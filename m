Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64812F4A18;
	Fri, 16 Jan 2026 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534531; cv=fail; b=dmkiWqVjbyTzqdMSRHFdirAZ3xiT00IivR4JrJ/N5Lail+Q6MGvvzTNeuCiaRY1GZfseZPKPOgYWfd0wK7QtFhknCElrfA4z4jATOqcSRqWOQW/CAjncEqqacmXlUPpk+fn5x04UjKMhM1tNcDXIz8AIT6xy1hERnJzFRwOJvvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534531; c=relaxed/simple;
	bh=VgEpF13SGH1WiGrCqhqpEVw52B22du9xtTJ4j/w+1uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0vlisZ8Ui0R4tZOQFa0yUDtjAONYWrdr0SvSl15A+OyBq+zFUhiIipA0itMWjcPBIoYxn2bAp+h1lhg4ld7uYuHYs2fBs4SI9U7glj2SqRhB+HrJblbwY+cxlgE6ddBx7htgxeZNGpzRe4UxXZQSEXjd2BBphyr0Wi1J41WCZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WhCXUIvX; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WhCXUIvX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjVPDmCxWH+XsVqB73vVks+HFCTkO1e/TKN3GvU0KOPeVef/+rEz+AZVBXlVdDqKbLbHFCYjoRG/LYf7TGDI5+8tHkwvF5uTudQ06gfvTYpj1DGz+ASd/1ZYbsgVheb3yhExDe+9bFZ1oyVZ3/d940i7GRjqfBx8uVht+ewQfOX9r/OPxCqaIw03wJzKiNb/ysXYUzScjNW4oOGOJOrSAqEIGQ5ZhM3BLmBypigqOKjDDEsdm4ISWsYcgg4OsIdpe5Z88tvDM/cMlGd4WgxlTFqXNpAuFf7Jl16uibkp8ONhOElAeghy54KE+mtjOiTgpL0cwMcihTu1wzy2QhQudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15H5i1OemKgzdmTMlunWReG0WynSqPRzBNApqoidrx4=;
 b=ad2OkW+oebzebBgbHqGGhYQnFgpjrp/eyqkBTNKD7tC2Dlw4KJX9qEKNyjC+3kVTgJgGAxH6GRF3MstoMuQqtre+Z6gaeQNhgDZPV5Se8l51KC7ZI341NXrJMnJpaCOCh+pC3jbIHiMVrim4fLsMig4biZlci1LUCXxt0mFyxsqyGQ0bgmhE3qa134xd4jd6+kDOPji3qCKwcn22gYjQ2hOqDIApTEBokE30GVcQSYf94PyG8Af5m3Zc9AYYRqJYFM+mnTRKc9CGUfMq8qjPakh7IMRUVlEx9/qyyVf1bbCQqLNfTETOu4+EqMJV2tz2Ebl6XGgWhX4cq/X+G7ZdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15H5i1OemKgzdmTMlunWReG0WynSqPRzBNApqoidrx4=;
 b=WhCXUIvXxcTuQNUzwkBVZ6eYkinXxE9gk3/gcMLxtXBoIoLgz9nK0v/lwxEwq8kZWhnnG3cjMWwIiu6R/ga34qR5UL6mNMMFROjGsca6/wVZWd0oTtIMlUTqHMU7jQrlwIvdME6QNgLJ/DLmvN8YCmYIdPRM/kv0zkJ+5TCnioo=
Received: from BN9PR03CA0653.namprd03.prod.outlook.com (2603:10b6:408:13b::28)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:35:26 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::c2) by BN9PR03CA0653.outlook.office365.com
 (2603:10b6:408:13b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 03:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:25 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:20 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 01/11] perf/amd/ibs: Throttle interrupts with filtered ldlat samples
