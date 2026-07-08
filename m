Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5C39D6F6
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554426; cv=none; b=sO/xglEmbk7eUC41BdeDhM0d9Kt+19X/YY8Chh/abDlm8L6HvYSALQFXwZWK8282owShas6uHOB/RY/T4H7gIdqKANkCYfssu9NKmhF3uJob6O9RbmpiJoacEYBqBp6CirRHtgjMnOO1jyyI4prFOqPmJvsDGIvpBW1hcSUc8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554426; c=relaxed/simple;
	bh=mhuzb7twXL2MKhFsI30i0fHd+yvuH0xLfzxhDfC6PHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OVnn8/1gXZSH6d1LTtWmtmJSMR5rfmnAjo5eMkeTC+FOxISxWLW6tQfRVXHLj3/Nkg7cJOLW0A4L0NYDocVKtjUIok4MpJck891zC2rp86O0H6VuRo1UaW0P7mkahnHBJN74r5AqFDZjJol1NPaC1Cw5hwJADgl/BwY5tFTfzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTK67Li1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTK67Li1"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca124bf0189so264426a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554425; x=1784159225; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cA790uSnKU/9JceTicDTrTP0WXo5wim3FYNyT5yZiew=;
        b=sTK67Li1btKvzUSCT4QG2n9NMAw1x1XRjf62MagN3xLv+Qhe01KCr723VawNoVy1Z1
         iU4Uvo/ko0cMIyktUDA/0bCMY3i06Q21bT3aB3dlHfUuRjaBWIF9VdBTukxn5tfyR2Pd
         LQXRQO3FCQigGYV0jAVXdNiUP1Q4aRBC7owtWvBwV1VcxbiS3ZOTP/s/tldGJj8JOyAl
         sU1XeKgN3X69/nKSQhPReaGgCOtQnpDsWgOnyMjiu17WrHYn99A8Iv+rqroKpVwR7Lk6
         7g5Jfermr1+6u7AAu/TvVCLu+yMHB4OftctEOHnXUMWn2jnR60Kg6IZ3sV7fMDtklKA7
         L0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554425; x=1784159225;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cA790uSnKU/9JceTicDTrTP0WXo5wim3FYNyT5yZiew=;
        b=YRiKUbP0muPA1EdjwmMjwehC004eO6gMk2rt66BycJeKHm4YkjAFpIBg467uwbag5t
         7IdB3XDVkeZew9EwcVH7c5MKvSAUH95vM9fqUzAP10ex+2pVC4qE4HCCl0VWQtu4/Dzq
         +0eA9dMAEJ2YnvubtKGb8JloGSZ+iWQxtcKt8jlC0v1TAOXOFN/nHIttC1vJKzmWbZUA
         +SsuUrWzdNm6LAR7BkNP9TJAr/0B8bFWMuETJ/ZMLn0fCR/O4BOom/KhENz8k7mX0Snh
         o9r03lcipm3xmL9GmLK8Cc+zLrMeZqL+8wjk6lgOazJNlygOPyUOmmLebLf/vRabVgUP
         gfRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLgKgIOeTsoHmb7CyxvlOKq15U3we1dx7qTHK7cEs+SI3G2jYiBVxOrsmZevRoGdE0NkDxWJLacIxUC15ekOdP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53N3fG+cxdfBKIBEske1LLKNKpxD5xUAOIYCqGBLg9Xf1W6AB
	2xN/4zcLbmWsMaz3sxl0XVr/ychuWhAja53bN/cf4pDX2hScAiowFJp4rpWKRGt6Sunb/etCipY
	H7OtSlXcYpg==
X-Received: from dldz9-n1.prod.google.com ([2002:a05:701b:4189:10b0:13b:7bb5:4190])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d612:b0:3b4:8c67:51d4
 with SMTP id adf61e73a8af0-3c0d6c71f42mr514696637.39.1783554424542; Wed, 08
 Jul 2026 16:47:04 -0700 (PDT)
Date: Wed,  8 Jul 2026 16:46:45 -0700
In-Reply-To: <20260708234646.1040003-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708234646.1040003-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234646.1040003-2-irogers@google.com>
Subject: [PATCH v1 2/3] perf ui hists: Remove duplicated thread in popup_action
From: Ian Rogers <irogers@google.com>
To: Josh Stone <jistone@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Tianyou Li <tianyou.li@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Zecheng Li <zecheng@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only
ever 1 thread with a popup_action.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f8ffd9b73582..c032068568d5 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2455,7 +2455,6 @@ static int switch_data_file(void)
 
 struct popup_action {
 	unsigned long		time;
-	struct thread 		*thread;
 	int (*fn)(struct hist_browser *browser, struct popup_action *act);
 	struct map_symbol 	ms;
 	int			socket;
@@ -2572,7 +2571,7 @@ add_annotate_type_opt(struct popup_action *act, char **optstr,
 static int
 do_zoom_thread(struct hist_browser *browser, struct popup_action *act)
 {
-	struct thread *thread = act->thread;
+	struct thread *thread = act->ms.thread;
 
 	if ((!hists__has(browser->hists, thread) &&
 	     !hists__has(browser->hists, comm)) || thread == NULL)
@@ -2627,7 +2626,7 @@ add_thread_opt(struct hist_browser *browser, struct popup_action *act,
 	if (ret < 0)
 		return 0;
 
-	act->thread = thread;
+	act->ms.thread = thread;
 	act->fn = do_zoom_thread;
 	return 1;
 }
@@ -2733,8 +2732,8 @@ do_run_script(struct hist_browser *browser,
 	int n = 0;
 
 	len = 100;
-	if (act->thread)
-		len += strlen(thread__comm_str(act->thread));
+	if (act->ms.thread)
+		len += strlen(thread__comm_str(act->ms.thread));
 	else if (act->ms.sym)
 		len += strlen(act->ms.sym->name);
 	script_opt = malloc(len);
@@ -2742,9 +2741,9 @@ do_run_script(struct hist_browser *browser,
 		return -1;
 
 	script_opt[0] = 0;
-	if (act->thread) {
+	if (act->ms.thread) {
 		n = scnprintf(script_opt, len, " -c %s ",
-			  thread__comm_str(act->thread));
+			  thread__comm_str(act->ms.thread));
 	} else if (act->ms.sym) {
 		n = scnprintf(script_opt, len, " -S %s ",
 			  act->ms.sym->name);
@@ -2799,7 +2798,7 @@ add_script_opt_2(struct popup_action *act, char **optstr,
 			return 0;
 	}
 
-	act->thread = thread;
+	act->ms.thread = thread;
 	act->ms.sym = sym;
 	act->fn = do_run_script;
 	return 1;
@@ -3202,7 +3201,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					   verbose);
 			continue;
 		case 't':
-			actions->thread = thread;
+			actions->ms.thread = thread;
 			do_zoom_thread(browser, actions);
 			continue;
 		case 'S':
@@ -3222,7 +3221,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			continue;
 		case 'r':
 			if (is_report_browser(hbt)) {
-				actions->thread = NULL;
+				actions->ms.thread = NULL;
 				actions->ms.sym = NULL;
 				do_run_script(browser, actions);
 			}
@@ -3305,7 +3304,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 				 */
 				do_zoom_dso(browser, actions);
 			} else if (top == &browser->hists->thread_filter) {
-				actions->thread = thread;
+				actions->ms.thread = thread;
 				do_zoom_thread(browser, actions);
 			} else if (top == &browser->hists->socket_filter) {
 				do_zoom_socket(browser, actions);
-- 
2.55.0.795.g602f6c329a-goog

