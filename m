Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4817555
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329049; cv=none; b=dP9biZvGwyK6mvDpuscahGv+YXCpQ2Xb5WuNb4zDOzzgdr7NMDySyf+Ot5U4hOFjqpoX+dEGxtRwkSWyJA4U5ZYXu0YUd6zYuS8O+8RIjZZYoy7YE61+dq2T7nlG+GT8aW0f2r845vLXO9DYo2B8fR6QS6kBA39jxwCeSGRnZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329049; c=relaxed/simple;
	bh=VqGJUur/EQPL8trw764Kkzi6nA3iImbyq+GYYTJJVXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=thAhU7QXZXk+09ek2kh6Cjc7hW/7qCnbPNEYhwPd3xWXhDCnsLjpNv4FfsNoy+sMN2PWV/RgvCgq9uPBe/xdIN0/72IyJDSM8Mg3wPbun6z6Jmw8RM2xoYyzqIgTsdz0CPsqhnw1Z4fADd/DJy/3pOenat6QwOhZ265SNslcigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7Ez/3Qh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7Ez/3Qh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A81F000E9;
	Thu, 21 May 2026 02:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329048;
	bh=xDPYsN2LOxOigD7/ytMC7iJtSZzAWx/0c0rXE7X+LF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7Ez/3QhDYLyix/A33id5pIgJp2hpEKoY41SwEijwl5Hy48Q2BV/Ame+9oPNDUzVt
	 4tTWQsW+5cCKCptAmuwufx2Pj5dEp6+PNSaBKU8fHph16TXhZqfHKoYD3Obtk4JOkq
	 XmD0H2dKQr+w3fXhNOM8xSL6ldGFPqxDCVmtsv3aWkSiLssnrEHn+0mFlO2qwFHk4j
	 ayxAAY3x+purh8+CCCbAJ9NOTJQ+8MmPfSSEKsDQ/lWcw++tvehUy8WcQST96XnEZg
	 bi5LA6dx2c/5Nu2hS8LadlZvRCS89qWYhb1G/mdGPjLWLY6mV3MSmjkGwIe1hbOnX5
	 PI0KjDfflBoig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/27] perf session: Validate HEADER_ATTR attr.size
 before swapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-10-acme@kernel.org>
References: <20260521011027.622268-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 02:04:07 +0000
Message-Id: <20260521020407.DA3A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) vulnerability allows b=
ypassing the new `attr.size` validation for foreign-endian files.
- [Critical] A 32-bit integer overflow in `nr_ids` calculation leads to a h=
eap buffer overflow in `perf_evsel__alloc_id()`.
- [High] ABI0 pipe events cause zero-length copies and ID array miscalculat=
ions in `perf_event__repipe_attr()`.
--

commit 705d678c5ac3163affe4c2f837e830af1d98f4b7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
perf session: Validate HEADER_ATTR attr.size before swapping

This commit hardens PERF_RECORD_HEADER_ATTR handling against crafted
perf.data files by validating attr.size before swapping. It also ensures
only min(attr.size, sizeof(struct perf_event_attr)) bytes are copied into
a local attr and fixes ABI0 pipe/inject events handling.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc32..967c3d8ff12c8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -4770,9 +4770,15 @@ static int read_attr(int fd, struct perf_header *p=
h,
[ ... ]
>  	/* read perf_file_section, ids are read in caller */
>  	ret =3D readn(fd, &f_attr->ids, sizeof(f_attr->ids));
> +	if (ret <=3D 0) {
> +		if (ret =3D=3D 0)
> +			errno =3D EIO;
> +		return -1;
> +	}
> =20
> -	return ret <=3D 0 ? -1 : 0;
> +	return 0;
>  }

[Severity: Critical]
This is a pre-existing issue, but does reading f_attr.ids.size here allow an
integer overflow later?

When processing a regular perf.data file, read_attr() reads the
attacker-controlled f_attr.ids.size. In perf_session__read_header(), this is
divided by 8 to compute nr_ids (an int).

If f_attr.ids.size is e.g. 0x100000008, nr_ids becomes 0x20000001.
perf_evsel__alloc_id() allocates memory based on
ncpus * nthreads * sizeof(u64) (1 * 0x20000001 * 8).

On 32-bit platforms where size_t is 32 bits, this multiplication overflows,
resulting in an 8-byte allocation. The subsequent loop:

for (j =3D 0; j < nr_ids; j++)

will execute 0x20000001 times, writing attacker-controlled IDs out-of-bounds
onto the heap until EOF is reached.

[ ... ]
> @@ -5108,13 +5155,46 @@ int perf_event__process_attr(const struct perf_to=
ol *tool __maybe_unused,
[ ... ]
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

[Severity: High]
This isn't a bug introduced by this patch, but does the failure to update
event->attr.attr.size cause issues in perf_event__repipe_attr()?

While the patch fixed perf_event__process_attr() to handle ABI0 events
without mutating event->attr.attr.size, perf_event__repipe_attr() appears
to be neglected.

Because event->attr.attr.size remains 0 for native-endian ABI0 events,
perf_event__repipe_attr() performs a zero-byte memcpy(), miscalculates n_ids
to encompass the entire payload, and computes an ID array offset of 0.

Could this corrupt the perf inject output by reading the first 64 bytes of
the attribute structure as ID array elements?

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index d14d8055b2d10..e45d51e898a8e 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -613,8 +613,39 @@ do { 						\
>  static int perf_event__hdr_attr_swap(union perf_event *event,
>  				     bool sample_id_all __maybe_unused)
>  {
> +	u32 attr_size, payload_size;
>  	size_t size;
> =20
> +	/*
> +	 * Validate attr.size (still foreign-endian) before calling
> +	 * perf_event__attr_swap(), which uses it via bswap_safe()
> +	 * to decide which fields to swap.  A crafted attr.size
> +	 * larger than the event payload would swap past the event
> +	 * boundary and corrupt adjacent memory.
> +	 *
> +	 * header.size alignment is already validated by
> +	 * perf_session__process_event().  The min_size table
> +	 * guarantees header.size >=3D sizeof(header) +
> +	 * PERF_ATTR_SIZE_VER0, so attr.size is safe to access.
> +	 */
> +	attr_size =3D bswap_32(event->attr.attr.size);

[Severity: Critical]
This is a pre-existing issue, but does validating event->attr.attr.size here
leave a Time-of-Check to Time-of-Use (TOCTOU) vulnerability?

When processing foreign-endian perf.data files, the file is mapped with
MAP_PRIVATE. If an attacker crafts an event such that its 8-byte header is
at the end of a page and the attr payload begins on the next page,
fetch_mmaped_event() will swap the header, triggering a Copy-On-Write (COW)
on the first page only.

The second page remains shared. perf_event__hdr_attr_swap() then validates
event->attr.attr.size from the shared page.

Next, perf_event__attr_swap() writes to attr->type (triggering COW on the
second page) and reads attr->size again. If the attacker concurrently
modifies attr.size in the file after validation but before the COW, the new
malicious size is copied into the private page and used, leading to an
out-of-bounds memory swap and memory corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D9
