Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7941265281;
	Mon,  6 Oct 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748099; cv=fail; b=Tiw/xcREANsIAjwDvvJb8cVHmfUYkoTPHNUch2crt2lW5TQbOIsHTM9JOtSrCQwdEVvVAmcNNskOgcuSP9zySM0SP7n2acnRClo1KE7uBL08hSJYoXsZQ0PKSiakeQgnhO7Vzn+IQiQVHrVvHMosd5gZ/8gLe7WsA22rUTjXJic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748099; c=relaxed/simple;
	bh=JapsIq6usewSiAzwDSEdPq4iuiLsT1RLRsai4BPbCGk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=c+VUPcW6RD0KXklmHEW3CXrv+8XXoKlKA3VenA48Qr3DTWPqm+K0ZecWBvvrVg6w74aLxXS7OsBRzPv6yNXWpG0JlS3PgtcFWGkqTbfF7UYA8i1vfkrRwhLFNQgSCGi2tzXk9KtBxCgTIB2HmGTr3iIEYSgcFwMHHIZs+C05e/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kh8CV2y9; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kh8CV2y9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M++g1K4BwZ4s4ruWyfJ60ippfQ6J2m6wB4hCxu/R05JkW8oW2I34+CtCL7E/oNBktaE34ziXBNSAAcpIphfO6UqPm3ZPx9NvoKglJdauA0Vr4pF05Dd6yK6Ac9Zsru3HqA5jJiGqlyx3sRPP+2HhNtMUMgiSNAfUJqeSHJpPMa4R1YQByVZ+5R9i6Dqff/lDWbrlfBNXvSijEPveMW34PZ4wMJjvK3ANHAnyUiuryYAR9WztoXB09pd5EG2Lg4MhF0Ep/u4bn2PVgHurse1vYKJk3MxKtwGBswb9RmtRlCehCoe9BfQHJWV3PSBT1o6/1nt4QNIZMiCmxIphmUMAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1nqjpc0kpf/wLPccBEP1Drj2WlkwJQmI2HUYoMN6q4=;
 b=pAeHjLfDnuT81drRK47sxCv2NDZ/TgwdAeGpn8/qaWreGTDBsAHFpJ2ADBStShusOBg6Q0MT9Vsh+HoGAbTZMgG1E9x1kbEXTaDnOttqmKGoV5uHawQIqZ2dOuVGuuev8HN0oA7VgXSeYlVd2pcGT6GkYBwp2icC0iID2OADjwRm8fCB23olRlvYUDcq/fSAoL/NFs/IitN803TN8AEn70hc75AkEzRDClfUXAbPyD84B8IMNbeDTg1tQ7smC+wq+iu0joAHpAWR/VwLn65yT08ENCSoEtc+pRZ3wA7agq2McMcE6r8Bk3t2faiFx1GH1uYR8D0Q7+9K7VVBTTsy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1nqjpc0kpf/wLPccBEP1Drj2WlkwJQmI2HUYoMN6q4=;
 b=Kh8CV2y9eIHt3sRer+/E4Mrtntz7ZrodWs6JR9cQtQvv5vfkW0S3n1DC55CCiIX1tzzevOOfp4bc2FlKYXG3ZhjNShcEnVfkKH7y8V4mE1aoIg4iC/+1pJsVnDEb9BEgNuIQlNRaXKDk2xJ66YMIy1M7pBP/1Py7+jUFIFatSfA=
Received: from BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 6 Oct
 2025 10:54:54 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::30) by BL1PR13CA0258.outlook.office365.com
 (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Mon, 6
 Oct 2025 10:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:54:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:54:53 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:54:53 -0500
Received: from [10.252.82.201] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Oct 2025 03:54:46 -0700
Message-ID: <2f981591-4159-411c-b530-e884262d1a80@amd.com>
Date: Mon, 6 Oct 2025 16:24:45 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v5] perf tools c2c: Add annotation support to perf c2c
 report
To: Tianyou Li <tianyou.li@intel.com>
CC: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <aNo-U0KquRbcJam9@google.com>
 <20250930123900.1445017-1-tianyou.li@intel.com> <aN9ZiPYyYtr332h_@google.com>
