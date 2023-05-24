Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC99C77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbjEXWW3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjEXWV6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:21:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD91E65
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:21:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8c3186735so2679194276.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966789; x=1687558789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yt6BXRhpcaagH+Rv9t2cYW9/1vlblP5mhKX6P/6LKqg=;
        b=dJbzSZQQie8CHjExrHF45ZUOMtyCX1iCnt44dhP0OcA5CdcTLww+elNVsvkuol2Vqo
         6SAtAw+mNF64uiMUukV3FIbXgscnC1H8RCedPPxT5kIPawwbC1Azu8buOB18bZXd+OBh
         K3tOIFrGyS9Dw+tYYATG1AYjKwtz4qN4zHHTljemHMmZIW5OkZgdqresjHxIHakHZCzR
         EmD55LBaK2EO2bV3CAnhi+0njGSbHSFnrYT/+5aU0DvPHHsrzXclbobUBLfZRGF2mCZj
         7JM5COM39iCmu26T0JCSACrCzOLBe9AmUPWFHwldn/SzoFkfA1BoWDjl8nwEoAD3lIb5
         CapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966789; x=1687558789;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt6BXRhpcaagH+Rv9t2cYW9/1vlblP5mhKX6P/6LKqg=;
        b=PApk+bZq26J8waHjciubTnJtqJjAdvJF0aa0blXlNaD2nlik5Avfxxi8WoW9K7l1gX
         ahbX2wkFn2+rTUUP/juMZTQbfxWilXm+NBQ99Luy0Zc+yo90jF8ro7hWUKMOgCxoTtjz
         o7S3X/cFWpdj1XkzwMIF1HYMyk8w/iBWXMAY0vKaG9j3eNTSBXRPzRzvwOOF3sbbWSmJ
         AVfiP08gVWU1MfURGYqFJzZLJK4VanzxnWLKlmkHQkQ3zHkunzErwnTcKbvNelkNCNRr
         tkiyvtWUlzGeYsUzLDnTj4zMNhQrTxoXDys2f1S3wr4K2zoCJJg6LL/tQtURE7GXurn0
         H2vg==
X-Gm-Message-State: AC+VfDxEfPF2JIfgdPtK6ey0sPRw8oJ+ZBa7SeaRzylUJkvWwTOTwj2S
        lhPkpUUhaSvJzA7/2qEk3ZSYlC7TTiF8
X-Google-Smtp-Source: ACHHUZ5oTxfW0VyTQCXsS1bjQIoxiAPiAEQHOJqrX6Swyr52eRMCYLy2UrYgwc4t82Dkyrnr017L3WqUUqX6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:2414:0:b0:ba7:68ff:a441 with SMTP id
 k20-20020a252414000000b00ba768ffa441mr605861ybk.0.1684966789477; Wed, 24 May
 2023 15:19:49 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:28 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-33-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 32/35] perf pmus: Ensure all PMUs are read for find_by_type
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

perf_pmus__find_by_type may be called for something like a raw event,
in which case the PMU isn't guaranteed to have been looked up. Add a
second check to make sure all PMUs are loaded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 2c512345191d..6ecccb5ad03e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -142,7 +142,7 @@ static void pmu_read_sysfs(bool core_only)
 	}
 }
 
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
 {
 	struct perf_pmu *pmu;
 
@@ -150,6 +150,7 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 		if (pmu->type == type)
 			return pmu;
 	}
+
 	list_for_each_entry(pmu, &other_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
@@ -157,6 +158,18 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu = __perf_pmus__find_by_type(type);
+
+	if (pmu || read_sysfs_all_pmus)
+		return pmu;
+
+	pmu_read_sysfs(/*core_only=*/false);
+	pmu = __perf_pmus__find_by_type(type);
+	return pmu;
+}
+
 /*
  * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
  * next pmu. Returns NULL on end.
-- 
2.40.1.698.g37aff9b760-goog

