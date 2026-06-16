Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08C450917;
	Tue, 16 Jun 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624698; cv=none; b=uPUoJKtuQ2NnrlAoF/DHVJ1lPK/B2dWb8E/wvpGHyDUCMcoRJG2/RYycOCzvxr4QcxPdrSXuFq4d/IKVAsLiNN8oGqictoFUqjK0Z8iB4UArNdJQweggi4vJmYqly2ZJ/7nT6L9R8ybERC8qqmwktxGycvoKcJpe3k70eJ8aJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624698; c=relaxed/simple;
	bh=0sqncjj6x2Tj+dz2Ih9q+LvrEcweALtmKO6xF635zqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iE1Uk3zvpcBapGMblBkvjPaKehYz8EtyRTuRAx0VdnT1JJJAaQWR5Fdo7sJyeRVL9a7fJdjGcBuYaV3apFm3Wbv9AM7b0aaPOtXqkpJalDuC64S9CVVlX5Gu2PkUdasHvgE+OEe9TDkuRIwmt+69+CyB2duMb1jlTQ94AetMA0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jksc0d2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jksc0d2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BF71F00AC4;
	Tue, 16 Jun 2026 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624696;
	bh=8hcLvp0Y39Y7GqB8qjde2MUDiIh1PAeX1exfMAaAznM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jksc0d2cjq+55L0rdaVYiPWZ9F65/i8z4vFkrc57X/DD2hXH5bt6Bpx/L8cO9uBf5
	 1BkIoLU8OyiSTD2aPH3zNBBDfAWAytwUXzQME2q16NzjDgo4faWrKQQj2UQTmSe9j3
	 9QbFpFcN+wt61sDG0oT5nHQ0sT1MozbVHZJ8UdAl5POlf2IgrJuK7jpzWKy+sHA9oT
	 syWGP6uKsMkJ2MZShP6EZQK8XmDlbo0HjiL5CEJxoIxo2+I6ShGNIJzs43fQrsqW6F
	 i4/En/uCio0BVQk/ScZats5MNVDviJ3ptwezggYsJRvA/jWb4Dx0qBZGAD3eUOQ/OQ
	 CETScE2bdD62w==
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
Date: Tue, 16 Jun 2026 12:44:45 -0300
Message-ID: <20260616154446.7206-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616154446.7206-1-acme@kernel.org>
References: <20260616154446.7206-1-acme@kernel.org>
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
the result in a 3-bit field (probe_type) in struct evsel.  The field
fits in existing padding after the bool fields, so struct size does not
grow.

The enum uses PROBE__UNKNOWN (0) as the uninitialized sentinel —
explicitly set in evsel__init() — so the lookup happens on first use.
PROBE__NOPE (1) caches "not a probe" to avoid repeated negative lookups.

PMU-based probes (kprobe/uprobe PMU) are detected by PMU name.
Ftrace-based dynamic probes (created via tracefs, reported as PMU
"tracepoint") are detected by the __probe_ip field that the kernel
adds to all dynamic probe formats.  This covers kprobes, uprobes, and
fprobes regardless of their group/system name.

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 53 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h |  5 ++++
 2 files changed, 58 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 05fa0010c858a51e..ea9fa04429f08a9e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -254,6 +254,58 @@ const char *evsel__pmu_name(const struct evsel *evsel)
 	return event_type(evsel->core.attr.type);
 }
 
+enum evsel_probe_type {
+	PROBE__UNKNOWN	= 0,
+	PROBE__NOPE	= 1,
+	PROBE__KPROBE	= 2,
+	PROBE__UPROBE	= 3,
+	/*
+	 * Ftrace-based dynamic probes (kprobes/uprobes/fprobes created via
+	 * tracefs) report PMU "tracepoint", not "kprobe"/"uprobe".  Detect
+	 * them by the __probe_ip field that the kernel adds to all dynamic
+	 * probe formats.
+	 */
+	PROBE__FTRACE	= 4,
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
+	else if (!strcmp(name, "tracepoint") && evsel__field(evsel, "__probe_ip"))
+		evsel->probe_type = PROBE__FTRACE;
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
@@ -413,6 +465,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->supported     = true;
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 	evsel->script_output_type = -1; // FIXME: OUTPUT_TYPE_UNSET, see builtin-script.c
+	evsel->probe_type = PROBE__UNKNOWN;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8009be22cc3f1055..300c64d1e0c15e7d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -126,6 +126,7 @@ struct evsel {
 	bool			needs_uniquify;
 	bool			fallenback_eacces;
 	bool			fallenback_eopnotsupp;
+	u8			probe_type:3;
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

