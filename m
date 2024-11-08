Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D361CDFA6;
	Fri,  8 Nov 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059605; cv=fail; b=e1tlwR8+boFX3GDzHrLZDglRbvyfX9gRUi+bCrQRyw/tehL0lGzDz2H0lB4T7oUVaX0pfnVdAj0bfTZl5hMDfzlxqSxvx1sYEp2nWQFlysBmieIqDUbxSItBPyhoppa7TmMOCFxK5ujUK9tsP4hVtcPqgrpMBtfio2CCrwbFZgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059605; c=relaxed/simple;
	bh=nKxcE88Jk7dMcRz6hxHmXAZXurQQkpLhMOK+HlB5YwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oKwY9dU9QmMps5ckVwPuCqzIcFtImR+y0SFhyG3UjFKW87yPgkUkTbmyzzjNIoDnoNp06aNwbBc2mcDb7QAD7tiUCzXSeD2oY0f8AIOZAoIujD5iDE+X/vctqkA4Kikjb7oGWC4ZN573S/iYECAKXNu++KEGEhM9vlmUOhAYmKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R96raZoU; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R96raZoU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXu75GTjxgliyDW+IBgJSLuwKDDQpJYKUUe+6nrldZdqsdE9lf3c0RYtgwCJ8RkaREoJJteaIfxKTcD5ewqGuKwZFWJjMyw2YIJvb7k4POxx4SI2hQMsDShM9ikFh6oidBJ86rg3YE3Sfit2+XjA3FtfLoQp1qdDq0EAYTrl6P1hNDU8EqayDqKPHjpQEWDyFPU//bT1DD1wtT5VVWgX0CCRCuaFogkUwAqkeKi2D1uRV2D99uYhCDN+URnEFuLQbmH2ZEN2MzFrhHehGHHi+y67uHW20XuOQFv6xV58IJ1UMU99/+neHiCPKTRtDR6yMPGFNBHH7wklUKGpzXqUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdjzPvX0xslgOpnwUxGZ+Yx2f8qWxhWsEO4trgeybpo=;
 b=m5FgMCiRnsBlVxzZEEbeHufCgAifImdcKSVZilOov9xLwumMaIa1DbyU3O1GEMHUp+2fhW+VU2zocAG2amDqCd1F16lQgqVmlgsR90okE3mp6DsiKJeYIiJzMfYf+k5ZbhGoNsAcl+eZixE1lgy5bhRJGXj6A+R/eBydai6ZURp9J3kjEnFQDAGh0nFuDK2NmMlWDh/tYkXVe0nu1xPQ7M/Lz8eZBIo6v8s0TkiDxr0vS2s02cdCbCFafK3xPztjXHI1NL4YqzUCVFSP/m5CCGqvi0kmK7Relnr1N8OPsYdc3eyiVvLq1zJQulVd1P0XebGLskdgywlShvAepgCOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdjzPvX0xslgOpnwUxGZ+Yx2f8qWxhWsEO4trgeybpo=;
 b=R96raZoUEHKPjeNTlH1+6PQxMLzCIn0W3HkzywGRB4Ytgk1IHPRlsF+qralrk2ycAvEwRBje8mSBKocpQpW1a2fY35jlt6hFT8JHrDLrkmVc4+Q9c9eti3gbJZYeXpGgfh/2sylRvAGxnsWIq2UoILp6cj690IOrfjgO+IGscGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.21; Fri, 8 Nov 2024 09:53:18 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 09:53:18 +0000
