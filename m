Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF133DEFE2;
	Fri, 10 Apr 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858977; cv=none; b=hE1qq/n3LBIL53u3VwbNSMpWhDRJaejEFDnC6wi3+GdE3G67hDs7djL/p1M9K01/9tcyS3V5EIFOFMFNjChpuaXqwNqoozefhtZ6u/TnfvX7OfCWzPP4PfBDVJfS4uzeYitLw+JcExUc4+f0scVJh/7oWUu8jpjH5H5wOTwaXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858977; c=relaxed/simple;
	bh=I850MQwAMB7j3L+RfWOch7LqtUKcjsXIQ8MP7NKk09g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC5Cbs1sIszULxlSxSB1BkUsZfid9QlxG90aovlDnAX5Gseapv+tG5Z14fzk/ptEZCrQw2f3zfR0LVjqkikYZ+b1YM7JLTSpqKfWMiDhPqspl0i/Cp80NMNfVk/ZLqMjEuNyV84e2eSoMtbRmd4PjaryXEMze+bqR+5NeggVmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+BT0YuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+BT0YuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E999CC19424;
	Fri, 10 Apr 2026 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858977;
	bh=I850MQwAMB7j3L+RfWOch7LqtUKcjsXIQ8MP7NKk09g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+BT0YuVXFloKc+PHG3g3UfxiD8leE1nmqtecstwPs2WD75j8+I40O08douPdgdWV
	 lTgY0KkQXYJq+hsDffh7f/iIPvx0FbmaQqH71XEDgqOYP8jRbpE6cJ9au3SLyvAuMP
	 qdKgKc8kxeoUjuFj4MrozoigIuSYpQJDera5vslxVHxhyaLs1lUQ0TpZ8zU4+T2zOD
	 +lcXFPG0J5NnBfbLmIvEx7Z9jtDtr1G4tERuxcPSoIL5rKIitLjMzMa6SAOS9WFWsa
	 c5IV44NbETyCvE3qkyjPOE/EeWVHMqulgjLcoZIduUIgH15XTnkkw+adInxPqldNht
	 FeAgLb9Z51DpQ==
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
Subject: [PATCH 05/13] perf header: Sanity check HEADER_NUMA_TOPOLOGY
Date: Fri, 10 Apr 2026 19:08:57 -0300
Message-ID: <20260410220905.200051-6-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add validation to process_numa_topology() to harden against malformed
perf.data files:

- Upper bound check on nr_nodes (max 4096)
- Minimum section size check before allocating

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index acd6b07528e013a4..2f405776e5013c13 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -63,6 +63,7 @@
 #include <event-parse.h>
 #endif
 
+#define MAX_NUMA_NODES		4096
 #define MAX_SCHED_DOMAINS	64
 
 /*
@@ -3005,6 +3006,18 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr))
 		return -1;
 
+	if (nr > MAX_NUMA_NODES) {
+		pr_err("Invalid HEADER_NUMA_TOPOLOGY: nr_nodes (%u) > %u\n",
+		       nr, MAX_NUMA_NODES);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + nr * (sizeof(u32) + 2 * sizeof(u64))) {
+		pr_err("Invalid HEADER_NUMA_TOPOLOGY: section too small (%zu) for %u nodes\n",
+		       ff->size, nr);
+		return -1;
+	}
+
 	nodes = calloc(nr, sizeof(*nodes));
 	if (!nodes)
 		return -ENOMEM;
-- 
2.53.0

