Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0A4A2E27;
	Thu,  2 Jul 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998752; cv=fail; b=ciGfYnGxXxWervAH7CVAwETx/7PwgjH7mgLwNA95lo+kwM6JFq7W8Byp/CEe1s6hNUh+T+10LucLz9zyGBgparV3vFiRkgzcBX0qvW91OdaogqVSGDAzatN2cRStpnCsgD9AJaFrrGLYOf11ue1yrdYrzsle1tf84LZQAz/GgCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998752; c=relaxed/simple;
	bh=wIy1JkviQ18VK6kBApZFI/kj2hbmF7ZPtK5C9MH0K8Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ldGXaCglFjN9mCkcGH+9wblCoWXCFNiJufOmTLt9RJqqHdVWaMYFp4OzLFD/f0BAwnDvEYxF6BSL6j0y8y/HL70lrJE8o+YrEUGLO4qd/tr2MP0gz9X/GVjNo396U7tMPupba9jELSSV6XxSy6QsV64pn1Livnf4XXZ/vKEeg4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+UnS1hs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+UnS1hs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782998750; x=1814534750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wIy1JkviQ18VK6kBApZFI/kj2hbmF7ZPtK5C9MH0K8Y=;
  b=m+UnS1hs/LkqPZ/LkLpZIoVweuiuWgdlbcEYJZLtbAREEc94qaaiVcGu
   96NrMGMDhYFLgchLK+i2vlHoHj59yjEYtJjPSXwWJIRolDinLSL8FnP+G
   lMFb0VT2+Wgsnxy3qz10XQwSWMUVywY3mSo2b/z6vwSYS817nL0KjpSim
   /s4JrN5X0T6GBUaAappw39K0zv9ErzVsh9q3dBEhMz1pQxjft+iNgVv44
   bvi8zabVp441ULokvJh+pOxZObMkllf5VQ7BVZneC4sn0FVVOZv7JvakJ
   rUt1eEs8dCA5s6vBcCZ5Mdu1WnLUtbSk9pKr770fqXMbyezQU/5IQAgzX
   w==;
X-CSE-ConnectionGUID: +9n2IvgnQDy6qwxziNZ5fw==
X-CSE-MsgGUID: TtjOOqd1RxuG9TE1yXflAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83784183"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="83784183"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 06:25:49 -0700
X-CSE-ConnectionGUID: lKQ2lkLiRGmjAo+cJl+CBg==
X-CSE-MsgGUID: ofetJKnTSY6BnW5gW4VMYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253524852"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 06:25:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 06:25:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 2 Jul 2026 06:25:49 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.17) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 2 Jul 2026 06:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRZlA5jL+Th1JA5SK6HG86mtT59+ec7cI/SwKkElQ2T7U62f//hKyzZ1NZbx6VkMi0iR1j4zM/VfONgrrCL/OmpkfcGyXH7gSUSSOQeFwhxCBK/UIn6cQmRnVfLNCLnfb9cI+FgwrXVwNcnXKcC4kGqTGI/SBAPd2GVlGj6BNUYOBt1rl60Mb5Ry607WsaN2/m1voOSRs7PnoQhhfhVL/nGdKNJW3JCn4hU6ezgrSCTzRjgLeKFuNHf47Pd7wsO7fSB+aw7M1mhsG5O2pdnGWV3ErjjUOqHRSt4tsl8xfRHFROcU5bfvyMisvhZL8GHQe+shIg/v9Fd1zo+ydaeMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W0grW1V4pIcbPIbshziSql8g2W7pbcJC4iE9o2TGO0=;
 b=nTLAD5zyrhcmz/Z5FrmeZMxIiiY1tKLIwOsJljrhihrkNcC9ymIlL59VQDo3g7yoLkuG6h5ievfHL8HIkNSok0ifAY+guB+6gwSJoDFOmIMqFw37qF4V4tBFgfeeI84zEBMaepTUq+gNJ7zt/UbWkDifVMr8VkqyNnfXV6jeBZ8PQTbvbNXLPwKLHW0fpxdNSD75UBzNQR6ZvXY1XT124voavnB7+QN1crlejCFPt9nyP0AhHndthXPGZ2rAm5qlu/GfWSipW1B4ds0ugiGyCyEuudv/SxtkgNcMxx7cpvBwpsHM2TexXY/fG0z2NywbSRPvvkM2t/SlmEt3NEeYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by MW4PR11MB6692.namprd11.prod.outlook.com (2603:10b6:303:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 13:25:44 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 13:25:43 +0000
Date: Thu, 2 Jul 2026 09:25:36 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
CC: John Hubbard <jhubbard@nvidia.com>, Matthew Brost
	<matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-perf-users@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] perf/core: out-of-line and export
 perf_allow_cpu/tracepoint()
