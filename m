Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8E160787;
	Wed, 29 May 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965019; cv=none; b=L5NyN6NgLAGeZrrjFw/vzGMdS+nBeRsXs9LoDBihLqKNnihv/6pO++NvW6d7xsr9ILjNhrI42pTfjx9SS/eYxhnEmh34jZqFg1G893Qz5wIPwrYHJKGyrkYxmOsJ2dL5aDHQG3ew2QCSdR9kv8Ut4kPg5hxNPiBj6S095yej9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965019; c=relaxed/simple;
	bh=Yzmr/CW7FoXY9rtOpGO1OHObEuPSYqt+qaUlmXKnjGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL1oxda5vxuLHE1gau3R0vQX53H0m7bkyK9cFRecoRGCnSX1q+vxZQAYLbB6q5FtntlEPLeRnHp8qje6eJMTFmuKqY8wWhYtRgtIi1RI4p4gOz+Ap4E3YpL5SnrClfWIdcbRCnAWx3pHw5rRRqcUtW9g8nb/MqkRPPUzxPKbjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eydmiAMz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eydmiAMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716965018; x=1748501018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yzmr/CW7FoXY9rtOpGO1OHObEuPSYqt+qaUlmXKnjGM=;
  b=eydmiAMz9fgE5F+hNfazA9KIlYfzIB/Isgi1jlJoePB2T8g/FIG1t2Wi
   0B8Qrqs5IMz+a1kBho60bcD0N0Tx5+HbVZmpvw2p9xhL8GpyEFfaWPhBG
   mxcT0tBOm+z8sQDRMsz5GQIIHQrVgw60uZ1khpwlRmNzxPIFLoWG8/JSo
   tW0hqzAX24iz2+bZHVaEBJSUyUZFGasZazeHZRtQ1xIWlAUbdQ4614dAG
   dCPuShHVTVf6b34ESIQULdH4s1YleUiHdLALXk3dzNbXdIjq5qaFVaQ+P
   PzvCG2tmpA6Wuxzn1ncsZr117P9Wt32LOCY4411dcwnpIGNxxQbhF4dcK
   Q==;
X-CSE-ConnectionGUID: 4YUMTh2rQ3KGTFaBwQuq2A==
X-CSE-MsgGUID: bzWbj6NJR2i8wYzEiSQWkA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16297992"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="16297992"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 23:43:35 -0700
X-CSE-ConnectionGUID: tVA8ivzAQAm4FqZxXbRWtA==
X-CSE-MsgGUID: uOrXQo1GR9qR208XYr/snQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39759279"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2024 23:43:34 -0700
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
Subject: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Wed, 29 May 2024 02:43:19 -0400
Message-ID: <20240529064327.4080674-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529064327.4080674-1-weilin.wang@intel.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

When retire_latency value is used in a metric formula, evsel would fork a perf
record process with "-e" and "-W" options. Perf record will collect required
retire_latency values in parallel while perf stat is collecting counting values.

At the point of time that perf stat stops counting, evsel would stop perf record
by sending sigterm signal to perf record process. Sampled data will be process
to get retire latency value.

Another thread is required to synchronize between perf stat and perf record
when we pass data through pipe.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     |   6 +
 tools/perf/util/Build         |   1 +
 tools/perf/util/evsel.c       |  11 +
 tools/perf/util/intel-tpebs.c | 397 ++++++++++++++++++++++++++++++++++
 tools/perf/util/intel-tpebs.h |  48 ++++
 5 files changed, 463 insertions(+)
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 428e9721b908..b09cb2c6e9c2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -70,6 +70,7 @@
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
 #include "util/util.h"
+#include "util/intel-tpebs.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -653,6 +654,9 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
+
+	tpebs_stop_delete();
+
 	return COUNTER_FATAL;
 }
 
@@ -985,6 +989,8 @@ static void sig_atexit(void)
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
 
+	tpebs_stop();
+
 	sigprocmask(SIG_SETMASK, &oset, NULL);
 
 	if (signr == -1)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 292170a99ab6..79adf39e0d8f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -153,6 +153,7 @@ perf-y += clockid.o
 perf-y += list_sort.o
 perf-y += mutex.o
 perf-y += sharded_mutex.o
+perf-$(CONFIG_X86_64) += intel-tpebs.o
 
 perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a0a8aee7d6b9..4157db30c3e7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2186,6 +2186,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		return 0;
 	}
 
+	if (evsel__is_retire_lat(evsel)) {
+		err = tpebs_start(evsel->evlist, cpus);
+		if (err)
+			return err;
+	}
+
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
 		return err;
