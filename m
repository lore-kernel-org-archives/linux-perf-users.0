Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988832F75F
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627798; cv=none; b=E6LwP+08Cjyzi6jr8EUf3FEtIZR2fqD3nVKmrKZyJvA/cRqsFA38eD92u8DxDVL80WL3SKQnnlXE9uZHWJ7hUygAuUVq2v7STRswfyUzS4VFGLKZnxO2WgiKfZhFz8R8RbBXNTVTgR1waXnJA5hdOzobZGS7g2fQm7iqbzIQFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627798; c=relaxed/simple;
	bh=BndAyPy+UuQw35OI1r1v6VocafXtrLbU/myQm8PBEEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JHvsVS/kutOAwq+Ih7y/KHiOI9iYeGMcRljL+V4MCJm+Evq8dN053785qVdqlJByGgw99NqdBtwRE9ZacWVz0Z9dBy/8OCzVXz3W8uWRcTlqzeKtYD/yDbPLnPmvlQtsbK7Mx5lzQrsOEx2tL7rcg9RACgJ3OY60qkr20zs9P5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkb8R172; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkb8R172"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1219f27037fso2973012c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627795; x=1769232595; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCYe3hHM7B67Bwgfqfhfq46zBLS+3DmzwV+DSyW0kMs=;
        b=gkb8R1724Kep7Vtwr/s2FggrCfe6LT3bSmUtucWLQQEo6zHJXwaYULE3p+EFyqIEJz
         IUXqU6HCB7vAPAC8G0IzE2S307UM4PFRvqH2VM/yL9p00t6GnHh5KX7s+mv+oVqnBjnY
         KCP4HhQtAK5ijLdAFxpx6fCi8Hrstj6Cvu5loGibNtvLfDEtRXqUEwRHRPTBOoume5eE
         83by83tCpg/tkFj7c55izJVIb05I1gYNY6lu20Kv0H7Gdq2FhewAsC8vOihoHT2VE/Gz
         Uno2yKrHpcYmaiNep/PU1fjd6mV1ZjAsxmxaNA9FCRsxdGlIXQLoIRRZAbD+XuGKAwww
         m6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627795; x=1769232595;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCYe3hHM7B67Bwgfqfhfq46zBLS+3DmzwV+DSyW0kMs=;
        b=cjM1ZyauHm4xh5Y9lRcwK8Pwi7trzhG7wDo9OYhJQdZdAfAk/wbE1bOxc1Qid31MMS
         AcV1A68PpY2/OCMaOT1UaKG8JTuhofJcgpTILGeAnDouJyANijpUH88K2Ek4l3kcA9rS
         mQaEFK6wEZCNbUGOi5VTzMm0O2pXyWXBh3I8YiqKIvJP7WKj22Sqb3g5nVZfNBNDyLCB
         O5S2TNxRFgBlaubucUYqD8SknukjA7Mzq1uYdjOL6G0xdoOdaAOhewPSMvMU0D70wEub
         IApBxjZcH/JGz/6gXZ6m5n/vIEtKyXMH0io9R7LBhj7D6mdinTni5psks9YbBXTDnBqV
         jKzA==
X-Forwarded-Encrypted: i=1; AJvYcCUcDSVQ/6dUQJlItym7upAfaZydwZNy0hsIKv6v3tBmmC7iX2IawK924HbvCmhIv7a9hyi/DhGOGSvfXRil7Anr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+PxIULZT8SeIj2pDNZ/E4Yga6wsF3D4MlwMM2NCbgrzLKJ6l
	Jk1jIiai0hfi84o55woN8C3KR7t6KwtUUg5lhkpmz7yT5dxJRV2ZQtI+TPo8rtLdT37JbJxz0xP
	6xrzgADCdYw==
