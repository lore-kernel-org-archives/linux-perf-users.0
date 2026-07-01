Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAF2370AEC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878877; cv=none; b=taDqHcWZCvsxu3MVnUoEYg4hggidc0xuYn3VGgIlTq2vQB1cgjH4hkExQc20U54m+CejlGBf94e2ZB5kpoI0+JCJscXYJz+kNViGywo4nGKHu5eN1Lffp6JjOZiZkDFwNVS7Zh4x1dBiCcPoe0xIv616yNpBmlBsgYtTxbW/Wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878877; c=relaxed/simple;
	bh=y437BNktkLawwW6d35yZgIE7OJ/r1uTJ1ZDrB62WFk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L3IqaKAkx/6Upmss8fNpR3NdSUw4ppJ8doWSnLt/3HRgfr7BqxWvx2ipV9awAOiNsT5ux6RQ9jMVN7JyBgFFwQqmLLkph/YG97YRgs/tmxObSmM3A3ikt3FnL2zdNgavIYA+AJP87zRk6v2L9/gvpVGaCCwl4TawLzctAevKMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaxRNIWF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaxRNIWF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F631F000E9;
	Wed,  1 Jul 2026 04:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782878868;
	bh=EwWsDcRTwaImabFO8ZXBuWpumvjCw/yN2LQ52Fa3oGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CaxRNIWFtJv+m7sMEODN5K7bVbC3yY0/fpFoOzcubKtgRXJJ+m51D3J+neLD/uBx5
	 INGT5AvBzVNIEyqhYCVkaPCzweiGH5dms5LiwMPqQni0zgqZUtZ6EfMMQtoZ8gz3Ys
	 xHloqFDCLfKTopNKen8ECmzaeWpk1W6inEpClasvK49xZd5oUR5DlGLeXx1doHuijW
	 NF2AibLJv/ov0KplV6JC//NYkbvy5+mh6PW8bOY9HsbWFI0I9bNSBWwltl3nUi/eTQ
	 GKB+YW3226H7zF0dRq7Ne+PknFtVipMCeqwQ8t0YXLkaCXk64ZazsdNQQN1EkTVBs8
	 Ymx1E0MfUKbjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/21] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701035355.752944-3-wutengda@huaweicloud.com>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-3-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:07:48 +0000
Message-Id: <20260701040748.64F631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Symbol resolution fails for relocated kernels (KASLR) and user-spa=
ce shared libraries due to mismatched address spaces.
- [Low] Build failure due to undeclared `machine` variable and undefined `m=
achine__normalized_is()` function in `capstone_init()`.
- [Low] Missing `<stdlib.h>` inclusion causes musl libc build failure.
- [Low] Usage of `ARM64_GRP_BRANCH_RELATIVE` causes build failures with Cap=
stone versions prior to 5.0.
--

commit 1f9744f04e456b1209677658edb7f30a5b26e56d
Author: Tengda Wu <wutengda@huaweicloud.com>

perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump

The patch implements extended formatting for arm64 jump and adrp instructio=
ns
during symbol__disassemble_capstone() to match objdump's expected output st=
yle.
It adds instruction detail resolution in capstone_init() and formats the
output with correct symbol and offset mappings.

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 9bba78ee0c5a2..a9c0a1d2eb036 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c

[ ... ]

> @@ -218,6 +218,12 @@ static int capstone_init(uint16_t e_machine, csh *cs=
_handle, bool is64, bool is_
>  		 * on x86 by investigating instruction details.
>  		 */
>  		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
> +	} else if (machine__normalized_is(machine, "arm64")) {

[Severity: Low]
Does this code cause a build failure? The variable machine is not declared
in capstone_init(), and the function machine__normalized_is() does not appe=
ar
to be defined in the codebase.

> +		/*
> +		 * Same as x86: arm64 needs instruction details to resolve
> +		 * symbolic addresses
> +		 */
> +		perf_cs_option(*cs_handle, CS_OPT_DETAIL, CS_OPT_ON);
>  	}
> =20
>  	return 0;

[ ... ]

> +static bool is_pc_relative_insn(struct cs_insn *insn)
> +{
> +	int i;
> +
> +	if (insn->id =3D=3D ARM64_INS_ADR || insn->id =3D=3D ARM64_INS_ADRP)
> +		return true;
> +
> +	if (insn->detail =3D=3D NULL)
> +		return false;
> +
> +	for (i =3D 0; i < insn->detail->groups_count; i++) {
> +		if (insn->detail->groups[i] =3D=3D ARM64_GRP_JUMP ||
> +		    insn->detail->groups[i] =3D=3D ARM64_GRP_CALL ||
> +		    insn->detail->groups[i] =3D=3D ARM64_GRP_BRANCH_RELATIVE)

[Severity: Low]
Will this break compilation against Capstone versions prior to 5.0?
ARM64_GRP_BRANCH_RELATIVE was introduced in Capstone 5.0. Since the perf
tool's build feature detection doesn't mandate a specific Capstone version,
relying on this enum might cause build failures on older setups.

> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
> +				       size_t len, struct annotate_args *args,
> +				       u64 addr)
> +{

[ ... ]

> +	if (is_pc_relative_insn(insn)) {
> +		/* Extract last immediate value as address */
> +		last_imm =3D strrchr(buf, '#');
> +		if (!last_imm)
> +			return;
> +
> +		orig_addr =3D strtoull(last_imm + 1, &endptr, 16);

[Severity: Low]
Can this cause a build failure on musl libc? The POSIX standard function
strtoull() is used here, but stdlib.h is not explicitly included in the
file. Relying on implicit inclusions often works on glibc but breaks on
musl libc.

> +		if (endptr =3D=3D last_imm + 1)
> +			return;
> +
> +		/* Relocate map that contains the address */
> +		if (dso__kernel(map__dso(map))) {
> +			found_map =3D maps__find(map__kmaps(map), orig_addr);
> +			if (found_map =3D=3D NULL)
> +				return;
> +			map =3D found_map;
> +		}
> +
> +		/* Convert it to map-relative address for search */
> +		addr =3D map__map_ip(map, orig_addr);

[Severity: High]
Does this code fail to resolve symbols for relocated kernels (KASLR) or
user-space shared libraries (PIE)?

The extracted orig_addr is in the objdump address space. However,
maps__find() and map__map_ip() expect absolute memory addresses. By omitting
the translation step via map__objdump_2mem(map, orig_addr) (which the x86
implementation handles correctly), KASLR relocated kernels will fail in
maps__find(), and user-space shared libraries will underflow in
map__map_ip().

> +
> +		sym =3D map__find_symbol(map, addr);
> +		if (sym =3D=3D NULL) {
> +			map__put(found_map);
> +			return;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701035355.7529=
44-1-wutengda@huaweicloud.com?part=3D2
