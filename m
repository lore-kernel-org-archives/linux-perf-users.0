Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4173203B6
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186288; cv=none; b=X5NYtf9uzAYD8zYXiSF7QVZLGufik5PXDYvmuOMjzjhPkb+S2KEdr7E8ksTmXjyDTxSFQxzn0NUuuKEtUnKYiIjKuLYBJu6dbaTIvIQTZ4Mv6WwqbecyMNH9K4DfC2rYy5TnspMpZPddCnazrdsgdTF5XvaqIjqTUI4wDacjeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186288; c=relaxed/simple;
	bh=wgHCtaQDBIC6SCAoTkekgnGfn+KtPd8rMddzfMmgoX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQw+BOPmXR11qL7/fCg/FYjkd66mQ2bztb/eg0F3dDDTsE15+0YOhZddJh9FKFadX5C/DagoZldfiICTsOwalbjZ1XK/nDjDcJ9TVCpJeblX783Is7q4igJ8/M/761wmWm2S95RbSScvBb+5UFCNDJMuTDLmwi34+YvffRMPEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdI6Yyb6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdI6Yyb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A76C2BCB2;
	Thu,  7 May 2026 20:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778186287;
	bh=wgHCtaQDBIC6SCAoTkekgnGfn+KtPd8rMddzfMmgoX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jdI6Yyb6bEcM6GZSbmZwVyKCeOrcikdlAY/iasYDbM3SjLbeJBUB19MwRYqJ2OCZl
	 qQYdqYMoqO2TvNz2HUUZjiBPQhL5cIG1NMcRumuKO5vzxDwZk0K26siDJwxhq7JpEZ
	 cQW9vyW10oQp1VWDs8FTwMo+i2jbBOnhalfOVI1dHkIgbAXa1x+/jxN661ORMTEbW2
	 sF8EthCz3ezFlRCqPM4B8dB3K9O+n01VEkC9CSGvwpHmoeV9eCCZt1RfVLv0HFp74z
	 5sBET8BbmtLd9op/3K0CxKtmLepu4uMut8V23JUoI4uqCd+Kk5K1Mo1t7MeuvvFisG
	 d7Gk8WJLd2pgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf: Add is_mapping_symbol() helper for kernel
 mapping symbol filtering
Reply-To: sashiko@lists.linux.dev
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507071103.2772577-1-qirui.001@bytedance.com>
References: <20260507071103.2772577-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 20:38:07 +0000
Message-Id: <20260507203807.A1A76C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The commit message claims to replace ad-hoc mapping symbol filte=
ring in `dso__load_sym_internal()` with a single helper, but the existing a=
rchitecture-specific checks were not removed, resulting in redundant code a=
nd a code/commit message mismatch.
- [Medium] The new mapping symbol filter in `dso__load_sym_internal()` is s=
trictly gated behind `kmodule`, which incorrectly allows mapping symbols fr=
om the main kernel image (`vmlinux`) to bypass the filter.
--

commit b0c39fbcfd41cb96be112e1c6d3979a91d527b75
Author: Rui Qi <qirui.001@bytedance.com>

perf: Add is_mapping_symbol() helper for kernel mapping symbol filtering

This commit introduces a unified is_mapping_symbol() inline helper to
consolidate and replace ad-hoc mapping symbol filtering for ARM, AArch64,
and RISC-V across the perf tool, while adding x86 local symbol filtering.

> perf: Add is_mapping_symbol() helper for kernel mapping symbol filtering
>
> The perf tool currently has ad-hoc logic to filter out ELF mapping
> symbols scattered across multiple files. ARM, AArch64 and RISC-V each
> have their own inline checks in dso__load_sym_internal(), and kallsym
> processing has yet another check for ARM module symbols.
>=20
> This is fragile: adding support for a new architecture or adjusting
> which prefixes are considered mapping symbols requires touching
> multiple places, and it is easy for the checks to diverge. It also
> does not match the kernel's own is_mapping_symbol() logic, which
> additionally covers x86 local symbols (".L*" and "L0*").
>=20
> Introduce a single is_mapping_symbol() inline helper in symbol.h and
> convert all kernel symbol handling to use it.

The commit message states we are replacing the inline checks in
dso__load_sym_internal() and converting all kernel symbol handling to use
the new helper.

However, looking at the resulting code in dso__load_sym_internal(), the old
checks are still present:

		if (ehdr.e_machine =3D=3D EM_ARM || ehdr.e_machine =3D=3D EM_AARCH64) {
			if (elf_name[0] =3D=3D '$' && strchr("adtx", elf_name[1])
			    && (elf_name[2] =3D=3D '\0' || elf_name[2] =3D=3D '.'))
				continue;
		}

		if (ehdr.e_machine =3D=3D EM_RISCV) {
			if (elf_name[0] =3D=3D '$' && strchr("dx", elf_name[1]))
				continue;
		}

Should these existing ARM, AArch64, and RISC-V inline checks have been
removed to avoid redundant filtering, or was the intention to only apply
the new helper to kernel modules while leaving the old checks for user-space
binaries?

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 7afa8a1171396..6b12508ea58dc 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
[ ... ]
> @@ -1607,6 +1607,14 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>  				continue;
>  		}
> =20
> +		/*
> +		 * For kernel modules, also reject x86 local symbols (.L* and L0*)
> +		 * to match the kernel's is_mapping_symbol() logic and kallsyms
> +		 * parsing behavior.
> +		 */
> +		if (kmodule && is_mapping_symbol(elf_name))
> +			continue;
> +

When perf loads the main kernel image via dso__load_vmlinux(), it calls
dso__load_sym() with kmodule =3D 0.

Does gating this check behind kmodule inadvertently bypass the new mapping
symbol logic for vmlinux?

If so, x86 local symbols might leak into the symbol tables for the main
kernel image. Would using dso__kernel(dso) instead of kmodule correctly
cover both vmlinux and kernel modules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507071103.2772=
577-1-qirui.001@bytedance.com?part=3D1
