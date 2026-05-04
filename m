Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42914364923
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886867; cv=none; b=Rh60lBBv3iswrYqQXPGz8HcU/sZkclrQzlGWTGFDmhsrL3L+B/pAMD2tSN2XpAF7mY3Oj5S3CBvs1ZNqmAvBIRJVE6ry5o+rodm03mpru9RIV39CNhA6XI5CPEX7SBwqiFftlZZOjCA4UwXkEGuLs/3X1hFTGEII22uhitX8Rfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886867; c=relaxed/simple;
	bh=wfouoM+IGMY9eSZBkReruBUvXt7lIXQH32YxiRrdujY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vogp/yeUhUD2L33mrRva6DAOME8w1VgJpSaDWJBlGUGcW/oAM+21p24thhTxtHtsFPh8NtPgmenGm/mxMvu1ekeNWk5DhblreOr6mQoZSJoa+cm1v82zXsgJ1YZMLBSy3INSdeAHYTlEQ5SXqFf/wFcIWlzeHTfKBb0DbFX9H6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6tSnrMl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6tSnrMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D71C2BCB8;
	Mon,  4 May 2026 09:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777886866;
	bh=wfouoM+IGMY9eSZBkReruBUvXt7lIXQH32YxiRrdujY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=B6tSnrMlJXx6rxyTMyiXKyaPzhjjHN2byykEzUz1YjP8GXkdI+aFovSvBV8Xh8Si/
	 Kw3rrmgI2DSvAxrnbMGULwh6wXUo9+yTwL0s8JmvqjvbXRMzKUmRQzgEjG0QwtGWlm
	 GK4MuBCsymRax4spWV2LQUvFJLr2qLVHzExHQ6JfHTpmO74A2UUI2u9Hhy2aEeb+0M
	 8HM2tSQuz3TecyfPDsi0xzABj9EhY6jSCggibXz/c4qdG8DZfyMHPN0mQntxcdAzQI
	 qN5M927uxpyBHxCI+fNhKEi0+YZsN7a5otqC6r+kK2mofquxAbjEqsOC6SDt3ni9fY
	 DYJRhMUanLvZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Extract is_mapping_symbol() helper for mapping
 symbol filtering
Reply-To: sashiko@lists.linux.dev
To: "Rui Qi" <qirui.001@bytedance.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504090609.1801880-1-qirui.001@bytedance.com>
References: <20260504090609.1801880-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 09:27:46 +0000
Message-Id: <20260504092746.B6D71C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Destructive empty map insertion in `machine__process_ksymbol_regis=
ter()` corrupts the kernel map tree.
- [High] Over-broad filtering unconditionally drops valid user-space and JI=
T symbols.
--

commit ae672508d7c2692194bb670cadab94e218fa13f7
Author: Rui Qi <qirui.001@bytedance.com>

perf: Extract is_mapping_symbol() helper for mapping symbol filtering

This commit extracts ad-hoc ELF mapping symbol filtering logic into a unifi=
ed
is_mapping_symbol() helper in symbol.h. It replaces architecture-specific
checks with a single check that ignores any symbol starting with '$', '.L',=
 or
'L0', and applies it across multiple symbol loading paths.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -769,6 +769,12 @@ static int machine__process_ksymbol_register(struct =
machine *machine,
>  		dso =3D dso__get(map__dso(map));
>  	}
> =20
> +	/* Ignore mapping symbols in ksymbol events */
> +	if (is_mapping_symbol(event->ksymbol.name)) {
> +		err =3D 0;
> +		goto out;
> +	}
> +

Could this early return corrupt the kernel map tree? If a new map was just
allocated and inserted via maps__fixup_overlap_and_insert() earlier in this
function, taking this goto out leaves the empty, unpopulated map in the
rbtree.=20

Since maps__fixup_overlap_and_insert() actively splits or deletes
existing overlapping maps, does this permanently punch a hole in the address
space layout?

Would it be safer to perform the is_mapping_symbol() check at the very
beginning of the function before any state mutations occur?

[ ... ]

> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1592,20 +1592,9 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>  		if (!is_label && !elf_sym__filter(&sym))
>  			continue;
> =20
> -		/* Reject ARM ELF "mapping symbols": these aren't unique and
> -		 * don't identify functions, so will confuse the profile
> -		 * output: */
> -		if (ehdr.e_machine =3D=3D EM_ARM || ehdr.e_machine =3D=3D EM_AARCH64) {
> -			if (elf_name[0] =3D=3D '$' && strchr("adtx", elf_name[1])
> -			    && (elf_name[2] =3D=3D '\0' || elf_name[2] =3D=3D '.'))
> -				continue;
> -		}
> -
> -		/* Reject RISCV ELF "mapping symbols" */
> -		if (ehdr.e_machine =3D=3D EM_RISCV) {
> -			if (elf_name[0] =3D=3D '$' && strchr("dx", elf_name[1]))
> -				continue;
> -		}
> +		/* Ignore mapping symbols in ELF files */
> +		if (is_mapping_symbol(elf_name))
> +			continue;

The previous logic carefully restricted filtering to exact ARM/RISC-V mappi=
ng
prefixes (like '$a', '$d', '$x') on those specific architectures.=20

Will unconditionally dropping all symbols starting with '$' across all
architectures silently discard legitimate user-space functions? GCC permits
'$' in identifiers, and it is frequently used in user-space code.

[ ... ]

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1566,6 +1566,10 @@ static int dso__load_perf_map(const char *map_path=
, struct dso *dso)
>  		if (len + 2 >=3D line_len)
>  			continue;
> =20
> +		/* Ignore mapping symbols in perf map */
> +		if (is_mapping_symbol(line + len))
> +			continue;
> +

Similarly, does applying this kernel-centric heuristic here discard valid
symbols for user-space JIT environments? The '$' character is a valid and
common prefix for function names in languages like Java and Scala.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504090609.1801=
880-1-qirui.001@bytedance.com?part=3D1
