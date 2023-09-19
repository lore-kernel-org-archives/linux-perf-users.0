Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160B9CD5BD1
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Sep 2023 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjISPFZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Sep 2023 11:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjISPFY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Sep 2023 11:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51215DF
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Sep 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695135868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=toatH24IAT8DfilaQlW0apDAhapg6Pu+9UMZ6BD8Jds=;
        b=XeRJb/WPvI4ahUxccW0v8o31OAxxwR2dcnRpbukmPRhWi1Z/FuHDSU+CRvV0Jy32z1SrvZ
        XUSx62pT+GzUA0SyU60dN/9v7+hiNvV142zZyk+AP+DjenIsZpDwgVsmIwzVc6YPTVGTJB
        CJxOQ2ktwDrccmYHm0v9xUJlMQRuSCY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-YcklP4ArO7-pNbc86JWErg-1; Tue, 19 Sep 2023 11:04:26 -0400
X-MC-Unique: YcklP4ArO7-pNbc86JWErg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C12F382255D;
        Tue, 19 Sep 2023 15:04:22 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B99491005E28;
        Tue, 19 Sep 2023 15:04:21 +0000 (UTC)
From:   vmolnaro@redhat.com
To:     vmolnaro@redhat.com, linux-perf-users@vger.kernel.org,
        acme@kernel.org, acme@redhat.com
Cc:     mpetlan@redhat.com
Subject: [PATCH 2/2] perf test lock_contention.sh: Skip test if not enough CPUs
Date:   Tue, 19 Sep 2023 17:02:43 +0200
Message-ID: <20230919150419.23193-2-vmolnaro@redhat.com>
In-Reply-To: <20230919150419.23193-1-vmolnaro@redhat.com>
References: <20230919150419.23193-1-vmolnaro@redhat.com>
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

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
Resending the patches with sign-off as it didn't go through last time, 
also tried to fix the found issues.

 tools/perf/tests/shell/lock_contention.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index f2cc187b618..768c10f1d6b 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -32,6 +32,12 @@ check() {
 		err=2
 		exit
 	fi
+
+	if [ `nproc` -lt 4 ]; then
+		echo "[Skip] Low number of CPUs (`nproc`), lock event cannot be triggered certainly"
+		err=2
+		exit
+	fi
 }
 
 test_record()
-- 
2.41.0

