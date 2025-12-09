Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BAE308F1B
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 20:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313555; cv=none; b=ZQmo7WtOeVBfuWLekKtSwD0XLjG56ktz2t8b4cmM4PN5tj7yluHxj1Vs0Oit6jkppg25vl61PLvRW/u/awdM2vCTofzL94khRZFksEeIF6lu57/k/Rx1MGnOg/GamV12QcOpr6YkYCpJY52+6zced5jYpsN2JLytXTEzuIfiD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313555; c=relaxed/simple;
	bh=DRKxMglUAQIUPphAezZ5SP/cHAMFr7fL5LywaHt3aMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MRZJs0u0kdYRmYtazcONWjSesoi7iC+mlGtXctuewZbXjsPIPXGofZ2S5FIW1sjTJ8sP2LN/dVcrd7d2QZ9rcthF+kCWQ60vuh33pejjv6k6Px+gg4j4NkR8INkf+tx+DNVPojE+5u1WoeyyIxmbHQ/9x4yVHTNbiBRB/c+D04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpzfOvwA; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpzfOvwA"
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-450c16f2bc1so7613914b6e.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 12:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313549; x=1765918349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVIdJYok4fKvyvbBrKjyW2svdWuCVzRHg04jM7uK3Lo=;
        b=jpzfOvwAZ4D9Gi3VonliA/1av9PNXv/wiaxPCvrM1GvaAOb8nSLjLIBV+6XGzyi7un
         Ag433nm+NxEzVJh/dtn26JJEwBbycxGVNEHAQT67iCXGM/q3a1vG5tWJIv2EJ/oFQ8Yo
         jk0HO9id0ZpqvY25OiNFaXQp8QpntP8fUFI59lGBCMstE68p9YfVknxBk9FGSq+bU84D
         SPW5t7uzSfFy3xIKUhXzBlb05E4a5p4KDH+CN0YlNjU6HGsAS9tfLTgxMFznsqCFUPg/
         BOg2IGjto8rLDi8vyfDqBXMSX4vHbvmdUBY/RyjMEajKGV17CbRZ5JS1tnjQPBg0SLA7
         BaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313549; x=1765918349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVIdJYok4fKvyvbBrKjyW2svdWuCVzRHg04jM7uK3Lo=;
        b=gAoisz0SLw7CbdL04bUCo7/eZMAjTjAs5wpBmfxiVA1hJxiRAo0CEdzbEvFl4hBrzx
         3AutpwcRIJDO5A3Br7BjtcEL+WT0690Z8oHVm9cpl9sbxRqgfChAD9u8LCn4YU/KEscL
         3X9LH1g8nPCAnG9JxwZ9VvlHXmvqAR0ZCws7kdXnsdwJhm+FIsKcy+cHdwE2l3EOKavb
         S/lC8ZDhySRNDRLQ5LaO7akbhLsPnTviBOfqfXfAVNwGABiw/sjJ5StqEE5Vp6P3ojDy
         0Fry/KFV2ymQtznqTYlOJGxAhVeAq7Fsme4lW/MHt1Y0pAyJf1p9b7vV8SsM96qfklbW
         c3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVc6Cw+9Ikd6Pg9W4J5E6iJfh1dyQKIUeSTbKO1uA2kZFRi1A5P9wIPZqJ2HI9XMHMDaVlll1qMoA6U2MhDsvJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nNh310+GVvjqcFXFHGgIbYwHXaWOlMs9UNsBpUqF3NWnHAdF
	mzshbq+wGASaKSUx1aoF9i6FTzUXF7PscAhzHXTcKrH8JQQthr1bHfTr/gSy1psEpreSE6kCVmn
	hqGbjHu03+h97k9sHEAPIvjfM1w==
X-Google-Smtp-Source: AGHT+IHakm9evPNzvbU5exw4KLaOwmIzNJE4dGxAct41AW1pYufo/Hoq5siHPrNun1I5ypJlFtQnQTo9wNdKcG/GXw==
X-Received: from ilbbn5.prod.google.com ([2002:a05:6e02:3385:b0:438:15d1:5e1c])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:81d8:b0:659:7bf7:4d96 with SMTP id 006d021491bc7-65b2ac4f918mr124596eaf.6.1765313549536;
 Tue, 09 Dec 2025 12:52:29 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:01 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-5-coltonlewis@google.com>
