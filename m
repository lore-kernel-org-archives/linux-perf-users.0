Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458E279329
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199681; cv=none; b=IW/bjxI4wJrzv/v3mhRAsGbNXrQVIE4qUJTE8jAWO0isKeZWj5CCEAuXi3QtvAhULQf48Y5VYRJPGtAXelyDN+M/pRzI24JRAYXNjZ/7PCHGXbRp0GU8f5h+A0HeyaALmqBWYNKOppCDqEjviB5JCk0SnN3W8mADYk6lHsURANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199681; c=relaxed/simple;
	bh=sIiBXWPdt16f/KfVWQKEpQvk3oU3lDi3QLFDPpTgqFE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=humjPFp/f77/eYMY42lE+TkyRlIQVU5H3QvejQh4Fs9mcmAgNWAzW9NFcH5YBhthu2f2zZ32ixsM/OIKoVc4kvSXnE35Wg99LNHvJ+proTrqpODrzfV/edlP9I504e4B1/XZbMky4GR3rF/oi8Nxt/tM/R4VfYPkCclA1P3iW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLxenDRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLxenDRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB261F00893;
	Thu, 11 Jun 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781199680;
	bh=Q50ZgtCmvWUA5ObbqsX+UEzVXf1Vu+AV0fU/r/krNt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLxenDRdFQrCyUQSixM3NyBEksj8LAJlioZO9tQqTtbI09kEIdSwT1r1/vj1F0qWt
	 qay6kaFUvf5x+cANXIkAZD3P++2RgX0JiyDPxPgUMwgdWNxPmdkS0b7ipDtFUipY31
	 SJ23bgHO0olq+f59yCg8wrjPtTAMTHtNs590BRpoJRHA/oGHk5KZVq1hgTIyGYFkBP
	 u3TRoyTK9rg+cvKpAbk7jmi/64nICA4nMQUAP7UHFb3xy6DOvTFcvklFTzHFS3Nz8v
	 o5QZfkCyzK02H11XAJ+Jv1mC6ifsVn8q5+awmtO+fCALbprxtGB/KjFI4r0EHb2GXR
	 gn9U+9pceJZXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611164122.3974068-4-irogers@google.com>
References: <20260611164122.3974068-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:41:19 +0000
Message-Id: <20260611174120.3CB261F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Addresses that cannot be remapped are destructively overwritten wi=
th 0.
- [Medium] Missing union-based repacking for PERF_SAMPLE_CPU causes cross-e=
ndian event synthesis failure.
--

commit 4363deb515e79cb7e3488a5d19b247858fb88edd
Author: Gabriel Marin <gmx@google.com>

Add the sample address remapping logic to the ASLR tool.

This patch implements sample event processing for the ASLR tool, parsing
sample events and remapping addresses like IPs, callchains, and branch stac=
ks.
It also adds the aslr_tool__remap_address helper function.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
> @@ -112,6 +113,60 @@ static u64 round_up_to_page_size(u64 addr)
>  	return (addr + page_size - 1) & ~((u64)page_size - 1);
>  }
> =20
> +static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
> +				    struct thread *aslr_thread,
> +				    u8 cpumode,
> +				    u64 addr)
> +{
> +	struct addr_location al;
> +	struct remap_addresses_key key;
> +	u64 *remapped_invariant_ptr =3D NULL;
> +	u64 remap_addr =3D 0;

[ ... ]

> +		if (!thread__find_map(aslr_thread, effective_cpumode, addr, &al)) {
> +			addr_location__exit(&al);
> +			return 0; /* No mmap. */

[Severity: High]
Does returning 0 here destructively overwrite valid non-randomized addresse=
s?

If an address cannot be mapped (such as JIT code, vsyscall, or missing map
regions), returning 0 unconditionally overwrites the sample's IP, ADDR,
callchains, and branch stacks. Should this return the original addr instead
to avoid clustering profiler trace data at NULL?

> +		}
> +	}
> +
> +	key.machine =3D maps__machine(thread__maps(aslr_thread));
> +	key.dso =3D map__dso(al.map);
> +	key.invariant =3D map__start(al.map) - map__pgoff(al.map);
> +	key.pid =3D (effective_cpumode =3D=3D PERF_RECORD_MISC_KERNEL ||
> +		   effective_cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL) ?
> +		  kernel_pid : thread__pid(aslr_thread);
> +
> +	if (hashmap__find(&aslr->remap_addresses, &key, &remapped_invariant_ptr=
)) {
> +		remap_addr =3D *remapped_invariant_ptr + map__pgoff(al.map) +
> +			     (addr - map__start(al.map));
> +	} else {
> +		pr_debug("Cannot find a remapped entry for address %lx in mapping %lx(=
%lx) for pid=3D%d\n",
> +			 addr, map__start(al.map), map__size(al.map), key.pid);
> +	}
> +
> +	addr_location__exit(&al);
> +	return remap_addr;

[Severity: High]
Similarly, when the mapping is not in the remap_addresses hashmap, this will
return remap_addr which was initialized to 0. Would it be safer to default
remap_addr to the original addr instead of 0?

> +}

[ ... ]

> +	if (sample_type & PERF_SAMPLE_ID)
> +		COPY_U64(); /* id */
> +	if (sample_type & PERF_SAMPLE_STREAM_ID)
> +		COPY_U64(); /* stream_id */
> +	if (sample_type & PERF_SAMPLE_CPU)
> +		COPY_U64(); /* cpu, res */

[Severity: Medium]
The commit message states that both PERF_SAMPLE_TID and PERF_SAMPLE_CPU must
be unpacked and repacked using unions to ensure correct 32-bit layout
alignment for cross-endian hosts. However, it looks like PERF_SAMPLE_CPU
blindly uses COPY_U64() here instead of a union.

Since the generic perf event parsing layer byte-swaps the 64-bit payload
array, this reverses the internal order of the two 32-bit fields (cpu and
res). Does copying this improperly swapped 64-bit word verbatim write the
reversed fields directly to the output, corrupting them when reparsed with
needs_swap=3Dfalse?

> +	if (sample_type & PERF_SAMPLE_PERIOD)
> +		COPY_U64(); /* period */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611164122.3974=
068-1-irogers@google.com?part=3D3
