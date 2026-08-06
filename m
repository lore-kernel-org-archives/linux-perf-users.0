Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823582BEFFD
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020718; cv=none; b=T59GDwnMAt/8V2BMbtbQKI4vyowZkg9S82Im0mHrrc3WjSftM4XKd2cb1tl/1ohRmVo8kNPF15MmvILztCBP/cR0QjtGK3DfMjxcFR1oCM2an/P6DKLuo9U+awlLHLHF8TcLmcq9IUSrYGM/yfeKU0PBvgx3DjENsOOPispVYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020718; c=relaxed/simple;
	bh=U0ISrlnkLYZSpXq3zlpn3quSG+b3EOIlTcGDqm9brHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XNRsoZaE5L80aw+qRXVbMUOYzTCAFnv58gJh1hfVQdG/CSvm+7TRbQCsM8iV4aG4rxSIsyPAfFpjs7Uo3+UqwuhK3jXfXXphZLxpVNDiDMg7/cG/xOBvc3jtiXJEwHgSMfruzyV52IUPCvYZxTsZqVd/Zz1Dv2pMna8YbYl4Xl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHuGm9gC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHuGm9gC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDF61F00A3A;
	Thu,  6 Aug 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020716;
	bh=edYVU5gjANlEEy1D/VocrwExBWp/WfSsU9AxiO4XVHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UHuGm9gCXTz3jOT29kbEB9fHqXnW3iDRSXwS2/8yofIWqiQDu15fJ2CHJnCNtC1DT
	 SrjmdyTLJXRAXYmJbyN9GOuL4urnEnbxcH0j0njku7I6vCuJcAsuzE30JUnpGQuNWy
	 BHiVNXE23cbzP8LA7W8QrUc/CzSqygLQJw1wX6C8N5Borzf3haK/pbL94ANYBUMazE
	 sSQTUYt7GGUPJHPr0KTjOf3vgOiu+R6RRzLMm48viu5pFa2Tn46bV4eYcTRvWqSEx2
	 ayZQlB/DMuJvyBRHJbF5PKPDUnTMaj7zSmsAVAUgNLCzINAayBsaHAni86Rq40Sykj
	 R/4iXWFrYYrTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] perf jitdump: Bounds-check debug entry byte-swap
 loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-6-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:51:56 +0000
Message-Id: <20260806125156.ADDF61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Medium] Replacing array indexing with sequential pointer arithmetic (`de=
bug_entry_next`) on unpadded, variable-length structures results in unalign=
ed struct pointers, causing undefined behavior and SIGBUS crashes on strict=
-alignment architectures.

