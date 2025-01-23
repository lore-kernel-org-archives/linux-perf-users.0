Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0B20CCCC
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627220; cv=fail; b=iaF54f5slFxi7uEYZ0xaob789Bxd78KkRhWJv/BcOSaxtAklqR0b61ueulWVwXGKXps/4aeES9Hbv3OqgJjNBw9mjomW2AgvTnfE0gXTDrgooIr/uW8CunMmh7pBqMsjgxjqWR/Q15si2S/g3O2owRFdNtEA0HsRTXI0D+D/sp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627220; c=relaxed/simple;
	bh=8xdHZ2oh/D6ALYZ9URSIFDOH6bWW5sd6I7jk1GxsRhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R5e2YBCG8CF7IIQDYGx2+Ko0OElza7U8wj7fzx5Pf4+l9VY5HC6gTyI6jrZb7EX856jq8jYNStBcnMzK7l/khnCF0SXJ8tNbUr6cQNR3raTtHEQxxsVpj6L1HM/n6g3Tfgv5o6gzTlgv2x+6NhWwQdM78Qrg0ASKz3C2V5iIxj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDh++Kp1; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDh++Kp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737627219; x=1769163219;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8xdHZ2oh/D6ALYZ9URSIFDOH6bWW5sd6I7jk1GxsRhM=;
  b=kDh++Kp1JtsWzmSQ/FvL+goFsJzJr5UsaXAMKL3dsJV03M9EOWMEdh4y
   UkoOplZqDMyFoS9Gh44ER2nDjkbKyTXXkJ4SqCA9MBH2CCs7Zyshoo9Hi
   X1bVhfixFiuGq3SvFatNYTi41uP9sR/yoniQYepxc7EE7xIQdCUdXwnS3
   3kUmeRXEuE/AkIpiy34rE3fR1+U9lV3N0fqjgCJOS4Pb3yKVuP4ESWTBR
   IxqBjb6diKCUsW0eGhobUHl0kEW1Vi6JW1z9e/+CTDYYmVo+CTmgNUM5s
   bwjBf2xOxKIBKJaMef9+B1t4+hCRnbBlp1UAEA1ywEnQdNtDvNnlorZBW
   A==;
