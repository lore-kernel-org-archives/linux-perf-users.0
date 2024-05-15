Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CD38DE9;
	Wed, 15 May 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715793302; cv=fail; b=IJC5F0OmDYtad2FPge7eN73ZwY/jjGg6d1IlfdqglX2wisi8BtMeRu13xCII2pYywMk6KnY7CDMzs7UcHHe/agnKiFBMMyos9cYJ2S+rRnegB4vPqiCByPF+lhGTaxd+EMIoTNc8UcSmv8fMxRNDOe8Lk9wg5pzdTyIgtXGe4+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715793302; c=relaxed/simple;
	bh=xsTb4+oG872X5jNdiTtwT0s6y3iJICQFvmhIs1LrybE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QARJys2N4OsV8DPzNDkWoo1NoxC8GVOIKb6+D7sTdAofTbYEy3iDatZotTjSQrHR7eSC3YhBBP/pB99wPZzp6u1erWgSnAQyCGTTxnLaw7gu6DpOfKCiErIgBgAkd2cQazRv3UiRNL4SC6NhxTya5MR/sMIJBZxlosihEaDr9Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ahw0/ECI; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ahw0/ECI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715793300; x=1747329300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xsTb4+oG872X5jNdiTtwT0s6y3iJICQFvmhIs1LrybE=;
  b=Ahw0/ECIcIJPnmS0ZAq/VqoO3USlixOk6NMsA5WC81pI+FF7Kiy5Od/z
   DGrC5hPM4qY02MamMpps73jVJV+ZdGceLiTpXgXHiRXa149DxCREQvTrh
   53HN2vV0lT0hdRV8zTMHSvsjFeQaEnehLeBhWBhjXtO3wzE+jsu+HMP/+
   is8GSzsH4XWjegJewc45zgW93QHdZPyqEAFVEYCyUcQ00wi4SzsjP9uFy
   mBhvwipe/8mb2eFVKJHLEhOisEZMU49ayrgwMp8XLaYRsM965fZ6mjFvA
   /Ij6AzubbLk/E1hP5h8pJwqkS2JLYo/NhQHJMqcWqnJ93vFPA1hWTAnlm
   w==;
X-CSE-ConnectionGUID: 1TlXE1SDRDq/yyvyy94VGw==
X-CSE-MsgGUID: i4sfmJ8sRmKqEXNn2yP/TQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="14813446"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="14813446"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 10:14:54 -0700
X-CSE-ConnectionGUID: wKrENIYyROWtKsDKW8rQZA==
X-CSE-MsgGUID: Ll0ZaXHfTNyBX0rS56JydA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="35586628"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 10:14:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 10:14:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 15 May 2024 10:14:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 10:14:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 10:14:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPHRY6Xiu7D22R0Z4Q/BXVTju6hWOh9bhm2JywKK00slx53IEHjYD9dHwcu86OekiqQ+e5zVcZ47Cq6ZHk1L64sQixGTLS6bjEsQVyZiVVLSvS8NMawhpGCUqnrGP/PUfxnwtIWWrkrDeOHDCf83WYihK7TkaiADU1vQCJ68dIiHiALDmnShbvZ1w8FZO0bGBGckRBh/CV1EvGRo2mS2NQW0rYeZp5zA7O5Md6MsnTlJLqWZy2HMp3M7Qd1F2phAbuDiJonCozafbGm8X64Lm9mH3XTl7zYLp7qOTGQQXw2iW8TDhF/3h2MSFQWjDDTZFHgnKAFi2Bm/UNNjH5OAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsTb4+oG872X5jNdiTtwT0s6y3iJICQFvmhIs1LrybE=;
 b=f9XKr4GuA1WcSJDua32Z43sTM2AKd02Gs47Y7/gGoko+9AEVLCy02a7UEnq1hZBRstAT52lA0EiWDyj8CRwvTGnSeejkaraKSXgUrLEpQvDRuhQjbB7Ltu08O3bBfL6fj+tY+ME/iV91m4cOZNd+axo/S4Ub3DaPeUap2dYswhjL/Zhfy+Vl0lz8PkPui9LRFmx8TgXia9HTfCx/jL5jyKLSX2WMq9LY5aAo7VGfurWyF9UbBwjovAcgnAfaPZH4fn9A2cfSAaAmj6iyGQ+IxUji8MM+N7CDYCeFo/k5+RuBTnpo+YTK+Q17Z7uVB7HObYpfy7IvSk97YiBfD1ixvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 17:14:28 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 17:14:28 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v6 2/5] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHagg0bJu1HXMAx+EKTfolw5tlMzLFT6nUAgAADChCAIpCggIAAE36ggAAP1wCAAStEAIAAH34AgCAmeLCAAAVagIAAumWg
