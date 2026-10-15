Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20132430CDD;
	Thu, 15 Oct 2026 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044307; cv=fail; b=kE25mZgMgJgLFT9tacOx37HsFwSIajpPqPZ/ZbMzbTRPtgaes8ptXp4CUFf8ZDoGwIUjd5dPTxZkCElfV3sL9RZym6kqy5+QVYdYpd4o8+G2JdUAYyMvZ5yUnp5DM7qTLxcD8kXMjtzMigVJf115rwZLeteynoRR/WTD74IekHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044307; c=relaxed/simple;
	bh=Ser6elNrnlwb16JYiLu9d+IcC64rF98XYRhm7mRgn/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUpb2pnaodwGcnoxSq36r8PgSWqhZYf+st6haZoGnfbilPjJMct6hf7+c/tHjvC9G2I8Q1XMP5Ems8BdFpBtrbWYYEAhKW8xjNcotpZW19VQMhl9eCEAwLvbuj/Jdx7JM3jdqJ7eofe0pjALrN5Ha9yGZZhCsAy6EGWG+ug1h3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0bsIwJHH; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0bsIwJHH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIz01KjI/qY5yo78HBxxctAEX7TutxGNYChjIu7DDVLrPm1ycQWmcLqO1R83L9Ui9kr2mjIAkfuotDRw21SUNCNGNqULiAJgrsBLEcyTU+p0sytMf7BKn75mJpZ9jVRgbEunTJpm5djeMwGE++fCRUpHtZ/NTcMVjEK56QNhdvG98oqSFrOJpi5saO4WKE0ZfE9KD6QtRFLvXTJLT6ISuolZul5wQgVq/vHiK8c87W3ewOIdb7tgj4Jd19Ywz+qkX0tOgG7R0Gkf+HLmiKZSo/3zUj+dcfYV12ojlohcsm0gdip82y47RK+jbJT1sCnPPrO4VfV0ltLWSEUpdL1S9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bd1W1s/Uc4lgyxZ3huALRu1EjAO9XUs8LD2fvOdgGe8=;
 b=jgW+veolRPWL3Ni8s9tRdhb0zzzKsSujAT5ytVxDLfTE8BtVIxgstdCZ/0q/8IExgpezTzjjo0939mE6liLe7FX/BvcOIVgu7SiTPHU13fY3ul76L2nKzZA+FV+3adHs0jOasboBMO5cOdn9gh1k9jPoXVt08l5+AJRurAMulV016eECUNZ6NouwMkqx4T6fLzA6BiC3d6R3Hop0/t/rjPKNyxQxSdcrOQ8suWp8DNBAKv629qgXZjkX6NX9NAPUCjXAJfXeC7d/R55/NafB1rZcGBCdu/ZqIs/NlCz5cQN/Mxj12NGNABBQytfoowZD2weud+L4zKeEwOFs1tLTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd1W1s/Uc4lgyxZ3huALRu1EjAO9XUs8LD2fvOdgGe8=;
 b=0bsIwJHHuCe4SKImNzxxXz2u8TA9lwWJ6V6HnQ4MEzoD3J04NUpDi6KqQeTDjBnW/3KC64cM4lOIMovi6/7Ow7i6BApQyXCtOARmeL069eL8cngYZgrXMo1DGjBeSi1tUGr+3NyawWZWK+gJaxICQRc0vxTC7ipeJ55TS+b25PM=
Received: from DS3P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::14) by
 IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:04:59 +0000
