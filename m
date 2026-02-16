Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CF29D269;
	Mon, 16 Feb 2026 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215977; cv=fail; b=MamKYMYOFVs/npT423yEkJj0LD/tNj3u4vL8LYRscpQCDcjUZpfl+1qsrOsfRid40VJOKpE+KkZ3ujC68mMIzglj5ZQFasjopTnBHROcJCSU/x9jm5sycQFQToMjvTSkk+dXId8e42sIfMMMzkbBdJVGNdGtvPQLfUCpWSopFRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215977; c=relaxed/simple;
	bh=V4MehkVbqu+Wdgxr1VMhVMD+ONITBtE0Qd5LN+km7SY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw5WVZSU2xS07awERaerApfYOUZUxzCxBFUDu6MONehXCxtkcNtsrLP3xMYEEd5qq6i7rfdbRfAMX/M7AQzYx4UaBivGiYHL/P8g5S4HAee68c6q7Yo1nKQ3/CKBDXwZuw4rIbhCWWQYe2rJFV1EfREfWNG949PKQO5e5SF15fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=esb0NJFO; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="esb0NJFO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VinYaspmMQgUoOl3OLdKisbhCpeXcXuCvs8TMbVtd1FXt9JBI9K5alGiLctwaBXlsC18j2N//NYRrh229jIMu/i0jt341MKWc6X57P9q+pjrwDF5jc/BS8hyJbDeFV0cGEMm4S3lFowJZ9wTR9Vd8wnMS32Uty5uTT23ALm6qwI5l0jWQb37YPgLJ5zfqLBewrzOHfpqRotKB9th3CnOAWAY7FBHZW580QiWfORyn8+WusFasAyczgxx+t3nqfXyXOyQX380c1ghfi4//mkxNqFwxhHzLYXAu5Ra5CUNb0s+l2IEtbYKTPpge0rdtpcP2vzwti6gyLCOVauYdZ54OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XZCuSaKxSVMJ5lR5N7suBFVshPbHzueK5WLAieyKmQ=;
 b=ct5OfKhSTZp7vrSlr3RVq4F1fIr8hZcYyy5Y8mWRd+9dT/LrUeMDPnaQvgKJaNf3jVAzUfEbrkHZJsshWmCJIS2m9lgXMvmddN2O5YEbLoex/VYJn2uznKVjUZHSLY3BtB4YhlO7P4vG012UNfvBEx1xr1Gxd+JuF00VkSyR4cxeTKQmtnO4psknT6QEIdShJi+c12gedepgfNuYed7b1T0MqSOfCG0J1RsZ+UikKLZOwVobA1okvzltePOAe2jpmfHMuKNk7A/GndaqoGrQAiQImMjVKlqBPz1OsEyXYujhYLRJOGPoQKLcGygaqtY8XOeUS2mNhqje97q/SjXwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XZCuSaKxSVMJ5lR5N7suBFVshPbHzueK5WLAieyKmQ=;
 b=esb0NJFOUqURx1+Gx8ynYeehv8iEMQazbkbIAiUKK3vyzq62D7G4h5oOtqG26mvYJSFVM7DzKmxdgmkJ0HpNr0WLZtyW5CMc1xDx4Kr2GqGCrQ+Nr/3zh2aH8y0J9+vYxeqNuSPyUkZCKnEtyv7T/cEd+klULASbTvprpFh3SfU=
Received: from SA0PR11CA0127.namprd11.prod.outlook.com (2603:10b6:806:131::12)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:26:11 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::28) by SA0PR11CA0127.outlook.office365.com
 (2603:10b6:806:131::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:26:11 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:26:06 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 5/7] perf/amd/ibs: Enable RIP bit63 hardware filtering
