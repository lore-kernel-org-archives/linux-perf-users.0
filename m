Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19721BB6B3
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792830; cv=none; b=FZsjBtI3qqEUmqDOoCqEhG53phXAW1QVq2CfB4vXRbnkZtbksRzSNqd0ZSorpW+OCipyFVYBpamaWssw7nK9wqfN7WmvXzHS7S7vAUQxgL0ROpIMTXPTK+uv7E5E+oV65URfVOw+bLyMGkVfd6JTOJKbsxB49Mj/yPNQN4Z/+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792830; c=relaxed/simple;
	bh=IO5SSy9yGN9ez+o4inQvSQyhoHVF3kQQgdjv+vpq1yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do8N1hxQXrNM5jCuL0Xf2sQIJvotS871vPnRtuau++uPuSis+Xa4I3lfFpiQMiRJKfXZ0fqgTyldY2Hqx2g1l58UwTy2PsAdHOZXJTWa8iUfXixHCXw/xOF+9Mv70ZEOUvNSH0/XAWmmc7XhdM/DNFBavKhQ55/cOxiDpBkKU7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtexWxTW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtexWxTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736792827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ox4QFeoIlB8yMvVMUnjPRi7APZkRaU74KoxBbfWdo/Y=;
	b=PtexWxTWa2MGY4mW6sXI3jrTDU9fBKweC3ul4Neckb8RQrRGmmljPO5INjZiEvkLv4t5pq
	aFjOYcj5D7UjtyCjKen/LdMYsD/JD4ZjGjXHMId6cWKqVL0uV0WSIZ7/oepHHagyQchNy7
	+yjDT1i1fIYRsnw7Ms4Bmqf63QOHjFY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-haGVms8KP7qarL5pHqhw4Q-1; Mon,
 13 Jan 2025 13:27:04 -0500
X-MC-Unique: haGVms8KP7qarL5pHqhw4Q-1
X-Mimecast-MFC-AGG-ID: haGVms8KP7qarL5pHqhw4Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 868B21955DDB;
	Mon, 13 Jan 2025 18:27:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AE6B19560AD;
	Mon, 13 Jan 2025 18:27:00 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	mpetlan@redhat.com,
	namhyung@kernel.org
Cc: irogers@google.com
Subject: [PATCH v2 10/10] perf test: Remove perftool drivers
Date: Mon, 13 Jan 2025 19:26:05 +0100
Message-ID: <20250113182605.130719-11-vmolnaro@redhat.com>
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

The perf now provides all of the features required for running the
perftool test cases, such as creating log directories, running setup scripts
and the tests are structured by the base_ directories.

Remove the drivers as they are no longer necessary together with
the condition of skipping the base_ directories and run the
test cases by the default perf test structure.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 .../tests/shell/perftool-testsuite_probe.sh   | 23 -------------------
 .../tests/shell/perftool-testsuite_report.sh  | 23 -------------------
 tools/perf/tests/tests-scripts.c              |  2 --
 3 files changed, 48 deletions(-)
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_probe.sh
 delete mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh

diff --git a/tools/perf/tests/shell/perftool-testsuite_probe.sh b/tools/perf/tests/shell/perftool-testsuite_probe.sh
deleted file mode 100755
index 7b1bfd0f888fc30c..0000000000000000
--- a/tools/perf/tests/shell/perftool-testsuite_probe.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/bash
-# perftool-testsuite_probe (exclusive)
-# SPDX-License-Identifier: GPL-2.0
-
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
index a8cf75b4e77ec1a3..0000000000000000
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
index 91ef0b47d2a8425c..e09a52c0f692dcfe 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -413,8 +413,6 @@ static void append_suits_in_dir(int dir_fd,
 			if (!S_ISDIR(st.st_mode))
 				continue;
 		}
-		if (strncmp(ent->d_name, "base_", 5) == 0)
-			continue; /* Skip scripts that have a separate driver. */
 
 		/* Scan subdir for test cases*/
 		fd = openat(dir_fd, ent->d_name, O_PATH);
-- 
2.43.0

