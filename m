Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCA32ED5D
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764882784; cv=none; b=P+IsYVDu3FYp0mlfMFoKwgBnUOM9SBT8hywHbG9+ZSdRkBcTuCnIauyMth2Fn2ybsptdvH/cjMdlmKI9sNPE5IwI0YkzWtPOnbvkx3WndPRtIklLM6g/6H6jNi4jQSe/ekFYu9AUF+/nR0chz+KrmcKehZVUakBCHR0CIarlRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764882784; c=relaxed/simple;
	bh=7j9U46Ae1Z5AypIdGMd9yPUyiTuV7Qjy+fczd7THRao=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=YHw7b/hQgLKlHFlZ0527OyFdS607hBFkzUmCWtaRqPonP5xdCIaOC1Sjvhx7IvA0e2w0ubs6BpJxW7nvXKZmu1aMHy3MggCAszp/qaJeRGG8R9fA78JLOCSnbaPspCaNx73B7pGEu4tf87Tn/CatOm/8kgTOYYnmquVPojG8j0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=watuRLei; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="watuRLei"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99763210e5so2616934a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764882781; x=1765487581; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qzak/OCzRh0xSld4WaA+fQD3w+DW1Y486K8IXJyVqlM=;
        b=watuRLeik3gVkZqLJAvV7+3tZN+7aVb2V/+2VCZZdHSgw5esi1Clm+5qHlzzFaUjpm
         +4iRAW5+JJ0ZLtgcsngOVn9g8D7lEMn6VusG4RCN84HEvmSj3dhDAGVZf6+ovgXx6qfb
         1F+PjqXAHUFDHTzkdAJUBOAjeXxpGiMG77W6mCkDjdbMQGlPVvPi+WmFn3vMt1j6wPQZ
         2TYMd90thvfwjmIkKUHUgZX6Sbikr3U16UVBtYSMGqI6WrouInm3GnX/H8rmrTibF/GF
         CLqLqBuoApmTaZqjO8KPvBEwPo/k5SseJQIBnG1OdEVOZrIT/sY7ymAny0Do9DfxW4Ts
         Putg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764882781; x=1765487581;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qzak/OCzRh0xSld4WaA+fQD3w+DW1Y486K8IXJyVqlM=;
        b=v17ytvG30OlEQeVTrN1QkLz9DOTUadiZtulZqaMLURrvCIhhG2hG9qvLHC2bnJjXA/
         tbVQUEipvW9IVSy+8Zac0wOsiR+ywWgXmTl58z9QWK8PlmdnNCq8VRinmfEogGAjeqSH
         sgVAobjz9p+tY+66djks3U3VUc2aZfyml0z9Y86RHKrasQC8XDb/vbvfHg80AbWK8veI
         FAobEC/7/kO5DsRX2YOct8IsClfa6HHVmsY8QLUSv51mO+xjeC8Ba1nVXsYk8A0z3pHJ
         9z3IR4Fk/YoTKE4qHkLT7r08mljeP5PMB7Gi4v5+wmZVGjLdZhez+uw4RhFfDNmclZ8v
         wMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjg0EbrgSGaxYBXbhkUwH3YY2wqWZcuX2q/CwZxp2/IZ4qOWHdkE6Spc13AzF3XMm2d7iVpKvCarfQQT3VyMxt@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSy1mTuDaVt3LvUodId7CTOgKG1e/wKICoQZfxHHzk+KGVy1I
	uUngwBwEm2tI0dObk4/J2CYP2NmQr0g5mb1DsddI4YtD4JL5qyTWHZq7OqKIAU4wqhmqwRIfZ9t
	xNXPoYuniXQ==
