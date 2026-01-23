Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3B173;
	Fri, 23 Jan 2026 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181617; cv=fail; b=usOML3R4m8lkjWa9nN3qDspr9rkhbGIiVPXpadKeXp/NT3A8hHNJnVM4rklKoaXChMp+7TDcHq5zcEcxHDFe6eWhfxKbZ91qLbYB6ZQbD4Qx7nLeB4tHDQb3eHcAvbP6y/JB3qTWZwgtRT3DInRCL4Gi0TvxIe3YUklSdAFa4jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181617; c=relaxed/simple;
	bh=rDKJL8m4iDs9ynlHtmLrzWOq8siYWrwWcyE3uVtneZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IrhhqMEzIOm8XQ9xKJJWka4tYU1YxmjYFWMNPY3JG0cJcaBuM9oy3zvJgdj/sy9M3qdCd3TS9CrQ+K/4HpFNUzx3R3Y8SiPXdnWGxCsen++yM9S53l45UgfWNlhg7FL7ZoRs/7hV0dZhvhx6BVMtwNgFKbSYeXTfk1RSCv4PajU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=skMhMchP; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="skMhMchP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMGNjjJ56CghQwiuQsru14X3LDQpJJqqyor/Vu6NLUx7pe6mmCgVgrmFO/MW/hlf9sZC9UvjECbiMu1DeWGGpI/Sm5M3zF9HMMFrwSh4W4byQSPuwlqGkMWLOx7ZE2qepDlekght8j9DnDjiYPaOjEOkkd0YXSU7O4uHB5CmwZjzLByhh/AUAMeTP5N4G/QAh5z2foVggrmeEHQHzxsebtsAgAakAtRLR3FJP6/IeLt4nq1mF1yt+4/6LS9tHByhY4BQuYEvdTT2jKXSFiWIQY/GqRLT5DskkPoGwleKUwYL8OWEFaWhcUBRBs25+sL2/n48m2zMNmOCJoRI9OQaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSEQ1qNFLXFEm+boLs498Tf0Oyek0nUEzCZEOC+fb8A=;
 b=Pg1Cvew8e02ZqSWgftU9LzM6jJaE7nIsxERrfFCpkA4g1kb4LkTTp0/XN3Pvk7njTdf3WxSXZf4BnUdxx7WKYmpzYhvqZudB6ySuwypLuHbf2a/TpJZglosKIWJ9J0y38xGlm6TebP1swybxT44Ip8jL7Cru2oUS60f+KwhnTxnp8hEO5EgR+Bw2mrI/QXIEPboOUjjslA+JGZt1R4mrPzL0x6nUm+Xl2BXrOI807Y6J7EsZc47Y6ZoJOXG6UgEP35LAryry1ux9QYO10jX+f+RkK6IqGOFdvega2GLCPSuaWT+P46mEwVzH9NDn5ga3Pf0Pc89KbULEBcKK4iP6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSEQ1qNFLXFEm+boLs498Tf0Oyek0nUEzCZEOC+fb8A=;
 b=skMhMchPOEktvMUhymNRZeVX3lEnaPCm73xpLqng27tPVN0hjaewCIz7ZRwiJpv2wMnWEDmIYGM7kZKLosKFSxxV2KMyrhwm7RwAMG0bkwlqN7ILrefQ5F77S3bYgIfJRtHCzyShK/QiSYH9goSqV/0Xr6ITa9kWWHlD0jEGYMk=
