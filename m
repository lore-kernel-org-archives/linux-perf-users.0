Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052816DEDF;
	Wed, 25 Sep 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262504; cv=none; b=Y9tBI34dQZM6f3URignYRfua7lGKYjk/X1UDAOkG4riVmBxv4R3d+uy73mJCqfhQkWAqVgC1V3N5IZskA2zLgflGUudyhnfjN2/VTj3HUcbDrB9JeOd6oJ2/7uVuzgWaLJFZlnLmWWx8XI2IqCFyOVQd1qfQcu7uWCIBFnJjT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262504; c=relaxed/simple;
	bh=/doo7ybACzSXDeYhHEYpI2ifb6nQO2/33UqQpWVZrLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hW+1MYHv3KupI3wEunw3YiuPpXcfvZJ2lD3iX0U5ovWZ8GEijSMhEr/HyuHqB0zoODTXNNe+qW7aynxsJzydyL0ozpVVey6sXrZ3MXCSpleMuoupWaM/zgWzUTPkw1zKMFEMUWSNf9l0Ruv5ZGLU81GvPXpG0N2EJLBYJU+mI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 938E4150C;
	Wed, 25 Sep 2024 04:08:45 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50A553F6A8;
	Wed, 25 Sep 2024 04:08:14 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com
Cc: nd@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH v5 1/2] perf stat: Close cork_fd when create_perf_stat_counter() failed
Date: Wed, 25 Sep 2024 12:08:01 +0100
Message-Id: <20240925110802.2620613-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925110802.2620613-1-yeoreum.yun@arm.com>
References: <20240925110802.2620613-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When create_perf_stat_counter() failed, it doesn't close workload.cork_fd
open in evlist__prepare_workload(). This could make too many open file
error while __run_perf_stat() repeats.

Introduce evlist__cancel_workload to close workload.cork_fd and
wait workload.child_pid until exit to clear child process
when create_perf_stat_counter() is failed.

Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-stat.c | 50 +++++++++++++++++++++++++++------------
 tools/perf/util/evlist.c  | 15 +++++++++++-
 tools/perf/util/evlist.h  |  1 +
 3 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 689a3d43c258..2c46bdbd9914 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -716,15 +716,19 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	}

 	if (!cpu_map__is_dummy(evsel_list->core.user_requested_cpus)) {
-		if (affinity__setup(&saved_affinity) < 0)
-			return -1;
+		if (affinity__setup(&saved_affinity) < 0) {
+			err = -1;
+			goto err_out;
+		}
 		affinity = &saved_affinity;
 	}

 	evlist__for_each_entry(evsel_list, counter) {
 		counter->reset_group = false;
-		if (bpf_counter__load(counter, &target))
-			return -1;
+		if (bpf_counter__load(counter, &target)) {
+			err = -1;
+			goto err_out;
+		}
 		if (!(evsel__is_bperf(counter)))
 			all_counters_use_bpf = false;
 	}
@@ -767,7 +771,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)

 			switch (stat_handle_error(counter)) {
 			case COUNTER_FATAL:
-				return -1;
+				err = -1;
+				goto err_out;
 			case COUNTER_RETRY:
 				goto try_again;
 			case COUNTER_SKIP:
@@ -808,7 +813,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)

 				switch (stat_handle_error(counter)) {
 				case COUNTER_FATAL:
-					return -1;
+					err = -1;
+					goto err_out;
 				case COUNTER_RETRY:
 					goto try_again_reset;
 				case COUNTER_SKIP:
@@ -833,8 +839,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			stat_config.unit_width = l;

 		if (evsel__should_store_id(counter) &&
-		    evsel__store_ids(counter, evsel_list))
-			return -1;
+		    evsel__store_ids(counter, evsel_list)) {
+			err = -1;
+			goto err_out;
+		}
 	}

 	if (evlist__apply_filters(evsel_list, &counter, &target)) {
@@ -855,20 +863,23 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		}

 		if (err < 0)
-			return err;
+			goto err_out;

 		err = perf_event__synthesize_stat_events(&stat_config, NULL, evsel_list,
 							 process_synthesized_event, is_pipe);
 		if (err < 0)
-			return err;
+			goto err_out;
+
 	}

 	if (target.initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 	} else {
 		err = enable_counters();
-		if (err)
-			return -1;
+		if (err) {
+			err = -1;
+			goto err_out;
+		}
 	}

 	/* Exec the command, if any */
@@ -878,8 +889,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (target.initial_delay > 0) {
 		usleep(target.initial_delay * USEC_PER_MSEC);
 		err = enable_counters();
-		if (err)
-			return -1;
+		if (err) {
+			err = -1;
+			goto err_out;
+		}

 		pr_info(EVLIST_ENABLED_MSG);
 	}
@@ -899,7 +912,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
 			pr_err("Workload failed: %s\n", emsg);
-			return -1;
+			err = -1;
+			goto err_out;
 		}

 		if (WIFSIGNALED(status))
@@ -946,6 +960,12 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		evlist__close(evsel_list);

 	return WEXITSTATUS(status);
+
+err_out:
+	if (forks)
+		evlist__cancel_workload(evsel_list);
+
+	return err;
 }

 static int run_perf_stat(int argc, const char **argv, int run_idx)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f14b7e6ff1dc..a37112174535 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -48,6 +48,7 @@
 #include <sys/mman.h>
 #include <sys/prctl.h>
 #include <sys/timerfd.h>
+#include <sys/wait.h>

 #include <linux/bitops.h>
 #include <linux/hash.h>
@@ -1536,7 +1537,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 		 * For cancelling the workload without actually running it,
 		 * the parent will just close workload.cork_fd, without writing
 		 * anything, i.e. read will return zero and we just exit()
-		 * here.
+		 * here (See evlist__cancel_workload()).
 		 */
 		if (ret != 1) {
 			if (ret == -1)
@@ -1611,12 +1612,24 @@ int evlist__start_workload(struct evlist *evlist)
 			perror("unable to write to pipe");

 		close(evlist->workload.cork_fd);
+		evlist->workload.cork_fd = -1;
 		return ret;
 	}

 	return 0;
 }

+void evlist__cancel_workload(struct evlist *evlist)
+{
+	int status;
+
+	if (evlist->workload.cork_fd > 0) {
+		close(evlist->workload.cork_fd);
+		evlist->workload.cork_fd = -1;
+		waitpid(evlist->workload.pid, &status, WNOHANG);
+	}
+}
+
 int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
 {
 	struct evsel *evsel = evlist__event2evsel(evlist, event);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bcc1c6984bb5..888fda751e1a 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -186,6 +186,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target,
 			     const char *argv[], bool pipe_output,
 			     void (*exec_error)(int signo, siginfo_t *info, void *ucontext));
 int evlist__start_workload(struct evlist *evlist);
+void evlist__cancel_workload(struct evlist *evlist);

 struct option;

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

