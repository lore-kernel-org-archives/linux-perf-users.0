Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE11E1322;
	Fri, 13 Sep 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235957; cv=none; b=NW2AKmR4TLp6KQabGvcuS4VtsoT4q3baRe83+2rJ1GRCiHpcxzlH3cEWI5lIzzrTiW+5n/udjAGFdN2mXx0gzoxjo+sJzCYX3KKgDNRm2J3wuF++p3+AMk/it5u3IKpM5F1xNuQPl4lVM8bRm6g//C2GQdA5T1ImdOaAjwqH5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235957; c=relaxed/simple;
	bh=TqGv/vktL2snc2i6wZRpqz0m2qfRkLuGeBy7bQbX/ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWzC6necJh6jS0e706rVqj1yqBB03WrSL9hTacR2Xa5LyGerV2iqdX3phnn4pKKshtDrGJUzJLsE/31zzr8edry2Fh7Grskwz4jE/8aiZI7c2Ft7xjLMmA9XGSZSdypkbFgtwd7MpZ/ZUA3DmfBjZnQammoku6KN9rSWkfn2lQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB9B713D5;
	Fri, 13 Sep 2024 06:59:44 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AD4B3F73B;
	Fri, 13 Sep 2024 06:59:13 -0700 (PDT)
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
Subject: [PATCH v4 2/2] perf stat: Stop repeating when ref_perf_stat() returns -1
Date: Fri, 13 Sep 2024 14:59:07 +0100
Message-Id: <20240913135907.648734-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913135907.648734-1-yeoreum.yun@arm.com>
References: <20240913135907.648734-1-yeoreum.yun@arm.com>
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
Reviewed-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-stat.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 954eb37ce7b8..8b7fc1e3c390 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -948,6 +948,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	return WEXITSTATUS(status);
 }
 
+/*
+ * Returns -1 for fatal errors which signifies to not continue
+ * when in repeat mode.
+ *
+ * Returns < -1 error codes when stat record is used. These
+ * result in the stat information being displayed, but writing
+ * to the file fails and is non fatal.
+ */
 static int run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int ret;
@@ -2875,7 +2883,10 @@ int cmd_stat(int argc, const char **argv)
 			evlist__reset_prev_raw_counts(evsel_list);
 
 		status = run_perf_stat(argc, argv, run_idx);
-		if (forever && status != -1 && !interval) {
+		if (status == -1)
+			break;
+
+		if (forever && !interval) {
 			print_counters(NULL, argc, argv);
 			perf_stat__reset_stats();
 		}
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

