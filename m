Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52A539789;
	Tue, 13 Oct 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917802; cv=none; b=qFNxpEqTjrFkinxVYGvwnyVVWHwKkxXgQ2szvgNm/LziAuZYt2GLtMLiXI3HlGR8qmKbYaNDRYI8p1bXUm74j1L3qTRgw9OTqw/8Uh5CDloLDfNsRXmkwc88K8tB2DoRWiR3mqlrgSormM6JbkaMFgkaYvgHOrP3ZYnAAeqp+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917802; c=relaxed/simple;
	bh=dRv+YoETP1Q6D9oZWCkvgyCJX5durAfdB7uYuaiP2Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzL20IgjFaTJUeP4T86D59dcZjbcamdP2x23QzgCg87aTMoml7vW/UZhF99eV+QAFZBLv0QWI8r62qJiguDKxNORgCltdB1wDZa6/ZLvDUtcXI1IRZ2bao4fVUgEYioBCeLzP52vVHXvN3z7hW+j/eLvPXj7PUb72OIXfP7GiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WSvo5ReE; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WSvo5ReE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791917801; x=1823453801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nGCOZnY2X3Y+Ss5k0gHETCUcHvQLg2UjcEz3muWhT2k=;
  b=WSvo5ReEM+nY6920PSIOZlL0Odx1NUEXrhTr5NnSOtLsbsNVcpWYQooj
   HFkXpxEUBsPAuXHbqxQKimiw7cSbFAjLUWXr/zANNtZM64BtWbgGuG1FH
   5pgv49XLdz0Ckfelq7QcfUYHPvzE5bVi5Fji8JbjQBZmIjrUqkGTnZnHX
   ZWXLpLRGSSmtaoNPuoxjaRLclXqd7y+VOpqsoH4WKzW6GiaXhrD4WjGGp
   77VnRpSzoy2B+ksM8Mw/4oBndKIj8Qt46jf94BxplPEn5Ir5BdNF/AM8e
   UKTNf+OubHC+ZXesMdKoN5D00GUEW+wtmLedfdeu7Tma02HcoJCsDr0vT
   A==;
X-CSE-ConnectionGUID: pP9gmpf2Ql+chWzsdYhrMQ==
X-CSE-MsgGUID: uICaBopsT2inaPbcvy+P4w==
X-IronPort-AV: E=Sophos;i="6.27,156,1787011200"; 
   d="scan'208";a="31152697"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 18:56:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:30840]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.46:2525] with esmtp (Farcaster)
 id 63871ec4-98d0-47eb-8e45-7c147d8c375b; Tue, 13 Oct 2026 18:56:35 +0000 (UTC)
X-Farcaster-Flow-ID: 63871ec4-98d0-47eb-8e45-7c147d8c375b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 18:56:35 +0000
Received: from u34cccd802f2d52.amazon.com (10.187.170.30) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 18:56:34 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <harisokn@amazon.com>
Subject: [PATCH 3/4] perf/core: Allow userspace to select a device PMU's CPU
Date: Tue, 13 Oct 2026 13:56:02 -0500
Message-ID: <20261013185603.1347265-4-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013185603.1347265-1-harisokn@amazon.com>
References: <20261013185603.1347265-1-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

perf core picks the CPU a "device" PMU (PERF_PMU_SCOPE_DEVICE) is
counted on when the PMU registers, and perf_try_init_event() then binds
every event to it. That choice is only revisited on CPU hotplug and
there is no way for users to set it explicitly, so in practice the PMU
stays wherever it was first placed.

All of the PMU's recurring work therefore lands on one CPU. This is
problematic on systems which reserve particular CPUs for latency
sensitive work or confine background activity to a chosen set of
housekeeping CPUs.

Make the 'cpumask' attribute writable for device scope, allowing users
to rebind PMU devices outside of hotplug by writing an arbitrary CPU
set. The same migration rules apply: user chosen CPU sets must contain
an online CPU that's accepted by the PMU driver's filter. Writes fail
with -ENODEV when none of the given CPUs satisfy these constraints.

The attribute expresses a preference rather than a guarantee. Hotplug
may still move the PMU, e.g. when the user chosen CPU is offlined.

Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 kernel/events/core.c | 46 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0d4e2c6d71584..fe048704ef4a1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12777,7 +12777,40 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
 	return 0;
 }
 
-static DEVICE_ATTR_RO(cpumask);
+/*
+ * Move a device PMU to one of the CPUs written here. The PMU gets the final
+ * say: the write fails if it cannot be counted on any of them.
+ */
+static ssize_t cpumask_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	cpumask_var_t requested;
+	ssize_t ret;
+
+	if (pmu->scope != PERF_PMU_SCOPE_DEVICE)
+		return -EOPNOTSUPP;
+
+	if (!zalloc_cpumask_var(&requested, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret = cpulist_parse(buf, requested);
+	if (ret)
+		goto out;
+
+	mutex_lock(&pmus_lock);
+	ret = perf_pmu_set_cpu(pmu, requested);
+	mutex_unlock(&pmus_lock);
+
+	if (!ret)
+		ret = count;
+out:
+	free_cpumask_var(requested);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RW(cpumask);
 
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
@@ -12796,8 +12829,15 @@ static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int
 		return 0;
 
 	/* cpumask */
-	if (n == 3 && pmu->scope == PERF_PMU_SCOPE_NONE)
-		return 0;
+	if (n == 3) {
+		/* Writable, the core picks the CPU. See cpumask_store(). */
+		if (pmu->scope == PERF_PMU_SCOPE_DEVICE)
+			return a->mode;
+		if (pmu->scope == PERF_PMU_SCOPE_NONE)
+			return 0;
+		/* A scope cpumask follows the CPU topology, read-only. */
+		return 0444;
+	}
 
 	return a->mode;
 }
-- 
Haris Okanovic
AWS Graviton

