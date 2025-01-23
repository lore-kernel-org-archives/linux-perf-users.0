Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963514AD19
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737627632; cv=fail; b=GTCAlDeEuhjEO54XDfuWHDFLM3MfJ0VHZpQD7TMTkWZNEtY1w9w0Aw3+YNTeLSlTJdCUZN/KQ84tc9MuVOHLrfAPT2oRP//Hm6ou6+kyhG34CI43jbwElmUIPcyf+qjkYI3si6Ndq14tl3a5aPfUofHp/LdQWipMwV9NYjU8M4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737627632; c=relaxed/simple;
	bh=F7rR0NitCRaRfk4hAIvm1/ZoCNmn6o7Q8LMBrx8tVSI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s0IuiXn7e+9EjMqCz6Yr2AtymGT5C4LXBSnOn1CzAZ903mWnDK3NDozR0vZoLkYe20ficsw7DsuJYyNC5t3dI3j50rmdU+LVJwrQnlV0Wo7BpDVmU94Tr4j5EgmEMIMKm+UAiS3FX85kr2AarlV+QCQN3AyIiYTKjJVTCkGmum8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYoFMFVs; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYoFMFVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737627630; x=1769163630;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F7rR0NitCRaRfk4hAIvm1/ZoCNmn6o7Q8LMBrx8tVSI=;
  b=UYoFMFVsaN39gj9zkk7n9sU2j3Ss+QfANi/zDX1KY/5Zca+ScirsXqhG
   336e5R/cpinUiPhFmJpyXD2299SFt0KBoktdeOmnvhsx1h9wbeMQZahNh
   KwvMkPhMespOsLQjzhqLrKs4l4aMsY4sQY2BkxiRpx7mODI1PwWRsfQ0P
   RTJ6oy1GSC5SZTApUY+3vzybO7q7CsCABC1PyKVXiztb8UI+KpKIi0A9L
   piSK2Q5jNi6LHB5PR9UpgglQfFeYJCJSZtKi/6VjqBGoKU5kLlwYLt1e2
   hZmfoRUNK9jtOAWHJajZ9vJ5kogHtkbz/atEV5W1WH8YLxos3kTLfn/5o
   A==;
