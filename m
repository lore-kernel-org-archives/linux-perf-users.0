Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599799;
	b=MoJSL3qoVffiOGogexfe1KhoWRtZg7xDbfWhiaGmtGh2C9JYgVOCcuXqdARcq2z6TjjA
	 KhJXaEUpnb16Bc770iBjKcgUdM+oFbeioxqY9JO27H1U18sCj047z5c/qZ4Q3D9vTY69a
	 /7jVwlMHfmQ8NFZubi5Da8pgnydEksrNWNqNx6mmZ2vrc//u0M7qEB6pVS2zLsC490xGd
	 fC5yIliZN4gvm9qVZAemrgneJk/W8ZDwZ13Z0U+QJ2RXRgiizbGb8kiQL8cGF+hPNuqi7
	 FHKXuwEcoLMJplifgB8sQYL4D2NPHmefFWpzYlhmknWt7pujdCdZLajcl0hL/eLq3EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=UcL/o0gLFgKjfaSHFlON0JxVCm55Q7Iu8bvskJ2RQYk=;
	b=32NVUlC9lp6KTo8fZZ6K7vBQTXh9NKBFo8/ZG39IS/5Fmb1OhpLXOmxh4UJFneiaLdkA
	 G3XRDEgEv8TBV+JGh3r2doSeREW8A7vEjshMAq7NUx/oK0qTwuPmAUkqeFe9CKf47Uucv
	 T9NQz70F6KiGYiibxrGanh4MHeTAHEtAuEK71eondwzHzqMAE0MHp/UuKG10PW0BjPAYt
	 WP1MnO1hzgYD66ExJrZw+/dVC4kygC+SXAvB83r5YLy2ctXiTs/CehmB4wBhRiSnu1bnz
	 E5KeW3L3U9VCrWlZ3JZtZiDepkfFChuN5EF+WP2Jkq0W/0xDnRliVeed2P/KLeFLZuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ip73ItuR;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B066070443
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17B066070443
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ip73ItuR
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3b5b49cabso1248786c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599798; x=1795204598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UcL/o0gLFgKjfaSHFlON0JxVCm55Q7Iu8bvskJ2RQYk=;
        b=ip73ItuR+8IfG1VSJrOSHyVzLscXHaXoUSaOEscnertGWVuUu223ukTO5lF1iJ5b2i
         hGCE0QB8Sqg8MZa+IfgXasbsjRPVeeeSPJ2hRjHE+jcdtUA1CzwWjJvcUQJcKn8XUkSR
         Myix3ByN9pt6fjme6FnyySrEekZBFDXKFxR8p1r8dAwDiQoUMjeqTAEXTuVcFsm6QMFK
         mIArxl/vqnjd1OYT+Ux2WxqCdkI3Z7MAiVqxl1b6a03iH7wbaB8ImTBUxolDl556N5IS
         KfzGTi7tKRfjunkohcMybL3wUGcjbKmvspDGnivZC80mQw52uL4JJbtXQZgLv3yijNko
         mfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599798; x=1795204598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UcL/o0gLFgKjfaSHFlON0JxVCm55Q7Iu8bvskJ2RQYk=;
        b=yqiyXpIZJwwbNgIKYP6NJAUa98WxUWtxnhV7/J/LQAr2oHfebY8/oui2hwGCPl/ojf
         aDvzTgZKCu/ENxUUbwR4bLbOxxd5/FELg9kmgWtRm4cHm3nIDGmWDqjQeyRGxKtnfhnY
         lsB4Ctyz8wYUOIIZCNDSCpkr8OWM9Xoqj4F1c2KpYaS6tEawUqD+FO5DuOHWZDCzX36x
         2ztQXcsGGxus+ogjRHoshEXJRZ81NolDa/SaC0MjdNs0YlbSxEZy1s4GcL7nDN5kUoDf
         dlQJ/OOMB9vNhcFxxw7bod6AIM7ktCI59Nq3r9HIGhAdv22BqKzYejyW8SgYtRvUtwJI
         f3CQ==
