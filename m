Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52372192D67;
	Mon, 28 Oct 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104072; cv=fail; b=Yfb9CdeTqotJOZv/+9sTzNkACRKvHc/eBQUHVNmLsphcEtZRNYy8j9hTUhon8KDjrM09KvZ0F3IBf0tpJ0ERkJ0Av6689XU/h2o+5gNav3lMDa/BRWgRT7JM5R0YpN10nn0Dy1fj1ID9CVqXfXHeMe5NbaD1FGJglBcxLMaRf0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104072; c=relaxed/simple;
	bh=Bqfdne1e/yYlTuG7Z0vbrkI80h9AlQGDh/BX5eI3toU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sa6Enl8/2nEJLxwSRp95zUAyL5nA9L/Eja391KctwBW5JsTbL4/2v3bKtjxoCFqgZnvnXM6TC2yEmw9PsN1OU73Vm3UBziFIAeXvDUQ9z1fkEP+CSy1aiGDdKbWuelhaJc8XcnbbV5eQ0Pk6ZaJHsdZvLsMEx/+q1MZK9TOoxwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nzHfICbm; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nzHfICbm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFXd637kmQbsCC9P9iNd4BvkMATgh5Hjhh3LNhKgn5MGEYSe8VFnPYmDGY1exQ/6ApH8btyBOP5TIFnyHB1X88IPeysrNbxusivFwu08m2OWR3MKCHj4Ib44Qz24XekmQfxqoT4pj2C065ABTX9LgHi5INqklEi7wGrkNlfIXfgsYkjByNTMNs1VXrdCapKaqEwXPbSwPVQjoqD/tcOmN8ZcISS6hkHIZlSCHZzvwaXXNV/V0eTmQdBhv9HsCywN6kCorUmyii3v7Rils86X8XlEiv9nEl66pJhrUp+SWIMt0A5T6d8T/MC4hdDwH4ck3q1mAScoEJuxZgGuXoQL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fjuqcpu/LCqYS+mt4yOPGo/nRVpKK+S/J9don9te5R8=;
 b=ZLVntqeUUmBNg2UpbyxwuRwW7hLI27Kw95sbD74y7Hv5BSZMdZ1u02MxDaXBng6BvEjIVzbwJaz2wlcCjmgAITnZOIsM2tVkcPTgSw7UBhjf+6lrvzp49LOy6KK8glk02S4desoj/vW4U80KK66X01ThpwyGZVq27oZnhqBNKEPbUSI7ufSSxqQqB+yioZ4D09GpzYEJBNpW84yMRHX+BhPexVzAhRaw0T8dosBc0oJi//+0kvEz3aCzH0RD6q0xg0cleX/KBAKxpFH/iX3wR+FV4mkTBtm+weKpxTAlu0w006cYQHFYVUdVPvbADAgZNoctRBx0NEFR0C/4CKxgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fjuqcpu/LCqYS+mt4yOPGo/nRVpKK+S/J9don9te5R8=;
 b=nzHfICbm4970Sw4oGQIAj21U3EY/nqsh8ODnEh9KGqPBcjD3DH2/gEji1FXy7Sxm9azNZRfETHThukbHRwCy0JjjsnnZV9ybyZR5TylXOeEgJwbl1QVZP6WiD6gnAJa/7ateTkXGZOQOWxShNoJ0DsPnC7muoO2kC2Phgg9+mPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 08:27:46 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 08:27:45 +0000
Date: Mon, 28 Oct 2024 13:57:27 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, ananth.narayan@amd.com,
	kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH v6 02/10] x86/topology: Introduce
 topology_logical_core_id()