X-CSE-ConnectionGUID: P7FSzb1VRPOlqkRHZzMXLg==
X-CSE-MsgGUID: PwwumchaQNetkFvOwWOz+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="40944070"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="40944070"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 02:20:29 -0800
X-CSE-ConnectionGUID: x6haSxVGTVeIAgJNarfOEQ==
X-CSE-MsgGUID: xyUyGhwVR8KZa1RCqzP5tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107414237"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 02:20:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 02:20:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 02:20:29 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 02:20:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSboRuRIoP1DkPx6dLMIGz1M7/QrERSeObaTDHkeJCb1orkcHQB+qKS9nJf4ITZcjQU+duEe2q1bdIWvlcuOdAOtM2ZV0SB5+782K/KtXUzogaKq5CiU3kgflnf3COUCYaSoC+pIKJHzJvcQkhExETuKsLM/b5UkKADdhCnj4SrTRAdU+SfS9pH3xZ1yWFLiOU2LOg4x/ixfXNM1HVtHRw/3kwN3Otj5vd3YqOR03frZRA9B8tr5R1U1eA6DTKKmcpNfHCfIQFFSqxAEiOF6LUKBQwkxMWwGgxeRAe9nAsvHgw5ivTPi6SpWKML9DX/VSpfAPPCIk69TAHiCv5gR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sSDpbADHLVUEiQwtlSTgzI4PLtN3t+/ud04Dau1hhU=;
 b=T3hDyIJAC/Ljbr1H4JfOxSxFy33OTOUvQgj7fsaKoiexmMOIzcVEVJ1COTD/2NnIB71kxJNGGex+hkYSo5VKNPTeGYggYnR1zEO1B8AGZkfJY7hLbpqFaCfcUFmb83aXhNqER3UaKqY177RFJnP9zDfrw/p7lyJtu0X8il4Cd90g3rjFuM5NhiG80EBNaD3ScUbvxJ8pgfQfFvrlog7ZwYotvRl9UlX4ouayvOYc56lvHwrZx1Z33NrNgvjmeQyyHXhjup7B+pMhQfGVID9fJwMddLzL0MGRnXIWLtTSMg/uq7a1JCEJ0YskpGoJ6+L+4/jRapf6gpistAWqz1MbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7SPRMB0046.namprd11.prod.outlook.com (2603:10b6:510:1f6::20)
 by CH0PR11MB5314.namprd11.prod.outlook.com (2603:10b6:610:bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 10:20:13 +0000
Received: from PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc]) by PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc%6]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 10:20:13 +0000
Date: Thu, 23 Jan 2025 05:20:09 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v15 3/6] drm/xe/pmu: Extract xe_pmu_event_update()
Message-ID: <Z5IX2Rixtx6csrKO@intel.com>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-4-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250123041923.1892837-4-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To PH7SPRMB0046.namprd11.prod.outlook.com (2603:10b6:510:1f6::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0046:EE_|CH0PR11MB5314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aad74c2-881e-4644-adeb-08dd3b9785b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B4h8Gx9tB0f5qYUocug3sC0yoGTG8+HVLqROQcXSE1rmBVOznTeTG+WS086W?=
 =?us-ascii?Q?5lcwZos2cTL16M2bQBjWXngVzJMczn6i/MD2ZM+K5UnBnQU8Rff3WPu7SkPu?=
 =?us-ascii?Q?W0wdD6h8X5LnX97BNJ0obmcaoGSY3/eg5qq3BK9D8TZQIQJrx9e8hT91Au6o?=
 =?us-ascii?Q?zgEpSJD3g++JqbP3eMoDq1+0XdBXC+8CkElGgu/HtT7wuNdS/EPUNsABsd55?=
 =?us-ascii?Q?Cdd01TOh74nLxaX7D8CUXYcLEExwIIIZY7kTuG9JDVtD3h5vorQwmbyfG0qI?=
 =?us-ascii?Q?0XUhZ1HyXeMOBVkbzZp1vVtnKEvMK6Wk+j1gfuvpfT58jZMDQn9CH8DazKhf?=
 =?us-ascii?Q?4c0bDlHAT6mFJLBaZuXKgaDvJYjXpgY16xS3zf+ZmWZSK8pKdG0DIMtGHb9F?=
 =?us-ascii?Q?OOODp7XUksoVNozWkwHk5E92keLF5wx3dNzzAywy03Xa4HO/r1gAXcAvC3gP?=
 =?us-ascii?Q?CuPYpVgo7qYfkXa2pBaTE2nOPP9U+CiiC5X13AGTcopdK4gEegUuZhpGsmBB?=
 =?us-ascii?Q?ZC4XIHiNg5e4IZyxM+xiDONDvSAP5KY4iFmlhLu+MZeX41dnAFFU6thz52d9?=
 =?us-ascii?Q?cxvQAPQV1oUcsiywhpA50y5yT0vRLixo0ep8TGd27bczxVsowsv+IqXZ0o5i?=
 =?us-ascii?Q?ee+Z8m+bOX+wHKehbeocq+pucIiDJuKdcp4+EW2EcA7BIcKeu8/7fGoNk1YL?=
 =?us-ascii?Q?mHbg+1nfEzRO+hjYSWnzhkHC9f5q3peVJF3o1qu98zxrDRVPGLbrjxEzmq2h?=
 =?us-ascii?Q?zRBSm3z+aBhBUyiqQO6RUTeZJmYzdzXvKIPSqHMN+y+tq4W9vVL5uG2yMXUu?=
 =?us-ascii?Q?JdkdnWykoYLMfyK5zEk2orvYj2ygvkSXvvo3oSCxakDqF3x69M1p1DRlfLvm?=
 =?us-ascii?Q?BgMo1Q62pQQKHjsAFhMZ4q9dxkA8qFcSLeuE52hdail7XbtXvFliUPvUfSx2?=
 =?us-ascii?Q?hhs5jX0lrNNFhoM+fzPlMX6InqYUWv+i5d+lH5lEoKc46lpvLUFdfIV9zc08?=
 =?us-ascii?Q?QmupyPK5Ti4twzZovoHONMPKXWIkkqZp2fk+ngvir761eOczYgvhmedT9jJX?=
 =?us-ascii?Q?y9MSmSKuk1TN9yTD1GpFAmU29+KR1ha5DNTYNZ1StYqAJlQ/2gbSxvxl7UfE?=
 =?us-ascii?Q?3FGhiV2S4xop8tcshapE8ov2+v909tup4rmjGYork6L4oiWw0DiJCQ5zyyQ6?=
 =?us-ascii?Q?yhz4b4CE79aY1xf9D1KtzaSVxr0IkOetK3ttQrIV7nmVJ5zkPKTBsgeIitVu?=
 =?us-ascii?Q?kMrcWNWRcnuaWCnmZwLCT7xVPyweSBQyT19R6zEg9S4VVg/3EJ2I9wgA4evz?=
 =?us-ascii?Q?OVNhR5lI854RCmQ0lZWQRLou6IDxMndb6+8+oeCYPixawv/3iaX3KxvwHL1Z?=
 =?us-ascii?Q?IRuWZWv+LODfsU7zHfU+dHn0itJb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0046.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?96fAQbjdueQ7boUn6+2G+wLDAnDtImQvOLL2dxmOHgWujGuIa0pP4nICbPPO?=
 =?us-ascii?Q?tREcQyfQSVl/aDWvoLyO22uMVIen581Q9GVozbmLAksB2TL6ZD149KMebuAc?=
 =?us-ascii?Q?cMcxNQH4VFGZxSr83uyv4WMVYXfmXOxW1XuyfukpMNAmVr/NDQ2B3SKumCG+?=
 =?us-ascii?Q?a+X8omN+p4fHCs7QHbUEi/bBEBzeEugyN70ejaIs5E5vBX+c67m1YCrfNz2D?=
 =?us-ascii?Q?fatA5Mvz2UQ2UpQFQRzybGUPwqgeH9HJIhoeWciYbb8QdJyi9quSLBpr4/3r?=
 =?us-ascii?Q?OaJ4PGMaLZ4z3+JyQwuvDcJBbrus60+sl45yx9mi7wscO4NhgZGa1qxhoUIc?=
 =?us-ascii?Q?FQTlrlZJplvVFGfiYrLy4zmdL7ikM72X/TIBA22hKZKBtfk18OZqyA7sjdJf?=
 =?us-ascii?Q?xSyt/KcrTWM2xFF+MPiRRw4kuX6dszEQiUap65H4qzGG0B/tPis2LcETZyK+?=
 =?us-ascii?Q?X666XRO6xDJtAUQfOzKMJI5vYcWU8Wbq2qLZwtBrf86e8jQi2ehLnYDKJSPA?=
 =?us-ascii?Q?sn9+thlq+kcVduBlcfnHnsp1NdPaGJY55xhtccC/A1pk9Zwr6JP+4eD1zor0?=
 =?us-ascii?Q?upF642EK+H+gH+9KpjppibE2FQ0F1tD9ZRsmf6f42WbgveYn2xBzF0pr4X0A?=
 =?us-ascii?Q?TjmRzTR3mlcfcTpGjqnvLUg5yCJbL7qdxThM2VlFxAO0hFtj/+MMLByOupv5?=
 =?us-ascii?Q?h1z7dP1kqld/+Jz48rHjO5IQMDm+idLVO0MgVaxsXVvxdbiYQugN7ELCZW31?=
 =?us-ascii?Q?vSHsjqqaC/IBy+ulR4ofpxWruSLngLBzdgzZipIrIlcqmfa4n3L6w6XzDTu8?=
 =?us-ascii?Q?Hkmw5qzUQNFndbdbEroa6StdCmAocanOWAU4mGdOCpYqSjSdPGF0jInCKNRl?=
 =?us-ascii?Q?aJsXGiFarSgKJORpcFMeOMW35VTvCsp647WlhkyAEf2AJ5eVUNJbCrTeeaM5?=
 =?us-ascii?Q?enXFZ3rkin+M7ObxGE+W1aoaKlaHoeWmfZIaYBSrUz7MGL579xPZ1xRFU6Tc?=
 =?us-ascii?Q?+Y/xRpBjqIzSkpNIaex6y+NPTZnzsbf9RbgWFx6/AaFDXegKU9L3qJidkdYk?=
 =?us-ascii?Q?n06bMV00uXQL/KQmkWF350ahyUlalQdzVj/C8peJbUgPt2JcTdGHGpewZ7Ek?=
 =?us-ascii?Q?1bN0aNZv0u0uESV8bmhWimrUB8fsIH4PVGAE23QqWXvuKF2Gacw4tqyVk/sb?=
 =?us-ascii?Q?lDAMWGZKDS5ewT80bAD+K304yNHE70tVTME+WukCRlUDO3eKTAyAwhSjKDE+?=
 =?us-ascii?Q?TU0IMgDGMcUemlBa0hYizXLClPGdTN+zHhoObJliQfvsKHa7LMAw5Ol9Yf9E?=
 =?us-ascii?Q?3GooUrANMg1jbPNPfgcvKGMhhysjHA0r20u6xWrTWHQ87jJucyWvDALfGHYQ?=
 =?us-ascii?Q?pRt2VHyTFS35bOS2gbbg+XlCzmvZh7EnTTchAc/UnzfInOcRSB8XsJCB+dHR?=
 =?us-ascii?Q?y5NGFKKzbOsEErk+ANlegsSFguzeHo1MnCIdgj9TaGLSbxqycPAe+zVFCZsl?=
 =?us-ascii?Q?gGlAFJbOnaXbOdqe3ZZidD8SxSh/XudFLyX0AqCRPndEcgVN512PbBTEQ2rM?=
 =?us-ascii?Q?eOUg0cy/wJ39iLGV+0mzhDlA14sUeeuN5J0BHapA/Opv4HjuGd6Jx8V40f2Z?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aad74c2-881e-4644-adeb-08dd3b9785b8
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0046.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 10:20:13.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyRisoZUC50szv9FeuYQz0qqipV4/9HGwN7PXjroOiWV8iFk6dLwboJKg9tHjn+MKQ2Rlewoo9HTEGPdcqxfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5314
X-OriginatorOrg: intel.com

On Wed, Jan 22, 2025 at 08:19:20PM -0800, Lucas De Marchi wrote:
> Like other pmu drivers, keep the update separate from the read so it can
> be called from other methods (like stop()) without side effects.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pmu.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index df93ba96bdc1e..33598272db6aa 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -117,18 +117,11 @@ static u64 __xe_pmu_event_read(struct perf_event *event)
>  	return val;
>  }
>  
> -static void xe_pmu_event_read(struct perf_event *event)
> +static void xe_pmu_event_update(struct perf_event *event)
>  {
> -	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
>  	struct hw_perf_event *hwc = &event->hw;
> -	struct xe_pmu *pmu = &xe->pmu;
>  	u64 prev, new;
>  
> -	if (!pmu->registered) {
> -		event->hw.state = PERF_HES_STOPPED;
> -		return;
> -	}
> -
>  	prev = local64_read(&hwc->prev_count);
>  	do {
>  		new = __xe_pmu_event_read(event);

I really have the feeling that the names are inverted, and that this
function should be the one actually called read, but I double
checked and everybody else is doing the same, so I guess I just need
more coffee...

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> @@ -137,6 +130,19 @@ static void xe_pmu_event_read(struct perf_event *event)
>  	local64_add(new - prev, &event->count);
>  }
>  
> +static void xe_pmu_event_read(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +
> +	if (!pmu->registered) {
> +		event->hw.state = PERF_HES_STOPPED;
> +		return;
> +	}
> +
> +	xe_pmu_event_update(event);
> +}
> +
>  static void xe_pmu_enable(struct perf_event *event)
>  {
>  	/*
> @@ -166,7 +172,7 @@ static void xe_pmu_event_stop(struct perf_event *event, int flags)
>  
>  	if (pmu->registered)
>  		if (flags & PERF_EF_UPDATE)
> -			xe_pmu_event_read(event);
> +			xe_pmu_event_update(event);
>  
>  	event->hw.state = PERF_HES_STOPPED;
>  }
> -- 
> 2.48.0
> 
