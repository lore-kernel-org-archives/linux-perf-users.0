Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCF91D3199;
	Fri, 13 Sep 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192940; cv=none; b=uIpBIJAKqL7Ztc1LNF6HR+BVfEfAuc8G5EYQNpEH9vYANs8VM91aRSrTwGrEly2ewaNz0+jPqCUy1HrL+slKwr3Px6N3PBTwE6eEOxBdDDC9m833+QioSnlSuTSmwMN4JOeLLAfgniCOchYMTjWR93iw6her9x9kz/g1LsV9RsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192940; c=relaxed/simple;
	bh=atQ2R8pD/pTPo3SqpiX8/UYHoq8DEAfBiIARSOB7iW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gd5GKk/RPaaX9by7XR9XZFGD7Etona9I0SL42kO8AAtMasdi/p1fBFkjgJTKXIOgGpGxFzmiI4ZYtHOC9/oU1UnPGIuPJ0+3HLH2EcmjsNff8hQXyeaJl0HGXEfrO5Kmuf96FSoxqJ7Zx1LzNqmafjtxBSH6j4J92kihi7bpbSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09DF11650;
	Thu, 12 Sep 2024 19:02:48 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 74B2B3F66E;
	Thu, 12 Sep 2024 19:02:16 -0700 (PDT)
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
	asmadeus@codewreck.org
Cc: nd@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 2/2] perf stat: Stop repeating when ref_perf_stat() returns -1
Date: Fri, 13 Sep 2024 03:02:09 +0100
Message-Id: <20240913020209.520104-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913020209.520104-1-yeoreum.yun@arm.com>
References: <20240913020209.520104-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exit when run_perf_stat() returns an error to avoid continuously
repeating the same error message. It's not expected that COUNTER_FATAL
or internal errors are recoverable so there's no point in retrying.

This fixes the following flood of error messages for permission issues,
for example when perf_event_paranoid==3:
  perf stat -r 1044 -- false

  Error:
  Access to performance monitoring and observability operations is limited.
  ...
  Error:
  Access to performance monitoring and observability operations is limited.
  ...
  (repeating for 1044 times).

Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
---
Changes in v2:
  - Add some comments.
---
 tools/perf/builtin-stat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 954eb37ce7b8..0153925f2382 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2875,7 +2875,15 @@ int cmd_stat(int argc, const char **argv)
 			evlist__reset_prev_raw_counts(evsel_list);

 		status = run_perf_stat(argc, argv, run_idx);
-		if (forever && status != -1 && !interval) {
+		/*
+		 * * Meet COUNTER_FATAL situation (i.e) can't open event counter.
+		 * * In this case, there is a high chance of failure in the next attempt
+		 * * as well with the same reason. so, stop it.
+		 * */
+		if (status == -1)
+			break;
+
+		if (forever && !interval) {
 			print_counters(NULL, argc, argv);
 			perf_stat__reset_stats();
 		}
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

