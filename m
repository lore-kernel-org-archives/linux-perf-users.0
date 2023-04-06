Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1356CC76196
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Apr 2023 23:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDFXx7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Apr 2023 19:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDFXx6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2023 19:53:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE461B1
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Apr 2023 16:53:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j11-20020a25230b000000b00b6871c296bdso40111934ybj.5
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Apr 2023 16:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680825237;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FLvfuP/ppd0j0/1co5enb/ElBXDAvYlZqA+xyY4YSI0=;
        b=MolppwmDeQulqB6WA5Ouco2p4R1r5C2to0lWGjzVHcaM482Z9Z2qbmq3XwcAINxepf
         FyaqSU8m0jBggXmE0PEFmg75/745IQSTW1x/JZl1X1ca+BqygoxccjIiUW5sJaTul+pI
         Mr0R69EuJ4DyWwUh7RaKz85Am1dmQyO2HLljVgHDBs8P6NKJW5Uuy1N1FM9hRmTGpzTz
         5gGbn9h3PSS/32c1fW3inLlYvfwkJYwaWgfzyWMjmHeCzY3jWWdoYvlrrgzbh0mVui5o
         6xykRwQ7cs6rwi8Yop99ZSCdQBP5Gegw4HU80Uz6m54r9pMMNqepTAzGCewBzg/pTnAi
         B8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680825237;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLvfuP/ppd0j0/1co5enb/ElBXDAvYlZqA+xyY4YSI0=;
        b=VJLawMqQFe8n/JsNhgvF5bQpWYdop2q+jSaCWOxH7Us2pnaAvik8XvSWNsY/gGC1/K
         uBjLrtitoy0wggkO4vxp1uqO8MUNpC/6e7nqCsXfM0s0aRoVFurQD0pgdFH6dzdUZdzp
         8D/RiskQKQ0m0CcjE3cmnYpfIcjQby+kVQlwNDaeGFUdx9t/6VT4GW3KQ1tBaGGmF7Su
         gTMxvsSUgrO1+P+yxzHfpmSsv6SSTQuMZg/jGEC6FZyUgEBiKr4qEeZnN9mQimIKwifn
         rhuc6A8WSkZfqVxsbAhFOq8XzKO9HVxH5Hk+d8KdbwRmo43aStQR0LqjiMwjY7+09lFK
         nPfQ==
X-Gm-Message-State: AAQBX9ePGhHEbxlk2w9raPMECuqh6Xoo7vFZhOR4OVPvCAd64ZIu5st+
        TAXM9NnBTlpj7tshGNdGnGigdkMn1280
X-Google-Smtp-Source: AKy350bEziOXF5P1ia/8qPKeLmnd9NJTDiichJKVjV8ga2NYjwK5cvlXgdbsiEmKYbN+0fsk9G4RfaSJi+v4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:939d:185a:97bb:59ee])
 (user=irogers job=sendgmr) by 2002:a81:b1c4:0:b0:52e:ac97:115f with SMTP id
 p187-20020a81b1c4000000b0052eac97115fmr123710ywh.5.1680825236846; Thu, 06 Apr
 2023 16:53:56 -0700 (PDT)
Date:   Thu,  6 Apr 2023 16:52:54 -0700
Message-Id: <20230406235256.2768773-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v1 1/3] perf pmu: Fewer const casts
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

struct pmu_event has const char*s, only unit needs to be non-const for
the sake of passing as an out argument to strtod. Reduce the const
casts from 4 down to 1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 78a407b42ad1..63a33fcfd42d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -338,16 +338,16 @@ static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
 	struct perf_pmu_alias *alias;
 	int ret;
 	char newval[256];
-	char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
+	const char *long_desc = NULL, *topic = NULL, *unit = NULL, *pmu_name = NULL;
 	bool deprecated = false, perpkg = false;
 
 	if (pe) {
-		long_desc = (char *)pe->long_desc;
-		topic = (char *)pe->topic;
-		unit = (char *)pe->unit;
+		long_desc = pe->long_desc;
+		topic = pe->topic;
+		unit = pe->unit;
 		perpkg = pe->perpkg;
 		deprecated = pe->deprecated;
-		pmu_name = (char *)pe->pmu;
+		pmu_name = pe->pmu;
 	}
 
 	alias = malloc(sizeof(*alias));
@@ -405,7 +405,7 @@ static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char *name,
 				desc ? strdup(desc) : NULL;
 	alias->topic = topic ? strdup(topic) : NULL;
 	if (unit) {
-		if (perf_pmu__convert_scale(unit, &unit, &alias->scale) < 0)
+		if (perf_pmu__convert_scale(unit, (char **)&unit, &alias->scale) < 0)
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-- 
2.40.0.577.gac1e443424-goog

