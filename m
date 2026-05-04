Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3FA346E75
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929513; cv=none; b=E5epPB0udMiZvvhTjvYA9ZQVZsGPBMLIrb9gnAamDpDdFTAe3tYPJXIpt8ZoSgqkbmr9Ayxw5NtqE/NUANsrWlS5hEWpZZBMd9fK+e3CPa2HJxJlnTIn19TFYNHjOfvVMdMgOw5YG1CLggpY4fObWIk8gK4uwSWQqzlTrRIO36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929513; c=relaxed/simple;
	bh=QnWGvE5r/VD50+dB5BY+tSgcU1JPBszfEEBcsQx8zVU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRhT+bjrpKJ+kfxhXoZN1JUkKWEgFswWBbv5txZXvUUYt8eGO5w1aMPlv6b36Jx0M+ywgl5SF859HJ2efz6qFcNPthBBOcmCO0FIyuaEHsQrRFVvQH9ldYfBPiHmpoOWlYIouQHkzpS7TQJuFPYQWKN4KIBD0ZBNg5rbQRHmbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxLfHn20; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxLfHn20"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-695391d14acso5317423eaf.2
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929511; x=1778534311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mx9MuEs10AivytOpsddviHcuIhm9po4u8KpiL1CkIVk=;
        b=mxLfHn20LqZprrtoPcLEGCHVC1mldaELnvJnAeXzkdrZkVy2WGhjlpbhymAGwMs4CV
         4NDJtgMavxa8IdoVVnjLQtwHFPL8lOZ3TKzMl69JYNr+fKdHFfogqW+zfKDoCmQPKVJX
         6uU9zGFQOQgT/5yoRB4j1TMaiYHsVbInaLBrWoiCMdPT6Voc2WfJROcz4Ne4rOeCPPy7
         TvSNgPyOtoUmZEsGdP2E0MMzouZ5/EERJJ8V2EJisJgo1biBeVKEglYTUBaEd2NZLNwj
         56ApH6l/9C+vp/bKLr6bBvqTHfoJAV74PkUe2As/xU1Z/RAzbfj3hdIPQch8lqai/bl0
         Ry2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929511; x=1778534311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mx9MuEs10AivytOpsddviHcuIhm9po4u8KpiL1CkIVk=;
        b=Ky+ppybd5rKdcAeMTdVJfC06CaZ7A1SDd52/vA4lRYqNHPh1IbpFlsnY6EWrSDKxXL
         gRi0tgYXWB2dBO+LnS/EWAhymV/Hjg69SG1Qsep6N2J1mBA1VEaGFdIeP7T+0UwvWAWj
         iRKWJTxiU8EQfMiKyPaDvNjIXd9gFaMlpai9dU36kconMAVmztkGfY2lCCtTHhLdZBI4
         J9ZDsiL9fVk7X86WgexHmfkRKIKuXlHKG0/jAaBBsfrT4So3HGsG3YZ4JnK35n+Jnn85
         trYAQ7lPHfU6s24u+/xPbJHg55DlQFJ6xOJ6AfDmiHZauZX7HfPsiGQlQ+zdzZwUUEc0
         5KUg==
X-Forwarded-Encrypted: i=1; AFNElJ+CLLLS2V2fd2tenTGwgJ5OeoHR9VAVVsNsMS6Wg8jI8Cnkg0nkMpsoOKzRHovWbC5STuYTqw9H3wZXlixSgxDL@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/8mCN+lpYh/+hx4eqRXPr/mIVHWW5hkg9NVKYhB+1x3ytF8e
	6DzlYM99NhZ0TKfWTWlb14PrTvcRsGNG1CDyRC4WTREFHwPTSps3J1SWzEXQRYxT4SZ2JXGfEL6
	0hbL7aL5HvwD6c6JI3aOwqqvHlA==
X-Received: from jams10.prod.google.com ([2002:a02:c50a:0:b0:5d9:a04c:991d])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:179b:b0:696:1814:717a with SMTP id 006d021491bc7-69697dc2ac6mr5287197eaf.47.1777929510525;
 Mon, 04 May 2026 14:18:30 -0700 (PDT)
Date: Mon,  4 May 2026 21:17:55 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-3-coltonlewis@google.com>
Subject: [PATCH v7 02/20] KVM: arm64: Reorganize PMU includes
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Marc Zyngier <maz@kernel.org>

