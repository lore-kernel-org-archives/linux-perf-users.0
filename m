Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723F919007D;
	Tue, 11 Mar 2025 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663272; cv=fail; b=BP1kyHkhxqyzFzF4JbRh/RNClQ8mGn0/2x2o8nmhcBmE8ibh6xD04DrVb3m4XozKXnQI46rbUD3CSeiEKAJutP9jvcP3gWpHFRWUC/1cdjl79lxDUY3GGV3/G2fcnYJHEg57ro+z79XoBwyO7qZ+n0K2WU8oEfL60J/+DgOtDYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663272; c=relaxed/simple;
	bh=IkBMeBYZZY3Lcp7FSkdxACCazQcplmZYRcHayTshDGw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BYpM52HMNErFfZMRWtdu9C6Y8Kaz8PyWkoTTaQ00kTLXU29nGiIdSp/YGz+2mzKJlGbbDh3czNGyJ4udBPlA80P80PMCNcWd6/FC0PCOTvQc0+V3v/3xZ+hfVbtKzLbpVLVqMJCpXz9Xe9Qol21+YiO9Za6U/eXBCPzfVRNCokA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXwbAS85; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXwbAS85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741663270; x=1773199270;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IkBMeBYZZY3Lcp7FSkdxACCazQcplmZYRcHayTshDGw=;
  b=GXwbAS85IM9Vrji+RspZqney2muXs0sOTudDDG+YyHjPNdyACKl/OPyI
   8UziRSK0TnG64CLXEIxa8ZSeE31gRPQ8HdK+ogqQBkbAJjZY0aXrpxUzn
   12IuEjzZNxVOcRpg4Eh3Rq2AzeMU4RAAXQHFZf7/0kc738a5R7L4gb/s/
   5B6avv5T7P/9ZIiTbzTfCUIGoECP5Q0H4JwefqophtuI/ROX/daT6/G+x
   XJq5DP4XpTqucfiiqGWd7/TcBRbJL5peRH01ZQGCocG1nfjZgOqaj8Aih
   kVSj8GiRhPwGXpRlg8pV32MfZghptw2861TE4S08Aj6EGWQbGofZ9UTnY
   A==;
X-CSE-ConnectionGUID: crbFpGO1RCyUhxlcPVsFdA==
X-CSE-MsgGUID: 79wQl1peT2aZuUZsmFnorg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="65140915"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="65140915"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 20:21:09 -0700
X-CSE-ConnectionGUID: ltWaPFwHT8+RH2hINuj7lQ==
X-CSE-MsgGUID: hSHvdiyOSZG8J8D7sDPXbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="120661982"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 20:21:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 20:21:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 20:21:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 20:21:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5KS52Cy8WHTm6QJzFTWnqaBHJAtpsZR3CZgMOIzBXJqKnSMlTkayyXRELfI7g81lnPxuD6FET41hU1RSotIbHihcb4tPEye5X0XR1+D8R2Bys4UfeAhUngeXqp03LJZp7ACFkKG8Juo0bU7e03x8MDkknF5sp/f2FK68Ia6pc4aHOoAb5XDhTCP29J2cfZ1KNTkE75/uJvSV+nlPdtnPjARI+Up7+DgqjeeFLvGBA+L5YfA/jc4aniOht8/HxMCmOQB09tOrOO01AE9uI1bwtWQ74DKjRs2/C3i5QsIukYQHpqvwF/Qqo0+pONZXS02OlN7zpQ4jMb5/Ijt60pzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJFcfQYxSTCm2ESwO4X/RPBNEx0VoSNyjXH1KUs5gmY=;
 b=Po7mV8/wKkxkCmm3OxPaTitosbD1BDwOHQE6wWr5wiMFaSkYbXimbvQMD5Gor52t+msoSqQny0tZ9gfxEKgY14Wr7fHzpQIolMvwslVif91MXxuHCmKqhybmJvkdb7ObA4h7mvET4sXa0mPb44O0APtw2cwi2NihCsIIKr8m9Xbm42xsf+l9P7xVgwjEL/HIclny+NEc0N0E9F6MZeauaKL6yp2n9w3jfJ6JGoeAUbzHBgygXpXAYH4ikbjALjHWihAQQOlB5B//w7cZn0eCSDIAaiBoFuoRMToNen2YfwVA1sTFsFiCkO5SvQ1cjH28VrqqiRrAJN6BYXQSIcc8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by MN2PR11MB4535.namprd11.prod.outlook.com (2603:10b6:208:24e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:21:06 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:21:06 +0000
