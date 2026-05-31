Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA03264D8
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780216920; cv=none; b=YOhGjLzNeF2R7/8FVVw++2wKEz55llT9UY23goIM/yramvBe9bAMBPTedDeEURREMa79vQTDjtNOJiziCbhizuTPiHjJC/BM9le4KQhbVi+ahtdy9ebrBHFg/LtrUYlmS6Ig1nKG9S3Y0owEaP/OVC0d1aN7ud28FsUkhRHe3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780216920; c=relaxed/simple;
	bh=u3TmLk2EJ5pqoHQ7ebvoUsp0KjSq8D7OYow9m65JS+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A77d+IfUqx3tc2iqRwrHuw/ZtvWtLAzhMTsR6Qzl3a6HsS/xI38Bh5BW6zf/uAPMoXXg+VzRcBab7g+WT+uSFCxTn7Qwm2FZMYzxcKEnhe45CwZJRH1y4kpizS+qjdZenHGt9+L+7rQKk6NnuIkZpGc8x20SNtyreS3HGDyruPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqXWWEHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqXWWEHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361151F00893;
	Sun, 31 May 2026 08:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780216919;
	bh=ZnIiqqJeDuhSUivcldIb4lYxawvoqmDqPM9VnUM6hco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqXWWEHkcO+DZHxXqwhE5gHPgikBkWwf28v1zR1essY4pUCWB3as6KF1gFUB4NY/W
	 x1U+hHN9/ge5X3FC/BsvP6DQcKOaWxD7ZXEpCRHtW7qVZQXhtpnZItayjd9ZbwvYyk
	 nSfRfynRyT5GoApNa0v5B6BsaLGIMRWZ10MpKSERHop+1KeIBUMJcZ82MjlLIbRYrW
	 hBikhAnl+EtQ4NHxLMIPo/G5NznEFsgZMFzp+xJcDfE0GyPpa3rrS5QjY1qmlw2VxO
	 bB+jTPwwly01Coe1T3cNECdGcYEShijniS7rvp6A+Z0fc+TzGrOpNRHkiZl6A7gNik
	 lBs3ib64cpUUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/15] perf test: Add -j/--junit option for JUnit XML
 test reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531082235.940833-14-irogers@google.com>
References: <20260531082235.940833-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 08:41:58 +0000
Message-Id: <20260531084159.361151F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Crashed or abnormally exiting tests are reported as successful i=
n the JUnit XML report.
--

commit 97a61309aed955d3a130fc7d4fb58abfdb0d12f1
Author: Ian Rogers <irogers@google.com>

perf test: Add -j/--junit option for JUnit XML test reports

This commit adds a -j/--junit command line option to generate standard
JUnit XML test reports. The XML report captures individual test suite
and subtest execution latency, alongside failure logs and skip reasons.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -418,6 +450,34 @@ static int print_test_result(struct test_suite *t, i=
nt curr_suite, int curr_test
[ ... ]
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
Will tests that crash or time out be incorrectly reported as successful
in the XML?

When a test terminates abnormally (e.g., due to a signal like SIGSEGV or
a timeout), execution monitors like finish_command() can return other negat=
ive
error codes (such as -11) instead of exactly TEST_FAIL (-1).

Since this strict equality check bypasses the <failure> block for those
other negative codes, it seems an empty <testcase> tag will be generated,
which standard JUnit CI parsers interpret as a passing test.

Should this check account for other negative return values, perhaps using
if (result !=3D TEST_OK && result !=3D TEST_SKIP), to ensure crashes are=20
properly recorded as failures?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531082235.9408=
33-1-irogers@google.com?part=3D13
