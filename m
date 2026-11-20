Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213640;
	b=uI4VAQUfD5UwwpLdteNy+xPDUAWSw8MZ8eJil92uI2vIOiGOYzgg6qP0hkKv+V0pHeUb
	 DqcMe+z2VcwEXdV11mX7Ue/1NUdIB2iVYggM+GT/r6ovbFfevU1ldWtUAyW9ZOoyqM/ar
	 sNvKbLFwZTvW4MS/gWFDZ4NnWPT4m+efZVQUeCMdl9dPwYMQgC3U+nlQh251TpQnjRr7M
	 Nu0PUyNg0iMfvbTie7MtoAEqTKBvcTEYzZmLZITqzv+0JW5OkaLk1URWNqcKmelQ9Us1/
	 6vSOd3Y+hBhFYRJQGPa4GeUwQRoD7FBPGog1i0YSgNrBPlgK/Su9icoNbMUebR0wmWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+dhur7WyznSfU/ZFWKgrRe3BazdTsA6e5RAz+mCpGKE=;
	b=R/HLxV3is4F9lhpQdMFi2YC1O+/C1IlvXh1mpynJCp7hp05+anyrFPA7nc/1EDPvzgq6
	 CmsUp/4se85usm9GwdTOcJW6O4uCo99zCqnUNNe6/Mbd0VGovJa69zwTDnCZIPs5Ys7Hr
	 2j/MNGSoqA2FEDueTAowaOsSknm42MHS2J5EGB8Dj5njyLqGkBlS/yyR3hsTwa9Nh0BCz
	 OVnxHOimCpPJsgpN5ct0xCH6pf3lvEhQ0PRcrXyamAdBXMTEEWpUdDazmW7Q5dWQ/PZiI
	 3VQzjfcDgkszt1meIk8S8pW7ge4flMoG9302k1/n+wZ8dDzhi6owhRlVwdTjn5MHvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mXMfLqfI;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F4606A6A3
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02F4606A6A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mXMfLqfI
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1780305eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213639; x=1795818439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dhur7WyznSfU/ZFWKgrRe3BazdTsA6e5RAz+mCpGKE=;
        b=mXMfLqfI9lDVnKCzhOMsTaaiEqVKGwS340U3gUfjS/RdSE8Mlhdh86WaWlcAHI118O
         WaNZj7HT74ZXnuPxha4QPQo05BQHR75LZ7FfnJ8cj1H8KxfkevWJ2XGfa6MGlc8Q1XFx
         1+j4A8OrybzhbQkrhi5Dr6TYn6NrN1WC8jZeV6Cs0AoXrW6Eo66ofQw6fFUALw9bnemB
         wJqyzVuFPHAeF2GlYOctO5/Qqy34pXjSLFEU9tU2LBjpZd1UXoex8tuVxmp3K0IkGLBf
         BfOdL3sRUoYVSb+mlyeJUxvy44usD9vgbCu2KpwFqJ8TGSVRBpuvia7HPMxODJBQN3EB
         n+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213639; x=1795818439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dhur7WyznSfU/ZFWKgrRe3BazdTsA6e5RAz+mCpGKE=;
        b=bxyQqtnCjqT0d0Ll7fqhU92donRJOmkNCGVMrhJIFNR/3m5lZnKwaLFtAyFaQL4jH9
         p8rcTfwoafhxE7wWletM3rqKAmUESJrtCZTVlTdSs7WlnjTIDgLY3247ENu11hh93Hkh
         0h6xoTKJ7jq7lsi5n8SW7eC2wor5Zzq4Fl6LfRS5F4rU/TSTPGHIoBzVO0WPRDxjtcZ7
         jRvp8x+Qyu/W62PBCyrJZdaEn0/LO1tIL8jXPv61p+L89VKAqOsEezQjvDzACXAKqZLS
         flsV1wwKwOhu2GgDmN5FoNI/Yb/iCto59I+2Z5FR1Biz7sWNVNmWlrHIU88dtdqM2HR1
         7xHw==
X-Gm-Message-State: APuU4Z/bfI17hVlysVCZk8h1p7TJ81V0+K1zUarGwR8IxnCh5OHk6+5T
	ZQaXiLJQjnlBJzQo6ksGAJ5pS5dUT0zrXLkDr+9Rwg8OJrMWuUPmK44vfjqCq7AwMWsAugWO3qA
	d7yyYcJzjbQ==
X-Received: from dyz23.prod.google.com ([2002:a05:693c:4097:b0:36a:ead:4dcc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6da7:b0:384:5885:2f81
 with SMTP id 5a478bee46e88-3856c0c7c05mr6082922eec.5.1795213638451; Fri, 20
 Nov 2026 14:27:18 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:12 -0800
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
Message-ID: <20261120222615.2291168-14-irogers@google.com>
Subject: [PATCH v3 13/16] perf pmu: Probe branch instruction skid
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
index 0a7bb0a215f0..63fd58354c60 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3944,6 +3944,263 @@ static void probe_mmap_caps(struct perf_pmu *pmu,
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
@@ -4301,6 +4558,8 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.1.750.gf70dc682cf-goog

