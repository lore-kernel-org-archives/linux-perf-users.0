Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5E222563
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002077; cv=none; b=iVRT6Ouq2d+x6SXtHr9M6P8v6oHBNQwR0cE4OqZ4OQ+I7nwoOM7eZtOSbxhHvdO7QCBvjGOZcD8fuRrqVXAO7/NN1yxstzBX2qjEW5yVcOL4QbrBBfuH54HURiQC9+gTCvB4WYLNnxSL8w1vy7SsFu1z1zFYHzlJEhr/kMnEosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002077; c=relaxed/simple;
	bh=2l/1oKHeKrpT+PnW/axoFCb0/bWcsP4vJAsPyglQu90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gZUoehfz88bhfOiK0XLBGgUFDB6yakEgg4qCiKQ4n9VRYt+bWSYpYEdwEphFuq3GcT6hL2myVIHr0aqMc01j+4Y7C5LSXSEiQ7uET9I2AQr4oiZvRXrDUtp6pAJwwcfFk7GbaQAyqCP3ruQzVTdzEToNToMD0/JT9FnJkGg83aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDQEbHHj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDQEbHHj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so3641003a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002074; x=1744606874; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=nDQEbHHjeYO8eNhBLLmjWQXpwkX7vb1QMh0E4lBSoJY8gc8X8VaScI8EnoYmQ8mMts
         yxgGXCm+PJzCPkxSYZEmu1uVADJHbb3DeccdY0QWQOd28xzTVKgLkiR6wruIQwubO+oP
         sNwJS3d/Ugs5Z+6PCSE4IUIiiY+iMGGzFQ6zkzwuH40xvMKLaPWlPrzZpBU298hfy3y6
         PFdN//8GWs0I/T3fs5wQFiB6TYqhafBer6IFjsklC1FO/IaEAJgTMxrlGEnW/FVYoy3y
         isY296/VG2Ke5C9Q0FVJPQ7+AnNplgyovrqBDWhalhoGBZQkHdKgpGhaFDNbVvFLVmwy
         rb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002074; x=1744606874;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=I3rHcxotyPzE/A52fDzUL/PTg2vrRhHUfOpZ+FRskw7HRPxcMSk3Fv8GCaACvvD1OZ
         xR2ILkEThTKQbqFyKiKeMpMMt2uixlk6b2krng/XBdAz+UQCdNmHgxTWvb2OQsBiDvqr
         ju0XmW0xy3ahAPi16WhCqXz14ZVggRQ8VBHXacB6dUNKcjHE9IYmGc1PVyqMHazarJR/
         2JqbiUnDUxV+WumyrRXv44/E6zYTz0Yiy4CDDG3SlZaf35Q4wJdtstq/qNQO2Cz06aE3
         H/BW4kprvJdr6xInNz8HFfKv36vwWCLwSJ+qI9NmvFRnlpxhWVIGPN7Wlw60QWdJ1ECv
         QJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFnSYlYcwc18LVZp7AszmW/k+Bvam4TWbWF01197hhevKJGt5G8kuCqF5PJjLrQxXThNAQnbn6Gd9SeJB13rMh@vger.kernel.org
X-Gm-Message-State: AOJu0YxExoY6ECItlsgGMtOvSG1mHLkPy9a6matd17DW+jkSzUN2UN65
	tn2ROB4g27w6bGsQ5A+JeWbGASUSZ8nUtS/W9mhxVMbm+jm3qtsZDqb6YstykAq2G/IDVU2Ilg8
	68wxZDQ==
X-Google-Smtp-Source: AGHT+IG8N3mPKXVD522zb67He0muPojk2SfhipQ3PxfaRroQ1AwtdR8vbE1Fb2RtpQ4hzJgmoSEnQC3M0COC
X-Received: from pjbsz6.prod.google.com ([2002:a17:90b:2d46:b0:2fe:800f:23a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2709:b0:2f9:c139:b61f
 with SMTP id 98e67ed59e1d1-306a48650dfmr18771002a91.14.1744002074573; Sun, 06
 Apr 2025 22:01:14 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:00:48 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-4-irogers@google.com>
Subject: [PATCH v2 03/16] perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Try to add more consistency to evsel by having tpebs_start renamed to
evsel__tpebs_open, passing the evsel that is being opened. The unusual
behavior of evsel__tpebs_open opening all events on the evlist is kept
and will be cleaned up further in later patches. The comments are
cleaned up as tpebs_start isn't called from evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c       |  2 +-
 tools/perf/util/intel-tpebs.c | 33 ++++++++++++++++-----------------
 tools/perf/util/intel-tpebs.h |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7..121283f2f382 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2595,7 +2595,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	struct perf_cpu cpu;
 
 	if (evsel__is_retire_lat(evsel))
-		return tpebs_start(evsel->evlist);
+		return evsel__tpebs_open(evsel);
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 74b43faab986..566e0ddcad88 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 #include <linux/err.h>
 #include "sample.h"
+#include "counts.h"
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -189,18 +190,16 @@ static int tpebs_stop(void)
 	return ret;
 }
 
-/*
- * tpebs_start - start tpebs execution.
- * @evsel_list: retire_latency evsels in this list will be selected and sampled
- * to get the average retire_latency value.
- *
- * This function will be called from evlist level later when evlist__open() is
- * called consistently.
+/**
+ * evsel__tpebs_open - starts tpebs execution.
+ * @evsel: retire_latency evsel, all evsels on its list will be selected. Each
+ *         evsel is sampled to get the average retire_latency value.
  */
-int tpebs_start(struct evlist *evsel_list)
+int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret = 0;
-	struct evsel *evsel;
+	struct evsel *pos;
+	struct evlist *evsel_list = evsel->evlist;
 	char cpumap_buf[50];
 
 	/*
@@ -215,25 +214,25 @@ int tpebs_start(struct evlist *evsel_list)
 	 * Prepare perf record for sampling event retire_latency before fork and
 	 * prepare workload
 	 */
-	evlist__for_each_entry(evsel_list, evsel) {
+	evlist__for_each_entry(evsel_list, pos) {
 		int i;
 		char *name;
 		struct tpebs_retire_lat *new;
 
-		if (!evsel->retire_lat)
+		if (!pos->retire_lat)
 			continue;
 
-		pr_debug("tpebs: Retire_latency of event %s is required\n", evsel->name);
-		for (i = strlen(evsel->name) - 1; i > 0; i--) {
-			if (evsel->name[i] == 'R')
+		pr_debug("tpebs: Retire_latency of event %s is required\n", pos->name);
+		for (i = strlen(pos->name) - 1; i > 0; i--) {
+			if (pos->name[i] == 'R')
 				break;
 		}
-		if (i <= 0 || evsel->name[i] != 'R') {
+		if (i <= 0 || pos->name[i] != 'R') {
 			ret = -1;
 			goto err;
 		}
 
-		name = strdup(evsel->name);
+		name = strdup(pos->name);
 		if (!name) {
 			ret = -ENOMEM;
 			goto err;
@@ -247,7 +246,7 @@ int tpebs_start(struct evlist *evsel_list)
 			goto err;
 		}
 		new->name = name;
-		new->tpebs_name = evsel->name;
+		new->tpebs_name = pos->name;
 		list_add_tail(&new->nd, &tpebs_results);
 		tpebs_event_size += 1;
 	}
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 63c16e759a71..cc98203719c8 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -10,7 +10,7 @@ struct evsel;
 
 extern bool tpebs_recording;
 
-int tpebs_start(struct evlist *evsel_list);
+int evsel__tpebs_open(struct evsel *evsel);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-- 
2.49.0.504.g3bcea36a83-goog

