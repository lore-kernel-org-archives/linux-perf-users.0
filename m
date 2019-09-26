From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/66] perf tools: Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap()
Date: Wed, 25 Sep 2019 21:31:56 -0300
Message-ID: <20190926003244.13962-19-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evlist__alloc_mmap() to evlist__alloc_mmap(), so we don't
have a name clash when we add perf_evlist__alloc_mmap() to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 888472c7bf9c..5bde2e5bf0e3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -693,8 +693,8 @@ void evlist__munmap(struct evlist *evlist)
 	zfree(&evlist->overwrite_mmap);
 }
 
-static struct mmap *perf_evlist__alloc_mmap(struct evlist *evlist,
-						 bool overwrite)
+static struct mmap *evlist__alloc_mmap(struct evlist *evlist,
+				       bool overwrite)
 {
 	int i;
 	struct mmap *map;
@@ -752,7 +752,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			maps = evlist->overwrite_mmap;
 
 			if (!maps) {
-				maps = perf_evlist__alloc_mmap(evlist, true);
+				maps = evlist__alloc_mmap(evlist, true);
 				if (!maps)
 					return -1;
 				evlist->overwrite_mmap = maps;
@@ -1004,7 +1004,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 				  .comp_level = comp_level };
 
 	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
+		evlist->mmap = evlist__alloc_mmap(evlist, false);
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-- 
2.21.0
