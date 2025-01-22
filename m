Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A21F193A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541989; cv=fail; b=PJKjvIsYSX51i4rBNYuxM81wTM4An2bJRHM3Wvv+5Py9Ckw1ApeMb+O+6WNYila2AjTp2mkfDWDDbPZHpbhP8ayZlZvsLL0UaM0+7PeJPA4JJZrJyz+MmyFRgZdWDWpigPi9xW04pjwwB1LtgYW8oYuMbYNRhi/UWtzxAdTirmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541989; c=relaxed/simple;
	bh=mNATzPxt5EiQa2Qiky+sFNX2Hb8RicJi4LOqJBffKHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IhqtIwrHu3N0syCbylg6p3Kgi8VJ8twSX7HFQL+RgEONxTZSJxZ7FPsLV639pAdvEnlnK63ReKHp9WR/FNBYltIlYi368yRvGTtYLtN4ONQhNDnASfK+rvrCasfWZlHCkktS+trekspP3Ii9U12hT2yhcZekfozTWEtyHjQ5Jcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWKryKcO; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWKryKcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737541987; x=1769077987;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mNATzPxt5EiQa2Qiky+sFNX2Hb8RicJi4LOqJBffKHQ=;
  b=RWKryKcObbPVajwcMlPJZM/bB9JIutaJUKuZL/rfMDIht7061VHUl0UV
   XQjxhQi0hCS17EQf0eIWNHy4wfFYwGtG/aUHqGcIohxROetBr6978AChR
   NNCc0apDROugrOANS3K5j4HATt7rFAWCso+PXWtf7YvMVJ0qxiSxoTozC
   4Xi9RsiPZuxCELhQvuHePW3l9zRjY7GUASnd9D+RfGHzn3P7PUam/Jp4H
   kKo9BoYbondy59dcFPsA2jaweZ975RZTAUvhxWk7HlOBVesbKkyWJA5fP
   EcuB0rHLdBaDFdyNWQtN9pXob9c8japw1nqcg7qMnViKwvS7wWxacOg5w
   Q==;
X-CSE-ConnectionGUID: WfIuhgU6QMmN3jIwJlQe4Q==
X-CSE-MsgGUID: KzGCziUhQY6yCqD92PKnFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37870887"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="37870887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 02:33:06 -0800
X-CSE-ConnectionGUID: 07BX29XURya+2esG4aBCgQ==
X-CSE-MsgGUID: H5gyc/nPQX+fTHoHlS1S1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137975875"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 02:33:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 02:33:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 02:33:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 02:33:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiYAS1uU0o5wUIGb/FibRAEg7nJPj1s7L0PPvdIFi2TC905XmFLI2fDeU8Eb+cG1B6AKMur3Tda3rwoZSqcoG3i6NxVDGtyj6xc++MfCtFXLv/ewxc/fJtu6G+b/4eGvGo/v1LTaclgK4wdNaKH0YFJyOQgCd+bSSI4UX+jQPTVXNlsr79O5xGe9ceASudztjWfwSBTZaMh0GZycbBA7eiUrNjFLvzblg6j4gFgDZ1NerxeENFv7H4R1yRR2Q5BNXasLT5NzWwE8fAikHyy9mntLG4N8rud0h6XZSJzBnexUQcZ/RBnaGNcwpx5UL7U0s4OcnOABIXIo0uUzfKJBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6GyL8P2APv+QLsNuPosQ591J+jogK1Ro+1V3Q0NsoU=;
 b=Ze9HEFG5dbGi71yNLCxSeUKhok+IA/nx2tdUkl0eb5VVLnqE1DhXBOMkCdVY55u8/1BL7q3yrxi7IbT6L65E9OK0vCBE+DAEJNnFWFFUt/Htx7geMEmXhSRoZG2c8qR6Wga77vb8+md6ZwuQi/wYxa0Re2WHR49+lG5fJE3oComXmZ6TsXsJz/EB7SnF10HxvsY+HJmJn/feDOlsFX6UhB++qABXAgAiguyx9GXrZGbJNyoCHCtnfg4wdRUSdJSPiNbGOQA2FZcOGb6sydkM+pq1D6LU7D3kSHUbwRUmdRb+IzXybZ0LB5spyaOaRAQwQWirLFJ0TbNnjw/E/jsxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7SPRMB0046.namprd11.prod.outlook.com (2603:10b6:510:1f6::20)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 10:33:03 +0000
