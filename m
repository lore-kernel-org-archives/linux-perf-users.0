Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DD126BEE
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138744; cv=fail; b=WhIQSd5tifiwzeY9n9kCIXoXepEpqjxIegv/PaNkJxaUrWyWCc/njed3sDojBx/uDcHaIZ8LkYYtB6WtZBz3ttgbNIOnqsc2Owll4Dql8CKW7+00OaTeJ5zSZmqu5EojwFR222daUn1Bf6NXCLWriJ4elRiF1cYJ1AU2+ilBGZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138744; c=relaxed/simple;
	bh=9HsDKYCZDKe+hSudMT5no5ni6Z/f35rYzyguM1Uu8Ao=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jcu9fDEXIVO6GxiE3MBLmUnzXbARicfByH70oJRF6lmcqJNLOqMHCH8VVtatOO2K7H9rin28sjLqXtGEJHl8D5w/XJnfCgluu97BGMDyl9EbDRoTHGCPEp/e1bbIjzsHvgTkFsqWGwu1l2MDEA5LmOHtdMcXRyGJRMYpsjuMw6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpN0cFMY; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpN0cFMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737138743; x=1768674743;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9HsDKYCZDKe+hSudMT5no5ni6Z/f35rYzyguM1Uu8Ao=;
  b=CpN0cFMY7KBS6vGIv2r5+75DM6Qw7mogqBwSor5OFbdH5ala2H75Uiyz
   DX6PGy0eEFbq524i6QacXbfYPOv8JMm7ACTlwx9vTIO7vpKu1BxyIXnrc
   aOSbMAtsZ7uNlIeNWU3jq8wG/lcCHT3nuscLnP9Zu9sxrSS+hjmUuQpWE
   kCSP1DoNhl8PPy+8+EyFqwoiBESnepmTDrRkRLwK9Iz89ZuiYYSr0au2Y
   S9wCSnpL17E046xolb9m1SlmCEJrpWqE8SMlezdstKhFbNZgrITGUw3If
   RjQiJm/7i8j39y90ui8GpXTgdl7lERcZ/xInJEaNpjtMmmfmEI24+OriL
   w==;
X-CSE-ConnectionGUID: VE/a+oADSu+6CaXgJFzYEQ==
X-CSE-MsgGUID: pVhqIGmUQ/KkIuxICwXocg==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="40389754"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="40389754"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 10:32:15 -0800
X-CSE-ConnectionGUID: 3FiBTbl4SL2ah2NOzFXnZA==
X-CSE-MsgGUID: Bn6sM7jNS46j01d26ZqEdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="106052367"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 10:32:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 10:32:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 10:32:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 10:32:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqjUkKv8BRry6pbTrJkHDSv3YBS1vrY0OvBi9iB+xs8l0YsS7qf1wpm/lob4uyHmXbo67iGQhWwuo34BKbtO+MCpmVCrIqP0opehlcOM16ecDSROd0BYAYhJPRq5tSH/mYcZGkRjmdaDujGydI6hJ2px/xirPOCUGIcVChpcKyFt7dAds9ZXKIZ50Kv/fwa8oVrwVKDu97TJl3QVxl0iBaBpAUpi59k+FahJx4Cv4BgC8qUKpdX5GTjkOQNZ+UwV/J6DEhPa8tWWCOU/qmDYG4HsNPP1NHQuEqLB9Thqk/1ZyVxE/4ioRQ88z9+Y2WZZZzO/9MBeC+jHYmjhhPWt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYuuLzljaKoQzrLn1W67g0YhzPPY4JA7xAR9Ei2AWpw=;
 b=d0V/CwO5bVB+iWmsKqjxYuj2jlapQ4dd/bFn5UBoaw1t1pJAnIKVbXxYsds0ptV4a3oFZZ11H9kRGoYpaP7iBdDpd1x41qna7SvDpFuokbAKlQTYg9Tg13vrCWlDltc+1LbIXvcJMnnoQ2T3/QLdcLQK7i4wLnq3XyCwZI4lmQTATKtCvV2Jq2DIDaog4MtoL6OrOh3PB4RDhCBCmrJyXxHiXYtxRY8k/9qDToaLJXl1Mb+oADrtfi+3ft6gb4fMRnWth5gmRcqyRsTPb4e52Qxie9IwuQqDwYE4gjtaBKNtRN4U8br/a5IMwJd1KaJ3RARvAurVI7+vEkUvmbULQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 18:31:55 +0000
