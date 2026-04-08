Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5053D47A5
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671790; cv=none; b=KbU4E8IdtBkSUMlhL/db3win71IbwE7UP1NvHGucuse1hMSntGgo6zPD/bmFG0U92LspobihdFX53oKqzSWEUqjbpEmCs9gwvDPDbFoIdavlwBYRxel++F4+hSib/8Nf9TQx0BxDiUlWkO/Z1nRuUIK17CWm1LmYD7PCGeHzw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671790; c=relaxed/simple;
	bh=o5PRpgiHpLd990ww/wVsqk+7DxXrMxIPG6rWwMujsWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3quMsjHIjBp9qFXptIUpMIF+NVn1x50F7l9a2NaWuqTDgAGq9Q8jy8P50S4T4nddxAkbSd//wgpcUQetvBHp6LMVUFpEpJuB/VytJuBLQm1yDiiRx5qOnbx8iWjmbQnOkXoAxXZ8huMVg4yOwcsk2OD3JDmawoJVWOFenzz3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt9l+Xim; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lt9l+Xim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9349BC19421;
	Wed,  8 Apr 2026 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671790;
	bh=o5PRpgiHpLd990ww/wVsqk+7DxXrMxIPG6rWwMujsWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Lt9l+XimgEx2kGYcY8pbMD7fAQmzkqYN1EY8KYQ5JCuUf7YNh7sR4eQqO3Tv3wWQC
	 ZF2uRNlouJAjS7SsxcjANbeVbiLfgSp7JKtmY14734dytnLSTLpX+kA2QpsGx9b92o
	 GXA/KpsL5hkLz+1mQxopBra+69ufoahC3ghQ89tu4Mh0Hdq1Dst9jnwCyqb9/ORLEj
	 dgI1PA2rKpYyxYIHlvIbZKNvs9uLGccVFRkIAYNY48OHnJrAfH5BFaf3c1Ix2COQJS
	 VD+q9uvwCs3AKKZ/YDkR1JJMtDIRBU8IWvfWMjqxnwq0Tb18Np54ZIhU37d88BW/wu
	 E70v+0vTByNhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf header: Use a max number of command line args
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408173203.96700-6-acme@kernel.org>
References: <20260408173203.96700-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 18:09:49 +0000
Message-Id: <20260408180950.9349BC19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Unvalidated `ff->size` and unenforced string lengths lead to h=
eap buffer overflow.
- [High] Missing null-termination validation causes out-of-bounds reads.
--

commit 1f222a4afd391a2d476456be29b779929e17885b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Use a max number of command line args

This commit sets a reasonable maximum number of command line arguments to
avoid overflows when reading perf.data files.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -2804,6 +2807,9 @@ static int process_cmdline(struct feat_fd *ff, void=
 *data __maybe_unused)
>  	if (do_read_u32(ff, &nr))
>  		return -1;
> =20
> +	if (nr > MAX_CMDLINE_NR)
> +		return -1;
> +
>  	env->nr_cmdline =3D nr;
> =20
>  	cmdline =3D zalloc(ff->size + nr + 1);

This problem wasn't introduced by this patch, but is there a potential inte=
ger
overflow here?

Because ff->size is attacker-controlled data from the perf.data file header
and is not validated, could an attacker set ff->size near the maximum value
to cause an integer overflow, resulting in zalloc allocating a tiny buffer?

Alternatively, even without an integer overflow, could an attacker set a sm=
all
ff->size but embed large strings in the file, bypassing validation if
do_read_string() does not enforce that the read bytes fit within the declar=
ed
ff->size?

This would cause the subsequent memcpy loop to write beyond the allocated
cmdline buffer, leading to a heap buffer overflow.

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

This issue was also not introduced by this patch, but does this code cause =
an
out-of-bounds read if the string is not null-terminated?

If do_read_string() allocates memory based on a length prefix and reads data
directly from the file without explicitly appending a null terminator, coul=
d a
malicious perf.data file provide a string length but fill the content entir=
ely
with non-null bytes?

This would cause strlen(str) to scan past the end of the str allocation unt=
il
it encounters a null byte in adjacent heap memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408173203.9670=
0-1-acme@kernel.org?part=3D5
