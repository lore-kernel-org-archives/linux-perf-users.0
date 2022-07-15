Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36398C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jul 2022 22:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiGOWf2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiGOWf1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jul 2022 18:35:27 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD46F6B77D
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Jul 2022 15:35:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k11-20020a170902ce0b00b0016a15fe2627so2750431plg.22
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Jul 2022 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Uj8SeARJLMyg9DKNAY9bhB9140qxBdG/Kjci8bJYAcA=;
        b=B3mv3BlHwHMDgtvov1Ex0MLQMTBHWfAjEw5B98QgJ10P4WsUB7Hy0Iuv/h2Ddm22Yd
         1kAx+gsJSeNNS7hcFZwLJ0Iy6NKjM9EOSq2DLHkp4shetdd+QkMRP3pV0XDUM+hw6lK4
         lJFoo13P+QpUdXVaNQ8uhiUfMo0VJOy97oxhIGpucim/MJ0PWEy9+Un8UZXO1ovLjdKT
         tJGIGgWQHw7p4syJxZFPHxZXtg7aZcTtmjfhxezdgJ5mlAHRU2L15GkM5bjq65pr2z0p
         mTP/FUyRJTeZbS5Grbv4Xnv+r76K2lIJATz41DbiHYp3n/83gCEkHvAU6kC/Vl/X6wVe
         7ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Uj8SeARJLMyg9DKNAY9bhB9140qxBdG/Kjci8bJYAcA=;
        b=lclxRrxhNeuikOt2JlGtF9j4LZoZJEJVy3KSSy9wmytVRQ0229qvJoXZiZfscYA/Kz
         f1kKWrxPvbI5A9PR9yA2ncUvIGKzwIzWgS1fFLvMuUUEhROCp6F2nhyIkvbc0Ii2tQJm
         XuQ+aj6ETDfSiq2832GVqDrKkpD46335g9vx/hyNCNv7+ggJIlduYOLLeiVtgoHNj07m
         9gjFIz8eeVU//pF5AXC0VIaPOCOZ4o2tQXgkTJm2PrrMurojYNQ9GVGkUhzoLjM+B6kb
         APCmXA9pCHdr6jkuubb3AuKoown6sOGeYwcnQ7SAb15yUHEsNOz1iLrFCyn+Mr3cY81N
         vIwQ==
X-Gm-Message-State: AJIora94rw70otlSAhtEsavDSURczk6Uai2n1GOJPkbXUcudkQ/EmXrK
        91pTkZoKe+yAMmfYU75p6eTTzINIeNI+
X-Google-Smtp-Source: AGRyM1uSAOMdbZrHCTFno/wdibRMWE6UTsIa2Rm/sYU3ri4fJ2Yh2RItC7fxs2mk+32HpyRDzEtGwQOnAUzb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:72de:b499:63be:efe1])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2347:b0:52a:cf39:59a5 with SMTP
 id j7-20020a056a00234700b0052acf3959a5mr15760131pfj.28.1657924526164; Fri, 15
 Jul 2022 15:35:26 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:35:19 -0700
Message-Id: <20220715223521.3389971-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v3 0/2] Add arch TSC frequency information
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The first patch adds support for deriving from /proc/cpuinfo and adds
tests. The second patch from Kan Liang derives it from CPUID available
on newer Intel processors as discussed here:
https://lore.kernel.org/lkml/20220527040407.4193232-1-irogers@google.com/#t

v2. Adds warnings to make clear if things have changed/broken on future
    Intel platforms. It also adds caching and an Intel specific that a
    value is computed.

Ian Rogers (1):
  perf metrics: Add literal for system TSC frequency

Kan Liang (1):
  perf tsc: Add arch TSC frequency information

 tools/perf/arch/x86/util/cpuid.h  | 34 +++++++++++++++++
 tools/perf/arch/x86/util/header.c | 27 ++++++--------
 tools/perf/arch/x86/util/tsc.c    | 33 ++++++++++++++++
 tools/perf/tests/expr.c           | 15 ++++++++
 tools/perf/util/expr.c            | 62 +++++++++++++++++++++++++++++++
 tools/perf/util/tsc.h             |  1 +
 6 files changed, 156 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/cpuid.h

-- 
2.37.0.170.g444d1eabd0-goog

