Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EFB301012
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Oct 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225883; cv=none; b=tJ1wbMcHKnbBwqqtt0wgvbSSy+ZOzQLXMrV06VJ8ThgGMNuR6MBGI7jFrWXl/8bNGVesiFsrgawxkJn8U0GdZMY6S8zYPOpDkwUkd3AGBxCIurkLZ9jKncodGrkfW+9aMeg0EIPx134LdbObcetUUMRVzsphEQ2DyT2LjV1p6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225883; c=relaxed/simple;
	bh=HgPEFhxEtacyjpkzy0Yk+l1SxzkIuZGirlJat/3l2lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkU16tFiPDQfhlPkYm0cBVH6ssRy2cufL3mNvnF4wWmncKNafOqs6KayF4XaRRAowA2MM3fQve1wGzyszmM5PQxVdmDba1p3iIldbgSRib+k4Qattc/Hcu8pSkuMMez4L1i6gj3yqkUbKs9HvOxlaqZb0mawbM62ZxvgtoHatwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cazodTOb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cazodTOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761225880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YqqHiZf/ehkbVF5GXKD0OqJ2i/OYi2/x//5mhjrLv6E=;
	b=cazodTObSIvpxnUXT3Jpp9dxVtIY75FFlTQJSB7c34w29x7hc14fqYvMTvhAGV07i87faQ
	CMNbfGpU0G9MNBIseJS0XqgdRAYm8jhLzFecvJQyJhEwxgah/v2QvUELDgRJtKXSDH2E/k
	12+ftYyq3hZNt0BbS49QVmfK3LKSU+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-B5p2jwQyOUOiVO76VqdJMQ-1; Thu,
 23 Oct 2025 09:24:34 -0400
X-MC-Unique: B5p2jwQyOUOiVO76VqdJMQ-1
X-Mimecast-MFC-AGG-ID: B5p2jwQyOUOiVO76VqdJMQ_1761225873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32DE1180065F;
	Thu, 23 Oct 2025 13:24:31 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (dhcp-17-53.lcy.redhat.com [10.42.17.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 074DE1800581;
	Thu, 23 Oct 2025 13:24:22 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	james.clark@linaro.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] Revert "perf test: Allow tolerance for leader sampling test"
Date: Thu, 23 Oct 2025 14:24:07 +0100
Message-ID: <20251023132406.78359-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This reverts commit 1c5721ca89a1c8ae71082d3a102b39fd1ec0a205.

The throttling bug has been fixed in 9734e25fbf5a perf: Fix the throttle
logic for a group. So this commit can be reverted.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/tests/shell/record.sh | 33 ++++++--------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0f5841c479e7..13e0d6ef66c9 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -267,43 +267,22 @@ test_leader_sampling() {
     err=1
     return
   fi
-  perf script -i "${perfdata}" | grep brstack > $script_output
-  # Check if the two instruction counts are equal in each record.
-  # However, the throttling code doesn't consider event grouping. During throttling, only the
-  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
-  # let's set the tolerance rate to 80%.
-  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
   index=0
-  valid_counts=0
-  invalid_counts=0
-  tolerance_rate=0.8
+  perf script -i "${perfdata}" | grep brstack > "${script_output}"
   while IFS= read -r line
   do
+    # Check if the two instruction counts are equal in each record
     cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
     if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
     then
-      invalid_counts=$(($invalid_counts+1))
-    else
-      valid_counts=$(($valid_counts+1))
+      echo "Leader sampling [Failed inconsistent cycles count]"
+      err=1
+      return
     fi
     index=$(($index+1))
     prev_cycles=$cycles
   done < "${script_output}"
-  total_counts=$(bc <<< "$invalid_counts+$valid_counts")
-  if (( $(bc <<< "$total_counts <= 0") ))
-  then
-    echo "Leader sampling [No sample generated]"
-    err=1
-    return
-  fi
-  isok=$(bc <<< "scale=2; if (($invalid_counts/$total_counts) < (1-$tolerance_rate)) { 0 } else { 1 };")
-  if [ $isok -eq 1 ]
-  then
-     echo "Leader sampling [Failed inconsistent cycles count]"
-     err=1
-  else
-    echo "Basic leader sampling test [Success]"
-  fi
+  echo "Basic leader sampling test [Success]"
 }
 
 test_topdown_leader_sampling() {
-- 
2.51.0

