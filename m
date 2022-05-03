Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F75DC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 04:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiECEhi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 00:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiECEhh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 00:37:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6701D3DDC6
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 21:34:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d188-20020a25cdc5000000b00648429e5ab9so14800765ybf.13
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 21:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SYV6mvqqYRmpIGlJiNQclA3XV8FhtN988Xp5/rbK+9A=;
        b=ewq00/eORkGEOQ1aR/rqFOA9uv4H0PJUBe8FE30HOblxaYm4JsB99/RBowSCR+17FS
         qc/zMSVujVYguge5uMlBJRPw0sEvJmjBEJrwwKstQM9TE8AOz4TI/bjQWUWp2OVrhj2C
         fSJv1r1Jnbg60OtJYDBmjASdgNklQA4hfAWpDhCxHNeCbWxVF0yTWNyCTYKDFeNNdFQ1
         JSZOo4WH4zrSKgkkRWU1wWD26psElJVq9fA+jg4OMbo+v15LXlpwWkage33jdjJDehNr
         LBAazA2zS73IOJ507XvHJdO/rWOxRhjtptssAeXG5N6KkxOgHwnQ8sodaWroW9/uV7d4
         HIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SYV6mvqqYRmpIGlJiNQclA3XV8FhtN988Xp5/rbK+9A=;
        b=YapYb5rYKLj1iNhmT2DlzqZ+Iuj542hzlmw2oDsGv2E3r1hp2jeN1WoVvkXXImXKQ/
         sstUjRg9MoQmtVDX/IN4nFGJybBKXJS/vCxi7X3HTbIbyseCZttzbHKanPkY2/j0QkVZ
         B21d6XUidgQAy8ctjNQv9xK9LOScj6mwhITl5mhuTCrhL3EHtB4DYle/gaLOoszQSidj
         JVZUELYN/3nPvotJv/aAYME0enmWJgYuY7/1SdQrmqEcvzCPjopzVsm85ZB3KjvZQF2A
         Sv4crbzXSDYYQ/hQByQ6g/9WMiA6HL0FZeWnugPgyqZv/m/JJOG+ZhBADrkmIREaYcAM
         N/XQ==
X-Gm-Message-State: AOAM533NMTQieI6VsWCX3HVev7mmYo3V3iFWIIqjPh1sQOOF1lJ2NQUh
        2+xdMxDE5Teq3Lce9Ml/hniBvKC0APtA
X-Google-Smtp-Source: ABdhPJy60yHmsgHhTY+gOjOm8/KuIYu5nQxakaCFybdLv0nYkP4DYbPWOOb9OfC5dQCNJGyHgmQACQW9gAmH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a25:3455:0:b0:648:44db:51e0 with SMTP id
 b82-20020a253455000000b0064844db51e0mr12118066yba.314.1651552445637; Mon, 02
 May 2022 21:34:05 -0700 (PDT)
Date:   Mon,  2 May 2022 21:34:00 -0700
Message-Id: <20220503043400.2374052-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2] perf test: Add skip to --per-thread test
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
 tools/perf/tests/shell/record.sh | 44 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index cd1cf14259b8..00c7285ce1ac 100755
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
@@ -39,4 +75,6 @@ test_register_capture() {
 
 test_per_thread
 test_register_capture
+
+cleanup
 exit $err
-- 
2.36.0.464.gb9c8b46e94-goog

