Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86278C64ED6
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjB1IoI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjB1InZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:43:25 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D58F969
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:43:02 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id bn17so5140195pgb.10
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcYnfVUhbZn9a7DJQxPts8NFnTbESI3ZdIxOG6ZSYi4=;
        b=rSgvDtF/wwjYXMC8nd8jl02NHDbmTcn0gvXseij+B77jqtsUvpDDcxJb5MVqkBHL1l
         1HVCqWtP3q9PkFZPRmKYXrWxev+8EAvtQFkcxqAQ4IT8I7hyeI5949yw4uhTm/kDJkRZ
         RVOLBobVsBtlVilhO8rkT0bbF87WI6wL2OTrUW/nTzFUDKdtncuOwR2U2QepXvUCPy79
         qejTQRoq2MKcuDAgCrykXjfhcNnk8LMulDiwcxGaMINgNePoRpkz9txc8oE5jUQR8y85
         pgqUu0UloLIm00IdnbYBkO1TCxDVmB1JSz5iwTEPfjLaLMEBzvfr55wd0jcXiuRjb5Ms
         GKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcYnfVUhbZn9a7DJQxPts8NFnTbESI3ZdIxOG6ZSYi4=;
        b=1/v+XLAIt/LJL2JPy46MOnxSuRq7UiMCClnyKJXUjO+mfF9W1i+xbi/jmrpN8L0euD
         v6SUqbabgAI1xJjkddg+ivuxmapvrs8XZ5MLAVWiyW5on/9FYG1tlhwe5MqUO4I/Wcuv
         7qku6XScWD+d+f7ya1EMxBM9G00J4m+Xk/mGqx7Py8YT3ww4r7is7wxO7OZcZq3Itcz0
         catDN1JsbU3qQQ1R0SFJiXtlx6edcMwZUs0i/oKbrYdklcUlFKU/VRv1bSAksXeMO5iM
         2iHx4mbAumROiWUYzrB7QXDhDFS1YbQNDEhMe9z7VgPOKncMElyPUBRlpLbeQvHl5XKu
         NV2A==
X-Gm-Message-State: AO0yUKUm10E3bu2CKTSjZUV7DcUMiybaTgcOQ+ZDvV5b3JEMEXTU92LQ
        1L+yfajfOovKn0HSO/NmrQuqQg==
X-Google-Smtp-Source: AK7set95msG1/6Sh9v+FITXHpNA20OgLeQT3mg9oPI6viuFokojuKa/LaXMD2mJYpxmReRbXZ1LarQ==
X-Received: by 2002:a62:1808:0:b0:575:b783:b6b3 with SMTP id 8-20020a621808000000b00575b783b6b3mr1778268pfy.28.1677573780039;
        Tue, 28 Feb 2023 00:43:00 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:59 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 14/14] perf kvm: Update documentation to reflect new changes
Date:   Tue, 28 Feb 2023 16:41:47 +0800
Message-Id: <20230228084147.106167-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update documentation for new sorting and option '--stdio'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-kvm.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 2ad3f5d9f72b..b66be66fe836 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -58,7 +58,7 @@ There are a couple of variants of perf kvm:
   events.
 
   'perf kvm stat report' reports statistical data which includes events
-  handled time, samples, and so on.
+  handled sample, percent_sample, time, percent_time, max_t, min_t, mean_t.
 
   'perf kvm stat live' reports statistical data in a live mode (similar to
   record + report but with statistical data updated live at a given display
@@ -82,6 +82,8 @@ OPTIONS
 :GMEXAMPLESUBCMD: top
 include::guest-files.txt[]
 
+--stdio:: Use the stdio interface.
+
 -v::
 --verbose::
 	Be more verbose (show counter open errors, etc).
@@ -97,7 +99,10 @@ STAT REPORT OPTIONS
 -k::
 --key=<value>::
        Sorting key. Possible values: sample (default, sort by samples
-       number), time (sort by average time).
+       number), percent_sample (sort by sample percentage), time
+       (sort by average time), precent_time (sort by time percentage),
+       max_t (sort by maximum time), min_t (sort by minimum time), mean_t
+       (sort by mean time).
 -p::
 --pid=::
     Analyze events only for given process ID(s) (comma separated list).
-- 
2.34.1

