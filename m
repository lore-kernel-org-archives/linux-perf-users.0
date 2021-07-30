Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCEBC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE1B160EBB
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 15:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhG3PiL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 11:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhG3PfA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jul 2021 11:35:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D662C06179C;
        Fri, 30 Jul 2021 08:34:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u15-20020a05600c19cfb02902501bdb23cdso9479874wmq.0;
        Fri, 30 Jul 2021 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xCOtqv2tenj2Od+wPZTYC3Z57feU6O1gHbiYEDCzbQ=;
        b=qOKc9BC5zP9dReUvB1bsK31L8KyUvJjYxbUiI091CFdY04bok0qSF1ldvLDq2qqbVd
         fNq4+twMD+q5LkBapkPEzH0EVmFZV9bnmvAcsvx1W6ST70TO9gRNOoyg+ucqrVJs7AOG
         8fXj9JhGdg+x6iwbw5mXgBkhL4qonNUDQcpHSTJe9cejlb+JAqKSz0TP2gkqleadpLjS
         LWsti7Z39gbpc+BeAC2zMmZFfJT3yOeKnsDyVQLALg5bdTPh+NUwWHBwl1LRDC2uQtD3
         fJDNX8u7W07vZ9TwVI4Cet//Z+Cmo1atGY1dlU8FxoqjFx2hviJCHlzTTXV/cavudjYf
         iYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xCOtqv2tenj2Od+wPZTYC3Z57feU6O1gHbiYEDCzbQ=;
        b=uUjZG66e8EzQMonJQNSPcxNQI+DJlcV96jqeskKspfgD0/ofg4lBzm/sZIJ485qukV
         zx/giDiJxrDM+BelqHw3WeIViLa3EKcjyvpoKfmE59DVsYq8deIz0XMIjIrtuv9ovxin
         R2/2E33IxIork8OZM3RZXW9oy0VKkfL7UOGooT3dufPes66Rv11HXFzp5itI4KNurZzp
         3g+OPurTddzb0/toAU71ibuXBxKAB8icGF25LH5Bj2MjHLFp5Mws6Ja52qOOTDLVlCbN
         RuiZDbQOX3lilQG7RzhTJP58Vcy900RB1yOCstnKrhM0ZFJYl7ZFlp9cyAKVhow2A6y4
         c+NA==
X-Gm-Message-State: AOAM5308FsJHDBkUPLkL15tmNsvIw6O/paBkvOvS7qit1Or6zO3Z27X4
        XWKLmluzoTkzd2VJjYmy69I=
X-Google-Smtp-Source: ABdhPJzaOREdJM7hcxUJXn/q/cw81/xSY/9GnvYcQMbVxb5bCbSTugrUprOAfM+uPOgdbfiJtTBW0A==
X-Received: by 2002:a7b:c3ce:: with SMTP id t14mr2921100wmj.50.1627659266938;
        Fri, 30 Jul 2021 08:34:26 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id v15sm2354727wmj.39.2021.07.30.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:34:26 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v2 05/10] tools: add sparse context/locking annotations in compiler-types.h
Date:   Fri, 30 Jul 2021 17:34:12 +0200
Message-Id: <58b2f161ce856ec8b499f4dcf60a10adc84651e0.1627657061.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627657061.git.rickyman7@gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch copies sparse context/locking annotations from
include/compiler-types.h to tools/include/compiler-types.h.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/include/linux/compiler_types.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index feea09029f610120..24ae3054f304f274 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -13,6 +13,24 @@
 #define __has_builtin(x) (0)
 #endif
 
+#ifdef __CHECKER__
+/* context/locking */
+# define __must_hold(x)	__attribute__((context(x,1,1)))
+# define __acquires(x)	__attribute__((context(x,0,1)))
+# define __releases(x)	__attribute__((context(x,1,0)))
+# define __acquire(x)	__context__(x,1)
+# define __release(x)	__context__(x,-1)
+# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
+#else /* __CHECKER__ */
+/* context/locking */
+# define __must_hold(x)
+# define __acquires(x)
+# define __releases(x)
+# define __acquire(x)	(void)0
+# define __release(x)	(void)0
+# define __cond_lock(x,c) (c)
+#endif /* __CHECKER__ */
+
 /* Compiler specific macros. */
 #ifdef __GNUC__
 #include <linux/compiler-gcc.h>
-- 
2.31.1

