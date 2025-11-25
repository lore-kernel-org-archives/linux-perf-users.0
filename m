Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26E1D8DFB
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086235; cv=none; b=b24efKFMHg+nSIf6togqTzHhxd9AHW+2zElfY2g8BAU/CWpvnqVb4nEFYJG1WCCUbCtwScRnWZffuANhi5DNnYo0x74uf4r7BHIZkqSohhTdykWcnf0dF3EXcLYrwVMNZwrO3OnUVndxCl4F3OhBbIuk2jc7e29bUdaK5JuqSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086235; c=relaxed/simple;
	bh=mx11cuJrd4d0h3K2UazuqCM7UKaB8U32a6M8KA3DKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8vGfF/u8cs6/dZJ+XIZkksGulb5UPhTlkr+1/lMelPFGDbGcxrJO1ioGAuln0YbQrd02hOOZSfgU+ANSMvGvE+IcFYhwPx2L7K1KPYCbYD2dcrFUnl+22VW2PgljYJ/WppD53uZmjUGmywJehdsI7pfJjECacckurEd+g30aLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnCZ32+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnCZ32+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764086230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6FMJzain/i6CspkJHYvCRU7S57sjeal6IegpAq1S34=;
	b=FnCZ32+7LaFhA5Swfi2mgvyLkDZgFqp39mncqVsve7XHQRExkJf79gk9fddopjmPuRNItk
	sUPh9m3yHiA0gWTcUSReO7NqSTQ2vlO/2dfJeJZNuLTJ3fD0zBUwG1TaMiRyY3fNzvXIDT
	wUT9pH1VcW7PF+V58uWGEnPLRGCjC0I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-E1VU7FfROnm4kBZxxeHG3g-1; Tue,
 25 Nov 2025 10:57:07 -0500
X-MC-Unique: E1VU7FfROnm4kBZxxeHG3g-1
X-Mimecast-MFC-AGG-ID: E1VU7FfROnm4kBZxxeHG3g_1764086226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 786811956046;
	Tue, 25 Nov 2025 15:57:06 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E4ED180049F;
	Tue, 25 Nov 2025 15:57:04 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v5 6/7] perf test: Remove perftool drivers
Date: Tue, 25 Nov 2025 16:56:47 +0100
Message-ID: <20251125155648.197527-7-jbrnak@redhat.com>
In-Reply-To: <20251125155648.197527-1-jbrnak@redhat.com>
References: <20251125155648.197527-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index bf974e4b9051..4ec6423114c1 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -424,9 +424,6 @@ static void append_suites_in_dir(int dir_fd,
 		if (!is_directory_fd(dir_fd, ent))
 			continue;
 
-		if (strncmp(ent->d_name, "base_", 5) == 0)
-			continue; /* Skip scripts that have a separate driver. */
-
 		/* Scan subdir for test cases*/
 		fd = openat(dir_fd, ent->d_name, O_PATH);
 		test_suite = prepare_test_suite(fd);	/* Prepare a testsuite with its path */
-- 
2.51.1

