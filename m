Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41C1BBBDE
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654923; cv=none; b=A1LzG6V9D9UsF6z5Igj7KQgGkive07UdEwE9iPLnnAJs2ENE+gaimygl185WJqj+qWIJ2dr8/RO+S44sTgm+sazl3sNnoPBgM959HOZNlbuxmR9O6rCoUoqUw7nZdzpgxsrHLvwJN0A5LimCZ9Ob97voAjk7KkHfbMt7PPB4oZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654923; c=relaxed/simple;
	bh=sTMdZ9woXqF8X8oUxhp2oJfyl5X5AVclLdFthtfujys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtK9+euZA3eygm02FD9+pEV1doOn0EMtNhA447/OS5f3n9rBZZ4jvTqRawoitp7x3DCq4/f5LzSjdRR+enQF8BcDTbfAXnlFGoLUS79pf8GqIOm89HF44cSr/DqnGM1oqxw5RPrciZFLfSqg+hL89E3BFZG6duz+kAgoo/evpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGZ8Vsw3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGZ8Vsw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723654920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iAOw1/o21opkXE6SecINtnPRNY9unTE3VQjS4j3Sdp4=;
	b=WGZ8Vsw3/yE8rSo0j09ItIDZ5LciipM+m0YQ4BD9IyMl6mggQuTrpcq7LRzyx58v76cPrz
	QHnjyLC+K2W42nCoiRhjFzwAFRgfSjEs0T8EyTZSbqo8W62vH/4YXQzyiG7zNqQM1vvjjM
	sPpc5QufQRNj8eoyQFMiI7DKVTwd/gE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-TZkV2-MLPm-Ol8t6o7x5EQ-1; Wed,
 14 Aug 2024 13:01:57 -0400
X-MC-Unique: TZkV2-MLPm-Ol8t6o7x5EQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90956190FEFF;
	Wed, 14 Aug 2024 17:01:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA83419560A3;
	Wed, 14 Aug 2024 17:01:51 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: kjain@linux.ibm.com,
	mpetlan@redhat.com,
	rstoyano@redhat.com,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com
Subject: [PATCH v4] perf test stat_all_pmu.sh: Parse return value of perf stat
Date: Wed, 14 Aug 2024 19:01:46 +0200
Message-ID: <20240814170146.20678-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Veronika Molnarova <vmolnaro@redhat.com>

With the upstream MR !3916 of commit ad86d7ee43b22aa2 ('powerpc/hv-gpci:
Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
stat for hv_gpci events without required permission set returns an
error value of -1 to differentiate the output from the unsupported
events. The stat_all_pmu test was designed in a way, that if any
command exits with a non-zero value the test exits with an error
value without any information provided due to the 'set -e' option.

The issue propagated upstream as the list of the files that affected perf
did not cover the changed files and was updated after the issue was
discovered. It was caught by CKI testing where it was triaged to stop
blocking further MRs, as most of the powerpc machines have some of
the hv_gpci events without the required permissions.

Remove the 'set -e' option from the test and rework the test case to log
the status of the event for better maintainability. Instead of exiting
immediately after 'perf stat' ends with a non-zero value, check the
return value and output of the 'perf stat' command with the appropriate action.

Link to the MR !3916 of commit ad86d7ee43b22aa2:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Radostin Stoyanov <rstoyano@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
v2: Fix commit hash
v3: Add 'device busy' for parallel testing
v4: Change commit message
---
 tools/perf/tests/shell/stat_all_pmu.sh | 41 ++++++++++++++++++--------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index c77955419173..a75beddda4db 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -2,21 +2,38 @@
 # perf all PMU test
 # SPDX-License-Identifier: GPL-2.0
 
-set -e
 
 # Test all PMU events; however exclude parameterized ones (name contains '?')
 for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
-  echo "Testing $p"
-  result=$(perf stat -e "$p" true 2>&1)
-  if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
-    # We failed to see the event and it is supported. Possibly the workload was
-    # too small so retry with something longer.
-    result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
-    if ! echo "$result" | grep -q "$p" ; then
-      echo "Event '$p' not printed in:"
-      echo "$result"
-      exit 1
+  echo -n "Testing event '$p' -- "
+  stat_output=$(perf stat -e "$p" true 2>&1)
+  stat_result=$?
+  if echo "$stat_output" | grep -q "$p"; then
+    # return value 0 if counters get printed either if the event is supported or not
+    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
+        echo "supported"
+    elif [ $stat_result -eq 0 ]; then
+        echo "not supported"
+    # return value 255 when the required permission for the event is not set
+    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
+        echo "no permission to enable"
+    # return value 255 in case of resource busy during parallel testing of events
+    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "Device or resource busy"; then
+        echo "resource busy"
+    # return value 129 when trying to run 'perf stat' with a non-existent event
+    elif [ $stat_result -eq 129 ] && echo "$stat_output" | grep -q "Bad event name"; then
+        echo "Fail: Bad event name"
+        echo "$stat_output"
+        exit 1
+    else
+        echo "Fail: Unknown return value $stat_result"
+        echo "$stat_output"
+        exit 1
     fi
+  else
+      echo "Fail: Event '$p' not printed in:"
+      echo "$stat_output"
+      exit 1
   fi
 done
 
-- 
2.43.0

