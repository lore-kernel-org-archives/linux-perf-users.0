Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74493BE17D
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715096; cv=none; b=Fk51O6KK7p0FmdF7BS+TAq0q5qM6Fxy7TdvaYFaWVdjHVE0wynwR5bGKwJRTe/+B1uq9XAAB6CHLN7riuWGxp8bVsu7/FbZDz27BEvbM0f48FtuQMwGxFA7ldxIVUZ0msWmPKLFBMZ1FNnySMjql9gKC0kS56c6w0MBfb2/I3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715096; c=relaxed/simple;
	bh=WYWkloWX0WwYIbfuRU0AbifbyJ2iXxd78Hzjdu5xb60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZ/fqeCEu/753Sg57BQHY4d/KdYuc/83Pgwyeb/2WDgkTdwvH0vlNdcdHMnX7zD+4RThrysmY2yGp977lTThdolmLshM+gJoKz4y2hRgYiNMF4YOq59MfC1DhobNixeMcb3p7Nd+IRiU+VHS1L7ioURvaH8k9dVZmCIPQKCUdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ3RKGop; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ3RKGop"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-86b03b75fecso42500767b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788715093; x=1789319893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5Xptp4H+rxzUUCx4qt8Wtg7L4/4Oif3JrXMZT5ooQM=;
        b=KJ3RKGopVD+MUwJKsDfjsTr13qI4M9luSyJs4hA133gHsuBvrnUs0/+hrDcVadH03l
         nuFjLQF257l2gCXDcaeW/1MhQBbYFg+PyyxMmNjGUzf+pEnSMe+aYJVXAFO6d5Wx1kDn
         4129G0IxXCiqeIxTZIi3H6qxYwK3xpt92O64MvOHcrtSEwvanLI1KRyFdbWY11PT6kM/
         k178iCvIKm3Z7KsP399yzw4UXUQmtv3B1S6J5kUrIgYUTlyr0EDbaocABXkp8gzqiyFM
         24bv/Jw0lYGkXWjK1JVl4XdMCNBkrHz4tavFE05/sXTsIQZDjO3ObCWvkNwwqD9Sx7y5
         SLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788715093; x=1789319893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5Xptp4H+rxzUUCx4qt8Wtg7L4/4Oif3JrXMZT5ooQM=;
        b=j/DNYy7slyiiW9P76shyWRGL6YipLmGngtfFYOXlHtK81/sxhCWZJeGwojxvH9VKOo
         sRxBEZidkOA4le3jvJMrILGMaDiJ6KWot4scwaVrOVHd6/xvRlMJ9jhBUxfMCBYToTjD
         nr5M6nc5V7kpQfWRCSBbBUQ+cfmLkUvlu1P8c9sPGuppL3nGgXYTebjUXBKVaV/E/34t
         HaKKjTguwMCnIhPqnl3OkpX++HjohUVyiOCnZSFnCcqNj8IJN06V0y23qU61uWnLeFS3
         ptmcijQU6G9FVm/S6LvwHy38Ut0Vbe4NLXSNpucPqIJknlzW9ADhcWYyvhhdllFEzl6M
         FUEQ==
X-Forwarded-Encrypted: i=1; AKwUvByOHRxv+DM5h/Lwr1//DWgn1AMDWY8u3ckuLjtw11LZnk7JrlEvc4WkIuKKxMznl/u9XfvOH5nK4CCc/QOGXSOQ@vger.kernel.org
X-Gm-Message-State: AFuF++mCpfdoZk+jzvvi6DOcFzHsAyptL61VKGf76VIoXKtu2k66Ts0A
	lAj3HRcYzLKEtuUH7CFCkCg0ajvzANBDml3ILoZIElgW5F5LvLyZFvTd
X-Gm-Gg: AYBFou0d5gGnP5ZXfLgihpoMKHId1blI2Z6J3Bm5R9YiLStITf2AYNY7qi2LpNDyLSZ
	TfaE23ad0YgphBFmK3pSbtMeagjBopwrDn9LPcIMeu52OuUDQVU+Xi7fo3Yfrr9n7P4FOyDekzp
	Mkw9in0Yf+atU6GjU+cLKUkNXUDLATa+cTmMHup4stURQtWgknbn/9PpeoYBV3VyQlSeIH7HxSn
	i+T2sWGV6hamp7HNNOFEi9U35yKNON6at3N1LZB6UvAvEj5CV5YPJ/B86lSxD00PmHgqpDHHdbY
	Q/bv03cmt4JOMpSUu8gnyW312K5J+MnV7ZxkfU5Lvuu1Ar1p9hFFAlAObRO7f3sO5tQGBjt5a+V
	Ep3xNdU+yU0faDIQ0Wk+S4d9e73kp1f1eAybmXYd/SLFKRNtankLOC6agwX+JAGHS4LTDgM2i60
	GOta+0NrydmlDaL6ngNxza3qoE7JR8Nsm4yJoVXkmxhmSQiByCSBxSTznhmOkGdA==
X-Received: by 2002:a05:690c:1a:b0:873:5bd1:98b1 with SMTP id 00721157ae682-8735bd19fa2mr41605437b3.35.1788715093078;
        Sun, 06 Sep 2026 10:18:13 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62bc77sm58248267b3.39.2026.09.06.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:18:12 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 13:18:06 -0400
