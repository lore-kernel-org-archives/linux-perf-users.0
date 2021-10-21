Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC938C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A0D61057
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 06:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhJUGsm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 02:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUGsk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 02:48:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2FC06161C;
        Wed, 20 Oct 2021 23:46:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so4195341pjb.3;
        Wed, 20 Oct 2021 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1M3kvLsbJ/ih3Eftrqw3DQFcvO6OMU9UEVLzGqMRyVU=;
        b=DmSnDoPQUC4477skIZmU6dENmvchZn3rssc191wBgZZTrQQ/DOuxmpUI+Z/vX+opba
         TCAFFf63hCgXPwlhDa6YGWUmIbnU7zPpKY4g4+giL0ZsWU8ITGXCQMa5SqvILgOZOR85
         V8jIwD7e94+ypon+Dw+ETGMY5yazB2QRpIG8vdmrlQIr4yfnpxVYyr5pn5hT8LTUYPxB
         mbO2EmdY0/VOGc9vmztsjdQdMcWQuJ65C3y2RZzR+67Y+jb/WsyDCxzaYwcXIyb6T1Oc
         cgnsEF8WXohHlSOGGWPB44qBiKads61gZDXmGwzlB5wOdO1fkx25cXMeUmPagB9/J4/2
         +5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1M3kvLsbJ/ih3Eftrqw3DQFcvO6OMU9UEVLzGqMRyVU=;
        b=CyBO61S2AJwbeHTdUTbnEMmIbWziGsNgLaT7tTl5lz2ie6Qpqj+vqC0z42hJdSi1dG
         P6nraBqdp6tcqI9z9bTR6FVeZZRmRQvBLLcO07+WcPgP0YDX/z7LZ0Ra+nFf8bT/NtFU
         EGEdeiq4Z8ruXlLIsX/sfqw9IMY0CkhT4XwXiwFGXWL5uq31Aic7hUFSGVZutPRFQUqS
         9uiIsQOTt7bRR+wDhccG5mQ0+ixQ5xXMHyVXXVPf94Nir3iisrKTExFTSr2KP87qoyw7
         244+6HVLkjvVkzMlMYKrdU7QKEOuuHDtK98SATlCXnmfEUlOKJuoWlYCKByY6HlmYe62
         81Mg==
X-Gm-Message-State: AOAM533m4M+74/r6s6ELS5mWWrfgHq+ASI26ZBOHKUVbWY+EZ8iCt2kh
        K/EbKn/fR851OMr/DhH6jXQ=
X-Google-Smtp-Source: ABdhPJxZ4vZikdD069dZLSVdPUu3bfHoBofw2Xwa8MsjN/cGJCmt0I7uP+2EGPvNcB0u6kYFZo3JaA==
X-Received: by 2002:a17:902:da8a:b0:13f:1a39:e02f with SMTP id j10-20020a170902da8a00b0013f1a39e02fmr3661792plx.82.1634798784557;
        Wed, 20 Oct 2021 23:46:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d21sm5049720pfl.135.2021.10.20.23.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 23:46:24 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     mingo@redhat.com
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] x86/events: fixup coccinelle warnings
Date:   Thu, 21 Oct 2021 06:46:18 +0000
Message-Id: <20211021064618.1047485-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 arch/x86/events/core.c       | 4 ++--
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/events/intel/pt.c   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 38b2c779146f..d7fb8a57b47f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2555,7 +2555,7 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
+	return sysfs_emit(buf, "%d\n", x86_pmu.attr_rdpmc);
 }
 
 static ssize_t set_attr_rdpmc(struct device *cdev,
@@ -2613,7 +2613,7 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	return sysfs_emit(buf, "%d\n", x86_pmu_max_precise());
 }
 
 static DEVICE_ATTR_RO(max_precise);
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
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 7f406c14715f..d3038fc5e0db 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -92,7 +92,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	enum pt_capabilities cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
+	return sysfs_emit(buf, "%x\n", intel_pt_validate_hw_cap(cap));
 }
 
 static struct attribute_group pt_cap_group __ro_after_init = {
-- 
2.25.1

