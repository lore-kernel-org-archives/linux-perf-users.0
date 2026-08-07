Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D43ED5DA;
	Fri,  7 Aug 2026 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088001; cv=none; b=CvJTXnDk4fFbKqoVexTVXr7eCADT+K1VIOhusW+jElsoZXdMDtuxkjRv7Z5/YrAoCnLj8kQI4MvOEPxqylJ9VbGA7bBgQDbSaNkXlbA1MzDKFz6pMLz8R36qCeorUenZBsXDEc9rSWmosFw8SGss9PFzaPTOHGTq7WFYuU0MYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088001; c=relaxed/simple;
	bh=kXGhDHvO9lwE1X8LtF7PXYh4XUcrpLYHM0VU0AHwwrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RqL/7tMIJsyiafwVNoHgepzQpAa1Qp29vnd+giIAAUx8faUYUm0UwC7dcZDa3lvv7aOZhaRZ4tHj/Oszvr99Vo4UiOEY4j9mkqYb4DDXYh5OrUHJ+FYLmtRSTXf6n3Qt9ue3Xpd8cIt9e0F4LAba+xr5qJjuExSuHFudvwe3PnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW3BCoXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW3BCoXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21811F000E9;
	Fri,  7 Aug 2026 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786087991;
	bh=wN6tBp2ugBmbFKIXm6J0w1s98rIeTKiaXL+EFTHVLSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KW3BCoXwXGFN49kfNwjJXbm3O4wPW9nWTo2m9T9no18YDf9xdttt1pZGwPSnrqH8K
	 MeexDqp9dKBrL2+cNx/RqnCnlIliKA4fSIoCPJPRvdotK6Xpxc/GurfNlsMr03lmYQ
	 XnNrT6Fi/q7aokYAaAgNGLnRJ8eecuPDp4Ts5QkdfZ0nRMuIXrJmvn+pI9ifqVaTNw
	 T/jnPr5B5NOjbp5z48kvD4bzT7HhCryo4gMm20WHsCaVr6bWtybfc/NTD+q6XdtdxB
	 K9qQsVNNLXIeU+MGKU+9+3AosppGf2w57R9+EvCJpla/rtRQDyYgrrWY1GN+tCoRox
	 5I2PmU09WPoxA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 1/8] perf event: Factor build_id out into its own
 top-level struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807071818.718751-2-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 07:33:11 +0000
Message-Id: <20260807073311.A21811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional zeroing of build ID fields clobbers valid fallback i=
dentifiers (`maj`, `min`, `ino`), breaking symbol resolution.
- [High] Typo in bounds check writes to the wrong union member, corrupting =
`pgoff` and failing to clamp the build ID size.
- [Low] Modifying a tooling UAPI header without syncing the main kernel UAP=
I header breaks build checks.
--

--- Patch [1]: [RFC PATCH v1 1/8] perf event: Factor build_id out into its =
own top-level struct ---
commit 52b0cf61920b265e87e7e98a009860673a5711f3
Author: Ian Rogers <irogers@google.com>

perf event: Factor build_id out into its own top-level struct

This commit factors out the inline build_id struct into its own type,
struct perf_build_id, and updates various contexts to use this new
consistent type.

> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index fd10aa8d697f2..2479a38883d00 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1058,6 +1058,18 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_SAMPLE			=3D 9,
> =20

[Severity: Low]
Does modifying this tooling UAPI header without also updating the main kern=
el
UAPI header in include/uapi/linux/perf_event.h break the check-headers.sh
build scripts?

> +	/*
> +	 * Build IDs may be present in a number of events. They have a
> +	 * consistent encoding of:
> +	 *
> +	 * struct build_id {
> +	 *	u8		size;
> +	 *	u8		__reserved_1;
> +	 *	u16		__reserved_2;
> +	 *	u8		data[20];
> +	 * };
> +	 */

[ ... ]

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 75a32ae8ef623..f7dedfb6bab87 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -478,16 +478,20 @@ static void perf_record_mmap2__read_build_id(struct=
 perf_record_mmap2 *event,
>  	nsinfo__put(nsi);
> =20
>  out:
> +	event->build_id.__reserved_1 =3D 0;
> +	event->build_id.__reserved_2 =3D 0;

[Severity: High]
Since struct perf_build_id is part of an anonymous union that overlaps with
the maj, min, and ino fields in struct perf_record_mmap2, do these
unconditional assignments corrupt the previously parsed fallback metadata
for binaries lacking a build ID?

>  	if (rc =3D=3D 0) {
> -		memcpy(event->build_id, bid.data, sizeof(bid.data));
> -		event->build_id_size =3D (u8) bid.size;
> +		memcpy(event->build_id.data, bid.data, sizeof(bid.data));
> +		event->build_id.size =3D (u8) bid.size;
>  		event->header.misc |=3D PERF_RECORD_MISC_MMAP_BUILD_ID;
> -		event->__reserved_1 =3D 0;
> -		event->__reserved_2 =3D 0;
> =20
>  		if (dso && !dso__has_build_id(dso))
>  			dso__set_build_id(dso, &bid);
>  	} else {
> +		memset(&event->build_id, 0, sizeof(event->build_id));

[Severity: High]
Can this memset destroy the valid maj, min, and ino identifiers when
perf_record_mmap2__read_build_id() fails to read a build ID?

> +		event->build_id.size =3D 0;
> +		event->header.misc &=3D ~PERF_RECORD_MISC_MMAP_BUILD_ID;
> +
>  		if (event->filename[0] =3D=3D '/') {
>  			pr_debug2("Failed to read build ID for %s\n",
>  				  event->filename);

[ ... ]

> @@ -2486,10 +2492,10 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
>  	ev.mmap2.len =3D len;
>  	ev.mmap2.pgoff =3D pgoff;
> =20
> -	ev.mmap2.build_id_size =3D bid->size;
> -	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
> -		ev.mmap2.build_id_size =3D sizeof(ev.mmap2.build_id);
> -	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
> +	ev.mmap2.build_id.size =3D bid->size;
> +	if (ev.mmap2.build_id.size > sizeof(ev.mmap2.build_id.data))
> +		ev.build_id.size =3D sizeof(ev.mmap2.build_id.data);

[Severity: High]
Is it possible this writes to ev.build_id.size instead of
ev.mmap2.build_id.size, accidentally modifying the pgoff field of
struct perf_record_mmap2 while leaving ev.mmap2.build_id.size unclamped
for the memcpy below?

> +	memcpy(ev.mmap2.build_id.data, bid->data, ev.mmap2.build_id.size);
> =20
>  	ev.mmap2.prot =3D prot;
>  	ev.mmap2.flags =3D flags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D1
