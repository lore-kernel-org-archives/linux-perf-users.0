Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VboVc8LW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF83E129
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 11:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701460003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5bAOLpYJ2nJlzCe8j/QXYogtqZvLNOuGnLuLyxl8bsY=;
	b=VboVc8LW6RhNvjNW6g8RixuD/4KYM1oM3Uo6Mkn106DIJ3R5UUPgOf+EtrjR+5gEEsCFiR
	JZYHucZ6LhNcHQAGWY+7RNtQ8eckZNQqi8lBYWNWMFpfNOcFc7G9+kQpoIo4z419Mq7xCf
	Rz8dr30X/JW+da3OtY4fZHyYwh2TDs4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-tsZXnde5O5O6N81ZRvNlUA-1; Fri, 01 Dec 2023 14:46:40 -0500
X-MC-Unique: tsZXnde5O5O6N81ZRvNlUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05E7F918561;
	Fri,  1 Dec 2023 19:46:40 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 466F310EA5;
	Fri,  1 Dec 2023 19:46:38 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	vmolnaro@redhat.com
Cc: mpetlan@redhat.com,
	leo.yan@linaro.org,
	james.clark@arm.com
Subject: [PATCH] perf test record user-regs: Fix mask for vg register
Date: Fri,  1 Dec 2023 20:46:17 +0100
Message-ID: <20231201194617.13012-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

From: Veronika Molnarova <vmolnaro@redhat.com>

The 'vg' register for arm64 shows up in --user_regs as available when
masking the variable AT_HWCAP with 1 << 22 returns '1' as done in
perf_regs.c. However, in subtests for support of SVE, the check for
the 'vg' register is done by masking the variable AT_HWCAP with the value
0x200000 which is equals to 1 << 21 instead of 1 << 22. This results in
inconsistencies on certain systems where the test expects that the 'vg'
register is not operational when it is, and vice-versa.

During the testing on a machine that the test expected not to have the
'vg' register available, the perf record with option --user-regs showed
records for the 'vg' register together with all of the others, which
means that the mask for the subtest of perf_event_attr is off by one.
Change the value of the mask from 0x200000 to 0x400000 to correct it.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64 | 2 +-
 tools/perf/tests/attr/test-record-user-regs-sve-aarch64    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64 b/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
index fbb065842880..bed765450ca9 100644
--- a/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
+++ b/tools/perf/tests/attr/test-record-user-regs-no-sve-aarch64
@@ -6,4 +6,4 @@ args    = --no-bpf-event --user-regs=vg kill >/dev/null 2>&1
 ret     = 129
 test_ret = true
 arch    = aarch64
-auxv    = auxv["AT_HWCAP"] & 0x200000 == 0
+auxv    = auxv["AT_HWCAP"] & 0x400000 == 0
diff --git a/tools/perf/tests/attr/test-record-user-regs-sve-aarch64 b/tools/perf/tests/attr/test-record-user-regs-sve-aarch64
index c598c803221d..a65113cd7311 100644
--- a/tools/perf/tests/attr/test-record-user-regs-sve-aarch64
+++ b/tools/perf/tests/attr/test-record-user-regs-sve-aarch64
@@ -6,7 +6,7 @@ args    = --no-bpf-event --user-regs=vg kill >/dev/null 2>&1
 ret     = 1
 test_ret = true
 arch    = aarch64
-auxv    = auxv["AT_HWCAP"] & 0x200000 == 0x200000
+auxv    = auxv["AT_HWCAP"] & 0x400000 == 0x400000
 kernel_since = 6.1
 
 [event:base-record]
-- 
2.41.0

