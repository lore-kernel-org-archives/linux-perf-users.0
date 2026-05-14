Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A91A683C
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778719402; cv=none; b=IJoxhBALAO9sh9J/3Z1+8Wa+WdfBqA5fVJGMR1T/6sUb7HaJ8k5pG2PTRqkZxX58YG6jRtvfOoMWVuf/pb1xPIN06irVRrMqxC16tgYcjsFaAHUc9OG+2+yHFfvvzN8yJXJrFV78emOp1LpvsmiWiApX8VX/IA5F8E0b/KdkHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778719402; c=relaxed/simple;
	bh=svMdPeeHgeXefb90ehm9/DK5sH9MehBhJ7NhKY0RpP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uJ8zx6BJSinnfDMPw2+eeeqm34RYin+vWqupgsjxrMMIyJ2uIrp+Gl6EsHyCHuv0Sfs/z/x7Yo1j7/uXerirsvspZGJFn5ofti+/0RwID2KEHNYESVMM2W/THAy2sMYXU41cm6+5XVnOlbWD9bSLM5nqAvoh+o/rEf2aagmMZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx1aM0xQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx1aM0xQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25019C19425;
	Thu, 14 May 2026 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778719402;
	bh=svMdPeeHgeXefb90ehm9/DK5sH9MehBhJ7NhKY0RpP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Sx1aM0xQw0v/i3WhxTkJgnm866UjCDIOETrUjOlYh4ZxEdg+izJ4tmk0BieR48Brj
	 3DXu6n3E3kGMhM1yaDB4xMBWB35kLZcv0TwGxb9uydJxRXKN+/zHpl83oo8YI/f3Nv
	 iy/i+5U0UoKQTW3U5Ye+fs2eaMKYtdpVaftHfjGlBx+hoh2saCgyONa0b0zHEbOb7T
	 g0NcqN+6xL1mbU5L5l1izKbVnS26G9njKA+OxKspnn+ZQ7ZGi7IXMskOznlqZp/Gxe
	 ueGcOB3M27MgdtKxsRr486vhpmZiH5jFnPRRt7xpi2M4sUgQ4JfSDqfyqoImoKAyOz
	 E2JniuqpYgKvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf stat: Make metric only column line up with header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512234345.554166-1-ak@linux.intel.com>
References: <20260512234345.554166-1-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:43:21 +0000
Message-Id: <20260514004322.25019C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Corruption of default metricgroup alignment in standard (non-metri=
c-only) output.
- [High] Extraneous trailing space added to CSV output breaks machine reada=
bility.
- [Medium] Off-by-one column misalignment in metric-only standard output.
--

commit 29839374a38b0f40e2eb452aeaffa530277247ff
Author: Andi Kleen <ak@linux.intel.com>

perf stat: Make metric only column line up with header

This commit attempts to fix column alignment in the --metric-only output
mode. It simplifies the column width computation and adjusts string
formatting for both standard and CSV outputs.

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index 993f4c4b8f442..402611ecaf423 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -580,16 +580,13 @@ static void print_metricgroup_header_std(struct per=
f_stat_config *config,
>  					 const char *metricgroup_name)
>  {
[ ... ]
> -	n =3D fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
> -
> -	fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + 2 - n,=
 "");
> +	fprintf(config->output, " %*s", config->metric_only_len, metricgroup_na=
me);
>  }

Does this change break tabular alignment for default metricgroups in standa=
rd
non-metric-only mode?

The commit message states that EVNAME_LEN and MGROUP_LEN are not useful in
the metric only context. However, print_metricgroup_header_std() is
completely bypassed in --metric-only mode.

In standard mode, this function uses these lengths to pad the metricgroup
name and align it with the preceding counter values. Replacing this padding
with config->metric_only_len could shift all subsequent metrics to the left.

> @@ -599,19 +596,20 @@ static void print_metric_only(struct perf_stat_conf=
ig *config,
[ ... ]
> +	olen =3D snprintf(str, sizeof(str), fmt ?: "", val);
>  	color_snprintf(str, sizeof(str), color ?: "", fmt ?: "", val);
> -	fprintf(out, "%*s ", mlen, str);
> +	fprintf(out, "%*s%s", max_t(int, mlen - olen, 1), "", str);
>  	os->first =3D false;
>  }

Could this lead to an off-by-one misalignment in the data columns?

This new formatting removes the trailing space and outputs exactly mlen
visual characters. However, the header formatting in print_metric_header()
was left unchanged and still outputs a trailing space:

tools/perf/util/stat-display.c:print_metric_header() {
    ...
    fprintf(os->fh, "%*s ", config->metric_only_len, unit);
    ...
}

Because each data column is exactly one character narrower than its header,
will the data rows progressively drift to the left compared to the headers?

> @@ -633,7 +631,7 @@ static void print_metric_only_csv(struct perf_stat_co=
nfig *config __maybe_unused
>  	while (isdigit(*ends) || *ends =3D=3D '.')
>  		ends++;
>  	*ends =3D 0;
> -	fprintf(out, "%s%s", vals, config->csv_sep);
> +	fprintf(out, "%s%s ", vals, config->csv_sep);
>  	os->first =3D false;
>  }

Does adding this trailing space after the CSV separator break machine
readability for strict CSV parsers?

The CSV header output does not appear to add this space, which might cause a
format mismatch between the headers and the data rows.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512234345.5541=
66-1-ak@linux.intel.com?part=3D1