Date: Wed, 15 May 2024 17:14:28 +0000
Message-ID: <CO6PR11MB5635E723DAAA5E94880396BAEEEC2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-3-weilin.wang@intel.com>
 <CAM9d7cjBfTM2bjkrvN5XWcXJ=OyBOU06fBN=+eWnDSdP2dkD4A@mail.gmail.com>
 <CO6PR11MB56351C2AB4BE15C5371E29C2EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjORNS9h7v6p2fg8OXsZMpeBODzTSCQNZ5zAea-baFKNQ@mail.gmail.com>
 <CO6PR11MB5635C7D8C91FEDA17EC4BCDEEE112@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSCQViX=VjgqdVn5un0J5MpGsGDGncUyY-K4=oPvvfQA@mail.gmail.com>
 <CO6PR11MB56359754A01778EA3EA53981EE102@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cj2Zmd_FMBzf=H6K6jRmYLYuR6mpcyhC0_neTvur0=pyw@mail.gmail.com>
 <CO6PR11MB5635CC88D0855FA485C383A9EEEC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAP-5=fV_mco8cf4yf0VUTGnpNUmQx-VA0S8TpbekAa83c3u5WQ@mail.gmail.com>
In-Reply-To: <CAP-5=fV_mco8cf4yf0VUTGnpNUmQx-VA0S8TpbekAa83c3u5WQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SJ2PR11MB7475:EE_
x-ms-office365-filtering-correlation-id: 89989f9b-ca56-4ddf-450e-08dc75027a7c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?c0RzdTBXcGFyS1hoQjQ4Y2xYZ3dXbnlUd1VmZ0R4RXI1Z2NHdllQc3NaMGhx?=
 =?utf-8?B?TDczNG9FQ3gvK2pBYnBNTGhjK2hLczk5UUtWeGRrT3JZcDJub3FDZHVpRDVN?=
 =?utf-8?B?T1M0Z05QRFlrWExDUHBCazN3MStHZVpwMVVhMTNacS9qNGU1bXM0cm5qMldJ?=
 =?utf-8?B?c09QeUFvSk1HZGxGZVIwRmNqSHQyQndsdHg2K0FMSy9FNDhlRVZ3amNJZFV6?=
 =?utf-8?B?a3ZMTHhsRC95RisvLzlJblJHbUdHUU5zckRrdmhDeC9rTEpiNjJKb0xKdWRQ?=
 =?utf-8?B?Z3VGWDc5S3BiY3VHRXpaMkt4YUtEbVMvNGdERmNFZURqRzkxTkluVmhjNWkz?=
 =?utf-8?B?VEkwbnhUUWVocEdocWdhMDhFWXd5b3p2ajB4dHZpN3JWbnRpOUFHdXhsbENX?=
 =?utf-8?B?WDVTM3BuSUwvU3ZodndsdDJ6RGIyRytBcTMwdUkxaDkrcklCbkw2NWpHRTRs?=
 =?utf-8?B?NCtxWUlHRVYrWWRzVXU0UlZtdE9jTm1haTdwbWZlM1dlbm1Kai9IZTdDVks0?=
 =?utf-8?B?VFdoZ0ZhK1EwRmc0TzZaNktQUVZRZU95b3p5aHJ2RGU1WTVyQlFod0RxRlJu?=
 =?utf-8?B?dUVGTnBUU0xrYzVNcWlndy9iODU3ZXVmZ0VKTmJkSE1reTFvN0VqdHhNT1B3?=
 =?utf-8?B?S1NwRmlpbDEyMVVGcnFFSk8xVk5zSVRmNVdidzd0eGkzZWV3MjdQVEZkSktX?=
 =?utf-8?B?SllBZk50UmJYOGlEcmZFTFhydVhxK0RRL0ZSaGxzYUN0bXB4eFJkRVEwT1pM?=
 =?utf-8?B?MWZGMStqbHN1eFhPblZBSmhIYmtHWi83Tk1JcWp0TFdtUm9GWGRFZXE0eXdL?=
 =?utf-8?B?T1Y1WTJUNktGU0pkTWovVHFWWVhXZmtkY2NJSWdDS1lpN1pKMXROcml6ejll?=
 =?utf-8?B?QXhwRmVTV0paMDVhZEJFbjJ4YkViQU9PVFdTUDRHcXk5TWtWTGozcXllVnU4?=
 =?utf-8?B?Ylg5Zkx0RnJCVi9WYXNzbFdrWjFXL002YmlURzRmeEVhaE9aSjd6NllzMVZz?=
 =?utf-8?B?SWg0RUdSejdndllhSWE2T0s4SHNRRUN1R3NHMDRqNHR1elc5KzBtS0FnejAv?=
 =?utf-8?B?OWw2WVk4S2xVd1VLdFR4eTdtbVZRaS8zeG1GYmZZZjIzZzJNKzJ1Yllvd1dh?=
 =?utf-8?B?SjRTcmRkbUQzSm1wcVZsTHRQUi90VEpZRjdMNEVQd2dVTlJsbVJEZzZKb3hF?=
 =?utf-8?B?dXdjOTU0T2E2T0ZDTk8yRG9Jc092aXlLM2hZbi9xZ1RlTCsyS2FZdDV0SVVR?=
 =?utf-8?B?OUJWWk9CVjRrV1lCTGFVY0VzZnR2UmRsL0xpSnJRQTlnVTByeVdrVy9ROWdN?=
 =?utf-8?B?eTNHZEdDYWcrRWQ4enBlVkZzendpa2JRaWMyelowV2gwMWROejE1Y0RLUVhl?=
 =?utf-8?B?WmJwVU1lc3VueUcvaHFYK3lLTWc1VFR0aUtkSW14bEdmbWhqTS9oOFk1S1pl?=
 =?utf-8?B?RzhJZkU0WHFac2FxNXY5S0dUVklqTmpncXJKaVh0M2VNd0JJU1VOY3pYNzZY?=
 =?utf-8?B?SXByRFdWcnFWbUtMS2hrUWsrUHZVdENET2kwT3lnUEVTUFU3MmpBU1NGV0E0?=
 =?utf-8?B?M1lremNCZjZuZTcvYTBIWnZkSlBDU0gxdjl6UzF5eVlhdFIzb203SmYrVUVN?=
 =?utf-8?B?bzVscFYvbHoxTVpPZFZ2RVdnT3ByblI5N0QyR29oL2RkZVIrdE0xakQzVk8y?=
 =?utf-8?B?MCtUQ2VBa2xqekUyMnYxVnB2UWJTL01HQ1JwQzFNUFlaUEVJdmJwU3hRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajFQVmFkMWlWWEduRE5PY1pZbFlLWHFpRXNDUUJuenF3ZlBxSjhML0x5Mnda?=
 =?utf-8?B?S0tVQ2RZa0ZXYTVkeS9aMmMrbmJNVEhlY2ZIOTVrbWtjU054ckJzZjAwUWhZ?=
 =?utf-8?B?aEttT3FoSTNwVGx3R1ZpSksreEN3dTNNTmlvZmovTksvd05qa1hIalFPZDIy?=
 =?utf-8?B?VHFyVitBUUpDZ2U1NWZ0c3BPTjc4U1ViblNMNjVsNUllbjlyS2F1ZUEzRE9U?=
 =?utf-8?B?amRsc2RUemRZVmdtUFZBTU5nMktrQmRpVnFhRUtpNzRKZDFEWWZpWElKeTJu?=
 =?utf-8?B?MXJsYzZOejhpTVV3MjA4NHNmM2dNOU9tK0VRbnFrc1U0eU1uemZuZFMxdmM4?=
 =?utf-8?B?ckgybGxkWTc3NlFMYkFINk1KZFF6ODc1eGxOZGlvZmVtdzJ0RlluQWROVE1D?=
 =?utf-8?B?N1U4ZmRweGw4NzVOTXBMR0F2VkwwdU1oZWRBMzQveHZsTnNBYlNMTFB4bDd4?=
 =?utf-8?B?MUFzUys5RWlVWnVpeGpid0Q0b2Q5TjErKzVEQVNXdmk1WUw5dnFxbCtIMUVr?=
 =?utf-8?B?VmxUTFpaWUh6Q0VTKzBqc2tWek0zM3pMV0gra3NKQjBIb3QweG0wWGNyK1BF?=
 =?utf-8?B?SWRDYVFkWE9TUEx2RG4vRitZTWJpM1EzeXdiZldkZUttckQxalRmVkkvNGJl?=
 =?utf-8?B?SHBYR214MGFEalk0OHBSZDN3TlQybmNvMCtlOGhmaGhNMEZ3bXF1TUlhelpw?=
 =?utf-8?B?eDNmS1NOYUUwVTRhWU5HTlhpZThFQ1dmOFUwbDkvdTRvOGQ2dUlEK3NNRWl1?=
 =?utf-8?B?amFVaUxndDRqcFF1aGwyVGp4elJPSENNTWVYS3dvREhFUlFVTVI3OVNuazZm?=
 =?utf-8?B?Qms0STNZc2ZNNkgwd0ttTHM2bWIwOVovNDNJa0xLU0NqU3lrejBhOFNPK2tM?=
 =?utf-8?B?b1lGVG1UVDVHaVZlbTJsS3ZiQXAxcFlCSDdLOGJ3NTVYc1VmSzVIdFFOa3pN?=
 =?utf-8?B?NkRVZnZ5djQ5ZUxFQko5YVlMTU9xQ0Y3WTJpOVVXanhxemVaVTliWXkreWpa?=
 =?utf-8?B?WkluZWRpZmRlZHlZcVR2R00xOGx1K1dJKzBzWEN3clkvNW84MHdGbTNuVmpv?=
 =?utf-8?B?amkwcHFOTVVSSWxIRDBjSk41d2I2VFk3TU5tc2VtUWdMNzVHclNQYllKMXR4?=
 =?utf-8?B?MTI1VGYyRUNLZ0swWGswZXhnRGtLbmlXcmxpWk50TEg1M3VlbjZzcTlFaUdW?=
 =?utf-8?B?dnJkMGtKZWJMbWVtRTlEdExYNVdBc0MzK2VIeC8wbXlKQTFVZ1REWjZpTnlF?=
 =?utf-8?B?RmoyRTFpRHl6Y3VzN2Z1QUNwR2tneTU3TG44VERqc0N4ZVVqV0JhVTlsUVA3?=
 =?utf-8?B?NG1ES0h5KytNdUlMbmR3aWNsaUtQRllWbDdjWmhPb2Fyb01sbGYwQkNkVlpn?=
 =?utf-8?B?Wk1qTHRrYjZ2VFhaWkN0UFZOWDdZUUFFeWlhWndFY3ZERk9NWURkQlNlYys3?=
 =?utf-8?B?U1ZHRmg1TnpnZXdiclhVZVFoeC9PVE9aN2hFeUhMM2F1aTJiQmVMRUpIVTlL?=
 =?utf-8?B?L3pLUWM1MlcrNkU3aFZSdUdjdWoyejFWWUdtSmVKZFhBZTMvMUJtc3d2T3RI?=
 =?utf-8?B?bFN0eC9vcTVUZmZ4d1FyMXIrMzFDbHVzV3czREcrVlphVnZFU1Rkb0JGVG1a?=
 =?utf-8?B?L3hDNC81SGJpRG9UQjQ4dFVBVWVaTWsxb2liWTBCUnJ4RldnSGYxcWZ1MUNz?=
 =?utf-8?B?alZidnV3bFd6OVNoaEljU2dlRGt1SWl0ckJLRmpEQ1N5dk14N01YbVRkN2lV?=
 =?utf-8?B?dVFkcVo5STNWcWdBbEp2K2xQNXVDSytZTHpObnhHQzJjQnYxRU96VitIN3lP?=
 =?utf-8?B?NzRMMEp0dW9KejE3SzlLQ2ZxQXhCRGY2dGNGTlRXRHFHcUppRE83WVhuUFQx?=
 =?utf-8?B?TTdMbXdhUWhyc0syTWFheU1KSXJ5K2NxcWVFRlRzWGNvMURXKzRUdEpKdnVR?=
 =?utf-8?B?a3ZzOXBlUVU2MVMxWWxXc01XczJnTWVRU1prRVVMVW0xYW5EUTg4KzNjVnQ5?=
 =?utf-8?B?ZGk4eG94bnJ0RHc4Z0d5MjBhV091eTBFNktKRVVka2FnRHRUTlpJTFJqSkZz?=
 =?utf-8?B?ZEJBRDNiS2VNNVh3QnBmTzl0R2Q5U2gzL2kxemxwUEFmNWRXemU2RTdMdzJT?=
 =?utf-8?Q?JJyTKuBcpt/xkTwIGjVJ/bmcF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89989f9b-ca56-4ddf-450e-08dc75027a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 17:14:28.4603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjnNaI8rFtxXAeB3T13o7SnINvuwN9Gw/OQsCykNJ+CKX84yw4awKptavStFra8d+qpr0jVfhhiGtPMkqLOw6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTQsIDIwMjQgMTE6MDcgUE0N
