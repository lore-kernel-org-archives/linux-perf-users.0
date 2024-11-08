Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5201D3625;
	Fri,  8 Nov 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060737; cv=fail; b=O7RveKh3jXtMM0e2hNt5UJKRS3EUAfsP5INQCnL4Wi8gF8ekraSZ7sbZEK5WN6gGIga5U+xIZplDUobEH7f+6QlOU+HiwrrFR/uVL8k6k4qLz4kiuBwKhv0NxG7rKEAAZLjgfip/8coD8SLiB1wFeVDHRYOn5krhmlPpub5fFek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060737; c=relaxed/simple;
	bh=slyJMYd/7m+lkHOh2i8lSU8aTKr3TYKs/Xkvw7heilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WJONm3Ii9bz4utuNFA0ieujTsYPThVZE4+X3wX3jJVArMnT0RXjwcjqnWTH+iUtUx0a1ovX6jy/jnVSFYlK4fqYmft40iit0KXtyRLFER4Jjb3sPGyoRBkBzAx9Sb2S4GcnPtykDZyFhcEMHIwZN06fCDvnqTXuV0N/QE4S0Zk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tyWIROUF; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tyWIROUF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ak+5FXP7PB0swLZ0IRpmXYfN/rsyWMFoPfagkRC1/ejjFZABTDxuvT/GbVZFdtGo2beGIp8ZX6kG6Qrx2cPxGR4KBIpP6AsgiyZOGrQpAPf9ym+orOyr0RjMCfJtIGNTb6Z9kbyoAoabuQMKrYJmDzEFyv6U+EQzfS7sQ7EX1o8UpGsiB+tPnEa4rL1crATlH80Wwbpwug9eB09mDNU/2ZVsIjIEmYOGYJ2LHG2ZxIjnrJeQVq/COtqTGPeA182GuyrSL5O/QAvF0nN7mUCNnxgdpoKsJ8LVqcO8IYg1w+lO1wpVpcNuPK3+eD6BTAbTyhoQTZXaQUeBVnaH4hIG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOX5HKJ5HXpnbGEKbpJSyp4u0pqo2khfXxqxlN/mNB0=;
 b=KHwftRt6rJfsTfaQubC4D2PtCbEO8WJ9fX0sk6duWmrHGXrUMdPYFCBhMtBNC9Pp28Uj21EAC2fw+HT6YV4pQFnL808KNvCLrki6wF5e7k7FoiLf9jkpP9l9m3ctUAFkfk/o9Dryn7ZbiUsLO4glQYP/0/3G9AQUc6b22l0z+bGxuMFlEUsMMDJNzZjnY3aeyqHeGW6NSa8DuBDnAgmMnjN4J6OeXDw5s+lEO0Cpla5pYeCjnr9K9vVbxKB/SB52KbKkZmCgvRDFg8DnQS1tw0dpljftCsdk1d1Xyl/o3T7OvQ3fX0Q/4wVKBmioTNCi+LaegXMtg7FaQ3y41eVEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOX5HKJ5HXpnbGEKbpJSyp4u0pqo2khfXxqxlN/mNB0=;
 b=tyWIROUF2o50ODWE3Ho7EKrddfjzfTxkRyvWMY7I3mvjJZEsIjyOmudwyrtmnK2cL0XbeKLtNjWcGskD/yhvyxixKD3UYji1M5qllkN6WT+JOHwWW6lm2bwcx6AR6YIjsC+tjmT1GCDI2TUx4prLvL3fvQaXPLUMu3KTg82cDWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 10:12:13 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:12:13 +0000
