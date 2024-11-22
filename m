Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF91CB32C;
	Fri, 22 Nov 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732265744; cv=fail; b=qmWTuunJiF8nGPmn0Aiib10QKZkGckYnJ6ujnTAq/IAZm9Hah2lBkLhywK23tFKg43ql3fDYza/W9mC+tva1rBU/la3poRPxeQS/WscCwQWEoPDJ5sIUOX+01NFBzzxLXFzfenfJ3d7qCUaojped1F35D2oPc153/MoajJQ/uV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732265744; c=relaxed/simple;
	bh=+1sSXpTImIAwg5fBSsLtg9XMr5+GjnOfxdAN2mu8dF4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=P7+81MG9zn9VA4WPDhgFWLWJqOc0VGJ6ot0cSrYGEQBALCPI5SQ8u142gjFQ2It7CD53EgWG38oPGtN3N/6p4p0L+KaFDvAMall8wsecz90g3HHD6bxhbl9HViopF5RkQukDYVcZuZEwgT/w+uVjaXVAC8Aw3mWdEBS6cyTZd2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LRGwGbmY; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LRGwGbmY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXNNRTu3vQkl1PV7pH8pUALRIEFxH5UF9tori5DtfAZ0qbPNUujC6fBHwhTPN1ZCfmtTY6/Gnn6GqubKVqU5COtSrnurwYpmG3JP4OpGRwpviPii6g2UONIhvrYRjkN2aFVSiD7yVZHWzpUvmdjBrc5CX8wBbh0gf3vcBsB2XMpx7S0LWjSN5DDYCExqiMarLq7j5faZTg278joMGVLci4oDzDL8YdOvknAGT5QUdvFjqXnO3mPQJpkrQfglY5m/bSbBGW986ow8j11pSW9jjThPWodZA83YC30RTdxiCMsumKzkF2E3z0ltBD7C93Vtwb8Bftjq3lWc1hPZo2HjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIUNVQWRdqcj/0h5Ud2eQHGAjn1z3l4AVqBWkBNdvDg=;
 b=KtNvD2ll1GUgL3qNQww1DHyvRwCz4aBliya4uomk2d5WZcQhJ7WZwHGaSxcDM8iEJ3dAfegVcxm4s9a11AiWtCCdhXyU2pBFYsMUulVI36afOkaokKPJf7YoU6vA3op+j62dX/ccuvt8ZzzYPdJlF2qimjfllyn2Lbepk9IdPpkGG5mxbSeKRvFz2ZkHuz+6e89da3Poi9qzxKqWTnvlFTxEIXY3nmpqG0DC/6nTAOyezKK7f2gp8FVMCcvW9KStBPT/vIfQiMY4DmkkgEykQU1jRI3dxuBEb4n/rVqEeve/S1AmXUCqGD8Xag5j6NHRtYcSuIrgLDJRHB275WoWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIUNVQWRdqcj/0h5Ud2eQHGAjn1z3l4AVqBWkBNdvDg=;
 b=LRGwGbmYVffsp5YkdxNIUZqN9Vp5Km/m5NJb2iYIWtoh1OMZ3PdDe6Tz6aVWFw4mwF0TiiS6kB6iEGDqVfZTOvpbkErf63/8zpKu8o3ubDWZxtEqMLR7xiDDaL1eDcZJ4fmijnsGOMRnnrnnagTfL1Qf8lrxmZCZLZ40Z2Uj9YM=
Received: from MN0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:52c::10)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Fri, 22 Nov
 2024 08:55:39 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::44) by MN0PR05CA0004.outlook.office365.com
 (2603:10b6:208:52c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 08:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 08:55:38 +0000
Received: from [10.136.35.206] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 02:55:31 -0600
Message-ID: <12995871-3186-4265-b1f5-520252b9757f@amd.com>
Date: Fri, 22 Nov 2024 14:25:22 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v2 1/6] sched/stats: Print domain
 name in /proc/schedstat
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <ravi.bangoria@amd.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<vineethr@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
 <20241122084452.1064968-2-swapnil.sapkal@amd.com>
