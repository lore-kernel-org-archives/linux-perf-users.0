Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394413D539;
	Mon, 28 Oct 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125659; cv=fail; b=X+M1kyDIbITWglcAO2Xg61IPe5YITG8TkX9pSxhxUlg8vlBm0b5F8Xa2dqZ5M04rk1hSJUfdBbuV/B4FfvDATgAilgPrMrFQZkgiRUz/SjdzvG/fdwFfWlRfN/0gxqQcm1eVzFfAb8wzVmRcQkV/reAUVa03j3DBy0Bn362IuMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125659; c=relaxed/simple;
	bh=AnLxpYOCQeq5zuCgOtLh/8okSBHBFGGrLI/yXcetUoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sg/1cPpWV6pfp16t5ToE6ONHgFgGg0TD50hojd7SKMGnyYfl4nJBQhd3PEcjts9UZVC/SSpeZ/cub/oFwlCqoZD6F8AiQM/ADzID/s3a7ZJ3TbsmyDfETTtYbnEV7W5RgP1MYVhI1K3sEBItp7UkXjQYq76D8ln6HhssSZcuDvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iYlxCOtV; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iYlxCOtV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1p9I6AX6ma62dIoGEIbf2gpfRA6mQ2aQDfCvRYaTAiGz0T+PxDLmODx6VFK3tcQUz5OWXJkWhzLcjkjeCNKFZq0onrdWO5JewYoBwxCi0TTH7pslShCVpm3meADoTWZEJ8whXASB3xSQxTL94an9o2mg5DvhuMi8Y6xcXleLPbjzX82d99v0F5lDrNRCOnZr+NI7FcBewfKJK44wCFXhgnRKuqUWH/MGV9+kAlwnB0gzj3KSPb5DGaawOmhGji/D3qkGKK50WtJwqFPcOycnzobfxuUMgxxnseC31Rn7HMoAytZCAntZOoaTWXYM634ZGuEWl8nws0tkonjd37TcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbz0SFESPsrBf+/aRdNPvCcPV5tecEG7ILGB377X4pM=;
 b=unRuq+eQuGH86ZUb5diyMPx8nfKtBoa9B7ZSpZJXy9gt9JOMyp5bpKC8w9/OmIflvUNq2nmUVKjnvjMWZTRSN5SXstjYru0IE54syiFn/H3LHrbRIftnMrNIRXt9iw2x7BYCGTzOryIhCkk4cXqDvZRMFmpT2X6JxRj+lfqqZhTeWx9Ul8EI8O/4RqPZRPTvvO7FCf2TFhsFW9sdgdSSnWp49t1d4xzZ2Rs3Nay0MaT0IuR7iLTS41hSppzWTC5SUnc2Aof1ZwQSgclZ/7/leN6TLtAwHDJBVVPVbmE8V7KCFuswJVacvnpPyq5lSw3d3QXPgmiNW9eFJC2rav8U+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbz0SFESPsrBf+/aRdNPvCcPV5tecEG7ILGB377X4pM=;
 b=iYlxCOtVmGPr+aaj+JNoJh/tqWkJ+2nL2uFMMEhD6XL/fYdfmwnncEG4nusZPQPUamLZU6GaQhfMV+BllQTeVabaCdNtIfRMubi3tiz+OHfUUZjcnp0Tq0TTJbOsd3Bbw/t9YxQyR8Vuzxors+vbMkviAChYxEoxZB/ZCxTCQ84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 14:27:27 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 14:27:27 +0000
Date: Mon, 28 Oct 2024 19:57:12 +0530
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
Subject: Re: [PATCH v6 07/10] perf/x86/rapl: Modify the generic variable
 names to *_pkg*
