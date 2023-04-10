Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB3CC76196
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Apr 2023 16:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjDJQ0V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDJQ0M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Apr 2023 12:26:12 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DF2702
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 09:25:55 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x4-20020a17090a788400b002466b299ed7so1620460pjk.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681143954;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEhyeTvRWmHial5y1xpzuX7Bv+mNf9xTgA+L3gEVz1w=;
        b=tlQ+zMDl0ubmzI4+JPtuYqjGNoiMwNFDo/CM/Z2CuSmbqjKpEuvu/GPmJQSMRzM2HP
         5E/SVf5M4IhVV9fqfBPE2wGDn0xGfocWKu4Rbyde6f4Wc0zrXOpyL/sgoiFbMLA8XRMX
         xyZzZFgrtcBwojAl4lRqTHBGgWNZJJDfy5x6VJji6M8dC6WkNm2Q9+kS5BDj390vngs0
         47I0Us+bwZ6cbdRbqLlg00Akrw8dTHI5xAsYBn3EmQrT8qPE8elIGV3tmnAcboivLaQz
         5rTaWvaVprBCOFn4HYOyISGaXcZFjfI/oI/5OUL9DkYx5MADrP4GbolF8Wap5b7P+9El
         CIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681143954;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEhyeTvRWmHial5y1xpzuX7Bv+mNf9xTgA+L3gEVz1w=;
        b=RDKTY/Wqrh3r36xZLEDrN6LduNgCzBUpzbgtUAYpamNZTx8oJhIEXCVKLtG4XooiV5
         ox1s7DYzfVzU1dcx38l+gdOfSzcaWFPkvfD4wClSM9GMvRU+lkU1RPaYYr6fEvPYKZMk
         k1YwQKU1YK2E3yvgt964yDMqEzbjv+91xPajB8OiCgSXiUTvJYIudbrCRIyuOMVHpnf/
         hTxxVCwtM6/SyF4pvBrHuTbJQTl6LV0Nnyt4TTaQgeFRz4dXyo4cw2fgmC/z2bhNOEE1
         zWQSBdBN9fmSjEVsqYK6M/m/xlTTLq7tArvdVf9tqAsTUi2Es7DQN3PRe4BD0qH+zLKp
         ZKiQ==
X-Gm-Message-State: AAQBX9enlBeWyA5Jg+mHyTN/hFJB8wasSHAmePhifqT0ZgZuWzkTcB6O
        kIqhT7EGQ+RaU99Vt/t1zUwXObv0WkA7
X-Google-Smtp-Source: AKy350ZucXc8sW32+DDyUAJfXp9FLneuOPfcdYymaaADUSV5SZWt8ZmhRdsNHbun6QAk8L6tnseXpx+JuE5r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a17:90a:2ecc:b0:23f:14c9:a606 with SMTP id
 h12-20020a17090a2ecc00b0023f14c9a606mr2833443pjs.6.1681143954554; Mon, 10 Apr
 2023 09:25:54 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:25:08 -0700
In-Reply-To: <20230410162511.3055900-1-irogers@google.com>
Message-Id: <20230410162511.3055900-4-irogers@google.com>
Mime-Version: 1.0
References: <20230410162511.3055900-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 3/6] perf header: Move perf_version_string declaration
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
2.40.0.577.gac1e443424-goog

