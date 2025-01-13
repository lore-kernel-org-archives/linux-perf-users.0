Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFD1C4A26
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792811; cv=none; b=WQFcc69Hdo5odJwQ8n3RoVrfbm7n0IlDEQia65jNGsAHm4xgonECkBLNrAqQbGCs1W4PMvQTyly8RXFJ5QB/Vvi5IopfBy5qf5djMo382k1qZSuKBUuVGjtCn0r/bDKAznApx4O0XUutXbehLRUPa9eSCzRXPJi0jcvpA0raR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792811; c=relaxed/simple;
	bh=+2cS1Gs/EwTxCBLR3CCBCXLUD4eq0xhHz8i/zki1XWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0zpuT77ZQ1HQne6Yg+pdqvUwnVDTNEUetUJof+MgKL8YBM5c0kPKAkCvOMcjxwVI0o5hjqpFyGZUDCOtNf0xbTSkp+O5gkn6VNfQYrUHSmmnP5jSwtMJzNni7tB2NtIUzT3hp4YY9jiP9KBRz+uxq3B+8M3LzrZqVAm/TtKoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUtSA3oU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUtSA3oU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736792808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwuir3JvJnHapvVQX584MCGjTGQ3ocSIYyZpmkpdsn0=;
	b=YUtSA3oUA3oAL7jR3v/CzBK4++hFv4kOXgDa9KDbuZDr3Cgk3VqCQd5BGhUKcJL/ccvTnc
	Ar8E21GIZt8yJ4GxEWi4MCaJ+kVClMAmDIEijVzCGQTsyYmSAQhnKScRtsvtgyAg53Kiym
	Qn6DhIssf+Ujwgcgpqjp0kVzLS17epM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-YKoWRhqDN2q4hIRjGMLcBA-1; Mon,
 13 Jan 2025 13:26:42 -0500
X-MC-Unique: YKoWRhqDN2q4hIRjGMLcBA-1
X-Mimecast-MFC-AGG-ID: YKoWRhqDN2q4hIRjGMLcBA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80DEB19560B8;
	Mon, 13 Jan 2025 18:26:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20EA219560AD;
	Mon, 13 Jan 2025 18:26:37 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	mpetlan@redhat.com,
	namhyung@kernel.org
Cc: irogers@google.com
Subject: [PATCH v2 02/10] perf test perftool_testsuite: Return correct value for skipping
Date: Mon, 13 Jan 2025 19:25:57 +0100
Message-ID: <20250113182605.130719-3-vmolnaro@redhat.com>
In-Reply-To: <Z4UwHy-Kj9XDI9cf@x1>
References: <Z4UwHy-Kj9XDI9cf@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
index 8d1570c44a54ac75..92f7254eb32a31d0 100755
--- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -19,7 +19,7 @@ TEST_RESULT=0
 
 if ! check_kprobes_available; then
 	print_overall_skipped
-	exit 0
+	exit 2
 fi
 
 # Check for presence of DWARF
diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
index 2ab70a543087c543..20435b6bf6bc654d 100755
--- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
+++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
@@ -20,7 +20,7 @@ TEST_RESULT=0
 
 if ! check_kprobes_available; then
 	print_overall_skipped
-	exit 0
+	exit 2
 fi
 
 # Check for presence of DWARF
diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index 259706ef58994bf9..26c7525651e084fc 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -88,7 +88,7 @@ consider_skipping()
 	# the runmode of a testcase needs to be at least the current suite's runmode
 	if [ $PERFTOOL_TESTSUITE_RUNMODE -lt $TESTCASE_RUNMODE ]; then
 		print_overall_skipped
-		exit 0
+		exit 2
 	fi
 }
 
-- 
2.43.0

