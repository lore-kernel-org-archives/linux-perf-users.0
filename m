Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793382705;
	b=4nu1erdjVyPnZ5OrBbknBO70Lo4srBczS/6Vay9fe62D8Eze7/sVsBJo95Jd2TKfk5de
	 YFU+q8O++pEoflEPfVP3n0Cj8Bn6UMQfMseFthH95EMptnfW9dlVQ6rP8Dh2hGva8yb/T
	 2C7HiRx4AScFK8C4qybptEoyIP29D9uNN4TQYZYjmVSMg3fhg3rAN8P+NyjFMNntqDC7K
	 wzYsijLCQawQLvKAzUtFF+PuydFPb1VzX9nAz+NkfeCYhnv0Zx2OqSpKERBLla1uoHoI6
	 G72xan8JX6bTNXMar7x4y+tw0UdcIAMo9W4WQ7sWbKMPZ5dNDBgZhALjQotF4EeBRmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382705;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QIYCLPpUh3b+DebYPQJix5wnkq03fOSnayYKyPsdwuU=;
	b=o2+q0Oj1U2UcV3YQIsCA8Qe7lcWeVkHDF/gIoUkYNYpHoGWBhJ6irwrzlsYkqe22tU8m
	 TFXwImO0BYO/pLPhV1nzLMve7oEFk4OFl87eBzW0QJKMUcfcJUfxMnnLJv84DVRyVp5KQ
	 zO9H6zxtYyYf0FQROdn/a9CfjY3g8OIYkpT0hQ4tEsc1ehQCM9NAy8hbL4DfwRQF34Zst
	 3mBJghEIe9v9e8yNL5XnWPtIhZnD0lSYqUc5yMTYU0r/qba3JyO9/wUIdXDFRhHmXf1Y1
	 pZJbUNAA6ArwOZgt7fxqD5Y26dqIsdgIMIH9K32+T4YUZ2UHG5sADtO2XUy+JcE2GVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ks8VsS72;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.35
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFC606A31A;
	Fri, 30 Oct 2026 17:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EBFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ks8VsS72
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/S2dDqBbbhHE+7X53IJdD74y3FtdiTgHf1cofjZgIeMpWikGHLOtrCBvGaFnG0wtjuXeMCGFObMzk+XW0F4GJpR8bJAEXkuXQEWckvTxLUNYC+FFuEmAPU9NL9DgIe3/2PurNHKKcig+MdH7NH+jWrvnMyFk/jyWnBj4GeMGMJ99pHH5/q3Nkpvc2lZwwyDKVj5312LW2+IZthZGEjgTIdTSNwZ/5Myq+MA/nXvxiqYWmz/qmAcTpN1+rtctP1zTcvzMs7aL16Cjc8QL59L9bDb8CkO8SqhrzcZws6RELxDiv+ku6+gtCS+7Is+0Cgi5DKhTMJ0C9DvKRNR5q1E/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIYCLPpUh3b+DebYPQJix5wnkq03fOSnayYKyPsdwuU=;
 b=X42lYVgKmwbNOA/BxlbPJQVLa0AutxfDmVvZLv8jEOoaCRxS2Jj8/1NeMYUUXNZUGLvrsrVq3GIY4LlOupo2E+HJAMdu4FkT9BIfLwNdXmcOCeFWRvB8SuiTbyHXxl4X1NMyh0tqyP+I0XS1VSmEbKP9OZwn+z5fSAbuAsHsRxldSdaI6g3NfrFjAWKBUyIUBpg0IL/EuwBZpCpTgSrAC9uCTB0IhfshJ/NUNc04WkB8Ye7g1KG5u71zfFg6yx5qFydwV9BkR8Iilfb/+SCvUP7xxRqwPy+0KJ5rZjpzwR7IC/Xznw0oT3WIXNNOGmdrZ+f33D/y2aypVkrGFDPifQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIYCLPpUh3b+DebYPQJix5wnkq03fOSnayYKyPsdwuU=;
 b=Ks8VsS72zUhn+jPUDiw0zD1VvfyZe9t3SnY0OSuQBjJLfBIHi4Dy95Sv2JBf7BwXl5/wIvMntExB5pegvmva9Z8XotErrdyZT/NTRx6EawT5nCx8e5oea7ZtJY/mmo5vGMJKHhI3BEY58Vg3dA0pXVM2CnY3aVwSNbEicCI44Mv1ps1BXxrJW27nTO583vvFMFchzYWVzBHj3UgmlVA4lPRlkoe4FMr2WvrFeBpEBJSeYQMgBbS55WVgwa9m5Aj1uyybjM5Z7FhhwG5Ki4hZ0YsKomxnJum83gC2s2cG3ncIuia/2aOWQna7mDG994uh2svm7x3KdWP4Y6z9JXXkgQ==
