Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6BF4C9547;
	Tue,  9 Jun 2026 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030948; cv=none; b=Fw+kbgNnpvE1IL3lMurOxStKVf8DftZzmUCPKOX3XJbpWihdFKKp8uQv9cFwUGygxGIkK67XTk86lmMENAVMZqlwkhl4yO2EoySJmzZvOb2Ox0no6FjvR9KqeotTktZ/idWMOjuJjvkjVe/iE08OToxinSUCLLfvwNhZPzjLoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030948; c=relaxed/simple;
	bh=a+0qdHU5VMy8uy4NjYaTDdpaMooU2fmklQC972RW20Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnNV2FEqPjBIZu0IDCZMnyKeVKl0GYHhH7afZ+CKMCnLb14ZLE3I/oKCLEga58LK8qDFUKnia2VqYbdWDucahxEb8DUxszJGUxpEKN4QkXguuRjzwq+kXaSITu8vwAvOSjoa9/kt7qowf6z1o89VlYfd7HGAvBuYfn+oAoHzt64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx7Jayjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx7Jayjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4681F00893;
	Tue,  9 Jun 2026 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030945;
	bh=4GeMqESW7GTml7dP6W6XYen29OXnwn/iLwBbUC6vWfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wx7JayjkOHjnszeHE1xNJot4JkPdyoBim8IrAUK7Q+5IvJyDqMOgs7Zstb1zX0bdS
	 2IzYGyu1f/0lupiqiiUl7XTbAvZGB4q7zvgr337LS4i29yxZOqyXXgjdzTUnjPAPzo
	 fV1bHiopyT3GfzkJGmnvUYsKz3TWPA5PZGaLUHL4HwH+qKq+juQfG2enkUInh+tg4B
	 Z+5rgLkEeZYhfsTBq2c8i5tKsYh20all0hFLfLqHPCSFZZa1W889gcGYZ9AcAnazkn
	 UuyuPU69ykgiOOJ5iurV5e47r+VoT7gplN2ZgiFxNOPB478/U13j5zP/xf/7L6L3+9
	 klZ0+9O/A9lCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] perf annotate: Support BPF JIT disassembly via
 genelf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260609182108.975586-7-irogers@google.com>
References: <20260609182108.975586-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:49:04 +0000
Message-Id: <20260609184905.2B4681F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] JIT ELF generation uses host-native endianness and ELF class, brea=
king cross-platform analysis of BPF programs.
- [High] Mismatch between ELF text section address and DWARF debug line bas=
e address for JIT profiling.
--

commit 3c8720c4a004bb87cca5176252e00dcb2ade47e7
Author: Ian Rogers <irogers@google.com>

perf annotate: Support BPF JIT disassembly via genelf

For in-memory BPF DSOs (DSO_BINARY_TYPE__BPF_PROG_INFO), write the
JITted instruction buffer to a temporary ELF file on disk using the
existing genelf framework (jit_write_elf). Reroute disassembly to
this temporary ELF file, allowing objdump and libasm to disassemble it
natively. Clean up the temporary file afterward.

> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index 14882def9704c..c3af040121eef 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
[ ... ]
> @@ -218,9 +218,9 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unus=
ed, const char *sym,
> =20
>  	ehdr->e_ident[EI_DATA] =3D GEN_ELF_ENDIAN;
>  	ehdr->e_ident[EI_CLASS] =3D GEN_ELF_CLASS;
> -	ehdr->e_machine =3D GEN_ELF_ARCH;
> +	ehdr->e_machine =3D e_machine;

[Severity: High]
Does this hardcoded endianness and class break cross-platform trace analysi=
s?

Since e_machine is now dynamically set, if a 64-bit x86 host analyzes a
32-bit or big-endian BPF trace (like ARM32 or s390x), wouldn't this generat=
e a
corrupt ELF container (e.g., a 64-bit little-endian ELF claiming to be
EM_S390) and cause objdump to reject the file or decode with the wrong
endianness?

[ ... ]
> @@ -230,8 +230,8 @@ jit_write_elf(int fd, uint64_t load_addr __maybe_unus=
ed, const char *sym,
>  	phdr =3D elf_newphdr(e, 1);
>  	phdr[0].p_type =3D PT_LOAD;
>  	phdr[0].p_offset =3D GEN_ELF_TEXT_OFFSET;
> -	phdr[0].p_vaddr =3D GEN_ELF_TEXT_OFFSET;
> -	phdr[0].p_paddr =3D GEN_ELF_TEXT_OFFSET;
> +	phdr[0].p_vaddr =3D load_addr;
> +	phdr[0].p_paddr =3D load_addr;

[Severity: High]
Does changing the ELF virtual addresses to use load_addr break DWARF mappin=
g?

In tools/perf/util/genelf_debug.c:jit_process_debug_info(), the code still
passes the hardcoded GEN_ELF_TEXT_OFFSET to add_debug_line():

	add_debug_line(dl, debug, nr_debug_entries, GEN_ELF_TEXT_OFFSET);

If the ELF is generated with load_addr but the DWARF .debug_line information
uses a base address of GEN_ELF_TEXT_OFFSET, will perf annotate and standard
debuggers fail to map source code lines to the disassembled instructions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609182108.9755=
86-1-irogers@google.com?part=3D6