Message-ID: <Zx9K77OBe+ADuu1g@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-3-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-3-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN2PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::21) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9db57c-c139-4d99-b65f-08dcf72a65f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NtyL9kxlR/CzMaHjHifN/7mdXnXY7pNchuH9oUdwPJXGwurChdizaSnMTMY3?=
 =?us-ascii?Q?C12vkGJB0z+YoDZzP0or2khkNKra0qHLIly/8ZEp/fEIJ7YKd3+f7UJSrIho?=
 =?us-ascii?Q?aj4PldPAS+p3uooYkv08m8nuM1seAEdEBCgNOu1Tj1obvm8FpkZG1IErwAmc?=
 =?us-ascii?Q?ZociQSLH57s8aA9HmJHyBRaXaeWmyMh/Isla97NP1U24ljEn5fVwrqtFNTdu?=
 =?us-ascii?Q?q0LThn23ahIC+1aJZGe8lF1P2QFO21c3EHKlnysxkLjzMv2CvU4vedcEYdoP?=
 =?us-ascii?Q?0aFX/mD+2j0ZgtH9EEpLzzAHisPr97ndhMNRSBbmfNOJasimvZJSSUk9fxTl?=
 =?us-ascii?Q?SLc37n494azZSCGnJFBJ4WkjaWypcUFeluxTGFG6VrKDmVZOotn7tfPjSHhc?=
 =?us-ascii?Q?XXG73/kr9bLMxKYvXyo+9qKdHtIyNA5wUHHQ/XT9s0Z0Kejlbk+0nxIpR3gk?=
 =?us-ascii?Q?se/i8LHZbgCwiSzRd1ZslEEQX4JgSHDV6pZ/UO4LpyWPsfrfXEEQsegguVZu?=
 =?us-ascii?Q?NhAfb7vpjQyDVTzBkHWGE47THzJQYjPgZKDaxmX6FoDFYkgSti9+FQuBTsH5?=
 =?us-ascii?Q?mDVpe/eF0cTwMSV8hVCzKWiqqndUjYrDbYBPOlGPgMVr20r7gTC0lgncL0n5?=
 =?us-ascii?Q?H6l9CDIx9ljwdaDrMzHrOikW4tYA4Gw1DBN9ffPZ2vPbv54L74zFyfFwe96n?=
 =?us-ascii?Q?sfp8W5+iVsftDaMY0h2hSAL4WR4Ogkmh7yc5di5cR5pRLN3WQRttZ0DnlENe?=
 =?us-ascii?Q?jZ6L7DvLnQBapMB54pA7WhRyvBtSN25vIRhr50Civn6TvFLRUBR9VQuRSg/W?=
 =?us-ascii?Q?9u7lfCiHFBSkCpxG4SebMgRLz2mNmwZh6KJkI63IglJl0wEpfv79nU7lScQe?=
 =?us-ascii?Q?A+PwjRtu04P5wvOnt9cbErT3PGJwq8gkGBMBQFd8S3fET8fjAa8am5tmbiJ1?=
 =?us-ascii?Q?R7D1VvycU6+6zoeHSdgrEZUU9JHaUakwJ2/XZlG7ITnk1bxBNCZ3e2VJmwpF?=
 =?us-ascii?Q?/kGE/hEje/5po/NIj1LyGfutCpAxR9V294vsHKT6iNQV3olCksSS0/V1zbP5?=
 =?us-ascii?Q?fAsh3Z1PF2AT2gV1wTA3+7zK4Bm1rMQjXqwH9NNMqAq/e+gOS6xyPv3NYlPw?=
 =?us-ascii?Q?rNJQf+zVG5B6WO8/ZDZ+L2gGVL8M2JembX2GTLoquh2wN/fdTIlIdsMQ1F+r?=
 =?us-ascii?Q?t79Lfpul1yvEWiZ+Ou4l+/hgtrc28tXGDSPBUIn4jjcc76PBR3cfpzq9WVMj?=
 =?us-ascii?Q?oDo0CoqFgVHpacyWFbqL+HQGSg/uzBLwD9Nn1V8kTvcvu5vs3gNat1Acbk5W?=
 =?us-ascii?Q?xiHpY5tjYXGadjS7xR9lDzKR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bjl2+vm6xMSvsFqmIzXNv2d+tlwvpAoikoEnlbna8h65UNeGQyqp4cAlIKHA?=
 =?us-ascii?Q?pFHjELnyAe+s6dcmlcX5UdowM2Llfdnf2dEs6VAGrpUxinexx8l1uFNsn4P6?=
 =?us-ascii?Q?e6Ax99lazvanfMvWaGK6d+9aJDdqjw7gjqKKoBh6g101A2GXnSmIUo/GsLhs?=
 =?us-ascii?Q?t6R2QolppX2saaXBPAMZI06e/DOKzx16pWV/JycjEQrnhzSOEsuwYniNjqr/?=
 =?us-ascii?Q?gWblqbdxfmkJY2FtmYadva8hwBQUsgS8swqn0Z9sThisPFrRm+G3gDPjMuKI?=
 =?us-ascii?Q?7hnnQ9u86DRmmhzGEUwh+LwqJYwZjRTZvzpffQ1lInzNpl35Ej3rF7p7QDjN?=
 =?us-ascii?Q?+Jr5/JIasCfuiFhqOtl0M2JtVYQ0eG+5VPKUNJqQLoXDwNyRbixAUEMXzbmJ?=
 =?us-ascii?Q?Qy2kBjIuk0fczC0/hkAYR1KzAtOUMniN241nIs82uV6s9gqFLTqK036Cwp7j?=
 =?us-ascii?Q?ZTOTaSN1L+dqgOEzrwb2/nxQm3nfU4uuf251kz9Mu15Eg70OtadZFwCGMhNY?=
 =?us-ascii?Q?DsIIQ0SyoWswbQ+OlyN0TQxhROCRSX98wMs30gfzfcSPhLNF7XxShFa33PVX?=
 =?us-ascii?Q?yKkEE0Plexa/aRVgf7YPiBggAgzuU1Z7R78wj/oVJ7Ip+6mAbCh6jNtTIiJ3?=
 =?us-ascii?Q?iof4UgUGtZOdjhnTzKjEyovogVGwSJhPMybkjVTa1gpnl54pQeYmB1zWvtsm?=
 =?us-ascii?Q?VVo/eaXYBzR2UJOSk7K5lBBlXVDufLum1Op8xrkL3ZUDTaxC1+ZsTbdXY2LA?=
 =?us-ascii?Q?JxtvSRR7zjDRW+0MX50sDB4KFctPviLfXMU5KYqI+ljXTUwUjmUl0thXUtJd?=
 =?us-ascii?Q?aoaFOELGwXWNB4NkCyWUgViagSgwy+CsmH8sU2tZSPiDOE210X0OrbPLbqhl?=
 =?us-ascii?Q?bsYtHrPJsyjYmGsyeFmvjyzXUndNdwkrC46sxedlv1rjVtWeWtitbgH74GYG?=
 =?us-ascii?Q?QWNLEGfHWA/imOtsXVtXJMdja8MDOgi12OpHpJxa+dCASTfWVpNzLzj1zZ+m?=
 =?us-ascii?Q?ziGC7HbTPJcPt2lc4jxn3xRXACbRVFvGY0I7t/YaEDUKyJ4WAYVYF79qk0+D?=
 =?us-ascii?Q?QwVWNGLdxChY0LRfkTwZFnmfBi0Ye/GtmAVG7wAlh086Tx7Vo0jqoGemzwFs?=
 =?us-ascii?Q?LRo9e35pTSfC3JwETpJbeCQ/XNhbNlTzson7Ot3OGmaBHcEZwYznf4N737CG?=
 =?us-ascii?Q?Am/4F1kyqOvl9wK00h3tOFN/f91AniNDXW1zWCllW1rScXhfcTTfgeWdVzIr?=
 =?us-ascii?Q?hhoWbxtS3JKtgbykCFsIKx+RTyaYOh7nl5mLWfgtgAmUBzHIZEMXAXOo+mP1?=
 =?us-ascii?Q?pJha2xgD1M3OuJVk+og2vLq0I5lr1AzguxzfQoWnMQHCz5BI+wweafXpmrq2?=
 =?us-ascii?Q?yRrhcSV/79S0ILEzV3QpR4/0HqiciVrVqLetAl0cd+xuRlvVkiKdY4ebdiUy?=
 =?us-ascii?Q?rGzLZx/mlRUOqhAOa5jb8ndWAxTX3F9oqZzXrFS7Xo2vfeOdstWvzeP5zVV5?=
 =?us-ascii?Q?wqOKFzKV9C2BVpjRVhzDxdzqe6ajg1hju4jEQg6otQP9irI/S/N8D8kPZ6XP?=
 =?us-ascii?Q?xyIkBvQFq2ynKJj9uxQLbNBPIrQ/4CbWBpdFdodY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9db57c-c139-4d99-b65f-08dcf72a65f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 08:27:45.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9GMs5jfgcG4rj6hb/HuPkjux1fOuigeakIdH7y1hIM/8nqrFG12H3tTt1KmhhuMlluqzrx7S1iL1J2kK+Q8Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226

