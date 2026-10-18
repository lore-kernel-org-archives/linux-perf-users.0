Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F44C10CD
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333371; cv=none; b=Awd2WBS5b5WhleDWnIbPksQ9mKW88oHXpzVKzNjJKd8tigRCjf+cQ/Idwl5XSDq+k2KvVWB19NvpwYciIbrCKJ9A9dXAlmsBWnjp1Z85tW5lvh8kbORH75dM5zPGgIE/Kz4jbcD3iBfQRhAxPv2aYuBzGtNayAPFEyI0h8QrGxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333371; c=relaxed/simple;
	bh=OGH5tKdgalU4IxqHH3W3jEb3fM56Gl/QkeeiAe2dG4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTLj9pE54ZXiz7sbUR6LpAtxRBKcdWYRa/iqvhNgp2N4KGa2g4K6D3otHj+y245ua2RGQIBQixsicXbvl6EFAYFOIwI1zuZaObfot9FyJblTfdsOGPCAbeFGEKx5Gq7y7Xgqr8s/LS0kf+LSJEuQzjF4HakfrmK3Vs0UzTYfWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6ObrOUE; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6ObrOUE"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679334baa1fso1188977d50.2
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792333369; x=1792938169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATlYUEm2rYxYLXZFWiyY4+dMH/jYL9JxWW6HUiAtEHY=;
        b=L6ObrOUE7u00CJ6kHYYvjsxhOBJicsbHr7Ye8n6YYJ+c4dyNDqql69x9yDh1aRiotk
         AaVJc0ZVNxhb8wOJHom+KQUV+qLKF7M4bQwcLltfR7XSlpXCq4rl2AucSntR6rcnigel
         F1tHFsKo5iDQR9RsOfdf4lBDPhiaw+8s0p6iYU4O3VhZJQlGK8H1SfJV+IlXYDr8gqYJ
         IeTOWfaU8O0LHarZ2J3ZHQY2xXo6H7r6by0gXzNkmAw+stxG90WbYz6+aT/KpUkvV22P
         oYl5/gscn94hzNgHXbzz/gHs0xTUaEwRpZJzWxFw7k+mj10eC0lwtp6HZAkBsMe24vf1
         KMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792333369; x=1792938169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATlYUEm2rYxYLXZFWiyY4+dMH/jYL9JxWW6HUiAtEHY=;
        b=nDYf+zJuGoqbhAYqVd+Y257YvUIAKLt13lFswpi6vt0EpllRbOEBv0o22HPromrX80
         8P2WPAR6n67tCe1l/zUI94EHpHcoZE/tFpcOMN4sLYqljE8XNKeBOdk0kFpWqcoFIWzg
         lL9EERlSRyFhNxHgKG5iEQRF+ZmS5GHoz85UfUo3Nc8FyoFIS3jvF5Bo/zDdhFnRRnP9
         YzJX499o+Jl9WzcQ4G/r2xoFyJE2FeEekbQY4Y7twBE9euMK6JW5BrJYaS8hoFPCocdD
         vZrp4yxkAI1/mK8ciaFwX97XWAcTncKqgizpk3N7qcYEJc64evnV6x66uW9N9jCeAyLs
         pj1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxdfHRYAznlpjCOvY5SrZQNXtKjcSfGrwguNiMRMu1iu0oGoc4NG2eH1ay/wYmGpF37DMIyxgVbAiUJa7jJkdWE@vger.kernel.org
X-Gm-Message-State: AFq9FYLXPbIot9lUAP2qwMPbghvytnHGPseqBYM7lgFA2EqdwNYzuTrq
	J0KXnQSvUuI53f+kvSgWO39LpFQ7pn0S1/k6v017Q5jGrKPZwT9mvI1O
X-Gm-Gg: AYBFou3AIeHA6R0Ot7E9MCIGbR9KldS+Pi/pUUvrOTpxUm2VE4w62NDkzngHHZKocKP
	hetO+xUs73JHCaZZV7eXmJfSbsEXwZ3elKR3ADZFHlPQLlHSL/Y0bnBE2id+CepWFWQOJlFwMpm
	6DGLpL+R3lIkC+pRfOu1Il6S83A4Tt3YBopIXi4E8hBHhI4EGh0RRrvOYyggiD1pyoKEalr9lny
	pe4WdvR0EELuur+lqCJaPO1wfInOmIfHB+qTgdeW44GAXqLxhPIILaXfqBErTfJeudaZZUl3t4M
	qQR5EfIeTKyIgb8HTZwNtlDcXP4q1kZQYGbZ5T9O1ozgF3YgdLYOHqhhA/JrX9+rce3UnX5LPuo
	3GwLy0DcEJ47f4yAMQ+2GtQyzU2H82T46DaTxp2VYraF9wUXamN7T4w8CgU6+mcezUoTnAgV4VL
	KPG7+zQHdCZRi2gqmFuANQRXokKrbIZmi2etSb55yjJ/cWaN3LX/7teB2XkHHZV/D97NvqIgTzV
	g7SqdUlRBAqAwQD+7qdtuV2Ip4rpIvS9IBiZaE0SpthHnhKmGtC3qWvPqfhJ+VrEUH2z18/s1QZ
	Fefe55HiFOaDfTSY5Bsw0C/c/EhVtuMYBx2PHqitAJPAmoiW+9UuDlKzJcdEC1Pjmqk7WDiTTD8
	tihQJCCbX/8yl7IC2bRbMHm5gOs4X3qk=
