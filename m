Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B37AC678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 23:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCHXAQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCHXAH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 18:00:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE629D1AF5
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 14:59:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so229207ybw.13
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 14:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316391;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=GlrQtbldYu3k0DDu2d6TktZ7Zisi4Ti65+jhiOj2ThVz42pumT6W4JOSR46rVrNgNu
         czv/K1YZ45ptiohVtKfHKQX4NCEpfM/hVrF/zKj5lI0iZWmDwj3uh1NlWwbMOB5OWQpU
         35URPYb0xSx/Q5yeBRF9cHOHceFR8pS4putcy170tHUvJk2R++0yOtlczpOqHYFmw5PI
         jUtBdDRVdF3YsjQO9R3lboR2hIx4wfuNcEk8Izba6r40rz+Sny61nL/AQZPiOIr2g4ky
         rBucCcXwqRIKvU3MsPoddsWgy/MklLN9gucUxmxla3k43gjrTjunTLUEsDwDBhUTqKH0
         srEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316391;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBjmM/9ZxcY4QPw1OT563S/xkYBM1O7yZVKEKyXWS5g=;
        b=p/ZSJlMnw9mE2Gc4v/YwYZfQVbNdnHkkw6lga9oyFvXY8apmLiKwTrYfPzza1j10Yc
         Vlun69v1hpJMEfe3x1Ff0pEbAmmRH9ALWrnUMBINghAjSyzFLKxUUxmLFD256jewDBsJ
         263AEUinbCMtk5Mly4fDinL2uEsOjT5ixcTnkRrqyz+ZjIXUaouXhrEAZtVWMmfPzBNh
         uD5ADuz2+tgoCLcJU8gEPlIH8IP9L77P002PrAJE+WytZtP8cfE528PcTjdZeU4bVh4b
         6EVeRU6eVgHOVNwoXRIX3a0XJw4JaXhbLpgWGgzzd9r4uC9z37/EoIBU2PjCSwep7lpm
         RZVg==
X-Gm-Message-State: AO0yUKXKPDzrUtTwA1x6id4RPhB16R89pUakKiYwdPySsaGteoYh/mCl
        4V246S5+Sp4c4YJLTHcB8O5v1lnWcwRY
X-Google-Smtp-Source: AK7set/H+awlmY7U1lmpbmtoMOdaIIQvJl0gR0hCJ93z0iImqLD5HSaQIYaP1vL/hmVoCX3BQcQN8qKFrYBQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a5b:9c8:0:b0:a1a:ba40:9790 with SMTP id
 y8-20020a5b09c8000000b00a1aba409790mr3ybq.251.1678316391572; Wed, 08 Mar 2023
 14:59:51 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:05 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-5-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 04/11] perf stat: Modify the group test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
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

