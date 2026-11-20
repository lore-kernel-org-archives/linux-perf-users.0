Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213622;
	b=Ks0JcZruZjm/+m6uVAIEf5Smh7AZKErhQP1JUwoYEhNCxxsSknH1enon95E8CmewBqgt
	 OjSfp+ATH5Umgq6tKlOqnjYIbRNOIYdXhLsy4ZbiZ1gKsEcF6B6rDPPdzoXtQxwF1V35N
	 XDdskrMYFHLdPGwAGxlCKhmHWrmHKny/WcfnNxZCDAgCf+nfsHRB3byUV5mnXxYw3ITeH
	 2P02upieI9IvEQDsfLZCqhC4B2m/yhJFDu/UQqF2FKd2eje+GvufCbBvRu5EMHOgu7CnF
	 ExoARQ+fwNEZhB1TC7eQkxBcu7rENlFpgmiU7qyEZikSjirDYQFJGNYdt7uW7va2qgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XSgbhqkKM6MgQZd8zrEF+hEyk5+eNQnHFb6nxyXIpPc=;
	b=pZ+B/YxyRFr6Nuae4sshNNxjEZ+zKVy72xpRTWF07gjd44SlESyIm/8SS/pNguS1hZAU
	 cxEHv0ZnLgEnFs1bfSLP+UoOAA5XqUK3nJpRByGPpDFS4IeKa/m/94aS7qGD+yDIX/UkS
	 W3oHHPdLWzSDr6pDr5Ku2DrrEc8ejB80rEgf0Mwhpub/peTAZzHVe/6t6vc3BluKps2Lu
	 Y6GEsJmhEkCOtHYkZ0hOgwUFAaVs9Ts4cahI4lbxJ3JL8Wjgu25ShWm4VJUUjjWwPDss4
	 Qb9Mz9hxUYXkmWhucXWyOW3Lao5ij5IdqwpnrdsWqHTE/9wgY+/wguadLkDgoamjuTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rmx8MVJu;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0A606A32C
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B0A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rmx8MVJu
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375bac6bd21so1489379eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213621; x=1795818421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSgbhqkKM6MgQZd8zrEF+hEyk5+eNQnHFb6nxyXIpPc=;
        b=Rmx8MVJulOLge3YRKXCh9zuHrEstnUufK8wc6SF+yd4PzgdiPK9z8cY7pB3At1n1rt
         w/ihYSCo8b4mFYk0rLNBmIXUo4en6kMvn4nAAY7q7DlT2jvYaNhGeIui/h0PQor23kPC
         fVOb0fLXiJQkRvl4tQQWveAo2kePCLTb6xzJX0x6FZ5Y/Qjq0xEquap0/BgiXqZcIAHV
         VkUfpfji8/HXvgGu59UgATbeS1mO0XNKiMeA6swdhdoG7C31T4QPT9lTKuO9pXCt6n/b
         9cajZ/KRkz+8NCFkkGEen8f5l+gXpwW2tdoWPZRyfRYUgT7ijKwQjKz6Zndn6W+JzBsj
         hy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213621; x=1795818421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSgbhqkKM6MgQZd8zrEF+hEyk5+eNQnHFb6nxyXIpPc=;
        b=GlR+u334IWrdO7wPhWRBuSp6p5ww+506gLA0XBPI77IX7fIXTF6QSTMVox3EcHGbyD
         OmxcQSm/579OOGnStkt4pNz8ARAaI+1E71YEJlpacRRMz8587eZTE5iGFpLu7y3842FV
         ARlJrTAHqO7nDqDoQkiuqWHZGjGGkemEGaCtn9px3rGOj61l5DNhgDNmsDJMLc0TE3w6
         Aq28Vwbnp/q8leCjENwbazv80oZp1jmZUkDHxffhbR2AkE/6E0EXebfrTv5R7b8fov2O
         MKGE/vTbdsx68VStsfT/9VN2er+CX8HZ2zoM1OmXHovgpH8IN0o/net6azVOOXfzi2AJ
         SZ6A==
X-Gm-Message-State: APuU4Z9FpX5ltn9hL8fd7TkUEi7B0jejLhOfZgxyuf/volDkKeWZUf+c
	1jWzrKMATc7ka5gT/3fYqn5GPoZ8oTwDqOqB/DGbXl7KXv5PO3tH9mcr9izIjBOJHby6H7gZk7F
	5ePZgAYQQxw==
X-Received: from dlgj1-n1.prod.google.com ([2002:a05:7023:e41:10b0:19b:58fb:b643])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c8b:b0:1b2:459d:331f
 with SMTP id a92af1059eb24-1b5525d007fmr4348004c88.16.1795213620821; Fri, 20
 Nov 2026 14:27:00 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:07 -0800
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
Message-ID: <20261120222615.2291168-9-irogers@google.com>
Subject: [PATCH v3 08/16] perf pmu: Probe event group size limits
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
index eacb8719f801..e3730fedbc9d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3136,6 +3136,123 @@ static bool try_open_attr_variants(struct perf_event_attr *attr,
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
@@ -3956,6 +4073,99 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
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
2.56.1.750.gf70dc682cf-goog

