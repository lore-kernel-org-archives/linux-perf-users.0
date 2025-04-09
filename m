Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B3F1DF244
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179061; cv=none; b=BNGVDceqS7tTeEGNy0lIYWtp1GIgDwuO8ttUCmeFor5m/ehhEDpxqVzfa9w93c+8FwnA9l+oYI+IOpC/lm4hCWkVyslFDAIFejIBhRtGdELVFNgvHFubh3pRrcDbs5oEfYB0ILaIZsyiUJpcdOYkskluupnFwZPe2WXOh/VSJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179061; c=relaxed/simple;
	bh=2l/1oKHeKrpT+PnW/axoFCb0/bWcsP4vJAsPyglQu90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gQXcYbBatnmoU6YT+Zf7JESZ+KdtWc24oANMQfHracURP+WQqkryj7KFlYlRO0jRk/9lgn/So6bz3NbDT6XHnG/GtaGNNZcvezthSANvLh5IPuYIy7KJ/kynx4Jf1eMtzeUgUqmlVhjNsSIuRdumHie+CKiB1g9jqLcsX5K9Zqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4efb/rU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4efb/rU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240c997059so79706765ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744179058; x=1744783858; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=u4efb/rUv7bxkQ8Xbdbjdia3aiCSfzVfB2CPXmeZlk7NDz5iVSKXFhndvhKtGY1Qrd
         w42YY5fduSxqlkUdQ5lbo1SZnC/xOIyuwRQZJVz+q+1Fehqi5pM3iqNHEY1ahupbNOAy
         ZrxlhmAfczPm9tK0Frn//BnxDuMCIqkfIGIz4eM2M+2e+AHDPiq27HsAccWcUNVMJm3z
         lV+KRjiYfVxFV54JWq2saXRUy4v7TQz8WcO8t45VNONQnNs0JrJMOCbunvArP/cei6aP
         fg/OYmCweasFjuKyOQdAUi2Hia8mCUr/2k9CzmUzThKTpo6VX13hinep02JNE3ubc7hb
         AnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744179058; x=1744783858;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=SVLkU2OpKD8Y97FgfadAevsKvO/QkqJyVX90Ntq22Ry8S/PengDVJt8WvYaPKEGLsv
         i8ScI+kwSvO1aI4sA5TDzYa7dMcgIJkleF32woUnTtvlIJf0Nw0ijDIf1sMb2apd7AFD
         TqjwghEaoXoKg3Ujcgx5Mjf5LpICJWr+ftQm4refdL1+MQ2/SxiNo4DRoUc5aUbAwbPg
         bEIMd+8ia+/FOzFfI6pCHnMqwu1TcjUtkQShri3tJKqd38HeT0DoW229VhXLYeASzNCR
         b7gow4FcMEq47FYp9Tww40Sgm7RbUvf/HkVMiJqE4gWMDVwLqIIbn3aKwQ9/y27qGP4k
         o9yA==
X-Forwarded-Encrypted: i=1; AJvYcCXoEUDEu4gc3fRFmGL6Ztxa1/GrlQBKtqVNV9KHSNFCcE5WaFVJQ2QVD46xryhoy1MshndAfs/A7B2fLNEY/qML@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kqvsgGCwUTmT9cyKKPtaeMERZfVsX2I0qODwbMNf+9Fxi9Ru
	swXv2FmEhvNN0KTXfgX7svCImM6RZuMELpJxCJjpYhVd+3KXK0ja0gEy6fK4MOpF45i5st7xrW9
	GEbN1QQ==
X-Google-Smtp-Source: AGHT+IGc+7BVyntdU4p0HeIsWvtKzQBSgCNB0GNk0awJtPTye95FSjH/7LTIWpEujW8ers20zhFBSaddcB1O
X-Received: from plth11.prod.google.com ([2002:a17:902:704b:b0:220:e84e:350c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2444:b0:224:1609:a747
 with SMTP id d9443c01a7336-22ac29be769mr31883425ad.31.1744179057966; Tue, 08
 Apr 2025 23:10:57 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:10:30 -0700
In-Reply-To: <20250409061043.700792-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409061043.700792-4-irogers@google.com>
Subject: [PATCH v4 03/16] perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
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

