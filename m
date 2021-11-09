Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E87C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC0561381
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 09:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbhKIJGB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 04:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbhKIJFZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 04:05:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40489C061205;
        Tue,  9 Nov 2021 01:01:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u17so19711073plg.9;
        Tue, 09 Nov 2021 01:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADqQSWSBgZvAUVfK5AnbdOpIlYdZvGUi9/6odqWla50=;
        b=BqIYfWbguzUXhd3p0RDhasrtP2hEMeyEhfAn9eVaqNTc/PToYnaPwPJy6/bnXileUZ
         K7xiNToySC7gr0EKr6ZeoAVZwTimoU4Swru+C429uBx8wANx1hjKMDlAdLoX1WMwQy23
         rJ2OEEfdk+ILeG132Y3SmoQHsE83yRxGHa8+R1x31ffvwoc2kvoAR6PREvQUNUCFGr5o
         zQNR9zRDCoICJes4lxG6zu9FCZZzNQKe1oTVMvOspKWNXgjwCLpiMo43mIaNq7bW4ISU
         VTbadijwQ6Pnfkg9R31RiKub1jZilmZyxI5/m2FIwrjFtQ4FGpsRdEie/mBkEnZ1pR3r
         cfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADqQSWSBgZvAUVfK5AnbdOpIlYdZvGUi9/6odqWla50=;
        b=7C8lkIAGn5ehHFxi9s1w1SjDJWT3pjxaDi9gxW7vHzDumwR6h+7c27qV5Tv47+A7Oi
         g/kqctQpUsq4qHVqVNqTHOTLPjO21i0qxjFUKf6lWEjNIxYvSmyMj1lmA4kEvbV33Snb
         Nx1/AxwYKdlOSkDOPhJAnmMZ1TE0oo9qSgcaY9ngw+gFvbaYJ/rjr3lD1El6sZ/dZizt
         qu53fI99/15fCug2Tsroel9ByifGHlz8amXBjpRpEyTfyr8M+9xbrWp5JjbH6f6NMvqH
         M3V6k9JZj9JLZznZU/1tH3mBWEpBT+sdSskLVg2paUfTzz1CWULBbBf61hmxv7EcMGj+
         oRag==
X-Gm-Message-State: AOAM533huvBsrg+LjjeyP5wSv/JEW61KZjJPi34+R3NSSPkg/KyGjd2f
        sa3GyCEthawypLqY/OEkvaKHVUyby5w=
X-Google-Smtp-Source: ABdhPJwf59kzjyK4ikxLTQsuWq+tt7XQ7usJ6wUhFx4AA8E4c0Ss8/4c9K8yJ9hvjdEXz0nhZA3ZXg==
X-Received: by 2002:a17:902:e546:b0:141:f4f7:7460 with SMTP id n6-20020a170902e54600b00141f4f77460mr5867395plf.17.1636448518838;
        Tue, 09 Nov 2021 01:01:58 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id 4sm1616065pgj.63.2021.11.09.01.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Nov 2021 01:01:58 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/perf/design: Synchronize the definition of enum perf_hw_id with code
Date:   Tue,  9 Nov 2021 17:01:47 +0800
Message-Id: <20211109090147.56978-1-likexu@tencent.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

We're not surprised that there are tons of Linux users who
only read the documentation to learn about the kernel.

Let's update the perf part for common hardware events
since three new *generic* hardware events were added.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/perf/design.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index a42fab308ff6..aa8cfeabb743 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -106,6 +106,9 @@ enum perf_hw_id {
 	PERF_COUNT_HW_BRANCH_INSTRUCTIONS	= 4,
 	PERF_COUNT_HW_BRANCH_MISSES		= 5,
 	PERF_COUNT_HW_BUS_CYCLES		= 6,
+	PERF_COUNT_HW_STALLED_CYCLES_FRONTEND	= 7,
+	PERF_COUNT_HW_STALLED_CYCLES_BACKEND	= 8,
+	PERF_COUNT_HW_REF_CPU_CYCLES		= 9,
 };
 
 These are standardized types of events that work relatively uniformly
-- 
2.33.0

