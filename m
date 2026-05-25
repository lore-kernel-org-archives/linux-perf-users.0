Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289E2673B0
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674163; cv=none; b=oW2tPdc+epf5XTzZ34HzVrB77PvYszeJizcWpGtTobq0DvCOALBSXlPSnGHh8Dx/NcpuQSQ5s280nyKsnWuIV8ph7rQbQ7NrpaHAax1IyE2XA8f5diRcZiVlkSKV5krQK+CmjM78uAFfoAqZQg/VLpeKSTz372vlN1t/C5UgF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674163; c=relaxed/simple;
	bh=MDjfX9LOhPv5hO9uJ3fpYUcZLgv0RgzVzxv/7ufIbZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ACRwB1RKTYv0suYQ48DM1xLJmnitP0lmw9gPGJHlt+V3MnvyUFq87wyvL6D/2xjcCNJKZo1yX0JXV/xgewJUEgttpSGtjH6YCIjs8bQ8ps6iRpJtbPyoXXqekfuXOO2HtphHSl2aqKv9rtWBJZFwd7UMb7kgRcY/CaY5i7jEQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzZkKzmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzZkKzmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030951F000E9;
	Mon, 25 May 2026 01:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779674162;
	bh=k/kpGLz8yLI/d0ZhNPEaQnPBAUfVQoUMdIWQ9Q1Sim8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CzZkKzmv0yzkAQxF8XApdaEWZGWG4tZY+qv1rRo4QDLGmPXcKQCb6ggqDFESCrEDS
	 hdJEedewjapTdjA8Et66Xr3Qu/+T2+tvDKUbeKL0rIiQKQBcroqNK9xe3AcpAtjrgo
	 1ssYb85ASdpLTuYLJbpJHgiqBSi88SaCT7rWwIc5oguGzGzXM6ndP5E9uuJw3FnTGZ
	 KFvQamd89FtzzUYWHop1ET3KnCNKcoD9DVI19GoHnW8wJb83op0bP9zkrqlAQTVfMu
	 SnvW88o3R8nKJtTMvZGAYrjjc3Np33TlDJBRB0odNkF60LWyDosAWOUgP4oZrHyKPB
	 we2Zp+VNH0Lmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/29] perf session: Validate HEADER_ATTR attr.size
 before swapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-11-acme@kernel.org>
References: <20260525010550.1100375-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:56:01 +0000
Message-Id: <20260525015602.030951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Repeated reads of `event->header.size` directly from a potentially=
 shared memory-mapped buffer (`MAP_SHARED`) allow an attacker to bypass bou=
nds validation by concurrently shrinking the size after checks. This leads =
to severe integer underflows and subsequent heap buffer overflows or massiv=
e memory allocations.
--

commit 28785713230e6589c3240262dcee366a34bae636
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Validate HEADER_ATTR attr.size before swapping

Harden PERF_RECORD_HEADER_ATTR handling against crafted perf.data:

- Validate attr.size: must be >=3D PERF_ATTR_SIZE_VER0, a multiple
  of sizeof(u64), and fit within the event payload.
- Copy only min(attr.size, sizeof(struct perf_event_attr)) bytes
  into a local attr, zeroing the rest so legacy files don't leak
  adjacent event data into new fields.
