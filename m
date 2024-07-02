Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A013158DDD
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918825; cv=none; b=Qcq1lxqqeCJPZqRwLwk1FYSn8uWs2I9H/5IOILZX3XxD02f10tpKhHVN1cyiSART+VqK1M6pBKutI8b5Id2JaJD6RveB3JNPbOk54zmALNFE/FcyAPWvbCYgzmRj6CsmjgvHdD73T1Dq+/Dft1okPoNpuWmpp4fCfxfZVjEPmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918825; c=relaxed/simple;
	bh=UOm55pnw9jfEkrPipkHCvxt/lvwwLNwK6zRqeG9kYEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaPkCmJq9l8zT7ynaAaP5T3HZZaKZ3CpjmeuUQesW9vbHtTZj70gc/ZE0boxrzm9ZCokG/7g1XAgKMuND/cD84tF0yMspZcq+BHB8oq+trPtMi3pFA60kS5OB+GUB9/okhlg+77En8vMyJFp4DhVerGwGETP9Lfx/o8tq0oHIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGCaV/3U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGCaV/3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MA6OZauhM2FC1vrvGXjZw8Ww7yWO7RNrRlgWMibeH6A=;
	b=OGCaV/3UIq/uxQ0uN9kFDChInUK/PWwrzo2CNtCwD1JaUn39N2CuAMwcMgxbFXmnJbBdIb
	wf9tzr4q+qVAP/OAp5X5sPDoNaQpQO0W8VQkEzPsV9iDFznHJ9wQ4XAtgwSyMG2HERSbN6
	tWPP4a0sCK1Mzzg8HCDRc+j4zhEAPio=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-WMoQZrVnNSitAVkXhu-VCw-1; Tue,
 02 Jul 2024 07:13:40 -0400
X-MC-Unique: WMoQZrVnNSitAVkXhu-VCw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57793195C272;
	Tue,  2 Jul 2024 11:13:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70C601956089;
	Tue,  2 Jul 2024 11:13:35 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 03/11] perf testsuite: Fix shellcheck warnings
Date: Tue,  2 Jul 2024 13:08:42 +0200
Message-ID: <20240702110849.31904-5-vmolnaro@redhat.com>
In-Reply-To: <20240702110849.31904-1-vmolnaro@redhat.com>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Veronika Molnarova <vmolnaro@redhat.com>

Shellcheck is becoming a standard when building perf to prevent
any unnecessary mistakes. Fix shellcheck warnings in perf testsuite.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/common/init.sh     | 8 ++++----
 tools/perf/tests/shell/common/settings.sh | 9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index b99fba50ba..075f17623c 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -26,8 +26,8 @@ print_results()
 	PERF_RETVAL="$1"; shift
 	CHECK_RETVAL="$1"; shift
 	FAILURE_REASON=""
-	TASK_COMMENT="$@"
-	if [ $PERF_RETVAL -eq 0 -a $CHECK_RETVAL -eq 0 ]; then
+	TASK_COMMENT="$*"
+	if [ $PERF_RETVAL -eq 0 ] && [ $CHECK_RETVAL -eq 0 ]; then
 		_echo "$MPASS-- [ PASS ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT"
 		return 0
 	else
@@ -56,7 +56,7 @@ print_overall_results()
 
 print_testcase_skipped()
 {
-	TASK_COMMENT="$@"
+	TASK_COMMENT="$*"
 	_echo "$MSKIP-- [ SKIP ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT :: testcase skipped"
 	return 0
 }
@@ -69,7 +69,7 @@ print_overall_skipped()
 
 print_warning()
 {
-	WARN_COMMENT="$@"
+	WARN_COMMENT="$*"
 	_echo "$MWARN-- [ WARN ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $WARN_COMMENT"
 	return 0
 }
diff --git a/tools/perf/tests/shell/common/settings.sh b/tools/perf/tests/shell/common/settings.sh
index dcdb7d49ac..2e50dd0bff 100644
--- a/tools/perf/tests/shell/common/settings.sh
+++ b/tools/perf/tests/shell/common/settings.sh
@@ -45,7 +45,7 @@ export TEST_IGNORE_MISSING_PMU=${TEST_IGNORE_MISSING_PMU:-n}
 export LC_ALL=C
 
 #### colors
-if [ -t 1 -o "$TESTLOG_FORCE_COLOR" = "yes" ]; then
+if [ -t 1 ] || [ "$TESTLOG_FORCE_COLOR" = "yes" ]; then
 	export MPASS="\e[32m"
 	export MALLPASS="\e[1;32m"
 	export MFAIL="\e[31m"
@@ -68,15 +68,15 @@ fi
 ### general info
 DIR_PATH=`dirname "$(readlink -e "$0")"`
 
-export TEST_NAME=`basename $DIR_PATH | sed 's/base/perf/'`
-export MY_ARCH=`arch`
+TEST_NAME=`basename $DIR_PATH | sed 's/base/perf/'`; export TEST_NAME
+MY_ARCH=`arch`; export MY_ARCH
 
 # storing logs and temporary files variables
 if [ -n "$PERFSUITE_RUN_DIR" ]; then
 	# when $PERFSUITE_RUN_DIR is set to something, all the logs and temp files will be placed there
 	# --> the $PERFSUITE_RUN_DIR/perf_something/examples and $PERFSUITE_RUN_DIR/perf_something/logs
 	#     dirs will be used for that
-	export PERFSUITE_RUN_DIR=`readlink -f $PERFSUITE_RUN_DIR`
+	PERFSUITE_RUN_DIR=`readlink -f $PERFSUITE_RUN_DIR`; export PERFSUITE_RUN_DIR
 	export CURRENT_TEST_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME"
 	export MAKE_TARGET_DIR="$CURRENT_TEST_DIR/examples"
 	export LOGS_DIR="$CURRENT_TEST_DIR/logs"
@@ -93,6 +93,7 @@ fi
 if [ ! -d ./common ]; then
 	# set parameters based on runmode
 	if [ -f ../common/parametrization.$PERFTOOL_TESTSUITE_RUNMODE.sh ]; then
+		# shellcheck source=/dev/null
 		. ../common/parametrization.$PERFTOOL_TESTSUITE_RUNMODE.sh
 	fi
 	# if some parameters haven't been set until now, set them to default
-- 
2.43.0

