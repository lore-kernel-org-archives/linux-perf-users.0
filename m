Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A135E936;
	Mon,  3 Aug 2026 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734999; cv=fail; b=W3yQGIzDs+0MyKiNI0i95UazxVVejvC8rjtodGE/GolO24A9yqg9qVY1+Db9vJFzWGoxeDMzhjxqZ+Je3ZeEv1iYGIBR6CIwEHAQSSJxJvFeCqzrImPAItFMaH6ftmhuqwUxB+ohTa+egvAeTC0z2aFDMj1OoPBqMpNBMRMZKNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734999; c=relaxed/simple;
	bh=rACZQC9cMyfSIU+OlZs2J2s4BnYc/OZsZdxvBInNhdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HufKjJYVm5m1BKVzAM5H6AP2fd3K3EFYcUP9xoD2vlKnXiccgY2Zh6vpEyICgPwoe48NGB9ndmU/k7i7MutwXj1WlRc/rTsdPBY1WPCyvx2Vq+LGtKoUjlwrogi0kQKO0cXa1oKBceNNmdjqp7bZa9KAAs5ix0BmOXyhhCv7SoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bdGUUEZY; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bdGUUEZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1cWd+ChBBR0qkz4avKTIJCJ0s/wHwa8prmGRl/LbliWMxnKaiMHSiu1WwJiLWZ24X1aV3KZ3QJPvvVSrpYHTGt9tTVs9au8wyl+v9T2vhChj51UdoHPUOmniAtNxnbk/nqa5ERu9r6VQBLQc93YaqV29fK3/eQYQJRzhLnvRMW9tTwnMp5AIe8dRghYwJmAKhNnjstsk2MtS/3sG4/ATTp/lBKpbonuXE+z5TvGkejjAGCl7XqGlK139NlZ1pNLGtlIRnX9jakGyY2DWEhmZWjymfW+wXyqLjIqkRDovbFoy1BIPoEV7QwuYk18tbbsaPMnM1X6hT/io58y8aYRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDGMNWPSBVRTk6UIHltyOK742KD2uDPr4InnuY6TUpI=;
 b=Eyeq0VQANzyHpec4/F0Hq2Pwa4Ce3PJ/2+0kNsgHgEVFDyvWiGUAHzZBFygHGbjR62Vpv989/GqVpgrF55eVdcdSTToOBdmHHiyXme6HWxozfMgTL2TMyMzJn+ZxCCpHMKBiYU2f+G2ei4Kj7CflbqIeBj3LV2NsZVRd12YXgfxgaNyspNCBaQPRodKxRYQTO2Qyc/lYTctpsi3HBRYqEblr/VQj3KBYibFNwGKFzoPRKqwje9B37QxK425Risd6un/vRR07zUSjPYwCBgBFIPuql8F5yRwTDuuyFEqdX/DYMheKuH+84KHFlxSIa29jhWL+hvZwK0FliQsL25WKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDGMNWPSBVRTk6UIHltyOK742KD2uDPr4InnuY6TUpI=;
 b=bdGUUEZY9Jo9sfLXzLuZ5v9pT5NJW+DeOAg45zVFyE7llTFTKiYebAAvXt70RTwwKmUftbQ8/rc5l9G9Ae5Uv4eaIJza0s3/8BdvSdIZYDCHhwjYMQDsREMiwtdohqp3YMZjodX4mHt3IILDKQO3shrnVTvLb+vN5d2o00tvaVJ3RThkMIVj6E2ZtfIA212ww1FY4u/rGvPz6tM//hCxBfnVK9mIDj68nlDkUA7mumzGiIDg+UAPQBMBkJrG0pPIVTtG5PdP+k3gEWdgWYNtsnv+Re5Y6fzXppzKMGrbzvGpGNBEmVDuKGj40gkVCQEYqCoeR0mp3fDA8rtG2SaIow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH8PR12MB9816.namprd12.prod.outlook.com (2603:10b6:610:262::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 05:29:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 05:29:54 +0000
Date: Mon, 3 Aug 2026 13:29:46 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net, 
	robin.murphy@arm.com, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] perf/cxl: Don't log through pmu.dev in the
 overflow interrupt handler
