Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D015733A;
	Mon,  7 Oct 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283294; cv=fail; b=fRAs/06+Z6dEVeqtc9T57mvb4pAMhctR/9DO9OxoFVrMJbAOsFSjkFM4CLrq8u8F1AakQFbR3p24JU9cE8h/8hwFxhg3oNHB9qePboYXJfocl5EggtWvLbKyS3wxvQAKm88qOzKsiU9h1NQ/t0TOy7h0TOxWQ+hRFfPBq0mMLPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283294; c=relaxed/simple;
	bh=FH1lbzTxXGiJo5/e7CRerBzgxasZMiBNkR/7/se2siw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UPW6q7kbZrdpNpTStlLbV0+OTyLJrUY70ZClGMY/oeaJbd3ZF0OYmIQXLBMrhz5GkTijs8wSKOjWvIVUWIrbGYl5uXWg0P9nue3X9iJ4t/A78bFS/ZmeoRMCCMjd5awM2tuPzXqO1nG98rJSl5j9ZyOb8NIlZRzLxEopJ9YHfTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DTQiEHNz; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DTQiEHNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZDIp7P0QyEV7NouC1ZyaBM6QoxY0lO+iD44/DEZpfBpPuBRKoJvYIQ4RJ7GnVJqgoHwGu2SmsLet7yyuR1OroIKkIbyMYwaI4AySpq/BrfB2mDVC6eAGSMgQSTbO4ATkdYyf8oHZMD3rg6/gne7dSOmR9by8ALHyko8UkNkcIYYz2RNkMrUA6WIt+VOz7RQ7aF2hza03h29pFjDRwHvG534GL+05iBfJ9NGplJ2z46d6Q9R++ZfEkHKaXThmcYWVc9bBhhos8KrXQ8dgYlqZ4EstMATgG+CTVEZenf612aV77ReaNVXFvDfPHld/HDebX6Pu3KsJgiYYq9tEE+PkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrCWv6uEAAROs3x1lSBZi7KWXSt48Pg5lPdwwTvi+xw=;
 b=m9EN+7yi6l8lhM48OW4gb0H0vmW4ouQJTcuALZVGML4QpY1Kguo8suQcC3MrvftUI9YREJWZA5fol9UmNIpCa+lYHcg+lnH6E0wc0xYatbys7hUYpd+VHRzaL3mCXAGE1wqeRok+ue5NHJoYFUH+xxU1SdQa/IhP+TN3QDeyO2RXHoiGG17p7QVJq17gtzl43/CQl1cBZjtYW/jbzgLnvE3i26XwwYb2FL3LRXMs1LSBhpMus48JBZ3dSeo9ZGT4XXwe11Tpcbf+wWYrIMXGI96IjGqGbM3TyNMdNEt0B7k+z/FlQ80y7qDF5YJkk4dvZUYkiGMFLWuS/pWsqyJqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrCWv6uEAAROs3x1lSBZi7KWXSt48Pg5lPdwwTvi+xw=;
 b=DTQiEHNzou4bDU1IMRN+V+ZzKfzuqVB2kpCxyAzuyGpkJnbRi+M5jC+qC+87Ae4b9qId1/cnnVG5PnD0sk/ErBgMXcTGne8wNhKuXVwFSHZbXQUmQoKlFE3B4CTnqHo/3X28Y+T1HRrROL7P8tXfUz39XzCG3n+NhBYV5w2SY8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.22; Mon, 7 Oct 2024 06:41:28 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 06:41:28 +0000
Date: Mon, 7 Oct 2024 12:11:12 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	rui.zhang@intel.com, oleksandr@natalenko.name, eranian@google.com,
	ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] perf/x86/rapl: Add per-core energy counter
 support for AMD CPUs