Subject: [PATCH v5 04/24] KVM: arm64: Move ARM specific headers in include/kvm
 to arch directory
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Move kvm/arm_{arch_timer,pmu,vgic}.h to arch/arm64/include/asm and drop
the "arm" prefix from all file names.  Now that KVM no longer supports
32-bit ARM, there is no reason to expose ARM specific headers to other
architectures beyond arm64.

Cc: Colton Lewis <coltonlewis@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20250611001042.170501-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[Colton: applied header change to vgic-v5.c]
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../arm64/include/asm/kvm_arch_timer.h                     | 0
 arch/arm64/include/asm/kvm_host.h                          | 7 +++----
 include/kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h  | 0
 .../kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h    | 0
 arch/arm64/kvm/arch_timer.c                                | 5 ++---
 arch/arm64/kvm/arm.c                                       | 3 +--
 arch/arm64/kvm/pmu-emul.c                                  | 4 ++--
 arch/arm64/kvm/reset.c                                     | 3 +--
 arch/arm64/kvm/trace_arm.h                                 | 2 +-
 arch/arm64/kvm/vgic/vgic-debug.c                           | 2 +-
 arch/arm64/kvm/vgic/vgic-init.c                            | 2 +-
 arch/arm64/kvm/vgic/vgic-irqfd.c                           | 2 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c                      | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v2.c                         | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                         | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio.c                            | 4 ++--
 arch/arm64/kvm/vgic/vgic-v2.c                              | 2 +-
 arch/arm64/kvm/vgic/vgic-v3-nested.c                       | 3 +--
 arch/arm64/kvm/vgic/vgic-v3.c                              | 2 +-
 arch/arm64/kvm/vgic/vgic-v5.c                              | 2 +-
 20 files changed, 22 insertions(+), 27 deletions(-)
 rename include/kvm/arm_arch_timer.h => arch/arm64/include/asm/kvm_arch_timer.h (100%)
 rename include/kvm/arm_pmu.h => arch/arm64/include/asm/kvm_pmu.h (100%)
 rename include/kvm/arm_vgic.h => arch/arm64/include/asm/kvm_vgic.h (100%)

diff --git a/include/kvm/arm_arch_timer.h b/arch/arm64/include/asm/kvm_arch_timer.h
similarity index 100%
rename from include/kvm/arm_arch_timer.h
rename to arch/arm64/include/asm/kvm_arch_timer.h
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 64302c438355c..7f19702eac2b9 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -26,17 +26,16 @@
 #include <asm/daifflags.h>
 #include <asm/fpsimd.h>
 #include <asm/kvm.h>
+#include <asm/kvm_arch_timer.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_pmu.h>
+#include <asm/kvm_vgic.h>
 #include <asm/vncr_mapping.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
-#include <kvm/arm_vgic.h>
-#include <kvm/arm_arch_timer.h>
-#include <kvm/arm_pmu.h>
-
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
 #define KVM_VCPU_MAX_FEATURES 9
diff --git a/include/kvm/arm_pmu.h b/arch/arm64/include/asm/kvm_pmu.h
similarity index 100%
rename from include/kvm/arm_pmu.h
rename to arch/arm64/include/asm/kvm_pmu.h
diff --git a/include/kvm/arm_vgic.h b/arch/arm64/include/asm/kvm_vgic.h
similarity index 100%
rename from include/kvm/arm_vgic.h
rename to arch/arm64/include/asm/kvm_vgic.h
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 3f675875abea2..ce62a12cf0e5c 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -14,12 +14,11 @@
 
 #include <clocksource/arm_arch_timer.h>
 #include <asm/arch_timer.h>
+#include <asm/kvm_arch_timer.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_nested.h>
-
-#include <kvm/arm_vgic.h>
-#include <kvm/arm_arch_timer.h>
+#include <asm/kvm_vgic.h>
 
 #include "trace.h"
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d1750d6058dfd..43e92f35f56ab 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -38,11 +38,10 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nested.h>
 #include <asm/kvm_pkvm.h>
+#include <asm/kvm_pmu.h>
 #include <asm/kvm_ptrauth.h>
 #include <asm/sections.h>
 
-#include <kvm/arm_pmu.h>
-
 #include "arm_hypercalls.h"
 #include "arm_psci.h"
 
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index b03dbda7f1ab9..dcdd80ffd49d5 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -12,8 +12,8 @@
 #include <linux/perf/arm_pmu.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_emulate.h>
-#include <kvm/arm_pmu.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_pmu.h>
+#include <asm/kvm_vgic.h>
 
 #define PERF_ATTR_CFG1_COUNTER_64BIT	BIT(0)
 
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 959532422d3a3..bae3676387419 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -17,12 +17,11 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
-#include <kvm/arm_arch_timer.h>
-
 #include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/fpsimd.h>
 #include <asm/ptrace.h>
