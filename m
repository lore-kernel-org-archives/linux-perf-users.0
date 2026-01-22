Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED736AB40
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100885; cv=none; b=Y9mifqgzvcRghNih8P+jM2w5Jx4yjrdi/+jePiuS7Cey+GDIF8MndPaGW8cbo1uQ/QuxgDey7SgRPrLSdInMseE2QlcQcy0uxAxO7Pw0omBOftA2NcfAf8yE4JZbNcCgrY9sD+5yJvJeJ99LZiwAZ3X6/z/cVh1daVLoDDRD70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100885; c=relaxed/simple;
	bh=491jb90fnisDDkG3+G9+p4v7Lk7B8Z252ZaXQb6NJdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KV4ZMA63m89ihUZ778ACxFyptNAgLtqErDXHRPwS1ZyjwpADF08tAy7GNAHwjSARCUuY2SopOMqJ3pmP/L40hUQ/gC00gLE8aH4BsCSgl7xQEpsLBdZXovaoPUavSIFf+ViYOgCqLFXuCfxRqXdMQpUzKP+wYouDCDEm/204aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1L9qkYaH; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1L9qkYaH"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11b21dfe918so900160c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100870; x=1769705670; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACMl4tEoxoHusBUNvHd7v0jfYpL5OX8OF2Pn3Unqkyk=;
        b=1L9qkYaHdgmJhA3p6jpodKlp4IPLzO6Zo4a42Z2NLdvvBv4UhbGxUMO/9vl4m41cDF
         M6npuVLmX7lm04bCEA4oj1YjM0aytK319YOYs9V8Nhq0bF3BjGzOkb1B9h9ODzfo0BGC
         uJuIKd3B/kHadBTGcMiEFLq45Q4AMCittfyC7nSayQGTwrAFxyt4sHQ3V+ipkTwUd5+a
         UTtS/Zc1lj+P123VDN/aVu+Suer+ZI7hbt763alxzFNCl1Y7myK5VEz0c7EYYyn+dTQ5
         dXoDKd+1GZpAndt8vffPN9wpgwkgizf6J29FbWiwhWjAY9sxF8f5SoZv7vexvMB9hGZT
         FLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100870; x=1769705670;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACMl4tEoxoHusBUNvHd7v0jfYpL5OX8OF2Pn3Unqkyk=;
        b=mAmZCmHH09hJK2af/IiNm4og7SMopF/MKSoOagyBacZIDP1M0jJdPCk3gynHQ79bDp
         0dNQWyMIfRIeeZQIhZ2Iqs71/zz8P9PzEKRCJGj35zQW4hxaJdibwTkXPts2Lguox6gi
         OHKUVBdpIgPkOp0vEKOvL/PmVdRJlskXNbJs1t4RqbDQLnDtS1uFkPXJjjA5sOTA/RVh
         qYsEydiyx6VW08gYw8B8J/sSfehLDur0SfqRsCP4oZdTzsYulvB+TDzx3KowLQA6jwtD
         Miz3o3phlbhZQ7Hc2kSEH6mbfqyPyBPwquzpvekHH2pHZIEhAd3siYKxxUIETVhozZm/
         fynA==
X-Forwarded-Encrypted: i=1; AJvYcCWc+UdE6YMNWP8YTVIYG1aAbRv2vqDTyi7t2pB/mIoYtPpkYTPJPOj2f/Gsunt+XqgIyiIZ1jyvw6f1kXSeCl5M@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsYDmzvEPd+SKK7VTlFURdwUskV2DCUijSjZ7DJ7/Of08r66Z
	INnHp5kv5IDlrx2xlsG1Q2Wk3r/pJg5psedMTh+pCNbkY65t5TlrLTWkWUUhEHPpRA1wwTHVmDM
	P9GhgyHhZOA==
