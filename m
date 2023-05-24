Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6524BC7EE2C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjEXWUA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbjEXWTh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992D41BD
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:21 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559c416b024so18511257b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966752; x=1687558752;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZYg2JPOF5mh3/s2R7+J9pQ85BbOWb9mT0CXNZohOl8=;
        b=CD5hlVHqEv/Y7LWF/Spza457wbC1CEDsm/P+9HoyOabOuNgeuvyrFQLdBLAvMRBXy6
         lrXn898aq2EUWKPiSdpCTV2BnE00nVGYWbN7Rmap/hIGhmJs/eEM0PfaahZ4HNqh11lU
         p0sCvaBiHhPW307HM2Zxj1AKhOSwQa3ScmnN9fK0snogBpVdNg/fZuQKubHX6rKZ6UBn
         R/njOEYTnBHfRqdWGKtcemHDlTvHdG/GYSdxwoddYp2C9UzLSUXu/rhh8K9xSfUbAAkB
         ShGEhuK5OJHMCNSlO5ZzVEf0mFqU4nnn+uYq1nsz7AEep5uvJ/UwxwYqpeCKznLZqsa+
         9+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966752; x=1687558752;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZYg2JPOF5mh3/s2R7+J9pQ85BbOWb9mT0CXNZohOl8=;
        b=lnikH5QJdr1Tgz9VK4+e7KwwJCJcCFK4hoWu5ZPg6Q7mfvqOSUYjwyC7iULqMl6kP0
         r7KqOxz0ohBbpuNJ698JMSmX04mlqy6/WTVVk/ja/zNmMoHCeyIxFDUDdFa5I8YzsVCk
         nekJU3o6FRPB02n0/sJNpUBvgLEBsjK1NNwjcIiPvo35euwMjjrGJEylqDH5TOXnHT/q
         a+DEk8UDoDQoF0O1t06E2Bsw7SXePy8qi1JoC9JDC/z4cL29RPprINitg8QXOaqjBl8h
         YyTYfDMoyNQxpxFencjfqyjd2g8n9tPc/62SLo2hAwf7FZumMXA3Z7piJnvkNR494Zkc
         b31w==
X-Gm-Message-State: AC+VfDxmAkAHKvVDRtfgqDfMJD8crzKXcBXbxv9VDenmBdCIAVcNl5kQ
        rkrhBSBSeyszikr134VGcfCJpCeeYIAT
X-Google-Smtp-Source: ACHHUZ7bYaKDOPGf0vOTAfySDo8dgtk3bBSmCzfAWgcCnDA9+/qbenId3D6EtgKGdRUNwdx0wWFFOIDjBmLI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:7652:0:b0:561:c567:c8ff with SMTP id
 j18-20020a817652000000b00561c567c8ffmr11891423ywk.4.1684966752285; Wed, 24
 May 2023 15:19:12 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:12 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-17-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 16/35] perf pmu: Remove perf_pmu__hybrid_mounted
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_pmu__hybrid_mounted is used to detect whether cpu_core or
cpu_atom is mounted with a non-empty cpus file by
pmu_lookup. pmu_lookup will attempt to read the cpus file too and so
the check can be folded into this.

Checking hybrid_mounted in pmu_is_uncore is redundant as the next
cpumask read will fail returning false.

Reduce the scope of perf_pmu__find_hybrid_pmu by making it static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu-hybrid.c | 15 +--------------
 tools/perf/util/pmu-hybrid.h |  3 ---
 tools/perf/util/pmu.c        | 26 ++++++++++++++------------
 3 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
index bc4cb0738c35..7fe943dd3217 100644
--- a/tools/perf/util/pmu-hybrid.c
+++ b/tools/perf/util/pmu-hybrid.c
@@ -18,20 +18,7 @@
 
 LIST_HEAD(perf_pmu__hybrid_pmus);
 
-bool perf_pmu__hybrid_mounted(const char *name)
-{
-	int cpu;
-	char pmu_name[PATH_MAX];
-	struct perf_pmu pmu = {.name = pmu_name};
-
-	if (strncmp(name, "cpu_", 4))
-		return false;
-
-	strlcpy(pmu_name, name, sizeof(pmu_name));
-	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
-}
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
+static struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
 {
 	struct perf_pmu *pmu;
 
diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
index 206b94931531..8dbcae935020 100644
--- a/tools/perf/util/pmu-hybrid.h
+++ b/tools/perf/util/pmu-hybrid.h
@@ -13,9 +13,6 @@ extern struct list_head perf_pmu__hybrid_pmus;
 #define perf_pmu__for_each_hybrid_pmu(pmu)	\
 	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
 
-bool perf_pmu__hybrid_mounted(const char *name);
-
-struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
 bool perf_pmu__is_hybrid(const char *name);
 
 static inline int perf_pmu__hybrid_pmu_num(void)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cd94abe7a87a..e9f3e6a777c0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -617,9 +617,6 @@ static bool pmu_is_uncore(int dirfd, const char *name)
 {
 	int fd;
 
-	if (perf_pmu__hybrid_mounted(name))
-		return false;
-
 	fd = perf_pmu__pathname_fd(dirfd, name, "cpumask", O_PATH);
 	if (fd < 0)
 		return false;
@@ -900,6 +897,16 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
 	return max_precise;
 }
 
+/**
+ * perf_pmu__skip_empty_cpus() - should pmu_lookup skip the named PMU if the
+ *      cpus or cpumask file isn't present?
+ * @name: Name of PMU.
+ */
+static bool perf_pmu__skip_empty_cpus(const char *name)
+{
+	return !strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom");
+}
+
 static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 {
 	struct perf_pmu *pmu;
@@ -907,15 +914,8 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	LIST_HEAD(aliases);
 	__u32 type;
 	char *name = pmu_find_real_name(lookup_name);
-	bool is_hybrid = perf_pmu__hybrid_mounted(name);
 	char *alias_name;
 
-	/*
-	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
-	 */
-	if (!strncmp(name, "cpu_", 4) && !is_hybrid)
-		return NULL;
-
 	/*
 	 * The pmu data we store & need consists of the pmu
 	 * type value and format definitions. Load both right
@@ -935,8 +935,10 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 		return NULL;
 
 	pmu->cpus = pmu_cpumask(dirfd, name);
-	pmu->name = strdup(name);
+	if (!pmu->cpus && perf_pmu__skip_empty_cpus(name))
+		goto err;
 
+	pmu->name = strdup(name);
 	if (!pmu->name)
 		goto err;
 
@@ -967,7 +969,7 @@ static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
-	if (is_hybrid)
+	if (!strcmp(name, "cpu_core") || !strcmp(name, "cpu_atom"))
 		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
 	else
 		INIT_LIST_HEAD(&pmu->hybrid_list);
-- 
2.40.1.698.g37aff9b760-goog

