Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89B3009F6
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883074; cv=none; b=fyMiybGvJz8QCDEa6zn36opoQqUD7p18cV0/mWzq1KBLgkoL8HBmaZ4+98UqfIBEt0Awo5eRBYfOd/2kVLuz62/VOJITo7mslFbRvm40MwRZXxhzgC5uF/v4Qjli3KqX0WVi68jgH3b2XYB5HhUpCYXmAyZvUs19yj5rXN5tAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883074; c=relaxed/simple;
	bh=ZYJXn+gey3VVzjlVCFIBfVNxokXqZQEMHvhC4iO3NVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HnTZT97KXOR2AA2hrW4gX/CXBqPW82l7Ocx/X1HL3zdS4zMYXylcUpdGSskdtkLIAWZzV5XfMLNanr8bSQ22DIFA4kTU5YCEUmOlLHANY6iNR91YY7uvNwjXeiDz1A+MFWXR2PAN0P/Jpd8AK1uG0qavtOpX3jd62zi3SlyyO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1robTKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1robTKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CC51F00893;
	Mon,  8 Jun 2026 01:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883072;
	bh=I5jtwlvYQ2srrqW8CDwhoHGLi+Fnh55AmuW/2BjG2CQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k1robTKdCa1s60KA/0x3FbWbnUbE2tq0CuRQzo+OwZ0R1RCW+nbNU1IsvJiSEa/KG
	 aIEKyozlQCqyVLQ5mwBmxL8YYUwkPBYQAx759MXQL37nnK3Y6HPqsTSsqQ48e/OknB
	 T0jMlvR7al5Pe069orXaC/hpItvNGVeMLAY4n0nWeEA5/km3kpKXBACy19U+uRf8KG
	 SdZsZXSqQO6wLzoA7jJ264elIWc1UU2oZf3WT6UCrwpUJc1vR7VSLUQTlMOsjkScV5
	 kEY9D58a0ufgNkX8hhQBu8U2t3XaaOp9FhjTOe8Iq+yxkJpCz1aqcDn00+8dD4EFQQ
	 FZlMrC4gTx91g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/11] perf tools: Add O_CLOEXEC to open() calls in DSO
 and ELF code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608013057.1942953-9-acme@kernel.org>
References: <20260608013057.1942953-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:44:30 +0000
Message-Id: <20260608014432.C3CC51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch incompletely fixes the file descriptor leak because it m=
isses multiple mkstemp() calls that do not set O_CLOEXEC.
--

commit 76a844002251898e2934fafe58f422e4df6f5517
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code

This patch adds O_CLOEXEC to open() calls in dso.c and symbol-elf.c to
prevent file descriptors from leaking to child processes spawned during
symbol resolution. This aims to prevent fd exhaustion during long
profiling sessions or when processing many DSOs.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 7dced896c64ea..fb2e78fe2aa8e 100644
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

[Severity: High]
This is a pre-existing issue, but does mkstemp() also leak file descriptors
to child processes?

Since mkstemp() does not automatically set the O_CLOEXEC flag, the file
descriptor created here for the decompressed kernel module might still rema=
in
open and leak to child processes (like addr2line) spawned during symbol
resolution.

Should a subsequent fcntl(fd, F_SETFD, FD_CLOEXEC) be added to fully resolve
the file descriptor exhaustion issue this patch targets?

>  	if (fd < 0) {

[ ... ]

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 186e6d92ac3d7..c2bdfd0003df2 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c

[ ... ]

> @@ -1985,7 +1985,7 @@ static int kcore__init(struct kcore *kcore, char *f=
ilename, int elfclass,
>  	if (temp)
>  		kcore->fd =3D mkstemp(filename);

[Severity: High]
This is a pre-existing issue, but this mkstemp() call also creates a
temporary file for kcore without setting O_CLOEXEC.

Additionally, looking at read_gnu_debugdata() in the same file, there is
another call to mkstemp() used for extracted .gnu_debugdata:

tools/perf/util/symbol-elf.c:read_gnu_debugdata() {
    ...
    temp_fd =3D mkstemp(temp_filename);
    ...
}

Do these mkstemp() descriptors also need to have the FD_CLOEXEC flag set to
prevent them from leaking to child processes?

>  	else
> -		kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL, 0400);
> +		kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, =
0400);
>  	if (kcore->fd =3D=3D -1)
>  		return -1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013057.1942=
953-1-acme@kernel.org?part=3D8
