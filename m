Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749598;
	b=oA2x2m7AQQIfB1jJF9eMWW8OREM8ZzRL38RcgUvqmmT1BnCKc2Wh9cHjmLnUMi3oK6sC
	 fWjLro+QZNJhzWMVSW8KTUwc4Axw5L5ly0WWP8cb28W4KHHQyyzrFWkMPrTyz2lLq0gXg
	 qgMwM0SQr1ZpllxB2J2qJSfHWltQPsX1heZLX337XP4RIX3WZnRoqnCsnkdU74QkQaNhy
	 9+kYDB41dWr5fWuFeJ86rSxSOTmkmRpYG2D+e58fjT3CUjRzk2ArLyHMpuNGvOE49YO2X
	 wXXPOMXrTO4kv0ykI5KePYMfXTMa4LNUMBKs3IHn8oFwzV7WiJxo8tYW5vy2YBumK4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=p+YtalTplzDx/zey/+nWV/tPZ+jI1yAKf3V/l0vlsOo=;
	b=zTsa2ae+lIydoimaMUGfDANTo4FYSBg/iGs9zN33cVte7rawpWz2dnfRyy4dZ+s/JvGa
	 sd+yOK8k5e3Zat0QwLWmQyOlddPynzR6g5v2d7F3OPfZJI7tcBzBjjRFNAsDoUKMRAZ1g
	 IkKZ7zFcMmF5Qp/OKHs75w/74X4Sli4FR8ddOQplhE/BIEr5xNt+6rD2hPFkbsqioXnrd
	 l4yQ+hDYFZlByTEuB9aOmooZMTMeWes5f1pAK5DOWhJfRi92X2SE3HqeRPgi5PGmUrQGW
	 qFrbVpx0egvBa5KhsBQbHHfVRdAwsxq5AtfnIZms/w9mSuHLJ/chy4MWHPvt8B0OYNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P8XsKFC3;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A760A2608
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 388A760A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P8XsKFC3
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb061cc4dbso737166a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749596; x=1794354396; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+YtalTplzDx/zey/+nWV/tPZ+jI1yAKf3V/l0vlsOo=;
        b=P8XsKFC3o8KY08JbhnM1rLGHuuGPsd8igBLEumBZq/1BJG9tVgJEUiUdPZeBmQ3Qx9
         WwPle6UYiDKY2wUacQxvmmGQmx8L+GTpAzEAXYQR4pRE/65XElBxQxkM3O/T0sHeSdgk
         fJaqYkIq5n3m8vCi5u55rmzuZVzxr1hz6gn+NAZ6zkucV39BzgS1Y1wbGlLdieYBmygV
         2sJ6qZ5oslUb01FdmjnScMbKfXL1XEGh9TevOznZWdfO61rFNJQoW+l9+O7ML4wYog+x
         XqGM0edETIVoe7wAnnBddpFtH9/+GzluCZLA+uC28jR8uKzScq6pakDjNjZ5VdVgXtGf
         piqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749596; x=1794354396;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+YtalTplzDx/zey/+nWV/tPZ+jI1yAKf3V/l0vlsOo=;
        b=Tos3NyrCQJwivB9bWMYYLkWOfU0VFz24voT+wW/824/PkngqbIHvvsxc96m9xsaT8T
         RfgT3fECIuBhdkkUlbxxiHHyceYujCwXPpL+j9FCXxwN4qRapAOzgzSE+ebh12ViGkBL
         0Og/FdZTdI00+qE6wtCVigIx+LhAVgEuBCs72rUS5ow7NYFVLePqtmuZqabhMIo+6Dkt
         eMrU7veZZdwfNrtzr7U3IcIR50kLYKQq8mrBUc0ePPlg6eHTWdIcQSAFomSOv8tVcV/4
         g2lkLOlQqlkXX9/KLNivBLeJJIK5As051M97+LVDqVvy+Fam/c8zLlFRe/OiznlWdGrG
         4DIw==