X-Gm-Message-State: APuU4Z/v3a3Bhg0NDMdVDa6A5TMUGF5eH8NyM6ziI4U+4MlsPI1tvQ54
	gl/GD6+pV7Ayjwm2H1aLtUUZOuWEU/SZLFKo+YhePMzczO7dg633E/IykFHFDsKEnfvI8gC1IaK
	Bj8gCkHbgqw==
X-Received: from dybud10.prod.google.com ([2002:a05:7300:f60a:b0:36c:9b55:8436])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3a8b:b0:182:94d7:f76a
 with SMTP id a92af1059eb24-1b5031562c3mr3505799c88.43.1794599797828; Fri, 13
 Nov 2026 11:56:37 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:58 -0800
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
Message-ID: <20261113195601.2872738-14-irogers@google.com>
Subject: [PATCH v2 13/16] perf pmu: Probe branch instruction skid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() with run_skid_branch_loop() and
probe_pmu_skid() to empirically measure branch instruction skid across
supported precise_ip levels (0..3) on core PMUs.

For each supported precise_ip level, open a branch sampling event on the
current thread, execute a NOP-runway loop ending in a backward
conditional branch on x86_64, arm64, and riscv, and compute the minimum,
maximum, average, and exact-IP (zero-skid) sample counts from the
recorded ring buffer samples.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 259 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  15 +++
 2 files changed, 274 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 04bd5b1bc33f..8157ada08502 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3934,6 +3934,263 @@ static void probe_mmap_caps(struct perf_pmu *pmu,
 	}
 }
 