X-Received: from dlf16.prod.google.com ([2002:a05:7022:410:b0:11f:3d13:8e65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:488:b0:11d:fd41:62c8
 with SMTP id a92af1059eb24-1247d778de2mr27365c88.13.1769100869572; Thu, 22
 Jan 2026 08:54:29 -0800 (PST)
Date: Thu, 22 Jan 2026 08:54:03 -0800
In-Reply-To: <20260122165407.561888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122165407.561888-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122165407.561888-9-irogers@google.com>
Subject: [PATCH v2 08/12] perf disasm: Don't include C files from the arch directory
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Move the arch instructions.c files into appropriately named files in
annotate-arch in the util directory. Don't #include to compile the
code, switch to building the files and fix up the #includes
accordingly. Move powerpc specific disasm code out of disasm.c and
into annotate-powerpc.c. Declarations and static removed as
appropriate for the code to compile as separate compilation units. The
e_machine and e_flags set up is moved to the disasm.c architectures
array so that later patches can sort by them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate-arch/Build           |  11 +
 .../annotate-arch/annotate-arc.c}             |   5 +-
 .../annotate-arch/annotate-arm.c}             |   9 +-
 .../annotate-arch/annotate-arm64.c}           |  14 +-
 .../annotate-arch/annotate-csky.c}            |  11 +-
 .../annotate-arch/annotate-loongarch.c}       |  15 +-
 .../annotate-arch/annotate-mips.c}            |   6 +-
 .../annotate-arch/annotate-powerpc.c}         | 105 ++++++++-
 .../annotate-arch/annotate-riscv64.c}         |   6 +-
 .../annotate-arch/annotate-s390.c}            |  15 +-
 .../annotate-arch/annotate-sparc.c}           |   7 +-
 .../annotate-arch/annotate-x86.c}             |  85 +++++---
 tools/perf/util/disasm.c                      | 199 ++++--------------
 tools/perf/util/disasm.h                      |  38 ++++
 15 files changed, 289 insertions(+), 238 deletions(-)
 create mode 100644 tools/perf/util/annotate-arch/Build
 rename tools/perf/{arch/arc/annotate/instructions.c => util/annotate-arch/annotate-arc.c} (53%)
 rename tools/perf/{arch/arm/annotate/instructions.c => util/annotate-arch/annotate-arm.c} (90%)
 rename tools/perf/{arch/arm64/annotate/instructions.c => util/annotate-arch/annotate-arm64.c} (90%)
 rename tools/perf/{arch/csky/annotate/instructions.c => util/annotate-arch/annotate-csky.c} (83%)
 rename tools/perf/{arch/loongarch/annotate/instructions.c => util/annotate-arch/annotate-loongarch.c} (93%)
 rename tools/perf/{arch/mips/annotate/instructions.c => util/annotate-arch/annotate-mips.c} (94%)
 rename tools/perf/{arch/powerpc/annotate/instructions.c => util/annotate-arch/annotate-powerpc.c} (76%)
 rename tools/perf/{arch/riscv64/annotate/instructions.c => util/annotate-arch/annotate-riscv64.c} (91%)
 rename tools/perf/{arch/s390/annotate/instructions.c => util/annotate-arch/annotate-s390.c} (91%)
 rename tools/perf/{arch/sparc/annotate/instructions.c => util/annotate-arch/annotate-sparc.c} (96%)
 rename tools/perf/{arch/x86/annotate/instructions.c => util/annotate-arch/annotate-x86.c} (97%)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c30ff257f8b4..b9925c6902ca 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,6 +1,7 @@
 include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/utilities.mak
 
+perf-util-y += annotate-arch/
 perf-util-y += arm64-frame-pointer-unwind-support.o
 perf-util-y += addr2line.o
 perf-util-y += addr_location.o
diff --git a/tools/perf/util/annotate-arch/Build b/tools/perf/util/annotate-arch/Build
new file mode 100644
index 000000000000..23316743fdc5
--- /dev/null
+++ b/tools/perf/util/annotate-arch/Build
@@ -0,0 +1,11 @@
+perf-util-y += annotate-arc.o
+perf-util-y += annotate-arm.o
+perf-util-y += annotate-arm64.o
+perf-util-y += annotate-csky.o
+perf-util-y += annotate-loongarch.o
+perf-util-y += annotate-mips.o
+perf-util-y += annotate-x86.o
+perf-util-y += annotate-powerpc.o
+perf-util-y += annotate-riscv64.o
+perf-util-y += annotate-s390.o
+perf-util-y += annotate-sparc.o
diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-arc.c
similarity index 53%
rename from tools/perf/arch/arc/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-arc.c
index e5619770a1af..d7ca08ca5600 100644
--- a/tools/perf/arch/arc/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-arc.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include "../disasm.h"
 
-static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	arch->initialized = true;
 	arch->objdump.comment_char = ';';
-	arch->e_machine = EM_ARC;
-	arch->e_flags = 0;
 	return 0;
 }
diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-arm.c
similarity index 90%
rename from tools/perf/arch/arm/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-arm.c
index b997d127fedd..08c49067c3c9 100644
--- a/tools/perf/arch/arm/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-arm.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <regex.h>
-#include <stdlib.h>
+#include "../annotate.h"
+#include "../disasm.h"
 
 struct arm_annotate {
 	regex_t call_insn,
@@ -28,7 +29,7 @@ static const struct ins_ops *arm__associate_instruction_ops(struct arch *arch, c
 	return ops;
 }
 
-static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	struct arm_annotate *arm;
 	int err;
@@ -54,8 +55,6 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	arch->associate_instruction_ops   = arm__associate_instruction_ops;
 	arch->objdump.comment_char	  = ';';
 	arch->objdump.skip_functions_char = '+';
-	arch->e_machine = EM_ARM;
-	arch->e_flags = 0;
 	return 0;
 
 out_free_call:
diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-arm64.c
similarity index 90%
rename from tools/perf/arch/arm64/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-arm64.c
index 44db33854dba..d2ea32984b0d 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <errno.h>
-#include <sys/types.h>
-#include <regex.h>
 #include <stdlib.h>
+#include <string.h>
+#include <linux/zalloc.h>
+#include <regex.h>
+#include "../annotate.h"
+#include "../disasm.h"
 
 struct arm64_annotate {
 	regex_t call_insn,
@@ -60,9 +63,6 @@ static int arm64_mov__parse(const struct arch *arch __maybe_unused,
 	return -1;
 }
 
-static int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
-			  struct ins_operands *ops, int max_ins_name);
-
 static const struct ins_ops arm64_mov_ops = {
 	.parse	   = arm64_mov__parse,
 	.scnprintf = mov__scnprintf,
@@ -87,7 +87,7 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 	return ops;
 }
 
-static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	struct arm64_annotate *arm;
 	int err;
@@ -114,8 +114,6 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 	arch->objdump.comment_char	  = '/';
 	arch->objdump.skip_functions_char = '+';
-	arch->e_machine = EM_AARCH64;
-	arch->e_flags = 0;
 	return 0;
 
 out_free_call:
diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-csky.c
similarity index 83%
rename from tools/perf/arch/csky/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-csky.c
index 4a55c84a320a..0b0b09b068ec 100644
--- a/tools/perf/arch/csky/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-csky.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
-
+#include <string.h>
 #include <linux/compiler.h>
+#include "../disasm.h"
 
 static const struct ins_ops *csky__associate_ins_ops(struct arch *arch,
 						     const char *name)
@@ -38,16 +39,10 @@ static const struct ins_ops *csky__associate_ins_ops(struct arch *arch,
 	return ops;
 }
 
-static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	arch->initialized = true;
 	arch->objdump.comment_char = '/';
 	arch->associate_instruction_ops = csky__associate_ins_ops;
-	arch->e_machine = EM_CSKY;
-#if defined(__CSKYABIV2__)
-	arch->e_flags = EF_CSKY_ABIV2;
-#else
-	arch->e_flags = EF_CSKY_ABIV1;
-#endif
 	return 0;
 }
diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
similarity index 93%
rename from tools/perf/arch/loongarch/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-loongarch.c
index 5010d5d58375..32df10f6fed5 100644
--- a/tools/perf/arch/loongarch/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -4,11 +4,17 @@
  *
  * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
  */
+#include <stdlib.h>
+#include <string.h>
+#include <linux/compiler.h>
+#include "../disasm.h"
+#include "../map.h"
+#include "../maps.h"
+#include "../symbol.h"
 
 static int loongarch_call__parse(const struct arch *arch, struct ins_operands *ops,
 				 struct map_symbol *ms,
 				 struct disasm_line *dl __maybe_unused)
