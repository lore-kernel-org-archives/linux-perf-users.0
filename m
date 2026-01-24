Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FD13957E
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Jan 2026 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213782; cv=none; b=e/nDfx8QfIxHOB+CwceSrTFcn8HnmZySrMwXgUCvawnEMMZMUc/etxVWCI8flMgyynsdOEGXxmmppvXwce+ByHNxGmdzBAgosgk+Bxj3gSB2PAJ8/l1vxZVPJHMSTRjBfj+RlaF4rHUZ+7RRHpfr8DxdW2vUHNMYiKP4RRdwQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213782; c=relaxed/simple;
	bh=D7GSXZHJxuwLT9nYxPxzqyHjM0asoUVFMFq1khSyD9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZoGA2EFMHUBP3N+5H3eoJkPg4T3G99gH86nV4VLrcZrS3uNmtCfNtafWAHAMoAuFeIyJGnxypG+3aF+C07Q4LrccRrylm5NZGHysld+eOireomXaCzE4Gp8cSEdJM4TY9lgxOwmtM6HLQqPsLXmKS7g5uzGPaH0OH2ARGE+R17k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZxFRCl+G; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxFRCl+G"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b74766fae7so939546eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 16:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769213779; x=1769818579; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71clqYtrvxTcP8hDC5pO0EDsKlw6xvkRsj75GQMSL04=;
        b=ZxFRCl+GMO2J7yuMrI6kaE6fEOE8XRTXUITiv9Bt5gGuq/2QHGH22WJZXSRV8pq+PK
         fMeMKFqm2XUZVUHmyfiteXua7n/mP2FrMJ/bbqIOHFMQIxnxAtBNmSAzFfp0B5QeLY10
         bQ1gP/kcv43CxO6NetDTsvugCh5Tuc/FSY+XDH4XjZyiLsautAKktBsdE+BCo7ZAgWMK
         q7nQeaad/QH9HggChdwvSjjh9KDbqndq84Gh/iDuiu12QVCIQ6q9Jowyd3v8+ofhnov7
         D43X1Y/hF1YYE/AnWMfcFCK5yyvpS48rZxQCoSEAyC8iVZoZG3mWhWH8rJTWfia8KEkn
         b5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769213779; x=1769818579;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71clqYtrvxTcP8hDC5pO0EDsKlw6xvkRsj75GQMSL04=;
        b=gASSkznkQWFpzjtdUGmcsVZ6EDQOvb/OfX2rAaNNurCO333n6/IegHM2J7mqUoZ5he
         TQzkDxNWmv5F5Kmix/PKiaJyCmHj/MeYT1hfPVNRJ3GX1vHzQQNmBXfQ2X2H4zENWrpV
         Jtv+LsmWEIwM9koOw2SqJtXC5WlAreIpx3eVSO1T+cEBnHAcfYj/QeLKBsucq+Jb0whQ
         1PkA/MHmIdSLxid0k363Wr+mmnm8McQ3+2Rvy29F3esb+31CM7azUOS4FjWr7Q1FBif/
         bI5xVLz9xzOxAHOzoYsZwg5p+rDdeQS2vU80b/HDCYfhKBysQRA11ZJR2qH5JtVUZU6U
         vaaw==
X-Forwarded-Encrypted: i=1; AJvYcCVKgTF7k1qJOPF8RW19binNfkP6j3r7NNZiqy+tEPd0JRqf/F4GG4OcMi5N8MXiujGdTHieWIb2LQy7/o3/qP7z@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4HJi8en7LR0iBEO70rzmHRUFjSwPdpLN3HPgqL65JhOiaT0W
	vhilZBF4rV9Yx5cRoS0pIt6KXmwWCboLBDjhX5OAojx6NAssEun1HSC4lAGI0bGlBfqlLBHSRSG
	frEMC+iWAFQ==
X-Received: from dycna19.prod.google.com ([2002:a05:7300:ea93:b0:2b7:481:7150])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e607:b0:2a4:3594:72ed
 with SMTP id 5a478bee46e88-2b739b6d28dmr2210277eec.28.1769213779370; Fri, 23
 Jan 2026 16:16:19 -0800 (PST)
Date: Fri, 23 Jan 2026 16:16:09 -0800
In-Reply-To: <20260124001611.1332019-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124001611.1332019-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124001611.1332019-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf script: Fix script_fetch_insn for more than just x86
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
index 372bede30230..b4bf68b17948 100644
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
@@ -1618,7 +1616,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
-	script_fetch_insn(sample, thread, machine, native_arch);
+	perf_sample__fetch_insn(sample, thread, machine);
 
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
@@ -4016,7 +4014,6 @@ int cmd_script(int argc, const char **argv)
 		.set = false,
 		.default_no_sample = true,
 	};
-	struct utsname uts;
 	char *script_path = NULL;
 	const char *dlfilter_file = NULL;
 	const char **__argv;
@@ -4438,17 +4435,6 @@ int cmd_script(int argc, const char **argv)
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

