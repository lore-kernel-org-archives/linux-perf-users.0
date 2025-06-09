Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3A8633F;
	Mon,  9 Jun 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488940; cv=fail; b=PvhTUc4daPju/Suj7YQI5cDo3sxb+00JT0xL11RfMF2RnIDmQto8VTC/krUFyoKw0qq6YBLBIZ3RETtz+sYemTQ6fJEJiSLsyqVuUiV/zWxLnpnA8sxKObZ88lT5BlL5FRZkWz6OX3ZdZf+vpvS9jfXyHs0q2gGHQl6VhoYUHCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488940; c=relaxed/simple;
	bh=h3EnPMQzPtv0UoFNS3mg6pgh+h7Czn3MPBxRtFYrpu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b1Y5Qi478vTa/L9ozP56oA7My7fqB3t5E9+NgYzqPAR2TxyrOrJ4XGZY6VHPsJIU8pq8tqi1AI/PDemYxebqB4roMXNgEbaN6WpBxuxs0nj+55cEour4bXRZpnYsAlbFPVj7UFfZlc6wW44vM1wcegk5lZp7riwUsVyLPhcfZGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I/kT11mP; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I/kT11mP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXACIr8Epl8/DfCtFNvZsnUtotH9ZZ3JeeIztmG38DXdlaHRe3Sy+/99hox7s0GSMGK0RszZIzH/5IC2g8Jaf0n8ylVVU2xbFLveaSDgd9gLr6AcFvUbBa/BKuj++cKz4r2gFBozMm3pUYhf4hNAHTc5ois4BxUdUTaa3O+adlD5RFJuJxe+GkNH9kUEpYeXika3sT1ASTP0rzZK5hUMNfXvOM21BDLgRRdXewYk3TCY26kv8u2RpS30hFazjKUESHkSjOo6Osd+Xt+X+W1N+egxAeJxsvPhVSkZNFFP3mTLFx1LG7pDsKrruORZrdKZ6xPfvJD22NsWgkOi/srJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSOqNqVOP6RWETMkl/KcHrNxwSLwL6XDMEtIdp9Q4Zk=;
 b=b+9/XK/brorGCtsZjA6qMazNpmfqL2QJRFStVB/nBz94nOqjBqBvXCRgKvyom0C12pi2NRpusk4xBF9BjkNqwZPCRS4qxy+/VnPHHa2Z535RXZg9q6ePyuM+D3h2K07zY14Z+/xBt/7nb9k9joCq39Vb7iPbg66V3f7jN5HmPHjaWC+GL+2XT3hTGUrcBrVMXCCX+/UX87Abgxfky7tIphT8I429G0Ira6JxumqmCkgV62yxyr6AWXX93b/55S5LGe1KRmSLh7YjMm60MuGZeSJPR7Rw0m26LFzeeutkJuByfNw5TxjPlKiCugp6jcnNmeGY3M6n/3G/mrmNW1mVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSOqNqVOP6RWETMkl/KcHrNxwSLwL6XDMEtIdp9Q4Zk=;
 b=I/kT11mPhGvmenNaXTKWR1WBaDgfL/gXcQzkafZhCSZnsxjj3AaaOSleOD98Z6dFXl4XiibUUfE85hTqXQaq9CHUiSpopZfxrvYzy9liVma9nh2o+63bW/Xuy3LNVpr05AXLF6nhO333UUTBV6DGRrIrjOWDpxZUNf5raKcaa2M=
