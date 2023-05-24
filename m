Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF80C77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbjEXWTd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbjEXWTR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:19:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EE19D
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564f6099813so29586387b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966738; x=1687558738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1GDqhuhALscXPKh6eW/Ok5E7hxu+Cdr1krhYltfFoAk=;
        b=SNqtFPGQVnr4w8egpCSubSaXhVTLKjLdVF/wFOSP5H++vlIJPYJLnjJa+r5b/zXpdj
         sf86HjTJZfzi8pfsa9/f6DQvL2Z5FwyfBykVVjj/ZHiYiiXCPTt0tO+7swzm2O5E0RNl
         6/zf9HDiY1pm0LGnLTrEZzJPX4Rd76VXns+uHlNI+lvhyOzahLwiqLEfh1aTqkEWjhaK
         CIGKxQVPZKq7wkVr7w7w4K28rVnMOSjTDFFQi7yUE5UXpjgB5v5G2VrwtQVzBXpdgaHf
         gDy0Rnq/caZLJZuHgB6qF/VM+Spj9vnVcbEcsH0vYdwkESqr8D7m4HlzTBQUv9KJaNDo
         6qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966738; x=1687558738;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GDqhuhALscXPKh6eW/Ok5E7hxu+Cdr1krhYltfFoAk=;
        b=PqPIqlPCEW7avyrZKOTDEcOhDngUuX2mNQ8zEj4P11Air6Ee6Z65Hkb9UWQjYFY4AB
         KboH97aROMdNR3xblUdrEeTUBW3Ge8CWuM5UvRskx7ksZOg+Ov94TpTeN/ltMX88J2mq
         tNHPPmE/DFnjdAbvSXiDL2evTk+NWp+l0YA6Idw53BuCY4HfTx3NIRJlZhTiSDjzOa79
         6g4Gd7xe8ZjoTMoosg3O184ef/N3IN3/mParPqgCYB51bFp9dl81+CXxP7P5JHBCM97G
         4fHJYDZdWXFbCklcC/kp95peUploH3JjTltCutlz1L1ZPNkxmqpKVyShcygsdWSyvsuq
         XUVg==
X-Gm-Message-State: AC+VfDzjLc5DSD5gD3frYj9pYcUl6+3UnGIhelkFWB0E1OZX5p1BJfuO
        3AYyV2aJ2Lqu5uDsHh/YTp9BluHnt80Q
X-Google-Smtp-Source: ACHHUZ62cL31QtcLPt6L7GAvXC3BNk7BWMiqw6dzsT68FbgIH7rTRzHWyAjtzVAe9UpHLGfWmGYM7NAUHAtz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ac0e:0:b0:561:a7d5:ec0d with SMTP id
 k14-20020a81ac0e000000b00561a7d5ec0dmr11443469ywh.0.1684966737912; Wed, 24
 May 2023 15:18:57 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:06 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-11-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 10/35] perf evlist: Allow has_user_cpus to be set on hybrid
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
2.40.1.698.g37aff9b760-goog

