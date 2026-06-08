Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B4309F09
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951249; cv=none; b=DLgOrefhfeCzOXHrH2PzFLDBtd64y2PfBd/XewzlEqAaOXVdg+jg4LIfDhNrnhJX4PRYbtqRig9nYAXjcZsOLlxUa3RlIRQ5H7ncVzrl8l3WTS2aKiP+7nThfVdNr3gbQAawg0Qr0osi44tIO17FhNO10UGUPdnAhl7Ur33rjsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951249; c=relaxed/simple;
	bh=ca1Qfy52hMVcSBlCUsKBqMYg4eIo7ZkkZM7GyL/k5aE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P6kyz4IJpSFCMuRAEkorWkBUJRy3fQ6yJURWJzhVRd04PZ7QHGJKZ7EmW41lW1r9j0WDeyDuuRmNgaE18dobd7FKAe2DKadG2le6v+Rjyp98wE/xIivDmxiicVlCljyuCBjfM+aaRpaPiq0oGwm4eUmt6ZbL9Xi4j/xwxe+Qhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEZbqYTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEZbqYTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408E81F00898;
	Mon,  8 Jun 2026 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951248;
	bh=toiqGZY9QRTMi6enGrSeCZOqsZbuaUFoo1MNTlPlpwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hEZbqYTl4jQqvhLEjuoVBjvtnxIbeLCWb1EYI7zbvFqNmUOMZIIqE3ybs6VQPIKq5
	 UL0eYnh6NJCyD3IOhDhBMKPBknF5RzBPRnO3F1fEBDQQw6DUCHJYhOgip5ngu+OOWE
	 Hb7M0cGphhqVyiwgN0k/IzvgfvSZYzGvKftwc8pm9RpSqmK1q6/12+SFU9LmVr85f+
	 NhWJjfgN5iX/zsXcPaxAOuLf0W1TWz0FApTXTUCjDr2DyxtPEFCVwH7fKSBCmuBDj3
	 h+BoKF+6FOa1HQsEPm5wmafX+jKoMLIET5LSqxn303JKCC4K6sal+JSxwEfNt3WKb+
	 ZkWRy0Aa/huAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] perf tools: Add O_CLOEXEC to open() calls in DSO
 and ELF code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608201753.1979464-8-acme@kernel.org>
References: <20260608201753.1979464-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:40:47 +0000
Message-Id: <20260608204048.408E81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete fix: The patch introduces an inconsistency where unco=
mpressed DSOs are protected from FD leaks via O_CLOEXEC, but compressed DSO=
s and temporary files using mkstemp() still leak.
--

commit 3d059467c232a3fc60a5f840954aaa8bdad70992
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code

This commit adds O_CLOEXEC to open() calls in dso.c and symbol-elf.c to pre=
vent
file descriptors from leaking to child processes during symbol resolution.

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

[Severity: Medium]
Is this fix incomplete for compressed DSOs? The open() call for uncompressed
files now has O_CLOEXEC, but the mkstemp() call directly below it does not =
set
the close-on-exec flag. Should mkostemp() with O_CLOEXEC be used here to
prevent leaking the compressed DSO file descriptors to child processes?

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 186e6d92ac3d7..c2bdfd0003df2 100644
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
>  	if (kcore->fd =3D=3D -1)

[Severity: Medium]
Does the temporary file branch also need similar protection? The else branch
now correctly uses O_CLOEXEC, but mkstemp() in the if (temp) branch will st=
ill
leak its file descriptor.=20

Additionally, there appears to be another mkstemp() call without O_CLOEXEC =
in
read_gnu_debugdata() in the same file. Do all instances of mkstemp() creati=
ng
temporary files for debugging need to be updated to mkostemp() to fully=20
address the leak?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201753.1979=
464-1-acme@kernel.org?part=3D7
