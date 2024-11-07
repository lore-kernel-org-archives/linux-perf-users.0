Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30A219C93
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996460; cv=none; b=EHVILXy0lipYxZgb1/14LMeGQiYOfbO1PzRk4KT//pVajXVxxo94k+avoGLYeK9zTH0UcDTj0pY9Fmfy5UZR8OsF9elvnwxPIKjMaum72zUclDg745Z6Kpe7ZuwvD6BPE/XtWjkONJjfbs7KpkxW3WlJY9x9FrCvqA5SwL9IQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996460; c=relaxed/simple;
	bh=CajUs616qyGppVWZm3vfBDC8+tgu0BtGWij+wkPy5Mo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XOFbUHQLDRAfLWBsH5CrOJrGwG8vH/s2wRJrqN4PxoJQqV/52RtY2CrJutR5UcdiRmaY1bCLbkYhS4Zbjgod7IS/15M5P75+f2D8R7QlB9YKLxIU17w/hoQ4eiLeKhhGOX92FjsWuH0dvwL+lsuyAR3xcoGekr4vB6iHTXaONRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=18y3afOa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="18y3afOa"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e9d6636498so21933297b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 08:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996456; x=1731601256; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmDxOz/jwQKQ9IxxvIQzkp5N2zsrObhsgCU4K9BCHGc=;
        b=18y3afOaEsuDgT2+2V/ctSZfF7MOErusX0gPmmS7dk/dJUuWKWeY+/SEuzQzG3SQVD
         FQlFFsGyu/+qKJ4S+zCA3SeCnidWhMzhg2IHp17TrKt13FWPBv/O10JszKGSSWuH3MyE
         zQcudwDuI5AXsiq/d8hn7tdgeOopHqe+WjZ1U2xbs2yZ3tVQE61N0SXRkP1JA9lDgAbj
         FgG0ifHH6eb3kTdRI6EfvjhMPbsAtWPGRp76hjDbJORywkduLAFZXbhEuUTiDAuWWoYa
         V/ldZY+U/i3S6mTVcbUpERgHnH7bchh+UKKe0CstIPdJv94hZ153EIQqIoHsTrDVpoUh
         JcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996456; x=1731601256;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmDxOz/jwQKQ9IxxvIQzkp5N2zsrObhsgCU4K9BCHGc=;
        b=kSBKiaeZSBrY98ipJXDPprIk90p5NM+jBOMSwWOtjoOvSDH7S80GcshxUeLRYNaVty
         k45yFDPEr5cNnyP1hvyIuFiOCeKD5rwYH3MUk1jovuM09o4NgBFwua0IHEvE3+1yLCkK
         yhjeBdQrLm9af0juoYwFgOJztASGbru+vh88MPhsyd6hQqxmvBi1Oy+EDASka14W8Siu
         q+JDeuKS9qXNswfA5SAjg7GDheTnotY2GABPRgC+VvxpNTct3wmoursTMzDasZjF5C5f
         Z9s6brO6yyabiobHjHC/ayPue+wyx+ONdmCsru3ii1aWKgfQNBi3h4DnKyiI0aHObP/3
         nq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZHhT5alFxr35MmLkscpBIe6pDjE0p082L5kTVpqlPZFtIIzQSeSGvT2NBeNhauvijkr4kXNHRUMLMyO5/JBkD@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNvUd60nUhv2bXYWi8X6YqrDOFGImB/Q00M5p5QMFn8ZHibhI
	G3rYW29uyU9ik0+9fN/6wBePm/L3ia4haolOzs15XcTjLU22oyeilQbn6BfeuSfKTQGmdB03MPj
	ThY9Exw==
X-Google-Smtp-Source: AGHT+IHCkQtw3cbe4yQXJVnOkaPBqQ3DtdlxV254RMwS9iWgJ8X5235+bgRmL2AfqDh6oANhnB+TqaB5uCbI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a81:de03:0:b0:6e2:371f:4aef with SMTP id
 00721157ae682-6eadaf980f4mr79097b3.3.1730996456017; Thu, 07 Nov 2024 08:20:56
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:34 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 7/8] perf jevents: Add map_for_cpu
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The PMU is no longer part of the map finding process and for metrics
doesn't make sense as they lack a PMU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 20 +++++++++++++-------
 tools/perf/pmu-events/jevents.py         | 20 +++++++++++++-------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 51ca8d61c15d..17306e316a3c 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -503,11 +503,11 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
-static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
         static struct {
                 const struct pmu_events_map *map;
-                struct perf_pmu *pmu;
+                struct perf_cpu cpu;
         } last_result;
         static struct {
                 const struct pmu_events_map *map;
@@ -515,15 +515,12 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
         } last_map_search;
         static bool has_last_result, has_last_map_search;
         const struct pmu_events_map *map = NULL;
-        struct perf_cpu cpu = {-1};
         char *cpuid = NULL;
         size_t i;
 
-        if (has_last_result && last_result.pmu == pmu)
+        if (has_last_result && last_result.cpu.cpu == cpu.cpu)
                 return last_result.map;
 
-        if (pmu)
-                cpu = perf_cpu_map__min(pmu->cpus);
         cpuid = get_cpuid_allow_env_override(cpu);
 
         /*
@@ -555,12 +552,21 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
                has_last_map_search = true;
         }
 out_update_last_result:
-        last_result.pmu = pmu;
+        last_result.cpu = cpu;
         last_result.map = map;
         has_last_result = true;
         return map;
 }
 
+static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+{
+        struct perf_cpu cpu = {-1};
+
+        if (pmu)
+                cpu = perf_cpu_map__min(pmu->cpus);
+        return map_for_cpu(cpu);
+}
+
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_map *map = map_for_pmu(pmu);
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index b5ff872e2beb..e44b72e56ac3 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1019,11 +1019,11 @@ int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
         return 0;
 }
 
-static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+static const struct pmu_events_map *map_for_cpu(struct perf_cpu cpu)
 {
         static struct {
                 const struct pmu_events_map *map;
-                struct perf_pmu *pmu;
+                struct perf_cpu cpu;
         } last_result;
         static struct {
                 const struct pmu_events_map *map;
@@ -1031,15 +1031,12 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
         } last_map_search;
         static bool has_last_result, has_last_map_search;
         const struct pmu_events_map *map = NULL;
-        struct perf_cpu cpu = {-1};
         char *cpuid = NULL;
         size_t i;
 
-        if (has_last_result && last_result.pmu == pmu)
+        if (has_last_result && last_result.cpu.cpu == cpu.cpu)
                 return last_result.map;
 
-        if (pmu)
-                cpu = perf_cpu_map__min(pmu->cpus);
         cpuid = get_cpuid_allow_env_override(cpu);
 
         /*
@@ -1071,12 +1068,21 @@ static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
                has_last_map_search = true;
         }
 out_update_last_result:
-        last_result.pmu = pmu;
+        last_result.cpu = cpu;
         last_result.map = map;
         has_last_result = true;
         return map;
 }
 
+static const struct pmu_events_map *map_for_pmu(struct perf_pmu *pmu)
+{
+        struct perf_cpu cpu = {-1};
+
+        if (pmu)
+                cpu = perf_cpu_map__min(pmu->cpus);
+        return map_for_cpu(cpu);
+}
+
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 {
         const struct pmu_events_map *map = map_for_pmu(pmu);
-- 
2.47.0.199.ga7371fff76-goog

