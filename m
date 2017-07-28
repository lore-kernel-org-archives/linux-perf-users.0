From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/15] perf data: Add doc when no conversion support compiled
Date: Fri, 28 Jul 2017 17:00:21 -0300
Message-ID: <20170728200021.11389-16-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Francis Deslauriers <francis.deslauriers@efficios.com>, Julien Desfossez <jdesfossez@efficios.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Geneviève Bastien <gbastien@versatic.net>

This adds documentation on the environment variables needed to the
message telling that no conversion support is compiled in.

Committer testing:

  $ make -C tools/perf install
  $ perf data convert --all --to-ctf myctftrace
  No conversion support compiled in. perf should be compiled with environment variables LIBBABELTRACE=1 and LIBBABELTRACE_DIR=/path/to/libbabeltrace/
  $

Signed-off-by: Geneviève Bastien <gbastien@versatic.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>
Cc: Julien Desfossez <jdesfossez@efficios.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20170727181205.24843-3-gbastien@versatic.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 0adb5f82335a..46cd8490baf4 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -69,7 +69,7 @@ static int cmd_data_convert(int argc, const char **argv)
 	};
 
 #ifndef HAVE_LIBBABELTRACE_SUPPORT
-	pr_err("No conversion support compiled in.\n");
+	pr_err("No conversion support compiled in. perf should be compiled with environment variables LIBBABELTRACE=1 and LIBBABELTRACE_DIR=/path/to/libbabeltrace/\n");
 	return -1;
 #endif
 
-- 
2.9.4
