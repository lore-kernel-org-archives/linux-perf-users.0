Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2D569F20
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187351; cv=none; b=sMrfygomenHIkZ/HqKdYwv4kivqYcaIhFmCigHhfA6UQoV6a9vGHCgZaZgXCjW3SPfeXgVkLbLRAjmhQgayJkV8UGY3NG4hRrbgO0U0nl6OwQoVkokLffrz3E9rebwRb1ZgbIRrGzUvi5qJHcDuwF4LveDOWOlI8P8qtoNHJ8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187351; c=relaxed/simple;
	bh=R5tve246ZDl6Iv6X0zWWuhAM7NySb22t97iDN5KeIBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QwRo2Cx5nVZwtDTGMZrFEoGTnU7F0bO3c3gV7GWJrNcJpis/OGQAyAkFm5hn6sIGLqUHW/wJgpl7eJKOHvuBKQSiFG25CcPKYKVIGZxNJIaIfB0nBAlLmLB4tCaPI+yLnWWcTuBi3m07cH9MtK8JFoB1/DLRW/XL/zlI17HVW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfZzBXsP; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfZzBXsP"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-32861f5448cso1252622eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187339; x=1790792139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gTx5ytJ429Jy8MS4ecM0pFZf3dlxtK0mnR/bovR6mE0=;
        b=jfZzBXsP5yvciXeJl0y4TS6fe6iBuRIHJCjkojaZaAbLBxspe2HZFEzazK8M9wM4QY
         rfb5X7g75VFHAlP5fkJQbKEKzqZk5yGoBnDOhJK76VXZqNqGqKUZ9I5qooHUqTGkcf7r
         bhr6213KjEIZi6u8xcNGdpUgZ9eG/CcCZLtlwj4Hpi8XWi30UWZNf1WeBNFmvWGPzX59
         zazNtcR7x/JC0um8omarR5B3u7URhWPD7lTLye2QKjUcl3QmuB47ebY6sIKuxSdNBMOk
         wSubZKYQltxewiM2QOdJcAHuvmgAejaD2BNE2vki/9Cp52anL5ild5fqQpS78JcXSMW/
         jZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187339; x=1790792139;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTx5ytJ429Jy8MS4ecM0pFZf3dlxtK0mnR/bovR6mE0=;
        b=otdHJgZARK6Ekbz2sJmCnKaiXdaW8f4giHBPXLG558/OAtQ9/COLvJ0vZWmm09OZKB
         TTkxno4MOlmm72xvtBAacBqgLf85PlRtgJtj7pzrPQwE+dABfUJ0Yr/foOOEtCrrZ2iO
         F5Nn+5pyDq3oqCPhdi0cNfTW6PJ8vhd1Zn/2gLzd40vyh4hvBmSt/SDkuczC0i1u+jdQ
         2iKsfJfmBMK3J2ArUtKCu61dhc6LXjY//JIWrsDfOWrj0vm77EsnLpFCy+n3vs3wMuZV
         7khs6AEkRa1w18JnrPE13HSvkILAtbSk7UkCvsFLfhpJNa8UTjdnHG8DvC6lc2IEnBUE
         GHRw==
X-Forwarded-Encrypted: i=1; AKwUvBzUI6vsKERvOEz9ACkL8vPto9WWUmtTM217cxSJn8plWaOTAdRH/cNyCaemDtOpi8p3sLOoEHgT8Y3S0utVk9N0@vger.kernel.org
X-Gm-Message-State: AFuF++nnKnd5fgNgQ5r0Zg0lItzdzqpx1iKrXHDV/qd2gI4idabPs8/a
	N4Y2iUGd5WN+kIqdgzVC84MtIOfMKoXid742Uj13MtCgTEq9ygds7mjorLuL0KUNQ9rfTsgp0DT
	aCPeA28ylxQ==
