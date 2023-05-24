Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D46C7EE2C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbjEXWTz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbjEXWTW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F04F18E
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-560ee0df572so29563187b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966740; x=1687558740;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02rUQOyiNwiIsyzOJl6kmDGqZDjZZQRLfOwGjV/VqPE=;
        b=6nKoJ2ZO2zIHMG8Vdhftw3G8IlB6fVDXK39qsnSEPChSilm0wJ/DBoEf/QAb9CKCtT
         sfl6tJ20fNMBLh97PdjBYAb4xwqrGbsF0B0qpOXvzMqb/SbfEy09hJ36UhQFCY2+3EkZ
         Ecs+YMXsSgSVwlenuoOLTusuDp6eMpj4MthxKqw7ozC/oX/4yiAau6Ja80T5wm+YIZph
         wg2k7TOddlTZGJ5APBshhaqD7+LEbnxMoJV6jtZYQq0CsMy27uPahpzu5IDpGWSkBCKC
         hX5nos7aAoj3UzTj18VQxbOd1qzYBmweEpaWI1d5IvW0Fz2DhWgg+2qTJc+zCcK6Z6cc
         uBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966740; x=1687558740;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02rUQOyiNwiIsyzOJl6kmDGqZDjZZQRLfOwGjV/VqPE=;
        b=TDQWk/eqIb4c/NI6yz8G61N7rGdusnPtZ89a3vZ5OOiP/5lfSK5Qj1od46vt7hzYIg
         2nyzMcGiyIMAkpww5A7+tPVGTLF4dTAfbvQOPu674IX1Oi1KIx6QNwRoDRaNaOWn1Us2
         jxnd6tqghnRsYTBlVmemkaR02/IKJc6bMz7vxegSuuRgYIj1pnmyrxO6pq9vmsEb7LsI
         DthZA89w3KfGLKtbY2XGbu1h+/Hf2WzDUS96CK0dRLd2bQJXYJWNxrogZA4Gj2khCuVm
         wqZyOdNzjJI/u/eArKlJUsWWytFEdZoqT4xH0ht3lQE+fxHi/tK2sj/Ls7fUpqHlQSXV
         Vqkw==
X-Gm-Message-State: AC+VfDxGrGm+O9JnQEIbywi9axugctZdvsamcZmwMOYA84rju8u3ENVp
        aVmWSumrOQ2JLold4UBPB8DoWFFAe8rk
X-Google-Smtp-Source: ACHHUZ4T7vcSgycY4rtVGxUs6e/PZeDHYPYD8NwHQcrQfDN3dFzRusqoyw6Y03vhVSWmL2KloRvoUXcR1GS5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ad4d:0:b0:552:d924:a304 with SMTP id
 l13-20020a81ad4d000000b00552d924a304mr11478114ywk.4.1684966740240; Wed, 24
 May 2023 15:19:00 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:07 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-12-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 11/35] perf target: Remove unused hybrid value
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
index bc45cee3f77c..c70cb0990661 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2467,7 +2467,6 @@ int cmd_stat(int argc, const char **argv)
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
2.40.1.698.g37aff9b760-goog

