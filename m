Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8964FECAAA1
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJXS7a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiJXS62 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 14:58:28 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7516F74D
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y18-20020a056a00181200b00565b27c2611so4946714pfa.14
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwUbAas6HwUpEbmohIDJ22IirHP0xTxc+7b+i3VB6U=;
        b=WNe4EQeeykspT4w/Io584+kx9lh/QeoAHLehl3suvkUCe1Cp12l+MOrLPerfCGXYSl
         tkULm4/+1vo92FIS6jrd4ShA6Wd+GOg80wHhdUNFIbzKf+CrNIIAjHCwi3oT8c+RDn7I
         rLm16gXSUTHOzSc+IjDqbYXGp+Ssc+Z1x7rQuGXozqHAd2ZYNYN/Kv/ikwNHa7nd1L3T
         s3B9IpBNSrLhMbYoAfN4Qscgo0OjOPVbDyLFGAVmU0arJMtRwsJa2A7QotYaDgvYOkvw
         vgWeT/2lmLHaADWBVOZkK6uIAlE1BLHzV2/bDmUo59pB6FYxwRynWnYrLYqSpkif8lzg
         yngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwUbAas6HwUpEbmohIDJ22IirHP0xTxc+7b+i3VB6U=;
        b=F227VJdzZwGEvTncdVtv+SAqUUbkY3wpEXUfoSzosGPLBLJ9QzND9zY105ob92i8cf
         vfAVx3PsGEB4qHndvoraCR30OuRTmMPJ0JnWnx+hNq+/DjgeOS0nJCWhcx/t78qHmam1
         0O4Tovqd8tFR6Okl9oYRzgQ4JI1AblvNinJrifLRCucstaaCTXILNNl+0hwm761uZS4h
         wBAnednWoVS9PrRlsiiKvIXZcAgdpBklxmJHCDlzRACr7XThW6fcWVnEahB50860JXNI
         GhdSG5eIxD9vJUMddxJXuoEkSfBFPeXNErYaWG/PT8aMOzFK/55rtbSDdfviF9i8wn5G
         Hbjg==
X-Gm-Message-State: ACrzQf0G2V1co7oi+borSYo/8W6XMqjbd4Rq0iH3g0r+dNMIssCFIrtP
        9s9mut/EQi0IG2GQHsx90fuUTqeYwwFe
X-Google-Smtp-Source: AMsMyM5Hal+np002XCO/XJUFdXFLqN4uPHd6YA51dLU/cUcRa+TfD0iPG/3RnFU9UaBwh/lgH18ME98noPZR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:e90:b0:213:2708:8dc3 with SMTP id
 fv16-20020a17090b0e9000b0021327088dc3mr233702pjb.2.1666633007051; Mon, 24 Oct
 2022 10:36:47 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:23 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-9-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 8/8] perf trace: Use sig_atomic_t to avoid UB
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
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3c757769b96..72991528687e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1535,8 +1535,8 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
 }
 
 static pid_t workload_pid = -1;
-static bool done = false;
-static bool interrupted = false;
+static volatile sig_atomic_t done = false;
+static volatile sig_atomic_t interrupted = false;
 
 static void sighandler_interrupt(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

