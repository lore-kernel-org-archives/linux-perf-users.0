Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5739AC3
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872453; cv=none; b=rUHRsqwkenkn1TzjuEKTN1Z+/Kr1+cil3AyPksjptNGy+9nzk+2fIP0rDvzUKa5v0UD4naNx84sYOw/sOIWaWmrMN0uz2wRiahKTfjb7MZxkeo9YzyI5IrVSh+/f9pEW8gtKh1bBxXSOv11DaFiE/xiOZnUK5+de3csmB6JPpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872453; c=relaxed/simple;
	bh=dMv2efYh9t5qbiHodN5CHCg9ZWvNG1WjJJvX3ETmegY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GNTEENyElcxLvw2WTc6sKXezdEXZBI4dvUBxb8724ky42lIcl9LGysb5IiyTd7Ht/2nkbiOzMh39fXSTV+9rHOLE2rOl5w9Itnr4LhXRHaI0QJ79iLZL0y7afvFsQh0fqAnk3eGaii256LyPJPCERZi+R2uS7w/FgBmSJInL0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+JETiTv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+JETiTv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2c0d3eadeso3241845ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712872451; x=1713477251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWEYeWMnUY3BOgV5tOpNO4uTAlbf0LGTh8Nxy6R0vPg=;
        b=N+JETiTvLgRdnYXZloB5a8GQDp5sBA/FbroybV8zXfTswz7BzN+wLW8A0/ijCf/XmV
         qHe5lDM6EjyIRwGB/IWYqyns8h9a9OmHlXDOjs+NoYDOS/Lg/RP0jblpUFxLVMZD0WXR
         Kqn5IWm940+yNgBMUMRncnLiVAjXCUJNC9gStQwW4GqQ7Jzit9QFc9Zx1cIA2C6ujW5A
         LnqyQYHqpqg79EeOoe+A+3hxsHYO4XRfLw0T1oR6UKpztX+ZvN9iTTczjLlIP4OJaI8p
         0Qk8Qg8U0NvroiCP9J/S+i5uHSx24c8oNAaGJcYIyTB5bYhDJisZIEd907+U+objGB++
         OziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712872451; x=1713477251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWEYeWMnUY3BOgV5tOpNO4uTAlbf0LGTh8Nxy6R0vPg=;
        b=e00jMDOO2lh63GYkVwofCviRR+dYZALb7tzRynS7OZEmTZMSDpX0zdTqLw157Ug6m8
         32Li/yKYJYBmUQQa7/vLpMb/a5xmhxWNGmsbu3gjfHe6Z+aoxNSBm2NIspJbQ27FxLiR
         +WcB48/YDdm9GbAC1UuVetjv0SKXIs74tWmyKOh4I8cPrwrv0pPmTWJx7FcF3h8joZow
         cMJiR+WPIMPVmos76i/e7gCrEbV7w9hH0xNEnicWDq46Vqz3URflFlczO+WAE3UvoSx1
         vQ8Hy5F8sUMrmB7ElPQpD+Odhg2q9k4BEGxxMq6TnJbcehTnhCLWfy8SHI3QlJwRNYza
         zAcw==
X-Forwarded-Encrypted: i=1; AJvYcCUTbqSTLdV07e6zpKMil+60kSm+iKiYIG7O6kGXzK7/6SIb2Ait4NjMviSkX0fUY4Pxy0FG0RQ8bAg6ZfmKmR/4lHUCkFEDLGXFp36zIEXxKQ==
X-Gm-Message-State: AOJu0Yx9UoMuXVbciWvDf6JM32It5oCBm7Zdcz8JUleIbpWT0WhwfTCd
	ipDnNJwX85qqafPxFhS9ibkkObCVpP2APiBvl/Dud8Rh2ui5UgofZ2FiJ4N4OUL71biRSvxiG2k
	riQ==
X-Google-Smtp-Source: AGHT+IE+4lhp+CVIvIL7jXc6IL4yCLOEq6e22oEzOBveayKBILIDUtN2lWLL1X94+Jx8CVt7uNuSRPz9m7A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:a4e:b0:1e2:881c:8ddc with SMTP id
 mn14-20020a1709030a4e00b001e2881c8ddcmr1730plb.12.1712872451257; Thu, 11 Apr
 2024 14:54:11 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:54:09 -0700
In-Reply-To: <20240126085444.324918-29-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com> <20240126085444.324918-29-xiong.y.zhang@linux.intel.com>
Message-ID: <ZhhcAT7XiLHK3ZNQ@google.com>
Subject: Re: [RFC PATCH 28/41] KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at
 VM boundary
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com, Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> +static void save_perf_global_ctrl_in_passthrough_pmu(struct vcpu_vmx *vmx)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(&vmx->vcpu);
> +	int i;
> +
> +	if (vm_exit_controls_get(vmx) & VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL) {
> +		pmu->global_ctrl = vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
> +	} else {
> +		i = vmx_find_loadstore_msr_slot(&vmx->msr_autostore.guest,
> +						MSR_CORE_PERF_GLOBAL_CTRL);
> +		if (i < 0)
> +			return;
> +		pmu->global_ctrl = vmx->msr_autostore.guest.val[i].value;

As before, NAK to using the MSR load/store lists unless there's a *really* good
reason I'm missing.

And we should consider adding VCPU_EXREG_GLOBAL_CTRL so that we can defer the
VMREAD until KVM actually tries to access the guest value.
