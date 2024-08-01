Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEB14A0A0
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488382; cv=none; b=UDr4xNtRpd8omTu3AnXjGuOZkRRvVCLXNJU1KK9EVr+fb4wHcuWGcDiQqC3tQWWosYUQM5+eUbmzQ1yzY/0N8EXWShJjBYhectIVbOle2nRpJ5rPnNVuMjNrn948Zr7rudwUXA0cygazcjGkip1mK9MzXFDxyiZPqfg9YYP4rq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488382; c=relaxed/simple;
	bh=0/b75EMzTbLP6NsYR29AELL/PRg0NZLtZLfh/BsNyNE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AqOSfiPxb6z7O2AJTUKjraneu5hnhMm82Tq7Wt/3mZ4z4jVMTGK0JDnbVUpdPtvjdiW4khsU94urHcN4/BE+BwfoMLizmSMaWtMpgAXK3E7K17nGVC7RX41ignOPSIDLi3lYWFjGCdA9MqPkes8X9Vy/yjtSr/ps1re6lI6GcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yep9aF8E; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yep9aF8E"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70f0a00eb16so2033989b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488380; x=1723093180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MGOggTalV7FwiA/xVIceGN8/hpdIkEgMiUN8jsDmXoY=;
        b=yep9aF8EJyG7bH/vhPa/oZev1JFZD519cWI6KtQG/09+rEoz/vEZ0vqmbwBcNYAipw
         0NtjWNwSon3klzBol1xu+FyMNZzyHH2kAIZwmU5cR5dfhjgR1DZ6EzsUm/RTDZYaC+t8
         5aB6a5pa6XSnH468pOq8hueXf/JFDGHYh8J2VD1lDglB01lDapbDzWK5oe0UcPNvNZhP
         si7yy5M5NATIUuM+yoGhYCdAzVkTb6SHLcGabr8ffHdPRJxOV5Z3bWVh8aQSnjpFMxyJ
         4zu17gg02rmFPI3CP5ZtiXTbNPyHTxwtmdoUbrMGTghgETyhC7d2F8Pb9LCFd+W6+Nvk
         qvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488380; x=1723093180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGOggTalV7FwiA/xVIceGN8/hpdIkEgMiUN8jsDmXoY=;
        b=OsjKbXOY0u+L5S/dohrfDG4XgoO81TPstzTrmw5yMPmuosiYEqNaJDIDVNWcdvEBXv
         0NKI5kAGFlR5RktQp8bNfuFrwNmTppfQ8flioOO8T7gOFZaiWTZx0HsJcuIsBi/fzSaW
         q3aqlmP3/tLrslkem7+AXM9jKrrIcRzdRt14TWygROl+7rVN397lEYa1cbTncR1rZqs5
         MfiAftIQWQXbtEPL4AAn4UadrTtwAmH/WEWm7U4kGleftxTSGomI2SARncX66agnq9Zl
         hAVwopWLdmytVEmo6XkyQL8dYMf9Uk9UXbd/PuJrPEyjPbsz1+fUbZ/5njq5O+ph0BSg
         JbAw==
X-Forwarded-Encrypted: i=1; AJvYcCWotxSye74n1Rp8H85xdSW+t9IUrux3X+2ISv+CBr/MbgrUie6RSMHLClOYB90yCWBQXns+WXxHyKBeVnkjZZb2+04kEDtyVOHflGMMtueFfA==
X-Gm-Message-State: AOJu0Yy2/7qNhx9zljrCytRBNK3X986nltExfR1pZ1SQthBm6rvE4Iuq
	Y+3hpfldtpog4HlXmYci1j0Aaphfp4zrNIgaLqIpEBvU79tp4WwqOXPsSVszxc4/mHyE5LrvGUN
	7DsSEqA==
X-Google-Smtp-Source: AGHT+IGliNyqPgVM+9MNmf/Lk2KHQLa5q91ZtJCzNXEKFOh/pBmygSkrQhNypvWjFArbh7+Gxuvomj3sONmb
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:61c6:b0:710:4d08:e41f with SMTP id
 d2e1a72fcca58-7105d7e450bmr5344b3a.4.1722488380182; Wed, 31 Jul 2024 21:59:40
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:25 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-17-mizhang@google.com>
Subject: [RFC PATCH v3 16/58] perf/x86: Forbid PMI handler when guest own PMU
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If a guest PMI is delivered after VM-exit, the KVM maskable interrupt will
be held pending until EFLAGS.IF is set. In the meantime, if the logical
processor receives an NMI for any reason at all, perf_event_nmi_handler()
will be invoked. If there is any active perf event anywhere on the system,
x86_pmu_handle_irq() will be invoked, and it will clear
IA32_PERF_GLOBAL_STATUS. By the time KVM's PMI handler is invoked, it will
be a mystery which counter(s) overflowed.

When LVTPC is using KVM PMI vecotr, PMU is owned by guest, Host NMI let
x86_pmu_handle_irq() run, x86_pmu_handle_irq() restore PMU vector to NMI
and clear IA32_PERF_GLOBAL_STATUS, this breaks guest vPMU passthrough
environment.

So modify perf_event_nmi_handler() to check perf_in_guest per cpu variable,
and if so, to simply return without calling x86_pmu_handle_irq().

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b17ef8b6c1a6..cb5d8f5fd9ce 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -52,6 +52,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.pmu = &pmu,
 };
 
+DEFINE_PER_CPU(bool, pmi_vector_is_nmi) = true;
+
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
@@ -1733,6 +1735,24 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	u64 finish_clock;
 	int ret;
 
+	/*
+	 * When guest pmu context is loaded this handler should be forbidden from
+	 * running, the reasons are:
+	 * 1. After perf_guest_enter() is called, and before cpu enter into
+	 *    non-root mode, NMI could happen, but x86_pmu_handle_irq() restore PMU
+	 *    to use NMI vector, which destroy KVM PMI vector setting.
+	 * 2. When VM is running, host NMI other than PMI causes VM exit, KVM will
+	 *    call host NMI handler (vmx_vcpu_enter_exit()) first before KVM save
+	 *    guest PMU context (kvm_pmu_save_pmu_context()), as x86_pmu_handle_irq()
+	 *    clear global_status MSR which has guest status now, then this destroy
+	 *    guest PMU status.
+	 * 3. After VM exit, but before KVM save guest PMU context, host NMI other
+	 *    than PMI could happen, x86_pmu_handle_irq() clear global_status MSR
+	 *    which has guest status now, then this destroy guest PMU status.
+	 */
+	if (!this_cpu_read(pmi_vector_is_nmi))
+		return 0;
+
 	/*
 	 * All PMUs/events that share this PMI handler should make sure to
 	 * increment active_events for their events.
@@ -2675,11 +2695,14 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
 
 static void x86_pmu_switch_interrupt(bool enter, u32 guest_lvtpc)
 {
-	if (enter)
+	if (enter) {
 		apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_GUEST_PMI_VECTOR |
 			   (guest_lvtpc & APIC_LVT_MASKED));
-	else
+		this_cpu_write(pmi_vector_is_nmi, false);
+	} else {
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		this_cpu_write(pmi_vector_is_nmi, true);
+	}
 }
 
 static struct pmu pmu = {
-- 
2.46.0.rc1.232.g9752f9e123-goog

