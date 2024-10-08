Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DEE2209D;
	Tue,  8 Oct 2024 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728354704; cv=fail; b=MSXWyhk61BtCRp7IKJwNAOjc77puKbm5Y6XUW1C6G5YSvVVL35zBcOzTFlEh9o+b4iVU1l/AcWL4YQFscjxt5UsUjoLHCg5i+R5iQisTwLaDuh+sapI9efGmVb3mjJZdw1q/uXaSTJD6V7jBpjhk5iZRdLXWmcnqphbZ7GdQCjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728354704; c=relaxed/simple;
	bh=+BC4U00ZACZU/+TPp/+coJpoEZbyU8unKvqoXksq/V4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VBVFnYLKmirNeBdCeaoYKleETd+e62yfu27DqIWo/waUUtT5+Wi2xogZ35KW2udhYvGCzrBDq0AyseT+rhoUT1+ABw0S6nZxrFfYFCJb+5yyU5alXf2VB++wy/2f1of2g69Wx0s0cckSMTBgkVZmEMjNffdCHAfkIfMn3SdfB3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyS01Uy0; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyS01Uy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728354703; x=1759890703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+BC4U00ZACZU/+TPp/+coJpoEZbyU8unKvqoXksq/V4=;
  b=jyS01Uy0EeXJl4kfEBwlJuwfKt2efNobzecpsh/24YozxFCJATo89S4R
   Nca5sgHW9KtlNgtDB8htDDLWb7JwPVfAcUv1iVZREBioHOyDOiAViSN21
   KS+Mpi8L0sPEs9eBxsHqbOMx49LsxVGJpeC9JHRpTgg6Gh1jeyuHyztQf
   7PfPA6j6TdOt4dHaJl/Yu+YsazPvoy1l/uv6VetiCAsYJYINU7ld1pyX9
   gXSqf4lBtH/UDigNApv4aLP3y3gc1KW+BLJtGSjI5+C99RxH4nbntJklI
   J+6jLePwR0sFWdTIXshOa4zp+dDdLa4O1hs4/x1f05cHSEbk2Bn4WvMbI
   w==;
X-CSE-ConnectionGUID: HX+GwuXSSaeUYZ62r+BR2w==
X-CSE-MsgGUID: yZMT1TMWQgKbsiTDcE5RVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="26983623"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="26983623"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 19:31:42 -0700
X-CSE-ConnectionGUID: qiP758sZQgWqFt8iPRhsLQ==
X-CSE-MsgGUID: 6tYuY0PiRAm4BsPn13GrWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80291579"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 19:31:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 19:31:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 19:31:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 19:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PunbWwjeE6u0pcy4ROOP9rqVsSVUF63iUyBMG0B6BIpt2l7PAdTVdCICpaUYZe1qtAUEUx/A06STUvkbvaH1d4I2c/3t+Jftbn2sz3MNM4oSBeDem0hkXylbkEu/rWkTGKXtApX5InhfTR6qD6vgSguBUGBPOwChDmDNNqrjhKxZLUzoUMBXBcRnysudH56oq649IEOW788hbKKxM6ze7HPG6XYTYXt1BRPS3E7voghDZkiktyz0YjKzWooCQVV7JQBJjPkOTF7GotJZ4lW0GAOMlPlWvsBKCxjCu3IrbrAm2RkBMQWadavTZnVvlfGrV6Zgex3s4Z8zi3TAlApcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BC4U00ZACZU/+TPp/+coJpoEZbyU8unKvqoXksq/V4=;
 b=TOJZUS2K9gxxrZOZK1xvYd7nyXtSwpX392qYIAjqoqzoe2sm7c7NQjSRrNoCbcpxk5vVx2oIcub7syQf+xCeB3Y6o3Xb3w8G13O8mS/S1mxtLuV8WvLuNJHoxt5pmO1khYvYtPZDAC+fG+TZqJbAeKg2zznxNyxShULAt83eTzmRzClBt0qJ+8JzG6zpLN8Iyfi+yWhgbaNgTAOJ8Mnf+HzvWCoc5XOpHcklK35Ev99o+N0U3mVx4FVJEgLPj1kq2RwAyOQOZQ5Pn0fL6aTS/I4nIZKckmsZ7iW3BuzUoDQ/vPlseiNgRSYtvnHEVP5obc05VNUg7jDYmfNdYWNUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 02:31:33 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::fa93:2029:3d0b:fb99]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::fa93:2029:3d0b:fb99%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 02:31:32 +0000
