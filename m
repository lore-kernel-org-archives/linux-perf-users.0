Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A63B2FD4
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403775; cv=none; b=VJ1rcxiOrh3Z8IfoKJU46lEPIdT4eK9pw1JxwAUxkLyd/Z6Q1CsVD1XEO9MMhmFOsLqKhnm7OEPoOFCwrwBdV8KK9xO3rvDzF0n84RBMmu6jecCRrFE+f579NLuaNL1a9SdFsE86ULLyw0VVbUTD7QhMpZ262KKoidBzXtrdtUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403775; c=relaxed/simple;
	bh=XJeyCGZTwyLwK78ky/PSydCnqWccLXi2BkIpz1j4dNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gvxuUHgdFEJxSQQzgSo9p+XA+UgB9oSX66EAbYkXajw7n2nSzlkHbfPwGSIDJYCP0tQe24M9KB5QTdqIhmRRd3/gfUBR3f+EwJXzytwvQjYaPQyCz/RmfssG6zBd8zzZerTZo9JiEH4eceEctURyesMitX8UJfbURyPWU/lQ5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9fAKUia; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9fAKUia"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-142f4306744so4687218c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403757; x=1791008557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qfua67QkcRb16bANLdcj21JEngXDyRMrB77SCNsh/O0=;
        b=r9fAKUiaJR9sAIzFxHxIldVGFQN4BfsuYK2o/uNe8DKA1yKPk6HmqjnftP63iKydF3
         FkDIzHWCeNKjXRDL61bGUa0MibASo/8M1+igEAcUwbDbw5J1hAtmTrvXSNzPvnj+nS10
         GNQJiCFYN2KoVglX3k0jqHbUJwg2qtYOFsV2HQ7QqD+t5f5tw5dS5xIY1lMe/yWfoetr
         O4EDIMDUez4XYYD0+qF8/6rSXXsN/OZcfOSAyDtru+ZAZDUmYYMGkXVjU34OceGAmaUR
         04xvMClswBWX5DaFrK7JCy2FXOS4/UZ0DahFBuqsLHz1bUgyuWHIYm+eFjgNopOs7m6Z
         qB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403757; x=1791008557;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qfua67QkcRb16bANLdcj21JEngXDyRMrB77SCNsh/O0=;
        b=SnH6Xv6VoNIdxHS6rugYvi+3PexoB3nwShDxZoO3IMD3ACDcekRtk48HT1XeD5i7E5
         x8KIOAktdijTizGpLgtk0ZICGvd3zWM0o5tD9NwAMk1pSSCAO47U463pV/IzwwAurqNs
         pVg9UMTM6bV6xlhiTdsBNRuj+x0HHtpdEvS8+3d/kosBdWhbYc4BnZvv/4Ww6bk+JMY6
         i0NIXlowu3v9HakxWuvj3kNU7XgnyLh2unJtLpHQ/SGkmEFibjkIcRk1vY+8mnMGt076
         nTal6h8GU/ohql2auvsB69xEpUDVVe86zD8D4K8JmwKX0co+AkfufHwEsmSZR6FUyP8U
         pP3A==
X-Forwarded-Encrypted: i=1; AKwUvBwX69t0zVRXWC4sEQTECqvdsEUADFmJ09FCqqg0NjIeDzbnkpaZiAofOh2z2kRYUlaV1xXgB89DqPkaLVPFKTN5@vger.kernel.org
X-Gm-Message-State: AFuF++nWlT9GBBZUzx0j0jcw005Wrl7tcnLlt+oyAXK2oYpLw1SvMieD
	5AaDR/ymLPAnAUj0eOuehRXFR1cBrL7J8KtPfztOhSS0PKElSZl3fYLR/iqsET3psr4cWeemn2Q
	u6bvxS96btw==
X-Received: from dlbsw8.prod.google.com ([2002:a05:7022:3a88:b0:146:40d5:dd6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:424c:20b0:143:2984:6518
 with SMTP id a92af1059eb24-146d096b0camr2170865c88.39.1790403755481; Fri, 25
 Sep 2026 23:22:35 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:20:15 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-49-irogers@google.com>
Subject: [PATCH v4 48/49] perf script: Support standalone scripts and remove
 embedded scripting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Refactor 'perf script' to launch standalone scripts directly via fork()
and execvp() and remove the legacy embedded Perl and Python scripting
engines:
- Remove the embedded Perl scripting engine
  (util/scripting-engines/trace-event-perl.c), Perl scripts, bin
  wrappers, and Trace-Util library
  (scripts/perl/Perf-Trace-Util/), and script_perl.sh test.
- Remove libperl feature checks from Makefile.config, Makefile.perf,
  builtin-check.c, and Documentation/perf-check.txt.
- Remove -g / --gen-script option and scripting_ops dispatch table from
  builtin-script.c and trace-event-scripting.c.
- Hide the legacy -s / --script option and update script discovery in
  find_script() and list_available_scripts() to prioritize the system
  'python' directory over bare filenames in the current directory.
- Update the Python script shell tests (test_arm_coresight_disasm.sh,
  test_task_analyzer.sh, and test_*_python.sh) to invoke scripts via
  'perf script <script>' rather than running the Python interpreter
  directly on the script file path.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                  |    1 -
 tools/build/feature/Makefile                  |   20 -
 tools/build/feature/test-libperl.c            |   10 -
 tools/perf/Build                              |    1 -
 tools/perf/Documentation/perf-check.txt       |    1 -
 tools/perf/Makefile.config                    |    1 -
 tools/perf/Makefile.perf                      |   14 -
 tools/perf/builtin-check.c                    |    1 -
 tools/perf/builtin-script.c                   | 1016 +++++++++--------
 tools/perf/scripts/Build                      |    3 -
 tools/perf/scripts/perl/Perf-Trace-Util/Build |    9 -
 .../scripts/perl/Perf-Trace-Util/Context.c    |  122 --
 .../scripts/perl/Perf-Trace-Util/Context.xs   |   42 -
 .../scripts/perl/Perf-Trace-Util/Makefile.PL  |   18 -
 .../perf/scripts/perl/Perf-Trace-Util/README  |   59 -
 .../Perf-Trace-Util/lib/Perf/Trace/Context.pm |   55 -
 .../Perf-Trace-Util/lib/Perf/Trace/Core.pm    |  192 ----
 .../Perf-Trace-Util/lib/Perf/Trace/Util.pm    |   94 --
 .../perf/scripts/perl/Perf-Trace-Util/typemap |    1 -
 .../scripts/perl/bin/check-perf-trace-record  |    2 -
 .../scripts/perl/bin/failed-syscalls-record   |    3 -
 .../scripts/perl/bin/failed-syscalls-report   |   10 -
 tools/perf/scripts/perl/bin/rw-by-file-record |    3 -
 tools/perf/scripts/perl/bin/rw-by-file-report |   10 -
 tools/perf/scripts/perl/bin/rw-by-pid-record  |    2 -
 tools/perf/scripts/perl/bin/rw-by-pid-report  |    3 -
 tools/perf/scripts/perl/bin/rwtop-record      |    2 -
 tools/perf/scripts/perl/bin/rwtop-report      |   20 -
 .../scripts/perl/bin/wakeup-latency-record    |    6 -
 .../scripts/perl/bin/wakeup-latency-report    |    3 -
 tools/perf/scripts/perl/check-perf-trace.pl   |  106 --
 tools/perf/scripts/perl/failed-syscalls.pl    |   47 -
 tools/perf/scripts/perl/rw-by-file.pl         |  106 --
 tools/perf/scripts/perl/rw-by-pid.pl          |  184 ---
 tools/perf/scripts/perl/rwtop.pl              |  203 ----
 tools/perf/scripts/perl/wakeup-latency.pl     |  107 --
 tools/perf/tests/make                         |    2 -
 .../coresight/test_arm_coresight_disasm.sh    |   14 +-
 tools/perf/tests/shell/script_perl.sh         |  102 --
 .../shell/test_check_perf_trace_python.sh     |    2 +-
 .../shell/test_compaction_times_python.sh     |    6 +-
 .../test_event_analyzing_sample_python.sh     |    3 +-
 .../shell/test_export_to_postgresql_python.sh |    8 +-
 .../shell/test_export_to_sqlite_python.sh     |    4 +-
 .../test_failed_syscalls_by_pid_python.sh     |    7 +-
 .../shell/test_failed_syscalls_python.sh      |    2 +-
 .../tests/shell/test_flamegraph_python.sh     |    8 +-
 .../shell/test_futex_contention_python.sh     |    2 +-
 tools/perf/tests/shell/test_gecko_python.sh   |    2 +-
 .../shell/test_intel_pt_events_python.sh      |    2 +-
 .../tests/shell/test_mem_phys_addr_python.sh  |    3 +-
 .../shell/test_net_dropmonitor_python.sh      |    2 +-
 .../tests/shell/test_netdev_times_python.sh   |    2 +-
 .../tests/shell/test_powerpc_hcalls_python.sh |    2 +-
 .../tests/shell/test_rw_by_file_python.sh     |    2 +-
 .../perf/tests/shell/test_rw_by_pid_python.sh |    2 +-
 tools/perf/tests/shell/test_rwtop_python.sh   |    2 +-
 .../shell/test_sched_migration_python.sh      |    2 +-
 tools/perf/tests/shell/test_sctop_python.sh   |    4 +-
 .../tests/shell/test_stackcollapse_python.sh  |    6 +-
 .../perf/tests/shell/test_stat_cpi_python.sh  |    4 +-
 .../test_syscall_counts_by_pid_python.sh      |    7 +-
 .../tests/shell/test_syscall_counts_python.sh |    4 +-
 tools/perf/tests/shell/test_task_analyzer.sh  |   58 +-
 .../tests/shell/test_wakeup_latency_python.sh |    4 +-
 tools/perf/ui/browsers/scripts.c              |  161 +--
 tools/perf/util/Build                         |    3 -
 tools/perf/util/scripting-engines/Build       |    5 -
 .../util/scripting-engines/trace-event-perl.c |  770 -------------
 tools/perf/util/trace-event-parse.c           |   65 --
 tools/perf/util/trace-event-scripting.c       |  398 -------
 tools/perf/util/trace-event.h                 |   72 +-
 72 files changed, 607 insertions(+), 3612 deletions(-)
 delete mode 100644 tools/build/feature/test-libperl.c
 delete mode 100644 tools/perf/scripts/Build
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.xs
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Makefile.PL
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/README
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/=
Context.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/=
Core.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/=
Util.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/typemap
 delete mode 100644 tools/perf/scripts/perl/bin/check-perf-trace-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-report
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-record
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-report
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-record
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-report
 delete mode 100644 tools/perf/scripts/perl/check-perf-trace.pl
 delete mode 100644 tools/perf/scripts/perl/failed-syscalls.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-file.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-pid.pl
 delete mode 100644 tools/perf/scripts/perl/rwtop.pl
 delete mode 100644 tools/perf/scripts/perl/wakeup-latency.pl
 delete mode 100755 tools/perf/tests/shell/script_perl.sh
 delete mode 100644 tools/perf/util/scripting-engines/Build
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-perl.c
 delete mode 100644 tools/perf/util/trace-event-scripting.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3ca7a4f5c7fd..dbef5b6c4e43 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -121,7 +121,6 @@ FEATURE_TESTS_EXTRA :=3D                  \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
-         libperl                        \
          llvm                           \
          libbpf                         \
          libpfm4                        \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 269af8e8f5cf..62f9cbf3dee9 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -31,7 +31,6 @@ FILES=3D                                          \
          test-libdebuginfod.bin                 \
          test-libnuma.bin                       \
          test-numa_num_possible_cpus.bin        \
-         test-libperl.bin                       \
          test-python-module.bin                 \
          test-libslang.bin                      \
          test-libtraceevent.bin                 \
@@ -242,25 +241,6 @@ $(OUTPUT)test-libtracefs.bin:
 $(OUTPUT)test-gtk4.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk4 2>/dev/null)
=20
-grep-libs  =3D $(filter -l%,$(1))
-strip-libs =3D $(filter-out -l%,$(1))
-
-PERL_EMBED_LDOPTS =3D $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null=
)
-PERL_EMBED_LDFLAGS =3D $(call strip-libs,$(PERL_EMBED_LDOPTS))
-PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EMBED_LDOPTS))
-PERL_EMBED_CCOPTS =3D $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null=
)
-FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
-
-ifeq ($(CC_NO_CLANG), 0)
-  PERL_EMBED_LDOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_LDOPTS))
-  PERL_EMBED_CCOPTS :=3D $(filter-out -flto=3Dauto -ffat-lto-objects, $(PE=
RL_EMBED_CCOPTS))
-  PERL_EMBED_CCOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_CCOPTS))
-  FLAGS_PERL_EMBED +=3D -Wno-compound-token-split-by-macro
-endif
-
-$(OUTPUT)test-libperl.bin:
-	$(BUILD) $(FLAGS_PERL_EMBED)
-
 $(OUTPUT)test-python-module.bin:
 	$(BUILD) $(FLAGS_PYTHON_EMBED)
=20
diff --git a/tools/build/feature/test-libperl.c b/tools/build/feature/test-=
libperl.c
deleted file mode 100644
index 0415f437eb31..000000000000
--- a/tools/build/feature/test-libperl.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <EXTERN.h>
-#include <perl.h>
-
-int main(void)
-{
-	perl_alloc();
-
-	return 0;
-}
diff --git a/tools/perf/Build b/tools/perf/Build
index 5bd0e58d7cb0..8a0b5592a973 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -61,7 +61,6 @@ perf-util-y +=3D arch/
 perf-y +=3D arch/
 perf-test-y +=3D arch/
 perf-ui-y +=3D ui/
-perf-util-y +=3D scripts/
=20
 gtk-y +=3D ui/gtk/
=20
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documenta=
tion/perf-check.txt
index a80913794eb6..1406a41c5d09 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -58,7 +58,6 @@ feature::
                 libLLVM                 /  HAVE_LIBLLVM_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
-                libperl                 /  HAVE_LIBPERL_SUPPORT
                 libpfm4                 /  HAVE_LIBPFM
                 libslang                /  HAVE_SLANG_SUPPORT
                 libtraceevent           /  HAVE_LIBTRACEEVENT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6c0071db8523..6e92f66afe90 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1280,7 +1280,6 @@ $(call detected_var,tipdir_SQ)
 $(call detected_var,srcdir_SQ)
 $(call detected_var,LIBDIR)
 $(call detected_var,GTK_CFLAGS)
-$(call detected_var,PERL_EMBED_CCOPTS)
 $(call detected_var,PYTHON_EMBED_CCOPTS)
 ifneq ($(BISON_FILE_PREFIX_MAP),)
 $(call detected_var,BISON_FILE_PREFIX_MAP)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8fe603aa9773..1768948d17b5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -17,7 +17,6 @@ include ../scripts/utilities.mak
 #
 # Define CROSS_COMPILE as prefix name of compiler if you want cross-builds=
.
 #
-# Define LIBPERL to enable perl script extension.
 #
 # Define NO_PYTHON_MODULE to disable python script extension.
 #
@@ -483,11 +482,6 @@ OTHER_PROGRAMS =3D $(OUTPUT)perf
 ifndef SHELL_PATH
   SHELL_PATH =3D /bin/sh
 endif
-ifndef PERL_PATH
-  PERL_PATH =3D /usr/bin/perl
-endif
-
-export PERL_PATH
=20
 LIBPERF_BENCH_IN :=3D $(OUTPUT)perf-bench-in.o
 LIBPERF_BENCH :=3D $(OUTPUT)libperf-bench.a
@@ -892,14 +886,6 @@ endif
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
'
 	$(call QUIET_INSTALL, perf-iostat) \
 		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
-ifdef LIBPERL
-	$(call QUIET_INSTALL, perl-scripts) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/P=
erf-Trace-Util/lib/Perf/Trace'; \
-		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DE=
STDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace=
'; \
-		$(INSTALL) scripts/perl/*.pl -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_=
SQ)/scripts/perl'; \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/b=
in'; \
-		$(INSTALL) scripts/perl/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/sc=
ripts/perl/bin'
-endif
=20
 ifndef NO_PYTHON_MODULE
 	$(call QUIET_INSTALL, python-scripts) \
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 06711362d37f..1e43e097e7a7 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -51,7 +51,6 @@ struct feature_status supported_features[] =3D {
 	FEATURE_STATUS("libLLVM", HAVE_LIBLLVM_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
-	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBP=
ERL=3D1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
 	FEATURE_STATUS("python-module", HAVE_PYTHON_MODULE_SUPPORT),
 	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 565ee8d55f80..b6691ebb1b4e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <signal.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <strings.h>
=20
 #include <dirent.h>
 #include <fcntl.h>
@@ -18,6 +22,7 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <sys/utsname.h>
 #include <unistd.h>
=20
@@ -77,8 +82,7 @@
 #include <event-parse.h>
 #endif
=20
-static char const		*script_name;
-static char const		*generate_script_lang;
+static char			*script_name;
 static bool			reltime;
 static bool			deltatime;
 static u64			initial_time;
@@ -88,7 +92,6 @@ static u64			last_timestamp;
 static u64			nr_unordered;
 static bool			no_callchain;
 static bool			latency_format;
-static bool			system_wide;
 static bool			print_flags;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
@@ -96,6 +99,7 @@ static int			max_blocks;
 static struct dlfilter		*dlfilter;
 static int			dlargc;
 static char			**dlargv;
+static unsigned int		scripting_max_stack =3D PERF_MAX_STACK_DEPTH;
=20
 enum perf_output_field {
 	PERF_OUTPUT_COMM            =3D 1ULL << 0,
@@ -1810,6 +1814,144 @@ static int perf_sample__fprintf_bts(struct perf_sam=
ple *sample,
 	return printed;
 }
=20
+#define SAMPLE_FLAGS_BUF_SIZE 64
+#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
+
+static int sample_flags_to_name(u32 flags, char *str, size_t size)
+{
+	static const struct {
+		u32 flags;
+		const char *name;
+	} sample_flags[] =3D {
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
+		{PERF_IP_FLAG_BRANCH, "jmp"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"=
},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "ir=
et"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "sys=
call"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "s=
ysret"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
+		 PERF_IP_FLAG_ASYNC | PERF_IP_FLAG_INTERRUPT,
+		 "hw int"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentr=
y"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"=
},
+		{0, NULL}
+	};
+	static const struct {
+		u32 flags;
+		const char *name;
+	} branch_events[] =3D {
+		{PERF_IP_FLAG_BRANCH_MISS, "miss"},
+		{PERF_IP_FLAG_NOT_TAKEN, "not_taken"},
+		{0, NULL}
+	};
+	int i;
+	const char *prefix;
+	int pos =3D 0, ret, ev_idx =3D 0;
+	u32 xf =3D flags & PERF_ADDITIONAL_STATE_MASK;
+	u32 types, events;
+	char xs[16] =3D { 0 };
+
+	/* Clear additional state bits */
+	flags &=3D ~PERF_ADDITIONAL_STATE_MASK;
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN)
+		prefix =3D "tr strt ";
+	else if (flags & PERF_IP_FLAG_TRACE_END)
+		prefix =3D "tr end  ";
+	else
+		prefix =3D "";
+
+	ret =3D snprintf(str + pos, size - pos, "%s", prefix);
+	if (ret < 0)
+		return ret;
+	pos +=3D ret;
+
+	flags &=3D ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
+
+	types =3D flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
+	for (i =3D 0; sample_flags[i].name; i++) {
+		if (sample_flags[i].flags !=3D types)
+			continue;
+
+		ret =3D snprintf(str + pos, size - pos, "%s", sample_flags[i].name);
+		if (ret < 0)
+			return ret;
+		pos +=3D ret;
+		break;
+	}
+
+	events =3D flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
+	for (i =3D 0; branch_events[i].name; i++) {
+		if (!(branch_events[i].flags & events))
+			continue;
+
+		ret =3D snprintf(str + pos, size - pos, !ev_idx ? "/%s" : ",%s",
+			       branch_events[i].name);
+		if (ret < 0)
+			return ret;
+		pos +=3D ret;
+		ev_idx++;
+	}
+
+	/* Add an end character '/' for events */
+	if (ev_idx) {
+		ret =3D snprintf(str + pos, size - pos, "/");
+		if (ret < 0)
+			return ret;
+		pos +=3D ret;
+	}
+
+	if (!xf)
+		return pos;
+
+	snprintf(xs, sizeof(xs), "(%s%s%s)",
+		 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
+		 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
+		 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
+
+	/* Right align the string if its length is less than the limit */
+	if ((pos + strlen(xs)) < SAMPLE_FLAGS_STR_ALIGNED_SIZE)
+		ret =3D snprintf(str + pos, size - pos, "%*s",
+			       (int)(SAMPLE_FLAGS_STR_ALIGNED_SIZE - ret), xs);
+	else
+		ret =3D snprintf(str + pos, size - pos, " %s", xs);
+	if (ret < 0)
+		return ret;
+
+	return pos + ret;
+}
+
+static int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
+{
+	const char *chars =3D PERF_IP_FLAG_CHARS;
+	const size_t n =3D strlen(PERF_IP_FLAG_CHARS);
+	size_t i, pos =3D 0;
+	int ret;
+
+	ret =3D sample_flags_to_name(flags, str, sz);
+	if (ret > 0)
+		return ret;
+
+	for (i =3D 0; i < n; i++, flags >>=3D 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] =3D chars[i];
+	}
+	for (; i < 32; i++, flags >>=3D 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] =3D '?';
+	}
+	if (pos < sz)
+		str[pos] =3D 0;
+
+	return pos;
+}
+
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	char str[SAMPLE_FLAGS_BUF_SIZE];
@@ -2654,8 +2796,6 @@ static void process_event(struct perf_script *script,
 		fflush(fp);
 }
=20
-static struct scripting_ops	*scripting_ops;
-
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads =3D perf_thread_map__nr(counter->core.threads);
@@ -2690,36 +2830,11 @@ static void __process_stat(struct evsel *counter, u=
64 tstamp)
=20
 static void process_stat(struct evsel *counter, u64 tstamp)
 {
-	if (scripting_ops && scripting_ops->process_stat)
-		scripting_ops->process_stat(&stat_config, counter, tstamp);
-	else
-		__process_stat(counter, tstamp);
-}
-
-static void process_stat_interval(u64 tstamp)
-{
-	if (scripting_ops && scripting_ops->process_stat_interval)
-		scripting_ops->process_stat_interval(tstamp);
-}
-
-static void setup_scripting(void)
-{
-#ifdef HAVE_LIBTRACEEVENT
-	setup_perl_scripting();
-#endif
-	setup_python_scripting();
+	__process_stat(counter, tstamp);
 }
=20
-static int flush_scripting(void)
+static void process_stat_interval(u64 tstamp __maybe_unused)
 {
-	return scripting_ops ? scripting_ops->flush_script() : 0;
-}
-
-static int cleanup_scripting(void)
-{
-	pr_debug("\nperf script stopped\n");
-
-	return scripting_ops ? scripting_ops->stop_script() : 0;
 }
=20
 static bool filter_cpu(struct perf_sample *sample)
@@ -2794,20 +2909,7 @@ static int process_sample_event(const struct perf_to=
ol *tool,
 		goto out_put;
 	}
=20
-	if (scripting_ops) {
-		struct addr_location *addr_al_ptr =3D NULL;
-
-		if ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
-		    sample_addr_correlates_sym(&evsel->core.attr)) {
-			if (!addr_al.thread)
-				thread__resolve(al.thread, &addr_al, sample);
-			addr_al_ptr =3D &addr_al;
-		}
-		scripting_ops->process_event(event, sample, &al, addr_al_ptr);
-	} else {
-		process_event(scr, sample, &al, &addr_al, machine);
-	}
-
+	process_event(scr, sample, &al, &addr_al, machine);
 out_put:
 	addr_location__exit(&addr_al);
 	addr_location__exit(&al);
@@ -3119,9 +3221,6 @@ static int process_switch_event(const struct perf_too=
l *tool,
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
=20
-	if (scripting_ops && scripting_ops->process_switch && !filter_cpu(sample)=
)
-		scripting_ops->process_switch(event, sample, machine);
-
 	if (!script->show_switch_events)
 		return 0;
=20
@@ -3129,18 +3228,6 @@ static int process_switch_event(const struct perf_to=
ol *tool,
 			   sample->tid);
 }
=20
-static int process_auxtrace_error(const struct perf_tool *tool,
-				  struct perf_session *session,
-				  union perf_event *event)
-{
-	if (scripting_ops && scripting_ops->process_auxtrace_error) {
-		scripting_ops->process_auxtrace_error(session, event);
-		return 0;
-	}
-
-	return perf_event__process_auxtrace_error(tool, session, event);
-}
-
 static int
 process_lost_event(const struct perf_tool *tool,
 		   union perf_event *event,
@@ -3153,12 +3240,11 @@ process_lost_event(const struct perf_tool *tool,
=20
 static int
 process_throttle_event(const struct perf_tool *tool __maybe_unused,
-		       union perf_event *event,
-		       struct perf_sample *sample,
-		       struct machine *machine)
+		       union perf_event *event __maybe_unused,
+		       struct perf_sample *sample __maybe_unused,
+		       struct machine *machine __maybe_unused)
 {
-	if (scripting_ops && scripting_ops->process_throttle)
-		scripting_ops->process_throttle(event, sample, machine);
+
 	return 0;
 }
=20
@@ -3301,10 +3387,9 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.mmap =3D process_mmap_event;
 		script->tool.mmap2 =3D process_mmap2_event;
 	}
