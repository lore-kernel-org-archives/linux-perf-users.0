Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DD3D0BE5;
	Wed, 27 May 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896581; cv=fail; b=dZHxtnuJ0QBKlTxYldXEpcjHEtlBbkovYwcclS5V+9KiFcjHXiK411/YW4k6nbetQeo1lIO1nFK/6Lb3NkZx15nmaOYzvfThuQiPzOmdw/jCAkEswZJFGZyqIIQBbhGIHEiYjDZ0K5WFp+YO1lzUjzvnQZWM0m8S9w42z/vGnYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896581; c=relaxed/simple;
	bh=IjtkvWA6XN+m0V8MYZ+jFTK0JbSEmwg3gyrQuqAGw7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTfsjn8TlJuiV78DATVje13ZPNd9qcndNNPcQQKm/Gs4oGEyaIsQ05XUsW1tUr8b06fra2ONOTvXABXmQgNZIcGhXNdw8uyyajun2sc1U+pAsl8VApWPpZbFIIEJqe124Aytol7Vnxq0K9B4F+Aamy5cDT+v+yaJgkrCWI+4cbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdMP8cVW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdMP8cVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779896579; x=1811432579;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IjtkvWA6XN+m0V8MYZ+jFTK0JbSEmwg3gyrQuqAGw7Y=;
  b=hdMP8cVWUaQq6A3XmIXDPgPyqaNI031fdizqQHNBqhsbGoCsZNACSCa7
   E3sK5rG4iesKPS7cs+cphSadrlUd6iNUvsotXUljrAzwN94iBB1gudrJT
   NHC9ZevpkeJflokGM2APi91ci9p3wtSWi4SvmASkRyqbSPTjFx/fdoVR0
   NgJALOcxyFCjx9vikr34JeZnF+3dh1nCeRaZxGQW5nuqggTZA6oODFVB2
   ied5TZQGfjDTTHKEr9Ft5E+ILQ8N7MBl4FI+97a0wDTHqiDgD7i94z5Jx
   2Hh4lLdDZFyl5Fk/n/XI7qxeRgvB8nSOa2wYdBWZ/Fkf+y4n8ztwdZtdr
   A==;
X-CSE-ConnectionGUID: wc8ys7DzRj2+Yn/D421BvQ==
X-CSE-MsgGUID: NipDGFAUQuyanyBydQt31w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80715392"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80715392"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:42:59 -0700
X-CSE-ConnectionGUID: nRPh8swiRUaEvXCYmFtOMA==
X-CSE-MsgGUID: 9FpaV889QsaUlZZzj52yKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="238099653"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:42:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:42:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 08:42:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 08:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbhl6xp4q06ZyE93EjxRlCBCeDew3QZZnrkpXwk/ItB+2EN5keWwhHT+73DfuEMDW3mEsagYuX2iuEsXmNdiOWBlcxrwx4xk5XKSakxS3JU0eHRqtIOQRNXMNnQ+sVXUf6AKAlvzNlGfPM0Md3T5Gfis3nwWIteSBrljTnmfim+HC4kXoC7+5txvEN0mwsW9r6FvsKjlLVfyqkFKoVifV10dJAmmGxMe+yYMjVzRP/p5++7j533qgSRmLLfzMar7Tl8g2cdwA2oOxwYpMwJnbGyuICqoD15/XxEKCrtd1UqZDqmmWj3xCaLqX7ihSQJYQLG6vKIpr66Vj0jVHvG0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keJ+yKG1OqXe/Ct/jAZW1Hx9toD4eEVlyAtg8rTYrCc=;
 b=Cs7UKBIpI9XqCKnCwkyi6k3y5IPCu/eF5Ha40YOOwFTIveUPnSbYoyrZVWL1eavFSaOFhRSp6eca40wa47EqJ71iiAvPFN9XIQePaY0uMnQ+xqOyeux/nCNVJvivUotA5moYy2v+ZcPxER0OpZkp+23X0YA67cr4E0WsSEndvqSl7ygv0BFCtKbPZc58oFtd5M9yyRB5ldwy4jjOH4Zezex8WHNOCdigjNDjXTN1Qzc0K+YUDn3OraFnWc0TzJWiJ8y0HsAddDuIu/S+1L2AbOy4mFPeJc3ZIZk+LU4G7YVBYMXLq+YtEHC6DfiiMJoamBywp8cmmN6IHh5p7/tOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 15:42:53 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 15:42:51 +0000
Date: Wed, 27 May 2026 11:42:44 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
CC: John Hubbard <jhubbard@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
	Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
	<thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho
 de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-perf-users@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] complete perf_allow_* trio and use in drm/xe
Message-ID: <ahcQ9Ns5mjsnrbEa@intel.com>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
 <20260523084056.GE3102624@noisy.programming.kicks-ass.net>
 <8871a158-7a68-4247-a09f-bb3d970d6dc2@nvidia.com>
 <87ecixv82m.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87ecixv82m.wl-ashutosh.dixit@intel.com>
