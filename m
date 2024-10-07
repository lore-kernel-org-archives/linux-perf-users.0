Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2F18BC2A;
	Mon,  7 Oct 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290308; cv=fail; b=mCnJ2gedju5yL7n+V691wHlhhik2lO3WGvCz4l/wmD2O9px51hTBnnL0vW1a8uBj8ICioMcrjVGL6+tDp6wgyKgXJDevI24tt+ULef5EYGg4hQXkoMwMk4t5xYyveqFhweb4WglQhzWto+V3dHrL2APvktz+hTd4SpXv/zOIEEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290308; c=relaxed/simple;
	bh=lv2f9JngngCRD9BvcWivV1tcnVPBORaOaWgoyLweqOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=USNB2DbXbMueB8KwxuX+HpW4f+DBjcVuS5wbqC85ulYifDFjibwjhUnbxm+GZfTjyu1Yqd0nvFWEYOOA0BBlutyZZtz9anJvYq0LGW3xKCh6vDTnvgK3O2h8h02Gz53CRiLuTwyGRkNtjjNAplFmQe/oUlda6hOEyLshuKzSgDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dMDsBfzX; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dMDsBfzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6nE3GRU3/kHpZKPQuaPj7q3Nd+QXHo45OU2T12dEvGDF6LOpPH118icYx1SXPHnl50k6d1nyz2xX9Rfa6bLUtoZdoqt0TTI+s2iEu+i8aWGkDKF4dMOSD94WBaHCi1zfJSI+/oB/AuJBYcmBZXj6qV06rKuc76bjtIxAs6vFhmTM4DSirKrxSAc2AyUgIYu3sseU4KBoj7Eu8x1yqXJkXAyzLkKV49QF6L9FlP5JHLn1IqOkRPoEmp0atCc6EpJ3rRS1iy1x4aG+u9dNZnAQFEn/10TVJFGCp4I0SoupFTOzdqAaL4mPMLVAypUOpLg1zoQ/pSzs6agCCTngiDmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L/m/Re9bzUHZIoB1i/N94gP+G3sAc7U/+MSQZLj4rk=;
 b=E6M6oIZ2y5JfO4wgQ/di4NLxhlohCYxbM6VbxD0EZNGN/dTkJx8NfYCHwJPFzblYjF03ATeb1isgVfScvoZIiDGNnvg1aAuoWf+4XcJZ8yWMPj5xgPcJ32iTKEZOKeMbDw6vrXyzvTWVmmt9tsL1/5HokX5BGBiBTdTPLsLPGZsWRBYI1X/fN2lvjOVFFJgXmfQBoGXC5aQLP/8tZ7LOG2QfIb+6xR882qeVDm6lCV9O+g8a5cgSrPmJWxo+Cz1X3PgK/jXY9cPr1DrVGA2eiETcXTFMDbfKBbp/0AmNDaoquELHPSevTNoEmEpt3JjON+KPMZhBD2FQu/ptv0ek5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L/m/Re9bzUHZIoB1i/N94gP+G3sAc7U/+MSQZLj4rk=;
 b=dMDsBfzXhBwt6x7Zv/yh6o8kRdwC0xY1hYFOjK3i2YKOeItsOmiUxNpEmV4t6voQRE+j27SlFYM241wOK1Scva8C9F0tQhW0I2CjRRkR0TUdrBR2BmX3aVuVFEyoQE7x3wiTb8VWU9PPOjUP+n3QktNrlyhZh4kDrP94JUZeGvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 08:38:23 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 08:38:22 +0000
