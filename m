Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF23ACA51
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186655; cv=none; b=HwnSO4PDFwjUpsZpkZf82ofmq1AJCxBj5gYsXtSrgAUK26ektN7qkeJmDzRvlSgN428yIfKNmjOGBMarq/7ge5BEGOyn/X3S5AVuafHWQimgRFPq3se6C9JUc4698buu6cNna9s7MjNn3uY/4dwWujbmyLiAyWiGNXVvNsE3TG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186655; c=relaxed/simple;
	bh=x1HSkkH2Je6cDLLf4AE86mt8e9K44TLWHmrkRfKVAJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SLjEZAMyx85XPTKHYYvUB6ytCFgUhcIygUBOniQ0NhiX2oUmpdKBrJ6i9xhuLtBJ54Kn9B5eO4sxp328Mkt2VrGoYPDzgypi1ij0SR6DTTdQJEVYIs42ghUx9VDBnLuH5biGq/mavcs7ccPucpcEl7XYs3pPeJxA/jX8EQ+UOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axWxGUUx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axWxGUUx"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38dbf293831so6716688a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186647; x=1784791447; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ViooJuCuT7nawLxU+EzfdjJq+a7CQwgEFBy2gpu3I/I=;
        b=axWxGUUx1w4A9tV2dVLiEpooIJQOqiVShYSv5kZTX7KZEW4g0B7t2re9QVNpInAo6b
         EQMZJ2nLaSLYj4rqde1t0aHKeikyx5z8SF+20fx3tt6cWmeXL0QlI8xxsfsT1uT3DOyP
         asQNxrrwlvkYbvsEr07FJYZaUFTCclwdWMLDnhU7uXZy3xjG/51hVybIlGK/TAeBqb5y
         Jff2JhnFF7YlxeXLWNgIKsF/M9FUQU+v8zOtSjfUmSRsODFpnNgwJW5R7O3c25aWn3Nh
         +gk7pB5HdWZh1tmSiyMPb5NMnwJUZpda9E6EdjCiEA221CsUR9QWCFnfd+HQkHctG828
         gh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186647; x=1784791447;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ViooJuCuT7nawLxU+EzfdjJq+a7CQwgEFBy2gpu3I/I=;
        b=ZPBUAYMcG4vKECR/jkBel5VU2cTA2a5rJq06FTt5tUXld3zV0SKR6OqBELTu95tOPc
         XZDTgCqZ0eFEGv3wUo1fUg0tDt4lwmTyO8YbZXZetaRntu6a63E1Elmbkey0U8HB2g6t
         H4n6RAGtrXLYw2pv5TJc1qjzazqXXFcR9QiTNAqrc2+7+DIlnGm8guuBv2GkLgBTSa59
         1dBEijOicZhAo7v/dG1hM8MX/u1oNBsfdvKvOvOT5rfKDR7YgL30d2ZWTrissb9oxiIC
         Vp6JwBfwT6WzuZpIFAi75ChWAgiGe4zYEYefruPh1j7dNvK8N1OzPrDctYyGXQMqLWaL
         ebfA==
X-Forwarded-Encrypted: i=1; AHgh+RqC7MNF1N0sZdPtb4d3gyvX6peJ7d2+Ep6WJQTgwbQSBMeVbfrvwwY1ljbBosZxZt9HMJl1MV8rnu27LCwXJiCL@vger.kernel.org
X-Gm-Message-State: AOJu0YwdW3UYesbkohXXMqH4oTcjJ9J0qj/yuuNH9xP0IPUGS3Rq5DGx
	xEnEtXczfZAQAxH91tSWMtf1Kysku631NYGGTUuQd1iAyVvNiWkFhhHBGcselsiYI5/dq38AUA1
	moWW6Y/dD4Q==
X-Received: from dycue4.prod.google.com ([2002:a05:7300:84:b0:310:be63:e100])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510f:b0:387:e0db:3faf
 with SMTP id 98e67ed59e1d1-38dc7793df1mr19173114a91.40.1784186647129; Thu, 16
 Jul 2026 00:24:07 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:48 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-7-irogers@google.com>
Subject: [PATCH v6 07/10] perf ui hists: In report UI ensure thread is set
 with reference counting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Populates the map_symbol thread in the UI code to fix the e_machine
