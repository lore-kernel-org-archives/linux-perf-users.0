Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBBE38F922
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487496; cv=none; b=MpdbiFXamud/TkMq9GMQUhIHtOeJ0QxfujrHL610VhrGszYmgC/oE9GhEDjC2U6PE6zBcH6zN4Z+vIXnaY2eJcAAyIHKppLwB00C21gqSdT57r+zK/iHx1hDJfj5DLYHoH9ZlwIQ2LalJMx0YyWSnalmVN69sCwCrB5wWapN90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487496; c=relaxed/simple;
	bh=vumwsMzw2OKnkaJH3dZkbheLZPdnOIMAA8QJLUg1C1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZWc4wYdEQJqsVB9VBZd6ZnU5sTh4JpRYQpUA3u0I05gS7ekq/RPRdlnUZaC8ND/6WHsCCf4lp9NDwVJqpdJOVfL9UHO6+cskPNNMW+gmOEsqXiEQKvjI0xrxwfZk59jPto3gNE4WnO4ckYlgdzM8ZfyU6fcVUHfG4P49oI+n6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMrGZsYp; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMrGZsYp"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ef62078ee7so8955772eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487495; x=1780092295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dI6//58XLq+utXNtomlMShi/6Q6ufN1k/99x8z/TUk=;
        b=lMrGZsYpXTwKO9cnf2PDxAbwpl+6/8vLRADd0fwkKcPkfrzEvRN5wQhIjyhXVPhGVe
         vMeQcB6sf44SSbi2boj7FE8Jv1JwffjRyRheHwwgupt1mNtHOV3ivrW9Ny/6ny5GLn6S
         DLNlxuKSOwVnx7vqv7cDiz3PP2DrSDZANmKCdfTqhA8KaZiHmzsSUGShjDFQpvO8xhaU
         C3xK6ynSKmH4kE2iD8pLp4F2zx4IknS1AsTeAnpOiWSy+H78M1HGPUON3sjP+mCrFD8E
         k4n/DyUN2Ssk6S8rwQ4w9s3X2W1WXpi0+IhklaLzqzxGdNiV85nqdqFAom91C+Wtgu62
         0heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487495; x=1780092295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dI6//58XLq+utXNtomlMShi/6Q6ufN1k/99x8z/TUk=;
        b=SIbDqo3ZZggunNZaFSPAEXSZJw+JEB5X8fQBByXfYGf4ehpn+4dBovtJuc8q3R/DMW
         WrWmZ1Z+1EJcQ1KMj7PYGlx1hIhi2A1qxiKKDLadS8whpkVnbtTtMYiaoBXg1RPv8GKe
         6o0wFgpHP1sK9Eh5xTnsF3Xgwh1YFd8qg+tY2ddk5Pe40FPFsrZ0E7lx+PIhkdM1gNpL
         MU7KIIX6zfktbnhYKi/Cbv8dLYkhj7yqOjo6Ym5uloKHpnYybZsyGrZWnAyXxOV6NMTj
         mKdYPUxjiFU+AAJnlrbRXpS7f+cQPKHf+FzVwf/6wI9ee0D7bsiPG5xQTAyGox/fs1VQ
         dB4w==
X-Forwarded-Encrypted: i=1; AFNElJ9CN4k4nvlgtXRXLx3KwHYjs0LFZ40QJmX3G1JtQFYEnB/E7sDRWY9vWuC9c55zVUjFdGXPZ98dvk8fepLWzT1y@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNJ9Iteqw92kGgvxoADlrxpgxt2IaL8UtFDO5D9tY2vV3IdLU
	DrQN82lbJUBBiv3uwF2DwJrliahVvFk0WYAxtrGHmh8uYrchd9LLOqucl8LL6IeF1BoGpfLCsck
	QzW1j+fCDHg==
X-Received: from dlb3.prod.google.com ([2002:a05:7022:603:b0:135:e6d6:d14d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:699f:b0:128:d5bd:3572
 with SMTP id a92af1059eb24-1365fb40573mr1929174c88.31.1779487494444; Fri, 22
 May 2026 15:04:54 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:18 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-8-irogers@google.com>
Subject: [PATCH v9 07/23] perf evsel/evlist: Avoid unnecessary #includes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
index 927e5b4756cc..2221694bb819 100644
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
2.54.0.794.g4f17f83d09-goog

