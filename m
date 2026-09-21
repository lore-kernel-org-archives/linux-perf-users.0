Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92F361651;
	Mon, 21 Sep 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967359; cv=fail; b=ocd9rtjzgGjRUXlQSgn86kZd5xZg1xdD24UdB2oT7pZBFtxs6f6H8Z62a/x0mEaHkWKceQYSeCFHg8ikrj/4EdEPBBINpUEy7FSvmSICVJAP5xVwf1uBZ5v1dYYQ1MSWWEOlCka8/5XWlXY27eDiuy5bQbwMIH+K+FiQUFZrLJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967359; c=relaxed/simple;
	bh=LJox9XRrsvjRLyJ0H0V39FCCHzV1YX5s0vbe2gnAqI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PB/npHUwU3KsKDKGoqzy+y8Wm7BRwdNSnLxkHBHZOiQKRYwhA5VK4vlA5Y+H5jZAUg75InioKB6rZ+tw1EFaXoXiMSrFCRhjxp8Nz9fCuKnFagBWnqxF3QxBkVncm1HfsvnHr+ahds86+ixZIDUPw9CCG+0KH6+syZGiUWSZ36c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D7Gz7uYr; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D7Gz7uYr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlCi9zyjKWDhotdQIYnm7IyXM8C1mEM+PaSSuZ4k2a9pdwVIY9dK1M+z++VN0ZVBpddBJt2+nQTOOJgb8BN376Ie8o6qDJ4t1oZXgGR6xNCrtLv8AwzdAf9QCGdrXILKhnexZyUL2eek1fBW7kCnPghMfF0zayV5zIK+LtMKo4RSBM6lNcQUMBQPvg3PCm5TKD+T+5Mc5pCx7uB1S/vTa5UhnACqDNB66Or0w7dQAkxHYCt44rfo0Y7TmWmY/KznsXyqWM2FKXEQ41pN8KZIu4f8Ey6ygiAKTbgRhArQDRtpQjWrye7J05qsTEXdDuHQZQjP1Nyoae/u+VZOL/H0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVgPVN5PNMRSKdqrYHQCGAJinTUnO/z+RGR/ZPnLvy8=;
 b=QSbQ1MRRK0QuNoKhV1/eGKIUwqdih4HCwk+I6KJNHzcYrwsBjcjtBk+vdCa4XaVClbnyTT4Dtodpf5XQW5iqHJFRiDHMXwpKWQa1ss2H7Mbg8j9HtfzSYDqyGaTbxOsMjoLK6qtAMqS9WzAosEPNzSGufrTIMDL5tVQrswiPHspkQ0A2jg6LBnGMAuwOnlj4ZH1+yPA+Sem6PTDtW7z6m1nFFcUpNvNHgpF3A3yJdaezOA6Vo1L9kTrnKswsg/HuwwdSz7bgTNks8NW26PHv0W+l/dTqfO677QtYceiN5ogaGOlZYQEesyzsR0V/TPZYu5ATqZyFYH9cEcoJlzMtWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVgPVN5PNMRSKdqrYHQCGAJinTUnO/z+RGR/ZPnLvy8=;
 b=D7Gz7uYr/0J5I0ap1BmYyCtoAUvBAhJG8XkDROAAoHNzowFXbNVJPWAzMk0VontFGHKjbCPRKA91+OFDY/mSHAGlNYY0O5PnzTxt60CAZA80yy4IeTBVHy6AjYN1JIcqG9MgmEXhGdyqpdU5bv30H0H5JNGA1MFWU/fH09n6lGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 05:09:14 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 05:09:14 +0000
Message-ID: <2bdad6ef-ed83-4a28-8717-61ac043739b7@amd.com>
Date: Mon, 21 Sep 2026 10:39:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Reject AMD Merge event as a countable event
To: Luka Absandze <absandze@amazon.de>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, tglx@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, yaoz@meta.com,
 dwmw2@infradead.org
