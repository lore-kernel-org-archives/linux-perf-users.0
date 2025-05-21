Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D8148827;
	Wed, 21 May 2025 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747805597; cv=fail; b=PyZ5Wx2wxoM0WpAkDTSPhoAFo412Py1tjH49vpX6Jh3aGoWznIUP8c0cYtFevNe0bMCZnnIlakGH4rdBiIHGLRR0o5kL/2+V+Dsx4vX+Ug8dKuUO32r58e/uWsHYW4+9QJ634bpJDPMfyT6R3bWCe1cTajrAGnVydKqn6G96H8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747805597; c=relaxed/simple;
	bh=wpD2FkwcLxzfSXcHB7NWbRgs6JElw0f2ulK3HaxWeik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HwKFkABDw+ekLzA/sVxf8H6hp/CsU/tn1yq6M0XsurVeynvxqPJygAyTflecOIbYSybKN26Bpg1SpPkeBaPlmhV9ppaSqu6cq+yVAnHNV2muylorQL48vkb2OZ2THe91bliQApX64vpnRs74LCyMHOO9Zf8qqVjyp1VIum3BuYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hvrmmt/H; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hvrmmt/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhJV9Aj30HqduU4+9sDJ5HbyKECbcFHeJCRVy5nRwDvRM+Z5fd5LYXRokzIbcNTV8+7ARfQjzJLFzsP3GG6vCPjWbNBm+6K+X9rLTjAoxNd0Kgg3KcjfpIxaACmNtvRZEox8UFqShr1Yk5+C6ezvlv4GiMnxNiqCNDGsyu2sFZjMnsmSNxLoNknoV/48yneOWEO1aw2D2v3dDdehO3zURw5zy91PHrjp4SRvZZW0qzkV19RzCcqCo5BjEVwtsJnHIdA8IYjUXsIoGS7ZY2LPeeiCj9VesBYZA5csOvM2nCIrJDgen1WdnBH8t9XcPeeDA0bH9o6UOOrxNrlm2F+vJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ihe3vthB/LR8yYHAvboL+oqiSbyast8wYWLgHYLXkSY=;
 b=cefcXtjByKXOC5PYJjzzJWP4+Wb5FNvLcUA0pSfzoiETrrKQA34fqR04uK/e2cSKx+JuTyVGQOaTnQAKwxX5f1MF3ES88dqNsWXZo3HTZ/2JJ7kjywroC+yNwS6H2AXt6EGl+3qYuw7uqbb+Di0riv4+02rmZ6qiTociM3V8ZbfjdS06LvX0nXNlT3EJlm6dvyar3Og7DkeFH579eM9pH94sTsIxjXx7hj/TkUFBjnEl2Gn6PcW/bxOHTlAedQ0ZOoYhbnSMg4L76AGWtlLaXzlmb409Qe0NJIdPAEHSGeP9RGEzN5+VrvUUxHhE+3hqqb6vM0FjV8BcA/rI21idbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ihe3vthB/LR8yYHAvboL+oqiSbyast8wYWLgHYLXkSY=;
 b=hvrmmt/HnYXHDOfNWcMwwHLtqQR5qoS62NjFerUMgNGZFavU6ya23HCxnjn53+kvaHNujqqWkp7PEx+ADcydTzCflVKpwanhIyo9l5tgUcJ1uyMP47MEzZSbQ+Tt4xmhiCPHK44Ku+eJZ8I0QbEUNwsFgHS8rnozQn11sVXLVC4=
