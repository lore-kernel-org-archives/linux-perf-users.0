Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799026B764
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170123; cv=none; b=tS7oMLbO4B2qVluEupmc/iesfELzZBd2x8VQ1qSAfxZH4GF0bTvNdoHLz1qxn8SC8sRSqXqWSCd4V08PTuf3fo/hPcU1yngruondGX3/jq4yaoJquO61A+YFatr5K0CjhGqTguo3HXcYMailsS8ztsDPxMqHWk0ju2hzx5KGm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170123; c=relaxed/simple;
	bh=Z6ePAo298cTff92T7EcbwYcvcpwrGO7w9AqJDLSUkXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BkNUsvJ1B27EblT2HbXPP8EsXqHGTfit2lTbjxzmMmd6hWFeEu1aH6+2jJUY1A3g6on1QWUCyJP0Uq8z5Fi3PAKus9vujVZwO+N9fJyDo86v9WH/M2gmuXYyK/wSIDsUv1XvD56C7Xu9Wn7y58N+Rmpj+EZaQXsPguIa9uv+GE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW+7pQCW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW+7pQCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A311F000E9;
	Mon, 27 Jul 2026 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785170121;
	bh=IEqaOR8PxwfxK9Bg2BRLv93ZVdwbbrETldxziQMJXu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RW+7pQCWSStjnafUcFDeYNgfBppt0P7JZ2taq0ND2ZFG60TNAnM98N/96xyJlaZXr
	 ydfKohWrcrrRyQ+n2LNOSh1W6gU+lr79odAcRUbfUQTcFG+Vn/nmroFtSg80BkSeOW
	 IIppVj/kCSlucZtXWitrnNZpfwBU7ptghPBfOWH8Nb4d6dg6I8LCTNCpMqK2ID/kWU
	 g8fCVmbZbCsDzwTLrMUhX49LHfBFagwNBJ1B0d3jkSJhB6qhUUlljagca3p4Gd3f60
	 83dPOUl9yhAHvEiEtua8K41BWJ7ZXXTCZO03RmJLmTMh1+F01YmARqWokXZHKjrl2M
	 HEffhj9p0zSsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf intel-pt: Fix off-by-one in auxtrace_info
 minimum size check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260727161705.64807-4-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:35:21 +0000
Message-Id: <20260727163521.A8A311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing or off-by-one boundary checks in sibling auxtrace info pro=
cessors lead to out-of-bounds reads.
- [High] Integer overflow when calculating the filter string length causes =
a 0-byte allocation and subsequent heap out-of-bounds read.
- [Medium] The function passes the raw, potentially endian-scrambled `filte=
r` pointer to `addr_filters__parse_bare_filter()` instead of the corrected =
`pt->filter` buffer.
- [Medium] Missing cleanup for `pt->vmcs_info` and `pt->br_stack` on the er=
ror paths in `intel_pt_process_auxtrace_info`.
--

--- Patch [3]: [PATCH 3/5] perf intel-pt: Fix off-by-one in auxtrace_info m=
inimum size check ---
commit d7842efbb6c00a1eec2b67aee65980fda65e6112
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf intel-pt: Fix off-by-one in auxtrace_info minimum size check

