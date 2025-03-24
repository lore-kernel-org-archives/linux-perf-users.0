Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E11F03E6
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855703; cv=none; b=DLwZ2ZCuHpaNYx2UIB2FtFzBuYEIvml/YpEQzdCb/H+emUynvZJuQ1WrGJMnaZUvhbiwmjdfs9BYKPXfE0/UiTnbbXrrv1I7j212hVC5hIEM8KzlbVgF/DFVeXARx7H3X4ZOEfrf/VFpW0kjolsoDyKMtBNdyFjT9xTnypki/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855703; c=relaxed/simple;
	bh=aQ94fNPaOZE6PYvgPCW5WSHPBQdQVUZq24pj9KnKwC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NbsruffHyVaKrS7clicYvtfzDRy7GCPtASYe73bGOK7MXb7dmGVGWrroJLwJg2wW6bvNB6iKeuibtHdFXTW4wOQ7g/dSD0WEVVAJTDGMZewqfTDdyDVH8ureYQiHF7dNEdjDI8zGIOmfYrM0YhXw0iZfDjepYKRcSRk9ERhvfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHZFEA8M; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHZFEA8M"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c2b6cc2f94so3351088fac.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855700; x=1743460500; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZY9q8axMcgGZoMAQk8YvUirygGOk3Mm/VWg06jUJcG8=;
        b=GHZFEA8Ms5T3EVR0FcQwF6kROMSe9sqqIf7GR3C3RRPB8GXKjR8JR0l7mVViy8pe02
         mp9xv5Crfk0NDuqd3hWp6aOSfgWetZHsE1L0YvlRAxTvpdoNWRJseAU4UI0QBJUa7d5s
         tuC3uApcWahGAwhKCGkpraPLLXxHY6Yz3kB8EJJ4vmhBAv+btlpebD5GDhN5JwJTthZk
         arx7TBSXEESe6zMHqim8WRNrDriq1J9GhsUVL71OjLIPiTRTAxqry/PhbfzAUF8MiUjO
         BlBQ0j1af47l7d4OFw/oHMmlOzWSm7YeI7u+9SQmU2TheT/MZI/KeEb4Kh9RqQMd3sQJ
         hMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855700; x=1743460500;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY9q8axMcgGZoMAQk8YvUirygGOk3Mm/VWg06jUJcG8=;
        b=BaFIuZ9Fj5kqiJIaImlbCMi1f8mbTbpd3Gw8aLg+jAXGVYpLrzEUR9Pk9EZjpMotu4
         /2UVZDbGv7XEvintL3JWeHEfabEw4YU21nOAkCVCSX6YIjI33tUsxAHcQdJKU+j9d01x
         7B5N5HHQaCdITueU/SInEPzKFD+sIQc10a2LKi+VGSxYNZ7Yp+LzQRMYB9CAyHtp79bd
         eqQIgF3xADu6r4Re7Omk8qQ1Eckdx/AbcaeKiiB0bLomn6bpyfupybqX+p0sYBX6a2go
         9NrcOnMtw4Y1hNpqImbakAfSfVxSzCOt00DoUA51D+6EtxNvzFgr2FDlFaWbAW91LEGM
         RQLg==
X-Forwarded-Encrypted: i=1; AJvYcCWERs4926qBJntOnmN7RbnNuqMMogrP90XgVWKeQTrOCkDdlKAbOX2biBb0q8OWpLm1w/sPq1SsBvJ3h2wG5R42@vger.kernel.org
X-Gm-Message-State: AOJu0Yx473kbCL42UiitCA5jGswcKwmmg7J4HTKdzBEr/4nImHeWrug/
	rnqXZd95Jis7V7PGuVc1KToOaXLEf/Tb0ijc8kBbTwZ55bPz5KUhI/SNlTVUJsD3XEaF3f+8jSG
	nQhzJ9g==
X-Google-Smtp-Source: AGHT+IHQY8KHThvchOZrihJb0/lyvXHFRemQHry7URlGvL+rdisr9TeUoaJpCLuUYjxiuiQ10J6XLEvR/aJh
X-Received: from oacqc9.prod.google.com ([2002:a05:6871:e7c9:b0:2b8:4497:1ce5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:1c2:b0:29d:c832:7ef6
 with SMTP id 586e51a60fabf-2c78051a29bmr8800315fac.39.1742855700650; Mon, 24
 Mar 2025 15:35:00 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:40 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-3-irogers@google.com>
Subject: [PATCH v1 02/14] perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
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
 tools/perf/util/intel-tpebs.h |  7 +++----
 3 files changed, 20 insertions(+), 22 deletions(-)

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
index fb28aa211a63..2b2f4b28e8ef 100644
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
@@ -188,18 +189,16 @@ static int tpebs_stop(void)
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
@@ -214,25 +213,25 @@ int tpebs_start(struct evlist *evsel_list)
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
@@ -246,7 +245,7 @@ int tpebs_start(struct evlist *evsel_list)
 			goto err;
 		}
 		new->name = name;
-		new->tpebs_name = evsel->name;
+		new->tpebs_name = pos->name;
 		list_add_tail(&new->nd, &tpebs_results);
 		tpebs_event_size += 1;
 	}
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 766b3fbd79f1..88d70bb37971 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -5,19 +5,18 @@
 #ifndef INCLUDE__PERF_INTEL_TPEBS_H__
 #define INCLUDE__PERF_INTEL_TPEBS_H__
 
-#include "stat.h"
-#include "evsel.h"
+struct evsel;
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 
 extern bool tpebs_recording;
-int tpebs_start(struct evlist *evsel_list);
+int evsel__tpebs_open(struct evsel *evsel);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
 #else
 
-static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
+static inline int evsel__tpebs_open(struct evsel *evsel __maybe_unused)
 {
 	return 0;
 }
-- 
2.49.0.395.g12beb8f557-goog