Message-ID: <akZm0HrMzwarUX1E@intel.com>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
 <20260523013326.129491-2-jhubbard@nvidia.com>
 <87fr3dv83t.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87fr3dv83t.wl-ashutosh.dixit@intel.com>
X-ClientProxiedBy: BY1P220CA0040.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::16) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|MW4PR11MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: 5653f793-bdca-47d6-624c-08ded83d6ad8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|4143699003|5023799004|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: VqS8TluSEx1m+PW4GGJ6/ta5tT7TWP36B+Qs1IwKNqG3Why5WObLl2b3jREbUgk+6bbfshZP4mMXITvgTb1ROmP+MQjXNjgj3p5QcMDjcnfyI1EPAUBRNwe+0Pbtwg5F5rCo2eb1lanNgZC19fW7hN+7TRP4ES4RamR/gYQHLujiXksk1zKB0L2FC9CduG5oHxHPFDaqdZdOMtQ6C6CQGAQIUP0a6I2yOwVaF3h0u8HcPa99gfmL5o65wUBncZCeaDDhLUh+ngvqu7JKIowP3zuuM2Z4rpMqn+3kNHvcQM+EBp3kbBSoeqnYhqHzOl4VkKMjjP0amBjhf2QLD8SUJNWx9PlTgz0pcwyqxQKqlr+5kWdNE+mp7Q8xz5yvQYY6sO/xpUsplCfobDl92oXYtbVDH4sPLCrCh+1g04A1Q4l4w7wfg5PdqQ70rLgdntTEfFeyW/ZgJfB9kslXz8dFPKTcGKYhJlWWZiaG2TIWjlSUK1qeIr60uBWAXv0nViLmGO3W8K9erkUcnRJesB+ys7St+Hk8ZOtiLv+PlH4fpXE/S/j6ChJSi5LSK6hrHxffxexAB6JUd599On6mngNxtm21gMUzH819HyNk6PnS/vNw0OaHh7VdgXV3hlzCInoDl8cj/IEVGsRDqO+tHoM+XjHL9MRnv63XZ5ie7co7N94=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ttMXkpNzRSqOkUOFy32Z0cJ0wX4oH9az67mz9897gJPMp5BCsUZY21hFsQIg?=
 =?us-ascii?Q?S4HMOtXV0/OCSa8eRsGB8tVurBFB0u3fbyUCIaQVb94/7UsTCt2jGNXZ120J?=
 =?us-ascii?Q?Ar9WtiaqvEeoOzDajYKbe373pVENXp8hWiv8j7FBEQke4EiCohHRsNIm12iP?=
 =?us-ascii?Q?iHSUPCp6CNAH2crhl6WhdXKg1KpTgObuZo9fna6Xo2q5z0PUZGcrmYqqZQh2?=
 =?us-ascii?Q?IXWJXMtwHhWz5aAEmCrenB4ONILf/qY4OGdVQZC9w3dAIK28c0yB282/LPZt?=
 =?us-ascii?Q?DLN9Goj5BrVFcisW0T/XLvHKw1penVOqmgMSwJoMRp3ZwZ2F+CRHbnerYvhI?=
 =?us-ascii?Q?3m2l1SgflIKV3NkC19i7mKQ6JkhE3HkGKY7PU6eBtKrzYb+ImS4MYZeYLQiX?=
 =?us-ascii?Q?akBcxNQ/jPhd9xBXbQJPbqI/v26QR9t0EOfrC/HGz+JvVtJZ06QaemK4ruL4?=
 =?us-ascii?Q?uQxUerH4+bUg/fMGAgX+DrnozpnPbL1XAmNhaswjjc8soAMd41NH6HZGYI41?=
 =?us-ascii?Q?k8pTqkUn0bL1prIYiW74zCVbyh5lmu8hqHMjaBYHrEAYh7iz/fHK3/EfOCyp?=
 =?us-ascii?Q?gdNly/Q+z4ol9Bbl/6H25fH5/xDdfvwCzvp4nEZpVwNISXMnSkJAhBacwQhv?=
 =?us-ascii?Q?0XRT1BYN8XPledrfOFf6H4MEj/znXpmhSQ4CxL0YyxHAdW5m6GX2Fg+f8WcY?=
 =?us-ascii?Q?3lPDbfrafiTdpmxufQw3NbPYeQ1K64xAxUHpG0O5cddR28LzATG5zwx/d2ke?=
 =?us-ascii?Q?PQoRC1p3aOoeWupY4gy/FydOIrPrp1ppsiXLeh6MQCIssa3iWf7h4UxBwCOg?=
 =?us-ascii?Q?arEPb4E0HeY2JKgD3J322PY5B32b668h/OBg8JY35KuUe4MBUAEE19RQFO1b?=
 =?us-ascii?Q?YLy/p0hrBOZLNBjjraaqgZHxshvi7VtgMIHrq34Ow8JkLtbnGNYORk54tdei?=
 =?us-ascii?Q?uELN+T331KDNvhpjk7DvfOIMDxT50h2c+reSFl2MIV6OkhsRNtgBz+Wp3BIg?=
 =?us-ascii?Q?YV87/1Fd0yBPqLdedB1/ZCk1sVjMQ0RWwCXL1gCovp2dmmIRxsjJ8mWAljES?=
 =?us-ascii?Q?NGY9XJqMxz6bhlX56awZVQf7c+Q5BHrj5SCcZBbX7ok+wz37xA/03+lT3q2S?=
 =?us-ascii?Q?HozED6HCpRv7BKcW+hP+3Q+C1+bz8crOR3PxaD4WbA1kgRXLVLEdHVqH6doc?=
 =?us-ascii?Q?t/o6bz6yubbrpqW6q0CVS6wszE8zseUwvesVVpvFP+B4pfmMdEOPhXmpeG80?=
 =?us-ascii?Q?5t5FAlcxREQRp++9yZGx/nleyhwwHSnQTv9Yl7iWGXvLwzB2gqO97TPI1ATP?=
 =?us-ascii?Q?Lv2CKEL9RrPqtsyQvElDd+r9fC2B5JzMEZxLiajHCmclAejB4EVKExihieKg?=
 =?us-ascii?Q?tUfKbL/DPMVY1F2kaz78jHuKekST6NvOEaSZH370CLXhKfet7pbhd1w1qYc1?=
 =?us-ascii?Q?QFPGtHlt0uBxF5a09q3e8zeXsEL2OoAX+jIalYDjrpe5XUrRts/gvyax8zK0?=
 =?us-ascii?Q?tP25CwqQzBTovpDTjw7stLqRyzACuKcjlSqAc4LD3yOFxCpH8PGd2jDIbjgt?=
 =?us-ascii?Q?TLWWTjfJqAggAVDXXTtabeDNTZEdsM0+kcfGv/WEg7MISvw6x3Hm31e4kbGt?=
 =?us-ascii?Q?Wnt+5BFfcC/DmhYrGhHmR8AobSqJ8LRXmFz8n3zv4042dM0EeDr+Y/5ECZgj?=
 =?us-ascii?Q?jJehyVpg3HXSrixcjRL/UHkEBT53oPv5myH2ELULjqMsY9FGPQEGRwk9NxU1?=
 =?us-ascii?Q?9eYPPE4okw=3D=3D?=
