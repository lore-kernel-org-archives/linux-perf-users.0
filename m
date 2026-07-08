Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA82E888C;
	Wed,  8 Jul 2026 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553466; cv=none; b=ew/8gh921GzKZ2h6yS3QNoVU0EXv5mrY6LBLqSvtxnxpTXP26AD0VppWnTbeP/umVYCKvkooEmV9FiohEnNnkQTARIGP1QZPjVcb21y3zAnh7wsGEMUWLE9W+05C9OpGCRMapJ1RKoNwc9f8xdfKxouQ5xMgZvHXwbdq/eQrJyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553466; c=relaxed/simple;
	bh=0/nWsR++Bm3P4S+Pi0mgcnYqmomOqCR/Al7fy+YwKzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN98AjpBVsd8chByH0KMN7kwca9OYAnOAyA5Z9E8yITIGziBQvGOAJfP+dtewZUdi7L+ZTV/EAtZHaWBbOLOO49ROA+pfko1UA8/hM+lDnTBCruAlqM11ek5ux4gjjUDHvbXi/g6RO18JbIHYGxORT3RilRK5r0DrpNvKVc31Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTV4D8T2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTV4D8T2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C361F00A3D;
	Wed,  8 Jul 2026 23:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553465;
	bh=DajP7XobUHlgSjOO2lQjQF4nK7dLDTjnTm73EmwOSmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTV4D8T2xS3JVzh8B6bM1IgmwqXZ3ECbwOizG+9oXEq44MHNAmt7ViYWVZUdihUnS
	 S9veKEEvpxGDHUUqlD3QniJDNx8pIvWR0VVp+TuRLrOohKfPmr7C4ILlpzbpsPpsAS
	 qDIOv/4l/y4cs/h3z0ibccyL5mAF4Q3kmLt2eLcGlUkc0pk8a+Uh+zqFoTxPTvbda7
	 JjO5g7iWMqe5y4YKUSC0FhCJ3NreCKxwQlPcGbJQYPKTzOAMmEMwqJ/bHgbUednZcA
	 zfMKroySH2cOyHLmeuiSBhR7jqq/WQuOvpnus877uHQVe9/HVaQnNxiR249MF5uYLx
	 lXyGRHJFGZB7g==
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
Subject: [PATCH v1 2/2] perf evsel: Arrange some fields that should be cloned
Date: Wed,  8 Jul 2026 16:31:03 -0700
Message-ID: <20260708233103.1359713-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260708233103.1359713-1-namhyung@kernel.org>
References: <20260708233103.1359713-1-namhyung@kernel.org>
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
index 6b0c08958616bf04..537aca1bf0537792 100644
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
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
@@ -125,8 +131,6 @@ struct evsel {
 	bool			cmdline_group_boundary;
 	bool			reset_group;
 	bool			needs_auxtrace_mmap;
-	bool			default_metricgroup; /* A member of the Default metricgroup */
-	bool			default_show_events; /* If a default group member, show the event */
 	bool			needs_uniquify;
 	bool			fallenback_eacces;
 	bool			fallenback_eopnotsupp;
@@ -182,9 +186,6 @@ struct evsel {
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