X-ClientProxiedBy: BY5PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::14) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH7PR11MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: ef71ac19-5515-46eb-d625-08debc069c6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: qZEGUBb3OMsnhx+uNHSxXkbYxG1YR6V+e5FbLUmfp3aIXaMlOoDnyH9E1E8K0mE7sTCCBt2Sr8YkcCPDu7hLrOYPtydi/BrFIOtReDlheM7CgYJ/X+JtaAC8CZRZ2UaV0Tk8kMMYGpQWhnvlXd7OYZlj3FDkqvCgUp24o+oEkws4rdAx3HWK743OL/hXSMdrXjT/23IPzuRBMa7CY51WK3sQ/qcG32SLV5gHk3zeMtMTt4zVjs4WcrBpiKs4r+f4ckJ7wILrY3ox83O9/UwdQq+vvaRWSiu+Qpq4BkMKN4gq/cGyrxczFnaneNsorI1elZE22RYBGcfcVpyve7ekchVls+J8gg5l9tP8O8dIhfZCuuLyus4rIZ05Ax7VypBfwzeP+Io/KP+PxOxq1jSX4p/gnaUm7ZWSHN4lhdoBbg7cW0665V+65zNe5AKa/plOBnOkgpoVF7QiGOaklY4J4PzMyaKMv0Y4s1/l9E4J7JLTSdSQCKXV3Zk61RGvYipAdPTAaTh9emeNHKrVRpRbN3CMC1ox6StOxNp2H1NWb9EHHVHP3C3N2+y8UFtBp7BebUHD+Azw3TiSz6ih/tpnI+yoFr4xvB/VInD8uaT5ATREpwmcikpaisspaCeEY0zqSl2RM257thMm05Y+ZKdwrSJd/Stl+ungT1J/9/BwgJQ3ZUirmP5U9cE47RiP4M28
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?peOWWld8NqrTnQtrfKi08WCCyhyAniK7CxxyhBu1w9QRdhrihrnDgiVbX7LZ?=
 =?us-ascii?Q?Tp4nIV6BKN+Ra62FAJKfJJX7zRNN8m0TdWC0msiXe7HlyxGScqWq27uf5swm?=
 =?us-ascii?Q?Z5i5SzBIFa1Xls7Q6MPXvOaFx84KmltYs6nY+z0gVDRzhRbRAT6RVZRo9W63?=
 =?us-ascii?Q?ZF6LWg/h4yvxtog0hytvAzobf3kKQhUwfNIzsto1UoJMzWOV1x8pDQOWmzYo?=
 =?us-ascii?Q?idhB3s4rQP15SosfLqYbGvPEl1MAM+UC+M3USje15Xhhtt8qVDpnB34WbDYi?=
 =?us-ascii?Q?gTkj+CktHoqMuFfYaZf3jlagxFI3+Zj1yhB9fdSBEQBp2YYbMjMOHfOKgN+8?=
 =?us-ascii?Q?CEPO7s+V13AlS29lRA/8EpcPJ462dCHNfS5HsBElm426PhOCVoT1tDc29Cz2?=
 =?us-ascii?Q?MSk6WtM1eFOS8xie0vgX3X82kabVwmPmVU4INktZpmBzO2NVbUxyB2OJZfX1?=
 =?us-ascii?Q?MSL8xn7Vc04l06Eb8+66m3+eT9DfFl88mWoNnIO/7gOJwWB/GJprY4g+vdZF?=
 =?us-ascii?Q?Fttl1uabFE9CfqjebDdCXrWTIDnBiuEqmFuWKm0PzwcnffTbMkY+tsuS707Z?=
 =?us-ascii?Q?HHBIBnuNVIFaURRADg6yT4QKH3jTDZXD/jebiYh7uGTlSVmHu0SptEyRwr5K?=
 =?us-ascii?Q?Bc1+38uXBrEJOYCDckQMlBmwMXedWy3MHPVvlZKdaWAFfSRM4AHAhY9k3GBS?=
 =?us-ascii?Q?plR7ZiIMbIurznu6KvaiS7YkfAHPXczocSoCIi9pefySDfv8VHVfATalaj4S?=
 =?us-ascii?Q?uffsy12sH+7/5jC+O+8MR20XmzbHKSAg4RIU2I3tETT6zhpYBGH/3PStb4Gn?=
 =?us-ascii?Q?mq+UZ8jnaVGjD14tVa4kQOYvk4nUm8krzuQUUf5+swLt77sWEvC78kum7CMZ?=
 =?us-ascii?Q?JkrntQjdejpo9pqx3FWhrctlwJPKiYc3oY+d+s2BXwTU9726Qq30Xc6GPGDi?=
 =?us-ascii?Q?v9BFevpyIwGzgoRUX3dfCffgylTl0Rzv3uB9QhSmhSlQMgSYqkKG3l0K8HH9?=
 =?us-ascii?Q?tfT/7Z+cxavQE4Wo2OuS6tZbB+CpZmrgtB6IhdR4r4oAT9VSJKdyRcGttI1d?=
 =?us-ascii?Q?naKWgTVAnXJL/5pSu639d3wqA+C3votcdyE/jXs/ulj0lR8AkKQVGSRab9c/?=
 =?us-ascii?Q?UZQEKPQ3EJuu2wkMP1jliPPljmVrIVIA5fn7owzCiXTP3LfKkARAe2TAgo0F?=
 =?us-ascii?Q?q368bnFbw1MNDxbwJ/EqUN7Z8Lyq0LdzWMLoEhQJOBk4jzxlXfVdzbE57o3n?=
 =?us-ascii?Q?fZSpLxHRXq9LS9wuCwmNaNDrR8v6GcZ22GeSzOWsxqNX5+sndVzB1k2d1g8g?=
 =?us-ascii?Q?AaIyjqnReAv+ufglA9xMrC7U/XSXDWsghzgy3+5EIxItIlwF4ljwxKf+zXy2?=
 =?us-ascii?Q?jR+QGHJksNl7WOuN+XjxRomcTAit1NffG8Yz4ehXjp0qJM2vwq5wvdDd4O9J?=
 =?us-ascii?Q?ScVV1T7eOUrHX9e37T/ZfgXKyKY4brqXOnMy/vG7auFqSvArFr9U/HUvmNaI?=
 =?us-ascii?Q?XibwFR8WdmfyKu7k1kJVFWT6anMnByNKn6ymmoVjGdCUMGS+Gjo1LZbjuEda?=
 =?us-ascii?Q?c/WtdfqEfabbO1mv60PlpLh7fPNiS0UM5KfWmLi21R0XT1CIp75ZnxYRGaZ0?=
 =?us-ascii?Q?ChjADJxUlOUr1hl3SYtvPifSyEdDCMazUq8lMVspVy8DOC0CRYC1da+sbO1a?=
 =?us-ascii?Q?HjNK612HskyNxiGKq/CpVElpwvhWSUToIomBVb8vfV0v5TEeEzd4a4cFYnKZ?=
 =?us-ascii?Q?aUNL4XKhgA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Oy6R/sSARRELSjLqGH7FsqbLGgq464tnaAwVYis8x2I45udm7eZOWCl9uj3sTnPa4bfnbzxr7/q7p6w7IZibp122LH0U5ws5593jEusnfqid8uySJ5SAFNnGJoE2/gwpSzYKA3YfUltINhh64YO1AyPbXvAL2lDzf6FDQVwQkf8pWcNrXiA0FKwZg6TYmiK9EHjdqlHHL4lIvKzrQ5HcdD3M/SzChpu7z7gI0mn8LVyCFhl5lLw/Q2hgYWfe2jRFWULo4KODN0PjPjSzAmV7OSQeIqjB3O20Ntzs6YvdxRlWM+0pQO+Tu+bsQeyZMJFPsolYGafm7wGZ8ks253Asyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef71ac19-5515-46eb-d625-08debc069c6c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 15:42:51.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7keJZ9yDli0ZCLQKgRQBmM2GbL0G+rhYrDIhWztGa157lNq6bNRrXy1LBF3awO1NdnQb0+o+QenAOI/y4FDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
