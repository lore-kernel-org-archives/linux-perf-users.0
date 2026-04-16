Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1B3921D5
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338083; cv=none; b=G46yAGBVEFO2G6C60iwpEshBclJSiMixWeIucWEOm0V1YoVjc+T1ci08C/EL2aPA8Wy/TnqgL2NKd0PKAOqqNvJYhiALKZ+U2w2fjAB4YkQAXvDHFojyEnAL3zy6QnbMmqBuyloBj4P66h8CavhoR2cQrNVDeHTI0zokOy12gE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338083; c=relaxed/simple;
	bh=GfGH2TBBeD22KJW6Y2vl52U9g9KqMNavzPvYUU4ATmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXcxFeHhHIvsaV2nEBOfj17kRFXupOCdxokvFtth2Nhk9h+WyC9mgyOrSEApiEexSppBaBlVSNUpXriXG3Igzl/2BvG63NwEsjZ3sL9jOAON9qVchehrHV5HSLLpAgaXRPxEIQXy0XiLdeeAZIgOjpp0kG0GopihVsgmO/XySK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpa2+S9M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpa2+S9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776338080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgeXs72aZfzV9xIgQzmwifwEGyYz0fq1uwHx9mIIifY=;
	b=bpa2+S9MAtnQIB6Zk5EdugZhmWvxrR7WE0uVr8qel/jIsDA1l634EWbGnJ8zVF+GzfAnKV
	sisCAmAtC+pS0J50lB1cngHIYOY+z4Xrkd0w2RddoWhVnKWUmrSSF53CQwVaGS0nYRU7rn
	BcyJZedK6ejryqm4v91Ih+rjC+bnriI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-zB7orW2aMH-vHb3tT7ZDmA-1; Thu,
 16 Apr 2026 07:14:39 -0400
X-MC-Unique: zB7orW2aMH-vHb3tT7ZDmA-1
X-Mimecast-MFC-AGG-ID: zB7orW2aMH-vHb3tT7ZDmA_1776338078
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 950FD195608D;
	Thu, 16 Apr 2026 11:14:38 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.44.34.208])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A57718004AD;
	Thu, 16 Apr 2026 11:14:36 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v7 6/7] perf test: Remove perftool drivers
Date: Thu, 16 Apr 2026 13:14:18 +0200
Message-ID: <20260416111419.385010-7-jbrnak@redhat.com>
In-Reply-To: <20260416111419.385010-1-jbrnak@redhat.com>
References: <20260416111419.385010-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The perf now provides all of the features required for running the
perftool test cases, such as creating log directories, running
setup scripts and the tests are structured by the base_ directories.

Remove the drivers as they are no longer necessary together with
the condition of skipping the base_ directories and run the
test cases by the default perf test structure.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 .../tests/shell/perftool-testsuite_probe.sh   | 24 -------------------
 .../tests/shell/perftool-testsuite_report.sh  | 23 ------------------
 tools/perf/tests/tests-scripts.c              |  3 ---
 3 files changed, 50 deletions(-)
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/perf/tests/shell/perftool-testsuite_probe.sh
deleted file mode 100755
index 3863df16c19b..000000000000
--- a/tools/perf/tests/shell/perftool-testsuite_probe.sh
+++ /dev/null
@@ -1,24 +0,0 @@
-#!/bin/bash
-# perftool-testsuite_probe (exclusive)
-# SPDX-License-Identifier: GPL-2.0
-
-[ "$(id -u)" = 0 ] || exit 2
-test -d "$(dirname "$0")/base_probe" || exit 2
-cd "$(dirname "$0")/base_probe" || exit 2
-status=0
-
-PERFSUITE_RUN_DIR=$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)
-export PERFSUITE_RUN_DIR
-
-for testcase in setup.sh test_*; do                  # skip setup.sh if not present or not executable
-     test -x "$testcase" || continue
-     ./"$testcase"
-     (( status += $? ))
-done
-
-if ! [ "$PERFTEST_KEEP_LOGS" = "y" ]; then
-	rm -rf "$PERFSUITE_RUN_DIR"
-fi
-
-test $status -ne 0 && exit 1
-exit 0
diff --git a/tools/perf/tests/shell/perftool-testsuite_report.sh b/tools/perf/tests/shell/perftool-testsuite_report.sh
deleted file mode 100755
index a8cf75b4e77e..000000000000
--- a/tools/perf/tests/shell/perftool-testsuite_report.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash
-# perftool-testsuite_report (exclusive)
-# SPDX-License-Identifier: GPL-2.0
-
-test -d "$(dirname "$0")/base_report" || exit 2
-cd "$(dirname "$0")/base_report" || exit 2
-status=0
-
-PERFSUITE_RUN_DIR=$(mktemp -d /tmp/"$(basename "$0" .sh)".XXX)
-export PERFSUITE_RUN_DIR
-
-for testcase in setup.sh test_*; do                  # skip setup.sh if not present or not executable
-     test -x "$testcase" || continue
-     ./"$testcase"
-     (( status += $? ))
-done
-
-if ! [ "$PERFTEST_KEEP_LOGS" = "y" ]; then
-	rm -rf "$PERFSUITE_RUN_DIR"
-fi
-
-test $status -ne 0 && exit 1
-exit 0
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index fc5e1b835ecc..a83e30ee4a09 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -487,9 +487,6 @@ static void append_suites_in_dir(int dir_fd,
 		if (!is_directory_fd(dir_fd, ent))
 			continue;
 
-		if (strncmp(ent->d_name, "base_", 5) == 0)
-			continue; /* Skip scripts that have a separate driver. */
-
 		/* Scan subdir for test cases */
 		fd = openat(dir_fd, ent->d_name, O_PATH);
 		if (fd < 0)
-- 
2.52.0

