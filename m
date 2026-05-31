Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620B1D63E4
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205824; cv=none; b=OkwKgGm5tXMDTrjYqk3ZSRwpmSkKeMq8FtsifU/QBT/ZvhiP4JUK0fgy6NYApbeivfO1XhCT/WBUy4yqYW7w7FzS1dQN8Nt1JV3I0apVa/5H54ihqWT7s0wcn8kdSqvOTp52U5kHsqcvMVn0qyatkynVo1nv97sMNTSr/H3Brfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205824; c=relaxed/simple;
	bh=Z8PcpJADc4GMhZ1Wk13fxrISCvAmJxMWlTzxp/YVQts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7Ej/WoAS00gEZWfUWD/QxqH/oLitoUte4uxACO2s0mY0em0PcOnuT7OjjGMgJf2BLbjHUAoXqgYuHwNnDc2KrftbnwetHhlqWCNIQgwhYx7lLKc9s+3vaynYidS+ms2szzmvcxiqK6Tn8IBflPptd6vvlWmLbVJYwPrHJ0KpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LteI7PpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LteI7PpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9E51F00893;
	Sun, 31 May 2026 05:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780205823;
	bh=3JmFg3cZHbwgl7zH0kp9NMvFwWVzrHhmYJ41dYIHX9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LteI7PpBtolXnpC7HCU7hi0AzyzLpCDVKQct6sFhKIWdB/2Jvj3522r1F6jJT4Ovr
	 qm97qaEoLgJwqTXvkEC7t0VqiL6VkLyPk4XescpgydJjvUiq4VwnzR0GyZ97wO+l6x
	 PNUFV6EUY4sncQSN3GgDhXeeOkRg0YqrezqmrbsBS/dBkQuIYsT12jA+yjBDJ5Fg3J
	 13SH/HQPZV8UKmHrPfvHjtnOkz89erM5wUt/5XvBB3MwkWpnnnc3mgApYsVdwKrCk8
	 tcvDyJjVWVZNO1qDMieCz2di4qICKsZKLh7N3mLALLv0WPSTMK4GxY/r1LQXAn7MuA
	 mXQTqfr/P57lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/14] perf test: Show snippet failure output for
 verbose=1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-8-irogers@google.com>
References: <20260531052740.796087-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:37:02 +0000
Message-Id: <20260531053702.CF9E51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Passing uncast characters to `tolower()` causes undefined behavi=
or and potential out-of-bounds reads for non-ASCII characters.
- [Medium] The extraction algorithm's implementation order violates the pri=
ority described in the commit message, causing execution boundary markers t=
o be discarded if failure keywords exhaust the line quota.
--

commit a2c183c6fc599017b8cecb4e8c338a3c845f8187
Author: Ian Rogers <irogers@google.com>

perf test: Show snippet failure output for verbose=3D1

Currently, when running tests in verbose mode (-v), if a test case fails,
the entire raw standard error buffer is dumped to stderr.
This patch implements a smart, bounded snippet string processor to improve
failure triaging by extracting keywords and test boundary markers.

>     2. Parse the raw error buffer dynamically into lines and run a three-=
pass
>        extraction algorithm:
>        - Pass 0: Prioritize retaining outline marker lines containing das=
hes
>          (=3D=3D=3D=3D) to beautifully frame the start and end execution =
boundaries.
>        - Pass 1: Scan forward from the top of the log to pick up to N lin=
es
>          that contain case-insensitive failure keywords (error, fail, seg=
v,

[Severity: Medium]
The commit message states that outline marker lines "=3D=3D=3D=3D" are prio=
ritized as
Pass 0. However, the implementation processes failure keywords first as Pas=
s 1
and then searches for "----" as Pass 2.

[ ... ]

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 87c6a67beb10e..ec44b24d419c1 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -395,6 +397,207 @@ static int print_test_result(struct test_suite *t, =
int curr_suite, int curr_test
>  	return 0;
>  }
> =20
> +static const char * const fail_keywords[] =3D {
> +	"error", "fail", "segv", "abort",
> +	"signal", "fatal", "panic", "corrupt", NULL
> +};
> +
> +static const char *find_next_keyword(const char *str, size_t max_len, si=
ze_t *kw_len)
> +{
> +	const char *best =3D NULL;
> +	size_t best_len =3D 0;
> +	int k;
> +
> +	for (k =3D 0; fail_keywords[k]; k++) {
> +		const char *s =3D str;
> +		size_t len =3D strlen(fail_keywords[k]);
> +
> +		while ((size_t)(s - str) + len <=3D max_len) {
> +			size_t i;
> +
> +			for (i =3D 0; i < len; i++) {
> +				if (tolower(s[i]) !=3D fail_keywords[k][i])

[Severity: Medium]
Since s is a const char *, s[i] can be negative if it's a non-ASCII charact=
er.
Passing negative values to tolower() can trigger undefined behavior or
out-of-bounds array reads in glibc implementations.

Should s[i] be cast to unsigned char before being passed to tolower()?

> +					break;
> +			}
> +			if (i =3D=3D len) {
> +				if (!best || s < best) {

[ ... ]

> +static void print_test_failure_snippet(FILE *fp, const char *buf)
> +{

[ ... ]

> +	/* Pass 1: Pick lines with failure keywords from start (Highest Priorit=
y) */
> +	for (i =3D 0; i < num_lines && picked_count < failure_snippet_lines; i+=
+) {
> +		size_t dummy;
> +
> +		if (find_next_keyword(lines[i], line_lens[i], &dummy)) {
> +			if (!pick[i]) {
> +				pick[i] =3D true;
> +				picked_count++;
> +			}
> +			/* Prioritize getting the immediate next line for context */
> +			if (i + 1 < num_lines && !pick[i + 1] &&
> +			    picked_count < failure_snippet_lines) {
> +				pick[i + 1] =3D true;
> +				picked_count++;
> +			}
> +		}
> +	}
> +
> +	/* Pass 2: Pick marker lines up to the remaining quota */
> +	for (i =3D 0; i < num_lines && picked_count < failure_snippet_lines; i+=
+) {
> +		if (!pick[i] && line_contains(lines[i], line_lens[i], "----")) {

[Severity: Medium]
The extraction algorithm's implementation order differs from the priority
described in the commit message.

Because failure keywords are processed here as Pass 1, if a failure log is
highly verbose and contains enough failure keywords to hit the
failure_snippet_lines limit (default 10) in Pass 1, will the execution boun=
dary
markers be silently discarded in Pass 2?

Additionally, this code matches "----" rather than the "=3D=3D=3D=3D" descr=
ibed in
the commit message.

> +			pick[i] =3D true;
> +			picked_count++;
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D7
