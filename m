Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE917EE49AE
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjHWIJ2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjHWIJN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE309E72
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c9d29588aso70353637b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778114; x=1693382914;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R5WZqRzaVJvIJMjlwpO1R+wpxZBFSIFOikqyfQZH1kE=;
        b=vjnAbFlXmxVBv6vhTv/dewJWBXmjwm2OZGZhVUyI+WT5WjEmpIiHXIAnBHZ/9vLEL3
         SEf147geT7ig/Nw+0gJeZpKAj6t+oojfrPtsbCVnIiSr+O3Fl3fChvDEfeWUidpZb/RJ
         stA+nOYj81ZN9/kK0gtg3S8DuPuikRuZyQjIzCDLtMDUz9y6+GktwhMjBQlLDgw853+a
         xWJoQvT7cSi2BgIA4sFXTxYkYlVkapVypIdwQ863mieqdXjiJ1beJ+FJNUBDIMtjJyz2
         8ZFX98FZFa0tk/RH4KDq3Q0inG2o8tI0noe7LJM4t2eoFMSugbojcNsxnvk2Tnjh+cb0
         GBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778114; x=1693382914;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5WZqRzaVJvIJMjlwpO1R+wpxZBFSIFOikqyfQZH1kE=;
        b=leeXVHyUiknrbn4+LmuBpM4dtLsk8tX8O/Vg8oPyn6rF87Vwb13XWkxwwI+o2s9Ajv
         /fcao6UkIi16XMUqlMoj9/DtgpbZck0f5CQU68Ur/WJt8Dsy+wKyQyZl+9yNdmOu45B5
         1Nmuip3o9l9CLJEXTH8t80lwKWCZiszGqXOgVlAK4+HRzc3jzYJliZ3nHr5Gv2AjTl0i
         Q3MOAQiZZjwYWjYK37OmxZB17SnjtEhew+c9P3vkGZ6810nUL2oUUuDKmNgc+j4tR/HX
         lTqLj1WG5fCONoPzX4OiFtfI6U2rBow3dC24WRN0naTCg9HL4g8I/MyOEO6e697zsdPq
         5qjg==
X-Gm-Message-State: AOJu0YzhvVGvBV0zxCCfPBuszWGIICXidcCMVme6pla2rPzSI2f0o5bd
        W1jdJbeOaFA+0s8AVJblXKumKgd+m74g
X-Google-Smtp-Source: AGHT+IFabHEBo1r4vNQ9MCETBVuXu18lGMDuZDFKBOYUQ77bnKyfuRUJ5IHUoxWgEiaxyrvuDZkQjPMRxYpO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a81:ad08:0:b0:58c:a9b4:a64c with SMTP id
 l8-20020a81ad08000000b0058ca9b4a64cmr147675ywh.1.1692778114142; Wed, 23 Aug
 2023 01:08:34 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:04 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-2-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 01/25] perf script ibs: Remove unused include
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
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Done to reduce dependencies on pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/amd-sample-raw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
index 6a6ddba76c75..9d0ce88e90e4 100644
--- a/tools/perf/util/amd-sample-raw.c
+++ b/tools/perf/util/amd-sample-raw.c
@@ -15,7 +15,6 @@
 #include "session.h"
 #include "evlist.h"
 #include "sample-raw.h"
-#include "pmu-events/pmu-events.h"
 #include "util/sample.h"
 
 static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
-- 
2.42.0.rc1.204.g551eb34607-goog

