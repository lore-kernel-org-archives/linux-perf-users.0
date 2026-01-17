Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416E329C6C
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627795; cv=none; b=d7kGpekjdc4pM1Cc39VU2PovJolAM+jDuPxnrL7ze0o2ktoK+NdcBCEcgh7VLsHNw5Jjvxrf/CbbGU52ffDP3gCnoscFmqA4VcJiS6vcAkI6VcY30ykMPV5K15SoHsoapvkSmJCSE51tt2OsR0XrnZAsnz6cOuxy0KxMdvHzy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627795; c=relaxed/simple;
	bh=JGRW69Ebv9XpmUXKYhV6JdipsoyGaj5JSbeie+Z5J8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dgeBCCw7UFb/4c4lpYrO2nOZ/7hE5C+VLU5x5pOH+2OSRnRdENGE4KAoXIv4R1jk31gAz90h7Tj2TIjOWQ6k8sI/vFak8JNEChJdFetCDHrE6Z/QbRKdKTJQV3RyLjbtrxKsApRqJ0+SeUHSW4zyrBTJonL8VRXc6mMkdm5E/QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3IgMpwN; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3IgMpwN"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b6a8b32fa9so10173601eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627787; x=1769232587; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHsNO/7z8jjFX1Qc/WXEy+tfgyKsRWXmvXzihFXmRbQ=;
        b=Y3IgMpwNzeTtx4sNdwCF7CDGAlcZteG2gEWoeDrmfKZzJrNhjKPfo6LNT023FAdg8X
         nhrRKVcPnn9SmHto8elHJcEja/TGEM3mqvPcF5UjuU4qsta1tb+nNHLbrdErSySml4W/
         +jVZbynwySmnpqz6mXiIIdikdAgfn6hd0UdBCfRDGf8B23JYFZXvRQr8ka+hm8425tY8
         B0K+EF9yDAK0L8TKz+kimu+GRrfm51/BMfG20UjmppKQp0jypsMMwmFYdt5CoxpA5Xx6
         Yv3UKjdFNtmDHtoveWMg6o+R1jMWmAUohnbCu9j+NR6cLOxK+OoQgZXgX+3U+Z6qmB4u
         PA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627787; x=1769232587;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHsNO/7z8jjFX1Qc/WXEy+tfgyKsRWXmvXzihFXmRbQ=;
        b=Rmltc3goYa1GissnsB5uWOnj7ubVollk+E/fKjqebkRDaVtSX5tRkruATybLy/EDMY
         AkF9wLxCpHogcmfU9ooJjBEMh3r5lO1xZyqyO7My/7P4XB5G0peG5F3yXuhKNDOQPMlX
         1uc/RB5jIvbwBphlvRz+E/2tZBUiwSzHZBubyOrzOkj3OHnlWZddQ9Zp26aBPxgZup09
         6VzHkvXKMa8v7oqqldXfN6Axc9rKPW7ivsM8HG0u+BFAU15PtbyAK8Q0hvdDDGcTWlIs
         1a4i+ecyDTFfy4EgYbGs4kk5cThezPJBC4OnO+JYBNFxeeCii9B5+vSkmO+ovEmtZ5NV
         i6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXTCWgdCzWh/F2fRprvlqZRR0gI3Y2n7fii2Bzu1mtfPnd1IOYUVBS7gao+OnKDt+OCXCrfNFL6ABNyRep4IG44@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFT/HLscRbRP1yQ/xnni5DhBHOafatg4e07jpoSalDdI+jvgR
	icTSrY65pg5CaRy9sjD8uiJjqZ8o1XHcMOS6G2rPe0ZoGp40jtCIHQu7GrmC1Hg8AAcftAC58K5
	yW2tRFZ3xgw==
X-Received: from dycue5.prod.google.com ([2002:a05:7300:85:b0:2b6:c560:337])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5787:b0:2ac:22ac:30
 with SMTP id 5a478bee46e88-2b6b4103759mr4377004eec.34.1768627786832; Fri, 16
 Jan 2026 21:29:46 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:41 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-16-irogers@google.com>
Subject: [PATCH v1 15/23] perf dwarf-regs: Add csky perf to dwarf register
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
unwind-libdw to be used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../util/dwarf-regs-arch/dwarf-regs-csky.c    | 58 ++++++++++++++
 tools/perf/util/dwarf-regs.c                  |  3 +
 tools/perf/util/include/dwarf-regs.h          |  2 +
 tools/perf/util/unwind-libdw-arch/Build       |  1 -
 .../unwind-libdw-arch/unwind-libdw-csky.c     | 78 -------------------
 tools/perf/util/unwind-libdw.c                |  5 +-
 tools/perf/util/unwind-libdw.h                |  1 -
 7 files changed, 64 insertions(+), 84 deletions(-)
 delete mode 100644 tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
index 86394ed46397..cb44b774f8d9 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
@@ -5,6 +5,10 @@
 #include <errno.h>
 #include <stddef.h>
 #include <dwarf-regs.h>
