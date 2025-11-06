Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4563357A52
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470958; cv=none; b=hYx1+19s91IfEJgHd+zmh515dH9JuQokg1/b94kwWwCxqfyFK7yurw7gEts1EG65qc7tzKq86N6OiB+Pm6O20MhqYeWtKh9xSZNB1oP5PMfd/+dFqCapcfH1nWme7e6xv7bgBiGebEVp4wuyiZLFI9dvqP9ZPa7Y3J04gbcNzHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470958; c=relaxed/simple;
	bh=wGLT+L2StwVsEe33LwLx0HGkrBzzAAKBmqSQyKDCyvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rrH3+jElvQrDN6GLRcaBnqj+RROR9WXMOtjUsv7Z9LfHoo6h2oxoYZFhz+ZWcjBnGJJntlvgyzW8y0CakGYjP1otQ26qrQbpdlys2c4O2P0Ut7UR17v+Nt1FFe3u534tIWPwog17bOW/hg3VaDNZ0nlysxjqWDAPExUBlHVsUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6nyTnCv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6nyTnCv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29555415c09so2106395ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470956; x=1763075756; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tCfti0BVw0vE3q2qzPNg4k5C/1/WEypOlA1+Gx0M6jE=;
        b=h6nyTnCvUyO7zMt39mTS6lJ5EHKjrM77FkGhyjiCZozRufDj/skZyffzMS+u8W/ctI
         8H5y94w541z4QVl/eGH9qFxFukqI+zeN7dY69n8uBhXe4STJboCRjJRFB/ilINSKptIf
         WnQAVloqLd7GrzWP/NSexXkqelrV04/FJmKWfYdYe0pwBf8bJDEvq/ZiJnt98tdFx4oz
         7ouzgSu2Vj46IYmseeHa8+kig25lqOpUJvL32+ihGROOHme4HkfnvsAI8tLPErLvb427
         mAqSUvjeFXE09GzRkJ1VGjK+gSKb8a4LtTB/68sWlqgJVrDrBk1ve/Gu/B6qo+rqPWHs
         uvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470956; x=1763075756;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCfti0BVw0vE3q2qzPNg4k5C/1/WEypOlA1+Gx0M6jE=;
        b=sgBvk0Pk0DXW+PQeQRj3zzSq6XI4+5XdmB4VcSfZrC9WrNU5TmR9KQwksUMdc4nwDP
         L8MKU2eHErvt5eaPcdtMyRmndNgSUu5cJ06KKXYwcgjPFFCmdK0MIZFyweE5AIby3qEW
         uYLHEkRSON7NldlWxl7Ph8o4Hn6yFyhFGBc2VuAVu2VYWdsDUAMCyWciPGrUvJCLDnUe
         T8o60QJf4A8f6c8s8654C4yGO6oyzIK5hlY2p+0DaIFEU6irjEP3+0ZsQY628z/t47Rl
         wk+SiOimvN2BZmEXx3+AKDCQDdW9D+pW4VENWngNnG28VP/izGO68KYHN7HKgP+Gs5Hd
         U2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5J+twUgCBbxRG24W5GEzlwR7QReALJ61e1jbMAwpTogMPZVq9PoW1Mo1Fq/TpELeHlP/d69oHZ/kRw2qNd91i@vger.kernel.org
X-Gm-Message-State: AOJu0YyXipHt2GO3vlXGSypjpgHSoPgOYrSSnHqh697RUnzqE/vt22TQ
	AJAlfmlOnBQ2WtDEhHiXXrHbNLNcgJSGWstfLPTZk93I7Xa7ZO0nzLOFhP4LCpDKmfNCPrIkse0
	o5faT8QIj3g==
