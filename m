Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA0C18BC36;
	Mon, 28 Oct 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106127; cv=fail; b=r7IEhLrcU8H47R+UEwfNYhNCAehRcmS90qOrVBSktNECHf5gBH+xXymkS0PACoCjDncan1nLGw+usJ3PQEKq4sQE+3Ni9GlEbD5M832ErmCvAigSNcGHge9rfJ3scTptNw9bJFfMFdndn/vU0z8DcEFFi528aCpbxLocjoWNO9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106127; c=relaxed/simple;
	bh=yedPqOL66rXfgKZubF76+ZcasEYf4yObgC4pXPjZwu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jkcvCCa6PlOiVYJcQ1e22sMVkWPynNMSz+W2534/Np+dCvTme4of4HazooC+sq4Mzvp1pkV+sYhL5yP/mtp+gQf3Jvn1e7dIeTlbSl3uBiE/a03Ua3dogQP5ChIWn820bemeD+JI1J5L6Uhax1+Fps4UmPz+GpZSli1ENlPUza0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H2eXlmie; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H2eXlmie"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXbNT9yCHM/COYeyM+CG3cvCKx4+eVcDRwNcoRFL+mMgLRFzA0ZswUo9J/lty14xQCDdTqIEHx+khpRa/mpw2Yub3b9sKeNkP0aGTYNZxUSYHmoEgSfpTgRiUs5iEsQdftqOSx6smnmvDqKuRN+bOJYRJrdFCmZ5B7shUS8NB+P18IBEddw003OYD1EEvlbv9YwtfKBHs+4pJtPRflBfxJeUkHWqyQ+6ghYURw7MyF6gF8r8zzFZJTMEsboSpuA4t+ShV06UwsQZGgE9aR//NzspTtbJ2JXc1UwQSWBLD2GVTPIGfA1F0kGBWFUuiP5kRdbB4cFGtz3itLLdoiLLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVFwItqY6jfjsHmVKsTogQzk/YsX71zjeXMemLKyPv0=;
 b=X8AQjAP8jPfh93+H/zazcEg9lG+rk8iTyC0OeQ0NwhWplte4g42Ssa+omq9tDlhFqb6htVhrHZaKLdfnZGj+SpG8gROmENrY/DmOvFX22oU3cZE+lZePL6+z/lWV2cCOSQWhs+rYQ1bchrdrku41rgBUJ3T/XeOsIq4yXQFyxSize31zitf9M23kCsS3+AhjYigQlsHuAGOjQoUUSpdrw11eQ59BlpoLUr07NkOTAqmqSxAaTSNoFLOX/BSn2e/kZ9s1oKSdGO8tyzZGEmJSlE1/CpSigDaDKBs0WHtia4uJhIvDHhXpGClb+kDku1YIinyK60hIcE8WqL+/l7iD/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVFwItqY6jfjsHmVKsTogQzk/YsX71zjeXMemLKyPv0=;
 b=H2eXlmieyMxrovpjHhYDi5SE+yaUf7ab+Y2RXc0B32ifzUkIJecLROQh3w7nmXqUOp8qknyAUzZNtC4PiWL+HDAki9v557zhJ85mpYlRlpFauBvQv7vgNBRSNAy8ikXgJyQerJoxT7kNDjwvewteRTWtqyUGmjVy8Tbq48nZUNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB7665.namprd12.prod.outlook.com (2603:10b6:610:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 09:02:02 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 09:02:02 +0000
Date: Mon, 28 Oct 2024 14:31:50 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, ananth.narayan@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/10] perf/x86/rapl: Rename rapl_pmu variables
Message-ID: <Zx9S/lb7wcns/VzF@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-5-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-5-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN2PEPF000001B8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a564912-5341-46ee-b570-08dcf72f2fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9iFRQWRadP+wM4UUS3jIV22/5jAyTryVTcH9ol1icnZdHFVVhLvGyBRRVRV?=
 =?us-ascii?Q?OEcNoSXYvN/zhtUop/Ibv2HHGwnmq4kAX9Hexe+eZQiWjEfhjEeJk7WiIoJF?=
 =?us-ascii?Q?o4i5kez524z9173mX17rnxZ3jC5LG5A5MJNfA+nmQBB2CnrVSfhpjlLRwt2S?=
 =?us-ascii?Q?TCqHUy+Z3KBCORaov91xUmJWVopsXZ73ynszibLrCeN70JcJ8sz4GfoJ3p7y?=
 =?us-ascii?Q?+6XcezjWno9lHrKMKfrDHA9lV4CY8i7IKUzswjAdRLoxRo7Qz430qV8dG3bG?=
 =?us-ascii?Q?6mshXLjDmeS7MGFr+kSEEtJSZ4VPy8tUvQbtxMMS6xC0k+1SU4pWz5RuXvEy?=
 =?us-ascii?Q?s/2nSUEUyG49KHPKWkngDz42kSPM/U8c5ZDNO7eS3XNMZ2tdwaBp4kVbhqxk?=
 =?us-ascii?Q?jwLo6tmr8BFRvNSQT2uhtlXkXACX7rnbzNLTEVUSmYltPFHxgXczOi8sqqgp?=
 =?us-ascii?Q?UofAx6P60gwcHp6ll8/ZHhqi6ozPGvL52anySdbOJKvd3Ub/JrONMsbzQtnE?=
 =?us-ascii?Q?N0jyRuiib9DZYLz18zC5bWr4+eLS3b6KUIzpVOMVf1Eye22kJPRShoeLyu52?=
 =?us-ascii?Q?rD5ilfX8qq4qZ9Er6iJ6SXIXFwfwb7+fpBSQncpN04oAXINw/PUYUPrHuRDl?=
 =?us-ascii?Q?hQFFKs9hX1POa4cN4cINWnmbQynu0alWnzXujQ+vIxq0tXlsjf2zDybbcrdC?=
 =?us-ascii?Q?E0rkeYnnCrNglJRc0gb5sePur8SoBB6ARrEIM5ZUon0lN7VmSk2Z95mZMr9R?=
 =?us-ascii?Q?ETPgGPJwb2VnFmWX1Yv3tfrI9rf/hheP3rsFAF3/QWCoGmDu5umUdJrsl3Yq?=
 =?us-ascii?Q?lFtqr0Emrm+x5PX4RPdmy9KCqVpZEYsdOoNruKhr2hRNAvQvR6meWnpbxSQz?=
 =?us-ascii?Q?hOyM6KP+/ovfVU3ew/YKmRs2GfIrTMPFXZf4xJ6ROQo01HtG7j7oEMqrUcwK?=
 =?us-ascii?Q?FZTqJhTn+4n0SCm6Kx9HWaKqo2rCiJrlpcMC386WxseIi07+1E5KP3ltEnBv?=
 =?us-ascii?Q?ihGKEgPbHR0w4PO+JvI0xQAl/TjGqM3pxOElTKUMkhTWtWACmbwIEMvkcpP+?=
 =?us-ascii?Q?xZ2iZezT0hPZVooSnPljGAq/fQ1qsvgeAHKQL7zTyt0KJ/J/FtH0NmhY0Ojv?=
 =?us-ascii?Q?jRYHS/Bta32Uk1B20KUem6GNSsr4sRUXsJWBPmmNfFn7hfYyfADGN3kXeCkN?=
 =?us-ascii?Q?35eH7XieGVBPeU5QOq55ZWGgbt51jAWXlTpeCm//mRvIEOr5JslEl5mp9PkX?=
 =?us-ascii?Q?EGGT1BZsA968ZePViFX6Oz5eUv0lQp0BROxAxFGmWd6h0ou0yLr4YQbUkc7N?=
 =?us-ascii?Q?dehjrJdsgYI4NpCwW4XK65QI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wFhP5Mbl33o0h8VgQG25I3XriueI7X5oxsoo3FUGNOzFBYnvCbQhQIm36BQh?=
 =?us-ascii?Q?whOUujLXFoemO/cVebko1e6QgVRTJfx9pIGUaWCoQ/xmpeweSxFIdBYLkxVH?=
 =?us-ascii?Q?LdRZFIYGOXi6yr/VELlKK4WOr5lv2kMVkRXEBMTbhLOH1SS+xALdltX6SB8a?=
 =?us-ascii?Q?twIRamTccrI0cF23gwFIiE78rhOxR38GBsRrF+oZtJ/I9zhmPzN1Giv8opyG?=
 =?us-ascii?Q?/NmjQq///DKnDB2UKaO7rdCLRiGuE2YM3X0rwthTPEXDzagXepbLZ6jm9Yc9?=
 =?us-ascii?Q?Weya5XjhsT7gbdqstAp5nKb9YuPWHuz68qdW2vINACgUN22yHf4zxB02V9Ok?=
 =?us-ascii?Q?zfNnKkyeJTUCpoOpvBmtGcCL1bsME7M+yrJnlXjf4ZV4z5rcCRFF1Nmd451D?=
 =?us-ascii?Q?AcrRtgaEb0EwvbtyTH73rcKDy7byW881VeRd15rLkRsXQ6aXccEjaqNDrql+?=
 =?us-ascii?Q?jHK21GOkd4bFniPt+1DYIaPLAAn1LaTmOAt7tna7MVWel7a+7Jsk8yFwS8IN?=
 =?us-ascii?Q?Cuf+xyptI8FlD105FTgP/uzw/DysEZ9z0wg7crOCuTdX3ySupH/luxSeIfVW?=
 =?us-ascii?Q?9xTB3FjVWZjYIz1XwIB9FmqummhuJQkFOqC0cMSv0vVxD0GxA5aJAaOOpBvs?=
 =?us-ascii?Q?LdFTjXQmt+0DtVo5aajL9hZAuJJB+wwYGk5QEwo70E2WN+npuqbGiJXke6KX?=
 =?us-ascii?Q?UYIwoFA0yke1MnvzNBCI5ofbjjpl4149qIbP+Wbp8BDMm1YK1G8a1MIzQC1O?=
 =?us-ascii?Q?V9wQOZBJnOl127PKWSBSS3aOr9NdpebLV8hu+YygUVoU3ILtcRXtXGbXJJ0e?=
 =?us-ascii?Q?aEyCBtxNOOh0qphNUzVk0N2zgTIfjPbLGIXlWERvYFFzITBrIcId+0Ybi65z?=
 =?us-ascii?Q?4twPKy1FO1rHpM4jckATjofsOcnZFfh8ZxAKJZ93EpSFACbHAvpjQpy7jqSt?=
 =?us-ascii?Q?EzMrQW8judPY1iKbD04ggDfw8I/5tQCnW1rB2WzXlMG/GsLe8ySiIzrhlPpK?=
 =?us-ascii?Q?LHm0wh5pIDLX2BEObRic0VViZslSjBMbjpBZBjpgWypvG3wNmLYlsKGxhO55?=
 =?us-ascii?Q?z0AKJTQ2ZGuarxJ4ufuKxLUKZe0CFUXPKGewXllMsegau2dNhdxxAgv883ur?=
 =?us-ascii?Q?GcxE6xxL5Eivub58VfFe2IRWZkgV76mRw5Jo0jJWbtpd16OHOlJFstX66MRL?=
 =?us-ascii?Q?xii/2umlgChZ9HyOB+egKS7+vygngn+35b6nkcgJDD+hFFDfGyZe4Nt/SFOv?=
 =?us-ascii?Q?hngQsNleLlyj4IUNArTt4PupxLjE7o+OqEQbvhPzqpFHlAyPhHiFeFpPP9ZR?=
 =?us-ascii?Q?hH/wkjtMkBMKc9+kcw8boKUd5+2gGCthe/Yw0f/3Y+FOBAIkjK+NYEyR0tVk?=
 =?us-ascii?Q?7SZdj7g3KmWzSsvduzZJlw5rz6dz9Scx7oBi5iRVzViz7DjCwigH7gCd1nvA?=
 =?us-ascii?Q?YsGzdvJBqcPOzaq98sAZoocD6+R3IUeIwcBsIYakhHxpr+pzsIBeU8FQD7Cs?=
 =?us-ascii?Q?SaOEogxonkQiWK66ND+q//awS8ryxdFvB5idlQ/1zGUa2Kk+QbtqMOJykceK?=
 =?us-ascii?Q?o4IStXYP6z1nSbQKX+/JeOkclNGuoHb/H+nXy/a6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a564912-5341-46ee-b570-08dcf72f2fff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:02:02.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGg8ZHUZGJrpH7xSIB5sQwdqc6tyBkTfqqXph861Hm/mvdvaxqaz/0O47cCQDuCc7xWZl8KJT89wO/jxuOXB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7665

