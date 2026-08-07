Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A63FA5E7;
	Fri,  7 Aug 2026 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090834; cv=none; b=r0P6o6BbagHJOuOVrpHExFq4pfNKP9Fb9qRwNWDaiakoMv/smJpYwQHAKEfsMsa618w9/9oGZD3P/zGnRjvDNX22q42gg3ZnBOPxsaREue1xnEI1BdcLAlPL3XJpsQuevbPA/WDMpFI+o+fbkBx5D7H6rZdNW9nMrmQFue6NEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090834; c=relaxed/simple;
	bh=En86djnGUfP86YDNJYz+E/WjfKvJih4YSDX7/oZCijQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N7sEiIYt+sDMtARcS4aNK5CcndqrTcA1j0Erbe6Ejfjkpp1GS+HEHMX76DJzwRda19p+dL6rp1Pth1XqE0lJWYj8QEyjHRsh86Urae46cAsAdB0NwrS00HYWiWUe+gHnWcpLsLNFGVOlL5oPEkV+WAR1sNZHixNt/gJuejiH2lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqD6uGgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqD6uGgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600541F000E9;
	Fri,  7 Aug 2026 08:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786090833;
	bh=uYuy0tJP1hS4EVlVKdwRE5ZSNRnDuPhHIpC7j8hEFTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqD6uGgi0WDtfVYNIIkvOAnrsbTwyNQllDRO05gclaqIoSkcYkspPSgkxsxZyLYJv
	 aMjL/wuxMPOoZp1c91NEcpkPVbs8r2Oo8E9GRdDcRTJWU2+0OYLIwGihz521z7guRS
	 BcrVCe8BtECkuE6SAkeIdAkr0/fZz8Jv31znXUb7Nfz2FD7UewQCXEo72VmPEBEvpq
	 2Uk9eclnI98JiMb3gy5SS1PQlSvBiU2SKnXmPtLIG3f6tE90XeAmsCvcXpOJbwbDNF
	 pafKYBcUV/6xxH/tOjQjBwbteRveDsZQCWDzXjQC6A9SlKOmlFhXqYORQGZZQsN/bw
	 x0dLlgTYL41rw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 4/8] perf: Refactor thread map and symbol APIs to
 take perf_sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807071818.718751-5-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:20:32 +0000
Message-Id: <20260807082033.600541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The updated `thread__find_map` function incorrectly treats an ad=
dress of `0` as missing IP data, breaking lookups for address `0` and skipp=
ing required `addr_location` field initialization.
- [Medium] Excessive and redundant zero-initialization of the large `struct=
 perf_sample` in hot paths causes severe performance overhead.
--

--- Patch [4]: [RFC PATCH v1 4/8] perf: Refactor thread map and symbol APIs=
 to take perf_sample ---
commit 1099356ec0523851e160af69676be71cd35a2dc7
Author: Ian Rogers <irogers@google.com>

perf: Refactor thread map and symbol APIs to take perf_sample

This commit refactors the thread__find_map and thread__find_symbol
family of APIs in the perf tools to accept a pointer to a perf_sample
structure instead of individual cpumode and addr parameters. This change
prepares the APIs to support symbol lookups using a build ID and offset,
which are contained in the sample payload rather than just the address.

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1000,8 +1000,10 @@ static int perf_sample__fprintf_brstack(struct per=
f_sample *sample,
> =20
>  			addr_location__init(&alf);
>  			addr_location__init(&alt);
> -			thread__find_map_fb(thread, sample->cpumode, from, &alf);
> -			thread__find_map_fb(thread, sample->cpumode, to, &alt);
> +			thread__find_map_fb(thread,
> +			    &(struct perf_sample){.cpumode =3D sample->cpumode, .ip =3D from}=
, &alf);
> +			thread__find_map_fb(thread,
> +			    &(struct perf_sample){.cpumode =3D sample->cpumode, .ip =3D to}, =
&alt);

[Severity: Medium]
Will these compound literals cause a significant performance regression in
this loop?

Because struct perf_sample is a large structure (~320 bytes), omitting the
remaining fields in the compound literal forces the compiler to
zero-initialize the rest of the struct for every branch stack entry.
Creating and zeroing these large structs inside a tight loop could
introduce severe CPU overhead when processing traces.

[ ... ]

> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -702,34 +702,39 @@ struct map *thread__find_map(struct thread *thread,=
 u8 cpumode, u64 addr,
>  	thread__zput(al->thread);
>  	al->thread =3D thread__get(thread);
> =20
> -	al->addr =3D addr;
> -	al->cpumode =3D cpumode;
> +	if (sample->ip) {
> +		al->addr =3D sample->ip;
> +	} else {
> +		pr_debug("Sample missing IP data\n");
> +		return NULL;
> +	}
> +	al->cpumode =3D sample->cpumode;

[Severity: Medium]
Could this fail when resolving legitimate 0 addresses?

If a page fault or branch event occurs exactly at address 0 (for example,
a NULL pointer dereference), tools like trace__pgfault pass a sample->addr
of 0 as the IP. This condition evaluates to false for address 0, causing
the function to return NULL early.

When the function returns early here, it skips the initialization of
al->cpumode and al->level, which can leave those fields uninitialized
and cause trace output corruption (like printing null bytes).

[ ... ]

> @@ -816,7 +822,10 @@ int machine__resolve(struct machine *machine, struct=
 addr_location *al,
>  		return -1;
> =20
>  	dump_printf(" ... thread: %s:%d\n", thread__comm_str(thread), thread__t=
id(thread));
> -	thread__find_map(thread, sample->cpumode, sample->ip, al);
> +	thread__find_map(thread,
> +			 &(struct perf_sample){.cpumode =3D sample->cpumode,
> +					       .ip =3D sample->ip,
> +					       .bid =3D sample->bid}, al);

[Severity: Medium]
Could this compound literal also introduce overhead in the hot path?

Similar to the loop in perf_sample__fprintf_brstack, machine__resolve is
called for every single sample event. Creating a new, mostly
zero-initialized struct perf_sample here forces the compiler to write
zeroes to hundreds of bytes per event parsed, which can drastically slow
down trace processing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D4
