Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEC223711
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060223; cv=none; b=dY70DAcYRm9W9r6ULqCM4IkwMOeSW/zTkuetBrGTnFftEaV2NdRVNJbv/KmHOB/CnI2XcRXisNiUUyhJQAGo8zVYX6uar4BegFlJpiJsJIf/VWsoko04HarkKKWO6ckpmnLNTt4DRTkrjSxH0LFjnDA+kZz0gkb1X70gFgqwzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060223; c=relaxed/simple;
	bh=oTGRBpcL/2sIHNUD+/BM6BV/LmnMI5XK3yo3xDS6KyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b4GfRJLW6BWPGYWpN8doBP49h0MeGTBZhPBieg/SMq1MKQaGm6pQr98HcpsK7ahiVQL2yHz4DBQQX8bVkXDcFnsxouQcd+rU6ti3AKSVAxQj6oASCH+6kGVrWoGKBPaF2PRWyJVDt3eSTVNtDGTmm17SKOYEeHYPqKxFZdxHp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jy9Tkv+G; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jy9Tkv+G"
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-72bc266dc24so5422790a34.2
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744060221; x=1744665021; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pClnDyLnT+OkOC5ziZK4pcS5wTXzmuK+3iocOmka5vs=;
        b=jy9Tkv+GCBUtPbS3Iv3v7fn1J9jWreDgLWYOg6fhXaJDWs7BpIF8+1LxxN3eGweLDZ
         Yy7xc9KdGCMaeuZkSJLT3wuQkpsY1kUSAF6UO76aNiYgWHuPr9d1Asx1r2858nqsW8VF
         H+EqcPI4v3lz2CRv1VFMRX9NV3cIgTRq+/o6DQyKwoTXpQGe2s+GfnyINyBDPmFQbIK/
         TPGPIe/WyCqPeIqXFp44NjWqvEBbiGK66TWltI4sKm+rqg9me0VY1bJRgTGYswuzvpgU
         kgbOG5ldULQwUodbiqIWCBfpDmE1YXNQPrQPfkhRhyKNSh8wCoXALhlWiIv+PdHNdZMr
         lhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744060221; x=1744665021;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pClnDyLnT+OkOC5ziZK4pcS5wTXzmuK+3iocOmka5vs=;
        b=ZyklYfcaDnP7obDDFTWOf7Jh+FWC5k1xXtaqGHePyK1l+2oS0yz6HUuKmClrxQKhOT
         r3mC/uPaQ+KThfADCZxEFgRG6kkLDZWC7N1MCWBL0tCrItA3RTi4npPmAv0/gial71XB
         D1VP8KUYiaFaayHU14ZFGFFJ/FK8hc7OUJV1oy7oX06qdNDKsRKDoCv2EEz+BiuJQYi2
         QrjIjjaRk9IdGvHwC1XE0Vu5WkTxjcjDwHk8qjOVEU9KQzTmTAaTNK5Z2hV7MOJ07vpt
         GcdHq8HB7A21HYWE82ItNw1u7OM5YxydszVJtoaYBmEV/TaTNkmtYDWnlhEFopTfUM9x
         PkBw==
X-Forwarded-Encrypted: i=1; AJvYcCVu55eyzjqYcY4cgQzideaGHizGSfS+qPJfR3VUdZRV9qI1Kh8CGRJuoLSZCMxjcnw2Ufro/IXpAZFm1njHco0z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7NSo44nCdCJ11Ud/Bn8YKQjv4qWniideEAtKG3ZAG/5kAJdgt
	0Q/FPLjSdVb3q+LsJZD4O9/yrpm1BkQUwY/4tqiJUN9JrxOCuZ+z2cJKeDUeDCfCm7aM/6MsXeK
	/2jTUwQ==
X-Google-Smtp-Source: AGHT+IH86lGfxCgWinbFenzzBxH0UG6egEG9qpsbS3h/oG/yaY/g6stYBTEZyLftj9OgRe77MLupZYD2cLwl
X-Received: from oacnq19.prod.google.com ([2002:a05:6871:3793:b0:2b8:ed65:d4c7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:3704:b0:72b:96cc:f994
 with SMTP id 46e09a7af769-72e37f2b89amr8850830a34.5.1744060220966; Mon, 07
 Apr 2025 14:10:20 -0700 (PDT)
Date: Mon,  7 Apr 2025 14:09:22 -0700
In-Reply-To: <20250407210937.131681-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407210937.131681-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407210937.131681-2-irogers@google.com>
Subject: [PATCH v3 01/16] perf intel-tpebs: Cleanup header
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

Remove arch conditional compilation. Arch conditional compilation
belongs in the arch/ directory.

Tidy header guards to match other files. Remove unneeded includes and
switch to forward declarations when necesary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build         |  2 +-
 tools/perf/util/intel-tpebs.c |  1 +
 tools/perf/util/intel-tpebs.h | 30 ++++++------------------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 946bce6628f3..815274b199fd 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -161,7 +161,7 @@ perf-util-y += clockid.o
 perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
-perf-util-$(CONFIG_X86_64) += intel-tpebs.o
+perf-util-y += intel-tpebs.o
 
 perf-util-$(CONFIG_LIBBPF) += bpf_map.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 2c421b475b3b..3503da28a12f 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -19,6 +19,7 @@
 #include "tool.h"
 #include "cpumap.h"
 #include "metricgroup.h"
+#include "stat.h"
 #include <sys/stat.h>
 #include <sys/file.h>
 #include <poll.h>
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 766b3fbd79f1..63c16e759a71 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -2,34 +2,16 @@
 /*
  * intel_tpebs.h: Intel TEPBS support
  */
-#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
-#define INCLUDE__PERF_INTEL_TPEBS_H__
+#ifndef __INTEL_TPEBS_H
+#define __INTEL_TPEBS_H
 
-#include "stat.h"
-#include "evsel.h"
-
-#ifdef HAVE_ARCH_X86_64_SUPPORT
+struct evlist;
+struct evsel;
 
 extern bool tpebs_recording;
+
 int tpebs_start(struct evlist *evsel_list);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
-#else
-
-static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
-{
-	return 0;
-}
-
-static inline void tpebs_delete(void) {};
-
-static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
-				int cpu_map_idx  __maybe_unused,
-				int thread  __maybe_unused)
-{
-	return 0;
-}
-
-#endif
-#endif
+#endif /* __INTEL_TPEBS_H */
-- 
2.49.0.504.g3bcea36a83-goog