Date: Fri, 8 Nov 2024 15:22:58 +0530
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
Subject: Re: [PATCH v6 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
Message-ID: <Zy3fem1TVYdYJAeF@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-11-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-11-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN1PEPF000067EF.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2b) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: fc791b87-9a40-439b-3c6f-08dcffdb2be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C0HjnbGUs+VPiR8DbYAguoMDaGEABqQTw7hSBFogtDmdBP767rJ7JTIMRe1A?=
 =?us-ascii?Q?G8Vqb+yVgdJV8HZiad7OEirFqrC3hrwgpSs8q9ppw9JD1kwELKtSwj3IFykN?=
 =?us-ascii?Q?RMXia/dUAKt6pXW2o5uH7yxDx/6svdhZio/eXoSI3jyo3EFDq+dJ/rT5t6PR?=
 =?us-ascii?Q?EzAjrwA+9gPr0zzWSkjfxTYwLmqOBw6uLnXhJL/eoLc7Qr1HIlhbExby/GVH?=
 =?us-ascii?Q?ZDc09FB+TW8a2O20i4QX4NjUdFt4w+4vix6jDagsDSRy9gC9caxOUJL5VuUa?=
 =?us-ascii?Q?LM15a7+zEl85tfCIf0KEYUrWHwF24+vGuk8aYqRmVqSF3fUs12A1URE6LqAA?=
 =?us-ascii?Q?TdKkCsrO16z19Xl5RDnf6jQE1bpgu8OOv+ynmltp0ezcBIKKfbAlT7YK093H?=
 =?us-ascii?Q?LrumhS4uaueJy80YtcuoiebKro6gqRQYuNEVktQ0YFNzIIWwv3kH4T9XlovM?=
 =?us-ascii?Q?HBQRgFEOhEoh++gbGMSvH4L1fd/GSgHiQXg0NOzoZxF61B14B4avgAnXW3fO?=
 =?us-ascii?Q?bkULeOjCY1N2G3RhhToV+I+PkDjN49GvN1Y+2K1Vk82jyUwXRfGxmzyRZ+8c?=
 =?us-ascii?Q?0b7un0knV6/Z5NL6A0Xuek4RWccX7TkyA/c5Dxiajv1qstv4gqCEJotH4/sf?=
 =?us-ascii?Q?9HCdlq+ptuSevvA4xE48/yIPEe9ZLxdPgLYFUaVayyWRtJ4B3aGGM80Vg4oK?=
 =?us-ascii?Q?PWVUs3E0Zq1HZseM9zhHAsNCWu6iqdV1wsbZ5bis/RUwCC+YnaRlHAsWfnM+?=
 =?us-ascii?Q?BB2wPHqPgQAjwqcYl1Lb+ibTOgQT7leXF69ayu4OAVN4NA/K4fAc11suT5X1?=
 =?us-ascii?Q?cbL4gL5KaE1onwQwhlsnOdYSZhhtry4D33/luBHrpnNZlKLoaZiGW+zSuzyS?=
 =?us-ascii?Q?UdFHW2Pqtsn4Zn3XqyuYbPfTxuJ19bgC3nF4Zkj2iJ/vJKFbAyjn5p6DDj5h?=
 =?us-ascii?Q?V2tDExW2+alj+tj14JCfIukVU7sdqRFEV5AfBYDvR/Kuc5k9JiBEYUmSBCb9?=
 =?us-ascii?Q?7JmxEonQGL0RMZL/qWGnovhodTP3ADSzdE8saEbDIbEeV/N+ODm4CIT8T7vf?=
 =?us-ascii?Q?XGl0Up3b7+U0S7q3WsGceqaEmeV17S+ibkxRJEaGqu7PsW9cxqqlQgJFDdg9?=
 =?us-ascii?Q?Ns9VChFZDQDodQqq/ZcWaEX8o2AIYI7wR9N3GQEjvn8Uubo7lE/nGSOI+g3I?=
 =?us-ascii?Q?0/q0+Pnk2pXReSDldyxsoaddubzE3c3UyL41kUn6wOgZsQWwIAN2MobXTWOA?=
 =?us-ascii?Q?WlyDkavw+zLmQfVGxxD61CVdwIOm8EYTCE5UGg2feTWPiv+sGt/r/PCNQs3F?=
 =?us-ascii?Q?D5iOk4uW8h8sxTpIHCyP4qJ0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eq3sFRHAQ1omnQ4S1Dcza/bPN1nm5MkN6FEZj9h8HJ8S92c+tORTG811QRT/?=
 =?us-ascii?Q?FApaONHeHlQWdXqA2E3p2gWnDTNd6ClVEKuiOh77vUT8fSHXuDF6sp5G+ZEr?=
 =?us-ascii?Q?UvoV+Hpk3RShc/iVTRohubfeoPkRuI1EiO78+hxug7MPqHMjTMfWrJagMAbP?=
 =?us-ascii?Q?A0gTLi8UZ/25iSYR2+6FZAc13NMU+BRpxGY3QsslteTBAs08TavFenUN1vkM?=
 =?us-ascii?Q?lbY+7dtU2p8DYWk5Kc+PJPLg2cLFVtmRC+vfFM8eLHU3as0eE+7ICXMs/gey?=
 =?us-ascii?Q?hiuislaE6iukFhPijiQg7Ur5zfhWep/jjo45bkP649sr2d1fivnGN4R+B0tF?=
 =?us-ascii?Q?2WhJ5gXAeR3s1qgFxLrEs5hmsDInjKtTjs/GuJReJDi3R5fYtTuHEGAfbuwB?=
 =?us-ascii?Q?YMNqCj5oKnIm58aM6KNhDHJpJVzVho8PpelTwV4ltB1YuNwL10P8FQHYALtJ?=
 =?us-ascii?Q?ZVhMrs+po9Xg1CbBT+0y/3mlt2m8ZClawiUvf7QRq/x8FdOAef5Umm/Qt3XS?=
 =?us-ascii?Q?vgIfRy0xcDdhnOMajD1B50dZIDFPCSTfzDu8Wrx4BdEDVLQQqeZXd1aGTVYF?=
 =?us-ascii?Q?Qi7082vRnkf8Zon93NiQJkPWN0aZKSNbYwKLasKXngWztlELB/K8GW65q9zu?=
 =?us-ascii?Q?Wf7bGEPmx0kZ0RgWimXsPJx+abdMAiepqORdrG8WneitT14BBynSS8DHdiFi?=
 =?us-ascii?Q?t4g8n2z0ZDa5Cq9K/IV2n94uIf97Re//nXusShn6JqudeHXDwg9kx3vlGmCd?=
 =?us-ascii?Q?PQ0blROSij197P5Vh7a3rDNeIZiUKZVjvd2DlSBh5xAlTRNkr69pOBL2u7J/?=
 =?us-ascii?Q?ECYpgss2N7ZmXQa3ks/F+B28c8Atv/KtjxrT1t0/ha2C3VjtZu6+HJQlbF1B?=
 =?us-ascii?Q?EFGJIJhtvvO1P6geIkGHI1AvjIkbMKNbI50T0vwxCumEvfxU75HTh+cw3kw5?=
 =?us-ascii?Q?8rAEsP7WH2RwKvyako1UdTJOh5Zx4TuUfOTwEdgQ5FAXj+ucAcV2ya0bQVuX?=
 =?us-ascii?Q?+MwWIWoCl9GpnR02+NFxVIBUJTwLUesgOFJP9yvsA7thtlUPQx3dFotlUpxw?=
 =?us-ascii?Q?OiAlfX2XSwJrJemEcDbnWU1prtHy3RGu7oRNCIxnHPCjzkWbRltKcE99hcv0?=
 =?us-ascii?Q?+JN+11kQuuiGxN7kEqDa2V76BwrLoLHShy3i39GJMsSoMhr0j/tYjqWjG3e0?=
 =?us-ascii?Q?vLWEJ4vUMju8z4UvuGS0cehMzVTR/1LVWva/Mz8v8rsuOP3mZC2lwtZnIzXB?=
 =?us-ascii?Q?x+dtppNQu1OqeeUkwakVHYxunod367U0cE4zWD4g3WkpR0GqglZCkxeAaPKu?=
 =?us-ascii?Q?Dn0rFevFN4iLAO3AR35NUMdq/MfainB/nZtrd6DxaTZYsDLyg0MrvAJJc02y?=
 =?us-ascii?Q?R5VPOjf+SQTu//cbTymdKE3i1/mii0bxM8z7w020SE3Xo1ebUsOcqn73jpJA?=
 =?us-ascii?Q?go/kAFUfRgPYL8xgcq5sds4Q/Kf8P5kcPshQ8c3nXb2hWSj2ubi+Cr1XSmQZ?=
 =?us-ascii?Q?PZIREaRFrGhUSn4qFCp2NLOYx/d2mjGfMOcyZ62rNoGNz+ablgY2dt4x31a+?=
 =?us-ascii?Q?DWA7+FfffEbO5yF1jmMS8aP++Mt7RLf4cmUohTl2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc791b87-9a40-439b-3c6f-08dcffdb2be1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 09:53:18.0654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5nhoCL2OskpG2OneBdDlNzts1zG0Sm/CUMkwq63PX+iDwv1+QPlBiS3dMaYcOUMDD2SLFo5DR4v1QkkdFc2QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225

