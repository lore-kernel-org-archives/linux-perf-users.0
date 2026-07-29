Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDF24963D0
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336767; cv=none; b=VxEeKDdOqHWPO5GAPWA0DyGAKQXUDXSy89tyyp0gmz/LlP+yDjmmutXQ/UvBnkD6errRtSYr5ix3plTJQMQ+oHw2PIXfb5uXOsd9+cu0fxuE3ztq6qrgdE4nnishYyDFMbb9LugxX5aYKBiSRupTmK2fM55T9mJGO7cobXoixvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336767; c=relaxed/simple;
	bh=NTO2Kc+b6BdSj0wXTlbocaD/W9njBfPxSMKpdPKIP3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VB8Fue0Be1RML9N3khlKwKNBQ8x5C2gJRlWERsOyyTeKo0fiiUHIn6qfgR6IENX1cJSUCcYVzF/0HRx0IOBE1m9eV+vlebF0jhzyreGqyoCl6PxnRQQhWDiiIiZwcSM4gbJrVDdXemcAPL7vZldOJy6LSIGqumMo+GQe5mlt3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXckIDpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXckIDpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7261F00A3A;
	Wed, 29 Jul 2026 14:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336765;
	bh=PKpguqTR9W4zLldBb+wTKrhjXUBoNwpUb1wJVvWPi/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DXckIDpY7rxf6uMgHib40STR7mITjeRTQ/EBQ6PCIVmjJ7d8jkeoadwgTyeStUihd
	 Wv8rOfhFKDRJLjJ9UqImFG3dbDDxa9DPKYZErj+lz8ZNZNU96tG1wapLlLOvdiSjfB
	 sAxRS9Sw2ZIzndsuPGX1c0Hko22358fGEva8i4N6kOhs6ZFbKCopKCwfIwSQwESeR5
	 6Ed6CsL1Kx1wSRRaNkfEOk0F0WBaa9/rU92eVEwLV89IFTU3/rPWrm+23l68NWrfNn
	 WK88VaJNg0yZ/irVc1ZJUE/8uwqnYGVBBYsHBESGTG1cMRYUVoUvqLgpeSXvPhxR7g
	 qJ6MNfiHvN0WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf sched latency: Auto-scale latency and
 runtime display units
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729144451.38286-3-atomlin@atomlin.com>
References: <20260729144451.38286-1-atomlin@atomlin.com>
 <20260729144451.38286-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:52:45 +0000
Message-Id: <20260729145245.8B7261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch breaks the tabular alignment of the `perf sched latency` =
output due to mismatched column widths and overextended separator lines.
--

--- Patch [2]: [PATCH v4 2/3] perf sched latency: Auto-scale latency and ru=
ntime display units ---
commit 652fc7d49ad81ba1ea0ce14f520241722f7c1054
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched latency: Auto-scale latency and runtime display units

This commit introduces auto-scaling for latency and runtime display columns
in the perf sched latency output. Values are dynamically scaled and output
with the most appropriate unit (ns, us, ms, or s). It also renames column
headers and adjusts spacing to accommodate these changes.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index fabd99a18aad4..c34726b87eaa1 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c

[ ... ]

> @@ -1430,14 +1443,17 @@ static void output_lat_thread(struct perf_sched *=
sched, struct work_atoms *work_
>  		printf(" ");
> =20
>  	avg =3D work_list->total_lat / work_list->nb_atoms;
> +	scnprintf_latency_unit(runtime_lat, sizeof(runtime_lat), work_list->tot=
al_runtime);
> +	scnprintf_latency_unit(avg_lat, sizeof(avg_lat), avg);
> +	scnprintf_latency_unit(max_lat, sizeof(max_lat), work_list->max_lat);
>  	timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, size=
of(max_lat_start));
>  	timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(m=
ax_lat_end));
> =20
> -	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max st=
art: %12s s | max end: %12s s\n",
> -	      (double)work_list->total_runtime / NSEC_PER_MSEC,
> -		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> -		 (double)work_list->max_lat / NSEC_PER_MSEC,
> -		 max_lat_start, max_lat_end);
> +	printf("|%14s |%9" PRIu64 " | avg:%11s | max:%11s | max start: %12s s |=
 max end: %12s s\n",
> +	       runtime_lat,
> +	       work_list->nb_atoms, avg_lat, max_lat,
> +	       max_lat_start, max_lat_end);
> +
>  }

[Severity: Low]
Does this format string in output_lat_thread() shift the subsequent columns
out of alignment with the header?

The data row format string here allocates 15 characters (14 padded plus
1 trailing space) for the Runtime column.

However, looking at the header defined in perf_sched__lat(), the header
allocates 16 characters for that same column ("    Runtime     "). This
1-character discrepancy appears to shift the data rows to the left relative
to the header.

[ ... ]

> @@ -3617,9 +3634,9 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	perf_sched__merge_lat(sched);
>  	perf_sched__sort_lat(sched);
> =20
> -	printf("\n ------------------------------------------------------------=
---------------------------------------------------------------------------=
----\n");
> -	printf("  Task                  |   Runtime ms  |  Count   | Avg delay =
ms    | Max delay ms    | Max delay start           | Max delay end        =
  |\n");
> -	printf(" --------------------------------------------------------------=
---------------------------------------------------------------------------=
--\n");
> +	printf("\n ------------------------------------------------------------=
---------------------------------------------------------------------------=
---------\n");
> +	printf("  Task                  |    Runtime     |  Count   |    Avg de=
lay    |    Max delay    |      Max delay start      |     Max delay end   =
  |\n");
> +	printf(" --------------------------------------------------------------=
---------------------------------------------------------------------------=
-------\n");

[Severity: Low]
Are these horizontal separator lines slightly too long for the table?

It looks like the separator line was lengthened to 144 hyphens, which
overshoots the right edge of the table columns by several characters,
breaking the visual alignment of the output.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729144451.3828=
6-1-atomlin@atomlin.com?part=3D2
