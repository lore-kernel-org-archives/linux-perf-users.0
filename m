Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4DFC6FA8B
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 20:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiINUJZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiINUJW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 16:09:22 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDE476D3;
        Wed, 14 Sep 2022 13:09:18 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1225219ee46so44091585fac.2;
        Wed, 14 Sep 2022 13:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QJp/i7zfiD1oGnxN83dfiN9EncGw/ZbjXDcYjXPOeXE=;
        b=E0mcM9CRfqIteL37TcOU5ahq8/YeNQvqLDlYv2plhTMcxe1d3E5EL2T1hFtx2PPmxI
         gcANgwQqmEnc6RrLcW4Er/j8iWm5X6H7LYKPqUwSQ/0O6CXwoa5YV0OO01vo9NkAa2ss
         2bdByMf9ssNM7CGMkhfraa7MsFuYj2iq32AkSCQDRRENg3mxDQFHcKsypzf5mF9XVaM8
         qCwoG9qazIIqa3w7fPwYQyOgVvOQ+Hith6+Kx/9qNAP8RA/C/4BBMo+WaSJS3MGDHExI
         nrzwCntEAdQWMLn5SlauMKMfExN4wxavE4gKi25ufL4ecdN903qB6rRdKRdRRxlJ2klR
         W2pA==
X-Gm-Message-State: ACgBeo1GS7mU1wbv22x4O7c2I40TAlCjZQY+Uw5QyxLjb5KHFJO+MZGl
        nGsq+R5hTHCcQFX0g24dKw==
X-Google-Smtp-Source: AA6agR4Hq97e8EthQOyi91MM8H5uAoBi3NXhD4EMWGV19hdPLzwXlQOObg0EDg2d7HxpKXyyG6W6QQ==
X-Received: by 2002:a05:6870:2395:b0:12b:cdce:c8a2 with SMTP id e21-20020a056870239500b0012bcdcec8a2mr3580210oap.158.1663186156411;
        Wed, 14 Sep 2022 13:09:16 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id r22-20020a544896000000b0033a37114eb0sm6745050oic.19.2022.09.14.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 13:09:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Sep 2022 15:08:35 -0500
Subject: [PATCH v3 2/3] perf tools: Sync perf_event_attr::config3 addition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v3-2-8189fc04dcc6@kernel.org>
References: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
In-Reply-To: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.0-dev
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arm SPEv1.2 adds another 64-bits of event filtering control. As the
existing perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config3' field.

Signed-off-by: Rob Herring <robh@kernel.org>
---
This patch is dependent on the kernel side landing first.

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
b4 0.10.0-dev
