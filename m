Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5401B395F;
	Wed, 16 Oct 2024 06:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059846; cv=none; b=ASAR5uUV3apkLOB5re1QOZXcTThb+nFJVLqNx537HmJ3V1CrJfwG9AVgmKDXTeNPgfy9F3mMwt2KtP9w3DhVqeFMxVIkTJHAVCnvhIqXqI6XQsug+JCEun1dbD3X0+LMBEFlNT6qQAZNguliGHB2lsqDu/iico90QeQMihzGBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059846; c=relaxed/simple;
	bh=rnRrIKaQslEqNn8T+FG377t3JCt5vKicziBWbvSfEEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udieJi1eYAbHOcjLM3HhM6uRxdMEYJQw4vAxbKiMroIEAhhj+8r8L9hKN1h1kj3UWVUCtUCBEfYRYk9X7pKxwNimIsHCOy7c0Y9b5cLQyISltAkPYmtL5fzyoUR0Agtk6vMMd/79y6AxdeT4u7GX7dFicXkL6b/jmme22Icl+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMK1NizS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMK1NizS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E120C4CED4;
	Wed, 16 Oct 2024 06:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059846;
	bh=rnRrIKaQslEqNn8T+FG377t3JCt5vKicziBWbvSfEEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMK1NizSlWoQSIRj/eK5RnqG8te6h/Lh3wDLjiqC9ZDNJELcWV3CedJh8eHPbixwj
	 j2b9njw9bF4j9V4yyP0FGhrpcZwCs20xVD0G8lXluE4SXL6zhOXKP/ZDUVnfgoI3UK
	 3ma6x8L3aALbn1KHVGOq08dwHdOXJINjZ6uHlPhJQbi1gLUzT9sSusKEJlb3ubacnh
	 iMRVwyrxeOiyZESKCUZ823bkBVolMbMe81xQ/CnCRNeHYUPeYMAIvksrilMPa22VqW
	 wVhRDgw6/8HwC4zZZUBP7HklC3zPKcfT//09ujHDPgIVxve/xM0ZqKHc3/eXG15hUf
	 oH+1Fm8pAk+hA==
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
Subject: [PATCH v5 7/9] perf tools: Check fallback error and order
Date: Tue, 15 Oct 2024 23:23:57 -0700
Message-ID: <20241016062359.264929-8-namhyung@kernel.org>
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

The perf_event_open might fail due to various reasons, so blindly
reducing precise_ip level might not be the best way to deal with it.

It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
given precise level.  Let's try again with the correct error code.

This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
user events with exclude_kernel=1 cannot make progress.  Let's add the
evsel__handle_error_quirks() to this case specially.  I plan to work on
the kernel side to improve this situation but it'd still need some
special handling for IBS.

Acked-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a7213cfa75f31150..68380d08a21c5a36 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2060,9 +2060,9 @@ static void evsel__detect_missing_brstack_features(struct evsel *evsel)
 
 	/*
 	 * Must probe features in the order they were added to the
-	 * perf_event_attr interface.  These are PMU specific limitation
-	 * so we can detect with the given hardware event and stop on the
-	 * first one succeeded.
+	 * perf_event_attr interface.  These are kernel core limitation but
+	 * specific to PMUs with branch stack.  So we can detect with the given
+	 * hardware event and stop on the first one succeeded.
 	 */
 
 	/* Please add new feature detection here. */
@@ -2288,6 +2288,25 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
 	return false;
 }
 
+static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
+{
+	/*
+	 * AMD core PMU tries to forward events with precise_ip to IBS PMU
+	 * implicitly.  But IBS PMU has more restrictions so it can fail with
+	 * supported event attributes.  Let's forward it back to the core PMU
+	 * by clearing precise_ip only if it's from precise_max (:P).
+	 */
+	if ((error == -EINVAL || error == -ENOENT) && x86__is_amd_cpu() &&
+	    evsel->core.attr.precise_ip && evsel->precise_max) {
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
@@ -2408,9 +2427,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 
 try_fallback:
-	if (evsel__precise_ip_fallback(evsel))
-		goto retry_open;
-
 	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
 					 idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
@@ -2427,11 +2443,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
2.47.0.rc1.288.g06298d1525-goog

