Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7E29CE9
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203487; cv=none; b=biw0B6UVqrzzqPBPWZAldCkPYkv4D/7lBSflaQeYwALZM3YRqv9uKIr67pMOPwNkdTstOqo6LtBAj9mmBLa4u/4RwtwQOocr3i+lXqgFoUWKd7bwszWnrHGt6UU1rEOnSuxKJ/s47uGHNP4VOEKR3HkxXF0zB9mH0Fn4LxB1rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203487; c=relaxed/simple;
	bh=PjfyYobEVOG44CS7RlZNeGWAtGkpF/a7UZdWVDA9WU0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QqWI8Zk+gJfLHxQPtap+7N/sjVsIGG3iQT5na5hZZwT9GKdgFLfX7+0rrIezshed1W3lkW5/kSSEvXsZgNcrYI5h2OWyUWQQ7d0zUAiXhPlLK422wUySjoLZwDJo/qMrrTJAS+S39Vrfz+mJe5QcIpHkAewsod70JOECFsn5vAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww6x/AoG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww6x/AoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35904C19425;
	Tue, 14 Apr 2026 21:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776203487;
	bh=PjfyYobEVOG44CS7RlZNeGWAtGkpF/a7UZdWVDA9WU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ww6x/AoG0Dh61tdZNNimajkKjCt66JLJr97CecnwZov8fGLGQ5pMUXU3bVls9r6t6
	 mEoXuR11Gl5hBdJFbS7Ok2hGVGOsrDvLhRR6/7R7n5fKWuDxCVyMSxeaX05mImuiHJ
	 umwfGzd970rb3gMZBSIlwbr2SE+yFFTyOkAymxH0GHgwUmqMk7o6DrUHQZNc7hRbdi
	 5eiAr7BEbcH/6Q81NiuVIsxu9HXT9xIk+RmGAINf64UEaHhhskF+R9G4xGUzvhSlaO
	 sAXxX/zpT4ejrGGq/F017xMMoGxcaHMfmeviDUBPh8wGinKb5zTlTXCDiafrZdImPZ
	 CtArh0FVQ79Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf header: Validate string length before
 allocating in do_read_string()
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414204847.293557-3-acme@kernel.org>
References: <20260414204847.293557-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:51:26 +0000
Message-Id: <20260414215127.35904C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] `do_read_string()` fails to ensure null-termination, leading t=
o out-of-bounds reads and heap buffer overflows.
- [Medium] The newly added size check is trivially bypassable because `ff->=
size` is unvalidated.
--

commit 1c3491f2bf9f038ae68f7007db4323e57b4d8132
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Validate string length before allocating in do_read_string()

This commit attempts to prevent large memory allocations by verifying the
requested string length against the remaining section size before calling
malloc.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index ca0c9e80345b2..f8acd06ae9235 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -259,6 +259,9 @@ static char *do_read_string(struct feat_fd *ff)
>  	if (do_read_u32(ff, &len))
>  		return NULL;
> =20
> +	if (len > ff->size - ff->offset)
> +		return NULL;

Is ff->size validated against the actual physical file size before this che=
ck?

If ff->size is initialized directly from the user-controlled section size in
the perf.data headers, couldn't a crafted file provide a maliciously large
section size?

This would allow the bounds check to pass, triggering the large allocation
this code was intended to prevent.

> +
>  	buf =3D malloc(len);
>  	if (!buf)
>  		return NULL;
> =20
>  	if (!__do_read(ff, buf, len)) {
>  		/*
>  		 * strings are padded by zeroes
>  		 * thus the actual strlen of buf
>  		 * may be less than len
>  		 */
>  		return buf;
>  	}

Does this guarantee the returned string is null-terminated?

If a crafted perf.data provides a string without a null byte, or if len is =
0,
wouldn't callers invoking strlen(buf) read out-of-bounds into adjacent heap
memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414204847.2935=
57-1-acme@kernel.org?part=3D2
