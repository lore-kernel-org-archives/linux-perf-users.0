Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB95320393
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256103; cv=none; b=K4k/5mSFODalQI7ox7Q62brC5FuY6c6A/enpKMKFOHIa92YGuW5PaqadR1XxIN+yUWLdXWgiyT9JPfVCkAQ+CGJDtckKtubV/XVvSdAhbDjoYJiCnOnQxupfw3Fj0Eq1qsjdtcdIx31KB4T3r1Btt0gGCFIYKN/Oo9xd5h7Z1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256103; c=relaxed/simple;
	bh=LWCW7Ab2npso2A0MnlnsVialL4wN6615PwU1Jme1Odg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzy1RtPh6LXgVqHXVEy6mAACIoACcNzYaHUdTfvWLKmMNbzVcu/qSjOkU7EetvjFu8BVKY+RPRkqAS/zCJwDZmVRmNEqT3h+JqXK29cQOCthT3HnrV3LQn98A4mvbzensnCXPddMyrbppu2zHbNouTQeia+GCnHfxjJ27+CcowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAvlZh63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAvlZh63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE911F000E9;
	Fri, 12 Jun 2026 09:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781256101;
	bh=z8eP0u8KtPXYMwpmkHl+cIN6DZUL4U6tNKDUWtD2Dbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAvlZh63F6e3sWAT7FTVglBa8L9b4p6swhYDRHcsFGaNsCq16l1CnS3FxeMmgxBLR
	 8PttODPMe5afP06Ve2iXsq2LhoYpMFwyskJgNZQ1PoedKAkyqJxM3HFJM01/xOIvUJ
	 PO2FBBlDdDYbczEKwSbg7+okmhSqqUpYW3gnoYsTPLLDEuK2jR9JxHBjB39OV5dGWy
	 Y0xzrCH5Vk9iPYIUWv1vulJtAriGlFh1jBvrZlpFTtqzctCs6+lR10Z1MZAA79yNnm
	 Kavl8izbxRik8zo8tnaD8DstVZnLDNB7om0rtjme4F6aMKig52hv7NnJDJEhRn+e36
	 ZTyeMLuN9QxXQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 3/8] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612090114.3188886-4-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:21:41 +0000
Message-Id: <20260612092141.8AE911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch introduces a severe performance regression in NMI contex=
t on Arch LBR CPUs that lack hardware branch-type decoding by unintentional=
ly forcing software disassembly on all recorded branches.
--

commit 4686077e19d211c998cc542c03a674a17408e8d7
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Fallback to sw branch type decoding if no hw decoding

This commit updates the arch-LBR filtering logic to fallback to software
branch-type decoding if hardware decoding is not supported. It replaces
the X86_FEATURE_ARCH_LBR CPU feature check with the x86_lbr_type static
branch to properly handle arch-LBR configurations that lack branch-type
information.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c68..e2657f791e507 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1231,7 +1231,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>  		 * Doesn't support OTHER_BRANCH decoding for now.
>  		 * OTHER_BRANCH branch type still rely on software decoding.
>  		 */
> -		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> +		if (static_branch_likely(&x86_lbr_type) &&
>  		    type <=3D ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>  			to_plm =3D kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>  			type =3D arch_lbr_br_type_map[type] | to_plm;

[Severity: High]
Does this introduce a performance regression in NMI context on arch-LBR CPUs
that lack hardware branch-type decoding?

Currently, intel_pmu_setup_hw_lbr_filter() unconditionally sets
X86_BR_TYPE_SAVE for arch-LBR CPUs:

arch/x86/events/intel/lbr.c:intel_pmu_setup_hw_lbr_filter() {
    ...
    reg->reg |=3D X86_BR_TYPE_SAVE;
    ...
}

Because X86_BR_TYPE_SAVE is forcibly set in br_sel, the fast-path early
return at the start of intel_pmu_lbr_filter() is bypassed even if the user
only requested basic branch recording without branch types.

With this patch, if x86_lbr_type is false, the loop falls through to the
else block and calls branch_type() for every LBR entry. This causes
expensive software instruction decoding to unconditionally execute for all
LBR records on every PMU interrupt.

Should intel_pmu_setup_hw_lbr_filter() be updated to only force-enable
X86_BR_TYPE_SAVE if static_branch_likely(&x86_lbr_type) is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090114.3188=
886-1-dapeng1.mi@linux.intel.com?part=3D3
