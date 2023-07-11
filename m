Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A79EB64DC
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Jul 2023 05:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjGKF7Z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Jul 2023 01:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjGKF7X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Jul 2023 01:59:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34ECE4F
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 22:59:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5766e49b802so57149687b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689055157; x=1691647157;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0QK7UrJCCNlVV6qfLvDD+ydWVpwOAsvAu1MiLJXtI7I=;
        b=d1hv7Zq1YfGVbj90PHFNpTAlUIx72fd4dtT90cyuswtwZBXgJlrDtmqISMB3756+zm
         QkVkESlyU70LfevKySbmv9xEibCLu2gzwFqlyXYjIYD1nQ1ysaN08Q/dvYb4FbJPIU23
         4iYKlRN6dlUjJ7DACnF2Bl4CTWC29eDrBoL0EhLej75caYNiFAxNvpkdU11B230zM97E
         NBRaMOMxsKbup+9LWKhGURXUrfDsUhSuyQbR1s+36VDr/TQYxgVA2qMHbDb2is7m7eIP
         JUBFoGc/xFhRHO+XqYQ1K0SJqkRORF4tSZE2f7aGM0hwQh9mYofZVEYBBUAh1XLW8/Tw
         fRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055157; x=1691647157;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QK7UrJCCNlVV6qfLvDD+ydWVpwOAsvAu1MiLJXtI7I=;
        b=h6+rVYIfg/x6OgupD60OmNQ1UVtEHAjtFgLQAmo0DMKEqClliH3WliCnI2ZzSOKZdn
         KhwAxkpFwDFX0BxwVu0UbhmaPaXMjgGSbzJ/Z8IXymi0ODDjM1DuS3/JmsIEBB7E1gZ/
         h75JS5OFrMNo1MNGBLG7a3dyvkfhN3o4BX/Ae1LjCBIQ97frw5gM/JMpjrmPQCUM4QrY
         1PsB9vSksLbLWPpQ/UdgsSWLjFt7zDF/Qx++Fnbmydms3JAvsI22SkjlR9D+jh1GcvBs
         dxYpJ442q7FP93WMaIAWRso7Gg8gh8yC99Xy8oWyz6yQQlp4I1BsAzq38eyJYIXaTWNq
         o96w==
X-Gm-Message-State: ABy/qLZ6n60Zx1e3hgWmYs8rb8FehBMVVkqBLlhc58ATRlHgYt0VSuB9
        YE1cw8BNEJlPHmtHv9Rg7x6pURFh2ieT
X-Google-Smtp-Source: APBJJlHPO+tWvTd6ygr4rxGnVr1FgxWxxR7YH0ay9NmUdOQaeDgtzVsRC96usmPKXQwQ8faDvKYH5ImpCR7c
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2efd:fc0f:9eaa:3bd5])
 (user=irogers job=sendgmr) by 2002:a81:b614:0:b0:577:3712:125d with SMTP id
 u20-20020a81b614000000b005773712125dmr121154ywh.4.1689055157210; Mon, 10 Jul
 2023 22:59:17 -0700 (PDT)
Date:   Mon, 10 Jul 2023 22:58:56 -0700
Message-Id: <20230711055859.1242497-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 0/3] perf list: Remove duplicate PMUs
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When there are multiple PMUs differing by ordered suffixes only
display one. This avoids repeated listing of events, in particular
when there are 10s of uncore PMUs. This also helps speed the all PMU
event tests.

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
```

The PMUs are sorted by name then suffix as a part of this change.

Ian Rogers (3):
  perf pmus: Sort pmus by name then suffix
  perf pmus: Add scan that ignores duplicates, use for perf list
  perf pmus: Don't print PMU suffix in list

 tools/perf/util/pmus.c | 107 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 5 deletions(-)

-- 
2.41.0.390.g38632f3daf-goog

