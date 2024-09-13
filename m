Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF6F1D86E8;
	Fri, 13 Sep 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222505; cv=none; b=KIqQO6zTiyX1jHcPTmE/U9Fco7foUl6kSFcjWaMUwwPzMylbZHkheh8Lw89sSeJ6sedC52ej3RIOxoCTdW1w1ywR/dPiuJpu4P3FMkHS4hLXoDRWpSS8Hp/ITHOVQnEEGvY0xieIxElxGidQM/qkrv2z0kEdFDul/vRGjIKhFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222505; c=relaxed/simple;
	bh=StySgqm+xqC2HEujeylioEPzB1Hl4xfOze+9HN6gNpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izncgAiHeUe/Jki8Hxm3zBOyYyZrLC7fyfAHb9OTw4OyUDiHqQamnub41b60Bq0fUU7X7qWrqocK6iIVTJCZvH0G66phpOQxQt/mZOoytZS8uLquqRFXKq7BsGFeKgsLZbZuYQlBY6qWaaGj16tbxTgeZRIpWZcu3NMKnenAmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90F7D1477;
	Fri, 13 Sep 2024 03:15:31 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 639093F64C;
	Fri, 13 Sep 2024 03:15:00 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	asmadeus@codewreck.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 1/2] perf stat: Close cork_fd when create_perf_stat_counter() failed
Date: Fri, 13 Sep 2024 11:14:55 +0100
Message-Id: <20240913101456.633819-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913101456.633819-1-yeoreum.yun@arm.com>
References: <20240913101456.633819-1-yeoreum.yun@arm.com>
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
when create_perf_stat_counter() is failed with COUNTER_FATAL.

Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-stat.c |  4 ++++
 tools/perf/util/evlist.c  | 14 +++++++++++++-
 tools/perf/util/evlist.h  |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 661832756a24..954eb37ce7b8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -763,6 +763,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 			switch (stat_handle_error(counter)) {
 			case COUNTER_FATAL:
+				if (forks)
+					evlist__cancel_workload(evsel_list);
 				return -1;
 			case COUNTER_RETRY:
 				goto try_again;
@@ -804,6 +806,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 				switch (stat_handle_error(counter)) {
 				case COUNTER_FATAL:
+					if (forks)
+						evlist__cancel_workload(evsel_list);
 					return -1;
 				case COUNTER_RETRY:
 					goto try_again_reset;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3a719edafc7a..51a221679c92 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -46,6 +46,7 @@
 #include <sys/mman.h>
 #include <sys/prctl.h>
 #include <sys/timerfd.h>
+#include <sys/wait.h>
 
 #include <linux/bitops.h>
 #include <linux/hash.h>
@@ -1465,7 +1466,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 		 * For cancelling the workload without actually running it,
 		 * the parent will just close workload.cork_fd, without writing
 		 * anything, i.e. read will return zero and we just exit()
-		 * here.
+		 * here (See evlist__cancel_workload()).
 		 */
 		if (ret != 1) {
 			if (ret == -1)
@@ -1546,6 +1547,17 @@ int evlist__start_workload(struct evlist *evlist)
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
index cb91dc9117a2..12f929ffdf92 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -184,6 +184,7 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target,
 			     const char *argv[], bool pipe_output,
 			     void (*exec_error)(int signo, siginfo_t *info, void *ucontext));
 int evlist__start_workload(struct evlist *evlist);
+void evlist__cancel_workload(struct evlist *evlist);
 
 struct option;
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

