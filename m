Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749595;
	b=LHeB4nfNjj1q10+vSBgmrzrpRPhpmB6LlXUyvSpaAtP5zyRILd64yamtLkx5l8JW3R2s
	 mW6UIBmrXue+xtqwa97AD1pO7AV4MYg1hpSgLrKUR9mSgyF7TQAocTLUmTxuf5A+AZBMC
	 lNoAfhjuGIzjdNKrTewTnp4zoBumZ76ZjMKURnS/EmqlBU13azE0lwer750p5o65JeAX/
	 c5ZAWV6BLalPiU+Qm9T9RZCNFO7iDRTvYCxTEDnMz7jaGmJo3hkjxwRrR0S2/TarMlevP
	 JwqSddFaw7qH+GE7rBiQ6nKO+G42K12dih62PbeqjJPN8bjr95tjcWR7LsW+Lk6KHtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=FqDE+361bdIzZA1kvRGMeKvyBziZVrZONXC3i36R9qE=;
	b=ezp8IFpqZsoBT/c1qVAoJL3rb1rI2kOkbx+ec40mPLHT3TsoORvnyUDRIGM+QKr15zTD
	 B9ofdAIgneeF37l1yJwyzc0Gby2CvrgF5eEm/gko2a31iDro6yfkty8YY5gj66dXJ8M2F
	 7hpDrw9zEQ7KasAWZ+HpPZTvAKvJzftSen7zY0cGe/EHr8z9uO4n5Y/sQKJ8XSOTVOVZg
	 EPHmm5iLOr6dTLHpAxTZVUfimVkSyyV4Rlq+qniNsGWG4+4rsU78EuZmyxIZ/U1NTsdbE
	 Mg2DEAcHakyEUqNE+rTsUj30B7KEUcCjw8LMYA9klBW4RWeBcxZ4l7YzySxn6hSULMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GxakPxP5;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6983606D83F
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6983606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GxakPxP5
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1acbaf81bebso225472c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749594; x=1794354394; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FqDE+361bdIzZA1kvRGMeKvyBziZVrZONXC3i36R9qE=;
        b=GxakPxP5Uu3Crc3BrXuvh7K8MbN2NFyt/V0XjfbqAZr1TqU8Lb37+O30D5NObUsRKP
         x9p8aqMTa2ZyIalANZ44AcaLRvJMbu6YiolHEKMbk8VFQikBNON01BJftrGcuIUJAX+X
         Rs5ZqvmOTis+v8q8AaaU+VswEFS2aA0QLAFkwqjscbuMCTxdbYE1watvrfcykfdVS16U
         En/lyjsfEC0SDm4pDw6iyRuRCe33UQmji6yC5WuyD3StOmrS2ouWIULEfnkRe5ZJNiTB
         M1gTpczqxay8yT0p+8BPdgoSxmvg0jQUpVBzptsFh+xH8PZQ3bE/UUFayKzLxcSZRpzT
         EZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749594; x=1794354394;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqDE+361bdIzZA1kvRGMeKvyBziZVrZONXC3i36R9qE=;
        b=XIFIll6Ih4LXHk6NncbeFATMklCo5yTEJO51SnS5vDKOeWpzh/yU2leJR15jN0PL3i
         RlD7lHM+k3NukI69Rx9R+dKA5v1HZUKaAiKZ6x5GOlYjkBCL0uuFM8JbAukr7ujrsQzV
         jGggKtxG0mGA5vuyWID+qBxtzDkRW4tsHWL9KKiYwIPoZ8ismLsktrRqSWmY7M2nXjHq
         u0ptVLBuFZ+ewfQ9oCoW05+ZcezJ3Xxwys46zX5pmP2czJAXND/CXWpjEm1KO6xBR3Xf
         eTatC0YUEOsjjfVD4QmzIghM05+4wINfFv7BALGYUMRcDFRgNr/peqyyX6l0Gv6Jjw8i
         b5+Q==
X-Gm-Message-State: APuU4Z8czADfQ6nxm/N0+ZdrvkOpS6tt/w5AQ9sG+seodSStdN2U0w/K
	ocjn7g0KheCGj+NU9+FDMIayaWB0/0tbkL/Ze65DS1DrSyQIunr7QlSCPUlRuke2SJsnQP1xP0X
	4lMHSrso9qdk1ZbT7vCCRIQ0dq/z0qPImnBsYu4IxyjwGveTmter5IJCBCyqvNrClUWu9TEO8Da
	q4U0x8A/4tlG+wuvjtVH8fqL/Ikfaihi312wekXibjhrjov4lDkrrr4yo=
X-Received: from dldyr8-n2.prod.google.com ([2002:a05:701b:4508:20b0:1b2:43f5:b296])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:92b:b0:144:fb42:52
 with SMTP id a92af1059eb24-1ac5de4e892mr26245287c88.28.1793749592198; Tue, 03
 Nov 2026 15:46:32 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:48 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-33-irogers@google.com>
Subject: [PATCH v1 32/41] perf pmu: Probe execution and AUX area features
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
 tools/perf/util/pmu.c | 333 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  32 ++++
 2 files changed, 365 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a1e27e678ccf..e7e05e29b695 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2858,6 +2858,7 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	free(pmu);
 }
 
+#define MAX_PROBE_GROUP_SIZE 64
 #define MAX_PROBE_CANDIDATES 16
 
 static unsigned long dummy_bp_var;
@@ -3268,12 +3269,52 @@ static void probe_sample_types(struct perf_pmu *pmu,
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
@@ -3488,6 +3529,48 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
@@ -3576,6 +3659,256 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
+		fd = sys_perf_event_open(&inh_attr, pid, cpu, -1, flags);
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
+		freq_attr.sample_freq = 4000;
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
2.56.0.385.gac671c819a-goog

