Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E4A387375
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940430; cv=none; b=l1QOyQcb1LKQK23anY54A9zCG/bebsS5Okgo+RFi8W+cXyj/A+3vY9R0fSDBV8vOvxOACAXWLJ8Fz3pm+LQkYOSrrDKQUM6e32wr2Wv+qf2JdpPItwq7yhTPHzJjJgAGgE0GUQ4rTFQn7wBIwV+257y6o7jsX0JtAL3LhP603cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940430; c=relaxed/simple;
	bh=nOnxIpxbp24Z2rghH5k/FzukprdfhR4lM1757O0lI24=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s4wi71F5Wx9xJ8hvqcf1B7v7adKTQEdj+uG1GtAEyR0axKEWUzkedvaGyL+jjW97FPhjfj07ygKGTFOHG7ZoKrxsx1RdOCTR29ArEkHi6IXwUYnDLpysktUp0CXR16fGk+yCewSkVm3w1Q5sE727o0wbRyUTVLObIYkePjJZmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SU/HuycV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU/HuycV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2673B1F000E9;
	Wed,  5 Aug 2026 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940420;
	bh=G0ktbtBrp3Oom7W8UWTkeia0zm8C1VsFFXc0x16snzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SU/HuycVlE+BEw/lMLUZ4IVjvtXZauknjYxSxhnO6xsaEwo0UQUe9w8TskLY/GRX4
	 Ibd8gzye3Y5m6BSsR+vHejoSpQ7GpEvp3bZJWAy3dIoS4ME84btTnjh0fGc3eERsjJ
	 d5Erpp7OHvXmUiFp3WyOoUOmdGlFIDXQJIph71AnybFBJxTCH/9QCsYBVkeqH69cFZ
	 kdJa1823sj/xND/jfKljCb0Lx9GgKFzW3QZ82d+eHtd/d2ZVOKfdo8F3HXA2WJUI4r
	 hru9nh6ffzXlcKn92jrOy6RILMtv+WhaU4VAXu4gzcxbhCd4kwubi3Gp3SQDNKjNR8
	 lVzefT2Niqa2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/12] perf jitdump: Free event in
 jit_repipe_code_move()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-8-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:33:39 +0000
Message-Id: <20260805143340.2673B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential heap out-of-bounds read and information leak due to hard=
coded memory allocation padding versus dynamic header size.
--

--- Patch [7]: [PATCH 07/12] perf jitdump: Free event in jit_repipe_code_mo=
ve() ---
commit 11d0d0b8d917333552119016252e41efe5f10dbc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Free event in jit_repipe_code_move()

jit_repipe_code_move() allocates a perf_event with calloc but never
frees it =E2=80=94 the 'out' label exits with only perf_sample__exit().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index c3f11d1c1d76d..4f52b143cd0da 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -683,6 +683,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)

[Severity: High]
This isn't a bug introduced by this patch, but could the hardcoded + 16
allocation padding lead to an out-of-bounds heap read in
jit_repipe_code_move()?

The event buffer is allocated with a hardcoded 16 bytes of padding:

	event =3D calloc(1, sizeof(*event) + 16);

Later, the header size is computed dynamically using idr_size:

	event->mmap2.header.size =3D (sizeof(event->mmap2) -
			(sizeof(event->mmap2.filename) - size) + idr_size);

If the jitted filename path length reaches PATH_MAX, the subtraction
(sizeof(...) - size) approaches 0, making the header.size evaluate to
sizeof(event->mmap2) + idr_size.

When idr_size (the sample ID header payload size) exceeds 16 bytes, which
can happen when multiple PERF_SAMPLE_* flags are requested, the computed
header.size will exceed the allocated chunk size.

Could this cause jit_inject_event() to call perf_data__write() with a size
larger than the allocation, potentially leaking uninitialized heap memory
into the perf.data output file?

>  		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
>  out:
>  	perf_sample__exit(&sample);
> +	free(event);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D7
