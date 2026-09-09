Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677D33EB01
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922246; cv=none; b=KY8yvA02vgUbbfznjN9zhNJ10aUR+F3QFYmEBAGhraNqTGr1iiNB+rcE5skBooXTsKjVkQ0Ua4XpMKOczx4o3QsiOQGE+T7jjIHNFBpJaj9SLTAhkePdRBH8x3MBArugVnnb+vUjf7J6YiAhhTlHakf47aGbAmhh+3Xw6r9tjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922246; c=relaxed/simple;
	bh=UiI5a1w69pq486YFF3CYIk0RqR4PZnnB6GRz2MyTcxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hac2FXy1B+p46gDTG/0B1J+7F0xE5S9v9YqaMWOO91JKyYk1e8G51cVLy1+6Pwn8uRzA/oaMPL26SIVOZxSoEUDq1OHA85Ujr0rVMi9qLsdtdcH7qYVJkw8O05yYHwg3Xvn9FwS5Y5i6mjgThb5vHt3/kpHX1CK+5JzLXVbkH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=re7ZSYCL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="re7ZSYCL"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-86b03b75fecso84449537b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 19:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922238; x=1789527038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nM4nO09OqQzGUxmO54c6Y6FRbsn4VH2OOYaXU9vXtRg=;
        b=re7ZSYCLxih1XVNdpn/TJ+EFbEfbS/EEux7Av1JSIxX2A0xJcF3VlkFwyBsb6nn2Gk
         w4w2FjFf4Tugd6LMTXOmMrZLfWAV3Mqsx5ZsDgbts5YRmg+P4oCk6gf3vDT+p8UH9K19
         2fUpZegMaohsE4EZNyj/lFv5AUxxMfQ0kH3WIUbkdqeXbsIB7e4+FxgrOY2DCGoHfplq
         S0nauTTy0zzSpvcdm0CxjzrtJKmGS8x1w3pVGLIbCYGHabWksAXWFznBYTJf3lXjn7Xe
         qCIVtfE3L8onGnaKPBQ/vrAlOPDFDs7/2P4ZCA17qKtQth8Sy8jVwsYTrrPDpF9s9J5j
         LhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922238; x=1789527038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nM4nO09OqQzGUxmO54c6Y6FRbsn4VH2OOYaXU9vXtRg=;
        b=dwiG5CD+Bw8Okm3RAVK/zrXBRmeBBN3tNPegIiMzaIqUboRsLmObjUI8QGU7fFTQZB
         VHG5kOCSsMdDjT1NybosMOuN5qJr/LR7SWUVqrs8obJ8LvPEwF2DJQEEb95Yrak4tWZu
         +fP3X6srQ+wOOssA/fWdQx+9lnwO1PRXJlcPruV/7P7DfVIzIK1wayykTMajzEezqgSx
         9werxYarQvb0L4a91PNlBHP5FEZsy+2pBN1eH1gfn50QsGqdCo8qew7AMm/cwlk6XltY
         LjkG+rOVvhh14n67J+A51ezV1wO1mrGQymXDinQlIZA33HxjeDh8R9HRI+669luSJUWc
         1IjA==
X-Forwarded-Encrypted: i=1; AKwUvBzJCgwd8PlCFPJvSgT+1Wlqk8OmvpGE3/sM5GLdCeOFGXPdzsmJKia5l/wN47MHPTn8cLNk9P1pTzmv9F2oo83x@vger.kernel.org
X-Gm-Message-State: AFuF++lZb4yy96y8OQyO86pFPYYXfMdGRezAkkjnaaAOFhjlUTUqwjM/
	xqfoQAN0TUgXJTrw12IqXqyIQYI6jd/D0N6rfE3Ekef34F0b68X+QZC2
X-Gm-Gg: AYBFou37NQaHF/osNqI61WHqONZ2rFr1LbW+7Ull4lsoYDjRXPBd7Ta+x7mGLRC8cee
	D1EphmvL9KbNb1oFx6u+ASgRlNV4ffAoFL5vMvZmSwCgvDLxR2itOvB6q8GirLIguF4+bgNQ/N3
	KQ+Sy8ke14ZnWZwpj6Vrc4xVv4eNi270XV9sDLmD96beG2KrXyg2dQvwgSnfppmwjXIwuP0kT3l
	SyGjUcWEUzuYHc6Qg8o3je/IUPgIvj8sipXR3pbJZ/B4yz3bwl8SISV2eIQPKrj8794fMcAi3k9
	1MSOngCXZF2gKzGCMnRoVO1vURTOXLEyFjfe0HOU19bai7JBwULH9Ll4sZtDXkZvQIcn7kuQVMS
	RnoLGGMzbRBKyJgLtS4Nv1lwxOHfUQs0C10f7QwnGWl1NqAXBddkhwsf1rJgsw1HPhw5GgNbr6l
	j11egxlyom7iDniKnWZM1niZTqbvYoo2kbK2XHItd0DwaVI/a7IVIiGm4gocC4gEKFDmat9ZQ=
X-Received: by 2002:a05:690e:d50:b0:671:476:fb32 with SMTP id 956f58d0204a3-6710476fbdemr1396482d50.90.1788922237832;
        Tue, 08 Sep 2026 19:50:37 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c454esm104051527b3.7.2026.09.08.19.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:50:36 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 08 Sep 2026 22:50:34 -0400
