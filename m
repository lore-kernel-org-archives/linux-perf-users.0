Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51ACC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 19:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJDTMy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJDTMv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 15:12:51 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE1B422C2;
        Tue,  4 Oct 2022 12:12:49 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l5so15368931oif.7;
        Tue, 04 Oct 2022 12:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x+TTQCiThW+1E+H+GkWYh6ipAJfPaAuRkbI13+Mwec8=;
        b=sL5cHlwYZvyHX6ti34hT/wdey14+emon0VKhpAb23K+keZxDs9GBiGTshzktcA82Wq
         zrUrukgveTYg6dT++5gDDQnqkaj7N9Hwsetz65U/kU9I0tEKYV7VtTeVV5XPx3FmBN5z
         OE8tnnwKi5i7hdEsSQYP7UU1U1dCFmpuW335H70ctLDqmwmG73be8xGPS8rDRX5vkQbc
         r9XfTgqdaBaUsRgQrpzy4fQBwQiKsO3LC5eZfVgb7L+rHv37aFBHOrvMq76j2U/75mJx
         vsVm4w5FZqrC/+UAcoAF8MyFIXx54elbPNkDpfWLRdAQP6wFMVR5THNH2zHydhwm+tQR
         q+eQ==
X-Gm-Message-State: ACrzQf2ijuRzjI8VgN5O/sQlFBkgEWoCCL7S/n/5EH1S/OLMnkHs6hzf
        nY1afi3/jT8HSSN1anJnCFyFV+vOPw==
X-Google-Smtp-Source: AMsMyM68jZWWdGp4e8zQud7mrQeshhU/Ubr1tRoCvep/UZmxFLyFgAniMBlpwP4yK1b63wgNRd0pyA==
X-Received: by 2002:a05:6808:1892:b0:350:7c49:649f with SMTP id bi18-20020a056808189200b003507c49649fmr567352oib.219.1664910769342;
        Tue, 04 Oct 2022 12:12:49 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id q206-20020acaf2d7000000b003507c386a4asm3296336oih.40.2022.10.04.12.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:12:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 04 Oct 2022 14:12:36 -0500
Subject: [PATCH v4 2/3] perf tools: Sync perf_event_attr::config3 addition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v4-2-83c098e6212e@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
X-Mailer: b4 0.11.0-dev
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arm SPEv1.2 adds another 64-bits of event filtering control. As the
existing perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config3' field.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This patch is dependent on the kernel side landing first.
---
 include/uapi/linux/perf_event.h       | 3 +++
 tools/include/uapi/linux/perf_event.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 03b370062741..b53f9b958235 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -333,6 +333,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
+#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -474,6 +475,8 @@ struct perf_event_attr {
 	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
+
+	__u64	config3; /* extension of config2 */
 };
 
 /*
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 581ed4bdc062..7fad17853310 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -333,6 +333,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
+#define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -474,6 +475,8 @@ struct perf_event_attr {
 	 * truncated accordingly on 32 bit architectures.
 	 */
 	__u64	sig_data;
+
+	__u64	config3; /* extension of config2 */
 };
 
 /*

-- 
b4 0.11.0-dev
