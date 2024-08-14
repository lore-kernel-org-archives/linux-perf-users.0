Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053A2D7B8
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648671; cv=none; b=l/vguWhuptSkMl9cCuEYEi8O9Sx06qtiYPSr3F7H0Wq34H+DphTbbg4+VVudnV7qAoOkhdHjD51WLYhhyq2vdGbj4pKVRPqRNQzedlD62qnDkdicqM6/w/dccKYZ/K6dX/PhwLMLirUw8eufAPmsmNcnuZrblukqrIGCsbQLQCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648671; c=relaxed/simple;
	bh=aRFyNechgxwKfivMiydKxMx3V0Va9iWCfEAI+jT3esg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqLFg42m/nE/4J8RTNFEeuo7NprlIElAN3RU5IuOHHE9Y3hFhJoy79c2f0lO5kc+GQHRigj3yKmMVgMRJKqp4A9Pudo4ypyBDf6tTrV2Jt5WdgW701ORZR8dd3cJLi3/2EfVfdOzXNZ/ZT83gCqgKuYE3Gqa5qJRwUoBFT+zhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlNqicOD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlNqicOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723648668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kbhb030fjOV/7gP5XT45pz/WKEU7wwGKMm6aYzIdmb8=;
	b=GlNqicODVgBYn8RmG+VVR+CV9QbQhCptOv/IjMBsmAhj8bVOqmJyCajVyIZBGsQRrZYMd6
	eMpqgwyrYZU8j9bLZXcQHjA9rj+bvE+tWcvsB8s4qg2wubUlWYKhx94aUdqbf3IqS5rpDT
	FbsSt9Z/U0MrmNIK0VdTFDIA+oS43jo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-P6bweoCfN_CkBWF6jD1dig-1; Wed,
 14 Aug 2024 11:17:45 -0400
X-MC-Unique: P6bweoCfN_CkBWF6jD1dig-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9D891944CEE;
	Wed, 14 Aug 2024 15:17:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C41441955F3F;
	Wed, 14 Aug 2024 15:17:39 +0000 (UTC)
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
Date: Wed, 14 Aug 2024 17:17:34 +0200
Message-ID: <20240814151734.15409-1-vmolnaro@redhat.com>
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
v3: Fix shellcheck warnings
---
 tools/perf/tests/shell/record.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3d1a7759a7b2..c1160d36311a 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -22,6 +22,21 @@ cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
 br_cntr_output="branch stack counters"
 
+ulimit_supported=false
+# With option --threads=cpu the number of open file descriptors should be
+# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
+#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
+#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
+# All together it needs 8*nmb_cpus file descriptors plus some are also used
+# outside of testing, thus raising the limit to 16*nmb_cpus
+min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
+
+# shellcheck disable=SC3045 # ulimit is required for testing --threads option
+default_fd_limit=$(ulimit -Sn)
+if [ $? -eq 0 ]; then
+  ulimit_supported=true
+fi
+
 cleanup() {
   rm -rf "${perfdata}"
   rm -rf "${perfdata}".old
@@ -107,6 +122,11 @@ test_register_capture() {
 
 test_system_wide() {
   echo "Basic --system-wide mode test"
+  if [ ! $ulimit_supported ] && [ $min_fd_limit -gt 1024 ]
+  then
+    echo "Limited file descriptors for --threads option [Skipped not available]"
+    return
+  fi
   if ! perf record -aB --synth=no -o "${perfdata}" ${testprog} 2> /dev/null
   then
     echo "System-wide record [Skipped not supported]"
@@ -190,11 +210,23 @@ test_branch_counter() {
   echo "Basic branch counter test [Success]"
 }
 
+# raise the limit of file descriptors to required minimum
+if [ $ulimit_supported ] && [ $default_fd_limit -lt $min_fd_limit ]; then
+  # shellcheck disable=SC3045 # ulimit is required for testing --threads option
+  ulimit -Sn $min_fd_limit
+fi
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
 
+# restore the default value
+if [ $ulimit_supported ]; then
+  # shellcheck disable=SC3045 # ulimit is required for testing --threads option
+  ulimit -Sn $default_fd_limit
+fi
+
 cleanup
 exit $err
-- 
2.43.0

