Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A62DF6C;
	Wed, 18 Sep 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649314; cv=fail; b=Ln18FMBxlcd0t+vuwECacnDlGqCTHFj3mUMtL5mSDKJrwVq/Nmz+I8wiuh2hTASv3cnoRA4wdFaxUZb+6IE2U8uiEG/x00KqDqXp6qGksQvPfs4DPdK+q/jn0fN7N/StDClXh9IhslIhmhCM/U7RUYzRyboy8UeN5pJO3iMw/Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649314; c=relaxed/simple;
	bh=O5wZ2AdMuiT2ZOELt8ckjJF6AbK3a3slUlLckqY8l9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OZUgyL67BLrWI+MfIAj0uW0se+l9Vd89wyD/goVuOQk8GYaQ9dgJMOCN+bju+tgJKqveKYiLWMIxMgWM19YIpiP4R2cFo7i3XZ/dlEEbo7KLz+UXb+Q42kQISJ05oLEX0TxPfPNItHCPq2aKdqfVYhIGkJYZDzS5gTYEz+YFHQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wraddr3Y; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wraddr3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBxpZNjU5A9484rRy4Un46zFJqN/LKwpdr4Iac48VD+/DaB9t5kqoS6m2VUPleDWN9iC0vEbTIO2dSvlTmxMghonbz3IOv53GM/YVUJaakYOCFS/Ub+QjJgYjuFPEgWABXAbQx+HSPJzEWEouyk5/1YLY/OBc6Qsc/jfNa7qROt7F1R/IaTapGhYtTbPwaZY41ZI0bLKUzHL8RDmOovvcatYD4bx8IYyjb6NDOj4y4PBc9K1V2JcIVYt5QLqkP7r4cHjjtD1rxKJ2yUkzeOCk5uGmIZ0upij0M8SRmXzExhv3p0ptBLtjDjT8VQdIIcidEZtrtxJEP8Zr6NwJY891A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJSqge9l92sdjvbmZ6ZhO57N8RcOFOifU0R2yGpDeOs=;
 b=kPF9UvXCr9PODvoMC1/VuYUXb3Oy930pciz39tFGvYYD/cBed2iGeJLdaySd2uX0AGhpdqJqdrwxy4nDF1AdB5vJsUgp4KFHlwSF7pVQ8JicArDBN2ELD4OS/VZj27/KdmYne7Bp+1IaHJhsza1S3zxfv0/qjDfxatiIGuDSITBaw1mpZQ7VeCBSybM8dYVdQxyR+cddvPT55qDUcY49aNLbBro7ytCpOurLIigg+yZfYbZvFWePbBs6n4LegYYP6U47mjyj1w0QCtgSM4x9MQWDtHzheSn8YgLtsWwYjU4xtMXIxaO67X2Kp/rXmd1ZoJn4PDkmjqZEv+d4bDw0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJSqge9l92sdjvbmZ6ZhO57N8RcOFOifU0R2yGpDeOs=;
 b=wraddr3YHvZ7DVp3lIUMBw7An6sRUArgfYyrzOsRt3bPF+WzB8GI5iN0/9GigsSHBBwegL0wN3KIuZrGRYIZNAeTxrcfTfxR0akf6HVxpjGnwU8qVuBf6JCWIn4WVg4C+46HozNBzPxJk9Flnj7GiXRSjBDeCDwkkA0z08jdgzc=
