# Setup

Two part setup before confirmation

## PlateCanPark

Request

```http

POST /v10/permit/PlateCanPark HTTP/1.1
Host: api.mobile-parking.eu
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0
Accept: application/json, text/plain, */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br, zstd
Access-Control-Allow-Origin: *
Content-Type: application/json
Content-Length: 109
Origin: https://online.mobilparkering.dk
Connection: keep-alive
Referer: https://online.mobilparkering.dk/
Sec-Fetch-Dest: empty
Sec-Fetch-Mode: cors
Sec-Fetch-Site: cross-site
DNT: 1
Sec-GPC: 1
Priority: u=0

{"licensePlate":"CX57383","Uid":"12cdf204-d969-469a-9bd5-c1f1fc59ee34","phoneNumber":"4542303145","email":""}
```

```js
await fetch("https://api.mobile-parking.eu/v10/permit/PlateCanPark", {
    "credentials": "omit",
    "headers": {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0",
        "Accept": "application/json, text/plain, */*",
        "Accept-Language": "en-US,en;q=0.5",
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        "Sec-Fetch-Dest": "empty",
        "Sec-Fetch-Mode": "cors",
        "Sec-Fetch-Site": "cross-site",
        "Sec-GPC": "1",
        "Priority": "u=0"
    },
    "referrer": "https://online.mobilparkering.dk/",
    "body": "{\"licensePlate\":\"CX57383\",\"Uid\":\"12cdf204-d969-469a-9bd5-c1f1fc59ee34\",\"phoneNumber\":\"4542303145\",\"email\":\"\"}",
    "method": "POST",
    "mode": "cors"
});
```

Respone

```
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 07 Dec 2025 17:16:21 GMT
Server: Microsoft-IIS/10.0
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: https://online.mobilparkering.dk
Content-Encoding: gzip
Set-Cookie: ARRAffinity=2c3952fa297307b8bc5d28f2a66a9674f5873a101c076bc2c551edfb609c7745;Path=/;HttpOnly;Secure;Domain=api.mobile-parking.eu
ARRAffinitySameSite=2c3952fa297307b8bc5d28f2a66a9674f5873a101c076bc2c551edfb609c7745;Path=/;HttpOnly;SameSite=None;Secure;Domain=api.mobile-parking.eu
Transfer-Encoding: chunked
Vary: Origin,Accept-Encoding
Request-Context: appId=cid-v1:b702659f-76da-4134-8b14-903540e7fc03
X-Powered-By: ASP.NET

"Plate can park"
```

## Tablet
Set up part two

Request

```
POST /v10/permit/Tablet HTTP/1.1
Host: api.mobile-parking.eu
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0
Accept: application/json, text/plain, */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br, zstd
Access-Control-Allow-Origin: *
Content-Type: application/json
Content-Length: 145
Origin: https://online.mobilparkering.dk
Connection: keep-alive
Referer: https://online.mobilparkering.dk/
Sec-Fetch-Dest: empty
Sec-Fetch-Mode: cors
Sec-Fetch-Site: cross-site
DNT: 1
Sec-GPC: 1

{"licensePlate":"CX57383","Uid":"12cdf204-d969-469a-9bd5-c1f1fc59ee34","phoneNumber":"4542303145","email":"","delayedDate":"","delayedDateTo":""}
```

```js
await fetch("https://api.mobile-parking.eu/v10/permit/PlateCanPark", {
    "credentials": "omit",
    "headers": {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0",
        "Accept": "application/json, text/plain, */*",
        "Accept-Language": "en-US,en;q=0.5",
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        "Sec-Fetch-Dest": "empty",
        "Sec-Fetch-Mode": "cors",
        "Sec-Fetch-Site": "cross-site",
        "Sec-GPC": "1",
        "Priority": "u=0"
    },
    "referrer": "https://online.mobilparkering.dk/",
    "body": "{\"licensePlate\":\"CX57383\",\"Uid\":\"12cdf204-d969-469a-9bd5-c1f1fc59ee34\",\"phoneNumber\":\"4542303145\",\"email\":\"\"}",
    "method": "POST",
    "mode": "cors"
});
```

```
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 07 Dec 2025 17:16:22 GMT
Server: Microsoft-IIS/10.0
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: https://online.mobilparkering.dk
Content-Encoding: gzip
Set-Cookie: ARRAffinity=2c3952fa297307b8bc5d28f2a66a9674f5873a101c076bc2c551edfb609c7745;Path=/;HttpOnly;Secure;Domain=api.mobile-parking.eu
ARRAffinitySameSite=2c3952fa297307b8bc5d28f2a66a9674f5873a101c076bc2c551edfb609c7745;Path=/;HttpOnly;SameSite=None;Secure;Domain=api.mobile-parking.eu
Transfer-Encoding: chunked
Vary: Origin,Accept-Encoding
Request-Context: appId=cid-v1:b702659f-76da-4134-8b14-903540e7fc03
X-Powered-By: ASP.NET

{"Email":"","Title":"Aalborg Universitet - Tilladelsen gælder i 10 timer på område 4688.","Description":".","PhoneNumber":"4542303145","VehicleRegistrationCountry":"DK","Duration":600,"VehicleRegistration":"CX57383","ParkingAreas":[{"Id":0,"DiscountId":0,"ParkingAreaId":1956,"ParkingAreaKey":"ADK-4688","Address":"Selma Lagerløfsvej 249","Added":"2025-12-07T18:16:22.4776628+01:00","Removed":null}],"StartTime":"2025-12-07T17:16:22.4983286+00:00","EndTime":"2025-12-08T03:16:22.4983286+00:00","UId":"12cdf204-d969-469a-9bd5-c1f1fc59ee34","Lang":""}
```

