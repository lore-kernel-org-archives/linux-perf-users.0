Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D624CA28D;
	Wed, 29 Jul 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336971; cv=none; b=mY6WIghuupVBVQMQQdVJ4xZKQ6+VE21rMv6Xx5WYsvKTySaC7Bvoq1doTK50KTvYSruOBPMj6synkqCdyPwBRUuDhgEujVHckvcFCBtqQrBaXoeoopSntHEiqF4EMb1cIur3B02L7oLr0KNhS9l8EDgQueGxNKiHfw/3mMrcOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336971; c=relaxed/simple;
	bh=HT3sUf4pdlmof1XQzq7kOxMdQrvWfp/x9aSv3ASpECw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy3iee3E0RP90sOdTm9S4tXLVDsYCc2OXTE1hNw6Gyh1fJ73ItX08OVhQK9oRLU46S/IqsQrmAQ//5/3/beRUoDh0LgVHHlg04VgrDca+iItDu+aoXCOkxKnqX5wlAvQBfHqIlT7zdFGsNihSaIAPN+OoGoYVphoQeqwskW32+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E841F000E9;
	Wed, 29 Jul 2026 14:56:10 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 9/9] perf/cxl: Avoid cpumask_of(-1) when no CPU is assigned
Date: Wed, 29 Jul 2026 07:55:55 -0700
Message-ID: <20260729145555.3919550-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145555.3919550-1-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask_show() feeds info->on_cpu straight into cpumask_of() for the
world-readable cpumask sysfs attribute. on_cpu is -1 before the first
hotplug online callback and transiently in cxl_pmu_offline_cpu() before a
new target is chosen. cpumask_of(-1) treats the CPU number as unsigned and
does out-of-bounds pointer arithmetic in get_cpu_mask(), so a concurrent
read of the attribute dereferences a wild pointer and can fault -- a local
denial of service.

Read on_cpu once and emit an empty mask when it is negative.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index f42238b2b6b0..6aad381c0376 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -501,8 +501,17 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct cxl_pmu_info *info = dev_get_drvdata(dev);
+	int cpu = READ_ONCE(info->on_cpu);
 
-	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
+	/*
+	 * on_cpu is -1 before the first online callback and transiently during
+	 * cxl_pmu_offline_cpu(). cpumask_of(-1) computes an out-of-bounds
+	 * pointer, so report an empty mask instead.
+	 */
+	if (cpu < 0)
+		return sysfs_emit(buf, "\n");
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(cpu));
 }
 static DEVICE_ATTR_RO(cpumask);
 
-- 
2.55.0

