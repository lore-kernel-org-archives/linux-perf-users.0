Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA60215F5C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553379; cv=none; b=IHsZHEgakZ7DLHvxKPwkyqY40qHXql11IGnwDd0b32n+f74us02ygtxZR24bom3YxSq2NY1EkCgOI/yPc4oCqzYMcdckyLqrk6+Y+AbmE+XNTQifHigyhmMFQ9d40ZsFzPOsq0cYPXzxTvKrI8uNC8HYSCiX80xttrdyJFyf6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553379; c=relaxed/simple;
	bh=m6I7ir56+s1v/FdObosdGxd9jycpVwV7dKBlyKs2db8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhkNqgQSvEWZz7eyJs3YMR4UN2IgxyQPJ2HGUmS6ZCnm0rRg5x4Kq4xRP1L+ZCnbWhYRHmBJ33hHPMdy+iTbq940+oKyAcuYS82PG2pk0iKaq6HOC3LYc5Y89yfhCAoBDhvqmJARfsKK4ovYKRhjoNMOCXiH7aN9z5/zZFAftgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIF+Fu0W; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIF+Fu0W"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65940221f7eso5992953a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770553377; x=1771158177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcNts/TUqejw4wKNwMzCnJmzZ08XO2pLIb1P3AzPhRY=;
        b=PIF+Fu0WqyEX3Jgx2zF4Mm7yoFEdO/fiaTaYdkJ7WOqavqURZxTpJmiKOY/qb3iM4S
         iHhL8Q4Z2wyBUj02LbJ0Ow9JXAgbmUzGw8utoPtBXwIPDPNjwlcgm6xpbj9QBHbuKyA6
         IspZ3lAsVmSHwnQ5e1etNWsCZfMxt/AU9f2khesVNVzXyHxFeT8rK9ogEzn20971KMxU
         8gj4GA2bgLZBVsn8iUlUqjeOVqxlrKUHq1ggal5Ea94yO8+Zvxu9DZFOKJFlPuV/hJRx
         Dn6QnBe3SqkJ33UAVhQSGHoTiNNLE02roN3Kb02/2QxbGSFXzp+uhGgE/IZekUjeAVxk
         kKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770553377; x=1771158177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gcNts/TUqejw4wKNwMzCnJmzZ08XO2pLIb1P3AzPhRY=;
        b=TgJpY2ZpXJueWDkyfgDa/ukvueW7ey2hBJqneXtXBDMZKfysvGGHgXQw3wz7A5X0Ep
         Vod2EAhDAfdkt22o2nmFO/LQFK8Db13izbQzXeJzxQiVQpeKxPJzHXxik53dLvgVA79I
         cPix57RNgpLXQ+CXzpUK193DP7BT1BWwkCuhZXhKyQv9+CsrkEHGBwRlY5jGSUNvdqBf
         O+1Z7j6hwaevrqum7mjokZV7YubAQoiWuWhaeIWsgMW0zQLI8llkbm10vSfJU97XyyEQ
         rKVrKUxyyx1ju7K4+k6EuaLl4Pm3E8VFKk7rTGfA6fcUiSH2v5kfKvVla06tX6A/z5fE
         KBvg==
X-Gm-Message-State: AOJu0Yz24F/aWcgtODbVG4BvHqqbV+pSxbh/xunLFeaTjzIwW2mGpXwR
	LMvu+7C/FimqWrSPZL1b0A37RrbWVZ+O98GEZl3cOWGuOCFI4k3cs4h7im72yg==
X-Gm-Gg: AZuq6aK2rDmS4vRRpiQijbv0ROkQTtca/42VDMbAfscoiTTe3TDKv2i98Gj6TPnlCTU
	K/BQIJzZcq/YUrvonAxfdynswQDYJT0XB359dhhm+WJR59ng20XlTXK2BQDgyNVQlgkWBDkNlQi
	fvX3svo9S9re2pBR4Zcl2hANPS/GcC0IqL6ofy1IyPnWX7LQcLEcR4qzekdGJwnyxZ8nseJZyPq
	p5HiRxiI2OBZ19ZFk4nOjcp2Ds/P6J6mW3SGtwPls2pkytRMeskttfjHvl/2NTJj/eKYJMtc1Ew
	uUpP3RXxzomxxZyQMMjtvOhAKt5/COkt9wOTWJHEEEeatc6ICg+qr6OdKaExBR7uLlI6Shlq4+x
	pcfpf6JyFLWkgNFGcEHPb25PBt8HDN9NYhXgIL7LPwoTEjxOKMYGgZKZKO9kQKP3klC1a43DPlj
	KWysJL2Vp3D6l7CJVj3armRzCZudMTmOifN8K/5zSt8HUgWaPxa/l/6LOD3gunMxtTkxkK5GW/y
	iz9pvwPX5iyGvaKFQJhJXu3cFfAxg==
X-Received: by 2002:a05:6402:2790:b0:64b:5885:87d6 with SMTP id 4fb4d7f45d1cf-65984182c9bmr3921298a12.24.1770553377066;
        Sun, 08 Feb 2026 04:22:57 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65984024e11sm2011658a12.32.2026.02.08.04.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 04:22:55 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v2 2/4] perf test workload: Add code_with_type test workload
Date: Sun,  8 Feb 2026 13:22:24 +0100
Message-ID: <20260208122227.3524-3-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260208122227.3524-1-9erthalion6@gmail.com>
References: <20260208122227.3524-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of the workload is to gather samples of rust runtime. To
achiever that it has a dummy rust library linked with it. Per
recommendations for such scenarios [1], the rust library is statically
linked.

