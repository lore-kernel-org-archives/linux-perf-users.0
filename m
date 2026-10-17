Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BA3E51F7
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263307; cv=none; b=NboVjrIRWgTnTqrJHK9nEthPNHnIxwiyiSTcG8Lfhr+xGqxgBPKuJJU6wnTVSgDx8M6W4oAhiH5DJeH/rkIpbs5GGZFctUjtbp6fgzsQ9Ku1e3vc69cb+BoRR1bF0YPILYJKqH46NBFAFEYHX9e5zSqYGFKhi2UmwZUR3vDtoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263307; c=relaxed/simple;
	bh=HELf046abCp2zhnhCVZgTVg3AIymowbdRqLHG1wTpaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j06Uue7QPEw1gIcg50jL9JCEI9zM/xyQ1yaa5tqBPUBYEYxA5oml6JoUV/EGp7lo+AIprTTjDm+Fhz7m51HR9xfwR80HH/8fCxVggKPmOoT9uWxyvgBbyA7WWIeXgO4QwVyNqWWAUAMmoxO4Sca4jpJMZxWNB9IhC+xOv0iRKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDG8nWzk; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDG8nWzk"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso1493145eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792263304; x=1792868104; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KeZVpSncFsOTvoiq4C2Ak2HLC8Rd9Ivw+WQJy2ZIghU=;
        b=MDG8nWzk8FcG/r5BUE159Wu60RgnxtYL2wyHwbeRo/K12fv+4om2V2BwEcpixv9V9q
         jVTdFijaEVDi4dcWdOyEChH5mezHi/tLQhMNXIelN4aQveYG+RM8w9vtsS33MrIuuuqQ
         AMvJsFTpib0I8+We8qOxqSuBBdLCVT9CoKoWp0wImQn70qG9mwPWbF/yQLVDC/yEH8hK
         mFYAODzv4epKwVXFmHeX5j8uS2tsxWxmlYxS3unNE5ISjqu52jNd8gHu7uCsZ2Nwf+Ey
         UjOsfzIyDye8Ld0SMMIvk5aCc7ekO/UNlrnFgTkYMHan7AJXjr9UPbL0Z2GXwPySfXAv
         XYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792263304; x=1792868104;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KeZVpSncFsOTvoiq4C2Ak2HLC8Rd9Ivw+WQJy2ZIghU=;
        b=soqe+zNrc7vN5CgSMVJpf/IppJqbYFlMXuw7pL/NEJpOu4TfqrMGpji5tc5MWFfxgr
         Se9Px3Y7ER1LAYLcYbU1nX/INWfmwldEVUOfVxPALEkzfu1wLhKjlarCA8XU0Z7B26FF
         +Dbz2w5BFX8zrnNP4XZ9Mvn3mbkz3KRPM8G7OBxzx5N0LH0E62rB/G+e8vvHil7AaP9H
         Hc+AQC810QrIr8NlYqfswmyLlcI1pYEZAzgsrN3dw+mZxJrbdmQ9xhO0gqHieVpiJOFz
         uTrAYy4ZMSVF2KCWMQ/u0L+wKsll7hSo2cpUsDocrV4KZpWZbq5Ow9WfC57pRjDkypNo
         Pk/w==
X-Forwarded-Encrypted: i=1; AKwUvByZlrsEo3dMSBf3Tfn8z4h/rzvplKscFo9IQ1qZgbtdaGM1XxwxXvAGteFyckTag7W8MtjjPlWE+XC91JlU/Q3a@vger.kernel.org
X-Gm-Message-State: AFq9FYI0l5kq9/lF20brQcTotquyPTDBM57/tMd/1Q5S4f2iLaDeEnaS
	igrSlEwvgMGnAN64g0949HNTEfogxSn9DvraFHdG/T+yfsIxVPVxSxO4PnBRyoraH5JXL1/kVTw
	H2wbtbUT4FQ==
X-Received: from dycag9.prod.google.com ([2002:a05:7300:fa09:b0:35f:c124:58ff])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ce0c:b0:35c:7d45:c6ea
 with SMTP id 5a478bee46e88-361a2053aeamr4739491eec.19.1792263303865; Sat, 17
 Oct 2026 11:55:03 -0700 (PDT)