Date: Mon, 16 Feb 2026 04:25:28 +0000
Message-ID: <20260216042530.1546-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216042530.1546-1-ravi.bangoria@amd.com>
References: <20260216042530.1546-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: a67190b5-8788-4f57-0e4e-08de6d138393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxS1eXibTfs3baqQAuzozMp94ZrKZcSsfprJl5EnkGxMSUESR5auTy8mtl8b?=
 =?us-ascii?Q?ZTrNCBRnJ9fHPcZIVz89qLsPNx2jXe0FvXqVqD/TdX3cZ4RR1DEzOX+r/EJs?=
 =?us-ascii?Q?xUdaTYt+cLuFJfAuetMrEdnlBhX1HUzEDAIE2feRQHdaSV5GcyqwRv/KtsHH?=
 =?us-ascii?Q?fdi4A3QJ6Oc5Lxl0vV6PZt7zzB8Xi0fqdUesBrQNIQuS6SXfTdJ66Gl4MUMY?=
 =?us-ascii?Q?zP7cG23AiGkSD5O442OT8TO9X0nUMnKZ78EuZqBbqf6XzO6DcfNnJdWy/f/6?=
 =?us-ascii?Q?+m/5mE/P4GZUprWJjFxTg7NrdQtvZ4pg64Ll1YcUSclAUeWmXzNwo89Fq7xi?=
 =?us-ascii?Q?TYUkQ1X24v9iIyzghdifXUWeeFsdJwnlZmIbEfhKP5LNLNMw/+Jvh5/mpW/g?=
 =?us-ascii?Q?pngJugIgzlHRiGJB+7DiyQ+f2cmTbE4Q1La3SB6T6pNsZndcW0+3NyfJcsC1?=
 =?us-ascii?Q?qR+OH1EHOdRalLeTtY7RWK7IKdHGZeZlVO7HPZWhfK3hJzjLVpcA8PCFq7z9?=
 =?us-ascii?Q?9SUFdWk6MOr5+6hlaM00ogG2ryHseehc74LEHLrJDaIxsAW/RlE0R4Gd4GS3?=
 =?us-ascii?Q?js2/STDkyEgiAlF2G/fbj79GPt98LMv7eDZktZ6vRkNee0aa2LQRSedHbAIO?=
 =?us-ascii?Q?6xRjZN6OwHoEUFY2FTJHSn1wQKdsTwhRtrX5aRUjVBdjcFfyE/fjJ4JUp82c?=
 =?us-ascii?Q?CnnAHmtUHYf0+3Yv2lN0xpgj1ibpF5MgNrGRA9vVIURvcpJXit3OxrzR7tqH?=
 =?us-ascii?Q?EnXf7wBPsteH3U86B606r5VGOGajYka3DiDIed9O6A2fINyTb33JWq/yaXz9?=
 =?us-ascii?Q?JDa5mdZTV7NX2mqVGqdOlUQ/5TIlgDENoqAUY2EZbyHvc2F9jHJaiYbw7G9x?=
 =?us-ascii?Q?iwdOLe4T4Bv1d4WOmJTu8W3G0W8udo5KvRcZuzKJKWfvCGEhzb+M0ngz0jGY?=
 =?us-ascii?Q?DcuCnTNJhnAAwkNYmB0RWuwI89yegzqpgps9z5MIuuymdR3nHTcQFZuQQasp?=
 =?us-ascii?Q?2xZdAyOwIOSolA88bSDsMP02TN8MEwv02lFb+p2SaHTsacU1K6W+oWTIig25?=
 =?us-ascii?Q?75ZOL2WTmeofwuxR7O1v0N3SL56XpHPal96G99zVrD+exl7YOD8Cm5PoMcWC?=
 =?us-ascii?Q?vr2eskfYu9/Iqt9omu4xD07QOeAAJLi8Jt25WOunDjdxp8JQx7mu0Y2Jj3bl?=
 =?us-ascii?Q?Kpf6msavWyHUTis8ZsX4Ijo9WATwmHXJ/zrdzAKbnz+umezTkbqDoEQ+yEu8?=
 =?us-ascii?Q?ReAZUZXoc6ztrvZbRbo/yLKfy6ZqhJGjxPtLRbqCvyZZlFG8OlDOmjjwgoqa?=
 =?us-ascii?Q?yhXaeDxMJO+ZhDynu/wmvPPOCscvQPRTOvV3hoF949o9M4Pg8HiWh+CnGZki?=
 =?us-ascii?Q?0A6/mdSNDEkgOLIBEsHTYBZ44dm6c3wbe4kH7gbSSCZno38gzPMOzH82ELEn?=
 =?us-ascii?Q?N9QB267yx9Ri6pUa2Fb9XqwVzcCtaXVp12HQ+LhDN/JA0yOr56Tehc+YjQfW?=
 =?us-ascii?Q?JgLFPU1BV+OUfyWqp+jyXSMJEt85Zj9GOqdzK5IVZfCgvfEpQvK6K9O7jUw/?=
 =?us-ascii?Q?D8zPyPFZnJxZzT/eemHtdPKViEeXwA6XI8eWMR1VM9G11B7gOS6cI2idiEvO?=
 =?us-ascii?Q?26WWpkWnkQKAIiTzK2exLq3/HPbIDOdZoV8wRXkrBlhyyoFyMJOBN7m32cW/?=
 =?us-ascii?Q?0LKGdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SaDkNZe3l6nec6WsNINMjBzs9bkroaFCFg2LsyO7xZlgTi8gUbUKaUowQlEM/w27JebeJdI0u0R1djFJVNJthuZ29lZ2UHquxD7KvH6xjbzT1glmBex+rVw0sQTELGzX/2Kdub8WT1YYf4dsm0gr1IGdZEWRX0W/81dPFEPRGhZ3mX4siVHRrFzWWAG3dfNAzwsOTjprTys7DPmQvElp75BUKd73Y/tYFDYMaefvj/Z84A/YiHpC25sM0Bk0TQxc7jNjznsLGdUpjX3MZseHNPNJ9MGSlLJ39HEOgxnznN5m8+Xu75A7v2M21zMm5QkQQG0Sc0eoK4QwtotxE5GlrpaQU95Vs2rn3y5aah6hOBKemPfNy2UQ9IEUZdtSqJ+azQRWeE8QFqxzhXDMjdt1kgVtJvPsLWZ6Qgj2iqFikeSpsHZRr9bPjPvqz2KOaaYe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:26:11.1784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67190b5-8788-4f57-0e4e-08de6d138393
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

