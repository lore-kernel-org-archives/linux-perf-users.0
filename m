Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749604;
	b=QhiKNnIIhfslCKpXTefeG0FLP5U4AQMPh0z3le0c0A8eTxejCWR81HXzs8gEnr9W0rmG
	 1TzLn+JatCzhmWlvGbNSv+MLBB2FD4I9wEOn1JM1gCOTkGg99e/cC/H9HWWIW6haMnKow
	 neCfC4uDfixQnIqtA0Ij+TdoTfeh/86T0UUMNJCXG9Bw5CiDfUb9slX3GdO55YZrzpv06
	 3kGmBXiKxD5yaojbWWcw4/VPdm/4MGm2EObo/O9ovDt9Hk0+KIWuQfP4Ay4ECH79Df9TM
	 OZ9ifyBzInBZ5RZobf/odGqFWTAXb95QRYcdTgKAc9edgkTMki5cjwSulJs2Nj5oTzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dfexYBXk5etmsl2zkwxtf2sW8TQ+h581CLafkhj4jsM=;
	b=bc81upVtvnaks+V5M3LpjuKNPBEbCEyJy1HANVcjVQcosfcmygq2CncX0bHUtpLjckUR
	 XRg7mEo+UsUpXBdZ2dVMqA/xl4cNUBW1O0YL9XVjUR1aMpL9YI5hehsEn2ep1lOOYCz0t
	 UCY3nuWi5oPs/6fPvAGhT0GpKQaPQjQKNlpyHM/ADrgRyVNLcetPvRNlsqo1TG/IkZEHC
	 ry4vM3xF9jD2xLZJm/+KZI3HW563To4ea7yKgrDQ9CBqqStLlh95VwzWBgasQu41NruQf
	 baJDAQ2CFnX3jP88ylboNP4dHB94NLfaeZIT2zW/jTUOX74J1FGuDQeSZ7yzi53cymg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RQ1ky6DV;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A860A3812
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5A860A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RQ1ky6DV
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a1e2485fdso144072eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749603; x=1794354403; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfexYBXk5etmsl2zkwxtf2sW8TQ+h581CLafkhj4jsM=;
        b=RQ1ky6DV0V0I3Knnp4p9Kn5thvo+f2c+W3KPz6vGfUtyWtgd+/bOfQT2OLBDh/LtQc
         e42rvSQ3Uom4ptfLBJCOJP5sj2W8FCP+C1bPSFaOuBjmHstMXoAJbJy5rW0LkTAezEsc
         ua/HDzA86eD61QxoVFCHsZJzm5S0EocSFE/yXzZnxcAGJOzXell6HsdSXcc1gdUtpasx
         vjMxhCvnQCo+bSJab2Pbr6rN9exwVcIR6QrJH4b7w6MTeJI+5NUVfKfp1XLPNMIU0xZW
         UUKxfaESPXnyhZw5LVHwe3vRvSWSy1dr70NYzbBUcHsFyj89Zf9DG8c4aHGD/9dBppba
         7rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749603; x=1794354403;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfexYBXk5etmsl2zkwxtf2sW8TQ+h581CLafkhj4jsM=;
        b=GE0YVFj0cuxEdeHCQWs8J+Vzerhoe3E9yVJv3GIgWwswXV8R0N6IgHclwOeF4iw6CH
         01yNM6vQ1D2tZN+CdZV3uFouF2SsRh0IhRAxGzq4levJ+S4XXDST2YtfBKrZRbAISFg5
         /ncyQtWja0D/JDXo+OZXPVMeZAd9XBqq09nxMI9tklOJuIIMMFkoIMIL8lypTfGaBojT
         kVGV5huFBRfr2hdIS7EVN7EKaZMhOo8eYDNsinIUKKP8al8/eTLw2ZQAJM4c0fKZfdzL
         TNanCimBci6WpHmc5ofG+ZFsKidP+KtM17pOVdkO7yC5cNt+dsGgmWsH50H687EyuSA2
         5GYg==
X-Gm-Message-State: APuU4Z99VZAWW0wRkf1O2iZzArV517c0x2PKzK54Xkamo5u52eDFKfmD
	izbRveqxifmS/wdlyved+wYHjzPbRz5e4xrgDnjlLTLnjiNBr1xZj4a3DBWlv5YtyAnFTvwEdUr
	bIsKEKgW57QL4tNzLczV5LlcSz4fT44zuqFecOCW7a48sIV57uReKrB4JTBfYDsF8Y9zgo5k78i
	b0c8F7yYcioOWPF2/eq+ovV+YGvFp1kN5ezbWyhT5+A80VF24yztigZPI=
X-Received: from dldd19.prod.google.com ([2002:a05:701a:c913:b0:19d:8ab5:5be5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f105:b0:141:5281:8a41
 with SMTP id a92af1059eb24-1ac5a2a3112mr16339059c88.9.1793749602692; Tue, 03
 Nov 2026 15:46:42 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:52 -0800
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
Message-ID: <20261103234502.1008382-37-irogers@google.com>
Subject: [PATCH v1 36/41] perf pmu: Probe memory profiling events and sample formats
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
index 294c5f02d3b8..bc3c821153b6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3646,6 +3646,142 @@ static void probe_pmu_regs_one(const struct perf_pmu *pmu,
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
@@ -4046,6 +4182,9 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.0.385.gac671c819a-goog