Received: from DS8PEPF000000DD.namprd05.prod.outlook.com
 (2603:10b6:8:45f:cafe::6f) by DS3P220CA0009.outlook.office365.com
 (2603:10b6:8:45f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 06:04:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000DD.mail.protection.outlook.com (10.167.23.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:04:59 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:04:48 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>, Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH 2/3] perf/amd/ibs: Fix kernel address leak via REGS_USER
Date: Thu, 15 Oct 2026 06:04:29 +0000
Message-ID: <20261015060430.5877-3-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000DD:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bf4ea9-79ff-4666-6411-08df2a823e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BXBOl2TAmYg1HLhMplXEAiRICiRXFlHBTotVXA3QRxTE/kQjEglWchVmaseoTOfwtadHIbND0hlzDdN68kRZM/7zEG153VDfxt3sUOaB7fLkvX0/cOWXkpPvFmvapFwUqyTBIV7zO+fvA0Ge4R93lHJLTbhwHNDUCMIa/TJ4GkzKL0+MrX45b2on3Qf8oDnxoqgwdbDr9hUwi7FquMAem9ZGa/n2D1sfI7W//dy37a6fQD5wS3DN2BW9YyShVQu0c55R6UQB9ZySd2mzDVK1z2DHXN7dU35b262Q5678FBmIk5QLk7+oInQNFocnxkPNkwQO8Xs7KSl7SITKrtPGt65glgWLZ6LrRCbGfIaWHoAVn1YEJCu+N6/qOAvwIxi4iVbMNZBCCfdjZ9TmePEb37yXD5+sQejuewsn+rTVotl94Pn94XMPQVoPITJrcjeoA09xnx0N9D7b3lhrtNkO2vxxzPvxa2rZBdN4j8zZbxxal+33Oj5EpvcvvKqEho0RH2qTNEOArAXTi2WqT5/ENalm/JHvZFVudVRlVoeC/2agU6vPusaaeIZtFrr5RvZthdfKoP3bObfbOFMdxrOuYi0j8mAYZlGjLLsWT1UcjsuIzoON9t9Ury4VXT4S/3mElEYD2WP3uRXsnKhj+Fcv6QffvJy60vGT9mS/aGdRijta3WkvAEZ3ayxeGLi6jHT7Lb8THRlyhHNUIdLU3NnW6w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t4PalPT/MIMRDRgWaYEd5w7CEAHJiRvUQPiXDOph5oWBkyAWmCiedyZvWGhzGSL+rUuovfdkyejamCO1Yi1MSpGKYGLHycNtAm4xFtjykM77R1Nts5XgwpQo8WUmh+UoHedtauo+OS8+/zcZpCJ+x+rGdVnwOb4wFGIfmoMVb+IlprZwb+hOf8lU2H1nbikZU4kmD6iQn3VjvMAESmDr3fPv4jwc2B2UOI0hkTxD9mk7DDI4z3pGQGvMfsOM8i4r7cjFOo2PvtkmmK//Qh5vb0+gs0BMFHBFaQGKfqFfauU0SJ6f7F8+T5M41uNH2cxYC5x0muplcST8LO1gWG9y4rC5vC99xMC0Q76npw5BmgqngwNBWK0or3q2An+gtn8ZuYeF/TJO4IdEbOg/YGhO5emMoN+x5Z7lLUPiMiPCIOgdzxNkNj+SELta6KoDhKU2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:04:59.1476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bf4ea9-79ff-4666-6411-08df2a823e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000DD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189

IBS hardware captures a sample and raises an NMI. Since the NMI can be
delivered with a delay, a privilege change may occur between sample
capture and NMI delivery. Because IBS only provides the sample RIP, the
kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
if a privilege switch occurred in the interim. This can leak kernel
addresses to unprivileged users through PERF_SAMPLE_REGS_USER.

Fix this by discarding samples where the NMI arrives in kernel mode and
the user has set exclude_kernel.

Reported-by: Jayapal Ashwin Nair <janair@amd.com>
Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index bfb51f8e184f..3cb46c775eaa 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1373,12 +1373,15 @@ static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
 }
 
 static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct perf_event *event,
-				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
-				    int br_target_idx)
+				    struct pt_regs *regs, struct pt_regs *iregs,
+				    struct perf_ibs_data *ibs_data, int br_target_idx)
 {
 	if (perf_exclude_event(event, regs))
 		return true;
 
+	if (perf_exclude_event(event, iregs))
+		return true;
+
 	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
 		return false;
 
@@ -1529,7 +1532,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 
 	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
 	     (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
-	    perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
+	    perf_ibs_discard_sample(perf_ibs, event, &regs, iregs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
-- 
2.55.0