Subject: [PATCH v8 1/3] tools: port perf ui from GTK 2 to GTK 4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-perf-gtk2-v8-1-e90d5d155f0d@gmail.com>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
In-Reply-To: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=35384; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=UiI5a1w69pq486YFF3CYIk0RqR4PZnnB6GRz2MyTcxA=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIWnKxMdH13cKdz0u359T9VndR9kl6a9Kqu39JUwVwzl
 UfPIIG74yMLgxgXw0wxRZa49Yoss9p2LPU5Lf0LZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jOIhcnoMGpnFxaWpRbppBUUOefkliSWZ+XnFevkFqXkF6QV6aZlpJRkZ+UXFqUAj9PJSS0x
 dHd2MDA1MLB0tzJwsHE1NnJ2dDJ3cHB2dXZ2MLM1NDJwtHU1cLc0ZuDgFYK5RZmBkWF1YLnrq3K
 XIEtFT+/b+DxEq1vGxcuB3OOMxUdOkqqLxFsP/0L2cVxnueE1gYtp+a6F8/p6VsQ/Ph539Url/q
 ZnZz7gZTAA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Port straight to GTK 4 rather than GTK 3, since GTK 4 is where new
development happens and GTK 3 is old itself now.

GTK 4 drops GtkContainer, GdkScreen, and the gtk_main()/
gtk_dialog_run() family perf's GTK UI relied on. Containers get
per-widget setters (gtk_box_append() and friends), monitor geometry
comes from GdkMonitor instead of GdkScreen, and the main and
error-dialog loops become explicit GMainLoops quit from the
"close-request" and "response" signals. Widgets are visible by default
now, so gtk_widget_show_all()/set_no_show_all() go away, and the
remaining gtk_widget_show()/gtk_widget_hide() calls become
gtk_widget_set_visible() (with a small wrapper where "response" needs
to pass gtk_widget_hide() as a callback, since it no longer exists as
a plain function).

gtk_ui_progress__finish() skips destroying a progress dialog that was
never created, since gtk_window_destroy() asserts on NULL where the old
widget destroy tolerated it. Two spots the GTK 2 to GTK 3 port had
missed (builtin-annotate.c, ui/gtk/setup.c still using
HAVE_GTK2_SUPPORT and gtk_main_quit()) are fixed to match.

Runtime fallout from the new signal-driven loops: the error dialog's
nested loop hung if the parent window closed
(GTK_DIALOG_DESTROY_WITH_PARENT destroys without emitting "response");
gtk_info_bar_get_content_area() is gone, breaking GTK_INFO_BAR_SUPPORT;
the progress dialog's static widget pointers dangled after a manual
close; perf_gtk__error() and the warning functions reused an exhausted
va_list when vasprintf() failed.

The error loop is tracked in a list instead of a single pointer, since
perf_gtk__error() can be called re-entrantly (the dialog isn't modal)
and a lone global leaked the outer loop when that happened. The list
is only ever touched from the main thread: perf_gtk__error() updates
it while handling a dialog, and SIGINT/SIGQUIT/SIGTERM are deferred to
a GLib source via g_unix_signal_add() rather than calling
perf_gtk__exit() straight out of a real signal handler, so quitting on
those signals is serialized with the list update instead of racing it
from signal-handler context. SIGSEGV/SIGFPE keep a real handler, since
they're synchronous faults with no "later" to defer to, but it's pared
down to reporting and reraising the default disposition
(perf_gtk__fatal_signal()): there's no safe way to run GTK/GLib code
from the faulting context. stdarg.h, stdio.h, and string.h are now
included explicitly where used (util.c, hists.c, annotate.c) rather
than relying on transitive includes, which musl doesn't guarantee.

The gtk4-infobar feature check is dropped: GtkInfoBar has existed
unconditionally since GTK 3.10, so the check can only ever pass, and it
was failing outright here anyway since gtk_info_bar_new() is deprecated
and the check treats deprecation warnings as errors.
HAVE_GTK_INFO_BAR_SUPPORT and its statusbar-only fallback go away; the
info bar is now built unconditionally.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/build/Makefile.feature                     |  4 +-
 tools/build/feature/Makefile                     | 10 +--
 tools/build/feature/test-gtk2-infobar.c          | 12 ---
 tools/build/feature/{test-gtk2.c => test-gtk4.c} |  4 +-
 tools/perf/Documentation/perf-report.txt         |  2 +-
 tools/perf/Makefile                              |  2 +-
 tools/perf/Makefile.config                       | 22 +++---
 tools/perf/Makefile.perf                         |  6 +-
 tools/perf/builtin-annotate.c                    |  8 +-
 tools/perf/builtin-report.c                      |  8 +-
 tools/perf/scripts/install-build-deps.sh         |  4 +-
 tools/perf/tests/make                            |  4 +-
 tools/perf/ui/gtk/annotate.c                     | 36 ++++-----
 tools/perf/ui/gtk/browser.c                      | 96 ++++++++++++++++++-----
 tools/perf/ui/gtk/gtk.h                          | 16 ++--
 tools/perf/ui/gtk/hists.c                        | 43 +++++------
 tools/perf/ui/gtk/progress.c                     | 40 +++++++---
 tools/perf/ui/gtk/setup.c                        |  5 +-
 tools/perf/ui/gtk/util.c                         | 97 ++++++++++++++----------
 tools/perf/ui/setup.c                            |  2 +-
 20 files changed, 239 insertions(+), 182 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 99eb0ea09537..4ec95c35a5c1 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -113,8 +113,7 @@ FEATURE_TESTS_EXTRA :=                  \
          compile-x32                    \
          cplus-demangle                 \
          cxa-demangle                   \
-         gtk2                           \
-         gtk2-infobar                   \
+         gtk4                           \
          hello                          \
          babeltrace2-ctf-writer         \
          libcapstone                    \
@@ -143,6 +142,7 @@ endif
 FEATURE_DISPLAY ?=              \
          libdw                  \
          glibc                  \
+         gtk4                   \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7d165018116a..01c48e6ef021 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -11,8 +11,7 @@ FILES=                                          \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
          test-glibc.bin                         \
-         test-gtk2.bin                          \
-         test-gtk2-infobar.bin                  \
+         test-gtk4.bin                          \
          test-hello.bin                         \
          test-libbfd.bin                        \
 	 test-libbfd-threadsafe.bin      	\
@@ -240,11 +239,8 @@ $(OUTPUT)test-libcpupower.bin:
 $(OUTPUT)test-libtracefs.bin:
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
-$(OUTPUT)test-gtk2.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
-
-$(OUTPUT)test-gtk2-infobar.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+$(OUTPUT)test-gtk4.bin:
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk4 2>/dev/null)
 
 grep-libs  = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
