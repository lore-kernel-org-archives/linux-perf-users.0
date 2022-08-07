Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713BAC19F2A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Aug 2022 07:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiHGHsO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Aug 2022 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiHGHsN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Aug 2022 03:48:13 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765D5FC3;
        Sun,  7 Aug 2022 00:48:10 -0700 (PDT)
X-QQ-mid: bizesmtp86t1659858480tz33kagm
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 07 Aug 2022 15:47:54 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: aV7gaNF68c+RCF21lqG5U0qofk0ktHKIHxMaKINsd4IX7dHQ+K+oB24erN7gI
        eMhJekVmp27lI8aGLNN4onsJjjXSpIKedWRk85gDuC8psHyRyrX78JB+zQutsgRNKyiwmkM
        h3VnxFesp9Q3huDkFScIuUf37yryWwvcTKFTbFXWE2b2Yl4E0lh1EHSVugWWeCI8oSTGH/1
        rL+TLjX3xNVqZ1L8VoyTs32zTeQhVHdybrPIFmQ+sbVAhTZtsir9KUQAgBOGkFdvFMqgLKU
        cUrenJz2GJy0j/7mnqr9UllYssL3Kv2wJ5K2Xnu/a3eYt8J16ZvclzeufC/OR8y2TuNHi1m
        NQ5cO6dl1kEXvr9zduTLC9WpaNRnR/VPgxbrMWDXRLsWqg5SHk=
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] perf test: Fix typo in comments
Date:   Sun,  7 Aug 2022 03:47:53 -0400
Message-Id: <20220807074753.7857-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Delete the rebundant word "then" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 tools/perf/tests/perf-time-to-tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 4ad0dfbc8b21..79a0d7fc6522 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -64,7 +64,7 @@ static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
  * This function implements a test that checks that the conversion of perf time
  * to and from TSC is consistent with the order of events.  If the test passes
  * %0 is returned, otherwise %-1 is returned.  If TSC conversion is not
- * supported then then the test passes but " (not supported)" is printed.
+ * supported then the test passes but " (not supported)" is printed.
  */
 static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-- 
2.35.1

