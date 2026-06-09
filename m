Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC902BEFE8
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982646; cv=none; b=q5u799hT2uhXyA6AwZw0XjG31mTpYsqCjPc/K5sBbsD//2tFlz8QgaBacp2dwS5tmPky7AK3oNfeSmcKHIjnrHDjz6LtC89xcllEDWqaKK+oo51jW02lTCpACzghb/HLdUKbeUjCgbe9CA0/8DjTytnmQOTaglHhKjtLyVATuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982646; c=relaxed/simple;
	bh=TbgXB/q3d/IRmO4Et2zei2G/my+yLR3D03QwnbpXZa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tlxf6AYAxxev1/Fbjs4cQASsorGVM3BPAhkVUdfT8hgL97JLK74AmezmCPt2tk8FmLLqrOpBPY8HMuZIeRl0UPDBRpXIRRYzc98HwWZQINirV/8GHr1ULQn6/6PHQ1eiXr8qnuLqEWLv3/PEdt+cHq30uCsOiTZGNHbHriuEx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZgcohJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZgcohJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A50C1F00898;
	Tue,  9 Jun 2026 05:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780982645;
	bh=hMNO9K8KftRTrgQ9ndKH5yvndQuk8K9WjWf5kJyFe04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NZgcohJUe75K8OBQ4yT2ADDrICtKMYU8F1NWfQYebd4CgMWJTMlfmQbKMPGRs0QV6
	 n9t9c0h5iIVyBz5aodN6bTKaVxTBSPKIgMLw5sgMyEjbfEtuL5Nk1Ol9Of/hsbo2r9
	 qK1aJKHV/qPyY05uFXtcEHJBtmIa6rSLLTI8ROrUASrVl3QOMHGs3Ek1Ec1hJIEd+q
	 c4umsrgDmhqG2lOvUg/P4MxK6ugUnUhQJSl/A52pl8QC5sg5z0Xb6tjTl9IYVzs4lk
	 WH0z94JZzFSSWVcRkOsiImudt6v6aDLXA8w/IZrKXImb/mTLxFU8eJsbAmd5uWzTuV
	 uvaGeKrqm3g/w==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 4/9] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609050222.2458129-5-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 05:24:04 +0000
Message-Id: <20260609052405.4A50C1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The fallback to software branch decoding causes massive NMI overhe=
ad and drops valid LBR entries when user memory is paged out.

Pre-existing issues:
- [Critical] Page fault in NMI context due to an out-of-bounds direct memor=
y read into unmapped guard pages during LBR software branch type decoding.
--

commit 11f8cb2dc702b7450f8fbb74de9eaa30a63a9248
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: perf/x86/intel: Fallback to sw branch type decoding if no hw decod=
ing

This commit updates intel_pmu_lbr_filter() to use software branch-type
decoding when hardware branch-type decoding is unavailable (i.e.
x86_lbr_type is not enabled). This aims to keep branch classification and
filtering behavior correct across Arch LBR configurations.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index cae2e02fe6cc4..171fdf1962ade 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1233,6 +1233,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		 * OTHER_BRANCH branch type still rely on software decoding.
>  		 */
>  		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> +		    static_branch_likely(&x86_lbr_type) &&

[Severity: High]
When x86_lbr_type is not enabled, this falls back to software decoding via
branch_type(). Because intel_pmu_setup_hw_lbr_filter() unconditionally sets
X86_BR_TYPE_SAVE for Arch LBR CPUs:

arch/x86/events/intel/lbr.c:intel_pmu_setup_hw_lbr_filter() {
    ...
    if (static_cpu_has(X86_FEATURE_ARCH_LBR)) {
        ...
        reg->reg |=3D X86_BR_TYPE_SAVE;
    ...
}

the early return fast-path in intel_pmu_lbr_filter() is bypassed. Does this
cause intel_pmu_lbr_filter() to iterate over all LBR entries and perform
high-overhead instruction decoding in NMI context even for generic branch
requests?

Additionally, if user memory is paged out, copy_from_user_nmi() will fail,
causing branch_type() to return X86_BR_NONE. Does this result in valid LBR
entries being silently dropped?

[Severity: Critical]
This is a pre-existing issue, but falling back to software decoding exposes
a vulnerability in get_branch_type() when processing LBR entries in NMI con=
text:

arch/x86/events/utils.c:get_branch_type() {
    ...
    if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
        addr =3D (void *)from;
        bytes_read =3D MAX_INSN_SIZE;
    ...
    insn_init(&insn, addr, bytes_read, is64);
    ret =3D decode_branch_type(&insn);
    ...
}

If the from address (which is controlled by the LBR hardware recording a
faulting RIP) points to the very last byte of a mapped page, bytes_read is
set to 15. The instruction decoder will blindly read past the page boundary
into an unmapped guard page without exception table handlers.

Can this trigger a kernel page fault (#PF) and Oops in NMI context when
processing the PMU interrupt?

>  		    type <=3D ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>  			to_plm =3D kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>  			type =3D arch_lbr_br_type_map[type] | to_plm;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609050222.2458=
129-1-dapeng1.mi@linux.intel.com?part=3D4
