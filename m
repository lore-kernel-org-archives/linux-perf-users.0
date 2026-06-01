Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FE347BC6
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295158; cv=none; b=jr+EDfC97qZ6miR/rdsawd3VcqMkosOvcQRJuID4faguwDockaO/lajTxoJAaKrgFsSM68Pp2iJjssDKlhWUwQXS2PTGzeHql2UHgGyqAViT9gHglmWGx0ZHrP8rCdFdbWjM83lmnhPNUC10f5kjZThL5PzItM+yYgnFpPoKm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295158; c=relaxed/simple;
	bh=NJocm4FazRwxDZtd69w7KkNDxLrn0Z74VnjBNQ4/wKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WxtJckPgMDpF9QgPMPh3iO9Wxlk9c0efKRHdhch2TPdJFL3P77dqL4gqzB8pYkf+0zf505avtbvjUQW+VrxhadvScbc1gl5Epb0vYARZK/h24Co0FnOGXj4hqPHVobkC6CSEv0QSlr1lfK/Cbr4ZzbC9MU9Hd8GeGU/UzCbcVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYdEOzdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYdEOzdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7961F00893;
	Mon,  1 Jun 2026 06:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295156;
	bh=oX7wAsazo1vp94xlyn4V264CsDZ7i3eDqqtSr6QoIZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYdEOzdGfdWwHgNQpEyTFUc+ZjrOzncM8YD1lLH4Lq5KcLbG39Tlw+OSrIvqtkbT6
	 OEtSaEpslOZcg6vyQMiEq19LOQBiRDvnbo+m2XacTDTZ68iR3SIeNm4CEF3lx1H5KB
	 hwxFxu1MDZjVsGpo1dzSaWcnIZ1Dt6SEBfM/7NvyciyXkqJy44AzhOGuVDDPR0YPnJ
	 sq7lWsOe1OpY4tsR7RGwBUbZEhJAR1YBOC+8vERFzVWHqonRFpMFxloM/usXSsKddl
	 JWrf9xvBnLid5C62JPbtFwWTkgtrIDxGSycYPhkCMhXZNTkUC5FLjBhHlL6qGPvSEM
	 /L3O+L/JOE7Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/15] perf test: Show snippet failure output for
 verbose=1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-9-irogers@google.com>
References: <20260601061401.1541457-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:25:56 +0000
Message-Id: <20260601062556.9B7961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] O(N^2) time complexity in `find_next_keyword` when processing lo=
ng lines.
--

commit 2095066ea9915f694a9267e1143ad972e358c87f
Author: Ian Rogers <irogers@google.com>

perf test: Show snippet failure output for verbose=3D1

This patch introduces a smart failure snippet processor for perf tests runn=
ing
in verbose mode. It dynamically parses the raw error buffer to extract up t=
o a
configurable number of lines containing failure keywords, highlighting them=
 in
red. This prevents massive log dumps from hiding important diagnostic keywo=
rds.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -400,6 +402,192 @@ static int print_test_result(struct test_suite *t, =
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

[Severity: Medium]
The find_next_keyword function searches for multiple keywords independently.
If an earlier keyword match (best) has already been found, this loop contin=
ues
scanning the remainder of the string for the other keywords up to max_len.

Could this loop be optimized to stop when the search pointer passes the best
match so far?

> +			size_t i;
> +
> +			for (i =3D 0; i < len; i++) {
> +				if (tolower(s[i]) !=3D fail_keywords[k][i])
> +					break;
> +			}

[ ... ]

> +static void print_line_highlighted(FILE *fp, const char *line, size_t le=
n)
> +{
> +	const char *s =3D line;
> +
> +	while (len > 0) {
> +		size_t kw_len =3D 0;
> +		const char *match =3D find_next_keyword(s, len, &kw_len);

[Severity: Medium]
Since print_line_highlighted repeatedly invokes find_next_keyword after each
match, and find_next_keyword scans the entire remaining max_len for every
missing keyword, a line with many occurrences of one keyword (e.g., error)
but lacking others could cause repeated full-length scans.

Can this lead to excessive processing time and quadratic behavior for very
long lines?

> +
> +		if (!match) {
> +			fwrite(s, 1, len, fp);
> +			break;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D8
