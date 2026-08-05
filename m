Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1D38BF97
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940554; cv=none; b=Q8jfk9votRHka4BP5b3SHyiZSzZiPH/X5vz/e3DlEmLwpCeRCp2OhZ9lJ2ZnbTxT7qM/3UgGwFd9UV6SzkGAOTDAQJMGx+6Xr6zEIDbGiXCMr1BftdOHZVw6Yaral8TyGesUSRFWy+MulmC+C36MW1yOQqXRHRgM6ggPgfLeDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940554; c=relaxed/simple;
	bh=7huaGxka1CcWIrRZFhD/tJFjDvcZX81VTgqDoU7JjNQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aiHMBT9bCj3q7KEjh8U5NFt7tmrXE2UCvRbN6qKXXmHxG+t6NsTCmNoHoCn0fFaFlVUehc+cHmJX3J8iE2J6LZu/HTjaqQj1V8TRi9bbTH1RjF/bp2KJoOOq7DUiWlBew/Z+Ahdzo+3Z4AuEfnjiCty7QaixrL+3n7mYUadSPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKMMQQAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKMMQQAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E31F00A3A;
	Wed,  5 Aug 2026 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785940542;
	bh=rug47uvNH4zk8uFgX85TzMWQkTzt2vxuBj6ikOwif/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKMMQQAQ/BZgbNRtTG3K7VUFrXnaBz9NXXhaFoHkqB8AvzqiaKKa1Ae24BoTgx/xW
	 Drc/g02zWCyjQS/GwGJcdE3EdYFabXl/aCqfSb49BKT5ULedg/gaslrm7w661BFOpG
	 Z+FNXzEkoi5jZeE07zxzH1U9+Oc7H3cfgYKKd4MApaYUWwT8ZKQjTelOHTRVZ+5yUn
	 USJDv6qs6gYsgGPLEDXIXf5ZCrUOUFFriwq4Sb7xcTRBJ8Be05cRM7C8r+YDgBThZy
	 Ory4kxZOC+LKETPNs6GAhphaXnzXPcf2biYKB4S8bvDTVADRK6bz1QQmPOxV1OLADf
	 73O/bvZP48F0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] perf jitdump: Fix debug_data and unwinding_data
 leaks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-9-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:35:41 +0000
Message-Id: <20260805143542.536E31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error returns in `jit_process_dump` loop are ignored, causing subs=
equent records to consume stale metadata from failed parses.
- [Medium] `jit_inject` ignores the return value of `jit_process_dump` enti=
rely, falsely reporting success on complete processing failures.
--

--- Patch [8]: [PATCH 08/12] perf jitdump: Fix debug_data and unwinding_dat=
a leaks ---
commit 57747ce97971858edaaa984c164ff79271eb0779
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Fix debug_data and unwinding_data leaks

This commit fixes memory leaks in perf jitdump by ensuring previous allocat=
ions
for debug_data and unwinding_data are freed before reassignment. It also ad=
ds
cleanup of both buffers when closing the jitdump session.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 4f52b143cd0da..3085091b95a51 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c

[ ... ]

> @@ -706,6 +708,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc =
*jd, union jr_entry *jr)
> =20
>  	memcpy(data, &jr->info.entries, sz);
> =20
> +	zfree(&jd->debug_data);

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling in
jit_repipe_debug_info() leave stale data active if a subsequent parse fails?

If malloc() fails or the payload size is malformed earlier in the function,=
 it
returns -1 without clearing jd->debug_data. Does jit_process_dump() check t=
his
error code, or does it continue and allow the next JIT_CODE_LOAD record to
consume the uncleared, stale debug data from a prior successful record?

tools/perf/util/jitdump.c:jit_process_dump() {
    ...
    case JIT_CODE_DEBUG_INFO:
        ret =3D jit_repipe_debug_info(jd, jr);
        break;
    ...
}

>  	jd->debug_data       =3D data;
> =20
>  	/*

[Severity: Medium]
This is a pre-existing issue, but is it intentional that jit_inject() ignor=
es
the return value of jit_process_dump() on complete failure?

If a fatal parsing or allocation error propagates out to ret, it looks like
the error code is logged in verbose mode but ultimately discarded from the
caller:

tools/perf/util/jitdump.c:jit_inject() {
    ...
    ret =3D jit_process_dump(jd);

    jit_close(jd);

    if (verbose > 0)
        fprintf(stderr, "injected: %s (%d)\n", path, ret);

    return 0;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D8
