Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715425A2A2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225562; cv=none; b=rVblxJq9Ejq0ozW7E9upsc+cFnZbM9wEPrGCjyBItFDnIR6d3rFqLQBGrwCkED96E1FXUK/G1bhiJdCDqvPrql2nqBhChs01Gf2jqdvScPusqwy5VovzqxOyyVASltyW7tAEnyo8KmCghVj96puwLg85OcPHfFzL4tCgf4X0X6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225562; c=relaxed/simple;
	bh=RNvj4zgQbI1XVuwYdP348ThRZHbGCAwQ3EJHjTwwdhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=slUnUctaXYhlHQ6mQFCKu+1tEICi/b92Ie0nUTyQoKG8XJPv9SdqmI+DnVBAq6Lt1q6kuaZqbeF4ipEUXuFVVmV+wxm7dqEniUiHMCRstYSxpf/WO2g7sGzqI47pAdtCxkxj95ipOLpmzDaJlqRTUdgMvBKqK/yhOoO9BKcbOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXSHAQBk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXSHAQBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68B31F000E9;
	Fri, 12 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781225561;
	bh=Cj4RKcf+PQSs5i0tBnT/P90sE1u5zJDSsEMEGZMeb9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXSHAQBkXkpa2ZMqChGVOdjAssk5VJ5eADQ60zKPVd8Mn/bzULafxzGIbsq54dXxk
	 EOwbt8kmGDQ17EDKsCeTYm9e2MilMLipR+cfq3JUuKJF5QdCcYJho4Lp+mOreQOQlv
	 enaIMsMsHW364fAiJ85jCfl4/oqxrAW3R8XXV/21NKcl+4R5kjeknUkJp+LbFBbOPi
	 dLtigi/FZGhWDdh6WSvYnRgzH0gtw/HzzsOgAq3h9KhBAmh/J5daYJwn7N8Hrdwwmn
	 yrlyFlcdBeF2JmTYRpyXRwJroKuX9W2Dc6kxotyCKv25xBKyfdBGPrkyfREB1p5OFs
	 EaYzYhgn04nkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/15] perf bpf: Validate func_info_rec_size and sub_id
 in synthesize_bpf_prog_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-11-acme@kernel.org>
References: <20260612003444.50723-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:52:40 +0000
Message-Id: <20260612005240.C68B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Arbitrary memory read due to unvalidated array offsets in `bpil_=
offs_to_addr()` when array bits are unset
--

commit a163a7a43ee7ff41ce65cced45401ef40028fc1f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Validate func_info_rec_size and sub_id in synthesize_bpf_prog_nam=
e()

synthesize_bpf_prog_name() computes a pointer into the func_info array
using sub_id * info->func_info_rec_size without validating either value.
Both come from perf.data and are untrusted, so bounds checks are added
before computing the pointer offset.

> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index c4594969d7677..fe6fbca508c51 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -143,7 +143,9 @@ static int synthesize_bpf_prog_name(char *buf, int si=
ze,
>  	name_len =3D scnprintf(buf, size, "bpf_prog_");
>  	name_len +=3D snprintf_hex(buf + name_len, size - name_len,
>  				 prog_tags[sub_id], BPF_TAG_SIZE);

[Severity: Medium]
This is a pre-existing issue, but does casting info->prog_tags to a pointer
and dereferencing it here allow an arbitrary memory read if a malicious
perf.data is provided?

If an attacker clears the array bit in info_linear->arrays,
bpil_offs_to_addr() will silently skip converting or validating the offset:

tools/perf/util/bpf-utils.c:bpil_offs_to_addr() {
    ...
    if ((info_linear->arrays & (1UL << i)) =3D=3D 0)
        continue;
    ...
}

This leaves the raw, untrusted 64-bit value from the file intact in
info->prog_tags.

> -	if (btf) {
> +	if (btf &&
> +	    info->func_info_rec_size >=3D sizeof(*finfo) &&
> +	    sub_id < info->nr_func_info) {

[Severity: Medium]
This is a pre-existing issue, but does info->func_info face the same
arbitrary memory read vulnerability?

The func_infos pointer is assigned from info->func_info earlier in
synthesize_bpf_prog_name(). If its array bit is cleared in
info_linear->arrays, it retains the untrusted value.

Since info->nr_func_info is also fully attacker-controlled in this
scenario, could an attacker bypass this bounds check and read from
an arbitrary address?

Similar unvalidated pointer accesses appear to happen in
__bpf_event__print_bpf_prog_info() when it casts info->jited_func_lens
and info->jited_ksyms to pointers.

>  		finfo =3D func_infos + sub_id * info->func_info_rec_size;
>  		t =3D btf__type_by_id(btf, finfo->type_id);
>  		if (t)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D10
