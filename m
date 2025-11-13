Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB042F0C46;
	Thu, 13 Nov 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049785; cv=fail; b=aWjQXF0lFMnYtjp0QIgBWbbmIfhRPd93HPWvp8Q99iAeFMu9P+3WyRFk6rHH44Sdf3LONgENmdh85NjwkfqdoROV67AWetiuprHvA30XhmZ6sFKdWFDUaHEUKhVz2ggZjxXYx7E7np+h9vmxt2qbNW/qb0QSVQhaJ8g1PUfu+oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049785; c=relaxed/simple;
	bh=4xA2qqDXPNL9BiHQen24xQlmSX5ScYRw9MpPpE5AOAs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZzteEh2wXf1CkfqHXoL6yja1FYZAa6hgNSJFtBMECjkQHK/19BzRsPNZM2SD06fpVbK4YS1dutLOCNCZXQdTBAsvLSz6jGZ+xOazFlItYCH+8XJ3XjsscASl9Svg69d9MDUAbA8rj3V/b4zBzqgz/I11f5GXjkshoOOpuePnMpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dbq7dBIq; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dbq7dBIq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrCMpPe9idBGrtT998KXAsaAJNjUS4BTCoC9xrmymVEGf1mqV2RoqyB5kawPu7gw+/EV06VSvIekQJ5rYsOX6CP6+yuoODOSwkjHmOZFLnAxAwfxgweu7x3JH5PxufJqJqlP/X2Ku1GJ9CCrHUGZpWM+7rcez56xKSjtLVJpYX4WElin6gJXzQcahH4JuICHm7Xn93wsHY0pa1PQRk+XHJrYUPvaI2BLWoL8QydKZqbh9hOXSD+S0ZgEh4Kycw9lojEhzjwdWljwmyutyizeExnnsCbKoK9NySKXkynbFO2NZnP3V89MHVELjWoesi2OeeFOsoWqTK5mMjYMGQSxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgKhDgzbvQC+nTLmHiW1j0hgB2iDAJT9t75nlB3jSyQ=;
 b=bQ8jahTBlttg7PkYQjqM1vynE2eDGIPuBYnuu1KnOkSdgbxCVLgAflgtIbATlXdwsRbMdOJsJVzARQeVH8xZg208hrpEex02msBECBono/sFqhFRxtCIN1IqjrSBWgtwCdZl/4xEfrjawzs2P+hWU9N+lsn3/06BXdCYZI/cJC/aQr8jdd49E6DW8KWZvnp0TScXZPe2BDbGi1x40TYyHiSvL94/8FwqiiSt3sMxFjpE1iGWdTxmnxh7yVZz276oOOeDMU8+t0JqilvHlvxbY3E02WbAwYVe6vKhfo63MXuLGsGspochDgEsmmy+/uNdcGys8sjWylDpbJPYVvgYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgKhDgzbvQC+nTLmHiW1j0hgB2iDAJT9t75nlB3jSyQ=;
 b=Dbq7dBIqvQc/mAWuXMNhwGUnlyAJfRVXHWoiGox0cv2bsGO8KFivIr8b1//sO8Xeqi4ugncmHPamofFsjiDmEYyyhJOZ2iXPaHWcTvuYo0oRGZGCT77sOxW281A2VPHXcXgK6MbHEE/NElQ0aOydvKlMM133krBoEuViYSY4PWw=
