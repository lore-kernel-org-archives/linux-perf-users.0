Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1c6wQf8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE5C10D9
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701380561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eASz2lQk3eM47a/jZZOa+KmSm8eGVLFWVxGcj8gJrMQ=;
	b=T1c6wQf8css9CoHoL4Zc6a96rE7/hDN2bsmLc6UWBwsOTsGsn8Vl416bcMxJhPUzyNXBYz
	uGYp6Plydj53RJ9fEc7/4sC+Xmia8nahBBxifjSZr0uBKvHX6ACYqMnJEFu/NflryN7f31
	MzJUUBQoqoltjDLfgqXYlqeLw5yPxpE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-RPwjbh3QNrq4rAVzjtGObw-1; Thu,
 30 Nov 2023 16:42:38 -0500
X-MC-Unique: RPwjbh3QNrq4rAVzjtGObw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F58A29ABA0E;
	Thu, 30 Nov 2023 21:42:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 770B710EA5;
	Thu, 30 Nov 2023 21:42:37 +0000 (UTC)
From: vmolnaro@redhat.com
To: vmolnaro@redhat.com,
	linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Subject: [PATCH v2] perf test record.sh: Raise limit of open file descriptors
Date: Thu, 30 Nov 2023 22:42:36 +0100
Message-ID: <20231130214236.9051-1-vmolnaro@redhat.com>
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