X-CSE-ConnectionGUID: /CTAn5rgQg2SO2ca4el0Hg==
X-CSE-MsgGUID: gsPh4cHfRbmA6YTr9jcp/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="42048163"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="42048163"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 02:13:39 -0800
X-CSE-ConnectionGUID: KcxC1PXKQoyzZzDR5UYOaA==
X-CSE-MsgGUID: iplyqQDbQSmPZUrEqKXcjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107234778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 02:13:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 02:13:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 02:13:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 02:13:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuHioo+9dmrJsYkWgSSXZhjgBuUvIr0dMWqJdVYcZa5MvycpRQWd6s+LWeFtE7RWAL0CwrfxhX13re7kWg+qVRVMkax3WG+CHFyO/upmTge2mVIi79YAw85XXv6DK5ln3Db+nHFCf39GRA/9PDJhVGL300qWR6htn2lk1aY0EfX0B8kPjh0E2UyKlJQYoLs1YL02dSlQzSTYUyAy5pW/xTrnEnEYlIaQ02YDsu3XkTIwQMV0zDgR8IMTl13DC4eLoP5a3Krj31+YG22sobCzE1GIX5slQAFWhE5VXvqqmwPeVAHUD6Sodxzj40iIExcicUBnXXCj2IqF1OmDo7uKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2/I6mdYcmEtphA5Dyfrle19BZmPf3jBH3DUkaKXEm0=;
 b=TfL+yDTTnrwVfwjP2Y5Q/WivvrF95GYX5mW/Jg7nCP92m/joS3LhVikBgOfZQRDsw4nxrjbgM/iDjXSaoW0rhQX/EGJQOHRQ1tkO1BGy3qnXswMhfYBMS5mbOI3sxqEaPbaOGipuXhXGOGlCYy4a3r2vu5JAQMkiyp3k8k3YKPNyFcu7LT7Mev8FQ9zRAhUonC9qH6yapMDCEcLIzl82xVbIcHU4J+Wt8WMbKiYMohcpHRCarwvyDN+N1HXLJIaBcGOXmrPM5wQABzmaQMNPz/zjpq055ztO3DwVOnKj+vTQJZBsslkgAP7B5Q1ZLlSwBZKv6gm0oKnlEMlmcLFmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7SPRMB0046.namprd11.prod.outlook.com (2603:10b6:510:1f6::20)
 by CH3PR11MB8363.namprd11.prod.outlook.com (2603:10b6:610:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 10:13:17 +0000
Received: from PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc]) by PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc%6]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 10:13:16 +0000
Date: Thu, 23 Jan 2025 05:13:13 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v15 4/6] drm/xe/pmu: Add attribute skeleton
Message-ID: <Z5IWOXGBdruLl0mQ@intel.com>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-5-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123041923.1892837-5-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To PH7SPRMB0046.namprd11.prod.outlook.com
 (2603:10b6:510:1f6::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0046:EE_|CH3PR11MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b35c1a3-d09e-4ea1-333c-08dd3b968db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cNxV9/7kIdhyqaPkbN2S2+bfRYF2WYUaLfHoVY6s4ARn/dGMlw6ypaMqIrsu?=
 =?us-ascii?Q?1XxvsuAVwfn7CQEzEnkPFip55nMeaJzCNAyd1n04/b1fBXgEYdOV53Xc03M+?=
 =?us-ascii?Q?3Z68B9vPI8FOWxzTocrGgrZgsYTFacquKlXoDAx/z6KocerthHwyxuKcyfRg?=
 =?us-ascii?Q?ZE6ZYszl/8elUPM3KIgBzLDetI6FIuDc22DTPmalb0TPSbRz+kElxB0/HQuF?=
 =?us-ascii?Q?NISyL3OsbgwwZ76CwcxCh2+ABYVAJ+f25xmvln5naGkfBXHsGRZXqHZz5Is4?=
 =?us-ascii?Q?gOtzZnLF4xbC/7X1XgwXPWW4wYX2tRcGw4O1woRBuLCFFMZ54GzeTDWx8ENN?=
 =?us-ascii?Q?npsaFHqBVz7u/p1qrqQQjifbAHigWLC0ZOPExV9QLIFL0JsGxsmgsnMqa0K/?=
 =?us-ascii?Q?uZ1cKwBBK2GO6H1mpfaln2lsEYXxLWZsyZHCQmhJX05DII4raM6kLF8XxT+d?=
 =?us-ascii?Q?rwdN2c7LapEI2JUx48u4ffz/RsdMqtx3TaElggzSEXogxRhB3US8dSgCajmF?=
 =?us-ascii?Q?g4V4JU/p02Zz2JX5VA49Ekqd1Ekn1w4h5I/VoaU8NbpXHgD2HcSbTLeHOn7q?=
 =?us-ascii?Q?KUsaPQ2RGTj0MdOvfKgwSBq4Hu53DK03pwQpuYbnsozzkKI5599kOkbZDXGX?=
 =?us-ascii?Q?2gjCKG4gLB5PJcp3tqI+OKCfIYoRZaqJ1um2MnXRmzurdPytl3gdimm7CSIn?=
 =?us-ascii?Q?JucEUV3RCIhVFL469eE85g3LSoIr63xVxMbTK9sVyXUyofOtLkNX9lCyYuDL?=
 =?us-ascii?Q?Lum5cC4kcnXUs70QmXSNRUEeQe6uti7hzDtOvn0aGLp0VLrNDSaX1SwVknhh?=
 =?us-ascii?Q?DARa1xgwWy8kr7K0WlehaCkH4vU+JK0eQ8CWLCCzT8LurETklmTicoQrna5u?=
 =?us-ascii?Q?dmfIis8qkEizm39FC2Lv756+vDqD31VJV11PVXcG4kx/aVct1AqAwYg8t6ME?=
 =?us-ascii?Q?BDDrUSKuYst6kRScBdNug7ihywKpyQ9e5TNEoL7gIWppeIUwnyKRDj/E9a9N?=
 =?us-ascii?Q?oruCeUKmkqpd6PPPzncXEKcQ1lG5oFJZgWvtleql2o5Ja9ySeRVDf7tfAD2W?=
 =?us-ascii?Q?sn03zOKwlyJEQwoWtG6KuqhZi9onCXI+9olmJ3VSTWHwcoA/2Kkusw5Q/COS?=
 =?us-ascii?Q?F6/jDXQXnwJBDFWUxnZICWuCq4vS8sdefyoeMwqLQFEFAnyxaxU6fMAUTkvm?=
 =?us-ascii?Q?io2VcRmyya6kpPra5ihwiOjZ9VN37jMdmvF0zGIdsjxie3inI3hniove937q?=
 =?us-ascii?Q?1Jcjiv84sVRmVc01M/S2nornQMNvWAIdlDKXRPUx/avvmTuRrFZsfQChKTYM?=
 =?us-ascii?Q?6B6dtHwbL8tEa72Cs5tyhJO6jHpkHH9G84pDFIYei/SCCVHdg1JCHhhdVeJu?=
 =?us-ascii?Q?Ga3LlZ9akDSi4LjOgGy0/ouAKxsN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0046.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pmu6J6uxImSSzx1tLBd3tFfpOwTHAS4FIZYhSfm4ZoBiK4GmjnZFvZgcpe/3?=
 =?us-ascii?Q?KN/3DuFzIdgU4+aGSnBslkTKmPPjY4HlaSoaZXYmmh6muzEDguoHLd30RiB5?=
 =?us-ascii?Q?mb1fDbP2912B6dED/sasOd+/DHfEN1RJoFVzfsqTE0qTHwwyYorrhvtur3nx?=
 =?us-ascii?Q?ADfVcWG2pWHQXAm/2l4HgqSVKUJ86YxIVCce0QcCz7xFKY0jSOlXQ0IDoOqv?=
 =?us-ascii?Q?+fMLWAh372Tj5LzokGVlKzEJGEzN4cfvhGn5yCcMaKvcXn1D8TnTdvPwzUHi?=
 =?us-ascii?Q?BSKD82rSoX1eTovx4v0GrKzB/kW3li3S5ZfI/8kLrx52mL4LEL8+ScSpeRBB?=
 =?us-ascii?Q?qCMPLhnB0IcGpX7Fkt/afj/MZpwEhA6l/TgJlg1lDWxQxT5zPoehadbL1gMY?=
 =?us-ascii?Q?9iuLWFwu7z64RD7yZ3lxBs9af9takjZTkTAfwTdESTZSi8x1i3kuOu3jV/r+?=
 =?us-ascii?Q?BQp9QGB7yWQtMICVvXZADxO/U7hYVl+IIULWfcGUf4QpZ4c7f6d/vop2deEN?=
 =?us-ascii?Q?A45XIqTQGV+eKAhrB/DpDXjVwJoQiiVFIeHWzv8/DZm79K5kTfa9pBqKttD/?=
 =?us-ascii?Q?mByJ3yM2kr8p9wfxKY1kAA/qoJa2wtrYjpWhc48PpEKUz4NHHMM7YHQqFffl?=
 =?us-ascii?Q?AEdHhhg6UeK5Wm09N5KTtMrRUj4dI2WRTbVcp769ETNxU24ipqgo2YpuzL+A?=
 =?us-ascii?Q?oinWrqKg4Bpt2d/pjrk1BhHmVf/xmI8hOG87feJlzuZnfi06gt3PviqclXdq?=
 =?us-ascii?Q?+qkhhFkXAS0+tjwXjNYLiSlPV6gN7zHUNdrk97xTuXu1FCwtFRuieVlPsTEX?=
 =?us-ascii?Q?0atoB31vvlbR/4o3sz4V8EVaa6wKvxatxWYDj7b483rZNOegz04ex4r48YIO?=
 =?us-ascii?Q?YeQWONTxQqyw0Ejqs/HYF4HwbinsySUGllWMPWRwWagCWIY8nU5gMOIhCqYI?=
 =?us-ascii?Q?jr/F9BE2bQWxdTlP1n6j+tYK4mqXeqYqVFf9Mub6qj+zNfDo3JxFfEAPntwV?=
 =?us-ascii?Q?PDaD2o7vnToazTihfrsQ73u9oLWOjkzPMqj3CafXELIbeDUoJECNnQjJXuM0?=
 =?us-ascii?Q?QX1b9DLFR/U20ttOk8FQdh1YiZU2F4feDelVXRq1W0Q5fm69uhy9GEEJbP5L?=
 =?us-ascii?Q?NuSjUXNtH9AuGiSCFmZg8SIO6HOTtapiOqdet3elvp9UgEwmCwKFUVedqiIS?=
 =?us-ascii?Q?Ol2i7C4ZqaO+i4S3bnyW4L4tAqYvh3EKrRsiJRpAaXEd2JdKkOS+H6mjK3Vi?=
 =?us-ascii?Q?vidHdHCsqxaIlcm6P3faZOiuRR0tBn6/b2B7Y/+YRE/Da3F6p5HQIW33gtF1?=
 =?us-ascii?Q?0nC3mStQqkW6W+NOTKNaLdstfD6gDeNKHhU1UKbYlqe+eiJFTJM9QHXBeTNv?=
 =?us-ascii?Q?I0XprPJhu7RHKuvlsZMllsla9Wuh+vFCzMoA+G9ww9lZmxH8ipBb9OJTjCzb?=
 =?us-ascii?Q?v8l24KdDIr5iAqJw5fkwaI0VSqTna91Ld6xQU0dYQtWe/2HXlCP47+74WnFQ?=
 =?us-ascii?Q?QAFzYoAzW+cGz96/8VvfeJi5TAAoUemXBWXHQwstWS9+/ICHX/aFEp6tqfoE?=
 =?us-ascii?Q?CNuQMgwZy7w0EyN8EJ0EPt6cywY7uy1dvyQ0/MLWzzmYSmUkr9YyD5Ce9Mna?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b35c1a3-d09e-4ea1-333c-08dd3b968db7
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0046.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 10:13:16.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y1rdXsjlZS5EZCNgv3HWMZRzhK3gG5DYci371b8PupCRHfFtA7nhuiGvuLoX/vmbQjIQ4+sIxs4YLmlo3uw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8363
X-OriginatorOrg: intel.com

On Wed, Jan 22, 2025 at 08:19:21PM -0800, Lucas De Marchi wrote:
> Add the generic support for defining new attributes. This uses
> gt-c6-residency as first attribute to bootstrap it, but its
> implementation will be added by a follow up commit: until proper support
> is added, it will always be invisible in sysfs since the corresponding
> bit is not set in the supported_events bitmap.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pmu.c       | 60 ++++++++++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_pmu_types.h |  4 +++
>  2 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index 33598272db6aa..5e5a9fcf30ace 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -46,6 +46,8 @@ static unsigned int config_to_gt_id(u64 config)
>  	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
>  }
>  
> +#define XE_PMU_EVENT_GT_C6_RESIDENCY	0x01
> +
>  static struct xe_gt *event_to_gt(struct perf_event *event)
>  {
>  	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> @@ -60,7 +62,8 @@ static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
>  	if (gt >= XE_MAX_GT_PER_TILE)
>  		return false;
>  
> -	return false;
> +	return id < sizeof(pmu->supported_events) * BITS_PER_BYTE &&
> +		pmu->supported_events & BIT_ULL(id);
>  }
>  
>  static void xe_pmu_event_destroy(struct perf_event *event)
> @@ -210,16 +213,62 @@ static const struct attribute_group pmu_format_attr_group = {
>  	.attrs = pmu_format_attrs,
>  };
>  
> -static struct attribute *pmu_event_attrs[] = {
> -	/* No events yet */
> +static ssize_t event_attr_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct perf_pmu_events_attr *pmu_attr =
> +		container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sprintf(buf, "event=%#04llx\n", pmu_attr->id);
> +}
> +
> +#define XE_EVENT_ATTR(name_, v_, id_, unit_)				\
> +	PMU_EVENT_ATTR(name_, pmu_event_ ## v_, id_, event_attr_show)	\
> +	PMU_EVENT_ATTR_STRING(name_.unit, pmu_event_unit_ ## v_, unit_)	\
> +	static struct attribute *pmu_attr_ ##v_[] = {			\
> +		&pmu_event_ ##v_.attr.attr,				\
> +		&pmu_event_unit_ ##v_.attr.attr,			\
> +		NULL							\
> +	};								\
> +	static umode_t is_visible_##v_(struct kobject *kobj,		\
> +				       struct attribute *attr, int idx) \
> +	{								\
> +		struct perf_pmu_events_attr *pmu_attr;			\
> +		struct xe_pmu *pmu;					\
> +									\
> +		pmu_attr = container_of(attr, typeof(*pmu_attr), attr.attr); \
> +		pmu = container_of(dev_get_drvdata(kobj_to_dev(kobj)),	\
> +				   typeof(*pmu), base);			\
> +									\
> +		return event_supported(pmu, 0, id_) ? attr->mode : 0;	\
> +	}								\
> +	static const struct attribute_group pmu_group_ ##v_ = {		\
> +		.name = "events",					\
> +		.attrs = pmu_attr_ ## v_,				\
> +		.is_visible = is_visible_ ## v_,			\
> +	}
> +
> +XE_EVENT_ATTR(gt-c6-residency, gt_c6_residency, XE_PMU_EVENT_GT_C6_RESIDENCY, "ms");
> +
> +static struct attribute *pmu_empty_event_attrs[] = {
> +	/* Empty - all events are added as groups with .attr_update() */
>  	NULL,
>  };
>  
>  static const struct attribute_group pmu_events_attr_group = {
>  	.name = "events",
> -	.attrs = pmu_event_attrs,
> +	.attrs = pmu_empty_event_attrs,
>  };
>  
> +static const struct attribute_group *pmu_events_attr_update[] = {
> +	&pmu_group_gt_c6_residency,
> +	NULL,
> +};
> +
> +static void set_supported_events(struct xe_pmu *pmu)
> +{
> +}
> +
>  /**
>   * xe_pmu_unregister() - Remove/cleanup PMU registration
>   * @arg: Ptr to pmu
> @@ -270,6 +319,7 @@ int xe_pmu_register(struct xe_pmu *pmu)
>  
>  	pmu->name		= name;
>  	pmu->base.attr_groups	= attr_groups;
> +	pmu->base.attr_update	= pmu_events_attr_update;
>  	pmu->base.scope		= PERF_PMU_SCOPE_SYS_WIDE;
>  	pmu->base.module	= THIS_MODULE;
>  	pmu->base.task_ctx_nr	= perf_invalid_context;
> @@ -280,6 +330,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
>  	pmu->base.stop		= xe_pmu_event_stop;
>  	pmu->base.read		= xe_pmu_event_read;
>  
> +	set_supported_events(pmu);
> +
>  	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
>  	if (ret)
>  		goto err_name;
> diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
> index 0e8faae6bc1b3..f5ba4d56622cb 100644
> --- a/drivers/gpu/drm/xe/xe_pmu_types.h
> +++ b/drivers/gpu/drm/xe/xe_pmu_types.h
> @@ -30,6 +30,10 @@ struct xe_pmu {
>  	 * @name: Name as registered with perf core.
>  	 */
>  	const char *name;
> +	/**
> +	 * @supported_events: Bitmap of supported events, indexed by event id
> +	 */
> +	u64 supported_events;
>  };
>  
>  #endif
> -- 
> 2.48.0
> 
