Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73F12F36C
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667785; cv=none; b=NoKTJEbrJwyd/H8dNGXGanekkJpp6VpBc6LB8U/Erc7YwrVLYi7vF3ViKVqut2+FMryLvN9LRZtVoLv+SvbvhyIw071rfhzPU2KilMo34DuR03YWU/MHZzJOB/KwbDjEa3LVELpxyanu798/E5uDCIiYbydjghmZY63KXGBm8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667785; c=relaxed/simple;
	bh=n35hBhlZI2Vo7uHOzpVIF0gDETcdCp3gSgO5SgyJGnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PB1KKwvsNXwjKoQdNgG3UBt3KbLBlumC69Ev6iwtnUYoaw8TNvPQZHP/HNTZm4CzYpSJ6sDVpfsGCDMOsMEAWrbIgJCCtDERaOHwopNgczL2SKSBOivseOfL0bVt/zSrJO/qS8R/YFXZr4cIVskL/IDJ+WxWcPwW6tDNkFa5B+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmH8m7tV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmH8m7tV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712667783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lTszHKgXOrchb+cozOhI3Q98+hceb8Kj8MCm0lVRnHk=;
	b=UmH8m7tVP0sRsJLe64CiG34ybImjPQL2m2PJaT+ZcRVQlGCofca++6lQYRxVApNqXDG6+v
	7O80MFu5S7GCmV91ywataBl97eaV22vg0jfe8sByphJr8FOZi063MoC2QpT1I6mVLk7Iku
	t0jY1/a4Jfjfp4RvtTE8ibaaGqzypck=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-4d50xWHzP8KJNyJq0emilA-1; Tue,
 09 Apr 2024 09:03:01 -0400
X-MC-Unique: 4d50xWHzP8KJNyJq0emilA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 423DD1C05AA8;
	Tue,  9 Apr 2024 13:03:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.240])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D13217ABB;
	Tue,  9 Apr 2024 13:02:58 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH] perf test stat_all_pmu.sh: Parse return value of perf stat
Date: Tue,  9 Apr 2024 15:02:40 +0200
Message-ID: <20240409130240.13973-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

From: Veronika Molnarova <vmolnaro@redhat.com>

With the MR a381bd3615de6 ('powerpc/hv-gpci: Fix the
H_GET_PERF_COUNTER_INFO hcall return value checks') the perf stat for
hv_gpci events without required permission set returns an error value
of -1 to differentiate the output from the unsupported events. The
stat_all_pmu test, however, exits immediately if any command exits with
a non-zero value due to 'set -e' option.

Remove the 'set -e' option from the test and rework the test case to log
the status of the event for better maintainability. Instead of exiting
immediately after 'perf stat' ends with a non-zero value, check the
return value and output of the 'perf stat' command with appriopriate action.
---
 tools/perf/tests/shell/stat_all_pmu.sh | 36 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index c77955419173..d9f0d2100baa 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -2,21 +2,35 @@
 # perf all PMU test
 # SPDX-License-Identifier: GPL-2.0
 
-set -e
 
 # Test all PMU events; however exclude parametrized ones (name contains '?')
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
+    # return value 0 if counters gets printed either if the event is supported or not
+    if [ $stat_result -eq 0 ] && ! echo "$stat_output" | grep -q "<not supported>"; then
+        echo "supported"
+    elif [ $stat_result -eq 0 ]; then
+        echo "not supported"
+    # return value 255 when the required pemission for the event is not set
+    elif [ $stat_result -eq 255 ] && echo "$stat_output" | grep -q "No permission"; then
+        echo "no permission to enable"
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

