Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793F20408C;
	Wed,  8 Jan 2025 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370016; cv=none; b=FU7NmBdKDhyH29w9EFL02z85REHa7ocmZvmMlO3PxW3TbfN+PN9XwBnSeHEwnUwQQDXggzTMCo38JtIZHnXdm1VtwiAAH7z+aV4rCsZgbBKKOCPmzmol2g5MQTqUIjF6TzM9tKr7SsaEW8LQOL7cMVKw3Up4g5QoG9tzUr8SSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370016; c=relaxed/simple;
	bh=OZjC06P6F/PvY2tElT0PeCr3pD8N23nPPYNYvwrHgYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MVO3OrihS+Th4+VRdpW4CMkWjQ+WW9N8mv6GhEyeGioqPK8HATOEa5aPt/25g0iEwLT6Lr9Dt3RlubVhlUYYj/xxvQREv/kXou1QGhl1fCTKfrLZ/ayAEsHF+YOXwLZSdq0uzxLDPqgU/Xbmue+8Lct7XsLBZB5KC4hCjUXb4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8FDUOXV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8FDUOXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B24C4CED3;
	Wed,  8 Jan 2025 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736370016;
	bh=OZjC06P6F/PvY2tElT0PeCr3pD8N23nPPYNYvwrHgYk=;
	h=From:To:Cc:Subject:Date:From;
	b=B8FDUOXVaPb4LbCvB4MtlwBb9D2oYIoBq9fnuIGXOSEZe5oRztI0fkBIQIrbaYtto
	 qORe+XdbuolVB//OF59Cu8g/jQ4Mhi+yoHXs5E3i4X23YYCmWQMbfY/CPHJdwsKGyC
	 KdEHGKaQd+1Rhy4KnO2WZb/NRsRkotPYAgnWquFNkYNiqtUWOXkJvw4aGQRurv2huL
	 UzOY8JuqOnxiky6g1k+4ussiibfoNGpKag3bjrEpRML/90icTMyKpaeaaEvRZn3/oS
	 TzUZS62BG/IgmUIBgE5tP3KwajCxBUuUFNRVctzNN+cL3txBRjgsjdxt+ITZO7f+4C
	 YpBXKEvwy2DhA==
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
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/2] perf ftrace: Check min/max latency only with bucket range
Date: Wed,  8 Jan 2025 13:00:14 -0800
Message-ID: <20250108210015.1188531-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's an optional feature and remains 0 when bucket range is not given.
And it makes the histogram goes to the last entry always because any
latency (num) is greater than or equal to 0.

Before:
  $ sudo ./perf ftrace latency -a -T do_futex sleep 1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 -    0 us |          0 |                                                |
       1 -    2 us |          0 |                                                |
       2 -    4 us |          0 |                                                |
       4 -    8 us |          0 |                                                |
       8 -   16 us |          0 |                                                |
      16 -   32 us |          0 |                                                |
      32 -   64 us |          0 |                                                |
      64 -  128 us |          0 |                                                |
     128 -  256 us |          0 |                                                |
     256 -  512 us |          0 |                                                |
     512 - 1024 us |          0 |                                                |
       1 -    2 ms |          0 |                                                |
       2 -    4 ms |          0 |                                                |
       4 -    8 ms |          0 |                                                |
       8 -   16 ms |          0 |                                                |
      16 -   32 ms |          0 |                                                |
      32 -   64 ms |          0 |                                                |
      64 -  128 ms |          0 |                                                |
     128 -  256 ms |          0 |                                                |
     256 -  512 ms |          0 |                                                |
     512 - 1024 ms |          0 |                                                |
       1 - ...  s  |       1353 | ############################################## |

After:
  $ sudo ./perf ftrace latency -a -T do_futex sleep 1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 -    0 us |        321 | ###########                                    |
       1 -    2 us |        132 | ####                                           |
       2 -    4 us |        202 | #######                                        |
       4 -    8 us |        188 | ######                                         |
       8 -   16 us |         16 |                                                |
      16 -   32 us |         12 |                                                |
      32 -   64 us |         30 | #                                              |
      64 -  128 us |         98 | ###                                            |
     128 -  256 us |         53 | #                                              |
     256 -  512 us |         57 | ##                                             |
     512 - 1024 us |          9 |                                                |
       1 -    2 ms |          9 |                                                |
       2 -    4 ms |          1 |                                                |
       4 -    8 ms |         98 | ###                                            |
       8 -   16 ms |          5 |                                                |
      16 -   32 ms |          7 |                                                |
      32 -   64 ms |         32 | #                                              |
      64 -  128 ms |         10 |                                                |
     128 -  256 ms |         10 |                                                |
     256 -  512 ms |          2 |                                                |
     512 - 1024 ms |          0 |                                                |
       1 - ...  s  |          0 |                                                |

Fixes: 690a052a6d85c530 ("perf ftrace latency: Add --max-latency option")
Cc: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 08c1cc429b27e169..90cf2c9915a7e35b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -796,8 +796,10 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 			// than the min latency desired.
 			if (num > 0) // 1st entry: [ 1 unit .. bucket_range units ]
 				i = num / ftrace->bucket_range + 1;
+			if (num >= max_latency - min_latency)
+				i = NUM_BUCKET -1;
 		}
-		if (i >= NUM_BUCKET || num >= max_latency - min_latency)
+		if (i >= NUM_BUCKET)
 			i = NUM_BUCKET - 1;
 
 		num += min_latency;
@@ -1738,7 +1740,7 @@ int cmd_ftrace(int argc, const char **argv)
 			ret = -EINVAL;
 			goto out_delete_filters;
 		}
-		if (!ftrace.min_latency) {
+		if (ftrace.bucket_range && !ftrace.min_latency) {
 			/* default min latency should be the bucket range */
 			ftrace.min_latency = ftrace.bucket_range;
 		}
@@ -1749,7 +1751,7 @@ int cmd_ftrace(int argc, const char **argv)
 			ret = -EINVAL;
 			goto out_delete_filters;
 		}
-		if (!ftrace.max_latency) {
+		if (ftrace.bucket_range && !ftrace.max_latency) {
 			/* default max latency should depend on bucket range and num_buckets */
 			ftrace.max_latency = (NUM_BUCKET - 2) * ftrace.bucket_range +
 						ftrace.min_latency;
-- 
2.47.1.613.gc27f4b7a9f-goog

