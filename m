Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201735C697
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707004; cv=none; b=tfq8CpoHAn4a0yC8zTX/N74w93yxsZa3+4R5ryPxtvUf6cPkCXjUxPYX8a/7qjsEZJQ1+tMsnPqpDoFO/TgXS8tMFtK/dfBunkvM7GHbN5ZCYPO0fqxRjbQFeKWoFUvjdBbQ/7TYwA1JUKkf3fqQNE3wBTdnbE+4Qh8iGTB73UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707004; c=relaxed/simple;
	bh=Z7PKO0uaSi3+YwcyXkKpNz8qtogiRophxKIDJJanxgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKqw87MzxXPpM31cu/62JxcxMKuFEK9jpCQm+Of+/+GLFtp/TEslmk830b6LBiS4/ESvoHS67UFNq0vgR3qMInq5cQB9HH04mLH2Y3yDoSUKIhXhmAuyjmR1ji9RZzWDsowdlOdaVhPVeIRLb18Kb2wJ0dkGjtH0sifVLD6Tqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIJAHFMD; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIJAHFMD"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66fc2844f0eso2506309d50.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788707001; x=1789311801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpeT1eGEPWoF1gyD0TtDkNs5OBBSnFYXVEXReqCmoiA=;
        b=SIJAHFMDYtn0RI8utsi8EiMtKl6Y7aHszqxHuHDV2FEVQLXdtRXQK2TEV4+oZPmPjW
         VLEbqfT6pAG6+TGnJVlmqgCigRWqJsIhg+svw3UVuWVlJ/BBMAHoCZkt6Q8+8nduUcUJ
         Y7ZGe9865dcDx8IeCaTLqf+ZG0WteSi4aercKkHftalvwNpI7WPZ/vWvIaGf+2wTVzyJ
         X4lIkQ/aZeqp4jRcvzGD+B0vhTNszdn+CXY3200+onC6tU4hGDMNb+Zod1Z3XZjAjALX
         0hqBx7DS8nbX6r189gT1kOG3aQBAAJZf1l0lv2HBPqflBkBmgrkvMe2kvQ+Jfi3pfjNk
         64jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788707001; x=1789311801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpeT1eGEPWoF1gyD0TtDkNs5OBBSnFYXVEXReqCmoiA=;
        b=CypCWY+XT2jBoZsQ4WlUL03Na8cabh+erVXx/aPCpq9R1kZYFw9vh1EKggMlOetvuu
         u5GnzlBwf4V43FQ46xnC0+v/Qx7ibypNHK96LAp/GhANgygWn40pqmslknFH+dXpaoIg
         OSEg4/N3tLzgzVjWjSwGAaWg64soFJ0baGDSUdWZGJn8lZbmUwTjSW4xFv9ZPHNDyp3q
         m7N/GjpjcaOpfGPi930TIjQHB9wFrvrroYYG0WxpI8HcBERbPqIxMTFz1ehsqPUaJKOi
         Y/H7TtP6T4B3+HrYOaqz2kxsgxd6C2Px7w32Q83qdEqePFkeqln+FA2M5oRQEhZ6zEnG
         AW4A==
X-Forwarded-Encrypted: i=1; AKwUvBzWfICTHKR9vRXKtZHZfaw58fNG9IbBmC9PMr6PzexfmrQ76v0LxK3bPaYPIxV2Mh93fvTMkHOgEQm5OlqroHCx@vger.kernel.org
X-Gm-Message-State: AFuF++l+g5EKy+lekd44Rbq//UEDQ/9+xFZakrV78Gs/fWoMMKP1qsvh
	Rq5DsWu6weTsRTqqqnQs8TvWUO7KztBECnZWcLNf7HayNTIGIRYbD7OwM3E8g83+HL0=
X-Gm-Gg: AYBFou1BiNLsPbkFlZ7rFmzxwgqxT4CAk0C1NjECm0uoVB/rP1l/H1zxQTiSw8Ca29I
	fp8/wJxj93f6UYK1vSp+j48/SOklRlpGmTho1buySMOB1ajD4XXAGq97lXKrGGQJZPXPfnI9YMZ
	oNmRWEFyXWXef7pjGO92P8OSHTy2Fw2+5iHaE8F5LmB0buYPg4FVvqwlyQqp+Gz4o9CxawSbJeO
	JBpGNuH89nLiPxxlsu6ZbBK9H5FFzK28/NRJ4cArzXDnj6WY0BjpOkkCtEK2XC7MqmVPDupWXRk
	FHEFvLz/z7I1pb6XPWRFNgAMdEzUtpRq0XC1DHj3TbyKbqlLLsChcolXOGvnqX9FSJJJUnlptRP
	GXaPh7rH7EIPpJZmar7JS0NPhaSsZ4MqPsXzKRV0YMhJ2nw7ORCnJiF7fua9TccvR/6TJWpcYcM
	ttibwmpW/sh+Jupv3nYJstkxeTJhopzxaMMhrzJ0NYc0wc6ZrmhM2MxUGamVHs5w==
