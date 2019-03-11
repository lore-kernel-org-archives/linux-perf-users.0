From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH v1 02/10] perf, tools, stat: Avoid memory overrun with -r
Date: Mon, 11 Mar 2019 13:24:38 -0700
Message-ID: <20190311202446.10210-3-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When -r is used memory would get corrupted because the evsel->id array
would get overrun. evsel->ids is a running counter of the last id.
Normally this works fine, but with -r the same event is initialized
multiple times, but not this counter, so it would keep growing
beyond the array limit and corrupt random memory.

Always reinitialize ->ids, and also add an assert to catch
such overruns in the future.

This fixes a perf segfault when running it from toplev.

Before:

$ valgrind perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
==27012== Memcheck, a memory error detector
==27012== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==27012== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
==27012== Command: perf stat -r2 -e {cycles,cycles,cycles,cycles} true
==27012==
==27012== Invalid write of size 8
==27012==    at 0x33090F: perf_evlist__id_add_fd (in /usr/bin/perf)
==27012==    by 0x33C99B: perf_evsel__store_ids (in /usr/bin/perf)
==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
==27012==    by 0x29C7A9: main (in /usr/bin/perf)
==27012==  Address 0x13182be8 is 0 bytes after a block of size 8 alloc'd
==27012==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
==27012==    by 0x33C921: perf_evsel__store_ids (in /usr/bin/perf)
==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
==27012==    by 0x29C7A9: main (in /usr/bin/perf)
==27012==
...

After:

$ valgrind ./perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
==27026== Memcheck, a memory error detector
==27026== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
==27026== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
==27026== Command: ./perf stat -r2 -e {cycles,cycles,cycles,cycles} true
==27026==

 Performance counter stats for 'true' (2 runs):

...

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/evlist.c | 1 +
 tools/perf/util/evsel.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ed20f4379956..4f02bccba204 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -529,6 +529,7 @@ void perf_evlist__id_add(struct perf_evlist *evlist, struct perf_evsel *evsel,
 			 int cpu, int thread, u64 id)
 {
 	perf_evlist__id_hash(evlist, evsel, cpu, thread, id);
+	assert(evsel->ids < evsel->sample_id->max_x * evsel->sample_id->max_y);
 	evsel->id[evsel->ids++] = id;
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e979c0..686318f69b1d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3001,5 +3001,7 @@ int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
 	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
 		return -ENOMEM;
 
+	evsel->ids = 0;
+
 	return store_evsel_ids(evsel, evlist);
 }
-- 
2.20.1
