Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB113A3F2;
	Wed, 11 Jun 2025 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665905; cv=fail; b=JFFVPwy8zekIJcxJyY1PeZUpToiyZp/uw7MdQrhQFrK3EKe27OYy7IscefmV9+8Abqsl6A2RzS3oXv+0iPYaKzMl9T4o/2atXhGZkDNs7/ZqTMMAk7Ys7LRV8kY+Mz6hAZK8WJrjNcbjBEO+V1OjkBmEB2qXBEBeZo0QwQEj1/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665905; c=relaxed/simple;
	bh=BlB322RgvlMjfH7nDueXPnd5S7k8hzreNzsU/4BIqM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MqgIW7LyBy7ocJpWcUe3WgjgeBtf/I69N1mhW464oMZqdvnkzUUonMtX3ZqrK0y0dDPd45unGK/jBwa+tTxyn0vFgz2K0O5tZ69TcwAWdHZhTXSwCqiCVaQJqaCahV7b37b/CmqIWe0ZsB6w/PWwSVPJakk54HcLY2hR4QRNxJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTW76xI1; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTW76xI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749665904; x=1781201904;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BlB322RgvlMjfH7nDueXPnd5S7k8hzreNzsU/4BIqM4=;
  b=OTW76xI1HCbGnqYA8IkukXDn9GiOxsXIxhK6MQ7n1t6L0NhJmIKkPJMz
   ocYerbj+mD5D5D92BP8hQ27Y+LB9SxDOhB/JCwELXs4mhENVRQKt8RECs
   g83vIkHV6CtxVpVyTN9wd+INXRBcOEnaZs6u9wgyByO/uoVNSVtIUfNrA
   KRa1eTF5RWpnFPjWQrWgsr+2CXDcaD4LmeddKcLE7shRSaZ39ZPvCyoaM
   UfVt1ASCJ4PjkbOJrbKo3WqfRehCQZeryAzOQ/1KzAwMsirFLjumJ4EUg
   nxzwostwgzxtucl0nIojXyclDDiAY3yrXp4duZlgdBjmQUZkLz6jQ8TqR
   Q==;
X-CSE-ConnectionGUID: 4EHGFDzNQYSFHzb2g83dEw==
X-CSE-MsgGUID: CPR0bBPsR+2VdmGeYy54Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51737079"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51737079"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:18:23 -0700
X-CSE-ConnectionGUID: WlHbpCyQTUiQ7cJ0R6GD8w==
X-CSE-MsgGUID: +VGPoVjVQs+hSUlg7ERgug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152541024"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:18:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 11:18:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 11:18:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.75)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 11:18:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7MEIskREqI8rJ6AFLf4NLuTcH4U8J5VF8V+n8D9P0Nxi+2zRfk8mud1DO5mKoExNhLjSMIKg6TAHHa1QRRgBWbaVWWCPUZiyJPyWf0mwMnSabD4Dvwxj9GOryfGZQu4fnT+gN6cRuXUwh5CIMX5QkkzzVwR8z4f1aWS4MaSPn4OuW8rwyECuQKxrtfygMxh0BMQbuDH9OSKI8ji6ph/5qW2tUA8Ur77MPHPsSG6JhfNMV1Vk+XeZxxFL5rEtopbMitwi+g9wwAcRc+wu59r6dz1xBBt5af46lpmPIr1ijII0LvW6jiCptS0Kxv4hZ/4gIR2bP9or0tj1XUny1Az8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlB322RgvlMjfH7nDueXPnd5S7k8hzreNzsU/4BIqM4=;
 b=YKutfYwW7/ZrMkbIxx05fv0cCysGrRpmcTNWgnjqKsE9mVidbCqIcPIVCFw2qS8fUXbs1uK10nc44QRew1y1z8y3bDXPHO0V5fIjtq27itchkTXMrJbJHp5iU5fGaTqWsdakoAZdb7GUTW2FkPv+KITvRoCYaQCjpXZmWNEyYBOkgPjUiChgducTvhrd3Qv85RzyC74Uj8QD/uEDOrcxLma+yq0JAQxFWJlCypSZq0gcTsCMbcUKg0hDgfWhizYKQKBnumqVeZ1/hvRrou0Uzg5AlhScac4Cxt0mxROEUGscuV2De7B9rgq/puOvscNpqTF2rjqlHyxSr6JnKmWKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 11 Jun
 2025 18:18:20 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 18:18:19 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "irogers@google.com"
	<irogers@google.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Thread-Topic: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Thread-Index: AQHbxF1Wi390zgPnOkKJ8kPrSTjDorP7LGwAgAHVNoCAAXAMAA==
Date: Wed, 11 Jun 2025 18:18:19 +0000
Message-ID: <94612a9d92f4d3820e8c293b0e184ab11971bf36.camel@intel.com>
References: <20250513231813.13846-1-thomas.falcon@intel.com>
	 <20250513231813.13846-2-thomas.falcon@intel.com>
	 <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>
	 <aEiTrRNyeqFsYwR6@google.com>
