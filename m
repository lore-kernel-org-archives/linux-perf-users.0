Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5D1B0F2C
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154371; cv=fail; b=mVfgyZraQxNS6QvPIbR85ZmPzwwcpC+dBXvA/D47qbeBH1Wu16zKnaVjNiCZUArNudEwgWOSvFT4mJfQdTrc7FTZpmai5ObrssU1RTt/J8A+1+s3Uwz6Gxp2sk4ZFzfYmAmi8FHLaWS+3eh0mpw/1Q065auA6TSOxghFaPLUJig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154371; c=relaxed/simple;
	bh=hdRNFUhwCrr76SHIEAuTAW4qQbn8eaHaj+nbaWCBprI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rS825GOX1IiF1ZqUaMo765frgKQlWvSbBRVy9wpt33frKSea1sqVl9Oalq0gIfFDuQQ3Xno2KNVGHMTKGNPbxBnhoqqkv3UGpnVyTDQwBcwCOAYO5IxxJbrKJyiEog6RhCLQLXjm1Q8IHi561n5iXJ4/2qrY/SQyfOS2rm/4Hwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4nmw6+i; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4nmw6+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737154366; x=1768690366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hdRNFUhwCrr76SHIEAuTAW4qQbn8eaHaj+nbaWCBprI=;
  b=R4nmw6+i3vJ2Wuo8KEKHn3ifYrPOxB1006mLd8SbrGB7foQQu/XP/xs9
   4sD1H3p4cZpBjd2hlf7aq1j88I2Pw3JELFSV+dJntFQ6yfUIuwPkh4+uo
   kI+wp7pjXkCfgkxvDlCv4KcXq/vjuW6/Ark79SLu2WVtfaJrm+mgdANgN
   eWFAQ5BlXD9SmwQLFHE0ZbbT1jCQIMHq4o+liQpC+MIntPdVPGX+aGCUv
   JGSWKQ+PKDLo2UqY6MeQrGb/AfP4DWHEYsJ3uMHJInnEOvlod50A04/GN
   LqDELxmaXqJYhbQATFylRbPYDLPTj/zPoZ34+foxvVuHo37zclGhI91xS
   w==;
X-CSE-ConnectionGUID: Y3DrBs0XTXSDWL5KOWl4GQ==
X-CSE-MsgGUID: Gw/uIqgqQfeakM8mQeiHHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48996618"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="48996618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 14:52:42 -0800
X-CSE-ConnectionGUID: 1fDnbdKHSCS2RZC20zHWLQ==
X-CSE-MsgGUID: 9r2fceInQ0i0FpA99ygvHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="106107685"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 14:52:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 14:52:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 14:52:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 14:52:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl6scpDKaBYJAt8cjJmWu3ZLeAGXGbkGBkiAKZxTPqNy/ghmOhm8IMUjtdb7ljugTkeoj8p/3Hnj90XNnWslJcBKzNpc/tgExH/vv6ak+OvqhLiaivqs0zkkYce1GCgCyoT8HO9zP2JkV3nDQYU9/IT3HVC/OyyPU7/180wfuKC+4QuCJRCbEcLDSanzOzk6B7CGyUHr0kK5WdWsUHFgZ8eJ/gEIYcaSvPAuUWPItuiB79cNiomD/O/hU7PSzmKYNTfIDXxplgRFydOSyqlG1xZrKfrtccjiLF9uQS97AfoVsMAWa3jNoTAbXyFMScj1zv4CMiQRiXbbpHHufNEIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=633FwY6dDEOrbZCTDE8/ktQQg0hqlyL7I8Q+AIfKvHI=;
 b=tbOokvN/wOUrdHHHHL5qxy+IRO+C+BB5/QU+nRDZ1PhxpRr8lJMMGweaC4iM7QXAoVa5dCelDv3WWqVbS7+0w/gqTQjdza0AD1DWr+qD4yYTuV+A5dcjfxzd7O5I5DGiygnRrur/yaEGP6NKQJNU9Vp4buXHKKfxS2Cx72S9V3HL9TBsv4irHZdYvU6RusFJgoeR7bpqluEdD6qggTz30N2dqjarHZaPtXQj3b3ZKAO7gh9Yurc37YexSidUbAexfL/LOdl9qzCZnl8Ej0sG0j/JfKSI9wcIssBNv/RSkEakLJEw516BVQij3pkDWQZHcatINB1nf2XbIr67I1v3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 22:52:39 +0000
