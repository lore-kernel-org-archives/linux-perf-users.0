Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7814A4CC
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Apr 2026 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318367; cv=none; b=H9uto7/bNOAMUWBj2x/K9TaNozdYVfaPmEOL8Hi+ztR57jahbGwWl7lApMXFl/+FXNme3J2QMWAoV4RMJS+M6bI6XeKS5dxu/ENOT23Ol+H2HYfKhz/e/tAtP2x7+uqvqhimdVcGNj2cj3JDasiUxIlvbFuDURcyoi7tagbrwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318367; c=relaxed/simple;
	bh=9CZYIOS6MW8K4vQfgkNIooNT9wafv/gOwWld1nbQyL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pbMNK+Va0yhcHNtGuD5WONx8xs8s6tud7nrOtY89NGDaWyy0Fyxx5G1UTm/IuzivUp/bFuhf5J5wSAWri2esAkAfEH+pVR4nlVxwv1VID61CAfJlgftLF3j4xu6wTYCjOhD3tzYul6idYL0JrPZKBlyEu+cnduwTdfG7V2mBTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lkWQQDdw; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lkWQQDdw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776318356; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=+XDvM7+Kt/WOSfd5G17pJj+WSxgrivA26pXydREI6w4=;
	b=lkWQQDdwmCALo8hb9pW98lLhq4GmYJsC84XADeCUxcDwaTmEwJ4S+IKyprsquQK8quyDNle+cJMsSbKAHIjSZhOBNYWqpBpaqsUyyo4IP0PRUTBcgdGJxdQTeWiIFapYhTIX+hmB4W+jMvndFAMtc+q14iqylPwgy8q85nnhuXs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X178jSk_1776318349;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X178jSk_1776318349 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Apr 2026 13:45:54 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	hpa@zytor.com,
	Kan Liang <kan.liang@linux.intel.com>
Cc: x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com
Subject: [PATCH] perf/x86/intel/uncore: Re-register PMU on PCI device hot-add
Date: Thu, 16 Apr 2026 13:45:49 +0800
Message-Id: <20260416054549.45585-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When an uncore PCI device is removed and then rescanned back, the PMU
and its associated box are unregistered during removal but never
re-registered during the rescan. This causes a NULL pointer dereference
(on box) when the device is removed again.

Reproduction steps:
1. Boot the system with uncore PCI devices enumerated
2. Remove an uncore PCI device (e.g., via sysfs or physical removal)
   - BUS_NOTIFY_DEL_DEVICE triggers uncore_pci_pmu_unregister()
   - pmu->boxes[die] is set to NULL and the box is freed
3. Rescan the PCI bus to re-enumerate the device
   - The PCI device appears again, but uncore does not re-register
     the PMU/box because uncore_pci_pmus_register() only runs during
     module initialization, not on PCI hotplug events
4. Remove the device again
   - BUS_NOTIFY_DEL_DEVICE triggers uncore_pci_pmu_unregister()
   - box = pmu->boxes[die] returns NULL → BUG() / crash

Root cause:
The uncore subsystem only registers PMUs and boxes during module
initialization (uncore_pci_pmus_register). It does not handle PCI
hotplug/rescan events to re-register PMUs when devices reappear.

Fix:
Extend the uncore PCI bus notifier to handle BUS_NOTIFY_ADD_DEVICE
events. When a previously-registered uncore PCI device is re-added,
call uncore_pci_pmu_register() to recreate the box and restore the
PMU state. This ensures that subsequent removal operations work
correctly.

Fixes: 42839ef4a20a ("perf/x86/intel/uncore: Generic support for the PCI type of uncore blocks")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 arch/x86/events/intel/uncore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 786bd51a0d89..211318733a35 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1272,8 +1272,7 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	struct intel_uncore_pmu *pmu;
 	int die;
 
-	/* Unregister the PMU when the device is going to be deleted. */
-	if (action != BUS_NOTIFY_DEL_DEVICE)
+	if (action != BUS_NOTIFY_DEL_DEVICE && action != BUS_NOTIFY_ADD_DEVICE)
 		return NOTIFY_DONE;
 
 	pmu = uncore_pci_find_dev_pmu(pdev, ids);
@@ -1283,7 +1282,16 @@ static int uncore_bus_notify(struct notifier_block *nb,
 	if (uncore_pci_get_dev_die_info(pdev, &die))
 		return NOTIFY_DONE;
 
-	uncore_pci_pmu_unregister(pmu, die);
+	switch (action) {
+	case BUS_NOTIFY_DEL_DEVICE:
+		uncore_pci_pmu_unregister(pmu, die);
+		break;
+	case BUS_NOTIFY_ADD_DEVICE:
+		uncore_pci_pmu_register(pdev, pmu->type, pmu, die);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
 
 	return NOTIFY_OK;
 }
-- 
2.32.0.3.g01195cf9f

