Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94942046F
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182592; cv=none; b=GKC74XbBAgfE6YRos6h7/1y5fIsqV8ZI9MI8pJsIoqkN/Y5PUgqvg5vmvkZqMDnQk2DfD1V+J650MJ6wSy+utkGMpEp4i1OdgC+V2pERjmE/WEtW2tR2MlQulKImAWvTgrztvm1vN5mSN20ROmgVVW2wJynA2L3w0mye+aK0wqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182592; c=relaxed/simple;
	bh=0yCuIrVrFH07qH5IGiPIxEk4os/an+2sdD+Ijk9rFtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sUpXeVn4M1Sp9RsbiIefiJn8DB0UxWkBxdeKrURN28+jveVa1m2mQdVF9bMoYwYoCgA8fUrUjflVgSqzSRkotRrr+joKg+X+M+uF3dneTZbWlXvgmaH8GmTjFfXVYCSFoYB2ZEwNE6OJ2AFSQUy3kq4k891QCQATqrJccb45pGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5L5Hv46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5L5Hv46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668011F00A3D;
	Mon, 31 Aug 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182590;
	bh=MXOU3h9FYBXBPj/3RvoYxoZSqlkdqym8a2PO3P+AWzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5L5Hv46531r+vckVGvZgFJWv9gZDkd6NmAmF+BcqlSSpKVtV8Jh4aWXdHdj2bzIk
	 NDd01Zxkmmrbg18PIaLvVFBZv1vI4+Z2k3QQ2W9XxZFbSP6haZVM4XdiqwTLaeTM7t
	 Am9af0BbTY7cbbUdKzrWvIwLmZ33pRPq4OCudhChv6qnK+sFgJgXUeKyJW+XxqkMVE
	 Vu9sJmNAbuXP8QpZ62HvgVv02D3YIzKQh+59Ny18X5e9bSnb7jFl9ySRyQNrV5iGSh
	 RKOeliytogM6FMC3EENzBkK2hqSby0r5/rrt8nOLANEDEY1rw013eSy07rdBYurf/q
	 RQaIGfh2TLTpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] perf jitdump: Check snprintf return before
 computing header size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831131110.4681-7-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
 <20260831131110.4681-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 13:23:10 +0000
Message-Id: <20260831132310.668011F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insufficient heap allocation in `jit_repipe_code_move()` leads to =
an out-of-bounds read and heap disclosure when writing the event to `perf.d=
ata`.
- [High] Heap out-of-bounds write due to brittle, hardcoded sample ID struc=
t layout.
--

commit 9bf23bcb5ee8564df7189ee4fbf6479763732a6c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Check snprintf return before computing header size

This commit clamps the string size returned by snprintf() to prevent an
integer underflow when computing header.size in jit_repipe_code_load() and
jit_repipe_code_move(). This fixes a heap corruption that occurs when jitted
filenames exceed PATH_MAX.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 7efbaa07f1ba7..45f0e21b0e780 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -495,6 +495,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  			jd->dir,
>  			nspid,
>  			count);
> +	/* snprintf returns would-be length on truncation, clamp to buffer */
> +	if (size >=3D sizeof(event->mmap2.filename))
> +		size =3D sizeof(event->mmap2.filename) - 1;

[Severity: High]
This is a pre-existing issue, but is it possible for the allocation of event
earlier in this function to cause an out-of-bounds write?

In jit_repipe_code_load(), event is allocated with exactly idr_size trailing
bytes:

    event =3D calloc(1, sizeof(*event) + idr_size);

Later in the function, it writes to id->time based on a hardcoded struct la=
yout:

    struct {
        u32 pid, tid;
        u64 time;
    } *id;

    if (jd->sample_type & PERF_SAMPLE_TIME)
        id->time =3D convert_timestamp(jd, jr->load.p.timestamp);

If PERF_SAMPLE_TID is missing from the session but PERF_SAMPLE_TIME is
present, idr_size may only be 8. Would writing to id->time at offset 8
strictly overflow the 8-byte dynamic allocation?

> =20
>  	size++; /* for \0 */
> =20

[ ... ]

> @@ -625,6 +628,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  	         jd->dir,
>  		 nspid,
>  		 jr->move.code_index);
> +	/* snprintf returns would-be length on truncation, clamp to buffer */
> +	if (size >=3D sizeof(event->mmap2.filename))
> +		size =3D sizeof(event->mmap2.filename) - 1;

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds read and
heap disclosure when the event is injected?

In jit_repipe_code_move(), the event buffer is allocated with a fixed 16-by=
te
offset for the sample ID:

    /*
     * +16 to account for sample_id_all (hack)
     */
    event =3D calloc(1, sizeof(*event) + 16);

However, the total event size is calculated using the full dynamic idr_size:

    event->mmap2.header.size =3D (sizeof(event->mmap2) -
            (sizeof(event->mmap2.filename) - size) + idr_size);

If idr_size > 16 (e.g. PERF_SAMPLE_CPU and PERF_SAMPLE_ID are set) and the
filename length approaches PATH_MAX, could header.size strictly exceed the
allocated buffer bounds? When jit_inject_event(jd, event) is called later,
could the oversized header size cause it to read past the allocation and le=
ak
heap memory into the perf.data file?

> =20
>  	size++; /* for \0 */
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831131110.4681=
-1-acme@kernel.org?part=3D6
