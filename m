Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6225C6377A
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAC161221
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 15:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhGUOWa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 10:22:30 -0400
Received: from foss.arm.com ([217.140.110.172]:56866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239502AbhGUOVj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 10:21:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CEF531B;
        Wed, 21 Jul 2021 08:02:13 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.39.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01DFC3F73D;
        Wed, 21 Jul 2021 08:02:10 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org
Cc:     leo.yan@linaro.org, al.grant@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] perf cs-etm: Refactor initialisation of kernel start address
Date:   Wed, 21 Jul 2021 16:01:57 +0100
Message-Id: <20210721150202.32065-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210721150202.32065-1-james.clark@arm.com>
References: <20210721150202.32065-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The kernel start address is already cached in the machine struct once it
is initialised, so storing it in the cs_etm struct is unnecessary.

It also depends on kernel maps being available to be initialised.
Therefore cs_etm__setup_queues() isn't an appropriate place to call it
because it could be called before processing starts. It would be better
to initialise it at the point when it is needed, then we can be sure
that all the necessary maps are available. Also by calling
machine__kernel_start() multiple times it can be initialised at some
point, even if it failed to initialise previously due to missing maps.

In a later commit cs_etm__setup_queues() will be moved which is the
motivation for this change.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index bc1f64873c8f..4c69ef391f60 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -62,7 +62,6 @@ struct cs_etm_auxtrace {
 	u64 instructions_sample_period;
 	u64 instructions_id;
 	u64 **metadata;
-	u64 kernel_start;
 	unsigned int pmu_type;
 };
 
@@ -691,7 +690,7 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
 
 	machine = etmq->etm->machine;
 
-	if (address >= etmq->etm->kernel_start) {
+	if (address >= machine__kernel_start(machine)) {
 		if (machine__is_host(machine))
 			return PERF_RECORD_MISC_KERNEL;
 		else
@@ -901,9 +900,6 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
 	unsigned int i;
 	int ret;
 
-	if (!etm->kernel_start)
-		etm->kernel_start = machine__kernel_start(etm->machine);
-
 	for (i = 0; i < etm->queues.nr_queues; i++) {
 		ret = cs_etm__setup_queue(etm, &etm->queues.queue_array[i], i);
 		if (ret)
-- 
2.28.0

