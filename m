Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B413C12002
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1C2613D0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhGOBg6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbhGOBg5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A3C061762
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s83-20020a2545560000b029055ae952c336so5429509yba.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jul 2021 18:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GIjWo0gzOMptvkl7/douQ77SF5UMK5TcXXj5psLQmwQ=;
        b=YfYatFr1PgmuDlSqCxGHNS7KP86q5AQ6O4VjwKg1ku2Vjnrx9PUEOSlRRlTDNnYjGT
         lkbu9PGbmIVZq1MgvMPNwcDSFCVd1HpW9yaO8T0clDTLLJCPJXAaIbmsukYaTnsS1GzM
         UjCe2BhfEZS0KXWUQbDl9ScElnh0XxjZVJ6ien4zR6T7v7c2kEBVIwtnMs/PDoITSF+o
         45UuJoywYuvd/vTFUSxanL8U3Cwu5xTP0IP26bw5cRRaEO95UpstaXs9gMjgrxET0Vu0
         1mLanC+CvRqHfLa0jZrN/LCz3hUqqg29hLXwVLmoWjjm/E/sQp1YgmIgLGzepfK/5oc/
         0g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GIjWo0gzOMptvkl7/douQ77SF5UMK5TcXXj5psLQmwQ=;
        b=TUckSaZJKrc71zpWgcZSjUdL2Ons8VRiVY5ZiP8G0NRNRF8gQosW0S0JU5s9xk/sAn
         3AEBFJaZ+YJpTBWzWGjuFwzqQNgGQnSoXIMrlyfcDcFe1bCMCHpSQ/wIRSZ8eAd5fmL3
         ylql27iIllUxwRTTCmv9X9V7hPYkZItfmNfinr5U9zwH0aCE1R7yFwBJY8unM22IkPIw
         2FVN7+8Dczd1r+BemUIQfqx44Swqg4bXQ1DW38HeFx+sE5xNrQJuyQbjKOaDe0UmFHNC
         tXRF7rxAv678Pf+tPpIAwaLDCs6jVVvKd2dByAxu4n/R4mOGSd5ffA2e7/DTriFVRN3r
         8LfQ==
X-Gm-Message-State: AOAM5320rv9iU21SvEwrFUpPZmfM5vC/fpCkf3mQio22ia0jQRf2J9z2
        FNLJr6FqsDZp7lUN9wY30ARDBoLfELHB
X-Google-Smtp-Source: ABdhPJwm9dD9egCtGYZHwFPyFZ1Trxro9AjycOBuUEmkfseiRuUNBjrVu3FodNRFeytyKV0I6AM/71SGvDDP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a25:ed01:: with SMTP id
 k1mr1315360ybh.74.1626312843141; Wed, 14 Jul 2021 18:34:03 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:40 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-5-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 4/7] perf doc: Add info pages to all target.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Enabled to ensure that info pages build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 03300c151858..85a796c112a2 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -173,7 +173,7 @@ ifneq ($(V),1)
 endif
 endif
 
-all: html man
+all: html man info
 
 html: $(DOC_HTML)
 
-- 
2.32.0.402.g57bb445576-goog

