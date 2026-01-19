Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FF363C6A;
	Mon, 19 Jan 2026 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827779; cv=fail; b=OjM7mD1UIe6u/+2GeB/YvMkQ80czwFHuLADkuo0Eh6tDqyTCHzqfpv/EYCg7JLXPG8GHM2rTA6mUW6+8yZH9DLdsGU+6Ff3AAqzz6oea95vdXUHe5NY8rx0aU9kUfwnuqy5gEu6qqnF2+lJQ0rfaSds9HcNIUhPUns65+xMTG9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827779; c=relaxed/simple;
	bh=XHxy9RYew0FQ/gljE5KkAnMscR5mWdx+/ebROSkxqYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n9kbeZJmoOsgduZqJ6+OLr00wGzSeaUtJlXlrODnPEeiMtPU4RyPxOIbSrh7A9WXZHVst81/jOoU/TbTNkl8++DueMlhLYZAISSvt68HGmwy/0EAAhjxcpdOh76h8B1pOPkBw1tX5Z3nGCKGUqntginXRQpsFENpuqfvRrTFMUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tQD9Ur1t; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tQD9Ur1t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyOLWIiVbGzSrjZZSzC1SucrIZNhEkiWTNFfXk0z3fiBEMnmo08OgnU7qUVYBkSa2STUCvh809eSt1ApK+8Ip1cB5vDIQWVcsYLWAFKWDkP3e0dXRlvTV3V8tCRhy6QwgAjYUt1JyQ4PZvti2KE1lE846v18PL7kexNfleA/InF1h8fRGdxio6m4dvuPeq2n5yYi3+dgLQUPZXFh2MBBD/Pi5IIJQnHHA+gegVGZY6QEJxCBgVH4p+2qWyGfrkstUknVpoz2+qd3Fws83CUciAw+qUnBkF7bAwIzwie7Mz054VbwjI4Tz2x93a/cR6rdHJuUWl1al4THdG79ZUEeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/YJ+ebzUuI1K1SioQs1o/z+fu7+wthv7BuIAolVbDM=;
 b=UWyvNrqzaNxdB2dU0HBt9mHK3+Ctlg/GgsvNthbF7/cuufQnQLME8k3UbF0nD31E4m3dOlchDqK8zqLjlpo6eCRG1k/sN6eTPWWGyjMXFzBFvT02MhrvecQztx/qa5nmE2ZeNE8KicJZfGUKtA+MrZujEkelrhr9lwzHIOK3FSVq4E8XMXX1EYWQQnWL+M2sDpveGLR+j7sDeSc1QYN308Zf/r8Hlw5T2k/bDrpeSSp0ui/PJcU8P+h9HHE43uwHReE+ksDOa9fNWOeYg2MVIQ+bF0fSYqGIUsxi7kpu1NZHGy6Ccr73VxhbZDbumat18wf+vWwfUTH+5jUQoTNBmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/YJ+ebzUuI1K1SioQs1o/z+fu7+wthv7BuIAolVbDM=;
 b=tQD9Ur1tWYVKEEo0S33Z0ZrwC8IUXmJ5it8nyUrpRkkeilcxnBN3drvoGU8yPRxNt02t91XExUtuq16ysafY2BwN1m71W1cSDeV5/IYuBY5owWYR9n0fRC3ynDgAQJQl5oBG4f7Y84P3jVAWgWq5emQHA6pb64wxhjDU0W7SngM=
