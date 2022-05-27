Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96979C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 18:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344367AbiE0Sye (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 May 2022 14:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbiE0Syd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 May 2022 14:54:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C94C796
        for <linux-perf-users@vger.kernel.org>; Fri, 27 May 2022 11:54:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4e17a5809so46208907b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 May 2022 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3jMHuEWZEVTgcKAyUiSFGjXQFMoZWUz11fN75aDaI5g=;
        b=PxCLRYqhvE0DZtFglnz62+sCDB4Vt4NUyo32ldkQ9A4c30DDh9X7Ky2Cn0gZ2jZGlf
         LPFxoj5yNFHsk751cMTkU4oy95xOVOiLwNni8YZ6lz0yrQa/SXfA/KuKju2FyAS94Cxg
         PT7m+vJf5JuN/a0EKoiHrzd+ZaeXLz32zehfaIMKbJPRjzX68tSjGvKOldAAMSsZF4fR
         qHAnd/x4pbCMWZknMQtHKOSe1XssAzQPhiulOg+eexRjpCLUdofNviv3onjrF/GlgNIe
         rVn6rhf7MlGoGN3vgaMKz9hMR8Fir1Hyr458x2gBlM7WThVueUuugonnuOkYjX/wicQa
         IYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3jMHuEWZEVTgcKAyUiSFGjXQFMoZWUz11fN75aDaI5g=;
        b=dv1jy40HMOnM1WcYt548MsQuoz3DE9mJOjx4LE9fLkVP530RyTzUSeDmJ/4/fCj7eN
         QVnB/scAJqBxxRigf6Ko1K7ut8AxInCza+6fr0ueaGO8ihE6cBiICALyPrVO2VwBHqxl
         2b8I/KFSV2Nl1hDZRh6GWQoJxV/TOfBsdPKEbsYHZkn0LFnfZGuWhFfnGZQCmoNuERhh
         a88H+0f9g+2c3+g3hCiiRtzOayuQcvOotsr+QOr6nmtoJZ41tE7U1tdM6zhwpJp0iypZ
         R8HPs9enExvNxsm8/FHSJv5u4HgRGm7v+fHjgoEtJPVr8JPHfSHeSftW35eI+FwEsza2
         QaeQ==
X-Gm-Message-State: AOAM531Fap3dG6iI3vHa5ZhlaKwF85oHSi33oFGdBS6gjASAMszQULPx
        vk+x4GYto9dvjvfYqfJFW1hwg3ijMNG5
X-Google-Smtp-Source: ABdhPJwLz/Cb2OhjVqfIOoEZruXZ0cC/Mj+ooHvw7vgvt567POuXK0Jif1n9ajCXug3PnxYnDLlRmLSh7gG7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:ed8f:39b4:b259:40ef])
 (user=irogers job=sendgmr) by 2002:a25:d89:0:b0:65c:6714:71c1 with SMTP id
 131-20020a250d89000000b0065c671471c1mr11197ybn.226.1653677670143; Fri, 27 May
 2022 11:54:30 -0700 (PDT)
Date:   Fri, 27 May 2022 11:54:23 -0700
Message-Id: <20220527185426.240235-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 0/3] Rewrite jevents program in python
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

New architectures bring new complexity, such as Intel's hybrid
models. jevents provides an alternative to specifying events in the
kernel and exposing them through sysfs, however, it is difficult to
work with. For example, an error in the json input would yield an
error message but no json file or location. It is also a challenge to
update jsmn.c given its forked nature.

The changes here switch from jevents.c to a rewrite in python called
jevents.py. This means there is a build time dependency on python, but
such a dependency already exists for asciidoc (used to generate perf's
man pages). If the build detects that python isn't present or is older
than version 3.6 (released Dec. 2016) then an empty file is
substituted for the generated one.

A challenge with this code is in avoiding regressions. For this reason
the jevents.py produces identical output to jevents.c, validated with a
test script and build target.

v3. Updates the patches for merged changes (on
    acme/tmp.perf/core). Re-runs all comparisons to make sure the
    generated pmu-events.c isn't altered at all by this change. Adds
    the jevents.c ExtSel fix in:
    https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
    Bumps the python version from 3.5 to 3.6, as f-strings weren't
    introduced until 3.6.

v2. Fixes the build for architectures that don't have pmu-events json
    (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
    build for python not being present or too old (Suggested-by: Peter
    Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).

Ian Rogers (3):
  perf jevents: Add python converter script
  perf jevents: Switch build to use jevents.py
  perf jevents: Remove jevents.c

 tools/perf/Makefile.config               |   19 +
 tools/perf/Makefile.perf                 |   16 +-
 tools/perf/pmu-events/Build              |   15 +-
 tools/perf/pmu-events/empty-pmu-events.c |   21 +
 tools/perf/pmu-events/jevents.c          | 1342 ----------------------
 tools/perf/pmu-events/jevents.py         |  392 +++++++
 tools/perf/pmu-events/jsmn.h             |   68 --
 tools/perf/pmu-events/json.c             |  162 ---
 tools/perf/pmu-events/json.h             |   39 -
 9 files changed, 444 insertions(+), 1630 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h

-- 
2.36.1.255.ge46751e96f-goog

