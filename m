Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26E35C1A8
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896158; cv=none; b=LTBv4bCoEIxsO8u91qxEV71X0teeRfxSIBBJRhJX80xZX+d4fGEX779xR5kfjgcXZLHx17lRvc9brHYa+4znzlyVxpmVSD3GQ2o90ZpkOKomRPqzOJpj6qXgH4pnjJKhoDymIJYJlqkKeg35fks/y/LJkB5i+T64EkH4q9E9/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896158; c=relaxed/simple;
	bh=mPqomsEvD+uDvuUCsVsHNRtD2HZ9SSw52pwrJZWVt/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kz6XDA62C51+L7L2x5lV8qypPLI7div2BRszHMhsGu19Xuil3cc/IDTidDmWdun+rkVOCXkxzhwXX9VsQX8H/Q1Zv8M4IEQHyXmKr2jYGVwTsTt3+igtkosuj3haWKaZeXl8oQpteXUrSbi2r058/QN12c5UpHwk5+hX8Hf2b4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UfZAC5Ca; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UfZAC5Ca"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so131103a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896155; x=1763500955; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDnrv0jnbZn3gDfnXEnUYKX49tEkQacFae5V8LtbXq0=;
        b=UfZAC5Cadh1PfgRQPFhomU/vP7PA/n0jeWDRGmoKrSQ8vUU6PmuGE1Xm1BB1ZYAcp4
         bUwhglSO2app2i2sEriLNjCOilmoBsk/2GixzKKMIe32Zs33KEbj6N65hZ3XY7qYT1Z/
         UUQN3nAmfUFCbMTVrlulQA0f5kl7ZuW1DzEXksTVhEYS9drhtTLEX2RAXYV3oV1+l98C
         ghYAKJ2CBKy5P+Gc+Q+ufitSPtoJ/Vh/b72KPF8vUDd+jmf2M0GknU55srWFfxkg1Lcf
         6YS3Xx3AVnuJOyGBIv3Zl1o8GQqbpP0rjPUH8X9/NJiEsOyxQTdzNuPXUGYs6o0U9LBX
         /ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896155; x=1763500955;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDnrv0jnbZn3gDfnXEnUYKX49tEkQacFae5V8LtbXq0=;
        b=rVjZIvvKmpRzGwQI4mZ8lWvzgPz5JfUKpa2By1MA/FwLiVM5cRIBjN7CVSgj1lBXue
         txJdAMUV+lsMe2Koh563srjg6mdwvYeCO7ivPf7VzxwPZeXGexPqr6QQFB/GpM8/xrcB
         2EZHxFsC1clSAgS0DifOfE7Uz4uY7x2xBRG2i1Ip/MlXbwJMwor4sO4Sa6ztR81wX4RT
         Re3AV95AS+HFOr3J7+RL0H0zcGqoxbK7hX2PlBcX140MOvvyPe5+zOHxsmB1iUsWqxHn
         2GVbgpzN2sWhTQhI9IBWP23IJ93zdZvk86FhBLe5//Nk5IOML9cDi0W7rmfrh2ZpUSpV
         mMog==
X-Forwarded-Encrypted: i=1; AJvYcCVR5Nl5VPzyBnKwnzvGYuMw67FktjFUhoheUkgkqET80PmmK786OlY9/B6qplMLT4RfJrZosUutB2WG5JyhjZkq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7c5Lg/TkPApg9PcofKX3HmN+kQgsBwL5rUUaYOV0MpLVODUut
	q2NOHzGWJDJ262ldw659zJr1RzyIYt4r/rg8ZcIXOOXmPqdebSRVQNxAH9nvFCvOePed9rxxLko
	wIxvNS0mlsg==
