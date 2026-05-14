Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C61E515
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739056; cv=none; b=RFlCnF8MnCxWx4WDXcqvco+QeEH/K/7BFGidQ2Igw9+GrjMndl7FH+oX4C5boZhrkg50+0ATSJFjzZNODzLAw0//MtPHYul8jcF683ZQwkTrPhC9Fml64HHcnUYjV84j+OrtbtU6YeMZ31mZpq+mnGFGnX8rTyegwMXKozFT6ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739056; c=relaxed/simple;
	bh=Ce5nPMjLm3PWM4Q+0TzVtV9wWwA7Fl9D1vkAT/sIHA0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaM8ipmwitwXctXHiMfrNZas3TsmgvYIKgwjqYmZurWnR9rEsOZ+TIbFqwraYOxbatNWgbu5XvKY8B+tv4uDuCvb5DYiHVb62VQrL7fpFs6d1yXWUN8H1BxITx8oSByOKvrOW0GND6QaA7D2NM3Az+HlnGrVYo+fThQ2h8EJ4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGbPm27S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGbPm27S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FDFC2BCB7;
	Thu, 14 May 2026 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778739055;
	bh=Ce5nPMjLm3PWM4Q+0TzVtV9wWwA7Fl9D1vkAT/sIHA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KGbPm27SBp5LqjjsX2AXr2ky/qykOj7IF4AYIr10Nji5h/qeQ6dTurM3FvPfw+Li0
	 0vTAcRKlbWevEwTfrvgsI4Z1v8YIMmSHXq3V/e3vkWHJE+wQQTl7haMc9YUKms4TwH
	 E3M7Bq0jFuWOdiFE/RG4nPan7T+6n5ZMlqxKCTmCCQI2IjMcvV3Vw1dLuleSTsTsYI
	 vd9vbwpMk6xmA/X3CB7Oe5dkiBtqB6sQLb4XGOyAfZ9flFI0h0TqK/0aT/7JxImzlG
	 N92fihMtZiJh6WsBvC2W7K5Lkt3cHB1+ZgGZxabsl39K/IkuUp780Dm/hpMdyXHO9Q
	 6nnVwExqlMfeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf stat: Make metric only column line up with
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260513144906.557896-1-ak@linux.intel.com>
References: <20260513144906.557896-1-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 06:10:55 +0000
Message-Id: <20260514061055.C4FDFC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Cumulative column drift misalignment in --metric-only output.
- [Medium] Metric group header alignment is broken in standard (non-metric-=
only) perf stat output.
--

commit 1fbd687246bd068cad87b8edb8dcd01fdb03fe25
Author: Andi Kleen <ak@linux.intel.com>

perf stat: Make metric only column line up with header

This commit attempts to fix metric-only output column alignment by simplify=
ing
the column width computation. It ignores EVNAME_LEN, MGROUP_LEN, and
config->unit_width, and relies solely on config->metric_only_len and the
actual unit width.

>     Fix all those. I simplified the column width computation significantl=
y,
>     ignoring EVNAME_LEN, MGROUP_LEN, config->unit_width which don't
>     seem to be useful in the metric only context. It now only uses
>     the actual unit width as well as config->metric_only_len. The result
>     is more code removed than added.

This isn't a bug, but the commit message states these constants aren't usef=
ul
in the metric only context. However, print_metricgroup_header_std() is
explicitly used for standard (non-metric-only) output, where these constants
are still necessary for proper alignment.

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 993f4c4b8f442..2b69d238858cf 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -580,16 +580,13 @@ static void print_metricgroup_header_std(struct per=
f_stat_config *config,
>  					 const char *metricgroup_name)
>  {
>  	struct outstate *os =3D ctx;
> =20
>  	if (!metricgroup_name) {
>  		__new_line_std(config, os);
>  		return;
>  	}
> =20
> -	n =3D fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
> -
> -	fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + 2 - n,=
 "");
> +	fprintf(config->output, " %*s", config->metric_only_len, metricgroup_na=
me);

Does this change break metric group header alignment in standard perf stat
output?

print_metricgroup_header_std() is used in the standard (non-metric-only)
context. By reducing the padding from EVNAME_LEN + MGROUP_LEN (roughly 56
characters) to config->metric_only_len (typically 20), the metric group hea=
der
is printed too early, misaligning it with the subsequent metric columns.

[ ... ]

> @@ -599,19 +596,20 @@ static void print_metric_only(struct perf_stat_conf=
ig *config,
>  	struct outstate *os =3D ctx;
>  	FILE *out =3D os->fh;
>  	char str[1024];
> -	unsigned mlen =3D config->metric_only_len;
> +	unsigned mlen;
>  	const char *color =3D metric_threshold_classify__color(thresh);
> +	int olen;
> =20
> -	if (!unit)
> -		unit =3D "";
> -	if (mlen < strlen(unit))
> -		mlen =3D strlen(unit) + 1;
> +	if (!unit) {
> +		os->first =3D false;
> +		return;
> +	}
> =20
> -	if (color)
> -		mlen +=3D strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
> +	mlen =3D max_t(unsigned, strlen(unit), config->metric_only_len);
> =20
> +	olen =3D snprintf(str, sizeof(str), fmt ?: "", val);
>  	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
> -	fprintf(out, "%*s ", mlen, str);
> +	fprintf(out, "%*s%s", max_t(int, mlen - olen, 1), "", str);

Can this cause a cumulative column drift in the --metric-only output?

The headers are printed with max(metric_only_len, strlen(unit)) characters
plus an unconditional trailing space, making the header column width exactly
mlen + 1 characters.

The modified print_metric_only() outputs exactly mlen characters with no
trailing space. Because each value column is exactly 1 character narrower t=
han
its corresponding header column, the alignment breaks cumulatively across t=
he
line, shifting left by 1 character per successive column.

>  	os->first =3D false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513144906.5578=
96-1-ak@linux.intel.com?part=3D1
