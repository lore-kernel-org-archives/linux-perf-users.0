Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B0218D74
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996451; cv=none; b=BVMHiSjicmSlflFu9AJ6zy/keF/FqGmxBk6gznGEu0ex2rdx0MIK3BZ3/Nb/uhHcXkyuP2/zCY5/481aHvc88c4ULydVLgrRFpYF+Tj3p4GCzqiFKj2+obfDlXShB43w+/oVQ3O+hJtyPNxBFST3urpqtASJcRqHcwMf/+9+QII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996451; c=relaxed/simple;
	bh=OHfFGp0ifWb+zyyGJptLLNowSsK7ixiaUATGyiRfl38=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MiR59uKu8S5FyYThSiahwAQ4quLGpSBeFG6yLtk7inAfTv7aVx3PhZcAbNkpvrkdHFxpqNE1jzBuIOaWAEgHwZQT9neqzOIkco4XHnleCRrzHmPfVNRlSnWssT/kqdhv7KTuapj4Wxk34Lf3D4p0oWBmn9PdBUUvi8X2K6xB9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OaglWSka; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OaglWSka"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e32ff6f578eso2897992276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Nov 2024 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996449; x=1731601249; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cITlh9ATOoPVTRO1t6obQAYHyRTBK7FrpPuOEFqdekQ=;
        b=OaglWSkaljUPgg4eVEsSCQX2Nr0aFgb5yZ9D7HsF+RpKKsdiEFay1LmjPh+7atoe/T
         IFkRb1uLrX7pA4TnAOf79eNM7ILpg1vPfgX5y5QDfEy2R6AUN0EFAUAh7G1eq0gc8Fb+
         ICyjm0qHw9DvHfrX8svdw3G5gWgjgbkF4xTLHl2Stth7hnohWcM/p/VvEeANKzB32sXB
         tmtQl+zuXue6o7p1k2K51+JnvYdBz7vjfarlkcJzdxrLusQDQveVMGEen5zexJ9CjHRF
         dpRhjp7aOLJscmb02417GG+hZoO9vSgtbE736exp7WqoK4XA5FAo1U+4Wcozws7SK26k
         cbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996449; x=1731601249;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cITlh9ATOoPVTRO1t6obQAYHyRTBK7FrpPuOEFqdekQ=;
        b=nRCPK1xCATL6DwoAmq/EPrUMhHbUtkyXf5iiiHfitLzfXolOgEdjI7ZItVfbgaburq
         SmF/tEYbZrxYr+zg/gbs89rgdvZJ+Fgt/pReJZivBE9FHnM6Vjl05h2bgXWLs1EEmpO8
         pnr2tYv3G9kxcwgdOJZQ4Ye+8KexRNmjhNcV2DGwIR425eRS7RHli1U+B6fgzgGdQqad
         DpEdHSBQmyOaYuuc56HTlLkiOswSOXub0oWS1lqP0TpKc6520Tx0UR+la9CK4uLDJzPW
         o6HFltd180mnI4c7rOzuxbRvnfGuMQ8ZOD6R/pbtb2Txw9po6/y10yRpQ0Q+6UKIYvkO
         gI5A==
X-Forwarded-Encrypted: i=1; AJvYcCUApUcbCwvJmcbg6IGi4rFDBioQgsDPsa/nIPs49tygPYmapdRi7hppnPwqbn8RxGfIAg9HR9B/woSXJi5Msg01@vger.kernel.org
X-Gm-Message-State: AOJu0YxkRv6nxBwA/Ghla2hIv+PX1liw0nKtetteh+PxhCJQUfRxzlC4
	rBIyGxuD1ELk+jAR2Q/j/dX8evmqXUJSBzAsH5aCPylTrte2QNszPxzuHu25lOzSB6k8dRY1497
	D0BlDpQ==