Received: from SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72]) by SN7PR11MB8282.namprd11.prod.outlook.com
 ([fe80::f9d9:8daa:178b:3e72%5]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 22:52:39 +0000
Date: Fri, 17 Jan 2025 17:52:35 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>
Subject: Re: [PATCH v13 7/7] drm/xe/pmu: Add GT C6 events
Message-ID: <Z4rfM91LoZs5LfM2@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-8-lucas.demarchi@intel.com>
 <Z4qk8qv1_VyV8W80@intel.com>
 <4k2afkamwpucxyap3hgklwpgh2p7an5ebdgyqixkyipye6o2ze@y6dext5dg5tb>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4k2afkamwpucxyap3hgklwpgh2p7an5ebdgyqixkyipye6o2ze@y6dext5dg5tb>
X-ClientProxiedBy: MW4PR04CA0260.namprd04.prod.outlook.com
 (2603:10b6:303:88::25) To SN7PR11MB8282.namprd11.prod.outlook.com
 (2603:10b6:806:269::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8282:EE_|SJ2PR11MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: d3cb7054-cf09-4b48-19d0-08dd3749a491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l46E6cSMY6WclXN3qNHcrLRlJkoNHmLqMmdN2e19fxfPeGCxxVcU8+Vpep1z?=
 =?us-ascii?Q?qfa/8ZyBWQBobQBEHw/ArXl0MbqgVqd4+KxnKG0qmtrK5ZsHHZqzRD9VRTNX?=
 =?us-ascii?Q?a4FXejALLlnDAwmsNKmWl3BeQS6tAuspH1+Da+NbaGz9OhRySRY8LZhrLKpt?=
 =?us-ascii?Q?ebVXAiYB+GV+ctggOfUjdwByLzeV6roOsE2T0kUXrHWeUjN9LdPo9WawgqTN?=
 =?us-ascii?Q?nYVQoMRQsR53avZzpIB8584AAfIaOhMceBi9JvRV2kosEadF+B9Tz1SPwIPQ?=
 =?us-ascii?Q?PlZ0BI6hUxUvwbk+hOItJmniPZgBl3bz1k/UVHCWOcycI6CHmqwkankEcPnU?=
 =?us-ascii?Q?mQ3sYkb1n21OwP0Nf1bJhuPsvntJGGRNX4CFRRoASMWgwKQ1Kzm88bCKD8Ht?=
 =?us-ascii?Q?LvYGOxPiBU0RuFbO1Bbre9e13TxMui2FsUUes4IzMZUT+SJoWFmPTImGMOP8?=
 =?us-ascii?Q?3r5bGpWhol4bcGC/sIFMrEH3fLbbBfeaag+Ehd6CKdpOayeU1D0gi2NAV0eW?=
 =?us-ascii?Q?Zy8zWpDd9W3EUBDorOTRAWudjpyerkrG0KcH1t4mIClHuY0sSnQtGd/QuWdI?=
 =?us-ascii?Q?CFjQkmW4k+HB0Esc9+tx4Tatqs1gR4UM0HJrMkeDe1XQYWN1oW52tg/BLXTG?=
 =?us-ascii?Q?7M3BVZWJ18BDl16og94lUG5w8253XQ/iZ+0loIwAXp3Yny71FlrZkyIdjbog?=
 =?us-ascii?Q?SZG8dzMTeaOXiX9UY30vCUcu3Wb1x39FLoQIJTIN/RE0cQpgnYdcEMyR+2rJ?=
 =?us-ascii?Q?i8snf8avGMLs1X+DIEYd50g3uJJaFAsXkO0meWlmgOXOW+/H4xApVNbI76uU?=
 =?us-ascii?Q?N97h5hV4xzTBkgizbu1Tcj+Pm7LVnMrekFJUFU3gfmCekup2Ve2DTOjXjxpz?=
 =?us-ascii?Q?7sfM4ihog0VfnPGc2bzKM0CODh9oliK04asm4k5xMWwD/BuBZupph1Fpx81L?=
 =?us-ascii?Q?vwqzdl78jRrWLjRnw3iFNMvcUT+gQOUC3mCtsvnW2A6ZyTo/owWu+o37w5P5?=
 =?us-ascii?Q?W4RB97zIgRsoMXV900vd8zREh+dhyqAAawp8707gwDpQKzcrAFaDnCKcIp2i?=
 =?us-ascii?Q?wlI2kISFmlVn0NfU/wUsWuUtGofIUGVbARYx1+jNfbJZoFVcLADt+zpcCjAj?=
 =?us-ascii?Q?dRUaAlJ6qz5lRGWYgF9qf0aL+Jb3ig1oy7rM1wO7pGzsY/vUFdpMLqldxixJ?=
 =?us-ascii?Q?JngtuF/GIDrH+RhxFu2zjQedjT4A7PNFZQrJe4U8gGG8wYjMLQiPPS4P/3rV?=
 =?us-ascii?Q?rzP50jLoUHZRSldpq4nIO+tIMNoSEVNtrHCPlTqwSTpHdPMJEaAGVcALbhPU?=
 =?us-ascii?Q?n7nmBNJ+nBE7zzIZQYdDz+l+bQgajo34VrSDFB2wczP2KcjhuK55UlJ0Zejr?=
 =?us-ascii?Q?rvr5rFA0qpgQeptLLJohZ1MZLO8B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8282.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F6PQ/dNMdzjphGhDerqAcga1dJ6vJJbJ7PoC2EYavaSg+v9qLtn6sC8ExJB8?=
 =?us-ascii?Q?5GESWhNDPNgjpm/XXWc8aHtAhkUY/V/ImvGOM3Fd7SiZSr+9vhK3Xn9qCzRl?=
 =?us-ascii?Q?VfhORik9wwIMg83QkPAxHuS0h73NaoVFUV4BIPJ8pZXuS19y0y07Sj6PdvTb?=
 =?us-ascii?Q?kd48Mdndro/XvfsLp4Q4taJRCxN/5W4HboKXpPk6UAw+EI6Ti47yC/SNNzgB?=
 =?us-ascii?Q?1gtON2ttVTy/wMC45gxOYDXYia9APYvjpRbPNVVGPrId2URIR1T8TAUbKufQ?=
 =?us-ascii?Q?d+hXFm4jOrn6Ie+u2jHxjflPJkzbzcAu1msYHDFPZE0v9EjNye8h56ngW6JS?=
 =?us-ascii?Q?3bvRvpH0HSBLLcioQJGTmbBG5VRQ2KxjMVd5c5R2W7i9L4zCycBPBMc7V08o?=
 =?us-ascii?Q?4jUN35gdgvH656w/jWOGqO2jdC9kfpx14+R2W/HjPcs0QQoL7KMTS3pETQu+?=
 =?us-ascii?Q?CyNKlgAEW/bXcwjjwBdrUGF+GpQX0jv//yyr5jYceZVObbB9xGBzhevUBKjB?=
 =?us-ascii?Q?3U5bNQvA1yMp6EE7yHJ1xGhpX/m+GD4nuHZ9VvhPVVLYxlAcJqriJQWRTc04?=
 =?us-ascii?Q?sfG20xz4XXyiFyFoXrCYsiww9m6tUTNf09FGmmNIkhX9zLj7IYOmuFTGjYRr?=
 =?us-ascii?Q?cECzLYkNFUlvkxbLXpEKke+huxLMiY5sgKtsW28P2GRbzasAo2+AoGUa9xT6?=
 =?us-ascii?Q?EkOyEYNxbBGjYjpjlTyPnO3TDuEfVZ/iM0eV3UUidJSHe1iH+q/LUH/rgacW?=
 =?us-ascii?Q?u1/vYl4CWxziNgQBmDZ8wuBZiZk9nuFenGppriQvh8vw0YVKqW3+6VekiP9l?=
 =?us-ascii?Q?a3ysgOL0IAjCZjfyBjXbkSlPLtb1HpMyN5O6i7lQBBbOANyRkzFZ6rRY0j8y?=
 =?us-ascii?Q?t65GLD8BW4yIZddZw57K+kHRVb/6gQ1legrIm/e6Wtisvd8pkfoHtZeVulWV?=
 =?us-ascii?Q?ZWVQgBj2+ovaiDzGRwPCxfwnkweN4q/QK55BFlKxioon1uAkUg/xNcM7da2F?=
 =?us-ascii?Q?96Cn83jKvmrOIYl5jATLqCEMUob1NvYtBRhMCyfMXlg01jCC2JGbakDwlzwh?=
 =?us-ascii?Q?naBddFqYYxx1WRGZik0cfxdrwxL9AsDxzDup2/5CmDpSjebeLe9RR25i12pX?=
 =?us-ascii?Q?lATBFIMBbwPg4ktiA+R0zEu834mE3MzyOtxVmURA+KB3o8dCUTfiAz3D0qsN?=
 =?us-ascii?Q?vi8NO2nSuDxD6d8598yrNxvBwsmrH+XAxsdvsSMPYuef+yL6sSSzmfBKIbtd?=
 =?us-ascii?Q?4wFn4Oo/JLVN4MCSRse8c6z4PbLEUlTFsdRASvrR+kUobQtq9W8sHjAP3evG?=
 =?us-ascii?Q?0Gl7uPmWb/s29d6NyhH/psVvMprTe5zvi5IJKR3GiBfJ9OKxfjvSc9m+j+4l?=
 =?us-ascii?Q?xMkQMNSELGivRTGmEsG4FHAkRcjE9kxQ2IWUshY4P0KD2Oq5yfoeglAv/EGM?=
 =?us-ascii?Q?v2u0ikkvk8MfiKQ4vFqKvuz6/hGJ6EAbtRUfIWzDLfWSCLK0vZm3ZRiLBsCS?=
 =?us-ascii?Q?F1DFxY8hz4OwuxOfL22XhITJOD9TEKRr5cLmGcjMiNoUrYrLmP2+aINjXfqI?=
 =?us-ascii?Q?X9lSe7Uig9wiF0T3kOB8vDCCMQTm6KF0U776LPxXCyXI1ljlgkv3bDe6/E68?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cb7054-cf09-4b48-19d0-08dd3749a491
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 22:52:39.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGoyeyW4IDtAsWlUNGMS0OtxmAzflh2HMtCsTZ+iHnLWR0J7dGblrUFyMXSLXy9BVYz9k+DD5CTx2mA8+dZQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com

On Fri, Jan 17, 2025 at 04:40:25PM -0600, Lucas De Marchi wrote:
> On Fri, Jan 17, 2025 at 01:44:02PM -0500, Rodrigo Vivi wrote:
> > On Thu, Jan 16, 2025 at 03:07:18PM -0800, Lucas De Marchi wrote:
> > > From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> > > 
> > > Provide a PMU interface for GT C6 residency counters. The implementation
> > > is ported over from the i915 PMU code. Residency is provided in units of
> > > ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
> > > 
> > > Sample usage and output:
> > > 
> > > 	$ perf list | grep gt-c6
> > > 	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
> > > 
> > > 	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
> > > 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
> > > 	event=0x01
> > > 
> > > 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
> > > 	ms
> > > 
> > > 	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
> > > 	#           time             counts unit events
> > > 	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> > > 	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> > > 
> > > Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > ---
> > > 
> > > Besides the rebase, that changed a lot how the event was added,
> > > here is a summary of other changes:
> > > 
> > > - Use xe_pm_runtime_get_if_active() when reading
> > >   xe_gt_idle_residency_msec() as there's not guarantee it will not be
> > >   suspended anymore by the time it reads the counter
> > > 
> > > - Drop sample[] from the pmu struct and only use the prev/counter from
> > >   the perf_event struct. This avoids mixing the counter reported to 2
> > >   separate clients.
> > > 
> > > - Drop time ktime helpers and just use what's provided by
> > >   include/linux/ktime.h
> > > 
> > >  drivers/gpu/drm/xe/xe_pmu.c | 56 +++++++++++++++++++++++++++++++------
> > >  1 file changed, 48 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> > > index c2af82ec3f793..37df9d3cc110c 100644
> > > --- a/drivers/gpu/drm/xe/xe_pmu.c
> > > +++ b/drivers/gpu/drm/xe/xe_pmu.c
> > > @@ -11,6 +11,7 @@
> > >  #include "xe_device.h"
> > >  #include "xe_force_wake.h"
> > >  #include "xe_gt_clock.h"
> > > +#include "xe_gt_idle.h"
> > >  #include "xe_gt_printk.h"
> > >  #include "xe_mmio.h"
> > >  #include "xe_macros.h"
> > > @@ -117,16 +118,50 @@ static int xe_pmu_event_init(struct perf_event *event)
> > >  	return 0;
> > >  }
> > > 
> > > -static u64 __xe_pmu_event_read(struct perf_event *event)
> > > +static u64 read_gt_c6_residency(struct xe_pmu *pmu, struct xe_gt *gt, u64 prev)
> > >  {
> > > -	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> > > +	struct xe_device *xe = gt_to_xe(gt);
> > > +	unsigned long flags;
> > > +	ktime_t t0;
> > > +	s64 delta;
> > > +
> > > +	if (xe_pm_runtime_get_if_active(xe)) {
> > > +		u64 val = xe_gt_idle_residency_msec(&gt->gtidle);
> > > +
> > > +		xe_pm_runtime_put(xe);
> > > +
> > > +		return val;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Estimate the idle residency by looking at the time the device was
> > > +	 * suspended: should be good enough as long as the sampling frequency is
> > > +	 * 2x or more than the suspend frequency.
> > > +	 */
> > > +	raw_spin_lock_irqsave(&pmu->lock, flags);
> > > +	t0 = pmu->suspend_timestamp[gt->info.id];
> > > +	raw_spin_unlock_irqrestore(&pmu->lock, flags);
> > 
> > I believe we should simply avoid the patch 4 and this block and use
> > xe_pm_runtime_get(xe) instead of the if_active variant.
> 
> downside is that gpu is going to be awaken because we are monitoring it.
> 
> > 
> > I'm afraid this won't be a good estimative since this mix 2 different wakes
> > of 2 different IP blocks... the runtime pm is for the entire device, while
> > in runtime active the GTs can be sleeping in GT-C6.
> 
> in runtime active we can read the counter without making the debug tool
> (perf) disrupt the device state. Idea here is that when it's on runtime
> pm suspended it also counts as gt-c6 since it's stronger than that.
> device suspended implies gt-6, so we count that since suspended.

hmm okay, that superseeds indeed. but then it would be good if patch 4
saves per device and not per gt, and we make this clear with a comment
there to avoid confusions...

> 
> > 
> > or did we get some deadlock risk on that scenario?
> 
> I don't think there's a deadlock... there's just the undesired behavior
> of "when perf is running, the device is never suspended" - and since we
> have plans to integrate perf with tools like gputop/qmassa/etc, it means
> it will never suspend "when users are looking at it".
> 
> It's definitely simpler, if acceptable: "when looking at gt-c6, the
> device will never suspend". We can also start with the simpler one and
> split the more complex scenario with a patch on top, too.

my baseline assumption was that if you are looking at perf is because you are
doing something with it, so it is not suspended in general...

But well, there's also the power consumption aspect in general that
would be higher when looking to the device and that wouldn't be good
indeed in the tools charts...

so, okay, let's try to save power and get some good charts ;)

> 
> > perhaps we should get runtime pm in upper layers when using PMU?
> 
> we'd need to do it when enabling/disabling the event. It should be
> possible, yes. We can't do it on the read call though since we'd need to
> make that synchronously.
> 
> Lucas De Marchi
> 
> > 
> > > +
> > > +	delta = ktime_ms_delta(ktime_get(), t0);
> > > +
> > > +	return prev + delta;
> > > +}
> > > +
> > > +static u64 __xe_pmu_event_read(struct perf_event *event, u64 prev)
> > > +{
> > > +	struct xe_pmu *pmu = container_of(event->pmu, typeof(*pmu), base);
> > > +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> > >  	struct xe_gt *gt = event_to_gt(event);
> > > -	u64 val = 0;
> > > 
> > >  	if (!gt)
> > > -		return 0;
> > > +		return prev;
> > > +
> > > +	switch (config_to_event_id(event->attr.config)) {
> > > +	case XE_PMU_EVENT_GT_C6_RESIDENCY:
> > > +		return read_gt_c6_residency(pmu, gt, prev);
> > > +	}
> > > 
> > > -	return val;
> > > +	return prev;
> > >  }
> > > 
> > >  static void xe_pmu_event_update(struct perf_event *event)
> > > @@ -136,10 +171,11 @@ static void xe_pmu_event_update(struct perf_event *event)
> > > 
> > >  	prev = local64_read(&hwc->prev_count);
> > >  	do {
> > > -		new = __xe_pmu_event_read(event);
> > > +		new = __xe_pmu_event_read(event, prev);
> > >  	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
> > > 
> > > -	local64_add(new - prev, &event->count);
> > > +	if (new > prev)
> > > +		local64_add(new - prev, &event->count);
> > >  }
> > > 
> > >  static void xe_pmu_event_read(struct perf_event *event)
> > > @@ -162,7 +198,7 @@ static void xe_pmu_enable(struct perf_event *event)
> > >  	 * for all listeners. Even when the event was already enabled and has
> > >  	 * an existing non-zero value.
> > >  	 */
> > > -	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
> > > +	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event, 0));
> > >  }
> > > 
> > >  static void xe_pmu_event_start(struct perf_event *event, int flags)
> > > @@ -267,6 +303,10 @@ static const struct attribute_group pmu_events_attr_group = {
> > > 
> > >  static void set_supported_events(struct xe_pmu *pmu)
> > >  {
> > > +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> > > +
> > > +	if (!xe->info.skip_guc_pc)
> > > +		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
> > >  }
> > > 
> > >  /**
> > > --
> > > 2.48.0
> > > 
