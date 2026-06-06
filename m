Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991D23394D
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760020; cv=none; b=Qi7GCHIKnoQXTp9BuntvkG5mBmJZkYMJxH0DfUPugCOFt1MpWJ3xo+1SlJylD2PC40I/nLd7O44n5v//Eemb+S+P9S9W8Dvpfm0chjvge5sDuhHatmmZt7L/kqOXncA9m/0R0yz3ZJjCr19dS/GkQZpJ9N6RzMwIXmI/2kJuU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760020; c=relaxed/simple;
	bh=2jobnH8Z82MCSatYuPywvf6hpz9yyGV4c+6R56xeVJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qv2x5OA5Xp9pKlxXa5pu+Nb1RiO3DzVyUAnB9j7teDUqFdMLjh7KLJUvWjK9OBsOnYQBAHX7o0+Uezb34X6twmhDHSoxC2UPGzZbpOZLRm2Z78bFHavsXGHvmdMOFVQgj8LG8is3N+taoiJTRkU5brRqmTlCQzbhaUzTaylyTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaSt8dQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaSt8dQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752771F00893;
	Sat,  6 Jun 2026 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780760019;
	bh=ETw6zT85deqsyn3aocpOJ62y5mhWQ7xz521g2P4R0Js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EaSt8dQZuluvKiVmHl+rOUVxYdjtWx5V94+aMTSkNUUwVKKIcsqPZ2ifwX1D09CPD
	 hH9B70y4W51142qRr/MDhCJsU55loQcI+Zg/ZgvD97sHxbP+H6yT1A8t7fJdenrIae
	 fO2JOtkBeQ24du6PlHgeCjhQZaEzO+k3h3fiTOcL0ZRqBQUOxKwSKip/LVYR74h8Of
	 rzAmyLQv06Ivunfxd6OtvwHeVJFei5FdLDm0OhLyUaY9xbDwz5MOGYXLuZV9AhgQ8O
	 G18+4DeJezYVHqanLgPVb8kzovAtev6Ch1WihCiLv8oqnmFFZNxnI9Xkc3Q1P323Ap
	 mITI8Gk6z9KMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 5/5] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606151451.2913860-6-irogers@google.com>
References: <20260606151451.2913860-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 15:33:38 +0000
Message-Id: <20260606153339.752771F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incorrect size bounds check for config1 and config2 overwrites the=
 trailing id[] array in older (ABI0/VER0) events.
- [High] Failure to mask unsupported sample_type bits leads to parsing fail=
ures on newer perf.data formats.

Pre-existing issues:
- [High] Cross-endian `perf.data` files are corrupted during ASLR injection=
 due to mixed endianness in the synthesized `new_event` payload.
--

commit 7fad8822f4c998bf1af1ae27d27ca2449d9ecea7
Author: Ian Rogers <irogers@google.com>

perf aslr: Strip sample registers

