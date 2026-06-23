Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091C3263C8C
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220753; cv=none; b=UBNfmTCrt7MGI1HYRMsUckLQVvomO5WGP7NfYeBUUReW6Eg3gxCwpP6wLrkAXbZCmeVjt05wXqGBqJvezNHvNAbWEjmPrN/bWdTOpbdCuqtSxynQSitL2cDbAU+Ada4Slzr/G1Kp01WeYFdfXPFsk2hkwvk16FYWP/PUYBUK4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220753; c=relaxed/simple;
	bh=8Ed/g/fbjMDiynwJzY8M2NisATT2tR1mKd+CJRgOd90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JlMf+L4AjZAHYHV17/L3avpxee1k8kxZwXbktbAZz+lyivtAoyRxK2gzy7ju7T3w++BgZDp1XGcOJ4PG28SDg+PN9gCdK5r8rG5xIOE5gc1ZkHCMevnoQNs4E/UwLj2XnnnWN+Rp7r6LFpYNAmdQANwyVK6yIrM1WR+2MUstENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nypi6Vks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nypi6Vks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803831F000E9;
	Tue, 23 Jun 2026 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782220751;
	bh=nwnJ2FPoFKQgb0G+mi//fMq+sdqSsnd+gbwLfbidkmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nypi6Vksz1BZbJLKOtXrndk1o2pypl17CLWP22V5OLAo+TtBuxAs9UViB5ux47Mxr
	 xmYULrAmJvSXx02RFOxnzONTR3HVRWQyID3bchoC+68fTn3TaL6VCKvYjOmC0CYy5f
	 JfxUOOWYYT94argiscN9GbEHW46RSHNjt7RTNjSSBjMk5wAWh/9F71zkgK9XxD4kZ8
	 oFGAQVKnNg2V7THkRpheOa9fUP0mjGGTku9K9Vpx4l1w22KCl/ZngtQMgpoNe54cIv
	 hcSXGZhsaAAl0PoOdD5bFvRS6EuiKpgjdVHjkSoA1kcgEM39dsWrBuDJmRoIwMdGTZ
	 wKFi9QgC5gIDw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/5] perf disasm: Add ARM64 architecture
 detection and raw instruction parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shuai Xue" <xueshuai@linux.alibaba.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623130234.8709-3-xueshuai@linux.alibaba.com>
References: <20260623130234.8709-1-xueshuai@linux.alibaba.com>
 <20260623130234.8709-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:19:10 +0000
Message-Id: <20260623131911.803831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] `disasm_line__parse_arm64` corrupts disassembly lines from LLVM an=
d Capstone by assuming the first word is always raw hex bytes.
- [High] Assigning `dl->ins.name =3D ""` leads to a glibc crash (`free(): i=
nvalid pointer`) during teardown.
- [Low] Missing explicit inclusion of `<stdio.h>` for `sscanf`.

Pre-existing issues:
- [High] Reads past the end of the line buffer when processing raw hexadeci=
mal instructions.
--

commit 76213afac23a5e082aabd6700958b58201fa5b8a
Author: Shuai Xue <xueshuai@linux.alibaba.com>

perf disasm: Add ARM64 architecture detection and raw instruction parsing

This commit adds an architecture detection helper for ARM64 binaries and
introduces a new parser to extract raw 32-bit instruction words from ARM64
objdump output. It wires up the new ARM64 parsing path alongside the existi=
ng
PowerPC implementation.

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 59ba88e1f7443..83fad4f01442b 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -902,6 +916,53 @@ static int disasm_line__parse_powerpc(struct disasm_=
line *dl, struct annotate_ar

[Severity: High]
This is a pre-existing issue, but does the pointer arithmetic in
disasm_line__parse_powerpc() read past the end of the line buffer?

char *tmp_raw_insn, *name_raw_insn =3D skip_spaces(line);
char *name =3D skip_spaces(name_raw_insn + RAW_BYTES);

If symbol__disassemble_raw() populates the line argument with an 8-character
string, and RAW_BYTES is hardcoded to 11, could skip_spaces() end up reading
from uninitialized stack memory?

> +/*
> + * Parses ARM64 disassembly output which includes raw instruction bytes.
> + * ARM64 objdump format:
> + *   a9bf7bfd 	stp	x29, x30, [sp, #-16]!
> + *
> + * The raw instruction is a hex word (typically 8 chars) followed by whi=
tespace.
> + */
> +static int disasm_line__parse_arm64(struct disasm_line *dl, struct annot=
ate_args *args)
> +{
> +	char *line =3D dl->al.line;
> +	const char **namep =3D &dl->ins.name;
> +	char **rawp =3D &dl->ops.raw;
> +	char *name_raw_insn =3D skip_spaces(line);
> +	char *end_raw, *name, *tmp_raw_insn;
> +	int ret =3D 0;
> +
> +	if (name_raw_insn[0] =3D=3D '\0')
> +		return -1;
> +
> +	/* Find end of raw instruction hex by looking for whitespace */
> +	end_raw =3D name_raw_insn;
> +	while (*end_raw && !isspace(*end_raw))
> +		end_raw++;
> +
> +	name =3D skip_spaces(end_raw);
> +
> +	if (args->options->disassembler_used)
> +		ret =3D disasm_line__parse(name, namep, rawp);

[Severity: High]
If a user analyzes a binary with the capstone or llvm disassemblers, the
output lacks raw hexadecimal bytes. Does this loop assume the first
non-whitespace token is always the raw hex instruction?

If so, could this isolate the instruction mnemonic by mistake, and cause the
remaining operands to be parsed incorrectly as the instruction mnemonic?

> +	else
> +		*namep =3D "";

[Severity: High]
When perf annotate is run with the source flag, the disassembler_used option
evaluates to 0. This assigns a read-only string literal to the namep pointe=
r.

Later on, disasm_line__free() unconditionally attempts to free this memory:

void disasm_line__free(struct disasm_line *dl)
{
        zfree(&dl->ins.name);
        ...

Will attempting to free this string literal cause a glibc crash?

> +
> +	tmp_raw_insn =3D strndup(name_raw_insn, end_raw - name_raw_insn);
> +	if (tmp_raw_insn =3D=3D NULL) {
> +		if (args->options->disassembler_used)
> +			zfree(namep);
> +		return -1;
> +	}
> +
> +	remove_spaces(tmp_raw_insn);
> +
> +	if (sscanf(tmp_raw_insn, "%x", &dl->raw.raw_insn) !=3D 1)

[Severity: Low]
Does this new usage of sscanf require an explicit include of <stdio.h> at t=
he
top of the file to prevent musl libc build failures?

> +		dl->raw.raw_insn =3D 0;
> +	free(tmp_raw_insn);
> +
> +	return ret;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623130234.8709=
-1-xueshuai@linux.alibaba.com?part=3D2
