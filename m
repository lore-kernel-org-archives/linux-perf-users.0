Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE8C07E9C
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66996124B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhGKKoe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbhGKKod (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF0CC0613DD
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p4so3244255plo.11
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8WBHdMiNLmIcoS32XEem64SidgwwayFr5+ViHTdRenk=;
        b=EIaNg9j2rZ8VjBp2Ru1d3pbSkzhH1TZGwMBQfIAMo9StPWmImfULZiZbCEhoWb80D6
         XOmzRSfywoys3eaekT+MNj07FnSbXjLmmR+V4CDh3S+xj3o4EupJ9UczuEBvfnd7YRde
         C7FZRp0gPB/eZP5ESKYFs99ZO7tLuYCoVo5mHJJDHYpS1VOjOBu5GucU0deXi/4U+Get
         FxjvDcGB16CkxYN1fOQS7M9bh0zYZ5K6IpDa3npaZI3HVhNIGq2dVIUKujKcwqKJ+Edv
         vFJ620Ba68Mpo5Lp2x9xkmUh2VQ/LtGD5W9KcTVpZrS3FI8Fh9EM0aryln9sT8/fWGc+
         QhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8WBHdMiNLmIcoS32XEem64SidgwwayFr5+ViHTdRenk=;
        b=U5ZRgeLHpVTSFjWMRO6ueEf7o33Pxop0E3U9nkKd4dJ7staFJZDix8LhfGwTFrdbh+
         v3QBRSpI/qlgON4RljrTzixwGprRcC8eTiblJepwjb1nzQTPhAivMHPR2N/vcFQNWKw9
         SVLl6nJiw/11u+r14zoEMJFoM6wRSB01h/LLEMaVWFGpP/27TvAqB5br5TzANKbWR9Jf
         GktVO1NUvRlQP3ptNVVtabupmLHgSAKuAB0YKNHDyfoXqNLS2qbpQFtyOlAhmSccuKef
         2RDfyPyMXd2D84fhFQ1TrQrSNgdHKAt5XHSufZ5FTVxnQPXvwCfXqh0hPClgWhZkcRp9
         /nBQ==
X-Gm-Message-State: AOAM530WneBViSWJxRAHHx6Myb/X6nA+5QfpLAT46ONHHfvNGxEYS0lz
        P+wA9naglgadSNVdmYY5lAIhsQ==
X-Google-Smtp-Source: ABdhPJx0+4d0Te0gQRwFPbMZtMfjEw0kaMwmkcHx5kjHd/IOrs6YQeaGRm41Sxs2ZCcCMa4F7kj8ow==
X-Received: by 2002:a17:90b:4a90:: with SMTP id lp16mr47619927pjb.137.1626000105798;
        Sun, 11 Jul 2021 03:41:45 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id 3sm4169592pfm.25.2021.07.11.03.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
Date:   Sun, 11 Jul 2021 18:41:04 +0800
Message-Id: <20210711104105.505728-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It's useful to know that the kernel is running in 32-bit or 64-bit
mode.  E.g. We can decide if perf tool is running in compat mode
from this info.

This patch adds a global variable "kernel_is_64_bit", it's initialized
when a session setups environment, its value is decided by checking the
architecture string.

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

