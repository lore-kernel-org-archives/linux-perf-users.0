Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952A3016F5;
	Wed,  5 Aug 2026 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929195; cv=fail; b=DD/H2fZtRxv+bmW8tgZSR4E0jrS5k7A6Brb0Hi5U5udHK2GUM8j0QY5IWII3APypanlSLBqd1P/tcIjAz//ESn/lVtK9ey9eLDwh0ZnlDhjC6gDtIdslOKWVqy+IZOa5thhrYMPaKxqq2FDlqKXwAV8WkMzDjsDKFb6ahrPNAII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929195; c=relaxed/simple;
	bh=fCnpv0SmIJn2xOF6pfqKLqz1xhjuuyYPRMybU0oj4E4=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGmg6Ite2smH95VG7iiGzrexp5fgMxb6z4u0ftoVp45kEbT06ihZoJhrOerbHuPweB3f2/J2bhlPEhTnb/QHvRHQv92RxDKA3OFob+YFC2zyPQ9q5D0Qn8ws/41V2RMRwjq2lNhJGi2J7nxycUUBeG7aM70WXzVrehT0vq2JC0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpBI6fi4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpBI6fi4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785929194; x=1817465194;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fCnpv0SmIJn2xOF6pfqKLqz1xhjuuyYPRMybU0oj4E4=;
  b=gpBI6fi4G4SxTPor89kBBx+6nz1KmZZSJzvQFJiPCi8PlFUqX0bOWQ2p
   ELJNo61QG3kr3hEvVgCZwituMQacHCFdqwHh6wzSFf1zWoBDBvEKsg0Gy
   pfWwTpQZxoPnMIoe4qVY2POxm1bS65GUNt+ppLZ/wYMu0AqMNNTNJDnq5
   8W36KvVfElYeWgAjmLY+I3Ngx31Z477XITFzt+Y8RHR0q6UYLwTfL0eGZ
   ICINF7I7QfNjHiO6w+hqHhqkirHK3ZN5nLH9+hvSd5wHU4V3zbVX+lnh3
   6zpaOjwhevQ5zGXdO5WoMRyaDSvs1Xux7z61V0z1sTFQ7kklsYiL8nUlq
   w==;
X-CSE-ConnectionGUID: 6DZ4nqP+S+K/X3hUubNxxg==
X-CSE-MsgGUID: 93waxNMUSme9p/mua04fSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86614123"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86614123"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:26:33 -0700
X-CSE-ConnectionGUID: HaWEZlGbRMOf1ho9Jk3mLg==
X-CSE-MsgGUID: ++/3lpjeQwOHcD7VBivcdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="257922661"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:22:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 04:22:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 04:22:44 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.21) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 04:22:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hos0YFzg1u7QdVVyut0tLE3idsErFAgCCGiyok2W4XZfsKUY9JjwsZioGZPtwVIGpZb5qNvsKyuB5osxOX2npnNBIhlZh+ADyLxXOVHvpbj2cP3bzHpepdXvgrc8RP8g2o40u3T1u7pq8WX8DWl5NPSUF7wy/udiMVOvu7nUGg0gO987Ss6fDhV7IPd7qb8jIci7k2W7moYQvXi+8FIRyGN/VeiNbssADYrAG+qoatj0S4DSy+Ygo3RMbgXCxdUeiI69KqXnrelyVUE80+z6csoD1Gj1dLntgStVN8VnAGHgWVgy/A72j5I53aKGgYW2WYIDoAQpBoQ0FWoBTudBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCnpv0SmIJn2xOF6pfqKLqz1xhjuuyYPRMybU0oj4E4=;
 b=y/2cV+2HOEZOeMph/ZjPLSIHbzOC3GNi2CM9v6hlaVP76wxK2aSY2+1XA7AE5o6CJj55rVDmR0JqOkRYFBDL2qOtQ/9JNloe9iKN+YxkHtcwZQaP+qFBGVMRiZmo1uASJV06hPsyIYfv+eyHPuSR9yjq0bdHlhBGhKFVRVJWdTN+V3Sug1CRFeLggCpt1Yue5+eY3zPeBknobODmkn9U9reHWWs4qY90FZJ7RKJhNVIdYeQD74C5IkUawaU+jb4uPBDUYRw+yswdQ/zXSdW32ExW8ykW45Ux/Q0auJv/87EOx9ZBOKnRTFfjE+tmLuNkNjRJ5kXuiRuB0xEg4bEdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 11:22:35 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 11:22:35 +0000
