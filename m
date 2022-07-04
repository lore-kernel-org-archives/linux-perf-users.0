Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD770C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Jul 2022 08:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiGDIMe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiGDIME (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Jul 2022 04:12:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DDCB483
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Jul 2022 01:12:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so7441736wmp.3
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Jul 2022 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=plqraaSJUkeNCDGA4aEvfb+pg8+kvKD5XTON2+h9YBA=;
        b=oz12zjWXxiKYvIUnwdtU+1cpeW4xquYSJyHG0bWhwcfdSFfsDSCYoHXHy/Qjx4VSYr
         e1HSsp3iLxlQcFkWH7+LF6cQbnVq5OXaY7LHK9Mq38WxdbjljKhOlshcZ6D/njgfaBox
         VtT22S1fk56slCsu6XCkh7X/9D9SlseAHIoDINGoJOciVy/zHWho1/3Umceqv+m9+cbk
         /eM90nNK03YRXH/JNdhcjJk2uLPehskE5wZOhv6SupGyyTV8xvlrWPAB5CmdUxEzjixm
         mqNPj5LFBraN09ulIJ3q4MHOhjzJEpCPpwFcl+QkltjicBJfpsn0PAwBlX4n2BRsQNPT
         rQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=plqraaSJUkeNCDGA4aEvfb+pg8+kvKD5XTON2+h9YBA=;
        b=RY49ZriQOt0v972/oYmj1eTHalZ6xVUN4jW33O4mlK/b4uuXPc1sZMwRm+WIHGpYGj
         gzwgkoM3WDeqBwqB/i3FuH2Coi+iQd3GafurgSES8ZuINHVG2/6h4JXjAog34JRhBG7e
         5lE05j26fho4NJIaC2e/FB5itkRSJviSpwqP/3WZf47yi2WED+eK61qV0DCpzHVEcxxk
         oEHSrbM91QxSGlfx9p23SaSBraYR2Sm51NEsBEMTDeDiFdbof0O6JchXBkD5XXinojzT
         NMrJ6KHRyHhbtg5d5YTU9aTvC3XZu7SkSaH+DGKrtckfDtn89YFgUTey9JVau5/v/uPh
         IhFQ==
X-Gm-Message-State: AJIora/q+wZ9hExb5bmOsgC/2g9RIXiubvP11DloOEHHZ/Np2iQvKYHE
        yF5xI6wEMHeRW74Mndp/gmCFKoCHV465eg==
X-Google-Smtp-Source: AGRyM1vcBm9hrS+Gdaug34C9Dljbs673NhCTJGPPhK8Fnlnl/szz96TTGBkFZVXyU/g5yAKaKRYb6g==
X-Received: by 2002:a05:600c:a08:b0:3a1:9319:ab78 with SMTP id z8-20020a05600c0a0800b003a19319ab78mr13105975wmp.158.1656922321341;
        Mon, 04 Jul 2022 01:12:01 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:12:00 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 10/13] kernel: events: Export perf_report_aux_output_id()
Date:   Mon,  4 Jul 2022 09:11:46 +0100
Message-Id: <20220704081149.16797-11-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

CoreSight trace being updated to use the perf_report_aux_output_id()
in a similar way to intel-pt.

This function in needs export visibility to allow it to be called from
kernel loadable modules, which CoreSight may configured to be built as.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..f5835e5833cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9117,6 +9117,7 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 
 	perf_output_end(&handle);
 }
+EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 
 static int
 __perf_event_account_interrupt(struct perf_event *event, int throttle)
-- 
2.17.1