diff --git a/tools/build/feature/test-gtk2-infobar.c b/tools/build/feature/test-gtk2-infobar.c
deleted file mode 100644
index b1b716dd5733..000000000000
--- a/tools/build/feature/test-gtk2-infobar.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#pragma GCC diagnostic ignored "-Wstrict-prototypes"
-#include <gtk/gtk.h>
-#pragma GCC diagnostic error "-Wstrict-prototypes"
-
-int main(int argc, char *argv[])
-{
-	gtk_init(&argc, &argv);
-	gtk_info_bar_new();
-
-	return 0;
-}
diff --git a/tools/build/feature/test-gtk2.c b/tools/build/feature/test-gtk4.c
similarity index 76%
rename from tools/build/feature/test-gtk2.c
rename to tools/build/feature/test-gtk4.c
index 2aaf4bfc2055..b9520e7408b9 100644
--- a/tools/build/feature/test-gtk2.c
+++ b/tools/build/feature/test-gtk4.c
@@ -3,9 +3,9 @@
 #include <gtk/gtk.h>
 #pragma GCC diagnostic error "-Wstrict-prototypes"
 
-int main(int argc, char *argv[])
+int main(void)
 {
-	gtk_init(&argc, &argv);
+	gtk_init();
 
         return 0;
 }
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 22f87eaa3279..7af9b3f81c06 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -351,7 +351,7 @@ OPTIONS
 	requires a tty, if one is not present, as when piping to other
 	commands, the stdio interface is used.
 
---gtk:: Use the GTK2 interface.
+--gtk:: Use the GTK4 interface.
 
 -k::
 --vmlinux=<file>::
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 5b713837eede..56014106479a 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -106,7 +106,7 @@ clean:
 # make -C tools/perf -f tests/make
 #
 build-test:
-	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory tarpkg make_static make_with_gtk2 out
+	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory tarpkg make_static make_with_gtk4 out
 
 build-test-tarball:
 	@$(MAKE) -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory out
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4d5993da9f94..3e59e2b7eaec 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -774,20 +774,16 @@ ifndef NO_SLANG
   endif
 endif
 
-ifdef GTK2
-  FLAGS_GTK2=$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
-  $(call feature_check,gtk2)
-  ifneq ($(feature-gtk2), 1)
-    $(warning GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev)
-    NO_GTK2 := 1
+ifdef GTK4
+  FLAGS_GTK4=$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --libs --cflags gtk4 2>/dev/null)
+  $(call feature_check,gtk4)
+  ifneq ($(feature-gtk4), 1)
+    $(warning GTK4 not found, disables GTK4 support. Please install gtk4-devel or libgtk-4-dev)
+    NO_GTK4 := 1
   else
-    $(call feature_check,gtk2-infobar)
-    ifeq ($(feature-gtk2-infobar), 1)
-      GTK_CFLAGS := -DHAVE_GTK_INFO_BAR_SUPPORT
-    endif
-    CFLAGS += -DHAVE_GTK2_SUPPORT
-    GTK_CFLAGS += $(shell $(PKG_CONFIG) --cflags gtk+-2.0 2>/dev/null)
-    GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-2.0 2>/dev/null)
+    CFLAGS += -DHAVE_GTK4_SUPPORT
+    GTK_CFLAGS += $(shell $(PKG_CONFIG) --cflags gtk4 2>/dev/null)
+    GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk4 2>/dev/null)
     EXTLIBS += -ldl
   endif
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 29cfd44c427f..2438b40eaaec 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -49,7 +49,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_SLANG if you do not want TUI support.
 #
-# Define GTK2 if you want GTK+ GUI support.
+# Define GTK4 if you want GTK+ GUI support.
 #
 # Define NO_DEMANGLE if you do not want C++ symbol demangling.
 #
@@ -473,7 +473,7 @@ ifneq ($(OUTPUT),)
   CFLAGS += -I$(OUTPUT)
 endif
 
-ifdef GTK2
+ifdef GTK4
   ALL_PROGRAMS += $(OUTPUT)libperf-gtk.so
   GTK_IN := $(OUTPUT)gtk-in.o
 endif
@@ -811,7 +811,7 @@ check: prepare
 
 ### Installation rules
 
