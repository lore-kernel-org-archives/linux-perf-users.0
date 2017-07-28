From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/15] perf annotate: Fix storing per line sym_hist_entry
Date: Fri, 28 Jul 2017 17:00:13 -0300
Message-ID: <20170728200021.11389-8-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The existing loop incremented the offset while using it as the array
index, when we went to an array of sym_hist_entry instances, we
should've moved the increment to outside of the array element reference,
oops, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 461c17f00f40 ("perf annotate: Store the sample period in each histogram bucket")
Link: http://lkml.kernel.org/n/tip-s3dm6uyrazlpag3f0psfia07@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 5125c2bbacaa..2dab0e5a7f2f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -963,8 +963,9 @@ double disasm__calc_percent(struct annotation *notes, int evidx, s64 offset,
 		u64 period = 0;
 
 		while (offset < end) {
-			hits += h->addr[offset++].nr_samples;
-			period += h->addr[offset++].period;
+			hits   += h->addr[offset].nr_samples;
+			period += h->addr[offset].period;
+			++offset;
 		}
 
 		if (h->nr_samples) {
-- 
2.9.4