Received: from MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) by
 SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Mon, 9 Jun 2025 17:08:54 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::10) by MW2PR16CA0024.outlook.office365.com
 (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 17:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 17:08:53 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Jun
 2025 12:08:47 -0500
From: Shivank Garg <shivankg@amd.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <david@redhat.com>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-mm@kvack.org>, Shivank Garg
	<shivankg@amd.com>
Subject: [RFC] mm: use folio_expected_ref_count() helper for reference counting
Date: Mon, 9 Jun 2025 17:08:07 +0000
Message-ID: <20250609170806.447302-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA3PR12MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e59651-73df-439f-f55d-08dda7784ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rE460TE9FnRmosNdP5ujCeqIoBGNRa3xQ9iSPcSZGpz3jhtaq6z7Bwtqca7S?=
 =?us-ascii?Q?IXxFTY0HHVs0caZG9BOmNjniikBCjVB/E9qpXMyE9HmvKf+od8gVdqpW2Ub9?=
 =?us-ascii?Q?MfxLa53rnvmn8CO/tKJkNxp24aL+2AdobgMTfBCG7YKBhG8x8Wjzn3jxdqLv?=
 =?us-ascii?Q?DjvWRJRP2HpQFqh9HnSIBYw6CKVyZtc38PF9ZM03PwCeIEpnKolTnBpjMwSl?=
 =?us-ascii?Q?IUacJ6fr27lOS6NSxErg6qsgqhhMWnJVVE350sUiWjm4Kkv5ZhrrcDn4YHc6?=
 =?us-ascii?Q?ZvG6DXwwQD352nvsMF6gaTB3vF5ia+X85cvTllOAAm+T/r53fdKiyACgHOzm?=
 =?us-ascii?Q?PksSXyKXj6Q9T/Idyzu/6x+W2/70X4K9oS9JSbztsVPrw/n3OdT2eedNI0Ly?=
 =?us-ascii?Q?jYJSP7qPBSKiIyYj2oFsH5sGlHEqgKuRDzSEsdsY3d1mnk5QatHItCXrUuOe?=
 =?us-ascii?Q?bwcNuSp0l8n2J7aLh/a+PAi8FbgvnWpWm0sgQi97D7ZAKzzEkNM4NJpVxJGm?=
 =?us-ascii?Q?E2Ug2DpJb6srlJBk/l1s9aZoCgE4hUdAKTUEaFCxenxlSk5I+z4RxqOIuuSA?=
 =?us-ascii?Q?Vyp1gzwimCQgTPuvO+uFcv1SBjSLnfnYZZt96mce8NIjq4Psids3HkyES9Rw?=
 =?us-ascii?Q?rHo2cVqtfmpA+1yuqYYZlRMvBUbiKGe2Uoet8QNq5T20kAPZyzOvv9b+rqYl?=
 =?us-ascii?Q?wPxD6QRhmrce5y7rRaXUaKxqtiHgddBPWPO8PnlOwot+U6QosCIeeSYXnL82?=
 =?us-ascii?Q?IbN7lUVd9BLIZJGXhLga5TDR19lSYeb8kkOJH35clvyqa4pePBmPfEHm3VXF?=
 =?us-ascii?Q?jhJ0hFEhB3nClAoWou9FfBnMvQXlvBfv696aDZuk2frgVIl8JXFLS/xkdAxK?=
 =?us-ascii?Q?nTs8f7/VmejsRNTicmhzsQIGIDMsiplTSmhQg0Ix7gkiMZh/Bc2lQFAHFkhs?=
 =?us-ascii?Q?rrkXVFRYjrMJQyIJdIHX10lo5KONSM7vM5Wqr4jIGWyMg0ipxGjI1Me20rhc?=
 =?us-ascii?Q?Bdu7kh7uBv+GnrT2bqlhwjRu+VpcWom463LRkE2tIPVzDih7uqA6zmS6R0M0?=
 =?us-ascii?Q?EI7ahc7nNOFheNBrZKyv9l7B4i7lg7SWwcC4pr244r/dUmLx+JIBU2JAp563?=
 =?us-ascii?Q?+J92UeWt7QMqrpcLhquy0IPFDprNNB9iEY/P8tDGXK7gsDEKJAdi2eTLcwrV?=
 =?us-ascii?Q?0ErMfnRxzvsGt8U1SnUR3p4Zjs5l2E6uECW9gBg4350TACJUbbzSIoDhThZp?=
 =?us-ascii?Q?48m/m0WHa8XRHupxA2cloV7oIibf28/Nk/ZAPVLXBXwpgTrBQ4eKAvPzaGJF?=
 =?us-ascii?Q?xsHF6Uy7HrGFMTRutcnB9jqJn9EtHXMqzIpB2JNlBXMX7tX6ofT6rK3o6ZIB?=
 =?us-ascii?Q?w+HI1ElDLaujfXLVzV6bTvH+m07XRqIy857FPPVsPj3Nghrm+QuCyZzY1j8U?=
 =?us-ascii?Q?qOxAjlLf2X/PGyJf85gJnR0mZ0NGvZlK4wdcB+EPNn7qF9w/930oXxrXR8Cm?=
 =?us-ascii?Q?RnRjihXI6UIK59L2js3YSpqyhooSgx11mcKSjRovNn+3DznfxQKuvtHQ1g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 17:08:53.5026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e59651-73df-439f-f55d-08dda7784ffb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923

Replace open-coded folio reference count calculations with the
folio_expected_ref_count() helper to improve code maintainability
and reduce duplication.

No functional changes intended.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 kernel/events/uprobes.c | 5 +++--
 mm/memfd.c              | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4c965ba77f9f..c978c8c27340 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -434,10 +434,11 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
 	/*
 	 * When unregistering, we may only zap a PTE if uffd is disabled and
 	 * there are no unexpected folio references ...
+	 * Expected refs: mappings + swapcache.
+	 * We hold one additional reference (+1).
 	 */
 	if (is_register || userfaultfd_missing(vma) ||
-	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
-	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
+	    (folio_ref_count(folio) != folio_expected_ref_count(folio) + 1))
 		goto remap;
 
 	/*
diff --git a/mm/memfd.c b/mm/memfd.c
index ab367e61553d..4ed5506221b7 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -32,8 +32,8 @@
 
 static bool memfd_folio_has_extra_refs(struct folio *folio)
 {
-	return folio_ref_count(folio) - folio_mapcount(folio) !=
-	       folio_nr_pages(folio);
+	/* Expected refs: pagecache + mappings */
+	return folio_ref_count(folio) != folio_expected_ref_count(folio);
 }
 
 static void memfd_tag_pins(struct xa_state *xas)
-- 
2.43.0

