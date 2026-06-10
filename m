Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3502346FC4
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111417; cv=none; b=ZCyuLvlkUqPRvqhWNOWgzE0j1jVqm8DFG/8Mu5bwYt1Tc3xvTd3cp5xElt2WVLMZd5XqrRJUJ15KSN5t4VBx1ge6FwfyjbFShYxgkj4D/R7qkb0JazRIIKO574WzBjK0WcjRcn6o0OnJjZ82tOCjINSI23DFlka1Vypll52ZjIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111417; c=relaxed/simple;
	bh=e8kDSDURRci3eFwW51gURjcZprsXZYP5BlTiKTcTniI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PzXdPq8bClbkbNmjsAUOyY0c1bWE7fcSMlGVR934emTEG+83e5Q6xlquGCAFw+ClzvdkeKFLKtOquJbxFyTvwTgu3Gq27bO7IuSJjFAGkvLrJoB1HPVcD+k2PZ01bAfV3xyem5DRyYDhHzCcjkGJt/zU/xa2aGLJPHSvnHeRE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RamZeB8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RamZeB8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2FA1F00898;
	Wed, 10 Jun 2026 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111416;
	bh=0j+1bM5KaWwo1bDzvzDMk4iAyOnCF2DwhFE3yqoiK1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RamZeB8we8tTnV7Dj4G3yKNbClck8LNkEK1ME+O5kVgI/JLTJAsOBy/vPNk1kDrlv
	 6iTb4wuUUmHgYaoPVkIcNJq5w16YHhmCnFsU04tN6ynXTgjL7TwVtPqo7nkJp8g22J
	 k3ivSvGBXdruB6oj30y0LaQ3Xh1iwzVboGNXNGygdDkKpBpgoa+OsiXtO4Bwn9U/wS
	 cD+857ltjk2ykuMC0JJkn9wHdHrEVhosMzAyLgUuwdeB1RgUv7kl4jDjZrKiTeH+CV
	 D+y5ds0Mv4eNNL9jqOf2HCdjpImgno6Vk0oQtFIP4jC5II0pdgSFBeVBUmZhMxIJxq
	 zvWqmflH1nEgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] perf tools: Add O_CLOEXEC to open() calls in DSO
 and ELF code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610165207.2077258-8-acme@kernel.org>
References: <20260610165207.2077258-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:10:15 +0000
Message-Id: <20260610171016.4D2FA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Incomplete fix for file descriptor leaks to child processes (O_C=
LOEXEC missed for mkstemp).
--

commit d5ad19894a39e26303c73d34d537bede2c1838e4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code

This commit adds the O_CLOEXEC flag to open() calls in dso.c and symbol-elf=
.c.
This aims to prevent file descriptors from leaking to child processes spawn=
ed
during symbol resolution, which can exhaust the file descriptor limit.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -344,7 +344,7 @@ int filename__decompress(const char *name, char *path=
name,
>  	 * descriptor to the uncompressed file.
>  	 */
>  	if (!compressions[comp].is_compressed(name))
> -		return open(name, O_RDONLY);
> +		return open(name, O_RDONLY | O_CLOEXEC);
> =20
>  	fd =3D mkstemp(tmpbuf);

[Severity: Medium]
This isn't a bug introduced by this patch, but since the goal is to prevent
file descriptor leaks, doesn't mkstemp() also leave the file descriptor
without the O_CLOEXEC flag?

If the file is compressed, the returned decompressed file descriptor might
still leak to child processes. Could mkstemp(tmpbuf) be changed to
mkostemp(tmpbuf, O_CLOEXEC) to fully close the leak?

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
[ ... ]
> @@ -1985,7 +1985,7 @@ static int kcore__init(struct kcore *kcore, char *f=
ilename, int elfclass,
>  	if (temp)
>  		kcore->fd =3D mkstemp(filename);
>  	else
> -		kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL, 0400);
> +		kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, =
0400);

[Severity: Medium]
This is a pre-existing issue, but updating only the open() call creates an
inconsistency between the temp and non-temp paths. Will temporary kcore file
descriptors still leak to child processes when temp is true?

Additionally, looking at read_gnu_debugdata() in this same file, there is
another pre-existing mkstemp() call used for temporary files. Would it make
sense to convert all of these mkstemp() calls to mkostemp(..., O_CLOEXEC) in
this series to completely prevent file descriptor exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610165207.2077=
258-1-acme@kernel.org?part=3D7
