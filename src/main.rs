//! # Apcoabot
//!
//! A simple rust program authorizing vehicles for parking at apcoa-controlled parking lots. Simply
//! pass apcoabot your phone and registration number, and it will automatically register you for 10
//! hours of parking at a selection of pre-implemented parking lots.
//!
//! ```sh
//! apcoabot -r <your registration number> -p <your phone number>
//! ```
//!
//! These are the currently supported parking lots:
//!
//! | Address                | Name       |
//! | Selma Lagerløfsvej 249 | Cassiopeia |

use anyhow::Result;
use clap::Parser;
use log::{debug, error, info};
use reqwest::Client;
use serde::Serialize;
use std::time::{Duration, SystemTime};

/// Command-line arguments for parking-cli
#[derive(Parser, Debug)]
#[command(name = "apcoabot-cli", about = "Sends a parking request")]
struct Args {
    /// Vehicle registration. Should correspond with the license plate of the vehicle you intend to
    /// park.
    #[arg(short = 'r', long = "registration")]
    registration: String,

    /// Phone number to send confirmation to. Should include county code but no '+'. Fx 45<your
    /// number> for denmark
    #[arg(short = 'p', long = "phonenumber")]
    phone_number: String,

    /// Dry run. Performs all actinos up to but excluding sending the confirmation request
    #[arg(long = "dry-run")]
    dry_run: bool,
}

#[derive(Serialize)]
struct ParkingArea {
    #[serde(rename = "Id")]
    id: u32,
    #[serde(rename = "DiscountId")]
    discount_id: u32,
    #[serde(rename = "ParkingAreaId")]
    parking_area_id: u32,
    #[serde(rename = "ParkingAreaKey")]
    parking_area_key: String,
    #[serde(rename = "Address")]
    address: String,
    #[serde(rename = "Added")]
    added: String,
    #[serde(rename = "Removed")]
    removed: Option<String>,
}

#[derive(Serialize)]
struct ConfirmRequestBody {
    #[serde(rename = "email")]
    email: String,

    #[serde(rename = "PhoneNumber")]
    phone_number: String,

    #[serde(rename = "VehicleRegistrationCountry")]
    vehicle_registration_country: String,

    #[serde(rename = "Duration")]
    duration: u32,

    #[serde(rename = "VehicleRegistration")]
    vehicle_registration: String,

    #[serde(rename = "parkingAreas")]
    parking_areas: Vec<ParkingArea>,

    #[serde(rename = "StartTime")]
    start_time: String,

    #[serde(rename = "EndTime")]
    end_time: String,

    #[serde(rename = "UId")]
    uid: String,

    #[serde(rename = "Lang")]
    lang: String,
}

/// I have no idea what this UUID is, but it is required and works.
/// It also seems to be static for Casiopeia across visits.
const UUID: &str = "12cdf204-d969-469a-9bd5-c1f1fc59ee34";

const CONFIRM_URI: &str = "https://api.mobile-parking.eu/v10/permit/Tablet/confirm";
const CONFIRM_REFERER: &str = "https://online.mobilparkering.dk/";

/// Parking at Casiopeia lasts 10 hours
/// TODO: Test if this can be changed
const CASSIOPEIA_DURATION: u32 = 600;
const CASSIOPEIA_AREA_ID: u32 = 1956;
const CASSIOPEIA_AREA_KEY: &str = "ADK-4688";
const CASSIOPEIA_ADDRESS: &str = "Selma Lagerløfsvej 249";

#[tokio::main]
async fn main() -> Result<()> {
    env_logger::init();

    // Parse CLI args
    let args = Args::parse();

    info!(
        "Running apcoabot-cli {}",
        if args.dry_run { "in dry-run mode" } else { "" }
    );
    debug!("registration = {}", args.registration);
    debug!("phone_number = +{}", args.phone_number);

    // Compute timestamps
    let now = SystemTime::now();
    let end = now + Duration::from_secs(10 * 60 * 60);

    let start_iso = chrono::DateTime::<chrono::Utc>::from(now).to_rfc3339();
    let end_iso = chrono::DateTime::<chrono::Utc>::from(end).to_rfc3339();

    // Build request body
    let body = ConfirmRequestBody {
        email: "".into(),
        phone_number: args.phone_number,
        vehicle_registration_country: "DK".into(),
        duration: CASSIOPEIA_DURATION,
        vehicle_registration: args.registration,
        parking_areas: vec![ParkingArea {
            id: 0,
            discount_id: 0,
            parking_area_id: CASSIOPEIA_AREA_ID,
            parking_area_key: CASSIOPEIA_AREA_KEY.into(),
            address: CASSIOPEIA_ADDRESS.into(),
            added: start_iso.clone(),
            removed: None,
        }],
        start_time: start_iso,
        end_time: end_iso,
        uid: UUID.into(),
        lang: "da".into(),
    };

    let client = Client::new();
    let request = client
        .post(CONFIRM_URI)
        .header("Content-Type", "application/json")
        .header("Referrer", CONFIRM_REFERER)
        .json(&body)
        .build()?;
    debug!("request = {:?}", request);

    if args.dry_run {
        info!("Dry run complete");
        return Ok(());
    }

    info!("sending confirmation request");
    let response = client.execute(request).await;

    match response {
        Ok(response) => {
            info!("Request completed with status: {}", response.status());
            let response_body = response.text().await?;
            println!("Response: {:?}", response_body);
            Ok(())
        }
        Err(e) => {
            error!("Error during request: {}", e);
            Err(e.into())
        }
    }
}
