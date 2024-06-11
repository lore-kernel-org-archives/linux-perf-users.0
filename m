Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763455CDF0;
	Tue, 11 Jun 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128157; cv=fail; b=DqvYgvEzTV/pnkKq2DbWzuDFgz2bvS0DZv1IXwAX9S+k2n8VN0VCCqzzwmKwsiyuBgm9smPhRxoZ1FuR3uhO8LjbsGvg+mJzOrEN6LMnmSOwzgrFUmnvbPOIAAjkoSBbJvLTRcUk7X8S21VA5FE9xo8vWdXWE2pn0UeQIgar81o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128157; c=relaxed/simple;
	bh=vYpfMvMkcZIv/lMzhByC3GX0WwUy+RNV+r9YsT643w8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GnEh465itRrAj0ww+pzAUBHxcnLEK+9YYGuuG2cmAWV/hH+CJ78EGLvcyqON/xT+EtPSMe93NwfKvXiHqdrUbNHMLf5NB9gzq+YE38yP3N5fW9HXXwlCuKgcK4cVQZ03osIfN3K+wWyN41mjoe9QMqiLX2fVfGuVy1k9g4ckE/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIauXcNO; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIauXcNO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718128155; x=1749664155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vYpfMvMkcZIv/lMzhByC3GX0WwUy+RNV+r9YsT643w8=;
  b=GIauXcNO/kSg0JI7X0a1uxTo0fR7iDVVl/N27DjP+mdMAn2WECrxyZqH
   S2eTmjazhYumAzxgJCZIbgCXpuiatDjkibNlqe+pUFKHsBFDK+cqcnAxB
   N3r7EJrbJbfjyrOotxJ1cmvntz7TP2yKJ8SK11nwESU0tERGzbZFce/QI
   iemfTFxq2Ojh9xK2D141rZATlomR+JrEGQWEXMJUAjDhIATkXYZoUDzh4
   ZYgCijbIMnhO80RhKAeyFWrbLfxNSC9j6bBesqx+ukfpsES8F27J57h6K
   Hs+E/tcRatOToKhdaLx5jDGn3cqO694LL2lc1lJK1G3PllnWNEy9eTJEb
   w==;
X-CSE-ConnectionGUID: y8aGq3ApR0SaWnTCag4N1A==
X-CSE-MsgGUID: 7jDex0h/QKqRyQlXZmEnlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="26273841"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="26273841"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:49:14 -0700
X-CSE-ConnectionGUID: JU7te5eKQROpIx/cUQfr8Q==
X-CSE-MsgGUID: dpHN9X02SVu6Zhzkrs2zIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39571360"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 10:49:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 10:49:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 10:49:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 10:49:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 10:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfyeOXETXulOPc6MxKJeI54UjSsTIbSEyxrbupDK0VF3g2MV0yt/oZzRDvPAs+1iL91CulnRx2RQNzXNhLVPRXqUzAAGVXZ21LMCiTI7Zq/4iZSAdZ2u/xwltGPMjXjavkbnsh4XBQTrTpX/0GoRHcKO0ccj3IVDzGxpDk5BnOe31170q25sSGueVDD7X8i/VcHuwC7z7POVa3rqHJNgjn0tJVUrOQl8Wh19ehYz+4111+VQiNBNpz63MHCAFW/LvfWAM+pvBkaU5nC8HqX9Ou0OqC3zN/LUjxx0RWi8rKJFh+RwtbzhF9IrFxWtUOddOnO6cwccg2msPMWHK7IjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYpfMvMkcZIv/lMzhByC3GX0WwUy+RNV+r9YsT643w8=;
 b=PcVJEr7n00JWVG1gSetSeF3JJTpeG7Z7N2+Ju5L11QAebIQQ8u058eKrZiRfRY55q0X8rUe1ibSfg8nQDrT1+98CVI5csdESzZOLbessdxqFgG5Wqsa+z1Dt8vPqLLUG+FOtI425qvZPHCVP+ZKY1C8Su4S3xVdtE97VYTWGxURruroPqFGz+OqSP8KHR6h/Zqsnd9mgY7H7Y9O6xx1iOT+CNyktr7N6ofx8rIaBB5bGu96JtZdaf3IJN7c9lfz1Rc3shIAsCQ6vXN6HI3dFBdQdodMoz3v/IJn2AK8jBS8cJjHIrhcw4ln47Yw6Mg3CDGNrE0pQgkhMLm+ggRxPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 17:49:11 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 17:49:11 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v12 6/8] perf stat: Add command line option for
 enabling tpebs recording
