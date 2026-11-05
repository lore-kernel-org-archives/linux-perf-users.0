Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.93.194.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793859463;
	b=L+G8sRPsKfnq2vbo6H5re+0jQaH6Y5y31jNrX0P3Js9DMLqjK/LxPNKOlF1W364j7g2o
	 bXusapmiBazx8QMmD7kQ57aAqHIR+F3Jsfc9ap8sa4BVI2pTJ6OZEqk8mWUDtM8IwKj+P
	 qk89yJtUNxPpv72XcI84/WWcWoP41QIjQvLxDo8Je5fL9wLmDXREjlp8X5mru24bt0+Jo
	 TP/ZLqRIKyPpoJtZjPdjB9zlbavBRiMGWQ0T7Ptt6yqx5Bxe2rJW0S4ISN8+YHQQ+uOcL
	 JBPKaMRrlPybHt+zG3LUc3LfUT0uszvqdMLxl22bZ++AKui+8VWxavJzcXOldkr+yww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859463;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=fc7yewoIQHvSxDCmRNjBIaH/a7iLhfNWH667MNUw5Wk=;
	b=P/Pr/pzTbV6Hkc9sEH8Byi8WTl9wy3s4UohkNIPXlu1GRpVK1wDpSTWpARc3pktUrQPy
	 89hBUKunk5Bb3nG5eV7nRqn6+jq8H1s4WW3SYaexx3KcYu/+5qfOTfNnk6H4qVpQDiZuE
	 nOqMhAovD3hAU9e9VanqwutGxUGoFRf06qNbF8OVhDrJ5Qh2h7+XCF9beJFOPUNBrzHCx
	 wVK+1hdjMfIGOBm+SgTMc8a42ASZ0oLAGm4TdxU1B9f7IdR0VPy9rj8rnnGi1pHANHZeU
	 mzxlOz/TgGMXXnyHlxJwU2m+ICK/bcVUpcuyZTpMmGnKNhOjDxl+YdQsBeD2bd8I3RQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V97lmpHL;
	arc=fail smtp.remote-ip=40.93.194.19
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D01606A32F;
	Thu,  5 Nov 2026 06:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1D01606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V97lmpHL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8iUSCZ1Xsr3XPua1iIyVjr8nfOREoW+PlQyWR6OmEcs0KDdGYx+oa2lODrhiyf0x4YPDquih5KTS81LKBA72SbqseJWysXz2kUdy2ciEaPDL32s+ryHIUL2gR0lCrYF5NMHbb1hqqSk3esIU7qdI4jCPuQMNoO7OpEzOroycMvJ0iruInUJIenz/OFdG9tmu8ZBdZIcpZyXaC3yO2j3LxtFfwWJ77oHhJsB67UM0EbBzaC8jVkaKWj3R6Oeg1f0WJygQzzlc+DVZtUYSlgcpCp382WPrPeN4ofd5hrff8CO8yHQJrlNr7HbIR0c0RDJWnazl3YRSavqF6x2VKPOow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc7yewoIQHvSxDCmRNjBIaH/a7iLhfNWH667MNUw5Wk=;
 b=Z2MdqyS5tWBQF15GigAdZddbvqKCO+o4a4UnsThwsEKkPk+HiPquLGqJyeXFBXVN0ABu0gIjae3oHy4TgF4w3XKBvkMPrrZiXCgy5bCbc+UiVNMTHWsozalrcjKBAnCGLNXoVJUAQr5eLKH/HU5fLrwoVYuhMTdjnZXK3bSaKsOGjRuurz9j4R0X4sGc5KHAzo4i7roTfQ2H4oq5INvwT96eUhsIrKAkFNIK98tIk9+p8raSUyrMdvP/kM11nTcJIj2JhAppxJJVUdV2FUYWJb9IT0iou+AP9xWPskOsNZsXAWANLufUxBIfOB6OY2AMIPbswcRFKvekt9cAgbwIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc7yewoIQHvSxDCmRNjBIaH/a7iLhfNWH667MNUw5Wk=;
 b=V97lmpHLRAk/E9XFlbn5GJOSaCs40M4v8myMHFBRIquYRUfCts0INEl1HsTfNRC43A+fP7HDvYU8hZbhRHL7vOdoGSUqqbiWUeH2driAaOcgNz4k7eA4Vap4zZKj0QIDBx+k9xClZdCSLM/YW7EjGFArTNys4j8uYPkdTU2jAsg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 06:17:39 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 06:17:39 +0000
