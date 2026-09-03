Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71654B0CBC
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443274; cv=none; b=jfg8+bLdVEpwSuJExzcy5nmQxQLTfvTJ2ACu3PEOQe2GqGIZPS0bao0Lk70EggHmnBRLq1H0HNRzmWgVavuKRA8PEPX2YWE8+1aYAVkGKTgglmIl8RwaPkQ0AUMdLwLQIdUJ7oiOC1OhbzvpT6mxRwXiJSQBkWSnF+naFU5LGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443274; c=relaxed/simple;
	bh=9s7cqiAiI75ytgf1ML88FJQASmatqWu8SuiYkUFZTMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cTB8mvJqLSZgVNfp6CYajMhKqpE2kPMVtPXgG4wIgAVYohgp1qJ5UpVG92cuSev9c+4OwsehYxjV6yUibGzoEHdj7Z6NWxQvzdU1HfJ7lwCUIGx2Paf/YwJjNoNsTMLIo4hjQn0D8zyB1oGOdWBGivbXJKWE6gnZnqZYoyh2ewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5E2sQ6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5E2sQ6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B52C1F00A3E;
	Thu,  3 Sep 2026 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443257;
	bh=WGHr7S2l2DO60UiXctqJIvgdlSXieTaHahXU69zI2JQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5E2sQ6tAyroP06QZou32cOp5DelNHcG5gKtpvP3ij35abZgk3zk+9+T+hFxldZV8
	 9aNhcyUK0VrESg4qnhWCYx5tfd/ZlI7HV0j8WGvTAYOU3XGWZ/q8d43+sUwQG/TBxj
	 XQMSWw6WY+Dh1ixK3/J0cqwGtObU14qZv9nPUOQ8f1c2qccSypGxGjr5YEht+WUGXo
	 amoHknSMXokZ+vPxpK3ssrnnftsCdNgDDUex1ZuSKfqK0q67fHtGpR+o0Do2SvG1He
	 UrzMup7/8BfxO8/b7dJcpymoNh7taMthYQ7mSe+bvb6CmEL+Wn3jemVyqCcL/BDeDb
	 r790GaXsrsUEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf jitdump: Size code_move event allocation with
 idr_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903132251.237029-5-acme@kernel.org>
References: <20260903132251.237029-1-acme@kernel.org>
 <20260903132251.237029-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 13:47:37 +0000
Message-Id: <20260903134737.9B52C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing the hardcoded +16 padding with +idr_size introduces =
a heap buffer overflow in jit_repipe_code_move() when PERF_SAMPLE_TID is mi=
ssing but PERF_SAMPLE_TIME is present, and the filename length approaches P=
ATH_MAX. This shares the same root cause as a pre-existing vulnerability in=
 jit_repipe_code_load().
--

commit 631d6cebecdf5de246fc9c8ce57d27948626c5ac
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf jitdump: Size code_move event allocation with idr_size

This commit alters the event buffer allocation in jit_repipe_code_move()
to dynamically scale with idr_size rather than using a static padding.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c

[ ... ]

> @@ -636,9 +636,10 @@ static int jit_repipe_code_move(struct jit_buf_desc =
*jd, union jr_entry *jr)
>  	idr_size =3D jd->machine->id_hdr_size;
> =20
>  	/*
> -	 * +16 to account for sample_id_all (hack)
> +	 * Sample ID is written past the end of the mmap2 record; size
> +	 * the allocation to account for it instead of a hardcoded +16.
>  	 */
> -	event =3D calloc(1, sizeof(*event) + 16);
> +	event =3D calloc(1, sizeof(*event) + idr_size);

[Severity: Critical]
Does this regression introduce a heap buffer overflow when setting the event
time?

Looking later in jit_repipe_code_move(), we calculate the id pointer based =
on
header.size and idr_size:

    id =3D (void *)((unsigned long)event + event->mmap.header.size - idr_si=
ze);
    if (jd->sample_type & PERF_SAMPLE_TID) {
        id->pid  =3D pid;
        id->tid  =3D tid;
    }
    if (jd->sample_type & PERF_SAMPLE_TIME)
        id->time =3D convert_timestamp(jd, jr->load.p.timestamp);

If PERF_SAMPLE_TID is missing from the configured sample type but
PERF_SAMPLE_TIME is present, idr_size evaluates to 8, making the allocation
size become sizeof(*event) + 8.

Because id->time is located at an 8-byte offset within the id structure
(after pid and tid), writing to id->time accesses memory 8 bytes past the
start of id.

When the filename string approaches PATH_MAX and header.size nears the base
allocation size, this writes exactly past the end of the calloc heap
allocation. Could this memory corruption be triggered by parsing a
maliciously crafted perf.data file?

This is a pre-existing issue, but does this exact same pattern also cause
an out-of-bounds write in jit_repipe_code_load()?

Looking at jit_repipe_code_load(), it similarly uses the idr_size for its
allocation limit and unconditionally performs the same timestamp assignment:

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
    event =3D calloc(1, sizeof(*event) + idr_size);
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

Should both load and move operations account for the struct offset of
id->time when sizing the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903132251.2370=
29-1-acme@kernel.org?part=3D4