-
 {
 	char *c, *endptr, *tok, *name;
 	struct map *map = ms->map;
@@ -51,7 +57,7 @@ static int loongarch_call__parse(const struct arch *arch, struct ins_operands *o
 	return 0;
 }
 
-static const struct ins_ops loongarch_call_ops = {
+const struct ins_ops loongarch_call_ops = {
 	.parse	   = loongarch_call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -100,7 +106,7 @@ static int loongarch_jump__parse(const struct arch *arch, struct ins_operands *o
 	return 0;
 }
 
-static const struct ins_ops loongarch_jump_ops = {
+const struct ins_ops loongarch_jump_ops = {
 	.parse	   = loongarch_jump__parse,
 	.scnprintf = jump__scnprintf,
 };
@@ -130,15 +136,12 @@ const struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char
 	return ops;
 }
 
-static
 int loongarch__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
 		arch->associate_instruction_ops = loongarch__associate_ins_ops;
 		arch->initialized = true;
 		arch->objdump.comment_char = '#';
-		arch->e_machine = EM_LOONGARCH;
-		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/mips/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-mips.c
similarity index 94%
rename from tools/perf/arch/mips/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-mips.c
index 0fbe0a7df95a..f14b34ed77d3 100644
--- a/tools/perf/arch/mips/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-mips.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <linux/compiler.h>
+#include "../disasm.h"
 
 static
 const struct ins_ops *mips__associate_ins_ops(struct arch *arch, const char *name)
@@ -33,15 +36,12 @@ const struct ins_ops *mips__associate_ins_ops(struct arch *arch, const char *nam
 	return ops;
 }
 
-static
 int mips__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
 		arch->associate_instruction_ops = mips__associate_ins_ops;
 		arch->initialized = true;
 		arch->objdump.comment_char = '#';
-		arch->e_machine = EM_MIPS;
-		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-powerpc.c
similarity index 76%
rename from tools/perf/arch/powerpc/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-powerpc.c
index d1be55425e35..593c138c8104 100644
--- a/tools/perf/arch/powerpc/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-powerpc.c
@@ -1,5 +1,97 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <string.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
+#include "../annotate-data.h"
+#include "../debug.h"
+#include "../disasm.h"
+
+#define PPC_OP(op)	(((op) >> 26) & 0x3F)
+#define PPC_21_30(R)	(((R) >> 1) & 0x3ff)
+#define PPC_22_30(R)	(((R) >> 1) & 0x1ff)
+
+#define MINUS_EXT_XO_FORM	234
+#define SUB_EXT_XO_FORM		232
+#define	ADD_ZERO_EXT_XO_FORM	202
+#define	SUB_ZERO_EXT_XO_FORM	200
+
+static int arithmetic__scnprintf(const struct ins *ins, char *bf, size_t size,
+		struct ins_operands *ops, int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
+			ops->raw);
+}
+
+/*
+ * Sets the fields: multi_regs and "mem_ref".
+ * "mem_ref" is set for ops->source which is later used to
+ * fill the objdump->memory_ref-char field. This ops is currently
+ * used by powerpc and since binary instruction code is used to
+ * extract opcode, regs and offset, no other parsing is needed here.
+ *
+ * Dont set multi regs for 4 cases since it has only one operand
+ * for source:
+ * - Add to Minus One Extended XO-form ( Ex: addme, addmeo )
+ * - Subtract From Minus One Extended XO-form ( Ex: subfme )
+ * - Add to Zero Extended XO-form ( Ex: addze, addzeo )
+ * - Subtract From Zero Extended XO-form ( Ex: subfze )
+ */
+static int arithmetic__parse(const struct arch *arch __maybe_unused, struct ins_operands *ops,
+		struct map_symbol *ms __maybe_unused, struct disasm_line *dl)
+{
+	int opcode = PPC_OP(dl->raw.raw_insn);
+
+	ops->source.mem_ref = false;
+	if (opcode == 31) {
+		if ((opcode != MINUS_EXT_XO_FORM) && (opcode != SUB_EXT_XO_FORM) &&
+		    (opcode != ADD_ZERO_EXT_XO_FORM) && (opcode != SUB_ZERO_EXT_XO_FORM))
+			ops->source.multi_regs = true;
+	}
+
+	ops->target.mem_ref = false;
+	ops->target.multi_regs = false;
+
+	return 0;
+}
+
+static const struct ins_ops arithmetic_ops = {
+	.parse     = arithmetic__parse,
+	.scnprintf = arithmetic__scnprintf,
+};
+
+static int load_store__scnprintf(const struct ins *ins, char *bf, size_t size,
+		struct ins_operands *ops, int max_ins_name)
+{
+	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
+			ops->raw);
+}
+
+/*
+ * Sets the fields: multi_regs and "mem_ref".
+ * "mem_ref" is set for ops->source which is later used to
+ * fill the objdump->memory_ref-char field. This ops is currently
+ * used by powerpc and since binary instruction code is used to
+ * extract opcode, regs and offset, no other parsing is needed here
+ */
+static int load_store__parse(const struct arch *arch __maybe_unused, struct ins_operands *ops,
+		struct map_symbol *ms __maybe_unused, struct disasm_line *dl __maybe_unused)
+{
+	ops->source.mem_ref = true;
+	ops->source.multi_regs = false;
+	/* opcode 31 is of X form */
+	if (PPC_OP(dl->raw.raw_insn) == 31)
+		ops->source.multi_regs = true;
+
+	ops->target.mem_ref = false;
+	ops->target.multi_regs = false;
+
+	return 0;
+}
+
+static const struct ins_ops load_store_ops = {
+	.parse     = load_store__parse,
+	.scnprintf = load_store__scnprintf,
+};
 
 static const struct ins_ops *powerpc__associate_instruction_ops(struct arch *arch, const char *name)
 {
@@ -49,10 +141,6 @@ static const struct ins_ops *powerpc__associate_instruction_ops(struct arch *arc
 	return ops;
 }
 
-#define PPC_OP(op)	(((op) >> 26) & 0x3F)
-#define PPC_21_30(R)	(((R) >> 1) & 0x3ff)
-#define PPC_22_30(R)	(((R) >> 1) & 0x1ff)
-
 struct insn_offset {
 	const char	*name;
 	int		value;
@@ -189,7 +277,7 @@ static int cmp_offset(const void *a, const void *b)
 	return (val1->value - val2->value);
 }
 
-static const struct ins_ops *check_ppc_insn(struct disasm_line *dl)
+const struct ins_ops *check_ppc_insn(struct disasm_line *dl)
 {
 	int raw_insn = dl->raw.raw_insn;
 	int opcode = PPC_OP(raw_insn);
@@ -302,15 +390,16 @@ static void update_insn_state_powerpc(struct type_state *state,
 }
 #endif /* HAVE_LIBDW_SUPPORT */
 
-static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
 		arch->initialized = true;
 		arch->associate_instruction_ops = powerpc__associate_instruction_ops;
 		arch->objdump.comment_char      = '#';
 		annotate_opts.show_asm_raw = true;
-		arch->e_machine = EM_PPC;
-		arch->e_flags = 0;
+#ifdef HAVE_LIBDW_SUPPORT
+		arch->update_insn_state = update_insn_state_powerpc;
+#endif
 	}
 
 	return 0;
diff --git a/tools/perf/arch/riscv64/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-riscv64.c
similarity index 91%
rename from tools/perf/arch/riscv64/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-riscv64.c
index a34798864fab..15526824037a 100644
--- a/tools/perf/arch/riscv64/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-riscv64.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <linux/compiler.h>
+#include "../disasm.h"
 
 static
 const struct ins_ops *riscv64__associate_ins_ops(struct arch *arch, const char *name)
@@ -21,15 +24,12 @@ const struct ins_ops *riscv64__associate_ins_ops(struct arch *arch, const char *
 	return ops;
 }
 
-static
 int riscv64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
 		arch->associate_instruction_ops = riscv64__associate_ins_ops;
 		arch->initialized = true;
 		arch->objdump.comment_char = '#';
-		arch->e_machine = EM_RISCV;
-		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-s390.c
similarity index 91%
rename from tools/perf/arch/s390/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-s390.c
index 1b22e6276e7d..81db102b3e15 100644
--- a/tools/perf/arch/s390/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -1,5 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <string.h>
 #include <linux/compiler.h>
+#include "../debug.h"
+#include "../disasm.h"
+#include "../map.h"
+#include "../maps.h"
+#include "../symbol.h"
+#include "../annotate.h"
+#include "../annotate-data.h"
 
 static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 			    struct map_symbol *ms,
@@ -49,7 +57,7 @@ static int s390_call__parse(const struct arch *arch, struct ins_operands *ops,
 	return 0;
 }
 
-static const struct ins_ops s390_call_ops = {
+const struct ins_ops s390_call_ops = {
 	.parse	   = s390_call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -159,7 +167,7 @@ static int s390__cpuid_parse(struct arch *arch, char *cpuid)
 	return -1;
 }
 
-static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	int err = 0;
 
@@ -170,8 +178,7 @@ static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 			if (s390__cpuid_parse(arch, cpuid))
 				err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
 		}
-		arch->e_machine = EM_S390;
-		arch->e_flags = 0;
+		arch->objdump.comment_char = '#';
 	}
 
 	return err;
diff --git a/tools/perf/arch/sparc/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-sparc.c
similarity index 96%
rename from tools/perf/arch/sparc/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-sparc.c
index a08d8734c883..66a0174376dd 100644
--- a/tools/perf/arch/sparc/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-sparc.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <linux/compiler.h>
+#include "../../util/disasm.h"
 
 static int is_branch_cond(const char *cond)
 {
@@ -157,14 +160,12 @@ static const struct ins_ops *sparc__associate_instruction_ops(struct arch *arch,
 	return ops;
 }
 
-static int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 {
 	if (!arch->initialized) {
 		arch->initialized = true;
 		arch->associate_instruction_ops = sparc__associate_instruction_ops;
 		arch->objdump.comment_char = '#';
-		arch->e_machine = EM_SPARC;
-		arch->e_flags = 0;
 	}
 
 	return 0;
diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/util/annotate-arch/annotate-x86.c
similarity index 97%
rename from tools/perf/arch/x86/annotate/instructions.c
rename to tools/perf/util/annotate-arch/annotate-x86.c
index ffca3029388b..0c7957fe60da 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -1,4 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <linux/compiler.h>
+#include <assert.h>
+#include <inttypes.h>
+#include "../annotate-data.h"
+#include "../debug.h"
+#include "../disasm.h"
+#include "../dso.h"
+#include "../map.h"
+#include "../string2.h" // strstarts
+#include "../symbol.h"
+
 /*
  * x86 instruction nmemonic table to parse disasm lines for annotate.
  * This table is searched twice - one for exact match and another for
@@ -191,37 +203,6 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
 	return -1;
 }
 
-static int x86__annotate_init(struct arch *arch, char *cpuid)
-{
-	int err = 0;
-
-	if (arch->initialized)
-		return 0;
-
-	if (cpuid) {
-		if (x86__cpuid_parse(arch, cpuid))
-			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
-	}
-
-#ifndef NDEBUG
-	{
-		static bool sorted_check;
-
-		if (!sorted_check) {
-			for (size_t i = 0; i < arch->nr_instructions - 1; i++) {
-				assert(strcmp(arch->instructions[i].name,
-					      arch->instructions[i + 1].name) <= 0);
-			}
-			sorted_check = true;
-		}
-	}
-#endif
-	arch->e_machine = EM_X86_64;
-	arch->e_flags = 0;
-	arch->initialized = true;
-	return err;
-}
-
 #ifdef HAVE_LIBDW_SUPPORT
 static void update_insn_state_x86(struct type_state *state,
 				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
@@ -795,3 +776,45 @@ static void update_insn_state_x86(struct type_state *state,
 	/* Case 4. memory to memory transfers (not handled for now) */
 }
 #endif
+
+int x86__annotate_init(struct arch *arch, char *cpuid)
+{
+	int err = 0;
+
+	if (arch->initialized)
+		return 0;
+
+	if (cpuid) {
+		if (x86__cpuid_parse(arch, cpuid))
+			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+	}
+
+	arch->instructions = x86__instructions;
+	arch->nr_instructions = ARRAY_SIZE(x86__instructions);
+#ifndef NDEBUG
+	{
+		static bool sorted_check;
+
+		if (!sorted_check) {
+			for (size_t i = 0; i < arch->nr_instructions - 1; i++) {
+				assert(strcmp(arch->instructions[i].name,
+					      arch->instructions[i + 1].name) <= 0);
+			}
+			sorted_check = true;
+		}
+	}
+#endif
+	arch->sorted_instructions = true;
+	arch->objdump.comment_char = '#';
+	arch->objdump.register_char = '%';
+	arch->objdump.memory_ref_char = '(';
+	arch->objdump.imm_char = '$';
+	arch->insn_suffix = "bwlq";
+	arch->e_machine = EM_X86_64;
+	arch->e_flags = 0;
+	arch->initialized = true;
+#ifdef HAVE_LIBDW_SUPPORT
+	arch->update_insn_state = update_insn_state_x86;
+#endif
+	return err;
+}
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index b7523256c4ad..845c2d0f39b1 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -33,20 +33,15 @@
 static regex_t	 file_lineno;
 
 /* These can be referred from the arch-dependent code */
-static const struct ins_ops call_ops;
-static const struct ins_ops dec_ops;
-static const struct ins_ops jump_ops;
-static const struct ins_ops mov_ops;
-static const struct ins_ops nop_ops;
-static const struct ins_ops lock_ops;
-static const struct ins_ops ret_ops;
-static const struct ins_ops load_store_ops;
-static const struct ins_ops arithmetic_ops;
-
-static int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops, int max_ins_name);
-static int call__scnprintf(const struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops, int max_ins_name);
+const struct ins_ops call_ops;
+const struct ins_ops dec_ops;
+const struct ins_ops jump_ops;
+const struct ins_ops mov_ops;
+const struct ins_ops nop_ops;
+const struct ins_ops lock_ops;
+const struct ins_ops ret_ops;
+const struct ins_ops load_store_ops;
+const struct ins_ops arithmetic_ops;
 
 static void ins__sort(struct arch *arch);
 static int disasm_line__parse(char *line, const char **namep, char **rawp);
@@ -86,7 +81,7 @@ static int arch__grow_instructions(struct arch *arch)
 	goto out_update_instructions;
 }
 