+/*
+ * Mark noinline so the compiler does not inline the multi-kilobyte .rept nop
+ * runway into callers; GCC estimates inline asm size by counting newlines in
+ * the template string and would otherwise emit short-range conditional
+ * branches (such as ARM64 tbz/tbnz with a +-32KB range) across the inlined
+ * block.
+ */
+static noinline bool run_skid_branch_loop(unsigned long iters,
+					  uintptr_t *out_s_ip,
+					  uintptr_t *out_b_ip,
+					  uintptr_t *out_e_ip,
+					  int *out_insn_sz, int *out_nop_cnt)
+{
+#if defined(__x86_64__)
+	uintptr_t s_ip, b_ip, e_ip;
+
+	asm volatile(
+		"lea 1f(%%rip), %[s_ip]\n\t"
+		"lea 2f(%%rip), %[b_ip]\n\t"
+		"lea 3f(%%rip), %[e_ip]\n\t"
+		".balign 64\n"
+		"1:\n\t"
+		".rept 8192\n\t"
+		"nop\n\t"
+		".endr\n\t"
+		"dec %[cnt]\n\t"
+		"2:\n\t"
+		"jnz 1b\n"
+		"3:\n\t"
+		: [cnt] "+r" (iters),
+		  [s_ip] "=&r" (s_ip),
+		  [b_ip] "=&r" (b_ip),
+		  [e_ip] "=&r" (e_ip)
+		:
+		: "cc", "memory"
+	);
+	*out_s_ip = s_ip;
+	*out_b_ip = b_ip;
+	*out_e_ip = e_ip;
+	*out_insn_sz = 1;
+	*out_nop_cnt = 8192;
+	return true;
+#elif defined(__aarch64__)
+	uintptr_t s_ip, b_ip, e_ip;
+
+	asm volatile(
+		"adr %[s_ip], 1f\n\t"
+		"adr %[b_ip], 2f\n\t"
+		"adr %[e_ip], 3f\n\t"
+		".balign 64\n"
+		"1:\n\t"
+		".rept 1024\n\t"
+		"nop\n\t"
+		".endr\n\t"
+		"subs %[cnt], %[cnt], #1\n\t"
+		"2:\n\t"
+		"b.ne 1b\n"
+		"3:\n\t"
+		: [cnt] "+r" (iters),
+		  [s_ip] "=&r" (s_ip),
+		  [b_ip] "=&r" (b_ip),
+		  [e_ip] "=&r" (e_ip)
+		:
+		: "cc", "memory"
+	);
+	*out_s_ip = s_ip;
+	*out_b_ip = b_ip;
+	*out_e_ip = e_ip;
+	*out_insn_sz = 4;
+	*out_nop_cnt = 1024;
+	return true;
+#elif defined(__riscv)
+	uintptr_t s_ip, b_ip, e_ip;
+
+	asm volatile(
+		".option push\n\t"
+		".option norvc\n\t"
+		"la %[s_ip], 1f\n\t"
+		"la %[b_ip], 2f\n\t"
+		"la %[e_ip], 3f\n\t"
+		".balign 64\n"
+		"1:\n\t"
+		".rept 512\n\t"
+		"nop\n\t"
+		".endr\n\t"
+		"addi %[cnt], %[cnt], -1\n\t"
+		"2:\n\t"
+		"bnez %[cnt], 1b\n"
+		"3:\n\t"
+		".option pop\n\t"
+		: [cnt] "+r" (iters),
+		  [s_ip] "=&r" (s_ip),
+		  [b_ip] "=&r" (b_ip),
+		  [e_ip] "=&r" (e_ip)
+		:
+		: "memory"
+	);
+	*out_s_ip = s_ip;
+	*out_b_ip = b_ip;
+	*out_e_ip = e_ip;
+	*out_insn_sz = 4;
+	*out_nop_cnt = 512;
+	return true;
+#else
+	(void)iters;
+	*out_s_ip = 0;
+	*out_b_ip = 0;
+	*out_e_ip = 0;
+	*out_insn_sz = 0;
+	*out_nop_cnt = 0;
+	return false;
+#endif
+}
+
+/*
+ * Measure branch instruction skid across supported precise_ip levels (0..3)
+ * by sampling a tight NOP-runway branch loop and inspecting sample IPs.
+ */
+static void probe_pmu_skid(struct perf_pmu *pmu,
+			   const struct perf_event_attr *base_attr,
+			   unsigned long flags)
+{
+	struct perf_event_attr br_attr;
+	char br_buf[256];
+	long page_sz = sysconf(_SC_PAGESIZE);
+	size_t data_sz, mmap_sz;
+
+	if (!pmu->is_core || !pmu->probed.can_sample)
+		return;
+
+	if (page_sz <= 0)
+		page_sz = 4096;
+	data_sz = 4 * (size_t)page_sz;
+	mmap_sz = (size_t)page_sz + data_sz;
+
+	memset(&br_attr, 0, sizeof(br_attr));
+	snprintf(br_buf, sizeof(br_buf), "%s/branches/", pmu->name);
+	if (!parse_candidate_attr(br_buf, &br_attr)) {
+		br_attr.type = PERF_TYPE_HARDWARE;
+		br_attr.size = base_attr->size;
+		br_attr.config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS;
+		if (perf_pmus__host_supports_extended_type())
+			br_attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+	}
+	br_attr.exclude_user = base_attr->exclude_user;
+	br_attr.exclude_kernel = 1;
+	br_attr.exclude_hv = 1;
+	br_attr.exclude_idle = base_attr->exclude_idle;
+	br_attr.exclude_host = base_attr->exclude_host;
+	br_attr.exclude_guest = base_attr->exclude_guest;
+
+	for (int lvl = 0; lvl <= 3; lvl++) {
+		struct perf_event_attr attr = br_attr;
+		struct perf_event_mmap_page *pc;
+		uintptr_t s_ip = 0, b_ip = 0, e_ip = 0;
+		int insn_sz = 0, nop_cnt = 0;
+		void *ring;
+		u8 *data;
+		u64 head, tail = 0;
+		int samples = 0, exact = 0;
+		int min_skid = 999999, max_skid = 0;
+		long sum_skid = 0;
+		int fd;
+
+		if (lvl > 0 && !(pmu->probed.precise_mask & (1u << lvl)))
+			continue;
+
+		attr.disabled = 1;
+		attr.sample_period = 251;
+		attr.sample_type = PERF_SAMPLE_IP;
+		attr.precise_ip = lvl;
+
+		fd = sys_perf_event_open(&attr, 0, -1, -1, flags);
+		if (fd < 0 && lvl > 0 && attr.exclude_kernel && attr.config2 == 0) {
+			attr.config2 = 1;
+			fd = sys_perf_event_open(&attr, 0, -1, -1, flags);
+		}
+		if (fd < 0)
+			continue;
+
+		ring = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+		if (ring == MAP_FAILED) {
+			close(fd);
+			continue;
+		}
+
+		ioctl(fd, PERF_EVENT_IOC_RESET, 0);
+		ioctl(fd, PERF_EVENT_IOC_ENABLE, 0);
+		if (!run_skid_branch_loop(8000, &s_ip, &b_ip, &e_ip,
+					  &insn_sz, &nop_cnt)) {
+			ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+			munmap(ring, mmap_sz);
+			close(fd);
+			break;
+		}
+		ioctl(fd, PERF_EVENT_IOC_DISABLE, 0);
+
+		pc = ring;
+		head = READ_ONCE(pc->data_head);
+		/* Ensure data_head is read before reading ring buffer contents. */
+		rmb();
+		if (head > data_sz)
+			head = data_sz;
+		data = (u8 *)ring + page_sz;
+
+		while (tail + sizeof(struct perf_event_header) <= head) {
+			struct perf_event_header *hdr =
+				(struct perf_event_header *)(data + tail);
+
+			if (hdr->size == 0 || tail + hdr->size > head)
+				break;
+			if (hdr->type == PERF_RECORD_SAMPLE &&
+			    hdr->size >= sizeof(*hdr) + sizeof(u64)) {
+				u64 ip = *(u64 *)((u8 *)hdr + sizeof(*hdr));
+				uintptr_t uip = (uintptr_t)ip;
+
+				if (uip >= s_ip && uip <= e_ip && insn_sz > 0) {
+					int skid;
+
+					if (uip == b_ip) {
+						skid = 0;
+					} else if (uip >= s_ip && uip < b_ip) {
+						long off = (long)(uip - s_ip) / insn_sz;
+
+						skid = (off < nop_cnt) ?
+						       (int)(off + 1) : (nop_cnt + 1);
+					} else {
+						skid = 1;
+					}
+
+					samples++;
+					if (hdr->misc & PERF_RECORD_MISC_EXACT_IP)
+						exact++;
+					if (skid < min_skid)
+						min_skid = skid;
+					if (skid > max_skid)
+						max_skid = skid;
+					sum_skid += skid;
+				}
+			}
+			tail += hdr->size;
+		}
+
+		if (samples > 0) {
+			pmu->probed.skid[lvl].measured = true;
+			pmu->probed.skid[lvl].samples = samples;
+			pmu->probed.skid[lvl].exact_samples = exact;
+			pmu->probed.skid[lvl].min_skid = min_skid;
+			pmu->probed.skid[lvl].max_skid = max_skid;
+			pmu->probed.skid[lvl].avg_skid = (double)sum_skid / samples;
+		}
+
+		munmap(ring, mmap_sz);
+		close(fd);
+	}
+}
+
 static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 {
 	struct probe_candidates cands = { .nr = 0 };
@@ -4291,6 +4548,8 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 				pmu->probed.max_precise = 0;
 			}
 		}
+
+		probe_pmu_skid(pmu, &base_attr, flags);
 	}
 
 	/* 3b. User and interrupt register sampling masks */
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index bb21e910da90..4bdb8daf7a5a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -381,6 +381,21 @@ struct perf_pmu {
 		 * can only be sampled with precise sampling.
 		 */
 		u64 intr_pred_precise_mask;
+		/** @probed.skid: Measured branch instruction skid at precise_ip levels (0..3). */
+		struct {
+			/** @probed.skid.measured: Was skid measured at this precise_ip level? */
+			bool measured;
+			/** @probed.skid.samples: Number of branch samples collected. */
+			int samples;
+			/** @probed.skid.exact_samples: Samples with zero skid from target IP. */
+			int exact_samples;
+			/** @probed.skid.min_skid: Minimum instruction skid observed. */
+			int min_skid;
+			/** @probed.skid.max_skid: Maximum instruction skid observed. */
+			int max_skid;
+			/** @probed.skid.avg_skid: Average instruction skid across samples. */
+			double avg_skid;
+		} skid[4];
 	} probed;
 };
 
-- 
2.56.1.703.gf848ed807c-goog

