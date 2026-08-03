Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD9274658;
	Mon,  3 Aug 2026 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785729736; cv=fail; b=UypHkO70aN9nOpMmHT6Gc5Qq128ggjwkdgxul7maouPyGztuYWgEhMEgQYhTeLetdB+Bo9kAyRrjhO448y+ml7tCIIPfXFazs8vEF1lSXw+kguPqKfJmtfY8Ea6cHdsoVdGW3QSo0A7K4kc/R1rSgDXzOzWg3URHkKeRO4VeJGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785729736; c=relaxed/simple;
	bh=JIPVP12d9x/uFomvwwOpFETygduDOHx6KuVH6MMCYuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H4ODeLNcu1qCAidOKC0Ww8s27MZBJISS3z5xTosfT7U46zsfkkmlqkrUEa3kTzLRsPrgeclADOBicfNJS0JfVAEeSbc8mnpmpxdoXKwQxo2ToNVsMjyUEDL8AH6ehUW4C6aHKosBFakvTOPiYajgxe1PVObRyK7R+QR0zBU/enc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dGmuE7By; arc=fail smtp.client-ip=52.101.85.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dGmuE7By"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAgBetdP2koCdx5tguudEvX/ExQ8RpO6H4QM1LIDhGov8iTnDo/m/1UZssQdTj/oM5OIKi6nYwbof+8e5MwBM15CRGIdsDgEwtHOXTvPmTPAUx9zNno4tdZh22UedsIQLg6pBf/ocNby051T/38H8xKlPZDC+qfQuBzJc3YnwqlpiGvqZUy1aCE4peqLu7DpCu0pj+qiDA4dc5c8I624427mF/JDbXZ/W/0ZhcXihnXmevG9fEHIf/PCXKQEmwf1au1soHzLR/LY4Uyj1ec9CXmPJMVC4TpQrCZQ22N0Bh1CFpIzK95WtNZ8maIvAtHcgN0iBc0Nj9h5hKhRvPkOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdIWSnK/E35GBcBB2VJSBG4ZjS59DwLrtQv76xNaKUk=;
 b=WpHplg1vPKNJxXLY7ecM7EbFuAStbGH9VdpTM3UzdSa06h6286+1CxcTZRZAvI052lhRu/13rmjnym5OolLJRcBHfYoWELHKln3Xu7dOdtfwWU0iaYVIFX7iHru+LbVVzkdDifrxU0K2tpGhfxXEqNhSi4uBcUC/KQU1WphUnjssaigY5yyYyZ67zHHNmX3qnab6jS1bj01rNwKKb+/NjzjrtWhpQMaueLo/k+J9iRElgq81LpbwYU1wnwmEL1XfNG5iGLb/aiCT5ezvU18H5Q1Agl5a/aOW+Cv8Yx4F//SyxVwMyRA2Vji8f7UtrC6UjctJA1MxJ5ydtD5m6eZS4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdIWSnK/E35GBcBB2VJSBG4ZjS59DwLrtQv76xNaKUk=;
 b=dGmuE7ByjH2puscAowwdK6DdhPKk5yhBSxsacJvlyikOcWlhjZAgFub5SP+dy8xM8FtNlPDNQHdXGTQ+hyfDlfJ++Y785Losh9zSaSNh/hGIKRHvfUYNoVOCiMWgIW9h6xOWrF1AK+OfobcuVjp5rZdMqNZYxBHa9qwI92cg7j3BZjaaIcG7vQCtieP9N4TtHgfJSLHKp2Qtp0eZUkb5sUAnInBh3C4WS6nHDgyYoJMIHonVyXQjpjvjEupfeF4G7XTiLOdtf270rnXztrzJD/CTOSJmTJNkBp6TjpNHgHkfH4jfJYw0alu9x3IyC9EmyrB0wlXP8qERipSfr3zPrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 04:00:21 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::8f:c340:8bac:c36d]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::8f:c340:8bac:c36d%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 04:00:21 +0000
Date: Mon, 3 Aug 2026 12:00:14 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net, 
	robin.murphy@arm.com, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] perf/cxl: Unfreeze counters after handling an
 overflow interrupt
