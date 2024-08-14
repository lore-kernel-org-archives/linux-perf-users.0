Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8C1B8EA4
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650460; cv=none; b=piUTL5epNUdtyChGnm0E54Qbkthr9AWS1vYvB4Dw619nS7aUi0L8A8Bvam8f39Sb3QKXNNeK6DJewzqVyv5rVCiJHSnsrp+dJq83RU7X5ZNGWZHFoq/tT78MgOhJbbnxSoJ2P3lm/HzZ8LgG+CHzMthB2clVadgjIfpuLi1uyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650460; c=relaxed/simple;
	bh=J8fJN9r8x9AzuBAKmjXjxlSDDdQuDW/qQ0Nv/PEt2Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkeylbPq1Evo2FCWnm/nCykWjt/isA1siKoXQBBl9IU05rVze5LUvO3d9bx3lRkWn4/FrxXn27/mexLr/JIpjN039VLJOHIFL3JkQKpFtBFeiKciB+s/zqgjLuFwiqErxm3lNzaPL9uK0ZytzEZs63AiEnZdgLIt80ZGSxeGnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A45N/wax; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A45N/wax"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723650457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o3E3rCSMvmt0sorYnkXspIQJvTatHBj3540p2k9A7pc=;
	b=A45N/waxEp4btSn/GjwZqS2fSUyKfPYX5gTMLCd4afs79XtLlzjV+XvK3VoX1mLQ8DhzC0
	S66O011uroB+znL5MFh8rf2w+xkg0c/5DudW/tutR/wcpqeqKAI051KfON/nyC4dmZKyX1
	BMtS1dzviFJvR8AekviV0Qqr0u6LTy0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-hk3EKUq6N02SmYzTuLeZGQ-1; Wed,
 14 Aug 2024 11:47:34 -0400
X-MC-Unique: hk3EKUq6N02SmYzTuLeZGQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83E14192DE2B;
	Wed, 14 Aug 2024 15:47:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83E9A1932DBF;
	Wed, 14 Aug 2024 15:47:11 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: adrian.hunter@intel.com,
	atrajeev@linux.vnet.ibm.com,
	irogers@google.com,
	jolsa@kernel.org,
	kjain@linux.ibm.com,
	mpetlan@redhat.com,
	rstoyano@redhat.com
Subject: [PATCH v3] perf test record.sh: Raise limit of open file descriptors
Date: Wed, 14 Aug 2024 17:47:06 +0200
Message-ID: <20240814154706.17223-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Veronika Molnarova <vmolnaro@redhat.com>

Subtest for system-wide record with '--threads=cpu' option fails due
to a limit of open file descriptors on systems with 128 or more CPUs
as the default limit is set to 1024.

The number of open file descriptors should be slightly above
nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
16*nmb_cpus for the test.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Radostin Stoyanov <rstoyano@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
v2: Rebase the patch to apply upstream
v3: Switch to bash to fix shellcheck warnings
---
 tools/perf/tests/shell/record.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3d1a7759a7b2..02b706792737 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # perf record tests
 # SPDX-License-Identifier: GPL-2.0
 
@@ -22,6 +22,15 @@ cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
 br_cntr_output="branch stack counters"
 
+# With option --threads=cpu the number of open file descriptors should be
+# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
+#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
+#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
+# All together it needs 8*nmb_cpus file descriptors plus some are also used
+# outside of testing, thus raising the limit to 16*nmb_cpus
+min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
+default_fd_limit=$(ulimit -Sn)
+
 cleanup() {
   rm -rf "${perfdata}"
   rm -rf "${perfdata}".old
@@ -190,11 +199,19 @@ test_branch_counter() {
   echo "Basic branch counter test [Success]"
 }
 
+# raise the limit of file descriptors to required minimum
+if [ $default_fd_limit -lt $min_fd_limit ]; then
+  ulimit -Sn $min_fd_limit
+fi
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
 
+# restore the default value
+ulimit -Sn $default_fd_limit
+
 cleanup
 exit $err
-- 
2.43.0

