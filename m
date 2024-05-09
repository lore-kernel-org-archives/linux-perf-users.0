Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CECD26D;
	Thu,  9 May 2024 05:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231372; cv=fail; b=BrY5XTHxMg1aN92dRBowk/HJLewA9wLL8KWpaCj24DPS/RwxW+FdIYNHLvOXLaVDvsjSiKObqsTdy43YouMH7q5y+UFzPheJtgxvdevgqf/m4DL6RzrtSe/kRGDoYvnDbwsAaupHUdLQhqivZoQlssrEeRpzMV3l5KIOCYionaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231372; c=relaxed/simple;
	bh=T8j1h4ogcWuzXMJPVswugxq6kaIyoWAHEbVB3SNBloo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJHjJACyZvFvSS4VSRGiLX4AuLdCe7c1WACm53YsuzD1y3T313CGQTuLZkLwYbHC1S7htGIa2ljDEW6FsgGhselWNNepqg0jrkgM1W1coDNYtEaCVQE99ZFoNcP0+kb2sQRzSNZr24O5ZkQYRBvr8FewIFUnQ9ufAzYlsOusEhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V9XLge2Q; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V9XLge2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+8JZWCFXLz7Yf9ST5suWAcB8ggtWYp+XB6DEmTNNg14YSvnW3DPMn4svbjCM2VpXFnJwYChnBMDb3+ps9fi7Aot8gI3oneUiAhKk5UzbybCl42Oknz7JiyY8vGb5uxazUFg2FVLW69AIWyD6SQwxBPfVvYiUxRurG8nx7qwSTjHq68QmqkJbvNGvy/irK5Th9uLUK6N5Cp6hb++6SBedXPwbf6Jz6ADKi9I1uL91psYpj8T2v2xXwL0OqXHUowyBiSgOrpXhmGUjhW5FH4jZTLaKp0XUlmFWk3B/Le6yfYPgqy5U4JBy5Qrec64wgZKARHX8HaA7ci2b2Wvj2KE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITbkJksTk0bth0unUJBppdv5rQlT/Z7mg+vfo22lyso=;
 b=f3Q/KN8JzCwabyfchYGYOcQDf6LkTKmWl7kCl1HeF8fVOOAZJ9o1sL7o6FZ3i0A88dAQRiEQlzr8H3K98xiu/b5ScCw96/4/6YOihKzX7HKJSFQXx+rwFHomCWiWGF6HqvcRXwkfCpNmkl9pVAGfK2JRFWOUq1/gqZIk8uxQ5AZJGz7nmtuyv8Yb6v6FQTSUR8PW1ebBbqIlH83CKWub8xgBy0euZCqdN8Z9dvvl2hFkSp/2UdRsbhY4tXdFDojABaWjfzf6hwNU0Lkq2E8sFF4QlvBnNSnaUT5qKxq8br7ZnEhb0DdDU3YD0yFUf/aqCVVW7BRUy0eE9Ua+D6/qMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITbkJksTk0bth0unUJBppdv5rQlT/Z7mg+vfo22lyso=;
 b=V9XLge2QVTglzabgPMAzYni2J1SGuvpT5L89acWWzIN0PwH/XqWhluTqomts+GYLkaaQzQzfUBQlQU6W5HfpL/O5vHuI5EjAeU2Kaw8I/xiYvn/qnZEsN0LkgawnpW6h9ai0LJmx022UTo0GelUhoGXCCgYHZnqfdmLcsH5hfow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 05:09:26 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 05:09:26 +0000
