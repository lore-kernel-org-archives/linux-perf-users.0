Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69427C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 11:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D78C63332
	for <linux-perf-users@archiver.kernel.org>; Tue, 16 Nov 2021 11:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhKPLmi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbhKPLlh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Nov 2021 06:41:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FEEC06120F;
        Tue, 16 Nov 2021 03:37:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso2640750pjb.0;
        Tue, 16 Nov 2021 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1YkV59UUDuaHjxt/1El7vRrZli8yesHvirxeJm8kUfY=;
        b=SUhAh/UqrXAsmszhI7xHQZcaUnqK2mNWfaOcVLbS2AsTCZhY0kvmfUnvW7MVtakrWs
         EUg4rpiSRzYTMXcSMm2SUBX+VAHWPVu3qSf8sGMKN+qUuchzdLIAJR7OginiyWMdDm6w
         G0BTPFdLmesv2Q8qVHBhPh08sth/MgLSHJzf9agbmefULJr1ctjbVuYWtibhrJsm/BgG
         97wGjRNdnARtjQ4ZIraX69LzupqtrxabjkPppfG33q5Xt6fiEIMMkzh4szCntow17Uex
         wAoXpgRxtj5Eylgd044FzXF+kBwgzw3dMYZLJpzR9xfWiGoUkzCyL3fxRKD+1vCtOZHe
         tWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1YkV59UUDuaHjxt/1El7vRrZli8yesHvirxeJm8kUfY=;
        b=Ew4mNzIit00SJ061Lo4NP+haBcLFhvoF5wdzlSvIdcV8YvBMbJx18JFmba5ojQX82O
         SC+RGgtgY22K69RNRJNz/mcIs4EgiIlrZAEY4avSdpHC5aYcPmVG+5p073Ih2e6YORqD
         LiAxC3d5RrAbKHA3D1QQ1wtXtllKiByoqUvt7lL6ado+lYGG1CtYbdW7J/4s9hxjRmXJ
         vOHVuPsvOdgyT3fV9Fr7aQzdI//AqAKYptHeFKXiIFolwYNHcXKJ47by5x8RYZr/nqmt
         AY7K0y6/Eav4Q8WN2Zc1SHKJLI/Hq/SCkyB+OHSaIoft5e4aw2th1mVT7LGlwoyHLh/z
         j3HQ==
X-Gm-Message-State: AOAM531WiqhX6rWpVwsRZY5+X7z0BtX/v0JUxDOxU4oF2g4wP6QjJO00
        WurD+UpbePQTc/9b7HtVrVo=
X-Google-Smtp-Source: ABdhPJyNbNWxjZ1rGxCKGL7DETShGe0vZaEhJ0qTJ11ZfJ5vXM9qB0HpSgW1IyFnaogtSABdUYAoNg==
X-Received: by 2002:a17:902:e546:b0:141:f4f7:7460 with SMTP id n6-20020a170902e54600b00141f4f77460mr44777686plf.17.1637062670458;
        Tue, 16 Nov 2021 03:37:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w17sm14874358pfu.58.2021.11.16.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:37:50 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mingo@redhat.com
Cc:     acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] perf/x86/intel: replace scnprintf in show functions with sysfs_emit
Date:   Tue, 16 Nov 2021 11:37:39 +0000
Message-Id: <20211116113739.156706-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 arch/x86/events/intel/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4d679b2d6024..ad87a48bfb41 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5115,7 +5115,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+	return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);
 }
 
 static ssize_t set_sysctl_tfa(struct device *cdev,
@@ -5149,7 +5149,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -5165,7 +5165,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return sysfs_emit(buf, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
-- 
2.25.1

