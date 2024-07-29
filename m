Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72B1494AC;
	Mon, 29 Jul 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263539; cv=none; b=QFiy4cwIueHkc1XDOXcB74jen2n5Ry8nkv+x9TZF3u0wAP0M0y88db0XRzPDKbix7Dhe3afAZ0Jp4urit7elWPI892+AfcMv+U5pgf53XQ0b1gboH5VF0zdcqdn5q8e3iky/aA5h78NnI/bo+mNMw8pWlRprJHUd4yPc6gOgxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263539; c=relaxed/simple;
	bh=FkoerdYwKiBNqZ/THKIbD6JIfYJKUyVNO0Qlv6PxoDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lAIpsguJpi7di1BSJH7r8p3hfmAQUJ+thGXrz0plUt7kkB5KNImIrDGQUJjrcFNliG65YClWBuEMcpEtZMGM+C1XY2mjPcdVZyjSv18Eofufpt8dX1skboh5BIEFr71o9tPunOyEh3xhsOdTuEHKqyKL9l9ZvNbAxhWqAmF8wYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXgkS37lrzgYBS;
	Mon, 29 Jul 2024 22:30:24 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D37A180105;
	Mon, 29 Jul 2024 22:32:14 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 22:32:13 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lihuafei1@huawei.com>
Subject: [PATCH] perf/x86/intel: Restrict period on Haswell
Date: Tue, 30 Jul 2024 06:33:28 +0800
Message-ID: <20240729223328.327835-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500004.china.huawei.com (7.202.181.242)

On my Haswell machine, running the ltp test cve-2015-3290 concurrently
reports the following warnings:

  perfevents: irq loop stuck!
  WARNING: CPU: 31 PID: 32438 at arch/x86/events/intel/core.c:3174 intel_pmu_handle_irq+0x285/0x370
  CPU: 31 UID: 0 PID: 32438 Comm: cve-2015-3290 Kdump: loaded Tainted: G S      W          6.11.0-rc1+ #3
  ...
  Call Trace:
   <NMI>
   ? __warn+0xa4/0x220
   ? intel_pmu_handle_irq+0x285/0x370
   ? __report_bug+0x123/0x130
   ? intel_pmu_handle_irq+0x285/0x370
   ? __report_bug+0x123/0x130
   ? intel_pmu_handle_irq+0x285/0x370
   ? report_bug+0x3e/0xa0
   ? handle_bug+0x3c/0x70
   ? exc_invalid_op+0x18/0x50
   ? asm_exc_invalid_op+0x1a/0x20
   ? irq_work_claim+0x1e/0x40
   ? intel_pmu_handle_irq+0x285/0x370
   perf_event_nmi_handler+0x3d/0x60
   nmi_handle+0x104/0x330
   ? ___ratelimit+0xe4/0x1b0
   default_do_nmi+0x40/0x100
   exc_nmi+0x104/0x180
   end_repeat_nmi+0xf/0x53
   ...
   ? intel_pmu_lbr_enable_all+0x2a/0x90
   ? __intel_pmu_enable_all.constprop.0+0x16d/0x1b0
   ? __intel_pmu_enable_all.constprop.0+0x16d/0x1b0
   perf_ctx_enable+0x8e/0xc0
   __perf_install_in_context+0x146/0x3e0
   ? __pfx___perf_install_in_context+0x10/0x10
   remote_function+0x7c/0xa0
   ? __pfx_remote_function+0x10/0x10
   generic_exec_single+0xf8/0x150
   smp_call_function_single+0x1dc/0x230
   ? __pfx_remote_function+0x10/0x10
   ? __pfx_smp_call_function_single+0x10/0x10
   ? __pfx_remote_function+0x10/0x10
   ? lock_is_held_type+0x9e/0x120
   ? exclusive_event_installable+0x4f/0x140
   perf_install_in_context+0x197/0x330
   ? __pfx_perf_install_in_context+0x10/0x10
   ? __pfx___perf_install_in_context+0x10/0x10
   __do_sys_perf_event_open+0xb80/0x1100
   ? __pfx___do_sys_perf_event_open+0x10/0x10
   ? __pfx___lock_release+0x10/0x10
   ? lockdep_hardirqs_on_prepare+0x135/0x200
   ? ktime_get_coarse_real_ts64+0xee/0x100
   ? ktime_get_coarse_real_ts64+0x92/0x100
   do_syscall_64+0x70/0x180
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   ...

My machine has 32 physical cores, each with two logical cores. During
testing, it executes the CVE-2015-3290 test case 100 times concurrently.

This warning was already present in [1] and a patch was given there to
limit period to 128 on Haswell, but that patch was not merged into the
mainline.  In [2] the period on Nehalem was limited to 32. I tested 16
and 32 period on my machine and found that the problem could be
reproduced with a limit of 16, but the problem did not reproduce when
set to 32. It looks like we can limit the cycles to 32 on Haswell as
well.

[1] https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/#r
[2] https://lore.kernel.org/all/1566256411-18820-1-git-send-email-johunt@akamai.com/T/#mf1479ab3f25d3f7f3a899244081baa2e7b7bc0b9

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/events/intel/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0c9c2706d4ec..459dec2f07e3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4625,6 +4625,11 @@ static void glc_limit_period(struct perf_event *event, s64 *left)
 		*left = max(*left, 128LL);
 }
 
+static void hsw_limit_period(struct perf_event *event, s64 *left)
+{
+	*left = max(*left, 32LL);
+}
+
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
 PMU_FORMAT_ATTR(umask,	"config:8-15"	);
 PMU_FORMAT_ATTR(edge,	"config:18"	);
@@ -6767,6 +6772,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
 		x86_pmu.lbr_double_abort = true;
+		x86_pmu.limit_period = hsw_limit_period;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
 		td_attr  = hsw_events_attrs;
-- 
2.25.1

