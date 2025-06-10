Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9C151985;
	Tue, 10 Jun 2025 00:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749517063; cv=none; b=QF2fC7rYT9SfYWLIc3Pir/MJO6fmQKKbXGv/EMnjDKOW0ByohXizgS3v66j/lxiVa7bysGiWCqeDKYV4xvGOl13+QNFA2w/Ae16z0lJKO5+dwsLKrpcS8GcIq7wgd1+TzDJQi7fXXvVfgw0lV+43Ht2+1YR22iLvYKQeCfNYUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749517063; c=relaxed/simple;
	bh=+4CQSPMqTNQcE956N50cCEl2XjxjoVAzYnvINs2GZME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVkvR6Ish+BCEsqfiT3U52O6wSryjbrAK+Yv0zuXv3X6/rH1fnEUQh9fnfszLovq8rym3+FmgBXT3PMYu1obhtnmnwOL5nQmyBo3Q+Gm0WshInxTKLWTDG+t3YP/Bdkvk+T6rzdqMlFn/rbIS2EAWcIsw3zk4MKyH4htIIEDv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBpAEPOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBpAEPOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6371C4CEEB;
	Tue, 10 Jun 2025 00:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749517063;
	bh=+4CQSPMqTNQcE956N50cCEl2XjxjoVAzYnvINs2GZME=;
	h=From:To:Cc:Subject:Date:From;
	b=MBpAEPOUit4Bw5ymbT8exTZdBaANv9ON6RgT/skiHcf62mCPOyRjPead/L7SdaDKY
	 w648U9t0nPqfUpSrIbpseUflapbc/0ZcrwmldS77TvxTeaNLgaoo683SETWMDJy0ba
	 yTjKO7swbfyA7IrrFGGb4DMGo8BJ76nDBvEjqCFPSovpLj6k9Qly22iGeSTdCgIZys
	 RaSsKZIzzN0T8iV1d/82QC77u3adR8O8aG753E+62JV+Z94F88tmUjEYvbEfgNaexX
	 HctKexYunHCMdiR9z0d2k1gxnkZ/KwRcsxVHI0v8cO7VwEjf8iH1xySPYCCVh5YYtv
	 4M367IRcp83RQ==
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
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH for-v6.16] perf mem: Describe the new output fields in the doc
Date: Mon,  9 Jun 2025 17:57:42 -0700
Message-ID: <20250610005742.2173050-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation of the new fields with examples and caveats.
Also update the related documentation for AMD IBS.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-amd-ibs.txt | 59 ++++++++++++++++-------
 tools/perf/Documentation/perf-mem.txt     | 50 +++++++++++++++++++
 2 files changed, 92 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
index 55f80beae0375a72..54854993576070c3 100644
--- a/tools/perf/Documentation/perf-amd-ibs.txt
+++ b/tools/perf/Documentation/perf-amd-ibs.txt
@@ -171,23 +171,48 @@ Below is a simple example of the perf mem tool.
 	# perf mem report
 
 A normal perf mem report output will provide detailed memory access profile.