X-Received: from dyid9.prod.google.com ([2002:a05:7300:7949:b0:338:5ce7:96f7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:83ce:10b0:33c:12b6:2bfb
 with SMTP id 5a478bee46e88-33ee3716f93mr2746334eec.24.1790187337200; Wed, 23
 Sep 2026 11:15:37 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:12:10 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-48-irogers@google.com>
Subject: [PATCH v3 47/49] perf Makefile: Update Python script installation path
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Replace the libpython feature test with a python-module feature test
checking for Python C extension build capability, and update feature
test references accordingly.

Remove references to the legacy scripts/python directory and install
standalone Python scripts (python/*.py), type stubs (python/perf.pyi),
and the compiled perf extension module (python/perf*.so, when built)
directly under the python directory in libexec. Update the TUI script
browser (ui/browsers/scripts.c) to discover standalone scripts from the
updated installation path.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature             |   4 +-
 tools/build/feature/Makefile             |   4 +-
 tools/build/feature/test-all.c           |   6 +-
 tools/build/feature/test-libpython.c     |  10 --
 tools/build/feature/test-python-module.c |  13 ++
 tools/perf/Documentation/perf-check.txt  |   1 +
 tools/perf/Makefile.config               |  15 +-
 tools/perf/Makefile.perf                 |   8 +-
 tools/perf/builtin-check.c               |   2 +-
 tools/perf/scripts/install-build-deps.sh |   4 +-
 tools/perf/tests/make                    |   8 +-
 tools/perf/ui/browsers/scripts.c         | 184 +++++++++++++++--------
 12 files changed, 156 insertions(+), 103 deletions(-)
 delete mode 100644 tools/build/feature/test-libpython.c
 create mode 100644 tools/build/feature/test-python-module.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 331f5cdfc34b..3ca7a4f5c7fd 100644
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
@@ -145,7 +145,7 @@ FEATURE_DISPLAY ?=              \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
-         libpython              \
+         python-module          \
          libcapstone            \
          llvm-perf              \
          zlib                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index cdf89f132074..269af8e8f5cf 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -32,7 +32,7 @@ FILES=                                          \
          test-libnuma.bin                       \
          test-numa_num_possible_cpus.bin        \
          test-libperl.bin                       \
-         test-libpython.bin                     \
+         test-python-module.bin                 \
          test-libslang.bin                      \
          test-libtraceevent.bin                 \
          test-libcpupower.bin                   \
@@ -261,7 +261,7 @@ endif
 $(OUTPUT)test-libperl.bin:
 	$(BUILD) $(FLAGS_PERL_EMBED)
 
-$(OUTPUT)test-libpython.bin:
+$(OUTPUT)test-python-module.bin:
 	$(BUILD) $(FLAGS_PYTHON_EMBED)
 
 $(OUTPUT)test-libbfd.bin:
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 544563d62950..0ee16eccd9e0 100644
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
index 000000000000..50e9e5062feb
--- /dev/null
+++ b/tools/build/feature/test-python-module.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <Python.h>
+
+int main(void)
+{
+	static struct PyModuleDef moduledef = {
+		PyModuleDef_HEAD_INIT,
+		.m_name = "test",
+	};
+	PyObject *module = PyModule_Create(&moduledef);
+
+	return module ? 0 : -1;
+}
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 3d169e5bb372..a80913794eb6 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -65,6 +65,7 @@ feature::
                 libunwind               /  HAVE_LIBUNWIND_SUPPORT
                 lzma                    /  HAVE_LZMA_SUPPORT
                 numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
+                python-module           /  HAVE_PYTHON_MODULE_SUPPORT
                 zlib                    /  HAVE_ZLIB_SUPPORT
                 zstd                    /  HAVE_ZSTD_SUPPORT
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 66291d868bc0..e469c5ee5424 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -305,7 +305,7 @@ PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
 
 # Python 3.8 changed the output of `python-config --ldflags` to not include the
 # '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
-# libpython fails if that flag is not included in LDFLAGS
+# python-module fails if that flag is not included in LDFLAGS
 ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
   PYTHON_CONFIG_LDFLAGS := --ldflags --embed
 else
@@ -328,8 +328,8 @@ ifdef PYTHON_CONFIG
   endif
 endif
 
-FEATURE_CHECK_CFLAGS-libpython := $(PYTHON_EMBED_CCOPTS)
-FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
+FEATURE_CHECK_CFLAGS-python-module := $(PYTHON_EMBED_CCOPTS)
+FEATURE_CHECK_LDFLAGS-python-module := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
@@ -801,13 +801,12 @@ endif
 
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
 
@@ -820,10 +819,10 @@ else
       $(call disable-python,No 'python-config' tool was found: disables Python support - please install python-devel/python-dev)
     else
 
-      ifneq ($(feature-libpython), 1)
+      ifneq ($(feature-python-module), 1)
         $(call disable-python,No 'Python.h' was found: disables Python support - please install python-devel/python-dev)
       else
-         CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
+         CFLAGS += -DHAVE_PYTHON_MODULE_SUPPORT
          PYTHON_SETUPTOOLS_INSTALLED := $(shell $(PYTHON) -c 'import setuptools;' 2> /dev/null && echo "yes" || echo "no")
          ifeq ($(PYTHON_SETUPTOOLS_INSTALLED), yes)
            PYTHON_EXTENSION_SUFFIX := $(shell $(PYTHON) -c 'from importlib import machinery; print(machinery.EXTENSION_SUFFIXES[0])')
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 36c251b98919..0daac2f9e349 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -19,7 +19,7 @@ include ../scripts/utilities.mak
 #
 # Define LIBPERL to enable perl script extension.
 #
-# Define NO_LIBPYTHON to disable python script extension.
+# Define NO_PYTHON_MODULE to disable python script extension.
 #
 # Define PYTHON to point to the python binary if the default
 # `python' is not correct; for example: PYTHON=python2
@@ -903,11 +903,9 @@ ifdef LIBPERL
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'; \
 		$(INSTALL) scripts/perl/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/bin'
 endif
-ifndef NO_LIBPYTHON
+
+ifndef NO_PYTHON_MODULE
 	$(call QUIET_INSTALL, python-scripts) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
-		$(INSTALL) python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'
-	$(call QUIET_INSTALL, python-scripts-standalone) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
 		$(INSTALL) python/*.py -m 755 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
 		$(INSTALL) python/perf.pyi -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 35272aaeb613..06711362d37f 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -52,7 +52,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
-	FEATURE_STATUS("python-module", HAVE_LIBPYTHON_SUPPORT),
+	FEATURE_STATUS("python-module", HAVE_PYTHON_MODULE_SUPPORT),
 	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
 	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index a601a5260c17..3e53c7bf0f85 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -155,7 +155,7 @@ fedora_pkg_for() {
 	libcapstone)
 		echo "capstone-devel"
 		;;
-	libpython)
+	python-module)
 		echo "python3-devel"
 		;;
 	libtraceevent)
@@ -314,7 +314,7 @@ debian_pkg_for() {
 	libcapstone)
 		echo "libcapstone-dev"
 		;;
-	libpython)
+	python-module)
 		echo "python3-dev"
 		;;
 	libtraceevent)
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index f879f8109072..b5eaf326573c 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -77,8 +77,8 @@ make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
 make_libperl        := LIBPERL=1
-make_no_libpython   := NO_LIBPYTHON=1
-make_no_scripts     := NO_LIBPYTHON=1
+make_no_python_module := NO_PYTHON_MODULE=1
+make_no_scripts     := NO_PYTHON_MODULE=1
 make_no_slang       := NO_SLANG=1
 make_no_demangle    := NO_DEMANGLE=1
 make_no_libelf      := NO_LIBELF=1
@@ -118,7 +118,7 @@ make_install_prefix_slash := install prefix=/tmp/krava/
 make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1
 
 # all the NO_* variable combined
-make_minimal        := NO_LIBPYTHON=1
+make_minimal        := NO_PYTHON_MODULE=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
 make_minimal        += NO_LIBBPF=1
@@ -150,7 +150,7 @@ run += make_jevents_all
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 run += make_libperl
-run += make_no_libpython
+run += make_no_python_module
 run += make_no_scripts
 run += make_no_slang
 run += make_no_demangle
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 94cc1f427c96..b8a3383ec02a 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -1,4 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <dirent.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
 #include "../../util/util.h" // perf_exe()
 #include "../util.h"
 #include "../../util/evlist.h"
@@ -14,7 +21,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <subcmd/exec-cmd.h>
-#include <stdlib.h>
 
 #define SCRIPT_NAMELEN	128
 #define SCRIPT_MAX_NO	64
@@ -128,7 +134,7 @@ static int check_ev_match(int dir_fd, const char *scriptname, struct perf_sessio
 			if (!len)
 				break;
 
-			snprintf(evname, len + 1, "%s", p);
+			snprintf(evname, sizeof(evname), "%.*s", (int)len, p);
 
 			match = 0;
 			evlist__for_each_entry(session->evlist, pos) {
@@ -159,6 +165,7 @@ static int check_ev_match(int dir_fd, const char *scriptname, struct perf_sessio
 static int find_scripts(char **scripts_array, char **scripts_path_array, int num,
 		 int pathlen)
 {
+	int namelen;
 	struct dirent *script_dirent, *lang_dirent;
 	int scripts_dir_fd, lang_dir_fd;
 	DIR *scripts_dir, *lang_dir;
@@ -180,73 +187,118 @@ static int find_scripts(char **scripts_array, char **scripts_path_array, int num
 
 		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
 		scripts_dir_fd = open(scripts_path, O_DIRECTORY);
-		pr_err("Failed to open directory '%s'", scripts_path);
-		if (scripts_dir_fd == -1) {
-			perf_session__delete(session);
-			return -1;
-		}
 	}
-	scripts_dir = fdopendir(scripts_dir_fd);
-	if (!scripts_dir) {
-		close(scripts_dir_fd);
-		perf_session__delete(session);
-		return -1;
+	if (scripts_dir_fd != -1) {
+		scripts_dir = fdopendir(scripts_dir_fd);
+		if (scripts_dir) {
+			while ((lang_dirent = readdir(scripts_dir)) != NULL) {
+				if (lang_dirent->d_type != DT_DIR &&
+				    (lang_dirent->d_type == DT_UNKNOWN &&
+				     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
+					continue;
+				if (!strcmp(lang_dirent->d_name, ".") ||
+				    !strcmp(lang_dirent->d_name, ".."))
+					continue;
+
+				if (strstr(lang_dirent->d_name, "python"))
+					continue;
+
+				lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name,
+					     O_DIRECTORY);
+				if (lang_dir_fd == -1)
+					continue;
+				lang_dir = fdopendir(lang_dir_fd);
+				if (!lang_dir) {
+					close(lang_dir_fd);
+					continue;
+				}
+				while ((script_dirent = readdir(lang_dir)) != NULL) {
+					if (script_dirent->d_type == DT_DIR)
+						continue;
+					if (script_dirent->d_type == DT_UNKNOWN &&
+					    is_directory_at(lang_dir_fd, script_dirent->d_name))
+						continue;
+					/* Skip those real time scripts: xxxtop.p[yl] */
+					if (strstr(script_dirent->d_name, "top."))
+						continue;
+					if (i >= num)
+						break;
+					scnprintf(scripts_path_array[i], pathlen,
+						  "%s/scripts/%s/%s", exec_path,
+						  lang_dirent->d_name,
+						  script_dirent->d_name);
+					temp = strrchr(script_dirent->d_name, '.');
+					namelen = temp ? (int)(temp - script_dirent->d_name)
+							       : (int)strlen(script_dirent->d_name);
+
+					if (namelen >= SCRIPT_NAMELEN)
+						namelen = SCRIPT_NAMELEN - 1;
+					snprintf(scripts_array[i], namelen + 1, "%s",
+						 script_dirent->d_name);
+
+					if (check_ev_match(lang_dir_fd, scripts_array[i], session))
+						continue;
+
+					i++;
+				}
+				closedir(lang_dir);
+			}
+			closedir(scripts_dir);
+		} else {
+			close(scripts_dir_fd);
+		}
 	}
 