Hello Dhananjay,


On Fri, Oct 25, 2024 at 11:13:48AM +0000, Dhananjay Ugwekar wrote:
> Add a new "power_core" PMU and "energy-core" event for monitoring 
> energy consumption by each individual core. The existing energy-cores 
> event aggregates the energy consumption of CPU cores at the package level. 
> This new event aligns with the AMD's per-core energy counters.
> 
> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
> 
> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
> machine:
> 
> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
> stress-ng: info:  [21250] setting to a 5 second run per stressor
> stress-ng: info:  [21250] dispatching hogs: 1 matrix
> stress-ng: info:  [21250] successful run completed in 5.00s
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0              1               0.00 Joules power_core/energy-core/
> S0-D0-C1              1               0.00 Joules power_core/energy-core/
> S0-D0-C2              1               0.00 Joules power_core/energy-core/
> S0-D0-C3              1               0.00 Joules power_core/energy-core/
> S0-D0-C4              1               8.43 Joules power_core/energy-core/
> S0-D0-C5              1               0.00 Joules power_core/energy-core/
> S0-D0-C6              1               0.00 Joules power_core/energy-core/
> S0-D0-C7              1               0.00 Joules power_core/energy-core/
> S0-D1-C8              1               0.00 Joules power_core/energy-core/
> S0-D1-C9              1               0.00 Joules power_core/energy-core/
> S0-D1-C10             1               0.00 Joules power_core/energy-core/
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Looks like my response to this patch never made it to the list.

