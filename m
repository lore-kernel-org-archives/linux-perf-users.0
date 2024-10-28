Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CF18A92C;
	Mon, 28 Oct 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730095998; cv=fail; b=rKikX70VvS2BE3NoQ5NghoTtD0gmWcZU2XKwv7Edky1ncIzf28tx04q48cRcIpqY/FpRMHTWEUwXdO0Io38eknBgrCfSIq3LtCPUmLUus4mVSZy2H1pPuFPd5OWVwNsr+BgM2zMNtI4vZlOM0BVgqA2PwKJcs8wAObzOc4oWrJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730095998; c=relaxed/simple;
	bh=mvffEVszlAo/nNHH4B4EctSt0ZLguEqUh2sqe2r+Je8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ss5GMjmOSI+DmglBRTqIL5uytadK8P5FFPsawbo4SimS2UI/spd7+0yJbJ02pKZc1K5lpiAdlHw4U1C6qHWc380SopL0GRIGotPSZET4RrfzgKvffGIbT9SmUlRiuZpzYQRoyeZXCY8YaLzYNeRx/6evm8p2pWuKO6MWXm0u2So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BddidM2x; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BddidM2x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl3pnpVY3D95hkuQ7zhQE6ocsW/yngXAYeefC72UqclPUEv5wPGHqezh3VCxhn6nG654uI5wVynTvjbeyxinJLmO6XpZN+CQb9lbzE5EsasXynl9lWufJ8SrHy2QqMIMNXU0uFjd05Ioee05OTIiaAOTkVK0Wpa84FUwdLh7OF0KjOaKPUkS/aPZODObVk3WmjTp+aPUZ6dalugPHLLOs9pv/AwIDiwnYyXIAJyLGVjzOsE4ME2H4Pa4t5KgpTGjYchRKoEwITmS7QFQEkAvxMSLot9n0D8aFptn6Bi5tG0Hxd64SbM7c/mjmJZHklFd+36ilW/+Sj38wmZFozOhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvjYe24q2kRGN/usIBdQq/cXfP/mhw4OxmttNValpjI=;
 b=CY+6xqS6bNq9VA7S0pm9z7i3yRj+zKHGnjXKwkblPdl61+tFE4GkcsXsFir2oCCJ5h2nn2cNC1kA0LnXGjkR2+4PoT9YMXUNHBG6ollmqI8d5klo54pcywTtd/CQINZAtXvZzhIj9k1HiFOFof7yv4zGLxbRj97eQsDDd7m6RjwVkxwlsO82bTtC1iroZWhkTFr4YkBcxlVNUB4GBJE85rPt0d/1P++6aJ6wEsYZzAxDMD63g3NKJUQd2dW01zlXOtLXvGv1Wd+9MERpPOHoKQz5tLdIpd05uq45OYibcb3YB1bY/NMmzYPQ7tQJFVn41vVtTw79rnBYcaQBAz7VHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvjYe24q2kRGN/usIBdQq/cXfP/mhw4OxmttNValpjI=;
 b=BddidM2xhcWbyrQBd5xcn2/eRHDVZKgvoBUN/23FwAnVp37ZmX5Vob9wypfIpVX/oko7gBB3xI2Zg+kAX55R6gB5skUImug7RvAamyAMbWxvcdf2tGhMxhyEpcWAULEfCeuKtl2P5IEhQuYULzaZ4EuKs4kIvcaGkPh7hdUgGos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 06:13:12 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 06:13:12 +0000
Date: Mon, 28 Oct 2024 11:42:58 +0530
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
Subject: Re: [PATCH v6 01/10] perf/x86/rapl: Remove the unused
 get_rapl_pmu_cpumask() function