Message-ID: <ZwOCiEGmbeRfurwG@BLRRASHENOY1.amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
 <20240913154801.6446-6-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913154801.6446-6-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 71db76ed-e056-4bb4-bd2e-08dce69b123c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vc3sw6KmhfNX1HBMT1s12e95HXeh7I+4o6R9o4MM5GrTBBXg/sPuoeXUrJYY?=
 =?us-ascii?Q?Rss1qgdZEt3kQ/QlotJXwnypfPvJPNSsJaDkBvTSJVYRDAz30rAVVFavHzLl?=
 =?us-ascii?Q?RU48xFZRewEqf2R++zWXkYYn2qusPE/sPGSEig0xv4BeCJI+RpVEEQ8MPx67?=
 =?us-ascii?Q?4xvH6QT/YVPzc3k2mmycBa2QMHky/1bEuiM/atkf31fjdLAwVGRFUimbFa1i?=
 =?us-ascii?Q?vGabFqU4kuubmcq9xFIkyVG1fXesqQuxq2VYLVY41uulbvM1sPCXYBwNbcGQ?=
 =?us-ascii?Q?5ZnKhlvFlMzHY6hzuaqPeT7pEH40ovvnw5ExIv0yFW/SawhtP7eAuislH9pF?=
 =?us-ascii?Q?0k2whUU+tYp4U6blQEZTmbKkKcNAR7N3Qi+zBfl1XMBPVFRo/C6OIVnN/TF1?=
 =?us-ascii?Q?/rVBIsmJH9/Au+sznb91SL1QOvVyqKhKO+SDrYbkNHQD3wA9xWdbCP7ZH5AF?=
 =?us-ascii?Q?kzknz4VWhBClZjvoqeAATZz2vqangCtyNKvHete3IEsUA1TYyFRF+1BAfq0G?=
 =?us-ascii?Q?Gbnjm0MgBMMO5UNlyOGwW3GXOi6h/N4vyhZO2noIkjm2VLLhRE9W9o6294jd?=
 =?us-ascii?Q?w5BQHvGeUeAvCddpbBab20fMLI420b5WofYAZxhIncpCVDGY7bwnPQWzWWvA?=
 =?us-ascii?Q?YqK4S7B/RDPdwyUL9yTcMxjKJmzXxrV/3RrgktetfCmB7o7OBlObkp2rAAlP?=
 =?us-ascii?Q?BT4sGcMh9M9aASudxon68g4X6NgS5Na/6kubnd6TFPbRpG5S9zD35gf4ts2E?=
 =?us-ascii?Q?SWpq1D9jOgGIDWWb0J5U3U3FX3tr+WDI/jeFW+kbgikijptYr+VS5jUlpADu?=
 =?us-ascii?Q?5TrYJ/sWvruzJCmDKs0wKyMFnG5zAGRM8VJAuaTmLMjy+GCwvtQijdOK/+Ia?=
 =?us-ascii?Q?KFj7q/rEJc4wfv809qJgcGll9gNea5qM3b6r01Wuhd5mIone2nBfV/VmbFr2?=
 =?us-ascii?Q?fa8YRMiTnOiDJjNbjaxMhR9x8vc98ckxEzfnNH4Az43AxcoEiqMtW30HxgJ4?=
 =?us-ascii?Q?ueEtUWzeBymqluomLzp1kbUH/DUwOkMwWpFV+miq/hPrpt0vO5uKwXXQ2sHM?=
 =?us-ascii?Q?Uv2mE70A4H49w4PdZcxFVSy/lmgwZRpjfrhL0pW0WfuI8GFsEi2PjUlriLPP?=
 =?us-ascii?Q?WPdAL1znZtW8XZ83OpN4vufkRJqmVlomXqwxwndh7eZg5jeKp6HHvh7/w34v?=
 =?us-ascii?Q?ZbUekrNkwtceyrE2jiF6YSnk6FFXqEuU2hSNppUpnjJ5o/bgU5lEdWVm96AI?=
 =?us-ascii?Q?rt+gSyGw6qARne4M3mAFburw8ONTdquBdY2UA23oQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTxkfZH7lfYzsS80xQw/9GP0IMFFq0PORFQkzBY2p4PxXCfcnJvSPa1OD+ef?=
 =?us-ascii?Q?x83xWPY04BS/umyAaUtSH2t3QOYPPgYIODDwnkvVtwe4K8EHG+tBnCd0YxMB?=
 =?us-ascii?Q?X0B2rj2EUoWsTYPwdpce0eGqCRLwYXcTL4n8FYFS5oeHCY9Gb40aEAfkReJN?=
 =?us-ascii?Q?0jx6SGDgsdTcyjz/r+l1Zm2Dwi5mkn6a8haPEDkCK2mkGQQlYEtJ0Gg0NO3Y?=
 =?us-ascii?Q?tJXqLLD82hHIdZZw/x4nRpeg8MXV85z8NghyjlfZe1BlcgDIA9jDIx/VFG1Q?=
 =?us-ascii?Q?38x7yEGHY5+CZUI7pZA6TNPQSgVKkozCft0SJ/E621Ykbmdvp0pynPugjLFZ?=
 =?us-ascii?Q?S6kErPg21e+QI7OUwBcsQ8c9ZG9TSnVwXpvn+BZUyK+Ro0/obOe40WnCIz+x?=
 =?us-ascii?Q?Uv3M+wLchKeBOpOslXEEYmHS3cMsjNDnxCz1cQcACrRc04ntWdF15nbzYZPF?=
 =?us-ascii?Q?l7U7KiJQdxrjkDnqH0mpX6kI8uKh4IQ1jbwYf+TS6FeJijgKWMLW6FLt5G0Z?=
 =?us-ascii?Q?jo6j8QyhEwrclD+qZvmrC8CN5myGORNhw3IjQ3frv4j/HiYYGDK6jOm87BFL?=
 =?us-ascii?Q?sRXQG8zQ+i5tAufdsKgR10RnUORTn+uNWb0n1GWbZ9Wi8J3NdeBT8SQRA2kn?=
 =?us-ascii?Q?GJ2/761/lySYi/t4agDHb8nM2Dh47UXx4EqXUh2mR34nwySr8s5I7hKbdenw?=
 =?us-ascii?Q?gFhwM+zDtlG1l6hJrIplnXGmbHqieUUqTkFoeXXaw5iJBpGlZP23HqnFBU+y?=
 =?us-ascii?Q?OzHwpvEububhoEWTK2cBz4Qfyf4m/1bEra2ADrPBkl3Nmw+9mh5poXhNKxeY?=
 =?us-ascii?Q?vjfAyJ+ix/57MhzXDr3s3te2dvUGWwF1XyqjSCw+1LtTgAqIxKoR1r8yaWh9?=
 =?us-ascii?Q?D2PDkZ4KnLXP1ATlLr8r2pXEqVZt21uspmFqRTcLBHwwGugsjJ1FgiB3aUnO?=
 =?us-ascii?Q?uLOqefpvJ+Gnn1+LO8pFrdaXkER4Ho4Ry/4Od9wjnpIPcxtuQGDY7iYBqRqI?=
 =?us-ascii?Q?Onl5CmLJUL13zmTWzSYhJRqAGTyD4pRFIl00iCRyE/Pi/H1Xj7N50SPA03JA?=
 =?us-ascii?Q?AMdo5HJrTWFJwfbkW1T5FjW1XhwlJ859l4ef5+oEdM/dnd6CJ841SYcqWoo1?=
 =?us-ascii?Q?aQgn4S82en+wozuE1pvI7t2/M434weh1MCrpRKJhE43FtQPYKQq3SDWatT50?=
 =?us-ascii?Q?z9Ho9a9bN3uP07bF4RWWk5esgLqWI1L4z2HiigpEGYyqcC/YhkGReBGiDsKB?=
 =?us-ascii?Q?P/MJ6xYoD0RXc/SFHxtK8y9FVRSgPw/TrUlFz+nPtI4Eiegrp1NMARXkSDmN?=
 =?us-ascii?Q?od8XhOznWrnL6gR5i4IyGHsGryHV33JK7Rus1OwxYx9sTRJxzExToCBfCKXv?=
 =?us-ascii?Q?6C36eCsoeVO9OzxacdeTqljJRKcB068DRbDVOw3y7zpRuKJX6mHpJa+sZzVG?=
 =?us-ascii?Q?SEpqano9+kOTNiwSvfrb9y+xOvC8I2vLP4SztXW0iUecuyyiF1jchGa4IHaw?=
 =?us-ascii?Q?mJtQw8lt7z4Le+ViKJlHaBK3zrjfLAgzohW8ZTJoC/nS2IV8PhurVhsS62HT?=
 =?us-ascii?Q?G2QuuQzOz3mu0t5KXIliN66mNuuwRQTJ6nhjA08o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71db76ed-e056-4bb4-bd2e-08dce69b123c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 06:41:28.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z87VVEvaHZ1yXrDcMpAlI3Yu49WcznBVEmPVnM2ucpVn6xxrcHdkR9g6ncm2kKFyephV4+e2h3tOGqGc3J0GQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361

