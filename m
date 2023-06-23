Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6450EB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 04:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFWEOX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 00:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjFWEOP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 00:14:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D0F211E
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:14:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so2006407b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493653; x=1690085653;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IWD9j1HDpuBwOtgRD8+VR/HyczlG3iSDWYis44Ihg3g=;
        b=Z6TPQvcA237450CbME4sySp4GZO5k8VXvDqisLx4wxKL4CKK/VN69L/LEq+H/jaxaa
         9jSPwdoN4ybnlf8zZXY2xA2TmCMbDjvpEblejvKPPC0N0bZ8bPoTy+JIdGEkptUU73zh
         E3XHe1UxVrOjHWaHcF5+wDYec6y8ndt8Nyq6paH6a+aoXZ0WVt3QQmKzMXCDOyaul7ag
         eByKdsLT4j27OEzLPHGbfYd3dwkCjRhmsTB3THolp9iILFJwADGV1IkAkP4dPjDZiyLZ
         Lg73CBhNQYuWVz6YdXlqTjET0jJZcFUOvcAispoSjBR0zBurogbz/GQYj3z9DIjRh6T6
         aN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493653; x=1690085653;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWD9j1HDpuBwOtgRD8+VR/HyczlG3iSDWYis44Ihg3g=;
        b=QxT+bgxLIrzK4JGYT7x4ERiV6HE5TRUnTdiLVKxkcqsKCCoX3+jVanyYCH+TsOS90q
         IyBVLx4gl53DYtr1kIUYxZmJ8+oe6Lbjo4wA9icDjxyGrCQJjBgzB2Y+sdOtjwqjCgN5
         9JZ5SFMVUDSqGmnIA+tFzLGSPMyAWdgM8/w8juN6ohh3cDvoePVQETGh2zMLlCMWU405
         cmGpXSPc4nwTo1faYBkj09Y4GHkd4U2kVxHbU5cFklq1iYRmXd1oKorKeMJzk/2F5k6C
         ZqdTOxKwbhYUmZIa10LIAdAfJ27DgGs0Py/0KtogI54tyFRFkn2BOpO0yisp6cPSZbwZ
         t5zw==
X-Gm-Message-State: AC+VfDwfLgCbZiKPIyvwaD4x712GzkLbMCxnrc5rl/8UXi+2iExxBT3C
        y2yIndHmKYf9Q9EgxXUY+4j5ZQGGd+F0
X-Google-Smtp-Source: ACHHUZ4ktfc6111JvR7+3Ed89DYQF4EkwuteMc+RPTAZXpHpUpH1nYrRdu+tu44wMR35qHiNSmWLIti3pmo/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:ae07:0:b0:570:200:18e1 with SMTP id
 m7-20020a81ae07000000b00570020018e1mr7911028ywh.3.1687493653716; Thu, 22 Jun
 2023 21:14:13 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:14:01 -0700
Message-Id: <20230623041405.4039475-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 0/4] Bring back vmlinux.h generation
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

v4. Rebase and add Namhyung and Jiri's acked-by.
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