Including *all* of asm/kvm_host.h in asm/arm_pmuv3.h is a bad idea
because that is much more than arm_pmuv3.h logically needs and creates
a circular dependency that makes it easy to introduce compiler errors
when editing this code.

asm/kvm_host.h includes kvm/arm_pmu.h includes perf/arm_pmuv3.h
includes asm/arm_pmuv3.h includes asm/kvm_host.h

Reorganize the PMU includes to be more sane. In particular:

* Remove the circular dependency by removing the kvm_host.h include
  from asm/arm_pmuv3.h since 99% of it isn't needed.

* Move the remaining tiny bit of KVM/PMU interface from kvm_host.h
  into arm_pmu.h

* Conditionally on ARM64, include the more targeted arm_pmu.h directly
  in the arm_pmuv3.c driver.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/include/asm/arm_pmuv3.h |  2 --
 arch/arm64/include/asm/kvm_host.h  | 14 --------------
 drivers/perf/arm_pmuv3.c           |  5 +++++
 include/kvm/arm_pmu.h              | 19 +++++++++++++++++++
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 8a777dec8d88a..cf2b2212e00a2 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -6,8 +6,6 @@
 #ifndef __ASM_PMUV3_H
 #define __ASM_PMUV3_H
 
-#include <asm/kvm_host.h>
-
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 70cb9cfd760a3..1f789ba589d56 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1441,25 +1441,11 @@ void kvm_arch_vcpu_ctxflush_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu);
 
-static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
-{
-	return (!has_vhe() && attr->exclude_host);
-}
-
 #ifdef CONFIG_KVM
-void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
-void kvm_clr_pmu_events(u64 clr);
-bool kvm_set_pmuserenr(u64 val);
 void kvm_enable_trbe(void);
 void kvm_disable_trbe(void);
 void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest);
 #else
-static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
-static inline void kvm_clr_pmu_events(u64 clr) {}
-static inline bool kvm_set_pmuserenr(u64 val)
-{
-	return false;
-}
 static inline void kvm_enable_trbe(void) {}
 static inline void kvm_disable_trbe(void) {}
 static inline void kvm_tracing_set_el1_configuration(u64 trfcr_while_in_guest) {}
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 8014ff766cff5..8d3b832cd633a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -9,6 +9,11 @@
  */
 
 #include <asm/irq_regs.h>
+
+#if defined(CONFIG_ARM64)
+#include <kvm/arm_pmu.h>
+#endif
+
 #include <asm/perf_event.h>
 #include <asm/virt.h>
 
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 96754b51b4116..e91d15a7a564b 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -9,9 +9,19 @@
 
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmuv3.h>
+#include <linux/perf/arm_pmu.h>
 
 #define KVM_ARMV8_PMU_MAX_COUNTERS	32
 
+#define kvm_pmu_counter_deferred(attr)			\
+	({						\
+		!has_vhe() && (attr)->exclude_host;	\
+	})
+
+struct kvm;
+struct kvm_device_attr;
+struct kvm_vcpu;
+
 #if IS_ENABLED(CONFIG_HW_PERF_EVENTS) && IS_ENABLED(CONFIG_KVM)
 struct kvm_pmc {
 	u8 idx;	/* index into the pmu->pmc array */
@@ -66,6 +76,9 @@ int kvm_arm_pmu_v3_has_attr(struct kvm_vcpu *vcpu,
 int kvm_arm_pmu_v3_enable(struct kvm_vcpu *vcpu);
 
 struct kvm_pmu_events *kvm_get_pmu_events(void);
+void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr);
+void kvm_clr_pmu_events(u64 clr);
+bool kvm_set_pmuserenr(u64 val);
 void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu);
 void kvm_vcpu_pmu_resync_el0(void);
@@ -159,6 +172,12 @@ static inline u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)
 
 #define kvm_vcpu_has_pmu(vcpu)		({ false; })
 static inline void kvm_pmu_update_vcpu_events(struct kvm_vcpu *vcpu) {}
+static inline void kvm_set_pmu_events(u64 set, struct perf_event_attr *attr) {}
+static inline void kvm_clr_pmu_events(u64 clr) {}
+static inline bool kvm_set_pmuserenr(u64 val)
+{
+	return false;
+}
 static inline void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu) {}
 static inline void kvm_vcpu_reload_pmu(struct kvm_vcpu *vcpu) {}
-- 
2.54.0.545.g6539524ca2-goog

