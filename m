Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2626AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhKZW22 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhKZW02 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 17:26:28 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9267C06173E;
        Fri, 26 Nov 2021 14:23:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso8173513wmh.0;
        Fri, 26 Nov 2021 14:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+4t5OMP+y8asfHJx9yemcdXWelcG0CCFormBoppS2w=;
        b=Gzxae8UGy2wtl+rrwGkZkZQPrLUDgc0Nc9kSYiZm5VyR4AcHrSzQE1oIXHanuNvRlS
         1COJ8mspv1pFLIiNp+fQiWfqN+bt1VwfFl4A53f95zL/Dgz8Nf5Qrbz1TN6DY79QXC5n
         I1C8c9Vr859QaoU2P23LgpGx2F861z9dHPKs/okYG9jkSjH6NoayVuMnjkw90spw6aSy
         vd30uuk2MUSBBVJ5oSdHS2ERGWYE3nswWJLhmne6f0d4EM0LhIXvvZSJpJuHvvVKM/Gd
         W/Pyj6CStsRIcW6pj7SzAE0Z8A7LYK2qnJ65VdusgNkoZisOd6e4qedsS+52/dEtREPr
         w+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z+4t5OMP+y8asfHJx9yemcdXWelcG0CCFormBoppS2w=;
        b=uobiXqoruj1envOpUFQcVSHq1mI7uV41uePzkcJKVI4LLGJQW+8mRX4eLxr+NGdlMk
         bpYIaGbCAfYepjogg5MafxagRPAS2DbMmSSEQGBBe0YV4mWEdjOlb1CKrlqbsLjiVOLI
         BuahldWJ4qJZBYFmDjF0qJAokCCgg/6ABccvXacJd35gDBX/d/BNAazLCE+qD7iIIOTh
         qBi440S/gu7m/VNtkvMZ3mVXIZMdmNImoRZ5I0gVWUXSHVxXob9fpWFdfk9t2aoKqDr/
         9zuk7j19FII0xGoNf4UMvmzRrXlvBlQsLdDOv/cvhMIO8Nly4ZyBpPHnkA8qJTrTP8YJ
         Susg==
X-Gm-Message-State: AOAM532KJvypWQjuC25wzhODacsAhE2HZKBPH4za7vRz6LdIvqdJrip0
        /JQxPCxwooHx8Q==
X-Google-Smtp-Source: ABdhPJzMntEXDyGjqAPNcqmlryFDYENzBgRQiOuclEM7RYDtf91okuklzP7kFyID/PcFnkVcWS1P5Q==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr18789968wmq.148.1637965393404;
        Fri, 26 Nov 2021 14:23:13 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d7sm6349690wrw.87.2021.11.26.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:23:13 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-snps-arc@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARC: perf: Remove redundant initialization of variable idx
Date:   Fri, 26 Nov 2021 22:23:12 +0000
Message-Id: <20211126222312.1125594-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The variable idx is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/arc/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 145722f80c9b..f5dd799ddb9e 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -361,7 +361,7 @@ static int arc_pmu_add(struct perf_event *event, int flags)
 {
 	struct arc_pmu_cpu *pmu_cpu = this_cpu_ptr(&arc_pmu_cpu);
 	struct hw_perf_event *hwc = &event->hw;
-	int idx = hwc->idx;
+	int idx;
 
 	idx = ffz(pmu_cpu->used_mask[0]);
 	if (idx == arc_pmu->n_counters)
-- 
2.33.1

