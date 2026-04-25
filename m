Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAD391E44
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157430; cv=none; b=h5aveG6H9f7l0kzqBWbY3tergbve/RENx6YWUPIf/bbXMeD1ySTvLcAPmfqi7pIviYlIpMn3n/2WvaUAEjWUex/1tkRnYjU4T7a5YTIXk9OmiGnCx0IqjyLNJzoEussi4x/m+tySDxQ50C4kli+ANUCg5x+XUBUbNuJnPGKxryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157430; c=relaxed/simple;
	bh=FP5o9n90ZT5agsSGJdl1masLAbe0pH/IJ+EbWllzEcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dgAYzM0PT1hzui1pEFFCdDFYTuy/Lm40xvLQC1EmXwuZrnm6/YuSqG5xaiSVYJCNbyEFt0akUouQhC2spOIGafGFjIpAER8Yq8J6MfsQ/sTVO+RGC2QRH83mn34qbU6F9bg71P8KCES/doE/oiKwNfJp7+ylnB94AEur7ogLqII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SuVDRJQe; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuVDRJQe"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2eaf70f3b5fso734207eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157428; x=1777762228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=SuVDRJQeiP5hEHiYJ9oWwgHp6+QSVqJZPsM/h8GIBA+5zsR+j3HecQ2l6kt93iCUx/
         4aPtN42T5Ss5oh1/RY7Vie/9ckmDT0v1K8KmqNp1HQreppf6Tp7qWIGS5CMcUejli+EU
         ppoJoPUOx9u3MHoDQtfF75pVRoT13xOUbZu5AlfQVTXDvbDw5PHe1zM9zBrd3Y2rxRIE
         ET5q2rpGUDIGkCqoTCEhPk/ukOpJUdZzQ5LqBXpVZYSIo/YrfGeejh/+excJ3gO0sO07
         z+VdHbEkZ3hvHm+yE2rqMLiIBN3Zlo1voqxEdCda/lFq1T9P35CtXkru5eBcreTj5dS+
         uIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157428; x=1777762228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niT+j+ygae4DUDVZvlLCzSKgJX/QJcllkfXgy9y3G00=;
        b=hvULbdjzRTL7BTHYmd/ZIJDnDMz8wFLhwQjoHmtIYOM0bnC7zgnoRoDZjYl22I43ha
         hMkySZg9yagHhYBlp7FFjwssy7T8/fyhcmlVQtysID7hBlyuRHGqO81q5Rt9ll+jYfRR
         zykGNCv2xKqG49AfIapq7wJlV8N5AJhfO6AyRvKZ+U1KzGTNs/M/PRoEq0TBwkosU0Kq
         e6tQ85OEAfXg2TEr1L0qCTzbB7kYoSUiulIWZyc/w9BobbxtHQQsMPaJpPq7kmmXMGWg
         Gxb/ORF2edyovSWiYXTn7cwCqrJKX9r5CAX0rWAihJV5qN2ljqPElZaOsxSmnzMlq0SL
         S9Iw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ye7SFdPr97/ivxROqccbuCK5YpXA87WpaM65SUL4n+FmJiLjLvJfqW8lHYfU4eokr1xA+pTcbxUv8YWDEclzA@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOHqKk572nGf2Kcq2DZ4vRNydmBQaBRsr5C2CE3kzlVj5Wu6L
	UnKaQ1p3hzNBvlB4eNV+8q9F/aW7TppWvKuXJx6dYqqyY1GxEEkN41txAVuXLepjYmMEuAAP10H
	9eOjF57p4UA==
X-Received: from dlbpu10.prod.google.com ([2002:a05:7022:e88a:b0:12b:fba9:5eb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4199:b0:12c:2cf8:2f30
 with SMTP id a92af1059eb24-12c73f83616mr19958155c88.15.1777157428055; Sat, 25
 Apr 2026 15:50:28 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:00 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-9-irogers@google.com>
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

