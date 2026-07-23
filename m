Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898037E5DB
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782805; cv=none; b=pch2c9bXMfJ9eUmbk4EprTVHf2FBiduIZLj72xOVJLdyJ4wUbgj6hcJqtb2aj9StP8YSoItxJoqopSQskCbTaiUdtdgCzuynVaVsn0XrwefhPpKSmggapUEoRQOfV77FuJnAqVb/XWNN7qnoFmd4E3XFsyPCU16ZDKYccou5r9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782805; c=relaxed/simple;
	bh=kh31A68W6fp1QIuEyOVeIzYBsOxWc/ieYSLlFZuHODA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BZiVwShnzseyZf2VrECfHENcX3mZtKifced1Fba9YvbBGoIIN8ce93dXCK8BbAEYqkzdB4B5TGBbZ+JSA8pvc/UrfmCr4ZOZ9Q7wlFBz5IwupbRzZ5ZXZYUZpc/iqMGP5WmpeXYGyCJFSgIZ3s+/CPHY5cJ7QPl5v4g/ULj4Tkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LOlQpZV3; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LOlQpZV3"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf6acd760cso4475105ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784782800; x=1785387600; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoVRrd065X4nNSzDa7DxgDBAhVFsnDoscw8jyLzmHP4=;
        b=LOlQpZV3CrHqsneX3U7nAATjCl8L6P+vHj1Js6gCtoX0j45ITEx50SeWiJXanqGLK0
         D4j80p3TpnTgS7eF1L9tNZDR0bDF5GGllx+0NWHGiZsFgDbs/+YuLgfFT+aSUAo+TZvQ
         IF1BVXqSfWysJ77PZfRAZcsh3A/lRPGDE1wiY3ggu6trmpRRDeysAW+D7dSO1qwYgKPh
         skZHHYnXZl9DAiJYxge9S2jJt/qnUicmTuyICsi0GWRq6Ieq66V95l+144HgIu13zagC
         MFHGJMeXdKIxKQZAw+nwC+EYx2vBcd+jSpuTIl7oLQyOKhBs1JLOc9mm5Q/LmIavEZnd
         szag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782800; x=1785387600;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hoVRrd065X4nNSzDa7DxgDBAhVFsnDoscw8jyLzmHP4=;
        b=oV0919Z8rxvgndwOobeteRBRtrWWkDQrDuSFYFNlPFLRXUEkoHDr21LhZcrwuAYKQ7
         vUty6V2BrWI4p6rW+WMdPOHquUEPR8RKPUogjjW78mS/pR79PTg493jRu3KPdNOaXrRE
         FzMa+0h5GTvQ7uW3cvGXlRXD4ooLZzRhJcj+/ibRTlrRJpaAD/pj2VTjZriBlfki4GKI
         FUU2UKOhjD6g9JcRcBYAuhTyq7km0OjkdsacGXIk7lbw8qgjhP8DP2VJqiDgmeO0MIFf
         ZzzEcK70Y5jNu1LslitP1U7bpjHKxCRjnoC7Nk950wI9Tr0wr4mpfv3PzNKcIBjIQJo4
         Mofw==
X-Forwarded-Encrypted: i=1; AHgh+RqGRpw4W1orDaZHRozfO3UPXKkWUn7rehuJtLzrdNZGi4pGrsxSbQLrPlEcg/1dC5Ns7IVbNaQWJiGkn8Y4cG2L@vger.kernel.org
X-Gm-Message-State: AOJu0YxeTRSm76/iTIFrk8Otm0eOkomHfq/TbFxnt9vWQBN3ZiYFOmCj
	5qCaxumnQS9UHe/oEJHdaWDfAdkx2SA5a1Uu+8btw6nfk+d28G02ScNZswtxo0mjywpUIYrT6AR
	CtibXEu0Ryw==
