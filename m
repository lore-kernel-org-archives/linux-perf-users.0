Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15706126F0A;
	Wed, 25 Sep 2024 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270436; cv=none; b=hrYYo8+GYYKEsPsDluSpyBLrFSP4ulll/ZLouNQ9Taw5GhGNnhmEO4/zcjqQ3wuWaVR0c1oMVqke5rW4i5XGmFBS7AAvgcBo8fQ2ZZ1BS0pU9eqM0lpcckc23Z6KIsQWdo0FVpSaa2lB+0RvrzMYULyDBjzQuv1S0TswUS3DneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270436; c=relaxed/simple;
	bh=VWkCCMmt+SSlKeFVFSzuMOqde4LRaApjaJXEOTiXnew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hcwCqD0xSyLLp6KA1lE0hK372mJdXhiHdbEKrvGqBNVyvDCo2+MQKOS5JOpicH0/dMh6CS3eomhTmbv3QII2kn7i61jFFFdb7RLNW6Y2ma1wgUtGY9pcyVmTCAitKXHxslus8zHRNr5sAFZAeWJwcGPJqCkRuOcHgf4qqJ9OBcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1B9C150C;
	Wed, 25 Sep 2024 06:21:03 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 83E723F64C;
	Wed, 25 Sep 2024 06:20:32 -0700 (PDT)
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
Subject: [PATCH v6 2/2] perf stat: Stop repeating when ref_perf_stat() returns -1
Date: Wed, 25 Sep 2024 14:20:22 +0100
Message-Id: <20240925132022.2650180-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925132022.2650180-1-yeoreum.yun@arm.com>
References: <20240925132022.2650180-1-yeoreum.yun@arm.com>
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
index 2c46bdbd9914..6cad3435b198 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -968,6 +968,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	return err;
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
@@ -2899,7 +2907,10 @@ int cmd_stat(int argc, const char **argv)
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

