Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594063B18D;
	Wed, 15 May 2024 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715751895; cv=none; b=SpHWGz+5sdUyki156/w6lMEt0qN99JtpDEee5YZBoW2WmEfsTgvl11s1lkGidvde7qVfF//DJkH4emvWBxtK9xBRUrjN8jIn/s1mbl4ZqBr+isXFPz49z7U85sfsl3e1jp0gm+xC49Opso8WndnySs6f8Blk2LrjTU7sDunXlD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715751895; c=relaxed/simple;
	bh=xK62uY6Fw+PXYAvUKo/Ufo5GINKjAq/J1I/zhNVtA50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGiuuBKoagb3sZnkH9Bgu3rRqxmHgy2gTV7+bwMfT/XXtSjyjHQXxdZUSVnwPLX1Qj3/Bqwc8AeSXOCMmsH/j4dv34DvhIcp+yaXDYHJfaxPHmbH2u8W0/KFK+7Wiick1DD2pyCxMt1yb/LBJETYk/tHfyUZ4pixGcdOQwzj3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7x2quh+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7x2quh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715751893; x=1747287893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xK62uY6Fw+PXYAvUKo/Ufo5GINKjAq/J1I/zhNVtA50=;
  b=Z7x2quh+paJjqRNi/kOXXeLfFr6pJ3DSl7aQx4AHOmrItyc4SJUP6UqZ
   K9lXWG0174jQ4JWlGvT686+cQfZHrcHyGiP81T9tP9rEsWkLF3tm7gPA7
   3/DdMIrSnrLjAcJvZNTvorEqMUvErF5sauDDYYOVKdnEUGxi6aqVbZwld
   X7kcUzP7xwV4uH//F2I/wPE/XzFSc0yr3Ie9YL6SPtNI/Dzr/JzUk/zod
   XusJd8CvN4nGfmYn0tU5Qp8Enk9WlZ7SDnpnZmPYoJLTME7fVvX1pI33C
   BZ28co5IFpKBCCOSCCg+ycEwkJqjKbYZWDAnNGlXdcB2WGm/uTAuz0L2y
   Q==;
X-CSE-ConnectionGUID: H+8R//pPR6yM61KnqyfqQQ==
X-CSE-MsgGUID: 0N7tOI5jQnCfib0WY7JREQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29298030"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="29298030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:44:51 -0700
X-CSE-ConnectionGUID: ZcMTwxGsTg2mCZufaBBj/A==
X-CSE-MsgGUID: 5PGsNtGZSmy5secudwwu9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35469204"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:44:50 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Wed, 15 May 2024 01:44:25 -0400
Message-ID: <20240515054443.2824147-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515054443.2824147-1-weilin.wang@intel.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When retire_latency value is used in a metric formula, perf stat would fork a
perf record process with "-e" and "-W" options. Perf record will collect
required retire_latency values in parallel while perf stat is collecting
counting values.

At the point of time that perf stat stops counting, it would send sigterm signal
to perf record process and receiving sampling data back from perf record from a
pipe. Perf stat will then process the received data to get retire latency data
and calculate metric result.

Another thread is required to synchronize between perf stat and perf record
when we pass data through pipe.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |  19 +++
 tools/perf/util/Build         |   1 +
 tools/perf/util/intel-tpebs.c | 285 ++++++++++++++++++++++++++++++++++
 tools/perf/util/intel-tpebs.h |  29 ++++
 tools/perf/util/stat.h        |   3 +
 5 files changed, 337 insertions(+)
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 428e9721b908..85927cf45adb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -70,6 +70,7 @@
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
 #include "util/util.h"
+#include "util/intel-tpebs.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -94,6 +95,7 @@
 #include <perf/evlist.h>
 #include <internal/threadmap.h>
 
+
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
 
@@ -162,6 +164,8 @@ static struct perf_stat_config stat_config = {
 	.ctl_fd			= -1,
 	.ctl_fd_ack		= -1,
 	.iostat_run		= false,
+	.tpebs_results		= LIST_HEAD_INIT(stat_config.tpebs_results),
+	.tpebs_pid              = -1,
 };
 
 static void evlist__check_cpu_maps(struct evlist *evlist)
@@ -653,6 +657,8 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
+	if (stat_config.tpebs_pid != -1)
+		stop_tpebs();
 	return COUNTER_FATAL;
 }
 
@@ -673,6 +679,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int err;
 	bool second_pass = false;
 
+	err = start_tpebs(&stat_config, evsel_list);
+	if (err < 0)
+		return err;
+
 	if (forks) {
 		if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe, workload_exec_failed_signal) < 0) {
 			perror("failed to prepare workload");
@@ -878,6 +888,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	t1 = rdclock();
 
+	err = stop_tpebs();
+	if (err < 0)
+		return err;
+
 	if (stat_config.walltime_run_table)
 		stat_config.walltime_run[run_idx] = t1 - t0;
 
@@ -985,6 +999,9 @@ static void sig_atexit(void)
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
 
+	if (stat_config.tpebs_pid != -1)
+		kill(stat_config.tpebs_pid, SIGTERM);
+
 	sigprocmask(SIG_SETMASK, &oset, NULL);
 
 	if (signr == -1)
@@ -2918,5 +2935,7 @@ int cmd_stat(int argc, const char **argv)
 	metricgroup__rblist_exit(&stat_config.metric_events);
 	evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_ack, &stat_config.ctl_fd_close);
 
