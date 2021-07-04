Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245FCC07E9D
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECCE6188B
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbhGDHUJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhGDHUD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jul 2021 03:20:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1726C061764
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Jul 2021 00:17:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p17-20020a17090b0111b02901723ab8d11fso9411162pjz.1
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jul 2021 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkRHt/y85aRyuOITrbWmeb01ZivbHBgtl/nAPj+TUR8=;
        b=VqLcGl8QRMM/MjvqsraNlWRi+4GDw1LQPmsLJDG4wxwq7VIDTaZbX3jxX6j2TiaLHh
         kMaAjr4tCheZ7DMiYNj/TfHTUW3J1uUuynVSoSkDRWXsLxR6HstwKSZeviP5EyYv8lwP
         ZwcpE0hBWWgrDTNzNDPzz8FyBzx5RcM5TXPGShZWL3TEL2kPlaTqYkImabz5LngV/e/n
         h7A/tt4M7neREizVTiLzQ+NpelDKtbGdhfbEgQX6anFZBIr7N2J/QqWOBazToo9pbLXd
         ofrRlOAEsaBCtF7M2tkRwm9UWzphdkUnRqwGH4Pc8qNaeXmo8MRAurDwdKUKjwa1js7r
         mKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkRHt/y85aRyuOITrbWmeb01ZivbHBgtl/nAPj+TUR8=;
        b=swPYvl1Uxjpt+oREW6Y8BHfNVqtlQxrheMUzOCuRqSNpey8JJA92Jb3bmRtbVpAzhf
         koLBoAqkRvWzVsc3KmIz+tVTj5YrFglOaKZ2FbqVGl0+Rv6QRgD0UFN1WxgJEKogSx93
         Asw/uIt2vllazdGTj1ydQtvJouUSWwO+jwc6IzfxbgjRVx0xq6dKXhK5RvZ2JazDx4EN
         80sjT4qB/pPLVpoLsTTeMLmiuzs5pYZWOPwAaDXtlei2RUY9Q7PRC1yHRg8rAwMAZ+zv
         4wvUkjZoeKZe8F6QXUlXOQXQMEUAi3OtHtoaibZy3VmIXXXmixwLRHbow0z8UkbL1xI6
         Idzw==
X-Gm-Message-State: AOAM531sPMzRGxwsvGa3JfAM9za/tJYDlLQETclecFD11A3ek24kcZ6N
        L6dQtGeFBQWLSnUEeoIqnMEvPw==
X-Google-Smtp-Source: ABdhPJxo7pvqsWUeTkUMmxlymc5HCjtuwR5SLuy5pNg+DlTa+bWG1beuCHQp9yxO4juHyAs2G4tu8Q==
X-Received: by 2002:a17:90a:5d92:: with SMTP id t18mr8097252pji.221.1625383048279;
        Sun, 04 Jul 2021 00:17:28 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id e4sm8655505pfa.29.2021.07.04.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:27 -0700 (PDT)
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
Subject: [PATCH v3 07/10] perf: Cleanup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
Date:   Sun,  4 Jul 2021 15:16:41 +0800
Message-Id: <20210704071644.107397-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the __sync functions have been dropped, This patch removes unused
build and checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in perf tool.

Note, there have a test for SYNC_COMPARE_AND_SWAP and the test file is
located in build/feature/test-sync-compare-and-swap.c.  Since there
still has several components using the sync functions, it's deliberately
to not be removed.

  $ cd linux/tools
  $ git grep __sync_val_compare_and_swap | awk '{ printf $1"\n" }'
  build/feature/test-sync-compare-and-swap.c:
  include/asm-generic/atomic-gcc.h:
  testing/selftests/bpf/progs/atomics.c:
  testing/selftests/bpf/progs/atomics.c:
  testing/selftests/bpf/progs/atomics.c:
  testing/selftests/bpf/progs/atomics.c:
  testing/selftests/futex/include/atomic.h:
  testing/selftests/futex/include/futextest.h:

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Makefile.config | 4 ----
 tools/perf/util/auxtrace.c | 5 -----
 2 files changed, 9 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index eb8e487ef90b..4a0d9a6defc7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -349,10 +349,6 @@ CXXFLAGS += $(INC_FLAGS)
 
 LIBPERF_CFLAGS := $(CORE_CFLAGS) $(EXTRA_CFLAGS)
 
-ifeq ($(feature-sync-compare-and-swap), 1)
-  CFLAGS += -DHAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
-endif
-
 ifeq ($(feature-pthread-attr-setaffinity-np), 1)
   CFLAGS += -DHAVE_PTHREAD_ATTR_SETAFFINITY_NP
 endif
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 44bd04dbb6d6..db6255b55c90 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -130,11 +130,6 @@ int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
 		return 0;
 	}
 
-#if BITS_PER_LONG != 64 && !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pr_err("Cannot use AUX area tracing mmaps\n");
-	return -1;
-#endif
-
 	pc->aux_offset = mp->offset;
 	pc->aux_size = mp->len;
 
-- 
2.25.1

