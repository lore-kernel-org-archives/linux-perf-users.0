Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFCAC83F14
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Aug 2023 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjH0NhV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Aug 2023 09:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjH0NhP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Aug 2023 09:37:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F7CC
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 06:37:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bf04263dc8so671809a34.3
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Aug 2023 06:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693143432; x=1693748232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLA0Ib5AzCk7ti/k6S86lw9GLjw/BcXDEQAlpgT5UMY=;
        b=A+OldztKXlooKdJuP3WB5Db5uysvd3ok8mrq9WgoyZG04+06r5yYXDJ66wkM95vZ9L
         GPHj54kMT7uNFrI3fpv5NpmuuzBd0XFAh+RYEsKz6NuyQ6oX8yDk1vnqNXrPHwRvfzZn
         YoCDfCAPqi6JnOKrIChPl3o8MRdGOkuquANX0KbvbIr7y1CQGr6JSiqJ3wnW6/YL8UwR
         +iN5aULN4vnIWw+f6OeIRNYf6T5pkx8HmcwJzhLvzqrKCp3QVXMxfQu/vpkU15np1PDj
         IrD9EQKShBRCs4xZ1CchqX5Ai+cboDIc83x9COaA1XbZ50BiJhAuBuo7+ksVr5NOg9PE
         UNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693143432; x=1693748232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLA0Ib5AzCk7ti/k6S86lw9GLjw/BcXDEQAlpgT5UMY=;
        b=QLVXxJVTmXO/2K/+UD4g5p6OiDsAMyT2P9rsq/Lerq1pT4hxtjGbvwmoG2cEqvhC4Y
         q4gQvK5YQfcF+lx8lnVus/dqk3T2SAVFelaMTJMw0TdF4I8l4+EnnZ2i5sQlQZtGIrx5
         eb2QB6iM5bBbHNPcyqrANO2M1AtcC09AIuzEJ/R/Yl67Mu1WEHj9yYPlLzOkGFRoyElf
         7c0VHoDdqnMxitOnbjTax4DwUd3PHdZhyWD4lsEzK2R7C6iGUxSnxapAxV7m3X0IrfUg
         jY02/47ubtndLlfW8tuTPK7kQrKE2JCBiAEvQ68bss4LNQ3rRaasQCTyWHtzEpz43Cr2
         vYJQ==
X-Gm-Message-State: AOJu0YyauKO6lSKDAsc6NPlgF/NHZ0mfRE5OK4BNOoq8daPLXhRM5iVl
        2Hgremd1uPzSvz3nTniUJ35teQ==
X-Google-Smtp-Source: AGHT+IHjn1XtKkD4mijnJVL6NgY8vzvVOpyDcVYvx81nneRxIK9gZ/MHZYfAlpmyu+5ADKt0rIuPZQ==
X-Received: by 2002:a9d:784f:0:b0:6b9:c869:862c with SMTP id c15-20020a9d784f000000b006b9c869862cmr9871370otm.1.1693143432271;
        Sun, 27 Aug 2023 06:37:12 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id e29-20020a63371d000000b00565eb4fa8d1sm5273627pga.16.2023.08.27.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:37:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf cs-etm: Validate timestamp tracing in per-thread mode
Date:   Sun, 27 Aug 2023 21:35:56 +0800
Message-Id: <20230827133557.112494-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230827133557.112494-1-leo.yan@linaro.org>
References: <20230827133557.112494-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

So far, it's impossible to validate timestamp trace in Arm CoreSight when
the perf is in the per-thread mode.  E.g. for the command:

  perf record -e cs_etm/timestamp/ --per-thread -- ls

The command enables config 'timestamp' for 'cs_etm' event in the
per-thread mode.  In this case, the function cs_etm_validate_config()
directly bails out and skips validation.

Given profiled process can be scheduled on any CPUs in the per-thread
mode, this patch validates timestamp tracing for all CPUs when detect
the CPU map is empty.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b8d6a953fd74..cf9ef9ba800b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -205,8 +205,17 @@ static int cs_etm_validate_config(struct auxtrace_record *itr,
 	for (i = 0; i < cpu__max_cpu().cpu; i++) {
 		struct perf_cpu cpu = { .cpu = i, };
 
-		if (!perf_cpu_map__has(event_cpus, cpu) ||
-		    !perf_cpu_map__has(online_cpus, cpu))
+		/*
+		 * In per-cpu case, do the validation for CPUs to work with.
+		 * In per-thread case, the CPU map is empty.  Since the traced
+		 * program can run on any CPUs in this case, thus don't skip
+		 * validation.
+		 */
+		if (!perf_cpu_map__empty(event_cpus) &&
+		    !perf_cpu_map__has(event_cpus, cpu))
+			continue;
+
+		if (!perf_cpu_map__has(online_cpus, cpu))
 			continue;
 
 		err = cs_etm_validate_context_id(itr, evsel, i);
-- 
2.34.1

