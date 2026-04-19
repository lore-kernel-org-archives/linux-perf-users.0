Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10511A9F8D
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643290; cv=none; b=cmFzLmemHoGzqQps1QnsEdFeDyAwvv/s131OVdQc72N7Fq8nwr/Oy8Fa428a4h384JBh5cVo22UMqzl/4q9cKS61bHRjYmIzFxRMCgITkz74pn9ES/7hEaAhUGR45J1XOJWzTJ0e9sRGL9O9eXWZkPjm99RlzwbinrXHvCHtwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643290; c=relaxed/simple;
	bh=viZxndnwt1T6ICuDJI4B232reWs/tTsZAWw54o5v8Jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ybociu8D2QQ/j3TBFf9DnxeoUXKegQwwu6JBcpHjKw/Rkk0MztGsSPwhiosphtkAHBQgYeAY0xvBeFUj55fKgoBQAwezlUm7t8BNuGuK0JktT6V4l15mFEjsEYIg9X4wWXKc1rNrdI8xzoOUY/nmccusDCRy02Z10rDHvsfpUSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WB7wLKOE; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WB7wLKOE"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so3410959eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643288; x=1777248088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWRHY3Ijdr6vnfIPietQsj/TXm3FNux1n2jopawrohg=;
        b=WB7wLKOE/ZXNIAg+cavOQjPCfLDjH6oWL7Nh2avomzGJI+d+wv3zq3ncT4VCSzIeGe
         +Jdhi5SJ/qY83kLJ4zRXE3i9EL2OR6wjLu5klpcwfU8S1o2TPk2dKeZT4MW58pLpNQJc
         UJwhY/BA0IkDh3U8C7dn12v0ONvIyMMrF5qeOM6hroqtYYr4JcWIQaTwLpmavwqlsPPX
         mfHov0c5o8yUoSFID5oMn2tj/U02BIK3wLH9nKCTmvI5BIu+wEnjDPixthz4Dh9UzwfM
         31uqfKOzQMjR2Hn2IkXka7XCmw3MzgKR8PsqUyuAKdyDq53Bh9cFmMDxelRYVNKmX3/5
         7IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643288; x=1777248088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KWRHY3Ijdr6vnfIPietQsj/TXm3FNux1n2jopawrohg=;
        b=qCTKTgy2ZWn6JDCGdakzjBCiaSSieWsycOZ0P07tiUZjlXJZ9DOVyAyhCRgEuIMXoi
         hMEENchhBiyMiFSU4ABXJo9ypZHy4VsihRymAjc5s+ProdHt3eENU1n2WMg8pwuJsLqL
         KzawNRsxKEpLdhi5JXoqNyamcMg2KHD5DYqw3jlf0xMzerQ9Zgv26UJQa+eHlM4ofuzZ
         Y8TH+n+ljjAQUK9o6vStvlZoaHtkW0Tf7/hHmDkhJLh1HoWP32z13YHrFqqKRA4Ki8Vk
         NzaxPZePfDeQGqtmkjgdJG+GKOfHfgAK42Dv5z9sb0u025smL69zE2QP44CD4e/y3mCO
         PXpA==
X-Forwarded-Encrypted: i=1; AFNElJ87ii95zC2AdNS1X3oLz6PBmmfzZ+gc/s2RGx68pp7GbqGQgiVZsEb125OiLrLuqocJ79bLAhemo093pFY6IUYD@vger.kernel.org
X-Gm-Message-State: AOJu0YykytYjZAxRM2Lh8FTfoAURJljLkwSIKuRDeb2PfvHRW24PJ1tW
	7UfqmwjHjb9JXPc+FWTkmC/xw9dcUVR5o2j4TSNNQbC001x7IiIIi668l7VZJBJecgBMpr6ju+S
	6asXtKMFgwg==
