Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAB1146D60
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307240; cv=none; b=idczMsjcp1lG31/QtOK8cUmhXcLb0kqhDIuB7sc0peo+8bfbosR7frpIuZQHZ7QF29DrUpqjwjzYp37GVU6IWQt/KqFew45xjYD1WvXBCrpCGkMmgxEBH0vXn6aTEpaOoGA6EdEDhnmMLkxL0KJdx7wvdpkg/zCK914iHvHXqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307240; c=relaxed/simple;
	bh=LWRyvbfjeunk/x/m1LkIyRe5LkP0hKPYuyJfL5mF5UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T7UDmjEgQSGi/p4KKBUC7L9XC7JGtBTKaa01baLlbyt9KLXQjq+77qL/Aou0ofpZLGGJjTOlSehkGQYOWfiMWpe/VRDuhTh8ihyvgAwCtXyejWgkxZudsbCMfa4WKvknQh6m0yE24ciFV0OUOavoBLQcbjKEqGwlmVFqMVYaok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGc/7Q9v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGc/7Q9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719307234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2S+PefxAtbcIXPxIFLX7R7/SRyIiY2MzjsG2JT1e7oU=;
	b=NGc/7Q9vbjxh8WyNggffils8uBfevhR5W0p66Oz4iPAhZZIrr00bfbRH6riKlze17hJSOl
	ZzzQqDEREqBG23+fHKYdPfqHVGfk4cLClr+xdNCUM3MlWwawByCzv/xNfPBkFPLFWuKFOt
	Hkeo1czeGSRZe57iAZjUvJ1g7nvvItY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-rwM6ZM27MbGruWhP6Q5XIg-1; Tue,
 25 Jun 2024 05:20:30 -0400
X-MC-Unique: rwM6ZM27MbGruWhP6Q5XIg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D619119560B8;
	Tue, 25 Jun 2024 09:20:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.142])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84C811955E82;
	Tue, 25 Jun 2024 09:20:25 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	namhyung@kernel.org
Subject: [PATCH v2] perf test stat_bpf_counter.sh: Stabilize the test results
Date: Tue, 25 Jun 2024 11:20:01 +0200
Message-ID: <20240625092001.10909-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Veronika Molnarova <vmolnaro@redhat.com>

The test has been failing for some time when two separate runs of
perf benchmarks are recorded for cycles events and their counts are
compared, while once the recording was done with option --bpf-counters
and once without it. It is expected that the count of the samples
should be within a certain range, firstly the difference was set to be
within 10%, which was then later raised to 20%. However, the test case
keeps failing on certain architectures as recording the provided
benchmark can produce completely different counts based on the
current load of the system.

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

Instead of recording the cycles use instructions event, which provides
more stable values. At the same time change the tested workload to one
of the provided testing workloads by perf that is not based on a
scheduler, which can provide another dependency on the current load.

Sampling instructions event with the new workload provide much more
stable results on intel-eaglestream-spr-13 of "perf stat --no-big-num
-e instructions -- perf test -w brstack":

 Performance counter stats for 'perf test -w brstack':

          64584494      instructions

       0.009173945 seconds time elapsed

       0.007262000 seconds user
       0.002071000 seconds sys

 Performance counter stats for 'perf test -w brstack':

          64672669      instructions

       0.008888135 seconds time elapsed

       0.005018000 seconds user
       0.004018000 seconds sys

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/stat_bpf_counters.sh | 36 ++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
index 61f8149d854e..f250b7d6f773 100755
--- a/tools/perf/tests/shell/stat_bpf_counters.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters.sh
@@ -4,7 +4,7 @@
 
 set -e
 
-workload="perf bench sched messaging -g 1 -l 100 -t"
+workload="perf test -w brstack"
 
 # check whether $2 is within +/- 20% of $1
 compare_number()
@@ -25,15 +25,15 @@ compare_number()
 
 check_counts()
 {
-	base_cycles=$1
-	bpf_cycles=$2
+	base_instructions=$1
+	bpf_instructions=$2
 
-	if [ "$base_cycles" = "<not" ]; then
-		echo "Skipping: cycles event not counted"
+	if [ "$base_instructions" = "<not" ]; then
+		echo "Skipping: instructions event not counted"
 		exit 2
 	fi
-	if [ "$bpf_cycles" = "<not" ]; then
-		echo "Failed: cycles not counted with --bpf-counters"
+	if [ "$bpf_instructions" = "<not" ]; then
+		echo "Failed: instructions not counted with --bpf-counters"
 		exit 1
 	fi
 }
@@ -41,29 +41,29 @@ check_counts()
 test_bpf_counters()
 {
 	printf "Testing --bpf-counters "
-	base_cycles=$(perf stat --no-big-num -e cycles -- $workload 2>&1 | awk '/cycles/ {print $1}')
-	bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- $workload  2>&1 | awk '/cycles/ {print $1}')
-	check_counts $base_cycles $bpf_cycles
-	compare_number $base_cycles $bpf_cycles
+	base_instructions=$(perf stat --no-big-num -e instructions -- $workload 2>&1 | awk '/instructions/ {print $1}')
+	bpf_instructions=$(perf stat --no-big-num --bpf-counters -e instructions -- $workload  2>&1 | awk '/instructions/ {print $1}')
+	check_counts $base_instructions $bpf_instructions
+	compare_number $base_instructions $bpf_instructions
 	echo "[Success]"
 }
 
 test_bpf_modifier()
 {
 	printf "Testing bpf event modifier "
-	stat_output=$(perf stat --no-big-num -e cycles/name=base_cycles/,cycles/name=bpf_cycles/b -- $workload 2>&1)
-	base_cycles=$(echo "$stat_output"| awk '/base_cycles/ {print $1}')
-	bpf_cycles=$(echo "$stat_output"| awk '/bpf_cycles/ {print $1}')
-	check_counts $base_cycles $bpf_cycles
-	compare_number $base_cycles $bpf_cycles
+	stat_output=$(perf stat --no-big-num -e instructions/name=base_instructions/,instructions/name=bpf_instructions/b -- $workload 2>&1)
+	base_instructions=$(echo "$stat_output"| awk '/base_instructions/ {print $1}')
+	bpf_instructions=$(echo "$stat_output"| awk '/bpf_instructions/ {print $1}')
+	check_counts $base_instructions $bpf_instructions
+	compare_number $base_instructions $bpf_instructions
 	echo "[Success]"
 }
 
 # skip if --bpf-counters is not supported
-if ! perf stat -e cycles --bpf-counters true > /dev/null 2>&1; then
+if ! perf stat -e instructions --bpf-counters true > /dev/null 2>&1; then
 	if [ "$1" = "-v" ]; then
 		echo "Skipping: --bpf-counters not supported"
-		perf --no-pager stat -e cycles --bpf-counters true || true
+		perf --no-pager stat -e instructions --bpf-counters true || true
 	fi
 	exit 2
 fi
-- 
2.43.0

