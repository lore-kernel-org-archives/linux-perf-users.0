Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22351C4320A
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 09:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09852613DA
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 09:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhHXJA7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbhHXJA5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 05:00:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE95C061757;
        Tue, 24 Aug 2021 02:00:13 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x16so17755742pfh.2;
        Tue, 24 Aug 2021 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epEB/j6CfBFIWkI0NQJbQR8TgF9ZCPLM1VaX62dtXjE=;
        b=Tio88SDoVKNebqEv7EELHgUiLge67qA0ftH92DcDDAwxdw/BfAh+TQMqJT9lB0bJRU
         Uh9pB1kqPVzHiMFhf/JPm/enwI/t8sgKWJSq1CEnJKyLCerfwF7HAO3di5jeTA4f80lW
         G4Esd9q8C87U1m2W1lVHm301AWB3vnJKmC3C6l1Md5Z02RSFXQr3+tG71IJk+VWbs4LV
         Pn95j0vmASYf5SgeJ/c516z0ycMVSlFWitKXN0NwwQuzMxx98N5cZVorwdAX5GvlRZn8
         fiDf4Xt0xsBIvW+Tay5kpHd2KvvFlG6fucrvJgOoMAbTckUFESR4NyAWPVlTnTMQVy4p
         5/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epEB/j6CfBFIWkI0NQJbQR8TgF9ZCPLM1VaX62dtXjE=;
        b=nW3hEUJ0R+yIXGQEBrTkv/io/dEv/2A9CwpSOjJkjrCZcIs8OeNalKPrWKnDv0PfOM
         1Fzh3p+Io06jdYRNSR8jGwuP/yK9GFIuKxcWww2r+bw8n/cuH9Fw2DTdpyAAAvSydWCy
         UBIwV98kT8ZY5d/W3DjDrDz1DLEA4sAt2Jj3rSddmyS92JKTLfdkLSLYG9BUK67jy4JB
         0PhCQIth4OAS+8JCLeJIV34uvdeq/bI5gNNGnYSPDS7pbfkCGlbETWlG/HojzgjDlq7Q
         bAIK6j8N3/ZjGqhq8jJX2iTig5I5QvMUjZGKEF+d7B3iTck1MmYK7EO1jYCz9umDqaXp
         R4YQ==
X-Gm-Message-State: AOAM532LNGNSoUjmVpkEKDcVaiLIdZBJTTVHJENA27XhXerQ5zVNdR6b
        +EyaADL8lNGwvaCV+kLoz8s=
X-Google-Smtp-Source: ABdhPJxaOAv+8OR3Q4jPnbfeBbBg2NxrcO52QInY04JsS/isxPgECbKutzEPFG4d5C4W3Kz1XaRl2A==
X-Received: by 2002:a05:6a00:189f:b0:3e1:b92d:5ef6 with SMTP id x31-20020a056a00189f00b003e1b92d5ef6mr38299958pfh.81.1629795613163;
        Tue, 24 Aug 2021 02:00:13 -0700 (PDT)
Received: from ubuntu.localdomain ([171.224.180.204])
        by smtp.gmail.com with ESMTPSA id u24sm18943692pfm.85.2021.08.24.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:00:12 -0700 (PDT)
From:   Nghia Le <nghialm78@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     Nghia Le <nghialm78@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: [PATCH] perf tools: Add missing newline at the end of file
Date:   Tue, 24 Aug 2021 15:59:47 +0700
Message-Id: <20210824085947.224062-1-nghialm78@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add missing newline at the end of file parse-sublevel-options.h.
Thus removing relevant warning reported by checkpatch.

Signed-off-by: Nghia Le <nghialm78@gmail.com>
---
 tools/perf/util/parse-sublevel-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-sublevel-options.h b/tools/perf/util/parse-sublevel-options.h
index 9b9efcc2aaad..578b18ef03bb 100644
--- a/tools/perf/util/parse-sublevel-options.h
+++ b/tools/perf/util/parse-sublevel-options.h
@@ -8,4 +8,4 @@ struct sublevel_option {
 
 int perf_parse_sublevel_options(const char *str, struct sublevel_option *opts);
 
-#endif
\ No newline at end of file
+#endif
-- 
2.25.1

