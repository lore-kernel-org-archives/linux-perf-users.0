Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBA1C1ADB;
	Tue, 11 Mar 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683885; cv=fail; b=mC9AUPUBfqPCyWIb46+pl316Erv+7Nd4qZvYLZ8x6syRvl918q30rxVeilgx8uIZLIKv4YuUEtHGxotjsEO/kx2NsfuyrGbAhEZx969olP5BTbA0jrxNPzRMr3lfO5/YD7N5BmHNtj0gujfquIp+1Uv4n806Xwnuzur3f2Jtw1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683885; c=relaxed/simple;
	bh=ezSvXbokBkOC9B8WFK/0VjqboF2ZLEWVOTEvylFX85M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AGDz6ZAgYlr1Ax8/tumEU9vfcxpOcgvjkJQWJtqWN48AupienNzRBnjCSkWRVYdzdPYrOlVN0IxcPSeA4/ekI93vyvT8AKfSXARA/bWP4Pyf9JPlF5fUoEuiP79u+8OcRg1pzPPNkw/50lHzDy5TR7wsLjQtbgmQAsPhE8jZ4iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOLsx2yX; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOLsx2yX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741683883; x=1773219883;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ezSvXbokBkOC9B8WFK/0VjqboF2ZLEWVOTEvylFX85M=;
  b=WOLsx2yXpCuFvs9cDgdOsG+ttR482ra8snI5ne7zJHivJkWLTmfQMnfL
   Oii5VdOtpZ0wXAk3VrhtY8wLhdq4WFJ72mThEncnKVJu4AzyF33cN1yDE
   y5clvINc9rPS/udUdc2Xle6NTTbY5i1xsNHmxwZ9LI6/1o+elhG5FqHBT
   TcNCpNlkVGIRAVmWsAnOKVFVrf5q7Z0utOFkgn/VXC/RTFNO9mlZcmqSo
   MILqExxKoW5MsezhGc/2clDiT34fgwn8BAwNnOJai+lzsPURHR+W1qbNn
   6ugo9aXxVZz2ogbDFyWulvWJlM/MEIeXa0lEQXiEjy6U39zfVS81qwBTY
   Q==;
