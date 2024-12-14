Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F559522F;
	Sat, 14 Dec 2024 00:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734136182; cv=none; b=rfChvuIQk35exBFQtjEjdt4J/GEUtVM66dWbyARSCadUizqm5r2XIVqsU/3t4xJM9ijSzsgvTNLMlNDe4kCJJTd6qpg6B3PFtCILrkjT45qDO4i9yj5R4blmcxbOaJ8JM6+kypKQp61uwlgC8tdfJWjwXLqufbV9j0mAgtOihKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734136182; c=relaxed/simple;
	bh=eqHTSpS6/fGwNzRj37ZWTn9z3Q1PGAPL1y8u2vWd0lE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOguQHxuNivnRf5nJh8NF3rCUKEOzRcVOzUh3WrdTUtVcSgAXMl2nS3V/pDtRj8Bqq2ncZbLb49C67fZa+jglPCpcsDctHSoPSgdiF+phdrpqza2XyXn67nmzsO2YwCed2y+AcrmwPpPhmnSGVlsDDVA/pKu6rLp0O3wxDAQClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1gGv6xs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1gGv6xs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F56C4CED0;
	Sat, 14 Dec 2024 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734136181;
	bh=eqHTSpS6/fGwNzRj37ZWTn9z3Q1PGAPL1y8u2vWd0lE=;
	h=From:To:Cc:Subject:Date:From;
	b=D1gGv6xsb0LgB38wR15FxLLNf3yKtnfoNbFVHiT6P/nGwLIoqRNL9rbQ+6a0XYuvw
	 /thyffcLiyL+gWXf7zNiqel/l0kwZ7IAgVqkPy6sI5L2r1g/AGM4tJi3wCi+qlyX3m
	 8tNXK3bbPq6b0MUjgiVaudDR2bjnkXslA+/3yTOngBf8RJMribAR+MChI8sS2OPWpX
	 r46vtgbl0Mjc+HR3EhMWl6WMWhiLqGpKvQ/VBwWTkRUEkrraKZSk2FZNKT1KPYAsyI
	 tAXxfTjBvqV13RhlzFMtUtg9uYR70JEM5586RuxVwkPYWO/XGNVMP7EEVjiCxOK20a
	 nbrl9OBg9WUKw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] perf ftrace latency: Fix compiler error for clang 12
Date: Fri, 13 Dec 2024 16:29:38 -0800
Message-ID: <20241214002938.1027546-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed this error on CentOS 8.

    CLANG   /build/util/bpf_skel/.tmp/func_latency.bpf.o
  Error at line 119: Unsupport signed division for DAG: 0x55829ee68a10: i64 = sdiv 0x55829ee68bb0, 0x55829ee69090, util/bpf_skel/func_latency.bpf.c:119:17 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]Please convert to unsigned div/mod.
  fatal error: error in backend: Cannot select: 0x55829ee68a10: i64 = sdiv 0x55829ee68bb0, 0x55829ee69090, util/bpf_skel/func_latency.bpf.c:119:17 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
    0x55829ee68bb0: i64,ch = CopyFromReg 0x55829edc9a78, Register:i64 %5, util/bpf_skel/func_latency.bpf.c:119:17 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
      0x55829ee68e20: i64 = Register %5
    0x55829ee69090: i64,ch = load<(volatile dereferenceable load 4 from @bucket_range, !tbaa !160), zext from i32> 0x55829edc9a78, 0x55829ee68fc0, undef:i64, util/bpf_skel/func_latency.bpf.c:119:19 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
      0x55829ee68fc0: i64 = BPFISD::Wrapper TargetGlobalAddress:i64<i32* @bucket_range> 0, util/bpf_skel/func_latency.bpf.c:119:19 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
        0x55829ee68808: i64 = TargetGlobalAddress<i32* @bucket_range> 0, util/bpf_skel/func_latency.bpf.c:119:19 @[ util/bpf_skel/func_latency.bpf.c:84:5 ]
      0x55829ee68530: i64 = undef
  In function: func_end
  PLEASE submit a bug report to https://bugs.llvm.org/ and include the crash backtrace, preprocessed source, and associated run script.

It complains about sdiv which is (s64)delta / (u32)bucket_range.
Let's cast the delta to u64 for division.

Fixes: e8536dd47a98b5db ("perf ftrace latency: Introduce --bucket-range to ask for linear bucketing")
Cc: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/func_latency.bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index 50ae153bf26e7a13..4df54e1b1411b10a 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -116,7 +116,8 @@ int BPF_PROG(func_end)
 			// Less than 1 unit (ms or ns), or, in the future,
 			// than the min latency desired.
 			if (delta > 0) { // 1st entry: [ 1 unit .. bucket_range units )
-				key = delta / bucket_range + 1;
+				// clang 12 doesn't like s64 / u32 division
+				key = (__u64)delta / bucket_range + 1;
 				if (key >= NUM_BUCKET ||
 					delta >= max_latency - min_latency)
 					key = NUM_BUCKET - 1;
-- 
2.47.1.613.gc27f4b7a9f-goog

