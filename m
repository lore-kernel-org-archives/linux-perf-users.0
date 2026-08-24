Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C43E5A1F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553484; cv=none; b=foSKx5eY6PK7DRawpaDnFaW9fl3ywKPUKE3ph2+jxTRpLzT1ROW1LS6pKPTerfECCqE1+hLepD1vTm0xXYDZfJUJLoc4eXOqBvAybVGBHY8lmh3bT0yH6GhVvCn1Uh7wd+69uxF/98uPICquyzwLmEsVpOTYVCEKqzMtHpDz53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553484; c=relaxed/simple;
	bh=NmUqxPumcCU/Ku7XFBQ2CbB8PZz9hr8FapMXvTDw1vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEMK+GbNP3tUkCWI0Gfk8JKuGXF/YkdsrECkkPtulnCc2kRzRTn7sjMm1U9TI9GmlU4AzDMtrFJ1GKv7S2filPADKWrEP/lZXxNcU9roiQ/3io5G3tISKg7R6y4Usd95rNT+h4iJmGSTlBd6ajCu8pPrEXRRgmoMHXEmh9ZjX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FMPFemMs; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMPFemMs"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3950b1371a7so4768831a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787553481; x=1788158281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/MF9jC0mP/Qm5YIccy+Ss2T7drb/vabI/FTHPUV5+zk=;
        b=FMPFemMs+X1kkimmQ1DTHupL1N3lABJBlrGjyTR65G7W/uNijqrakvc9czmDtUZs8T
         Ax6etzwBBfrxUkwky6gnRijPK5/3AkmVZDaaxjpSAh3pd4x+oj0X1VFW4044Qw1y0TMk
         0G86dhaQHijGAtJ/jAYyPp6Wv6ef4JRQ2o7hC6sjzmEHoiQdBiOZMNWPEJdC7Kt17tfh
         MgdjsykXZUYxfzT14flGDT88Ri10J0hGkBsMpuLIrD0VM1Puj6AcZ20dbr8/gffb7YVf
         llVDRxlJUits94txx05Z+Vp6FkaR36TInzS2Rq/0FwwqHcXFx9IkpjuqkwSWIdhVAnlS
         Mdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787553481; x=1788158281;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MF9jC0mP/Qm5YIccy+Ss2T7drb/vabI/FTHPUV5+zk=;
        b=oPlqB3zQly8WTzrNGKmv9AruU81dS0iF84YUWV4WBumm5wnPyaXzXWTN81ruy3hNj7
         Y2mko8n4fUiuHC+OQWxeMwosBVtwYD3PB5GgPTgayhluZ70xuPEiwW7x7Rki4OqZYMm0
         i3B18TF6wk0y9bHT9Aay0Dd7fcqusdsww0WyuGZryGHeuG93B/5mbkbinQiMJjTnd7k+
         nxkj8WqQduZn1QlYTenggPbeG/x0rLmRJ+lnRr8UST10c3DFXjECnIpP5hXa+vhU3BqH
         h6RVTu0ubq1TgIva51FIv1TODf6pn/49LM7K7suiNLd8zYf/6hmMzb8Vs/DFQQBUS7lv
         6O6A==
X-Forwarded-Encrypted: i=1; AHgh+RpHill8YUkwZPsDrZP/RCPcrLDHFDper/dGZvsGpC7FMmBK6/BRrJzFmb5RzfVEL24JXg7YPqO+UXRedSM7LBTg@vger.kernel.org
X-Gm-Message-State: AFuF++loyGhENdJ48+TSFFgCqmyqNU2unHFmlJNFOIjOEqaSRpv+untu
	OQLW8HMb5eJdXSIDcTZ7awgTUvgy5FeqaBvF40f12LuRtmelxBTKES/GEiS1JkantbcK5n3F2X/
	zY5VqDQcJ9Q==
X-Received: from dlbou15.prod.google.com ([2002:a05:7022:110f:b0:13b:9778:570])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c90:b0:393:19a3:4f1
 with SMTP id 98e67ed59e1d1-395c351d788mr41956359a91.6.1787553481245; Sun, 23
 Aug 2026 23:38:01 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:37:40 -0700
In-Reply-To: <20260824063744.1533837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <20260824063744.1533837-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824063744.1533837-4-irogers@google.com>
Subject: [PATCH v1 3/7] perf ui browsers: Implement interactive 'M' keystroke
 to toggle hybrid event merging
