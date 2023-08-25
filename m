Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6662EE49B5
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 02:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbjHYCkt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbjHYCkp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABF1AD
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d72403b9e03so564737276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931242; x=1693536042;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcUqJfD2vtZBJtRGaKPEtBOFxtzHCYdgja7TOmPH0eI=;
        b=CjxI+TYHnmhAYRxwVdz5aS2g96q8COr2M6h1zy3NUfYwcihYrPYYCdvJnDnUg3DHSX
         UeQeKLw+tyDRqQAtQBA2xCKe8vkrQ3zIJhnly8Qs661aa1M6x0+fFWxkV9DeySTUm7Oe
         CgM7ih1p8azQOaAe6VGeT+vbraXYGRJgKXMwBzDwzhTMTCMnawFW71Ycz1ccqtl1ewQP
         hr7zYtvI6lzLwmgTyO9P6dKlTCUGw6YRAerJ0NYO+i3EU99Po9+yYPIe6MBLun8Mj9XV
         XZmmNMjkxkV5Jx4gGBPQsrtB/kaWmHM6ibdL4mRvuGWl5yd18Vphb+gBAdefjpfeyta6
         jhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931242; x=1693536042;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcUqJfD2vtZBJtRGaKPEtBOFxtzHCYdgja7TOmPH0eI=;
        b=aLJbx45hWAh9+lw3h6gsu46C+QPzqSJg6rioJtg4IbW8MZHHsOk5m/EDwQKdtGGg9A
         m0lfqO4eN5OQcb8hDa3CzNRRgokKlSYSdXqDUifr/GmEYxmQjX+2CcVt/3FjaaM1zzMg
         GGQLhz3qaC8Uek4x9pxTsLfDYwTDXh6SfG2Rgoi1IM81URaJjbp1zjA+pQD0bChmHiCU
         zbz41aDUg6TbtPmydQZO/EyatidzHoajAOTJGAVYRDW+KXWA6/T/8t6QB4Aa/xf+j5za
         S0lxdFFrAEH/nDPiWIzUzHN7o3Q71fgfLqNy3i7GMbvmpsFx9Ex10kL504bb1ZqRhJxf
         DdoA==
X-Gm-Message-State: AOJu0YwrAvCrwdih5BGSJpnaUagfaf5Ym2EY1HozWQmbCDBQplbcaSFz
        YSDH7nOrBi6ZqfqLYrzcAQmz9xsdux8W
X-Google-Smtp-Source: AGHT+IEOo3g5mLbnRiubfq5FYzAABS3D4p8ybai45wdimtAsrJ2oNUARHrolM3wRcoYP/3jUwHZ2GyLtspc3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a25:fc0d:0:b0:d07:e80c:412e with SMTP id
 v13-20020a25fc0d000000b00d07e80c412emr300379ybd.12.1692931242503; Thu, 24 Aug
 2023 19:40:42 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:40:02 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-7-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 6/6] perf tui slang: Tidy casts
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Casts were necessary for older versions of libslang, however, these
are now 15 years old and so we no longer need to care about supporting
them. Tidy the casts and remove unnecessary logic. Move the
ENABLE_SLFUTURE_CONST to the libslang.h common include file, and also
enable ENABLE_SLFUTURE_VOID.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/Build          |  2 --
 tools/perf/ui/browser.c      |  6 +++---
 tools/perf/ui/browsers/Build |  5 -----
 tools/perf/ui/libslang.h     | 20 ++++----------------
 tools/perf/ui/tui/helpline.c |  2 +-
 tools/perf/ui/tui/setup.c    |  2 +-
 tools/perf/ui/tui/util.c     | 12 ++++++------
 7 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/tools/perf/ui/Build b/tools/perf/ui/Build
index 3aff83c3275f..6b6d7143a37b 100644
--- a/tools/perf/ui/Build
+++ b/tools/perf/ui/Build
@@ -10,5 +10,3 @@ CFLAGS_setup.o += -DLIBDIR="BUILD_STR($(LIBDIR))"
 perf-$(CONFIG_SLANG) += browser.o
 perf-$(CONFIG_SLANG) += browsers/
 perf-$(CONFIG_SLANG) += tui/
-
-CFLAGS_browser.o += -DENABLE_SLFUTURE_CONST
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 78fb01d6ad63..603d11283cbd 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -57,12 +57,12 @@ void ui_browser__gotorc(struct ui_browser *browser, int y, int x)
 void ui_browser__write_nstring(struct ui_browser *browser __maybe_unused, const char *msg,
 			       unsigned int width)
 {
-	slsmg_write_nstring(msg, width);
+	SLsmg_write_nstring(msg, width);
 }
 
 void ui_browser__vprintf(struct ui_browser *browser __maybe_unused, const char *fmt, va_list args)
 {
-	slsmg_vprintf(fmt, args);
+	SLsmg_vprintf(fmt, args);
 }
 
 void ui_browser__printf(struct ui_browser *browser __maybe_unused, const char *fmt, ...)
@@ -808,6 +808,6 @@ void ui_browser__init(void)
 
 	while (ui_browser__colorsets[i].name) {
 		struct ui_browser_colorset *c = &ui_browser__colorsets[i++];
-		sltt_set_color(c->colorset, c->name, c->fg, c->bg);
+		SLtt_set_color(c->colorset, c->name, c->fg, c->bg);
 	}
 }
