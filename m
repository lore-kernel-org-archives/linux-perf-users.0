Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D107377566;
	Fri, 10 Jul 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783726905; cv=none; b=HF4o1nhOLCfiYR3LDAHmPyER7cxv5prWcR/OMoRocsfdKE8m1IDOpKCMvw2Ju40RpF9TScb7m1clooJSx2TAVvu9X1hbDzkjG4GyJaKcZs8pFCTvx8L9YW3bPiLIF8ZbU7ZEQ0f+EeduEMikfUHWkaeNS6572jkT6dEUwxIsnIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783726905; c=relaxed/simple;
	bh=yz5jqrtxVLelTtHJolVRKvcLd+BYVWDLI5stcB+1Vmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSnwtU1n5Z+GdAYz1eulqHYuGo7Iwryu1Z0sZwmpqe7uwawkK6O3zyTSl9dqkOA/CY/Q7pnvvzlsJqhH8bVl/FUAuZVP6v1zGCaBaOLNbEono4XxrIEH3PvRaccxou2b6IJUO4HrjCCNDjxjSa3bQXnLZZoJDhuPJSFYZw7e6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joDUoUow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joDUoUow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CA81F00A3F;
	Fri, 10 Jul 2026 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783726904;
	bh=e9r9U2xICAZHeMeDiKWKT+ZXt7ERy51hmXjZcSzYXxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=joDUoUowzbZSvgI6/JDdFxanOZyJjJIcq6Tfhff+8sSj2npDI0g8pNRpcAWMewJY0
	 oqzB2dppW4Z73L64eWDNifRegjm5Fcc5VvsGrtz9mQ2/4Pxb6/L5OmhJIe1ieeo/Xo
	 1ZELj+TN63WUF8dx/suY66gAdjRwtDhdHQqMOnLJiKE7aGBP3DBrha8+spd5G3EjYU
	 BA6iQWTbjtmnKiplgkbdgDFYGWqNl6p34T9RIiHjAPEFy+BXhczcCMyZ8ErQlKQQiu
	 +2Q/fuuv2CExaby+rhFBjJlU68JI3x+yBreKQZYCP5KGrkM5Cfs4gj2b1/KdPuwLXN
	 qf+A0+c6eBgOA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/4] perf evsel: Remove unused BPF related fields
Date: Fri, 10 Jul 2026 16:41:41 -0700
Message-ID: <20260710234143.1934263-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260710234143.1934263-1-namhyung@kernel.org>
References: <20260710234143.1934263-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIUC bpf_fd and bpf_obj fields are not used anymore.  It seems like
leftover from 3d6dfae889174340 ("perf parse-events: Remove BPF event
support").

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 21 ---------------------
 tools/perf/util/evsel.h |  2 --
 2 files changed, 23 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 82399a3eb96e3ce7..ea97efc58e206e70 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -455,8 +455,6 @@ static void evsel__init(struct evsel *evsel,
 	evsel->scale	   = 1.0;
 	evsel->max_events  = ULONG_MAX;
 	evsel->evlist	   = NULL;
-	evsel->bpf_obj	   = NULL;
-	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
 	INIT_LIST_HEAD(&evsel->bpf_counter_list);
 	INIT_LIST_HEAD(&evsel->bpf_filters);
@@ -540,10 +538,6 @@ struct evsel *evsel__clone(struct evsel *orig)
 	BUG_ON(orig->priv);
 	BUG_ON(orig->per_pkg_mask);
 
-	/* cannot handle BPF objects for now */
-	if (orig->bpf_obj)
-		return NULL;
-
 	evsel = evsel__new(&orig->core.attr);
 	if (evsel == NULL)
 		return NULL;
@@ -3079,21 +3073,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			/* Debug message used by test scripts */
 			pr_debug2_peo(" = %d\n", fd);
 
-			if (evsel->bpf_fd >= 0) {
-				int evt_fd = fd;
-				int bpf_fd = evsel->bpf_fd;
-
-				err = ioctl(evt_fd,
-					    PERF_EVENT_IOC_SET_BPF,
-					    bpf_fd);
-				if (err && errno != EEXIST) {
-					pr_err("failed to attach bpf fd %d: %m\n",
-					       bpf_fd);
-					err = -EINVAL;
-					goto out_close;
-				}
-			}
-
 			set_rlimit = NO_CHANGE;
 
 			/*
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6b0c08958616bf04..27af0c4f294efb30 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -94,8 +94,6 @@ struct evsel {
 		bool			skippable;
 		bool			retire_lat;
 		bool			dont_regroup;
-		int			bpf_fd;
-		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
 		u64			alternate_hw_config;
 	};
-- 
2.55.0.795.g602f6c329a-goog

