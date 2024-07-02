Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1BE158DDD
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918820; cv=none; b=UVLeH5tSyyCGQieFhramSEVAuE6g6R89FkQ4+kO5Qsq92hvSC56W+Qmfowr+lRbnY9yFZ3Q15zG+IQnUTtTFcP88mHfh/U7ejld88rLv/kjudoJtCRZiF7XApkXQzey7OclV8rk2gjsqk/ONHQeQvkVrjPqYFox+bCbG+6QB/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918820; c=relaxed/simple;
	bh=Ap30hE8TXku1hKmJTKmSmSjPdAspwnEbQ1OSkRZUfnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAqm12s4DtFAug4D1aCDw64gT5//zRtauP7LtXOoluDx/Vv3IkU7vKf/Zm7T/70WRkV+wy3QlNGrF0Ry7kecgrMn0dNQAhXE3ldVF/959SPGresv3vjPRpwxplzQNPC2kS/VkmqIJU2HH6wR7eNDOMRtzfC4ymC11V2s+4K3dcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUVrMuS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUVrMuS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gszHvJpDqmOj3aPPl9+BuFeqEi0vBIrbLnY1zQXwoOg=;
	b=YUVrMuS4e+XSc4nRTPWB0kSHT30xWN10LlxqF/0/X3iyPTqbKY2+2TdcWF+EizeY9RgytA
	cGh0rLDLVMPFrDPrqLZo86xycBzUFLaJQKOakSiP55yeqjLCzf76dZdzRscUMGmW24reh3
	3H9EpvXiiyHb0S5DZWY/P95E6FwECAw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-s533TACqMjiWvvLHBeL2Ew-1; Tue,
 02 Jul 2024 07:13:36 -0400
X-MC-Unique: s533TACqMjiWvvLHBeL2Ew-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F28D519792E3;
	Tue,  2 Jul 2024 11:13:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05DF31956089;
	Tue,  2 Jul 2024 11:13:31 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 02/11] perf testsuite: Merge settings files for shell tests
Date: Tue,  2 Jul 2024 13:08:41 +0200
Message-ID: <20240702110849.31904-4-vmolnaro@redhat.com>
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

Merge perf testsuite setting files into common settings to reduce
duplicates and prevent errors.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/base_probe/settings.sh | 48 -------------------
 .../shell/base_probe/test_adding_kernel.sh    |  3 --
 tools/perf/tests/shell/common/init.sh         | 23 +++++++++
 tools/perf/tests/shell/common/settings.sh     | 23 +++++++++
 4 files changed, 46 insertions(+), 51 deletions(-)
 delete mode 100644 tools/perf/tests/shell/base_probe/settings.sh

diff --git a/tools/perf/tests/shell/base_probe/settings.sh b/tools/perf/tests/shell/base_probe/settings.sh
deleted file mode 100644
index 123621c7f9..0000000000
--- a/tools/perf/tests/shell/base_probe/settings.sh
+++ /dev/null
@@ -1,48 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-#	settings.sh of perf_probe test
-#	Author: Michael Petlan <mpetlan@redhat.com>
-#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
-#
-
-export TEST_NAME="perf_probe"
-
-export MY_ARCH=`arch`
-
-if [ -n "$PERFSUITE_RUN_DIR" ]; then
-	# when $PERFSUITE_RUN_DIR is set to something, all the logs and temp files will be placed there
-	# --> the $PERFSUITE_RUN_DIR/perf_something/examples and $PERFSUITE_RUN_DIR/perf_something/logs
-	#     dirs will be used for that
-	export PERFSUITE_RUN_DIR=`readlink -f $PERFSUITE_RUN_DIR`
-	export CURRENT_TEST_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME"
-	export MAKE_TARGET_DIR="$CURRENT_TEST_DIR/examples"
-	test -d "$MAKE_TARGET_DIR" || mkdir -p "$MAKE_TARGET_DIR"
-	export LOGS_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME/logs"
-	test -d "$LOGS_DIR" || mkdir -p "$LOGS_DIR"
-else
-	# when $PERFSUITE_RUN_DIR is not set, logs will be placed here
-	export CURRENT_TEST_DIR="."
-	export LOGS_DIR="."
-fi
-
-check_kprobes_available()
-{
-	test -e /sys/kernel/debug/tracing/kprobe_events
-}
-
-check_uprobes_available()
-{
-	test -e /sys/kernel/debug/tracing/uprobe_events
-}
-
-clear_all_probes()
-{
-	echo 0 > /sys/kernel/debug/tracing/events/enable
-	check_kprobes_available && echo > /sys/kernel/debug/tracing/kprobe_events
-	check_uprobes_available && echo > /sys/kernel/debug/tracing/uprobe_events
-}
-
-check_sdt_support()
-{
-	$CMD_PERF list sdt | grep sdt > /dev/null 2> /dev/null
-}
diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index 187dc8d4b1..d541ffd44a 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -15,10 +15,7 @@
 
 # include working environment
 . ../common/init.sh