IBS on future hardware adds the ability to filter IBS events by examining
RIP bit 63. Because Linux kernel addresses always have bit 63 set while
user-space addresses never do, this capability can be used as a privilege
filter.

So far, IBS supports privilege filtering in software (swfilt=1), where
samples are dropped in the NMI handler. The RIP bit63 hardware filter
enables IBS to be usable by unprivileged users without passing swfilt
flag. So, swfilt flag will silently be ignored when the hardware
filtering capability is present.

Example (non-root user):
  $ perf record -e ibs_op//u -- <workload>

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index cb3ae4e4744c..13ecc8d92b23 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -321,11 +321,6 @@ static int perf_ibs_init(struct perf_event *event)
 	    event->attr.exclude_idle)
 		return -EINVAL;
 
-	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    (event->attr.exclude_kernel || event->attr.exclude_user ||
-	     event->attr.exclude_hv))
-		return -EINVAL;
-
 	ret = validate_group(event);
 	if (ret)
 		return ret;
@@ -338,6 +333,32 @@ static int perf_ibs_init(struct perf_event *event)
 		hwc->extra_reg.reg = perf_ibs->msr2;
 	}
 
+	if (ibs_caps & IBS_CAPS_BIT63_FILTER) {
+		if (perf_ibs == &perf_ibs_fetch) {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |= IBS_FETCH_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |= IBS_FETCH_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+		} else {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |= IBS_OP_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |= IBS_OP_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+		}
+	} else if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+		   (event->attr.exclude_kernel || event->attr.exclude_user ||
+		    event->attr.exclude_hv)) {
+		return -EINVAL;
+	}
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -1280,7 +1301,7 @@ static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
 			op_data.op_brn_ret && kernel_ip(br_target));
 }
 
-static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct perf_event *event,
 				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
 				    int br_target_idx)
 {
@@ -1435,8 +1456,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
-	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
+	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
+	     (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
+	    perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
@@ -1899,6 +1921,14 @@ static __init int amd_ibs_init(void)
 
 	perf_ibs_pm_init();
 
+#ifdef CONFIG_X86_32
+	/*
+	 * IBS_CAPS_BIT63_FILTER is used for exclude_kernel/user filtering,
+	 * which obviously won't work for 32 bit kernel.
+	 */
+	caps &= ~IBS_CAPS_BIT63_FILTER;
+#endif
+
 	ibs_caps = caps;
 	/* make ibs_caps visible to other cpus: */
 	smp_mb();
-- 
2.43.0