X-Google-Smtp-Source: AGHT+IF4qlRqyF9crDFtm7CD2Cy9PTsB1TSVNBLHr4Qq6WhGnSJksjq6eS9zHTh4lXVdE4f38OL9D34T5Ssa
X-Received: from dyw18.prod.google.com ([2002:a05:7300:8812:b0:2a4:6f7f:e6f0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cc9c:b0:2a4:3593:6472
 with SMTP id 5a478bee46e88-2ab92ec938dmr4070217eec.34.1764882781288; Thu, 04
 Dec 2025 13:13:01 -0800 (PST)
Date: Thu,  4 Dec 2025 13:11:43 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251204211143.572382-1-irogers@google.com>
Subject: [PATCH v1] perf help: Move common_cmds into builtin-help
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There's a lot of infrastructure for generating a relatively simple
array used by one function. Move the array into the function and
remove the supporting build logic. At the same time opportunistically
const-ify the array.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf            | 11 ++---
 tools/perf/builtin-help.c           | 51 ++++++++++++++++++---
 tools/perf/command-list.txt         | 36 ---------------
 tools/perf/util/Build               | 14 ------
 tools/perf/util/generate-cmdlist.sh | 70 -----------------------------
 5 files changed, 49 insertions(+), 133 deletions(-)
 delete mode 100644 tools/perf/command-list.txt
 delete mode 100755 tools/perf/util/generate-cmdlist.sh

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 80decc7ce13c..a91c5d01f3b4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -807,11 +807,6 @@ $(GTK_IN): FORCE prepare
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
 	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
 
-$(OUTPUT)common-cmds.h: util/generate-cmdlist.sh command-list.txt
-
-$(OUTPUT)common-cmds.h: $(wildcard Documentation/perf-*.txt)
-	$(QUIET_GEN). util/generate-cmdlist.sh > $@+ && mv $@+ $@
-
 $(SCRIPTS) : % : %.sh
 	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
 
@@ -849,7 +844,7 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(or $(__build-dir),.)
 
-prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
+prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
 	arm64-sysreg-defs \
 	$(syscall_array) \
 	$(fs_at_flags_array) \
@@ -1053,7 +1048,7 @@ cscope:
 # However, the environment gets quite big, and some programs have problems
 # with that.
 
-check: $(OUTPUT)common-cmds.h
+check: prepare
 	if sparse; \
 	then \
 		for i in *.c */*.c; \
@@ -1296,7 +1291,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 \
 		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo \
-		$(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
+		TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
 		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 7be6fb6df595..2692b2e40a23 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -9,7 +9,6 @@
 #include "util/strbuf.h"
 #include "builtin.h"
 #include <subcmd/exec-cmd.h>
-#include "common-cmds.h"
 #include <subcmd/parse-options.h>
 #include <subcmd/run-command.h>
 #include <subcmd/help.h>
@@ -301,16 +300,58 @@ static struct cmdnames main_cmds, other_cmds;
 
 void list_common_cmds_help(void)
 {
-	unsigned int i, longest = 0;
+	const struct cmdname_help {
+		const char *name;
+		const char *help;
+	} common_cmds[] = {
+		{"annotate", "Read perf.data (created by perf record) and display annotated code"},
+		{"archive",
+		 "Create archive with object files with build-ids found in perf.data file"},
+		{"bench", "General framework for benchmark suites"},
+		{"buildid-cache", "Manage build-id cache."},
+		{"buildid-list", "List the buildids in a perf.data file"},
+		{"c2c", "Shared Data C2C/HITM Analyzer."},
+		{"config", "Get and set variables in a configuration file."},
+		{"daemon", "Run record sessions on background"},
+		{"data", "Data file related processing"},
+		{"diff", "Read perf.data files and display the differential profile"},
+		{"evlist", "List the event names in a perf.data file"},
+		{"ftrace", "simple wrapper for kernel's ftrace functionality"},
+		{"inject", "Filter to augment the events stream with additional information"},
+		{"iostat", "Show I/O performance metrics"},
+		{"kallsyms", "Searches running kernel for symbols"},
+		{"kvm", "Tool to trace/measure kvm guest os"},
+		{"list", "List all symbolic event types"},
+		{"mem", "Profile memory accesses"},
+		{"record", "Run a command and record its profile into perf.data"},
+		{"report", "Read perf.data (created by perf record) and display the profile"},
+		{"script", "Read perf.data (created by perf record) and display trace output"},
+		{"stat", "Run a command and gather performance counter statistics"},
+		{"test", "Runs sanity tests."},
+		{"top", "System profiling tool."},
+		{"version", "display the version of perf binary"},
+	#ifdef HAVE_LIBELF_SUPPORT
+		{"probe", "Define new dynamic tracepoints"},
+	#endif /* HAVE_LIBELF_SUPPORT */
+	#ifdef HAVE_LIBTRACEEVENT
+		{"trace", "strace inspired tool"},
+		{"kmem", "Tool to trace/measure kernel memory properties"},
+		{"kwork", "Tool to trace/measure kernel work properties (latencies)"},
+		{"lock", "Analyze lock events"},
+		{"sched", "Tool to trace/measure scheduler properties (latencies)"},
+		{"timechart", "Tool to visualize total system behavior during a workload"},
+	#endif /* HAVE_LIBTRACEEVENT */
+	};
+	size_t longest = 0;
 
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(common_cmds); i++) {
 		if (longest < strlen(common_cmds[i].name))
 			longest = strlen(common_cmds[i].name);
 	}
 
 	puts(" The most commonly used perf commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %-*s   ", longest, common_cmds[i].name);
