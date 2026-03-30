Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8BF381AF7
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861219; cv=none; b=GkmM0cfrQo78/B0FxZCLVT/RsPc1Ob+80CYawv9SII+iIkXoqsaef2e9ttMRbGpoy7BaUxmtKasxeynVszI4g/RiK+TGzaPnRGcelB6CrVnwdwZigkpUw/wmpOFeOmKqHPxGTQa/FR4lTAD7z3AhE+v/tsWuQrO+NdhzaQTBPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861219; c=relaxed/simple;
	bh=Cp8YO84b5c8V5gcmuNpJ4guSpIdbShwq7IlHaMQLlwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=IRAbNJIP0zo4zl1eiLTpVYO8Xu3SB1R79JVRUEAgmZQyex5pLIwRuzN6+WPp3vXZaQpROHjHfeVJDHGE32Qj6rsd7SO7dmDQ5oXKGSsi3T3i7y973IYwe4AJBl1PiMVNyghJT3a7MgpqnLvlSgjNr0P00OKoaXkMbSWeQihyUew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a91iVF9W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a91iVF9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774861217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tvSIu6qWHWvd0uZmO2xMrIyYCpNTJ1h2iS4FhbIbdzU=;
	b=a91iVF9WkmpaqWmCGl4BPdfwSD0DXbb9oBGKGVtnoY9OfXGxu8tdEheaqLp1f8wrURZ/jJ
	KNxbbNqG4KEMgl8jFRuMQQq+W4IgPAbpRTyLNnJs5S/beFrcjx8Pc0yP5YkNVaMQ65+iyO
	reH7LVom8WN0egEDNTLXhgnyrMhlkLg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-xG8wfx0nM-6ENYPWadd6Yw-1; Mon,
 30 Mar 2026 05:00:13 -0400
X-MC-Unique: xG8wfx0nM-6ENYPWadd6Yw-1
X-Mimecast-MFC-AGG-ID: xG8wfx0nM-6ENYPWadd6Yw_1774861211
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8736195606F;
	Mon, 30 Mar 2026 09:00:11 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 174A81800361;
	Mon, 30 Mar 2026 09:00:07 +0000 (UTC)
From: Qiao Zhao <qzhao@redhat.com>
To: irogers@google.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	leo.yan@linux.dev,
	namhyung@kernel.org,
	acme@kernel.org,
	mpetlan@redhat.com,
	Qiao Zhao <qzhao@redhat.com>
Subject: [RESEND PATCH v3] perf tests: mmap-basic: fix user rdpmc detection logic
Date: Mon, 30 Mar 2026 17:00:02 +0800
Message-ID: <20260330090003.656540-1-qzhao@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The mmap-basic test incorrectly determined rdpmc availability in
several environments, leading to unexpected failures on arm64 and
other architectures.

Previously the rdpmc capability decision lived in test_stat_user_read(),
which caused inconsistent behaviour when:
 - perf_user_access sysctl state is unknown
 - architectures expose cap_user_rdpmc differently
 - arm64 platforms where rdpmc semantics differ from x86

As suggested during review, move the rdpmc capability decision into
set_user_read() so that the user_read state and expected behavior
are decided in a single place.

Changes in v3:
 - Moves perf_user_access handling into set_user_read()
 - Simplify test_stat_user_read() expectation logic
 - Use unified rdpmc_supported calculation
 - Handle USER_READ_UNKNOWN consistently

v2:
https://lore.kernel.org/linux-perf-users/20260203141608.14128-1-qzhao@redhat.com/

v1:
https://lore.kernel.org/linux-perf-users/20260120090522.1193981-1-qzhao@redhat.com/

Note:
A potential cleanup around perf_event.h mentioned during review is
intentionally deferred and will be handled in a follow-up change
to keep this fix minimal and focused.

Tested on:
 - ARM64 (armv8_pmuv3): all mmap-basic user-space counter tests pass
 - X86(include hybrid): all mmap-basic tests pass
 - IBM Power9: all mmap-basic tests pass

Signed-off-by: Qiao Zhao <qzhao@redhat.com>
---
 tools/perf/tests/mmap-basic.c | 55 +++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..3633e7c87dc1 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -185,38 +185,57 @@ static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_s
 {
 	char buf[2] = {0, '\n'};
 	ssize_t len;
-	int events_fd, rdpmc_fd;
+	int events_fd, fd;
 	enum user_read_state old_user_read = USER_READ_UNKNOWN;
 
 	if (enabled == USER_READ_UNKNOWN)
 		return USER_READ_UNKNOWN;
 
+	// Try the PMU rdpmc sysfs interface or similar
 	events_fd = perf_pmu__event_source_devices_fd();
-	if (events_fd < 0)
-		return USER_READ_UNKNOWN;
-
-	rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
-	if (rdpmc_fd < 0) {
+	if (events_fd >= 0) {
+		fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
+		if (fd >= 0) {
+			len = read(fd, buf, sizeof(buf));
+			if (len == sizeof(buf))
+				old_user_read = (buf[0] == '1') ?
+					USER_READ_ENABLED :
+					USER_READ_DISABLED;
+
+			if (enabled != old_user_read) {
+				buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
+				len = write(fd, buf, sizeof(buf));
+				if (len != sizeof(buf))
+					pr_debug("%s write failed\n", __func__);
+			}
+			close(fd);
+			close(events_fd);
+			return old_user_read;
+		}
 		close(events_fd);
-		return USER_READ_UNKNOWN;
 	}
 
-	len = read(rdpmc_fd, buf, sizeof(buf));
-	if (len != sizeof(buf))
-		pr_debug("%s read failed\n", __func__);
+	// Fallback: perf_user_access interface (arm64, riscv, or similar)
+	fd = open("/proc/sys/kernel/perf_user_access", O_RDWR);
+	if (fd < 0)
+		return USER_READ_UNKNOWN;
 
 	// Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
 	// all the core PMUs.
-	old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
+	len = read(fd, buf, sizeof(buf));
+	if (len == sizeof(buf))
+		old_user_read = (buf[0] == '1') ?
+			USER_READ_ENABLED :
+			USER_READ_DISABLED;
 
 	if (enabled != old_user_read) {
 		buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
-		len = write(rdpmc_fd, buf, sizeof(buf));
+		len = write(fd, buf, sizeof(buf));
 		if (len != sizeof(buf))
 			pr_debug("%s write failed\n", __func__);
 	}
-	close(rdpmc_fd);
-	close(events_fd);
+
+	close(fd);
 	return old_user_read;
 }
 
@@ -295,12 +314,16 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 			goto cleanup;
 		}
 
+#if defined(__aarch64__) || defined(__riscv)
+		rdpmc_supported = pc->cap_user_rdpmc;
+#else
 		if (saved_user_read_state == USER_READ_UNKNOWN)
-			rdpmc_supported = pc->cap_user_rdpmc && pc->index;
+			rdpmc_supported = pc->cap_user_rdpmc;
 		else
 			rdpmc_supported = (enabled == USER_READ_ENABLED);
+#endif
 
-		if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
+		if (rdpmc_supported && !pc->cap_user_rdpmc) {
 			pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
 				pmu->name, pc->cap_user_rdpmc, pc->index);
 			ret = TEST_FAIL;
-- 
2.49.0

