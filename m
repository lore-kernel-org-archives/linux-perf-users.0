Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD83E7167
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049383; cv=none; b=tPggN1fFBuINysAnsMR27bWo/c+ILvFw9KuxjJ1u2OM16+dHQNIQzojbuT4srxKzac1O7w29hGAtVq+9atZx4JcDlaraG0Prv0vCa2rKq5TkzEZgy5DtpfbJM50MCBGWqXW8dHl8E5xlwzMgJvnwsHTpQt9D7/Xt2NUn01nSRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049383; c=relaxed/simple;
	bh=dx7uCW0bnwuKU2GglY9FGcq7UBHfLC8qaHrzJbtO6KA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZc7nm2iHKoYQy5jrpWEdklDTQaE0XbhVX5xQ132ldWyguaYkLUHEgKr6lcGsrluLaBqBPlQwxMCBQfovhuT3JypO3/bjXzWG4nIlG8A/1DAzhbo4o/WII0tchhx1cR9+67WEMJmqpc4MEy4wavfuBleuOZkETt99N557rF60eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eKyLOxxD; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eKyLOxxD"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d889997495so20619750eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049377; x=1777654177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YwParOeiktAQb4Ic30frldJ2z6ALoLqPytyXwFhFQE=;
        b=eKyLOxxD88TOIyiWYvEIMmvfuczriTds1Gw7X9b0t0KaZaFpkhyYE8emJPOcxSUKZB
         L9VLSbVIRIUK5AWzCvVCJt7AlT7+hywz3/6w1qT41XCWpnQP4odO28rw5CzqtfopP4Je
         RmTvcgODiY/yf/eO+M/3xUqTvdkCMfFbg5eWFXTqM7mCnAMt+EAUW6RWvIHrhXqxjJDK
         vTCvuT+WZTpoXjJHx4PtObg4/qDGEfkZm46GD4Zj+046uBIZJbL3m8FrNsMXPx/6XanX
         Q0sjddQz/d3Zh9ZKEO88Kc5bcIAsQx1LHRKDPujpg0yeJ6kiVovDXgz62C98JaULOynl
         etOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049377; x=1777654177;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6YwParOeiktAQb4Ic30frldJ2z6ALoLqPytyXwFhFQE=;
        b=ermCX2h8rK/xXGvqV0h858bePr/eNJj7w+mM1HT3Y3TjZhOZEq/hDJ3d8UoUeyel98
         Gr+n4sK4FDvzWqlPLed5Zxavt6+6UvMEfxjRlLuox4l8Q+OCAQutEhSzOqmX0gOv5kuk
         Qwv6z4jFwhnDA3NedOFdOdzho1GIDafj9ptJV668dKVq5xTqj5epwTYwUoQ+0/+aA2mA
         4MeuuROb1yOuoE1gH0nb/iZ55nd01UiL4fYNyJDUbR2Z3OeVLFwW5w95dWdyPwaaTdPC
         qqqY6zRpO2fPtQY/C37qR4ZLfMrfv9zdZyGal6dUWhxoxnhYE6+aixR5I3wGUmbsjLBx
         FTlA==
X-Forwarded-Encrypted: i=1; AFNElJ+Pjr0OAFEoChdVOlOenBuk+PmphRkn+R/t+Xj8q/3ISwdARYAgZ6UiI70wf3Fwdj6pMhSI3c1R0zGioS6EabIK@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWPzJVnM67G+Id3AkaQt11M3Tm2lUFT+/NA6FS3kymzDNNMXr
	sLAdATw7w3YwipEKfB2tb9/LppFrtpIBII8Ke6Qus7CflvN46Vm3/C3OFcsnib4dXRrhGJ/UMNs
	To/iE6nDfVw==
X-Received: from dyjh29.prod.google.com ([2002:a05:7300:561d:b0:2e0:f299:f616])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fb91:b0:2cb:de38:c77d
 with SMTP id 5a478bee46e88-2e4648c57a5mr15839310eec.3.1777049376552; Fri, 24
 Apr 2026 09:49:36 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:47:15 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-54-irogers@google.com>
Subject: [PATCH v5 53/58] perf: Remove libperl support, legacy Perl scripts
 and tests
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit removes embedded Perl interpreter support from perf, as all
legacy Perl scripts have been ported to Python or are no longer needed.

Changes include:
- Removal of libperl feature detection and flags from Makefile.config.
- Removal of Perl script installation rules from Makefile.perf.
- Removal of build rules for trace-event-perl.o and Perf-Trace-Util.
- Deletion of tools/perf/util/scripting-engines/trace-event-perl.c.
- Removal of Perl scripting operations and setup from
  trace-event-scripting.c.
- Removal of setup_perl_scripting() call from builtin-script.c and
  declaration from trace-event.h.
