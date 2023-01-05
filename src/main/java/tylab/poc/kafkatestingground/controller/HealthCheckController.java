package tylab.poc.kafkatestingground.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api/v1/health")
public class HealthCheckController {

    @GetMapping(value = "/ping")
    @ResponseBody
    public String pingRequest() {
        return "success";
    }
}