Message-ID: <Zx+fQOiPc91A4mlq@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-8-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-8-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN1PEPF000067F0.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2c) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 38614fef-59a2-46ba-853b-08dcf75ca597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PR6FU2y5mTm1j5Sr4CG0Mp0cozY0Y9nC+eLPQ9xsLbG3JhKE8JN/lfOV+NhD?=
 =?us-ascii?Q?UxNM+RAeP+r1mzzGw1riQeHEPiO7NUXaWVXENezuvueV6HKtGEmn9JK2EEkM?=
 =?us-ascii?Q?hUMSWaMvt0LqEQ3FZB92FYO71g1Sm6MIbucxJycjFsR+ThNnSwbnHPrNCGX3?=
 =?us-ascii?Q?kUU8MuguUe11V86ZKoRBWZ1aH6hl1VNu/tjJJUELivPPnCeLK5ENgXP06DVd?=
 =?us-ascii?Q?sls4xFG2b+NOkgpOTQOI1fYEJKrrysnGjPrv4FIqSGDRoHntGI/30jZyrVff?=
 =?us-ascii?Q?7XOAHuAaQDjiQiJtOpYGCnAnF2BRp9FJbaBcf4iG/Eyv4NIzOS3mZvLJww94?=
 =?us-ascii?Q?Y025pD0xr7nb8EyvnRIpcsZG+HKJGg4TXC6b9y724lw4W2FdTO1pQC2nIwDc?=
 =?us-ascii?Q?pakv30R/V62z9BQUHJWiL0sn/VwQwzeW0/r1BjMNI6Fz/ruiJjeQzs2b51c2?=
 =?us-ascii?Q?DP/0XXMUE3s4PbiXcYoz3lxbTBIPUeRNSFVMo06SmGMw5GXmNiBu4KG9IKPG?=
 =?us-ascii?Q?Wh57YStdG3euO4oPR7uuhRZkBXxuOWzZnBpQo5quDUtmuGQv670jDcyfH8Kx?=
 =?us-ascii?Q?9o9uOpRiTRlq+m926/SXEmmluT2WYSHs9iu/kShOvp18k4octWEN7+SeSt9e?=
 =?us-ascii?Q?wWeGhAoDrI+h0kL4gUHbBRZgE5x0b/041lTYwJlwtE3dypxIPbu1LKqFxhC1?=
 =?us-ascii?Q?jDSg06HWIiIGdYz7AF/3J2Wm1ngCjN868REgFMCBr4x5VOLfCSAJjWe4S3BN?=
 =?us-ascii?Q?sckw0yl/Kcp+ypcG2sIiDjSSbyfQEvWlctAIHnxxg6PhtVXRYjleTmdmAFZG?=
 =?us-ascii?Q?QExIJ7aRbyfIsGTF/RjNQnqt3E1rcoW8fIZBDWboIPv+WoY+MQf+S+lqgBJw?=
 =?us-ascii?Q?K67tu1cnO3aby43PkMZ4rXqqM8Kz4VXVWD7A7CQ0WZIgj+tPAdt7FkzHq8oJ?=
 =?us-ascii?Q?uTfzW08aN2OIV+x2jOPHzJ5pOcve8XAPaL5ovEg0TApzEPT87t1La1sxSQ5l?=
 =?us-ascii?Q?lgFm9vQ8X2XGRK+TELeSdcvzxlaQXsJyQDI3fMsc2lvSXXFJTp4DvMmMgCVo?=
 =?us-ascii?Q?odNcT6XNukB3efJOGkinbfGULagwa7Br/ZomkyFjzOTrK07/U3ephRpdcvhr?=
 =?us-ascii?Q?XAzEnTbNRDZPwMm+qTdWVIEHQOQw/YvIYCTsLadcRc89sCdhr6jrF8jLveGO?=
 =?us-ascii?Q?whnCmgYAjqCZyhGyL88h3adtY7JiHjjjwrkJT7x/Z5xvOW0VJfR8M3vXmLPY?=
 =?us-ascii?Q?08dcphC0HGODs5kq6w3D1xnC/X1P9/0USlFYQ/6KFcrQCaXhKX/dvuEOWUPP?=
 =?us-ascii?Q?MCyFmHn/ghoHnX3GXZgbv51g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzGl25lfwnrIk59MUWi7zz2UUlzHIW9kKeq66lzTJxmEiTMJzRSfY0VmYRPH?=
 =?us-ascii?Q?w8SXe64MEvOfEmpqnWLoeNK+KyfdTI2lbcVFtM0+I6kXNhycUWRtahPPc8jq?=
 =?us-ascii?Q?soaw4qu+BU6SsaJiI56S87WDpDCtbcOlx3p0XbtXRz0FdilSlP7EQ2+6MLcU?=
 =?us-ascii?Q?ZrCuYIVIAFYWCmfy8Hns5viHXDfRBAanjNbbogO66Rif6lTJf4PRsgjOPbPL?=
 =?us-ascii?Q?hAGFQrTr3SyuzIgHrQeJhgnTRFicDh4KrjfBuE7i64bAPp74GM1ynkDgnrzF?=
 =?us-ascii?Q?q/AChEV3CLPwcUb3X3fVpvmVzkT1KL0lBtN9VbNAxui+Gvu74pMAHFQISCYl?=
 =?us-ascii?Q?sFGkY0usWRmIUOBDu1r93GhcTXK7qpFCJ5LZBzCe4fWSnEVYlFCTLM1DOX+3?=
 =?us-ascii?Q?TDODxYsUhK7vOKT5HQJpSV/jYWUKeDQas/amsNE/0a8cIeiXwkPKkMf6bw9M?=
 =?us-ascii?Q?Jh/2pGqavbPoYracC4FQ4oNbsQP+R+fIIKlYyihk/VjuYld8fX0o8WWdV7ql?=
 =?us-ascii?Q?zDZ5L4SeyDQbT3RV5zshkzbFl0G4DSVApYtjS33mK4jcWb0KPu7DW2LCZD+Q?=
 =?us-ascii?Q?EO4Uiu1ZiChqKNi45xAvK35nHwJp/US+Xm+7Mm4cVvU6pNxYTdTRIYTz2+un?=
 =?us-ascii?Q?a7li8eFXrjmCbIwIBiH4+0qExM8wxqeslCaVAG3fOHKJOULUJCKalW8EFhAc?=
 =?us-ascii?Q?19i/9Ium6nzNAN9uAgfHiSYG7jUos4Lkl/CDinWl+XiUT8HM3NYsqC5h7o3S?=
 =?us-ascii?Q?oRdhb9CfKfX5xz+yzI+JiNoLAlRu/Aw0zkZSxng0S7V7y12XYRCPG+lA3NTs?=
 =?us-ascii?Q?7TQ5OxF5uxsAJhvX/ZbAxSDtLE7aES2xVUZkmghm97b/6JJnqaNSn2EhIktv?=
 =?us-ascii?Q?PgsHCHkxykJy8QqxvYQ2sYK3SiPrtgJrqu5F1gBmtugEb5gvIGH7O5LfIiHk?=
 =?us-ascii?Q?1NE9iApETtG6Uk+v+cjC5s5It8pRztm5RyYWx1MfsRuuaiCeASylh6yjVelC?=
 =?us-ascii?Q?NguIWRp4hViQNca9YXkqNjek3AUcgTzAkFnfuePwgLDVW4IUPbiJGi9Bcg5z?=
 =?us-ascii?Q?YaQwt3kspuo7OjsAmy6GXwyKJrLMu/F+GCvA2Cfwg0iBhaCGbveonfr90CvW?=
 =?us-ascii?Q?whVQ9fznQZUVhazd1/3lfutQ7oK1ALFl5Z8miK12lUZGKGG5nMBdqB4oraha?=
 =?us-ascii?Q?Bu8a9/v++twE8TVN1uZ6ftw+E12t0jfn8VIcpevjm77+Gde98wn1rohlLIAZ?=
 =?us-ascii?Q?oUGa3A/89K7tDFeT4dFIBWtCxbGPqMyzUPCin7dxoNXubq4tJ8Yso19JZXDG?=
 =?us-ascii?Q?5q40bI5T2Ey3S7To7CSzTua8saLfDtabJkIYS2Zw73kWPlu9b5TWmN8ukq/+?=
 =?us-ascii?Q?EqGwwzmFiK6AUXWoXFUEJrLvF0IG5Weno4tGtJKWRXkonaISp80+l9LRSTBY?=
 =?us-ascii?Q?xmM7S63X1qUB7Z9bONjObwuUKQ/HWinGyc8zlQifII730wV1FaKFp4gYouwW?=
 =?us-ascii?Q?4kOaJS8DMFshh9Shyh+xr9WDpTuBLrx5O5/CZzFUNsTZo6kkdmbcHAp68BrL?=
 =?us-ascii?Q?jVAA285oEqdTFPCLSsHAG6W4jjF7ybIoYRgdsozP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38614fef-59a2-46ba-853b-08dcf75ca597
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:27:26.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iykQ+mPHz5SEqoATvrLUU0ko6hAQci0Ot3Ed6LrUXUHa/ylliaTPtw5VuAKm6RI6Us57EiuAp9nIgsKWJ12gMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