From: Ian Rogers <irogers@google.com>
To: andi@firstfloor.org
Cc: acme@kernel.org, ak@kernel.org, ak@linux.intel.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Map the 'M' keystroke globally across the interface to toggle boolean state
dynamically rebuilding hybrid core groups independently.
This allows cleanly separating or aggregating hybrid core histograms.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/ui/browsers/hists.c | 48 +++++++++++++++++++++++++++++-----
 tools/perf/util/evsel.c        | 12 +++++++++
 tools/perf/util/evsel.h        |  2 ++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c15874a491b4..07cb06834d0f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2840,10 +2840,10 @@ add_script_opt(struct hist_browser *browser,
 			return n;
 		j = sprintf(tstr, " in ");
 		j += timestamp__scnprintf_usec(he->time, tstr + j,
-					       sizeof tstr - j);
+						   sizeof(tstr) - j);
 		j += sprintf(tstr + j, "-");
 		timestamp__scnprintf_usec(he->time + symbol_conf.time_quantum,
-				          tstr + j, sizeof tstr - j);
+					  tstr + j, sizeof(tstr) - j);
 		ret = add_script_opt_2(time_act, time_optstr, thread, sym, tstr);
 		if (ret > 0) {
 			time_act->time = he->time;
@@ -3580,8 +3580,11 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 	int delay_secs = hbt ? hbt->refresh : 0;
 	int key;
 
-	if (ui_browser__show(&menu->b, title,
-			     "ESC: exit, ENTER|->: Browse histograms") < 0)
+	const char *help_msg = evlist__can_merge_hybrid(evlist) ?
+			       "ESC: exit, ENTER|->: Browse histograms, M: Merge hybrid events" :
+			       "ESC: exit, ENTER|->: Browse histograms";
+
+	if (ui_browser__show(&menu->b, title, help_msg) < 0)
 		return -1;
 
 	while (1) {
@@ -3636,6 +3639,16 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 				goto out;
 			case K_ESC:
 			default:
+				if (key == 'M') {
+					if (evlist__can_merge_hybrid(evlist)) {
+						if (!symbol_conf.hybrid_merge)
+							evlist__merge_hybrid(evlist, true);
+						symbol_conf.hybrid_merge =
+							!symbol_conf.hybrid_merge;
+						ui_browser__hide(&menu->b);
+						return K_RELOAD;
+					}
+				}
 				continue;
 			}
 		case K_LEFT:
@@ -3649,6 +3662,15 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 		case CTRL('c'):
 			goto out;
 		default:
+			if (key == 'M') {
+				if (evlist__can_merge_hybrid(evlist)) {
+					if (!symbol_conf.hybrid_merge)
+						evlist__merge_hybrid(evlist, true);
+					symbol_conf.hybrid_merge = !symbol_conf.hybrid_merge;
+					ui_browser__hide(&menu->b);
+					return K_RELOAD;
+				}
+			}
 			ui_browser__warn_unhandled_hotkey(&menu->b, key, delay_secs, NULL);
 			continue;
 		}
@@ -3675,6 +3697,8 @@ static int __evlist__tui_browse_hists(struct evlist *evlist, int nr_entries, con
 				      bool warn_lost_event)
 {
 	struct evsel *pos;
+	int ret;
+
 	struct evsel_menu menu = {
 		.b = {
 			.entries    = &evlist__core(evlist)->entries,
@@ -3699,8 +3723,11 @@ static int __evlist__tui_browse_hists(struct evlist *evlist, int nr_entries, con
 			menu.b.width = line_len;
 	}
 
-	return perf_evsel_menu__run(&menu, nr_entries, help,
+	ret = perf_evsel_menu__run(&menu, nr_entries, help,
 				    hbt, warn_lost_event);
+
+
+	return ret;
 }
 
 static bool evlist__single_entry(struct evlist *evlist)
@@ -3720,10 +3747,14 @@ static bool evlist__single_entry(struct evlist *evlist)
 	return false;
 }
 
+
 int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
 			     float min_pcnt, struct perf_env *env, bool warn_lost_event)
 {
 	int nr_entries = evlist__nr_entries(evlist);
+	int ret;
+
+retry:
 
 	if (evlist__single_entry(evlist)) {
 single_entry: {
@@ -3747,8 +3778,13 @@ single_entry: {
 			goto single_entry;
 	}
 
-	return __evlist__tui_browse_hists(evlist, nr_entries, help, hbt, min_pcnt, env,
+	ret = __evlist__tui_browse_hists(evlist, nr_entries, help, hbt, min_pcnt, env,
 					  warn_lost_event);
+	if (ret == K_RELOAD) {
+		nr_entries = evlist__nr_entries(evlist);
+		goto retry;
+	}
+	return ret;
 }
 
 static int block_hists_browser__title(struct hist_browser *browser, char *bf,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3f56a0e6f9d6..a4760cfb7582 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -4758,3 +4758,15 @@ void evsel__warn_user_requested_cpus(struct evsel *evsel, struct perf_cpu_map *u
 	perf_cpu_map__put(intersect);
 	perf_cpu_map__put(online);
 }
+
+struct evsel *evsel__new_dummy(void)
+{
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_DUMMY,
+		.size	= sizeof(attr),
+		.freq = 0,
+		.sample_period = 1,
+	};
+	return evsel__new(&attr);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d9ecc6628217..6cf07120da9f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -15,6 +15,8 @@
 
 #include "symbol_conf.h"
 
+struct evsel *evsel__new_dummy(void);
+
 struct bperf_follower_bpf;
 struct bperf_leader_bpf;
 struct bpf_counter_ops;
-- 
2.55.0.766.g2966f0265a-goog

