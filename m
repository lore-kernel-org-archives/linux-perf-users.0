Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A4266F02
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837592; cv=none; b=rgh0ByeTc0tr7meoeYFzlfKrFBGLqpwwxxaolb6CIG2jv80RZsfU2oJWUNuSymcZoli9OrpTXma6Mq0D1qvKaDgi5dKPTq2DQvhcHLXfB83Ejx9wDQdIf8akaXqJBUcdlTl40bQY/Lolk+3yI3ak3m+CNfcvxWGFhRJEiFq/k4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837592; c=relaxed/simple;
	bh=7yohD4OY7oJi3PjKnxCA6LaTJHZ1/TxhZUQgByNjysY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/XkJlFlcWjfx+KXGlNNnv0mIREIffNh0lfdiSToefegBhcrYHX0G1R8LCf5Rj68R/XJsJNi6Nv/P0KVpr5FLsawgjNGwcdJ3XXRIQUd2wBGAOXIy1YXyJCounsI0iVBeLyFXtocW/fFOxfrrS+1+8BYgPUP7vSsnsDm0URKIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=feSMjzYD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feSMjzYD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22650077995so119211885ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837590; x=1743442390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dGFuB9mmLp1BQVwj/uNArSbaMRJJW4D9abapz9TbNsk=;
        b=feSMjzYDYEpiUZ0DlHVbdW7g4WJ91v03gdyDD46ItIoKjGBNT8aFrtNvP/v5/nE7GQ
         D/kl1Aokvlq9lYwBkB7LDM78H3iSMOLXh5T+5T/iQo13XCzRiKqdn0Bj0eSLdyjoDoRW
         GXMHUMg/WPnTYPp8gtskXOZPZHgW36V7G2BrP+luEEhY+M1J2f6fD3bW81qBOys5XQVp
         DuN5fJEauLn6rf4n2i3yXAhk0EqfTqLVspCf4AiJrMrSK0rfTEu47ZqgB34qL3SaUWCa
         W5Hwx53PCc963XPgrVfYqFV/c27+7rwO24BQSdfzn2lUY1QkcrpjE7pAUwa7O3Ovs+Tg
         Da5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837590; x=1743442390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGFuB9mmLp1BQVwj/uNArSbaMRJJW4D9abapz9TbNsk=;
        b=v6tSbplcoKowb4k5rf2hczqp3bk3NwDzVlrc5jI1rr0BU8SURj8vwEd3tmxoc+Eczr
         11uzbTJUwr02mp3trn7vIbkHlAjdwjFPiGCJ6CVHFDvRm32T9oC0rJpM1Q+CxXw4CASm
         t/LJw3rqIJBWM+pvZ4o2rzr6iXbQ8wQlT8wNQ/mV+REIfla93A0C6QeR+rbN3VhIEPbf
         syU9vHModwru1RvDp0ntw5aly4iOYEDkNKRNsEBN+c7cC4SNRvmzSO5I2UcakQYF1NQi
         r62F/cTenJPYxFiEIrczurmNasx+Zzi0zvchD8sSjAj2cYgjYCa05ASB3DmcVmVF8YOC
         sQKA==
X-Forwarded-Encrypted: i=1; AJvYcCWfrft2fCDQL3bBt+IW+H902ZObehqeRmell6BqDOmHeS/8NLER1LZM7yPq2TsLSLrahaID9Mj89+3u4o+1WT3W@vger.kernel.org
X-Gm-Message-State: AOJu0YzE7yOdMTybSBiOh6gjWYOMejYyb0vgo8rS5uLHCo+nJ67xbV24
	g/tkkqAYp0l3hehZwXpYV+bu4bepa0XdrwLe85DClAfIBLpzOlxopbu67KTlVFp8QjHQfHWuakh
	vaGSGFw==
X-Google-Smtp-Source: AGHT+IEfRjGoPGy11ZTF+dZtGZ81t1uBtVUdGc31rboe3q80FnaB9lKjiEwv64EnTeLYudK0ci+z5pWqoJgr
X-Received: from pfld12.prod.google.com ([2002:a05:6a00:198c:b0:736:46a8:452d])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f81:b0:736:5822:74b4
 with SMTP id d2e1a72fcca58-73905a530a9mr23169375b3a.21.1742837589869; Mon, 24
 Mar 2025 10:33:09 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:30:51 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-12-mizhang@google.com>
Subject: [PATCH v4 11/38] perf/x86: Forbid PMI handler when guest own PMU
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
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
index 28161d6ff26d..96a173bbbec2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -54,6 +54,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.pmu = &pmu,
 };
 
+static DEFINE_PER_CPU(bool, pmi_vector_is_nmi) = true;
+
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
@@ -1737,6 +1739,24 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	u64 finish_clock;
 	int ret;
 
+	/*
+	 * When guest pmu context is loaded this handler should be forbidden from
+	 * running, the reasons are:
+	 * 1. After perf_guest_enter() is called, and before cpu enter into
+	 *    non-root mode, host non-PMI NMI could happen, but x86_pmu_handle_irq()
+	 *    restore PMU to use NMI vector, which destroy KVM PMI vector setting.
+	 * 2. When VM is running, host non-PMI NMI causes VM exit, KVM will
+	 *    call host NMI handler (vmx_vcpu_enter_exit()) first before KVM save
+	 *    guest PMU context (kvm_pmu_put_guest_context()), as x86_pmu_handle_irq()
+	 *    clear global_status MSR which has guest status now, then this destroy
+	 *    guest PMU status.
+	 * 3. After VM exit, but before KVM save guest PMU context, host non-PMI NMI
+	 *    could happen, x86_pmu_handle_irq() clear global_status MSR which has
+	 *    guest status now, then this destroy guest PMU status.
+	 */
+	if (!this_cpu_read(pmi_vector_is_nmi))
+		return NMI_DONE;
+
 	/*
 	 * All PMUs/events that share this PMI handler should make sure to
 	 * increment active_events for their events.
@@ -2681,10 +2701,13 @@ static void x86_pmu_switch_guest_ctx(bool enter, void *data)
 {
 	u32 guest_lvtpc = *(u32 *)data;
 
-	if (enter)
+	if (enter) {
 		apic_write(APIC_LVTPC, guest_lvtpc);
-	else
+		this_cpu_write(pmi_vector_is_nmi, false);
+	} else {
 		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		this_cpu_write(pmi_vector_is_nmi, true);
+	}
 }
 
 static struct pmu pmu = {
-- 
2.49.0.395.g12beb8f557-goog