On Fri, Oct 25, 2024 at 11:13:45AM +0000, Dhananjay Ugwekar wrote:
> Prepare for the addition of RAPL core energy counter support.
> 
> Replace the generic names with *_pkg*, to later on differentiate between 
> the scopes of the two different PMUs and their variables.
> 
> No functional change.
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Looks good to me, even though rapl_pkg_pmu_is_pkg_scope() is a bit
mouthful. But I cannot think of an alternative.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.



> ---
>  arch/x86/events/rapl.c | 118 ++++++++++++++++++++---------------------
>  1 file changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index bf6fee114294..ae8b450caa9b 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -70,18 +70,18 @@ MODULE_LICENSE("GPL");
>  /*
>   * RAPL energy status counters
>   */
> -enum perf_rapl_events {
> +enum perf_rapl_pkg_events {
>  	PERF_RAPL_PP0 = 0,		/* all cores */
>  	PERF_RAPL_PKG,			/* entire package */
>  	PERF_RAPL_RAM,			/* DRAM */
>  	PERF_RAPL_PP1,			/* gpu */
>  	PERF_RAPL_PSYS,			/* psys */
>  
> -	PERF_RAPL_MAX,
> -	NR_RAPL_DOMAINS = PERF_RAPL_MAX,
> +	PERF_RAPL_PKG_EVENTS_MAX,
> +	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>  };
>  
> -static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
> +static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>  	"pp0-core",
>  	"package",
>  	"dram",
> @@ -112,7 +112,7 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
>   *	     considered as either pkg-scope or die-scope, and we are considering
>   *	     them as die-scope.
>   */
> -#define rapl_pmu_is_pkg_scope()				\
> +#define rapl_pkg_pmu_is_pkg_scope()				\
>  	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
>  	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>  
> @@ -139,16 +139,16 @@ enum rapl_unit_quirk {
>  };
>  
>  struct rapl_model {
> -	struct perf_msr *rapl_msrs;
> -	unsigned long	events;
> +	struct perf_msr *rapl_pkg_msrs;
> +	unsigned long	pkg_events;
>  	unsigned int	msr_power_unit;
>  	enum rapl_unit_quirk	unit_quirk;
>  };
>  
>   /* 1/2^hw_unit Joule */
> -static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
> -static struct rapl_pmus *rapl_pmus;
> -static unsigned int rapl_cntr_mask;
> +static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
> +static struct rapl_pmus *rapl_pmus_pkg;
> +static unsigned int rapl_pkg_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  static struct rapl_model *rapl_model;
> @@ -159,7 +159,7 @@ static struct rapl_model *rapl_model;
>   */
>  static inline unsigned int get_rapl_pmu_idx(int cpu)
>  {
> -	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>  					 topology_logical_die_id(cpu);
>  }
>  
> @@ -172,7 +172,7 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>  
>  static inline u64 rapl_scale(u64 v, int cfg)
>  {
> -	if (cfg > NR_RAPL_DOMAINS) {
> +	if (cfg > NR_RAPL_PKG_DOMAINS) {
>  		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
>  		return v;
>  	}
> @@ -182,7 +182,7 @@ static inline u64 rapl_scale(u64 v, int cfg)
>  	 * or use ldexp(count, -32).
>  	 * Watts = Joules/Time delta
>  	 */
> -	return v << (32 - rapl_hw_unit[cfg - 1]);
> +	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
>  }
>  
>  static u64 rapl_event_update(struct perf_event *event)
> @@ -342,7 +342,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	struct rapl_pmu *rapl_pmu;
>  
>  	/* only look at RAPL events */
> -	if (event->attr.type != rapl_pmus->pmu.type)
> +	if (event->attr.type != rapl_pmus_pkg->pmu.type)
>  		return -ENOENT;
>  
>  	/* check only supported bits are set */
> @@ -352,14 +352,14 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> -	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
> +	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>  		return -EINVAL;
>  
> -	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
> +	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
>  	bit = cfg - 1;
>  
>  	/* check event supported */
> -	if (!(rapl_cntr_mask & (1 << bit)))
> +	if (!(rapl_pkg_cntr_mask & (1 << bit)))
>  		return -EINVAL;
>  
>  	/* unsupported modes and filters */
> @@ -367,11 +367,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  		return -EINVAL;
>  
>  	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
> -	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
> +	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
>  		return -EINVAL;
>  
>  	/* must be done before validate_group */
> -	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
> +	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
>  	if (!rapl_pmu)
>  		return -EINVAL;
>  
> @@ -525,11 +525,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
>  };
>  
>  /*
> - * Force to PERF_RAPL_MAX size due to:
> - * - perf_msr_probe(PERF_RAPL_MAX)
> + * Force to PERF_RAPL_PKG_EVENTS_MAX size due to:
> + * - perf_msr_probe(PERF_RAPL_PKG_EVENTS_MAX)
>   * - want to use same event codes across both architectures
>   */
> -static struct perf_msr amd_rapl_msrs[] = {
> +static struct perf_msr amd_rapl_pkg_msrs[] = {
>  	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
>  	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
>  	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
> @@ -545,8 +545,8 @@ static int rapl_check_hw_unit(void)
>  	/* protect rdmsrl() to handle virtualization */
>  	if (rdmsrl_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
>  		return -1;
> -	for (i = 0; i < NR_RAPL_DOMAINS; i++)
> -		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
> +	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
> +		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
>  
>  	switch (rapl_model->unit_quirk) {
>  	/*
> @@ -556,11 +556,11 @@ static int rapl_check_hw_unit(void)
>  	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
>  	 */
>  	case RAPL_UNIT_QUIRK_INTEL_HSW:
> -		rapl_hw_unit[PERF_RAPL_RAM] = 16;
> +		rapl_pkg_hw_unit[PERF_RAPL_RAM] = 16;
>  		break;
>  	/* SPR uses a fixed energy unit for Psys domain. */
>  	case RAPL_UNIT_QUIRK_INTEL_SPR:
> -		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
> +		rapl_pkg_hw_unit[PERF_RAPL_PSYS] = 0;
>  		break;
>  	default:
>  		break;
> @@ -575,9 +575,9 @@ static int rapl_check_hw_unit(void)
>  	 * if hw unit is 32, then we use 2 ms 1/200/2
>  	 */
>  	rapl_timer_ms = 2;
> -	if (rapl_hw_unit[0] < 32) {
> +	if (rapl_pkg_hw_unit[0] < 32) {
>  		rapl_timer_ms = (1000 / (2 * 100));
> -		rapl_timer_ms *= (1ULL << (32 - rapl_hw_unit[0] - 1));
> +		rapl_timer_ms *= (1ULL << (32 - rapl_pkg_hw_unit[0] - 1));
>  	}
>  	return 0;
>  }
> @@ -587,12 +587,12 @@ static void __init rapl_advertise(void)
>  	int i;
>  
>  	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
> -		hweight32(rapl_cntr_mask), rapl_timer_ms);
> +		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
>  
> -	for (i = 0; i < NR_RAPL_DOMAINS; i++) {
> -		if (rapl_cntr_mask & (1 << i)) {
> +	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
> +		if (rapl_pkg_cntr_mask & (1 << i)) {
>  			pr_info("hw unit of domain %s 2^-%d Joules\n",
> -				rapl_domain_names[i], rapl_hw_unit[i]);
> +				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
>  		}
>  	}
>  }
> @@ -673,71 +673,71 @@ static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_
>  }
>  
>  static struct rapl_model model_snb = {
> -	.events		= BIT(PERF_RAPL_PP0) |
> +	.pkg_events	= BIT(PERF_RAPL_PP0) |
>  			  BIT(PERF_RAPL_PKG) |
>  			  BIT(PERF_RAPL_PP1),
>  	.msr_power_unit = MSR_RAPL_POWER_UNIT,
> -	.rapl_msrs      = intel_rapl_msrs,
> +	.rapl_pkg_msrs	= intel_rapl_msrs,
>  };
>  
>  static struct rapl_model model_snbep = {
> -	.events		= BIT(PERF_RAPL_PP0) |
> +	.pkg_events	= BIT(PERF_RAPL_PP0) |
>  			  BIT(PERF_RAPL_PKG) |
>  			  BIT(PERF_RAPL_RAM),
>  	.msr_power_unit = MSR_RAPL_POWER_UNIT,
> -	.rapl_msrs      = intel_rapl_msrs,
> +	.rapl_pkg_msrs	= intel_rapl_msrs,
>  };
>  
>  static struct rapl_model model_hsw = {
> -	.events		= BIT(PERF_RAPL_PP0) |
> +	.pkg_events	= BIT(PERF_RAPL_PP0) |
>  			  BIT(PERF_RAPL_PKG) |
>  			  BIT(PERF_RAPL_RAM) |
>  			  BIT(PERF_RAPL_PP1),
>  	.msr_power_unit = MSR_RAPL_POWER_UNIT,
> -	.rapl_msrs      = intel_rapl_msrs,
> +	.rapl_pkg_msrs	= intel_rapl_msrs,
>  };
>  
>  static struct rapl_model model_hsx = {
> -	.events		= BIT(PERF_RAPL_PP0) |
> +	.pkg_events	= BIT(PERF_RAPL_PP0) |
>  			  BIT(PERF_RAPL_PKG) |
>  			  BIT(PERF_RAPL_RAM),
>  	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
>  	.msr_power_unit = MSR_RAPL_POWER_UNIT,
> -	.rapl_msrs      = intel_rapl_msrs,
> +	.rapl_pkg_msrs	= intel_rapl_msrs,
>  };
>  
>  static struct rapl_model model_knl = {
> -	.events		= BIT(PERF_RAPL_PKG) |
> +	.pkg_events	= BIT(PERF_RAPL_PKG) |
>  			  BIT(PERF_RAPL_RAM),
>  	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
>  	.msr_power_unit = MSR_RAPL_POWER_UNIT,
> -	.rapl_msrs      = intel_rapl_msrs,
> +	.rapl_pkg_msrs	= intel_rapl_msrs,
>  };
>  
>  static struct rapl_model model_skl = {
> -	.events		= BIT(PERF_RAPL_PP0) |
> +	.pkg_events	= BIT(PERF_RAPL_PP0) |
>  			  BIT(PERF_RAPL_PKG) |
>  			  BIT(PERF_RAPL_RAM) |
>  			  BIT(PERF_RAPL_PP1) |
>  			  BIT(PERF_RAPL_PSYS),
>  	.msr_power_unit = MSR_RAPL_POWER_UNIT,
> -	.rapl_msrs      = intel_rapl_msrs,
> +	.rapl_pkg_msrs      = intel_rapl_msrs,
>  };
>  
>  static struct rapl_model model_spr = {
> -	.events		= BIT(PERF_RAPL_PP0) |
> +	.pkg_events	= BIT(PERF_RAPL_PP0) |
>  			  BIT(PERF_RAPL_PKG) |
>  			  BIT(PERF_RAPL_RAM) |
>  			  BIT(PERF_RAPL_PSYS),
>  	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
>  	.msr_power_unit = MSR_RAPL_POWER_UNIT,
> -	.rapl_msrs      = intel_rapl_spr_msrs,
> +	.rapl_pkg_msrs	= intel_rapl_spr_msrs,
>  };
>  
>  static struct rapl_model model_amd_hygon = {
> -	.events		= BIT(PERF_RAPL_PKG),
> +	.pkg_events	= BIT(PERF_RAPL_PKG),
>  	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
> -	.rapl_msrs      = amd_rapl_msrs,
> +	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
>  };
>  
>  static const struct x86_cpu_id rapl_model_match[] __initconst = {
> @@ -793,11 +793,11 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
>  static int __init rapl_pmu_init(void)
>  {
>  	const struct x86_cpu_id *id;
> -	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
> +	int rapl_pkg_pmu_scope = PERF_PMU_SCOPE_DIE;
>  	int ret;
>  
> -	if (rapl_pmu_is_pkg_scope())
> -		rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
> +	if (rapl_pkg_pmu_is_pkg_scope())
> +		rapl_pkg_pmu_scope = PERF_PMU_SCOPE_PKG;
>  
>  	id = x86_match_cpu(rapl_model_match);
>  	if (!id)
> @@ -805,20 +805,20 @@ static int __init rapl_pmu_init(void)
>  
>  	rapl_model = (struct rapl_model *) id->driver_data;
>  
> -	rapl_msrs = rapl_model->rapl_msrs;
> +	rapl_msrs = rapl_model->rapl_pkg_msrs;
>  
> -	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
> -					false, (void *) &rapl_model->events);
> +	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
> +					false, (void *) &rapl_model->pkg_events);
>  
>  	ret = rapl_check_hw_unit();
>  	if (ret)
>  		return ret;
>  
> -	ret = init_rapl_pmus(&rapl_pmus, rapl_pmu_scope);
> +	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
>  	if (ret)
>  		return ret;
>  
> -	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
> +	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
>  	if (ret)
>  		goto out;
>  
> @@ -827,14 +827,14 @@ static int __init rapl_pmu_init(void)
>  
>  out:
>  	pr_warn("Initialization failed (%d), disabled\n", ret);
> -	cleanup_rapl_pmus(rapl_pmus);
> +	cleanup_rapl_pmus(rapl_pmus_pkg);
>  	return ret;
>  }
>  module_init(rapl_pmu_init);
>  
>  static void __exit intel_rapl_exit(void)
>  {
> -	perf_pmu_unregister(&rapl_pmus->pmu);
> -	cleanup_rapl_pmus(rapl_pmus);
> +	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
> +	cleanup_rapl_pmus(rapl_pmus_pkg);
>  }
>  module_exit(intel_rapl_exit);
> -- 
> 2.34.1
> 
