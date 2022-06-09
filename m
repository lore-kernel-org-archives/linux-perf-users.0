Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5155C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 05:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiFIFYG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiFIFYF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9B5FDA
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 22:24:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c9a01d1c5so193008057b3.11
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7XF9Ovw3kggDsMB//JiO35wPNulyyyK2DnQRx8sKbCw=;
        b=Qxt+qHfYhDcOmc8hJ0bwanQhLdkNTTw/fTHYnVI3n9lc9yKskzsAgPUblvzaiKqzki
         f4R+lZJq29nNw2NS9A2gMI8kKaT12s3IhM+pX4QiU0AQrQ0qe/G4kYYOKL4Oz+KPv82X
         7lDgoVC5Fl/2mmrBnJzIwfT/hm0Hp/dNnPONk4i7CseHykg9pWWgTQuRqjzOnWZLYoe9
         kPG0qrkCgz/oKwWwvd0zLDJGFiYnrGgZTbqMxeE3QmbZPzlNqwlr2qca2eSgyrf2s/ej
         5BDSK7xwy0GfLGHT32urHkpiQqk95ILmj57wVUSRiEvC+FoQ38ZkFZH9Rl0lU3I99xqa
         pH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7XF9Ovw3kggDsMB//JiO35wPNulyyyK2DnQRx8sKbCw=;
        b=dD8Zu/4GfgrB40wVG2Yjw+mg6ZcBV4gQxcKS9pIXBKvU7bdK2eOitvaviamXCyco8n
         Yk8TWjfEshOcM0X5Kc/6Un3dmcbVjY1D85w6K2Oh9YDt76AI81WOx9t0KQecLpR7l4+z
         fgnFB/22ISUuUUiTHLloCPiBCZ/MJQ4EM3uVkLHM6NCacWRT1T35znG8lDaiEEBtuxQU
         y5YGrMWbJCmyANl1DfzWnhDwCt9UAPWl14roHHe87WICqKHfhiIRAiTDsxSzUO8QydOx
         UqZCzmAye6fMJYkeCXSaxaVWDofUzG0oT4lGtSlKuDScWuTGJHxf5ND5D3Xa1sKvNDct
         IFMA==
X-Gm-Message-State: AOAM533O1GhLsK5AcVsQAE3axUSFfRtJ/k9AM25KfbM60rkJ8+bhM6lZ
        3y5ctjqCQOl0Vh6tzadnZJBduLaR0dzn
X-Google-Smtp-Source: ABdhPJwf1EjrawTD8TkuztwNA6YeKtP7aL1hFxOD/Pfd+D7027QpFXS+X5Jr8E+OajcbsOHLBLEehH23wdcM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ae20:7578:fb21:976b])
 (user=irogers job=sendgmr) by 2002:a25:2385:0:b0:664:381c:7c98 with SMTP id
 j127-20020a252385000000b00664381c7c98mr1028385ybj.7.1654752241781; Wed, 08
 Jun 2022 22:24:01 -0700 (PDT)
Date:   Wed,  8 Jun 2022 22:23:51 -0700
Message-Id: <20220609052355.1300162-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 0/4] Tidy user rdpmc documentation and testing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libperf's perf_mmap__read_self and the addition of arm64 support mean
that the perf_event.h and the rdpmc perf test have become
stale. Refresh the documentation in perf_event.h, remove the x86 rdpmc
test and port the libperf test as a non-architecture specific test.

Address sanitizer testing showed libperf leaking fds when the
perf_event_open failed, add error paths to handle this.

A comment is added to perf_event.h to avoid a divide by zero when
scaling counts if the running time is 0. This was previously discussed
in this thread:
https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/

v2. Alters the skip in test_stat_user_read for open to always be a
    skip as perf_event_open may fail with EACCES (permissions), ENOSYS
    (not supported) and ENOENT (hypervisor). Adds Rob Herring's
    acked-by on patch 3.

Ian Rogers (4):
  libperf evsel: Open shouldn't leak fd on failure
  perf: Align user space counter reading with code
  perf test: Remove x86 rdpmc test
  perf test: Add user space counter reading tests

 include/uapi/linux/perf_event.h        |  32 +++--
 tools/include/uapi/linux/perf_event.h  |  32 +++--
 tools/lib/perf/evsel.c                 |  17 ++-
 tools/perf/arch/x86/tests/Build        |   1 -
 tools/perf/arch/x86/tests/arch-tests.c |   2 -
 tools/perf/arch/x86/tests/rdpmc.c      | 182 -------------------------
 tools/perf/tests/mmap-basic.c          | 127 ++++++++++++++++-
 7 files changed, 176 insertions(+), 217 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/rdpmc.c

-- 
2.36.1.255.ge46751e96f-goog

