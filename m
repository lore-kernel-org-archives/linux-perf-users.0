Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F460C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Jun 2022 04:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350458AbiFPEs0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiFPEsQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Jun 2022 00:48:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFF61A383
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 21:48:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so3357627b3.12
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jun 2022 21:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mKf42Zv02T/hvgMLHfSYcw3YN23ypYzTUhBJOeaxezY=;
        b=SU75kiS0ZllhjZaPXyKzLYFc6mDVt9IoZddLXvl/i3NslSQhxfVIE732b8PzBVSg0R
         Ohzf13jJM+zjTOW70WCURFl4iHI9nMkPIElZ7LH7vPa3jTkSMdV9cMjY43WwErPgxrou
         uFn+EUwMTW66GMnJwQnEjBASRtMGMkZKiuVPo3nc3ey5Mjz6f9VLs69UkladSCF/veSZ
         B7H1XODwzX2ZOU6uf27uZZFdlLfsdqZdPCB53yHF06ZCxmgARFYdT83STpPBLzrj8Ymm
         3ClHezdLiVbMZFQfkJYqD3naKtapuWAcVBPxSy5AU6UJOaulfhDYZlI42yuW3VOmXt4B
         Od5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mKf42Zv02T/hvgMLHfSYcw3YN23ypYzTUhBJOeaxezY=;
        b=nGaVX9NBpiG6j0UNyvGYYmiTbpDaOfVZRcVpW84m0m/jiuZ53L27/MCbgvaxiqiMSn
         t1ISuPxuJq8t82IcQ2waG3u/HOwTo+ViIpg3OcrPpHd0TOKZTW8L/KKgmAHKUdS2UM4o
         wbzTS04B3VR9oqesU/rsfPRYJDjd15S7HvfPdoFThwE4XlerXWpswRAROz6Zir3gKpTh
         x13nFcDrnSX68qMI6/lvxOL+HisUzatjru2hrxD85IzK4+aJc+EQ6IokwuAT8gYlRH2I
         sb8GANigctbacc9YcVR27w65eDUonxBodd7xPbHPO/vBVgECHkFaCtFZ9otmaVEkNkqV
         B1NA==
X-Gm-Message-State: AJIora9gGWCWUF2YasNihXQ9Wzs99zWq+gm+LiThx+C5ge9CpSSwcIPL
        fyvEii05n7QjoxYDehoLjl8NwsBCLPw+
X-Google-Smtp-Source: AGRyM1sbfQBDosW2bMN33qgFqyEp4NP9wf7esAKr8ytcslcO1xbCwchmcbifSQ5o4pZ7VuCweyH9zu2iOvma
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8a8e:cef:df61:163d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1146:b0:660:9278:80fa with SMTP
 id p6-20020a056902114600b00660927880famr3458693ybu.172.1655354894522; Wed, 15
 Jun 2022 21:48:14 -0700 (PDT)
Date:   Wed, 15 Jun 2022 21:48:02 -0700
Message-Id: <20220616044806.47770-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v5 0/4] Rewrite jevents program in python
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

v5. Adds a 2>/dev/null as suggested by David Laight
    <David.Laight@aculab.com>.
v4. Fixes the build for systems with python2 installed by adding a
    patch that makes python3 the preferred python (Reported-by: John
    Garry <john.garry@huawei.com>). It also fixes a bash-ism in the
    jevents-test.sh and fixes the handling of an empty string for a
    metric BriefDescription as one was added for sapphirerapids in the
    metric Execute.
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

Ian Rogers (4):
  perf python: Prefer python3
  perf jevents: Add python converter script
  perf jevents: Switch build to use jevents.py
  perf jevents: Remove jevents.c

 tools/perf/Makefile.config               |   27 +-
 tools/perf/Makefile.perf                 |   16 +-
 tools/perf/pmu-events/Build              |   15 +-
 tools/perf/pmu-events/empty-pmu-events.c |   21 +
 tools/perf/pmu-events/jevents.c          | 1342 ----------------------
 tools/perf/pmu-events/jevents.py         |  394 +++++++
 tools/perf/pmu-events/jsmn.h             |   68 --
 tools/perf/pmu-events/json.c             |  162 ---
 tools/perf/pmu-events/json.h             |   39 -
 9 files changed, 450 insertions(+), 1634 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h

-- 
2.36.1.476.g0c4daa206d-goog

