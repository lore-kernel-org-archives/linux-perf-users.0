Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67196239E99
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786171; cv=none; b=ozDu6fdf2vi6d7ci/fetrWGlY6E1vlALQDkRlAZy0DGhK60GuIl7mgdSwo70x0XGqRRwGYrPRXnKyhrVGOV9+45wMpZOLHmP35uXHr7KSl424+Y2Oob76IJ6McjWSiHfCz+/bQ3DlVX9KXuzMEcY1BBkpLiBvNZCyvcp4tOVlG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786171; c=relaxed/simple;
	bh=LV19GYynUUF0CjbElgTqMTM8C4erDLHMoiN6xloIXdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iGJu+8ioGrwPj7u4QJBjLO1Gn92SeImImkh36xPhBVoIlEpHhSLW8wqYN1vi6rrJXfCmFdqVzzvgrcDFcBjFXWwyis1InYyiGSlGeyN3O1TEEuKYNKu1lJYYvUPpjcQ+JQxGJ4dGRFz3BkQqnun7HV4w9K5NRyIAwMFIdCHzv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWIPQ7gk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWIPQ7gk"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e7337f26so1437829a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786168; x=1753390968; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/sNed9QLILs+6YAkcENeXJYowIz3bMiJ6NyLJB9+4y0=;
        b=sWIPQ7gkTrBq4eyQZt/quXUJcdK421s0oa34qw38yLmR+B1fqKO/YWgMvrO4n1NU72
         r4eOjmTuzYSFDlt3W0gggVpg+s4xrBKnXO74eVLBNvjbGoN4SoVZ9n4b0IQQpr9lp8s+
         xZqsDhhXzkxKztcMLroVxiY++znjeRZcICqChyvcBjk7zPHK2B8FXfVI8K3qwcZi+2f5
         Ot/+pBJ8VTcRJM1ZfAffwb8JJ76rxxMzULpOdo6/yRyvHflK0haLVrv3yf+q9vVyMq7F
         DQ9XVoutP6QtJxrB+D7AH/MDdRkmJwc3bV7Hw4qrjqxnwP3/7JMAmJsQDh7iM3lXcthc
         up7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786168; x=1753390968;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sNed9QLILs+6YAkcENeXJYowIz3bMiJ6NyLJB9+4y0=;
        b=Sq49fZHIpWcVgbnu9AsRyZ9MvcLcArnBAqcFj1E7cAiqcdntBSWVwQCLl/LZJHpc+A
         N3jqLq+Gn97v1aeszvINsdzIdUHl8XtJ03o3NCkj3x7KjwQFMTgRu+GWumYJq43hYzyF
         tpM6NGxrzhXUPB3KndA7wY9p1u9U4RZ09JoZp6QtK4n1HO5oS33pBl0Dc0XcBjGM0CB2
         1FJNRO2mZABZpRchRNkmpj8eXtywdJIOisCWT4aMa90vaXO6DwRO71LvLk8OhjinW9lS
         I+5+9F4VFZx8giHW7itgeytIAQ54C95GSx9nhIt8WlgIHKfNaJB+0dWko/pagpK0SI5d
         EGMA==
X-Forwarded-Encrypted: i=1; AJvYcCU59jLmUr1lBVne9rg81zLxuBOYqNHIQyFkvYJf/oX3yr18fkA5qpwE3qVObjNOMvlgUA2eusyDtVhRwrOEfv1f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/g+1RaXihp0SAxtwamIwi0R03Zn6plZ5Lang/2P7JK4jtPRR
	83cE0ijxqxEosAv5Aj/fvEjemtc38mUnYBr+RG/To4OOpzvQIzFWMPnHAXRPez3kjOXClZwoTV1
	tF6J/1kulFA==
X-Google-Smtp-Source: AGHT+IF1N5bP0NH1x3UUsnmmORw1kMloHDLxHBityI1C1Ml7b5Hy2MMBow/vt/WFaEmPoxG4b7rht9xNYEnM
X-Received: from pji6.prod.google.com ([2002:a17:90b:3fc6:b0:313:2213:1f54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c09:b0:311:ffe8:20ee
 with SMTP id 98e67ed59e1d1-31c9e6f7349mr12023057a91.11.1752786167666; Thu, 17
 Jul 2025 14:02:47 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:26 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-6-irogers@google.com>
Subject: [PATCH v2 05/12] perf tool_pmu: Allow num_cpus(_online) to be
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

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c     |  2 +-
 tools/perf/util/tool_pmu.c | 56 +++++++++++++++++++++++++++++++++-----
 tools/perf/util/tool_pmu.h |  2 +-
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index ca70a14c7cdf..7fda0ff89c16 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -401,7 +401,7 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
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

