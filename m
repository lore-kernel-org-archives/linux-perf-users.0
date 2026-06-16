Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1723AB88
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639057; cv=none; b=FTiF+LC5aXjY+Lq5GOqFwpzZ5nsvQxNpyAvcO2MTDAyXkj8LizyXdSbObx9zraO67F6yDKY/bOohmglSxa9hJjU/f0NIGYTYCJW1/k/GVj2U1Du/TWlA2lpkIwYPQKduDqMULVFrpq+QBI/ZnurZ9OMRCKA0S5I4B+/z0O/TLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639057; c=relaxed/simple;
	bh=CykSBiwqnDAkzMQ8QH/oCz8YSN8Sy1xGOQH457YP77k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LTjxs1B8XZQ4c1rw+jXxQMnPrDJR0FQlUBu71F1CRZtYEiAktz3czUvZ02Hs10PhLEyoLEItwN1FYYs36lPulORiOtyGjiu/1LW/wLgG+368Pdohsldz4eoF+LMbpMtxNGsnS5NQiv6Cr1IOvDriBPJhjKPMzJY6gs/jWNQIGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZjx0U4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZjx0U4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0111B1F000E9;
	Tue, 16 Jun 2026 19:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639056;
	bh=kvFNWfywzbtUE/roJBvNk978zPNQy8DGvu7/pYKz+lE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UZjx0U4LF1sxCVWQJHCoFBh3eFyS6uYUX/dDYDtKOjBHx2ezCFgorS9fLAiLn70si
	 ylTzcILThuGFb+sxVYyMbN2GrI6nH9mVHtKTQ2JA7sFXRp2nvF1E1RL174SgSJQCv0
	 c32injRKpL17xS9JvnJHMhJrZ35aNecdGU71i8qfLNdc6BHI2PtxqBOkT0kTGJd8l7
	 OCeZQDIm8GKmPU7omIs0qoeeGm1CwMSTny/WXQ5v7yHV3dSdA3ZBjghnP6JP7+xPct
	 wLpClOTG5PR2mLvd5sSuhQwpv+c0QFFsSt0Hbe8sngVJzU2KoRS2YAb32+OjSOdrJr
	 nDeXbhUgxwMCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] perf dso: Set standard errno on decompression
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616193033.10035-10-acme@kernel.org>
References: <20260616193033.10035-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:44:15 +0000
Message-Id: <20260616194416.0111B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `dso__get_filename()` can fail and return `NULL` without setting `=
errno` to a non-zero value, leading `__open_dso()` to mistakenly treat the =
error as success or yield an invalid state (like caching `stdin` as a DSO f=
ile descriptor).
- [Low] `close()` is called unconditionally on a potentially negative file =
descriptor in `dso__decompress_kmodule_path()`.
--

commit 0a5c1c7faf0a0df19aeca89ce7afb8679748c9b8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Set standard errno on decompression failure

The commit fixes an issue where a negative custom error value was used
to set errno on decompression failure. This caused the caller to compute
a valid-looking positive file descriptor, which could lead to closing
unrelated file descriptors.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 79f1a30f3683d..2309196d8df31 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -600,7 +600,13 @@ static char *dso__get_filename(struct dso *dso, cons=
t char *root_dir,
>  		size_t len =3D sizeof(newpath);
> =20

[Severity: High]
This is a pre-existing issue, but since __open_dso() relies on errno to
compute the file descriptor when dso__get_filename() fails:

tools/perf/util/dso.c:__open_dso() {
...
    if (name)
        fd =3D do_open(name);
    else
        fd =3D -errno;
...
}

Does dso__get_filename() always set errno when returning NULL?

Earlier in dso__get_filename(), if dso__read_binary_type_filename()
returns -1, it jumps to the out label and returns NULL, but errno might
remain 0. If errno is 0, __open_dso() computes fd =3D -0, which is standard
input.

Could this cause the tool to mistakenly cache stdin as the DSO data file
descriptor and later unintentionally close it when it reaches the open file
limit?

>  		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {

[Severity: Low]
This isn't a bug introduced by this patch, but does
dso__decompress_kmodule_path() handle negative file descriptors correctly?

If the kernel module doesn't need decompression, decompress_kmodule()
returns -1:

tools/perf/util/dso.c:dso__decompress_kmodule_path() {
...
    int fd =3D decompress_kmodule(dso, name, pathname, len);

    close(fd);
...
}

Calling close(-1) will fail and set errno to EBADF. Could this clobber the
errno value unnecessarily?

> -			errno =3D *dso__load_errno(dso);
> +			/*
> +			 * Use a standard errno value, not the negative custom
> +			 * DSO_LOAD_ERRNO stored in dso__load_errno(dso):
> +			 * __open_dso() computes fd =3D -errno, so a negative
> +			 * errno produces a positive fd that looks valid.
> +			 */
> +			errno =3D EIO;
>  			goto out;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616193033.1003=
5-1-acme@kernel.org?part=3D9
