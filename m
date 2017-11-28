From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/30] perf evlist: Set the correct idx when adding dummy events
Date: Tue, 28 Nov 2017 12:01:51 -0300
Message-ID: <20171128150220.5064-2-acme@kernel.org>
References: <20171128150220.5064-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128150220.5064-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Bram Stolk <b.stolk@gmail.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The evsel->idx field is used mainly to access the right bucket in
per-event arrays such as the annotation ones, but also to set
evsel->tracking, that in turn will decide what of the events will ask
for PERF_RECORD_{MMAP,COMM,EXEC} to be generated, i.e. which
perf_event_attr will have its mmap, etc fields set.

When we were adding the "dummy" event using perf_evlist__add_dummy() we
were not setting it correctly, which could result in multiple tracking
events.

Now that I'll try using a dummy event to be the tracking one when using
'perf record --delay', i.e. when we process the --delay
setting we may already have the evlist set up, like with:

  perf record -e cycles,instructions --delay 1000 ./workload

We will need to add a "dummy" event, then reset evsel->tracking for the
first event, "cycles", and set it instead to the dummy one, and also
setting its attr.enable_on_exec, so that we get the PERF_RECORD_MMAP,
etc metadata events while waiting to enable the explicitely requested
events, so lets get this straight and set the right evsel->idx.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Bram Stolk <b.stolk@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-nrdfchshqxf7diszhxcecqb9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c6c891e154a6..ccb749f9a83f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -257,7 +257,7 @@ int perf_evlist__add_dummy(struct perf_evlist *evlist)
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
-	struct perf_evsel *evsel = perf_evsel__new(&attr);
+	struct perf_evsel *evsel = perf_evsel__new_idx(&attr, evlist->nr_entries);
 
 	if (evsel == NULL)
 		return -ENOMEM;
-- 
2.13.6
