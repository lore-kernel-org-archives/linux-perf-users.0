Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ADAC64EC4
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Feb 2023 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjBJQz0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjBJQzX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:23 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B49795D7
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:22 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z8-20020a170902d54800b001994bb90ddfso3254946plf.8
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eTxS2QhvdNdpvgmUZqkMCnw+JmhuyZ0B0cX/cmTrdw=;
        b=NmReRb3Cda4WNwjHJW58p8tXQoCPNoToXpB97MxrKm630BDvcb1slFqI8uySPLb0n7
         VX1qskQJimagKJppZxLX/w2Rvvoo6deJAst6tEyaGXCVqBvpUr9dRERXHjFHx7lNWAMm
         xXIBmfWtRSj/6plxfwJgXcP40ieCBA5e5Pr9G3uLtfsuo3VzeseKxIhNy9Jui7lczkE/
         DJBWMmOJLZYd677Gx3mk+ZtIjakHoymHLPiOzdITuuA+vlEWtX3sExV9dZMMOBxJsRKM
         kA23dRyNZ56nWF+I6VrxcKi3UiiifejJiV0+7OEcg3ro09wANzVIyG6rwnweQrzJZiw9
         fP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eTxS2QhvdNdpvgmUZqkMCnw+JmhuyZ0B0cX/cmTrdw=;
        b=iMhNmBlE3AveHjBibAXCMql/VOpCfGknlV9wOXaa8358BjOW9w1NsWGXnB9Wx7te6X
         axZmK9OWvzgAx0IHT/Vh5krGVITqCBjMmfzmxaBfWfZ0y6N4KQXdinojW5GQTOgiVbzN
         QS3jqefNSTZY8NBpiJTVzexHQhzH+DY1bgmQxZjGzot1br+CyP06wlm6JzgJYPb480MQ
         JsdA2SU6x5YYMQpsYs+citH1zArfoy1J9flyDGEmcoNQVfCm6cqzS1eA4agNzGIxr7Mx
         fUYoVlopVx+UvXsS9Nv3hEkSY/xYrtKmromJCUfpZFLjA7eWrMIqFCylYaKXMQUw3EOW
         9B6Q==
X-Gm-Message-State: AO0yUKWQO+Ed/wMaQ4EIqCsHKqV5MNAwoixjOYULGdrZY6hTD5rv56AF
        2zKULzpX6F8LQ11KzqYhw01Yt+G+4AGPorg=
X-Google-Smtp-Source: AK7set+YMfD8sTDVabPOQ78qWERVLHMXj74nYgIQleRKqKxZRIemnhE4Bpwus4okiwWg/wZaOL9+ZSgBe0Ek2U0=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:a512:b0:199:554c:39c with SMTP
 id s18-20020a170902a51200b00199554c039cmr2149652plq.19.1676048122399; Fri, 10
 Feb 2023 08:55:22 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:54:56 -0500
In-Reply-To: <20230210165500.2292608-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230210165500.2292608-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210165500.2292608-5-zalbassam@google.com>
Subject: [PATCH v2 4/8] perf: pmuv3: Move inclusion of kvm_host.h to the
 arch-specific helper
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

KVM host support is available only on arm64.

By moving the inclusion of kvm_host.h to an arm64-specific file,
the 32bit architecture will be able to implement dummy helpers.

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230126204444.2204061-5-zalbassam@google.com
---
 arch/arm64/include/asm/arm_pmuv3.h | 2 ++
 drivers/perf/arm_pmuv3.c           | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index b13651a06adf9..1c460515b02bd 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -18,6 +18,8 @@
 #ifndef __ASM_PMUV3_H
 #define __ASM_PMUV3_H
 
+#include <linux/kvm_host.h>
+
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 46e89e92f8236..b3683fdf8d0b9 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -16,7 +16,6 @@
 
 #include <linux/acpi.h>
 #include <linux/clocksource.h>
-#include <linux/kvm_host.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
-- 
2.39.1.581.gbfd45094c4-goog

