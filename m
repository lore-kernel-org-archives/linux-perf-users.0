Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3938485935;
	Wed, 30 Sep 2026 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809920; cv=none; b=FV/QxSRSYA8bxFp5rzyPcEJHPYqIcmzMkyLFnWGPy03aZB5WxZT7UdgmRtuvkDwXtSHLxicmwAlnknX9eNNEoQhBPD4P2S08RU9Cl5cPyGuE37feLHhmPcwwN1DXQeTNt5fVhweHHFiaMOKk6Q+I9OzHBqQoTKxjoF19CNzGvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809920; c=relaxed/simple;
	bh=hgo9uoT4tchRHqcgvD4dlxMtrU3V4PIL+9of6kxv+nU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aaj/esRSjJz8wXzpOuwGaP0bI0lbs6SQEQlERi/aaMLVz4sGcKWhnOiPNu5dgOu+IlMjR3TzSRbeDhZ4z4L/scmC0C2xUUXr2K+kJnM0jEnscdv2w93CL1AOazxxB24nWFs0NTOf9TJ6FOgD87zgDSUowgv58EDAE0zVz1qV59c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qFDu3j35; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qFDu3j35"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790809915; x=1822345915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQbvrPde+OrHghCdEsygXprSEkwsxJSA8PZNB/95K18=;
  b=qFDu3j35wraVfF1w9R2eaGKjxzyx75XIGe+EZ4JwmTh1RhzGvHk1d/ON
   4WXTZ/6JjuAqLxBFzTtLD398uC0H0JDQ3J92twX/UITwNjN6HncMeLJbp
   mkKLu9rQV1+TAxlQmVoIVqdz8Z9vZYrh39FAJaNST6+c3UBZvhCpIUs0X
   8fcmKL8OY+mHNvxGtFfFQWoVJdgprDen+Nbkq9zhuT2OpQcJTGOTEuu5B
   CN63UwGRW8CNt7+uNHC5w+VIPCu0i7ooIx2zkHj4M6LpLFGaJ6NqlL7Px
   lulrVv4H30JM1xevUxU7FKAONOocZVWliM61ZSVbFkFJ9hldzU/R6Tlf8
   g==;
X-CSE-ConnectionGUID: B03tRbnNQPGYvWESfMmWSA==
X-CSE-MsgGUID: r5hzBHL+Qy27irkFeF2Yzw==
X-IronPort-AV: E=Sophos;i="6.27,133,1787011200"; 
   d="scan'208";a="30123055"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 23:11:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:19945]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.131:2525] with esmtp (Farcaster)
 id 7d9e45ef-53a4-4d07-a5cb-784678d52f7d; Wed, 30 Sep 2026 23:11:52 +0000 (UTC)
X-Farcaster-Flow-ID: 7d9e45ef-53a4-4d07-a5cb-784678d52f7d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 23:11:51 +0000
Received: from u34cccd802f2d52.amazon.com (10.106.239.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 23:11:50 +0000
From: Haris Okanovic <harisokn@amazon.com>
To: <robin.murphy@arm.com>, <mark.rutland@arm.com>, <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<harisokn@amazon.com>
Subject: [PATCH v2 2/2] perf/arm-cmn: Allow userspace to select the PMU's CPU
Date: Wed, 30 Sep 2026 18:11:27 -0500
Message-ID: <20260930231127.3094040-3-harisokn@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930231127.3094040-1-harisokn@amazon.com>
References: <20260930231127.3094040-1-harisokn@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

arm_cmn_probe() picks the CPU that owns the PMU with

	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));

and arm_cmn_event_init() then binds every event to it unconditionally.
That choice is only revisited by the CPU hotplug callbacks, so in
practice the PMU stays on the first CPU local to the interconnect's NUMA
node, which is usually CPU 0.

All of the PMU's recurring work therefore lands on one CPU. This is
problematic on systems which reserve particular CPUs for latency
sensitive work or confine background activity to a chosen set of
housekeeping CPUs.

There is no way to set it explicitly. perf_event_open() and 'perf stat
-C' have no effect because arm_cmn_event_init() overwrites event->cpu;
/proc/irq/*/smp_affinity is refused for the DTC interrupts, which are
requested with IRQF_NOBALANCING because their affinity has to follow the
owning CPU.

Make the existing 'cpumask' attribute writable. It already reports the
CPU which owns the PMU; writing a CPU number now migrates the PMU there
via the existing arm_cmn_migrate(), which moves the perf contexts and
the DTC interrupt affinity together. Since the PMU has a single owning
CPU, anything other than one CPU number is rejected.

The attribute expresses a preference rather than a guarantee. The
hotplug callbacks may still move the PMU, for example when the chosen
CPU is offlined.

Signed-off-by: Haris Okanovic <harisokn@amazon.com>
---
 Documentation/admin-guide/perf/arm-cmn.rst | 18 ++++++++++
 drivers/perf/arm-cmn.c                     | 40 +++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf/arm-cmn.rst b/Documentation/admin-guide/perf/arm-cmn.rst
index 796e25b7027b2..bf75b686cef76 100644
--- a/Documentation/admin-guide/perf/arm-cmn.rst
+++ b/Documentation/admin-guide/perf/arm-cmn.rst
@@ -44,6 +44,24 @@ given type. To target a specific node, "bynodeid" must be set to 1 and
 "nodeid" to the appropriate value derived from the CMN configuration
 (as defined in the "Node ID Mapping" section of the TRM).
 
+CPU affinity
+------------
+
+The driver also provides a "cpumask" sysfs attribute, which contains a
+single CPU ID, of the processor which will be used to handle all the CMN
+PMU events.
+
+The attribute is writable, and accepts a single CPU ID to move the PMU
+to that processor, for instance to keep counter reads, interrupt handling
+and event rotation away from CPUs reserved for latency sensitive work::
+
+  $# echo 5 > /sys/bus/event_source/devices/arm_cmn_0/cpumask
+
+This expresses a preference rather than a guarantee. In case of the
+chosen processor being offlined, or a processor local to the
+interconnect's NUMA node coming online while the chosen one is not, the
+events and interrupts are migrated and the attribute is updated.
+
 Watchpoints
 -----------
 
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index a5593e5821925..1f114ac3f0700 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -5,6 +5,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -12,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
@@ -404,6 +406,8 @@ struct arm_cmn_nodeid {
 	u8 dev;
 };
 
+static void arm_cmn_migrate(struct arm_cmn *cmn, unsigned int cpu);
+
 static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
 {
 	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
@@ -1519,8 +1523,42 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
 	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpumask_of(cmn->cpu)));
 }
 
+static ssize_t arm_cmn_cpumask_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	static DEFINE_MUTEX(cpumask_mutex);
+
+	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
+	unsigned int cpu;
+	int err;
+
+	err = kstrtouint(buf, 0, &cpu);
+	if (err)
+		return err;
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	/* Serialises multiple writers against each other */
+	mutex_lock(&cpumask_mutex);
+	/* Blocks hotplug during write */
+	cpus_read_lock();
+
+	if (!cpu_online(cpu))
+		err = -EINVAL;
+	else if (cpu != cmn->cpu)
+		arm_cmn_migrate(cmn, cpu);
+
+	cpus_read_unlock();
+	mutex_unlock(&cpumask_mutex);
+
+	return err ?: count;
+}
+
 static struct device_attribute arm_cmn_cpumask_attr =
-		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
+		__ATTR(cpumask, 0644, arm_cmn_cpumask_show,
+		       arm_cmn_cpumask_store);
 
 static ssize_t arm_cmn_identifier_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
-- 
Haris Okanovic
AWS Graviton

