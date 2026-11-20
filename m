Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213620;
	b=tQsRDrIz9hOiiS1ZT/MuLeargkgCN+OngVs0bQQ9FNNg31j9KzdV7JAn6P+20hqSCXqn
	 pRGe8dLYu5F+llPcn8d60tTBhRVlH+QorbZY9qPzw50w/OKThiIlZxBHFuruIaKMB+VCf
	 8e14QouglVjITiBGo4WUl8bzSFbuq258Wfpy3PhhgECzimbel6krA7xsmi9x4VI785YL0
	 pa8eDNVb5ekFjtMOzpd6QEeQ4wS1xFfC0RUKCFhpfblcFiHMdwddN1V/d3yhPdGTAF6Vm
	 mkKXKYKovv4jWV5fpaHOaB+U2OKhWHwbPHkH2GyR9/5h2F/FmEG+YQU1L1xcNfXOY8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=e32iL6f8BD46i5H3EYbcVjG/ZVXtuxRUMvq7INvVP4A=;
	b=LpgigPNzxKGvdidpMKDAbX87LSaRPkWtnW5BeUum6ileJS9sbgbEHY6A890nKJpRMncG
	 NX+rYSHFROQ4u3LGmzpChNvFWroSzJeMbidBKL5nzEvHmvooD3Mgw1nN+zlVlXl9mYf1B
	 CUZnarQcHo01VWwc5e6/WlwwXykMMlecqivtvK+9BykOmd5G7yJ69Tdt5oB43PthQzAJK
	 RbOwxGrfnKHo1DSrbHvj9e5B3FxBdQgafT/SYKg2mbr5QazhSYb2GG8LbjBm7XRsx/np3
	 vPXL6QOHftrl1kCUXNB14KQnzA+6Z/d7a/TGnnXrP9meW6dza1ZB0ZmNXDmXFyDF5ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VBsBtWcp;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BED606A691
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78BED606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VBsBtWcp
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-384c78aa0dbso1829461eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213617; x=1795818417; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e32iL6f8BD46i5H3EYbcVjG/ZVXtuxRUMvq7INvVP4A=;
        b=VBsBtWcpoP5ualFlXo8h86hcyoa9yiPjDPiOc3fb1BQG8cdZZI1D6Bz/7lbmoMAgOS
         zsQex3+ANBX6PRy6VkrDaWIaAunX83RHYCNc/jx6d4F1ZbVArLqbdBD96tJ0LK3BQ5mD
         uujib1JJFPh8UlcKjMznmtMBbhbf66jBc1MAAUix++epdHrsDO0GgUlgbDIwt9XsTG+c
         Q1VrzNH2FVqk45Fckn+DHGkntNaD+3XvFIf15nV9ngUBJyCevW23d5ZPyqfxWGl8ETwN
         CFGS/ZwmrmAi9dEIbFLDPGQAQB+gaIGRbMLujiPsJf3aXC2hMI99QkYpm3bVgjkMlJ4t
         AWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213617; x=1795818417;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e32iL6f8BD46i5H3EYbcVjG/ZVXtuxRUMvq7INvVP4A=;
        b=yfQqzPG7Sb77Rbqw/TYmGeaRvDhAuSwGNbdEDUKDH5FG4bkA90EJuhuRGta7iokz2L
         k3McLC3dB5lu/QgxO1pUNxX+xsJ73T+z9Db6S76JXLu7oaFu92ROMdtbqD2pv8Gt5lTH
         uVpB8XX2G+FMR7JNTEWK5Id5zBk4EYO+/oEvHmADklPF7Z1k1rVVTDH02GBWiyUW4NOj
         9FgGEZuQaDxqqoMZTH1d3OpbCJNIPbkXjXwqWsEIrMl+70+lua++5dw379TweKjygRmw
         qxCR+uF0fhAFTO6elAobidG7ydSeB4muk2cxTlLzm2a34iYmSR9Slfp4kp07lvDWnxia
         jshw==
X-Gm-Message-State: APuU4Z+a+x4VQgAxdyh0O4kRv25qGsfayF5OhFvEtYXNdTsO5Cwu+SIS
	ki934gt/QahcWKBzt82SMuScmJsypuui5Bv3KFpvayoWa5XSUcAz8NW2T4LuKY3Lv5kgszesVIw
	oeq/MXbuwSw==