Received: from CH2PR07CA0020.namprd07.prod.outlook.com (2603:10b6:610:20::33)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 05:33:10 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::92) by CH2PR07CA0020.outlook.office365.com
 (2603:10b6:610:20::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 05:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 05:33:09 +0000
Received: from [10.252.216.136] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 00:33:02 -0500
Message-ID: <d1bd5519-21b2-4ef6-833e-751a89ff5372@amd.com>
Date: Wed, 21 May 2025 11:02:46 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] perf sched stats: Add support for report
 subcommand
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-5-swapnil.sapkal@amd.com>
 <20250520103647.GH16434@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250520103647.GH16434@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c58f63-cade-4130-a044-08dd9828f8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXlkVTAyNnBNTW1tMlc0L2NrQlZVeWZWNGI4cGVZVW5iLzhSaUZFYm5PRW41?=
 =?utf-8?B?RHcvY0VWbE03eGphVmhmR1Z3czRxUHlZL1Zva2RGUW5JSmZQN0g5RFpsTERo?=
 =?utf-8?B?bVFuSGpjaTdwdnFnb0UyM3cyZWJnanJvK3ViYXN6d25taUd1cnBuUlJBdjla?=
 =?utf-8?B?YjhZNkcrQmgxRzVycE90ZmppTWtkc29mcUdveHNFbm5PUkxBb0hlUEV1cE5H?=
 =?utf-8?B?RGZ2aStwbWNLRm9ZQUhKNWYwc2hTVisxbkI5aXhqWVZxR0pMSXpEYk1jU0lU?=
 =?utf-8?B?RzFIUGhlaWFJUUhYRzhrQjBoN21LM3VuZDNaY0dPMGRSc3QrQnlKSVo5VFRD?=
 =?utf-8?B?WVIwdU9lRFBqZmhKTzdLYzFrOTNIWFlyV2hHUGlTeFFPM1ppVHh5OGhacWFC?=
 =?utf-8?B?Q2Q3MXd0Y0hmV3h3VHlkbm9zS2t3Ry96RmJOcXk5a08ySmNSQ0plT2gwaFpo?=
 =?utf-8?B?OVZteW9FUUdBY1BnNWtQUTlWK1E3MXZvMm53NGx0VkZmazZjOTh4YkF3YXhF?=
 =?utf-8?B?ZUdEbjRRQnZHMmRRS2Z2R1VJVjhJelpUQTJJSEtIcmpYN0tWbDJNM3Zydkhn?=
 =?utf-8?B?RXcwZzgvM3I5UmlCYWZtNC93NUEzRm9CR1EvT1U1bnY3TE5oRDBkMmR0KzhT?=
 =?utf-8?B?V1I2b2FoYXRUSkMxcXhWcGRRUzVwZStnMlFnaDd4R2xVRjZ1cnBZRndPZ1pz?=
 =?utf-8?B?WkZpTVR2Vnc4VUplMklUeFVFZHNwbkZrTFZtM3AyN1o0cVZyRDNCdXVESXNI?=
 =?utf-8?B?U2ozQzlVRHQrdTd2Z3VTdXZaQ09hT3pENWFWT3VZZTNONUNhRjZvclpIYXBy?=
 =?utf-8?B?c2V5U2p6cHpWeGNZb0NKUk8zMHVlQkE5b1JWdXhWeWNlbWF3LzZZL0FTYnl3?=
 =?utf-8?B?Zmk0ZXh3dWdpVWJrcG50SWROSFJqNjBWcnBjaGc0a2JXYXpKenpCQnIyVC83?=
 =?utf-8?B?Ryt4RzZwZ000TnB5bUZlMk5qOVc1M0tvN1lVZkZVV1RIRkNsSFh3ZjNlMDhn?=
 =?utf-8?B?Rkt5MVZJYkR6aEFqa1Z1aktiSE9obzQ4eFVyN0JURVIxUDd2V3lhWnN1YVA3?=
 =?utf-8?B?S2Mzc25RSmxiUUV3ZWY1QmlNWTJoTVBJVjJjTHFXNDZwMG1Wa2pNL2Z5ZG5o?=
 =?utf-8?B?MWxTSEdVVW1CRzNndmRWNm5kVzNsSlgzSksyeWRMbUZkTVRRUmxKNVg0V1M0?=
 =?utf-8?B?dXRmbUZYcDRHZ2MycktYeUg2TTR2K1VvOUZVOXRMWGZOSHIwK01NYTBhd1ln?=
 =?utf-8?B?RUYrYk1uM0NMQzkycGZzcTV4U2NldzdlV1FnblRodEVyN2p1NFFYMXVSK2xn?=
 =?utf-8?B?ak1aME9FZFBUWFZXdzlFRnh0Sm9SWTVpRk8zd0F3RXg2QmpzS1JPVFVlVDRq?=
 =?utf-8?B?Q0U1U2dYd21oMDhVaHJYQlJ4NHJlbFBORnQwVnZyNW5sZXJNWDkyUllZQVAv?=
 =?utf-8?B?cStBbDlGSGZlZXFXNDFHdzhJZ3RSWjdxcVVndFhHUVpNWmllV0QwKzBsZ3Nk?=
 =?utf-8?B?WDFjQUl4Uk00cVlUTWMvTGhXakpaMDB6UEpvT0RhdEdQY0paajM4RXlWWktZ?=
 =?utf-8?B?Ky81SWJEUVBjUzB2YUt5YjE4UDUvM2lzeGJKVnd6STJzc2UwR01QbHU3YUpt?=
 =?utf-8?B?MkZ4Mnk4c0Q0MUFNV2RRR0JuTVFvUTNwendpOUpFQXZjc2ZuVGFqNXM2bnR3?=
 =?utf-8?B?TVpuRHdzTVFlUloxUjM5N2JDS2FlRlVTTXRtU09ZRTdyTkFER1NnZlJnVDNz?=
 =?utf-8?B?T3RGWWlIYVVGSlRQMXczQ012Sy9rdCtCVGt6ZEJTNU5GNVhJdGpyMnBJSnds?=
 =?utf-8?B?VFYrSU9jeGdKYS9yNmRickNsSTd6cFFEZUpVT0k4ZjVrKzNTbWdUUWVMTUIw?=
 =?utf-8?B?WVBjbXBmbUZxMVh1U2h5QU9xSzZmRXlybUpvWldENjFSSTdyb0hTMmtXUGZC?=
 =?utf-8?B?Y1FibERia2o3UGc3OVhLNmxqN0V2bVkxM0MwbktRTmg4c3BnZEp6NTg3VmRr?=
 =?utf-8?B?c0FpZExLcmtkcVFhUjVSbkZiRTBydEVxRjdVdjJhRVU5Z3hyUmFmdE5kMkl3?=
 =?utf-8?Q?DwUlmB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 05:33:09.5410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c58f63-cade-4130-a044-08dd9828f8c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241

