Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025B13D8A3
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339025; cv=none; b=cTka7zDYwBfsMy4GnQB8phQ2XygkadByv0sWiABJojqNTPRZQZiyH0RCIDA4vT8J3mJVMWLJeTvKgLxFoglpPjUMcOugLPMLgiFTNENN6rMPFisKS/3hXwq7cSVTaZXEP1UAbrzkF8hsPnpNiyjs4pdki1eEBhv8Wubvep1Ocq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339025; c=relaxed/simple;
	bh=82bijJeRZvQKffUYSp6pgeymdNvCFHYsEPeLvVMlPr4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DwwV7UlwAIs/0UxxjeA+tNGtq4KCQsiNVnrar/MSl9iQyBpoYlfPGBLxTjWh6CF59wHLXku0q0qlGN1z5zQlscnJvqZX8Khgi/4fCbssveNMHFFBVptpHR9AdrWXOnKi4xQa8UaLBDFoW/P+tqMlsFTYm8MM4ayHIZtMzmTZAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eonBIH3z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eonBIH3z"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so6020757b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 18:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339022; x=1730943822; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZD7VBq2UGR6iF+9N7VjgPo1K8yaYKmQwzvOlxr3CE1U=;
        b=eonBIH3zCzg8KRJaTDSDHr9rkgvGAszuxrCer46Fm8KbzCsDqLRL0fxvy+NjO2Nf3k
         H1/+tVhvsIvtv6yj5LnQD2QUxZ/xR1ouPh6eoFhTPx2Ca3fKmoQLQ8UmvyKr56Qkea1d
         iG7Y9IUZW21KA/sItudj4lQSY3zVL6NoDcp//zLVl25JtfQPnYWrVn/sWX3uZqnawSWS
         /c+118dg10aKeEJCilSQgievuD9vcbQ4kWkJ3LLstqJP1JH16rS26z8FUt7aLBlgmj49
         zdrPuwjlfyenBd2HejP7YXPMNiknziQIzqYZCZZcmRa+u7jqmptGXs8FEfAMzhDKfG1P
         +7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339022; x=1730943822;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD7VBq2UGR6iF+9N7VjgPo1K8yaYKmQwzvOlxr3CE1U=;
        b=Uq/RK9lqjGkXipwoePIO92FezbNUQijMbOb7rHlmM9MLWsBdXRKjkhiIKuyqMcad2G
         ZtkmEZuYFcekcP4oXdZ2ChWcbtclhGc2/8KVdcOHP2dVvPJUof8T1c07TkxOTLjygl2C
         56basAdNU247gXl9TLEmVsmxSr5LNxDlgIueII2ShjIOPfwy2G3QcmOiVTGmsrwl37jG
         T+lJgVSjaxSFMk1Lt4YQY/ha27qclFUgpQls1zbRizMj9jj3b2bYkhmf1YqTfFMbNoxM
         1UqnmPiGuJiAbnFbg7Nk9SGTuQ3ud00hoq1VMd8XDh4BC1iHHd1Qan+3F607DH5ripH6
         Ch5A==
X-Forwarded-Encrypted: i=1; AJvYcCUSiDID+SSwvNykcjIFIVGqLhJCTmZe6nQeTP75NuhSDxe7lI9eUlgQdKxcFLM+TA2eg2gYv2OxOBCEBpHDL0VX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7THSw3KQ8L1dNsvRRdgPkjMu+ybMYrf9XkptlnDDv1KXnSYwH
	5U4s0oxJHbpBWqfgxXCMWXBgCZbyTzwe548ZD0F/IGQp/flTTQy3q05e076+Jo1pVKe7Ybx32k3
	IbC6OIA==
X-Google-Smtp-Source: AGHT+IGD2zl5CoM1dn1fd62QFAfNFk6dQhVlQX2zqIA8JQBYZtzbSCfBNBohWHmQXmShCDO3HgNQb3NdUTNe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a0d:d1c3:0:b0:6d9:d865:46c7 with SMTP id
 00721157ae682-6ea5576f128mr31617b3.2.1730339022068; Wed, 30 Oct 2024 18:43:42
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:42 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 11/21] perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