Message-ID: <anARd0nTEQMiv4qj@MWDK4CY14F>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-8-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731232827.401447-8-dave.jiang@intel.com>
X-ClientProxiedBy: JH0PR01CA0106.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::9) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2376:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e338d3-ecbb-4bf2-9c06-08def113bcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|5023799004|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	J/yugqIq7pItUZBLoec6BFyoJB39uyj+hynqphNRyL9fpMIjCdLErRzOecOLjSwJYyuZzOpRVvB1xEcruTB8xV6l5k2X3PtH3925DVEuWisUdihtCBYQvav9Ji6beJR/6RXBF48lh8YtintXPEHD6RTxvrXxp7Vpe2RoQVXmDTA1xdBM8IJfMzVQ+LCfKURdiVIuMeJfGKAWN/AwM6SsspTlj5bCoRkrB3Kk5RjGHhKuHhtRMdZeUseTwmzOOyZLyqW1GSr4EubcWuVfKJ2X5bn3E8SkBYHVKtXlMKumZX3TYls9EXWqdElr1op5Id/PWZdNnIs/pNorncYiQmd8eYp7bGWdCHPn+XYKkPMS0ATAat6F2qWGxSquxdDKhaVXVmwlSKcs2iIQtPTM3lQZhq/9eFDXOYz/wSnBHvyKGuyGfQH95tzEfm2IQxzXdbwUCJ+4xvFH4+lqBWQVjKKnMl8fXmXhxmKvTHB5MoMOiLroOW78O7UFn62RYtMxEJ+ezjHqalwFVZTm398f1qr/HMtXGfk9LDk8QX2cfgn99vMPN9KRUH+VIEeL2aIQM7p7YEWqarDqt96E5/sKc4P4JtIb0l/pq+/fxi+I49mamMBMsqri2scTrwozmHpg+BgKWkULPjT0q3s1Ug1ALe2LfByImPaBYQkDjKxy+KxNm9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2376.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(5023799004)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pZo/mjy9xgnSyOv9b5eJWpyda/lWzJLwGva18Zf/HNijKHhXctcvax3QVjnw?=
 =?us-ascii?Q?dgx4ID773yiiPhzr/2l9vWHJ+W3T0GFRg9BylR9uyPQWj/DgZWDoqnlZ6YKz?=
 =?us-ascii?Q?Ik/UUcgfV6LDEopJNM1riv9o6pKcsmHgr+zbl7ogUERmwfLcpZAy9DbrXa1Z?=
 =?us-ascii?Q?ZtywLRSsmXEHW8EhhvA/OLRGdgy5yDetHPgOV1s+BELFGJvfdoTYxmCTVSN+?=
 =?us-ascii?Q?/vDBz+WYNGcJ9OOv1jhxCnQvwZxVt/77a0pe5Viw+ullVdFoopssXp6m30ww?=
 =?us-ascii?Q?Rws0XobCvz2VA2NhMRqr/lMxWYBmhsecjWK9oVQKkoOSgbRQbchyG9q8vkQB?=
 =?us-ascii?Q?X+joKGKJbwudaMwu52SWFWzOsUsaGX8KOjDHNjFy64OkJq3nbDbxqwKOjrAY?=
 =?us-ascii?Q?ipkUtJ0oVYYksC8a/bakTtczzsGeca45Q9CUxRvauPcjmKtFluBXxTW4xGj9?=
 =?us-ascii?Q?JyoytOP1cB9fukSmQ+f0OGve8fR+1zQE4AW+8bYVDKmzghNbrygSPUb6im2/?=
 =?us-ascii?Q?/rtpHr6N3aPbzgEmKeolL98qpTjNFLzLgOldnhSzRvQ1AbTxaYIG8LPdmE1Q?=
 =?us-ascii?Q?yUIGZfdOcXQWmeh2Va/KAcPMt5z6Hd67GFPy8reYI4FuIJkRNupRBxHbbzOV?=
 =?us-ascii?Q?WoDKN++tjHgVwrMGctSZwQ+WvEVEf5nCkoWeTk69GUDGt9ETSM+2oV+dPbER?=
 =?us-ascii?Q?x77Wjbiz8IBh7lqNvdgP1TlmFSSGCd2ZdXwQB22v9M80/gbJR7T1ayBnHuFv?=
 =?us-ascii?Q?DMeIqhPhHPNrsFkmJQd2uB/oMr0GC33Vsx32zFwfZKNyp3Eq4UBlClvn/rYG?=
 =?us-ascii?Q?ENBoDm1+rAGrCG3PAsYkXbcAEzS/f/w/m3ulTag4U4JuufsYkdZ2oTuA/6J5?=
 =?us-ascii?Q?toXmx2Su/39L240rz1KS8xntCFgHfQcU872N6XDEbUskvle4xLIp5QsJotAL?=
 =?us-ascii?Q?2GLcQnMfHoWkDftFrdsWEYR+koCUyEu6D75cSTkIWiJne4MT8y6pNOxtu0J2?=
 =?us-ascii?Q?IPathiAxFlr/pcaAc64nFqZqsQ5nW7eka+R8OgH/8TREyulBT5deVSRWzao8?=
 =?us-ascii?Q?9ke8JjueKMz6p+wYj4EF6ROFgLAoAb6FuzuwLSaNZOeeKl+1SWfj3VESeWm1?=
 =?us-ascii?Q?DFzacNIF7TpYAr6YRTq0hw8/OnYdgEVY4nzWsm25248nBSpKlZ6E+ARXc/TJ?=
 =?us-ascii?Q?jTSEha9ERc+EfQUztRsW/uXHmTdfT6uX0MozOz0zxoOX/QDb9QRmTZaicgfl?=
 =?us-ascii?Q?qjUGziW3hO/B+OyLa/sFMVPGGFGDBAATQ1tN1ogpdr4w5TPkrXRE41ceeWyd?=
 =?us-ascii?Q?DHKY6lQyW5vYtTcXjRZblk+XZnqxl+yDbzkfHnK7z+N47X05hzvjM11mJFHI?=
 =?us-ascii?Q?6R8vQ2HWS719VuMtKGwD4AcIehlz49Z3A2SeaSpmkLqi1iob3s4/oNY72k6x?=
 =?us-ascii?Q?4zYpAJPaCnYW900Q4D1HwTRVbY+oHg1CwHeCpY2H2O7wVgH+61BOuSSrPCnc?=
 =?us-ascii?Q?9001+UFWWZhrsrT7GjdssjFTCg2W+Yyd3Ss70TXnY29jKDpBGkP7h//o9ixS?=
 =?us-ascii?Q?ooBVgpe5ZHUcuVlGbQhVixJ9dsfsuaGNOHUzp+jv6vmcHEQjfzSWHOclS/7P?=
 =?us-ascii?Q?Ft4b82r5LFdyqKSQSKxJpxUiTcx18pw95Mzo3pavHtv1/9lf5UQDXBlxEbr8?=
 =?us-ascii?Q?inSbL3926ChsciLTS7KxH6lxVKdy6JDIgeaMpFQoEaZstJIk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e338d3-ecbb-4bf2-9c06-08def113bcfc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2376.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 04:00:21.5626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV84YlFqWhl9I5OGkntN2qR58VvqDBUWieKmKzimqO+QSkJtmIz97jpJws7GorqYYcRwqGHv61pidjon9TKvsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871