-	if (script->show_switch_events || (scripting_ops && scripting_ops->proces=
s_switch))
+	if (script->show_switch_events)
 		script->tool.context_switch =3D process_switch_event;
-	if (scripting_ops && scripting_ops->process_auxtrace_error)
-		script->tool.auxtrace_error =3D process_auxtrace_error;
+	script->tool.auxtrace_error =3D perf_event__process_auxtrace_error;
 	if (script->show_namespace_events)
 		script->tool.namespaces =3D process_namespaces_event;
 	if (script->show_cgroup_events)
@@ -3341,96 +3426,48 @@ static int __cmd_script(struct perf_script *script)
 	return ret;
 }
=20
-static int list_available_languages_cb(struct scripting_ops *ops, const ch=
ar *spec)
-{
-	fprintf(stderr, "  %-42s [%s]\n", spec, ops->name);
-	return 0;
-}
-
-static void list_available_languages(void)
-{
-	fprintf(stderr, "\n");
-	fprintf(stderr, "Scripting language extensions (used in "
-		"perf script -s [spec:]script.[spec]):\n\n");
-	script_spec__for_each(&list_available_languages_cb);
-	fprintf(stderr, "\n");
-}
-
 /* Find script file relative to current directory or exec path */
 static char *find_script(const char *script)
 {
 	char path[PATH_MAX];
+	char *exec_path;
=20
-	if (!scripting_ops) {
-		const char *ext =3D strrchr(script, '.');
+	if (strchr(script, '/') && access(script, R_OK) =3D=3D 0)
+		return strdup(script);
=20
-		if (!ext)
-			return NULL;
+	exec_path =3D get_argv_exec_path();
+	if (exec_path) {
+		snprintf(path, sizeof(path), "%s/python/%s", exec_path, script);
+		if (access(path, R_OK) =3D=3D 0) {
+			free(exec_path);
+			return strdup(path);
+		}
=20
-		scripting_ops =3D script_spec__lookup(++ext);
-		if (!scripting_ops)
-			return NULL;
+		snprintf(path, sizeof(path), "%s/python/%s.py", exec_path, script);
+		free(exec_path);
+		if (access(path, R_OK) =3D=3D 0)
+			return strdup(path);
 	}
=20
-	if (access(script, R_OK)) {
-		char *exec_path =3D get_argv_exec_path();
-
-		if (!exec_path)
-			return NULL;
-		snprintf(path, sizeof(path), "%s/scripts/%s/%s",
-			 exec_path, scripting_ops->dirname, script);
-		free(exec_path);
-		script =3D path;
-		if (access(script, R_OK))
-			return NULL;
+	if (access(script, R_OK) =3D=3D 0) {
+		if (!strchr(script, '/')) {
+			snprintf(path, sizeof(path), "./%s", script);
+			return strdup(path);
+		}
+		return strdup(script);
 	}
-	return strdup(script);
+
+	/* Failure to find script. */
+	return NULL;
 }
=20
 static int parse_scriptname(const struct option *opt __maybe_unused,
 			    const char *str, int unset __maybe_unused)
 {
-	char spec[PATH_MAX];
-	const char *script, *ext;
-	int len;
-
-	if (strcmp(str, "lang") =3D=3D 0) {
-		list_available_languages();
-		exit(0);
-	}
-
-	script =3D strchr(str, ':');
-	if (script) {
-		len =3D script - str;
-		if (len >=3D PATH_MAX) {
-			fprintf(stderr, "invalid language specifier");
-			return -1;
-		}
-		strncpy(spec, str, len);
-		spec[len] =3D '\0';
-		scripting_ops =3D script_spec__lookup(spec);
-		if (!scripting_ops) {
-			fprintf(stderr, "invalid language specifier");
-			return -1;
-		}
-		script++;
-	} else {
-		script =3D str;
-		ext =3D strrchr(script, '.');
-		if (!ext) {
-			fprintf(stderr, "invalid script extension");
-			return -1;
-		}
-		scripting_ops =3D script_spec__lookup(++ext);
-		if (!scripting_ops) {
-			fprintf(stderr, "invalid script extension");
-			return -1;
-		}
-	}
-
-	script_name =3D find_script(script);
+	zfree(&script_name);
+	script_name =3D find_script(str);
 	if (!script_name)
-		script_name =3D strdup(script);
+		script_name =3D strdup(str);
=20
 	return 0;
 }
@@ -3618,7 +3655,6 @@ static int parse_output_fields(const struct option *o=
pt __maybe_unused,
 		    (script_dirent->d_type !=3D DT_UNKNOWN ||		\
 		     !is_directory(lang_path, script_dirent)))
=20
-
 #define RECORD_SUFFIX			"-record"
 #define REPORT_SUFFIX			"-report"
=20
@@ -3626,7 +3662,6 @@ struct script_desc {
 	struct list_head	node;
 	char			*name;
 	char			*half_liner;
-	char			*args;
 };
=20
 static LIST_HEAD(script_descs);
@@ -3641,16 +3676,16 @@ static struct script_desc *script_desc__new(const c=
har *name)
 	return s;
 }
=20
-static void script_desc__delete(struct script_desc *s)
-{
-	zfree(&s->name);
-	zfree(&s->half_liner);
-	zfree(&s->args);
-	free(s);
-}
-
 static void script_desc__add(struct script_desc *s)
 {
+	struct script_desc *pos;
+
+	list_for_each_entry(pos, &script_descs, node) {
+		if (s->name && pos->name && strcasecmp(s->name, pos->name) < 0) {
+			list_add_tail(&s->node, &pos->node);
+			return;
+		}
+	}
 	list_add_tail(&s->node, &script_descs);
 }
=20
@@ -3698,15 +3733,65 @@ static int read_script_info(struct script_desc *des=
c, const char *filename)
 {
 	char line[BUFSIZ], *p;
 	FILE *fp;
+	bool in_docstring =3D false;
+	bool found_description =3D false;
=20
 	fp =3D fopen(filename, "r");
 	if (!fp)
 		return -1;
=20
 	while (fgets(line, sizeof(line), fp)) {
+		static const char * const triple_quote_str[] =3D {
+			"\"\"\"",
+			"'''",
+			"r\"\"\"",
+		};
 		p =3D skip_spaces(line);
 		if (strlen(p) =3D=3D 0)
 			continue;
+
+		if (in_docstring) {
+			if (strlen(p) && p[strlen(p) - 1] =3D=3D '\n')
+				p[strlen(p) - 1] =3D '\0';
+			zfree(&desc->half_liner);
+			desc->half_liner =3D strdup(skip_spaces(p));
+			in_docstring =3D false;
+			found_description =3D true;
+			break;
+		}
+
+			for (size_t i =3D 0; i < ARRAY_SIZE(triple_quote_str); i++) {
+				const char *quote =3D triple_quote_str[i];
+				const char *close_quote =3D quote;
+
+				if (quote[0] =3D=3D 'r' || quote[0] =3D=3D 'R')
+					close_quote++;
+
+				if (!strstarts(p, quote))
+					continue;
+
+				p +=3D strlen(quote);
+				p =3D skip_spaces(p);
+				if (strlen(p) > 0) {
+					if (p[strlen(p) - 1] =3D=3D '\n')
+						p[strlen(p) - 1] =3D '\0';
+					p =3D skip_spaces(p);
+					if (str_ends_with(p, close_quote))
+						p[strlen(p) - strlen(close_quote)] =3D '\0';
+					zfree(&desc->half_liner);
+					desc->half_liner =3D strdup(skip_spaces(p));
+					found_description =3D true;
+					break;
+				}
+				in_docstring =3D true;
+				break;
+		}
+		if (found_description)
+			break;
+
+		if (in_docstring)
+			continue;
+
 		if (*p !=3D '#')
 			continue;
 		p++;
@@ -3719,14 +3804,17 @@ static int read_script_info(struct script_desc *des=
c, const char *filename)
=20
 		if (!strncmp(p, "description:", strlen("description:"))) {
 			p +=3D strlen("description:");
+			zfree(&desc->half_liner);
 			desc->half_liner =3D strdup(skip_spaces(p));
-			continue;
+			found_description =3D true;
+			break;
 		}
=20
-		if (!strncmp(p, "args:", strlen("args:"))) {
-			p +=3D strlen("args:");
-			desc->args =3D strdup(skip_spaces(p));
-			continue;
+		if (!found_description && strlen(p) > 0 &&
+		    strncmp(p, "SPDX-License-Identifier", 23)) {
+			if (!desc->half_liner)
+				desc->half_liner =3D strdup(p);
+			// Don't set found_description, maybe we find a better "description:" l=
ater!
 		}
 	}
=20
@@ -3757,23 +3845,21 @@ static int list_available_scripts(const struct opti=
on *opt __maybe_unused,
 				  const char *s __maybe_unused,
 				  int unset __maybe_unused)
 {
-	struct dirent *script_dirent, *lang_dirent;
-	char *buf, *scripts_path, *script_path, *lang_path, *first_half;
-	DIR *scripts_dir, *lang_dir;
+	struct dirent *script_dirent;
+	char *buf, *scripts_path, *script_path;
+	DIR *scripts_dir;
 	struct script_desc *desc;
 	char *script_root;
=20
-	buf =3D malloc(3 * MAXPATHLEN + BUFSIZ);
+	buf =3D malloc(2 * MAXPATHLEN + BUFSIZ);
 	if (!buf) {
 		pr_err("malloc failed\n");
 		exit(-1);
 	}
 	scripts_path =3D buf;
 	script_path =3D buf + MAXPATHLEN;
-	lang_path =3D buf + 2 * MAXPATHLEN;
-	first_half =3D buf + 3 * MAXPATHLEN;
=20
-	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
+	snprintf(scripts_path, MAXPATHLEN, "%s/python", get_argv_exec_path());
=20
 	scripts_dir =3D opendir(scripts_path);
 	if (!scripts_dir) {
@@ -3785,30 +3871,26 @@ static int list_available_scripts(const struct opti=
on *opt __maybe_unused,
 		exit(-1);
 	}
=20
-	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		scnprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			  lang_dirent->d_name);
-		lang_dir =3D opendir(lang_path);
-		if (!lang_dir)
-			continue;
+	while ((script_dirent =3D readdir(scripts_dir)) !=3D NULL) {
+		if (script_dirent->d_type !=3D DT_DIR &&
+		    (script_dirent->d_type !=3D DT_UNKNOWN ||
+		     !is_directory(scripts_path, script_dirent))) {
=20
-		for_each_script(lang_path, lang_dir, script_dirent) {
-			script_root =3D get_script_root(script_dirent, REPORT_SUFFIX);
+			script_root =3D get_script_root(script_dirent, ".py");
 			if (script_root) {
 				desc =3D script_desc__findnew(script_root);
 				scnprintf(script_path, MAXPATHLEN, "%s/%s",
-					  lang_path, script_dirent->d_name);
+					  scripts_path, script_dirent->d_name);
 				read_script_info(desc, script_path);
 				free(script_root);
 			}
 		}
 	}
+	closedir(scripts_dir);
=20
-	fprintf(stdout, "List of available trace scripts:\n");
+	fprintf(stdout, "List of available scripts:\n");
 	list_for_each_entry(desc, &script_descs, node) {
-		sprintf(first_half, "%s %s", desc->name,
-			desc->args ? desc->args : "");
-		fprintf(stdout, "  %-36s %s\n", first_half,
+		fprintf(stdout, "  %-36s %s\n", desc->name,
 			desc->half_liner ? desc->half_liner : "");
 	}
=20
@@ -3844,94 +3926,6 @@ static void free_dlarg(void)
 	free(dlargv);
 }
=20
-static char *get_script_path(const char *script_root, const char *suffix)
-{
-	struct dirent *script_dirent, *lang_dirent;
-	char scripts_path[MAXPATHLEN];
-	char script_path[MAXPATHLEN];
-	DIR *scripts_dir, *lang_dir;
-	char lang_path[MAXPATHLEN];
-	char *__script_root;
-
-	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
-
-	scripts_dir =3D opendir(scripts_path);
-	if (!scripts_dir)
-		return NULL;
-
-	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		scnprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			  lang_dirent->d_name);
-		lang_dir =3D opendir(lang_path);
-		if (!lang_dir)
-			continue;
-
-		for_each_script(lang_path, lang_dir, script_dirent) {
-			__script_root =3D get_script_root(script_dirent, suffix);
-			if (__script_root && !strcmp(script_root, __script_root)) {
-				free(__script_root);
-				closedir(scripts_dir);
-				scnprintf(script_path, MAXPATHLEN, "%s/%s",
-					  lang_path, script_dirent->d_name);
-				closedir(lang_dir);
-				return strdup(script_path);
-			}
-			free(__script_root);
-		}
-		closedir(lang_dir);
-	}
-	closedir(scripts_dir);
-
-	return NULL;
-}
-
-static bool is_top_script(const char *script_path)
-{
-	return ends_with(script_path, "top") !=3D NULL;
-}
-
-static int has_required_arg(char *script_path)
-{
-	struct script_desc *desc;
-	int n_args =3D 0;
-	char *p;
-
-	desc =3D script_desc__new(NULL);
-
-	if (read_script_info(desc, script_path))
-		goto out;
-
-	if (!desc->args)
-		goto out;
-
-	for (p =3D desc->args; *p; p++)
-		if (*p =3D=3D '<')
-			n_args++;
-out:
-	script_desc__delete(desc);
-
-	return n_args;
-}
-
-static int have_cmd(int argc, const char **argv)
-{
-	char **__argv =3D calloc(argc, sizeof(const char *));
-
-	if (!__argv) {
-		pr_err("malloc failed\n");
-		return -1;
-	}
-
-	memcpy(__argv, argv, sizeof(const char *) * argc);
-	argc =3D parse_options(argc, (const char **)__argv, record_options,
-			     NULL, PARSE_OPT_STOP_AT_NON_OPTION);
-	free(__argv);
-
-	system_wide =3D (argc =3D=3D 0);
-
-	return 0;
-}
-
 static void script__setup_sample_type(struct perf_script *script)
 {
 	struct perf_session *session =3D script->session;
@@ -4055,6 +4049,14 @@ static int perf_script__process_auxtrace_info(const =
struct perf_tool *tool,
 	return ret;
 }
=20
+static const char *script_itrace_opts;
+
+static int parse_script_itrace(const struct option *opt, const char *str, =
int unset)
+{
+	script_itrace_opts =3D unset ? "" : (str && *str ? str : "cepwx");
+	return itrace_parse_synth_opts(opt, str, unset);
+}
+
 static int parse_insn_trace(const struct option *opt __maybe_unused,
 			    const char *str, int unset __maybe_unused)
 {
@@ -4074,6 +4076,7 @@ static int parse_insn_trace(const struct option *opt =
__maybe_unused,
 	if (ret < 0)
 		return ret;
=20
+	script_itrace_opts =3D "i0nse";
 	itrace_parse_synth_opts(opt, "i0nse", 0);
 	symbol_conf.nanosecs =3D true;
 	return 0;
@@ -4095,6 +4098,7 @@ static int parse_call_trace(const struct option *opt =
__maybe_unused,
 			    int unset __maybe_unused)
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
+	script_itrace_opts =3D "cewp";
 	itrace_parse_synth_opts(opt, "cewp", 0);
 	symbol_conf.nanosecs =3D true;
 	symbol_conf.pad_output_len_dso =3D 50;
@@ -4106,27 +4110,102 @@ static int parse_callret_trace(const struct option=
 *opt __maybe_unused,
 			    int unset __maybe_unused)
 {
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent,+flags", =
0);
+	script_itrace_opts =3D "crewp";
 	itrace_parse_synth_opts(opt, "crewp", 0);
 	symbol_conf.nanosecs =3D true;
 	return 0;
 }
=20
+/*
+ * Detect scripts written for the removed legacy embedded Python scripting=
 API.
+ *
+ * Without an embedded interpreter invoking trace_begin()/process_event()/=
trace_end(),
+ * executing a callback-only legacy script directly under `python3` would =
simply
+ * define top-level functions and silently exit with status 0 without proc=
essing
+ * any events.
+ *
+ * Note on ordering and heuristics:
+ * 1) "perf_trace_context" and "Perf-Trace-Util" must be checked BEFORE
+ *    "import perf", because "import perf" is a substring prefix of
+ *    "import perf_trace_context".
+ * 2) Defining `def process_event(`, `def trace_begin(`, or `def trace_end=
(`
+ *    is only flagged as legacy when `!has_perf_import`, because standalon=
e
+ *    `import perf` scripts commonly define a helper named `def process_ev=
ent(sample):`
+ *    to pass as the `sample=3D` callback to `perf.session(...)`.
+ */
+static bool is_legacy_python_script(const char *path)
+{
+	struct stat st;
+	int fd;
+	FILE *fp;
+	char line[1024];
+	bool has_legacy_cb =3D false;
+	bool has_perf_import =3D false;
+
+	fd =3D open(path, O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return false;
+
+	if (fstat(fd, &st) < 0 || !S_ISREG(st.st_mode)) {
+		close(fd);
+		return false;
+	}
+
+	fp =3D fdopen(fd, "r");
+	if (!fp) {
+		close(fd);
+		return false;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		const char *p =3D skip_spaces(line);
+
+		if (*p =3D=3D '#')
+			continue;
+		if ((strstr(p, "import perf") && !strstr(p, "import perf_trace_context")=
) ||
+		    strstr(p, "from perf ") ||
+		    strstr(p, "__main__"))
+			has_perf_import =3D true;
+		if (strstr(p, "perf_trace_context") ||
+		    strstr(p, "Perf-Trace-Util") ||
+		    strstr(p, "def process_event(") ||
+		    strstr(p, "def trace_begin(") ||
+		    strstr(p, "def trace_end("))
+			has_legacy_cb =3D true;
+	}
+	fclose(fp);
+	return has_legacy_cb && !has_perf_import;
+}
+
+static volatile sig_atomic_t script_child_pid;
+
+static void forward_script_sig(int sig, siginfo_t *info, void *ucontext __=
maybe_unused)
+{
+	/*
+	 * Terminal-generated signals (Ctrl-C / Ctrl-\) have si_code > 0
+	 * (SI_KERNEL) and are already delivered by the TTY driver to the
+	 * entire foreground process group, including the child script.
+	 * Signals sent directly to the perf process via kill(2) / sigqueue(3)
+	 * have si_code <=3D 0 (SI_USER, SI_QUEUE, etc.) and must be forwarded
+	 * to the child script so it can catch KeyboardInterrupt / SIGTERM
+	 * and flush its output before exiting.
+	 */
+	if (script_child_pid > 0 && (sig =3D=3D SIGTERM || !info || info->si_code=
 <=3D 0))
+		kill(script_child_pid, sig);
+}
+
 int cmd_script(int argc, const char **argv)
 {
 	bool show_full_info =3D false;
 	bool header =3D false;
 	bool header_only =3D false;
-	bool script_started =3D false;
 	bool unsorted_dump =3D false;
 	bool merge_deferred_callchains =3D true;
-	char *rec_script_path =3D NULL;
-	char *rep_script_path =3D NULL;
 	struct perf_session *session;
 	struct itrace_synth_opts itrace_synth_opts =3D {
 		.set =3D false,
 		.default_no_sample =3D true,
 	};
-	char *script_path =3D NULL;
 	const char *dlfilter_file =3D NULL;
 	const char **__argv;
 	int i, j, err =3D 0;
@@ -4147,11 +4226,10 @@ int cmd_script(int argc, const char **argv)
 			   list_available_scripts),
 	OPT_CALLBACK_NOOPT(0, "list-dlfilters", NULL, NULL, "list available dlfil=
ters",
 			   list_available_dlfilters),
-	OPT_CALLBACK('s', "script", NULL, "name",
-		     "script file name (lang:script name, script name, or *)",
-		     parse_scriptname),
-	OPT_STRING('g', "gen-script", &generate_script_lang, "lang",
-		   "generate perf-script.xx script in specified language"),
+	{ .type =3D OPTION_CALLBACK, .short_name =3D 's', .long_name =3D "script"=
,
+	  .value =3D NULL, .argh =3D "name",
+	  .help =3D "script file name (lang:script name, script name, or *)",
+	  .callback =3D parse_scriptname, .flags =3D PARSE_OPT_HIDDEN },
 	OPT_STRING(0, "dlfilter", &dlfilter_file, "file", "filter .so file name")=
,
 	OPT_CALLBACK(0, "dlarg", NULL, "argument", "filter argument",
 		     add_dlarg),
@@ -4180,8 +4258,6 @@ int cmd_script(int argc, const char **argv)
 		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup,retire_lat,"
 		     "brcntr",
 		     parse_output_fields),
-	OPT_BOOLEAN('a', "all-cpus", &system_wide,
-		    "system-wide collection from all CPUs"),
 	OPT_STRING(0, "dsos", &symbol_conf.dso_list_str, "dso[,dso...]",
 		   "only consider symbols in these DSOs"),
 	OPT_STRING('S', "symbols", &symbol_conf.sym_list_str, "symbol[,symbol...]=
",
@@ -4244,7 +4320,7 @@ int cmd_script(int argc, const char **argv)
 		    "Use 9 decimal places when displaying time"),
 	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
 			    "Instruction Tracing options\n" ITRACE_HELP,
-			    itrace_parse_synth_opts),
+			    parse_script_itrace),
 	OPT_BOOLEAN(0, "full-source-path", &srcline_full_filename,
 			"Show full source file name path for source lines"),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
@@ -4278,22 +4354,16 @@ int cmd_script(int argc, const char **argv)
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
-	const char * const script_subcommands[] =3D { "record", "report", NULL };
 	const char *script_usage[] =3D {
 		"perf script [<options>]",
-		"perf script [<options>] record <script> [<record-options>] <command>",
-		"perf script [<options>] report <script> [script-args]",
-		"perf script [<options>] <script> [<record-options>] <command>",
-		"perf script [<options>] <top-script> [script-args]",
+		"perf script [<options>] <script> [script-args]",
 		NULL
 	};
 	struct perf_env *env;
=20
 	perf_set_singlethreaded();
=20
-	setup_scripting();
-
-	argc =3D parse_options_subcommand(argc, argv, options, script_subcommands=
, script_usage,
+	argc =3D parse_options_subcommand(argc, argv, options, NULL, script_usage=
,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
 	if (symbol_conf.guestmount ||
@@ -4316,22 +4386,6 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__validate_sym_arguments())
 		return -1;
=20
-	if (argc > 1 && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		rec_script_path =3D get_script_path(argv[1], RECORD_SUFFIX);
-		if (!rec_script_path)
-			return cmd_record(argc, argv);
-	}
-
-	if (argc > 1 && strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
-		rep_script_path =3D get_script_path(argv[1], REPORT_SUFFIX);
-		if (!rep_script_path) {
-			fprintf(stderr,
-				"Please specify a valid report script"
-				"(see 'perf script -l' for listing)\n");
-			return -1;
-		}
-	}
-
 	if (reltime && deltatime) {
 		fprintf(stderr,
 			"reltime and deltatime - the two don't get along well. "
@@ -4346,149 +4400,194 @@ int cmd_script(int argc, const char **argv)
 	/* make sure PERF_EXEC_PATH is set for scripts */
 	set_argv_exec_path(get_argv_exec_path());
=20
-	if (argc && !script_name && !rec_script_path && !rep_script_path) {
-		int live_pipe[2];
-		int rep_args;
-		pid_t pid;
-
-		rec_script_path =3D get_script_path(argv[0], RECORD_SUFFIX);
-		rep_script_path =3D get_script_path(argv[0], REPORT_SUFFIX);
-
-		if (!rec_script_path && !rep_script_path) {
-			script_name =3D find_script(argv[0]);
-			if (script_name) {
+	if (argc && !script_name) {
+		if (!strcmp(argv[0], "record") || !strcmp(argv[0], "report")) {
+			fprintf(stderr,
+				"The '%s' subcommand is no longer supported.\n",
+				argv[0]);
+			fprintf(stderr,
+				"Run 'perf script <script> [args]' directly.\n");
+			err =3D -1;
+			goto out;
+		}
+		script_name =3D find_script(argv[0]);
+		if (script_name) {
+			argc -=3D 1;
+			argv +=3D 1;
+			if (argc && !strcmp(argv[0], "--")) {
 				argc -=3D 1;
 				argv +=3D 1;
-				goto script_found;
 			}
-			usage_with_options_msg(script_usage, options,
-				"Couldn't find script `%s'\n\n See perf"
-				" script -l for available scripts.\n", argv[0]);
+			goto script_found;
 		}
+		usage_with_options_msg(script_usage, options,
+			"Couldn't find script `%s'\n\n"
+			" See perf script -l for available scripts.\n", argv[0]);
+	}
+script_found:
=20
-		if (is_top_script(argv[0])) {
-			rep_args =3D argc - 1;
-		} else {
-			int rec_args;
-
-			rep_args =3D has_required_arg(rep_script_path);
-			rec_args =3D (argc - 1) - rep_args;
-			if (rec_args < 0) {
-				usage_with_options_msg(script_usage, options,
-					"`%s' script requires options."
-					"\n\n See perf script -l for available "
-					"scripts and options.\n", argv[0]);
-			}
-		}
+	if (script_name) {
+		pid_t pid;
+		bool is_python =3D str_ends_with(script_name, ".py");
+		struct sigaction forward_sa =3D {
+			.sa_sigaction =3D forward_script_sig,
+			.sa_flags =3D SA_SIGINFO,
+		};
+		struct sigaction old_int, old_quit, old_term;
+		sigset_t block_mask, old_mask;
=20
-		if (pipe(live_pipe) < 0) {
-			perror("failed to create pipe");
-			return -1;
+		if (is_python && is_legacy_python_script(script_name)) {
+			pr_err("Error: '%s' uses the removed legacy embedded Python scripting A=
PI.\n"
+			       "Please port it to a standalone script using 'import perf' (see =
'man perf-script-python').\n",
+			       script_name);
+			err =3D -EINVAL;
+			goto out;
 		}
=20
+		if (cpu_list || symbol_conf.comm_list_str ||
+		    symbol_conf.pid_list_str || symbol_conf.tid_list_str ||
+		    script.time_str || dlfilter_file || dlargc > 0) {
+			pr_warning("Warning: Filtering options (-C, -c, --pid, --tid, --time, -=
-dlfilter, --dlarg) are ignored for standalone scripts.\n");
+		}
+		/*
+		 * Install forward_script_sig for SIGINT, SIGQUIT, and SIGTERM
+		 * in the parent `perf` process while waiting for the child
+		 * script, and restore the original handlers and signal mask in
+		 * the child before execvp(). When the user presses Ctrl-C
+		 * during a live trace, the terminal delivers SIGINT (SI_KERNEL)
+		 * to the entire foreground process group; ignoring SI_KERNEL in
+		 * the parent prevents `perf` from terminating immediately and
+		 * allows the child Python script to catch KeyboardInterrupt,
+		 * print its summary/report, and finish cleanup before exiting.
+		 * When a signal is sent directly to `perf` via kill(2) (e.g.
+		 * from a backgrounded job in a non-interactive shell), si_code
+		 * is <=3D 0 (SI_USER) and forward_script_sig forwards it to the
+		 * child script.
+		 */
+		sigemptyset(&forward_sa.sa_mask);
+		sigemptyset(&block_mask);
+		sigaddset(&block_mask, SIGINT);
+		sigaddset(&block_mask, SIGQUIT);
+		sigaddset(&block_mask, SIGTERM);
+		sigprocmask(SIG_BLOCK, &block_mask, &old_mask);
+		sigaction(SIGINT, &forward_sa, &old_int);
+		sigaction(SIGQUIT, &forward_sa, &old_quit);
+		sigaction(SIGTERM, &forward_sa, &old_term);
 		pid =3D fork();
 		if (pid < 0) {
-			perror("failed to fork");
-			return -1;
+			err =3D -errno;
+			sigaction(SIGINT, &old_int, NULL);
+			sigaction(SIGQUIT, &old_quit, NULL);
+			sigaction(SIGTERM, &old_term, NULL);
+			sigprocmask(SIG_SETMASK, &old_mask, NULL);
+			pr_err("failed to fork\n");
+			goto out;
 		}
-
-		if (!pid) {
+		if (pid =3D=3D 0) { /* child */
+			sigaction(SIGINT, &old_int, NULL);
+			sigaction(SIGQUIT, &old_quit, NULL);
+			sigaction(SIGTERM, &old_term, NULL);
+			sigprocmask(SIG_SETMASK, &old_mask, NULL);
+			__argv =3D calloc(argc + 6, sizeof(const char *));
 			j =3D 0;
+			if (!__argv)
+				_exit(127);
=20
-			dup2(live_pipe[1], 1);
-			close(live_pipe[0]);
+			if (is_python) {
+				const char *python =3D getenv("PYTHON");
=20
-			if (is_top_script(argv[0])) {
-				system_wide =3D true;
-			} else if (!system_wide) {
-				if (have_cmd(argc - rep_args, &argv[rep_args]) !=3D 0) {
-					err =3D -1;
-					goto out;
-				}
+				if (!python || !*python)
+					python =3D "python3";
+				__argv[j++] =3D python;
+				__argv[j++] =3D "--";
+				__argv[j++] =3D script_name;
+			} else {
+				__argv[j++] =3D script_name;
 			}
-
-			__argv =3D calloc(argc + 6, sizeof(const char *));
-			if (!__argv) {
-				pr_err("malloc failed\n");
-				err =3D -ENOMEM;
-				goto out;
+			if (input_name) {
+				__argv[j++] =3D "-i";
+				__argv[j++] =3D input_name;
+			} else {
+				struct stat st;
+				bool has_input_arg =3D false;
+
+				for (i =3D 0; i < argc; i++) {
+					if (!strcmp(argv[i], "-i") ||
+					    strstarts(argv[i], "--input")) {
+						has_input_arg =3D true;
+						break;
+					}
+				}
+				if (!has_input_arg &&
+				    fstat(STDIN_FILENO, &st) =3D=3D 0 &&
+				    S_ISFIFO(st.st_mode)) {
+					__argv[j++] =3D "-i";
+					__argv[j++] =3D "-";
+				}
 			}
-
-			__argv[j++] =3D "/bin/sh";
-			__argv[j++] =3D rec_script_path;
-			if (system_wide)
-				__argv[j++] =3D "-a";
-			__argv[j++] =3D "-q";
-			__argv[j++] =3D "-o";
-			__argv[j++] =3D "-";
-			for (i =3D rep_args + 1; i < argc; i++)
+			for (i =3D 0; i < argc; i++)
 				__argv[j++] =3D argv[i];
 			__argv[j++] =3D NULL;
=20
-			execvp("/bin/sh", (char **)__argv);
-			free(__argv);
-			exit(-1);
-		}
-
-		dup2(live_pipe[0], 0);
-		close(live_pipe[1]);
-
-		__argv =3D calloc(argc + 4, sizeof(const char *));
-		if (!__argv) {
-			pr_err("malloc failed\n");
-			err =3D -ENOMEM;
-			goto out;
-		}
+			if (symbol_conf.vmlinux_name)
+				setenv("PERF_SYMBOL_VMLINUX", symbol_conf.vmlinux_name, 1);
+			if (symbol_conf.kallsyms_name)
+				setenv("PERF_SYMBOL_KALLSYMS", symbol_conf.kallsyms_name, 1);
+			if (symbol_conf.symfs && symbol_conf.symfs[0])
+				setenv("PERF_SYMBOL_SYMFS", symbol_conf.symfs, 1);
+			if (script_itrace_opts)
+				setenv("PERF_ITRACE", script_itrace_opts, 1);
+
+			execvp(__argv[0], (char **)__argv);
+			{
+				int err_code =3D errno;
+
+				pr_err("failed to execute script '%s': %s\n",
+				       script_name, strerror(err_code));
+				_exit(err_code);
+			}
+		} else { /* parent */
+			siginfo_t info;
+			int status =3D 0;
=20
-		j =3D 0;
-		__argv[j++] =3D "/bin/sh";
-		__argv[j++] =3D rep_script_path;
-		for (i =3D 1; i < rep_args + 1; i++)
-			__argv[j++] =3D argv[i];
-		__argv[j++] =3D "-i";
-		__argv[j++] =3D "-";
-		__argv[j++] =3D NULL;
-
-		execvp("/bin/sh", (char **)__argv);
-		free(__argv);
-		exit(-1);
-	}
-script_found:
-	if (rec_script_path)
-		script_path =3D rec_script_path;
-	if (rep_script_path)
-		script_path =3D rep_script_path;
-
-	if (script_path) {
-		j =3D 0;
-
-		if (!rec_script_path)
-			system_wide =3D false;
-		else if (!system_wide) {
-			if (have_cmd(argc - 1, &argv[1]) !=3D 0) {
-				err =3D -1;
+			script_child_pid =3D pid;
+			sigprocmask(SIG_SETMASK, &old_mask, NULL);
+			/*
+			 * Wait with WNOWAIT first so the child remains a
+			 * zombie (preventing PID reuse by the kernel) until
+			 * script_child_pid is cleared and signal handlers are
+			 * restored, then reap the zombie with waitpid().
+			 */
+			while (waitid(P_PID, pid, &info, WEXITED | WNOWAIT) < 0) {
+				if (errno =3D=3D EINTR)
+					continue;
+				pr_err("failed to wait for script '%s': %s\n",
+				       script_name, strerror(errno));
+				err =3D -errno;
+				script_child_pid =3D 0;
+				sigaction(SIGINT, &old_int, NULL);
+				sigaction(SIGQUIT, &old_quit, NULL);
+				sigaction(SIGTERM, &old_term, NULL);
 				goto out;
 			}
-		}
-
-		__argv =3D calloc(argc + 2, sizeof(const char *));
-		if (!__argv) {
-			pr_err("malloc failed\n");
-			err =3D -ENOMEM;
+			script_child_pid =3D 0;
+			sigaction(SIGINT, &old_int, NULL);
+			sigaction(SIGQUIT, &old_quit, NULL);
+			sigaction(SIGTERM, &old_term, NULL);
+			while (waitpid(pid, &status, 0) !=3D pid) {
+				if (errno =3D=3D EINTR)
+					continue;
+				err =3D -errno;
+				goto out;
+			}
+			if (WIFEXITED(status))
+				err =3D WEXITSTATUS(status);
+			else if (WIFSIGNALED(status))
+				err =3D 128 + WTERMSIG(status);
+			else
+				err =3D -1;
 			goto out;
 		}
-
-		__argv[j++] =3D "/bin/sh";
-		__argv[j++] =3D script_path;
-		if (system_wide)
-			__argv[j++] =3D "-a";
-		for (i =3D 2; i < argc; i++)
-			__argv[j++] =3D argv[i];
-		__argv[j++] =3D NULL;
-
-		execvp("/bin/sh", (char **)__argv);
-		free(__argv);
-		exit(-1);
 	}
=20
 	if (dlfilter_file) {
@@ -4580,79 +4679,11 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 	}
 #endif
-	if (generate_script_lang) {
-		struct stat perf_stat;
-		int input;
-		char *filename =3D strdup("perf-script");
-
-		if (output_set_by_user()) {
-			fprintf(stderr,
-				"custom fields not supported for generated scripts");
-			err =3D -EINVAL;
-			goto out_delete;
-		}
-
-		input =3D open(data.path, O_RDONLY);	/* input_name */
-		if (input < 0) {
-			err =3D -errno;
-			perror("failed to open file");
-			goto out_delete;
-		}
-
-		err =3D fstat(input, &perf_stat);
-		if (err < 0) {
-			perror("failed to stat file");
-			goto out_delete;
-		}
-
-		if (!perf_stat.st_size) {
-			fprintf(stderr, "zero-sized file, nothing to do!\n");
-			goto out_delete;
-		}
-
-		scripting_ops =3D script_spec__lookup(generate_script_lang);
-		if (!scripting_ops && ends_with(generate_script_lang, ".py")) {
-			scripting_ops =3D script_spec__lookup("python");
-			free(filename);
-			filename =3D strdup(generate_script_lang);
-			filename[strlen(filename) - 3] =3D '\0';
-		} else if (!scripting_ops && ends_with(generate_script_lang, ".pl")) {
-			scripting_ops =3D script_spec__lookup("perl");
-			free(filename);
-			filename =3D strdup(generate_script_lang);
-			filename[strlen(filename) - 3] =3D '\0';
-		}
-		if (!scripting_ops) {
-			fprintf(stderr, "invalid language specifier '%s'\n", generate_script_la=
ng);
-			err =3D -ENOENT;
-			goto out_delete;
-		}
-		if (!filename) {
-			err =3D -ENOMEM;
-			goto out_delete;
-		}
-#ifdef HAVE_LIBTRACEEVENT
-		err =3D scripting_ops->generate_script(session->tevent.pevent, filename)=
;
-#else
-		err =3D scripting_ops->generate_script(NULL, filename);
-#endif
-		free(filename);
-		goto out_delete;
-	}
=20
 	err =3D dlfilter__start(dlfilter, session);
 	if (err)
 		goto out_delete;
=20
-	if (script_name) {
-		err =3D scripting_ops->start_script(script_name, argc, argv, session);
-		if (err)
-			goto out_delete;
-		pr_debug("perf script started with script %s\n\n", script_name);
-		script_started =3D true;
-	}
-
-
 	err =3D perf_session__check_output_opt(session);
 	if (err < 0)
 		goto out_delete;
@@ -4680,8 +4711,6 @@ int cmd_script(int argc, const char **argv)
=20
 	err =3D __cmd_script(&script);
=20
-	flush_scripting();
-
 	if (verbose > 2 || debug_kmaps)
 		perf_session__dump_kmaps(session);
=20
@@ -4696,10 +4725,9 @@ int cmd_script(int argc, const char **argv)
 	perf_session__delete(session);
 	perf_script__exit(&script);
=20
-	if (script_started)
-		cleanup_scripting();
+out:
+	zfree(&script_name);
 	dlfilter__cleanup(dlfilter);
 	free_dlarg();
-out:
 	return err;
 }
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
deleted file mode 100644
index fbeab8fff88b..000000000000
--- a/tools/perf/scripts/Build
+++ /dev/null
@@ -1,3 +0,0 @@
-ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-util-$(CONFIG_LIBPERL)   +=3D perl/Perf-Trace-Util/
-endif
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Build b/tools/perf/scr=
ipts/perl/Perf-Trace-Util/Build
deleted file mode 100644
index 01a1a0ed51ae..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Build
+++ /dev/null
@@ -1,9 +0,0 @@
-perf-util-y +=3D Context.o
-
-CFLAGS_Context.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-stric=
t-prototypes -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-s=
witch-enum
-CFLAGS_Context.o +=3D -Wno-unused-parameter -Wno-nested-externs -Wno-undef
-CFLAGS_Context.o +=3D -Wno-switch-default -Wno-shadow -Wno-thread-safety-a=
nalysis
-
-ifeq ($(CC_NO_CLANG), 1)
-  CFLAGS_Context.o +=3D -Wno-unused-command-line-argument
-endif
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Context.c b/tools/perf=
/scripts/perl/Perf-Trace-Util/Context.c
deleted file mode 100644
index 25c47d23a130..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Context.c
+++ /dev/null
@@ -1,122 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * This file was generated automatically by ExtUtils::ParseXS version 2.18=
_02 from the
- * contents of Context.xs. Do not edit this file, edit Context.xs instead.
- *
- *	ANY CHANGES MADE HERE WILL BE LOST!=20
- */
-#include <stdbool.h>
-#ifndef HAS_BOOL
-# define HAS_BOOL 1
-#endif
-#line 1 "Context.xs"
-/*
- * Context.xs.  XS interfaces for perf script.
- *
- * Copyright (C) 2009 Tom Zanussi <tzanussi@gmail.com>
- */
-
-#include "EXTERN.h"
-#include "perl.h"
-#include "XSUB.h"
-#include "../../../util/trace-event.h"
-
-#ifndef PERL_UNUSED_VAR
-#  define PERL_UNUSED_VAR(var) if (0) var =3D var
-#endif
-
-#line 42 "Context.c"
-
-XS(XS_Perf__Trace__Context_common_pc); /* prototype to pass -Wmissing-prot=
otypes */
-XS(XS_Perf__Trace__Context_common_pc)
-{
-#ifdef dVAR
-    dVAR; dXSARGS;
-#else
-    dXSARGS;
-#endif
-    if (items !=3D 1)
-       Perl_croak(aTHX_ "Usage: %s(%s)", "Perf::Trace::Context::common_pc"=
, "context");
-    PERL_UNUSED_VAR(cv); /* -W */
-    {
-	struct scripting_context *	context =3D INT2PTR(struct scripting_context *=
,SvIV(ST(0)));
-	int	RETVAL;
-	dXSTARG;
-
-	RETVAL =3D common_pc(context);
-	XSprePUSH; PUSHi((IV)RETVAL);
-    }
-    XSRETURN(1);
-}
-
-
-XS(XS_Perf__Trace__Context_common_flags); /* prototype to pass -Wmissing-p=
rototypes */
-XS(XS_Perf__Trace__Context_common_flags)
-{
-#ifdef dVAR
-    dVAR; dXSARGS;
-#else
-    dXSARGS;
-#endif
-    if (items !=3D 1)
-       Perl_croak(aTHX_ "Usage: %s(%s)", "Perf::Trace::Context::common_fla=
gs", "context");
-    PERL_UNUSED_VAR(cv); /* -W */
-    {
-	struct scripting_context *	context =3D INT2PTR(struct scripting_context *=
,SvIV(ST(0)));
-	int	RETVAL;
-	dXSTARG;
-
-	RETVAL =3D common_flags(context);
-	XSprePUSH; PUSHi((IV)RETVAL);
-    }
-    XSRETURN(1);
-}
-
-
-XS(XS_Perf__Trace__Context_common_lock_depth); /* prototype to pass -Wmiss=
ing-prototypes */
-XS(XS_Perf__Trace__Context_common_lock_depth)
-{
-#ifdef dVAR
-    dVAR; dXSARGS;
-#else
-    dXSARGS;
-#endif
-    if (items !=3D 1)
-       Perl_croak(aTHX_ "Usage: %s(%s)", "Perf::Trace::Context::common_loc=
k_depth", "context");
-    PERL_UNUSED_VAR(cv); /* -W */
-    {
-	struct scripting_context *	context =3D INT2PTR(struct scripting_context *=
,SvIV(ST(0)));
-	int	RETVAL;
-	dXSTARG;
-
-	RETVAL =3D common_lock_depth(context);
-	XSprePUSH; PUSHi((IV)RETVAL);
-    }
-    XSRETURN(1);
-}
-
-#ifdef __cplusplus
-extern "C"
-#endif
-XS(boot_Perf__Trace__Context); /* prototype to pass -Wmissing-prototypes *=
/
-XS(boot_Perf__Trace__Context)
-{
-#ifdef dVAR
-    dVAR; dXSARGS;
-#else
-    dXSARGS;
-#endif
-    const char* file =3D __FILE__;
-
-    PERL_UNUSED_VAR(cv); /* -W */
-    PERL_UNUSED_VAR(items); /* -W */
-    XS_VERSION_BOOTCHECK ;
-
-        newXSproto("Perf::Trace::Context::common_pc", XS_Perf__Trace__Cont=
ext_common_pc, file, "$");
-        newXSproto("Perf::Trace::Context::common_flags", XS_Perf__Trace__C=
ontext_common_flags, file, "$");
-        newXSproto("Perf::Trace::Context::common_lock_depth", XS_Perf__Tra=
ce__Context_common_lock_depth, file, "$");
-    if (PL_unitcheckav)
-         call_list(PL_scopestack_ix, PL_unitcheckav);
-    XSRETURN_YES;
-}
-
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Context.xs b/tools/per=
f/scripts/perl/Perf-Trace-Util/Context.xs
deleted file mode 100644
index 8c7ea42444d1..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Context.xs
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Context.xs.  XS interfaces for perf script.
- *
- * Copyright (C) 2009 Tom Zanussi <tzanussi@gmail.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
- *
- */
-
-#include "EXTERN.h"
-#include "perl.h"
-#include "XSUB.h"
-#include "../../../perf.h"
-#include "../../../util/trace-event.h"
-
-MODULE =3D Perf::Trace::Context		PACKAGE =3D Perf::Trace::Context
-PROTOTYPES: ENABLE
-
-int
-common_pc(context)
-	struct scripting_context * context
-
-int
-common_flags(context)
-	struct scripting_context * context
-
-int
-common_lock_depth(context)
-	struct scripting_context * context
-
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Makefile.PL b/tools/pe=
rf/scripts/perl/Perf-Trace-Util/Makefile.PL
deleted file mode 100644
index e8994332d7dc..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Makefile.PL
+++ /dev/null
@@ -1,18 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-use 5.010000;
-use ExtUtils::MakeMaker;
-# See lib/ExtUtils/MakeMaker.pm for details of how to influence
-# the contents of the Makefile that is written.
-WriteMakefile(
-    NAME              =3D> 'Perf::Trace::Context',
-    VERSION_FROM      =3D> 'lib/Perf/Trace/Context.pm', # finds $VERSION
-    PREREQ_PM         =3D> {}, # e.g., Module::Name =3D> 1.1
-    ($] >=3D 5.005 ?     ## Add these new keywords supported since 5.005
-      (ABSTRACT_FROM  =3D> 'lib/Perf/Trace/Context.pm', # retrieve abstrac=
t from module
-       AUTHOR         =3D> 'Tom Zanussi <tzanussi@gmail.com>') : ()),
-    LIBS              =3D> [''], # e.g., '-lm'
-    DEFINE            =3D> '-I ../..', # e.g., '-DHAVE_SOMETHING'
-    INC               =3D> '-I.', # e.g., '-I. -I/usr/include/other'
-	# Un-comment this if you add C files to link with later:
-    OBJECT            =3D> 'Context.o', # link all the C files too
-);
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/README b/tools/perf/sc=
ripts/perl/Perf-Trace-Util/README
deleted file mode 100644
index 2f0c7f3043ee..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/README
+++ /dev/null
@@ -1,59 +0,0 @@
-Perf-Trace-Util version 0.01
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
-This module contains utility functions for use with perf script.
-
-Core.pm and Util.pm are pure Perl modules; Core.pm contains routines
-that the core perf support for Perl calls on and should always be
-'used', while Util.pm contains useful but optional utility functions
-that scripts may want to use.  Context.pm contains the Perl->C
-interface that allows scripts to access data in the embedding perf
-executable; scripts wishing to do that should 'use Context.pm'.
-
-The Perl->C perf interface is completely driven by Context.xs.  If you
-want to add new Perl functions that end up accessing C data in the
-perf executable, you add desciptions of the new functions here.
-scripting_context is a pointer to the perf data in the perf executable
-that you want to access - it's passed as the second parameter,
-$context, to all handler functions.
-
-After you do that:
-
-  perl Makefile.PL   # to create a Makefile for the next step
-  make               # to create Context.c
-
-  edit Context.c to add const to the char* file =3D __FILE__ line in
-  XS(boot_Perf__Trace__Context) to silence a warning/error.
-
-  You can delete the Makefile, object files and anything else that was
-  generated e.g. blib and shared library, etc, except for of course
-  Context.c
-
-  You should then be able to run the normal perf make as usual.
-
-INSTALLATION
-
-Building perf with perf script Perl scripting should install this
-module in the right place.
-
-You should make sure libperl and ExtUtils/Embed.pm are installed first
-e.g. apt-get install libperl-dev or yum install perl-ExtUtils-Embed.
-
-DEPENDENCIES
-
-This module requires these other modules and libraries:
-
-  None
-
-COPYRIGHT AND LICENCE
-
-Copyright (C) 2009 by Tom Zanussi <tzanussi@gmail.com>
-
-This library is free software; you can redistribute it and/or modify
-it under the same terms as Perl itself, either Perl version 5.10.0 or,
-at your option, any later version of Perl 5 you may have available.
-
-Alternatively, this software may be distributed under the terms of the
-GNU General Public License ("GPL") version 2 as published by the Free
-Software Foundation.
-
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Context=
.pm b/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Context.pm
deleted file mode 100644
index 4e2f6039ac92..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Context.pm
+++ /dev/null
@@ -1,55 +0,0 @@
-package Perf::Trace::Context;
-
-use 5.010000;
-use strict;
-use warnings;
-
-require Exporter;
-
-our @ISA =3D qw(Exporter);
-
-our %EXPORT_TAGS =3D ( 'all' =3D> [ qw(
-) ] );
-
-our @EXPORT_OK =3D ( @{ $EXPORT_TAGS{'all'} } );
-
-our @EXPORT =3D qw(
-	common_pc common_flags common_lock_depth
-);
-
-our $VERSION =3D '0.01';
-
-require XSLoader;
-XSLoader::load('Perf::Trace::Context', $VERSION);
-
-1;
-__END__
-=3Dhead1 NAME
-
-Perf::Trace::Context - Perl extension for accessing functions in perf.
-
-=3Dhead1 SYNOPSIS
-
-  use Perf::Trace::Context;
-
-=3Dhead1 SEE ALSO
-
-Perf (script) documentation
-
-=3Dhead1 AUTHOR
-
-Tom Zanussi, E<lt>tzanussi@gmail.com<gt>
-
-=3Dhead1 COPYRIGHT AND LICENSE
-
-Copyright (C) 2009 by Tom Zanussi
-
-This library is free software; you can redistribute it and/or modify
-it under the same terms as Perl itself, either Perl version 5.10.0 or,
-at your option, any later version of Perl 5 you may have available.
-
-Alternatively, this software may be distributed under the terms of the
-GNU General Public License ("GPL") version 2 as published by the Free
-Software Foundation.
-
-=3Dcut
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm=
 b/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm
deleted file mode 100644
index 9158458d3eeb..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm
+++ /dev/null
@@ -1,192 +0,0 @@
-package Perf::Trace::Core;
-
-use 5.010000;
-use strict;
-use warnings;
-
-require Exporter;
-
-our @ISA =3D qw(Exporter);
-
-our %EXPORT_TAGS =3D ( 'all' =3D> [ qw(
-) ] );
-
-our @EXPORT_OK =3D ( @{ $EXPORT_TAGS{'all'} } );
-
-our @EXPORT =3D qw(
-define_flag_field define_flag_value flag_str dump_flag_fields
-define_symbolic_field define_symbolic_value symbol_str dump_symbolic_field=
s
-trace_flag_str
-);
-
-our $VERSION =3D '0.01';
-
-my %trace_flags =3D (0x00 =3D> "NONE",
-		   0x01 =3D> "IRQS_OFF",
-		   0x02 =3D> "IRQS_NOSUPPORT",
-		   0x04 =3D> "NEED_RESCHED",
-		   0x08 =3D> "HARDIRQ",
-		   0x10 =3D> "SOFTIRQ");
-
-sub trace_flag_str
-{
-    my ($value) =3D @_;
-
-    my $string;
-
-    my $print_delim =3D 0;
-
-    foreach my $idx (sort {$a <=3D> $b} keys %trace_flags) {
-	if (!$value && !$idx) {
-	    $string .=3D "NONE";
-	    last;
-	}
-
-	if ($idx && ($value & $idx) =3D=3D $idx) {
-	    if ($print_delim) {
-		$string .=3D " | ";
-	    }
-	    $string .=3D "$trace_flags{$idx}";
-	    $print_delim =3D 1;
-	    $value &=3D ~$idx;
-	}
-    }
-
-    return $string;
-}
-
-my %flag_fields;
-my %symbolic_fields;
-
-sub flag_str
-{
-    my ($event_name, $field_name, $value) =3D @_;
-
-    my $string;
-
-    if ($flag_fields{$event_name}{$field_name}) {
-	my $print_delim =3D 0;
-	foreach my $idx (sort {$a <=3D> $b} keys %{$flag_fields{$event_name}{$fie=
ld_name}{"values"}}) {
-	    if (!$value && !$idx) {
-		$string .=3D "$flag_fields{$event_name}{$field_name}{'values'}{$idx}";
-		last;
-	    }
-	    if ($idx && ($value & $idx) =3D=3D $idx) {
-		if ($print_delim && $flag_fields{$event_name}{$field_name}{'delim'}) {
-		    $string .=3D " $flag_fields{$event_name}{$field_name}{'delim'} ";
-		}
-		$string .=3D "$flag_fields{$event_name}{$field_name}{'values'}{$idx}";
-		$print_delim =3D 1;
-		$value &=3D ~$idx;
-	    }
-	}
-    }
-
-    return $string;
-}
-
-sub define_flag_field
-{
-    my ($event_name, $field_name, $delim) =3D @_;
-
-    $flag_fields{$event_name}{$field_name}{"delim"} =3D $delim;
-}
-
-sub define_flag_value
-{
-    my ($event_name, $field_name, $value, $field_str) =3D @_;
-
-    $flag_fields{$event_name}{$field_name}{"values"}{$value} =3D $field_st=
r;
-}
-
-sub dump_flag_fields
-{
-    for my $event (keys %flag_fields) {
-	print "event $event:\n";
-	for my $field (keys %{$flag_fields{$event}}) {
-	    print "    field: $field:\n";
-	    print "        delim: $flag_fields{$event}{$field}{'delim'}\n";
-	    foreach my $idx (sort {$a <=3D> $b} keys %{$flag_fields{$event}{$fiel=
d}{"values"}}) {
-		print "        value $idx: $flag_fields{$event}{$field}{'values'}{$idx}\=
n";
-	    }
-	}
-    }
-}
-
-sub symbol_str
-{
-    my ($event_name, $field_name, $value) =3D @_;
-
-    if ($symbolic_fields{$event_name}{$field_name}) {
-	foreach my $idx (sort {$a <=3D> $b} keys %{$symbolic_fields{$event_name}{=
$field_name}{"values"}}) {
-	    if (!$value && !$idx) {
-		return "$symbolic_fields{$event_name}{$field_name}{'values'}{$idx}";
-		last;
-	    }
-	    if ($value =3D=3D $idx) {
-		return "$symbolic_fields{$event_name}{$field_name}{'values'}{$idx}";
-	    }
-	}
-    }
-
-    return undef;
-}
-
-sub define_symbolic_field
-{
-    my ($event_name, $field_name) =3D @_;
-
-    # nothing to do, really
-}
-
-sub define_symbolic_value
-{
-    my ($event_name, $field_name, $value, $field_str) =3D @_;
-
-    $symbolic_fields{$event_name}{$field_name}{"values"}{$value} =3D $fiel=
d_str;
-}
-
-sub dump_symbolic_fields
-{
-    for my $event (keys %symbolic_fields) {
-	print "event $event:\n";
-	for my $field (keys %{$symbolic_fields{$event}}) {
-	    print "    field: $field:\n";
-	    foreach my $idx (sort {$a <=3D> $b} keys %{$symbolic_fields{$event}{$=
field}{"values"}}) {
-		print "        value $idx: $symbolic_fields{$event}{$field}{'values'}{$i=
dx}\n";
-	    }
-	}
-    }
-}
-
-1;
-__END__
-=3Dhead1 NAME
-
-Perf::Trace::Core - Perl extension for perf script
-
-=3Dhead1 SYNOPSIS
-
-  use Perf::Trace::Core
-
-=3Dhead1 SEE ALSO
-
-Perf (script) documentation
-
-=3Dhead1 AUTHOR
-
-Tom Zanussi, E<lt>tzanussi@gmail.com<gt>
-
-=3Dhead1 COPYRIGHT AND LICENSE
-
-Copyright (C) 2009 by Tom Zanussi
-
-This library is free software; you can redistribute it and/or modify
-it under the same terms as Perl itself, either Perl version 5.10.0 or,
-at your option, any later version of Perl 5 you may have available.
-
-Alternatively, this software may be distributed under the terms of the
-GNU General Public License ("GPL") version 2 as published by the Free
-Software Foundation.
-
-=3Dcut
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm=
 b/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm
deleted file mode 100644
index 053500114625..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm
+++ /dev/null
@@ -1,94 +0,0 @@
-package Perf::Trace::Util;
-
-use 5.010000;
-use strict;
-use warnings;
-
-require Exporter;
-
-our @ISA =3D qw(Exporter);
-
-our %EXPORT_TAGS =3D ( 'all' =3D> [ qw(
-) ] );
-
-our @EXPORT_OK =3D ( @{ $EXPORT_TAGS{'all'} } );
-
-our @EXPORT =3D qw(
-avg nsecs nsecs_secs nsecs_nsecs nsecs_usecs print_nsecs
-clear_term
-);
-
-our $VERSION =3D '0.01';
-
-sub avg
-{
-    my ($total, $n) =3D @_;
-
-    return $total / $n;
-}
-
-my $NSECS_PER_SEC    =3D 1000000000;
-
-sub nsecs
-{
-    my ($secs, $nsecs) =3D @_;
-
-    return $secs * $NSECS_PER_SEC + $nsecs;
-}
-
-sub nsecs_secs {
-    my ($nsecs) =3D @_;
-
-    return $nsecs / $NSECS_PER_SEC;
-}
-
-sub nsecs_nsecs {
-    my ($nsecs) =3D @_;
-
-    return $nsecs % $NSECS_PER_SEC;
-}
-
-sub nsecs_str {
-    my ($nsecs) =3D @_;
-
-    my $str =3D sprintf("%5u.%09u", nsecs_secs($nsecs), nsecs_nsecs($nsecs=
));
-
-    return $str;
-}
-
-sub clear_term
-{
-    print "\x1b[H\x1b[2J";
-}
-
-1;
-__END__
-=3Dhead1 NAME
-
-Perf::Trace::Util - Perl extension for perf script
-
-=3Dhead1 SYNOPSIS
-
-  use Perf::Trace::Util;
-
-=3Dhead1 SEE ALSO
-
-Perf (script) documentation
-
-=3Dhead1 AUTHOR
-
-Tom Zanussi, E<lt>tzanussi@gmail.com<gt>
-
-=3Dhead1 COPYRIGHT AND LICENSE
-
-Copyright (C) 2009 by Tom Zanussi
-
-This library is free software; you can redistribute it and/or modify
-it under the same terms as Perl itself, either Perl version 5.10.0 or,
-at your option, any later version of Perl 5 you may have available.
-
-Alternatively, this software may be distributed under the terms of the
-GNU General Public License ("GPL") version 2 as published by the Free
-Software Foundation.
-
-=3Dcut
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/typemap b/tools/perf/s=
cripts/perl/Perf-Trace-Util/typemap
deleted file mode 100644
index 840836804aa7..000000000000
--- a/tools/perf/scripts/perl/Perf-Trace-Util/typemap
+++ /dev/null
@@ -1 +0,0 @@
-struct scripting_context * T_PTR
diff --git a/tools/perf/scripts/perl/bin/check-perf-trace-record b/tools/pe=
rf/scripts/perl/bin/check-perf-trace-record
deleted file mode 100644
index 423ad6aed056..000000000000
--- a/tools/perf/scripts/perl/bin/check-perf-trace-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -a -e kmem:kmalloc -e irq:softirq_entry -e kmem:kfree
diff --git a/tools/perf/scripts/perl/bin/failed-syscalls-record b/tools/per=
f/scripts/perl/bin/failed-syscalls-record
deleted file mode 100644
index 74685f318379..000000000000
--- a/tools/perf/scripts/perl/bin/failed-syscalls-record
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-(perf record -e raw_syscalls:sys_exit $@ || \
- perf record -e syscalls:sys_exit $@) 2> /dev/null
diff --git a/tools/perf/scripts/perl/bin/failed-syscalls-report b/tools/per=
f/scripts/perl/bin/failed-syscalls-report
deleted file mode 100644
index 9f83cc1ad8ba..000000000000
--- a/tools/perf/scripts/perl/bin/failed-syscalls-report
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# description: system-wide failed syscalls
-# args: [comm]
-if [ $# -gt 0 ] ; then
-    if ! expr match "$1" "-" > /dev/null ; then
-	comm=3D$1
-	shift
-    fi
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/perl/failed-syscalls.pl $comm
diff --git a/tools/perf/scripts/perl/bin/rw-by-file-record b/tools/perf/scr=
ipts/perl/bin/rw-by-file-record
deleted file mode 100644
index 33efc8673aae..000000000000
--- a/tools/perf/scripts/perl/bin/rw-by-file-record
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-perf record -e syscalls:sys_enter_read -e syscalls:sys_enter_write $@
-
diff --git a/tools/perf/scripts/perl/bin/rw-by-file-report b/tools/perf/scr=
ipts/perl/bin/rw-by-file-report
deleted file mode 100644
index 77200b3f3100..000000000000
--- a/tools/perf/scripts/perl/bin/rw-by-file-report
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/bash
-# description: r/w activity for a program, by file
-# args: <comm>
-if [ $# -lt 1 ] ; then
-    echo "usage: rw-by-file <comm>"
-    exit
-fi
-comm=3D$1
-shift
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/perl/rw-by-file.pl $comm
diff --git a/tools/perf/scripts/perl/bin/rw-by-pid-record b/tools/perf/scri=
pts/perl/bin/rw-by-pid-record
deleted file mode 100644
index 7cb9db230448..000000000000
--- a/tools/perf/scripts/perl/bin/rw-by-pid-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -e syscalls:sys_enter_read -e syscalls:sys_exit_read -e syscal=
ls:sys_enter_write -e syscalls:sys_exit_write $@
diff --git a/tools/perf/scripts/perl/bin/rw-by-pid-report b/tools/perf/scri=
pts/perl/bin/rw-by-pid-report
deleted file mode 100644
index a27b9f311f95..000000000000
--- a/tools/perf/scripts/perl/bin/rw-by-pid-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: system-wide r/w activity
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/perl/rw-by-pid.pl
diff --git a/tools/perf/scripts/perl/bin/rwtop-record b/tools/perf/scripts/=
perl/bin/rwtop-record
deleted file mode 100644
index 7cb9db230448..000000000000
--- a/tools/perf/scripts/perl/bin/rwtop-record
+++ /dev/null
@@ -1,2 +0,0 @@
-#!/bin/bash
-perf record -e syscalls:sys_enter_read -e syscalls:sys_exit_read -e syscal=
ls:sys_enter_write -e syscalls:sys_exit_write $@
diff --git a/tools/perf/scripts/perl/bin/rwtop-report b/tools/perf/scripts/=
perl/bin/rwtop-report
deleted file mode 100644
index 83e11ec2e190..000000000000
--- a/tools/perf/scripts/perl/bin/rwtop-report
+++ /dev/null
@@ -1,20 +0,0 @@
-#!/bin/bash
-# description: system-wide r/w top
-# args: [interval]
-n_args=3D0
-for i in "$@"
-do
-    if expr match "$i" "-" > /dev/null ; then
-	break
-    fi
-    n_args=3D$(( $n_args + 1 ))
-done
-if [ "$n_args" -gt 1 ] ; then
-    echo "usage: rwtop-report [interval]"
-    exit
-fi
-if [ "$n_args" -gt 0 ] ; then
-    interval=3D$1
-    shift
-fi
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/perl/rwtop.pl $interval
diff --git a/tools/perf/scripts/perl/bin/wakeup-latency-record b/tools/perf=
/scripts/perl/bin/wakeup-latency-record
deleted file mode 100644
index 464251a1bd7e..000000000000
--- a/tools/perf/scripts/perl/bin/wakeup-latency-record
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-perf record -e sched:sched_switch -e sched:sched_wakeup $@
-
-
-
-
diff --git a/tools/perf/scripts/perl/bin/wakeup-latency-report b/tools/perf=
/scripts/perl/bin/wakeup-latency-report
deleted file mode 100644
index 889e8130cca5..000000000000
--- a/tools/perf/scripts/perl/bin/wakeup-latency-report
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/bash
-# description: system-wide min/max/avg wakeup latency
-perf script $@ -s "$PERF_EXEC_PATH"/scripts/perl/wakeup-latency.pl
diff --git a/tools/perf/scripts/perl/check-perf-trace.pl b/tools/perf/scrip=
ts/perl/check-perf-trace.pl
deleted file mode 100644
index d307ce8fd6ed..000000000000
--- a/tools/perf/scripts/perl/check-perf-trace.pl
+++ /dev/null
@@ -1,106 +0,0 @@
-# perf script event handlers, generated by perf script -g perl
-# (c) 2009, Tom Zanussi <tzanussi@gmail.com>
-# Licensed under the terms of the GNU GPL License version 2
-
-# This script tests basic functionality such as flag and symbol
-# strings, common_xxx() calls back into perf, begin, end, unhandled
-# events, etc.  Basically, if this script runs successfully and
-# displays expected results, perl scripting support should be ok.
-
-use lib "$ENV{'PERF_EXEC_PATH'}/scripts/perl/Perf-Trace-Util/lib";
-use lib "./Perf-Trace-Util/lib";
-use Perf::Trace::Core;
-use Perf::Trace::Context;
-use Perf::Trace::Util;
-
-sub trace_begin
-{
-    print "trace_begin\n";
-}
-
-sub trace_end
-{
-    print "trace_end\n";
-
-    print_unhandled();
-}
-
-sub irq::softirq_entry
-{
-	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm, $common_callchain,
-	    $vec) =3D @_;
-
-	print_header($event_name, $common_cpu, $common_secs, $common_nsecs,
-		     $common_pid, $common_comm);
-
-	print_uncommon($context);
-
-	printf("vec=3D%s\n",
-	       symbol_str("irq::softirq_entry", "vec", $vec));
-}
-
-sub kmem::kmalloc
-{
-	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm, $common_callchain,
-	    $call_site, $ptr, $bytes_req, $bytes_alloc,
-	    $gfp_flags) =3D @_;
-
-	print_header($event_name, $common_cpu, $common_secs, $common_nsecs,
-		     $common_pid, $common_comm);
-
-	print_uncommon($context);
-
-	printf("call_site=3D%p, ptr=3D%p, bytes_req=3D%u, bytes_alloc=3D%u, ".
-	       "gfp_flags=3D%s\n",
-	       $call_site, $ptr, $bytes_req, $bytes_alloc,
-
-	       flag_str("kmem::kmalloc", "gfp_flags", $gfp_flags));
-}
-
-# print trace fields not included in handler args
-sub print_uncommon
-{
-    my ($context) =3D @_;
-
-    printf("common_preempt_count=3D%d, common_flags=3D%s, common_lock_dept=
h=3D%d, ",
-	   common_pc($context), trace_flag_str(common_flags($context)),
-	   common_lock_depth($context));
-
-}
-
-my %unhandled;
-
-sub print_unhandled
-{
-    if ((scalar keys %unhandled) =3D=3D 0) {
-	return;
-    }
-
-    print "\nunhandled events:\n\n";
-
-    printf("%-40s  %10s\n", "event", "count");
-    printf("%-40s  %10s\n", "----------------------------------------",
-	   "-----------");
-
-    foreach my $event_name (keys %unhandled) {
-	printf("%-40s  %10d\n", $event_name, $unhandled{$event_name});
-    }
-}
-
-sub trace_unhandled
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain) =3D @_;
-
-    $unhandled{$event_name}++;
-}
-
-sub print_header
-{
-	my ($event_name, $cpu, $secs, $nsecs, $pid, $comm) =3D @_;
-
-	printf("%-20s %5u %05u.%09u %8u %-20s ",
-	       $event_name, $cpu, $secs, $nsecs, $pid, $comm);
-}
diff --git a/tools/perf/scripts/perl/failed-syscalls.pl b/tools/perf/script=
s/perl/failed-syscalls.pl
deleted file mode 100644
index 05954a8f363a..000000000000
--- a/tools/perf/scripts/perl/failed-syscalls.pl
+++ /dev/null
@@ -1,47 +0,0 @@
-# failed system call counts
-# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
-# Licensed under the terms of the GNU GPL License version 2
-#
-# Displays system-wide failed system call totals
-# If a [comm] arg is specified, only syscalls called by [comm] are display=
ed.
-
-use lib "$ENV{'PERF_EXEC_PATH'}/scripts/perl/Perf-Trace-Util/lib";
-use lib "./Perf-Trace-Util/lib";
-use Perf::Trace::Core;
-use Perf::Trace::Context;
-use Perf::Trace::Util;
-
-my $for_comm =3D shift;
-
-my %failed_syscalls;
-
-sub raw_syscalls::sys_exit
-{
-	my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	    $common_pid, $common_comm, $common_callchain,
-	    $id, $ret) =3D @_;
-
-	if ($ret < 0) {
-	    $failed_syscalls{$common_comm}++;
-	}
-}
-
-sub syscalls::sys_exit
-{
-	raw_syscalls::sys_exit(@_)
-}
-
-sub trace_end
-{
-    printf("\nfailed syscalls by comm:\n\n");
-
-    printf("%-20s  %10s\n", "comm", "# errors");
-    printf("%-20s  %6s  %10s\n", "--------------------", "----------");
-
-    foreach my $comm (sort {$failed_syscalls{$b} <=3D> $failed_syscalls{$a=
}}
-		      keys %failed_syscalls) {
-	next if ($for_comm && $comm ne $for_comm);
-
-	printf("%-20s  %10s\n", $comm, $failed_syscalls{$comm});
-    }
-}
diff --git a/tools/perf/scripts/perl/rw-by-file.pl b/tools/perf/scripts/per=
l/rw-by-file.pl
deleted file mode 100644
index 92a750b8552b..000000000000
--- a/tools/perf/scripts/perl/rw-by-file.pl
+++ /dev/null
@@ -1,106 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0-only
-# (c) 2009, Tom Zanussi <tzanussi@gmail.com>
-
-# Display r/w activity for files read/written to for a given program
-
-# The common_* event handler fields are the most useful fields common to
-# all events.  They don't necessarily correspond to the 'common_*' fields
-# in the status files.  Those fields not available as handler params can
-# be retrieved via script functions of the form get_common_*().
-
-use 5.010000;
-use strict;
-use warnings;
-
-use lib "$ENV{'PERF_EXEC_PATH'}/scripts/perl/Perf-Trace-Util/lib";
-use lib "./Perf-Trace-Util/lib";
-use Perf::Trace::Core;
-use Perf::Trace::Util;
-
-my $usage =3D "perf script -s rw-by-file.pl <comm>\n";
-
-my $for_comm =3D shift or die $usage;
-
-my %reads;
-my %writes;
-
-sub syscalls::sys_enter_read
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain, $nr, $fd, $buf, $count) =3D=
 @_;
-
-    if ($common_comm eq $for_comm) {
-	$reads{$fd}{bytes_requested} +=3D $count;
-	$reads{$fd}{total_reads}++;
-    }
-}
-
-sub syscalls::sys_enter_write
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain, $nr, $fd, $buf, $count) =3D=
 @_;
-
-    if ($common_comm eq $for_comm) {
-	$writes{$fd}{bytes_written} +=3D $count;
-	$writes{$fd}{total_writes}++;
-    }
-}
-
-sub trace_end
-{
-    printf("file read counts for $for_comm:\n\n");
-
-    printf("%6s  %10s  %10s\n", "fd", "# reads", "bytes_requested");
-    printf("%6s  %10s  %10s\n", "------", "----------", "-----------");
-
-    foreach my $fd (sort {$reads{$b}{bytes_requested} <=3D>
-			      $reads{$a}{bytes_requested}} keys %reads) {
-	my $total_reads =3D $reads{$fd}{total_reads};
-	my $bytes_requested =3D $reads{$fd}{bytes_requested};
-	printf("%6u  %10u  %10u\n", $fd, $total_reads, $bytes_requested);
-    }
-
-    printf("\nfile write counts for $for_comm:\n\n");
-
-    printf("%6s  %10s  %10s\n", "fd", "# writes", "bytes_written");
-    printf("%6s  %10s  %10s\n", "------", "----------", "-----------");
-
-    foreach my $fd (sort {$writes{$b}{bytes_written} <=3D>
-			      $writes{$a}{bytes_written}} keys %writes) {
-	my $total_writes =3D $writes{$fd}{total_writes};
-	my $bytes_written =3D $writes{$fd}{bytes_written};
-	printf("%6u  %10u  %10u\n", $fd, $total_writes, $bytes_written);
-    }
-
-    print_unhandled();
-}
-
-my %unhandled;
-
-sub print_unhandled
-{
-    if ((scalar keys %unhandled) =3D=3D 0) {
-	return;
-    }
-
-    print "\nunhandled events:\n\n";
-
-    printf("%-40s  %10s\n", "event", "count");
-    printf("%-40s  %10s\n", "----------------------------------------",
-	   "-----------");
-
-    foreach my $event_name (keys %unhandled) {
-	printf("%-40s  %10d\n", $event_name, $unhandled{$event_name});
-    }
-}
-
-sub trace_unhandled
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain) =3D @_;
-
-    $unhandled{$event_name}++;
-}
-
-
diff --git a/tools/perf/scripts/perl/rw-by-pid.pl b/tools/perf/scripts/perl=
/rw-by-pid.pl
deleted file mode 100644
index d789fe39caab..000000000000
--- a/tools/perf/scripts/perl/rw-by-pid.pl
+++ /dev/null
@@ -1,184 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0-only
-# (c) 2009, Tom Zanussi <tzanussi@gmail.com>
-
-# Display r/w activity for all processes
-
-# The common_* event handler fields are the most useful fields common to
-# all events.  They don't necessarily correspond to the 'common_*' fields
-# in the status files.  Those fields not available as handler params can
-# be retrieved via script functions of the form get_common_*().
-
-use 5.010000;
-use strict;
-use warnings;
-
-use lib "$ENV{'PERF_EXEC_PATH'}/scripts/perl/Perf-Trace-Util/lib";
-use lib "./Perf-Trace-Util/lib";
-use Perf::Trace::Core;
-use Perf::Trace::Util;
-
-my %reads;
-my %writes;
-
-sub syscalls::sys_exit_read
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $ret) =3D @_;
-
-    if ($ret > 0) {
-	$reads{$common_pid}{bytes_read} +=3D $ret;
-    } else {
-	if (!defined ($reads{$common_pid}{bytes_read})) {
-	    $reads{$common_pid}{bytes_read} =3D 0;
-	}
-	$reads{$common_pid}{errors}{$ret}++;
-    }
-}
-
-sub syscalls::sys_enter_read
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $fd, $buf, $count) =3D @_;
-
-    $reads{$common_pid}{bytes_requested} +=3D $count;
-    $reads{$common_pid}{total_reads}++;
-    $reads{$common_pid}{comm} =3D $common_comm;
-}
-
-sub syscalls::sys_exit_write
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $ret) =3D @_;
-
-    if ($ret <=3D 0) {
-	$writes{$common_pid}{errors}{$ret}++;
-    }
-}
-
-sub syscalls::sys_enter_write
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $fd, $buf, $count) =3D @_;
-
-    $writes{$common_pid}{bytes_written} +=3D $count;
-    $writes{$common_pid}{total_writes}++;
-    $writes{$common_pid}{comm} =3D $common_comm;
-}
-
-sub trace_end
-{
-    printf("read counts by pid:\n\n");
-
-    printf("%6s  %20s  %10s  %10s  %10s\n", "pid", "comm",
-	   "# reads", "bytes_requested", "bytes_read");
-    printf("%6s  %-20s  %10s  %10s  %10s\n", "------", "------------------=
--",
-	   "-----------", "----------", "----------");
-
-    foreach my $pid (sort { ($reads{$b}{bytes_read} || 0) <=3D>
-				($reads{$a}{bytes_read} || 0) } keys %reads) {
-	my $comm =3D $reads{$pid}{comm} || "";
-	my $total_reads =3D $reads{$pid}{total_reads} || 0;
-	my $bytes_requested =3D $reads{$pid}{bytes_requested} || 0;
-	my $bytes_read =3D $reads{$pid}{bytes_read} || 0;
-
-	printf("%6s  %-20s  %10s  %10s  %10s\n", $pid, $comm,
-	       $total_reads, $bytes_requested, $bytes_read);
-    }
-
-    printf("\nfailed reads by pid:\n\n");
-
-    printf("%6s  %20s  %6s  %10s\n", "pid", "comm", "error #", "# errors")=
;
-    printf("%6s  %20s  %6s  %10s\n", "------", "--------------------",
-	   "------", "----------");
-
-    my @errcounts =3D ();
-
-    foreach my $pid (keys %reads) {
-	foreach my $error (keys %{$reads{$pid}{errors}}) {
-	    my $comm =3D $reads{$pid}{comm} || "";
-	    my $errcount =3D $reads{$pid}{errors}{$error} || 0;
-	    push @errcounts, [$pid, $comm, $error, $errcount];
-	}
-    }
-
-    @errcounts =3D sort { $b->[3] <=3D> $a->[3] } @errcounts;
-
-    for my $i (0 .. $#errcounts) {
-	printf("%6d  %-20s  %6d  %10s\n", $errcounts[$i][0],
-	       $errcounts[$i][1], $errcounts[$i][2], $errcounts[$i][3]);
-    }
-
-    printf("\nwrite counts by pid:\n\n");
-
-    printf("%6s  %20s  %10s  %10s\n", "pid", "comm",
-	   "# writes", "bytes_written");
-    printf("%6s  %-20s  %10s  %10s\n", "------", "--------------------",
-	   "-----------", "----------");
-
-    foreach my $pid (sort { ($writes{$b}{bytes_written} || 0) <=3D>
-			($writes{$a}{bytes_written} || 0)} keys %writes) {
-	my $comm =3D $writes{$pid}{comm} || "";
-	my $total_writes =3D $writes{$pid}{total_writes} || 0;
-	my $bytes_written =3D $writes{$pid}{bytes_written} || 0;
-
-	printf("%6s  %-20s  %10s  %10s\n", $pid, $comm,
-	       $total_writes, $bytes_written);
-    }
-
-    printf("\nfailed writes by pid:\n\n");
-
-    printf("%6s  %20s  %6s  %10s\n", "pid", "comm", "error #", "# errors")=
;
-    printf("%6s  %20s  %6s  %10s\n", "------", "--------------------",
-	   "------", "----------");
-
-    @errcounts =3D ();
-
-    foreach my $pid (keys %writes) {
-	foreach my $error (keys %{$writes{$pid}{errors}}) {
-	    my $comm =3D $writes{$pid}{comm} || "";
-	    my $errcount =3D $writes{$pid}{errors}{$error} || 0;
-	    push @errcounts, [$pid, $comm, $error, $errcount];
-	}
-    }
-
-    @errcounts =3D sort { $b->[3] <=3D> $a->[3] } @errcounts;
-
-    for my $i (0 .. $#errcounts) {
-	printf("%6d  %-20s  %6d  %10s\n", $errcounts[$i][0],
-	       $errcounts[$i][1], $errcounts[$i][2], $errcounts[$i][3]);
-    }
-
-    print_unhandled();
-}
-
-my %unhandled;
-
-sub print_unhandled
-{
-    if ((scalar keys %unhandled) =3D=3D 0) {
-	return;
-    }
-
-    print "\nunhandled events:\n\n";
-
-    printf("%-40s  %10s\n", "event", "count");
-    printf("%-40s  %10s\n", "----------------------------------------",
-	   "-----------");
-
-    foreach my $event_name (keys %unhandled) {
-	printf("%-40s  %10d\n", $event_name, $unhandled{$event_name});
-    }
-}
-
-sub trace_unhandled
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain) =3D @_;
-
-    $unhandled{$event_name}++;
-}
diff --git a/tools/perf/scripts/perl/rwtop.pl b/tools/perf/scripts/perl/rwt=
op.pl
deleted file mode 100644
index eba4df67af6b..000000000000
--- a/tools/perf/scripts/perl/rwtop.pl
+++ /dev/null
@@ -1,203 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0-only
-# (c) 2010, Tom Zanussi <tzanussi@gmail.com>
-
-# read/write top
-#
-# Periodically displays system-wide r/w call activity, broken down by
-# pid.  If an [interval] arg is specified, the display will be
-# refreshed every [interval] seconds.  The default interval is 3
-# seconds.
-
-use 5.010000;
-use strict;
-use warnings;
-
-use lib "$ENV{'PERF_EXEC_PATH'}/scripts/perl/Perf-Trace-Util/lib";
-use lib "./Perf-Trace-Util/lib";
-use Perf::Trace::Core;
-use Perf::Trace::Util;
-use POSIX qw/SIGALRM SA_RESTART/;
-
-my $default_interval =3D 3;
-my $nlines =3D 20;
-my $print_thread;
-my $print_pending =3D 0;
-
-my %reads;
-my %writes;
-
-my $interval =3D shift;
-if (!$interval) {
-    $interval =3D $default_interval;
-}
-
-sub syscalls::sys_exit_read
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $ret) =3D @_;
-
-    print_check();
-
-    if ($ret > 0) {
-	$reads{$common_pid}{bytes_read} +=3D $ret;
-    } else {
-	if (!defined ($reads{$common_pid}{bytes_read})) {
-	    $reads{$common_pid}{bytes_read} =3D 0;
-	}
-	$reads{$common_pid}{errors}{$ret}++;
-    }
-}
-
-sub syscalls::sys_enter_read
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $fd, $buf, $count) =3D @_;
-
-    print_check();
-
-    $reads{$common_pid}{bytes_requested} +=3D $count;
-    $reads{$common_pid}{total_reads}++;
-    $reads{$common_pid}{comm} =3D $common_comm;
-}
-
-sub syscalls::sys_exit_write
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $ret) =3D @_;
-
-    print_check();
-
-    if ($ret <=3D 0) {
-	$writes{$common_pid}{errors}{$ret}++;
-    }
-}
-
-sub syscalls::sys_enter_write
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$nr, $fd, $buf, $count) =3D @_;
-
-    print_check();
-
-    $writes{$common_pid}{bytes_written} +=3D $count;
-    $writes{$common_pid}{total_writes}++;
-    $writes{$common_pid}{comm} =3D $common_comm;
-}
-
-sub trace_begin
-{
-    my $sa =3D POSIX::SigAction->new(\&set_print_pending);
-    $sa->flags(SA_RESTART);
-    $sa->safe(1);
-    POSIX::sigaction(SIGALRM, $sa) or die "Can't set SIGALRM handler: $!\n=
";
-    alarm 1;
-}
-
-sub trace_end
-{
-    print_unhandled();
-    print_totals();
-}
-
-sub print_check()
-{
-    if ($print_pending =3D=3D 1) {
-	$print_pending =3D 0;
-	print_totals();
-    }
-}
-
-sub set_print_pending()
-{
-    $print_pending =3D 1;
-    alarm $interval;
-}
-
-sub print_totals
-{
-    my $count;
-
-    $count =3D 0;
-
-    clear_term();
-
-    printf("\nread counts by pid:\n\n");
-
-    printf("%6s  %20s  %10s  %10s  %10s\n", "pid", "comm",
-	   "# reads", "bytes_req", "bytes_read");
-    printf("%6s  %-20s  %10s  %10s  %10s\n", "------", "------------------=
--",
-	   "----------", "----------", "----------");
-
-    foreach my $pid (sort { ($reads{$b}{bytes_read} || 0) <=3D>
-			       ($reads{$a}{bytes_read} || 0) } keys %reads) {
-	my $comm =3D $reads{$pid}{comm} || "";
-	my $total_reads =3D $reads{$pid}{total_reads} || 0;
-	my $bytes_requested =3D $reads{$pid}{bytes_requested} || 0;
-	my $bytes_read =3D $reads{$pid}{bytes_read} || 0;
-
-	printf("%6s  %-20s  %10s  %10s  %10s\n", $pid, $comm,
-	       $total_reads, $bytes_requested, $bytes_read);
-
-	if (++$count =3D=3D $nlines) {
-	    last;
-	}
-    }
-
-    $count =3D 0;
-
-    printf("\nwrite counts by pid:\n\n");
-
-    printf("%6s  %20s  %10s  %13s\n", "pid", "comm",
-	   "# writes", "bytes_written");
-    printf("%6s  %-20s  %10s  %13s\n", "------", "--------------------",
-	   "----------", "-------------");
-
-    foreach my $pid (sort { ($writes{$b}{bytes_written} || 0) <=3D>
-			($writes{$a}{bytes_written} || 0)} keys %writes) {
-	my $comm =3D $writes{$pid}{comm} || "";
-	my $total_writes =3D $writes{$pid}{total_writes} || 0;
-	my $bytes_written =3D $writes{$pid}{bytes_written} || 0;
-
-	printf("%6s  %-20s  %10s  %13s\n", $pid, $comm,
-	       $total_writes, $bytes_written);
-
-	if (++$count =3D=3D $nlines) {
-	    last;
-	}
-    }
-
-    %reads =3D ();
-    %writes =3D ();
-}
-
-my %unhandled;
-
-sub print_unhandled
-{
-    if ((scalar keys %unhandled) =3D=3D 0) {
-	return;
-    }
-
-    print "\nunhandled events:\n\n";
-
-    printf("%-40s  %10s\n", "event", "count");
-    printf("%-40s  %10s\n", "----------------------------------------",
-	   "-----------");
-
-    foreach my $event_name (keys %unhandled) {
-	printf("%-40s  %10d\n", $event_name, $unhandled{$event_name});
-    }
-}
-
-sub trace_unhandled
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain) =3D @_;
-
-    $unhandled{$event_name}++;
-}
diff --git a/tools/perf/scripts/perl/wakeup-latency.pl b/tools/perf/scripts=
/perl/wakeup-latency.pl
deleted file mode 100644
index 53444ff4ec7f..000000000000
--- a/tools/perf/scripts/perl/wakeup-latency.pl
+++ /dev/null
@@ -1,107 +0,0 @@
-#!/usr/bin/perl -w
-# SPDX-License-Identifier: GPL-2.0-only
-# (c) 2009, Tom Zanussi <tzanussi@gmail.com>
-
-# Display avg/min/max wakeup latency
-
-# The common_* event handler fields are the most useful fields common to
-# all events.  They don't necessarily correspond to the 'common_*' fields
-# in the status files.  Those fields not available as handler params can
-# be retrieved via script functions of the form get_common_*().
-
-use 5.010000;
-use strict;
-use warnings;
-
-use lib "$ENV{'PERF_EXEC_PATH'}/scripts/perl/Perf-Trace-Util/lib";
-use lib "./Perf-Trace-Util/lib";
-use Perf::Trace::Core;
-use Perf::Trace::Util;
-
-my %last_wakeup;
-
-my $max_wakeup_latency;
-my $min_wakeup_latency;
-my $total_wakeup_latency =3D 0;
-my $total_wakeups =3D 0;
-
-sub sched::sched_switch
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$prev_comm, $prev_pid, $prev_prio, $prev_state, $next_comm, $next_pid,
-	$next_prio) =3D @_;
-
-    my $wakeup_ts =3D $last_wakeup{$common_cpu}{ts};
-    if ($wakeup_ts) {
-	my $switch_ts =3D nsecs($common_secs, $common_nsecs);
-	my $wakeup_latency =3D $switch_ts - $wakeup_ts;
-	if ($wakeup_latency > $max_wakeup_latency) {
-	    $max_wakeup_latency =3D $wakeup_latency;
-	}
-	if ($wakeup_latency < $min_wakeup_latency) {
-	    $min_wakeup_latency =3D $wakeup_latency;
-	}
-	$total_wakeup_latency +=3D $wakeup_latency;
-	$total_wakeups++;
-    }
-    $last_wakeup{$common_cpu}{ts} =3D 0;
-}
-
-sub sched::sched_wakeup
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain,
-	$comm, $pid, $prio, $success, $target_cpu) =3D @_;
-
-    $last_wakeup{$target_cpu}{ts} =3D nsecs($common_secs, $common_nsecs);
-}
-
-sub trace_begin
-{
-    $min_wakeup_latency =3D 1000000000;
-    $max_wakeup_latency =3D 0;
-}
-
-sub trace_end
-{
-    printf("wakeup_latency stats:\n\n");
-    print "total_wakeups: $total_wakeups\n";
-    if ($total_wakeups) {
-	printf("avg_wakeup_latency (ns): %u\n",
-	       avg($total_wakeup_latency, $total_wakeups));
-    } else {
-	printf("avg_wakeup_latency (ns): N/A\n");
-    }
-    printf("min_wakeup_latency (ns): %u\n", $min_wakeup_latency);
-    printf("max_wakeup_latency (ns): %u\n", $max_wakeup_latency);
-
-    print_unhandled();
-}
-
-my %unhandled;
-
-sub print_unhandled
-{
-    if ((scalar keys %unhandled) =3D=3D 0) {
-	return;
-    }
-
-    print "\nunhandled events:\n\n";
-
-    printf("%-40s  %10s\n", "event", "count");
-    printf("%-40s  %10s\n", "----------------------------------------",
-	   "-----------");
-
-    foreach my $event_name (keys %unhandled) {
-	printf("%-40s  %10d\n", $event_name, $unhandled{$event_name});
-    }
-}
-
-sub trace_unhandled
-{
-    my ($event_name, $context, $common_cpu, $common_secs, $common_nsecs,
-	$common_pid, $common_comm, $common_callchain) =3D @_;
-
-    $unhandled{$event_name}++;
-}
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index cf9d4b5d3153..7524de522802 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -79,7 +79,6 @@ make_no_jevents     :=3D NO_JEVENTS=3D1
 make_jevents_all    :=3D JEVENTS_ARCH=3Dall
 make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
 make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
