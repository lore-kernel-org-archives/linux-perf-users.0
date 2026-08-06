Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D312BE056
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020724; cv=none; b=skjaq2gtGedh9LPLOpo6oiEMugnNiaqs/MBLGEKdYrHnUf7BT3CdD8yBoU2LoJFgPUVkpX/VVCibOCsAHBin3Pvl2vDbrhjZmqPKkq7TcDVi8oWnz67bNLALyS+5ydLn+T75cwo84hR3d9XDTzzkvDQ3bFAWpVFm7e80MBIiTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020724; c=relaxed/simple;
	bh=l0rD98BGGD8J1NLoO4ZGXPa25t7t6+TSaUl0i6NhdFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s2mDQFlVKocROURhG25RD9kvBMUeRph7ls/maTNLsnY+f8hPya/C807Fnw+DXlOhmx/PPCihBKxs6j/+AoHev4iMFttEYTPxtUhhaMsHVkSz4OlJIuQmokCOJW6bsEPqf+0i82yzuO5pLbLbm3i9FFV/53ndWm49vYuShQBAsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1MnH2zX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1MnH2zX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5E01F000E9;
	Thu,  6 Aug 2026 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020723;
	bh=YerniM0z7J8LG9rfvHyUBs/GW9igFUvR0HLSYO7pqyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H1MnH2zXE6WW8aQm+yP5js2UOOwwi/CREwJ25Jbh1EINlWa0c3phFZ3AxaawhEBtj
	 GXYGp/61e40W4LavB6csYc4mplsJPJSkj/U9wWrapSln5EjdLjK81/4qdvSP3Gh1eA
	 zzPTGcQtyxtyucXCnXWeQWBxPCLKAF+BsPR/1m+zl32YP+4VISdZKVSqAyDcdMCOLm
	 kkcIR4HuYb2sf2KlKrBCQR03oRXKbIg4fu94+PK1BIkPVTQVX5RIwt/Ooaa7Aviv1r
	 ZMQVWMc6UpXn1SRz0hoOZFk16o/aLlAvoBWZVY5XM4+MRnaGAOPuZknXngKyq9Z4ix
	 dToZfhnoNJbYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] perf jitdump: Fix debug_data and unwinding_data
 leaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-3-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:52:02 +0000
Message-Id: <20260806125203.3D5E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `csize` value from the untrusted JIT dump file is not vali=
dated against `total_size`, allowing an integer underflow that leads to a m=
assive out-of-bounds heap read and information leak.
- [Critical] Output `.so` files are opened without `O_EXCL` and `O_NOFOLLOW=
` in a potentially attacker-controlled directory, allowing a symlink attack=
 to overwrite arbitrary files.
- [High] Code load events fail to consume and free `unwinding_data` and `de=
bug_data` if their respective auxiliary sizes or counts are zero, leading t=
o state contamination.
- [High] Calling `funlockfile()` without a preceding `flockfile()` on the `=
malloc()` error path causes undefined behavior.
- [High] Missing bounds check on the JIT record `total_size` before accessi=
ng the `sym` string pointer causes an out-of-bounds string read.
--

--- Patch [2]: [PATCH 02/12] perf jitdump: Fix debug_data and unwinding_dat=
a leaks ---
commit e7687575b20ca5df1e7780e1c7b436a5bc7d2f8c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Fix debug_data and unwinding_data leaks
   =20
This commit fixes memory leaks in jit_repipe_debug_info() and jit_close().
It uses zfree() to correctly free existing allocations before reassignment
and cleans up at the end of the session.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -61,12 +61,12 @@ static int
>  jit_emit_elf(struct jit_buf_desc *jd,
>  	     char *filename,
[ ... ]
>  	nsinfo__mountns_enter(jd->nsi, &nsc);
>  	fd =3D open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0644);

[Severity: Critical]
This isn't a bug introduced by this patch, but opening output files without
O_EXCL and O_NOFOLLOW in a potentially attacker-controlled directory might
allow a symlink attack to overwrite arbitrary files.

Could this be updated to use safer open flags?

[ ... ]

