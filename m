Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B77EC77B7C
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjE0HXc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjE0HXO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:23:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6360710CC
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:22:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5657dbf8cecso30207287b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172176; x=1687764176;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJDTWFJvEsCqEFcR+09p/LfLUHaIhto6iTEyBvf82vg=;
        b=feEPYnKtve9bpYAcmwdWjuf9tDRk8oSi4VoTBHVxiiL4m6sDY5jbBgovteYm0L/Sp7
         TjkgxkhULbRDU4CMslHYyEtBeyDeQ/m49LLHa3t9m696jHZIV9mvqWkKqSOT9nH833qL
         2VIgPJh4vGJHEE+4s1dLgrQPnTedxEjWEJiKiY1ApmL/hDRDghngvJ70pt2aQ2LZlJf+
         h9WdJrr7Tdnt3WWnkjukXpvbUr6FSbaM/kAQt7muZJ2R+s64YWd3qTHbf6T4wE7+UoEB
         nvs0ecYmbMiBPBVbNLtywierMbpQLEIT90L7hP2Lu6BREiCda6xTqe0qg+lcaWagMzsN
         m7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172176; x=1687764176;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJDTWFJvEsCqEFcR+09p/LfLUHaIhto6iTEyBvf82vg=;
        b=K2hbIZwIafvHIaMHTggmll5iUFoFc3Bb7cHVvOi9/WYsKLR5G73Xlpm/WLfBmj03zR
         AX3mbXbTbURLDNwgwmp6+9FoBuot5wCuwv8hV7LDnPVnx/cPSDsjcF+95kJbtRi/IqY9
         ZfkL49eEA1F6HwuBMyy4dZlFa6YNuy2IgmWnTqji1zNbNA3m71kuFH2rspsWYMTPaUAq
         1c0Wx8hN35CS2+IHUdopyt25QD3B8s3SmOyNOPRdDR44JZI/C9PcY6LSJ/FHUlwar55k
         13C7lMOJaNmNKUgpC7JzS0V3KuopsDGDUQYXgNlZO5CnbM3r0yhUFTDGhtyBxESCbqin
         wmOQ==
X-Gm-Message-State: AC+VfDzEtXraJgoWSjtBDyrWih8ybEbrpEKgUy87pOsILDlY34Im/tQB
        HRU/hSTSnO9epnIBj3yEUw2Rk9q2ufEZ
X-Google-Smtp-Source: ACHHUZ5O4UjV5BQjzirb1q5Z+yJ9MJMCKfvf+O6mA3Z6mhtgKlXRb0Gy5I4yBTaVjQzDIZhdgNRrzdk8ot/q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ae0c:0:b0:559:e97a:cb21 with SMTP id
 m12-20020a81ae0c000000b00559e97acb21mr2442213ywh.9.1685172176150; Sat, 27 May
 2023 00:22:56 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:46 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-11-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 10/34] perf target: Remove unused hybrid value
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

Previously this was used to modify CPU map propagation, but it is now
unnecessary as map propagation ensure core PMUs only have valid PMUs
in the CPU map from user requested CPUs.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-record.c | 2 --
 tools/perf/builtin-stat.c   | 1 -
 tools/perf/util/target.h    | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ec0f2d5f189f..d152ab04a209 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4204,8 +4204,6 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
-	rec->opts.target.hybrid = perf_pmu__has_hybrid();
-
 	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
 		arch__add_leaf_frame_record_opts(&rec->opts);
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 176deeb8ee66..8d4c4f4ca8ea 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2730,7 +2730,6 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	target.hybrid = perf_pmu__has_hybrid();
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 880f1af7f6ad..d582cae8e105 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -17,7 +17,6 @@ struct target {
 	bool	     default_per_cpu;
 	bool	     per_thread;
 	bool	     use_bpf;
-	bool	     hybrid;
 	int	     initial_delay;
 	const char   *attr_map;
 };
-- 
2.41.0.rc0.172.g3f132b7071-goog

