interface ConfirmResponseBody {
  email: string;
  PhoneNumber: string;
  VehicleRegistrationCountry: string;
  Duration: number;
  VehicleRegistration: string;
  parkingAreas: [
    {
      Id: number;
      DiscountId: number;
      ParkingAreaId: number;
      ParkingAreaKey: string;
      Address: string;
      Added: string;
      Removed: null;
    },
  ];
  StartTime: string;
  EndTime: string;
  UId: string;
  Lang: string;
}

const plateRequest = {
  licensePlate: "CX57383",
  Uid: "12cdf204-d969-469a-9bd5-c1f1fc59ee34",
  phoneNumber: "4542303145",
  email: "",
};

const plateResponse = "Plate can park";

const tabletRequest = {
  licensePlate: "CX57383",
  Uid: "12cdf204-d969-469a-9bd5-c1f1fc59ee34",
  phoneNumber: "4542303145",
  email: "",
  delayedDate: "",
  delayedDateTo: "",
};

const tabletResponse = {
  Email: "",
  Title: "Aalborg Universitet - Tilladelsen gælder i 10 timer på område 4688.",
  Description: ".",
  PhoneNumber: "4542303145",
  VehicleRegistrationCountry: "DK",
  Duration: 600,
  VehicleRegistration: "CX57383",
  ParkingAreas: [
    {
      Id: 0,
      DiscountId: 0,
      ParkingAreaId: 1956,
      ParkingAreaKey: "ADK-4688",
      Address: "Selma Lagerløfsvej 249",
      Added: "2025-12-07T18:16:22.4776628+01:00",
      Removed: null,
    },
  ],
  StartTime: "2025-12-07T17:16:22.4983286+00:00",
  EndTime: "2025-12-08T03:16:22.4983286+00:00",
  UId: "12cdf204-d969-469a-9bd5-c1f1fc59ee34",
  Lang: "",
};

const confirmParking = async () => {
  let body: ConfirmResponseBody = {
    email: "",
    PhoneNumber: "4542303145",
    VehicleRegistrationCountry: "DK",
    Duration: 600,
    VehicleRegistration: "CX57383",
    parkingAreas: [
      {
        Id: 0,
        DiscountId: 0,
        ParkingAreaId: 1956,
        ParkingAreaKey: "ADK-4688",
        Address: "Selma Lagerløfsvej 249",
        Added: "2025-12-07T18:16:22.4776628+01:00",
        Removed: null,
      },
    ],
    StartTime: "2025-12-07T17:16:22.4983286+00:00",
    EndTime: "2025-12-08T03:16:22.4983286+00:00",
    UId: "12cdf204-d969-469a-9bd5-c1f1fc59ee34",
    Lang: "da",
  };

  const deltaEpoch = 10 * 60 * 60 * 1000; // 10 hours
  const currentEpoch = Date.now();
  const currentTime = new Date(currentEpoch);
  const endTime = new Date(currentEpoch + deltaEpoch);

  body.StartTime = currentTime.toISOString();
  body.EndTime = endTime.toISOString();

  // testing changes
  // body.VehicleRegistration = "CX57384";

  const response = await fetch(
    "https://api.mobile-parking.eu/v10/permit/Tablet/confirm",
    {
      credentials: "omit",
      headers: {
        "Content-Type": "application/json",
      },
      referrer: "https://online.mobilparkering.dk/",
      body: JSON.stringify(body),
      method: "POST",
      mode: "cors",
    },
  );

  return response;
};

const main = async () => {
  console.log("Sending Confirmation");
  const res = await confirmParking();
  console.log(res);
};

main();