Received: from PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc]) by PH7SPRMB0046.namprd11.prod.outlook.com
 ([fe80::5088:3f5b:9a15:61dc%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 10:33:03 +0000
Date: Wed, 22 Jan 2025 05:32:59 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Riana Tauro <riana.tauro@intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v14 7/7] drm/xe/pmu: Add GT C6 events
Message-ID: <Z5DJW7oYSlp6ZTQn@intel.com>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
 <20250122062341.1100173-8-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250122062341.1100173-8-lucas.demarchi@intel.com>
X-ClientProxiedBy: MW2PR16CA0035.namprd16.prod.outlook.com (2603:10b6:907::48)
 To PH7SPRMB0046.namprd11.prod.outlook.com (2603:10b6:510:1f6::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0046:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2f83e0-a2f3-47a0-2900-08dd3ad02691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fe4AX24yYg8WY6HbkFKEkvTJ/nnCrb39zL10vKVZ8mLpR7jwjwYVxbPifOFL?=
 =?us-ascii?Q?7xnaa1Fb73bufdkMEEzd/47qXDEJHwnNPoeYg2OSg7b9FWoLY60zhlvZyGvb?=
 =?us-ascii?Q?dj8uLBuPSqBFjiztdhtIPhtxZE8GI0BceSqWJLlJ9C/gBP75RH6HFhSpGSAk?=
 =?us-ascii?Q?8XtB/vXKbOSs4lEUfKTG0Sj19+IuVipz8HfGitvYvvh1yekHG6gMktS9Hhvz?=
 =?us-ascii?Q?wh8WrJRy+jXAL8YQaQmIYwUx5JnKEjzDX6ITH9n4fi51OMAzEhCVWPDTtas3?=
 =?us-ascii?Q?xYmgEASFpbdhEBLqpS0PrgFBJ8XZpwzT0p8J6KajA7cNyaV4b4ZjLLShnUAh?=
 =?us-ascii?Q?vVoknbwAjcFw3tEFa8IYp0oN8e8GL1XYWiGx9IlGKNMhQPZNYA539K7fh28K?=
 =?us-ascii?Q?LN3nH8kpvJ3XUB4+Wbsb3WfXv0UBByYkCy32tD58/ivTSfr/bri01VqWkSed?=
 =?us-ascii?Q?CIpYuYDlX0kNNkG/DOeCENOEqLdxRljXYcC7Zp88Vl5MiYnpOy0TV8dnXk6p?=
 =?us-ascii?Q?a0aGjeim0h+AOFmvhIfNS51/dIa/9WtOjF3YYjAFwUCFS+Rp+uruaMohnMbX?=
 =?us-ascii?Q?Pao4r4sq/0x0KSjK1CtNYyjw6wK3vfjx7z6xN58crrxnED/29OzSUeUqsHh0?=
 =?us-ascii?Q?5Y5HGQ3LGS3QYZipF2wrA5k4zb5WkaWPVuGYpKzhaEXoWLXbzQJRrAU0EoQH?=
 =?us-ascii?Q?oYHD75M7LqXgzGPl6klTKXPxRi4gvukCQk3nAwVF1t4Gtv6pYP3BLR+D0JxH?=
 =?us-ascii?Q?+8Crn1bLBBlDxLrcDPFGkyo8tJJBQeriOtWmR/Q4U4VeRAV9VIt/yJlUkjOU?=
 =?us-ascii?Q?/GFwDvSmlEpuN5qSlMzwwBaR+D2RpHMLN8vdXLsTQB+Am0N71hvjkVjv3atJ?=
 =?us-ascii?Q?I+KAgNDVdscaSYN5gpfIEnMndzI5J7e+t2r50NNs7zIIzRh5pABD2Z6dmnab?=
 =?us-ascii?Q?8VQTQKfqV0LltXeyxxstpprx26YL7XmBH8W1XxLFYymPqTdpUvtd2bbiUBN+?=
 =?us-ascii?Q?BH5QfZa1O0Su1UfFushzEteX3gGjz7bF/0Bmev6/zlCBG1m6Zth2HGQ0rfKY?=
 =?us-ascii?Q?69+Ihpt9laxEhjQKpoa7+vxLevboqbTIGH1Rxds1iJhrGKAD12Ff1meJY0LV?=
 =?us-ascii?Q?WIjpyfHUz1Wmc7CbpaeK92We5WJjk84Afa1KV773A0QO8wPB1i0h5/zUC1Hs?=
 =?us-ascii?Q?Mc3zubHvmCmfLy3ZZAbcaqCqO6eEziGvs/nMqArF0NHbkqvLKpanILC/4LFX?=
 =?us-ascii?Q?WiBQZPIApVlCr3lmZu8wMWBQMlC8eRzrQ8dcJUaddGts782kzXnWQZhhgsFT?=
 =?us-ascii?Q?BV5GliQnU5b17NmsyWKhJjfZTuTZH5FIHR2pCm8HVBtLJ8X6bssQ3b3NA1p0?=
 =?us-ascii?Q?rIEA9zqTRmZfBaI2UwCVrQmysjiT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0046.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WMx8/io0wywm1Ds9zGpQWZ9qStpUzvXuyu1afhs4MMfVLGnjrhUIh6U1Q7Zv?=
 =?us-ascii?Q?5ic5PqS+E2FpyRc0EEyx/cNHkfBgN9Jx6YpGdrcQKD6hamTc5lDGA5Lw9r97?=
 =?us-ascii?Q?+YkfgJ+qkGDQCVQdlDtr3McUXHuyTRSRZL9GPmwbzdrA+4hVilwVVSP+VRX0?=
 =?us-ascii?Q?aF7H0aKkzqV7Hu/rDYpkyglYB0fVRAqg+hY42vU31Xw1aKaar/BIwM0i+d5W?=
 =?us-ascii?Q?hXZ7o+2ryJNFXA2lCzvnUC/n2B2TeTdZMVLCf/F9pXKGgJogkFFemmxk/Vno?=
 =?us-ascii?Q?gBvjlULT0teHZM2X3uRR/ITLBhBxZOLrMirDOCy9agFH5/lx8QP6CeDLWPnO?=
 =?us-ascii?Q?3kjmncx6z3f348RtAHI5WUg/6NfA3R/9pu0IyGcWSQQHIfC2bG7+Aw19/U+1?=
 =?us-ascii?Q?KcT35GzM+Nx6z7HActNz6mW1T7B2Qw0ASP+3AYmo1ltkcRjBKr8bYQgszJJm?=
 =?us-ascii?Q?57ggXDqDfiZYLyrMleJGQVQ9xSTE/yNWq/03gBh1uxlfmURZ5gFU8xAnNinf?=
 =?us-ascii?Q?u+3/m/9okn8P1+hd86RvJOzh7zM+MLPMhi516igW5n0U37yIvgabi9SM0v5U?=
 =?us-ascii?Q?tTuuro2JEexb6Qx8U4jOlQpPWBiyqHm+im0Chnl/WlOKorHlswghiDf9jLt8?=
 =?us-ascii?Q?q9ne1xZbfIFyz9zc305M9hxbZ4wzAihj4zWxxGhdJl25KSuRM5Snwlfz8p16?=
 =?us-ascii?Q?Fj0l1BEX5RZJRSp4H1LHd1FGN0TvPa9iw4aciKGVwJxIr3c0c+e5m1yrhUKK?=
 =?us-ascii?Q?Egf0/jV/hcJvTWhuXprqVd3swExPCNsHvbxVSc5ECfJiQ4V4O2Q4sgPT1G8E?=
 =?us-ascii?Q?njLvdlewk4XqxY1o98T8p5aMv6Kz7qsvJvqoUtg9NyxwDHP9eLX1qZgfO1hc?=
 =?us-ascii?Q?E3ZQVLO0K6lxfmKf/cHUXp5wmajXJ5eNA16aKrZpOOcAqMVUM5tYjzSIOqGM?=
 =?us-ascii?Q?nKX7PPmXu5AT+pULtLNmWa5b0WSqyYxz/i6QsGDBOiMTIaxJHLRvDY12SIB+?=
 =?us-ascii?Q?4J0IS0E/nFPqXi1nnNLaDaakTPGZtC5Ji6R8SIOOAfzi3EmEbpItf7MptXyy?=
 =?us-ascii?Q?iVqD0PiYTr0Y6FHYxRolSKFsoiaFvkKXi8UKGOesU9nIFpzBDyyrcur7OAw3?=
 =?us-ascii?Q?Zn7zKLouTcFUBKT73LsInDrrSB+NHHILJrUAxSZZj/b1jgedTYqaoebt7YO3?=
 =?us-ascii?Q?LOSqmlqjPGSZSP30jFrXdnxISdy15nGc7Y1siPTkz4FNvxm6uRub5XQPLrZk?=
 =?us-ascii?Q?STDv/7YMF8QSeib7gO5nUgLYU8cVE1lTy1yWmfAAcBMetLyUq7iij7r1iKcf?=
 =?us-ascii?Q?XMxyQXRk1ETuiy0h3PgDsJARy79KlsHm11trS1NbVJo+VwprZVUsrxW6x74F?=
 =?us-ascii?Q?cBNSg+zrvTL6iyn47koOjKXChlOC+aYm3sm8aEgx3cgMdUxItMfeVwR9L4Hq?=
 =?us-ascii?Q?GpT+O+ogCMsMQxzr1eLuEqY64xoVR94j9i2XDJyypXe7vt1k6EPXCeEnRFQJ?=
 =?us-ascii?Q?3VLCW+6Jyw9yYziFjVa+sX2PQfLqTd4NKidLwFY5bPYOAJIK0gND/wXJCH/9?=
 =?us-ascii?Q?pQn/RbgFn/bwHHCvEZ1/cZ5m8dKbfzwW8boOj6IOP23jcNq0/4PZOzWrMQx/?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2f83e0-a2f3-47a0-2900-08dd3ad02691
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0046.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:33:03.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpOBBCvwgiO2eC0n4RRzjC5mCnLDR8hnWBT20Ztl7ycbCEXp9ak45c0EUHeNB1XW4qDEcqYVaBxxrpf5cZIcFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com

On Tue, Jan 21, 2025 at 10:23:41PM -0800, Lucas De Marchi wrote:
> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> 
> Provide a PMU interface for GT C6 residency counters. The implementation
> is ported over from the i915 PMU code. 

This is not valid anymore right?! Perhaps rephrase to show that the API
design itself was taken from there?

> Residency is provided in units of
> ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
> 
> Sample usage and output:
> 
> 	$ perf list | grep gt-c6
> 	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
> 
> 	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
> 	event=0x01
> 
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
> 	ms
> 
> 	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
> 	#           time             counts unit events
> 	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_pmu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index 8d938d67c1f2c..a2e4addd3dd7e 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -11,6 +11,7 @@
>  #include "xe_device.h"
>  #include "xe_force_wake.h"
>  #include "xe_gt_clock.h"
> +#include "xe_gt_idle.h"
>  #include "xe_gt_printk.h"
>  #include "xe_mmio.h"
>  #include "xe_macros.h"
> @@ -122,12 +123,16 @@ static int xe_pmu_event_init(struct perf_event *event)
>  static u64 __xe_pmu_event_read(struct perf_event *event)
>  {
>  	struct xe_gt *gt = event_to_gt(event);
> -	u64 val = 0;
>  
>  	if (!gt)
>  		return 0;
>  
> -	return val;
> +	switch (config_to_event_id(event->attr.config)) {
> +	case XE_PMU_EVENT_GT_C6_RESIDENCY:
> +		return xe_gt_idle_residency_msec(&gt->gtidle);
> +	}
> +
> +	return 0;
>  }
>  
>  static void xe_pmu_event_update(struct perf_event *event)
> @@ -268,6 +273,10 @@ static const struct attribute_group pmu_events_attr_group = {
>  
>  static void set_supported_events(struct xe_pmu *pmu)
>  {
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +
> +	if (!xe->info.skip_guc_pc)
> +		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>  }

A feeling that it would be better to squash this to the other attribute patch,
but I understand the reasons...

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

>  
>  /**
> -- 
> 2.48.0
> 