Received: from CH0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:610:cd::16)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 17:51:12 +0000
Received: from IA0PEPF00000044.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::14) by CH0PR03CA0101.outlook.office365.com
 (2603:10b6:610:cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 17:51:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 IA0PEPF00000044.mail.protection.outlook.com (10.167.249.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 17:51:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 10:50:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 10:50:47 -0700
Received: from build-bwicaksono-noble-20260804.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Fri, 30 Oct 2026 10:50:46 -0700
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
	<ctshao@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<mochs@nvidia.com>, <rajjoshi@nvidia.com>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <john.garry@linux.dev>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>
Subject: [PATCH v2 9/9] perf Documentation: Describe PMU names numbered in more than one place
Date: Fri, 30 Oct 2026 17:48:16 +0000
Message-ID: <20261030174816.1544471-10-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030174816.1544471-1-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000044:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e2c763-4e52-40d1-475e-08df36ae6286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|36860700016|82310400026|261026140227099003|10067099003|11063799006|56012099006|261009221227099003|261009223027099003|261026121527099003|261022105027099003|261028144727099003|261021121427099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Uo87Jlzq3ImZQpQfP+kRX9C+96001IZGozhD/+HoX/ASuS0Ok4bsypzHSqL07+FpKVwIgURjZ6HbWgu3hijwR56ZhZCAfjM4SBr6cv68I8RVbpS41LpkwJEqDN3EyVtlwSdtrnwkNhRTpVAHQzNVR94oFaGdpO4/iORW1tw7VLzrGdO5ncVSsDLPcKSrJgQSobMTckOqlOLGuNliVlXoXDgK4NXsfYCUGr8mozIoWooZCKZTEK8/pTnQDBhI207U8Sd6SjFIu6YPBeGgsT/JZMzupJZpbV2l/F5VLHuiEYzbrgxyAHYZPZF2S7AZW2MwO2pqZ88pegcLBtHYWUQ8HsAp0McYxMrpDb1bjM4eYgiWVMMso3RPFSMqRBDtCqbcoMhkxm7AxmczHc+frnp0+feyqe52dQc1RP+8IOoaEPJslUJLdmldVrJG+k9VvJLCSG3TpWE+uKYv5dTTFGw1PYZ09tnTsIViNKre5YWWBou/qKoGDJnXJ4I/USUYdMTkSo4h9QUwRX0+XCuJg+b88xKBg/lbU78Y3sppPVFWimIFo4hVc3EV4CRDMr5OJVUbK7r8AjRSQe7+gVh5jf6OAaWjZNFMgQ5k1tMpcdQ8h0dXZV1px15a4mw5/dpe3n48pU+qToVAExyr/0kuqnrLvXh9Ej9P2l44VtjoeQCbiRvLmNvAeIkfp8LHCfZNOEv72reEGEakt6yVPdxnfi/qxQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(36860700016)(82310400026)(261026140227099003)(10067099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021121427099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	COEa8VFMyh0Dd1SgmPh1CBO7yTqs/+60wp5EBs1DtuNkjORKR8Cp+zuk0RLqBp8G9YeqhPFUEOkif725Y+oVAcMeGDHIRViHj+kORIl6uCq0py/1ICHc2lyW+snx9hZvf0HfDvrUszC9VXpStaMMMAC0QHJVao/zvFGsgpjMH5ku0m7E7JpPiy1SOG7nK+15WjHjyJH43JZh40v9psJjbV/vOJioBMooMdnp+eA7LZ8XIY2yFh7KEcZ/yDIxPWidzpXIkOtI64mZM5TK1Ud66ghyI+FMEJtPkbRw6W/xcIvOk0K6csqZMyGtMZvh5QotKqgriWeou70ZRR48bIFVdEolAr9rnQKrrXsyi/KDUieEgssa0Mghv7GcR2mtlYFuv1zLgpWjFxIBg1kle+qdGGlsi0uYXax8XpCFOCepWa7rVX9rcVhmY2BJU0Ek/h/1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:51:11.3265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e2c763-4e52-40d1-475e-08df36ae6286
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000044.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673

The PMU naming convention describes an optional numeric suffix that tools
ignore to treat PMUs as instances of one PMU. Some PMU names contain more
than one number to identify an instance, such as the NVIDIA PCIe PMU
nvidia_pcie_pmu_<socket>_rc_<rc>. Since commit 730670b1d108 ("perf pmu:
Support more complex PMU event aliasing"), the perf tool matches such
names with json event Units with comma-separated parts, like
"nvidia_pcie_pmu_,rc_".

Describe these names and how tools can tell that all their numbers
identify an instance of the same PMU.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices b/Documentation/ABI/testing/sysfs-bus-event_source-devices
index 79b268319df1..7610aa46cd50 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices
@@ -22,3 +22,17 @@ Description:	Performance Monitoring Unit (<pmu>)
 		uncore_imc_free_running should be treated as opening
 		the data_read event on PMU uncore_imc_free_running_0
 		and PMU uncore_imc_free_running_1.
+
+		Some PMU names contain more than one number to
+		identify an instance. For example, the NVIDIA PCIe PMU
+		of root complex <rc> on socket <socket> is named
+		nvidia_pcie_pmu_<socket>_rc_<rc>. The name alone does
+		not show that both numbers identify an instance of the
+		same PMU; in other names, an earlier number can select
+		a different PMU. Tools can treat such PMUs as
+		instances of the same PMU when they have a description
+		of the name parts, like the perf tool's json event
+		"Unit" with comma-separated parts,
+		"nvidia_pcie_pmu_,rc_", which matches PMU names with
+		an optional number after each part, like
+		nvidia_pcie_pmu_1_rc_3.
-- 
2.43.0