Message-ID: <anAVpO--i5heVfz9@MWDK4CY14F>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-10-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731232827.401447-10-dave.jiang@intel.com>
X-ClientProxiedBy: SI3PR03CA0003.apcprd03.prod.outlook.com
 (2603:1096:4:297::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH8PR12MB9816:EE_
X-MS-Office365-Filtering-Correlation-Id: b694fb00-b7ff-4579-49b8-08def1203ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|5023799004|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BEuPl6BeRw6Z5n6vTP7MhltskAgpXQH9A1Wz7UsQJJLFBw+TA4KaFOyZO/4JlhPTmkiRgX9jZlViPGoZjDqzpzFsG+NbD4wjOSmjXY9KnaSrH81+vF4U1oZJPe4kYXh9jH005jyyE09P9hCQkARLdvhHkiwzFn35CeSk/Pj1Inwt+U6qoFROqee/KzbLpGS+v45Wla7oTKnICMoowAvBwoLMJPsQpc3MLAgqTGTu5CIGdCT9vAKacIzFOpiDzgxaHlsMuLyGmN5XVyagmntZA0Kp8rW5faoh+hiOcvG3WVJ6QEwdIoToxX5AICmlT8FB8M8Ffnx5aLvCR3Zf6pHR1JBGhaEJDJlo0ITu9FhjKHbEkr52xwm3eOLgK6r/NkeqA/3drKBUGW0w99Fz7UvH/+bK8mY3MXKFAhTWih6iy6Ewof4XKiTHSWtOiOOiVwo5HEXgOUvJA4/JB3hcsERdovKDSFe70N7Xxe+HJ7/dcT9lVsCcvG7nwm701nixlmOVsvulhUGueiNosMTy/lMrJoYF/KtC7Z2Js2Qxd9BfZ4Ok+FhuXvaBvT/Pvv4RbUikkqf9K6NRjD0EWESLDXufepCdDB/SpUEtChhjkS9L8Gy8DqGFCPyjmRQHyJN5rlukQR1OaQq3dhLaSxlmNytV9mozJl5dgYwJqjqn4ONgQcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAAcVQ5526FHxDxqykECnNPDXkZjazHEzeF+eHZoyCN3injQN0KORV1uJV7B?=
 =?us-ascii?Q?8pJbEeM921o3A54sNNs5qqmTP3QfSg1jBj5ryMSE9rOTBCA1LOD6OmaGNlZW?=
 =?us-ascii?Q?4oGV+4cq0WdbOGZrxbZI+1FrKyC7b0mKCZyq6zADjiNVeMuB9D0QQX5YvJj0?=
 =?us-ascii?Q?INKyqQynUk8SFTPmPrvhiuIDCGeQPiKI0o+wPiy1Umkkdu9tUk3QQkZCQZqS?=
 =?us-ascii?Q?HPGfy5Rkea3cL8D/adz1Svk/C5UOAxPSaaY+m/3VisVf58GltjSq0dYJOivP?=
 =?us-ascii?Q?6p4goicMbo+1gdy8sB1lr22f5QfPzNNXNznXGIGsTgQZPF3f/T7iRuMy09wr?=
 =?us-ascii?Q?NMnOImnqnauWUbrYYh4yrSUqimcVhuCzlyCliVCe2ilnXxsEnYNWfjSR5nOG?=
 =?us-ascii?Q?o8DP+bIwAoFHyajFeK3OhO6vPblvo03imUiPz4QLjrx5mJi1cFWuHx+UQm3i?=
 =?us-ascii?Q?Vx8tro+CAp4QmI2bEIYAp4Hj6ybO9rWQFKRQvR0RtjpT8l7usGgLBa+0jRBe?=
 =?us-ascii?Q?YBU+AMcvT3P8J7QhfaF4u9mC3kA9qEyAOL0Uq4QpkAotnElunF1aTTTQRUhT?=
 =?us-ascii?Q?RVOZMKYyn301zDf8oOw3jXFxrqH9ERLcPugdVLkpYdVYDWPU8xBTEv0+HuaH?=
 =?us-ascii?Q?YEwRFV51FMagWJ6EqkpiA+HhonLfZESXuWEmgfA9t1aChdU/nEsPRoMAeh05?=
 =?us-ascii?Q?oo6xH0wtZptk1fG7KYgvbBEua/HxUi1eGus/Hyi33AnnGwQ4bsesB4cC4eP8?=
 =?us-ascii?Q?eDbanRP1bx1WfJB8T4kO86y2eAzJrDSKtVwsFLPB5paDLS9Itp0sPViQ6QKh?=
 =?us-ascii?Q?bDvn0wpm+2stxD7i9qPidX6UpUV6cwHM7PcD96L9SecBJQNtuPoAiGOeqDvS?=
 =?us-ascii?Q?ymaVcgNhCN2mfI7aSqCNL/Z+CduAgcyUD8IPtsD8RSvaZ0Vy4J381S7Jl33U?=
 =?us-ascii?Q?0kkIXaNZNEsyQaY3ykUGW7ZbN4XqrMSFRjl8Kc/woU/XwrmtDRiNSlQ8ayyr?=
 =?us-ascii?Q?okFiu7CSftrOMgF9LY73pz9JJumvhedMMbFEXgJYYedSIMYCWCQ4ZB+oc7An?=
 =?us-ascii?Q?3fqSWosKzWnxT/erLioVTTDG/Fp5mdczYPAKDihRtHc2SBEFRJt9xAYBLVoG?=
 =?us-ascii?Q?XeciKhn1nzvvMyfva49a9VUbCxn8EvSwvVYfCfG18OPUPmYIh+8anqcaBO0j?=
 =?us-ascii?Q?qBYr97ESHaIdpk1O5U0cRWn/hpUJpyc5IvsMcErlxZ2Sw5lNPS8OWbuL0+r3?=
 =?us-ascii?Q?5xrWLsKypkkUm217+eH+rGktclZhoypyxc3o1Y983+SFqQG3XKAs+hKtDglZ?=
 =?us-ascii?Q?a7dJF6h5Be8734VdjhGdPZmfJRHM6+ciqytA+mLl8EXyMUI2udOaqu+f36Fd?=
 =?us-ascii?Q?iObLFHHeVWAfiq4tuRG5kVjnrS6lL4yMvQHQdZ8szLbqij+Ri0T3k0ugejX4?=
 =?us-ascii?Q?pC0FSz7HdcMBNhcQy7v4mPkL65w6kIARBwggPGzrqfgu58nuC8ZTsISGnZ33?=
 =?us-ascii?Q?XW84YLEoFv4Vwa/ws2V6/0NdDzSuq7b5998aP1Upoam3Esvm48G16nX01KIi?=
 =?us-ascii?Q?zfAatO6rLqQVl4kwBTh2TYS0v0t0e4+yocQepNog8yV/6CQfTvqoRp8+mNXu?=
 =?us-ascii?Q?3UxXZD7niFjZwdqifbKn+sJxT2TzR5gNzp0LdWU37O/doGBv9XmxC/zvPjWc?=
 =?us-ascii?Q?KzNZ+ZiY+IRqqwEPoQGyjzT3ZRjhjETdwZ4kdXGUV8NrdPRD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b694fb00-b7ff-4579-49b8-08def1203ed5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 05:29:54.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9CQZqh9RZnMQ2ns4wQ8ybeeURiudOpa8rCOxNMtndSqt+wPItUfnSUH+pOc8eVpZScdlJQSLBS9fYWY334sHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9816

On Fri, Jul 31, 2026 at 04:28:27PM +0800, Dave Jiang wrote:
> perf_pmu_unregister() frees pmu->dev without clearing the pointer, and
> cxl_pmu_probe() registers its devm actions so that teardown runs
> perf_pmu_unregister() first, then the hotplug instance removal, then
> free_irq(). Nothing before free_irq() masks the interrupt, so the handler
> stays live across a window where info->pmu.dev is freed and its dev_dbg()
> walks that pointer.
> 
> Unsharing the interrupt does not close that window. cxl_pmu_event_stop()
> leaves the counter's overflow status bit set, and only the handler clears
> it, so an overflow taken just before teardown is still delivered and still
> gets past the "did anything overflow" early-out. It lands in the !event
> branch, where the dev_dbg() is.
> 
> Log through info->pmu.parent instead, which is devm-managed and outlives
> every teardown action.
> 
> Clear the overflow status before requesting the interrupt too, since the
> driver never touched it at probe and a counter left enabled with
> INT_ON_OVRFLW by firmware or a previous kernel can raise an interrupt at
> any point.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Clear CXL_PMU_OVERFLOW_REG at probe, before the handler is armed. A stale
>   status bit from firmware can cause overflow interrupt. (Robin)
> - Ack dropped as the patch grew a hunk.
> - Drop the cxl_pmu_offline_cpu() hunk. That dev_err() cannot be reached.
> ---
>  drivers/perf/cxl_pmu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 37742ce43d9f..3683427fbb7e 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -806,7 +806,7 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>  		struct perf_event *event = info->hw_events[i];
>  
>  		if (!event) {
> -			dev_dbg(info->pmu.dev,
> +			dev_dbg(info->pmu.parent,
>  				"overflow but on non enabled counter %d\n", i);
>  			continue;
>  		}
> @@ -903,6 +903,15 @@ static int cxl_pmu_probe(struct device *dev)
>  	if (!irq_name)
>  		return -ENOMEM;
>  
> +	/*
> +	 * Clear any overflow status left set by firmware or a previous kernel
> +	 * before the handler goes live, so it cannot mistake a stale bit for an
> +	 * overflow on a counter no event owns yet. The register is RW1C, and
> +	 * bits above the implemented counters are RsvdZ, so only write those.
> +	 */
> +	writeq(GENMASK_ULL(info->num_counters - 1, 0),
> +	       info->base + CXL_PMU_OVERFLOW_REG);
> +

Hi Dave,

I have a question here, since you are adding a clear, event_start() covers more than probe does. The block is frozen there, and it closes the reuse case as well as the boot one.
If a counter's overflow MSI is still in flight when perf reschedule that counter
to another event, the handler charges the full period to an event whose
prev_count was just zeroed.

Also if FW can leave a counter enabled, I'm not sure whether it's possible or not, but if that's the case, is clearing the status bit enough?
A leftoever counter with Global Freeze on Overflow but not Interrupt on Overflow
will wrap, freeze the whole CPMU, and raise nothing.

Best regards,
Richard Cheng.



>  	/*
>  	 * The handler must run on info->on_cpu, so the interrupt cannot be
>  	 * shared - IRQF_NOBALANCING is only honoured for the first action on a
> -- 
> 2.55.0
> 
> 
