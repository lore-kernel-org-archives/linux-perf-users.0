Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD55EB64DC
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 Jul 2023 00:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGSASm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 Jul 2023 20:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSASm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 Jul 2023 20:18:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F4134
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jul 2023 17:18:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ccabb20111dso3369507276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Jul 2023 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689725920; x=1692317920;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3OvYnUXhgex75QX5U1PzD5o/QrwcqmO5OIHxzMjFjqo=;
        b=PiKNCRuZgqEfYgPlOs9Lx4w3rfFPcZ/ikLGlk/Jr/HMX9FPypQNcJqBvpOjrdpBEF9
         6gp17GYCae05BZ3qR/b8xWAiwVQRypbpnyx7xnhTnN0IZvuWyT3qtNmsnm8VEA6e1XwA
         us3xnQkmRH6P8grbzAGN5urVi8svcz+OUVzVEl8rzsIV52TMeDyhbuYHd1lnouILzJJN
         br2Z7oUyIp0xvL6MQL7z+IoXceo+jrpc7PPDOWpiHmklTYViTH+udyBAUe7Ijsk8r0qv
         /eNN9k2QZdGPo5IYyc43N5LSMhfiqVKjmn+G+xuAVwVaQtMlrfsW9WRHc5OxYqBTjbgG
         Hx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689725920; x=1692317920;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OvYnUXhgex75QX5U1PzD5o/QrwcqmO5OIHxzMjFjqo=;
        b=IXyO/ePOb0aSRMxcrOW2Ewf4JiBNP/7rAOL3Yi7kLIzTvG5zOGpQhDiMwfsPGSMx59
         vpgO2ayzy6t9fvcQLU7dzHEneOvj9re07tU7FG9CzjXjCCP0bTxzxcg2A0vZG+DnuCk2
         69D3+SRgcCz8R3nlR2u0ylPd4jTHKr9/qKZGVZ0RLG7s6rXvO4KZ23UkpkJ1roJZvnor
         3AqFlLqpYwmmJKoY823uCU3URRw/t5HGdEkPHntwCuBTzVCTLuI8F9h5gPPG5yIgIQdL
         XOXc18HR5ofFhW6R409smsyAWE4zpb9V6AAP/oLe6DCOKFlrIFTS67//X8XTX6bt+zcj
         O7WQ==
X-Gm-Message-State: ABy/qLaJzKciwgwIblSFSp0WzFJ0VKug/jVI+8DIxXyE3Jfm8vBps8BN
        ZlrxOhZYqNk11pbDmf/r3bwNAjVxHidS
X-Google-Smtp-Source: APBJJlFJOAFe5rJL86qzWIsRY3lDf6NnGfLOgnpqNhepHk0GWPWVrml60+l9Ld0nV6BKuWdLkuJRYeF3dW0m
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c587:348f:a079:d876])
 (user=irogers job=sendgmr) by 2002:a05:6902:1746:b0:cea:ef04:1c61 with SMTP
 id bz6-20020a056902174600b00ceaef041c61mr12142ybb.1.1689725920315; Tue, 18
 Jul 2023 17:18:40 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:18:33 -0700
Message-Id: <20230719001836.198363-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/3] Parse event sort/regroup fixes
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Patch 1, fix:
perf stat -e cycles,slots,topdown-fe-bound
so that cycles isn't made a group leader (failure caused by PMUs
matching). Previously this event list would fail so not necessarily a
regression over previous perf release.

Patch 2, when regrouping events the leader needs to be updated due to
sorting. This fix causes larger event groups that then regress at
least the tigerlake metric test as the kernel PMU driver fails to
break the weak groups. This is a fix for a bug but the consequence of
fixing the bug is to make a passing test fail due to the kernel PMU
driver.

Patch 3, don't alter the list position of events without a group if
they don't need forcing into a group. Analysis showed this was the
cause of the issue reported by Andi Kleen:
https://lore.kernel.org/linux-perf-users/ZLBgbHkbrfGygM%2Fu@tassilo/

Due to the test regression in patch 2, follow up patches may be
necessary for Icelake+ Intel vendor metrics to add METRIC_NO_GROUP to
avoid the kernel PMU driver issue.

Ian Rogers (3):
  perf parse-events: Extra care around force grouped events
  perf parse-events: When fixing group leaders always set the leader
  perf parse-events: Only move force grouped evsels when sorting

 tools/perf/util/parse-events.c | 58 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 22 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

