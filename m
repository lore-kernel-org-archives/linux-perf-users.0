Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CC1CAA68;
	Mon,  3 Aug 2026 05:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736669; cv=fail; b=JKCU1PuaEDwFOGNL+Y7j6LO3vmzNo8SH1Y37qPSrtdgfioM4SQvRS66RmjtdThoSa8+8DBRLOPiA+XPkzW6VQK+7XeDOPd2tOGIP4YRK+2qouYE4k10NXrMDPdAyIAo+ii+B62aBcFLOao2ZUvmuH60UgA3SqZcrVEEqJgG2JD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736669; c=relaxed/simple;
	bh=CckBuUoSh1Auo4sNINtTcVBLiraohL1ouCnhfcVn9DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t71fL1OVgoWWunfP5juAJQCfDm3YGuqxXeagb5i+vyg/H7y0NRycS49tpaxggZSMz3HZ8nhSlXdUTt8Pyt8AXJ1Mtw9bfiwBISQuPESU6ouAFzAv4tCgTyqd/dQLj5VDIPGN0B4Euzw+bl0XicB0jMv6VN/0YLVG6N3aT5i092o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RSk1ANtC; arc=fail smtp.client-ip=52.101.53.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RSk1ANtC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBtTxfbwZWrhZoyY9QJf1Al7ntAAUEk97tSEEYu4k/M9qUVt0ZH9W4MEv9kaBK0dgkNI6x8z1Qg3ElEQwTVSijRAMc9BzjF9hz1BJUiAOcCRcKf7y/QjcdytS8psfTn6G8wD15tlvR+ewfDwCn9CfKXQjdC7VSb1b1oSbLXoCAgVgN90vyZfACGaBEsL0/Ii8kBUHGodbg6b159A9pT/Dt+46yl3L5Ht00xcUUqlZATS6iNXmlyB/6Mo6A/V0aMuhOsUhW7qBy247oFs7dtDmF/q5lboNvQzNaPrGBBCVpa42cjCTvJmCh1JN88qgJ48yqTr8NlRv4gU1U/ky/VOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksTIwcmvnI4L1ZaHsgto+8p0LWGVAwEj6iHB7SYAcbU=;
 b=LGehHVF1cbu0+gHTxqSoPRuc0vPHxljxVhua1Il4r150tSRARfhTaxrfW+DHNG3RwjvidaVaKrFXstcM/vCcyBFGlZ/mRqUSFBXeAZgHnnclfbzgDlUrgFpWDoioQHKyfLoxP0swo6gdfOswnOmwRSOCqIeoH2/h6fRmMNsROqDvO6yET1sM+Yzq239coxHI9vWLHKryE7D22uZfX7h1XFIpARrQkxu11nGHDnjXoG5DH95eE5apjbdpRAiW9VkMU9Fp8ZA/KiEtr27Pr9qKZRdyTO0cHBA0baHV/4SFBTFfKlsWaNbfoh+fRi5dre1LWmMDTokDLsvKWV8g5p3PTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksTIwcmvnI4L1ZaHsgto+8p0LWGVAwEj6iHB7SYAcbU=;
 b=RSk1ANtCSJGCmiKnrVpnsf3uRUJLxi2Nay7SEwjJyvW0uaFEr3+n18prVQqOJQYhqiMdgJkOfZkk8vR6exS7sOwp+XycDyB0Q5pLFA9bR2cZHtgSOXrHedSJeVx92G33hXaBSJO1ekEBStUkA7j1PnYXILY70t18nrm6yq+NiysZ7YsMDeGvbFIuLwMwcc+sHKO1wDqul9P6gv+wFsk+G6or5BH5Ah6Gp8vAf+h0chdth07KsXHWEXso1bCU4LyAjzDJNiZACKpnrMBrno5ZX0VXIKF1/8+FLYqwyAiTZ+nANQZc7+zfMeuUnmwXB8j1WrEZ6opqebL2FIZRA0ED7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 05:57:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 05:57:44 +0000
Date: Mon, 3 Aug 2026 13:57:37 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net, 
	robin.murphy@arm.com, sashiko-bot@kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
