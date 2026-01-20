Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45923BC4EC
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899938; cv=none; b=OLbncWgXmED24+i3DAzgL7UkBDBZL8/N/G5Iz1g6Mo0DrfjxezI109cgGR3vvVW0/bwz+hQnpNQNAGb/aJBPerHdJddfVJHcuvg/af1mhb1/3mPmSd12BcOvZTtbfSB011UOy2NKYZF9wGgR57D1rELQIHxtzclDCwp8vIkD2UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899938; c=relaxed/simple;
	bh=FlUghQMBHtVkOp6ClfW9o/MoVRuAN2Y9rQwFxif1sGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Fye4P6A8oFHvjYCV9d4DDi+TrBy6Fn3D7fep1cT7/si4lLRq7rX4pV/xKkopEPQoBOI/oOFhaWZkJzInQ21NQ7xYBFY5S9+sUoPka6KNV9Oz/QVpd2v4+woTZz6eB41bnxySA9xswDRtNRS3UVhKfuWHn4l4ioP/LsqfgQja2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lrso4+xC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lrso4+xC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768899935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bov6DIY6+UC71LWKeADGDcUBYekVe0uLC+ngoN2+n9g=;
	b=Lrso4+xCMwl+/I1pqMQcCs+LIi0SMwoPnB+5Nv4NTpfPy2PQZ/qjbCMYSnVbhzIYxIJGtm
	CN+GQ+dpfPD4V7RENL2LRhigsY9zHeeEjyf9CKxRtEZf6lXFNIo17vjAq4VRL9ZCd6uNC0
	KxlDrOxm+i+MZCLR9Yq7PFJyZ2frBlA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-DUDSScboMQiHazz7_wEp0Q-1; Tue,
 20 Jan 2026 04:05:31 -0500
X-MC-Unique: DUDSScboMQiHazz7_wEp0Q-1
X-Mimecast-MFC-AGG-ID: DUDSScboMQiHazz7_wEp0Q_1768899930
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09D34180047F;
	Tue, 20 Jan 2026 09:05:30 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CA9718008FF;
	Tue, 20 Jan 2026 09:05:26 +0000 (UTC)
From: Qiao Zhao <qzhao@redhat.com>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mpetlan@redhat.com,
	acme@kernel.org,
	Qiao Zhao <qzhao@redhat.com>
Subject: [PATCH] perf tests: mmap: skip user counter tests when runtime PMU access is unavailable
Date: Tue, 20 Jan 2026 17:05:22 +0800
Message-ID: <20260120090522.1193981-1-qzhao@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On some platforms (e.g. ARM systems with restricted PMU access), user space
PMU counters may be reported as supported but blocked at runtime. Failing
the mmap interface tests in this case is incorrect.

[Test Log]
124.2: User space counter reading of instructions                    : FAILED!
--- start ---
User space counter reading 0
User space counter reading for PMU armv8_pmuv3_0
User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected unsupported counter access 1]
---- end ----
124.3: User space counter reading of cycles                          : FAILED!
--- start ---
User space counter reading 1
User space counter reading for PMU armv8_pmuv3_0
User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected unsupported counter access 1]
---- end ----
[/Test Log]

Skip the user counter mmap tests when runtime PMU access is not available,
while preserving failure for genuinely inconsistent states.

Signed-off-by: Qiao Zhao <qzhao@redhat.com>
---
 tools/perf/tests/mmap-basic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..4881a641749b 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		}
 
 		if (!rdpmc_supported && pc->cap_user_rdpmc) {
-			pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
+			pr_debug("User space counter reading for PMU %s is not supported (cap_user_rdpmc=%d), skipping!\n",
 				pmu->name, pc->cap_user_rdpmc);
-			ret = TEST_FAIL;
+			ret = TEST_SKIP;
 			goto cleanup;
 		}
 
-- 
2.49.0

