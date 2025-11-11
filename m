Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719A26E6E5
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833869; cv=none; b=SahYD4KXHhnrSG7uLIDEzDd1LRX5+wcy80nQnduJ96mLadmC8Yi29JEg6qyVjk39eWPk5U/BTZy6iT7vhA5JMPLM4XC9gdbxbcn2T3GKgbnAKQcVjIzhxB7r4xqUxX7cUR+PXwqfoWnYKppNW++6avkGGJRDEfnNxdb8r88bgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833869; c=relaxed/simple;
	bh=5gugg7lkraj9TC0kZ6NwAUfMZ08oCZLBOSh79lmJK3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pU1WnA3olK6g+SLsl3bCp8AcfVwwoRVTrZH5qml44UfMwK6wN34p+RNZOZi5djywSuz4cMJvQEzeANkuQpfdzMm8vIpTpq86cMxDuJiA6wt3+T7QYD0h3QYXFmQ06b5Jy2UsuVSboLd7jygmXgiDbAV+PohXDg0hnhEhalumerg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1eaSCDK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1eaSCDK"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297dfae179bso81287855ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833868; x=1763438668; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/I124Vpc3AJUGEYy3T6Y6dhWjIbeIJN7sVjw18uSEg=;
        b=V1eaSCDKp3xcy4BzEuGZoR3xVw8A+oaf5KshSak1mED2lNgNQ4jOUe3gM5cQpkutCL
         NVYlQM+ILlf8Pa9I1FM88SdgUZ+cfnWC+YKy0sc07KaWjZM0Q6MhHuW6K6YkVP+XJDK5
         rCoXw/Oue/2bnfbBTrpzR35NUwjeJN4Ab06y65AnUL4MCwAZd79SReKP7DXkvBaz1ge4
         Tnji6QjQIdcUUm35zHXVVNFYYguYpjat4azJDu/NS8tF/mmqMyHvJargSqGdsgoSf+la
         bsaLRXJyyJD7HvYMUkPHaHvTLTZQ0fds+aNYhCHTUWzA+l7bqXfRateY82Gn+XwzSHBB
         48Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833868; x=1763438668;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/I124Vpc3AJUGEYy3T6Y6dhWjIbeIJN7sVjw18uSEg=;
        b=hfSK+huNEjm+4sXdLVeHFRxAVJ4p7zgscPTHwPAWIKZ1E3P7WXpNJDew61H09Y1ZOz
         p271Ik1ZqWzqqJHG4TPdwqcTj0428osEsYPbzCLL8EifRoFn906/Q160LiUzU7ZYEF2Z
         Zao3pqrStrJPBrA/6R2bJOxFDD4Kc+7B9th2dD09WBYXf5L+6wQjH0Aq9fxk7J4swPBc
         cL+o9bj59qGwFynfIV9wJwJxkMmorIoNMuVFD1ZxxxEj0c8cWsli0180sVg4pRzZvzpu
         5UBHIA33jjBuiiIrhYNFEogiENyr524EaNIEmOA4jICAlF42IhsRFCjsdW+1SQCJpQ5G
         S9DA==
X-Forwarded-Encrypted: i=1; AJvYcCXRY314i2dVD+wVZZLeSHbuHHdk4u2O+PfUfo0WVZkC7r/cBpnRKvRLYpw3cI0F0vWL0pgVzmnPTrCKIlm/P2X/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjxv+k89MWM/4takY2O1RejkMb6W2m2biQRdVIgNAdDil/GQN3
	se/M6Fl5QNnIfHX8ZXRX/h2wL4QLHD7M6m06WYOgS6r7NVHCsiruP6Lg4Yisd9fGX/NcTqK+lgK
	QtQOtoNbMSw==
X-Google-Smtp-Source: AGHT+IFomYyqh++zhNNCgyW6eUnQVtaZE4eDcAiCVDnxPld217gHT64tQpyx6OdmePxbHM9DBBM4TULNbDTI
X-Received: from dlnn4.prod.google.com ([2002:a05:7022:6184:b0:119:b185:ea76])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:b715:b0:295:8db9:305f
 with SMTP id d9443c01a7336-297e56be263mr100503715ad.34.1762833867710; Mon, 10
 Nov 2025 20:04:27 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:00 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-2-irogers@google.com>
Subject: [PATCH v3 01/18] perf metricgroup: Add care to picking the evsel for
 displaying a metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rather than using the first evsel in the matched events, try to find
the least shared non-tool evsel. The aim is to pick the first evsel
that typifies the metric within the list of metrics.

This addresses an issue where Default metric group metrics may lose
their counter value due to how the stat displaying hides counters for
default event/metric output.