X-Received: by 2002:a05:690c:385:b0:873:5c0f:287 with SMTP id 00721157ae682-8735c0f0402mr38568167b3.49.1788707000575;
        Sun, 06 Sep 2026 08:03:20 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714af5581bsm56307877b3.36.2026.09.06.08.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:03:19 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 11:03:15 -0400
Subject: [PATCH v2 1/2] tools: port perf ui from GTK 2 to GTK 4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v2-1-3eccff053cd1@gmail.com>
References: <20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v2-0-3eccff053cd1@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=30060; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Z7PKO0uaSi3+YwcyXkKpNz8qtogiRophxKIDJJanxgw=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmNmxm/yu9XkIv/ci5n4GOL64Ju1ieMLy0Un2V6ouOs
 4/uc77N7/jIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhr9skzMtw0Fk/+VL
 7HYKMjU6/glGdFJV/jDI8pyk8WmZIdznndLZuR4VjkpfyX16cb/+FYrSx9fb3Vxz+u93nWaPxbN
 uOHkvhfF14A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Port straight to GTK 4 rather than the intermediate GTK 3, since GTK 4
is where new development happens and GTK 3 is now old itself.

GTK 4 removes GtkContainer, GdkScreen, and the gtk_main()/
gtk_dialog_run() family perf's GTK UI relied on, so this is more than a
mechanical rename: containers get per-widget setters (gtk_box_append()
and friends), monitor geometry comes from GdkMonitor instead of
GdkScreen, and the main and error-dialog loops become explicit
GMainLoops, quit from the "close-request" and "response" signals since
gtk_main_quit() and gtk_dialog_run() no longer exist. Widgets are
visible by default now too, so gtk_widget_show_all()/set_no_show_all()
go away.

gtk_ui_progress__finish() also skips destroying a progress dialog that
was never created, since gtk_window_destroy() asserts on NULL/non-window
where the old plain widget destroy tolerated it. Two spots the GTK 2 to
GTK 3 port had missed (builtin-annotate.c, ui/gtk/setup.c still using
HAVE_GTK2_SUPPORT and gtk_main_quit()) are fixed to match.

A few runtime issues come with the new signal-driven loops: the error
dialog's nested loop hung if the parent window closed
(GTK_DIALOG_DESTROY_WITH_PARENT destroys the dialog without emitting
"response") or a signal arrived while the dialog was open;
gtk_info_bar_get_content_area() is gone in GTK 4, breaking the build
with GTK_INFO_BAR_SUPPORT; the progress dialog's static widget pointers
dangled after a manual close; and perf_gtk__error() and the warning
functions reused an exhausted va_list when vasprintf() failed.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/build/Makefile.feature                       |  5 +-
 tools/build/feature/Makefile                       | 12 ++---
 .../{test-gtk2-infobar.c => test-gtk4-infobar.c}   |  4 +-
 tools/build/feature/{test-gtk2.c => test-gtk4.c}   |  4 +-
 tools/perf/Documentation/perf-report.txt           |  2 +-
 tools/perf/Makefile                                |  2 +-
 tools/perf/Makefile.config                         | 22 ++++-----
 tools/perf/Makefile.perf                           |  6 +--
 tools/perf/builtin-annotate.c                      |  8 ++--
 tools/perf/builtin-report.c                        |  8 ++--
 tools/perf/scripts/install-build-deps.sh           |  4 +-
 tools/perf/tests/make                              |  4 +-
 tools/perf/ui/gtk/annotate.c                       | 28 +++++------
 tools/perf/ui/gtk/browser.c                        | 54 +++++++++++++++++-----
 tools/perf/ui/gtk/gtk.h                            |  3 ++
 tools/perf/ui/gtk/hists.c                          | 32 +++++--------
 tools/perf/ui/gtk/progress.c                       | 39 +++++++++++-----
 tools/perf/ui/gtk/setup.c                          |  5 +-
 tools/perf/ui/gtk/util.c                           | 52 +++++++++++++++++++--
 tools/perf/ui/setup.c                              |  2 +-
 20 files changed, 188 insertions(+), 108 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 99eb0ea09537..7ffeb75a01c7 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -113,8 +113,8 @@ FEATURE_TESTS_EXTRA :=                  \
          compile-x32                    \
          cplus-demangle                 \
          cxa-demangle                   \
