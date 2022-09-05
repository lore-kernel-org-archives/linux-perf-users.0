Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73369ECAAD5
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Sep 2022 05:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiIEFnO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Sep 2022 01:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiIEFnL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Sep 2022 01:43:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5724A2F3A6;
        Sun,  4 Sep 2022 22:43:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F326D6E;
        Sun,  4 Sep 2022 22:43:16 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F03513F73D;
        Sun,  4 Sep 2022 22:43:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Subject: [PATCH V2 2/4] perf/core: Assert PERF_EVENT_FLAG_ARCH does not overlap with generic flags
Date:   Mon,  5 Sep 2022 11:12:37 +0530
Message-Id: <20220905054239.324029-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905054239.324029-1-anshuman.khandual@arm.com>
References: <20220905054239.324029-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This just ensures that PERF_EVENT_FLAG_ARCH does not overlap with generic
hardware event flags.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f51fbf4a595..10e23a0f9db0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -140,6 +140,8 @@ struct hw_perf_event_extra {
 #define PERF_EVENT_FLAG_ARCH			0x000fffff
 #define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
 
+static_assert((PERF_EVENT_FLAG_USER_READ_CNT & PERF_EVENT_FLAG_ARCH) == 0);
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
-- 
2.25.1

