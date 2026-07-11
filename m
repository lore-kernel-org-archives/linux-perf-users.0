Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1A1FB1;
	Sat, 11 Jul 2026 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728261; cv=none; b=brp6uEP3Y8LNedKfxp6EaobhbcyTUQBLuTCNATtMfp9QtseKItIqN6rod3zMBx8Re6YKgJgPTwJaDWdM+V1seQXR50zRwqCfBO3zlwQ3LCh/jtkdpyJvt6oqo9mgfborIOwbipd598byjrzVzsvu6Eyw+sArl52wTfblFHAKyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728261; c=relaxed/simple;
	bh=Nb4mW2+P12q8XWk+nuuLnQD1fpdTQGKfFTCKS2PeGB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0tg+use4Q7bVrTQOgcei6VNZdvJlk+We1AxJwkxr/9UIy3bj6pHTwGiB9RvuP7myyh/gmKLSEkZEjpj2oE7u3lQJaEZ8yg2pJgHiDO5AG/rEpRm9/AZ+eV6HWpIirx7pbtc2/JsjwFHsju+bYoaa/J2d6RqJIumLw4cZIo0FoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltMGKk5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltMGKk5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5181F00A3D;
	Sat, 11 Jul 2026 00:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783728260;
	bh=MPYKTNBGH6FgS58l2JJwNQ+PfQGYT1OEPLxuX3+aeNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ltMGKk5g97ovvCZpMpihP/gPPmHV3jBKbYSRgUaMV0PlsVtTlSys/mcyPDwIn6wNS
	 3WJCxCKl4yuNM6tj8H6tmwi3sZxzZZKSIR6vPoxYOz50nSBPOTnBVzsvQus2Aes1g0
	 O/UJ4SKLoWtBA8zqOU0tb9ynIJ33mCw9MTN/M7PRS+RcNhsNUni26RpUcHfGoOMp7Z
	 q84OMqzlCqvIiehBq/9EyZ1v6fUpZa7oGsAuGzDwmihQ6t200E/vqdhwCrphnlq9Kn
	 SVU0vxLaXpPWVwuKLbGe8YIZYLAr1tUzHgw1SM7lWnsN6o1S1jQIy8DWQN1Li4GEaW
	 yODt9efiUypcg==
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
Subject: [PATCH v3 3/4] perf evsel: Arrange some fields that should be cloned
Date: Fri, 10 Jul 2026 17:04:18 -0700
Message-ID: <20260711000419.1949161-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260711000419.1949161-1-namhyung@kernel.org>
References: <20260711000419.1949161-1-namhyung@kernel.org>
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