Message-ID: <e43c36d3-4cf4-431b-bd6b-3e7f072179c4@amd.com>
Date: Mon, 7 Oct 2024 14:08:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] perf/x86/rapl: Add per-core energy counter support
 for AMD CPUs
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 rui.zhang@intel.com, oleksandr@natalenko.name, eranian@google.com,
 ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
 <20240913154801.6446-6-Dhananjay.Ugwekar@amd.com>
 <ZwOCiEGmbeRfurwG@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <ZwOCiEGmbeRfurwG@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 490d1754-bb81-47e8-406f-08dce6ab6755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE50OUR1NGNkbktKRStHcTBBYkE2b3UxNU1sQXZwUXZWTWptQUdQZFJZTmNE?=
 =?utf-8?B?VmhRdTd2SklaaHc5Wk5IUnZoMUFrVGsxc3BWUkdhZ2lOdUx5bW4yTG5CZzhs?=
 =?utf-8?B?c0x3SWFCMVkzL2k0eFIvcDNkUjRMZXNHSkVmdldVWWxXV2t4K2c5L0ZxQVpZ?=
 =?utf-8?B?aDVTNFgxYjAva2RtSDluajFtOTBlZ1JoQkhWaTZ6YXBtVU13MWZQdy9oSDdL?=
 =?utf-8?B?bUtzQzhlNDhvbHN3dmFhQUxzYzIyM09SRzZJL1FVaXR4TStXeHB1VmgzaE1B?=
 =?utf-8?B?dU1ob0xncU41WDMyU2JweS9hNVNPRzZTdWNRSkhVUVRjZjF2Zk9DcUhURWE2?=
 =?utf-8?B?aXZXSk8vaXZlbkZFWGJ4Yi9ISnYvUytjM3hKTmJEVDFjaFdad2xNVmdtR1lB?=
 =?utf-8?B?djdjM1hsVlJTV2VnR2JLdHFQYVdCS2ZGcExtbVNWdFU0clFPak1VTGE4SjdN?=
 =?utf-8?B?ckZxOGdXQmpWZ0NFaTY2WmVRc2xBZ0FKVHozQU0rcXNYQlB2K0F4Q3l6RlJM?=
 =?utf-8?B?YlBSWlZTblV3NnBDWkhxaXhvZHM3cGhlb2tVM212bFJwMno2Lys3UEliVGdm?=
 =?utf-8?B?cytrVkFMT1pzMFFLbmpPTm5uZUY2ckJKT1FmSm96V3lkMjNXdkI3NVZWWkU5?=
 =?utf-8?B?N0VudjRTY2lqQWEzQXdMRi84QWNMdWVXWkJtenVMNzZIbVgwd1lVZVBCdGl2?=
 =?utf-8?B?d0FpcVREQkVNcTI3dm1PckRsRW9iemFjSmRnZUcrMnFiZGliSytHUTVvSU4y?=
 =?utf-8?B?dEpIKzdhYjhaWXhaNWtmSEwwSVRUQ2NvVFFtVmhqQUxyemF5Z0svZThiVWp6?=
 =?utf-8?B?b3VkWEwwdjRrYUx5RE4rcFlydXlUQjc1cU1EM0FPK2ltNE4vdGEwdU1ySFcz?=
 =?utf-8?B?eS9wN2hlelJhK0VGM1c2TWs0NFI2bFBnMFhBSmxHNUZBY2VTVFhGRUR4ajZQ?=
 =?utf-8?B?bGVTYzlqNGV4MDF2RUhSWlo5OWNKR0prM21EWVFkcm5TY3hNcEhERUNmLzRD?=
 =?utf-8?B?WnBuanJMRkxaVHRDT01XVTZiSWx3YjEvRWFzQjVyQkZHWTBzTFp2ZW10SFp5?=
 =?utf-8?B?WExGSHUwMHl5QkNLVEdOUllzTWVLS1FMTkQ3cCtLbzNQTlNWdjcwNG1yK1pL?=
 =?utf-8?B?dVhoaTRTSGNmQ0R4TUVYRjErUHpKNDZhbnJTYko1Z1BhUktzc1FrYlhhQ0xJ?=
 =?utf-8?B?Wm10Smk2bE12bEpCUWVPcjFhTTE0b3RXL2dMUkw5ZkxQQzVEaGdVYzljZDVJ?=
 =?utf-8?B?K2t5dEwzQlV1eHpobXBNbHFIOUxrWTJmSWFaYUpYNkRMcENMQU1ESXEzMkZs?=
 =?utf-8?B?QlFzbHZvKzZoQnZBQmVCMTI0VXVXUko4eERvaTdidC8zV0RCL2RnM1hOY1JK?=
 =?utf-8?B?T3c1RHR1M1dlM2hRUE5vOUhCSzV4OXhPM09pUjdFZmF6bEQ0Qjh0MTV4aXMv?=
 =?utf-8?B?bTdITlhVOFU0NWgxZndtZkI4cy94RFB4RXJKM1JKbThOQVU4QVZMS2JmTW5t?=
 =?utf-8?B?dGlYUGpjeGg0QmVJS1NhSmN4akhKRjdFMDVaaDRkZDN6c0FGVUVCbTBrQ2tO?=
 =?utf-8?B?VFQrWFM0MHJkSWp6YTljVWJ5WlQzSWRvOG0zUkgyTHpScUw1T0Y3NUNrdzlt?=
 =?utf-8?B?b1N4bTRsVDZpT2JpZUQzaWlZa2VSOG56WW5JVzZhYjR1djBkcW9KaHNaV3JX?=
 =?utf-8?B?TnZuOTYwcGtEdHN3bHQ0M0pvSmFJQ3lGWmpkWVBCTTVMRXpkWW5MWlV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWJpYjZVdUtnc2ZHTytmSWNIbWV0ZytrWTMyeWUyRytFTis4VVYrMWRqS2No?=
 =?utf-8?B?eEUrTDJTM005Wk1YTEpRSVVUZU12TzFsRk1kdnVNazEwRERZek9OUU4zSldZ?=
 =?utf-8?B?ZnpGVWxFTUlXQ3hreXBta1ArNWxQUnlUeWNBL0hlRkFMdytSRlR2Z2V1Q2lZ?=
 =?utf-8?B?d1lqdCtuSFNpN3c3MWtRNVlvM2xNVTFLQW5RR2pLRFhCWXFvUm91dWdhYXEv?=
 =?utf-8?B?dTVHUW1TTTFBa2RtUGFuak5FbWZsTHJJWmlFV0xKSlZrVVowS0RqTUVneXQ0?=
 =?utf-8?B?UU9hZVArV05vaVBPa2VTRmRENmFZSlBVdkx3T0pyaUlFMkhwNVJvT3dJN0hr?=
 =?utf-8?B?bHFUYmVOdnlWNm5YaHJsT2JNM1FBSVVET2JMK2kyeU1JaWVaazE1Z1ZqUGYy?=
 =?utf-8?B?QVJrWldlZ0ZxWFBzYkpwbmdZSFlTTTlKOXhQM25EdTg3TjAzUDd4ckcwZTVI?=
 =?utf-8?B?Zjh6Und4dFlVemF1bEYreW5UUk5SK25NOU9EMUZpMUlabWZWaWlLb1lVdGpD?=
 =?utf-8?B?eDZEdVNjNE9IU2pneXNnQm5QOEhic1JGM2prQlBCTy9Tb3dkYzhnWmdMcW4x?=
 =?utf-8?B?c3NzNmZlQlJYcnRaVHptZW1XbE8zdS9iQXZ5WFF0Mk5udUFONVVRcW9NM1Bl?=
 =?utf-8?B?MnFGZUt4c1VuQ2d2OE9mNWFtdTBPTzUxZmcxMzZFSU9aUFVxTmtEOUJHUzJS?=
 =?utf-8?B?RjJ4Z1N6bG4rTHMxTjNWbnp1MllmajR3ZjlZeDdNbWVtdmdJaFdTT0xBb0xt?=
 =?utf-8?B?R2QyTHlBWWhqeHgxTHhlQVRnL2hCd1FtWmFVVHlreHQ4bFJFNWdHam5WSVky?=
 =?utf-8?B?R1NXY2JBcmFXckptdk8rM3RUeHEzY0VWRytybjRMdlFLdC9RTXdNazNadU9a?=
 =?utf-8?B?OTRxbzJmTXlLZ0t3WjVHcUhFV1ZROHlmTzhvZEE0OEtXWVZ2K1ozNGJCNU1B?=
 =?utf-8?B?ZXF1REpFK0czWW4wa2trVkNLS0FIeDJyc3g0UCtIbFZBS3JlNjlLWjd0SW9p?=
 =?utf-8?B?NzNHWURRRkNvVFFqeE1IUHJNUnlhQW1tdkFuUTNBWUd2a3l4cEZHMDl1dXBs?=
 =?utf-8?B?MHlTNUZVTGtmVzhGSjlUNkU4U3oyOFJneEg1cEtmdnhZL0Z4SWE4OUgrZzVs?=
 =?utf-8?B?NVBJbGt2MldaUVZoekkyczhWNDNjVng1SXpMbEJiRFV6ckc3SXJ3TWVYY0xQ?=
 =?utf-8?B?MGdTSE9OWlpPSEovWnVKaEJOVE9YZHFLRnFYbjNLZ3hTbElhUjFHVk1ScFNH?=
 =?utf-8?B?ZjVhdmlyOHBLd0pFWmI0dGdZaWlJZnZYNE1tV1dsSWlqdU93ZzNyRmJEd0pw?=
 =?utf-8?B?dGFwUHZPVDdXTlIwTVF1dnZsbzFIeVJrVUF2aHM1blRYYW5lL2U1Q3Vhc2g1?=
 =?utf-8?B?RllaVktwbVJaekFTNVBtWHhiUHBtdmxnZkpNRmZ2cy9VRzZ0QW1Vbjh2YWF6?=
 =?utf-8?B?TXNQZzN0TjZ3T1lFRkhlSzdGMnBQT3VJUm1OMmhJQlg5UEpDUmsrOEpyM3Zm?=
 =?utf-8?B?VU5adEtBUzdQa0k2aHJkb0hZd1NwS2RFMTM3WHpqT0s0QndhamY5blFQN2Zz?=
 =?utf-8?B?QTdKd0lJZFNnZWVWcCtBWFUwbWt6SEdwQ3NGWG9KellGNGNZZHJvSnJjY0t1?=
 =?utf-8?B?L0VIM0lJNXY2QzFLK0x3SWh1OTUxQXBGc1gxK213eDh0VVlNUWdYV24rNzdD?=
 =?utf-8?B?RCtxN2tDUTcwQk9nY3BGMnprbUNYYmR2QjJLWmswa084WE53RGN3cTFuL0pN?=
 =?utf-8?B?NjRXZGlkcS90L2tEYVplWG1qcU82WTM5SnQ0bzlWc1RJRDUvUjZFM1dLc0Na?=
 =?utf-8?B?Zm1yLzB3MFV2MldjUXVnRVFKdjlHOWpPUExRQzdIREE1OEErOUhLcW5QOEF6?=
 =?utf-8?B?dVQzNGMreUx0T2NQdkpqZmVkY2VGb2IwcWcybDFmSWtpQndrbVdtZzA1S3B1?=
 =?utf-8?B?c3BRR3FkdEdRRUF0Yno1TVdneUEyWVNiQUU4c1czbnNGUXR5R25JcnBhL1N1?=
 =?utf-8?B?c0xHOGYvbktVMm9SbkhtbEF2OU1YUjNiNVFWRFBUbm9SQmszV0tmdTFGY1hw?=
 =?utf-8?B?cWFhK3A5NmZ4c2FvNnBOUnZseHQzUmZGaDFiSzZlMkpscWwvcjJTbEs0YTdU?=
 =?utf-8?Q?MI0eihJXMGzGWcUKJdaVnP1os?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490d1754-bb81-47e8-406f-08dce6ab6755
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 08:38:22.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8stK4IBdJvo5iF7N6TQTuEDUbuWEkdXmbd+a8dw/LOgZKPEW3EI6DT9x+FEbGgO7sshduNEW0zfDSJKS1YALKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

