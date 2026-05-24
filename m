Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89497156F45
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595436; cv=none; b=te6bnFq1gzAhmIlSd558WlHjzvDHeWW8pudMIdBOaFf36MSLWwUQbEVkqaHK6QBm1loAomXM16MOfL+l/OlPAP89tvXnWYDhbMfRkqYLZ7Sy2VHkD5/ecdwq2uKQbfZiYuRv2YSQRfj0d3vKqu5KauVZ18wYwqgX5RGHbo2cjNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595436; c=relaxed/simple;
	bh=cOZ6hYSxvUfOLWk0J5iYB1nS0D1nv1+sJHMb2JMdCtg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mKqA8GoQg0uT6b7CLQyktnln43bt/a2aDknQsvAqPtwZLj42MFaYNNiWc422WXdDdE76CzUh8yQuTo7DlHdMlliGz2jjVu4OuxxG9e4IE950QFXGKVJvQFeJ4ehwKhvWFAT0kv6BAm+dHFTzHO93zMpqx50K3qhPllA1gFELUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMJNcOOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMJNcOOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222081F000E9;
	Sun, 24 May 2026 04:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779595435;
	bh=xHK4vqBMkK4oAYHOmgdynD4xb+N/ZTWaSVt+p8QbJng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BMJNcOOH11Nc1QfZ/P2A74wj2NQup2hHjFhKEhiuaXtSKklEIoN+W8m+bJCCJpmqS
	 a3bB1aO6EEVGEzu531leeZaE37a8jIZDJ/aPW4kZIsZTk5MqiLo3jj6o9w9O79OdQJ
	 YzCE70qAFVab56zxXcY5YHNitUUAZHwm3UA0NCVjv45MM/wRF90aRkecnMtmK1IZDd
	 Z5ao92Or0UgDLm8TkcQ0quOcSLEZOkA/uAjnMd1XCiEytvxPexYcOdVa//xUTWkj7Q
	 V35vD4CqcINgt8GS5DM5h7SiQz4pVKPHNsuOJgY5rmY0lG/7us7cL6h11wNeFYjtqp
	 6ItmKZi9FZZqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/29] perf session: Bounds-check one_mmap event pointer
 in peek_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-3-acme@kernel.org>
References: <20260524032709.1080771-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:03:54 +0000
Message-Id: <20260524040355.222081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced `session->one_mmap_size` calculation can unde=
rflow, defeating the bounds check and leaving the out-of-bounds memory read=
 vulnerability exploitable.

Pre-existing issues:
- [High] The main event parsing loop in fetch_mmaped_event() remains vulner=
able to the exact same SIGBUS crash the patch attempted to fix.
- [High] The bounds check on `event->header.size` can be bypassed via concu=
rrent file modification (TOCTOU), leading to potential out-of-bounds reads =
or infinite loops.
--

commit e8e996106d544b30e283950a45bb1095c85f5114
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Bounds-check one_mmap event pointer in peek_event

This patch adds one_mmap_size to the session struct and validates that
both the header and the full event fit within the mapped region before
dereferencing. This prevents out-of-bounds memory reads on corrupted
perf.data files.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
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
This is a pre-existing issue, but can the bounds check on event->header.size
be bypassed via concurrent file modification?

Since the file is mapped using a shared mapping, this function returns a
direct pointer into shared memory. Any subsequent reads of event->header.si=
ze
by the caller perform a second fetch from that same memory.

If an attacker modifies the perf.data file concurrently after this bounds
check passes, could they change the size to a very large value or to 0,
leading to out-of-bounds reads or infinite loops in downstream callbacks?

>  	} else {
>  		if (perf_data__is_pipe(session->data))

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
Can session->one_mmap_size underflow here?

If a corrupted perf.data file header provides extremely large values for
data_offset and data_size, their sum could wrap around to a small value,
causing rd->mmap_size to be smaller than page_offset.

If this subtraction underflows, session->one_mmap_size will become a
massive value, which would bypass the new bounds checks in
perf_session__peek_event() and still allow out-of-bounds memory access.

[Severity: High]
This isn't a bug introduced by this patch, but does the main event parsing
loop in fetch_mmaped_event() remain vulnerable to this same crash?

While this patch adjusts session->one_mmap_size by page_offset to avoid
unbacked pages, it appears rd->mmap_size itself is left unadjusted.

If fetch_mmaped_event() still bounds-checks events against the unadjusted
rd->mmap_size, could a crafted file supply an event size that passes the
check but lands in the unbacked pages at the tail of the mapping, causing
a crash when rd->process() attempts to read it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D2
