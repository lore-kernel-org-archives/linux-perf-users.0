Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8715AAC1
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918832; cv=none; b=WK0z+dHBaOAF0Yl0BexsVnM0RAg7Um+CXUT8u3kyEq6ibDCbtILqF9Ar3agursnAxM9EX0nd3YCtdD2FiDg2RmbP0VghnvNR82lOQ/QTjZTPUf2NXoZBEwwcWvlIB/Cckfb86hOP1rLU8WAfFbwcjLJZSFV6t9cse4YA/gQhDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918832; c=relaxed/simple;
	bh=K/JFy6JZrByr4X6e+GC8VI71SLXinS7qiD2eIvTFy98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvsggCevETmz7fZPd9oI9WT9OLQ3iH5obj1cfAWjgMH6RK3ZpoXMll56Vtt4bXso0MABG+pON2nl0KPn9E27t6L/VCMKkpFszi9EN0ilMifyxAcPWL6yKl/VNF/IDrS/oLXayDwBmzenX0H63fki0ayd24kGaf38PpPWVgaAG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/lb8jTA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/lb8jTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egd9NYINBVrjgvg2t4qazisJdPqm9eKa0p/aKDwcv6o=;
	b=a/lb8jTAIOORv3hB5KGVeQxc242pCrZbi+Arkxivfh1TFltNjmvFCSw/kA1CJ5ivenvAGB
	RvyZxQ95ks3V3/RRoJ+bBZp3Avn58rNva8U36gdzjkDS0xOp+DwO7xou/KGj2PbMAPGyE/
	LJiR080O2gUNj//53vLOSOtbEnvjJnU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-IXjDJb4KNAGL5SsDo3Sikw-1; Tue,
 02 Jul 2024 07:13:47 -0400
X-MC-Unique: IXjDJb4KNAGL5SsDo3Sikw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C34B1955F1D;
	Tue,  2 Jul 2024 11:13:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35CA61956089;
	Tue,  2 Jul 2024 11:13:42 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 05/11] perf testsuite probe: Add test for basic perf-probe options
Date: Tue,  2 Jul 2024 13:08:44 +0200
Message-ID: <20240702110849.31904-7-vmolnaro@redhat.com>
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

Test basic behavior of perf-probe subcommand. It is run as a part of
perftool-testsuite_probe test case.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../perf/tests/shell/base_probe/test_basic.sh | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/test_basic.sh

diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
new file mode 100755
index 0000000000..09669ec479
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/test_basic.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
+
+#
+#	test_basic of perf_probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#
+#	Description:
+#
+#		This test tests basic functionality of perf probe command.
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
+### help message
+
+if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
+	# test that a help message is shown and looks reasonable
+	$CMD_PERF probe --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR/basic_helpmsg.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-PROBE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYNTAX" < $LOGS_DIR/basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "LAZY\s+MATCHING" "FILTER\s+PATTERN" "EXAMPLES" "SEE\s+ALSO" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "vmlinux" "module=" "source=" "verbose" "quiet" "add=" "del=" "list.*EVENT" "line=" "vars=" "externs" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "no-inlines" "funcs.*FILTER" "filter=FILTER" "force" "dry-run" "max-probes" "exec=" "demangle-kernel" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_no_patterns_found.pl "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
+	(( CHECK_EXIT_CODE += $? ))
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
+	(( TEST_RESULT += $? ))
+else
+	print_testcase_skipped "help message"
+fi
+
+
+### usage message
+
+# without any args perf-probe should print usage
+$CMD_PERF probe 2> $LOGS_DIR/basic_usage.log > /dev/null
+
+../common/check_all_patterns_found.pl "[Uu]sage" "perf probe" "verbose" "quiet" "add" "del" "force" "line" "vars" "externs" "range" < $LOGS_DIR/basic_usage.log
+CHECK_EXIT_CODE=$?
+
+print_results 0 $CHECK_EXIT_CODE "usage message"
+(( TEST_RESULT += $? ))
+
+
+### quiet switch
+
+# '--quiet' should mute all output
+$CMD_PERF probe --quiet --add vfs_read > $LOGS_DIR/basic_quiet01.log 2> $LOGS_DIR/basic_quiet01.err
+PERF_EXIT_CODE=$?
+$CMD_PERF probe --quiet --del vfs_read > $LOGS_DIR/basic_quiet03.log 2> $LOGS_DIR/basic_quiet02.err
+(( PERF_EXIT_CODE += $? ))
+
+test "`cat $LOGS_DIR/basic_quiet*log $LOGS_DIR/basic_quiet*err | wc -l`" -eq 0
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "quiet switch"
+(( TEST_RESULT += $? ))
+
+
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
2.43.0