X-OriginatorOrg: intel.com

On Tue, May 26, 2026 at 08:34:57PM -0700, Dixit, Ashutosh wrote:
> On Sat, 23 May 2026 10:52:16 -0700, John Hubbard wrote:
> >
> > On 5/23/26 1:40 AM, Peter Zijlstra wrote:
> > > On Fri, May 22, 2026 at 06:33:24PM -0700, John Hubbard wrote:
> > ...
> > >>    perf/core: out-of-line and export perf_allow_cpu/tracepoint()
> > >>    drm/xe: gate observation streams with perf_allow_cpu()
> > >>
> > >>   drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
> > >>   drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
> > >>   drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
> > >>   drivers/gpu/drm/xe/xe_observation.h |  3 +--
> > >>   include/linux/perf_event.h          | 31 ++++++++++++++--------------
> > >>   kernel/events/core.c                | 18 ++++++++++++++++
> > >>   6 files changed, 79 insertions(+), 35 deletions(-)
> > >
> > > Sure, works for me. How do you want to route these things, Xe tree or
> > > -tip?
> >
> > Hi Peter,
> >
> > Maybe -tip, but really, either way is perfectly OK with me.
> 
> I've R-b'd both the patches. If you want to merge via Xe tree, let me know
> and we can get them merged.

To get them through drm-xe trees we need ack from performance events subsystem
maintainers.

Peter, Ilgo, anyone, ack here?

Or do you prefer to get this through your trees?
Then,

Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Thanks,
Rodrigo.

> 
> Thanks.
> --
> Ashutosh
