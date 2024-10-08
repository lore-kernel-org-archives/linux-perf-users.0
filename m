Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C091DFE8;
	Tue,  8 Oct 2024 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355940; cv=fail; b=DxBR4FUnmUDikpDOWQq//DdiKOpVIvfEnZZBkIcZlzgNyyp1v6fd/wXQUprXhiK8rWpf6lHBXbc65dBAxGuWLc5JL05WZqfSPFT4FfnkxFPGwPV1BdPlgAUgzscw6wfsSHg8F+f9CiVxWM9dq1y4mHfQz8+Y8Jl13+J+Yf5STes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355940; c=relaxed/simple;
	bh=yBGIiXrl2a6KU/3Tj7R/wNQ5tcNHqKv3DIa3dpQZVfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SNW4Qem01rgFXqCHjRlLLigvj8gGwxmnjEUCncX+kMj6Wtx38VAuAK1E2fK6JylDMvEoW+Nl+OYazFC4xFouoJjw8k1lhgnygjBdAssz40pxpUA1MxzITts3AeGZqKbuOpVeZZM0NZ6gL+v2a6tIxkOyU2JOCN0EBnHvffYluvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeMn0fhv; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeMn0fhv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728355938; x=1759891938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yBGIiXrl2a6KU/3Tj7R/wNQ5tcNHqKv3DIa3dpQZVfQ=;
  b=jeMn0fhv2bF2dU4F9fgBmwPbizynXi2hDhrJrPfhGhBWJu0MgO+pySwi
   Jum/rE3UrdpEnRjltvGNl86lM1zzaQcBpn2WFxzaxnxF6uni5R0qtokdM
   SVz0osjmOzwMZQCIGIzyqw8h6Ghh9r6n9FdRXvJ2aESf87i0dYLodG0ME
   IeJ1t3zWuLknlRBaKJs0aP1huCw1TBn5munqOcW0ScmTolDPVgyPScuvc
   YEecNvhGxnYgUPizK8Zx9GpNMgTbXKIFTQKp+MO7sWJ7gPbtTgs2cIFjQ
   EYdMy5TQzU1yljjxm7agmoZMUtlYy9vsHBSEnNovHfI/1v6V2+yy2RxFa
   w==;
X-CSE-ConnectionGUID: G3YEe/XjS+2c/dUT2HyAaw==
X-CSE-MsgGUID: HnepszOGTbea7HlHaLkMLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38182711"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="38182711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 19:52:18 -0700
X-CSE-ConnectionGUID: +HUO39EITPK2b6ZajxXcbg==
X-CSE-MsgGUID: ZsQB2gCoRRud8IzxrzaWOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="79659455"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 19:52:18 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 19:52:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 19:52:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 19:52:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 19:52:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 19:52:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMXyuZWY3sgh+AB4GZBiQCZiXrt84njnZGEvsL11qpHz4yonhUBbd/hwLYKfLLn/7Jf0KwdsqTUsBf8xEiReDyvPMfwK789MzNiehcOEXceSMQShmfweAelFRxF0bKSmLtHAnHTUyFPFi5C6T6elu1t7zDePtfGbaEh8ExdsTdi+ANYWSImtHuGfFWk+chH038vT9vUbydjFxGjFmYADXEFaostdbl+3hU8qTg6FNNnmFh0oJbF5/Qwb+1LPB7Kc/6s7kXQvozShPaGeRMfPDQ0KpMtZ1Qjyp+eVycPF3y1a6OtM9jHE9gM3E1adcKXtIi+qbJIjZv+yuGH9krDSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBGIiXrl2a6KU/3Tj7R/wNQ5tcNHqKv3DIa3dpQZVfQ=;
 b=jFnzdVfxmhe4nsF+HvlQkQ5LyLqFCGW1cJoyCuz6drmaQxGv3CAcxo5XEyUYgZ5RCElB9milpYqxeOX+/1tjrHZOLL3jwQPv/jI2gBplKXaE0dxIIwaeGAH4gMZvU5a7WDn3zWMkvL6gl8Pe6acWSc3cAWye1J26m9vQ+oDOnj3R5ZVbuAuyS0PQkRkdsayWovJEWphlndQcSdCncG7QFd8CwxVdy+UYcqhntcfK+njkgW7cpQ7m5JbLVlE9hkt/G2B8eWt/omY8vy6LfeBscsd7dRn2xGIbCcJgjfi5YfM/NkQA0nV/VRbTKunr5sIj1LX+rfZWa4SoPNy2Cgg+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 02:52:13 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::fa93:2029:3d0b:fb99]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::fa93:2029:3d0b:fb99%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 02:52:12 +0000
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
Thread-Index: AQHbBZzE0FC6Ch5gqUmvLr/5BrB70rJyfxsAgAAZJgCAAar9gIAAD9sAgADquoCAABBBAIAADfEAgAAyRYCAABxOgIAADT6AgAAVBACAAAILgIAGelzw
Date: Tue, 8 Oct 2024 02:52:12 +0000
Message-ID: <PH0PR11MB482486871B66FC139C399C8DCD7E2@PH0PR11MB4824.namprd11.prod.outlook.com>
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
 <Zv8XIZAwfoTtzOl4@google.com>
 <8df24fe8-4d90-4105-acf0-e4f2667c42c9@linux.intel.com>
 <CAP-5=fUVNa_JKz7WweWsQjobhFCoknbPuPGzPGFGcaDJ8wxLQw@mail.gmail.com>
