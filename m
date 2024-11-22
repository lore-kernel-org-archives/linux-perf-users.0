Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D79189B86
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Nov 2024 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317180; cv=none; b=keyjuDRvzg3Rp0XS0g6c7nJySq9mUmdYvQGF4gjoMRm7S1Nkr8eDYh7OXoiww2dfcarGQq/GZWNUYpT8TkMELjtYjskcCBEErfBsdZ35+OYAkRYjOQchOtuWXPdnbM9PDMdRAFB3ZGWKZAmHjgPtfWV5/OUEk5QIWurSqyBdd6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317180; c=relaxed/simple;
	bh=oOqSCd5kirULqarfn/9f95V9HrFmc10PARZxt+L033k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5TI9BJD5H42gD5gj/pShvMFoNMnDoiZqsFDDw/mc04bg3JtJKZF/iMJGK3RBb5nsV37LMf077aI1+wuDz3/9H9+fQoM4HY6RtMuJyXCqljF4c5FfU7iXbVrcl8wwxXJUWf9IGsTKV2nAAYSrF+6SeIVepAheeAi7dl/YAXGiPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+WdueV2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+WdueV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732317177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wNS8twpURPIKU9vfxq6MLh9LGT/n455rgMBOQje9fMU=;
	b=E+WdueV2V/e2ZlQrK98xKozv2aW5QyNpzrK+STkmYR1kPTVkQQ5G2p2iM4JTC3c/i97W8W
	YjleLv3suaDMKiMey8EI7LR1rLL9P5bZ0Iflqcrdqom/mwT8epCDD9OuHyvdCnc3OwTTvU
	FQmQ9omWlrn9kkLdgSEj5vy8oAjw2LQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-dvXW-7HHPtW-waJB9RRgdg-1; Fri,
 22 Nov 2024 18:12:54 -0500
X-MC-Unique: dvXW-7HHPtW-waJB9RRgdg-1
X-Mimecast-MFC-AGG-ID: dvXW-7HHPtW-waJB9RRgdg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC7E41956048;
	Fri, 22 Nov 2024 23:12:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EF7A30000DF;
	Fri, 22 Nov 2024 23:12:46 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	irogers@google.com
Cc: mpetlan@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	qzhao@redhat.com
Subject: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat' result
Date: Sat, 23 Nov 2024 00:12:33 +0100
Message-ID: <20241122231233.79509-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Veronika Molnarova <vmolnaro@redhat.com>

Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' output
due to a poor design. Firstly, having the 'set -e' option with a trap
catching the sigexit causes the shell to exit immediately if 'perf stat' ends
with any non-zero value, which is then caught by the trap reporting an
unexpected signal. This causes events that should be parsed by the if-else
statement to be caught by the trap handler and are reported as errors:

    $ perf test -vv "perf all pmu"
    Testing i915/actual-frequency/
    Unexpected signal in main
    Error:
    Access to performance monitoring and observability operations is limited.

Secondly, the if-else branches are not exclusive as the checking if the
event is present in the output log covers also the "<not supported>"
events, which should be accepted, and also the "Bad name events", which
should be rejected.

Remove the "set -e" option from the test case, correctly parse the
"perf stat" output log and check its return value. Add the missing
outputs for the 'perf stat' result and also add logs messages to
report the branch that parsed the event for more info.

Fixes: 7e73ea40295620e7 ("perf test: Ignore security failures in all PMU test")
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/stat_all_pmu.sh | 48 ++++++++++++++++++--------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
index 8b148b300be1131e..9c466c0efa857fc2 100755
--- a/tools/perf/tests/shell/stat_all_pmu.sh
+++ b/tools/perf/tests/shell/stat_all_pmu.sh
@@ -2,7 +2,6 @@
 # perf all PMU test (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
-set -e
 err=0
 result=""
 
@@ -16,34 +15,55 @@ trap trap_cleanup EXIT TERM INT
 # Test all PMU events; however exclude parameterized ones (name contains '?')
 for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g')
 do
-  echo "Testing $p"
-  result=$(perf stat -e "$p" true 2>&1)
-  if echo "$result" | grep -q "$p"
+  echo -n "Testing $p -- "
+  output=$(perf stat -e "$p" true 2>&1)
+  stat_result=$?
+  if echo "$output" | grep -q "$p"
   then
     # Event seen in output.
-    continue
-  fi
-  if echo "$result" | grep -q "<not supported>"
-  then
-    # Event not supported, so ignore.
-    continue
+    if [ $stat_result -eq 0 ] && ! echo "$output" | grep -q "<not supported>"
+    then
+      # Event supported.
+      echo "supported"
+      continue
+    elif echo "$output" | grep -q "<not supported>"
+    then
+      # Event not supported, so ignore.
+      echo "not supported"
+      continue
+    elif echo "$output" | grep -q "No permission to enable"
+    then
+      # No permissions, so ignore.
+      echo "no permission to enable"
+      continue
+    elif echo "$output" | grep -q "Bad event name"
+    then
+      # Non-existent event.
+      echo "Error: Bad event name"
+      echo "$output"
+      err=1
+      continue
+    fi
   fi
-  if echo "$result" | grep -q "Access to performance monitoring and observability operations is limited."
+
+  if echo "$output" | grep -q "Access to performance monitoring and observability operations is limited."
   then
     # Access is limited, so ignore.
+    echo "access limited"
     continue
   fi
 
   # We failed to see the event and it is supported. Possibly the workload was
   # too small so retry with something longer.
-  result=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
-  if echo "$result" | grep -q "$p"
+  output=$(perf stat -e "$p" perf bench internals synthesize 2>&1)
+  if echo "$output" | grep -q "$p"
   then
     # Event seen in output.
+    echo "supported"
     continue
   fi
   echo "Error: event '$p' not printed in:"
-  echo "$result"
+  echo "$output"
   err=1
 done
 
-- 
2.43.0