- Keep the original attr.size so perf_event__synthesize_attr()
  uses it for both allocation and ID-array placement.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 41a3721a194dc..d8cb1f562f690 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -244,24 +245,34 @@ static int perf_event__repipe_attr(const struct per=
f_tool *tool,
>  	if (!inject->itrace_synth_opts.set)
>  		return perf_event__repipe_synth(tool, event);
> =20
> -	if (event->header.size < sizeof(struct perf_event_header) + sizeof(u64)=
) {
> +	if (event->header.size < sizeof(struct perf_event_header) + PERF_ATTR_S=
IZE_VER0) {
>  		pr_err("Attribute event size %u is too small\n", event->header.size);
>  		return -EINVAL;
>  	}
> =20
> -	if (event->header.size - sizeof(event->header) < event->attr.attr.size)=
 {
> +	/*
> +	 * ABI0 pipe/inject events have attr.size =3D=3D 0; default to
> +	 * PERF_ATTR_SIZE_VER0 (the ABI0 footprint) for the bounded
> +	 * copy and ID array position.  Same pattern as
> +	 * perf_event__process_attr() in header.c.
> +	 */
> +	raw_attr_size =3D event->attr.attr.size;
> +	attr_size =3D raw_attr_size ?: PERF_ATTR_SIZE_VER0;
> +
> +	if (raw_attr_size && (raw_attr_size < PERF_ATTR_SIZE_VER0 ||
> +			      raw_attr_size > event->header.size - sizeof(event->header))) {
>  		pr_err("Attribute event size %u is too small for attr.size %u\n",
> -		       event->header.size, event->attr.attr.size);
> +		       event->header.size, raw_attr_size);
>  		return -EINVAL;
>  	}
> =20
>  	memset(&attr, 0, sizeof(attr));
>  	memcpy(&attr, &event->attr.attr,
> -	       min_t(size_t, sizeof(attr), (size_t)event->attr.attr.size));
> +	       min_t(size_t, sizeof(attr), attr_size));
> =20
> -	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	n_ids =3D event->header.size - sizeof(event->header) - attr_size;

[Severity: High]
This is a pre-existing issue, but does reading event->header.size here dire=
ctly
from a potentially shared memory-mapped buffer (MAP_SHARED) allow a
time-of-check to time-of-use (TOCTOU) race?

If an attacker concurrently shrinks event->header.size after the bounds
validation checks above, this calculation can severely underflow.

The underflowed n_ids is then passed to perf_event__synthesize_attr() which,
on 32-bit architectures, wraps around during the size calculation.
This results in a small memory allocation followed by a massive memcpy(),
causing a heap buffer overflow.

Should we cache event->header.size in a local variable like we did for
raw_attr_size?

>  	n_ids /=3D sizeof(u64);
> -	ids =3D perf_record_header_attr_id(event);
> +	ids =3D (void *)&event->attr.attr + attr_size;
> =20
>  	attr.size =3D sizeof(struct perf_event_attr);
>  	attr.sample_type &=3D ~PERF_SAMPLE_AUX;

[ ... ]
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc32..967c3d8ff12c8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -5094,11 +5110,42 @@ int perf_event__process_attr(const struct perf_to=
ol *tool __maybe_unused,
>  			     union perf_event *event,
>  			     struct evlist **pevlist)
>  {
> -	u32 i, n_ids;
> +	struct perf_event_attr attr;
> +	u32 i, n_ids, raw_attr_size;
>  	u64 *ids;
> +	size_t attr_size, copy_size;
>  	struct evsel *evsel;
>  	struct evlist *evlist =3D *pevlist;
> =20
> +	/*
> +	 * HEADER_ATTR event layout (pipe/inject mode):
> +	 *
> +	 *   [header (8 bytes)] [attr (attr_size bytes)] [id0 id1 ... idN]
> +	 *   |<------------------ header.size --------------------------->|
> +	 *
> +	 * attr_size varies across perf versions: VER0 =3D 64 bytes,
> +	 * current sizeof(struct perf_event_attr) =3D larger.  A newer
> +	 * producer may emit a larger attr than we understand.
> +	 *
> +	 * attr.size =3D=3D 0 (ABI0) means the producer didn't set it
> +	 * (e.g., bench/inject-buildid, older perf).  Treat as VER0.
> +	 *
> +	 * Require 8-byte alignment so the u64 ID array is aligned
> +	 * and attr.size fits cleanly within the payload.
> +	 *
> +	 * Read attr.size once =E2=80=94 the event may be on a shared mmap
> +	 * and re-reading could yield a different value.
> +	 */
> +	raw_attr_size =3D event->attr.attr.size;
> +	if (event->header.size < sizeof(event->header) + PERF_ATTR_SIZE_VER0 ||
> +	    (raw_attr_size && (raw_attr_size < PERF_ATTR_SIZE_VER0 ||
> +			      raw_attr_size % sizeof(u64) ||
> +			      raw_attr_size > event->header.size - sizeof(event->header)))) {
> +		pr_err("PERF_RECORD_HEADER_ATTR: invalid attr.size %u (event size %u, =
min %d)\n",
> +		       raw_attr_size, event->header.size, PERF_ATTR_SIZE_VER0);
> +		return -EINVAL;
> +	}
> +
>  	if (dump_trace)
>  		perf_event__fprintf_attr(event, stdout);
> =20
> @@ -5108,13 +5155,46 @@ int perf_event__process_attr(const struct perf_to=
ol *tool __maybe_unused,
>  			return -ENOMEM;
>  	}
> =20
> -	evsel =3D evsel__new(&event->attr.attr);
> +	/*
> +	 * attr_size =3D footprint of the attr in the event =E2=80=94 determines
> +	 * where the ID array starts.  For ABI0, assume VER0 (64 bytes).
> +	 *
> +	 * copy_size =3D how much we copy into our local struct, capped at
> +	 * sizeof(attr) so a newer producer's larger attr doesn't
> +	 * overflow.  Fields beyond copy_size are zeroed.
> +	 *
> +	 * Do NOT write attr_size back to the event =E2=80=94 native-endian
> +	 * files use MAP_SHARED (read-only), writing would SIGSEGV.
> +	 * The swap path handles ABI0 in perf_event__attr_swap()
> +	 * which writes to the writable MAP_PRIVATE copy instead.
> +	 */
> +	attr_size =3D raw_attr_size ?: PERF_ATTR_SIZE_VER0;
> +	copy_size =3D min(attr_size, sizeof(attr));
> +	memcpy(&attr, &event->attr.attr, copy_size);
> +	if (copy_size < sizeof(attr))
> +		memset((void *)&attr + copy_size, 0, sizeof(attr) - copy_size);
> +
> +	/*
> +	 * Normalize ABI0: the swap path sets attr.size =3D VER0 on the
> +	 * event, but the native path leaves it as 0.  Set it on the
> +	 * local copy so perf inject re-synthesizes with consistent
> +	 * layout regardless of endianness.
> +	 */
> +	attr.size =3D attr_size;
> +
> +	evsel =3D evsel__new(&attr);
>  	if (evsel =3D=3D NULL)
>  		return -ENOMEM;
> =20
>  	evlist__add(evlist, evsel);
> =20
> -	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	/*
> +	 * IDs occupy the remainder after header + attr.  Use attr_size
> +	 * (not copy_size) =E2=80=94 even if the producer's attr is larger than
> +	 * our struct, the IDs start after attr_size bytes in the event.
> +	 * Validation above guarantees attr_size <=3D payload size.
> +	 */
> +	n_ids =3D event->header.size - sizeof(event->header) - attr_size;

[Severity: High]
This is a pre-existing issue, but can an attacker concurrently modify
event->header.size here?

Because event can point to a MAP_SHARED buffer, reading event->header.size
multiple times allows a TOCTOU race where the size is shrunk after the boun=
ds
checks.

This would cause n_ids to severely underflow, leading to a massive
memory allocation in perf_evsel__alloc_id() and out-of-bounds reads.

Could we fix this by caching event->header.size into a local variable before
performing the initial validation?

>  	n_ids =3D n_ids / sizeof(u64);
>  	/*
>  	 * We don't have the cpu and thread maps on the header, so

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D10
