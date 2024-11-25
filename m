Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA67FD;
	Mon, 25 Nov 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732506556; cv=fail; b=m22+aZnbgmyJ424JSBbwEvxekAlFlX3ZNVMb5NjNbJeB5nrBvwLqwnwie9OVPoMAIrA2yajQWlwWGuU18EGOnWpR8qYPfb40z89Rp7os8nr+gzs6lnD9jBLWPOutw7uSDCj2w8lHbpZ1iNfGTIr5EUB0njytwXIBIJBDzwhHvoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732506556; c=relaxed/simple;
	bh=CB9vTufXjeL2HLP/GyIbkyRAx+kZVah92Cg458BY8rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f6czmuQbR8bvldFy4CfyD+RKG7pMv6N2EkcR+jrsNSR+LApzxuHbX97w1dF56XaDd8A5YwyQ32ZPf5fmYifAbTVI2CF0bISECWgtLkyO2Guwv9EJvOZeZFCA9XSNSDCk/BF6UfcfLB+XUpkt+T+5PpNrqLA0TxXwzNMHmAehRfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2htSCWkY; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2htSCWkY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCw2u1rOUsXdZea82+fdUiP2tuPVY80Trj0gBavBB6u3A28pvwM6QnHu6by6Qijp1Rl/XSOTzbSOy7GJddyFdV18ND+jEDBxnIBPHwbuBQjNGNvkxkdtfRzg0Uj7ApQib8jU/HgVuSvvy3RCvD4M5GQVeE+6XaM7nYdklhV7V+C2MDozTHen/K1oyZrJaCi0xPIzOE6KxIqbpgTo+2vZL+ug4LBNRZXyTdapkWZrx/KKErVTIYmGmGi57kUe8K0YRLaBsRnD+Zxick46iR0aTcX6cd9EK56jNfUYSNoo3z/D4fmcC9vX6Ic++jtfgLEXpMSXXOghbD/GC8skY0mHjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muSTnc86zl4XOUwTXzoDD3yX18LOlL+yA7ntXogKrJc=;
 b=vkXufznuKWEP0A6pfUEKUH9kLwNLCbLh5JFPdft8DRC5mYZ1Brb84FC95FGa2UMFM6Ips/hvRNpm6ow9mQ29DrGPNfUYyeEL5P938KiWYuBkNm81SlvAQ5K04p4wt+DbE2o4TdU/6speA86Nvewi8TZxFXvQ8ceQiScm3JjRd464d97cMmZvBxg1KjCw4SBy8Te7ay7aq1/R9r97sQzegZhJ7wrMjQAxdLhhQbs8Jt9NkqlITLBjGDcvjIY4QC+fRVr5aRo4dUhQV1OCAiAM85A+NY08cOr1c6eRizt0OUqNpwIXLt/GNFR8RCedoJ7CkhF+ieh2FLeodJL1pCQCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muSTnc86zl4XOUwTXzoDD3yX18LOlL+yA7ntXogKrJc=;
 b=2htSCWkY41Nbw/OS/g9ujlFFsiQ7NzPgWSv68RGsyUO7AkQKfiv4zu/4GldKZ/GFHSnRvZ05z2Hx5Wf0jHWSoBxxem3Llf9ariPs4e2lAuuHyX/EUexTMNjZTA571hr6qDA54qKi0/PqCMby69GVM+Nonuf/54mQldYJywwlHAE=
