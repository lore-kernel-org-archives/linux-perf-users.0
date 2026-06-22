Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12EB377ED7;
	Mon, 22 Jun 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125420; cv=none; b=VRCoB1XfyZ5Fkl4tPSbIdSIjlsgjI1nIDh6WbrBzfhnUen+G4ArZFxuPR1P5bjl8Z98rZM8QYOK44I8xxvv7q8DPIsI7TN+q2owuIS6v4IdUN6IoEtxeyZ2oA3Ha8IXi0i7NAZxBrj4RPteTkdpJuv0OrWYD+cV+HHmBKEv6xHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125420; c=relaxed/simple;
	bh=H8X06Phiim+aCjKErJmP0Uhgj7HAnHtKvFPNYP9ebLM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aUmQW7zNs/nBIOdPJ/ejzturttjutwI6pkpkEh1QEQ4OywEwamRwEYGCM55zs4GzSaayBr3zm1Ecfy907ljVrBhvKCrOlMQY08Bfg60PHy2Ktn+wcCZbB1pvXugz0LjH/SrOaKiPcutiF8Kbll6Dp2eebTe5ToVAHargaVbUbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLhvxVdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLhvxVdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5244C1F000E9;
	Mon, 22 Jun 2026 10:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125419;
	bh=HQJiszT1tHQGIQuQnntE3/aHyY+hEliajFsrxSTAP/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLhvxVdJzz6QliRuAtHLS2fjLa8CaPdF+iF12xuITPyaLbQwUDKjpm0C54IGz72w6
	 NoCTNOMoeWM2ZD2N5Zlh+83zBhKO7K/y56n5HRQM/vMWTSeqE787sRhzs809zdn0f4
	 WieNUkrE5mxB4/gtt+eC7ILXz9OpjG/ihdqbjhqmvd1mP/WQUgUmsGXxoK4m6RghsT
	 f4bvuVvcs7pB3Mqv85TUL6ys/lW1/T4/+501E//keUHB9uDUkqu+Tm/ca6ID23WN2v
	 u7NEXp0juYGeNp7mrbLY7W16UDeAv7S7cwEaO5H1mAg+T1lqHgJO1716AFn+vg3Q6A
	 lsWr9tM8phMiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf] perf: Fix btf_vlen() signedness errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260622103418.579115-1-alan.maguire@oracle.com>
References: <20260622103418.579115-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:50:18 +0000
Message-Id: <20260622105019.5244C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Silent truncation of BTF_INFO_VLEN in libbpf's btf_vlen()
--

commit c28608c8a13cb7af8bf42f5aaadf102bb452fc40
Author: Alan Maguire <alan.maguire@oracle.com>

perf: Fix btf_vlen() signedness errors

This commit updates perf to use unsigned int loop counters when
iterating up to btf_vlen(). This avoids signedness errors after commit
f7a6b9eaff3e6 extended the BTF UAPI vlen to use previously unused bits.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 48615ddccd93a..9903d79c4b77a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -964,7 +964,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, s=
ize_t size, struct syscall_
>  	struct btf *btf =3D arg->trace->btf;
>  	struct btf_enum *be =3D btf_enum(bt);
> =20
> -	for (int i =3D 0; i < btf_vlen(bt); ++i, ++be) {
> +	for (unsigned int i =3D 0; i < btf_vlen(bt); ++i, ++be) {

[Severity: Medium]
This is a pre-existing issue, but does the btf_vlen function still silently
truncate the newly extended length?

Looking at tools/lib/bpf/btf.h, it appears to be defined as:

static inline __u16 btf_vlen(const struct btf_type *t)
{
        return BTF_INFO_VLEN(t->info);
}

Since commit f7a6b9eaff3e6 extended the internal BTF_INFO_VLEN from 16 to
24 bits to support more than 65535 elements, won't returning __u16 here
truncate the upper 8 bits?

While updating the loop variables to unsigned int fixes the signedness
warnings in consumers, does the underlying library still need an update to
return __u32 and prevent truncation?

>  		const char *name =3D btf__name_by_offset(btf, be->name_off);
>  		int max_len =3D max(size, strlen(name));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622103418.5791=
15-1-alan.maguire@oracle.com?part=3D1
