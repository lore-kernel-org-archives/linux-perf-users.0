Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D6B1AC88B
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922012; cv=none; b=Y2LiptbxO5ziQYU7sKJbIu2JjdDTuJC22PBA0x8WwLxHukXQaizT1Z+s/2rvJovkfh1jJe8Aw0INzU6iFIevzb2JexBgsOOPbA5895IeP9Czs9Ru4tfIgjIpqVjbMOPRvECD2Lk0vrua0Oux44zBl1KBotecoQScCLrknSQJ/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922012; c=relaxed/simple;
	bh=iN8WovyFuRjSwZJv2FDucbCFOnu8NqKRhx7jU5eDsVQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQ5WBtdOUKy5AbdTJSrPUtj0YMIkieUrQT8xlXVQxtOthfbJNbvH1TZbww20FNBVAgniKHM/Mxh6+Fs5Kk+ahWx8ycUgaX8oqXyjP+lwC6V/vsiKPU6ULuwfxSAYXjRK3qI1KnXoDHtTB8FzfuUtzXC9hyCYUGQqaa5/gm25AlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rGJXj3A; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rGJXj3A"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-204e310e050so57647465ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Oct 2024 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728922010; x=1729526810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwSWZjQ27GxDWRHISycf7nMSxcYhNRFFhPOH/5On2AI=;
        b=0rGJXj3Ag4SgTRCsF6tb2TjcEwfmK9a8Ig0yUPHKiRFniqsvIfjWfSeDTfDAaDv/EW
         bLCejfmL0psrvhBXDY2xw/POPXGJZuEWjZ5cxBfvYML7BL3y28zOAN/vjMHwTdpExqAC
         HfmpJBXGCFxFsp4opSIOXthzeswr+B/YSGJAkuZ+AVuq/W6g7hZvzlNwcjsK5CPchfIs
         BD9SHbttegA7h4tEdMkFoUF5Lm9u810SqjyDde+xBE8qRUAZJpYTUcpJnvvFQ/PBt0gY
         +lybEbAHjNr51Ot4PeDRoawZSFH582/tYLquGOtHsoIdkuKbRa1AXc5zdgxO6l4bgBGZ
         C6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728922010; x=1729526810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwSWZjQ27GxDWRHISycf7nMSxcYhNRFFhPOH/5On2AI=;
        b=SfF6YzfPWL6vYQLWiXCo8As4pJD5++si216d+8188fGg6WCLalkOh8nMUJKUcA0TWD
         6VqMvy6yzrFaRp5sbJOI3SLMGMubgC2TLmElL6sfZmtXXVtQPnDoeL7P7AJ3HzDh9CIc
         NmNlZLKOBmoKLYDNX8iQV+TPuT3HphzFXhafhWwmtwU7HkmsJ6z2/ANNrMXdVE4Qqg6S
         1Caz+my8mbfpWtm5u/tZuB+4azSGmFJyfNnJGGPFvcpSKEJbSNGUQwDytP0ea5Kx6e6O
         y/JbiMz8xWj+Wj3AzZYBJIrZsE/P8j678703siz01jDDmyHO07C58uExB6M/+hWvasrZ
         7scw==
X-Forwarded-Encrypted: i=1; AJvYcCXZR7utGsTIVafT1Umk/inP5co12bJSn64KxT0JXIfBwuISoEHIdBmITpsKx6saJRPDICFjew06lS36sPnVY/R4@vger.kernel.org
X-Gm-Message-State: AOJu0YwKE5jmBuQk0qAqtuKfFvfYuN4p5mmXVtWdHwo/KpFuJ5lgGMcQ
	ve753LqWxgMCcxbOaGMixvvbzdhLXTOhr8fVLWAMNwcXd+ymMwgiYb27R/d54kOJVg+fakPaLdR
	frQ==
X-Google-Smtp-Source: AGHT+IEwjwfWJSyr0D7btX97mpAtj9F5UTed1EZBw/lMmbFEbnas4u3vHagJykzf8XQHofrX4lrNygFFlNk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5d0:b0:20b:861a:25d4 with SMTP id
 d9443c01a7336-20ca1460029mr661295ad.5.1728922010162; Mon, 14 Oct 2024
 09:06:50 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:06:48 -0700
In-Reply-To: <20241014105124.24473-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014105124.24473-1-adrian.hunter@intel.com> <20241014105124.24473-3-adrian.hunter@intel.com>
Message-ID: <Zw1BcYhTxZS4E2O5@google.com>
Subject: Re: [PATCH V13 02/14] KVM: x86: Fix Intel PT IA32_RTIT_CTL MSR validation
From: Sean Christopherson <seanjc@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, H Peter Anvin <hpa@zytor.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com, 
	kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

"KVM: VMX:" for the scope.

And I would much prefer to actually state what is changing.  "Fix XYZ" isn't
helpful in understanding what's actually broken, fallout from the bug, etc.  It's
never easy to describe bugs where the logic is flat out busted, but I think we can
at least capture the basic gist, and allude to the badness being a wrongly disallowed
write.

On Mon, Oct 14, 2024, Adrian Hunter wrote:
> Fix KVM IA32_RTIT_CTL MSR validation logic so that if RTIT_CTL_TRACEEN
> bit is cleared, then other bits are allowed to change also. For example,
> writing 0 to IA32_RTIT_CTL in order to stop tracing, is valid.

There's a fair amount of extraneous and disctracting information in both the shortlog
and changelog.  E.g. "Intel PT IA32_RTIT_CTL MSR" can simply be MSR_IA32_RTIT_CTL.
And the 

I'll fix up to the below when applying; AFAICT, this fix is completely independent
of the rest of the series.

KVM: VMX: Allow toggling bits in MSR_IA32_RTIT_CTL when enable bit is cleared

  Allow toggling other bits in MSR_IA32_RTIT_CTL if the enable bit is being
  cleared, the existing logic simply ignores the enable bit.  E.g. KVM will
  incorrectly reject a write of '0' to stop tracing.
  
> Fixes: bf8c55d8dc09 ("KVM: x86: Implement Intel PT MSRs read/write emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1a4438358c5e..eaf4965ac6df 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1635,7 +1635,8 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
>  	 * result in a #GP unless the same write also clears TraceEn.
>  	 */
>  	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
> -		((vmx->pt_desc.guest.ctl ^ data) & ~RTIT_CTL_TRACEEN))
> +	    (data & RTIT_CTL_TRACEEN) &&
> +	    data != vmx->pt_desc.guest.ctl)
>  		return 1;
>  
>  	/*
> -- 
> 2.43.0
> 
