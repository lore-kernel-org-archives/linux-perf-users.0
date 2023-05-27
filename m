Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360CDC77B73
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 05:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjE0Fz3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 01:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjE0Fz2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 01:55:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31370114
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 22:55:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb79a17b8so1968407276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 22:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685166926; x=1687758926;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXQxaED4vp6H14Psblq6TQZfsUPt84iSNNTs5r5nIVk=;
        b=OEDp5myjnZeIgIl+eYSLbYatcxAxQpyiOtdmgkZg6uAStnx0PVtD+ICPFf1FV9osSw
         uH2j1iaWKIkDplA/fZ9UjmqXves9T0v8NSv6GkvUwl4sGhOTNa/oFhWuhqwsBzxLWD3z
         K4f7RRR/RCp9TOujLTd0QD2xScpb13H2oBNpj1aEJ48YwG08ezp5/UjL5tWzZcxOScrF
         d6MrjsOTn3aFsE0kao1GpSljB6GRXYIztusfsNiAzq0eCaOVqz4TVCyWm8Bv5QyGEQcn
         WjpM8QNwJauKgn8hOSmfkwFHYMkq5mpkoKzmtvBAOLMFeDGIHDgCCtiObw8BnJ+6R1Iq
         R/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685166926; x=1687758926;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXQxaED4vp6H14Psblq6TQZfsUPt84iSNNTs5r5nIVk=;
        b=Bej08qUTJ78bj2nrlrIPQD/7J2zCFFg5W4kU+X9hZpdWYuMAVVwF6ZTK3lBGQUbQFF
         WZnoA8HAnewj0SuE7S5Sn/QrWHXt6KaCyhIvPitWkaWMJFf79zC7+Z2ZRLiECG+g1IsL
         zxvw+ejSpMgTz+ME6Ve0GF3xgXX7Y8BaIfTf1C/lstZVoHKSfkxpfEoD6FwINmv+t41y
         Q68o/J7BsIGNaI8F2J11R4nOoNVQFlMCLb8SlO3YxYnxLs5Z59WIxwakvbP3jrSUsqKs
         EEQRFiW3Qg43R2jNxP1r+wO5RLRHuKoEM1YIerm+vswM8DuiPCXnsxEaMnQWL0NOyewd
         bh9g==
X-Gm-Message-State: AC+VfDwVFYnUGluUKaCQxBBHEIEFUI4gNaaAUgPOvdDTM0RBTm937b5n
        gGPiHM4LzFbgA9HXTYaZJ826OUuqCFlJ
X-Google-Smtp-Source: ACHHUZ7Z2jZnaomLhv+CmPE/K5wVWznhPumiRtXyxfDPzjZ3Y4WJYmBxpEgtlp1KVvEaTkiQTR8rt68upOPP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:ad83:0:b0:ba9:9a4f:a40 with SMTP id
 z3-20020a25ad83000000b00ba99a4f0a40mr2202137ybi.13.1685166926450; Fri, 26 May
 2023 22:55:26 -0700 (PDT)
Date:   Fri, 26 May 2023 22:55:17 -0700
Message-Id: <20230527055517.2711487-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1] perf test python: Put perf python at start of sys.path
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This avoids picking up a system installed version of the perf python module.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/python-use.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
index 6b990ee38575..0ebc22ac8d5b 100644
--- a/tools/perf/tests/python-use.c
+++ b/tools/perf/tests/python-use.c
@@ -14,7 +14,7 @@ static int test__python_use(struct test_suite *test __maybe_unused, int subtest
 	char *cmd;
 	int ret;
 
-	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
+	if (asprintf(&cmd, "echo \"import sys ; sys.path.insert(0, '%s'); import perf\" | %s %s",
 		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
 		return -1;
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

