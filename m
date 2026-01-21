Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3143218CF;
	Wed, 21 Jan 2026 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768969855; cv=fail; b=AvxxO6yfghCQW16L/A5deiskXjWgynZxSDxrf2w8Q7RL6MLb1rda7KR9Ajn1T2oAkGYwybJN0VdJqFcrt2xjRFNRzJtnWV5SzAyjylqcBkhxDLKBClrMDXwgjenyS6/Ns8OjFWH2bE1keJ+H2SUapHsIB+/RTnaYxQsbdcKL/lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768969855; c=relaxed/simple;
	bh=9HyLGchhqFeHOl7NDbvbi+Bj2n8oQ5y8z/eTwPJdPlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HslpnrYYx/vX1YYqTsazT3sBZH8JdDDa81KbOE9shw8i11EPBhJXD1WPKkzoB10Xz1rmjt+91aa5ZY14+ed/6b6aajhah3/2Tll89UbkK0u2EGVwFZF47V9Exs8yHD0KXjoOX6HkcjFOCYSck1/3cEOPiT14DvH1uelWxKd+ce8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Icu/CiW; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Icu/CiW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNaOS+y+i8Od8ya0Ux6x36ei0N/u0Wqt5kSA1wx5O6A5Itb1irlqVLG5kiKe2Qh8UaMrNPBkgVyhE/HPZiXUqQvPPqYxyCm/rrP43UdArOpHVPxOuBf49f8Yuyxlgy+whSukaWO8gnf6Ke59FTEVxzvbSZ6qUkDwnHIetKRm1al2Zp5l0Ij+cl2iVXcbT+o42G9+e/I283jIaNKyjC0GB4pQU5E876cz7aTReCrSU1AbQ4KaSy0ehOLd2hKE07I1VGtaaZnFRIuHmca8i9D2yoY5Ajbeg6+BPWGRyqkgC+KZMTQdOpyLwNDAXvEIfzo6smOUWoNHOKQycRR/IuuB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSShMBwFMIYyBloQPbnpNb0XyU1qHLVOHWDEFgGn/XA=;
 b=Fv3I/9DiJUZmWhSxcC6dgPtXFM1dwV/jtV5tNqIUCTDWmUWoleJkx3NZa9hThqddqYJ10umVtca0tXwNfqCgUXYo+FSjtUpwynnUhfP3r1I97uUbWDz3be/Hsf2GACZF1K2c05A6q/+7BmnybHS2PoJs4YOoS4HiIwyVAhTsGbCALnpqD8eyiS6A/vBNiWAI5Fkqk2AnJwvIHcEqsTE3VVHavY7fXP4jBfJOc6iOQ53a518Vq7utHipybSll+XI85dri3dE/FRqDd3LNqNqMTVsBCOOQ7n0UajoDlZAkqLqTWW9fUXsXUToDwO2MF8vzYH/635ObPr6J6i6GqhHZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSShMBwFMIYyBloQPbnpNb0XyU1qHLVOHWDEFgGn/XA=;
 b=3Icu/CiW9Sm/0QgqnAN8awJrdp8baYkW7Lapd195xrdg7maBIZtjeO6svvyWR2IZBXD6sFkXbw1sQqLYvIQlfP54TG4qTUGWvWbkF9A9B11Alh/M2mMR7OgZpMQlK9DFSDP08o9idmf5heqvdPb0fB5hPQgFnSvXfZ80+Bs7sbw=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 04:30:50 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::66) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 04:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 04:30:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 22:30:49 -0600
Received: from [172.31.177.127] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 20:30:45 -0800
Message-ID: <863fcd33-b6a0-4e21-be0f-b7efb0ca279a@amd.com>
Date: Wed, 21 Jan 2026 10:00:44 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] perf tool ibs: Sync AMD IBS header file
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, "Dapeng
 Mi" <dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>
