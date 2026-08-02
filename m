Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EA331ED6
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Aug 2026 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682481; cv=none; b=X2vN/UGKeuSX4tAUi1AHfwAgb/miKDjEZmRibbA9UQRd06qa0Zun11bX3SN2ES181Qbz59oONC8z/bsP9o0s/X3Z9nDx2Ta8/Gb7RZLYQ1uYYyOpy0voaGV37SEpi25PQ8Q6nabAdxUqGNX94OIpTGBYVRHtkfZS3xktJri3kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682481; c=relaxed/simple;
	bh=lMrZkPOvTnhWxr7qx3BvGbwCcO/K2wroSiw18Iyhk54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AFJn6mi7EDOArJB24e6cAnmFmJau+lUForN6A4RlGopN2p7/280wllmAQdHpcR+AQncyZWdpEHXjrmCQNpp5Qiydf++MUxgOIJ/W2bJUsA0Vrkctc6I57WpemDQaPZ/80jWqGFtBd/8O2DgnSJBKY2VQhdfDzQoW3vVnNitK2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag/R8Atl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag/R8Atl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3536B1F000E9;
	Sun,  2 Aug 2026 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785682480;
	bh=5MpuCvJvgFSeaRkhMvqi7RppCF2z7bUrUTYLIKulF2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ag/R8AtlkLKvKhqYP4KmckU7XJagl/ASWNLxUQM3rN8KOjEGTd7C2eFfDaoYQ/49J
	 rUgLjbScX+iHQ0b11PQY2qKeBGlgUI+vDLN+QaJTE1WIq/LZ4UyPAkYKjbHhxw6CX4
	 KehWooS9KUr2fzpxBDXB64ew3RSLEKTPoe2byQz6RJBVUj+mF4yiB06aST1i/3+5jS
	 iVaiHM8yrSVr1zojyH3rbVVfffU0BOpIwbRKFdbmYcWA7+ElJ9AV+ytEa0hQ6NqYgq
	 +4iU+O5BY3uQVUroqOXPqcsj4oO6OW7PaXhqP8dtOvreLcqhDZqjMJvE0+nAu0+Mqx
	 AFAZ4ynJ0q3Ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf libbfd: Validate BPF prog info arrays before
 pointer cast
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260802142712.154726-2-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
 <20260802142712.154726-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 14:54:39 +0000
Message-Id: <20260802145440.3536B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bitmask validation for several PERF_BPIL_* flags before ca=
lling bpf_prog_linfo__new(), leading to raw file offset dereferences.
- [High] Missing bitmask validation for PERF_BPIL_PROG_TAGS and PERF_BPIL_F=
UNC_INFO in bpf-event.c call sites.
--

--- Patch [1]: [PATCH 1/4] perf libbfd: Validate BPF prog info arrays befor=
e pointer cast ---
commit 91de4e21d8f65551a65e6afd999ee44cac7b52f7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf libbfd: Validate BPF prog info arrays before pointer cast

This commit adds bitmask checks for PERF_BPIL_JITED_INSNS and
PERF_BPIL_JITED_KSYMS in libbfd.c before casting them to pointers. This
prevents raw file offsets from being dereferenced when processing a crafted
perf.data file.

> perf libbfd: Validate BPF prog info arrays before pointer cast
>
> symbol__disassemble_bpf_libbfd() casts info_linear->info.jited_prog_insns
> and info_linear->info.jited_ksyms to pointers without checking whether
> bpil_offs_to_addr() actually converted the file offsets.  A crafted
> perf.data with PERF_BPIL_* bits unset but non-zero counts causes raw
> file offsets to be dereferenced as pointers.
>
> Add bitmask checks for PERF_BPIL_JITED_INSNS and PERF_BPIL_JITED_KSYMS
> before the casts, matching the validation added to bpf-event.c call
> sites.

[Severity: High]
This is a pre-existing issue, but is the validation in the bpf-event.c call
sites complete?

In tools/perf/util/bpf-event.c:__bpf_event__print_bpf_prog_info(), the
required_arrays bitmask fails to include PERF_BPIL_PROG_TAGS and
PERF_BPIL_FUNC_INFO.

It then proceeds to call synthesize_bpf_prog_name(), which dereferences
info->prog_tags without checking if they were converted:

tools/perf/util/bpf-event.c:synthesize_bpf_prog_name() {
    ...
    name_len +=3D snprintf_hex(buf + name_len, size - name_len,
                             prog_tags[sub_id], BPF_TAG_SIZE);
    ...
}

Could a crafted perf.data file provide non-zero counts but omit the
corresponding bits in the array mask, leaving them as unconverted raw
file offsets?

> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index c1c12308cc12f..d6c2d9807fc9c 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c

[ ... ]

> @@ -581,6 +586,12 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sy=
m __maybe_unused,
>  	if (disassemble =3D=3D NULL)
>  		abort();
> =20
> +	/* jited_ksyms is only valid if bpil_offs_to_addr() converted it */
> +	if (!(info_linear->arrays & (1UL << PERF_BPIL_JITED_KSYMS))) {
> +		ret =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> +		goto out;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but does calling bpf_prog_linfo__new() earlier
in this function before validating the PERF_BPIL_JITED_KSYMS bitmask risk
dereferencing raw file offsets?

Because bpf_prog_linfo__new() relies on jited_ksyms internally, putting the
validation for PERF_BPIL_JITED_KSYMS here means the validation happens after
the structure has already been accessed:

tools/lib/bpf/bpf_prog_linfo.c:dissect_jited_func() {
    ...
    if (ksym_func[0] !=3D *jited_linfo)
    ...
}

It also seems that bpf_prog_linfo__new() uses info->line_info, which doesn't
have a PERF_BPIL_LINE_INFO check before the call.

Should the validation for PERF_BPIL_JITED_KSYMS (and other arrays like
line_info) be moved earlier, before info_linear->info is passed to
bpf_prog_linfo__new()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802142712.1547=
26-1-acme@kernel.org?part=3D1
