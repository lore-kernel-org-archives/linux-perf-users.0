From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/12] perf c2c: Keep struct hist_entry at the end of struct c2c_hist_entry
Date: Mon, 11 Jun 2018 14:48:09 -0300
Message-ID: <20180611174810.14815-12-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Exactly as the comment just before 'struct c2c_hist_entry" says, i.e.
the last entry in struct hist_entry is a zero length array, that when
allocating space for hist_entry gets extra space if callchains are in
use, which, if hist_entry is not at the end of c2c_hist_entry, the
members after it gets corrupted when callchains get added to the rb
trees collecting them, etc.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address")
Link: http://lkml.kernel.org/n/tip-bh0ke4fh2ygpj3yowna7o1di@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 307b3594525f..6a8738f7ead3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -56,16 +56,16 @@ struct c2c_hist_entry {
 
 	struct compute_stats	 cstats;
 
+	unsigned long		 paddr;
+	unsigned long		 paddr_cnt;
+	bool			 paddr_zero;
+	char			*nodestr;
+
 	/*
 	 * must be at the end,
 	 * because of its callchain dynamic entry
 	 */
 	struct hist_entry	he;
-
-	unsigned long		 paddr;
-	unsigned long		 paddr_cnt;
-	bool			 paddr_zero;
-	char			*nodestr;
 };
 
 static char const *coalesce_default = "pid,iaddr";
-- 
2.14.3