X-Received: by 2002:a05:690c:6203:b0:8b0:ad62:19c0 with SMTP id 00721157ae682-8b0f21b9343mr17217437b3.39.1792333369127;
        Sun, 18 Oct 2026 07:22:49 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58b3329sm29899867b3.21.2026.10.18.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:22:46 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 18 Oct 2026 10:22:04 -0400
Subject: [PATCH v3 4/5] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-alpha-perf-regs-v3-v3-4-52be85332c57@gmail.com>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7020; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=OGH5tKdgalU4IxqHH3W3jEb3fM56Gl/QkeeiAe2dG4o=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKuXON8y1/+Lt70lf+VLZmiZ+V2HA1pU58z/cfNo1Kvr
 XdYr/xh0fGRhUGMi2GmmCJL3HpFllltO5b6nJb+BTOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GQIZOkbxEDk9Bo3M4uLS1CLdtIIih7z8ksSSzPy8Yr38gtS8gvQCvbTMtJKMjPyi4lSgEXp5qSW
 mro5uRoYGJpaOFmZOFo6mJs7OToZObo6Ozq5ORpbmJgbOlo4mrpbmDFycAjDX3A5m+Ct1/U7gzi
 lS/2JmJqYs8JIS1st/UfJo9qmn+T+F9zga3XzB8Fcmz1I2bp1f64GQubm6JxjWKsvdyjxlwxQS9
 u/NZPs/25gA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Let perf sample registers and dump the user stack, which is what the
perf tool needs for --call-graph dwarf.

The register indices follow the hardware numbering, so r0-r30 map
directly to DWARF register numbers, with pc after them. r9-r15
are callee-saved and live in switch_stack rather than pt_regs, so they
cannot be sampled. Without r15 an unwinder cannot recover the CFA of a
first frame that uses $15 as its frame pointer.

sp is not in pt_regs either: for user frames it comes from
user_stack_pointer(), and for kernel frames (PERF_SAMPLE_REGS_INTR) it
is the end of the trap frame, as in stacktrace.c.

Software events such as context switches and tracepoints hand perf a
per-CPU pt_regs filled in by perf_fetch_caller_regs() instead of a
trap frame. It is not on the stack and has no room for sp, so report
sp as 0 there rather than the address of the per-CPU buffer.

Assisted-by: Claude:claude-opus-5-5
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 .../features/perf/perf-regs/arch-support.txt       |  2 +-
 .../features/perf/perf-stackdump/arch-support.txt  |  2 +-
 arch/alpha/Kconfig                                 |  2 +
 arch/alpha/include/uapi/asm/perf_regs.h            | 45 +++++++++++++++
 arch/alpha/kernel/Makefile                         |  1 +
 arch/alpha/kernel/perf_regs.c                      | 64 ++++++++++++++++++++++
 6 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 4c9a5a012075..7d736d678fd4 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -6,7 +6,7 @@
     -----------------------
     |         arch |status|
     -----------------------
-    |       alpha: | TODO |
+    |       alpha: |  ok  |
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index dd362b5cb638..17b84ea7769d 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -6,7 +6,7 @@
     -----------------------
     |         arch |status|
     -----------------------
-    |       alpha: | TODO |
+    |       alpha: |  ok  |
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b2c359b947f6..8fafbfabd1e5 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -41,6 +41,8 @@ config ALPHA
 	select HAVE_PAGE_SIZE_8KB
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
 	select GENERIC_IRQ_PROBE
