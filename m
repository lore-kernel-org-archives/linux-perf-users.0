Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABA130E44;
	Thu, 13 Jun 2024 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249801; cv=none; b=SfpF3dTEc7erGWoU3e0hT5rN1gvxlLJYZtg8Qpx0pS16nOpuSwDZgJffVTqEVh6HbiraRErRhrcMGzbmf9jjndDiUhUI22gcJ5yVJ55+XCFXCXAm4h70wFCmFi3ByB7AuFFXF6ok/uxfnXUXTBPpBAEqtLeXNR9n1smd/yYaBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249801; c=relaxed/simple;
	bh=mqgj0LAa/PJGaETNPbnZZ6EtLOEoG9cWbYYG/A0h/Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmosTSapEpEITaIdZnbFKrK6+nl2nzwntEJtUMMfM8RMJVScpOvCLkwRj/HA4J7yONFOwRrnq8wuUAp7bObAE6uB7aeRitnsINKztwdm03IuWzNfDFSNFpRFaBRQjNrHVLaNkSIagK2okMkVNwacHTREyl60566IxU55Mv1O3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr/s4NGO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr/s4NGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718249799; x=1749785799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqgj0LAa/PJGaETNPbnZZ6EtLOEoG9cWbYYG/A0h/Io=;
  b=Jr/s4NGOCJPnhi4+R5Nb+lHgpT8+lX1R/MECU2OU7ZQ5zkxKgw/4ThBL
   OC0rvopLYQb78V+JR1bTEySf6MCHJs8XcrwwqQkADbNrJl7MHR2nIlkfN
   Wr7+vyqKSqerrLhoyMOlmY9/zKvhuk2vd/hjTkdw4Z/GcDW+zavZTbSJy
   4aWj+YMbL6SHZAn1EV7PCeGFF9naIS/Oy6+FKEb73Cvqg0haJjsVUEsmr
   NI/3NKo+9qSHxNTkaV0xwqpiD/z09Xe8zzSXAO51fVMFjr48ss6OWVKPG
   mq7lvxg3JyDycAZscAFvuzNgbqUsWyNyOQ5sq8cloufmfHdT5yAyvGkHQ
   Q==;
X-CSE-ConnectionGUID: 9RELy0N6SAaWd7EFndVi+Q==
X-CSE-MsgGUID: jbBGrUYSQ5au+KVsbzaNZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12046717"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12046717"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:36:37 -0700
X-CSE-ConnectionGUID: 35wXmuoVQZyThpSt6RU2KQ==
X-CSE-MsgGUID: 5NzvpfTASAKHoZqIpakKaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40100354"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa009.fm.intel.com with ESMTP; 12 Jun 2024 20:36:36 -0700
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
Subject: [RFC PATCH v13 4/9] perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
Date: Wed, 12 Jun 2024 23:36:24 -0400
Message-ID: <20240613033631.199800-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613033631.199800-1-weilin.wang@intel.com>
References: <20240613033631.199800-1-weilin.wang@intel.com>
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
to get retire latency value. Another thread is required to synchronize between
perf stat and perf record when we pass data through pipe.

Retire_latency evsel is not opened for perf stat so that there is no counter
wasted on it. This commit includes code suggested by Namhyung to adjust reading
size for groups that include retire_latency evsels.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     |   4 +
 tools/perf/util/Build         |   1 +
 tools/perf/util/evlist.c      |   2 +
 tools/perf/util/evsel.c       |  66 +++++-
 tools/perf/util/intel-tpebs.c | 407 ++++++++++++++++++++++++++++++++++
 tools/perf/util/intel-tpebs.h |  35 +++
 6 files changed, 513 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 661832756a24..68125bd75b37 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -70,6 +70,7 @@
 #include "util/bpf_counter.h"
 #include "util/iostat.h"
 #include "util/util.h"
+#include "util/intel-tpebs.h"
 #include "asm/bug.h"
 
 #include <linux/time64.h>
@@ -683,6 +684,9 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 
 	if (child_pid != -1)
 		kill(child_pid, SIGTERM);
+
+	tpebs_delete();
+
 	return COUNTER_FATAL;
 }
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index da64efd8718f..26ef80641f9f 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -154,6 +154,7 @@ perf-y += clockid.o
 perf-y += list_sort.o
 perf-y += mutex.o
 perf-y += sharded_mutex.o
+perf-$(CONFIG_X86_64) += intel-tpebs.o
 
 perf-$(CONFIG_LIBBPF) += bpf_map.o
 perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3a719edafc7a..78ce80f227aa 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -33,6 +33,7 @@
 #include "util/bpf-filter.h"
 #include "util/stat.h"
 #include "util/util.h"
+#include "util/intel-tpebs.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -179,6 +180,7 @@ void evlist__delete(struct evlist *evlist)
 	if (evlist == NULL)
 		return;
 
+	tpebs_delete();
 	evlist__free_stats(evlist);
 	evlist__munmap(evlist);
 	evlist__close(evlist);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 28c54897a97e..e8e2ad5fc867 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1547,6 +1547,60 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 	perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
 }
 
