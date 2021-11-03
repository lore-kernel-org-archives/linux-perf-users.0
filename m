Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392AC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 08:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AEE61184
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Nov 2021 08:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhKCI1A (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 04:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhKCI1A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Nov 2021 04:27:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3014CC061714;
        Wed,  3 Nov 2021 01:24:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y4so1576710pfa.5;
        Wed, 03 Nov 2021 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9NIKEDHqLCRhU12tMy0QZPx9nT1tD6ckOt8ztpTIROk=;
        b=jV8MnVySVhW/cJONKXCarehnv9b3NpegTgTsbbUBIlm0Di3ouklO0uxonaUD8F3AzO
         jza//rMwYPAkveezpcqWPB5FRJgvLwD8nPrNd8T/9zfkRjrfkJWhKEyNTH4h9Wv91xgX
         pcYjCtnhgxY4PrfBj+n8EuaoIM0YcaJKhvBArjXObSIfaGkJRamBF4MwP+AoIFvkPybv
         sTvHsYTXiVi4YpdF1eJ1RCR/6uv+LtOt6qqUrlpHeccQkikvW2xukSoeEFWaHFzVXcbB
         rV4nb5x8kvahFbb49rJQRFxj4evwEOzAxdlTLp7kWp52eFOFpQQuEe2dlZnM0+oQFCm8
         QWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9NIKEDHqLCRhU12tMy0QZPx9nT1tD6ckOt8ztpTIROk=;
        b=3HvQ+pzlHWZf96zgXlqqSJA9TRB3aP/ssvie8JGYN/hThPyQgQopOATDJyCZoDm83Z
         Wm2u9jr6wRkC6C0IA5paMMglHRXXylX/urr3TuSmWxudJgKZQjzF9JjP6Rbhfx55vJgr
         kJFBf7Ux2/D8tDFAlLyU0knquFZhGsFRkBZVo6AfKLICvuj7Vnss9ec1AhvKlUYA4wz/
         PSCVF73oaPfk934gO6jiJ0pBN7P0Qme97piEAtwisGvB3sqa2m9F60vhfcR9OqwSlhWf
         PY7A1L3q2vpnIsrjGzjHL2jrtjcidzjZGMRnzhDwX9UHZWIDnQjT0iaxQNrXVjJkKGND
         hmMw==
X-Gm-Message-State: AOAM531J79+g4YlPxh4KSh97qPDL0esZdRGY7/EBNW0yhNbd83/BmH4E
        kedg/uns3sLlmrW2OoEFuI4=
X-Google-Smtp-Source: ABdhPJwYSOnyPnCnKQlaMLKH3NA4QjvNt0/tyU103JR+DF1EFGbckBw5EvTrMXA5IvXOxhRyJJx+uQ==
X-Received: by 2002:a05:6a00:b50:b0:48c:2d75:2ec1 with SMTP id p16-20020a056a000b5000b0048c2d752ec1mr5786440pfo.66.1635927863763;
        Wed, 03 Nov 2021 01:24:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e8sm1556614pfv.183.2021.11.03.01.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 01:24:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Yao <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] kernel: events: replace snprintf in show functions with sysfs_emit
Date:   Wed,  3 Nov 2021 08:24:18 +0000
Message-Id: <20211103082418.27657-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf make more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f2253ea729a2..15419ced2a51 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10921,7 +10921,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
+	return sysfs_emit(page, "%d\n", pmu->nr_addr_filters);
 }
 DEVICE_ATTR_RO(nr_addr_filters);
 
@@ -10932,7 +10932,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->type);
+	return sysfs_emit(page, "%d\n", pmu->type);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -10943,7 +10943,7 @@ perf_event_mux_interval_ms_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->hrtimer_interval_ms);
+	return sysfs_emit(page, "%d\n", pmu->hrtimer_interval_ms);
 }
 
 static DEFINE_MUTEX(mux_interval_mutex);
-- 
2.25.1

