Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD52EA742
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052273; cv=none; b=N9YLQiEBw8TqBKe+ZKmkA+PRF8G/awPkhJ4xyleD5KltnPG/sUa1zlCtvKUVOJ9x14K+9R/B0nfuT7r7WKOq6gy64pqQ9mpeJSIoxHt1gZX1QmExq+IbHQuBSkHKH5yDOflrTjIGvDggOKhYGtxkrgvYW/pH5AGmzjDpmWN9qDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052273; c=relaxed/simple;
	bh=K4cbZPYI0JIDUSm80xYGKtxGYlTRrcLLUhCDzn/a6pE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NWFLJ6uv4o6O5HkBs9DygDRIzGGv7tpfQnQFFqBnnK8KK0beHsrJZpuOBfl/CfJhiPXG/Bqxy3Yl5PHVviAts+m52o8GRdPIgFU3H/qMjhJc5QMn2yyjX4oFnVDF/mGsNEImh7WihYIlh33EMF7ExcpD6cT5tcT7pyA0CLiwoAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ruQ8MxTd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ruQ8MxTd"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ae13e99d6so2310676b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751052271; x=1751657071; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RNo+3aZLvAZ2/IwuDIGfrnV93di4OKI/L8u1uWE4qY=;
        b=ruQ8MxTdY3T3Ctlei8wkPPiuNLJx8/mbkeHilhU2KXi8Q0Fv4st6LIK/5Ne0iQXDHO
         exE31q8rHlblCj4r4vuWOhf13jwbbH6WjzaFf2V/Fz++Axs/Et+Dm9eNSvfv6H8bGw6K
         9ICthocSc/ID5bqOPB4p2TNLUKNTM+IE1Y5RaaMGYx7zlC9MkwZaYCh6vl7Q/fgqcfAa
         aKbEMsXxX3WyO26HzOdtSfyA8l9O5GUNyZETXaIwfFLR9W6mdmYWYVeK+0tSMgRPAl94
         WHoIoh6kfwG1dHIHE5iZqTCSMkUAlAnjT/9tbK7agPdaLBPIiIgPyYfPfSh/90fgm4sH
         pIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751052271; x=1751657071;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RNo+3aZLvAZ2/IwuDIGfrnV93di4OKI/L8u1uWE4qY=;
        b=kT/WoMcJeX0CGl9fXtkjG4VYO67N/TzE4X1hi+vP6V/lUffTht5GYeYIST3OX9vANU
         vRSzceTXHGiSJiei8vs3HbhBRn77luEf5Z1q0ZEVmUYbzZvJNO7MeJjMw2CRHa4G+n4c
         /BvN4ATJTaSb1uK2axIR27yPR+8G6Lkr9e5W1o9DnvKKKA4HNVm66RuuZPpjBy7191Dl
         0slUoYn/ymwXMm9/8BfggI2SnrDQoZ2sRGBRK5Cq4Br/8LWeRaPnmq4Vw1XQvoUYiwMQ
         49ws9atiNsfjX05nhFw6ODJ1KE4o4oU7WgsLcdPRxsxPWttdeliUy/3h7PAO++4SMIQU
         rRfw==
X-Forwarded-Encrypted: i=1; AJvYcCVPjtsLgIWDyomMpi26m4i3x5lbuXqMPs/LQLkC/5F6649BE561Y0o1SkBZ3ibTCGAMeCT3/wcyriEZZiFUSc3O@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ifeQbkvdOUIYaL1K7E3bLwu+jB2XQjUm57VevXMKhuV8iU47
	Ykwt+aaa3YQJ2BrkB1b1S7Bn11NuORCSR69mK/tfvbJfQuSo2KPQWnZ6TonZDHiDLjTDR0uOwr/
	uE1Ul0GToOg==
X-Google-Smtp-Source: AGHT+IFXlNHgYdYR42gk1f05pi6MWOw2KfQ1AEVMMAnasDAr5TxaXvAaxf5ou9FqDIGdxDC7lI+WkmTgGfYT
X-Received: from plq16.prod.google.com ([2002:a17:903:2f90:b0:223:4c5f:3494])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:280f:b0:221:751f:cfbe
 with SMTP id d9443c01a7336-23ac5f88835mr46714905ad.19.1751052271292; Fri, 27
 Jun 2025 12:24:31 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:24:10 -0700
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627192417.1157736-6-irogers@google.com>
Subject: [PATCH v1 05/12] perf tool_pmu: Allow num_cpus(_online) to be
 specific to a cpumask
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For hybrid metrics it is useful to know the number of p-core or e-core
CPUs. If a cpumask is specified for the num_cpus or num_cpus_online
tool events, compute the value relative to the given mask rather than
for the full system.

