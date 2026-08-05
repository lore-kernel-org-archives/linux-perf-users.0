Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E557F26A0D5
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939214; cv=none; b=eS+gdy6HJArCeTWF3a5PfEknt0Z1YsdflZVC/Tmu83lJq4tGF42l8TlGmlveoNqneECdQbELaUs9TIEErUcNKenCC3MMGR8WoA+YeiV9QXvNOAloqpTVUUUcnWgcYs0ssYtNXgcyXn8Q+dSisI3EVNip+69mEVD0PYTf5HrFR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939214; c=relaxed/simple;
	bh=8BsqkZUabN+Bqwq20PSGD2Whl8GPWuyOaE7qinLA6eM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ugdr0HVZrxcsd87libZAF2KGItohqhaxovg5mdvUt+FVRmbxZhKX3IEGWA/+Y4FooqJ+9osIdXkdCES3Bqab4fMkrA12xd0k8nCpQfJRD9Be9HXS7CGWzurrhUC9Tel+J0Ld++usVB1vEHEyinlJNX2CqnYTuP2BQDzICRNYDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckF19Lux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckF19Lux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3507F1F000E9;
	Wed,  5 Aug 2026 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939212;
	bh=QFffFOCZRI0MAtlCJKdtHMRptpNf427ZfrjicmAd7oU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckF19LuxexzFI9NZnsdEUKyxBliFLhvEGJOrX3Nua/XIzLy0uNkpT2sAdmPccxCp/
	 bFXvPl4vKkjmf1CZVy35cMnE7DKTvGVjxZ8Dm272XjGLhc7U1ZiSQX+GyTwmtKt/Zl
	 6j4Fp/iceP8z+MZzRqVlQEmkzgYcCs7C9gDagufym1agudlfiva9pWwNW6PcSWyPqc
	 ZbtnuzOumKlgWT5q9vJtSvUpV6Wm5XUcE5VEOJKMHWKC4MNfL/nJUD7wMCpJQ2SKUw
	 abn0FuLIajEmCvtCxyvRlftbA7gjqNgZ+CM4A2D35HP3Cr99X6I/2gBvKhlu7xDL3t
	 hR5bsvBPDQrkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] perf jitdump: Use dirname() return value in
 jit_open()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-10-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:13:31 +0000
Message-Id: <20260805141332.3507F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing total_size validation in JIT_CODE_MOVE record processing a=
llows uninitialized heap memory to be leaked into the output perf.data file.
- [High] An insufficient memory allocation in jit_repipe_code_move() causes=
 a heap out-of-bounds read when writing the generated event to the output f=
ile.
--

--- Patch [9]: [PATCH 09/12] perf jitdump: Use dirname() return value in ji=
t_open() ---
commit 8e32408a1e72fef109700c74dd502aaacc3125c7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Use dirname() return value in jit_open()

jit_open() calls dirname(jd->dir) but ignores the return value.  POSIX
says dirname() may return a pointer to internal static storage =E2=80=94 gl=
ibc
does this when the path has no '/', returning "." from a static buffer
and leaving jd->dir unchanged with the original filename.

Capture the return value and copy it back to jd->dir when dirname()
returns a different pointer.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 3085091b95a51..02840dbf8a1fc 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c

[ ... ]

> static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *=
jr)
> {
> 	struct perf_sample sample;
> 	union perf_event *event;
> 	const struct perf_tool *tool =3D jd->session->tool;
> 	char *filename;
> 	size_t size;
> 	struct stat st;
> 	int usize;
> 	u16 idr_size;
> 	int ret;
> 	pid_t nspid, pid, tid;
> 	struct {
> 		u32 pid, tid;
> 		u64 time;
> 	} *id;
>=20
> 	nspid =3D jr->load.pid;
> 	pid   =3D jr_entry_pid(jd, jr);
> 	tid   =3D jr_entry_tid(jd, jr);

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing bounds ch=
eck
here?

Unlike jit_repipe_code_load(), this function appears to blindly access fiel=
ds
from the code move record without first verifying that the record total_size
is at least sizeof(jr->move).

If a parsed jitdump file contains a truncated code move record, could this
read uninitialized fields from the jd->buf buffer and leak leftover heap da=
ta
into the output perf.data file?

> 	usize =3D jd->unwinding_mapped_size;
> 	idr_size =3D jd->machine->id_hdr_size;
>=20
> 	/*
> 	 * +16 to account for sample_id_all (hack)
> 	 */
> 	event =3D calloc(1, sizeof(*event) + 16);

[Severity: High]
This is a pre-existing issue, but is this allocation large enough for the
generated event?

The memory is allocated with a hardcoded + 16 extra bytes. If the session's
sample_type includes multiple fields (like CPU, TIME, and TID), idr_size can
easily exceed 16 bytes.

> 	if (!event)
> 		return -1;

[ ... ]

> 	event->mmap2.header.type =3D PERF_RECORD_MMAP2;
> 	event->mmap2.header.misc =3D PERF_RECORD_MISC_USER;
> 	event->mmap2.header.size =3D (sizeof(event->mmap2) -
> 			(sizeof(event->mmap2.filename) - size) + idr_size);

[Severity: High]
This is also a pre-existing issue related to the allocation above, but might
this cause a heap out-of-bounds read?

When the header size is calculated here using the dynamically larger idr_si=
ze,
the size will exceed the allocated space by (idr_size - 16) bytes.

Would this cause perf_data__write() to read out-of-bounds heap memory?

Should the code dynamically allocate (sizeof(*event) + idr_size) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D9