-static int arch__associate_ins_ops(struct arch *arch, const char *name, const struct ins_ops *ops)
+int arch__associate_ins_ops(struct arch *arch, const char *name, const struct ins_ops *ops)
 {
 	struct ins *ins;
 
@@ -106,90 +101,66 @@ static int arch__associate_ins_ops(struct arch *arch, const char *name, const st
 	return 0;
 }
 
-#include "arch/arc/annotate/instructions.c"
-#include "arch/arm/annotate/instructions.c"
-#include "arch/arm64/annotate/instructions.c"
-#include "arch/csky/annotate/instructions.c"
-#include "arch/loongarch/annotate/instructions.c"
-#include "arch/mips/annotate/instructions.c"
-#include "arch/x86/annotate/instructions.c"
-#include "arch/powerpc/annotate/instructions.c"
-#include "arch/riscv64/annotate/instructions.c"
-#include "arch/s390/annotate/instructions.c"
-#include "arch/sparc/annotate/instructions.c"
-
 static struct arch architectures[] = {
 	{
 		.name = "arc",
 		.init = arc__annotate_init,
+		.e_machine = EM_ARC,
 	},
 	{
 		.name = "arm",
 		.init = arm__annotate_init,
+		.e_machine = EM_ARM,
 	},
 	{
 		.name = "arm64",
 		.init = arm64__annotate_init,
+		.e_machine = EM_AARCH64,
 	},
 	{
 		.name = "csky",
 		.init = csky__annotate_init,
+		.e_machine = EM_CSKY,
+#if defined(__CSKYABIV2__)
+		.e_flags = EF_CSKY_ABIV2,
+#else
+		.e_flags = EF_CSKY_ABIV1,
+#endif
 	},
 	{
 		.name = "mips",
 		.init = mips__annotate_init,
-		.objdump = {
-			.comment_char = '#',
-		},
+		.e_machine = EM_MIPS,
 	},
 	{
 		.name = "x86",
 		.init = x86__annotate_init,
-		.instructions = x86__instructions,
-		.nr_instructions = ARRAY_SIZE(x86__instructions),
-		.sorted_instructions = true,
-		.insn_suffix = "bwlq",
-		.objdump =  {
-			.comment_char = '#',
-			.register_char = '%',
-			.memory_ref_char = '(',
-			.imm_char = '$',
-		},
-#ifdef HAVE_LIBDW_SUPPORT
-		.update_insn_state = update_insn_state_x86,
-#endif
+		.e_machine = EM_X86_64, // TODO: EM_386 too.
 	},
 	{
 		.name = "powerpc",
 		.init = powerpc__annotate_init,
-#ifdef HAVE_LIBDW_SUPPORT
-		.update_insn_state = update_insn_state_powerpc,
-#endif
+		.e_machine = EM_PPC, // TODO: EM_PPC64 too.
 	},
 	{
 		.name = "riscv64",
 		.init = riscv64__annotate_init,
+		.e_machine = EM_RISCV,
 	},
 	{
 		.name = "s390",
 		.init = s390__annotate_init,
-		.objdump =  {
-			.comment_char = '#',
-		},
+		.e_machine = EM_S390,
 	},
 	{
 		.name = "sparc",
 		.init = sparc__annotate_init,
-		.objdump = {
-			.comment_char = '#',
-		},
+		.e_machine = EM_SPARC,
 	},
 	{
 		.name = "loongarch",
 		.init = loongarch__annotate_init,
-		.objdump = {
-			.comment_char = '#',
-		},
+		.e_machine = EM_LOONGARCH,
 	},
 };
 
@@ -248,14 +219,14 @@ static void ins_ops__delete(struct ins_operands *ops)
 	zfree(&ops->target.name);
 }
 
