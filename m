Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1103112BB
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763157959; cv=none; b=UxkFoRUlvM5IphbwfyOqlOr+KdUk0t5TeNO1EKBwXi6ALcU3c4PHOoSeJqWOTMvwIQpGlHbWqEkltY4rFH2nDPzJNdZlfYZndHJKd6xts0HMhroKRJ6rhSaKueTYGgeirRt54+OKyyk4lEaN43pWPWeAaf0RMYSdtrqmVUHRz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763157959; c=relaxed/simple;
	bh=dWtmIi42n+cGRypKNCWX0aYJg1UkKOR3jqiXU5PN0jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DdgzrIfqdtio7WqGUTwoMacWzpv2+6B9ssyhq20fAEGchnDSf3bCbfAkh25STT8mNZ39xnmoU+BOaoahcjgJOOHWBRgv7rxI1q9/yAVWsbxngcOu9q1kvEqIwS5EnjKKa3g5czSUwRGLgZMwy8MUKaFEtaOIUb+uGqtUEJzdATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ge9yEuYO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ge9yEuYO"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso5506374a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 14:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763157957; x=1763762757; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW8g6E6wuseF8R53IBGl3qHBxpIGSbliEbwCJCZ1Dns=;
        b=ge9yEuYOJkQupY5yEc+hLHNL471kBZQsXW/VnTcqDkQG4XK0y9TukjR8J3VyCSKfG0
         XzXFIouG7Ou0P1/Eud1cbat8YewH708EE51uxyY7qq5q2B1aK9FejIL8Oir2EWwCyZTl
         dL9xF9AXUUvLFzF9x/zQSm73VMHymffmsfmN1oM71wUjz1iPUHEECejkkEiPWbme5Ivu
         2OS1jjHVWrXsrW1jpqkUExvzarprP97pB0pNSbzzXijfvA4jC1Mlwdvp5KTjfylrMYC4
         xTjK04pVXTAiad2qQWdp3lfnu53CuqBIiwa9Xcd3TnYCQscFz0Ff51XM3zqcITYNssL7
         Ajzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763157957; x=1763762757;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HW8g6E6wuseF8R53IBGl3qHBxpIGSbliEbwCJCZ1Dns=;
        b=XjIBqFqhM68V58nYVRHpz68/e2RslJaG8UjHkwYgrtOTcPC6k2HsYx8+BOF7THaEbD
         W/7DdqDkdmt8Qjb/W08tZKjacV00nMYbgHCnyY1KsTjI8535UnGp58G6YtOCBDqeMVQi
         0bS2LG67UZhs3G1dCNsrL9PBV1YskPHOluSr5/u231Srtq+lX1WLIZn2Cx5MuDrfin/1
         DIAgz4ANVTwvOSXRyu8kRlf9aZcyt3qqUyZTFWxz2pJn944+5/nKUhlsKq3bWi03ZazV
         EGKVK/DB8/rpFykCG+RnwB1HLVDPy52wJjEqFWQhMuBqColRlctE5byTbNJkW6xc+MVK
         WzAg==
X-Forwarded-Encrypted: i=1; AJvYcCXoylZm3v9Oi9hrG005KH9V6BB5yei73DktmcYNSZrARMn7gjRQIJmfElKmayjus0+lCqjP57VNKUDV/3sKZ6IB@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZhX/kpVoGmi5+NHU7X4F1fFmAcuHbDPI4wH2vPHwSThN6NF8
	zEjCBttRlEZK4wMDyv0zfhupAPl60txYxLyJH+k6P0u3IIRS2v3DqRTu90U6iPiMaHbR9Yf/7ju
	vvMbH+TWkHA==
