Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F132ED31
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Jan 2026 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627795; cv=none; b=CoPEccM/uxve8OknF1h66FzKfUCgO+x1hmgDkk2J/XoSTlNKfIIMlFD8aZEZr6wZ8872o3pWlGO9+TkeesRCDaolScq8Npzz939cAIzEStVWdAWWMThCyXInDGAhTYc2W1HAJgpS5aWOu5DjR2dsJWLZAXxptfi8zKMEicySN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627795; c=relaxed/simple;
	bh=u+b3O63vZvH1AQEyJ0ZNvbCIwQXEG3+oVy3wGQYabO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bcbQYglf6uAYyF+Tp+G/9rD7peykYecg527YmS2cplUUZ/2FA8Ae/wp4bgRT3bmAfu/4a43077NCXEu2FG37CnWOIhtdzo6rRY8cV8vEE+BgZs70x+tIoAS5E0t/hlA6SP9TQJeKpcRcCaHBDcjo0hTxLwZvxvCwrdvZiW1H2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+R2B3G8; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+R2B3G8"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b6a8afb513so3064622eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Jan 2026 21:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627793; x=1769232593; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gu6Ay1rV/hnUCdAd59fcfxBvScqY/4/I5R48NWueiwM=;
        b=k+R2B3G8D7bSs5DKZojLZbHZF1BA0Ja5uh3vbC5cLvPkaEdAwn5IlE70xh9mAiAupu
         ATYZF5KUbtsxI8gU0ahmYpJGeWbC+UPiaLVHAzzbgXkBC3Lfdad4y7uPgiW42KlX6I8u
         h2QXNV8VvwGzAq67bRQoUtfHRBukUS9HdX56vyd83Y1Z87UrNBnArnH7DLYFCac2o49I
         wf3JSls5Eh2HN5vm+uy19JPtqr2p4+VyJysS/cbQD0BeMqZLcjySDpk3sT5ToUNbnWXF
         1RWAUt59CI7W4CxSoooA5EhYplU3YeZ5dY3Any4PEBYz6ew57Hr2XG0vocjKtC90ToiI
         mzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627793; x=1769232593;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gu6Ay1rV/hnUCdAd59fcfxBvScqY/4/I5R48NWueiwM=;
        b=NcgS8NBeujjjyz5C0dBItAVr/VsFPqJ9Kmn19y+3ETW4uksBJfLhYx5NT55fkk9EAd
         X/v67wZLujwE98ZwgCChvQv5juVYiR64sm2YAszrOnV/p2AYWVRxk6YHVF6+XXhtbf5K
         e9To4ojh5DvkrVeYQYjlvHyeP9K0tqsEsyXV+LsQKIjLN/XIglPbDh9N/LmxW6iSYkQC
         d1XIOo64GAZcAB4RgffqfRu1UhPnTOYl+KgMisiqdPfR0fxB5JIbxRhl20MSbn3vuw5E
         cXtZMb9Tnooq3BblosiIs/n8euAmkOwWw/ddUeg5cRQl2JwYODa3lQ7QJ7iHCRPck+jI
         1PKA==
X-Forwarded-Encrypted: i=1; AJvYcCXiRY0lLiITSo3YhWiwsfeBc3m2R0hfzr17leRYWhOMp0LIu3p/9/AhTKUQQle9eGfJn/RP2vjtsa2v1GQTw7JJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMwgdUO3TILCrqyQumd6KKivja8qCu1itJxOUarF4O9TnrGDO
	z3crEpAKlabFX4wdk9kfQCfc9PcVojnIVDeOBF7Wf6ULdWEgmUg27sv8FsEEGMjCTBBpyhUCFKI
	5HZc50+4V4Q==
X-Received: from dycnr20-n2.prod.google.com ([2002:a05:7300:e9d4:20b0:2b0:5541:d643])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2d93:b0:2b0:5028:bafd
 with SMTP id 5a478bee46e88-2b6b46c68femr3497511eec.8.1768627792479; Fri, 16
 Jan 2026 21:29:52 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:44 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-19-irogers@google.com>
Subject: [PATCH v1 18/23] perf dwarf-regs: Add RISC-V perf to dwarf register
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
 tools/perf/util/dwarf-regs-arch/Build         |  1 +
 .../util/dwarf-regs-arch/dwarf-regs-riscv.c   | 12 ++++
 tools/perf/util/dwarf-regs.c                  |  3 +
 tools/perf/util/include/dwarf-regs.h          |  1 +
 tools/perf/util/unwind-libdw-arch/Build       |  1 -
 .../unwind-libdw-arch/unwind-libdw-riscv.c    | 58 -------------------
 tools/perf/util/unwind-libdw.c                |  5 +-
 tools/perf/util/unwind-libdw.h                |  1 -
 8 files changed, 18 insertions(+), 64 deletions(-)
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-riscv.c
 delete mode 100644 tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c

diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
index 188359376ea5..94e4dfceb4d1 100644
--- a/tools/perf/util/dwarf-regs-arch/Build
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -3,4 +3,5 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-loongarch.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-riscv.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-riscv.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-riscv.c
new file mode 100644
index 000000000000..090db51aba41
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-riscv.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <dwarf-regs.h>
+#include "../../../arch/riscv/include/uapi/asm/perf_regs.h"
+
+int __get_dwarf_regnum_for_perf_regnum_riscv(int perf_regnum)
+{
+	if (perf_regnum < 0 || perf_regnum >= PERF_REG_RISCV_MAX)
+		return -ENOENT;
+
+	return perf_regnum;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 3b1c2a436806..137568e15018 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -209,6 +209,9 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_PPC64:
 		reg = __get_dwarf_regnum_for_perf_regnum_powerpc(perf_regnum);
 		break;
+	case EM_RISCV:
+		reg = __get_dwarf_regnum_for_perf_regnum_riscv(perf_regnum);
+		break;
 	case EM_LOONGARCH:
 		reg = __get_dwarf_regnum_for_perf_regnum_loongarch(perf_regnum);
 		break;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 9ebb3ba33fba..ae76608da110 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -111,6 +111,7 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags);
 int __get_dwarf_regnum_for_perf_regnum_loongarch(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum);
+int __get_dwarf_regnum_for_perf_regnum_riscv(int perf_regnum);
 
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/unwind-libdw-arch/Build
index e6c97e842cd6..6d6e319e1201 100644
--- a/tools/perf/util/unwind-libdw-arch/Build
+++ b/tools/perf/util/unwind-libdw-arch/Build
@@ -1,2 +1 @@
-perf-util-y += unwind-libdw-riscv.o
 perf-util-y += unwind-libdw-s390.o
diff --git a/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
deleted file mode 100644
index c2e2c4b6b2e0..000000000000
--- a/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
-
-#include <elfutils/libdwfl.h>
-#include "../arch/riscv/include/uapi/asm/perf_regs.h"
-#include "util/unwind-libdw.h"
-#include "util/perf_regs.h"
-#include "util/sample.h"
-
-bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)
-{
-	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
-	Dwarf_Word dwarf_regs[32];
-
-#define REG(r) ({						\
-	Dwarf_Word val = 0;					\
-	perf_reg_value(&val, user_regs, PERF_REG_RISCV_##r);	\
-	val;							\
-})
-
-	dwarf_regs[0]  = 0;
-	dwarf_regs[1]  = REG(RA);
-	dwarf_regs[2]  = REG(SP);
-	dwarf_regs[3]  = REG(GP);
-	dwarf_regs[4]  = REG(TP);
-	dwarf_regs[5]  = REG(T0);
-	dwarf_regs[6]  = REG(T1);
-	dwarf_regs[7]  = REG(T2);
-	dwarf_regs[8]  = REG(S0);
-	dwarf_regs[9]  = REG(S1);
-	dwarf_regs[10] = REG(A0);
-	dwarf_regs[11] = REG(A1);
-	dwarf_regs[12] = REG(A2);
-	dwarf_regs[13] = REG(A3);
-	dwarf_regs[14] = REG(A4);
-	dwarf_regs[15] = REG(A5);
-	dwarf_regs[16] = REG(A6);
-	dwarf_regs[17] = REG(A7);
-	dwarf_regs[18] = REG(S2);
-	dwarf_regs[19] = REG(S3);
-	dwarf_regs[20] = REG(S4);
-	dwarf_regs[21] = REG(S5);
-	dwarf_regs[22] = REG(S6);
-	dwarf_regs[23] = REG(S7);
-	dwarf_regs[24] = REG(S8);
-	dwarf_regs[25] = REG(S9);
-	dwarf_regs[26] = REG(S10);
-	dwarf_regs[27] = REG(S11);
-	dwarf_regs[28] = REG(T3);
-	dwarf_regs[29] = REG(T4);
-	dwarf_regs[30] = REG(T5);
-	dwarf_regs[31] = REG(T6);
-	dwfl_thread_state_register_pc(thread, REG(PC));
-
-	return dwfl_thread_state_registers(thread, 0, PERF_REG_RISCV_MAX,
-					   dwarf_regs);
-}
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index e9ba050e7ab1..b3c4380d40b6 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -292,14 +292,11 @@ static const Dwfl_Thread_Callbacks callbacks_generic = {
 	.set_initial_registers = libdw_set_initial_registers_generic,
 };
 
-DEFINE_DWFL_THREAD_CALLBACKS(riscv);
 DEFINE_DWFL_THREAD_CALLBACKS(s390);
 
 static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arch)
 {
-	if (!strcmp(arch, "riscv"))
-		return &callbacks_riscv;
-	else if (!strcmp(arch, "s390"))
+	if (!strcmp(arch, "s390"))
 		return &callbacks_s390;
 
 	return &callbacks_generic;
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index 0ec1abdabbe7..5c23080cb6c1 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -10,7 +10,6 @@ struct perf_sample;
 struct thread;
 
 bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
-bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
 
 struct unwind_info {
-- 
2.52.0.457.g6b5491de43-goog

