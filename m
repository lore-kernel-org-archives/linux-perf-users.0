Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F7B29D26E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295630; cv=none; b=pW2v2YntHGo/utOJWTkL2/iDe7I+7NpWMgcHMCgy7exSycSx97fb6B9xD7d3dTCKvgysCAZ8cZ+Ci+QiyD75A60Ygjzyhi1cyWzn2vBsrr7ucJOhJzsrZfOMRPerhqw8fK16j9YkBnbpqp+mK/PVFeUIl9e9gUsDZREADd7jvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295630; c=relaxed/simple;
	bh=4iypRvHuOHEjgLgh8MLGVY7g2REhQ5GBRmInKfOdHyw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzl8h72jMADhAVer4sd2IbTmcamAVNHastyvYyeiQf6MPa/cUJmzIpM5/SbAox8CyF953qtMr7Ig3BjKiXHmN1BW4NVL3H8yDghvE5ucscB7ztfU3HkxsSsFzKwm02Q3cD+pEGBrNKb2oA3cN5C2UhzmTgJ1t5BSlC7DOf2//OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElH+uhzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElH+uhzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568B01F00893;
	Mon,  1 Jun 2026 06:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295629;
	bh=zMO1myzGFazJI6dGIABrGYxF6rWrkIpuC0/cir+ndvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElH+uhzuWKXXmff5nlX+rMJq7E+Ng55dyR5pCAx4oiXKfeqJ0cpOVeWh4npvfxzYp
	 4q+uAC7BjlIlJh51iWKOKfkey5B0L7h0nTXtIfRIHk84dvYjmwVWHfp5WahOEXZOoK
	 l/fnmhKmgJOYNgbtF5BaCNaaYIa+QZQgO0mdDADgezY7cym8RrqqxMc66jhMR9d0qy
	 t/jZ00DqyYP1ymMDC6qxUHwnvW/7aWRemZIxZ39Alw43e1c5lv5Z+3MQlEWJgz9lQt
	 pKToUh2dioOuwRBc3R+El5PqjrfIpNfDNIs6hVcwk7huDu5wQzjzk4aD/3Zb1egW8A
	 FP4+5WYkI89Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] perf test: Add -j/--junit option for JUnit XML
 test reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-14-irogers@google.com>
References: <20260601061401.1541457-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:33:48 +0000
Message-Id: <20260601063349.568B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] JUnit XML incorrectly reports failed tests as passed if they retur=
n negative error codes other than TEST_FAIL (-1) or crash.
--

commit 0cfa01c83fa8f407962850a84df883fa8c3c4967
Author: Ian Rogers <irogers@google.com>

perf test: Add -j/--junit option for JUnit XML test reports

This commit adds a -j/--junit command-line option to generate standard
JUnit XML format test reports. The report captures test execution latency,
XML-escaped failure logs, and skip reasons while preserving the concurrency
of parallel test execution.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -421,6 +453,34 @@ static int print_test_result(struct test_suite *t, i=
nt curr_suite, int curr_test
>  		break;
>  	}
> =20
> +	if (junit_filename && result !=3D TEST_RUNNING) {
> +		const char *classname =3D t->desc;
> +		const char *testname =3D test_description(t, curr_test_case);
> +		char *escaped_err =3D xml_escape(err_output);
> +		char *escaped_class =3D xml_escape(classname);
> +		char *escaped_test =3D xml_escape(testname);
> +
> +		strbuf_addf(&junit_xml_buf,
> +			    "    <testcase classname=3D\"%s\" name=3D\"%s\" time=3D\"%.2f\">\=
n",
> +			    escaped_class, escaped_test, elapsed);
> +		if (result =3D=3D TEST_FAIL) {

[Severity: High]
Does this incorrectly report tests as passed if they return negative error
codes other than TEST_FAIL (-1) or crash?

In print_test_result(), any result that is not TEST_RUNNING, TEST_OK, or
TEST_SKIP correctly falls through to the default case in the earlier switch
statement and increments summary_tests_failed.

However, this XML generation block explicitly checks if result =3D=3D TEST_=
FAIL.
If a test crashes (returning a signal status) or returns another negative
error code like -ENOMEM, will the <testcase> element be closed without a
<failure> tag, causing CI systems to silently treat the failed test as
passed?

> +			strbuf_addf(&junit_xml_buf,
> +				    "      <failure message=3D\"FAILED\">\n%s\n      </failure>\n",
> +				    escaped_err);
> +		} else if (result =3D=3D TEST_SKIP) {
> +			const char *reason =3D skip_reason(t, curr_test_case);
> +			char *escaped_reason =3D xml_escape(reason ? reason : "Skip");
> +
> +			strbuf_addf(&junit_xml_buf, "      <skipped message=3D\"%s\"/>\n",
> +				    escaped_reason);
> +			free(escaped_reason);
> +		}
> +		strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
> +		free(escaped_err);
> +		free(escaped_class);
> +		free(escaped_test);
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D13
