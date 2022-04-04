Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A21C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Apr 2022 22:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiDDXAR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbiDDW77 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Apr 2022 18:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F028B689BA
        for <linux-perf-users@vger.kernel.org>; Mon,  4 Apr 2022 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649110547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Z2GhUuA3WSCuHq7xQzvmfremBfFb0z4PXZzph0ghBJc=;
        b=BBwTCuVM4ZCzLsPFvwMmRr9ijqGt5P4jcqlXGfPIb18WXW4DnoprgWq/4gaewF6rG/vZdw
        /WDfJMCATgtnCx9fb9AqaNIwzrUT0t4RZ9OcBCb4fhQX8iw2rbuyNhx2hgQQZqNCbUCPTT
        iKPSL7wf4Wt4YcOKOwUqm2imabd4+yE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-0W8Vn9aAMHWbsOvU4W3hNg-1; Mon, 04 Apr 2022 18:15:44 -0400
X-MC-Unique: 0W8Vn9aAMHWbsOvU4W3hNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4220C85A5BE;
        Mon,  4 Apr 2022 22:15:44 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52CA540D0197;
        Mon,  4 Apr 2022 22:15:43 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@redhat.com
Cc:     jolsa@kernel.org
Subject: [PATCH 1/2] perf docs: Add perf-iostat link to manpages
Date:   Tue,  5 Apr 2022 00:15:40 +0200
Message-Id: <20220404221541.30312-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/Documentation/perf.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index 9c330cdfa973..71ebdf8125de 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -83,7 +83,7 @@ linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
 linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
 linkperf:perf-evlist[1], linkperf:perf-ftrace[1],
 linkperf:perf-help[1], linkperf:perf-inject[1],
-linkperf:perf-intel-pt[1], linkperf:perf-kallsyms[1],
+linkperf:perf-intel-pt[1], linkperf:perf-iostat[1], linkperf:perf-kallsyms[1],
 linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
 linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
 linkperf:perf-script[1], linkperf:perf-test[1],
-- 
2.18.4

