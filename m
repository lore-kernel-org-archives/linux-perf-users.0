Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634F3ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 18:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiJXS62 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiJXS5p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 14:57:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE6A1F042C
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so9794449ybs.17
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=j+74AYOxCaajozdBfiO5kv/80FZYXYndelThFiPyXfTn5d+15h0iTwKi762lYKKt3M
         wXCC92m2LibdA4uqtYnNfy0lNPA1tSrSqmtmmO/doOPBrPkkUDb1C+6ElrbnmtRX6M5R
         Fe4V2jfcpE6ePzNLE+3Q84vJggdtywVZ5+x9VA7CLp2obDtqoh5VLeHIPpob6Jn8w+Ql
         10SMYYl33WZclEXBIpVktcohFEvcfz1wo01/cPGUwMJ93DIY41SmmQ9P9CV7Z9X3QhGp
         KZqbj05kQPns4meT8vTk/c7Ym60Ec3DoHoiaqN39sC/PReynUtjWH61qFKOotqnS6Nw9
         pgPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKQRTEXGqt08SGBdEhLKezf4NlN9FWNmZKirRw+wNE=;
        b=sJRqqPMaketF24kW4bgTLfbRpWoMt5qI5AWOHOk0OM6SkV9X+Vc1l7Peq+h2HCDj58
         vdDkY0m3BEGy4Z8Yj+AaruCpLV4D1rwu7lM5dmdYCXckph4jEQyRLBtHiY5juFZYaN5Z
         MsPJ1EWi46NiToN7thDQvx69u27rS2vNp8/O9hiiemnU3Dmk53sHxtA1KWkTJDar2Ekx
         z1EH2aFtQHsWo4vnu7jE6pCLXkd4wU9t754xMBfbvl8r+4flhrEFcAxGgk84HhO/CFoH
         kHT9QncCIfNHMYD63AsOyl76fKnlynRPcyEajaB30n/vfdZbQ0VbmVOLBC3mTdOPqr5H
         ZmRw==
X-Gm-Message-State: ACrzQf3atiamoO7ghty1xlbtYIaptGE4sDdaf5dA8IL/p4Tqq2jhZC6z
        nqsp/Ptp11hT9QosAdM2gJHmv3zYRj19
X-Google-Smtp-Source: AMsMyM5XYqtNgXUFd1h7brKL0bHrVRyG5HrQ1WbR+O1JB2SeqeRi637dBIgo+oclvIQ4a6cQ5REYI+m+j9z8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a25:dd2:0:b0:6c0:7938:5b43 with SMTP id
 201-20020a250dd2000000b006c079385b43mr30564176ybn.280.1666632998495; Mon, 24
 Oct 2022 10:36:38 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:22 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-8-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 7/8] perf top: Use sig_atomic_t to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use sig_atomic_t for variables written/accessed in signal
handlers. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4b3ff7687236..bb5bd241246b 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -87,8 +87,8 @@
 #include <linux/ctype.h>
 #include <perf/mmap.h>
 
-static volatile int done;
-static volatile int resize;
+static volatile sig_atomic_t done;
+static volatile sig_atomic_t resize;
 
 #define HEADER_LINE_NR  5
 
-- 
2.38.0.135.g90850a2211-goog