X-Received: from dlbvv6.prod.google.com ([2002:a05:7022:5f06:b0:11b:1a9a:d2e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2387:b0:11b:c1ab:bdd4
 with SMTP id a92af1059eb24-1244a74fe9amr4162959c88.38.1768627794473; Fri, 16
 Jan 2026 21:29:54 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:45 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-20-irogers@google.com>
Subject: [PATCH v1 19/23] perf dwarf-regs: Add S390 perf to dwarf register
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
unwind-libdw to be used. Now the non-generic code in unwind-libdw has
no uses remove it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs-arch/Build         |  1 +
 .../util/dwarf-regs-arch/dwarf-regs-s390.c    | 53 +++++++++++++++
 tools/perf/util/dwarf-regs.c                  |  3 +
 tools/perf/util/include/dwarf-regs.h          |  1 +
 tools/perf/util/unwind-libdw-arch/Build       |  1 -
 .../unwind-libdw-arch/unwind-libdw-s390.c     | 65 -------------------
 tools/perf/util/unwind-libdw.c                | 31 ++-------
 tools/perf/util/unwind-libdw.h                |  1 -
 8 files changed, 62 insertions(+), 94 deletions(-)
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
 delete mode 100644 tools/perf/util/unwind-libdw-arch/Build
 delete mode 100644 tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c

diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
index 94e4dfceb4d1..10c2af3d933a 100644
--- a/tools/perf/util/dwarf-regs-arch/Build
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -4,4 +4,5 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-loongarch.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-riscv.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-s390.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
new file mode 100644
index 000000000000..310a37451bdc
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <dwarf-regs.h>
+#include "../../../arch/s390/include/uapi/asm/perf_regs.h"
+
+int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum)
+{
+	static const int dwarf_s390_regnums[] = {
+		[PERF_REG_S390_R0] = 0,
+		[PERF_REG_S390_R1] = 1,
+		[PERF_REG_S390_R2] = 2,
+		[PERF_REG_S390_R3] = 3,
+		[PERF_REG_S390_R4] = 4,
+		[PERF_REG_S390_R5] = 5,
+		[PERF_REG_S390_R6] = 6,
+		[PERF_REG_S390_R7] = 7,
+		[PERF_REG_S390_R8] = 8,
+		[PERF_REG_S390_R9] = 9,
+		[PERF_REG_S390_R10] = 10,
+		[PERF_REG_S390_R11] = 11,
+		[PERF_REG_S390_R12] = 12,
+		[PERF_REG_S390_R13] = 13,
+		[PERF_REG_S390_R14] = 14,
+		[PERF_REG_S390_R15] = 15,
+		[PERF_REG_S390_FP0] = 16,
+		[PERF_REG_S390_FP1] = 20,
+		[PERF_REG_S390_FP2] = 17,
+		[PERF_REG_S390_FP3] = 21,
+		[PERF_REG_S390_FP4] = 18,
+		[PERF_REG_S390_FP5] = 22,
+		[PERF_REG_S390_FP6] = 19,
+		[PERF_REG_S390_FP7] = 23,
+		[PERF_REG_S390_FP8] = 24,
+		[PERF_REG_S390_FP9] = 28,
+		[PERF_REG_S390_FP10] = 25,
+		[PERF_REG_S390_FP11] = 29,
+		[PERF_REG_S390_FP12] = 26,
+		[PERF_REG_S390_FP13] = 30,
+		[PERF_REG_S390_FP14] = 27,
+		[PERF_REG_S390_FP15] = 31,
+		[PERF_REG_S390_MASK] = 64,
+		[PERF_REG_S390_PC] = 65,
+	};
+
+	if (perf_regnum == 0)
+		return 0;
+
+	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s390_regnums) ||
+	    dwarf_s390_regnums[perf_regnum] == 0)
+		return -ENOENT;
+
+	return dwarf_s390_regnums[perf_regnum];
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 137568e15018..f86f76547592 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -212,6 +212,9 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_RISCV:
 		reg = __get_dwarf_regnum_for_perf_regnum_riscv(perf_regnum);
 		break;
