Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A540B6E3
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641029; cv=none; b=bjotnNs2/i8PNFpP1B5I2wVi1I/9OPRJqgQP8rrSuOfCGfIpRAB7dk57rpvzQKR0jnDeDgd6XiiWubvzuagJ4Yw0xwlFWtklqJSAobTCSjHKT6FD//flCTThr+YDoMqDtN3Jg5Itc5mCpz4fxYigeQsFtujVj4EJb8irt9+1czc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641029; c=relaxed/simple;
	bh=Wn2fyHK1tPEg+399xHV9ltz1c0MVPpGHvt6qi8BtNd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NJRpkm+R0BLB16VfUpdjm+EXVxHvG8Eq6+rSPiBpk9ysPET65h78TA1/0XaNZe65GIfAwgUhqu2+xSaeDXg5VQ6TszRyShjrMcMCLOl0Em5ASNymVaJ1xVIrsIOX+J+DX+0pL8E9NoAHQdtaaQzhlYC7MitKYzeOTgDuyXxnUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcafU3dB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcafU3dB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432CA1F00893;
	Fri,  5 Jun 2026 06:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641028;
	bh=WUAYAxXFM/wZApX3sHTqf9Yqa69WLKg7DBVyTs4DWlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YcafU3dBW9OL7N4fzcZpoeZ8TXEUyliJoVCxkVJTkU14xAw534easv51yCQzEas03
	 H2fgqKI23QdctOhkT6nIQcgajXtDyCJC5D+jhIa/i3PeZBc5bf6B86ro5lzOThNeyu
	 KuJR69/gLPZfMF654okScPtCCe+zBAaZQFQbtdmZ5smHL9Gvy7XSO+qSmCWLZmBL6S
	 RnS60uZbnrZyaklIKt63Yc65T/3FmsH1vEeuXqDCBZ0g8RMnOZjeuNoBPpXnvnkax6
	 fsjrfzwitLELHoeRqcNp6E4rp3SUHCIyyJbZGRF85JVFtfICuVvGCGhNJeGPQVg6hj
	 tzktVly2i81RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605060610.1529996-4-irogers@google.com>
References: <20260605060610.1529996-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 06:30:27 +0000
Message-Id: <20260605063028.432CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] aslr_tool__process_sample disables needs_swap when parsing new_eve=
nt, causing 32-bit sample fields (like PID and TID) to be swapped during cr=
oss-endian analysis, which silently breaks downstream sample processing lik=
e build ID injection.
--

commit d0d9af33f8edcc0ac1964813a5b4d04938f7d3bf
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping

This patch introduces the logic for aslr_tool__process_sample to parse samp=
le
events and remap addresses using mapping metadata. It filters out specific
sample types to prevent ASLR leaks and delegates the modified sample to the
next tool.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 375a0355f2812..8cfefa23030d2 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c

[ ... ]

> @@ -554,13 +608,405 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,

[ ... ]

> +	new_event->sample.header.size =3D sizeof(struct perf_event_header) + j =
* sizeof(u64);
> +
> +	orig_needs_swap =3D evsel->needs_swap;
> =20
> -	return delegate->sample(delegate, event, sample, machine);
> +	perf_sample__init(&new_sample, /*all=3D*/ true);
> +	evsel->needs_swap =3D false;
> +	ret =3D evsel__parse_sample(evsel, new_event, &new_sample);

[Severity: High]
Does disabling evsel->needs_swap here break 32-bit fields when processing
cross-endian perf.data files?

When processing a cross-endian perf.data file, the core perf session loop
blindly 64-bit swaps the sample array before invoking the tool callback. For
fields containing packed 32-bit values (like PERF_SAMPLE_TID containing pid
and tid), the 64-bit swap reverses their order in memory.

evsel__parse_sample() normally corrects this by undoing the 64-bit swap and
reswapping the 32-bit words if evsel->needs_swap is true. By explicitly
setting it to false in aslr_tool__process_sample(), we bypass this 32-bit
unswapping logic. Could this cause new_sample.pid to receive the TID and
new_sample.tid to receive the PID (and similarly for PERF_SAMPLE_CPU)?

If these fields are swapped, wouldn't this silently break downstream sample
processing, such as build ID injection failing to find the correct thread
because the PID is completely invalid?

> +	evsel->needs_swap =3D orig_needs_swap;
> +
> +	if (ret) {
> +		perf_sample__exit(&new_sample);
> +		goto out_put;
> +	}
> +
> +	new_sample.evsel =3D evsel;
> +	ret =3D delegate->sample(delegate, new_event, &new_sample, machine);
> +	perf_sample__exit(&new_sample);
> +
> +out_put:
> +	thread__put(thread);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605060610.1529=
996-1-irogers@google.com?part=3D3
