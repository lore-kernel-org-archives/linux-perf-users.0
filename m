Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF778200A6
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XodS3QPU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE476126
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 06:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700057127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=REn12GzKEVmpRqqAUc+Tpu9Q3BQoa/Me0ZBtIktyTew=;
	b=XodS3QPUNYt9YamB0pdMeWGYze57X1SQdH/qDwAfhXZxGH9pZBYbcPYhwBxAw0db+mG6Me
	ZT/xfu4DrLnRtFJ8OChllFe90wdGz7Dy5cn5k1KhG9gEW3A56mmc1JVnhGMHTIsgOCEXlA
	M6Ry3BFcZ8km18AoiFIF6kYmS6nS+s8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-NIH0BNv8OpW2-c4K2upsGQ-1; Wed, 15 Nov 2023 09:05:25 -0500
X-MC-Unique: NIH0BNv8OpW2-c4K2upsGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEBDF185A785;
	Wed, 15 Nov 2023 14:05:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F0371121306;
	Wed, 15 Nov 2023 14:05:24 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH] perf test record.sh: Raise limit of open file descriptors
Date: Wed, 15 Nov 2023 15:05:22 +0100
Message-ID: <20231115140522.28200-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Veronika Molnarova <vmolnaro@redhat.com>

Subtest for system-wide record with '--threads' option fails due to a
limit of open file descriptors(usually set to 1024) on systems with
128 and more CPUs.

If the default limit is set lower than 2048 file descriptors,
temporarily raise it to this value for the test.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/record.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 4fbc74805d52..c6c43263809a 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -11,6 +11,8 @@ err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 testprog="perf test -w thloop"
 testsym="test_loop"
+min_fd_limit=2048
+default_fd_limit=$(ulimit -n)
 
 cleanup() {
   rm -rf "${perfdata}"
@@ -154,10 +156,16 @@ test_workload() {
   echo "Basic target workload test [Success]"
 }
 
+if [[ $default_fd_limit -lt $min_fd_limit ]]; then
+	ulimit -n $min_fd_limit
+fi
+
 test_per_thread
 test_register_capture
 test_system_wide
 test_workload
 
+ulimit -n $default_fd_limit
+
 cleanup
 exit $err
-- 
2.41.0

