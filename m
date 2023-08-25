Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A2AEE49B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 02:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbjHYCks (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 22:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbjHYCkj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4E1BDB
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59299db9977so3703367b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931237; x=1693536037;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHXteoJsO5CjisE3iWmyoU3o62DiyCouesqp1NV6ZaY=;
        b=aM1+/Q9/kqw9FPRt+ilUC2t7yHLdncPzCcyJOdfOPAzDkrfOyw4un0h7kWm/0Qss3d
         NZFW3A2SdinUDE2lpqWfXf87L12zQUGFk4HnP+F43itYhRV9t8p4sPKvIxpLO4O1e5ry
         xWTvly0fX09Jg95DitgN79YkII2+4qbIpeeQQLydHeV4IFgM1g6nevB8+LkEG1TR1gyo
         IgsiBX1y1/dn65Bvbkbn14tFgtJtGGxxK0KrXwN0HheDF/LrN7dc2LyhkLbEGu0uyqK1
         VEVzzuFW9e/yWmLZP3luTRDeMbdMaF1I55SoCgD1dSo+nZFJUAJiI13BEx3e16PI+zJV
         sRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931237; x=1693536037;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHXteoJsO5CjisE3iWmyoU3o62DiyCouesqp1NV6ZaY=;
        b=hK61QhgRHDUITvgOwj4dil0qzRafvN7OWcam3noTAMDzpBV5gMEHbVq0IwHBp9RtOx
         r5IZ58W1e7fkfrI7anS/DZGkU1kt9j1oQrwPA20HnXBZjpbL3yYS5HBRaHB62IHFO4gH
         O7DXshC+HnVCPr1JPWmfPWSZuE/SAXQhs+3qkqrfzn+u/EzMLxooMvAC8S3T21s5qV0z
         xqY/5lZW/Lq4vecSWou9PYY3N9SAOCQXkw0jO8eRfQVIRwcoMIjhom//fVvBThZnS6uN
         imMLTczbSasHPzoCUE4mVkNXb7LcsHv4keVfS+ehKPxYKjFoyV/DHrzquVym9MOJbtcP
         xBcA==
X-Gm-Message-State: AOJu0YxbOJ+hnlqvsnEklSx96PqLL642KmXcMQ6SCIQuGT2VYWtnl+7+
        2Wve5a5GN7QmLjHDcwYr4RJlChDzbZFr
X-Google-Smtp-Source: AGHT+IGaNkQKvYICmjYwbFYZkcVjwo9/uyNhIHNgKwBwkDBYJTIRQcWeE5epFd3NZyNnRo3DSrMjLPSFkFEv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a81:b660:0:b0:573:5797:4b9e with SMTP id
 h32-20020a81b660000000b0057357974b9emr373461ywk.1.1692931237087; Thu, 24 Aug
 2023 19:40:37 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:40:00 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-5-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 4/6] perf pmu: Make id const and add missing free
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The struct pmu id is initialized from pmu_id that is read into
allocated memory from a file, as such it needs free-ing in
pmu__delete. Make the id value const so that we can remove casts in
tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 4 ++--
 tools/perf/util/pmu.c         | 1 +
 tools/perf/util/pmu.h         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 94937378647a..eb243392c0f4 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -684,7 +684,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 		.pmu = {
 			.name = "uncore_sys_ddr_pmu0",
 			.is_uncore = 1,
-			.id = (char *)"v8",
+			.id = "v8",
 		},
 		.aliases = {
 			&sys_ddr_pmu_write_cycles,
@@ -694,7 +694,7 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 		.pmu = {
 			.name = "uncore_sys_ccn_pmu4",
 			.is_uncore = 1,
-			.id = (char *)"0x01",
+			.id = "0x01",
 		},
 		.aliases = {
 			&sys_ccn_pmu_read_cycles,
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index eb42f9830be7..b92dc7237f3b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2056,6 +2056,7 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->default_config);
 	zfree(&pmu->name);
 	zfree(&pmu->alias_name);
+	zfree(&pmu->id);
 	free(pmu);
 }
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e90169ab3dc2..73965f208009 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -49,7 +49,7 @@ struct perf_pmu {
 	 * @id: Optional PMU identifier read from
 	 * <sysfs>/bus/event_source/devices/<name>/identifier.
 	 */
-	char *id;
+	const char *id;
 	/**
 	 * @type: Perf event attributed type value, read from
 	 * <sysfs>/bus/event_source/devices/<name>/type.
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