Hello Gautham,

On 10/7/2024 12:11 PM, Gautham R. Shenoy wrote:
> On Fri, Sep 13, 2024 at 03:48:01PM +0000, Dhananjay Ugwekar wrote:
>> Add a new "power_per_core" PMU and "energy-per-core" event for
>> monitoring energy consumption by each core. The existing energy-cores
>> event aggregates the energy consumption at the package level.
>> This new event aligns with the AMD's per_core energy counters.
[Snip]
>>  
>> @@ -156,10 +170,14 @@ static struct rapl_model *rapl_model;
>>   * Helper function to get the correct topology id according to the
>>   * RAPL PMU scope.
>>   */
>> -static inline unsigned int get_rapl_pmu_idx(int cpu)
>> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
>>  {
>> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>> -					 topology_logical_die_id(cpu);
>> +	if (scope == PERF_PMU_SCOPE_PKG)
>> +		return topology_logical_package_id(cpu);
>> +	else if (scope == PERF_PMU_SCOPE_DIE)
> 
> You don't need the "else if" since you are returning if there is a
> match for the earlier if condition.

Right, will modify accordingly

> 
>> +		return topology_logical_die_id(cpu);
>> +	else
>         ^^^^^
> Please check if the scope is SCOPE_CORE here. Again, you don't need the
> else condition.

Yes, will add the if check and remove the else

> 
> 
>> +		return topology_logical_core_id(cpu);
> 
> 
> 
>>  }
>>  
>>  static inline u64 rapl_read_counter(struct perf_event *event)
[Snip]
>> @@ -337,12 +356,13 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>>  static int rapl_pmu_event_init(struct perf_event *event)
>>  {
>>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>> -	int bit, rapl_pmu_idx, ret = 0;
>> +	int bit, rapl_pmus_scope, rapl_pmu_idx, ret = 0;
>>  	struct rapl_pmu *rapl_pmu;
>> +	struct rapl_pmus *rapl_pmus;
>>  
>> -	/* only look at RAPL events */
>> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
>> -		return -ENOENT;
> 
> Don't we need the check to only look at RAPL events of pkg or core ?
> Or is that covered by a check below ?

I moved this check to the PMU specific if blocks (highlighted below)

> 
> 
> 
>> +	/* unsupported modes and filters */
>> +	if (event->attr.sample_period) /* no sampling */
>> +		return -EINVAL;
>>  
>>  	/* check only supported bits are set */
>>  	if (event->attr.config & ~RAPL_EVENT_MASK)
>> @@ -351,31 +371,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>  	if (event->cpu < 0)
>>  		return -EINVAL;
>>  
>> -	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>> +	rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
>> +	if (!rapl_pmus)
>>  		return -EINVAL;
>> -
>> -	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
>> -	bit = cfg - 1;
>> -
>> -	/* check event supported */
>> -	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
>> +	rapl_pmus_scope = rapl_pmus->pmu.scope;
>> +
>> +	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
>> +		/* only look at RAPL package events */
>> +		if (event->attr.type != rapl_pmus_pkg->pmu.type)
>> +			return -ENOENT; 		^^^^ here and
>> +
>> +		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
>> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>> +			return -EINVAL;
>> +
>> +		bit = cfg - 1;
>> +		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>> +	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
>> +		/* only look at RAPL per-core events */
>> +		if (event->attr.type != rapl_pmus_core->pmu.type)
>> +			return -ENOENT;
		^^^^ here
>> +
>> +		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
>> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>> +			return -EINVAL;
>> +
>> +		bit = cfg - 1;
>> +		event->hw.event_base = rapl_model->rapl_core_msrs[bit].msr;
>> +	} else
>>  		return -EINVAL;
>>  
>> -	/* unsupported modes and filters */
>> -	if (event->attr.sample_period) /* no sampling */
>> +	/* check event supported */
>> +	if (!(rapl_pmus->cntr_mask & (1 << bit)))
>>  		return -EINVAL;
>>  
>> -	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
>> -	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
>> +	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu, rapl_pmus_scope);
>> +	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>>  		return -EINVAL;
>> -
>>  	/* must be done before validate_group */
>> -	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
>> +	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
>>  	if (!rapl_pmu)
>>  		return -EINVAL;
>>  
>>  	event->pmu_private = rapl_pmu;
>> -	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>>  	event->hw.config = cfg;
>>  	event->hw.idx = bit;
>>  
[Snip]
>> @@ -644,15 +720,19 @@ static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>>  	cpus_read_unlock();
>>  }
>>  
>> -static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
>> +static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
>> +				 const struct attribute_group **rapl_attr_groups,
>> +				 const struct attribute_group **rapl_attr_update)
>>  {
>>  	int nr_rapl_pmu;
>>  	struct rapl_pmus *rapl_pmus;
>>  
>>  	if (rapl_pmu_scope == PERF_PMU_SCOPE_PKG)
>>  		nr_rapl_pmu	= topology_max_packages();
>> -	else
>> +	else if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
>>  		nr_rapl_pmu	= topology_max_packages() * topology_max_dies_per_package();
>> +	else
>> +		nr_rapl_pmu	= topology_max_packages() * topology_num_cores_per_package();
> 
> Here please check if the rapl_pmu_scope is PERF_PMU_SCOPE_CORE instead
> of assuming it to be the case if the scope is neither SCOPE_PKG nor
> SCOPE_DIE. If it is neither of these three, then return an error.

Actually, I thought there is only one caller of this function (rapl_pmu_init), 
which only passes one of these 3 values, so I thought maybe the error check isnt 
needed. What do you think? 

Thanks,
Dhananjay

> 
> 
> --
> Thanks and Regards
> gautham.
> 
>>  
>>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
>>  	if (!rapl_pmus)