Message-ID: <6f7cdb51-ac65-4ee8-98bd-1274e84ee38b@intel.com>
Date: Wed, 5 Aug 2026 14:22:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf/x86/intel/pt: Fix stop/start with no update
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20260721070254.13557-1-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260721070254.13557-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0007.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ff9f24e-9e76-457f-48d7-08def2e3d951
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: xUHxyK+o6A5FwnDL/o/9yT5WDJnRPjDWUo/XBr/iJtXhM0O+vrQgjyGYSv/pM3AWMvne+aw3dKqMFdHr83g5xDXYjFgCwG9ZuDiTKgdvqCbW/SG4E09+GO6nVGro8TRGifyJ5S/Pvl2GclmGWkJNaSMsfLCQr/W8TiQCQLAOz1CQwdkhw15xEEGkp68wxPKGTw+Kty/Hd4xM5BsCgD0gr2VRnzyA2DUG+TQbuKRzyKdTn3yRGqIXQtz5DEWtBUozHKyYe+E21sbVAF7PWgA189jshSuZpAYTQ8JPoisCiON4whjeVXxnM4t1U7We7py8DSCxoGSUyr62dfdLJxNl5G5PprJvhEx7BDsG4xkoTTXTN5fj/RhiPK8THHzHES7mwgUIgaW9LumkA6LsoiUwgq8PX/EZH6V2MdeLfI/7H0cqAsZ1kYDgIsd5/wV9vqmr9PYNA080f0U2C84HYkhTEF+DJCkHI8ygT1vSDJM6UVlYSyWO5nH8DdVQ+CVG0aBkx8wB82x6jnNx205oXNQiDkno1uJ7EsC7kZB9LunxNcJlAlRF3cFGjWr+pAR/rkpzsZfQPCSEkMTQ5tP4yalc1z8JcvoiLBkLVV2h5ymqX6Kra9/mc93z630TKZX9aGRDuY5xh1saKV/n4mM3vAZxeDUIQVgI+ZEX89DzzQSnF3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzZiZmU4Uy9Bdi9TallHaEJnWE9hcjdGL2EzU3NtWFJCOGF5RGlkU1pvU2Z0?=
 =?utf-8?B?c1pPcmxyMS9Ta2VSUHhOMk5VOHlnTWxIeXNlMm56cmhCU0NES3psamxZT2g4?=
 =?utf-8?B?RVFXMjR5WlhTSkN1ZWt3eDhWU3ZqaVVQTWdxbkRsbEFTSzNKUUllRTBIcWN6?=
 =?utf-8?B?V3U5SnFHTlFBa1pJMnFxZlpMNDc5TmZpR201WHJEVWIzUGZTMkhlYWtGZk1j?=
 =?utf-8?B?Rm9yUmZ0L3Y0c21xcUFLSHhNdGpGTk53cS9Lb09RNjlsYitpbjkwTzFzS0ZQ?=
 =?utf-8?B?WDJnK3Q4bG1CeW91YWxyaDRJQTArMjZYUnIwWFdTUGhRWEMyeDZjbTU0cFdE?=
 =?utf-8?B?WHRNNTNzMFppTTlFOUwvTitMWktBODNJWEE1SFdiOG5HUm1zVmZkVUl5QTJp?=
 =?utf-8?B?eVBzUUFQbHBIS01HYnRmeUxNL2dqYjdUdGsvQTNwTFlZaWFKOHJONG1uRGFU?=
 =?utf-8?B?QUROUWNFRTFIVHQ1SHNSVmJEVUVuRWxkckREN1ZNdmdtN2NlL2FKU1NMb0JN?=
 =?utf-8?B?YUFiOUZML0dBTTg5RjFxY2JlUm1Tc3g2MXF3M1d0N0xkYUkrSmxKcUVqcHNl?=
 =?utf-8?B?QkYyeFRhZG0rMWd3bkhpSURqdmtaZmhENkxlRGNuc1JsclcvOU9abUE4TEUw?=
 =?utf-8?B?Zjk3UDh5WnFSYkt4TlBnbmNoRkNLUnNWMHp4NW5HWktLaDIrdjR6Z0VHN0pp?=
 =?utf-8?B?MkErQmlSVFBsZVNFYmNXZWk0MHAxNWxCQ0ZYbkZVMlJ0ZE1FdGpFQlpDVjl0?=
 =?utf-8?B?L2pacTlRYXU0VDc1TTZBMXpQZ0ZzMVBvUEkyeXRtWXdOUHh6cFF6WVNnMGZ4?=
 =?utf-8?B?ZjA0K2FrQ3FoNk9ud1BVbyt6aVJ2dVZRc3NESEF1TzR0Y3pVM0FpK3ZzSkRC?=
 =?utf-8?B?WWFRTDZVNjh6eDdXNWVOQ0w1dzlQZXpydkkzWkt1UjRXVDZaWnprQVBUSE4x?=
 =?utf-8?B?cGxuYmtZdENnL1ladlFZUllmTGthRU82L1AycDhUdHNVckt4Um42d2RDODIy?=
 =?utf-8?B?YVptYjdzNUxLSEoxQUR5dmFCdVgrTnNraHQyVTRXNXlPMFFuQkVld3IxclVF?=
 =?utf-8?B?RDBhVlJYWEtiVFozYUdIcVg2bFNqWkdVNGhOUzJBMDJzUkhGQXJ6ZVpmYWY0?=
 =?utf-8?B?SFh1YmNSSmxGUzVlVmlReGw1TkV0YUxEV3Yxckx6YWxmeWNYbFU2SnVpK3g4?=
 =?utf-8?B?U2ljQ1dmOWFaa3E4Zzlsc3JtdXBMTXRJU0ZMVUVOYXBjTVhrUFFrVktGM2w5?=
 =?utf-8?B?bE9NbnB5czBUVXRKbnRnUjdTSUVRUk5CWnRvYmpxTHFyV253dFJmUVRDWCti?=
 =?utf-8?B?c1NCS0tPSUdnZGljR20vZUIyVXNYUGhVN1dVZE9hRi9BNVhVMTQ0WWRZSks3?=
 =?utf-8?B?RHFnQWNNZkFXeDY3U1k2Ly8vSzBxWDREbWM4L3YzM2JaZDNHVnp2OFl0ZzJh?=
 =?utf-8?B?eTZOYVdIS2JqaE9LZ2dleUNodXJ2dGI3Q3ZsS2JDU3B6aHBXYlFyM2pXdktZ?=
 =?utf-8?B?ZE9YMzJ4a1ZYaENjOFE5ZzBSaGtsYUFvOStqRC9BajA4eFBnZVpIOG1wRTJL?=
 =?utf-8?B?dmdidllrZ1hadTJ5M0hBTTFnSXJnRWpiTDkwMWlsc1JZRkMvSTF1SnB6bjVJ?=
 =?utf-8?B?bVVqQ2h4aXVJWDQ5STNFbk42N3ZjR1k3OWNEaXdlNlZyU0JwWFFBSTZNeU9P?=
 =?utf-8?B?Z2hqa3BPVmJwTGRheTJhUWt2aFJVb2VXSlZ3Z1ZwUW5rV1pNaENtWGt0STQr?=
 =?utf-8?B?dStWMDlnOWIzTDdtUEFiS1A1K0pEMk1ibDkvNGdaaEVMOHJhSmhWa1pVb0o4?=
 =?utf-8?B?d2FGbG1Qb2FBdUhMM1dlYzVCQUdKeSt4RlNpa28zd001bXowZ2dlU0hGbjV3?=
 =?utf-8?B?MExwUkNyVjY1TjV4R2ZEM0xHeUlEMzVUY292anJMK2VlNmZJWUM5aGtYT1JL?=
 =?utf-8?B?ZGNmcWptRE01SE9NTC80QVp6SnVnZ0xZbHVqZktHcEx2eUZkUXdvOTVVZkM3?=
 =?utf-8?B?MEZLT0pwc0d3ZlBtY1JmV1lkWGhmVXRodExERUVYK0tFakI0aEVheTVGK1lV?=
 =?utf-8?B?MWpnL0RoQXgzODJaNWF6Ulgwb2FyeGV5a2c2MEpkTWFuYi84WHFIWWkwLy9h?=
 =?utf-8?B?c01SWlJ6MnpQbm5RYmtYaHQyY1lJdVpveFFpUFlQNVJ0M3I2WUtwdEdvMm0v?=
 =?utf-8?B?NTZzY0xObFdGeDRGUXB1ZTlYVkhrWGw4dzY5SzRRVVhPdzBUeHBoYnpNR2JE?=
 =?utf-8?B?NE1lWnV2QU1ZV2hpcTFhUGROSUM4ZEZrMm9lOVhWZE4yYm9DNUhNdGxBS2ky?=
 =?utf-8?B?U3JoOG9JRnRlUjV0Qk9oU05oYlpmZHpQek5aTHNJcTYvY2pzYjJSYWFmbWdk?=
 =?utf-8?Q?Iw3bY4u6KTmkFiz0=3D?=
X-Exchange-RoutingPolicyChecked: IClESJ3YHwZ9e7zN0CmwAWHcHJBrRZQqe4BlakoaH3kh2REXiyjG/75BhkJ1XyzioZJqWcVHP5Uw83DcjlK0Dx9iUzgbbAOaluV86aiNGXidJbiqYxz7DsV284Rm08wQy1LY28gzty6f8Ync3NbAmCoCJFLrpmnCl8ujFYGO3IsC+cxXe2R7/BGnT7ylwRVobUkSTKmsfYz9BKfRg/+E0HLDwGt9S0WF99KMQBmDVE/yf49MqUmLA3JKLqmstOp2OdilSG3Uf6TbwDKPOqrNznFM4inCdemslgZErxUznbBaXFLn1b7psgIB79pAvQIbUz+g3gAOSes1cC483t0gPA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff9f24e-9e76-457f-48d7-08def2e3d951
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:22:35.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23r8Qlq6nnergBHR6xwd7uAhTmRnjZ2876Qcr8WSeEC6FnxkZ2PCaZZ1OKfm1sgclWnUTUIt5KT0te5bvdzohQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

On 21/07/2026 10:02, Adrian Hunter wrote:
> Here is a fix for Intel PT.

Any comments on this