diff --git a/arch/alpha/include/uapi/asm/perf_regs.h b/arch/alpha/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..b6d2dcf6e184
--- /dev/null
+++ b/arch/alpha/include/uapi/asm/perf_regs.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_ALPHA_PERF_REGS_H
+#define _ASM_ALPHA_PERF_REGS_H
+
+/*
+ * Indices 0-30 match the hardware (and DWARF) register numbers.
+ * r9-r15 are not saved in pt_regs and cannot be sampled.
+ */
+enum perf_event_alpha_regs {
+	PERF_REG_ALPHA_R0,
+	PERF_REG_ALPHA_R1,
+	PERF_REG_ALPHA_R2,
+	PERF_REG_ALPHA_R3,
+	PERF_REG_ALPHA_R4,
+	PERF_REG_ALPHA_R5,
+	PERF_REG_ALPHA_R6,
+	PERF_REG_ALPHA_R7,
+	PERF_REG_ALPHA_R8,
+	PERF_REG_ALPHA_R9,
+	PERF_REG_ALPHA_R10,
+	PERF_REG_ALPHA_R11,
+	PERF_REG_ALPHA_R12,
+	PERF_REG_ALPHA_R13,
+	PERF_REG_ALPHA_R14,
+	PERF_REG_ALPHA_R15,
+	PERF_REG_ALPHA_R16,
+	PERF_REG_ALPHA_R17,
+	PERF_REG_ALPHA_R18,
+	PERF_REG_ALPHA_R19,
+	PERF_REG_ALPHA_R20,
+	PERF_REG_ALPHA_R21,
+	PERF_REG_ALPHA_R22,
+	PERF_REG_ALPHA_R23,
+	PERF_REG_ALPHA_R24,
+	PERF_REG_ALPHA_R25,
+	PERF_REG_ALPHA_R26,
+	PERF_REG_ALPHA_R27,
+	PERF_REG_ALPHA_R28,
+	PERF_REG_ALPHA_GP,
+	PERF_REG_ALPHA_SP,
+	PERF_REG_ALPHA_PC,
+	PERF_REG_ALPHA_MAX,
+};
+
+#endif /* _ASM_ALPHA_PERF_REGS_H */
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 4ea5c189e60e..0c04b89676ed 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PCI)	+= pci.o pci_iommu.o pci-sysfs.o
 obj-$(CONFIG_SRM_ENV)	+= srm_env.o
 obj-$(CONFIG_MODULES)	+= module.o
 obj-$(CONFIG_PERF_EVENTS) += perf_event.o
+obj-$(CONFIG_HAVE_PERF_REGS) += perf_regs.o
 obj-$(CONFIG_RTC_DRV_ALPHA) += rtc.o
 obj-$(CONFIG_AUDIT)	+= audit.o
 
diff --git a/arch/alpha/kernel/perf_regs.c b/arch/alpha/kernel/perf_regs.c
new file mode 100644
index 000000000000..33ea2e831ba0
--- /dev/null
+++ b/arch/alpha/kernel/perf_regs.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bits.h>
+#include <linux/perf_event.h>
+#include <linux/sched/task_stack.h>
+#include <asm/perf_regs.h>
+
+#define REG(idx, field) \
+	[PERF_REG_ALPHA_##idx] = offsetof(struct pt_regs, field)
+
+#define REG_RESERVED	(~GENMASK_ULL(PERF_REG_ALPHA_MAX - 1, 0) | \
+			 GENMASK_ULL(PERF_REG_ALPHA_R15, PERF_REG_ALPHA_R9))
+
+static const unsigned int pt_regs_offset[PERF_REG_ALPHA_MAX] = {
+	REG(R0, r0),	REG(R1, r1),	REG(R2, r2),	REG(R3, r3),
+	REG(R4, r4),	REG(R5, r5),	REG(R6, r6),	REG(R7, r7),
+	REG(R8, r8),	REG(R16, r16),	REG(R17, r17),	REG(R18, r18),
+	REG(R19, r19),	REG(R20, r20),	REG(R21, r21),	REG(R22, r22),
+	REG(R23, r23),	REG(R24, r24),	REG(R25, r25),	REG(R26, r26),
+	REG(R27, r27),	REG(R28, r28),	REG(GP, gp),	REG(PC, pc),
+};
+
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	if (idx == PERF_REG_ALPHA_SP) {
+		if (user_mode(regs))
+			return user_stack_pointer(regs);
+		/*
+		 * Software events built by perf_fetch_caller_regs() use a
+		 * per-CPU pt_regs rather than a trap frame, and pt_regs has
+		 * nowhere to record sp, so report none.
+		 */
+		if (!object_is_on_stack(regs))
+			return 0;
+		/* Same kernel sp approximation as stacktrace.c. */
+		return (unsigned long)(regs + 1);
+	}
+
+	if (WARN_ON_ONCE((u32)idx >= PERF_REG_ALPHA_MAX ||
+			 BIT_ULL(idx) & REG_RESERVED))
+		return 0;
+
+	return *(unsigned long *)((void *)regs + pt_regs_offset[idx]);
+}
+
+int perf_reg_validate(u64 mask)
+{
+	if (!mask || mask & REG_RESERVED)
+		return -EINVAL;
+
+	return 0;
+}
+
+u64 perf_reg_abi(struct task_struct *task)
+{
+	return PERF_SAMPLE_REGS_ABI_64;
+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi = perf_reg_abi(current);
+}

-- 
2.55.0

