Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7433DBBF
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Mar 2024 15:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641126; cv=none; b=X2U9ToEo2uKt4smGXt7f1LML7/YaD1KVdKIhSJ5CNBZ9qtfVe9J+rcLplD445iSZSmXX6pVY2lrID7+KYFt/MN+Rbp67xH7kAI5Y1OW6YgICRpKE6sBOHKd8N/I1e8YDNj2vWnvQq1bRwtc2vhSb8B1AT2/SSd0MjkNP2ktBT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641126; c=relaxed/simple;
	bh=/ck/1ENcqvxzmkMHzerk8YY23NIguPKoq3xNvI74eDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFPT/RTFHvcL6Djw/0h3NDoSnsshgIhOh38HRPTeIs5XiFdNRnX4l0rQSgfOu6bP4EQun/jDjDzA1y4Y55iNKUxIPBz+KiCQB+0Ifc4PmPdqMiPW+tbCufRdxJoCQaMZsMW3J/nt+QCmGxqs2jLSUqaefbfXzEPlAd0+cuSRxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATltxYg+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATltxYg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711641124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceK+0hWqwrD4srtDhzJqxO6YnCvRIBHJ0AUCCWm59/A=;
	b=ATltxYg+4kP0ZaGhbxjdtqW6p6I8O50c8m/bEXmY56QeT+w4mySwyP64E9KOn0DfAwZ7+x
	qLdtrO406X4TkJps+sw468lBtNr34cDK8a6vDInrUh5B7mWlpNGllNcs/zdHuJJTrrOXbg
	SHFU2hJVMnkRXvIGfyYyvqnotx69NU4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-HW-zEaofOKqfloO0Dubdyw-1; Thu, 28 Mar 2024 11:51:59 -0400
X-MC-Unique: HW-zEaofOKqfloO0Dubdyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C0E6800264;
	Thu, 28 Mar 2024 15:51:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.127])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C941917AA3;
	Thu, 28 Mar 2024 15:51:57 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH] perf test record.sh: Raise limit of open file descriptors
Date: Thu, 28 Mar 2024 16:46:14 +0100
Message-ID: <20240328155116.16473-1-vmolnaro@redhat.com>
In-Reply-To: <ZfrwcurxSYKy9uma@x1>
References: <ZfrwcurxSYKy9uma@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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
Reworked the patch as the testfile has already changed since the patch
was sent causing the applying to fail. Should be good now.
 tools/perf/tests/shell/record.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 4fbc74805d52..8dc90fa08682 100755
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
2.43.0

