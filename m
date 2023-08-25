Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD18C3DA66
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbjHYNxU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 09:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245242AbjHYNws (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 09:52:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D61BD2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 06:52:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d78452de9cbso498038276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692971566; x=1693576366;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BhixeHvMu45aDRLT8BXtYp6C1FaHvg0V+ngeFdmjaWM=;
        b=vAfXVSxR20QAokFomQuPbwdk04Lxzl1E6dP42bitTnZXR45YVREpMyKU7DksbANxci
         yKcyt5gL2cAWFTFTQ6Mfto2DNRJYfzpL6445E17ZsxaYklQbvOAXIKSVqL3Klo6/0eil
         VgbGEGtxmywRssB5dDrUidk0T+dhsXpRYFLw3racy3erIq3uZ1OQZEMlnkcBs+raRlJ+
         FGaqrxcLrmj+fklS4aqlPZdnOkWB+BuDijigb46sNqZTWmLmpE7qzxkidztaPpGYs44I
         p37x2puA1cdv5jLluNZyHkZ8om2Cj4OknSRs4TCRDKbiIF0zZECxlwhLiW5T7KB+h2WS
         emfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971566; x=1693576366;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhixeHvMu45aDRLT8BXtYp6C1FaHvg0V+ngeFdmjaWM=;
        b=UsucOo80Y+0Mtkv73Pl0rz8CxFvhC8mOgcoCVPCwg+rkerjQhSv/C2DPHk4LuSnWcJ
         t/xQuDED90lbPI02/Iq6nuRagZxZOtpf59IyTRKFyijvJBI4XvzX8a3HFTvF6NyY7nC2
         Ai3q4RqxaD1BGlu+JC4v1eQFofb+r7lNtfYT/KFspHVwVhwBbi+FQV3yt565X9FmQeGV
         515ugcDHCJPHhGy/iZ95TLoltCvxpKXKb4lTXJq2Xx56cj8C96TxC5Muh9UrHSfMJHr0
         Vfc5G4nj94HB0cNeDJWwAbw3o9JZpARYVnJXcb/7wgWBEKhjGVmVg2guPYfo0UPQ8Xsl
         1iRg==
X-Gm-Message-State: AOJu0Ywedaom1RT9JGOaD/e7PJ5YigedqV6ufpn4o5FFBd7n/INYBz7e
        gHiHOOZGWF30rgGGkN+BY3JOCcsznk0M
X-Google-Smtp-Source: AGHT+IEgpTmNIc7KOSf820fw1DANJ7Ec2sG87zEQCs3uLASLershQlmKmBMo/EgdBSu+MEY1ZthbFtCLR/J6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a25:b90e:0:b0:d07:7001:495b with SMTP id
 x14-20020a25b90e000000b00d077001495bmr467015ybj.11.1692971566200; Fri, 25 Aug
 2023 06:52:46 -0700 (PDT)
Date:   Fri, 25 Aug 2023 06:52:35 -0700
Message-Id: <20230825135237.921058-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v5 0/2] perf list: Remove duplicate PMUs
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

v5: Improved the 2nd patch's commit message and removed an unused
    variable as suggested by Kan Liang <kan.liang@linux.intel.com>.
v4: Rebase on top of lazy PMU changes. Ignore numeric ordering due to
    gaps, suggested by Kan Liang <kan.liang@linux.intel.com>. Fold
    patches 2 & 3 as suggested by John Garry <john.g.garry@oracle.com>
    (done by accident as part of rebasing).
v3: Add detail to patch 1 sorting commit message about the suffix and
    why sorting is necessary.
v2: List all PMUs when "-v" is passed as suggested by John Garry
    <john.g.garry@oracle.com>.

Ian Rogers (2):
  perf pmus: Sort pmus by name then suffix
  perf pmus: Skip duplicate PMUs and don't print list suffix by default

 tools/perf/builtin-list.c         |  8 +++
 tools/perf/util/pmu.c             | 17 ++++--
 tools/perf/util/pmu.h             |  3 +-
 tools/perf/util/pmus.c            | 99 ++++++++++++++++++++++++++++++-
 tools/perf/util/pmus.h            |  2 +
 tools/perf/util/print-events.h    |  1 +
 tools/perf/util/s390-sample-raw.c |  3 +-
 7 files changed, 123 insertions(+), 10 deletions(-)

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

