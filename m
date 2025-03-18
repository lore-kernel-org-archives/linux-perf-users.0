Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD981A2658
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 04:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271295; cv=none; b=lcP0RNJof0il3BuBeQqMQWYof8wfN3qyAv5/BqA+o2vLwLOQR0Q/nRrCUZ1PCRgYVyT4Vfm+ucwSVldzkLZiC/8a+wVDoK+fNQeIC9JDaA0nCd1H/5Z8575ri0e54J1qVRexwtpLYcl0ZQU08K265Oz05helWGYcVvp+6q7ytBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271295; c=relaxed/simple;
	bh=1ifexhJwUBdmaJDGG25z0IZv2DVc0saV1QH/eEcKA84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aU4UPh89UE2NFEfvXMClEmiK+ii8Kh0KP8R4Kj2yq/lNz2uvKHhLvTN+I9gUrpgjAdtqeGMs86FFfu9DlbQAbRNLvNNBLj2uUWwuKMstAibM+zzITfDWu/ch+zayu/ofx52B0lmbtcaV7/TBaYxW9amAwbnq4zijhvb9tI3Dp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4JR+e9V/; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4JR+e9V/"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2a8e3905c56so1890541fac.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742271293; x=1742876093; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZBuQKhM+u9c6pepP6gqKhQVXCUikQqb1UN6fdxC8pQ=;
        b=4JR+e9V/qRzkfnJ4Y+QPNMkwOW1fYuFejr9KA6DQeZY4LCrMLKhOaq/V2LW6Op31CV
         B6im6/SaCdRdw311hbnkxYchEAXvR1a3QFkeVdJED4RspaMCAV4BCx2RY6sJdP86lI43
         jrV5t4QXRHCd5UchmWBJDMRuvKKoowyLGCy2Q0uNw0y9vp6fhXgYIfHxzRr7PtJ/um3s
         Xkld9lsd0tuPUC2voV4Dg+L4b6k7B9qa7N6AX665vU1QCm6+3PGrpbNv7429Pm9KkZdJ
         Mf1S0oYZR2Z4RSbMOHj1/apaTKHz1XeiPLwjFU8VQiIZtcyyRjQjNj3JmU7EFUnsioH6
         tHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271293; x=1742876093;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZBuQKhM+u9c6pepP6gqKhQVXCUikQqb1UN6fdxC8pQ=;
        b=I+x6SOKKIMUveq6cCmhk28ohQ0Fez72TotRYxbiCO5zVxkTSR/OXZV+aHvZO8XaMLg
         +HE3Oh7nRjV04ATEV3dNZTOOHkVVv6fkt4+iITLHLQ4OQ1OLbk7GQY6azui+ehPKwn57
         lJRxUpnjFfuGg4Z2SF9HzJWD1yMtOpodyUCMTU2nMY76faghJVFfNCqeCIondMQEZsDG
         jN3FPD3CVclXQZhxZGcRF1BYNuXEgHx7zI2dnfeb0e2kQxPfkRkgkSPBJa0Rp7XdYKbb
         5Jt/Cs174rEIA2hgZnKmpZrVJS8kxXnqzxlJNAaITFT1r0Sfzrui6HryPv5rOqP1j0a5
         SAIg==
X-Forwarded-Encrypted: i=1; AJvYcCXEDsfbO14P9mB2wiP1NYT2EpJn1SOuFiWKxbakkky6L1LA5+nLn9rwUi2+vT6kjWbYkmqN/zBCqxsDIQrCet1w@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2ZgdiT+chp9bRcH1XFciY0K+Hc4qnpzgD2sX9yv9XrcuwTnw
	WU8IpL4+gq3zPdPwPYKvhCWr9UNbBuWL9jBAPiZwDuBXv7IoQ85IZhq/IJn6ae0FAGDqYOlwDjC
	IF5su/w==
X-Google-Smtp-Source: AGHT+IHGwEtX1e44VeoF08hASz/dr/doRnth0R2Nh6U3dXLSsvJEuOjhpPAqND3KAFY16udrSphrHf+yI2dL
X-Received: from oabsf10.prod.google.com ([2002:a05:6871:230a:b0:2bc:6ad3:5671])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:468d:b0:29e:80d8:31a9
 with SMTP id 586e51a60fabf-2c719f157d9mr1055815fac.2.1742271292698; Mon, 17
 Mar 2025 21:14:52 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:14:39 -0700
In-Reply-To: <20250318041442.321230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318041442.321230-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf stat: Remove print_mixed_hw_group_error
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
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
index f311f1960e29..1751a450f449 100644
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
 static bool evlist__has_hybrid(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -886,8 +862,6 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		if (counter->supported) {
 			if (!evlist__has_hybrid(counter->evlist)) {
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
2.49.0.rc1.451.g8f38331e32-goog

