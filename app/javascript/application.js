import "@hotwired/turbo";
import { Application } from "@hotwired/stimulus";
import HelloController from "./controllers/hello_controller.js";
import TaskController from "./controllers/task_controller.js";

const application = Application.start();

application.register("hello", HelloController);
application.register("task", TaskController);
