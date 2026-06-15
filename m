Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7938BF61
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564498; cv=none; b=UkqQYE/uvqJWrAxLqY/sdPgDtuoMNDeU/C9qoy4b92la4zWwO+okv8m2W/zZ+259bZX6lmjQVI9Q88c1nd6KTqYCESvDb8pXkuh2AbvvKK2qKUt9stCCnzwhI4bDvYr5ddn6vfZZmzx/u0m5CufFywVe0Gng5NFUMvBqwCrAycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564498; c=relaxed/simple;
	bh=5t2Un0LrY8xTjXRX+YD3wki9U6Wm9gtyfasJgQqlX4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HoHc31b4XfAJv/WhzMJWbFTCaRv8et5GL2I62o8BpcfLWSA8K/DoMnlRY7P+fnTyuTWBRgM5vG0RUUBDonH0/5fLr9b3sePVDghx/0QHg+PM+dZD6Z/kqhku7gjltkw+zstaHFyg8dHLzWdIjCVVpq2s6jW6TgSRa9dacrAx2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEwTLrRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEwTLrRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486821F000E9;
	Mon, 15 Jun 2026 23:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564497;
	bh=aqCsZTWeCJ944tgV1H+05X42thujBCQN+ZFrKaEXF5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEwTLrRpE5YXUym0s0BGuMyiSY+4gj7XRoiN5ZL4oYPa1I8e43ADIrVqwVEjcBwwo
	 fsfS8Q7mj8a9tIPD+8y+vKe86eQxm/acvvj3fGwqQCkY4SB9Vp5CUoU7MEa6YkJe7i
	 zdRAE88g2RWkbjGUTRW5N9jcnzwQ8wuyG69T5IPUxLSn5EDrPUSqs54mcA1Wa8sRof
	 yseytJDqAwzJUhNZzanTV5gxS5SnJOaxkY5Z/WIJnEllB7UieO0P9tSe0kctTCVdzt
	 4dEYBjGGRdDHyMA7buW41cAYDRi8bA/s129TsM7bRU3qq03XL3GSzlMSc+31gYKY7j
	 dQsj5Nxyo1emw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] perf bpf: Validate array presence before casting
 BPF prog info pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223249.36598-9-acme@kernel.org>
References: <20260615223249.36598-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:01:36 +0000
Message-Id: <20260615230137.486821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The newly added array bitmask validation in `__bpf_event__print_bp=
f_prog_info()` is incomplete, missing critical validations for `PERF_BPIL_P=
ROG_TAGS` and `PERF_BPIL_FUNC_INFO` arrays.
- [High] The libbfd annotation path completely misses the newly added array=
 bitmask validations, allowing arbitrary file offsets for `jited_prog_insns=
`, `line_info`, and `jited_line_info` to be dereferenced.
--

commit 0cf9a385d10d4f34d342db1cd59a01ae41698542
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Validate array presence before casting BPF prog info pointers

This commit adds bitmask validations to ensure that BPF program info fields
like jited_ksyms and jited_func_lens are actually valid pointers before
they are dereferenced. It aims to prevent issues where crafted perf.data
files leave these bits unset, causing functions to dereference raw file
offsets.

>     A crafted perf.data can leave these bits unset while setting non-zero
>     counts and offset values, causing the functions to dereference raw fi=
le
>     offsets as pointers.
>    =20
>     Add array bitmask validation to all perf.data processing paths:

[Severity: High]
This is a pre-existing issue, but does the libbfd annotation path also need
similar validation?

The commit message states validations are added to all perf.data processing
paths, but symbol__disassemble_bpf_libbfd() in tools/perf/util/libbfd.c
accesses info_linear->info.jited_prog_insns and passes it to
bpf_prog_linfo__new().=20

bpf_prog_linfo__new() then casts info->line_info and info->jited_line_info
to pointers and calls memcpy():

tools/lib/bpf/bpf_prog_linfo.c:bpf_prog_linfo__new() {
    ...
    memcpy(prog_linfo->raw_linfo, (void *)(long)info->line_info, data_sz);
    ...
    memcpy(prog_linfo->raw_jited_linfo,
           (void *)(long)info->jited_line_info, data_sz);
    ...
}

Can a crafted perf.data file omitting PERF_BPIL_JITED_INSNS,
PERF_BPIL_LINE_INFO, or PERF_BPIL_JITED_LINE_INFO bits cause an
out-of-bounds read or segmentation fault here?

>       - __bpf_event__print_bpf_prog_info(): check JITED_KSYMS and
>         JITED_FUNC_LENS (changed to take struct perf_bpil *)
>       - machine__process_bpf_event_load(): check JITED_KSYMS
>       - bpf_read(): check JITED_INSNS before memcpy from jited_prog_insns
>       - dso__disassemble_filename(): check JITED_INSNS before returning
>         jited_prog_insns pointer

[ ... ]

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
This is a pre-existing issue, but is this required_arrays bitmask missing
validations for PERF_BPIL_PROG_TAGS and PERF_BPIL_FUNC_INFO?

__bpf_event__print_bpf_prog_info() calls synthesize_bpf_prog_name(), which
casts info->prog_tags and info->func_info to pointers and dereferences them:

tools/perf/util/bpf-event.c:synthesize_bpf_prog_name() {
    ...
    u8 (*prog_tags)[BPF_TAG_SIZE] =3D (void *)(uintptr_t)(info->prog_tags);
    void *func_infos =3D (void *)(uintptr_t)(info->func_info);
    ...
    name_len +=3D snprintf_hex(buf + name_len, size - name_len,
                             prog_tags[sub_id], BPF_TAG_SIZE);
    ...
}

If a crafted perf.data file leaves the PERF_BPIL_PROG_TAGS and
PERF_BPIL_FUNC_INFO bits unset but provides non-zero offset values, will=20
untranslated raw offsets be dereferenced here?

> +	__u32 *prog_lens;
> +	__u64 *prog_addrs;
>  	char name[KSYM_NAME_LEN];
>  	struct btf *btf =3D NULL;
>  	u32 sub_prog_cnt, i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223249.3659=
8-1-acme@kernel.org?part=3D8