-ifdef GTK2
+ifdef GTK4
 install-gtk: $(OUTPUT)libperf-gtk.so
 	$(call QUIET_INSTALL, 'GTK UI') \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 69cb72b2082a..15163e081a8c 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -52,7 +52,7 @@ struct perf_annotate {
 	bool	   use_tui;
 #endif
 	bool	   use_stdio, use_stdio2;
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK4_SUPPORT
 	bool	   use_gtk;
 #endif
 	bool	   skip_missing;
@@ -712,7 +712,7 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN('q', "quiet", &quiet, "do now show any warnings or messages"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK4_SUPPORT
 	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
 #endif
 #ifdef HAVE_SLANG_SUPPORT
@@ -828,7 +828,7 @@ int cmd_annotate(int argc, const char **argv)
 	if (annotate_check_args() < 0)
 		return -EINVAL;
 
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK4_SUPPORT
 	if (symbol_conf.show_nr_samples && annotate.use_gtk) {
 		pr_err("--show-nr-samples is not available in --gtk mode at this time\n");
 		return ret;
@@ -898,7 +898,7 @@ int cmd_annotate(int argc, const char **argv)
 	else if (annotate.use_tui)
 		use_browser = 1;
 #endif
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK4_SUPPORT
 	else if (annotate.use_gtk)
 		use_browser = 2;
 #endif
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 60d1f166629e..d14384c58466 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -82,7 +82,7 @@ struct report {
 #ifdef HAVE_SLANG_SUPPORT
 	bool			use_tui;
 #endif
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK4_SUPPORT
 	bool			use_gtk;
 #endif
 	bool			use_stdio;
@@ -1359,8 +1359,8 @@ int cmd_report(int argc, const char **argv)
 #ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
 #endif
-#ifdef HAVE_GTK2_SUPPORT
-	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
+#ifdef HAVE_GTK4_SUPPORT
+	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK4 interface"),
 #endif
 	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
 		    "Use the stdio interface"),
@@ -1710,7 +1710,7 @@ int cmd_report(int argc, const char **argv)
 	else if (report.use_tui)
 		use_browser = 1;
 #endif
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK4_SUPPORT
 	else if (report.use_gtk)
 		use_browser = 2;
 #endif
diff --git a/tools/perf/scripts/install-build-deps.sh b/tools/perf/scripts/install-build-deps.sh
index d003e7fab2be..a601a5260c17 100755
--- a/tools/perf/scripts/install-build-deps.sh
+++ b/tools/perf/scripts/install-build-deps.sh
@@ -199,8 +199,8 @@ fedora_pkg_for() {
 	# opt-in features, which a default build does not enable: the libbfd
 	# disassembler family (libbfd, libbfd-threadsafe, libbfd-liberty,
 	# disassembler-*, cplus-demangle), only linked on BUILD_NONDISTRO
-	# builds and deprecated in favor of capstone, GTK2, LIBPERL and
-	# LIBUNWIND support (ifdef GTK2 / ifdef LIBPERL / LIBUNWIND=1),
+	# builds and deprecated in favor of capstone, GTK4, LIBPERL and
+	# LIBUNWIND support (ifdef GTK4 / ifdef LIBPERL / LIBUNWIND=1),
 	# and CoreSight (ifdef CORESIGHT), are deliberately not mapped.
 	# libaio is not mapped either: its
 	# test uses the POSIX AIO API (aio.h, aio_*, -lrt), provided by
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index d2c2f526e1db..202ab5501916 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -95,7 +95,7 @@ make_no_babeltrace2 := NO_BABELTRACE2=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_libpfm4     := NO_LIBPFM4=1
-make_with_gtk2      := GTK2=1
+make_with_gtk4      := GTK4=1
 make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
 make_tags           := tags
 make_cscope         := cscope
@@ -318,7 +318,7 @@ $(run):
 	$(call test,$@) && \
 	rm -rf $@ $$TMP_DEST || (cat $@ ; false)
 
-make_with_gtk2:
+make_with_gtk4:
 	$(call clean)
 	@TMP_DEST=$$(mktemp -d); \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 8920e298420a..094dfa045b77 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -11,6 +11,7 @@
 #include "ui/helpline.h"
 #include <inttypes.h>
 #include <signal.h>
+#include <string.h>
 
 enum {
 	ANN_COL__PERCENT,
@@ -161,7 +162,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 			gtk_list_store_set(store, &iter, ANN_COL__LINE, s, -1);
 	}
 
-	gtk_container_add(GTK_CONTAINER(window), view);
+	gtk_scrolled_window_set_child(GTK_SCROLLED_WINDOW(window), view);
 
 	list_for_each_entry_safe(pos, n, &notes->src->source, al.node) {
 		list_del_init(&pos->al.node);
@@ -205,40 +206,34 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 		GtkWidget *infobar;
 		GtkWidget *statbar;
 
-		signal(SIGSEGV, perf_gtk__signal);
-		signal(SIGFPE,  perf_gtk__signal);
-		signal(SIGINT,  perf_gtk__signal);
-		signal(SIGQUIT, perf_gtk__signal);
-		signal(SIGTERM, perf_gtk__signal);
+		signal(SIGSEGV, perf_gtk__fatal_signal);
+		signal(SIGFPE,  perf_gtk__fatal_signal);
+		perf_gtk__install_quit_signals();
 
-		window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+		window = gtk_window_new();
 		gtk_window_set_title(GTK_WINDOW(window), "perf annotate");
 
-		g_signal_connect(window, "delete_event", gtk_main_quit, NULL);
-
 		pgctx = perf_gtk__activate_context(window);
 		if (!pgctx)
 			return -1;
 
-		vbox = gtk_vbox_new(FALSE, 0);
+		vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
 		notebook = gtk_notebook_new();
 		pgctx->notebook = notebook;
 
-		gtk_box_pack_start(GTK_BOX(vbox), notebook, TRUE, TRUE, 0);
+		gtk_widget_set_vexpand(notebook, TRUE);
+		gtk_box_append(GTK_BOX(vbox), notebook);
 
 		infobar = perf_gtk__setup_info_bar();
-		if (infobar) {
-			gtk_box_pack_start(GTK_BOX(vbox), infobar,
-					   FALSE, FALSE, 0);
-		}
+		gtk_box_append(GTK_BOX(vbox), infobar);
 
 		statbar = perf_gtk__setup_statusbar();
-		gtk_box_pack_start(GTK_BOX(vbox), statbar, FALSE, FALSE, 0);
+		gtk_box_append(GTK_BOX(vbox), statbar);
 
-		gtk_container_add(GTK_CONTAINER(window), vbox);
+		gtk_window_set_child(GTK_WINDOW(window), vbox);
 	}
 
-	scrolled_window = gtk_scrolled_window_new(NULL, NULL);
+	scrolled_window = gtk_scrolled_window_new();
 	tab_label = gtk_label_new(sym->name);
 
 	gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled_window),
@@ -267,12 +262,11 @@ void perf_gtk__show_annotations(void)
 		return;
 
 	window = pgctx->main_window;
-	gtk_widget_show_all(window);
 
 	perf_gtk__resize_window(window);
-	gtk_window_set_position(GTK_WINDOW(window), GTK_WIN_POS_CENTER);
+	gtk_widget_set_visible(window, TRUE);
 
-	gtk_main();
+	perf_gtk__run_main_loop(window);
 
 	perf_gtk__deactivate_context(&pgctx);
 }
diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index d2dadf3873fb..98f1d6bfcb24 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -5,32 +5,92 @@
 #include "../hist.h"
 #include "../helpline.h"
 
+#include <glib-unix.h>
 #include <signal.h>
 
-void perf_gtk__signal(int sig)
+/*
+ * SIGINT/SIGQUIT/SIGTERM are asynchronous: deferring the actual exit to a
+ * GLib source dispatched from the main loop means it always runs on the
+ * main thread, serialized with everything else the main loop does
+ * (including perf_gtk__error()'s updates to perf_gtk__error_loops), instead
+ * of racing them from arbitrary signal-handler context.
+ */
+static gboolean perf_gtk__quit_signal(gpointer data __maybe_unused)
 {
 	perf_gtk__exit(false);
+	return G_SOURCE_REMOVE;
+}
+
+void perf_gtk__install_quit_signals(void)
+{
+	g_unix_signal_add(SIGINT,  perf_gtk__quit_signal, NULL);
+	g_unix_signal_add(SIGQUIT, perf_gtk__quit_signal, NULL);
+	g_unix_signal_add(SIGTERM, perf_gtk__quit_signal, NULL);
+}
+
+/*
+ * SIGSEGV/SIGFPE are synchronous faults: there's no "later" to defer to,
+ * and no safe way to run GTK/GLib code (or anything else non-async-signal-
+ * safe) from the faulting context. Report and let the default disposition
+ * (core dump) happen instead of trying to tear down GTK state here.
+ */
+void perf_gtk__fatal_signal(int sig)
+{
 	psignal(sig, "perf");
+	signal(sig, SIG_DFL);
+	raise(sig);
 }
 
 void perf_gtk__resize_window(GtkWidget *window)
 {
 	GdkRectangle rect;
-	GdkScreen *screen;
-	int monitor;
+	GdkMonitor *monitor;
+	GdkDisplay *display;
+	GListModel *monitors;
 	int height;
 	int width;
 
-	screen = gtk_widget_get_screen(window);
+	display = gtk_widget_get_display(window);
+	monitors = gdk_display_get_monitors(display);
+	monitor = g_list_model_get_item(monitors, 0);
+	if (!monitor) {
+		gtk_window_set_default_size(GTK_WINDOW(window), 800, 600);
+		return;
+	}
 
-	monitor = gdk_screen_get_monitor_at_window(screen, window->window);
-
-	gdk_screen_get_monitor_geometry(screen, monitor, &rect);
+	gdk_monitor_get_geometry(monitor, &rect);
+	g_object_unref(monitor);
 
 	width	= rect.width * 3 / 4;
 	height	= rect.height * 3 / 4;
 
-	gtk_window_resize(GTK_WINDOW(window), width, height);
+	gtk_window_set_default_size(GTK_WINDOW(window), width, height);
+}
+
+static GMainLoop *perf_gtk__main_loop;
+
+void perf_gtk__quit_main_loop(void)
+{
+	if (perf_gtk__main_loop)
+		g_main_loop_quit(perf_gtk__main_loop);
+}
+
+static gboolean perf_gtk__close_request(GtkWidget *widget __maybe_unused,
+					gpointer data __maybe_unused)
+{
+	perf_gtk__quit_main_loop();
+
+	return FALSE;
+}
+
+void perf_gtk__run_main_loop(GtkWidget *window)
+{
+	g_signal_connect(window, "close-request",
+			 G_CALLBACK(perf_gtk__close_request), NULL);
+
+	perf_gtk__main_loop = g_main_loop_new(NULL, FALSE);
+	g_main_loop_run(perf_gtk__main_loop);
+	g_clear_pointer(&perf_gtk__main_loop, g_main_loop_unref);
 }
 
 const char *perf_gtk__get_percent_color(double percent)
@@ -42,33 +102,35 @@ const char *perf_gtk__get_percent_color(double percent)
 	return NULL;
 }
 
-#ifdef HAVE_GTK_INFO_BAR_SUPPORT
+static void perf_gtk__hide_widget(GtkWidget *widget, gint response_id __maybe_unused,
+				   gpointer data __maybe_unused)
+{
+	gtk_widget_set_visible(widget, FALSE);
+}
+
 GtkWidget *perf_gtk__setup_info_bar(void)
 {
 	GtkWidget *info_bar;
 	GtkWidget *label;
-	GtkWidget *content_area;
 
 	info_bar = gtk_info_bar_new();
-	gtk_widget_set_no_show_all(info_bar, TRUE);
+	gtk_widget_set_visible(info_bar, FALSE);
 
 	label = gtk_label_new("");
-	gtk_widget_show(label);
+	gtk_widget_set_visible(label, TRUE);
 
-	content_area = gtk_info_bar_get_content_area(GTK_INFO_BAR(info_bar));
-	gtk_container_add(GTK_CONTAINER(content_area), label);
+	gtk_info_bar_add_child(GTK_INFO_BAR(info_bar), label);
 
-	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), GTK_STOCK_OK,
+	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
 				GTK_RESPONSE_OK);
 	g_signal_connect(info_bar, "response",
-			 G_CALLBACK(gtk_widget_hide), NULL);
+			 G_CALLBACK(perf_gtk__hide_widget), NULL);
 
 	pgctx->info_bar = info_bar;
 	pgctx->message_label = label;
 
 	return info_bar;
 }