X-Received: from dlep8-n2.prod.google.com ([2002:a05:701b:4588:20b0:13c:e55a:19d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c784:b0:3ba:f5c7:6bc3
 with SMTP id adf61e73a8af0-3c44afcd253mr1547604637.10.1784782799976; Wed, 22
 Jul 2026 21:59:59 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:59:46 -0700
In-Reply-To: <20260723045949.988740-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716072351.560311-1-irogers@google.com> <20260723045949.988740-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723045949.988740-4-irogers@google.com>
Subject: [PATCH v7 3/6] perf ui hists: In report UI ensure thread is set with
 reference counting
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

Fixes: 0e26ba5a8774 ("perf disasm: Refactor arch__find and initialization of arch structs")
Reported-by: Josh Stone <jistone@redhat.com>
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 135 +++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 48 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f5e13fc125c6..684df550ba49 100644
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
@@ -2365,6 +2375,16 @@ static inline void free_popup_options(char **options, int n)
 		zfree(&options[i]);
 }
 
+static inline void free_popup_actions(struct popup_action *actions, int n)
+{
+	int i;
+
+	for (i = 0; i < n; ++i) {
+		map_symbol__exit(&actions[i].ms);
+		memset(&actions[i], 0, sizeof(struct popup_action));
+	}
+}
+
 /*
  * Only runtime switching of perf data file will make "input_name" point
  * to a malloced buffer. So add "is_input_name_malloced" flag to decide
@@ -2454,16 +2474,6 @@ static int switch_data_file(void)
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
@@ -2541,7 +2551,7 @@ add_annotate_opt(struct popup_action *act, char **optstr,
 	if (asprintf(optstr, "Annotate %s", ms->sym->name) < 0)
 		return 0;
 
-	act->ms = *ms;
+	map_symbol__copy(&act->ms, ms);
 	act->fn = do_annotate;
 	return 1;
 }
@@ -2573,7 +2583,7 @@ add_annotate_type_opt(struct popup_action *act, char **optstr,
 static int
 do_zoom_thread(struct hist_browser *browser, struct popup_action *act)
 {
-	struct thread *thread = act->thread;
+	struct thread *thread = act->ms.thread;
 
 	if ((!hists__has(browser->hists, thread) &&
 	     !hists__has(browser->hists, comm)) || thread == NULL)
@@ -2628,7 +2638,7 @@ add_thread_opt(struct hist_browser *browser, struct popup_action *act,
 	if (ret < 0)
 		return 0;
 
-	act->thread = thread;
+	act->ms.thread = thread__get(thread);
 	act->fn = do_zoom_thread;
 	return 1;
 }
@@ -2675,7 +2685,7 @@ add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 		     __map__is_kernel(map) ? "the Kernel" : dso__short_name(map__dso(map))) < 0)
 		return 0;
 
-	act->ms.map = map;
+	act->ms.map = map__get(map);
 	act->fn = do_zoom_dso;
 	return 1;
 }
@@ -2720,7 +2730,7 @@ add_map_opt(struct hist_browser *browser,
 	if (asprintf(optstr, "Browse map details") < 0)
 		return 0;
 
-	act->ms.map = map;
+	act->ms.map = map__get(map);
 	act->fn = do_browse_map;
 	return 1;
 }
@@ -2734,8 +2744,8 @@ do_run_script(struct hist_browser *browser,
 	int n = 0;
 
 	len = 100;
-	if (act->thread)
-		len += strlen(thread__comm_str(act->thread));
+	if (act->ms.thread)
+		len += strlen(thread__comm_str(act->ms.thread));
 	else if (act->ms.sym)
 		len += strlen(act->ms.sym->name);
 	script_opt = malloc(len);
@@ -2743,9 +2753,9 @@ do_run_script(struct hist_browser *browser,
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
@@ -2800,7 +2810,7 @@ add_script_opt_2(struct popup_action *act, char **optstr,
 			return 0;
 	}
 
-	act->thread = thread;
+	act->ms.thread = thread__get(thread);
 	act->ms.sym = sym;
 	act->fn = do_run_script;
 	return 1;
@@ -3097,6 +3107,8 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 		key = 0; // reset key
 do_hotkey:		 // key came straight from options ui__popup_menu()
+		free_popup_options(options, MAX_OPTIONS);
+		free_popup_actions(actions, MAX_OPTIONS);
 		choice = nr_options = 0;
 		key = hist_browser__run(browser, helpline, warn_lost_event, key);
 
@@ -3156,24 +3168,40 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
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
@@ -3183,18 +3211,20 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
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
@@ -3209,12 +3239,16 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
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
@@ -3232,9 +3266,11 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
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
@@ -3306,20 +3342,19 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 				continue;
 			}
-			actions->ms.map = map;
+			memset(&hotkey_act, 0, sizeof(hotkey_act));
 			top = pstack__peek(browser->pstack);
 			if (top == &browser->hists->dso_filter) {
-				/*
-				 * No need to set actions->dso here since
-				 * it's just to remove the current filter.
-				 */
-				do_zoom_dso(browser, actions);
+				hotkey_act.ms.map = map__get(map);
+				do_zoom_dso(browser, &hotkey_act);
 			} else if (top == &browser->hists->thread_filter) {
-				actions->thread = thread;
-				do_zoom_thread(browser, actions);
+				hotkey_act.ms.thread = thread__get(thread);
+				do_zoom_thread(browser, &hotkey_act);
 			} else if (top == &browser->hists->socket_filter) {
-				do_zoom_socket(browser, actions);
+				hotkey_act.socket = socked_id;
+				do_zoom_socket(browser, &hotkey_act);
 			}
+			map_symbol__exit(&hotkey_act.ms);
 			continue;
 		}
 		case 'q':
@@ -3456,9 +3491,13 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 
 		if (key == K_SWITCH_INPUT_DATA)
 			break;
+
+		free_popup_options(options, MAX_OPTIONS);
+		free_popup_actions(actions, MAX_OPTIONS);
 	}
 out_free_stack:
 	pstack__delete(browser->pstack);
+	free_popup_actions(actions, MAX_OPTIONS);
 out:
 	hist_browser__delete(browser);
 	free_popup_options(options, MAX_OPTIONS);
-- 
2.55.0.229.g6434b31f56-goog

