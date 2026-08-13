Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A87489890
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634660; cv=none; b=WAslrz4qqvVfldlYadPfb5oJ0LQ/vl7CeV84yVvJdkuN1X7efdlyHkJh4pWAMZrj7agUe/e1ud5QHeVSUw8KGpz/gyUMgD8zWF+GeJIybZ9VErsEu61q3lw+ZcvpxwobqT1naeKBbfHlI+UOVPrw2b8t2LnHPM0qGEz3OPJNUqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634660; c=relaxed/simple;
	bh=kzU0OaNL/84ht/klnDZEcjcoaJLtDXPY/GzLbDsVpGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TEDLCgSWdNNSz1FWPwpiQqrLChFBpCyOHUY/1POhPOWyrc8eK4rzKu33ofpTGS6YUMj+fdyrBwAQRAfUyZWzam6gFb22nvlkV2nkRt4ej6XB/+24u5reXIFVGpRo9KmT79zG+BD1R95POhcHLS/OPotbKSGP8Q7UMt7snxNhQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj69JL91; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj69JL91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D7C1F000E9;
	Thu, 13 Aug 2026 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634658;
	bh=dk/fUGIAV1BWza/cFQEVBwxxuvw9HxxLTWLYx2VRYlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rj69JL91xMSiG/LuRC9vMiFtp2WhYYTZ7mZTRc4abje53cu81BSWdfomiOofAVoGR
	 nRL9MNKnJKJCP07NKy94qmOHiuk62P4CpVXoagEfWF9oSzSbLlq1hPXfGwnnxAZwWm
	 o2nVlyPeHRKRKJ15cAk0ZNlC8gVud0ZL4OuiwPB9F7UVyteFyWRdM8epsnRWyUU+yN
	 tKcveksBwVwwGN8CAHLv4pjw6KqqNho1MzFsmpoivzrDSObEGSNs6JnEBwGOsWY8y1
	 at1S//j6HSzFmgVj6E6PoSLP3t31BBByL5uB/l1F2Za+M6lXoADpkQFHkvwFnxO2bw
	 +iCcr61NgGc5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf dso: Guard against errno==0 when
 dso__get_filename() returns NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813151148.23169-2-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
 <20260813151148.23169-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:24:17 +0000
Message-Id: <20260813152418.77D7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> __open_dso() computes fd =3D -errno when dso__get_filename() returns NULL.
> Some failure paths in dso__get_filename() (e.g. binary type mismatch)
> return NULL without making a syscall, leaving errno at 0 from a prior
> successful call.  fd =3D -0 =3D 0, which is stdin =E2=80=94 subsequent co=
de treats
> it as a valid file descriptor.
>=20
> Fall back to ENOENT when errno is 0, ensuring fd is always negative on
> failure.
>=20
> The forced ENOENT stays in errno for the callers that check it after a
> negative fd.  It must not misdirect the try_to_open_dso() fallback
> loop, though: dso__get_filename()'s chroot fallback used to accept a
> stale ENOENT even when stat() succeeded on a non-regular file (e.g. a
> directory).  Re-stat() there and only take the chroot path when
> stat() actually failed with ENOENT [sashiko-bot review of PATCH 1/5].
>=20
> Fixes: eba5102d2f0b ("perf tools: Add global list of opened dso objects")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813151148.2316=
9-1-acme@kernel.org?part=3D1

