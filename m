Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6BCC07E95
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DAD617C9
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGDHUK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhGDHUK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jul 2021 03:20:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E4C061762
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Jul 2021 00:17:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a14so8156863pls.4
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jul 2021 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=brLMJrOwQbG83P71X9VPeuY9tvE7zleojiqdMG48VEY=;
        b=dAw3luOtdje26JAgPM3asmsdnTkplFoo7KvC7H2I/C61UvF35Nzg2HweTqvr7niy3w
         ys2DktQwpbPTEFPl0Gr/LGVnnmdjqAiSgtMTBegUSKLAKijAFCJfajwQv+Cd5RGAzHmG
         2ZW/bq9w3dRLhP013Ef9EVJCV6lTlgAqzoLTcD3ESWEF+uKS4NoXNviD/aH9X6UWQgP4
         lKlBL6ss0GmwsSwpyv9rWMl+w6krPT1lD+UF+xJGHDeWJoTZ1dDm97Y8zYPIZ48dL6lL
         I1eIWQPqDSjVmyb1U+uhUS9Ut5csTpmxVqHZDKDqkYDlt9PLsEW4HsM6wfuSYs0J9fbw
         IQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=brLMJrOwQbG83P71X9VPeuY9tvE7zleojiqdMG48VEY=;
        b=TGyYmFphVJqP1aeKNypOUNGti5vRnsPLZ7/nnbScVQ56k2vmshV1bJAntvZkLiuDkL
         H7D3nM3YjZTx5jiDGYhfNx18rh8ZtcWrDwodEg61jCn5MPWqrsv0VX0Pa7hX0Pnwju70
         9Yh0QNg5DoE5Q4WuQXHXJFMW9CEdperdDIBc/rm6XgXt5TVBN+nq/44q7UBFmasxy2s7
         SxN5Ne/8y4PnOEtERSUFf3E3q2q1ST7G9bIep0i6LQuZo7pW3NKW4deYhBhS5uGUYrxw
         Mf2LYMT6RjOHVGxXUgwbGYpdV9rtj4D4xlcdZwgV3bAwiStF5H7d8LqCQDy1plnPtcm8
         zJPw==
X-Gm-Message-State: AOAM533GTBCDsumuIZ/+qxV0CSnVzrM+w8HSWz5NCnUiDgihmiv9NK5c
        k+bM8XnhPf7p/kGRBhHblFRW8w==
X-Google-Smtp-Source: ABdhPJzEIeBGPpbSgBBcebonFiiSAj58V7y8TRazuYUDjwzJmrKKnWu6NqjrWvwDYuhHUmwXg3kOVg==
X-Received: by 2002:a17:902:9006:b029:107:394a:387 with SMTP id a6-20020a1709029006b0290107394a0387mr7069924plp.35.1625383053898;
        Sun, 04 Jul 2021 00:17:33 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id s43sm983678pfw.50.2021.07.04.00.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 09/10] perf env: Set kernel bit mode
Date:   Sun,  4 Jul 2021 15:16:43 +0800
Message-Id: <20210704071644.107397-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It's useful to know that the kernel is running in 32-bit or 64-bit
mode.  E.g. We can decide perf tool is running in compat mode when
detects kernel is running in 64-bit mode and the tool is in 32-bit
mode with the compiler macro BITS_PER_LONG is 32.

This patch adds a global variable "kernel_is_64_bit", during the
environment initialization for the session, the kernel running mode
is decided by checking the architecture string.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/env.c | 17 ++++++++++++++++-
 tools/perf/util/env.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ebc5e9ad35db..345635a2e842 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -11,6 +11,7 @@
 #include <stdlib.h>
 #include <string.h>
 
+int kernel_is_64_bit;
 struct perf_env perf_env;
 
 #ifdef HAVE_LIBBPF_SUPPORT
@@ -172,6 +173,19 @@ static void perf_env__purge_bpf(struct perf_env *env __maybe_unused)
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
+static void perf_env__init_kernel_mode(struct perf_env *env)
+{
+	const char *arch = perf_env__raw_arch(env);
+
+	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
+	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
+	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
+	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
+		kernel_is_64_bit = 1;
+	else
+		kernel_is_64_bit = 0;
+}
+
 void perf_env__exit(struct perf_env *env)
 {
 	int i;
@@ -217,13 +231,14 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->hybrid_cpc_nodes);
 }
 
-void perf_env__init(struct perf_env *env __maybe_unused)
+void perf_env__init(struct perf_env *env)
 {
 #ifdef HAVE_LIBBPF_SUPPORT
 	env->bpf_progs.infos = RB_ROOT;
 	env->bpf_progs.btfs = RB_ROOT;
 	init_rwsem(&env->bpf_progs.lock);
 #endif
+	perf_env__init_kernel_mode(env);
 }
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 6824a7423a2d..cc989ff49740 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -139,6 +139,7 @@ enum perf_compress_type {
 struct bpf_prog_info_node;
 struct btf_node;
 
+extern int kernel_is_64_bit;
 extern struct perf_env perf_env;
 
 void perf_env__exit(struct perf_env *env);
-- 
2.25.1

