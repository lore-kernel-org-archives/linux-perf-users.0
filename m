Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17161C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Jun 2022 10:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiFNKwV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiFNKwS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Jun 2022 06:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B45704925A
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jun 2022 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655203936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=0wNA1VQgyCCUSE4A/iZqDRkwdxV6/sL0ZXmKKaUB9rw=;
        b=L03Iwa/Q26sFUxHW+Z+f+i44ZSrym049d0URB6/k3RDRIrG8+sxhS1uGw2QHhrMoqZL60p
        T01Fm65mwiWmCdU+mk5NJMGFeBCqKXrzgEFtCrrEoIi4OJ+yLNGX5I0wShMyPeYDCN1p/L
        k7XN5qfll6RvqJiKc93IR/fk22eTMOU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-P4cZPo30PH-iUUV8ubTjBg-1; Tue, 14 Jun 2022 06:52:11 -0400
X-MC-Unique: P4cZPo30PH-iUUV8ubTjBg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7297E101A54E;
        Tue, 14 Jun 2022 10:52:11 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DC94010E32;
        Tue, 14 Jun 2022 10:52:09 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     acme@redhat.com, jolsa@kernel.org, german.gomez@arm.com
Subject: [PATCH] perf test: Record only user callchains
Date:   Tue, 14 Jun 2022 12:52:07 +0200
Message-Id: <20220614105207.26223-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The testcase 'Check Arm64 callgraphs are complete in fp mode' wants to
see the following output:

    610 leaf
    62f parent
    648 main

However, without excluding user callchains, the output might look like:
	ffffc2ff40ef1b5c arch_local_irq_enable
	ffffc2ff419d032c __schedule
	ffffc2ff419d06c0 schedule
	ffffc2ff40e4da30 do_notify_resume
	ffffc2ff40e421b0 work_pending
	             610 leaf
	             62f parent
	             648 main

Adding '--user-callchains' leaves only the wanted symbols in the chain.

Suggested-by: German Gomez <german.gomez@arm.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/test_arm_callgraph_fp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index 6ffbb27afaba..ec108d45d3c6 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -43,7 +43,7 @@ CFLAGS="-g -O0 -fno-inline -fno-omit-frame-pointer"
 cc $CFLAGS $TEST_PROGRAM_SOURCE -o $TEST_PROGRAM || exit 1
 
 # Add a 1 second delay to skip samples that are not in the leaf() function
-perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 -- $TEST_PROGRAM 2> /dev/null &
+perf record -o $PERF_DATA --call-graph fp -e cycles//u -D 1000 --user-callchains -- $TEST_PROGRAM 2> /dev/null &
 PID=$!
 
 echo " + Recording (PID=$PID)..."
-- 
2.18.4

