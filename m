From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/40] perf cgroup: Fix refcount usage
Date: Wed, 26 Jul 2017 11:17:14 -0300
Message-ID: <20170726141730.30750-25-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, Kees Kook <keescook@chromium.org>, Krister Johansen <kjlx@templeofstupid.com>, Paul Turner <pjt@google.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>

When converting from atomic_t to refcount_t we didn't follow the usual
step of initializing it to one before taking any new reference, which
trips over checking if taking a reference for a freed refcount_t, fix
it.

Brendan's report:

 ---
It's 4.12-rc7, with node v4.4.1. I'm building 4.13-rc1 now, as I hit
what I think is another unrelated perf bug and I'm starting to wonder
what else is broken on that version:

(root) /mnt/src/linux-4.12-rc7/tools/perf # ./perf record -F 99 -a -e
cpu-clock --cgroup=docker/f9e9d5df065b14646e8a11edc837a13877fd90c171137b2ba3feb67a0201cb65
-g
perf: /mnt/src/linux-4.12-rc7/tools/include/linux/refcount.h:108:
refcount_inc: Assertion `!(!refcount_inc_not_zero(r))' failed.
Aborted

that used to work...
 ---

Testing it:

Before:

  # perf stat -e cycles -C 0 --cgroup /
  perf: /home/acme/git/linux/tools/include/linux/refcount.h:108: refcount_inc: Assertion `!(!refcount_inc_not_zero(r))' failed.
  Aborted (core dumped)
  #

After:

  # perf stat -e cycles -C 0 --cgroup /
^C
  Performance counter stats for 'CPU(s) 0':

       132,081,393      cycles                    /

       2.492942763 seconds time elapsed

  #

Reported-by: Brendan Gregg <brendan.d.gregg@gmail.com>
Acked-by: Elena Reshetova <elena.reshetova@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Kees Kook <keescook@chromium.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 79c5fe6db8c7 ("perf cgroup: Convert cgroup_sel.refcnt from atomic_t to refcount_t")
Link: http://lkml.kernel.org/n/tip-l7ovfblq14ip2i08m1g0fkhv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 03347748f3fa..0e77bc9e5f3c 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -98,8 +98,10 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 		cgrp = counter->cgrp;
 		if (!cgrp)
 			continue;
-		if (!strcmp(cgrp->name, str))
+		if (!strcmp(cgrp->name, str)) {
+			refcount_inc(&cgrp->refcnt);
 			break;
+		}
 
 		cgrp = NULL;
 	}
@@ -110,6 +112,7 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 			return -1;
 
 		cgrp->name = str;
+		refcount_set(&cgrp->refcnt, 1);
 
 		cgrp->fd = open_cgroup(str);
 		if (cgrp->fd == -1) {
@@ -128,12 +131,11 @@ static int add_cgroup(struct perf_evlist *evlist, char *str)
 			goto found;
 		n++;
 	}
-	if (refcount_read(&cgrp->refcnt) == 0)
+	if (refcount_dec_and_test(&cgrp->refcnt))
 		free(cgrp);
 
 	return -1;
 found:
-	refcount_inc(&cgrp->refcnt);
 	counter->cgrp = cgrp;
 	return 0;
 }
-- 
2.9.4
