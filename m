Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84423988F1
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682573; cv=none; b=pl56NCIlSmRwx8ygLSRWKZDsd+vBC6HXfE+QN8IojEeE0UxwVBiCe5t0tvtDaauC32IykupoaBgk4HnDSdt11MkA/W+018OFxf37g3cWorQymyDcptqjplByGFmjtxPq1GWHiCyZPCqU9zhcRA+3lBAB5RDK9IbPdarLN0/w2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682573; c=relaxed/simple;
	bh=3sGTQlwMNTiBg3KyUqdIW/26nigh2Oqb2F0cW0tIo64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KDzDlz7tR8mzZ2bvGBt397eSRHhMHxmbdR0qOQ+AecCSBTZObHC8rVFmVUSo3p1NsikN6JXGrWlHgR66idJD8tNfYJ9krn8AH/y6mcRd88WYMxkOja2skwC+CyHcBxR/8vhFlkYHwWF/SR96gUrGmxj0+jzHPnL4PSM8UTq8tWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLmGKk+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLmGKk+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A82B1F000E9;
	Sun,  2 Aug 2026 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785682571;
	bh=Fw8vvxS2xvsjGejPGQakeMOqJadVlTTuE2SwRUJhQDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LLmGKk+IlfVtTA1KsymSeMYBtluMveyTXELqgavKmuyOkVstBiP1JNGBLEPcqCXs9
	 UnQO8mHVNneGuCWvBMC88neBbbm/W9ku7GXnrxEpOJEsQxvAdp6KOUvB0sQrAG+3d0
	 27FZrQY0Qkl6dGFnfsgb0qmYUq4QyBLnSdU8qdmtNd9le9cVJlM8SYjV9h7upIPFVx
	 a32NTBK1hJIMKM8ZzjY9kGPI87PWyhULKAjhqPoiFqjxYbtHUPlpwt+GDQz+aGcsqF
	 1X9KOrSJR7BszeyK4PtnXo9mz0WOCJYuKaY4sWoa79V1PLnfApB8ch4EpmViA00ZTY
	 IlsM90+76bJsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf bpf: Add PROG_TAGS to required arrays in
 __bpf_event__print_bpf_prog_info()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802142712.154726-4-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
 <20260802142712.154726-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 14:56:10 +0000
Message-Id: <20260802145611.4A82B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch fixes an arbitrary memory read by adding PERF_BPIL_PRO=
G_TAGS to required_arrays in __bpf_event__print_bpf_prog_info(), but fails =
to add corresponding validation for PERF_BPIL_FUNC_INFO, which is also acce=
ssed by synthesize_bpf_prog_name().
- [Medium] Missing validation for PERF_BPIL_LINE_INFO and PERF_BPIL_JITED_L=
INE_INFO before passing bpf_prog_info to bpf_prog_linfo__new().
--

--- Patch [3]: [PATCH 3/4] perf bpf: Add PROG_TAGS to required arrays in __=
bpf_event__print_bpf_prog_info() ---
commit 34f6adfee35f6522cc507083e8ec384e57659823
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_prog_i=
nfo()

This commit fixes an arbitrary memory read by ensuring PERF_BPIL_PROG_TAGS =
is
present in the required_arrays bitmask in __bpf_event__print_bpf_prog_info(=
).
If the bit is cleared, prog_tags contains a raw file offset which causes a
crash on dereference.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index fa3ebc8ea7f09..e67f28a8e92bd 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -969,7 +969,8 @@ void __bpf_event__print_bpf_prog_info(struct perf_bpi=
l *info_linear,
>  {
>  	struct bpf_prog_info *info =3D &info_linear->info;
>  	__u64 required_arrays =3D (1UL << PERF_BPIL_JITED_KSYMS) |
> -				(1UL << PERF_BPIL_JITED_FUNC_LENS);
> +				(1UL << PERF_BPIL_JITED_FUNC_LENS) |
> +				(1UL << PERF_BPIL_PROG_TAGS);

[Severity: Medium]
This is a pre-existing issue, but does required_arrays also need to include
PERF_BPIL_FUNC_INFO?

In synthesize_bpf_prog_name(), which is called later in this function, we d=
o:

tools/perf/util/bpf-event.c:synthesize_bpf_prog_name() {
    void *func_infos =3D (void *)(uintptr_t)(info->func_info);
    ...
    if (btf &&
        info->func_info_rec_size >=3D sizeof(*finfo) &&
        sub_id < info->nr_func_info) {
            finfo =3D func_infos + sub_id * info->func_info_rec_size;
            t =3D btf__type_by_id(btf, finfo->type_id);
    ...
}

If a crafted perf.data file has nr_func_info > 0 but the PERF_BPIL_FUNC_INFO
bit is cleared in the array mask, info->func_info remains an untranslated r=
aw
file offset, which could lead to an arbitrary memory read.

[Severity: Medium]
This isn't a bug introduced by this patch, but there appears to be a similar
missing validation for PERF_BPIL_LINE_INFO and PERF_BPIL_JITED_LINE_INFO
when disassembling:

tools/perf/util/libbfd.c:symbol__disassemble_bpf_libbfd() {
    if (info_linear->info.nr_line_info)
        prog_linfo =3D bpf_prog_linfo__new(&info_linear->info);
    ...
}

tools/lib/bpf/bpf_prog_linfo.c:bpf_prog_linfo__new() {
    ...
    memcpy(prog_linfo->raw_linfo, (void *)(long)info->line_info, data_sz);
    ...
}

If the structure is blindly passed without checking if PERF_BPIL_LINE_INFO =
was
set and converted, info->line_info is dereferenced as an unvalidated raw fi=
le
offset in memcpy(). Could this cause an out-of-bounds read and crash?

>  	__u32 *prog_lens;
>  	__u64 *prog_addrs;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802142712.1547=
26-1-acme@kernel.org?part=3D3