An example:

$ perf record perf test -w code_with_type
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.160 MB perf.data (4074 samples) ]

$ perf report --stdio --dso perf -s srcfile,srcline
    45.16%  ub_checks.rs       ub_checks.rs:72
     6.72%  code_with_type.rs  code_with_type.rs:15
     6.64%  range.rs           range.rs:767
     4.26%  code_with_type.rs  code_with_type.rs:21
     4.23%  range.rs           range.rs:0
     3.99%  code_with_type.rs  code_with_type.rs:16
    [...]

[1]: https://doc.rust-lang.org/reference/linkage.html#mixed-rust-and-foreign-codebases

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/build/Makefile.build                   | 14 ++++++
 tools/perf/Makefile.perf                     |  2 +-
 tools/perf/tests/builtin-test.c              |  4 ++
 tools/perf/tests/tests.h                     |  4 ++
 tools/perf/tests/workloads/Build             |  5 +++
 tools/perf/tests/workloads/code_with_type.c  | 46 ++++++++++++++++++++
 tools/perf/tests/workloads/code_with_type.rs | 23 ++++++++++
 tools/scripts/Makefile.include               |  2 +
 8 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/workloads/code_with_type.c
 create mode 100644 tools/perf/tests/workloads/code_with_type.rs

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 3584ff30860..60e65870eae 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -76,6 +76,14 @@ quiet_cmd_host_ld_multi = HOSTLD  $@
       cmd_host_ld_multi = $(if $(strip $(obj-y)),\
                           $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
 
+rust_common_cmd = \
+	$(RUSTC) $(rust_flags) \
+	--crate-type staticlib -L $(objtree)/rust/ \
+	--emit=dep-info=$(depfile),link
+
+quiet_cmd_rustc_a_rs = $(RUSTC) $(quiet_modtag) $@
+      cmd_rustc_a_rs = $(rust_common_cmd) -o $@ -g $< $(cmd_objtool)
+
 ifneq ($(filter $(obj),$(hostprogs)),)
   host = host_
 endif
@@ -105,6 +113,12 @@ $(OUTPUT)%.s: %.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_s_c)
 
+# it's recommended to build a static rust library, when a foreight (to rust)
+# linker is used.
+$(OUTPUT)%.a: %.rs FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,rustc_a_rs)
+
 # bison and flex files are generated in the OUTPUT directory
 # so it needs a separate rule to depend on them properly
 $(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2a7e5814b15..a6d8ca3e923 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -271,7 +271,7 @@ ifeq ($(PYLINT),1)
   PYLINT := $(shell which pylint 2> /dev/null)
 endif
 
-export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
+export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e2490652f03..06507066213 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -154,6 +154,10 @@ static struct test_workload *workloads[] = {
 	&workload__landlock,
 	&workload__traploop,
 	&workload__inlineloop,
+
+#ifdef HAVE_RUST_SUPPORT
+	&workload__code_with_type,
+#endif
 };
 
 #define workloads__for_each(workload) \
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1f0f8b267fb..f5f1238d1f7 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -242,6 +242,10 @@ DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
 DECLARE_WORKLOAD(inlineloop);
 
+#ifdef HAVE_RUST_SUPPORT
+DECLARE_WORKLOAD(code_with_type);
+#endif
+
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
 
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 866a00bd14a..2ef97f7affc 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -10,6 +10,11 @@ perf-test-y += landlock.o
 perf-test-y += traploop.o
 perf-test-y += inlineloop.o
 
+ifeq ($(CONFIG_RUST_SUPPORT),y)
+    perf-test-y += code_with_type.o
+    perf-test-y += code_with_type.a
+endif
+
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
 CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/code_with_type.c b/tools/perf/tests/workloads/code_with_type.c
new file mode 100644
index 00000000000..65d7be7dac2
--- /dev/null
+++ b/tools/perf/tests/workloads/code_with_type.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <pthread.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+extern void test_rs(uint count);
+
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int code_with_type(int argc, const char **argv)
+{
+	int sec = 1, num_loops = 100;
+
+	pthread_setname_np(pthread_self(), "perf-code-with-type");
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	if (argc > 1)
+		num_loops = atoi(argv[1]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	/*
+	 * Rust doesn't have signal management in the standard library. To
+	 * not deal with any external crates, offload signal handling to the
+	 * outside code.
+	 */
+	while (!done) {
+		test_rs(num_loops);
+		continue;
+	}
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(code_with_type);
diff --git a/tools/perf/tests/workloads/code_with_type.rs b/tools/perf/tests/workloads/code_with_type.rs
new file mode 100644
index 00000000000..3b91e51919d
--- /dev/null
+++ b/tools/perf/tests/workloads/code_with_type.rs
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// We're going to look for this structure in the data type profiling report
+#[allow(dead_code)]
+struct Buf {
+    data1: u64,
+    data2: String,
+    data3: u64,
+}
+
+#[no_mangle]
+pub extern "C" fn test_rs(count: u32) {
+    let mut b =  Buf { data1: 0, data2: String::from("data"), data3: 0};
+
+    for _ in 1..count {
+        b.data1 += 1;
+        if b.data1 == 123 {
+            b.data1 += 1;
+        }
+
+        b.data3 += b.data1;
+    }
+}
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index ded48263dd5..b5ecf137feb 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -94,6 +94,8 @@ LLVM_STRIP	?= llvm-strip
 # Some tools require bpftool
 SYSTEM_BPFTOOL	?= bpftool
 
+RUSTC		?= rustc
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 
-- 
2.52.0

