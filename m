Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B3143C53
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717046931; cv=none; b=izrIZnSai9xhHcVn2WTfkg8B+dVw3Z6nJHbiUHMrE61HF9CBIvaj++TQwiqTAZZJ3AdWZf6zHj7sTLC7fQtji6aAysvccEuK+U9JJ1UvJdXiE5wAKfatBkgl+2A0AGXLQvIAcUJ5JQe3hSTn6odkdgaYtDyZDeIRRf6BmdotEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717046931; c=relaxed/simple;
	bh=v9jJLCeiAFLPf9YjhvostbXWDJY//Rqy+nYAZ6S5wWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fizrM1cQJ739nZIi1K/ZQqoy+Loiuqr4npF1OF0MFsAxXDwyM7lMm7OPkVMfTgsxTulPmAvGvnqtNkNajJn4IV31HkqL7+iZKsQ5vFJ0UJS442NB8owMMu2dEb8PUcFAFfa6TEl5PhW+HbpLTQ47BT/ych665OF0rp875DYO46I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORhCZBqG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORhCZBqG"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7022e0cd0aeso552711b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717046930; x=1717651730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxpsU0fnxACaXJ9dwZah6/wvtHJUl8POw+WTjY9EqCE=;
        b=ORhCZBqGQP5QA2NbcUZNgXkDA3N8WzdYKhvYg9/J6E65qz+p/G/25cmiyOdldYXsPV
         /OA4iktuwYsvor3wEK63h5F0hDykB/CeqXl0co5oOnCu0sxpZ7hNtvIB6wVRy3dJ3ela
         GQ5VRAlE+HRYJiCsLt0gbRWXZgGYg78fAP6kDfufYCcv52mag69mGkdLXRpMou44t3Vq
         I3yZ0WM2syl4tgxPQFdBtmmC2wGlc8hY4Qx+wGr+LQL3WLmO/RL4lCEGQB9/N3G9Uogm
         y7UBt46gEBGALy1/NTUZFiS6Xrgvkw1RA1NtQsIVyOf7zDmhFph3lb6IoFzjGLj3QnNR
         p4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717046930; x=1717651730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxpsU0fnxACaXJ9dwZah6/wvtHJUl8POw+WTjY9EqCE=;
        b=dd1q+BQ5iFJEOfwSyAN1REIs6IRE/R9TRrLDG01tVgRrMa7/s/jxzlHqvPdaWygxHQ
         Hz+1haWTazpgiURzvqYhDtAYdmjvDtoUzzWcf1IPyeYIW2Shmdx5y0TjGrlV9TjvVru+
         nCHKzTCCZjxaot6ciA8HQweFOqb1l4j1QO4GSdNv1SxfO6g1eUO/S5yWlAy1FF/KTPNm
         Y+0SFictyJNeXrGK6zrxRavpt6mq1mo4RJbNZI06nRCLRkkpp4fC44DEowGWJwA4MoWZ
         zqITt52FeEqqb+gOdYDomMMNNCF0yKszp/Rp/ejgiBr0Q2/Yz67Yqxfe0AXn2X5Wvsf+
         aRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSI8/zckllZy0tZai7rcQrq7mvxlZp2NK7y07At1rGOEnJBTq/CJCzsbxibrCJBIJIlJfuUZlgfEkRVvAPfdj54A3Ucva2XnR8UaT8wF3f4g==
X-Gm-Message-State: AOJu0Yy/fGE5MzonzQXaXZSrPm+VCAS2GZMeH5Vun+lCOEOoPQxy8yMw
	2g7CMPo3ZTU9jJRNG2k3siUPQ2L8RwE5DRWPsFLa23vrsSopDJ/vRB7zqsCxwA==
