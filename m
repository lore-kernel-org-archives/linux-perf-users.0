Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CAC6FA8E
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 22:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCBWYU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCBWYT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 17:24:19 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B1418AB7
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 14:24:18 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id h19-20020a056e021d9300b00318f6b50475so441107ila.21
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677795857;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=IB4KwzIDhOV3szJy3KFFxkUyUK+4zYercmpCvtxQb9tlM3x7sKAZG1PyFvfKUbTmD2
         YqS3VTbQcqsvGZQGb5FyogPjHhB/6eORsYO5nFtwgERINFYO2i4nn4OaF4JqxWFLfMpF
         V2SkIu5hIxgeou3aPONjSrplbzYZuRrAeIDVNOsSO71nCx26Tzgv2CCYp/PNagWhcvJs
         t8WVpyk3gqnwVu2MUX7nleqMT0SiDuDtlxuRFiysfh+KskmbFmS4WZ7qGc1A1ci1hwRy
         3bxeARhONVpdnZNG/4hmTLwilDCjMTxycijfPZtqRh13DvcAG3/ml+Gp5CH6IqVursiD
         0m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795857;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=EYAqalScwKT89FafDlATFx4d7Zd/e8vzylY3ZQiZ5+ncJCsL6cGHmtjCwcFaPzCPwP
         k5tsQDf9VrTrSltZWAORQKa5bIImBhd0mKduwWaP7bxoIUbEMK6mHa4rh+i8TFYZFSpT
         +H54mcp/f8gOsto6Z+xmekU+jNnGYz+ETiM/d1rvs9POUSAYF89dLfjvt601PGMKH4TS
         4ZtiQwJRsZ6CkB/V24TxoDCvq1CoL2JPb9zlWFYKD0XOEsy1EzwBeth1Tbo0LvqSqU3m
         wJcE8RCmuP9YyQQJI4jBdL2/v+C4La4afo3tnY3Gg6x62fDctkmc8TqP5NezBRurhQZ2
         kkHQ==
X-Gm-Message-State: AO0yUKU8eH6p3eChzEudy7t5SoDaAB5glSwmgjMExk//8w34n4nK2Bd2
        kLzpg7ERcZsyGaV+uq1A3rtPBhYVXaDb
X-Google-Smtp-Source: AK7set/VsA1HeM14pe/4lFMqpkMj6EPzo21Zf4W04XTdb1j3BgpGJ06CGU154fyiO+ld8pTCysXaZZgkXxmf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a5b:1cf:0:b0:a43:52fe:c36f with SMTP id
 f15-20020a5b01cf000000b00a4352fec36fmr5200622ybp.7.1677792379741; Thu, 02 Mar
 2023 13:26:19 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:25 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-5-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 04/10] perf stat: Modify the group test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently nr_members is 0 for an event with no group, however, they
are always a leader of their own group. A later change will make that
count 1 because the event is its own leader. Make the find_stat logic
consistent with this, an improvement suggested by Namhyung Kim.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index ef85f1ae1ab2..eeccab6751d7 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -163,7 +163,7 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 			continue;
 
 		/* Ignore evsels that are part of different groups. */
-		if (evsel->core.leader->nr_members &&
+		if (evsel->core.leader->nr_members > 1 &&
 		    evsel->core.leader != cur->core.leader)
 			continue;
 		/* Ignore evsels with mismatched modifiers. */
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