> @@ -117,6 +117,8 @@ jit_close(struct jit_buf_desc *jd)
>  	funlockfile(jd->in);
>  	fclose(jd->in);
>  	jd->in =3D NULL;
> +	zfree(&jd->debug_data);
> +	zfree(&jd->unwinding_data);
>  }

[ ... ]

> @@ -154,9 +154,9 @@ static int
>  jit_open(struct jit_buf_desc *jd, const char *name)
>  {
[ ... ]
>  	bsz =3D hmax(sizeof(header), sizeof(*prefix));
>=20
>  	buf =3D malloc(bsz);
>  	if (!buf)
>  		goto error;
>=20
>  	/*
>  	 * protect from writer modifying the file while we are reading it
>  	 */
>  	flockfile(jd->in);
[ ... ]
> @@ -217,9 +217,9 @@ static int
>  	return 0;
>  error:
>  	free(buf);
>  	funlockfile(jd->in);

[Severity: High]
This isn't a bug introduced by this patch, but if the initial malloc(bsz)
fails, we jump to error and call funlockfile(jd->in) without a preceding
flockfile().

Does calling funlockfile() on an unlocked FILE stream cause undefined
behavior or corruption of internal libc mutexes here?

>  	fclose(jd->in);
>  	return retval;
>  }

[ ... ]

> @@ -465,10 +465,10 @@ static int jit_repipe_code_load(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  	nspid =3D jr->load.pid;
>  	pid   =3D jr_entry_pid(jd, jr);
>  	tid   =3D jr_entry_tid(jd, jr);
>  	csize =3D jr->load.code_size;
>  	usize =3D jd->unwinding_mapped_size;
>  	addr  =3D jr->load.code_addr;
>  	sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));

[Severity: High]
This is a pre-existing issue, but is it possible for jr->load.p.total_size
to be smaller than sizeof(jr->load)?

The sym pointer is derived assuming total_size is at least 56 bytes, which
isn't validated before access. Could this lead to an out-of-bounds string
read if a smaller total_size is provided?

>  	code  =3D (unsigned long)jr + jr->load.p.total_size - csize;

[Severity: Critical]
This is a pre-existing issue, but the code pointer is calculated using csize
without checking if it exceeds total_size.

Could an attacker provide a csize larger than total_size to cause an integer
underflow, resulting in a massive out-of-bounds heap read and information
leak into the generated ELF file?

>  	count =3D jr->load.code_index;
>  	idr_size =3D jd->machine->id_hdr_size;
[ ... ]
> @@ -475,10 +475,10 @@ static int jit_repipe_code_load(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  	event =3D calloc(1, sizeof(*event) + idr_size);
>  	if (!event)
>  		return -1;
>=20
>  	filename =3D event->mmap2.filename;
>  	size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
>  			jd->dir,
>  			nspid,
>  			count);

[Severity: Critical]
This isn't a bug introduced by this patch, but the filename is predictably
constructed using fields (nspid and count) controlled by the JIT dump.

Combined with the lack of O_EXCL|O_NOFOLLOW in jit_emit_elf(), does this
allow an attacker to perform a symlink attack when perf inject is run?

[ ... ]

> @@ -495,10 +495,10 @@ static int jit_repipe_code_load(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  		jd->nr_debug_entries =3D 0;
>  	}
>=20
>  	if (jd->unwinding_data && jd->eh_frame_hdr_size) {
>  		zfree(&jd->unwinding_data);
>  		jd->eh_frame_hdr_size =3D 0;
>  		jd->unwinding_mapped_size =3D 0;
>  		jd->unwinding_size =3D 0;
>  	}

[Severity: High]
This is a pre-existing issue, but this conditional cleanup leaves
jd->unwinding_data dangling if eh_frame_hdr_size is zero.

If a JIT runtime emits JIT_CODE_UNWINDING_INFO without .eh_frame_hdr, is the
unwinding data incorrectly applied to all subsequent JIT_CODE_LOAD events
until overwritten, producing corrupted ELF files?

[ ... ]

> @@ -665,6 +667,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc =
*jd, union jr_entry *jr)
> =20
>  	memcpy(data, &jr->info.entries, sz);
> =20
> +	zfree(&jd->debug_data);
>  	jd->debug_data       =3D data;
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D2
