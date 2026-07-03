Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEC36F8E5;
	Fri,  3 Jul 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068142; cv=fail; b=cp4b/sU6DRGNxgWScO3woEaSkpk2G1OKFDfwbWz7dtryDakqgBuYA8hxXRmHa43G0jsrOgjBcTYLw88rV9OhgWWfZiAG/yvm5edyy65ePP58ZNTrXB50bOZWU9hLohwi+bQLLy/89rGaNxc3er+4Oev7n9NxfWc8tkha1bXBO5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068142; c=relaxed/simple;
	bh=74o8e7G/WQRXj61ww9AZTUXoj8OeiP54kkKjEwf5ZBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTEKxwSrQGg1/5cGJ9WOsgMq9+4iny6M4p+Up2/4zwA9yH/wx2kV/5JbG1VbRAOJ/JavF2W18bA5pJsqSpSyQ34F/D1jnj8+ebL0IqYlCjrsNBAQBTP5jFdifHdY/iI1qQZSVs78wU+JiEZZB/uMVeMktDCRj40by5SX5ZzI+64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjhaUP1Z; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjhaUP1Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h56LM0gJEbOt0V8GnBHxxilulI1MIBshE6aIrBxa7wOx0wc8A7j8ty9H0bztZL/rKI4ri1bABxXPzAUUdiIn9tJPRfaTbL+aItdooD5KPzlPmZ2xC0xCmrH8mq2V01zR0PmkKvw+YADiy/Zjsav91DjQqC1W7XHdjhb1fdkXmD2OvMRt4EE1CUbyN69OS3eJX+6swdC4lninDMic1xg3Z5ig8DxNrRj/cHCmBcelegm2xlan9bxfh7CXTF2y3P2TLyRfGjkAQdoJtPM4Fqj8RbreHIf65SYtmPUz1aXB0uu/NGpRPPlyZUYSANJHzUMXpxvQsAWtw3UA9Mc3etsgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCUNIcPYFUmRXk26/vYigUG6HP//OGPVTdJyUvN9Ekw=;
 b=NuRA0lL1DzBmrmOcWocXuk6SG90427ksk3VKxzxHgxnPJbz0aGS4NNIXIo9ph3iYFSZx02gEmr+GkLu5tNHDWRNSPty6OcCwuOeI4ApiWSqqQnwGGdv8eDAukg6fSprvEYolO27JMOdlkKjwJfBEyC+51MZ+oA5GKIJfoNguUeA5zP9aLNOzlCu4YwMabNwtpeQtPA1WRUk4jY27/9hjsACwtII623sU7q1WIaheXdH7DN0nZ84NPxitr95eRrJZw6jLDV5Jm4oe6Y0piC3H0uBrMKjkylzyMigwR06DHDFr/VanWORlDm4l946Ykf4mt0b2ihm+NPG4Uv/zpCrJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCUNIcPYFUmRXk26/vYigUG6HP//OGPVTdJyUvN9Ekw=;
 b=yjhaUP1ZMRu0OjaXK3/5msPn9EBi5eJH3W08Jkx2PASajbixnnXAe6GtDHK77Y1loDOVPF6cv75a+CzMfPn2deCtu2W6YQO+EmSPCQlbWV2OLt0R3CW+PMygYm5bkGnJ/TuQTty/k7jN6Fgwuntw+2LJBY3GwNz/1Ha7IYGweYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:42:15 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 08:42:14 +0000
Message-ID: <44959c7f-fedd-413e-bb2f-07f97142aef8@amd.com>
Date: Fri, 3 Jul 2026 14:11:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] perf/x86/amd/uncore: Add common helpers and Hygon
 support