+// Ensure the V2 perf reg definitions are included.
+#undef __CSKYABIV2__
+#define __CSKYABIV2__ 1
+#include "../../../arch/csky/include/uapi/asm/perf_regs.h"
 
 #define CSKY_ABIV2_MAX_REGS 73
 static const char * const csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
@@ -66,3 +70,57 @@ int __get_csky_regnum(const char *name, unsigned int flags)
 
 	return __get_dwarf_regnum(csky_dwarf_regs_table_abiv1, CSKY_ABIV1_MAX_REGS, name);
 }
+
+int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags)
+{
+	static const int dwarf_csky_regnums[][2] = {
+		[PERF_REG_CSKY_TLS] = {-ENOENT, 31},
+		[PERF_REG_CSKY_LR] = {15, 15},
+		[PERF_REG_CSKY_PC] = {-ENOENT, 32},
+		/* TODO: PERF_REG_CSKY_SR */
+		[PERF_REG_CSKY_SP] = {0, 14},
+		/* TODO: PERF_REG_CSKY_ORIG_A0 */
+		[PERF_REG_CSKY_A0] = {2, 0},
+		[PERF_REG_CSKY_A1] = {3, 1},
+		[PERF_REG_CSKY_A2] = {4, 2},
+		[PERF_REG_CSKY_A3] = {5, 3},
+		[PERF_REG_CSKY_REGS0] = {6, 4},
+		[PERF_REG_CSKY_REGS1] = {7, 5},
+		[PERF_REG_CSKY_REGS2] = {8, 6},
+		[PERF_REG_CSKY_REGS3] = {9, 7},
+		[PERF_REG_CSKY_REGS4] = {10, 8},
+		[PERF_REG_CSKY_REGS5] = {11, 9},
+		[PERF_REG_CSKY_REGS6] = {12, 10},
+		[PERF_REG_CSKY_REGS7] = {13, 11},
+		[PERF_REG_CSKY_REGS8] = {14, 12},
+		[PERF_REG_CSKY_REGS9] = {1, 13},
+		[PERF_REG_CSKY_EXREGS0] = {-ENOENT, 16},
+		[PERF_REG_CSKY_EXREGS1] = {-ENOENT, 17},
+		[PERF_REG_CSKY_EXREGS2] = {-ENOENT, 18},
+		[PERF_REG_CSKY_EXREGS3] = {-ENOENT, 19},
+		[PERF_REG_CSKY_EXREGS4] = {-ENOENT, 20},
+		[PERF_REG_CSKY_EXREGS5] = {-ENOENT, 21},
+		[PERF_REG_CSKY_EXREGS6] = {-ENOENT, 22},
+		[PERF_REG_CSKY_EXREGS7] = {-ENOENT, 23},
+		[PERF_REG_CSKY_EXREGS8] = {-ENOENT, 24},
+		[PERF_REG_CSKY_EXREGS9] = {-ENOENT, 25},
+		[PERF_REG_CSKY_EXREGS10] = {-ENOENT, 26},
+		[PERF_REG_CSKY_EXREGS11] = {-ENOENT, 27},
+		[PERF_REG_CSKY_EXREGS12] = {-ENOENT, 28},
+		[PERF_REG_CSKY_EXREGS13] = {-ENOENT, 29},
+		[PERF_REG_CSKY_EXREGS14] = {-ENOENT, 30},
+		/* TODO: PERF_REG_CSKY_HI */
+		/* TODO: PERF_REG_CSKY_LO */
+		/* TODO: PERF_REG_CSKY_DCSR */
+	};
+	int idx = 0;
+
+	if (flags & EF_CSKY_ABIV2)
+		idx++;
+
+	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_csky_regnums) ||
+	    dwarf_csky_regnums[perf_regnum][idx] == 0)
+		return -ENOENT;
+
+	return dwarf_csky_regnums[perf_regnum][idx];
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index c472ec5e4d1a..7fa0930fd298 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -202,6 +202,9 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_AARCH64:
 		reg = __get_dwarf_regnum_for_perf_regnum_arm64(perf_regnum);
 		break;
+	case EM_CSKY:
+		reg = __get_dwarf_regnum_for_perf_regnum_csky(perf_regnum, flags);
+		break;
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 		return -ENOENT;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index a52df8d1b138..7780bc07e70e 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -108,6 +108,8 @@ int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
 
+int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags);
+
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
  * name: architecture register name
diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/unwind-libdw-arch/Build
index 79c3bbdc2dee..5fa1754fca8d 100644
--- a/tools/perf/util/unwind-libdw-arch/Build
+++ b/tools/perf/util/unwind-libdw-arch/Build
@@ -1,4 +1,3 @@
-perf-util-y += unwind-libdw-csky.o
 perf-util-y += unwind-libdw-loongarch.o
 perf-util-y += unwind-libdw-powerpc.o
 perf-util-y += unwind-libdw-riscv.o
