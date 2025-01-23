Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD920B22
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645872; cv=fail; b=kooyVeLEhsLegfCU9x28+AzFz4aoGXEvsGOA+PdptWTLD6NUP2qR6Mpt9DGuPo49HhjSwj/D7qcjp0JvUQvISOapTMdaDerwzdy1YyoQ06B5IMqw8Y9wnrUf7J8pegTOAtPyX3it6ImF4+3IJFFTZrxRvEhgJcjJUwSnMF/sVfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645872; c=relaxed/simple;
	bh=ZSlJN2zmsaduuogU8NKqaw3DkG7DYkiid4e/Gv/E7LU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5JB5OAT9NVnJ21J4l0acC1rDx80UgNQ4Pbk5+2/8Sxnprt8qtDzIZeik1TOQq3kS1KWy8hd1ii6s7hapzLU32nX7brxVAZ67+WduqlktF/twdb6v2k6vAQSikkCBqPSQQVyXoIj43l6+WMb/ZW6HEeDXG6PQbZVgWSbydlrsYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niDpstyr; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niDpstyr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737645870; x=1769181870;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZSlJN2zmsaduuogU8NKqaw3DkG7DYkiid4e/Gv/E7LU=;
  b=niDpstyr5vgqoUwEH85OClolJfOPvwCq2JmMSgljq04wB98cx1bzQ7xx
   Jes9L4cyh08gjLgF5eqx/d/ZF+KSU3Zras2wjJeRYAFrydKQ8Ri/ZdVVE
   B0YIsI/h2+bxXt248NqRDsty9h8EM2bEyF0h3gXAyTkUvZsStGOKoixu2
   ugiHTSyJUmDecyJkj0A5gi6yWsMWwxR9BV4YFt/a8ApK2LY6ks3dimRiJ
   Rh9RBSBc46ligOTXyKTKcfNR9akISXBmGrRdlfsisfdHT9MI9KRFNX1qT
   4oVmD976XvuUFV92LwrwnCA2TSh1mSSNIvf/DBTAXHf/pldg1Gr3EMuKN
   Q==;
X-CSE-ConnectionGUID: euH+z3fmQfi5iEiBPzU2sg==
X-CSE-MsgGUID: ISZOLRLRSvCatWlDN9iqlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="48737519"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="48737519"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:24:29 -0800
X-CSE-ConnectionGUID: wrPk3wfLQWmaTCCQB2whjg==
X-CSE-MsgGUID: EbaVycrhRI6twKFFHFXZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107907350"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 07:24:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 07:24:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 07:24:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 07:24:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4+sbdymOJMl9r1wJ4yNf3D1Dve+aAyIOuB2/9UDU5dPDx4WFESvFxbtDbG3UivCTDcV+DxVBWIQC3oHdW4czNSmzfPExk4XuotGihB8mnDXF7m0z9Rk7BqsSzqrltM0hY9ylDO8W1tmAwjNXn+LvN2zgRR8TVA5Lk7Kn4VPTDGFZDfFAwQkYwvb2WlM+wWodAdgA3Jbx7AR9kUGBB3HYsqI9VaUJ5lXQ4vTKT9bHnUvXUUYB0gEFq2+zvnweGCAePgFMFFOC9leYU2dnPGk/9JwhJwPwGk6IXClpY4GyhvYvfWbtcVXlM2QmJgh2O+deN8rucevbGAh47TgG6rnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5LoG22zAKM7izEPWAoD/omMzgulXFUG9UGweUKsuNc=;
 b=YYch1JWexq15U7e0DSUjsyAJ6dnB1mX+0xjzzect0tiPiw5TUcWSj+W7SemG/aQ5gBjRRhJjlrxxAthojpGBBdW9/zvfvi3qhKkQI+FvAPgmX0tJS+80bNBn0ENaFvybUOWqErFXpUEp0FJNDfUv3q/gHez8Hcbe55OlR7ChKnLRo6HPnTU7RZpRq1K9f1OuGirnVFicCQZHyung/wqAUwM+NBXIlLac8PvwFbhM8dgGkIgGqM9A2Qri46UX5uMge+2XDgZm+SuH33WqmhAmRqONWNweYb6a9jfonl7tM/2E22gv47hgHTgRGk7G+Iy1Mqxtc2qBBKEEpVubeA47Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7SPRMB0046.namprd11.prod.outlook.com (2603:10b6:510:1f6::20)
 by PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 23 Jan
 2025 15:24:26 +0000