+	tpebs_data__delete();
+
 	return status;
 }
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 292170a99ab6..c9f1d0bb6bf8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -153,6 +153,7 @@ perf-y += clockid.o
 perf-y += list_sort.o
 perf-y += mutex.o
 perf-y += sharded_mutex.o
+perf-y += intel-tpebs.o
 
 perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
new file mode 100644
index 000000000000..4b7a98794fae
--- /dev/null
+++ b/tools/perf/util/intel-tpebs.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * intel_pt.c: Intel Processor Trace support
+ * Copyright (c) 2013-2015, Intel Corporation.
+ */
+
+
+#include <sys/param.h>
+#include <subcmd/run-command.h>
+#include <thread.h>
+#include "intel-tpebs.h"
+#include <linux/list.h>
+#include <linux/zalloc.h>
+#include <linux/err.h>
+#include "sample.h"
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "session.h"
+#include "tool.h"
+#include "metricgroup.h"
+#include <sys/stat.h>
+#include <sys/file.h>
+
+
+
+#define PERF_DATA		"-"
+#define CONTROL			"/tmp/control"
+#define ACK			"/tmp/ack"
+pthread_t reader_thread;
+struct child_process *cmd;
+struct perf_stat_config *stat_config;
+
+static int get_perf_record_args(const char **record_argv)
+{
+	int i = 0;
+	struct tpebs_retire_lat *e;
+
+	pr_debug("Prepare perf record for retire_latency\n");
+
+	record_argv[i++] = "perf";
+	record_argv[i++] = "record";
+	record_argv[i++] = "-W";
+	record_argv[i++] = "--synth=no";
+	record_argv[i++] = "--control=fifo:/tmp/control,/tmp/ack";
+
+	if (stat_config->user_requested_cpu_list) {
+		record_argv[i++] = "-C";
+		record_argv[i++] = stat_config->user_requested_cpu_list;
+	}
+
+	if (stat_config->system_wide)
+		record_argv[i++] = "-a";
+
+	if (!stat_config->system_wide && !stat_config->user_requested_cpu_list) {
+		pr_err("Require -a or -C option to run sampling.\n");
+		return -ECANCELED;
+	}
+
+	list_for_each_entry(e, &stat_config->tpebs_results, nd) {
+		record_argv[i++] = "-e";
+		record_argv[i++] = e->name;
+	}
+
+	record_argv[i++] = "-o";
+	record_argv[i++] = PERF_DATA;
+
+	return 0;
+}
+
+static int prepare_run_command(const char **argv)
+{
+	cmd = zalloc(sizeof(struct child_process));
+	if (!cmd)
+		return -ENOMEM;
+	cmd->argv = argv;
+	cmd->out = -1;
+	return 0;
+}
+
+static int prepare_perf_record(int tpebs_event_size)
+{
+	const char **record_argv;
+	int ret;
+
+	/*Create control and ack fd for --control*/
+	if (mkfifo(CONTROL, 0600)) {
+		pr_err("Failed to create control fifo");
+		return -1;
+	}
+	if (mkfifo(ACK, 0600)) {
+		pr_err("Failed to create control fifo");
+		return -1;
+	}
+
+	record_argv = calloc(10 + 2 * tpebs_event_size, sizeof(char *));
+	if (!record_argv)
+		return -ENOMEM;
+
+
+	ret = get_perf_record_args(record_argv);
+	if (ret)
+		goto out;
+
+	ret = prepare_run_command(record_argv);
+	if (ret)
+		goto out;
+	ret = start_command(cmd);
+out:
+	free(record_argv);
+	return ret;
+}
+struct sample_data_reader {
+	struct perf_tool	tool;
+	struct perf_session	*session;
+};
+
+static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
+{
+	zfree(&r->name);
+	zfree(&r->tpebs_name);
+	free(r);
+}
+
+void tpebs_data__delete(void)
+{
+	struct tpebs_retire_lat *r, *rtmp;
+
+	list_for_each_entry_safe(r, rtmp, &stat_config->tpebs_results, nd) {
+		list_del_init(&r->nd);
+		tpebs_retire_lat__delete(r);
+	}
+	free(cmd);
+}
+
+static int process_sample_event(struct perf_tool *tool __maybe_unused,
+				union perf_event *event __maybe_unused,
+				struct perf_sample *sample,
+				struct evsel *evsel,
+				struct machine *machine __maybe_unused)
+{
+	int ret = 0;
+	const char *evname;
+	struct tpebs_retire_lat *t;
+
+	evname = evsel__name(evsel);
+
+	/*
+	 * Need to handle per core results? We are assuming average retire
+	 * latency value will be used. Save the number of samples and the sum of
+	 * retire latency value for each event.
+	 */
+	list_for_each_entry(t, &stat_config->tpebs_results, nd) {
+		if (!strcmp(evname, t->name)) {
+			t->count += 1;
+			t->sum += sample->retire_lat;
+			t->val = (double) t->sum / t->count;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int process_feature_event(struct perf_session *session,
+				 union perf_event *event)
+{
+	if (event->feat.feat_id < HEADER_LAST_FEATURE)
+		return perf_event__process_feature(session, event);
+	return 0;
+}
+
+static void *__sample_reader(void *arg)
+{
+	struct child_process *child = arg;
+	struct perf_session *session;
+	struct perf_data data = {
+		.mode = PERF_DATA_MODE_READ,
+		.path = PERF_DATA,
+		.file.fd = child->out,
+	};
+	struct sample_data_reader reader = {
+		.tool = {
+		.sample		 = process_sample_event,
+		.feature	 = process_feature_event,
+		.attr		 = perf_event__process_attr,
+		},
+	};
+
+	session = perf_session__new(&data, &reader.tool);
+	if (IS_ERR(session))
+		return NULL;
+	reader.session = session;
+	perf_session__process_events(session);
+	perf_session__delete(session);
+
+	return NULL;
+}
+
+
+int start_tpebs(struct perf_stat_config *perf_stat_config, struct evlist *evsel_list)
+{
+	int ret = 0;
+	struct evsel *evsel;
+	int control = -1, ack = -1;
+
+	stat_config = perf_stat_config;
+	/*
+	 * Prepare perf record for sampling event retire_latency before fork and
+	 * prepare workload
+	 */
+	evlist__for_each_entry(evsel_list, evsel) {
+		if (evsel->retire_lat) {
+			struct tpebs_retire_lat *new = malloc(sizeof(struct tpebs_retire_lat));
+			int i;
+			char *name;
+
+			pr_debug("perf stat retire latency %s required\n", evsel->name);
+			if (!new)
+				return -1;
+			for (i = strlen(evsel->name) - 1; i > 0; i--) {
+				if (evsel->name[i] == 'R')
+					break;
+			}
+			if (i <= 0 || evsel->name[i] != 'R')
+				return -1;
+
+			name = strdup(evsel->name);
+			if (!name)
+				return -ENOMEM;
+			name[i] = 'p';
+			new->name = strdup(name);
+			free(name);
+			new->tpebs_name = strdup(evsel->name);
+			if (!new->tpebs_name)
+				return -ENOMEM;
+			new->count = 0;
+			new->sum = 0;
+			list_add_tail(&new->nd, &stat_config->tpebs_results);
+			stat_config->tpebs_event_size += 1;
+		}
+	}
+
+	if (stat_config->tpebs_event_size > 0) {
+		ret = prepare_perf_record(stat_config->tpebs_event_size);
+		if (ret)
+			return ret;
+		if (pthread_create(&reader_thread, NULL, __sample_reader, cmd)) {
+			kill(cmd->pid, SIGTERM);
+			close(cmd->out);
+			pr_err("Could not create thread to process sample data.\n");
+			return -1;
+		}
+		/* Wait for perf record initialization a little bit.*/
+		control = open(CONTROL, O_RDONLY, O_NONBLOCK);
+		if (!control)
+			return -1;
+		close(control);
+		ack = open(ACK, O_RDONLY, O_NONBLOCK);
+		if (!ack)
+			return -1;
+		close(ack);
+		pr_debug("Received ack from perf record\n");
+	}
+
+	return ret;
+}
+
+
+int stop_tpebs(void)
+{
+	int ret = 0;
+
+	if (stat_config->tpebs_event_size > 0) {
+		kill(cmd->pid, SIGTERM);
+		pthread_join(reader_thread, NULL);
+		close(cmd->out);
+		ret = finish_command(cmd);
+		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+			ret = 0;
+		remove(CONTROL);
+		remove(ACK);
+	}
+	return ret;
+}
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
new file mode 100644
index 000000000000..e8e2bb2f479b
--- /dev/null
+++ b/tools/perf/util/intel-tpebs.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * intel_pt.h: Intel Processor Trace support
+ * Copyright (c) 2013-2015, Intel Corporation.
+ */
+#include "stat.h"
+
+#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
+#define INCLUDE__PERF_INTEL_TPEBS_H__
+
+struct tpebs_retire_lat {
+	struct list_head nd;
+	/* Event name */
+	const char *name;
+	/* Event name with the TPEBS modifier R */
+	const char *tpebs_name;
+	/* Count of retire_latency values found in sample data */
+	size_t count;
+	/* Sum of all the retire_latency values in sample data */
+	int sum;
+	/* Average of retire_latency, val = sum / count */
+	double val;
+};
+
+int start_tpebs(struct perf_stat_config *perf_stat_config, struct evlist *evsel_list);
+int stop_tpebs(void);
+void tpebs_data__delete(void);
+
+#endif
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index fd7a187551bd..c6c2aa43030f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -110,6 +110,9 @@ struct perf_stat_config {
 	struct cpu_aggr_map	*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
+	size_t			 tpebs_event_size;
+	struct list_head	 tpebs_results;
+	pid_t			 tpebs_pid;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
-- 
2.43.0