Received: from SN7PR04CA0237.namprd04.prod.outlook.com (2603:10b6:806:127::32)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 16:03:00 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::de) by SN7PR04CA0237.outlook.office365.com
 (2603:10b6:806:127::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 16:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 16:03:00 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 08:02:55 -0800
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Tycho Andersen <tycho@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 0/2] perf lock contention: Assorted fixes
Date: Thu, 13 Nov 2025 16:01:22 +0000
Message-ID: <20251113160124.2695-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|LV0PR12MB999092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3faf0130-e6f7-444e-be3a-08de22ce1e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?41WSKFFNxKsXYCXhma+7ZZ+F34YnlZCE2eQ93S8Mb/9ikgJrKwFm9ZgleU7R?=
 =?us-ascii?Q?seupHDLzxg1zONIUn+hdskiPzqvCO9zIad6lB47DR7zXBA9GAssfJJ8j5OU8?=
 =?us-ascii?Q?0hmb74UN3uLhguQLGeQEG1tMLOKAyxq/iBVe9Zd62mmivZZBkatCmlUVY/mK?=
 =?us-ascii?Q?zGnlJMEbYP3wyFXkhHM9JavNy4p5e5AV//zhErNXQ5dXk9v8ZOeVtojudNpF?=
 =?us-ascii?Q?1RzPSiaB1oKh1lLKS2n0jbNPxLxjzdX74peq5/sCbhWHXnIAkPy2ZVzcQssy?=
 =?us-ascii?Q?CC6i1CDwlXo34RVYlIyVNxwimagJ5azX28j/PdkMNYWmA5EsACgIfQP5BOAG?=
 =?us-ascii?Q?kOCi7qVyMA8O/4h6TJ7bzyupS9wZtkCIMnk+uJH6GSkAtGYjNe+teqUjf5Li?=
 =?us-ascii?Q?1GfYaiIW+Xk0ceMkg2woKnkGdl1qBwquAlVA8AhR6TYZrnm5v1ZNNOjObT1K?=
 =?us-ascii?Q?dGuWv4GQ+gg7jDNjPu4OpVBGD4kZBgQf7QPROEBDkfWOBnbTGcN79azr/ftX?=
 =?us-ascii?Q?0nz/bzSOXIPQpcoRX0OU5wqpyxPNSvOugqSNv9zeqweqOCVt4L4Hbh7wxHiP?=
 =?us-ascii?Q?wMiuxTUvuZ+Ykgo+I9lepoRm85/QmdOjEERz7CKEBIaZ850Lt66VeNr+Ci39?=
 =?us-ascii?Q?pPBHKThGRxrtJ5QUVUsY86lZEwNXbXjKYZL0t62TrrfVqiA7akhtIlYsjo0t?=
 =?us-ascii?Q?hia87oqri/wcr2smbxAjaNheyOPmbDLgMdvqyVsZxFOpy8obXgsaEw6RI6YZ?=
 =?us-ascii?Q?YRJSvj95+II3o4fl+lyZqH4A6mm+bjCbuRPzTwTO73ISNBVcshiACq9+TKD+?=
 =?us-ascii?Q?ye9plQvR7cQnONz7jeJYnoXrGCZdQDBPbITJszcpEfhqyeWYzJefOVv5yXSE?=
 =?us-ascii?Q?cBG732SB6L05zEkqGhxVXVEs7BBIRT1+JuLIRVfSQ9Cp3Udd4x3rZPVFmuaL?=
 =?us-ascii?Q?nrpudKAQn9i28+frnDRnNlijxj0DV8lm7tNA1DnyCtUEDk7xKnhUNi1BcMsT?=
 =?us-ascii?Q?GlQVIYP1HD0iY1bCJ10gevm8FaQQ4x4bKHGboxqQyFeh5Mb9+bbkqnXhDXDv?=
 =?us-ascii?Q?0Wm2wWNR6k4HOCN1EcUv+QSpuUyHj7aAzpKIuj2sHtLCBcYU1D6TGbGy2icq?=
 =?us-ascii?Q?Njy8lCDZ2dd+6Gyu1oljnf8i0mKZhAVrHvAKzsCOoLIhqWqPgb3uThvjd/T1?=
 =?us-ascii?Q?ciNvRIQYuXXyQdJ5ISVLIHHViAvJ+uLvgAXazQRKDFTHf4+tm6jNwBbhijPo?=
 =?us-ascii?Q?p0ToDIRDEGiZ1SYBlKK2B57SwIe708XBRouPETKQZnRzyT1fmQ+jIEN6c4Uy?=
 =?us-ascii?Q?SM2DwkRF06U2OZb2NgeM7xGGXrqAvFXp9W5Ypb0jDwmACCvue3Tqqt0VqAG5?=
 =?us-ascii?Q?DgkJRzPMNqWWdnsfF3N8aLJm24IHIEX70mRIkkYl9RdTNrZTv7TOCAxjYTal?=
 =?us-ascii?Q?7K5zMPrL8YXzxz9yXhwXAcCijWvJ++2nvEwVnGLsIc0qVW0UyuZFYshFEA8g?=
 =?us-ascii?Q?rWcz5dJY/MnTcNtdXo5OJ7su9tWkztstgLXC8M/ukswG5Ncb+jlsAkE4NIBk?=
 =?us-ascii?Q?rGaiWlT1fkXnf9fXvBo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:03:00.2742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faf0130-e6f7-444e-be3a-08de22ce1e7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092

o Patch 1 resolves a segmentation fault in both "perf lock report"
  and "perf lock contention".
o Patch 2 repairs the perf-lock unit test.

Ravi Bangoria (2):
  perf lock: Fix segfault due to missing kernel map
  perf test: Fix lock contention test

 tools/perf/builtin-lock.c                 |  2 ++
 tools/perf/tests/shell/lock_contention.sh | 14 +++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.51.0