X-Received: from dyclx1.prod.google.com ([2002:a05:693c:2181:b0:36e:f67b:23ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:391c:b0:379:f7aa:1013
 with SMTP id 5a478bee46e88-3856fd59fcemr4266843eec.15.1795213617260; Fri, 20
 Nov 2026 14:26:57 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:06 -0800
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120222615.2291168-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120222615.2291168-8-irogers@google.com>
Subject: [PATCH v3 07/16] perf pmu: Probe execution and AUX area features
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() to probe event execution and grouping features
via perf_event_open() and ioctl(PERF_EVENT_IOC_ENABLE):

 - Group leader sampling (PERF_SAMPLE_READ with PERF_FORMAT_GROUP)
 - Grouping software events with the PMU's events (can_sw_grouping)
 - Child task inheritance (attr.inherit)
 - Dynamic frequency mode (attr.freq)
 - Overwrite ring buffer mode (attr.write_backward)
 - Pinned and exclusive event attributes (attr.pinned, attr.exclusive)
 - Lost-event read format (PERF_FORMAT_LOST)
 - Auto-counter reload when the PMU exposes format/acr_mask (can_acr)
 - AUX area actions on auxtrace PMUs (aux_start_paused, aux_pause,
   aux_resume, and PERF_SAMPLE_AUX snapshot sampling)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 338 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  32 ++++
 2 files changed, 370 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 49e3c66c94f1..eacb8719f801 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2870,6 +2870,7 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	free(pmu);
 }
 
+#define MAX_PROBE_GROUP_SIZE 64
 #define MAX_PROBE_CANDIDATES 16
 #define MAX_TRACEPOINT_PROBE_CANDIDATES 3
 
@@ -3289,12 +3290,52 @@ static void probe_sample_types(struct perf_pmu *pmu,
 	pmu->probed.can_weight = !!(pmu->probed.sample_types & PERF_SAMPLE_WEIGHT);
 }
 
+/*
+ * Pack @value into the perf_event_attr config field named by the sysfs format
+ * @name of @pmu, e.g. "rdpmc" defined as "config1:1". Returns false if the
+ * format doesn't exist or uses an unsupported config field.
+ */
+static bool probe_format_pack(const struct perf_pmu *pmu, struct perf_event_attr *attr,
+			      const char *name, __u64 value)
+{
+	struct perf_pmu_format *format = pmu_find_format(&pmu->format, name);
+	__u64 *vp;
+
+	if (!format)
+		return false;
+
+	perf_pmu_format__load(pmu, format);
+	switch (format->value) {
+	case PERF_PMU_FORMAT_VALUE_CONFIG:
+		vp = &attr->config;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG1:
+		vp = &attr->config1;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG2:
+		vp = &attr->config2;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		vp = &attr->config3;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		vp = &attr->config4;
+		break;
+	default:
+		return false;
+	}
+	perf_pmu__format_pack(format->bits, value, vp, /*zero=*/true);
+	return true;
+}
+
 static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 {
 	struct probe_candidates cands = { .nr = 0 };
 	struct perf_event_attr base_attr;
+	struct perf_event_attr group_attrs[MAX_PROBE_GROUP_SIZE];
 	char uprobe_exe_path[PATH_MAX];
 	__u64 uprobe_offset = 0;
+	size_t nr_group_attrs = 0;
 	unsigned long flags = perf_event_open_cloexec_flag();
 	int keepalive_fd = -1;
 	pid_t pid = 0;
@@ -3520,6 +3561,48 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 		keepalive_fd = sys_perf_event_open(&ka_attr, pid, cpu, -1, flags);
 	}
 
+	group_attrs[nr_group_attrs++] = base_attr;
+
+	for (size_t i = 0; pmu->type != PERF_TYPE_TRACEPOINT &&
+	     i < cands.nr && nr_group_attrs < MAX_PROBE_GROUP_SIZE; i++) {
+		struct perf_event_attr cand_attr;
+		int fd;
+		bool dup = false;
+
+		memset(&cand_attr, 0, sizeof(cand_attr));
+		if (!parse_candidate_attr(cands.names[i], &cand_attr))
+			continue;
+
+		cand_attr.sample_period = base_attr.sample_period;
+		cand_attr.freq = base_attr.freq;
+		cand_attr.sample_type = base_attr.sample_type;
+		cand_attr.exclude_user = base_attr.exclude_user;
+		cand_attr.exclude_kernel = base_attr.exclude_kernel;
+		cand_attr.exclude_hv = base_attr.exclude_hv;
+		cand_attr.exclude_idle = base_attr.exclude_idle;
+		cand_attr.exclude_host = base_attr.exclude_host;
+		cand_attr.exclude_guest = base_attr.exclude_guest;
+		cand_attr.disabled = 1;
+
+		for (size_t j = 0; j < nr_group_attrs; j++) {
+			if (group_attrs[j].type == cand_attr.type &&
+			    group_attrs[j].config == cand_attr.config &&
+			    group_attrs[j].config1 == cand_attr.config1 &&
+			    group_attrs[j].config2 == cand_attr.config2) {
+				dup = true;
+				break;
+			}
+		}
+		if (dup)
+			continue;
+
+		fd = sys_perf_event_open(&cand_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			group_attrs[nr_group_attrs++] = cand_attr;
+		}
+	}
+
 	probe_candidates__exit(&cands);
 
 	/* 1. Counting vs Sampling support */
@@ -3618,6 +3701,261 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 	pmu->probed.exclude_guest =
 		test_exclude_flag(&base_attr, pid, cpu, flags, PROBE_EXCLUDE_GUEST);
 
+	/* 5. Execution features */
+	if (pmu->probed.can_sample) {
+		struct perf_event_attr l_attr = base_attr;
+		struct perf_event_attr f_attr = nr_group_attrs > 1 ? group_attrs[1] : base_attr;
+		int l_fd;
+
+		l_attr.disabled = 1;
+		l_attr.sample_period = 10000;
+		l_attr.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_READ;
+		l_attr.read_format = PERF_FORMAT_GROUP | PERF_FORMAT_ID;
+
+		f_attr.disabled = 0;
+		f_attr.sample_period = 0;
+		f_attr.sample_type = 0;
+		f_attr.read_format = 0;
+
+		l_fd = sys_perf_event_open(&l_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			int f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+
+			if (f_fd >= 0) {
+				if (ioctl(l_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP) >= 0)
+					pmu->probed.can_leader_sampling = true;
+				ioctl(l_fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
+				close(f_fd);
+			}
+			close(l_fd);
+		}
+	}
+
+	{
+		struct perf_event_attr l_attr = base_attr;
+		int l_fd;
+
+		l_attr.disabled = 1;
+		l_fd = sys_perf_event_open(&l_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			struct perf_event_attr sw_attr;
+			int sw_fd;
+
+			memset(&sw_attr, 0, sizeof(sw_attr));
+			sw_attr.type = PERF_TYPE_SOFTWARE;
+			sw_attr.size = sizeof(sw_attr);
+			sw_attr.config = PERF_COUNT_SW_DUMMY;
+			sw_attr.disabled = 0;
+			sw_attr.exclude_user = base_attr.exclude_user;
+			sw_attr.exclude_kernel = base_attr.exclude_kernel;
+			sw_attr.exclude_hv = base_attr.exclude_hv;
+			sw_attr.exclude_idle = base_attr.exclude_idle;
+			sw_attr.exclude_host = base_attr.exclude_host;
+			sw_attr.exclude_guest = base_attr.exclude_guest;
+
+			sw_fd = sys_perf_event_open(&sw_attr, pid, cpu, l_fd, flags);
+			if (sw_fd < 0) {
+				sw_attr.config = PERF_COUNT_SW_CPU_CLOCK;
+				sw_fd = sys_perf_event_open(&sw_attr, pid, cpu, l_fd, flags);
+			}
+			if (sw_fd >= 0) {
+				pmu->probed.can_sw_grouping = true;
+				close(sw_fd);
+			}
+			close(l_fd);
+		}
+	}
+
+	{
+		struct perf_event_attr inh_attr = base_attr;
+		int fd;
+
+		inh_attr.disabled = 1;
+		inh_attr.inherit = 1;
+		/*
+		 * Inheritance only applies to task events, CPU events (pid
+		 * -1) accept but ignore it, so probe with the current task.
+		 */
+		fd = sys_perf_event_open(&inh_attr, /*pid=*/0, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_inherit = true;
+		}
+	}
+
+	if (pmu->probed.can_sample) {
+		struct perf_event_attr freq_attr = base_attr;
+		int fd;
+
+		freq_attr.disabled = 1;
+		freq_attr.freq = 1;
+		/* A low frequency is below perf_event_max_sample_rate. */
+		freq_attr.sample_freq = 1;
+		freq_attr.sample_type = PERF_SAMPLE_IP;
+		fd = sys_perf_event_open(&freq_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_freq = true;
+		}
+	}
+
+	if (pmu->probed.can_sample) {
+		struct perf_event_attr wb_attr = base_attr;
+		int fd;
+
+		wb_attr.disabled = 1;
+		wb_attr.sample_period = 10000;
+		wb_attr.sample_type = PERF_SAMPLE_IP;
+		wb_attr.write_backward = 1;
+		fd = sys_perf_event_open(&wb_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_write_backward = true;
+		}
+	}
+
+	{
+		struct perf_event_attr pin_attr = base_attr;
+		int fd;
+
+		pin_attr.disabled = 1;
+		pin_attr.pinned = 1;
+		fd = sys_perf_event_open(&pin_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_pinned = true;
+		}
+	}
+
+	{
+		struct perf_event_attr exc_attr = base_attr;
+		int fd;
+
+		exc_attr.disabled = 1;
+		exc_attr.exclusive = 1;
+		fd = sys_perf_event_open(&exc_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_exclusive = true;
+		}
+	}
+
+	{
+		struct perf_event_attr lost_attr = base_attr;
+		int fd;
+
+		lost_attr.disabled = 1;
+		lost_attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+					PERF_FORMAT_TOTAL_TIME_RUNNING |
+					PERF_FORMAT_LOST;
+		fd = sys_perf_event_open(&lost_attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			pmu->probed.can_format_lost = true;
+		}
+	}
+
+	/* 5c. Auto-counter reload (acr_mask / ratio-to-prev) */
+	if (pmu->probed.can_sample && perf_pmu__has_format(pmu, "acr_mask")) {
+		struct perf_event_attr l_attr = base_attr;
+		struct perf_event_attr f_attr = nr_group_attrs > 1 ? group_attrs[1] : base_attr;
+		int l_fd;
+
+		l_attr.disabled = 1;
+		l_attr.freq = 0;
+		l_attr.sample_period = 200000;
+		l_attr.sample_type = PERF_SAMPLE_IP;
+
+		f_attr.disabled = 0;
+		f_attr.freq = 0;
+		f_attr.sample_period = 100000;
+		f_attr.sample_type = PERF_SAMPLE_IP;
+
+		/*
+		 * Equivalent of the group
+		 * '{cycles/acr_mask=0x2/,cycles/acr_mask=0x3/}'.
+		 */
+		if (probe_format_pack(pmu, &l_attr, "acr_mask", 0x2) &&
+		    probe_format_pack(pmu, &f_attr, "acr_mask", 0x3))
+			l_fd = sys_perf_event_open(&l_attr, pid, cpu, -1, flags);
+		else
+			l_fd = -1;
+		if (l_fd >= 0) {
+			int f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+
+			if (f_fd >= 0) {
+				if (ioctl(l_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP) >= 0)
+					pmu->probed.can_acr = true;
+				ioctl(l_fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
+				close(f_fd);
+			}
+			close(l_fd);
+		}
+	}
+
+	/* 5d. AUX area event actions (start_paused, pause, resume, aux_sample) */
+	if (pmu->auxtrace) {
+		struct perf_event_attr a_attr = base_attr;
+		int l_fd;
+
+		a_attr.size = max_t(__u32, base_attr.size, PERF_ATTR_SIZE_VER8);
+		a_attr.disabled = 1;
+		a_attr.aux_start_paused = 1;
+		l_fd = sys_perf_event_open(&a_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			close(l_fd);
+			pmu->probed.can_aux_start_paused = true;
+		}
+
+		a_attr = base_attr;
+		a_attr.disabled = 1;
+		l_fd = sys_perf_event_open(&a_attr, pid, cpu, -1, flags);
+		if (l_fd >= 0) {
+			struct perf_event_attr f_attr;
+			int f_fd;
+
+			memset(&f_attr, 0, sizeof(f_attr));
+			f_attr.type = PERF_TYPE_SOFTWARE;
+			f_attr.size = max_t(__u32, base_attr.size, PERF_ATTR_SIZE_VER8);
+			f_attr.config = PERF_COUNT_SW_CPU_CLOCK;
+			f_attr.sample_period = 10000;
+			f_attr.sample_type = PERF_SAMPLE_IP;
+			f_attr.exclude_user = base_attr.exclude_user;
+			f_attr.exclude_kernel = base_attr.exclude_kernel;
+			f_attr.exclude_hv = base_attr.exclude_hv;
+			f_attr.exclude_idle = base_attr.exclude_idle;
+			f_attr.exclude_host = base_attr.exclude_host;
+			f_attr.exclude_guest = base_attr.exclude_guest;
+
+			f_attr.aux_pause = 1;
+			f_attr.aux_resume = 0;
+			f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+			if (f_fd >= 0) {
+				close(f_fd);
+				pmu->probed.can_aux_pause = true;
+			}
+
+			f_attr.aux_pause = 0;
+			f_attr.aux_resume = 1;
+			f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+			if (f_fd >= 0) {
+				close(f_fd);
+				pmu->probed.can_aux_resume = true;
+			}
+
+			f_attr.aux_resume = 0;
+			f_attr.sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_AUX;
+			f_attr.aux_sample_size = 64;
+			f_fd = sys_perf_event_open(&f_attr, pid, cpu, l_fd, flags);
+			if (f_fd >= 0) {
+				close(f_fd);
+				pmu->probed.can_aux_sample = true;
+			}
+
+			close(l_fd);
+		}
+	}
+
 	if (keepalive_fd >= 0)
 		close(keepalive_fd);
 	pmu->probed.checked = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index a7d794d67bf2..8efffbac3cbf 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -228,12 +228,44 @@ struct perf_pmu {
 		bool can_sample;
 		/** @probed.can_branch_stack: Supports PERF_SAMPLE_BRANCH_STACK. */
 		bool can_branch_stack;
+		/** @probed.can_leader_sampling: Supports group leader sampling (:S). */
+		bool can_leader_sampling;
+		/**
+		 * @probed.can_sw_grouping: Supports grouping software events
+		 * with this PMU's events.
+		 */
+		bool can_sw_grouping;
+		/** @probed.can_inherit: Supports perf_event_attr::inherit across child tasks. */
+		bool can_inherit;
+		/** @probed.can_freq: Supports dynamic sample frequency (perf_event_attr::freq). */
+		bool can_freq;
+		/** @probed.can_write_backward: Supports overwrite ring buffer (write_backward). */
+		bool can_write_backward;
 		/** @probed.can_callchain: Supports PERF_SAMPLE_CALLCHAIN. */
 		bool can_callchain;
 		/** @probed.can_data_src: Supports PERF_SAMPLE_DATA_SRC. */
 		bool can_data_src;
 		/** @probed.can_weight: Supports PERF_SAMPLE_WEIGHT. */
 		bool can_weight;
+		/** @probed.can_pinned: Supports perf_event_attr::pinned. */
+		bool can_pinned;
+		/** @probed.can_exclusive: Supports perf_event_attr::exclusive. */
+		bool can_exclusive;
+		/** @probed.can_format_lost: Supports PERF_FORMAT_LOST. */
+		bool can_format_lost;
+		/** @probed.can_acr: Supports auto-counter reload (acr_mask / ratio-to-prev). */
+		bool can_acr;
+		/**
+		 * @probed.can_aux_start_paused: Supports aux_start_paused
+		 * (PERF_PMU_CAP_AUX_PAUSE).
+		 */
+		bool can_aux_start_paused;
+		/** @probed.can_aux_pause: Supports aux_pause action on group followers. */
+		bool can_aux_pause;
+		/** @probed.can_aux_resume: Supports aux_resume action on group followers. */
+		bool can_aux_resume;
+		/** @probed.can_aux_sample: Supports AUX area snapshot sampling. */
+		bool can_aux_sample;
 		/** @probed.exclude_user: Supports perf_event_attr::exclude_user. */
 		bool exclude_user;
 		/** @probed.exclude_kernel: Supports perf_event_attr::exclude_kernel. */
-- 
2.56.1.750.gf70dc682cf-goog

