Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F31DED63
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759348341; cv=none; b=jgJSdeuRhdg52vgJbr/m4uECphU+NNeU2+fEvtiqSrlALWIJkt4FTKicO5IaFiK/RS9Bgs6LFFlpJPelo666RmslDPNsdTUdmvf96SUcIBgFFcNcE/dgc0R/noATnnWiNV0v51L+qX+JbNX6+s1uSmh36cq08NBRNu4Fieg8Q2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759348341; c=relaxed/simple;
	bh=2GwntnuGEgVcJp5uzDbaxQTWGpDZdjmJnerRcjsvzJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iARDOJyzpJtE8hlftfn+o/G2U0f/SWCkdBh5KnEGtALpef6WTSIntxBjZiYQkF5+v5tnr1irex3g3VxbsZgBt1s5tbHPlZeejM7YyYS55ZxOHdBz5vwh6kUSF0uBJhT3aF4EJocBPSgVOU5b02mCR/SKrYdVAHm7SXJAxH8A9Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WITDMlD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WITDMlD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759348337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E1IGHmX8DGMtzjlmDVzuCFCfPglAkbYr95cqX8KMDng=;
	b=WITDMlD92Q6VODzLriAx1ibGRwlF4b2SnJdqHK/a8gGaFt/AUQRWEbzjwbfrexYFpti+hI
	Al5nx1YZmgx4+2ZdeUYilCc3FFtGSQ7OteETd9EfpU/NRrgN+FsCn3fvgyGPUOoUQvmDXZ
	7cVUeMgSS7kmTA3GdIWB/DSTUiSRw1Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-5GORiUkiMriGhjVqvR_XEQ-1; Wed,
 01 Oct 2025 15:52:10 -0400
X-MC-Unique: 5GORiUkiMriGhjVqvR_XEQ-1
X-Mimecast-MFC-AGG-ID: 5GORiUkiMriGhjVqvR_XEQ_1759348326
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BE8A180047F;
	Wed,  1 Oct 2025 19:52:06 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66A2419560B4;
	Wed,  1 Oct 2025 19:52:02 +0000 (UTC)
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
Subject: [PATCH] perf tests record: allow for some difference in cycle count in leader sampling test on aarch64
Date: Wed,  1 Oct 2025 15:50:48 -0400
Message-ID: <20251001195047.541745-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On aarch64 systems, when running the leader sampling test, the cycle
count on the leader is consistently ~30 cycles less than the cycle count
on the slave event causing the test to fail. This looks like the result
of some hardware property of aarch64 processors, so allow for a small
difference in cycles between the leader and slave events on aarch64
systems.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/tests/shell/record.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index b1ad24fb3b33..dff83d64e970 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -280,7 +280,12 @@ test_leader_sampling() {
   while IFS= read -r line
   do
     cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
-    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
+    # On aarch64 systems the leader event gets stopped ~30 cycles before the slave, so allow some
+    # difference
+    if [ "$(uname -m)" = "aarch64" ] && (( cycles - prev_cycles < 50 ))
+    then
+	    valid_counts=$(($valid_counts+1))
+    elif [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
     then
       invalid_counts=$(($invalid_counts+1))
     else
-- 
2.47.3

