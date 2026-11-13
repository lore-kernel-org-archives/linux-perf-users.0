Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599794;
	b=dTGYWbQRMMC3/qccNRoCBtBB3B5ViXugtarL0Q5Q62v9509zruaEc9cfCXRSRO/4dwA9
	 VjQMw/tyiGGrTwi8QekvUNxVh5/XfBn2W6nPMFqPJPVTeVWZdndksTh5Ka3THKd9BCB5R
	 26/hZuopn69f+hFRNUfzzM0VvBF07txgkHSnzujELrzciTzaexCZnMY4xXf5H+3YN7HPr
	 9vdwiOgPJgBdsbqdzT5j2H5Z3X9GOkKMJ0CJ5JKwAmjJxD/jyut3C0ZAybXnNRWQIzGsV
	 2nmiPtAwSwL8WRDXEcJwmVLpBLP0CybWTgW/HH0Sjp9gn/1QnFXO7UaD7ZNbEwd3NXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6DfreFz7WlDQRhWElU93m9m7uq8k9MNAGFQ/T52xNpA=;
	b=GnJohCF+vO3YXLO4ZKNnRgWThzzC1GcNrC95O0oKeMI3Bzn1j1qHuN3Em25ymF+psFdA
	 pg2lMj2OLkIsckztL/oGPTZwttae/vgXCEDKxxj/fmEqc/PYmxNsdA7Ow4yFh7sh51Wmw
	 LFOcVPOji+Zc01MHlsVROq9kdXFAe3+7hpSizgbmJuZqfzF4zEUPevS4s+dQvUJz2JNqI
	 +Qfu6gMhnQzCBsc/Wx81OKbOyOygumodlwXgZsBKgZCZXKUmm7u2BJw+YdzkyDZRlPZGx
	 9RyehcXG2ILC3+in5YcYGdtrN7wXNSYcUlvxUyy0PYHjaaqCz4gHff3HLyvEVAXEDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GvIkChEs;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB020606F378
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB020606F378
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GvIkChEs
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-567e742f481so838802b6e.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599793; x=1795204593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DfreFz7WlDQRhWElU93m9m7uq8k9MNAGFQ/T52xNpA=;
        b=GvIkChEs0eI7TLyNNTrmK7N9SUOTxEcIOxbyZpCRsSmwB9KRtTYVAjakrKF0HxEbM+
         9jC4ggZnG5/5qP/+rmFCEesdcZ7e4japQ6ibRvLzILYLqUCYQRmMCNJK7f5vVQST986S
         hePXjtTbmrE6P6BN+1vtSkMrnjPyhTDdJoDxqskaso4ky5/OgCCuZA/q16AZ5S+PGOBF
         RuXU35kBAz+NZmF3PdaIFTsYNgecOBivbGP+IqsUJPTww5wDgj1Rzt/szEwvtxnfuAbi
         lLQ5s7Ic3UwP/AIHy1yhr9/DasZVrEzCLy1aYwUkX7NlraOSUawPtJKPxK6NiNq+k2w1
         lrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599793; x=1795204593;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DfreFz7WlDQRhWElU93m9m7uq8k9MNAGFQ/T52xNpA=;
        b=NG5m6WG9285O3AH5krvY2pC2WzYzIu0YkxCfZQFtoRQ10dtq50X27i79YtNWFMdgEp
         ZWqnC79ZfxuPFNLqYpdxr7fBTconXTkLHzDO2lFskaE+RVlQwnizF9/dCVlDvVdDdXtN
         5gViLBoMG4I5FXCUPTV0pL1/jgHRyxFNP/pnRH4HAR/lDY4zZHXWlmJYtjE/jbSZl5D5
         6VF89BLW5s08K+u+sed+2TfVW4HSB6WhEwiwkItApmDUXHPrdVfnDqul2GofbraVNRK3
         YOcdIjsGF1yu3HwAumNj0t1Q3OS0g7lxZav/QFaoOkNEXOfwWO481DDigSRjf8PEvNmI
         M+Xg==