Received: from SA1PR03CA0023.namprd03.prod.outlook.com (2603:10b6:806:2d3::28)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 03:49:10 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::2d) by SA1PR03CA0023.outlook.office365.com
 (2603:10b6:806:2d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend
 Transport; Mon, 25 Nov 2024 03:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 03:49:09 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 21:47:56 -0600
Message-ID: <94d6c785-d79d-4055-bdcd-76076eae899a@amd.com>
Date: Mon, 25 Nov 2024 09:17:22 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v2 1/6] sched/stats: Print domain
 name in /proc/schedstat
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
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
 <12995871-3186-4265-b1f5-520252b9757f@amd.com>
 <20241122110853.GQ24774@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20241122110853.GQ24774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 449aa44c-594a-489e-0cbd-08dd0d041e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDJraDFubk1WakN3dkJjQzN2dHFRR2FNNmprS3o2OU0vOE1kcWo0SEQwblJ6?=
 =?utf-8?B?djY0L3JpUUU1R285cStvOEJLaFBxTEtVckxzcUZEVFNmWjBTZE82T25sRVFG?=
 =?utf-8?B?eE1lbmFpeXlKbWhORTh0T2J0Rno4Qkl1V3FyMlY1M0V5WmZ1WDVGeW00SGRo?=
 =?utf-8?B?enJub2lmUGhZeVNuZ2xhWnVjK2V5UWpyQVNNNTF5SVpvcnpHdndNQml0YlJo?=
 =?utf-8?B?bGlyRTRFRldNdXptMVJTS0tsK2lPWGtScG1LL1EwLzlXNmVFY3lWM3B5YjhL?=
 =?utf-8?B?RjB3RExXUDYrMHo4bkJDdFdDak1WNXh1QVZvYThTMTBQRzNYVStGMHROWnlp?=
 =?utf-8?B?K2ZTeDBOTldJYllSNkc1cmc0NDF1emkyWWdhQWVscUw1YWtIR0RFSERZTUwz?=
 =?utf-8?B?czFRZ1NEQjNWUldBT09lQ0tOZ3JkZ2VpaWVuL0l2V1pCUElGL0d5Mkd1SVdh?=
 =?utf-8?B?aXMyQ1ZpdWk4cnVucjNSdXVUTkRDK1pTZGpyRE5HS1pBNEQ1dklDZUJZb0cz?=
 =?utf-8?B?aWdTVnA0Yjd3SDdZZFBsR09LYzh0TTl4ME1mZmlCbDlWQzNzQkVMOG9aUXFG?=
 =?utf-8?B?NmRGL0FyaWpTeGE3M0lINkFocXJnSmJCM05VK3dTTllsdFBrd01uN2sybTNr?=
 =?utf-8?B?TG1JdW0yQzFDczduc1FGZGFxUStLeWlvelFOV2l4QU5jdEliczdUWVdLanlq?=
 =?utf-8?B?QWFveTVabkVuYkV1c0pjVE9iVUxGRjBNdGYvY0c5Z1VxdzJCSGZBOTRyWlpa?=
 =?utf-8?B?QXhXWlB6OG1xdTgzbEdONlpKeWlMR2FWRy9wYmt2T3FwbEJFNVg4cURsdW0v?=
 =?utf-8?B?SU50MVZKbzNxWHJPOWlabGYwV2g1di9peFVFS096SGVtMnpzMU1DTEJzQjc2?=
 =?utf-8?B?bm9FRjRRbEJGeS9Ja3cvZFpsNGxhYjRRSjhlYm5DcW1CWmZDWHBVY0YzWXdF?=
 =?utf-8?B?azBrMndqbjVxN3pyT1pEcW5Fdi9VS3hrdjVIeTNQbWh1dnJFZzN2VXNUNVFN?=
 =?utf-8?B?OUVpVEdra0RybVRhWjdHWUpyYmZEVitNRTh4SG5lTGdackE1aDJwUllSaTNo?=
 =?utf-8?B?OFhVaThVL0g1TEhhMjVjSlFKV2F3VDAxeVdSTUIwRE5ZeW5kTUxSSWVqRGF4?=
 =?utf-8?B?WGhDN3JYRlhwN1F3Ymxha3JXdmx6aGthcmlpRnlUbVhqd0Qwa0d4T1hnbGpN?=
 =?utf-8?B?dzJJVEE5SmtMdm9oYXhpNmkrMGdJanRJTjY4QTN4b0RkV0E4MDlKOGpTUFlo?=
 =?utf-8?B?NGJZcEdNcTVOOGYwNEpaY0YrUGNuTWU0dk8vYXFEWVI1cFFZWE1RY2cyVThq?=
 =?utf-8?B?MTAxL0gzdmYxV3Zpd0JNQk1vUmQ2ZmFpNXlHdnpZUUpPOXkwdVdnTGxRTnl2?=
 =?utf-8?B?WW9oK0RrRjhBeHBGbVBIaHAreENMWEdVUmxMN1ZNamR0aWhCcnAyNktIMUpM?=
 =?utf-8?B?czM5dGdLSGtWeE9OZnB3LzVUR2xyeGE3eVlna05sU2RQOWNiSEp6ZFAzUXV2?=
 =?utf-8?B?SnVsOXd6ZFp4MlVIUE5qY3JxNEg3L0sxRUpDVVRlVU4rWVFuOU9WU2FiTGVn?=
 =?utf-8?B?QWlPNGJxb0tyZDJmdmRhSTRSNVR1QnpnRm5lV3F0SGNVY2tvZVdXSXpFY0Ns?=
 =?utf-8?B?UzltRjAzeVljQlpaWVEzT21NbWVXcFc4SnpqMFlxWGNaQWQwTkw0WGErTHo5?=
 =?utf-8?B?NDZiTFdVQkNtSlRqb09aNkxsNTZRVWZLV2F0RlJBZTl5TnlSNGI3eGtKQ0Vi?=
 =?utf-8?B?QnMxazRzeit4S25PZlZacW9HdzVIODlJSVUvNjlxRHVraHFrT2htMmVRdHlm?=
 =?utf-8?B?KzAxeTQxVXVuNzZEQUZnVitPRHdtRmVER3N0dWoxR011TXpZWnVadlVXUVNU?=
 =?utf-8?B?aFd3bzVxOWtnQlRnc01wUk5nckRINzJzTmt2OUxwNXBqOFdPOWZEWFJ6RnVp?=
 =?utf-8?Q?Viv2rHaw6vjqeCn1mvv18yMu7rb8i1as?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 03:49:09.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 449aa44c-594a-489e-0cbd-08dd0d041e8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

