Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DA3CA497
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835228; cv=none; b=Gxt+YIJcyimkbNDqV2gEA5GZ7lp9jzl43xODnoqQEn8Bb3flsJYvDkz40F3Tu5A6D678b8fvB/14+OjfTgWPpd0cY+8Qy9roEu9lafXRRa7CbZDVV9glv5c6o37s5AoBRVIpsThMQp2V4UseuxPHtXP6ZmCk2/ArEmmBxYac2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835228; c=relaxed/simple;
	bh=vzvglo72xW/TtDGS7+WyXqkvU92S047Ju9KjWP227HE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNmffWwzQTjuGva7uNJ5b3GfQW0cb34SP8aDmhg9KiiJADjsLgrCQI/KRonHc4/0nD9qCfStyOpVOGq7DOpoJbbMKW4BOjPsdtaWzPUW5EmdfDUNROZe02MQ514rkYx9bDa2Lk2A01a82R3QumPX/SfaJ1TbqoI6MtIYOspL2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTWrQNoS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTWrQNoS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498F01F000E9;
	Tue, 26 May 2026 22:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835226;
	bh=HBVKtGLo98moPWyooaFPvFJek9txNzdVoBKD94q84V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTWrQNoSjYCYyLzTCyxWrRgqrxpq9C8e1ff56Q/8OjYuJk5Jr7ekX877oK0QflcC8
	 rl6eOcK9vj2cza3AWHMR6kN1GdM0xY5DljIJOU0+rTMXBDdP2JHzGlUj5fMlZLRdTD
	 FCHR6jArCpynE3s/C8Wv72d25N0CSb1T/V2AF6rrSfvMaSscAliG65PS8GKhwG+ofu
	 mN8+1RfymfzoCfZRkluNZJbz5oon8mxjIHtR8CYTJpguz8UZlUHhuqexwn1J7myNhi
	 ch46Frt7iWatvQpiZFGp8fMH9enuiHkgG3QnbdcqNJjggUMBGdfa89GCH4CMI/ch8C
	 sLtz/q+joxksA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 26/29] perf session: Bound nr_cpus_avail and validate
 sample CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-27-acme@kernel.org>
References: <20260526211806.1193848-27-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:40:25 +0000
Message-Id: <20260526224026.498F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Globally mutating `sample.cpu` to 0 for CPUs exceeding `MAX_NR_CPU=
S` corrupts valid data for tools that correctly support large CPU counts.
--

commit 17ecab60f87deb66695ee576a168167eb8c64bf5
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Bound nr_cpus_avail and validate sample CPU
   =20
This commit adds a bounds check for the sample CPU index in the core event
delivery loop to protect downstream tools with fixed-size arrays. It bounds
the available CPU count to MAX_NR_CPUS and clamps any out-of-bounds
sample.cpu value to 0.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 9271885e3920f..6de665d3c9054 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c

[ ... ]

> +		/*
> +		 * Cap at MAX_NR_CPUS for the bounds check =E2=80=94 downstream
> +		 * consumers use fixed-size arrays of that size.  Keep
> +		 * the true nr_cpus_avail in env for header parsing
> +		 * (e.g. process_cpu_topology) which needs the real count.
> +		 */
> +		if (nr_cpus_avail > MAX_NR_CPUS)
> +			nr_cpus_avail =3D MAX_NR_CPUS;
> +		if (sample.cpu >=3D (u32)nr_cpus_avail &&
> +		    sample.cpu !=3D (u32)-1) {
> +			/*
> +			 * Warn rather than abort: synthesized events
> +			 * (MMAP, COMM) lack sample_id_all data, so
> +			 * parse_id_sample reads garbage from the event
> +			 * payload.  Clamping to 0 protects downstream
> +			 * array indexing while keeping the session alive.
> +			 *
> +			 * Preserve (u32)-1: perf script and perf inject
> +			 * use it as a sentinel for "CPU not applicable."
> +			 * Downstream array users (timechart, kwork) have
> +			 * their own per-callback bounds checks.
> +			 */
> +			pr_warning_once("WARNING: sample CPU %u >=3D nr_cpus_avail %u, clampi=
ng to 0\n",
> +					sample.cpu, nr_cpus_avail);
> +			sample.cpu =3D 0;

[Severity: High]
Does this global mutation of sample.cpu corrupt valid data for tools that
correctly support large CPU counts?

If a system legitimately has more than MAX_NR_CPUS (4096) CPUs, clamping
nr_cpus_avail to MAX_NR_CPUS and then reassigning sample.cpu to 0 will
attribute all samples from CPU 4096 and above to CPU 0.

Downstream tools like perf script and perf report handle CPU indices
dynamically and fully support greater than 4096 CPUs.

Would it be safer to push this fixed-size array bounds checking down into
the specific tools (like timechart and kwork) rather than altering the
shared sample structure globally in the core event delivery loop?

> +		}
> +	}
> =20
>  	ret =3D auxtrace__process_event(session, event, &sample, tool);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D26
