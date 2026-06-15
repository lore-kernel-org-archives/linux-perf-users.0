Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78168319860
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560412; cv=none; b=i0WpTYpxaqpZOyGizWgbZX/s2Z01e6XEZHdYSgbhrMCT01dq3GDrp3+7tknYVxXee0wvKYueITOq13nZVc0i6SnztNhzQg7TKh58hELM37Jy7CE56cW5kaAH/3PFRxrfCA3//7LcdRRJzByuD+Y2PODuQEUSr4I5zw87s7louuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560412; c=relaxed/simple;
	bh=MIwkB0FP5Y5JDf0D/5HqBWVcnzOrqM3VP5+FlPnwtSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=etLkxOAMp4+T7NgBi+yPL7MvXVCgZJ2VKlV9mj2HvTJOqUBiROFcYrqevkjBckwNKTDhDYWqc58NnXcPzdSYN2YKaVxDm7Vk3wEdi5izOXLaCDkTc+VN9WFV+sONwvEd01fh19zySYDG3r8GpWI1M7S4bQJMIPGKm0zOYvG3gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQwdbCCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQwdbCCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096C51F000E9;
	Mon, 15 Jun 2026 21:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560411;
	bh=ivIvoJ2wh0q4DsxIwkGlnYbkYYIwXW6c63NZ+izBDSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WQwdbCCfoHV62OM52SVRjA8cAUcCa8an13hW11XKrllxd2rFJoVBulnD66BscMnc2
	 cAk7qcmLzYdokl1z7TZI40PWwnMEiJWH18KfETRjqh19HDeVFY6r8eawxWQTSukiHm
	 k3S9vlKt+zPQAaReWjHME8vhNTOnJDUkr4zvo2c1HA2CpUsXKY6+iHVVg4qo194KWT
	 h/1a9d7bcouxGW/fdBWwPy0r8RLTY/yjdZA5ZEPMAEhh14G90OsHD/b0gwO7NLsQtC
	 zU+D+Lg6EAL4IwEar3WBJXBYaKCR4GBg+NC8wDzmaep0o7UVRdhE2mwjxdM+Ph6T2P
	 UknKfITFDmuFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] perf bpf: Validate array presence before casting
 BPF prog info pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615213657.35776-9-acme@kernel.org>
References: <20260615213657.35776-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 21:53:30 +0000
Message-Id: <20260615215331.096C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete validation of BPF program info arrays leaves paths to a=
rbitrary pointer dereferences open in synthesize_bpf_prog_name().
- [High] Missing array bitmask validation in symbol__disassemble_bpf_libbfd=
() leads to arbitrary pointer dereferences.
- [High] Attacker-controlled length in dso__read_symbol() triggers assertio=
n failure (DoS) or out-of-bounds heap read.
--

commit 2f222987999c231a301341e2fbb0abf020879147
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Validate array presence before casting BPF prog info pointers

Several functions cast bpf_prog_info fields (jited_ksyms,
jited_func_lens, jited_prog_insns) from u64 to pointers and
dereference them. These fields are only valid pointers if
bpil_offs_to_addr() converted their file offsets to addresses, which
only happens when the corresponding PERF_BPIL_* bits are set in
info_linear->arrays.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 57d53ba848359..fa3ebc8ea7f09 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
[ ... ]
> @@ -959,12 +963,15 @@ int evlist__add_bpf_sb_event(struct evlist *evlist,=
 struct perf_env *env)
>  	return evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
>  }
> =20
> -void __bpf_event__print_bpf_prog_info(struct bpf_prog_info *info,
> +void __bpf_event__print_bpf_prog_info(struct perf_bpil *info_linear,
>  				      struct perf_env *env,
>  				      FILE *fp)
>  {
> -	__u32 *prog_lens =3D (__u32 *)(uintptr_t)(info->jited_func_lens);
> -	__u64 *prog_addrs =3D (__u64 *)(uintptr_t)(info->jited_ksyms);
> +	struct bpf_prog_info *info =3D &info_linear->info;
> +	__u64 required_arrays =3D (1UL << PERF_BPIL_JITED_KSYMS) |
> +				(1UL << PERF_BPIL_JITED_FUNC_LENS);

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the validation
remains incomplete. Could this leave a path for arbitrary pointer
dereferences open in synthesize_bpf_prog_name()?

If a crafted perf.data file omits PERF_BPIL_PROG_TAGS and PERF_BPIL_FUNC_IN=
FO
from the bitmask but provides raw file offsets, bpil_offs_to_addr() won't
convert or clear them. Since required_arrays doesn't check these flags,
synthesize_bpf_prog_name() will then unconditionally cast info->prog_tags a=
nd
conditionally cast info->func_info to pointers and dereference them.

Should PERF_BPIL_PROG_TAGS and PERF_BPIL_FUNC_INFO be added to the
required_arrays bitmask check here?

[ ... ]
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 1a2fc6d18da74..79f1a30f3683d 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
[ ... ]
> @@ -1995,6 +2001,10 @@ const u8 *dso__read_symbol(struct dso *dso, const =
char *symfs_filename,
>  			return NULL;
>  		}
>  		info_linear =3D info_node->info_linear;
> +		if (!(info_linear->arrays & (1UL << PERF_BPIL_JITED_INSNS))) {
> +			errno =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> +			return NULL;
> +		}
>  		assert(len <=3D info_linear->info.jited_prog_len);

[Severity: High]
This is a pre-existing issue, but does this assertion evaluate attacker
controlled lengths?

In dso__read_symbol(), the local variable len is calculated using sym->start
and sym->end from a parsed PERF_RECORD_KSYMBOL event, which comes from the
perf.data file.

Since both len and jited_prog_len come from the data source, could this
assertion be forced to fail, crashing the tool? Or, if perf is compiled
with NDEBUG, couldn't this bypass the check entirely, allowing an
out-of-bounds heap read that exposes memory contents in the disassembly out=
put?

[Severity: High]
This is a pre-existing issue, but it appears a similar lack of array bitmask
validation exists in symbol__disassemble_bpf_libbfd() in
tools/perf/util/libbfd.c. Was this file missed during the conversion?

Looking at symbol__disassemble_bpf_libbfd(), it directly casts and
dereferences info_linear->info.jited_prog_insns and
info_linear->info.jited_ksyms without checking if PERF_BPIL_JITED_INSNS or
PERF_BPIL_JITED_KSYMS are set in the info_linear->arrays bitmask.

Additionally, it calls bpf_prog_linfo__new(), which blindly copies memory
from info->line_info using memcpy(). A crafted perf.data file could provide
raw file offsets for these fields while unsetting the bitmask flags,
bypassing address conversion and potentially causing arbitrary memory reads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615213657.3577=
6-1-acme@kernel.org?part=3D8
