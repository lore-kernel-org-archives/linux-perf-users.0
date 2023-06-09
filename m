Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C81C87FDC
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 04:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFIEct (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 00:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjFIEcs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 00:32:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F6A30E5
        for <linux-perf-users@vger.kernel.org>; Thu,  8 Jun 2023 21:32:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569e7aec37bso19346817b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jun 2023 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285166; x=1688877166;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWF7slA8vgXA8RW6bpiqoclUoglCNciaZKdWa5dk63U=;
        b=j3MQdwlPlNLSTAZ4JPSGVl2PkwH9k9SMKlrpWVwSIlZgNR8AhEh8j40ZMSq/Ij3yms
         qUeg4kfPtj5voC4sBWo+zdv9jE5SwHv8EKxP+EVpjDR1rku1BzGshxuoxH7oSEnHSJPx
         kADT7DRCNyNrO4Tqc/b3GGfDMKX6auftBx9DtFHn7E3HAJrjk9Zi6+45CWxFa8wPQ89m
         FwuYi8ld3YGYzpMLO0tIAdYyn9lXQBsmstAA3oJ9TDwZ7Oeg3suixjRtWNN6yB/JHw/w
         d6ldvdlJd9ASl3ZdlecZYVv19ohBwyMwOedDcxg9pJdyqiutkzn0p3/7DJiWYrFWEEgh
         y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285166; x=1688877166;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWF7slA8vgXA8RW6bpiqoclUoglCNciaZKdWa5dk63U=;
        b=JHZgKj8GLn4M+Zr7PuBYkwmEjplnFMvG5rA0nyA9cvMaiSUBfVKuQNzz7r8wI35Piq
         Tm2YHYgwOBuHULUf0aCPc+NNqG0vYrdK6i86lJRIqCu/nAu8NAbUi6CkWf88P/59e0kW
         BESPcfBF6ijJoiy9ki76bpxEiPDJTxgvqERBVzZ0cCDxPv/m9fCB8zi2UkYHj0UXS/b3
         Tt6ypVDuFqmIYavnB+B8zIm+YL144km9e6UaTtnLQ22UXFUbB9XMALsQxqcg3I7BqtRF
         04od47fSa97dzukklpFPmSAzv7LvzpvUz49zRXyU1bhfHfWHRvXyqT29swdqPrKeBsTB
         GlcA==
X-Gm-Message-State: AC+VfDx1S+zhfRbS6BNU1FVKAGZqhHn7pqIxdoFXyuLLwXESLU3J7+Zj
        SiQ5ynLMVX23YGVIuSaVaZ1lKTJ9112C
X-Google-Smtp-Source: ACHHUZ44KRlU5EFyYw3JMeyIqiBlwHsT9TKFRUfjhoaPmuiiLS4fTqN0WKDjiNqDuvWLoJ72BMqe5oYveMfj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ad17:0:b0:561:2d82:7f08 with SMTP id
 l23-20020a81ad17000000b005612d827f08mr230962ywh.0.1686285165838; Thu, 08 Jun
 2023 21:32:45 -0700 (PDT)
Date:   Thu,  8 Jun 2023 21:32:36 -0700
Message-Id: <20230609043240.43890-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 0/4] Bring back vmlinux.h generation
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
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
satisfy libbpf 'runqueue' type verification") inadvertently created a
declaration of 'struct rq' that conflicted with a generated
vmlinux.h's:

```
util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
struct rq {};
       ^
/tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
struct rq {
       ^
1 error generated.
```

Fix the issue by moving the declaration to vmlinux.h. So this can't
happen again, bring back build support for generating vmlinux.h then
add build tests.

v3. Address Namhyung's comments on filtering ELF files with readelf.
v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
    filter out kernels that lack a .BTF section and cause the build to
    break.

Ian Rogers (4):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL
  perf build: Filter out BTF sources without a .BTF section

 tools/perf/Makefile.config                    |  4 ++
 tools/perf/Makefile.perf                      | 39 ++++++++++++++++++-
 tools/perf/tests/make                         |  4 ++
 tools/perf/util/bpf_skel/.gitignore           |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 -
 .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 +++++
 6 files changed, 57 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.41.0.162.gfafddb0af9-goog

