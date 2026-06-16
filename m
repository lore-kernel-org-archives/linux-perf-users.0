Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AA282F1A
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584770; cv=none; b=Sh4ZXzCopjtefoeG7hRtWdahAw5qpIdxkcB4mw7KSmdzmbrvixKBrbHVbs+0RxeLRaTrV5BgVuzmDKgNvzFTGhU3lDhhwZP/6DT4tdVnsYAweL9DyiBEWa4FiAl4fE44FT8inOWe4zZRC84cEOh46qjYDGVcZynR44uRdpCSsC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584770; c=relaxed/simple;
	bh=2ThmJs98Rp+IwcZPha/S9OW0wHAWciniB2Rlvxzb2kg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HFHqr73UhW8wZVKpdWmlYqw3bSZBCilOBNPBST6SknkjfCCYsQSdZH83d85bqaXYZE1DzTpHW9EW6uf9DuqaR7baBSrL75cRYie2FGJ+3qQWGSAf7z3m2Dn3xO5zYo7rx48HPy2OyKCgQ/voGPYQ9E0dDc4UiimLnYKY8Kri7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sgsc4lrU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sgsc4lrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E57B1F000E9;
	Tue, 16 Jun 2026 04:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781584769;
	bh=+WGNbMZ1+aiNPOR5jEH2ckklf6wkw3hfsRAK6eaFk0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sgsc4lrU8AOTqLWOa1E9J31Fn00NNJPDckHkd8DgayNlbNCSkyARWIQC2LHlTaPad
	 Sl8jw9bHz2kmmtixH3AaZcFt2tBAZ8w6MyX9jmcM98C/4qtnLqIPPnQMsbKSYOVENu
	 ldx/+9D8eZEeEp7HProIqJ+jeWDRF7WaWUjBVt+ZHqOJeD1I0WJSYTK5D0oM79Q5N3
	 xxJ4LYr6GUabudhGN2L6OMHFSxiOLDEAfOL3Ct5uDeXQZAq/5uPKGoC/7WVh2NbEoj
	 sH+8GY+zRmQJIeztYFG0CLoon9hFXfP1I/We2+gkVZAN7l1P1J0JrZJUq4TDAjc9uM
	 sjV+hbe7FYNUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] perf bpf: Validate array presence before casting
 BPF prog info pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616022715.5739-9-acme@kernel.org>
References: <20260616022715.5739-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 04:39:28 +0000
Message-Id: <20260616043929.2E57B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds array bitmask validation for `JITED_KSYMS` and `JIT=
ED_FUNC_LENS` in `__bpf_event__print_bpf_prog_info()`, but fails to include=
 `PROG_TAGS` and `FUNC_INFO`. This leaves the function vulnerable to arbitr=
ary pointer dereferences when calling `synthesize_bpf_prog_name()`.
- [High] The patch completely misses adding array bitmask validations to `s=
ymbol__disassemble_bpf_libbfd()` in `libbfd.c`, leaving it vulnerable to un=
converted pointer dereferences.
--

commit 07052c4321d3973c606cfca5a84ae676ff46cd05
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Validate array presence before casting BPF prog info pointers

This patch adds array bitmask validation to several perf.data processing pa=
ths
to ensure that bpf_prog_info file offsets are properly converted to valid
pointers before being dereferenced.

> Add array bitmask validation to all perf.data processing paths:
>=20
>   - __bpf_event__print_bpf_prog_info(): check JITED_KSYMS and
>     JITED_FUNC_LENS (changed to take struct perf_bpil *)
>   - machine__process_bpf_event_load(): check JITED_KSYMS
>   - bpf_read(): check JITED_INSNS before memcpy from jited_prog_insns
>   - dso__disassemble_filename(): check JITED_INSNS before returning
>     jited_prog_insns pointer

[Severity: High]
This isn't a bug introduced by this patch, but does this miss the
processing path in symbol__disassemble_bpf_libbfd() in
tools/perf/util/libbfd.c?

Looking at symbol__disassemble_bpf_libbfd(), it also casts and
dereferences jited_prog_insns and jited_ksyms without verifying their
corresponding PERF_BPIL_ bits are set:

tools/perf/util/libbfd.c:symbol__disassemble_bpf_libbfd() {
    ...
    info.buffer =3D (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
    ...
    addr =3D pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_i=
d];
    ...
}

Can a crafted perf.data missing these arrays still cause arbitrary memory
reads or segmentation faults during offline disassembly via perf annotate?

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
This is a pre-existing issue, but does this bitmask also need to include
PERF_BPIL_PROG_TAGS and PERF_BPIL_FUNC_INFO?

Later in this function, synthesize_bpf_prog_name() is called, which accesses
info->prog_tags without checking if it was converted from a file offset:

tools/perf/util/bpf-event.c:synthesize_bpf_prog_name() {
    ...
    name_len +=3D snprintf_hex(buf + name_len, size - name_len,
                             prog_tags[sub_id], BPF_TAG_SIZE);
    ...
}

If a crafted perf.data omits PERF_BPIL_PROG_TAGS from the arrays bitmask
but provides matching counts (e.g., nr_prog_tags =3D=3D nr_jited_ksyms),
could this dereference unconverted file offsets and cause a crash
during perf report?

>  	char name[KSYM_NAME_LEN];
>  	struct btf *btf =3D NULL;
>  	u32 sub_prog_cnt, i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022715.5739=
-1-acme@kernel.org?part=3D8
