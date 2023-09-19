Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFC4CD5BCD
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Sep 2023 15:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjISPFS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Sep 2023 11:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjISPFR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Sep 2023 11:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E992
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Sep 2023 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695135865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2mOJtqNjM2BgyD4KPBQ+Og95EOKGNsoMxxpZLLYYP18=;
        b=dLtwmO8YE3lD11oZ5AqU/BJnZMpxHs2WPbnseIGpHGhsBHruJt+KV9iVwdLrBScJ1hzipS
        cFQRAtQm4R9k9yDHdKnIn7N1ftA6fRyTwVXCrAXAxhqFIp6o1ECW4AH5XpgXajaU4jzSMo
        odMgAmASlbAIHw/q6KinZRA/KXvVoHQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-JFPVI7UROTuTTBCzdw367A-1; Tue, 19 Sep 2023 11:04:22 -0400
X-MC-Unique: JFPVI7UROTuTTBCzdw367A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 853CF858286;
        Tue, 19 Sep 2023 15:04:21 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFA2510EE859;
        Tue, 19 Sep 2023 15:04:20 +0000 (UTC)
From:   vmolnaro@redhat.com
To:     vmolnaro@redhat.com, linux-perf-users@vger.kernel.org,
        acme@kernel.org, acme@redhat.com
Cc:     mpetlan@redhat.com
Subject: [PATCH 1/2] perf test stat+shadow_stat.sh: Add threshold for rounding errors
Date:   Tue, 19 Sep 2023 17:02:42 +0200
Message-ID: <20230919150419.23193-1-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Veronika Molnarova <vmolnaro@redhat.com>

The test was failing in specific scenarios due to imperfection of FP
arithmetics. The `bc` command wasn't correctly rounding the result of
division causing the failure.

Replace the `bc` with `awk` which should work with more decimal places
and add a threshold to catch any possible rounding errors.  The
acceptable rounding error is set to 0.01 when the test passes with a
warning message.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
Resending the patches with sign-off as it didn't go through last time,
also tried to fix the found issues.

 tools/perf/tests/shell/stat+shadow_stat.sh | 30 +++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 0e9cba84e75..6be3b4f80e5 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -4,6 +4,8 @@
 
 set -e
 
+THRESHOLD=0.015
+
 # skip if system-wide mode is forbidden
 perf stat -a true > /dev/null 2>&1 || exit 2
 
@@ -33,10 +35,18 @@ test_global_aggr()
 		fi
 
 		# use printf for rounding and a leading zero
-		res=`printf "%.2f" "$(echo "scale=6; $num / $cyc" | bc -q)"`
+		res=`echo $num $cyc | awk '{printf "%.2f", $1 / $2}'`
 		if [ "$ipc" != "$res" ]; then
-			echo "IPC is different: $res != $ipc  ($num / $cyc)"
-			exit 1
+			# check the difference from the real result for FP imperfections
+			diff=`echo $ipc $res $THRESHOLD | \
+			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
+
+			if [ $diff -eq 1 ]; then
+				echo "IPC is different: $res != $ipc  ($num / $cyc)"
+				exit 1
+			fi
+
+			echo "Warning: Difference of IPC is under the threshold"
 		fi
 	done
 }
@@ -67,10 +77,18 @@ test_no_aggr()
 		fi
 
 		# use printf for rounding and a leading zero
-		res=`printf "%.2f" "$(echo "scale=6; $num / $cyc" | bc -q)"`
+		res=`echo $num $cyc | awk '{printf "%.2f", $1 / $2}'`
 		if [ "$ipc" != "$res" ]; then
-			echo "IPC is different for $cpu: $res != $ipc  ($num / $cyc)"
-			exit 1
+			# check difference from the real result for FP imperfections
+			diff=`echo $ipc $res $THRESHOLD | \
+			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
+
+			if [ $diff -eq 1 ]; then
+				echo "IPC is different: $res != $ipc  ($num / $cyc)"
+				exit 1
+			fi
+
+			echo "Warning: Difference of IPC is under the threshold"
 		fi
 	done
 }
-- 
2.41.0

