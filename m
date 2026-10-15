Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C55469850;
	Thu, 15 Oct 2026 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044319; cv=fail; b=bi4z6GbuZLBYSgm2hedRh4mUu57fm1hVBV+zVwW17uVGyGDFBMw0DrA2tXENo6gNmm51wj0QlTeQcNfdOA6Yg2Jwdd7LVh2P3L9r1tyH54mWVdTwaVFsDGbGycIdByKtM7qGoKoMs4x0xHCPf/ETrVQVlD8bw/cIeeEwh/CR8y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044319; c=relaxed/simple;
	bh=CnjPj9UsU6lqp7uBC643qUycCsSzd1ai8DA53VJ866g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IO/k/O7Py/E1dvlGvEmyzyFrDTY7duUfOJ1wXEfgfF2GHLvhNk3T7msLCtyvFFru5DpwxmL6dCsFOHQoLeUCJf3ylPaxu0cm4J/6ZEMIV8w4NqNeafpDCMOYBoByNwloDnei7lvjpfdUSkA3IV4aa0ugvzWlyZV8D/QHM/QCpKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dyTV3aWo; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dyTV3aWo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXkOGZvAjsbdo7wUfrC3AaTC07FifdakD1HH3aP4YNEkReVi7T/m6e1e+Sxmu15kGRcYXAXW6pEXiXO7eyOBlI320tKGc9WHBKzYEqsmk5CwGd3I0ufsrAb2+X5Y6TGjR3uvK99QbmZLjV3qPs/QHHIvJzGQTmcr54nDpthOImdUPBLpd6sA8u2bbrNdTLspR7vKKHd0sEtBCcf691mkiLwM1bYmAKkU81ly6vXE79Ql6BGDxzpY3F6JgjMvmxsCz81EfRiY1Bev+qeqUmWc5M40UK1TM0jm2ffcWeH0uuozj3X5jf5XpGg8dU3bFGnWCIodpni8OltmxxbKKfC8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emmwFZ0FN06tMHV27qd2qjR0FFJXpcTcxRmWZEqri7k=;
 b=ERkuESIaqkyvsQW1sTBAD4ILpHmIhincJklger0Onvzhq2IroMbrDC5BoF0ZaVIM66i3cwwGPShmDQ6RLVyjyhG0ecz7vTxZkCK+LejsBrsXMd6jaT+gxBD8QMPm2omIlrRlBfdVdz4YzQa4InOoNZdUyjYbRztlnOvoM9nDxBiN5m+UXaiwSeS/h2i3la0nGIquOKZUd9AP+EviXgQ/MRwfjwVtS4IwTsEfm0x7wxl7ZY/xfl+oCKShA03r7XIoDJDyXjguNCNIEGLkpQJiMB9V5GdmU1U4ThriHwqoM+5RJbbXc8jPb8C/IqaMja9hJeACDSlWY38iHApW+ZZ3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emmwFZ0FN06tMHV27qd2qjR0FFJXpcTcxRmWZEqri7k=;
 b=dyTV3aWo3s2mfqHoLcb+jSRhFwHJoGI/WKHM/ZV718eAndF+k6bo1UrkIs2mLEmWCydHYFo+nwnbebH/q72wuvqQ5LgzRtyJ66n4dDP2NUcPCadLXV5tSZYaKqTx+nXOTJK5ZDi68SVrxHdRwqXElZDjavR1m1T4YfplYtRjvYc=
Received: from DM6PR08CA0049.namprd08.prod.outlook.com (2603:10b6:5:1e0::23)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 06:05:04 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:5:1e0:cafe::91) by DM6PR08CA0049.outlook.office365.com
 (2603:10b6:5:1e0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:05:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:05:04 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:04:53 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>, Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH 3/3] perf/amd/ibs: Simplify event state handling with IBS_CAPS_DIS
