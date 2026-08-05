Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255E47127E
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937610; cv=none; b=mMu7m68KpxiPyquHSlJpde1/DOmHV58Bsegy35LTa4arRNInq2kvXroYPK9S7+YKHxXYiQA+rWHEwbioVLp/Y7ZNf7De4wGLLsTWmIRYqZv3MPMkB6KILvwoVBf7R0LzBSONBWIdr7hLZkZ1ff0fOvQYBFmxcC9wQkUqmoCcN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937610; c=relaxed/simple;
	bh=hQTQ2cQfBEITS/Zvk5glbktoq3X/xfGM3gR7pqWapOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RHUDZIrvt1/SSB3yeWS7XtZu8Lynpl/SbIGVmZkUuK64j3QSc19witUNkuAso5un5ctIJPPzhf2eK+pduwqXe/Sf6796ZByr6UuOBh9lBiV4i4M/ikNasKht1T7w/aOaOJyHFEGhtJccExhj6YDslkznIjl1BGyp8kpHytQQC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEJLLeNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEJLLeNs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662921F000E9;
	Wed,  5 Aug 2026 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785937608;
	bh=cerBXqmCiNEysCGf89aJduciHSTkhNWrW8JKzOzRCM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JEJLLeNsz4Yzo8hsgLiCpdf0LvCY7bLJA3ZWqU0LMHDUTgkW72pBO9TJ+umD/ICug
	 a6rNwsHH9tMQY1gwxhDgP5wrCBCUcU/U0k+33Vsxxj0B8zrQ28j9ASinek+ovlK8r6
	 sXiVRxkjLmwAvxASDgh5TUomriXKL8bO8582VAZKwvvS6BNlMbKA337b8dGEHd8HZn
	 xnTUm++caA4uu+/IQuu6/7NXST9OdGtCChz0AP2Ok0ePVh+3vesK3grXDHqqhsRNH1
	 tWFrNDttmUfmwBBHmbmFqOXOoZUQcfy5+Av02EdCYowDaV2DtMkwf9ZvI3PlQbmBn/
	 UQrgDR/RicJig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] perf jitdump: Fix extended header read that
 always fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-2-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 13:46:47 +0000
Message-Id: <20260805134648.662921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing size validation in `jit_get_next_entry` allows out-of-boun=
ds heap access and arbitrary memory exfiltration.
- [High] Memory leak of the `event` structure in `jit_repipe_code_move`.
- [High] Memory leak of `debug_data` and `unwinding_data` buffers.
- [Medium] Undefined behavior from calling `funlockfile()` on an unlocked s=
tream during early initialization error paths.
- [Low] Ineffective use of `flockfile()` for cross-process file synchroniza=
tion.
--

--- Patch [1]: [PATCH 01/12] perf jitdump: Fix extended header read that al=
ways fails ---
commit 9c0b715100e3938e32e2120f1ac2090e75d6c0a1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Fix extended header read that always fails

This commit fixes an issue where jit_open() sets bsz =3D bs before the
fread() that uses bs - bsz as the read size, making the read size zero.
It separates the buffer growth from the read to ensure extended header
bytes are correctly consumed.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 83005b30b9bf3..4b7c7ba7cd95d 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -224,10 +224,12 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>  		n =3D realloc(buf, bs);
>  		if (!n)
>  			goto error;
> -		bsz =3D bs;
>  		buf =3D n;
> -		/* read extra we do not know about */
> -		ret =3D fread(buf, bs - bsz, 1, jd->in);
> +		bsz =3D bs;
> +	}
> +	if (bs > 0) {
> +		/* consume extended header bytes from the stream */
> +		ret =3D fread(buf, bs, 1, jd->in);
>  		if (ret !=3D 1)
>  			goto error;
>  	}

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential problem in the error
handling earlier in jit_open().

When the initial buffer allocation fails:

buf =3D malloc(bsz);
if (!buf)
    goto error;

/*
 * protect from writer modifying the file while we are reading it
 */
flockfile(jd->in);
// ...
error:
    free(buf);
    funlockfile(jd->in);

Does this cause undefined behavior by calling funlockfile() on a stream that
was never locked by flockfile()?

[Severity: Low]
This isn't a bug introduced by this patch, but is flockfile() providing the
intended synchronization here?

/*
 * protect from writer modifying the file while we are reading it
 */
flockfile(jd->in);

The comment mentions protecting against a writer modifying the file while
reading, but flockfile() only provides thread-level synchronization within =
the
same process. It doesn't lock the file descriptor at the OS level against a
separate JIT compiler process.

Might a file-level lock be needed instead?

[Severity: High]
This is a pre-existing issue, but could we have an out-of-bounds heap access
when reading the record prefix?

In jit_get_next_entry(), the bounds check only verifies the prefix size:

bs =3D (size_t)size;
if (bs < sizeof(*prefix))
    return NULL;

If a malformed file provides a prefix->total_size smaller than the specific
record struct (e.g., 17 bytes instead of the 56 bytes needed for
struct jr_code_load), the fread() will succeed but leave stale data.

Later, functions like jit_repipe_code_load() use this stale heap data:

csize =3D jr->load.code_size;
// ...
code  =3D (unsigned long)jr + jr->load.p.total_size - csize;

Can this result in an out-of-bounds pointer calculation and arbitrary memory
being exfiltrated to the output ELF file?

[Severity: High]
This is a pre-existing issue, but does jit_repipe_code_move() leak the event
structure?

event =3D calloc(1, sizeof(*event) + 16);
if (!event)
    return -1;
// ...
out:
    perf_sample__exit(&sample);
    return ret;

Unlike other repipe functions that free the event, the event pointer here
appears to go out of scope without being freed, potentially causing the tool
to OOM on large dumps with many JIT_CODE_MOVE records.

[Severity: High]
This is a pre-existing issue, but is there a memory leak when processing de=
bug
info records?

In jit_repipe_debug_info(), memory is allocated and assigned unconditionall=
y:

data =3D malloc(sz);
if (!data)
    return -1;

memcpy(data, &jr->info.entries, sz);

jd->debug_data =3D data;

This replaces jd->debug_data without freeing any previously held allocation.

Additionally, in jit_process():

nsinfo__put(jd.nsi);
free(jd.buf);

return ret;

It looks like jd.debug_data and jd.unwinding_data are not cleaned up when
processing finishes. Should these buffers be freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D1
