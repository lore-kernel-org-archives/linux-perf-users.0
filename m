Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C84156C5;
	Wed, 23 Sep 2026 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200377; cv=none; b=Q2Bn4H3vJG1YH7rXBJYkf8Q8wigcV9aM6ZQj1rKS3rNK498L9CyQPqXYmUXrG4GAvVm6HkbcLrOkamg4frglBjU/jwhVjsJK4pu3cHB7bvOagOG6tMXYlEzcFUQceH7hdpLsrZRLz96zMuxoBJOUotD2DfIUeX+5eRfwEzlxnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200377; c=relaxed/simple;
	bh=xQw9bDMbY7X5J+AEFzwa5Ca3iFs+XoaC3SrpeyDqjnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsTBsNcb2/10jkBBYnXsFaf/CdbhcPpYQ56GKFgrJHrSKKFlg6cd0R785DpC3mrvkx09GwO8yaiqZkSboCGLVjp/VCipOEaZ/4yu5YjGwF1Xl5cim94AyKHZqIu0Ip028NmohUAZuuclvcmbGrtvb2lSe+ZGhC3qNPi9QaS64OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD3Z7AGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD3Z7AGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D561F00893;
	Wed, 23 Sep 2026 21:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790200376;
	bh=nUwh1xT7W9h6Rk6j772amqZT0ZXOfA/whfiZ7yaI0TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iD3Z7AGteuTzDrBELMHKf1v8F0rxSVS8VXuLC1Q0TgcO13NIQAhX5Ih7TmnS2zCFJ
	 GA8wzQALea4glcLjg6UQk5+D+7UccVNMr2gKNup/Aox9Jl5cFfTOjax5YxdwPhPCd0
	 zkc7KogLg+hDGpdsZyrGO17K0iH3NIsIPzsOXSQAJRnPUG0o5sIK1vvP8P+dnXS00c
	 gLRjSoI2ycngLRvU590CkL8c4D5PAGv3RjEHuqZ3zy29ydE0FvgIxAtPGi/9DBCJ0M
	 PN1ApiHZlzqtOYEEoPHqq61vSozXL8s/HW+Fphp+JcV2FyU4cFLIx4sfquFspxERxw
	 afHYRqaU6IOQw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf test: Fix record tests on Intel Broadwell
Date: Wed, 23 Sep 2026 14:52:54 -0700
Message-ID: <20260923215255.3329181-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923215255.3329181-1-namhyung@kernel.org>
References: <20260923215255.3329181-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed it failed for leader sampling tests on Broadwell.  It's
because the period of groups members are a little bit different.  Maybe
there's an hardware issue but anyway it's close enough to treat them as
same.  I printed the value like below.

  $ perf test record
  ...
  prev: 462507, curr: 462506
  prev: 494783, curr: 494782
  prev: 454350, curr: 454349
  prev: 502782, curr: 502781
  prev: 566693, curr: 566692
  prev: 606558, curr: 606557
  prev: 559770, curr: 559769
  prev: 595737, curr: 595736
  prev: 643386, curr: 643385
  prev: 663672, curr: 663671
  prev: 620622, curr: 620621
  prev: 650419, curr: 650418
  Leader sampling [Failed inconsistent cycles count]

Let's update the logic to compare values to allow 1% of errors.

Also I think it should compare only if sees the non-leader samples so
split the check of (($index % 2)).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index cf8ba3d3411b0bcc..04df35b30b0c15fd 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -550,11 +550,14 @@ test_leader_sampling() {
   while IFS= read -r line
   do
     cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
-    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
+    if [ $(($index%2)) -ne 0 ]
     then
-      invalid_counts=$(($invalid_counts+1))
-    else
-      valid_counts=$(($valid_counts+1))
+      if (( $(bc <<< "scale=4; r = ${cycles} / ${prev_cycles}; r >= 0.99 && r <= 1.01") ))
+      then
+        valid_counts=$(($valid_counts+1))
+      else
+        invalid_counts=$(($invalid_counts+1))
+      fi
     fi
     index=$(($index+1))
     prev_cycles=$cycles
-- 
2.56.0.rc1.310.g51773c2048-goog