+	case EM_S390:
+		reg = __get_dwarf_regnum_for_perf_regnum_s390(perf_regnum);
+		break;
 	case EM_LOONGARCH:
 		reg = __get_dwarf_regnum_for_perf_regnum_loongarch(perf_regnum);
 		break;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index ae76608da110..b95cf2d7b5b3 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -112,6 +112,7 @@ int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags)
 int __get_dwarf_regnum_for_perf_regnum_loongarch(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_riscv(int perf_regnum);
+int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum);
 
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/unwind-libdw-arch/Build
deleted file mode 100644
index 6d6e319e1201..000000000000
--- a/tools/perf/util/unwind-libdw-arch/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += unwind-libdw-s390.o
diff --git a/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
deleted file mode 100644
index 1e05e9d9d95f..000000000000
--- a/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
+++ /dev/null
@@ -1,65 +0,0 @@
-#include <linux/kernel.h>
-#include <elfutils/libdwfl.h>
-#include "util/unwind-libdw.h"
-#include "util/perf_regs.h"
-#include "util/event.h"
-#include "util/sample.h"
-#include "../arch/s390/include/dwarf-regs-table.h"
-#include "../arch/s390/include/uapi/asm/perf_regs.h"
-
-
-bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg)
-{
-	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
-	Dwarf_Word dwarf_regs[ARRAY_SIZE(s390_dwarf_regs)];
-
-#define REG(r) ({						\
-	Dwarf_Word val = 0;					\
-	perf_reg_value(&val, user_regs, PERF_REG_S390_##r);	\
-	val;							\
-})
-	/*
-	 * For DWARF register mapping details,
-	 * see also perf/arch/s390/include/dwarf-regs-table.h
-	 */
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
-
-	dwarf_regs[16] = REG(FP0);
-	dwarf_regs[17] = REG(FP2);
-	dwarf_regs[18] = REG(FP4);
-	dwarf_regs[19] = REG(FP6);
-	dwarf_regs[20] = REG(FP1);
-	dwarf_regs[21] = REG(FP3);
-	dwarf_regs[22] = REG(FP5);
-	dwarf_regs[23] = REG(FP7);
-	dwarf_regs[24] = REG(FP8);
-	dwarf_regs[25] = REG(FP10);
-	dwarf_regs[26] = REG(FP12);
-	dwarf_regs[27] = REG(FP14);
-	dwarf_regs[28] = REG(FP9);
-	dwarf_regs[29] = REG(FP11);
-	dwarf_regs[30] = REG(FP13);
-	dwarf_regs[31] = REG(FP15);
-
-	dwarf_regs[64] = REG(MASK);
-	dwarf_regs[65] = REG(PC);
-
-	dwfl_thread_state_register_pc(thread, dwarf_regs[65]);
-	return dwfl_thread_state_registers(thread, 0, 32, dwarf_regs);
-}
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index b3c4380d40b6..e0321043af88 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -226,7 +226,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 	return true;
 }
 
-static bool libdw_set_initial_registers_generic(Dwfl_Thread *thread, void *arg)
+static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
 {
 	struct unwind_info *ui = arg;
 	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
@@ -279,29 +279,12 @@ static bool libdw_set_initial_registers_generic(Dwfl_Thread *thread, void *arg)
 	return ret;
 }
 
-#define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
-static const Dwfl_Thread_Callbacks callbacks_##arch = {              \
-	.next_thread           = next_thread,                        \
-	.memory_read           = memory_read,                        \
-	.set_initial_registers = libdw_set_initial_registers_##arch, \
-}
-
-static const Dwfl_Thread_Callbacks callbacks_generic = {
+static const Dwfl_Thread_Callbacks callbacks = {
 	.next_thread           = next_thread,
 	.memory_read           = memory_read,
-	.set_initial_registers = libdw_set_initial_registers_generic,
+	.set_initial_registers = libdw_set_initial_registers,
 };
 
-DEFINE_DWFL_THREAD_CALLBACKS(s390);
-
-static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arch)
-{
-	if (!strcmp(arch, "s390"))
-		return &callbacks_s390;
-
-	return &callbacks_generic;
-}
-
 static int
 frame_callback(Dwfl_Frame *state, void *arg)
 {
@@ -349,10 +332,8 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 		.e_machine	= e_machine,
 		.best_effort    = best_effort
 	};
-	const char *arch = perf_env__arch(machine->env);
 	Dwarf_Word ip;
 	int err = -EINVAL, i;
-	const Dwfl_Thread_Callbacks *callbacks;
 
 	if (!data->user_regs || !data->user_regs->regs)
 		return -EINVAL;
@@ -375,11 +356,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		goto out;
 
-	callbacks = get_thread_callbacks(arch);
-	if (!callbacks)
-		goto out;
-
-	err = !dwfl_attach_state(ui->dwfl, /*elf=*/NULL, thread__tid(thread), callbacks, ui);
+	err = !dwfl_attach_state(ui->dwfl, /*elf=*/NULL, thread__tid(thread), &callbacks, ui);
 	if (err)
 		goto out;
 
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index 5c23080cb6c1..20d63d881dff 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -10,7 +10,6 @@ struct perf_sample;
 struct thread;
 
 bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
-bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
 
 struct unwind_info {
 	Dwfl			*dwfl;
-- 
2.52.0.457.g6b5491de43-goog

