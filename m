Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F082157E99
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318362; cv=none; b=WJ18JGNNFwzNNcOo+tr9NszNS1AueZ0/q7Y0pqaFO6X1UORsW2YBBGAu61+ylLSCsWH6ICY7MADiVT4abWw7I6SJhzbvUrejWEcAewCMwFuixpdbDZjCbtXUjNtfLXacyrWcV6MZk2oDDiUy//ZQzwK3Rd1iFXQ2VKKiHijKaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318362; c=relaxed/simple;
	bh=L4LywadbE5mYY8mu02wFC7XHQywI/d157uAGv7GqMZY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fSDD24COYG4AwVPHEyu17tOwcAFVV9xGW+FDQVpnDmNIjfUG6zPmczmQFCovo3Ly7PFnnnpRnc2ShrQINaWfjRUE8LTElBc7dGgXcTNePos37ucjjJBQ61qiXpRoNlWzXjRP7txHOOfCouz65T1aq3FkZLveHTwHx2ZlM0ckjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLx8crY8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLx8crY8"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fd010df0f4so92854387b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742318359; x=1742923159; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KvYyFj2nG1/TQMfnz/J5XJ8/WMEVshs5kPWwTWXCuSU=;
        b=iLx8crY80/EeWtU0OF58dHtcv+nz2t7U67jm0hRqWErAIVO1B50Ad0yhaWRKDck6UW
         PqUWy4OKHR5YQpBuFz/gEGvcMHWzj0t0SxCBSvEDZr6J/wh8Pck4awl+oX55F727OXCS
         lZo2A3cz0MGhKqGxqqPOnBVNHbBrr7iCFqlPRZ0rfA/YR3sMot86Vv3YJ1xpUhoKnQWZ
         wu80PhTUCbFENKVw5E5Mqd6WA9xG5cJVpVrt3vLsJw5DYGmPRxF6YipIYgtZ2XeEjrUD
         cjfBK/yj0cvCe/TBL2SSy7YLBNexoVjLIevWIrnqIujZPSZfelDos+9Vtx0aHTgoMR0h
         oQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742318359; x=1742923159;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KvYyFj2nG1/TQMfnz/J5XJ8/WMEVshs5kPWwTWXCuSU=;
        b=Wtmb9aV21MoBMot6uYQztB4v7Z4eE2fxYNKVHOOYIPCIjcENPF0njMeGyF5KSfiF37
         QE3Ujw/NdrENu/8riJUC2sC1R4Q534npkrP7NHx1wfFz5ZWOBpJDK+FVNbRttk1Z/7ZC
         vGb3t8eg5Zhnug+znzoWPuw46R1j6AwWvzzr8Z96FAT7/NwtFvkq34n92OKUTN8HcKmI
         Cu5fFlwXaxiGmEF8tfmvQXkj0CeHWz83txCN/8pbQUZ5LjOx3mUyti8FoL0+SbCm/bgq
         ZhpomH3SuNHeMymNL5Hdp5kGmaYHVN6SNjeZZHfOX3p4EcJVkc9znMV6QVOO8kyvN7g8
         L/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWaabP6JFP6Ykgfq2fITHYpSMjU1Doyd+cZoLKB+uzm9aG1pWOrgndycaaHKIIHRP8/5x+KKQhmer/iToUnMmpj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FtNotVA3Wm6S7UWb2srkKwoBLrOKwuSFXcV9q45Nt0tk4NgX
	kkx8IvouZNkRSUcRfqnhcXQDqUs3byTJJL7Mvu6X02xM35wYgGEx93IoRg6jFiMHHzbEUkVCP6h
	X0k8i0g==
X-Google-Smtp-Source: AGHT+IFPSXtbSEWitohgO7VMQCfcTTqptJqeHL+kp6kVB+7zkOLZaeS6VlTaqfbk3dWQLiZNfbrkJc6CPvLj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:d801:0:b0:e60:89be:c33a with SMTP id
 3f1490d57ef6-e63f5bdea0cmr8923276.0.1742318359222; Tue, 18 Mar 2025 10:19:19
 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:19:14 -0700