+	for (size_t i = 0; i < ARRAY_SIZE(common_cmds); i++) {
+		printf("   %-*s   ", (int)longest, common_cmds[i].name);
 		puts(common_cmds[i].help);
 	}
 }
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
deleted file mode 100644
index e8d2762adade..000000000000
--- a/tools/perf/command-list.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-#
-# List of known perf commands.
-# command name			category [deprecated] [common]
-#
-perf-annotate			mainporcelain common
-perf-archive			mainporcelain common
-perf-bench			mainporcelain common
-perf-buildid-cache		mainporcelain common
-perf-buildid-list		mainporcelain common
-perf-data			mainporcelain common
-perf-diff			mainporcelain common
-perf-c2c			mainporcelain common
-perf-config			mainporcelain common
-perf-evlist			mainporcelain common
-perf-ftrace			mainporcelain common
-perf-inject			mainporcelain common
-perf-iostat			mainporcelain common
-perf-kallsyms			mainporcelain common
-perf-kmem			mainporcelain traceevent
-perf-kvm			mainporcelain common
-perf-kwork			mainporcelain traceevent
-perf-list			mainporcelain common
-perf-lock			mainporcelain traceevent
-perf-mem			mainporcelain common
-perf-probe			mainporcelain full
-perf-record			mainporcelain common
-perf-report			mainporcelain common
-perf-sched			mainporcelain traceevent
-perf-script			mainporcelain common
-perf-stat			mainporcelain common
-perf-test			mainporcelain common
-perf-timechart			mainporcelain traceevent
-perf-top			mainporcelain common
-perf-trace			mainporcelain audit
-perf-version			mainporcelain common
-perf-daemon			mainporcelain common
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1c2a43e1dc68..eb77d85a9683 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -418,20 +418,6 @@ $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
-ifdef SHELLCHECK
-  SHELL_TESTS := generate-cmdlist.sh
-  SHELL_TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
-else
-  SHELL_TESTS :=
-  SHELL_TEST_LOGS :=
-endif
-
-$(OUTPUT)%.shellcheck_log: %
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
-
-perf-util-y += $(SHELL_TEST_LOGS)
-
 PY_TESTS := setup.py
 ifdef MYPY
   MYPY_TEST_LOGS := $(PY_TESTS:%=%.mypy_log)
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
deleted file mode 100755
index 6a73c903d690..000000000000
--- a/tools/perf/util/generate-cmdlist.sh
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-echo "/* Automatically generated by $0 */
-struct cmdname_help
-{
-    char name[16];
-    char help[80];
-};
-
-static struct cmdname_help common_cmds[] = {"
-
-sed -n -e 's/^perf-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/perf-'"$cmd"'/H
-     ${
-            x
-            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
-	    p
-     }' "Documentation/perf-$cmd.txt"
-done
-
-echo "#ifdef HAVE_LIBELF_SUPPORT"
-sed -n -e 's/^perf-\([^ 	]*\)[ 	].* full.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/perf-'"$cmd"'/H
-     ${
-            x
-            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
-	    p
-     }' "Documentation/perf-$cmd.txt"
-done
-echo "#endif /* HAVE_LIBELF_SUPPORT */"
-
-echo "#if defined(HAVE_LIBTRACEEVENT)"
-sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/perf-'"$cmd"'/H
-     ${
-            x
-            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
-	    p
-     }' "Documentation/perf-$cmd.txt"
-done
-echo "#endif /* HAVE_LIBTRACEEVENT */"
-
-echo "#ifdef HAVE_LIBTRACEEVENT"
-sed -n -e 's/^perf-\([^ 	]*\)[ 	].* traceevent.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/perf-'"$cmd"'/H
-     ${
-            x
-            s/.*perf-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
-            p
-     }' "Documentation/perf-$cmd.txt"
-done
-echo "#endif /* HAVE_LIBTRACEEVENT */"
-echo "};"
-- 
2.52.0.223.gf5cc29aaa4-goog

