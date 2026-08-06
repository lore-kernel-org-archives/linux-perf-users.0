Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1AE2DC783
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021847; cv=none; b=OwrDg9vUKgkJIsQsdcyCgBuPrrpFklHBJPeci5t7soSCPcwNxm/MSOGw0xjF9WTDmsMwJR2arUE+08Vf2ceBt955QTBnLlQUwPxWYpnRgopBuS9AWFYZEiUZIfvfaqjSPm+ZWDUOgHFiWC8L1aCD1q2/dPBEnMLGwr0Q2HJ8V3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021847; c=relaxed/simple;
	bh=IhfIJNuaoRbUuHZ6xi5ml+MwsFAtRNIm5tLiK/MOFj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnndGGrFFibF5WL7awoQAZ6BlksO+D/NSEM6CJvYj032yc6NjhqX+Gic+73rzw/PYJyJF8em7R1Cj92zZdANQPIaEm2pHkKtfmnoLmtaVYsIPsR0ePZ6JMRPCa3j7bb9XY0I/PP8OOuEVbvQSDK7+0EZuGI7QmdAI14cyTsFb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9F6n2r1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9F6n2r1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5081F000E9;
	Thu,  6 Aug 2026 13:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021844;
	bh=i7zx/AOeE9EjEXKlbhYWqFnhslF5ZzaD4SVIwJS3VPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c9F6n2r1yDzcMINTfFae0OT8LqwX9feRtnHUU4Q9vW5q5nlWPJxWJ8HTWM5KyYQxr
	 znA3p2ynCIDaAaOyb2eKLZMuS0x4hvpzHDATM1E1M1TbIgBpzpcmPSpMwmoMQaTQCi
	 nwhnoW9C/ebc2WKgNemmOUI5gqwcH4nGI5HTuLTMHEE0QX0j1F5hDYULgLxzK+rqY1
	 aTy5ThsRL6707PgNqowEM+1YL7YCkM378k8FiGNKHoIm2DeoUUf3yHuAC+0h1jDPE2
	 6eYUUgmx3aoTZgngZDdfsYyC86NwsGEWdjCp7/kTT0WSNh62AzrAiK6CjHXs2y1cgZ
	 LEVIeIiru9cRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] perf jitdump: Validate debug entries on native
 (non-swap) path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-11-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:10:43 +0000
Message-Id: <20260806131044.AC5081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Iterating over `struct debug_entry` with `debug_entry_next()` prod=
uces unaligned pointers, causing undefined behavior and hardware exceptions=
 (SIGBUS) on strict-alignment architectures.
- [Medium] Parsing errors in JIT dump records are silently ignored in `jit_=
process_dump()`, leaving stale debug and unwinding data active and overwrit=
ing error return codes.
- [Medium] `jit_repipe_code_move()` processes `JIT_CODE_MOVE` records witho=
ut verifying that the record's `total_size` is large enough to contain the =
struct, leading to uninitialized heap memory reads.
--

--- Patch [10]: [PATCH 10/12] perf jitdump: Validate debug entries on nativ=
e (non-swap) path ---
commit f31dd5de27938e11279a2fce6356aeba4e9918b4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate debug entries on native (non-swap) path

The bounds-checking and nr_entry clamping added for the byte-swap path
only runs when jd->needs_bswap is true. This patch adds bounds-checked
iteration in jit_repipe_debug_info() to validate each debug_entry fits in
the payload.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index d3de307532d55..5a3ea2681fb37 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -694,8 +694,10 @@ static int jit_repipe_code_move(struct jit_buf_desc =
*jd, union jr_entry *jr)

[Severity: Medium]
This is a pre-existing issue, but does jit_repipe_code_move() process
JIT_CODE_MOVE records without verifying that the record's total_size is
large enough to contain the struct?

If a malformed JIT_CODE_MOVE record specifies a small total_size, fread()
might read 0 bytes, leaving the jr->move fields mapped to uninitialized
bytes in jd->buf. Could this cause uninitialized heap memory to be read,
byte-swapped in jit_get_next_entry(), and written to the output perf.data
file?

> =20
>  static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry=
 *jr)
>  {
> -	void *data;
> -	size_t sz;
> +	struct debug_entry *ent;
> +	void *data, *end;
> +	size_t sz, valid;
> +	uint64_t i;

[ ... ]

>  	/*
> -	 * we must use nr_entry instead of size here because
> -	 * we cannot distinguish actual entry from padding otherwise
> +	 * Clamp nr_debug_entries to entries that actually fit in the
> +	 * payload.  The byte-swap path already does this for cross-endian
> +	 * files; validate on the native path too, since downstream
> +	 * jit_process_debug_info() iterates via debug_entry_next() which
> +	 * calls strlen() on each entry's name field.
>  	 */
> -	jd->nr_debug_entries =3D jr->info.nr_entry;
> +	end =3D data + sz;
> +	ent =3D data;
> +	valid =3D 0;
> +	for (i =3D 0; i < jr->info.nr_entry; i++) {
> +		if ((void *)ent + sizeof(*ent) > end)
> +			break;
> +		/* name must be NUL-terminated within the payload */
> +		if (!memchr(ent->name, '\0', (char *)end - ent->name))
> +			break;
> +		ent =3D debug_entry_next(ent);

[Severity: High]
This isn't a bug introduced by this patch, but does debug_entry_next()
produce unaligned pointers here?

Because struct debug_entry contains 64-bit and 32-bit fields but lacks
__attribute__((packed)), the compiler emits 8-byte aligned memory accesses.
Since the variable-length string does not pad to 8-byte boundaries,
subsequent entries appear to become naturally unaligned in memory.

When downstream code dereferences these fields, such as:

tools/perf/util/genelf_debug.c:jit_process_debug_info() {
    ...
    ent->addr =3D ent->addr - code_addr;
    ...
}

could this perform unaligned 64-bit loads and stores, triggering hardware
alignment faults (SIGBUS) on strict-alignment architectures?

> +		valid++;
> +	}
> +	jd->nr_debug_entries =3D valid;
> =20
>  	return 0;
>  }

[Severity: Medium]
This is a pre-existing issue, but are the error codes returned by this
function silently ignored by its caller?

In jit_process_dump():

tools/perf/util/jitdump.c:jit_process_dump() {
    ...
    ret =3D jit_repipe_debug_info(jd, jr);
    ...
    default:
        ret =3D 0;
        continue;
}

If jit_repipe_debug_info() returns -1 (e.g., due to OOM), the while loop
doesn't seem to break. If a subsequent unrecognized record or JIT_CODE_CLOSE
triggers the default case, ret is overwritten to 0. Does this successfully
hide the parse failure and leave stale debug data active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D10
