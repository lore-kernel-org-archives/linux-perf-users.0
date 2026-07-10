Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A33254A5
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651818; cv=none; b=WooBz45VHCzX7iiqj7KJGM1V1dQjQf0+T3Vg8VMdgByMk7sWDUkj2j79Y0V6H/vbuaNWVWGw97k8DUAXtaWZ//xED3poWlaR2fZHtvEfzuAAF0dfzIGw5qQAhbsiOsDmzBCKwcUdMBLBO8hwv1AX7q9erue+Yjgr4rFzpSPQGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651818; c=relaxed/simple;
	bh=5+hFsYtXq05IaOOn6iMdJSPJ+p/Qf0zuBGd5YWR176A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GFztoZSoE2OXKpxOS6J/btT4j3X035jUhMijz8GZH/iy4TWO5uZCj1hTBRpeTqwixgwmsNRe7OF0FwBzT0vHsAZ+wVK2VcySsrnjjNtCV/xHx6r0aBIv4aDYCg0VFRAMSm4+LInk7DpCQCe38ayO3zrnWtZb/uhESitCjovH8do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXu++Q/c; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXu++Q/c"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-384636ba25dso802455a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jul 2026 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783651815; x=1784256615; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pA9Op4Hwz3i31jefMvgPRLUHIl3t8wAVDRT47WA7a0A=;
        b=ZXu++Q/cREdY8VdWwuZiZkjAN8eK0dwQz5hebR1Uj8dARLBH/J1Dgx2vUZJQ9M56Wu
         GJdI4Sbkk1dEKZgUw43/LH5/e8MGWSBLcbeNeCJBt1bSl20GhEkW6912zDdzwlu506oy
         7X3FaITnwXR5GkfeH9wEppEN/crnryMmlPTL5jg/p78bvBN1mm9R1zYEgLJTz9CG3zgA
         pVcJ1Fe7MKMLD2c3rbuga8uhp/05NJvvykFSjzRyc3n0wQWJl/Li1fHL8VeDx+htPssb
         1rXF6UM1DQh9JwhI2U4TzBIue3QDU+M241J0IR5S5vNu315GEfLWufzopYtbgGcHoBki
         Ck6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783651815; x=1784256615;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pA9Op4Hwz3i31jefMvgPRLUHIl3t8wAVDRT47WA7a0A=;
        b=GTvpQN85qhVKEuFqmUwf+o4CeXxcPeBcOvep+iF6o7IhlMdxddoWk/B6khVik8PfJa
         1/fFZcyns6ipmALaq8OvWwQ73gv1Fk33pCZRo1P+rHBm+nlhU5BGLW0dow6xBwZeA1Jf
         zS5aloL5XMLbWlAPdQV2bEENQ53FkzEeOL+WAHF2Wlcjcu/ueRFMMYoMJs5YPrTEDbGi
         oaOdfdOVYgw+I7ddMDDq29TR5Bl/I3ESTw2eVoCTv3D9YODAwf6F1//cyTFxJ0VxB6dX
         MgAJS1pj43jC3e/v8k88u8MzGOeJrWv6pf1ZuVrWHQuxHcN1eMXRg1fMp+Eic/7MFyok
         JNFw==
X-Forwarded-Encrypted: i=1; AHgh+RrynzC7zZCag/ovrqYkv5Ni3Sq6+S7A0y7+oB71NPauQDzE4AMvdAdNxrIv/ncwOzYYk9aLucpA7cXo4u+KObXE@vger.kernel.org
X-Gm-Message-State: AOJu0YzAOV7kxdN0sBjaOyv1HGyZv7HEsTr+1j72psnTA+i2+6Ecumve
	P3fcHpxX+1wg8iI4SVOGQw1Wz0bWaSVJj7THkMTFDgsR1lfTiKez3k56Yz32CGRo7B0JBVTv3ar
	KoQqsF7rvIg==
X-Received: from dycc3.prod.google.com ([2002:a05:693c:60c3:b0:311:afe7:27])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c8:b0:37f:9ce1:cdb3
 with SMTP id 98e67ed59e1d1-3894279ba33mr9607592a91.33.1783651815158; Thu, 09
 Jul 2026 19:50:15 -0700 (PDT)
Date: Thu,  9 Jul 2026 19:49:51 -0700
In-Reply-To: <20260710024952.1668911-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709165220.1411149-1-irogers@google.com> <20260710024952.1668911-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710024952.1668911-8-irogers@google.com>
Subject: [PATCH v4 8/9] perf ui hists: Remove duplicated thread in popup_action
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, jistone@redhat.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

struct popup_action has a thread but this is duplicated in the
map_symbol. Remove the non-map_symbol version so that there's only ever
1 thread with a popup_action.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 28f1abdd87da..0005e454255d 100644
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
@@ -2734,8 +2733,8 @@ do_run_script(struct hist_browser *browser,
 	int n = 0;
 
 	len = 100;
-	if (act->thread)
-		len += strlen(thread__comm_str(act->thread));
+	if (act->ms.thread)
+		len += strlen(thread__comm_str(act->ms.thread));
 	else if (act->ms.sym)
 		len += strlen(act->ms.sym->name);
 	script_opt = malloc(len);
@@ -2743,9 +2742,9 @@ do_run_script(struct hist_browser *browser,
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
@@ -2800,7 +2799,7 @@ add_script_opt_2(struct popup_action *act, char **optstr,
 			return 0;
 	}
 
-	act->thread = thread;
+	act->ms.thread = thread;
 	act->ms.sym = sym;
 	act->fn = do_run_script;
 	return 1;
@@ -3211,7 +3210,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 					   verbose);
 			continue;
 		case 't':
-			actions->thread = thread;
+			actions->ms.thread = thread;
 			do_zoom_thread(browser, actions);
 			continue;
 		case 'S':
@@ -3231,7 +3230,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
 			continue;
 		case 'r':
 			if (is_report_browser(hbt)) {
-				actions->thread = NULL;
+				actions->ms.thread = NULL;
 				actions->ms.sym = NULL;
 				do_run_script(browser, actions);
 			}
@@ -3314,7 +3313,7 @@ static int evsel__hists_browse(struct evsel *evsel, int nr_events, const char *h
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