Message-ID: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com>
Date: Thu, 5 Nov 2026 11:47:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Freeze LBR on PMI only when kernel
 branches are recorded
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20261023124157.75524-1-puranjay@kernel.org>
 <CAEf4Bzb2jEjqpZrmtTk_+YCW3_jU8fcVzk26CBZnxkpYJ8kCbQ@mail.gmail.com>
 <317a989b-c79a-41a3-8c0a-7e952bdae6d0@amd.com>
 <CAEf4BzY4FYFuT2iSU+fEApnKK4LjHe3i0Xpq_kd4rt4iDLK3XA@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAEf4BzY4FYFuT2iSU+fEApnKK4LjHe3i0Xpq_kd4rt4iDLK3XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0102.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b9::9) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 39315f5c-66c4-40b8-aad4-08df3b047dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|4143699003|56012099006|11063799006|261022105027099003|261021123027099003|261026140227099003|261028144727099003|261021121427099003|261009223027099003|261026121527099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Z7oIXu63N18USGhucKFMK6tJaj1Mv3czg0oAKLRU1E65NPlertwPqdLJcICkoc4hcoh3Qv9hBg0TnSqJVmWFQkI9PvknuDO9kD40Y5a/NpuOAieQLVGuaCSkKmb7ee6OgRZjxgrPYIiDRFSQgmTDU33KS1hFiM68uEX/DSoOuFnvZsQrL1L7kzUeZeE2av7c5k+VOlq93vFOsuuYfYE9uqERxVTX+sOfWhQW0lUYVmrS8nOn2l/JrgmbhNMGZAqECjkNq/z0DH+dgR4eCelggpaBfbdhSAL54rfWRp1vNPzFjzMN94JSKHCw+PPL0P/GaASeZ8+n5DxQ6fcly86vKYYHCXKDAlrHTw7AKfyLcmMVpRuyg0fnQ9GIrdbtsjuVpzihD+Uw9jrobC/xL9smtpU+/SV1iIAK8lBEQrYl1L2tKHLGPqBQVvuPpn2ayWd8V+qR896r4OX9tGJNaGubG/XzE/VclP8NIzOPOfQtg1RukorSqmt6tjTXAX3xO59TkvnwJd6dUyAH8dYLxUTabHQEDOaKngvzLbsY2l3TGNHSfxCsqjHmIDbrNaIvl7337mkuK68V/osG6eIR06Qo3TybTeCx2LTrc3TjNzigkPR3bKyV0n2/L1/qX0tFRiMBwf4xuFI2QlIPS+nMYdv78jWpaP0XFvL2hOWUe+a0bZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261009223027099003)(261026121527099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0dYT283TGJ4RURRRkFkUENaTjBsaUt1UUExaE9KTytRdEtrQ0RwejVWK3F3?=
 =?utf-8?B?SkRBSWxiV0l5VEh0bWFWT3BlN0tvSDh1ZVVpU0NyeWhOWWQrd0U1RU5ZUFR0?=
 =?utf-8?B?ckRURzBMU21GSHhxekxiYU9nTzVyOHlxWjRDVEZGeC94SUNENS8zM2FzYUJ5?=
 =?utf-8?B?SWp2SlkvbktPM0xSSGpoSGFsODNQeDVXbGVIeUtBZWlyTGU0bG10d1F0Nnpq?=
 =?utf-8?B?SnNmdHloTnk3MWZSVnQ3SXU5Ykd4cm5ISEdIMEU2VjBVRlVRcUc3U2E5TGxu?=
 =?utf-8?B?QllyQzlsdkJsajZIYlQ1NnRNQnNOeER2NjkxeDBqbEZkaTRlOTdPdmlTRUNQ?=
 =?utf-8?B?TnUvRjZpSG15OXNLbEpGU20veG9GODNzeGFpWTZta1JDVzZtdmljTzZTUFQ5?=
 =?utf-8?B?YllnWXc5aGJhN3NvajNqOFpQd2RReWJROTlsOEZUNHBzNFRXTmIvb1BpUmRL?=
 =?utf-8?B?U1U5RXU3ekJQRGxBSGpMR3lGOUYvcHRhVFRxRnRqVHNYd2s0VDlqNm5hZFhJ?=
 =?utf-8?B?Z2g2ai9YNklRem5PbWovenZSK2tQWWY3YzN2T1BHRDd2Z2tTSWJXd2hkWktv?=
 =?utf-8?B?MU9CUHV4RXYyVnBwQW5xK3RVNEtVdVZ4UStZUWYwTWU4VE5pbEJXWCtPVzky?=
 =?utf-8?B?SkxoRlk5K09XUnM5SjRJTVZYbnVybFdmOXVCZGxPdXBPNGlmaHF2eUZMMUhs?=
 =?utf-8?B?Ujk2U3NWN3phL0Zvbi9ydHFZeUV5cDhSdmdNSHY1YVllYmR0dXJXbDRlNCtx?=
 =?utf-8?B?MFlaaHpseWhycnVlcXg0Y1JjUWhOWjRZOEdYM0tpb1VROVR2RnRYODgyTDQz?=
 =?utf-8?B?YWthaW1RK01YMHM1SFRXZ251RlcvaHl2aS9zWWpVSmVHT3d0MWsvTDBrbmZp?=
 =?utf-8?B?V3JUaDhzQW5TQjJSN0tyNkphbk1GamZESkxXZCtGTUdBMzdYV0lnaEJyeXJp?=
 =?utf-8?B?Y3dTTUpCQjg0VVZ6aTBIRmRpVytZdDVWa2R0WXRTL0EyR3ZFVnYyaTdIWHZW?=
 =?utf-8?B?Z2JibHAyaDJqUU1LZTlpbklRckNlZCtwTUdmRVVMS0kyb3NYcGNKaHpwV1JG?=
 =?utf-8?B?SXpvdUp5WXdVNzEyZ0xFdStFeDBmRVFra2hHa2Z3V2YxK3piVkRkN2ZXcXpO?=
 =?utf-8?B?bHE0Vm90NUYyOENFWVZOalNWa2xmenZjWjJIMXlFWlFNeGhuK3hDTXVNVDJK?=
 =?utf-8?B?TlVzQU5MVU02Uk44bXlZMFZZMUExQTJPdjdEY3FxeGVyVnpPN29hUHFBaFpr?=
 =?utf-8?B?UElQakxIWTJpby9HSW9QclZGT09WUTdkTWVEakppK3hEc2VMTFhTOU8xUWVI?=
 =?utf-8?B?MGo0U3ZMV0RSaGVZK3hxNHRuaXVYWFpRQUJkb0ZTRmttWk1QTWhxVnRIejk0?=
 =?utf-8?B?RlJ6a0wvOWhXRzFmM21CdnQzSUJ0UjNrTmRiMnl6aXQzOXlzdlFBVE8yVXlK?=
 =?utf-8?B?UWdpNlFuOEtMZkFPVHZDZm9MTC9FMUs1bWNabzhua3pXN3FHQXFudHI0RkVh?=
 =?utf-8?B?OHlKMWpoU0NEY200MmFwUVVCb1R4ZUgwa2Y1RkFnalRjcVZaRytFcGJKWVFl?=
 =?utf-8?B?Z2N3bHZPWWp3d1VYbHN0eGNoQnV5Um5iN0J0bElCbUtmRG9nZTBwUEhNclJo?=
 =?utf-8?B?aXZXZWtxMyt4QksrZkEvWmNFakNUbk5LZEVDRFNlNzk2RmhsbnBLcGUwcHBF?=
 =?utf-8?B?SjhzRE1ZeEZaZDN3WXdiSkRDRWxHV2VBTEw1eTYxOXJkKzRYVEpuUjNXMDNt?=
 =?utf-8?B?SWN6OGhqUzVmRzhqMUNqZ0V5K1VVV2I5dmNEWi9WOWIxdGF4R2RUYnprcG0r?=
 =?utf-8?B?aTRkYXkvdGx6Q1c4NkhTd1Z1eC9vZ1VtNGlJOUNES0wvWFh1NlBjVmx5MGVt?=
 =?utf-8?B?VU9tVHkyUVBCWHhOb0psSHdNRUpjNjgyQWIvcUFFVkxUV2puMFp1OThUNjd2?=
 =?utf-8?B?OVFEVG9nK0YzRTcrb2k3dEJoY1E2Y0YwMkFRRktZWnJIdW5ET1Q3QnpvRk1X?=
 =?utf-8?B?d3pTdEx4MyttWUYvRkF4VmdaQTJMWk1SeTBhY3B3dUZwaGZ1L0xHRitEYmNk?=
 =?utf-8?B?UUtLU2tvbGw5eEV2ay9jQzRhdTB1Tm5odjg1VnBRWVhYNUJrZDV0Q1NERlMv?=
 =?utf-8?B?MHdkclorWm5GUE0zNHB1Z2VRME5NN2lVbmg3WHliMjRHOGQwNGlUc3RHYXNx?=
 =?utf-8?B?WnJPTlN3cE04Q254NTlXdkpQSWg0alloM3BONHE1TUNiS3BKWlYrWFpGN0xV?=
 =?utf-8?B?WmtpYVR5MXJIMGhDQmZFMGNHcythTEZWQ3hSd1FtNXlTNm9NYUMwemZVbzN2?=
 =?utf-8?Q?NZKSN7kSnuhGjzGzNh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39315f5c-66c4-40b8-aad4-08df3b047dcf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:17:39.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq079Q0VK0t9wR3YZKlsjQbRplXotUtqX7bOP4V3tIqoVUfJNjfhMn7LR1d0O7e+eUpq4YFFZb7C9FqVGQMdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212

On 04-11-2026 00:39, Andrii Nakryiko wrote:
> On Mon, Nov 2, 2026 at 2:08 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> On 30-10-2026 01:42, Andrii Nakryiko wrote:
>>> On Fri, Oct 23, 2026 at 5:42 AM Puranjay Mohan <puranjay@kernel.org> wrote:
>>>>
>>>> On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
>>>> PMI, so the branch stack ends before the IP and callchain, which are
>>>> taken when the NMI is delivered. IBS rejects branch-stack events, so
>>>> there is no precise alternative.
>>>>
>>>> The freeze only keeps the PMI handler's branches out of the stack, which
>>>> matters only when branches into the kernel are recorded; without it the
>>>> stack fills with the handler's own branches. A user-only filter does not
>>>> record them, and parts without the feature are never frozen (see commit
>>>> 598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")).
>>>>
>>>> Freeze unless the value written to LBR_SELECT, which is shared by all
>>>> events on the CPU, suppresses branches into the kernel.
>>>>
>>>> With perf record -e ex_ret_brn_tkn:u -j any,u on a Zen 5 part running
>>>> CPython, the function of the sampled IP differs from the function of
>>>> LBR[0].to in 84.3% of samples with the freeze and in 0.1% without it.
>>>>
>>>> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>>>> ---
>>>>  arch/x86/events/amd/lbr.c | 9 +++++++--
>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>>>> index a55646fcb8465..7ec50380ac81d 100644
>>>> --- a/arch/x86/events/amd/lbr.c
>>>> +++ b/arch/x86/events/amd/lbr.c
>>>> @@ -392,7 +392,7 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu_context *pmu_ctx,
>>>>  void amd_pmu_lbr_enable_all(void)
>>>>  {
>>>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>> -       u64 lbr_select, dbg_ctl, dbg_extn_cfg;
>>>> +       u64 lbr_select = 0, dbg_ctl, dbg_extn_cfg;
>>>>
>>>>         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
>>>>                 return;
>>>> @@ -405,7 +405,12 @@ void amd_pmu_lbr_enable_all(void)
>>>>
>>>>         if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
>>>>                 rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>>>> -               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
>>>> +               /* Freeze unless the filter suppresses branches into the kernel */
>>>> +               if (lbr_select & LBR_KERNEL)
>>>
>>> On Intel CPU side, we reset this FREEZE bit in
>>> __intel_pmu_lbr_enable() if is_lbr_call_stack_bit_set(), with the
>>> comment "LBR callstack does not work well with FREEZE_LBRS_ON_PMI.".
>>> So this is not *exactly* what Intel side of things is doing, and I'm
>>> not sure I fully understand the differences, so hopefully someone more
>>> knowledgeable can help.
>>>
>>> But what Puranjay is trying to do here is to at least make a
>>> user-mode-only LBR and IP + callstack to be coherent (for PGO data
>>> collection, which we then use for user space app compilation), by
>>> disabling freezing for LBR.
>>>
>>> It doesn't seem like there is anything we can do on AMD hardware for
>>> when we want kernel-side LBR and precise IP to be in sync,
>>> unfortunately, but at least for user-space only case it would allow us
>>> to not plain disable freezing altogether at kernel boot time.
>>>
>>> Does this approach make sense?
>>>
>>
>> Yes, the intent to keep the LBR and IP coherent is clear. However, my
>> concern is that this may end up dropping the branches preceding the
>> hotspots since a CPU might keep executing in userspace until the PMI
>> handler runs. I'm not sure about the effect that this is going to have
>> on PGO but what if we rely on a mechanism (UAPI + tool flags) to let
>> users explicitly request freeze?
>>
>> If there is an use-case where freeze helps, then the facility can be
>> explicitly requested.
> 
> heh, it's actually the other way, freezing **hurts** consistency
> here... should API requested freeze *opt-out*? because freezing, if
> supported by CPU, currently, is the default behavior not requiring
> opt-in. Or are you proposing to not enable freeze (even if
> cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE) is true), and then
> make user space request freezing with the new UAPI config flag?
> 

The latter. The default will be freeze disabled irrespective of the
CPUID feature bit.

> I'm not against expanding UAPI, but it feels like a very quirky little
> thing which also stems from AMD-only limitation of not supporting
> precise IP capture with LBR enabled
> 

I agree but it can live as an AMD-only flag in perf_event_attr.config2
or something similar and advertised through x86_pmu.format_attrs.

> 
> BTW, the alternative that internal customers actually requested
> initially instead of this was to completely disable freezing at start
> up through the kernel command line. Which seems like the worst
> outcome.
> 
> Thoughts? This all seems unfortunately messy, but hopefully we can
> figure out some non-intrusive but workable solution.
> 
>>
>>>
>>>> +                       dbg_ctl &= ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
>>>> +               else
>>>> +                       dbg_ctl |= DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
>>>> +               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
>>>>         }
>>>>
>>>>         rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
>>>>
>>>> base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
>>>> --
>>>> 2.53.0-Meta
>>>>
>>

