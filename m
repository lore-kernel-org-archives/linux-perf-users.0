Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921E0C7EE23
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjE0HYS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjE0HYD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:24:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37AFE76
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:33 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2563afb0150so1072023a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172190; x=1687764190;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwNQ71nzWAtCurlrP6FCuEtDPR9XmwsHJykHXM8qing=;
        b=lOmkzKB/CDHXV/rco7HS2RvubFjRAX64Al/x/EveVXU+0EEbRI8AWv2xMFWJhKQCtV
         /8zoblOYubNZ1ztF7yf55Ugp4qBvu02MYXnz9Rhu0yZ2ixeo0LoYzpzS5z4YIEH6N4Op
         sVCEH62LkRrUAc3vbKYQ+TJ6iZqsSpKFbAh86EEmY8fIdwlskwcUxW0fu/46vt+mV7lX
         JdwDskbPIfkzzyIGTjkOypbJrFnoEdZyfcfAQlloVlkHDMrVF1tFvSdKVokf/2gQqAY/
         gXQDr+pOcntJtC7Odt3SiKE6CP1CUzqHWm1PpXA6VqAZjpNQTnSvxkFqjZ3Lshi7pnrx
         zgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172190; x=1687764190;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwNQ71nzWAtCurlrP6FCuEtDPR9XmwsHJykHXM8qing=;
        b=JvhHgljF5TS/wmL9AgTKfABH7PSeYsuNAZVkLWLSIODu9gsSbezh7Ef4+j/cNGVVz9
         VXRa1p5tKN3UaU8+3q7DJgz0iXUiCuH3QF6/SkHuOcsuPNviaweQSzIq9tvFHOCAKfP+
         0fHwDvnW70Y9zaP58oeC4NqyttE9kObhf6fkl2FHKLqY4VJIquUhuVrdkDH94iGTA9uj
         4epsoYtoYohpnpE+rmk/wtecvcM0jrmPXFENjXg5ujsh/YmP+YX4whfXM0AmB9yFiFUj
         pNZfNdc1ep3zl7U4wtL0yWGCTBS1nRApMsc17+oHpx+uVmvwPAwOhOFr8tS+XORJiXWC
         o7ig==
X-Gm-Message-State: AC+VfDx7N1iSEU5BMim48Chw1EwM+WZYN0u/8xUAKNerTFHc1FDylGPJ
        rsFIGZbxkgSzuskpZ+l9Kq6d+KM/bw0Z
X-Google-Smtp-Source: ACHHUZ7UV8GZgGYFzC4oxTs1TYELikiLvG9qg0wVWQ4EFn9Nb8epp081W/xOPomIVYFOAD5jMOcSUqzwfE1P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a17:902:bb92:b0:1ad:e398:4477 with SMTP id
 m18-20020a170902bb9200b001ade3984477mr1200446pls.8.1685172190553; Sat, 27 May
 2023 00:23:10 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:52 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-17-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 16/34] perf pmu: Rewrite perf_pmu__has_hybrid to avoid list
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

Rather than list empty on perf_pmu__hybrid_pmus, detect if any core
PMUs match the hybrid name. Computed values held in statics to avoid
recomputation.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 83c7eeb8abea..5a7bfbf621d0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -60,8 +60,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-static bool hybrid_scanned;
-
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
 
 /*
@@ -2013,12 +2011,20 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
 
 bool perf_pmu__has_hybrid(void)
 {
+	static bool hybrid_scanned, has_hybrid;
+
 	if (!hybrid_scanned) {
+		struct perf_pmu *pmu = NULL;
+
+		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+			if (pmu->is_core && is_pmu_hybrid(pmu->name)) {
+				has_hybrid = true;
+				break;
+			}
+		}
 		hybrid_scanned = true;
-		perf_pmu__scan(NULL);
 	}
-
-	return !list_empty(&perf_pmu__hybrid_pmus);
+	return has_hybrid;
 }
 
 int perf_pmu__match(char *pattern, char *name, char *tok)
-- 
2.41.0.rc0.172.g3f132b7071-goog