X-Exchange-RoutingPolicyChecked: K+krLiMDTIDpSGCXlYshu5UKwWiGk2+XSSwEuSC10Ws7xB709bmx7SYvZsEmHIhYj2dbtVxi8IIQoMnkl+oRpjKwE1WU8sPc/aSon3QswC4653bALP5tPZw3smoV3KAxQQA4D1o6WzUX0fqg0SwkI+Kc2dbKD5q2W67ElII44boaIaoKcTIwXHrjKZbn61Hskds93+kynMrzCK+R7h3xPE6ONFZROoOGGHK76uedTSdcqiuhMXa6v0cgFgUGIrw2r3AwYylbNCLpcWzropLjjDgUNkPDP6e+4uw//6ZvSVFAqA4t7qBUtoMb0TOKn3uZyyMBOPv6xOY407mESKXjFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5653f793-bdca-47d6-624c-08ded83d6ad8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 13:25:43.6113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAmkbzii0GZqjCipM1hsaqJwyRQVA7Q/EaZLRhIZNzTrKXNW/CiCmb4kSjiyuCDUiVajq1mR7ia+bB6bn+lT+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6692
X-OriginatorOrg: intel.com

On Tue, May 26, 2026 at 08:34:14PM -0700, Dixit, Ashutosh wrote:
> On Fri, 22 May 2026 18:33:25 -0700, John Hubbard wrote:
> >
> > These helpers are static inline in <linux/perf_event.h> and reach
> > into sysctl_perf_event_paranoid and security_perf_event_open(),
> > neither of which is itself exported. The perf_allow_* trio is
> > therefore asymmetric: built-in callers can use any of the three, but
> > modular code can only call perf_allow_kernel().
> >
> > Move both bodies into kernel/events/core.c next to perf_allow_kernel()
> > and export them with EXPORT_SYMBOL_GPL, following the shape of
> > commit 5e9629d0ae97 ("drivers/perf: arm_spe: Use perf_allow_kernel()
> > for permissions"). Existing in-tree callers live in built-in arch and
> > tracing code, so the change is invisible to them.
> >
> > Provide !CONFIG_PERF_EVENTS stubs that fall back to perfmon_capable(),
> > so the helpers stay callable when perf is compiled out.
> >
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> 
> > ---
> >  include/linux/perf_event.h | 31 +++++++++++++++----------------
> >  kernel/events/core.c       | 18 ++++++++++++++++++

Peter, Ingo or any other perf maintainer, ack on this patch and on
propagating this through drm trees?

Thanks,
Rodrigo.

> >  2 files changed, 33 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 48d851fbd8ea..5842552294c1 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1791,22 +1791,8 @@ static inline int perf_is_paranoid(void)
> >  }
> >
> >  extern int perf_allow_kernel(void);
> > -
> > -static inline int perf_allow_cpu(void)
> > -{
> > -	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
> > -		return -EACCES;
> > -
> > -	return security_perf_event_open(PERF_SECURITY_CPU);
> > -}
> > -
> > -static inline int perf_allow_tracepoint(void)
> > -{
> > -	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
> > -		return -EPERM;
> > -
> > -	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
> > -}
> > +extern int perf_allow_cpu(void);
> > +extern int perf_allow_tracepoint(void);
> >
> >  extern int perf_exclude_event(struct perf_event *event, struct pt_regs *regs);
> >
> > @@ -2023,6 +2009,19 @@ perf_event_pause(struct perf_event *event, bool reset)			{ return 0; }
> >  static inline int
> >  perf_exclude_event(struct perf_event *event, struct pt_regs *regs)	{ return 0; }
> >
> > +static inline int perf_allow_kernel(void)
> > +{
> > +	return perfmon_capable() ? 0 : -EACCES;
> > +}
> > +static inline int perf_allow_cpu(void)
> > +{
> > +	return perfmon_capable() ? 0 : -EACCES;
> > +}
> > +static inline int perf_allow_tracepoint(void)
> > +{
> > +	return perfmon_capable() ? 0 : -EPERM;
> > +}
> > +
> >  #endif /* !CONFIG_PERF_EVENTS */
> >
> >  #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 7935d5663944..cb13f3ad11a3 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -14731,6 +14731,24 @@ int perf_allow_kernel(void)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_allow_kernel);
> >
> > +int perf_allow_cpu(void)
> > +{
> > +	if (sysctl_perf_event_paranoid > 0 && !perfmon_capable())
> > +		return -EACCES;
> > +
> > +	return security_perf_event_open(PERF_SECURITY_CPU);
> > +}
> > +EXPORT_SYMBOL_GPL(perf_allow_cpu);
> > +
> > +int perf_allow_tracepoint(void)
> > +{
> > +	if (sysctl_perf_event_paranoid > -1 && !perfmon_capable())
> > +		return -EPERM;
> > +
> > +	return security_perf_event_open(PERF_SECURITY_TRACEPOINT);
> > +}
> > +EXPORT_SYMBOL_GPL(perf_allow_tracepoint);
> > +
> >  /*
> >   * Inherit an event from parent task to child task.
> >   *
> > --
> > 2.54.0
> >
