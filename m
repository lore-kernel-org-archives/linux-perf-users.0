Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E31D13D51D
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234519; cv=none; b=CRnhY6cM7xDe2b2A1A0HTTO5hH6kTOT+2W+duh24uSBvt4ZgL+Hox5NUee9ahOKssUzgILPx6CyZu3Wo8HBx5jA4e0021PGxcZmrOE4dtQjZO6aTk8qoI56qIl3ykJMM7UdhzbNWNoblKRFKLX9ch7+36DzpTpkjMQ6EbU3JyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234519; c=relaxed/simple;
	bh=ah5nxhv6gC+AxiMf2wcSJxIF1701+DVa/FruqbmKFj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IB27hivZy5oxHOFDakoX6kamRNe9F8aVKsm3UicJ3C3rZxXKX0uvsU75Prl3VvFByEh/LI+If2m7/zP+JS4X4MFWH/iffC6cpPE1DP+Hh6C9MYiIcQK2COKFnfVr17aPm7Np7zYl6zDBdnBfd6+nZ6lVIw7G1D2XrqUZRpXTh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARrte9Bj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARrte9Bj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=4/PIUUoMw/VVSasGiALBxVMOaWa897I1V3rEk1Qav6U=;
	b=ARrte9BjY+MndGsfCSIEwKKdNO4cthZ/n8BMAZOTr5DCSRatejvK2CIJMoKZppGFtHW0aN
	39v9xKAwF9uy+lWKFJRNYcw5j9Sn8sLaecqVMtWdRJge37ziWP0zJL7dIGFVJoYHQEKbWX
	hGcXoiIGLoUySxRUIeQJYKx8rN7373Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-atu6CUhBO2mJYBf_QY6h3g-1; Mon,
 24 Jun 2024 09:08:33 -0400
X-MC-Unique: atu6CUhBO2mJYBf_QY6h3g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60E6919560BD;
	Mon, 24 Jun 2024 13:08:32 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67D7E19560AB;
	Mon, 24 Jun 2024 13:08:29 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 02/11] perf testsuite: Merge settings files for shell tests
Date: Mon, 24 Jun 2024 15:08:00 +0200
Message-Id: <20240624130809.1612-3-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
index 123621c7f95e..000000000000
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
index 63bb8974b38e..3363f8c57e46 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -15,10 +15,7 @@
 
 # include working environment
 . ../common/init.sh
-. ./settings.sh
 
-# shellcheck disable=SC2034 # the variable is later used after the working environment is included
-THIS_TEST_NAME=`basename $0 .sh`
 TEST_RESULT=0
 
 TEST_PROBE=${TEST_PROBE:-"inode_permission"}
diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index aadeaf782e03..b99fba50ba94 100644
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
index 361641dbaaad..dcdb7d49ac00 100644
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