- Removal of Perl checks in the script browser (scripts.c).
- Removal of libperl from the supported features list in
  builtin-check.c and Documentation/perf-check.txt.
- Removal of make_libperl target from tests/make.
- Deletion of the entire tools/perf/scripts/perl directory containing
  legacy Perl scripts.
- Removal of tools/perf/tests/shell/script_perl.sh test.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. In tools/perf/ui/browsers/scripts.c : I added an unconditional skip
   for the "perl" directory in find_scripts() . This ensures that even
   if stale Perl scripts are left over in the installation directory,
   they will not appear in the TUI script browser.

2. In tools/perf/Makefile.config : I removed the dangling $(call
   detected_var,PERL_EMBED_CCOPTS) line at the end of the file, so it
   no longer exports that undefined variable to the configuration.
---
 tools/build/Makefile.feature                  |   1 -
 tools/build/feature/Makefile                  |  19 +-
 tools/build/feature/test-libperl.c            |  10 -
 tools/perf/Documentation/perf-check.txt       |   1 -
 tools/perf/Makefile.config                    |  22 +-
 tools/perf/Makefile.perf                      |  11 +-
 tools/perf/builtin-check.c                    |   2 +-
 tools/perf/builtin-script.c                   |   4 +-
 tools/perf/scripts/Build                      |   4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |   9 -
 .../scripts/perl/Perf-Trace-Util/Context.c    | 122 ---
 .../scripts/perl/Perf-Trace-Util/Context.xs   |  42 -
 .../scripts/perl/Perf-Trace-Util/Makefile.PL  |  18 -
 .../perf/scripts/perl/Perf-Trace-Util/README  |  59 --
 .../Perf-Trace-Util/lib/Perf/Trace/Context.pm |  55 --
 .../Perf-Trace-Util/lib/Perf/Trace/Core.pm    | 192 -----
 .../Perf-Trace-Util/lib/Perf/Trace/Util.pm    |  94 ---
 .../perf/scripts/perl/Perf-Trace-Util/typemap |   1 -
 .../scripts/perl/bin/check-perf-trace-record  |   2 -
 .../scripts/perl/bin/failed-syscalls-record   |   3 -
 .../scripts/perl/bin/failed-syscalls-report   |  10 -
 tools/perf/scripts/perl/bin/rw-by-file-record |   3 -
 tools/perf/scripts/perl/bin/rw-by-file-report |  10 -
 tools/perf/scripts/perl/bin/rw-by-pid-record  |   2 -
 tools/perf/scripts/perl/bin/rw-by-pid-report  |   3 -
 tools/perf/scripts/perl/bin/rwtop-record      |   2 -
 tools/perf/scripts/perl/bin/rwtop-report      |  20 -
 .../scripts/perl/bin/wakeup-latency-record    |   6 -
 .../scripts/perl/bin/wakeup-latency-report    |   3 -
 tools/perf/scripts/perl/check-perf-trace.pl   | 106 ---
 tools/perf/scripts/perl/failed-syscalls.pl    |  47 --
 tools/perf/scripts/perl/rw-by-file.pl         | 106 ---
 tools/perf/scripts/perl/rw-by-pid.pl          | 184 -----
 tools/perf/scripts/perl/rwtop.pl              | 203 -----
 tools/perf/scripts/perl/wakeup-latency.pl     | 107 ---
 tools/perf/tests/make                         |   4 +-
 tools/perf/tests/shell/script_perl.sh         | 102 ---
 tools/perf/ui/browsers/scripts.c              |   7 +-
 tools/perf/util/scripting-engines/Build       |   6 +-
 .../util/scripting-engines/trace-event-perl.c | 773 ------------------
 tools/perf/util/trace-event-scripting.c       |  65 --
 tools/perf/util/trace-event.h                 |   2 +-
 42 files changed, 15 insertions(+), 2427 deletions(-)
 delete mode 100644 tools/build/feature/test-libperl.c
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
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-perl.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 0b7a7c38cb88..96d4382144c4 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -118,7 +118,6 @@ FEATURE_TESTS_EXTRA :=3D                  \
          libbfd-liberty                 \
          libbfd-liberty-z               \
          libopencsd                     \
-         libperl                        \
          cxx                            \
          llvm                           \
          clang                          \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f163a245837a..60e3df8142a5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -30,7 +30,6 @@ FILES=3D                                          \
          test-libdebuginfod.bin                 \
          test-libnuma.bin                       \
          test-numa_num_possible_cpus.bin        \
-         test-libperl.bin                       \
          test-libpython.bin                     \
          test-libslang.bin                      \
          test-libtraceevent.bin                 \
