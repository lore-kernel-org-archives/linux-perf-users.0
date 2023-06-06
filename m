Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4218C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Jun 2023 06:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFFGub (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Jun 2023 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbjFFGu0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Jun 2023 02:50:26 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DBEE43
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Jun 2023 23:50:24 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-463e368a74cso1096310e0c.0
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jun 2023 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686034223; x=1688626223;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6D8/A1EaMpr0fZI/q/93AmR2VPYJ65578K2QcmNIOO4=;
        b=Wfays52CAY5id1Tvb60S6cBe4OW7bTPCrqwUhOLQZCdBURdjyoDs4CKzv42NeTdTBA
         FCpdWsttL9AyZrImgWH3YaI+/r/3fL88i8VkQiYoGGxyPrJBl1gDMpJ1JzMWTnclt9ul
         QYe3R0itQEyVIffou7S6Ifu1AIKYIL7bgErmNQcPcsZCHQiD7Li0yadRRWxzT1T/OQy9
         5YbtvGaq/3TVhvdPPs7OXj7DspG3vISjb04JD/dHiedItdW+J8kVAymtfGOiqMMWx9Eh
         sOYpucn3QZPIdzPoepcHtxcPcU57s0WUZt+/0KaQQXkHm1GO5YYbpgTvIFhbnPGElwKK
         YZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686034223; x=1688626223;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D8/A1EaMpr0fZI/q/93AmR2VPYJ65578K2QcmNIOO4=;
        b=EB+/IRr1Tc/hDsPwA6e0p8ZNmQWltghSXeBvGeyohtK4XP+Z3PgXlDZLJyd/t0iYPP
         kVQ3LVh5jGQxADCoTaBHPvhMaYfAZV3598qmlCtuGi9SeFyLgDeVPnBpXbCFTOqGgYWZ
         OTufX80Tf8LznyIvZ+vXYBZPS0J2xrMiqu+7uiVnpDMyc2ZnBTkvNE++TSf3vpJMaaDR
         ql7vV10xNbey6WW4okG9Dc1/DezJM9OfpPPCtvcesxYVNUmOFQffV9nlRZiV1c/t7gaV
         oa4qYSim2Fnf+roA5KH+kvZBI013PB+AilEWB34gI4oUN1Ku8vlBJ8uLY2fOzCKItJA5
         +Vgw==
X-Gm-Message-State: AC+VfDxyFdnWZqwGNxCk+kO/+dWaaQOMyG9jVd3F/DssbZuap2KGiNIU
        2QjeyhkqCrSNA0KplcNn0SKXXLFQdAC5I+UdjqakNQO/XPzlzgpRMN8=
X-Google-Smtp-Source: ACHHUZ77YD2qmuIEso1iXnD54IE8hSPoEpKABhPPf8kF3y/L1FcPQsBzBpPrIjvtxBwtrUbpd9YDRZJ3u5BfwyRGIZo=
X-Received: by 2002:a1f:c3c3:0:b0:43f:f4a3:7385 with SMTP id
 t186-20020a1fc3c3000000b0043ff4a37385mr407796vkf.7.1686034223556; Mon, 05 Jun
 2023 23:50:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 6 Jun 2023 12:19:32 +0530
Message-ID: <CA+G9fYtVYhyCtD-ExKj7tOJbj9nykxkBs7dxHKo5v_H+kqG1Gg@mail.gmail.com>
Subject: perf: arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: 'pmus' undeclared
To:     linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        ravi.bangoria@amd.com, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Following warnings and errors noticed while building perf x86_64,

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
arch/x86/tests/amd-ibs-via-core-pmu.c: In function 'test__amd_ibs_via_core_pmu':
arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: 'pmus' undeclared
(first use in this function)
   47 |         if (list_empty(&pmus))
      |                         ^~~~
arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: note: each undeclared
identifier is reported only once for each function it appears in
arch/x86/tests/amd-ibs-via-core-pmu.c:48:17: error: implicit
declaration of function 'perf_pmu__scan'; did you mean
'perf_pmus__scan'? [-Werror=implicit-function-declaration]
   48 |                 perf_pmu__scan(NULL);
      |                 ^~~~~~~~~~~~~~
      |                 perf_pmus__scan
arch/x86/tests/amd-ibs-via-core-pmu.c:50:19: error: implicit
declaration of function 'perf_pmu__find'; did you mean
'perf_pmus__find'? [-Werror=implicit-function-declaration]
   50 |         ibs_pmu = perf_pmu__find("ibs_op");
      |                   ^~~~~~~~~~~~~~
      |                   perf_pmus__find
arch/x86/tests/amd-ibs-via-core-pmu.c:50:17: error: assignment to
'struct perf_pmu *' from 'int' makes pointer from integer without a
cast [-Werror=int-conversion]
   50 |         ibs_pmu = perf_pmu__find("ibs_op");
      |                 ^
cc1: all warnings being treated as errors

Links:
======
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17346999/suite/build/test/gcc-11-lkftconfig-perf/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230606/testrun/17346999/suite/build/test/gcc-11-lkftconfig-perf/history/


--
Linaro LKFT
https://lkft.linaro.org