Date: Tue, 11 Mar 2025 11:20:54 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, "Andi
 Kleen" <ak@linux.intel.com>, Martin Liska <martin.liska@hey.com>, Leo Yan
	<leo.yan@arm.com>
Subject: Re: [PATCH] perf script: Update brstack syntax documentation
Message-ID: <Z8+sFgbp0pO1Lt/m@yujie-X299>
References: <20250225061736.1698175-1-yujie.liu@intel.com>
 <Z8q51Mcz/9QenjnC@yujie-X299>
 <Z89WFKPIxWBgN6q2@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z89WFKPIxWBgN6q2@google.com>
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|MN2PR11MB4535:EE_
X-MS-Office365-Filtering-Correlation-Id: cf874805-198a-4faf-f2e8-08dd604bc2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ai2AEP7DOv+j6n+OMaikPj4pbsIJgX1+3AEumbLwoeISPmrXRFtwdg6AZ6Q5?=
 =?us-ascii?Q?geDlI0imRtrBIsrEsmLwFNPA+QLhGnY09VJJ1mQ3pKER9Mjk2DnxRGOI6I2D?=
 =?us-ascii?Q?WskamvcELjEhLNTS2YptMlLpaN5l2fnCQORDOlTvXbyqhGRkIS6Cc3hFEHtd?=
 =?us-ascii?Q?FkPV/kz+4yA0PUXbePkZeH6xvCi8SZF/tj+S8PabGMtYawASKxRUYnkgiZeD?=
 =?us-ascii?Q?76FDbYoA4/n0172taEoKEOkmrn65Me/21J1I4SbaAJj5UYOoSpje8727kQhN?=
 =?us-ascii?Q?KdU/KtTdlXxnmlvB0Lkl51smJUayUDc0pnRNlXhUtSYKicyIJmt/DNr1Nfp5?=
 =?us-ascii?Q?P2vLKsP0KDivgGIh7e8Lp4lRLpdljIRsmX9FbIyUFxCj+r6AeHqb+z77p2cU?=
 =?us-ascii?Q?Et2jvbLljGAdltNNA3A2oRSzMlG2xpul+Usdgeq1Teab/v1ytojRBT6iHoJm?=
 =?us-ascii?Q?LOsDyjBK/NpgG+gFy7wBDakgWkJVjqFnvx6RQxvJwUyVzBcYjSIlyiIfX4kY?=
 =?us-ascii?Q?Fszo8FfqIh5BU3CMEnfYgpoR6hrcgFMKtcvYG7wEETqKb2i0R9xD7AFXIMeb?=
 =?us-ascii?Q?Nje3JwADpVs9M9Cq9g1PS3vBZLbGDxFjTb/fBmkW9qHY3OrjEC31Nv44Aw0P?=
 =?us-ascii?Q?bNCNT+RLcV8Pxuzwhja880rtHy2PHwc6aZFYBg+Upi4ZSNh13q7kSxRC0HL1?=
 =?us-ascii?Q?oYdisSGo+nYPkH5ak0S5xIuRRPbBEh3xbE0n9kZ6ahkZwuVYwozLtnHEw1Iz?=
 =?us-ascii?Q?B2CRoS/oj5NlyMYFiZUpbDNhWjmhlWq05sxuJmP9Lu4a3kixDA/Hjs4V1wvg?=
 =?us-ascii?Q?13aDQ3wp1Os+166xYGsAF6dUi5wuf5BbhD0TxiiQZe7ACKEOZmDpBAa5oK+A?=
 =?us-ascii?Q?OWZoHzzO7FWfOvI74I6Sw6GD7A9w05ynC2xUFhWlXC95wFkXb1yIw1wGfyt8?=
 =?us-ascii?Q?WXauHkmUMiVxPoLj226tA6DKTXzTZfkzfLhtCwBAjGWJeWyyAlCwShjxNII0?=
 =?us-ascii?Q?CBLGS0pJWW0VkOxzeqgwsCVuuxJUd6SewyF14fbHTwcg2+E1PrFUDIoqs9Lj?=
 =?us-ascii?Q?K5/SP4QxCSKmzHkeODEaX+3SccsJOQDOPN2F6Rq9XscembDYhL5y+Dz/Tc/b?=
 =?us-ascii?Q?kJHt/Hj1fy1G71rlEc8Crr9TkJQVnL1OoKYVEk711rv3TwUAOsRH+vlRncjo?=
 =?us-ascii?Q?LwQkQaW1pEFwt54S0uN40d6Te7hxednyGZsDYEgty+NCXeR3kf7odgBGrzY7?=
 =?us-ascii?Q?MFH1XQ1CRD8BiTotjaeEKUkZg1flrX6mD9C5TiuUHLj6QYJ3XyC9LGvBPVX1?=
 =?us-ascii?Q?hLQI0yGgCX0iNTBcQIm/wMi1mcpZolESywB8NmoPkhAWf+MOZs/9D3hz4y9E?=
 =?us-ascii?Q?wLjXXnsI0b2EhYz+/Hiir38gPBte?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CJyvYMB1GcOuugrtI+VVkIy1qZefeow3voicZmUUjmyTevMOfg3RHVQ6AmX9?=
 =?us-ascii?Q?5S69P+d08r5iYrHVtjm0FPqUY6ctQv6RnM3ld5PuFlAPhngbTdNje9NP/FsY?=
 =?us-ascii?Q?NzvRqs/Pximk8vilQWgTZZLJxLW8QAeIds/pGS7jGkXVF5wbg7fTArBvb47I?=
 =?us-ascii?Q?NpPBEmCaz6lqz/NoUnr0m01Hkl5xOz1Kgsatqwa5XYH9x6xjsl/PWRxFI64X?=
 =?us-ascii?Q?yZFxl3Y/eUH1uWCL4w17iiKnjaRBERNIYYmNBKbaJQ5kAk46GkJWKJExmnH8?=
 =?us-ascii?Q?3Qd+qwkvEanENMAdeXMInzfFWxh1PBY/sLiYvOT9gu0JKoIAit3wiSr7X/2V?=
 =?us-ascii?Q?VIO86vkEP1vJiFfkELyCnlTfV8rCAGLemlq9QFDIP6wvzznmb+04/KNnl1+3?=
 =?us-ascii?Q?WW9IPdpyKd+lR1La0JKPrPsbtaHsi2ZMIkCha9QhhFaKMZ94rIY0LBPQYCiO?=
 =?us-ascii?Q?IviOTOU9VwvncITYczZKdqjcjcmtW6Zqp75VuPfqTKMfoDt10UZcWZEoZ01N?=
 =?us-ascii?Q?R88ANc3zltBvLdiecuG1slgbQCUo4E/O+JzaMPufvlGOLtY1kxVwfZaxBfC0?=
 =?us-ascii?Q?ubNJWzPIRudBZfPG8UKogoRVXilbgup16scw4XkrhZMQ/xx71yPumgeIhIV9?=
 =?us-ascii?Q?LmVSmbqHtOJGk4hzEq83+EcuCMH1QEBjIqnlI6b2bw/9gMoE3uWjcsjJSImK?=
 =?us-ascii?Q?LcBm/ERR6SoCADGXVZGyqDaFJ+ia89eEPzrQ5v/OBMFKw9S+rXGW0K/SUCFf?=
 =?us-ascii?Q?C3uMULwxW5HsNyqUMJKTTjshMIJWl9csvj8euj4Fr+lleiGq31+ezj9bJ9Zl?=
 =?us-ascii?Q?pxO3JsbCpWjC00XCTsx+P067FdgVQpV6eSFzo8+6YMgRiWNo5bGsRMhrrZJk?=
 =?us-ascii?Q?SsoWXyfhWENAZawza8moOeGXBg7oTllBpCFH7B5schIaN1znXTbAGSaW373E?=
 =?us-ascii?Q?7/3oTVgZl8A6aIO29dHEEPe858QG6ROZ2hWgR+vEdSKXuj7FBikuzfKagIil?=
 =?us-ascii?Q?7yX+rnWBLryOx33TC6LeU9LZpTP56N1BMvyHLx3CjzKCTm7NzKUcHF9uphMy?=
 =?us-ascii?Q?jNjp7n1MY8q8OizcoV7YJOu99IiAVPfrUuOWx/gxzmgM7oWj4g5GpTHrOkTy?=
 =?us-ascii?Q?hYH2hQln6ZjA9L8u403KXVWmqpQWx0CIOiqDefh7Nsh7gxwkn/3HV67xXViU?=
 =?us-ascii?Q?Lz2YilGigniF9fROSuIfoXiSnhMX/kxscqdo4LfHQwE9fKJRIcLvGDOT0Z9D?=
 =?us-ascii?Q?RCwvLav9P7cEnqNViVwJ4ITeHgfmBjZhHDDPYrmGgINM/QOUxHBgcjUikzgb?=
 =?us-ascii?Q?t2zN9CRRgBO7RMjUb2RIACy6CNcPN0m4xBvCmDM/yNjz5cqnfPZDW2SBKsVU?=
 =?us-ascii?Q?9Sh9nlcAokmIgjgZiD9mJwFt4OR6GemxvxX4w1ya4bbi3RIOAmrVmL3c76hs?=
 =?us-ascii?Q?UzMKF+HaVPlPswnxEfkIQ648jfzdcC9e5kPOW4i+/Zr39kpnHotiIOaa2EdK?=
 =?us-ascii?Q?DXKawCUI6ZSr06oDJNo5u/gP/9nVfi9zUsiR/rGfU/PfmIWEeTATyB8pSlxm?=
 =?us-ascii?Q?ZKRO/Zs/7Dlv6QjIVK8VvTt6FsVwfUHY7mQCjNVQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf874805-198a-4faf-f2e8-08dd604bc2c0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 03:21:06.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AL3F0gugnj7Zd0TOQYW6WfAzHGUgHAgfu7+Yipb8P74wSCLiwyT2hbJdgbk7hj5JHjuV0OC5Ufdvc1iFnvZ9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4535
X-OriginatorOrg: intel.com

On Mon, Mar 10, 2025 at 02:13:56PM -0700, Namhyung Kim wrote:
> > On Tue, Feb 25, 2025 at 02:17:36PM +0800, Yujie Liu wrote:
> > > The following commits appended new fields to the end of the branch info
> > > list, such as branch type and branch speculation info.
> > > 
> > > commit 1f48989cdc7d ("perf script: Output branch sample type")
> > > commit 6ade6c646035 ("perf script: Show branch speculation info")
> > > 
> > > Update brstack syntax documentation to be consistent with the latest
> > > branch info list. Improve the descriptions to help users interpret the
> > > fields accurately.
> 
> Thanks for your work, but can you please update it again with recent
> changes from Leo?
> 
> https://lore.kernel.org/linux-perf-users/20250304111240.3378214-1-leo.yan@arm.com/

Sure. I will respin this patch to align with Leo's recent changes.

Best Regards,
Yujie
