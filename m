Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE633B97D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049284; cv=none; b=uXX1420Z/ecpPq9lFBRQ4R1sp6fbtCgIz8q+nV3BKCb3J2u9S235ZUe0ZgZHBbxezXexZuNaxCI477jobyi68jEUlVLCzWBZgRHtC+11/w2FKrPYgkBW+KcPbDM7KNVToBSRxRCr21IjuO+czhfaQzsAAZWtOsRj4DGU16pgusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049284; c=relaxed/simple;
	bh=FP5o9n90ZT5agsSGJdl1masLAbe0pH/IJ+EbWllzEcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIDCwVdwCzph7i8MbENWoBK6hnf/hxMREDS307lG/eFiTxfmX1ex7G0w0c6ODgmEwo1gP0oGgyZEPQ/CWOaNTmwq7iCHRzY3xG4eDUvq89wIDlboshE9jTpJmwiJ0pY62r+Di3VQGwR5Lulht6FpQmiA1iYweYailP3aiKtKJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZcRyAn4; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZcRyAn4"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso10402155eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049282; x=1777654082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=HZcRyAn466NbDCRejNAHZeTPkZKj/syx4Ay0/cv9G1bZdshxFnI2Zs7OnsFUVUSdo4
         nxCznQ+Yzg0HAiOyFynk4xnmL/4yo0NEG0uxcOE458Fzui0LWWIEcH2RCz/sQoYQe6HD
         7edGzuXSxcaEDdrJRGP2q/Cy7HAvHoEEeWrbBezNV4JJDxeDDU0Sl8noIAVRKsd0fWvv
         iGohR64wOvOexAeOrZrfJTqc5ZopSpPC9f8R9mg6MG1cy4yJ2lQi7jn3kP5lnxcMQ4kj
         mGKQMUf1ZK57v+8tNzD54nhBGcW6uAm9GAfj2jHBc4RyFO6aUwK/ZReKPrI3sZOhwzcJ
         R9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049282; x=1777654082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=CfwDB4cSDfctoboM2K7srxGqW7m+IDPw2My3kOdx1P1niE5pY6cAVBrdk1EEUC/bHu
         qM1Cosm5K9ls5D9ZHCfhaXLr4W/GuY90rR3upBjqd22SNOQqz8Ytflfbbq6KlCo7grej
         xzMlYK34XEEV2BS2tV84uQIRVy4welB0AxRM1ntvGTKjnxd81QgL5Sa/ZA6vY1d26rMs
         XK86SwRWwxDFfPVPAbh3lqksrRltEfVNnFMlanR0zUvtvdmpNrT/6lRmdB4VyyKGWphe
         HR98UyhJnb0/6EBek37oS98Bljw/qTz20mBgYqXQRcwm8onu9P00jUjFJxIsfwZrwuCo
         HIAQ==
X-Forwarded-Encrypted: i=1; AFNElJ8buH163MO0FJ4FFWUnmVsR9PvRAhJHjRFsP7SLJuw7Q8O25w2mm/0ovkL5dzWPX+SvRa9IZ3Oz04gs8wB+ezBr@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8T6dYel74COnA2OALSGLnXjtbHUgZgTuw2EuDXx7abV4sb5q
	2e+EprJ0xi7nxal6Iyc/v3mqVBYhLYAlUegIfPd2eUylCquiDxij49txOfps8xsEdz72t7n1SzN
	JJJ3SuKiZbA==
X-Received: from dybrt7.prod.google.com ([2002:a05:7301:4707:b0:2d8:e988:4a97])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4185:b0:2e0:1f09:d924
 with SMTP id 5a478bee46e88-2e464ea9aeemr17387563eec.5.1777049281746; Fri, 24
 Apr 2026 09:48:01 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:30 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-9-irogers@google.com>
Subject: [PATCH v5 08/58] perf evsel/evlist: Avoid unnecessary #includes
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