Date: Fri, 8 Nov 2024 15:42:00 +0530
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
Subject: Re: [PATCH v6 05/10] perf/x86/rapl: Make rapl_model struct global
Message-ID: <Zy3j8MsUGp3+g4RJ@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-6-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-6-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: e495db6a-d7e5-4253-cb94-08dcffddd05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D6xIZ8fubmeVMzA9ygYl5+94iiZQiEdznsJOBsnV8gppTK+cxJiIVsLhHQRE?=
 =?us-ascii?Q?YFRBaUFyiZLk0r82XrnfEfxTAwNTORsIOQgr7Gq6cuhNEQeHyqGZtqGXCNdO?=
 =?us-ascii?Q?6Xu9Wru0UAcPcwqczkcDO9lIqSduFMxn4It4z2lEEuRNEBXPGBPFaO977svX?=
 =?us-ascii?Q?eiFpdSNOWUnRNfKIPsKmK1TcPzzFU0G0O3FyRpMmb00WSWFJ6c218mpEuDpm?=
 =?us-ascii?Q?3D5Evhl87+i6cxZe6hXTYuKBFcP6PoN3eaYcMyiCrfIwVrDzTbd1RmY/rWTq?=
 =?us-ascii?Q?Pa3Xt7nNPix8FHPKqpqh6uACENIBsQB+veDmvLUBHuOei2vIJWGOV8+7Ake7?=
 =?us-ascii?Q?DtmFE6fe035KOuh3hI1HS+eGPOEHv7zkRUEUJyK94O6GAB8aRgIBPIJSe4Vu?=
 =?us-ascii?Q?AEkW26MUQ8s28su7GNcHGkBGAx2iAMZ1mArcUWk+n4dZYLjp6wM0/U5nw1kr?=
 =?us-ascii?Q?jy8gGBwOeHyu3AjXGqJnGTYgegYhCi/ErRJu5Q5q1Aj3BOHXxZHKCp+b98WT?=
 =?us-ascii?Q?Dn0zQV0rRXIbhuv/uDTA25NPMFl9BdZTRd3ZeHFLf6r9F9D/SqurbNQ4RuSA?=
 =?us-ascii?Q?ftdpM3En2ZSkQhKGznle6pbmCQwn+8UPRHLFnhurqcD9Wddh1OH3o7flVtbK?=
 =?us-ascii?Q?31JA+/wUeCkSCKX5zWlD40WqDEvSN2bLCPwPLGDJ7Yx4mGlKgkWJaY7qUqIj?=
 =?us-ascii?Q?vEywxVS3mdHVeDlRLfkvowFunKvUI1NEouTH1B98GBoQwyo7KEJqKTtlIUra?=
 =?us-ascii?Q?7E0ohbZlJ8gXsA+LDtss2Lk6WejJFbNUmavkjq4Ox47qnfF/Cqx4kw0UfLOD?=
 =?us-ascii?Q?rRTMvG8coOO4vxIIHpS+UZwmiJrg1wC0lYOgs5QsRzF2YKRhC9T0t/ctQLZ0?=
 =?us-ascii?Q?hdd4OsAiPmybozLVGg/f+VU1fCwZD7QZGBLi60H+SrIZnrXDZ4B21lLZT814?=
 =?us-ascii?Q?GvQBt8HvC4OGuWhqxTavKw4j1iG5h14xnd3IrDvyUa1XRHV6v+vH2aQpXzzf?=
 =?us-ascii?Q?G1KVwUnyjSuo/TKfGmCD4DP6L5/4GLrSYH7adCQbbz8M9a6NPjHamX2orZ3x?=
 =?us-ascii?Q?VC58RMqtcDvIpCni16bNJ9PqQpZwQn8WvEP2DfEJWJByPWKGQCJAsmll4p0J?=
 =?us-ascii?Q?NKh3kzREDUO4IxOB93y+y2NCFTSr/riohdmmvZEI9+Lxu1b5TM6EK/8W51TP?=
 =?us-ascii?Q?sPAI2u9thhRCc5Kpr7r3FnEcfsotLI6zy5q92cTSX4nxGYX9OBOgmkozLteS?=
 =?us-ascii?Q?kHYLpH2m4X+8gHWKczwI2uEZlUSQPoRIQlUm+VhDNqhLFM95/sxl+sZ7nJ6a?=
 =?us-ascii?Q?ZrrYv8UQLvMUNjZZ5xGSIuWi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFW0+RyoRU+qg9mcrDhLZiN+8QmTQoZhDaIRKGh42wQ9azBNaikyJWCK3NTo?=
 =?us-ascii?Q?ixudlPI1l53dv6yy+F9DtSaeo0XWKPJZsAqv1hrwROgnnHqFU0NCqbX7IE4m?=
 =?us-ascii?Q?KPgjO1nXaBGIn053xikvKxcZmz1Ho6XkSvJ2RCD5bL1pQ/GeXCO1hkV1ohqa?=
 =?us-ascii?Q?0AwethYOVZOm/cizYPPAK7E4rlGJhi8PX1AtjGjspopLAfULyvbAICzaC9ty?=
 =?us-ascii?Q?K2ZC8ji6qZd8i/7g9UWCsVWgpHD9Op+hlTMtQSaoonRCqvj5YQH1VevTsFfC?=
 =?us-ascii?Q?AzDlimkf/hwD9inmzyfHxmJghWjvMdaXHfpc89Io8RBsgTqAVFHpJtzNlD3R?=
 =?us-ascii?Q?LKktXoaSBUtFUbLZ31sM8isnOIeyLhu1hFT4PHv8Z1qIv/mVX0hBNSGrMC5b?=
 =?us-ascii?Q?JMPctnbMZjy23aWLb13tCH4YbZvWMS5KJ7vp/jRg0MVe98JId/X452N+GTDd?=
 =?us-ascii?Q?U8M9y4F+O2nprhI53o1PiDSlx3OOe6OdtEBiw52HYKHJdRlBLutiyCGEhPXq?=
 =?us-ascii?Q?R+nB0JFrUClQF5XPeXBvCaruFoeL6Sd0SUR7vqptqqOUOxqB3FXMe+HrRQPX?=
 =?us-ascii?Q?ebBeXJ5A6jkcODQskxSxr56UuHuk/4EuFTzcBDxQ5dZ5vy8wp9J7wCTh6Ss3?=
 =?us-ascii?Q?u6YSXkHzeuBKkHFOAS4hKdfXHXR7o94Eu12llmHeBsFa1vxY+pcce+5GyYz6?=
 =?us-ascii?Q?o+vRX4wmINc/dV+EgETiSWyev0z+Z5ZcVOzCp3Ppj8ODNeTciNt7D28aXjQx?=
 =?us-ascii?Q?XRLypvy56RgibBNBXARSZreJ2TC6I515CGP50G3SLfuRUa6FXmsY3uUgpko2?=
 =?us-ascii?Q?sHJ4qwtR81F9dccMJrEmenKctreh0UW0TPgESwaFNH2WShlr3bQjiZpx8aae?=
 =?us-ascii?Q?fP5B9H5eoVMViHgqeosIvrxG/kLsU3AgWylOWUm3cq3AUvrh/pnupSJnImxC?=
 =?us-ascii?Q?T6wS9X4ttnKBpdtcTNtW0Ju4nqcC7uLzZX5vv4sFAP3MoUG3+q3IlWR49MyZ?=
 =?us-ascii?Q?M+rWhDZxGz80STEaQGr6KfPX5zQxoaccnswktDkdgyDBor63HoBNFIu1vSs5?=
 =?us-ascii?Q?Sp9Q9FC2zE4Vqs56ZYVIEAYi5faSOOn9sBPvPl2Kz9irj8iXHCrPW0SnVIYu?=
 =?us-ascii?Q?mAvufSoxwApGhw3YWcDfmE7L1UPBzVpeQAxJM8fEkR0MocrlSdaslUJyiAW9?=
 =?us-ascii?Q?nVkK7BjYvrTgX+J9QZt9fF7vCaODyicR2bT4jrVDdfLmGdu+d8POg9XyLfni?=
 =?us-ascii?Q?wMuzZrLIRPsoO8Ycw+nHHlf2xF0EXcL2Bc9HfmGFnrzVVwzf5l0/f4JQrZ10?=
 =?us-ascii?Q?1kYuGdM784Zg+iF5xeM5I168kp7mp2YUo1watLbxJnHNxp3OOmT8ksffIdhE?=
 =?us-ascii?Q?Flrv8pnkWUnLGONjU7+jFy/3VFzEjhZaiuUuQuWlbN3vpo96cBAPcUSX6P99?=
 =?us-ascii?Q?sA3FUU5U4/mnNTXS37s10d74OVILoeZ7294nkGifWcnWCrCqLT7yEl80QMYp?=
 =?us-ascii?Q?zqgjcBuZrepfjDB7H4FdhyY8SrPehlaSiwWYsYKPDKI3eJkq73XWcIyLs69l?=
 =?us-ascii?Q?FnrRjsfA+X/5EzFzidrwvSfFIvHsyQM9t2+cEZWQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e495db6a-d7e5-4253-cb94-08dcffddd05f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 10:12:13.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6n+gJHSNayJDC/xHXCbR0IqVICn2eYyihLTcJFnJXyZR26LHKMDr8VtmuBgm8SPjfFXSFidS0wywcKg0oYTIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

On Fri, Oct 25, 2024 at 11:13:43AM +0000, Dhananjay Ugwekar wrote:
> Prepare for the addition of RAPL core energy counter support.
> 
> As there will always be just one rapl_model variable on a system, make it
> global, to make it easier to access it from any function.
> 
> No functional change.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

LGTM.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  arch/x86/events/rapl.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 7387bca95018..447f62caa5f9 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -151,6 +151,7 @@ static struct rapl_pmus *rapl_pmus;
>  static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
> +static struct rapl_model *rapl_model;
>  
>  /*
>   * Helper function to get the correct topology id according to the
> @@ -536,18 +537,18 @@ static struct perf_msr amd_rapl_msrs[] = {
>  	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
>  };
>  
> -static int rapl_check_hw_unit(struct rapl_model *rm)
> +static int rapl_check_hw_unit(void)
>  {
>  	u64 msr_rapl_power_unit_bits;
>  	int i;
>  
>  	/* protect rdmsrl() to handle virtualization */
> -	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
> +	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
>  		return -1;
>  	for (i = 0; i < NR_RAPL_DOMAINS; i++)
>  		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
>  
> -	switch (rm->unit_quirk) {
> +	switch (rapl_model->unit_quirk) {
>  	/*
>  	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
>  	 * different than the unit from power unit MSR. See
> @@ -792,21 +793,20 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
>  static int __init rapl_pmu_init(void)
>  {
>  	const struct x86_cpu_id *id;
> -	struct rapl_model *rm;
>  	int ret;
>  
>  	id = x86_match_cpu(rapl_model_match);
>  	if (!id)
>  		return -ENODEV;
>  
> -	rm = (struct rapl_model *) id->driver_data;
> +	rapl_model = (struct rapl_model *) id->driver_data;
>  
> -	rapl_msrs = rm->rapl_msrs;
> +	rapl_msrs = rapl_model->rapl_msrs;
>  
>  	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
> -					false, (void *) &rm->events);
> +					false, (void *) &rapl_model->events);
>  
> -	ret = rapl_check_hw_unit(rm);
> +	ret = rapl_check_hw_unit();
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.34.1
> 
