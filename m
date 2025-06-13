Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EE2D8769;
	Fri, 13 Jun 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814875; cv=none; b=Ddb5mT6z1+NxOjsJVZfdyI5cwVFMMNNv9lLQtYVHD+PlWZCeWXaT3UB0cAdJdkEkEhU8B1HEcUXdhUG6sXBbhxmEyjwRd4fQPMMo6wv9bOGj/IqFLlIKdxI4uFuVQ6gKd4kkC60CmPSuBLcIzStQfeNgOSPlDs2gWiz2tT2MmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814875; c=relaxed/simple;
	bh=AKO2IWwBCnH/kj2D9yQB16wKAlI1BiVH+clJ4sSGF9w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gw5GqtuG47iAU3o3OS0bqxwT4QUwvZ6yu+FR2fEvXbdYyoyCTCvb6eQTI1Put8v8BW2NHv9y8rYCyPJH/qwGdh4ROY1I0+SEFOndWioJIEIYh7B2I/i+USTFXPMpgVth1voiY3Zlr+Tg+nuYtEg8N/Tk5KefcoG/vGjH25kMJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bJcnJ6WN4zdbCp;
	Fri, 13 Jun 2025 19:37:08 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5689E18047B;
	Fri, 13 Jun 2025 19:41:01 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Jun 2025 19:41:01 +0800
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Jun 2025 19:41:00 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf: ftrace: add graph tracer options args/retval/retval-hex/retaddr
Date: Fri, 13 Jun 2025 19:40:47 +0800
Message-ID: <20250613114048.132336-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)

This change adds support for new funcgraph tracer options funcgraph-args,
funcgraph-retval, funcgraph-retval-hex and funcgraph-retaddr.

The new added options are:
  - args       : Show function arguments.
  - retval     : Show function return value.
  - retval-hex : Show function return value in hexadecimal format.
  - retaddr    : Show function return address.

 # ./perf ftrace -G vfs_write --graph-opts retval,retaddr
 # tracer: function_graph
 #
 # CPU  DURATION                  FUNCTION CALLS
 # |     |   |                     |   |   |   |
 5)               |  mutex_unlock() { /* <-rb_simple_write+0xda/0x150 */
 5)   0.188 us    |    local_clock(); /* <-lock_release+0x2ad/0x440 ret=0x3bf2a3cf90e */
 5)               |    rt_mutex_slowunlock() { /* <-rb_simple_write+0xda/0x150 */
 5)               |      _raw_spin_lock_irqsave() { /* <-rt_mutex_slowunlock+0x4f/0x200 */
 5)   0.123 us    |        preempt_count_add(); /* <-_raw_spin_lock_irqsave+0x23/0x90 ret=0x0 */
 5)   0.128 us    |        local_clock(); /* <-__lock_acquire.isra.0+0x17a/0x740 ret=0x3bf2a3cfc8b */
 5)   0.086 us    |        do_raw_spin_trylock(); /* <-_raw_spin_lock_irqsave+0x4a/0x90 ret=0x1 */
 5)   0.845 us    |      } /* _raw_spin_lock_irqsave ret=0x292 */
 5)               |      _raw_spin_unlock_irqrestore() { /* <-rt_mutex_slowunlock+0x191/0x200 */
 5)   0.097 us    |        local_clock(); /* <-lock_release+0x2ad/0x440 ret=0x3bf2a3cff1f */
 5)   0.086 us    |        do_raw_spin_unlock(); /* <-_raw_spin_unlock_irqrestore+0x23/0x60 ret=0x1 */
 5)   0.104 us    |        preempt_count_sub(); /* <-_raw_spin_unlock_irqrestore+0x35/0x60 ret=0x0 */
 5)   0.726 us    |      } /* _raw_spin_unlock_irqrestore ret=0x80000000 */
 5)   1.881 us    |    } /* rt_mutex_slowunlock ret=0x0 */
 5)   2.931 us    |  } /* mutex_unlock ret=0x0 */

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 ++
 tools/perf/builtin-ftrace.c              | 60 +++++++++++++++++++++++-
 tools/perf/util/ftrace.h                 |  4 ++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index b77f58c4d2fd..4b21a755132f 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -123,6 +123,10 @@ OPTIONS for 'perf ftrace trace'
 --graph-opts::
 	List of options allowed to set:
 
+	  - args         - Show function arguments.
+	  - retval       - Show function return value.
+	  - retval-hex   - Show function return value in hexadecimal format.
+	  - retaddr      - Show function return address.
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index bba36ebc2aa7..f7cf1dd7b64b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -301,6 +301,10 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
 	write_tracing_option_file("funcgraph-tail", "0");
+	write_tracing_option_file("funcgraph-args", "0");
+	write_tracing_option_file("funcgraph-retval", "0");
+	write_tracing_option_file("funcgraph-retval-hex", "0");
+	write_tracing_option_file("funcgraph-retaddr", "0");
 	write_tracing_option_file("latency-format", "0");
 	write_tracing_option_file("irq-info", "0");
 }
@@ -542,6 +546,41 @@ static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_funcgraph_args(struct perf_ftrace *ftrace)
+{
+	if (ftrace->graph_args) {
+		if (write_tracing_option_file("funcgraph-args", "1") < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
+{
+	if (ftrace->graph_retval || ftrace->graph_retval_hex) {
+		if (write_tracing_option_file("funcgraph-retval", "1") < 0)
+			return -1;
+	}
+
+	if (ftrace->graph_retval_hex) {
+		if (write_tracing_option_file("funcgraph-retval-hex", "1") < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
+{
+	if (ftrace->graph_retaddr) {
+		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
 static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
 {
 	if (!ftrace->graph_noirqs)
@@ -642,6 +681,21 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
+	if (set_tracing_funcgraph_args(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-args\n");
+		return -1;
+	}
+
+	if (set_tracing_funcgraph_retval(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-retval\n");
+		return -1;
+	}
+
+	if (set_tracing_funcgraph_retaddr(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-retaddr\n");
+		return -1;
+	}
+
 	if (set_tracing_funcgraph_irqs(ftrace) < 0) {
 		pr_err("failed to set tracing option funcgraph-irqs\n");
 		return -1;
@@ -1607,6 +1661,10 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	int ret;
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	struct sublevel_option graph_tracer_opts[] = {
+		{ .name = "args",		.value_ptr = &ftrace->graph_args },
+		{ .name = "retval",		.value_ptr = &ftrace->graph_retval },
+		{ .name = "retval-hex",		.value_ptr = &ftrace->graph_retval_hex },
+		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
@@ -1699,7 +1757,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index a9bc47da83a5..782c33227e92 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -29,6 +29,10 @@ struct perf_ftrace {
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;
+	int			graph_args;
+	int			graph_retval;
+	int			graph_retval_hex;
+	int			graph_retaddr;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
 	int			graph_verbose;
-- 
2.43.0

