Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97874381E98
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939925; cv=none; b=M2ZJbZDqY966vl3cr3x3VmRI2uTm4jbeQo0sPrKwO58JYslWTm0gC6tPoMUUgZlpcJZJhx7rcCob3yG84Zgrno8t/zKPV2kd6rmJiRVo6HQ+lTXxxOI91pn8fo79aDlRu/G225WEywjMg7IBnf1M2QI8tafU8DFGLXWavbvKG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939925; c=relaxed/simple;
	bh=30wvbazIE+LGx6NNvPlnJoRar4sa+e507i8B25G+L9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hq7ugyP1PLHoipqgPVEci/hF4uVawoDAoBcsRLFJMhjTxEGSeNmQpe98CY5AAzTJ9AkLzS8t4w8clKBxGa+3S5CDn2gwQwyePGPuEPh3NIk0k3mCoLGq4f+4M4CgV5m9xNkhgs2STCNk1zdfdxwPu7CmXBp1YDslrw2j3ZBrGGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGgbHdl9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGgbHdl9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEC61F000E9;
	Wed,  5 Aug 2026 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939916;
	bh=lIkfQavtDusISmKkLO4tuIxyx7QkuJLbu0sQ/NaB4Ow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OGgbHdl94iQ+fJ3Bbvs0PwzSLHfsyyi/vhkl4aPk4G0NUUpCPxNfpqURdwdSSifvg
	 JV5t8mIvskX/hI0Mphm0Jagx/3Tc5RXVv+/50A1umfV5fLImfCYfilhAonR4W5OSbR
	 X6nkQXWL7cDZNXrbAbHb1gI6ygZNOny6YL0mOQ6edZ9U9XILCpffV18S4x1nATTlI6
	 Nm1JL4LE4FyjP5rJxqv8vm4sTIDh0wTYGwZqOBZQptEgJFBsIdZAfF4OZJKMYTIr46
	 mq+Xr2PS/m46pxe46J/2Xn7Mp8eOOy4qS/Ndds67wte+FGc6RlGugTwOKAcCVptq4V
	 ELSj8QegoLDcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] perf jitdump: Check snprintf return before
 computing header size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-6-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:25:16 +0000
Message-Id: <20260805142516.8FEC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Insufficient heap allocation in `jit_repipe_code_move` when `idr_s=
ize` exceeds 16 bytes causes an out-of-bounds heap read and information lea=
k.
- [High] The dynamically allocated `event` buffer is never freed in `jit_re=
pipe_code_move()`.
- [High] Hardcoded sample ID structure layout causes a heap out-of-bounds w=
rite and event corruption when standard layout assumptions are violated.
- [High] Predictable filenames are opened without `O_EXCL` and `O_NOFOLLOW`=
 in a potentially shared directory, enabling a symlink attack to overwrite =
arbitrary files.
--

--- Patch [5]: [PATCH 05/12] perf jitdump: Check snprintf return before com=
puting header size ---
commit c4d5fd2e9b69d8618378d2b3d3ea73b74c28f945
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Check snprintf return before computing header size

This commit clamps the return value of snprintf to PATH_MAX - 1 when comput=
ing
the length of a generated JIT filename. This prevents an out-of-bounds heap
read/write caused by size underflow when the jitted filename exceeds PATH_M=
AX.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 078d3304d2b7e..fd11e07bf00b7 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  			jd->dir,
>  			nspid,
>  			count);

[Severity: High]
This is a pre-existing issue, but does this predictable filename creation a=
llow
for a symlink attack?=20

The filename is constructed using jd->dir, which could be a world-writable =
or
attacker-controlled path. When jit_emit_elf() subsequently creates this fil=
e,
it omits O_EXCL and O_NOFOLLOW:

    fd =3D open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0644);

If a local attacker places a symlink in this directory pointing to a sensit=
ive
file like /etc/shadow, could this result in an arbitrary file overwrite when
the file is opened and truncated?

[Severity: High]
This isn't a bug introduced by this patch, but can the sample ID structure
layout assumption result in out-of-bounds heap writes?

In jit_repipe_code_load(), the pointer is mapped to the trailing bytes of t=
he
payload and cast to a hardcoded struct:

    id =3D (void *)((unsigned long)event + event->mmap.header.size - idr_si=
ze);
    if (jd->sample_type & PERF_SAMPLE_TID) {
        id->pid  =3D pid;
        id->tid  =3D tid;
    }
    if (jd->sample_type & PERF_SAMPLE_TIME)
        id->time =3D convert_timestamp(jd, jr->load.p.timestamp);

If the user configures the perf session to omit TID or include other fields
preceding TID, idr_size might only be 8 bytes for time. Writing to id->time
(at offset 8) would then write exactly 8 bytes out of bounds of the allocat=
ed
heap space. The identical struct mapping is also repeated later in
jit_repipe_code_move().

> +	/* snprintf returns would-be length on truncation, clamp to buffer */
> +	if (size >=3D PATH_MAX)
> +		size =3D PATH_MAX - 1;
> =20
>  	size++; /* for \0 */

[ ... ]

> @@ -623,6 +626,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  	         jd->dir,
>  		 nspid,
>  		 jr->move.code_index);

[Severity: High]
This isn't a bug introduced by this patch, but might the hardcoded buffer
allocation size in jit_repipe_code_move() lead to an out-of-bounds read?

The event buffer is allocated with a fixed 16 bytes for the sample ID:

    event =3D calloc(1, sizeof(*event) + 16);

However, the header size is computed using the dynamic idr_size:

    event->mmap2.header.size =3D (sizeof(event->mmap2) -
            (sizeof(event->mmap2.filename) - size) + idr_size);

If idr_size exceeds 16 bytes (for example, if the perf session is configured
with PERF_SAMPLE_TID | PERF_SAMPLE_TIME | PERF_SAMPLE_ID), header.size will
exceed the allocated bounds. When the event is later written in
jit_inject_event():

    size =3D perf_data__write(jd->output, event, event->header.size);

Could this result in reading past the end of the heap buffer and leaking
sensitive heap contents to the output file?

[Severity: High]
This is a pre-existing issue, but is there a memory leak of the dynamically
allocated event buffer in jit_repipe_code_move()?

The function allocates the event buffer, but appears to return on both succ=
ess
and error paths without freeing it:

out:
	perf_sample__exit(&sample);
	return ret;

Since perf can process millions of events in a single run, could leaking th=
is
buffer per move event rapidly exhaust system memory and lead to an
Out-Of-Memory crash during standard analysis?

> +	/* snprintf returns would-be length on truncation, clamp to buffer */
> +	if (size >=3D PATH_MAX)
> +		size =3D PATH_MAX - 1;
> =20
>  	size++; /* for \0 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D5