Hello Dhananjay,

On Fri, Oct 25, 2024 at 11:13:42AM +0000, Dhananjay Ugwekar wrote:
> Rename struct rapl_pmu variables from "pmu" to "rapl_pmu", to
> avoid any confusion between the variables of two different
> structs pmu and rapl_pmu. As rapl_pmu also contains a pointer to
> struct pmu, which leads to situations in code like pmu->pmu,
> which is needlessly confusing. Above scenario is replaced with
> much more readable rapl_pmu->pmu with this change.
> 
> Also rename "pmus" member in rapl_pmus struct, for same reason.
> 
> No functional change.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

This looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
--
Thanks and Regards
gautham.

> ---
>  arch/x86/events/rapl.c | 91 +++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index d20c5b1dd0ad..7387bca95018 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -129,7 +129,7 @@ struct rapl_pmu {
>  struct rapl_pmus {
>  	struct pmu		pmu;
>  	unsigned int		nr_rapl_pmu;
> -	struct rapl_pmu		*pmus[] __counted_by(nr_rapl_pmu);
> +	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
>  };
>  
>  enum rapl_unit_quirk {
> @@ -223,34 +223,34 @@ static void rapl_start_hrtimer(struct rapl_pmu *pmu)
>  
>  static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
>  {
> -	struct rapl_pmu *pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
> +	struct rapl_pmu *rapl_pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
>  	struct perf_event *event;
>  	unsigned long flags;
>  
> -	if (!pmu->n_active)
> +	if (!rapl_pmu->n_active)
>  		return HRTIMER_NORESTART;
>  
> -	raw_spin_lock_irqsave(&pmu->lock, flags);
> +	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
>  
> -	list_for_each_entry(event, &pmu->active_list, active_entry)
> +	list_for_each_entry(event, &rapl_pmu->active_list, active_entry)
>  		rapl_event_update(event);
>  
> -	raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>  
> -	hrtimer_forward_now(hrtimer, pmu->timer_interval);
> +	hrtimer_forward_now(hrtimer, rapl_pmu->timer_interval);
>  
>  	return HRTIMER_RESTART;
>  }
>  
> -static void rapl_hrtimer_init(struct rapl_pmu *pmu)
> +static void rapl_hrtimer_init(struct rapl_pmu *rapl_pmu)
>  {
> -	struct hrtimer *hr = &pmu->hrtimer;
> +	struct hrtimer *hr = &rapl_pmu->hrtimer;
>  
>  	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	hr->function = rapl_hrtimer_handle;
>  }
>  
> -static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
> +static void __rapl_pmu_event_start(struct rapl_pmu *rapl_pmu,
>  				   struct perf_event *event)
>  {
>  	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> @@ -258,39 +258,39 @@ static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
>  
>  	event->hw.state = 0;
>  
> -	list_add_tail(&event->active_entry, &pmu->active_list);
> +	list_add_tail(&event->active_entry, &rapl_pmu->active_list);
>  
>  	local64_set(&event->hw.prev_count, rapl_read_counter(event));
>  
> -	pmu->n_active++;
> -	if (pmu->n_active == 1)
> -		rapl_start_hrtimer(pmu);
> +	rapl_pmu->n_active++;
> +	if (rapl_pmu->n_active == 1)
> +		rapl_start_hrtimer(rapl_pmu);
>  }
>  
>  static void rapl_pmu_event_start(struct perf_event *event, int mode)
>  {
> -	struct rapl_pmu *pmu = event->pmu_private;
> +	struct rapl_pmu *rapl_pmu = event->pmu_private;
>  	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&pmu->lock, flags);
> -	__rapl_pmu_event_start(pmu, event);
> -	raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
> +	__rapl_pmu_event_start(rapl_pmu, event);
> +	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>  }
>  
>  static void rapl_pmu_event_stop(struct perf_event *event, int mode)
>  {
> -	struct rapl_pmu *pmu = event->pmu_private;
> +	struct rapl_pmu *rapl_pmu = event->pmu_private;
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&pmu->lock, flags);
> +	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
>  
>  	/* mark event as deactivated and stopped */
>  	if (!(hwc->state & PERF_HES_STOPPED)) {
> -		WARN_ON_ONCE(pmu->n_active <= 0);
> -		pmu->n_active--;
> -		if (pmu->n_active == 0)
> -			hrtimer_cancel(&pmu->hrtimer);
> +		WARN_ON_ONCE(rapl_pmu->n_active <= 0);
> +		rapl_pmu->n_active--;
> +		if (rapl_pmu->n_active == 0)
> +			hrtimer_cancel(&rapl_pmu->hrtimer);
>  
>  		list_del(&event->active_entry);
>  
> @@ -308,23 +308,23 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
>  		hwc->state |= PERF_HES_UPTODATE;
>  	}
>  
> -	raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>  }
>  
>  static int rapl_pmu_event_add(struct perf_event *event, int mode)
>  {
> -	struct rapl_pmu *pmu = event->pmu_private;
> +	struct rapl_pmu *rapl_pmu = event->pmu_private;
>  	struct hw_perf_event *hwc = &event->hw;
>  	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&pmu->lock, flags);
> +	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
>  
>  	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
>  
>  	if (mode & PERF_EF_START)
> -		__rapl_pmu_event_start(pmu, event);
> +		__rapl_pmu_event_start(rapl_pmu, event);
>  
> -	raw_spin_unlock_irqrestore(&pmu->lock, flags);
> +	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
>  
>  	return 0;
>  }
> @@ -338,7 +338,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  {
>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>  	int bit, rapl_pmu_idx, ret = 0;
> -	struct rapl_pmu *pmu;
> +	struct rapl_pmu *rapl_pmu;
>  
>  	/* only look at RAPL events */
>  	if (event->attr.type != rapl_pmus->pmu.type)
> @@ -370,10 +370,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	/* must be done before validate_group */
> -	pmu = rapl_pmus->pmus[rapl_pmu_idx];
> -	if (!pmu)
> +	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
> +	if (!rapl_pmu)
>  		return -EINVAL;
> -	event->pmu_private = pmu;
> +
> +	event->pmu_private = rapl_pmu;
>  	event->hw.event_base = rapl_msrs[bit].msr;
>  	event->hw.config = cfg;
>  	event->hw.idx = bit;
> @@ -600,7 +601,7 @@ static void cleanup_rapl_pmus(void)
>  	int i;
>  
>  	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
> -		kfree(rapl_pmus->pmus[i]);
> +		kfree(rapl_pmus->rapl_pmu[i]);
>  	kfree(rapl_pmus);
>  }
>  
> @@ -615,27 +616,27 @@ static const struct attribute_group *rapl_attr_update[] = {
>  
>  static int __init init_rapl_pmu(void)
>  {
> -	struct rapl_pmu *pmu;
> +	struct rapl_pmu *rapl_pmu;
>  	int idx;
>  
>  	for (idx = 0; idx < rapl_pmus->nr_rapl_pmu; idx++) {
> -		pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
> -		if (!pmu)
> +		rapl_pmu = kzalloc(sizeof(*rapl_pmu), GFP_KERNEL);
> +		if (!rapl_pmu)
>  			goto free;
>  
> -		raw_spin_lock_init(&pmu->lock);
> -		INIT_LIST_HEAD(&pmu->active_list);
> -		pmu->pmu = &rapl_pmus->pmu;
> -		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
> -		rapl_hrtimer_init(pmu);
> +		raw_spin_lock_init(&rapl_pmu->lock);
> +		INIT_LIST_HEAD(&rapl_pmu->active_list);
> +		rapl_pmu->pmu = &rapl_pmus->pmu;
> +		rapl_pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
> +		rapl_hrtimer_init(rapl_pmu);
>  
> -		rapl_pmus->pmus[idx] = pmu;
> +		rapl_pmus->rapl_pmu[idx] = rapl_pmu;
>  	}
>  
>  	return 0;
>  free:
>  	for (; idx > 0; idx--)
> -		kfree(rapl_pmus->pmus[idx - 1]);
> +		kfree(rapl_pmus->rapl_pmu[idx - 1]);
>  	return -ENOMEM;
>  }
>  
> @@ -649,7 +650,7 @@ static int __init init_rapl_pmus(void)
>  		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
>  	}
>  
> -	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
> +	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1
> 