Message-ID: <91a904c3-fe6c-2e0f-0af9-6c687ce45c4e@amd.com>
Date: Thu, 9 May 2024 10:39:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 0/4] perf sched: Introduce schedstat tool
To: Ian Rogers <irogers@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, swapnil.sapkal@amd.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com,
 james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
 <CAP-5=fX1r2RA1=2Bs4DmMGjrV0VD-kYGMCtt+E530rVihK+MxQ@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fX1r2RA1=2Bs4DmMGjrV0VD-kYGMCtt+E530rVihK+MxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ca70a1-d2dd-4069-bbbd-08dc6fe632de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHFMbjNGUXQxenJGQU9OVEt6YVhzaG5rcTNnbENSYjlQNWVXTGxRWkwwQkZB?=
 =?utf-8?B?em1sdGVocVFIb0p3R2tlZmlYTDQvbWo2YWtkUk9IMC9yQUl0SFF6V1k4cWdK?=
 =?utf-8?B?UnNCVFhvN1kya0xDbTc3YWFzU3lLb3NyeUswTkR2U1lPSGIweGs5TjI4VlRG?=
 =?utf-8?B?bU01dXBsbm5nWnRuN0RjRmtldTMwRVAyZGRNWDNyUlljelNpSk9yeEtUYnlG?=
 =?utf-8?B?bFBVY1pKSXdJZVBHUFJZUUZmMmVwNUdyU1czZEVnY3FiYVVmcnowNWtPRWEr?=
 =?utf-8?B?YmJOaHhWbmhoYnh0eStndnpwMGs1RWU0dU95ZzhrWldrSmt5Sk5vN2pYcDdE?=
 =?utf-8?B?ODgrRmVDRVpYL01PSytHeno3M09VTGxZeG5DdUF6WkVFM3BQd3JLdmh4MkRW?=
 =?utf-8?B?a2ZvVnlWY1hnMmtiVmMyZGp3QVJXWS91VnVZZFJLQS9aNFRQZDh6NzB4TnVT?=
 =?utf-8?B?VmtkR09OSWJrcEhtaTNkVDRxYVlvY3lNOWpzSXllM1pyWkZ4QUdVekpqQ0tQ?=
 =?utf-8?B?c2dmY3NVNG9HQ0VZTDNPcGY1ZU52R3NLQ2w4VjhwUlRhSGJhMmg1aWhIU2M0?=
 =?utf-8?B?VlZpdjNSMCsvRWZxYkRTNXFoZm1wYjRyLzJTa2RCREEwTWpST3lGNlF3WFA5?=
 =?utf-8?B?Ky9vK2Fub3VuU21HcFNRTjgrcEx1SEM2WjdxZVEzRVd0S21mS1J4VUpwMWZ0?=
 =?utf-8?B?eGZQOUNWMGtlbUNoMWRKSWIvYWlNSWtDcFFzcHpsaXZkcTcrVUV1aWNoWG1P?=
 =?utf-8?B?YXdPTmxWc2MwaVJCd0wvVWxYdDQydHROVHNsZjJXSmJSTlg5ZFJZM3l1MHFk?=
 =?utf-8?B?MGlDQXc4Sk5JY25JMFFYMVVaNFl1VG00YnAvOWlTd1dodU04SDAzZFJRaWNa?=
 =?utf-8?B?TndOemhUS2hFUTBxZGdtVjVENHBDcW5mN0Rwa3N6eWdDNit6L28yUUExWnYv?=
 =?utf-8?B?eWR2bzd6ZUl0d0YwdmVabFMrTHkzWTlRbGg3ajdBSkQ4aUxpS1o3djV6WTls?=
 =?utf-8?B?MGxRaGlGN3NPN2ZvT1BPczJ2OG1Eb3kyNnkxQlZQbEY0bVhKNFlQL0g0aGxP?=
 =?utf-8?B?TmpoMTE0R0QrZlF6aHJhcDNzOTQ3UGdVV0FTYUMzR3RJZEFJOW4xRnV4aHZr?=
 =?utf-8?B?a0xqSXFyVHhvMC9YbnJMaXJ4M3RzeEhjeTNtUktSWThQODY1b21EZUxmQ2JN?=
 =?utf-8?B?ekpRYkV5dGNUcXd5WElXb2w4eWl4TDVyTzFudlZzeHZvT28xQWZTeUREYWkr?=
 =?utf-8?B?dkFtd1lsZGdOaUdLczA1UzJFeU1kV2pNbDgxOHpXT2YxUnBSUGVaTU9odUI1?=
 =?utf-8?B?TXcyY2R1S0c2S1pyZ2hsaHZqNWdnTnV5d2o1MUp3TTluT0dCWm1BZlJmcTNR?=
 =?utf-8?B?QUlKTFRJMWtDbWFld29QRVdETWRDTDlPRkRBZUhvMnVZVzRYMHp0TVo2V0dK?=
 =?utf-8?B?UGs3cjAzK3A4dWhpanZHQ1hqWUNKclI2YlBFdFNFNGYrOGlUTmJINHlsbUVD?=
 =?utf-8?B?K0JCUTVPdEpIRndhVDJJOUUvQ0Qwb0phRENwUFJLVlRRUlhvQmRVVHlheEpZ?=
 =?utf-8?B?aUJidk42TzZneWNBS1hVQUs3Mk16bkRyODc4WnZpZHZhTGw3RHNpMVphWUVJ?=
 =?utf-8?Q?3p1Gw82uy9V/EPtQHb6OdZeSLcw3fVPnzP4gkEa80fEA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUlNeE1WVWh3MmQzLzVtZ0E3dzFMNHJYcWxFVWtCc2Z4aFI3VWVPKy9Pczk1?=
 =?utf-8?B?YTIvMVpNY1ZrczVWdmdPV1hCd25WMFpvVE40OHlMZkZ2VlhQK0VKVVphOGc2?=
 =?utf-8?B?dlV3eW5Sdmc1SXRXT3pPOUFZUFE5SnpUMm1kT2RmQ2N6MWRSaFRId3ZsTTZo?=
 =?utf-8?B?WS9WcDIwbGg5YnJEMWRqRjVkNGYxWTN1V1VDOU1vVCszd0E2b1BzZHpxTS8r?=
 =?utf-8?B?MXQyY3B3bTk5UlNnb1YyYzdoOTNtYUJOeThSQjcxZCtxckE5aDNMaHRQQjZL?=
 =?utf-8?B?dFFOakJvYURDQk5rM3ExZmhZSmxoeVplbFhJNE55SVNQNS9LcWNBdUF4SzJ1?=
 =?utf-8?B?a05PbmlMRGJEMlJ4VHN5bEdKcGtRSDhPNlEwQW1wVHEzMUlIQUlucGVETExK?=
 =?utf-8?B?RlBjSWdCOWwvbFpLdElVcHpKUFQreGwzd1g5bnFtWnowczdjOTJGbjdPbnRG?=
 =?utf-8?B?ZnJJZlZkUmZGRGRFdXVKc3E3YnRjYW9VU3R5bzJDc3UrQzhaQXNoVlh1VXpk?=
 =?utf-8?B?WTF6aVFGZVF0d0xSeXlOZTR6L2FNOHZHRVE5ejk4UElFUmZwV1FUK2RTUjIw?=
 =?utf-8?B?NS9odjBsc0lCTDd0VVZrWXJLYkZPSmR5SHpUSWpKYTFtMmwzb2FoMTlETHZ1?=
 =?utf-8?B?akJjdTcyUmhOSzhZaklwVXdrTXlHd0JqaFltU3AyREJodkFROWdJdlhKMDJ3?=
 =?utf-8?B?NmhjNjZlanpPUlhyeWx3RURZZUhxS2E3UlhxbW5iOTMzNmM1U1VtNnBmbnho?=
 =?utf-8?B?MGZIYndFSnBUeFREUmJhWTZ5di91WXMxNU4yMjlCTm13TGtLUHM2SzUrbTMw?=
 =?utf-8?B?SjlxQjNTdS9OemRoK2czb2QwdjA1ejFkbTduaDgvRjQvNjNpOWdQSnZyN2Ew?=
 =?utf-8?B?QnViL05saFI4MnZrY0UvV0owcFE5NjlBRkZCeTRMMkZ2SndJYUtTYnFockdW?=
 =?utf-8?B?RTRydWo5bk56TmZzdGJNZHo3Wkhxei9MZzZqV2gyUHVMcjVlZjEyMFp1R2Vx?=
 =?utf-8?B?a0RKNnpER0p3RW55anUyeFZ5OUQ3UXVsYUhEdkY1a1JHNGQrWTJCTFAzNEpj?=
 =?utf-8?B?Y2x4L0puclZ0WmpRYWphY0laQWpMQzQzUHpTMWN3Y2RNNzZSc2J5eDRaZTJU?=
 =?utf-8?B?VTF6YWlKcmZjRjh2Y2cyTnNld0ZhK3lWSkR5LzVpTXAvTUZXYTFkbUVaaFly?=
 =?utf-8?B?S2YzUUhna3RTc0NsK254MDBDbGVqK1hiSElJb2tSR1RlVmJGSHMvR0xqY1FL?=
 =?utf-8?B?WGtPT3h5ZUdsNGl2amdnMlpIOXBCM0ZHZmsvUUI4ck00bmlBYVFHQ2IzMUN6?=
 =?utf-8?B?aktIT2haRGRlbndGUFFzdHhJSG9QTFVjNW5wWEtTYVQrZk5kMDlvSmhLUzNM?=
 =?utf-8?B?VUlFREp3UnlkTVRhVDRoSGpqaWcxeDMrb2lFQmxnNFZwWUFCYzNnVzF5alhN?=
 =?utf-8?B?Z2I3d3B4a3VyYkFsQXpvMmJ4Nkl2QlVYUFF5bDYrc1VMR04zZHRVOXBOaXE5?=
 =?utf-8?B?V3dnU0grd3V2aVVjNUpwNmdaQVlYZ1pHRGNZQnh5Qlc0ODFHc3k5U1pCRVBt?=
 =?utf-8?B?TGVUQXVxU2g3WSs3Ry96a3piam45UnpCV0NKbDdVZGJEcS9Kc2RxNmhuRkJH?=
 =?utf-8?B?YUIxQ2pqZ3pxZU5hdXpDOFFHd3hMMW4rYko2cEJIRkorRHEzK0xkcnJObE9y?=
 =?utf-8?B?R1pqQnN2cE5LRWU5REJQci8ycjNOR2pTQ3RGZFZ5VG1MOHR6T1QrK0Nib3li?=
 =?utf-8?B?SlpzTnBGSzJhOWNvNzVYK01EYnJBOStRakxhWDBMMjd6V3VUQjZtVkJlckhZ?=
 =?utf-8?B?SHFON1hacVo4RVdKcW5lNlJyUmREVFltVEFKcGFrTm9jSXduUXBuVWE3bEli?=
 =?utf-8?B?aWdQNlE4NEd6dDRYUllITC9US1BFMVhmdGNGWHU5RHZoWTlNMlpVK0tJZ01v?=
 =?utf-8?B?Y0k5WjJGQzhGY3cwQTFmVGdVUjRVRXpRWmwycVVhMkpXK1Z1M3lsTkdSYXUz?=
 =?utf-8?B?bkRLNytsSkgzZGE2cHVPT1p3U2xmbnJVWjNLZ3Z2Tk1WMEF2UUI0d1h5TGdG?=
 =?utf-8?B?cHJML21XNXFlU1lZbDdmZ1k3VnQvOTFUZmFScFJWZUx3UVlmVk1OUnQrL1lC?=
 =?utf-8?Q?lLtZ5XS/V4P4rDIQf7UqmTeD4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ca70a1-d2dd-4069-bbbd-08dc6fe632de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 05:09:26.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E30L8wZvX4w2yX79YgpB5IDbV6GnpJyWPGte3Dxn2s8VlWHuP7PfxlrRIGWZyZzuknGtuX/llyKrX/NR5Aup8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758

>> TODO:
>>  - This RFC series supports v15 layout of /proc/schedstat but v16 layout
>>    is already being pushed upstream. We are planning to include v16 as
>>    well in the next revision.
>>  - Currently schedstat tool provides statistics of only one run but we
>>    are planning to add `perf sched schedstat diff` which can compare
>>    the data of two different runs (possibly good and bad) and highlight
>>    where scheduler decisions are impacting workload performance.
>>  - perf sched schedstat records /proc/schedstat which is a cpu and domain
>>    level scheduler statistic. We are planning to add taskstat tool which
>>    reads task stats from procfs and generate scheduler statistic report
>>    at task granularity. this will probably a standalone tool, something
>>    like `perf sched taskstat record/report`.
>>  - /proc/schedstat shows cpumask in domain line to indicate a group of
>>    cpus that belong to the domain. Since we are not using domain<->cpumask
>>    data anywhere, we are not capturing it as part of perf sample. But we
>>    are planning to include it in the next revision.
>>  - We have tested the patch only on AMD machines, not on other platforms.
> 
> This is great! Is it possible to add some basic shell script testing:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell?h=perf-tools-next
> for the sake of coverage, other platform testing, etc. ?

Sure, I will think about adding some simple tests.

Thanks,
Ravi
