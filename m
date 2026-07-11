Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1C625;
	Sat, 11 Jul 2026 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728261; cv=none; b=JKv3NFhR+aPIL3td8gEs7UYZQLX8LFPLAa+QDtHu+mh2qklFtbZlXur+a7Q7em3I2VB6Xt12GxgiVO2WL76bi7kTcUdePUHK8dvk2G48lHN7OvU48AMm5Ygj7rb6SJqYnGUEjb2VDvaw4zWI/l8BkhxDC9t6KXZly47AgKmdqp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728261; c=relaxed/simple;
	bh=Zt1B6VPovhfVpyX9UR5NUHnE8Zvo81vAsDCnUOP2zCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzY6KC/WzhFHmLQK915v8oIp/Xcp7zL4azf8rEtxodjd9IPP06iVKENUHD1N09kQVe7aq0rFKv2uAatBJbS3vkHYizCZYYPnYAPAySY0pZMTAo0Stt+OFvJInKiV/PjSZILQVpuwx5YFnJS+0fJX6R9GrBU4NeJ4r4oR1bXMblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp450Uyp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp450Uyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48641F000E9;
	Sat, 11 Jul 2026 00:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783728260;
	bh=SCZvCCsl0w6sqrYLip6wnTNjQbhXuaUOrlcJCvHIG+E=;
	h=From:To:Cc:Subject:Date;
	b=cp450UypPSi2Hk6ra0m9SWOzeUORauprRlwlUKaA57iSGk1N8b29CmVp03MZuRT9m
	 6k7YDhsPQfj2cF6PKPDldwJTvgj3FRL/ikYm5IEV/qdtXBQgXJ7x8oM+BvVzRizjGG
	 qlbdlruDEUEwWkCGnDvsGT/tlbO+cDDtfHrOwP3xCNOLn5V48ITGpQO2bVpwlach4V
	 i3kT0oh0aR0KPqUnAExEr6z0FKgucoVYiu46R61o68aruiI36myHjDfUFw8ixlufQy
	 cdyXQs4LQOVjsyxwrPlHc6Z/DIhVK6dHwqdXYOM0821p37qOELXouSF64SWyMiWtjO
	 +tYeY2YaOg8aA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 1/4] perf stat: Fix duplicate output with --for-each-cgroup
Date: Fri, 10 Jul 2026 17:04:16 -0700
Message-ID: <20260711000419.1949161-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently it produces following output with duplicate events when
 --for-each-cgroup option is used.  It seems perf stat adds them when
it handles default events but didn't copy some fields in evsel__clone().

  $ sudo perf stat -a --for-each-cgroup / true

   Performance counter stats for 'system wide':

           8,440,165      duration_time                    /
           8,439,895      duration_time                    /
           8,440,015      duration_time                    /
           8,440,024      duration_time                    /
           8,440,075      duration_time                    /
           8,440,095      duration_time                    /
                 330      context-switches                 /             #    679.4 cs/sec  cs_per_second
              485.69 msec cpu-clock                        /             #     57.5 CPUs  CPUs_utilized
                  70      cpu-migrations                   /             #    144.1 migrations/sec  migrations_per_second
                  71      page-faults                      /             #    146.2 faults/sec  page_faults_per_second
          12,183,711      branch-misses                    /             #     10.9 %  branch_miss_rate         (5.15%)
         111,981,297      branches                         /                                                       (5.15%)
          95,844,809      branches                         /             #    197.3 M/sec  branch_frequency     (35.49%)
          65,611,429      cpu-cycles                       /             #      0.1 GHz  cycles_frequency       (98.32%)
          24,170,987      cpu-cycles                       /                                                       (95.12%)
          18,552,509      instructions                     /             #      0.8 instructions  insn_per_cycle  (95.12%)
          22,405,293      cpu-cycles                       /                                                       (64.78%)
           6,840,383      stalled-cycles-frontend          /             #     0.31 frontend_cycles_idle        (64.78%)
       <not counted>      cpu-cycles                       /
     <not supported>      stalled-cycles-backend           /             #      nan backend_cycles_idle
     <not supported>      stalled-cycles-backend           /             #      nan stalled_cycles_per_instruction
     <not supported>      instructions                     /
     <not supported>      stalled-cycles-frontend          /

         0.006546057 seconds time elapsed

  Some events weren't counted. Try disabling the NMI watchdog:
  	echo 0 > /proc/sys/kernel/nmi_watchdog
  	perf stat ...
  	echo 1 > /proc/sys/kernel/nmi_watchdog

But I'm worrying about opening same events multiple times.  Probably due
to grouping, but I'm not sure if it's beneficial in the end.  Without
duplication, it seems it won't cause multiplexing (assuming no other
users at the same time).

Fixes: a3248b5b5427d ("perf jevents: Add metric DefaultShowEvents")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2 changes)
 * add missing bpf_counter and retire_lat fields  (Sashiko)

 tools/perf/util/evsel.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d0484e4ee679e635..82399a3eb96e3ce7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -617,7 +617,13 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->sample_read = orig->sample_read;
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
+	evsel->bpf_counter = orig->bpf_counter;
 	evsel->use_config_name = orig->use_config_name;
+	evsel->skippable = orig->skippable;
+	evsel->dont_regroup = orig->dont_regroup;
+	evsel->default_metricgroup = orig->default_metricgroup;
+	evsel->default_show_events = orig->default_show_events;
+
 	evsel->pmu = orig->pmu;
 	evsel->first_wildcard_match = orig->first_wildcard_match;
 
@@ -626,6 +632,10 @@ struct evsel *evsel__clone(struct evsel *orig)
 
 	evsel->alternate_hw_config = orig->alternate_hw_config;
 
+	evsel->retire_lat = orig->retire_lat;
+	if (evsel->retire_lat)
+		evsel->retirement_latency = orig->retirement_latency;
+
 	return evsel;
 
 out_err:
-- 
2.55.0.795.g602f6c329a-goog

