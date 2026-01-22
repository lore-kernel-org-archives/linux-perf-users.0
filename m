Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5489480DF5
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067120; cv=none; b=Hs2+cwjE2Xf2Nyi8uIaElJFwG85eFxPXxPt3k+EqvQU8jqKKmxGn3fNGfL+xd7NX/qbX3vf71svL/q4X2l02ZkugWmYMge1v//xDJI/1431cDT0VNGPjP/6ndhscB0oWLN7CmIVKkJNnutZlNy1iZ6HSvDi9T3IiEBAXhc9la7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067120; c=relaxed/simple;
	bh=v+aTeeAV8nhOFL8+eVICd0d4UiUDga/acNumVc4sLTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qZmkA1Im3hWnw9onv9mJXvYCzFnygHesS51QWlXWzg4Ld++kOQIE1fIxZ3b/Io+rZZMgDyrC6vzP6WY2hySJHE/J5NEOHlQ77Z1spJH4VXRsfFeYNOoEiZ5azDt8f6iMRwXE+FjioKjLl6kFLQ3/oBOc9ltF2vIWkAka6euEBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EKOiXkFP; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKOiXkFP"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b72a9a9715so1390502eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769067109; x=1769671909; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRR5J/0mXEgLBS6l/XCegg4cpSLNBAVJGyQiUAqW/FE=;
        b=EKOiXkFP9/b6MR/uUVtcIfsvdGw3CJmdsJjODxYASK64OF9Hqn+MwlPBYLv2RROu0K
         rA3aaGPra4D6AyXtlqOvPMc9jcUQR8ZMjih2MH8JZZoFlX+j4ogY9EYrA0znIxIrQVAW
         sb1yjn+rkPhO79OINRnickki/OcFg2k+Cd8wLEMkBO+8meLEMZBN+LRjrHLDIirPQGVV
         8CbETMfyoHe1g+DtQVZkcGoksPDSS9URmkRIaEiEJLtdOS3ut4gBUaKKlRSLJ/swmbtF
         PiCtWu7TmfI660o7/JtQHXa7JFjgdTfnyNjN02Cb3FrGfQhc1jnWR1DOYB8DhaE6dSo7
         t9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067109; x=1769671909;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRR5J/0mXEgLBS6l/XCegg4cpSLNBAVJGyQiUAqW/FE=;
        b=UMswlJyXPbEhMHbvBOrQhaj+wRQIiRQEp/ntXMdDlNnQDhJzAO+MOyAkUJJrodRRBY
         YWMa05IoMH39US/V7aWBKVRm4cxJDeHTsh41Upl+K/lf7DeIiXCRlzByTKxVj9FaPdTm
         flHoLrboViewQFTXJUB7FU5PcMPQbli+u8kJAAwEa4Slwqa/KRZne72FJXCNdp+9E6Hy
         hv72nsZGXT8fsBM/6drSzkE8dI0fveXcVa16ZgG4UhF0JuuupLAAWPHynyOkNAPXIcB8
         TNn4ylL4XuzqaUlRf0ij8BRFlfr0cvND5lSUw1L9z5RMld80+f8EWj4GKc1yq2kKA1lD
         vgGg==
X-Forwarded-Encrypted: i=1; AJvYcCWOYdfdZ+bqVdrWhDjuB7qotEkD8XkWOhJCMFsnLwPuVSdHBw3s0/EJcjerUAN7EhpyXwSpLwz035IYDMjbfcUb@vger.kernel.org
X-Gm-Message-State: AOJu0YySA4DgLY9l5jAdYFeE5Pgc8UfH7DE4zO6v+u1CykxkNBesp1yi
	REAVPiLBHqcRWNyAD7qdQx1ZyEVkE6n0LzES5lZWKAfqHZYEZrtuUmnMmvrDtlWPBamPIOBQCTY
	YBtcuQpF5KA==
X-Received: from dyke40.prod.google.com ([2002:a05:7300:4728:b0:2a2:4eb1:3771])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6508:b0:2b6:aeb8:3d8c
 with SMTP id 5a478bee46e88-2b6b503bcb5mr15638769eec.32.1769067108802; Wed, 21
 Jan 2026 23:31:48 -0800 (PST)
Date: Wed, 21 Jan 2026 23:31:26 -0800
In-Reply-To: <20260122073127.375139-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122073127.375139-11-irogers@google.com>
Subject: [PATCH v1 10/11] perf disasm: Refactor arch__find and initialization
 of arch structs
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