+#include <asm/kvm_arch_timer.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
diff --git a/arch/arm64/kvm/trace_arm.h b/arch/arm64/kvm/trace_arm.h
index 9c60f6465c787..8fc8178e21a70 100644
--- a/arch/arm64/kvm/trace_arm.h
+++ b/arch/arm64/kvm/trace_arm.h
@@ -3,7 +3,7 @@
 #define _TRACE_ARM_ARM64_KVM_H
 
 #include <asm/kvm_emulate.h>
-#include <kvm/arm_arch_timer.h>
+#include <asm/kvm_arch_timer.h>
 #include <linux/tracepoint.h>
 
 #undef TRACE_SYSTEM
diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
index bb92853d1fd3a..a67e5e5f44871 100644
--- a/arch/arm64/kvm/vgic/vgic-debug.c
+++ b/arch/arm64/kvm/vgic/vgic-debug.c
@@ -9,7 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/kvm_host.h>
 #include <linux/seq_file.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include <asm/kvm_mmu.h>
 #include "vgic.h"
 
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index da62edbc1205a..39ead7ec1b43a 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -7,7 +7,7 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/kvm_host.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include "vgic.h"
diff --git a/arch/arm64/kvm/vgic/vgic-irqfd.c b/arch/arm64/kvm/vgic/vgic-irqfd.c
index c314c016659ab..b73401c34f298 100644
--- a/arch/arm64/kvm/vgic/vgic-irqfd.c
+++ b/arch/arm64/kvm/vgic/vgic-irqfd.c
@@ -6,7 +6,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <trace/events/kvm.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include "vgic.h"
 
 /*
diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index 3d1a776b716d7..39d96b52f773d 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -7,7 +7,7 @@
  */
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/kvm_host.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include <linux/uaccess.h>
 #include <asm/kvm_mmu.h>
 #include <asm/cputype.h>
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v2.c b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
index f25fccb1f8e63..d00c8a74fad63 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v2.c
@@ -9,7 +9,7 @@
 #include <linux/nospec.h>
 
 #include <kvm/iodev.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 
 #include "vgic.h"
 #include "vgic-mmio.h"
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 70d50c77e5dc7..5191ad3b74b7e 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -9,11 +9,11 @@
 #include <linux/kvm_host.h>
 #include <linux/interrupt.h>
 #include <kvm/iodev.h>
-#include <kvm/arm_vgic.h>
 
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_vgic.h>
 
 #include "vgic.h"
 #include "vgic-mmio.h"
diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index a573b1f0c6cbe..45876b5ef9fc8 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -10,8 +10,8 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <kvm/iodev.h>
-#include <kvm/arm_arch_timer.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_arch_timer.h>
+#include <asm/kvm_vgic.h>
 
 #include "vgic.h"
 #include "vgic-mmio.h"
diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 381673f03c395..780afb7aad06e 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -6,7 +6,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include <asm/kvm_mmu.h>
 
 #include "vgic.h"
diff --git a/arch/arm64/kvm/vgic/vgic-v3-nested.c b/arch/arm64/kvm/vgic/vgic-v3-nested.c
index 7f1259b49c505..f3f21d8fa8335 100644
--- a/arch/arm64/kvm/vgic/vgic-v3-nested.c
+++ b/arch/arm64/kvm/vgic/vgic-v3-nested.c
@@ -7,11 +7,10 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 
-#include <kvm/arm_vgic.h>
-
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_nested.h>
+#include <asm/kvm_vgic.h>
 
 #include "vgic.h"
 
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 2f75ef14d3399..f345501016e2c 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -7,10 +7,10 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/string_choices.h>
-#include <kvm/arm_vgic.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_vgic.h>
 
 #include "vgic.h"
 
diff --git a/arch/arm64/kvm/vgic/vgic-v5.c b/arch/arm64/kvm/vgic/vgic-v5.c
index 2d3811f4e1174..601d7b376deef 100644
--- a/arch/arm64/kvm/vgic/vgic-v5.c
+++ b/arch/arm64/kvm/vgic/vgic-v5.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
-#include <kvm/arm_vgic.h>
+#include <asm/kvm_vgic.h>
 #include <linux/irqchip/arm-vgic-info.h>
 
 #include "vgic.h"
-- 
2.52.0.239.gd5f0c6e74e-goog