From: "Mi, Dapeng1" <dapeng1.mi@intel.com>
To: Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>
CC: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yongwei Ma
	<yongwei.ma@intel.com>
Subject: RE: [Patch v5 0/6] Bug fixes on topdown events reordering
Thread-Topic: [Patch v5 0/6] Bug fixes on topdown events reordering
Thread-Index: AQHbBZzE0FC6Ch5gqUmvLr/5BrB70rJyfxsAgAAZJgCAAar9gIAAD9sAgADquoCAABBBAIAADfEAgAAyRYCAABxOgIAGnlfQ
Date: Tue, 8 Oct 2024 02:31:32 +0000
Message-ID: <PH0PR11MB48247D4A9F1D09156A9DA765CD7E2@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
 <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com>
 <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
 <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
In-Reply-To: <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4824:EE_|MN0PR11MB6086:EE_
x-ms-office365-filtering-correlation-id: 104b6865-401a-47bf-0fa2-08dce74152c9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVJjNzByTkMyeXBIKys5NkRGdG40VzF3V24xUUlyaVdhakhwdmw4dXE4Q3N5?=
 =?utf-8?B?TlIxQWV0VFI1WVZpTUNPVWFMbkpoU3pKaVZIUWN3dm1DTEZHUjQzZk5XMXNB?=
 =?utf-8?B?ZE9MNVlnTnBha0tjWkQva09lejZ4cFRFOXJUYjM1SkRtZ1BMVzUwaXMwOHNQ?=
 =?utf-8?B?d1dWTDN5Q3c1aDFyb3BHRWljNEpnNzUwNXM4N3UyY0Q0bzNLWEkxWnkwZGdQ?=
 =?utf-8?B?aS9pVEEvU3BOUEt4Rk9zY21jQkJtaUhXLzRiSGhUL05EZUlydXZvMGZBb25o?=
 =?utf-8?B?aEpYQ3pGc0J2aXQrUjY0eGRCWmdjNHQwVUVYREcrcWdhSTdTZHFhaXphcmll?=
 =?utf-8?B?bUJCeSt1cFVwRWJmNzN0dk5LdHFhd3p0NXlGa2RoTnR2dW1wWnF5eDhUTi83?=
 =?utf-8?B?eExIWW5haG5vUTVvZmZtcnpBOEozNTU2Yk8xZDRFOU9Ca2laV3ppWGtPT1d2?=
 =?utf-8?B?WnpyZGZLaHRGRk1tY0xsMWRrMEJhczlkOEg4V2VSbEJGbGQvV3VYVmxld1Iw?=
 =?utf-8?B?cnBrUEUzUzMwZU5vVk1zNXBmMk4xRDlvRWpFcCtEUS8wVXNvYnVLb3B6R1Q5?=
 =?utf-8?B?R1hIRHh4VDh3OG5wSFZSZy9maStvVFhLZkxla2Q3NzhWTm45d2ZJdFlmQXRp?=
 =?utf-8?B?cE9Qd3FrVkExUHBSVHJ1NUxyRDJQN0EvbWprMmk3MVZvNk9pUHp2ci9QWTQw?=
 =?utf-8?B?L1kycDZDY3pjWEE4RDRNaDN4MFh1YVlrYlcvWmh4WFBUaWxKMnFtM0tPY29Q?=
 =?utf-8?B?RklUZ1dCeTB5R3cwd2phK1g0TTdYWDlFK1dyTW1jOUtRNCtaMXFEcGlQMWpZ?=
 =?utf-8?B?K1RiQVNJdmN1R2xtci8wUnpVeGR5c3JUVitqSGt4cUc0dkJQbWxZMDJUNjRt?=
 =?utf-8?B?RkcyRmowQWZ5UmRCRDVOdnVXdTY4dVhJNEVERVhibmovSGx6Ky8ySis3Z0x0?=
 =?utf-8?B?VmFPRkJBaVN3SmtXYVJYVmVQSkxRV0d3TGlGeXo4REdqWmJZMFhHZTZLbktu?=
 =?utf-8?B?SzZLWVJUNWZWN1QyNk5EZi85Z2gzMEcyRERRNlVIbVM0bnl6emtGaHFtUmx5?=
 =?utf-8?B?UEUwNlFyYXJydTZLY0dmakFjcHJZUWE4YStwUkU3U3RBclJHWkZmbURHWmxJ?=
 =?utf-8?B?dERZZkNHWDRCRlJyd0ZNbk9HdGlTMmpKci96a2pNV1Q3ZWRORDhXRUdlbVhj?=
 =?utf-8?B?cHgvd1owZWV5NTNGb29lUUR1aWdVWkxIRWVBUnEzVUgzbzRpL3lXRHJteHFK?=
 =?utf-8?B?Wm15MzNvRUFmWFBmQkdUM3RjaTVVTTlxYjdoSU1oWDdsZTQ5WGFYK3JGanlI?=
 =?utf-8?B?MHF6MzAybEJNRjJTZE1LVG5DZnRSWGVxS2RQZTFIUElOWGZlUkg2emJCckdq?=
 =?utf-8?B?M2R5bmpGV1hpMnJ6d1J3UUtRemliemJjL1MwQVZELzZ5ejRYL2tmY2RQVUk3?=
 =?utf-8?B?NU9ScHk1N3d1MzM1T21tYXBYVDZyT3oyQTlZRzJUQXZSRzBVMnMzUURMVW9U?=
 =?utf-8?B?REZqMDJPSHp6R3pDVVdUYUlCR1FMVGNkcU1uOGxzNy9BRHc4ZDM2SmxnWFlY?=
 =?utf-8?B?MFZIaWgwTVFTcFdudXdDL2VKYWZ2R2N3VEpERldsL2paZWZCakJPUS83NmFh?=
 =?utf-8?B?VXFyYmNCNWxidDhmK3hMcGR6Yzgyd1RxdVozREdTeExOUnVWL0JxMDRVNGdP?=
 =?utf-8?B?TWFZM0JHNVhRRnJnS2VWamtGZmlSVHhPMm5aNTE2Tm54QjhCalFZY1lBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVIrU0VpNDc1UmhVY2VHeFM1UkhIdlljZkMyMDNOU0xXNFhhYjJTTFJXbkdQ?=
 =?utf-8?B?WmJpNUl2U0h3bThnZC9UV0U0eVFRRWxwcTlraWV2RUVESGpWL3FsQWtTbXFT?=
 =?utf-8?B?MkI0SlN6NVZZQXdzc0tUYm56SDViMXNQb0hoK3hGKzBPcFlrd3VJY1hxeHpN?=
 =?utf-8?B?QmkxSGRQNHpreGl6V2J4bGQxZGgyZVk1RXNCVERhSlp1TlZNaUFZYiticDli?=
 =?utf-8?B?TzNtakUxanBnYVRqY1RETHNDcndJYks1UU9TbDE5M1dLV2R1dkMvTXdjNnB0?=
 =?utf-8?B?cjBuUXRtekNraGk3RjhxWGtLNXF4dG81VzdrNVUyb0x3dWVqaTQyZDJaMHpV?=
 =?utf-8?B?anR1Q2RTMHJodEZidjgvTm9mSnQybVI4T0srL2x4dE10YjFiZ1MxN2hUTldv?=
 =?utf-8?B?K0cySjBwR1VDLzBwWnVWMXpyakJpSVFiQU9FekwzZmQ5Y2JnSjJVajR5R0Vr?=
 =?utf-8?B?VU1EY2xnTlYxdDcrZUQ2bTFQYmo0aU5RRnR0anNvUUVBM2c0dkxJWE9QeUhv?=
 =?utf-8?B?Q2c2WE13b1BzdDFHd2d4a2VQQXFyOFBPcnNwWGUyRERRdENBZk00RzdrTWpI?=
 =?utf-8?B?THZiZ2M4SThDdklobnpWOUVuK1o0cHI1VGVKZ01JMFlTTC9HTjA3K29GRWN2?=
 =?utf-8?B?NnBES0FpTHJtaWRZMVhOaGZDbXc0WlZseE9vMllUUWdDZXB0ZlJWVndyc29j?=
 =?utf-8?B?VDlMUWE0UytzczhEQTdLc2FlbmIzVnZuNjc2Sy9HdDJjc3RMdmt3ejdxTXhB?=
 =?utf-8?B?ZGdza0dIVlFoVjU1Z0lBMEVEL2RSZWNFaFI0WFFtb0FHOE5OWnJOY1B1MDl4?=
 =?utf-8?B?RzVjSE54cW1DS09wNXZ2dlp0aW5TM2hFdVNLRCtVTmFjL3I3dGJJRHljNU9j?=
 =?utf-8?B?WFpIVURMa3R2UVR3Ny9EQzFFMkJDZHhPNU9DQTAvYUVpcm1hVk9MRUt5ejBV?=
 =?utf-8?B?a1RKYitOdW11eWZlckZwT3lkWDRFc0NZSjVnaUR6cDA0b0QwRVNPU0lISVAx?=
 =?utf-8?B?T2dPbmZFNFRROTZSV2ZTdkZ6RkRML24xOElHSHZ0amd4TVA2WU5CYjdTdGtY?=
 =?utf-8?B?a21RSlVKd0ZORkV6KzN1MkZ3K2JrOXVKTXZ4V0lwdTlBbmhzM2x4YTVMRDBz?=
 =?utf-8?B?TFAzanBQcnVnREZCWEFRTUYvY29WYlo1WGFXOW40ZzRGTzdiUXE5a0FtRFR1?=
 =?utf-8?B?cUR4N0JFcnNSQndrcUx1Uzl6bFgvZlhzMlJQRUtONkRvWDZGRWlNbHdzNEVL?=
 =?utf-8?B?NHRRM0RIbXBFZ1NOMDZtcnJjT3NhUWpOVHIzNGpHSExlUDlML2s5RklEUmg5?=
 =?utf-8?B?TkxMQjNaaldjSUx1b0IzRkJpQXNSMGk2WWtoZmZ0eUoxTWdRMGN4NGtsRWE3?=
 =?utf-8?B?UWJCM3llRXdDTjV3OERVbXdnY0wzclkrMlBjbkxBUjRkZk1IVHBBTkt2ZzZ5?=
 =?utf-8?B?K0tNUE4rcGM2czdKd2RYeWxEeDJxYXRJN2NwUGxkS0xSSVBoQ3FmaDJweklu?=
 =?utf-8?B?RSt0ZldFSG9ja3JhY0kzbzdGVTVVQTNzZFN6U2RrU2MvT2ZnZUtEZzA2MDNh?=
 =?utf-8?B?bldrTFRBRHAwTVVJYnJ6Z0ZtOXhabk5Kbm51OWhIVmNnK1JJQlBaREM2WW1Y?=
 =?utf-8?B?eVZhTWdYTEZBaXFXcERQVWY4dHdjQUR4cGx6QWk1WmhjeG1IUjl0ZmlLb3FC?=
 =?utf-8?B?YXliZDAvNW1zWUQ4NGl5b2VxemtWNGtiYnc0cy9iMGx3UWl1NHpiMmFCWU94?=
 =?utf-8?B?alYwVHoxQnRsSG5IcnNaaVpQTkhtYm0rU0JmYjhVaHkyc1h2RkxvdUJ1Y1JV?=
 =?utf-8?B?S2ZYdFlYUktINmJGNVRna0dhTnhJNmdWOVcvOU9GVjBRYVFMcmNoN1J2cHV2?=
 =?utf-8?B?UU8wOFlZTnBsM0lSYzdwQTlUbDBISFpyQmNXallBWmZpZm1oWlFxOVhMTHd3?=
 =?utf-8?B?VUowcTgwWWRaSjhONjRyY0xockg5a3hQUi9GSzR5TndTVm5DMGt1UXp3VVFt?=
 =?utf-8?B?NmpEQWRzeS9GMmg1MGJwVkxBVUp4dUtxeThOL1VYNzc4ZGRBN3JrWUppWlJa?=
 =?utf-8?B?MjFaTkpIMDVuWEhHVW1QUlZhZDBLYjV4bFk1eGQ1T3EzVGxDWkM1R2NrR2xM?=
 =?utf-8?Q?/tRxS5p6jA9VZtJ9Ji4L4Cl44?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104b6865-401a-47bf-0fa2-08dce74152c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 02:31:32.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNpiRq8UG+v8EWwD1Nz1q1GMJK+XIl1Q7pICtFRTyz8Ndflnal2+iDrK7SyCiITSvIH7S0kkxoP2MDSYvPn2yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgNCwgMjAyNCA1OjI2IEFN
