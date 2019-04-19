From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 6/7] perf tools: Fix map reference counting
Date: Fri, 19 Apr 2019 09:30:28 -0300
Message-ID: <20190419123029.11328-7-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric Saint-Etienne <eric.saint.etienne@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

By calling maps__insert() we assume to get 2 references on the map,
which we relese within maps__remove call.

However if there's already same map name, we currently don't bump the
reference and can crash, like:

  Program received signal SIGABRT, Aborted.
  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6

  (gdb) bt
  #0  0x00007ffff75e60f5 in raise () from /lib64/libc.so.6
  #1  0x00007ffff75d0895 in abort () from /lib64/libc.so.6
  #2  0x00007ffff75d0769 in __assert_fail_base.cold () from /lib64/libc.so.6
  #3  0x00007ffff75de596 in __assert_fail () from /lib64/libc.so.6
  #4  0x00000000004fc006 in refcount_sub_and_test (i=1, r=0x1224e88) at tools/include/linux/refcount.h:131
  #5  refcount_dec_and_test (r=0x1224e88) at tools/include/linux/refcount.h:148
  #6  map__put (map=0x1224df0) at util/map.c:299
  #7  0x00000000004fdb95 in __maps__remove (map=0x1224df0, maps=0xb17d80) at util/map.c:953
  #8  maps__remove (maps=0xb17d80, map=0x1224df0) at util/map.c:959
  #9  0x00000000004f7d8a in map_groups__remove (map=<optimized out>, mg=<optimized out>) at util/map_groups.h:65
  #10 machine__process_ksymbol_unregister (sample=<optimized out>, event=0x7ffff7279670, machine=<optimized out>) at util/machine.c:728
  #11 machine__process_ksymbol (machine=<optimized out>, event=0x7ffff7279670, sample=<optimized out>) at util/machine.c:741
  #12 0x00000000004fffbb in perf_session__deliver_event (session=0xb11390, event=0x7ffff7279670, tool=0x7fffffffc7b0, file_offset=13936) at util/session.c:1362
  #13 0x00000000005039bb in do_flush (show_progress=false, oe=0xb17e80) at util/ordered-events.c:243
  #14 __ordered_events__flush (oe=0xb17e80, how=OE_FLUSH__ROUND, timestamp=<optimized out>) at util/ordered-events.c:322
  #15 0x00000000005005e4 in perf_session__process_user_event (session=session@entry=0xb11390, event=event@entry=0x7ffff72a4af8,
  ...

Add the map to the list and getting the reference event if we find the
map with same name.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: 1e6285699b30 ("perf symbols: Fix slowness due to -ffunction-section")
Link: http://lkml.kernel.org/r/20190416160127.30203-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 28d484ef74ae..ee71efb9db62 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -926,10 +926,8 @@ static void __maps__insert_name(struct maps *maps, struct map *map)
 		rc = strcmp(m->dso->short_name, map->dso->short_name);
 		if (rc < 0)
 			p = &(*p)->rb_left;
-		else if (rc  > 0)
-			p = &(*p)->rb_right;
 		else
-			return;
+			p = &(*p)->rb_right;
 	}
 	rb_link_node(&map->rb_node_name, parent, p);
 	rb_insert_color(&map->rb_node_name, &maps->names);
-- 
2.20.1
