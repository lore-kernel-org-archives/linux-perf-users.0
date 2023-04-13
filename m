Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384B1C77B6E
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Apr 2023 16:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDMQUh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMQUg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 12:20:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0867A72B3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 09:20:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so10165522wmq.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1681402833; x=1683994833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbhrF1vaRRoJzYyea1JBFcTA2VAH3WkbBcvliTXkyWM=;
        b=xVRpVSn8CzSugrtbdPwe0szyiwDqMkR+UEllz4W7naM2gmqv/Mjyn0tKhvPZYVFy5B
         qr7sBJ8yOjlJ7nfDYo+ia+PpSt/Cr4cMPH2Otf/r4hvuEXhldV8NkSKpARdKTc9lj0q8
         UyeAxkjzT9B3qvstiOW4L4Iu/x4tV+F3KeldSXVb+gMF5feNEXAVY/IiZUN0E06bBf6E
         MTOzvMFWYX11zNGN7XMXfnV9f5u6Sdp8SmuzAJAkd80wMkQwfswo2ikmUIHm4fLfLcb+
         OwbsxPWDKcdl/YA0HMvx62LAYuGXYdbz6xIExRTw8/ntNeRjdkzZfbQzrpdFj2AyhHtW
         QEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402833; x=1683994833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbhrF1vaRRoJzYyea1JBFcTA2VAH3WkbBcvliTXkyWM=;
        b=eumqje5HYteueZTi7Y4B9P100Lg1VnwtNyYDlhyoY3YSVWjj39VqEzdEDOHCufUbeI
         X+i6Ekoy+EO6G0giHH2Ly//EWd5C8BwJRUDMo56iUfokNF+GCrODesGZTvIy0uUaCF+E
         4O18QW0y/dH+utjg59doXe8afHpznSwMufQOX7H6JpH/SIqhP/eft3fHDxtJI5UF9n8H
         2I3wh3ALLRfviQVLEB8aJsH1gxBq7JOHMmpCKBjbIir9wXpcVAJS7T9E8/uGV4NZuVw2
         QONtGOs2g0ovjjlRBlYW/4nwkcX4mp1vVmNeUrSlzD+FcISUPiCaiHwc9nGeFZ5WYER/
         j2bA==
X-Gm-Message-State: AAQBX9cazuquFzk/7Eg/O6xiZIXLZ+fxdrwzATt3Ho5MqiJmo2reoO01
        eN+xB4aMNRevQQ3n28T7TkaqAA==
X-Google-Smtp-Source: AKy350Zp5PeohDBdd7Xv3HthFjOkMMVG4oUVL5Rpyjw5IcUHxehnqFrVF/5LhGA4zzMyI3xHwOYFNg==
X-Received: by 2002:a05:600c:2244:b0:3f0:7e63:e034 with SMTP id a4-20020a05600c224400b003f07e63e034mr2268188wmm.29.1681402833535;
        Thu, 13 Apr 2023 09:20:33 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003f09fd301ddsm5004185wmq.1.2023.04.13.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 09:20:33 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 3/4] riscv: Make legacy counter enum match the HW numbering
Date:   Thu, 13 Apr 2023 18:17:24 +0200
Message-Id: <20230413161725.195417-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230413161725.195417-1-alexghiti@rivosinc.com>
References: <20230413161725.195417-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

RISCV_PMU_LEGACY_INSTRET used to be set to 1 whereas the offset of this
hardware counter from CSR_CYCLE is actually 2: make this offset match the
real hw offset so that we can directly expose those values to userspace.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 drivers/perf/riscv_pmu_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index ca9e20bfc7ac..0d8c9d8849ee 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -12,8 +12,11 @@
 #include <linux/perf/riscv_pmu.h>
 #include <linux/platform_device.h>
 
-#define RISCV_PMU_LEGACY_CYCLE		0
-#define RISCV_PMU_LEGACY_INSTRET	1
+enum {
+	RISCV_PMU_LEGACY_CYCLE,
+	RISCV_PMU_LEGACY_TIME,
+	RISCV_PMU_LEGACY_INSTRET
+};
 
 static bool pmu_init_done;
 
-- 
2.37.2

