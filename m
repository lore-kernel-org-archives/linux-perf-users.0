Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CC20F970
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541611; cv=fail; b=QF6rkEMnsEyGM3fxPl90lTGhKsWAYCKtpiO16Kalx0NVYGFBpove8yocES3DcKO+lr+tvTnVFmgYV7lNJrLuKV0jkMtM3YODcJFBgFCb8bA46j2uoXSOXZB/xTQYFGGYvmuFyirZnJQ2z3T6W9vvJ+AbVXpKzotHawJDZbbJUdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541611; c=relaxed/simple;
	bh=O81VTyihCelyIHwRuvuPhkcT+m+hQ/59Gx07gxT2OTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NXPgV/IlneFMCTk3WDYnwQ+HEXgDnOavePP1+UdTyakpu7iIXY9N9XbPh/88Y5a0Me/pmXfTWQlDKXYgxlS8350FJXePG70IFDTLrk/Q5GIrYZWIjXiOEdqR/XNTYeqEHEt/Poojzcrjr48FtlYZJNPCO3UYz40WMz7GospiDt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjcBSyY5; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjcBSyY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737541609; x=1769077609;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O81VTyihCelyIHwRuvuPhkcT+m+hQ/59Gx07gxT2OTc=;
  b=ZjcBSyY5oWY713yvmSl00Ee3739IRcOaRELOiaT+ftdMPTNYi2nr4K4C
   68fGpFIIesUBKvDtyc8HDmrSQWx4qXkFXOGJciZKzNYh0dXc1LIRSdGJG
   z4s9b+sm5sI2QJ1xsTB4p1tcU/6Jp9oeKj6P/QvatIm8OtP2yoSU1pHIn
   SCttUQEMtv9+VSKsksBudwXkRVHa8sh+sp63JDSdBi2KJE1yH/nSFP0vx
   HKGDdJsK1RcevAH4HoyxjY4JFlsVcTIkvMf4+I43ybQ57byiGMzmwT07+
   jIYKLrX/S3GLH3zgdbcLA6nnWsD06zwbinKjidmOY+rxGyEEstcZb2/TK
   A==;
X-CSE-ConnectionGUID: 7Azk6AgYQ+S46SV1USfdmQ==
X-CSE-MsgGUID: omgacnrzSAySF5iBLj6Ygg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37870191"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="37870191"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 02:26:48 -0800
X-CSE-ConnectionGUID: L22OHdYERH+l8aqNVsGzVQ==
X-CSE-MsgGUID: GvdcvB4sRg28KxRLRibC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137975060"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 02:26:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 02:26:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 02:26:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 02:26:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGsoHo2GoGZJM6btB1DNz/AOxG85u9G2jvdROSkuX26E2ctDn3VFxYalhqpm16kBQ6R6QzK5ur0w8xJElAg7ltkDIMiwOSIM2GXgejJErR7BLmdlyDrjwcMqomRKJNt38+FquxK2r1SG0B2jKxSsZK17eKnvslPI3MIOGaAFXYtlA6Ox9G08lcKNNi3zY8IQu3zA015UaxoXz9Gc5/xFT1veHJmj43aDe/3no4jaua/PO3qxm8rbSsZDQQr/UyFJO3kDm3Fig1/wssbPAWflcsAluAzXj2Y6KnCAf5OVxnS4K29gP0BfSYCe4tszlAyVjlQEFJK+Qb8KPyZihKn//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUD/tcado0z2TjnOFExJrwidofWxxL68R6bTQj9B+aU=;
 b=xiRIbz1ZVwvHfCDIAmDZEo1TqFsEjo+Dbcs9Oh1RwiR0TgaeRDYOStp5UM78BxsvlQ37J8lB34753A/Ja5hqjyZ1N7btJneWzofmbsq1PEjX5Gl88fnFUdpFAcDYJnkImA5LSFb/EGCkkbLqac4hQEJBGVePRQMmg5aEgeaWUjt/lF8/X2ev788INu+u548PNYHZcFajqWB21UJJvLP3q1RylwfiN8+ybdET8rWHLcQaKTm/GUINEE9aTwoKORh7G7nMYPDEom+1T/XgHeVldGvBZjrEqi23DSMu3fKvEDA75gZkUyASZWpSWnCmepvp+N+M1b5i6B11dXgi9WPTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7SPRMB0046.namprd11.prod.outlook.com (2603:10b6:510:1f6::20)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 10:26:45 +0000
