Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD2CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Apr 2022 06:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352520AbiD2GRC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Apr 2022 02:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354431AbiD2GQ7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Apr 2022 02:16:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAD2A0BE7
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 23:13:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d134-20020a25e68c000000b006483b1adcc3so6550015ybh.11
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Kqo59qgKd1gaX20d6SNzOXicZIkv6urxzb/rb9AIZQ4=;
        b=K1nJzgo8S7CyE26PvnGHw0Xo0cKbXQMzSTUbU4RZXQWNvthmXLa1Fa/55QdsRFbfMr
         C0U9sTC1gbZi5m2tPBNzFFsY+eSUlaO32uAv0XIV5WzOS8FzgAzgVn8uotaI6Edqpc2Y
         l2C+p6Vi4ZB5cdwz7MRyI67/bBYbF3MB2FZlT3rzV9hH5XXw7FeqZo0MXAaVxWGooE5+
         DbOt5cGIh+LNg0O4OPhyQTwg2GYtKVPH69P0w3rQjbIMuhXpKyV002lZy3kZR25R850V
         qJ67vs573N67W/vwECJO9fgtHh5GpxxkTJwOta3kSKPRdcGvTyQDIv5UA5fcrrwZgAXv
         myuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Kqo59qgKd1gaX20d6SNzOXicZIkv6urxzb/rb9AIZQ4=;
        b=EmBTWr2jiTDUUEU6A5Kn80MBHJ6t9+qeQZ952cNVktYDQQ2u2imqHMuJNHryG1y/Up
         hxh/sZIYSqimRJRALuoLoqsUriHY9KKW5S6/2A+rgASaz+DSnAcYwrbys80fbkraeir6
         QL/3VUXvHq7jz4pl9m9yFHA8haJmbruS19x+EXlzq4gUiogQfpgzXrrzuqwCwY9oKEwE
         oNYrziRgv//5iZweVRdmzkCVByMlxe3GmKKv12XO2kspY8W1LJsi7aFaMv621VguidgV
         hg5RpMgEM59VJK8k+WECN8cozCZg6qTF+On3m6h2a6kQCiPX515fgSEDmu7h6xxwTKXe
         ib4A==
X-Gm-Message-State: AOAM533VaVt6Oq+DeO9aQsj7cBKtfgNOUQ/k4eA+TC5qk6FEtlAMqZeT
        QFxhFt0kBzU+Ga0Ol6oxMK7OxC7kHwdi
X-Google-Smtp-Source: ABdhPJyHpmgogZV5669KSyoTmYzPXdpO4rHCuq4zduFqHlDxAwemPHgNsDQPhWVBwDMKZN+yfhhsTISvmoQE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3c33:ed69:1770:973e])
 (user=irogers job=sendgmr) by 2002:a25:2553:0:b0:649:1c7e:51ee with SMTP id
 l80-20020a252553000000b006491c7e51eemr3811092ybl.458.1651212820823; Thu, 28
 Apr 2022 23:13:40 -0700 (PDT)
Date:   Thu, 28 Apr 2022 23:13:36 -0700
Message-Id: <20220429061336.1184848-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] perf test: Add skip to --per-thread test
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
stat'.

Switch some code away from pipe to make the failures clearer.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 44 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index cd1cf14259b8..efc0cb07a929 100755
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
+  if ! perf stat -e instructions:u --quiet true
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
@@ -39,4 +75,6 @@ test_register_capture() {
 
 test_per_thread
 test_register_capture
+
+cleanup
 exit $err
-- 
2.36.0.464.gb9c8b46e94-goog

