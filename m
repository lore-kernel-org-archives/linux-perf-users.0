From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/41] perf stat: Fall weak group back even for EBADF
Date: Tue, 12 Sep 2017 12:10:18 -0300
Message-ID: <20170912151029.6612-31-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

It's not possible to run a package event and a per cpu event in the same
group. This is used by some of the power metrics.  They work correctly
when not using a group.

Normally weak groups should handle that, but in this case EBADF is
returned instead of the normal EINVAL.

  $ strace -e perf_event_open ./perf stat -v -e '{cstate_pkg/c2-residency/,msr/tsc/}:W' -a sleep 1
  Using CPUID GenuineIntel-6-3E
  perf_event_open({type=0x17 /* PERF_TYPE_??? */, size=PERF_ATTR_SIZE_VER5, config=0, ...}, -1, 0, -1, PERF_FLAG_FD_CLOEXEC) = -1 EINVAL (Invalid argument)
  perf_event_open({type=0x17 /* PERF_TYPE_??? */, size=PERF_ATTR_SIZE_VER5, config=0, ...}, -1, 0, -1, 0) = -1 EINVAL (Invalid argument)
  perf_event_open({type=0x17 /* PERF_TYPE_??? */, size=PERF_ATTR_SIZE_VER5, config=0, ...}, -1, 0, -1, 0) = -1 EINVAL (Invalid argument)
  perf_event_open({type=0x17 /* PERF_TYPE_??? */, size=PERF_ATTR_SIZE_VER5, config=0, ...}, -1, 0, -1, 0) = -1 EINVAL (Invalid argument)
  perf_event_open({type=0x17 /* PERF_TYPE_??? */, size=PERF_ATTR_SIZE_VER5, config=0, ...}, -1, 0, -1, 0) = 3
  perf_event_open({type=0x7 /* PERF_TYPE_??? */, size=PERF_ATTR_SIZE_VER5, config=0, ...}, -1, 0, 3, 0) = 4
  perf_event_open({type=0x7 /* PERF_TYPE_??? */, size=PERF_ATTR_SIZE_VER5, config=0, ...}, -1, 1, 0, 0) = -1 EBADF (Bad file descriptor)

and perf errors out.

Make weak groups trigger a fall back for EBADF too. Then this case works correctly:

  $ perf stat -v -e '{cstate_pkg/c2-residency/,msr/tsc/}:W' -a sleep 1
  Using CPUID GenuineIntel-6-3E
  Weak group for cstate_pkg/c2-residency//2 failed
  cstate_pkg/c2-residency/: 476709882 1000598460 1000598460
  msr/tsc/: 39625837911 12007369110 12007369110

   Performance counter stats for 'system wide':

         476,709,882      cstate_pkg/c2-residency/
      39,625,837,911      msr/tsc/

         1.000697588 seconds time elapsed

  This fixes perf stat -M Power ...

  $ perf stat -M Power --metric-only -a sleep 1

   Performance counter stats for 'system wide':

  Turbo_Utilization  C3_Core_Residency  C6_Core_Residency C7_Core_Residency  C2_Pkg_Residency   C3_Pkg_Residency  C6_Pkg_Residency  C7_Pkg_Residency
       1.0                 0.7                30.0               0.0               0.9                 0.1               0.4                 0.0

         1.001240740 seconds time elapsed

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170905211324.32427-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2248ebe582ca..9af46e316e77 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -656,7 +656,7 @@ static int __run_perf_stat(int argc, const char **argv)
 		if (create_perf_stat_counter(counter) < 0) {
 
 			/* Weak group failed. Reset the group. */
-			if (errno == EINVAL &&
+			if ((errno == EINVAL || errno == EBADF) &&
 			    counter->leader != counter &&
 			    counter->weak_group) {
 				counter = perf_evsel__reset_weak_group(counter);
-- 
2.13.5