To: Qi Liu <liuqi@hygon.cn>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 lijing@hygon.cn, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 x86@kernel.org
References: <20260701093417.1312443-1-liuqi@hygon.cn>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260701093417.1312443-1-liuqi@hygon.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::20) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MN0PR12MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 2422e2c9-8380-48d7-75d2-08ded8defb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UFPEM56ORY+jBaqa8n9B4P417sHfqGz3MSKhXrMWrpQBuyAQdvRaUtk/p9Z4c6l6AfoNjpsG2NBQRODK7bxzPNqrkRjhZLCyqJgqrOoLKPZcuNrnrVy5kBMJkYPDBMbEVlhCB0UpUO49eNnw+gRm+JZq0Egty6PNS+F+x8cjfj/6HPW7VMBZvwo4nNoJqMqTBgwJ7fjfxzVKBZOLRWMkF3xgDrpeWp85epsKPiDOCYM2LlfIpUsdmGniWUvLyceW3HM2PJDs4FQMwU5VqlC1q/wEz8tipA+jEkav0Ucc2waq9m9PcB77y523j8KKNkwhTzLy0Qx6ku6X1FTjPSjP1xPzoSmmDVf+MoKRyI5wY8nuMCgFYdl61PxPmD6AATWToX9dieiTlZlXlFElZoVzFL8UlhnDaSvno49VmLEIc6MQst99rzc2ar95ETIr6SiMKEujgtZ6Ts9HleWAc3UYEQtB/Z27QLgy7U8Ao8Jv200z65zsHSPKtADcbO2ndcD37V/wk1VfPll3z6mhv9NDEb5M+fTNMo/MVcn11XBtIDe8fJttIejR/c4OIPSbDWd1etSm4X7OoxYlijvVDb+E34pS3vL6UNQkDkd4FUTSum10kc9jnxjItWWsHFY+IkyttFeiu2L+usXczNpCIDt28BbpOUFUh1bZTwisUCjWCTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnpMQzdVUmdIU3M2d0EwanF5WVk5NEowcEhYbFVwb0l1TkRHS082SzVyMWY1?=
 =?utf-8?B?bm41K0EwNlVPWjViMS9PdFNFeXUvZEVTT1dmSk1Lc2JFWC9BNDBrb2FGeUZi?=
 =?utf-8?B?RnZYWjk4Sk14Qmt6WHV2TEIxM09OYWNIbUpRSytvN241Wnd2M2JtY0tqYnRk?=
 =?utf-8?B?T1ZTT3JSRGN0dWdpeXJOQ1JmM2kzenJFU1FXUHdDYUJKTlZRSk81TGRLYWI3?=
 =?utf-8?B?NzYyekxOLzdKWEtrZVR1dlorMVprSHR2UHZVODczVWtxZUdjTVlsRTYrdEVI?=
 =?utf-8?B?UXRGMWdnc25xVVZxUEZBcVhoWmtVdURITGpCQjhSSTRheXVkaFdqVUlNWWNM?=
 =?utf-8?B?Y2M3TE94NkdjSld0cXJOUmR1dWVPMFJ2ZTFObzZ1cW9iZVZrVUpBTWNqUHRp?=
 =?utf-8?B?S3VYbGhsVXY3VVpBcUdMZTkxVkdsUWNTd3NmaDVrSU9kTTZrampWWHhsTHZ4?=
 =?utf-8?B?SjZqTUhreU9JTUhLVDNwUmF5KzJpWitvZGsweWErV0xtbVZJamNGTTJUMDkz?=
 =?utf-8?B?ZFZBcXRydzR4VGlOdHRJYW9oQll1YkZnbDRkMkhPVU10OSsxYnhwWlA0RlFx?=
 =?utf-8?B?bXU1SVpoWVdtOG1jNHB2RnNtSUlOTjEzVXA3bklnY1pEeVpkeVI5STl4ODRO?=
 =?utf-8?B?clMvSmk2Y25Sc3JKWFVQaDBKRmdPZUc4OTFwclNKTjF3TkFvUVhHaVk4UEdH?=
 =?utf-8?B?UHNsSjhub0pVZHFqQ1pFUytFVGwvc0Uxd1czZUNOK2FrNGNtRjhQbENvUDU3?=
 =?utf-8?B?SDFESDJXb2ZVMHM3d0ljL0R3UlRyTmRxUFlxbzQzMzlwVWQ0NitUb0hocEpq?=
 =?utf-8?B?RFhma2VRQ1orRDJTOS9kNTFKeXBCOGdhSkZza21vaHVXMUg4eTlxSHlDbmk1?=
 =?utf-8?B?UGo2b1pvUW5ScHJaQUVMQytnYW51VHBYdnlZMFhhK0pvV1cwaW9BWFFLeGE0?=
 =?utf-8?B?anZrcnhBRjRKdDFqd3ZMc09tYlkzWStaKzVUQ2tnVlRuclBvcmN1WHIzNXJM?=
 =?utf-8?B?dkkrRWZGRlhZSm1ZU0dnN3V3VXVtTFduWjBEakNqaGdIcWpqSzdNSHJCWEpY?=
 =?utf-8?B?eXI1VzVmTU4ycVV0dzVCZG9iMkE4dGtlNmU1UDh4b0RoUG9RalRmSFloZXov?=
 =?utf-8?B?MUdrTml2K0duU201TnhFOXFRZmYrellrbzdTcVlyZDZqazV2Y0lyS2lERXFq?=
 =?utf-8?B?dE5hZUZQK2FnME1yYjJLSUVEbmd5N3BzTmpoRHROK2RMWnJFMHVrVFZKSUpp?=
 =?utf-8?B?aWxvVFlobzdNaC8wc0hnNzIrWCtoWjluZE5SZlB5cEo4eStKazNaU0RrMytl?=
 =?utf-8?B?aE9TTGtSYVJxdm9EYzlTSFIveGdKTGIyNy83YnplRUlZVEsvZU00dUdoTTdW?=
 =?utf-8?B?VmZGVDFkYStWQzluVys0YU9rR0pzNWppWnlMazdnY1FlekJ4K2d6QmdaWTdF?=
 =?utf-8?B?Qzc1OGpNaUNVY1hwcm45ODd1bVIzSVEvVnRYaXIrTy94NXVwS0k0eHNxeFNn?=
 =?utf-8?B?NEFZSnlITDFITTVoSk9TTGROSXNyblc0clRoNGdZdVhqb1RQYzZJbE0wQTFE?=
 =?utf-8?B?UXVkUURGTGhUdGpER08yWUZkanNRZjI0MS81MzhZaHg0bTZVNllPV29iMFRR?=
 =?utf-8?B?NkxUbTRvUHJZdTBLUWVwaUwvN04rN0crVzJBWVl1NGRjMFcraVF1VDV6MHZa?=
 =?utf-8?B?SVl6NDJlRjRzTXJvb1o5MTNhL24wUzVpZjVTelVMaXBxVjFDaDZpMlJJY3ZU?=
 =?utf-8?B?eEFEMUVRRkh6bTY5VTNSWE9NWXpGZkJ6UmNBWlVPWWtrckdEL0RURnBVZTZm?=
 =?utf-8?B?Q2RHMFdMNkFpMUJWbFM2OFlDSjUzTituRHpSMU9sNGwzcWMyZVIxYmRocWtq?=
 =?utf-8?B?bEZnZDJtYzRxUDRrYVpod1oyamMxSHNEV1pLdmNYb0ZWR05KYWwvdVhFSkRh?=
 =?utf-8?B?R25jeGhvbkJudnBHWXB0VU4yRFo4OGxIVUZyMzNTMUpwV0Y0czcwRWVhYlFT?=
 =?utf-8?B?WFFNY1RwVlFoZVVoUlQ1SmdCV1pwZ0FWQmN4NUFuSW5GQjYrYVBZSlZBU3Q1?=
 =?utf-8?B?c0N3bmZ0WDUrUllpQ2RxQkl5RXlreEdLWnFFZTNJUGZJYmlPVmRRTmlUNmZl?=
 =?utf-8?B?UjRXL3MwejFLU05kYk1CRkhvRXdIK1NTMG1FK0hvRit3NE94VGNQU2tha3ZH?=
 =?utf-8?B?T1ZNbysvbm9Bay90c3d4Zk51VTB2RkdpQVhodVRBeE0yZ2MvOHlVMVdFRU5V?=
 =?utf-8?B?QXJGZHNoYmhEWW1wRmxNQ0ZOakVqOXFvWWNRTFlOZmw2RStFQTVTR2JTMUZP?=
 =?utf-8?B?R0JaSE5xcyt1ZUdSOVQ4MExOQTY4dFQ5bmJuRHRCRm9kOW1VcGhzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2422e2c9-8380-48d7-75d2-08ded8defb09
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:42:14.4899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PNY2G5GSHd0cup7epFRaCiiOI5S+tTzyqWymIyqJXFmbP0/uCNt9XJXN95SCtzRVjT10KqaxCRyz+X6mUoadQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762

