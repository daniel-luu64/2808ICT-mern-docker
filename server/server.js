const express = require("express")
const app = express()
const cors = require("cors")
require("dotenv").config()
const port = process.env.PORT || 5000
app.use(cors())
app.use(express.json())
app.use(require("./routes/record"))
const dbo = require("./db/conn")

app.get("/", function(req, res) {
    res.send("App is running")
})

app.get("/health",(req, res) => {
  res.status(200).json({ ok:true })
})

dbo.connectToMongoDB(function (error) {
    if (error) {
      console.error("MongoDB connection failed:", error.message);
      console.log("Starting server")
    }

    app.listen(port, "0.0.0.0", () => {
        console.log("Server is running on port: " + port)
    })
})
