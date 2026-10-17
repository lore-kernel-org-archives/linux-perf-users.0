Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770CF386C3D
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 02:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202583; cv=none; b=uzm262qQr/h/e8LxCHz1FXMblxNJcGCYChM5rJw57UzhFn54+N7C9Ne34NyREqBXAA0tc+cixp9ltMhskagcvCu33zKHxXAMIwI/6xpOz97FQ8rfqaR/Q9JKul0SF7hQie6NjMbqNicEiWFPYcwE+lD20+pr+T5p0NidzI3prDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202583; c=relaxed/simple;
	bh=AHey/6lsxOZgUyUpkCoO7mTK7r5tQADZWQsfBWOrKB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fm3yDeEFEKg/R24Yanld+Cxg2hSt6G3F5xWpE+fnK5hTAntQm1CHuQPtqkXWvo1eeKKrUa5Avp3YFIFsR6NG1jd92FtzWf6NaJ/d74bfodJ7x5R3/lGSaJ7wevmYBjUSkh8/YgI3OGntrVD9l2stRakAi78tTCLaFp42eb+0n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC9uN1a2; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC9uN1a2"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0a28a720aso4188287b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 19:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792202580; x=1792807380; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=03JppcS9M69F8GKXR0PtGVJjkl3ix0qS7Ai7xdxnVkQ=;
        b=NC9uN1a2IK0BrClEEx4XP5pI9mJMol2wA/ozzUk0xdbA10xkM1QB+Scix/CS2QqitI
         UA+YtewmHOKl+p5qGtNl0HmWTMG/NFVcl4PHH7oIz1sQWIG6Zg55IP1kHJH7kTALdRJ0
         UPdqKnOcY6ZthDhyimtnKEsVl0WNnYrSTZcIK4XhOnB82NDq6Bfmev2JpUE3atkcxuk3
         yqMRjEX1rXuiRGFSLHrpURlvMc0DDF+6jLAkTfF2eTns1NXYSMs/k3MFUH4hY/TNsAxY
         L8cs7HhtjjtMGSK4g41PQd2Q/k6Oux7NZcWievi/J6jZ1s3qCz9/4m3VuQT0ZOXFWlof
         iWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792202580; x=1792807380;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=03JppcS9M69F8GKXR0PtGVJjkl3ix0qS7Ai7xdxnVkQ=;
        b=Rc0s835IcYDQByox3G/vMw7qozHAk5A0DluV/AwdPUrjF6fT4hYlLluIp1s+pnPXQX
         o2OyLyrCk2r1HNzrSHiRYtGUntDWaa1r8bB/T3ikQ8x3PEf+OkM/x495bvHJdRApxT6V
         g3Xfou3c0MYsTa1sLRmOjN88QMbejQJ0RLCDPWDRFKQKKpUtcuFFCxClkh6ceALu8H6T
         gtqYbH3qUU3mb6YXnIB2DhmydAJEkUwDsV8HVZZGA4VZ07wOY4RbjnWVu8xERmf8lCo9
         8TnsRm9onuYcyW5cfMhGhuis0O1wUueMBRTlSndjZaUjf52muUcikr4KpWZVxvFemH4v
         lCgA==
X-Forwarded-Encrypted: i=1; AKwUvBxG5jS1GXRiJ+aATjnNav0mKkNp2Ke+EXkPBQ8QHiaxPTHSX5/4tqWJq6jZVHSJzfCJDFdzUqNrLjUTUNu9F09i@vger.kernel.org
X-Gm-Message-State: AFq9FYKLeZwCwlivD/BH4Mx0+azpUwRm5yQYehHZINF1W4H73n4s6kWF
	txu7b/xGsZj3Ww7DGCOqPB9j2w+aT/TD90DVA2qIjQJtRyRtdshVUMfc