Message-Id: <20250318171914.145616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v1] perf cpumap: Increment reference count for online cpumap
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thomas Richter <tmricht@linux.ibm.com> reported a double put on the
cpumap for the placeholder core PMU:
https://lore.kernel.org/lkml/20250318095132.1502654-3-tmricht@linux.ibm.com/
Requiring the caller to get the cpumap is not how these things are
usually done, switch cpu_map__online to do the get and then fix up any
use cases where a put is needed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c | 5 +++--
 tools/perf/util/cpumap.c       | 2 +-
 tools/perf/util/evlist.c       | 5 +++--
 tools/perf/util/mem-events.c   | 5 ++++-
 tools/perf/util/mmap.c         | 4 ++--
 tools/perf/util/pmu.c          | 2 +-
 tools/perf/util/tool_pmu.c     | 1 +
 7 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 57dc94a6e38c..f70075c89aa0 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -18,7 +18,7 @@
 
 void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
-	struct perf_cpu_map *intersect;
+	struct perf_cpu_map *intersect, *online = cpu_map__online();
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
@@ -41,7 +41,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 	}
 #endif
 	/* Workaround some ARM PMU's failing to correctly set CPU maps for online processors. */
-	intersect = perf_cpu_map__intersect(cpu_map__online(), pmu->cpus);
+	intersect = perf_cpu_map__intersect(online, pmu->cpus);
+	perf_cpu_map__put(online);
 	perf_cpu_map__put(pmu->cpus);
 	pmu->cpus = intersect;
 }
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 9bc5e0370234..89570397a4b3 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -722,7 +722,7 @@ struct perf_cpu_map *cpu_map__online(void) /* thread unsafe */
 	if (!online)
 		online = perf_cpu_map__new_online_cpus(); /* from /sys/devices/system/cpu/online */
 
-	return online;
+	return perf_cpu_map__get(online);
 }
 
 bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 49e10d6981ad..c1a04141aed0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2534,10 +2534,10 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 		return;
 
 	evlist__for_each_entry(evlist, pos) {
-		struct perf_cpu_map *intersect, *to_test;
+		struct perf_cpu_map *intersect, *to_test, *online = cpu_map__online();
 		const struct perf_pmu *pmu = evsel__find_pmu(pos);
 
-		to_test = pmu && pmu->is_core ? pmu->cpus : cpu_map__online();
+		to_test = pmu && pmu->is_core ? pmu->cpus : online;
 		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
 		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
 			char buf[128];
@@ -2547,6 +2547,7 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
 		}
 		perf_cpu_map__put(intersect);
+		perf_cpu_map__put(online);
 	}
 	perf_cpu_map__put(user_requested_cpus);
 }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 9011784b950d..884d9aebce91 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -303,12 +303,15 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr, char **eve
 	}
 
 	if (cpu_map) {
-		if (!perf_cpu_map__equal(cpu_map, cpu_map__online())) {
+		struct perf_cpu_map *online = cpu_map__online();
+
+		if (!perf_cpu_map__equal(cpu_map, online)) {
 			char buf[200];
 
 			cpu_map__snprint(cpu_map, buf, sizeof(buf));
 			pr_warning("Memory events are enabled on a subset of CPUs: %s\n", buf);
 		}
+		perf_cpu_map__put(online);
 		perf_cpu_map__put(cpu_map);
 	}
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a7ef4d8d57d8..a34726219af3 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -244,9 +244,8 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 {
 	int idx, nr_cpus;
 	struct perf_cpu cpu;
-	const struct perf_cpu_map *cpu_map = NULL;
+	struct perf_cpu_map *cpu_map = cpu_map__online();
 
-	cpu_map = cpu_map__online();
 	if (!cpu_map)
 		return;
 
@@ -256,6 +255,7 @@ static void build_node_mask(int node, struct mmap_cpu_mask *mask)
 		if (cpu__get_node(cpu) == node)
 			__set_bit(cpu.cpu, mask->bits);
 	}
+	perf_cpu_map__put(cpu_map);
 }
 
 static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 57450c73fb63..b7ebac5ab1d1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -779,7 +779,7 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *pmu_name, bool is
 	}
 
 	/* Nothing found, for core PMUs assume this means all CPUs. */
-	return is_core ? perf_cpu_map__get(cpu_map__online()) : NULL;
+	return is_core ? cpu_map__online() : NULL;
 }
 
 static bool pmu_is_uncore(int dirfd, const char *name)
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 9156745ea180..b60ac390d52d 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -355,6 +355,7 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
 
 		if (online) {
 			*result = perf_cpu_map__nr(online);
+			perf_cpu_map__put(online);
 			return true;
 		}
 		return false;
-- 
2.49.0.rc1.451.g8f38331e32-goog

