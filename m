Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1179314A8C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355568; cv=none; b=Ad+1bdYQPBcXUY0I2htJt62z0Z0UfuUKhYGtEQ/X86PbwgpoT7UNkw1W2jnbv5NfDztGWQfy0f1vbphyyjEpkHJBjRIlrZ+G+kC2Fs7kX4kWpCcLBgzoR0h1ul9A7mTFTDN4NPoW82J+yY2fHIT5X554W0cufs3Jpj5ZGu3cktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355568; c=relaxed/simple;
	bh=Xwquh3bwgFJpE0pIkJGqz/t5r0bKeHXc3Wt80ZhC3M0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Ny6Dmjhdco33CuICi4oS7wxfXH5kY4IFp0spO6EzoZHq/HC7XBTHw9TNMFbGY3itguTt/4D/7VziEPoPR7RWifHiUB+BxezFAWxU+F/kp6TQf1WZwoA77USpGwhIKsHjLkMZ5CS5W2yvFneRkM7yCXza0Iu/35JC2LpjI02loQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gDDp7T+b; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gDDp7T+b"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32bdfd536aeso2663575a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757355566; x=1757960366; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LTH3K3V8fTrwxwbr7ThJRkDjglPD5Yew7cQGt4b8tZs=;
        b=gDDp7T+b9Z2cWcibelyar60Frqt6PMY4KtosPope7z9mjUppEF5jdWsZNzX3ozsi84
         mZDrIj8ObJ5nxb6Do2OMfma8JQOB38rz6FgHSKN9fPT9hT1Yz1+phsB4hi0C7QXiKh0f
         sic6+iRAkXf3bZ2lVevadbfAB0/2/q52Ekt+sHrMto9VU5oyfY8zWs+0xmr2zyx8hUhd
         L3QCCGbGW/9lWl3iwsRvZnfmse7wogTaEl3jQbAi4CR+evt/Ckc/s+MIpjhGJS+CEd2x
         dkTZFD6rZorsFdQba3qGq362YNVbaR/r0nWKAQrkZ51ajP46s56tmogpqYph7P+aWW5K
         JRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355566; x=1757960366;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTH3K3V8fTrwxwbr7ThJRkDjglPD5Yew7cQGt4b8tZs=;
        b=wcrPGluJQOxg/Cl15WHBv3DsGNkGGNh57rNYCHyml6XMR0TcdcTH79taWvFUqh12qJ
         ZyDh4Fwbu5wsCYDd3/UG9TplV9cvH27ZWJkAAZko9sgOo+1ZvpmN2roXGYs+544ABLjJ
         k1RRmbdqWSiU5cW9+MycqoyK5jpuMdobd/S7QN9MfKiQMvWc6ot+0JXyCcam85IZ1s+o
         dvg8Umo2PHjlXC3EP5RSTlJfrGDzzqqHGTlr4MxLzW5d6qZRqQBm5ejnRp0jAvGsC0c+
         rLalDYH9S3hMlHprvpfh0eiPCkQkklYaQJAtkmRw3+1XQpzF3uudV04knbVgyyoOHaWC
         5eng==
X-Forwarded-Encrypted: i=1; AJvYcCUUlYzj3jeV/K42l7r+iXdTTm/JpCTxFiHMF3AGCQjMy7NuUYep5HGije08krtkJb88juuCtNq8GRUGW/0ki4dD@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZexOpwU/rwrQr0cvs4Ymn1TPHDb+mTea8nSpGW2txrZFs95p
	almpj9KLxjhpFMFxtQ8RADN+K18ae/4/jTLJmkmIVJx3yevhV8qEPyu2V86hTNDTYvQwuyc8e6m
	PRyXen8JGjA==