Content-Language: en-US
In-Reply-To: <aN9ZiPYyYtr332h_@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: daf8288e-a1f3-4d20-d757-08de04c6c826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVJrMVNqa3J5ai9ucVF6TkhaOVF1Y01peGU2a01NRXBncVRMSUxQNnBGWG03?=
 =?utf-8?B?RWUvK0FKU2E3MHdsQ0dQZ3R4VEdGNDhiQVV5M3hCd0dDZkZaMGY2YVVPbEM5?=
 =?utf-8?B?ZnlxVzZveDU4bkh1Q3lzRmpOc3ZhcHo1cXFBbUxXRmRsOEN5YjN5S1ozRGla?=
 =?utf-8?B?TkJ3ZkwvYlFmQXdtSGpISjJnaTFSNWtwenRmODd5ZlBlM0JVNjJneGdKWUp5?=
 =?utf-8?B?Z2k3bWhnQzVaV0JZRDdRVy96VFlxQ0t4NWJydHZLSnVVMGVHOWwrZ1Z3MlVz?=
 =?utf-8?B?d2RMZmVxeEJrQis2UHhSUHFONzFlZVVjckQrSjhVbzBTWkJEZGJVd1Awa0h6?=
 =?utf-8?B?UTFLTDhmWFlZL1JQNzEyeTh4Y1lTdHBXZEhBa3hwZERoK1I0SG0zWERMM2FV?=
 =?utf-8?B?eUtoWmxUcm9HeWpxN3I0M21aQ2JrS0t6MXA2bDA0VFJnQzhqR3VST3NwaEUy?=
 =?utf-8?B?U2ZITEdJVW4rR3RYaFlEQnRVM0hUSUU1UFpVdFRoVDJMSHY5NFNkdG4vRWph?=
 =?utf-8?B?MWJkYmV1SUludGRWM2NxSlVxb2ZRRVJseENYenlyc0ErdnphRjhhRmRsejgr?=
 =?utf-8?B?S2JvbUdtVWVlaUgxMzF2TDNMOEpwK0RtblNFVGYyNEVKbDdUSzNqRGp0SFZw?=
 =?utf-8?B?OGdKZklrSkZGVHVaQkNBdEIwaUYxQmJhNGJ5VVFUYjVsb0Q0Q3ZkNnNjMVFT?=
 =?utf-8?B?b2l1WnJWVTl5WmlhTEcreDNlTFU1dzY1WUl6MUFIaS9GWkVVTjVJWFVCTzcw?=
 =?utf-8?B?UzJNY0kwK214QktzVGh1NXRQUXV4UEd2MERzcFl0SEJPbGhQSjVVTUV0YjNh?=
 =?utf-8?B?WHJUNXRuam9Lb2M5cWkrRGpQQnNmZ3FGeElZZTg1NEYrOHcwL29xMTBUTTlE?=
 =?utf-8?B?LzhoTndWdUJCTEZlQ2JIU05WclprT3FNa2VtU0taaDZCUzZEeWU4Mm1OZDV1?=
 =?utf-8?B?ZnlYeGtmS21CbHdyaFVyb0QweXdEZm4ybjVpeHRLVjR3WldEQ3VBdGRTa0tG?=
 =?utf-8?B?S2F2RzBwL2YwbVo4ZVhNR2ZyWnhrSFVUWjlWQmg3U00yb3lFckdSTWN5cDRh?=
 =?utf-8?B?bTlsVUNFalBMd3J0dUpoN1A1V2RPTjArNEN6dVMyZ1NDKytyNnpHU1JJSUtp?=
 =?utf-8?B?d1pCTWhRWGo3MFZVU3F6d0FOajY1Zm83Q2VlWTc1ckpTUmhZNk1hcGpoalJh?=
 =?utf-8?B?UnRnd1lxN29wY2NXcnNSR0pYbkM5ZmQ2aWFOUnlDYWNZL0MvNTJLa1QxOEF2?=
 =?utf-8?B?bEZvbVpuZHA5M3pBbHh5SlU5SDBkSG1rMVhocDMvODg4Q3ZRaEhqS1BqSGs3?=
 =?utf-8?B?RERVYjhheFlmdlJFRlJGcHh6eTlTOXZyWjJBYjJ1dmJwd3pBbSt5OVZKZ3dj?=
 =?utf-8?B?b0lUaUVtK05LVWJ2eG5tTGl0VGpCZjdoN1ppZkk2UGJ1ZWxTQ3BpMW5lTDJn?=
 =?utf-8?B?U3UvVzdOaS92a0RxWWR4YzRDcDNCbGs3NWdUUi83U0F5MVc1b3dDNzl3Ykpn?=
 =?utf-8?B?bjNTaHExaWpyUHJVeWwyWHlBaTR4TThjbkY5ZFoxTk40UVkyeS9JYkFwSm5p?=
 =?utf-8?B?NWdaYVU5Vk5wSit5cE9JYnhzTkVVWXlwWUJIcE5HUjUvWjNTa0FwdzVIVGQ2?=
 =?utf-8?B?Q3RMTzBSRXUzRzRta1doSHZZRHh6YXQ0RVZRaE5sUG1LeDdxZStWdEJZdVB3?=
 =?utf-8?B?VEw1UDJhdFgyTmVLZHZGTFdobWtZaHFhNFA0QllSVEtZeGJ0R1FNWmhRZ0Vr?=
 =?utf-8?B?eFc0ZFRxU1F0TFhHK2RVdnl5SW5qVVpQUzVkOVV4bWF0SXVXVy9FdnlrVkRI?=
 =?utf-8?B?ODk1ZTJUek5rMSt6dDN2Z0lUci9nQ3JlV0c2cWNFNHNNMWd1d2w0M1RZYmVv?=
 =?utf-8?B?ZDRpVmI4WTFtRStCMDIvQVlqR25aWllNZks0b2YyOXpLa0hYSXBRZlA4QzlO?=
 =?utf-8?B?Skh3MG84UjB3cTJsY3QwQTRQYlZsTTdQaC9KbXFiT3NEcE1hcnUxK1pEVnl3?=
 =?utf-8?B?YTdOTnc4bFIvQlZMTFNObERPZXlXbTErSFhrUFhEQVRnYXZ4SzFaamp3R090?=
 =?utf-8?B?U3JIeGxNZkxVNHFEZGkvMFRiL0Q0Y1dVQTg3aGxGMXUrd3FMdlBlVWtZOVkz?=
 =?utf-8?Q?viPk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:54:54.0773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daf8288e-a1f3-4d20-d757-08de04c6c826
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6

