Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B12FD1D0
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210033; cv=none; b=NObpTato58C5cQk8a3U4oosoahYQkEu7eHqluwkz8o7l+iSYfl6c+RDjK5QKvsztJ5PZ/ek7rexJ3j4FhgGjl6bjI4BWhJV3913CUR/cxCQlTH2HaLxwbpxnopL0GpBfJ30O5VlAHBXYKogRn6xt0odkvcy4BTPlaTH2PPa7fJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210033; c=relaxed/simple;
	bh=VkTKo3EuQRLQcl5SV/aIcl4ugsRLshTms0Zckb+gl+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gbiaCAlpB0JN13IqxFRaHIkKk9S4MM6pILzjqQS6bSV2F7nO3quAZKyzX7Wwpva0NJjMMqWoTgiGBin868M9Inj381kxKUA6pSvCciVSxzjBQ1PFvAa0SftZMfClZ/w6Ix+JtCO2pkE2jCuRXqKF5irP82zJsNE4h1cxOxOUX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd8O+q69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd8O+q69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5694E1F00893;
	Sun, 31 May 2026 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210032;
	bh=wBeO5ttsxoXvpOn7+BPMJ4Lp/eRBxDXoeXeAUyuiccs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zd8O+q69aJnYkQ1598PDXk4rbGDQ2UAmoeA2zJizqWrLDImu31Br6T5N/96pcrlT9
	 TXZ426YyJWUmdQC+gEtVM1uIf1GgjHm6GQeyOJ7z+7sgRkP6Bqmn11cnVsOsTphbfH
	 InGwjagak42YbSarDdHQIzPvw3iKzwWmOJMUpwsTaakGPrku6bz/LuvXlP8O9eXpUD
	 6IPiyzaEsCq1G3pITq43mrEMdezt0efyTEvmCsjAqiphLB20aqi4u+w8kVoN+bmGzH
	 /nzxr9L8P+31qyCrXYRpEbAC/liJ3V7PonhdNJoWylDR705mG+rp6BgS402FUleYiO
	 90dstom5xHC9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/14] perf test: Show snippet failure output for
 verbose=1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531063736.871777-8-irogers@google.com>
References: <20260531063736.871777-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 06:47:12 +0000
Message-Id: <20260531064712.5694E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch introduces an unused helper function `line_contains` w=
hich causes a `-Werror` build failure, and Pass 0 fails to search for execu=
tion boundary markers as claimed in the commit message.
- [Medium] Passing a signed `char` directly to `tolower()` invokes undefine=
d behavior and can cause out-of-bounds memory reads for non-ASCII character=
s.
--

commit 341f346c5efffc91ead705378b8412e2de4cf957
Author: Ian Rogers <irogers@google.com>

perf test: Show snippet failure output for verbose=3D1

This patch introduces a bounded snippet processor to limit the amount of
output dumped to stderr when a test case fails in verbose mode, extracting
lines that contain relevant failure keywords.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 9f71f11928c60..a29925656865b 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -398,6 +400,204 @@ static int print_test_result(struct test_suite *t, =
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
> +					break;
> +			}

[Severity: Medium]
Is it safe to pass s[i] directly to tolower() without casting to unsigned
char first?=20

If s[i] is a signed char containing a negative value, such as non-ASCII UTF=
-8
sequences or binary garbage from a crashing test case, could this invoke
undefined behavior and lead to out-of-bounds array lookups in libc?

[ ... ]

> +static bool line_contains(const char *line, size_t len, const char *tok)
> +{
> +	size_t tok_len =3D strlen(tok);
> +	const char *s =3D line;
> +
> +	while ((size_t)(s - line) + tok_len <=3D len) {
> +		if (memcmp(s, tok, tok_len) =3D=3D 0)
> +			return true;
> +		s++;
> +	}
> +	return false;
> +}

[Severity: Medium]
This function appears to be completely unused. Does this cause a build fail=
ure
when the tree is compiled with -Werror=3Dunused-function, which is typically
enabled by default for perf tools?

[ ... ]

> +	/* Pass 0: Always pick the very first line */
> +	if (num_lines > 0 && picked_count < failure_snippet_lines) {
> +		pick[0] =3D true;
> +		picked_count++;
> +	}

[Severity: Medium]
The commit message mentions that Pass 0 prioritizes "retaining outline mark=
er
lines containing dashes (=3D=3D=3D=3D)". However, this implementation just
unconditionally selects the first line instead.=20

Was the unused line_contains() function above originally intended to be used
here to search for the execution boundary markers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531063736.8717=
77-1-irogers@google.com?part=3D7
