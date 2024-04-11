Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA53FE54
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877958; cv=none; b=W+PX/qOf4GuTuhLABmajx/3bDlKJ6HdwkemV1Id4D5D9NbxL8BAhurxH3xSPLmmw8j2MWoh1jGfd+nLsJalJzanS7YaIYDEsI9Ul48dkA3Zu49UWbg/7hELTSPygCLbQB3RCCCmVdbUpICwU6U0Py5exzPNhr0ktb/UonMjvff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877958; c=relaxed/simple;
	bh=Vi/2xASu1BxKX4lM8VAO/Am54CJvEJC5TgkBtmp5PPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MeaTo85ZU0OTwab2+QQOHs7lhdtGV/arCvNSPlqg4IPT8YPsiloObSHbkdpF4GpoqhJIDk1xXjaXOVWxTA7gJJ4/6u89J6rbeza3ukcQRXBizxThwJQW5PnpWonZOK04jHOG4PCvzHyGbADoNldo0OtQE7cT1775ers5jy0gbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQIFsRtN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQIFsRtN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso249863a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877957; x=1713482757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SBa5EsG+dA7Im52unjbubbrECIOknLW2YGglXB1T+g=;
        b=RQIFsRtNGlt/nv43uQ8oG7WM8XsQcUmp6US2Q1cx5SJirloCYhW1seAa6lacop/zZw
         ni/cL7981m5LRY7s5f8KmpFcuQoft17ps7gG1Rc5A22Hr3SUkzcHQ212kpXmvLH9mEhH
         R7ol6zYep7hLbCj1HHdXYAO2YqH7d3hNOy7PBSdaWGYo2ww1txKgs02Vtkp6Wk59MrVd
         D4zETNN8gKEvHGeZP1hqOcISuNrKNrRHs+rBww4o1pS1pAc3/VIG9Rlglp7OLrmT7POg
         DfdIkv9x49DRoBP4w0y27JRisYLZ8C0gDCDjdUtaroBcCCYzkjFgjTrhQdUWbwnxfGRE
         bbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877957; x=1713482757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SBa5EsG+dA7Im52unjbubbrECIOknLW2YGglXB1T+g=;
        b=t5ZbSbqxxxWY5HHQvUiGYbADkWzKghYMTm/xVAiN5TcVEWBQjOS1YYBAFkrEZpTJeG
         PAwS3M/JqEVCssrWz2S286zEwTGmDYpTQtKkZ1xpMzts8za7cpBBIwzmAilMsiV1z7ND
         U59Y2EynnNllI+7LXP5SUsR9dO2p+4nfjowVUdJwiBMMKQ5OAjIddZ1OKA69KnV6grbV
         a2G5G+Cjsr98skeOYYI3ZX1iUuS8i1PKmO+rATVYstFyc8jlicYRInugysig8j6rsQlh
         R323NjqpZ85HtMSUbTLfxvgKqEmuB/7AJyFyf17Xaw/QCuWrAqIWXYWfotA7fNfH+xF1
         Quqw==
X-Forwarded-Encrypted: i=1; AJvYcCWs+RJf2qyOWmN8NZHVmMfl0LTrjtrOz87R7HZOJoHSIE5d3Zpi93BauM5IDnGaNsDgTlmzVenGw+rGc/P/aoF+VlHH2MMm5dTwLZBa72D7Kw==
X-Gm-Message-State: AOJu0Yz0pYu/IBCZXA9mlJJMjNgUUn0gSXHWhKDVYP8gaAvdzfigfyR/
	kilL/v8o3XOdB+Q8H162B3LZ0AJ20hUrrAEyJHVn7psL+bcW6r/Yb0QmWjbbFSHu71Oj7daUkOu
	H8g==
X-Google-Smtp-Source: AGHT+IHyFg0c4G2zelykoKwgq1TYbzSAKGdL6gHaImhSh+/66Pan1Vfc60LX/7BV6fA+CJx/673mL3wSNyg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:d70a:0:b0:5f4:36ab:acad with SMTP id
 d10-20020a63d70a000000b005f436abacadmr19603pgg.5.1712877956702; Thu, 11 Apr
 2024 16:25:56 -0700 (PDT)
