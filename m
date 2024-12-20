Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA652198845
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732233; cv=none; b=ojqizXDGwUX9BQg/KT3OnKHKfxgDYnyNjSKrJg3/U86gf4ThqCxdWSN+YoLWB6COx6VnrHtqjeo2kIWpFMP1lovj0njkFFp13S6IK5VGBGR7RE4phrlbWHoTIHy038dGQctl2JDOH+uwmKdVR30ml1rN9syjptPHgJE/Rl/eEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732233; c=relaxed/simple;
	bh=Kt7zm+nWmtFM7COfOGBlpYcq3DmTSdVBDsL4JIDSXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tnyyz3euZM/h9SXFo1yy124mtcuhYNwck2aLbQE6qqbOmqFRQWKVYux8WJL0+SFJeOtkYQeO47803MEmQFLpz7gvly/ShKvz0a6i2mxOJZNLYECaLp847b1pRW9bqrG6gY45QnLbb77KYRzmTUJJpYROkh8/yxEeWZXMFInxyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxitnO8c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxitnO8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkhtOujpzyP9JOv6iLRi6gSemvjUb0FRmv0IA5Xr3Lw=;
	b=PxitnO8cTA2FW/C8dk6KlRT/N44K4OnIehklUXbLJyxnWhLwN2wnrwbTLuZbazblwY/gW2
	vhX6OFVhFIiCh/wBrsvPxnRsQ1jhEGK5z5l1m9URnQ9fBQG5nieZ2kM0mNQoDANuBJ3X5X
	XQ/ZZhqlEZ69YJcEzatZoPOTwJLuImM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-Jhwc5Jj8PsyqOaYmBTNkeQ-1; Fri,
 20 Dec 2024 17:03:49 -0500
X-MC-Unique: Jhwc5Jj8PsyqOaYmBTNkeQ-1
X-Mimecast-MFC-AGG-ID: Jhwc5Jj8PsyqOaYmBTNkeQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FFF01955F45;
	Fri, 20 Dec 2024 22:03:48 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B2A419560A2;
	Fri, 20 Dec 2024 22:03:46 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 02/10] perf test perftool_testsuite: Return correct value for skipping
Date: Fri, 20 Dec 2024 23:03:26 +0100
Message-ID: <20241220220334.69198-3-vmolnaro@redhat.com>
In-Reply-To: <20241220220334.69198-1-vmolnaro@redhat.com>
References: <20241220220334.69198-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

In 'perf test', a return value 2 represents that the test case was
skipped. Fix this value for perftool_testsuite test cases to
differentiate between skip and pass values.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh | 2 +-
 tools/perf/tests/shell/base_probe/test_adding_kernel.sh      | 2 +-
 tools/perf/tests/shell/base_probe/test_basic.sh              | 2 +-
 tools/perf/tests/shell/base_probe/test_invalid_options.sh    | 2 +-
 tools/perf/tests/shell/base_probe/test_line_semantics.sh     | 2 +-
 tools/perf/tests/shell/common/init.sh                        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
index 4204e941fad99269..45c21673643641b3 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
@@ -22,7 +22,7 @@ TEST_RESULT=0
 BLACKFUNC_LIST=`head -n 5 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
 if [ -z "$BLACKFUNC_LIST" ]; then
 	print_overall_skipped
-	exit 0
+	exit 2
 fi
 
 # try to find vmlinux with DWARF debug info
diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index c276c2a3fc26ecde..24fe91550c672cc2 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -33,7 +33,7 @@ fi
 check_kprobes_available
 if [ $? -ne 0 ]; then
 	print_overall_skipped
-	exit 0
+	exit 2
 fi
 
 
diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
index a69dc1c9f92c1b96..9d8b5afbeddda268 100755
--- a/tools/perf/tests/shell/base_probe/test_basic.sh
+++ b/tools/perf/tests/shell/base_probe/test_basic.sh
@@ -19,7 +19,7 @@ TEST_RESULT=0
 
 if ! check_kprobes_available; then
 	print_overall_skipped
-	exit 0
+	exit 2
 fi
 
 
diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
index 491eae7ba09574b9..59757a00e6d3e40a 100755
--- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -19,7 +19,7 @@ TEST_RESULT=0
 
 if ! check_kprobes_available; then
 	print_overall_skipped
-	exit 0
+	exit 2
 fi
 
 
diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
index 83f2db898d795c5a..da8999be4604e9d6 100755
--- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
+++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
@@ -20,7 +20,7 @@ TEST_RESULT=0
 
 if ! check_kprobes_available; then
 	print_overall_skipped
-	exit 0
+	exit 2
 fi
 
 
diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index 075f17623c8eaad0..13ec38c15c014252 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -85,7 +85,7 @@ consider_skipping()
 	# the runmode of a testcase needs to be at least the current suite's runmode
 	if [ $PERFTOOL_TESTSUITE_RUNMODE -lt $TESTCASE_RUNMODE ]; then
 		print_overall_skipped
-		exit 0
+		exit 2
 	fi
 }
 
-- 
2.43.0

