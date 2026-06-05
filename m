Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5FC4779A3
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643034; cv=none; b=A2gD96iq6W7MQIRjHJH/+k34zqD+708kKbovGpX3Gl8hFneHiewnWNRFqJw5bxlFv6uF3sDeZCBXfGWALNz+NhZn/qrhZt+s+TkqV0mjOOFdoLat1eILAohJHBZVhzpyynNB7/gpmw8siZhmoVk1uTELkVI4RXdjU4cneeWJevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643034; c=relaxed/simple;
	bh=orTatLZFysVaUy6o+hUzN+zoJt9P7EJYOvzrKf5mqJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nwr0wmO9hfRpcwlCIBpfdYJARXyae6o4Wn7LFS6cGOEQjTjx1HowkZOpN5AoFiLbiovyA3FX0jitC9ORdNY3dBtYlqlztjISehipK8lnEIfjkiDVk777JolvrV/M/29CAojqR1m8HgGKCYUQHgqNpCWYlMSLysrGhiJN02bkJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gebCFJu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gebCFJu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27A41F00893;
	Fri,  5 Jun 2026 07:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780643030;
	bh=2ND8QX0fRJ2yTsN0l9fmVqaZuS9F5ZRVgZzkdMJiSqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gebCFJu1wD84ensTcetX93nc63QaJAo68qDxg4RyvvA+J1frbRIfBiVhwuUFnBILo
	 exvNsuzZuYoK+jmBQqweJKIZaSzdwhDs/y/5SSwkN/TPJRGccePh2h5cKIznChJhm3
	 0tWXYXv9V8uPXoBI3fMHLtjVetYR8bJV44TL4I0EMRPTF+BbiedB4LxzJtCanA/+yo
	 YYmgARNVtSaAFfR58JTLKX3UfEcxDt+U4oexSU7zGCorm54DTGItxTQojU8UkwlK1N
	 BUQfSP4mJBoBzNW94z3/0EnF/ln4DXwp+KEDeQEFIDpM//Uz03sJcuZS5bEJCC9rIj
	 j5F/0xTm3rkAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf jitdump: Fix a build error with ASAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605064932.34316-1-namhyung@kernel.org>
References: <20260605064932.34316-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 07:03:49 +0000
Message-Id: <20260605070349.E27A41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

Pre-existing issues:
- [High] Unlocking an unlocked stream on the error path causes undefined be=
havior.
- [High] Incorrect logic for skipping extended jitdump headers leads to par=
sing failure.
- [High] Ignoring the return value of `dirname()` breaks directory extracti=
on and causes ENOTDIR failures.
- [High] If the generated JIT ELF path exceeds PATH_MAX, snprintf truncatio=
n causes size underflow resulting in a heap buffer overflow.
- [High] Cross-endian byte swapping of JIT_CODE_DEBUG_INFO records corrupts=
 data by ignoring the flexible array member.
- [High] Lack of validation on `code_size` enables arbitrary out-of-bounds =
read and memory leakage.
- [Medium] Memory leak of `debug_data` and `unwinding_data` pointers.
- [Medium] Memory leak of `event` in `jit_repipe_code_move`.
- [Medium] Ineffective inter-process synchronization using `flockfile`.
- [Medium] Integer underflow leading to massive malloc in `jit_repipe_debug=
_info`.
--

commit f314399f4edf9366c3ee4d529f45cb2d7e7d454d
Author: Namhyung Kim <namhyung@kernel.org>

perf jitdump: Fix a build error with ASAN

This patch resolves a stringop-truncation build error when compiling perf
with ASAN on GCC 16. It reduces the strncpy bound by one byte to avoid
truncation warnings.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index e0ce8b9047298..16390e7f9062d 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -234,7 +234,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>  	/*
>  	 * keep dirname for generating files and mmap records
>  	 */
> -	strncpy(jd->dir, name, PATH_MAX);
> +	strncpy(jd->dir, name, PATH_MAX - 1);
>  	jd->dir[PATH_MAX - 1] =3D '\0';
>  	dirname(jd->dir);

[Severity: High]
This isn't a bug introduced by this patch, but is it correct to ignore the
return value of dirname()?

If jd->dir contains no slashes, glibc dirname() returns a pointer to "." but
leaves the original string unmodified. Since the return value is discarded,
jd->dir retains the full filename instead of becoming ".". This could cause
later snprintf calls to use the target file as a directory component, leadi=
ng
to ENOTDIR failures.

>  	free(buf);

[Severity: High]
This is a pre-existing issue, but does the error handling path incorrectly
unlock an unlocked stream?

If malloc() fails early in jit_open(), it jumps to the error label:

tools/perf/util/jitdump.c:jit_open() {
    ...
	buf =3D malloc(bsz);
	if (!buf)
		goto error;

	/*
	 * protect from writer modifying the file while we are reading it
	 */
	flockfile(jd->in);
    ...
error:
	free(buf);
	funlockfile(jd->in);
	fclose(jd->in);
	return retval;
}

Since flockfile() is only called after malloc() succeeds, calling funlockfi=
le()
here results in undefined behavior on an unlocked stream.

[Severity: High]
This is a pre-existing issue, but does this logic break extended header rea=
ds?

In jit_open(), when handling extended headers, bsz is updated to bs right
before calculating the read size:

tools/perf/util/jitdump.c:jit_open() {
    ...
	if (bs > bsz) {
		n =3D realloc(buf, bs);
		if (!n)
			goto error;
		bsz =3D bs;
		buf =3D n;
		/* read extra we do not know about */
		ret =3D fread(buf, bs - bsz, 1, jd->in);
		if (ret !=3D 1)
			goto error;
	}
    ...
}

Because bsz =3D bs, the read size bs - bsz is always 0. fread() will return=
 0,
causing the ret !=3D 1 check to fail and unconditionally jump to the error =
path.

[Severity: High]
This is a pre-existing issue, but could snprintf() truncation cause an
out-of-bounds pointer calculation?

In jit_repipe_code_load(), snprintf() calculates a path:

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
	filename =3D event->mmap2.filename;
	size =3D snprintf(filename, PATH_MAX, "%s/jitted-%d-%" PRIu64 ".so",
			jd->dir,
			nspid,
			count);

	size++; /* for \0 */

	size =3D PERF_ALIGN(size, sizeof(u64));
    ...
	event->mmap2.header.size =3D (sizeof(event->mmap2) -
			(sizeof(event->mmap2.filename) - size) + idr_size);
    ...
	id =3D (void *)((unsigned long)event + event->mmap.header.size - idr_size);
	if (jd->sample_type & PERF_SAMPLE_TID) {
		id->pid  =3D pid;
    ...
}

If the string exceeds PATH_MAX, snprintf() returns the untruncated length. =
The
expression sizeof(event->mmap2.filename) - size will then underflow because=
 size
is greater than PATH_MAX, resulting in a massively inflated header.size. The
pointer id will point outside the allocated bounds, leading to heap corrupt=
ion
when id->pid is assigned.

[Severity: High]
This isn't a bug introduced by this patch, but does the byte-swapping logic
corrupt data by ignoring a flexible array member?

In jit_get_next_entry():

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
	case JIT_CODE_DEBUG_INFO:
		if (jd->needs_bswap) {
			uint64_t n;
			jr->info.code_addr =3D bswap_64(jr->info.code_addr);
			jr->info.nr_entry  =3D bswap_64(jr->info.nr_entry);
			for (n =3D 0 ; n < jr->info.nr_entry; n++) {
				jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
				jr->info.entries[n].lineno  =3D bswap_32(jr->info.entries[n].lineno);
				jr->info.entries[n].discrim =3D bswap_32(jr->info.entries[n].discrim);
			}
		}
		break;
    ...
}

struct debug_entry contains a flexible array member (const char name[]). Us=
ing
array indexing (jr->info.entries[n]) assumes fixed-size elements. This will
calculate incorrect offsets that land inside the variable-length strings of
earlier entries, overwriting them with byte-swapped data.

[Severity: Medium]
This is a pre-existing issue, but do jd->debug_data and jd->unwinding_data =
leak?

In jit_repipe_debug_info(), memory is allocated and assigned:

tools/perf/util/jitdump.c:jit_repipe_debug_info() {
    ...
	data =3D malloc(sz);
	if (!data)
		return -1;

	memcpy(data, &jr->info.entries, sz);

	jd->debug_data       =3D data;
    ...
}

While these are freed during jit_repipe_code_load(), if a JIT dump terminat=
es
early, lacks trailing load records, or contains consecutive debug records, =
the
previously allocated buffers are overwritten or never freed. Neither jit_cl=
ose()
nor jit_process() cleans up jd->debug_data or jd->unwinding_data.

[Severity: Medium]
This isn't a bug introduced by this patch, but does jit_repipe_code_move() =
leak
its event allocation?

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
	event =3D calloc(1, sizeof(*event) + 16);
	if (!event)
		return -1;
    ...
out:
	perf_sample__exit(&sample);
	return ret;
}

The event buffer is dynamically allocated but there is no free(event) in the
cleanup block, leaking the memory for every JIT_CODE_MOVE record processed.

[Severity: Medium]
This is a pre-existing issue, but is flockfile() being used incorrectly for
inter-process synchronization?

In jit_open():

tools/perf/util/jitdump.c:jit_open() {
    ...
	/*
	 * protect from writer modifying the file while we are reading it
	 */
	flockfile(jd->in);
    ...
}

flockfile() is a POSIX thread mutex that provides no OS-level file locking.
It cannot prevent an external process from modifying the file concurrently,
making this synchronization completely ineffective against external writers.

[Severity: Medium]
This isn't a bug introduced by this patch, but could this allocation size c=
alculation
underflow?

In jit_repipe_debug_info():

tools/perf/util/jitdump.c:jit_repipe_debug_info() {
    ...
	sz  =3D jr->prefix.total_size - sizeof(jr->info);
	data =3D malloc(sz);
    ...
}

If total_size is smaller than sizeof(jr->info), the unsigned subtraction wi=
ll
underflow to a massive value, leading to a guaranteed malloc() failure or
instability if memory is overcommitted.

[Severity: High]
This is a pre-existing issue, but does lack of validation on code_size allow
out-of-bounds reads?

In jit_repipe_code_load():

tools/perf/util/jitdump.c:jit_repipe_code_load() {
    ...
	csize =3D jr->load.code_size;
    ...
	code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
    ...
	ret =3D jit_emit_elf(jd, filename, sym, addr, (const void *)uaddr, csize, =
...
    ...
}

If an artificially large csize is parsed from the file without being bounds
checked against total_size, the code pointer calculation will underflow and
point into earlier heap memory. jit_emit_elf() will then dump csize bytes
from this out-of-bounds memory into the ELF file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605064932.3431=
6-1-namhyung@kernel.org?part=3D1
