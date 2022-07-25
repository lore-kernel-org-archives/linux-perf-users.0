Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03303C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jul 2022 22:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiGYWl0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbiGYWjo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 18:39:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177FC26109
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:38:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31e619dcbbaso96551857b3.14
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0r3HjsQD2+mb0wsEzIakMgBjDsOoNwszNIkiBQ7nAXY=;
        b=S9EUsYTZwhR6CPCBNnM0vibmcEI78YknZJu6QIUxRwfi8v4ImQJTCfcL8zKRGoSYkK
         7WwkA72kep0BQa128skm5JZFi1ysRM2siDYpZXGV3S5GkBi1ssYDynpmurb8EhgoDhzU
         ww6IoOQi/JAjVKKOgCmd8cKKQdF37OCwZC9uvfSc+SaunWDj64pczNT3UxWC0IebkT4t
         fZ9VKzu3G0qgBRBQIqhVhhsC4waZRRnXah2f7tsfnOqjzJA9gjKe9BRzEkjanmyN7kss
         ZlB255aLtWvqXlYilDwLS7JejRiLoF/0It3OrzjWpY3lqs9/R7SD8lm1mkp9uKNP519G
         SsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0r3HjsQD2+mb0wsEzIakMgBjDsOoNwszNIkiBQ7nAXY=;
        b=W4pkDc26stqfAQaTdXm4na1pDQFjp855hCU6rNTXfmL3qlDAnMr3N/2H5IUG2eiyXG
         wpuKEk0ZOOvImplGua4P170Rqnem+k97KWXNgFuSkbF7x42X066R5hManVqSxWTMSHGl
         Z8+3bePcVjdRds2XA3Ee1Ow8j8OURqiUZqBtHgiJWNZDdJpyVDpE1OjjPGKvYNu7qOfU
         6F9KDbsu/iNi3qYDAtG/3qpgTyAzpFn/7Da0J6FBQl2wnYI0Wn7VYkU7UxpwRCeNdYoz
         Zem6aZ/a9FJPf6TO4kHqpXOA7uMIhXSpIdQA4zx76fSBh7R4o2qgCKNz3dTzkynxFQUX
         o6Aw==
X-Gm-Message-State: AJIora+ZMg89cYgb+aitzwNijbe2Hk+QhDLsOQhDHJrXiPQ520n8dCiK
        6XJ4seO0I+8bYZWkvCakd3dZ7Bt/B5Iv
X-Google-Smtp-Source: AGRyM1sBEiKwTqirqb0r0WooZIhScMRsn+/AtAKFxZ6scFO8jt80M5g6Z0CE9Rzq8PIP6g5h14LkhtOCuPwB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:9208:0:b0:66e:b73f:cdf4 with SMTP id
 b8-20020a259208000000b0066eb73fcdf4mr10579288ybo.300.1658788683969; Mon, 25
 Jul 2022 15:38:03 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:31 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-31-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 30/32] perf vendor events: Update Intel westmereex
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update to v3, the metrics are based on TMA 4.4 full.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually
copy the westmereex files into perf and update mapfile.csv. This
change just aligns whitespace and updates the version number.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv                    | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/floating-point.json | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/frontend.json       | 2 +-
 tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 4c00b050ebc6..4cf708477680 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -27,7 +27,7 @@ GenuineIntel-6-55-[01234],v1.28,skylakex,core
 GenuineIntel-6-8[CD],v1.07,tigerlake,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v3,westmereep-sp,core
-GenuineIntel-6-2F,v2,westmereex,core
+GenuineIntel-6-2F,v3,westmereex,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
index 39af1329224a..666e466d351c 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
@@ -226,4 +226,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
index 8ac5c24888c5..c561ac24d91d 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/frontend.json
@@ -23,4 +23,4 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
index 5d1e017d1261..0c3501e6e5a3 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
@@ -170,4 +170,4 @@
         "SampleAfterValue": "200000",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
-- 
2.37.1.359.gd136c6c3e2-goog