X-Gm-Gg: AYBFou28vux3gBzHkaYrd5KHSaBUa69Yji7cVE2hyIMFWHIhfRhM4NfykVfj61wNokq
	h6x431LrhhavNUblA7a3sM8qtEgqTjkH7goqgZ+k/5cXlDy0ybXJmjQ7UaV0FbAAaCa/GvERFFW
	wcDgIQlbn9aHYeHc7waYmtmxPvX3oO1ICU4q+dQAG1P8FhgS1qAKuePvCz80nZConWvpa/TxB0G
	TQr6P5MBa9vFnrR6lkewdtgno4GN5EQX2P1hOXZXdUA7pTAzzxlClr6Y/j4rSQnZBFGA/uAcQyV
	5iNYf2uaz3Y/KCvxk+E8zs/WWSZDiOuXp9h75KM72993g2LzJ2qX5F3wzv36to5BvUFWyIojlxZ
	RXnhHKaptmr1lzeFtxp6M1A+XK+BkhRdN5xaGh9rCPMKZ3XOH1w4QTU0WRoHZLdlgu20aES4Jg8
	SZzUkxO5RC22a2dQg0orQaAXbcnIJuzV25fJm/0SWyeTgMzeW/QXN5DmDicthNp7nhIT/lrCuea
	3hf0Vefibzj39roJg/+GPkMpUtqjtq9r1gLHLeLgd4wiaFrh0WTYhKJClLUXcfUZwMSq80ncYhV
	eOH3KNeS4IC+fbM1c8YIob7dF6AfxQ==
X-Received: by 2002:a05:690c:385:b0:8b0:cd30:ce6c with SMTP id 00721157ae682-8b0f21d0c90mr6969807b3.30.1792202580125;
        Fri, 16 Oct 2026 19:03:00 -0700 (PDT)