Hi Peter,

On 11/22/2024 4:38 PM, Peter Zijlstra wrote:
> On Fri, Nov 22, 2024 at 02:25:22PM +0530, Sapkal, Swapnil wrote:
>> On 11/22/2024 2:14 PM, Swapnil Sapkal wrote:
>>> From: K Prateek Nayak <kprateek.nayak@amd.com>
>>>
>>> Currently, there does not exist a straightforward way to extract the
>>> names of the sched domains and match them to the per-cpu domain entry in
>>> /proc/schedstat other than looking at the debugfs files which are only
>>> visible after enabling "verbose" debug after commit 34320745dfc9
>>> ("sched/debug: Put sched/domains files under the verbose flag")
>>>
>>> Since tools like `perf sched schedstat` require displaying per-domain
>>> information in user friendly manner, display the names of sched domain,
>>> alongside their level in /proc/schedstat if CONFIG_SCHED_DEBUG is enabled.
>>>
>>> Domain names also makes the /proc/schedstat data unambiguous when some
>>> of the cpus are offline. For example, on a 128 cpus AMD Zen3 machine
>>> where CPU0 and CPU64 are SMT siblings and CPU64 is offline:
>>>
>>> Before:
>>>       cpu0 ...
>>>       domain0 ...
>>>       domain1 ...
>>>       cpu1 ...
>>>       domain0 ...
>>>       domain1 ...
>>>       domain2 ...
>>>
>>> After:
>>>       cpu0 ...
>>>       domain0:MC ...
>>>       domain1:PKG ...
>>>       cpu1 ...
>>>       domain0:SMT ...
>>>       domain1:MC ...
>>>       domain2:PKG ...
>>>
>>> schedstat version has not been updated since this change merely adds
>>> additional information to the domain name field and does not add a new
>>> field altogether.
>>>
>>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>> Tested-by: James Clark <james.clark@linaro.org>
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> Surely you mean either acked-by or reviewed-by ? Otherwise I suggest you
> re-read the documentation on tags.

I took over the series from Ravi but forgot to add my S-o-b. I will make 
sure to include it from next time onward.

--
Thanks and Regards,
Swapnil
