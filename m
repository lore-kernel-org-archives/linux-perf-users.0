Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084E1B4C56;
	Thu,  5 Sep 2024 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567875; cv=none; b=ARLkcm6UOGk8OjQ1E0Ahvh3DoIcabEDr/OwG1cKVk/FUCn8JisVAyMqQP5F2/HeQgskxYW1Ws7uxPc7bCUHaYbZK6/RtU3yH8uJReIPZAoUbW36/FAx47N/kh1ezZY5E+ilMLmO1jrMyBoBcu+xVGGbBuAQBeyDYIrhW31Bhgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567875; c=relaxed/simple;
	bh=AufemQAU604Y4JGWJuF8BhzAdHiSnLIB5lKrQoVMdK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdEukLJ0fC+Dfvl8YOpOhptKc/YSSVp0khahw2Mz7UAUKTqFsUhqs7LV6yWWnklq4Mk4utqrTy2tPIG3mz9v376eIo1qMBlijaF95mga7nl5JOjEF3vf0RsV67dKsWsIw4hRPjV+pe+yk0PrLkG2XRAj9+y5q1Lajqvsbb1I8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfCiNnwE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfCiNnwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83658C4CEC9;
	Thu,  5 Sep 2024 20:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725567875;
	bh=AufemQAU604Y4JGWJuF8BhzAdHiSnLIB5lKrQoVMdK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfCiNnwE0sdsRr5mZ1AvaDDmoOAJVxKj7xOteJOz/SuY9hh06Jez1EMYH9TTnEY+H
	 IdEJXEszSWefypTkQSOZaC7DnJkmoBIzj4FbGqZEJllEGU+GxWeYtT035oiv/Gs61k
	 WHzBoCbeJc4z9L4AIn7pkVme0dlk/2zF9QonHqZP2n0CzAl1+RQJH58CWHJQLKaPYJ
	 OIKJDqxQcHykVB0uMAKiwojeU7RvQo7phtnzk1W/DC/N2T+YhsVe5x/vwTqp2mQtMK
	 Z0uu0OOokS1opBLmmeqH/XfRsDtE0E4EEJ51WBdJr4mq4z6VdB3FVT59axIipkJK0u
	 nRJNZq77jG8VA==
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
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 09/10] perf tools: Check fallback error and order
Date: Thu,  5 Sep 2024 13:24:25 -0700
Message-ID: <20240905202426.2690105-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905202426.2690105-1-namhyung@kernel.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf_event_open might fail due to various reasons, so blindly
reducing precise_ip level might not be the best way to deal with it.

It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
given precise level.  Let's try again with the correct error code.

This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
user events with exclude_kernel=1 cannot make progress.  Let's add the
evsel__handle_error_quirks() to this case specially.  I plan to work on
the kernel side to improve this situation but it'd still need some
special handling for IBS.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c5df45bb74dfc1b5..895f45921da30bb2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2404,6 +2404,20 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
 	return false;
 }
 
+static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
+{
+	/* AMD IBS doesn't support exclude_kernel, forward it to core PMU */
+	if (error == -EINVAL && evsel->precise_max && evsel->core.attr.precise_ip &&
+	    evsel->core.attr.exclude_kernel && x86__is_amd_cpu()) {
+		evsel->core.attr.precise_ip = 0;
+		pr_debug2_peo("removing precise_ip on AMD\n");
+		display_attr(&evsel->core.attr);
+		return true;
+	}
+
+	return false;
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu_map_idx, int end_cpu_map_idx)
@@ -2565,9 +2579,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 
 try_fallback:
-	if (evsel__precise_ip_fallback(evsel))
-		goto retry_open;
-
 	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
 					 idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
@@ -2584,11 +2595,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
-	if (err != -EINVAL || idx > 0 || thread > 0)
-		goto out_close;
+	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
+		goto retry_open;
 
-	if (evsel__detect_missing_features(evsel))
+	if (err == -EINVAL && evsel__detect_missing_features(evsel))
 		goto fallback_missing_features;
+
+	if (evsel__handle_error_quirks(evsel, err))
+		goto retry_open;
+
 out_close:
 	if (err)
 		threads->err_thread = thread;
-- 
2.46.0.469.g59c65b2a67-goog