@@ -113,7 +112,7 @@ __BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(p=
atsubst %.bin,%.c,$(@F)) $(
   BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
   BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
   BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2 -=
ldw -lelf -lnuma -lelf -lslang \
-	      $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd \
+	      $(FLAGS_PYTHON_EMBED) -ldl -lz -llzma -lzstd \
 	      $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
=20
 __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,=
%.cpp,$(@F)) $(LDFLAGS)
@@ -253,22 +252,6 @@ $(OUTPUT)test-gtk2-infobar.bin:
 grep-libs  =3D $(filter -l%,$(1))
 strip-libs =3D $(filter-out -l%,$(1))
=20
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
 $(OUTPUT)test-libpython.bin:
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
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documenta=
tion/perf-check.txt
index 09e1d35677f5..60fa9ea43a58 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -58,7 +58,6 @@ feature::
                 libLLVM                 /  HAVE_LIBLLVM_SUPPORT
                 libnuma                 /  HAVE_LIBNUMA_SUPPORT
                 libopencsd              /  HAVE_CSTRACE_SUPPORT
-                libperl                 /  HAVE_LIBPERL_SUPPORT
                 libpfm4                 /  HAVE_LIBPFM
                 libpython               /  HAVE_LIBPYTHON_SUPPORT
                 libslang                /  HAVE_SLANG_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 333ddd0e4bd8..db30e73c5efc 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -820,26 +820,7 @@ ifdef GTK2
   endif
 endif
=20
-ifdef LIBPERL
-  PERL_EMBED_LDOPTS =3D $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/nu=
ll)
-  PERL_EMBED_LDFLAGS =3D $(call strip-libs,$(PERL_EMBED_LDOPTS))
-  PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EMBED_LDOPTS))
-  PERL_EMBED_CCOPTS =3D $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/nu=
ll)
-  PERL_EMBED_CCOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_CCOPTS))
-  PERL_EMBED_CCOPTS :=3D $(filter-out -flto% -ffat-lto-objects, $(PERL_EMB=
ED_CCOPTS))
-  PERL_EMBED_LDOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_LDOPTS))
-  FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
-
-  $(call feature_check,libperl)
-  ifneq ($(feature-libperl), 1)
-    $(error Missing perl devel files. Please install perl-ExtUtils-Embed/l=
ibperl-dev)
-  else
-    LDFLAGS +=3D $(PERL_EMBED_LDFLAGS)
-    EXTLIBS +=3D $(PERL_EMBED_LIBADD)
-    CFLAGS +=3D -DHAVE_LIBPERL_SUPPORT
-    $(call detected,CONFIG_LIBPERL)
-  endif
-endif
+
=20
 ifeq ($(feature-timerfd), 1)
   CFLAGS +=3D -DHAVE_TIMERFD_SUPPORT
@@ -1321,7 +1302,6 @@ $(call detected_var,tipdir_SQ)
 $(call detected_var,srcdir_SQ)
 $(call detected_var,LIBDIR)
 $(call detected_var,GTK_CFLAGS)
-$(call detected_var,PERL_EMBED_CCOPTS)
 $(call detected_var,PYTHON_EMBED_CCOPTS)
 ifneq ($(BISON_FILE_PREFIX_MAP),)
 $(call detected_var,BISON_FILE_PREFIX_MAP)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c06..7bf349198622 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -17,7 +17,7 @@ include ../scripts/utilities.mak
 #
 # Define CROSS_COMPILE as prefix name of compiler if you want cross-builds=
.
 #
-# Define LIBPERL to enable perl script extension.
+
 #
 # Define NO_LIBPYTHON to disable python script extension.
 #