Date: Thu, 15 Oct 2026 06:04:30 +0000
Message-ID: <20261015060430.5877-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015060430.5877-1-ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 2059b49e-17bb-4db6-197e-08df2a824186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	l3B3VZf05PQ3eIJc8XuqFhEwXRXhrDUcEZgLnNXexgiibHYYwu/IB14gUM2dcWmoiOFz9/ClQ/zrBZ1mnxZKQNTi9+ZrGMIkWl3YXnibbsMScRg6AAIx138XtqatgsrUfoPUHpx6PAvROe67XDFFGI0MCNd88rO9b/lxPU5glki8EpcRoQx50hzpBsAPidbQnhMlYj2dWUGb++Cpw8Cep20nMsOiFlvELmhQVTRIH2EWL67Dy6ncciPkeemDzXTm3hoYB4wBL7IJ1/xjxAZ4Fp1Y6jAW2zGOQFnGw4hGLapPR4+z/Xkh+M0/IqlUFl9X80cQnJDLAMbiXcAHsKD61T8TBr47fk128/Qk4WJ9JORNqjcQSf37/k5efcU7GUnXTI+9nM9eLmNQRPKh5pUR4q/Aa20Pp6SchNUmy1/1DPM4Kc4O88NJrE/oVRslreH42bOyWTAoeog92s9DoETvqyfDVh4rlgM7W/tWunF9We3tfPb869LBZVRqSqzc152fLH/UzBKyaTxMr8KgHd+g4OaTFMSuCAMR7lFjkpQ5/EJ6wQZuWVSCmhcJEGpilweQ8ydgzjxSZNeCFaifqhceXVpVTZvdSR7FJep0RRzKDCgdZHhEsJ86d7TKnKVcK4IHvFkHCLXiGIkElV3PzksyktGlyUOG11pqnLzybx+QFXo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pYmIPxxxpAzpPi86b5+t43z1mCE5hCs+2NIt5uS6n5fCEn0Jdq/H2AM5YF+ptvlGct0CWkfaNesEJutZNoyzZ3uz2Iwb/EOINKWbp86CkNqWv0QGZeX8JYM4E4p5ba00fi/nd7j184HRVDmFhPxxTO7MZLFMuB3+/DXVPTA91dOc1se8mZDSRpwjdecJ6yfT+b7sBi3/5b4qJy4vRRQVsJDZ8qgzh5Y320EJL6LqKird+CVc1Cym1wP5ARuWT3nr61/H4nW7LGfr/r+y/lhe8SxAfORIvPzr4o4LWRsBGMD5ptr9mBf+TWqNT8jGumXshkatB7l2Qx4D4SacGChodeN9RWJmEOqPC8pJic+J/jYh5tCJOEU3GXmv4xl5yqT4DyQ1GuL9iS836EKBWCXlPorNs5yR4m8/x3jQFiR2In7+cv6TTAA27gMhTHzcMdtC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:05:04.2916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2059b49e-17bb-4db6-197e-08df2a824186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

The IBS_{FETCH|OP}_CTL2[Dis] bit allows IBS sampling to be stopped without
a RMW of IBS_{FETCH,OP}_CTL. Systems providing this bit therefore do not
require the IBS_STARTED and IBS_STOPPED states used to coordinate control
MSR updates with late NMIs.

Add a separate stop path for these systems. Preserve Val while disabling
the event so that a delayed NMI can be identified and consumed, and wait
briefly for such an NMI before restarting the event.

Leave the existing handling unchanged on systems without IBS_CAPS_DIS.

Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/r/20261007234815.4026028-1-jmattson@google.com
Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to eliminate RMW race")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 145 ++++++++++++++++++++++++++++++++------
 1 file changed, 122 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3cb46c775eaa..f49f30f53399 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -28,6 +28,7 @@ static u32 ibs_caps;
 #include <linux/hardirq.h>
 
 #include <asm/nmi.h>
+#include <asm/delay.h>
 #include <asm/amd/ibs.h>
 
 /* attr.config2 */
@@ -73,7 +74,12 @@ static u32 ibs_caps;
  *
  * XXX: we could probably be using !atomic bitops for all this.
  */
-
+/*
+ * NOTE: IBS_CAPS_DIS eliminates the RMW race on the IBS_{FETCH|OP}_CTL, making
+ * IBS_STARTED and IBS_STOPPED states unnecessary. We use only IBS_ENABLED and
+ * IBS_STOPPING states when IBS_CAPS_DIS is present. Semantics of IBS_STOPPING
+ * changes a bit as well.
+ */
 enum ibs_states {
 	IBS_ENABLED	= 0,
 	IBS_STARTED	= 1,
@@ -557,7 +563,9 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
+	unsigned int delay = 50;
 	u64 period, config = 0;
+	u64 ctl;
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -575,23 +583,87 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	}
 	config |= period >> 4;
 