X-Gm-Message-State: APuU4Z+TvvvtvpI1SAmifKR74BxIDXJ7cC2R8zic3CgQkwrMNR+DFk+l
	m9k77P5tydFm+t3+RbFpcy9udoXIYDDk45J7KcVEZhLm8a1YOqdr1TXUAsDqEDj7C/ObXOfEKkH
	KAsTKem7YcShq7Pb7JBw9akMQWNWoc9armC64/CCzduADuAlO22TifKTW4YVM/Yii+mmnq596E5
	IPuKzewpVY4wKaU7P825LZZU/ACGdTmX38hbQUFmy04gDhGbTVYUsr+y8=
X-Received: from pjbcm14.prod.google.com ([2002:a17:90a:fa0e:b0:3ab:7aa4:cfe9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265
 with SMTP id 98e67ed59e1d1-3ae897585bamr8174157a91.26.1793749596051; Tue, 03
 Nov 2026 15:46:36 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:49 -0800
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
Message-ID: <20261103234502.1008382-34-irogers@google.com>
Subject: [PATCH v1 33/41] perf pmu: Probe event group size limits
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

Extend perf_pmu__probe() with check_group_active() and
probe_group_limits() to determine the maximum number of events in a
group that are counted simultaneously, without multiplexing
(max_group_size). After each event is added to the group, the group is
enabled and checked to be counting by comparing time_running with
time_enabled.

The number of events in a group accepted by perf_event_open() isn't
reported as it doesn't reflect what can be counted: disabled events are
accepted so that groups may be scheduled by hand and many PMUs accept
groups of enabled events that can never be scheduled.

On core PMUs, where cycles and instructions may use dedicated fixed
counters, also probe a group of general-purpose (GP) hardware events to
determine max_gp_group_size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 210 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  14 +++
 2 files changed, 224 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e7e05e29b695..3585147c5242 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3119,6 +3119,123 @@ static bool try_open_attr_variants(struct perf_event_attr *attr,
 	return false;
 }
 
+/*
+ * Enable @leader_fd's group briefly and verify that both the group leader and
+ * @last_fd run for 100% of their enabled time without multiplexing.
+ */
+static bool check_group_active(int leader_fd, int last_fd)
+{
+	u64 before[3] = { 0, 0, 0 };
+	u64 after[3] = { 0, 0, 0 };
+	u64 f_before[3] = { 0, 0, 0 };
+	u64 f_after[3] = { 0, 0, 0 };
+	u64 delta_ena, delta_run;
+	bool check_follower = false;
+
+	if (read(leader_fd, before, sizeof(before)) != sizeof(before))
+		return false;
+
+	if (last_fd >= 0 && read(last_fd, f_before, sizeof(f_before)) == sizeof(f_before))
+		check_follower = true;
+
+	if (ioctl(leader_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP) < 0)
+		return false;
+
+	for (int spin = 0; spin < 20000; spin++)
+		barrier();
+
+	ioctl(leader_fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP);
+
+	if (read(leader_fd, after, sizeof(after)) != sizeof(after))
+		return false;
+
+	if (check_follower && read(last_fd, f_after, sizeof(f_after)) != sizeof(f_after))
+		return false;
+
+	delta_ena = after[1] - before[1];
+	delta_run = after[2] - before[2];
+	if (delta_ena == 0 || delta_run != delta_ena)
+		return false;
+
+	if (check_follower) {
+		u64 f_delta_ena = f_after[1] - f_before[1];
+		u64 f_delta_run = f_after[2] - f_before[2];
+
+		if (f_delta_ena == 0 || f_delta_run != f_delta_ena)
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Probe the maximum number of events in a group that are counted
+ * simultaneously, without multiplexing. Opening a group doesn't imply it can
+ * be scheduled, many PMUs accept groups of enabled events that can never be
+ * counted, so after each follower is added the group is enabled and checked
+ * to be running.
+ */
+static void probe_group_limits(const struct perf_event_attr *attrs, size_t nr_attrs,
+			       pid_t pid, int cpu, unsigned long flags,
+			       int *max_size, bool *capped)
+{
+	struct perf_event_attr leader_attr;
+	int leader_fd;
+	int fds[MAX_PROBE_GROUP_SIZE];
+	int nr_followers = 0;
+	enum rlimit_action set_rlimit = NO_CHANGE;
+
+	*max_size = 0;
+	*capped = false;
+
+	if (!attrs || nr_attrs == 0)
+		return;
+
+	leader_attr = attrs[0];
+	leader_attr.disabled = 1;
+	leader_attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;
+
+	/* The times are needed to determine whether the group is counting. */
+	leader_fd = sys_perf_event_open(&leader_attr, pid, cpu, -1, flags);
+	if (leader_fd < 0)
+		return;
+
+	if (!check_group_active(leader_fd, -1))
+		goto out;
+	*max_size = 1;
+
+	for (int count = 2; count <= MAX_PROBE_GROUP_SIZE; count++) {
+		struct perf_event_attr follower_attr = attrs[(count - 1) % nr_attrs];
+		int fd;
+
+		follower_attr.disabled = 0;
+		follower_attr.read_format = leader_attr.read_format;
+
+		fd = sys_perf_event_open(&follower_attr, pid, cpu, leader_fd, flags);
+		if (fd < 0 && errno == EMFILE && rlimit__increase_nofile(&set_rlimit))
+			fd = sys_perf_event_open(&follower_attr, pid, cpu, leader_fd, flags);
+		if (fd < 0) {
+			/* The leader's times show whether the whole group is counting. */
+			follower_attr.read_format = 0;
+			fd = sys_perf_event_open(&follower_attr, pid, cpu, leader_fd, flags);
+		}
+		if (fd < 0)
+			break;
+
+		fds[nr_followers++] = fd;
+		if (!check_group_active(leader_fd, fd))
+			break;
+		*max_size = count;
+	}
+
+	if (*max_size >= MAX_PROBE_GROUP_SIZE)
+		*capped = true;
+out:
+	for (int i = 0; i < nr_followers; i++)
+		close(fds[i]);
+	close(leader_fd);
+}
+
 enum probe_exclude_flag {
 	PROBE_EXCLUDE_USER,
 	PROBE_EXCLUDE_KERNEL,
@@ -3909,6 +4026,99 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 		}
 	}
 
+	/* 6. Max number of events in a group counted simultaneously. */
+	if (pmu->name && (!strcmp(pmu->name, "kprobe") || !strcmp(pmu->name, "uprobe"))) {
+		if (pmu->probed.can_leader_sampling || pmu->probed.can_sw_grouping) {
+			pmu->probed.max_group_size = MAX_PROBE_GROUP_SIZE;
+			pmu->probed.max_group_capped = true;
+		} else {
+			pmu->probed.max_group_size = 1;
+		}
+	} else {
+		probe_group_limits(group_attrs, nr_group_attrs, pid, cpu, flags,
+				   &pmu->probed.max_group_size,
+				   &pmu->probed.max_group_capped);
+	}
+
+	/*
+	 * On core PMUs, cycles/instructions may use fixed counters in addition
+	 * to general-purpose (GP) programmable counters. Probe a GP-only event
+	 * group rotating through distinct GP events to determine the GP limit.
+	 */
+	if (pmu->is_core) {
+		static const char * const gp_events[] = {
+			"branches",
+			"branch-misses",
+			"cache-misses",
+			"cache-references",
+			"bus-cycles",
+			"stalled-cycles-frontend",
+			"stalled-cycles-backend",
+		};
+		static const int gp_configs[] = {
+			PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
+			PERF_COUNT_HW_BRANCH_MISSES,
+			PERF_COUNT_HW_CACHE_MISSES,
+			PERF_COUNT_HW_CACHE_REFERENCES,
+			PERF_COUNT_HW_BUS_CYCLES,
+			PERF_COUNT_HW_STALLED_CYCLES_FRONTEND,
+			PERF_COUNT_HW_STALLED_CYCLES_BACKEND,
+		};
+		struct perf_event_attr gp_attrs[MAX_PROBE_GROUP_SIZE];
+		size_t nr_gp_attrs = 0;
+		pid_t gp_pid = pid;
+		int gp_cpu = cpu;
+		int gp_err = 0;
+
+		for (size_t i = 0;
+		     i < ARRAY_SIZE(gp_events) && nr_gp_attrs < MAX_PROBE_GROUP_SIZE; i++) {
+			char gp_buf[256];
+			struct perf_event_attr gp_attr;
+			bool parsed;
+
+			snprintf(gp_buf, sizeof(gp_buf), "%s/%s/", pmu->name, gp_events[i]);
+			memset(&gp_attr, 0, sizeof(gp_attr));
+			parsed = parse_candidate_attr(gp_buf, &gp_attr);
+			if (!parsed) {
+				gp_attr.type = PERF_TYPE_HARDWARE;
+				gp_attr.size = sizeof(gp_attr);
+				gp_attr.config = gp_configs[i];
+				if (perf_pmus__host_supports_extended_type())
+					gp_attr.config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+			}
+			gp_attr.sample_period = base_attr.sample_period;
+			gp_attr.freq = base_attr.freq;
+			gp_attr.sample_type = base_attr.sample_type;
+			gp_attr.exclude_user = base_attr.exclude_user;
+			gp_attr.exclude_kernel = base_attr.exclude_kernel;
+			gp_attr.exclude_hv = base_attr.exclude_hv;
+			gp_attr.exclude_idle = base_attr.exclude_idle;
+			gp_attr.exclude_host = base_attr.exclude_host;
+			gp_attr.exclude_guest = base_attr.exclude_guest;
+			gp_attr.disabled = 1;
+
+			if (nr_gp_attrs == 0) {
+				if (try_open_attr_variants(&gp_attr, false, pmu_cpu,
+							   flags, &gp_pid, &gp_cpu, &gp_err)) {
+					gp_attrs[nr_gp_attrs++] = gp_attr;
+				}
+			} else {
+				int fd = sys_perf_event_open(&gp_attr, gp_pid, gp_cpu, -1, flags);
+
+				if (fd >= 0) {
+					close(fd);
+					gp_attrs[nr_gp_attrs++] = gp_attr;
+				}
+			}
+		}
+
+		if (nr_gp_attrs > 0) {
+			probe_group_limits(gp_attrs, nr_gp_attrs, gp_pid, gp_cpu, flags,
+					   &pmu->probed.max_gp_group_size,
+					   &pmu->probed.max_gp_group_capped);
+		}
+	}
+
 	if (keepalive_fd >= 0)
 		close(keepalive_fd);
 	pmu->probed.checked = true;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8efffbac3cbf..cacb8bc5198b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -278,6 +278,10 @@ struct perf_pmu {
 		bool exclude_host;
 		/** @probed.exclude_guest: Supports perf_event_attr::exclude_guest. */
 		bool exclude_guest;
+		/** @probed.max_group_capped: Was max_group_size capped at probe limit? */
+		bool max_group_capped;
+		/** @probed.max_gp_group_capped: Was max_gp_group_size capped at probe limit? */
+		bool max_gp_group_capped;
 		/** @probed.probe_event: Name of the event used to probe the PMU. */
 		char *probe_event;
 		/** @probed.open_err: errno if open_supported is false. */
@@ -286,6 +290,16 @@ struct perf_pmu {
 		int max_precise;
 		/** @probed.precise_mask: Bitmask of supported precise_ip levels (1..3). */
 		unsigned int precise_mask;
+		/**
+		 * @probed.max_group_size: Max events in a group counted
+		 * simultaneously, without multiplexing.
+		 */
+		int max_group_size;
+		/**
+		 * @probed.max_gp_group_size: Max general-purpose counter events
+		 * in a group counted simultaneously, without multiplexing.
+		 */
+		int max_gp_group_size;
 		/**
 		 * @probed.sample_types: Bitmask of supported
 		 * enum perf_event_sample_format flags.
-- 
2.56.0.385.gac671c819a-goog

