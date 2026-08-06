Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A6175A8B
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020584; cv=none; b=F75GrUH6LtY5DRSZGHwyP6zR3Jc2/FjB7e2p/1G62OK451mrYbNbcWpEGzPuqK+kHRBe0aWaDSmy3OfK7RIgpcw2aOI08bIE5lGQd5M0zOmMYX+yq3gFRSrvqjQZkIvbE1zRxBodx4OZ5CsWjUgS697DY5E7HHU9rxQzxsbQ9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020584; c=relaxed/simple;
	bh=RxmT04qbdb5wSHu1OP43cHtU968E/1Ga9FF+sAZitv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WN12i/0hqHtawQZURa+TIOnLC8unSu8fbHbh2CTqvgtyHjYSVJSNwxYhBoKisMDb1MEFRwN48Du7olQWU6CxPgFSUdISTRUZ3g9W3d0OBo+dTd7blBJV48jz9kboqa65p3zBAjD8BaNRQm32MolqI186nVwrPJhWDGG000GHYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CByTIpZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CByTIpZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3EF1F000E9;
	Thu,  6 Aug 2026 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020583;
	bh=z+hIlHxwNHfKRODbXciLXZexyOHa3Z89HpDD74qL8zA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CByTIpZYxrPECjW8ldMZ4sn+7FNdZDKZTXf6Kf/aSbdXznKm8uj/sKxHuTB19L5g1
	 UXgHjMkg4xv15aCvRVh56ZAJ6fhU2EkmHHVGN7zK/JNfxZsDOnojvH4kiks9lGuGAc
	 XsM5duz0AlXTrpm6aHb8Ytk9JI6ApKBFJQ0eCk7wGQbmcqEk3R5O0p5Grzc51zu7Ho
	 PQCb6ZkbrXa6IvI/ECCtkcsbVhpcPOw52uU/eCiOsw8r0bd6ZnztCQkE0rM8VRhqqm
	 GYpWeEZHiUA8+vEqF5LQICDrePsRxHYmKYFHLGMwWK0H5BwhGHQsahnPqP3bkWg8qa
	 Q48J4WeSV8/yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] perf jitdump: Free event in
 jit_repipe_code_move()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-9-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:49:42 +0000
Message-Id: <20260806124943.2D3EF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap Out-of-Bounds Read when writing event to perf.data in `jit_re=
pipe_code_move()`
--

--- Patch [8]: [PATCH 08/12] perf jitdump: Free event in jit_repipe_code_mo=
ve() ---
commit b900743750fdefef6d63a1e65a54cf9d26b1477d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Free event in jit_repipe_code_move()

This commit fixes a memory leak in jit_repipe_code_move() by freeing the
event allocated via calloc at the out label, matching the behavior in
jit_repipe_code_load().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index ae63366b86c6d..91aa1eea8229f 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -685,6 +685,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)

[ ... ]

>  		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
>  out:
>  	perf_sample__exit(&sample);
> +	free(event);

[Severity: High]
This is a pre-existing issue, but does this code have a heap out-of-bounds
read when calculating the event size?

In jit_repipe_code_move(), the event being freed here is initially allocated
with a hardcoded extra 16 bytes:

    event =3D calloc(1, sizeof(*event) + 16);

However, the header size is calculated using idr_size:

    event->mmap2.header.size =3D (sizeof(event->mmap2) -
                    (sizeof(event->mmap2.filename) - size) + idr_size);

If idr_size is greater than 16 (which can happen when multiple sample types
like TID, TIME, and CPU are enabled), and the path is very long, the
calculated header.size can exceed the allocated size.

When this event is later injected:

tools/perf/util/jitdump.c:jit_inject_event() {
    ...
    size =3D perf_data__write(jd->output, event, event->header.size);
    ...
}

Could this cause perf_data__write() to read out-of-bounds from the heap,
potentially leaking adjacent memory into the perf.data file or causing a cr=
ash
if the read crosses into an unmapped page?

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D8