diff --git a/tools/perf/ui/browsers/Build b/tools/perf/ui/browsers/Build
index fdf86f7981ca..7a1d5ddaf688 100644
--- a/tools/perf/ui/browsers/Build
+++ b/tools/perf/ui/browsers/Build
@@ -4,8 +4,3 @@ perf-y += map.o
 perf-y += scripts.o
 perf-y += header.o
 perf-y += res_sample.o
-
-CFLAGS_annotate.o += -DENABLE_SLFUTURE_CONST
-CFLAGS_hists.o    += -DENABLE_SLFUTURE_CONST
-CFLAGS_map.o      += -DENABLE_SLFUTURE_CONST
-CFLAGS_scripts.o  += -DENABLE_SLFUTURE_CONST
diff --git a/tools/perf/ui/libslang.h b/tools/perf/ui/libslang.h
index 991e692b9b46..1dff3020e9d5 100644
--- a/tools/perf/ui/libslang.h
+++ b/tools/perf/ui/libslang.h
@@ -11,28 +11,16 @@
 #define HAVE_LONG_LONG __GLIBC_HAVE_LONG_LONG
 #endif
 
+/* Enable future slang's corrected function prototypes. */
+#define ENABLE_SLFUTURE_CONST 1
+#define ENABLE_SLFUTURE_VOID 1
+
 #ifdef HAVE_SLANG_INCLUDE_SUBDIR
 #include <slang/slang.h>
 #else
 #include <slang.h>
 #endif
 
-#if SLANG_VERSION < 20104
-#define slsmg_printf(msg, args...) \
-	SLsmg_printf((char *)(msg), ##args)
-#define slsmg_vprintf(msg, vargs) \
-	SLsmg_vprintf((char *)(msg), vargs)
-#define slsmg_write_nstring(msg, len) \
-	SLsmg_write_nstring((char *)(msg), len)
-#define sltt_set_color(obj, name, fg, bg) \
-	SLtt_set_color(obj,(char *)(name), (char *)(fg), (char *)(bg))
-#else
-#define slsmg_printf SLsmg_printf
-#define slsmg_vprintf SLsmg_vprintf
-#define slsmg_write_nstring SLsmg_write_nstring
-#define sltt_set_color SLtt_set_color
-#endif
-
 #define SL_KEY_UNTAB 0x1000
 
 #endif /* _PERF_UI_SLANG_H_ */
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index db4952f5990b..b39451314f43 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -22,7 +22,7 @@ static void tui_helpline__push(const char *msg)
 
 	SLsmg_gotorc(SLtt_Screen_Rows - 1, 0);
 	SLsmg_set_color(0);
-	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
+	SLsmg_write_nstring(msg, SLtt_Screen_Cols);
 	SLsmg_refresh();
 	strlcpy(ui_helpline__current, msg, sz);
 }
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index c1886aa184b3..605d9e175ea7 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -142,7 +142,7 @@ int ui__init(void)
 		goto out;
 	}
 
-	SLkp_define_keysym((char *)"^(kB)", SL_KEY_UNTAB);
+	SLkp_define_keysym("^(kB)", SL_KEY_UNTAB);
 
 	signal(SIGSEGV, ui__signal_backtrace);
 	signal(SIGFPE, ui__signal_backtrace);
diff --git a/tools/perf/ui/tui/util.c b/tools/perf/ui/tui/util.c
index 3c5174854ac8..e4d322ce0b54 100644
--- a/tools/perf/ui/tui/util.c
+++ b/tools/perf/ui/tui/util.c
@@ -106,7 +106,7 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 	SLsmg_draw_box(y, x++, nr_lines, max_len);
 	if (title) {
 		SLsmg_gotorc(y, x + 1);
-		SLsmg_write_string((char *)title);
+		SLsmg_write_string(title);
 	}
 	SLsmg_gotorc(++y, x);
 	nr_lines -= 7;
@@ -117,12 +117,12 @@ int ui_browser__input_window(const char *title, const char *text, char *input,
 	len = 5;
 	while (len--) {
 		SLsmg_gotorc(y + len - 1, x);
-		SLsmg_write_nstring((char *)" ", max_len);
+		SLsmg_write_nstring(" ", max_len);
 	}
 	SLsmg_draw_box(y++, x + 1, 3, max_len - 2);
 
 	SLsmg_gotorc(y + 3, x);
-	SLsmg_write_nstring((char *)exit_msg, max_len);
+	SLsmg_write_nstring(exit_msg, max_len);
 	SLsmg_refresh();
 
 	mutex_unlock(&ui__lock);
@@ -197,7 +197,7 @@ void __ui__info_window(const char *title, const char *text, const char *exit_msg
 	SLsmg_draw_box(y, x++, nr_lines, max_len);
 	if (title) {
 		SLsmg_gotorc(y, x + 1);
-		SLsmg_write_string((char *)title);
+		SLsmg_write_string(title);
 	}
 	SLsmg_gotorc(++y, x);
 	if (exit_msg)
@@ -207,9 +207,9 @@ void __ui__info_window(const char *title, const char *text, const char *exit_msg
 				   nr_lines, max_len, 1);
 	if (exit_msg) {
 		SLsmg_gotorc(y + nr_lines - 2, x);
-		SLsmg_write_nstring((char *)" ", max_len);
+		SLsmg_write_nstring(" ", max_len);
 		SLsmg_gotorc(y + nr_lines - 1, x);
-		SLsmg_write_nstring((char *)exit_msg, max_len);
+		SLsmg_write_nstring(exit_msg, max_len);
 	}
 }
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