Cj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzogTmFtaHl1
bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+
IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FA
a2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYtdXNl
cnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3Is
IFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50
aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjYgMi81XSBwZXJmIHN0YXQ6IEZvcmsg
YW5kIGxhdW5jaCBwZXJmIHJlY29yZCB3aGVuDQo+IHBlcmYgc3RhdCBuZWVkcyB0byBnZXQgcmV0
aXJlIGxhdGVuY3kgdmFsdWUgZm9yIGEgbWV0cmljLg0KPiANCj4gT24gVHVlLCBNYXkgMTQsIDIw
MjQgYXQgMTA6NTfigK9QTSBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+ID4gRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiA+ID4gU2Vu
dDogV2VkbmVzZGF5LCBBcHJpbCAyNCwgMjAyNCAxMTo1MCBBTQ0KPiA+ID4gVG86IFdhbmcsIFdl
aWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IElhbiBSb2dlcnMgPGlyb2dl
cnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA+ID4gPGFjbWVAa2Vy
bmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9s
bmFyDQo+ID4gPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0KPiA+ID4g
PGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtl
cm5lbC5vcmc+OyBIdW50ZXIsDQo+ID4gPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
PjsgS2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gPiA+IGxpbnV4LXBl
cmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBU
YXlsb3IsDQo+IFBlcnJ5DQo+ID4gPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2Ft
YW50aGEgPHNhbWFudGhhLmFsdEBpbnRlbC5jb20+Ow0KPiBCaWdnZXJzLA0KPiA+ID4gQ2FsZWIg
PGNhbGViLmJpZ2dlcnNAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
djYgMi81XSBwZXJmIHN0YXQ6IEZvcmsgYW5kIGxhdW5jaCBwZXJmIHJlY29yZA0KPiB3aGVuDQo+
ID4gPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJldGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1l
dHJpYy4NCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEFwciAyNCwgMjAyNCBhdCAxMDowOOKAr0FNIFdh
bmcsIFdlaWxpbg0KPiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+ID4gPiBGcm9tOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQo+
ID4gPiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMjMsIDIwMjQgNDowNiBQTQ0KPiA+ID4gPiA+
IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPiA+ID4gPiBDYzog
SWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
DQo+ID4gPiA+ID4gPGFjbWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47IEluZ28NCj4gTW9sbmFyDQo+ID4gPiA+ID4gPG1pbmdvQHJlZGhhdC5jb20+
OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4gPiA+ID4gPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4
LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz47DQo+IEh1bnRlciwNCj4g
PiA+ID4gPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgS2FuIExpYW5nDQo+IDxr
YW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gPiA+ID4gPiBsaW51eC1wZXJmLXVzZXJzQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9yLA0KPiA+
ID4gUGVycnkNCj4gPiA+ID4gPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50
aGEgPHNhbWFudGhhLmFsdEBpbnRlbC5jb20+Ow0KPiA+ID4gQmlnZ2VycywNCj4gPiA+ID4gPiBD
YWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5jb20+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggdjYgMi81XSBwZXJmIHN0YXQ6IEZvcmsgYW5kIGxhdW5jaCBwZXJmIHJlY29yZA0K
PiA+ID4gd2hlbg0KPiA+ID4gPiA+IHBlcmYgc3RhdCBuZWVkcyB0byBnZXQgcmV0aXJlIGxhdGVu
Y3kgdmFsdWUgZm9yIGEgbWV0cmljLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVHVlLCBBcHIg
MjMsIDIwMjQgYXQgMzoxNuKAr1BNIFdhbmcsIFdlaWxpbg0KPiA8d2VpbGluLndhbmdAaW50ZWwu
Y29tPg0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+ID4gPiA+ID4gPiAtc3RhdGljIGludCBf
X3J1bl9wZXJmX3JlY29yZCh2b2lkKQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiArc3RhdGljIGludCBf
X3J1bl9wZXJmX3JlY29yZChjb25zdCBjaGFyICoqcmVjb3JkX2FyZ3YpDQo+ID4gPiA+ID4gPiA+
ID4gPiA+ICB7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgaW50IGkgPSAwOw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiArICAgICAgIHN0cnVjdCB0cGVic19ldmVudCAqZTsNCj4gPiA+ID4gPiA+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIHByX2RlYnVnKCJQcmVwYXJl
IHBlcmYgcmVjb3JkIGZvciByZXRpcmVfbGF0ZW5jeVxuIik7DQo+ID4gPiA+ID4gPiA+ID4gPiA+
ICsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gInBlcmYi
Ow0KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAicmVjb3Jk
IjsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1XIjsN
Cj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gIi0tc3ludGg9
bm8iOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
aWYgKHN0YXRfY29uZmlnLnVzZXJfcmVxdWVzdGVkX2NwdV9saXN0KSB7DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1DIjsNCj4gPiA+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJlY29yZF9hcmd2W2krK10gPQ0KPiBzdGF0X2Nv
bmZpZy51c2VyX3JlcXVlc3RlZF9jcHVfbGlzdDsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAg
ICB9DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICBp
ZiAoc3RhdF9jb25maWcuc3lzdGVtX3dpZGUpDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1hIjsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgIGlmICghc3RhdF9jb25maWcuc3lzdGVtX3dpZGUN
Cj4gPiA+ID4gPiA+ID4gJiYgIXN0YXRfY29uZmlnLnVzZXJfcmVxdWVzdGVkX2NwdV9saXN0KQ0K
PiA+ID4gPiA+ID4gPiA+ID4gew0KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAg
cHJfZXJyKCJSZXF1aXJlIC1hIG9yIC1DIG9wdGlvbiB0byBydW4gc2FtcGxpbmcuXG4iKTsNCj4g
PiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUNBTkNFTEVEOw0KPiA+
ID4gPiA+ID4gPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4g
PiA+ID4gPiA+ID4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkoZSwgJnN0YXRfY29uZmln
LnRwZWJzX2V2ZW50cywgbmQpIHsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
IHJlY29yZF9hcmd2W2krK10gPSAiLWUiOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9IGUtPm5hbWU7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsg
ICAgICAgfQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAg
ICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICItbyI7DQo+ID4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAg
cmVjb3JkX2FyZ3ZbaSsrXSA9IFBFUkZfREFUQTsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ID4gPiA+ID4gPiAg
fQ0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IFN0aWxsIEkgdGhpbmsgaXQn
cyB3ZWlyZCBpdCBoYXMgJ3BlcmYgcmVjb3JkJyBpbiBwZXJmIHN0YXQgKGRlc3BpdGUgdGhlDQo+
ID4gPiA+ID4gPiA+ID4gPiAncGVyZiBzdGF0IHJlY29yZCcpLiAgSWYgaXQncyBvbmx5IEludGVs
IHRoaW5nIGFuZCB3ZSBkb24ndCBoYXZlIGEgcGxhbg0KPiA+ID4gPiA+ID4gPiA+ID4gdG8gZG8g
dGhlIHNhbWUgb24gb3RoZXIgYXJjaGVzLCB3ZSBjYW4gbW92ZSBpdCB0byB0aGUgYXJjaA0KPiA+
ID4gPiA+ID4gPiA+ID4gZGlyZWN0b3J5IGFuZCBrZWVwIHRoZSBwZXJmIHN0YXQgY29kZSBzaW1w
bGUuDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBJJ20gbm90IHN1cmUgd2hhdCBp
cyB0aGUgcHJvcGVyIHdheSB0byBzb2x2ZSB0aGlzLiBBbmQgSWFuDQo+IG1lbnRpb25lZA0KPiA+
ID4gPiA+ID4gPiA+IHRoYXQgcHV0IGNvZGUgaW4gYXJjaCBkaXJlY3RvcnkgY291bGQgcG90ZW50
aWFsbHkgY2F1c2Ugb3RoZXIgYnVncy4NCj4gPiA+ID4gPiA+ID4gPiBTbyBJJ20gd29uZGVyaW5n
IGlmIHdlIGNvdWxkIGtlZXAgdGhpcyBjb2RlIGhlcmUgZm9yIG5vdy4gSSBjb3VsZA0KPiA+ID4g
d29yaw0KPiA+ID4gPiA+ID4gPiA+IG9uIGl0IGxhdGVyIGlmIHdlIGZvdW5kIGl0J3MgYmV0dGVy
IHRvIGJlIGluIGFyY2ggZGlyZWN0b3J5Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBN
YXliZSBzb21ld2hlcmUgaW4gdGhlIHV0aWwvIGFuZCBrZWVwIHRoZSBtYWluIGNvZGUgbWluaW1h
bC4NCj4gPiA+ID4gPiA+ID4gSUlVQyBpdCdzIG9ubHkgZm9yIHZlcnkgcmVjZW50IChvciB1cGNv
bWluZz8pIEludGVsIENQVXMgYW5kIHdlDQo+ID4gPiA+ID4gPiA+IGRvbid0IGhhdmUgdGVzdHMg
KGhvcGVmdWxseSBjYW4gcnVuIG9uIG90aGVyIGFyY2gvQ1BVcykuDQo+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IFNvIEkgZG9uJ3QgdGhpbmsgaGF2aW5nIGl0IGhlcmUgd291bGQgaGVscCBm
aXhpbmcgcG90ZW50aWFsIGJ1Z3MuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRG8geW91IG1l
YW4gYnkgY3JlYXRpbmcgYSBuZXcgZmlsZSBpbiB1dGlsLyB0byBob2xkIHRoaXMgY29kZT8NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IFllYWgsIG1heWJlIHV0aWwvaW50ZWwtdHBlYnMuYyAoaWYgaXQn
cyBiZXR0ZXIgdGhhbiBhcmNoL3g4Ni8uLi4pID8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IFllcywgdGhpcyBmZWF0dXJlIGlzIGZvciB2ZXJ5IHJlY2VudCBJbnRlbCBDUFVz
LiBJdCBzaG91bGQgb25seSBiZQ0KPiB0cmlnZ2VyZWQgaWYNCj4gPiA+ID4gPiA+IGEgbWV0cmlj
IHVzZXMgZXZlbnQocykgdGhhdCBoYXMgdGhlIFIgbW9kaWZpZXIgaW4gdGhlIGZvcm11bGEuDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBDYW4gd2UgaGF2ZSBhIHRlc3Qgd2l0aCBhIGZha2UgbWV0cmlj
IHNvIHRoYXQgd2UgY2FuIHRlc3QNCj4gPiA+ID4gPiB0aGUgY29kZSBvbiBub24tKG9yIG9sZC0p
SW50ZWwgbWFjaGluZXM/DQo+ID4gPiA+DQo+ID4gPiA+IEFsbCB0aGUgZXhpc3RpbmcgbWV0cmlj
cyBpbiBub24tKG9yIG9sZC0pSW50ZWwgQ1BVcyBzaG91bGQgd29yayBhcyB1c3VhbC4NCj4gU28g
SQ0KPiA+ID4gdGhpbmsNCj4gPiA+ID4gZXhpc3RpbmcgbWV0cmljIHRlc3RzIHNob3VsZCB3b3Jr
IGZvciBpdC4NCj4gPiA+ID4NCj4gPiA+ID4gSWYgd2Ugd2FudCB0byBhZGQgYSBmYWtlIG1ldHJp
YyB1c2VzIHRoZSA6UiBtb2RpZmllciBmb3IgdGhvc2UgcGxhdGZvcm1zLA0KPiB0aGUNCj4gPiA+
IG1ldHJpYw0KPiA+ID4gPiBzaG91bGQgZWl0aGVyIGZhaWwgKGlmIHRoZSBmYWtlIG1ldHJpYyB1
c2VzIGFuIGV2ZW50IG5vdCBleGlzdCBvbiB0aGUgdGVzdA0KPiA+ID4gcGxhdGZvcm0pIG9yDQo+
ID4gPiA+IHJldHVybiBhbGwgMCByZXRpcmUgbGF0ZW5jeSBkYXRhLg0KPiA+ID4gPg0KPiA+ID4g
PiBTbywgSSdtIG5vdCBxdWl0ZSBzdXJlIHdoYXQgd2Ugd2FudCB0aGUgZmFrZSBtZXRyaWMgdG8g
dGVzdCBmb3IuIE1heWJlIHdlDQo+ID4gPiBjb3VsZA0KPiA+ID4gPiBjb250aW51ZSB1c2luZyBl
eGlzdGluZyBtZXRyaWMgdGVzdHMgdG8gZW5zdXJlIGFsbCB0aGUgZGVmaW5lZCBtZXRyaWNzIHdv
cmsNCj4gPiA+IGNvcnJlY3RseQ0KPiA+ID4gPiBpbiBlYWNoIG1hY2hpbmUgdW5kZXIgdGVzdD8N
Cj4gPiA+DQo+ID4gPiBJIHRoaW5rIGl0J3Mgb2sgdG8gcmV0dXJuIGFsbCAwIHJldGlyZSBsYXRl
bmN5IGZvciBmYWtlIHRQRUJTIG1ldHJpY3MuDQo+ID4gPiBJdCdzIGp1c3QgdG8gdmVyaWZ5IHRo
ZSBiYWNrZ3JvdW5kIHJlY29yZCArIHJlcG9ydCBsb2dpYyB3b3JrcyBvay4NCj4gPg0KPiA+IEhp
IE5hbWh5dW5nLA0KPiA+DQo+ID4gQWZ0ZXIgdGhpbmsgbW9yZSBhYm91dCBob3cgVFBFQlMgYW5k
IG1ldHJpY3Mgd29yaywgSSBmZWVsIHNob3VsZCBkaXNjdXNzDQo+IG1vcmUNCj4gPiBhYm91dCBk
ZWZpbmluZyBhIGZha2UgVFBFQlMgbWV0cmljIGluIHVuc3VwcG9ydGVkIHBsYXRmb3Jtcy4NCj4g
PiBJZiB3ZSdkIGxpa2UgYSBhZGQgZmFrZSBtZXRyaWNzLCB3aGVyZSBzaG91bGQgd2UgZGVmaW5l
IGFuZCBzdG9yZSB0aGVzZQ0KPiBtZXRyaWNzPw0KPiA+IFNob3VsZCB3ZSBhZGQgdGhpcyB0eXBl
IG9mIG1ldHJpY3MgZm9yIGV2ZXJ5IHBsYXRmb3JtPyBBbGwgdGhlIG9mZmljaWFsIG1ldHJpY3MN
Cj4gPiB3ZSBwdWJsaXNoIGFyZSBkZWZpbmVkIGJ5IGFyY2hpdGVjdCBhbmQgc3RvcmVkIGluIEpT
T04gZmlsZXMgdW5kZXIgc2VwYXJhdGUNCj4gPiBkaXJlY3RvcmllcyBmb3IgZWFjaCBwbGF0Zm9y
bS4gSSB0aGluayBpdCBpcyBub3QgYSBnb29kIGlkZWEgdG8gcGxhY2UgZmFrZSBtZXRyaWNzDQo+
ID4gdG9nZXRoZXIgd2l0aCByZWFsIG1ldHJpY3MuIENvdWxkIHlvdSBwbGVhc2UgbGV0IG1lIGtu
b3cgaWYgdGhlcmUgaXMgYW55IG90aGVyDQo+ID4gbWV0aG9kIHRvIGRlZmluZSBmYWtlIG1ldHJp
Y3MgZm9yIHRlc3Rpbmc/DQo+IA0KPiBXZSBkbyBwdXQgZmFrZSBldmVudHMvbWV0cmljcyBpbiB0
aGUgInRlc3QiIGFyY2g6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3BlcmYvcGVyZi10b29scy0NCj4gbmV4dC5naXQvdHJlZS90b29scy9wZXJmL3Bt
dS1ldmVudHMvYXJjaC90ZXN0L3Rlc3Rfc29jL2NwdS9tZXRyaWNzLmpzb24NCj4gDQo+IEl0IGlz
IHNvbWV0aGluZyBvZiBhIHBhaW4gYnJpbmdpbmcgdGhpbmdzIGhlcmUgb3ZlciB0byB0aGUNCj4g
Tk9fSkVWRU5UUz0xIChpZSBubyBweXRob24pIGVtcHR5LXBtdS1ldmVudHMuYyBmaWxlLiBJIGFn
cmVlIG9uIG5vdA0KPiB3YW50aW5nIHRvIHBvbGx1dGUgcmVhbCBtZXRyaWNzIHdpdGggdGVzdCBt
ZXRyaWNzLCB3ZSBjdXJyZW50bHkganVzdA0KPiB1c2UgdGhlIHRlc3QgbWV0cmljcyB0byBmYWtl
IHVwIHNvbWUgZXhwcmVzc2lvbiBwYXJzaW5nIHRlc3RzOg0KPiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZXJmL3BlcmYtdG9vbHMtDQo+IG5leHQuZ2l0
L3RyZWUvdG9vbHMvcGVyZi90ZXN0cy9wbXUtZXZlbnRzLmMjbjgxMQ0KPiANClRoYW5rcyBJYW4h
IEkgd2lsbCB3b3JrIG9uIHRoaXMuIA0KDQpCZXN0LA0KV2VpbGluDQoNCj4gVGhhbmtzLA0KPiBJ
YW4NCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFdlaWxpbg0KPiA+DQo+ID4gPg0KPiA+ID4gVGhhbmtz
LA0KPiA+ID4gTmFtaHl1bmcNCg==
