Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EBA78F51;
	Fri, 21 Mar 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573598; cv=fail; b=LnTlkEeVKsWoshXeMP+U7a7FgGmt+ttDpPkIXZD7n3Ii3Az3ei7nBFM4oq9nNNuHUc/b6iDO41D/nZZyu0NL6d1fIs/BVBF+JjMnJflCEVx8qEPrugShvj1WVNE6Biocyy3u617ubMucJcabPc5yTG4ErG8ELB8LebGl9qRrNIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573598; c=relaxed/simple;
	bh=k3UI3T43I5/0UiagmlbtdniC+oKvYp6geCjOTt217fk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MNZSLLY1cm2WvqS6OjBOVJl1ODuPeDGkTbawSKLQMDGwag75nGBUG4lPgnDk4I5urQRajmhzc/tqFdnLnUqpmDov6tNw/p3lYfb7lnOF13gZjL5ZHZnTXrdaPne1pFUDhL9vX+1uu+St8K7Qsxd/wk7mK6qcMji4L4XA4s7nHy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zKkB7woM; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zKkB7woM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIbllCmXKjrPL3gFFCXwTLkhjFgfux03ud7q3LQIjudPOGaoBhn2cK0umdOUBjyTDAdXrtmx5Vx5VhExZIPAAc5VWeS1EL2lVE7jbGrXxhQGnVz6LmD5S4bveLb5TAbAgGuLlZhEtklLuMHPEo+eqgchPtnqs/wPXxNZFBxa3Sy4SI8KcXgIlsWyMBVryr2RKwk+TPfH37BsMTTqoChuVgjvEjkbY1haMmGGzSXY8CuULTgXMhEagIqciu6OA2MQWzX1YMykcT3HTmm5Pdo0Mi7nsnfMngFQLot2DVE7k7X8rf1Ea/7Jj+Env3DNPamOKZ3Y1Qy+3tZwQqDE4uHS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6J6F4cgYqfOYvUq3kuKeXhJWtMLlJhf+ilgqdtAVTc=;
 b=om0A9Midgvv+Fvo/p29g52zIkS3yD+8NpB1aJFuVX1HEAc+3zfM2zJ6uCr1JL5NXibNyFcEjhH2MBHQAIcSUrG1/1upFzwSNQzmlgKFjwmDUWagNZI4N7DONunNp2kvY+i15c1fEqAeeriUJTL8qAXZ2ELrZCaLEVoIGv9Wmo/AVO2d+wm9/OpkSsoR1C0Ajl1zr1inYJvv3cQhsbTkWMnwcY1lVNCe39S4zrvlJ0CYbRJtDPiQpyiMPm4DosHsdef6CtA1h9LDSGF/GBOPgF0Ab/gTOUhLIKYdt9QoLQcyjb0wgoAq8NPIyhzW1goEXhpwJJiZcbn8GJLg9PEtfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6J6F4cgYqfOYvUq3kuKeXhJWtMLlJhf+ilgqdtAVTc=;
 b=zKkB7woMLIXCXXso3yGIFVZTTn2VhUG4gzq41KprH4mbHPLGu6gjTsaOyXb5RIrr/nn63Ju++yB35egVwQAAuLXbhw4SrzPt2WBqVOAUocmwXux/5CeSIvsATJTPI0MKGPKZD9zLYnhYoc6FRRLgElAoAFX2nqpCN8r8n5m8MpM=
Received: from CH2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:5a::27)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 16:13:12 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::fe) by CH2PR08CA0017.outlook.office365.com
 (2603:10b6:610:5a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 16:13:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 16:13:11 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 11:13:06 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <namhyung@kernel.org>, <mingo@redhat.com>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <kan.liang@linux.intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <matteorizzo@google.com>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 tip:perf/core] perf/amd/ibs: Prevent leaking sensitive data to userspace