X-Google-Smtp-Source: AGHT+IFSQuYB9Qqx3hOktl8KWuEiEHrEiAeEfBnPpMVb4DDIpqlZOuwevngzjViNr7w7/cRhaz5TaA==
X-Received: by 2002:a05:6a20:2452:b0:1a7:2f39:f0cf with SMTP id adf61e73a8af0-1b2646ca7b9mr1254803637.26.1717046929419;
        Wed, 29 May 2024 22:28:49 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6176325e3sm6711275ad.165.2024.05.29.22.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 22:28:48 -0700 (PDT)
Date: Thu, 30 May 2024 05:28:45 +0000
From: Mingwei Zhang <mizhang@google.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: "Chen, Zide" <zide.chen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Xiong Zhang <xiong.y.zhang@intel.com>,
	Kan Liang <kan.liang@intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Manali Shukla <manali.shukla@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	gce-passthrou-pmu-dev@google.com,
	Samantha Alt <samantha.alt@intel.com>,
	Zhiyuan Lv <zhiyuan.lv@intel.com>, Yanfei Xu <yanfei.xu@intel.com>,
	maobibo <maobibo@loongson.cn>, Like Xu <like.xu.linux@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 26/54] KVM: x86/pmu: Avoid legacy vPMU code when
 accessing global_ctrl in passthrough vPMU
Message-ID: <ZlgOjRuqdK4ECZED@google.com>
References: <20240506053020.3911940-1-mizhang@google.com>
 <20240506053020.3911940-27-mizhang@google.com>
 <d19e06e7-ed97-4361-a628-014e5670cf22@intel.com>
 <9b93c6bb-0182-4729-a935-2c05f1160a73@linux.intel.com>
 <e7bc3989-154b-42cb-9a6b-83b395f5d0ee@intel.com>
 <5e14e5bd-0125-4d56-953f-8ecdbe31668d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e14e5bd-0125-4d56-953f-8ecdbe31668d@linux.intel.com>

On Thu, May 09, 2024, Mi, Dapeng wrote:
> 
> On 5/9/2024 9:29 AM, Chen, Zide wrote:
> >
> > On 5/8/2024 5:43 PM, Mi, Dapeng wrote:
> >> On 5/9/2024 5:48 AM, Chen, Zide wrote:
> >>> On 5/5/2024 10:29 PM, Mingwei Zhang wrote:
> >>>> Avoid calling into legacy/emulated vPMU logic such as reprogram_counters()
> >>>> when passthrough vPMU is enabled. Note that even when passthrough vPMU is
> >>>> enabled, global_ctrl may still be intercepted if guest VM only sees a
> >>>> subset of the counters.
> >>>>
> >>>> Suggested-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> >>>> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> >>>> ---
> >>>>  arch/x86/kvm/pmu.c | 3 ++-
> >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> >>>> index bd94f2d67f5c..e9047051489e 100644
> >>>> --- a/arch/x86/kvm/pmu.c
> >>>> +++ b/arch/x86/kvm/pmu.c
> >>>> @@ -713,7 +713,8 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >>>>  		if (pmu->global_ctrl != data) {
> >>>>  			diff = pmu->global_ctrl ^ data;
> >>>>  			pmu->global_ctrl = data;
> >>>> -			reprogram_counters(pmu, diff);
> >>>> +			if (!is_passthrough_pmu_enabled(vcpu))
> >>>> +				reprogram_counters(pmu, diff);
> >>> Since in [PATCH 44/54], reprogram_counters() is effectively skipped in
> >>> the passthrough case, is this patch still needed?
> >> Zide, reprogram_counters() and reprogram_counter() are two different
> >> helpers. Both they need to be skipped in passthrough mode.
> > Yes, but this is talking about reprogram_counters() only.  passthrough
> > mode is being checked inside and outside the function call, which is
> > redundant.
> Oh, yes. I don't need this patch then.

Right. I am thinking about dropping [PATCH 44/54], since that one
contains some redundant checking. I will see how should this be fixed in
next version. Thanks for pointing it out though.

-Mingwei
