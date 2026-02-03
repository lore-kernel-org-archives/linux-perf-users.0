Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7838214A9B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128197; cv=none; b=CVu3bZffw28gBcpsx3IUFAcc0Akwhhc+cmc+dI3vkoDf+FuswmniKupeBT7g64GLg/1XOP/kb87YbOOYD0jP0tapRpciSN5SEKfdYFjxBzgS/E18ulHuw6huaHF78gVBt3utZz3RznD03lao+Kp2bCD0scAqUDBTS1FglIbchaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128197; c=relaxed/simple;
	bh=EbNa7mwdazSyCzmGEpTruqcEmDOo7hmQZ+69coYfxAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=OTdqbZDxukRkFN3r8ecxn7hFkwieOP5KDYSSxzBRCSp6+iyY672fh8krGiL6tDk5X/LqzIE0YXzr/W4+b0q170yl9DhRgCSyJg3jr145NuS1fO8Ovi7OkbcpxC7Prn/GjV3iqbSY0WW9/YlhSkJrZJKzXSz3LCV+iASOo9vAmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkHvGdDX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkHvGdDX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770128194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OZ9g3SIN9r/HPEHuCbGfcArXDVgkXfYv/gM6R/5xQMg=;
	b=SkHvGdDXNR28qbj0XLStThpVZKEDHlKAdWRh599qif1CiiP2zCcRKbtJp3x4bhFw7hlZdT
	jQIZHP+ChOZ6aNDoYkROvd00A0qYW198qiHEYQRNf2SqgxvAqteI6fQFjIPPBXTkvARiyk
	//cC5O8hEEggVF1Vf76doQQzW/ADUVQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-L9DDmHh7OLu5xvMa4CEvxg-1; Tue,
 03 Feb 2026 09:16:19 -0500
X-MC-Unique: L9DDmHh7OLu5xvMa4CEvxg-1
X-Mimecast-MFC-AGG-ID: L9DDmHh7OLu5xvMa4CEvxg_1770128178
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E201119560A3;
	Tue,  3 Feb 2026 14:16:17 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABAC818007D2;
	Tue,  3 Feb 2026 14:16:13 +0000 (UTC)
From: Qiao Zhao <qzhao@redhat.com>
To: irogers@google.com,
	james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org,
	leo.yan@linux.dev,
	namhyung@kernel.org,
	mpetlan@redhat.com,
	acme@kernel.org,
	vincent.weaver@maine.edu,
	Qiao Zhao <qzhao@redhat.com>
Subject: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
Date: Tue,  3 Feb 2026 22:16:08 +0800
Message-ID: <20260203141608.14128-1-qzhao@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Some architectures control user-space rdpmc access via sysfs or sysctl,
for example /proc/sys/kernel/perf_user_access on arm64/riscv or the
rdpmc attribute under event_source devices on x86_64.

The mmap-based rdpmc tests currently assume rdpmc availability purely
based on perf_event configuration, which leads to false failures when
the system globally disables rdpmc access.

Introduce a helper to detect rdpmc availability via sysfs and skip
user space counter reading tests when rdpmc is disabled by the system.

The check is only applied to USER_READ_ENABLED tests. User-read disabled
tests continue to run unconditionally, as they validate perf_event mmap
semantics independent of rdpmc availability.

Additionally, tighten the unsupported rdpmc check to require a valid
counter index, avoiding false failures when cap_user_rdpmc is set but
no counter is assigned.

v1->v2
- Check rdpmc availability via sysfs before running USER_READ_ENABLED tests
- Handle both perf_user_access and rdpmc sysfs interfaces
- Avoid false failures when cap_user_rdpmc is set but no counter index exists

Testing:
- arm64: rdpmc disabled by perf_user_access (tests correctly skipped)
- x86_64: no behavior change compared to v1

Signed-off-by: Qiao Zhao <qzhao@redhat.com>
---
 tools/perf/tests/mmap-basic.c | 45 +++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..67d6d83dbedb 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -220,6 +220,37 @@ static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_s
 	return old_user_read;
 }
 
+static bool rdpmc_sysfs_enabled(struct perf_pmu *pmu)
+{
+	char buf[8];
+	int events_fd, fd;
+	ssize_t len;
+
+	/* ARM/RISC-V style or similar */
+	fd = open("/proc/sys/kernel/perf_user_access", O_RDONLY);
+	if (fd > 0) {
+		len = read(fd, buf, sizeof(buf));
+		close(fd);
+		if (len > 0)
+			return buf[0] == '1';
+	}
+
+	/* x86_64 style rdpmc file or similar */
+	events_fd = perf_pmu__event_source_devices_fd();
+	if (events_fd >= 0) {
+		fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDONLY);
+		close(events_fd);
+		if (fd >= 0) {
+			len = read(fd, buf, sizeof(buf));
+			close(fd);
+			if (len > 0)
+				return buf[0] == '1';
+		}
+	}
+
+	return false;
+}
+
 static int test_stat_user_read(u64 event, enum user_read_state enabled)
 {
 	struct perf_pmu *pmu = NULL;
@@ -247,7 +278,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		struct perf_evsel *evsel = NULL;
 		int err;
 		struct perf_event_mmap_page *pc;
-		bool mapped = false, opened = false, rdpmc_supported;
+		bool mapped = false, opened = false, rdpmc_supported, sysfs_enabled;
 		struct perf_counts_values counts = { .val = 0 };
 
 
@@ -300,6 +331,16 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		else
 			rdpmc_supported = (enabled == USER_READ_ENABLED);
 
+		if (enabled == USER_READ_ENABLED) {
+			sysfs_enabled = rdpmc_sysfs_enabled(pmu);
+			if (!sysfs_enabled) {
+				pr_debug("User space counter reading for PMU %s [Skip rdpmc disabled by sysfs]\n",
+					pmu->name);
+				ret = TEST_SKIP;
+				goto cleanup;
+			}
+		}
+
 		if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
 			pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
 				pmu->name, pc->cap_user_rdpmc, pc->index);
@@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 			goto cleanup;
 		}
 
-		if (!rdpmc_supported && pc->cap_user_rdpmc) {
+		if (!rdpmc_supported && pc->cap_user_rdpmc && pc->index) {
 			pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
 				pmu->name, pc->cap_user_rdpmc);
 			ret = TEST_FAIL;
-- 
2.49.0

