Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB819D07B
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745384644; cv=none; b=Ef/7mGUfPxPzRiqFKOYXmNbH4VN3mNEhqXkZtQ64mCu+cQPO2+Y+4BPGzESK1PmQl//sYFCUCXPukVU0kKIoTCp+XPobm6eZB18BeMMSFOX/01VEdg8utIIe3UZouH17cJkvt/gyx7TjRAOS+k2kPi9khLCShNPCV3Bqx6ZJLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745384644; c=relaxed/simple;
	bh=oB2HzbtYpc9Q5I3Vg5QkTUqM7V3SyGu8YJi7lZs4R10=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XkBS2DT5k2o0ubZ3+ZxvPUvOJaWII6Tj0GBOL0GUPLGaTMj8rqnZXXMXFXSCRLDNBI+2rCXxPUOp0axGgSu4XOAp5R5rNtVp2HgY6SKnsw1/FFbW/mskNIC72CNkcLk4wS7GA6dOk92hWjCypofToxZek980Cw9iAm72Dt5gFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urA9eEN0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urA9eEN0"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so5332467a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745384642; x=1745989442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c8FjqkwUOy/feAuFkYLTMBE7cfoy6lLV0uD1r/cCh0I=;
        b=urA9eEN0xh/Ca70FjmQBJ9h8vxHH4EwzhE44wwEDiTeMR86L+K4xZia+qpAw+qjgFk
         pOlOEocjeLssDpeuW615c7tKEsOgA3G2ysJISlVVYDUgcCrADrbkDCLd7MJjv0Dqlwv6
         JR0S6QB9IqV79YvVehf5qEnav+VFIse3JwUeFLvRz4cDqCMdCoCUsnDySkv9StDj9HCZ
         ozXK1dtbgce/HcfF8lGKkBsdvvKuPV9Ju4SbKki94fTel3ExzAqNYAvR2TvgyvSSDPYt
         mmDXZCKJfiuGz50fLALmTB1UflrKwMNsHCpmeRXf9oKY+sHESIWRezcRXz/kTRIitchE
         VzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745384642; x=1745989442;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8FjqkwUOy/feAuFkYLTMBE7cfoy6lLV0uD1r/cCh0I=;
        b=d3PL6DiDmSWrFLJPATYCwLM1sKT71E3EDjQjSd137lCWyztCSkgU5wdMGc77KxImxI
         bPjitOs4NkNk1qHBIPN86mzdGwRb7nTvujL/8coLS6T6S9J3IxaCfYrbrJ0lk00q4vXF
         OaV9hJkMrIfoH9C2NxIvgGt5rhuo2Vy+J/I8uOyLiWBHH95l1SjEtBB0vxTYbKDjdlI9
         qww1f+lCSEJg76/L8VIxVCka6m1HoC1htgjlJXuwT9/UuhS7DOKgaFeullX9+IOm38O9
         g16ixcFgJWYwpmlPNA7xc9QknLf5pej1nSIhOYAWmTz9Z1bFcsszjPxiJIrH1nLmyHRb
         37Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXr9h4pIR+v6PtqRi97ZZKzVFpv+A8p3I7vTFQ5IC3eLRsb2lc/PJfnPOeieqKMOUWqMNIfVZeikVHAnleQvUrb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpkii8CNU20PJKvHXbYoqg7u3lPi9LnEy1wFteUpZ/jWgsP1GT
	Qi6r+0+l6VPB502LDDnEMOtsJTlzfDleaIAND5CF3B8If9QOLeNBnkN10MftSu3xRaqIqMhY/km
	gOCfKWQ==
X-Google-Smtp-Source: AGHT+IEbKVuQ+IUoxTP2GjaxL/FeIucG9KFtnMOdHmvOXU/9QIWe+RKO8d61OXFu3KMCelLXzw2U8CktptGb
X-Received: from pji15.prod.google.com ([2002:a17:90b:3fcf:b0:301:1bf5:2f07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d448:b0:2ff:4f04:4266
 with SMTP id 98e67ed59e1d1-3087bbc22b1mr22444810a91.23.1745384641976; Tue, 22
 Apr 2025 22:04:01 -0700 (PDT)
Date: Tue, 22 Apr 2025 22:03:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250423050358.94310-1-irogers@google.com>
Subject: [PATCH v1] perf tool_pmu: Fix aggregation on duration_time
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

evsel__count_has_error fails counters when the enabled or running time
are 0. The duration_time event reads 0 when the cpu_map_idx != 0 to
avoid aggregating time over CPUs. Change the enable and running time
to always have a ratio of 100% so that evsel__count_has_error won't
fail.

Before:
```
$ sudo /tmp/perf/perf stat --per-core -a -M UNCORE_FREQ sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0              1      2,615,819,485      UNC_CLOCK.SOCKET                 #     2.61 UNCORE_FREQ
S0-D0-C0              2      <not counted>      duration_time

       1.002111784 seconds time elapsed
```

After:
```
$ perf stat --per-core -a -M UNCORE_FREQ sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0              1        758,160,296      UNC_CLOCK.SOCKET                 #     0.76 UNCORE_FREQ
S0-D0-C0              2      1,003,438,246      duration_time

       1.002486017 seconds time elapsed
```

Note: the metric reads the value a different way and isn't impacted.

Reported-by: Stephane Eranian <eranian@google.com>
Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PMU")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool_pmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 97b327d1ce4a..727a10e3f990 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -486,8 +486,14 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 		delta_start *= 1000000000 / ticks_per_sec;
 	}
 	count->val    = delta_start;
-	count->ena    = count->run = delta_start;
 	count->lost   = 0;
+	/*
+	 * The values of enabled and running must make a ratio of 100%. The
+	 * exact values don't matter as long as they are non-zero to avoid
+	 * issues with evsel__count_has_error.
+	 */
+	count->ena++;
+	count->run++;
 	return 0;
 }
 
-- 
2.49.0.805.g082f7c87e0-goog

