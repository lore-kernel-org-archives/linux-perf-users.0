Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A32BB1C;
	Tue,  1 Oct 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742034; cv=none; b=n4u8pwtH1RH7mNkOxnkLek0Cjm7eNfAkiz4r7+iRLNTQOunes8tjsIEpxpjJmc3BP+qRTb541ZaiQSxjtapI7jIosERGP4C9aegOn55BNEHAIkZGUfTzyhMwGh/ZNEmetahQqKRC61S6HeREgbI8/t6oCanAqojqaTZfBYocikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742034; c=relaxed/simple;
	bh=bnuIx94/I4mNE95yKMxIO/90FkFYQ2/++qPAUf+SEMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhSPVZbYWFWrWbehekkWbGxqVVN6+E6DoiiUDrKnezO8vGZlYNdTkZn7HahQrZNcQ4ztVAIpq1e6n9A6RoxtoZwhzJGK/jxFV4zZztG0ZF2rs724UMDYQPPTAqHJgqcxatk58s1+YM1E1impl6XiVMItWLDFDbnjySEHYws2+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCS3RON5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCS3RON5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C33C4CED0;
	Tue,  1 Oct 2024 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742034;
	bh=bnuIx94/I4mNE95yKMxIO/90FkFYQ2/++qPAUf+SEMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCS3RON5sLSnuiyF+gyBB9lajpoH4ZYtrHQa8AQwoPEqAdT7i38ChHYwtqBAzKWKz
	 zdONLnPgx+qrbY/A5qJGqiEYO7lybEiH/HFfSV3DMfHBO6dk+vev86RAm9wzJ1sQR3
	 8GMJLBJO8XymBzU99RdJZp5ljOnDevRYp38fuInAy2l/OxOYvwogcoPShY93dJPYAG
	 HYMNq2qKxHhtiQM7TxpBY931hfkFBHVsmW5eux1FnHhqVLGcQ0fuvwlRtLy96ZlwoJ
	 0K1KqQs21hY4LYVk9YzMm8rjnP2izSPAYkeQPP7ptsNv+MyeQgAju1G1KbbPLnKdXM
	 Gxy3CqmaILURg==
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
Subject: [PATCH 7/8] perf tools: Check fallback error and order
Date: Mon, 30 Sep 2024 17:20:26 -0700
Message-ID: <20241001002027.1272889-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
References: <20241001002027.1272889-1-namhyung@kernel.org>
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
index 32e30c293d0c6198..ef8356260eea54cd 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
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
@@ -2580,9 +2594,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 
 try_fallback:
-	if (evsel__precise_ip_fallback(evsel))
-		goto retry_open;
-
 	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
 					 idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
@@ -2599,11 +2610,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
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
2.46.1.824.gd892dcdcdd-goog

