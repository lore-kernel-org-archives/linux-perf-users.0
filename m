Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9EDCA0EC3
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 12:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjILMUX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjILMUV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 08:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47C4E10D5
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694521171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tFi1GDyf9RmoFl4Z/U2EElHQSHqPJzZzmIgC5WvTwDI=;
        b=HxgRLjAKvMOf2lzTd7CqrS5jWn0MxredjIu9L72o4GujPut7JN4/Rb1ykBaFTH14CxAJ7w
        Axhu6WYfM9vgiqom/h79viCOb2KFYwOyDU21L/sgfkxBU79wMQUdF8IRfhBFHy64STIK2d
        kG7NHLaiGFM1EDmB0+r2MyOb2qVRTXw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-688--6q8uP-eN1-hmzNOc--Gog-1; Tue, 12 Sep 2023 08:19:28 -0400
X-MC-Unique: -6q8uP-eN1-hmzNOc--Gog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 242B129AA2D0;
        Tue, 12 Sep 2023 12:19:28 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 668131008808;
        Tue, 12 Sep 2023 12:19:27 +0000 (UTC)
From:   vmolnaro@redhat.com
To:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Cc:     mpetlan@redhat.com
Subject: [PATCH 1/2] perf test lock_contention.sh: Skip test if the number of CPUs is low
Date:   Tue, 12 Sep 2023 14:19:25 +0200
Message-ID: <20230912121926.12111-1-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Veronika Molnarova <vmolnaro@redhat.com>

Machines with less then 4 CPUs weren't consistently triggering lock
events required for the test.

Skip the test on those machines. The limit of 4 CPUs is set as it
generates around 100 lock events for a test.
---
 tools/perf/tests/shell/lock_contention.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index f2cc187b618..1d3598ff6a0 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -31,6 +31,12 @@ check() {
 		echo "[Skip] No lock contention tracepoints"
 		err=2
 		exit
+	fi 
+
+	if [ `nproc` -lt 4 ]; then
+		echo "[Skip] Low number of CPUs (`nproc`), lock event cannot be triggered certainly"
+		err=2
+		exit
 	fi
 }
 
-- 
2.41.0

