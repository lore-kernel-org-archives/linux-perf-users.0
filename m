Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A69481FCA
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031594; cv=none; b=G6LHqpHVf7km+T3iyV7MuXKq74SFm3wqOFRS29iDW5B+qwjAcrUHEipQl8ljJzXfhO+ZXvfk9+kjcpI3ofBX30HTPszcPBnv4EBTTXaEDr7Y/ktnLBm5XfZ1qRzxNefwOiT3XUL+McodBTaYCDB7XHpTNKU1OxVpba6X1xDbyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031594; c=relaxed/simple;
	bh=FHwPpHv38PWluWC/nqAfmxw9CX6aMIXFAk8VtAGWbCA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ia95WEs4eWXkLcScoz/EF0N4rp7bE9oLXa1kohXz7PVRHcNFhb4NLL82mDoUBnc+QgCgM59NOQCFFG28cU+nTKhLixoUYJg60Y5as3Aaac8n5L8VyTkQe6+rzyxohKNRR5SmQtBUUfbyCbuSMlLrlrNyWCGkuzLgYfkIzdhZsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra+JBiLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra+JBiLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C49D1F00A3A;
	Thu,  6 Aug 2026 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031580;
	bh=jhzv1zWJRITAWdxqoNZSQ22NIQ4irmMmaEluwLaV0yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ra+JBiLPvlPbQi76Ntg6rkz0q683MYM0hkHqPnw2CgUvt77GBCCNYEgqnNVK471+j
	 T7C7YfEygnGcF015BJq7Uh/WVyCUFiRd7KocM5gm1+qEYEx3wT2QkMtKi8bJJQZtnN
	 mCfvCRN4ITUVcwj8Pk1VzJI6Aj/JKXOzfBMJKqX03hp/G8G0DgOx0wxvSnab5RMYhT
	 4fnhzyXjc5dFDBLb2FPHVWmG6EGt1HcvoiW5jlXIY6rlBSe+X0/I2dNpX4fJlMvcZK
	 kLtWDVUJ8eIuxz4Y6ttUI7VYMG1fV3EtI0tlCSm5MsZvCTDrrU+OT4wmgYl2HVZlkI
	 wMNXKSmY0Wy/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] perf sched latency: Add histogram and time
 interval options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806153926.300499-5-atomlin@atomlin.com>
References: <20260806153926.300499-1-atomlin@atomlin.com>
 <20260806153926.300499-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:52:59 +0000
Message-Id: <20260806155300.6C49D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit POSIX libc header inclusions for musl compatibilit=
y.
--

--- Patch [4]: [PATCH v9 4/4] perf sched latency: Add histogram and time in=
terval options ---
commit 045c1ada1f2d7eef344279deacd80eabe1267dcc
Author: Aaron Tomlin <atomlin@atomlin.com>
Subject: perf sched latency: Add histogram and time interval options

This commit adds --histogram, --hist-mode, and --time options to the
perf sched latency command. These options provide a visual ASCII bar chart
distribution of how long tasks waited for CPU runtime across latency
buckets within a specific time interval.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -257,6 +324,59 @@ static int scnprintf_latency_unit(char *buf, size_t =
size, u64 nsecs)
>  	return scnprintf(buf, size, "%6.3f s ", (double)nsecs / NSEC_PER_SEC);
>  }
> =20
> +static int latency_bucket(struct perf_sched *sched, u64 delta_ns)

[ ... ]

> +static void print_latency_histogram(struct perf_sched *sched, u64 *hist,
> +				    u64 total_count, const char *title)
> +{
> +	const char **bucket_names =3D (sched->hist_mode =3D=3D HIST_MODE_LINEAR=
) ?
> +		linear_bucket_names : lat_bucket_names;
> +	int bar_total =3D 40;
> +	char bar[] =3D "########################################";
> +	int i;
> +
> +	if (total_count =3D=3D 0)
> +		return;
> +
> +	printf("\n %s (total samples: %" PRIu64 ")\n", title, total_count);

[Severity: Low]
Does this file explicitly include <stdio.h>? The patch introduces new calls
to printf() in print_latency_histogram(), which can cause musl libc builds
to fail due to missing declarations if the file relies on implicit header
inclusions.

[ ... ]

> @@ -3649,6 +3803,24 @@ static int perf_sched__lat(struct perf_sched *sche=
d)
> =20
>  	setup_pager();
> =20
> +	if (sched->hist_mode_str) {
> +		sched->show_histogram =3D true;
> +		if (!strcmp(sched->hist_mode_str, "linear"))

[Severity: Low]
Are we sure <string.h> is explicitly included? This introduces a new use
of strcmp() in perf_sched__lat(), which has similar musl compatibility
requirements for explicit POSIX header inclusions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806153926.3004=
99-1-atomlin@atomlin.com?part=3D4
