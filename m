Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7067C25B4E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Jan 2023 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjATPiC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjATPiB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Jan 2023 10:38:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C2FDA104
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 07:37:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n7so5200993wrx.5
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jan 2023 07:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cftWnAmLp1SAzK+LEC+VkfIJXP3yn4XV5OF+VxxmSEI=;
        b=kehQTJmy06GF73Jk4gupKe+iWEBSAOLIlh+im1CqYyRHgwYZcbshJUPBfo72NL2LAd
         SLtSL0YWsl7BzjCrReChO3QJdVuU+6VCQP2yXD+UC2XIgu4L2cfaSb00D4h26H7FjZ1R
         ShBO5E9s4ISWQZzZYOx93qA1eVZPYMQTfLrMk3WozQqhIO0ZwTZiBsKePs9hL6qWo5LD
         WsaOhLeRTc2YqX6diZLb59zkH3S+py+QjDuizqXsGKvCv9cFAQyf1l9tQMJmlHCtTzNu
         ienzRpqA5wUeZ/1B2roxwgRvvX8PZrY/fWWZ01bC4YdTC9stVMa7pZ+uZhVPAnc15d8j
         J95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cftWnAmLp1SAzK+LEC+VkfIJXP3yn4XV5OF+VxxmSEI=;
        b=ok1CGTkAnzAHE/4r5DZvs89Fbmc9phb3S8d22OpNT6H2YNawTrEW/NAYFN5b/GZaWD
         d41hmlPoBjINPe8oSDfjOC21A64M/GCXeVRECoHDXoub+ro3raxgf0djXBpTOOLZlO2/
         G9oJMZsRPP89QXCQmc2KN33i3EwfoX/CMd3K0XvJddDSz2/cHfqWk6wq0Trt48jub2u2
         gDCOH4LJkTySgQfbPHzEEsXD0qLpvIZcka7dswN2nJFBFwy9QZr/bhXZUa0ZoM7dZUiF
         xGWBrES58/3bXERE9IAJ8yHZaLUqw9zg4CqIDCICt1vOtbkM9yF2lPbL4/PlXsjgl1dp
         o0Uw==
X-Gm-Message-State: AFqh2kor/HX0yYg/Va9LARBa9aPpQ1NOi25hpUeak9CLCgAksWIM4GHT
        8SiqU/syyRA+IUGvTwaUI5oqKNWLNTfnSQbq
X-Google-Smtp-Source: AMrXdXt5CVI6en+fALH4TA94NWNVBKOXDQkJFNKnLrn1CAOecTTxtMpPgS5gk3DiOQ5A4gVDQE6s4Q==
X-Received: by 2002:adf:a485:0:b0:2bf:81eb:dc26 with SMTP id g5-20020adfa485000000b002bf81ebdc26mr1311316wrb.37.1674229029690;
        Fri, 20 Jan 2023 07:37:09 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:a9b1:8068:4297:73be])
        by smtp.gmail.com with ESMTPSA id b16-20020adff910000000b002bdf8dd6a8bsm14212460wrr.80.2023.01.20.07.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:37:08 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-perf-users@vger.kernel.org
Cc:     acme@kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] perf: cs-etm: Update decoder code for OpenCSD version 1.4
Date:   Fri, 20 Jan 2023 15:37:06 +0000
Message-Id: <20230120153706.20388-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

OpenCSD version 1.4 is released with support for FEAT_ITE.
This adds a new packet type, with associated output element ID in
the packet type enum - OCSD_GEN_TRC_ELEM_INSTRUMENTATION.

As we just ignore this packet in perf, add to the switch statement
to avoid the "enum not handled in switch error", but conditionally
so as not to break the perf build for older OpenCSD installations.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index fa3aa9c0fb2e..48e7121880a9 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -604,6 +604,9 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_CUSTOM:
 	case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
 	case OCSD_GEN_TRC_ELEM_MEMTRANS:
+#if (OCSD_VER_NUM >= 0x010400)
+	case OCSD_GEN_TRC_ELEM_INSTRUMENTATION:
+#endif
 	default:
 		break;
 	}
-- 
2.17.1