X-Google-Smtp-Source: AGHT+IG1fNyhU6PNjCD8QiB4AIaYMuHJ0Ff8pcK56s0BAFMRxuWOpx7ZU0605y5qL9fF+7F7l6kf2Vho1N3/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:ef08:0:b0:e26:3788:9ea2 with SMTP id
 3f1490d57ef6-e337e037c8emr122276.0.1730996449164; Thu, 07 Nov 2024 08:20:49
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:31 -0800
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
Message-Id: <20241107162035.52206-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 4/8] perf arm64 header: Use cpu argument in get_cpuid
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

Use the cpu to read the MIDR file requested. If the "any" value (-1)
is passed that keep the behavior of returning the first MIDR file that
can be read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/header.c | 63 ++++++++++++++---------------
 tools/perf/util/header.h            |  1 +
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
index 760c21784713..f0907daad3ae 100644
--- a/tools/perf/arch/arm64/util/header.c
+++ b/tools/perf/arch/arm64/util/header.c
@@ -14,55 +14,52 @@
 #define MIDR_REVISION_MASK      GENMASK(3, 0)
 #define MIDR_VARIANT_MASK	GENMASK(23, 20)
 
-static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
+static int _get_cpuid(char *buf, size_t sz, struct perf_cpu cpu)
 {
+	char path[PATH_MAX];
+	FILE *file;
 	const char *sysfs = sysfs__mountpoint();
-	struct perf_cpu cpu;
-	int idx, ret = EINVAL;
 
+	assert(cpu.cpu != -1);
 	if (!sysfs || sz < MIDR_SIZE)
 		return EINVAL;
 
-	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		char path[PATH_MAX];
-		FILE *file;
-
-		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d" MIDR,
-			  sysfs, cpu.cpu);
-
-		file = fopen(path, "r");
-		if (!file) {
-			pr_debug("fopen failed for file %s\n", path);
-			continue;
-		}
-
-		if (!fgets(buf, MIDR_SIZE, file)) {
-			fclose(file);
-			continue;
-		}
-		fclose(file);
+	scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d" MIDR, sysfs, cpu.cpu);
 
-		/* got midr break loop */
-		ret = 0;
-		break;
+	file = fopen(path, "r");
+	if (!file) {
+		pr_debug("fopen failed for file %s\n", path);
+		return EINVAL;
 	}
 
-	return ret;
+	if (!fgets(buf, MIDR_SIZE, file)) {
+		pr_debug("Failed to read file %s\n", path);
+		fclose(file);
+		return EINVAL;
+	}
+	fclose(file);
+	return 0;
 }
 
-int get_cpuid(char *buf, size_t sz, struct perf_cpu cpu __maybe_unused)
+int get_cpuid(char *buf, size_t sz, struct perf_cpu cpu)
 {
-	struct perf_cpu_map *cpus = perf_cpu_map__new_online_cpus();
-	int ret;
+	struct perf_cpu_map *cpus;
+	int idx;
+
+	if (cpu.cpu != -1)
+		return _get_cpuid(buf, sz, cpu);
 
+	cpus = perf_cpu_map__new_online_cpus();
 	if (!cpus)
 		return EINVAL;
 
-	ret = _get_cpuid(buf, sz, cpus);
-
-	perf_cpu_map__put(cpus);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		int ret = _get_cpuid(buf, sz, cpu);
 
-	return ret;
+		if (ret == 0)
+			return 0;
+	}
+	return EINVAL;
 }
 
 char *get_cpuid_str(struct perf_pmu *pmu)
@@ -78,7 +75,7 @@ char *get_cpuid_str(struct perf_pmu *pmu)
 		return NULL;
 
 	/* read midr from list of cpus mapped to this pmu */
-	res = _get_cpuid(buf, MIDR_SIZE, pmu->cpus);
+	res = get_cpuid(buf, MIDR_SIZE, perf_cpu_map__min(pmu->cpus));
 	if (res) {
 		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
 		free(buf);
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index b77f89de12dd..3bb768455a60 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include "env.h"
 #include "pmu.h"
+#include <perf/cpumap.h>
 
 enum {
 	HEADER_RESERVED		= 0,	/* always cleared */
-- 
2.47.0.199.ga7371fff76-goog

