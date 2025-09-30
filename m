Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB2309DDC
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248597; cv=none; b=mRt8gP991i28DBIJ6JPrC7/tJC7TwPVhFjk4w/ZMCQcl8Sqd7QdSlpgb3WmhZpqR8c8Djo3r/wUYzuPPb86dN3lS2+Hndpy115UyzQcctZfo5jfCeQ6DfaQEE2quVbC37cOm+y0gTvfEq90VsLjVKiWR6RTRoK3sHTa3wh1MKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248597; c=relaxed/simple;
	bh=GOymHrNWJ/DcqzFRzNLLiF1DogkUUYreDSzbM08GGt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BizmolCUuCSIeOQaDJvmA/befrDyugJJuUo4W2tlCEPzHfeO16mUxaKkHn4ddrd2cmm4ae+bDGiJNYfYyw84UrOJMHIfqoV4ea28kNJEslMSTGc6yCTD5sZ6Gu0uqSq4EIfkfu5a0jpIaQ4SkQxFvFd5ivbpPECsQNTFhLKhbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCpG8RS/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCpG8RS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759248594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHb7eAG3iz8vQBG390eouAsX/g11mGeOxSw1qV8aQ3I=;
	b=UCpG8RS/ZwVh2BUkiBE0IL8V89swuNwq9sp3HKQWcD/sA7rMbGBgGSLCzZgUohYu08fudB
	/uO3YVn588tHnAW9WttebtRNurvvtyR/pDAbTEGt3XsckpMOmvTC26GZhqkCYnXaUZlWHn
	G6ytuMkYx7c+GFJ9KOBNXd2VkQjJybg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586--BFkofxyMwWBzFwcH0tROA-1; Tue,
 30 Sep 2025 12:09:51 -0400
X-MC-Unique: -BFkofxyMwWBzFwcH0tROA-1
X-Mimecast-MFC-AGG-ID: -BFkofxyMwWBzFwcH0tROA_1759248589
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 653111800371;
	Tue, 30 Sep 2025 16:09:49 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8EE230003BA;
	Tue, 30 Sep 2025 16:09:46 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v4 7/7] perf test: Remove perftool drivers
Date: Tue, 30 Sep 2025 18:09:23 +0200
Message-ID: <20250930160923.13728-8-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-1-jbrnak@redhat.com>
References: <20250930160923.13728-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Veronika Molnarova <vmolnaro@redhat.com>

The perf now provides all of the features required for running the
perftool test cases, such as creating log directories, running
setup scripts and the tests are structured by the base_ directories.

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
index 9b4782bc1767..e5137a89471b 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -420,8 +420,6 @@ static void append_suites_in_dir(int dir_fd,
 			if (!S_ISDIR(st.st_mode))
 				continue;
 		}
-		if (strncmp(ent->d_name, "base_", 5) == 0)
-			continue; /* Skip scripts that have a separate driver. */
 
 		/* Scan subdir for test cases*/
 		fd = openat(dir_fd, ent->d_name, O_PATH);
-- 
2.50.1