-#endif
 
 GtkWidget *perf_gtk__setup_statusbar(void)
 {
diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
index a2b497f03fd6..6b37fd9943c9 100644
--- a/tools/perf/ui/gtk/gtk.h
+++ b/tools/perf/ui/gtk/gtk.h
@@ -13,10 +13,8 @@ struct perf_gtk_context {
 	GtkWidget *main_window;
 	GtkWidget *notebook;
 
-#ifdef HAVE_GTK_INFO_BAR_SUPPORT
 	GtkWidget *info_bar;
 	GtkWidget *message_label;
-#endif
 	GtkWidget *statbar;
 	guint statbar_ctx_id;
 };
@@ -38,19 +36,15 @@ void perf_gtk__init_helpline(void);
 void gtk_ui_progress__init(void);
 void perf_gtk__init_hpp(void);
 
-void perf_gtk__signal(int sig);
+void perf_gtk__install_quit_signals(void);
+void perf_gtk__fatal_signal(int sig);
 void perf_gtk__resize_window(GtkWidget *window);
+void perf_gtk__run_main_loop(GtkWidget *window);
+void perf_gtk__quit_main_loop(void);
+void perf_gtk__quit_error_dialog(void);
 const char *perf_gtk__get_percent_color(double percent);
 GtkWidget *perf_gtk__setup_statusbar(void);
-
-#ifdef HAVE_GTK_INFO_BAR_SUPPORT
 GtkWidget *perf_gtk__setup_info_bar(void);
-#else
-static inline GtkWidget *perf_gtk__setup_info_bar(void)
-{
-	return NULL;
-}
-#endif
 
 struct evsel;
 struct evlist;
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index bae21f336ae6..716dcf02bd0e 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -8,6 +8,8 @@
 #include "../helpline.h"
 #include "../string2.h"
 #include <signal.h>
+#include <stdarg.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <linux/string.h>
 
@@ -395,11 +397,9 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 		}
 	}
 