@@ -2376,6 +2382,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 void evsel__close(struct evsel *evsel)
 {
+	if (evsel__is_retire_lat(evsel))
+		tpebs_delete();
 	perf_evsel__close(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
 }
@@ -3341,6 +3349,9 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	int cpu_map_idx, thread;
 
+	if (evsel__is_retire_lat(evsel))
+		return 0;
+
 	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
 		     thread++) {
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
new file mode 100644
index 000000000000..d099fc8080e1
--- /dev/null
+++ b/tools/perf/util/intel-tpebs.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * intel_tpebs.c: Intel TPEBS support
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
+#include "cpumap.h"
+#include "metricgroup.h"
+#include <sys/stat.h>
+#include <sys/file.h>
+#include <poll.h>
+
+#define PERF_DATA		"-"
+
+bool tpebs_recording;
+static pid_t tpebs_pid = -1;
+static size_t tpebs_event_size;
+static pthread_t tpebs_reader_thread;
+static struct child_process *tpebs_cmd;
+static struct list_head tpebs_results = LIST_HEAD_INIT(tpebs_results);
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
+static int get_perf_record_args(const char **record_argv, char buf[],
+				const char *cpumap_buf)
+{
+	struct tpebs_retire_lat *e;
+	int i = 0;
+
+	pr_debug("Prepare perf record for retire_latency\n");
+
+	record_argv[i++] = "perf";
+	record_argv[i++] = "record";
+	record_argv[i++] = "-W";
+	record_argv[i++] = "--synth=no";
+	record_argv[i++] = buf;
+
+	if (cpumap_buf) {
+		record_argv[i++] = "-C";
+		record_argv[i++] = cpumap_buf;
+	}
+
+	record_argv[i++] = "-a";
+
+	if (!cpumap_buf) {
+		pr_err("Require cpumap list to run sampling.\n");
+		return -ECANCELED;
+	}
+
+	list_for_each_entry(e, &tpebs_results, nd) {
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
+	tpebs_cmd = zalloc(sizeof(struct child_process));
+	if (!tpebs_cmd)
+		return -ENOMEM;
+	tpebs_cmd->argv = argv;
+	tpebs_cmd->out = -1;
+	return 0;
+}
+
+static int start_perf_record(int control_fd[], int ack_fd[],
+				const char *cpumap_buf)
+{
+	const char **record_argv;
+	int ret;
+	char buf[32];
+
+	scnprintf(buf, sizeof(buf), "--control=fd:%d,%d", control_fd[0], ack_fd[1]);
+
+	record_argv = calloc(12 + 2 * tpebs_event_size, sizeof(char *));
+	if (!record_argv)
+		return -ENOMEM;
+
+	ret = get_perf_record_args(record_argv, buf, cpumap_buf);
+	if (ret)
+		goto out;
+
+	ret = prepare_run_command(record_argv);
+	if (ret)
+		goto out;
+	ret = start_command(tpebs_cmd);
+out:
+	free(record_argv);
+	return ret;
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
+	list_for_each_entry(t, &tpebs_results, nd) {
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
+	struct perf_tool tool = {
+		.sample = process_sample_event,
+		.feature = process_feature_event,
+		.attr = perf_event__process_attr,
+	};
+
+	session = perf_session__new(&data, &tool);
+	if (IS_ERR(session))
+		return NULL;
+	perf_session__process_events(session);
+	perf_session__delete(session);
+
+	return NULL;
+}
+
+int tpebs_start(struct evlist *evsel_list, struct perf_cpu_map *cpus)
+{
+	int ret = 0;
+	struct evsel *evsel;
+	char cpumap_buf[50];
+
+	/*
+	 * We should only run tpebs_start when tpebs_recording is enabled.
+	 * And we should only run it once with all the required events.
+	 */
+	if (tpebs_pid != -1 || !tpebs_recording)
+		return 0;
+
+	cpu_map__snprint(cpus, cpumap_buf, sizeof(cpumap_buf));
+	pr_debug("cpu map: %s\n", cpumap_buf);
+
+	/*
+	 * Prepare perf record for sampling event retire_latency before fork and
+	 * prepare workload
+	 */
+	evlist__for_each_entry(evsel_list, evsel) {
+		struct tpebs_retire_lat *new = zalloc(sizeof(*new));
+		char *name;
+		int i;
+
+		if (!evsel->retire_lat)
+			continue;
+
+		pr_debug("perf stat retire latency of event %s required\n", evsel->name);
+		if (!new) {
+			ret = -1;
+			goto err;
+		}
+		for (i = strlen(evsel->name) - 1; i > 0; i--) {
+			if (evsel->name[i] == 'R')
+				break;
+		}
+		if (i <= 0 || evsel->name[i] != 'R') {
+			ret = -1;
+			goto err;
+		}
+
+		name = strdup(evsel->name);
+		if (!name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		name[i] = 'p';
+		new->name = name;
+		new->tpebs_name = strdup(evsel->name);
+		if (!new->tpebs_name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		list_add_tail(&new->nd, &tpebs_results);
+		tpebs_event_size += 1;
+	}
+
+	if (tpebs_event_size > 0) {
+		int control_fd[2], ack_fd[2], len;
+		char ack_buf[8];
+
+		/*Create control and ack fd for --control*/
+		if (pipe(control_fd) < 0) {
+			pr_err("Failed to create control fifo");
+			ret = -1;
+			goto out;
+		}
+		if (pipe(ack_fd) < 0) {
+			pr_err("Failed to create control fifo");
+			ret = -1;
+			goto out;
+		}
+
+		ret = start_perf_record(control_fd, ack_fd, cpumap_buf);
+		if (ret)
+			goto out;
+		tpebs_pid = tpebs_cmd->pid;
+		if (pthread_create(&tpebs_reader_thread, NULL, __sample_reader, tpebs_cmd)) {
+			kill(tpebs_cmd->pid, SIGTERM);
+			close(tpebs_cmd->out);
+			pr_err("Could not create thread to process sample data.\n");
+			ret = -1;
+			goto out;
+		}
+		/* Wait for perf record initialization.*/
+		len = strlen("enable");
+		ret = write(control_fd[1], "enable", len);
+		if (ret != len) {
+			pr_err("perf record control write control message failed\n");
+			goto out;
+		}
+
+		ret = read(ack_fd[0], ack_buf, sizeof(ack_buf));
+		if (ret > 0)
+			ret = strcmp(ack_buf, "ack\n");
+		else {
+			pr_err("perf record control ack failed\n");
+			goto out;
+		}
+		pr_debug("Received ack from perf record\n");
+out:
+		close(control_fd[0]);
+		close(control_fd[1]);
+		close(ack_fd[0]);
+		close(ack_fd[1]);
+	}
+err:
+	if (ret)
+		tpebs_delete();
+	return ret;
+}
+
+int tpebs_stop(void)
+{
+	int ret = 0;
+
+	/* Like tpebs_start, we should only run tpebs_end once. */
+	if (tpebs_pid != -1) {
+		kill(tpebs_cmd->pid, SIGTERM);
+		tpebs_pid = -1;
+		pthread_join(tpebs_reader_thread, NULL);
+		close(tpebs_cmd->out);
+		ret = finish_command(tpebs_cmd);
+		if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
+			ret = 0;
+	}
+	return ret;
+}
+
+int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	struct perf_counts_values *count;
+	struct tpebs_retire_lat *t;
+	bool found = false;
+	__u64 val;
+	int ret;
+
+	/* Non reitre_latency evsel should never enter this function. */
+	if (!evsel__is_retire_lat(evsel))
+		return -1;
+
+	ret = tpebs_stop();
+	if (ret)
+		return ret;
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+
+	list_for_each_entry(t, &tpebs_results, nd) {
+		if (!strcmp(t->tpebs_name, evsel->name) || !strcmp(t->tpebs_name, evsel->metric_id)) {
+			found = true;
+			break;
+		}
+	}
+
+	/* Set ena and run to non-zero */
+	count->ena = count->run = 1;
+	count->lost = 0;
+
+	if (!found) {
+		/*
+		 * Set default value or 0 when retire_latency for this event is
+		 * not found from sampling data (enable_tpebs_recording not set
+		 * or 0 sample recorded).
+		 */
+		val = 0;
+		return 0;
+	}
+
+	/*
+	 * Only set retire_latency value to the first CPU and thread.
+	 */
+	if (cpu_map_idx == 0 && thread == 0) {
+	/* Lost precision when casting from double to __u64. Any improvement? */
+		val = t->val;
+	} else
+		val = 0;
+
+	count->val = val;
+	return 0;
+}
+
+static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
+{
+	zfree(&r->name);
+	zfree(&r->tpebs_name);
+	free(r);
+}
+
+void tpebs_delete(void)
+{
+	struct tpebs_retire_lat *r, *rtmp;
+
+	list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
+		list_del_init(&r->nd);
+		tpebs_retire_lat__delete(r);
+	}
+
+	if (tpebs_cmd) {
+		free(tpebs_cmd);
+		tpebs_cmd = NULL;
+	}
+}
+
+int tpebs_stop_delete(void)
+{
+	int ret;
+
+	if (tpebs_pid == -1)
+		return 0;
+
+	ret = tpebs_stop();
+	tpebs_delete();
+	return ret;
+}
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
new file mode 100644
index 000000000000..73c1e5219522
--- /dev/null
+++ b/tools/perf/util/intel-tpebs.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * intel_tpebs.h: Intel TEPBS support
+ */
+#ifndef INCLUDE__PERF_INTEL_TPEBS_H__
+#define INCLUDE__PERF_INTEL_TPEBS_H__
+
+#include "stat.h"
+#include "evsel.h"
+
+#ifdef HAVE_ARCH_X86_64_SUPPORT
+
+extern bool tpebs_recording;
+int tpebs_start(struct evlist *evsel_list, struct perf_cpu_map *cpus);
+int tpebs_stop(void);
+void tpebs_delete(void);
+int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
+int tpebs_stop_delete(void);
+
+#else
+
+static inline int tpebs_start(struct evlist *evsel_list __maybe_unused,
+				struct perf_cpu_map *cpus  __maybe_unused)
+{
+	return 0;
+}
+
+static inline int tpebs_stop(void)
+{
+	return 0;
+}
+
+static inline void tpebs_delete(void) {};
+
+static inline int tpebs_set_evsel(struct evsel *evsel  __maybe_unused,
+				int cpu_map_idx  __maybe_unused,
+				int thread  __maybe_unused)
+{
+	return 0;
+}
+
+static inline int tpebs_stop_delete(void)
+{
+	return 0;
+}
+
+#endif
+#endif
-- 
2.43.0

