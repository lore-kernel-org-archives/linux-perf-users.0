Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013CDF6C;
	Wed, 18 Sep 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649413; cv=fail; b=gqd6oRwgH/bErfPmzh8+C04ygbxs8NmODwdii/JtGkU3FEoEd6i1larEYkJu/QUkFGIy9iv7UVjwHM2wuiJnf8Pgkudwaiq6/kvPy5KR9bj6SkUnNCdN/5ZEUenio9uOOOKbEvn8aWHgscW2wywGgR9gRWt3VFNj36r6noIXylM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649413; c=relaxed/simple;
	bh=O5wZ2AdMuiT2ZOELt8ckjJF6AbK3a3slUlLckqY8l9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VFn8MzTRncQmlvy6ZABK0mS8LKjrXo1aanI2/0S6nHriGS7JLNhbW5GofQnmYVM6qMSmebIKl66VRVkrTzFoz4Uaz4THqSBtUwQOW0oSecPBDFMdU0YtTj/yRLyAaNCLKi/0ikQFf6eaaLQg2zIuPOv1vnQjrdB3C5kPV3nv7SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KxJaZtIw; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KxJaZtIw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7I3/Tn0R5OE2syAMzNLVX+LY2WFrcyRPAqkdibv2LMxfYAb9VHSieOw+r2X8n3NQSgdDmGyjfw04HTVRRxalRs7AF2YrBR5fnu+9fu+WZ9J3k30wBMQct61rlG4DGWoBW77eRhYSgDDmGvyoEp28Bwwv27e+8dNSyjx1eoTZQS78xpJ41dtFzuGVRosQcNYHZ+KZuI27MZSRP/rnOUpzF6FggcdtI6PWOb+hdRVv+a84pe4o65NRsx1WOw7ixzAdlMybmQh7qQFeflo9LfXOa8AadzxjK0KKV6zpXJL24L6HVMpD4iRfK7hKy/S70yhiFZqcM0ldNaDU3UgnLYC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJSqge9l92sdjvbmZ6ZhO57N8RcOFOifU0R2yGpDeOs=;
 b=QDEWPivDQMAUagG8TGrvNEltGVAk8T9b7JPK0LkBCgsYwYEXxAMa/zseUKf7t7hlXnhmuLYRMBdZzVtih1frpbMSlPrhV/1su65U/t1Ru941r7BkKdYE6jiF5IuT9nLs6slMcLNKwGTGw2u/C315UxgEEK62b2ENDtbSom3JyHkk9RgwQ5ra45TDfJniLq6OQT6D9bumcviyPR/QPNO1OJUD+5o/jKHX7le3GOfF8FqqmhO91FcDbFo16J5NuYf8aF04WzWEjOPX+aYzW8o1o+RkSN/fcumnknqYHZ4zE1mwooYZvXtjhYivS0JXZIkacJN1poFnQV8urHPmg7MP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJSqge9l92sdjvbmZ6ZhO57N8RcOFOifU0R2yGpDeOs=;
 b=KxJaZtIwiZNrbNZRnmPZeODsWfQWUJQg38+fDlh0uADZmGCW4pv7Iz+MWizVhS2CRNeCIvTvxCc957CAk4p5Ntdu4omlKT0lISxKGfzLFiqRCIQJ5q63CWd6ZGhPJZP9w097TbD70sF0MQ9QgANJYIcWELC9AvMJ0jlqiX1iDfk=