+static bool evsel__group_has_tpebs(struct evsel *leader)
+{
+	struct evsel *evsel;
+
+	for_each_group_evsel(evsel, leader) {
+		if (evsel__is_retire_lat(evsel))
+			return true;
+	}
+	return false;
+}
+
+static u64 evsel__group_read_nr_members(struct evsel *leader)
+{
+	u64 nr = leader->core.nr_members;
+	struct evsel *evsel;
+
+	for_each_group_evsel(evsel, leader) {
+		if (evsel__is_retire_lat(evsel))
+			nr--;
+	}
+	return nr;
+}
+
+static u64 evsel__group_read_size(struct evsel *leader)
+{
+	u64 read_format = leader->core.attr.read_format;
+	int entry = sizeof(u64); /* value */
+	int size = 0;
+	int nr = 1;
+
+	if (!evsel__group_has_tpebs(leader))
+		return perf_evsel__read_size(&leader->core);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		size += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_ID)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
+	if (read_format & PERF_FORMAT_GROUP) {
+		nr = evsel__group_read_nr_members(leader);
+		size += sizeof(u64);
+	}
+
+	size += entry * nr;
+	return size;
+}
+
 static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int thread, u64 *data)
 {
 	u64 read_format = leader->core.attr.read_format;
@@ -1555,7 +1609,7 @@ static int evsel__process_group_data(struct evsel *leader, int cpu_map_idx, int
 
 	nr = *data++;
 
-	if (nr != (u64) leader->core.nr_members)
+	if (nr != evsel__group_read_nr_members(leader))
 		return -EINVAL;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -1585,7 +1639,7 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->core.attr.read_format;
-	int size = perf_evsel__read_size(&leader->core);
+	int size = evsel__group_read_size(leader);
 	u64 *data = ps->group_data;
 
 	if (!(read_format & PERF_FORMAT_ID))
@@ -2193,6 +2247,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		return 0;
 	}
 
+	if (evsel__is_retire_lat(evsel))
+		return tpebs_start(evsel->evlist);
+
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
 		return err;
@@ -2385,6 +2442,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 void evsel__close(struct evsel *evsel)
 {
+	if (evsel__is_retire_lat(evsel))
+		tpebs_delete();
 	perf_evsel__close(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
 }
@@ -3350,6 +3409,9 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
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
index 000000000000..2bf57e10a959
--- /dev/null
+++ b/tools/perf/util/intel-tpebs.c
@@ -0,0 +1,407 @@
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
+#include <math.h>
+
+#define PERF_DATA		"-"
+
+bool tpebs_recording;
+static pid_t tpebs_pid = -1;
+static size_t tpebs_event_size;
+static LIST_HEAD(tpebs_results);
+static pthread_t tpebs_reader_thread;
+static struct child_process *tpebs_cmd;
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
+	} else {
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
+/*
+ * tpebs_stop - stop the sample data read thread and the perf record process.
+ */
+static int tpebs_stop(void)
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
+/*
+ * tpebs_start - start tpebs execution.
+ * @evsel_list: retire_latency evsels in this list will be selected and sampled
+ * to get the average retire_latency value.
+ *
+ * This function will be called from evlist level later when evlist__open() is
+ * called consistently.
+ */
+int tpebs_start(struct evlist *evsel_list)
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
+	cpu_map__snprint(evsel_list->core.user_requested_cpus, cpumap_buf, sizeof(cpumap_buf));
+	/*
+	 * Prepare perf record for sampling event retire_latency before fork and
+	 * prepare workload
+	 */
+	evlist__for_each_entry(evsel_list, evsel) {
+		int i;
+		char *name;
+		struct tpebs_retire_lat *new;
+
+		if (!evsel->retire_lat)
+			continue;
+
+		pr_debug("Retire_latency of event %s is required\n", evsel->name);
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
+
+		new = zalloc(sizeof(*new));
+		if (!new) {
+			ret = -1;
+			zfree(name);
+			goto err;
+		}
+		new->name = name;
+		new->tpebs_name = evsel->name;
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
+
+int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	__u64 val;
+	bool found = false;
+	struct tpebs_retire_lat *t;
+	struct perf_counts_values *count;
+
+	/* Non reitre_latency evsel should never enter this function. */
+	if (!evsel__is_retire_lat(evsel))
+		return -1;
+
+	/*
+	 * Need to stop the forked record to ensure get sampled data from the
+	 * PIPE to process and get non-zero retire_lat value for hybrid.
+	 */
+	tpebs_stop();
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+
+	list_for_each_entry(t, &tpebs_results, nd) {
+		if (t->tpebs_name == evsel->name || !strcmp(t->tpebs_name, evsel->metric_id)) {
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
+		count->val = 0;
+		return 0;
+	}
+
+	/*
+	 * Only set retire_latency value to the first CPU and thread.
+	 */
+	if (cpu_map_idx == 0 && thread == 0)
+		val = rint(t->val);
+	else
+		val = 0;
+
+	count->val = val;
+	return 0;
+}
+
+static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
+{
+	zfree(&r->name);
+	free(r);
+}
+
+
+/*
+ * tpebs_delete - delete tpebs related data and stop the created thread and
+ * process by calling tpebs_stop().
+ *
+ * This function is called from evlist_delete() and also from builtin-stat
+ * stat_handle_error(). If tpebs_start() is called from places other then perf
+ * stat, need to ensure tpebs_delete() is also called to safely free mem and
+ * close the data read thread and the forked perf record process.
+ *
+ * This function is also called in evsel__close() to be symmetric with
+ * tpebs_start() being called in evsel__open(). We will update this call site
+ * when move tpebs_start() to evlist level.
+ */
+void tpebs_delete(void)
+{
+	struct tpebs_retire_lat *r, *rtmp;
+
+	if (tpebs_pid == -1)
+		return;
+
+	tpebs_stop();
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
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
new file mode 100644
index 000000000000..766b3fbd79f1
--- /dev/null
+++ b/tools/perf/util/intel-tpebs.h
@@ -0,0 +1,35 @@
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
+int tpebs_start(struct evlist *evsel_list);
+void tpebs_delete(void);
+int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
+
+#else
+
+static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
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
+#endif
+#endif
-- 
2.43.0

