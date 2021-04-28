Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BBC433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 12:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271A060FDB
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 12:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhD1MKO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 08:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhD1MKN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 08:10:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C94DC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 05:09:29 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c17so8967934pfn.6
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 05:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTmK7aCuO+JgVajONYR1FKskSgQ8youTi+N6g89HWRY=;
        b=Hw/INPO6X8ySiT7BfvVMv6SLuxkEF1nRql6QfSSKXUhYZMVdoa2Agd//5oh05ilfUF
         H6VMbWHpashDSpziEHIUrIZ524bT80KMae4CVMXETzktHdn7TQJsMd6iJrl+i0u+AnPY
         rksx6DI8J5Qiwj1tM02joW44Yw9yivEMrjTigUXqCqhm5IGehjdvjl3hVnz25zE9/cyy
         HnpMbl4AN+9EG7THf/ymaLF211+u7VmtzwRaaJdjyNm+uZ3Yz47WYJvlKOzFM1TJLbmD
         GoU3p7qVDKX/zE/vOTEXUssu01FVYj7sRYdkftGiY4zQDoSmWHQEjh/B5K8iX/ZMsHt4
         /Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTmK7aCuO+JgVajONYR1FKskSgQ8youTi+N6g89HWRY=;
        b=nYJ5fb4RdkKQ1leFPHUkCVuKwWoNxnbWX77Lr1WZ7x8qZAotfJ+EB/yWPimGF3N1EO
         LiS9MHOALmTLpr2OzAnH+7EP0uxLbXKDwXlmi09RKn+t+XgyqdTM1y0IXnyJh3podo67
         9dRgZ56KXjDEZKVkddaITdhMIkHcpcljmGSZHc/9X1ymemr3dfuyOEVD0buL0VjnnYrw
         0EYHCi161h4AqiscAELozAlIMQmVZvFDca1x9U22OZ1V3tp2FRlo6c2il++1JxYHS11J
         g/CcIWMP0DPBYej4lKWhjM8BHuQRQfadbOslTw95F6uKRgM7c1wz/j31FQHeoddYD9TD
         Q25A==
X-Gm-Message-State: AOAM533vEy8MXqtbGSxsUfo5WdJ8ibJmj2kjDSUiBsG2V6Eu/Q9F9w6Z
        ZJMNcp1MfEurSTCDXSiTJP3UXg==
X-Google-Smtp-Source: ABdhPJzJhZboTxLbprhBPe052w4HiJpISSLnuIL64nxUZ/5b4az7RjVJoG6V3wh6kA2Ar3uyGplw1Q==
X-Received: by 2002:a05:6a00:1588:b029:272:f5b1:c96c with SMTP id u8-20020a056a001588b0290272f5b1c96cmr20025201pfk.47.1619611768639;
        Wed, 28 Apr 2021 05:09:28 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id g14sm4933388pjh.28.2021.04.28.05.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:09:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/4] perf tool: Change fields type in perf_record_time_conv
Date:   Wed, 28 Apr 2021 20:09:12 +0800
Message-Id: <20210428120915.7123-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428120915.7123-1-leo.yan@linaro.org>
References: <20210428120915.7123-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

C standard claims "An object declared as type _Bool is large enough to
store the values 0 and 1", bool type size can be 1 byte or larger than
1 byte.  Thus it's uncertian for bool type size with different
compilers.

This patch changes the bool type in structure perf_record_time_conv to
__u8 type, and pads extra bytes for 8-byte alignment; this can give
reliable structure size.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/lib/perf/include/perf/event.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index d82054225fcc..48583e441d9b 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -346,8 +346,9 @@ struct perf_record_time_conv {
 	__u64			 time_zero;
 	__u64			 time_cycles;
 	__u64			 time_mask;
-	bool			 cap_user_time_zero;
-	bool			 cap_user_time_short;
+	__u8			 cap_user_time_zero;
+	__u8			 cap_user_time_short;
+	__u8			 reserved[6];	/* For alignment */
 };
 
 struct perf_record_header_feature {
-- 
2.25.1

