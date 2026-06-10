Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A1213E9C
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122488; cv=none; b=uKrlUBZviTVLSITPk3H9e1KrtNnqgRQdVkF6CGkGvzqX7JnQtW2fjl+ztPYdNG48xsoT5rPop48qPR0NW57rO2dew5XYFgr/VTeQnP5vveQvWPc5mzshzDtxMv1T+si//1fpRxtBUNvWEEmQ1ZUQyojkVQ9AEFsETlA1X8Y1QTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122488; c=relaxed/simple;
	bh=0wZDehZFb0A+zd/oU1s8tOED2ZYN7Ut/sCzPSzHlGv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mrgymMN9HnyPWp7PWlPS3hnvLERe1k2DmgqDn2xp21nyOOqcE9E+itfgB5FCs1ba3E1YTrUN6vUFL0wqrGP/oZsIKl591E+Qs/GNrCdtn0zoU0uyHFRcPJJ7J5Ng+TWgXovuvp2ng6qQ/XzZaHTDiloaX1N+lakWzK0kqfEMPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUh72lWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUh72lWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585911F00893;
	Wed, 10 Jun 2026 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781122487;
	bh=YlCXqj3k2TgKIUtouGREyy5Zvf+d3G6kewf/PaGA8+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZUh72lWsZRAA+hVQBeDlQ5YPSci/srzFRNMKqyg9NjSBlTl2QQFrqPBUkbt6w1i40
	 EkoOxupNHlCE927+ortuBh/tGOVr98LH3WlyAxulsCoEFEvI40HSYTmQpLT8Mr4mLn
	 Mf+0JramCJWb2kWZrnBmeZ2RDpaTykx4NrmhBVANDdB+h1gy+WZ2SXcOiUdOJtxi3X
	 3g0iNmtE7fb7gI9BL1K+XjP70SBBhKuIpGixbE685Cq2dQHXjoTyDSvm7seSzqF31R
	 UyYVP01QTA37HZXHqQKMCw52JfNt4XLPfUe9B9/vVE3v+sEXXwoyK1P9IAxxoggzjP
	 mY5CiSqkLS8hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/23] perf bpf: Add NULL check for btf__type_by_id() in
 synthesize_bpf_prog_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260610195157.2091137-20-acme@kernel.org>
References: <20260610195157.2091137-20-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 20:14:46 +0000
Message-Id: <20260610201447.585911F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unvalidated array offsets and skipped pointer translations in =
perf.data BPF payload parsing lead to arbitrary memory read vulnerabilities.
- [High] Missing bounds and array existence checks for func_infos allow out=
-of-bounds reads and segmentation faults when parsing crafted BPF program i=
nfo.
--

commit a92bfede2cc53dbfcffc14b00f211f62734591be
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Add NULL check for btf__type_by_id() in synthesize_bpf_prog_name()

synthesize_bpf_prog_name() calls btf__type_by_id() and immediately
dereferences the result via t->name_off without checking for NULL.
btf__type_by_id() returns NULL when the type_id is invalid or out
of range, so an invalid ID from untrusted input causes a NULL pointer
dereference. This patch adds a NULL check before dereferencing t.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 2c09842469f1f..fe01551dc3e6c 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -146,7 +146,8 @@ static int synthesize_bpf_prog_name(char *buf, int si=
ze,
>  	if (btf) {
>  		finfo =3D func_infos + sub_id * info->func_info_rec_size;

[Severity: High]
This is a pre-existing issue, but is there a missing bounds check on sub_id
before we calculate the finfo pointer?

In __bpf_event__print_bpf_prog_info(), this function is called in a loop
bounded by info->nr_jited_ksyms, which is passed as sub_id.  However,
func_infos is sized according to info->nr_func_info.

Since these lengths and func_info_rec_size can be attacker-controlled from =
an
untrusted perf.data file, couldn't a large nr_jited_ksyms and a small
nr_func_info cause the pointer arithmetic here to point out of bounds,
leading to a segmentation fault when accessing finfo->type_id below?

>  		t =3D btf__type_by_id(btf, finfo->type_id);

[Severity: Critical]
This isn't a bug introduced by this patch, but does the broader handling of
perf.data BPF payloads allow for arbitrary memory reads?

When parsing HEADER_BPF_PROG_INFO from an untrusted perf.data file,
process_bpf_prog_info() reads attacker-controlled lengths and fields into
info_linear->info.

The helper bpil_offs_to_addr() translates these offsets into memory pointer=
s,
but if the corresponding bit in the arrays bitmask is unset, the translation
is skipped, leaving the raw attacker-controlled 64-bit value intact:

tools/perf/util/bpf-utils.c:bpil_offs_to_addr() {
	...
	if ((info_linear->arrays & (1UL << i)) =3D=3D 0)
		continue;
	offs =3D bpf_prog_info_read_offset_u64(&info_linear->info,
					     desc->array_offset);
	addr =3D offs + ptr_to_u64(info_linear->data);
	...
}

Furthermore, even if the bit is set, it appears there is no verification th=
at
the calculated offset falls within info_linear->data_len.

When functions like synthesize_bpf_prog_name() or
__bpf_event__print_bpf_prog_info() dereference these unvalidated pointers
(like info->func_info or info->prog_tags) and print their contents, could t=
his
provide an arbitrary memory read primitive if a privileged user runs
perf report -D on an untrusted file?

> -		short_name =3D btf__name_by_offset(btf, t->name_off);
> +		if (t)
> +			short_name =3D btf__name_by_offset(btf, t->name_off);
>  	} else if (sub_id =3D=3D 0 && sub_prog_cnt =3D=3D 1) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610195157.2091=
137-1-acme@kernel.org?part=3D19