X-Google-Smtp-Source: AGHT+IG/QEJy1VSBNaJGAiUUw0LzTxNsm5zFdT1h8QNuUaL4aofpanXaEa9qQkeft/PhGMqdykt5EgumSadm
X-Received: from dybnc27.prod.google.com ([2002:a05:7300:cb1b:b0:2a4:5178:f11f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4142:b0:2a4:4bb4:4712
 with SMTP id 5a478bee46e88-2a4abd8d009mr1474830eec.39.1763157956640; Fri, 14
 Nov 2025 14:05:56 -0800 (PST)
Date: Fri, 14 Nov 2025 14:05:47 -0800
In-Reply-To: <20251114220547.496562-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114220547.496562-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114220547.496562-3-irogers@google.com>
Subject: [PATCH v1 3/3] perf evsel: Skip store_evsel_ids for non-perf-event PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The IDs are associated with perf events and not applicable to non-perf
event PMUs. The failure to generate the ids was causing perf stat
record to fail.

```
$ perf stat record -a sleep 1

 Performance counter stats for 'system wide':

            47,941      context-switches                 #      nan cs/sec  cs_per_second
              0.00 msec cpu-clock                        #      0.0 CPUs  CPUs_utilized
             3,261      cpu-migrations                   #      nan migrations/sec  migrations_per_second
               516      page-faults                      #      nan faults/sec  page_faults_per_second
         7,525,483      cpu_core/branch-misses/          #      2.3 %  branch_miss_rate
       322,069,004      cpu_core/branches/               #      nan M/sec  branch_frequency
     1,895,684,291      cpu_core/cpu-cycles/             #      nan GHz  cycles_frequency
     2,789,777,426      cpu_core/instructions/           #      1.5 instructions  insn_per_cycle
         7,074,765      cpu_atom/branch-misses/          #      3.2 %  branch_miss_rate         (49.89%)
       224,225,412      cpu_atom/branches/               #      nan M/sec  branch_frequency     (50.29%)
     2,061,679,981      cpu_atom/cpu-cycles/             #      nan GHz  cycles_frequency       (50.33%)
     2,011,242,533      cpu_atom/instructions/           #      1.0 instructions  insn_per_cycle  (50.33%)
             TopdownL1 (cpu_core)                        #      9.0 %  tma_bad_speculation
                                                         #     28.3 %  tma_frontend_bound
                                                         #     35.2 %  tma_backend_bound
                                                         #     27.5 %  tma_retiring
             TopdownL1 (cpu_atom)                        #     36.8 %  tma_backend_bound        (59.65%)
                                                         #     22.8 %  tma_frontend_bound       (59.60%)
                                                         #     11.6 %  tma_bad_speculation
                                                         #     28.8 %  tma_retiring             (59.59%)

       1.006777519 seconds time elapsed

$ perf stat report

 Performance counter stats for 'perf':

     1,013,376,154      duration_time
     <not counted>      duration_time
     <not counted>      duration_time
     <not counted>      duration_time
     <not counted>      duration_time
     <not counted>      duration_time
            47,941      context-switches
              0.00 msec cpu-clock
             3,261      cpu-migrations
               516      page-faults
         7,525,483      cpu_core/branch-misses/
       322,069,814      cpu_core/branches/
       322,069,004      cpu_core/branches/
     1,895,684,291      cpu_core/cpu-cycles/
     1,895,679,209      cpu_core/cpu-cycles/
     2,789,777,426      cpu_core/instructions/
     <not counted>      cpu_core/cpu-cycles/
     <not counted>      cpu_core/stalled-cycles-frontend/
     <not counted>      cpu_core/cpu-cycles/
     <not counted>      cpu_core/stalled-cycles-backend/
     <not counted>      cpu_core/stalled-cycles-backend/
     <not counted>      cpu_core/instructions/
     <not counted>      cpu_core/stalled-cycles-frontend/
         7,074,765      cpu_atom/branch-misses/                                                 (49.89%)
       221,679,088      cpu_atom/branches/                                                      (49.89%)
       224,225,412      cpu_atom/branches/                                                      (50.29%)
     2,061,679,981      cpu_atom/cpu-cycles/                                                    (50.33%)
     2,016,259,567      cpu_atom/cpu-cycles/                                                    (50.33%)
     2,011,242,533      cpu_atom/instructions/                                                  (50.33%)
     <not counted>      cpu_atom/cpu-cycles/
     <not counted>      cpu_atom/stalled-cycles-frontend/
     <not counted>      cpu_atom/cpu-cycles/
     <not counted>      cpu_atom/stalled-cycles-backend/
     <not counted>      cpu_atom/stalled-cycles-backend/
     <not counted>      cpu_atom/instructions/
     <not counted>      cpu_atom/stalled-cycles-frontend/
        17,145,113      cpu_core/INT_MISC.UOP_DROPPING/
    10,594,226,100      cpu_core/TOPDOWN.SLOTS/
     2,919,021,401      cpu_core/topdown-retiring/
       943,101,838      cpu_core/topdown-bad-spec/
     3,031,152,533      cpu_core/topdown-fe-bound/
     3,739,756,791      cpu_core/topdown-be-bound/
     1,909,501,648      cpu_atom/CPU_CLK_UNHALTED.CORE/                                         (60.04%)
     3,516,608,359      cpu_atom/TOPDOWN_BE_BOUND.ALL/                                          (59.65%)
     2,179,403,876      cpu_atom/TOPDOWN_FE_BOUND.ALL/                                          (59.60%)
     2,745,732,458      cpu_atom/TOPDOWN_RETIRING.ALL/                                          (59.59%)

       1.006777519 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
```

Reported-by: James Clark <james.clark@linaro.org>
Closes: https://lore.kernel.org/lkml/ca0f0cd3-7335-48f9-8737-2f70a75b019a@linaro.org/
Signed-off-by: Ian Rogers <irogers@google.com>
---
I looked into adding metrics to perf stat report but there would be a
merge conflict with:
https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/
so holding off for now.
---
 tools/perf/util/evsel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 989c56d4a23f..aee42666e882 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3974,6 +3974,9 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 	if (evsel__is_retire_lat(evsel))
 		return 0;
 
+	if (perf_pmu__kind(evsel->pmu) != PERF_PMU_KIND_PE)
+		return 0;
+
 	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
 		     thread++) {
-- 
2.52.0.rc1.455.g30608eb744-goog

