Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0E2BEFE5;
	Tue, 16 Jun 2026 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573529; cv=none; b=nItCm3/hnbmc1w7hEyuOxDWhdm01YRbewgwi4vgBwWiWUGS9m6yPIYQYsZHr3ZoYQSx6WXU0CT9SisXZYkXSqWVNW5ly6sfWKiF2VNFzfpTranzkgpXILCB8eU3Cx1ntvd8YvLvStpZ3+I7UAxA8St7n6jZzcfFESvQEs1TZxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573529; c=relaxed/simple;
	bh=A1/GoLc53djwNCcTzKKtMR4/Z1+CTJo33m4GE/XsdAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Img69RXrqHWcfIOuBV9A53jQb3w1eJwGKaD30D+1E53GR8iu/nOkWSU/SbvTDLu4JOZgz4Zmhza1eij3dAFytR9D8lN615DMbjhZmL6NmqPmiB18X5uyFe6yFUH2YIiNhERPoJYokzaoj7xHwQGJIIWItzTsQIu/th1Urey/ovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBPFuMU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBPFuMU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EFF1F00A3A;
	Tue, 16 Jun 2026 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573527;
	bh=RniA3Y3Xeruh0O/t5dIkTId45G5JLPafqsrbJRwH1tM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBPFuMU/qOrc8YgpSxAgB8p/IWazmQmpEqN3xSKB5HeIYRLJKQjAn3YUVWLlf1/c3
	 KiX4Hbf3G8etSEJ0tm4eg2PqqsafGKrF0lVnsXa8g7Oo8SRqxe36Pun0aWvUtEoxB+
	 FeRPALn1hdKofm0y8MynoBSw5pABs+IEX+A3gjm/YDxZddvySoZEh2uW1f5dyi97oX
	 8YM09tgALr21iYNxMSAqGWKz1NQgf0LUOLcPTdFyvJ6LveWODVEq4QK4A+UN0iVk02
	 3I32JDtW966nJ8PIXzKXZCq3/gPAYY/gwInpy2qVAI+lrxY+Ri/7wEYVzz0KVHSKLy
	 cXhjahJKond0w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 1/2] perf evsel: Add lazy-initialized probe type detection helpers
Date: Mon, 15 Jun 2026 22:31:56 -0300
Message-ID: <20260616013157.38960-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616013157.38960-1-acme@kernel.org>
References: <20260616013157.38960-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Several places in perf need to check whether an evsel is a kprobe or
uprobe, which requires looking up the PMU by name via evsel__find_pmu().
This lookup walks the PMU list each time, which is wasteful when the
same evsel is checked repeatedly.

Add evsel__is_kprobe(), evsel__is_uprobe(), and evsel__is_probe() that
resolve the probe type on first call via evsel__pmu_name() and cache
the result in a 2-bit field (probe_type) in struct evsel.  The field
fits in existing padding after the bool fields, so struct size does not
grow.

The enum uses PROBE__UNKNOWN (0) as the uninitialized sentinel —
explicitly set in evsel__init() — so the lookup happens on first use.
PROBE__NOPE (1) caches "not a probe" to avoid repeated negative lookups.

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 44 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h |  5 +++++
 2 files changed, 49 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 05fa0010c858a51e..223571091f09f9ee 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -254,6 +254,49 @@ const char *evsel__pmu_name(const struct evsel *evsel)
 	return event_type(evsel->core.attr.type);
 }
 
+enum evsel_probe_type {
+	PROBE__UNKNOWN	= 0,
+	PROBE__NOPE	= 1,
+	PROBE__KPROBE	= 2,
+	PROBE__UPROBE	= 3,
+};
+
+static void evsel__resolve_probe_type(struct evsel *evsel)
+{
+	const char *name = evsel__pmu_name(evsel);
+
+	if (!strcmp(name, "kprobe"))
+		evsel->probe_type = PROBE__KPROBE;
+	else if (!strcmp(name, "uprobe"))
+		evsel->probe_type = PROBE__UPROBE;
+	else
+		evsel->probe_type = PROBE__NOPE;
+}
+
+bool evsel__is_probe(struct evsel *evsel)
+{
+	if (evsel->probe_type == PROBE__UNKNOWN)
+		evsel__resolve_probe_type(evsel);
+
+	return evsel->probe_type > PROBE__NOPE;
+}
+
+bool evsel__is_kprobe(struct evsel *evsel)
+{
+	if (evsel->probe_type == PROBE__UNKNOWN)
+		evsel__resolve_probe_type(evsel);
+
+	return evsel->probe_type == PROBE__KPROBE;
+}
+
+bool evsel__is_uprobe(struct evsel *evsel)
+{
+	if (evsel->probe_type == PROBE__UNKNOWN)
+		evsel__resolve_probe_type(evsel);
+
+	return evsel->probe_type == PROBE__UPROBE;
+}
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
 int __evsel__sample_size(u64 sample_type)
@@ -413,6 +456,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->supported     = true;
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 	evsel->script_output_type = -1; // FIXME: OUTPUT_TYPE_UNSET, see builtin-script.c
+	evsel->probe_type = PROBE__UNKNOWN;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8009be22cc3f1055..bf75381526147f92 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -126,6 +126,7 @@ struct evsel {
 	bool			needs_uniquify;
 	bool			fallenback_eacces;
 	bool			fallenback_eopnotsupp;
+	u8			probe_type:2;
 	struct hashmap		*per_pkg_mask;
 	int			err;
 	int			script_output_type;
@@ -259,6 +260,10 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
 const char *evsel__pmu_name(const struct evsel *evsel);
 bool evsel__is_aux_event(const struct evsel *evsel);
 
+bool evsel__is_probe(struct evsel *evsel);
+bool evsel__is_kprobe(struct evsel *evsel);
+bool evsel__is_uprobe(struct evsel *evsel);
+
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
 
 static inline struct evsel *evsel__new(struct perf_event_attr *attr)
-- 
2.54.0