The patch looks good to me.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.



> ---
> v6 changes:
> * Replaced the if-ladder in get_rapl_pmu_idx() with a switch case. (Gautham)
> * Added the error if condition in init_rapl_pmus().
> * Modify the PMU name from "power_per_core" to "power_core" and event name
>   from "event_per_core" to "event_core"
> ---
>  arch/x86/events/rapl.c | 182 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 150 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index d3acc70a3d31..57cf15a19b7c 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -39,6 +39,10 @@
>   *	  event: rapl_energy_psys
>   *    perf code: 0x5
>   *
> + *  core counter: consumption of a single physical core
> + *	  event: rapl_energy_core (power_core PMU)
> + *    perf code: 0x1
> + *
>   * We manage those counters as free running (read-only). They may be
>   * use simultaneously by other tools, such as turbostat.
>   *
> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>  };
>  
> +#define PERF_RAPL_CORE			0		/* single core */
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
> +static const char *const rapl_core_domain_name __initconst = "core";
> +
>  /*
>   * event code: LSB 8 bits, passed in attr->config
>   * any other bit is reserved
> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
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
> @@ -156,10 +170,18 @@ static struct rapl_model *rapl_model;
>   * Helper function to get the correct topology id according to the
>   * RAPL PMU scope.
>   */
> -static inline unsigned int get_rapl_pmu_idx(int cpu)
> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
>  {
> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> -					 topology_logical_die_id(cpu);
> +	switch (scope) {
> +	case PERF_PMU_SCOPE_PKG:
> +		return topology_logical_package_id(cpu);
> +	case PERF_PMU_SCOPE_DIE:
> +		return topology_logical_die_id(cpu);
> +	case PERF_PMU_SCOPE_CORE:
> +		return topology_logical_core_id(cpu);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static inline u64 rapl_read_counter(struct perf_event *event)
> @@ -169,19 +191,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
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
> @@ -208,7 +231,7 @@ static u64 rapl_event_update(struct perf_event *event)
>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>  	delta >>= shift;
>  
> -	sdelta = rapl_scale(delta, event->hw.config);
> +	sdelta = rapl_scale(delta, event);
>  
>  	local64_add(sdelta, &event->count);
>  
> @@ -337,12 +360,13 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
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
> +	/* unsupported modes and filters */
> +	if (event->attr.sample_period) /* no sampling */
> +		return -EINVAL;
>  
>  	/* check only supported bits are set */
>  	if (event->attr.config & ~RAPL_EVENT_MASK)
> @@ -351,31 +375,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
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
> +		/* only look at RAPL core events */
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
> @@ -392,12 +434,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
>  RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
>  RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
>  RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
> +RAPL_EVENT_ATTR_STR(energy-core,   rapl_core, "event=0x01");
>  
>  RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
> +RAPL_EVENT_ATTR_STR(energy-core.unit,   rapl_core_unit, "Joules");
>  
>  /*
>   * we compute in 0.23 nJ increments regardless of MSR
> @@ -407,6 +451,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
>  RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
>  RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
>  RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-core.scale,   rapl_core_scale, "2.3283064365386962890625e-10");
>  
>  /*
>   * There are no default events, but we need to create
> @@ -439,6 +484,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
>  	NULL,
>  };
>  
> +static const struct attribute_group *rapl_core_attr_groups[] = {
> +	&rapl_pmu_format_group,
> +	&rapl_pmu_events_group,
> +	NULL,
> +};
> +
>  static struct attribute *rapl_events_cores[] = {
>  	EVENT_PTR(rapl_cores),
>  	EVENT_PTR(rapl_cores_unit),
> @@ -499,6 +550,18 @@ static struct attribute_group rapl_events_psys_group = {
>  	.attrs = rapl_events_psys,
>  };
>  
> +static struct attribute *rapl_events_core[] = {
> +	EVENT_PTR(rapl_core),
> +	EVENT_PTR(rapl_core_unit),
> +	EVENT_PTR(rapl_core_scale),
> +	NULL,
> +};
> +
> +static struct attribute_group rapl_events_core_group = {
> +	.name  = "events",
> +	.attrs = rapl_events_core,
> +};
> +
>  static bool test_msr(int idx, void *data)
>  {
>  	return test_bit(idx, (unsigned long *) data);
> @@ -536,6 +599,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
>  	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
>  };
>  
> +static struct perf_msr amd_rapl_core_msrs[] = {
> +	[PERF_RAPL_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_core_group,
> +				 test_msr, false, RAPL_MSR_MASK },
> +};
> +
>  static int rapl_check_hw_unit(void)
>  {
>  	u64 msr_rapl_power_unit_bits;
> @@ -547,6 +615,8 @@ static int rapl_check_hw_unit(void)
>  	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
>  		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
>  
> +	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
> +
>  	switch (rapl_model->unit_quirk) {
>  	/*
>  	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
> @@ -565,7 +635,6 @@ static int rapl_check_hw_unit(void)
>  		break;
>  	}
>  
> -
>  	/*
>  	 * Calculate the timer rate:
>  	 * Use reference of 200W for scaling the timeout to avoid counter
> @@ -584,9 +653,13 @@ static int rapl_check_hw_unit(void)
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
> @@ -594,6 +667,10 @@ static void __init rapl_advertise(void)
>  				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
>  		}
>  	}
> +
> +	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_CORE)))
> +		pr_info("hw unit of domain %s 2^-%d Joules\n",
> +			rapl_core_domain_name, rapl_core_hw_unit);
>  }
>  
>  static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
> @@ -614,6 +691,10 @@ static const struct attribute_group *rapl_attr_update[] = {
>  	NULL,
>  };
>  
> +static const struct attribute_group *rapl_core_attr_update[] = {
> +	&rapl_events_core_group,
> +};
> +
>  static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  {
>  	struct rapl_pmu *rapl_pmu;
> @@ -640,13 +721,22 @@ static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  	return -ENOMEM;
>  }
>  
> -static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
> +static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
> +				 const struct attribute_group **rapl_attr_groups,
> +				 const struct attribute_group **rapl_attr_update)
>  {
>  	int nr_rapl_pmu = topology_max_packages();
>  	struct rapl_pmus *rapl_pmus;
>  
> +	/*
> +	 * rapl_pmu_scope must be either PKG, DIE or CORE
> +	 */
>  	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
>  		nr_rapl_pmu	*= topology_max_dies_per_package();
> +	else if (rapl_pmu_scope == PERF_PMU_SCOPE_CORE)
> +		nr_rapl_pmu	*= topology_num_cores_per_package();
> +	else if (rapl_pmu_scope != PERF_PMU_SCOPE_PKG)
> +		return -EINVAL;
>  
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)
> @@ -735,8 +825,10 @@ static struct rapl_model model_spr = {
>  
>  static struct rapl_model model_amd_hygon = {
>  	.pkg_events	= BIT(PERF_RAPL_PKG),
> +	.core_events	= BIT(PERF_RAPL_CORE),
>  	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>  	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
> +	.rapl_core_msrs	= amd_rapl_core_msrs,
>  };
>  
>  static const struct x86_cpu_id rapl_model_match[] __initconst = {
> @@ -808,7 +900,8 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
> +	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
> +			     rapl_attr_update);
>  	if (ret)
>  		return ret;
>  
> @@ -820,6 +913,27 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		goto out;
>  
> +	if (rapl_model->core_events) {
> +		ret = init_rapl_pmus(&rapl_pmus_core, PERF_PMU_SCOPE_CORE,
> +				     rapl_core_attr_groups,
> +				     rapl_core_attr_update);
> +		if (ret) {
> +			pr_warn("power-core PMU initialization failed (%d)\n", ret);
> +			goto core_init_failed;
> +		}
> +
> +		rapl_pmus_core->cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
> +						     PERF_RAPL_CORE_EVENTS_MAX, false,
> +						     (void *) &rapl_model->core_events);
> +
> +		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_core", -1);
> +		if (ret) {
> +			pr_warn("power-core PMU registration failed (%d)\n", ret);
> +			cleanup_rapl_pmus(rapl_pmus_core);
> +		}
> +	}
> +
> +core_init_failed:
>  	rapl_advertise();
>  	return 0;
>  
> @@ -832,6 +946,10 @@ module_init(rapl_pmu_init);
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