-	while ((lang_dirent = readdir(scripts_dir)) != NULL) {
-		if (lang_dirent->d_type != DT_DIR &&
-		    (lang_dirent->d_type == DT_UNKNOWN &&
-		     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
-			continue;
-		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".."))
-			continue;
-
-#ifndef HAVE_LIBPERL_SUPPORT
-		if (strstr(lang_dirent->d_name, "perl"))
-			continue;
-#endif
-#ifndef HAVE_LIBPYTHON_SUPPORT
-		if (strstr(lang_dirent->d_name, "python"))
-			continue;
-#endif
-
-		lang_dir_fd = openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY);
-		if (lang_dir_fd == -1)
-			continue;
-		lang_dir = fdopendir(lang_dir_fd);
-		if (!lang_dir) {
-			close(lang_dir_fd);
-			continue;
-		}
-		while ((script_dirent = readdir(lang_dir)) != NULL) {
-			if (script_dirent->d_type == DT_DIR)
-				continue;
-			if (script_dirent->d_type == DT_UNKNOWN &&
-			    is_directory_at(lang_dir_fd, script_dirent->d_name))
-				continue;
-			/* Skip those real time scripts: xxxtop.p[yl] */
-			if (strstr(script_dirent->d_name, "top."))
-				continue;
-			if (i >= num)
-				break;
-			scnprintf(scripts_path_array[i], pathlen, "%s/scripts/%s/%s",
-				exec_path,
-				lang_dirent->d_name,
-				script_dirent->d_name);
-			temp = strchr(script_dirent->d_name, '.');
-			snprintf(scripts_array[i],
-				(temp - script_dirent->d_name) + 1,
-				"%s", script_dirent->d_name);
-
-			if (check_ev_match(lang_dir_fd, scripts_array[i], session))
-				continue;
-
-			i++;
+#ifdef HAVE_PYTHON_MODULE_SUPPORT
+	{
+		char py_scripts_path[PATH_MAX];
+		int py_scripts_dir_fd;
+		DIR *py_scripts_dir;
+		int len;
+
+		snprintf(py_scripts_path, sizeof(py_scripts_path), "%s/python", exec_path);
+		py_scripts_dir_fd = open(py_scripts_path, O_DIRECTORY);
+		if (py_scripts_dir_fd != -1) {
+			py_scripts_dir = fdopendir(py_scripts_dir_fd);
+			if (py_scripts_dir) {
+				while ((script_dirent = readdir(py_scripts_dir)) != NULL) {
+					if (script_dirent->d_type == DT_DIR)
+						continue;
+					if (script_dirent->d_type == DT_UNKNOWN &&
+					    is_directory_at(py_scripts_dir_fd,
+						    script_dirent->d_name))
+						continue;
+					/* Skip those real time scripts: xxxtop.p[yl] */
+					if (strstr(script_dirent->d_name, "top."))
+						continue;
+					if (i >= num)
+						break;
+					len = strlen(script_dirent->d_name);
+					if (len <= 3 ||
+					    strcmp(script_dirent->d_name + len - 3, ".py"))
+						continue;
+
+					scnprintf(scripts_path_array[i], pathlen, "%s/python/%s",
+						exec_path,
+						script_dirent->d_name);
+					temp = strrchr(script_dirent->d_name, '.');
+					namelen = temp ? (int)(temp - script_dirent->d_name)
+							       : (int)strlen(script_dirent->d_name);
+
+					if (namelen >= SCRIPT_NAMELEN)
+						namelen = SCRIPT_NAMELEN - 1;
+					snprintf(scripts_array[i], namelen + 1, "%s",
+						 script_dirent->d_name);
+
+					i++;
+				}
+				closedir(py_scripts_dir);
+			} else {
+				close(py_scripts_dir_fd);
+			}
 		}
-		closedir(lang_dir);
 	}
-
-	closedir(scripts_dir);
+#endif
 	perf_session__delete(session);
 	return i;
 }
@@ -264,7 +316,7 @@ static int list_scripts(char *script_name, bool *custom,
 	int ret = 0;
 	int max_std, custom_perf;
 	char pbuf[256];
-	const char *perf = perf_exe(pbuf, sizeof pbuf);
+	const char *perf = perf_exe(pbuf, sizeof(pbuf));
 	struct script_config scriptc = {
 		.names = (const char **)names,
 		.paths = paths,
@@ -354,7 +406,7 @@ int script_browse(const char *script_opt, struct evsel *evsel)
 		return -1;
 
 	if (asprintf(&cmd, "%s%s %s %s%s 2>&1 | less",
-			custom ? "perf script -s " : "",
+			custom ? "perf script " : "",
 			script_name,
 			script_opt ? script_opt : "",
 			input_name ? "-i " : "",
-- 
2.56.0.rc1.310.g51773c2048-goog

