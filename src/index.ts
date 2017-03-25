const elm = require("./elm/Main.elm");
const flag = {
  cinemaScheduleFlag: {
    time: (new Date).getTime()
  }
};
const app = elm.Main.fullscreen(flag);
