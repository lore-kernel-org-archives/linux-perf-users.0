Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E013F7888
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064186; cv=none; b=QGZ0Ky/Fl+oWcgbYdq9gJt46aS4xja/k1dXgpoR29YnMlYhT1le5YzR/r0siNdn/LfLVe1tNpmR+ROQ6ctyPlX7M35+x/LjwLT7Ds+gfe2J2oSFMM0E9Z4UfmwBp0cmPAKwj3SzJXWjIfNY49g9JIBgLv0CIOYd7kGWW000piXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064186; c=relaxed/simple;
	bh=ShCLg5t291+uhQQKA+r9zPDdtb4zC6gKHL6Br5Gf6/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cg0reFCC1BMdAcg/WQHALXBUShxc3TlzYxWp4lgIvB5W+LOqiHrnz5ODJfK8ZT/c1T+cFEsJVeT3BClZQGxtkYjZNIa0nnuv4Y2hQ9F6Kz9MmEOZnXCRDly2FdzxfL6VU1esaGUpl1pMtRvHEJ7wqcHKtwV/s4ekOqEqzNlWonc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exReD/og; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exReD/og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D54DC2BCB8;
	Wed,  6 May 2026 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778064186;
	bh=ShCLg5t291+uhQQKA+r9zPDdtb4zC6gKHL6Br5Gf6/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=exReD/ogrbrOhzfjJ85mUqHmXFBWJc7hK5PH7pxOGHiIvSfj4XgSTGEoApzezsXs4
	 x+fkrO9vlGMPLdV1ybBkVW/yRriqCGg74y+JhaZQiv5j1snZXxhjujbCFNpoXv5WDJ
	 XZZfxDJdqO0qLhzs67bwqeSzt4dsgsXSlvh06U4bTj2YgiFKW+K6jZjgDMqg2kiFwt
	 3/6LZd9aY0k+rBokAdvVIkCORDd/yBDcdMhbTY0AuHGSnly1Ba1Z1VE3ORSYZjEfGy
	 0wlTWGJExfbuxgoQDsvQO1DTmL9Mv6DvvvNmmBFxhTgfHuOV0/U1U+BMT0r2tFp4qd
	 MjCVtW9GH91VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf: Extract is_mapping_symbol() helper for kernel
 mapping symbol filtering
Reply-To: sashiko@lists.linux.dev
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260506073820.2419087-1-qirui.001@bytedance.com>
References: <20260506073820.2419087-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 10:43:04 +0000
Message-Id: <20260506104305.2D54DC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Asymmetric mapping symbol filtering leads to map/symbol deletion d=
uring ksymbol unregistration.
- [Medium] Incomplete refactoring leaves ELF mapping symbol logic fragile a=
nd inconsistent.
--

commit f27956b5bf680b8ef41ba119f6dc5cedae4567f5
Author: Rui Qi <qirui.001@bytedance.com>

perf: Extract is_mapping_symbol() helper for kernel mapping symbol filtering

This patch introduces an is_mapping_symbol() inline helper to consolidate
logic for filtering out ELF mapping symbols across architectures. It also
adds the helper to machine__process_ksymbol_register() and
map__process_kallsym_symbol().

> The perf tool currently has ad-hoc logic to filter out ELF mapping
> symbols scattered across multiple files and architectures.  ARM,
> AArch64 and RISC-V each have their own inline checks in
> dso__load_sym_internal(), and kallsym processing in map__process_kallsym_=
symbol()
> has yet another check for ARM module symbols.
>=20
> This is fragile: adding support for a new architecture or adjusting
> which prefixes are considered mapping symbols requires touching
> multiple places, and it is easy for the checks to diverge.  It also
> does not match the kernel's own is_mapping_symbol() logic, which
> additionally covers x86 local symbols ('.L*' and 'L0*').

This commit message claims to convert dso__load_sym_internal() to use the
new helper. However, this patch does not modify dso__load_sym_internal()
in tools/perf/util/symbol-elf.c at all, leaving the scattered inline checks
untouched.

Because x86 local symbols (.L*) were added to the new helper, does this
omission introduce a new inconsistency where kallsyms parsing will correctly
filter x86 .L* symbols, but kernel module parsing via ELF (.ko) will not?

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e76f8c86e62a6..e0dcf8bfb896e 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -729,9 +729,15 @@ static int machine__process_ksymbol_register(struct =
machine *machine,
>  {
>  	struct symbol *sym;
>  	struct dso *dso =3D NULL;
> -	struct map *map =3D maps__find(machine__kernel_maps(machine), event->ks=
ymbol.addr);
> +	struct map *map;
>  	int err =3D 0;
> =20
> +	/* Ignore mapping symbols in ksymbol events - check early before any st=
ate mutation */
> +	if (is_mapping_symbol(event->ksymbol.name))
> +		return 0;

If a PERF_RECORD_KSYMBOL event arrives with the UNREGISTER flag,
machine__process_ksymbol() routes it to machine__process_ksymbol_unregister=
().

Because machine__process_ksymbol_unregister() does not have the same
is_mapping_symbol() filter, could maps__find() return the enclosing map
(such as the BPF JIT map or a loaded kernel module's map) that covers the
mapping symbol's address?

tools/perf/util/machine.c:machine__process_ksymbol_unregister() {
...
	map =3D maps__find(machine__kernel_maps(machine), event->ksymbol.addr);
	if (!map)
		return 0;

	if (!RC_CHK_EQUAL(map, machine->vmlinux_map))
		maps__remove(machine__kernel_maps(machine), map);
...
}

If so, will the unregister path incorrectly call maps__remove() on that
parent map, prematurely destroying legitimate tracking state and breaking
symbol resolution for subsequent samples in that memory region?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506073820.2419=
087-1-qirui.001@bytedance.com?part=3D1
