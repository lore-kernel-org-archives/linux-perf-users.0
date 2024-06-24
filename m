Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965C13D600
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234537; cv=none; b=FayBi5v770abtqzhP48/PZqLtrL8I0vEs4E+2RBneidPw7sgnVPL9ZDkrMLCP+O/sVu6+MeCh6AEnALj5F+B4z49uSH2ReTAhMwPuv1TGmybGaCfylDqeP5FPZ++18b48FPEfmM4HOLXUtbc0+NowRRl74TOgeSiVnXVHZ4KIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234537; c=relaxed/simple;
	bh=SNQixkk2dI2K2omjTLx6x7oXdy83UonW6Nyd76j2Sio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RppsotnySID2s8fs3mAyGGaOr6hh8NiR95rkd/t2vEU1jYUDOG+1HZqaPCEd6RhLAm1UHibaZbz3ell3s3jvziYMI5HKvx+dtSu0x3//doOerj+MQGO3UXo0fPnSbeih/O373Xo64+xblvhw9N5bcbgRY+bnZc47wlj3pblCAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDHryRt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDHryRt1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=4yfLP96bzdw8ILZXZyIOLLxBMkEVNJMorHem0bRnJoc=;
	b=FDHryRt1e6wZNENMg+L7PXPT+QBuGLpSLbRJ6RrWmkJuB0PzB9UaiURcJxe/2Qy+VTF4/0
	VxX9MiONeVq2e/cGOAGpnxMBhHZe+J8VAyLlNhf1PEpnONF/gGeIIhSLiu1vui/CNIhenr
	UrpYEWo7JK9KKQj3faXu9P+CG1XbT8o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-RPAXeLF2PW6GTj2HKe_1ug-1; Mon,
 24 Jun 2024 09:08:50 -0400
X-MC-Unique: RPAXeLF2PW6GTj2HKe_1ug-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43ADA19560AF;
	Mon, 24 Jun 2024 13:08:49 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3502F1956087;
	Mon, 24 Jun 2024 13:08:45 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 06/11] perf testsuite probe: Add test for invalid options
Date: Mon, 24 Jun 2024 15:08:04 +0200
Message-Id: <20240624130809.1612-7-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

From: Veronika Molnarova <vmolnaro@redhat.com>

Test if various incompatible options are correctly handled-rejected.
It is run as a part of perftool-testsuite_probe test case.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../shell/base_probe/test_invalid_options.sh  | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/test_invalid_options.sh

diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
new file mode 100755
index 000000000000..1fedfd8b0d0d
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
+
+#
+#	test_invalid_options of perf_probe test
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test checks whether the invalid and incompatible options are reported
+#
+
+# include working environment
+. ../common/init.sh
+
+TEST_RESULT=0
+
+if ! check_kprobes_available; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### missing argument
+
+# some options require an argument
+for opt in '-a' '-d' '-L' '-V'; do
+	! $CMD_PERF probe $opt 2> $LOGS_DIR/invalid_options_missing_argument$opt.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Error: switch .* requires a value" < $LOGS_DIR/invalid_options_missing_argument$opt.err
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "missing argument for $opt"
+	(( TEST_RESULT += $? ))
+done
+
+
+### unnecessary argument
+
+# some options may omit the argument
+for opt in '-F' '-l'; do
+	$CMD_PERF probe -F > /dev/null 2> $LOGS_DIR/invalid_options_unnecessary_argument$opt.err
+	PERF_EXIT_CODE=$?
+
+	test ! -s $LOGS_DIR/invalid_options_unnecessary_argument$opt.err
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "unnecessary argument for $opt"
+	(( TEST_RESULT += $? ))
+done
+
+
+### mutually exclusive options
+
+# some options are mutually exclusive
+test -e $LOGS_DIR/invalid_options_mutually_exclusive.log && rm -f $LOGS_DIR/invalid_options_mutually_exclusive.log
+for opt in '-a xxx -d xxx' '-a xxx -L foo' '-a xxx -V foo' '-a xxx -l' '-a xxx -F' \
+		'-d xxx -L foo' '-d xxx -V foo' '-d xxx -l' '-d xxx -F' \
+		'-L foo -V bar' '-L foo -l' '-L foo -F' '-V foo -l' '-V foo -F' '-l -F'; do
+	! $CMD_PERF probe $opt > /dev/null 2> $LOGS_DIR/aux.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Error: switch .+ cannot be used with switch .+" < $LOGS_DIR/aux.log
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "mutually exclusive options :: $opt"
+	(( TEST_RESULT += $? ))
+
+	# gather the logs
+	cat $LOGS_DIR/aux.log | grep "Error" >> $LOGS_DIR/invalid_options_mutually_exclusive.log
+done
+
+
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
2.43.0