Received: from BY5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:1d0::33)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 08:48:29 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::4d) by BY5PR04CA0023.outlook.office365.com
 (2603:10b6:a03:1d0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 08:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 08:48:28 +0000
Received: from [10.136.32.87] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 03:44:04 -0500
Message-ID: <1c5c2f9a-830e-49c4-949a-6e7bebb05401@amd.com>
Date: Wed, 18 Sep 2024 14:13:07 +0530
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 351ce943-77e4-4838-9c72-08dcd7beaa99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFI5QjJuMTdYVkhPcm9WZ2pYN1E0eE1HYzlwNVZoNUZzcmN3SHlTUkE5eld0?=
 =?utf-8?B?VzhENzNReDBReWltTGlyVldnS1JHNWhjNytaQ1AzTVRNYUpVQ3J6V1kzajNu?=
 =?utf-8?B?SUxsbmp4dlYydzFtdTVPTWF5ZnVSRTVLUnBLSVAzYmEwYWxwTE91SnRVUTdN?=
 =?utf-8?B?U3ZKa0NEanZKWUZnMUJrbzJNdlJ0a3BNSnFRUU9nZHA4VUhiVzcrN3RGUkNt?=
 =?utf-8?B?ZnA0ZkZmQ1NxbDFtUm04eGpFWk4vVmhucVl3bkFtNjhPVEhCU3BSMThqaWNq?=
 =?utf-8?B?WWVockJSY1Q2blpHQ1MxcjYwSnFnVDZlSUxPU25UNStObkNlaElnVTJPa1U5?=
 =?utf-8?B?Tmp3cWl4RTNIT0pXTFhFU0d2Z3M2Y1hXL3k4aHdrTFNtTno1TzQvdzN3QktT?=
 =?utf-8?B?ZWlYWWkrVzRPVEZRVEd0QUdKL002dUJIdkxRbXBKcWQ5QzJMaVVPbEJHMS9S?=
 =?utf-8?B?ZXA5aXJNbWFQV3dxMHhmeUJMMmtDN2t1clRCYkFncldtSUxYTGdLUUE1VTdO?=
 =?utf-8?B?QU1HRGl1enJTRzh6NG9RREdLeDRFQkNxMXhYMU5OTzVHOE5BNGttS3hub1Vl?=
 =?utf-8?B?eWlqclN3LzA0dy9zanRtNWpxREpvTFhaV2tVMndYeitPVlVXYjdxUkdteDV5?=
 =?utf-8?B?T0pmQ3Jra2k1KzdDQWZRQUEvVkdzRWlSbzByTWJUY1lvU3lVbXc2VHJTSDkv?=
 =?utf-8?B?VGZ3dFJGMXVHNzhNMXJETW4yOHltUitGU1V2d2pSTmdEV3c2VG5rRmp0TEFE?=
 =?utf-8?B?bkZjRzNmME1ray9IUGdIMzNCR0lXVWdQYnlJV3dtRERkMFpjV0RpNUZ5ako5?=
 =?utf-8?B?WEpsVG9QVVFoekY3Qit2MzQwUlJIUHNKS2dZYTFjd0FYeC95L3BaMzdQS2F4?=
 =?utf-8?B?KzcxSTdva0dzZDJGbmJucW9YQ0NWY080OW5NUndaOVh6Zm93ZEVyYThObEx4?=
 =?utf-8?B?L1I2UnF1MHdBcWlaUE5WbFVtZ3dPSlBPOUxXc3JBL2JqU2lBei9xQ3RHWnd5?=
 =?utf-8?B?RzBRd25jT0FuM1Z2S1lKajg2M1dNK2Z4U04vT2ovMXZpWGhxZ3F1enhHUEVT?=
 =?utf-8?B?Uzc4WGZNN09ZNlNTbXdGckNUUmMrdzl5bmRqL2xDU1c0dHVWMUpoNUN5blVU?=
 =?utf-8?B?M01aYUhsSStRbVZLcm5RSm5Xdm9tMDBlNTh1cjYvd2JablBoTy9xYkRKZmQ1?=
 =?utf-8?B?NDJDa3M0eW9RNDFmUUM4Rjk2ek85dkgreWJyZzlvbmtVWnA3QTZnRVlTMVN5?=
 =?utf-8?B?UjNVNkpUbWZFUXRRRFFjUmcvbGhyWm9BQm96WlBHSHduNFI5Vmg0elhLek1k?=
 =?utf-8?B?TUEvcHlsK0N1cmJWcWVIQVcrWVVJRG5LS0t1U1Q2U1hjWm55QnZFR3A4RGZh?=
 =?utf-8?B?bGJXcnhHVjluVDR5SmxhMXBkZlZ0RjF2aXZPQW00a21yeTJoandlTjhURDRk?=
 =?utf-8?B?b2FLLy95VERqQXJtODRLWk1wWElZNng3aFVKMmtlYTMrc3l4V014ZTJZTkFD?=
 =?utf-8?B?cml4VHdNOEpxU0lML0ZCK3ZLczBrRVNJcVc0K05UVTFBbVVZMUd6SGQ0ZU95?=
 =?utf-8?B?RTRZNHNHb2hxWTNtWjVSKzY4RVNUTUJvdEVCS2hpMGhsenpHcitBYi9KWnZ4?=
 =?utf-8?B?US85RGFvZytWYVpZaFVvTzV0d1E0VXRCUTUvdnRHNzdUZ1BkMS9yUnJNUysw?=
 =?utf-8?B?d2Y3NkdaakJ0bEpJUTJGSWpSMUlPYmtkaERiYzRwdzBOS1dGZ1dybkRHWGM4?=
 =?utf-8?B?TnVSZzJlMXpGeHBEZENlL3ZFQWI4UTM1bWdKaEtIcGV4OHVwVVIxWENtSFpB?=
 =?utf-8?B?eGo5bW1wR2N6WkNFYmdoWWduYm15SGttN0JuOXhFY29FenZTeHVQQTU0R2xo?=
 =?utf-8?B?UmJjZzdRYXVBdDdwS2M3YUZYUkRMRjJSemJlNWM4WHRESWtNdjF4ZjgwSUZi?=
 =?utf-8?Q?JlivC6S1GCS2tUpf9o0ogKlHvTG08qDJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 08:48:28.4469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 351ce943-77e4-4838-9c72-08dcd7beaa99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

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
