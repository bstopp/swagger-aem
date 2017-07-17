package com.github.bstopp.swagger.service.impl;

import com.github.bstopp.swagger.service.TestService;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.ConfigurationPolicy;
import org.osgi.service.metatype.annotations.Designate;
import org.osgi.service.metatype.annotations.ObjectClassDefinition;

/**
 * Created by bryan on 7/15/17.
 */
@Component(
        service = { TestService.class },
        configurationPolicy = ConfigurationPolicy.REQUIRE
)
@Designate(ocd = TestServiceImpl.Config.class)
public class TestServiceImpl implements TestService {

    @ObjectClassDefinition(
            name = "Swagger Test Service Config",
            description = "Configuration for the swagger client test service."
    )
    @interface
    Config {

    }

    @Override
    public String helloWorld() {
        return null;
    }

}