X-CSE-ConnectionGUID: 1zUhu5ZPTd27/tLX3Zu+zQ==
X-CSE-MsgGUID: Ck3GDBjxQbSStUTXOkp44g==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42563539"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42563539"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:04:42 -0700
X-CSE-ConnectionGUID: ZS1YbdEPRXett1jv0CCwNw==
X-CSE-MsgGUID: yYCsAxP4TgCaUIvoCWUHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="119982222"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 02:04:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 02:04:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 02:04:41 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 02:04:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQYcbxCqSzimaBjyi9DNdWrte7CWHRj6c5jykOj9dG/Cpcc90CZ7H27YOuiqesT54Wb0Hwj//4NSM2Tiy/VcScfFv7/etbB2Qn+ysS3SKf/51RMbR8deQSafnakt/HrtAd0duV1yc+GM2IoiqIAjDcxvliXXTlFxbt13M/DZYSvoXM4u7g8BvXVWHw90PNW+UHDt9tKok/R7ssK4wZ/u94Y3V247FzhCii+qIbvf5t8zC6eME1tnxxb93RXqGx4xex578+j0fE32fg5OidNzaVwR5WwaFDCuKG3jJlE4PEEEHbwVLopTG77U0NtwXQs6twnPCVJat8ZMHL1sPlEpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+12E1zkkyYqe+S2/mJCgMmJgbLIUqLObrYmh1hfe3E=;
 b=poGFZlZSqJ1d6/BLyZin8zD/osPELkRuMWGqhvUrE3ss/USdlKI/NJgesYa17nPtvYK8qd8nfVwWoZFD7R2wBnEFXKCq53yYC2b8fSzr/JA2ZbfNUuvXcDS8fNZkBBAz0gxz/l+5aHvSEw2x7FdmdOYMelukhDbM1pl4Iso9muAOXxANbo0iPSY6qYkbxGKW7ixLS5AIYSxqcqgKqIcHf+SosNwoNfDsEc/6sQ+L/2UZ3M/kGYKpmoXJRpOSjsxF6A7soaphsQ2JP9irdMpfGnPvESUsNyHLzesB51Vet8LFs/42wTXHAVPcrOk3Y2mWwFtfTkcr6o50gpmJ+KcnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by SA1PR11MB5804.namprd11.prod.outlook.com (2603:10b6:806:237::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:04:38 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:04:38 +0000
Date: Tue, 11 Mar 2025 17:04:28 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Leo Yan <leo.yan@arm.com>
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
	"Martin Liska" <martin.liska@hey.com>
Subject: Re: [PATCH] perf script: Update brstack syntax documentation
Message-ID: <Z8/8nBSBRj56kO87@yujie-X299>
References: <20250225061736.1698175-1-yujie.liu@intel.com>
 <20250311081443.GI9682@e132581.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311081443.GI9682@e132581.arm.com>
X-ClientProxiedBy: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|SA1PR11MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a4fc57c-4498-44e5-3f20-08dd607bc098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G0BtN9Z1oKcjzpyjo00PLtpC9ZxMbQKfG+XCV7PuKIxvuBfE2nhPde51A2vq?=
 =?us-ascii?Q?w8KEIG2QCwcgsbBqtNZ/iXDG8h7RL/w3HYyMWG01fcTC8jZ0Gu4dVeYAwZSi?=
 =?us-ascii?Q?GpgaaUMVJw6blJlBRspV4xPjzpZGet0G2rKFe5qlr+pQrkgcQM3yaZYnwDai?=
 =?us-ascii?Q?ax6EngYhs+ZP0y4KAnTSZw/e06l3+Nv7hT0dFtYZYxpXPcOzqSpzAjo7+AXA?=
 =?us-ascii?Q?mCa8YuftlVsppHD+Kr2+ZNSvWdNPI+kCBxOiqL9fdycgNJbJyBHFWAgr95il?=
 =?us-ascii?Q?E62km6NfbFLVCN7kNZ/FAa2tXxwD2/js9AWtopIj8g1JGXEWDp61tP818MFR?=
 =?us-ascii?Q?yUdF/EhCK3ag81dQHiRhZFpS1JNKgMFSCrqUOaOUzqfgXVaE/9KfXkEyancM?=
 =?us-ascii?Q?nOJEJsICxc+1IyKeCHPaLTykeuuPeq5ceiKpbEs7prpa6o675vfXhmNRi55o?=
 =?us-ascii?Q?rzuOCxdBXkeWb530+pXo+np2bgJgy46EUsCnv8v3RDO8yDu5KWY3aagrXesz?=
 =?us-ascii?Q?HyPCEohgtClFR0CQ7CO4pRJVmophRMOBBFjHOZpUzanxtH3M+qXx4ysgx4KZ?=
 =?us-ascii?Q?7Xrsh59Ugf4HJX24YF7x7SxLB7Vq7lImoac+kHZZ6/8lGK5hC0UYD3tbLn13?=
 =?us-ascii?Q?dPct0NtOK6q6Owm/y1nOyfk9+z2pBCnbRoDqWvwKbutSQQZyWMs5CZwClbtP?=
 =?us-ascii?Q?5TDl6Y3bKx5HUuA7Jc2wSStjSD/yZDx+VWiqU/TMhnCtew7dXFDgmwj4dYnW?=
 =?us-ascii?Q?/UC7a5htDi+esPPZo2OJibd5vSM3TOE3LiPuYXGphDE3rEDfJJ2MicBbQan0?=
 =?us-ascii?Q?a8jf2dJ8YQKhUMYZxq7OwXy7LUtaZAxxQd/OGMFdU+sfBinKrcZqE0ppbia7?=
 =?us-ascii?Q?PMF13i2tzSO+DQ3RxfKCqsEtgv1IBO56Kfs/sCf5V0347fwxUP65L8gqz4dL?=
 =?us-ascii?Q?UUNoE1eI1msCi3at6tfXD9AXndEg6icycirRac2BGKO2ibmQZl5GDUcWHskS?=
 =?us-ascii?Q?i4VleKyhNftoqTbMxGCaQWw/7eBtia6U2apkq0pCKTXdyaLq9EBPIV7jBLiq?=
 =?us-ascii?Q?XIrUWE3JnjCizjOENZM2rsFo33LhrfVxvtkTNP0z73ULJyWLOwraG9F0Ika4?=
 =?us-ascii?Q?Fl1gNgNeQdu/i9VqpX7HXUOKGWy1YQR6GcNTX3H6U53h9v8zooSHtwmfTxrO?=
 =?us-ascii?Q?Zbq0ZSNbJMRmU5nIhwGtnZPs9WhAynoRhmEzgEqsAQ4dS7YazGPxsHFBTpoB?=
 =?us-ascii?Q?j4lnQnQP+h2F/9BWDaBDAG3hdt3YGixbHF+gtOXzmvsKfH8hkAiKU5X1atvs?=
 =?us-ascii?Q?vfcte+MXPfKlX5+ulxnUrjCk3WJNadBlcTgDUanTH3RtNlS5aeilLy63rRlA?=
 =?us-ascii?Q?FKjcj6eE4G2iuJvHEhp7yj2trNs7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Se9SB8xCt0iWntaCwJ/lV5NlLxINe3OeLDFXItU7c75JOrbT6giRb8VgAWo5?=
 =?us-ascii?Q?7BO1/8W3Mk6OCils2Di4tH/nGPFcTw1dKaoiyt49LpfVMVzLcXR616ODgIsb?=
 =?us-ascii?Q?xu/1ZD8++wyOndFiSMgRaN6xkLWJQy8E1ELR2O/nv415i7ifF5cZaH0+rKlB?=
 =?us-ascii?Q?MyzBhtWDga/L2V4wcNRys98yAcuDmPaU97OH2sisF6rjtJGj+s7+k95B3ql7?=
 =?us-ascii?Q?XrDNVGIJC6Hchai/YBGE9kcdZg0PFyBu2HtuT28mEU/ju8h1wSGGoU2yWuEE?=
 =?us-ascii?Q?Vgmv5894VU2uYQGVlygU7upRhM6+s8DLjy/VRo2Z27eGtpw9+pC5N0uKK1w/?=
 =?us-ascii?Q?9VHPrxUW81kdyDO7q4+oLDjrj5Z6ktK0pvEvr+JyR50/wSLv01wyJBs/kg8e?=
 =?us-ascii?Q?yWcCo9xcVCwLd1v2IzTe0ot65C6axDIFuKkCnEsGfR7YPmLxqh70X+EQpHxL?=
 =?us-ascii?Q?WnpnW/hycbbAEUOde8Py/UiYxVsEqh+I7hMdhZJGSsxK+FT1MXZ+IhFrXcZa?=
 =?us-ascii?Q?EJIHC2fg+t41pbZHh3HTBKKQu2CG+88E8ICi4GyLVEZQQ8woGPuBb9wMrWyO?=
 =?us-ascii?Q?CYLx+duDDu7louzffwayN7OwmQ3PclI6x4ydkX5/eiQmAPgIiM0ZDaZvBAPs?=
 =?us-ascii?Q?tbeRTH1VdFZZvv2wGoazsNvy0dyTk42z3lyVMh3LSqO0jJ8vfmglK5ZoC5F/?=
 =?us-ascii?Q?ek/HodUlrjY8QhBxiqEirfNX8Vf7AscCDpVPnpA2ugSCD3FylUMLIfTk9oIA?=
 =?us-ascii?Q?UZ4GHeJajbxur+bQcybXmiCyo0zP1fy+8yvl3CI3NcyMEXPpU+97X/V8cJ4b?=
 =?us-ascii?Q?8dFvv6368+2rbo0SmuoO+vvbGePBtz+LlUvhNyeyYohb2qHbSUt6txAT+3H6?=
 =?us-ascii?Q?itw6fR4v7G0HbRBL5GMa5R+UdMCuEulRnSO3ZjwX70mPsyue2v1kqe5a/zIK?=
 =?us-ascii?Q?DrqrWoZ16BI6HS1d/xcO4ZBqskaqCSQ2nSEBXfM9ZETigtwdxEOOC0cctzfo?=
 =?us-ascii?Q?qsaZ69udhAiDGyEEDhG+r6CCybzHqiVaOawRBommCxv+TrfRRmEKcCM5v51p?=
 =?us-ascii?Q?VktMbQclpH0EtmxUNugfBy1hSIW0RHfDTHYeRwnz5j2LXKzIvrCiHQGtAjfz?=
 =?us-ascii?Q?Wjqn45RGHoNgowWfWvCdkJHbJtv/f/0kJUd0bBhbsueRCXwUUpjqh2H1noD/?=
 =?us-ascii?Q?td++Yd753QN/fNwLnp5qjet12lVk0RtdfFnVk/QA6cu4hzq7EeGrVkOhOXZ5?=
 =?us-ascii?Q?y7qMPjhw5pvP+Q/Dge4CVvXq7KSkgPIgmhgOD3To5qBKuuh8SqYcrNV0ffGH?=
 =?us-ascii?Q?7BjyiUoVvx3h6s/GDHixu6msYEq++YibcR+7uJprQxAIr/5FrLYYg4ZBqV9n?=
 =?us-ascii?Q?KODvBpb8cMDToyxVgjIs3XrYacPcoPqlv+VsZA1BeczrXRs4T47nntqOl1er?=
 =?us-ascii?Q?Wz2kdGp150Ucgy9rL1O156msucc8p/MTvfGQYoZYDUdKj80GivP890pz5BdR?=
 =?us-ascii?Q?rS6Z6qJYOHS5al3F4YOXVc5lBtXBqmSU22DoX1NvpFigH4IajxCY7z3EIYqH?=
 =?us-ascii?Q?Rb+EL/cYS/nCSZEBiP8tsY/Ch8F80Yg096V0dfwX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4fc57c-4498-44e5-3f20-08dd607bc098
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:04:38.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkXH0YySfulO7DdpiHudUtavOv9LDOWxHMR29yc3vPZirt7aJhPpxGLkgqUV0FnNVzsDZxFgkyql2FW+X0nHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5804
X-OriginatorOrg: intel.com

Hi Leo,

On Tue, Mar 11, 2025 at 08:14:43AM +0000, Leo Yan wrote:
> Hi Yujie,
> 
> Sorry I missed this patch.
> 
> On Tue, Feb 25, 2025 at 02:17:36PM +0800, Yujie Liu wrote:
> > 
> > The following commits appended new fields to the end of the branch info
> > list, such as branch type and branch speculation info.
> > 
> > commit 1f48989cdc7d ("perf script: Output branch sample type")
> > commit 6ade6c646035 ("perf script: Show branch speculation info")
> > 
> > Update brstack syntax documentation to be consistent with the latest
> > branch info list. Improve the descriptions to help users interpret the
> > fields accurately.
> > 
> > Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> > ---
> >  tools/perf/Documentation/perf-script.txt | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index b72866ef270b..8bd105084280 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -239,13 +239,15 @@ OPTIONS
> >         i.e., -F "" is not allowed.
> > 
> >         The brstack output includes branch related information with raw addresses using the
> > -       /v/v/v/v/cycles syntax in the following order:
> > -       FROM: branch source instruction
> > -       TO  : branch target instruction
> > -        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> > -       X/- : X=branch inside a transactional region, -=not in transaction region or not supported
> > -       A/- : A=TSX abort entry, -=not aborted region or not supported
> > -       cycles
> > +       FROM/TO/PRED/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
> > +       FROM  : branch source instruction
> > +       TO    : branch target instruction
> > +       PRED  : M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> 
> Can we use a more generic naming (e.g., EVENT) for this field?
> 
> My patches have added a 'N' flag in this field, which stands for
> "Not taken branch".  Later we might extend this field for support new
> event types.

Thank you for this feedback. Sure I'll change this field name to EVENT
in the repsin patch.

Thanks,
Yujie

> 
> Thanks,
> Leo
> 
> > +       INTX  : X=branch inside a transactional region, -=not in transaction region or not supported
> > +       ABORT : A=TSX abort entry, -=not aborted region or not supported
> > +       CYCLES: the number of cycles that have elapsed since the last branch was recorded
> > +       TYPE  : branch type
> > +       SPEC  : branch speculation info
> > 
> >         The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
> > 
> > --
> > 2.34.1
> > 
> > 
