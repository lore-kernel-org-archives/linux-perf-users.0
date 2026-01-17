Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAF32E730
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627796; cv=none; b=E8pjcP7Wr4j84gqtYxMBVcCAI9jqH7EJQl4hwfkxD3qi/n4J0pVNnq/D189iaooz4WzKQBaRDGbCwKcBVeG+AGLZh+b/y5Ter09nmihO26yQRJQ+92NnEtY1WGPOh897f8YPcgwCOyLT7Wepceti4zcyxtaLtSOUFvLqOlOfjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627796; c=relaxed/simple;
	bh=xvrfmRGwN50DWc39nR8IudM0hWgXMsfj7kakQ4UFT3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V6dVB3/lqDy+VQAw7/MmyIktIs6pDboFN5Qh9mTFmWdmjNSH8PXkhuuVfLxBM+OnnHMFBVDikRF3HSaj7PBx2+wauFbntAty3jQFQNStPuOIrxH2ou6viPNkZMJucSF+NN9jnhpFwXiDVWfiu0KBe6n3LzLV5cuXtw5xKaV5XOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mA56SJad; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mA56SJad"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-123349958b2so11311634c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627791; x=1769232591; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYVgloMaIeMWmcnEWxnIXuJDky8ZiRg8gWqhum1bLc0=;
        b=mA56SJadBdtnWOFIURo+7nIIjZWkzNXrCee1UXz2Fq4eC2RpjTBT83NLssGMd5dnv+
         iyL58PCPxjLpnq5UvIJ88z5HyoYumi4jfKlEGeHGx1HZz/ar841mihn+UwkmAkqyirOF
         46rAZy7HiH+kYza3WLNnGaHrLQ5pHnL2eTQZt1lgbe7sQQdSwOjsJNg3Tf3jKQFuK6kl
         5gkGpNJPKuwXrt0SoLDf3b7ZH4WmlL/81+MkQ+zhYX1AfdRvz/tDwbw5Mvj3Pczw3ljh
         khe5n5b3y9a83pWEt5m1rWGhnc6KJ2jXj6O6oDz9nKq1t9SS56MWRH11lPYE8BNfEirB
         rsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627791; x=1769232591;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYVgloMaIeMWmcnEWxnIXuJDky8ZiRg8gWqhum1bLc0=;
        b=c1ToB76pX21Zk7fJJPzzmijdXf4P25FbGkGfdJ+hGvZF2xmL/LnSz9Z2IfEfLykxIX
         CAz/0K8tgopJpxQ437IcoXUoRKkxewRsAy8JEcKyzgSvc1GaTzYr9mUNrmJcOpSNadXs
         YfvyAOup/EO/sQwyoWo7ucSBkBoQgMgTHcpGDH/vVZnr3sb2dhC/kCzAKcDQNN/aI+hg
         TfIh8niJOZYYyWwM4UZ/WRDcdHrtZMbGw1rAESoK8djLRBVEHle5amAkguhjBV70Lm3/
         tdU1eoVz6lUrQsglrKUs4hLtM7APKmQV+UKM+5JCnJtV8P5FBXKiVrTbPJAYumdoEl+5
         YNLA==
X-Forwarded-Encrypted: i=1; AJvYcCUynUK6vwuGM9fdBdp6Ggn89TIzIG5IjoA6RFBZB09ByDemp6DlgD/Xqst5BEouyJJZxvP+fC5dvrGlGSKisC8f@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0t5wjEqY0HNcADc3SBczg6X+veQAvSN2LuBz6+7f/uPiEWQ5j
	ouE4T4N+ZbVkLcxcQRtHU/kh1grBTwvDaRoOeoeMw/nCyIvxiJzyNM6SB4EQRuQRIUZsbaut2k7
	GD7VCNNrd2g==
