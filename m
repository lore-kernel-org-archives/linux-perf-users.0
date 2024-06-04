Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88672143C7B
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515084; cv=none; b=dhNaLE8cWX9Q88NeJH+PehLQcu2voWGn/UMF0nvBE/ke6KuuCSZbpAf+FqjPbaWD7mOxDCb5tArzLOFxMi49IwmUPupZFNrw8SfA4cs7djuBnegxU57FCK8N/EgDM13uJrg1VFY3qB58NiK5Dli7aE3CX/O8i/cLYoEgSVAYSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515084; c=relaxed/simple;
	bh=OOhEYWvjKelT48bWd65Yeoowh+Uo6MBJux7g4Tv4Ic0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wh+caA30WW224/JsWQ9o/9bodI7Xi0PHxNaEDXOZbXwytNehBzG2R21Sp/GR2sJ5Bg+X2xdZd03sBsTJB+dOmmPt9oejJVYDwng3JCslesJOCJwOukpIiEOWz0TUSJLKcODatCDqJ9YnpBeMxWlNEDPzdeIYR/Bp+MVM+61flJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8yu3tUS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8yu3tUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717515081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D+zDHxsxzg/IAazMi/3ZPhfBHUTEv9jBPPUq11pfpgw=;
	b=R8yu3tUS3gUCQp94KqXhv+94cIHTQa4D68AeO/xDuUVtKeSAd5fi0OAOhB41G+dFHX9AY/
	yoSNmgLtzdWgLnV4MCF6NtZKaspJBoEdXrFHDYW+PW+3sO8OeRLbhxaCmZ6fMKg61d3Y6o
	SGGpBHK8nTTxzgMFvwfKIE034KSxCQg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-jNkQxFJwPhGGb1rz5dcRvw-1; Tue, 04 Jun 2024 11:31:18 -0400
X-MC-Unique: jNkQxFJwPhGGb1rz5dcRvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE8188007A1;
	Tue,  4 Jun 2024 15:31:17 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.23])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F40D02166AE6;
	Tue,  4 Jun 2024 15:31:16 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH] perf test stat_bpf_counter.sh: Remove comparison of separate runs
Date: Tue,  4 Jun 2024 17:31:11 +0200
Message-ID: <20240604153111.105548-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Veronika Molnarova <vmolnaro@redhat.com>

The test has been failing for some time when two separate runs of
perf benchmarks are recorded and the counts of the samples are compared,
while once the recording was done with option --bpf-counters and once
without it. It is expected that the count of the samples should within
a certain range, firstly the difference should have been within 10%,
which was then later raised to 20%. However, the test case keeps failing
on certain architectures as recording the same benchmark can provide
completely different counts samples based on the current load of the
system.

Sampling two separate runs on intel-eaglestream-spr-13 of "perf stat
--no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t":

 Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':

         396782898      cycles

       0.010051983 seconds time elapsed

       0.008664000 seconds user
       0.097058000 seconds sys

 Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':

        1431133032      cycles

       0.021803714 seconds time elapsed

       0.023377000 seconds user
       0.349918000 seconds sys

, which is ranging from 400mil to 1400mil samples.

From the testing point of view, it does not make sense to compare two
separate runs against each other when the conditions may change
significantly. Remove the comparison of two separate runs and check only
whether the stating works as expected for the --bpf-counters option. Compare
the samples count only when the samples are recorded simultaneously
ensuring the same conditions.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 61f8149d854e..873b576836c6 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -6,19 +6,19 @@ set -e
 
 workload="perf bench sched messaging -g 1 -l 100 -t"
 
-# check whether $2 is within +/- 20% of $1
+# check whether $2 is within +/- 10% of $1
 compare_number()
 {
 	first_num=$1
 	second_num=$2
 
-	# upper bound is first_num * 120%
-	upper=$(expr $first_num + $first_num / 5 )
-	# lower bound is first_num * 80%
-	lower=$(expr $first_num - $first_num / 5 )
+	# upper bound is first_num * 110%
+	upper=$(expr $first_num + $first_num / 10 )
+	# lower bound is first_num * 90%
+	lower=$(expr $first_num - $first_num / 10 )
 
 	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
-		echo "The difference between $first_num and $second_num are greater than 20%."
+		echo "The difference between $first_num and $second_num are greater than 10%."
 		exit 1
 	fi
 }
@@ -44,7 +44,6 @@ test_bpf_counters()
 	base_cycles=$(perf stat --no-big-num -e cycles -- $workload 2>&1 | awk '/cycles/ {print $1}')
 	bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- $workload  2>&1 | awk '/cycles/ {print $1}')
 	check_counts $base_cycles $bpf_cycles
-	compare_number $base_cycles $bpf_cycles
 	echo "[Success]"
 }
 
-- 
2.43.0

