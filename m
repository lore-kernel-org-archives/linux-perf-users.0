Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D16C3DA71
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Dec 2022 16:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiLSQbS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiLSQbJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Dec 2022 11:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9BEBF2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Dec 2022 08:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671467420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=reQXhCOfknl7qIZ+KahalTwkbNSsH6zEhtkbBHNqlQs=;
        b=FekwPRgwNuv3hZe8zEyFvF3Y17caQmKjahyR4/GySBFjz/5DBWt9TPyeml/gMhv+hj7GjL
        V/x5J1iLOTGED9/zr7daZYsVZNW7GE4oe7hVzOIXiwiKLsDvF8+c8CYyo/cJvD8K1VW1+1
        imEXzrk+1Byob+wBDU90TcMSY3e6Xp0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-5mMGcfuiPjSHQ7j5I3QOGw-1; Mon, 19 Dec 2022 11:30:16 -0500
X-MC-Unique: 5mMGcfuiPjSHQ7j5I3QOGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A5183806739;
        Mon, 19 Dec 2022 16:30:14 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FE0117582;
        Mon, 19 Dec 2022 16:30:10 +0000 (UTC)
From:   Michael Petlan <mpetlan@redhat.com>
To:     linux-perf-users@vger.kernel.org, acme@redhat.com
Cc:     disgoel@linux.vnet.ibm.com, atrajeev@linux.vnet.ibm.com,
        mpe@ellerman.id.au, irogers@google.com, rnsastry@linux.ibm.com
Subject: [PATCH] perf test: Fix "all PMU test" to skip parametrized events
Date:   Mon, 19 Dec 2022 17:30:08 +0100
Message-Id: <20221219163008.9691-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Parametrized events are not only a powerpc domain. They occur on other
platforms too (e.g. aarch64). They should be ignored in this testcase,
since proper setup of the parameters is out of scope of this script.

Let's not filter them out by PMU name, but rather based on the fact
that they expect a parameter.

Fixes: 451ed8058c69 ("perf test: Fix "all PMU test" to skip hv_24x7/hv_gpci tests on powerpc")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/stat_all_pmu.sh | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index 9c9ef33e0b3c..c77955419173 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -4,17 +4,8 @@
 
 set -e
 
-for p in $(perf list --raw-dump pmu); do
-  # In powerpc, skip the events for hv_24x7 and hv_gpci.
-  # These events needs input values to be filled in for
-  # core, chip, partition id based on system.
-  # Example: hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
-  # hv_gpci/event,partition_id=?/
-  # Hence skip these events for ppc.
-  if echo "$p" |grep -Eq 'hv_24x7|hv_gpci' ; then
-    echo "Skipping: Event '$p' in powerpc"
-    continue
-  fi
+# Test all PMU events; however exclude parametrized ones (name contains '?')
+for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
   echo "Testing $p"
   result=$(perf stat -e "$p" true 2>&1)
   if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
-- 
2.18.4