On Fri, Jul 31, 2026 at 04:28:25PM +0800, Dave Jiang wrote:
> The counters run with Freeze on Overflow set, so one overflow freezes every
> counter in the block (CXL r4.0 8.2.7.2.1). cxl_pmu_irq() reads the
> overflowed counters and clears the overflow status, but never unfreezes.
> Everything stays frozen until the next pmu_enable(), and events in that
> window are lost.
> 
> Unfreeze after clearing the status, unless the PMU has been disabled in the
> meantime. cxl_pmu_disable() freezes the block deliberately, and
> cxl_pmu_offline_cpu() migrates the context before it moves the interrupt's
> affinity, so an overflow can still land on the old CPU while the new one
> reprograms. Track the enabled state and leave the block frozen in that
> case. pmu_enable() unfreezes anyway.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Don't unfreeze if the PMU has been disabled (Robin, Jonathan). Review tag
>   dropped as the patch grew a hunk.
> - Robin also asked whether this can release a counter that overflowed after
>   the status read. It cannot. Global Freeze on Overflow stops every
>   non-free-running counter and they stay frozen until software unfreezes
>   them, so nothing the driver owns can advance, let alone newly overflow,
>   between the readq and here. Two counters overflowing together both show
>   up in the same pass. Only free-running counters move while frozen, and
>   the driver never programs those.
> - The enabled check is not a full exclusion, since the flag is read outside
>   any lock. Say so in the comment rather than implying otherwise. A lock
>   would buy nothing: pmu_disable() normally runs on the pinned CPU with
>   interrupts off, and in the one window where it does not - the migration
>   in cxl_pmu_offline_cpu() - event_stop() has already cleared Counter
>   Enable, so a stray unfreeze resumes nothing (sashiko-bot).
> ---
>  drivers/perf/cxl_pmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 6fdc66a01fb6..580a75bc9210 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -108,6 +108,8 @@ struct cxl_pmu_info {
>  	bool filter_hdm;
>  	int msi_vec;
>  	int irq;
> +	/* Set between pmu_enable() and pmu_disable(), read by the IRQ handler */
> +	bool enabled;
>  };
>  
>  #define pmu_to_cxl_pmu_info(_pmu) container_of(_pmu, struct cxl_pmu_info, pmu)
> @@ -596,6 +598,7 @@ static void cxl_pmu_enable(struct pmu *pmu)
>  	void __iomem *base = info->base;
>  
>  	/* Can assume frozen at this stage */
> +	WRITE_ONCE(info->enabled, true);
>  	writeq(0, base + CXL_PMU_FREEZE_REG);
>  }
>  
> @@ -604,6 +607,7 @@ static void cxl_pmu_disable(struct pmu *pmu)
>  	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(pmu);
>  	void __iomem *base = info->base;
>  
> +	WRITE_ONCE(info->enabled, false);
>  	/*
>  	 * Whilst bits above number of counters are RsvdZ
>  	 * they are unlikely to be repurposed given
> @@ -803,6 +807,9 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>  
>  	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
>  
> +	if (READ_ONCE(info->enabled))
> +		writeq(0, base + CXL_PMU_FREEZE_REG);
> +

The unfreeze looks right to me.
Maybe we should quote the corresponding part in spec as needed?
CXL 4.0 8.2.7.1.3 "CPMU Freeze (Offset 18h)", Table 8-183 - "Counter Unit
N remains frozen until explicitly unfrozen by software" .

I guess Robin's hotplug rework is solving the issue of cross-CPU check-then-act ?

--Richard



>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.55.0
> 
> 
