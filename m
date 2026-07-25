Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC263F4107
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785001178; cv=none; b=H/krsmciAtKx5HmLUSFcq7l25tsmXulFYsF7oKZ3y7uUUrCYEqNLiKks1cEHIYGtk7q2iS5AKtx77WxD928KFGGdXmVWK/y4rYtrTzV1ZbhaqlMAHOZ9wWtCnFMVpGw1WLdJulE2tAHH6vwxwcbXQOgmCUnliI70FkfntyAwD3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785001178; c=relaxed/simple;
	bh=IoIHwgwaZP6eYzNTM6ly2hHcDKWwQbXHLbg7LAPBK7U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nk+G0Zw94BoeHjioWc0F0THPxZB2vAGXgD3DEnz6OVnTZvXbAsKIdVPqsS2ChO611PYY/VuSVOYRcv0ydWxg5CSFQ2mxaoU6HT4fH4HZPgawKLciO3ncA5PuhKDyLuhQZOlqNNuY4/+9DrXtJGGr0ejw7Gv4SFeSMjc+q0sSH58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdtEeeZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdtEeeZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5241F000E9;
	Sat, 25 Jul 2026 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785001174;
	bh=GYD+zGdcPB2KrVb6JFNZ8xMDg1WYyDsaMRgqE+2FnQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdtEeeZqBDeCdS3FeHHdqbcMMSZ8yLHJlRBCGi8kAWiNVkEGBHZVINqfLha5Anl1m
	 8TNciuBKf9qMRzJmpCIHVgWJC2pnbsUlkeG4sox7oCwXSayu4bRXIPkMjnI2D0IA4v
	 hpJKBdqDowdgWvFUCky7Er7erpRTHXaQwBJQcxYzwSRjgaAogpSIPwcKnrcrVRO3UM
	 ApnjUHTLKd2btuF5M1xuCttAIP7+DG0zCOCDoXwcLhrtMl5aLfji2CKBQ2D8eyuhlv
	 yMSCTcxJLYNbxEVltWlAEKvE1Hp2CCAjGYN0Rm3kvu94pLjDVWqU4sC1kYRnkMr+zg
	 fqK/B7vQVLncA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf sched latency: Auto-scale latency and
 runtime display units
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725173341.679782-3-atomlin@atomlin.com>
References: <20260725173341.679782-1-atomlin@atomlin.com>
 <20260725173341.679782-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 17:39:33 +0000
Message-Id: <20260725173934.1D5241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The table column alignment in `perf sched latency` is broken by the=
 new formatting widths, contradicting the commit message's claim of maintai=
ning column alignment.
--

--- Patch [2]: [PATCH v2 2/3] perf sched latency: Auto-scale latency and ru=
ntime display units ---
commit bd1f9f65443ae53474112d9990f8290686a5aaa3
Author: Aaron Tomlin <atomlin@atomlin.com>

perf sched latency: Auto-scale latency and runtime display units

This commit introduces dynamic scaling for latency and runtime values in
'perf sched latency' output. It replaces hardcoded millisecond output with
auto-scaled units (ns, us, ms, s) and updates the table formatting to
improve readability.

> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index b3cf678573e0a..00ff5abb08b57 100644
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
> +	printf("|%13s |%9" PRIu64 " | avg:%10s | max:%10s | max start: %12s s |=
 max end: %12s s\n",
> +	       runtime_lat,
> +	       work_list->nb_atoms, avg_lat, max_lat,
> +	       max_lat_start, max_lat_end);
> +
>  }

[Severity: Low]
Does this format string break the column alignment?

The table header defines a width of 15 characters for the "Runtime" column
(|   Runtime     |), and 17 characters for the "Avg delay" and "Max delay"
columns. The new formats %13s and avg:%10s produce strings that are shorter
than these expected widths, which appears to cause the vertical bar separat=
ors
to misalign.

[ ... ]

> @@ -3612,7 +3629,7 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	perf_sched__sort_lat(sched);
> =20
>  	printf("\n ------------------------------------------------------------=
---------------------------------------------------------------------------=
----\n");
> -	printf("  Task                  |   Runtime ms  |  Count   | Avg delay =
ms    | Max delay ms    | Max delay start           | Max delay end        =
  |\n");
> +	printf("  Task                  |   Runtime     |  Count   | Avg delay =
      | Max delay       | Max delay start           | Max delay end        =
  |\n");
>  	printf(" --------------------------------------------------------------=
---------------------------------------------------------------------------=
--\n");

[ ... ]

> @@ -3626,8 +3643,9 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	}
> =20
>  	printf(" --------------------------------------------------------------=
---------------------------------------------------\n");
> -	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
> -		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
> +	scnprintf_latency_unit(total_runtime_str, sizeof(total_runtime_str), sc=
hed->all_runtime);
> +	printf("  TOTAL:                |%13s |%9" PRIu64 " |\n",
> +	       total_runtime_str, sched->all_count);
> =20
>  	printf(" ---------------------------------------------------\n");

[Severity: Low]
Does the use of %13s here also break the vertical alignment of the first
column for the TOTAL row summary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725173341.6797=
82-1-atomlin@atomlin.com?part=3D2