Message-ID: <anAs42gO1Yd7MCid@MWDK4CY14F>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731232827.401447-6-dave.jiang@intel.com>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efa09dc-4ae4-4ca7-5db5-08def1242299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|1800799024|376014|5023799004|11063799006|4143699003|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3eQQc0IUnJgHXioJarF4JH8IzS6Xo/Ry0/a54Sx3eAOQ9iDnr8Mgc9HZIp/OIqpjNIDSZYXr1TtJGaraaB94UvpWxVyelmQjinyjBu6emwZC1d47aQavikkaCK+fLBE68acVKvN+8bI3GKKXIq6deCeQ+RSfA169ERxCU2u1fsKIfzs5V20Rhiw7+Zc5TYtl1bBkSRa35/x1StCWWBVspI8QPsHIiWVnBMA62WJOH5DOFhtj5jkW0MMVhZD/krZy78se+2A7jj4bLuzhBeKa8EMw60B6rjWASWQJYouQkGYydvaks+r+eSMD+MV91PMB62CHcIezp/mPTaaB9+YDtDs2S3RhUVyvCusSeexeZWuhQD1bRTEdR4/f0iDL9VGvps0JjG4DS3q8qNm2xsU1fdxrdChCgSHERCMnaAXhpldoi0jzgUq164GmpsO64FktClgc6w4d/9aXXQmkFgrJO8Rq2FRBknHDohL8CjD86KPl8F/aH10oI4b615Tx6YhiFii3053xG/MxkFuCc6dEbwkiOpJqIhMMfXMmzpWiTJdIvzlLp1mU9Ibp3phflmO2UKNINEpA69p8TEoUiOrKPaXot0hCWJhDzc2i7YYdWXVkco6OoTkmn3fBNrqi/bj1crfTCKpwSDZWAoss4GFpyVZkgnVYZK3IFlGpzjwfcbc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QcUz5YknwuRf6vz0BzL0ubNbsOAssca4ofladkzA26hf/3g8lAdGoR1NHC0?=
 =?us-ascii?Q?gBL5GluPRanLFq1QMGqNT4J4Xyvs1JsZAWpO7I+Y/6tesE38i7A6E8wPefsC?=
 =?us-ascii?Q?jVTKQYGMLPP8izdsc8lLhNgWtYknrRbO+jx0Sug1Erz+I5QU9OuexEEfgHpg?=
 =?us-ascii?Q?0DQkzWN1FK8LjkJxXpb94HPmDpEYHj2GwkehDXZx5rm5nrM73ldsIFAawJQ/?=
 =?us-ascii?Q?+l+7MSUOso4HAMSO5Lr12IYsZrJbqj9YcAGKb6e35s29HVaSUalOIMA7Y6A3?=
 =?us-ascii?Q?1nYT4sOSrNoreGITipQkqnszpti4tQNxYjOL/Ky6SrHnh+WsXQ4iu27pmiYM?=
 =?us-ascii?Q?vv7jqY6N38g0b4jENaiu/mEg4sy++SR4/y0MZyogwbV2EQMhXi1e2F2UaUIl?=
 =?us-ascii?Q?0Jq4o96PDghwkv9MAIQCaaZlQRjrWrUYZ3UuKIQOn5QF5FdXWNXgJUb+65xJ?=
 =?us-ascii?Q?vPzr7CGUKvKaNB3yLbrw1nZe8UJvir8NUZg8H3MspQnrUVvNGs0GPBvtxcLk?=
 =?us-ascii?Q?cux89J83T0N3Duda1NET605t+0Kp+bNp3Wy+VTYvCTIHbl8TePR8cPt3PP+0?=
 =?us-ascii?Q?YGEklx5NeSKn7mdYdgRchWqTINarjpPtTz4B5Pdrxb4HRTKJ6HwfWCz2bZzd?=
 =?us-ascii?Q?LN2UEnt/Rn4OuHo4NM0mS/T+d0NqVzixMl+dlBo1tzwPSq/6w6EoWWH/CaH7?=
 =?us-ascii?Q?aDW/rqd0Yyt4o6gD25gba2gI/I+UYZqrm8DdvWzusgLoebmpji/zhm3DvSwW?=
 =?us-ascii?Q?kvKxPN6nlQg4CcQNqD82gewjgPohMku58X/0MeRK2RQ3wpmdm+FNHzgIrmt3?=
 =?us-ascii?Q?SeIdW6+c8CZo03lkByYBK9MNb6ck2yhl5l7JrjlOOJIAlbH8IdwpfWnQuAP4?=
 =?us-ascii?Q?z+YHsk227VB2xkQLqw5TqqLvUYY6uyCCCX2NkGMb+tbVR+OtdGaWHrSqpzrO?=
 =?us-ascii?Q?nyPB5P2zTI9qmyOr4hpyIVdDsecV5jUxFZaJ3pT0Rr16TCVbH8SP1PtTQGn2?=
 =?us-ascii?Q?BYagtaDZMEpWSxlV44a5Y1wKV2P2Ufr3kqa5sCuQQspmJgI5nQq1Pp3m/Mj5?=
 =?us-ascii?Q?4mFeoLnWYu96aFNnMNeHxuEtjH/fgk5dFdijkM6ZPDKG8QrUCbCWLyYbCA32?=
 =?us-ascii?Q?UMFuo82kL4webTcLGsANYpy79K8w1aeRC67h5VbgQQxucYlG1yXrZR4nHEYJ?=
 =?us-ascii?Q?y4vxTBwWe4NluH9Ni93wD4zk49TeUlOFJ3MqNpISnmyAsRTcSQcrYL/ol26Z?=
 =?us-ascii?Q?icfN9g5IABrMl93C4jwB1mB7wCRlnhMZpfVbwSj+K8w+DChpafQ/UscIEtR6?=
 =?us-ascii?Q?53k+8O7WrFf/KAUjpcMA55rXjMrFN87WFjaTnWHkF9nBq6FRn6NevvE/Aw8k?=
 =?us-ascii?Q?gaScLLVCBGc8FXAkBCuFprUHLMgZVisHWu7p2HSpMYeBFLizqdTdbbvoENyW?=
 =?us-ascii?Q?wXiUmNgFAXCrri2XWTx+mT/EKzclPuDLzt64cxxPxvWHgP9hTwwxAQNfiFNT?=
 =?us-ascii?Q?v2RPJJoi1fqZ5SJ2G44Fp79MKHRF1ucC9T/yP0tlvige8AnMLpvwp1B4mKS8?=
 =?us-ascii?Q?AR8EQgRT3sMjZQ1jyEKHhuE7zdeP04ffD9Cr3YdIiKet/jpOTRfaCYXcjxiQ?=
 =?us-ascii?Q?ys9wCB9GXtLWML8FjxDoPCs5VWMO5gaKLdWEsZQP9PnXVti83wP3OuZvwaCA?=
 =?us-ascii?Q?iHI2dvgk923mSMQIIPm83fBnd8yzF7YKjsWA1w/TG0m/aaOv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efa09dc-4ae4-4ca7-5db5-08def1242299
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 05:57:44.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LPekBYimBkDGRediBm7QmRE20ED8RyX5NcJau0qKpH/nRZB545THkZehWafH2I2UJbEYy9tPw5m2VRPxU0Pvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556

