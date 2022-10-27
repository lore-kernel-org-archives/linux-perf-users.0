Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A5BECAAA1
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Oct 2022 13:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiJ0Nfp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 Oct 2022 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiJ0Nfo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 Oct 2022 09:35:44 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58006152014
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Oct 2022 06:35:43 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id d187so1591782vsd.6
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Oct 2022 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ybstN7f+kXd58VgRIov/9s6MeFgWJ+N6wj257nI0Lg=;
        b=ayUh8+OznejXo7f1dKWpgAMW3XuQtibP2G1DZgTqysx++FMKRtun60GcOPXiQfrt+8
         jRQpG50j2IU4zKFP0YxPUJ1Zxg5IMZK1zGunVusO/5m3nHZ20MXtQp+Qu5sxEreJjfLp
         l9wh3ZYONuvKcG5HW09HyYp3eZ6t/215AUOxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ybstN7f+kXd58VgRIov/9s6MeFgWJ+N6wj257nI0Lg=;
        b=pTlxxcT16qbz9cYaajAm6ciwoMu9b4rpK+kBIEYw8vywsxWSw7zND9uUPgVxXu36nD
         4NIiqGmI/7aOOJhljVm91c13IzfkT2pjCN7eLWB75pZYA/dhG3aE676OHtJgv4CpWtqk
         RqRf6uOYSMYjZp0bU4LLhXSTW6irwZDRCIYW/Lc/Ct5ZRAD2HgeU9yLvvWlF9/0nPgZx
         ZD98XbM31/e2bWVXEUF6g3ue3rIRSDwmX52TnzAJZlaT3X21/F2IHNVmS9mJ4s8uAUp+
         HXGyMn700XNC4+JbHvtDRKi9LPqteLPabuvdeCIZyaUvhMSdBa/WXuvfBd005i2Ht5GW
         KJLQ==
X-Gm-Message-State: ACrzQf1f1jFM4rYSDZl4rZIaonMhAePgBqKw9TY5ZIXvJVAkgIOTep5L
        YNaw1+8i3Xt1V4zkmXnxdRqjiO2qijRdY7QB
X-Google-Smtp-Source: AMsMyM6GjEspIfDhmpWT+Lgb6seweBY5igaXFywtPUP3WVl3yJPb6YUFL08ldQtHPalME0xxS98pjg==
X-Received: by 2002:a05:6214:4015:b0:4b1:78f2:8dfd with SMTP id kd21-20020a056214401500b004b178f28dfdmr42091251qvb.81.1666877731516;
        Thu, 27 Oct 2022 06:35:31 -0700 (PDT)
Received: from xryan.lan (107-142-220-210.lightspeed.wlfrct.sbcglobal.net. [107.142.220.210])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a410300b006eef13ef4c8sm971265qko.94.2022.10.27.06.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 06:35:30 -0700 (PDT)
From:   Liang Yan <lyan@digitalocean.com>
X-Google-Original-From: Liang Yan <lyan@digtalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/x86/events/amd/core.c: Return -ENODEV when CPU does not have PERFCTL_CORE bit
Date:   Thu, 27 Oct 2022 09:35:11 -0400
Message-Id: <20221027133511.161922-1-lyan@digtalocean.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

After disabling cpu.perfctr_core in qemu, I noticed that the guest kernel
still loads the pmu driver while the cpuid does not have perfctl_core.

The test is running on an EPYC Rome machine.
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# lscpu | grep perfctl
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~#
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
[    0.732097] Performance Events: AMD PMU driver.

By further looking,

==> init_hw_perf_events
    ==> amd_pmu_init
        ==> amd_core_pmu_init
            ==>
                if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
			return 0;

With returning 0, it will bypass amd_pmu_init and return 0 to
init_hw_perf_events, and continue the initialization.

I am not a perf expert and not sure if it is expected for AMD PMU,
otherwise, it would be nice to return -ENODEV instead.

New output after the change:
root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
[    0.531609] Performance Events: no PMU driver, software events only.

Signed-off-by: Liang Yan <lyan@digtalocean.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8b70237c33f7..34d3d2944020 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1335,7 +1335,7 @@ static int __init amd_core_pmu_init(void)
 	int i;
 
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
-		return 0;
+		return -ENODEV;
 
 	/* Avoid calculating the value each time in the NMI handler */
 	perf_nmi_window = msecs_to_jiffies(100);
-- 
2.34.1

