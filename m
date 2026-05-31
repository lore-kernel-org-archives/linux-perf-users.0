Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82222175A9C
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210346; cv=none; b=QXib7OqEwgIqc4AlbfTbQAx0Sr8FKCP9wOwA4ohj30PuWUPWYyPtuZnPJaof2/mHLdsiF/kR2uju5KrJTTgB1jWv9XaoA13SIanmoUY3A1KXSUQtgFIKZNK7N/q/me8VdD06RhAg1823tuzarjsMOqPCXjt8fsr4HEAXjXlDzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210346; c=relaxed/simple;
	bh=C/RsvT8gUHEK3HBNHNDa+Dl79i3IDVkl7wwpKKbb5B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a228ve6hDOnmd3zlB5avo4MqOxfBZx6kmZLw9XSwjvY2adAbDC7Wyd+VWEWG2XjzBZzkVcQZt8OG6v4c2j1iLUC/rUpsb8pAJCiqRVBkTE7me5tnHiFbgD3DXNxS8JlrpeSwaj7HdqxUF2PoJrlVd53EYIkBfs7pOp9mc79b0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9HNIwO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9HNIwO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F21F00893;
	Sun, 31 May 2026 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210345;
	bh=521rSp6GU8v525IW/1LifePsthp84GdG16Ztg4yco5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D9HNIwO4Z7irgPyrwVuEGvlo9FSSdJwSMep3O2AYZgBPXzocaWbXE9P0cWZP2vhGr
	 xNuGjvBhFvcEl5HRnYOOqI2M2UkLG+1H7ca3aEr+M9d9OBTOiHPEEiGdA470cZvoCJ
	 szY0n47gY4pBTkUU49WmDX9Mr2aZXjc8HCH1FR+QM/qgVdOIIe/xRj01pQ/1wbGOOl
	 fIyPqGNOJeFhQlYoZiy7VtChgCrPATEtEhSKwQ9T6Xat1LJhFet5wb0Te4pAd2wbF4
	 L/RnPFsmiS/PYbNpBObLgD0tBUMRsB5Y1o35+LnjmZi3zT4dWcjyVdyaMTIZe3w/qD
	 Q7Z+OSQWD7fUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/14] perf test: Skip shebang and SPDX comments in
 shell test descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531063736.871777-11-irogers@google.com>
References: <20260531063736.871777-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 06:52:24 +0000
Message-Id: <20260531065224.EF6F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized stack memory access due to `readlink()` not null-ter=
minating its output string.
- [High] Stack buffer overflow when constructing the script filename due to=
 an unchecked `readlink()` return value.
- [High] `io__get_char()` implicitly sign-extends non-ASCII characters, cau=
sing premature EOF on architectures with signed chars.
--

commit 37c9e7577c4c35ff9a02375d4ed22021ca8bd62d
Author: Ian Rogers <irogers@google.com>

perf test: Skip shebang and SPDX comments in shell test descriptions

When extracting shell test descriptions in tests-scripts.c, the parser
skipped the first line assuming it was the shebang (#!/bin/sh) and then read
the first comment line on line 2 as the test description.

However, checkpatch.pl expects shell scripts to declare their SPDX license
identifier on line 2 (# SPDX-License-Identifier: ...). This caused the test
harness to extract the SPDX license string as the test description.

Refactor shell_test__description to use io__getline, skipping both shebang
and SPDX comment lines. This allows shell tests to include standard SPDX
headers without breaking test suite description extraction.

> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index f18c4cd337c8f..11ad1263ef85c 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -51,7 +51,7 @@ static int shell_tests__dir_fd(void)
>  		return -1;
>  	/* Follow another level of symlink if there */
>  	if (lstat(path2, &st) =3D=3D 0 && (st.st_mode & S_IFMT) =3D=3D S_IFLNK)=
 {
> -		scnprintf(path, sizeof(path), path2);
> +		scnprintf(path, sizeof(path), "%s", path2);

[Severity: High]
This isn't a bug introduced by this patch, but does this code read
uninitialized stack memory?

Looking at the preceding readlink() call:

	if (readlink("/proc/self/exe", path2, sizeof path2) < 0)
		return -1;

Since readlink() populates path2 but does not append a null terminator, pat=
h2
remains an uninitialized stack array. When lstat() and scnprintf() expect a
null-terminated string, won't this cause reads past the valid resolved path
until a random null byte is found?

[ ... ]
> @@ -78,43 +78,49 @@ static int shell_tests__dir_fd(void)
>  static char *shell_test__description(int dir_fd, const char *name)
>  {
>  	struct io io;
> -	char buf[128], desc[256];
> -	int ch, pos =3D 0;
> +	char buf[128], *line =3D NULL;
> +	size_t line_len =3D 0;
> +	ssize_t len;
> +	char *desc =3D NULL;
> =20
>  	io__init(&io, openat(dir_fd, name, O_RDONLY), buf, sizeof(buf));
>  	if (io.fd < 0)
>  		return NULL;
> =20
> -	/* Skip first line - should be #!/bin/bash Shebang */
> -	if (io__get_char(&io) !=3D '#')
> -		goto err_out;
[ ... ]
> +	while ((len =3D io__getline(&io, &line, &line_len)) > 0) {

[Severity: High]
This isn't a bug introduced by this patch, but does io__get_char() implicit=
ly
sign-extend non-ASCII characters?

io__getline() uses io__get_char() under the hood:

tools/lib/api/io.h:io__get_char() {
	...
	if (io->data =3D=3D io->end) {
		int ret =3D io__fill_buffer(io);

		if (ret)
			return ret;
	}
	return *io->data++;
}

Since io__get_char() returns *io->data++ directly as an int, on architectur=
es
where char is signed (like x86), wouldn't characters >=3D 0x80 (such as UTF=
-8
multibyte sequences) be sign-extended into negative integers?

Callers (such as io__getdelim()) use if (ch < 0) to check for EOF or errors.
Could any non-ASCII character in the parsed text incorrectly trigger an EOF
condition and truncate the read operation?

[ ... ]

While reviewing this file, I noticed another pre-existing issue in
append_script() in tools/perf/tests/tests-scripts.c:

tools/perf/tests/tests-scripts.c:append_script() {
	...
	len =3D readlink(link, filename, sizeof(filename));
	if (len < 0) {
		pr_err("Failed to readlink %s", link);
		return;
	}
	filename[len++] =3D '/';
	strcpy(&filename[len], name);
	...
}

[Severity: High]
This is a pre-existing issue, but is there a risk of a stack buffer overflow
when constructing the script filename here?

readlink() returns the number of bytes written to filename. If the resolved
path length is exactly PATH_MAX, len will equal sizeof(filename). Wouldn't
filename[len++] =3D '/' then write a byte past the end of the filename arra=
y on
the stack, with strcpy() continuing to write out-of-bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531063736.8717=
77-1-irogers@google.com?part=3D10