Date: Sat, 17 Oct 2026 11:54:39 -0700
In-Reply-To: <20261017185442.2137623-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016213258.945737-1-irogers@google.com> <20261017185442.2137623-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261017185442.2137623-7-irogers@google.com>
Subject: [RFC PATCH v2 6/9] perf pmu: Probe registers, memory events, rdpmc,
 and branch skid
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, eranian@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() to probe supported user and interrupt sampling
register masks (both general-purpose and SIMD), memory profiling events
and sample formats, user-space mmap counter reading (rdpmc) and PMC bit-
width, and empirically measured branch instruction skid across precision
levels.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 758 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 758 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 83c8d6f392ba..15a21f8c65ed 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3356,6 +3356,739 @@ static void probe_sample_types(struct perf_pmu *pmu,
 	pmu->probed.can_weight = !!(pmu->probed.sample_types & PERF_SAMPLE_WEIGHT);
 }
 
+static void probe_pmu_regs_one(const struct perf_pmu *pmu,
+			       const struct perf_event_attr *base_attr,
+			       pid_t pid, int cpu, unsigned long flags,
+			       int max_precise, bool intr,
+			       u64 *out_mask, int *out_abi,
+			       u64 *out_simd_mask, u64 *out_pred_mask)
+{
+	int dummy_abi = -1;
+	u64 gpr_mask = intr ? perf_intr_reg_mask(EM_HOST, &dummy_abi) :
+			      perf_user_reg_mask(EM_HOST, &dummy_abi);
+	u64 sample_type = intr ? PERF_SAMPLE_REGS_INTR : PERF_SAMPLE_REGS_USER;
+	u64 mask = 0;
+	int abi = 0;
+	struct perf_event_attr attr = *base_attr;
+	int fd;
+
+	attr.disabled = 1;
+	attr.sample_period = base_attr->sample_period ?: 10000;
+	attr.sample_type = sample_type;
+
+	if (gpr_mask) {
+		if (intr)
+			attr.sample_regs_intr = gpr_mask;
+		else
+			attr.sample_regs_user = gpr_mask;
+
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+		if (fd >= 0) {
+			close(fd);
+			mask |= gpr_mask;
+		} else {
+			for (int b = 0; b < 64; b++) {
+				if (!(gpr_mask & BIT_ULL(b)))
+					continue;
+				if (intr)
+					attr.sample_regs_intr = BIT_ULL(b);
+				else
+					attr.sample_regs_user = BIT_ULL(b);
+				fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+				if (fd >= 0) {
+					close(fd);
+					mask |= BIT_ULL(b);
+				}
+			}
+		}
+	}
+
+	if (perf_pmu__is_software(pmu)) {
+		*out_mask = mask;
+		*out_abi = abi;
+		return;
+	}
+
+	/*
+	 * Probe extended GPRs outside the base GPR mask when the host ABI
+	 * supports PERF_SAMPLE_REGS_ABI_SIMD (e.g. APX R16-R31 and CET SSP).
+	 * Note: perf_pmu__probe() actively probes the running host kernel via
+	 * perf_event_open(), so EM_HOST is used intentionally here.
+	 */
+	{
+		int host_abi = 0;
+		u64 host_mask = intr ? perf_intr_reg_mask(EM_HOST, &host_abi) :
+				       perf_user_reg_mask(EM_HOST, &host_abi);
+		u64 ext_gpr_mask = host_mask & ~gpr_mask;
+
+		if ((host_abi & PERF_SAMPLE_REGS_ABI_SIMD) && ext_gpr_mask) {
+			struct perf_event_attr e_attr = *base_attr;
+			bool ext_batch_ok = false;
+
+			e_attr.size = sizeof(e_attr);
+			e_attr.disabled = 1;
+			e_attr.sample_period = base_attr->sample_period ?: 10000;
+			e_attr.sample_type = sample_type;
+			e_attr.sample_simd_regs_enabled = 1;
+			if (intr)
+				e_attr.sample_regs_intr = ext_gpr_mask;
+			else
+				e_attr.sample_regs_user = ext_gpr_mask;
+
+			fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+			if (fd < 0 && intr && max_precise > 0) {
+				e_attr.precise_ip = 1;
+				fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+			}
+			if (fd >= 0) {
+				close(fd);
+				mask |= ext_gpr_mask;
+				abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+				ext_batch_ok = true;
+			}
+
+			if (!ext_batch_ok) {
+				for (int b = 0; b < 64; b++) {
+					if (!(ext_gpr_mask & BIT_ULL(b)))
+						continue;
+					e_attr.precise_ip = base_attr->precise_ip;
+					if (intr)
+						e_attr.sample_regs_intr = BIT_ULL(b);
+					else
+						e_attr.sample_regs_user = BIT_ULL(b);
+					fd = sys_perf_event_open(&e_attr, pid, cpu, -1, flags);
+					if (fd < 0 && intr && max_precise > 0) {
+						e_attr.precise_ip = 1;
+						fd = sys_perf_event_open(&e_attr, pid, cpu, -1,
+									 flags);
+					}
+					if (fd >= 0) {
+						close(fd);
+						mask |= BIT_ULL(b);
+						abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+					}
+				}
+			}
+		}
+	}
+
+	for (int is_pred = 0; is_pred <= 1; is_pred++) {
+		bool pred = is_pred != 0;
+		u64 class_mask = intr ?
+			perf_intr_simd_reg_class_mask(EM_HOST, pred) :
+			perf_user_simd_reg_class_mask(EM_HOST, pred);
+		u64 supported_classes = 0;
+
+		for (int reg_c = 0; reg_c < 64; reg_c++) {
+			struct perf_event_attr s_attr = *base_attr;
+			u16 qwords = 0;
+			u64 bitmap;
+
+			if (!(class_mask & BIT_ULL(reg_c)))
+				continue;
+			bitmap = intr ?
+				perf_intr_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred) :
+				perf_user_simd_reg_class_bitmap_qwords(EM_HOST, reg_c,
+								       &qwords, pred);
+			if (!bitmap || !qwords)
+				continue;
+
+			s_attr.size = sizeof(s_attr);
+			s_attr.disabled = 1;
+			s_attr.sample_period = base_attr->sample_period ?: 10000;
+			s_attr.sample_type = sample_type;
+			s_attr.sample_simd_regs_enabled = 1;
+			if (pred) {
+				s_attr.sample_simd_pred_reg_qwords = qwords;
+				if (intr)
+					s_attr.sample_simd_pred_reg_intr = bitmap;
+				else
+					s_attr.sample_simd_pred_reg_user = bitmap;
+			} else {
+				s_attr.sample_simd_vec_reg_qwords = qwords;
+				if (intr)
+					s_attr.sample_simd_vec_reg_intr = bitmap;
+				else
+					s_attr.sample_simd_vec_reg_user = bitmap;
+			}
+
+			fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
+			if (fd < 0 && intr && max_precise > 0) {
+				s_attr.precise_ip = 1;
+				fd = sys_perf_event_open(&s_attr, pid, cpu, -1, flags);
+			}
+			if (fd >= 0) {
+				close(fd);
+				supported_classes |= BIT_ULL(reg_c);
+				abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+			}
+		}
+
+		if (pred)
+			*out_pred_mask = supported_classes;
+		else
+			*out_simd_mask = supported_classes;
+	}
+
+	if (!(abi & PERF_SAMPLE_REGS_ABI_SIMD)) {
+		u64 ext_mask = GENMASK_ULL(63, 32) & ~gpr_mask;
+		struct perf_event_attr x_attr = *base_attr;
+		bool batch_ok = false;
+
+		x_attr.disabled = 1;
+		x_attr.sample_period = base_attr->sample_period ?: 10000;
+		x_attr.sample_type = sample_type;
+		if (intr && max_precise > 0)
+			x_attr.precise_ip = 1;
+
+		if (ext_mask) {
+			if (intr)
+				x_attr.sample_regs_intr = ext_mask;
+			else
+				x_attr.sample_regs_user = ext_mask;
+
+			fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
+			if (fd >= 0) {
+				close(fd);
+				mask |= ext_mask;
+				batch_ok = true;
+			}
+		}
+
+		if (!batch_ok) {
+			for (int b = 0; b < 64; b++) {
+				const char *rname;
+
+				if (gpr_mask & BIT_ULL(b))
+					continue;
+				rname = perf_reg_name(b, EM_HOST, EF_HOST, 0);
+				if (!rname || !strcmp(rname, "unknown"))
+					continue;
+				if (intr)
+					x_attr.sample_regs_intr = BIT_ULL(b);
+				else
+					x_attr.sample_regs_user = BIT_ULL(b);
+				fd = sys_perf_event_open(&x_attr, pid, cpu, -1, flags);
+				if (fd >= 0) {
+					close(fd);
+					mask |= BIT_ULL(b);
+				}
+			}
+		}
+	}
+
+	*out_mask = mask;
+	*out_abi = abi;
+}
+
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
+static void probe_mmap_caps(struct perf_pmu *pmu,
+			    const struct perf_event_attr *base_attr,
+			    int pmu_cpu, pid_t pid, int cpu,
+			    unsigned long flags)
+{
+	struct perf_event_attr attr = *base_attr;
+	struct perf_event_mmap_page *pc;
+	long page_sz = sysconf(_SC_PAGESIZE);
+	cpu_set_t old_mask, mask;
+	bool affinity_changed = false;
+	bool has_rdpmc_cap = false;
+	int events_fd;
+	int fd = -1;
+
+	pmu->probed.rdpmc_sysfs = -1;
+
+	if (page_sz <= 0)
+		page_sz = 4096;
+
+	events_fd = perf_pmu__event_source_devices_fd();
+	if (events_fd >= 0) {
+		int pmu_dirfd = openat(events_fd, pmu->name, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+
+		if (pmu_dirfd >= 0) {
+			if (faccessat(pmu_dirfd, "rdpmc", F_OK, 0) == 0) {
+				int rfd;
+
+				has_rdpmc_cap = true;
+				rfd = openat(pmu_dirfd, "rdpmc", O_RDONLY | O_CLOEXEC);
+				if (rfd >= 0) {
+					char rbuf[16];
+					ssize_t n = read(rfd, rbuf, sizeof(rbuf) - 1);
+
+					if (n > 0) {
+						rbuf[n] = '\0';
+						pmu->probed.rdpmc_sysfs = atoi(rbuf);
+					}
+					close(rfd);
+				}
+			}
+			close(pmu_dirfd);
+		}
+		close(events_fd);
+	}
+
+	if (pmu_cpu >= 0 && pmu_cpu < CPU_SETSIZE &&
+	    sched_getaffinity(0, sizeof(old_mask), &old_mask) == 0) {
+		CPU_ZERO(&mask);
+		CPU_SET(pmu_cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask) == 0)
+			affinity_changed = true;
+	}
+
+	attr.disabled = 0;
+
+	/*
+	 * On architectures such as arm64, user-space counter reading must be
+	 * explicitly requested via format/rdpmc (config1:1).
+	 */
+	if (perf_pmu__has_format(pmu, "rdpmc")) {
+		struct perf_event_attr r_attr = attr;
+		int uval;
+
+		has_rdpmc_cap = true;
+		if (pmu->probed.rdpmc_sysfs < 0 &&
+		    sysctl__read_int("kernel/perf_user_access", &uval) == 0)
+			pmu->probed.rdpmc_sysfs = uval;
+
+		r_attr.config1 |= 0x2;
+		fd = sys_perf_event_open(&r_attr, 0, -1, -1, flags);
+	}
+
+	if (fd < 0 && !pmu->is_uncore)
+		fd = sys_perf_event_open(&attr, 0, -1, -1, flags);
+	if (fd < 0)
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+
+	if (fd >= 0) {
+		pc = mmap(NULL, page_sz, PROT_READ, MAP_SHARED, fd, 0);
+		if (pc != MAP_FAILED) {
+			if (has_rdpmc_cap || pc->cap_user_rdpmc) {
+				pmu->probed.rdpmc_available = true;
+				pmu->probed.pmc_width = pc->pmc_width;
+			}
+			if (pc->cap_user_rdpmc && pc->index != 0) {
+				struct perf_mmap map = { .base = pc };
+				struct perf_counts_values start = { .val = 0 };
+				struct perf_counts_values end = { .val = 0 };
+
+				pmu->probed.can_user_rdpmc = true;
+				if (perf_mmap__read_self(&map, &start) == 0) {
+					for (int spin = 0; spin < 10000; spin++)
+						barrier();
+					if (perf_mmap__read_self(&map, &end) == 0 &&
+					    end.val >= start.val && end.val > 0)
+						pmu->probed.rdpmc_works = true;
+				}
+			}
+			pmu->probed.can_user_time = !!pc->cap_user_time;
+			pmu->probed.can_user_time_zero = !!pc->cap_user_time_zero;
+			pmu->probed.can_user_time_short = !!pc->cap_user_time_short;
+			munmap(pc, page_sz);
+		}
+		close(fd);
+	}
+
+	if (affinity_changed)
+		sched_setaffinity(0, sizeof(old_mask), &old_mask);
+}
+
+/*
+ * Mark noinline so the compiler does not inline the multi-kilobyte .rept nop
+ * runway into callers; GCC estimates inline asm size by counting newlines in
+ * the template string and would otherwise emit short-range conditional
+ * branches (such as ARM64 tbz/tbnz with a +-32KB range) across the inlined
+ * block.
+ */
+static noinline bool run_skid_branch_loop(u64 iters, uintptr_t *out_s_ip,
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
+static void probe_pmu_skid(struct perf_pmu *pmu,
+			   const struct perf_event_attr *base_attr,
+			   int pmu_cpu, unsigned long flags)
+{
+	struct perf_event_attr br_attr;
+	char br_buf[256];
+	long page_sz = sysconf(_SC_PAGESIZE);
+	size_t data_sz, mmap_sz;
+	cpu_set_t old_mask, mask;
+	bool affinity_changed = false;
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
+		if (perf_pmus__supports_extended_type())
+			br_attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+	}
+	br_attr.exclude_user = base_attr->exclude_user;
+	br_attr.exclude_kernel = 1;
+	br_attr.exclude_hv = 1;
+	br_attr.exclude_idle = base_attr->exclude_idle;
+	br_attr.exclude_host = base_attr->exclude_host;
+	br_attr.exclude_guest = base_attr->exclude_guest;
+
+	if (pmu_cpu >= 0 && pmu_cpu < CPU_SETSIZE &&
+	    sched_getaffinity(0, sizeof(old_mask), &old_mask) == 0) {
+		CPU_ZERO(&mask);
+		CPU_SET(pmu_cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask) == 0)
+			affinity_changed = true;
+	}
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
+
+	if (affinity_changed)
+		sched_setaffinity(0, sizeof(old_mask), &old_mask);
+}
+
 void perf_pmu__probe(struct perf_pmu *pmu)
 {
 	struct probe_candidates cands = { .nr = 0 };
@@ -3696,7 +4429,29 @@ void perf_pmu__probe(struct perf_pmu *pmu)
 			}
 		}
 
