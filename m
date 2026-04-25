Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B853359A66
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139359; cv=none; b=EvUq+D5Ob5ivJgQrkimB3mbjZJbAX9cwcI4NAuOBQlZ6PPF0Rq5cNMEDe7a19lPuBmGQTnzNRcATsWk0R+RXXtTttuAdPA6mNzNEyBw5yUdxpaMNOTk7QlQ4XRGedD3Fon/co9f1ZvbP4iMtj5My1LXTIGBIP3ECPVCMchMs+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139359; c=relaxed/simple;
	bh=FP5o9n90ZT5agsSGJdl1masLAbe0pH/IJ+EbWllzEcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MzJIAj9J16xxYIOpK0AfNcd0awJ0pxidaOcqvMGi8Si9nrkCLwbPIbtk+95EHmK87QPzG5a4wmKXS36cQ2rPpZReiP/OQwN4FiPNsHhNYUPEBLLti8zBfYnPydnPu+u0wfwLJLQRIVHgNiSWhRUIj2+4VrnWlfVPQDRWNFfDcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aAEzrhtc; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aAEzrhtc"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso605072eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139357; x=1777744157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=aAEzrhtcZBo1koLxeErFUsDntr+oZgXc/YZ0RYsVsZFJeFbnxm+Q5TDJdGG2howwBV
         KsscQwnAOoBy0/DA3ZU6qZxr834wAqq4Bt2+Iniuwd/17G0DwHlg8+znm7+PCNNqEerB
         8NBgQ7jJ6NwUDnJjg6HBe1wJvzUxVVQQo4sOavMIa22zexoSg0zk4MVnB8eaYnF0XtIB
         7VqDDbowK6HjyTf5xm8X1Cgws48s5JR5BQt5oE3U/exUlivEd51HEjsd9zTOqYwWrxp9
         FB0zl1Wf6jtxDhb48Y3K8NQgZ44afMGsuscXH6Legh04FU8QpjugU8KFu7sQ0kKurFh+
         iE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139357; x=1777744157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=SAHH0cgnKNdUNWYjpp/XTe4u8NK5gPyeFXXQYICEcb/wbXfJccIugxgFDXx9T6wppf
         qdQ/IQg7cPFjGQl6hruzoO3SyAXsOvPbv320RuXq+lZ640mfGj78xIEuT63WbHxDFmmb
         jtSTTP7ZrB4GQHKjugIQLucpZpsYPhsjDS+0kAtgxD9nTkkFJ7c2JjaIBTlUoLSzccgG
         g9LKKHUTfGkcRFerhajgiCfCGuDPt78adZ83MTsw98J9aXGsYbioVfIaPzBBdhjxfoMC
         pMp/v6+b1e7AYSvY8UuOXcZ1onlr9+YoXfM9N3p8pCD1yDcMmZ16NKAocABI3XryN1hX
         yG7w==
X-Forwarded-Encrypted: i=1; AFNElJ/JO9x2e9RqJjN8N4NGzIPiHc3YOKeGZHsxMCxp8WpkgtOkh0fxArEv4WRRA3LRIX1dqkfVYTAire8hxHjiLMdg@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvXX5AFbXkR0BEUellKVuPiBUFG152rF4kxAFsYPf6wybGIum
	Jd4DrJsaow6JDOZ/K6UgwDdXjKIbtBjtOVewAcXxvjHeduRKT+Rt3dQgpQ5hiwvldI2gtQBpyN4
	3EU/izFo3Fg==
X-Received: from dlbur7-n1.prod.google.com ([2002:a05:7022:ea47:10b0:12c:4a54:8b0d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1282:b0:127:3b1e:7e0e
 with SMTP id a92af1059eb24-12c73f9951amr17112131c88.20.1777139357205; Sat, 25
 Apr 2026 10:49:17 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:06 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-9-irogers@google.com>
Subject: [PATCH v6 08/59] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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