Pre-existing issues:
- [Critical] The newly added bounds checking and `nr_entry` clamping for `J=
IT_CODE_DEBUG_INFO` records are scoped exclusively inside the `if (jd->need=
s_bswap)` block, leaving native-endian files completely vulnerable to a mas=
sive heap buffer overflow.
- [High] Missing validation of `unwinding_size` against `unwinding_data_siz=
e` in `JIT_CODE_UNWINDING_INFO` leads to an out-of-bounds read during ELF g=
eneration.
- [Medium] The `event` buffer is leaked on all return paths in `jit_repipe_=
code_move()`.
- [Medium] `jit_repipe_code_move` fails to validate that the record's `tota=
l_size` is large enough to contain the `jr_code_move` payload, leading to t=
he processing of uninitialized memory.
--

--- Patch [5]: [PATCH 05/12] perf jitdump: Bounds-check debug entry byte-sw=
ap loop ---
commit 14beafbf2609e41d04f4020f064d84fdbb15c5a7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Bounds-check debug entry byte-swap loop
   =20
This commit replaces array indexing with pointer arithmetic and adds bounds
checking for JIT_CODE_DEBUG_INFO records during byte-swapping to prevent
out-of-bounds reads.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index f79e9420c6bd7..7efbaa07f1ba7 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -320,14 +320,32 @@ jit_get_next_entry(struct jit_buf_desc *jd)
>  	switch(id) {
>  	case JIT_CODE_DEBUG_INFO:
>  		if (jd->needs_bswap) {
> +			void *end =3D (void *)jr + jr->prefix.total_size;
> +			struct debug_entry *ent;
>  			uint64_t n;
> +
>  			jr->info.code_addr =3D bswap_64(jr->info.code_addr);
>  			jr->info.nr_entry  =3D bswap_64(jr->info.nr_entry);
> -			for (n =3D 0 ; n < jr->info.nr_entry; n++) {
> -				jr->info.entries[n].addr    =3D bswap_64(jr->info.entries[n].addr);
> -				jr->info.entries[n].lineno  =3D bswap_32(jr->info.entries[n].lineno);
> -				jr->info.entries[n].discrim =3D bswap_32(jr->info.entries[n].discrim=
);
> +
> +			/*
> +			 * debug_entry has a variable-length name[], so array
> +			 * indexing would compute wrong offsets =E2=80=94 use
> +			 * debug_entry_next() and bounds-check each entry.
> +			 */
> +			ent =3D &jr->info.entries[0];
> +			for (n =3D 0; n < jr->info.nr_entry; n++) {
> +				if ((void *)ent + sizeof(*ent) > end)
> +					break;

[Severity: Critical]
This is a pre-existing issue, but by placing the bounds checking and
nr_entry clamping exclusively inside the if (jd->needs_bswap) block,
native-endian files bypass this validation completely.

If a maliciously crafted JIT dump file with a native endianness matching the
host provides an arbitrarily large untrusted nr_entry count for a
JIT_CODE_DEBUG_INFO record, this path is skipped.

Later in the processing, this unvalidated value is assigned directly:

tools/perf/util/jitdump.c:jit_repipe_debug_info()
    jd->nr_debug_entries =3D jr->info.nr_entry;

And then blindly iterated over on the heap:

tools/perf/util/genelf_debug.c:jit_process_debug_info()
    for (i =3D 0; i < nr_debug_entries; i++) {
        ent->addr =3D ent->addr - code_addr;
        ent =3D debug_entry_next(ent);
    }

Could we move the bounds validation outside of the byte-swapping block so a=
ll
inputs are checked?

> +				/* name must be NUL-terminated within the record */
> +				if (!memchr(ent->name, '\0', (char *)end - ent->name))
> +					break;
> +				ent->addr    =3D bswap_64(ent->addr);
> +				ent->lineno  =3D bswap_32(ent->lineno);
> +				ent->discrim =3D bswap_32(ent->discrim);
> +				ent =3D debug_entry_next(ent);

[Severity: Medium]
Does this unpadded sequential pointer arithmetic lead to unaligned memory
accesses?

struct debug_entry contains 64-bit and 32-bit fields, requiring 8-byte
alignment, but it is not __packed. The debug_entry_next() helper calculates
the next entry's address by adding the length of the string:

tools/perf/util/jitdump.h:debug_entry_next()
    void *a =3D ent + 1;
    size_t l =3D strlen(ent->name) + 1;
    return a + l;

This leaves the pointer unaligned. When the byte-swapping loop uses
ent =3D debug_entry_next(ent) and accesses ent->addr =3D bswap_64(ent->addr=
),
the compiler generates aligned load/store instructions for an unaligned
address, leading to SIGBUS crashes on strict-alignment architectures.

>  			}
> +			/* clamp so downstream consumers don't overrun */
> +			jr->info.nr_entry =3D n;
>  		}
>  		break;
>  	case JIT_CODE_UNWINDING_INFO:
>  		if (jd->needs_bswap) {
>  			jr->unwinding.unwinding_size =3D bswap_64(jr->unwinding.unwinding_siz=
e);

[Severity: High]
This is a pre-existing issue, but is the unwinding_size validated against t=
he
actual payload size?

In jit_repipe_unwinding_info(), the unwinding size is saved directly from t=
he
payload without validation against the allocated heap buffer size:

tools/perf/util/jitdump.c:jit_repipe_unwinding_info()
    jd->unwinding_size =3D jr->unwinding.unwinding_size;

This unvalidated size is later passed to libelf:

tools/perf/util/genelf.c:jit_add_eh_frame_info()
    d->d_size =3D unwinding_table_size;

A crafted record with a small total_size but a huge unwinding_size could
cause libelf to read out-of-bounds heap memory and embed it into the output
ELF, leading to an information leak.

>  			jr->unwinding.eh_frame_hdr_size =3D bswap_64(jr->unwinding.eh_frame_h=
dr_size);
>  			jr->unwinding.mapped_size =3D bswap_64(jr->unwinding.mapped_size);
>  		}
>  		break;

While reviewing this patch, I also noticed a couple of pre-existing issues
in the handling of JIT_CODE_MOVE records:

tools/perf/util/jitdump.c:jit_repipe_code_move()
[ ... ]
> 	nspid =3D jr->load.pid;
> 	pid   =3D jr_entry_pid(jd, jr);

[Severity: Medium]
This isn't a bug introduced by this patch, but does jit_repipe_code_move()
validate that the record's total_size is large enough to contain the
jr_code_move payload?

If a malformed record is provided with a truncated total_size, fread() will
read only a partial record into jd->buf. The remaining fields will be
uninitialized or contain leftover data, which are then used to construct
the perf event.

[ ... ]
> 	event =3D calloc(1, sizeof(*event) + 16);
> 	if (!event)
> 		return -1;
[ ... ]
> 	ret =3D perf_event__process_mmap2(tool, event, &sample, jd->machine);
> 	if (ret)
> 		goto out;
>=20
> 	ret =3D jit_inject_event(jd, event);
> 	if (!ret)
> 		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
> out:
> 	perf_sample__exit(&sample);
> 	return ret;

[Severity: Medium]
This is a pre-existing issue, but does this leak the event buffer?

The memory for event is allocated via calloc() and the function returns at
the out: label without calling free(event). Neither of the processing
functions take ownership of the memory, so the buffer appears to be leaked =
on
every JIT_CODE_MOVE record.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D5