Message-ID: <Zx8ragiP5JBVuKvy@BLRRASHENOY1.amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-2-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025111348.3810-2-Dhananjay.Ugwekar@amd.com>
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f5c83e-9178-4da0-7f22-08dcf71799e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aTDQ1t/l/ihoql/3wusvXee0AzOdpA6ToRMtTxnx9qnVOzhzg3SF31oTVLgo?=
 =?us-ascii?Q?WtIEemmwX4b8Nww6esvK1fYRzLv5bE2v6cwrBSRQe8JfywVBwGHFrvV8HLSU?=
 =?us-ascii?Q?sIIISREBsMSJmoUA0Zm6L10yEnhTQlRi+LumGMYGCrxCdR2hGeOcA/RJJCgs?=
 =?us-ascii?Q?BfhEtvoxvWT+O0Mt/OZdSPP0U8+miD4MHbMuksJkUy8AeD4f/WP1WutdQHcB?=
 =?us-ascii?Q?hWK/BgQhsRWhXxAc4V8Imm5WwKz5MYisgWzWDhkXYAOFOUThVOeRc11Rm17u?=
 =?us-ascii?Q?0dcLIxRv6EIAg+KGco9TnI72RQj1SkBNSRy9/q+hj3NuVaqpOBP8EGNWmXrE?=
 =?us-ascii?Q?V9/5UKfqR4hPdYpcP0TPQSOD/C7t+MAjh7QU5wx5qZy0VP0oUUHg/iPD2hAe?=
 =?us-ascii?Q?bjIGk0/2Xx3W5ORa0e6U/vWdplm6xJ26uy0QYI0nGdX2ETNlW7eIZojLfza8?=
 =?us-ascii?Q?Dp6tZRYA4d1FWLFKFY6iumQdPW5flz4YQ2CDzWXZ3cnEgqdE905VjDb/Rfeu?=
 =?us-ascii?Q?oful/fSXhbD+MC/cve5FJsq0LUEAMuBrcCxRgeuAZj7YECTLp4Wc7gVRfrr7?=
 =?us-ascii?Q?lDX017FcAklo8n5otxKBKy1++abl+cAUc7ywn4PiSe0qJiYQmfroFwgURcZu?=
 =?us-ascii?Q?4lrV2tAa8K96Lv6wKiiicz9P61KrOHOHxvwraNvW+GzQWCJEcIAtvP6oKYN1?=
 =?us-ascii?Q?Ta7L8o/z3QLSCn3gDwCoRDwUH/MM+TbLjiTNLh6SGsfGObTccKLUvWlAvT62?=
 =?us-ascii?Q?QyUkMGsuYjf4hZzOEAHKStTjNij7WD3AHyM9QlOfSTGwvGirsLh9KEfWvyAr?=
 =?us-ascii?Q?WiZ/TN8FpbCI0UQMiAqORTemB8sN/7nvkd2FDUugSyJcqRMA/iq+d4Kf7Otp?=
 =?us-ascii?Q?W3cBgg1/Y+eBHR/Eme3b2ILtqCxyAouEsqUwbvhdQDtcM90Ahgc49Vs2/ALG?=
 =?us-ascii?Q?+rq5LwIZHWSWfBNuJwGdHqi0GojEUrwM0xVplJcq0jq+ZjR68C8D2Wa4kKmP?=
 =?us-ascii?Q?9tthSVit5gSDRA7UO7THaQs/4GYltT+dvHRWMTnzygN4ogP7McmBAX9VDvAl?=
 =?us-ascii?Q?lbwl6h2MBNI1kZms1gdAUb0gbjYOnVKgGfVxpI8kx8R9QCDNyLW9Q/172vYG?=
 =?us-ascii?Q?gppat6Szne40FiFD4BSO2hOzGoZvZk5K/8PBlEw7V2Gafk+x+CniTtMaLP+U?=
 =?us-ascii?Q?hHbBdjWU8ao1VKpA/mPbY1yS+ApqOXR3+tInYzdlEIyLvPzePAbVcQabyoWT?=
 =?us-ascii?Q?ImzEPEvgbTTYN35vNC/GXzyfGVj3KXDNWnWPRxuPGoBNFyHXYhcN9U4FaHoF?=
 =?us-ascii?Q?hFJBOQVMRZk6CcnnVf2pD2dd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4fdsslLfd3SrawLx20oyi3y84GdHF242HGt37D4BDUFMQ9tLe1f40uYtHWSj?=
 =?us-ascii?Q?qkOo1/EjcdbdikC6rTlo3DWkSKvhxuwf1ZJoEpZw0MuVXFyLcOzI/g/mCB4T?=
 =?us-ascii?Q?fR5DFRgjA432fhH14FnmMO5qATUd8ZyGBjGmdGKaKkUUKpwCq6oSmZska2n9?=
 =?us-ascii?Q?HFUOtp8evwr+0EMDiniXpUQmI9UKnbuUVqSL5WCbiAqc6xgOHhah3/7tMU+T?=
 =?us-ascii?Q?7ygdOhngiWMqPm0EYpRbgmXUCTVsdiC+JiuRgeUXW/JZF28/Lnq3g8XkyD8R?=
 =?us-ascii?Q?fTTDIUI93Fgpc85/tINjg/f5wIyS+8VnD3ILWtC+h0XUUgXf6Ikuoftcln9W?=
 =?us-ascii?Q?8x5vvkZO7v/qMDA/EFWGet1AbE9Y3dA62EBYCQJB2cUp1ydzR+omfvRB4Mnd?=
 =?us-ascii?Q?sDJnTq2R+w+BI4QcAfjNQXueQtJOOvJuA9VrxSD38ia2POQ7uHUZXLM6GHG2?=
 =?us-ascii?Q?Lvhv8gyFtfTSGkFlNymeJ+OW9veLn6GZyqHLQWUVFI+ltleZ5/9ctUYdUI8q?=
 =?us-ascii?Q?Fp2GL2lpoYWUWAwRznEhxc2O+T765dckZUADWTPRcEqnJ809uM5xmi0Yf0aM?=
 =?us-ascii?Q?eGt3ZzxygIWjHLmhznFK+Ad8LxPvxN9GPsKXtOLLRIVwuwvlk4eeRNnagRvo?=
 =?us-ascii?Q?2H4i8QUj8uSALFafGctz4zOcchf5XQoDWY84yPTt5C55Fuc+kv24YFIh1I8P?=
 =?us-ascii?Q?9+3Rc/TmchAsek+SaQ/0IhS0rUy0mW/os8AV2/hkZ8/jCO9O5u2SwZWIiVwM?=
 =?us-ascii?Q?x2ttQziuUTuvklIPw1WV+0gGSsJQxaNiCjjju7acRh8NYQ2mDo6WNnB4A2B1?=
 =?us-ascii?Q?cVerw4gxlwTnmvZBRvNsi/sp+pTuNCmWZS/LIJKz7af9Af4sRgqpo5ouqgyz?=
 =?us-ascii?Q?TNmCIpaCIUthTjf9+Ej+xFTHsIjWfYjixseJf/fs2VmHXbAANh9laYsiGb3/?=
 =?us-ascii?Q?kxfGgs8AmKre/F7qIYNVw4BagUpUSJgeUeNSp24NtL5BL724AC8gZlfTWQJH?=
 =?us-ascii?Q?EwrLp1UNqhnbLXg0o35mbbgJnDqv3LGG7qZrnS+kZs3nVhlhg+bJ6wHsSW3z?=
 =?us-ascii?Q?wqRh1XoeFG1GvcZH2KkC5I0MTyRR0zJzmolNRz90iiSnmKpB4kj8MvkHO+Vd?=
 =?us-ascii?Q?2dLFhs0CfgLWmy0pIq50GZrb7YtIiiOCmsid8o8JY4ZwSJml+Lh5Vg2LS3FU?=
 =?us-ascii?Q?hEfqP8G5PxPCHc+uZZ3Lk96aWuBS0NGkszX86ISkIqb4xwhIt67uMd1acwtm?=
 =?us-ascii?Q?TH+eFs9tgJCWiTbCKAXWizp66wMDNxh3Km/3+upTTxgvoJGVCep4Jkruiwxf?=
 =?us-ascii?Q?YIj/aRIRlUuMlpEytWKgs8s80r9Dnu4pH9UM+QEZP5NfzcWjEB4p+YgepjoD?=
 =?us-ascii?Q?bv3HepEOejjW2QEKbT9okyQSd96m0V7TBPB823GxrfYIMXC2aeiXym4hh4mo?=
 =?us-ascii?Q?E8M5cmXzKsu0zJD4eAtRvX6CN7yoUGNNvHNwCX9azLd71vRscNXHtbiFu34B?=
 =?us-ascii?Q?thGLbC56QcWOssfxqrOb9zvuzwFcOz8J9fgD8ImgatHjWDxtdJxx32BbjSDa?=
 =?us-ascii?Q?dw9TMSjDAs0/6U4RcqY3lfOakG0uOvr2bUiyQwOo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f5c83e-9178-4da0-7f22-08dcf71799e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:13:12.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbcQuNiz7Ezoey4qQTBFjpp/mLF4vWZxdAwNNkCKdr4W4IS2aGycOXsC9BqrbwIEQCrYSY2uB5h68djy9ygzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973

Hello Dhananjay,

On Fri, Oct 25, 2024 at 11:13:39AM +0000, Dhananjay Ugwekar wrote:
> An earlier commit eliminates the need for this function, so remove it.

If the commit is merged, please provide the commit id. If it is not
merged, please share the shortlog here with the link to the patch on
the mailing list.

--
Thanks and Regards
gautham.

> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> ---
>  arch/x86/events/rapl.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index a8defc813c36..f70c49ca0ef3 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -153,7 +153,7 @@ static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
>  /*
> - * Helper functions to get the correct topology macros according to the
> + * Helper function to get the correct topology id according to the
>   * RAPL PMU scope.
>   */
>  static inline unsigned int get_rapl_pmu_idx(int cpu)
> @@ -162,12 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
>  					 topology_logical_die_id(cpu);
>  }
>  
> -static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
> -{
> -	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
> -					 topology_die_cpumask(cpu);
> -}
> -
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
>  	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
> -- 
> 2.34.1
> 
