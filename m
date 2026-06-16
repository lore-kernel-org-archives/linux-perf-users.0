Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6747CC70;
	Tue, 16 Jun 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634357; cv=none; b=Squk5to/pR/QQKKnCOCthdyxnkxIjBKyJ4CjG0vf7abaj+7dg6tW13erdbAlfFQS6bXLyVLFSNihKeBIeaa7rpG6adihCnCMKSr44XWrYB+Fc9KFxgmUpTmK3jCZyEV16/RJfI746S/XWrXtXJBUbEa+OiU/J15LoP92FBkoPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634357; c=relaxed/simple;
	bh=zgUt24gu+8tzh7/9SFI7WvWpp4NJL3BCGK6G3kNb3nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QEPZpINLDN2uDSH7813UtYMRyzWRekz2043x+BhIQMp0OhBypz+Yk1RsynzyhXEA+a4RaTRPANKjAN7kCUN7d8dLV67XiPtaqiwDx9rwxse4bOeizoBssO1Kmboa/zmBKgQ9+qstVOS7ZvDMRxTce18ZtUAvKMiiuCjlb/0toJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELQAt/qW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELQAt/qW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55A71F00A3A;
	Tue, 16 Jun 2026 18:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781634355;
	bh=KTLO6GfdGjF9hxIivMHaY4nXCFGxx0Lk9axnc0RZfj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ELQAt/qWEQwjdEQT8Q5LIzAn3KbnwP2UCqCLYV5abWDp0bY4bVjgav9YwqRmFEmaK
	 tZOtAoaIuV+YNh0fw40Sxftmkb/R15zSvV5Q/YCApETOWOuaHHGUG5/eTr8VifZ+hT
	 7jCjzbl4ySS/uceQokD9UnRysoFXFXq4aa/lSjjW3t0zxNIsBcNAVT7sxxl5VvmxZR
	 3DtJ6/WKgfkP/U9x0Szi2beC50Pxpl7e3TT6T1L4FLiHFBNcqYIAWrALldfMASJbgQ
	 YdrTrgYo73fwhTB09RPJKN87Epgz81u3V2Lr98IgtvpHXy1GOqusqTdraY7Z4JOdKp
	 ICBsJorW5CicQ==
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
Date: Tue, 16 Jun 2026 15:25:45 -0300
Message-ID: <20260616182546.8892-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616182546.8892-1-acme@kernel.org>
References: <20260616182546.8892-1-acme@kernel.org>
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
 tools/perf/util/evsel.h | 19 +++++++++++++++
 2 files changed, 72 insertions(+)

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
index 8009be22cc3f1055..163fc2b6a7eacca4 100644
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
@@ -397,8 +402,22 @@ struct tep_format_field;
 
 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);
 
+#ifdef HAVE_LIBTRACEEVENT
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name);
+#else
+static inline struct tep_format_field *
+evsel__field(struct evsel *evsel __maybe_unused, const char *name __maybe_unused)
+{
+	return NULL;
+}
+
+static inline struct tep_format_field *
+evsel__common_field(struct evsel *evsel __maybe_unused, const char *name __maybe_unused)
+{
+	return NULL;
+}
+#endif
 
 bool __evsel__match(const struct evsel *evsel, u32 type, u64 config);
 
-- 
2.54.0