Date: Fri, 21 Mar 2025 16:12:51 +0000
Message-ID: <20250321161251.1033-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ecb3ab0-6f16-4664-b275-08dd689346db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9cfr4cd5yTHccquy0qZNxCGziyEaB8Cq5iJs2uuXlPT4ovVnnujOJzgBfuz?=
 =?us-ascii?Q?y4XIkVQNLKox17/Rqn2kwy01rQMXufuXCBfLgad2f6JvSqAs2Z45mWnbfE3V?=
 =?us-ascii?Q?TQQnxoUVKPMwpY+DzTNhS+0JBbwH6aod095eXVFrhXM7dTcRrkqPzJk34FBj?=
 =?us-ascii?Q?PPTCH66ySZWLENmDpY9CYdpJGdHmupKmCbFWjIKxgModixY1yNNSav9LH7u3?=
 =?us-ascii?Q?Bex98WsJfD0MXa9DK57CnFjl80ScQZxWHhBxyq4aHDwCQYSOg243nqDhXRTb?=
 =?us-ascii?Q?55AbRLGGx25NqNrGl3y8W+cGF4L9Dd7AgxHItipVqKQpL7M4lL3jtOpGqaCI?=
 =?us-ascii?Q?KJrn7EU13KGGn5wXlnOlDU4VO+GY5bAc5NoTrGeYiAcGAMscayOzJudxELGm?=
 =?us-ascii?Q?DFf0P3dI1aSb5H8hGUDuK0An2zkf6TZ3Y8+oN0c+R1tz9X+lYvMyBwJm0MJp?=
 =?us-ascii?Q?G399b6N72IyZq7JYA5fnfciBBpNh3mxUzSOiLAD3hr1jsCGqChISjwsalTE8?=
 =?us-ascii?Q?dAQZkdUvD54IGrrndEGHJ3juW9uKthfbRDnQ2Pp9WlFNZL4wu8uMHSE1C2mw?=
 =?us-ascii?Q?xPUiBS5eo37op458MTkDLtXkQsXmOmR3RSClbPyDShk6mX8yiKj/qVa15wW4?=
 =?us-ascii?Q?0l5QwxuQq9Z+lB9Vzo02xnBGSN89ikRfSG1iXQ7gs7d9XeUbpYFJ6TTaSvqf?=
 =?us-ascii?Q?A7YYsevDW0D+vbJfKxpp6CAD+efJ4Wko5gxtCgELdmCq6hH008+vg+OEhcHo?=
 =?us-ascii?Q?ewtuKvn499foAc7q5jDmv8MGspUHaKFkx6eGxm1jrIn0wTuWKl6THPrWgpzv?=
 =?us-ascii?Q?HJCn3Sa3at2d5G6YMo0nE1q/wVpkZvHXQVNlp9lbTCgajqKAGKo6EVFIaejx?=
 =?us-ascii?Q?a/g7IzqAxbxozFb+THPU6njjp9XwT1e5vA+llSPYEbXr8fXtScIcUO+2cLZb?=
 =?us-ascii?Q?FpVdCze6QengJPoIt7/aqKpjUYTLO+60K+AlYqc+lCWXgyilUjx1mo5tt4J6?=
 =?us-ascii?Q?VxgawDGIYRPHCcR8GUhYy5uyLOmAlVOXy6jIB/B6MHD+FMT5vBBYgHEqdiYT?=
 =?us-ascii?Q?BADUHFv1sQqTAliaGmDXeHvRUbyYugAOzz7fYBq1Bnz3PYONxDGOD7UI3pnH?=
 =?us-ascii?Q?zGHWOzUy28Js4LR49nJ92KWxau5vuMRnabq5JkD1q+47moMe1/UDSu+X1IBK?=
 =?us-ascii?Q?DtoTKhE9Z1S2ekNLOR1eKsIBfAcEmbZad7csRqfSsH+xQH2OKiFMJcWto6HI?=
 =?us-ascii?Q?8i5leRmHbn0r5vkZFjiyJ+indAos1NdUN1rO1CQC3u/xZP1h1PbX8M7ZyQjb?=
 =?us-ascii?Q?MXV2T6Tks7ONhtc8PqIgncwZmvdqUBMCE753F7FlhZQeV8sFMRE6p/OWwM+G?=
 =?us-ascii?Q?rTVhtPNDzVIKOrMe+uw4btfLKfXIPoN5Irk+m0kH2uid/0eB1rjqdG4pwPEL?=
 =?us-ascii?Q?9J7337GhLqu1x7ShBsmqZxfRhX5Vahw5etXBOQC2eyX0NpM5kjJFNPPW7k2L?=
 =?us-ascii?Q?PG9PeoZfvwE4scc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:13:11.3200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecb3ab0-6f16-4664-b275-08dd689346db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

