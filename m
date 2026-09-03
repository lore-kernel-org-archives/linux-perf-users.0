Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811E440A0B;
	Thu,  3 Sep 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436528; cv=fail; b=j0/SlZLIsUA9d+UlMbPHtGvwQmanJ1YoR9AWlOPW0IWWDFo1gRXcJve9KdYvQADsTorcmYYnUy1Lceh4wp1wyaOTQgvHAtqyq0KZOKSWkuZr6Dw6t/TZAN/83QhYM9675QHxXcYsgjg8dd1mWCIJLWAKqG2v2OPqlOnD9EdJMrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436528; c=relaxed/simple;
	bh=BhDEG5FguE5jqqRdrY1zUv716lx6ijb25/UHtifiV0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GyXvxE+qK4xmCeZYV9lcdsaXUxzdH/9oOpbZS3A+MpyRFm631dg9XXUR0hc97rW3Yv0TJp6dtSQmO+VfmHt2mp1jLFN6Ow6hcOnJe2A3aCKsCSUS48+Ze1RUAaNB6sfOkv/9ZVwr8X7tiF0kGtCFwl4NzxgOdxg4aKGapNusMLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NgYUaG7d; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NgYUaG7d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AD++1XgQ+9o9hjH8bcfDD+sVgQceyi8PUoiCTro0aNzZJFB0wdrCdoTqn8kxtRz1VCv0e0WGOvQIOGQ8NUD5vcAWRY6DlpLT95TE7UNong+D4BtSrREvCmKiRlkg+qKbLffqOI85YYMJz3aePOEpA1RokNQRb5m/INeORcWk940cbz5p8BwGMBZzYoOZ0/PpmdgxU19J4QicEZoLm8jbFU2C+CNcUM2t9HnBbrCay8+GLEWuSgZ5nKmcPF/wbs1ggb8gOZSynHyRUxDt6fjpOb40TEzEVTCfAdYXm3HaAWO3D0TIFr9VsYI8nDZnkuSOLz7pyHAwHu37OpkzERU+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbj38qnJeBXViGfjjqER99b4w0k9Mb2cN4H/EDuTTok=;
 b=Z6i9JjhR/8k4xVcpCDJGqN61kYv6v7e3SO7E148j73OW5EGkZrWz4d+6aHA5sHhoHNGNRBF3h7f/AWqVnWxHUGPEkkcIXGVMg07w07GOBNemvy5rde1J0F9lRaanbsLu7oBxJjDG/Tya4sZ24ckkxpD2a3VaADh0Q0zVgjq9BiO/zp7B+CC9UsmGVCUoUwylhFKN0TIGZWZGZzD2dPRUhsti5JaOvZdD7hyBo4Ve5i9ApYelCbppar+Dqh2MRdcyBqRkLQtTPod1RFSIX9i/dJPDpoZ275jOaKUaoxgJ8rv8Sv4dR9Bo5i/ZXwtSIdB+gKo1icm6QTqpcIY1gjytaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=hygon.cn smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbj38qnJeBXViGfjjqER99b4w0k9Mb2cN4H/EDuTTok=;
 b=NgYUaG7dZ3M0XjgbLjatcHGtOuXqLEaR0vPKDxWvWwazji0gYiO3XyFDCx1ixbgVOem97ueUWJBe6xQuBGkkb1W5uwBVCILJzp8pcx1D59OP6bRFzSuIB6g2UvpoRrcbIAy+qA4P+a2uiSBW4mCB9KCJQYmFWSPgl4ChxcdB2yI=
