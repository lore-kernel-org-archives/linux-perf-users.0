Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F060D18D634;
	Wed, 16 Oct 2024 06:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059842; cv=none; b=nPxUDHlPdHqZPrbJCpzwoOd5Y/8Q71ILPpIsGfHuuKrS3WjMQ/cfGFz6aPzoJ0VYZ5PNkxs+EJ6rgJiWCyG6eW0wNSOVmj+/DRvsPbobxrECZs08/HSB+PXKGPHy4C5DtSOcxInjusz+NyxKld7YoZFcKH/jCgOsuVLeiFwqsf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059842; c=relaxed/simple;
	bh=2GuXExIeHB5Pio+GUyFCWdTjHAtYr6iB9FkrPvyroKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dix1SaAg/HOShoSjEow+651ustR8y/fCOfm6MJT0uoDyJ2rXj/HDsKe+sBzegN4jGMT7YbbqNxVhKIUlolEzyamCzhRa0oPqglSK2mdM9rPAp8OiKhLpvQ79r7vMM3f4T8aT8haNOKkl/JIamt1h/FSCLSUjUAn2I5A+2SHWPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx0XkuZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx0XkuZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24E4C4CED1;
	Wed, 16 Oct 2024 06:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059841;
	bh=2GuXExIeHB5Pio+GUyFCWdTjHAtYr6iB9FkrPvyroKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rx0XkuZyBLavS9dEbq1Ak9nE2fjXQyZLsdbnjM6SpGmeCLr4udyRGnI9M70tYiBLB
	 9I8Rhf3GHsBftYfSOv0sv1LfyZUz/jgF59Awyn1gY4XjQAyrswgsLBCDeFNLrNoGGy
	 l3Kr3NiX7YgJjYK/nqcOjnobnKpDZiP6qUkgAxzmXoBtWydpwwfgumRm8nWpdXoZoo
	 hqIIT1li6NgAVLKSv78tFckNDsbDILTXVT19tbYyrvxNtz/O88tfx/sne9hyQmReLk
	 PkooBzyf8zVnBSw0Z5yM9NzIbIC95irHprmwL+rCYjGrEvumqDaNfO9ybbTfmCTOIS
	 lY5rBqntASAsQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v5 1/9] perf tools: Add fallback for exclude_guest
Date: Tue, 15 Oct 2024 23:23:51 -0700
Message-ID: <20241016062359.264929-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241016062359.264929-1-namhyung@kernel.org>
References: <20241016062359.264929-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
changed to parse "cycles:P" event instead of creating a new cycles
event for perf record.  But it also changed the way how modifiers are
handled so it doesn't set the exclude_guest bit by default.

It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
if not.  Let's add a fallback so that it can work with default events.

Also update perf stat hybrid tests to handle possible u or H modifiers.

Fixes: 7b100989b4f6bce70 ("perf evlist: Remove __evlist__add_default")
Reviewed-by: Ian Rogers <irogers@google.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c      | 18 +++++++++++++++---
 tools/perf/tests/shell/stat.sh |  2 +-
 tools/perf/util/evsel.c        | 21 +++++++++++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b5e18853982cdb0f..0de3db9810db16f8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -640,8 +640,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	 * (behavior changed with commit b0a873e).
 	 */
 	if (errno == EINVAL || errno == ENOSYS ||
-	    errno == ENOENT || errno == EOPNOTSUPP ||
-	    errno == ENXIO) {
+	    errno == ENOENT || errno == ENXIO) {
 		if (verbose > 0)
 			ui__warning("%s event is not supported by the kernel.\n",
 				    evsel__name(counter));
@@ -659,7 +658,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
-	} else if (target__has_per_thread(&target) &&
+	} else if (target__has_per_thread(&target) && errno != EOPNOTSUPP &&
 		   evsel_list->core.threads &&
 		   evsel_list->core.threads->err_thread != -1) {
 		/*
@@ -680,6 +679,19 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		return COUNTER_SKIP;
 	}
 
+	if (errno == EOPNOTSUPP) {
+		if (verbose > 0) {
+			ui__warning("%s event is not supported by the kernel.\n",
+				    evsel__name(counter));
+		}
+		counter->supported = false;
+		counter->errored = true;
+
+		if ((evsel__leader(counter) != counter) ||
+		    !(counter->core.leader->nr_members > 1))
+			return COUNTER_SKIP;
+	}
+
 	evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index f25ef468b8fca992..7a8adf81e4b39338 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -185,7 +185,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles  " | wc -l)
+  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
 
   if [ "$pmus" -ne "$cycles_events" ]
   then
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e9e1f576d34ddf64..c965ec5676f8d54a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3037,6 +3037,27 @@ bool evsel__fallback(struct evsel *evsel, struct target *target, int err,
 		evsel->core.attr.exclude_kernel = 1;
 		evsel->core.attr.exclude_hv     = 1;
 
+		return true;
+	} else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
+		   !evsel->exclude_GH) {
+		const char *name = evsel__name(evsel);
+		char *new_name;
+		const char *sep = ":";
+
+		/* Is there already the separator in the name. */
+		if (strchr(name, '/') ||
+		    (strchr(name, ':') && !evsel->is_libpfm_event))
+			sep = "";
+
+		if (asprintf(&new_name, "%s%sH", name, sep) < 0)
+			return false;
+
+		free(evsel->name);
+		evsel->name = new_name;
+		/* Apple M1 requires exclude_guest */
+		scnprintf(msg, msgsize, "trying to fall back to excluding guest samples");
+		evsel->core.attr.exclude_guest = 1;
+
 		return true;
 	}
 
-- 
2.47.0.rc1.288.g06298d1525-goog