For a metricgroup like TopdownL1 on an Intel Alderlake the change is,
before there are 4 events with metrics:
```
$ perf stat -M topdownL1 -a sleep 1

 Performance counter stats for 'system wide':

     7,782,334,296      cpu_core/TOPDOWN.SLOTS/          #     10.4 %  tma_bad_speculation
                                                  #     19.7 %  tma_frontend_bound
     2,668,927,977      cpu_core/topdown-retiring/       #     35.7 %  tma_backend_bound
                                                  #     34.1 %  tma_retiring
       803,623,987      cpu_core/topdown-bad-spec/
       167,514,386      cpu_core/topdown-heavy-ops/
     1,555,265,776      cpu_core/topdown-fe-bound/
     2,792,733,013      cpu_core/topdown-be-bound/
       279,769,310      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.2 %  tma_retiring
                                                  #     15.1 %  tma_bad_speculation
       457,917,232      cpu_atom/CPU_CLK_UNHALTED.CORE/  #     38.4 %  tma_backend_bound
                                                  #     34.2 %  tma_frontend_bound
       783,519,226      cpu_atom/TOPDOWN_FE_BOUND.ALL/
        10,790,192      cpu_core/INT_MISC.UOP_DROPPING/
       879,845,633      cpu_atom/TOPDOWN_BE_BOUND.ALL/
```

After there are 6 events with metrics:
```
$ perf stat -M topdownL1 -a sleep 1

 Performance counter stats for 'system wide':

     2,377,551,258      cpu_core/TOPDOWN.SLOTS/          #      7.9 %  tma_bad_speculation
                                                  #     36.4 %  tma_frontend_bound
       480,791,142      cpu_core/topdown-retiring/       #     35.5 %  tma_backend_bound
       186,323,991      cpu_core/topdown-bad-spec/
        65,070,590      cpu_core/topdown-heavy-ops/      #     20.1 %  tma_retiring
       871,733,444      cpu_core/topdown-fe-bound/
       848,286,598      cpu_core/topdown-be-bound/
       260,936,456      cpu_atom/TOPDOWN_RETIRING.ALL/   #     12.4 %  tma_retiring
                                                  #     17.6 %  tma_bad_speculation
       419,576,513      cpu_atom/CPU_CLK_UNHALTED.CORE/
       797,132,597      cpu_atom/TOPDOWN_FE_BOUND.ALL/   #     38.0 %  tma_frontend_bound
         3,055,447      cpu_core/INT_MISC.UOP_DROPPING/
       671,014,164      cpu_atom/TOPDOWN_BE_BOUND.ALL/   #     32.0 %  tma_backend_bound
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 48 ++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 48936e517803..76092ee26761 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
 	return ret;
 }
 
+/* How many times will a given evsel be used in a set of metrics? */
+static int count_uses(struct list_head *metric_list, struct evsel *evsel)
+{
+	const char *metric_id = evsel__metric_id(evsel);
+	struct metric *m;
+	int uses = 0;
+
+	list_for_each_entry(m, metric_list, nd) {
+		if (hashmap__find(m->pctx->ids, metric_id, NULL))
+			uses++;
+	}
+	return uses;
+}
+
+/*
+ * Select the evsel that stat-display will use to trigger shadow/metric
+ * printing. Pick the least shared non-tool evsel, encouraging metrics to be
+ * with a hardware counter that is specific to them.
+ */
+static struct evsel *pick_display_evsel(struct list_head *metric_list,
+					struct evsel **metric_events)
+{
+	struct evsel *selected = metric_events[0];
+	size_t selected_uses;
+	bool selected_is_tool;
+
+	if (!selected)
+		return NULL;
+
+	selected_uses = count_uses(metric_list, selected);
+	selected_is_tool = evsel__is_tool(selected);
+	for (int i = 1; metric_events[i]; i++) {
+		struct evsel *candidate = metric_events[i];
+		size_t candidate_uses = count_uses(metric_list, candidate);
+
+		if ((selected_is_tool && !evsel__is_tool(candidate)) ||
+		    (candidate_uses < selected_uses)) {
+			selected = candidate;
+			selected_uses = candidate_uses;
+			selected_is_tool = evsel__is_tool(selected);
+		}
+	}
+	return selected;
+}
+
 static int parse_groups(struct evlist *perf_evlist,
 			const char *pmu, const char *str,
 			bool metric_no_group,
@@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_evlist,
 			goto out;
 		}
 
-		me = metricgroup__lookup(&perf_evlist->metric_events, metric_events[0],
+		me = metricgroup__lookup(&perf_evlist->metric_events,
+					 pick_display_evsel(&metric_list, metric_events),
 					 /*create=*/true);
 
 		expr = malloc(sizeof(struct metric_expr));
-- 
2.51.2.1041.gc1ab5b90ca-goog