In-Reply-To: <CAP-5=fUVNa_JKz7WweWsQjobhFCoknbPuPGzPGFGcaDJ8wxLQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4824:EE_|CH0PR11MB5235:EE_
x-ms-office365-filtering-correlation-id: 05ce12f3-39b0-41b6-6cc9-08dce74435e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFJVSllVVElRUWkxem40REdmMnVnaERhYkdhZEtoaDdxdzRWMHA4RFJlekg2?=
 =?utf-8?B?R1g2dzhFc092d2xzbWRJZzNCRzNjYlFwZktZWkZVMWxrOUpZaHNVVFAvdHgx?=
 =?utf-8?B?OGVtRW1aZzZyaG5qdG5CQ3RTdGU3VGltNnlCZ0JkRWdZcThMOWo0ZFhSa0F0?=
 =?utf-8?B?QkVxWFV5VCtsbkx6UVV3QnY4UG9FSTdlNC9nS2F3RTZNN0JFNnprUjFHbUho?=
 =?utf-8?B?TnFLUW14cUJORmFNNUYraDMzeHJHUDhxc0JsbUJXZzNjT0ZxZ3pJY3VsczEx?=
 =?utf-8?B?R1Vjb09GbE00L2FRc2Y1SkM4ZTEyblNseHdQUXZMZHA5eWRQM1I0NjFCaUw5?=
 =?utf-8?B?N1IzSDZFVWVnZnY0YUpVcTMvZDZCbEs4VzNPQXA5SFhOZjMzZVZYTWpuVU11?=
 =?utf-8?B?RkVBdzJtbWQ2Q1JhVFVPZE5UNjIvbndRK2JSeG1TYmRLeG5DOGtsN3BUd1NY?=
 =?utf-8?B?UDNGQ293cVUxNHplTEtGeExpSmZCeDRIVHFoZHFwK291bDBNamVNOWRGUVBr?=
 =?utf-8?B?QUhaSUlLc3RNQnRmS1dKaEpKRTE0WVR0ZXo0M0xoaHQ2elJ4Sk1YWFFQUUU2?=
 =?utf-8?B?RndWa2hHcXozUXFPZWhnK2JKaTY3T0NlVzk3WmFHNnJNV1JBeTFyR3JoWld6?=
 =?utf-8?B?VUJqdWVvRGphTHVFRkR4U3E3YnYydzBpaHI0OFFDcU90cDdrNFVJTC81S0Ju?=
 =?utf-8?B?SVJJVGVqQ0phaWI5aEFHNnpveUFIcWJwM05vYUNlRFZiOTM3cEpIamNaV2Rw?=
 =?utf-8?B?QXovZUhmRWFLRHhKZ0JKMVRndDQzbUtYQ3IyUXJjNXNGR1VpQnhZNktxTmtQ?=
 =?utf-8?B?U29EYlNhcjVlZGJkSG1naTl2Q1Bzd0lOOWhKc0RtTTB2SStrR1d0N2VjUFFD?=
 =?utf-8?B?d3F5bFV4TEY0eWc5RDRHaWNSQm5hTGhYcXQwdWNRRHFiTXlwUzlOZDA1dWs5?=
 =?utf-8?B?UElQczNoQVppQnVGK0ZTQlJtS0dXNS90c042L0pWZ3BIOWNYRzc2eHl3V2Nr?=
 =?utf-8?B?ZTBpZHVqSTFBSVE0Ty9hRjNWQmhkYS9kU3B1WjhBU2JsbmRkUmlLOEtaanBW?=
 =?utf-8?B?RlJIWThhbWdyK2tkdHI1QjdtMkw3QzBDdzFjM25Xc2hEVXR1S0NXMFduMVhV?=
 =?utf-8?B?WWthaFZ2bXByK1Y4UkoyNElBUUk5QzFaUjJkeUZDdmVCYnRRZzcwc3FVM2xJ?=
 =?utf-8?B?SDcrbW1yTjFyeUNrSFk1cjVQeWduZFlWRHZxVGk2eis3TlpGZ2ZFTFlIUS9y?=
 =?utf-8?B?c3EvSGpWQmREZFhoV2NRYkhocStSQk5HZDVaZm4rYmk2TlJYVVJwUkRGRTdB?=
 =?utf-8?B?UEJDRzMyb29iNW5nVWFGZnE2ZlFub0o4T1VManQxOHhpamVzWlBBVi9GWEVF?=
 =?utf-8?B?bDU0ajVhK1FhUTdGWkFMSzF6TWthVXByZUpvNFN2UURZVSsvQTg4WlVQYzM2?=
 =?utf-8?B?UDV0NEp6d0ozTjN5QkNXRjZGNU5IUndEMXRnVWJNRlIwVk5yZHBZSm1VSTh6?=
 =?utf-8?B?bG16VUVqWkYxTlVRcUduZHI0Ym1ORG5ZbkpSZEtTam1VVVlwOVdJZlY3VlhL?=
 =?utf-8?B?djhTUFc0eXk1M0Nqais4L1VTWEx1RWlrUEVvVk5PaysrTjhUUUJTaUVrdFRN?=
 =?utf-8?B?bnEvRXloVUY5bzVOeWpQZkRjbXN1K3NIdUpPd2xob3cveEo4YzB1a3g5dDFa?=
 =?utf-8?B?aVIvdk5FUmFsL1VLSDhrMjNIMWZoRUtnaVlzdmVVUW8vUWgxVFp2Wmd0UW01?=
 =?utf-8?Q?19Nkl1y6gUIHcgUJsw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEVJNmFkSDJPalUrc2w5K1cyMTlKNVpCQ21xSXorbWRWakdqMVV3QWFlOCtZ?=
 =?utf-8?B?ZHVNV1VnV1dJVXFsNDc3TTkxSTBSaWtkcFlCZ29ibDgvWk5kNTNKVlplT1Fj?=
 =?utf-8?B?NW5oLzNWS0FCT25jNHpYRFFqN1VXZC9KaXp3SUpqaUdsU1RrMW9TNFE1Mkl5?=
 =?utf-8?B?SDZheUEzd0JJV1kxcTJYQmdlVkwza2tqRERPaXpQRGt2WnZPV2QzM2lqUU9Y?=
 =?utf-8?B?ZU9saGxMVFpsWlVRdGwxUmlMbzA0by9ZTTJ1TXYrMEZjV1ZWZnkxaFk3U3Za?=
 =?utf-8?B?YlRYZ2lHWC9lekcwem5vaTdIeHorTWtzQndWWEY3QlVFTDhYbGFqVHlvUSt6?=
 =?utf-8?B?WFBCL240MFpCai9vcUlmVEdONk5JaHRSdEgvY3J3U3ZKTklYSk5GSjg0VzBJ?=
 =?utf-8?B?NzZDSGxVcC8yZTlRTE1JR3J1S3lrSXBKQzRIYUxVSTJ1cmxIOUNHa1BVNEw2?=
 =?utf-8?B?ZzJGUjNWQmJKQlBqeENNc0ZOYlMweG1QZDc3RUJiUWtlK1N0QitXZDdRNy9l?=
 =?utf-8?B?RXpWL0VEdW9GMzJ0eGc0bHU1UTdxenRxWWtwR3FCUUtKK1dHQWd3SDBxeDJ6?=
 =?utf-8?B?OVAwTHlSOEV1NUIveU8zWXo4SFpjeEtXc0NJNVE4S2JKY20rdFhzNmxtbGFK?=
 =?utf-8?B?UTRyUExIRlk4RXdad3pheDduQ2hNbjYycEpFZ3BKalZYd1IyNC9DdHU5TU9s?=
 =?utf-8?B?NitCMkNYcnlDNjcrVmZNc1JLTWRVUmVRZVhjakYyNndzNENpSkdEZG5IVGs3?=
 =?utf-8?B?VFg2QVdhSi9WWUlSdTdEMVdoTGg1Z0Rlelpoa3FtdHhmR0g5bHNNczdDZVlh?=
 =?utf-8?B?U0xDSDlLUEMwMGp5VVFZVVc0Z09mWjc3UVZ5TFRLMWc1elIrYVpuaGVtVTUv?=
 =?utf-8?B?QmRENnF1WTBodXJWQW5JV3NScHpVZzJ2TmhEa3JjNnZ2UURteFNhaWNQS1JB?=
 =?utf-8?B?Z2ZiMk9vL1l0eHBLVmRxYTBvUUwvdEN2dlMxTzgyTHFLQVlEVTVKZURnc09p?=
 =?utf-8?B?TG5Md1VYSU5LUmdtaDRISGR5VVlTeDRNREQ3c01pb3BEUUNRdDBmYXlTRXh0?=
 =?utf-8?B?MGw2aHhqRmFRQllHRSsrSWlUMzZFQTZYVTVDYnJoOXRLZVQ1UmFVcUpidlNM?=
 =?utf-8?B?SWplN2dQak9Ob3VRa1plUDBTZjl3dHIwM0lUTEdGby9aVnREWDVKc2Y3WWVx?=
 =?utf-8?B?cnE2emljY1pLSklBbUpONEFpTVMwbzBGMXVEVzl0UDdVb0JEa2xvTWlwZFMx?=
 =?utf-8?B?bTk0S0wvYkt2dEx1aDhIbUlJZDRhcVZpK2JzT0VBbUFpdWswUFBxbnNjSVU0?=
 =?utf-8?B?Vzh3bmc3Y3lWTmNYTStxejFLLzY2S1VGR0N2dVpqOWF2UWRhVVBEd3BTSkEx?=
 =?utf-8?B?cWxnQ0FGN0hSK1VXWlBYKzlzdlc5cVUyZDZQUE9vaFZ5ZnkvTnZSL001ZThE?=
 =?utf-8?B?eExWSTFBVGRSS0R2c1R2ejJTbVIydVVjdUZkZElmWWZ1L050QURRaTFLZGU4?=
 =?utf-8?B?M2kwSjFUZDBmSjU4VytxLzVIOEwxMXF0SEtUK0VJSXM4ZDJnRGxQVHBsdkRN?=
 =?utf-8?B?am1IMXozVzJCZ2Y0bVM0VHZMRWprTFlkc3NiZVVZekFQbUk4WkdxczFKVkta?=
 =?utf-8?B?NnNkLy9aR01QWmFmV3NZWUdYQkdVaDVuWDkyZUFuQ2lHc0Rmd1RBYmxidDhp?=
 =?utf-8?B?ckR4STQxbnBNbDRqc2JFUUZuYUFENENLR0pqUDZGeWI4a0FDSk5MQURPMzJO?=
 =?utf-8?B?QXN6VTRWb3p3KzFER1pQQXRkKzZjVjhuaXpNMFA2eVpiaEplQ2ZEVU5JMTV2?=
 =?utf-8?B?RzFOYXUwT1ZTckJxLzFybjYzYW1oZmdqUHBRbUZsMTRpUnRMUjRzQkpycjBK?=
 =?utf-8?B?US82U1QwUU5FWVQ2N1FzaVFWd01Nc0l1Rit6am9jcjBndTdDc1NZSVF5Ukpa?=
 =?utf-8?B?M29VV0F1M1U2dVdma1N5V2ZWOEZTRER5Q1ZaVkk0Rk1rd01mWEFvaWpVOTBH?=
 =?utf-8?B?b1dscXRwcmZtZzhtdzFZSXdWYzJTRW9kSU5oZjBSQUxlZVV6WXZhR0tXZGdK?=
 =?utf-8?B?TE56MFRONDBibVFIbFlROFprRFFUdG9MeEpvZ2d0eXBzaDNIQzFjSk44R24w?=
 =?utf-8?Q?uY+NKgMa9vfnVfA0+zuh6vLXC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ce12f3-39b0-41b6-6cc9-08dce74435e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 02:52:12.7446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEvN6BLtn0e3ooyx5pshcGmSRixw73dNsa9Kk9Ta9sBExVghAGZ7lJAWUc0aelE0/wj8ZTn7+qi0t0PZWjrfIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgNCwgMjAyNCA3OjM2IEFN
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
DQo+IE9uIFRodSwgT2N0IDMsIDIwMjQgYXQgNDoyOeKAr1BNIExpYW5nLCBLYW4gPGthbi5saWFu
Z0BsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+IE9uIDIwMjQtMTAt
MDMgNjoxMyBwLm0uLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+ID4gPj4gRGFwZW5nJ3MgY29tbWVu
dCBzaG91bGQgY292ZXIgcmVwbGFjZSB0aGUgY29tbWVudCAvKiBGb2xsb3dlZCBieQ0KPiA+ID4+
IHRvcGRvd24gZXZlbnRzLiAqLyBidXQgdGhlcmUgYXJlIG90aGVyIHRoaW5ncyBhbWlzcy4gSSdt
IHRoaW5raW5nDQo+ID4gPj4gb2Ygc29tZXRoaW5nIGxpa2U6ICJzbG90cyxjeWNsZXMse2luc3Ry
dWN0aW9ucyx0b3Bkb3duLWJlLWJvdW5kfSINCj4gPiA+PiB0aGUgdG9wZG93bi1iZS1ib3VuZCBz
aG91bGQgZ2V0IHNvcnRlZCBhbmQgZ3JvdXBlZCB3aXRoIHNsb3RzLCBidXQNCj4gPiA+PiBjeWNs
ZXMgYW5kIGluc3RydWN0aW9ucyBoYXZlIG5vIHJlYXNvbiB0byBiZSByZW9yZGVyZWQsIHNvIGRv
IHdlDQo+ID4gPj4gZW5kIHVwIHdpdGggc2xvdHMsIGluc3RydWN0aW9ucyBhbmQgdG9wZG93bi1i
ZS1ib3VuZCBiZWluZyBncm91cGVkDQo+ID4gPj4gd2l0aCBjeWNsZXMgc2l0dGluZyB1bmdyb3Vw
ZWQgaW4gdGhlIG1pZGRsZSBvZiB0aGUgZXZsaXN0PyBJDQo+ID4gPj4gYmVsaWV2ZSB0aGVyZSBh
cmUgYXNzdW1wdGlvbnMgdGhhdCBncm91cGVkIGV2c2VscyBhcmUgYWRqYWNlbnQgaW4NCj4gPiA+
PiB0aGUgZXZsaXN0LCBub3QgbGVhc3QNCj4gPiA+PiBpbjoNCj4gPiA+PiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZXJmL3BlcmYtdG9vbHMtbmV4DQo+
ID4gPj4gdC5naXQvdHJlZS90b29scy9wZXJmL3V0aWwvcGFyc2UtZXZlbnRzLmM/aD1wZXJmLXRv
b2xzLW5leHQjbjIxMDYNCj4gPiA+PiBEb2VzIGN5Y2xlcyBpbnN0cnVjdGlvbnMgZW5kIHVwIGJl
aW5nIGJyb2tlbiBvdXQgb2YgYSBncm91cCBpbiB0aGlzDQo+ID4gPj4gY2FzZT8gV2hpY2ggZmVl
bHMgbGlrZSB0aGUgY2FzZSB0aGUgY29kZSB3YXMgdHJ5aW5nIHRvIGF2b2lkLg0KPiA+ID4gSSBn
b3QgdGhpczoNCj4gPiA+DQo+ID4gPiAgICQgc3VkbyAuL3BlcmYgcmVjb3JkIC1hIC1lICJzbG90
cyxjeWNsZXMse2luc3RydWN0aW9ucyx0b3Bkb3duLWJlLWJvdW5kfSINCj4gdHJ1ZQ0KPiA+ID4g
ICBFcnJvcjoNCj4gPiA+ICAgVGhlIHN5c19wZXJmX2V2ZW50X29wZW4oKSBzeXNjYWxsIHJldHVy
bmVkIHdpdGggMjIgKEludmFsaWQgYXJndW1lbnQpIGZvcg0KPiBldmVudCAodG9wZG93bi1iZS1i
b3VuZCkuDQo+ID4gPiAgICJkbWVzZyB8IGdyZXAgLWkgcGVyZiIgbWF5IHByb3ZpZGUgYWRkaXRp
b25hbCBpbmZvcm1hdGlvbi4NCj4gPg0KPiA+IFRvIGJlIGhvbmVzdCwgSSB0aGluayB0aGUgInNs
b3RzLGN5Y2xlcyx7aW5zdHJ1Y3Rpb25zLHRvcGRvd24tYmUtYm91bmR9Ig0KPiA+IGlzIGEgbWVh
bmluZ2xlc3MgY2FzZS4gV2h5IGEgdXNlciB3YW50cyB0byBncm91cCBpbnN0cnVjdGlvbnMgYW5k
DQo+ID4gdG9wZG93biBldmVudHMsIGJ1dCBsZWF2ZSB0aGUgc2xvdHMgb3V0IG9mIHRoZSBncm91
cD8NCj4gPiBUaGVyZSBjb3VsZCBiZSBodW5kcmVkcyBvZiBkaWZmZXJlbnQgY29tYmluYXRpb25z
IGNhdXNlZCBieSB0aGUgcGVyZg0KPiA+IG1ldHJpY3MgbWVzcy4gSSBkb24ndCB0aGluayB0aGUg
cmUtb3JkZXJpbmcgY29kZSBzaG91bGQvY2FuIGZpeCBhbGwgb2YgdGhlbS4NCj4gDQo+IEknbSBo
YXBweSB3aXRoIGJldHRlciBjb2RlIGFuZCB0aGluZ3MgZG9uJ3QgbmVlZCB0byBiZSBwZXJmZWN0
LiBDYW4gd2UgZml4IHRoZQ0KPiBjb21tZW50cyB0aG91Z2g/IEl0J2QgYmUgbmljZSB0byBhbHNv
IGluY2x1ZGUgdGhhdCBzb21lIHRoaW5ncyBhcmUgZ29pbmcgdG8gYmUNCj4gYnJva2VuLiBJIGNh
biBpbWFnaW5lIGdyb3VwcyB3aXRoIHRvcGRvd24gZXZlbnRzIGJ1dCB3aXRob3V0IHNsb3RzLCBm
b3IgZXhhbXBsZQ0KPiB3ZSBncm91cCBldmVudHMgaW4gbWV0cmljcyBhbmQgaW4gdG1hX3JldGly
aW5nIHdlIGFkZCAiMCAqDQo+IHRtYV9pbmZvX3RocmVhZF9zbG90cyIgdG8gdGhlIG1ldHJpYyBz
byB0aGF0IHdlIGdldCBhIHNsb3RzIGV2ZW50LiBJZiB0aGUgbXVsdGlwbHkNCj4gd2VyZSBvcHRp
bWl6ZWQgYXdheSBhcyByZWR1bmRhbnQgdGhlbiB3ZSdkIGhhdmUgYSB0b3Bkb3duIGdyb3VwIHdp
dGhvdXQNCj4gc2xvdHMsIHdlIGNvdWxkIHBpY2sgdXAgc2xvdHMgYW5kIG90aGVyIGV2ZW50cyBm
cm9tIG90aGVyIG1ldHJpY3MuDQoNCkkgZG9uJ3QgdGhpbmsgdGhpcyBwYXRjaCB3b3VsZCBicmVh
ayBhbnkgY3VycmVudCByZWdyb3VwIGNhc2UuIEl0IGp1c3QgYmxvY2tzIHRvIG1vdmUgdG9wZG93
biBtZXRyaWNzIGV2ZW50IGlmIHRoZXkgYXJlIGFscmVhZHkgaW4gc2FtZSBncm91cCB3aXRoIHNs
b3QgZXZlbnRzLiBXZSBjYW4gc2VlIHNhbWUgZXJyb3IgZm9yIHRoaXMgZXZlbnQgY29tYmluYXRp
b24gInNsb3RzLGN5Y2xlcyx7aW5zdHJ1Y3Rpb25zLHRvcGRvd24tYmUtYm91bmR9IiBpbiB0aGUg
b3JpZ2luYWwgY29kZS4NCg0KQXMgS2FuIHNhaWQsIHRoZXJlIGNvdWxkIGJlIGh1bmRyZWRzIG9m
IHRvcGRvd24gbWV0cmljcyBjb21iaW5hdGlvbnMsIGl0J3MgdW5yZWFsaXN0aWMgdG8gY292ZXIg
YWxsIHRoZXNlIGNvbWJpbmF0aW9ucyBqdXN0IHVzaW5nIHNvcnRpbmcsIGFuZCBldmVuIGl0IGNh
biBiZSBkb25lLCB0aGUgY29tcGFyYXRvciB3b3VsZCBiZWNvbWUgbXVjaCBjb21wbGljYXRlZCBh
bmQgaGFyZCB0byBtYWludGFpbi4NCg0KSSB0aGluayB3ZSdkIGJldHRlciBqdXN0IG1haW50YWlu
IHNldmVyYWwgY29tbW9ubHkgdXNlZCByZWdyb3VwIGNhc2VzLCBpdCB3b3VsZCBiZSBmaW5lIHRv
IHJhaXNlIGFuIGVycm9yIGZvciB0aGVzZSB1bnN1cHBvcnRlZCBjb21iaW5hdGlvbnMgYXMgbG9u
ZyBhcyBlcnJvciBtZXNzYWdlIGlzIGNsZWFyIGVub3VnaC4NCg0KSWFuLCBJIGRvbid0IGZ1bGx5
IHVuZGVyc3RhbmQgeW91ciB3b3JkcywgY291bGQgeW91IHBsZWFzZSBnaXZlIGFuIGV4YW1wbGU/
IFRoYW5rcy4NCg0KDQo+IA0KPiA+IEZvciB0aGUgY2FzZSB3aGljaCB0aGUgcmUtb3JkZXJpbmcg
Y2Fubm90IGNvdmVyIChsaWtlIGFib3ZlKSwgYW4gZXJyb3INCj4gPiBvdXQgaXMgYWNjZXB0YWJs
ZS4gU28gdGhlIGVuZCB1c2VyIGNhbiB1cGRhdGUgdGhlaXIgY29tbWFuZCB0byBhIG1vcmUNCj4g
PiBtZWFuaW5nZnVsIGZvcm1hdCwgZWl0aGVyIHtzbG90cyxjeWNsZXMsaW5zdHJ1Y3Rpb25zLHRv
cGRvd24tYmUtYm91bmR9DQo+ID4gb3Ige3Nsb3RzLHRvcGRvd24tYmUtYm91bmR9LGN5Y2xlcyxp
bnN0cnVjdGlvbnMgc3RpbGwgd29ya3MuDQo+IA0KPiBQZXJoYXBzIHdlIGNhbiBhZGQgYW4gYXJj
aCBlcnJvciBwYXRoIHRoYXQgY291bGQgaGVscCBtb3JlIGZvciB0b3Bkb3duIGV2ZW50cw0KPiBn
aXZlbiB0aGV5IGFyZSBhIHBhcnRpY3VsYXIgcGFpbiB0byBvcGVuLg0KPiANCj4gPiBJIHRoaW5r
IHdoYXQgdGhlIHBhdGNoIHNldCByZWFsbHkgZml4ZWQgaXMgdGhlIGZhaWx1cmUgb2Ygc2FtcGxl
IHJlYWQNCj4gPiB3aXRoIHBlcmYgbWV0cmljcy4gV2l0aG91dCB0aGUgcGF0Y2ggc2V0LCBpdCBu
ZXZlciB3b3JrcyBubyBtYXR0ZXIgaG93DQo+ID4geW91IGNoYW5nZSB0aGUgb3JkZXIgb2YgdGhl
IGV2ZW50cy4NCj4gPiBBIGJldHRlciBvcmRlcmluZyBpcyBqdXN0IGEgbmljZSB0byBoYXZlIGZl
YXR1cmUuIElmIHBlcmYgY2Fubm90DQo+ID4gcHJvdmlkZXMgYSBwZXJmZWN0IHJlLW9yZGVyaW5n
LCBJIHRoaW5rIGFuIGVycm9yIG91dCBpcyBhbHNvIE9LLg0KPiANCj4gQWdyZWVkLCB3ZSBkb24n
dCBuZWVkIHRvIGZpeCBldmVyeXRoaW5nIGFuZCBmb2N1c3Npbmcgb24gdGhlIGNvbW1vbiB1c2Ug
Y2FzZXMNCj4gbWFrZXMgc2Vuc2UuDQo+IA0KPiBUaGFua3MsDQo+IElhbg0K
