Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF7C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 05:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiEQF1g (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 01:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237195AbiEQF1e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 01:27:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05077237E3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 22:27:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25a086000000b0064d8822f94bso4890568ybh.22
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Oo0cEG8PI+5L/vf8eiiditzi/mq8iK5al1bzl2MFWFc=;
        b=n01fylJR1lJSvx/jdDzD+0NVzUxkWd+0nl3FOPG95yM12glrdF0XMO0tJMBCYLPGJ5
         l8uC58N4yqI2Rz6XTcaB5J9GMBdYZVdQuj95xs/KoVeRs2FJZmWPl/SrklShMbLKI2YS
         Rn/bQMvcIoXk26DgJExCNgbjXboRTI+OpjZPv0i1UtuXbeB4Fevvz6WIyhuPGbYRedfd
         kSb2L58qmTNgDoVN2IjvQ1yvyGAQOx+Bb/wT3YbxLmuAcrnwWxy6KI9Rn6djJOK20h+8
         4Po33TeGhFNdig0M+M4cyk7NfaQ/5ZX6hqLaVzAYQfj/QiP2he6sfh/8e9GqoLYaTxAB
         wO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Oo0cEG8PI+5L/vf8eiiditzi/mq8iK5al1bzl2MFWFc=;
        b=teTLop750Pvl4YP8mH1l4QJQ/3jmZMmzPB2kZsZ1yB4ZCEnR5dcDtbLbVGwlkVc/2G
         iuo/htKzXXma2WPlf0W8RdRFdjUuqKn4SsQ2E65b8g054wBz3LyXfDV2pbDPx3++0B/H
         QfXvmhdDvitMRG25f1j4D1+B1iCxoFF/6hD9/fq5limiRenBeFzGdjisRWc9p7ZEZxMC
         mUdrocf8eKJu/ehaKTSX5rBRicFQqBTgm6RAnuhvDINLW71BmwgLoqLBFibhVns+98Fe
         +n2FAzua9pu3o3bxSbvalSI49V52IVeNiiOBvCBMPJyb0o4aCgAQaKuSjSuVwzidWPJQ
         MLKA==
X-Gm-Message-State: AOAM530+zQPKK/8S6x1qMyURKzp/K4DAQfztisnY7n7LHu79Gkzp6hPl
        Uw1fy+08mVg8OlqPSpCp3lumiParizSl
X-Google-Smtp-Source: ABdhPJzeLq12ZohTeKdhYCNUmbJTdchTeyphmgzsTscwirUuwlYhvk/M4bey6+VENeBvXs61Cr788PPrTzru
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d585:282c:3f88:36e3])
 (user=irogers job=sendgmr) by 2002:a25:9ac8:0:b0:64d:fee6:1c8 with SMTP id
 t8-20020a259ac8000000b0064dfee601c8mr947979ybo.344.1652765252213; Mon, 16 May
 2022 22:27:32 -0700 (PDT)
Date:   Mon, 16 May 2022 22:27:24 -0700
In-Reply-To: <20220517052724.283874-1-irogers@google.com>
Message-Id: <20220517052724.283874-3-irogers@google.com>
Mime-Version: 1.0
References: <20220517052724.283874-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 2/2] perf test: Add basic stat and topdown group test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a basic stat test.
Add two tests of grouping behavior for topdown events. Topdown events
are special as they must be grouped with the slots event first.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/stat.sh | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat.sh

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.s=
h
new file mode 100755
index 000000000000..c7894764d4a6
--- /dev/null
+++ b/tools/perf/tests/shell/stat.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# perf stat tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=3D0
+test_default_stat() {
+  echo "Basic stat command test"
+  if ! perf stat true 2>&1 | egrep -q "Performance counter stats for 'true=
':"
+  then
+    echo "Basic stat command test [Failed]"
+    err=3D1
+    return
+  fi
+  echo "Basic stat command test [Success]"
+}
+
+test_topdown_groups() {
+  # Topdown events must be grouped with the slots event first. Test that
+  # parse-events reorders this.
+  echo "Topdown event group test"
+  if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
+  then
+    echo "Topdown event group test [Skipped event parsing failed]"
+    return
+  fi
+  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | egrep -q "<not su=
pported>"
+  then
+    echo "Topdown event group test [Failed events not supported]"
+    err=3D1
+    return
+  fi
+  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | egrep -q "<not su=
pported>"
+  then
+    echo "Topdown event group test [Failed slots not reordered first]"
+    err=3D1
+    return
+  fi
+  echo "Topdown event group test [Success]"
+}
+
+test_topdown_weak_groups() {
+  # Weak groups break if the perf_event_open of multiple grouped events
+  # fails. Breaking a topdown group causes the events to fail. Test a very=
 large
+  # grouping to see that the topdown events aren't broken out.
+  echo "Topdown weak groups test"
+  ok_grouping=3D"{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound=
,topdown-retiring},branch-instructions,branch-misses,bus-cycles,cache-misse=
s,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,=
cache-misses,cache-references"
+  if ! perf stat --no-merge -e "$ok_grouping" true > /dev/null 2>&1
+  then
+    echo "Topdown weak groups test [Skipped event parsing failed]"
+    return
+  fi
+  group_needs_break=3D"{slots,topdown-bad-spec,topdown-be-bound,topdown-fe=
-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-=
misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cy=
cles,cache-misses,cache-references}:W"
+  if perf stat --no-merge -e "$group_needs_break" true 2>&1 | egrep -q "<n=
ot supported>"
+  then
+    echo "Topdown weak groups test [Failed events not supported]"
+    err=3D1
+    return
+  fi
+  echo "Topdown weak groups test [Success]"
+}
+
+test_default_stat
+test_topdown_groups
+test_topdown_weak_groups
+exit $err
--=20
2.36.0.550.gb090851708-goog

