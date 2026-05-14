Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A719D07E
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780939; cv=none; b=ZCpuw45lUyZFxot3NOAp1OGVJWtA70d/nN2UPUoXC41kjleWmjUPTQcLFUcA7DzrjrV2T5BUxDSErXFSTEcec5IynD0DqmGzeZ1AuwTog/eXaGIZN2AaijwN8cewsTaT6ZvPy4pl0dm0xkYljsJYjW/rnXWd7r5vDGBnNMvqLRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780939; c=relaxed/simple;
	bh=yUhmgSO/SEwckVlcFwSjFXc+j1Dz8DlxxoAbm2PPlVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjq/C195kAM0XJyi4oJfjjkx/yME+yUtfS/KeNf8I9vFdv908VMc/lgpbTzZ5CZOckulRPnoR4+/l4qOj/Hy9qzy7R4RIvQjtahRXCWOjgHEj26wQXMMwuDFIjAkyOmNn0l3BasQ9UHPRKRBFqjclUcZvDCUtkjHlzVq6/VMzic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2o+9+oG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2o+9+oG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9ECC2BCB3;
	Thu, 14 May 2026 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778780939;
	bh=yUhmgSO/SEwckVlcFwSjFXc+j1Dz8DlxxoAbm2PPlVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a2o+9+oGMd+zdelF8BC08yC8EPC8cy53PNE5VUyIjLoZTnKQCMS90AKe1YD7L2dSH
	 bj8atkZigKUu3+DGOobnG3Ke9CaWKGuVXn1TXJzaijkh/34FX341xAR8UnQ3JiSIVM
	 yCJ5UVF0E0oKWolKaLiAnqJLwGX+oS2Ca75N+dGfK9YPorsL6hBH+bAqu57kPz2o2f
	 Utc/ZsqiRNStPaoy3HD+r5iEEN4I9EEqf8d21/wgZlqxzy8Nh9ECzkMVKtecGuqux+
	 8Lon8/ABj4koIvzACK41KsNGM8xsbqOr7xBNq9OMrENPnUM2wr33i+9k2ihn6C9s8k
	 jbZlNeoIuJAcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/14] perf test: Add -j/--junit option for JUnit XML
 test reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513230450.529380-13-irogers@google.com>
References: <20260513230450.529380-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 17:48:58 +0000
Message-Id: <20260514174859.5F9ECC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] `xml_escape` silently discards all non-ASCII/UTF-8 characters du=
e to signed char comparison.
- [Medium] Test suites skipped via the '--skip' command-line option are omi=
tted from the JUnit XML, creating a structural mismatch.
- [Medium] Unsafe file creation for the JUnit XML report is vulnerable to a=
 symlink attack (Arbitrary File Overwrite).
- [Low] The globally scoped `junit_xml_buf` buffer is leaked if the test ha=
rness aborts on an error path.
--

commit f788260e3f8e93c92ba78c033616b340413eb066
Author: Ian Rogers <irogers@google.com>

perf test: Add -j/--junit option for JUnit XML test reports

This commit adds a -j/--junit command line option to perf test to generate
JUnit XML format test reports. The report captures execution latency, failu=
res,
and skip reasons.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 765724817776e..99f5afba10822 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
[ ... ]
> @@ -366,8 +372,34 @@ static unsigned int summary_tests_skipped;
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

On architectures where char is signed, will *p >=3D 32 evaluate to false for
non-ASCII characters (like UTF-8 sequences) since their most significant bit
is set?

Could this silently discard multi-byte characters from test logs, and should
the pointer value be cast to unsigned char before comparison to avoid this?

> +			strbuf_addch(&buf, *p);
> +	}
> +	res =3D strbuf_detach(&buf, NULL);
> +	return res ? res : strdup("");
> +}
[ ... ]
> @@ -999,6 +1078,29 @@ static void print_tests_summary(void)
>  	} else {
>  		color_fprintf(stderr, PERF_COLOR_GREEN, "Failed tests      : 0\n");
>  	}
> +
> +	if (junit_filename) {
> +		FILE *fp;
> +
> +		fp =3D fopen(junit_filename, "w");

If perf test -j is executed with elevated privileges in a shared directory =
like
/tmp, could fopen() with mode "w" be vulnerable to a symlink attack?

Would it be safer to use open() with O_CREAT | O_TRUNC | O_WRONLY | O_NOFOL=
LOW
to prevent arbitrarily overwriting system files?

> +		if (fp) {
> +			unsigned int total =3D summary_tests_passed + summary_subtests_passed=
 +
> +					     summary_tests_skipped + summary_tests_failed;
> +			fprintf(fp, "<?xml version=3D\"1.0\" encoding=3D\"utf-8\"?>\n");
> +			fprintf(fp, "<testsuites>\n");
> +			fprintf(fp, "  <testsuite name=3D\"perf-tests\" tests=3D\"%u\" failur=
es=3D\"%u\" skipped=3D\"%u\">\n",
> +				total, summary_tests_failed, summary_tests_skipped);

If a test suite is skipped via the user override (-s/--skip), __cmd_test()
increments summary_tests_skipped but skips calling print_test_result().

Will this cause a structural mismatch in the XML report between the reported
skipped count here and the actual number of <testcase> elements emitted?

> +			fprintf(fp, "%s", junit_xml_buf.buf);
> +			fprintf(fp, "  </testsuite>\n");
> +			fprintf(fp, "</testsuites>\n");
> +			fclose(fp);
> +			pr_info("Wrote junit XML output to %s\n", junit_filename);
> +		} else {
> +			pr_err("Failed to open %s for writing junit XML output: %s\n",
> +			       junit_filename, strerror(errno));
> +		}
> +	}
> +	strbuf_release(&junit_xml_buf);

If the test harness catches a signal (such as Ctrl-C) and jumps to the err_=
out
label in __cmd_test(), it bypasses print_tests_summary().

Could this cause junit_xml_buf to leak and trigger LeakSanitizer failures?

>  	strbuf_release(&summary_failed_tests_buf);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513230450.5293=
80-1-irogers@google.com?part=3D12
