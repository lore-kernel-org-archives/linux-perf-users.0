From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/24] perf kmem: Perform some cleanup if '--time' is given an invalid value
Date: Mon, 23 Oct 2017 20:47:34 -0300
Message-ID: <20171023234736.5335-23-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, kernel-janitors@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If the string passed in '--time' is invalid, we must do some cleanup
before leaving. As in the other error handling paths of this function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Fixes: 2a865bd8dddd ("perf kmem: Add option to specify time window of interest")
Link: http://lkml.kernel.org/r/20170916060936.28199-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 24ee68ecdd42..d8f25ef8157b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1983,7 +1983,8 @@ int cmd_kmem(int argc, const char **argv)
 
 	if (perf_time__parse_str(&ptime, time_str) != 0) {
 		pr_err("Invalid time string\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_delete;
 	}
 
 	if (!strcmp(argv[0], "stat")) {
-- 
2.13.6