lookup for cross-platform disassembly when using the annotate action.
At the same time, refactor the UI options and actions generation to
comply with the perf subsystem's strict reference counting abstraction
requirements for 'struct map_symbol' and 'struct thread'. Introduce
explicit reference acquiring via map_symbol__copy() and thread__get() for
menu items, safely clean them up between menu iterations using a new
free_popup_actions() helper, and utilize insulated temporary action
variables for direct hotkey handler execution.

Assisted-by: Antigravity:gemini-3.5-flash
Reported-by: Josh Stone <jistone@redhat.com>
Fixes: 0e26ba5a8774 ("perf disasm: Refactor arch__find and initialization of arch structs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 103 ++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 34 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 07a2e18f8aaf..b0d421768dc5 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2357,6 +2357,16 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 	return printed;
 }
 
+struct popup_action {
+	unsigned long		time;
+	struct thread		*thread;
+	int (*fn)(struct hist_browser *browser, struct popup_action *act);
+	struct map_symbol	ms;
+	int			socket;
+	enum rstype		rstype;
+
+};
+
 static inline void free_popup_options(char **options, int n)
 {
 	int i;
@@ -2365,6 +2375,14 @@ static inline void free_popup_options(char **options, int n)
 		zfree(&options[i]);
 }
 
+static inline void free_popup_actions(struct popup_action *actions, int n)
+{
+	int i;
+
+	for (i = 0; i < n; ++i)
+		map_symbol__exit(&actions[i].ms);
+}
+
 /*
  * Only runtime switching of perf data file will make "input_name" point
  * to a malloced buffer. So add "is_input_name_malloced" flag to decide
@@ -2454,16 +2472,6 @@ static int switch_data_file(void)
 	return ret;
 }
 
-struct popup_action {
-	unsigned long		time;
-	struct thread 		*thread;
-	int (*fn)(struct hist_browser *browser, struct popup_action *act);
-	struct map_symbol 	ms;
-	int			socket;
-	enum rstype		rstype;
-
-};
-
 static int
 do_annotate(struct hist_browser *browser, struct popup_action *act)
 {
@@ -2541,7 +2549,7 @@ add_annotate_opt(struct popup_action *act, char **optstr,
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
 		return 0;
 
-	act->ms = *ms;
+	map_symbol__copy(&act->ms, ms);
 	act->fn = do_annotate;
 	return 1;
 }
@@ -2628,7 +2636,7 @@ add_thread_opt(struct hist_browser *browser, struct popup_action *act,
 	if (ret < 0)
 		return 0;
 
-	act->thread = thread;
+	act->ms.thread = thread__get(thread);
 	act->fn = do_zoom_thread;
 	return 1;
 }
@@ -2675,7 +2683,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 		     __map__is_kernel(map) ? "the Kernel" : dso__short_name(map__dso(map))) < 0)
 		return 0;
 
-	act->ms.map = map;
+	act->ms.map = map__get(map);
 	act->fn = do_zoom_dso;
 	return 1;
 }
@@ -2720,7 +2728,7 @@ add_map_opt(struct hist_browser *browser,
 	if (asprintf(optstr, "Browse map details") < 0)
 		return 0;
 
-	act->ms.map = map;
+	act->ms.map = map__get(map);
 	act->fn = do_browse_map;
 	return 1;
 }
@@ -2800,7 +2808,7 @@ add_script_opt_2(struct popup_action *act, char **optstr,
 			return 0;
 	}
 
-	act->thread = thread;
+	act->ms.thread = thread__get(thread);
 	act->ms.sym = sym;
 	act->fn = do_run_script;
 	return 1;
@@ -3095,6 +3103,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 		key = 0; // reset key
 do_hotkey:		 // key came straight from options ui__popup_menu()
+		free_popup_options(options, MAX_OPTIONS);
+		free_popup_actions(actions, MAX_OPTIONS);
 		choice = nr_options = 0;
 		key = hist_browser__run(browser, helpline, warn_lost_event, key);
 
@@ -3154,24 +3164,40 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			}
 
 			if (!browser->selection->sym) {
+				struct map_symbol source_ms;
+
 				if (!browser->he_selection)
 					continue;
 
+				memset(&source_ms, 0, sizeof(source_ms));
+
 				if (sort__mode == SORT_MODE__BRANCH) {
 					bi = browser->he_selection->branch_info;
 					if (!bi || !bi->to.ms.map)
 						continue;
 
-					actions->ms.sym = symbol__new_unresolved(bi->to.al_addr, bi->to.ms.map);
-					actions->ms.map = bi->to.ms.map;
+					source_ms.sym =
+						symbol__new_unresolved(
+							bi->to.al_addr,
+							bi->to.ms.map);
+					source_ms.thread = bi->to.ms.thread;
+					source_ms.map = bi->to.ms.map;
 				} else {
-					actions->ms.sym = symbol__new_unresolved(browser->he_selection->ip,
-										 browser->selection->map);
-					actions->ms.map = browser->selection->map;
+					source_ms.sym =
+						symbol__new_unresolved(
+							browser->he_selection->ip,
+							browser->selection->map);
+					source_ms.thread = browser->selection->thread;
+					source_ms.map = browser->selection->map;
 				}
 
-				if (!actions->ms.sym)
+				if (!source_ms.sym)
 					continue;
+
+				memset(&hotkey_act, 0, sizeof(hotkey_act));
+				map_symbol__copy(&hotkey_act.ms, &source_ms);
+				do_annotate(browser, &hotkey_act);
+				map_symbol__exit(&hotkey_act.ms);
 			} else {
 				if (symbol__annotation(browser->selection->sym)->src == NULL) {
 					ui_browser__warning(&browser->b, delay_secs * 2,
@@ -3181,18 +3207,20 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					continue;
 				}
 
-				actions->ms.map = browser->selection->map;
-				actions->ms.sym = browser->selection->sym;
+				memset(&hotkey_act, 0, sizeof(hotkey_act));
+				map_symbol__copy(&hotkey_act.ms, browser->selection);
+				do_annotate(browser, &hotkey_act);
+				map_symbol__exit(&hotkey_act.ms);
 			}
-
-			do_annotate(browser, actions);
 			continue;
 		case 'P':
 			hist_browser__dump(browser);
 			continue;
 		case 'd':
-			actions->ms.map = map;
-			do_zoom_dso(browser, actions);
+			memset(&hotkey_act, 0, sizeof(hotkey_act));
+			hotkey_act.ms.map = map__get(map);
+			do_zoom_dso(browser, &hotkey_act);
+			map_symbol__exit(&hotkey_act.ms);
 			continue;
 		case 'k':
 			if (browser->selection != NULL)
@@ -3207,12 +3235,16 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					   verbose);
 			continue;
 		case 't':
-			actions->thread = thread;
-			do_zoom_thread(browser, actions);
+			memset(&hotkey_act, 0, sizeof(hotkey_act));
+			hotkey_act.ms.thread = thread__get(thread);
+			do_zoom_thread(browser, &hotkey_act);
+			map_symbol__exit(&hotkey_act.ms);
 			continue;
 		case 'S':
-			actions->socket = socked_id;
-			do_zoom_socket(browser, actions);
+			memset(&hotkey_act, 0, sizeof(hotkey_act));
+			hotkey_act.socket = socked_id;
+			do_zoom_socket(browser, &hotkey_act);
+			map_symbol__exit(&hotkey_act.ms);
 			continue;
 		case '/':
 			if (ui_browser__input_window("Symbol to show",
@@ -3230,9 +3262,11 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			continue;
 		case 'r':
 			if (is_report_browser(hbt)) {
-				actions->thread = NULL;
-				actions->ms.sym = NULL;
-				do_run_script(browser, actions);
+				memset(&hotkey_act, 0, sizeof(hotkey_act));
+				hotkey_act.ms.thread = NULL;
+				hotkey_act.ms.sym = NULL;
+				do_run_script(browser, &hotkey_act);
+				map_symbol__exit(&hotkey_act.ms);
 			}
 			continue;
 		case 's':
@@ -3457,6 +3491,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 	}
 out_free_stack:
 	pstack__delete(browser->pstack);
+	free_popup_actions(actions, MAX_OPTIONS);
 	zfree(&hists->symbol_filter_str);
 	hists__filter_by_symbol(hists);
 out:
-- 
2.55.0.141.g00534a21ce-goog

