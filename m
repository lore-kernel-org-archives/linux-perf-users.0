Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E645BD57
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625820; cv=none; b=IimVLFA6NgIT1T+lzflIpvJ8TbsWHtUrnW97QmT4LbtBQIky1rOiENyCZwr6luAM1BZs6Cdp51LPbl5SBVuIYKqE1ROVfYip2pK98z5tjYwIU68SZpgKjsjwZCofDxj1ektdy1nb/JNgoG+T5xzctM62QSNn490fAuMoaRZk49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625820; c=relaxed/simple;
	bh=Xiv7sokzBCawQC2AMaMMHGYqqbrZ/6KLAq28HZTR1hw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nsro4AZ9cPI7bOIl6YuHy129NdYJoUC7AlBDk+fP38DFx2bVUimwGnSRfXvUbccYKnQ6ksXo26wf1ylzZFE7fvb/9d3AqKh2O6aqwuDQeCnA2RUNv7MeyAAr1dcpNVEDJjQVQ5w0o/mkMUyBc9+Eb2lwfKReray6Hu1SS+WLxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqDSKkcD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqDSKkcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFF1F00A3A;
	Tue, 16 Jun 2026 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625818;
	bh=LbweZTS/RuCc+Qe7hvGT2QPQs1cT3PBmDDs6WtYkpHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqDSKkcDc1cpCqJxpXOb+wK0iVMd7EXdxo0S3hhy1v0K8CrSaKwofTNt+n7bZROU1
	 lLw2jHjAOqFRp2dVDSuYO7NkgNMKWuJGFkCQAFsG5Ax02N7lmM+61/iFXxDfxnNYMS
	 2WkdOBF/OObjUbrdKmqM33QJJcNNEAB5DZ3bNZInW8OZI69kHCMTLDi+Pxfj+0pL8A
	 VWZNU6r60/YSfuW03nOg4lYpKPZmMRBVqFh/qfaL2IJBQRr48fRd3lgoWwg1eo2wAW
	 ecrOlr4V6JiNxnsFPbvrqXOvJuyB2anli09SjqVJSQngM9zLm8xprbzmVM+908tH+F
	 nNLKaGppN+9dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] perf bpf: Validate array presence before casting
 BPF prog info pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616153920.6852-9-acme@kernel.org>
References: <20260616153920.6852-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:03:38 +0000
Message-Id: <20260616160338.B5DFF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditional bitmask validation in `__bpf_event__print_bpf_prog=
_info` silently drops BPF program info for programs without subprograms (e.=
g., non-JITed or non-BTF programs).

Pre-existing issues:
- [High] Incomplete validation of BPF prog info array bitmasks allows arbit=
rary pointer dereferences via crafted `perf.data` files.
--

commit c8a78c4f19f095efa7672153271eb294c216288b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf bpf: Validate array presence before casting BPF prog info pointers

Several functions cast bpf_prog_info fields (jited_ksyms,
jited_func_lens, jited_prog_insns) from u64 to pointers and
dereference them. These fields are only valid pointers if
bpil_offs_to_addr() converted their file offsets to addresses.

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
This isn't a bug introduced by this patch, but does this incomplete bitmask
validation allow arbitrary pointer dereferences via crafted perf.data files?

The required_arrays bitmask enforces PERF_BPIL_JITED_KSYMS and
PERF_BPIL_JITED_FUNC_LENS but omits PERF_BPIL_PROG_TAGS and
PERF_BPIL_FUNC_INFO.

Later in this function, synthesize_bpf_prog_name() is called, which blindly
casts and dereferences info->prog_tags and info->func_info without checking
if their array presence bits were set.

Additionally, symbol__disassemble_bpf_libbfd() in tools/perf/util/libbfd.c
lacks any array bitmask validation and blindly casts and dereferences
jited_prog_insns and jited_ksyms. A crafted perf.data file can provide
these fields as raw file offsets while unsetting their corresponding bits,
bypassing the bpil_offs_to_addr() conversion and leading to segmentation
faults.

> +	__u32 *prog_lens;
> +	__u64 *prog_addrs;
>  	char name[KSYM_NAME_LEN];
>  	struct btf *btf =3D NULL;
>  	u32 sub_prog_cnt, i;
> @@ -974,6 +981,13 @@ void __bpf_event__print_bpf_prog_info(struct bpf_pro=
g_info *info,
>  	    sub_prog_cnt !=3D info->nr_jited_func_lens)
>  		return;
> =20
> +	/* Ensure the arrays were present and converted by bpil_offs_to_addr() =
*/
> +	if ((info_linear->arrays & required_arrays) !=3D required_arrays)
> +		return;

[Severity: Medium]
Will this unconditional check silently drop BPF program info for programs
without subprograms?

The function bpil_offs_to_addr() has an edge case where it clears an array's
presence bit if its count is 0 and it is placed at the end of the data buff=
er
(offset equals data_len).

Valid BPF programs that legitimately have nr_jited_ksyms =3D=3D 0 and
nr_jited_func_lens =3D=3D 0 (such as non-JITed programs) will have these bi=
ts
unset. The new validation check will unconditionally fail here, causing
perf report --header to silently omit their basic program info.

Should this check only be enforced when sub_prog_cnt > 0?

> +
> +	prog_lens =3D (__u32 *)(uintptr_t)(info->jited_func_lens);
> +	prog_addrs =3D (__u64 *)(uintptr_t)(info->jited_ksyms);
> +
>  	if (info->btf_id) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616153920.6852=
-1-acme@kernel.org?part=3D8