On Fri, Oct 25, 2024 at 11:13:40AM +0000, Dhananjay Ugwekar wrote:
> From: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> On x86, topology_core_id() returns a unique core ID within the PKG
> domain. Looking at match_smt() suggests that a core ID just needs to be
> unique within a LLC domain. For use cases such as the core RAPL PMU,
> there exists a need for a unique core ID across the entire system with
> multiple PKG domains. Introduce topology_logical_core_id() to derive a
> unique core ID across the system.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

LGTM

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

--
Thanks and Regards
gautham.

> ---
>  Documentation/arch/x86/topology.rst   | 4 ++++
>  arch/x86/include/asm/processor.h      | 1 +
>  arch/x86/include/asm/topology.h       | 1 +
>  arch/x86/kernel/cpu/debugfs.c         | 1 +
>  arch/x86/kernel/cpu/topology_common.c | 1 +
>  5 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
> index 7352ab89a55a..c12837e61bda 100644
> --- a/Documentation/arch/x86/topology.rst
> +++ b/Documentation/arch/x86/topology.rst
> @@ -135,6 +135,10 @@ Thread-related topology information in the kernel:
>      The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
>      "core_id."
>  
> +  - topology_logical_core_id();
> +
> +    The logical core ID to which a thread belongs.
> +
>  
>  
>  System topology examples
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 4a686f0e5dbf..595859cbf7ff 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -98,6 +98,7 @@ struct cpuinfo_topology {
>  	// Logical ID mappings
>  	u32			logical_pkg_id;
>  	u32			logical_die_id;
> +	u32			logical_core_id;
>  
>  	// AMD Node ID and Nodes per Package info
>  	u32			amd_node_id;
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index aef70336d624..672fccf9f845 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -137,6 +137,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
>  #define topology_logical_package_id(cpu)	(cpu_data(cpu).topo.logical_pkg_id)
>  #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
>  #define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
> +#define topology_logical_core_id(cpu)		(cpu_data(cpu).topo.logical_core_id)
>  #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
>  #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
>  #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
> diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
> index 3baf3e435834..b1eb6d7828db 100644
> --- a/arch/x86/kernel/cpu/debugfs.c
> +++ b/arch/x86/kernel/cpu/debugfs.c
> @@ -24,6 +24,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
>  	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
>  	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
>  	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
> +	seq_printf(m, "logical_core_id:     %u\n", c->topo.logical_core_id);
>  	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
>  	seq_printf(m, "l2c_id:              %u\n", c->topo.l2c_id);
>  	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index 9a6069e7133c..23722aa21e2f 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -151,6 +151,7 @@ static void topo_set_ids(struct topo_scan *tscan, bool early)
>  	if (!early) {
>  		c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
>  		c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
> +		c->topo.logical_core_id = topology_get_logical_id(apicid, TOPO_CORE_DOMAIN);
>  	}
>  
>  	/* Package relative core ID */
> -- 
> 2.34.1
> 
