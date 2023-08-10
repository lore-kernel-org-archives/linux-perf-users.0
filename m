Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F67C04A6A
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Aug 2023 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHJVuG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJVuF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2023 17:50:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F83A273D
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 14:50:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583c1903ad3so17844247b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704204; x=1692309004;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3eKtThco3Z0l5cBOgMWn8czF5qOIic4mTX3OJXGISEI=;
        b=Jpq9eNc9Je6rsq1OQ41MayUOMKLy1kFY1xMJ5FaYUt6NWuRN7NoEa+9VnVWRtg3sCC
         xmkNOHneuxT7XWEtixx1zuX8BsRHdzhpuOlbxrZbv50DyzgXfFo7NTRYCJrpktc2+nVi
         M6/7KwJpts/lW33m7EpB5DBcMj+NVpWDsddO0+2MsTvJ6dTzJmLM5LYGrUWmv0R10B4S
         8U6BV3InhR3wc5YYcuY1HbDdd/8Y2ypdALrmbWK9v0PE1XKllXWcmCiUkrCZR3kTDoQJ
         /pKSU9IRvUhrF3hvjFlHfFcDo/DHoq6t6VPsNllWbf65bjV/qMIidZ7kcyVtHmY7n9yo
         SXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704204; x=1692309004;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eKtThco3Z0l5cBOgMWn8czF5qOIic4mTX3OJXGISEI=;
        b=EJFdLkPpkZJqBfHjBIfrLS0INTgsv8jiNRv3QZVZlRTj+Fz0NZwzN/D6zEGNBd/kkm
         jkbEO1izCdrYxglzamt1dypCzOyxTHCBdQVfmNs205diojix5Ht3Lwsiy3Snzs3ystGm
         Wzlx3F/pMhzo2kxk19N0gGS9nswSHxF/NZWr386CPwqaRtnkstKjSaelCs+6JivK0elt
         kDaTk+QUhByunOPbq201q/tfGlDOAdSwJbUkqpmHgxT85gWser+N4nJoedoqMqXUq6L9
         i/8LWUVqG1kJ+tljDz3lqo4anz5nkwgh66hg87PC/AnptiCwKmc1NeXxNlBsbXYIymZW
         g7TA==
X-Gm-Message-State: AOJu0Yyo/6r6D9R3ukbqoiH+N6bsYxJ2o20lnts043399e0zBUU0EKbQ
        7uqguS/M69Vb0jY0hnrTpqNNFMsOtavZ
X-Google-Smtp-Source: AGHT+IGRqAVGZpSCHrHzdVLHeubqrLYA+lq+O3OF/fUfNVieh0pY7MCPwSv0RgcJAB6weuBFJ8h+K4wxYqNs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a81:ac1b:0:b0:589:a9fd:8257 with SMTP id
 k27-20020a81ac1b000000b00589a9fd8257mr2479ywh.6.1691704204386; Thu, 10 Aug
 2023 14:50:04 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:49:49 -0700
Message-Id: <20230810214952.2934029-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v2 0/3] perf list: Remove duplicate PMUs
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
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When there are multiple PMUs, differing by ordered suffixes, by
default only display one. This avoids repeated listing of events, in
particular when there are 10s of uncore PMUs. If "-v" is passed to
"perf list" then still list all PMUs.

Listing fewer PMU/event combinations helps speed the all PMU event
tests.

Before:
```
$ perf list
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
```

After:
```
$ perf list
...
  uncore_imc_free_running/data_read/                 [Kernel PMU event]
  uncore_imc_free_running/data_total/                [Kernel PMU event]
  uncore_imc_free_running/data_write/                [Kernel PMU event]
...
$ perf list -v
...
  uncore_imc_free_running_0/data_read/               [Kernel PMU event]
  uncore_imc_free_running_0/data_total/              [Kernel PMU event]
  uncore_imc_free_running_0/data_write/              [Kernel PMU event]
  uncore_imc_free_running_1/data_read/               [Kernel PMU event]
  uncore_imc_free_running_1/data_total/              [Kernel PMU event]
  uncore_imc_free_running_1/data_write/              [Kernel PMU event]
...
```

The PMUs are sorted by name then suffix as a part of this change.

v2: List all PMUs when "-v" is passed as suggested by John Garry
    <john.g.garry@oracle.com>.

Ian Rogers (3):
  perf pmus: Sort pmus by name then suffix
  perf pmus: Add scan that ignores duplicates, use for perf list
  perf pmus: Don't print duplicate PMU suffix in list by default

 tools/perf/builtin-list.c      |   8 +++
 tools/perf/util/pmus.c         | 120 +++++++++++++++++++++++++++++++--
 tools/perf/util/print-events.h |   1 +
 3 files changed, 122 insertions(+), 7 deletions(-)

-- 
2.41.0.640.ga95def55d0-goog

