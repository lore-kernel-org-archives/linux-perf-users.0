Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6D3932E5
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568255; cv=none; b=Nao+7wiCY620RIxDsM6b3wJV/NlTbO39zqruiOtiXlgRdMfri2XPL+WkrbAmrAnkMV79ocl9NCow4mR485rgcWY1H8+Tfh6yeg7R2fY8QhohQePjwTeCpEN3ZS8E/cMYigD3WaTElZyrbY6dkRpB82yDhqscib2CBM27K97Dqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568255; c=relaxed/simple;
	bh=mhuzb7twXL2MKhFsI30i0fHd+yvuH0xLfzxhDfC6PHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qXNuDsyzR8BHIZZ/KwMmdUFCkN9DN/U6Av0xCkoPohKeAUuLkjXzwtj0nN4L/drufuhSJ1fSWiJveL/PiN1tRu/TtkouAaGYcAVan2DH0XHgp5VqF6qeIk1+Y7khgtZufc7WazVfZnnHwtC2XYtwGV0f9LeCdtN6ENPeKqtgRkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LroPPLVj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LroPPLVj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca860baea9fso761574a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783568253; x=1784173053; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cA790uSnKU/9JceTicDTrTP0WXo5wim3FYNyT5yZiew=;
        b=LroPPLVjNe5Tc8W7SKkZJr2bKvj6A5Lg56Bma0eFGg0b4h0G19Nvd6HwNhlEBBqUAv
         Du+I5bwa5TWWdSTljsjG2E9fAdb+Lnv2j86EoIdvtrI6x9/KJ8lwaPUJ7YxLkQlyfkIM
         LdPxIaevFmSLWiHUbcMNBjYxOoD7JNOqBpTs39CK0QSJCvhJyDGy3lj2MRUJGtZEUACc
         f9bQTg3f8iMIxZMBW9/qroeSz6vWa//dRGgXGpBAsxPK0nR6dTuR64/VEkcEf36AVktd
         KkC/Pb5qljmhJD9K/kwjEQ9jaLLz29qoioqg8qBeOngHTKGIJ//ZQ+aeQwXgG3toMpHf
         e3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783568253; x=1784173053;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cA790uSnKU/9JceTicDTrTP0WXo5wim3FYNyT5yZiew=;
        b=cNZaNrksQF5COdSKV6RwsLq73WCv4efZ+rahk9Fqb7X5Fh7ith67ZxswzC4R+dQ4LZ
         r2lPqG5sKU5XHRrs2bW8ek7LsRyz/HPneNoVMz5ax2PSKooNxsSbZLbYnZuB1aIwV8nA
         IyJNEjI87TtHAw5XHMa9eHzlreH9Aw4RzN6UnBGOnAF6vHSoH5VIu8nv96/NHT75+V2I
         T5/1K5KmnEc6Ur9LaaQr5OSPmV0ZTDx8Vl7cNvl2PnyLYHaCUKF2OAFpxYZQyIo8A9KL
         cophyTO4xe7x1IJhp4E4M1F3/T0jtdOXeEO9s2TvzEJmwDFK4dF2Ldxff3prS2wrpcnm
         +RsA==
X-Forwarded-Encrypted: i=1; AHgh+RofzI+fHH223vwHGk4XNJxc5NnbN18NVSlDid7LWcy7jIG0xm2c3/0rWdNY8a0XMEOgb6bKm5YHwLkFAmLbNQIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzE90b74eWB5+gG0kiAxr0ccuGh0KJcmSOm/UU785IA0BW6xQR5
	P+TgR6FlU6HPNKZ3RHAKhCJgEYgyRkvTMQNc5XhHV/IyO+icxIjLQyo92zgYkTgMlZaZ72G1kLS
	6CdPqTdtDQA==
X-Received: from dlbsj7.prod.google.com ([2002:a05:7022:f907:b0:13b:331e:3daa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3394:b0:3bf:d354:134f
 with SMTP id adf61e73a8af0-3c0bd1a8338mr7154976637.44.1783568252817; Wed, 08
 Jul 2026 20:37:32 -0700 (PDT)
Date: Wed,  8 Jul 2026 20:36:59 -0700
In-Reply-To: <20260709033701.1117943-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708234646.1040003-1-irogers@google.com> <20260709033701.1117943-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709033701.1117943-2-irogers@google.com>
Subject: [PATCH v2 2/4] perf ui hists: Remove duplicated thread in popup_action
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