Received: from PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc]) by PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 10:26:45 +0000
Date: Wed, 22 Jan 2025 05:26:41 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v14 6/7] drm/xe/pmu: Get/put runtime pm on event init
Message-ID: <Z5DH4dVikf7nbJft@intel.com>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
 <20250122062341.1100173-7-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122062341.1100173-7-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To PH7SPRMB0046.namprd11.prod.outlook.com
 (2603:10b6:510:1f6::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0046:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: b57f0a4c-fdf9-40c8-3882-08dd3acf4552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bvhk5KlQAubMLD3EGcq6/sycoYqVPSkoRpj50GYCBTkpDjdn86q1pJrjYqy7?=
 =?us-ascii?Q?hEJYQe/GDJ3Tgd262BLqlUlJZlJzzRarOq+3MqlO5vagNJoGeuqxBlJWTCc+?=
 =?us-ascii?Q?1MIPpcezzRNn9Rojgs43phegZQEc+UP4AnXCG47djM+YqqqIHJ/Lww3bb+68?=
 =?us-ascii?Q?gro3zxPVE6Rl4SMNK6kKXt3bGTxbh2TiNkGBRISdIsKQ1Or6FFiJpdgHV6eD?=
 =?us-ascii?Q?Wk3gqwYF0gRTkHzam4HyjZxITti7LNuHT+KHEMZSwISNFDDS1+5tpxrZbwVf?=
 =?us-ascii?Q?DIHonwtEDwmA3KhIeKqYt8zPh+mSkhrkBET2xadWm9OzjSI1xD3js1E4aAT4?=
 =?us-ascii?Q?Bvl57qNoQE5Hj0iNabVB/GZhp9rWLTwa9p+bQgLsBz7K0L3OLdL0tLjFkg5q?=
 =?us-ascii?Q?nzpxzc/8LoImJXI3ra3xkfdbhKVlTRfBPk86/VefdqKcIaFBqSDe416kNtCB?=
 =?us-ascii?Q?PJCV9RsxP8rz1IMaw6ANSBY5o9gXHt89msQeHbusmMNhPyMA9WE9BEfrzCjn?=
 =?us-ascii?Q?NFlit7OMK8kw5bGAcNpmHooq/Lwh+b2pUrZxkLqcP21IGEMakVaALopxipf+?=
 =?us-ascii?Q?ujbaUGLdrO3AFiV+LjZ4qtk5bv/Th4KlqXJD6BcTHns7xF0X7ZgZOAGWoM+I?=
 =?us-ascii?Q?X5IyOs6EcvYb4yl+bitWEAaE1ssAwjwzinLzjSH4L1QzeZ2V1PMT2NM2Mw2G?=
 =?us-ascii?Q?4g70TUUF/yZ/QaNp5cBMRRnUhOPYv/zbeqCySm51OCdW0j9pEw8h+j5Rnfi5?=
 =?us-ascii?Q?Kkpo6Iz+H+4TeINbcZ3zl/ufh/TdgZeYYl2GjbV6q0fNCWeW1ueXs83KPbhp?=
 =?us-ascii?Q?79xz5eOVgfi/YzFnrg3TPDY/E6lUFpgbor+hQ0xUyhzsqjtvZ7bfgznDaP/z?=
 =?us-ascii?Q?NFWgEkv5XV+PgJ8TvPA5X5wumatlz5e06SuYQZZhYUbhKeTBWOof1jNA6CsA?=
 =?us-ascii?Q?PTYKJGLOrLFkrG+eG1n9P2OJLqCb0skOsc5/waT0Ll82WdVJkBk128IjheSy?=
 =?us-ascii?Q?7nX4eJxSS75g/BKYAw3LngcA1kImsT6lPgKgs202oAkt8PPP7NwpZmhyCcSE?=
 =?us-ascii?Q?pciBYpZzpZHc6N6aOBjCqz3TQmj3FuZyEsGumgyk1YZDHDY06eD50J2Zi8ZF?=
 =?us-ascii?Q?at+aS+bvqVoqezM82D2LkWcuPcC6/kYBOmn8VIG1nn0IBeDBHzV4hT7DenMF?=
 =?us-ascii?Q?SoiilMtWlc0dFhrT7lOsWfeOSTNvh1L2GU05m8nG8osacXpSaMLpTEKwxbgR?=
 =?us-ascii?Q?j4zsGATGZrh/1Xi4XIXZZvDEkYqLIURBG+W0gBPzPN29zggmHf3smSo0vYEW?=
 =?us-ascii?Q?PGbW/+Gk+1tDe0yI7+M0OTSXVii58nGdS9Q23bix+dJJJFkmoN00VIxr8q34?=
 =?us-ascii?Q?gK8WgRvwqtGsmKHLBhSV7x1kR4Nb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0046.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/UqefFFnIhAPdeyM+04gRQAVFq5E/3T49uSO0uYt9rc6+A04Ei7p4pRX8+/?=
 =?us-ascii?Q?tGrqq+8A15FFA2meqGGjacLRnkZaDRK6ZVTMd3Dt5geg2fZ109UYMgZ35tmk?=
 =?us-ascii?Q?qBmVBxK9X8ekYZ5Smpiy+H1va7hw8pgYFVfV1OMHkd/lLub6990VAKYxI11J?=
 =?us-ascii?Q?LJvCB+vGdFQpl1m/5Eg9StCne9A/azSxCGaoreXnrOzlR3D67qQcZHVcoVCH?=
 =?us-ascii?Q?e0Jfl5T4xU6N/iB6p/iXjhyhJgFccuXnViYusdomck2ytFPAoBxwTnYLWw9j?=
 =?us-ascii?Q?TFomXrwwO+WJtT7OmW8KLjJy8xsgoL9onSqLUCjgVCrNSvdZ5KTUz4Ro/onJ?=
 =?us-ascii?Q?B5Owly0WiY3RU9kp/yLOdiodepraKK87Dsu6XAUoVY9POinWCnhOpBF6W6+t?=
 =?us-ascii?Q?pivXXDVXaxvngWnmCo6xNZoV4wMTXVoGExQWtmphI5IIA4LxBnHkyeeXv77H?=
 =?us-ascii?Q?v+dGLjDQcz4dME01v3Ij6NaCh44ND3N14TvMCQYth70qB5Gd8ZbcjK/m/0No?=
 =?us-ascii?Q?pISlL1hgNJ7OgZ5XpwlLVw7Um6uNZRQO++khf5otFy8zGADU4v8sQEVDzkgL?=
 =?us-ascii?Q?dPTFoYEINwfGYhZcLGYBx6EaxEsdGoeRKzsJgc/FPi53pHYCxas8kcErB3TK?=
 =?us-ascii?Q?7L5MB95g+xalJYR9BEiLSkMrKkqxK5XjWqzFL8HmIehVMncsSalGGnP9uOPI?=
 =?us-ascii?Q?1rlCcyxJCyEoYDD8ndidLdkP8RSmuVpCW9ccvlua9A/QlmYD0Ksr1AaSXLLI?=
 =?us-ascii?Q?psCj2oncyLs6vjENM/iDYIixeebJ2XLH0Jp6qgsKe8bww51oS691oKC1TopN?=
 =?us-ascii?Q?+FQsxN4mYN5taMSw2e+HjwqOyGI0zh5XfQ+BHNl4NmmUZolhbP/315J0vCYW?=
 =?us-ascii?Q?4RjrMD7Jx47VZscHP6VXfhweaJAmUbwAY6iVAIl/4xllC6ESwOKB7u0lMGI9?=
 =?us-ascii?Q?YUybkOW269/C+G1hKrjWqEjlLSERQH1Sud1aFPq+7bRg/FIR36hMDUfZzk8S?=
 =?us-ascii?Q?7QmMsWDyH1owXkpUcO+4jNJtKt/wd1U6AvAtjVhsDcYRNFLJKn9P6dmXMgZq?=
 =?us-ascii?Q?/bqG4KjmOFtBpCq2blemdZQzrXa6M/xJOXbkRa8TwztHkzW8jtWW9GV6zb61?=
 =?us-ascii?Q?CHLa7jbOPe2QwxAcSCOSDbxGCJsAuoR1Qgr2Tym40JgUr1uD0EDyDrjoC4SQ?=
 =?us-ascii?Q?aSIbpPVIGDveFEykq7XWtGdy2QhKMeRnx8VmpF6GLWHXOFKfj4xz4SkO3YJA?=
 =?us-ascii?Q?crvF1RuU9QNxsk7ZOEaaT3EaIsAg6aIFJH0zgIhUFrK24wefQXA9fTvv6M0g?=
 =?us-ascii?Q?uixL/FaRV/OBd5l3FtNBIw64HfvUWtcOYf2qCdisNY2LIZLsSRy1MbDItjeU?=
 =?us-ascii?Q?Epl/WzbsvUVvBOLbMYm7rV7I2FKRDumMpbOEdBIHyOQMPwojRJULGgDV72j0?=
 =?us-ascii?Q?9RH1c7dHD162SjBziXblGC94IYu3u9dFltKEHkQmCh1y2c4syiIn7skzyNH9?=
 =?us-ascii?Q?C98QF00HJVuSpFlDHaqnXHZevci/kiEN5LX8TXf2UvXU6j0B7dLNtp/XBWQw?=
 =?us-ascii?Q?XIsOUTbbr0FapGMqSOUMpcf9QFg/6CI1hT2MKlsp0cKh89jShV41r3Ftzac2?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f0a4c-fdf9-40c8-3882-08dd3acf4552
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0046.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:26:45.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQDIkihP0bEENXi4jNdPvZeMNVP3xmG6mpk3vz89WSMqwSvnPOMmG7qkNXahTlEtGY6har8xVue3SGPgYgS0aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com

On Tue, Jan 21, 2025 at 10:23:40PM -0800, Lucas De Marchi wrote:
> When the event is created, make sure runtime pm is taken and later put:
> in order to read an event counter the GPU needs to remain accessible and
> doing a get/put during perf's read is not possible it's holding a
> raw_spinlock.
> 
> Suggested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/xe_pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index 68ebec1746a53..8d938d67c1f2c 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -79,6 +79,7 @@ static void xe_pmu_event_destroy(struct perf_event *event)
>  	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
>  
>  	drm_WARN_ON(&xe->drm, event->parent);
> +	xe_pm_runtime_put(xe);
>  	drm_dev_put(&xe->drm);
>  }
>  
> @@ -111,6 +112,7 @@ static int xe_pmu_event_init(struct perf_event *event)
>  
>  	if (!event->parent) {
>  		drm_dev_get(&xe->drm);
> +		xe_pm_runtime_get(xe);
>  		event->destroy = xe_pmu_event_destroy;
>  	}
>  
> -- 
> 2.48.0
> 