On Fri, Jul 31, 2026 at 04:28:23PM +0800, Dave Jiang wrote:
> cxl_pmu_probe() rejects the PMU when info->msi_vec <= 0, but that field
> holds the MSI/MSI-X message number the device signals overflow on. The
> field is 0-based, and -1 means no interrupt support. Message number 0 is
> valid and pci_irq_vector() takes a 0-based index, so a compliant device
> signalling on the first vector fails to probe.
> 
> Reject only the no-interrupt case, matching how the CXL mailbox and event
> interrupts handle it.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Rebase on the preceding patch, so this tests info->msi_vec rather than
>   info->irq. The fix is unchanged and the hunk is still one line.
> - Not guarding against pci_irq_vector()'s INTx fallback for vector 0, which
>   it returns when neither MSI nor MSI-X is enabled. A v3 draft added a
>   pci_dev_msi_enabled() check for that, but a modern CXL device wiring up
>   INTx is not a realistic prospect, and the consequence otherwise is a PMU
>   that counts nothing rather than anything unsafe. Left alone to keep this
>   a one-liner.
> ---
>  drivers/perf/cxl_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 56e6ae7bebf7..c9e30cb149df 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -875,7 +875,7 @@ static int cxl_pmu_probe(struct device *dev)
>  		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>  	};
>  
> -	if (info->msi_vec <= 0)
> +	if (info->msi_vec < 0)
>  		return -EINVAL;
>

Hi Dave,

I agree that 0 is a legal message number, but do we need to check whether
MSI is actually enabled ?

something like
"""
if (info->msi_vec < 0 || (!pdev->msi_enabled && !pdev->msix_enabled))
    return -EINVAL;
"""

Best regards,
Richard Cheng




>  	rc = pci_irq_vector(pdev, info->msi_vec);
> -- 
> 2.55.0
> 
> 
