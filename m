Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296617756
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381057; cv=none; b=f3R/AqfVCKujTIxbpNa+eUxxbLRAogP3h7SqDw/oJhhkfPYYmDW+c6TO7cshZgTN33fDPZeBGPR5M4g3XPphUgG6Gb+8QzdPbjvIs1NGmQ5IWfaur2vU+2F4mLFhhrKuM6PdnHorlmvRzPyuw6eP5q+kP8SJPXCwkimUz9UT4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381057; c=relaxed/simple;
	bh=luk3lnPBR/yejRDS8J/t+B60aT0TiAGGLiAkGpijOsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBftCVmTfjzxuEzP3waoRVKizAlqPUxd6rcrxtfG4JcPzHyx3f21JrZ10FZf/AncAZABoToNTUep1sLv4itqiPmyYjuMTQkN+CUni1wmEPuAFdSao1Tx5Ad5pyQyJFugpKJ/ZpZebJXFV6ySZXytoYf26FVAa1MCvvJpRh6OZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/KFWyMN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/KFWyMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714381055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ojv0KKuScOmjHuLArsayBA9l9YZbscqtGMetvNF24Lw=;
	b=Y/KFWyMNESCMvJ+4HZq7qnzZPynn5qmhxDGoIyoMhEMQn1E+TArzqNpkv0ztsLjvg6rSkN
	MBFB1hXpJx7s+7oJQv8e2AiWS/5farwUNZoiri4xZNy2Icp0odjkC3u9Np5f3YQKdLw4/V
	0WBeeqRLY5yjzWVnk4QY2g2YFx+Ws6E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-hJ8e8PMROnqWqHFGZffG2g-1; Mon, 29 Apr 2024 04:57:31 -0400
X-MC-Unique: hJ8e8PMROnqWqHFGZffG2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F09FC830E76;
	Mon, 29 Apr 2024 08:57:30 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.225.237])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D332D5C772;
	Mon, 29 Apr 2024 08:57:29 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH v2] perf test record.sh: Raise limit of open file descriptors
Date: Mon, 29 Apr 2024 10:53:07 +0200
Message-ID: <20240429085721.10122-1-vmolnaro@redhat.com>
In-Reply-To: <ZiqoWj3f-P3ChlWa@x1>
References: <ZiqoWj3f-P3ChlWa@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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
was sent causing the applying to fail, now applying upstream without
problems.
 tools/perf/tests/shell/record.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3d1a7759a7b2..344c0e40ebe8 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -21,6 +21,15 @@ testprog="perf test -w thloop"
 cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
 br_cntr_file="/caps/branch_counter_nr"
 br_cntr_output="branch stack counters"
+default_fd_limit=$(ulimit -n)
+# With option --threads=cpu the number of open file descriptors should be
+# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
+#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
+#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
+# All together it needs 8*nmb_cpus file descriptors plus some are also used
+# outside of testing, thus raising the limit to 16*nmb_cpus
+min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
+
 
 cleanup() {
   rm -rf "${perfdata}"
@@ -190,11 +199,19 @@ test_branch_counter() {
   echo "Basic branch counter test [Success]"
 }
 
+# raise the limit of file descriptors to minimum
+if [[ $default_fd_limit -lt $min_fd_limit ]]; then
+       ulimit -n $min_fd_limit
+fi
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 test_branch_counter
 
+# restore the default value
+ulimit -n $default_fd_limit
+
 cleanup
 exit $err
-- 
2.43.0

