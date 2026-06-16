Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4833D890D
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639058; cv=none; b=saWYSzsCkhj8zUu0OhQGhynqW4TIMoqeGcb2Qoa6i/9MyY3doip6ZSyDp6vbYqMiGD5ePDFo3rTlnWL7Bfmv1SwXY4mDpo76r50Exk39qv47ukL0djmhRjbU0xWNOGC0bJs9nnSnLOam4rFxvPRcX3VZ6Bbo+EFnxcCrzVJ5gfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639058; c=relaxed/simple;
	bh=3DOeI9iLn1F1eKULfdZp0GAFUnhrg4AQkaybLT/IqrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n7ck6czqiWi83KIGaHZVS73pqWomZqG2kfTG1jZOPGEj/0QG2Da5wwZfKEmeW8H4welnYu/OMMzJ1evCVL8kU+KssYRrQmF+4FVhEeXl6Lm8CK0ObtgzPlsFhAXq7RjMKd83EkU+5R2PBPfe39CwNjZVEFnN8MnHBHuSMFlmB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhmIiXWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhmIiXWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6DA1F00A3A;
	Tue, 16 Jun 2026 19:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639057;
	bh=8QR2SdJ0UhCO2FCgqt36i7RYCzTd8wOFwPsJ1DAIfzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nhmIiXWkng0+FosZBuamsw7oApRSPmwjAa9pf8cxyXkXEjQQaUNSOQCyahtEk52d/
	 EVVuCaKUrVFgxHLYPbbr9b5s9R4QRFxFttaPimh3KsmmnrFrIt9/6qDzUpexCyFYnM
	 WSovruZko3jQJqQ69tHib9nF20QlyH5qdzVKn1aCT/ftc1aL6shCSghOhD1NYCraU5
	 KyQFAzLxtI61/d3nAZmIcXV2N1tSWiHQo9JpacUg5RGhi9RKLd3toiCqrHw1xwAPn5
	 76ltHwOdWzM8PzEsyHFP+S55q6z8SmXyGeNtCtO+Eg99uLtg1tGoMkBIhD1C02I2Ku
	 PlP3SWI6q+zvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] perf bpf: Validate array presence before casting
 BPF prog info pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616193033.10035-9-acme@kernel.org>
References: <20260616193033.10035-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:44:16 +0000
Message-Id: <20260616194416.EC6DA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete array validation in __bpf_event__print_bpf_prog_info() =
leaves prog_tags and func_info vulnerable to raw offset dereferences.
- [High] symbol__disassemble_bpf_libbfd() completely lacks array validation=
, leading to raw offset dereferences.
--

commit 3d136fa4b35cc5388e537f4cdae3d81c00325ba1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Validate array presence before casting BPF prog info pointers

Several functions cast bpf_prog_info fields (jited_ksyms,
jited_func_lens, jited_prog_insns) from u64 to pointers and
dereference them.  These fields are only valid pointers if
bpil_offs_to_addr() converted their file offsets to addresses, which
only happens when the corresponding PERF_BPIL_* bits are set in
info_linear->arrays.

A crafted perf.data can leave these bits unset while setting non-zero
counts and offset values, causing the functions to dereference raw file
offsets as pointers.

> Add array bitmask validation to all perf.data processing paths:
>=20
>   - __bpf_event__print_bpf_prog_info(): check JITED_KSYMS and
>     JITED_FUNC_LENS (changed to take struct perf_bpil *)
>   - machine__process_bpf_event_load(): check JITED_KSYMS
>   - bpf_read(): check JITED_INSNS before memcpy from jited_prog_insns
>   - dso__disassemble_filename(): check JITED_INSNS before returning
>     jited_prog_insns pointer

[Severity: High]
This isn't a bug introduced by this patch, but since the commit message
mentions adding validation to all perf.data processing paths, are we missing
the validation in symbol__disassemble_bpf_libbfd() located in
tools/perf/util/libbfd.c?

The function symbol__disassemble_bpf_libbfd() directly casts
jited_prog_insns and jited_ksyms to pointers, and also passes info to
bpf_prog_linfo__new() which accesses line_info. Because it never checks
info_linear->arrays for the presence of PERF_BPIL_JITED_INSNS,
PERF_BPIL_JITED_KSYMS, etc., a crafted perf.data file with missing array
bits could cause the function to pass raw file offsets to the disassembler,
resulting in arbitrary memory reads and crashes when running perf annotate.

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
This isn't a bug introduced by this patch, but should this required_arrays
bitmask also include PERF_BPIL_PROG_TAGS and PERF_BPIL_FUNC_INFO?

The current bitmask omits these arrays, meaning if a crafted perf.data file
sets offsets for these fields but leaves their bits unset in the arrays
bitmask, bpil_offs_to_addr() will not convert the raw file offsets into safe
pointers.

These unvalidated offsets are then passed to synthesize_bpf_prog_name() whi=
ch
is called below:

tools/perf/util/bpf-event.c:synthesize_bpf_prog_name() {
    ...
    u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(uintptr_t)(info->prog_tags);
    ...
    name_len +=3D snprintf_hex(buf + name_len, size - name_len,
                             prog_tags[sub_id], BPF_TAG_SIZE);
    ...
}

Processing an untrusted perf.data file could trigger arbitrary memory reads=
 or
segmentation faults when the raw offset is treated as a pointer and
dereferenced.

> +	__u32 *prog_lens;
> +	__u64 *prog_addrs;
>  	char name[KSYM_NAME_LEN];
>  	struct btf *btf =3D NULL;
>  	u32 sub_prog_cnt, i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616193033.1003=
5-1-acme@kernel.org?part=3D8