Received: from localhost (108-93-236-139.lightspeed.chtnsc.sbcglobal.net. [108.93.236.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58882c4sm16523587b3.13.2026.10.16.19.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 19:02:58 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 16 Oct 2026 22:02:54 -0400
Subject: [PATCH v2] perf regs: Add alpha support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-alpha-perf-tools-regs-v2-1-406c9628320a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQqDMBBFryKz7pRkUGu78h7FRYiTOKBGEpEW8
 e5Npdsu34P//g6Jo3CCR7FD5E2ShDkDXQqwg5k9o/SZgRTVWimNZlwGgwtHh2sIY8LIPqElVZu
 m7NneHOTtEtnJ6+w+u8yDpDXE93mz6a/9FfW/4qZRI5nqXiomqsqm9ZOR8WrDBN1xHB8i/Rcou
 gAAAA==
X-Change-ID: 20261001-alpha-perf-tools-regs-c206a84dec7f
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Magnus Lindholm <linmag7@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 linux-alpha@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11096; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=AHey/6lsxOZgUyUpkCoO7mTK7r5tQADZWQsfBWOrKB0=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIuXfcN1f3/4kjk6pNSj0wqjjSw6exXMfm+oXrOnt7Zk
 tlLTD9Yd3xkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1ZX8Y/ooI/p5o4r
 q8UvSb2H/GJbzWqS9XVhkVFYp6Zi7NeiXKM5+R4dsL2wvBzbve/Vy3/Zjsa+8zppLXl6z7eatlx
 bppxTf+HucHAA==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Add the alpha perf register tables so that -I/--user-regs and
--call-graph dwarf work.

r9-r15 cannot be sampled and are left out of the mask. Perf register
numbers 0-30 are the DWARF numbers. The pc is DWARF 64, the column GCC
uses as the alternate return address column on alpha, so libdw's
frame_nregs is 65.

Assisted-by: Claude:claude-opus-5-5
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
This depends on the kernel side, "alpha: add HAVE_PERF_REGS and
HAVE_PERF_USER_STACK_DUMP support", posted as part of:

https://lore.kernel.org/r/20261016-alpha-perf-regs-v3-v2-0-17654742226a@gmail.com

--call-graph dwarf also needs libdw alpha unwinding support (abi_cfi
and frame_nregs), which I sent to elfutils-devel:

https://inbox.sourceware.org/elfutils-devel/20261012-alpha-v1-0-46760216dfb7@gmail.com/

Without it, libdw rejects the thread and perf reports the error;
-I/--user-regs work regardless.
---
Changes in v2:
- No code changes.
- Fix the link to the kernel series, now pointing at its v2 (Ian).
- Link the elfutils posting.
- Collect trailers.
- Link to v1: https://lore.kernel.org/r/20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com
---
 tools/arch/alpha/include/uapi/asm/perf_regs.h      | 45 ++++++++++++++++++++++
 tools/perf/arch/alpha/include/perf_regs.h          | 16 ++++++++
 tools/perf/check-headers.sh                        |  1 +
 tools/perf/util/dwarf-regs-arch/Build              |  1 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-alpha.c | 14 +++++++
 tools/perf/util/dwarf-regs.c                       |  5 +++
 tools/perf/util/include/dwarf-regs.h               |  2 +
 tools/perf/util/perf-regs-arch/Build               |  1 +
 tools/perf/util/perf-regs-arch/perf_regs_alpha.c   | 34 ++++++++++++++++
 tools/perf/util/perf_regs.c                        | 13 +++++++
 tools/perf/util/perf_regs.h                        |  5 +++
 11 files changed, 137 insertions(+)

diff --git a/tools/arch/alpha/include/uapi/asm/perf_regs.h b/tools/arch/alpha/include/uapi/asm/perf_regs.h
new file mode 100644
index 000000000000..da96a31b12fb
--- /dev/null
+++ b/tools/arch/alpha/include/uapi/asm/perf_regs.h
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
diff --git a/tools/perf/arch/alpha/include/perf_regs.h b/tools/perf/arch/alpha/include/perf_regs.h
new file mode 100644
index 000000000000..409f3a08af9b
--- /dev/null
+++ b/tools/perf/arch/alpha/include/perf_regs.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include <linux/types.h>
+#include <linux/bits.h>
+#include "../../../../arch/alpha/include/uapi/asm/perf_regs.h"
+
+#define PERF_REGS_MAX PERF_REG_ALPHA_MAX
+
+/* The kernel rejects r9-r15. */
+#define PERF_REGS_MASK (GENMASK_ULL(PERF_REG_ALPHA_MAX - 1, 0) & \
+			~GENMASK_ULL(PERF_REG_ALPHA_R15, PERF_REG_ALPHA_R9))
+
+#endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 531c0e0e84df..9baf83f79e23 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -36,6 +36,7 @@ declare -a FILES=(
   "arch/x86/include/asm/msr-index.h"
   "arch/x86/lib/x86-opcode-map.txt"
   "arch/x86/tools/gen-insn-attr-x86.awk"
+  "arch/alpha/include/uapi/asm/perf_regs.h"
   "arch/arm/include/uapi/asm/perf_regs.h"
   "arch/arm64/include/uapi/asm/perf_regs.h"
   "arch/loongarch/include/uapi/asm/perf_regs.h"
diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
index ceb68ae86fd8..026b7b5ca895 100644
--- a/tools/perf/util/dwarf-regs-arch/Build
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -1,3 +1,4 @@
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-alpha.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm64.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-alpha.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-alpha.c
new file mode 100644
index 000000000000..50fd17096597
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-alpha.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <dwarf-regs.h>
+#include "../../../arch/alpha/include/uapi/asm/perf_regs.h"
+
+int __get_dwarf_regnum_for_perf_regnum_alpha(int perf_regnum)
+{
+	if (perf_regnum >= PERF_REG_ALPHA_R0 && perf_regnum <= PERF_REG_ALPHA_SP)
+		return perf_regnum;
+	if (perf_regnum == PERF_REG_ALPHA_PC)
+		return 64;
+
+	return -ENOENT;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 09aca6304002..3fd71787c658 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -185,6 +185,8 @@ static int get_libdw_frame_nregs(unsigned int machine, unsigned int flags __mayb
 		return 74;
 	case EM_MIPS:
 		return 71;
+	case EM_ALPHA:
+		return 65;
 	default:
 		return 0;
 	}
@@ -228,6 +230,9 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_MIPS:
 		reg = __get_dwarf_regnum_for_perf_regnum_mips(perf_regnum);
 		break;
+	case EM_ALPHA:
+		reg = __get_dwarf_regnum_for_perf_regnum_alpha(perf_regnum);
+		break;
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 		return -ENOENT;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 1da915c2683a..8d1a981ab8aa 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -105,6 +105,8 @@ int __get_dwarf_regnum_x86_64(const char *name);
 int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum, int abi);
 
+int __get_dwarf_regnum_for_perf_regnum_alpha(int perf_regnum);
+
 int __get_dwarf_regnum_arm64(const char *name);
 int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
diff --git a/tools/perf/util/perf-regs-arch/Build b/tools/perf/util/perf-regs-arch/Build
index be95402aa540..1fbc299775f7 100644
--- a/tools/perf/util/perf-regs-arch/Build
+++ b/tools/perf/util/perf-regs-arch/Build
@@ -1,4 +1,5 @@
 perf-util-y += perf_regs_aarch64.o
+perf-util-y += perf_regs_alpha.o
 perf-util-y += perf_regs_arm.o
 perf-util-y += perf_regs_csky.o
 perf-util-y += perf_regs_loongarch.o
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_alpha.c b/tools/perf/util/perf-regs-arch/perf_regs_alpha.c
new file mode 100644
index 000000000000..cb9c8a1cd74b
--- /dev/null
+++ b/tools/perf/util/perf-regs-arch/perf_regs_alpha.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../perf_regs.h"
+#include "../../arch/alpha/include/perf_regs.h"
+
+static const char * const alpha_reg_names[PERF_REG_ALPHA_MAX] = {
+	"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
+	"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
+	"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+	"r24", "r25", "r26", "r27", "r28", "gp", "sp", "pc",
+};
+
+uint64_t __perf_reg_mask_alpha(bool intr __maybe_unused)
+{
+	return PERF_REGS_MASK;
+}
+
+const char *__perf_reg_name_alpha(int id)
+{
+	if (id < 0 || id >= PERF_REG_ALPHA_MAX)
+		return NULL;
+
+	return alpha_reg_names[id];
+}
+
+uint64_t __perf_reg_ip_alpha(void)
+{
+	return PERF_REG_ALPHA_PC;
+}
+
+uint64_t __perf_reg_sp_alpha(void)
+{
+	return PERF_REG_ALPHA_SP;
+}
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index c8242b7e1db5..6eb5824f5521 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -43,6 +43,9 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine, int *abi /*inout*/)
 	uint64_t mask = 0;
 
 	switch (e_machine) {
+	case EM_ALPHA:
+		mask = __perf_reg_mask_alpha(/*intr=*/true);
+		break;
 	case EM_ARM:
 		mask = __perf_reg_mask_arm(/*intr=*/true);
 		break;
@@ -86,6 +89,9 @@ uint64_t perf_user_reg_mask(uint16_t e_machine, int *abi /*inout*/)
 	uint64_t mask = 0;
 
 	switch (e_machine) {
+	case EM_ALPHA:
+		mask = __perf_reg_mask_alpha(/*intr=*/false);
+		break;
 	case EM_ARM:
 		mask = __perf_reg_mask_arm(/*intr=*/false);
 		break;
@@ -129,6 +135,9 @@ const char *perf_reg_name(int id, uint16_t e_machine, uint32_t e_flags, int abi)
 	const char *reg_name = NULL;
 
 	switch (e_machine) {
+	case EM_ALPHA:
+		reg_name = __perf_reg_name_alpha(id);
+		break;
 	case EM_ARM:
 		reg_name = __perf_reg_name_arm(id);
 		break;
@@ -198,6 +207,8 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 uint64_t perf_arch_reg_ip(uint16_t e_machine)
 {
 	switch (e_machine) {
+	case EM_ALPHA:
+		return __perf_reg_ip_alpha();
 	case EM_ARM:
 		return __perf_reg_ip_arm();
 	case EM_AARCH64:
@@ -227,6 +238,8 @@ uint64_t perf_arch_reg_ip(uint16_t e_machine)
 uint64_t perf_arch_reg_sp(uint16_t e_machine)
 {
 	switch (e_machine) {
+	case EM_ALPHA:
+		return __perf_reg_sp_alpha();
 	case EM_ARM:
 		return __perf_reg_sp_arm();
 	case EM_AARCH64:
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index c9f461b6f11f..4134e4eed802 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -34,6 +34,11 @@ const char *__perf_reg_name_arm64(int id);
 uint64_t __perf_reg_ip_arm64(void);
 uint64_t __perf_reg_sp_arm64(void);
 
+uint64_t __perf_reg_mask_alpha(bool intr);
+const char *__perf_reg_name_alpha(int id);
+uint64_t __perf_reg_ip_alpha(void);
+uint64_t __perf_reg_sp_alpha(void);
+
 uint64_t __perf_reg_mask_arm(bool intr);
 const char *__perf_reg_name_arm(int id);
 uint64_t __perf_reg_ip_arm(void);

---
base-commit: bc01105ed65d15787b2eb93ac26e8624a2139e35
change-id: 20261001-alpha-perf-tools-regs-c206a84dec7f

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

