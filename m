Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5EEEE4993
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 09:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjHUJBf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 05:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjHUJBf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 05:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C81C4
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692608457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x9CTxUC7/S4QALZTobYyZuHG+uh5iHA2aPDORTC57Fk=;
        b=eGd/rv0V5NgoSyWoPJHwtSWw3omWliTACZLljxgQ58s8SMt9pa3PHUR4pFmmi7y12K7W/G
        PPeSBjYs4O8AABm9jPz7v7CksueHfP01ImVvr409mqqeDRbpkB4rZ2ukNRrZvmv3X8gX4B
        pimfI8SmQe9Zoa4Ar+T2NCTLhmxAgH4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-sv35uJdfPKC1MqEQE9scSg-1; Mon, 21 Aug 2023 05:00:55 -0400
X-MC-Unique: sv35uJdfPKC1MqEQE9scSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E1A0801FA0;
        Mon, 21 Aug 2023 09:00:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D4B32026D76;
        Mon, 21 Aug 2023 09:00:54 +0000 (UTC)
From:   vmolnaro@redhat.com
To:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Cc:     mpetlan@redhat.com
Subject: [PATCH 1/2] perf test lock_contention.sh: Skip test if the number of CPUs is low
Date:   Mon, 21 Aug 2023 11:00:52 +0200
Message-ID: <20230821090053.8807-1-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: notValord <v.m.veverka@gmail.com>

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