-. ./settings.sh
 
-# shellcheck disable=SC2034 # the variable is later used after the working environment is included
-THIS_TEST_NAME=`basename $0 .sh`
 TEST_RESULT=0
 
 # shellcheck source=lib/probe_vfs_getname.sh
diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index aadeaf782e..b99fba50ba 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -115,3 +115,26 @@ detect_amd()
 	# 1 = is not AMD or unknown
 	grep "vendor_id" < /proc/cpuinfo | grep -q "AMD"
 }
+
+# base probe utility
+check_kprobes_available()
+{
+	test -e /sys/kernel/debug/tracing/kprobe_events
+}
+
+check_uprobes_available()
+{
+	test -e /sys/kernel/debug/tracing/uprobe_events
+}
+
+clear_all_probes()
+{
+	echo 0 > /sys/kernel/debug/tracing/events/enable
+	check_kprobes_available && echo > /sys/kernel/debug/tracing/kprobe_events
+	check_uprobes_available && echo > /sys/kernel/debug/tracing/uprobe_events
+}
+
+check_sdt_support()
+{
+	$CMD_PERF list sdt | grep sdt > /dev/null 2> /dev/null
+}
diff --git a/tools/perf/tests/shell/common/settings.sh b/tools/perf/tests/shell/common/settings.sh
index 361641dbaa..dcdb7d49ac 100644
--- a/tools/perf/tests/shell/common/settings.sh
+++ b/tools/perf/tests/shell/common/settings.sh
@@ -65,6 +65,29 @@ else
 	export MEND=""
 fi
 
+### general info
+DIR_PATH=`dirname "$(readlink -e "$0")"`
+
+export TEST_NAME=`basename $DIR_PATH | sed 's/base/perf/'`
+export MY_ARCH=`arch`
+
+# storing logs and temporary files variables
+if [ -n "$PERFSUITE_RUN_DIR" ]; then
+	# when $PERFSUITE_RUN_DIR is set to something, all the logs and temp files will be placed there
+	# --> the $PERFSUITE_RUN_DIR/perf_something/examples and $PERFSUITE_RUN_DIR/perf_something/logs
+	#     dirs will be used for that
+	export PERFSUITE_RUN_DIR=`readlink -f $PERFSUITE_RUN_DIR`
+	export CURRENT_TEST_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME"
+	export MAKE_TARGET_DIR="$CURRENT_TEST_DIR/examples"
+	export LOGS_DIR="$CURRENT_TEST_DIR/logs"
+	test -d "$CURRENT_TEST_DIR" || mkdir -p "$CURRENT_TEST_DIR"
+	test -d "$LOGS_DIR" || mkdir -p "$LOGS_DIR"
+else
+	# when $PERFSUITE_RUN_DIR is not set, logs will be placed here
+	export CURRENT_TEST_DIR="."
+	export LOGS_DIR="."
+fi
+
 
 #### test parametrization
 if [ ! -d ./common ]; then
-- 
2.43.0

