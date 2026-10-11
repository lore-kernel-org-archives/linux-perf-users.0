Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261F361961
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751050; cv=none; b=itaTPoXajKYLdydzRaELIim3YFap1UdbU6WcHsiVYk5XGGgZSB9uyy4RDJeYhkuHjmijuFZ48gQLIOleLTu6UjY/II3K6tD3viQ5RUlRC1BWPRsbsiEO/TueGuz61w09BP/zBgikD2ygcetjPn9cdYCTzsZS1t62VX0Vsmlln+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751050; c=relaxed/simple;
	bh=GqxR9gNOB18oNI7VGb/lK4F6CxWjz8h4zrcF4QPTtn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ohv8K8Fz477oABEIS96YA98BjpXW9QXcT7KZGC9b9cykRpZw1to/2Am3N1HWYZJ141zF8OQA+jMt/V4ifiqTdgY4UVJD+1oWWxKFB+w4sYQujgVS4Ry2k4fuV/YIBYZhJn6BdZZIYzQtdJo2kmaYTHfPrNGs6gzql8fhC25eLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOV288Ug; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOV288Ug"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ae9bc9a2fcso25971387b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791751047; x=1792355847; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2j8G9aHSjP36yNVlwzumqBCueTgcinKhTiJknp+vEIc=;
        b=AOV288UgHaT/nLCcdjdAXHHMItRTCkY/spKPA+e03RxSdt8hjXxH0rFu8D7j8NwruQ
         fAnPAK4yB23R3nyuHMOIRV6qjhBB0wuiYchPy2cQFtJGHQhXj7HddRCJKRDL71N3/7G/
         DoBOloLCGRj8fq1M+8fwBdlvxa476pdWx8KmyQPk1OcDZKP7oDm0S6jk0J+iggX8Y8wn
         81IbVIZE7mLXTAspHbKe3DLrHM6+ZwbLASx+hwNm72kBN9T4fFWy+WlAiQ92vJFidcU0
         tf4tuleZxAgMTnFhVJLOkD7T72HiycOUxmq6m0GdI0JZ7JtzEDNUQPlyi4+HY/CFAVgj
         aBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791751047; x=1792355847;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2j8G9aHSjP36yNVlwzumqBCueTgcinKhTiJknp+vEIc=;
        b=ID+POGnOjAvLl5WkISAcaHq4QW3f0YVJCSeLTyUjZzMi2HsZ01F+30T2eCxwDxFsIN
         hoPMorgy5vXQ8l/lOZk4ue4tGEf59Y4attWSeSNYjVlpK0CXkLi8hfoviZeNbdCtLpnQ
         Fg5J0mVWa0Guhv8lwY5UUlmMfe3IvkKZL6JkNvh7oWS3kqgtiMWgXKSghCvLv7Um9Ecs
         BF1tt3AWudeidjtHi0wg1bv2NmEtqVkzGjFsqSBW/yY8wPSuIjukazyq/rbr1pzCSUTP
         ux8Bc1vMl5QloI4gMkKC5kHMn8cWo3gJVrawr7m+Gkc8pY/1MQ6HtTChNdyztraRx4Is
         YKsg==
X-Forwarded-Encrypted: i=1; AKwUvBwEB32/IynxSsen9LnPmfUCcdFkoYFTbD2W5c8Htjgz9q23pEeKvBOTD3uyKw2TDpsprdhv+XedlZEw231fu/7t@vger.kernel.org
X-Gm-Message-State: AFq9FYLKf66GeXc/kpKyiJTpmMeYMpgqU4cxQ9xOIaeMMpxRj4kG1EXb
	3tRYiqCQYZpE3PfO3/DBOqdllC5z4sCHjCrIMlNSSG1H0SewU+wvItVa
X-Gm-Gg: AYBFou1/sb54Az0My248GpMJ4mNBPQ+Qoaa4M3M/fLnvbPJq/4CatkwlPk+0TAchi9j
	xqvLdxdyHzyBJ3mRmaqMsfsw/gRmgu/6ulh/Uj6UqQ3kQhqYyAUZvzN2XtdblhsDETMzFeEJkiN
	g9xOSWH6KPHyK7m/lfrvMdKNYaVIvZvtIdZBqGFs4AB89E5SqXgSJaA65J70Ve0g4IhmWizPLzC
	rQNLCCBUrbskwtzgbY+EXYHdsaPpKgL3bgTu0/d8doukIOjPV5x1dGuTyWmiMdMm37puRsFoNd3
	iRkAM0A4BqMITBNZhK/fxq+OoxNzW2iWkTY2jeS9S7g7gPcno11dZChA4EyVze5ChO8ktnHvxWR
	kGWVmSIisGOAn83RaNPszORGmFdqf19stNS+SZ7oAdlJ7XYBMwuW+eQF/WXyo4F6Px4FXfJ1awX
	wn+gbCBGyZFJ8P1gSWliSgmIgdwcX0c0kd5sevTJH0fQryRHNdCDyrc121Ob1Tt9j3hfKPO61tn
	ZkbmAZrkPXZ0VJdjhN0LRaFsiC1HtUfvnKWgQwjh7fDVp06hcWk84A+
X-Received: by 2002:a05:690c:281:b0:80e:dc2:873b with SMTP id 00721157ae682-8b07ed55d68mr25749927b3.16.1791751046028;
        Sun, 11 Oct 2026 13:37:26 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07ed0b54asm27861707b3.0.2026.10.11.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 13:37:24 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 11 Oct 2026 16:37:24 -0400
Subject: [PATCH] perf regs: Add alpha support
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-alpha-perf-tools-regs-v1-1-2a5940e22548@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNtERWvIg6lphoQWxIRQXp3i
 +Mb/n9BSZgUpuYFoZuV01lh2wbC7s+NkNdqcMb11hiL/si7x0wS8UrpUBTaFIMzvR+7lcIQobZ
 ZKPLzf+ellA8e82DjZwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10666; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=GqxR9gNOB18oNI7VGb/lK4F6CxWjz8h4zrcF4QPTtn4=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJOf25+c/CMhVvL6dOMpRqtao6xrKtfa8mVu07fm3jF0
 UR7+p65HR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNuirDf3ejGNmEK8
 lrdFRO3ROTsqya8vKgx5L7n7bN/b61LGnljy2MDP9XP9p/uveB2SNWrf6vYn/O8+rybWC/xp71e
 fG38lJ/fg4A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Add the alpha perf register tables so that -I/--user-regs and
--call-graph dwarf work.

r9-r15 cannot be sampled and are left out of the mask. Perf register
numbers 0-30 are the DWARF numbers. The pc is DWARF 64, the column GCC
uses as the alternate return address column on alpha, so libdw's
frame_nregs is 65.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
This depends on the kernel side, "alpha: add HAVE_PERF_REGS and
HAVE_PERF_USER_STACK_DUMP support", posted as part of:

https://lore.kernel.org/r/20261011-alpha-perf-regs-v3-v1-0-3354d135d972@gmail.com

--call-graph dwarf also needs libdw alpha unwinding support (abi_cfi
and frame_nregs), which I am sending to elfutils-devel separately.
Without it, libdw rejects the thread and perf reports the error;
-I/--user-regs work regardless.
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

