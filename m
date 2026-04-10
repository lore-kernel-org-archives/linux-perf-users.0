Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B093DEFE2;
	Fri, 10 Apr 2026 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858989; cv=none; b=hw76RAvBdI3KOQHsv2lIrsDm5D/WylFEO/eu3sjeCcV7BbEz9JRrUSKIkNWn8QbaX26O3vtCIreN+5a9oPG2BkNy6Js8XBGEmpcu3Wq2YjSCH/Om6MfI1xJ9gw+7KYQza+L2k+qDFDGISFYi5lMLsDJ21bg6NAoAhY8eGlKJY0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858989; c=relaxed/simple;
	bh=2hUb5eNHqfrZmUcZOh9XjAuEIZTrIReRRL5XVkTRAdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2S8JN2AgwzWfBcHyNqYelTJ7/xdTLiCnbOePHkLnAhayMxO45K1QmOFKAO3n9NsNF/sASPQkKMd7W+ptQtKvJJrg1Eba5CvmoAvsgvxvVEcUJ2WbzhDpjS6DwnsfvXMuoxEgkHfhCxdxaMUw8VxFUrm4ukZtx1tUC+5K0/W7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdXFLilY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdXFLilY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C44BC19424;
	Fri, 10 Apr 2026 22:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858988;
	bh=2hUb5eNHqfrZmUcZOh9XjAuEIZTrIReRRL5XVkTRAdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdXFLilY4AEyipaoMLVEpmcpkz23PsksuI7k6bbsidEm2pXjR1UBRUeXhv1YMC+t/
	 1lq1kS0gtSFLjYeZ7PZBpI+u+nJaPnwUj2riBe4WeeeY3N33i440v27djiR9vDfJxo
	 Xg7YRcaskuvIc1W0FA7LMoi1qJEdyEKnOoj/ul7m7ucmHiwa0+2XmDy8l9QLzTBq+/
	 x5ruy2fmSZVPGK4aG9oGosILJISvzVTQaSJhNGn51Y0d/8MhYT3o5ig2uQfyn2hx4n
	 xh4Meyqx9lQMLD9UJSU+jnykplbsMc/SRc2gShC8UpC1TEw8zJDXKfa3w7KvnAKGn/
	 19d8PT577IxiA==
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
Subject: [PATCH 08/13] perf header: Sanity check HEADER_GROUP_DESC
Date: Fri, 10 Apr 2026 19:09:00 -0300
Message-ID: <20260410220905.200051-9-acme@kernel.org>
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

Add upper bound check on nr_groups in process_group_desc() to harden
against malformed perf.data files (max 32768), and move the env
assignment after validation.

Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 77035d9b138cb3cd..993e20debd5ca315 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -63,6 +63,7 @@
 #include <event-parse.h>
 #endif
 
+#define MAX_GROUP_DESC		32768
 #define MAX_NUMA_NODES		4096
 #define MAX_PMU_MAPPINGS	4096
 #define MAX_SCHED_DOMAINS	64
@@ -3132,12 +3133,25 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr_groups))
 		return -1;
 
-	env->nr_groups = nr_groups;
 	if (!nr_groups) {
 		pr_debug("group desc not available\n");
 		return 0;
 	}
 
+	if (nr_groups > MAX_GROUP_DESC) {
+		pr_err("Invalid HEADER_GROUP_DESC: nr_groups (%u) > %u\n",
+		       nr_groups, MAX_GROUP_DESC);
+		return -1;
+	}
+
+	if (ff->size < sizeof(u32) + nr_groups * 3 * sizeof(u32)) {
+		pr_err("Invalid HEADER_GROUP_DESC: section too small (%zu) for %u groups\n",
+		       ff->size, nr_groups);
+		return -1;
+	}
+
+	env->nr_groups = nr_groups;
+
 	desc = calloc(nr_groups, sizeof(*desc));
 	if (!desc)
 		return -1;
-- 
2.53.0