DQo+IFRvOiBMaWFuZywgS2FuIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPg0KPiBDYzogTmFt
aHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVy
ekBpbmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBBcm5hbGRv
IENhcnZhbGhvDQo+IGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz47IEh1bnRlciwgQWRyaWFuIDxh
ZHJpYW4uaHVudGVyQGludGVsLmNvbT47DQo+IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxleGFuZGVy
LnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IERhcGVuZyBNaQ0KPiA8ZGFwZW5nMS5taUBsaW51
eC5pbnRlbC5jb20+OyBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFlvbmd3ZWkgTWEgPHlvbmd3ZWkubWFAaW50ZWwuY29t
PjsgTWksIERhcGVuZzENCj4gPGRhcGVuZzEubWlAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BhdGNoIHY1IDAvNl0gQnVnIGZpeGVzIG9uIHRvcGRvd24gZXZlbnRzIHJlb3JkZXJpbmcNCj4g
DQo+IE9uIFRodSwgT2N0IDMsIDIwMjQgYXQgMTI6NDXigK9QTSBMaWFuZywgS2FuIDxrYW4ubGlh
bmdAbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiBPbiAyMDI0LTEw
LTAzIDEyOjQ1IHAubS4sIE5hbWh5dW5nIEtpbSB3cm90ZToNCj4gPiA+Pj4gSWYgdGhlIGFsZ29y
aXRobXMgY2Fubm90IGJlIGNoYW5nZWQsIGNhbiB5b3UgcGxlYXNlIGdpdmUgc29tZQ0KPiA+ID4+
PiBzdWdnZXN0aW9ucywgZXNwZWNpYWxseSBmb3IgdGhlIHNhbXBsZSByZWFkIGZhaWx1cmU/DQo+
ID4gPj4gU28gdGhpcyBpcyBzeW1tZXRyaWM6DQo+ID4gPj4gYGBgDQo+ID4gPj4gaWYgKGFyY2hf
aXNfdG9wZG93bl9tZXRyaWNzKGxocykgJiYgIWFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKHJocykp
DQo+ID4gPj4gICByZXR1cm4gLTE7DQo+ID4gPj4gaWYgKCFhcmNoX2lzX3RvcGRvd25fbWV0cmlj
cyhsaHMpICYmIGFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKHJocykpDQo+ID4gPj4gICByZXR1cm4g
MTsNCj4gPiA+PiBgYGANCj4gPiA+PiBUaGF0IGlzIHdlcmUgbGhzIGFuZCByaHMgc3dhcHBlZCB0
aGVuIHlvdSdkIGdldCB0aGUgZXhwZWN0ZWQgY29tcGFyaXNvbg0KPiBvcmRlci4NCj4gPiA+PiBg
YGANCj4gPiA+PiBpZiAoYXJjaF9pc190b3Bkb3duX21ldHJpY3MobGhzKSAmJiAhYXJjaF9pc190
b3Bkb3duX21ldHJpY3MocmhzKQ0KPiA+ID4+ICYmDQo+ID4gPj4gbGhzLT5jb3JlLmxlYWRlciAh
PSByaHMtPmNvcmUubGVhZGVyKQ0KPiA+ID4+ICAgcmV0dXJuIC0xOw0KPiA+ID4+IGlmICghYXJj
aF9pc190b3Bkb3duX21ldHJpY3MobGhzKSAmJiBhcmNoX2lzX3RvcGRvd25fbWV0cmljcyhyaHMp
DQo+ID4gPj4gJiYNCj4gPiA+PiBsaHMtPmNvcmUubGVhZGVyICE9IHJocy0+Y29yZS5sZWFkZXIp
DQo+ID4gPj4gICByZXR1cm4gMTsNCj4gPiA+PiBgYGANCj4gPiA+PiBJcyBzeW1tZXRyaWMgYXMg
d2VsbC4NCj4gPiA+PiBgYGANCj4gPiA+PiBpZiAoYXJjaF9pc190b3Bkb3duX21ldHJpY3MobGhz
KSAmJiAhYXJjaF9pc190b3Bkb3duX21ldHJpY3MocmhzKSkNCj4gPiA+PiAgIHJldHVybiAtMTsN
Cj4gPiA+PiBpZiAoIWFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKGxocykgJiYgYXJjaF9pc190b3Bk
b3duX21ldHJpY3MocmhzKQ0KPiA+ID4+ICYmDQo+ID4gPj4gbGhzLT5jb3JlLmxlYWRlciAhPSBy
aHMtPmNvcmUubGVhZGVyKQ0KPiA+ID4+ICAgcmV0dXJuIDE7DQo+ID4gPj4gYGBgDQo+ID4gPj4g
KHdoYXQgdGhpcyBwYXRjaCBkb2VzKSBpcyBub3Qgc3ltbWV0cmljIGFzIHRoZSBncm91cCBsZWFk
ZXIgaW1wYWN0cw0KPiA+ID4+IHRoZSBncmVhdGVyLXRoYW4gY2FzZSBidXQgbm90IHRoZSBsZXNz
LXRoYW4gY2FzZS4NCj4gPiA+Pg0KPiA+ID4+IEl0IGlzIG5vdCB1bmNvbW1vbiB0byBzZWUgaW4g
YSBzb3J0IGZ1bmN0aW9uOg0KPiA+ID4+IGBgYA0KPiA+ID4+IGlmIChjbXAoYSwgYikgPD0gMCkg
ew0KPiA+ID4+ICAgYXNzZXJ0KGNtcChiLGEpID49IDAgJiYgImNoZWNrIGZvciB1bnN0YWJsZS9i
cm9rZW4gY29tcGFyZQ0KPiA+ID4+IGZ1bmN0aW9ucyIpOyBgYGANCj4gPiA+IEkgc2VlLiAgU28g
YXJlIHlvdSBwcm9wb3NpbmcgdGhpcz8NCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
cGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+ID4gPiBiL3Rvb2xzL3BlcmYvYXJjaC94ODYv
dXRpbC9ldmxpc3QuYw0KPiA+ID4gaW5kZXggNDM4ZTQ2MzlmYTg5MjMwNC4uNDY4ODRmYTE3ZmU2
NThhNiAxMDA2NDQNCj4gPiA+IC0tLSBhL3Rvb2xzL3BlcmYvYXJjaC94ODYvdXRpbC9ldmxpc3Qu
Yw0KPiA+ID4gKysrIGIvdG9vbHMvcGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+ID4gPiBA
QCAtNzAsNyArNzAsOCBAQCBpbnQgYXJjaF9ldmxpc3RfX2NtcChjb25zdCBzdHJ1Y3QgZXZzZWwg
KmxocywgY29uc3QNCj4gc3RydWN0IGV2c2VsICpyaHMpDQo+ID4gPiAgICAgICAgICAgICAgICAg
aWYgKGFyY2hfaXNfdG9wZG93bl9zbG90cyhyaHMpKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIDE7DQo+ID4gPiAgICAgICAgICAgICAgICAgLyogRm9sbG93ZWQgYnkgdG9w
ZG93biBldmVudHMuICovDQo+ID4gPiAtICAgICAgICAgICAgICAgaWYgKGFyY2hfaXNfdG9wZG93
bl9tZXRyaWNzKGxocykNCj4gJiYgIWFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKHJocykpDQo+ID4g
PiArICAgICAgICAgICAgICAgaWYgKGFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKGxocykNCj4gJiYg
IWFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKHJocykgJiYNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgbGhzLT5jb3JlLmxlYWRlciAhPSByaHMtPmNvcmUubGVhZGVyKQ0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiA+ID4gICAgICAgICAgICAgICAgIC8qDQo+ID4g
PiAgICAgICAgICAgICAgICAgICogTW92ZSB0b3Bkb3duIGV2ZW50cyBmb3J3YXJkIG9ubHkgd2hl
biB0b3Bkb3duDQo+ID4gPiBldmVudHMNCj4gPiA+DQo+ID4gPiBEYXBlbmcgYW5kIEthbiwgY2Fu
IHlvdSB2ZXJpZnkgaWYgaXQncyBvaz8gIE15IHF1aWNrIHRlc3RzIGxvb2sgb2suDQo+ID4NCj4g
PiBJIHZlcmlmaWVkIHRoZSBhYm92ZSBjaGFuZ2UuIEl0IHdvcmtzIHdlbGwuDQo+ID4NCj4gPiBU
ZXN0ZWQtYnk6IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IERh
cGVuZydzIGNvbW1lbnQgc2hvdWxkIGNvdmVyIHJlcGxhY2UgdGhlIGNvbW1lbnQgLyogRm9sbG93
ZWQgYnkgdG9wZG93bg0KPiBldmVudHMuICovIGJ1dCB0aGVyZSBhcmUgb3RoZXIgdGhpbmdzIGFt
aXNzLiBJJ20gdGhpbmtpbmcgb2Ygc29tZXRoaW5nIGxpa2U6DQoNClRoYW5rcy4gSSB3b3VsZCBj
aGFuZ2UgdGhlIGNvbW1lbnRzLg0KDQo+ICJzbG90cyxjeWNsZXMse2luc3RydWN0aW9ucyx0b3Bk
b3duLWJlLWJvdW5kfSIgdGhlIHRvcGRvd24tYmUtYm91bmQgc2hvdWxkIGdldA0KPiBzb3J0ZWQg
YW5kIGdyb3VwZWQgd2l0aCBzbG90cywgYnV0IGN5Y2xlcyBhbmQgaW5zdHJ1Y3Rpb25zIGhhdmUg
bm8gcmVhc29uIHRvIGJlDQo+IHJlb3JkZXJlZCwgc28gZG8gd2UgZW5kIHVwIHdpdGggc2xvdHMs
IGluc3RydWN0aW9ucyBhbmQgdG9wZG93bi1iZS1ib3VuZCBiZWluZw0KPiBncm91cGVkIHdpdGgg
Y3ljbGVzIHNpdHRpbmcgdW5ncm91cGVkIGluIHRoZSBtaWRkbGUgb2YgdGhlIGV2bGlzdD8gSSBi
ZWxpZXZlIHRoZXJlDQo+IGFyZSBhc3N1bXB0aW9ucyB0aGF0IGdyb3VwZWQgZXZzZWxzIGFyZSBh
ZGphY2VudCBpbiB0aGUgZXZsaXN0LCBub3QgbGVhc3QNCj4gaW46DQo+IGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3BlcmYvcGVyZi10b29scy0NCj4gbmV4
dC5naXQvdHJlZS90b29scy9wZXJmL3V0aWwvcGFyc2UtZXZlbnRzLmM/aD1wZXJmLXRvb2xzLW5l
eHQjbjIxMDYNCj4gRG9lcyBjeWNsZXMgaW5zdHJ1Y3Rpb25zIGVuZCB1cCBiZWluZyBicm9rZW4g
b3V0IG9mIGEgZ3JvdXAgaW4gdGhpcyBjYXNlPyBXaGljaA0KPiBmZWVscyBsaWtlIHRoZSBjYXNl
IHRoZSBjb2RlIHdhcyB0cnlpbmcgdG8gYXZvaWQuDQo+IA0KPiBUaGFua3MsDQo+IElhbg0K
