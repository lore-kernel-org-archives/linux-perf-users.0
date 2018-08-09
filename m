From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/44] perf map: Synthesize maps only for thread group leader
Date: Thu,  9 Aug 2018 11:58:21 -0300
Message-ID: <20180809145822.21391-44-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Threads share map_groups, all map events are merged into it.

Thus we could send mmaps only for thread group leader.  Otherwise it
took ages to attach and record something from processes with many vmas
and threads.

Thread group leader could be already dead, but it seems perf cannot
handle this case anyway.

Testing dummy:

  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/mman.h>
  #include <pthread.h>
  #include <unistd.h>

  void *thread(void *arg) {
          pause();
  }

  int main(int argc, char **argv) {
        int threads = 10000;
        int vmas = 50000;
        pthread_t th;
        for (int i = 0; i < threads; i++)
                pthread_create(&th, NULL, thread, NULL);
        for (int i = 0; i < vmas; i++)
                mmap(NULL, 4096, (i & 1) ? PROT_READ : PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
        sleep(60);
        return 0;
  }

Comment by Jiri Olsa:

We actualy synthesize the group leader (if we found one) for the thread
even if it's not present in the thread_map, so the process maps are
always in data.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/153363294102.396323.6277944760215058174.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0c8ecf0c78a4..0cd42150f712 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -541,10 +541,17 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 						      tgid, process, machine) < 0)
 			return -1;
 
+		/*
+		 * send mmap only for thread group leader
+		 * see thread__init_map_groups
+		 */
+		if (pid == tgid &&
+		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
+						       process, machine, mmap_data,
+						       proc_map_timeout))
+			return -1;
 
-		return perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
-							  process, machine, mmap_data,
-							  proc_map_timeout);
+		return 0;
 	}
 
 	if (machine__is_default_guest(machine))
-- 
2.14.4