@@ -1098,14 +1098,7 @@ endif
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
+
 ifndef NO_LIBPYTHON
 	$(call QUIET_INSTALL, python-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python=
/Perf-Trace-Util/lib/Perf/Trace'; \
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 3641d263b345..944038814d62 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -51,7 +51,7 @@ struct feature_status supported_features[] =3D {
 	FEATURE_STATUS("libLLVM", HAVE_LIBLLVM_SUPPORT),
 	FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
 	FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
-	FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, use LIBP=
ERL=3D1 and install perl-ExtUtils-Embed/libperl-dev to build with it"),
+
 	FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
 	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
 	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3e3692088154..c0949556d1bb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2621,9 +2621,7 @@ static void process_stat_interval(u64 tstamp)
=20
 static void setup_scripting(void)
 {
-#ifdef HAVE_LIBTRACEEVENT
-	setup_perl_scripting();
-#endif
+
 	setup_python_scripting();
 }
=20
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index 91229a1fe3ff..d72cf9ad45fe 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -1,6 +1,4 @@
-ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-util-$(CONFIG_LIBPERL)   +=3D perl/Perf-Trace-Util/
-endif
+
 perf-util-$(CONFIG_LIBPYTHON) +=3D python/Perf-Trace-Util/
=20
 ifdef MYPY
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
index 6587dc326d1b..31b064928cfc 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -74,7 +74,7 @@ make_no_jevents     :=3D NO_JEVENTS=3D1
 make_jevents_all    :=3D JEVENTS_ARCH=3Dall
 make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
 make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
-make_libperl        :=3D LIBPERL=3D1
+
 make_no_libpython   :=3D NO_LIBPYTHON=3D1
 make_no_scripts     :=3D NO_LIBPYTHON=3D1
 make_no_slang       :=3D NO_SLANG=3D1
@@ -149,7 +149,7 @@ run +=3D make_no_jevents
 run +=3D make_jevents_all
 run +=3D make_no_bpf_skel
 run +=3D make_gen_vmlinux_h
-run +=3D make_libperl
+
 run +=3D make_no_libpython
 run +=3D make_no_scripts
 run +=3D make_no_slang
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
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scri=
pts.c
index 1e8c2c2f952d..27a099af2135 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -200,14 +200,13 @@ static int find_scripts(char **scripts_array, char **=
scripts_path_array, int num
 		if (!strcmp(lang_dirent->d_name, ".") || !strcmp(lang_dirent->d_name, ".=
."))
 			continue;
=20
-#ifndef HAVE_LIBPERL_SUPPORT
-		if (strstr(lang_dirent->d_name, "perl"))
-			continue;
-#endif
+
 #ifndef HAVE_LIBPYTHON_SUPPORT
 		if (strstr(lang_dirent->d_name, "python"))
 			continue;
 #endif
+		if (strstr(lang_dirent->d_name, "perl"))
+			continue;
=20
 		lang_dir_fd =3D openat(scripts_dir_fd, lang_dirent->d_name, O_DIRECTORY)=
;
 		if (lang_dir_fd =3D=3D -1)
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scri=
pting-engines/Build
index 24f087b0cd11..ce14ef44b200 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -1,9 +1,7 @@
-ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-util-$(CONFIG_LIBPERL)   +=3D trace-event-perl.o
-endif
+
 perf-util-$(CONFIG_LIBPYTHON) +=3D trace-event-python.o
=20
-CFLAGS_trace-event-perl.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -=
Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs=
 -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-aft=
er-statement -Wno-switch-enum -Wno-thread-safety-analysis
+
=20
 # -Wno-declaration-after-statement: The python headers have mixed code wit=
h declarations (decls after asserts, for instance)
 CFLAGS_trace-event-python.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-dec=
ls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecated=
-declarations -Wno-switch-enum -Wno-declaration-after-statement
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/p=
erf/util/scripting-engines/trace-event-perl.c
deleted file mode 100644
index e261a57b87d4..000000000000
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ /dev/null
@@ -1,773 +0,0 @@
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
-				  struct evsel *evsel,
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
-	if (thread__resolve_callchain(al->thread, cursor, evsel,
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
-			    !hv_stores(sym, "binding", newSVuv(node->ms.sym->binding)) ||
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
-				    struct evsel *evsel,
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
-	XPUSHs(sv_2mortal(perl_process_callchain(sample, evsel, al)));
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
-		XPUSHs(sv_2mortal(perl_process_callchain(sample, evsel, al)));
-		call_pv("main::trace_unhandled", G_SCALAR);
-	}
-	SPAGAIN;
-	PUTBACK;
-	FREETMPS;
-	LEAVE;
-}
-
-static void perl_process_event_generic(union perf_event *event,
-				       struct perf_sample *sample,
-				       struct evsel *evsel)
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
-	XPUSHs(sv_2mortal(newSVpvn((const char *)&evsel->core.attr, sizeof(evsel-=
>core.attr))));
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
-			       struct evsel *evsel,
-			       struct addr_location *al,
-			       struct addr_location *addr_al)
-{
-	scripting_context__update(scripting_context, event, sample, evsel, al, ad=
dr_al);
-	perl_process_tracepoint(sample, evsel, al);
-	perl_process_event_generic(event, sample, evsel);
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
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trac=
e-event-scripting.c
index fa850e44cb46..a82472419611 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -206,72 +206,7 @@ void setup_python_scripting(void)
 }
 #endif
=20
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
=20
-void setup_perl_scripting(void)
-{
-	register_perl_scripting(&perl_scripting_ops);
-}
-#endif
-#endif
=20
 static const struct {
 	u32 flags;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 914d9b69ed62..7bdf44403e3a 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -116,7 +116,7 @@ extern unsigned int scripting_max_stack;
 struct scripting_ops *script_spec__lookup(const char *spec);
 int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char =
*spec));
=20
-void setup_perl_scripting(void);
+
 void setup_python_scripting(void);
=20
 struct scripting_context {
--=20
2.54.0.545.g6539524ca2-goog

