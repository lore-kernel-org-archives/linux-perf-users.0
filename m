Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEC234964
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328760; cv=none; b=Oi2J+v1xIu8okAC3TGrmumHKUmopaYoNHrPdL6evWrOlVFo1GWhIGLM4zk/ocbbrboPagvSnAlaRVlejfLOZzpMdRYLUJpBq+DNt89tZEQmCGzEQ9HgCAxcjfLCqgTsTWjupPxr3IB7pnmiplO1IIM5Tn0ofEIeS0KUQrrpSnLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328760; c=relaxed/simple;
	bh=40WhuobJZRLnENdSUmMOd9EwiCUNxAcLhuGoc9Q3aEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TNGRfwArBjjdEKhYK2QiTU1UBLB6wafH2PTrYI05napy6loy4KExYBACgm3pBOnZohiO8mpiWfxHM1ZXze003egOmBqEJvKmaYtGvgDvXBWQ141wK60oRscSddQSUxg6Va0optbXbDgIgXT7GW1i+DnK3Qzf7le8w7tvdTwse28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmKIXR0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmKIXR0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702051F000E9;
	Thu, 21 May 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328759;
	bh=4ILdTl4FEgPMWFHG17mTI+aD5URecv0PudyOHETgBPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmKIXR0OAZL91UiAGUOAL6zunzuuuxScr4X/XXh3BVPRwFFOob/Rq4WwZfRjr8W8B
	 Ykp1yQ4eWiSbmzsCMp980VMBn1bj4WZg/GqVLne1KQ6/mh5McfQVRdiSsrha1RmQR3
	 qQs5EbVInMLRZiv5LcDMopsJhl/AvnZVBm7d1OgGHjhYt8L98FcFP+xC0he8mja3rQ
	 tA+bERRYKNKZYGpWE4rsxylmz2yk3kTNhVnR0vk5WY8Zm2Kva2hY46ZY6BG4pGUP4N
	 aM6F157i3VxTdvyzgo/f4YRy1DtUmw6sOsTUNlkwks1Ch2dQayohyAAJ3LHE/WX8Er
	 ZbeUcJmyHEFqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/27] perf session: Add minimum event size and
 alignment validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-2-acme@kernel.org>
References: <20260521011027.622268-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 01:59:19 +0000
Message-Id: <20260521015919.702051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly added strict 8-byte alignment enforcement on event sizes=
 rejects valid user-space synthetic events such as `PERF_RECORD_HEADER_TRAC=
ING_DATA`, breaking tracepoint parsing.

Pre-existing issues:
- [High] `perf_session__process_event` returns `event->header.size` for unk=
nown event types, causing the stream reader to skip double the event size.
- [High] Opening files derived from untrusted mmap events lacks `O_NONBLOCK=
`, risking an indefinite hang.
--

commit 8c99bee268e0d99f0f5f5fcad6d1f258c2f4431f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add minimum event size and alignment validation

This commit adds a per-type minimum size table to enforce bounds before swap
and processing, guarding against out-of-bounds accesses. It also rejects
events with header sizes that are not 8-byte aligned.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 1e25892963b78..82ab29525a4b0 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -1759,11 +1759,102 @@ int perf_session__deliver_synth_attr_event(struc=
t perf_session *session,
>  	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
>  }
> =20
> -static void event_swap(union perf_event *event, bool sample_id_all)
> +/*
> + * Minimum event sizes indexed by type.  Checked before swap and
> + * processing so that both cross-endian and native-endian paths
> + * are protected from accessing fields past the event boundary.
> + * Zero means no minimum beyond the 8-byte header (already
> + * enforced by the reader).
> + */
> +static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] =3D {
> +	/*
> +	 * offsetof() + 1 for types with a trailing variable-length
> +	 * string (filename, comm, path, name, msg): the +1 ensures
> +	 * room for at least a null terminator.  Full null-termination
> +	 * within the event boundary is checked separately.
> +	 *
> +	 * PERF_RECORD_SAMPLE is omitted: all64_swap is bounded by
> +	 * header.size, and the internal layout varies by sample_type
> +	 * so a fixed minimum is not meaningful.
> +	 */
> +	[PERF_RECORD_MMAP]		  =3D offsetof(struct perf_record_mmap, filename) +=
 1,

[Severity: High]
This is a pre-existing issue, but does opening files derived from untrusted
mmap events without O_NONBLOCK risk an indefinite hang?

The filename__read_build_id() function in tools/perf/util/symbol-elf.c opens
paths provided by perf.data without the O_NONBLOCK flag.

Although it checks is_regular_file() before opening, could a TOCTOU race
allow an attacker to create a crafted perf.data file with a path pointing to
a regular file, and replace it with a FIFO just before open() is called?

[ ... ]
> @@ -1775,52 +1866,76 @@ int perf_session__peek_event(struct perf_session =
*session, off_t file_offset,
[ ... ]
> +	/* Kernel aligns all events to sizeof(u64); see process_event */
> +	if (event->header.size % sizeof(u64)) {
> +		pr_warning("WARNING: peek_event: %s event size %u not aligned to %zu\n=
",
> +			   perf_event__name(event->header.type),
> +			   event->header.size, sizeof(u64));
>  		return -1;
> +	}

[Severity: High]
Does this strict 8-byte alignment check break compatibility with older
perf.data files?

Legacy perf.data files generated prior to August 2025 synthesize
PERF_RECORD_HEADER_TRACING_DATA with a size of exactly 12 bytes (8-byte
header + 4-byte size), which is not 8-byte aligned.

Parsing valid legacy files containing tracepoint data seems like it will
deterministically fail here.

[ ... ]
> @@ -1858,16 +1973,29 @@ static s64 perf_session__process_event(struct per=
f_session *session,
[ ... ]
> +	if (event->header.size % sizeof(u64)) {
> +		pr_err("ERROR: %s event size %u is not 8-byte aligned, aborting\n",
> +		       perf_event__name(event->header.type),
> +		       event->header.size);
> +		return -EINVAL;
> +	}

[Severity: High]
Does this strict 8-byte alignment check break compatibility with older
perf.data files here as well, due to the PERF_RECORD_HEADER_TRACING_DATA
events that have a 12 byte size?

> =20
>  	if (event->header.type >=3D PERF_RECORD_HEADER_MAX) {
>  		/* This perf is outdated and does not support the latest event type. */
>  		ui__warning("Unsupported header type %u, please consider updating perf=
.\n",
>  			    event->header.type);
> -		return -EINVAL;
> -
> +		/* Skip unsupported event by returning its size. */
> +		return event->header.size;
>  	}

[Severity: High]
This is a pre-existing issue, but does returning event->header.size for
unknown event types cause the stream reader to skip too far?

When the caller reader__read_event() initializes size =3D event->header.size
and adds the positive return value (skip), it causes the reader to advance
by 2 * event->header.size.

Could this misalign the stream and break parsing for the rest of the file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D1
