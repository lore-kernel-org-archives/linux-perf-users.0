Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258D1DDC04
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178882; cv=none; b=Rf53ZKxcBSl5j9E2v1p6b53y3ceiHsYMUIpX2gfDatFXrYWLYUkpVAhm+l7E7gCLQSoodl60/ZADSSZcTYYLa3EccU0G50XZmWCyeQ9zqP1HvfIiNx10syR++33GmdmuxSS4jJFwzVka5sMtl2Zm1CYrOWiRjsgpKlnBpXfIwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178882; c=relaxed/simple;
	bh=2l/1oKHeKrpT+PnW/axoFCb0/bWcsP4vJAsPyglQu90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Qef7pauEptKxDNOQJUc3nNT6t0sgc8XTqU/H+wcEFLXhsl0o/QOKPGTYKnplQzPJlO8qxGYi4lsDpMu1zX5D5kHZCJPV2A6zfHrX97eZgzjmChj7+e/sywCkDExW2uRDWr5o8/vTZJm29CVcJZWwFygbF9wiX8Tiw6/1z6yp37s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGp45GC6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGp45GC6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225107fbdc7so54453165ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Apr 2025 23:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744178880; x=1744783680; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=BGp45GC6BeESsFl5CMlnRJgCJGq6VT6XAHjK8VLAWD2G31Cuhv/J3ML/PTATOzuxoz
         Ld4F05HPpqcWtSttwZ2cHgJSmgCSgEiw6JnuQiuYq7ELSB9cLGk4cke/MydtqOnwNIrP
         7Bxb/Z7aYiexJ/CTg4owqSALEzbzYGxWqrZY3Yz0CGqmf24oDAD/EbnK2JnMo01QP6Fo
         PMb3gR55kJV1fPHNZh6z8cFvcnk5Mzeqeo41CBTGZ2gJm0HEQMhtR6Cq4MXFxL8YRcVv
         RjB+gvRNGifhTG6frt7BVAozPmNaqD0LfLwpKOyjp6FJjHxw6W2Ht5EHR8NCM3yHaQpd
         7eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744178880; x=1744783680;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0w8p9z7uIDU2rw9JTfItdCw1PZrvXFzExYD6rhP3a4=;
        b=HUXbK6IS5HLXthCtg8elJpXl5wFbcJHkYwVeXdbwE05eHzm5y2KqgA7WBG5AoFvldB
         yn5zyNZrnU8+5xrYIZ27xVu4cAE4t3ylt+Bv++yHubFF6jIRflz0HxM+spCuox897Yo8
         PmVUryRyAdGmfJygEWpkrO0ShZ/kdl4k7RMgERmlw9V317M9bJelf7JJ/GI098WtR3BU
         GiTSt2QWj7Zk3zmab78rtTGogM27293ABKs3d44fWZdCuPw4jfZLfx0MwwgYJuNHWF/W
         jmrws5Oyv1RoFIyHF/5Fh+RTq43+IBGX4LRhN7gFSR+QkOB/nRczx8g0ozchIlFgkgkU
         RRmw==
X-Forwarded-Encrypted: i=1; AJvYcCWjcArNIlAgbACsZ8IQZvI6nK2lrDfOgRJVlCRq/eeU28+19zXis9OIFcAjH95hxeFEGPQl/s3Chvxvhg9nUtlC@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/bqXqI7LS51N9ZSfs6cb6+QiixSe8rAO/gv4c/yUH5B8YvYQ
	Qn0XhcL/R8hDDUnQoD3j8EB9z2nr23l1q6WNzZylhJC2GJG1U75WQKyjYQ53AkVehvC3PDwgfCU
	l6LrwDg==
X-Google-Smtp-Source: AGHT+IEISs/jGi3uQMkCb7uLQngJy69VVzlIcXAAbuRcrGJqCzgfLRivtI4sce3nnsF5LGzTYEix0F77S62z
X-Received: from pjbqn15.prod.google.com ([2002:a17:90b:3d4f:b0:2fa:b84:b308])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cc:b0:220:e338:8d2
 with SMTP id d9443c01a7336-22ac29a9ea5mr21805015ad.21.1744178879653; Tue, 08
 Apr 2025 23:07:59 -0700 (PDT)
Date: Tue,  8 Apr 2025 23:07:30 -0700
In-Reply-To: <20250409060744.698511-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250409060744.698511-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250409060744.698511-4-irogers@google.com>
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

