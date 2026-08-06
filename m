Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CB30C16E
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021434; cv=none; b=pV2qftWGnIxxoGsEe2sc99Sz7rfPKP1C3grL+/jUMBqA5CopO5/fPH6HGe3S431HQiKYI6JrRAEmdKxj8cnoJunFt1s2hwcjCXm+mpBqgdBUgjpldZDZXpDvsMSJgM7I71Pu2oiVAbKUSZ86vvHp/bwDrMOaH7v4gSnxcYjZT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021434; c=relaxed/simple;
	bh=UloDeS9nPGvLO+qUOSQhw0WyYn0rMm5lYkWMNavu+O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uoL4TAehrhIKDPBviZ168ab6NxjJDCtDXBa+uCXcXVDDaAcc9TOIZ6AhRo8bSgzyVzARuxhG3k4LPjUXpv1nubjmfvBvmTT52bYCK2t2dr5ALjX3KwSEo7cZ4xozmoD/wzIpjE0QOSzrWs5dsxYwG7/fb7/1R4kdt7XGQQ4yKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKnrchbs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKnrchbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CA91F00A3A;
	Thu,  6 Aug 2026 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021429;
	bh=4J6hQ5nLXez/MirN5mQl9Y3kjWVby7jPqK/LJLiBQyw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKnrchbs5yKxAkdWhFsDWJgdK6vr5UCIgWI4rAreBRhAWGST5iN1qQcvw2FkyUBVW
	 njm16oG7l+PGYOpbPWnzh/s6BP4yP4sl73F1I3YazbCZtJP3ldUNdvCTDGA0wOJq/x
	 0hjzMRqZvB+UvFwBUlIZgke8Rv4GTUzNsWHxX0Rxb9iQzWvaoU0crC4/eQ6TCDpzJe
	 yZtuqCrJP4ij6vPaM9m6MAwMrxdJHLtCJZ7aqLtAKKBbrT2q89caN/sDnvnCiXy9da
	 Ktq01qJAR2vZFoFitvGG27PpHrMD9Pj1SFBEK5yk6b9bXaEuEkmmrfj/nYqbCYwJWG
	 gAsXu/Y5Yg4kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] perf jitdump: Validate sym string NUL-termination
 in code load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-12-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:03:49 +0000
Message-Id: <20260806130349.A0CA91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap Buffer Overflow / Out-of-bounds Write in JIT event synthe=
sis due to hardcoded sample ID struct.
- [High] Out-of-bounds Read / Information Leak in `jit_repipe_code_move` du=
e to fixed 16-byte sample ID allocation.
--

--- Patch [11]: [PATCH 11/12] perf jitdump: Validate sym string NUL-termina=
tion in code load ---
commit 6b4b582de49c92ce6528fb28a944ec4bfb31b834
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate sym string NUL-termination in code load

jit_repipe_code_load() computes sym =3D (void *)jr + sizeof(jr->load) and
passes it to jit_emit_elf() which calls strlen(sym) via jit_write_elf().
If code_size equals total_size - sizeof(jr->load), the sym pointer
aliases the code blob with no NUL terminator, and strlen() scans past
the buffer into adjacent heap memory.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 5a3ea2681fb37..5898a7d8eb962 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -487,6 +487,13 @@ static int jit_repipe_code_load(struct jit_buf_desc =
*jd, union jr_entry *jr)
> =20
>  	sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
>  	code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
> +
> +	/* sym string lives between the load header and the code blob */
> +	if (!memchr(sym, '\0', code - (unsigned long)sym)) {
> +		pr_warning("jitdump: unterminated symbol name in code_load record\n");
> +		return -1;
> +	}
> +
>  	count =3D jr->load.code_index;
>  	idr_size =3D jd->machine->id_hdr_size;
> =20

[Severity: Critical]
This isn't a bug introduced by this patch, but I noticed a potential
out-of-bounds write later in jit_repipe_code_load() and
jit_repipe_code_move() when setting up the sample ID:

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
    id =3D (void *)((unsigned long)event + event->mmap.header.size - idr_si=
ze);
    if (jd->sample_type & PERF_SAMPLE_TID) {
        id->pid  =3D pid;
        id->tid  =3D tid;
    }
    if (jd->sample_type & PERF_SAMPLE_TIME)
        id->time =3D convert_timestamp(jd, jr->load.p.timestamp);
    ...
}

The code casts the end of the event payload to a hardcoded struct layout.
If the session is recorded with PERF_SAMPLE_TIME but without PERF_SAMPLE_TI=
D,
idr_size is 8 bytes.

The id pointer is placed 8 bytes before the end of the payload size, but
writing to id->time (at offset 8) will write exactly 8 bytes past the end of
the buffer.

Could this corrupt heap memory if the original filename is long enough to
maximize the event buffer?

[Severity: High]
This is also a pre-existing issue, but could this calculation in
jit_repipe_code_move() lead to an out-of-bounds read?

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
    event =3D calloc(1, sizeof(*event) + 16);
    ...
    event->mmap2.header.size =3D (sizeof(event->mmap2) -
            (sizeof(event->mmap2.filename) - size) + idr_size);
    ...
}

The allocation hardcodes 16 bytes for the sample ID payload, but header.size
incorporates idr_size.

If the session was recorded with multiple sample attributes, idr_size can
exceed 16 bytes.

If the calculated header.size exceeds the allocated heap size, will
perf_data__write() read past the end of the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D11