```
$ sudo /tmp/perf/perf stat -e 'tool/num_cpus/,tool/num_cpus,cpu=cpu_core/,
  tool/num_cpus,cpu=cpu_atom/,tool/num_cpus_online/,tool/num_cpus_online,
  cpu=cpu_core/,tool/num_cpus_online,cpu=cpu_atom/' true

 Performance counter stats for 'true':

                28      tool/num_cpus/
                16      tool/num_cpus,cpu=cpu_core/
                12      tool/num_cpus,cpu=cpu_atom/
                28      tool/num_cpus_online/
                16      tool/num_cpus_online,cpu=cpu_core/
                12      tool/num_cpus_online,cpu=cpu_atom/

       0.000767205 seconds time elapsed

       0.000938000 seconds user
       0.000000000 seconds sys
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c     |  2 +-
 tools/perf/util/tool_pmu.c | 56 +++++++++++++++++++++++++++++++++-----
 tools/perf/util/tool_pmu.h |  2 +-
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 6413537442aa..ffd55bc06fa4 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -397,7 +397,7 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 	if (ev != TOOL_PMU__EVENT_NONE) {
 		u64 count;
 
-		if (tool_pmu__read_event(ev, &count))
+		if (tool_pmu__read_event(ev, /*evsel=*/NULL, &count))
 			result = count;
 		else
 			pr_err("Failure to read '%s'", literal);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 4630b8cc8e52..7aa4f315b0ac 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -332,7 +332,7 @@ static bool has_pmem(void)
 	return has_pmem;
 }
 
-bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
+bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *result)
 {
 	const struct cpu_topology *topology;
 
@@ -347,18 +347,60 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result)
 		return true;
 
 	case TOOL_PMU__EVENT_NUM_CPUS:
-		*result = cpu__max_present_cpu().cpu;
+		if (!evsel || perf_cpu_map__is_empty(evsel->core.cpus)) {
+			/* No evsel to be specific to. */
+			*result = cpu__max_present_cpu().cpu;
+		} else if (!perf_cpu_map__has_any_cpu(evsel->core.cpus)) {
+			/* Evsel just has specific CPUs. */
+			*result = perf_cpu_map__nr(evsel->core.cpus);
+		} else {
+			/*
+			 * "Any CPU" event that can be scheduled on any CPU in
+			 * the PMU's cpumask. The PMU cpumask should be saved in
+			 * own_cpus. If not present fall back to max.
+			 */
+			if (!perf_cpu_map__is_empty(evsel->core.own_cpus))
+				*result = perf_cpu_map__nr(evsel->core.own_cpus);
+			else
+				*result = cpu__max_present_cpu().cpu;
+		}
 		return true;
 
 	case TOOL_PMU__EVENT_NUM_CPUS_ONLINE: {
 		struct perf_cpu_map *online = cpu_map__online();
 
-		if (online) {
+		if (!online)
+			return false;
+
+		if (!evsel || perf_cpu_map__is_empty(evsel->core.cpus)) {
+			/* No evsel to be specific to. */
 			*result = perf_cpu_map__nr(online);
-			perf_cpu_map__put(online);
-			return true;
+		} else if (!perf_cpu_map__has_any_cpu(evsel->core.cpus)) {
+			/* Evsel just has specific CPUs. */
+			struct perf_cpu_map *tmp =
+				perf_cpu_map__intersect(online, evsel->core.cpus);
+
+			*result = perf_cpu_map__nr(tmp);
+			perf_cpu_map__put(tmp);
+		} else {
+			/*
+			 * "Any CPU" event that can be scheduled on any CPU in
+			 * the PMU's cpumask. The PMU cpumask should be saved in
+			 * own_cpus, if not present then just the online cpu
+			 * mask.
+			 */
+			if (!perf_cpu_map__is_empty(evsel->core.own_cpus)) {
+				struct perf_cpu_map *tmp =
+					perf_cpu_map__intersect(online, evsel->core.own_cpus);
+
+				*result = perf_cpu_map__nr(tmp);
+				perf_cpu_map__put(tmp);
+			} else {
+				*result = perf_cpu_map__nr(online);
+			}
 		}
-		return false;
+		perf_cpu_map__put(online);
+		return true;
 	}
 	case TOOL_PMU__EVENT_NUM_DIES:
 		topology = online_topology();
@@ -417,7 +459,7 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 			old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 		val = 0;
 		if (cpu_map_idx == 0 && thread == 0) {
-			if (!tool_pmu__read_event(ev, &val)) {
+			if (!tool_pmu__read_event(ev, evsel, &val)) {
 				count->lost++;
 				val = 0;
 			}
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index c6ad1dd90a56..d642e7d73910 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -34,7 +34,7 @@ enum tool_pmu_event tool_pmu__str_to_event(const char *str);
 bool tool_pmu__skip_event(const char *name);
 int tool_pmu__num_skip_events(void);
 
-bool tool_pmu__read_event(enum tool_pmu_event ev, u64 *result);
+bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *result);
 
 u64 tool_pmu__cpu_slots_per_cycle(void);
 
-- 
2.50.0.727.gbf7dc18ff4-goog

