Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022105.outbound.protection.outlook.com [52.101.43.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087B235C01;
	Mon, 13 Jul 2026 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783924355; cv=fail; b=VEwWtr/IHJOJ5jl1jb26meZWtlpUXyHmbSkfnrHGP3cg5HJd6z9ZXckQMDWqITgJ+MCWRc/8x36rBX0d+YrlzSvHULIfu28IwYFj6q6MEfMV3OG0UaIkYL5JQVGFRf/HkzsAoUID1hj12/7D0hwd8p3eefUt+RqxkaWAs8vbryI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783924355; c=relaxed/simple;
	bh=Av0/cf6tAxMXw87OnO9rbBFzALlUXY70XSEbSx7cZro=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=CsXTPlDmtQs8ZFOmYQfVxcBI6qKjieCTS0u8mnfzG4nQgoJBix3HFqXMJsgaPX8BxWvBnvzE2StV86e8KH0egOkThkxnfN0BLfqRjVe10guE5fTuPUDbOQClxEHvfZ3swnrXdAykus4AOK7jKjB6nBXOR70iXbfg189RiPlOtHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=V8MeOUrl; arc=fail smtp.client-ip=52.101.43.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="V8MeOUrl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0umY8Mi7W4Uw5MDbD08ehYf8f3pkYZbC47tQDcqhpFjADTsAChAmcORnJpc7s6oB4hJilQCMT2JG4iEeSVGP2nmeakTN38KcsqMN0FGoK6CJ6GmFb2nd+puua6G/zxaan2f2wWctREl9BZp6aHGtny75JHPOrTFRL9mckgG9X3hFun8D6jaTQJD6Zwdc/mpZ39clugFfa1QS8zAZRjaiygAdQJYFIjj3lz+YT2J7nQsWJC9tJXRQs3oz3Mi/vViK7sbnmXoaqt+s1FEqklL17pgEGFWvv/LFl03XlbzkmQ7BZhsDrXUxhrAmFdHlbPUIrfpAvJrge2MY5ft/3eolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJqaPCcbkzv4JeAey4EMzEq/+Wg5I6SDgEMrWl+zh+I=;
 b=P5uJgo746bBCvDNiFQLj0tGRi++bQdextkkVkApsoKhroc10jV+MhzlLNmglnzAgWQQTQpLUmDUMna+/CZLFyuVOp8TQ6sjQMC/ngIAKotZRlSEGerk+EALfR4o7PAAPieDJShNuXpCPru+O2VBxk8y+XbE5G8d9lf2J4asz50v6eUpYdL2Fh9cwFGAiRkMlscIpbUnLVaN3ZrVz6Du4ESz7jMe8I6M92hPgFxztFcgBxsA75X+VyFNtZTUyiiCTfwrfxsV2BfFo951dA3fqkxwNZNsYUGkEhaCCPHAmDIqRsjvDcdrPjmhICyD8xc6ySIjhUAW4e3sbcp+XkmcldQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJqaPCcbkzv4JeAey4EMzEq/+Wg5I6SDgEMrWl+zh+I=;
 b=V8MeOUrlIvMHd26gHRtUi/yoRvgpVED7UPDTua//+Tb/BwiSBR6tg7ijcr+Klobi5h9A2poTrkbnypYXWAZF3OtyBeuhuuJCZoLkN8B1iL3zP441eWP34UVWhNbEuVZI9KCE4OcBLsJ8rlblXoyGkU3QCvJGES4wbYs62QpwiIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 SJ2PR01MB7956.prod.exchangelabs.com (2603:10b6:a03:4cf::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.22; Mon, 13 Jul 2026 06:32:29 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 06:32:28 +0000
Date: Sun, 12 Jul 2026 23:32:24 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, 
    ilkka@os.amperecomputing.com, bwicaksono@nvidia.com, 
    linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf/arm_cspmu: Make IRQ more optional
In-Reply-To: <fb2cab05c714f24f703b242c8f8b8e9e4df938f8.1783605641.git.robin.murphy@arm.com>
Message-ID: <ba54ce98-f1f5-2144-2f94-b27d3cd90df9@os.amperecomputing.com>
References: <cover.1783605641.git.robin.murphy@arm.com> <fb2cab05c714f24f703b242c8f8b8e9e4df938f8.1783605641.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:303:8d::7) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|SJ2PR01MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bcb3b90-d1d1-4a68-fa06-08dee0a88294
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info:
	1PfaIS5M20fq1rcphyQyzW1HDoreqXw0CT8cnNkDIcmSvYHB4eiQuO+ZaG/xDPuuLzemHWmHD+vKkEPVneIJ6gzRURoR1P2F2pXmkuv56FbgT2szg003+xkZGJUs5HXeJS1797n/G1mnOUFCo5Le0eXWmHI89p43MY9wiWorObIrcnTG54N0oNUwUic0qQLwkfYeKliFyh3o94AzgHoM93FGS7F/noh7HW+SPGlOjDwJmf8jpVdu3Ywnsd0bsJGt5ZJP0SA8SpPuaHWCy5L9rMYDWhBIIOQuA49tUEfBpU2qiknDzYJS41MJcNwbcRCr8wfqUsKNRgTurlQOGYU8kkqdaY31UjV60y7VCNWoYfA1zsVEG2dDvfHHmkQhWcr37dN3AwkqngiVlVTVtfx0GoKoTQGQ4Y9PvWBCHUWNDF/IPdHb6KmucSSx61Y1+q3pcvDKTVszjy+EjkXs9rJGVDBv/FfBVhZAWrItxLIZvn/+M/Arsls9hRxyF/QjaNgqJctCagZ9VSFRLl4/AxUaGW9HqKNIxNwglkIw8Zr+szkeHlP5z2/F5k6OBO70XSjr1I4seDmT3JvkbGRHhFtFKzZPcxBsR6izX4vLClU4xU2Wn8sXWtvAHxpug/7Svyo/5Bk2uop+h+1/d2eBfZuzpvtoRq+en7ctoUGH/Hya0PY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xJQvEgvsHx5ez9fsnE+zHw/BTIjtrLzfvr7WY/XE2Fb4xasFnZ6g2mnapLRR?=
 =?us-ascii?Q?MM7VFQ7Rm0tenWOC/czITvYy1omyK06oOwQwrLui5pYI9w8V8uIQL0AOd0tu?=
 =?us-ascii?Q?UILwP1mxxtTZ7tAsls7wGOHgwRaAywnrcVFIHYuZRysMJS/s7yJxDPfNyXVk?=
 =?us-ascii?Q?WHFOo5c1K6ZIoWeD3DkYv81mEUDujXP8hxY1wniSqUOR/PBapsSs8ns1+xOt?=
 =?us-ascii?Q?PiLDbeVptgWXSGUO0BzE4wTjTJUHhX/GqHu4vRoWRWEuzFwRKu8ZlhWpV7oW?=
 =?us-ascii?Q?8DI8K2Ux/XZyuqFOM1Wlw6S4FfV6KfaXsEXZjOkGvZEzGjoxv/jK2ZM6vMHj?=
 =?us-ascii?Q?HRXTLzdLtJbdsXabUEOWZR/mTU6s2yFIr7D25uFVUoXrsP5duTOWfjqonI30?=
 =?us-ascii?Q?kxp0WuCJvyqbtohVW3DggaCBAfs8WoI/5oTq9LflfLvEEXM7dcfAYabLAyPU?=
 =?us-ascii?Q?qdqYRELqqeIlbfpUi3HVFYJGtAT7QlnvfUs9NOBsCEVFfgLcvjb/Qx6liAp1?=
 =?us-ascii?Q?+7LXE69j3/b2XYOytDPdk4xvkLdpXPLUqE9nLLz5VCW61sXfOfFKSoil8oF4?=
 =?us-ascii?Q?vECDnq/Rak4Cbbi2hbqtc7a4mRB1AC8XJYXsYrPnQF91kvamom6puVVWwSjd?=
 =?us-ascii?Q?/Ln437VFsaR+TUMBk2rPSZWohTGab2Codph7P69FvkRvnaKTSZIj5D0Tv56M?=
 =?us-ascii?Q?AMwodavbITLlUeKra2KOnlpq/2cqJoZn1Oojtwso55md3fBP6xXLe+8pGekE?=
 =?us-ascii?Q?V8a8LrtS5Tp1Dkwlk/t4K4w5+EAdPlojAS6iy18QyKlGuPLE5BLfCmPJhzgq?=
 =?us-ascii?Q?N3aY5Q1nXJ0ABX/bVbweysmLrWLy3b/NsE7k0CtfpzxSR0EniFqnfXPTEPno?=
 =?us-ascii?Q?MNl2MPRh8AJe0NjQ5qZwHo1dFuQqFSsFPoYtOFt2zg1pbnC2XfWj8joJ3mDU?=
 =?us-ascii?Q?lOCDcv+X1/jSpkY/SMn5yzX1ZC4AHrOpuQFMjVobkzJKI5pph2oK7OZZNB7w?=
 =?us-ascii?Q?kILYYQRmAsRK1TYn/kUGtvuTrTm6QrJgFBDTwF/FuN8CMqUGQ1dQLVVrZux9?=
 =?us-ascii?Q?Cqf19Rvu/ACOlBus1mtkJhLwOSU+x19rI189ygaI2zQz15T6Lz7PpvLeEd6+?=
 =?us-ascii?Q?gb1GzDgB8bO0eyxRGThtCX6XcE8KJERGOqBO31uoFU2G2qhDDlWOHATz2ngR?=
 =?us-ascii?Q?pLaKijrm5M4Ez40EKsEhfnx8arx/657IBm/LWcCeUXEdilujcTJi1WIM4Ivr?=
 =?us-ascii?Q?1JmbiBggqi7raQz7lTOBG7miuR/paZkrrzcm00ZykOfX07Tc32VAeYbdc1UK?=
 =?us-ascii?Q?soY6MjfzCs1S9YlRXXR7eEhRsoKPxYJHZL+ZqptEof4f3GKUnWhDLMiCezFA?=
 =?us-ascii?Q?Qr2ZKDl+d8uI4sa3sALGGJw8STvVhvFlgba2w6L5ALryVh1ksFszBpGtEX+D?=
 =?us-ascii?Q?SlcYIm9lLzTFqdOoqJ/wKbgxOPCeRtRZctxaNLPDv+SzlamcUe3pB22q5Rjj?=
 =?us-ascii?Q?TCI320xarWLFQq8uNbpr8tPQ+WswpwYvmqEbvOPBJ+K0O6TfVqAQ7mNo2LWm?=
 =?us-ascii?Q?VpdR5tDvnxO1ItlxcP1qXqM5DjWol3x+WXv+XxTCLXKbHdMGikKSJcIvPX50?=
 =?us-ascii?Q?7yH8gHFMzIV6gc20rWt6VY4Ft1lzIzGlJQL6OCZc9OvJEB9IlxE0nAAHfQAw?=
 =?us-ascii?Q?eUsHlHI7blEfw2ckl6t+FVGexhzy7RS6ypowsFp4I/DkXNHn89RtZmpx9Imk?=
 =?us-ascii?Q?ts5IBFmb3wSAJf6bhxfMrJeQVK4k9VY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcb3b90-d1d1-4a68-fa06-08dee0a88294
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 06:32:28.7518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zIOhD+ziXtyn2sheladzL8FRKda0dU87i3KuvJENNu05sp1t94wC1DnKBZ/ZCsBkSwXpfnuw0XdAd6osVPbjLJxW1ESIoM+GfYyRoOD2bztYtXY1835T835ae47Bvx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB7956



On Thu, 9 Jul 2026, Robin Murphy wrote:

> If we have 64-bit counters, we can reasonably assume we'll never have to
> handle an overflow before the end of the universe (since we're a system
> PMU with no sampling). Thus even if firmware does specify an IRQ, we can
> still continue in the event of being unable to request it. This can help
> systems where IRQs cannot be claimed exclusively, or are broken in other
> ways.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me,

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 0b26a1588eba..4ba47bccc99c 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1257,8 +1257,11 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
> 		return ret;
>
> 	ret = arm_cspmu_request_irq(cspmu);
> -	if (ret)
> -		return ret;
> +	if (ret) {
> +		if (counter_size(cspmu) < 64)
> +			return ret;
> +		dev_info(cspmu->dev, "Continuing without IRQ\n");
> +	}
>
> 	ret = arm_cspmu_get_cpus(cspmu);
> 	if (ret)
> -- 
> 2.54.0.dirty
>
>
