Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3232E03EA;
	Fri, 10 Apr 2026 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781654; cv=none; b=BP+JY5fBhBMC7wq0Awp2E/5UjJGwXMu1satycXohFLvgsykSL7J3XMf3UK/gdp0wpLrbyQD1a7e/f0kXl0djUGgWMbJs/R5o9I9Qo0wx3wc8roufoqBepJsQ3kn+kYouT2O7ev6XMCVS4kJS+43jFvO9Pxng2GKxQ+2ZPbfNmqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781654; c=relaxed/simple;
	bh=bSjw0l7vsHYRjhidUpSEWJ8ORo5VTXLn7Q7VZAsN0i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3HmhtmOZ0T1vFRVN4Pfq1JOoRm2Z2200kDpStCU3ZNvznMTRV+WvYVGZkMDctvjk7RvPxGyIpoF1C8wpzqWT9uknimKzyRZYRVS2/q/OFTIWSEKLfh5GlGT7D3MEXBdT2DmbcgShxFcl/MU+3qZA0RNaNVHTvFCkB2d4MhHBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZfaHl5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZfaHl5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66DDC2BC9E;
	Fri, 10 Apr 2026 00:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781654;
	bh=bSjw0l7vsHYRjhidUpSEWJ8ORo5VTXLn7Q7VZAsN0i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZfaHl5bixkxXQsQE77cc+Ue187tCbBThcJKo7+avpqOXLiCZNQpHWwspSwXgDTgO
	 b8Mza/VUsGOHJ28zE7LydIMqCsuMfAUgbridNgUNnmCrkFbei8EJEVZ/F9vdPbCIel
	 +2OFLOMlSjCSBwLPtuLiEuVZ/dvHsH5G8oD5tPHzstCGUadP2ykDDNhXZAAjVaEdeb
	 8Ody26PdrJ1UYH0hhdB/MtMs+gqqj5jd/d7nGLJVU8ZPNaSwlRuW9Sa4cvKO51BkD6
	 l5IP2iZnfj4Q0djkmzD8w4tiHQRf644D63o9fl3Zkl/7ibwOyW9A4zjhqPvcwaMSjW
	 ADjyeEaG+864A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/13] perf header: Sanity check HEADER_MEM_TOPOLOGY
Date: Thu,  9 Apr 2026 21:39:53 -0300
Message-ID: <20260410004000.148138-7-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add validation to process_mem_topology() to harden against malformed
perf.data files:

- Upper bound check on nr_nodes (reuses MAX_NUMA_NODES, 4096)
- Minimum section size check before allocating

This is particularly important here since nr is u64, making unbounded
values especially dangerous.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2c6f7c96e2dccaf1..45f533fbb8fdc3c6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3306,6 +3306,18 @@ static int process_mem_topology(struct feat_fd *ff,
 	if (do_read_u64(ff, &nr))
 		return -1;
 
+	if (nr > MAX_NUMA_NODES) {
+		pr_err("Invalid HEADER_MEM_TOPOLOGY: nr_nodes (%llu) > %u\n",
+		       (unsigned long long)nr, MAX_NUMA_NODES);
+		return -1;
+	}
+
+	if (ff->size < 3 * sizeof(u64) + nr * 2 * sizeof(u64)) {
+		pr_err("Invalid HEADER_MEM_TOPOLOGY: section too small (%zu) for %llu nodes\n",
+		       ff->size, (unsigned long long)nr);
+		return -1;
+	}
+
 	nodes = calloc(nr, sizeof(*nodes));
 	if (!nodes)
 		return -1;
-- 
2.53.0

