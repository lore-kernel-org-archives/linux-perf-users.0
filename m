Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DC2FF67F
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465160; cv=none; b=YSO1FWCUWnIc+s2MfkfFNP+mZhzTbTZUB7o1rlYRMw8nRWQAXt2vRO8Qf842fEfnwfkeh1XmZYTzekzzTQJRdLMzL1eQ3k9ExQ+8N9wU8GTRau+dgyXaJMsxoPPI8uWxmlhN9Fw33Uzn6D5+bNCV5JXWZ8MlOsVOAcSor95nID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465160; c=relaxed/simple;
	bh=D6IHvh/RYDhrsOnsnqt6RvaM6BELKcPnEPdhv2NRJZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uoHyBWmQ/2us/4GHmYMbPpML3IblVj00/gneXUdggfhYI7oO8qJGYFPywypLsrxh+NjDpgJ1xDOmPVtvy9oXHyNuktBr1XIONswAR02I5DNmGKg+7gPETLzh0NRnUQV8eMhrYGDqevm/IxOY8Ka3CY45wKof9fNSgMj3ZApy4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzzJejOj; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzzJejOj"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b74766fae7so3589428eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769465157; x=1770069957; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGvTYo7LJrFeZcKynUHNX0eReEMJ0nid9UIfv18rSLo=;
        b=gzzJejOjrDijleBlmGyw9oQsbKaR/8fgd5Vqtng8i+qMVSjY13NmnfNYH4daf7erIm
         N3pDh1sFeoFhpHjYqVuXU9BDMd3jiJ3bu34eYRf8m29pBycFf+MbR78a2dy6Rm2gFtA2
         RvZHIyKIZSUzY8hcBW9o/BY349HmvCTT3at4156WSInmxprvWxo44BeYJ1QeUCPsmpfF
         A7solAzjgzr3Pujmcqu/cUs3RNicvEAyw/EXDH4ob6qRi7tSsLbtnyH0Xy7bbzizU/+9
         yXN32ru4arBYwee19vhgIWQAnX2QV57M/57uW28DSOrlKguFpFOaORMl1yLYuP1HJZg8
         BGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465157; x=1770069957;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGvTYo7LJrFeZcKynUHNX0eReEMJ0nid9UIfv18rSLo=;
        b=ZTFKkOkN1WVGNeuzNdGYSaJfuEKqmuH5S1TSCXv5G8kFqSSd/Y6Fc+skfo6t35zysH
         2AeLZyX63+QnTK0MFSCL3Deu5EhM55XhAOnzHJw7DMO/S3jt/sJMil1bC0StUwGuB2rC
         10UKWsLBYJfcYVmBCt7FDHj6C469CYkgjsll50F1O3fYdzcnlVIb/KgyU8MeYlo2PpWK
         MRLLcq+jta7tePZGY6KSTBKTfO9ttF4T9qYBHio9xTE/wQt9Tq3dejEYE/MWkWvyMFKW
         mUElBwCbHqI0ZSsC5EavHbwE68zYjQeyO7aQJrTFKSH6i8uYwfiHTRHFnCmoWQzQsNHJ
         4HPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWhfKO5WYV6wh5IZ7UbsxT9Faxe41c/JNq9/sHzVF7vg2mvG/sXZvA8I7N2eLRchV18EURdVU9SnHyto1b7Uyy@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3cuCgKYkftr13ZPYeUniUmITRHyKBtX9rYKRg+4u/NqOXzGi
	R6/iiHZJVuJjdKHibv/+IFuvjhhsVsB/qiGTxeEEigIMo73qR1TMLjCKUZW/3TsxEWXmbalcWVV
	5C0yQk053Yg==
