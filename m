Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F12390992
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157531; cv=none; b=eJAscvL1/9Mg+Qm1ADNalQiMGMB610+viYqs1pwLTEGGhfZh4XwvPXlFr8awCSFcNoCQH8V0CNEhq8jxJxnJpFb0YQlUvsknvBNvAwLeX2Fm/f1lo2tpyCsWS7gZ6XwejLiqJfDMm27rmm9FO1Fsdap0t8flchGaOuYaePEe8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157531; c=relaxed/simple;
	bh=S/MOHsrAK2wj/AmmX0K/d6tBXNsHAINGPYqbaAYXZKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IaUpoCbEOPYLYBrYaM0+rkFoDhrusMt7Z2EJkKHZz3dOXcPE6cxAddLJlu5VsjhyVuBEtNNRd4edgmD0cwqduMcXZyR1+DZ1IT74d/hrTeNXoNGjIenOZO1YvAIRTa0f5aGsILAwK9uJ5LOtq6ly+XbsoQSDSWXpYRFppXbrUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8XHvZnj; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8XHvZnj"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so33859203c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157528; x=1777762328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FUJSZggZAnW35gY6L6UfepyO4olhr8IMzDQNCfxT3yU=;
        b=J8XHvZnjhzImCB3Tet6XTyJeP1JtYnFDylG/CfxcqFhoWgGivfVlXKP5hBFseX4CIf
         OohRWvQJ6o8ylvOin27IpJbpwAYVdlj98GkqX/2zX84XxKm9f14SkPFOETP6qsexryb4
         yTo9JFN6nCbXWQNa8Mfanz5bFV++7LEW6EMtawrcvddNcMiISVfWp8FSCQf6C69wKx6s
         /TBLk3J4epfcgAywWgfh9KHxQiE2FIbxCt+EE9Gsjf7Mtpg6MV22d6UHPAmTFWToUWWN
         pijyyvjN0850phFrbJfvc2xIDo9Q+ri0SbIjykevYTnQ1cImUHu/+sD2qVwdwktBkwIw
         EYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157528; x=1777762328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUJSZggZAnW35gY6L6UfepyO4olhr8IMzDQNCfxT3yU=;
        b=CWiF44N3yfHlpP3iTIc9hmdWwPGYDfjtBoq9qZUdSb0RRegBbjzhI2xmo1wUl5+jrZ
         ycj58R4auQrAFHDmlI9zCTG5y3/aoTIzxL4PMGTrw4vhLZlob2B9AvQZY4Uy51X/LyZS
         NxAfPBQrKwfvfhVcr4IOrQEFbe35Pa1/b06cTWWVwre4RI9I+CszSOTlQLeWROvVynOn
         2rh07gMMeQ9Fx/qs7NIg5mRqx0/ngissfLvnJpV75sQF3gHf96ns4Zbk4hXwmHPjkfrF
         H98hhdcJ/aFnvoLFKZM3W/z5yWxT8aczEIYGCrrle+Dm/nWi8zodV9IEn3oRv7aw0rQW
         3C5g==
X-Forwarded-Encrypted: i=1; AFNElJ9+/PbsGWABdYFiHExd24hvY3hGShCWDwd1lFPXsTiSZw1/sqHkGrnd6VOnvaVtrj4ONT1NEJveN8MYJV6lDK2O@vger.kernel.org
X-Gm-Message-State: AOJu0YwhX2H6HP11ckFVyl/0/E2R8RFqvW1ME2AucB8UTTO2Z7HV/kW3
	py3BoouytZHnudb8dgS+QIoCP1cGk0nK4VNUZdZX4kW8vio54g/iRhW58Uu/aJrqtp06kk/bxaO
	bRqVRbqraMg==
X-Received: from dlbvg6.prod.google.com ([2002:a05:7022:7f06:b0:12d:b396:eadf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4199:b0:122:2f4:b24b
 with SMTP id a92af1059eb24-12c73f9bfebmr18766156c88.25.1777157528294; Sat, 25
 Apr 2026 15:52:08 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:47 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-56-irogers@google.com>
Subject: [PATCH v7 55/59] perf Makefile: Update Python script installation path
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
index ecddd91229c8..e2cef452964f 100644
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
2.54.0.545.g6539524ca2-goog