X-Received: from dlaj19.prod.google.com ([2002:a05:701b:2813:b0:119:49ca:6bae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6990:b0:11f:2c69:32
 with SMTP id a92af1059eb24-1244a717f0amr3961097c88.7.1768627790635; Fri, 16
 Jan 2026 21:29:50 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:43 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-18-irogers@google.com>
Subject: [PATCH v1 17/23] perf dwarf-regs: Add powerpc perf to dwarf register
 number mapping functions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

These functions allow the generic initial register state code in
unwind-libdw to be used. Note, the link register was being coped to
dwarf register 65 that the SysV ABI spec claims is FPSCR. It is
corrected here to 108, but this is unlikely to matter as FPSCR has
little to no impact on unwinding.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../util/dwarf-regs-arch/dwarf-regs-powerpc.c | 77 ++++++++++++++++++-
 tools/perf/util/dwarf-regs.c                  |  4 +
 tools/perf/util/include/dwarf-regs.h          |  1 +
 tools/perf/util/unwind-libdw-arch/Build       |  1 -
 .../unwind-libdw-arch/unwind-libdw-powerpc.c  | 76 ------------------
 tools/perf/util/unwind-libdw.c                |  5 +-
 tools/perf/util/unwind-libdw.h                |  1 -
 7 files changed, 82 insertions(+), 83 deletions(-)
 delete mode 100644 tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
index caf77a234c78..51892a09725b 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
@@ -4,8 +4,9 @@
  *
  * Copyright (C) 2010 Ian Munsie, IBM Corporation.
  */
-
+#include <errno.h>
 #include <dwarf-regs.h>
+#include "../../../arch/powerpc/include/uapi/asm/perf_regs.h"
 
 #define PPC_OP(op)	(((op) >> 26) & 0x3F)
 #define PPC_RA(a)	(((a) >> 16) & 0x1f)
@@ -59,3 +60,77 @@ void get_powerpc_regs(u32 raw_insn, int is_source,
 	if ((op_loc->mem_ref) && (PPC_OP(raw_insn) != 31))
 		op_loc->offset = get_offset_opcode(raw_insn);
 }
+
+int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum)
+{
+	static const int dwarf_powerpc_regnums[] = {
+		[PERF_REG_POWERPC_R0] = 0,
+		[PERF_REG_POWERPC_R1] = 1,
+		[PERF_REG_POWERPC_R2] = 2,
+		[PERF_REG_POWERPC_R3] = 3,
+		[PERF_REG_POWERPC_R4] = 4,
+		[PERF_REG_POWERPC_R5] = 5,
+		[PERF_REG_POWERPC_R6] = 6,
+		[PERF_REG_POWERPC_R7] = 7,
+		[PERF_REG_POWERPC_R8] = 8,
+		[PERF_REG_POWERPC_R9] = 9,
+		[PERF_REG_POWERPC_R10] = 10,
+		[PERF_REG_POWERPC_R11] = 11,
+		[PERF_REG_POWERPC_R12] = 12,
+		[PERF_REG_POWERPC_R13] = 13,
+		[PERF_REG_POWERPC_R14] = 14,
+		[PERF_REG_POWERPC_R15] = 15,
+		[PERF_REG_POWERPC_R16] = 16,
+		[PERF_REG_POWERPC_R17] = 17,
+		[PERF_REG_POWERPC_R18] = 18,
+		[PERF_REG_POWERPC_R19] = 19,
+		[PERF_REG_POWERPC_R20] = 20,
+		[PERF_REG_POWERPC_R21] = 21,
+		[PERF_REG_POWERPC_R22] = 22,
+		[PERF_REG_POWERPC_R23] = 23,
+		[PERF_REG_POWERPC_R24] = 24,
+		[PERF_REG_POWERPC_R25] = 25,
+		[PERF_REG_POWERPC_R26] = 26,
+		[PERF_REG_POWERPC_R27] = 27,
+		[PERF_REG_POWERPC_R28] = 28,
+		[PERF_REG_POWERPC_R29] = 29,
+		[PERF_REG_POWERPC_R30] = 30,
+		[PERF_REG_POWERPC_R31] = 31,
+		/* TODO: PERF_REG_POWERPC_NIP */
+		[PERF_REG_POWERPC_MSR] = 66,
+		/* TODO: PERF_REG_POWERPC_ORIG_R3 */
+		[PERF_REG_POWERPC_CTR] = 109,
+		[PERF_REG_POWERPC_LINK] = 108, /* Note, previously in perf encoded as 65? */
+		[PERF_REG_POWERPC_XER] = 101,
+		/* TODO: PERF_REG_POWERPC_CCR */
+		/* TODO: PERF_REG_POWERPC_SOFTE */
+		/* TODO: PERF_REG_POWERPC_TRAP */
+		/* TODO: PERF_REG_POWERPC_DAR */
+		/* TODO: PERF_REG_POWERPC_DSISR */
+		/* TODO: PERF_REG_POWERPC_SIER */
+		/* TODO: PERF_REG_POWERPC_MMCRA */
+		/* TODO: PERF_REG_POWERPC_MMCR0 */
+		/* TODO: PERF_REG_POWERPC_MMCR1 */
+		/* TODO: PERF_REG_POWERPC_MMCR2 */
+		/* TODO: PERF_REG_POWERPC_MMCR3 */
+		/* TODO: PERF_REG_POWERPC_SIER2 */
+		/* TODO: PERF_REG_POWERPC_SIER3 */
+		/* TODO: PERF_REG_POWERPC_PMC1 */
+		/* TODO: PERF_REG_POWERPC_PMC2 */
+		/* TODO: PERF_REG_POWERPC_PMC3 */
+		/* TODO: PERF_REG_POWERPC_PMC4 */
+		/* TODO: PERF_REG_POWERPC_PMC5 */
+		/* TODO: PERF_REG_POWERPC_PMC6 */
+		/* TODO: PERF_REG_POWERPC_SDAR */
+		/* TODO: PERF_REG_POWERPC_SIAR */
+	};
+
+	if (perf_regnum == 0)
+		return 0;
+
+	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_powerpc_regnums) ||
+	    dwarf_powerpc_regnums[perf_regnum] == 0)
+		return -ENOENT;
+
+	return dwarf_powerpc_regnums[perf_regnum];
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 033218f14b36..3b1c2a436806 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -205,6 +205,10 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_CSKY:
 		reg = __get_dwarf_regnum_for_perf_regnum_csky(perf_regnum, flags);
 		break;
