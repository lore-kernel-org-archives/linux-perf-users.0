Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83C3D3BF
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174171; cv=none; b=SE3oplzs1/am9onxX69TlSdTh76tT6xw2Enp2oVROOV5f4ueGjRqNJ3sQJXQQIkof6DScTjZImfe3bcwsKG5lEyakq2lPxthst2ekAGX1R6tNQiDvtGwRyAFBgbwWxQCwI0a6Yy8aZkx5RPgBufNeQY4n7ZM2Jdionpx2cRg1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174171; c=relaxed/simple;
	bh=5L8SNsGSY3T4zTZzt59WflsA1XF2Mje1iGMheRXb9Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFFpU/zhIuPjezeIvyv5AjsBQSXOF86HZ/EG/BFalKWZh3RnUeOrqsjU5c8bcqrVwvZMzNACJkC84UlIArvNqDPFwNohZ9TGWk415l6MojoMXv7Z8GKjFfWDme3vKENnNUaYN5qY3amGP09kST6wlr2yerl+Aoq/A8HdsSNruo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnwjYvQO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnwjYvQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713174169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pyAnoPN55A0rLJXc46xvh8bSsiHfnfwt/NWOJM/0y8=;
	b=FnwjYvQOK8ZA6m6KpZrSELJreTOb2UzUKfgXQSnRjpEDu6ncgzth4aI5T4ni6n1CZ9hAzn
	nDH8cz3+BknOj1sJ8yMZ3aLq8xZEOyxvuZmpJm8CgLVQx6Qqp/LM1dfDP1OQs2o8MZEqHP
	HFAMUfJkIIXjIIEANkKZWuXFPdkooZE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-Z1gDFPNwOAO9mfocEtwbEw-1; Mon,
 15 Apr 2024 05:42:47 -0400
X-MC-Unique: Z1gDFPNwOAO9mfocEtwbEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30C7D29AA3B4;
	Mon, 15 Apr 2024 09:42:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.158])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DF0A492BC7;
	Mon, 15 Apr 2024 09:42:45 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH v2] perf test stat_all_pmu.sh: Parse return value of perf stat
Date: Mon, 15 Apr 2024 11:42:20 +0200
Message-ID: <20240415094220.11639-1-vmolnaro@redhat.com>
In-Reply-To: <ZhgpWkUAto8nzvle@x1>
References: <ZhgpWkUAto8nzvle@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Veronika Molnarova <vmolnaro@redhat.com>

With the upstream MR !3916 of commit a381bd3615de6 ('powerpc/hv-gpci:
Fix the H_GET_PERF_COUNTER_INFO hcall return value checks') the perf
stat for hv_gpci events without required permission set returns an
error value of -1 to differentiate the output from the unsupported
events. The stat_all_pmu test was designed in a way, that if any
command exits with a non-zero value the test exits with an error
value without any information provided due to the 'set -e' option.

Running stat_all_pmu test on powerpc machine with unsupported hv_gpci
event causes failure after the MR as the zero return value was required.
The issue propagated upstream as the list of the files that affected perf
did not cover the changed files and was updated after the issue was
discovered. It was caught by CKI testing where it was triaged to stop
blocking further MRs, as most of the powerpc machines do not support
some of the hv_gpci events.

Remove the 'set -e' option from the test and rework the test case to log
the status of the event for better maintainability. Instead of exiting
immediately after 'perf stat' ends with a non-zero value, check the
return value and output of the 'perf stat' command with the appropriate action.

Link to the MR !3916 of commit a381bd3615de6:
https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-9/-/merge_requests/3916

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
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

