Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91814C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Nov 2022 08:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKVIc7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiKVIci (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Nov 2022 03:32:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E4F40478
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Nov 2022 00:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669105888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=WAE9UCy36wjhWwkpwskpOeH61lqVZI3X+KQc7eoa5fo=;
        b=eGvn7D+S9i9VkvHwg1gvXmeCeQjMnqe/lfh+zcAzFpftDDVbh9TTOHNs+2azEE7fT8J0S7
        483QtQ4KowPTjWKGqDIqQtVdn17znRWiF2GTej+l84dTVvh/g51oF+HWj34l3NkddqUqG8
        FC0c2yWvRki5XfPIs/89ny4JhB3t0Uc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-JarI72DKMx6zNBFpilUwQg-1; Tue, 22 Nov 2022 03:31:26 -0500
X-MC-Unique: JarI72DKMx6zNBFpilUwQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97DD63C0F42D
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Nov 2022 08:31:26 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18080C159CD
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Nov 2022 08:31:25 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org
Subject: [PATCH] perf test: Fix record test on KVM guests
Date:   Tue, 22 Nov 2022 09:31:21 +0100
Message-Id: <20221122083121.6012-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Using precise flag with br_inst_retired.near_call causes the test fail
on KVM guests, even when the guests have PMU forwarding enabled and the
event itself is supported.

Remove the precise flag in order to make the test work on KVM guests.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/record.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index e93b3a8871fe..a796222288ec 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -134,7 +134,7 @@ test_register_capture() {
     echo "Register capture test [Skipped missing registers]"
     return
   fi
-  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
+  if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call \
     -c 1000 --per-thread ${testprog} 2> /dev/null \
     | perf script -F ip,sym,iregs -i - 2> /dev/null \
     | grep -q "DI:"
-- 
2.18.4

