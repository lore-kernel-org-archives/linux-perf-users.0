Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C6BC64EC7
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjB1InN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjB1Ims (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:48 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FC2BECA
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:32 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p20so8411482plw.13
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCXvY3VOyromxWZSsh4iONVhiGPWxZ3OU8P5j9wqMDM=;
        b=mHa3wZ4GywafX9hnclLu9nn5NSKcgATH5FrysR3DIX0jEA8FhX8B2sADMTrve843Ad
         k8EMMHyMHGDBv7O3yhebbdoecjhSu6Zt9wBWuRRJsF8uKDCx5xFXwlH2N1t6tLpfMP2Z
         RvSYgr+m8PWRjzTBOF8ymbLHCbnrwyLzziNl/X4z1KLd2WvhvC0UEbQzOnZSZ7VFVyMC
         kD7k6G8Be4mi8pe5qgH1mNgZEzpKpgtUZtCfmrszQqTEH4Zz4PuqVEL8QkaHMG418wmh
         3JUVbtBmA6PLZhWlRKrAagZcaeGzdxyPlxayIrsyzj2Y6fURu9WTcREIrGV5PB80v6UL
         AXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCXvY3VOyromxWZSsh4iONVhiGPWxZ3OU8P5j9wqMDM=;
        b=iReBRDUVJ5a2MuBo1yf+rmtH11FYQhuqZEeh4lesEntFYGscxN2QS2H181+Payo24h
         9dvz+6TXApWpCqjUFR1xAxulc7WHq4Y68ws7Ga4gukYKvuH8s3L05z6aUpyOBkfRPvhc
         xRF4flJbPBjTdd4j2TiSccCozcWwof9ZDIq4nL2oWXPzhR0aEgJ42xlGFyoM1F96mRf6
         ZGtVzotZQECYhOvm/SODi4WWYxZ4I1sp6OO1rX57kWnMAuLZ49D3sUil4pG+ZP58S/Uf
         7Bv6rJfrBPCGoWbD/fU1n+qjTGjjmX6huWoaT3xSpka+ENF8l42g5oeDhgPp1XXrZUcJ
         ggGQ==
X-Gm-Message-State: AO0yUKUozgEFseaGzuipAYQxtYVpXaob54PU/PI5M6C0WkJxQL3Lua/i
        l+c0qhE67JTq17TlGNBmv/pW/Q==
X-Google-Smtp-Source: AK7set9bL9mt87w1xeJDL0pksFC1N7K+o8xP6omLFrYoHQY1VugzdXJ2ybddTxs/ZQzEluFuTRIjdA==
X-Received: by 2002:a05:6a20:3d8c:b0:cc:f39:5094 with SMTP id s12-20020a056a203d8c00b000cc0f395094mr3032509pzi.30.1677573752594;
        Tue, 28 Feb 2023 00:42:32 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:32 -0800 (PST)
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
Subject: [PATCH v2 07/14] perf kvm: Parse address location for samples
Date:   Tue, 28 Feb 2023 16:41:40 +0800
Message-Id: <20230228084147.106167-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Parse address location for samples and save it into the structure
'perf_kvm_stat', it is to be used by histograms entry.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c   | 5 +++++
 tools/perf/util/kvm-stat.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 779881901a05..a9f467926bdd 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -704,6 +704,11 @@ static int process_sample_event(struct perf_tool *tool,
 	if (skip_sample(kvm, sample))
 		return 0;
 
+	if (machine__resolve(machine, &kvm->al, sample) < 0) {
+		pr_warning("Fail to resolve address location, skip sample.\n");
+		return 0;
+	}
+
 	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
 	if (thread == NULL) {
 		pr_debug("problem processing %d event, skipping it.\n",
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index a3219829c448..80d5c5a9ae31 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -7,6 +7,7 @@
 #include "tool.h"
 #include "sort.h"
 #include "stat.h"
+#include "symbol.h"
 #include "record.h"
 
 struct evsel;
@@ -86,6 +87,9 @@ struct perf_kvm_stat {
 	const char *sort_key;
 	int trace_vcpu;
 
+	/* Used when process events */
+	struct addr_location al;
+
 	struct exit_reasons_table *exit_reasons;
 	const char *exit_reasons_isa;
 
-- 
2.34.1