Received: from SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72]) by SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 18:31:54 +0000
Date: Fri, 17 Jan 2025 13:31:51 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v13 3/7] drm/xe/pmu: Assert max gt
Message-ID: <Z4qiF1e8bFK3volf@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-4-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250116230718.82460-4-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW4PR04CA0308.namprd04.prod.outlook.com
 (2603:10b6:303:82::13) To SN7PR11MB8282.namprd11.prod.outlook.com
 (2603:10b6:806:269::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8282:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: f28bb30e-27a8-40b7-a0fd-08dd372537c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G2JrUm9pn02XpiWh/SovDkCAm33xqHz8D8ex5ErxNCGZ4Jcj7KsYfEoi8bRv?=
 =?us-ascii?Q?6WpL5b3a9217zyBlZdfRHCPDcVy0xYMOFmbeUH9qE8HxpXsWVrvy5hSDeRv0?=
 =?us-ascii?Q?J91wMUdL1miEiRPRtG+sbNCMUExhfBx+jwLIuE8j9KuLVYPtuuCB4r7KUzeU?=
 =?us-ascii?Q?fvahx8x3wLkdg4boRRkBJ1p/7VgrGTTsH1gil1U322g+31ZqgBugxiCbr7en?=
 =?us-ascii?Q?05KtlIjLhwOWgLgXeTCeiQzp5qGsZZPBH2F8kKIzJrnzkwSrU2/EK49J/Gkg?=
 =?us-ascii?Q?n1EQoGtLt/0rblmWHBBGPSI6QX3NiCLHa4Op3xm9IxKbXXezk22gDlEvdQNk?=
 =?us-ascii?Q?GwSbi97qPdkclrxgqZA9ORdRXTm1XLvvO/BMegCVRkBLFZabHed4nEVNBiWi?=
 =?us-ascii?Q?HgLNb5KY3J/fiSqArcnWQH27pPBsD1uqKhHcxRMmSTNfFJuy4r2VvQEq02Bu?=
 =?us-ascii?Q?D8AllHYoOkDn3R0gWjT8qYfxVIq7V2580m/Hvj1Cu2UMZ0jaJe06F3/I9408?=
 =?us-ascii?Q?OTPKTrtxmQuoaotaQHAbRQcHh4lvOr9B3Zaf0/9emljwvZj2I34ZUR/+cOlk?=
 =?us-ascii?Q?tZEINrtwdXjmyMNX981iEVGqJey+b5ZnjMDRAuRaa7CXhdnBhLk9dHgRwVs5?=
 =?us-ascii?Q?pVxxWmYXrOk0EHy9cp0YLeoW6nBvPcp4jvJ7MmyBPTv5kA2fU6U01SDRDlyL?=
 =?us-ascii?Q?FfGJX/tRS5xqdloQwk4cTzB0wodNHcAmb6RqFy4GlS2dymzInyhZ8eM12xfd?=
 =?us-ascii?Q?lZei6rztiKcWEOKOpCqI4ndG+zKb0A5e8sAdEGbLC8AU+FaGjqs6xA6RdbjU?=
 =?us-ascii?Q?2vGuOdZ4cEf/e7u29F1naBpl5EyKoavMngalHMcHKJ9HEvilQE8hRJorUBKn?=
 =?us-ascii?Q?LpYkntJjCLLwwJ6Uk3cNTwEoE5riPcrXbAgDfC4dJg7XLXzykAlKhNdxQK8j?=
 =?us-ascii?Q?UGI/2noyGWsG8mA1Fw/I/drapPxgrLj52CaAY/FEl5kqHcs3lk7HLB+R6RNV?=
 =?us-ascii?Q?nx4TXWeqpOtS2mLn9zpqnF/CWQqWDg1H8abO2hu3ep1xgD4Fq1cuKuMF79KR?=
 =?us-ascii?Q?XgS1fBtnfuPacOfl5MU8JQi6v/OYVTbsw5vwCdRRQDMEgLx5W52l2eteMZWQ?=
 =?us-ascii?Q?mL/pFxfngvOKCPqMolIPb2aerySFIMX1VuInOP1K9YRach6ZAUuvx/aKunkx?=
 =?us-ascii?Q?yoRQ0vJXbixIIRq06/vBJ6gWqNIJnBK6+Do1qjr0OLagjRNeMR2V6eaSpXE6?=
 =?us-ascii?Q?1bvh8550jMtSanVLcV8r+KTtuAXPHtP/GIw48qSwaTWKF7TtNrV5sp3zNsEB?=
 =?us-ascii?Q?gX+pIoijdAqAK6czqve5Ouoh+L6xCXQf3Z2fCpaTYkSi7z+iUVJhx25gvk4g?=
 =?us-ascii?Q?jFQzUn6/qqin6/zXSpRSoY/7Zq9D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fT9bQlVhI1pa9kG6hZaKDTrz1NPiNjPo2BCPoODy2k1btIHxCf5uUI+InScm?=
 =?us-ascii?Q?ek34Ax5zOSsL0t3F8BCM0NWOfbss81Nl9HAZ/dVe4o5314jucd28tqG2/HfP?=
 =?us-ascii?Q?Q9dESNmsEj8KXySAz7dxYOYZ7o21VIU6NLPfyaB1LCAWz5/TJdKR0aUtGSMz?=
 =?us-ascii?Q?V7fQ0iN0kuO5LFsY2xFu8IK32H4e/xu353g17Dv5t0PqUKj/XPKJ31z9kcD3?=
 =?us-ascii?Q?VoQNERG88gIjzM7ivr4h86+fx+vCuYyqfw2w2aI4FIDrc0VLMbwubnaNdo+h?=
 =?us-ascii?Q?jedEaUsphDYlGnrg1LRObMW1PIJl0K4S9548+hFHlFwdBOOBwYM/kGDhFsv6?=
 =?us-ascii?Q?cE35edawG/ZJeaH5/lxO0xjgM/MqsDLvmumkKPW+kpcZHvHXsWklobv44UBM?=
 =?us-ascii?Q?33ftij1bcNUq+OJ4QAYpn7KWGPxxoTsccRvBCklHdjtUjjDxDBqiPf0UsBSt?=
 =?us-ascii?Q?U9X1jruijIVX9GUk9Khc7QOnkhVnYFfA2wEkiK1XEKfiOJj/AU8ByY5YTb//?=
 =?us-ascii?Q?iweob91TAv6YwHtROlhPl+1U7+v3cOZ8LXYv+gZQEQyWPzu4eXd8JQ0lfdZc?=
 =?us-ascii?Q?iWQw+2A9EnfR3TKV1NOuGQRe3abpGUvWtERwgfbrIK4OUqd3XMmUO+SLBK/V?=
 =?us-ascii?Q?8ZQPlW/3qK9s6z5Qe43DtAfdhN4+SzWtRIAq187HFAhOorJ0a/ZY4R2kNC41?=
 =?us-ascii?Q?EMk2Yu5UqzZcQzhsDD4cLYkX7hGshu8tgyjoTiATLQt/UHah0F1f81dEaujN?=
 =?us-ascii?Q?IUwubZe0GqhkD3nzYhFfgXtz7QrI7c9FJI6BG95s5sL6hF6X+nlkKXL/Y3h0?=
 =?us-ascii?Q?80G0KEre08vl8XkgqOm1r/FmgWCeo7CLnAWqtHYMdv7TJHk/CKMk6UeGFqTH?=
 =?us-ascii?Q?TFFMX1BgnFyaO3qApDnrvykNxFTRQkokf9GnPZOiEW3aetdHeu74iHko9lg/?=
 =?us-ascii?Q?328LvP0dS0dMYASYo+2d6D0jVE4Joq/7PeO4CLVLdKdRKiAzHBSI5uF4qLdm?=
 =?us-ascii?Q?NRG5kro1/nEBvUU/UYbtbrIwKuMCKeEVhpWl7LQ9ICs/s4TrfYfy90JE2QTh?=
 =?us-ascii?Q?ber6Aj3DaTyYyLcx5wt8MANLfey3huI0HomY7aImwRNzEs146yWmmpEGcV8U?=
 =?us-ascii?Q?77Z1WShdnjoKMl/ceu6NKGZ6/HxtXG8rjva3h3VdAMyVtHkLUy6M2688S/it?=
 =?us-ascii?Q?jYxT/nytfaXe5l2bN3nNOKqumI1bwjG2+KUMW4OX04dBmzzVNVT7B2PhTfuM?=
 =?us-ascii?Q?ZHTqZgsyjmcfA9tomqhnsU40a9bivNX0RNxdypcMCm80L0zC9GBm5OO4ZM8h?=
 =?us-ascii?Q?9N+vvAPimgA3H2SCrLcmTkA1qcYViLuqHZNIJW6yW7Qy/VZ9BOy6C2hLcj9V?=
 =?us-ascii?Q?2Z290A6aZ9oXio0um0DtlI+JRzwZZZelI5iqb0xHIb0ZnYUxxYUwZXVD8NP+?=
 =?us-ascii?Q?6xmQmUuu+agrzQLHqVKcKgFilqUGIFoGym+r1erh23S02rnUcfgPO3c2w72O?=
 =?us-ascii?Q?0Vo+YWTh9pEEB4SSHyg+rUn4BkmHTbvY7TqTWoH1smd+rxuFmKdzKwRmeU60?=
 =?us-ascii?Q?ZFyeLpwC/CV/G02Fsb/D9ImGs6M0scO1Tt/0ZkuOi/VcvUIPD9xtfiwO20sH?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f28bb30e-27a8-40b7-a0fd-08dd372537c3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 18:31:54.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VppPILIXn7GBl5D09T3dPCTxCCYr58AwFffiBoG2+ngFiOYnWck1n4zh41kTz6a4RjfDPKuLVa9krcWlSw93nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com

On Thu, Jan 16, 2025 at 03:07:14PM -0800, Lucas De Marchi wrote:
> XE_PMU_MAX_GT needs to be used due to a circular dependency, but we
> should make sure it doesn't go out of sync with XE_PMU_MAX_GT. Add a
> compile check for that.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pmu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index b63f819c54d02..2312c73a3ee16 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -258,6 +258,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
>  	int ret = -ENOMEM;
>  	char *name;
>  
> +	BUILD_BUG_ON(XE_MAX_GT_PER_TILE != XE_PMU_MAX_GT);

good idea!

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> +
>  	if (IS_SRIOV_VF(xe))
>  		return 0;
>  
> -- 
> 2.48.0
> 
