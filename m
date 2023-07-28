Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13E1C0015E
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Jul 2023 00:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjG1AM5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Jul 2023 20:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjG1AM4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Jul 2023 20:12:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7086C2126
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 17:12:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5a479bc2d4so1457886276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Jul 2023 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503173; x=1691107973;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pjo35PlF/wWvhS1Cmx8bdMFmFen6pv+m7YZnMKsM5hM=;
        b=Kxi7gcEHRIDlZ8Dkc2GhTzNZ20lYfZCvlq+ldSJviigTVdp0JZgOz5hqDz2Aa+rfvi
         ALuAGwd59azVJCigV88ctSOJRFGTPP4BBeZmqsXtVJHiu8EPgdhC+vGXNffNbbA7hgqk
         ch9Vw/sRFCzPTn5XUWe6FfCeQ5btSOpQNPO+NUm5v+uKBT5PVH+SPSlp1/7oen9+0w2w
         k3RM8rts+l34AAbcdCkYj/0SI/q7OatEGzGM/HC+I4fcH9sd9tJNIiSqVDD7ku8+8viG
         bkmvcEUxK/AocjL1j0qx0gGXFo9PmD6uL+XwQYpa4obRkNKAZhZPCKBbc0//y5EraIMJ
         ZKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503173; x=1691107973;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pjo35PlF/wWvhS1Cmx8bdMFmFen6pv+m7YZnMKsM5hM=;
        b=eYmTBoEX2xD8a0JgEjRPX5NaBHzkL+z/vm0W7HAIaxRY7z1WnmtTYqfw8uG8eQEYvv
         pnkg1EPr+qFO/oreqRO//cywJ9IdED3++XDDObNEHhunpU9/qU+ZHgscpse/q607liSH
         karmwkLO6TEDXX3XfNSB9fVaa0PBUpHfBfP7R0n4I5rnQWVOjNAW6EEcA3+CjJ70Ikvm
         rNKu44yNimpr5AfaJaEow7/Hl4J4E6P7GQUllL97siGSk3LIHXac3dPFX+ueyi1wEKdZ
         NQOfnIfb9mJv+wjBF1a2h0JllngKVU+IZTnd81R6JKw77im+we3joyCr6OIohi8iV9FU
         nxEA==
X-Gm-Message-State: ABy/qLZVSH5WsoJ2PoNocKQvlK3sqn8IPaQElGAZ/CVfhJqbZLEkBobw
        IanKz/yCrKRhwmDTU4qbb1pYMr5Lztkg
X-Google-Smtp-Source: APBJJlF8HwXtj+YshMZZDcCVKC35WCn7D5t/5BkZSF40yl9o6ZL5PKImCZTzA7ciNPRV+LorQdyG8DubR6So
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:37d8:0:b0:c64:2bcd:a451 with SMTP id
 e207-20020a2537d8000000b00c642bcda451mr973yba.7.1690503173648; Thu, 27 Jul
 2023 17:12:53 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:12:09 -0700
Message-Id: <20230728001212.457900-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/3] Remove BPF arrays from perf event parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Event parsing was recently refactored:
https://lore.kernel.org/all/20230502223851.2234828-1-irogers@google.com/

During these changes I wanted to get coverage of all parts of the
parse-events.y and found that I couldn't test the array code.

The first patch fixes a BPF testing issue.
The 2nd and 3rd patch remove the BPF array event parsing code so that
it isn't adding complexity to event parsing.

Ian Rogers (3):
  perf parse-event: Avoid BPF test segv
  perf tools: Revert enable indices setting syntax for BPF map
  perf parse-events: Remove array remnants

 tools/perf/util/bpf-loader.c   | 101 ---------------------------
 tools/perf/util/parse-events.c |  18 +----
 tools/perf/util/parse-events.h |  10 ---
 tools/perf/util/parse-events.l |  11 ---
 tools/perf/util/parse-events.y | 122 ---------------------------------
 5 files changed, 2 insertions(+), 260 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

