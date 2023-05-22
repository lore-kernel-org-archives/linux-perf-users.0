Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F351C77B73
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 May 2023 20:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEVUl1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 May 2023 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjEVUl0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 May 2023 16:41:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E474B93
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 13:41:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2553b096ddfso1195056a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788085; x=1687380085;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iR+BWwf4OJyjMqBDmvTGWi3YCxxOLx+95DOCyJVhKPk=;
        b=xEa2mOQ2SU1uUUjttd9udMgRxPuLw8oCfRKbF8vtgTjACLQmxJkg3UlfAOJR42UukM
         2ceUcX4VaZ3REotSepvjFLOyzJj6wCM9CXPDxU6j3PR5bc5IPOtAhWh1/oqItWFbKb+l
         733AS0+sqdBmKeoiq9rksTo8cQroiIz3l70/cGsIUiBtEeuOHdNHejR/PaQdK6xnsVQJ
         XUBiLUf1hBSGbYMKJvUzpTcqDcCRL669NjLWUA27uHWUc0BBEx74CIGWM+tl8oxQrIKX
         XJTY0s8FmyqQUBkNT7x3lSqe4UciisM58DPS/vS7/Hav5LKzuhpyJ7um5LQ/px5A+9Rb
         Wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788085; x=1687380085;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iR+BWwf4OJyjMqBDmvTGWi3YCxxOLx+95DOCyJVhKPk=;
        b=AbTS35rweOS06auc2r073f1iAjGhdbBjYTnu07gBP13bVGgWHG2bDx0c7/mhjmk9PL
         dAkAS5dlW9apfv7D0CXAvK5wrNC+ehvfmXNeJfLdUwUfSCfEFcl8KnPQmlwjAJgqecYk
         L7WYCIIBqSomAMTcOscehdhYDuGWgeQAMeuQQ/7Nunmfwj50Ealk45RSwcgvqCh5yORe
         abW5rRs67gS6E3kBZzHi9sGw0ntTp6LatDXr7SZZ6BfNB7qXt71KgAkfQEACOkmBY/Bn
         f/e25W28HuqK3kt/FFn4QkyfH6Z6cgyI/1JQVPkwI/1koNXE0Fw6Bw16r6V7VNGthFIc
         q1dA==
X-Gm-Message-State: AC+VfDxRQspi1936irszK5hfSHbRhdSS8C8dyC1UznqU9oTzzfU3x94z
        AIYP+e1qd+Axj9CAzRT+MuNkfWcSyRnt
X-Google-Smtp-Source: ACHHUZ5UVJ/C3KmSAfO5qNKyH4H6nxwXGqLXpomHHJOGaFsacH0kVA5wReOpD9Jl2yVocPJozpRri3FrjLbf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a17:903:3390:b0:1ae:5474:4c82 with SMTP id
 kb16-20020a170903339000b001ae54744c82mr2770731plb.1.1684788085354; Mon, 22
 May 2023 13:41:25 -0700 (PDT)
Date:   Mon, 22 May 2023 13:40:44 -0700
Message-Id: <20230522204047.800543-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 0/3] Bring back vmlinux.h generation
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

Ian Rogers (3):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL

 tools/perf/Makefile.config                       |  4 ++++
 tools/perf/Makefile.perf                         | 16 +++++++++++++++-
 tools/perf/tests/make                            |  4 ++++
 tools/perf/util/bpf_skel/.gitignore              |  1 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
 tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h | 10 ++++++++++
 6 files changed, 34 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.40.1.698.g37aff9b760-goog

