Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0973C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4517601FF
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbhHEQGh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232283AbhHEQGh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 12:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628179582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jE7ks8Qkc6R3DmWR8bnWH4oldDmygmCzqjJXXNKHRPQ=;
        b=UeuHOWdP8kHmVrU4rmUt1mZ51nHo1oOgN6H+dKbwqpUR4jHoL9cuVlQGpXlbvMsIOjLg/N
        4vC9gKL/tg/w3BBxmuMAfOcL5vEv0fCok5QG2UTu+suLN/6rz2dwkoCLCDZ2ofnefg91JL
        5RzewoM3DzzQw1sa9tQjAVmmarj/Hqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-QSnBu-y7P_ecKYMVr4hodA-1; Thu, 05 Aug 2021 12:06:20 -0400
X-MC-Unique: QSnBu-y7P_ecKYMVr4hodA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D63FE809CD2;
        Thu,  5 Aug 2021 16:06:19 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A274A5D6B1;
        Thu,  5 Aug 2021 16:06:17 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     acme@redhat.com, linux-perf-users@vger.kernel.org
Cc:     jolsa@redhat.com, sumanthk@linux.ibm.com
Subject: [PATCH] perf test: Fix bpf test sample mismatch reporting
Date:   Thu,  5 Aug 2021 18:06:11 +0200
Message-Id: <20210805160611.5542-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When the expected sample count in the condition changed, the message
needs to be changed too, otherwise we'll get:

  0x1001f2091d8: mmap mask[0]:
  BPF filter result incorrect, expected 56, got 56 samples

Fixes: 4b04e0decd25 ("perf test: Fix basic bpf filtering test")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index dbf5f5215abe..fa03ff0dc083 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -192,7 +192,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	}
 
 	if (count != expect * evlist->core.nr_entries) {
-		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect, count);
+		pr_debug("BPF filter result incorrect, expected %d, got %d samples\n", expect * evlist->core.nr_entries, count);
 		goto out_delete_evlist;
 	}
 
-- 
2.18.4