Content-Language: en-US
In-Reply-To: <20241122084452.1064968-2-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: b54ab267-f742-44de-bdee-08dd0ad36faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUJ4Rm05M3Y4S3NuNHBxYUNJWWd4K3dYWEZBOUVLMEdnNG5mQzhYMXcrZjdN?=
 =?utf-8?B?TWlZRFk0V3RVT1Qxc1NDZWY3RmIya1p3aktQUHBENUd5cjgzOENxNHFDbUtV?=
 =?utf-8?B?MWZqclE1Zk9wSURNdVhMYitGWG5oVlNXWmlkU085UGxBSFMwNmJJQXIyb1p3?=
 =?utf-8?B?SFc2R0VIZ29tN0JTTFJ1T0JEMU5MK2JISGllN3haeE10TytHbHN5eG1NcGp2?=
 =?utf-8?B?SVZsZXJldHVENHVDNnluNnAvaTlqSXpDU3dPRHJEMmpLVDRkODZpSGxUd2ZF?=
 =?utf-8?B?Q2pUTk1JblZSOWlkUTkwWXpkV0lpTkRGZiszYkc4NWpRaG1MTkhadEtvcDFv?=
 =?utf-8?B?UFpGMGlJZTFHRncrRU5FUThWTVBpcGZ4bGIvRjJaaTVsc3E1V3M2Q1czNXRl?=
 =?utf-8?B?ZFIydjJsTS9rTWIxaEN3TkJIakNrci9rY3J4bXEzeUdhWm9Fb0h4NkhXNHRQ?=
 =?utf-8?B?a2VyZWpXVHZiNHJnYWxVNFBvaXg1YUJ3MzVwdEczMEg5NjNYRVc5OW9pa0NO?=
 =?utf-8?B?RDdhUGJ5VnlwaDd6bGlsU292QTR3a2M4QlIvdlE5WEIrbVRMTjlteFMxR0xL?=
 =?utf-8?B?OS9WTktJTTRsTmZzWXhTalhvMHoyRzlGYVByRjNzdkt2bkRPbmN6UkxzUGJr?=
 =?utf-8?B?QWFZVW0wSGs4NmFMS0NPRENJUFZyWU1nbEdGRTJoTmVGcU84R081WTltWHlv?=
 =?utf-8?B?L3ZUaERQVWZpclpZTWZFVzd1c0ZNZjAzcmhVNGczSGIyaVQrYzRzbkgrdlNn?=
 =?utf-8?B?eHA3RzNGYmZVQ2FNMmhTUGhmZDRMSFJob2V4Q3RJbStoeGd0cEdVS3Zqb0U0?=
 =?utf-8?B?Yk5UT0ErUFlBZnpxM2U2VWJBSGo1cnorYytkaFlhZmlEeVhBeldWUm1SWC9u?=
 =?utf-8?B?UFd4azFMUHhNS0s2ZkEvVCsvMkNJWGdTcHBBQVhQRXJ6UVAzanJWRzZ5dGRO?=
 =?utf-8?B?dkw0bEFjVnZLWVc5TzVEVU5PRDE2V2g5Q2ZtM0tlL3hVNGJlMndKb0FnZGlH?=
 =?utf-8?B?anhHWWZOUzBJRWM4SHA2OGVOSFlmTjZ1VVhLRkl3eWJiOHBYY0dLUUZlNmcx?=
 =?utf-8?B?NDNrWFVBNDZuc2tpaHJKSVEvOGhQYTkyeXU2V3U0STF1Z3pEL2h6bjFSZlRu?=
 =?utf-8?B?Z3RUM0lBZTdFdlU2UEZSVGp3cHF0a1BsS0k5Q0hmRHUzUXVoa0lUMzllOFdW?=
 =?utf-8?B?d0pwMDArTnRhY25wbE5WLzE3dUlRaW5YdE5HY1JMdnRFa21LUjNYa21wcmNE?=
 =?utf-8?B?K29yMUliSC80RnJjQkRZLzIyOFRmcEU2TlphRFZjelZGZSs2a0llYzAyQ2Yz?=
 =?utf-8?B?Wis0L2hqcGg3UENVVGRVT3JkS1dXMUtWK29KYUF5Y3RCYU1SZVFOMnZMdnVR?=
 =?utf-8?B?VDhPR3NwN21RSElnL2ZXQmxBZjZJU1ZURUhxWk92aUdiR1p3MlN1VTdMSmdz?=
 =?utf-8?B?b1U5STBTRUZITS9ZUnR0MHBzS0NNdElKR3BId2l0bjl1T04veWw5RDBmbXhR?=
 =?utf-8?B?RzdJamkrN2J4WWQ0d2NZQ01TZTY2ZHJxbFpEaFhLaGI5MlJzWk8vN2c4aEo5?=
 =?utf-8?B?Wk4vTko1eFV3WGpNclduSytBemFCdUo1aFdqNkVjRWFvK2dyUS9CekEyTTNY?=
 =?utf-8?B?M0phaVpQSmU0NDZ2cWZDazFrckVwd0Y0bVdFUjV3NFlHZlU2QnQ1elJWUEFV?=
 =?utf-8?B?MjZqV0xhN0wzeVpkS3UrYUp0TWI0ajk0SkpZWHZObWp0RWhJaDZBOHJiVy9T?=
 =?utf-8?B?dE0vZFBRL2lpd1BqREFTZXJVUmsrY0RxUVc2NWFhSGlKUEtLTDZ5anJMQjBG?=
 =?utf-8?B?ZlIvYVBBcHBScTFjSVRrdWdtSU5TTTNmaVE2amJVci91QVdxZHdIU0F1ZmpG?=
 =?utf-8?B?Vk5GZnBwRDZpMGk3T0NhYmVuZFhGNE8yM2FWWXFlb0xlSXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 08:55:38.3862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54ab267-f742-44de-bdee-08dd0ad36faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400

On 11/22/2024 2:14 PM, Swapnil Sapkal wrote:
> From: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Currently, there does not exist a straightforward way to extract the
> names of the sched domains and match them to the per-cpu domain entry in
> /proc/schedstat other than looking at the debugfs files which are only
> visible after enabling "verbose" debug after commit 34320745dfc9
> ("sched/debug: Put sched/domains files under the verbose flag")
> 
> Since tools like `perf sched schedstat` require displaying per-domain
> information in user friendly manner, display the names of sched domain,
> alongside their level in /proc/schedstat if CONFIG_SCHED_DEBUG is enabled.
> 
> Domain names also makes the /proc/schedstat data unambiguous when some
> of the cpus are offline. For example, on a 128 cpus AMD Zen3 machine
> where CPU0 and CPU64 are SMT siblings and CPU64 is offline:
> 
> Before:
>      cpu0 ...
>      domain0 ...
>      domain1 ...
>      cpu1 ...
>      domain0 ...
>      domain1 ...
>      domain2 ...
> 
> After:
>      cpu0 ...
>      domain0:MC ...
>      domain1:PKG ...
>      cpu1 ...
>      domain0:SMT ...
>      domain1:MC ...
>      domain2:PKG ...
> 
> schedstat version has not been updated since this change merely adds
> additional information to the domain name field and does not add a new
> field altogether.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Tested-by: James Clark <james.clark@linaro.org>

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