-	gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(view), TRUE);
-
 	g_signal_connect(view, "row-activated",
 			 G_CALLBACK(on_row_activated), NULL);
-	gtk_container_add(GTK_CONTAINER(window), view);
+	gtk_scrolled_window_set_child(GTK_SCROLLED_WINDOW(window), view);
 }
 
 static void perf_gtk__add_hierarchy_entries(struct hists *hists,
@@ -583,11 +583,9 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 	perf_gtk__add_hierarchy_entries(hists, &hists->entries, store,
 					NULL, &hpp, min_pcnt);
 
-	gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(view), TRUE);
-
 	g_signal_connect(view, "row-activated",
 			 G_CALLBACK(on_row_activated), NULL);
-	gtk_container_add(GTK_CONTAINER(window), view);
+	gtk_scrolled_window_set_child(GTK_SCROLLED_WINDOW(window), view);
 }
 
 int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
@@ -600,36 +598,32 @@ int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 	GtkWidget *statbar;
 	GtkWidget *window;
 
-	signal(SIGSEGV, perf_gtk__signal);
-	signal(SIGFPE,  perf_gtk__signal);
-	signal(SIGINT,  perf_gtk__signal);
-	signal(SIGQUIT, perf_gtk__signal);
-	signal(SIGTERM, perf_gtk__signal);
+	signal(SIGSEGV, perf_gtk__fatal_signal);
+	signal(SIGFPE,  perf_gtk__fatal_signal);
+	perf_gtk__install_quit_signals();
 
-	window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+	window = gtk_window_new();
 
 	gtk_window_set_title(GTK_WINDOW(window), "perf report");
 
-	g_signal_connect(window, "delete_event", gtk_main_quit, NULL);
-
 	pgctx = perf_gtk__activate_context(window);
 	if (!pgctx)
 		return -1;
 
-	vbox = gtk_vbox_new(FALSE, 0);
+	vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
 
 	notebook = gtk_notebook_new();
 
-	gtk_box_pack_start(GTK_BOX(vbox), notebook, TRUE, TRUE, 0);
+	gtk_widget_set_vexpand(notebook, TRUE);
+	gtk_box_append(GTK_BOX(vbox), notebook);
 
 	info_bar = perf_gtk__setup_info_bar();
-	if (info_bar)
-		gtk_box_pack_start(GTK_BOX(vbox), info_bar, FALSE, FALSE, 0);
+	gtk_box_append(GTK_BOX(vbox), info_bar);
 
 	statbar = perf_gtk__setup_statusbar();
-	gtk_box_pack_start(GTK_BOX(vbox), statbar, FALSE, FALSE, 0);
+	gtk_box_append(GTK_BOX(vbox), statbar);
 
