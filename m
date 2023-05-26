Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B488C77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244283AbjEZV5f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244289AbjEZV4z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:56:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892BB1711
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:56:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacd408046cso2656255276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138123; x=1687730123;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rh9VPjugtBPm6X+hrybIGNZEfoE06aG1Vq+cBf1Euw8=;
        b=NT47HnCq13e2wZRzBEQWWbHa/45uvSJ/XVEwTiDIWl1gDOzU7WvOS2G/IJ5doVx4AG
         HDJ+am3vb+kV/p1Z7SsxVG2Xpvdd5jMwtiWLTdgSOWbczhyR+kDdn3YesUdkW6qJvfeT
         rYAq1RljWhu/+pnAP2BF6TRkkP3YaZatsjHazMIyTwIglHKhqD2l33MfmWciS6kTcqgF
         b6B9h4GNjQwp6TxdvDgQCv5pLmko9M+nBiGytDeb9QNrigkOPNFadhoiw4Eq4zwqUtix
         qVYZ79buD0oir3DABZBTE8DO/WSaGe4DoB4bVCoQXYB4tdLNUCQMsBHc+MEEu6MXtOiG
         BBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138123; x=1687730123;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh9VPjugtBPm6X+hrybIGNZEfoE06aG1Vq+cBf1Euw8=;
        b=jTeh94jIBzznt/K+yHKo9SqbEphJbUcrMqGi/usewtpMQGdSs8lqBpXWG2EV3jVEj5
         75zWBaaTwDRNsjvkWYmSWwdu5PmXRjoz+J/mYg3zfw8ckdzTn4JOfCYh1ujcFLwNeXpx
         iclYwlgI4cSvr8YC8poYZYWxSHc3aJjX/Udvhk5+F14SUrvDGKhI/PHtMW9dZtsV4+bh
         afxqGByEEMZWG8GQTO154kiPjis0L77QN2TarF/Z8k38RAtVC/E6+jDXJHRTiifBLf4S
         7FkfQoRp0C8ZZNt5MkUqN3KLnbKVCg7GRXSpdip0Tcv2b79SXYYgyxXUvYJUY0YlanfW
         tloA==
X-Gm-Message-State: AC+VfDwQtlsiZdfTQjbJvxn7EWFSfBT/uUht8GP+vgGUYEGos2fd2SZl
        sHgSQE6NQnZ24coSyab3+8F029Ufg4RR
X-Google-Smtp-Source: ACHHUZ6Iu1fmtHJGUmPzxev78Fx3TvKNcbnqx6CoeWzqHZJpPNCQBBZPeyu1JlueZVJRFDGqvNyf/oaRflmQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:2646:0:b0:bad:41b:f343 with SMTP id
 m67-20020a252646000000b00bad041bf343mr1730959ybm.1.1685138123360; Fri, 26 May
 2023 14:55:23 -0700 (PDT)
Date:   Fri, 26 May 2023 14:54:06 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-32-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 31/35] perf pmus: Avoid repeated sysfs scanning
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

