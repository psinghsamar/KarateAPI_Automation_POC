package runners;

import com.intuit.karate.junit5.Karate;

class ApiRunner {
	@Karate.Test
	Karate testAll() {
		return Karate.run().relativeTo(getClass());
	}
}

