Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553E2D949E
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104428; cv=none; b=KwuKlQIKZbQpyeWXvfnk4tZt7sXLP2fB9tQ4WLXzN/olVQ7GBxgwRXxYQzLLqOQXrp9kqthgWHilss0/XQlqQKn3Aktni+WhsbUWdoWcY6GKzoNnovncz6Yk8kpxhtKmYyoyJXXRirRkzr9fK209Yi2uk0/kB4TQNbNl46qaLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104428; c=relaxed/simple;
	bh=P7NPumAKORKJ6IW8iLCy7JzMhZLLc9Ok/KbNQozvQ+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3VAHF2g7OghmNNxD5a05PBGzq537sDKDn7E2k9BPjYjcmfMHCmxTvUzdCcTT3x68ZwPUZPTBQwSopWuHve9YQtkzDJCgeyKF1w/yzciiLsf0rwZIFX8UAGftyq+CLiMpZCvf4Ilhl4mUsiUk4YS2yXfs9TrI7+AMzRbsdcPTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQebLeGW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQebLeGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urlDRoa/HN2b50unJaUlE1i+v4dnvMxmDXeKY5MU4XY=;
	b=aQebLeGWJhRHSC7mZ1nXdV6Nd8lJfslgIIqO5Wr4K3Z28Nkme09R0/TI+RODEAmct+YHul
	to+vLrO8VPcZO4W01JiGM9m84kzbG4gcNaPcP9eWsnGxXEegJTi9ypW4N0vRQL1BP0MeH1
	2EVX3A9YzGGv5ktfhVUKF8663y05oJQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-S-nKDxcVO22gIqdQlybIfw-1; Mon,
 21 Jul 2025 09:27:04 -0400
X-MC-Unique: S-nKDxcVO22gIqdQlybIfw-1
X-Mimecast-MFC-AGG-ID: S-nKDxcVO22gIqdQlybIfw_1753104423
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F2FD1800878;
	Mon, 21 Jul 2025 13:27:03 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80DEB19560AF;
	Mon, 21 Jul 2025 13:27:01 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: vmolnaro@redhat.com
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	namhyung@kernel.org
Subject: [PATCH v3 7/7] perf test: Remove perftool drivers
Date: Mon, 21 Jul 2025 15:26:42 +0200
Message-ID: <20250721132642.40906-8-jbrnak@redhat.com>
In-Reply-To: <20250721132642.40906-1-jbrnak@redhat.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

The perf now provides all of the features required for running the
perftool test cases, such as creating log directories, running setup scripts
and the tests are structured by the base_ directories.

Remove the drivers as they are no longer necessary together with
the condition of skipping the base_ directories and run the
test cases by the default perf test structure.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 .../tests/shell/perftool-testsuite_probe.sh   | 24 -------------------
 .../tests/shell/perftool-testsuite_report.sh  | 23 ------------------
 tools/perf/tests/tests-scripts.c              |  2 --
 3 files changed, 49 deletions(-)
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
index d4e382898a30..79b75b83a4bf 100644
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
2.50.1