Date: Thu, 11 Apr 2024 16:25:55 -0700
In-Reply-To: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
Message-ID: <Zhhxg7VvBD38nymZ@google.com>
Subject: Re: [RFC PATCH 00/41] KVM: x86/pmu: Introduce passthrough vPM
From: Sean Christopherson <seanjc@google.com>
To: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jan 26, 2024, Xiong Zhang wrote:
> Dapeng Mi (4):
>   x86: Introduce MSR_CORE_PERF_GLOBAL_STATUS_SET for passthrough PMU
>   KVM: x86/pmu: Implement the save/restore of PMU state for Intel CPU
>   KVM: x86/pmu: Introduce macro PMU_CAP_PERF_METRICS
>   KVM: x86/pmu: Clear PERF_METRICS MSR for guest
> 
> Kan Liang (2):
>   perf: x86/intel: Support PERF_PMU_CAP_VPMU_PASSTHROUGH
>   perf: Support guest enter/exit interfaces
> 
> Mingwei Zhang (22):
>   perf: core/x86: Forbid PMI handler when guest own PMU
>   perf: core/x86: Plumb passthrough PMU capability from x86_pmu to
>     x86_pmu_cap
>   KVM: x86/pmu: Introduce enable_passthrough_pmu module parameter and
>     propage to KVM instance
>   KVM: x86/pmu: Plumb through passthrough PMU to vcpu for Intel CPUs
>   KVM: x86/pmu: Add a helper to check if passthrough PMU is enabled
>   KVM: x86/pmu: Allow RDPMC pass through
>   KVM: x86/pmu: Create a function prototype to disable MSR interception
>   KVM: x86/pmu: Implement pmu function for Intel CPU to disable MSR
>     interception
>   KVM: x86/pmu: Intercept full-width GP counter MSRs by checking with
>     perf capabilities
>   KVM: x86/pmu: Whitelist PMU MSRs for passthrough PMU
>   KVM: x86/pmu: Introduce PMU operation prototypes for save/restore PMU
>     context
>   KVM: x86/pmu: Introduce function prototype for Intel CPU to
>     save/restore PMU context
>   KVM: x86/pmu: Zero out unexposed Counters/Selectors to avoid
>     information leakage
>   KVM: x86/pmu: Add host_perf_cap field in kvm_caps to record host PMU
>     capability
>   KVM: x86/pmu: Exclude existing vLBR logic from the passthrough PMU
>   KVM: x86/pmu: Make check_pmu_event_filter() an exported function
>   KVM: x86/pmu: Allow writing to event selector for GP counters if event
>     is allowed
>   KVM: x86/pmu: Allow writing to fixed counter selector if counter is
>     exposed
>   KVM: x86/pmu: Introduce PMU helper to increment counter
>   KVM: x86/pmu: Implement emulated counter increment for passthrough PMU
>   KVM: x86/pmu: Separate passthrough PMU logic in set/get_msr() from
>     non-passthrough vPMU
>   KVM: nVMX: Add nested virtualization support for passthrough PMU
> 
> Xiong Zhang (13):
>   perf: Set exclude_guest onto nmi_watchdog
>   perf: core/x86: Add support to register a new vector for PMI handling
>   KVM: x86/pmu: Register PMI handler for passthrough PMU
>   perf: x86: Add function to switch PMI handler
>   perf/x86: Add interface to reflect virtual LVTPC_MASK bit onto HW
>   KVM: x86/pmu: Add get virtual LVTPC_MASK bit function
>   KVM: x86/pmu: Manage MSR interception for IA32_PERF_GLOBAL_CTRL
>   KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at VM boundary
>   KVM: x86/pmu: Switch PMI handler at KVM context switch boundary
>   KVM: x86/pmu: Call perf_guest_enter() at PMU context switch
>   KVM: x86/pmu: Add support for PMU context switch at VM-exit/enter
>   KVM: x86/pmu: Intercept EVENT_SELECT MSR
>   KVM: x86/pmu: Intercept FIXED_CTR_CTRL MSR

All done with this pass.  Looks quite good, nothing on the KVM side scares me.  Nice!

I haven't spent much time thinking about whether or not the overall implementation
correct/optimal, i.e. I mostly just reviewed the mechanics.  I'll make sure to
spend a bit more time on that for the next RFC.

Please be sure to rebase to kvm-x86/next for the next RFC, there are a few patches
that will change quite a bit.
