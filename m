Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED22C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 11:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA51260296
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Nov 2021 11:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhKDLyA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 07:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDLyA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Nov 2021 07:54:00 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648B7C061714;
        Thu,  4 Nov 2021 04:51:22 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h14so3797621qtb.3;
        Thu, 04 Nov 2021 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTZizCF4mBzhoH1k9EfuDvzGzYpsqOCj8H44w+5svOs=;
        b=Jp2HDF8/rednlErqLr1ha/jD2dq+q3UTPtT/PC2s35D2KUFGMj3xBgIm6lcv3DiN5m
         3Hekd8JP32s1Mtp/bfjPVAfeu+HA5gkyxfpgVajnbLXMMMChsHMGAsUPO1HipLPxJnZv
         grPqlzmJzn+4qglHiYj8+6EcQmR/YoSBb/NGbwjmo0i5YFV+LBRZmnQ2SnaiuEAFVzko
         dz/RPoXd/iHaeN6msSlNL6lOYC/rgEZ2WZ9Ocl8xX0pKIn5FsljrsleIkj5xEFOU+xRf
         G6u25d/RxiVQut94ixBnNdZAERSXvIWpY9rejhfPv3veyFTpHoLSHwqx8sm/6njvTO0c
         lzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTZizCF4mBzhoH1k9EfuDvzGzYpsqOCj8H44w+5svOs=;
        b=B73E1drhwyFemaBLhb2ZQRb/ewJloNQ5yKfYq8Yibo+kHZyaTKK6G9Ip77nInk890+
         Wk9fibaebu/laAW9ZTwZTGAMpGD3wf6qmqM78xWMBJwpE+ht0uIsN81luQIE6YlaonsA
         pmrbUjQUQLLAM+L0d34HcocIwiMvHnI6CTQzEOo4j13eEk0FTgca/9q67n6Dosk4TpkH
         P0GlpXH4k2eynCpyFU8HEIvxD2llYdZhhdb4sxRNblr4xYa+xrKH/g8oonshApcnon99
         HrP2vk8txXKKPe+MGkLfnu7cew17AOs/EFF1BdxRMw0/UWzhRQkcYSHycVgwiXqiIV3B
         5wEw==
X-Gm-Message-State: AOAM530aZZwQuUM6QJgBGcD72n4PBxEph5wG7PjG5NAb7bBr9cfktnUs
        8+eUescMOtWQRUd8RMl4Np0=
X-Google-Smtp-Source: ABdhPJwEJI9R/kdA70qLf3Wjb3LePRTJks2aScW6zJtEhy48MG5H637QI65fCiApAbktKLC+Dwl0Rg==
X-Received: by 2002:a05:622a:254:: with SMTP id c20mr43607511qtx.31.1636026681695;
        Thu, 04 Nov 2021 04:51:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x7sm3448159qko.109.2021.11.04.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 04:51:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86/events/intel: replace snprintf in show functions with sysfs_emit
Date:   Thu,  4 Nov 2021 11:51:00 +0000
Message-Id: <20211104115100.31547-1-yao.jing2@zte.com.cn>
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

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 arch/x86/events/intel/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 603964408d2d..687e15473feb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5116,7 +5116,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+	return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);
 }
 
 static ssize_t set_sysctl_tfa(struct device *cdev,
@@ -5150,7 +5150,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -5166,7 +5166,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return sysfs_emit(buf, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
-- 
2.25.1