-However, it can also be aggregated based on output fields. For example:
-
-	# perf mem report -F mem,sample,snoop
-	Samples: 3M of event 'ibs_op//', Event count (approx.): 23524876
-	Memory access                                 Samples  Snoop
-	N/A                                           1903343  N/A
-	L1 hit                                        1056754  N/A
-	L2 hit                                          75231  N/A
-	L3 hit                                           9496  HitM
-	L3 hit                                           2270  N/A
-	RAM hit                                          8710  N/A
-	Remote node, same socket RAM hit                 3241  N/A
-	Remote core, same node Any cache hit             1572  HitM
-	Remote core, same node Any cache hit              514  N/A
-	Remote node, same socket Any cache hit           1216  HitM
-	Remote node, same socket Any cache hit            350  N/A
-	Uncached hit                                       18  N/A
+New output fields will show related access info together.  For example:
+
+	# perf mem report -F overhead,cache,snoop,comm
+	...
+	# Samples: 92K of event 'ibs_op//'
+	# Total weight : 531104
+	#
+	#           ---------- Cache -----------  --- Snoop ----
+	# Overhead       L1     L2 L1-buf  Other     HitM  Other  Command
+	# ........  ............................  ..............  ..........
+	#
+	    76.07%     5.8%  35.7%   0.0%  34.6%    23.3%  52.8%  cc1
+	     5.79%     0.2%   0.0%   0.0%   5.6%     0.1%   5.7%  make
+	     5.78%     0.1%   4.4%   0.0%   1.2%     0.5%   5.3%  gcc
+	     5.33%     0.3%   3.9%   0.0%   1.1%     0.2%   5.2%  as
+	     5.00%     0.1%   3.8%   0.0%   1.0%     0.3%   4.7%  sh
+	     1.56%     0.1%   0.1%   0.0%   1.4%     0.6%   0.9%  ld
+	     0.28%     0.1%   0.0%   0.0%   0.2%     0.1%   0.2%  pkg-config
+	     0.09%     0.0%   0.0%   0.0%   0.1%     0.0%   0.1%  git
+	     0.03%     0.0%   0.0%   0.0%   0.0%     0.0%   0.0%  rm
+	     ...
+
+Also, it can be aggregated based on various memory access info using the
+sort keys.  For example:
+
+	# perf mem report -s mem,snoop
+	...
+	# Samples: 92K of event 'ibs_op//'
+	# Total weight : 531104
+	# Sort order   : mem,snoop
+	#
+	# Overhead       Samples  Memory access                            Snoop
+	# ........  ............  .......................................  ............
+	#
+	    47.99%          1509  L2 hit                                   N/A
+	    25.08%           338  core, same node Any cache hit            HitM
+	    10.24%         54374  N/A                                      N/A
+	     6.77%         35938  L1 hit                                   N/A
+	     6.39%           101  core, same node Any cache hit            N/A
+	     3.50%            69  RAM hit                                  N/A
+	     0.03%           158  LFB/MAB hit                              N/A
+	     0.00%             2  Uncached hit                             N/A
 
 Please refer to their man page for more detail.
 
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 965e73d377724607..4d164836d0943119 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -119,6 +119,22 @@ REPORT OPTIONS
 	And the default sort keys are changed to local_weight, mem, sym, dso,
 	symbol_daddr, dso_daddr, snoop, tlb, locked, blocked, local_ins_lat.
 
+-F::
+--fields=::
+	Specify output field - multiple keys can be specified in CSV format.
+	Please see linkperf:perf-report[1] for details.
+
+	In addition to the default fields, 'perf mem report' will provide the
+	following fields to break down sample periods.
+
+	- op: operation in the sample instruction (load, store, prefetch, ...)
+	- cache: location in CPU cache (L1, L2, ...) where the sample hit
+	- mem: location in memory or other places the sample hit
+	- dtlb: location in Data TLB (L1, L2) where the sample hit
+	- snoop: snoop result for the sampled data access
+
+	Please take a look at the OUTPUT FIELD SELECTION section for caveats.
+
 -T::
 --type-profile::
 	Show data-type profile result instead of code symbols.  This requires
@@ -156,6 +172,40 @@ there are two samples in perf.data file, both with the same sample period,
   90%   [k] memcpy
   10%   [.] strcmp
 
+OUTPUT FIELD SELECTION
+----------------------
+"perf mem report" adds a number of new output fields specific to data source
+information in the sample.  Some of them have the same name with the existing
+sort keys ("mem" and "snoop").  So unlike other fields and sort keys, they'll
+behave differently when it's used by -F/--fields or -s/--sort.
+
+Using those two as output fields will aggregate samples altogether and show
+breakdown.
+
+  $ perf mem report -F mem,snoop
+  ...
+  # ------ Memory -------  --- Snoop ----
+  #     RAM Uncach  Other     HitM  Other
+  # .....................  ..............
+  #
+       3.5%   0.0%  96.5%    25.1%  74.9%
+
+But using the same name for sort keys will aggregate samples for each type
+separately.
+
+  $ perf mem report -s mem,snoop
+  # Overhead       Samples  Memory access                            Snoop
+  # ........  ............  .......................................  ............
+  #
+      47.99%          1509  L2 hit                                   N/A
+      25.08%           338  core, same node Any cache hit            HitM
+      10.24%         54374  N/A                                      N/A
+       6.77%         35938  L1 hit                                   N/A
+       6.39%           101  core, same node Any cache hit            N/A
+       3.50%            69  RAM hit                                  N/A
+       0.03%           158  LFB/MAB hit                              N/A
+       0.00%             2  Uncached hit                             N/A
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-arm-spe[1]
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