-	gtk_container_add(GTK_CONTAINER(window), vbox);
+	gtk_window_set_child(GTK_WINDOW(window), vbox);
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
@@ -649,7 +643,7 @@ int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 			}
 		}
 
-		scrolled_window = gtk_scrolled_window_new(NULL, NULL);
+		scrolled_window = gtk_scrolled_window_new();
 
 		gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled_window),
 							GTK_POLICY_AUTOMATIC,
@@ -665,15 +659,12 @@ int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 		gtk_notebook_append_page(GTK_NOTEBOOK(notebook), scrolled_window, tab_label);
 	}
 
-	gtk_widget_show_all(window);
-
 	perf_gtk__resize_window(window);
-
-	gtk_window_set_position(GTK_WINDOW(window), GTK_WIN_POS_CENTER);
+	gtk_widget_set_visible(window, TRUE);
 
 	ui_helpline__push(help);
 
-	gtk_main();
+	perf_gtk__run_main_loop(window);
 
 	perf_gtk__deactivate_context(&pgctx);
 
diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.c
index eea6fcde518a..770f9251b54b 100644
--- a/tools/perf/ui/gtk/progress.c
+++ b/tools/perf/ui/gtk/progress.c
@@ -1,49 +1,65 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
+#include <stdio.h>
 
 #include "gtk.h"
 #include "../progress.h"
+#include <linux/compiler.h>
 
 static GtkWidget *dialog;
 static GtkWidget *progress;
 
+static void gtk_ui_progress__destroyed(GtkWidget *widget __maybe_unused,
+					gpointer data __maybe_unused)
+{
+	dialog = NULL;
+	progress = NULL;
+}
+
 static void gtk_ui_progress__update(struct ui_progress *p)
 {
 	double fraction = p->total ? 1.0 * p->curr / p->total : 0.0;
 	char buf[1024];
 
 	if (dialog == NULL) {
-		GtkWidget *vbox = gtk_vbox_new(TRUE, 5);
+		GtkWidget *vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
 		GtkWidget *label = gtk_label_new(p->title);
 
-		dialog = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+		dialog = gtk_window_new();
 		progress = gtk_progress_bar_new();
 
-		gtk_box_pack_start(GTK_BOX(vbox), label, TRUE, FALSE, 3);
-		gtk_box_pack_start(GTK_BOX(vbox), progress, TRUE, TRUE, 3);
+		gtk_widget_set_vexpand(label, TRUE);
+		gtk_box_append(GTK_BOX(vbox), label);
+		gtk_widget_set_vexpand(progress, TRUE);
+		gtk_box_append(GTK_BOX(vbox), progress);
 
-		gtk_container_add(GTK_CONTAINER(dialog), vbox);
+		gtk_window_set_child(GTK_WINDOW(dialog), vbox);
+
+		g_signal_connect(dialog, "destroy",
+				 G_CALLBACK(gtk_ui_progress__destroyed), NULL);
 
 		gtk_window_set_title(GTK_WINDOW(dialog), "perf");
-		gtk_window_resize(GTK_WINDOW(dialog), 300, 80);
-		gtk_window_set_position(GTK_WINDOW(dialog), GTK_WIN_POS_CENTER);
+		gtk_window_set_default_size(GTK_WINDOW(dialog), 300, 80);
 
-		gtk_widget_show_all(dialog);
+		gtk_widget_set_visible(dialog, TRUE);
 	}
 
 	gtk_progress_bar_set_fraction(GTK_PROGRESS_BAR(progress), fraction);
 	snprintf(buf, sizeof(buf), "%"PRIu64" / %"PRIu64, p->curr, p->total);
 	gtk_progress_bar_set_text(GTK_PROGRESS_BAR(progress), buf);
 
-	/* we didn't call gtk_main yet, so do it manually */
-	while (gtk_events_pending())
-		gtk_main_iteration();
+	/* we didn't start a main loop yet, so pump events manually */
+	while (g_main_context_pending(NULL))
+		g_main_context_iteration(NULL, FALSE);
 }
 
 static void gtk_ui_progress__finish(void)
 {
+	if (dialog == NULL)
+		return;
+
 	/* this will also destroy all of its children */
-	gtk_widget_destroy(dialog);
+	gtk_window_destroy(GTK_WINDOW(dialog));
 
 	dialog = NULL;
 }
diff --git a/tools/perf/ui/gtk/setup.c b/tools/perf/ui/gtk/setup.c
index f5eee4d66873..9b44f3719747 100644
--- a/tools/perf/ui/gtk/setup.c
+++ b/tools/perf/ui/gtk/setup.c
@@ -12,7 +12,7 @@ int perf_gtk__init(void)
 	gtk_ui_progress__init();
 	perf_gtk__init_hpp();
 
-	return gtk_init_check(NULL, NULL) ? 0 : -1;
+	return gtk_init_check() ? 0 : -1;
 }
 
 void perf_gtk__exit(bool wait_for_ok __maybe_unused)
@@ -20,5 +20,6 @@ void perf_gtk__exit(bool wait_for_ok __maybe_unused)
 	if (!perf_gtk__is_active_context(pgctx))
 		return;
 	perf_error__unregister(&perf_gtk_eops);
-	gtk_main_quit();
+	perf_gtk__quit_error_dialog();
+	perf_gtk__quit_main_loop();
 }
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index c47f5c387838..5823ff0d7c2a 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -2,8 +2,10 @@
 #include "../util.h"
 #include "gtk.h"
 
+#include <stdarg.h>
+#include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
+#include <linux/compiler.h>
 #include <linux/zalloc.h>
 
 struct perf_gtk_context *pgctx;
