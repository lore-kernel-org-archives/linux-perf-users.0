Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A123B71A9;
	Fri, 10 Jul 2026 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783726905; cv=none; b=Z0tc5Jxrnp/aafh+Sb/S8vLRIRoDkWYpSPAyhBQXnomhb5C7FRARmsO1pY1aeJDc/uRN8KJ7FrFLI1n3TRtMVMCwGSxLAjonHzfzOaaTsVJqy7XI02/ZU3zDG4pB3INhQ9xG1jDRrSSgjPCd89AcoZn3vTgUXYLuMCFJC0y7fQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783726905; c=relaxed/simple;
	bh=Nb4mW2+P12q8XWk+nuuLnQD1fpdTQGKfFTCKS2PeGB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBMpy5M2gAoHfQSbzOb0zdh1jwjJsBuWFSrE+R3OduzHpRg8tcLzSgKK8RDm/xA5Mk6mbCgLbdupTpc0OAYLAzA4vddOQ8xb7DK4lVk4msDzsuxBu6bGtF+qlVRajkYb0CD9QTJSnI1h2jgn1LxxaOEvRjCtt3UdXuvAqCVPG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fuj6b7RB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fuj6b7RB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A941F00A3D;
	Fri, 10 Jul 2026 23:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783726904;
	bh=MPYKTNBGH6FgS58l2JJwNQ+PfQGYT1OEPLxuX3+aeNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fuj6b7RBXQcbRw+7PV8CG6ic4XZJTOKulJHA9mtR+ssrF7LVQTK8ssoulovk4NhS+
	 x7V87fbAAxcdrp/UB25ilcjgbonaWmNMHAcf1mBgKqw5QhImNcpsHqTXWiz7v0TPEa
	 o2bA36/SiXefOar7tDzqtGy1IZgIB/ou8e7gpDMwIwstH5zKDmFONn+mdFXD4Jbhvi
	 pMgLEJhVWdQiiz8FydMQ0ZGSZX0WpDLmXID7xQZDoWX50jaBG99utXO9/ysQ1/FcQN
	 kjKlJM8mi5alkTgmJCGhn1VseHbG/E9UPX8gTb73EHTzbY9XEfXZB5TYSuOLacaUiN
	 WwzSgJTRrzUwQ==
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
Subject: [PATCH v2 3/4] perf evsel: Arrange some fields that should be cloned
Date: Fri, 10 Jul 2026 16:41:42 -0700
Message-ID: <20260710234143.1934263-3-namhyung@kernel.org>
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

In the evsel, there's an internal struct to put fields need copy when
the evsel is cloned.  This is purely to make it easier track those
fields even if it sometimes failed to do so. :)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 27af0c4f294efb30..42b95933632ae32d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -74,6 +74,10 @@ struct evsel {
 		const char		*unit;
 		struct cgroup		*cgrp;
 		const char		*metric_id;
+
+		/* The PMU the event is from. Used for missing_features, PMU name, etc. */
+		struct perf_pmu		*pmu;
+
 		/*
 		 * This point to the first evsel with the same name, intended to store the
 		 * aggregated counts in aggregation mode.
@@ -94,6 +98,8 @@ struct evsel {
 		bool			skippable;
 		bool			retire_lat;
 		bool			dont_regroup;
+		bool			default_metricgroup; /* A member of the Default metricgroup */
+		bool			default_show_events; /* If a default group member, show the event */
 		struct list_head	config_terms;
 		u64			alternate_hw_config;
 	};
@@ -123,8 +129,6 @@ struct evsel {
 	bool			cmdline_group_boundary;
 	bool			reset_group;
 	bool			needs_auxtrace_mmap;
-	bool			default_metricgroup; /* A member of the Default metricgroup */
-	bool			default_show_events; /* If a default group member, show the event */
 	bool			needs_uniquify;
 	bool			fallenback_eacces;
 	bool			fallenback_eopnotsupp;
@@ -180,9 +184,6 @@ struct evsel {
 	unsigned long		open_flags;
 	int			precise_ip_original;
 
-	/* The PMU the event is from. Used for missing_features, PMU name, etc. */
-	struct perf_pmu		*pmu;
-
 	/* For tool events */
 	/* Beginning time subtracted when the counter is read. */
 	union {
-- 
2.55.0.795.g602f6c329a-goog