From: Namhyung Kim <namhyung@kernel.org>

Although IBS "swfilt" can prevent leaking samples with kernel RIP to the
userspace, there are few subtle cases where a 'data' address and/or a
'branch target' address can fall under kernel address range although RIP
is from userspace. Prevent leaking kernel 'data' addresses by discarding
such samples when {exclude_kernel=1,swfilt=1}.

IBS can now be invoked by unprivileged user with the introduction of
"swfilt". However, this creates a loophole in the interface where an
unprivileged user can get physical address of the userspace virtual
addresses through IBS register raw dump (PERF_SAMPLE_RAW). Prevent this
as well.

Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
Suggested-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v2: https://lore.kernel.org/r/20250317163755.1842589-1-namhyung@kernel.org

 arch/x86/events/amd/ibs.c | 76 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 7b52b8e3a185..66f981865091 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1054,6 +1054,8 @@ static void perf_ibs_get_mem_lock(union ibs_op_data3 *op_data3,
 		data_src->mem_lock = PERF_MEM_LOCK_LOCKED;
 }
 
+/* Be careful. Works only for contiguous MSRs. */
+#define ibs_fetch_msr_idx(msr)	(msr - MSR_AMD64_IBSFETCHCTL)
 #define ibs_op_msr_idx(msr)	(msr - MSR_AMD64_IBSOPCTL)
 
 static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
@@ -1159,6 +1161,67 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
 	return 1;
 }
 
+static bool perf_ibs_is_kernel_data_addr(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data)
+{
+	u64 sample_type_mask = PERF_SAMPLE_ADDR | PERF_SAMPLE_RAW;
+	union ibs_op_data3 op_data3;
+	u64 dc_lin_addr;
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+	dc_lin_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
+
+	return unlikely((event->attr.sample_type & sample_type_mask) &&
+			op_data3.dc_lin_addr_valid && kernel_ip(dc_lin_addr));
+}
+
+static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data,
+					 int br_target_idx)
+{
+	union ibs_op_data op_data;
+	u64 br_target;
+
+	op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
+	br_target = ibs_data->regs[br_target_idx];
+
+	return unlikely((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+			op_data.op_brn_ret && kernel_ip(br_target));
+}
+
+static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
+				    int br_target_idx)
+{
+	if (perf_exclude_event(event, regs))
+		return true;
+
+	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
+		return false;
+
+	if (perf_ibs_is_kernel_data_addr(event, ibs_data))
+		return true;
+
+	if (br_target_idx != -1 &&
+	    perf_ibs_is_kernel_br_target(event, ibs_data, br_target_idx))
+		return true;
+
+	return false;
+}
+
+static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
+				   struct perf_ibs_data *ibs_data)
+{
+	if (perf_ibs == &perf_ibs_op) {
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &= ~(1ULL << 18);
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] = 0;
+		return;
+	}
+
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &= ~(1ULL << 52);
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] = 0;
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -1171,6 +1234,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	int offset, size, check_rip, offset_max, throttle = 0;
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
+	int br_target_idx = -1;
 
 	if (!test_bit(IBS_STARTED, pcpu->state)) {
 fail:
@@ -1241,6 +1305,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_BRNTRGT) {
 				rdmsrl(MSR_AMD64_IBSBRTARGET, *buf++);
+				br_target_idx = size;
 				size++;
 			}
 			if (ibs_caps & IBS_CAPS_OPDATA4) {
@@ -1268,10 +1333,19 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	}
 
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_exclude_event(event, &regs)) {
+	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
+	/*
+	 * Prevent leaking physical addresses to unprivileged users. Skip
+	 * PERF_SAMPLE_PHYS_ADDR check since generic code prevents it for
+	 * unprivileged users.
+	 */
+	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+	    perf_allow_kernel(&event->attr)) {
+		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
+	}
 
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw = (struct perf_raw_record){
-- 
2.43.0

