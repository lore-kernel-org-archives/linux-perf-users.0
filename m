Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0120C54EE9
	for <linux-perf-users@archiver.kernel.org>; Sat, 17 Sep 2022 23:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIQXlX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 17 Sep 2022 19:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIQXlX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Sep 2022 19:41:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833E222299
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Sep 2022 16:41:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so536616wrm.2
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Sep 2022 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=oWOIBNUdsLJwcEjs9drp0WNmb5uwCxSvrbqI+0uFx/8=;
        b=k9+Nhx1QrR9eli4d6oTqKdAmHLNvT4OVBM/E8HZpU6tbL5bNhXavmDUJJCDPoQHL7L
         BVERMzWUsIrcbizBV4C73fdqC1VJMhdmnxTf+UNWDPF2ryT0UTJdr88aBwfPgcqNBbQY
         JtvjrmIFbkpBu9VqXKABISAr2qxHtlUGNRrHpjtfnBx9ct/2QHAlLuFsXfYVdbKoVMeC
         dTthqRoU0JzNPVyf0AiRKrdCFJsJWm04I2f5X9mckotXpz44MZqDV407YzQi1ESQ14ye
         pN40Iu5Jlp+D4jx6b/tF00Q/V4CsqQ9tBjkslF7ICcRnpCAbBWg7iHH4k8iJNeHYfHe9
         Njrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oWOIBNUdsLJwcEjs9drp0WNmb5uwCxSvrbqI+0uFx/8=;
        b=1o9Q4FxPB/qd/GYMLzv8BjszFiZ1Icl/uWAZ5I3PScwGH+BaUeeifH8Rv6iJAZ/4qs
         UZQdiAhkW4sZ5k+A+W6Hy7yo2ET4tWtbhOyFbJnPnCFxmgLRLTh6uJwhVvyBCa2FEs+f
         fquvxUD2uwGj2kqkzIovTTW28vaskq/rgnvu83t87OIvNUasO/XwCwRCv2lYojbpr48j
         yNYpJ9ktZY5d9KV5a6UiAYTKoQI6cZUBwXS7wZW+JVTYaNc5oITQGhKchxDMWTtZImA6
         sJJRx0G2tgIQvB43mFkJm6Qq3jaxkRYkJqbUjkS30VUIrIUrvt7IIQn9xthkD5ixKz4D
         l4Xg==
X-Gm-Message-State: ACrzQf00cIb7MpTzjK9hGiS9/dnmfWD67P4Nzw5YElYnqTZd7Td+8oVl
        4O1Em/3lAP5nA86NZHDG8rGODgqDjA==
X-Google-Smtp-Source: AMsMyM7br9R1/xZ9hHBLYSVgZ+MhStTCt1+TWRLq9MFiuHLajuAFkuM7sgu8/u2iiRv6UdkTva6WyQ==
X-Received: by 2002:adf:f00b:0:b0:22a:906d:358d with SMTP id j11-20020adff00b000000b0022a906d358dmr6796521wro.464.1663458079660;
        Sat, 17 Sep 2022 16:41:19 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id n2-20020a1ca402000000b003a5ca627333sm7581851wme.8.2022.09.17.16.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 16:41:19 -0700 (PDT)
Date:   Sun, 18 Sep 2022 00:41:08 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, Elana.Copperman@mobileye.com
Subject: [PATCH 1/2] perf/core: convert snprintf to scnprintf
Message-ID: <YyZbFOmp9bW3B3s6@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Coccinelle reports a warning

WARNING: use scnprintf or sprintf

Adding to that,
there has also been some slow migration from snprintf to scnprintf
The article explains the rationale for this change

https: //lwn.net/Articles/69419/
Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..0b03a98945eb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10933,7 +10933,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
 }
 DEVICE_ATTR_RO(nr_addr_filters);
 
@@ -10944,7 +10944,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->type);
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->type);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -10955,7 +10955,7 @@ perf_event_mux_interval_ms_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->hrtimer_interval_ms);
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->hrtimer_interval_ms);
 }
 
 static DEFINE_MUTEX(mux_interval_mutex);
-- 
2.35.1