@@ -28,86 +30,103 @@ int perf_gtk__deactivate_context(struct perf_gtk_context **ctx)
 	return 0;
 }
 
+/*
+ * perf_gtk__error() can be called re-entrantly, since the dialog isn't
+ * modal and its nested loop still pumps events for the main window.
+ * Track every currently running loop instead of a single pointer, so a
+ * nested call can't clobber an outer call's loop and leak it.
+ */
+static GSList *perf_gtk__error_loops;
+
+static void perf_gtk__quit_loop(gpointer data, gpointer user_data __maybe_unused)
+{
+	g_main_loop_quit(data);
+}
+
+void perf_gtk__quit_error_dialog(void)
+{
+	g_slist_foreach(perf_gtk__error_loops, perf_gtk__quit_loop, NULL);
+}
+
+static void perf_gtk__dialog_response(GtkDialog *dialog,
+				      gint response_id __maybe_unused,
+				      gpointer data __maybe_unused)
+{
+	gtk_window_destroy(GTK_WINDOW(dialog));
+}
+
 static int perf_gtk__error(const char *format, va_list args)
 {
 	char *msg;
 	GtkWidget *dialog;
+	GMainLoop *loop;
+	va_list args_copy;
 
+	va_copy(args_copy, args);
 	if (!perf_gtk__is_active_context(pgctx) ||
-	    vasprintf(&msg, format, args) < 0) {
+	    vasprintf(&msg, format, args_copy) < 0) {
+		va_end(args_copy);
 		fprintf(stderr, "Error:\n");
 		vfprintf(stderr, format, args);
 		fprintf(stderr, "\n");
 		return -1;
 	}
+	va_end(args_copy);
 
 	dialog = gtk_message_dialog_new_with_markup(GTK_WINDOW(pgctx->main_window),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
 					GTK_MESSAGE_ERROR,
 					GTK_BUTTONS_CLOSE,
 					"<b>Error</b>\n\n%s", msg);
-	gtk_dialog_run(GTK_DIALOG(dialog));
 
-	gtk_widget_destroy(dialog);
+	/*
+	 * "response" only fires when a button is clicked; DESTROY_WITH_PARENT
+	 * destroys the dialog directly without it. Quit from "destroy"
+	 * instead, which fires either way, so the nested loop below can't
+	 * outlive the dialog and hang.
+	 */
+	loop = g_main_loop_new(NULL, FALSE);
+	perf_gtk__error_loops = g_slist_prepend(perf_gtk__error_loops, loop);
+	g_signal_connect(dialog, "response",
+			 G_CALLBACK(perf_gtk__dialog_response), NULL);
+	g_signal_connect_swapped(dialog, "destroy",
+				 G_CALLBACK(g_main_loop_quit), loop);
+
+	gtk_widget_set_visible(dialog, TRUE);
+	g_main_loop_run(loop);
+	perf_gtk__error_loops = g_slist_remove(perf_gtk__error_loops, loop);
+	g_main_loop_unref(loop);
+
 	free(msg);
 	return 0;
 }
 
-#ifdef HAVE_GTK_INFO_BAR_SUPPORT
 static int perf_gtk__warning_info_bar(const char *format, va_list args)
 {
 	char *msg;
+	va_list args_copy;
 
+	va_copy(args_copy, args);
 	if (!perf_gtk__is_active_context(pgctx) ||
-	    vasprintf(&msg, format, args) < 0) {
+	    vasprintf(&msg, format, args_copy) < 0) {
+		va_end(args_copy);
 		fprintf(stderr, "Warning:\n");
 		vfprintf(stderr, format, args);
 		fprintf(stderr, "\n");
 		return -1;
 	}
+	va_end(args_copy);
 
 	gtk_label_set_text(GTK_LABEL(pgctx->message_label), msg);
 	gtk_info_bar_set_message_type(GTK_INFO_BAR(pgctx->info_bar),
 				      GTK_MESSAGE_WARNING);
-	gtk_widget_show(pgctx->info_bar);
+	gtk_widget_set_visible(pgctx->info_bar, TRUE);
 
 	free(msg);
 	return 0;
 }
-#else
-static int perf_gtk__warning_statusbar(const char *format, va_list args)
-{
-	char *msg, *p;
-
-	if (!perf_gtk__is_active_context(pgctx) ||
-	    vasprintf(&msg, format, args) < 0) {
-		fprintf(stderr, "Warning:\n");
-		vfprintf(stderr, format, args);
-		fprintf(stderr, "\n");
-		return -1;
-	}
-
-	gtk_statusbar_pop(GTK_STATUSBAR(pgctx->statbar),
-			  pgctx->statbar_ctx_id);
-
-	/* Only first line can be displayed */
-	p = strchr(msg, '\n');
-	if (p)
-		*p = '\0';
-
-	gtk_statusbar_push(GTK_STATUSBAR(pgctx->statbar),
-			   pgctx->statbar_ctx_id, msg);
-
-	free(msg);
-	return 0;
-}
-#endif
 
 struct perf_error_ops perf_gtk_eops = {
 	.error		= perf_gtk__error,
-#ifdef HAVE_GTK_INFO_BAR_SUPPORT
 	.warning	= perf_gtk__warning_info_bar,
-#else
-	.warning	= perf_gtk__warning_statusbar,
-#endif
 };
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index ff800047e697..d887346c7a63 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -14,7 +14,7 @@ int use_browser = -1;
 
 #define PERF_GTK_DSO "libperf-gtk.so"
 
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK4_SUPPORT
 
 static int setup_gtk_browser(void)
 {

-- 
2.54.0

