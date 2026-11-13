Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599786;
	b=vdeiVJrrxyl2E+5keFy37umDY08TuVhXk4Zeiy9bOVfivGGNYSonKYOiPs1nBtlvNsiI
	 MvF2G8yDu/9FUx6TaJEowp/64u+o6+rbUOZ5k7GXkvju4pQWa80SlgWuFj6AFrryCtPLs
	 UvlAMNPGTMSxFc3QFYImMJDD+bMGcS8in9Yl/JM1Ru8YiMMsvyrv20UBQpk8GKWgSe6cl
	 vKNqHcnEpnM4IePo0l+lhqzF0oNCseFTkTtePXcCqHlwk1BlWrsFyZXzmkTDeG8Rc2MrD
	 YnvhR4xTcKfUMj0X/4Ncrb4xDUgC9V6MIHmdfYvthxlWTSmZleAQfMEUYZU6yXgkCew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=z5ejdXTNrA/iCN+/s2Xu5N3ubGR15XLB4rWgV9wx/pU=;
	b=RVqedmtgHDi4ONya/Kdk/KL+iwACwMAoptAD0Y+oidalLOJcjx4xMNWsb6bPe49XmMeK
	 2g46HpivqmwSru5IFZX10Vkf0qGkXMpI/Qz2YsKaqwKmUhp2lpSMtiQAaLFFQVxU+qIvd
	 NmGd1VfF3i3+KEvzSSqLo88QZw4wkklMvDi5P86F39lxI7VDEkczTG32af2b17h/YBb5c
	 dAj77aJlLxJqL2OW2iJ/+BqlMvFR6RRWlWZmM+0OkBfz6CZT9eJFJlRaoRw2CCuC/IZDl
	 L0fAb8gTl/kPAkhEZdqu8sT2MsGKZ29zn4ZWG2kA5UR3ifFuW0NXhd4UUZTbTUBfy0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZyOX5b8o;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2EA60A6F6B
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2EA60A6F6B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZyOX5b8o
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f26e6abe9so1650979eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599785; x=1795204585; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z5ejdXTNrA/iCN+/s2Xu5N3ubGR15XLB4rWgV9wx/pU=;
        b=ZyOX5b8ofbZpWQmoJCbQOeuIp769cz46KXBMdmC2yJjSn0MYLD9dhQvheiVvxQEOqN
         mgHQSaSysT1F24urGSF1GcssHq1s3PR0AOb5gJBeJzLcnIFYQHaeFlUJdTtQsjxRPsPZ
         gOlfG757tNnUVHvsLrfiSkoWJSCPcMomE//tpFCItDg5NfApmIV5Q54bWHBWn27y+cxY
         ogzCgN2yYm4HezHzByV9LoVvOfZ+gjQISH1xEj8KzT9dLEOAYGXiN954SV4whsDzzcHY
         dxmiJrDDLb+B1pKWB9dAzXJBDWq9kxjqNoMB9FkGQLxrNbIFMul2/MutNvrgz1LKrLRi
         nwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599785; x=1795204585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5ejdXTNrA/iCN+/s2Xu5N3ubGR15XLB4rWgV9wx/pU=;
        b=t0FQWvekrzdcrSibhbxC3N7k+ps2s2YCS3j3kM64kuEbPpIw2zofYXCWlyM4Kut37G
         ZHwuOKinpGg5FcAosAC0fCS0xV2mG10lv7eK3HKNHMO8X0mEcY8LQH3riZxITMXlxkbk
         nhsT0VvIy9vyAWzfJGNLIImTMIXQ3Ynm5L/S19OJOaSmQXm+2GQF7x+Dhto+Wz2e+p3i
         SVP64OPJNmj1cgUOngqIJdHIDEoQkWXwua3SgwLrBxs8BNvvkLRp9UWXiIBH4CqO208g
         wTebHarIBzb2XYxzW72l1cXN+v0y9OJa1UKYvNw6roJVdkW4sA+d1iBObG4rr+Zgzseo
         VBXQ==
X-Gm-Message-State: APuU4Z+UqNUxr/kOq7ZMVmUvYw1JSVHxtF+9eybrp9VjyYnXhbO0Gbiq
	zXe1CnKSHExrcA6b7EnB4XEX4Nqggu7W14pKi2pXYONiQf2cjY5CbAT5UWy/yeIAo4zTXHgj1j5
	7o4EcDBpvTg==
X-Received: from dycc23.prod.google.com ([2002:a05:693c:60d7:b0:372:278c:c777])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7193:b0:376:19bd:2af9
 with SMTP id 5a478bee46e88-3796366047bmr3164594eec.5.1794599784592; Fri, 13
 Nov 2026 11:56:24 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:53 -0800
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
Message-ID: <20261113195601.2872738-9-irogers@google.com>
Subject: [PATCH v2 08/16] perf pmu: Probe event group size limits
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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
index a45d42b6e59a..eb7a4736b30e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3126,6 +3126,123 @@ static bool try_open_attr_variants(struct perf_event_attr *attr,
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
@@ -3946,6 +4063,99 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.1.703.gf848ed807c-goog

