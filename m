Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADCC145A1F
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940002; cv=none; b=LN2Llt784UmUILSLRnb7SzXlp1hOR009sozjcvy8ijbvIVwPOTDDV2X31l0lhtkiIDG31W8kqXE5fK0xLQPSp6AMt9ZDKiLO6tmmpaXcM77KUwoHNv194iwv+pJG6t2dXYp8cTuGdHFtfvQCAkbVTB/4hQr3f1WOUaspO+3MmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940002; c=relaxed/simple;
	bh=oVq7ZfvXUZkMGchc6gO3Vj3EZhhA+jiGz68qfw0NXk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ec3QymZZBX78dkIy2Fn7+1Etgls6dSgfxHb2HKumngp8HCOm/hfJYQK5DdaBnkpzIhgSRBz7J6fcBiU+RhZdQgN2P3BxhT8STXqGWQ2JjsI2Bf7MIw8C5zG5AIchAC6h4QAMAbThh24k9vtWMkHkDbQ/yxoso80tuWpIgv/f1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl3d1af2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl3d1af2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C3F1F000E9;
	Wed,  5 Aug 2026 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785939993;
	bh=ox6HYC4ArO026drHQeL+oAUKMkSx6yfyrhu5seP85us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fl3d1af2oYVl6qjOLTXLIbjnnp22vlQMmdDHaITk5qj0npXgPH05rG23Ii7I/Dspo
	 okBPIxkY9F8++ouunbKlF3EZP3di09ImyBvO3dgBOU1F5YXH2EXAxIvik33N/AFdCM
	 2VpUQIfDmImQGe1wRbAsE/32lhNpncZVhvb48HPzas+bZqSsbiK8/Vp1EyOpzZt/YT
	 PKUm4nSDN/hDsHsyTaCNETRslaGxudUr6Zx2bM2LKZQYsNPb8XSGuC1qBEXIg8NJFk
	 LY+r8VNc5z9BlntllUvpjM0/HgNadopnKOHGOsbQY8D+Bz88T2ewpgmCUJ0qQcHfle
	 KQvaM3tmTXLFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/12] perf jitdump: Validate debug entries on native
 (non-swap) path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805133013.235016-11-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
 <20260805133013.235016-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 14:26:32 +0000
Message-Id: <20260805142633.A1C3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The JVMTI agent and debug_entry array iterates over tightly packed=
, variable-length structures without padding, causing unaligned memory acce=
sses when reading or writing 64-bit and 32-bit fields.
- [High] The functions `jit_get_next_entry()` and `jit_repipe_code_move()` =
lack bounds checking to ensure that the parsed `JIT_CODE_MOVE` record is at=
 least `sizeof(struct jr_code_move)` bytes in length.
- [High] The arguments `unwinding_header_size` and `unwinding_size` are sil=
ently truncated from 64-bit to 32-bit before being passed to `jit_write_elf=
()`.
--

--- Patch [10]: [PATCH 10/12] perf jitdump: Validate debug entries on nativ=
e (non-swap) path ---
commit 1922967864de6630181cc1d54ced351d4019f568
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Validate debug entries on native (non-swap) path

This commit fixes an out-of-bounds read and write on native-endian files
by adding bounds checking and NUL-termination validation for debug
entries in jit_repipe_debug_info(). It clamps nr_debug_entries to the
count of valid entries that fit in the payload.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 02840dbf8a1fc..87612ef3e2325 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -694,8 +694,10 @@ static int jit_repipe_code_move(struct jit_buf_desc =
*jd, union jr_entry *jr)

[Severity: High]
This isn't a bug introduced by this patch, but does jit_repipe_code_move()
lack bounds checking for the JIT_CODE_MOVE record size?

If a crafted JIT dump provides a JIT_CODE_MOVE record with a total_size
smaller than sizeof(struct jr_code_move), jit_get_next_entry() might only
read the provided smaller size into jd->buf.

Could extracting fields like jr->move.new_code_addr in jit_repipe_code_move=
()
then read out-of-bounds heap memory and leak stale data into the generated
perf.data file?

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

> @@ -715,10 +717,25 @@ static int jit_repipe_debug_info(struct jit_buf_des=
c *jd, union jr_entry *jr)
>  	jd->debug_data       =3D data;
> =20
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
This is a pre-existing issue, but does advancing the pointer this way lead
to unaligned memory accesses?

Looking at tools/perf/util/jitdump.h, debug_entry_next() computes the next
pointer without enforcing 8-byte alignment:

static inline struct debug_entry *
debug_entry_next(struct debug_entry *ent)
{
	void *a =3D ent + 1;
	size_t l =3D strlen(ent->name) + 1;
	return a + l;
}

Since the variable-length name string is not padded, the returned pointer
might not be 64-bit aligned.=20

When jit_process_debug_info() or jit_get_next_entry() subsequently accesses
ent->addr (a 64-bit integer), could this trigger a SIGBUS crash on
architectures that enforce strict alignment?

> +		valid++;
> +	}
> +	jd->nr_debug_entries =3D valid;
> =20
>  	return 0;
>  }

[Severity: High]
This is also a pre-existing issue, but does jit_emit_elf() silently truncate
64-bit size values?

In tools/perf/util/jitdump.c, jit_repipe_code_load() passes the 64-bit fiel=
ds
jd->eh_frame_hdr_size and jd->unwinding_size to jit_emit_elf():

ret =3D jit_emit_elf(jd, filename, sym, addr, (const void *)uaddr, csize,
                   jd->debug_data, jd->nr_debug_entries,
                   jd->unwinding_data, jd->eh_frame_hdr_size,
                   jd->unwinding_size);

However, jit_emit_elf() defines these parameters as 32-bit integers:

void *unwinding,
uint32_t unwinding_header_size,
uint32_t unwinding_size)

If a crafted JIT dump provides 64-bit sizes that are truncated when passed
to jit_emit_elf(), could this result in an unwinding_size smaller than
unwinding_header_size?

When jit_write_elf() widens these back to 64-bit and subtracts them, could
this underflow the unwinding_table_size and cause massive out-of-bounds
operations during ELF generation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805133013.2350=
16-1-acme@kernel.org?part=3D10