Subject: [PATCH v4 3/3] perf tools: fix GTK4 leftover show/hide calls and
 error-loop list race
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v4-3-97e92ee07214@gmail.com>
References: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v4-0-97e92ee07214@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4571; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=WYWkloWX0WwYIbfuRU0AbifbyJ2iXxd78Hzjdu5xb60=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmLvBp23LZQib47aP9Z933OftXl5u5Vk3rqTmRt1s4O
 uXu2vDTHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHNNaQzDT8Yrs272TQ
 nT9+yyKnRWrdvCznxQI/uZlsq9oFKuTxwaLQx/xfYtbLF/eCdudyTzGbb6vdqBhdMSvaRbFe+W/
 97CveAvFwA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Sashiko AI review of the GTK2-to-GTK4 port flagged two real issues:

- gtk_widget_show()/gtk_widget_hide() were removed in GTK4 but three
  call sites were missed during the port. Replace with
  gtk_widget_set_visible(), adding a small wrapper for the
  info-bar "response" signal callback since gtk_widget_hide() no
  longer exists to pass directly.

- perf_gtk__error_loops is updated with g_slist_prepend()/
  g_slist_remove() in perf_gtk__error(), but perf_gtk__quit_error_dialog()
  walks the same list from a signal handler (perf_gtk__signal() ->
  perf_gtk__exit()) that can fire mid-update, corrupting the list.
  Block the relevant signals around the two list updates.
---
 tools/perf/ui/gtk/browser.c | 10 ++++++++--
 tools/perf/ui/gtk/util.c    | 27 ++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index e1d286945832..40a413787192 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -74,6 +74,12 @@ const char *perf_gtk__get_percent_color(double percent)
 	return NULL;
 }
 
+static void perf_gtk__hide_widget(GtkWidget *widget, gint response_id __maybe_unused,
+				   gpointer data __maybe_unused)
+{
+	gtk_widget_set_visible(widget, FALSE);
+}
+
 GtkWidget *perf_gtk__setup_info_bar(void)
 {
 	GtkWidget *info_bar;
@@ -83,14 +89,14 @@ GtkWidget *perf_gtk__setup_info_bar(void)
 	gtk_widget_set_visible(info_bar, FALSE);
 
 	label = gtk_label_new("");
-	gtk_widget_show(label);
+	gtk_widget_set_visible(label, TRUE);
 
 	gtk_info_bar_add_child(GTK_INFO_BAR(info_bar), label);
 
 	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
 				GTK_RESPONSE_OK);
 	g_signal_connect(info_bar, "response",
-			 G_CALLBACK(gtk_widget_hide), NULL);
+			 G_CALLBACK(perf_gtk__hide_widget), NULL);
 
 	pgctx->info_bar = info_bar;
 	pgctx->message_label = label;
diff --git a/tools/perf/ui/gtk/util.c b/tools/perf/ui/gtk/util.c
index 8a922851257e..f1dbd96e2370 100644
--- a/tools/perf/ui/gtk/util.c
+++ b/tools/perf/ui/gtk/util.c
@@ -2,6 +2,7 @@
 #include "../util.h"
 #include "gtk.h"
 
+#include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -48,6 +49,25 @@ void perf_gtk__quit_error_dialog(void)
 	g_slist_foreach(perf_gtk__error_loops, perf_gtk__quit_loop, NULL);
 }
 
+/*
+ * perf_gtk__signal() runs perf_gtk__quit_error_dialog() from a signal
+ * handler, which can preempt perf_gtk__error() while it is updating
+ * perf_gtk__error_loops below. Block those signals around the update so
+ * the list is never traversed half-modified.
+ */
+static void perf_gtk__block_exit_signals(sigset_t *old_set)
+{
+	sigset_t set;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGSEGV);
+	sigaddset(&set, SIGFPE);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGQUIT);
+	sigaddset(&set, SIGTERM);
+	sigprocmask(SIG_BLOCK, &set, old_set);
+}
+
 static void perf_gtk__dialog_response(GtkDialog *dialog,
 				      gint response_id __maybe_unused,
 				      gpointer data __maybe_unused)
@@ -61,6 +81,7 @@ static int perf_gtk__error(const char *format, va_list args)
 	GtkWidget *dialog;
 	GMainLoop *loop;
 	va_list args_copy;
+	sigset_t old_set;
 
 	va_copy(args_copy, args);
 	if (!perf_gtk__is_active_context(pgctx) ||
@@ -86,7 +107,9 @@ static int perf_gtk__error(const char *format, va_list args)
 	 * outlive the dialog and hang.
 	 */
 	loop = g_main_loop_new(NULL, FALSE);
+	perf_gtk__block_exit_signals(&old_set);
 	perf_gtk__error_loops = g_slist_prepend(perf_gtk__error_loops, loop);
+	sigprocmask(SIG_SETMASK, &old_set, NULL);
 	g_signal_connect(dialog, "response",
 			 G_CALLBACK(perf_gtk__dialog_response), NULL);
 	g_signal_connect_swapped(dialog, "destroy",
@@ -94,7 +117,9 @@ static int perf_gtk__error(const char *format, va_list args)
 
 	gtk_widget_set_visible(dialog, TRUE);
 	g_main_loop_run(loop);
+	perf_gtk__block_exit_signals(&old_set);
 	perf_gtk__error_loops = g_slist_remove(perf_gtk__error_loops, loop);
+	sigprocmask(SIG_SETMASK, &old_set, NULL);
 	g_main_loop_unref(loop);
 
 	free(msg);
@@ -120,7 +145,7 @@ static int perf_gtk__warning_info_bar(const char *format, va_list args)
 	gtk_label_set_text(GTK_LABEL(pgctx->message_label), msg);
 	gtk_info_bar_set_message_type(GTK_INFO_BAR(pgctx->info_bar),
 				      GTK_MESSAGE_WARNING);
-	gtk_widget_show(pgctx->info_bar);
+	gtk_widget_set_visible(pgctx->info_bar, TRUE);
 
 	free(msg);
 	return 0;

-- 
2.54.0

