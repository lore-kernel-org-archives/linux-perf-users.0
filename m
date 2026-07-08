Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C31F03DE
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487321; cv=none; b=Gp1Y737ExuDVS8fngrhadwdUE62RckmRmAKc3B1EmoJFxYq/5lofbYFzPsmxMrc6oRcxXgOT8Kat4HMhUz60H148nytxmg0AwkdeXQadqSvgClSScXGkaCosJuygisllcpWN2jo3WN10sCJ2mHL+3Qj+FkURyXr/uD5s6svJGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487321; c=relaxed/simple;
	bh=8MblFwsm1i/+oUCTx3jDufSe6sql+3Uz9pefM8R2g5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j/monmOgfHtaQdDl6Ge7essUOEAZ/gpKDCYDd+zv1mNsusNxkA0yi8Zr3GZ4J4Vk2sw1VOvseECDiF1GxrHo8kZjTi9aLuhQDM+PwSv5leSyZ7Skjz4ujHcqoAZRQE8fPQG/Xo0mkO9ZBtcOSIRK9sVaTp0e+LIrQWBjTXbiK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX5/SpnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX5/SpnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9491F000E9;
	Wed,  8 Jul 2026 05:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783487320;
	bh=aucPiRXKi15UeE+PobWgOp9xjxp7o7E/miOD1kmnhjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DX5/SpnDW1iSY6JIsvLVu4gu13LsnIsTLbFFWwlF5+eEOWTZPsCE1nXQ8V99PNskg
	 +FPtf0hbnyba7efwDPCJFZUWqgl3O6vFU9e5I9iXKpf5Nh83PVbugOJLbqrsurWpa0
	 lIlbdieTmZAnBHglT3MWIwd+Xt2I6VPnBG2KFOil8MNjdLB5hy5EXh/+w9mRTnpxnb
	 4CfkY0oO1e64P3ow6NAcDKGG35RjWTkqmJbUkUXZRKm3NY0CTgvucGh09hwEre30jj
	 /bsS3qIkTTQRMdLR8HjKwL9T55iNrI8pVYp8XQB//fXBlHJuGaGW2CvaRzl4o6rxmT
	 MnatBVqa6lWWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf x86: Add .note.gnu.property to assembly linked
 into perf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Trevor Allison" <tallison@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260708045606.43649-4-tallison@redhat.com>
References: <20260708045606.43649-1-tallison@redhat.com>
 <20260708045606.43649-4-tallison@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 05:08:39 +0000
Message-Id: <20260708050839.BD9491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Adding .note.gnu.property asserts IBT support without providing =
ENDBR64 instructions, causing a #CP crash in perf memory benchmarks.
- [Medium] The .note.gnu.property section hardcodes 8-byte alignment, viola=
ting the 32-bit x86 ELF specification.
--

--- Patch [3]: [PATCH 3/3] perf x86: Add .note.gnu.property to assembly lin=
ked into perf ---
commit b48d7edb7fb18bc3dace2af272de108eb561d69b
Author: Trevor Allison <tallison@redhat.com>

perf x86: Add .note.gnu.property to assembly linked into perf

This commit adds `.note.gnu.property` to x86 assembly files linked into
perf to indicate CET properties support. This is intended to prevent static
linking from dropping CET from the final binary.

> diff --git a/tools/perf/arch/x86/tests/regs_load.S b/tools/perf/arch/x86/=
tests/regs_load.S
> index 80f14f52e3f60..1947f95cceda5 100644
> --- a/tools/perf/arch/x86/tests/regs_load.S
> +++ b/tools/perf/arch/x86/tests/regs_load.S
[ ... ]
> @@ -97,3 +97,27 @@ SYM_FUNC_END(perf_regs_load)
>   * the ELF stack should not be restricted at all and set it RWX.
>   */
>  .section .note.GNU-stack,"",@progbits
> +
> +/*
> + * We need to provide .note.gnu.property section with IBT and SHSTK,
> + * saying that this object supports the same CET properties as C code
> + * built with -fcf-protection. Otherwise static linking drops CET from
> + * the final perf binary when other objects are CET-enabled.
> + */
> +	.pushsection .note.gnu.property, "a"
> +	.p2align 3

[Severity: Medium]
Does this unconditionally hardcode 8-byte alignment for 32-bit x86 builds?

The assembly file `regs_load.S` can be compiled for 32-bit x86, which requi=
res
4-byte alignment (`.p2align 2`) for ELF notes. When the linker merges these,
the forced 8-byte alignment can create zero-byte padding gaps between notes,
corrupting the contiguous ELF note structure.

Could this cause the dynamic loader or tools like `readelf` to fail to parse
the ELF notes properly?

[ ... ]
> diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm.S b/tools/perf/bench/=
mem-memcpy-x86-64-asm.S
> index 1b9fef7efcdcc..e7b84aa43ab44 100644
> --- a/tools/perf/bench/mem-memcpy-x86-64-asm.S
> +++ b/tools/perf/bench/mem-memcpy-x86-64-asm.S
[ ... ]
> @@ -18,3 +18,27 @@
>   * the ELF stack should not be restricted at all and set it RWX.
>   */
>  .section .note.GNU-stack,"",@progbits
> +
> +/*
> + * We need to provide .note.gnu.property section with IBT and SHSTK,
> + * saying that this object supports the same CET properties as C code
> + * built with -fcf-protection. Otherwise static linking drops CET from
> + * the final perf binary when other objects are CET-enabled.
> + */
> +	.pushsection .note.gnu.property, "a"
> +	.p2align 3

[Severity: Medium]
Will this cause a Control Protection Exception (#CP) crash on IBT-capable
hardware when running `perf bench mem memcpy`?

Adding this section artificially claims IBT support and forces the linker to
enable CET on the final `perf` binary. However, `perf`'s local linkage head=
ers
do not automatically emit `endbr64` instructions for `SYM_FUNC_START`.

When `do_memcpy()` in `tools/perf/bench/mem-functions.c` indirectly calls
these assembly entry points like `memcpy_orig`:

	fn(dst, src, size);

the hardware may detect the missing `endbr64` on the indirect branch target
and throw a #CP fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708045606.4364=
9-1-tallison@redhat.com?part=3D3