This response is similar to an initial `info` request send before displaying the form.

# Confirmation

```
POST /v10/permit/Tablet/confirm HTTP/1.1
Host: api.mobile-parking.eu
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0
Accept: application/json, text/plain, */*
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate, br, zstd
Access-Control-Allow-Origin: *
Content-Type: application/json
Content-Length: 456
Origin: https://online.mobilparkering.dk
Connection: keep-alive
Referer: https://online.mobilparkering.dk/
Sec-Fetch-Dest: empty
Sec-Fetch-Mode: cors
Sec-Fetch-Site: cross-site
DNT: 1
Sec-GPC: 1
Priority: u=0

{"email":"","PhoneNumber":"4542303145","VehicleRegistrationCountry":"DK","Duration":600,"VehicleRegistration":"CX57383","parkingAreas":[{"Id":0,"DiscountId":0,"ParkingAreaId":1956,"ParkingAreaKey":"ADK-4688","Address":"Selma Lagerløfsvej 249","Added":"2025-12-07T18:16:22.4776628+01:00","Removed":null}],"StartTime":"2025-12-07T17:16:22.4983286+00:00","EndTime":"2025-12-08T03:16:22.4983286+00:00","UId":"12cdf204-d969-469a-9bd5-c1f1fc59ee34","Lang":"da"}
```

```
await fetch("https://api.mobile-parking.eu/v10/permit/Tablet/confirm", {
    "credentials": "omit",
    "headers": {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:144.0) Gecko/20100101 Firefox/144.0",
        "Accept": "application/json, text/plain, */*",
        "Accept-Language": "en-US,en;q=0.5",
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
        "Sec-Fetch-Dest": "empty",
        "Sec-Fetch-Mode": "cors",
        "Sec-Fetch-Site": "cross-site",
        "Sec-GPC": "1",
        "Priority": "u=0"
    },
    "referrer": "https://online.mobilparkering.dk/",
    "body": "{\"email\":\"\",\"PhoneNumber\":\"4542303145\",\"VehicleRegistrationCountry\":\"DK\",\"Duration\":600,\"VehicleRegistration\":\"CX57383\",\"parkingAreas\":[{\"Id\":0,\"DiscountId\":0,\"ParkingAreaId\":1956,\"ParkingAreaKey\":\"ADK-4688\",\"Address\":\"Selma Lagerløfsvej 249\",\"Added\":\"2025-12-07T18:16:22.4776628+01:00\",\"Removed\":null}],\"StartTime\":\"2025-12-07T17:16:22.4983286+00:00\",\"EndTime\":\"2025-12-08T03:16:22.4983286+00:00\",\"UId\":\"12cdf204-d969-469a-9bd5-c1f1fc59ee34\",\"Lang\":\"da\"}",
    "method": "POST",
    "mode": "cors"
});
```

```
HTTP/1.1 200 OK
Content-Type: application/json
Date: Sun, 07 Dec 2025 17:16:51 GMT
Server: Microsoft-IIS/10.0
Access-Control-Allow-Credentials: true
Access-Control-Allow-Origin: https://online.mobilparkering.dk
Content-Encoding: gzip
Set-Cookie: ARRAffinity=2c3952fa297307b8bc5d28f2a66a9674f5873a101c076bc2c551edfb609c7745;Path=/;HttpOnly;Secure;Domain=api.mobile-parking.eu
ARRAffinitySameSite=2c3952fa297307b8bc5d28f2a66a9674f5873a101c076bc2c551edfb609c7745;Path=/;HttpOnly;SameSite=None;Secure;Domain=api.mobile-parking.eu
Transfer-Encoding: chunked
Vary: Origin,Accept-Encoding
Request-Context: appId=cid-v1:b702659f-76da-4134-8b14-903540e7fc03
X-Powered-By: ASP.NET

{"id":"10a000ea-6990-4eda-bca9-f9b46bb5a190","parkingAreas":[{"key":"ADK-4688","providerKey":"ADK","number":"4688","address":{"Name":null,"Line":"Selma Lagerløfsvej 249","Line2":null,"PostalCode":"9200","City":"Aalborg SV","Region":null,"CountryCode":"DK"},"name":"","description":null,"timezoneId":"Central European Standard Time"}],"vehicleRegistration":{"typed":"CX57383","trimmed":"CX57383","country":"DK","key":"DK-CX57383"},"created":{"dateTime":"2025-12-07T17:16:52.0385465Z","epoch":1765127812},"validFrom":{"dateTime":"2025-12-07T17:16:22.4983286Z","epoch":1765127782},"validTo":{"dateTime":"2025-12-08T03:16:52.0368176Z","epoch":1765163812},"metadata":{"TabletDiscountUID":"12cdf204-d969-469a-9bd5-c1f1fc59ee34","OrganisationUID":"9237e0a7-1f13-40ca-b873-cbb29b20d0f4","startedTime":{"dateTime":"2025-12-07T17:16:52.0421936Z","epoch":1765127812}},"archived":false,"anonymized":false,"number":{"stringValue":"18a3t6","longValue":74374602},"parkingType":3,"parkingState":1,"customerInfo":{"id":null,"email":"","quickUser":false,"allowContact":false},"invalidReason":{},"timeLimits":{}}
```