References: <20260119024328.897-1-ravi.bangoria@amd.com>
 <20260119024328.897-2-ravi.bangoria@amd.com> <aW_XsuKv5n_IxXkj@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <aW_XsuKv5n_IxXkj@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 125db8a8-bfb4-441c-7182-08de58a5daed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVMzakNKdVdzZkI0L2JHNXJLUW5Eei9IV0tOVTY3QnRFN3AyL1FERjEyQVph?=
 =?utf-8?B?MHlGczFUMHplSkJCUXdPR1N0RTA5UDVMczZkZUl0V3pKaFRWRTlaVVFYTDVs?=
 =?utf-8?B?VC9ub2N4djBsdjVaamt1elg2TVdWMG5FU3hHMTBOMmlOV2trSk92aklDT0Uv?=
 =?utf-8?B?VjFJWmR0Z0ZBZS9LajQ4ZWExQlhLUm84eHdzS2FDYTF0NUh6akt1Umhjb1Jt?=
 =?utf-8?B?Y0w3bkJKSmJueDJ0Wm1vQnlvMzJ2WjVMclNXcitCOEdoQ1dHNDVZdzlPV21m?=
 =?utf-8?B?MFE1QlU5cWxFd3RKemM1RWkwbDFrUDZWL2grWlZqczBKVWtWbmZ5TEN4OG5D?=
 =?utf-8?B?LzNvQVVwbyt2QUtpUE9xanBueFgwR2kvYXNXQmVTU0FXUWtPbDNOemRtNERp?=
 =?utf-8?B?Wk1XNTNPekx5aysyUUhTZkl3L2x1Q284M3dJcmZ1N2RrTVI3d2pScDEzV01j?=
 =?utf-8?B?WFFGNjhIMmhVbDhIVlBLbWwzK3hxRzVSRk9MVGVlY1NCOTY3NkE4N2ExT0Vy?=
 =?utf-8?B?UG9IRzVVTXJlQ2NRbFJ4ZUNFRHFpR1k2a2poOXVTTUErdTJJWDZ0NW8xTGtF?=
 =?utf-8?B?Q1lmMngzQ1B2eENScWIwVkNyWjJ1ekg3eDVIL0xYR3cvL0N3ZVlVU1FzSWZX?=
 =?utf-8?B?NE1MbExJOVRGb2pPMms3U1FFN3FiRTdleTU5NnJCSDUxemtwZGNlcE9KUzNo?=
 =?utf-8?B?Vm1yRDQ5d3BoNFBJVG8zcXhTclRKRUx2OUhnQ1E4bDBwS05IVnpLUU1pc0sv?=
 =?utf-8?B?ZVUvWW5mNkNpQUY2NGZwZ052a1JBMGhycko4MmF1T29tRUI4Y1ZQR08wdjVR?=
 =?utf-8?B?RGJxaFpQV0xyWFZ3dWtnY2xubE83T0JDUWRQdnFyU1RPaEltZ0piK1kxcnhl?=
 =?utf-8?B?eUdmRDFwZVJEMXEvcFNZVzczZVQrYlpnYTk0MlFLZDR4aERadS9KbFhBV3d5?=
 =?utf-8?B?UGVHOGg4TlF6T0YxNVdodkdzNzZiV0cwZDdTK3BlZm5VTWhOTWNYK0FLWFpF?=
 =?utf-8?B?a2wzVk1qbm1BUzFBSlJGTnhLSk1sVzdvQmJmeU15cjQ4WkxDdUtCcllQM05n?=
 =?utf-8?B?Si9iNEpDQU1KeW92N2VIV1g5c2J0RE1haSsxckQyQlQwZ2xzMTBTZmIwYlFY?=
 =?utf-8?B?eGtCVzVkSmZYZ1BrQ3lOa2dFcDZsaGNSQ3JwUHE4U1ZGVldXejE3RTRpaHA1?=
 =?utf-8?B?VFNPUVJUb0RmWnZjbFBYb2kwOXdDL016YUE5N25BSkxheU9xOS8wa1Bzbm5t?=
 =?utf-8?B?aThVMitib2N4andzdU5SNEwvS2lsZmVaTGhCZjJxWjUraFl2Q1VrZktjQmVH?=
 =?utf-8?B?Mmd3bnBKNEhyTEVESjF5V3F5d1JvWENpWkxrNFo3WTJOY1NsN1pJL0FTazQ3?=
 =?utf-8?B?bnZPSHhvSXVVY3cwZlF1WXJQKzBpUnI4TlBybHBQOTdHQU01TUdhNVNEL3h6?=
 =?utf-8?B?cXl5RGJickM5V2Nyb1VkdlZFSjZ4aW1PTXhwU1hONnM1NzY4T0lXK2kwMUdB?=
 =?utf-8?B?UWpqYXo1b04rbHRuRko1ZXpFSW04ZFRjdFRIUGVTcGFoRzVCbVNBaXoySkhU?=
 =?utf-8?B?OUhDRHlmV0xTT2RTZ2NKb2dMYmRFaHd0Z2c4RFVKdk9XeVZhQnJMa2E4aU80?=
 =?utf-8?B?RXQ0elA0R1dPSnU2RVVqeUpjeXkzVmFHeFNJNGV5SE1IdmVYdlJvR0M3Y1hE?=
 =?utf-8?B?cm5HVVlDNTNzWS9mOU5jYjkxU1BoZjBOcVJmVXYrOTkvR25Fa3hxNVhMSk1y?=
 =?utf-8?B?WWZ5TEExcVB5YklwRVBpNkl3Tm9PWXFYWVpBSHA5VFlHRmMrRVVjS3M4UVRM?=
 =?utf-8?B?d0ZuRWt1RVFmL2NOYW55djRuK2dteklHbDZDcUVpQVc5alZTaGFhQ3dPMnlR?=
 =?utf-8?B?b1liNEZqQ3JsN2lwcFJBMlIrNFJqYmtWbS82OUdubWp2RDl0MWwyNDc3aDN3?=
 =?utf-8?B?anFzMzVhcGc1R3ExV0U5eTdyWWIvdjl1cldpT2ZCMjV5alRESHpxWXBIenVG?=
 =?utf-8?B?WWtwcVlvekdHNkZLMFpQWVdadElYaENzUC9EcDRHVFNoWmplWjB6d0FyU1FJ?=
 =?utf-8?B?ZmZ6RysyMERVWE5zZ1hhOE4yZUZ6eldCVXBOU3N1M1FNVVdRTW9ENHkrc0hY?=
 =?utf-8?B?bEFwQVp4TGJqbTA2dWd4NmQ2OU1Pclh4bDNlUVlSdTNwanpkbWRuWFpJTHBx?=
 =?utf-8?B?ZVlmZjRTbGpxZmdBU0ZvKzdqR25qYzhVNEthQlRPMkFaZk9xQ3cydFNYMUk1?=
 =?utf-8?Q?Z7ml52TWTMTrfSgypCmBxxkYktqZXB1DeNL1oAX/O8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 04:30:49.8636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 125db8a8-bfb4-441c-7182-08de58a5daed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

Hi Arnaldo,

On 21-Jan-26 12:59 AM, Arnaldo Carvalho de Melo wrote:
> On Mon, Jan 19, 2026 at 02:43:22AM +0000, Ravi Bangoria wrote:
>> IBS_OP_DATA2 register will have two more fields: strm_st and rmt_socket
>> in future AMD CPUs. Kernel header file is already updated. Add those
>> fields in tools copy as well.
> 
> Was this already merged in the kernel?

Apologies for any confusion. By "Kernel header file is already updated",
I meant kernel copy has been updated by following patches. But kernel
patches are still under review.

https://lore.kernel.org/r/20260116033450.965-11-ravi.bangoria@amd.com
https://lore.kernel.org/r/20260116033450.965-12-ravi.bangoria@amd.com

Thanks,
Ravi