X-Gm-Message-State: APuU4Z96OxxYWliUjX2yMf1cQQ5uPm/K1Acr8vQpVFIJ5h00bgtMTlHd
	q5dZ9rlilQR13sG1BA7dxf13lGuhBzdEdCA8guY02/Xh1HtZjppSsPcXSzDjXtp/Lo+jufEeabD
	PQZkhjN2elg==
X-Received: from ilec16-n2.prod.google.com ([2002:a05:6e02:6150:20b0:549:aa38:c1ba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1816:b0:53a:8c5:d7d7
 with SMTP id 5614622812f47-56e6626d27cmr2851925b6e.58.1794599792582; Fri, 13
 Nov 2026 11:56:32 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:56 -0800
In-Reply-To: <20261113195601.2872738-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195601.2872738-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195601.2872738-12-irogers@google.com>
Subject: [PATCH v2 11/16] perf pmu: Probe memory profiling events and sample formats
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() with try_open_mem_evlist() and
probe_mem_events() to test which perf_mem_events types (such as
ldlat-loads and ldlat-stores) can be opened on the PMU and which
additional memory sample formats (PERF_SAMPLE_WEIGHT,
PERF_SAMPLE_WEIGHT_STRUCT, PERF_SAMPLE_PHYS_ADDR,
PERF_SAMPLE_DATA_PAGE_SIZE, PERF_SAMPLE_TRANSACTION) are supported with
them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 139 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |   7 +++
 2 files changed, 146 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 80159358318e..45c557c85c5e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3652,6 +3652,142 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
 		*out_pred_precise_mask = pred_precise_mask;
 }
 
+static bool try_open_mem_evlist(struct evlist *evlist,
+				const struct perf_event_attr *base_attr,
+				pid_t pid, int cpu, unsigned long flags,
+				int precise_ip, u64 sample_type)
+{
+	int fds[16];
+	size_t nr_fds = 0;
+	int leader_fd = -1;
+	struct evsel *evsel;
+	bool ok = true;
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct perf_event_attr attr = evsel->core.attr;
+		int fd;
+
+		if (nr_fds >= ARRAY_SIZE(fds)) {
+			ok = false;
+			break;
+		}
+
+		attr.disabled = (leader_fd < 0) ? 1 : 0;
+		attr.sample_period = attr.sample_period ?: 10000;
+		attr.sample_type = sample_type;
+		attr.exclude_user = base_attr->exclude_user;
+		attr.exclude_kernel = base_attr->exclude_kernel;
+		attr.exclude_hv = base_attr->exclude_hv;
+		attr.exclude_idle = base_attr->exclude_idle;
+		attr.exclude_host = base_attr->exclude_host;
+		attr.exclude_guest = base_attr->exclude_guest;
+		if (evsel->precise_max || precise_ip > 0)
+			attr.precise_ip = precise_ip;
+
+		fd = sys_perf_event_open(&attr, pid, cpu, leader_fd, flags);
+		if (fd < 0) {
+			ok = false;
+			break;
+		}
+		if (leader_fd < 0)
+			leader_fd = fd;
+		fds[nr_fds++] = fd;
+	}
+
+	for (size_t i = nr_fds; i > 0; i--)
+		close(fds[i - 1]);
+
+	return ok && nr_fds > 0;
+}
+
+/*
+ * Probe which perf_mem_events types (e.g. ldlat-loads, ldlat-stores) and
+ * additional memory sample formats can be opened on @pmu.
+ */
+static void probe_mem_events(struct perf_pmu *pmu,
+			     const struct perf_event_attr *base_attr,
+			     pid_t pid, int cpu, unsigned long flags)
+{
+	static const u64 extra_mem_stypes[] = {
+		PERF_SAMPLE_WEIGHT,
+		PERF_SAMPLE_WEIGHT_STRUCT,
+		PERF_SAMPLE_PHYS_ADDR,
+		PERF_SAMPLE_DATA_PAGE_SIZE,
+		PERF_SAMPLE_TRANSACTION,
+	};
+
+	if (!pmu->mem_events)
+		return;
+
+	perf_pmu__mem_events_init_pmu(pmu);
+
+	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
+		const char *s;
+		char buf[256];
+		struct evlist *evlist;
+		struct parse_events_error err;
+		struct evsel *first;
+		int max_p, min_p, working_p = -1;
+		u64 base_stype = PERF_SAMPLE_IP | PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC;
+		int ret;
+
+		if (!e || !e->tag || !e->supported)
+			continue;
+
+		s = perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf));
+		if (!s)
+			continue;
+
+		evlist = evlist__new();
+		if (!evlist)
+			continue;
+
+		parse_events_error__init(&err);
+		ret = __parse_events(evlist, s, /*pmu_filter=*/NULL,
+				     /*cputype_filter=*/false, &err, /*fake_pmu=*/false,
+				     /*warn_if_reordered=*/false, /*fake_tp=*/false);
+		parse_events_error__exit(&err);
+		if (ret || evlist__empty(evlist)) {
+			evlist__put(evlist);
+			continue;
+		}
+
+		first = evlist__first(evlist);
+		if (first->precise_max) {
+			max_p = pmu->probed.max_precise > 0 ? pmu->probed.max_precise : 3;
+			min_p = 1;
+		} else {
+			max_p = first->core.attr.precise_ip;
+			min_p = first->core.attr.precise_ip;
+		}
+
+		for (int p = max_p; p >= min_p; p--) {
+			if (try_open_mem_evlist(evlist, base_attr, pid, cpu,
+						flags, p, base_stype)) {
+				working_p = p;
+				break;
+			}
+		}
+
+		if (working_p >= 0) {
+			pmu->probed.mem_events_mask |= (1u << j);
+			pmu->probed.mem_sample_types |= PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC;
+
+			for (size_t k = 0; k < ARRAY_SIZE(extra_mem_stypes); k++) {
+				u64 st = base_stype | extra_mem_stypes[k];
+
+				if (try_open_mem_evlist(evlist, base_attr, pid, cpu,
+							flags, working_p, st)) {
+					pmu->probed.mem_sample_types |= extra_mem_stypes[k];
+				}
+			}
+		}
+
+		evlist__put(evlist);
+	}
+}
+
 /*
  * Pack @value into the perf_event_attr config field named by the sysfs format
  * @name of @pmu, e.g. "rdpmc" defined as "config1:1". Returns false if the
@@ -4073,6 +4209,9 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 				   &pmu->probed.intr_pred_precise_mask);
 	}
 
+	/* 3c. Memory event types and memory sample formats */
+	probe_mem_events(pmu, &base_attr, pid, cpu, flags);
+
 	/* 4. Privilege / exclusion modifiers */
 	pmu->probed.exclude_user =
 		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_USER);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 21c4b1a4b608..ee56570cac00 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -304,11 +304,18 @@ struct perf_pmu {
 		int user_regs_abi;
 		/** @probed.intr_regs_abi: ABI flags for intr_regs_mask. */
 		int intr_regs_abi;
+		/** @probed.mem_events_mask: Bitmask of memory event types verified by probing. */
+		unsigned int mem_events_mask;
 		/**
 		 * @probed.sample_types: Bitmask of supported
 		 * enum perf_event_sample_format flags.
 		 */
 		u64 sample_types;
+		/**
+		 * @probed.mem_sample_types: Bitmask of memory sample formats
+		 * verified on mem_events.
+		 */
+		u64 mem_sample_types;
 		/** @probed.user_regs_mask: Bitmask of supported sample_regs_user registers. */
 		u64 user_regs_mask;
 		/** @probed.intr_regs_mask: Bitmask of supported sample_regs_intr registers. */
-- 
2.56.1.703.gf848ed807c-goog

