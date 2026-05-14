Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2833314C5
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778724865; cv=none; b=o1b1D7uaQx3lHjXY79yj2YtSI3KUi3goM+/4c3QZ8V0rlge9jr5yR6ETaBGlCwI1eOtlJOsQ0PWfHAWdKGfNkCvdpFEEFdiGLHYf3VCpfen4sfmT2UuxAB2837m99iwd3UMsfeOBnDCfzvtz15GaDtY/ia/NHw2IxdMwUnOXiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778724865; c=relaxed/simple;
	bh=VAjDINNf/lfjB+UrZjyvkAx0KjuK3gvqAskzwm/IKeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gRVhTP+s1HvUcRZzq/XmBC0GlpuE4eadsZSCpmAxJXERXmiX+g/WnGgoWWPmxrLHmt5bzeZG6KmupyrV0tZDY2Y9SSVouDMGXIk+cypO7R9cfQlRR0TcQNoyPaIeW8H9/meMMU3f8VtSDa0iLNmrhIsR2bML5RNRZGy9TAmkQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZswrKZGv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZswrKZGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821EEC19425;
	Thu, 14 May 2026 02:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778724864;
	bh=VAjDINNf/lfjB+UrZjyvkAx0KjuK3gvqAskzwm/IKeg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZswrKZGv8oC+UxvsvHs7KwjYGrxgt+FzFLx1E1dbLnRk4UmzkcGTlu6J5/J5PD660
	 cUeNNcB+OBzswuIo9HqJGWqB21A5iP936VEGecuQr2I+hVNqjNEvHjfU1o0BeSFJFm
	 SOecAHF8u0YEN2/vj/lZ0FGYc5jQSTRmVceoggObuVl/H8rrfzwuxWrvWQD3gFfXe/
	 7PEuWOKdzvl49GbTv/8AgVxChg7OMdk7zd0KHreF6HyFIhazmKsZE2/3huIj1A1DWN
	 4HjKb1xqucKew0Az1a6lZzlcSmzoOsgvWB2IPRY/i6QPfGk2wLNEJeCWG/zlwOGrVS
	 YjLAcRXWiO7JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] perf/x86/intel/uncore: Let init_box() callback
 report failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512233048.9577-3-zide.chen@intel.com>
References: <20260512233048.9577-3-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 02:14:24 +0000
Message-Id: <20260514021424.821EEC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The adl_uncore_msr_init_box callback was missed during the return =
type conversion and still returns void, causing a build failure and a runti=
me functional regression.
--

commit 9d842c01126a1db0940fbdd8cefa558fa67a3758
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Let init_box() callback report failures

The init_box() callback currently returns void, so initialization
failures are silently ignored and the box is still marked initialized.
Change the callback to return int so platform code can report errors
back to the common uncore layer.

> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncor=
e.h
> index 2e41a66f00551..25a44d3de6e7d 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -129,7 +129,7 @@ struct intel_uncore_type {
>  #define events_group attr_groups[2]
> =20
>  struct intel_uncore_ops {
> -	void (*init_box)(struct intel_uncore_box *);
> +	int (*init_box)(struct intel_uncore_box *);

It appears the return type for the init_box callback was changed here, but
adl_uncore_msr_init_box() in arch/x86/events/intel/uncore_snb.c was missed
and still returns void:

static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
{
	if (box->pmu->pmu_idx =3D=3D 0)
		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
}

Could this cause a build warning or failure (e.g., incompatible pointer
type)?

Also, at runtime, uncore_box_init() expects an int return value. Would it
end up reading an uninitialized return value from the eax register?

If the last operation in adl_uncore_msr_init_box() is wrmsrq(), which
loads SNB_UNC_GLOBAL_CTL_EN into eax, could this residual non-zero value
cause uncore_box_init() to incorrectly treat the initialization as a failur=
e?

If the initialization failure marks the PMU as broken, would this render the
Alder Lake (ADL) MSR uncore PMU inaccessible to userspace?

>  	void (*exit_box)(struct intel_uncore_box *);
>  	void (*disable_box)(struct intel_uncore_box *);
>  	void (*enable_box)(struct intel_uncore_box *);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512233048.9577=
-1-zide.chen@intel.com?part=3D2
