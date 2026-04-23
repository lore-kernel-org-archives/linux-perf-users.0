Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4853D348E
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916661; cv=none; b=IERKofZcUIjFpo93NU2XlYsVbkgerg6kgS1K4yZ9QCOSWRNbeF5yRivbwYH1hUHXnIf0uXhN26DAF6zQqicuUkXzYtRPorKdOMQyYxFgWwAl6CAs6d9Gj73vwKBc/fLjb2xNGYaS0JIdYcC0enNUHaCbJkBAIFqdGuiK1FijjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916661; c=relaxed/simple;
	bh=2eEYSKRLgb13mj0aPAHjjmYnpxBe64bPYI1FFVx00Oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ir7LZiGPU3BZL4opIM2Pivv2Y88uzsteBqWxyvyEgEs0cPC1KgKgH7MnzNa+Ic1klMdiQIYibZUzTJtF4FKWrkbNFDiEWsdBedP+MqBwpFToqeHNHrB2fDReTduyx6ON7sk4taHXgM0W53OFhfj43BxtBYUtaM6mt7jErpxsw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0v9XPIt; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0v9XPIt"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso6582726eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916659; x=1777521459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuF+Z+ovCdTWBRS8xM9l5IRkTc5PBKJHCoqG1SvHQlk=;
        b=M0v9XPItW6L86K/L9xgNbaDVPMHR3jKipSytN2fDMyr9mgHgq+t99ooHPGGzW9DQl/
         e0BIbkdMkzp1nzxZ8tuxGdN7FHPQGbGiSkDh5A6/mhA6ft/lUP+yqXkSiqLHFdJqfrve
         NjVevjDNRw7wnVpsXidemlKyKGIZr1TpGTFdNhVZJfTOZdQUbDfeTo6CIsomymrZOj1Q
         3ATQVphlXrtmH81aLAvNkgce/yfh8B6v+S/5CMt9JbyrRgy3rwn96T2Tv/OqT2uZf0M4
         7McTvjHeFLVmgyUTUy+iRqqAKXUd2RCVB+N3wpzwuPtb/g4T78pgP3l3OPGgEJ+AV/Kq
         4B/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916659; x=1777521459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuF+Z+ovCdTWBRS8xM9l5IRkTc5PBKJHCoqG1SvHQlk=;
        b=RaZHI2Ylg9GY85COI20D7q+2ac5zvdsU0kHDXQ2N7r7XEe1aqGnbcTOS9iDJjBsrlq
         G1T+6NEx+WRhs8II238d1ieUwdfz3CninWQ1W8wj+Ar7x3RwbLe20vDt/n6YNf/5Te2G
         qfGRFdx6PITntrlNX2Dqhip9iTkMb0LpRTwSTFDB/ZIPLHbokhOsw5Pv0hebothOXHrb
         ykmdiE50SIvpKoy2r5JLzLXACfb73A7djf75c8/+gdHbo/ts3GpIznYFt0bJrtnli/Il
         DC1Fm5YiqGcCwuJNp+KDPF5zlomLVk2H51ajPueB8qhU9UJX/r+f5V1GMsf0ocKPqGKt
         MI2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+kur2NfyU9XaNgNPFzxMO3RfPtvzWzEph/ocQxZ/pDNd/D+XU84R3tWasNcR8aYEDJZI8uClRDuUBmiZsRD5lb@vger.kernel.org
X-Gm-Message-State: AOJu0YzENrkPB/2LdES2EfpjS6ajkx12LfPe03N3Uf2gD0/4O7eaW75L
	HGWrZZjDTygMyaXpYkA/NjRt/M1J5jJxdsDy3mr6wNHfwXN+MGx4EfW5Xit09dKG98+yo84kkrn
	Lm7HKckkcQQ==
X-Received: from dybdm8.prod.google.com ([2002:a05:7300:bb08:b0:2d8:5557:aec])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8628:b0:2e2:d94d:6175
 with SMTP id 5a478bee46e88-2e46557c96dmr14774731eec.12.1776916658258; Wed, 22
 Apr 2026 20:57:38 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:22 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-56-irogers@google.com>
Subject: [PATCH v2 55/58] perf Makefile: Update Python script installation path
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