Hi Peter,

On 5/20/2025 4:06 PM, Peter Zijlstra wrote:
> On Tue, Mar 11, 2025 at 12:02:26PM +0000, Swapnil Sapkal wrote:
>> `perf sched stats record` captures two sets of samples. For workload
>> profile, first set right before workload starts and second set after
>> workload finishes. For the systemwide profile, first set at the
>> beginning of profile and second set on receiving SIGINT signal.
>>
>> Add `perf sched stats report` subcommand that will read both the set
>> of samples, get the diff and render a final report. Final report prints
>> scheduler stat at cpu granularity as well as sched domain granularity.
>>
>> Example usage:
>>
>>    # perf sched stats record
>>    # perf sched stats report
>>
> 
>> +#ifdef DOMAIN_CATEGORY
>> +DOMAIN_CATEGORY(" <Category idle> ");
>>   #endif
>> +DOMAIN_FIELD(__u32, idle_lb_count,
>> +	     "load_balance() count on cpu idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_balanced,
>> +	     "load_balance() found balanced on cpu idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_failed,
>> +	     "load_balance() move task failed on cpu idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_imbalance,
>> +	     "imbalance sum on cpu idle", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_gained,
>> +	     "pull_task() count on cpu idle", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_hot_gained,
>> +	     "pull_task() when target task was cache-hot on cpu idle", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyq,
>> +	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, idle_lb_nobusyg,
>> +	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v15);
>> +#ifdef DERIVED_CNT_FIELD
>> +DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
>> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v15);
>> +#endif
>> +#ifdef DERIVED_AVG_FIELD
>> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu idle)", "%11.2Lf",
>> +		  idle_lb_count, idle_lb_balanced, idle_lb_failed, idle_lb_gained, v15);
>> +#endif
>> +#ifdef DOMAIN_CATEGORY
>> +DOMAIN_CATEGORY(" <Category busy> ");
>> +#endif
>> +DOMAIN_FIELD(__u32, busy_lb_count,
>> +	     "load_balance() count on cpu busy", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_balanced,
>> +	     "load_balance() found balanced on cpu busy", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_failed,
>> +	     "load_balance() move task failed on cpu busy", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_imbalance,
>> +	     "imbalance sum on cpu busy", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_gained,
>> +	     "pull_task() count on cpu busy", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_hot_gained,
>> +	     "pull_task() when target task was cache-hot on cpu busy", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyq,
>> +	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, busy_lb_nobusyg,
>> +	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v15);
>> +#ifdef DERIVED_CNT_FIELD
>> +DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
>> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v15);
>> +#endif
>> +#ifdef DERIVED_AVG_FIELD
>> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu busy)", "%11.2Lf",
>> +		  busy_lb_count, busy_lb_balanced, busy_lb_failed, busy_lb_gained, v15);
>> +#endif
>> +#ifdef DOMAIN_CATEGORY
>> +DOMAIN_CATEGORY(" <Category newidle> ");
>> +#endif
>> +DOMAIN_FIELD(__u32, newidle_lb_count,
>> +	     "load_balance() count on cpu newly idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_balanced,
>> +	     "load_balance() found balanced on cpu newly idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_failed,
>> +	     "load_balance() move task failed on cpu newly idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_imbalance,
>> +	     "imbalance sum on cpu newly idle", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_gained,
>> +	     "pull_task() count on cpu newly idle", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_hot_gained,
>> +	     "pull_task() when target task was cache-hot on cpu newly idle", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
>> +	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v15);
>> +DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
>> +	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v15);
>> +#ifdef DERIVED_CNT_FIELD
>> +DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
>> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v15);
>> +#endif
>> +#ifdef DERIVED_AVG_FIELD
>> +DERIVED_AVG_FIELD("avg task pulled per successful lb attempt (cpu newly idle)", "%11.2Lf",
>> +		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, newidle_lb_gained, v15);
>> +#endif
>> +#ifdef DOMAIN_CATEGORY
>> +DOMAIN_CATEGORY(" <Category active_load_balance()> ");
>> +#endif
>> +DOMAIN_FIELD(__u32, alb_count,
>> +	     "active_load_balance() count", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, alb_failed,
>> +	     "active_load_balance() move task failed", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, alb_pushed,
>> +	     "active_load_balance() successfully moved a task", "%11u", false, v15);
>> +#ifdef DOMAIN_CATEGORY
>> +DOMAIN_CATEGORY(" <Category sched_balance_exec()> ");
>> +#endif
>> +DOMAIN_FIELD(__u32, sbe_count,
>> +	     "sbe_count is not used", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, sbe_balanced,
>> +	     "sbe_balanced is not used", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, sbe_pushed,
>> +	     "sbe_pushed is not used", "%11u", false, v15);
>> +#ifdef DOMAIN_CATEGORY
>> +DOMAIN_CATEGORY(" <Category sched_balance_fork()> ");
>> +#endif
>> +DOMAIN_FIELD(__u32, sbf_count,
>> +	     "sbf_count is not used", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, sbf_balanced,
>> +	     "sbf_balanced is not used", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, sbf_pushed,
>> +	     "sbf_pushed is not used", "%11u", false, v15);
>> +#ifdef DOMAIN_CATEGORY
>> +DOMAIN_CATEGORY(" <Wakeup Info> ");
>> +#endif
>> +DOMAIN_FIELD(__u32, ttwu_wake_remote,
>> +	     "try_to_wake_up() awoke a task that last ran on a diff cpu", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, ttwu_move_affine,
>> +	     "try_to_wake_up() moved task because cache-cold on own cpu", "%11u", false, v15);
>> +DOMAIN_FIELD(__u32, ttwu_move_balance,
>> +	     "try_to_wake_up() started passive balancing", "%11u", false, v15);
>> +#endif /* DOMAIN_FIELD */
> 
> So I have one request for a future version of this. Could we please add
> a knob to print the output using the field name instead of the fancy
> pants description?
> 

Sure, I will add a knob to print the field name.

> It is *MUCH* easier to grep the field name in the code than to try and
> figure out wth this description is on about :-)
> 
> That is, ttwu_wake_remote is infinitely better than "try_to_wake_up()
> awake a task that last ran on a diff cpu" and so on.
> 

I agree.

> I realize I might be weird, but it should be simple enough to add and it
> makes my life easier :-)

Thank you for the suggestion. It is simple to add it.

--
Thanks and Regards,
Swapnil