-         gtk2                           \
-         gtk2-infobar                   \
+         gtk4                           \
+         gtk4-infobar                   \
          hello                          \
          babeltrace2-ctf-writer         \
          libcapstone                    \
@@ -143,6 +143,7 @@ endif
 FEATURE_DISPLAY ?=              \
          libdw                  \
          glibc                  \
+         gtk4                   \
          libelf                 \
          libnuma                \
          numa_num_possible_cpus \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7d165018116a..2ca992fbb9ad 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -11,8 +11,8 @@ FILES=                                          \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
          test-glibc.bin                         \
-         test-gtk2.bin                          \
-         test-gtk2-infobar.bin                  \
+         test-gtk4.bin                          \
+         test-gtk4-infobar.bin                  \
          test-hello.bin                         \
          test-libbfd.bin                        \
 	 test-libbfd-threadsafe.bin      	\
@@ -240,11 +240,11 @@ $(OUTPUT)test-libcpupower.bin:
 $(OUTPUT)test-libtracefs.bin:
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
-$(OUTPUT)test-gtk2.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
+$(OUTPUT)test-gtk4.bin:
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk4 2>/dev/null)
 
-$(OUTPUT)test-gtk2-infobar.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+$(OUTPUT)test-gtk4-infobar.bin:
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk4 2>/dev/null)
 
 grep-libs  = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
diff --git a/tools/build/feature/test-gtk2-infobar.c b/tools/build/feature/test-gtk4-infobar.c
similarity index 77%
rename from tools/build/feature/test-gtk2-infobar.c
rename to tools/build/feature/test-gtk4-infobar.c
index b1b716dd5733..6c1bcee595a9 100644
--- a/tools/build/feature/test-gtk2-infobar.c
+++ b/tools/build/feature/test-gtk4-infobar.c
@@ -3,9 +3,9 @@
 #include <gtk/gtk.h>
 #pragma GCC diagnostic error "-Wstrict-prototypes"
 
