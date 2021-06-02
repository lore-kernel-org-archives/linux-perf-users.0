Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EDFC47092
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18E7613D0
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhFBKci (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhFBKcY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:24 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E981DC06174A
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Jun 2021 03:30:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y15so1794866pfn.13
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jun 2021 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ethqvFDGtJ7pygL6O7+7W1A8KYpMXPVj/v6wIqt0W0=;
        b=P7Nl3qoG2cR/l1a0GaRz5SGODttE3PK1+fLPoFdWJRNZITEUVt9CGmC2MseKhHKWoA
         jv9a2pLhsevTHrxkBo9HVQyYJZJIqvaDnxoNKLdzSMS0Xxp0vB7yjbyi7FHcumGwYDqq
         E8fJtd0VfJWBd+GV+dIrBrNzyW1mFsSM92TWjlLg6Bq6Dyk/lurPws7rPkyXUP1HuaC+
         Ba7LceFajeDe2f5sNRrfvQrWh1AVraF37RZweYZa8OUZ/20a37juKY8w1g2iCtg0lVZv
         kAzAEtC7RYKMuDeB6M7TES+S7xfuxQW35iPn+QFRSa/R5ddK8FXKOzlJ38jxJxUfmcha
         V0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ethqvFDGtJ7pygL6O7+7W1A8KYpMXPVj/v6wIqt0W0=;
        b=Kipdrc73tshtYOyJLeOauH6K3xjbGSjdIBRKl0gTIOv+X0UoTMGG06WGIOcDtcoMCB
         THiYh9bkjTyqfJE+IxA/KrgR8PrkvSwHGGFjXYMhMc4RfpL9gtYkRtMc0qwAaZJ7RvTh
         qkhs2c7K/xYTE0dxMHz+Tfw7Kr2rz/Qzt7l9LakzOukq5d8PMKltl5uDMaWQX+vSVB67
         9Dmq3gc1uDIdVyjhs7loxZ7iwqrJtffs+Qu8FzfNaF+aFMFVZ9iKb6S2QD6R5YpXSxUt
         mF3HH+Edhph3GU2fOM6AzepagpcCzzcYfDeFCis4gsAARH6u4VQq9dlX7vqwfvHLtrcc
         f62A==
X-Gm-Message-State: AOAM5327vvuYGT4hMg/0RbI4b5fiBxoYtHPimbaoNaDW6JrCJPvyVJcC
        idnWheNfxvSmrGJfNL81rJbdCA==
X-Google-Smtp-Source: ABdhPJx0EfBw6QaTO9+VL3wMCj4oJnHgh5bVeyIeRmYvkSdry99ww/+lQjMFdUFcUK7C3Asky0mOxg==
X-Received: by 2002:a63:8f0b:: with SMTP id n11mr32834096pgd.342.1622629840534;
        Wed, 02 Jun 2021 03:30:40 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id g2sm7950812pfv.106.2021.06.02.03.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:40 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 8/8] perf record: Directly bail out for compat case
Date:   Wed,  2 Jun 2021 18:30:07 +0800
Message-Id: <20210602103007.184993-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the 64-bit atomicity is not promised in 32-bit perf, directly
report the error and bail out for this case.

Now only applies on x86_64 and Arm64 platforms.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-record.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3337b5f93336..f47e298281f7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -74,6 +74,7 @@
 #include <linux/zalloc.h>
 #include <linux/bitmap.h>
 #include <sys/time.h>
+#include <sys/utsname.h>
 
 struct switch_output {
 	bool		 enabled;
@@ -848,6 +849,22 @@ static int record__mmap_evlist(struct record *rec,
 				  opts->auxtrace_sample_mode;
 	char msg[512];
 
+#ifndef __LP64__
+	struct utsname uts;
+	int ret;
+
+	ret = uname(&uts);
+	if (ret < 0)
+		return ret;
+
+	if (!strncmp(uts.machine, "x86_64", 6) || !strncmp(uts.machine, "aarch64", 7) ||
+	    !strncmp(uts.machine, "arm64", 5)) {
+		pr_err("Error, 32-bit perf cannot record from a 64-bit kernel.\n"
+		       "Please use a 64-bit version of perf instead.\n");
+		return -ENOTSUP;
+	}
+#endif
+
 	if (opts->affinity != PERF_AFFINITY_SYS)
 		cpu__setup_cpunode_map();
 
-- 
2.25.1

