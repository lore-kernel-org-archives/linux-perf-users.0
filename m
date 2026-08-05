Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C43F4830
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966047; cv=none; b=bwa0DX4M1gjKrg4OnC/GbZBRpSmqGs/0RHck3gbkv3i7bAcVqWIA9sHss/bkAfkQRF7oJii1x8kbxpcC9oCLHpNrAMpRJq7UnZ3xqqLL8s8UTWkbvWsHDZHWwaJhb4tHmxNLi3F1tFA9B9rAUvgh/KsmLAUfnbD8hVHJ6DwR4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966047; c=relaxed/simple;
	bh=DXfq8kpyxbZZr7loSd5xjG5oHl8yPqEhczl4xg3ue4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YfpkjJ18fWYERCJLslHnxe5Lj5L7ghCtp0Q/eNpIwgYE/vvgqC+dIwDXBb5VhiMN/sxJ/Xc6DiWJ6oNOwPBVRb1HHgiqjtgKRa8Gc/dm9gVbKYMnnzSb6Rp3EpUEA9wnenJJ3kOtIUdm+P7D6fIWl/G0+aYaBUZJvNWkFhJWZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFf0JRmm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFf0JRmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8843F1F000E9;
	Wed,  5 Aug 2026 21:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966045;
	bh=UQ141WCoGJvUMYR4s6mFbZVw2x5wqvgw6F+p55tGKJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFf0JRmmSzhSqUzJLXhgJbqtNEcKlGbazZ1Y3LvklntJfvi8O55yo8lRZzLw7K34C
	 BrmYUipK3PecFBjVt3MDoi5jmZgc30qo0yd0rOB30iVACnLRElPVwJLY67K78o7dK5
	 zk4iowdW0llXBEwiMRfAKclU8wxWoQNcfurNZjM/yuhzMx8Zwlh4dsRkqI7k0sxWWr
	 MUysPTorZwEOkxY2V/KMOcP+qGXjQmyusDy8xOfu+kdV6B1/xcU3B1uVFY6fouWCyl
	 mmeteQ4ykrocza7c8NiLEHHhneqACPRNtxQ/wJyxlKLtSjE3KlrcvFKTgGi1jD9o9h
	 ovtL2DUN8VSaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] perf jitdump: Bounds-check debug entry byte-swap
 loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-5-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:40:44 +0000
Message-Id: <20260805214045.8843F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added bounds-checking and string NUL-termination validat=
ion for debug entries are isolated within the `if (jd->needs_bswap)` block.=
 For native-endian files, validation is bypassed, leaving out-of-bounds hea=
p read/write vulnerabilities unmitigated.
--

--- Patch [4]: [PATCH 04/12] perf jitdump: Bounds-check debug entry byte-sw=
ap loop ---
commit b0b40e7a47c677d680f97fb1312ed129f617d651
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Bounds-check debug entry byte-swap loop

This commit replaces array indexing with pointer arithmetic for debug_entry
structures in the JIT_CODE_DEBUG_INFO byte-swap loop to handle
variable-length names. It also adds bounds checking against total_size to
prevent out-of-bounds reads.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 787f8a03dae87..078d3304d2b7e 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c

[ ... ]

> @@ -318,14 +318,32 @@ jit_get_next_entry(struct jit_buf_desc *jd)
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
> +				/* name must be NUL-terminated within the record */
> +				if (!memchr(ent->name, '\0', (char *)end - ent->name))
> +					break;
> +				ent->addr    =3D bswap_64(ent->addr);
> +				ent->lineno  =3D bswap_32(ent->lineno);
> +				ent->discrim =3D bswap_32(ent->discrim);
> +				ent =3D debug_entry_next(ent);
>  			}
> +			/* clamp so downstream consumers don't overrun */
> +			jr->info.nr_entry =3D n;
>  		}
>  		break;

[Severity: High]
This is a pre-existing issue, but by keeping the new bounds-checking and
clamping logic exclusively inside the if (jd->needs_bswap) block, doesn't
this leave native-endian files unvalidated?

For a native-endian file, jd->needs_bswap is false, so jr->info.nr_entry
bypasses this clamping in jit_get_next_entry(). Later in
tools/perf/util/jitdump.c, it is assigned directly:

jit_repipe_debug_info() {
    ...
    jd->nr_debug_entries =3D jr->info.nr_entry;
    ...
}

This unvalidated count is then used in tools/perf/util/genelf_debug.c:

jit_process_debug_info() {
    ...
    for (i =3D 0; i < nr_debug_entries; i++) {
        ent->addr =3D ent->addr - code_addr;
        ent =3D debug_entry_next(ent);
    }
    ...
}

If the number of entries is artificially inflated, or if NUL terminators are
missing, could this lead to out-of-bounds reads and writes in
jit_process_debug_info() when processing a native-endian jitdump file?

Should the entry validation and clamping logic be pulled out of the
jd->needs_bswap block so it applies to all files regardless of endianness?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D4
