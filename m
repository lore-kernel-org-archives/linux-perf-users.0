Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934303B19B7
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785944925; cv=none; b=QUAQNA7vkCS50enNuoGlUiJj7mlb2KIXm/SUZlReAIhJbXHQgpZHBfwOQkoWAm2HDbbq6fdbLyL6WFdrIIKAtIbfcHC83qep9MlA9mKKq5q1jTLmpR7bDK/YTOGAYkTnMeuahPf33PspL8jvBiUImOrs5kVgaOgG5jaUu4BpaZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785944925; c=relaxed/simple;
	bh=8aQRN66TbkAFXWDp/kJBlSHcoIXsXgoqyQRMNlanxeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UcWN+9bo1maYJ5Mjkl7LX03FEv6XUsvtLSfzOIK79CukpyonDStUkXXeR/HhRmSbs+bEp4+ZmuY7Ke2L9etQSbyxjLU/JQzV8gGYszpkqobmS29JkAg+vGgpyQTWzN7WRdyLu4F4nbbSwNnhwvkPBuyDmEmb7wAjUeG29RSgReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks3p10Ah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks3p10Ah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB391F000E9;
	Wed,  5 Aug 2026 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785944924;
	bh=UxL+Bx9+vcpdFty0hD152kKWDHtBwNu+MHcAqEcMOHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ks3p10AhGwJh6bAOExc85CRBFwbxrl1oVJFrScW6RXY6UoYOWOK9EaqUAeoLAi9FQ
	 jCjLbEXpm97U29fUDidoD0YhINlC915Ox4dAxbDO2QPkaNcnj7DyceR7EUoFZHoODc
	 hHSRw3HcBZPYaV7VHqzbDo1wbZ09W4cNnu9WrSkK5vzWM9lAA+iNdE1qWH1fygubzR
	 Wp8mhJp+BPCqnZ64akKTumjlbIheqstNuQB7mSKfxXjjTnf8sKpQg6wzaXtNXXlTta
	 qmNq/8CZoI6Qgd0v67nnZI+AOfun4k2MTx5Wz1Vmv/C5va/okDZEJrV9yZ01swBgKU
	 Pde9SPONqkAUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] perf jitdump: Fix funlockfile on unlocked stream
 in jit_open() error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-7-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 15:48:43 +0000
Message-Id: <20260805154843.ECB391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unvalidated nr_entry field in JIT_CODE_DEBUG_INFO leads to arb=
itrary heap out-of-bounds read and write.
- [High] Insecure file creation in jit_emit_elf allows arbitrary file overw=
rite via symlink attacks, potentially leading to privilege escalation.
--

--- Patch [6]: [PATCH 06/12] perf jitdump: Fix funlockfile on unlocked stre=
am in jit_open() error path ---
commit 9c3ece5485fc42d2bde29b52e999638dd26c389f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path

If the malloc() for the initial read buffer fails, jit_open() jumps to
the error label which calls funlockfile(jd->in).  However, flockfile()
is called later in the function, so at this point the stream was never
locked.  Calling funlockfile() on an unlocked stream is undefined
behavior per POSIX.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index fd11e07bf00b7..c3f11d1c1d76d 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -155,7 +155,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
> =20
>  	buf =3D malloc(bsz);
>  	if (!buf)
> -		goto error;
> +		goto error_noflock;
> =20
>  	/*
>  	 * protect from writer modifying the file while we are reading it
> @@ -244,8 +244,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
> =20
>  	return 0;
>  error:
> -	free(buf);
>  	funlockfile(jd->in);
> +error_noflock:
> +	free(buf);
>  	fclose(jd->in);
>  	return retval;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed an insecure file creation bug
in jit_emit_elf() while reviewing this file:

tools/perf/util/jitdump.c:jit_emit_elf() {
    ...
	nsinfo__mountns_enter(jd->nsi, &nsc);
	fd =3D open(filename, O_CREAT|O_TRUNC|O_WRONLY, 0644);
	saved_errno =3D errno;
	nsinfo__mountns_exit(&nsc);
    ...
}

The open() call truncates and writes to the file, but lacks O_EXCL or
O_NOFOLLOW.

Does this leave the file creation vulnerable to symlink-based file overwrite
attacks?

If a local attacker pre-creates a symlink matching the expected .so output
filename (e.g., jitted-<pid>-<count>.so) in a world-writable directory (like
/tmp), could they point it to a sensitive system file such as /etc/shadow?

When a privileged user runs perf inject on the attacker's perf.data file,
could the target file be truncated and overwritten with an ELF binary
containing jitted code?


[Severity: Critical]
This is a pre-existing issue, but the nr_entry field is completely unvalida=
ted
against the actual JIT_CODE_DEBUG_INFO record size when jd->needs_bswap is
false (native endianness):

tools/perf/util/jitdump.c:jit_get_next_entry() {
    ...
	case JIT_CODE_DEBUG_INFO:
		if (jd->needs_bswap) {
    ...
			/* clamp so downstream consumers don't overrun */
			jr->info.nr_entry =3D n;
		}
		break;
    ...
}

If a maliciously crafted jitdump file provides an artificially large nr_ent=
ry,
could it cause this loop in jit_process_debug_info() to blindly iterate
based on the unvalidated value?

tools/perf/util/genelf_debug.c:jit_process_debug_info() {
    ...
	for (i =3D 0; i < nr_debug_entries; i++) {
		ent->addr =3D ent->addr - code_addr;
		ent =3D debug_entry_next(ent);
	}
    ...
}

If so, it appears debug_entry_next() could read out of bounds, and the
ent->addr =3D ent->addr - code_addr; operation might repeatedly subtract fu=
lly
attacker-controlled values (code_addr) from arbitrary heap metadata.

Could this lead to arbitrary code execution when processing an untrusted fi=
le?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D6
