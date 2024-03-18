Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9FF5B5A5
	for <linux-perf-users@vger.kernel.org>; Mon, 18 Mar 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802269; cv=none; b=kxl3a5QHcuOXaKTMKMKXwaiwh0aHsA64ylh9G17XwLHDVl1Ig+1YxgQxRBnmsiuC1QbDTNYIoB/TPku7RKuLzRQ1dgZ2zM19DA+zyZW+kTEzSDvC8ap7CZNVXHjW+yBFCgQ0iybOTcDF0qUdg1eXTq5MsjAIQSgfpimifzZoCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802269; c=relaxed/simple;
	bh=RtlWf1DUjv82ac5qipkxBnNnekJF65HsPSXIESmFR1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyfUpMxWqRXn2QC7/IqpQTulTNuV5KWjKQs6K768ffntcnOsLTfDb3BcreuBHF4LdfBYdvw5qKGtfgIFIjhEwxIuAvRHAlYU3xFtvn4jE7looY6MGPG6RHWpDhGyHdjMjz4gMeGlTMbwLHzPRsUqc7gHinB9PRhzAa4jgX/UUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v0kwI8Io; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0kwI8Io"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e032fc60a0so8898295ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Mar 2024 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710802267; x=1711407067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ud5yd9UEneNd5ugAHKB8CxcOGP5/5ejBm7BMlFrBXtE=;
        b=v0kwI8IoH1QjkCtl9IByXbtkUTfh3xQigQtvscjTfd7bmAWiIIGOEfbml1yk9n38Um
         RZlwzkFuy+diFg9aO+QCNVNaUYj5t4zlS7kG8oES08a7EAumM7ZEO890z5FBqX6mMnVz
         fy1gehMnTQ1A0Vxvs1+bw0JHLxKnoUKztS1Ubq+MecmpTaHWjN6y8/k7d+Z79/IDUg7M
         OjYfJ5C61mRfRAlAmj6fa1511I7FB8MZhTDDh41gCCCybc7z8GQtfC7/QoHsTXe0wHYo
         7Fdn2d3BjgH9nbMiI/mwvJRx/EReT9MHGRFd3WFv3DWguppJwwYqDWHJZAUogHrR0r1U
         NNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802267; x=1711407067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud5yd9UEneNd5ugAHKB8CxcOGP5/5ejBm7BMlFrBXtE=;
        b=m9uCpeyRRWDBC6KUIHHBHmcapIJQ35Bx+Xu+/JKzdu7ifVkXXKrjQUKDuHpfxzBOhL
         /dhR82UYVwpxem3ZOAHHoPkDMSX3r+HY2H9nwQwHWflRW+2P51XMyXVKuzzYMW0wLQfe
         GM/ZByfABwgxj4bT7rMAMYP8GtTkzFFw8El1s1ZMXsDoHsXgawDl+mfXrqqGj1QPjkC4
         CHHdvQDirRYPvO/n055L7X+tqy3QagPc1cfQyFTxEmagifCU95r7XX7fun8DpfvTFjzH
         Y6OKSoqTYlaYinrbZ0JYotPkn6/qAjV7FCGXTlfvwFKGkpAsZ5HvaQq8gseO8E9h5Byi
         FKAw==
X-Forwarded-Encrypted: i=1; AJvYcCV1jwr3R0uUnlqLcxJZem82o5y4Ye8HbRklux60rh0XlC6P+UiCvtGuCO+TRYRzogzDbopeGJyTCOR9F3NrfEqUA/7UhRrw8NjUsASmJ8H2dA==
X-Gm-Message-State: AOJu0YxodwwiJWOcV4DnSrE5SuPOcSKArEcqLE2nAO5FSXpGli3pCzwY
	/XxOR2s7qyYFfkvMpdJKoeIfDd4dp2qmFukn+duy0+jCldi0D7YHVpn8rmlDjVkzMXfL+yQpxcK
	nwg==
X-Google-Smtp-Source: AGHT+IGkbPpdZYo3CU/OW4NGStQrIoeWxFx9gM4FUXRlaZ1U+lwcKMp6kX2beZo/T/r2hiTw5nHSDw==
X-Received: by 2002:a17:902:ea01:b0:1e0:e14:b19d with SMTP id s1-20020a170902ea0100b001e00e14b19dmr1326325plg.18.1710802266853;
        Mon, 18 Mar 2024 15:51:06 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902ea0800b001def99dc4d2sm6731245plg.96.2024.03.18.15.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 15:51:06 -0700 (PDT)
Date: Mon, 18 Mar 2024 22:51:03 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH 3/3] KVM: VMX: Disable LBR virtualization if the CPU
 doesn't support LBR callstacks
Message-ID: <ZfjFV0W6-OCgugJl@google.com>
References: <20240307011344.835640-1-seanjc@google.com>
 <20240307011344.835640-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307011344.835640-4-seanjc@google.com>

On Wed, Mar 06, 2024, Sean Christopherson wrote:
> Disable LBR virtualization if the CPU doesn't support callstacks, which
> were introduced in HSW (see commit e9d7f7cd97c4 ("perf/x86/intel: Add
> basic Haswell LBR call stack support"), as KVM unconditionally configures
> the perf LBR event with PERF_SAMPLE_BRANCH_CALL_STACK, i.e. LBR
> virtualization always fails on pre-HSW CPUs.
> 
> Simply disable LBR support on such CPUs, as it has never worked, i.e.
> there is no risk of breaking an existing setup, and figuring out a way
> to performantly context switch LBRs on old CPUs is not worth the effort.
> 
> Fixes: be635e34c284 ("KVM: vmx/pmu: Expose LBR_FMT in the MSR_IA32_PERF_CAPABILITIES")
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2a7cd66988a5..25a7652bee7c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7859,7 +7859,15 @@ static __init u64 vmx_get_perf_capabilities(void)
>  
>  	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
>  		x86_perf_get_lbr(&vmx_lbr_caps);
> -		if (vmx_lbr_caps.nr)
> +
> +		/*
> +		 * KVM requires LBR callstack support, as the overhead due to
> +		 * context switching LBRs without said support is too high.
> +		 * See intel_pmu_create_guest_lbr_event() for more info.
> +		 */
> +		if (!vmx_lbr_caps.has_callstack)
> +			memset(&vmx_lbr_caps, 0, sizeof(vmx_lbr_caps));
> +		else if (vmx_lbr_caps.nr)
>  			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
>  	}
>  
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 
