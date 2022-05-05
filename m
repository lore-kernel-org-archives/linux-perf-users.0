Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA50DC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 May 2022 04:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiEEEmf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 May 2022 00:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242891AbiEEEmd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 May 2022 00:42:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5D4553B
        for <linux-perf-users@vger.kernel.org>; Wed,  4 May 2022 21:38:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a17-20020a258051000000b00648703d0c56so2745298ybn.22
        for <linux-perf-users@vger.kernel.org>; Wed, 04 May 2022 21:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=CcdaVhY+2N/pSPp9MDh8luZCCl4PZJf4OlSTWHiC27U=;
        b=o8t/WMYszPRD1Jcw6CGfHsJQdXMUN1UM53DetWJR41bFO31stW+2jSH4RVgEj9rxRy
         ZratbzUuIp2ap7KH3v2Nmezp9fThnQMoK9VxHhoZwFgQO3Zgl2EuvnuGDnfse78nj+t5
         EMVw03OZjktSfv8cyh8JteNUopYxMyh+QPo+GPgUDLui2IL5Tp3z5fNiEOeBIisbDsuO
         KKxxRcAVIqjnHLBYSzRchkU0feXeXs6/6YwUt4jpiaAwry02SWycFrDNAf6tEpU/5BzO
         a6yJgYxP10D2+5PfVCh0Gnti6+ZBi8vJYnJpLOqYfkTzQ3xtSb7517Pj8SwXUvtI97ys
         oPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=CcdaVhY+2N/pSPp9MDh8luZCCl4PZJf4OlSTWHiC27U=;
        b=cEgppUM+FLa6UJOjcwfM7PJPaRJdHFtJ+vsAZhdG5dfcsc4qHE2TShbLW6fdCYLGaR
         jC7AwO9qz4vEXhJEkSf1CNL2b/9pRPGk0fLVDvvMEROb/OoxisRwBTn+AV8drCxGIq7z
         Hxy+5u2aChB8LKfFCtYVzcoyesQZgkUX6B/dnHjxUCNlrM5/HFJ4Ivja3df/ctIKHS9B
         HvHYKl1MCKW6Dp6wnTQxSJYydl01sZTLIvOJ4F5l+OzSlfkfBmcgddpOP+uU7mM7xLmG
         IJZs4cYjE6rp7jeIpI4H3OFK8G2xtOF9qJgx53tXy0BrQTRPkQrvAswhWsrpGgaMfpxV
         VbEA==
X-Gm-Message-State: AOAM532R2XpjI3ghKMu2VCHblEbLDL/trWJqjiw+F6Bv2vGEP4VVBnbL
        TkFJeKRu8VFXrXCH6J5uwO3p24HaJAoA
X-Google-Smtp-Source: ABdhPJwxex3sU48Q1+MF+8X6oBei8TtadftQAcXZdvaDq1s/G2cW3NCBhXCUXo38MTf/bfVseQ084TMTY5cL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:385b:60bc:5434:2897])
 (user=irogers job=sendgmr) by 2002:a25:8c10:0:b0:61d:b17e:703d with SMTP id
 k16-20020a258c10000000b0061db17e703dmr20792127ybl.154.1651725532371; Wed, 04
 May 2022 21:38:52 -0700 (PDT)
Date:   Wed,  4 May 2022 21:38:46 -0700
In-Reply-To: <20220505043846.3165303-1-irogers@google.com>
Message-Id: <20220505043846.3165303-2-irogers@google.com>
Mime-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 2/2] perf test: Add basic stat and topdown group test
From:   Ian Rogers <irogers@google.com>
To:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a basic stat test.
Add two tests of grouping behavior for topdown events. Topdown events
are special as they must be grouped with the slots event first.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat.sh

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.s=
h
new file mode 100755
index 000000000000..80869ea6debc
--- /dev/null
+++ b/tools/perf/tests/shell/stat.sh
@@ -0,0 +1,65 @@
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
+  if ! perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-b=
ound,topdown-retiring},branch-instructions,branch-misses,bus-cycles,cache-m=
isses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cyc=
les,baclears.any,ARITH.DIVIDER_ACTIVE' true > /dev/null 2>&1
+  then
+    echo "Topdown weak groups test [Skipped event parsing failed]"
+    return
+  fi
+  if perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bou=
nd,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-miss=
es,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles=
,baclears.any,ARITH.DIVIDER_ACTIVE}:W' true 2>&1 | egrep -q "<not supported=
>"
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
2.36.0.464.gb9c8b46e94-goog