+		probe_pmu_skid(pmu, &base_attr, pmu_cpu, flags);
+	}
+
+	/* 3b. User and interrupt register sampling masks */
+	if (pmu->probed.sample_types & PERF_SAMPLE_REGS_USER) {
+		probe_pmu_regs_one(pmu, &base_attr, pid, cpu, flags,
+				   pmu->probed.max_precise, /*intr=*/false,
+				   &pmu->probed.user_regs_mask,
+				   &pmu->probed.user_regs_abi,
+				   &pmu->probed.user_simd_mask,
+				   &pmu->probed.user_pred_mask);
 	}
+	if (pmu->probed.sample_types & PERF_SAMPLE_REGS_INTR) {
+		probe_pmu_regs_one(pmu, &base_attr, pid, cpu, flags,
+				   pmu->probed.max_precise, /*intr=*/true,
+				   &pmu->probed.intr_regs_mask,
+				   &pmu->probed.intr_regs_abi,
+				   &pmu->probed.intr_simd_mask,
+				   &pmu->probed.intr_pred_mask);
+	}
+
+	/* 3c. Memory event types and memory sample formats */
+	probe_mem_events(pmu, &base_attr, pid, cpu, flags);
 
 	/* 4. Privilege / exclusion modifiers */
 	pmu->probed.exclude_user =
@@ -3861,6 +4616,9 @@ void perf_pmu__probe(struct perf_pmu *pmu)
 		}
 	}
 
+	/* 5b. User-space mmap capabilities (rdpmc, user_time, pmc_width) */
+	probe_mmap_caps(pmu, &base_attr, pmu_cpu, pid, cpu, flags);
+
 	/* 5c. Auto-counter reload (acr_mask / ratio-to-prev) */
 	if (pmu->probed.can_sample && perf_pmu__has_format(pmu, "acr_mask")) {
 		struct perf_event_attr l_attr = base_attr;
-- 
2.56.0.212.g129ede20d9-goog

