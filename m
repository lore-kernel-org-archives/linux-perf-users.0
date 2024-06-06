Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4EE1B3F25;
	Thu,  6 Jun 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684871; cv=none; b=ByvpRLKHCPFCMmMab9Dm2f57YZBWlOS3OaWLoejVbLbYIqzHCCCpWnPQz+0i8FmVJ4x6H5hgYd3AZ8kg0djePY9leFtzhaNFaPUqZHC/rxF5QtrHaRhRq2Q/Vc7tlaVsCM6+YutWThrQ6NmKd7whSljpkc1oo/d9XhgeNpJd8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684871; c=relaxed/simple;
	bh=hd5THI3gAhXc2jN10Sxl+TkEfdWPtV/F/TJXm7qJTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgWZGF1x1nhAmmi6TqeuZ8cMfdF7bfYWfQeThLdoPRhiLSs67vBIh8Wt6+qs8C3D/qSDwFdjun0m4FZEugQHXAG3KaXWJh1sMn3thEQXuRrKXN+HKTt+YNfQcXHC0MIQqlEF7QC6ZqJj8amNjbfuWJfq0Qb2fVa3uwA7kDv4gHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03B5CDA7;
	Thu,  6 Jun 2024 07:41:34 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E45883F64C;
	Thu,  6 Jun 2024 07:41:07 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v7 2/4] tools/perf: Track where perf_sample_ids need per-thread periods
Date: Thu,  6 Jun 2024 15:40:57 +0100
Message-ID: <20240606144059.365633-3-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606144059.365633-1-ben.gainey@arm.com>
References: <20240606144059.365633-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_sample_ids and related evlist/evsel code are modified to track
which events combine inherit+PERF_SAMPLE_READ+PERF_SAMPLE_TID.

Events with this combination of properties must be handled differently
when calculating each sample period. They must use the combination
of (ID + TID) to uniquely identify each distinct sequence of values.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/lib/perf/evlist.c                 | 1 +
 tools/lib/perf/evsel.c                  | 7 +++++++
 tools/lib/perf/include/internal/evsel.h | 9 +++++++++
 3 files changed, 17 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..d17288eeaee4 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -255,6 +255,7 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
 
 	sid->id = id;
 	sid->evsel = evsel;
+	sid->period_per_thread = perf_evsel__attr_has_per_thread_sample_period(evsel);
 	hash = hash_64(sid->id, PERF_EVLIST__HLIST_BITS);
 	hlist_add_head(&sid->node, &evlist->heads[hash]);
 }
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c07160953224..f7abb879f416 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -537,6 +537,13 @@ void perf_evsel__free_id(struct perf_evsel *evsel)
 	evsel->ids = 0;
 }
 
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel)
+{
+	return (evsel->attr.sample_type & PERF_SAMPLE_READ)
+		&& (evsel->attr.sample_type & PERF_SAMPLE_TID)
+		&& evsel->attr.inherit;
+}
+
 void perf_counts_values__scale(struct perf_counts_values *count,
 			       bool scale, __s8 *pscaled)
 {
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 5cd220a61962..f8de2bf89c76 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -36,6 +36,13 @@ struct perf_sample_id {
 
 	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
 	u64			 period;
+
+	/*
+	 * When inherit is combined with PERF_SAMPLE_READ, the period value is
+	 * per (id, thread) tuple, rather than per id, so use the stream_id to
+	 * uniquely identify the period, rather than the id.
+	 */
+	bool			 period_per_thread;
 };
 
 struct perf_evsel {
@@ -88,4 +95,6 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__free_id(struct perf_evsel *evsel);
 
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
-- 
2.45.2

