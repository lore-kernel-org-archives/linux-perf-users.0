Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F33E6398
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311482; cv=none; b=XejFc4QP7stLy2kggHThcfa4OX/91mRi70W8N0gkmho1WUX/gk8d8l6wFJx/rias3fNrdZUOGYEmvqrL/HUQ0/z/ShAL0w9JbNMtl0r8IKlByCHd34mS00DQNdJ1mg9TTV0XU+jbBIAZVqZz8Ulwfl2je2/tp2nlZQGWQYsleHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311482; c=relaxed/simple;
	bh=ZoNGjq0IsGIpPDMoe9Jft3cfPxzyxAx+rUXzrdgUMS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g7xtwNdLTncfWdB5KPeh1lFekgSV3PTQnsATwXZM6S93PvNJ51RQzNBQLlxiE7M2A8VDJhEfLPCbvJgz1aymZTtoqvPqfbYVnAtOxy7B1KhkX/3J6lVWeue6qygppIQ0UXUSNejERBAs7gh2WK/ZNqjgbHtNhfgAaSZBh0aIVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmnT681f; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmnT681f"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24a00d12cso106660925ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777311478; x=1777916278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUGfHBBKLKTBHfPFY8nLzpUEKNPZw0zVaxuVGypwmBw=;
        b=MmnT681fMrKrtOc+Xk4HFfIG1C6LiD5TgHxdaH8nzbuhGzrJ2LffRtrbicdPhe16ij
         RcmSB5sgJgsXmlUA+2LroozwvoB1bcD7ANeVCt9mMBOtg+0cwsAXN8hr4KS9lEvV6Uy0
         vkD2wsGIdhcHq5nEPRb/E0QD/hwGkMqIvi0aMCrXDTfnzOZX7LNv7fumfWTvwfBchIYJ
         BIEooAvKVjMNKrxeqC0/ol8Lbe2lEzmTXV+Zw4d/SgDd55vQ23hZIN5MLd5vzRiy+ms0
         Omooi8PEVl0BN1NF2CyIIHzcKW7mmMAlmCSXtJE18n12A3yXZ7RoAsQnvKsCSqq5oMJ0
         5/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311478; x=1777916278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUGfHBBKLKTBHfPFY8nLzpUEKNPZw0zVaxuVGypwmBw=;
        b=R4Ges1+4nxOMapu2juG7ivOCzcqepUvLWyBYQhTqCM+wow3ZLNF06rPU98xrai5UJ9
         nr9ZgsuGAhSS95AM3DkT80M7EL0cc0lcbDHX0hJPaqfPDuQYkNrrPffTC+rcKp1cRxdf
         LJeIkh+xwLd/Qe1FzWo1Z+sqoJsJYSoQXH80hj7OKKEC3wopM8D9VJguQI5AMuCfhORS
         g2f7XS+NBBfMwZfjE6C1xaWZmYE9mNkwzG7En5wgOGpPjtV+q+RkAxyZxryqp575ceX9
         YDMycN19ArirYegOzbB9030ZvIPKZ6e4WrPzKJpb1Z54/QQw5g71KFfWbqd/cc3ivH4e
         1UZA==
X-Gm-Message-State: AOJu0Yy7dB9SEam8iV1UTcpp1eSiEKhXTC0ZVM20FKSnC6+q9q9wZOcm
	H54EwLONP6cVJz3eONEp3vzYlcnVgc0BUJMH2+uTqugZ1GOrCBrCO3WtrnS+UyPIuXBtd5yvdE9
	Q/F5f+A==
X-Received: from pjbbj13.prod.google.com ([2002:a17:90b:88d:b0:359:f0e8:29f8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:37c7:b0:35f:b7c1:faad
 with SMTP id 98e67ed59e1d1-36490cdb867mr41738a91.25.1777311478337; Mon, 27
 Apr 2026 10:37:58 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:37:56 -0700
In-Reply-To: <20260423233145.DDC5BC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423150340.463896-5-seanjc@google.com> <20260423233145.DDC5BC2BCAF@smtp.kernel.org>
Message-ID: <ae-e9FQzmhnMVn1Q@google.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
From: Sean Christopherson <seanjc@google.com>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 23, 2026, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Unconditional external function call to intel_pmu_get_cross_mapped_mask() introduced in the VMX hot path.
> --
> 
> commit bf596eb4f1ae159ccdd3b9e0517c0eaa4c80ce4a
> Author: Sean Christopherson <seanjc@google.com>
> 
> perf/x86: KVM: Have perf define a dedicated struct for getting guest PEBS data
> 
> This commit introduces a dedicated struct (x86_guest_pebs) for passing guest
> PEBS data from KVM to perf. It replaces the previous method of passing an
> opaque pointer to kvm_pmu, allowing perf to define its own data requirements
> independently of KVM-internal state.
> 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index a29896a9ef1456..e6c1c64a8c949d 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -7313,12 +7313,15 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
> >  	if (kvm_vcpu_has_mediated_pmu(&vmx->vcpu))
> >  		return;
> >  
> > -	pmu->host_cross_mapped_mask = 0;
> > -	if (pmu->pebs_enable & pmu->global_ctrl)
> > -		intel_pmu_cross_mapped_check(pmu);
> > +	struct x86_guest_pebs guest_pebs = {
> > +		.enable = pmu->pebs_enable,
> > +		.ds_area = pmu->ds_area,
> > +		.data_cfg = pmu->pebs_data_cfg,
> > +		.cross_mapped_mask = intel_pmu_get_cross_mapped_mask(pmu),
> > +	};
> 
> Does this introduce an unnecessary function call overhead on the VMX hot path?

Probably.  I'm not sure how much we care.  Though what does matter and should be
fixed is that intel_pmu_get_cross_mapped_mask() is a bit of a lie.  It doesn't
check _all_ PMCs, only those that are globally enabled and configured for PEBS.

I'll figure out a way to address both in the next version.

> Prior to this patch, the external function intel_pmu_cross_mapped_check()
> was conditionally called only when PEBS was enabled, which avoided an
> external function call in the vast majority of cases.
> 
> Because intel_pmu_get_cross_mapped_mask() is in a different compilation
> unit (pmu_intel.c), calling it unconditionally here results in a function
> call on every VM-entry.
> 
> Would it be better to restore the inline condition check, perhaps using a
> ternary operator when initializing cross_mapped_mask?


