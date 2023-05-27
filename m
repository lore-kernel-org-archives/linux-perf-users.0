Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD101C77B7C
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjE0HY2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjE0HYI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:24:08 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5867510C6
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-75aff1596d3so277035385a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172194; x=1687764194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKlpZwIe+ZNMqSgCu8evjP4rcM8k5wR/kLw9LO8buYU=;
        b=lsZLeHt5sAbeY7UZ0KeCF7oCQNqze4XVDBB51YNyFTPseP/6U28Jwpu8SY0CwhLDSE
         tpa1XII3YpCbwOoh5Fd2BOD9GyUYKW6Ah+AAOJe135CVOsm3rIMB1/wos/3d8ThA0qMG
         qsd8FS901G/nV5YGFGGQ2c+4WTJ4ryArpyEFOsbity3IhAoXt5GpH1u4UFN8D0JJbZIz
         htK0BYRY+UBSxNMFyx4AMvxubhvRCgpuXJmxqHeTw5joUCq0I+tZsm00WBMn115McmCv
         AcikFFlGivB2xbjVmYPVvBWful9CtaV+bCdtGbzI+1/tWQByYgVy6lzpp3YT1VdUR3Ve
         xrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172194; x=1687764194;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKlpZwIe+ZNMqSgCu8evjP4rcM8k5wR/kLw9LO8buYU=;
        b=S7D4cHsvZQQfd2pMQyYayaRocs9SVbjph4PKd6Nb5p7RvMhnZPtz64AivL8UsG7cmL
         wc93OninXSHBIkBEPy/OVOMbkkUO/iya/+ySufwm2tJHEuljyeymnne0g1xY6eXWh+qy
         URTGAyN9hDt3c2eHKykWNVnji/m+NrS60nFDC8n3JeN2cCH6EtoenX4mz+zS2qRJM7AR
         oOwTfi628GYbi74pb01GvnDvP+cZcuHD0scDFBASKfdg72PYC2CrU6QTL1649dCaEK+t
         883pXguDsRocTrmnJ4jYtSe+nagrMXqy9l3s5VgsuS23un8ACOauywu9uOVGRDXalmTz
         KFMg==
X-Gm-Message-State: AC+VfDylPqWanakgGu9G/3pyMuvBdn0pEIx8S6znnHY05ApMDSeKpv8/
        LI4WKwOG2mRCzpm2ROdeCb97Cm8VP6ld
X-Google-Smtp-Source: ACHHUZ4jekes7nIRnkxzUdy4DbvGJAqgfFnphibXKR3KuIyMq02R8j6YRDjQghdmNBvBIuDqp/vlPDxErrXl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:a989:0:b0:552:b607:634b with SMTP id
 g131-20020a81a989000000b00552b607634bmr2512177ywh.4.1685172173971; Sat, 27
 May 2023 00:22:53 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:45 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-10-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 09/34] perf evlist: Allow has_user_cpus to be set on hybrid
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

Now that CPU map propagation only sets valid CPUs for core PMUs, there
is no reason to disable "has_user_cpus" for hybrid.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a0504316b06f..2e2c3509bec3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	if (!cpus)
 		goto out_delete_threads;
 
-	evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
+	evlist->core.has_user_cpus = !!target->cpu_list;
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