X-Google-Smtp-Source: AGHT+IEAe+z9vLAwWmr5BuHAiJUh/HgPekXCgVSRIg+YHIscSbYSC4zYjJFfyYeEO+z/ZH5JVzEa7KJNnPwG
X-Received: from dlj34.prod.google.com ([2002:a05:7022:522:b0:119:b185:ea69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a90:b0:269:aba0:f0a7
 with SMTP id d9443c01a7336-297c03866fdmr14660265ad.2.1762470956029; Thu, 06
 Nov 2025 15:15:56 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:59 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-10-irogers@google.com>
Subject: [PATCH v2 09/18] perf stat: Sort default events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

To improve the readability of default events/metrics, sort the evsels
after the Default metric groups have be parsed.

Before:
```
$ perf stat -a sleep 1
 Performance counter stats for 'system wide':

            21,194      context-switches                 #    752.1 cs/sec  cs_per_second
             TopdownL1 (cpu_core)                 #      9.4 %  tma_bad_speculation
                                                  #     25.0 %  tma_frontend_bound
                                                  #     37.0 %  tma_backend_bound
                                                  #     28.7 %  tma_retiring
             6,371      page-faults                      #    226.1 faults/sec  page_faults_per_second
       734,456,525      cpu_atom/cpu-cycles/             #      0.0 GHz  cycles_frequency       (49.77%)
     1,679,085,181      cpu_core/cpu-cycles/             #      0.1 GHz  cycles_frequency
             TopdownL1 (cpu_atom)                 #     19.2 %  tma_bad_speculation
                                                  #     15.1 %  tma_retiring             (50.15%)
                                                  #     32.9 %  tma_backend_bound
                                                  #     32.9 %  tma_frontend_bound       (50.34%)
        86,758,824      cpu_atom/branches/               #      3.1 K/sec  branch_frequency     (60.26%)
       524,281,539      cpu_core/branches/               #     18.6 K/sec  branch_frequency
             1,458      cpu-migrations                   #     51.7 migrations/sec  migrations_per_second
    28,178,124,975      cpu-clock                        #     28.0 CPUs  CPUs_utilized
       776,037,182      cpu_atom/cpu-cycles/             #      0.6 instructions  insn_per_cycle  (60.18%)
     1,679,168,140      cpu_core/cpu-cycles/             #      1.8 instructions  insn_per_cycle
         4,045,615      cpu_atom/branches-misses/        #      5.3 %  branch_miss_rate         (49.65%)
         6,656,795      cpu_core/branches-misses/        #      1.3 %  branch_miss_rate

       1.007340329 seconds time elapsed

```
After:
```
$ perf stat -a sleep 1

 Performance counter stats for 'system wide':

            25,701      context-switches                 #    911.8 cs/sec  cs_per_second
    28,187,404,943      cpu-clock                        #     28.0 CPUs  CPUs_utilized
             2,053      cpu-migrations                   #     72.8 migrations/sec  migrations_per_second
            12,390      page-faults                      #    439.6 faults/sec  page_faults_per_second
       592,082,798      cpu_core/branches/               #     21.0 K/sec  branch_frequency
         7,762,204      cpu_core/branches-misses/        #      1.3 %  branch_miss_rate
     1,925,833,804      cpu_core/cpu-cycles/             #      0.1 GHz  cycles_frequency
     1,925,848,650      cpu_core/cpu-cycles/             #      1.7 instructions  insn_per_cycle
        95,449,119      cpu_atom/branches/               #      3.4 K/sec  branch_frequency     (59.78%)
         4,278,932      cpu_atom/branches-misses/        #      4.3 %  branch_miss_rate         (50.26%)
       980,441,753      cpu_atom/cpu-cycles/             #      0.0 GHz  cycles_frequency       (50.34%)
     1,091,626,599      cpu_atom/cpu-cycles/             #      0.6 instructions  insn_per_cycle  (50.37%)
             TopdownL1 (cpu_core)                 #      9.1 %  tma_bad_speculation
                                                  #     27.3 %  tma_frontend_bound
                                                  #     35.7 %  tma_backend_bound
                                                  #     27.9 %  tma_retiring
             TopdownL1 (cpu_atom)                 #     31.1 %  tma_backend_bound
                                                  #     34.3 %  tma_frontend_bound       (49.74%)
                                                  #     24.1 %  tma_bad_speculation
                                                  #     10.5 %  tma_retiring             (59.57%)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0ac3c8906668..bd48448bd085 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -74,6 +74,7 @@
 #include "util/intel-tpebs.h"
 #include "asm/bug.h"
 
+#include <linux/list_sort.h>
 #include <linux/time64.h>
 #include <linux/zalloc.h>
 #include <api/fs/fs.h>
@@ -1857,6 +1858,35 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
 	return 0;
 }
 
+static int default_evlist_evsel_cmp(void *priv __maybe_unused,
+				    const struct list_head *l,
+				    const struct list_head *r)
+{
+	const struct perf_evsel *lhs_core = container_of(l, struct perf_evsel, node);
+	const struct evsel *lhs = container_of(lhs_core, struct evsel, core);
+	const struct perf_evsel *rhs_core = container_of(r, struct perf_evsel, node);
+	const struct evsel *rhs = container_of(rhs_core, struct evsel, core);
+
+	if (evsel__leader(lhs) == evsel__leader(rhs)) {
+		/* Within the same group, respect the original order. */
+		return lhs_core->idx - rhs_core->idx;
+	}
+
+	/* Sort default metrics evsels first, and default show events before those. */
+	if (lhs->default_metricgroup != rhs->default_metricgroup)
+		return lhs->default_metricgroup ? -1 : 1;
+
+	if (lhs->default_show_events != rhs->default_show_events)
+		return lhs->default_show_events ? -1 : 1;
+
+	/* Sort by PMU type (prefers legacy types first). */
+	if (lhs->pmu != rhs->pmu)
+		return lhs->pmu->type - rhs->pmu->type;
+
+	/* Sort by name. */
+	return strcmp(evsel__name((struct evsel *)lhs), evsel__name((struct evsel *)rhs));
+}
+
 /*
  * Add default events, if there were no attributes specified or
  * if -d/--detailed, -d -d or -d -d -d is used:
@@ -2023,6 +2053,8 @@ static int add_default_events(void)
 							&metric_evlist->metric_events);
 			evlist__delete(metric_evlist);
 		}
+		list_sort(/*priv=*/NULL, &evlist->core.entries, default_evlist_evsel_cmp);
+
 	}
 out:
 	if (!ret) {
-- 
2.51.2.1041.gc1ab5b90ca-goog