+	case EM_PPC:
+	case EM_PPC64:
+		reg = __get_dwarf_regnum_for_perf_regnum_powerpc(perf_regnum);
+		break;
 	case EM_LOONGARCH:
 		reg = __get_dwarf_regnum_for_perf_regnum_loongarch(perf_regnum);
 		break;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index bec15fb53e73..9ebb3ba33fba 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -110,6 +110,7 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
 
 int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags);
 int __get_dwarf_regnum_for_perf_regnum_loongarch(int perf_regnum);
+int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum);
 
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/unwind-libdw-arch/Build
index 62a4cbf2dca8..e6c97e842cd6 100644
--- a/tools/perf/util/unwind-libdw-arch/Build
+++ b/tools/perf/util/unwind-libdw-arch/Build
@@ -1,3 +1,2 @@
-perf-util-y += unwind-libdw-powerpc.o
 perf-util-y += unwind-libdw-riscv.o
 perf-util-y += unwind-libdw-s390.o
diff --git a/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
deleted file mode 100644
index 1560db45e7b4..000000000000
--- a/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
+++ /dev/null
@@ -1,76 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <elfutils/libdwfl.h>
-#include <linux/kernel.h>
-#include "../arch/powerpc/include/uapi/asm/perf_regs.h"
-#include "util/unwind-libdw.h"
-#include "util/perf_regs.h"
-#include "util/sample.h"
-
-/* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
-static const int special_regs[3][2] = {
-	{ 65, PERF_REG_POWERPC_LINK },
-	{ 101, PERF_REG_POWERPC_XER },
-	{ 109, PERF_REG_POWERPC_CTR },
-};
-
-bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg)
-{
-	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
-	Dwarf_Word dwarf_regs[32], dwarf_nip;
-	size_t i;
-
-#define REG(r) ({						\
-	Dwarf_Word val = 0;					\
-	perf_reg_value(&val, user_regs, PERF_REG_POWERPC_##r);	\
-	val;							\
-})
-
-	dwarf_regs[0]  = REG(R0);
-	dwarf_regs[1]  = REG(R1);
-	dwarf_regs[2]  = REG(R2);
-	dwarf_regs[3]  = REG(R3);
-	dwarf_regs[4]  = REG(R4);
-	dwarf_regs[5]  = REG(R5);
-	dwarf_regs[6]  = REG(R6);
-	dwarf_regs[7]  = REG(R7);
-	dwarf_regs[8]  = REG(R8);
-	dwarf_regs[9]  = REG(R9);
-	dwarf_regs[10] = REG(R10);
-	dwarf_regs[11] = REG(R11);
-	dwarf_regs[12] = REG(R12);
-	dwarf_regs[13] = REG(R13);
-	dwarf_regs[14] = REG(R14);
-	dwarf_regs[15] = REG(R15);
-	dwarf_regs[16] = REG(R16);
-	dwarf_regs[17] = REG(R17);
-	dwarf_regs[18] = REG(R18);
-	dwarf_regs[19] = REG(R19);
-	dwarf_regs[20] = REG(R20);
-	dwarf_regs[21] = REG(R21);
-	dwarf_regs[22] = REG(R22);
-	dwarf_regs[23] = REG(R23);
-	dwarf_regs[24] = REG(R24);
-	dwarf_regs[25] = REG(R25);
-	dwarf_regs[26] = REG(R26);
-	dwarf_regs[27] = REG(R27);
-	dwarf_regs[28] = REG(R28);
-	dwarf_regs[29] = REG(R29);
-	dwarf_regs[30] = REG(R30);
-	dwarf_regs[31] = REG(R31);
-	if (!dwfl_thread_state_registers(thread, 0, 32, dwarf_regs))
-		return false;
-
-	dwarf_nip = REG(NIP);
-	dwfl_thread_state_register_pc(thread, dwarf_nip);
-	for (i = 0; i < ARRAY_SIZE(special_regs); i++) {
-		Dwarf_Word val = 0;
-		perf_reg_value(&val, user_regs, special_regs[i][1]);
-		if (!dwfl_thread_state_registers(thread,
-						 special_regs[i][0], 1,
-						 &val))
-			return false;
-	}
-
-	return true;
-}
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 9c8dad643cd0..e9ba050e7ab1 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -292,15 +292,12 @@ static const Dwfl_Thread_Callbacks callbacks_generic = {
 	.set_initial_registers = libdw_set_initial_registers_generic,
 };
 
-DEFINE_DWFL_THREAD_CALLBACKS(powerpc);
 DEFINE_DWFL_THREAD_CALLBACKS(riscv);
 DEFINE_DWFL_THREAD_CALLBACKS(s390);
 
 static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arch)
 {
-	if (!strcmp(arch, "powerpc"))
-		return &callbacks_powerpc;
-	else if (!strcmp(arch, "riscv"))
+	if (!strcmp(arch, "riscv"))
 		return &callbacks_riscv;
 	else if (!strcmp(arch, "s390"))
 		return &callbacks_s390;
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index 9d177d70f15c..0ec1abdabbe7 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -10,7 +10,6 @@ struct perf_sample;
 struct thread;
 
 bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
-bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
 
-- 
2.52.0.457.g6b5491de43-goog

