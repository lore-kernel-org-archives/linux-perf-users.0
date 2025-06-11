Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE3224B06;
	Wed, 11 Jun 2025 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749619699; cv=fail; b=SRfuNody3kl4t4KYT2YHx4bOm6L1N3yCiAglum+gUG5oKQ8x4lHhlrsm677cDc8JwNfmXLoa2M5/dLL8QGMTGNY+rqIMRXBl/FlW6nB7y9yYlRq5YG1mB0VtknOzJ2EFqNWMAyaTOAAc2nSRmqOIDtJmlLU6timfLviCFuiKTX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749619699; c=relaxed/simple;
	bh=uBScSCCPVg1vl29dJwH3sqx4+GYV85qCfp2GK6Lo90w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f2Oq/kWcL+jbn94t/5/CkH8mn5QSa23RjoBV6NKiRLeQbBcVHmFQEPHTYllh2CENLnTXB1vZH8o4GPO+ZEtCUABzgcGHI/wOQrbjNEugMrhkGe9hBXBlX0674czqwQwdEvqjZ09Nl0LrZFBHTO8UP+jIBe/7QrxjK7xiXSyZ3SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjM/uGOh; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjM/uGOh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Loj6oF1CBBBHefSII3BA6WaYRYsCFKnigSF+EZ7QHD34hz1QdJ20ZzIXdMb5kE0HvHylrej/H6eIr5ZZBB275lORI010S8IVCo875UiAXCUoiq3BfegMvMy4qm23SY0QCUqGFPOSDPVl9Osfk9+Zr/Th23uB4ACS1XcSJzwQHnn5p2K/H2dAEUGALTmzCUkuG875ewdny6dJSpOv9d7zo9k3UfW4JiL5IT+zjODNP5cb+097GrmNg+8fkrj9e/lDVLQEmRFe+z48q1eiaioSMIA1DDNP9Pai8vmstRKTxvwnca8tn5NVyDSpwb3ssxmjZfuTvSBRk70Mzt+FaTMU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0hkpmGIcEDkpZBA/HfLji10IO/IG0Sgj/djBfcSvwg=;
 b=NqW+l4tCubVVrkEjea1u2hcbxsB9K4wmOA+MfXDMBh+GkQwjwjcLBDYV7yibmDs7LUPoRkgnvJo5LPd3daDpzF8bY2roy4pCx9Nu0N2zGiXUKXXEaIYEpT14j+4aJKz5aOH8L9Dsk3adyGILAwnxlJMm63udsY9bKqxh6+PVqEsRe6WDNq2ayfFmIqYfCcADSnmYjuunsAOwr83ReKiDW3fnLQmdKxnGBKYJF9VcEb8ZeevH+TBalhf5qFjEqdTu/eiUXZ7wZe7yXu2Z8mLckAno5FbUkG+kqdr8rd05bWST/284/2iWlQnQhXwwLLGaouu4j760QoPD69njOvZEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0hkpmGIcEDkpZBA/HfLji10IO/IG0Sgj/djBfcSvwg=;
 b=OjM/uGOhPvlmtm7S73WzDgxlwzg/O/jVQkcs3wJ4j9Lba7zkvLq5+VYBAx6qyz0PVVSRnVcOAIDFSatIKIvXjuZHGwcWfz8PKMFZrwkYrqoNVPheHNId4B7J5lQs4mlbPJ0yDadEasSrERQcviK4mM0LG3Po6/bbONJ9HFXRvdw=
