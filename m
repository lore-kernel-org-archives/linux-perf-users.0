Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C5CC67871
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJXTjj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJXTis (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:38:48 -0400
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E432E02B
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:09:21 -0700 (PDT)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-36b1a68bfa6so56667747b3.22
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YFlo4MLo2hX2jeXESO2A6LNaguFCae29tGLf3GNidYk=;
        b=ZGS6i81yil9zXXjp3+jzkPjW6Nq6onHh2W7XR+EhPWDsbPW8j3Sr+ARRyLEH07YgNj
         urHr3gg7kJCnF0QTVe1wFi9ltnBPG4kMJplrGvchu3bAUMI8hyj8VB4fDgScPt7E3yci
         3RzpLjdf93ULnobPhlzdHrcmz0aK1MPt9S6DFXZXjwEg8KbiomKOrZbNQQ1LOxd/IEQx
         V5oUX/kqXQAKkpYBum4ZgKSCInR/diwLNn0mGClyuwtUCwKUMqZr7ab+BJtHJKfDSiSP
         bDnL9+WccaIteWfVAMO3Xr2/+PssCf9SQxrUEfPHniUsFrSdTX/l3jV3Nh4Xozel3zJ/
         hFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFlo4MLo2hX2jeXESO2A6LNaguFCae29tGLf3GNidYk=;
        b=w0M8T8Guey4ndRmD7ZoDUU9X024VFjImhYQqwWqHqTKcR2HgXNHdSx+Sfzcov/wmaU
         /t9jq8Sl1mfkzyRowA8BQujwenJJO4YoLlsN9dp2rwTwgyFI5fxaJTZ0Y1rUjPMaB2ty
         AjyO0x32v064LgPSE3FhpNAIzFSLn1vF/OWyy5VtCaYJqGNNG8iFse8MHzcOlvOLm1Vc
         IjDdfZDtuJnzxPCm28T8xH3xyYK2m3dYG6kFka9eqs/FevjM6IBDa4CJ8a/ekNeJ+I0s
         anwgEGO5/Ljf9Sf/w2R+gU4Q8HbrKjyHZardwfk25ppFGmWtuGvIsuKr4m6LxoJKBX5i
         Wgsw==
X-Gm-Message-State: ACrzQf0I6sjMr0gmTO8Vu+NU2WHViGlNc/46dclnmZqK73Z+YSR1RZ0k
        uTqKjkGUVIFLZEKVpczBgYWVo4JZLhRf
X-Google-Smtp-Source: AMsMyM4TC2UOHQgUijqTe/CjUsLzraRvQ14rJaP27casQNWgKIjGSoNnf9yDeTk2i0Yp5rBOr6hFCHyHPOA4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a0d:d7c4:0:b0:368:9884:fe84 with SMTP id
 z187-20020a0dd7c4000000b003689884fe84mr21397606ywd.252.1666632942781; Mon, 24
 Oct 2022 10:35:42 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:15 -0700
Message-Id: <20221024173523.602064-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The use of C11 is mainstream in the kernel [1]. There was some
confusion on volatile and signal handlers in [2]. Switch to using
stdatomic.h (requires C11) and sig_atomic_t as per [3]. Thanks to Leo
Yan <leo.yan@linaro.org> for the suggestions.

[1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
[3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers


Ian Rogers (8):
  perf build: Update to C standard to gnu11
  perf record: Use sig_atomic_t for signal handlers
  perf daemon: Use sig_atomic_t to avoid UB
  perf ftrace: Use sig_atomic_t to avoid UB
  perf session: Change type to avoid UB
  perf stat: Use sig_atomic_t to avoid UB
  perf top: Use sig_atomic_t to avoid UB
  perf trace: Use sig_atomic_t to avoid UB

 tools/perf/Makefile.config  | 2 +-
 tools/perf/builtin-daemon.c | 3 ++-
 tools/perf/builtin-ftrace.c | 4 ++--
 tools/perf/builtin-record.c | 9 +++++----
 tools/perf/builtin-stat.c   | 9 +++++----
 tools/perf/builtin-top.c    | 4 ++--
 tools/perf/builtin-trace.c  | 4 ++--
 tools/perf/util/session.c   | 3 ++-
 8 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