-int main(int argc, char *argv[])
+int main(void)
 {
-	gtk_init(&argc, &argv);
+	gtk_init();
 	gtk_info_bar_new();
 
 	return 0;
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
index 4d5993da9f94..3ac1826a0cbe 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -774,20 +774,20 @@ ifndef NO_SLANG
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
+    $(call feature_check,gtk4-infobar)
+    ifeq ($(feature-gtk4-infobar), 1)
       GTK_CFLAGS := -DHAVE_GTK_INFO_BAR_SUPPORT
     endif
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
index 8920e298420a..fc46ac150408 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -161,7 +161,7 @@ static int perf_gtk__annotate_symbol(GtkWidget *window, struct map_symbol *ms,
 			gtk_list_store_set(store, &iter, ANN_COL__LINE, s, -1);
 	}
 
-	gtk_container_add(GTK_CONTAINER(window), view);
+	gtk_scrolled_window_set_child(GTK_SCROLLED_WINDOW(window), view);
 
 	list_for_each_entry_safe(pos, n, &notes->src->source, al.node) {
 		list_del_init(&pos->al.node);
@@ -211,34 +211,31 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 		signal(SIGQUIT, perf_gtk__signal);
 		signal(SIGTERM, perf_gtk__signal);
 
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
+		if (infobar)
+			gtk_box_append(GTK_BOX(vbox), infobar);
 
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
@@ -267,12 +264,11 @@ void perf_gtk__show_annotations(void)
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
index d2dadf3873fb..99bb0ea76d77 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -16,21 +16,53 @@ void perf_gtk__signal(int sig)
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
@@ -47,18 +79,16 @@ GtkWidget *perf_gtk__setup_info_bar(void)
 {
 	GtkWidget *info_bar;
 	GtkWidget *label;
-	GtkWidget *content_area;
 
 	info_bar = gtk_info_bar_new();
-	gtk_widget_set_no_show_all(info_bar, TRUE);
+	gtk_widget_set_visible(info_bar, FALSE);
 
 	label = gtk_label_new("");
 	gtk_widget_show(label);
 
-	content_area = gtk_info_bar_get_content_area(GTK_INFO_BAR(info_bar));
-	gtk_container_add(GTK_CONTAINER(content_area), label);
+	gtk_info_bar_add_child(GTK_INFO_BAR(info_bar), label);
 
-	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), GTK_STOCK_OK,
+	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
 				GTK_RESPONSE_OK);
 	g_signal_connect(info_bar, "response",
 			 G_CALLBACK(gtk_widget_hide), NULL);
diff --git a/tools/perf/ui/gtk/gtk.h b/tools/perf/ui/gtk/gtk.h
index a2b497f03fd6..beea75d01955 100644
--- a/tools/perf/ui/gtk/gtk.h
+++ b/tools/perf/ui/gtk/gtk.h
@@ -40,6 +40,9 @@ void perf_gtk__init_hpp(void);
 
 void perf_gtk__signal(int sig);
 void perf_gtk__resize_window(GtkWidget *window);
+void perf_gtk__run_main_loop(GtkWidget *window);
+void perf_gtk__quit_main_loop(void);
+void perf_gtk__quit_error_dialog(void);
 const char *perf_gtk__get_percent_color(double percent);
 GtkWidget *perf_gtk__setup_statusbar(void);
 
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index bae21f336ae6..f0053e3af077 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -395,11 +395,9 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
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
@@ -583,11 +581,9 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
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
@@ -606,30 +602,29 @@ int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 	signal(SIGQUIT, perf_gtk__signal);
 	signal(SIGTERM, perf_gtk__signal);
 
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
 	if (info_bar)
-		gtk_box_pack_start(GTK_BOX(vbox), info_bar, FALSE, FALSE, 0);
+		gtk_box_append(GTK_BOX(vbox), info_bar);
 
 	statbar = perf_gtk__setup_statusbar();
-	gtk_box_pack_start(GTK_BOX(vbox), statbar, FALSE, FALSE, 0);
+	gtk_box_append(GTK_BOX(vbox), statbar);
 
-	gtk_container_add(GTK_CONTAINER(window), vbox);
+	gtk_window_set_child(GTK_WINDOW(window), vbox);
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
@@ -649,7 +644,7 @@ int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 			}
 		}
 
-		scrolled_window = gtk_scrolled_window_new(NULL, NULL);
+		scrolled_window = gtk_scrolled_window_new();
 
 		gtk_scrolled_window_set_policy(GTK_SCROLLED_WINDOW(scrolled_window),
 							GTK_POLICY_AUTOMATIC,
@@ -665,15 +660,12 @@ int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
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
index eea6fcde518a..28a4b486360d 100644
--- a/tools/perf/ui/gtk/progress.c
+++ b/tools/perf/ui/gtk/progress.c
@@ -3,47 +3,62 @@
 
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
index c47f5c387838..5096888b7c16 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 #include <string.h>
+#include <linux/compiler.h>
 #include <linux/zalloc.h>
 
 struct perf_gtk_context *pgctx;
@@ -28,27 +29,60 @@ int perf_gtk__deactivate_context(struct perf_gtk_context **ctx)
 	return 0;
 }
 
+static GMainLoop *perf_gtk__error_loop;
+
+void perf_gtk__quit_error_dialog(void)
+{
+	if (perf_gtk__error_loop)
+		g_main_loop_quit(perf_gtk__error_loop);
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
+	perf_gtk__error_loop = g_main_loop_new(NULL, FALSE);
+	g_signal_connect(dialog, "response",
+			 G_CALLBACK(perf_gtk__dialog_response), NULL);
+	g_signal_connect_swapped(dialog, "destroy",
+				 G_CALLBACK(g_main_loop_quit), perf_gtk__error_loop);
+
+	gtk_widget_set_visible(dialog, TRUE);
+	g_main_loop_run(perf_gtk__error_loop);
+	g_clear_pointer(&perf_gtk__error_loop, g_main_loop_unref);
+
 	free(msg);
 	return 0;
 }
@@ -57,14 +91,18 @@ static int perf_gtk__error(const char *format, va_list args)
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
@@ -78,14 +116,18 @@ static int perf_gtk__warning_info_bar(const char *format, va_list args)
 static int perf_gtk__warning_statusbar(const char *format, va_list args)
 {
 	char *msg, *p;
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
 
 	gtk_statusbar_pop(GTK_STATUSBAR(pgctx->statbar),
 			  pgctx->statbar_ctx_id);
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

