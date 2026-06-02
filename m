Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BD3A8FE8
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386556; cv=none; b=ewJ6kvSInBOfr9lOnlnrXwSdZdwDWeEPcubpiSMSYupU/kLqJvSoA0932jPHrzo7O0HK39WXFYGtz/jHnsQcLpvviCE2hXcHrbZ56JW1i1OBNqxu3v//B01PHm4zLjqv/+vwScWdHZgBi02QHBdw6ls6dUg/10p3kZZqX41POVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386556; c=relaxed/simple;
	bh=8pUUIMym2rMqiG5ShxXXuYfng2MHxZWqu+eRawAW9pQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qHYW19e8T9/eaII6iRB+QFI1POx+NnNCjjVj8I4uxivHuYteoGLV6IHV+6H2AQF6Et9IoDMy+LikzGkBcSJDCzsD1qE80oX94tFfFuCzV3yELqIpuCX2yAuLBdOqp2EJ7P3LXvGEF57FH870ezeZOv/8vwbmzh3aQx7whyOjD0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOKJslKq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOKJslKq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4CE1F00893;
	Tue,  2 Jun 2026 07:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386555;
	bh=VG5b4dGSj+5arSfOor50Q63dw/M+zOthCpu9UAar90s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YOKJslKqtwhoMS2YwUykwdnlBSPVSOzmzIbUGdJhQZR/jLNp2cIOyLBrKTedhUTE4
	 /Atk/WHSuM2VPFF8gY7h0JNJsfnpscWSCeEeRsK4qh6BzfF4E+z+5XIjIyAkXX30VQ
	 tZVGnW62xQFN/pDTbgECB7zsrjimd27gRwOCGtbB4SZgimyWU+c45vCcQLYGfx6qmi
	 EIQwWsnEbEqwfrB5qPdTmR6jvMgmyLoEfpzQDAgWBBy9uvVvlgFq4nULoGl7F4yNSw
	 cBOs1d7qbyrYIQ8X9xZRNpdBBnSlnwNjm5OFtIJwvMEG+M1zESFCHhUjch0zgfmYxF
	 MoKSxhbsLxVPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf test: Skip shebang and SPDX comments in shell
 test descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-13-irogers@google.com>
References: <20260602073132.2653307-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 07:49:15 +0000
Message-Id: <20260602074915.7D4CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Off-by-one error in readlink bounds check rejects exactly-fitting p=
aths
--

commit 9089c17859338d0541d199d5b734699b5eaf5d78
Author: Ian Rogers <irogers@google.com>

perf test: Skip shebang and SPDX comments in shell test descriptions

This commit refactors the shell test description extraction to correctly
skip shebang and SPDX license lines. It uses io__getline instead of
manual character reading and adds a few bounds checking adjustments.

> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index f18c4cd337c8f..ec24a1d974ae0 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c

[ ... ]

> @@ -178,9 +190,9 @@ static void append_script(int dir_fd, const char *nam=
e, char *desc,
>  	char *exclusive;
> =20
>  	snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> -	len =3D readlink(link, filename, sizeof(filename));
> -	if (len < 0) {
> -		pr_err("Failed to readlink %s", link);
> +	len =3D readlink(link, filename, sizeof(filename) - 1);
> +	if (len < 0 || (size_t)len >=3D sizeof(filename) - strlen(name) - 2) {

[Severity: Low]
Does this bounds check erroneously reject paths that perfectly fit in the
buffer?

If len is exactly sizeof(filename) - strlen(name) - 2, the string appended
will occupy up to the last index of the buffer: filename[len] gets '/', and
strcpy() writes strlen(name) + 1 bytes starting at len + 1.

The highest index accessed is exactly sizeof(filename) - 1, which is the
very last byte of the filename array. This perfectly fits within the buffer,
yet the >=3D operator incorrectly triggers the error path for strings of th=
is
exact length.

> +		pr_err("Failed to readlink %s or path too long", link);
>  		return;
>  	}
>  	filename[len++] =3D '/';

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-13-irogers@google.com?part=3D1