Received: from PH7P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::9)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Wed, 11 Jun
 2025 05:28:13 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::bd) by PH7P223CA0012.outlook.office365.com
 (2603:10b6:510:338::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 05:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 05:28:12 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 00:28:01 -0500
From: Shivank Garg <shivankg@amd.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <willy@infradead.org>, <rostedt@goodmis.org>,
	<apopple@nvidia.com>, <david@redhat.com>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-mm@kvack.org>, Shivank Garg
	<shivankg@amd.com>
Subject: [PATCH V2] mm: use folio_expected_ref_count() helper for reference counting
Date: Wed, 11 Jun 2025 05:27:07 +0000
Message-ID: <20250611052706.515408-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: f41d2a4b-43a3-4e47-6562-08dda8a8c27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aY7dNwCpzDoJ9iYeHKVHBueyqK2itUC8tucvcD6Cdw+aPx1AsAlcINgkXv2a?=
 =?us-ascii?Q?/6n8fqNH8W+Oel8Zfvp9UPOFk15wmwGau9IC5G27Iznd5f5a/2K50KFS7nl2?=
 =?us-ascii?Q?7ZQd30e5LSLihy2UPXHaqe0ts77SeJ4gYagOLO5jvvVYzNtLBKq+26Dxpriw?=
 =?us-ascii?Q?mZ0/jsPcRzX1cf8DTjsU1N/3tueyiJbPGVVoPJ04gW7FcTKF/kLzJJP/V7Ca?=
 =?us-ascii?Q?k40SG1cUlwrX22e/+48S+KuPuIJozaUghCmjwdovpTZX2O3RQbyXYNXrHBao?=
 =?us-ascii?Q?heBIw4zfzgjPfSqhezN1Va8l+nk9yFcw3ISmknfDpeSMYVkecFWZmcN+BBnr?=
 =?us-ascii?Q?AMFytBd12hzYahJcwz9BLfUkC1CoKYPLot6RbCqJjHLHwZ0HRvlZiWfvSnCQ?=
 =?us-ascii?Q?kNmMxtckoPo6ARmFzIPWMoDlPTIX7HXs8D2NOYyKG+oNr8L2b1DgTEmvT8sR?=
 =?us-ascii?Q?PVbLdsMUyMO2LlNhk+/qCt6O75Gxiji61W6py0JNXHkN4ue8GafygyH0Ruol?=
 =?us-ascii?Q?drZ1XxmcC+AegcU94prIZgNNzczEc38i9kQ+1WBRWxlk0dezCmhMpPy7cAG0?=
 =?us-ascii?Q?f99DjpVaUS6PYYEfPeS3p9ojY0wyQBNQi4ucvMKZjd+e1dgaxxvzrZQAs7lo?=
 =?us-ascii?Q?xSRvKy1bXmW0VqqgVWkSjilDcTZ9BXZsVgum5Z58p72wDndmr6SWHDVuopCK?=
 =?us-ascii?Q?pqEjtaOW8m3Ux4Qpa3wg9JP4ZUPPqOFeCvVckwoFA3jccdLq7bt9RPpOVT72?=
 =?us-ascii?Q?PDZ9kEtbWkakUyXSNRlKgXvhPutGXuOA+TfzOTiBib7rkQDEAcEqZhNSMT5b?=
 =?us-ascii?Q?BcC6rRQ4IohYES/ieJyCdlbzIQF9yeSX8WDuzMKpDELSLkurK+7ANTkxUW3T?=
 =?us-ascii?Q?FPM3EBZznqX5iD4VfFaaqpTWhdkBWtEXQXUqP1OswQ90NdvgkWuLmxCGFGnk?=
 =?us-ascii?Q?iXbY3QVBYq9LjCqnTyLmFMU7wZG5KJxXtEFLOWUdsvklfczg/B8gbnxmaXcs?=
 =?us-ascii?Q?sR6Ufifa0zr3c2sZIhz+MABiavKDoJ/Fa5TmHHCV4FU45LGCsc53rooElqJX?=
 =?us-ascii?Q?vwSzjSw2/insowScL8QJ3vK0chyKEau3mxxnOQp+SrmP+lOj1ykl6g+LmbTv?=
 =?us-ascii?Q?3T7IDNK3VbPyDaUN15hYRVKXAqAGYwWiENuZjKGC5jmj19uYpQzUolkz5WIc?=
 =?us-ascii?Q?QtQJRiD/iuGfOznqL9u21+x3u3wpYTewj+IILZIKhLY4vPkxvsTMrs5BbEHC?=
 =?us-ascii?Q?H7HsiuIrmsB3RZKmZLphKBovtRTEWMntHx+9Fg/cLm9NgEFpHROqv+J9+ZDN?=
 =?us-ascii?Q?pA3mYWrSzEQ7eGgEWp/okrt2OpK9KKoQvj6g2ODqB67UeRYiD6UwhiuTtpT/?=
 =?us-ascii?Q?g/HAtrueUnO2vjcgG3WxCCLGpA165vEOht55vdwqHH3QNtOUPX6UAUi06jFL?=
 =?us-ascii?Q?e3h7cPBAM3rLZy9j58r5bgqIE/FX7l+ugURDgTxj2bDLG8XOJmG3jEczoS9y?=
 =?us-ascii?Q?iyD96zroMw5m839IfTM+30h9vWvURwCavsRwSu1mlY5nFZt+XNDSrMqzhA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 05:28:12.6243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f41d2a4b-43a3-4e47-6562-08dda8a8c27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176

Replace open-coded folio reference count calculations with the
folio_expected_ref_count().

No functional changes intended.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Changes from V1:
- https://lore.kernel.org/linux-mm/20250609170806.447302-2-shivankg@amd.com
- remove extra comments
- drop RFC tag
---
 kernel/events/uprobes.c | 3 +--
 mm/memfd.c              | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4c965ba77f9f..8a601df87072 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -436,8 +436,7 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
 	 * there are no unexpected folio references ...
 	 */
 	if (is_register || userfaultfd_missing(vma) ||
-	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
-	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
+	    (folio_ref_count(folio) != folio_expected_ref_count(folio) + 1))
 		goto remap;
 
 	/*
diff --git a/mm/memfd.c b/mm/memfd.c
index ab367e61553d..4db1fd2959aa 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -32,8 +32,7 @@
 
 static bool memfd_folio_has_extra_refs(struct folio *folio)
 {
-	return folio_ref_count(folio) - folio_mapcount(folio) !=
-	       folio_nr_pages(folio);
+	return folio_ref_count(folio) != folio_expected_ref_count(folio);
 }
 
 static void memfd_tag_pins(struct xa_state *xas)
-- 
2.43.0