Received: from SA9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::14)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 08:50:07 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::b8) by SA9P221CA0009.outlook.office365.com
 (2603:10b6:806:25::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.29 via Frontend
 Transport; Wed, 18 Sep 2024 08:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 08:50:07 +0000
Received: from [10.136.32.87] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 03:46:42 -0500
Message-ID: <b4dbc5f4-a379-4824-9898-95271728ab03@amd.com>
Date: Wed, 18 Sep 2024 14:15:48 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] perf sched: Introduce stats tool
Content-Language: en-GB
To: <20240916164722.1838-1-ravi.bangoria@amd.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>
CC: <irogers@google.com>, <namhyung@kernel.org>, <acme@kernel.org>,
	<peterz@infradead.org>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>, <bristot@redhat.com>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>,
	<mingo@redhat.com>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
 <af4000b6-02c7-4160-8207-57f34239bd49@linux.ibm.com>
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <af4000b6-02c7-4160-8207-57f34239bd49@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 80215586-3b6f-4661-8419-08dcd7bee5b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTlGTkl2YTlpUEN3aURXVGVzcE84S3hOVi9wQmRPampoRURGS3VsOXRPWWl6?=
 =?utf-8?B?OHl4THpxaU1wNTNZdHdwR0xFb3EwN2lzMmx0YW9SVmZ3dXd5YXJ6TFJWYmVR?=
 =?utf-8?B?aGE4U0U3cUc1Z2ZUYWNWS3VLVU5EeDlFTnVJTEswMm5ZdFIvZzFOenpocFhv?=
 =?utf-8?B?QUd1R2wzUG12c2NzVmR6bkRJVmw5KzlNbDJSNFAwYXJGMVliOFpKNG9aSDVQ?=
 =?utf-8?B?Q2lCVTByN0toQkVBQjlpOXRiMHJOR2JmYXVMTHFuV1poRE8rS0pOZmZ0dzdn?=
 =?utf-8?B?eXZlNTNZYjBNbjEzRzl0SUMwN0RFTGxZMU15Sk9LMlA3T1FGMnk1MFNHcWM1?=
 =?utf-8?B?c25sUVhyaWxGd3Mwa0h3a2RlQmNsbE9nYzcvMnc3Y0pOUzBnNiszL2EwYXQ1?=
 =?utf-8?B?UytKMXFIUWNmdGNQbzgveGpBTDhqbmZUYldWNGdndVBWSS9yYWZraHpHOEJ6?=
 =?utf-8?B?QW5KQkx0V3dSSVRlVHJ4OGZwOCtUN2c0S2Y1SzU4TnFMWWN4ZVRUUWFCTnJz?=
 =?utf-8?B?Wld4UC9TRGRxaUNWMlM2VlNRUzg3dGx3NlhralUvcFRpV1BNSzFLUWgvZFN1?=
 =?utf-8?B?NVhFdWFwSDRNbUtMNU50NW92WU1XZzh3WnZKSlpmajlJa3JKSm9nVkRSb3dQ?=
 =?utf-8?B?SWMrMGhveDFhUFM3ZDNkeHV4VUdUUDdRVXRhMXQ4N3pJaW03QkFVVjlwQUJM?=
 =?utf-8?B?SDIvZ3BBSFVwMERtM0ZNV2ZkeU11ZllCWitkVjMyTUVRTXRuODMyTFZKUG1j?=
 =?utf-8?B?SzdYRXZFL3pWdllURDNhbTNLKzF4QmszakFKNmhZKzdpbGZORWRLS2FTR2Z6?=
 =?utf-8?B?ei9zc3NLLy9qd09UTS9uZG1lY1N6TEx6cU4vQ1R0aW9TTTZSOGR1dndKUWQ2?=
 =?utf-8?B?Q1hkKzJBV2JiUTJXUmZDL3g0S09KUGRvZnVKZytudEwrSG5Kbk1ucnNidHlw?=
 =?utf-8?B?d0FNTXpZb0R4V2FZTGFWOFZ6WnZoS0VsVE5QVEtXOXk4YzRkeFNIdkNYbmxw?=
 =?utf-8?B?blNOZHRoVmtPbmpJL3dCVHdFQlNURGdJR282eWk1T2F1ZXhYZXJ0R25XWWRy?=
 =?utf-8?B?Zk42NnU3YTRKMVZqdHZuc3NHaFQzSmhmQ1MyMnhwWWFpRVpMdXRvek8rVklh?=
 =?utf-8?B?MTBmZUZ1aTNtNHRMTW1LVFEreEdObmI0b21Sbmp6ckxFOGJheDZMZW9HN3d2?=
 =?utf-8?B?dlhUZm55bDE1MXJSbHVyS1R5TG5yeDNHTVFQYWxiWVhLaDN6aHlXQXoxV0h5?=
 =?utf-8?B?RXFBUnFDVjZxelFMNUJFZk1Vb2N2R3BXVFVHbWJUZ2IwcCtmQ3F1TUQ1czBJ?=
 =?utf-8?B?M05TVzVWM3EyR1pWaHlSdGlsWWtxL1QxUXJoZlA2eWJiWW5DczNUTVI3c281?=
 =?utf-8?B?blVhZUxRNmEyU0RqRGZvaVhya3I2NkJ3YlJpWjlWMDJHUUlnTDR2UkYzaGdQ?=
 =?utf-8?B?aTZ2UkhkL1N3Znp4S1ZGZERwZHkwR3F6Z0ZCdWFLYVZWcDNwNE1HQ2xqZnNQ?=
 =?utf-8?B?RnlXVFhXTGlSOVBCanZmWjRtL3FYR3ZtdXNMdCtnc3h2bjd5VUwra0VaL2tr?=
 =?utf-8?B?TU16RjJpYXBaUW85S1FIT1gwK2dFMGNGVDV3ZVdJOS9YbjlDQ2dwM0tMWXh5?=
 =?utf-8?B?d3FwV0VPRkhlNFRHOXJweFpjYmdMQi9oUjdVTDRJRjR5RUwvVkVyK3FVeE5r?=
 =?utf-8?B?V2FpYlhOWGYrLzJoRE9KbnREY045b2hxTW11ZDdmUjVrNXVWVTF1NGJ6NmpK?=
 =?utf-8?B?dWNWU3Y3eC9PbkZlMDhZK0poampvbTlCVzZrRWxiLzVSbjdXUmxWdHdGaTI3?=
 =?utf-8?B?YldidkRlUGNSNWdtNEFLWUVFeXpOQXJySllWVDRhUEd3UWFBeXkrRm9UbXNi?=
 =?utf-8?B?VU5pdWRxcXdUcVQwS0tjWVZsT3M0b3hUclpBaHFuSU41R2pRcWxhc2NQWGZt?=
 =?utf-8?Q?LXAn9sXsO9gbSftZvDFX4IgWhwlPn+r/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 08:50:07.6295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80215586-3b6f-4661-8419-08dcd7bee5b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