This commit fixes an off-by-one error in the intel_pt_process_auxtrace_info
minimum size check by ensuring the array is large enough to access the
INTEL_PT_PER_CPU_MMAPS element. A crafted perf.data file with exactly min_sz
bytes could previously pass the check and trigger an out-of-bounds read.

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 56a9e439f5f8f..806cd173a0067 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -4430,7 +4430,7 @@ int intel_pt_process_auxtrace_info(union perf_event=
 *event,
>  				   struct perf_session *session)
>  {
>  	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
> -	size_t min_sz =3D sizeof(u64) * INTEL_PT_PER_CPU_MMAPS;
> +	size_t min_sz =3D sizeof(u64) * (INTEL_PT_PER_CPU_MMAPS + 1);

[Severity: High]
This isn't a bug introduced by this patch, but does this same vulnerability=
=20
exist in other auxtrace info processors?

In tools/perf/util/intel-bts.c:intel_bts_process_auxtrace_info(), is min_sz=
=20
undersized by calculating with INTEL_BTS_SNAPSHOT_MODE instead of=20
(INTEL_BTS_SNAPSHOT_MODE + 1)?

In tools/perf/util/powerpc-vpadtl.c:powerpc_vpadtl_process_auxtrace_info(),=
=20
POWERPC_VPADTL_TYPE is 0, which makes min_sz =3D 0, but the code later read=
s=20
index 0. Could this cause an out-of-bounds read on minimally sized payloads?

In tools/perf/util/arm-spe.c:arm_spe__alloc_metadata(), the v2 metadata pat=
h=20
unconditionally accesses index 3, even though min_sz is only enforced to be=
 16=20
bytes (2 elements). Are we risking an out-of-bounds read here?

In tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full(), the code =
reads=20
index 1 (CS_PMU_TYPE_CPUS) to calculate bounds before validating that the=20
event's priv_size is large enough to contain the global header. Is this saf=
e?


[Severity: High]
This is a pre-existing issue, but further down in=20
intel_pt_process_auxtrace_info(), could an integer overflow lead to a 0-byt=
e=20
allocation and out-of-bounds read?

When calculating the filter string length from user-controlled event data:

    len =3D auxtrace_info->priv[INTEL_PT_FILTER_STR_LEN];
    ...
    if (len) {
        ...
        len =3D roundup(len + 1, 8);
        info +=3D len >> 3;
        if ((void *)info > info_end) {

If a crafted perf.data file sets len to SIZE_MAX, would roundup(len + 1, 8)=
=20
overflow to 0?

This would prevent info from advancing, bypassing the info > info_end point=
er=20
validation.=20

Then memdup(filter, len) would allocate 0 bytes, and the subsequent check:

    if (pt->filter[len - 1]) {

would read pt->filter[SIZE_MAX] (offset -1), causing an out-of-bounds read =
into=20
the heap chunk's header.


[Severity: Medium]
This is a pre-existing issue, but in the same block handling the filter str=
ing,=20
are we passing the wrong buffer to addr_filters__parse_bare_filter()?

If session->header.needs_swap is true, the priv array payload is endian-swa=
pped,=20
which scrambles string characters and relocates the null terminator.=20

The code copies the string and un-swaps it:

    pt->filter =3D memdup(filter, len);
    ...
    if (session->header.needs_swap)
        mem_bswap_64(pt->filter, len);

However, it then passes the raw, un-swapped filter variable instead of the=
=20
corrected pt->filter buffer:

    err =3D addr_filters__parse_bare_filter(&pt->filts, filter);

Since the scrambled filter string might not contain a null terminator where=
=20
expected, could the parsing function read out-of-bounds until it finds a ra=
ndom=20
null byte?


[Severity: Medium]
This isn't a bug introduced by this patch, but are there missing cleanups o=
n the=20
error paths in intel_pt_process_auxtrace_info()?

If initialization fails and the code jumps to the error labels:

    err_delete_thread:
        thread__zput(pt->unknown_thread);
    err_free_queues:
        intel_pt_log_disable();
        auxtrace_queues__free(&pt->queues);

It appears the RB tree pt->vmcs_info (allocated via=20
intel_pt_parse_vm_tm_corr_args()) and pt->br_stack (allocated dynamically=20
inside intel_pt_synth_events()) are not freed.

Unlike the successful teardown path (intel_pt_free()), these error paths la=
ck=20
calls to intel_pt_free_vmcs_info(pt) and zfree(&pt->br_stack). Will this re=
sult=20
in a memory leak?

>  	struct intel_pt *pt;
>  	void *info_end;
>  	__u64 *info;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727161705.6480=
7-1-acme@kernel.org?part=3D3
