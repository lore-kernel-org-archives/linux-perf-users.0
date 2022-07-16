Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113A3C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jul 2022 13:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiGSN3K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiGSN2z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jul 2022 09:28:55 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0585FA7;
        Tue, 19 Jul 2022 05:45:00 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658234559t2p9cey4
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:42:36 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000C00A0000000
X-QQ-FEAT: y5UFFkuhlmK39uWOV5DqxqO5Tj6sfllocKrJ3xpJ4Ql7ghLqcnTFoyRD0Jlz4
        T9GCnfbcgXnuSaMGurHxa235FaSzMv38wkVLuU5wn5hh5moxRWhflt2EcxO4PpZurlO99os
        3tGnptID4OLyB/WzTtg8CwV/7dwPVAjxVtcCi11rFauTITrqJC9ld1IdxVKS0DMquctFHBv
        vtjDI76lHhIK9BTctzalu/a5etFkU1tnzBSQUYkG7JnL4wjKhhEleo1n5sG30QPdEi8jGav
        GuBgL6bUBOBdynMTCBsePY5n/Jkdlv7fhZQ38XEGr45ECYgswIKL4fKwB3ppOX20Ky8YENf
        g0zM9OgBUIrSHx9WsAari2C9qBjnoWBxjMwfKG4dXKetEbcEf8tkgKb+62617ca7lQ59AHk
        ly4VldHOX9o=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     suzuki.poulose@arm.com
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, john.garry@huawei.com, will@kernel.org,
        james.clark@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] perf cs-etm: Fix comment typo
Date:   Sat, 16 Jul 2022 12:40:40 +0800
Message-Id: <20220716044040.43123-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8b95fb3c4d7b..16db965ac995 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1451,7 +1451,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * tidq->packet->instr_count represents the number of
 		 * instructions in the current etm packet.
 		 *
-		 * Period instructions (Pi) contains the the number of
+		 * Period instructions (Pi) contains the number of
 		 * instructions executed after the sample point(n) from the
 		 * previous etm packet.  This will always be less than
 		 * etm->instructions_sample_period.
-- 
2.35.1

