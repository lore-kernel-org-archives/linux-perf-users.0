Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5530F95D;
	Thu, 18 Dec 2025 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766051215; cv=fail; b=nmEOUwz9KF3brxgbsQFBRB2/GYV2tw+4hOHvkIWoNxhACUNdQlKFsIrcl6ZtJBHdJKaLLjeVpn8YuamxywJDgVATbG3EftHzDjikqjh7fiXFR5z0E9LIK3+WS0596K4gH1CNvUnlyGBImYX4yqup725FPakVc7ZoHB5OdY8BZKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766051215; c=relaxed/simple;
	bh=eMwPhTxVdJG8vkiYetzuLDsHED8jlBT+C+j76o+5yts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hnDUj7S7hDPeB+wUde5VIEEACoHLcPr+WwU/KVsHdA90oWChhEOcQGGgO1ZJQKkZ2WBPVduNXpHjZ5BFfkhdWZV0Mmj5OpANjMCu4vBN70azMbqJrBDRrEuobdJ/hozZp3zIuZa5vHYYimWItJFoelXzflZ3rS4hg7XPoDNjQVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jW9qQ10F; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jW9qQ10F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY7VlTO6oyHCHxYIPZYrvJj1EVt7LcJPSoPu2hYayam7Diu3AF9nh4RbJ5MoN5w/bMdKMEFW8HZw3hEIuY/Cskkqh9RRziSrkV1/cpQBSx4reHZqFqJGtMFznWMK2Ibhp8/jJk3y9UlbJaYdpzc6cs3JvlKCsYaoSG+n74t2u2TMw9hXD5ize8rg6Zcy2OjdgKZ9bBUYRtQTHEdzSJPf0y7aPdcR0CMp6Z+hXX8Gdw588+/S9Zi1/cilO0A8dn5S9rYLq9Q4j+PZ4LvNoEQ/PaSZ7hfe4V3bjUcgJQQe9LEtXninF8lmiCbwyGU6bwkNzkrM5wmrrMBzl3EB2G4b0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUauLZX7ni7adcCIe2Pg6kBIvvhtUnBEQ6MheukmS/c=;
 b=QbdAlR1AoEcWM0QgeoZhVGBZeTq3aZVAjQDk/0IFtdzY4cNfkdVwI1VpcB1WwurUb8RMUAxgVMduxHoMoAuttsLX21FQC8bdRR2LPD2MmLHE0hbR9yZb4L09ThRJ/q4dJjZq7G1OBCbRrSzm8JyX4/nxBupUElBkVpJkDnkuD7YxS39LZKRVHl3R2Iu8YXLPBH3/9sDjcYRvFt6qkFrpxxchHzNE9u/TmCg5kWMfTCztaiIAidtaV03xaL0Kzl4l6TUoHhyziB1WCPvFM785VPmiAle8gsxtG3XgOf8Fz4s2ypN010fqLXWq+a33aNzan7Ef7gGQrVcDqlAAJH2G/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUauLZX7ni7adcCIe2Pg6kBIvvhtUnBEQ6MheukmS/c=;
 b=jW9qQ10Fup2iwl+POG4tDRkqQIo0JbbG4KGW3QboQL8NcB6cLWCAZ5Idh+8H9cK8k+6qXtZAL14frPh34uP1miGwzqYHwPbGwdb+4EujSrRJifCkEPjEtReUkhM/aSUVhAsHfdzVSF1rHiYb/al7kKCfmAk09MtLszi7nmriEqE=
