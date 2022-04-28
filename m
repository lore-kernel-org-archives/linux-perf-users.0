Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1CC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 07:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbiD1IBC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343625AbiD1IAy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 04:00:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC39D4F0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 00:57:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r14-20020a25844e000000b00648bdf7491bso3924227ybm.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=WbDS88DQIjjAAnPNNRJm6QxdO8FoD18taeSIjkeeF7Y=;
        b=kD/nG/4nCV5aP1SrGgDoLmcnNyZ4OBFcelAIx6MLZqretsqG1RknCqObGFFu8jW0b1
         TZqAPn35flfazlRI9kQXJFNRYVqrgzHF1Wi6+O2l2N9jBjDaOXnhEsJLuOd1OLcMKxNy
         MQ1tH5aREIZStjZOg0hJnHjLcZd13SmgcQV7lvO+9n/J5FaBsV3oFe94QmHEPWyJyOZh
         +MVGeNIxHUQulsx8Gi1sRQD/YDUcO/WkCeSz3s0xJnF7SNBYwIlsP+5OaS68bVU9VTFR
         2eSblLnAn2ejj75yfHc+qGpuxEchJIZMWKFdeKXfKDFbzRKWFg05IfC2RobYUObNClbn
         YnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=WbDS88DQIjjAAnPNNRJm6QxdO8FoD18taeSIjkeeF7Y=;
        b=GAFJgiWOe94NrKOLzZK/R+0o443i9/NmynEIo8Gl7OpznVpNN5wIlWmozEfiDfH1ac
         WmLEAmhzDKY/Kaojzjd9W05mMNz0DakPM4f/+HZ8Kp0CE27SpQv6L346VYW6lMGpzSGx
         HgpkJaprIYhVTqcUmGrcty6Nd30Bi+Z8mg9HPV6B1vGV8cI/tp4PGtbPDpMOmgRoO6rr
         7QV2cpV+7djZlG5je2prYLG4myRwh/y5fkgxZVLLq3ZVFiGhyUd8moHNBCarFhHXZ1Su
         rJTKaU/kCtby3RWc2p5leA+r6ku99Hz+3GmZ0t50F9E+vmzJlVBu5bO/hGkXE86mXZxy
         lYxw==
X-Gm-Message-State: AOAM53360hY45xwmSAmPhfPj91YlC58dJ2o6vMrNf/6A8uTt/Al7bQk0
        7pn9Sa+SwnZbxbltXobsbflcIIcDJePV
X-Google-Smtp-Source: ABdhPJx2mnPH4DIPYjYxOebfsyr7oE2tcyi3eMqjZu5wuJm/n2hoKgMaaZHal9PfTPHNw4c5OlRkGos3mOeI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:33c3:c9d8:c4fd:e75c])
 (user=irogers job=sendgmr) by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr30732068ywb.326.1651132659749; Thu, 28
 Apr 2022 00:57:39 -0700 (PDT)
Date:   Thu, 28 Apr 2022 00:57:26 -0700
In-Reply-To: <20220428075730.797727-1-irogers@google.com>
Message-Id: <20220428075730.797727-3-irogers@google.com>
Mime-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 3/7] perf vendor events intel: Update IVT events to v21
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Events are generated for Ivytown v21 with events from:
https://download.01.org/perfmon/IVT/

Using the scripts at:
https://github.com/intel/event-converter-for-linux-perf/

This change fixes a spelling mistake in a description.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivytown/pipeline.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools/p=
erf/pmu-events/arch/x86/ivytown/pipeline.json
index 2de31c56c2a5..d89d3f8db190 100644
--- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
@@ -676,7 +676,7 @@
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "Number of occurences waiting for the checkpoi=
nts in Resource Allocation Table (RAT) to be recovered after Nuke due to al=
l other cases except JEClear (e.g. whenever a ucode assist is needed like S=
SE exception, memory disambiguation, etc.)",
+        "BriefDescription": "Number of occurrences waiting for the checkpo=
ints in Resource Allocation Table (RAT) to be recovered after Nuke due to a=
ll other cases except JEClear (e.g. whenever a ucode assist is needed like =
SSE exception, memory disambiguation, etc.)",
         "Counter": "0,1,2,3",
         "CounterHTOff": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
@@ -1269,4 +1269,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
--=20
2.36.0.464.gb9c8b46e94-goog

