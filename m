Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB83C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 06:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FAB611C6
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 06:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhIPGGx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 02:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhIPGGw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 02:06:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D8C061764
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Sep 2021 23:05:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so11236880yba.6
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Sep 2021 23:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D0r7TBMbEZnc2Tmp30aYQUE/VFgDrqrZPzYpb/fCP9U=;
        b=Jt6MQlFhyIvw2VNWhD8wr04h95Ttto+QvH0023lhvq/waQF7PhGlzEKlb/Ni0DzroC
         Q3IDXtN/LWMYLuhf7nu3BtFAyi/EKZzD7mXFtD8CgCVLz5kOiq/EvBQYYb5MAy0gMOxg
         jsshIRdhhE41Uz5g4i3Oq805XRY1W9vUMUJVLCn5SaMdSdYO8ILVvn8WpZTog3fxlplq
         +6FfLMK012Jpb8BuKgM/HYPTUTU34bJ607tph5E3fsSYGHJ10sfuJT7nfB0jBkivcyOl
         MVU7LV3b3BQmLMRmYUaIMHuJHxhWzjgAa8o7jc3jY/BOBhRyS36k8nnKqvfzeiVKtpA5
         RBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D0r7TBMbEZnc2Tmp30aYQUE/VFgDrqrZPzYpb/fCP9U=;
        b=NKnZocaU2DiOKUCjkxwKMWLlJiYIBlUpYRLHmLx1hBHRpIQ/RjQg8rkiL42LRvZElk
         wrOm/lMJjisECyqVVAko489gRcrrUeIUAH06LT8KLdFNzpQiAZcnyqxCEVzLQd1vvbSK
         6q7j4c8erMtuajv8FOLknn+DKBbPqcQ0OuZfi0wwKNbMFHMkEftLgO+MrXCewDHMhG9C
         C1b2OSqSKY3lrF2sALyZz+GA0SCkhvlGvuTDwwDx9gu9YVq7SlepdymPtbGTZboTCtnf
         Sfnu7lRP29uZPrhfQAoyRdirmwjJRI5zvc7LYPtzXM9Qem5eR0Wj3BCEWBOyU4yEPCBb
         j6Zw==
X-Gm-Message-State: AOAM533Jng3maM25eWvjlddj8s7BioLzUJ1d3bHdKJkRsO3xTxjY36rg
        wSosqyZzfoQahUWCmVnDfCA6LsNVIiwM
X-Google-Smtp-Source: ABdhPJx5FbJpBunw6Fx0AcOekAy/kFV87vGAH5kU3v7Yt5ESkUQLPihxEJSoyk0TUWgEcCgAoWj7Pr3U/1p7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7b71:ab93:de5f:617b])
 (user=irogers job=sendgmr) by 2002:a5b:f03:: with SMTP id x3mr5069739ybr.546.1631772331782;
 Wed, 15 Sep 2021 23:05:31 -0700 (PDT)
Date:   Wed, 15 Sep 2021 23:05:25 -0700
Message-Id: <20210916060525.1890638-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2] perf test: Workload test of metric and metricgroups
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Test every metric and metricgroup with 'true' as a workload.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
 tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
 create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
new file mode 100755
index 000000000000..de24d374ce24
--- /dev/null
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# perf all metricgroups test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+for m in $(perf list --raw-dump metricgroups); do
+  echo "Testing $m"
+  perf stat -M "$m" true
+done
+
+exit 0
diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
new file mode 100755
index 000000000000..81b19ba27e68
--- /dev/null
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# perf all metrics test
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+for m in `perf list --raw-dump metrics`; do
+  echo "Testing $m"
+  result=$(perf stat -M "$m" true)
+  if [[ "$result" =~ "$m" ]]; then
+    echo "Metric not printed: $m"
+    exit 1
+  fi
+done
+
+exit 0
-- 
2.33.0.309.g3052b89438-goog

