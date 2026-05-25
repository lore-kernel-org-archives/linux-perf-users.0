Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B58246778
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673294; cv=none; b=SUC6zEBX6xk0eCbP6Du/OApZt4GPKojwmkXWGQ9BrmiXHLU2DAFuEermGiPm8le9Y+h4AZrDTrjNO8ViCEh44M5B7MrJRy6zNNAO+AHjZ84ZQph7KmtRFtDgMFEv1wMUM+wkxfR36S/X55HpRnTf7hE5dEhi7r3C93ZZjHHHYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673294; c=relaxed/simple;
	bh=zNYgH24w11c2GXbKQsoGihG7IK8vpB9CrKH85ZAZids=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFsagCXBpWgqnt4ypo+/dwWjXZLd9L9MfH2OSYCpLUrbcxPZNWHmK5HEjb3vRzkV+B10ra6ZFmLv0yKEEWqRYT+/WfHp0aqdcEv/qWi9FlVyouIt4HX8kNuWOZheOWYWk6tCsTYY4+THYQHN5vwoL5hkMkSLwjGkwhnV/1tUKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxvHZ2sl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxvHZ2sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752901F000E9;
	Mon, 25 May 2026 01:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779673292;
	bh=/JUeWIfuUTP4RDWbzm0VKGr9tz90tsGWyBwTQj0Jcc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxvHZ2slenNOXzwiv7/iwPyPyHZXXRJXqkiybH582HHpGZ3aakPhMEaQVL3Rr8H0W
	 cNqaSoVYE8lpJxEz+emjtVpX6F6+9KOwlJcRygidDMSFZuTs52raFIkhPl0Jpl4jb1
	 B1VzxKZE49eG6KgLL+xTdsKREjoig2SO63/IMVdKKWZhBnAk4ZejfXuK/PbRQZERbl
	 VikPFo+KEVamJ57mxrZZqBi+cRjM5sSoL8An22W/CnX5opRjKTsaJR/wZTWalcGo4I
	 iWIvIgCtvrVtpgm2n1e6azVrd6CrmFwzRufcrhueufpZ44GV0UkbclHNIQlzHYpwdY
	 qDX5gEN6wjl0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/29] perf session: Bounds-check one_mmap event pointer
 in peek_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260525010550.1100375-3-acme@kernel.org>
References: <20260525010550.1100375-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 01:41:32 +0000
Message-Id: <20260525014132.752901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The calculation of `session->one_mmap_size` is vulnerable to integ=
er underflow and lacks physical file size validation, allowing attackers to=
 bypass the new bounds checks and trigger a crash.
- [High] The newly added bounds check is vulnerable to a TOCTOU race condit=
ion because it reads `event->header.size` directly from a `MAP_SHARED` memo=
ry mapping without caching the value.

Pre-existing issues:
- [High] The patch fixes an out-of-bounds pointer calculation in `perf_sess=
ion__peek_event()` when `one_mmap` is used, but misses an identical unvalid=
ated pointer calculation in `auxtrace_queues__add_buffer()`.
--

commit d7ee9e1cc395f66a07488630068264ff3c40712f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Bounds-check one_mmap event pointer in peek_event

This commit adds bounds checking to perf_session__peek_event() when one_mmap
is active. It adds one_mmap_size to the session struct and ensures both the
header and the full event fit within the mapped region to prevent
out-of-bounds reads.

[Severity: High]
This is a pre-existing issue, but looking at tools/perf/util/auxtrace.c
in auxtrace_queues__add_buffer(), there appears to be an identical unvalida=
ted
pointer calculation:

buffer->data =3D buffer->data_offset - session->one_mmap_offset +
               session->one_mmap_addr;

Since buffer->data_offset originates from the untrusted perf.data file,
could an attacker provide a manipulated AUX trace event offset to yield an
out-of-bounds pointer, leading to an out-of-bounds memory read?

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0523fd243e02c..c4cd8ad6d810a 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1887,12 +1887,27 @@ int perf_session__peek_event(struct perf_session =
*session, off_t file_offset,
>  	*event_ptr =3D NULL;
> =20
>  	if (session->one_mmap && !session->header.needs_swap) {
> -		event =3D file_offset - session->one_mmap_offset +
> -			session->one_mmap_addr;
> +		u64 offset_in_mmap;
> +
> +		/* Validate offset with integer arithmetic to avoid pointer UB */
> +		if ((u64)file_offset < session->one_mmap_offset)
> +			return -1;
> +
> +		offset_in_mmap =3D (u64)file_offset - session->one_mmap_offset;
> +
> +		/* Use subtraction to avoid addition overflow */
> +		if (offset_in_mmap >=3D session->one_mmap_size ||
> +		    session->one_mmap_size - offset_in_mmap < sizeof(struct perf_event=
_header))
> +			return -1;
> +
> +		event =3D session->one_mmap_addr + offset_in_mmap;
> =20
> -		/* Every event must at least contain its own header */
>  		if (event->header.size < sizeof(struct perf_event_header))
>  			return -1;
> +
> +		/* Ensure full event is within the mmap region */
> +		if (session->one_mmap_size - offset_in_mmap < event->header.size)
> +			return -1;

[Severity: High]
Does this introduce a time-of-check to time-of-use race condition?

Since the event structure is located in a MAP_SHARED memory mapping, the va=
lue
of event->header.size is read directly from memory and could be modified by=
 a
concurrent attacker after this bounds check passes.

If the caller later re-reads the tampered event->header.size from memory,
could it allow the offset to advance out of bounds?

[ ... ]

> @@ -2560,6 +2575,14 @@ reader__mmap(struct reader *rd, struct perf_sessio=
n *session)
>  	if (session->one_mmap) {
>  		session->one_mmap_addr =3D buf;
>  		session->one_mmap_offset =3D rd->file_offset;
> +		/*
> +		 * mmap_size was set to the full file extent (data_offset +
> +		 * data_size) but file_offset was shifted forward by
> +		 * page_offset for page alignment.  Reduce by page_offset
> +		 * so the bounds check reflects the file-backed portion
> +		 * of the mapping =E2=80=94 pages beyond the file cause SIGBUS.
> +		 */
> +		session->one_mmap_size =3D rd->mmap_size - page_offset;

[Severity: High]
Is this calculation vulnerable to an integer underflow?

If rd->mmap_size is derived from an unvalidated data_size + data_offset, and
this addition overflows to a value smaller than page_offset, the subtraction
could result in a huge one_mmap_size that bypasses the new bounds checks.

Additionally, since rd->mmap_size relies on the untrusted data_size from the
file header rather than the physical file size, could an attacker specify a
32MB data_size for a 4KB file? The bounds check might pass, but accessing
unbacked pages would trigger a SIGBUS.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525010550.1100=
375-1-acme@kernel.org?part=3D2