diff --git a/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
deleted file mode 100644
index 2556d034c32a..000000000000
--- a/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
-
-#include <elfutils/libdwfl.h>
-#include "../arch/csky/include/uapi/asm/perf_regs.h"
-#include "util/unwind-libdw.h"
-#include "util/perf_regs.h"
-#include "util/sample.h"
-
-bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg)
-{
-	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
-	Dwarf_Word dwarf_regs[PERF_REG_CSKY_MAX];
-
-#define REG(r) ({						\
-	Dwarf_Word val = 0;					\
-	perf_reg_value(&val, user_regs, PERF_REG_CSKY_##r);	\
-	val;							\
-})
-
-#if defined(__CSKYABIV2__)
-	dwarf_regs[0]  = REG(A0);
-	dwarf_regs[1]  = REG(A1);
-	dwarf_regs[2]  = REG(A2);
-	dwarf_regs[3]  = REG(A3);
-	dwarf_regs[4]  = REG(REGS0);
-	dwarf_regs[5]  = REG(REGS1);
-	dwarf_regs[6]  = REG(REGS2);
-	dwarf_regs[7]  = REG(REGS3);
-	dwarf_regs[8]  = REG(REGS4);
-	dwarf_regs[9]  = REG(REGS5);
-	dwarf_regs[10] = REG(REGS6);
-	dwarf_regs[11] = REG(REGS7);
-	dwarf_regs[12] = REG(REGS8);
-	dwarf_regs[13] = REG(REGS9);
-	dwarf_regs[14] = REG(SP);
-	dwarf_regs[15] = REG(LR);
-	dwarf_regs[16] = REG(EXREGS0);
-	dwarf_regs[17] = REG(EXREGS1);
-	dwarf_regs[18] = REG(EXREGS2);
-	dwarf_regs[19] = REG(EXREGS3);
-	dwarf_regs[20] = REG(EXREGS4);
-	dwarf_regs[21] = REG(EXREGS5);
-	dwarf_regs[22] = REG(EXREGS6);
-	dwarf_regs[23] = REG(EXREGS7);
-	dwarf_regs[24] = REG(EXREGS8);
-	dwarf_regs[25] = REG(EXREGS9);
-	dwarf_regs[26] = REG(EXREGS10);
-	dwarf_regs[27] = REG(EXREGS11);
-	dwarf_regs[28] = REG(EXREGS12);
-	dwarf_regs[29] = REG(EXREGS13);
-	dwarf_regs[30] = REG(EXREGS14);
-	dwarf_regs[31] = REG(TLS);
-	dwarf_regs[32] = REG(PC);
-#else
-	dwarf_regs[0]  = REG(SP);
-	dwarf_regs[1]  = REG(REGS9);
-	dwarf_regs[2]  = REG(A0);
-	dwarf_regs[3]  = REG(A1);
-	dwarf_regs[4]  = REG(A2);
-	dwarf_regs[5]  = REG(A3);
-	dwarf_regs[6]  = REG(REGS0);
-	dwarf_regs[7]  = REG(REGS1);
-	dwarf_regs[8]  = REG(REGS2);
-	dwarf_regs[9]  = REG(REGS3);
-	dwarf_regs[10] = REG(REGS4);
-	dwarf_regs[11] = REG(REGS5);
-	dwarf_regs[12] = REG(REGS6);
-	dwarf_regs[13] = REG(REGS7);
-	dwarf_regs[14] = REG(REGS8);
-	dwarf_regs[15] = REG(LR);
-#endif
-	dwfl_thread_state_register_pc(thread, REG(PC));
-
-	return dwfl_thread_state_registers(thread, 0, PERF_REG_CSKY_MAX,
-					   dwarf_regs);
-}
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 8f291f9f9469..a193163da707 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -292,7 +292,6 @@ static const Dwfl_Thread_Callbacks callbacks_generic = {
 	.set_initial_registers = libdw_set_initial_registers_generic,
 };
 
-DEFINE_DWFL_THREAD_CALLBACKS(csky);
 DEFINE_DWFL_THREAD_CALLBACKS(loongarch);
 DEFINE_DWFL_THREAD_CALLBACKS(powerpc);
 DEFINE_DWFL_THREAD_CALLBACKS(riscv);
@@ -300,9 +299,7 @@ DEFINE_DWFL_THREAD_CALLBACKS(s390);
 
 static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arch)
 {
-	if (!strcmp(arch, "csky"))
-		return &callbacks_csky;
-	else if (!strcmp(arch, "loongarch"))
+	if (!strcmp(arch, "loongarch"))
 		return &callbacks_loongarch;
 	else if (!strcmp(arch, "powerpc"))
 		return &callbacks_powerpc;
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index fe3ae2a768ad..ee56f1e827e5 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -9,7 +9,6 @@ struct machine;
 struct perf_sample;
 struct thread;
 
-bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg);
-- 
2.52.0.457.g6b5491de43-goog