archinsn.c containing arch_fetch_insn was only enabled with
CONFIG_AUXTRACE, but this meant that a NO_AUXTRACE build on x86 would
use the empty weak version of arch_fetch_insn - weak symbols are a
frequent source of errors like this and are outside of the C
specification. Change it so that archinsn.c is always built on x86 and
make the weak symbol empty version of arch_fetch_insn a strong one
guarded by ifdefs.

arch_fetch_insn on x86 depends on insn_decode which is a function
included then built into
intel-pt-insn-decoder.c. intel-pt-insn-decoder.c isn't built in a
NO_AUXTRACE=1 build. Separate the insn_decode function from
intel-pt-insn-decoder.c by just directly compiling the relevant
file. Guard this compilation to be for either always on x86 (because
of the use in arch_fetch_insn) or when auxtrace is enabled. Apply the
CFLAGS overrides as necessary, reducing the amount of code where
warnings are disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/Build                 |  2 +-
 tools/perf/util/Build                          |  2 +-
 tools/perf/util/intel-pt-decoder/Build         | 18 ++++++++++++++----
 .../intel-pt-decoder/intel-pt-insn-decoder.c   |  3 ---
 tools/perf/util/trace-event-scripting.c        |  4 +++-
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index bc56a8e70f34..c5df4a2cf180 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -18,6 +18,6 @@ perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-util-$(CONFIG_AUXTRACE) += archinsn.o
+perf-util-y += archinsn.o
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 650974413849..340544a6f5ec 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -122,7 +122,7 @@ perf-util-y += iostat.o
 perf-util-y += stream.o
 perf-util-y += kvm-stat.o
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
+perf-util-y += intel-pt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-util-$(CONFIG_AUXTRACE) += arm-spe.o
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index 30793d08c6d4..f99d150059b9 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -9,14 +9,24 @@ $(OUTPUT)util/intel-pt-decoder/inat-tables.c: $(inat_tables_script) $(inat_table
 
 # Busybox's diff doesn't have -I, avoid warning in the case
 
-$(OUTPUT)util/intel-pt-decoder/intel-pt-insn-decoder.o: util/intel-pt-decoder/intel-pt-insn-decoder.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
+ifeq ($(SRCARCH),x86)
+  perf-util-y += inat.o insn.o
+else
+  perf-util-$(CONFIG_AUXTRACE) += inat.o insn.o
+endif
+
+$(OUTPUT)util/intel-pt-decoder/inat.o: $(srctree)/tools/arch/x86/lib/inat.c $(OUTPUT)util/intel-pt-decoder/inat-tables.c
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-CFLAGS_intel-pt-insn-decoder.o += -I$(OUTPUT)util/intel-pt-decoder
+CFLAGS_inat.o += -I$(OUTPUT)util/intel-pt-decoder
+
+$(OUTPUT)util/intel-pt-decoder/insn.o: $(srctree)/tools/arch/x86/lib/insn.c
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
 
 ifeq ($(CC_NO_CLANG), 1)
-  CFLAGS_intel-pt-insn-decoder.o += -Wno-override-init
+  CFLAGS_insn.o += -Wno-override-init
 endif
 
-CFLAGS_intel-pt-insn-decoder.o += -Wno-packed
+CFLAGS_insn.o += -Wno-packed
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 47cf35799a4d..8fabddc1c0da 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -11,9 +11,6 @@
 #include <byteswap.h>
 #include "../../../arch/x86/include/asm/insn.h"
 
-#include "../../../arch/x86/lib/inat.c"
-#include "../../../arch/x86/lib/insn.c"
-
 #include "event.h"
 
 #include "intel-pt-insn-decoder.h"
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 2e9da0b089ef..8d71998a9ecd 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -272,11 +272,13 @@ void setup_perl_scripting(void)
 #endif
 #endif
 
-__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+#if !defined(__i386__) && !defined(__x86_64__)
+void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
 		     struct thread *thread __maybe_unused,
 		     struct machine *machine __maybe_unused)
 {
 }
+#endif
 
 void script_fetch_insn(struct perf_sample *sample, struct thread *thread,
 		       struct machine *machine, bool native_arch)
-- 
2.47.0.163.g1226f6d8fa-goog

