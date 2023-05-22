Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A509C77B75
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 06:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjEVGrJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 02:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjEVGqH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 02:46:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FA1731
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed51adso10456747276.0
        for <linux-perf-users@vger.kernel.org>; Sun, 21 May 2023 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684737868; x=1687329868;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+aFtpu9F2yGljXWeZ17LuoYXO4ZNmuRrdV4BNXebZU=;
        b=WaMOe5OUll0Sz3acYm4uBfP9Z16Iny/8w4BooK0DItssmCmNzxlUurQkN2coR0gNZn
         VA9XDIt83nTT1n/huWCKal3K6IbRP/7461ldA4ftEms4RfXQKm6GC4TaZwpQGFfcTKqB
         oIYrXtvyVFtZKxpNNgMT7H8kXvww57QD6IXbvkv3pwYxvv3Xz5UXm4RtaYEssAp4liK9
         C4nuzxzYmak9iZYoexyN6LBpeLG85ppM9G08VP2VyuaeDKLi2TYGZxF9s9/ynZ4RtTJn
         U7hw7jr42r3RXEZu0ZFOeXm+Q48UG/nUdfFzp8U7CchRVHGNj9b29tj0LfL0gIUiaLWu
         xB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684737868; x=1687329868;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+aFtpu9F2yGljXWeZ17LuoYXO4ZNmuRrdV4BNXebZU=;
        b=TkcrmY88R4wfMDvOGTcFcs9qioZtTNyj2FRckQmSorAF2QKYzsGef5pRO/e1Nu7Mha
         qxi6dwHIawY87N6Hu2hjCKGtMpBjn3wYyr507eRmq+2P2GvCBLF/Jm1Zno0MUbCQcQ4Y
         G1qU4bm1F35asdpL8t9qIJSfzA+taKWc7ZYAE9RsjqgdWo5KS85TfnbB6x/mrra3vJsd
         5IbD6kbmU54f8Efu4fljWhwoZLZzeynjlvwmbWw8pbR79WxFrCvImno/MTssuhRt/vp9
         eoOM96AR3PZF8Oe2edgfFGIUACp1dK7ghWhBKnqUcydPrw93+R8eGSh9pCA2CePLjYtS
         Fo1A==
X-Gm-Message-State: AC+VfDyDOEZuDCYPcPfr5vgA4G0g6QD0NijuYPx9abThKn2eArXenADV
        s/D9CW6pfM43NjKx/pyc7kvEpBZO5eRD
X-Google-Smtp-Source: ACHHUZ4VYf6iGuG5alZmBIczqrBWEaYLm65RVnA3VZh2jBU21XmP0FFw2fc2n/SzpDwfAuNUisc8brDXSjVm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:48d9:8c21:e099:7301])
 (user=irogers job=sendgmr) by 2002:a25:bb41:0:b0:b9a:6508:1b5f with SMTP id
 b1-20020a25bb41000000b00b9a65081b5fmr3592765ybk.11.1684737868018; Sun, 21 May
 2023 23:44:28 -0700 (PDT)
Date:   Sun, 21 May 2023 23:43:29 -0700
In-Reply-To: <20230522064330.189127-1-irogers@google.com>
Message-Id: <20230522064330.189127-23-irogers@google.com>
Mime-Version: 1.0
References: <20230522064330.189127-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 22/23] perf pmus: Avoid repeated sysfs scanning
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

perf_pmus__scan will process every directory in sysfs to see if it is
a PMU, attempting to add it if not already in the pmus list. Add two
booleans to record whether this scanning has been done for core or all
PMUs. Skip scanning in the event that scanning has already occurred.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 5736e99facd1..22e9e46ab765 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -14,6 +14,8 @@
 
 static LIST_HEAD(core_pmus);
 static LIST_HEAD(other_pmus);
+static bool read_sysfs_core_pmus;
+static bool read_sysfs_all_pmus;
 
 void perf_pmus__destroy(void)
 {
@@ -29,6 +31,8 @@ void perf_pmus__destroy(void)
 
 		perf_pmu__delete(pmu);
 	}
+	read_sysfs_core_pmus = false;
+	read_sysfs_all_pmus = false;
 }
 
 static struct perf_pmu *pmu_find(const char *name)
@@ -53,6 +57,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 {
 	struct perf_pmu *pmu;
 	int dirfd;
+	bool core_pmu;
 
 	/*
 	 * Once PMU is loaded it stays in the list,
@@ -63,8 +68,15 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	if (pmu)
 		return pmu;
 
+	if (read_sysfs_all_pmus)
+		return NULL;
+
+	core_pmu = is_pmu_core(name);
+	if (core_pmu && read_sysfs_core_pmus)
+		return NULL;
+
 	dirfd = perf_pmu__event_source_devices_fd();
-	pmu = perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
+	pmu = perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
 	close(dirfd);
 
 	return pmu;
@@ -73,6 +85,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 {
 	struct perf_pmu *pmu;
+	bool core_pmu;
 
 	/*
 	 * Once PMU is loaded it stays in the list,
@@ -83,7 +96,14 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	if (pmu)
 		return pmu;
 
-	return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &other_pmus, dirfd, name);
+	if (read_sysfs_all_pmus)
+		return NULL;
+
+	core_pmu = is_pmu_core(name);
+	if (core_pmu && read_sysfs_core_pmus)
+		return NULL;
+
+	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name);
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -93,6 +113,9 @@ static void pmu_read_sysfs(bool core_only)
 	DIR *dir;
 	struct dirent *dent;
 
+	if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
+		return;
+
 	fd = perf_pmu__event_source_devices_fd();
 	if (fd < 0)
 		return;
@@ -111,6 +134,12 @@ static void pmu_read_sysfs(bool core_only)
 	}
 
 	closedir(dir);
+	if (core_only) {
+		read_sysfs_core_pmus = true;
+	} else {
+		read_sysfs_core_pmus = true;
+		read_sysfs_all_pmus = true;
+	}
 }
 
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
-- 
2.40.1.698.g37aff9b760-goog

