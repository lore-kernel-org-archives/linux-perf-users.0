Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID9CFvSi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9CA19D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Nov 2023 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700140864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=t4PYFP0mc1q9xM0NUsWH7XJrdNwuM+GsguInSrQQA1U=;
	b=ID9CFvSilmSBs87t/FHkfRzXms2NoceR60FeAsl/ESRUCFixy8GdWLpWOv5Wk2b5GHrBzX
	sbxvbm31JoKOcNwN2eekdMa3lbizs9OrngHvXUpoHkwYtj3Tro7RspasL1XyGsZU9/dKSR
	xmNCfR9kKxs9zWdhjMwWjkcIRkSRCgw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-3oZBZTl-NvmOqJXD5DW4nA-1; Thu, 16 Nov 2023 08:21:00 -0500
X-MC-Unique: 3oZBZTl-NvmOqJXD5DW4nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63C9F88261D;
	Thu, 16 Nov 2023 13:21:00 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.41])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7693D1C060BA;
	Thu, 16 Nov 2023 13:20:58 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org
Cc: acme@redhat.com,
	vmolnaro@redhat.com,
	tmricht@linux.ibm.com
Subject: [PATCH] perf test record+probe_libc_inet_pton: Fix call chain match on ppc64le
Date: Thu, 16 Nov 2023 14:20:56 +0100
Message-Id: <20231116132056.31657-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

The test case probe libc's inet_pton & backtrace it with ping fails with
updated glibc on ppc64le. It appears to be related to commits:
  1f85d016768f ("perf test record+probe_libc_inet_pton: Fix call chain match on x86_64")
  311693ce81c9 ("perf test record+probe_libc_inet_pton: Fix call chain match on s390")

In ppc64le case, "gaih_inet" does not show up in the call chain anymore.

Output before:

  # perf test -vvv inet_pton
   85: probe libc's inet_pton & backtrace it with ping                 :
  --- start ---
  test child forked, pid 126720
  ping 126748 [006] 79153.090766: probe_libc:inet_pton: (7fff8ef35488)
  7fff8ef35488 __GI___inet_pton+0x8 (/usr/lib64/libc.so.6)
  7fff8eee3a3c getaddrinfo+0x12fc (/usr/lib64/libc.so.6)
  FAIL: expected backtrace entry "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6\)$" got "7fff8eee3a3c getaddrinfo+0x12fc (/usr/lib64/libc.so.6)"
  test child finished with -1
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: FAILED!

Output after:

  # perf test -vvv inet_pton
   85: probe libc's inet_pton & backtrace it with ping                 :
  --- start ---
  test child forked, pid 126996
  ping 127024 [007] 79698.558646: probe_libc:inet_pton: (7fff97445488)
  7fff97445488 __GI___inet_pton+0x8 (/usr/lib64/libc.so.6)
  7fff973f3a3c getaddrinfo+0x12fc (/usr/lib64/libc.so.6)
  108323534 main+0x824 (/usr/bin/ping)
  test child finished with 0
  ---- end ----
  probe libc's inet_pton & backtrace it with ping: Ok

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index eebeea6bdc76..e8f988ffecf0 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -45,7 +45,6 @@ trace_libc_inet_pton_backtrace() {
 		;;
 	ppc64|ppc64le)
 		eventattr='max-stack=4'
-		echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" >> $expected
 		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
 		;;
-- 
2.18.4