Hi Tianyou,

I tested this on an AMD machine and it's working fine. Few minor issues
I would suggest to address.

>> Perf c2c report currently specified the code address and source:line
>> information in the cacheline browser, while it is lack of annotation
>> support like perf report to directly show the disassembly code for
>> the particular symbol shared that same cacheline. This patches add
>> a key 'a' binding to the cacheline browser which reuse the annotation
>> browser to show the disassembly view for easier analysis of cacheline
>> contentions. By default, the 'TAB' key navigate to the code address
>> where the contentions detected.

1. Annotate browser title always shows "Samples: 0", which is misleading:

   Samples: 0  of event 'ibs_op//', 100000 Hz, Event count (approx.): 0
            ^                                                         ^
             `--- this                                                 `--- and this

2. Comment from v3:

   > In the annotation browser, we did not need to show the overhead of
   > particular event type, or switch among events. The only selection
   > was set to the ip addr where the hist entry indicated in the
   > cacheline browser. The hist_entry was correctly initialized with
   > .ms field by addr_location when the mem_info can be successfully
   > resolved through addr_location.

   It's ideal if we can show sample count/overhead along with the
   instruction (because that's what users are used to seeing with
   perf-report->annotate output). I haven't checked the code but is
   it possible to highlight the instruction by default (Annotate+TAB
   OR Set the font color to red etc.)? Waiting for user to press the
   TAB seems counterintuitive esp when instructions are not tagged
   with overhead.

        |1340: > callq   0x10f0 <_init+0xf0>
        |1345: v jmp     0x1376 <thread+0x12d>
        |1347:   cmpl    $0x1, -0xb0(%rbp)
        |134e: v jne     0x1364 <thread+0x11b>
        |1350:   movq    0x2d29(%rip), %rax  # 0x4080 <data>   <=====  Highlight it by default
        |1357:   addq    $0x1, %rax
        |135b:   movq    %rax, 0x2d1e(%rip)  # 0x4080 <data>
        |1362: v jmp     0x1376 <thread+0x12d>

These are not blockers if Namhyung / Arnaldo are okay with current design.

Thanks,
Ravi
