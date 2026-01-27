Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888382571C7
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502655; cv=none; b=hqofzUiFEab/htqg4Pwdw6z3HMFnTjszSPwzD55ANxXIF+KCcBP6in9bGCubLpFlJYN8bt4QIyyelquIPflH1zJtgNtJJIfksaFgwvrQSAye0sVzQR+2zD0NWfbqTerbw4xUqYtMSgkwBvuQFl71OIuHuvm+YFjEjfoHSO7ArY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502655; c=relaxed/simple;
	bh=D+vR9N0dtsj/0Cenalt30rJe1GTjZyYl0p4h5dhDa24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAZgKl/0y3m/MHY2tmoejGSyCuiTKCaBkCyD36NKa2gf5UKbodvQYaqH3u8iIqfqQKjIUfHUfTVc8yONLvgoR4GFVCIVYNrnpQLQNMWZWktTerOIy3YWuRGZCzMUTgzZ0mQN6Xs7rLb2rrhq9DSCeTlNcO0KianER9OgAU1MiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnS9ER/F; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnS9ER/F"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so7980578a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 00:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769502652; x=1770107452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GG5KsU9/hS8gAYn3yliTxu5aa3KfHBXQ0bhOPe4mdHU=;
        b=gnS9ER/F02rrw/Yz7GBS3rX2jhR8KKTKubvl2YIIK6dR8JcOJIVqElYxZorBxZsr4f
         p9/Fhi2q4VFRkZ8h5OwH0208kbuJh875yK1F45alRumhQx312fkZUs04VgZrG8GIPLxe
         QQvAtEAXd0Rkzd6hfYc+xSJMXR/RWvZf4niI4XY0Fcl0+7ZVQLlOnKUZCD8GPDthn2py
         Rqvgeh6SyImQdtY1UyNCKx25yol1O+GWJ4P5810wKCo6lHNEtovUmK/tOjHrqPCDW9kw
         1UPSKWuLVtTYyZl8BHnTPye1KXzea875gPmYZKRAH3azeDVcfsGyJqv7A7OsvDJ6hSjN
         zlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769502652; x=1770107452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG5KsU9/hS8gAYn3yliTxu5aa3KfHBXQ0bhOPe4mdHU=;
        b=SMdg95cWtbCqxZ9rr/6/+rcIsJT1uAeqJo9bwYOsey3YgBE+n9fJGHchXxKzLRtkAB
         SlLNHnkeNadqtVCQC3e5aMv23vo6EWALc/QDv0kWZai5+kZMuaZCzCgViGj6Ixve3KyS
         7v+8nsahg6vvUgsR599GdIEteFtrbs78lP0cyvvEF+EeCcVIHLy02PYBviw4QMKoJN+Q
         ftbnlMi6oOz1tyWnbOHgxbnqkw399WhDrCs60JSjMzjrCitJEXpQIqs2cZddSJfhNkw3
         YCB1qy7leEkG3VE1fSgI7u8dw7xPRi5ffOYuU4+sEGGmd/XP+7qoBUhtVC4+eiN/jyo3
         TfzA==
X-Gm-Message-State: AOJu0YwUka5H2OnJfyn4Jq60QFek91lNFXZ86khdRr0n9hEnzYPhjJLs
	GfI8iOWaWFV1eiYNY7rq+G2NHKVPKXIZdOr9JjTl00MlkCpGaRBmxUiYifi7aQ==
X-Gm-Gg: AZuq6aLFGz+tqJDQ0jDsEVFSHaN6i+2VjT98EqNp1H4anCclgqcSidQmSKz/tSIJsSJ
	iGXYNhk6mpFwspIlVRO7UMdDLqOHxpSx94FpUP36sgLkD+NJSmQDQ4hGgwYRlfC3yTypp42kjRp
	CaaDA0V1RWn0OEK8ns6hz2lnnlSZkZttv8fIR8RLx7c2yMX3A/k09MSJENp0TvV1hoDgQ44ZJNO
	mdgEHQiyc691vrQcJ8Fz5f0NHhMAIPY02cMnMaHk72v0WtmF3m39hVqn8LJx/X7S8hlivjcMlFJ
	DHO52DE/Oqgw4RsUAqD05Ng3YYjD3gH7MfDVQ+LdD3wjC6JKyqQ9ElU2z9VqY96vbaFpAzK6hIW
	OjU0Qs2Fx53X8tiKQoER/xO+iE6meFIdE7GahVjY5YfJq41z9Peiti2Zc/9Cx9zp2vwVDiWBi0O
	S/fbxzTjwlun0v3rlnoq3kYdaFytVgrNNEVE4NSK2V2tnftLRePJXDADVuPZ+nEJz/gmM2WwKQC
	QUs6cpyeaJNMTchPmmyAF/91x9+Nw==
X-Received: by 2002:a17:906:6a28:b0:b8a:fb6a:b6c9 with SMTP id a640c23a62f3a-b8dab40b5c9mr79171566b.58.1769502651441;
        Tue, 27 Jan 2026 00:30:51 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-088-078-017-026.088.078.pools.vodafone-ip.de. [88.78.17.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75d648sm767949666b.47.2026.01.27.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 00:30:50 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v1] perf tests: Test annotate with data type profiling and rust
Date: Tue, 27 Jan 2026 09:30:27 +0100
Message-ID: <20260127083030.5909-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the annotate command with data type profiling feature on the
rust runtime:

