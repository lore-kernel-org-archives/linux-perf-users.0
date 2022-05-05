Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D1C4321E
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 May 2022 18:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383811AbiEEScl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 May 2022 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387148AbiEEScO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 May 2022 14:32:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103B2DDE
        for <linux-perf-users@vger.kernel.org>; Thu,  5 May 2022 11:25:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d11b6259adso44964267b3.19
        for <linux-perf-users@vger.kernel.org>; Thu, 05 May 2022 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Sft0aEle5FJBG0zu9fL28JLPynIEDLy2Y66OeP2apJI=;
        b=FPmA3loXH7U1+PgnU7d8LHvM48Kpsr6ukJE6Pu8MKYUKs048VGExOWz7QAiGFpuD2O
         FoK/1HZLhm/gSNpyTrJt7DTz0WhGhSyr0iBNMKmA4Zp5hJzvohNGSFRSEMOe6EEhyDRO
         YLdHkud5odMSRV+9fM8p8N4KGK3DOhhx20IqDX+VkUWJzCtGGc8q9lvn16O9RymmgXpL
         Fm3wua6LTtrbrc64wVsjeKQagxgJ63u3yW8CtokozmLvrrK6IUElS/q+RFgc2iDIeRH0
         L/Yt7HheMPOEk5vnuLKIghfUcrkRR2jHBB2kfOOfrOld5eYbFqhPXV1aZPVJBmv5QUZ5
         wEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Sft0aEle5FJBG0zu9fL28JLPynIEDLy2Y66OeP2apJI=;
        b=DchcSHK11+7kPEcDd0thjNQzpGBPFGkY7uL3ZQ6A9x5VFxjbjPuOuIeNhq2b890J9Z
         HqJde9ILuYQU4+Zp0eCZC7/BLqijBMrMKiWkbBQhZlAvG25W2tb4Q04x3NrkiT8/18Cf
         wTkpjbpCW3MCrkYgl3vlHBB9NVcgarHMM9s7Tku9RoEQG98jLBGY4HcRb+SELvltdsoT
         D+xEc5+J0GBMGvbI6y0y8KmuCHFJNaz3Dcaj3e2q2XgDHFTmn4tC5Uvt0S+aV1zVH5p9
         xd6+iif8zjlXHkKtRX7TuST1IRs6iqCa+ybBEnbtl+hWqxDK4xycPBKSXPy9x920qGh/
         RQJQ==
X-Gm-Message-State: AOAM532kfTbIHn9VV5y+JPBw//EiMFlJ9k4gNvM6B5aPS4juMNfWjN5E
        UNcHPNO0KR3XFtEqNSEDVsGSzoZE7mmK
X-Google-Smtp-Source: ABdhPJxQVDsSNLDtS9UPqhmAedPtZ2IhstTNzju4ZkjhWpfJE7tYgdL4f/1QYS8vWLUOk3PUz7tFnnHS45Zs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8e1c:fc1e:d94:1da8])
 (user=irogers job=sendgmr) by 2002:a25:950:0:b0:648:ba7a:b98d with SMTP id
 u16-20020a250950000000b00648ba7ab98dmr23765230ybm.42.1651775110313; Thu, 05
 May 2022 11:25:10 -0700 (PDT)
Date:   Thu,  5 May 2022 11:25:05 -0700
Message-Id: <20220505182505.3313191-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v3] perf test: Add skip to --per-thread test
From:   Ian Rogers <irogers@google.com>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As reported in:
https://lore.kernel.org/linux-perf-users/20220428122821.3652015-1-tmricht@linux.ibm.com/
the 'instructions:u' event may not be supported. Add a skip using 'perf
record'.

Switch some code away from pipe to make the failures clearer.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 46 ++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index d98f4d4a00e1..00c7285ce1ac 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -5,11 +5,43 @@
 set -e
 
 err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+  rm -f ${perfdata}
+  rm -f ${perfdata}.old
+  trap - exit term int
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup exit term int
+
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  perf record -e instructions:u --per-thread -o- true 2> /dev/null \
-    | perf report -i- -q \
-    | egrep -q true
+  if ! perf record -e instructions:u -o ${perfdata} --quiet true 2> /dev/null
+  then
+    echo "Per-thread record [Skipped instructions:u not supported]"
+    if [ $err -ne 1 ]
+    then
+      err=2
+    fi
+    return
+  fi
+  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
+  then
+    echo "Per-thread record of instructions:u [Failed]"
+    err=1
+    return
+  fi
+  if ! perf report -i ${perfdata} -q | egrep -q true
+  then
+    echo "Per-thread record [Failed missing output]"
+    err=1
+    return
+  fi
   echo "Basic --per-thread mode test [Success]"
 }
 
@@ -18,6 +50,10 @@ test_register_capture() {
   if ! perf list | egrep -q 'br_inst_retired.near_call'
   then
     echo "Register capture test [Skipped missing instruction]"
+    if [ $err -ne 1 ]
+    then
+      err=2
+    fi
     return
   fi
   if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
@@ -37,8 +73,8 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
-# Test for platform support and return TEST_SKIP
-[ $(uname -m) = s390x ] && exit 2
 test_per_thread
 test_register_capture
+
+cleanup
 exit $err
-- 
2.36.0.512.ge40c2bad7a-goog

