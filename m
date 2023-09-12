Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B0BCA0ECA
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 12:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjILMUY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjILMUV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 08:20:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC08810D2
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694521170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYCud5TTTXD52ydxJR0TroJhA01q5jw7zVV5G1QYWwM=;
        b=O1aO5MHf2TVPDbyd/Ar48bQEWIxawhXsFSp7i4EVxCGzGGjdE8ChynbHPRNexlgRqKkGTV
        DK3The6i9oUv9G0/iI+HDI7x43Xos4k9iPwrqeaWEm+Qg3rVoLXupaSK78c7cBlLLbdX4o
        U8+ZGyyzw5iCMYwvFHmpLoZW5UH7S8I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-2xY1DNxtNfabCLeF1FhJqw-1; Tue, 12 Sep 2023 08:19:29 -0400
X-MC-Unique: 2xY1DNxtNfabCLeF1FhJqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 154193800BCD;
        Tue, 12 Sep 2023 12:19:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5994F1006E0B;
        Tue, 12 Sep 2023 12:19:28 +0000 (UTC)
From:   vmolnaro@redhat.com
To:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Cc:     mpetlan@redhat.com
Subject: [PATCH 2/2] perf test stat+shadow_stat.sh: Add threshold for rounding errors
Date:   Tue, 12 Sep 2023 14:19:26 +0200
Message-ID: <20230912121926.12111-2-vmolnaro@redhat.com>
In-Reply-To: <20230912121926.12111-1-vmolnaro@redhat.com>
References: <20230912121926.12111-1-vmolnaro@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Veronika Molnarova <vmolnaro@redhat.com>

The test was failing in specific scenarios due to imperfection of FP
arithmetics. The `bc` command wasn't correctly rounding the result
of division causing the failure.

Replace the `bc` with `awk` which should work with more decimal
places and add a threshold to catch any possible rounding errors.
The acceptable rounding error is set to 0.01 when the test
passes with a warning message.
---
 tools/perf/tests/shell/stat+shadow_stat.sh | 30 +++++++++++++++++-----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/stat+shadow_stat.sh b/tools/perf/tests/shell/stat+shadow_stat.sh
index 0e9cba84e75..73c990fe5ee 100755
--- a/tools/perf/tests/shell/stat+shadow_stat.sh
+++ b/tools/perf/tests/shell/stat+shadow_stat.sh
@@ -4,6 +4,8 @@
 
 set -e
 
+TRESHOLD=0.015
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
+			diff=`echo $ipc $res $TRESHOLD | \
+			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
+
+			if [ $diff -eq 1 ]; then
+				echo "IPC is different: $res != $ipc  ($num / $cyc)"
+				exit 1
+			fi
+
+			echo "Warning: Difference of IPC is under the treshold"
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
+			diff=`echo $ipc $res $TRESHOLD | \
+			awk '{x = ($1 - $2) < 0 ? ($2 - $1) : ($1 - $2); print (x > $3)}'`
+
+			if [ $diff -eq 1 ]; then
+				echo "IPC is different: $res != $ipc  ($num / $cyc)"
+				exit 1
+			fi
+
+			echo "Warning: Difference of IPC is under the treshold"
 		fi
 	done
 }
-- 
2.41.0

