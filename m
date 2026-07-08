Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AE21CA02;
	Wed,  8 Jul 2026 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553466; cv=none; b=rsG87lbx+rYLP1rRXiT9lInplevsKhq0iOZCsR6op09nsSyVa5EygGhrh3pTjfayqhY9W79WNCxQVjfRvxqp+5yUYGl1NwYoJrmQgsDOwomJP2aF9n0+XYaoiR3Q+c2Wip8l17Y8BFEseUtSajFx7pBWHLw3v82LgdZK67db4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553466; c=relaxed/simple;
	bh=tBZZacDPJqJWjaVKBQ0YpT7JDhpbuo8FOZA6wilkrHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0Rrqof/GwCltMlg6QPHM0FYgIVApS4k33+/8afJ/uevZwdUNy3APOhT/WFz6YsHfP4v7kmaaYnF+8oVvRq1bqGX2qjSNMCtDmSSN04IZ0B0cSkVg32rNYWcE6lYfgeEuR4+Yy7FfMBQgrKyJ0RV8qRNoE1jJ2QgHSRWP36ASxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU0gvSwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU0gvSwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836A21F00A3A;
	Wed,  8 Jul 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553464;
	bh=vZQ5N4OBrTl0dNJ0Es2C1NPSUXJXAxYwYULRieuYpq0=;
	h=From:To:Cc:Subject:Date;
	b=QU0gvSwnpCQqvwu9kXbFkYh/FV2iYH+hsnfs3/H6ydhUAsxemry6eaUtnRNjcGktZ
	 IbrC4c9DlPE9VQosd5BDWlUgTNeHLgiBLwhQe5ldNTxX6H7ifaYQ7bdWzfPckuh/zF
	 RwwuTkwjFOOK96+jU9Izm2ZmaJpKxJXDVWCoDnJhepNlcvhM37ZI1HsuCCkVoLcB2M
	 Fq3A3AQ+3iVjjMRky4CgJdc1dwa3zgSkHXaayoeIuS98d9VQg4ADOhHzq+AGkr/vJr
	 itGIaocwUb+AleR9JFFeoJs14JLxccMCFt5SGEiG5cdvjSJJ3zlos7u2Hicoyol0TD
	 yMRUYmRifIsNQ==
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
Subject: [PATCH v1 1/2] perf stat: Fix duplicate output with --for-each-cgroup
Date: Wed,  8 Jul 2026 16:31:02 -0700
Message-ID: <20260708233103.1359713-1-namhyung@kernel.org>
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
 tools/perf/util/evsel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d0484e4ee679e635..fefa5c73a474ff87 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -612,12 +612,18 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->percore = orig->percore;
 	evsel->precise_max = orig->precise_max;
 	evsel->is_libpfm_event = orig->is_libpfm_event;
+	evsel->skippable = orig->skippable;
+	evsel->retire_lat = orig->retire_lat;
+	evsel->dont_regroup = orig->dont_regroup;
 
 	evsel->exclude_GH = orig->exclude_GH;
 	evsel->sample_read = orig->sample_read;
 	evsel->collect_stat = orig->collect_stat;
 	evsel->weak_group = orig->weak_group;
 	evsel->use_config_name = orig->use_config_name;
+	evsel->default_metricgroup = orig->default_metricgroup;
+	evsel->default_show_events = orig->default_show_events;
+
 	evsel->pmu = orig->pmu;
 	evsel->first_wildcard_match = orig->first_wildcard_match;
 
-- 
2.55.0.795.g602f6c329a-goog

