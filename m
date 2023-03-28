Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F144C76195
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 01:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjC1Blu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjC1Blr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 21:41:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BB226B6
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 18:41:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-545dd1a1e31so51496817b3.22
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 18:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967698;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywXshmLmOGjaY4x40OQowm4pf0YHZ4IGihkPimWY52w=;
        b=JIUT89bxDoFZJcK7cHK+S1+2ScqvgAOhnR2/gdEVFiQdimTI5sLS7tYKXNHkd/wfDN
         azXmzSdOQUWVdrRKq3glGBbqfUTMJgp3upM7zhI9j7lGO0yxmtPoCNSSNtPQLqymSWz2
         T2wdW/dChQF7lXw1j3v8C91bMlhMgC/GDR02wPIC72YMBK97oVlj8gJJ993PQY9HUZXD
         xBrCI0hI34wHicBN3nPn2WgbEL3cpxp/yS5uVkzuFgjxc+q8qGrDHWTiwCPoRMfcKCTR
         qTolJZOMbCVlErTsFP/FapOPHvTVimqClVJkpZi9q3KRgPyFuhNJ8Baa+CVrTc4xcCzD
         7rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967698;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywXshmLmOGjaY4x40OQowm4pf0YHZ4IGihkPimWY52w=;
        b=7FIGPOkh1UUFqu11NYMXi/0hu05F2qln9PB5QUusoIpS/QGUtRq7Iv56LMoXq21eAF
         XsYLNSQNCdvGDgmFAlNIQQ97xwnBeIKyk8dkOTIiIshc7jF8K6FZpIOKto6/tRnQpI0c
         9JMQ2k3mz2r7sl1xfZtA6ugy3wXkvqd95VksnWNgH8YwCxDvJSa36pT7aBRHt5kVT4j4
         AvqokvVO6X6kCFVHYFFXwCUBFG6C5Iz32gPF4NzaRH0Mv44h1g4iTGsOXaBMcG7Quqob
         P1xVxPxsEikXzdJ2Hafixe6lya/KRSBaXLLNeMkfSmNGo9TVGTLjJX6BThDnb2b2H62p
         wXdg==
X-Gm-Message-State: AAQBX9d38c87dZvLgDjcJ4fOuJJhcqalifrYt7ot3URx9F+9yjM1Y0Ne
        roaW5Wz4ZpoK/+RdQSKQJIGDfWdLfGIi
X-Google-Smtp-Source: AKy350Y6n28wu/MafERlysbCqy15XbAzYFhuYCmhQpAiBUTzBQwlNMpFtw8jJBVCP+CeoUWRtORJUH377it4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a25:b909:0:b0:b39:b0d3:9a7f with SMTP id
 x9-20020a25b909000000b00b39b0d39a7fmr6562095ybj.7.1679967698066; Mon, 27 Mar
 2023 18:41:38 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:55 -0700
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Message-Id: <20230328014058.870413-4-irogers@google.com>
Mime-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 3/6] perf header: Move perf_version_string declaration
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
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move to match the definition in header.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-version.c | 2 +-
 tools/perf/perf.h            | 1 -
 tools/perf/util/header.h     | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index c5d03a11e565..4a43043ca8ef 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "builtin.h"
-#include "perf.h"
 #include "color.h"
+#include "util/header.h"
 #include <tools/config.h>
 #include <stdbool.h>
 #include <stdio.h>
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index e21a7e15a34c..20e9b93f8a39 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -10,7 +10,6 @@
 
 extern const char *input_name;
 extern bool perf_host, perf_guest;
-extern const char perf_version_string[];
 
 enum perf_affinity {
 	PERF_AFFINITY_SYS = 0,
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index e3861ae62172..59eeb4a32ac5 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -115,6 +115,8 @@ struct perf_session;
 struct perf_tool;
 union perf_event;
 
+extern const char perf_version_string[];
+
 int perf_session__read_header(struct perf_session *session, int repipe_fd);
 int perf_session__write_header(struct perf_session *session,
 			       struct evlist *evlist,
-- 
2.40.0.348.gf938b09366-goog