X-Google-Smtp-Source: AGHT+IFrs/zQc+ObXQbqH1OyQ107aiC3ghh/sI1b/bY3PIA0R/bl4RpgH+FbbA6oAuL5S+4BWMpcU/3QyU1a
X-Received: from pjbsy7.prod.google.com ([2002:a17:90b:2d07:b0:327:b430:11ad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2396:b0:32b:b514:3936
 with SMTP id 98e67ed59e1d1-32bbe214925mr12118508a91.13.1757355566230; Mon, 08
 Sep 2025 11:19:26 -0700 (PDT)
Date: Mon,  8 Sep 2025 11:19:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250908181918.3533480-1-irogers@google.com>
Subject: [PATCH v1] tools build: Make libperl opt-in rather than opt-out, deprecate
From: Ian Rogers <irogers@google.com>
To: Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Quentin Monnet <qmo@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If libperl is installed then the perf tool build will build against
it. There appears to be limited interest in the scripting support for
perl so let's make it opt-in and deprecate it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
In the future it would be nice to refactor the python support, for
example, so that perf doesn't steal the main thread which UIs like
textual assume they can have. When such work is done, any equivalent
perl work will be a challenge and it might just be best to delete it.
---
 tools/build/Makefile.feature   |  3 +--
 tools/build/feature/test-all.c |  9 ++-------
 tools/perf/Makefile.config     | 12 +++---------
 tools/perf/Makefile.perf       |  4 ++--
 tools/perf/builtin-check.c     |  2 +-
 tools/perf/tests/make          |  8 ++++----
 6 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 649c5ab8e8f2..9c1a69d26f51 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -80,7 +80,6 @@ FEATURE_TESTS_BASIC :=                  \
         libelf-zstd                     \
         libnuma                         \
         numa_num_possible_cpus          \
-        libperl                         \
         libpython                       \
         libslang                        \
         libtraceevent                   \
@@ -121,6 +120,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
+         libperl                        \
          cxx                            \
          llvm                           \
          clang                          \
@@ -144,7 +144,6 @@ FEATURE_DISPLAY ?=              \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
-         libperl                \
          libpython              \
          libcapstone            \
          llvm-perf              \
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 4419fb4710bd..e1847db6f8e6 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -7,17 +7,13 @@
  */
 
 /*
- * Quirk: Python and Perl headers cannot be in arbitrary places, so keep
- * these 3 testcases at the top:
+ * Quirk: Python headers cannot be in arbitrary places, so keep this testcase at
+ * the top:
  */
 #define main main_test_libpython
 # include "test-libpython.c"
 #undef main
 
-#define main main_test_libperl
-# include "test-libperl.c"
-#undef main
-
 #define main main_test_hello
 # include "test-hello.c"
 #undef main
@@ -161,7 +157,6 @@
 int main(int argc, char *argv[])
 {
 	main_test_libpython();
-	main_test_libperl();
 	main_test_hello();
 	main_test_libelf();
 	main_test_get_current_dir_name();
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53..0f4b297fbacc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -817,9 +817,7 @@ ifdef GTK2
   endif
 endif
 
-ifdef NO_LIBPERL
-  CFLAGS += -DNO_LIBPERL
-else
+ifdef LIBPERL
   PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
   PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
   PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
@@ -829,17 +827,13 @@ else
   PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
   FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
 
+  $(call feature_check,libperl)
   ifneq ($(feature-libperl), 1)
-    CFLAGS += -DNO_LIBPERL
-    NO_LIBPERL := 1
-    $(warning Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev)
+    $(error Missing perl devel files. Please install perl-ExtUtils-Embed/libperl-dev)
   else
     LDFLAGS += $(PERL_EMBED_LDFLAGS)
     EXTLIBS += $(PERL_EMBED_LIBADD)
     CFLAGS += -DHAVE_LIBPERL_SUPPORT
-    ifeq ($(CC_NO_CLANG), 0)
-      CFLAGS += -Wno-compound-token-split-by-macro
-    endif
     $(call detected,CONFIG_LIBPERL)
   endif
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e2150acc2c13..7d6ac03a7109 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -17,7 +17,7 @@ include ../scripts/utilities.mak
 #
 # Define CROSS_COMPILE as prefix name of compiler if you want cross-builds.
 #
-# Define NO_LIBPERL to disable perl script extension.
+# Define LIBPERL to enable perl script extension.
 #
 # Define NO_LIBPYTHON to disable python script extension.
 #
@@ -1103,7 +1103,7 @@ endif
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-iostat) \
 		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
-ifndef NO_LIBPERL
+ifdef LIBPERL
 	$(call QUIET_INSTALL, perl-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
 		$(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index b1e205871ab1..5457762f7dd5 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -49,7 +49,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
-	FEATURE_STATUS("libperl", HAVE_LIBPERL_SUPPORT),
+	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBPERL=1 and install libperl-dev to build with it"),
 	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
 	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index c574a678c28a..b650ce8864ed 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -73,9 +73,9 @@ make_extra_tests    := EXTRA_TESTS=1
 make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
 make_gen_vmlinux_h  := GEN_VMLINUX_H=1
-make_no_libperl     := NO_LIBPERL=1
+make_libperl        := LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
-make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
+make_no_scripts     := NO_LIBPYTHON=1
 make_no_slang       := NO_SLANG=1
 make_no_gtk2        := NO_GTK2=1
 make_no_ui          := NO_SLANG=1 NO_GTK2=1
@@ -118,7 +118,7 @@ make_install_prefix_slash := install prefix=/tmp/krava/
 make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1
 
 # all the NO_* variable combined
-make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
+make_minimal        := NO_LIBPYTHON=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
@@ -143,7 +143,7 @@ run += make_extra_tests
 run += make_jevents_all
 run += make_no_bpf_skel
 run += make_gen_vmlinux_h
-run += make_no_libperl
+run += make_libperl
 run += make_no_libpython
 run += make_no_scripts
 run += make_no_slang
-- 
2.51.0.384.g4c02a37b29-goog

