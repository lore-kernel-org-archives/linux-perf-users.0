From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 62/66] perf evlist: Fix access of freed id arrays
Date: Wed, 25 Sep 2019 21:32:40 -0300
Message-ID: <20190926003244.13962-63-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

I'm not fully sure if this is the correct fix, but without this I get
crashes on more complex perf stat metric usages. The problem is that
part of the state gets freed when a weak group fails, but then is later
still used. Just don't free the ids, we're going to reuse them anyways
on the weak group retry.

For example:

  % perf stat -M IpB,IpCall,IpTB,IPC,Retiring_SMT,Frontend_Bound_SMT,Kernel_Utilization,CPU_Utilization --metric-only -a -I 1000 sleep 2

  crashes and gives in valgrind:

  =21527== Invalid write of size 8
  ==21527==    at 0x4EE582: hlist_add_head (list.h:644)
  ==21527==    by 0x4EFD3C: perf_evlist__id_hash (evlist.c:477)
  ==21527==    by 0x4EFD99: perf_evlist__id_add (evlist.c:483)
  ==21527==    by 0x4EFF15: perf_evlist__id_add_fd (evlist.c:524)
  ==21527==    by 0x4FC693: store_evsel_ids (evsel.c:2969)
  ==21527==    by 0x4FC76C: perf_evsel__store_ids (evsel.c:2986)
  ==21527==    by 0x450DA7: __run_perf_stat (builtin-stat.c:519)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)
  ==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
  ==21527==    by 0x4D5931: run_argv (perf.c:406)
  ==21527==  Address 0x12e3f008 is 104 bytes inside a block of size 2,056 free'd
  ==21527==    at 0x4839A0C: free (vg_replace_malloc.c:540)
  ==21527==    by 0x627139: xyarray__delete (xyarray.c:32)
  ==21527==    by 0x4F6BE4: perf_evsel__free_id (evsel.c:1253)
  ==21527==    by 0x4FA11F: evsel__close (evsel.c:1994)
  ==21527==    by 0x4F30A3: perf_evlist__reset_weak_group (evlist.c:1783)
  ==21527==    by 0x450B47: __run_perf_stat (builtin-stat.c:466)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)
  ==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
  ==21527==    by 0x4D5931: run_argv (perf.c:406)
  ==21527==    by 0x4D5CAE: main (perf.c:531)
  ==21527==  Block was alloc'd at
  ==21527==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
  ==21527==    by 0x627024: zalloc (zalloc.c:8)
  ==21527==    by 0x627088: xyarray__new (xyarray.c:10)
  ==21527==    by 0x4F6B20: perf_evsel__alloc_id (evsel.c:1237)
  ==21527==    by 0x4FC74E: perf_evsel__store_ids (evsel.c:2983)
  ==21527==    by 0x450DA7: __run_perf_stat (builtin-stat.c:519)
  ==21527==    by 0x451285: run_perf_stat (builtin-stat.c:636)
  ==21527==    by 0x454619: cmd_stat (builtin-stat.c:1966)
  ==21527==    by 0x4D557D: run_builtin (perf.c:310)
  ==21527==    by 0x4D57EA: handle_internal_command (perf.c:362)
  ==21527==    by 0x4D5931: run_argv (perf.c:406)
  ==21527==    by 0x4D5CAE: main (perf.c:531)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lore.kernel.org/lkml/20190923233339.25326-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 84c42790dab3..d277a98e62df 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1659,7 +1659,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 			is_open = false;
 		if (c2->leader == leader) {
 			if (is_open)
-				evsel__close(c2);
+				perf_evsel__close(&evsel->core);
 			c2->leader = c2;
 			c2->core.nr_members = 0;
 		}
-- 
2.21.0
