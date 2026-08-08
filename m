Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883233CF217
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Aug 2026 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194214; cv=none; b=sTcnSVGl1IDR2VKWVWLx3PHsbhDTVMIQVwcV8dgS011CpHRaMW+RnPRoTDb04jTV0XpKP0WB9OD/Wvmin5mUs9uztr9itZCnf0jNjllLJVIIq403uKjnHc2Hpulg69Sspn8drukXzRWR+iE7PPgvzOkoAkgerSXM7o2JHWloy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194214; c=relaxed/simple;
	bh=FfWhDGnvfxzKGH2Nx52YTFEudHA4HHYZM4kv5cUZWnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k3J10K3tpclrfwZyWDOR+pl7X6r2Bdtj+Mv0XeQqHbj29GrErf/FEWV8t2q3m3FT5a7jX+04+mvfR9Yv8B1G2eVhd8wzCQA58SdGHtN2cIW3JaKuK/H328ZQIgXYxbNdlUGo5jG7BFh2lGD+NRQ0Cl6hAiEMB6oVS6PFNwxeaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g50Dpvro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g50Dpvro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6F31F000E9;
	Sat,  8 Aug 2026 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786194210;
	bh=CKd/nlHsSZ8pyJPeR4wzsoiDsgJ2lTbWlqBJGxnw9Sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g50DpvrolDuBPNlQvJVfKpVdIr2s+Pv3mnVkOEJjK3VbK1FmdoTGkNgV+2Agh+zvG
	 Nv4VWOmZZKIUjt9yuQJD0wlx435nHiCqeOYB104yH6VwsilqmEWQfyPEyIOottkT9J
	 LFnIhbAkDsVYzXuST5V79e9f8HJNcK6gk/2HkUQcK5TUCfy4egM8+WpiA7GmDPeijo
	 WRAHKRFYlvaK+SxEuEdJEWspcpIifscBKJcUUMbLaCXIKgXdPMR+FJk007oysliJKE
	 sDHyex0l0XVjTVpxBQ20NNGRNnnYHhgPhRfOo9OzCoHTBTTAbQWlPApdzdGW+0D/J8
	 JYnDJALB+a7nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/23] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260808122400.2961238-3-wutengda@huaweicloud.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-3-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 13:03:29 +0000
Message-Id: <20260808130329.EA6F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of the dynamically allocated string `name` on an err=
or path if a comma is missing in the disassembled instruction, which also b=
rittly aborts the entire disassembly process.
--

--- Patch [2]: [PATCH v4 02/23] perf llvm: Fix arm64 adrp instruction disas=
sembly mismatch with objdump ---
commit d33f174b93415a7430f8bf32e53bbf77ad2fce9a
Author: Tengda Wu <wutengda@huaweicloud.com>

perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump

This commit addresses an inconsistency where libllvm parses arm64 adrp
operands as raw immediates instead of the address format used by objdump.
It extracts the target address and resolves the symbol, reformatting the
disassembly output to match objdump's expectations.

> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index a0deb742a7331..6b53b283205ab 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c

[ ... ]

> @@ -230,10 +242,40 @@ int symbol__disassemble_llvm(const char *filename, =
struct symbol *sym,
>  		if (storage.pcrel_load_addr !=3D 0) {
>  			char *name =3D llvm_name_for_data(dso, filename,
>  							storage.pcrel_load_addr);
> -			disasm_len +=3D scnprintf(disasm_buf + disasm_len,
> -						sizeof(disasm_buf) - disasm_len,
> -						"  # %#"PRIx64,
> -						storage.pcrel_load_addr);
> +
> +			if (arch__is_arm64(args->arch)) {
> +				/*
> +				 * For arm64, replace the immediate operand with
> +				 * the resolved address to match objdump's output.
> +				 *
> +				 * Example conversion:
> +				 *   From: adrp  x18, 8014
> +				 *   To:   adrp  x18, ffff800081f5f000
> +				 */
> +				char *s =3D strchr(disasm_buf, ',');
> +
> +				if (s =3D=3D NULL)
> +					goto err;

[Severity: Medium]
Does this leak name if a comma isn't found in the disassembled instruction?

Looking at symbol__disassemble_llvm(), name is allocated earlier in this
block via llvm_name_for_data(). If strchr() fails and the code jumps to the
err label, name appears to be leaked since the err cleanup path only frees
code_buf and line_storage.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808122400.2961=
238-1-wutengda@huaweicloud.com?part=3D2
