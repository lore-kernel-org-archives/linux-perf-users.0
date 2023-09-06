Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE40EE14C3
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Sep 2023 23:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbjIFXoe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIFXoc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2023 19:44:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990D94
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Sep 2023 16:44:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58daaa2ba65so4637867b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Sep 2023 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694043868; x=1694648668; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+URDfp1vmUnXA0TNecMPXbtTgLIonsOk2VAg6fREvI=;
        b=zHjXjO/UGZy3RRHHUmnI44bM1PZmZWHq+t3EuhOspUU+fB/jWSJMDCjcbkk2LopzQH
         yqDB9OB/Wy3FNbXskHmJn4/VIlHELLYrNGUExiFZOWXvkrGMxo7C0DJ7kRDAu1FSHrj0
         ySA6jhVy6TlhiQgdAV7UIKtCKLX+KvX0lQ+WnmMqU03lzLB/sPWrOR/qMYjjf7rHCR0k
         MvO4OwZQJ7zMmLulbV+due+R3ltlinEprot+uL3QZ+tnu7OaEM1VyVVbD3und91Al6jh
         mb9Mr3H+vlJA8mb4PnnhEEaBSKOQHqAOsdHdqvO1rNJ8HPUkfFdD5n4YiXZ7UpMJr1ec
         3w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694043868; x=1694648668;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+URDfp1vmUnXA0TNecMPXbtTgLIonsOk2VAg6fREvI=;
        b=jkDeJ6tAnRS194/w4POBmZ6BsiIw1XikS29u5Ds0X1iLvB3om49T+o87lXSdolmllz
         NZFzEje3PqcfDXueX1OIgPwKmzgjUENMLHNWUc+xkGjj3OF0SR+dewKmiDEdaFaFyl7d
         HR1P1tERZ3VC03lvOoXANxFxMbOcVnru50paR88CHlUEFjjBlAlNoZKHjYgA5qBmwK9Y
         c5VvcM/BCU9AFVmTX7S331kdFBr2uuf2v9kxQ0Q7YLNPp4E23vSvhEetCA6x/F+YOgGw
         ptBuOGxlz2YvyWRG3XSOXhz56Oh8JPlVoceQ3rVcuHyrcZZq6rYV2miNmzcS+KzuXTGc
         3cxA==
X-Gm-Message-State: AOJu0Yy8Rn/z1j8cKWFWWb1TVGI95/uTPXjN1tUoXAfHYw7IdL+ojGgk
        uplEtbXuLo7YxCrmry3U+VEBfJ3HQ8Vf
X-Google-Smtp-Source: AGHT+IFUsJFd+ZXwL0O9cqJfkHWMky3iGbPQNlocLh26uAaNrkFX/dpC4F4qxtqil6Na0N1gy2uRA4MdRv6i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e535:39a0:5730:b9dd])
 (user=irogers job=sendgmr) by 2002:a0d:ec4a:0:b0:595:cab:4bc5 with SMTP id
 r10-20020a0dec4a000000b005950cab4bc5mr431689ywn.4.1694043868077; Wed, 06 Sep
 2023 16:44:28 -0700 (PDT)
Date:   Wed,  6 Sep 2023 16:44:16 -0700
In-Reply-To: <20230906234416.3472339-1-irogers@google.com>
Message-Id: <20230906234416.3472339-2-irogers@google.com>
Mime-Version: 1.0
References: <20230906234416.3472339-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1 2/2] perf list pfm: Retry supported test with exclude_kernel
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
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

With paranoia set at 2 evsel__open will fail with EACCES for non-root
users. To avoid this stopping libpfm4 events from being printed, retry
with exclude_kernel enabled - copying the regular is_event_supported
test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pfm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 862e4a689868..5ccfe4b64cdf 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -145,7 +145,20 @@ static bool is_libpfm_event_supported(const char *name, struct perf_cpu_map *cpu
 
 	evsel->is_libpfm_event = true;
 
-	if (evsel__open(evsel, cpus, threads) < 0)
+	ret = evsel__open(evsel, cpus, threads);
+	if (ret == -EACCES) {
+		/*
+		 * This happens if the paranoid value
+		 * /proc/sys/kernel/perf_event_paranoid is set to 2
+		 * Re-run with exclude_kernel set; we don't do that
+		 * by default as some ARM machines do not support it.
+		 *
+		 */
+		evsel->core.attr.exclude_kernel = 1;
+		ret = evsel__open(evsel, cpus, threads);
+
+	}
+	if (ret < 0)
 		result = false;
 
 	evsel__close(evsel);
-- 
2.42.0.283.g2d96d420d3-goog