-static int ins__raw_scnprintf(const struct ins *ins, char *bf, size_t size,
-			      struct ins_operands *ops, int max_ins_name)
+int ins__raw_scnprintf(const struct ins *ins, char *bf, size_t size,
+			   struct ins_operands *ops, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-static int ins__scnprintf(const struct ins *ins, char *bf, size_t size,
-			  struct ins_operands *ops, int max_ins_name)
+int ins__scnprintf(const struct ins *ins, char *bf, size_t size,
+		   struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
 		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
@@ -326,8 +297,8 @@ static int call__parse(const struct arch *arch, struct ins_operands *ops, struct
 	goto find_target;
 }
 
-static int call__scnprintf(const struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops, int max_ins_name)
+int call__scnprintf(const struct ins *ins, char *bf, size_t size,
+		      struct ins_operands *ops, int max_ins_name)
 {
 	if (ops->target.sym)
 		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->target.sym->name);
@@ -341,7 +312,7 @@ static int call__scnprintf(const struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s *%" PRIx64, max_ins_name, ins->name, ops->target.addr);
 }
 
-static const struct ins_ops call_ops = {
+const struct ins_ops call_ops = {
 	.parse	   = call__parse,
 	.scnprintf = call__scnprintf,
 };
@@ -453,8 +424,8 @@ static int jump__parse(const struct arch *arch, struct ins_operands *ops, struct
 	return 0;
 }
 
-static int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops, int max_ins_name)
+int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
+		      struct ins_operands *ops, int max_ins_name)
 {
 	const char *c;
 
@@ -494,7 +465,7 @@ static void jump__delete(struct ins_operands *ops __maybe_unused)
 	 */
 }
 
-static const struct ins_ops jump_ops = {
+const struct ins_ops jump_ops = {
 	.free	   = jump__delete,
 	.parse	   = jump__parse,
 	.scnprintf = jump__scnprintf,
@@ -586,7 +557,7 @@ static void lock__delete(struct ins_operands *ops)
 	zfree(&ops->target.name);
 }
 
-static const struct ins_ops lock_ops = {
+const struct ins_ops lock_ops = {
 	.free	   = lock__delete,
 	.parse	   = lock__parse,
 	.scnprintf = lock__scnprintf,
@@ -687,103 +658,19 @@ static int mov__parse(const struct arch *arch, struct ins_operands *ops,
 	return -1;
 }
 
-static int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
-			   struct ins_operands *ops, int max_ins_name)
+int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
+		     struct ins_operands *ops, int max_ins_name)
 {
 	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
 			 ops->source.name ?: ops->source.raw,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static const struct ins_ops mov_ops = {
+const struct ins_ops mov_ops = {
 	.parse	   = mov__parse,
 	.scnprintf = mov__scnprintf,
 };
 
-#define PPC_22_30(R)    (((R) >> 1) & 0x1ff)
-#define MINUS_EXT_XO_FORM	234
-#define SUB_EXT_XO_FORM		232
-#define	ADD_ZERO_EXT_XO_FORM	202
-#define	SUB_ZERO_EXT_XO_FORM	200
-
-static int arithmetic__scnprintf(const struct ins *ins, char *bf, size_t size,
-		struct ins_operands *ops, int max_ins_name)
-{
-	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
-			ops->raw);
-}
-
-/*
- * Sets the fields: multi_regs and "mem_ref".
- * "mem_ref" is set for ops->source which is later used to
- * fill the objdump->memory_ref-char field. This ops is currently
- * used by powerpc and since binary instruction code is used to
- * extract opcode, regs and offset, no other parsing is needed here.
- *
- * Dont set multi regs for 4 cases since it has only one operand
- * for source:
- * - Add to Minus One Extended XO-form ( Ex: addme, addmeo )
- * - Subtract From Minus One Extended XO-form ( Ex: subfme )
- * - Add to Zero Extended XO-form ( Ex: addze, addzeo )
- * - Subtract From Zero Extended XO-form ( Ex: subfze )
- */
-static int arithmetic__parse(const struct arch *arch __maybe_unused, struct ins_operands *ops,
-		struct map_symbol *ms __maybe_unused, struct disasm_line *dl)
-{
-	int opcode = PPC_OP(dl->raw.raw_insn);
-
-	ops->source.mem_ref = false;
-	if (opcode == 31) {
-		if ((opcode != MINUS_EXT_XO_FORM) && (opcode != SUB_EXT_XO_FORM) \
-				&& (opcode != ADD_ZERO_EXT_XO_FORM) && (opcode != SUB_ZERO_EXT_XO_FORM))
-			ops->source.multi_regs = true;
-	}
-
-	ops->target.mem_ref = false;
-	ops->target.multi_regs = false;
-
-	return 0;
-}
-
-static const struct ins_ops arithmetic_ops = {
-	.parse     = arithmetic__parse,
-	.scnprintf = arithmetic__scnprintf,
-};
-
-static int load_store__scnprintf(const struct ins *ins, char *bf, size_t size,
-		struct ins_operands *ops, int max_ins_name)
-{
-	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name,
-			ops->raw);
-}
-
-/*
- * Sets the fields: multi_regs and "mem_ref".
- * "mem_ref" is set for ops->source which is later used to
- * fill the objdump->memory_ref-char field. This ops is currently
- * used by powerpc and since binary instruction code is used to
- * extract opcode, regs and offset, no other parsing is needed here
- */
-static int load_store__parse(const struct arch *arch __maybe_unused, struct ins_operands *ops,
-		struct map_symbol *ms __maybe_unused, struct disasm_line *dl __maybe_unused)
-{
-	ops->source.mem_ref = true;
-	ops->source.multi_regs = false;
-	/* opcode 31 is of X form */
-	if (PPC_OP(dl->raw.raw_insn) == 31)
-		ops->source.multi_regs = true;
-
-	ops->target.mem_ref = false;
-	ops->target.multi_regs = false;
-
-	return 0;
-}
-
-static const struct ins_ops load_store_ops = {
-	.parse     = load_store__parse,
-	.scnprintf = load_store__scnprintf,
-};
-
 static int dec__parse(const struct arch *arch __maybe_unused, struct ins_operands *ops,
 		      struct map_symbol *ms __maybe_unused,
 		      struct disasm_line *dl __maybe_unused)
@@ -820,7 +707,7 @@ static int dec__scnprintf(const struct ins *ins, char *bf, size_t size,
 			 ops->target.name ?: ops->target.raw);
 }
 
-static const struct ins_ops dec_ops = {
+const struct ins_ops dec_ops = {
 	.parse	   = dec__parse,
 	.scnprintf = dec__scnprintf,
 };
@@ -831,11 +718,11 @@ static int nop__scnprintf(const struct ins *ins __maybe_unused, char *bf, size_t
 	return scnprintf(bf, size, "%-*s", max_ins_name, "nop");
 }
 
-static const struct ins_ops nop_ops = {
+const struct ins_ops nop_ops = {
 	.scnprintf = nop__scnprintf,
 };
 
-static const struct ins_ops ret_ops = {
+const struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index db7f1ee3d8e7..83503c5075f9 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -109,6 +109,28 @@ const struct arch *arch__find(const char *name);
 bool arch__is_x86(const struct arch *arch);
 bool arch__is_powerpc(const struct arch *arch);
 
+extern const struct ins_ops call_ops;
+extern const struct ins_ops dec_ops;
+extern const struct ins_ops jump_ops;
+extern const struct ins_ops mov_ops;
+extern const struct ins_ops nop_ops;
+extern const struct ins_ops lock_ops;
+extern const struct ins_ops ret_ops;
+
+int arch__associate_ins_ops(struct arch *arch, const char *name, const struct ins_ops *ops);
+
+int arc__annotate_init(struct arch *arch, char *cpuid);
+int arm__annotate_init(struct arch *arch, char *cpuid);
+int arm64__annotate_init(struct arch *arch, char *cpuid);
+int csky__annotate_init(struct arch *arch, char *cpuid);
+int loongarch__annotate_init(struct arch *arch, char *cpuid);
+int mips__annotate_init(struct arch *arch, char *cpuid);
+int powerpc__annotate_init(struct arch *arch, char *cpuid);
+int riscv64__annotate_init(struct arch *arch, char *cpuid);
+int s390__annotate_init(struct arch *arch, char *cpuid);
+int sparc__annotate_init(struct arch *arch, char *cpuid);
+int x86__annotate_init(struct arch *arch, char *cpuid);
+
 const struct ins_ops *ins__find(const struct arch *arch, const char *name, struct disasm_line *dl);
 
 bool ins__is_call(const struct ins *ins);
@@ -117,12 +139,28 @@ bool ins__is_fused(const struct arch *arch, const char *ins1, const char *ins2);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 
+extern const struct ins_ops s390_call_ops;
+extern const struct ins_ops loongarch_call_ops;
+extern const struct ins_ops loongarch_jump_ops;
+const struct ins_ops *check_ppc_insn(struct disasm_line *dl);
+
 struct disasm_line *disasm_line__new(struct annotate_args *args);
 void disasm_line__free(struct disasm_line *dl);
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size,
 			   bool raw, int max_ins_name);
 
+int ins__raw_scnprintf(const struct ins *ins, char *bf, size_t size,
+			   struct ins_operands *ops, int max_ins_name);
+int ins__scnprintf(const struct ins *ins, char *bf, size_t size,
+		   struct ins_operands *ops, int max_ins_name);
+int call__scnprintf(const struct ins *ins, char *bf, size_t size,
+		    struct ins_operands *ops, int max_ins_name);
+int jump__scnprintf(const struct ins *ins, char *bf, size_t size,
+		    struct ins_operands *ops, int max_ins_name);
+int mov__scnprintf(const struct ins *ins, char *bf, size_t size,
+		   struct ins_operands *ops, int max_ins_name);
+
 int symbol__disassemble(struct symbol *sym, struct annotate_args *args);
 
 char *expand_tabs(char *line, char **storage, size_t *storage_len);
-- 
2.52.0.457.g6b5491de43-goog