X-Google-Smtp-Source: AGHT+IGYliipBIcYMFjzpqFJTq0eEvT7up1H3c8qack7Mu6PR4HUPrqh+AlkQ/O/cspTqJiSVLTvIys71CKK
X-Received: from dybsc19.prod.google.com ([2002:a05:7301:4b13:b0:2a2:367e:4ef9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce04:b0:295:9db1:ff41
 with SMTP id d9443c01a7336-2984ed41fb1mr9997815ad.21.1762896155392; Tue, 11
 Nov 2025 13:22:35 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:57 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-10-irogers@google.com>
Subject: [PATCH v4 09/18] perf stat: Sort default events/metrics
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

            22,087      context-switches                 #      nan cs/sec  cs_per_second
             TopdownL1 (cpu_core)                 #     10.3 %  tma_bad_speculation
                                                  #     25.8 %  tma_frontend_bound
                                                  #     34.5 %  tma_backend_bound
                                                  #     29.3 %  tma_retiring
             7,829      page-faults                      #      nan faults/sec  page_faults_per_second
       880,144,270      cpu_atom/cpu-cycles/             #      nan GHz  cycles_frequency       (50.10%)
     1,693,081,235      cpu_core/cpu-cycles/             #      nan GHz  cycles_frequency
             TopdownL1 (cpu_atom)                 #     20.5 %  tma_bad_speculation
                                                  #     13.8 %  tma_retiring             (50.26%)
                                                  #     34.6 %  tma_frontend_bound       (50.23%)
        89,326,916      cpu_atom/branches/               #      nan M/sec  branch_frequency     (60.19%)
       538,123,088      cpu_core/branches/               #      nan M/sec  branch_frequency
             1,368      cpu-migrations                   #      nan migrations/sec  migrations_per_second
                                                  #     31.1 %  tma_backend_bound        (60.19%)
              0.00 msec cpu-clock                        #      0.0 CPUs  CPUs_utilized
       485,744,856      cpu_atom/instructions/           #      0.6 instructions  insn_per_cycle  (59.87%)
     3,093,112,283      cpu_core/instructions/           #      1.8 instructions  insn_per_cycle
         4,939,427      cpu_atom/branch-misses/          #      5.0 %  branch_miss_rate         (49.77%)
         7,632,248      cpu_core/branch-misses/          #      1.4 %  branch_miss_rate

       1.005084693 seconds time elapsed
```
After:
```
$ perf stat -a sleep 1
 Performance counter stats for 'system wide':

            22,165      context-switches                 #      nan cs/sec  cs_per_second
              0.00 msec cpu-clock                        #      0.0 CPUs  CPUs_utilized
             2,260      cpu-migrations                   #      nan migrations/sec  migrations_per_second
            20,476      page-faults                      #      nan faults/sec  page_faults_per_second
        17,052,357      cpu_core/branch-misses/          #      1.5 %  branch_miss_rate
     1,120,090,590      cpu_core/branches/               #      nan M/sec  branch_frequency
     3,402,892,275      cpu_core/cpu-cycles/             #      nan GHz  cycles_frequency
     6,129,236,701      cpu_core/instructions/           #      1.8 instructions  insn_per_cycle
         6,159,523      cpu_atom/branch-misses/          #      3.1 %  branch_miss_rate         (49.86%)
       222,158,812      cpu_atom/branches/               #      nan M/sec  branch_frequency     (50.25%)
     1,547,610,244      cpu_atom/cpu-cycles/             #      nan GHz  cycles_frequency       (50.40%)
     1,304,901,260      cpu_atom/instructions/           #      0.8 instructions  insn_per_cycle  (50.41%)
             TopdownL1 (cpu_core)                 #     13.7 %  tma_bad_speculation
                                                  #     23.5 %  tma_frontend_bound
                                                  #     33.3 %  tma_backend_bound
                                                  #     29.6 %  tma_retiring
             TopdownL1 (cpu_atom)                 #     32.1 %  tma_backend_bound        (59.65%)
                                                  #     30.1 %  tma_frontend_bound       (59.51%)
                                                  #     22.3 %  tma_bad_speculation
                                                  #     15.5 %  tma_retiring             (59.53%)

       1.008405429 seconds time elapsed
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