Received: from PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc]) by PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc%6]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 15:24:26 +0000
Date: Thu, 23 Jan 2025 10:24:22 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v15 3/6] drm/xe/pmu: Extract xe_pmu_event_update()
Message-ID: <Z5JfJmEPNrDd0HLH@intel.com>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-4-lucas.demarchi@intel.com>
 <Z5IX2Rixtx6csrKO@intel.com>
 <djk45hhruejm5yzsvyn7jfmby6holhyhfk74xnbkxmot2yqmwf@l2kz7pjdxvvp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <djk45hhruejm5yzsvyn7jfmby6holhyhfk74xnbkxmot2yqmwf@l2kz7pjdxvvp>
X-ClientProxiedBy: MW4PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:303:8c::25) To PH7SPRMB0046.namprd11.prod.outlook.com
 (2603:10b6:510:1f6::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0046:EE_|PH7PR11MB6498:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d474a6a-1d79-4593-135e-08dd3bc205a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+kx996MmoGj6DvaBZlyVkHp3z1Ql9HlrDddkHLgGdyNpLhLrHSLA/w47hyFL?=
 =?us-ascii?Q?NCfHq9psJIoMV39n4FNOAa8jg7fAW1Ba1Oqwh02CCDkV9mHNcxzSaYxwpfqH?=
 =?us-ascii?Q?TD19bVNiUGFq4S96o1Nab5+emm9H564L6QCR8W5owaCMr6eYlVWFE7sYfs89?=
 =?us-ascii?Q?DWQ31s/QCUbSPE3pk3eLxl0GkEUk2Q1nHEmmaZxEUbpkl8F51uFPIsgIZcbd?=
 =?us-ascii?Q?1rLLE6p12h4M1RpNQ5K5oEmzUAFfGe2d9CmzRkR2wY1jKACckyhWh8fr+N76?=
 =?us-ascii?Q?/zlJd53sql+DgXqEKvCGXWXdAaEM3ezwBUE6XBdJny+1XTaCf4ZyAVElCDM+?=
 =?us-ascii?Q?fniUM/19BZ76Z+qvM+LuTmYUU7ybvEVVbhK9oRLzxTdrSQLcDMhCkexKWLCM?=
 =?us-ascii?Q?ZcoocyinYD/kKUi19ESziG58vOBmz948/OcECKdvINe686y187jtKWty/zp8?=
 =?us-ascii?Q?oCYOQsJ9sFAs5HO3OQbuiAq6P3yXZUXjgiqPDNgfmMnFWqH+10JQ7LxSnxX5?=
 =?us-ascii?Q?hcrYIrEEUEy6zaKYJE0R3UekJXAJFJz+DCaH30eN+K3kOODYEJUDNDN6OX3V?=
 =?us-ascii?Q?SMJMUE3vx6/hKvkrvJo+kLvoJ0BJw5SmJRuQrlUL4NoWu96HTYnlT/0YyrpX?=
 =?us-ascii?Q?dRE0BhcZ+HmtuDLL48MgOMpX5YGMYPy7g4z7v0TGj9wwRe9rM2cW4w872Kpv?=
 =?us-ascii?Q?ETBfSztu/stSpiv2ouesB2uaQZ+FulkTFKEXoaq05q58uWIaKYD+d+7ZoFef?=
 =?us-ascii?Q?/DlnnWPyxsdXjzLCfL820MVaeo3TlvVgEWL3rqAscAaZvbEINCAK587d5cJj?=
 =?us-ascii?Q?Wq7S1eMs4rAK4+TI4NXUUIhQL6C/pAqcnGqDMkIVoDY/USOYYnOoM9yFMSRO?=
 =?us-ascii?Q?A7zxjuuTU7zSN8K2ZW1R5EEzjIlXl4CpJBzabSwlZIc+NFHanoyB3EkNK+a9?=
 =?us-ascii?Q?S9YWncG0b3r3DNkA9sZ6HhwE7xXCZVbzJ51CFlpKLFELGJqThy2St2e14L/k?=
 =?us-ascii?Q?MuIyOwfKLqcR1LbJX+T+5v3JGL5GZguFKcmmY+6mZIRhHG3OQJhDSCCOEpPt?=
 =?us-ascii?Q?3RwMfbDTIkbrm1d27k4wKUoNdv40aGAmpvKAPgw7nB3oWpkWxNalCwu9Wm0g?=
 =?us-ascii?Q?V77G4UAErXTe2IYY8Rinvz68Fz2LA7fPEXgz15pgUD/MjyAJNkmW49LIEBkX?=
 =?us-ascii?Q?b8ZFuX4PDru4eQdYzVvrdzB5PPxpKym9VdHzj2dNjAVwZOW+qaWsOtZV1Fj6?=
 =?us-ascii?Q?astcAUlwMgzIZqu2tBfHXourLdt68CkoZ9eNQfqWsIvi/wW0VmIyPP+mj71v?=
 =?us-ascii?Q?Ffpv576I+nYfcmFAeffu6AB133KpF6bYy394ik1emBivpd2EvdnO7txpTkaP?=
 =?us-ascii?Q?+YDiqj0S0aZ8jNqY4wDMXIZRhGDW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0046.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qy0CuOdRtzcJXrv0bzjeg/rCyCV6BamwbljLNxx7uSKsf4VkgbZriTcq5UbN?=
 =?us-ascii?Q?MY1JZ6+4hSKHCOAk+xR2FaJ3deodMnpOFMQmLh3DVXzwj1vh0UqgHFkFodD4?=
 =?us-ascii?Q?0+LiXWvcgqoR12CwNmFsZbTUTJR+z+ZKeBxQS/CGleU6zJYe3KtgSpDCMuNi?=
 =?us-ascii?Q?EzS6yVHC215qzWFScasP8zgioH6O2DeTuZSQB7hgit1ah4/VkJ+nAmVefULX?=
 =?us-ascii?Q?YVqar1TkYtnA7mM7PW0hSLMeEwkAd7Jc0h7OTu7BgiWZ/mCHwX99Y1+FDbks?=
 =?us-ascii?Q?sqNj6xHW+50ZB3kxw0qjv442JCDGByzHJ8S0RL13kpANjRg1TFOLNyBqvk7w?=
 =?us-ascii?Q?K37nDFvg+JA/qH71pAVATEtGsdKe3GMzYyVgAnxqJxV7C9AceC4qQWXW32ee?=
 =?us-ascii?Q?dhwTtvDun3VkENDmM8QreYtQGqwE4W/Fc7w5VT0oLAiYAWiUfWhEFKAb3jXU?=
 =?us-ascii?Q?vAq1RJDlsFcRZ0d7fgdKmmP8Dy4e4lPZilVa9MXb4b1Usxi3erjQfZV/v4Zr?=
 =?us-ascii?Q?6kp5x+mHE4jYXy9LTKqpcgHHAiQaLaR3uxb07ZhIjL3INDrS7sIkgMhTpdFt?=
 =?us-ascii?Q?r+FjPi0I88fbG0OIbEuiCX/BiGGFnMbMrI7xFxbsDzjIMhc31RrtCadKZmI3?=
 =?us-ascii?Q?3ULduZ/akqXAk8iexJYK3zn3o2Gk1KNWZFcVIyNGyu62RCmJLswuyKFxBzqt?=
 =?us-ascii?Q?vnNA0tCDAb714S4OOD4y0+xzW4aIg1wGok6d95uTRSjjPz4x7zgxusAwzshv?=
 =?us-ascii?Q?QrQjLCGK2ltHcH3zmCyPyFLedjGWDrJ/DS0EjS/wgcAlfI/YXBuK+xZ9eqFW?=
 =?us-ascii?Q?V2J1nelenR04H8Nvgc8ilYgWOmZvB6FOxhKW6iPKFXWo8jWnd25iu8hglfUF?=
 =?us-ascii?Q?8f+/oqZeWxDl69tA0Oq8Os5yOzgmpGZAusULy4LgESia47W3vfVXgxPnYh35?=
 =?us-ascii?Q?EHEMJMbSiPhxxUpxkhuomG4fAV9I9hcQfNTiq+W7BCdqDPotwBnQFEFvN0G/?=
 =?us-ascii?Q?0NVawyRQtO7ww5Ud6yLkPV0Jdlvdrt5FZpJErxbjx4GNYQ42mAHZ5vr/y6/o?=
 =?us-ascii?Q?lbMOOlncmPSNNLIKLRIzSS3TEfnhqnt6c5wjtl7sHfhipE3anPUdj9/gG1+O?=
 =?us-ascii?Q?IEYMfjPo3ALgSYGqHjEKATPiZw0JnZfN4SKoYBPEQjOBSO5OUcNRJD7yl2oV?=
 =?us-ascii?Q?rLZjscbb/aN0IzQqscxZ53qdRQYN8IIqKwF2TuvSjEzHav+2klfTXed48VDj?=
 =?us-ascii?Q?gyG5BEoB+v6exhmV/oe24mYMyAvlJG6aKy0TdoWzEyuZSdThIts8z7FbTScl?=
 =?us-ascii?Q?KXiOFroIUfNILaXbKbI8vWUxEs/JPZqhm/dQEbxa5GBEc/DxjmHHSpxMocnd?=
 =?us-ascii?Q?MQjhSTIFxtmeeWoVhkfGIL+fRdYkTZKtbQRkbe13flmvUwbixk/+zE9ySTSh?=
 =?us-ascii?Q?t8C827f/n1EvHm1O1xEph7gWlSPlLdcfYfEbUe8zJcql4fNuSUTB6FJGaQ6y?=
 =?us-ascii?Q?dJ9HUpwFaMjx29wQQQ6mo49vhL8quB4caYCrEYNJLeHYdyt8h5aB611v9vcI?=
 =?us-ascii?Q?p4fWlTEj/ofAZFP2VPaENLWR8894ObmfPBsc6OPnfnjnWB5tDY9WOwA6ksJA?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d474a6a-1d79-4593-135e-08dd3bc205a2
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0046.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:24:26.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AkoekSYiFOn7ekPKMljbkKX9REEunR2kdinJ1A8pe9LDQu8q3Dxsvgs/CuOwnIEtZ9kd62YMPt/YaoefI8dbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com

On Thu, Jan 23, 2025 at 08:59:16AM -0600, Lucas De Marchi wrote:
> On Thu, Jan 23, 2025 at 05:20:09AM -0500, Rodrigo Vivi wrote:
> > On Wed, Jan 22, 2025 at 08:19:20PM -0800, Lucas De Marchi wrote:
> > > Like other pmu drivers, keep the update separate from the read so it can
> > > be called from other methods (like stop()) without side effects.
> > > 
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_pmu.c | 24 +++++++++++++++---------
> > >  1 file changed, 15 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> > > index df93ba96bdc1e..33598272db6aa 100644
> > > --- a/drivers/gpu/drm/xe/xe_pmu.c
> > > +++ b/drivers/gpu/drm/xe/xe_pmu.c
> > > @@ -117,18 +117,11 @@ static u64 __xe_pmu_event_read(struct perf_event *event)
> > >  	return val;
> > >  }
> > > 
> > > -static void xe_pmu_event_read(struct perf_event *event)
> > > +static void xe_pmu_event_update(struct perf_event *event)
> > >  {
> > > -	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> > >  	struct hw_perf_event *hwc = &event->hw;
> > > -	struct xe_pmu *pmu = &xe->pmu;
> > >  	u64 prev, new;
> > > 
> > > -	if (!pmu->registered) {
> > > -		event->hw.state = PERF_HES_STOPPED;
> > > -		return;
> > > -	}
> > > -
> > >  	prev = local64_read(&hwc->prev_count);
> > >  	do {
> > >  		new = __xe_pmu_event_read(event);
> > 
> > I really have the feeling that the names are inverted, and that this
> > function should be the one actually called read, but I double
> > checked and everybody else is doing the same, so I guess I just need
> > more coffee...
> 
> yeah... that's because "read" here is used in 2 different contexts:
> 
> 1) as implementation of the perf_pmu functor. We are implementing the
> .event_read() so we call the function xe_pmu_event_read()
> 2) as the verb implying we are reading the HW since it's commonly used
> in xe, so we call the function __xe_pmu_event_read()
> 
> however the perf_pmu implies that the HW values are updated not only in
> the .read() call, but also in e.g. in the .stop() call. So we have
> 
> 	xe_pmu_event_stop
> 	  xe_pmu_event_update
> 	    __xe_pmu_event_read
> 
> and
> 
> 	xe_pmu_event_read
> 	  xe_pmu_event_update
> 	    __xe_pmu_event_read
> 

