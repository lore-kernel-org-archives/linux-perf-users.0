Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A198C43334
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Jun 2022 04:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350441AbiFDE2w (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Jun 2022 00:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350435AbiFDE2t (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Jun 2022 00:28:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1C35DEB
        for <linux-perf-users@vger.kernel.org>; Fri,  3 Jun 2022 21:28:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h192so1888277pgc.4
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2022 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wc1YiV9uyUA6hUWTfhvQxLsnBAF4WMjPE/wOPDue8vY=;
        b=hlvAt+NKFQ93oLQE+Vc7CC1SciVNNaEIsz4OTmUYSw53+wN/88LcPvewlmeJcjqXYy
         xGnEzwNO8wU1Snp1WP1B9f9NwHHICuzVLy/kMdZy+bHh8L05GvVO01KGtZUYt33hvH+o
         GmMl0wyAXy5iFBMecOREOxexJjO7lDDILDeO7QsHanGXKIeCGZ0kEaftIpt8zpBcw8Ja
         vU5ng6WEB2+UfN05oKcuQ+z7AAMC/U3C4hCbrMyVe83VuLrsQVjIB4se1DubesMRInFm
         DIHSLpHgNLriaJfUci9gLg8jmUAQG+3T+8LohzfTvK0lJT6QAPO9iKsuQnN1p3rirA4+
         g0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wc1YiV9uyUA6hUWTfhvQxLsnBAF4WMjPE/wOPDue8vY=;
        b=ccOenSbUcW08QcwFH8plXQSswuT3jczBWkJaLbPSr96RbzE8dzZRbaCT7NzrLI5Tuk
         4gS885IwVNgCdkNm5gkOH0e4l2P0TW2dPUugdi/y9/1+ahFMhxt7x2sfxKt2xFtXBvd8
         a0B2002M4vqp8zrMu1Af7Y5Z4s4JwrPQwVK5Aws+ZqXwl2BE5d/JDpPMBNpMtzNxBaAu
         kDMaE6QsrIkWPtkrPwfzBfzjI2GOEIjHa8kiAHlLwv+d4dRwaRTI6w+UwL/7rMnkANNr
         j5m2O7bw1OKGrr3xTmlvcZU0gWCSiGSzUb/iKl63Gi2t/Ip8yZ/lrmvnLE+F1QlVVH1L
         5uqw==
X-Gm-Message-State: AOAM530+R6eHBI6zSnGCGPkkBQTJubKiLzhSWJJiXBnWKn3ddaqku3F4
        7cZGGi9JOFRc6cZMRkm1wWIlvg==
X-Google-Smtp-Source: ABdhPJyn3cqkMg0lACTzH2D0FR58K/46kMHeeMtnsgDgo1oVmKvzkM9jv8FNzFKJqNucvHfJJilpVQ==
X-Received: by 2002:a05:6a00:21c8:b0:4c4:4bd:dc17 with SMTP id t8-20020a056a0021c800b004c404bddc17mr13233148pfj.57.1654316927721;
        Fri, 03 Jun 2022 21:28:47 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:28:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>, Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v5 01/17] perf: Add SNOOP_PEER flag to perf mem data struct
Date:   Sat,  4 Jun 2022 12:28:04 +0800
Message-Id: <20220604042820.2270916-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Ali Saidi <alisaidi@amazon.com>

Add a flag to the perf mem data struct to signal that a request caused a
cache-to-cache transfer of a line from a peer of the requestor and
wasn't sourced from a lower cache level.  The line being moved from one
peer cache to another has latency and performance implications. On Arm64
Neoverse systems the data source can indicate a cache-to-cache transfer
but not if the line is dirty or clean, so instead of overloading HITM
define a new flag that indicates this type of transfer.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
---
 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72..7b88bfd097dc 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1310,7 +1310,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
-- 
2.25.1

