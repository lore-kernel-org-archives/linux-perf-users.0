Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1925C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 05:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiEQF1c (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 01:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEQF1a (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 01:27:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41A1EEE0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 22:27:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2fecfc7a95aso63483047b3.22
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 22:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fhyPdQWeqDloOKkKqTz1ZyQ6igO44pea09Y6oXJ4klY=;
        b=oMRiADXfrP4QBwGawTd1L5SwFNv8CHzhSSsJDawBVeWwP1hjzKwNSdHcMag0nDJJ/n
         GXv5QsF//jdR0Q7QbSm9UWgt06i36tZIkrb7AZwSm9jEfm6GQhUElKUb7fojaDVaNfVk
         1gOJzZgeRgUI8Nn2fl2bn8nwPJZIS4W2RcjOaXWTshcGeKtNnPQK6bi7zUuE3h81/ef+
         /0/T2pb7TSSYTtCIuUwrSkqUkkPyIX0rJmsukU8PG7GnmlGTysFxlRwmJ432VFWk7hIS
         36zP+bKKG+ksXei8Fb9P26HV7Mu0sIIjdvpKd8rJRd7hWUiyjDn5IiK7w1qx5HdUMQrt
         kugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fhyPdQWeqDloOKkKqTz1ZyQ6igO44pea09Y6oXJ4klY=;
        b=v8RCBdyGsk8ncPn9NBXiLM1AULvcNWtXfAKkAsSDL3NqjF1Jn5EdriL+nePCV0n5AG
         eKQIeOVUYMWa3MbaaLp/5tgojOIU+6l89rryZ3pRiwn8Z/hII4ztir+shujDgmflL75p
         hMnnA9f8anS0rY5DyQqIBptoWiV63LEhKZsu+szqNIi0jP5wgLgUAMVT3WJ7DqPXe7im
         1iUk9+HFEtIrGyNfIPm41xd20r13pnZ8gX1QX8BwVsP0dG/Af24WnsXifHEbIOV65OCo
         SuNyeSTxceMsbQ9il0ufyOc9YBfX8QI3EL19a23DtfX7cFwuktP6Fhgmzt5t7rt78yEh
         zTQw==
X-Gm-Message-State: AOAM531R1Febwy9IiArZ7znTLqjefaH0XhlnSvIepgyJTlTQc36wRn3L
        9eNV9JYIWBaFzREA8tKeJdwqkiKWiIUx
X-Google-Smtp-Source: ABdhPJzK5gioy2Ufu8Nvw+w5uXCwY7XPZoxsENMWp8krL0HptQF/mdYlJn+xPergrvZ8ZFgsEtAxEMrD/+Xs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d585:282c:3f88:36e3])
 (user=irogers job=sendgmr) by 2002:a81:9d5:0:b0:2f4:dd93:4513 with SMTP id
 204-20020a8109d5000000b002f4dd934513mr23671440ywj.54.1652765247839; Mon, 16
 May 2022 22:27:27 -0700 (PDT)
Date:   Mon, 16 May 2022 22:27:22 -0700
Message-Id: <20220517052724.283874-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 0/2] Fix topdown event weak grouping
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Keep topdown events within a group when a weak group is broken. This
is a requirement as topdown events must form a group.

Add perf stat testing including for required topdown event group
behaviors.

Note: as with existing topdown evsel/evlist code topdown events are
assumed to be on the PMU "cpu". On Alderlake the PMU "cpu_core" should
also be tested. Future changes can fix Alderlake.

v3. Fix computation of number of events in leader's group.
    Adds reviewed-by: Liang, Kan <kan.liang@linux.intel.com
v2. Correct behavior wrt pmu prefixed events and avoid the test using
    deprecated events: Suggested-by: Liang, Kan <kan.liang@linux.intel.com>

Ian Rogers (2):
  perf evlist: Keep topdown counters in weak group
  perf test: Add basic stat and topdown group test

 tools/perf/arch/x86/util/evsel.c | 12 ++++++
 tools/perf/tests/shell/stat.sh   | 67 ++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.c         | 16 +++++++-
 tools/perf/util/evsel.c          | 10 +++++
 tools/perf/util/evsel.h          |  3 ++
 5 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat.sh

-- 
2.36.0.550.gb090851708-goog

