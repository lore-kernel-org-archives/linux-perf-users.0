Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6E3B7B97
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522997; cv=none; b=j8wd4JfCPxr7chaFm4aVhajWJenwSQLbvjVnR9eM8yeI+v3ru0svuW9Amej6Fi8gxd2VUHi/2fAbC05qNy9oFI+s0C0Nt9UnW6KrmcMuAHtqRs2/BStq/3sr4ImHgwB87xW6+tEfTalqCbPzm2rCJREaN/P5QvcPSDaAGk3pKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522997; c=relaxed/simple;
	bh=AfinkU3zC/cJ1iUhCFlcZ3fZUO8i8FIhit/qfucglnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q0RCwfVoQuOcrlF/8sHPxL6ESidQLS2lPyD/gU57QfFqcEOdjUBF5JoDE273iAg31KiNOjnVnDSZRCbWnavUuN/2PWiYqJ0FBtyoa8kMLeIkGLD6h7KLGYKY2o4RGbL1fdNhJRZ32SukFyaeyK0aTchDoPRybNHT4tuOQ9RhXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e269Emt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e269Emt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A931F00898;
	Wed, 16 Sep 2026 01:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522984;
	bh=vjnr+rcJkr7ahTcahTmrpUPBDhJmauPT9ya3GTTImgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e269Emt0DD8e1wwnps/+ntWrR1JuQ0zQsZUZaTbSuCBEWPv3Sk2BKfXfZS/yZHfzh
	 TNL0gabbrsoPulbwb73U7Nlqkcnr3f1GTygfbpq0VZvWKIvWuPy7LUmLQB7nhrVqaB
	 wcvTdgEBGKuJRAOrnN1gDcGGpS1bmSPnWcYwTBtPePyJem68bC9RZ6wSUgDHpfaext
	 6oNDdUjV+z5IqD7+n+bcGaEdVoVFGLOUDJwUwuuleyR0UNU5MgeaW2zZrUpxOGlNnz
	 CkiNkCAtXe/d3BxMfgDnNdAFvczCeuRQ8E9oD7W7ZN4B6qV38DNV+LtpzqNidNSlCs
	 ndvGEu6TYIkTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/26] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <63d15af66450065329b08f41794738c2e8c811ab.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <63d15af66450065329b08f41794738c2e8c811ab.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:43:03 +0000
Message-Id: <20260916014303.D5A931F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: arm64 pcrel load formatting failure aborts disassembly
--

commit ad5ee451ad40bd108c85e2fea401d911d9304dee
Author: Tengda Wu <wutengda@huaweicloud.com>

perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump

This commit fixes an inconsistency in how libllvm parses arm64 adrp
instructions by manually extracting the target address via
symbol_lookup_callback(). The extracted address is then converted to match
objdump's format, ensuring compatibility with existing parsers.

> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index a0deb742a7331..a78845689aa1c 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c
[ ... ]
> @@ -228,12 +240,42 @@ int symbol__disassemble_llvm(const char *filename, =
struct symbol *sym,
[ ... ]
>  		if (storage.pcrel_load_addr !=3D 0) {
> -			char *name =3D llvm_name_for_data(dso, filename,
> +			char *name;
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
Could this error path escalate a minor string formatting mismatch into a
complete failure of the disassembly operation?

If an ARM64 instruction triggers a PC-relative load but its disassembled
text lacks a comma (e.g., due to an unexpected mnemonic format from LLVM,
or data incorrectly decoded as an instruction), strchr() returns NULL and
triggers this abort.

Because the error path in symbol__disassemble_llvm() fails to clean up
partially populated lists, aborting the disassembly here discards the LLVM
disassembly for the function. When the fallback disassembler takes over,
this leaves interleaved, corrupted disassembly lines and causes a memory
leak.

> +
> +				s++;
> +				*s =3D '\0';
> +				disasm_len =3D strlen(disasm_buf);
> +				disasm_len +=3D scnprintf(disasm_buf + disasm_len,
> +							sizeof(disasm_buf) - disasm_len,
> +							" %"PRIx64,
>  							storage.pcrel_load_addr);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D2
