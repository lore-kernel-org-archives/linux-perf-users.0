Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D759405C40
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304020; cv=none; b=CgXuvcIC6Pxpv3Mf9OFP4+p76owLzR7oe5MxlrVeT0DB0DkChcqKAS/m2hMCg1Xk0KwTE996kD0JOEZkjRaCYhPnbzwRvTmXvl6ZKvcUuZN69sw7bpyczfcncjPCqGpD0e13fQaME7c0672p6EAZbNi/I272jhkPkyGWe4zI2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304020; c=relaxed/simple;
	bh=YjhMEcp8jhyhcHmd6D+2n1fjOykDNPpZ4pPIFYQUUXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pk6wkleoElqgeUT13QRu290l21d1g4TSBnHezTtLLNQNogMuqtIsuh8oLzHy/0CDurliqES0cDPAYj4CdTQi0GOb3cslCO2VND3K3i3TBTYgKJ+XrmtggSs/wFFf5tjVUQ5hVA7ykWpWf8ZTckKD1YOgHsoxpP0DRcrSElu73pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5koaB6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5koaB6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFD61F000E9;
	Fri, 12 Jun 2026 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304019;
	bh=+/FFgvS3p8HZwVnsSIFIGFsr78IQdw/1j6t07KBJkJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5koaB6Lq23J+/oJOjnBfBSvJYKZXLZpaYwAitEhMAL3qO4R8V/sVCoyQNtL6M/+F
	 DGF66SQ/TRAuLFejKVgCOtEepEa9Kjn6wtHTqD0k9NHWij9mgpU3RfTqHvX9bG+Owm
	 +RUKYVM4qgm4FsXPg3EzBkSacZi2TynMN4j6VK+a0cawljJPx/PPRdNcvuYhYefv5R
	 s6id5ADb1d86oVZESAuCXAC7MCl+/vqJJEQa2ZnL0tS28ESnHBosodYOEHZyRzI/mp
	 KKeIzU8ZGNOWsKDjg4EyEkcC8i4sZ/yidGjiDxK2yn0qOEY8X9bYZ0IagD+gvLWLq7
	 LSZnfx+8a1VAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] perf dso: Set error code when open() fails on
 uncompressed fallback path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612222413.40791-6-acme@kernel.org>
References: <20260612222413.40791-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:40:18 +0000
Message-Id: <20260612224019.1EFD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Negative custom error codes leak into standard errno and cause __o=
pen_dso() to compute a positive fake file descriptor.
--

commit d095129ae47ce61267962a75bfe2602fe1eafe44
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Set error code when open() fails on uncompressed fallback path

This commit sets the error code when open() fails on the uncompressed
fallback path in filename__decompress(). It ensures the caller chain
correctly reads the populated errno instead of a stale or zero value.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 511921bd901d8..1a2fc6d18da74 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -344,9 +344,12 @@ int filename__decompress(const char *name, char *pat=
hname,
>  	 * descriptor to the uncompressed file.
>  	 */
>  	if (!compressions[comp].is_compressed(name)) {
> +		fd =3D open(name, O_RDONLY | O_CLOEXEC);
> +		if (fd < 0)
> +			*err =3D errno;
>  		if (pathname && len > 0)
>  			pathname[0] =3D '\0';
> -		return open(name, O_RDONLY | O_CLOEXEC);
> +		return fd;
>  	}
> =20
>  	fd =3D mkostemp(tmpbuf, O_CLOEXEC);

[Severity: High]
This isn't a bug introduced by this patch, but the commit message mentions
matching the error handling on the compressed path. Does that compressed
path have an issue where negative custom error codes leak into standard
errno?

If filename__decompress() sets *err to the custom enum value
DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE (which is negative),
dso__get_filename() assigns this directly into standard errno:

tools/perf/util/dso.c:dso__get_filename() {
    ...
    errno =3D *dso__load_errno(dso);
    ...
}

Then __open_dso() handles the failure by calculating fd =3D -errno:

tools/perf/util/dso.c:__open_dso() {
    ...
    fd =3D -errno;
    ...
}

Could this double-negate the custom error code into a positive file
descriptor value (like 9996)?

If open_dso() then incorrectly believes it successfully opened the DSO
because fd >=3D 0, could it cache this as the active file descriptor?
This might cause close_data_fd() to later close an arbitrary file
descriptor used by another subsystem when perf cleans up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612222413.4079=
1-1-acme@kernel.org?part=3D5
