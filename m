Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D5B37EFFB
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860444; cv=none; b=kHMybHhzU0FXUvxemRokHXGX51R8nYPmtzFcuNEAb8RfyV9ygvCDF1QsphjFqdt5sOYCThrcy+nwnQeV3j0YbaXnwX2mFvJfb3Av45VDjhRqgKRtzPXvH2YcKWm6M2Sie1wwSiGNehf/xDv8auizL2q6/EkT0cbqMWjKJYpGGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860444; c=relaxed/simple;
	bh=MiJC62cpPG2AI81i43Fk94BR1wqQ8IcFuVLnAkI9mJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BioWE+mkZu+liAdcsS6dL1i1COlCArsS/9ouAiJmfVFf2VH7fVDvYEOLKyP+WFImoVPcRtEEcq35XFNGfquPrO51iagFk6+XEf39SIJsl3aFE6ZX0OLFxEDSC/ZhcGKNLJoVIB3iPcdxBbCBT5HWo5IDs7GT+OBcnoYnG3ZSAKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tste+tZi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tste+tZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C933C19421;
	Fri, 10 Apr 2026 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775860444;
	bh=MiJC62cpPG2AI81i43Fk94BR1wqQ8IcFuVLnAkI9mJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tste+tZiCR7FcnqUODq0mnJc/w4MM2DUhkBGtOkDq/Ed0GJM3evTdi/lTEJPIcWIS
	 whNRe9MUBRA9aQXZ23sQ6QQCk+HrkdScxIAy8RmYYylXmn3SxlsZLJk3Afqbo0UFbZ
	 wqge0IX/QRCPDoQ57fJse7k0RHS7PmtHu4KY5CUGgK/e4O5m3ZkLeYk6ACUZRmG4g7
	 4uktuZQ8C8fd3mjWCRE/PzRM2Ib1Q8on6i1e1KGQfL2z+xKWqy2mX1cAEJctmu2jPA
	 27ue7nIq4GsEGiC/EEH+mbxd5r5CTC+1THvbs+L1YpHsJ2RfuiMwC6PIvdki/gP0Zg
	 vhSREsjqagenw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] perf header: Bump up the max number of command
 line args allowed
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410220905.200051-3-acme@kernel.org>
References: <20260410220905.200051-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 22:34:04 +0000
Message-Id: <20260410223404.8C933C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Heap buffer overflow in process_cmdline due to unvalidated section=
 size.
- [High] Out-of-bounds heap read and write due to missing null-termination =
in do_read_string.
--

commit 9eedbd20bb926c7a91d560c07ac34934b0d810bb
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Bump up the max number of command line args allowed

This commit increases the arbitrary maximum limit of command line arguments
allowed when processing perf headers to accommodate wildcard expansions.

Link: https://sashiko.dev/#/patchset/20260408172846.96360-1-acme%40kernel.o=
rg

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2795,8 +2795,11 @@ process_event_desc(struct feat_fd *ff, void *data =
__maybe_unused)

[ ... ]

> -// Some reasonable arbitrary max for the number of command line arguments
> -#define MAX_CMDLINE_NR 32768
> +/*
> + * Some arbitrary max for the number of command line arguments,
> + * Wildcards can expand and end up with tons of command line args.
> + */
> +#define MAX_CMDLINE_NR 1048576
> =20
>  static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
>  {
>  	struct perf_env *env =3D &ff->ph->env;
>  	char *str, *cmdline =3D NULL, **argv =3D NULL;
>  	u32 nr, i, len =3D 0;
> =20
>  	if (do_read_u32(ff, &nr))
>  		return -1;
> =20
>  	if (nr > MAX_CMDLINE_NR)
>  		return -1;
> =20
>  	env->nr_cmdline =3D nr;
> =20
>  	cmdline =3D zalloc(ff->size + nr + 1);

This isn't a bug introduced by this commit, but could this allocation allow=
 a
heap buffer overflow when parsing an untrusted perf.data file?

The buffer size relies on ff->size, which originates from the attacker
controlled section->size in the file header. If do_read_string() reads from
the file descriptor without enforcing that the bytes read stay within
ff->size, could an attacker set a tiny section->size to force a small
allocation, but provide large strings in the payload?

If so, the subsequent memcpy(argv[i], str, strlen(str) + 1) in
process_cmdline() could write unbounded data past the end of the cmdline
buffer.

Additionally, does do_read_string() guarantee null termination for the
strings it reads?

If the payload lacks a null byte and do_read_string() leaves the buffer
unterminated, calling strlen(str) on the result could scan out of bounds
into adjacent heap memory until it finds a null byte. The subsequent memcpy=
()
would then copy this out of bounds data into the cmdline buffer, resulting
in an out of bounds write.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410220905.2000=
51-1-acme@kernel.org?part=3D2
