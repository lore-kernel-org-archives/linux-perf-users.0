Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17939A7F2
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615950; cv=none; b=bQ94KnKbKqFsAFk7OEVn04qdLHH3SqFcvRCEXpt594FnUeughyW7hsm03G8dVy/6MP4YwpHLLJnnyOeLlAqPX5OVUoM6khKXes1PFtnBZcQWMnvv8TuEhkFIU1i5LvqyW98UMEcmcAYbox+5qbTHUTNAVcIMcdbQ7enzU3OFX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615950; c=relaxed/simple;
	bh=mhuzb7twXL2MKhFsI30i0fHd+yvuH0xLfzxhDfC6PHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jP5cMYXAYZlqyO5gxDuL3pYIscUj4mhqgBz2LsDi60q+fzYrK2qaXTIMoZbBIcwgdxA/OJha6c80dhmWpsZbSVtBIRYggw2ZG2YwlUXVIhbQtznIuM9x5bR9B/HHmiD7XIRMpnlJngUR4jlc1UiQtrOp+PX59JENwOC4qjdhlxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnQvO+NJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnQvO+NJ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c860544c077so92397a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783615948; x=1784220748; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cA790uSnKU/9JceTicDTrTP0WXo5wim3FYNyT5yZiew=;
        b=mnQvO+NJbPIReN37DqQKgkuV3u0wGY45ya/mXfFQ89ao5AIkyAOWqUiPyyCzH8tQqp
         4piz4OIERNoeostFMao4UOF9W5D5yVQF4biIF/AOR5ZTTgAtH3jLlX0FIujW4Ei7akYO
         cjx0zLaHw9irArEJquGgZkVupOmqJ2B5LaYTyTZmwMAj9JopmnG3dmXuKvv5L575+/0+
         kCy6Fl/BDAwRXotRo3GTvT4Wy4JO8et+OFDxyhl5maYEKBYjgqaS1fI97/+emOZQSnIO
         lqDEABptS2nEpkCIUGzv6PLE8HLH9h+SYwK3EgAsj+dRRJtWuHSCoaY9nihnct191Nnq
         L49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615948; x=1784220748;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cA790uSnKU/9JceTicDTrTP0WXo5wim3FYNyT5yZiew=;
        b=iDUmH4XQjgCFSgGztTYBAWv93mctzwL5g4t/5aVMt6IyxQit0aw1DaemTMRKfZzpmm
         OhcZRpQO+jgqY5Dnh1aG73+9jCRNyqs3Hut0vnYljKE5lqhVtw9cx2/oDzuTxDVM7iee
         x+vCayI/Ax0zuzUERbMizHeCt2u3MUIbqE8Xqba8gBV1BINux9bUtze0yywcirhJfCID
         6Z02rbYTr3tvQ//pc384TWIhK0EqGIWbctnlUdXcsjtJcJu16AoOP5CwxfTAGJJpMNCf
         lR/kwL8jWNkAxF8vAIzNN7EizzawN7niYxwo3TBiDP+PxYnohKmMuv7NlQOVS03lzBzC
         tinA==
X-Forwarded-Encrypted: i=1; AHgh+Rp37lqgZaGiiDsXZIR414VJV+2KHz6CsgtQVca4sGA031nqPgVg7BU6l3pcfmWR3ee0FXImfzmh2dL2NCYiQphi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5fNVS2kbWOa3l7TRjPPFxbb21mOawqYOYZV7kvyOraZCWD22l
	w4sqooopgBfz0PHz3WkVX8tk3vcBwtp018fjt0QeABbQ/A5lsBZ2AE4/A4NeW2h1f3REu9OoAmT
	4fnMN8gjG4Q==
X-Received: from dlb32.prod.google.com ([2002:a05:7022:620:b0:138:51b:792c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d495:b0:3b2:a809:ffe
 with SMTP id adf61e73a8af0-3c0bcf162edmr10197269637.14.1783615948149; Thu, 09
 Jul 2026 09:52:28 -0700 (PDT)
Date: Thu,  9 Jul 2026 09:52:18 -0700
In-Reply-To: <20260709165220.1411149-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709033701.1117943-1-irogers@google.com> <20260709165220.1411149-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709165220.1411149-2-irogers@google.com>
Subject: [PATCH v3 2/4] perf ui hists: Remove duplicated thread in popup_action
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
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

