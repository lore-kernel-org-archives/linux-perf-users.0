Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA4C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 May 2022 15:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbiEYPmG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 May 2022 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245225AbiEYPl7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 May 2022 11:41:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 075832DD45;
        Wed, 25 May 2022 08:41:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBA351424;
        Wed, 25 May 2022 08:41:56 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.8.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89DF53F73D;
        Wed, 25 May 2022 08:41:53 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     broonie@kernel.org, german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/5] perf tools: Use dynamic register set for Dwarf unwind
Date:   Wed, 25 May 2022 16:41:12 +0100
Message-Id: <20220525154114.718321-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220525154114.718321-1-james.clark@arm.com>
References: <20220525154114.718321-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Architectures can detect availability of extra registers at
runtime so use this more complete set for unwinding. This
will include the VG register on arm64 in a later commit.

If the function isn't implemented then PERF_REGS_MASK is
returned and there is no change.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ef169ad15236..020836a4c4bc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -896,7 +896,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
 					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
 			} else {
-				attr->sample_regs_user |= PERF_REGS_MASK;
+				attr->sample_regs_user |= arch__user_reg_mask();
 			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
-- 
2.28.0