Received: from BN1PR13CA0029.namprd13.prod.outlook.com (2603:10b6:408:e2::34)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 11:55:19 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::9f) by BN1PR13CA0029.outlook.office365.com
 (2603:10b6:408:e2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 11:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 11:55:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 06:55:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 06:55:10 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 06:55:03 -0500
Message-ID: <bd3b3a2a-2dc6-4494-ac3c-954731f4a468@amd.com>
Date: Thu, 3 Sep 2026 17:25:02 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
To: Huang Shijie <huangsj@hygon.cn>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuqi@hygon.cn>, <lijing@hygon.cn>,
	<wujianyong@hygon.cn>, <wangfengyu@hygon.cn>, Ravi Bangoria
	<ravi.bangoria@amd.com>
References: <20260903054422.148739-1-huangsj@hygon.cn>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260903054422.148739-1-huangsj@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 302d410b-077d-401c-3ce7-08df09b2393e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|22082099003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	oUVttUQtGrIWFcO2epjk5rU1bHPvdtbnXZcY0Ncl0DRhlGAD+AHpG56GpfGqvSTyc8wLT9WKzesof1Q5x5MVib0Xy+RgeL80Sg/a32ImjR22MpVpjf3aw2dImuYziAgAsZVKudZkJFper4KcNOh+2J15uw48sY7DGEczUJccby3PNvAWA0BjL0RV+3R7UhNwSGUyVYzNYkKhB1mk8XRMkNbSKrqrd6m/eByFEYR+kU+658yHBuxw3cSd/kqrcbbq/UHi8NsBRWjhHk37YZUuOB8Ppyex2T4iFrle7s6/oDI1ajNH97S5UsS4zvql84YNgwzA+j2lGPMXusd+SFGbD9fpsPUUA4hwP+z3AlcN4PVg40VNmQUwjuAQNjm7ZZWZCTA+CiC2C4peo/S0RE3l1rP1AYv4Ip10t4Yo4qzZzboM15hi2FLQSZQauESqlEZ4gzpPYPnS+dm/QJiX/bqEKDtYKsKFqEJum+Kw4vcV77di30s8/Q//fVEGRsdKhLbBes8pVeroupWwfbjADImKRlGu7rlR4K7lSYifCdr5gBF/drxeYHDLqEMCcDXL4W7n09dIyE3inPD9Q0io+jE2UcGudjkQlcbZIXaWw/8YujFCA7fbqrTq4x43YOMXAAzl9fASwbzLE3aIzuZQTPhNe7Mjz2T8wdZ6/iWmp6kzPHsMx30AiHbDN67Xj3l7jPrsWUdZHW7p3IcbJzdhK7l7sQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m6S/VUxR7gVZ24Np7Ngj3eD9eg+89Rf5uGQBugYUIOH3mARmJh942wb962jt+IvJiyHF4M4hiQ3czZOZqJBrD0RWTXKkC/6Lz+Z614wZc7bDHbnAIkXrVSkBUYrpZz7Xh8Lc1llx3i5ztEV5ETVUIQn/F+A0oFhGLu8kwMJJ5eB7+0Bp78gGbkZ/iJKcu9s6zDTRQCx2QGgLaQm9UVn/FBMWOwYkpC+tt1/Peyw83O+dAh/cmoZlu2tWBIf5Vsnmy3u1Sl0UqYqgupjo5IJwiVz8TK9nyWsSvuQMWN6jAVmpG5iTZZc6pNoAN40oJGyaV7OCSs6uOE/jeGGxZSSbyUGgNg4hp0M45Ml/hvwjl9iNCekJ7I33MQ2RlYEzXw4eWjqP8g+y2uQFQ22y+pWFcOq7FYe/43kakvPVQCcgEZCAMg5rLdosJ5kvMIsL5I2w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 11:55:17.8670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302d410b-077d-401c-3ce7-08df09b2393e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

Hi Huang,

> The IBS Fetch sampling does not report the physical address of the
> fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
> while IBS Op sampling does.
> 
> This patch reports physical address for IBS fetch samples which can be
> used for profiling the running program.

As I understand it, we decided not to pursue this because it changes
the semantics of PERF_SAMPLE_PHYS_ADDR _only_ for the IBS Fetch PMU,
which is confusing. The alternative is to use PERF_SAMPLE_RAW and
extract the physical address from the raw data.

Thanks,
Ravi