Switch arch__find to using an ELF machine number rather than a
string. Rather than an array of fixed size arch structs turn the init
functions into new functions indexed by the ELF machine they
correspond to. This allows data to be stored with a struct arch with
the container_of trick, so the priv variable can be removed. Switch to
using the thread to find the arch rather than the evsel as the evsel
only has limited notions of the running thread upon which disassembly
is performed. Factor out the e_machine and e_flags into their own
struct to make them easier to pass around.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/annotate.c             |   2 +-
 tools/perf/util/annotate-arch/annotate-arc.c  |  14 +-
 tools/perf/util/annotate-arch/annotate-arm.c  |  37 +++--
 .../perf/util/annotate-arch/annotate-arm64.c  |  39 +++--
 tools/perf/util/annotate-arch/annotate-csky.c |  14 +-
 .../util/annotate-arch/annotate-loongarch.c   |  19 ++-
 tools/perf/util/annotate-arch/annotate-mips.c |  19 ++-
 .../util/annotate-arch/annotate-powerpc.c     |  22 +--
 .../util/annotate-arch/annotate-riscv64.c     |  19 ++-
 tools/perf/util/annotate-arch/annotate-s390.c |  29 ++--
 .../perf/util/annotate-arch/annotate-sparc.c  |  17 +-
 tools/perf/util/annotate-arch/annotate-x86.c  |  24 +--
 tools/perf/util/annotate.c                    |  46 +++---
 tools/perf/util/annotate.h                    |   2 +-
 tools/perf/util/disasm.c                      | 153 ++++++++----------
 tools/perf/util/disasm.h                      |  59 +++----
 16 files changed, 278 insertions(+), 237 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 91ded9c271ee..ea17e6d29a7e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -1198,7 +1198,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 				ui__warning("Annotation has no source code.");
 		}
 	} else {
-		err = evsel__get_arch(evsel, &browser.arch);
+		err = thread__get_arch(ms->thread, &browser.arch);
 		if (err) {
 			annotate_browser__symbol_annotate_error(&browser, err);
 			return -1;
diff --git a/tools/perf/util/annotate-arch/annotate-arc.c b/tools/perf/util/annotate-arch/annotate-arc.c
index d7ca08ca5600..170103e383a4 100644
--- a/tools/perf/util/annotate-arch/annotate-arc.c
+++ b/tools/perf/util/annotate-arch/annotate-arc.c
@@ -1,10 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include "../disasm.h"
 
-int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_arc(const struct e_machine_and_e_flags *id,
+				 const char *cpuid __maybe_unused)
 {
-	arch->initialized = true;
+	struct arch *arch = zalloc(sizeof(*arch));
+
+	if (!arch)
+		return NULL;
+
+	arch->name = "arc";
+	arch->id = *id;
 	arch->objdump.comment_char = ';';
-	return 0;
+	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-arm.c b/tools/perf/util/annotate-arch/annotate-arm.c
index 08c49067c3c9..25086f5fce23 100644
--- a/tools/perf/util/annotate-arch/annotate-arm.c
+++ b/tools/perf/util/annotate-arch/annotate-arm.c
@@ -7,14 +7,15 @@
 #include "../annotate.h"
 #include "../disasm.h"
 
-struct arm_annotate {
-	regex_t call_insn,
-		jump_insn;
+struct arch_arm {
+	struct arch arch;
+	regex_t call_insn;
+	regex_t jump_insn;
 };
 
 static const struct ins_ops *arm__associate_instruction_ops(struct arch *arch, const char *name)
 {
-	struct arm_annotate *arm = arch->priv;
+	struct arch_arm *arm = container_of(arch, struct arch_arm, arch);
 	const struct ins_ops *ops;
 	regmatch_t match[2];
 
@@ -29,37 +30,39 @@ static const struct ins_ops *arm__associate_instruction_ops(struct arch *arch, c
 	return ops;
 }
 
-int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_arm(const struct e_machine_and_e_flags *id,
+				 const char *cpuid __maybe_unused)
 {
-	struct arm_annotate *arm;
 	int err;
+	struct arch_arm *arm = zalloc(sizeof(*arm));
+	struct arch *arch;
 
-	if (arch->initialized)
-		return 0;
-
-	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return ENOMEM;
+		return NULL;
+
+	arch = &arm->arch;
+	arch->name = "arm";
+	arch->id = *id;
+	arch->objdump.comment_char	  = ';';
+	arch->objdump.skip_functions_char = '+';
+	arch->associate_instruction_ops   = arm__associate_instruction_ops;
 
 #define ARM_CONDS "(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl|vc|vs)"
 	err = regcomp(&arm->call_insn, "^blx?" ARM_CONDS "?$", REG_EXTENDED);
 	if (err)
 		goto out_free_arm;
+
 	err = regcomp(&arm->jump_insn, "^bx?" ARM_CONDS "?$", REG_EXTENDED);
 	if (err)
 		goto out_free_call;
 #undef ARM_CONDS
 
-	arch->initialized = true;
-	arch->priv	  = arm;
-	arch->associate_instruction_ops   = arm__associate_instruction_ops;
-	arch->objdump.comment_char	  = ';';
-	arch->objdump.skip_functions_char = '+';
 	return 0;
 
 out_free_call:
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
+	errno = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
+	return NULL;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
index d2ea32984b0d..da45c7d05757 100644
--- a/tools/perf/util/annotate-arch/annotate-arm64.c
+++ b/tools/perf/util/annotate-arch/annotate-arm64.c
@@ -8,9 +8,10 @@
 #include "../annotate.h"
 #include "../disasm.h"
 
-struct arm64_annotate {
-	regex_t call_insn,
-		jump_insn;
+struct arch_arm64 {
+	struct arch arch;
+	regex_t call_insn;
+	regex_t jump_insn;
 };
 
 static int arm64_mov__parse(const struct arch *arch __maybe_unused,
@@ -70,7 +71,7 @@ static const struct ins_ops arm64_mov_ops = {
 
 static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
 {
-	struct arm64_annotate *arm = arch->priv;
+	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
 	const struct ins_ops *ops;
 	regmatch_t match[2];
 
@@ -87,38 +88,44 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
 	return ops;
 }
 
-int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
+				   const char *cpuid __maybe_unused)
 {
-	struct arm64_annotate *arm;
 	int err;
+	struct arch_arm64 *arm = zalloc(sizeof(*arm));
+	struct arch *arch;
 
-	if (arch->initialized)
-		return 0;
+	if (!arm)
+		return NULL;
+
+	arch = &arm->arch;
+	arch->name = "arm64";
+	arch->id = *id;
+	arch->objdump.comment_char	  = '/';
+	arch->objdump.skip_functions_char = '+';
+	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
 
 	arm = zalloc(sizeof(*arm));
 	if (!arm)
-		return ENOMEM;
+		return NULL;
 
 	/* bl, blr */
 	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
 	if (err)
 		goto out_free_arm;
+
 	/* b, b.cond, br, cbz/cbnz, tbz/tbnz */
 	err = regcomp(&arm->jump_insn, "^[ct]?br?\\.?(cc|cs|eq|ge|gt|hi|hs|le|lo|ls|lt|mi|ne|pl|vc|vs)?n?z?$",
 		      REG_EXTENDED);
 	if (err)
 		goto out_free_call;
 
-	arch->initialized = true;
-	arch->priv	  = arm;
-	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
-	arch->objdump.comment_char	  = '/';
-	arch->objdump.skip_functions_char = '+';
-	return 0;
+	return arch;
 
 out_free_call:
 	regfree(&arm->call_insn);
 out_free_arm:
 	free(arm);
-	return SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
+	errno = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP;
+	return NULL;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-csky.c b/tools/perf/util/annotate-arch/annotate-csky.c
index 0b0b09b068ec..d2b18e4ea2c9 100644
--- a/tools/perf/util/annotate-arch/annotate-csky.c
+++ b/tools/perf/util/annotate-arch/annotate-csky.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
 #include <string.h>
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include "../disasm.h"
 
 static const struct ins_ops *csky__associate_ins_ops(struct arch *arch,
@@ -39,10 +40,17 @@ static const struct ins_ops *csky__associate_ins_ops(struct arch *arch,
 	return ops;
 }
 
-int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_csky(const struct e_machine_and_e_flags *id,
+				  const char *cpuid __maybe_unused)
 {
-	arch->initialized = true;
+	struct arch *arch = zalloc(sizeof(*arch));
+
+	if (!arch)
+		return NULL;
+
+	arch->name = "csky";
+	arch->id = *id;
 	arch->objdump.comment_char = '/';
 	arch->associate_instruction_ops = csky__associate_ins_ops;
-	return 0;
+	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-loongarch.c b/tools/perf/util/annotate-arch/annotate-loongarch.c
index a23744eafd6a..2027e3b816f4 100644
--- a/tools/perf/util/annotate-arch/annotate-loongarch.c
+++ b/tools/perf/util/annotate-arch/annotate-loongarch.c
@@ -7,6 +7,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include "../disasm.h"
 #include "../map.h"
 #include "../maps.h"
@@ -137,13 +138,17 @@ const struct ins_ops *loongarch__associate_ins_ops(struct arch *arch, const char
 	return ops;
 }
 
-int loongarch__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_loongarch(const struct e_machine_and_e_flags *id,
+				       const char *cpuid __maybe_unused)
 {
-	if (!arch->initialized) {
-		arch->associate_instruction_ops = loongarch__associate_ins_ops;
-		arch->initialized = true;
-		arch->objdump.comment_char = '#';
-	}
+	struct arch *arch = zalloc(sizeof(*arch));
 
-	return 0;
+	if (!arch)
+		return NULL;
+
+	arch->name = "loongarch";
+	arch->id = *id;
+	arch->associate_instruction_ops = loongarch__associate_ins_ops;
+	arch->objdump.comment_char = '#';
+	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-mips.c b/tools/perf/util/annotate-arch/annotate-mips.c
index f14b34ed77d3..e8d1c6c7e9f3 100644
--- a/tools/perf/util/annotate-arch/annotate-mips.c
+++ b/tools/perf/util/annotate-arch/annotate-mips.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include "../disasm.h"
 
 static
@@ -36,13 +37,17 @@ const struct ins_ops *mips__associate_ins_ops(struct arch *arch, const char *nam
 	return ops;
 }
 
-int mips__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_mips(const struct e_machine_and_e_flags *id,
+				  const char *cpuid __maybe_unused)
 {
-	if (!arch->initialized) {
-		arch->associate_instruction_ops = mips__associate_ins_ops;
-		arch->initialized = true;
-		arch->objdump.comment_char = '#';
-	}
+	struct arch *arch = zalloc(sizeof(*arch));
 
-	return 0;
+	if (!arch)
+		return NULL;
+
+	arch->name = "mips";
+	arch->id = *id;
+	arch->objdump.comment_char = '#';
+	arch->associate_instruction_ops = mips__associate_ins_ops;
+	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-powerpc.c b/tools/perf/util/annotate-arch/annotate-powerpc.c
index 593c138c8104..004e6137aa03 100644
--- a/tools/perf/util/annotate-arch/annotate-powerpc.c
+++ b/tools/perf/util/annotate-arch/annotate-powerpc.c
@@ -390,17 +390,21 @@ static void update_insn_state_powerpc(struct type_state *state,
 }
 #endif /* HAVE_LIBDW_SUPPORT */
 
-int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id,
+				     const char *cpuid __maybe_unused)
 {
-	if (!arch->initialized) {
-		arch->initialized = true;
-		arch->associate_instruction_ops = powerpc__associate_instruction_ops;
-		arch->objdump.comment_char      = '#';
-		annotate_opts.show_asm_raw = true;
+	struct arch *arch = zalloc(sizeof(*arch));
+
+	if (!arch)
+		return NULL;
+
+	arch->name = "powerpc";
+	arch->id = *id;
+	arch->objdump.comment_char = '#';
+	annotate_opts.show_asm_raw = true;
+	arch->associate_instruction_ops = powerpc__associate_instruction_ops;
 #ifdef HAVE_LIBDW_SUPPORT
-		arch->update_insn_state = update_insn_state_powerpc;
+	arch->update_insn_state = update_insn_state_powerpc;
 #endif
-	}
-
 	return 0;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-riscv64.c b/tools/perf/util/annotate-arch/annotate-riscv64.c
index 15526824037a..29a988fca8c9 100644
--- a/tools/perf/util/annotate-arch/annotate-riscv64.c
+++ b/tools/perf/util/annotate-arch/annotate-riscv64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include "../disasm.h"
 
 static
@@ -24,13 +25,17 @@ const struct ins_ops *riscv64__associate_ins_ops(struct arch *arch, const char *
 	return ops;
 }
 
-int riscv64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_riscv64(const struct e_machine_and_e_flags *id,
+				     const char *cpuid __maybe_unused)
 {
-	if (!arch->initialized) {
-		arch->associate_instruction_ops = riscv64__associate_ins_ops;
-		arch->initialized = true;
-		arch->objdump.comment_char = '#';
-	}
+	struct arch *arch = zalloc(sizeof(*arch));
 
-	return 0;
+	if (!arch)
+		return NULL;
+
+	arch->name = "riscv";
+	arch->id = *id;
+	arch->objdump.comment_char = '#';
+	arch->associate_instruction_ops = riscv64__associate_ins_ops;
+	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-s390.c b/tools/perf/util/annotate-arch/annotate-s390.c
index cb112c1ba090..094b2e125363 100644
--- a/tools/perf/util/annotate-arch/annotate-s390.c
+++ b/tools/perf/util/annotate-arch/annotate-s390.c
@@ -145,7 +145,7 @@ static const struct ins_ops *s390__associate_ins_ops(struct arch *arch, const ch
 	return ops;
 }
 
-static int s390__cpuid_parse(struct arch *arch, char *cpuid)
+static int s390__cpuid_parse(struct arch *arch, const char *cpuid)
 {
 	unsigned int family;
 	char model[16], model_c[16], cpumf_v[16], cpumf_a[16];
@@ -166,19 +166,22 @@ static int s390__cpuid_parse(struct arch *arch, char *cpuid)
 	return -1;
 }
 
-int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_s390(const struct e_machine_and_e_flags *id, const char *cpuid)
 {
-	int err = 0;
-
-	if (!arch->initialized) {
-		arch->initialized = true;
-		arch->associate_instruction_ops = s390__associate_ins_ops;
-		if (cpuid) {
-			if (s390__cpuid_parse(arch, cpuid))
-				err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+	struct arch *arch = zalloc(sizeof(*arch));
+
+	if (!arch)
+		return NULL;
+
+	arch->name = "s390";
+	arch->id = *id;
+	arch->associate_instruction_ops = s390__associate_ins_ops;
+	if (cpuid) {
+		if (s390__cpuid_parse(arch, cpuid)) {
+			errno = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+			return NULL;
 		}
-		arch->objdump.comment_char = '#';
 	}
-
-	return err;
+	arch->objdump.comment_char = '#';
+	return arch;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-sparc.c b/tools/perf/util/annotate-arch/annotate-sparc.c
index 66a0174376dd..fe7a37966261 100644
--- a/tools/perf/util/annotate-arch/annotate-sparc.c
+++ b/tools/perf/util/annotate-arch/annotate-sparc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 #include <linux/compiler.h>
+#include <linux/zalloc.h>
 #include "../../util/disasm.h"
 
 static int is_branch_cond(const char *cond)
@@ -160,13 +161,17 @@ static const struct ins_ops *sparc__associate_instruction_ops(struct arch *arch,
 	return ops;
 }
 
-int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
+const struct arch *arch__new_sparc(const struct e_machine_and_e_flags *id,
+				   const char *cpuid __maybe_unused)
 {
-	if (!arch->initialized) {
-		arch->initialized = true;
-		arch->associate_instruction_ops = sparc__associate_instruction_ops;
-		arch->objdump.comment_char = '#';
-	}
+	struct arch *arch = zalloc(sizeof(*arch));
+
+	if (!arch)
+		return NULL;
 
+	arch->name = "sparc";
+	arch->id = *id;
+	arch->associate_instruction_ops = sparc__associate_instruction_ops;
+	arch->objdump.comment_char = '#';
 	return 0;
 }
diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
index 0c7957fe60da..eb9a649ca656 100644
--- a/tools/perf/util/annotate-arch/annotate-x86.c
+++ b/tools/perf/util/annotate-arch/annotate-x86.c
@@ -182,7 +182,7 @@ static bool intel__ins_is_fused(const struct arch *arch, const char *ins1,
 	return false;
 }
 
-static int x86__cpuid_parse(struct arch *arch, char *cpuid)
+static int x86__cpuid_parse(struct arch *arch, const char *cpuid)
 {
 	unsigned int family, model, stepping;
 	int ret;
@@ -777,18 +777,21 @@ static void update_insn_state_x86(struct type_state *state,
 }
 #endif
 
-int x86__annotate_init(struct arch *arch, char *cpuid)
+const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const char *cpuid)
 {
-	int err = 0;
+	struct arch *arch = zalloc(sizeof(*arch));
 
-	if (arch->initialized)
-		return 0;
+	if (!arch)
+		return NULL;
 
+	arch->name = "x86";
+	arch->id = *id;
 	if (cpuid) {
-		if (x86__cpuid_parse(arch, cpuid))
-			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+		if (x86__cpuid_parse(arch, cpuid)) {
+			errno = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
+			return NULL;
+		}
 	}
-
 	arch->instructions = x86__instructions;
 	arch->nr_instructions = ARRAY_SIZE(x86__instructions);
 #ifndef NDEBUG
@@ -810,11 +813,8 @@ int x86__annotate_init(struct arch *arch, char *cpuid)
 	arch->objdump.memory_ref_char = '(';
 	arch->objdump.imm_char = '$';
 	arch->insn_suffix = "bwlq";
-	arch->e_machine = EM_X86_64;
-	arch->e_flags = 0;
-	arch->initialized = true;
 #ifdef HAVE_LIBDW_SUPPORT
 	arch->update_insn_state = update_insn_state_x86;
 #endif
-	return err;
+	return arch;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 79702072568b..c16c6dfaa959 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -980,32 +980,27 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int evsel__get_arch(struct evsel *evsel, const struct arch **parch)
+int thread__get_arch(struct thread *thread, const struct arch **parch)
 {
-	struct perf_env *env = evsel__env(evsel);
-	const char *arch_name = perf_env__arch(env);
 	const struct arch *arch;
-	int err;
+	struct machine *machine;
+	uint16_t e_machine;
 
-	if (!arch_name) {
+	if (!thread) {
 		*parch = NULL;
-		return errno;
+		return -1;
 	}
 
-	*parch = arch = arch__find(arch_name);
+	machine = maps__machine(thread__maps(thread));
+	e_machine = thread__e_machine(thread, machine);
+	arch = arch__find(e_machine, machine->env ? machine->env->cpuid : NULL);
 	if (arch == NULL) {
-		pr_err("%s: unsupported arch %s\n", __func__, arch_name);
-		return ENOTSUP;
+		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
+		return errno;
 	}
+	if (parch)
+		*parch = arch;
 
-	if (arch->init) {
-		err = arch->init((struct arch *)arch, env ? env->cpuid : NULL);
-		if (err) {
-			pr_err("%s: failed to initialize %s arch priv area\n",
-			       __func__, arch->name);
-			return err;
-		}
-	}
 	return 0;
 }
 
@@ -1020,7 +1015,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 	const struct arch *arch = NULL;
 	int err, nr;
 
-	err = evsel__get_arch(evsel, &arch);
+	err = thread__get_arch(ms->thread, &arch);
 	if (err)
 		return err;
 
@@ -1268,7 +1263,7 @@ int hist_entry__annotate_printf(struct hist_entry *he, struct evsel *evsel)
 
 	apd.addr_fmt_width = annotated_source__addr_fmt_width(&notes->src->source,
 							      notes->src->start);
-	evsel__get_arch(evsel, &apd.arch);
+	thread__get_arch(ms->thread, &apd.arch);
 	apd.dbg = dso__debuginfo(dso);
 
 	list_for_each_entry(pos, &notes->src->source, node) {
@@ -1373,7 +1368,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 	struct annotation_line *al;
 
 	if (annotate_opts.code_with_type) {
-		evsel__get_arch(apd->evsel, &apd->arch);
+		thread__get_arch(apd->he->ms.thread, &apd->arch);
 		apd->dbg = dso__debuginfo(map__dso(apd->he->ms.map));
 	}
 
@@ -2495,7 +2490,7 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 	if (regname == NULL)
 		return -1;
 
-	op_loc->reg1 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
+	op_loc->reg1 = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
 	free(regname);
 
 	/* Get the second register */
@@ -2508,7 +2503,7 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
 		if (regname == NULL)
 			return -1;
 
-		op_loc->reg2 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
+		op_loc->reg2 = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
 		free(regname);
 	}
 	return 0;
@@ -2607,8 +2602,11 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
 			if (s == NULL)
 				return -1;
 
-			if (*s == arch->objdump.register_char)
-				op_loc->reg1 = get_dwarf_regnum(s, arch->e_machine, arch->e_flags);
+			if (*s == arch->objdump.register_char) {
+				op_loc->reg1 = get_dwarf_regnum(s,
+								arch->id.e_machine,
+								arch->id.e_flags);
+			}
 			else if (*s == arch->objdump.imm_char) {
 				op_loc->offset = strtol(s + 1, &p, 0);
 				if (p && p != s + 1)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 58eaf4b2fa65..696e36dbf013 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -586,5 +586,5 @@ int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
 			     int num_aggr, struct evsel *evsel);
 int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
 
-int evsel__get_arch(struct evsel *evsel, const struct arch **parch);
+int thread__get_arch(struct thread *thread, const struct arch **parch);
 #endif	/* __PERF_ANNOTATE_H */
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index c537c12ff7cd..e9f3155f3173 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -102,112 +102,101 @@ int arch__associate_ins_ops(struct arch *arch, const char *name, const struct in
 	return 0;
 }
 
-static struct arch architectures[] = {
-	{
-		.name = "arc",
-		.init = arc__annotate_init,
-		.e_machine = EM_ARC,
-	},
-	{
-		.name = "arm",
-		.init = arm__annotate_init,
-		.e_machine = EM_ARM,
-	},
-	{
-		.name = "arm64",
-		.init = arm64__annotate_init,
-		.e_machine = EM_AARCH64,
-	},
-	{
-		.name = "csky",
-		.init = csky__annotate_init,
-		.e_machine = EM_CSKY,
-#if defined(__CSKYABIV2__)
-		.e_flags = EF_CSKY_ABIV2,
-#else
-		.e_flags = EF_CSKY_ABIV1,
-#endif
-	},
-	{
-		.name = "mips",
-		.init = mips__annotate_init,
-		.e_machine = EM_MIPS,
-	},
-	{
-		.name = "x86",
-		.init = x86__annotate_init,
-		.e_machine = EM_X86_64, // TODO: EM_386 too.
-	},
-	{
-		.name = "powerpc",
-		.init = powerpc__annotate_init,
-		.e_machine = EM_PPC, // TODO: EM_PPC64 too.
-	},
-	{
-		.name = "riscv64",
-		.init = riscv64__annotate_init,
-		.e_machine = EM_RISCV,
-	},
-	{
-		.name = "s390",
-		.init = s390__annotate_init,
-		.e_machine = EM_S390,
-	},
-	{
-		.name = "sparc",
-		.init = sparc__annotate_init,
-		.e_machine = EM_SPARC,
-	},
-	{
-		.name = "loongarch",
-		.init = loongarch__annotate_init,
-		.e_machine = EM_LOONGARCH,
-	},
-};
+static int e_machine_and_eflags__cmp(const struct e_machine_and_e_flags *val1,
+				     const struct e_machine_and_e_flags *val2)
+{
+	if (val1->e_machine == val2->e_machine) {
+		if (val1->e_machine != EM_CSKY)
+			return 0;
+		if ((val1->e_flags & EF_CSKY_ABIMASK) < (val2->e_flags & EF_CSKY_ABIMASK))
+			return -1;
+		return (val1->e_flags & EF_CSKY_ABIMASK) > (val2->e_flags & EF_CSKY_ABIMASK);
+	}
+	return val1->e_machine < val2->e_machine ? -1 : 1;
+}
 
-static int arch__key_cmp(const void *name, const void *archp)
+static int arch__key_cmp(const void *key, const void *archp)
 {
-	const struct arch *arch = archp;
+	const struct arch *const *arch = archp;
 
-	return strcmp(name, arch->name);
+	return e_machine_and_eflags__cmp(key, &(*arch)->id);
 }
 
 static int arch__cmp(const void *a, const void *b)
 {
-	const struct arch *aa = a;
-	const struct arch *ab = b;
+	const struct arch *const *aa = a;
+	const struct arch *const *ab = b;
 
-	return strcmp(aa->name, ab->name);
+	return e_machine_and_eflags__cmp(&(*aa)->id, &(*ab)->id);
 }
 
-static void arch__sort(void)
+const struct arch *arch__find(uint16_t e_machine, const char *cpuid)
 {
-	const int nmemb = ARRAY_SIZE(architectures);
+	static const struct arch *(*const arch_new_fn[])(const struct e_machine_and_e_flags *id,
+							 const char *cpuid) = {
+		[EM_386]	= arch__new_x86,
+		[EM_ARC]	= arch__new_arc,
+		[EM_ARM]	= arch__new_arm,
+		[EM_AARCH64]	= arch__new_arm64,
+		[EM_CSKY]	= arch__new_csky,
+		[EM_LOONGARCH]	= arch__new_loongarch,
+		[EM_MIPS]	= arch__new_mips,
+		[EM_PPC64]	= arch__new_powerpc,
+		[EM_PPC]	= arch__new_powerpc,
+		[EM_RISCV]	= arch__new_riscv64,
+		[EM_S390]	= arch__new_s390,
+		[EM_SPARC]	= arch__new_sparc,
+		[EM_SPARCV9]	= arch__new_sparc,
+		[EM_X86_64]	= arch__new_x86,
+	};
+	static const struct arch **archs;
+	static size_t num_archs;
+	struct e_machine_and_e_flags key = {
+		.e_machine = e_machine,
+		// TODO: e_flags should really come from the same source as e_machine.
+		.e_flags = EF_HOST,
+	};
+	const struct arch *result = NULL, **tmp;
 
-	qsort(architectures, nmemb, sizeof(struct arch), arch__cmp);
-}
+	if (num_archs > 0) {
+		tmp = bsearch(&key, archs, num_archs, sizeof(*archs), arch__key_cmp);
+		if (tmp)
+			result = *tmp;
+	}
 
-const struct arch *arch__find(const char *name)
-{
-	const int nmemb = ARRAY_SIZE(architectures);
-	static bool sorted;
+	if (result)
+		return result;
 
-	if (!sorted) {
-		arch__sort();
-		sorted = true;
+	if (e_machine >= ARRAY_SIZE(arch_new_fn) || arch_new_fn[e_machine] == NULL) {
+		errno = ENOTSUP;
+		return NULL;
 	}
 
-	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
+	tmp = reallocarray(archs, num_archs + 1, sizeof(*archs));
+	if (!tmp)
+		return NULL;
+
+	result = arch_new_fn[e_machine](&key, cpuid);
+	if (!result) {
+		pr_err("%s: failed to initialize %s (%u) arch priv area\n",
+			__func__, result->name, e_machine);
+		free(tmp);
+		return NULL;
+	}
+	archs = tmp;
+	archs[num_archs++] = result;
+	qsort(archs, num_archs, sizeof(*archs), arch__cmp);
+	return result;
 }
 
 bool arch__is_x86(const struct arch *arch)
 {
-	return arch->e_machine == EM_386 || arch->e_machine == EM_X86_64;
+	return arch->id.e_machine == EM_386 || arch->id.e_machine == EM_X86_64;
 }
 
 bool arch__is_powerpc(const struct arch *arch)
 {
-	return arch->e_machine == EM_PPC || arch->e_machine == EM_PPC64;
+	return arch->id.e_machine == EM_PPC || arch->id.e_machine == EM_PPC64;
 }
 
 static void ins_ops__delete(struct ins_operands *ops)
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index b6a2a30fdf27..2793d48aa04e 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -17,21 +17,23 @@ struct data_loc_info;
 struct type_state;
 struct disasm_line;
 
+struct e_machine_and_e_flags {
+	uint16_t e_machine;
+	uint32_t e_flags;
+};
+
 struct arch {
-	const char	*name;
+	/** @id: ELF machine and flags associated with arch. */
+	struct e_machine_and_e_flags id;
+	/** @name: name such as "x86" or "powerpc". */
+	const char		*name;
 	const struct ins	*instructions;
-	size_t		nr_instructions;
-	size_t		nr_instructions_allocated;
-	const struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
-	bool		sorted_instructions;
-	bool		initialized;
-	const char	*insn_suffix;
-	void		*priv;
-	unsigned int	model;
-	unsigned int	family;
-	int		(*init)(struct arch *arch, char *cpuid);
-	bool		(*ins_is_fused)(const struct arch *arch, const char *ins1,
-					const char *ins2);
+	size_t			nr_instructions;
+	size_t			nr_instructions_allocated;
+	bool			sorted_instructions;
+	const char		*insn_suffix;
+	unsigned int		model;
+	unsigned int		family;
 	struct		{
 		char comment_char;
 		char skip_functions_char;
@@ -39,15 +41,14 @@ struct arch {
 		char memory_ref_char;
 		char imm_char;
 	} objdump;
+	bool		(*ins_is_fused)(const struct arch *arch, const char *ins1,
+					const char *ins2);
+	const struct ins_ops  *(*associate_instruction_ops)(struct arch *arch, const char *name);
 #ifdef HAVE_LIBDW_SUPPORT
 	void		(*update_insn_state)(struct type_state *state,
 				struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				struct disasm_line *dl);
 #endif
-	/** @e_machine: ELF machine associated with arch. */
-	unsigned int e_machine;
-	/** @e_flags: Optional ELF flags associated with arch. */
-	unsigned int e_flags;
 };
 
 struct ins {
@@ -107,7 +108,7 @@ struct annotate_args {
 	char			  *fileloc;
 };
 
-const struct arch *arch__find(const char *name);
+const struct arch *arch__find(uint16_t e_machine, const char *cpuid);
 bool arch__is_x86(const struct arch *arch);
 bool arch__is_powerpc(const struct arch *arch);
 
@@ -121,17 +122,17 @@ extern const struct ins_ops ret_ops;
 
 int arch__associate_ins_ops(struct arch *arch, const char *name, const struct ins_ops *ops);
 
-int arc__annotate_init(struct arch *arch, char *cpuid);
-int arm__annotate_init(struct arch *arch, char *cpuid);
-int arm64__annotate_init(struct arch *arch, char *cpuid);
-int csky__annotate_init(struct arch *arch, char *cpuid);
-int loongarch__annotate_init(struct arch *arch, char *cpuid);
-int mips__annotate_init(struct arch *arch, char *cpuid);
-int powerpc__annotate_init(struct arch *arch, char *cpuid);
-int riscv64__annotate_init(struct arch *arch, char *cpuid);
-int s390__annotate_init(struct arch *arch, char *cpuid);
-int sparc__annotate_init(struct arch *arch, char *cpuid);
-int x86__annotate_init(struct arch *arch, char *cpuid);
+const struct arch *arch__new_arc(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_arm(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_csky(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_loongarch(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_mips(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_powerpc(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_riscv64(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_s390(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_sparc(const struct e_machine_and_e_flags *id, const char *cpuid);
+const struct arch *arch__new_x86(const struct e_machine_and_e_flags *id, const char *cpuid);
 
 const struct ins_ops *ins__find(const struct arch *arch, const char *name, struct disasm_line *dl);
 
-- 
2.52.0.457.g6b5491de43-goog

