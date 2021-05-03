import { CorsOptions } from "cors";

const whiteList = [
  "http://localhost:3000",
  "http://localhost:5000",
  "https://chat.abdou.dev",
  "https://studio.apollographql.com",
];

const corsOptions: CorsOptions = {
  origin: (origin, callback) => {
    if (origin && whiteList.indexOf(origin) !== -1) {
      callback(null, true);
    } else {
      console.log("REJECTED ORIGIN", origin);
      callback(new Error("Not allow by CORS"));
    }
  },
  credentials: true,
};

export default corsOptions;
