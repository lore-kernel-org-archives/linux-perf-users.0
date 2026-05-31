Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC042FD1DA
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206209; cv=none; b=SofmlLbIJq/Hygv1VR5WuU+Vy9zgqCLWOtdzXAxzVdZRGLkcACys5PzquY1mOnUh0VRO7s/9+paGFXiTno4wzlwkn/8rulYeOCG6PgqpnFgnI1r+kPWtDWgD45DMCd9RIC0VtRIBIhEtfBjFa6ujvpJuOsu0hTz+PBdJNCr4LGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206209; c=relaxed/simple;
	bh=I7vJKyq1vTp6ZEX8ibXhxbc40OgNh0P/Q6ebN42/T8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nU4TfLaHMannPQYD3MRZIfl6IATM258HdYiIxjNCT4A08Wvzq9NGzHsv7AWLbx+qOY/eBNTUIdrp6FQdDCevIYnhtUahMR+6yyo2DtNZkNzujYLzbIrx+9HsTBioIJQk1STVylQz1ecidxNAmgPo2kw9ZE5sgigbOrDRD4vqVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjerEHwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjerEHwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072E41F00893;
	Sun, 31 May 2026 05:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780206208;
	bh=SWsKUiZxzL5VV7dyeQehj0MzE0WkknJKFC3ZzYF1MyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjerEHwiqtWbnIkA1l18Qz+u2PhrW86ZoBOOuicP3donKOXctIEwD8q85GKSpumzH
	 J1sEF6YQLIQ0Hw4CEVclkZu5GSFYfkHQcFqfU/uqEsJqh9ashzQflcmAy72cgUqX37
	 c/AJMf9T93SHWSX7p8rckpf0xJw9YadPdBu0/sqWVQjIJp/RZ+JcA72PJRoonDl9ji
	 m/+qnu2hQLoTvkJyqWIhv+cVKUd7uHvabyupWpLFt105uf5hH5LufrTpJut/IdBQFQ
	 EU1L6YL20dLDtIh6CNJae23aqdXxc+jh1W8v6cm2R1gzHbd0+1rPvZWUz2dCeYp/lO
	 A0pu3HIzxgvYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/14] perf test: Add -j/--junit option for JUnit XML
 test reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-13-irogers@google.com>
References: <20260531052740.796087-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:43:27 +0000
Message-Id: <20260531054328.072E41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Tests failing with arbitrary error codes or signals are logged a=
s PASSED in the generated JUnit XML report.
- [Medium] `xml_escape` silently drops UTF-8 and extended ASCII characters =
on architectures where `char` is signed.
--

commit 85c89b056c0810130f9d5935a708601da2cc88ff
Author: Ian Rogers <irogers@google.com>

perf test: Add -j/--junit option for JUnit XML test reports

Add a -j/--junit command line option to generate standard JUnit XML format
test reports. The XML report captures individual test suite and subtest
execution latency alongside XML-escaped failure logs and skip reasons.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index fb4dffacf4068..38697243f33ad 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -367,8 +373,34 @@ static unsigned int summary_tests_skipped;
>  static unsigned int summary_tests_failed;
>  static struct strbuf summary_failed_tests_buf =3D STRBUF_INIT;
> =20
> +static char *xml_escape(const char *str)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	const char *p;
> +	char *res;
> +
> +	if (!str)
> +		return strdup("");
> +
> +	for (p =3D str; *p; p++) {
> +		if (*p =3D=3D '&')
> +			strbuf_addstr(&buf, "&amp;");
> +		else if (*p =3D=3D '<')
> +			strbuf_addstr(&buf, "&lt;");
> +		else if (*p =3D=3D '>')
> +			strbuf_addstr(&buf, "&gt;");
> +		else if (*p =3D=3D '"')
> +			strbuf_addstr(&buf, "&quot;");
> +		else if (*p >=3D 32 || *p =3D=3D '\n' || *p =3D=3D '\t')

[Severity: Medium]
Since char is signed on architectures like x86, will characters with the
high bit set (such as UTF-8 sequences) evaluate as negative values?=20

It looks like they would fail the *p >=3D 32 check and be silently dropped =
from
the XML output. Could *p be cast to an unsigned char for this comparison?

> +			strbuf_addch(&buf, *p);
> +	}
> +	res =3D strbuf_detach(&buf, NULL);
> +	return res ? res : strdup("");
> +}

[ ... ]

> @@ -416,6 +448,34 @@ static int print_test_result(struct test_suite *t, i=
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

[Severity: Medium]
Will this strict check for TEST_FAIL miss tests that fail with other negati=
ve
POSIX error codes like -ENOMEM?=20

The switch statement above this code falls through to default: for any
unrecognized error code, treating them as failures for the terminal output.
However, if a test returns a different error code, the <failure> element
would be omitted here, potentially causing CI systems and JUnit parsers to
report a broken test as passed.

> +			strbuf_addf(&junit_xml_buf,
> +				    "      <failure message=3D\"FAILED\">\n%s\n      </failure>\n",
> +				    escaped_err);
> +		} else if (result =3D=3D TEST_SKIP) {
> +			const char *reason =3D skip_reason(t, curr_test_case);
> +			char *escaped_reason =3D xml_escape(reason ? reason : "Skip");
> +
> +			strbuf_addf(&junit_xml_buf, "      <skipped message=3D\"%s\"/>\n",
> +				    escaped_reason);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D12