Received: from SA0PR11CA0159.namprd11.prod.outlook.com (2603:10b6:806:1bb::14)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 13:02:53 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::f3) by SA0PR11CA0159.outlook.office365.com
 (2603:10b6:806:1bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 13:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 13:02:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 19 Jan
 2026 07:02:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Jan
 2026 07:02:52 -0600
Received: from [172.31.177.127] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 07:02:47 -0600
Message-ID: <41ebf668-36d0-4084-8697-cb856be1de02@amd.com>
Date: Mon, 19 Jan 2026 18:32:41 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] perf/amd/ibs: Enable streaming store filter
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-11-ravi.bangoria@amd.com>
 <ebc19c7f-191e-4e94-bc58-6f431ad5fff6@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ebc19c7f-191e-4e94-bc58-6f431ad5fff6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: ravi.bangoria@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: f0702aaa-19ca-48ef-e434-08de575b0e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N21EUEtLWHQ3MTkxRzl2MVR5YVV5Q0UvR3UzSkhMdDQzOWlxSVU2Q1U5RGFr?=
 =?utf-8?B?bGlqMzhueGFDRm5jNWJZdTRxTXZJL1NDaEszM0pVMlR1MjdzZWpFOVRWSXUw?=
 =?utf-8?B?NnIxOG1HMGZ2cko2RHE2WVhZdWQ5YUdXUmMwOGNnY1dvdWZQTXBFTzdTVnBw?=
 =?utf-8?B?UnB0NjJNengyZFpDTVRoRm1hampsZGlaZm5xNXUxbFYvdk8xN2tWZDRhTjhq?=
 =?utf-8?B?aTM0SDFwOC9pTXA4bDlaa0lReE9pU1Q4V0RDT3B1UWNCS1ZxL3BocWFqSEZZ?=
 =?utf-8?B?ZzExTWJsNTFJSmxhOGFFVkozdzZ2QXgxZ0k4Nmpvd0pOYTMxMUk0V1hBekky?=
 =?utf-8?B?MC9uZ2h4UkkzSnRHUDhRem5jK0p2RXdiOXRzYjNBNjNBSDk5TExSajViS2VP?=
 =?utf-8?B?MU92TkZwWkJPYjV0QmpDc3NaaVg4anpEL291RXowVzRhNjJscXU0MkFSM21N?=
 =?utf-8?B?SXk1MXE0bHBlRnFVNSt0ZHZWZ0c5MklLbVFGVWpHYVk5UWhnOEVFSUc2OHFZ?=
 =?utf-8?B?Z0FuS1hYcHA2cVRpckN6Y2k2RGFpS3g1Q0JoNDd6b2xDRStJR20rVDZ1V2ll?=
 =?utf-8?B?eW5Wb3ltaUxwdWZJUnM2ZVd2bXI1T1lxR0Y1WWQrUVI2RVMvazl6TW1adHlJ?=
 =?utf-8?B?Y2lBbWwxK2cvT2Znd09GMEUzWDBRS0JCOGUxWWhBamRScVVjOVB5d0NBNG42?=
 =?utf-8?B?RUdUWHhZQ1ZwenEzS3ZBZWVZVitBZURnN0VQb09rNmp2QkM5cVkwekNsdlNG?=
 =?utf-8?B?Mm5WNGZvdURUcEhlVXNLbytFYWVQNGtHRCtwSGxPRkNiSmd4Ym1kaGdyUHhx?=
 =?utf-8?B?QXpSRXFwaWZoNThSTHJLeDNqclVudVYrVm15SElFVVFTNW9kazJybnpzTHZZ?=
 =?utf-8?B?Rm81UGxXSi9neEw4MXpwZUkyUkxkLzJteWY3bzVDQ1kyTFFVejBRTmdZaXpT?=
 =?utf-8?B?TEx2dUdETGQ4L2lnalRZNUtyRWp6Yk5WM2NyNGt2NUpmNXZiUk1uajhTZU9O?=
 =?utf-8?B?RlE1NTV6VmJ4RnNjUjdEYjVvandlcFRvZmphTVNtMVJicHg2d3U2U0crWGFt?=
 =?utf-8?B?OFhscDJzTU1JRmVPMzFpUU85dGVkODBzdGNxQU14RGhEelJvWmRDSFkrWXF3?=
 =?utf-8?B?YWc3Z3JsR3lKdUNEMWlQOUdVYTNPSGlZSHZLTVF6U1kwdDM5MTlWcVgvTHJi?=
 =?utf-8?B?RmJVeWM1UWw2eW4wRktXUkQ4Ym9rVGFaWi9zRTg1cWMwLzd2ZW9WZXlzNEhn?=
 =?utf-8?B?RTEyZWVVUFAyQWdGVHpicGtZREN5TWRDa1YvdjhHOVZHQjlQVktSY01LWlpW?=
 =?utf-8?B?WGRGbHVEcFM0ZDY5NFVzVWJrU0xZanEzTmxySWZydzNTYm51cFdIMVBvYy96?=
 =?utf-8?B?ZkZvSTVsekNkVXovdyt3aEl4VWI1TFlwOTBVemJSTlZESW9TR1ZBWU55TEJp?=
 =?utf-8?B?NXBmRHRlZVlrUUdNMVRZMUdBUnduZG14Ym8zZmlWSXBCY0ttSnN1NjhkRU5v?=
 =?utf-8?B?OTRpTG8xSnI3TXhiV0pKcGx0ZTA4YThrbDU1MjkyN09OSlVxQ0xVYVRMSjRR?=
 =?utf-8?B?MFZWMFhZMU1VNC9FVEhObEtpYmVITytVWkg2TTU1U0RHRXFkTXhUdGJ4YVRJ?=
 =?utf-8?B?MkdvV0kwWncvcFNnbGNEN0JsN3NyWjNndTRDbExjUTh4blRHbkUrNG9yRHNV?=
 =?utf-8?B?UjlGaUdhOHdWa2lFdjZ4d2lJd1FKTXJjWW03MFZZWFJ1Z01tcW90YTZsZGVp?=
 =?utf-8?B?SjIrL0lmdDBDZ2lQMTh4SGN3dC8xMjZkYnllZGN1amM2b0RmaGlKQzFLU2lK?=
 =?utf-8?B?MWd5bG1BOFNpM3d3ZzIxSncralVzZzdiM1lBOXorVGprRmRCWFdqaG5aZlNN?=
 =?utf-8?B?aTlnL1VBUjRtUzEzakgyR1RtRW5TQSt1bmpweitTczBHZE04cCtubjNXYkJW?=
 =?utf-8?B?K0FUc1FkdFhkU3RXNWRQRnZ6NkxJWXYwU2FieVkzKzN6elhXdFhiZStuYWIy?=
 =?utf-8?B?VjJkVUwxRXlvNktQb2RqRjl4b1F6Y0N2QzVoQlpjQnRrWHdrZFJHWFZqUFF0?=
 =?utf-8?B?a2p4Q1EzSzNoT3lZK0F1dGt2cWwzR2tNdGNoS2drNEpDM1VObk1RNm04QVJz?=
 =?utf-8?B?NUhwZk5BK3pac1E5ZzVSd01saFVibUFzWjFOK2x1Sk9Ua0ppL2FjY0pRZVdY?=
 =?utf-8?B?aGpHc0lHdm1mdG41UnRCbmlEQWNnOVMrYkE5elZrbERQZ01OclZiYi82clBh?=
 =?utf-8?B?S3Ivd1RNNkgwSU9zTm1YTStWQnR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 13:02:53.0163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0702aaa-19ca-48ef-e434-08de575b0e8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

Hi Dapeng,

>> @@ -416,6 +425,15 @@ static int perf_ibs_init(struct perf_event *event)
>>  		hwc->extra_reg.config |= fetchlat << 1;
>>  	}
>>  
>> +	if (perf_ibs_strmst_event(perf_ibs, event)) {
>> +		u64 strmst = event->attr.config1 & IBS_OP_CONFIG1_STRMST_MASK;
>> +
>> +		strmst >>= 12;
> 
> The right shift can be directly merged into previous sentence, and better
> define some macro instead of use these magic numbers.

Ack.

Thanks for the review,
Ravi
