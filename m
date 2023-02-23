Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE6BC636D7
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Feb 2023 05:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjBWFx1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjBWFx0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Feb 2023 00:53:26 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A936FC1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 21:53:25 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bfec4a66so106517287b3.5
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Feb 2023 21:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDgXS1ftumo1r65N+SbOeCecYRv//vJu/P3chpFR5JQ=;
        b=nm+fgnXRAHDlICA2dS9MgRkbQs2nSJVBBOYglg3/KRf4PfqmJIHgcrQMjNcz9Imaye
         3XuYy/14YPK1YzI98f3OtdXzP+LyJywgOkBk7gjTk3Lg0WkzEGFjbSGpHQOBMOBY13o5
         GvW0Iku8BKE9SFt7eW9e3BOTuaCs685odbhFnO/6TdUKtAyk9qKZXplCsm/3S6+PmCwO
         XX13ETDSg5gEUyBVnFGjBmB6KLBP1gCFpnpBTr+GxC5ACwJdH+N/hl2Ak3tvry1+zALV
         DBWZ3fXGZbPzZnekrzozq9Zc2vGygAMxvhQUj/Ve9RgEBEi/kvOp2xU4EvY1gIuWjJkt
         caIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDgXS1ftumo1r65N+SbOeCecYRv//vJu/P3chpFR5JQ=;
        b=uk0PYG2XCLhyy2hs/LuYDDPVaGgoeT4GacfutJUL9xnSx8pSZiVPfkOwtF+gkPuCYO
         80uYtzVuGOhxKd3mzUysfM7CY3TGm4QGNo4CH5A1AUlo38V6Kuhoy4mfZsBbaksjwD8e
         db+YtArX6VL/1jH4FCvao6DHguabJP8VeWTXI8xo+pJ5HRoY2TxrP3Fll4X/RVoJ3QMW
         TFp5qAf8KUvsYRJbukFpig0cgbu1ZubF7PcCxxkj8aZGzcXmjnUJReoZbvRHEt3r/1jT
         D+CjiSes40b2u4ZniifXAccN3mu5Lcmok3GjG66KB3TrhglZh/3pVegaUn4uHrKGRFYv
         wrbw==
X-Gm-Message-State: AO0yUKXinoMpYA4Bre4kzP6Kj37QnPeksHDil2JSXchK1MEYq5iCcks+
        fFbQIFZ+1/q8JCEgYpdcyNLT/wVEBjxj
X-Google-Smtp-Source: AK7set+p2Eid2y8XQfngFt7UiVeZneEnwLO+j03PtLgelli3+OybfcZRHUyv64woWmRAA9xg93yark0S4EKT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9002:67cd:9e6b:7083])
 (user=irogers job=sendgmr) by 2002:a05:6902:138d:b0:a09:314f:9f09 with SMTP
 id x13-20020a056902138d00b00a09314f9f09mr1623114ybu.6.1677131604657; Wed, 22
 Feb 2023 21:53:24 -0800 (PST)
Date:   Wed, 22 Feb 2023 21:53:03 -0800
Message-Id: <20230223055306.296179-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 0/3] Update Alderlake and IcelakeX events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update Alderlake and IcelakeX events to v1.19.

Developed on the perf-tools-next branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Ian Rogers (3):
  perf vendor events intel: Update alderlake to v1.19
  perf vendor events intel: Update alderlaken to v1.19
  perf vendor events intel: Update icelakex to v1.19

 .../pmu-events/arch/x86/alderlake/memory.json |  8 +++++
 .../arch/x86/alderlake/pipeline.json          | 10 ++++++
 .../arch/x86/alderlaken/memory.json           |  7 +++++
 .../pmu-events/arch/x86/icelakex/cache.json   |  8 +++++
 .../arch/x86/icelakex/floating-point.json     | 31 +++++++++++++++++++
 .../arch/x86/icelakex/pipeline.json           | 10 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  6 ++--
 7 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