Hi Vineeth,

Thank you for testing the series.

On 9/17/2024 4:27 PM, Madadi Vineeth Reddy wrote:
> Hi Ravi,
> 
> On 16/09/24 22:17, Ravi Bangoria wrote:
>> MOTIVATION
>> ----------
>>
>> Existing `perf sched` is quite exhaustive and provides lot of insights
>> into scheduler behavior but it quickly becomes impractical to use for
>> long running or scheduler intensive workload. For ex, `perf sched record`
>> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
>> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
>> generates huge 56G perf.data for which perf takes ~137 mins to prepare
>> and write it to disk [1].
>>
>> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
>> and generates samples on a tracepoint hit, `perf sched stats record` takes
>> snapshot of the /proc/schedstat file before and after the workload, i.e.
>> there is almost zero interference on workload run. Also, it takes very
>> minimal time to parse /proc/schedstat, convert it into perf samples and
>> save those samples into perf.data file. Result perf.data file is much
> 
> per.data file is empty after the record.
> 
> Error:
> The perf.data data has no samples!

I am not able to reproduce this error on my system. Can you please share 
`/proc/schedstat` file from your system? What was the base kernel you 
applied this on?

--
Thanks And Regards,
Swapnil
> 
> Thanks and Regards
> Madadi Vineeth Reddy
> 
>> smaller. So, overall `perf sched stats record` is much more light weight
>> compare to `perf sched record`.
>>
>> We, internally at AMD, have been using this (a variant of this, known as
>> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
>> of any scheduler code changes[3][4].
>>
>> Please note that, this is not a replacement of perf sched record/report.
>> The intended users of the new tool are scheduler developers, not regular
>> users.
> 