Thread-Topic: [RFC PATCH v12 6/8] perf stat: Add command line option for
 enabling tpebs recording
Thread-Index: AQHau7+aOC3cYAEJDkWzRsCVj+441bHCx0iAgAAOaHA=
Date: Tue, 11 Jun 2024 17:49:10 +0000
Message-ID: <CO6PR11MB56353719739D822626369453EEC72@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240611052331.85715-1-weilin.wang@intel.com>
 <20240611052331.85715-7-weilin.wang@intel.com>
 <CAM9d7chQFeqCFJAfnRFKkQkxyRtOotF3kE49tL47EuEEBC_RkA@mail.gmail.com>
In-Reply-To: <CAM9d7chQFeqCFJAfnRFKkQkxyRtOotF3kE49tL47EuEEBC_RkA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: c5ed839f-9d4c-4221-56e7-08dc8a3eccde
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|7416006|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?WWJ2cEhQZU9peEo5ZzBLMVJxTU85dUVkUSsydHNaV3d3RWtXempSRGp0LzJU?=
 =?utf-8?B?eDVoeENxODIzellHTy96T2pZdkIvMWtZSzFhaXhCaE04blNGd2Q4dXRML2Zm?=
 =?utf-8?B?dGRycmdVYnlDZnlMUUtadEtXd0NOdU5wNEtlNUx1VVYzVElkV2Y0TkxzU05p?=
 =?utf-8?B?K1VtTUJ3NWs4Z2FhMTVuSldubW5KSStUUFNXeFV2SENQd1pzYVFoTHRQZ2xS?=
 =?utf-8?B?UWFhZ2M3SUViWWpnTzNWOE9rR0pEUEgyT3M2Ly9qM3lnVnFuV0NwekR4blUz?=
 =?utf-8?B?YkUrQXErQ2NvUko4d2c1SmIzRC91aXRsM2FBTUd4RDA4TlhLTzVIa2JxY1Np?=
 =?utf-8?B?TU9UcUwrcGNYcTJ1K2NrWDVpRlByM1B0ZGNMTTJOYm4vemdiUy8xdlNWaDdZ?=
 =?utf-8?B?V0pBTmFPeXpTZlRWQTBMQThGdk4zL1RjSGV6NWpJQzMvbGRacy80QVBycEhp?=
 =?utf-8?B?YjZUK0Y0R09QdzNFd28zbzQ5WEJ0dVU0RUhJZ0wzNnp6YlJMME1lc0FTMTJE?=
 =?utf-8?B?VVphT1M1N0kxU2lQZnh3eVd1cmZqc2J4aGdYMGNpa0hnQXJjWkNHTTBkZFZH?=
 =?utf-8?B?b2VMNUtHeWk0bWVHU05Fb0hmTnRQd0EwYlpUMW5aWjVSVjc5OUNBZTJ1RUdI?=
 =?utf-8?B?SUh2VkplUjB0eXErVlNtZjFXc0ZZMHVVR0ZzdnlMWnhzNi83MjY1NTBGVzB4?=
 =?utf-8?B?NjhjaXdxZlVEWGZkQ0pVZGgvVFZKOURjQnk1VFFLUjd3OWNUSnRzKytadENM?=
 =?utf-8?B?ZElzZVN0RUpVeiszdXNlWTA3T0RIOU4yd1g1ejVsT2hMUW9YTzNKT2xMT3FU?=
 =?utf-8?B?dlFVVjRoK0tGTm9FQ2FraitPQU01YjJuamRtRDg5TTk4Y285YWdrUGRWdmt2?=
 =?utf-8?B?SEk1eDg0Z0RHNUwweTA2OUxDNEFFdzBpQ3lzK1BqWTI0Q0lQRld2M3ZmTjEx?=
 =?utf-8?B?MUZLK092THI5WWNYVGtJcmNnaUY5bUdsWm9NMTlRZVpVSmo3clFpT3ZPcERo?=
 =?utf-8?B?NTBMRjZFYXVsUURhZGtaRDFySEM4Sithak03dEpIR2JCKzl4MVFWRkpqTDBl?=
 =?utf-8?B?bWRLV2FwVzZjQ1RjM3A4YXJEbXNNMTRTZDJjdmwxS0VpRTV3T1FJSVBtOEVU?=
 =?utf-8?B?cTZUOFJJUzVIYjZpOGpFNmlManZ6WXpndUJTUHZFSmtvTk01K1hLbWgrb1k3?=
 =?utf-8?B?SzRJb2JFUG95KzZscWY2blBMdXdvNUgrRTY2a0Q2QkZ5bmZmd0s2SEZMbnl5?=
 =?utf-8?B?ak1hekNJVHI5ZFE0VEZLZTcydG5mQnYwTVZVTzdBcEFSd3RJcGsyaTEycTlJ?=
 =?utf-8?B?bmgwVitMT2d4TTExMTFZVUR3NGxYZmU5SlVldUtLa09Vbzd4bmV3SnpqMmVP?=
 =?utf-8?B?SGxPUTlPTGxETW1ySmx1bUVQajFGZmcrYndqbEFZNjFJdmpSY1c4d1ZTZ2VJ?=
 =?utf-8?B?d1NKWnlTMVpCSi9OLzdNajFmSXVST3NTY0N3c2dZZkVCUG9XZjFLM1BEbmhF?=
 =?utf-8?B?OXRDQlREaTJOWk00dzR3MEs0R2trNzZUbFErc0pjSXpVMERTRVBEYm16TVgr?=
 =?utf-8?B?dnVlZ1pvTS8wSy9qZXA0dHJPaW95cHl1MVIxNUJwWlBIckhLUnRxdlJqb1dy?=
 =?utf-8?B?eTdwZVB3aE9XdXR4Q3VVOFBacDc0dzllVnVoOVNzdUtOOFlhaWFEdUxVWUJ0?=
 =?utf-8?B?cElFNThhbzNubVNwcWd4dUlhUFFoVHVkWkxKRXZ0WjdOR3B4aXhVUlRmNlpG?=
 =?utf-8?B?ZUo0SElkR1NCV043YzNQRFo2aE45ZkhOc3ZHc3VGa0hiRGVuK1JzZlJ5OWx1?=
 =?utf-8?Q?4+jlgNBV+4KDop2Y39XEvqxIXE9Lc6ABxlVbU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(7416006)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVpBa3dHb0hNTEcza0NLbk5LRFVEQzVkYW4vODJpbm5Mc3V0bGwwMmNSdmZk?=
 =?utf-8?B?bGdpTkxjQm1ETWNJdjgxQlFULzJNVCtZZzlOak9najN3VGZIei9KRGVWTjM5?=
 =?utf-8?B?RkdKKzVtcHFLQlRqSitCbVFVMXZBK2ZJcHY2eFc5SVlpOHZBUzBHUmlOWFZi?=
 =?utf-8?B?akwzYzVTbURsS0NURVdXcGNuVmVPbVhxRXdJUnpZc2JZaXFWcWZLQ200NE5L?=
 =?utf-8?B?eWdCaTJYeFZBbjdzVE5QaDRJZ1ZpckxUai9BVDNvN01mUnNCdmJKTEtGY2k5?=
 =?utf-8?B?UklpTHBVRWFRTU1zTEV3S2o2ZWQ5ZjdOeWlwZnFOWjZIbnh6Z1g3Ny9jTE54?=
 =?utf-8?B?eGZGNjdDYnhwZHVmdnRQTTZSVGxTZ2k2aVFhM0ZPSHNFaHNhcENLWVcyODd1?=
 =?utf-8?B?V0RRNEt0bm9sSWUvSEE1OTdFZWhlN1hBNkZOYmpaRE1kbmhaaCszRWFONDEr?=
 =?utf-8?B?MVlvZDQ1R3E0NHFHRWN2Q3BOaEhqcmY1VmpMQUNzM1gwSnQ0NHRnamFYSXFT?=
 =?utf-8?B?OHY2RENYUGhML2Y1SlE3ZXdFeCs2KytpV1d5THV4ZzBmTVBkRnRzTnBrU1Va?=
 =?utf-8?B?NjdEcUJZSkFJMnBEcVAzRXhVcUZjM3pnY3NkYTF5T05EcXBHbCtiWFZHSm42?=
 =?utf-8?B?SU9iM0JIbXFjTGJFT3RIaEJ2cG8rSzJlcEdHbXpOVE8rR2hyQ0s4N1VxREYy?=
 =?utf-8?B?OU5kRU13MnZSdUc1S3p3Qlk3WEhMZkVXY05QbzhYK0ZoTnAya0FzOEkvd1Bj?=
 =?utf-8?B?MFFkTlBlV29mMXZLUFJnbjJUUE1NWXJIam1DWnVFZ3QyeEE5cG9FZnROZ3A2?=
 =?utf-8?B?S1NVelJNZHR4Y0tDaVRhTTN6QzM4QVkxajRpeGdHS09oTUpVT1FFd3QyV0FX?=
 =?utf-8?B?ZjBUOStKS04zWXgxQ1k0S2JJMVdua2VKMjB3MEN5SDJXb2phT2FBaWJLazl5?=
 =?utf-8?B?amhFR2pESS82VWs0UDlqdDZzaUNDVUQ3ZFA4bndjMElpeUc3ei85bGdvT2Qz?=
 =?utf-8?B?MVFlbWM1K3c5TUUvYjRwb2piOWJPR2JtUk9UNkJ0bTVidVppUjdYL21GV215?=
 =?utf-8?B?M1JoSWNYWS9SK3E3eTlJOWxEWElBN2d6b1FTelN2OE80aUJhNVZYZUJHRnh3?=
 =?utf-8?B?aEc4VUZYSWhwWTFQMUNtemZCNENoNUlrbzgwV3loS0pZMEZqeU9mN3BWRDF3?=
 =?utf-8?B?czNGR05qZTIzbzhzZUZEaGxJOGpmSExsVEg4OGVUbjA4T1VxakRqMTdpV0dQ?=
 =?utf-8?B?V3BqT09sZ1NZRWxJR3dvL0c5bkwrZkhKTFdGNHY2RTEvb3dsOHpieE1jcG9D?=
 =?utf-8?B?azB5cjJIbTZ4Q2FKTklrdWlOUjR0UWFQT3pCZE9mR3lLWVJzYSt5NUNJcG1N?=
 =?utf-8?B?TnZSck1wSGM3ZlM2Tlc0cnBRUk5CZ21VSzNpNUY2Z1RhL0hJbkFrQ1lHbXoz?=
 =?utf-8?B?Mi9lb3diYkMyTHdwS040SFBpM0Zid0FtSEFXZFN2cW81VFdhc3YvRS9keFFy?=
 =?utf-8?B?OThhUUl3RHVsQWJxOWlYZEZ2SGNRRjdGMGpkeEdHdXl5cmFaZjB6czJlcXdi?=
 =?utf-8?B?cGI4ODNxa3ZyaXRLY3RNZitOekxoQTVZMFVzaWtYYjBDQTBKYzVYTXVQRW9V?=
 =?utf-8?B?T1NFdkgyUWxMc0VpMkx4VGlrNlN6QWMrNTNVTHdGd3ZGOHhNUGtlaCs2VUtS?=
 =?utf-8?B?c2UwamQ4eGFPRHV4Q2xFR3RmK3BTVTg1RTZ6RlVyTnYyNmtWS0FFMzF2dnE4?=
 =?utf-8?B?RG1PU3FwRldqOHJsS1NEOGFDUjB0U2VPVnlVclRUbm5jLzZQRzJBeVZFa0JP?=
 =?utf-8?B?YVZScjh5eE5XSWZkMlZDc29iSzkwMFlJekhhT2txbjB4dUl2RjVPalpTaVF6?=
 =?utf-8?B?Rm1FMWdPN0Z6WTVOa1FtZVNDZDBxQ2gxVDNWODNyeTV0MnNFNVRScm1yOFAx?=
 =?utf-8?B?SXV2Q0E1NDR6bVpJSVo1K05YaENaWk1paDk0bmpQK0FpRUttT25PTXN2L2NY?=
 =?utf-8?B?NW5SWER6U0YxSlJHUGM1RWgvYWJUa1Y2S0sxQ253V3RSZmxNRHZMUTVOOGov?=
 =?utf-8?B?RGY2bjRISTRKUkVZMlRJTEZJRVEwMUVFQ2hSb2UxNnZoYyt2c2tLV1dwdjNY?=
 =?utf-8?Q?CqdWm2k64vk4zpQo6Z6BRIlYw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ed839f-9d4c-4221-56e7-08dc8a3eccde
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 17:49:10.9442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQ2P2KxaTP8SfDDbmLSolJBLyN9l5NZrVPMgBgACXjJKHQLDy0Ezhu9skl6R4ZWyrt/vdQe3b+1VhioTt9X1ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDExLCAyMDI0IDk6NTAg
QU0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzogSWFu
IFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+
IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FA
a2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYtdXNl
cnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3Is
IFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50
aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjEyIDYvOF0gcGVyZiBzdGF0OiBBZGQg
Y29tbWFuZCBsaW5lIG9wdGlvbiBmb3INCj4gZW5hYmxpbmcgdHBlYnMgcmVjb3JkaW5nDQo+IA0K
PiBIZWxsbywNCj4gDQo+IE9uIE1vbiwgSnVuIDEwLCAyMDI0IGF0IDEwOjI04oCvUE0gPHdlaWxp
bi53YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBXZWlsaW4gV2FuZyA8d2Vp
bGluLndhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gV2l0aCB0aGlzIGNvbW1hbmQgbGluZSBvcHRp
b24sIHRwZWJzIHJlY29yZGluZyBpcyB0dXJuZWQgb2ZmIGluIHBlcmYgc3RhdCBvbg0KPiA+IGRl
ZmF1bHQuIEl0IHdpbGwgb25seSBiZSB0dXJuZWQgb24gd2hlbiB0aGlzIG9wdGlvbiBpcyBnaXZl
biBpbiBwZXJmIHN0YXQNCj4gPiBjb21tYW5kLg0KPiA+DQo+ID4gRXhhbXBlIHdpdGggLS1lbmFi
bGUtdHBlYnMtcmVjb3JkaW5nOg0KPiA+DQo+ID4gcGVyZiBzdGF0IC1NIHRtYV9kdGxiX3N0b3Jl
IC1hIC0tZW5hYmxlLXRwZWJzLXJlY29yZGluZyBzbGVlcCAxDQo+ID4NCj4gPiBbIHBlcmYgcmVj
b3JkOiBXb2tlbiB1cCAxIHRpbWVzIHRvIHdyaXRlIGRhdGEgXQ0KPiA+IFsgcGVyZiByZWNvcmQ6
IENhcHR1cmVkIGFuZCB3cm90ZSAwLjAwMCBNQiAtIF0NCj4gPg0KPiA+ICBQZXJmb3JtYW5jZSBj
b3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOg0KPiA+DQo+ID4gICAgICAgIDE4MSwwNDcs
MTY4ICAgICAgY3B1X2NvcmUvVE9QRE9XTi5TTE9UUy8gICAgICAgICAgIyAgICAgIDAuNiAlDQo+
IHRtYV9kdGxiX3N0b3JlDQo+ID4gICAgICAgICAgMywxOTUsNjA4ICAgICAgY3B1X2NvcmUvdG9w
ZG93bi1yZXRpcmluZy8NCj4gPiAgICAgICAgIDQwLDE1Niw2NDkgICAgICBjcHVfY29yZS90b3Bk
b3duLW1lbS1ib3VuZC8NCj4gPiAgICAgICAgICAzLDU1MCw5MjUgICAgICBjcHVfY29yZS90b3Bk
b3duLWJhZC1zcGVjLw0KPiA+ICAgICAgICAxMTcsNTcxLDgxOCAgICAgIGNwdV9jb3JlL3RvcGRv
d24tZmUtYm91bmQvDQo+ID4gICAgICAgICA1NywxMTgsMDg3ICAgICAgY3B1X2NvcmUvdG9wZG93
bi1iZS1ib3VuZC8NCj4gPiAgICAgICAgICAgICA2OSwxNzkgICAgICBjcHVfY29yZS9FWEVfQUNU
SVZJVFkuQk9VTkRfT05fU1RPUkVTLw0KPiA+ICAgICAgICAgICAgICA0LDU4MiAgICAgIGNwdV9j
b3JlL01FTV9JTlNUX1JFVElSRUQuU1RMQl9ISVRfU1RPUkVTLw0KPiA+ICAgICAgICAgMzAsMTgz
LDEwNCAgICAgIGNwdV9jb3JlL0NQVV9DTEtfVU5IQUxURUQuRElTVFJJQlVURUQvDQo+ID4gICAg
ICAgICAzMCw1NTYsNzkwICAgICAgY3B1X2NvcmUvQ1BVX0NMS19VTkhBTFRFRC5USFJFQUQvDQo+
ID4gICAgICAgICAgICAxNjgsNDg2ICAgICAgY3B1X2NvcmUvRFRMQl9TVE9SRV9NSVNTRVMuV0FM
S19BQ1RJVkUvDQo+ID4gICAgICAgICAgICAgICAgICAwICAgICAgTUVNX0lOU1RfUkVUSVJFRC5T
VExCX0hJVF9TVE9SRVM6Ug0KPiANCj4gSGVyZSBJIGd1ZXNzIHdlIGNhbiBleHBlY3QgYSBub24t
emVybyB2YWx1ZSwgcmlnaHQ/DQoNCkhpIE5hbWh5dW5nLCANCg0KRG8geW91IG1lYW4gd2hlbiB3
ZSBoYXZlIHRoZSBvcHRpb24sIHdlIHNob3VsZCBleHBlY3Qgbm9uLXplcm8gdmFsdWU/IA0KRHVy
aW5nIHRoZSBleGVjdXRpb24sIGl0J3MgcG9zc2libGUgdGhhdCB3ZSBkb24ndCBjYXB0dXJlIGFu
eSBzYW1wbGUgb24gdGhpcyANCmV2ZW50LiBJbiB0aGlzIGNhc2UsIHdlIHdvdWxkIGhhdmUgYSB6
ZXJvIHZhbHVlLiBJbiB0aGUgZnV0dXJlLCBJIHRoaW5rIHdlIHdpbGwNCmdpdmUgaXQgdGhlIGRl
ZmF1bHQgdmFsdWUgaW5zdGVhZCBvZiB6ZXJvLg0KDQo+IA0KPiA+DQo+ID4gICAgICAgIDEuMDAz
MTA1OTI0IHNlY29uZHMgdGltZSBlbGFwc2VkDQo+ID4NCj4gPiBFeGFtcGUgd2l0aG91dCAtLWVu
YWJsZS10cGVicy1yZWNvcmRpbmc6DQo+ID4NCj4gPiBwZXJmIHN0YXQgLU0gdG1hX2R0bGJfc3Rv
cmUgLWEgc2xlZXAgMQ0KPiA+DQo+ID4gIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdz
eXN0ZW0gd2lkZSc6DQo+ID4NCj4gPiAgICAgICAgMTgxLDA0NywxNjggICAgICBjcHVfY29yZS9U
T1BET1dOLlNMT1RTLyAgICAgICAgICAjICAgICAgMC42ICUNCj4gdG1hX2R0bGJfc3RvcmUNCj4g
PiAgICAgICAgICAzLDE5NSw2MDggICAgICBjcHVfY29yZS90b3Bkb3duLXJldGlyaW5nLw0KPiA+
ICAgICAgICAgNDAsMTU2LDY0OSAgICAgIGNwdV9jb3JlL3RvcGRvd24tbWVtLWJvdW5kLw0KPiA+
ICAgICAgICAgIDMsNTUwLDkyNSAgICAgIGNwdV9jb3JlL3RvcGRvd24tYmFkLXNwZWMvDQo+ID4g
ICAgICAgIDExNyw1NzEsODE4ICAgICAgY3B1X2NvcmUvdG9wZG93bi1mZS1ib3VuZC8NCj4gPiAg
ICAgICAgIDU3LDExOCwwODcgICAgICBjcHVfY29yZS90b3Bkb3duLWJlLWJvdW5kLw0KPiA+ICAg
ICAgICAgICAgIDY5LDE3OSAgICAgIGNwdV9jb3JlL0VYRV9BQ1RJVklUWS5CT1VORF9PTl9TVE9S
RVMvDQo+ID4gICAgICAgICAgICAgIDQsNTgyICAgICAgY3B1X2NvcmUvTUVNX0lOU1RfUkVUSVJF
RC5TVExCX0hJVF9TVE9SRVMvDQo+ID4gICAgICAgICAzMCwxODMsMTA0ICAgICAgY3B1X2NvcmUv
Q1BVX0NMS19VTkhBTFRFRC5ESVNUUklCVVRFRC8NCj4gPiAgICAgICAgIDMwLDU1Niw3OTAgICAg
ICBjcHVfY29yZS9DUFVfQ0xLX1VOSEFMVEVELlRIUkVBRC8NCj4gPiAgICAgICAgICAgIDE2OCw0
ODYgICAgICBjcHVfY29yZS9EVExCX1NUT1JFX01JU1NFUy5XQUxLX0FDVElWRS8NCj4gPiAgICAg
ICAgICAgICAgICAgIDAgICAgICBNRU1fSU5TVF9SRVRJUkVELlNUTEJfSElUX1NUT1JFUzpSDQo+
ID4NCj4gPiAgICAgICAgMS4wMDMxMDU5MjQgc2Vjb25kcyB0aW1lIGVsYXBzZWQNCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMgfCAyICsrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJm
L2J1aWx0aW4tc3RhdC5jIGIvdG9vbHMvcGVyZi9idWlsdGluLXN0YXQuYw0KPiA+IGluZGV4IDE0
YmUxMzJmN2I2Zi4uMDU1MTM5ZTQ0NzYzIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvYnVp
bHRpbi1zdGF0LmMNCj4gPiArKysgYi90b29scy9wZXJmL2J1aWx0aW4tc3RhdC5jDQo+ID4gQEAg
LTEyMzUsNiArMTIzNSw4IEBAIHN0YXRpYyBzdHJ1Y3Qgb3B0aW9uIHN0YXRfb3B0aW9uc1tdID0g
ew0KPiANCj4gV2hhdCdzIHRoZSBiYXNlIG9mIHlvdXIgcGF0Y2hzZXQ/ICBJIHRoaW5rIHdlIG1v
dmVkIHRoaXMgdG8gY21kX3N0YXQoKS4NCj4gUGxlYXNlIG1ha2Ugc3VyZSB0byByZWJhc2Ugb24g
dGhlIHBlcmYtdG9vbHMtbmV4dC4NCg0KVGhpcyB3YXMgcmViYXNlZCBvbiB0b3Agb2YgSWFuJ3Mg
Y2hhbmdlIGZvciB0aGUgdG9vbCBldmVudCBhbmQgcmV0aXJlX2xhdGVuY3kgcGFyc2VyIA0KcGF0
Y2hlcy4gSSB0aGluayB0aGF0IHdhcyBvbiB0bXAucGVyZi10b29scy5uZXh0LiBJIHdpbGwgcmVi
YXNlIG9uIHBlcmYtdG9vbHMtbmV4dC4gDQoNCj4gDQo+IA0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgImRpc2FibGUgYWRkaW5nIGV2ZW50cyBmb3IgdGhlIG1ldHJpYyB0aHJlc2hvbGQgY2Fs
Y3VsYXRpb24iKSwNCj4gPiAgICAgICAgIE9QVF9CT09MRUFOKDAsICJ0b3Bkb3duIiwgJnRvcGRv
d25fcnVuLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICJtZWFzdXJlIHRvcC1kb3duIHN0
YXRpc3RpY3MiKSwNCj4gPiArICAgICAgIE9QVF9CT09MRUFOKDAsICJlbmFibGUtdHBlYnMtcmVj
b3JkaW5nIiwgJnRwZWJzX3JlY29yZGluZywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAi
ZW5hYmxlIHJlY29yZGluZyBmb3IgdHBlYnMgd2hlbiByZXRpcmVfbGF0ZW5jeSByZXF1aXJlZCIp
LA0KPiANCj4gUGxlYXNlIHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiAobWFuIHBhZ2UpIGZvciB0
aGlzIG9wdGlvbi4NCj4gDQo+IEFsc28gSSdtIGFmcmFpZCBpdCdkIGZhaWwgdG8gYnVpbGQgb24g
bm9uLXg4NiBiZWNhdXNlIHRwZWJlc19yZWNvcmRpbmcNCj4gaXMgZGVmaW5lZCBpbiBpbnRlbC10
cGVicy5jLg0KPiANCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBJIGZvcmdvdCBhYm91dCBub24teDg2
LiBJIHdpbGwgdXBkYXRlIHRoaXMgYW5kIGFsc28gdGhlIA0KRG9jdW1lbnRhdGlvbi4NCg0KVGhh
bmtzLA0KV2VpbGluDQoNCj4gVGhhbmtzLA0KPiBOYW1oeXVuZw0KPiANCj4gDQo+ID4gICAgICAg
ICBPUFRfVUlOVEVHRVIoMCwgInRkLWxldmVsIiwgJnN0YXRfY29uZmlnLnRvcGRvd25fbGV2ZWws
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIlNldCB0aGUgbWV0cmljcyBsZXZlbCBmb3Ig
dGhlIHRvcC1kb3duIHN0YXRpc3RpY3MgKDA6IG1heCBsZXZlbCkiKSwNCj4gPiAgICAgICAgIE9Q
VF9CT09MRUFOKDAsICJzbWktY29zdCIsICZzbWlfY29zdCwNCj4gPiAtLQ0KPiA+IDIuNDMuMA0K
PiA+DQo=