Received: from MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 09:46:50 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::fd) by MN2PR15CA0038.outlook.office365.com
 (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 09:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 09:46:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 03:46:50 -0600
Received: from [10.252.192.220] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 18 Dec 2025 01:46:42 -0800
Message-ID: <c06e8773-ead7-4f1c-b4ac-9d0b0bba2ac0@amd.com>
Date: Thu, 18 Dec 2025 15:16:40 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] perf sched: Introduce stats tool
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <james.clark@arm.com>,
	<ravi.bangoria@amd.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<sandipan.das@amd.com>, Cristian Prundeanu <cpru@amazon.com>
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
 <cc87d705-0409-4451-b95d-8a9af94f0c1c@amd.com>
 <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
 <3b7c8c6f-e54e-4bec-9e12-ca672671ad87@amd.com> <aULOMekyd9_IiJBt@google.com>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aULOMekyd9_IiJBt@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 96380206-24a6-4be6-64d3-08de3e1a5e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUR2U09wZnNSNDNPL0JVd1UrZGlFV3Q2NFByQ0RJTXMxVitHTjhKUFdXdnA4?=
 =?utf-8?B?N0tXSjJoOStmeTBRVzNEaFdUQWpWRkh3K0FFdlpjQjNZekhnNGhrMWhWdWZI?=
 =?utf-8?B?Uk5EaHlRaTFSWFp4MHhKNjRzTld0QzBmUE9meEhoZUg2V2UxRU9rbXN4TVVZ?=
 =?utf-8?B?OEF4RXhEdWkza2xjZVFiaWtjSk1NK1c5NjFrUmxxcmtxdVpVSkxqcW1zcC9F?=
 =?utf-8?B?QWwrSnZWSHZHZ0ZZS3JHMnh6WlF4aW9YVzQ0WGJ5TmZvSGN6ancwR1hPNTBr?=
 =?utf-8?B?emNYcmxFcE5XQU5EQ1g4ODNtdXA4Wk5WVy84L0RrYURDQkowUnZ6cENQRnlR?=
 =?utf-8?B?T2lnUnlHWjU4cXl4anF3Q1lnWFhrd04vVmhUTDNxaWE3SW5aV1VldXFuMTBx?=
 =?utf-8?B?SHY2V0dCYVpEbW02K2RiZVFOdlpyb3lMVG9pMWRFSFh4WjJtMUtmZC93bkdF?=
 =?utf-8?B?Ni9idEVnWUdLOTdocWUrK3c1RWxITUxrQ1FqMTF2eWdvZU5EWnZ4YjhhZ1I0?=
 =?utf-8?B?bFlINzZMSEg3ekVlYTRWSXY4bGF5YmpkTERWako0eGRxYzBpZHptT3YxNGky?=
 =?utf-8?B?RlZTTzdiaURPRGhya0x5NzFNMVRCekZzRUM5QXlyc2hDdEViTDk5WFRyOEwx?=
 =?utf-8?B?Z24vclkxME82Rk9TSDJsR3dLZ05UY0lSdk9aRG5pWDJFR25DNmQxWnNJVXlz?=
 =?utf-8?B?bDV4RUJQTGZVZE5wWlZhU3VONDJnSXQ3aUN4VmxhdFhHV2J2OExwaW4yNnl0?=
 =?utf-8?B?cnV3a1phUHZnUVhKSzVHNGpITGVjN1FXM2FPMnpBWGpPYnVKcHlYeXlUTnpK?=
 =?utf-8?B?cjJGZlNET3JiUHNFRTJkYXZHbTFPODZBNlowYlErWTJBcldYYjZHYUxXeXQz?=
 =?utf-8?B?dUZVRmVwV1djek1lY3RVZytzSWVLWlFOUzJsaEZIUHFWenZ0TzBJMnQvc2NX?=
 =?utf-8?B?TGc2bGpBQUE2L2dWc0xOOXVaV3BSTXB0SE1lQ1ZyeVM1Y04rRkVQa091M0Uy?=
 =?utf-8?B?ZVFTWUs4OVpXc2pYWmRHS0lQTE1id25DTGQ5OThNZTN5WDlRcWs1TlBGWkpn?=
 =?utf-8?B?eFpQWmJnNXl1R2Y3R0ZkVlBYb0w4Rk5lQk1heTF3T3BjSFlaQWdFU1Zuc3JO?=
 =?utf-8?B?cUVhUDJqczhJZ2N2cDNKOVVSNHdhWkJ3b3NsRVVGTDNuTTlOdjNDSytGai9p?=
 =?utf-8?B?YXB3Z1U3bmF1Zk9IQ3VscE9IenBMbnNJaW03RnhsWEVXbEdWM1QvZWVlYmxU?=
 =?utf-8?B?UVhkeVdXNW9wZ29RVWxIeXVhYTZ0cnkxZ2R3U2sxZ01PMkozWlJ3U0hwYlJR?=
 =?utf-8?B?aWVraHg1VUFxdDNNelNpcGdheHJFL1NUS3c0TDFpaG8rWWNUUVNRb2xhTWlY?=
 =?utf-8?B?blMxR24xdkwvRk1kY00raVNlaklRN2wrZk1lb1BLa0gyWEpHSjVyelF6OUNz?=
 =?utf-8?B?aFMwL25kSW50U05raGRvNmRHQmlqOEFxWlk3cy9QZnZ2Ly95OVdSV2NxRThO?=
 =?utf-8?B?b0x6dTFoMFkwcUFmUXpjNjJQS05jKzZFaFg4amRQcyt1VXhTWThsMUIvWXdy?=
 =?utf-8?B?TlJoRkl5NjBpc09WT3hoM2JZS0JHbnVlOEZuTEY5dnpQY2J0L3I0aEJYZmIv?=
 =?utf-8?B?ZGFCSVNOWmtUNGIvaFE3SUVyakZmNjl5RWpWRVErRkRTRXk2YmpBTGl0b1hO?=
 =?utf-8?B?WENHenBnMjRhT0pScTcwb2d5UjZZZkNJWFhjQXV6emR6THlGdWpGV3VLdWRQ?=
 =?utf-8?B?NXBkbVNiR210UStRM2ZrVFhkTCtOU2c2clR0MGFTK3N3MlhtNVZJYnNiQnhL?=
 =?utf-8?B?NjdWc2NPZEQ0T1B2VG52UnEvRU11VEZoYitsM292cm5zbXVNcDkwMkRuc2hm?=
 =?utf-8?B?QXhYTTUweTkrNDNPbjVWejl2b1V2b0lpd1RBazZESU9YVno3Mmd3d3BxTVZ3?=
 =?utf-8?B?UUh2c2trTThGNnhaUXIvd1c5QmJFUlJFaXpNNTA2SUpJcnQrZUxmUEN4SFox?=
 =?utf-8?B?MDN3N0NCVjBwL0xSQWJJUVhVTmNQYkpRdG1NWG0xTW1NYmZlVDhzMzR5OHZV?=
 =?utf-8?B?QTNGRjFSazUxaTlIaGQ3ckRDTFlITGJMV21GS2dmS0ZSMXI1RVNpclJoeHRC?=
 =?utf-8?Q?II0s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 09:46:50.2732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96380206-24a6-4be6-64d3-08de3e1a5e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

Hi Namhyung,

On 17-12-2025 21:07, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Dec 16, 2025 at 03:39:21PM +0530, Swapnil Sapkal wrote:
>> Hi Ian,
>>
>> On 10-12-2025 02:33, Ian Rogers wrote:
>>> On Wed, Aug 27, 2025 at 9:43 PM Sapkal, Swapnil <swapnil.sapkal@amd.com> wrote:
>>>>
>>>> Hello all,
>>>>
>>>> Missed to add perf folks to the list. Adding them here. Sorry about that.
>>>
>>> Hi Swapnil,
>>>
>>> I was wondering if this patch series was active? The kernel test robot
>>> mentioned an issue.
>>
>> The series is active. I have fix for the kernel test robot issue. I will be
>> posting the next version in a week. I did not see any more review comments
>> on the series hopefully it will be the final version.
> 
> Sorry for the delay.  I'll try to review the series next week. ;-)
> 
No problems.

I will be taking off next week. I will incorporate your review comments 
after coming back and post the new series.

--
Thanks and Regards,
Swapnil

> Thanks,
> Namhyung
> 