This patch refactors the ASLR tool to strip out only the register dump
payload by masking out the relevant perf_event_attr fields when the
delegated tool is handling the data. It maintains the original
perf_event_attr values via an aslr_evsel_priv struct looked up in the
evsel_orig_attrs hashmap.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 00a54d1c7e41f..c852ade3c4e37 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -254,6 +254,12 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  				return -ENOMEM;
>  			memcpy(stripped_event, event, event->header.size);
>  			stripped_event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +			if (stripped_event->attr.attr.size >=3D
> +			    (offsetof(struct perf_event_attr, sample_regs_user) + sizeof(u64)=
))
> +				stripped_event->attr.attr.sample_regs_user =3D 0;
> +			if (stripped_event->attr.attr.size >=3D
> +			    (offsetof(struct perf_event_attr, sample_regs_intr) + sizeof(u64)=
))
> +				stripped_event->attr.attr.sample_regs_intr =3D 0;
> =20
>  			if (stripped_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT &&
>  			    event->header.size >=3D (offsetof(struct perf_record_header_attr,

[Severity: High]
Does this bounds check for config1 and config2 overwrite the trailing id[] =
array
in older (ABI0/VER0) events?

In perf_event__repipe_attr(), when clearing config1 and config2 for
kprobe/uprobe events, the size check validates against event->header.size r=
ather
than stripped_event->attr.attr.size.

In older perf records, config2 is not part of the perf_event_attr payload, =
and
the id[] array begins exactly at offset 64. However, event->header.size inc=
ludes
the size of the appended id[] array.

If an event has a 64-byte attr.size and an appended id[] array, the validat=
ion
will incorrectly pass and the code will write 0 to config2 (offset 72),
overwriting id[0]. Can this corrupt the unique event ID and break event
demuxing for downstream readers?

[ ... ]
> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 7afa5a0dac2f3..bac41bff1b2a3 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -668,6 +693,10 @@ static int aslr_tool__process_sample(const struct pe=
rf_tool *tool,
>  	u64 addr;
>  	size_t i;
>  	size_t j;
> +	struct aslr_evsel_priv *priv =3D NULL;
> +	u64 orig_sample_type;
> +	u64 orig_regs_user;
> +	u64 orig_regs_intr;
>  	bool orig_needs_swap;
> =20
>  	del_tool =3D container_of(tool, struct delegate_tool, tool);
> @@ -678,7 +707,23 @@ static int aslr_tool__process_sample(const struct pe=
rf_tool *tool,
>  		return delegate->sample(delegate, event, sample, machine);
> =20
>  	ret =3D -EFAULT;
> -	sample_type =3D evsel->core.attr.sample_type;
> +
> +	if (hashmap__find(&aslr->evsel_orig_attrs, evsel, &priv)) {
> +		orig_sample_type =3D priv->orig_sample_type;
> +		orig_regs_user =3D priv->orig_sample_regs_user;
> +		orig_regs_intr =3D priv->orig_sample_regs_intr;
> +	} else {
> +		orig_sample_type =3D evsel->core.attr.sample_type;
> +		orig_regs_user =3D evsel->core.attr.sample_regs_user;
> +		orig_regs_intr =3D evsel->core.attr.sample_regs_intr;
> +	}
> +
> +	orig_sample_size =3D evsel->sample_size;
> +
> +	sample_type =3D orig_sample_type;
> +	sample_type &=3D ~PERF_SAMPLE_REGS_USER;
> +	sample_type &=3D ~PERF_SAMPLE_REGS_INTR;
> +

[Severity: High]
Does failing to mask out unsupported sample_type bits lead to parsing failu=
res
on newer perf.data formats?

In aslr_tool__process_sample(), the sample_type used to synthesize the new
event is derived from orig_sample_type by masking out only
PERF_SAMPLE_REGS_USER and PERF_SAMPLE_REGS_INTR.

Because this fails to mask out unsupported bits (unlike the pre-patch logic
which used &=3D ASLR_SUPPORTED_SAMPLE_TYPE), and the extraction loop (COPY_=
U64)
lacks handlers for unknown/unsupported bits, they are dropped from the
new_event payload.

However, since evsel->core.attr.sample_type =3D sample_type advertises these
bits as present, the subsequent call to evsel__parse_sample() will expect to
find them in the array. Can this mismatch cause the parser to read misalign=
ed or
out-of-bounds data when processing traces from newer perf tools?

>  	max_i =3D (event->header.size - sizeof(struct perf_event_header)) / siz=
eof(__u64);
>  	max_j =3D (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header)) / s=
izeof(__u64);
>  	new_event =3D (union perf_event *)aslr->event_copy;
> @@ -727,25 +772,25 @@ static int aslr_tool__process_sample(const struct p=
erf_tool *tool,
>  		i++; \
>  	} while (0)
> =20
> -	if (sample_type & PERF_SAMPLE_IDENTIFIER)
> +	if (orig_sample_type & PERF_SAMPLE_IDENTIFIER)
>  		COPY_U64(); /* id */

[Severity: High]
This isn't a bug introduced by this patch, but can cross-endian perf.data f=
iles
be corrupted during ASLR injection due to mixed endianness in the synthesiz=
ed
new_event payload?

In aslr_tool__process_sample(), new_event is synthesized using a combination
of COPY_U64() and REMAP_U64(). COPY_U64() copies directly from the original
event->sample.array, which is in the original file's endianness (perf core
does not swap sample payloads in-place).

However, REMAP_U64() computes remapped addresses and writes them in host
endianness. For cross-endian perf.data files, this results in a corrupted,
mixed-endian payload.

Furthermore, evsel->needs_swap =3D false forces the subsequent parser and t=
he
delegated tool to treat the entire payload as host-endian, which permanently
corrupts fields like TID, TIME, and IDENTIFIER in the injected output file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606151451.2913=
860-1-irogers@google.com?part=3D5