On Fri, Sep 13, 2024 at 03:48:01PM +0000, Dhananjay Ugwekar wrote:
> Add a new "power_per_core" PMU and "energy-per-core" event for
> monitoring energy consumption by each core. The existing energy-cores
> event aggregates the energy consumption at the package level.
> This new event aligns with the AMD's per_core energy counters.
> 
> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
> 
> Results with workload pinned to CPU 1 in core 1 on a AMD Zen4 Genoa
> machine:
> 
> $ perf stat -a --per-core -e power_per_core/energy-per-core/ sleep 1
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
> v5 changes:
> * Pass an extra "scope" argument to the get_rapl_pmu_idx() to
>   support the per-core PMU as well.
> * Pass "perf_event" pointer argument to rapl_scale(), to use the 
>   corresponding hw_unit value (pkg or core) to scale.
> * Move around the code in rapl_pmu_event_init() to consolidate the PMU
>   specific code to single if block.
> * Removed the sanity check in rapl_scale() as we have already
>   bound-checked "cfg" in rapl_pmu_event_init()
> ---
>  arch/x86/events/rapl.c | 178 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 143 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 7e9cb01f749a..6514ea67cf0c 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -39,6 +39,10 @@
>   *	  event: rapl_energy_psys
>   *    perf code: 0x5
>   *
> + *  per_core counter: consumption of a single physical core
> + *	  event: rapl_energy_per_core (power_per_core PMU)
> + *    perf code: 0x1
> + *
>   * We manage those counters as free running (read-only). They may be
>   * use simultaneously by other tools, such as turbostat.
>   *
> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>  };
>  
> +#define PERF_RAPL_PER_CORE		0		/* per-core */
> +#define PERF_RAPL_CORE_EVENTS_MAX	1
> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
> +
>  static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>  	"pp0-core",
>  	"package",
> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
>  	"psys",
>  };
>  
> +static const char *const rapl_core_domain_name __initconst = "per-core";
> +
>  /*
>   * event code: LSB 8 bits, passed in attr->config
>   * any other bit is reserved
> @@ -128,14 +138,18 @@ enum rapl_unit_quirk {
>  
>  struct rapl_model {
>  	struct perf_msr *rapl_pkg_msrs;
> +	struct perf_msr *rapl_core_msrs;
>  	unsigned long	pkg_events;
> +	unsigned long	core_events;
>  	unsigned int	msr_power_unit;
>  	enum rapl_unit_quirk	unit_quirk;
>  };
>  
>   /* 1/2^hw_unit Joule */
>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
> +static int rapl_core_hw_unit __read_mostly;
>  static struct rapl_pmus *rapl_pmus_pkg;
> +static struct rapl_pmus *rapl_pmus_core;
>  static u64 rapl_timer_ms;
>  static struct rapl_model *rapl_model;
>  
> @@ -156,10 +170,14 @@ static struct rapl_model *rapl_model;
>   * Helper function to get the correct topology id according to the
>   * RAPL PMU scope.
>   */
> -static inline unsigned int get_rapl_pmu_idx(int cpu)
> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
>  {
> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> -					 topology_logical_die_id(cpu);
> +	if (scope == PERF_PMU_SCOPE_PKG)
> +		return topology_logical_package_id(cpu);
> +	else if (scope == PERF_PMU_SCOPE_DIE)

You don't need the "else if" since you are returning if there is a
match for the earlier if condition.

> +		return topology_logical_die_id(cpu);
> +	else
        ^^^^^
Please check if the scope is SCOPE_CORE here. Again, you don't need the
else condition.


> +		return topology_logical_core_id(cpu);



>  }
>  
>  static inline u64 rapl_read_counter(struct perf_event *event)
> @@ -169,19 +187,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>  	return raw;
>  }
>  
> -static inline u64 rapl_scale(u64 v, int cfg)
> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
>  {
> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
> -		return v;
> -	}
> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
> +
> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
> +		hw_unit = rapl_core_hw_unit;
> +
>  	/*
>  	 * scale delta to smallest unit (1/2^32)
>  	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
>  	 * or use ldexp(count, -32).
>  	 * Watts = Joules/Time delta
>  	 */
> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
> +	return v << (32 - hw_unit);
>  }
>  
>  static u64 rapl_event_update(struct perf_event *event)
> @@ -208,7 +227,7 @@ static u64 rapl_event_update(struct perf_event *event)
>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>  	delta >>= shift;
>  
> -	sdelta = rapl_scale(delta, event->hw.config);
> +	sdelta = rapl_scale(delta, event);
>  
>  	local64_add(sdelta, &event->count);
>  
> @@ -337,12 +356,13 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>  static int rapl_pmu_event_init(struct perf_event *event)
>  {
>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
> -	int bit, rapl_pmu_idx, ret = 0;
> +	int bit, rapl_pmus_scope, rapl_pmu_idx, ret = 0;
>  	struct rapl_pmu *rapl_pmu;
> +	struct rapl_pmus *rapl_pmus;
>  
> -	/* only look at RAPL events */
> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
> -		return -ENOENT;

Don't we need the check to only look at RAPL events of pkg or core ?
Or is that covered by a check below ?



> +	/* unsupported modes and filters */
> +	if (event->attr.sample_period) /* no sampling */
> +		return -EINVAL;
>  
>  	/* check only supported bits are set */
>  	if (event->attr.config & ~RAPL_EVENT_MASK)
> @@ -351,31 +371,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> -	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +	rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
> +	if (!rapl_pmus)
>  		return -EINVAL;
> -
> -	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
> -	bit = cfg - 1;
> -
> -	/* check event supported */
> -	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
> +	rapl_pmus_scope = rapl_pmus->pmu.scope;
> +
> +	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
> +		/* only look at RAPL package events */
> +		if (event->attr.type != rapl_pmus_pkg->pmu.type)
> +			return -ENOENT;
> +
> +		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +			return -EINVAL;
> +
> +		bit = cfg - 1;
> +		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
> +	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
> +		/* only look at RAPL per-core events */
> +		if (event->attr.type != rapl_pmus_core->pmu.type)
> +			return -ENOENT;
> +
> +		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +			return -EINVAL;
> +
> +		bit = cfg - 1;
> +		event->hw.event_base = rapl_model->rapl_core_msrs[bit].msr;
> +	} else
>  		return -EINVAL;
>  
> -	/* unsupported modes and filters */
> -	if (event->attr.sample_period) /* no sampling */
> +	/* check event supported */
> +	if (!(rapl_pmus->cntr_mask & (1 << bit)))
>  		return -EINVAL;
>  
> -	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
> -	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
> +	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu, rapl_pmus_scope);
> +	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>  		return -EINVAL;
> -
>  	/* must be done before validate_group */
> -	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
> +	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
>  	if (!rapl_pmu)
>  		return -EINVAL;
>  
>  	event->pmu_private = rapl_pmu;
> -	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>  	event->hw.config = cfg;
>  	event->hw.idx = bit;
>  
> @@ -392,12 +430,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
>  RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
>  RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
>  RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
> +RAPL_EVENT_ATTR_STR(energy-per-core,   rapl_per_core, "event=0x01");
>  
>  RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
> +RAPL_EVENT_ATTR_STR(energy-per-core.unit,   rapl_per_core_unit, "Joules");
>  
>  /*
>   * we compute in 0.23 nJ increments regardless of MSR
> @@ -407,6 +447,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
>  RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
>  RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
>  RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-per-core.scale,   rapl_per_core_scale, "2.3283064365386962890625e-10");
>  
>  /*
>   * There are no default events, but we need to create
> @@ -439,6 +480,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
>  	NULL,
>  };
>  
> +static const struct attribute_group *rapl_per_core_attr_groups[] = {
> +	&rapl_pmu_format_group,
> +	&rapl_pmu_events_group,
> +	NULL,
> +};
> +
>  static struct attribute *rapl_events_cores[] = {
>  	EVENT_PTR(rapl_cores),
>  	EVENT_PTR(rapl_cores_unit),
> @@ -499,6 +546,18 @@ static struct attribute_group rapl_events_psys_group = {
>  	.attrs = rapl_events_psys,
>  };
>  
> +static struct attribute *rapl_events_per_core[] = {
> +	EVENT_PTR(rapl_per_core),
> +	EVENT_PTR(rapl_per_core_unit),
> +	EVENT_PTR(rapl_per_core_scale),
> +	NULL,
> +};
> +
> +static struct attribute_group rapl_events_per_core_group = {
> +	.name  = "events",
> +	.attrs = rapl_events_per_core,
> +};
> +
>  static bool test_msr(int idx, void *data)
>  {
>  	return test_bit(idx, (unsigned long *) data);
> @@ -536,6 +595,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
>  	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
>  };
>  
> +static struct perf_msr amd_rapl_core_msrs[] = {
> +	[PERF_RAPL_PER_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_per_core_group,
> +				 test_msr, false, RAPL_MSR_MASK },
> +};
> +
>  static int rapl_check_hw_unit(void)
>  {
>  	u64 msr_rapl_power_unit_bits;
> @@ -547,6 +611,8 @@ static int rapl_check_hw_unit(void)
>  	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
>  		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
>  
> +	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
> +
>  	switch (rapl_model->unit_quirk) {
>  	/*
>  	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
> @@ -565,7 +631,6 @@ static int rapl_check_hw_unit(void)
>  		break;
>  	}
>  
> -
>  	/*
>  	 * Calculate the timer rate:
>  	 * Use reference of 200W for scaling the timeout to avoid counter
> @@ -584,9 +649,13 @@ static int rapl_check_hw_unit(void)
>  static void __init rapl_advertise(void)
>  {
>  	int i;
> +	int num_counters = hweight32(rapl_pmus_pkg->cntr_mask);
> +
> +	if (rapl_pmus_core)
> +		num_counters += hweight32(rapl_pmus_core->cntr_mask);
>  
>  	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
> -		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
> +		num_counters, rapl_timer_ms);
>  
>  	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
>  		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
> @@ -594,6 +663,10 @@ static void __init rapl_advertise(void)
>  				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
>  		}
>  	}
> +
> +	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_PER_CORE)))
> +		pr_info("hw unit of domain %s 2^-%d Joules\n",
> +			rapl_core_domain_name, rapl_core_hw_unit);
>  }
>  
>  static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
> @@ -614,6 +687,10 @@ static const struct attribute_group *rapl_attr_update[] = {
>  	NULL,
>  };
>  
> +static const struct attribute_group *rapl_per_core_attr_update[] = {
> +	&rapl_events_per_core_group,
> +};
> +
>  static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  {
>  	struct rapl_pmu *rapl_pmu;
> @@ -622,10 +699,9 @@ static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  	cpus_read_lock();
>  
>  	for_each_cpu(cpu, cpu_online_mask) {
> -		rapl_pmu_idx = get_rapl_pmu_idx(cpu);
> +		rapl_pmu_idx = get_rapl_pmu_idx(cpu, rapl_pmus->pmu.scope);
>  		if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>  			continue;
> -
>  		rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
>  		if (rapl_pmu)
>  			continue;
> @@ -644,15 +720,19 @@ static void __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  	cpus_read_unlock();
>  }
>  
> -static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
> +static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
> +				 const struct attribute_group **rapl_attr_groups,
> +				 const struct attribute_group **rapl_attr_update)
>  {
>  	int nr_rapl_pmu;
>  	struct rapl_pmus *rapl_pmus;
>  
>  	if (rapl_pmu_scope == PERF_PMU_SCOPE_PKG)
>  		nr_rapl_pmu	= topology_max_packages();
> -	else
> +	else if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
>  		nr_rapl_pmu	= topology_max_packages() * topology_max_dies_per_package();
> +	else
> +		nr_rapl_pmu	= topology_max_packages() * topology_num_cores_per_package();

Here please check if the rapl_pmu_scope is PERF_PMU_SCOPE_CORE instead
of assuming it to be the case if the scope is neither SCOPE_PKG nor
SCOPE_DIE. If it is neither of these three, then return an error.


--
Thanks and Regards
gautham.

>  
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)
> @@ -743,8 +823,10 @@ static struct rapl_model model_spr = {
>  
>  static struct rapl_model model_amd_hygon = {
>  	.pkg_events	= BIT(PERF_RAPL_PKG),
> +	.core_events	= BIT(PERF_RAPL_PER_CORE),
>  	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>  	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
> +	.rapl_core_msrs	= amd_rapl_core_msrs,
>  };
>  
>  static const struct x86_cpu_id rapl_model_match[] __initconst = {
> @@ -816,7 +898,8 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
> +	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
> +			     rapl_attr_update);
>  	if (ret)
>  		return ret;
>  
> @@ -828,6 +911,27 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		goto out;
>  
> +	if (rapl_model->core_events) {
> +		ret = init_rapl_pmus(&rapl_pmus_core, PERF_PMU_SCOPE_CORE,
> +				     rapl_per_core_attr_groups,
> +				     rapl_per_core_attr_update);
> +		if (ret) {
> +			pr_warn("Per-core PMU initialization failed (%d)\n", ret);
> +			goto per_core_init_failed;
> +		}
> +
> +		rapl_pmus_core->cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
> +						     PERF_RAPL_CORE_EVENTS_MAX, false,
> +						     (void *) &rapl_model->core_events);
> +
> +		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_per_core", -1);
> +		if (ret) {
> +			pr_warn("Per-core PMU registration failed (%d)\n", ret);
> +			cleanup_rapl_pmus(rapl_pmus_core);
> +		}
> +	}
> +
> +per_core_init_failed:
>  	rapl_advertise();
>  	return 0;
>  
> @@ -840,6 +944,10 @@ module_init(rapl_pmu_init);
>  
>  static void __exit intel_rapl_exit(void)
>  {
> +	if (rapl_pmus_core) {
> +		perf_pmu_unregister(&rapl_pmus_core->pmu);
> +		cleanup_rapl_pmus(rapl_pmus_core);
> +	}
>  	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
>  	cleanup_rapl_pmus(rapl_pmus_pkg);
>  }
> -- 
> 2.34.1
> 
