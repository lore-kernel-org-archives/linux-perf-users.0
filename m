Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354D140394
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973451; cv=none; b=szcOVTd5eqJS6C+FY+HGolvR1n+SZpRTBQFOukOBKM/PA4c2KlWkb5GTE7jAs5cBT6ljk2LFiINq03yM7aTfyNOV3uUNAXsBSBouALHaZoNqggsrfeenbNiNdxy8uf/BinakDbrHkTOww7YktlTerK/cvU4YS9M9PG+m/GKnUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973451; c=relaxed/simple;
	bh=OKVnKqjqLes500+TVVKHCbNHVn805ASKjv1fJgD46/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jCL4Xd6Hje5QLa2Kh8o4N7BnLxwXnd38IXptQ+EkcLqhlxFBUZuuw2by4zQhLc9+o4c+2NIybeVu/DSA0bAuoyW72lz6gbe1tif2Gn+WvF21bIi5yxiId/wSgOU9zSSGmp0HixH3cNO+DTSSBfjS6/5IBFP7owT6yVNH8XGFg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsV731uT; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsV731uT"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f441afba80so2209310b3a.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973449; x=1715578249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=L3LCM1OsaYiIlnrBibBFz2xG/zfA/cshhJRla+qWYkk=;
        b=tsV731uTrqRxA7Vjs5I1TYT8urvii6Hg7Nifcybq6LSKV7rZGjSha8t3VIFlSNYWyd
         4xh/Wlf2OmbYe9PCDkP2wdHkWleaaGCQYXAOCqArbSGp0qAG731P7h9JaBm2na+wJAJE
         YKEoe3cR0Gr0dvvBUSNaY9SYulp7Z+njSsLZgfLY3fy1JeGSwTRnOuXrKd8hw25F0GCr
         gB8ybAdI0yxkeHgFT/ZbIBTacNgcsg3VpyiQPDfl5G+VrTAj0kH9vCjTvvTEbF1K1XHX
         8Za9UkezTfYTa/DphTEDX3sGsUCVn+VkWhZEtOajKRxdhqjCW1HzHDNco6bv/MywhNJ7
         QSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973449; x=1715578249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3LCM1OsaYiIlnrBibBFz2xG/zfA/cshhJRla+qWYkk=;
        b=jsZK8cFct6ORgPkuzhoYxWvlXgcFyve7b1QeRvH+2Jbbkx1oh06i3vdMdFb8nLtV8o
         Guf5L0HIKAT2iVJPIBaTRiSYKg3CnANmBBdTwTM5fVn+AtTBu3RKfYnPYEc4vUhzE9bG
         b5yie59zV+Yptjv6GuAXGaAxMBGGKvwvsIpnmZVIxzyhcD189n0OBTLNykga5R39XVOi
         DunJS2bE1KlD4d2s9X8PMBZQzfZ6O4e+ilqiqSbD87Df0XJKccr3nyMu7r9Z8yyEWhK4
         Nmw3XcZ3wQPs9VXuqC10sVYllWbWKYKtkyTOgoyKxEAIZldr1iCGQ2TSrfKkQLvB6Fbe
         nufQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5XO1TczZPQ6JUHyEvJMoZUVPQPepcx3sqiCOlbhuBx4CrFFoy62djuZWZv3Dtb9hVzk35+oogDVey6HxavMcu768oSMMGBEz+B3mmArsuGg==
X-Gm-Message-State: AOJu0Yx6MJA8djPhxUyzCwL6d2PXjieES4U6sY8BPtmdorump5dQM4hv
	gmGiwE5hgAlFc0ebtnT1wEm1pycq8ag+h6HJ3Nq8pYhbqOOzl1HskCVlyd/1jvV3vX1dypzoukB
	jvmdZKw==
X-Google-Smtp-Source: AGHT+IEoDoKL6bIcsKXu5g80INJRprO1/lLAhr+CEcEGoJrqGc2N33Bj0ShzzTtaYaOJs/MTq2tsW/TfUFFh
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:39a1:b0:6ec:ceb4:d9e2 with SMTP id
 fi33-20020a056a0039a100b006ecceb4d9e2mr239424pfb.0.1714973449476; Sun, 05 May
 2024 22:30:49 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:37 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-13-mizhang@google.com>
Subject: [PATCH v2 12/54] perf: x86: Add x86 function to switch PMI handler
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

Add x86 specific function to switch PMI handler since passthrough PMU and host
PMU use different interrupt vectors.

x86_perf_guest_enter() switch PMU vector from NMI to KVM_GUEST_PMI_VECTOR,
and guest LVTPC_MASK value should be reflected onto HW to indicate whether
guest has cleared LVTPC_MASK or not, so guest lvt_pc is passed as parameter.

x86_perf_guest_exit() switch PMU vector from KVM_GUEST_PMI_VECTOR to NMI.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 17 +++++++++++++++++
 arch/x86/include/asm/perf_event.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 09050641ce5d..8167f2230d3a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -701,6 +701,23 @@ struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data)
 }
 EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
 
+void x86_perf_guest_enter(u32 guest_lvtpc)
+{
+	lockdep_assert_irqs_disabled();
+
+	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_GUEST_PMI_VECTOR |
+			       (guest_lvtpc & APIC_LVT_MASKED));
+}
+EXPORT_SYMBOL_GPL(x86_perf_guest_enter);
+
+void x86_perf_guest_exit(void)
+{
+	lockdep_assert_irqs_disabled();
+
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+}
+EXPORT_SYMBOL_GPL(x86_perf_guest_exit);
+
 /*
  * There may be PMI landing after enabled=0. The PMI hitting could be before or
  * after disable_all.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 3736b8a46c04..807ea9c98567 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -577,6 +577,9 @@ static inline void perf_events_lapic_init(void)	{ }
 static inline void perf_check_microcode(void) { }
 #endif
 
+void x86_perf_guest_enter(u32 guest_lvtpc);
+void x86_perf_guest_exit(void);
+
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
 extern void x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