In-Reply-To: <aEiTrRNyeqFsYwR6@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|LV3PR11MB8604:EE_
x-ms-office365-filtering-correlation-id: d9b13fe6-be96-405a-e557-08dda9145815
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MXhUK0ovRnd6bEo2NTdyUFg1b0M0aFFFbHBYUUF6b2VGSXJzVy94eFBkZDMv?=
 =?utf-8?B?UE5DR2RmUFVhVDJUd1M4cFRxTjZuaUtTNW9zUmhQRnBzdGFUQUdKTHMwY3VX?=
 =?utf-8?B?Z0NybldiM2NZeWxJNjZLMy9nczN1TW5aaG9Ydnd2ZTk3Q3ZhUjQrWGtGQkRn?=
 =?utf-8?B?ejM2cDVndDdpQjRpbENydUd0Ymt3SlA0ekZ1SzBSNlc5T0pRajhYNWdkcTgx?=
 =?utf-8?B?T1JONHlBQmtSRXBWUE1WRGFEYStBMkxwMHBDWE9mNzVYSTBDWGpzSmZFTnVI?=
 =?utf-8?B?ODhuWU9Fbmg2c096UjQxa0hmdzhFYjRDNVE1dWtNL1cwNXJkV1hwNzQvc2dh?=
 =?utf-8?B?T2VZc3lsV05KeE9kOU50bHVMQUlTM09iT3c4VzBSa2puRktIM1hkamdkZHNy?=
 =?utf-8?B?ZmhiaEZJazJrSGptTDd5R2pSb0RweEloOVZNV29lSEdzMDJhUU1lMUJpTzR2?=
 =?utf-8?B?MlhpWWRsdTRTcG9mdmpLM0JIMzMra3U1OTVPZUVVcE9oTFl0VW5UdW5GRzB6?=
 =?utf-8?B?Zlh1eDV2Z2t6UDRmWGxnWXU1WHpaMjVDbllQOENJNVN6WDRSeU8rY3ZlcXp2?=
 =?utf-8?B?dkRoZGd4bmdtazdPNzJoZi9ueHhXTVZkUDJFSWEybStkUU5XU2ZnTTcyQ3g1?=
 =?utf-8?B?cHc0WUhncGpRTGJPNWNrUFV0TmxIMnRrSzg4WG1TUGhRNlc1MHZaWGw0S0ZO?=
 =?utf-8?B?dVcySXordFFvVHY2OGVQakxlMVdrNmVLRnluRUpRdHJtdjdlNkRGMElkd3FT?=
 =?utf-8?B?Mm5ZUFl5bEFPYmt5cGorOGFtbjE3TExxSzhycTA2SVNxNEtYQkNENCtwcnhX?=
 =?utf-8?B?KzBhSGFhQ1I2NjRBaEQ4SDdTc1JidThySlBXNExpUnlMdzFML2kxUVcwcVIw?=
 =?utf-8?B?dDJ1MkdwZGpPRTRMRUgwRTFlQjBlbHRucjl5SnZHYVBWa205azdDRENGL1VH?=
 =?utf-8?B?aHpmMmI4Z0h0OWlEQVA0cWd2TkFuaVVhQmNtYVNrQi9hYm85ZXRyL3RJZW1V?=
 =?utf-8?B?cWdDcGpqSGFySVc3cUZkNmZDL0N2RnI0cGhRUmIwT1dJeHlISGJKQ3k0cWI5?=
 =?utf-8?B?LzRaZkZISFc1L0t6V2dHWVZIYWdUeklnSlV0djlCeVRkSE9yTEF4TW5UbzFq?=
 =?utf-8?B?N0pKUDFIQmxXS3BsRGorR2RkVnU0b1kzeTc2VW5PVi9BQVVmMSt5VFN2WFgy?=
 =?utf-8?B?WWlNMnFITGhDVTFtb0RTeldzM0VXZlN4REFRR2JncUtTTnJEbnpXa1BZeFZI?=
 =?utf-8?B?aFB4UksvNmE2YUhDMWpCS2NLQTFtNjhtMjhjdGZNN1JjOEEvVlF4ZW80SUNl?=
 =?utf-8?B?bmxOeFpwY0VjTTNkdzYzQ3hTVTFGMjNXNDVDbys3M3dPbkdNa3dWdVMwN2Fy?=
 =?utf-8?B?NHJPRlF3U0JBdWRwL0MxMDVpSVVIejA1Syt2UENwV0FCUmQwTDZ2SG1TbVFX?=
 =?utf-8?B?NkhCajl3Y1I5ZWpKeTF5WHE5ZkwzUnR0TTZ5MWVBQXY1cGE0ZU5USjhOUlF3?=
 =?utf-8?B?ZHZNdjRxRlFUT2dtSkoxNHFxTE84bSs0N3E5QWU4TXIxU3FwTDhySXo2TGdy?=
 =?utf-8?B?dFNqNjBQKzBjeFVhMmt1YWZ1dmJ2alRvdXNVZE1VVW1wUzNKUzE5bHJZQURF?=
 =?utf-8?B?U3NDUGtFSGtxM0hFUE5ab3hadm04TWtYUU5CbVh6dG5zMmRpMGJSY1hNUUZG?=
 =?utf-8?B?OFk1QkIvRUVveVNRdkpwcFRCUG0rcHNvcGZNN09XN2JvenB6OEFreWNIOGds?=
 =?utf-8?B?ckZxUm9RN2J5Y25abmJkV2xiMnVFVVUzTVh6NnRkc2VOY1NvSU5YdDJKVjM0?=
 =?utf-8?B?eWYwTkFLTG1VYlJSd0lJaG9ZYWJNZ1hiZFlDNjd4K2tEMFY1Z0ozMWUrdm5J?=
 =?utf-8?B?ajZscHQ4YkUxVmxoRHlSaUcwYjNHNURCLzVlQVlpOUhOUG85VVFCWEUvQ2wr?=
 =?utf-8?B?b1M3c3RIY1hFNXJ3elpzKzd0YUVRUkRqckc0L3N4NzVmWElmUmExUHU3Y045?=
 =?utf-8?Q?S6t6IHwcv0wbRiwUPa36Q0lxPyZwy0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVpSM05RNXVBOUFiM1JqMFMyZHhySTdyTkgyWDd4c1g5QytxeU4xaHd1bXZB?=
 =?utf-8?B?UVJRK2ZwdkxBN05HbksvdUJ1cnQxUzN1cU1ZQzZCNDQrcXZRVkV0bm55cVJo?=
 =?utf-8?B?UE8wWHpjN25uM0JiSndjQmpBYUVlbHRQeUhnT3J4TXB5YWZZb3Rva2QyanJD?=
 =?utf-8?B?MWZpTTRhZWVYeTlmQzFFejRyRnpSY2ZPcTdIMUNTTUFQLzMwZWdjUCtobUUw?=
 =?utf-8?B?T2tQQmcvWDVWbk5yTWFYTkNxaXpyUkUrV1Brb2ltanlwOEFVaGczUWtQSU02?=
 =?utf-8?B?YS9QeVU0UmhJeW5zbzNJM2IvNjk1ZHdKMkNHaXFBbGJHWENGWmxQRkNxUjFE?=
 =?utf-8?B?UmYxak5GbHpRMGVkQWZ6NkxOYytyZDEzZ0tWeGhyZ2J4YUV0Rk9GYkRIb01D?=
 =?utf-8?B?NXNhTEVsRTJjVlBOdlNVRHlWaGh6WlBqUVdxdFV2N3JWM0tIOTdxV2hRV2kr?=
 =?utf-8?B?djR2RnVrN09XTnVxczd6bzFERldMUm8wa0JROXljeXBLenJYVnBVdzdKWC8v?=
 =?utf-8?B?VERRWkNSTlhqaGNWWVdqdjFYb0NBb2ZvZE5XZ2hDQ1Y0b0RVcXlNZ0VxTWYw?=
 =?utf-8?B?V1NERkdUNmpvZUVnWlRrWVRRT2ZNOXV0Q2dyREEwTWJoblVqUjNkTHRXSHpt?=
 =?utf-8?B?VDZ2cHVOcU1NRkZiNnJKWEZiTEhuMU5CS2dnQ0xSSDFaVjNaSHNtZkVJUEhS?=
 =?utf-8?B?dGpoMHRnNWdqKzFzOXVDLzNwdWNzeXdPTzg1YlN0ejF0NWhRKzVwR0xiU2dX?=
 =?utf-8?B?d2JweC9MbXZWWnpiS2hQWDVIeCtlc2Vibm8vV0U1K0pJM29MenF5OERBQzF0?=
 =?utf-8?B?RHBjUC94bnBCN00rdjl1aUhvZy9BaFZkYTlSbXc3eUtodmo5TE1hZFRSNTdy?=
 =?utf-8?B?MGUzTEtCNnMwblRTclhVV1lUVUxuNUZoTzNkckgzeFNTQTJ1ck9yTk8rVjdO?=
 =?utf-8?B?VFlCa1BWSzdLa2NIamJpMmtGY3UxUjNiMDF5SnNFWVFCVTZ1Q0prZUc5OWFM?=
 =?utf-8?B?NEFXaGk5Y25mMndMZ0VSUVgxWUhBQy9ZTVJYNStZV2ZPdjdWb1JrTFpNSVVK?=
 =?utf-8?B?QUFQdk8xOEdiN1g4ZURPWWcxMCtjcUltRFhxK2ZLSDZGVkpyNzNvbU1udnhT?=
 =?utf-8?B?cDNnYkhmdU9RNDlFN0dVeEhydlR4emVWTXQzcnhCVmxrNEl3Qk5ZZjVFREt1?=
 =?utf-8?B?d3B5RU9IeG85bWRTcE9OZ2R3Y3ViYklHSlBGOTd6M2QzMTdZRUIxd1BFZGk2?=
 =?utf-8?B?VnFYeUNwYUo3dHZpLzJxTjlpNk1KblhMVmVaaUdsV2tlRXk5ZDZONkE3OFpl?=
 =?utf-8?B?YWt6K0tjczBNeldiUXJjQktaS08zamsvNWUyYkdVS0RHc2pDNEJMeEtvSmxD?=
 =?utf-8?B?Qi80TEVFM29HamxqZmphT2dkSzVkQTc0STUxd0doOGRKcE40bS9rWkxsOFQ4?=
 =?utf-8?B?d25pVW1jdzd0WU00R0FxdS9TWk5MTHE1OEtMOThhOStpemtiQVRobkNEdVlU?=
 =?utf-8?B?VHVBVnQ3L3AxMHdZZ0sxUkNUMEt3MUFnTGpvUGZkRzBscHlUMGNYRmdWck1Q?=
 =?utf-8?B?dE9RRjdXTERVTU5qUjZoL1BubStDeUhJQnlKSmEzbFFjTlo2Z0UzTXo4eWJm?=
 =?utf-8?B?Q1BCZVJMVGd4b3RPdWJpMEFRK2JMaENuL1Fza09Qb282cFNIMVRNOFkyN1Q0?=
 =?utf-8?B?SE1sMlpZdkNSSGNFZCtvTTBBWTRXWDFPR1NwdDIvWXA3QVU3UGhBdlB0Zkc2?=
 =?utf-8?B?L3pTTmdQMmcvdGM4SGZtbW5CM0hSemREYjB6MlRpbyttQmVaWkt3Z3l3VTdt?=
 =?utf-8?B?dTN4dngzNmhUcUFiemRHYlJHZWwxYTRvaTNLcVQvZDVJTWZkTW9uTDBMV3hx?=
 =?utf-8?B?WUR3Y256emxCNGNEdjBKdjRZbHhMd3U4cTZwVmF1cnVCUCtKck5WNXlPWUZo?=
 =?utf-8?B?Qkw1c08zbjErSUI5cElieXV1U2FqMUR0YnNwcitmMWZWdE52Q1NuL1JGRWFO?=
 =?utf-8?B?ZEszaWVUSjRFZUxqQzBvZ2ZnZWd0Zkc5K0pLNzg1ZUgzcEkzdWFCQ3cyckhn?=
 =?utf-8?B?eHBaRmx5cVRsR002SGpKZ1hSaEhtRFRJRzVJc2hqU1QzWG1iMWZtMGNGMUtr?=
 =?utf-8?B?Q1N5OFM1SXFncFdyMWMySWdvNDVMZXRHUEEwVjlBVmFyeWJKMzQ5UmlCaUc4?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2391FCC8C6779148BB533B825FE2ED9D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b13fe6-be96-405a-e557-08dda9145815
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 18:18:19.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaAwB5TBqKzry6C5O2ThUb2bOWFMfQG/cNFGleTLq4THVNsfe5wFuNxcCKMNREy6sIJqyoV9nW/jhPoVkUj6qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA2LTEwIGF0IDEzOjIxIC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gT24gTW9uLCBKdW4gMDksIDIwMjUgYXQgMDQ6MjE6MzlQTSArMDAwMCwg
RmFsY29uLCBUaG9tYXMgd3JvdGU6DQo+ID4gUGluZz8NCj4gDQo+IFNvcnJ5IGZvciB0aGUgZGVs
YXksIEknbGwgcHJvY2VzcyB0aGUgc2VyaWVzIGFzIGl0J3MgcmV2aWV3ZWQgYnkgSWFuLg0KPiBJ
YW4sIGl0IG1heSBjbGFzaCB3aXRoIHlvdXIgcGVyZl9lbnYgY2xlYW51cCB0aG91Z2guDQo+IA0K
PiBBbHNvIG5vdGUgdGhhdCBwbGVhc2UgZG9uJ3QgbWl4IHBhdGNoIHZlcnNpb25zLiAgVGhlIDEv
MiBpcyB2MSBhbmQgMi8yDQo+IHYzIC0gaXQgbWFrZXMgYjQgY29uZnVzZWQuDQo+IA0KPiBUaGFu
a3MsDQo+IE5hbWh5dW5nDQoNClRoYW5rcyENCg0KVG9tDQoNCj4gDQo+ID4gDQo+ID4gT24gVHVl
LCAyMDI1LTA1LTEzIGF0IDE4OjE4IC0wNTAwLCBUaG9tYXMgRmFsY29uIHdyb3RlOg0KPiA+ID4g
Q2FsbGluZyBwZXJmIHRvcCB3aXRoIGJyYW5jaCBmaWx0ZXJzIGVuYWJsZWQgb24gSW50ZWwgQ1BV
J3MNCj4gPiA+IHdpdGggYnJhbmNoIGNvdW50ZXJzIGxvZ2dpbmcgKEEuSy5BIExCUiBldmVudCBs
b2dnaW5nIFsxXSkgc3VwcG9ydA0KPiA+ID4gcmVzdWx0cyBpbiBhIHNlZ2ZhdWx0Lg0KPiA+ID4g
DQo+ID4gPiBUaHJlYWQgMjcgInBlcmYiIHJlY2VpdmVkIHNpZ25hbCBTSUdTRUdWLCBTZWdtZW50
YXRpb24gZmF1bHQuDQo+ID4gPiBbU3dpdGNoaW5nIHRvIFRocmVhZCAweDdmZmZhZmZmNzZjMCAo
TFdQIDk0OTAwMyldDQo+ID4gPiBwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8gKGVudj0weGY2
NmRjMCA8cGVyZl9lbnY+LCBucj0weDAsIHdpZHRoPTB4N2ZmZmFmZmY2MmMwKSBhdCB1dGlsL2Vu
di5jOjY1Mw0KPiA+ID4gNjUzCQkJKndpZHRoID0gZW52LT5jcHVfcG11X2NhcHMgPyBlbnYtPmJy
X2NudHJfd2lkdGggOg0KPiA+ID4gKGdkYikgYnQNCj4gPiA+ICAjMCAgcGVyZl9lbnZfX2ZpbmRf
YnJfY250cl9pbmZvIChlbnY9MHhmNjZkYzAgPHBlcmZfZW52PiwgbnI9MHgwLCB3aWR0aD0weDdm
ZmZhZmZmNjJjMCkgYXQgdXRpbC9lbnYuYzo2NTMNCj4gPiA+ICAjMSAgMHgwMDAwMDAwMDAwNWIx
NTk5IGluIHN5bWJvbF9fYWNjb3VudF9icl9jbnRyIChicmFuY2g9MHg3ZmZmY2MzZGI1ODAsIGV2
c2VsPTB4ZmVhMmQwLCBvZmZzZXQ9MTIsIGJyX2NudHI9OCkgYXQgdXRpbC9hbm5vdGF0ZS5jOjM0
NQ0KPiA+ID4gICMyICAweDAwMDAwMDAwMDA1YjE3ZmIgaW4gc3ltYm9sX19hY2NvdW50X2N5Y2xl
cyAoYWRkcj01NjU4MTcyLCBzdGFydD01NjU4MTYwLCBzeW09MHg3ZmZmY2MwZWU0MjAsIGN5Y2xl
cz01MzksIGV2c2VsPTB4ZmVhMmQwLCBicl9jbnRyPTgpIGF0IHV0aWwvYW5ub3RhdGUuYzozODkN
Cj4gPiA+ICAjMyAgMHgwMDAwMDAwMDAwNWIxOTc2IGluIGFkZHJfbWFwX3N5bWJvbF9fYWNjb3Vu
dF9jeWNsZXMgKGFtcz0weDdmZmZjZDdiMDFkMCwgc3RhcnQ9MHg3ZmZmY2Q3YjAyYjAsIGN5Y2xl
cz01MzksIGV2c2VsPTB4ZmVhMmQwLCBicl9jbnRyPTgpIGF0IHV0aWwvYW5ub3RhdGUuYzo0MjIN
Cj4gPiA+ICAjNCAgMHgwMDAwMDAwMDAwNjhkNTdmIGluIGhpc3RfX2FjY291bnRfY3ljbGVzIChi
cz0weDExMGQyODgsIGFsPTB4N2ZmZmFmZmY2NTQwLCBzYW1wbGU9MHg3ZmZmYWZmZjY3NjAsIG5v
bmFueV9icmFuY2hfbW9kZT1mYWxzZSwgdG90YWxfY3ljbGVzPTB4MCwgZXZzZWw9MHhmZWEyZDAp
IGF0IHV0aWwvaGlzdC5jOjI4NTANCj4gPiA+ICAjNSAgMHgwMDAwMDAwMDAwNDQ2MjE2IGluIGhp
c3RfaXRlcl9fdG9wX2NhbGxiYWNrIChpdGVyPTB4N2ZmZmFmZmY2NTkwLCBhbD0weDdmZmZhZmZm
NjU0MCwgc2luZ2xlPXRydWUsIGFyZz0weDdmZmZmZmZmOWUwMCkgYXQgYnVpbHRpbi10b3AuYzo3
MzcNCj4gPiA+ICAjNiAgMHgwMDAwMDAwMDAwNjg5Nzg3IGluIGhpc3RfZW50cnlfaXRlcl9fYWRk
IChpdGVyPTB4N2ZmZmFmZmY2NTkwLCBhbD0weDdmZmZhZmZmNjU0MCwgbWF4X3N0YWNrX2RlcHRo
PTEyNywgYXJnPTB4N2ZmZmZmZmY5ZTAwKSBhdCB1dGlsL2hpc3QuYzoxMzU5DQo+ID4gPiAgIzcg
IDB4MDAwMDAwMDAwMDQ0NjcxMCBpbiBwZXJmX2V2ZW50X19wcm9jZXNzX3NhbXBsZSAodG9vbD0w
eDdmZmZmZmZmOWUwMCwgZXZlbnQ9MHgxMTBkMjUwLCBldnNlbD0weGZlYTJkMCwgc2FtcGxlPTB4
N2ZmZmFmZmY2NzYwLCBtYWNoaW5lPTB4MTA4Yzk2OCkgYXQgYnVpbHRpbi10b3AuYzo4NDUNCj4g
PiA+ICAjOCAgMHgwMDAwMDAwMDAwNDQ3NzM1IGluIGRlbGl2ZXJfZXZlbnQgKHFlPTB4N2ZmZmZm
ZmZhMTIwLCBxZXZlbnQ9MHgxMGZjMjAwKSBhdCBidWlsdGluLXRvcC5jOjEyMTENCj4gPiA+ICAj
OSAgMHgwMDAwMDAwMDAwNjRjY2FlIGluIGRvX2ZsdXNoIChvZT0weDdmZmZmZmZmYTEyMCwgc2hv
d19wcm9ncmVzcz1mYWxzZSkgYXQgdXRpbC9vcmRlcmVkLWV2ZW50cy5jOjI0NQ0KPiA+ID4gICMx
MCAweDAwMDAwMDAwMDA2NGQwMDUgaW4gX19vcmRlcmVkX2V2ZW50c19fZmx1c2ggKG9lPTB4N2Zm
ZmZmZmZhMTIwLCBob3c9T0VfRkxVU0hfX1RPUCwgdGltZXN0YW1wPTApIGF0IHV0aWwvb3JkZXJl
ZC1ldmVudHMuYzozMjQNCj4gPiA+ICAjMTEgMHgwMDAwMDAwMDAwNjRkMGVmIGluIG9yZGVyZWRf
ZXZlbnRzX19mbHVzaCAob2U9MHg3ZmZmZmZmZmExMjAsIGhvdz1PRV9GTFVTSF9fVE9QKSBhdCB1
dGlsL29yZGVyZWQtZXZlbnRzLmM6MzQyDQo+ID4gPiAgIzEyIDB4MDAwMDAwMDAwMDQ0NzJhOSBp
biBwcm9jZXNzX3RocmVhZCAoYXJnPTB4N2ZmZmZmZmY5ZTAwKSBhdCBidWlsdGluLXRvcC5jOjEx
MjANCj4gPiA+ICAjMTMgMHgwMDAwN2ZmZmY2ZTdkYmE4IGluIHN0YXJ0X3RocmVhZCAoYXJnPTxv
cHRpbWl6ZWQgb3V0PikgYXQgcHRocmVhZF9jcmVhdGUuYzo0NDgNCj4gPiA+ICAjMTQgMHgwMDAw
N2ZmZmY2ZjAxYjhjIGluIF9fR0lfX19jbG9uZTMgKCkgYXQgLi4vc3lzZGVwcy91bml4L3N5c3Yv
bGludXgveDg2XzY0L2Nsb25lMy5TOjc4DQo+ID4gPiANCj4gPiA+IFRoZSBjYXVzZSBpcyB0aGF0
IHBlcmZfZW52X19maW5kX2JyX2NudHJfaW5mbyB0cmllcyB0byBhY2Nlc3MgYQ0KPiA+ID4gbnVs
bCBwb2ludGVyIHBtdV9jYXBzIGluIHRoZSBwZXJmX2VudiBzdHJ1Y3QuIEEgc2ltaWxhciBpc3N1
ZSBleGlzdHMNCj4gPiA+IGZvciBob21vZ2VuZW91cyBjb3JlIHN5c3RlbXMgd2hpY2ggdXNlIHRo
ZSBjcHVfcG11X2NhcHMgc3RydWN0dXJlLg0KPiA+ID4gDQo+ID4gPiBGaXggdGhpcyBieSBwb3B1
bGF0aW5nIGNwdV9wbXVfY2FwcyBhbmQgcG11X2NhcHMgc3RydWN0dXJlcyB3aXRoDQo+ID4gPiB2
YWx1ZXMgZnJvbSBzeXNmcyB3aGVuIGNhbGxpbmcgcGVyZiB0b3Agd2l0aCBicmFuY2ggc3RhY2sg
c2FtcGxpbmcNCj4gPiA+IGVuYWJsZWQuDQo+ID4gPiANCj4gPiA+IFsxXSwgTEJSIGV2ZW50IGxv
Z2dpbmcgaW50cm9kdWNlZCBoZXJlOg0KPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjMxMDI1MjAxNjI2LjMwMDAyMjgtNS1rYW4ubGlhbmdAbGludXguaW50ZWwuY29tLw0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGlu
dGVsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gdjM6IGNvbnN0aWZ5IHN0cnVjdCBwZXJmX3BtdSAq
cG11IGluIF9fcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2FwcygpDQo+ID4gPiAgICAgdXNlIHBl
cmZfcG11c19fZmluZF9jb3JlX3BtdSgpIGluc3RlYWQgb2YgcGVyZl9wbXVzX19zY2FuX2NvcmUo
TlVMTCkNCj4gPiA+IA0KPiA+ID4gdjI6IHVwZGF0ZSBjb21taXQgbWVzc2FnZSB3aXRoIG1vcmUg
bWVhbmluZ2Z1bCBzdGFjayB0cmFjZSBmcm9tDQo+ID4gPiAgICAgZ2RiIGFuZCBpbmRpY2F0ZSB0
aGF0IGFmZmVjdGVkIHN5c3RlbXMgYXJlIGxpbWl0ZWQgdG8gQ1BVJ3MNCj4gPiA+ICAgICB3aXRo
IExCUiBldmVudCBsb2dnaW5nIHN1cHBvcnQgYW5kIHRoYXQgYm90aCBoeWJyaWQgYW5kDQo+ID4g
PiAgICAgbm9uLWh5YnJpZCBjb3JlIHN5c3RlbXMgYXJlIGFmZmVjdGVkLg0KPiA+ID4gLS0tDQo+
ID4gPiAgdG9vbHMvcGVyZi9idWlsdGluLXRvcC5jIHwgICA4ICsrKw0KPiA+ID4gIHRvb2xzL3Bl
cmYvdXRpbC9lbnYuYyAgICB8IDExNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiA+ICB0b29scy9wZXJmL3V0aWwvZW52LmggICAgfCAgIDEgKw0KPiA+ID4gIDMg
ZmlsZXMgY2hhbmdlZCwgMTIzIGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdp
dCBhL3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYw0K
PiA+ID4gaW5kZXggZjlmMzEzOTFiZGRiLi5jOWQ2Nzk0MTA1OTEgMTAwNjQ0DQo+ID4gPiAtLS0g
YS90b29scy9wZXJmL2J1aWx0aW4tdG9wLmMNCj4gPiA+ICsrKyBiL3Rvb2xzL3BlcmYvYnVpbHRp
bi10b3AuYw0KPiA+ID4gQEAgLTE3MjksNiArMTcyOSwxNCBAQCBpbnQgY21kX3RvcChpbnQgYXJn
YywgY29uc3QgY2hhciAqKmFyZ3YpDQo+ID4gPiAgCWlmIChvcHRzLT5icmFuY2hfc3RhY2sgJiYg
Y2FsbGNoYWluX3BhcmFtLmVuYWJsZWQpDQo+ID4gPiAgCQlzeW1ib2xfY29uZi5zaG93X2JyYW5j
aGZsYWdfY291bnQgPSB0cnVlOw0KPiA+ID4gIA0KPiA+ID4gKwlpZiAob3B0cy0+YnJhbmNoX3N0
YWNrKSB7DQo+ID4gPiArCQlzdGF0dXMgPSBwZXJmX2Vudl9fcmVhZF9jb3JlX3BtdV9jYXBzKCZw
ZXJmX2Vudik7DQo+ID4gPiArCQlpZiAoc3RhdHVzKSB7DQo+ID4gPiArCQkJcHJfZXJyKCJQTVUg
Y2FwYWJpbGl0eSBkYXRhIGlzIG5vdCBhdmFpbGFibGVcbiIpOw0KPiA+ID4gKwkJCWdvdG8gb3V0
X2RlbGV0ZV9ldmxpc3Q7DQo+ID4gPiArCQl9DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICAJ
c29ydF9fbW9kZSA9IFNPUlRfTU9ERV9fVE9QOw0KPiA+ID4gIAkvKiBkaXNwbGF5IHRocmVhZCB3
YW50cyBlbnRyaWVzIHRvIGJlIGNvbGxhcHNlZCBpbiBhIGRpZmZlcmVudCB0cmVlICovDQo+ID4g
PiAgCXBlcmZfaHBwX2xpc3QubmVlZF9jb2xsYXBzZSA9IDE7DQo+ID4gPiBkaWZmIC0tZ2l0IGEv
dG9vbHMvcGVyZi91dGlsL2Vudi5jIGIvdG9vbHMvcGVyZi91dGlsL2Vudi5jDQo+ID4gPiBpbmRl
eCAzNjQxMTc0OWUwMDcuLjY3MzU3ODZhMWQyMiAxMDA2NDQNCj4gPiA+IC0tLSBhL3Rvb2xzL3Bl
cmYvdXRpbC9lbnYuYw0KPiA+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2Vudi5jDQo+ID4gPiBA
QCAtNDE2LDYgKzQxNiwxMjAgQEAgc3RhdGljIGludCBwZXJmX2Vudl9fcmVhZF9ucl9jcHVzX2F2
YWlsKHN0cnVjdCBwZXJmX2VudiAqZW52KQ0KPiA+ID4gIAlyZXR1cm4gZW52LT5ucl9jcHVzX2F2
YWlsID8gMCA6IC1FTk9FTlQ7DQo+ID4gPiAgfQ0KPiA+ID4gIA0KPiA+ID4gK3N0YXRpYyBpbnQg
X19wZXJmX2Vudl9fcmVhZF9jb3JlX3BtdV9jYXBzKGNvbnN0IHN0cnVjdCBwZXJmX3BtdSAqcG11
LA0KPiA+ID4gKwkJCQkJICBpbnQgKm5yX2NhcHMsIGNoYXIgKioqY2FwcywNCj4gPiA+ICsJCQkJ
CSAgdW5zaWduZWQgaW50ICptYXhfYnJhbmNoZXMsDQo+ID4gPiArCQkJCQkgIHVuc2lnbmVkIGlu
dCAqYnJfY250cl9uciwNCj4gPiA+ICsJCQkJCSAgdW5zaWduZWQgaW50ICpicl9jbnRyX3dpZHRo
KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IHBlcmZfcG11X2NhcHMgKnBjYXBzID0gTlVMTDsN
Cj4gPiA+ICsJY2hhciAqcHRyLCAqKnRtcDsNCj4gPiA+ICsJaW50IHJldCA9IDA7DQo+ID4gPiAr
DQo+ID4gPiArCSpucl9jYXBzID0gMDsNCj4gPiA+ICsJKmNhcHMgPSBOVUxMOw0KPiA+ID4gKw0K
PiA+ID4gKwlpZiAoIXBtdS0+bnJfY2FwcykNCj4gPiA+ICsJCXJldHVybiAwOw0KPiA+ID4gKw0K
PiA+ID4gKwkqY2FwcyA9IHphbGxvYyhzaXplb2YoY2hhciAqKSAqIHBtdS0+bnJfY2Fwcyk7DQo+
ID4gPiArCWlmICghKmNhcHMpDQo+ID4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+ICsNCj4g
PiA+ICsJdG1wID0gKmNhcHM7DQo+ID4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkocGNhcHMsICZw
bXUtPmNhcHMsIGxpc3QpIHsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmIChhc3ByaW50ZigmcHRyLCAi
JXM9JXMiLCBwY2Fwcy0+bmFtZSwgcGNhcHMtPnZhbHVlKSA8IDApIHsNCj4gPiA+ICsJCQlyZXQg
PSAtRU5PTUVNOw0KPiA+ID4gKwkJCWdvdG8gZXJyb3I7DQo+ID4gPiArCQl9DQo+ID4gPiArDQo+
ID4gPiArCQkqdG1wKysgPSBwdHI7DQo+ID4gPiArDQo+ID4gPiArCQlpZiAoIXN0cmNtcChwY2Fw
cy0+bmFtZSwgImJyYW5jaGVzIikpDQo+ID4gPiArCQkJKm1heF9icmFuY2hlcyA9IGF0b2kocGNh
cHMtPnZhbHVlKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmICghc3RyY21wKHBjYXBzLT5uYW1lLCAi
YnJhbmNoX2NvdW50ZXJfbnIiKSkNCj4gPiA+ICsJCQkqYnJfY250cl9uciA9IGF0b2kocGNhcHMt
PnZhbHVlKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmICghc3RyY21wKHBjYXBzLT5uYW1lLCAiYnJh
bmNoX2NvdW50ZXJfd2lkdGgiKSkNCj4gPiA+ICsJCQkqYnJfY250cl93aWR0aCA9IGF0b2kocGNh
cHMtPnZhbHVlKTsNCj4gPiA+ICsJfQ0KPiA+ID4gKwkqbnJfY2FwcyA9IHBtdS0+bnJfY2FwczsN
Cj4gPiA+ICsJcmV0dXJuIDA7DQo+ID4gPiArZXJyb3I6DQo+ID4gPiArCXdoaWxlICh0bXAtLSAh
PSAqY2FwcykNCj4gPiA+ICsJCWZyZWUoKnRtcCk7DQo+ID4gPiArCWZyZWUoKmNhcHMpOw0KPiA+
ID4gKwkqY2FwcyA9IE5VTEw7DQo+ID4gPiArCSpucl9jYXBzID0gMDsNCj4gPiA+ICsJcmV0dXJu
IHJldDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAraW50IHBlcmZfZW52X19yZWFkX2NvcmVf
cG11X2NhcHMoc3RydWN0IHBlcmZfZW52ICplbnYpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3Qg
cGVyZl9wbXUgKnBtdSA9IE5VTEw7DQo+ID4gPiArCXN0cnVjdCBwbXVfY2FwcyAqcG11X2NhcHM7
DQo+ID4gPiArCWludCBucl9wbXUgPSAwLCBpID0gMCwgajsNCj4gPiA+ICsJaW50IHJldDsNCj4g
PiA+ICsNCj4gPiA+ICsJbnJfcG11ID0gcGVyZl9wbXVzX19udW1fY29yZV9wbXVzKCk7DQo+ID4g
PiArDQo+ID4gPiArCWlmICghbnJfcG11KQ0KPiA+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4g
PiArDQo+ID4gPiArCWlmIChucl9wbXUgPT0gMSkgew0KPiA+ID4gKwkJcG11ID0gcGVyZl9wbXVz
X19maW5kX2NvcmVfcG11KCk7DQo+ID4gPiArCQlpZiAoIXBtdSkNCj4gPiA+ICsJCQlyZXR1cm4g
LUVOT0RFVjsNCj4gPiA+ICsJCXJldCA9IHBlcmZfcG11X19jYXBzX3BhcnNlKHBtdSk7DQo+ID4g
PiArCQlpZiAocmV0IDwgMCkNCj4gPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ID4gKwkJcmV0dXJu
IF9fcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2FwcyhwbXUsICZlbnYtPm5yX2NwdV9wbXVfY2Fw
cywNCj4gPiA+ICsJCQkJCQkgICAgICAmZW52LT5jcHVfcG11X2NhcHMsDQo+ID4gPiArCQkJCQkJ
ICAgICAgJmVudi0+bWF4X2JyYW5jaGVzLA0KPiA+ID4gKwkJCQkJCSAgICAgICZlbnYtPmJyX2Nu
dHJfbnIsDQo+ID4gPiArCQkJCQkJICAgICAgJmVudi0+YnJfY250cl93aWR0aCk7DQo+ID4gPiAr
CX0NCj4gPiA+ICsNCj4gPiA+ICsJcG11X2NhcHMgPSB6YWxsb2Moc2l6ZW9mKCpwbXVfY2Fwcykg
KiBucl9wbXUpOw0KPiA+ID4gKwlpZiAoIXBtdV9jYXBzKQ0KPiA+ID4gKwkJcmV0dXJuIC1FTk9N
RU07DQo+ID4gPiArDQo+ID4gPiArCXdoaWxlICgocG11ID0gcGVyZl9wbXVzX19zY2FuX2NvcmUo
cG11KSkgIT0gTlVMTCkgew0KPiA+ID4gKwkJaWYgKHBlcmZfcG11X19jYXBzX3BhcnNlKHBtdSkg
PD0gMCkNCj4gPiA+ICsJCQljb250aW51ZTsNCj4gPiA+ICsJCXJldCA9IF9fcGVyZl9lbnZfX3Jl
YWRfY29yZV9wbXVfY2FwcyhwbXUsICZwbXVfY2Fwc1tpXS5ucl9jYXBzLA0KPiA+ID4gKwkJCQkJ
CSAgICAgJnBtdV9jYXBzW2ldLmNhcHMsDQo+ID4gPiArCQkJCQkJICAgICAmcG11X2NhcHNbaV0u
bWF4X2JyYW5jaGVzLA0KPiA+ID4gKwkJCQkJCSAgICAgJnBtdV9jYXBzW2ldLmJyX2NudHJfbnIs
DQo+ID4gPiArCQkJCQkJICAgICAmcG11X2NhcHNbaV0uYnJfY250cl93aWR0aCk7DQo+ID4gPiAr
CQlpZiAocmV0KQ0KPiA+ID4gKwkJCWdvdG8gZXJyb3I7DQo+ID4gPiArDQo+ID4gPiArCQlwbXVf
Y2Fwc1tpXS5wbXVfbmFtZSA9IHN0cmR1cChwbXUtPm5hbWUpOw0KPiA+ID4gKwkJaWYgKCFwbXVf
Y2Fwc1tpXS5wbXVfbmFtZSkgew0KPiA+ID4gKwkJCXJldCA9IC1FTk9NRU07DQo+ID4gPiArCQkJ
Z290byBlcnJvcjsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJCWkrKzsNCj4gPiA+ICsJfQ0KPiA+ID4g
Kw0KPiA+ID4gKwllbnYtPm5yX3BtdXNfd2l0aF9jYXBzID0gbnJfcG11Ow0KPiA+ID4gKwllbnYt
PnBtdV9jYXBzID0gcG11X2NhcHM7DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiAwOw0KPiA+ID4g
K2Vycm9yOg0KPiA+ID4gKwlmb3IgKGkgPSAwOyBpIDwgbnJfcG11OyBpKyspIHsNCj4gPiA+ICsJ
CWZvciAoaiA9IDA7IGogPCBwbXVfY2Fwc1tpXS5ucl9jYXBzOyBqKyspDQo+ID4gPiArCQkJZnJl
ZShwbXVfY2Fwc1tpXS5jYXBzW2pdKTsNCj4gPiA+ICsJCWZyZWUocG11X2NhcHNbaV0uY2Fwcyk7
DQo+ID4gPiArCQlmcmVlKHBtdV9jYXBzW2ldLnBtdV9uYW1lKTsNCj4gPiA+ICsJfQ0KPiA+ID4g
KwlmcmVlKHBtdV9jYXBzKTsNCj4gPiA+ICsJcmV0dXJuIHJldDsNCj4gPiA+ICt9DQo+ID4gPiAr
DQo+ID4gPiAgY29uc3QgY2hhciAqcGVyZl9lbnZfX3Jhd19hcmNoKHN0cnVjdCBwZXJmX2VudiAq
ZW52KQ0KPiA+ID4gIHsNCj4gPiA+ICAJcmV0dXJuIGVudiAmJiAhcGVyZl9lbnZfX3JlYWRfYXJj
aChlbnYpID8gZW52LT5hcmNoIDogInVua25vd24iOw0KPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xz
L3BlcmYvdXRpbC9lbnYuaCBiL3Rvb2xzL3BlcmYvdXRpbC9lbnYuaA0KPiA+ID4gaW5kZXggZDkw
ZTM0M2NmMWZhLi4xMzVhMWY3MTQ5MDUgMTAwNjQ0DQo+ID4gPiAtLS0gYS90b29scy9wZXJmL3V0
aWwvZW52LmgNCj4gPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdXRpbC9lbnYuaA0KPiA+ID4gQEAgLTE1
Miw2ICsxNTIsNyBAQCBzdHJ1Y3QgYnRmX25vZGU7DQo+ID4gPiAgDQo+ID4gPiAgZXh0ZXJuIHN0
cnVjdCBwZXJmX2VudiBwZXJmX2VudjsNCj4gPiA+ICANCj4gPiA+ICtpbnQgcGVyZl9lbnZfX3Jl
YWRfY29yZV9wbXVfY2FwcyhzdHJ1Y3QgcGVyZl9lbnYgKmVudik7DQo+ID4gPiAgdm9pZCBwZXJm
X2Vudl9fZXhpdChzdHJ1Y3QgcGVyZl9lbnYgKmVudik7DQo+ID4gPiAgDQo+ID4gPiAgaW50IHBl
cmZfZW52X19rZXJuZWxfaXNfNjRfYml0KHN0cnVjdCBwZXJmX2VudiAqZW52KTsNCj4gPiANCg0K
