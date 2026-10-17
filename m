Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ABD38B12D
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202184; cv=none; b=ADJsAcZ9PAdFsDdWya8SzKq7Wtst1L74b4BOO1hFTgjb4yCqZDin8/+eSkOyO8U83pi2t3N80taX1k76H7RTTnu8EQgj1mcS0UnIM0OoptRsqx3SgfU1k+pNvX7XYINE3XtqaMrPACP0JEg8ixWDcKlbQhyDv3gjvMl2aV8RSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202184; c=relaxed/simple;
	bh=0sfPDDT0jECZIMZZ9J0nFJ+B721wObM7DqWeHH9xcrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arWY8NbnEm9Zf1f1siUcCcdrl6abEXZ5KK0ehn+hAAEo2r20x0rpKpgNQT15mzFhhLIiDW+K0BD+MdvV4LMPyP5MqLgMtwScD+VgJhGexDwwuIAjkLrTYPcYHXt5LXbYdh4R1y+AG5/YqvJBy/oSJe990BCKl+mDZYtAyCUNlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScACKjkJ; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScACKjkJ"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-677bc4704cbso559232d50.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792202181; x=1792806981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQsk+DrjtKX2noPiCRNVvYKJ7WY0cqf+gtD3vyGOBkg=;
        b=ScACKjkJzCzHGy/9ydwQSyLBsKOCu0Pdi6uFaYGpgjpxFf7YPP3c4XpaBqeLwqGxSy
         jVjQUdFvguiTPq7kVDWbV835dLpwuCZYYhtpQ9Sx1mHJvUQUUmljuiXKzL3Pkhjcs/35
         q9dcfa+kVYHxlPLIvf0eeGxnj4BIw4tr6RaDtznImBNx6G9cto2eEYJjEua88waUW0p4
         +ax/rrHw4ooPIKJN5hOvUdjVRMV51IAJGb6DFnSpaYWunXnqaYF/tInfrOP0CROd46S8
         8hQNpa6QZAy4GGQnwm6RDQHFCb+CUoPSTXbPV1IqfYFhUE3vgVbO1sW24bsIn5in9HQL
         Rv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792202181; x=1792806981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQsk+DrjtKX2noPiCRNVvYKJ7WY0cqf+gtD3vyGOBkg=;
        b=CI6QUdPwT4YUk5CrFfFT4EGtorb0u7K30jlLx5X6692Lvt9sy4XS/T5JImS1zl/rKX
         IK3IeXVaQieJCwdzItO+ezBphQXNUrrFsZs/g/QAggoWS+HPOnWzOynphJ1Bvli8ZnEz
         XIXoyPr7eIkuA64eT/S/DMJJsQ6251tf4kiH60bN9mSYTC60dhd95yU4wChdrwng5ryl
         cEitbcWa5mGmo1hOai5UCXSVNFkLK9fQvaAeyEy0vj1bpjyr8ZCXdnox7K8rWyV1kBJW
         HfSjVp4k+/kuCliqG3uRFGQuIefLUPRqkJx/eCz1fmSeLchDSs3S1gYL4z6GO1w9DZxk
         nlcA==
X-Forwarded-Encrypted: i=1; AKwUvBxN5vNcvbxJR7le1g3Hoa2YFwd7ujFgl3jC0E1GtaOO1PBVlksFfVazPZYP3HroMVNgmCghMrAOd26QjZn8wRif@vger.kernel.org
X-Gm-Message-State: AFq9FYKHcgMnELFnhVVBQmCQGfLO7Fxt34MZEwd9+d9dVN/PUw6xRXpf
	T2v8YbASn/jR2KVnvoJtdVTONmGnHjfoFTke+lftFBx2QSIul7w13JOH
X-Gm-Gg: AYBFou19XrJChQpDeGEr5mmRDDzCaA8Fc6+Phl0/oa8t3Pp79x9grXwIDZDupO+9dD7
	T4ZSh+eX6WejWSW5sxTcuLnQUREFvFG/k3LjrEz32IylVOefnqE0++sJ+ZDJ0azr+FmrUnvnwbz
	I97FqG+aGnlAIzV/Pz0p48drl7R+wy5pT9SBEiqp6wKduGqMogK/82N3A6AkaR77ErM7rDcnKaf
	LpAA76RLXHtzil4QGxWKvaEB8Kp5QnZYk7G+Go/69dbWpSPKb6Xw18a1umL7dv2VE2lPtlYnR6w
	s1lQFXQjkcHQ/UGWPQNUakZ7LzzEcoBIZcIwiSTjVVMjMsp8jVQpsvWrqIHERwMSehtLFkNj9vI
	CKvkdNn+MdPhcn/0+rQJKF1EDSiZ0UJNF6sSarCAwCmfD4t30tEh8f17xvRrwxf4W2GHAGEcqIz
	Btjzt6SjRz5JbKPQZ2m8bwutqBwnxM0lfRrPkVIzPQ4cwUHDK9jChIMBpDxO+ORgojysyxFsVw/
	O+h9m8UrjxjKEHeSP88md6tjnc4F+qfV4uHRtBZwaZhaTbzYcyB1e3hMNqYKRdQ8NYa0d8SqWmh
	06pnNy+sDdg10i0i1vvBjbgig0y6oWqZEAtiNh/V8gddk4eaXzUu2xnIjsEejuL/o33+XNxM30P
	XVu2qTIjeALt6Xh9duQKPXUeU80RiGcE=
X-Received: by 2002:a05:690e:4184:b0:679:8f96:ee34 with SMTP id 956f58d0204a3-679ca572478mr317726d50.22.1792202181284;
        Fri, 16 Oct 2026 18:56:21 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58d93a0sm16403857b3.23.2026.10.16.18.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:56:19 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 16 Oct 2026 21:55:50 -0400
Subject: [PATCH v2 4/5] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-alpha-perf-regs-v3-v2-4-17654742226a@gmail.com>
References: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
In-Reply-To: <20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6937; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=0sfPDDT0jECZIMZZ9J0nFJ+B721wObM7DqWeHH9xcrk=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIuXV1cHabXfPv/wXlZq7fs/RC+psz6NZ/GZi3p0+/ij
 99YeenR+Y6PLAxiXAwzxRRZ4tYrssxq27HU57T0L5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 zxDI0DGKh8jpMWhkFheXphbpphUUOeTllySWZObnFevlF6TmFaQX6KVlppVkZOQXFacCjdDLSy0
 xdXV0MzI0MLF0tDBzsnA0NXF2djJ0cnN0dHZ1MrI0NzFwtnQ0cbU0Z+DiFIC55pMxI8P7pj9rRV
 qZbRfXLGe69Ezk9eV8XnOP9qlr25OiJu9LyL7JyLB11g5H/z3/17CuOBU2/+ejjMvbP/E+OK916
 PmZCwLM2634AA==
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
index 000000000000..da96a31b12fb
--- /dev/null
+++ b/arch/alpha/include/uapi/asm/perf_regs.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_ALPHA_PERF_REGS_H
+#define _UAPI_ASM_ALPHA_PERF_REGS_H
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
+#endif /* _UAPI_ASM_ALPHA_PERF_REGS_H */
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