X-Received: from dlbcf3.prod.google.com ([2002:a05:7022:4583:b0:123:12b9:c4e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4399:b0:121:9f05:c4c2
 with SMTP id a92af1059eb24-1248ec40fa3mr2859327c88.23.1769465157415; Mon, 26
 Jan 2026 14:05:57 -0800 (PST)
Date: Mon, 26 Jan 2026 14:05:48 -0800
In-Reply-To: <20260126220550.2573257-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126220550.2573257-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126220550.2573257-2-irogers@google.com>
Subject: [PATCH v2 1/3] perf script: Fix script_fetch_insn for more than just x86
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@arm.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The script_fetch_insn code was only supported on natively running
x86. Implement a crude elf_machine_max_instruction_length function and
use to give an instruction length on more than just x86. Use the ELF
machine to determine the length to use to support cross-architecture
development.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/Build                |  1 -
 tools/perf/arch/x86/util/archinsn.c           | 27 -------
 tools/perf/builtin-script.c                   | 16 +----
 .../scripts/python/Perf-Trace-Util/Context.c  |  2 +-
 tools/perf/tests/dlfilter-test.c              |  1 -
 tools/perf/util/archinsn.h                    | 12 ----
 tools/perf/util/dlfilter.c                    |  3 +-
 tools/perf/util/sample.c                      | 71 +++++++++++++++++++
 tools/perf/util/sample.h                      |  7 ++
 tools/perf/util/trace-event-scripting.c       | 16 -----
 tools/perf/util/trace-event.h                 |  3 -
 11 files changed, 81 insertions(+), 78 deletions(-)
 delete mode 100644 tools/perf/arch/x86/util/archinsn.c
 delete mode 100644 tools/perf/util/archinsn.h

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index fad256252bb9..76127eefde8b 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -14,6 +14,5 @@ perf-util-y += iostat.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 
 perf-util-y += auxtrace.o
-perf-util-y += archinsn.o
 perf-util-y += intel-pt.o
 perf-util-y += intel-bts.o
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
deleted file mode 100644
index 546feda08428..000000000000
--- a/tools/perf/arch/x86/util/archinsn.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "archinsn.h"
-#include "event.h"
-#include "machine.h"
-#include "thread.h"
-#include "symbol.h"
-#include "../../../../arch/x86/include/asm/insn.h"
-
-void arch_fetch_insn(struct perf_sample *sample,
-		     struct thread *thread,
-		     struct machine *machine)
-{
-	struct insn insn;
-	int len, ret;
-	bool is64bit = false;
-
-	if (!sample->ip)
-		return;
-	len = thread__memcpy(thread, machine, sample->insn, sample->ip, sizeof(sample->insn), &is64bit);
-	if (len <= 0)
-		return;
-
-	ret = insn_decode(&insn, sample->insn, len,
-			  is64bit ? INSN_MODE_64 : INSN_MODE_32);
-	if (ret >= 0 && insn.length <= len)
-		sample->insn_len = insn.length;
-}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6ec225c697a4..69af25780fc5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -37,7 +37,6 @@
 #include "ui/ui.h"
 #include "print_binary.h"
 #include "print_insn.h"
-#include "archinsn.h"
 #include <linux/bitmap.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -90,7 +89,6 @@ static bool			print_flags;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static int			max_blocks;
-static bool			native_arch;
 static struct dlfilter		*dlfilter;
 static int			dlargc;
 static char			**dlargv;
@@ -1627,7 +1625,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
-	script_fetch_insn(sample, thread, machine, native_arch);
+	perf_sample__fetch_insn(sample, thread, machine);
 
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
@@ -4034,7 +4032,6 @@ int cmd_script(int argc, const char **argv)
 		.set = false,
 		.default_no_sample = true,
 	};
-	struct utsname uts;
 	char *script_path = NULL;
 	const char *dlfilter_file = NULL;
 	const char **__argv;
@@ -4456,17 +4453,6 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__init(env) < 0)
 		goto out_delete;
 
-	uname(&uts);
-	if (data.is_pipe) { /* Assume pipe_mode indicates native_arch */
-		native_arch = true;
-	} else if (env->arch) {
-		if (!strcmp(uts.machine, env->arch))
-			native_arch = true;
-		else if (!strcmp(uts.machine, "x86_64") &&
-			 !strcmp(env->arch, "i386"))
-			native_arch = true;
-	}
-
 	script.session = session;
 	script__setup_sample_type(&script);
 
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 60dcfe56d4d9..c19f44610983 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -93,7 +93,7 @@ static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
 	if (c->sample->ip && !c->sample->insn_len && thread__maps(c->al->thread)) {
 		struct machine *machine =  maps__machine(thread__maps(c->al->thread));
 
-		script_fetch_insn(c->sample, c->al->thread, machine, /*native_arch=*/true);
+		perf_sample__fetch_insn(c->sample, c->al->thread, machine);
 	}
 	if (!c->sample->insn_len)
 		Py_RETURN_NONE; /* N.B. This is a return statement */
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 80a1c941138d..e63790c61d53 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -30,7 +30,6 @@
 #include "symbol.h"
 #include "synthetic-events.h"
 #include "util.h"
-#include "archinsn.h"
 #include "dlfilter.h"
 #include "tests.h"
 #include "util/sample.h"
diff --git a/tools/perf/util/archinsn.h b/tools/perf/util/archinsn.h
deleted file mode 100644
index 448cbb6b8d7e..000000000000
--- a/tools/perf/util/archinsn.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef INSN_H
-#define INSN_H 1
-
-struct perf_sample;
-struct machine;
-struct thread;
-
-void arch_fetch_insn(struct perf_sample *sample,
-		     struct thread *thread,
-		     struct machine *machine);
-
-#endif
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index c0afcbd954f8..dc31b5e7149e 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -234,8 +234,7 @@ static const __u8 *dlfilter__insn(void *ctx, __u32 *len)
 			struct machine *machine = maps__machine(thread__maps(al->thread));
 
 			if (machine)
-				script_fetch_insn(d->sample, al->thread, machine,
-						  /*native_arch=*/true);
+				perf_sample__fetch_insn(d->sample, al->thread, machine);
 		}
 	}
 
diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
index 605fee971f55..d885c02a9861 100644
--- a/tools/perf/util/sample.c
+++ b/tools/perf/util/sample.c
@@ -1,9 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include "sample.h"
 #include "debug.h"
+#include "thread.h"
+#include <elf.h>
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <string.h>
+#include "../../arch/x86/include/asm/insn.h"
 
 void perf_sample__init(struct perf_sample *sample, bool all)
 {
@@ -41,3 +44,71 @@ struct regs_dump *perf_sample__intr_regs(struct perf_sample *sample)
 	}
 	return sample->intr_regs;
 }
+
+static int elf_machine_max_instruction_length(uint16_t e_machine)
+{
+	switch (e_machine) {
+	/* Fixed 4-byte (32-bit) architectures */
+	case EM_AARCH64:
+	case EM_PPC:
+	case EM_PPC64:
+	case EM_MIPS:
+	case EM_SPARC:
+	case EM_SPARCV9:
+	case EM_ALPHA:
+	case EM_LOONGARCH:
+	case EM_PARISC:
+	case EM_SH:
+		return 4;
+
+	/* Variable length or mixed-mode architectures */
+	case EM_ARM:    /* Variable due to Thumb/Thumb-2 */
+	case EM_RISCV:  /* Variable due to Compressed (C) extension */
+	case EM_CSKY:   /* Variable (16 or 32 bit) */
+	case EM_ARC:    /* Variable (ARCompact) */
+		return 4;
+	case EM_S390:   /* Variable (2, 4, or 6 bytes) */
+		return 6;
+	case EM_68K:
+		return 10;
+	case EM_386:
+	case EM_X86_64:
+		return 15;
+	case EM_XTENSA: /* Variable (FLIX) */
+		return 16;
+	default:
+		return MAX_INSN;
+	}
+}
+
+void perf_sample__fetch_insn(struct perf_sample *sample,
+			     struct thread *thread,
+			     struct machine *machine)
+{
+	int ret, len;
+	bool is64bit = false;
+	uint16_t e_machine;
+
+	if (!sample->ip || sample->insn_len != 0)
+		return;
+
+	e_machine = thread__e_machine(thread, machine);
+	len = elf_machine_max_instruction_length(e_machine);
+	len = thread__memcpy(thread, machine, sample->insn,
+			     sample->ip, len,
+			     &is64bit);
+	if (len <= 0)
+		return;
+
+	sample->insn_len = len;
+
+	if (e_machine == EM_386 || e_machine == EM_X86_64) {
+		/* Refine the x86 instruction length with the decoder. */
+		struct insn insn;
+
+		ret = insn_decode(&insn, sample->insn, len,
+				  is64bit ? INSN_MODE_64 : INSN_MODE_32);
+		if (ret >= 0 && insn.length <= len)
+			sample->insn_len = insn.length;
+	}
+}
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index a8307b20a9ea..3cce8dd202aa 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -5,6 +5,9 @@
 #include <linux/perf_event.h>
 #include <linux/types.h>
 
+struct machine;
+struct thread;
+
 /* number of register is bound by the number of bits in regs_dump::mask (64) */
 #define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
 
@@ -127,6 +130,10 @@ void perf_sample__exit(struct perf_sample *sample);
 struct regs_dump *perf_sample__user_regs(struct perf_sample *sample);
 struct regs_dump *perf_sample__intr_regs(struct perf_sample *sample);
 
+void perf_sample__fetch_insn(struct perf_sample *sample,
+			     struct thread *thread,
+			     struct machine *machine);
+
 /*
  * raw_data is always 4 bytes from an 8-byte boundary, so subtract 4 to get
  * 8-byte alignment.
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 72abb28b7b5a..fa850e44cb46 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -13,7 +13,6 @@
 #include <event-parse.h>
 #endif
 
-#include "archinsn.h"
 #include "debug.h"
 #include "event.h"
 #include "trace-event.h"
@@ -274,21 +273,6 @@ void setup_perl_scripting(void)
 #endif
 #endif
 
-#if !defined(__i386__) && !defined(__x86_64__)
-void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
-		     struct thread *thread __maybe_unused,
-		     struct machine *machine __maybe_unused)
-{
-}
-#endif
-
-void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine, bool native_arch)
-{
-	if (sample->insn_len == 0 && native_arch)
-		arch_fetch_insn(sample, thread, machine);
-}
-
 static const struct {
 	u32 flags;
 	const char *name;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 71e680bc3d4b..914d9b69ed62 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -116,9 +116,6 @@ extern unsigned int scripting_max_stack;
 struct scripting_ops *script_spec__lookup(const char *spec);
 int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
 
-void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
-		       struct machine *machine, bool native_arch);
-
 void setup_perl_scripting(void);
 void setup_python_scripting(void);
 
-- 
2.52.0.457.g6b5491de43-goog

