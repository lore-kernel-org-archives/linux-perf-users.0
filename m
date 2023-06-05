Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB9C7EE23
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jun 2023 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjFEU2O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjFEU2O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jun 2023 16:28:14 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B494
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 13:28:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f84f75bf4so1927449a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996893; x=1688588893;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XnxfahBFhDdYZkXlZPUfdWCh0pSs+dY9UekTfoE8XFc=;
        b=Q9T10dtnVViuYX7PiAM77gTQR0mNL3l97CIumpOUFIVSRAIJxcSd3D2ssFddid/ZER
         4yvhaKqX+CXtWJOEEHsIF1yDBSZMgW+3U2Dg0QjFQ55IN/igthyx8QVzi7TuPneZdMSo
         qBwAdbSf3nSWBH6RfewrhomP/I0PC2ahg28AHryNHnChrBkmAhLkUpbUku9HyU3wCGE5
         ZrrC6SF/Tn+Z0D4LZdyOmwPRCfQS2rkd8UCnKCqnnJLzFS3Q+Tmbf6YTv1J+HigoQAk3
         w8f7zo+pYQdVXX3jPv76zrwHgJEmr0M4X8TE03/0WaKp1+pSCpmpu4tGo/rWgZjL1i6y
         DVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996893; x=1688588893;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnxfahBFhDdYZkXlZPUfdWCh0pSs+dY9UekTfoE8XFc=;
        b=E8cxNg+IkBdcB0NNO9PuWtjeYdtxUkKv5ptuCmx+XTOGK+MXnBd5/Wl+IS/rfVZ9dA
         JDX0BkCBOrdLSRi7vrneS7RSzhzco67HB0ejzrYlcznvxpzLDYtOXxzkcr52mjLE6l8d
         aCMs7VQ1SjPJPv7u/NnqhmhC5gzF7woyxz82/27OUkF8X0ndG63LFOAXdB2tmWaF+dlh
         +mU6TnVJL8YOnd9/K3UyjtH3bEFe58BA0VlYo5nYAyfx6sApgmKSTeQCWLr89hQsVWbq
         iaaz1On9/YtBUYuwJJiRxED477bAVbju8w/cy5amsXPqnuCy7EYIg2hHUNglhcrc64sL
         sAtA==
X-Gm-Message-State: AC+VfDw9VBrqMSSeNy5hFtK1O+TLXK56fmxxkCY1FLbARrZv46p2Vw89
        6usdYHPyPzOlv27fzAXZhvZt+qzI25Nh
X-Google-Smtp-Source: ACHHUZ5bhfZTZzASA6Lnd8k7u3qSQLLP0zYksqWxf+mRuBv7Pszw2pIpT7PC1WG+Mphjo3kJ1B+xcPEnKtB/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a63:f14c:0:b0:52c:4227:aa61 with SMTP id
 o12-20020a63f14c000000b0052c4227aa61mr193290pgk.6.1685996892776; Mon, 05 Jun
 2023 13:28:12 -0700 (PDT)
Date:   Mon,  5 Jun 2023 13:27:08 -0700
Message-Id: <20230605202712.1690876-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 0/4] Bring back vmlinux.h generation
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

v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
    filter out kernels that lack a .BTF section and cause the build to
    break.

Ian Rogers (4):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL
  perf build: Filter out BTF sources without a .BTF section

 tools/perf/Makefile.config                    |  4 +++
 tools/perf/Makefile.perf                      | 33 ++++++++++++++++++-
 tools/perf/tests/make                         |  4 +++
 tools/perf/util/bpf_skel/.gitignore           |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 --
 .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 ++++++
 6 files changed, 51 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.41.0.rc0.172.g3f132b7071-goog

