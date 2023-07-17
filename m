Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D302DEB64DC
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Jul 2023 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGQKS2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Jul 2023 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGQKS1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Jul 2023 06:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B063116
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Jul 2023 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689589074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9uZnNi/X5LAplhAECNi5MK9XPEkBrvNM7bX0mtceGCo=;
        b=J+hx2Us8Q4VmwS8JALQ6qG4D1st4z28wXoazzn8pFqHNf7DPudTm2wa1z0b/kdfxUFSnib
        hDhwTlxyDzB1pqK5xccRAlrHwN/wgFGCNvSW4WSnMswltlKsUHyx1dFT6EGDqjZxOn0w92
        9P7ng5KLImShHQ+TULoZ141eV1phGOE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-DbrMMteZNtG7zTB2ibnWHw-1; Mon, 17 Jul 2023 06:17:49 -0400
X-MC-Unique: DbrMMteZNtG7zTB2ibnWHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81896800B35;
        Mon, 17 Jul 2023 10:17:48 +0000 (UTC)
Received: from dhcp-134-122.lab.eng.brq2.redhat.com (dhcp-134-122.lab.eng.brq2.redhat.com [10.37.134.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1FF040C6F4C;
        Mon, 17 Jul 2023 10:17:46 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        carsten.haitzler@arm.com, james.clark@arm.com, acme@kernel.org,
        jstancek@redhat.com
Subject: [PATCH] perf test coresight: asm_pure_loop: add .note.GNU-stack
Date:   Mon, 17 Jul 2023 06:17:42 -0400
Message-Id: <e79288922fbd0bad6facf06488735ec74f811d1b.1689588798.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add .note.GNU-stack annotation to indicate it does not need
executable stack.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
index 75cf084a927d..bb39d8089331 100644
--- a/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
+++ b/tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
@@ -26,3 +26,5 @@ skip:
 	mov	x0, #0
 	mov	x8, #93 // __NR_exit syscall
 	svc	#0
+
+.section .note.GNU-stack,"",@progbits
-- 
2.39.0

