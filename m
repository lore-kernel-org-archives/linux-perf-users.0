Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7F125AE
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Mar 2024 08:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710144707; cv=none; b=fmkWyR27zXI6pD7f+4mLTMlxa6RF8FQbiI2mdI8G3CVfQVj619UdLd87GH/GxAgkYuZtTBxBOCeRgjuI0/E4iKAm2vQ2c7gBTGTFp9x/4p9cy3LHR3iVumuUebHREj9JfbJiWi7Q9yPffnnmxzvuQ2d9UDa4TETQGyfgxL2KLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710144707; c=relaxed/simple;
	bh=9S4gcLby3shXeunf4zVZOOuMBRQiiJcQ9sfAeg4amIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ywx2IeEosDUcuMy+jCMCpu3jtaPAK3mGothW8yxCfCuyd+tPe1h9vW6P0ZOmgTSC5jKLZyNjj8CyWg8fFGthSZM1cjPvHy7kRzpuNFChnzu5TVE0LDUmFgsNg82UU2ZWKsDIlFJrV/uKTISTzCPdY8WEAqBjNytuhfIOkl8z7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qai1PKh9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qai1PKh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710144704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eASz2lQk3eM47a/jZZOa+KmSm8eGVLFWVxGcj8gJrMQ=;
	b=Qai1PKh91KMIRPNpdpOtWTOfX7ERI7in2YJs5VZhCsxLlA+3B5JwOGbEVSCjQmqvB5QTyE
	BNaCPOB/ocN+fnbk6j5DV+UxLCoNXlNVKHN4rwU+QWV8rS9LcBayh9NcborI9AfsSrReWD
	oee76Ooyxv10KNSV/kf36aaIE9NZ0Mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-pvKVE6Q3OCW-5fhF8sKaHg-1; Mon, 11 Mar 2024 04:11:42 -0400
X-MC-Unique: pvKVE6Q3OCW-5fhF8sKaHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2DE08007A4;
	Mon, 11 Mar 2024 08:11:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.214])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E4862024517;
	Mon, 11 Mar 2024 08:11:40 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH v2] perf test record.sh: Raise limit of open file descriptors
Date: Mon, 11 Mar 2024 09:11:27 +0100
Message-ID: <20240311081127.7652-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: Veronika Molnarova <vmolnaro@redhat.com>

Subtest for system-wide record with '--threads=cpu' option fails due
to a limit of open file descriptors on systems with 128 or more CPUs
as the default limit is set to 1024.

The number of open file descriptors should be slightly above
nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
16*nmb_cpus for the test.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/record.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 4fbc74805d52..8acd55d09a1c 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -11,6 +11,14 @@ err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 testprog="perf test -w thloop"
 testsym="test_loop"
+default_fd_limit=$(ulimit -n)
+# With option --threads=cpu the number of open file descriptors should be
+# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
+#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
+#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
+# All together it needs 8*nmb_cpus file descriptors plus some are also used 
+# outside of testing, thus raising the limit to 16*nmb_cpus
+min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
 
 cleanup() {
   rm -rf "${perfdata}"
@@ -154,10 +162,18 @@ test_workload() {
   echo "Basic target workload test [Success]"
 }
 
+# raise the limit of file descriptors to minimum
+if [[ $default_fd_limit -lt $min_fd_limit ]]; then
+	ulimit -n $min_fd_limit
+fi
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 
+# restore the default value
+ulimit -n $default_fd_limit
+
 cleanup
 exit $err
-- 
2.41.0

