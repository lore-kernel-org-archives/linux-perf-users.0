Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45771D86E6;
	Fri, 13 Sep 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222506; cv=none; b=rI+f+IcWhSI7Cj6WXK9pKhn6yIOfhKUx+5ZjD83yBrHdp8P9M9iIapOFqlMHq3i2pmVc4T6HH1hXjQNn/8TjE6ACnCiYQqXCqMKPE6pwOTv3RRZNdI9Zua5klzR5DgwrcXrJY+DVbowjv9kwxlKJAj4u94cVOM54Pjir08venGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222506; c=relaxed/simple;
	bh=ir8vX6MXsOlLBq+Sw4GvLvpZHcWsfRU6u+eNWjXEwJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZ4DCJalUP2zt4c0/78GGDTiBDUyw7wPsNKhkLwQYNWDsznFDSDgflNCHiJFDBS7CuuH9q4GEvHNw1JLbc3vDZPBSNGLF5nBcLJYkC1KqlX/cnFpEv8xY3y+JJycsv8z8dRVP2N806CquOEr2dTxYgKXBwfjId95ByZiK9Rp2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60F6913D5;
	Fri, 13 Sep 2024 03:15:33 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D7AF3F836;
	Fri, 13 Sep 2024 03:15:02 -0700 (PDT)
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
Subject: [PATCH v3 2/2] perf stat: Stop repeating when ref_perf_stat() returns -1
Date: Fri, 13 Sep 2024 11:14:56 +0100
Message-Id: <20240913101456.633819-3-yeoreum.yun@arm.com>
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
 tools/perf/builtin-stat.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 954eb37ce7b8..d25528ea7e40 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2875,7 +2875,19 @@ int cmd_stat(int argc, const char **argv)
 			evlist__reset_prev_raw_counts(evsel_list);
 
 		status = run_perf_stat(argc, argv, run_idx);
-		if (forever && status != -1 && !interval) {
+
+		/*
+		 * Returns -1 for fatal errors which signifies to not continue
+		 * when in repeat mode.
+		 *
+		 * Returns < -1 error codes when stat record is used. These
+		 * result in the stat information being displayed, but writing
+		 * to the file fails and is non fatal.
+		 */
+		if (status == -1)
+			break;
+
+		if (forever && !interval) {
 			print_counters(NULL, argc, argv);
 			perf_stat__reset_stats();
 		}
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

