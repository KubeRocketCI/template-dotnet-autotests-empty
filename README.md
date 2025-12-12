# .NET Autotest Project Template (KubeRocketCI)

This repository is a template for creating .NET API autotest components as part of the KubeRocketCI platform solution.

## Project Overview

- Designed for API contract and integration testing using .NET and xUnit/NUnit/MSTest.
- Intended for use in CI/CD deploy pipelines and local development.
- Template includes: `README.md`, `.gitignore`, `Makefile`.

## Quick Start with https://www.nuget.org/packages/RestAssured.Net

1. **Create a solution file (if not present):**

	```sh
	dotnet new sln -n dotnet-autotests
	```

2. **Create a test project (if not present):**

	```sh
	dotnet new xunit -n ApiContractTests -o ApiContractTests
	dotnet sln add ApiContractTests/ApiContractTests.csproj
	```
	_You can use `xunit`, `nunit`, or `mstest` as needed._

3. **Add required NuGet packages to your test project:**

	```sh
	dotnet add ApiContractTests/ApiContractTests.csproj package RestAssured.Net --version 4.10.0
	dotnet add ApiContractTests/ApiContractTests.csproj package NUnit --version 3.14.0
	dotnet add ApiContractTests/ApiContractTests.csproj package Microsoft.NET.Test.Sdk --version 17.9.0
	dotnet add ApiContractTests/ApiContractTests.csproj package NUnit3TestAdapter --version 4.5.0
	```
	_Add other dependencies as needed for your API testing._

4. **Add your tests** to the `ApiContractTests/Controllers/` directory. For example, create `ApiContractTests/Controllers/HelloControllerTests.cs`:

```csharp
using NUnit.Framework;
using static RestAssured.Dsl;
using NHamcrest;

namespace ApiContractTests.Controllers
{
	[TestFixture]
	public class HelloControllerTests
	{
		private const string BaseUrl = "https://restful-api-run0-team0-backend-dev.development.krci-dev.cloudmentor.academy";

		[Test]
		public void Hello_ShouldReturn200AndString()
		{
			Given()
			.When()
				.Get(BaseUrl + "/api/hello")
			.Then()
				.StatusCode(200)
				.And()
				.Body(NHamcrest.Is.Not(NHamcrest.Is.Null()));
		}
	}
}
```

5. **Restore dependencies:**

	```sh
	dotnet restore
	```

6. **Build the solution:**

	```sh
	dotnet build
	```

7. **Run tests locally:**

	```sh
	dotnet test
	```

## CI/CD Usage

- In CI/CD pipelines, the Makefile will call these .NET commands. If your test workflow requires different commands, update the Makefile accordingly to match your test setup.
- The `make` commands are used in deploy pipelines (see `Makefile`).
- `make e2e` will restore, build, and run all tests.

## Recommendations

- Use xUnit, NUnit, or MSTest for .NET API testing.
- Organize tests by endpoint/resource.
- Keep tests clear, maintainable, and aligned with your OpenAPI spec.
