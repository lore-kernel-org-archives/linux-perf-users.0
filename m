Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E501FC7EE31
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjE0H0y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbjE0HZ1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:25:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B7E1721
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:24:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ba5667d5so23101377b3.0
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172223; x=1687764223;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rh9VPjugtBPm6X+hrybIGNZEfoE06aG1Vq+cBf1Euw8=;
        b=r0mpCy0lGZyvfrm4W35bC646coxeGE0T/kSRr50y2P56BGfokwpNidgydSYfk1itmt
         pLbHWr3LNX5cBVrRV83jBbBh4GgLbyr1sx90KLDZm4s+msqQg5TPc1o4pD5Dhhr7/Mh5
         CkRUvPW5ly2q2eWh4mxiEa5EynGdnztPYpWYnHosw4EVqi+lSOGMY3t6C5xFPCZdQqIx
         yGNcvvnWKTF7X4tz+o4dw+/tVGWO8WiN4LYZrseCKtSVBw/GCF4Mi8iUSQItsjF1/ge1
         jsoxhkNjBJ+0eRNabf/nEez5GQxQXlBQ9Ps1/VGam5NqgKVwG/vHa0FoXGbdGjIXDNS6
         R5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172223; x=1687764223;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh9VPjugtBPm6X+hrybIGNZEfoE06aG1Vq+cBf1Euw8=;
        b=B2ot4puMp8itg9LLzboXuRE1vEN7UFp5v958R5HqPZPok5fEzciYDxLLXyVJF9gC2l
         sI1pD1+eKRPHAyDJP5/hJUiDYD7Bwv5bGPEErTeDVzv9aBJbn3eI74IJQmYhV5r0c7K/
         Zh132UdpgezGj+qspVCHfrkzPZh12rIg7Y7HGeix1gVNHU7kDUIoGMUBBkDKai0qWP/e
         hq6Z4aAWl/ecCt83F/KBg9N3td+1c2/guj1G0jEQfQErFyP9GrSV23bAgT/rZ9Eo07TQ
         8gQHyI3SK/RuOCkHzf4tOBn4jBIc9yLSbfaoexFi2bD9Dp6rf+83ftUFjClAEog7SyGd
         WVxQ==
X-Gm-Message-State: AC+VfDyQh6mZ0D5xEMKkUvRtXRJTy+o/uUu4USNLWBwt2T0xanJpRSt8
        pchFnmAYrYlI/n3Y1j+iNWkhrfCAaQ3u
X-Google-Smtp-Source: ACHHUZ5TpHSYN9xqqYVbAzsfS3as8XAdzTyPO2AkByUbViLzIDa8wISYrpr6ifcVnt5dPJwW5hnHJCMevHAs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ae21:0:b0:565:ce25:2693 with SMTP id
 m33-20020a81ae21000000b00565ce252693mr761021ywh.3.1685172223260; Sat, 27 May
 2023 00:23:43 -0700 (PDT)
Date:   Sat, 27 May 2023 00:22:06 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-31-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 30/34] perf pmus: Avoid repeated sysfs scanning
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmus.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index de7fc36519c9..2c512345191d 100644
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
2.41.0.rc0.172.g3f132b7071-goog

