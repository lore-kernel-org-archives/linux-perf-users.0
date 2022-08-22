Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B5C28D13
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Aug 2022 21:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiHVVeR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiHVVeJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Aug 2022 17:34:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A65726575
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2022 14:34:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-333b218f2cbso206752857b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Aug 2022 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=dI1HM2qpD13pHVf8vcdUDtzAR56g72bb/Lagcy2hQJo=;
        b=NW7jcTketQHOa31a5ZOmDT3goDI2B8/cHmva8ClRVt6pOzcdpSI2qKr5ovG9u5Fmn0
         mHlEwL16EzQa2MlP8Oknzi3Mp7ukSkGQgB38UTNNuj7pdPfgHg1fWIJsgXANKkwZHlyd
         fTfqOWZH2tfo/TovUGebIood8ZVgiBpgN85kI3Vky+IJp8b7gIu9zd7rnnRx7wWbA82j
         wDAib8CWzWxNdT1O7EJaYSQVdX5Fhz2mQagBESo7gbOXghye842FSINVuebwXDf9xAx9
         u59eBDQeMV6lYbp2Pjxn8Dhl5wADAoatnaX3K/pGqJBPqnSZ+hcudXYwTx/qu5HTCVpv
         ATVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=dI1HM2qpD13pHVf8vcdUDtzAR56g72bb/Lagcy2hQJo=;
        b=UB1XlDqNtVEyIQkHhm6mIPShIua5ZiL8iRPKaNRZAJys9oMV23UNhuH0r+cKfUwtMa
         rC+L3I5SEDiyOXbZDiCN3PvjH4l8RJg/n0xlC7TW11thaLQyJgyQR6PNKvDxHbTOWd8h
         zxoJblVQdJEu4YWgs0764jYiFmjwBAl/VhrXHrwhAiTlCB38x5ZTdEywuo1R6nEuKvZ2
         u+YM7uuS9YicWpyM9ngJmnE5OKP1NfAb2u5m7+eQUjqR9SC+qRVvemTkFyEI84L+FQfz
         7TLAzsmJZA9IAIVHu/zITRBrXedtIq7mEROErymcrXLyT5cHDk+EQeEgqaw6GPaaSPK3
         a/Ww==
X-Gm-Message-State: ACgBeo2G6dZ4saNWlxt/WjiDGOb8VJSxfPe7w+oQ26M3exDLdRkdhhTM
        9Jd26VwtWxyfEryZm4P7SqAMQ/i+rpHz
X-Google-Smtp-Source: AA6agR4nULUg2CVMU5RXXoLFXgyGL8q9ciVi+6GVip8nhfi+e/KN0hQHNcuJH5vW1+5AdSa2kK+7ei0h9mVd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2768:cfe4:142e:cbca])
 (user=irogers job=sendgmr) by 2002:a25:4013:0:b0:695:b3ca:c165 with SMTP id
 n19-20020a254013000000b00695b3cac165mr6439198yba.406.1661204047024; Mon, 22
 Aug 2022 14:34:07 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:33:52 -0700
In-Reply-To: <20220822213352.75721-1-irogers@google.com>
Message-Id: <20220822213352.75721-2-irogers@google.com>
Mime-Version: 1.0
References: <20220822213352.75721-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v1 2/2] perf test: Stat test for repeat with a weak group
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Breaking a weak group requires multiple passes of an evlist, with
multiple runs this can introduce bugs ultimately leading to
segfaults. Add a test to cover this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 9313ef2739e0..26a51b48aee4 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -28,6 +28,24 @@ test_stat_record_report() {
   echo "stat record and report test [Success]"
 }
 
+test_stat_repeat_weak_groups() {
+  echo "stat repeat weak groups test"
+  if ! perf stat -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' \
+     true 2>&1 | grep -q 'seconds time elapsed'
+  then
+    echo "stat repeat weak groups test [Skipped event parsing failed]"
+    return
+  fi
+  if ! perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W' \
+    true > /dev/null 2>&1
+  then
+    echo "stat repeat weak groups test [Failed]"
+    err=1
+    return
+  fi
+  echo "stat repeat weak groups test [Success]"
+}
+
 test_topdown_groups() {
   # Topdown events must be grouped with the slots event first. Test that
   # parse-events reorders this.
@@ -75,6 +93,7 @@ test_topdown_weak_groups() {
 
 test_default_stat
 test_stat_record_report
+test_stat_repeat_weak_groups
 test_topdown_groups
 test_topdown_weak_groups
 exit $err
-- 
2.37.2.609.g9ff673ca1a-goog