-make_libperl        :=3D LIBPERL=3D1
 make_no_python_module :=3D NO_PYTHON_MODULE=3D1
 make_no_scripts     :=3D NO_PYTHON_MODULE=3D1
 make_no_slang       :=3D NO_SLANG=3D1
@@ -175,7 +174,6 @@ run +=3D make_no_jevents
 run +=3D make_jevents_all
 run +=3D make_no_bpf_skel
 run +=3D make_gen_vmlinux_h
-run +=3D make_libperl
 run +=3D make_no_python_module
 run +=3D make_no_scripts
 run +=3D make_no_slang
diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh =
b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
index 82cdb1762285..d298b18154b2 100755
--- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
@@ -20,13 +20,6 @@ skip_if_no_cs_etm_event || exit 2
 set -e
 glb_err=3D1
=20
-# Relative path works whether it's installed or running from repo
-if [ -n "$PERF_EXEC_PATH" ] && [ -e "$PERF_EXEC_PATH/python/arm-cs-trace-d=
isasm.py" ]; then
-	script_path=3D"$PERF_EXEC_PATH/python/arm-cs-trace-disasm.py"
-else
-	script_path=3D$(dirname "$0")/../../../python/arm-cs-trace-disasm.py
-fi
-
 # shellcheck source=3Dlib/setup_python.sh
 . "$(dirname "$0")"/../lib/setup_python.sh
 $PYTHON -c "import perf" 2>/dev/null || {
@@ -56,8 +49,8 @@ branch_search=3D'[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs=
|vc|hi|ls|ge|lt|gt|le|al)
 if [ "$(id -u)" =3D=3D 0 ] && [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file=
 > /dev/null 2>&1
-	$PYTHON ${script_path} -i ${perfdata} -d --stop-sample=3D2 \
-		-k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
+	perf script -i ${perfdata} arm-cs-trace-disasm -- \
+		-d --stop-sample=3D2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${fil=
e}
 	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
 else
@@ -68,7 +61,8 @@ fi
 ## Test user ##
 echo "Testing userspace disassembly"
 perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/n=
ull 2>&1
-$PYTHON ${script_path} -i ${perfdata} -d --stop-sample=3D2 2> /dev/null > =
${file}
+perf script -i ${perfdata} arm-cs-trace-disasm -- \
+	-d --stop-sample=3D2 2> /dev/null > ${file}
 grep -q -E ${branch_search} ${file}
 echo "Found userspace branches"
=20
diff --git a/tools/perf/tests/shell/script_perl.sh b/tools/perf/tests/shell=
/script_perl.sh
deleted file mode 100755
index b6d65b6fbda1..000000000000
--- a/tools/perf/tests/shell/script_perl.sh
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/bash
-# perf script perl tests
-# SPDX-License-Identifier: GPL-2.0
-
-set -e
-
-# set PERF_EXEC_PATH to find scripts in the source directory
-perfdir=3D$(dirname "$0")/../..
-if [ -e "$perfdir/scripts/perl/Perf-Trace-Util" ]; then
-  export PERF_EXEC_PATH=3D$perfdir
-fi
-
-
-perfdata=3D$(mktemp /tmp/__perf_test_script_perl.perf.data.XXXXX)
-generated_script=3D$(mktemp /tmp/__perf_test_script.XXXXX.pl)
-
-cleanup() {
-  rm -f "${perfdata}"
-  rm -f "${generated_script}"
-  trap - EXIT TERM INT
-}
-
-trap_cleanup() {
-  echo "Unexpected signal in ${FUNCNAME[1]}"
-  cleanup
-  exit 1
-}
-trap trap_cleanup TERM INT
-trap cleanup EXIT
-
-check_perl_support() {
-	if perf check feature -q libperl; then
-		return 0
-	fi
-	echo "perf script perl test [Skipped: no libperl support]"
-	return 2
-}
-
-test_script() {
-	local event_name=3D$1
-	local expected_output=3D$2
-	local record_opts=3D$3
-
-	echo "Testing event: $event_name"
-
-	# Try to record. If this fails, it might be permissions or lack of suppor=
t.
-	# We return 2 to indicate "skip this event" rather than "fail test".
-	if ! perf record -o "${perfdata}" -e "$event_name" $record_opts -- perf t=
est -w thloop > /dev/null 2>&1; then
-		echo "perf script perl test [Skipped: failed to record $event_name]"
-		return 2
-	fi
-
-	echo "Generating perl script..."
-	if ! perf script -i "${perfdata}" -g "${generated_script}"; then
-		echo "perf script perl test [Failed: script generation for $event_name]"
-		return 1
-	fi
-
-	if [ ! -f "${generated_script}" ]; then
-		echo "perf script perl test [Failed: script not generated for $event_nam=
e]"
-		return 1
-	fi
-
-	echo "Executing perl script..."
-	output=3D$(perf script -i "${perfdata}" -s "${generated_script}" 2>&1)
-
-	if echo "$output" | grep -q "$expected_output"; then
-		echo "perf script perl test [Success: $event_name triggered $expected_ou=
tput]"
-		return 0
-	else
-		echo "perf script perl test [Failed: $event_name did not trigger $expect=
ed_output]"
-		echo "Output was:"
-		echo "$output" | head -n 20
-		return 1
-	fi
-}
-
-check_perl_support || exit 2
-
-# Try tracepoint first
-test_script "sched:sched_switch" "sched::sched_switch" "-c 1" && res=3D0 |=
| res=3D$?
-
-if [ $res -eq 0 ]; then
-	exit 0
-elif [ $res -eq 1 ]; then
-	exit 1
-fi
-
-# If tracepoint skipped (res=3D2), try task-clock
-# For generic events like task-clock, the generated script uses process_ev=
ent()
-# which dumps data using Data::Dumper. We check for "$VAR1" which is stand=
ard Dumper output.
-test_script "task-clock" "\$VAR1" "-c 100" && res=3D0 || res=3D$?
-
-if [ $res -eq 0 ]; then
-	exit 0
-elif [ $res -eq 1 ]; then
-	exit 1
-fi
-
-# If both skipped
-echo "perf script perl test [Skipped: Could not record tracepoint or task-=
clock]"
-exit 2
diff --git a/tools/perf/tests/shell/test_check_perf_trace_python.sh b/tools=
/perf/tests/shell/test_check_perf_trace_python.sh
index a346e45eb18c..92cc7b1f0033 100755
--- a/tools/perf/tests/shell/test_check_perf_trace_python.sh
+++ b/tools/perf/tests/shell/test_check_perf_trace_python.sh
@@ -68,7 +68,7 @@ test_file_mode() {
 	fi
=20
 	# Run the script
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	if ! perf script check-perf-trace -i "${temp_data}" > "${temp_out}"; then
 		echo "File mode test failed."
 		err=3D1
 	elif ! grep -q "in trace_begin" "${temp_out}" || \
diff --git a/tools/perf/tests/shell/test_compaction_times_python.sh b/tools=
/perf/tests/shell/test_compaction_times_python.sh
index ad950f3602b5..50397afaafed 100755
--- a/tools/perf/tests/shell/test_compaction_times_python.sh
+++ b/tools/perf/tests/shell/test_compaction_times_python.sh
@@ -58,7 +58,7 @@ test_file_mode() {
 	fi
=20
 	# Run the script with some filters to validate filtering logic
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	if ! perf script compaction-times -i "${temp_data}" > "${temp_out}"; then
 		echo "File mode default test failed."
 		err=3D1
 	elif ! grep -q "total:" "${temp_out}"; then
@@ -66,7 +66,7 @@ test_file_mode() {
 		err=3D1
 	fi
=20
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" "0-0" > "${temp_out}"; th=
en
+	if ! perf script compaction-times -i "${temp_data}" "0-0" > "${temp_out}"=
; then
 		echo "File mode strict PID filter test failed."
 		err=3D1
 	elif ! grep -q "total:" "${temp_out}"; then
@@ -74,7 +74,7 @@ test_file_mode() {
 		err=3D1
 	fi
=20
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" "sleep" > "${temp_out}"; =
then
+	if ! perf script compaction-times -i "${temp_data}" "sleep" > "${temp_out=
}"; then
 		echo "File mode comm filter test failed."
 		err=3D1
 	elif ! grep -q "total:" "${temp_out}"; then
diff --git a/tools/perf/tests/shell/test_event_analyzing_sample_python.sh b=
/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
index 4678edfd9e5b..a7a8ded003db 100755
--- a/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
+++ b/tools/perf/tests/shell/test_event_analyzing_sample_python.sh
@@ -45,7 +45,8 @@ test_file_mode() {
 	fi
=20
 	# Run the script
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -d "${temp_db}" > "${temp=
_dir}/perf.out" 2>&1; then
+	if ! perf script event_analyzing_sample -i "${temp_data}" \
+		-d "${temp_db}" > "${temp_dir}/perf.out" 2>&1; then
 		echo "File mode test failed."
 		err=3D1
 	elif ! grep -q "Statistics about the general events" "${temp_dir}/perf.ou=
t" || \
diff --git a/tools/perf/tests/shell/test_export_to_postgresql_python.sh b/t=
ools/perf/tests/shell/test_export_to_postgresql_python.sh
index ce13a1aa7cd7..350813466700 100755
--- a/tools/perf/tests/shell/test_export_to_postgresql_python.sh
+++ b/tools/perf/tests/shell/test_export_to_postgresql_python.sh
@@ -54,7 +54,8 @@ test_file_mode() {
 	echo "Testing export-to-postgresql.py..."
=20
 	# Verify that invalid URI / key-value database names are rejected
-	if "$PYTHON" "$script_path" -i /dev/null -o "dbname=3Dfoo host=3Devil" >/=
dev/null 2>&1; then
+	if perf script export-to-postgresql -i /dev/null \
+		-o "dbname=3Dfoo host=3Devil" >/dev/null 2>&1; then
 		echo "Connection parameter injection check failed."
 		err=3D1
 	fi
@@ -71,7 +72,7 @@ test_file_mode() {
 	psql -c "DROP DATABASE IF EXISTS ${temp_db}" postgres >/dev/null 2>&1 || =
true
=20
 	# Run the script
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -o "${temp_db}" >/dev/nul=
l; then
+	if ! perf script export-to-postgresql -i "${temp_data}" -o "${temp_db}" >=
/dev/null; then
 		echo "File mode test failed."
 		err=3D1
 	else
@@ -101,7 +102,8 @@ test_intel_pt() {
 	fi
=20
 	# Run the script with --itrace cr to synthesize call_returns
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -o "${temp_db}" --itrace =
cr >/dev/null; then
+	if ! perf script export-to-postgresql -i "${temp_data}" \
+		-o "${temp_db}" --itrace cr >/dev/null; then
 		echo "intel_pt file mode test failed."
 		err=3D1
 	else
diff --git a/tools/perf/tests/shell/test_export_to_sqlite_python.sh b/tools=
/perf/tests/shell/test_export_to_sqlite_python.sh
index 59280d372399..d3c5e22a0754 100755
--- a/tools/perf/tests/shell/test_export_to_sqlite_python.sh
+++ b/tools/perf/tests/shell/test_export_to_sqlite_python.sh
@@ -55,7 +55,7 @@ test_file_mode() {
 	fi
=20
 	# Run the script
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -o "${temp_db}" >/dev/nul=
l; then
+	if ! perf script export-to-sqlite -i "${temp_data}" -o "${temp_db}" >/dev=
/null; then
 		echo "File mode test failed."
 		err=3D1
 	else
@@ -86,7 +86,7 @@ test_intel_pt() {
 	fi
=20
 	# Run the script with --itrace cr to synthesize call_returns
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -o "${temp_db}" --itrace =
cr; then
+	if ! perf script export-to-sqlite -i "${temp_data}" -o "${temp_db}" --itr=
ace cr; then
 		echo "intel_pt file mode test failed."
 		err=3D1
 	else
diff --git a/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh b=
/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
index 5bbd1a0adb1e..215372d4e1c5 100755
--- a/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
+++ b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
@@ -63,14 +63,14 @@ test_file_mode() {
 	fi
=20
 	# Run the script and check output
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	if ! perf script failed-syscalls-by-pid -i "${temp_data}" > "${temp_out}"=
; then
 		echo "failed-syscalls-by-pid test failed."
 		err=3D1
 	elif ! grep -n -q "err =3D ENOENT" "${temp_out}"; then
 		echo "Failed to find expected failed syscalls"
 		cat "${temp_out}"
 		err=3D1
-	elif ! "$PYTHON" "$script_path" -i "${temp_data}" "ls" > "${temp_out}.com=
m" || \
+	elif ! perf script failed-syscalls-by-pid -i "${temp_data}" "ls" > "${tem=
p_out}.comm" || \
 	     ! grep -q "err =3D ENOENT" "${temp_out}.comm"; then
 		echo "failed-syscalls-by-pid comm filter test failed."
 		cat "${temp_out}.comm"
@@ -78,7 +78,8 @@ test_file_mode() {
 	else
 		ls_pid=3D$(sed -n 's/^ls \[\([0-9][0-9]*\)\].*/\1/p' "${temp_out}.comm" =
| head -n 1)
 		if [ -z "${ls_pid}" ] || \
-		   ! "$PYTHON" "$script_path" -i "${temp_data}" "${ls_pid}" > "${temp_ou=
t}.pid" || \
+		   ! perf script failed-syscalls-by-pid -i "${temp_data}" \
+			"${ls_pid}" > "${temp_out}.pid" || \
 		   ! grep -q "err =3D ENOENT" "${temp_out}.pid"; then
 			echo "failed-syscalls-by-pid PID filter test failed."
 			cat "${temp_out}.pid" 2>/dev/null || true
diff --git a/tools/perf/tests/shell/test_failed_syscalls_python.sh b/tools/=
perf/tests/shell/test_failed_syscalls_python.sh
index 0cabb127d7e9..861c2ba71c0a 100755
--- a/tools/perf/tests/shell/test_failed_syscalls_python.sh
+++ b/tools/perf/tests/shell/test_failed_syscalls_python.sh
@@ -63,7 +63,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script failed-syscalls -i "${temp_data}" > "${temp_out}"; then
 	echo "failed-syscalls.py test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_flamegraph_python.sh b/tools/perf/=
tests/shell/test_flamegraph_python.sh
index c6f5cf80b79f..86313c72f53e 100755
--- a/tools/perf/tests/shell/test_flamegraph_python.sh
+++ b/tools/perf/tests/shell/test_flamegraph_python.sh
@@ -66,7 +66,7 @@ test_file_mode() {
 	fi
=20
 	# Run the script in file mode and validate JSON output
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -f json -o "${temp_json}"=
 >/dev/null; then
+	if ! perf script flamegraph -i "${temp_data}" -f json -o "${temp_json}" >=
/dev/null; then
 		echo "File mode JSON test failed."
 		err=3D1
 	else
@@ -76,7 +76,7 @@ test_file_mode() {
 	# Run the script in pipe ('-') mode and validate JSON output
 	rm -f "${temp_json}"
 	if ! perf record -g -o - -- perf test -w noploop 2>/dev/null | \
-		"$PYTHON" "$script_path" -i - -f json -o "${temp_json}" >/dev/null; then
+		perf script flamegraph -i - -f json -o "${temp_json}" >/dev/null; then
 		echo "Pipe stdin JSON mode test failed."
 		err=3D1
 	else
@@ -84,7 +84,7 @@ test_file_mode() {
 	fi
=20
 	# Run the script, dump as html to temp_html using MINIMAL_HTML fallback
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -f html \
+	if ! perf script flamegraph -i "${temp_data}" -f html \
 		--template /nonexistent/template.html -o "${temp_html}" >/dev/null 2>&1;=
 then
 		echo "File mode HTML test failed."
 		err=3D1
@@ -105,7 +105,7 @@ const opts =3D /** @options_json **/;
 const data =3D /** @flamegraph_json **/;
 </script></body></html>
 EOF
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" -f html --template "${tem=
p_tpl}" \
+	if ! perf script flamegraph -i "${temp_data}" -f html --template "${temp_=
tpl}" \
 		--colorscheme blue-green -o "${temp_html}" >/dev/null 2>&1; then
 		echo "Custom template HTML test failed."
 		err=3D1
diff --git a/tools/perf/tests/shell/test_futex_contention_python.sh b/tools=
/perf/tests/shell/test_futex_contention_python.sh
index 26b13d263d20..a8846ed68ac2 100755
--- a/tools/perf/tests/shell/test_futex_contention_python.sh
+++ b/tools/perf/tests/shell/test_futex_contention_python.sh
@@ -101,7 +101,7 @@ test_file_mode() {
 		return
 	fi
=20
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	if ! perf script futex-contention -i "${temp_data}" > "${temp_out}"; then
 		echo "File mode test failed."
 		err=3D1
 	else
diff --git a/tools/perf/tests/shell/test_gecko_python.sh b/tools/perf/tests=
/shell/test_gecko_python.sh
index eac9b2f8e3c7..de1d7fcf88b7 100755
--- a/tools/perf/tests/shell/test_gecko_python.sh
+++ b/tools/perf/tests/shell/test_gecko_python.sh
@@ -45,7 +45,7 @@ test_file_mode() {
 	fi
=20
 	# Run the script in save-only mode with custom product and category color=
s
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" \
+	if ! perf script gecko -i "${temp_data}" \
 		--product "perf-test-product" --user-color blue --kernel-color red \
 		--save-only "${temp_json}" >/dev/null; then
 		echo "File mode test failed."
diff --git a/tools/perf/tests/shell/test_intel_pt_events_python.sh b/tools/=
perf/tests/shell/test_intel_pt_events_python.sh
index 0d397792ced8..b5c3173fa2db 100755
--- a/tools/perf/tests/shell/test_intel_pt_events_python.sh
+++ b/tools/perf/tests/shell/test_intel_pt_events_python.sh
@@ -49,7 +49,7 @@ test_intel_pt() {
 	fi
=20
 	# Run the script and check output
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	if ! perf script intel-pt-events -i "${temp_data}" > "${temp_out}"; then
 		echo "intel-pt-events.py test failed."
 		err=3D1
 	else
diff --git a/tools/perf/tests/shell/test_mem_phys_addr_python.sh b/tools/pe=
rf/tests/shell/test_mem_phys_addr_python.sh
index d094a0611a24..451692d5e089 100755
--- a/tools/perf/tests/shell/test_mem_phys_addr_python.sh
+++ b/tools/perf/tests/shell/test_mem_phys_addr_python.sh
@@ -87,7 +87,8 @@ test_file_mode() {
 	fi
=20
 	# Run the script with custom --iomem
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" --iomem "${temp_iomem}" >=
 "${temp_out}" || \
+	if ! perf script mem-phys-addr -i "${temp_data}" \
+		--iomem "${temp_iomem}" > "${temp_out}" || \
 	   [ ! -s "${temp_out}" ]; then
 		echo "File mode test failed."
 		err=3D1
diff --git a/tools/perf/tests/shell/test_net_dropmonitor_python.sh b/tools/=
perf/tests/shell/test_net_dropmonitor_python.sh
index d00be255d259..05056a897bc9 100755
--- a/tools/perf/tests/shell/test_net_dropmonitor_python.sh
+++ b/tools/perf/tests/shell/test_net_dropmonitor_python.sh
@@ -59,7 +59,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes and outputs table header
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script net_dropmonitor -i "${temp_data}" > "${temp_out}"; then
 	echo "net_dropmonitor.py test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_netdev_times_python.sh b/tools/per=
f/tests/shell/test_netdev_times_python.sh
index bb0f8c30207f..393bf446efb2 100755
--- a/tools/perf/tests/shell/test_netdev_times_python.sh
+++ b/tools/perf/tests/shell/test_netdev_times_python.sh
@@ -93,7 +93,7 @@ if ! perf record -e skb:kfree_skb -a -o "${temp_data}" \
 fi
=20
 # Check that the script executes
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script netdev-times -i "${temp_data}" > "${temp_out}"; then
 	echo "netdev-times.py test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_powerpc_hcalls_python.sh b/tools/p=
erf/tests/shell/test_powerpc_hcalls_python.sh
index 5316c28f243f..19569c6d3613 100755
--- a/tools/perf/tests/shell/test_powerpc_hcalls_python.sh
+++ b/tools/perf/tests/shell/test_powerpc_hcalls_python.sh
@@ -79,7 +79,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes on recorded perf.data
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script powerpc-hcalls -i "${temp_data}" > "${temp_out}"; then
 	echo "powerpc-hcalls.py test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_rw_by_file_python.sh b/tools/perf/=
tests/shell/test_rw_by_file_python.sh
index 98218bf8a39e..f121597f418f 100755
--- a/tools/perf/tests/shell/test_rw_by_file_python.sh
+++ b/tools/perf/tests/shell/test_rw_by_file_python.sh
@@ -52,7 +52,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes - filtering for "dd" since that's what we=
 ran
-if ! "$PYTHON" "$script_path" -i "${temp_data}" "dd" > "${temp_out}"; then
+if ! perf script rw-by-file -i "${temp_data}" "dd" > "${temp_out}"; then
 	echo "rw-by-file.py test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_rw_by_pid_python.sh b/tools/perf/t=
ests/shell/test_rw_by_pid_python.sh
index da8b065d43de..41eaa29097a2 100755
--- a/tools/perf/tests/shell/test_rw_by_pid_python.sh
+++ b/tools/perf/tests/shell/test_rw_by_pid_python.sh
@@ -58,7 +58,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script rw-by-pid -i "${temp_data}" > "${temp_out}"; then
 	echo "rw-by-pid.py test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_rwtop_python.sh b/tools/perf/tests=
/shell/test_rwtop_python.sh
index 062fca2dad14..05897e384702 100755
--- a/tools/perf/tests/shell/test_rwtop_python.sh
+++ b/tools/perf/tests/shell/test_rwtop_python.sh
@@ -58,7 +58,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script rwtop -i "${temp_data}" > "${temp_out}"; then
 	echo "rwtop.py test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_sched_migration_python.sh b/tools/=
perf/tests/shell/test_sched_migration_python.sh
index f243e86c6700..75465bcd3791 100755
--- a/tools/perf/tests/shell/test_sched_migration_python.sh
+++ b/tools/perf/tests/shell/test_sched_migration_python.sh
@@ -58,7 +58,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes
-if ! "$PYTHON" "$script_path" -v --no-gui -i "${temp_data}" > "${temp_out}=
"; then
+if ! perf script sched-migration -v --no-gui -i "${temp_data}" > "${temp_o=
ut}"; then
 	echo "sched-migration.py test failed"
 	err=3D1
 elif [ "$has_sched" -eq 1 ] && ! grep -q "Timeslices:" "${temp_out}"; then
diff --git a/tools/perf/tests/shell/test_sctop_python.sh b/tools/perf/tests=
/shell/test_sctop_python.sh
index cd38cdd4794c..007f2584cce6 100755
--- a/tools/perf/tests/shell/test_sctop_python.sh
+++ b/tools/perf/tests/shell/test_sctop_python.sh
@@ -56,13 +56,13 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script sctop -i "${temp_data}" > "${temp_out}"; then
 	echo "sctop.py test failed"
 	err=3D1
 elif ! grep -E -q "[0-9]+$" "${temp_out}"; then
 	echo "Failed to find metric data rows in default run"
 	err=3D1
-elif ! "$PYTHON" "$script_path" -i "${temp_data}" sleep 1 > "${temp_out}";=
 then
+elif ! perf script sctop -i "${temp_data}" sleep 1 > "${temp_out}"; then
 	echo "sctop.py comm+interval test failed"
 	err=3D1
 else
diff --git a/tools/perf/tests/shell/test_stackcollapse_python.sh b/tools/pe=
rf/tests/shell/test_stackcollapse_python.sh
index a3b6c917e842..ce0f80407eec 100755
--- a/tools/perf/tests/shell/test_stackcollapse_python.sh
+++ b/tools/perf/tests/shell/test_stackcollapse_python.sh
@@ -47,7 +47,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes with default options
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script stackcollapse -i "${temp_data}" > "${temp_out}"; then
 	echo "stackcollapse.py test failed"
 	err=3D1
 else
@@ -61,12 +61,12 @@ else
 fi
=20
 # Test CLI flags (--include-pid, --include-tid, --tidy-java, --kernel) and=
 BrokenPipeError
-if ! "$PYTHON" "$script_path" -i "${temp_data}" \
+if ! perf script stackcollapse -i "${temp_data}" \
 	--include-pid --include-tid --tidy-java --kernel | head -n 1 > "${temp_ou=
t}" || \
    [ ! -s "${temp_out}" ]; then
 	echo "stackcollapse.py options/pipe test failed"
 	err=3D1
-elif ! "$PYTHON" "$script_path" -i "${temp_data}" --no-comm > "${temp_out}=
" || \
+elif ! perf script stackcollapse -i "${temp_data}" --no-comm > "${temp_out=
}" || \
      [ ! -s "${temp_out}" ]; then
 	echo "stackcollapse.py --no-comm test failed"
 	err=3D1
diff --git a/tools/perf/tests/shell/test_stat_cpi_python.sh b/tools/perf/te=
sts/shell/test_stat_cpi_python.sh
index 0960afa4c797..fe7562307634 100755
--- a/tools/perf/tests/shell/test_stat_cpi_python.sh
+++ b/tools/perf/tests/shell/test_stat_cpi_python.sh
@@ -62,7 +62,7 @@ test_live_mode() {
 	ran=3D1
=20
 	# Run live mode for 1 interval in the background, give it a tiny sleep, t=
hen interrupt
-	"$PYTHON" "$script_path" -I 0.1 -p "$workload_pid" > "${temp_out}" &
+	perf script stat-cpi -I 0.1 -p "$workload_pid" > "${temp_out}" &
 	pid=3D$!
 	sleep 0.5
 	kill -INT "$pid" 2>/dev/null || true
@@ -96,7 +96,7 @@ test_file_mode() {
 	fi
 	ran=3D1
=20
-	out=3D$("$PYTHON" "$script_path" -i "${temp_data}")
+	out=3D$(perf script stat-cpi -i "${temp_data}")
 	if ! echo "$out" | grep -q "cpi"; then
 		echo "File mode test failed."
 		err=3D1
diff --git a/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh b/=
tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
index 9f2ad27751a2..45bbdc554c8f 100755
--- a/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
+++ b/tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
@@ -53,7 +53,7 @@ test_file_mode() {
 		-- sleep 0.5 >/dev/null 2>&1 || \
 		{ echo "Skipping test, perf record failed"; exit 2; }
=20
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	if ! perf script syscall-counts-by-pid -i "${temp_data}" > "${temp_out}";=
 then
 		echo "File mode test failed."
 		err=3D1
 	elif ! grep -E -q "^  [a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
@@ -64,7 +64,7 @@ test_file_mode() {
 	fi
=20
 	# Test with a comm argument
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" "sleep" > "${temp_out}"; =
then
+	if ! perf script syscall-counts-by-pid -i "${temp_data}" "sleep" > "${tem=
p_out}"; then
 		echo "Comm filter test failed."
 		err=3D1
 	elif ! grep -E -q "^  [a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
@@ -76,7 +76,8 @@ test_file_mode() {
=20
 	# Extract sleep PID from "sleep [<pid>]" header and test with a numeric P=
ID filter argument
 	sleep_pid=3D$(sed -n 's/^sleep \[\([0-9]\+\)\]$/\1/p' "${temp_out}" | hea=
d -n 1)
-	if [ -z "${sleep_pid}" ] || ! "$PYTHON" "$script_path" -i "${temp_data}" =
"${sleep_pid}" > "${temp_out}"; then
+	if [ -z "${sleep_pid}" ] || \
+	   ! perf script syscall-counts-by-pid -i "${temp_data}" "${sleep_pid}" >=
 "${temp_out}"; then
 		echo "PID filter test failed."
 		err=3D1
 	elif ! grep -E -q "^  [a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
diff --git a/tools/perf/tests/shell/test_syscall_counts_python.sh b/tools/p=
erf/tests/shell/test_syscall_counts_python.sh
index 0c4b75499209..310e05d399f9 100755
--- a/tools/perf/tests/shell/test_syscall_counts_python.sh
+++ b/tools/perf/tests/shell/test_syscall_counts_python.sh
@@ -54,7 +54,7 @@ test_file_mode() {
 		exit 2
 	fi
=20
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+	if ! perf script syscall-counts -i "${temp_data}" > "${temp_out}"; then
 		echo "File mode test failed."
 		err=3D1
 	elif ! grep -E -q "^[a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
@@ -65,7 +65,7 @@ test_file_mode() {
 	fi
=20
 	# Test with a comm argument
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" "sleep" > "${temp_out}"; =
then
+	if ! perf script syscall-counts -i "${temp_data}" "sleep" > "${temp_out}"=
; then
 		echo "Comm filter test failed."
 		err=3D1
 	elif ! grep -E -q "^[a-zA-Z0-9_]+ +[0-9]+$" "${temp_out}"; then
diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/test=
s/shell/test_task_analyzer.sh
index 3a97d58eec74..f99a637a6099 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -11,16 +11,6 @@ csv=3D"$tmpdir/csv"
 csvsummary=3D"$tmpdir/csvsummary"
 err=3D0
=20
-# Set up perfdir and PERF_EXEC_PATH
-if [ "x$PERF_EXEC_PATH" =3D "x" ]; then
-  perfdir=3D"$(dirname "$0")/../.."
-  if [ -f "$perfdir/python/task-analyzer.py" ]; then
-    export PERF_EXEC_PATH=3D"$perfdir"
-  fi
-else
-  perfdir=3D"$PERF_EXEC_PATH"
-fi
-
 # Disable lsan to avoid warnings about python memory leaks.
 export ASAN_OPTIONS=3Ddetect_leaks=3D0
=20
@@ -81,17 +71,17 @@ prepare_perf_data() {
 # check standard inkvokation with no arguments
 test_basic() {
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" > "$out"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata}"
+	perf script -i "${perfdata}" task-analyzer > "$out"
+	check_exec_0 "perf script -i ${perfdata} task-analyzer"
 	find_str_or_fail "Comm" "$out" "${FUNCNAME[0]}"
 }
=20
 test_ns_rename(){
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+	perf script -i "${perfdata}" task-analyzer \
 		--ns \
 		--rename-comms-by-tids 0:random > "$out"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+	check_exec_0 "perf script -i ${perfdata} task-analyzer \
 		--ns \
 		--rename-comms-by-tids 0:random"
 	find_str_or_fail "Comm" "$out" "${FUNCNAME[0]}"
@@ -99,20 +89,20 @@ test_ns_rename(){
=20
 test_ms_filtertasks_highlight(){
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+	perf script -i "${perfdata}" task-analyzer \
 		--ms --filter-tasks perf --highlight-tasks perf \
 	> "$out"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+	check_exec_0 "perf script -i ${perfdata} task-analyzer \
 		--ms --filter-tasks perf --highlight-tasks perf"
 	find_str_or_fail "Comm" "$out" "${FUNCNAME[0]}"
 }
=20
 test_extended_times_timelimit_limittasks() {
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --extended-time=
s \
+	perf script -i "${perfdata}" task-analyzer --extended-times \
 		--time-limit :99999 \
 	--limit-to-tasks perf > "$out"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+	check_exec_0 "perf script -i ${perfdata} task-analyzer \
 		--extended-times \
 		--time-limit :99999 --limit-to-tasks perf"
 	find_str_or_fail "Out-Out" "$out" "${FUNCNAME[0]}"
@@ -120,30 +110,30 @@ test_extended_times_timelimit_limittasks() {
=20
 test_summary() {
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --summary > "$o=
ut"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --s=
ummary"
+	perf script -i "${perfdata}" task-analyzer --summary > "$out"
+	check_exec_0 "perf script -i ${perfdata} task-analyzer --summary"
 	find_str_or_fail "Summary" "$out" "${FUNCNAME[0]}"
 }
=20
 test_summaryextended() {
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --summary-exten=
ded > "$out"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --s=
ummary-extended"
+	perf script -i "${perfdata}" task-analyzer --summary-extended > "$out"
+	check_exec_0 "perf script -i ${perfdata} task-analyzer --summary-extended=
"
 	find_str_or_fail "Inter Task Times" "$out" "${FUNCNAME[0]}"
 }
=20
 test_summaryonly() {
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --summary-only =
> "$out"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --s=
ummary-only"
+	perf script -i "${perfdata}" task-analyzer --summary-only > "$out"
+	check_exec_0 "perf script -i ${perfdata} task-analyzer --summary-only"
 	find_str_or_fail "Summary" "$out" "${FUNCNAME[0]}"
 }
=20
 test_extended_times_summary_ns() {
 	out=3D"$tmpdir/perf.out"
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --extended-time=
s \
+	perf script -i "${perfdata}" task-analyzer --extended-times \
 		--summary --ns > "$out"
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+	check_exec_0 "perf script -i ${perfdata} task-analyzer \
 		--extended-times \
 		--summary \
 		--ns"
@@ -152,34 +142,34 @@ test_extended_times_summary_ns() {
 }
=20
 test_csv() {
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" --csv "${csv}" =
> /dev/null
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} --c=
sv ${csv}"
+	perf script -i "${perfdata}" task-analyzer --csv "${csv}" > /dev/null
+	check_exec_0 "perf script -i ${perfdata} task-analyzer --csv ${csv}"
 	find_str_or_fail "Comm;" "${csv}" "${FUNCNAME[0]}"
 }
=20
 test_csv_extended_times() {
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+	perf script -i "${perfdata}" task-analyzer \
 		--csv "${csv}" \
 		--extended-times > /dev/null
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+	check_exec_0 "perf script -i ${perfdata} task-analyzer \
 		--csv ${csv} \
 		--extended-times"
 	find_str_or_fail "Out-Out;" "${csv}" "${FUNCNAME[0]}"
 }
=20
 test_csvsummary() {
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+	perf script -i "${perfdata}" task-analyzer \
 		--csv-summary "${csvsummary}" > /dev/null
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+	check_exec_0 "perf script -i ${perfdata} task-analyzer \
 		--csv-summary ${csvsummary}"
 	find_str_or_fail "Comm;" "${csvsummary}" "${FUNCNAME[0]}"
 }
=20
 test_csvsummary_extended() {
-	$PYTHON $perfdir/python/task-analyzer.py -i "${perfdata}" \
+	perf script -i "${perfdata}" task-analyzer \
 		--csv-summary "${csvsummary}" --summary-extended \
 	>/dev/null
-	check_exec_0 "$PYTHON $perfdir/python/task-analyzer.py -i ${perfdata} \
+	check_exec_0 "perf script -i ${perfdata} task-analyzer \
 		--csv-summary ${csvsummary} --summary-extended"
 	find_str_or_fail "Out-Out;" "${csvsummary}" "${FUNCNAME[0]}"
 }
diff --git a/tools/perf/tests/shell/test_wakeup_latency_python.sh b/tools/p=
erf/tests/shell/test_wakeup_latency_python.sh
index fc39ac117609..cb2571449168 100755
--- a/tools/perf/tests/shell/test_wakeup_latency_python.sh
+++ b/tools/perf/tests/shell/test_wakeup_latency_python.sh
@@ -57,7 +57,7 @@ if [ ! -s "${temp_data}" ]; then
 fi
=20
 # Check that the script executes
-if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+if ! perf script wakeup-latency -i "${temp_data}" > "${temp_out}"; then
 	echo "wakeup-latency.py test failed"
 	err=3D1
 else
@@ -71,7 +71,7 @@ fi
=20
 # Also test zero-wakeups / unhandled events path to verify division-by-zer=
o protection
 if perf record -e cycles -o "${temp_data}" -- perf test -w noploop >/dev/n=
ull 2>&1; then
-	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}" || \
+	if ! perf script wakeup-latency -i "${temp_data}" > "${temp_out}" || \
 	   ! grep -q "avg_wakeup_latency (ns): N/A" "${temp_out}"; then
 		echo "wakeup-latency zero-wakeups guard test failed"
 		err=3D1
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scri=
pts.c
index b8a3383ec02a..d6d09b4a348c 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -86,75 +86,6 @@ static int scripts_config(const char *var, const char *v=
alue, void *data)
 	return 0;
 }
=20
-/*
- * Some scripts specify the required events in their "xxx-record" file,
- * this function will check if the events in perf.data match those
- * mentioned in the "xxx-record".
- *
- * Fixme: All existing "xxx-record" are all in good formats "-e event ",
- * which is covered well now. And new parsing code should be added to
- * cover the future complex formats like event groups etc.
- */
-static int check_ev_match(int dir_fd, const char *scriptname, struct perf_=
session *session)
-{
-	char line[BUFSIZ];
-	FILE *fp;
-
-	{
-		char filename[NAME_MAX + 5];
-		int fd;
-
-		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
-		fd =3D openat(dir_fd, filename, O_RDONLY);
-		if (fd =3D=3D -1)
-			return -1;
-		fp =3D fdopen(fd, "r");
-		if (!fp)
-			return -1;
-	}
-
-	while (fgets(line, sizeof(line), fp)) {
-		char *p =3D skip_spaces(line);
-
-		if (*p =3D=3D '#')
-			continue;
-
-		while (strlen(p)) {
-			int match, len;
-			struct evsel *pos;
-			char evname[128];
-
-			p =3D strstr(p, "-e");
-			if (!p)
-				break;
-
-			p +=3D 2;
-			p =3D skip_spaces(p);
-			len =3D strcspn(p, " \t");
-			if (!len)
-				break;
-
-			snprintf(evname, sizeof(evname), "%.*s", (int)len, p);
-
-			match =3D 0;
-			evlist__for_each_entry(session->evlist, pos) {
-				if (evsel__name_is(pos, evname)) {
-					match =3D 1;
-					break;
-				}
-			}
-
-			if (!match) {
-				fclose(fp);
-				return -1;
-			}
-		}
-	}
-
-	fclose(fp);
-	return 0;
-}
-
 /*
  * Return -1 if none is found, otherwise the actual scripts number.
  *
@@ -162,95 +93,18 @@ static int check_ev_match(int dir_fd, const char *scri=
ptname, struct perf_sessio
  * will list all statically runnable scripts, select one, execute it and
  * show the output in a perf browser.
  */
-static int find_scripts(char **scripts_array, char **scripts_path_array, i=
nt num,
-		 int pathlen)
+static int find_scripts(char **scripts_array __maybe_unused,
+		 char **scripts_path_array __maybe_unused, int num __maybe_unused,
+		 int pathlen __maybe_unused)
 {
-	int namelen;
-	struct dirent *script_dirent, *lang_dirent;
-	int scripts_dir_fd, lang_dir_fd;
-	DIR *scripts_dir, *lang_dir;
-	struct perf_session *session;
-	struct perf_data data =3D {
-		.path =3D input_name,
-		.mode =3D PERF_DATA_MODE_READ,
-	};
-	char *temp;
 	int i =3D 0;
-	const char *exec_path =3D get_argv_exec_path();
-
-	session =3D perf_session__new(&data, NULL);
-	if (IS_ERR(session))
-		return PTR_ERR(session);
-
-	{
-		char scripts_path[PATH_MAX];
-
-		snprintf(scripts_path, sizeof(scripts_path), "%s/scripts", exec_path);
-		scripts_dir_fd =3D open(scripts_path, O_DIRECTORY);
-	}
-	if (scripts_dir_fd !=3D -1) {
-		scripts_dir =3D fdopendir(scripts_dir_fd);
-		if (scripts_dir) {
-			while ((lang_dirent =3D readdir(scripts_dir)) !=3D NULL) {
-				if (lang_dirent->d_type !=3D DT_DIR &&
-				    (lang_dirent->d_type =3D=3D DT_UNKNOWN &&
-				     !is_directory_at(scripts_dir_fd, lang_dirent->d_name)))
-					continue;
-				if (!strcmp(lang_dirent->d_name, ".") ||
-				    !strcmp(lang_dirent->d_name, ".."))
-					continue;
-
-				if (strstr(lang_dirent->d_name, "python"))
-					continue;
-
-				lang_dir_fd =3D openat(scripts_dir_fd, lang_dirent->d_name,
-					     O_DIRECTORY);
-				if (lang_dir_fd =3D=3D -1)
-					continue;
-				lang_dir =3D fdopendir(lang_dir_fd);
-				if (!lang_dir) {
-					close(lang_dir_fd);
-					continue;
-				}
-				while ((script_dirent =3D readdir(lang_dir)) !=3D NULL) {
-					if (script_dirent->d_type =3D=3D DT_DIR)
-						continue;
-					if (script_dirent->d_type =3D=3D DT_UNKNOWN &&
-					    is_directory_at(lang_dir_fd, script_dirent->d_name))
-						continue;
-					/* Skip those real time scripts: xxxtop.p[yl] */
-					if (strstr(script_dirent->d_name, "top."))
-						continue;
-					if (i >=3D num)
-						break;
-					scnprintf(scripts_path_array[i], pathlen,
-						  "%s/scripts/%s/%s", exec_path,
-						  lang_dirent->d_name,
-						  script_dirent->d_name);
-					temp =3D strrchr(script_dirent->d_name, '.');
-					namelen =3D temp ? (int)(temp - script_dirent->d_name)
-							       : (int)strlen(script_dirent->d_name);
-
-					if (namelen >=3D SCRIPT_NAMELEN)
-						namelen =3D SCRIPT_NAMELEN - 1;
-					snprintf(scripts_array[i], namelen + 1, "%s",
-						 script_dirent->d_name);
-
-					if (check_ev_match(lang_dir_fd, scripts_array[i], session))
-						continue;
-
-					i++;
-				}
-				closedir(lang_dir);
-			}
-			closedir(scripts_dir);
-		} else {
-			close(scripts_dir_fd);
-		}
-	}
=20
 #ifdef HAVE_PYTHON_MODULE_SUPPORT
 	{
+		int namelen;
+		struct dirent *script_dirent;
+		char *temp;
+		const char *exec_path =3D get_argv_exec_path();
 		char py_scripts_path[PATH_MAX];
 		int py_scripts_dir_fd;
 		DIR *py_scripts_dir;
@@ -299,7 +153,6 @@ static int find_scripts(char **scripts_array, char **sc=
ripts_path_array, int num
 		}
 	}
 #endif
-	perf_session__delete(session);
 	return i;
 }
=20
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index afcf98dc5006..512f2ca0cd1a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -95,7 +95,6 @@ perf-util-y +=3D tool_pmu.o
 perf-util-y +=3D tp_pmu.o
 perf-util-y +=3D svghelper.o
 perf-util-y +=3D trace-event-info.o
-perf-util-y +=3D trace-event-scripting.o
 perf-util-$(CONFIG_LIBTRACEEVENT) +=3D trace-event.o
 perf-util-$(CONFIG_LIBTRACEEVENT) +=3D trace-event-parse.o
 perf-util-$(CONFIG_LIBTRACEEVENT) +=3D trace-event-read.o
@@ -236,8 +235,6 @@ endif
=20
 perf-util-y +=3D data-convert-json.o
=20
-perf-util-y +=3D scripting-engines/
-
 perf-util-$(CONFIG_ZLIB) +=3D zlib.o
 perf-util-$(CONFIG_LZMA) +=3D lzma.o
 perf-util-$(CONFIG_ZSTD) +=3D zstd.o
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scri=
pting-engines/Build
deleted file mode 100644
index 3f1dc10526f8..000000000000
--- a/tools/perf/util/scripting-engines/Build
+++ /dev/null
@@ -1,5 +0,0 @@
-ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-util-$(CONFIG_LIBPERL)   +=3D trace-event-perl.o
-endif
-
-CFLAGS_trace-event-perl.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -=
Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs=
 -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-aft=
er-statement -Wno-switch-enum -Wno-thread-safety-analysis
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/p=
erf/util/scripting-engines/trace-event-perl.c
deleted file mode 100644
index 410dc4cd0600..000000000000
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ /dev/null
@@ -1,770 +0,0 @@
-/*
- * trace-event-perl.  Feed perf script events to an embedded Perl interpre=
ter.
- *
- * Copyright (C) 2009 Tom Zanussi <tzanussi@gmail.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
- *
- */
-
-#include <inttypes.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <ctype.h>
-#include <errno.h>
-#include <linux/bitmap.h>
-#include <linux/time64.h>
-#include <event-parse.h>
-
-#include <stdbool.h>
-/* perl needs the following define, right after including stdbool.h */
-#define HAS_BOOL
-#include <EXTERN.h>
-#include <perl.h>
-
-#include "../callchain.h"
-#include "../dso.h"
-#include "../machine.h"
-#include "../map.h"
-#include "../symbol.h"
-#include "../thread.h"
-#include "../event.h"
-#include "../trace-event.h"
-#include "../evsel.h"
-#include "../debug.h"
-
-void boot_Perf__Trace__Context(pTHX_ CV *cv);
-void boot_DynaLoader(pTHX_ CV *cv);
-typedef PerlInterpreter * INTERP;
-
-void xs_init(pTHX);
-
-void xs_init(pTHX)
-{
-	const char *file =3D __FILE__;
-	dXSUB_SYS;
-
-	newXS("Perf::Trace::Context::bootstrap", boot_Perf__Trace__Context,
-	      file);
-	newXS("DynaLoader::boot_DynaLoader", boot_DynaLoader, file);
-}
-
-INTERP my_perl;
-
-#define TRACE_EVENT_TYPE_MAX				\
-	((1 << (sizeof(unsigned short) * 8)) - 1)
-
-extern struct scripting_context *scripting_context;
-
-static char *cur_field_name;
-static int zero_flag_atom;
-
-static void define_symbolic_value(const char *ev_name,
-				  const char *field_name,
-				  const char *field_value,
-				  const char *field_str)
-{
-	unsigned long long value;
-	dSP;
-
-	value =3D eval_flag(field_value);
-
-	ENTER;
-	SAVETMPS;
-	PUSHMARK(SP);
-
-	XPUSHs(sv_2mortal(newSVpv(ev_name, 0)));
-	XPUSHs(sv_2mortal(newSVpv(field_name, 0)));
-	XPUSHs(sv_2mortal(newSVuv(value)));
-	XPUSHs(sv_2mortal(newSVpv(field_str, 0)));
-
-	PUTBACK;
-	if (get_cv("main::define_symbolic_value", 0))
-		call_pv("main::define_symbolic_value", G_SCALAR);
-	SPAGAIN;
-	PUTBACK;
-	FREETMPS;
-	LEAVE;
-}
-
-static void define_symbolic_values(struct tep_print_flag_sym *field,
-				   const char *ev_name,
-				   const char *field_name)
-{
-	define_symbolic_value(ev_name, field_name, field->value, field->str);
-	if (field->next)
-		define_symbolic_values(field->next, ev_name, field_name);
-}
-
-static void define_symbolic_field(const char *ev_name,
-				  const char *field_name)
-{
-	dSP;
-
-	ENTER;
-	SAVETMPS;
-	PUSHMARK(SP);
-
-	XPUSHs(sv_2mortal(newSVpv(ev_name, 0)));
-	XPUSHs(sv_2mortal(newSVpv(field_name, 0)));
-
-	PUTBACK;
-	if (get_cv("main::define_symbolic_field", 0))
-		call_pv("main::define_symbolic_field", G_SCALAR);
-	SPAGAIN;
-	PUTBACK;
-	FREETMPS;
-	LEAVE;
-}
-
-static void define_flag_value(const char *ev_name,
-			      const char *field_name,
-			      const char *field_value,
-			      const char *field_str)
-{
-	unsigned long long value;
-	dSP;
-
-	value =3D eval_flag(field_value);
-
-	ENTER;
-	SAVETMPS;
-	PUSHMARK(SP);
-
-	XPUSHs(sv_2mortal(newSVpv(ev_name, 0)));
-	XPUSHs(sv_2mortal(newSVpv(field_name, 0)));
-	XPUSHs(sv_2mortal(newSVuv(value)));
-	XPUSHs(sv_2mortal(newSVpv(field_str, 0)));
-
-	PUTBACK;
-	if (get_cv("main::define_flag_value", 0))
-		call_pv("main::define_flag_value", G_SCALAR);
-	SPAGAIN;
-	PUTBACK;
-	FREETMPS;
-	LEAVE;
-}
-
-static void define_flag_values(struct tep_print_flag_sym *field,
-			       const char *ev_name,
-			       const char *field_name)
-{
-	define_flag_value(ev_name, field_name, field->value, field->str);
-	if (field->next)
-		define_flag_values(field->next, ev_name, field_name);
-}
-
-static void define_flag_field(const char *ev_name,
-			      const char *field_name,
-			      const char *delim)
-{
-	dSP;
-
-	ENTER;
-	SAVETMPS;
-	PUSHMARK(SP);
-
-	XPUSHs(sv_2mortal(newSVpv(ev_name, 0)));
-	XPUSHs(sv_2mortal(newSVpv(field_name, 0)));
-	XPUSHs(sv_2mortal(newSVpv(delim, 0)));
-
-	PUTBACK;
-	if (get_cv("main::define_flag_field", 0))
-		call_pv("main::define_flag_field", G_SCALAR);
-	SPAGAIN;
-	PUTBACK;
-	FREETMPS;
-	LEAVE;
-}
-
-static void define_event_symbols(struct tep_event *event,
-				 const char *ev_name,
-				 struct tep_print_arg *args)
-{
-	if (args =3D=3D NULL)
-		return;
-
-	switch (args->type) {
-	case TEP_PRINT_NULL:
-		break;
-	case TEP_PRINT_ATOM:
-		define_flag_value(ev_name, cur_field_name, "0",
-				  args->atom.atom);
-		zero_flag_atom =3D 0;
-		break;
-	case TEP_PRINT_FIELD:
-		free(cur_field_name);
-		cur_field_name =3D strdup(args->field.name);
-		break;
-	case TEP_PRINT_FLAGS:
-		define_event_symbols(event, ev_name, args->flags.field);
-		define_flag_field(ev_name, cur_field_name, args->flags.delim);
-		define_flag_values(args->flags.flags, ev_name, cur_field_name);
-		break;
-	case TEP_PRINT_SYMBOL:
-		define_event_symbols(event, ev_name, args->symbol.field);
-		define_symbolic_field(ev_name, cur_field_name);
-		define_symbolic_values(args->symbol.symbols, ev_name,
-				       cur_field_name);
-		break;
-	case TEP_PRINT_HEX:
-	case TEP_PRINT_HEX_STR:
-		define_event_symbols(event, ev_name, args->hex.field);
-		define_event_symbols(event, ev_name, args->hex.size);
-		break;
-	case TEP_PRINT_INT_ARRAY:
-		define_event_symbols(event, ev_name, args->int_array.field);
-		define_event_symbols(event, ev_name, args->int_array.count);
-		define_event_symbols(event, ev_name, args->int_array.el_size);
-		break;
-	case TEP_PRINT_BSTRING:
-	case TEP_PRINT_DYNAMIC_ARRAY:
-	case TEP_PRINT_DYNAMIC_ARRAY_LEN:
-	case TEP_PRINT_STRING:
-	case TEP_PRINT_BITMASK:
-		break;
-	case TEP_PRINT_TYPE:
-		define_event_symbols(event, ev_name, args->typecast.item);
-		break;
-	case TEP_PRINT_OP:
-		if (strcmp(args->op.op, ":") =3D=3D 0)
-			zero_flag_atom =3D 1;
-		define_event_symbols(event, ev_name, args->op.left);
-		define_event_symbols(event, ev_name, args->op.right);
-		break;
-	case TEP_PRINT_FUNC:
-	default:
-		pr_err("Unsupported print arg type\n");
-		/* we should warn... */
-		return;
-	}
-
-	if (args->next)
-		define_event_symbols(event, ev_name, args->next);
-}
-
-static SV *perl_process_callchain(struct perf_sample *sample,
-				  struct addr_location *al)
-{
-	struct callchain_cursor *cursor;
-	AV *list;
-
-	list =3D newAV();
-	if (!list)
-		goto exit;
-
-	if (!symbol_conf.use_callchain || !sample->callchain)
-		goto exit;
-
-	cursor =3D get_tls_callchain_cursor();
-
-	if (thread__resolve_callchain(al->thread, cursor,
-				      sample, NULL, NULL, scripting_max_stack) !=3D 0) {
-		pr_err("Failed to resolve callchain. Skipping\n");
-		goto exit;
-	}
-	callchain_cursor_commit(cursor);
-
-
-	while (1) {
-		HV *elem;
-		struct callchain_cursor_node *node;
-		node =3D callchain_cursor_current(cursor);
-		if (!node)
-			break;
-
-		elem =3D newHV();
-		if (!elem)
-			goto exit;
-
-		if (!hv_stores(elem, "ip", newSVuv(node->ip))) {
-			hv_undef(elem);
-			goto exit;
-		}
-
-		if (node->ms.sym) {
-			HV *sym =3D newHV();
-			if (!sym) {
-				hv_undef(elem);
-				goto exit;
-			}
-			if (!hv_stores(sym, "start",   newSVuv(node->ms.sym->start)) ||
-			    !hv_stores(sym, "end",     newSVuv(node->ms.sym->end)) ||
-			    !hv_stores(sym, "binding", newSVuv(symbol__binding(node->ms.sym))) =
||
-			    !hv_stores(sym, "name",    newSVpvn(node->ms.sym->name,
-								node->ms.sym->namelen)) ||
-			    !hv_stores(elem, "sym",    newRV_noinc((SV*)sym))) {
-				hv_undef(sym);
-				hv_undef(elem);
-				goto exit;
-			}
-		}
-
-		if (node->ms.map) {
-			struct map *map =3D node->ms.map;
-			struct dso *dso =3D map ? map__dso(map) : NULL;
-			const char *dsoname =3D "[unknown]";
-
-			if (dso) {
-				if (symbol_conf.show_kernel_path && dso__long_name(dso))
-					dsoname =3D dso__long_name(dso);
-				else
-					dsoname =3D dso__name(dso);
-			}
-			if (!hv_stores(elem, "dso", newSVpv(dsoname,0))) {
-				hv_undef(elem);
-				goto exit;
-			}
-		}
-
-		callchain_cursor_advance(cursor);
-		av_push(list, newRV_noinc((SV*)elem));
-	}
-
-exit:
-	return newRV_noinc((SV*)list);
-}
-
-static void perl_process_tracepoint(struct perf_sample *sample,
-				    struct addr_location *al)
-{
-	struct thread *thread =3D al->thread;
-	struct tep_event *event;
-	struct tep_format_field *field;
-	static char handler[256];
-	unsigned long long val;
-	unsigned long s, ns;
-	int pid;
-	int cpu =3D sample->cpu;
-	void *data =3D sample->raw_data;
-	unsigned long long nsecs =3D sample->time;
-	const char *comm =3D thread__comm_str(thread);
-	DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
-	struct evsel *evsel =3D sample->evsel;
-
-	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
-	dSP;
-
-	if (evsel->core.attr.type !=3D PERF_TYPE_TRACEPOINT)
-		return;
-
-	event =3D evsel__tp_format(evsel);
-	if (!event) {
-		pr_debug("ug! no event found for type %" PRIu64, (u64)evsel->core.attr.c=
onfig);
-		return;
-	}
-
-	pid =3D raw_field_value(event, "common_pid", data);
-
-	sprintf(handler, "%s::%s", event->system, event->name);
-
-	if (!__test_and_set_bit(event->id, events_defined))
-		define_event_symbols(event, handler, event->print_fmt.args);
-
-	s =3D nsecs / NSEC_PER_SEC;
-	ns =3D nsecs - s * NSEC_PER_SEC;
-
-	ENTER;
-	SAVETMPS;
-	PUSHMARK(SP);
-
-	XPUSHs(sv_2mortal(newSVpv(handler, 0)));
-	XPUSHs(sv_2mortal(newSViv(PTR2IV(scripting_context))));
-	XPUSHs(sv_2mortal(newSVuv(cpu)));
-	XPUSHs(sv_2mortal(newSVuv(s)));
-	XPUSHs(sv_2mortal(newSVuv(ns)));
-	XPUSHs(sv_2mortal(newSViv(pid)));
-	XPUSHs(sv_2mortal(newSVpv(comm, 0)));
-	XPUSHs(sv_2mortal(perl_process_callchain(sample, al)));
-
-	/* common fields other than pid can be accessed via xsub fns */
-
-	for (field =3D event->format.fields; field; field =3D field->next) {
-		if (field->flags & TEP_FIELD_IS_STRING) {
-			int offset;
-			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
-				offset =3D *(int *)(data + field->offset);
-				offset &=3D 0xffff;
-				if (tep_field_is_relative(field->flags))
-					offset +=3D field->offset + field->size;
-			} else
-				offset =3D field->offset;
-			XPUSHs(sv_2mortal(newSVpv((char *)data + offset, 0)));
-		} else { /* FIELD_IS_NUMERIC */
-			val =3D read_size(event, data + field->offset,
-					field->size);
-			if (field->flags & TEP_FIELD_IS_SIGNED) {
-				XPUSHs(sv_2mortal(newSViv(val)));
-			} else {
-				XPUSHs(sv_2mortal(newSVuv(val)));
-			}
-		}
-	}
-
-	PUTBACK;
-
-	if (get_cv(handler, 0))
-		call_pv(handler, G_SCALAR);
-	else if (get_cv("main::trace_unhandled", 0)) {
-		XPUSHs(sv_2mortal(newSVpv(handler, 0)));
-		XPUSHs(sv_2mortal(newSViv(PTR2IV(scripting_context))));
-		XPUSHs(sv_2mortal(newSVuv(cpu)));
-		XPUSHs(sv_2mortal(newSVuv(nsecs)));
-		XPUSHs(sv_2mortal(newSViv(pid)));
-		XPUSHs(sv_2mortal(newSVpv(comm, 0)));
-		XPUSHs(sv_2mortal(perl_process_callchain(sample, al)));
-		call_pv("main::trace_unhandled", G_SCALAR);
-	}
-	SPAGAIN;
-	PUTBACK;
-	FREETMPS;
-	LEAVE;
-}
-
-static void perl_process_event_generic(union perf_event *event, struct per=
f_sample *sample)
-{
-	dSP;
-
-	if (!get_cv("process_event", 0))
-		return;
-
-	ENTER;
-	SAVETMPS;
-	PUSHMARK(SP);
-	XPUSHs(sv_2mortal(newSVpvn((const char *)event, event->header.size)));
-	XPUSHs(sv_2mortal(newSVpvn((const char *)&sample->evsel->core.attr,
-				   sizeof(sample->evsel->core.attr))));
-	XPUSHs(sv_2mortal(newSVpvn((const char *)sample, sizeof(*sample))));
-	XPUSHs(sv_2mortal(newSVpvn((const char *)sample->raw_data, sample->raw_si=
ze)));
-	PUTBACK;
-	call_pv("process_event", G_SCALAR);
-	SPAGAIN;
-	PUTBACK;
-	FREETMPS;
-	LEAVE;
-}
-
-static void perl_process_event(union perf_event *event,
-			       struct perf_sample *sample,
-			       struct addr_location *al,
-			       struct addr_location *addr_al)
-{
-	scripting_context__update(scripting_context, event, sample, al, addr_al);
-	perl_process_tracepoint(sample, al);
-	perl_process_event_generic(event, sample);
-}
-
-static void run_start_sub(void)
-{
-	dSP; /* access to Perl stack */
-	PUSHMARK(SP);
-
-	if (get_cv("main::trace_begin", 0))
-		call_pv("main::trace_begin", G_DISCARD | G_NOARGS);
-}
-
-/*
- * Start trace script
- */
-static int perl_start_script(const char *script, int argc, const char **ar=
gv,
-			     struct perf_session *session)
-{
-	const char **command_line;
-	int i, err =3D 0;
-
-	scripting_context->session =3D session;
-
-	command_line =3D malloc((argc + 2) * sizeof(const char *));
-	if (!command_line)
-		return -ENOMEM;
-
-	command_line[0] =3D "";
-	command_line[1] =3D script;
-	for (i =3D 2; i < argc + 2; i++)
-		command_line[i] =3D argv[i - 2];
-
-	my_perl =3D perl_alloc();
-	perl_construct(my_perl);
-
-	if (perl_parse(my_perl, xs_init, argc + 2, (char **)command_line,
-		       (char **)NULL)) {
-		err =3D -1;
-		goto error;
-	}
-
-	if (perl_run(my_perl)) {
-		err =3D -1;
-		goto error;
-	}
-
-	if (SvTRUE(ERRSV)) {
-		err =3D -1;
-		goto error;
-	}
-
-	run_start_sub();
-
-	free(command_line);
-	return 0;
-error:
-	perl_free(my_perl);
-	free(command_line);
-
-	return err;
-}
-
-static int perl_flush_script(void)
-{
-	return 0;
-}
-
-/*
- * Stop trace script
- */
-static int perl_stop_script(void)
-{
-	dSP; /* access to Perl stack */
-	PUSHMARK(SP);
-
-	if (get_cv("main::trace_end", 0))
-		call_pv("main::trace_end", G_DISCARD | G_NOARGS);
-
-	perl_destruct(my_perl);
-	perl_free(my_perl);
-
-	return 0;
-}
-
-static int perl_generate_script(struct tep_handle *pevent, const char *out=
file)
-{
-	int i, not_first, count, nr_events;
-	struct tep_event **all_events;
-	struct tep_event *event =3D NULL;
-	struct tep_format_field *f;
-	char fname[PATH_MAX];
-	FILE *ofp;
-
-	sprintf(fname, "%s.pl", outfile);
-	ofp =3D fopen(fname, "w");
-	if (ofp =3D=3D NULL) {
-		fprintf(stderr, "couldn't open %s\n", fname);
-		return -1;
-	}
-
-	fprintf(ofp, "# perf script event handlers, "
-		"generated by perf script -g perl\n");
-
-	fprintf(ofp, "# Licensed under the terms of the GNU GPL"
-		" License version 2\n\n");
-
-	fprintf(ofp, "# The common_* event handler fields are the most useful "
-		"fields common to\n");
-
-	fprintf(ofp, "# all events.  They don't necessarily correspond to "
-		"the 'common_*' fields\n");
-
-	fprintf(ofp, "# in the format files.  Those fields not available as "
-		"handler params can\n");
-
-	fprintf(ofp, "# be retrieved using Perl functions of the form "
-		"common_*($context).\n");
-
-	fprintf(ofp, "# See Context.pm for the list of available "
-		"functions.\n\n");
-
-	fprintf(ofp, "use lib \"$ENV{'PERF_EXEC_PATH'}/scripts/perl/"
-		"Perf-Trace-Util/lib\";\n");
-
-	fprintf(ofp, "use lib \"./Perf-Trace-Util/lib\";\n");
-	fprintf(ofp, "use Perf::Trace::Core;\n");
-	fprintf(ofp, "use Perf::Trace::Context;\n");
-	fprintf(ofp, "use Perf::Trace::Util;\n\n");
-
-	fprintf(ofp, "sub trace_begin\n{\n\t# optional\n}\n\n");
-	fprintf(ofp, "sub trace_end\n{\n\t# optional\n}\n");
-
-
-	fprintf(ofp, "\n\
-sub print_backtrace\n\
-{\n\
-	my $callchain =3D shift;\n\
-	for my $node (@$callchain)\n\
-	{\n\
-		if(exists $node->{sym})\n\
-		{\n\
-			printf( \"\\t[\\%%x] \\%%s\\n\", $node->{ip}, $node->{sym}{name});\n\
-		}\n\
-		else\n\
-		{\n\
-			printf( \"\\t[\\%%x]\\n\", $node{ip});\n\
-		}\n\
-	}\n\
-}\n\n\
-");
-
-	nr_events =3D tep_get_events_count(pevent);
-	all_events =3D tep_list_events(pevent, TEP_EVENT_SORT_ID);
-
-	for (i =3D 0; all_events && i < nr_events; i++) {
-		event =3D all_events[i];
-		fprintf(ofp, "sub %s::%s\n{\n", event->system, event->name);
-		fprintf(ofp, "\tmy (");
-
-		fprintf(ofp, "$event_name, ");
-		fprintf(ofp, "$context, ");
-		fprintf(ofp, "$common_cpu, ");
-		fprintf(ofp, "$common_secs, ");
-		fprintf(ofp, "$common_nsecs,\n");
-		fprintf(ofp, "\t    $common_pid, ");
-		fprintf(ofp, "$common_comm, ");
-		fprintf(ofp, "$common_callchain,\n\t    ");
-
-		not_first =3D 0;
-		count =3D 0;
-
-		for (f =3D event->format.fields; f; f =3D f->next) {
-			if (not_first++)
-				fprintf(ofp, ", ");
-			if (++count % 5 =3D=3D 0)
-				fprintf(ofp, "\n\t    ");
-
-			fprintf(ofp, "$%s", f->name);
-		}
-		fprintf(ofp, ") =3D @_;\n\n");
-
-		fprintf(ofp, "\tprint_header($event_name, $common_cpu, "
-			"$common_secs, $common_nsecs,\n\t             "
-			"$common_pid, $common_comm, $common_callchain);\n\n");
-
-		fprintf(ofp, "\tprintf(\"");
-
-		not_first =3D 0;
-		count =3D 0;
-
-		for (f =3D event->format.fields; f; f =3D f->next) {
-			if (not_first++)
-				fprintf(ofp, ", ");
-			if (count && count % 4 =3D=3D 0) {
-				fprintf(ofp, "\".\n\t       \"");
-			}
-			count++;
-
-			fprintf(ofp, "%s=3D", f->name);
-			if (f->flags & TEP_FIELD_IS_STRING ||
-			    f->flags & TEP_FIELD_IS_FLAG ||
-			    f->flags & TEP_FIELD_IS_SYMBOLIC)
-				fprintf(ofp, "%%s");
-			else if (f->flags & TEP_FIELD_IS_SIGNED)
-				fprintf(ofp, "%%d");
-			else
-				fprintf(ofp, "%%u");
-		}
-
-		fprintf(ofp, "\\n\",\n\t       ");
-
-		not_first =3D 0;
-		count =3D 0;
-
-		for (f =3D event->format.fields; f; f =3D f->next) {
-			if (not_first++)
-				fprintf(ofp, ", ");
-
-			if (++count % 5 =3D=3D 0)
-				fprintf(ofp, "\n\t       ");
-
-			if (f->flags & TEP_FIELD_IS_FLAG) {
-				if ((count - 1) % 5 !=3D 0) {
-					fprintf(ofp, "\n\t       ");
-					count =3D 4;
-				}
-				fprintf(ofp, "flag_str(\"");
-				fprintf(ofp, "%s::%s\", ", event->system,
-					event->name);
-				fprintf(ofp, "\"%s\", $%s)", f->name,
-					f->name);
-			} else if (f->flags & TEP_FIELD_IS_SYMBOLIC) {
-				if ((count - 1) % 5 !=3D 0) {
-					fprintf(ofp, "\n\t       ");
-					count =3D 4;
-				}
-				fprintf(ofp, "symbol_str(\"");
-				fprintf(ofp, "%s::%s\", ", event->system,
-					event->name);
-				fprintf(ofp, "\"%s\", $%s)", f->name,
-					f->name);
-			} else
-				fprintf(ofp, "$%s", f->name);
-		}
-
-		fprintf(ofp, ");\n\n");
-
-		fprintf(ofp, "\tprint_backtrace($common_callchain);\n");
-
-		fprintf(ofp, "}\n\n");
-	}
-
-	fprintf(ofp, "sub trace_unhandled\n{\n\tmy ($event_name, $context, "
-		"$common_cpu, $common_secs, $common_nsecs,\n\t    "
-		"$common_pid, $common_comm, $common_callchain) =3D @_;\n\n");
-
-	fprintf(ofp, "\tprint_header($event_name, $common_cpu, "
-		"$common_secs, $common_nsecs,\n\t             $common_pid, "
-		"$common_comm, $common_callchain);\n");
-	fprintf(ofp, "\tprint_backtrace($common_callchain);\n");
-	fprintf(ofp, "}\n\n");
-
-	fprintf(ofp, "sub print_header\n{\n"
-		"\tmy ($event_name, $cpu, $secs, $nsecs, $pid, $comm) =3D @_;\n\n"
-		"\tprintf(\"%%-20s %%5u %%05u.%%09u %%8u %%-20s \",\n\t       "
-		"$event_name, $cpu, $secs, $nsecs, $pid, $comm);\n}\n");
-
-	fprintf(ofp,
-		"\n# Packed byte string args of process_event():\n"
-		"#\n"
-		"# $event:\tunion perf_event\tutil/event.h\n"
-		"# $attr:\tstruct perf_event_attr\tlinux/perf_event.h\n"
-		"# $sample:\tstruct perf_sample\tutil/event.h\n"
-		"# $raw_data:\tperf_sample->raw_data\tutil/event.h\n"
-		"\n"
-		"sub process_event\n"
-		"{\n"
-		"\tmy ($event, $attr, $sample, $raw_data) =3D @_;\n"
-		"\n"
-		"\tmy @event\t=3D unpack(\"LSS\", $event);\n"
-		"\tmy @attr\t=3D unpack(\"LLQQQQQLLQQ\", $attr);\n"
-		"\tmy @sample\t=3D unpack(\"QLLQQQQQLL\", $sample);\n"
-		"\tmy @raw_data\t=3D unpack(\"C*\", $raw_data);\n"
-		"\n"
-		"\tuse Data::Dumper;\n"
-		"\tprint Dumper \\@event, \\@attr, \\@sample, \\@raw_data;\n"
-		"}\n");
-
-	fclose(ofp);
-
-	fprintf(stderr, "generated Perl script: %s\n", fname);
-
-	return 0;
-}
-
-struct scripting_ops perl_scripting_ops =3D {
-	.name =3D "Perl",
-	.dirname =3D "perl",
-	.start_script =3D perl_start_script,
-	.flush_script =3D perl_flush_script,
-	.stop_script =3D perl_stop_script,
-	.process_event =3D perl_process_event,
-	.generate_script =3D perl_generate_script,
-};
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-ev=
ent-parse.c
index 9c015fc2bcfb..374cf82fd86e 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -14,71 +14,6 @@
 #include <linux/kernel.h>
 #include <event-parse.h>
=20
-static int get_common_field(struct scripting_context *context,
-			    int *offset, int *size, const char *type)
-{
-	struct tep_handle *pevent =3D context->pevent;
-	struct tep_event *event;
-	struct tep_format_field *field;
-
-	if (!*size) {
-
-		event =3D tep_get_first_event(pevent);
-		if (!event)
-			return 0;
-
-		field =3D tep_find_common_field(event, type);
-		if (!field)
-			return 0;
-		*offset =3D field->offset;
-		*size =3D field->size;
-	}
-
-	return tep_read_number(pevent, context->event_data + *offset, *size);
-}
-
-int common_lock_depth(struct scripting_context *context)
-{
-	static int offset;
-	static int size;
-	int ret;
-
-	ret =3D get_common_field(context, &size, &offset,
-			       "common_lock_depth");
-	if (ret < 0)
-		return -1;
-
-	return ret;
-}
-
-int common_flags(struct scripting_context *context)
-{
-	static int offset;
-	static int size;
-	int ret;
-
-	ret =3D get_common_field(context, &size, &offset,
-			       "common_flags");
-	if (ret < 0)
-		return -1;
-
-	return ret;
-}
-
-int common_pc(struct scripting_context *context)
-{
-	static int offset;
-	static int size;
-	int ret;
-
-	ret =3D get_common_field(context, &size, &offset,
-			       "common_preempt_count");
-	if (ret < 0)
-		return -1;
-
-	return ret;
-}
-
 unsigned long long
 raw_field_value(struct tep_event *event, const char *name, void *data)
 {
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trac=
e-event-scripting.c
deleted file mode 100644
index c78b317978dd..000000000000
--- a/tools/perf/util/trace-event-scripting.c
+++ /dev/null
@@ -1,398 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * trace-event-scripting.  Scripting engine common and initialization code=
.
- *
- * Copyright (C) 2009-2010 Tom Zanussi <tzanussi@gmail.com>
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
-
-#include "debug.h"
-#include "event.h"
-#include "trace-event.h"
-#include "evsel.h"
-#include <linux/perf_event.h>
-#include <linux/zalloc.h>
-#include "util/sample.h"
-
-unsigned int scripting_max_stack =3D PERF_MAX_STACK_DEPTH;
-
-struct scripting_context *scripting_context;
-
-struct script_spec {
-	struct list_head	node;
-	struct scripting_ops	*ops;
-	char			spec[];
-};
-
-static LIST_HEAD(script_specs);
-
-static struct script_spec *script_spec__new(const char *spec,
-					    struct scripting_ops *ops)
-{
-	struct script_spec *s =3D malloc(sizeof(*s) + strlen(spec) + 1);
-
-	if (s !=3D NULL) {
-		strcpy(s->spec, spec);
-		s->ops =3D ops;
-	}
-
-	return s;
-}
-
-static void script_spec__add(struct script_spec *s)
-{
-	list_add_tail(&s->node, &script_specs);
-}
-
-static struct script_spec *script_spec__find(const char *spec)
-{
-	struct script_spec *s;
-
-	list_for_each_entry(s, &script_specs, node)
-		if (strcasecmp(s->spec, spec) =3D=3D 0)
-			return s;
-	return NULL;
-}
-
-static int script_spec_register(const char *spec, struct scripting_ops *op=
s)
-{
-	struct script_spec *s;
-
-	s =3D script_spec__find(spec);
-	if (s)
-		return -1;
-
-	s =3D script_spec__new(spec, ops);
-	if (!s)
-		return -1;
-
-	script_spec__add(s);
-	return 0;
-}
-
-struct scripting_ops *script_spec__lookup(const char *spec)
-{
-	struct script_spec *s =3D script_spec__find(spec);
-
-	if (!s)
-		return NULL;
-
-	return s->ops;
-}
-
-int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char =
*spec))
-{
-	struct script_spec *s;
-	int ret =3D 0;
-
-	list_for_each_entry(s, &script_specs, node) {
-		ret =3D cb(s->ops, s->spec);
-		if (ret)
-			break;
-	}
-	return ret;
-}
-
-void scripting_context__update(struct scripting_context *c,
-			       union perf_event *event,
-			       struct perf_sample *sample,
-			       struct addr_location *al,
-			       struct addr_location *addr_al)
-{
-#ifdef HAVE_LIBTRACEEVENT
-	const struct tep_event *tp_format =3D evsel__tp_format(sample->evsel);
-
-	c->pevent =3D tp_format ? tp_format->tep : NULL;
-#else
-	c->pevent =3D NULL;
-#endif
-	c->event_data =3D sample->raw_data;
-	c->event =3D event;
-	c->sample =3D sample;
-	c->al =3D al;
-	c->addr_al =3D addr_al;
-}
-
-static int flush_script_unsupported(void)
-{
-	return 0;
-}
-
-static int stop_script_unsupported(void)
-{
-	return 0;
-}
-
-static void process_event_unsupported(union perf_event *event __maybe_unus=
ed,
-				      struct perf_sample *sample __maybe_unused,
-				      struct addr_location *al __maybe_unused,
-				      struct addr_location *addr_al __maybe_unused)
-{
-}
-
-static void print_python_unsupported_msg(void)
-{
-	fprintf(stderr, "Python scripting not supported."
-		"  Install libpython and rebuild perf to enable it.\n"
-		"For example:\n  # apt-get install python-dev (ubuntu)"
-		"\n  # yum install python-devel (Fedora)"
-		"\n  etc.\n");
-}
-
-static int python_start_script_unsupported(const char *script __maybe_unus=
ed,
-					   int argc __maybe_unused,
-					   const char **argv __maybe_unused,
-					   struct perf_session *session __maybe_unused)
-{
-	print_python_unsupported_msg();
-
-	return -1;
-}
-
-static int python_generate_script_unsupported(struct tep_handle *pevent
-					      __maybe_unused,
-					      const char *outfile
-					      __maybe_unused)
-{
-	print_python_unsupported_msg();
-
-	return -1;
-}
-
-struct scripting_ops python_scripting_unsupported_ops =3D {
-	.name =3D "Python",
-	.dirname =3D "python",
-	.start_script =3D python_start_script_unsupported,
-	.flush_script =3D flush_script_unsupported,
-	.stop_script =3D stop_script_unsupported,
-	.process_event =3D process_event_unsupported,
-	.generate_script =3D python_generate_script_unsupported,
-};
-
-static void register_python_scripting(struct scripting_ops *scripting_ops)
-{
-	if (scripting_context =3D=3D NULL)
-		scripting_context =3D malloc(sizeof(*scripting_context));
-
-       if (scripting_context =3D=3D NULL ||
-	   script_spec_register("Python", scripting_ops) ||
-	   script_spec_register("py", scripting_ops)) {
-		pr_err("Error registering Python script extension: disabling it\n");
-		zfree(&scripting_context);
-	}
-}
-
-void setup_python_scripting(void)
-{
-	register_python_scripting(&python_scripting_unsupported_ops);
-}
-
-#ifdef HAVE_LIBTRACEEVENT
-static void print_perl_unsupported_msg(void)
-{
-	fprintf(stderr, "Perl scripting not supported."
-		"  Install libperl and rebuild perf to enable it.\n"
-		"For example:\n  # apt-get install libperl-dev (ubuntu)"
-		"\n  # yum install 'perl(ExtUtils::Embed)' (Fedora)"
-		"\n  etc.\n");
-}
-
-static int perl_start_script_unsupported(const char *script __maybe_unused=
,
-					 int argc __maybe_unused,
-					 const char **argv __maybe_unused,
-					 struct perf_session *session __maybe_unused)
-{
-	print_perl_unsupported_msg();
-
-	return -1;
-}
-
-static int perl_generate_script_unsupported(struct tep_handle *pevent
-					    __maybe_unused,
-					    const char *outfile __maybe_unused)
-{
-	print_perl_unsupported_msg();
-
-	return -1;
-}
-
-struct scripting_ops perl_scripting_unsupported_ops =3D {
-	.name =3D "Perl",
-	.dirname =3D "perl",
-	.start_script =3D perl_start_script_unsupported,
-	.flush_script =3D flush_script_unsupported,
-	.stop_script =3D stop_script_unsupported,
-	.process_event =3D process_event_unsupported,
-	.generate_script =3D perl_generate_script_unsupported,
-};
-
-static void register_perl_scripting(struct scripting_ops *scripting_ops)
-{
-	if (scripting_context =3D=3D NULL)
-		scripting_context =3D malloc(sizeof(*scripting_context));
-
-       if (scripting_context =3D=3D NULL ||
-	   script_spec_register("Perl", scripting_ops) ||
-	   script_spec_register("pl", scripting_ops)) {
-		pr_err("Error registering Perl script extension: disabling it\n");
-		zfree(&scripting_context);
-	}
-}
-
-#ifndef HAVE_LIBPERL_SUPPORT
-void setup_perl_scripting(void)
-{
-	register_perl_scripting(&perl_scripting_unsupported_ops);
-}
-#else
-extern struct scripting_ops perl_scripting_ops;
-
-void setup_perl_scripting(void)
-{
-	register_perl_scripting(&perl_scripting_ops);
-}
-#endif
-#endif
-
-static const struct {
-	u32 flags;
-	const char *name;
-} sample_flags[] =3D {
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
-	{PERF_IP_FLAG_BRANCH, "jmp"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"}=
,
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "ire=
t"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "sysc=
all"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "sy=
sret"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |	PERF_IP_F=
LAG_INTERRUPT,
-	 "hw int"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry=
"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"}=
,
-	{0, NULL}
-};
-
-static const struct {
-	u32 flags;
-	const char *name;
-} branch_events[] =3D {
-	{PERF_IP_FLAG_BRANCH_MISS, "miss"},
-	{PERF_IP_FLAG_NOT_TAKEN, "not_taken"},
-	{0, NULL}
-};
-
-static int sample_flags_to_name(u32 flags, char *str, size_t size)
-{
-	int i;
-	const char *prefix;
-	int pos =3D 0, ret, ev_idx =3D 0;
-	u32 xf =3D flags & PERF_ADDITIONAL_STATE_MASK;
-	u32 types, events;
-	char xs[16] =3D { 0 };
-
-	/* Clear additional state bits */
-	flags &=3D ~PERF_ADDITIONAL_STATE_MASK;
-
-	if (flags & PERF_IP_FLAG_TRACE_BEGIN)
-		prefix =3D "tr strt ";
-	else if (flags & PERF_IP_FLAG_TRACE_END)
-		prefix =3D "tr end  ";
-	else
-		prefix =3D "";
-
-	ret =3D snprintf(str + pos, size - pos, "%s", prefix);
-	if (ret < 0)
-		return ret;
-	pos +=3D ret;
-
-	flags &=3D ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
-
-	types =3D flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
-	for (i =3D 0; sample_flags[i].name; i++) {
-		if (sample_flags[i].flags !=3D types)
-			continue;
-
-		ret =3D snprintf(str + pos, size - pos, "%s", sample_flags[i].name);
-		if (ret < 0)
-			return ret;
-		pos +=3D ret;
-		break;
-	}
-
-	events =3D flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
-	for (i =3D 0; branch_events[i].name; i++) {
-		if (!(branch_events[i].flags & events))
-			continue;
-
-		ret =3D snprintf(str + pos, size - pos, !ev_idx ? "/%s" : ",%s",
-			       branch_events[i].name);
-		if (ret < 0)
-			return ret;
-		pos +=3D ret;
-		ev_idx++;
-	}
-
-	/* Add an end character '/' for events */
-	if (ev_idx) {
-		ret =3D snprintf(str + pos, size - pos, "/");
-		if (ret < 0)
-			return ret;
-		pos +=3D ret;
-	}
-
-	if (!xf)
-		return pos;
-
-	snprintf(xs, sizeof(xs), "(%s%s%s)",
-		 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
-		 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
-		 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
-
-	/* Right align the string if its length is less than the limit */
-	if ((pos + strlen(xs)) < SAMPLE_FLAGS_STR_ALIGNED_SIZE)
-		ret =3D snprintf(str + pos, size - pos, "%*s",
-			       (int)(SAMPLE_FLAGS_STR_ALIGNED_SIZE - ret), xs);
-	else
-		ret =3D snprintf(str + pos, size - pos, " %s", xs);
-	if (ret < 0)
-		return ret;
-
-	return pos + ret;
-}
-
-int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
-{
-	const char *chars =3D PERF_IP_FLAG_CHARS;
-	const size_t n =3D strlen(PERF_IP_FLAG_CHARS);
-	size_t i, pos =3D 0;
-	int ret;
-
-	ret =3D sample_flags_to_name(flags, str, sz);
-	if (ret > 0)
-		return ret;
-
-	for (i =3D 0; i < n; i++, flags >>=3D 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] =3D chars[i];
-	}
-	for (; i < 32; i++, flags >>=3D 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] =3D '?';
-	}
-	if (pos < sz)
-		str[pos] =3D 0;
-
-	return pos;
-}
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 1c342fce36bb..fa3824cf39fa 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -7,15 +7,9 @@
 #include <sys/types.h>
 #include <linux/types.h>
=20
-struct evlist;
 struct machine;
-struct perf_sample;
-union perf_event;
-struct perf_tool;
-struct thread;
-struct tep_plugin_list;
-struct evsel;
 struct tep_format_field;
+struct tep_plugin_list;
=20
 struct trace_event {
 	struct tep_handle	*pevent;
@@ -80,70 +74,6 @@ struct tracing_data *tracing_data_get(struct list_head *=
pattrs,
 				      int fd, bool temp);
 int tracing_data_put(struct tracing_data *tdata);
=20
-
-struct addr_location;
-
-struct perf_session;
-struct perf_stat_config;
-
-struct scripting_ops {
-	const char *name;
-	const char *dirname; /* For script path .../scripts/<dirname>/... */
-	int (*start_script)(const char *script, int argc, const char **argv,
-			    struct perf_session *session);
-	int (*flush_script) (void);
-	int (*stop_script) (void);
-	void (*process_event) (union perf_event *event,
-			       struct perf_sample *sample,
-			       struct addr_location *al,
-			       struct addr_location *addr_al);
-	void (*process_switch)(union perf_event *event,
-			       struct perf_sample *sample,
-			       struct machine *machine);
-	void (*process_auxtrace_error)(struct perf_session *session,
-				       union perf_event *event);
-	void (*process_stat)(struct perf_stat_config *config,
-			     struct evsel *evsel, u64 tstamp);
-	void (*process_stat_interval)(u64 tstamp);
-	void (*process_throttle)(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct machine *machine);
-	int (*generate_script) (struct tep_handle *pevent, const char *outfile);
-};
-
-extern unsigned int scripting_max_stack;
-
-struct scripting_ops *script_spec__lookup(const char *spec);
-int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char =
*spec));
-
-void setup_perl_scripting(void);
-void setup_python_scripting(void);
-
-struct scripting_context {
-	struct tep_handle *pevent;
-	void *event_data;
-	union perf_event *event;
-	struct perf_sample *sample;
-	struct addr_location *al;
-	struct addr_location *addr_al;
-	struct perf_session *session;
-};
-
-void scripting_context__update(struct scripting_context *scripting_context=
,
-			       union perf_event *event,
-			       struct perf_sample *sample,
-			       struct addr_location *al,
-			       struct addr_location *addr_al);
-
-int common_pc(struct scripting_context *context);
-int common_flags(struct scripting_context *context);
-int common_lock_depth(struct scripting_context *context);
-
-#define SAMPLE_FLAGS_BUF_SIZE 64
-#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
-
-int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
-
 #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D MAKE_LIB=
TRACEEVENT_VERSION(1, 5, 0)
 #include <event-parse.h>
=20
--=20
2.56.0.rc1.315.gc6ed9934b7-goog