On 01-07-2026 15:04, Qi Liu wrote:
> This series adds initial Hygon uncore PMU support.
> 
> Hygon uncore PMUs use a programming model close to the AMD uncore PMU,
> so this series factors out a small set of common helpers for perf event
> handling, counter assignment and per-CPU context management.
> 
> The Hygon-specific support is kept in the Hygon driver. This series
> supports the Hygon DF and DF IOD PMUs. No Hygon-specific logic is
> added to the AMD driver.
> 
> Changes since RFC:
>   - Address sashiko bot review.
> Changes since v1:
>   - Rename the helper namespace to amd_uncore_common_* to avoid
>     an generic uncore_common_* prefix, and to keep it distinct
>     from the existing amd_uncore_* names.
> 
> 
> Qi Liu (3):
>   perf/x86/amd/uncore: Add common PMU helper functions
>   perf/x86/amd/uncore: Convert AMD driver to common PMU helpers
>   perf/x86/amd/uncore: Add Hygon uncore PMU support
> 
>  arch/x86/events/Kconfig                 |  17 +
>  arch/x86/events/amd/Makefile            |   4 +
>  arch/x86/events/amd/amd_uncore_common.c | 403 +++++++++++++++++
>  arch/x86/events/amd/amd_uncore_common.h | 114 +++++
>  arch/x86/events/amd/hygon_uncore.c      | 556 +++++++++++++++++++++++
>  arch/x86/events/amd/uncore.c            | 578 +++---------------------
>  arch/x86/include/asm/msr-index.h        |   2 +
>  arch/x86/include/asm/perf_event.h       |  20 +
>  include/linux/cpuhotplug.h              |   3 +
>  9 files changed, 1192 insertions(+), 505 deletions(-)
>  create mode 100644 arch/x86/events/amd/amd_uncore_common.c
>  create mode 100644 arch/x86/events/amd/amd_uncore_common.h
>  create mode 100644 arch/x86/events/amd/hygon_uncore.c
> 

I am trying to understand if the code movement is necessary.
Wouldn't it be sufficient to just add the following?
 - new UNCORE_TYPE_HYGON_DF and UNCORE_TYPE_HYGON_DF_IOD types
 - Hygon-specific attr_groups, pmu->event_init(), pmu->add(),
   amd_uncore->init() and amd_uncore->scan() implementations

Using new PMU names will also require tools-side changes. Additionally,
to make the PMUs actually useful, new JSON events and metrics need to
be added. Are there plans for that?
