Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88A35E922;
	Tue,  9 Jun 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989769; cv=none; b=sOo3m+VTONwponEAjwJeMV5FV67qiuyNAmMTp/vQblJzUeS3cmp+dG6YtOM9KGmqnCPKgzL+Fa3aHoh/9t2qbbzSma3jQ4QgPJa3tYAjJWM6Xjet4AsxYOxuSBwPU/0pYXUY2k68l0fFM5rBsiRUP04hKCQC96Nvp1WT4cr/INA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989769; c=relaxed/simple;
	bh=SoLY/lE0ckiUfMvqig5ndSY582tpt6K+4g6b6ZOOfKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hofHeq8ycR53cPA1xGJQsiAnHLoACGj7hNrCKQpZmnV1MHp1poQ1Ks4Hvhl7TsxtLqDTLY0INbT0hmd9vBKB3+TJTHHA34dBa4b/U56yhIZ+AR0cERLtLxvPikf2WaNwWFOH3Hyh8EkaG8DQlJfjSML8+44CQ8EURVJnqboiZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaosZiOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaosZiOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD0A1F0089A;
	Tue,  9 Jun 2026 07:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989767;
	bh=BlJ4fquG0mwAniX3fpBPGqmDtUMxZIEP5DDdLI3OKCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SaosZiOjTOC+Y9uUrleQt7jVbDfunsbOvL68rLLaACHJS7t7d1HQMsyNCFgJBHXyc
	 RDTd+oumFQMiVk/DsTB1u7BZnAXOHTIxS5AO/v7XNBQ/k9ToAescgzmnXS2coLsLkx
	 O7tyb4n0bFi+tZpKcJ59vr8oN2fLubbPw53gGxr7f0hUuCwczOk+oewnJjHn1+L0o7
	 wgdvwH2PT3R5cykS2sM0I0HIe8MZ1ZPizLKceHmi32RTDlPl35PZf4ArCp/u7N03me
	 Opyk9NfCjfHtS0Gh76opnGvqzJ7aqmskxEXth9QtnIuXcSvnPsIPQmkUj8b6OO3qRi
	 pHq6wZR3BqOyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] perf annotate: Support BPF JIT disassembly via
 genelf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260609070732.545416-7-irogers@google.com>
References: <20260609070732.545416-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 07:22:46 +0000
Message-Id: <20260609072247.5AD0A1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Objdump fails to disassemble the temporary BPF ELF file because =
of an address range mismatch between the ELF file's hardcoded text section =
and objdump's `--start-address` boundary.
--

commit 515b53823b20255d2b911e2440f76dd5f76eaf39
Author: Ian Rogers <irogers@google.com>

perf annotate: Support BPF JIT disassembly via genelf

For in-memory BPF DSOs (DSO_BINARY_TYPE__BPF_PROG_INFO), write the
JITted instruction buffer to a temporary ELF file on disk using the
existing genelf framework (jit_write_elf). Reroute disassembly to
this temporary ELF file, allowing objdump and libasm to disassemble it
natively. Clean up the temporary file afterward.

> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 42af3603fdffd..0648afd1b5f31 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
[ ... ]
> +#ifdef HAVE_LIBELF_SUPPORT
> +#include <unistd.h>
> +#include "dwarf-regs.h"
> +static int symbol__create_bpf_temp_elf(const char *filename, struct symb=
ol *sym,
> +				       struct annotate_args *args,
> +				       char *tmp_elf, size_t tmp_elf_sz)
> +{
[ ... ]
> +	if (tmp_fd >=3D 0) {
> +		uint16_t e_machine =3D args->arch ? args->arch->id.e_machine : EM_HOST;
> +
> +		if (jit_write_elf(tmp_fd, e_machine, map__rip_2objdump(map, sym->start=
),
> +				  sym->name, buf, buf_len,
> +				  NULL, 0, NULL, 0, 0) =3D=3D 0) {

[Severity: Medium]
Will this cause objdump to misalign or truncate the disassembly?

When symbol__create_bpf_temp_elf() calls jit_write_elf(), it passes
map__rip_2objdump(map, sym->start) as the load_addr argument, but
jit_write_elf() explicitly ignores this argument:

tools/perf/util/genelf.c:jit_write_elf() {
    ...
    int
    jit_write_elf(int fd, uint16_t e_machine, uint64_t load_addr __maybe_un=
used, const char *sym,
    ...
}

Instead, jit_write_elf() hardcodes the .text section VMA to
GEN_ELF_TEXT_OFFSET (typically 128 bytes).

Later, when symbol__disassemble_objdump() invokes objdump, it uses
--start-address and --stop-address derived from the symbol's start and end
addresses:

tools/perf/util/disasm.c:symbol__disassemble_objdump() {
    ...
	err =3D asprintf(&command,
		 "%s %s%s --start-address=3D0x%016" PRIx64
		 " --stop-address=3D0x%016" PRIx64
    ...
}

For BPF DSOs, these addresses typically map to the range [0, csize]. Howeve=
r,
the actual instructions inside the generated ELF are placed at
[GEN_ELF_TEXT_OFFSET, GEN_ELF_TEXT_OFFSET + csize].

If the BPF program is smaller than GEN_ELF_TEXT_OFFSET, does objdump end up
outputting nothing? If it is larger, could this result in objdump reading
misaligned and truncated instructions that no longer match the performance
samples?

As a side note, it appears that any test added later in the series might
silently pass if it only blindly greps for offsets in objdump's output, whi=
ch
would mask this offset and truncation corruption.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609070732.5454=
16-1-irogers@google.com?part=3D6
