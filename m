Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfr5TRxO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D6D1B4
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 13:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701379770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eASz2lQk3eM47a/jZZOa+KmSm8eGVLFWVxGcj8gJrMQ=;
	b=dfr5TRxOYc24PKmvmuFaZ1lfsOJewpcOmoF9FtexqcG0yNbZbR8pzq4psr2aG9OQwQYfwW
	cuEBHJ/NuaQpIWInTVO9IFDLZ+rdRUgWbvO+QRQnNc43xjPZLF1MRWE7je6hj0NVovrMoA
	8PDrUHTxluwd63UE+ffsDFvjL8KQkmQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-uuMnSmbDP62bxlpjftTldg-1; Thu, 30 Nov 2023 16:29:27 -0500
X-MC-Unique: uuMnSmbDP62bxlpjftTldg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA720185A780;
	Thu, 30 Nov 2023 21:29:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.14])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A44210E46;
	Thu, 30 Nov 2023 21:29:25 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	vmolnaro@redhat.com
Cc: mpetlan@redhat.com
Subject: [PATCH] perf test record.sh: Raise limit of open file descriptors
Date: Thu, 30 Nov 2023 22:29:24 +0100
Message-ID: <20231130212924.8557-1-vmolnaro@redhat.com>
In-Reply-To: <ZVyjZjPCXVmGGVFk@kernel.org>
References: <ZVyjZjPCXVmGGVFk@kernel.org>
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