Received: from DS7PR03CA0271.namprd03.prod.outlook.com (2603:10b6:5:3ad::6) by
 LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:19:53 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::16) by DS7PR03CA0271.outlook.office365.com
 (2603:10b6:5:3ad::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Fri,
 23 Jan 2026 15:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 15:19:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 09:19:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 07:19:51 -0800
Received: from [10.252.222.65] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 09:19:42 -0600
Message-ID: <16b0e37d-978b-4991-a16d-425f00e50029@amd.com>
Date: Fri, 23 Jan 2026 20:49:40 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] perf header: Support CPU DOMAIN relation info
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: <ravi.bangoria@amd.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<ctshao@google.com>, <quic_zhonhan@quicinc.com>, <thomas.falcon@intel.com>,
	<blakejones@google.com>, <ashelat@redhat.com>, <leo.yan@arm.com>,
	<dvyukov@google.com>, <ak@linux.intel.com>, <yujie.liu@intel.com>,
	<graham.woodward@arm.com>, <ben.gainey@arm.com>, <vineethr@linux.ibm.com>,
	<tim.c.chen@linux.intel.com>, <linux@treblig.org>, <santosh.shukla@amd.com>,
	<sandipan.das@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-3-swapnil.sapkal@amd.com>
 <ae0de6b0-82d8-4016-8011-0439ae2851e2@linux.ibm.com>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <ae0de6b0-82d8-4016-8011-0439ae2851e2@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: afbbb68b-09a3-4b31-90a1-08de5a92dbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2JtaE1nQkJQbWpYYWg3RCs5c3JLWFdwcFRLL2VOVEhTaVkwOXdCOGtITFE5?=
 =?utf-8?B?YXRRZDRLWmJxY3YvZDY1NGIySkE5WEFCbmVxUjJxcnp1bEFqdlRKWmltdDZV?=
 =?utf-8?B?di9WUFdkNXBmdCsxaFJBNndSc1k5WTdYTHNUNzk0QUFFV2NSMXF6OUs5dzJH?=
 =?utf-8?B?eEFCM1B3ZFd3dWJ5V1ZIaDZ4VndsV2N4Yk5OK3FNbGwrc3JoUHAzZXlPQnhw?=
 =?utf-8?B?dzBjc3cyRFY4dDNtcHg5cG43MGxBbzlLOVVuYVd6aW42T3RHUmMzNEhsOE1I?=
 =?utf-8?B?dytoTUlOajhxajFjbFZ0UHQxQzd0VU5wVDVlV1FZYWVpSDZWcWNBVGpsNERU?=
 =?utf-8?B?WENSYVNxQkw4ZGxDcHc0SVRNL21IdXY1RzBoSFdsNVAyVVUxMWRKQ1BZeWlP?=
 =?utf-8?B?dlJoRSszb01Xdmhxb25GdFptUkV4TUQ5dXlmcFFabHExb0dCOVpoUVdScnBQ?=
 =?utf-8?B?cldlVEhrakp5TDZkYmlrYm1PRVVYemh2eDUxZTBmOWlFaXpTdWZuSlRRT24w?=
 =?utf-8?B?N1VScnE5TkNsb2pnZExMNWxDSXdsRmIvTFc5eEpXUTY5SGNQRnlOL1VKdWdv?=
 =?utf-8?B?a2hvdkhXSEY3Z3MxNEFPUk1rdjlxdVVGV1ZoM0kxdzNkNHp3SU9tMHNkMTRK?=
 =?utf-8?B?VGJ1ODRzeXErYmZ0VXg0M1hKS3dHVnR3d2tyZWx2RzVselhZYU1jUVovYzh6?=
 =?utf-8?B?VHNMTFduaGJEN1pNc2dSZ0pFNytqQnBrSWprSHowVkRjR1hEbE9lUkxDa3JD?=
 =?utf-8?B?Yno4ZkZ4dkVBcC96ZnFhYXVMUlg1MjVBMUhaRjBCV0RzRHdZRmhUYWU4SEVN?=
 =?utf-8?B?V0RIMy9XZnZSaTdRaGV0MEhCbTVhVVlXeXYyRU1peTJobC92SUVveXBickN0?=
 =?utf-8?B?aGsyQlFHdGtldHltZE8rOXlId2lONkpFMXN4SmRJRitjcm8vY3JlVHpHM2J0?=
 =?utf-8?B?S1JPcVFTNWl6R2tTZ2I4ZzBlWWlPOGwzdEMxdWxpQWNpdWwvd1JWUzVLOFFn?=
 =?utf-8?B?MVR1T1lwUEVNQ3Z0QnJzNTZyNzR4MTRtbmROTkRKWERPb2FaS3d1WGpXaVl3?=
 =?utf-8?B?NXJiNXZMQlBTQ2xFTXJ6VVdXSDkrSXYwK1lNSWtJTkFSSTcyOHc5bXQzMkFn?=
 =?utf-8?B?bkFBSVV5UkJIZm81UklaTHVjdHVRWEVYVC9YS3RsYWZ6eDByeityOEExWXAy?=
 =?utf-8?B?ODRpdk5teVNuaG5RRWgxS0xKVmkxQ2hCOHA2aVh5aDhxeEhJeE5GWlhYNjNG?=
 =?utf-8?B?RjI0YTdITXIzOE1qa2pKdENXbm5xcTl3SUJHaWIzNUxVYmdIYUxzblNUQk9i?=
 =?utf-8?B?bWtyN1VWc3VjUWhrcFo5VFBZZnRKcWcyQ3NXOUU3VitOTDAzdGU0VEE3NDM3?=
 =?utf-8?B?T3BOYmZiaVpMU29iUStNd0JxU0RsN2tlRjFTZ2VrdS9IMXFUWmRWZ1lwSjRF?=
 =?utf-8?B?RmlScVA1QUNJUGtWUkVSK0laOEhqenFXUXNIa01iU0RsMkY2TWxhUU5LNW5j?=
 =?utf-8?B?TlNNRjhPT0NVTmM0clBod0lQT3JDaW1mWi9wd0hpamxZaDg1TS9jbVgwa3Vi?=
 =?utf-8?B?d09UTXQyRkNScnBtamNGbC92MC92anlCWGdFcS9OdnVoWjUrcG4xbCtDL3pN?=
 =?utf-8?B?WWtFU29yWm1hWHMyS2tmeDZzeUxIdENkRGlrQVA0TXpsTEZoZWM1elI5OFJP?=
 =?utf-8?B?QUdnTkRZdGk5SDlrVWk5eTNpeGNJME56dEZjMTkxKzBOOUdzYnl3bDdoQStv?=
 =?utf-8?B?eFdXNFpGSmJwdisyeFJqU1RMQmtiaWxlc25XbDNsV09hUVlnanNFdlJMNThl?=
 =?utf-8?B?MjU3Y3pkOWphcUdTYWdLZlVhN2N5WXRJaHhTcUFSWEtSLy9hOEVCSXpmUkE5?=
 =?utf-8?B?TTNkQVA5Z3Qvbm9YaVFaaytEbTAxVHNuOGZ0SDFZM0JWeG00Zk5GYnJzMnZZ?=
 =?utf-8?B?eExUMUhBQk1oMXFxaUVxa05ZdVZleGRCZnVqbko0azVnN25pMW01WmFiYzJX?=
 =?utf-8?B?aDRwaHZpalRCQmU2UWN0UXJFUkZCeXZ1RENkN2YxSEMrVldZem9UWk8wQVJD?=
 =?utf-8?B?dlkyVEttUk5JdXFRalkzSTh0YlBvaXFydGNxdWJ0d2VMSVF2RjVxSXluRnJS?=
 =?utf-8?B?TlFKRC84enQxa1lWeHNaUUlzUk8zdHRvK3lTWEN6VVA5enhLZFdDeVVzVlpE?=
 =?utf-8?B?ZnZQS2tCR05GaW95cFpvY0RMcFZWYW9kcVB0cldKOTZpQXZMNjBiVm1lNjls?=
 =?utf-8?B?M0RPNW5hbXIrOXRBVWsyYmV0dmZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:19:53.1917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbbb68b-09a3-4b31-90a1-08de5a92dbdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

Hi Shrikanth,

Thanks for the review.

On 21-01-2026 22:48, Shrikanth Hegde wrote:
> Hi Swapnil.
> 
> 

[...]

>>   }
>> +static struct cpu_domain_map **build_cpu_domain_map(u32 
>> *schedstat_version, u32 *max_sched_domains,
>> +                            u32 nr)
>> +{
>> +    struct domain_info *domain_info;
>> +    struct cpu_domain_map **cd_map;
>> +    char dname[16], cpumask[256];
> 
> You should likely make cpumask and cpulist as NR_CPUS to be
> safe.
> 
> 256 will work till 1024 CPUs no? These days there are systems with
> more CPUs than that.
> 
> Making it NR_CPUS will likely cover all crazy cases/configurations.
> 

This was a miss at my end. This should be NR_CPUS.

--
Thanks and Regards,
Swapnil


