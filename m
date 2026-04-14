Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DB25A2C9
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199799; cv=none; b=bG7O4TQGBKe5X+fkj7R701IUAw970EBqX3+6jRtv+cEoAd2v38XEC8FLT62Cjj1pBMXQ99wQwssiJzmDKgJS3p73SAVD3uAhsxKeVQnY2pGmeVmmntFoyqZvr2ufxJmgGu3R5s5hYKktUXb+bZtWMQBnHlW8LDMVUyHMIl8f1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199799; c=relaxed/simple;
	bh=W0/jEgy52SpfoYngp5WKnk+fijN2JLn3E9O1YbrQdbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o6U2lHTzoL/wpeHkDD1f9WQwjFmnRWReI75JvIKI3ZrgJ8sPkZDicYDGLcFF7CGzfwb14Fr0lawBM+0J9eQBoodrAX9tW6DP4cP/CB35CFjHy6PidGUykr3M+NLBETnmepmTKazvSIz8HESFbPkysoVvCK6CLiztaHw1um+4Huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhKGpfvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhKGpfvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866B1C19425;
	Tue, 14 Apr 2026 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199798;
	bh=W0/jEgy52SpfoYngp5WKnk+fijN2JLn3E9O1YbrQdbw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=IhKGpfvk7mrfTbLYT2NC2r4vLYw/d/ydTvDUFCJoaixy3BhQyVwVq/vmyhYso3gI/
	 NqI5WuUpR9WuC8E6zyS3XG/CkkCPOzsL0V2c6AHUenawp2mvPmTnWHz3cIonoj8sNw
	 hVwnpLi/EbqwvCUHSPtD7mHI4a3cQl2sPhSGCHhghvcnyo2LmPNdak8U95QhlzavC2
	 SMMX+F8sfIaqGY6aVa7qXj8ZigJJ9i0/ar7201mzk5f5DmnQWTaN/aMb5ZCRM1+W+b
	 hnu4q+LNEW1lV3qj/4m4nV5N1rK/YJHku8VmkYbeA7R1/84evNTl/5fXYcgddPctX2
	 acixCWAsjhcMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
Reply-To: sashiko@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260414191425.2697918-3-seanjc@google.com>
References: <20260414191425.2697918-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 20:49:57 +0000
Message-Id: <20260414204958.866B1C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Critical] Omitting MSRs from the returned array fails to clear them from=
 KVM's VMCS autoload list, defeating the optimization and causing host PMU =
state corruption and cross-CPU memory corruption.
--

commit 96e2a3492ccedcf6d37eda9e864908154fe181d9
Author: Sean Christopherson <seanjc@google.com>

perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS is u=
nused

This commit conditionally omits DS_AREA and MSR_PEBS_DATA_CFG from the list
of MSRs to be loaded by KVM on VMX transitions when PEBS is not active in
the guest. The goal is to save MSR writes and eliminate pointless writes
on roundtrips when the guest isn't using PEBS.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
[ ... ]
> +	/*
> +	 * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS will be
> +	 * active in the guest; if no records will be generated while the guest
> +	 * is running, then running with host values is safe (see above).
> +	 */
> +	if (!guest_pebs_mask)
> +		return arr;

Will KVM actually stop context switching these MSRs if they are simply omit=
ted
from the array?

To instruct KVM to stop context switching an MSR, the perf subsystem
needs to explicitly return the MSR in the array with .host =3D=3D .guest,
which triggers KVM to call clear_atomic_switch_msr().

By dynamically omitting MSR_IA32_DS_AREA and MSR_PEBS_DATA_CFG when
guest_pebs_mask is 0, KVM never processes these MSRs and permanently leaves
them in its msr_autoload lists with stale .host and .guest values.

Does this regression cause cross-CPU memory corruption?

If a vCPU migrates to a different physical CPU while guest PEBS is disabled,
the VMCS retains the old physical CPU's MSR_IA32_DS_AREA host pointer.
On VM-Exit, the new physical CPU will load the old CPU's DS_AREA pointer.

Any subsequent host PEBS records generated on the new CPU would then be
erroneously written to the old CPU's memory.

> +
>  	arr[(*nr)++] =3D (struct perf_guest_switch_msr){
>  		.msr =3D MSR_IA32_DS_AREA,
>  		.host =3D (unsigned long)cpuc->ds,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414191425.2697=
918-1-seanjc@google.com?part=3D2