X-Received: from dybmd11.prod.google.com ([2002:a05:7301:180b:b0:2d8:d251:f7ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80c5:b0:2df:7882:1ce0
 with SMTP id 5a478bee46e88-2e479618a50mr6288995eec.29.1776643287521; Sun, 19
 Apr 2026 17:01:27 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:59:07 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-56-irogers@google.com>
Subject: [PATCH v1 55/58] perf Makefile: Update Python script installation path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove libpython feature test that is now a python-module feature
test. Update references from libpython to python-module accordingly.

Remove references to legacy 'scripts/python' directory and install
scripts directly to 'python' directory under libexec. This aligns with
the removal of embedded interpreter and move to standalone
scripts.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature             |  4 ++--
 tools/build/feature/Makefile             |  4 ++--
 tools/build/feature/test-all.c           |  6 +++---
 tools/build/feature/test-libpython.c     | 10 ----------
 tools/build/feature/test-python-module.c | 12 ++++++++++++
 tools/perf/Makefile.config               | 13 ++++++-------
 tools/perf/Makefile.perf                 | 10 ++++------
 tools/perf/tests/make                    |  5 +----
 8 files changed, 30 insertions(+), 34 deletions(-)
 delete mode 100644 tools/build/feature/test-libpython.c
 create mode 100644 tools/build/feature/test-python-module.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 96d4382144c4..cbe41ba7bae5 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -79,7 +79,7 @@ FEATURE_TESTS_BASIC :=                  \
         libelf-zstd                     \
         libnuma                         \
         numa_num_possible_cpus          \
-        libpython                       \
+        python-module                   \
         libslang                        \
         libtraceevent                   \
         libcpupower                     \
@@ -140,7 +140,7 @@ FEATURE_DISPLAY ?=              \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
-         libpython              \
+         python-module          \
          libcapstone            \
          llvm-perf              \
          zlib                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 60e3df8142a5..5530f9e03fcf 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -30,7 +30,7 @@ FILES=                                          \
          test-libdebuginfod.bin                 \
          test-libnuma.bin                       \
          test-numa_num_possible_cpus.bin        \
-         test-libpython.bin                     \
+         test-python-module.bin                 \
          test-libslang.bin                      \
          test-libtraceevent.bin                 \
          test-libcpupower.bin                   \
@@ -252,7 +252,7 @@ $(OUTPUT)test-gtk2-infobar.bin:
 grep-libs  = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
 
-$(OUTPUT)test-libpython.bin:
+$(OUTPUT)test-python-module.bin:
 	$(BUILD) $(FLAGS_PYTHON_EMBED)
 
 $(OUTPUT)test-libbfd.bin:
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 1488bf6e6078..4400e3d24f81 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -10,8 +10,8 @@
  * Quirk: Python headers cannot be in arbitrary places, so keep this testcase at
  * the top:
  */
-#define main main_test_libpython
-# include "test-libpython.c"
+#define main main_test_python_module
+# include "test-python-module.c"
 #undef main
 
 #define main main_test_hello
@@ -148,7 +148,7 @@
 
 int main(int argc, char *argv[])
 {
-	main_test_libpython();
+	main_test_python_module();
 	main_test_hello();
 	main_test_libelf();
 	main_test_gettid();
diff --git a/tools/build/feature/test-libpython.c b/tools/build/feature/test-libpython.c
deleted file mode 100644
index 371c9113e49d..000000000000
--- a/tools/build/feature/test-libpython.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <Python.h>
-
-int main(void)
-{
-	Py_Initialize();
-
-	return 0;
-}
-#undef _GNU_SOURCE
diff --git a/tools/build/feature/test-python-module.c b/tools/build/feature/test-python-module.c
new file mode 100644
index 000000000000..d670dba014b0
--- /dev/null
+++ b/tools/build/feature/test-python-module.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <Python.h>
+
+int main(void)
+{
+	static struct PyModuleDef moduledef = {
+		PyModuleDef_HEAD_INIT,
+	};
+	PyObject *module = PyModule_Create(&moduledef);
+
+	return module ? 0 : -1;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 50dc199a825f..c7c38f755fd5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -317,7 +317,7 @@ PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
 
 # Python 3.8 changed the output of `python-config --ldflags` to not include the
 # '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
-# libpython fails if that flag is not included in LDFLAGS
+# python-module fails if that flag is not included in LDFLAGS
 ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
   PYTHON_CONFIG_LDFLAGS := --ldflags --embed
 else
@@ -340,8 +340,8 @@ ifdef PYTHON_CONFIG
   endif
 endif
 
-FEATURE_CHECK_CFLAGS-libpython := $(PYTHON_EMBED_CCOPTS)
-FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
+FEATURE_CHECK_CFLAGS-python-module := $(PYTHON_EMBED_CCOPTS)
+FEATURE_CHECK_LDFLAGS-python-module := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
@@ -830,13 +830,12 @@ endif
 
 disable-python = $(eval $(disable-python_code))
 define disable-python_code
-  CFLAGS += -DNO_LIBPYTHON
   $(warning $1)
-  NO_LIBPYTHON := 1
+  NO_PYTHON_MODULE := 1
 endef
 
 PYTHON_EXTENSION_SUFFIX := '.so'
-ifdef NO_LIBPYTHON
+ifdef NO_PYTHON_MODULE
   $(call disable-python,Python support disabled by user)
 else
 
@@ -849,7 +848,7 @@ else
       $(call disable-python,No 'python-config' tool was found: disables Python support - please install python-devel/python-dev)
     else
 
-      ifneq ($(feature-libpython), 1)
+      ifneq ($(feature-python-module), 1)
         $(call disable-python,No 'Python.h' was found: disables Python support - please install python-devel/python-dev)
       else
          PYTHON_SETUPTOOLS_INSTALLED := $(shell $(PYTHON) -c 'import setuptools;' 2> /dev/null && echo "yes" || echo "no")
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2020532bab9c..e50b1e8cf85d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -17,9 +17,7 @@ include ../scripts/utilities.mak
 #
 # Define CROSS_COMPILE as prefix name of compiler if you want cross-builds.
 #
-
-#
-# Define NO_LIBPYTHON to disable python script extension.
+# Define NO_PYTHON_MODULE to disable python script extension.
 #
 # Define PYTHON to point to the python binary if the default
 # `python' is not correct; for example: PYTHON=python2
@@ -1099,10 +1097,10 @@ endif
 	$(call QUIET_INSTALL, perf-iostat) \
 		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 
-ifndef NO_LIBPYTHON
+ifndef NO_PYTHON_MODULE
 	$(call QUIET_INSTALL, python-scripts) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
-		$(INSTALL) python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python'; \
+		$(INSTALL) python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python'
 endif
 	$(call QUIET_INSTALL, dlfilters) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters'; \
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 31b064928cfc..f2c5f1c254a7 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -75,8 +75,6 @@ make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
 
-make_no_libpython   := NO_LIBPYTHON=1
-make_no_scripts     := NO_LIBPYTHON=1
 make_no_slang       := NO_SLANG=1
 make_no_gtk2        := NO_GTK2=1
 make_no_ui          := NO_SLANG=1 NO_GTK2=1
@@ -118,7 +116,7 @@ make_install_prefix_slash := install prefix=/tmp/krava/
 make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1
 
 # all the NO_* variable combined
-make_minimal        := NO_LIBPYTHON=1 NO_GTK2=1
+make_minimal        := NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
 make_minimal        += NO_LIBBPF=1
@@ -150,7 +148,6 @@ run += make_jevents_all
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 
-run += make_no_libpython
 run += make_no_scripts
 run += make_no_slang
 run += make_no_gtk2
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