Cc: kim.phillips@amd.com, kvm@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260916123315.89042-1-absandze@amazon.de>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260916123315.89042-1-absandze@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::7) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7d2df0-eef1-4b89-fa56-08df179e7a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|5023799004|11063799006|56012099006|10067099003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	luN4stRZbBtZNhfLRtuUBVYiNOrbAjRWQzskzejXACs+ociwSljyzjIBP+olKWq30MroWsHmNp7N3IxBul0BOlnjR+CIgXZanFriRmZjzZU5G7gkz+FjhybdfKGKTAVGuZWFtXcSTSs128ExjSJNEtCUwNYEpaEe0+Zc/GWgAQYBXUfD4V7S3V9N9PpdxSKmlRS7bMMELmp1XMbl3YxSZb2EnU9DES0CjDeO8wFM/hg6EdyMqKhQvuN8TicfLBdJz4ykbs9EEXGcitekVdWW5mXuX445S8OAlBqgVRsVCqP21csrbYcd4BPZGg64fWifeqy+ZdwWheQdwGh+IToVcImdL8Pikjpbrkm9p96s0RsTJj8Gz86WzE8t4r/jTT6WIUro2fVABMB732w9HHKVA/Rp+IPjtGQ/p6UvyvTkzpOnC5cuXhFVXEdfn6EiLapI6ECP9XjHoXbb735KnyHRiv+1Cn/v5zZ/QNVChCj8+NJ2OtNd2jGx4g118PQ6Afq9My6d4yOUZfi2ee+Juzz4ycBZsa3DQLbVDDh1FtYarHCsEmqiH+7F53uzW1CBYJHCgOKLfLETXBgOR70UZ1gf4/ZBfmiau/CVbQRF8j5y2mzXMx4nDnDHwHdIhLaF4Q0+T3bWTaTSXpNCeBL/EKfoH60auj+gjsL4ZkarFrqqcsRn4CSW+EF+spgzw6wMqwd9vSvKkRmuGK4jZjKcNL26/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(5023799004)(11063799006)(56012099006)(10067099003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVUrMVNlYzQ4ZnBJaUM5Zk0yd1EwWEJaR0l2RlRsOXZDOXBoS09uZVJuWDdZ?=
 =?utf-8?B?Nnl3emFCRTVLclJoWGJlQ2Jmb1hNZ1dTdmpWTnhuM1dsMFJrMzZORlpvZkV5?=
 =?utf-8?B?TGRRNmQ3TmQ4eW8ya0VKb1dKRDJzclRYYkE5TUpTSXV6MUsyUE5WM0hwTXI5?=
 =?utf-8?B?bHJnbUt4Z3BrR3ZnWjZqR29xeVc2UWswWmIzQTBXWFN0emZONU5jYUlGend6?=
 =?utf-8?B?akt5aSsrUkpKOUJtNDIzbmxqbElaQkVmdnNML2xKTkptWnVuaW1PMXVVaERz?=
 =?utf-8?B?dCtEYnd2N1NIVTRCcHNmeC8vbmhZMkZMbklSTG1jNm9NOTYwUnNlN3czZDlC?=
 =?utf-8?B?eEVuY2k1eE5aSGhQdzR3anphMzM4bkhVZGVWOWRlTWU4RkdqMTY3NHR3NG5Z?=
 =?utf-8?B?WERzR2I3WVl1UVVkZXZOZVdEeXNiMENjbHFDVjFWQUFhdStvYURvNEhwRjlH?=
 =?utf-8?B?RzRYUTVBMldlVXpHbE5teEFwWlVYcXQ3ZFQvT2czQy85bitBalRNV085UWdq?=
 =?utf-8?B?S2g3bko1RFhsK3JBZ0grU3JxK216dHlZaFc5YjUyeFEzME02VGJaNWtOSHB1?=
 =?utf-8?B?WVgxK1l0ejVHUzhSaHFlTkF5Yjk3OTFkY2NEcTY1d1UzMmFKNkFqWHd4UmVF?=
 =?utf-8?B?ak1zNjJwbEJSV2c2Wnk0Z2NNRzFReVVxTnhhUllnR005UXVOTGtaR2oxK1l1?=
 =?utf-8?B?KzZ4eW90Z1dlY0YwcFN5OTV0ditBZ3VpaTdrR0xCcHhoWWc4TkhBTEVmZFJ6?=
 =?utf-8?B?a2xkeG16cStSZnRkeThrQkVId1daSjI1MkpxUWFqL2xRMGhyN3JzLy9kWWtI?=
 =?utf-8?B?RElJbWVuYmo4akFFYlU3WXk2T3o2UzdVMUxrd01aWk9yZGxDRll1T2EwWXdy?=
 =?utf-8?B?Mkhpd1pFZ0dEa0dxRlYxaE5zL0lXL2k1Z2FEMUJwMDU1SldocVZvcEdiWE82?=
 =?utf-8?B?RlRqQW1EZlA4Z0YxdnNGaHBlRVZPQWxuQVNqSWkzNVZwRHYzRHREclBWQy95?=
 =?utf-8?B?TFdQU1ZtMnNmaS93T0xLc2NscW9BNU9sNkdScDUydTROV2xwVUJZM0t6ZG8r?=
 =?utf-8?B?WTFYU0tPbldiSXhkd3JNU203V0htVE5TbEhzeStJeHZMQmd1SDFOUXFuYjdE?=
 =?utf-8?B?aFMvSVFBL2p4NlR2M2xjVjBWMk5ETVpuT1lHY1RyNVRaK3ZkL1BTS2FkTXlr?=
 =?utf-8?B?WDhjY1RLRHY4RW1jOGd3K2szS0hma21wN2d3Z2dxT2owMHd5VUxuYjd4YlFu?=
 =?utf-8?B?dHlPby9NdlhETHV5Sm9Ybjd4VmNHNkVWdTdhR21iSUpiQit6L2k3clF2MWJs?=
 =?utf-8?B?SGxTSmJLY3VNUWtpSDZ0dk5RQmtTb00rVXBmRlRjQTlsU0p1WFN0b3NQYy9V?=
 =?utf-8?B?OHFqUjVEQzBUT3NyQUVLYTRpZGwzU3dCa3ZETEUrRFg1ZWpTb2JsbXBwS3BX?=
 =?utf-8?B?b1lmOXdFQzF0WElKeFVIcjFDN0k5cDczM3FMVEVRL0hXdStFd2tKSk1xbHpS?=
 =?utf-8?B?b29KVkJMVWdabEgzUk9BV01VanBpQzE4d3ltRFpwL0NicFgvYlFNZmtjT2pr?=
 =?utf-8?B?M3d6UFlpSTVHVW11dk5Sd3U0am0rY3ExTHIyZXE1cjE3bjExOVhBZnVPdEF0?=
 =?utf-8?B?K1E0YVFuakZ5L2cwT3RTYmYvZ3F0Wnh5WDl1UmhmVkhwajgrcHRDYXI2a2Ux?=
 =?utf-8?B?L0NqQkUwa3ZFVlBGTFA1T0dEUVE4TW9DTWJOUmFNQVFnQkMwNVBRbVkrejc5?=
 =?utf-8?B?ekx6ZTdFQUZhN1JSVDFodE5TdmZkdkpKSmQ0TWw3bnNDRWVxVllaT3JJWjBV?=
 =?utf-8?B?S1dRbWtZT0Z6aFJvWFlxTGlLalFRbWRYeitKampTdjBuR1k0NFRpcUJKN09x?=
 =?utf-8?B?a2Q5QzhnWmQyYVViWmtJQ1JOSHBobUlIM3JPUUJmb0VqVkRrakx1WkROcVht?=
 =?utf-8?B?dDZ0SVdpN3NuTEZleXhvSWU4MzJFb3hZM1JPaU4yQmtIOUwxSFZPYVZuZk1a?=
 =?utf-8?B?ODdzTGNnSUtLeERYOXlYaEduU3dkTDgxUllTWXljTTZCQ3JZNVIxSlcwTWkw?=
 =?utf-8?B?S2ZIUHN1dWd6aEMrcmVaUGdIWkRJQnNqelVod3N6REtaWWpaamNWTldFK3cy?=
 =?utf-8?B?cVBmM0Ntc3VTczBxcmRxYnVXKzB1WjhyVG92NG5jdFp5U1drVlEwV0MwZEUr?=
 =?utf-8?B?SVpMeURVSkdyTEdTV0dnQlR5WXh4ZGF3bHZUeWw2WlZncWZGUU9kdVd2U3JH?=
 =?utf-8?B?RGQ0c1hldWcza0pkMml6eTY4bCt6RW9uK3UrSEhmd1dBcCtOS2JpeUlISWJ2?=
 =?utf-8?Q?XBpED1CrGqp8CWj6Nz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7d2df0-eef1-4b89-fa56-08df179e7a6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 05:09:13.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q86qocB7c/aT1Jed6d9ohm++f9zX64okkmbJ39zzqSV4S4IRkCyqiSpA8nNBvEOE764ltl2FHZI3P6IW5UPEtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

On 16-09-2026 18:03, Luka Absandze wrote:
> AMD event select 0xFFF (Merge) is the hardware control encoding used by
> Large Increment per Cycle (LIPC) pairs.  When written into an odd
> counter's PerfCtl it turns that counter into the upper 16 bits of a
> 64-bit merged accumulator; any subsequent arming write (-(2^47-1)) is
> silently truncated to its low 16 bits, while hwc->prev_count retains the
> full value.
> 
> This is particularly problematic with a KVM guest, which will program
> the Merge encoding into its own odd vPMC as a normal part of scheduling
> a LIPC event.  KVM intercepts that write and faithfully forwards it to
> the host as a raw event carrying the Merge encoding, where it is
> accepted as an ordinary countable event. Once a counter's PerfCtl holds
> the Merge encoding, every later user of that counter gets a first delta
> inflated by 2^47
> 
> Reject Merge (AMD_MERGE_EVENT) in amd_core_hw_config() so it cannot be
> submitted as a user-visible event.  The pair mechanism programs it
> itself via x86_pmu.perf_ctr_pair_en; nothing else should do so.
> 
> Fixes: 5738891229a2 ("perf/x86/amd: Add support for Large Increment per Cycle Events")
> Reported-by: Yao Zhou <yaoz@meta.com>
> Signed-off-by: Luka Absandze <absandze@amazon.de>
> ---
>  arch/x86/events/amd/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce566..cb655c751e5b 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -380,8 +380,12 @@ static int amd_core_hw_config(struct perf_event *event)
>  	else if (event->attr.exclude_guest)
>  		event->hw.config |= AMD64_EVENTSEL_HOSTONLY;
>  
> -	if ((x86_pmu.flags & PMU_FL_PAIR) && amd_is_pair_event_code(&event->hw))
> -		event->hw.flags |= PERF_X86_EVENT_PAIR;
> +	if (x86_pmu.flags & PMU_FL_PAIR) {
> +		if ((event->hw.config & AMD64_EVENTSEL_EVENT) == AMD_MERGE_EVENT)
> +			return -EINVAL;
> +		if (amd_is_pair_event_code(&event->hw))
> +			event->hw.flags |= PERF_X86_EVENT_PAIR;
> +	}
>  
>  	if (has_branch_stack(event))
>  		return static_call(amd_pmu_branch_hw_config)(event);

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
