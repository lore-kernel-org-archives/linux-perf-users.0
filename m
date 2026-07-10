Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116638757B
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661809; cv=none; b=su4YfeCSOdPVmtS8qgIbS+WDRkZ1PC2SqHKrzDXae4N4ef9gotn9AexqF09dst8GsovWLPq9e+tRmn6FnTumOoyyDT0oVz6GkcPvyS95uJdi1Irjy3PMS2ZfigEWTSpGhShFTz9iIsWBWZ/zmFqTVtoOm3+uyPvrJUlhg6VcaaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661809; c=relaxed/simple;
	bh=PlvfWjyYZ00a2OlTExi+JmlSa7RHuQmUFjyHuy8zMq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AA9CmF/ALwKiZvu0qF7DkVFQkOTGUHxkVtKgLaqbObs6fFHYE5fj89bdlTtjHi6VpEXo8TJhcD2LvVjKtwSudcLDO4j4zNOJ1okHSVvwxRquFiItRCs8jRVz+TyXFc3z13sAFLsKCNf0WFuChXvhJd4A+gb5/uPzT5/eWYeioOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwGv9y5o; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwGv9y5o"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88e0d11a3fso553574a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 22:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783661807; x=1784266607; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AO7o9uHk5qwMxVfw83e0kgYUfwKsY1O5JJvpua8VSHw=;
        b=vwGv9y5o8hN9g8B5tV6RGrvbJVRCN2z7WoGGhyxTtaRCZAGRVAPENscc/dwXpvn3ED
         y/iDwLHRhE0kWZdZWc0ndi9DhhPy5cgnEUQGAzKeSCeJQICDHpZn8wGhiykIQL/fFLQO
         eZmw1+C0WYJ3YjpKadyCe1KVktAFaHR1oUgREHPFqNPd4HJcTAE8T+NZcy0baj6sLZoq
         8YAf1jXdPhBfKu47KYSi8Gy2eX781Tq/ICF2oV0yboDTtYvZ6H2BercoqVZfnu/ydX93
         6oQGNwp13pugZgu1jx2JOx5G9a3AJ1mWMnbqisNo1QaI07VZ2uJNwWSBNATpd2C/e85m
         cByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661807; x=1784266607;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AO7o9uHk5qwMxVfw83e0kgYUfwKsY1O5JJvpua8VSHw=;
        b=V7WbQAd1++IqiI11MB28roaAyeToSj9ty3E9RenYjf/KKxH0N7UyPNNQSJZX/TQJhe
         Nu1J+EGdtRKZ1umQA6w1fAv1Atx+PwCqS3sDgY0fS6gWxKzfXDfgCsnk4zjMRIhGycW7
         km3Lk64RyTlNg9u4X+g/GvlO4HHWq+d2OJvIu5h69bN5t0iUxqpq5FL6l3nmLoqINfru
         yfDpePohfDUQTprPXTuj+jG1O7nEVWFge4pQgMHfOBt76i5wm5//igwKEuNm+VsYX+J9
         sDsJFq2G80a5OokjUTNGhycCssO7bsg9YM+wMFx+Kxb3mrvUDkTsD0cIJh2+GebLtIZM
         htHg==
X-Forwarded-Encrypted: i=1; AHgh+Rr94lIHA6NUrtwEQuyM3R9BjyYgwk2ijai2kI/iB67wVgg8uMJUs5ie9In3d3QR7Cj8dwZhkPIq/JSVymqlKVJ0@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvpp3FCqabd6ykdONdY2BV7wqnDa6HFw5jZl0GBv7mBNJo78G
	HCvaWs2oAlErocruFLB7kBcvqBaqNwZex8Up8mAcqFeSAkNoQ7NMxozEydbkuI5geQQetIQfanv
	j7wGvhaZ/Aw==
X-Received: from dlbuu14.prod.google.com ([2002:a05:7022:7e8e:b0:13b:8641:cbb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12d0:b0:3bf:b228:10ae
 with SMTP id adf61e73a8af0-3c0bc8aa66cmr12070900637.5.1783661806635; Thu, 09
 Jul 2026 22:36:46 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:36:25 -0700
In-Reply-To: <20260710053628.1861645-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710024952.1668911-1-irogers@google.com> <20260710053628.1861645-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710053628.1861645-7-irogers@google.com>
Subject: [PATCH v5 07/10] perf ui hists: In report UI ensure thread is set
 with reference counting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
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
2.55.0.795.g602f6c329a-goog

