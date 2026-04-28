Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAB3D4134
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360775; cv=none; b=dxtCdxdQar0hxdBZAfd8TuzdiNl4D3zhHSfFmA6kMC+pJo1HqCCvtk8v0qcjWbZ0LIFcxePmMqrSINbinNdmB7HlhZ5VvOZtjkx6U2Vm7AYyDG8bKDuaYFuHTCiJnMbM7BbvvAWsRJ9YayDOLiv9H4WrxWyUOv92SvIQGONEYr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360775; c=relaxed/simple;
	bh=FP5o9n90ZT5agsSGJdl1masLAbe0pH/IJ+EbWllzEcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=la6B7vIltEMzaYth3wN/RAx0d5TwlMJpmd9ZyCFX9cJl2eum9ghxBHxvggQTz+BTot+BUFTUnVUp+vWBfQE3B9mP95wL3c0A6e2SYbKScJ3KmAjk4k3Yio1mERr/M88NxcGQVxA5cxkmuw74KDFQc044M7oYAI4dznsHRvs+ugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiVOse/o; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiVOse/o"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso3230128eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360774; x=1777965574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=QiVOse/oQstoLXsq30rtkbfTzvzEQabM5tRvhUg1kSVpo71h038unqDjWKMBBo/zYX
         qBQp9Ye1WhkIhiXDmLxuFJHCI0+sFr2B9A0TWua6iVDalbe4aCEYzBaqKhtYMTZAvqnI
         bb8KvUwOIuRAV71PaRc2VLxiQtFi2XwCOwHA2z+j3usp96oohFL+8SYpkBLDTn14KXaQ
         aRi1iXr0+uHaTsA0hcMd/MK87mB5andFiKOJaI739dnuw3/9/v7Ay0GmtcsStXzSk8g4
         iaC0f8W6CadqNl8rN/VK+AgVNsqlHAfYEEg7XO/6vL9fAxAtW1CuwLGDScyzRoaAc/Q0
         p0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360774; x=1777965574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=RFF+qrTTKHuFFvATA4cHXv6B6aVKeL5YYoCQ85TeJbWmzyj5O/1REnaa2Uy06JsMkk
         S3tCQmFsQYLeDLjqFPJHoCm6qdyUykTKZ3/UHIRq1hpkLoxIY60eDyH/i9mYf4MVnz36
         RpVUNG0SjIbtoYBfmyhbCrcEx5H9QMUz+WhKO7kmFiZGgnmAt3VfpIQuMLt5LW8pU27B
         huFJH9p5bPQvJMfM9kR5lmP2fRK4d/qBMYGA9QM0eBSdZOn8elVhlmGUHJjIXwhSxHPq
         SrA+ArJPiR9Si9Eg9lna9ERjAHZch0aHNlzOLi+RJlZ922xIdY4/se1gIL/S6nn1YTvf
         xtQw==
X-Forwarded-Encrypted: i=1; AFNElJ9yTHpcnJAJXW2aIsTTdzMudunu6Ajlz93Q0dYPemnljCKMVTFcnBD3qeAm0hId6VS3zMnJ6nZ6bUPc7gJcIiZl@vger.kernel.org
X-Gm-Message-State: AOJu0YxElqU3VaI87EUqUMW25IIong+oEjd843EMMRUUM4x1qqVkAHRR
	PYSG9qJxH161eQ7rlcE85DBAQufqwBCkIIBuPzJ4KSyTtPplcF04AKd13zwhEcWeUHbp0HAqTcC
	0lc1Wkew8uQ==
X-Received: from dlae27.prod.google.com ([2002:a05:701b:231b:b0:12d:b86f:f7a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:439d:b0:12b:ebc9:2464
 with SMTP id a92af1059eb24-12ddd98e9f7mr774500c88.22.1777360773119; Tue, 28
 Apr 2026 00:19:33 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:12 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-8-irogers@google.com>
Subject: [PATCH v8 07/58] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Use forward declarations and remove unnecessary #includes in
evsel.h. Sort the forward declarations in evsel.h and evlist.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.h | 15 +++++++++------
 tools/perf/util/evsel.h  | 20 +++++++++++---------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e507f5f20ef6..e54761c670b6 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -2,29 +2,32 @@
 #ifndef __PERF_EVLIST_H
 #define __PERF_EVLIST_H 1
 
+#include <signal.h>
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <linux/refcount.h>
 #include <linux/list.h>
+#include <linux/refcount.h>
+#include <pthread.h>
+#include <unistd.h>
+
 #include <api/fd/array.h>
 #include <internal/evlist.h>
 #include <internal/evsel.h>
 #include <perf/evlist.h>
+
 #include "affinity.h"
 #include "events_stats.h"
 #include "evsel.h"
 #include "rblist.h"
-#include <pthread.h>
-#include <signal.h>
-#include <unistd.h>
 
-struct pollfd;
-struct thread_map;
 struct perf_cpu_map;
 struct perf_stat_config;
+struct pollfd;
 struct record_opts;
 struct strbuf;
 struct target;
+struct thread_map;
 
 /*
  * State machine of bkw_mmap_state:
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 339b5c08a33d..b099c8e5dd86 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -2,28 +2,30 @@
 #ifndef __PERF_EVSEL_H
 #define __PERF_EVSEL_H 1
 
-#include <linux/list.h>
 #include <stdbool.h>
-#include <sys/types.h>
+
+#include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <sys/types.h>
+
 #include <internal/evsel.h>
 #include <perf/evsel.h>
+
 #include "symbol_conf.h"
-#include "pmus.h"
-#include "pmu.h"
 
+struct bperf_follower_bpf;
+struct bperf_leader_bpf;
+struct bpf_counter_ops;
 struct bpf_object;
 struct cgroup;
+struct hashmap;
 struct perf_counts;
+struct perf_pmu;
 struct perf_stat_config;
 struct perf_stat_evsel;
-union perf_event;
-struct bpf_counter_ops;
 struct target;
-struct hashmap;
-struct bperf_leader_bpf;
-struct bperf_follower_bpf;
+union perf_event;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
-- 
2.54.0.545.g6539524ca2-goog