* Add a new type of workload code_with_type, which has a dummy rust
  library linked with it. It's recommended that for such scenarios rust
  library is statically linked [1].

* Add a new shell test, which will profile the new workload, then
  annotate the result expecting to see some data structures from the
  rust code.

[1]: https://doc.rust-lang.org/reference/linkage.html#mixed-rust-and-foreign-codebases

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 tools/build/Makefile.build                    | 14 ++++
 tools/perf/Makefile.perf                      |  2 +-
 tools/perf/tests/builtin-test.c               |  1 +
 tools/perf/tests/shell/data_type_profiling.sh | 69 +++++++++++++++++++
 tools/perf/tests/tests.h                      |  1 +
 tools/perf/tests/workloads/Build              |  2 +
 tools/perf/tests/workloads/code_with_type.c   | 46 +++++++++++++
 tools/perf/tests/workloads/code_with_type.rs  | 23 +++++++
 tools/scripts/Makefile.include                |  2 +
 9 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/tests/shell/data_type_profiling.sh
 create mode 100644 tools/perf/tests/workloads/code_with_type.c
 create mode 100644 tools/perf/tests/workloads/code_with_type.rs

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 3584ff30860..672ddbe2f4d 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -76,6 +76,14 @@ quiet_cmd_host_ld_multi = HOSTLD  $@
       cmd_host_ld_multi = $(if $(strip $(obj-y)),\
                           $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
 
+rust_common_cmd = \
+	$(RUSTC) $(rust_flags) \
+	--crate-type staticlib -L $(objtree)/rust/ \
+	--out-dir $(dir $@) --emit=dep-info=$(depfile),link
+
+quiet_cmd_rustc_a_rs = $(RUSTC) $(quiet_modtag) $@
+      cmd_rustc_a_rs = $(rust_common_cmd) -g $< $(cmd_objtool)
+
 ifneq ($(filter $(obj),$(hostprogs)),)
   host = host_
 endif
@@ -105,6 +113,12 @@ $(OUTPUT)%.s: %.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_s_c)
 
+# it's recommended to build a static rust library, when a foreight (to rust)
+# linker is used.
+$(OUTPUT)lib%.a: %.rs FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,rustc_a_rs)
+
 # bison and flex files are generated in the OUTPUT directory
 # so it needs a separate rule to depend on them properly
 $(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 45d5a59a02c..87762694315 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -273,7 +273,7 @@ ifeq ($(PYLINT),1)
   PYLINT := $(shell which pylint 2> /dev/null)
 endif
 
-export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
+export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
 export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
 
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e2490652f03..183ccfe55a8 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -154,6 +154,7 @@ static struct test_workload *workloads[] = {
 	&workload__landlock,
 	&workload__traploop,
 	&workload__inlineloop,
+	&workload__code_with_type,
 };
 
 #define workloads__for_each(workload) \
diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
new file mode 100755
index 00000000000..33fc1ae6b26
--- /dev/null
+++ b/tools/perf/tests/shell/data_type_profiling.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# perf data type profiling tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+# The logic below follows the same line as the annotate test, but looks for a
+# data type profiling manifestation
+testtype="# data-type: struct Buf"
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+perfout=$(mktemp /tmp/__perf_test.perf.out.XXXXX)
+testprog="perf test -w code_with_type"
+
+cleanup() {
+  rm -rf "${perfdata}" "${perfout}"
+  rm -rf "${perfdata}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_basic_annotate() {
+  mode=$1
+  echo "${mode} perf annotate test"
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf record -o "${perfdata}" ${testprog} 2> /dev/null
+  else
+    perf record -o - ${testprog} 2> /dev/null > "${perfdata}"
+  fi
+  if [ "x$?" != "x0" ]
+  then
+    echo "${mode} annotate [Failed: perf record]"
+    err=1
+    return
+  fi
+
+  # Generate the annotated output file
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf annotate --code-with-type -i "${perfdata}" --stdio --percent-limit 10 2> /dev/null > "${perfout}"
+  else
+    perf annotate --code-with-type -i - --stdio 2> /dev/null --percent-limit 10 < "${perfdata}" > "${perfout}"
+  fi
+
+  # check if it has the target data type
+  if ! grep -q "${testtype}" "${perfout}"
+  then
+    echo "${mode} annotate [Failed: missing target data type]"
+    cat "${perfout}"
+    err=1
+    return
+  fi
+  echo "${mode} annotate test [Success]"
+}
+
+test_basic_annotate Basic
+test_basic_annotate Pipe
+
+cleanup
+exit $err
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 1f0f8b267fb..cfa3a4562e9 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -241,6 +241,7 @@ DECLARE_WORKLOAD(datasym);
 DECLARE_WORKLOAD(landlock);
 DECLARE_WORKLOAD(traploop);
 DECLARE_WORKLOAD(inlineloop);
+DECLARE_WORKLOAD(code_with_type);
 
 extern const char *dso_to_test;
 extern const char *test_objdump_path;
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index 866a00bd14a..cc9a938948e 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -9,6 +9,8 @@ perf-test-y += datasym.o
 perf-test-y += landlock.o
 perf-test-y += traploop.o
 perf-test-y += inlineloop.o
+perf-test-y += code_with_type.o
+perf-test-y += libcode_with_type.a
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
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
 

base-commit: 571d29baa07e83e637075239f379f91353c24ec9
-- 
2.49.0

