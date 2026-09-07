Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013087.outbound.protection.outlook.com [52.103.43.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909AA35893;
	Mon,  7 Sep 2026 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751495; cv=fail; b=HeKEyryB1kqWn9EBHGtGxupKsiEJJVPwg/DPoNccnpkkbmqGHTOxY7Cnzkd0PJbOf8UnxRjXLOG+TuEONmhEajjUzfLqK0MzntHYj4MY3iMcEJLRdZC/CrmDkWykN7cPWW5DOZKBzTMjvE/+qv8FA6Xv8rBGf1HAaXtLKAb3nwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751495; c=relaxed/simple;
	bh=EWxwGvF6U9ht/+aOxo3OZc8dAFeyLW9Re5YTgdnJSj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H9pjRJcfvKjnpHj15y1mynEO92Pe8C0ceHY0rR+zQP7DF4K1Rpksi/bHLmgOgG+tx6FRRlMs0BdLn8CVmXUFt32qpIeO9pZtvxLf1VaID22QW9sdmKi6pUvsULKDVE/2gI6hMdfSi7EkHDDAjpxluU+/7GaTW4U1njGukWan4kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=u8+ksZr5; arc=fail smtp.client-ip=52.103.43.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="u8+ksZr5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvKA5qlUKzQYjNpXfzdEIWzK7s1Nu+QvnRTgilDQANMrbOZyaXsZBxws2UZTP5HxO9uxUzmXAAWFsb8uNFUKXAXSKUZwXqMWPePTP3RciBgz/yZNB25YMkdg0Fszn6mHji4hJk2EtxIlhT0ia0FI+CGz2U3MSoyAwNtOayia9vcXotWO8MI2IfdRDzSQG6gZ3eDE0cNx27xqXbVup1tLEBLtaJsULgMSWi4QAqQYrqWaloLEoSiS1gd2oq8yXwo30Sa1y/sdDexQKIN6HOwzIkl5df7o2Zf37yW1aup6MCFSE9G4yylpnTnr4og9jehCBrbML7Xq6TYrjpPHMBaG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyEBVzQu2JDQD6rEvM7+5Wj53JQQCA+dcYM+zw8z3JM=;
 b=sZNOtJCd+FAnkNSz2ElNQPZ5SvXChf7ykXc19JE0RH2F3yilKZD5/DCSCM0IEDvJMtC0ARzkTI9pPQPiCcwiJWJLIslAdM+2wZ8X3yHBXwKTiuotPFyWM0wuJIcb+k6MnoVKTT18RmX1csNRsPsE9DL5/clZg9rkWfKerFUilRR03inqZjpFMn8E0MDE1Hw1u3wsgQXI+COowO/J/ct6GjLkBcmTFHwRkpZkGrmqGSz33OAi6U6xUkswk8zeD5lABORYp0o+wh4WbRpYFyGeX5Acox7dkZcE2OR4Hh/rXWD0lWm3tOi5PKhD5wXdsi2rwynwixf3XE4HShd45brLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyEBVzQu2JDQD6rEvM7+5Wj53JQQCA+dcYM+zw8z3JM=;
 b=u8+ksZr5xZm0qgf90eHQWlBvYwBfpUzwEsCEdTriqnSEH54ZVTIslF0a2VFTKSENAAvuTSVCWJXsMf1PLj0YMf1r/ramhzdyLpGrT5nJKvxTqPxfKG3DFKR/9f13JQ+FDpEqT7P5ANZjLnxMzGNxuOVsZObXDCmJS3tfunDCQOwebyDVmDMgpNP1st830eAjDG6KQnyuT+F24y2mMZ27tf5Dga8dNYkr1nWpxbGFW+sjEWmKZ1z0ntJm5zLiQGvzkwNv3NzvctxHeJTR0zSBFGDx7JSrw1AekmfWHIyRm1kEAzk68sqg0K/jtiviZwDEJczBcG1IP9Jwp7FH47KGXw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by SEYPR04MB5737.apcprd04.prod.outlook.com (2603:1096:101:8b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 03:24:44 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 03:24:44 +0000
Message-ID:
 <SE3PR04MB8922F1703F8C7BB59265AAF1F3B22@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Mon, 7 Sep 2026 11:24:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iommu/riscv: create a auxiliary device for HPM
To: Zong Li <zong.li@sifive.com>, tomasz.jeznach@linux.dev, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com,
 andrew.jones@oss.qualcomm.com, guoren@kernel.org,
 david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com,
 yang.yicong@picoheart.com, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Chen Pei <cp0613@linux.alibaba.com>,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>,
 Samuel Holland <samuel.holland@sifive.com>
References: <20260904092136.113321-1-zong.li@sifive.com>
 <20260904092136.113321-3-zong.li@sifive.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260904092136.113321-3-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:4:297::11) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <9c040154-be80-47a6-bcfe-88827024a53e@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|SEYPR04MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a17076-5aff-46f8-e55f-08df0c8f8f46
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|23021999003|15080799012|22091999003|24121999003|19101099003|55001999006|41001999006|4140399003|6090799003|25010399006|5072599009|52005399003|40105399003|2607281247196008|12091999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUxwZzVGSk85VTAxM0ZtRmRMdG45d3JjWURlU2FkejJ0cFR2WkRma0ZDdkhv?=
 =?utf-8?B?T0ZpN1ZnTHdIZEU3Tm1sSTN2L05qR0VtU3pybnI2bzMwSHIrclhnNWZoT2x2?=
 =?utf-8?B?aE5Bdlo1aWk1aldzRmYzbU8zVEdNaTRWNFZ2a3FGbC9QMWZRTGVGNnBYeHdw?=
 =?utf-8?B?dzdpQ1loek9zUGpzWTZZUTcwM0RSK3BTY2lPWERNek5Tam5jWG5SeWNsZm9i?=
 =?utf-8?B?am1ybm1WL0tRaG1UeWVzbDBSengrN2xhMWljaEREZGxOR3piUzJPRVFnUUtn?=
 =?utf-8?B?TlNDbXRHV1RCY3hFY2xsRGYra0w5STh1MmhPSVpOSDJVdDdhR2lkSGcyeUgz?=
 =?utf-8?B?NDJWU2RNVHBTdHMrbmR1YUJKYW1lSHJ5TVpOSjYxa0dBYTZsbWtRMUFxSkN5?=
 =?utf-8?B?cVp4bk1ZbnJoRDlhUkpPTk1hWllER0FjbjBua1U1RXJnOXhCV21HSmY5dGE4?=
 =?utf-8?B?OVN2ZkFVcW5Md25DMmxoQ0ZURnFSS01tNEtEUlRMQ2paNzZHZ0FaVlVobWJJ?=
 =?utf-8?B?dXNleStQUGVPcXlqeklFd25NNEE1QjNRNWNnbFlIeXUvQ1I1NTQvM05iVnJC?=
 =?utf-8?B?MlV5aDdDNUV3dy82WEZ2Z3kyWFpyOFh4UlN1K3pCZENBeWhnbmdXcys4MU1k?=
 =?utf-8?B?aVl6Vk95K1NpN1Rnak5raDdTVEpIaWdTUU8xSDhYWTJnSG5vM1IwN2RmTXNO?=
 =?utf-8?B?bVcwUk9nWHY0WERaM1dWcGFwM2Q0MWd0NW5QNHBSaUlhaUFBbXo2aVN5SGlE?=
 =?utf-8?B?dmQ1WmFISUVjanhqK0ZaalZIS08xWW5ET1UwZWttWGczWXM0YmFGUEc1QXNy?=
 =?utf-8?B?VE12am9aVlRRZWVrb0VCSkRJb2ozNWtxcDlBVmludG5zOVlXa2lOTTdSQ1Fh?=
 =?utf-8?B?d21GdUZiU0tJQmMzbEx2NWtkWHRRY01JMnFkSG1QVTVHQnNyTXJzSG00TjI0?=
 =?utf-8?B?RFhsMFladjZRS3VsTW9EVzU4M0lHcG9WeEJaSlF2M3dsNjhVRDgzbndLZVJT?=
 =?utf-8?B?N3U0MlYzT3c0V1RnS0RFVENoYytHbTg5WHdkUnZaUnU5VDhWRDk0SExEVzJ2?=
 =?utf-8?B?SFhmWCtVVXlBMlpzM1VqcThtTjlOWURCbWRnRWVOY1JMWk9HVHNHSTlFL1VB?=
 =?utf-8?B?MTBDS1BVdjdMdVdtRk15d3hmTGJ4eVJzZ2k1ZXZlcDFMVEUra2p3eVlhcEJX?=
 =?utf-8?B?cUo5ZUZSMEpCQ2hZNDdGWGs1SlR2OHU2Z09hU2IzT2ZqVnN6SmltMVBjaWJQ?=
 =?utf-8?B?U0ZMUG5aclg2TkliNE94WFJJQ0h3MEFlTnU3bzRPdDVlajk3N25kU2Eydk04?=
 =?utf-8?B?QXBVN1Roc1hYNllSQXMwN21SeUFrbnVmWVN2MEE5aUl4cFQ1UEFTT3Zzb0hS?=
 =?utf-8?B?SWlZK1M0QktpOVh1ZTF5YXZlTC9icTJkdGhMSnllMkt1blBYWit6eGJnRXhm?=
 =?utf-8?B?clZ4ZlpvZisrN3JUYnY2by91RDVNNDc2VS9TVFRVM3NTRC9aRzBhY3hJK0Qx?=
 =?utf-8?Q?D+db8K4FNtuz72E7Iiae+IzD8n6?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGxIS21EeVk0MjdCM1AraFNLK05RVmh0bURISHQ3ejRUbTU3TXN0eFdRNThx?=
 =?utf-8?B?RlAvaHh0V0c2cHpSTjFtV05pODV5aGNkVEhXQXZ1WFlXZUVQRUxTc1lkMEdq?=
 =?utf-8?B?ZVprQzZrY2pwbkZpQnJxc3dCcExlTlVmcjNjbzlQVHNYWG1uc0hFLzBXUm5s?=
 =?utf-8?B?K2ZYeHFLK2QwNEI0amtoZ3k3UWdkc0EwOGxqUHZubVlmOFNKd2swN2Vkc2tV?=
 =?utf-8?B?ZWVOY1RSNjF5UFZUbHhkS2NFZU5QbXNIUTc1SUZvc2xTeWZiMEFrVnI1QjJ3?=
 =?utf-8?B?alpVZkZHNHI4VXFMbmNuWTlaN0xmOUZSRTI5ZHJZaTZrbzZwb3NQcmQ3MVd5?=
 =?utf-8?B?YmpUMmV5T0oxSjYzdm1qc1ExNUJGSUJjcHNUcVlwNEdOUkovd1hKUlBqQ0JK?=
 =?utf-8?B?TnU0NWJpS2doWkZNMHVzN0FDUUt4ZUNjaE40TWlNSDhnS0dLeGtrdElyNEhF?=
 =?utf-8?B?WStDZzdIMGdBWEhNYWl0Q29ZSlduYmZlK2ZxL3NOQU9PTzhNak11QU9DTExZ?=
 =?utf-8?B?N3haSUJKSm5VUWtIVC9pRjdSNjdONy9vTXNwWU5JVm83bEdSNHRhc3JDTnp2?=
 =?utf-8?B?SFZKblYyTm9NVVgvVTB2dnZYTjNQWXppUU9tL29FeVFnZ25DNW1wQjR0RER3?=
 =?utf-8?B?Y1ViK2w3ZnhHeHo1ZklCYXVhcS9DR255ajFDT3VCTGRRMlpycnhDcFJjQUQr?=
 =?utf-8?B?eENweXRwM1E5TStPTGRjbDdpTEphMXJlR1dzaHdmWkoyVXZFZUJwaHFldVRX?=
 =?utf-8?B?TVpobk10VEE5RmdXdFExTTFycUtpR3lpTGZsMlJEcGNyYzJWMjFJQm13UW54?=
 =?utf-8?B?aFllNDI3ekhuN3IvQzBscDN2MmN4RGVzZWZYY29QTk03RlJxYnFueG9MV2NI?=
 =?utf-8?B?U2QzTW01WXJNUC9NWENVNGVTNkFRQkFqRGtiR2pWRWJ1aDNNTllGTDVaZFBL?=
 =?utf-8?B?bzI4YllZbk9CNDJ3ZFdudzMrSTZRVE55V1N4UDhuV3FwdmdqdHltQU5LQk01?=
 =?utf-8?B?Q0xrd2VVdWk2eC9jcDZMRXFqczF2TkZxRm90cjJueDJtaFVZNlpMdzVSWk9z?=
 =?utf-8?B?V0xwU1lCelFjb3BLMGRPVFRicFNVaTY5K292SDljSllzS25nRG9GbEJaektG?=
 =?utf-8?B?d29zM054VFp4U3Nwb25aSWRxWTFTdjhZc3FmSXoycDhMQUtiWWYySFo5UVBz?=
 =?utf-8?B?R1AzM1YreXhwUDB6UnJFWGtublZFcWlZbE9UZzA3b0lBd0FqbmVXR2Iwd1JF?=
 =?utf-8?B?LzlWLzJIR1owalMza1pzSTg1YlNLYkJiUFUrMFgraGZOUHo1SWc2WDJMWlpJ?=
 =?utf-8?B?WEZRR3U4eFF0TDZVMEhFTmtYajlyQUh2UU5BVEVGZGFhekVIUWpIMFBCMURE?=
 =?utf-8?B?V2xMa0IxMGJFSzFhbUpYYnR4WW9vYm42SWJMMFBnQW9Ua0ErWDFPa1JJUWVx?=
 =?utf-8?B?Y1ZmSkZWNDJid3ZjcnA3blJLOEFza25ndWxIK1ozd2tFTXhkWnhvV0t0a1Jt?=
 =?utf-8?B?K3JWZ0FKbE1jKzJPVHozTFg2VlRkL2RFY0U3UWNxSjFBeWI5bTgwSC9jLzJC?=
 =?utf-8?B?YzRwcFIvcjhqZm5rRGhoblk1SmczUGFoK3VHVTl0UnBrVENUbFpoUEl2Qzdt?=
 =?utf-8?B?NnBJcHI4dkNBdWlZZHNjTzZTTngwV0Q1bmc1aGtJZTNDMHlrTlkwaXV0S0xp?=
 =?utf-8?B?cnFwN3YzSDdHeFdQWkt1Z0dGUU0walAva3d4N1V2ZS9taTkyUCtuWTIrQW0v?=
 =?utf-8?B?a1dSY3ZnajJzenBnam5oZG9IN3RZL2psWERNUXByYUx3ZGVGUm9TNlptZktL?=
 =?utf-8?B?Rm1UZ0dwQnpYMUxxU2JLOUlka2hvSE8rRjNQSDc1bzl4VWNYV1BwMy9sVzNo?=
 =?utf-8?Q?/bRfjbXwjvFPC?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a17076-5aff-46f8-e55f-08df0c8f8f46
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 03:24:44.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB5737


On 9/4/2026 5:21 PM, Zong Li wrote:
> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
>
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   drivers/iommu/riscv/Kconfig |  1 +
>   drivers/iommu/riscv/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
>
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index b86e5ab94183..8025bf0fb67f 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -10,6 +10,7 @@ config RISCV_IOMMU
>   	select GENERIC_PT
>   	select IOMMU_PT
>   	select IOMMU_PT_RISCV64
> +	select AUXILIARY_BUS
>   	help
>   	  Support for implementations of the RISC-V IOMMU architecture that
>   	  complements the RISC-V MMU capabilities, providing similar address
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index cec3ddd7ab10..7f619971bb70 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -14,6 +14,7 @@
>   
>   #include <linux/acpi.h>
>   #include <linux/acpi_rimt.h>
> +#include <linux/auxiliary_bus.h>
>   #include <linux/compiler.h>
>   #include <linux/crash_dump.h>
>   #include <linux/init.h>
> @@ -48,6 +49,9 @@
>   static DEFINE_IDA(riscv_iommu_pscids);
>   #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
>   
> +/* IOMMU PMU auxiliary device id allocation namespace. */
> +static DEFINE_IDA(riscv_iommu_pmu_ida);
> +
>   /* Device resource-managed allocations */
>   struct riscv_iommu_devres {
>   	void *addr;
> @@ -565,6 +569,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +static void riscv_iommu_pmu_id_free(void *data)
> +{
> +	ida_free(&riscv_iommu_pmu_ida, (unsigned long)data);
> +}
> +
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +	struct auxiliary_device *auxdev;
> +	int id, ret;
> +
> +	id = ida_alloc(&riscv_iommu_pmu_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return id;
> +
> +	ret = devm_add_action_or_reset(iommu->dev, riscv_iommu_pmu_id_free,
> +				       (void *)(unsigned long)id);
> +	if (ret)
> +		return ret;
> +
> +	auxdev = __devm_auxiliary_device_create(iommu->dev, "riscv-iommu",
> +						"pmu", iommu, id);
> +	if (!auxdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>   /* Lookup and initialize device context info structure. */
>   static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
>   						 unsigned int devid)
> @@ -1613,6 +1647,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   		goto err_remove_sysfs;
>   	}
>   
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> +		riscv_iommu_hpm_enable(iommu);
> +
>   	return 0;
>   
>   err_remove_sysfs:
