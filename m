Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816401DDC3C;
	Mon, 28 Oct 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127313; cv=fail; b=oL83BtIUOFyUZQ++abs+MViVqmjf4jXdoarCkChYie1oLTy0gu3VN/k9Cu7EBk1Dy0hd5gL2hcuHCSnvPMji0G42cy9rbmQjnI9b0mUaJzs1jqLnX99cD8bRwRJscoiiBGOubCIx9vrBlomglI2MXgqtkcf2zKFOvoCjQDQTACU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127313; c=relaxed/simple;
	bh=ZL0lwXSlkIR1076TYdsgS7xZ2gJzdtEiJ+3zF29MZXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=baz9sWxg/W/tvHLR9R2pJQ+DGFSPMGjE6czegKWWjWMAc5L3BabddwyOS+ZG9lwOgU5uqBppVxGqef/QJY4qOAvOozUVxjOGvOVkAWl/opw5J/TjjqJNbjEuRO2DX1iCIZyMceU67QkjFQuB854jdMyGiezlhm6jdT/npjNSYQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v0wQt+xr; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v0wQt+xr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb5s2pcvCZeabVddJJXtZzJmDrPWDy3tSqmrK+7s/0Q54jtF+kIAfnBuZahJTFiKLBuxVmYa+lfGbSw3WAFr25yHcqFJ/pUmETkvHf2VYB3pITUCqASACJudRgc4nz3PM6omQDozC1Q5vm/DPfXQANWe6yRhbSynjueGIBVv/zpwo7jB6HmcjfK1A0vOiSbadS1qg2PBbCAjoHnltU61m+perFI8yufc5jXdTOUFEXPWOFYxabOHY7IgbYvWW3XNBWJq4lwLnlB88G02b7AjLknf/dj8piECVM9wldse84OWFMFk9THGE8LJ0l+6tm0Uj+1kMuosYJ2SwIKDQUrqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gJ/rkNKTJ1xEd5yvQ0UYwSfkE6pwCp/bUZ9Qtulp5w=;
 b=K+l5JTmrKqiTj6T2sDVPoJF8/lIwyYbWP5WOfhhrH7U7ImDgbtCGzS1OljzIGPVTFv+5UFnofTfuTB0up72ald9g9/4ktztPvdZYFH63RzrkL6Dzg0mcOy5+MjOco4fj3fjXWbLeA6KZXCbNvtpsCIoxMnz27dKUewgZTocHZKh1pXxpQzB18OWDx8gLpGKuaBhYsWV+YA/2aYfycWIfKVQRLn9xmZDqwUCUgCbb74jNa6R7puNLFrjoBrhMrwzmz0ywaqCB8Edl3dtmlh5fu5uSmZzzPZ88ZN9oFi/S1k4rKyPV20FQVYIoAhj7MY4Zoy21JMWc4qGm24U8kaokpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gJ/rkNKTJ1xEd5yvQ0UYwSfkE6pwCp/bUZ9Qtulp5w=;
 b=v0wQt+xraLj9jqMCWvBXWWUbX/bGBAGXwbOEMQBteLCZwHRCbScXCqHi+n9/Q0cNlb6LInsmlfIteaeyNsRNQL9JKBFAIqduHh7WXv6LOqWCpp1lk/YaP3t6xOORgSRjSo0ZUJdW1k2jNp6SUny5j1QQKeO8+URJNNi+FWTB98U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 14:55:02 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 14:55:02 +0000
Date: Mon, 28 Oct 2024 20:24:47 +0530
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
Subject: Re: [PATCH v6 09/10] perf/x86/rapl: Move the cntr_mask to rapl_pmus
 struct
Message-ID: <Zx+lt4KZXGNWSsEP@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-10-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-10-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PNYP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a27db3-89ea-458f-c2ee-08dcf7608028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0UySGkSYxTAt8+b8LGwtXy5FojUYbMXTz5//TDdmivPrGZfzErxZw7h1/MiW?=
 =?us-ascii?Q?4Jz8EOc7sA8Ts9Cxex8yber5ZWKQ67/UiL9r/s2dEKpqcSdXvqE/C5GZvMuy?=
 =?us-ascii?Q?VXxQVaBi4RCxS5aW4YG+u7lQkLHSp94Yrv5b0eDHUWJDqA/m1XeotGYiztL7?=
 =?us-ascii?Q?NQlFu8Ln8tTSEvb/v7xjU5qFhTcs60fKsbWTiKRwgQT5p98Bbta7A712U/SJ?=
 =?us-ascii?Q?lmOLVFxgw/a3+QJvUomQOJx3l0uzj4Cb4U4z6MkA640GRgOYQWSTb6xUf6HS?=
 =?us-ascii?Q?DzIyn738/XmuIDnaGPc+ojcW9lPxNAk6NcXY9ycqK+vOIkVlm8pDa85JSTuX?=
 =?us-ascii?Q?bdKEER8h6zMSB2l6lDORMoEUKPODu4ljE8AuP4DCFTpM6/Jt0Vh6xFsfbBlc?=
 =?us-ascii?Q?/5RymB6782f/aLpeX6r33zObGteMDITLMgzR1Jb8YQYnSugrv8+NEWqwQJUk?=
 =?us-ascii?Q?TJtZq/gELdbDWPlUQhZSCz7J5/oDcXnmX+Um88tFAAhF689Q1B0qqWnj+M9z?=
 =?us-ascii?Q?kKkk1sMI05gc7vq9nBXaipZG2xJmIciHlXyrZ8wGYEgRRrpJZ/CCQH0gZyZZ?=
 =?us-ascii?Q?bfmWpnkdp43tarW7n7OR7cPOv9uZp0bx8WAjSupA6KujBc76PyAWr2TtJFh0?=
 =?us-ascii?Q?jhGPfbC7hwigxjLMQ31ORTnEXLfeufb/Il02DvP9o8YyrL94bRGckOnaKb0c?=
 =?us-ascii?Q?k0RBShvWjb9NDipzT6e/ZNekmufxe//CX39ddv7w/1v8SWjz7h6aKZqbzXMQ?=
 =?us-ascii?Q?iQgQ/ErJ3tmBJ7i2umDTfgAi53UpyGpcXMwoQZBQY8MFrEvqUzOa1WuTK2xV?=
 =?us-ascii?Q?fWIjUviXkjtS+8De4mfjWNxrUlFJ0onbwvxsqOgs7UlM8A6wuZVA9R0p8X+b?=
 =?us-ascii?Q?PUOajm43pKDvi342l6E0npGi1d0puUD48s08K6jZq4ZepuXA/5PuXxCpy2b8?=
 =?us-ascii?Q?6wsfyb71Q+kiUyVLC6FXsd2Ugm8dPse4ZSBwr+Cn0ja4mr4F73D9XV5eoMlH?=
 =?us-ascii?Q?I5mkyNVakiONXgWWrE3agUKo4NtMuTYYQSzulZulxUclvSfg0tjy1mhHv3zI?=
 =?us-ascii?Q?VWoND4I8gpwCuk8T2o2zL+wzqnJclFvLqfYuL74DrOYgj+cs4QiPnXCSV69O?=
 =?us-ascii?Q?FP49hP3bx2N696NtBzlfAQ4L9bJOP9y51kE+S/EkQz522ftdzdJCo/QaPuy+?=
 =?us-ascii?Q?WzRNTOyPA1aQBJgkjcXtPGQY4h0NrMEcDrw0FO1v2nRmDBA/wyHzARhrlPe2?=
 =?us-ascii?Q?5xTttcsRxlMXRAsKeId9mZJIu6r2Ey0Q9J8aneqAYkwilhVyctVh4U4Qid8V?=
 =?us-ascii?Q?gG6T7Cd2UsD8HlUH01dQtzl3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZHarxl3pakINHtbNdB4vhWyAaxRUXByTl4QhwqZNWsTBwdHKwdA4VTrFJJ/?=
 =?us-ascii?Q?P+P1LfYitiIAcHbTrwv69q3K1nRin8gC3ZR5HVpNySciWuIgbCQ+1Rvcae5v?=
 =?us-ascii?Q?H7XOrvuMPGQ9S6XbRcCkoElkG86pAi+3qeQ97OWNYweuyDYPlDeiXOvBW5yp?=
 =?us-ascii?Q?uzQLED9hlppAm+G2XeAJkjUYxpksaZU8kFJqKWRqMUjDi5tAWub+AAg/JgXU?=
 =?us-ascii?Q?eeriy+c6EZ8YXIUXHSTOwUaoawJAjQj4/JHgw0B77TdsZYlr1WU5GEJrjGc+?=
 =?us-ascii?Q?WMxT0aWUPrR2Sj5Cp6kx/mqWJRtW7LFOB93dmBQRn9q2xKaGTGckFgaipyR5?=
 =?us-ascii?Q?b/rnOGD35PoJvdAmiF1lWomQ6PqOB+MZM8IdnQbzdyy2r5XyYGOTo3nDteDk?=
 =?us-ascii?Q?ULNBZyWgcWSuXKFwu+G5aYIfm54PlMexWZHS1a5ByMVaBjpWvaHlXsmca+2N?=
 =?us-ascii?Q?fOucyuM4rTnnIud7firDWXXIMXbtkCjaR4zpa/HXi0DlqL1kgK/r+QN46YLj?=
 =?us-ascii?Q?Pm8pQDjkijY6dqdWwvTPEAA/eAkYRGKRxSnA5YIV+fdCvUWhrJ+/l++QzCO1?=
 =?us-ascii?Q?GApHwXfmcwEfqJhPsSLosaENvUiK1haMGOFFttoYVNAteKIPr6h3bhc+IwkM?=
 =?us-ascii?Q?11OmmMkzi2q3Gnfls0a0hUmUmcLHcEer4DAG+w7gdDMjZHcDBH46YoWB3G1l?=
 =?us-ascii?Q?CedFrkTpRvoeTRBtA/dJhwRjBu3S2CJCLrNG4x3HLizUDAHAJP21cGpWLL9U?=
 =?us-ascii?Q?jguYQelm3v+AwhulCMuyxt+M/5TSjCVDrTP/VGxNaQ1bw2iexwZENGHb/5gB?=
 =?us-ascii?Q?nwpE51IUzXt9ihyVx2svJ/VjUlj/PkYJ2roXTnGaGAXRKtlEbovSmMvMmbPa?=
 =?us-ascii?Q?qwtJyPAEdhvyn4tJZ6TvejVh25mhCAASMGzaQhj79o4gnB9rKiRZFi6blYPV?=
 =?us-ascii?Q?F9Zdf/RO50dwMnwLxG+V8clnwZjOfYqe2Xxxu9G2Zv/TkquHGbdjzt+POPlY?=
 =?us-ascii?Q?IOcpREqIU85EZqw6hhjf8Z+El0sW0d0AIfVY/QJSuAZnk79jjgNzh0vqnZ9s?=
 =?us-ascii?Q?cV9yHfgAiMMX5dJ3TXxu2KluaHGo0q5lbapvsZpQbaN8gEnLtVMdE4mFrS7J?=
 =?us-ascii?Q?It1cGgjyRqTwyQcQ2oeietxfhCwltoACZDzv+LGU1JmL9LCEtOaLD5dVirMA?=
 =?us-ascii?Q?CSybZcVoNJYwwGikprRDAPcXEJAU/U7cxs81z9mf8tpppMpTw7MzqyV4aInH?=
 =?us-ascii?Q?ibGtOiEWekew6Z1pVSoVIyn8vrXeW0ytPrV3ewfD7ePc89LQp0OiflXpTzPd?=
 =?us-ascii?Q?qSk6AiexZd6kZWm4Y3IYVe14sdPlfli5ylrNXwPtdLcpOJ90EBnEsdwi1DwK?=
 =?us-ascii?Q?tXYzLsX0d8BAA0Wp3597MqiFT+6j90dXRyqDcq6Ng3AOx70737aImdpoe7Oz?=
 =?us-ascii?Q?IblCo8tl7/+fxRcSht6O+I8++uGpVPvyN0UqVXaeVDEZVMvHnoTgAdoT2xCy?=
 =?us-ascii?Q?eBIzxBBUFoJuQftxHoKgz9oYbzZvmSJYpg2CXUrgkDylflSkJj9xDK9g66eG?=
 =?us-ascii?Q?rjqHmuybEF8hpnv6fnph/+RTLGX7YOlYmnSW+Sy9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a27db3-89ea-458f-c2ee-08dcf7608028
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:55:02.0589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvbhNeI2362RA+SGNu+hW3EmMEGOQTzb2OwlZWl/smfXi2K0nJmwRvnGFZ6kJ9bDDFApG5WzFF7PVK0ypl3EmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

On Fri, Oct 25, 2024 at 11:13:47AM +0000, Dhananjay Ugwekar wrote:
> Prepare for the addition of RAPL core energy counter support.
> 
> Move cntr_mask to rapl_pmus struct instead of adding a new global
> cntr_mask for the new RAPL power_core PMU. This will also ensure that
> the second "core_cntr_mask" is only created if needed (i.e. in case of
> AMD CPUs).
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

LGTM.
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
--
Thanks and Regards
gautham.

> ---
>  arch/x86/events/rapl.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index e80b62cf9abc..d3acc70a3d31 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -129,6 +129,7 @@ struct rapl_pmu {
>  struct rapl_pmus {
>  	struct pmu		pmu;
>  	unsigned int		nr_rapl_pmu;
> +	unsigned int		cntr_mask;
>  	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
>  };
>  
> @@ -148,7 +149,6 @@ struct rapl_model {
>   /* 1/2^hw_unit Joule */
>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
>  static struct rapl_pmus *rapl_pmus_pkg;
> -static unsigned int rapl_pkg_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct rapl_model *rapl_model;
>  
> @@ -358,7 +358,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	bit = cfg - 1;
>  
>  	/* check event supported */
> -	if (!(rapl_pkg_cntr_mask & (1 << bit)))
> +	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
>  		return -EINVAL;
>  
>  	/* unsupported modes and filters */
> @@ -586,10 +586,10 @@ static void __init rapl_advertise(void)
>  	int i;
>  
>  	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
> -		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
> +		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
>  
>  	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
> -		if (rapl_pkg_cntr_mask & (1 << i)) {
> +		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
>  			pr_info("hw unit of domain %s 2^-%d Joules\n",
>  				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
>  		}
> @@ -804,9 +804,6 @@ static int __init rapl_pmu_init(void)
>  
>  	rapl_model = (struct rapl_model *) id->driver_data;
>  
> -	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
> -					false, (void *) &rapl_model->pkg_events);
> -
>  	ret = rapl_check_hw_unit();
>  	if (ret)
>  		return ret;
> @@ -815,6 +812,10 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		return ret;
>  
> +	rapl_pmus_pkg->cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs,
> +						  PERF_RAPL_PKG_EVENTS_MAX, false,
> +						  (void *) &rapl_model->pkg_events);
> +
>  	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
>  	if (ret)
>  		goto out;
> -- 
> 2.34.1
> 