Date: Fri, 16 Jan 2026 03:34:40 +0000
Message-ID: <20260116033450.965-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033450.965-1-ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: eed064c5-2870-4e9e-4a69-08de54b04987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6sDymAtsMZZM4p204MBzshvPCCw9UgHtmLlvSvQq2mu7hny+B3fw84kzR2f9?=
 =?us-ascii?Q?zOQ+69vJ2j/LkVKRLJIzam3yP9I5rp77P4Rk5JG2eYem5PrM3JG3Kvgatt1v?=
 =?us-ascii?Q?UJ3KTlnMDxDLLQNLOmXFTymaZi7qJTZEectzNIXtkyNcrrN6i7uLiRTb2S2q?=
 =?us-ascii?Q?noMfwyahZ/gtMtiapKrO5S9mMPLLLzUn87Ol5Zw2YHlhcdh47QZepJVXScSR?=
 =?us-ascii?Q?b6r+6Ct+zluDjRU+CK0wbt6k/lvuDCnyYIx8LZupSzkDr9y6Bz7GMS3KM6Nk?=
 =?us-ascii?Q?vfUyJOVG6F6svr4RlYTvODyHBlKeIk3fuFUljVBm2OnsW1VX35lzr+Pd9sUl?=
 =?us-ascii?Q?pcEM2rAisP4VcYHv/WAojd59TU5+XGoa4d9fsaER49R9azeyUGFwcSG68kyy?=
 =?us-ascii?Q?x1/34yeX7PWn1CiCp1LqgDhSL7Uto4cbQIVfwUC98psEvsvftNdxgp77c7hK?=
 =?us-ascii?Q?iBimBwn/5fiCEsqR8DOgn6zNpAfDZ9QjT7cB6VOAD6hKwtAqeYfyNCrq12E5?=
 =?us-ascii?Q?mC5uNNa7VJUNe8kokY8kjSdRQTjQfvY819rAlXxsI03oJYL4JbBhQz4HeyQH?=
 =?us-ascii?Q?5CSOmcmW9zZ9soEv+G5FuV/UysEjeYPJD/22NxGoU589i+io2A5EFWRk+++9?=
 =?us-ascii?Q?Eey33/u1szNSWwJg74u/ME09nadX5aDxfF+MLAmN/w/RixD5thJ3eSuqziia?=
 =?us-ascii?Q?jM9+bGqenyFgdq7NvwJWxtmQDbChSe+5NIYrj9wv2NkIHU/KIPQ+ap09symR?=
 =?us-ascii?Q?X5qsbBq6cWjZT0Ifg+mWMmVPkVAb0ypFBKDzBPMqrpcXVvyNv7J8ktrXO/NW?=
 =?us-ascii?Q?mTpLGEX9R7alfBu4koFvBa7FJ8MVk1mB4fsew5btPKJ6aVT4Ff3uNjAIXQeL?=
 =?us-ascii?Q?CB9PCU6sYH59G5ezUaCpYpKbxt1ANZ+W2ShJMz7noFpQUskAJZuOI+bU0bDI?=
 =?us-ascii?Q?Vo4rRbWkrv+XW/CYRKU2SJ3WRVyiZcSSwDOAmidSQjk5UQCnH+qF3bSWQ7zK?=
 =?us-ascii?Q?sE+TB1CDxesl0P19f5JLZD+q8TxkC7pl9aWgEW1cFQ/Jf+15CGmrPokKM4kz?=
 =?us-ascii?Q?8xU+EFtbOszxByTEJmRwe+VCOTMUpinh5o00+gxAkFr/RA+kyit1Wc9hF7SB?=
 =?us-ascii?Q?Gqw2jt3B9WdHdyKd2xT0Djx0LePsFey8a20tF3XB7gnv2RucTy34ii+eehJd?=
 =?us-ascii?Q?CRAJueRwLFyD7BBCKOkzXpJmlrIL9lrqqLH/pdCj4QkSM28ad4KCBigjtIOx?=
 =?us-ascii?Q?JSX2y7ZpgLWp5LwOhktoMm3yFqpyRPRxwfT0J5g2GqkILCkezk2wezP29gr1?=
 =?us-ascii?Q?DrYth4eoRwcTKQFqIii9k8Y8FxaN/gl6sDXvnT1jxff/GcmX4bSxASBjD7D9?=
 =?us-ascii?Q?60vR5I16D7LLULo2+dt1bYokAq3Xyqa+i9ET0CiagZxd37ZfN6hTTDzSyVnY?=
 =?us-ascii?Q?X+JSLP5IHjSrPjeI8zcrZL/mM6H2D9W+2Gpzpud7cWQogDSbgUIJrer3RNBo?=
 =?us-ascii?Q?8pPYYbn3ZtIf2OsLPHWM5AWdISe8UzR2h1q92atkPS+jRKyFGXj58Ik0f6uw?=
 =?us-ascii?Q?Rt58SwX5veCy72UdLFa295Nh4BWAJn/CEsEmR0nNfqS3T2eOtc3glq1UTPOC?=
 =?us-ascii?Q?1mP1KHHf9RFJGhW+XC+OWBeqT1lyvlH9X9vpdFF39KYevbFxyGPoY5ErjyqK?=
 =?us-ascii?Q?KwC25Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:25.7334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed064c5-2870-4e9e-4a69-08de54b04987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

IBS NMI handler has a software filter (on top of hardware filter) to
discard samples with load latency value lesser than user requested
threshold. However, since software filter still involves NMI, check
for NMI overhead and throttle the sample rate if needed.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aca89f23d2e0..96bb0974057f 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1293,8 +1293,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		 * within [128, 2048] range.
 		 */
 		if (!op_data3.ld_op || !op_data3.dc_miss ||
-		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
+		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
+			throttle = perf_event_account_interrupt(event);
 			goto out;
+		}
 	}
 
 	/*
-- 
2.43.0