This kind of makes sense now, or at least explains my own confusion...

> __xe_pmu_event_read could be called event_hw_readout() or something like
> that if it helps clearing up the confusion. Thoughts?
> 
> > 
> > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> 
> let me know what you think about the rename above and I will keep your
> r-b.

No no, let's continue with the style that is used everywhere...

> 
> thanks
> Lucas De Marchi
> 
> > 
> > > @@ -137,6 +130,19 @@ static void xe_pmu_event_read(struct perf_event *event)
> > >  	local64_add(new - prev, &event->count);
> > >  }
> > > 
> > > +static void xe_pmu_event_read(struct perf_event *event)
> > > +{
> > > +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> > > +	struct xe_pmu *pmu = &xe->pmu;
> > > +
> > > +	if (!pmu->registered) {
> > > +		event->hw.state = PERF_HES_STOPPED;
> > > +		return;
> > > +	}
> > > +
> > > +	xe_pmu_event_update(event);
> > > +}
> > > +
> > >  static void xe_pmu_enable(struct perf_event *event)
> > >  {
> > >  	/*
> > > @@ -166,7 +172,7 @@ static void xe_pmu_event_stop(struct perf_event *event, int flags)
> > > 
> > >  	if (pmu->registered)
> > >  		if (flags & PERF_EF_UPDATE)
> > > -			xe_pmu_event_read(event);
> > > +			xe_pmu_event_update(event);
> > > 
> > >  	event->hw.state = PERF_HES_STOPPED;
> > >  }
> > > --
> > > 2.48.0
> > > 
