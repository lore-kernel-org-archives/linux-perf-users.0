Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E3211A28
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967788; cv=none; b=iD0+e2lVuWl89M9kNDty4n37ByywP5nZ/9yCGo2lFshibH9DS1Nt8QvhAUF4opTHHgHyPQvwkrhFCtIJUHm/YST1OYUJHHsRVXJWB2xH61qKwXtn9mm51+lPMl8Ku15We3hJLdvVo3rufEvkuCP+OMWNAsVxCl6S3pKbeZDJpp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967788; c=relaxed/simple;
	bh=65+ogC9uRtRQ0yedWozrR4nMHrUzoYq+2/q5dtepIWI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pq+dntyig+PV/V5P7iU6ULvBERG1foA/ThGAEOSW5RJE57Dmgp9mJRIs3y/RcdiwNp9E/TTQT+r3MxdNQ9M8esUmXkYKTVYDlRNoyk6uYJitjZ04w+kxO5T9cqGsfRe4i+lWQoGiS0f5w/j7IIDHyVeS+qwLxGhrEttOieLIfxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuavxXuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuavxXuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE73D1F00893;
	Tue,  9 Jun 2026 01:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967787;
	bh=uhKkMvSmEYUp60kChnCDghvhqsGWDqRoF+15OIjGVNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QuavxXuPxF+zxeOuNWGIS3Wh6uC6z+3ZuXp1bs6fDR4MJmQECA8CT4a+83Rwmff72
	 4dYZwiSBvSlKpjpHdSno2AChwafKJoF5i7rApK+msVZg1FNqcjAC4mS5Pp+JqCkujV
	 MaA8JDKF/eFO4W/WolRwNf3w8XKY8t+bqrNycNp0prR+Q/lyvY+D4KkKuuTYKn7dmM
	 QTWi9rXIonjLaGfN/9GjUxI2KW7uBHS8EhAiddQM4YJWvPV8qPSrNDHy7uGWRsKcyw
	 xkzqS8nHiQ0GWyueDqL3j95/PwkUB2owN3Q5QHpR1wfS7M8wFEZDbw0SPvaN8+tpoO
	 fEV58aQxN749w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] perf tools: Add O_CLOEXEC to open() calls in DSO
 and ELF code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-8-acme@kernel.org>
References: <20260609010526.1998472-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:16:26 +0000
Message-Id: <20260609011626.DE73D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incomplete fix for file descriptor leaks in DSO and ELF code.

Pre-existing issues:
- [Critical] Stack buffer overflow in sysfs__read_build_id when skipping no=
n-matching GNU notes.
--

commit 66274b4049c9a2092defa7caf237fe0295853d9c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code

The commit adds O_CLOEXEC to open() calls in dso.c and symbol-elf.c to
prevent leaking file descriptors to child processes during symbol
resolution.

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
Since the goal of this patch is to prevent leaking file descriptors to child
processes, should we also address the mkstemp() calls in these files?

mkstemp() creates file descriptors without O_CLOEXEC. For instance, here in
filename__decompress(), the temporary file descriptor will still be leaked.
Should mkostemp(tmpbuf, O_CLOEXEC) be used instead?

[ ... ]
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 186e6d92ac3d7..c2bdfd0003df2 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
[ ... ]
> @@ -935,7 +935,7 @@ int sysfs__read_build_id(const char *filename, struct=
 build_id *bid)
>  	size_t size =3D sizeof(bid->data);
>  	int fd, err =3D -1;
> =20
> -	fd =3D open(filename, O_RDONLY);
> +	fd =3D open(filename, O_RDONLY | O_CLOEXEC);
>  	if (fd < 0)
>  		goto out;

[Severity: Critical]
This is a pre-existing issue, but while reviewing this function, could
an unbounded read() happen later in sysfs__read_build_id() when skipping
non-matching GNU notes?

If a crafted sysfs note has a maliciously large nhdr.n_descsz, the code doe=
s:

    } else if (read(fd, bf, descsz) !=3D (ssize_t)descsz)

Since bf is a fixed-size stack array (char bf[BUFSIZ]), could this read past
the end of bf and overwrite the stack frame if descsz exceeds BUFSIZ?

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
>  		return -1;

[Severity: High]
Similarly to the issue in filename__decompress(), if temp is true here,
mkstemp() is called without O_CLOEXEC.

There is also a similar mkstemp() call in read_gnu_debugdata() in this file
that extracts debug data without O_CLOEXEC. Should all of these be updated
to prevent leaking file descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D7