-	/*
-	 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
-	 * Doing so prevents a race condition in which an NMI due to other
-	 * source might accidentally activate the event before we enable
-	 * it ourselves.
-	 */
-	perf_ibs_disable_event(perf_ibs, hwc, 0);
+	if (ibs_caps & IBS_CAPS_DIS) {
+		/*
+		 *      IBS HW                     SW
+		 *
+		 *  o Capture sample       o ->stop()
+		 *  o Set VAL bit            CTL2[Dis] = 1
+		 *  o Raise NMI --.        o ...
+		 *                 \       o ->start()
+		 *                  \        wrmsr(IBS_{FETCH|OP}_CTL, new value);
+		 *                   \       (wrmsr clears the VAL bit)
+		 *                    `--> o Receives delayed NMI
+		 *                           (Unknown NMI since VAL bit is cleared)
+		 *
+		 * Handle this with induced delay.
+		 */
+		rdmsrq(hwc->config_base, ctl);
+		while ((ctl & perf_ibs->valid_mask) && delay--) {
+			udelay(1);
+			rdmsrq(hwc->config_base, ctl);
+		}
+	} else {
+		/*
+		 * Reset the IBS_{FETCH|OP}_CTL MSR before updating pcpu->state.
+		 * Doing so prevents a race condition in which an NMI due to
+		 * other source might accidentally activate the event before we
+		 * enable it ourselves.
+		 */
+		perf_ibs_disable_event(perf_ibs, hwc, 0);
+		/*
+		 * Set STARTED before enabling the hardware, such that a
+		 * subsequent NMI must observe it.
+		 */
+		set_bit(IBS_STARTED,    pcpu->state);
+		clear_bit(IBS_STOPPING, pcpu->state);
+	}
+	perf_ibs_enable_event(perf_ibs, hwc, config);
+
+	perf_event_update_userpage(event);
+}
+
+/* ->stop() for platforms with additional CTL2[Dis] bit. */
+static void perf_ibs_stop_dis(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
+	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
+	u64 config;
+	u64 ctl2;
+
+	WARN_ON_ONCE(test_bit(IBS_STOPPING, pcpu->state));
+
+	set_bit(IBS_STOPPING, pcpu->state);
+
+	rdmsrq(hwc->extra_reg.reg, ctl2);
+	if (ctl2 & perf_ibs->disable_mask)
+		goto reset_state;
+
+	wrmsrq(hwc->extra_reg.reg, perf_ibs->disable_mask);
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		goto reset_state;
+
+	rdmsrq(hwc->config_base, config);
+
+	config &= ~perf_ibs->valid_mask;
 
 	/*
-	 * Set STARTED before enabling the hardware, such that a subsequent NMI
-	 * must observe it.
+	 * Clear the Val bit otherwise ->start() will unnecessarily
+	 * wait for 50us.
 	 */
-	set_bit(IBS_STARTED,    pcpu->state);
-	clear_bit(IBS_STOPPING, pcpu->state);
-	perf_ibs_enable_event(perf_ibs, hwc, config);
+	if (in_nmi())
+		wrmsrq(hwc->config_base, config);
 
-	perf_event_update_userpage(event);
+	perf_ibs_event_update(perf_ibs, event, &config);
+	hwc->state |= PERF_HES_UPTODATE;
+
+reset_state:
+	clear_bit(IBS_STOPPING, pcpu->state);
 }
 
 static void perf_ibs_stop(struct perf_event *event, int flags)
@@ -602,6 +674,9 @@ static void perf_ibs_stop(struct perf_event *event, int flags)
 	u64 config;
 	int stopping;
 
+	if (ibs_caps & IBS_CAPS_DIS)
+		return perf_ibs_stop_dis(event, flags);
+
 	if (test_and_set_bit(IBS_STOPPING, pcpu->state))
 		return;
 
@@ -1419,19 +1494,43 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
 	int br_target_idx = -1;
+	u64 ctl2, ctl;
 
-	if (!test_bit(IBS_STARTED, pcpu->state)) {
-fail:
+	if (ibs_caps & IBS_CAPS_DIS) {
 		/*
-		 * Catch spurious interrupts after stopping IBS: After
-		 * disabling IBS there could be still incoming NMIs
-		 * with samples that even have the valid bit cleared.
-		 * Mark all this NMIs as handled.
+		 * ->stop() {
+		 *     set_bit(IBS_STOPPING);
+		 *                               <-- NMI (race 1)
+		 *     CTL2[Dis]=1;
+		 *     ...                       <-- NMI (race 2)
+		 * }
 		 */
-		if (test_and_clear_bit(IBS_STOPPED, pcpu->state))
-			return 1;
+		rdmsrq(perf_ibs->msr2, ctl2);
+		if (test_bit(IBS_STOPPING, pcpu->state) /* race 1 */ ||
+		    (ctl2 & perf_ibs->disable_mask) /* race 2 */) {
+			rdmsrq(perf_ibs->msr, ctl);
+			if (ctl & perf_ibs->valid_mask) {
+				ctl &= ~(perf_ibs->enable_mask |
+					 perf_ibs->valid_mask);
+				wrmsrq(perf_ibs->msr, ctl);
+				return 1;
+			}
+			return 0;
+		}
+	} else {
+		if (!test_bit(IBS_STARTED, pcpu->state)) {
+fail:
+			/*
+			 * Catch spurious interrupts after stopping IBS: After
+			 * disabling IBS there could be still incoming NMIs
+			 * with samples that even have the valid bit cleared.
+			 * Mark all this NMIs as handled.
+			 */
+			if (test_and_clear_bit(IBS_STOPPED, pcpu->state))
+				return 1;
 
-		return 0;
+			return 0;
+		}
 	}
 
 	if (WARN_ON_ONCE(!event))
-- 
2.55.0

