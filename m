Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BEE1F0E2B
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624979; cv=none; b=jeooc5jc9A5FOaow7Qz5MZGKUNEHEAF8jS8s8ya5rchedeU/zLNhdXCTclq8aNZLOpjGkb+YB1wm8RbcdOMdtJGTllgyHECruTk2owjhdTm+I0UvAbz/U/fD1O+UC1SLp1FWl7i6YEGjMJ5UUVrUmhGPns2YuKhpfkuGz2ktF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624979; c=relaxed/simple;
	bh=NqnWpcdFkNGPmqWCPNT6GGaIm7Gc0q9VpwYczE12dRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YG5iQN68nUQyc7TDQVAHnld6pvW4SJBMSy8mFDRANVGgWodxxS3u3uhx/xj/9CehAdj/Zbz1trPEOa3wMX/zSR/vKlnyhWf4KzpuW811xkCwB9RxU3/Ggh4nyREd7Cl3krrBVtm8HgnS4xxrbjNerRR3QlHFGF9C+Vlx5l1llTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWXp68gG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWXp68gG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224364f2492so1691045ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743624978; x=1744229778; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVMZzaRI0SYaZ9HIFXqjbn9kAaASuQl6uCuXVUyZL/Q=;
        b=oWXp68gGcpbatrX/v+U5Sy6YtXo2PXM3WnBs4mDHIwt8mRrjegp4QVIh8xQ9chB6ZX
         zgXjXG3whyF7b0TiDPPzdOdZ5Ffe5JcJ6WOJMZnUQOX6r8keR7uFKGtf1r8cPFVgCwD2
         xMhvxZbwMOIn4WKY5F/eoLFd1/aXuci4s3qVLiBjD11psFFVOaL5CyI3sJa3eauL/l49
         VmBXVn9iXCroJ/O6nCTytYHsw7cCkR15IQDjA2FNkEhsvJjAwxpg1KnkNu54KegJP9q4
         T1JKUOIH/DK8RKpBbCZ7F8QaLX8CRUxtPXIQabjLofs8KBDAzXFSXnTaGchouvs5squl
         /Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743624978; x=1744229778;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVMZzaRI0SYaZ9HIFXqjbn9kAaASuQl6uCuXVUyZL/Q=;
        b=wWVrnX1Kj1E4f3X7LoSrX2gjdeQTy0cqPmEcylvlbDEY/kst88rUURjL9YCh6jBaHO
         L3Ye1HaD+4nELLLabUEVMrL/3b4eR1eiKNjrli73332l10M0TjBbceDTpi9L+awdbVLj
         4h+c0Yt0iAPbb63qwJpXgXQc5ZDWr8o9iV3e3ZT960gY/bvjS4JjNyCl2j3JT5pIvOGQ
         sPMV4//zNYCU4YqMmmfvIKY8quJr1XWSQhk3MEnM+BGo/zatwhnoDX4AUOer1h76YxiG
         nRmXQBym+26TJSb8h3qJKs4eGeuBIH3rXcF+jN+VM85Mvn9QY5voIw6kr6t8YOKAQwvV
         EeAw==
X-Forwarded-Encrypted: i=1; AJvYcCWepVPmbInmYv+jj4624vgRQC+AmsNz4LYsF2j479yCRn2u6ehRfkAgtVPuRpylxEVa0bea1dbmDncZAmDjS96p@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2KQHK61hwR8JWa73JCMWdYWKvu9d3C6+DiU4ZaWXDummRn1E
	gAIUGs3PqgIRakrryYtvsez2QHBC0gakqWEbCyuTXVrLS5uhBUzg5MMTrrCOVhpV3DDP4JmlgWv
	nGiDtew==
X-Google-Smtp-Source: AGHT+IE9JQSaSNT9+T67Fkw2cDbYozJxAUfJ3kBmZZqgEDU9Xl9sBP5tq+Bq6erIy5pJoy1fkGy1uDx6xAaq
X-Received: from plry12.prod.google.com ([2002:a17:902:b48c:b0:223:4788:2e83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d586:b0:224:93e:b5d7
 with SMTP id d9443c01a7336-22977e0fba2mr1340135ad.34.1743624977770; Wed, 02
 Apr 2025 13:16:17 -0700 (PDT)
Date: Wed,  2 Apr 2025 13:15:46 -0700
In-Reply-To: <20250402201549.4090305-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402201549.4090305-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250402201549.4090305-3-irogers@google.com>
Subject: [PATCH v3 2/5] perf stat: Remove print_mixed_hw_group_error
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

print_mixed_hw_group_error will print a warning when a group of events
uses different PMUs. This isn't possible to happen as
parse_events__sort_events_and_fix_groups will break groups when this
happens, adding the warning at the start of perf of:

  WARNING: events were regrouped to match PMUs

As the previous mixed group warning can never happen, remove the
associated code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 31 -------------------------------
 tools/perf/util/stat.h         |  1 -
 2 files changed, 32 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1115efb380fb..aab3697aed63 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -798,30 +798,6 @@ static void abs_printout(struct perf_stat_config *config,
 	print_cgroup(config, os, evsel->cgrp);
 }
 
-static bool is_mixed_hw_group(struct evsel *counter)
-{
-	struct evlist *evlist = counter->evlist;
-	u32 pmu_type = counter->core.attr.type;
-	struct evsel *pos;
-
-	if (counter->core.nr_members < 2)
-		return false;
-
-	evlist__for_each_entry(evlist, pos) {
-		/* software events can be part of any hardware group */
-		if (pos->core.attr.type == PERF_TYPE_SOFTWARE)
-			continue;
-		if (pmu_type == PERF_TYPE_SOFTWARE) {
-			pmu_type = pos->core.attr.type;
-			continue;
-		}
-		if (pmu_type != pos->core.attr.type)
-			return true;
-	}
-
-	return false;
-}
-
 static bool evlist__has_hybrid_pmus(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -886,8 +862,6 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		if (counter->supported) {
 			if (!evlist__has_hybrid_pmus(counter->evlist)) {
 				config->print_free_counters_hint = 1;
-				if (is_mixed_hw_group(counter))
-					config->print_mixed_hw_group_error = 1;
 			}
 		}
 	}
@@ -1587,11 +1561,6 @@ static void print_footer(struct perf_stat_config *config)
 "	echo 0 > /proc/sys/kernel/nmi_watchdog\n"
 "	perf stat ...\n"
 "	echo 1 > /proc/sys/kernel/nmi_watchdog\n");
-
-	if (config->print_mixed_hw_group_error)
-		fprintf(output,
-			"The events in group usually have to be from "
-			"the same PMU. Try reorganizing the group.\n");
 }
 
 static void print_percore(struct perf_stat_config *config,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2fda9acd7374..1bcd7634bf47 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -100,7 +100,6 @@ struct perf_stat_config {
 	int			 times;
 	int			 run_count;
 	int			 print_free_counters_hint;
-	int			 print_mixed_hw_group_error;
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
 	struct rusage		 ru_data;
-- 
2.49.0.504.g3bcea36a83-goog

