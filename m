Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138A324B1F
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672269; cv=none; b=FgIN/5Lv9QyE37MxVsBhAnYLjLVqxqUOjPOGOKf+Ihc0+wREly7lUUbWzm/x6v12AtZUoCdkS6/HQbZoAB+8Z413cDJO/cHuVctLA6/EUiw89ukQ3x++1lN+MXk00LMGT0HXYXbJ+uX66PpwYD0OjvqNkOL6uYA+sXjI5CKZkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672269; c=relaxed/simple;
	bh=YNs9Fk4HWwcgnsc6vwITHRFVum8m9wj3daKt8rmqFX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gY8gaXxXWQ6d7vevinHVfPH0gdBVnVsEbqWKA7Jptglxy9M0xZNbgpMelng3kweN5/2f2EUJH8JfiGIn5mj1fj655sxb3m1DffR57lUFkLHQE0rDBD1+r78Q32Usk70uKrnIE2asX6coj25wtYkvSA5mO+dsKJ2tQ5S77I5R+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHJy/yaC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHJy/yaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAD2C19421;
	Wed,  8 Apr 2026 18:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775672268;
	bh=YNs9Fk4HWwcgnsc6vwITHRFVum8m9wj3daKt8rmqFX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bHJy/yaCVDbjxxfgGoqEFyrF+AxBsApN1Sw5R5YoLwS9y0TElsOOLLGRAeSjTbTT5
	 BDpf6vul4fA9jfagTyl57ZLctaFvxHon3XWFhvmX2DoDKUWZMgTHbiQPK7gVFxjLcw
	 AS19IAxT7UOVLrHiaQGD+saSeRdQWLYrWatYTd3vKnpIH2dWMikLCQHw3zvLZQg6DV
	 gluAQYlndr4slaWWGkzdMGuplUYwXqrgexxheRARZzPP0V2gy5qZYh1MsmOr4L70tp
	 g9Z9F712loz9I/JPQR8IKQeALAD3JWTwWNe+vZzAv2GP37Z5nbGazjSTWTvnjwFLVn
	 OaQ7NW6JB7u1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf header: Use a max number of command line args
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408172846.96360-6-acme@kernel.org>
References: <20260408172846.96360-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 18:17:47 +0000
Message-Id: <20260408181748.ABAD2C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] Incomplete Mitigation for Heap Buffer Overflow (Ignores sectio=
n bounds)
- [High] Incomplete Mitigation for Integer Overflow in `cmdline` allocation
- [High] Pre-existing Out-of-Bounds Read and Heap Data Leak in `do_read_str=
ing`
- [High] Pre-existing Inconsistent Error State Leads to NULL Pointer Derefe=
rence
- [Medium] Silent Truncation of Remaining Header Features on Large Command =
Lines
--

commit f7dfe248f37e0c8cc488e6a1ae29de4882de3598
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Use a max number of command line args

This commit limits the maximum number of command line arguments processed
from the perf.data header to avoid overflows.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -2795,6 +2795,9 @@ static int process_cmdline(struct feat_fd *ff, void=
 *data __maybe_unused)
>  	if (do_read_u32(ff, &nr))
>  		return -1;
> =20
> +	if (nr > MAX_CMDLINE_NR)
> +		return -1;

If nr exceeds this limit, returning -1 here aborts the rest of the section
processing. Since perf_session__read_header() ignores errors from
perf_header__process_sections(), does this silently discard remaining
header features (like CPU_TOPOLOGY) without warning the user?

Furthermore, valid command lines can exceed 32,768 arguments when using
wildcards, which might result in silently dropping features on valid data.

>  	env->nr_cmdline =3D nr;
> =20
>  	cmdline =3D zalloc(ff->size + nr + 1);

The commit message notes this is to avoid overflows, but can
ff->size + nr + 1 still integer overflow? Since ff->size is a 64-bit
value read directly from the user-controlled perf.data header, a value near
SIZE_MAX could wrap the allocation size to a small number. zalloc() would
succeed, but it could lead to a heap buffer overflow during the memcpy()
operations below.

Also, if zalloc() fails here, or do_read_string() fails in the loop,
env->nr_cmdline remains set to nr while env->cmdline_argv is NULL.
Could this cause a NULL pointer dereference later in functions like
print_cmdline() that iterate over env->nr_cmdline?

>  	if (!cmdline)
>  		return -1;
> =20
>  	argv =3D zalloc(sizeof(char *) * (nr + 1));
>  	if (!argv)
>  		goto error;
> =20
>  	for (i =3D 0; i < nr; i++) {
>  		str =3D do_read_string(ff);
>  		if (!str)
>  			goto error;
> =20
>  		argv[i] =3D cmdline + len;
>  		memcpy(argv[i], str, strlen(str) + 1);

While looking at the overflow mitigations here, I noticed a couple of
potential issues with how do_read_string() interacts with this buffer.

First, do_read_string() reads strings without bounding them to ff->size.
If a file provides a small ff->size (resulting in a small cmdline
allocation) but embeds huge strings, will this memcpy() write past the
end of the cmdline buffer?

Second, if the data returned by do_read_string() lacks a null terminator,
will strlen(str) read out of bounds into adjacent heap memory, causing the
subsequent memcpy() to leak that heap data into the cmdline buffer?

>  		len +=3D strlen(str) + 1;
>  		free(str);
>  	}
>  	env->cmdline =3D cmdline;
>  	env->cmdline_argv =3D (const char **) argv;
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408172846.9636=
0-1-acme@kernel.org?part=3D5
