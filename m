Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35E38D016
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156909; cv=none; b=dM3Iyly5JTd4TCox174bnOommWSOpccG01+E5Hc1k16bmfpmFGjKBbNeB1rjLXKOn2F/004VsU+/IPfIZwVjBI3BSAThrpJj/uLFsrjg1EWe1bz0vt0JCTXE0WgzB/ZJLb+Qw9o9a2fygU3LIDL1+21///rwBbNGAEdDSiA8KHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156909; c=relaxed/simple;
	bh=FP5o9n90ZT5agsSGJdl1masLAbe0pH/IJ+EbWllzEcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DsHihr+HMXPtv7jeRqcqkUEgyvHe6dP1J9k4ZJXTQbeZagIIw2SZzPCH4yV+0Ev81hDz+B6ReuZwRJJoYUf1TbKAKY+g7jbfR7pZnvK2eWYRs9dbme3XA7spa2Tui8spMrsM9GExsAHMJO0PXjxpUvyHqpClVtjJGf1ptYGWVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+k/NcRE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+k/NcRE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c20d5d7f4so43611381c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156907; x=1777761707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=M+k/NcREwpu5GJqi09eIw0YfDkQzaWSSuVYVBduoI3FhCRb70wATTGJ0SDfbM3c+PG
         vYkmjr0Xx3N6sEI5Zaawgp03IfdPwmMbojLgja02vmPpH9bQyKhHyCh7qpOu+DZiRyDT
         oW9NijAkuoNA4A2QwYROtNb+irQM978mSsa3liy7wwrnlOav7jSrUeX9Z2OwHqNjP2/Q
         q0ngJFfzxiSbdZZzHcHy6l5CDqom8JCTS+rJ1GHld2ANAa0cY1MYuu2zdP4b2GkkyyJY
         UnfUsnsiGuxVbDZbXN+7gOPGSccGHwFPlAVrMW970RPt+Np13JoO4wXBN7jJpDk2oQyK
         8p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156907; x=1777761707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=b2bFlVsIYTScwMcbOFomRMl+WOkyjzhcBLEaZZN4wlkeuZ09W31E9F7tYohnAOGQAG
         h+2CT8fWPgRVsfzTeyzOwNN29ir9Dy9CpB4W53B6S1/c5MjVAnNEjlkz1U8PwiQXnkX+
         wdouzjFqto+R1qGRr/kiCLs7c3l8i7nrQkgIS3AYnrz7xtjRk0tI+58yUJzYRnz2rUrb
         DNhIO17zApGgk5mbu62iLANHymt3h4a355s3AOHBdRPYbJyWm11yKAYHgXjYSLtOKNAU
         f1cZgkHsXKNsOyafyvPE0E6c7yaFq5ATfIAHyOIynHpQci94K0va6qgARx7AhQfZcMEF
         eWbQ==
X-Forwarded-Encrypted: i=1; AFNElJ89eEREVsoS58Zf6uc2Y3n80rLCh5zXZwUWMNwX+Xlb6W5paIqV89TXgdKyVySaTz2IFtswLW55QpTpIKraSIQX@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPuRWYzRYymlIefHaS/wJ1Fr8575ad74SnwLb+hKTwqaOSLJ6
	CGPVbb1OFzAqOh4vEW5lWDSF/nBtcZ9Ya+89zmG6vLH7yhP8tR6Vsoh6RYLGJ1luY2D5VxKwBTx
	kq0HiZPiFKg==
X-Received: from dlbec10.prod.google.com ([2002:a05:7022:d8a:b0:12c:34da:e06e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eac8:b0:128:d714:3ca6
 with SMTP id a92af1059eb24-12c73f7167cmr22119688c88.12.1777156907006; Sat, 25
 Apr 2026 15:41:47 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:33 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-9-irogers@google.com>
Subject: [PATCH v7 08/59] perf evsel/evlist: Avoid unnecessary #includes
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

