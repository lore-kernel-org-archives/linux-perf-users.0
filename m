Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D6734B691
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833887; cv=none; b=qr4KMPD3o0by+1dM1f8y39JF5sRTWWpsdkA8K20eJAoxXn5wIDuFxW/CJQOISOadF7eSBhzAqysDkz+PhIK944S4cOT6aonyhDaxet79Ql/qRr/0hV9l8A8IaJNmOf8mNRmq1RbAuxf/OYsZz5ch3cL++/MUpSjRfm3gOVL5PlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833887; c=relaxed/simple;
	bh=z5ai+zFpH2QBuK5+a38Mk4V/HsbjWKL3F0Fj9eLHmOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C6Z/9LbGGLOSoc0MlkfPGfVBuDRwhHpA+Y3EgIjyqCF+ygAnjUkUhuh5id+AWQ6167naA0F7CMFMLAAAnX/dff/OyiRxVOEm5ahehP5QKdbCsKRoLqUru69LsX38q8m4zB9GOVCqd2trOW0K9DgUZ/lpsKCMNyl2RB2tjd33LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDrUy1Ag; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDrUy1Ag"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-298389232c4so10574425ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833883; x=1763438683; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISmadZFruDrBTfreeqdnoWbjJP8/Vr5LKfdKCjHv7vI=;
        b=IDrUy1Ag++ETbjpvi4DjUAPyxQmO5YO/mEGDjD61V2YDudaWqmvr3EbNtmVRtDh5Pa
         UyrZdmF9i690iBwiWDH++QZP8JHcz/1ChbbfYs6wf4eMfNu8+Liicem8EEmzUQB3Pw5h
         z0241W/d3tA75ZSKa5XN1UvGOJAk8z7D96/DEW3RhXvKLelXfc+CYxpUQIz7LuIauAFy
         zbGB45kcn6PmRbxDhCRvO9bh/KZhoehF/9Gywv5tJ8OSHiLxZbEC2aGCdJbWBzHKucb1
         hieZg0dMpRbTMEn2A+pHhBKvxftKeviNzR858VHCLiv3x9PzgJe4UZfq19CGWhi2nNoK
         UT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833883; x=1763438683;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISmadZFruDrBTfreeqdnoWbjJP8/Vr5LKfdKCjHv7vI=;
        b=j0/8++mfYS9TBYzDgCc8FZ/kx0mf/M0INq6+LC9y5vrDzXzh+S3+uPk0mcwmQ+wigM
         1T9J//A2SHTmeP8G3f26AWE7a0S1UsFjaIowGoTe6jbqamxT1T6iNySaQ+84vrdXnutT
         HKA2NdvmUkrfWbktSqkXxNBgSOu78w5ZI6Cu6CD/0GE7OfB0fYEUQHiFmzAA7vnOgxH9
         NF5MQbxPkY5+nsgoDgamgrWRIhH1QI/K6lSRJ7/vP7u2b56V4gVQRSSHH4EcsWKQrBX9
         j5gZwaJf0WAn6tHxD8BUe1+5VyECLAUDGJdhISBR8H468fUxhcgw5LjwClRZ08vUnBqm
         rUtA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZLRwBNWnIiII0639kfwYS52cB4b/odNIbOZmRVKGsSmWYOcvnBPzGOamn05PaXxNuw/GL8iS7oROKdyQVp1v@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmrDyJ5vauCx0w8efxHAsm02deoFPuRODAPFrUG2wGLiqH2Sp
	sLAkHsR6TiT7ShbXO+Mg1mbmxd8+Gm7GQ14J1y0hnif8fPUC1sBItu45oGLa+xzDWfOjwL4piwR
	iN9Wnt+ylkQ==
X-Google-Smtp-Source: AGHT+IGiBXsZJvHje+7C1vX1eoueo2kY601eMqrQfibmvzA4SzBeU37Zi/9PcAuxsjuO8ZRjv+M6a392ts8N
X-Received: from dlah8.prod.google.com ([2002:a05:701b:2608:b0:11a:51f9:d69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4b:b0:27e:f018:d2fb
 with SMTP id d9443c01a7336-297e540dbf8mr130637515ad.6.1762833882935; Mon, 10
 Nov 2025 20:04:42 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:08 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-10-irogers@google.com>
Subject: [PATCH v3 09/18] perf stat: Sort default events/metrics
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
index 7862094b93c8..095016b2209e 100644
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

