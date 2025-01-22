Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72621B8E0
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567830; cv=none; b=roIl+vzZyo8r1HurqiNu5jYhNUo9qRksm+FwM0KjJEw615JRUKbsD6zxLhGpYAMf7O3UXMwT1FBPSZcE/8f5w2PFh54vRojHZCKFyHWptlzRl5+IB9eJwI093PoX5h0cB3t8zV+EIrqTpGWudgWbWU7ohmofY2nBgfHi1J+bngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567830; c=relaxed/simple;
	bh=HiDr79fP47XwAxdIV+5DIotVwJFwOZkI27dPvSasCd8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WaeIbqLdbyUdCvI7wWJaHoPHlrGds/Im5afni+QeXQMvncT2CQX50S+NvQQFy/GcP1KBdit1TbfBVmKjeIhF4eosT9k6UzfzxYqt6HJJl9oBFMhhznyr2z7Roq4ZGitGhv9yJ+hqf2kwl4j5Y4D4TPaHaHs4I+u6xIsf1Gquy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GGAgTIBF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGAgTIBF"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e579836ee17so13849513276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567828; x=1738172628; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnFfwugrGP+xutDceieXM+J2RpmU+m6WOl3TVXWgxXg=;
        b=GGAgTIBFgojZCn3h9E/DvvYwmmh/iwxoiDZcUC7oESOD3qJvjfaGvnSobqq9uRaJv0
         WQPHK0OjIP23D/Tx00ToMHIX/mhtqPdjhkpBVrtQNP8t6OGPkN91uaxiwykRWWZ0Nerf
         ZclMwqw4HKUw4ozWOJfy320iGjOGo3JpX/BK8DbR8hwmn3oB6hOwq/vXFSyqHE9UdTu/
         WR9hviT5cXY5e8tq2wSRdcTZx+xV6xKy2NyW09XiLywzcOGwZ5Z+FYpy9xb3nUZYELbe
         tRPPJzY9HMqjMdVdo0Z6TxPMUaQDdVoZ3b5fKp22wTnzlmq1XPAla/TVFWjheNQGgJAb
         72kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567828; x=1738172628;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnFfwugrGP+xutDceieXM+J2RpmU+m6WOl3TVXWgxXg=;
        b=TVhTPnvPOhnuUvUaRDG4srNn3k40AQOm7sj6xQ5al2NLi1/DyKScc42B+bue93gWH5
         BlV/jwMMA9H04rgBp1U95gW/a7/T6hY0mVXmTPnHsXuBKxv8wGJ514zmbAe9s0Ei6ZK+
         U2QumjISDB8BkI89Laht2ruy+9ZFXdoLGs0kUPMwFpS5PK47eP/voemtNq0mBEu0Lkfg
         NeeWb7T1mzNmtPrtD5y6mZioMMbaCn1jCZ9R1KZSRlD5XYBTS3BTKf1uGm1M+y2MPpeS
         7Z3Q3hRrhESSlCxLnQYZSmzivtav1aTzx6KN3jTd5z9ANLhx7Qd6+AHEpRIfDPPqHVFy
         MrMw==
X-Forwarded-Encrypted: i=1; AJvYcCVEqDGFODH//I8ivnP/UB0fraX6YMJhTpQf176saJ5usezFtdeKndu2R+tfSp8zMrip3Jo0FVU/yWpIjxXZj6Ej@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDs9T41+o9i/Q9y7IiHVlDJNgaTbek1z/QM6FPORspE2rYv5C
	SU1BFN02QIXwxvUqg/4EVnyE19IGQVzh90ZNEo+efF+NdOo/f3EYfAN2EXjp6hucw1zcqPW1sAs
	okMQm0g==
X-Google-Smtp-Source: AGHT+IGDW+VNC2I24v7j/el8+7OGxfjMW+p+QeEe5IN2AYkiRD2ZzpAOO1qo8IKIdt8znQOJcYUv6/sID15c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a0d:c387:0:b0:6e7:e493:2db6 with SMTP id
 00721157ae682-6f73417e510mr135397b3.3.1737567828128; Wed, 22 Jan 2025
 09:43:48 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:06 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 16/18] perf disasm: Remove disasm_bpf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

BPF disassembly was handled in here by libbfd. The LLVM and capstone
disassemblers now support BPF JIT disassembly. As libbfd support was
removed the functions here no longer did anything remove them and
associated error values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build        |  1 -
 tools/perf/util/annotate.h   |  1 -
 tools/perf/util/disasm.c     | 12 +++---------
 tools/perf/util/disasm_bpf.c | 29 -----------------------------
 tools/perf/util/disasm_bpf.h | 12 ------------
 5 files changed, 3 insertions(+), 52 deletions(-)
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index eb00c599e179..4b757d157f13 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -14,7 +14,6 @@ perf-util-y += copyfile.o
 perf-util-y += ctype.o
 perf-util-y += db-export.o
 perf-util-y += disasm.o
-perf-util-y += disasm_bpf.o
 perf-util-y += env.o
 perf-util-y += event.o
 perf-util-y += evlist.o
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0ba5846dad4d..e704a9c913f7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -438,7 +438,6 @@ enum symbol_disassemble_errno {
 	__SYMBOL_ANNOTATE_ERRNO__START		= -10000,
 
 	SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX	= __SYMBOL_ANNOTATE_ERRNO__START,
-	SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF,
 	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING,
 	SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP,
 	SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE,
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 99b9c21e02b0..ebd86691acf8 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -17,7 +17,6 @@
 #include "capstone.h"
 #include "debug.h"
 #include "disasm.h"
-#include "disasm_bpf.h"
 #include "dso.h"
 #include "dwarf-regs.h"
 #include "env.h"
@@ -1230,9 +1229,6 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 			  "  --vmlinux vmlinux\n", build_id_msg ?: "");
 	}
 		break;
-	case SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF:
-		scnprintf(buf, buflen, "Please link with binutils's libopcode to enable BPF annotation");
-		break;
 	case SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_REGEXP:
 		scnprintf(buf, buflen, "Problems with arch specific instruction name regular expressions.");
 		break;
@@ -1500,11 +1496,9 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return symbol__disassemble_bpf(sym, args);
-
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
-		return symbol__disassemble_bpf_image(sym, args);
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO ||
+	    dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return -1;
 
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
deleted file mode 100644
index a891a0b909a7..000000000000
--- a/tools/perf/util/disasm_bpf.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include "util/annotate.h"
-#include "util/disasm_bpf.h"
-#include "util/symbol.h"
-#include <linux/zalloc.h>
-#include <string.h>
-
-int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct annotate_args *args __maybe_unused)
-{
-	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
-}
-
-int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct disasm_line *dl;
-
-	args->offset = -1;
-	args->line = strdup("to be implemented");
-	args->line_nr = 0;
-	args->fileloc = NULL;
-	dl = disasm_line__new(args);
-	if (dl)
-		annotation_line__add(&dl->al, &notes->src->source);
-
-	zfree(&args->line);
-	return 0;
-}
diff --git a/tools/perf/util/disasm_bpf.h b/tools/perf/util/disasm_bpf.h
deleted file mode 100644
index 2ecb19545388..000000000000
--- a/tools/perf/util/disasm_bpf.h
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#ifndef __PERF_DISASM_BPF_H
-#define __PERF_DISASM_BPF_H
-
-struct symbol;
-struct annotate_args;
-
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
-int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args);
-
-#endif /* __PERF_DISASM_BPF_H */
-- 
2.48.1.262.g85cc9f2d1e-goog

