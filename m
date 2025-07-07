Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8791BF37;
	Mon,  7 Jul 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751925063; cv=fail; b=u51pGt+sxp5ZbvLI1bjrV3XoWWU+P0eBj8GHydy12w/NJAWPu4C9BlxKC2YuF5BxkUBG0cerFjDjLbvuFxWNQv9Nv3SCyqin4BTK9aZXHA+pkvwMd6arIVpLJcdnEzr73cEvxaP121ni/rCw7cEz+QsmaEB7YDowkhlsU6n0JrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751925063; c=relaxed/simple;
	bh=ix+5lr+TcQfJPGZ6/IWjYxjKKIW5lL8oHDMiZjRdbxE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GR+70462l+V6XtySCZI0va4gozo9ot+1uKrAkr90EBKa2iapAi0MKKjSNJCM3SLEeTVuAjVVS0REhCc16zMHPs+wkIjvaSXLrOTBAT7WHWcM9ljqYMBapleQofUb5CwTjsoTco2sOsvajyPKdFlE60l9RoS/7iZlVnyHyLqtmjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPbgOYKs; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPbgOYKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751925062; x=1783461062;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ix+5lr+TcQfJPGZ6/IWjYxjKKIW5lL8oHDMiZjRdbxE=;
  b=aPbgOYKsX7sxXTh5xhl+UvX+BTylCptWqcuVh8YJOmbnt2K7kJYfDngj
   ubd+61WcYQKBWo73Yt/ZTaQifEjnTtGAM6F2RBc36Tru0Rri8bwpW3Dve
   Im+QH7YvURxW4wlUJQhHWJvX7bU8Nb3jzweIvAPRIV04wFaGBsQ/CHQVn
   fxf4HqNlVlpNikMB8B2rs+QroW5BQT7bcqclVFHT6FzUFzVuHafIp0MZs
   eaJCFfQLKnKRAmNQra+/myn3RFO5RzqS+kUIGwoVXWNjqBld4KqogATEa
   FVUz2LBa+WPWaQfG0sDMs3bn7xw3HqK/s6xTcAFdkAv+NNKw457t4D91d
   g==;
X-CSE-ConnectionGUID: CMulEjysRASulEnDEU1y8A==
X-CSE-MsgGUID: YNAydlEDTXO+7h7O0urOEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57828538"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57828538"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:51:01 -0700
X-CSE-ConnectionGUID: IGlUZZb3Sjqq2eaKO3i5Sw==
X-CSE-MsgGUID: 1Xt22OiVTmu4dO1EU6x32A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="178990465"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 14:51:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 14:50:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 14:50:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 14:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbV7yud52OU4+TGoZnoZLqh5yTDi2QS07a/35+yTaRKX/N1RqmCCleUjVmb9lP7SY7Elt32wEOwp451bIxgD3CAhUeOM/VKNnrw/BSD8WL8T/rFqCIVbdfcB6fPGIuLqEsvWoW9LYaGS1pdxkhySZ3k/toYQwP0BpfU9IaN0h/2g33dc7r76iWJkWCbN71zIrjE2toEVfabYK33NFmbnf3xUt/fuRdxGCTC23VHJzt8puG6/y9r3yD6W771XknOy1YMzAeGuXmI1lcJnUnr5+1DMf9+q40xIoEjtWFTwxbW2NcQKaB9HAdTMelVJHTXQEMwjglYGCZhFRTvIcmA5MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix+5lr+TcQfJPGZ6/IWjYxjKKIW5lL8oHDMiZjRdbxE=;
 b=ZXNnQbiGL3e/FMSEUzLm32AlCrRejVFLRLGtuXWBVO4Qme+/byAbpX+7IoYisIo0fNonhGfNS7uIh/s7UiSAOOjhyA7T/JdURBls9apYcXKFBMRVXO8UEvXks2oAQcg4bM94DtKyOdFFwfWciMh4fMUfYjymXPimPiItr7E650qaYDCFoq2bXRvdLkFP3QlbE8SCcz2gkAB3CS8XYUqLXP2U5lLhtqvx440WZ5o+/Xv8yGcd6WQXZ4VTTIa+Xw7n07GAkd1ufb9NAUSZR7TELmHC9zvRLUrBbcmeZJA5LLxuIui56YfF41MDub9D+F8VsL2Oq8pNps2YKaHULR3vIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Mon, 7 Jul
 2025 21:50:21 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 21:50:21 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"afaerber@suse.de" <afaerber@suse.de>, "Biggers, Caleb"
	<caleb.biggers@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mani@kernel.org" <mani@kernel.org>
Subject: Re: [PATCH v2 00/15] perf vendor events: Update Intel events
Thread-Topic: [PATCH v2 00/15] perf vendor events: Update Intel events
Thread-Index: AQHb6dxtnTHZPJ7KO0uIugc3+AKRTLQnPoqA
Date: Mon, 7 Jul 2025 21:50:21 +0000
Message-ID: <b8fa881ed65effdf378320b0aa92c51f96fbb50d.camel@intel.com>
References: <20250630163101.1920170-1-irogers@google.com>
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CY8PR11MB7107:EE_
x-ms-office365-filtering-correlation-id: 930898d9-d7da-412a-a722-08ddbda04571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEtqb0JVbnpZbGFGbHFkMFFsUngyamplOXNUYVd1VFBWSU9HaXFjb1l4NTBs?=
 =?utf-8?B?dVkzODY1cDBJdG1vbWxQUmdOVGtzeGxDRXJSSCtNWjE3THFKWGxyUCtDZUVo?=
 =?utf-8?B?SEd2a2NjbFIyQzRKbVpoR1RFY3oxcmJVMGxKaEJ2bHAwWmFacnBrVDE3UXJp?=
 =?utf-8?B?YVN2Sk9KUUlrWHJKdSt1RENoc2lpQS9EeElXNHhndTh1eEo1T3BNNjI0WC9O?=
 =?utf-8?B?VURGSk1VVkZFV3NmMmJjcXNqZmNMNHBZMUtTTG5lcEVkeW5xOXUxWnREa3dI?=
 =?utf-8?B?VlVPTDJXTDM2dkpsVXh6L0xsbjhPYnRoMGhYV3psTFB2VUoyYm9DeUFuYnpK?=
 =?utf-8?B?MVd2MnlYYkMzbTl0amZLSjNpdm93WTRQMTgwYlFuNDRBKytsUjM1cDlGNlpQ?=
 =?utf-8?B?cUd2YWdLak9QNWxtcksxdHlxN1liVEgxQSt4OERXZlBPS2R2QVRkR0x4SGNz?=
 =?utf-8?B?RXFBOWZpd21YK2puS0hrRTVBYThpZmQzUTNWL3AwZEpOSHg3aW1CRWpSVEdL?=
 =?utf-8?B?L3dQb1Y5T3JDVG9jYTF4U1dkS09kcTA2Y2NoU3ZRWkZTVTZQS21ENnUvdy9h?=
 =?utf-8?B?eU5adTdrY1VzVFhyYXlsR2dGS2Q0SUx1QjZUUVN3UTFENHdWSXh1TDI4Ung4?=
 =?utf-8?B?bnJqby9ZOGl5TGMwZHdXNE0zT0cwMGVoVXYybnJDT0lmYjRLZS8xMzhjOHlQ?=
 =?utf-8?B?cnVETTRnQzVrTmlTY3V3dEJjWDdudE44RXNvTXF4b1Z5STlNRFYrOEhwb2di?=
 =?utf-8?B?Y3RHUk1iTXRhYUw0Y2NYQjVRTjZuQk5tSk1VWUxkOW12UmRoU3ZtaGhPUlY5?=
 =?utf-8?B?czFJQzZCV0ZBV25teUpibms0ZUpGR0MvNkFQMUFNNmljTGdGc3VKREhxZjdl?=
 =?utf-8?B?b3VYOE9xbFlxR3UyaTdCMVo4bHJ1cUpQZWtVdzFvWGI0YWt6Q25GNFdqM1Ba?=
 =?utf-8?B?dW1xWEVBQmV0L0h6QVpTWVlWLzZkVDJ0c2JKVEkxR0FKSzE2aFFCVHI4M20y?=
 =?utf-8?B?djVKR01oMWdiZVZVdTk1VXpaNWMvVmdZNEdwRmF0Zm9SbDNwQ2YwOFM0bDdO?=
 =?utf-8?B?QWlwYy8rZXdUVlJxWk9KYkQxK0NrMW82cjFaazROR3lnR3l1ZC8vYWlrbEcw?=
 =?utf-8?B?STlFdVAxOG01YUdvd25ld21CczgyL0JNTXRpZXNVZjBlNzh4aTE1MFo5ZHU0?=
 =?utf-8?B?SEtuYnJES2dhVW5HZmR4TmZvd3U5Uk1sUW1RNzZqS2grazJJZ0pZTm1SM0xz?=
 =?utf-8?B?Y05xdGV0bGtEeTh3QUM4bFptTXFEMENzYVRrTnZjb0FKc1Y1RzdFRmNydG9t?=
 =?utf-8?B?dk5sQ3hSTXg3d1pKZWI5VFdweTh4ejJnT3hsRVRsMXpuVmlOUkd5VlJCdm9m?=
 =?utf-8?B?MlNGZHNTRFhMQisvNE5IZk1VeHJvc2lXd1ZmQXc4cllxaEZKbENuOC8rMWhr?=
 =?utf-8?B?akVkeENPOHpMZ3JsRS9ZZzhIMzl5U0gxeW5oZk5BMmwxK0h0VzFRdkk2Mmkw?=
 =?utf-8?B?ZHEwSXVGNUl1WEJzUGlJb045TGMwQUM3VlVQOFV0TlNqL3RvYzE0WXUxOGxy?=
 =?utf-8?B?a2p1WDBjekNMbHl4bVpJYjJobUEvZzU0RlhOYVNXQVB1OUxvOFd1dEhIbjh1?=
 =?utf-8?B?QUIrUEV4ZmZqMWgwOG9JTHlYcVN3TjhzN29GQXJteUFBN2E1UWxVWkw1WUtp?=
 =?utf-8?B?TjRYYnIxQkdMemJBSkJONEc4RGR5c1BkaGlPZm40cUN1eW41YkxUNHB2Unk2?=
 =?utf-8?B?RkhvVWNnODF3eFYxYTI0amFEVkJwQWVCZ1djMFV4cG1xUEtlWW03S3lZWVgx?=
 =?utf-8?B?NXJ6aHJVYnpaS0NPOExhSE1Qa2M4S1dLT0xCSGsvcG1aTjVKTkJFVnc5U2tr?=
 =?utf-8?B?N0k2QmxrYU1uOG5kaHhuekRSMXdZTGNvQTVUUHNXaFVXN3QvMHdLaVF1Wll3?=
 =?utf-8?B?T090QVdJYmNOb2QvYVJFNTZ3MEdXc052NWMveTJFcVNmZW1iaVhiUUM5YUh5?=
 =?utf-8?B?VWZVcERJd0N3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnVtaXozdWRRamxYTkFPbTRmLy9UNWhkT0luRjlHUlFUbVU4V2ErMjFTd2kz?=
 =?utf-8?B?RURhaEFDbmlHdko3eW05YkVrOVY4SVFNZEhrWWdYZnUzc3V0MGlHa0F0bUY4?=
 =?utf-8?B?dEt3SG1Xc2VZU2daUzNMZHlZRHJtVUVCMDVTQjYwZkh6K0Fod2ZGa25NMGxI?=
 =?utf-8?B?MjFtQ1VDQmkxMWpTWSt5TnI1MnY4NVFEYXEvV0REVXNsSVlJNXZDWFpYQmtM?=
 =?utf-8?B?M012dElObXIyd0VtM0VaaTcxQlJMcmwyam81TzgxN0hQcVJSdFZ4emdQQ0tU?=
 =?utf-8?B?YXczTjNNdUhLRmwwd3BVUXpjczg3Yy9ydVdxekt2aGpkbWNIVzJ1dnNnQnRG?=
 =?utf-8?B?SkZhTmtaUUhWajBhTnVUaHJpcGkyWFR3dTg5RnhQTVdvaE93M1QvL1NQa1E3?=
 =?utf-8?B?ODZDTjVMOUt1NTZmYmlqK25rK1NzQ245L1g5VldzczNiTjE4YmNqTUpKaG1L?=
 =?utf-8?B?NEFRTmRuY0MveVB1VnRnbDc2QjFVSitkaVBLL0RDeXZCZVJhSFFueitsVW12?=
 =?utf-8?B?T2s4VWZGbmx0K3IyM2NtNFcxSTRpQlkrN0VyaHF1UmorREJQS25JTHp6RVRs?=
 =?utf-8?B?ZVI1MlNpdUtzRHJpY2l6UTNxTDVEVGoxSnFwYk9vZ29kOGp3U3JqNGRpOU80?=
 =?utf-8?B?UnBKWWRnS0RYTzRxQk9XWmx1M3Bva0plNUV6T1lxcDhOdEVkT2tjOGxySzdN?=
 =?utf-8?B?bGExV2FlMDhBdUtDSzF3ZlFsUG5UYlRSb2EyWXUxek0xNzVMRTNKalpvT1ox?=
 =?utf-8?B?MEV6SzE1T2RFUUlncGNuOEttYk1NWEY0YjB4WDVyTVpCQklDQVZPZmVMM0tp?=
 =?utf-8?B?bUZuOERwUy9BVDVsWG9YVFR5TjBYK1JUU2E2WnhGbVdGQmsxaVVpaTg5SzlQ?=
 =?utf-8?B?UmlBRGFyWFdMaEtiK2pGU1JUejVYTG1BL3c0QjZtcWFyMHQ3SWY1UTVEdG9x?=
 =?utf-8?B?azZTVm1rVjNYZmdBeVI2dFltdUZtTmdmNGkwSWNHbjBCbWVsbnQxZUdFZFdl?=
 =?utf-8?B?TGNYZFhOMDFPU3ZuVjBvcW15T3NscXF6enkwdGFFSzRjMlJkS05DSDd3TFFG?=
 =?utf-8?B?dW5jRjY3VWd3S2ttVDM1T3NmdGtOVmNrUkNhdjFOOEIxNlhZVUFYaWJhU1d5?=
 =?utf-8?B?UjFHU3g3T1ZORjFHOGNMY2loc3FhSVgrMnA0dXVQblVJNUFVUXlUK1gvbDN1?=
 =?utf-8?B?LzRWK0dETHNUTW8rdVFzdmNid201b2JFaFE4aU5WMzhUWWg0Z1hhMlRTR0E3?=
 =?utf-8?B?QzVQeHlPZkx1REtaR3lRenVuZDdCdGR6NDd5R3dDcWFWME9NYlZpNDFaN0dF?=
 =?utf-8?B?YWZ6TFRiOVV0a0c5T0V6a2RuZXJMcjd0UUg5VlFnbGRWaEVYRzhIbW5qRGtm?=
 =?utf-8?B?eXZOdE1MeXJFRzhFQ2IwQnN2SHNOWTVjbVdrNmc4U2Y4K2hKbHpNMm5hZERW?=
 =?utf-8?B?U1M4MUV5bThTdWVxdTNmMS9HdGs1K0ZwRktFRVdaTWE1TnVWSWlNQUlmUDl5?=
 =?utf-8?B?R05ycmViOThrL2Jtd00wSzc0dEpDa2JjWkJlU09YUTNCYUhMdDVaeGJPTFZC?=
 =?utf-8?B?RUZXcm91YmFSeWhXeGVHZTg2VEs1TGtqS2w3UFVCbVQ4bzdMRzJtc3Z1TFBE?=
 =?utf-8?B?eERkL0lBVldNemc0Um9vMStaaStLRkliSGN2bFBSc2J0alRWNlhqZVE1SEpk?=
 =?utf-8?B?bzlZbDBVRDVrNUZxUVo1QmNHeERLSityaFROK0NtcnRsUU83UUdXcWZybGVw?=
 =?utf-8?B?cmUxR2tVOUFGZ0RHZHcxS3o3YmtGN1VBYldTd0JqZlZaZHlKR3JFL2JZanVo?=
 =?utf-8?B?NHFMcDA3TDZxNUZEUE5sTHFldU9KN2hydTdTY1lyREp3azNaMnpoVlp5Qmw0?=
 =?utf-8?B?aGF1aGV6endUTk1KMDkyYy92QVdNRkt0L083YldPRTA1L2FtaW40SGVybkcz?=
 =?utf-8?B?NnRmSWF0QXlPczhqemxWeWNZM1laRVp1clZlUHRxZkFlS2hjQmJrVGM1RmxG?=
 =?utf-8?B?M25SS1BvUFBKZGJ0d3ZxeElXU3R4cVJBbktCNENJLzZMRUU3OEd4WUZzNEF4?=
 =?utf-8?B?cnpycG1IU2lDOEdBbE4xbnZSTXBCVE5ycXZiTVNhamo0UkJhcDV1Zmx3TEFt?=
 =?utf-8?B?aXlOeFBIRTdQS2cyekdYVTR3WEZDSmw2eGI2VjkzaUxPM1BzN0dwQytCNjR2?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42A2622EB6718C419DBC3619126D1357@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930898d9-d7da-412a-a722-08ddbda04571
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 21:50:21.3930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPeKTuZkTHQ0ENqYOqpetWv6VCh81oBiPcl2SZUNd2W+mVkwVM6EE5+SxRIGqT68v93gBaXyOt/1vcuH7iDcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA2LTMwIGF0IDA5OjMwIC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBV
cGRhdGU6DQo+ICAtIEFETC9BRExOIHYxLjI5IC0+IDEuMzENCj4gIC0gQVJMIDEuMDggLT4gMS4w
OQ0KPiAgLSBDTFggMS4yMyAtPiAxLjI1DQo+ICAtIEVNUiAxLjExIC0+IDEuMTQNCj4gIC0gR1JS
IDEuMDcgLT4gMS4wOQ0KPiAgLSBHTlIgMS4wOCAtPiAxLjEwDQo+ICAtIElDWCAxLjI3IC0+IDEu
MjgNCj4gIC0gTE5MIDEuMTEgLT4gMS4xNA0KPiAgLSBNVEwgMS4xMyAtPiAxLjE0DQo+ICAtIFBU
TCBuZXcgdjEuMDANCj4gIC0gU1BSIDEuMjUgLT4gMS4yOA0KPiAgLSBTUkYgMS4wOSAtPiAxLjEx
DQo+ICAtIFNLWCAxLjM2IC0+IDEuMzcNCj4gIC0gVEdMIDEuMTcgLT4gMS4xOA0KPiANCj4gVXBk
YXRlcyBmcm9tOg0KPiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvcGVyZm1vbg0KPiB3aXRoOg0K
PiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvcGVyZm1vbi9wdWxsLzMxMg0KPiBSdW5uaW5nIHRo
ZSBzY3JpcHQ6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9wZXJmbW9uL2Jsb2IvbWFpbi9z
Y3JpcHRzL2NyZWF0ZV9wZXJmX2pzb24ucHkNCj4gDQo+IHYyOiBSZWJhc2UsIG5vIGNvbmZsaWN0
cy4NCg0KVGVzdGVkIG9uIEFETCBhbmQgQVJMLCBMR1RNLg0KDQpUZXN0ZWQtYnk6IFRob21hcyBG
YWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0KDQpUaGFua3MsDQpUb20NCg0KPiANCj4g
SWFuIFJvZ2VycyAoMTUpOg0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIEFsZGVybGFr
ZSBldmVudHMNCj4gICBwZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBBbGRlcmxha2VOIGV2ZW50
cw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIEFycm93bGFrZSBldmVudHMNCj4gICBw
ZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBDYXNjYWRlbGFrZVggZXZlbnRzDQo+ICAgcGVyZiB2
ZW5kb3IgZXZlbnRzOiBVcGRhdGUgRW1lcmFsZFJhcGlkcyBldmVudHMNCj4gICBwZXJmIHZlbmRv
ciBldmVudHM6IFVwZGF0ZSBHcmFuZFJpZGdlIGV2ZW50cw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50
czogVXBkYXRlIEdyYW5pdGVSYXBpZHMgZXZlbnRzDQo+ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBV
cGRhdGUgSWNlbGFrZVggZXZlbnRzDQo+ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUgTHVu
YXJMYWtlIGV2ZW50cw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIE1ldGVvckxha2Ug
ZXZlbnRzDQo+ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBBZGQgUGFudGhlckxha2UgZXZlbnRzDQo+
ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUgU2FwcGhpcmVSYXBpZHMgZXZlbnRzDQo+ICAg
cGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUgU2llcnJhRm9yZXN0IGV2ZW50cw0KPiAgIHBlcmYg
dmVuZG9yIGV2ZW50czogVXBkYXRlIFNreWxha2VYIGV2ZW50cw0KPiAgIHBlcmYgdmVuZG9yIGV2
ZW50czogVXBkYXRlIFRpZ2VyTGFrZSBldmVudHMNCj4gDQo+ICAuLi4vcG11LWV2ZW50cy9hcmNo
L3g4Ni9hbGRlcmxha2UvY2FjaGUuanNvbiAgfCAgNTYgKystDQo+ICAuLi4vYXJjaC94ODYvYWxk
ZXJsYWtlL2Zsb2F0aW5nLXBvaW50Lmpzb24gICAgfCAgIDEgLQ0KPiAgLi4uL3BtdS1ldmVudHMv
YXJjaC94ODYvYWxkZXJsYWtlL290aGVyLmpzb24gIHwgICAxIC0NCj4gIC4uLi9hcmNoL3g4Ni9h
bGRlcmxha2UvcGlwZWxpbmUuanNvbiAgICAgICAgICB8ICA0NCArLS0NCj4gIC4uLi9hcmNoL3g4
Ni9hbGRlcmxha2UvdmlydHVhbC1tZW1vcnkuanNvbiAgICB8ICAgMyAtDQo+ICAuLi4vcG11LWV2
ZW50cy9hcmNoL3g4Ni9hbGRlcmxha2VuL2NhY2hlLmpzb24gfCAgNTIgKy0tDQo+ICAuLi4vYXJj
aC94ODYvYWxkZXJsYWtlbi9mbG9hdGluZy1wb2ludC5qc29uICAgfCAgIDEgLQ0KPiAgLi4uL3Bt
dS1ldmVudHMvYXJjaC94ODYvYWxkZXJsYWtlbi9vdGhlci5qc29uIHwgICAxIC0NCj4gIC4uLi9h
cmNoL3g4Ni9hbGRlcmxha2VuL3BpcGVsaW5lLmpzb24gICAgICAgICB8ICA0MiArLS0NCj4gIC4u
Li9hcmNoL3g4Ni9hbGRlcmxha2VuL3ZpcnR1YWwtbWVtb3J5Lmpzb24gICB8ICAgMyAtDQo+ICAu
Li4vcG11LWV2ZW50cy9hcmNoL3g4Ni9hcnJvd2xha2UvY2FjaGUuanNvbiAgfCAgMTMgKy0NCj4g
IC4uLi9hcmNoL3g4Ni9hcnJvd2xha2UvZnJvbnRlbmQuanNvbiAgICAgICAgICB8IDEzNSArKysr
KysrKw0KPiAgLi4uL2FyY2gveDg2L2Nhc2NhZGVsYWtleC9mbG9hdGluZy1wb2ludC5qc29uIHwg
ICA2ICstDQo+ICAuLi4vYXJjaC94ODYvY2FzY2FkZWxha2V4L3BpcGVsaW5lLmpzb24gICAgICAg
fCAgIDIgKy0NCj4gIC4uLi9hcmNoL3g4Ni9lbWVyYWxkcmFwaWRzL3BpcGVsaW5lLmpzb24gICAg
ICB8ICAgMiArLQ0KPiAgLi4uL2FyY2gveDg2L2VtZXJhbGRyYXBpZHMvdW5jb3JlLWlvLmpzb24g
ICAgIHwgIDEyICsNCj4gIC4uLi9hcmNoL3g4Ni9lbWVyYWxkcmFwaWRzL3VuY29yZS1tZW1vcnku
anNvbiB8ICAyMCArKw0KPiAgLi4uL2FyY2gveDg2L2dyYW5kcmlkZ2UvZ3JyLW1ldHJpY3MuanNv
biAgICAgIHwgIDMwICstDQo+ICAuLi4veDg2L2dyYW5kcmlkZ2UvdW5jb3JlLWludGVyY29ubmVj
dC5qc29uICAgfCAgMTAgKw0KPiAgLi4uL2FyY2gveDg2L2dyYW5kcmlkZ2UvdW5jb3JlLWlvLmpz
b24gICAgICAgIHwgIDEyICsNCj4gIC4uLi9hcmNoL3g4Ni9ncmFuaXRlcmFwaWRzL2NhY2hlLmpz
b24gICAgICAgICB8ICAgOSArDQo+ICAuLi4vYXJjaC94ODYvZ3Jhbml0ZXJhcGlkcy9jb3VudGVy
Lmpzb24gICAgICAgfCAgMTAgKy0NCj4gIC4uLi9hcmNoL3g4Ni9ncmFuaXRlcmFwaWRzL2duci1t
ZXRyaWNzLmpzb24gICB8ICAzNiArKw0KPiAgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMvcGlw
ZWxpbmUuanNvbiAgICAgIHwgICAyICstDQo+ICAuLi4vZ3Jhbml0ZXJhcGlkcy91bmNvcmUtaW50
ZXJjb25uZWN0Lmpzb24gICAgfCAgMTkgLQ0KPiAgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMv
dW5jb3JlLWlvLmpzb24gICAgIHwgIDI3ICstDQo+ICAuLi4vYXJjaC94ODYvaWNlbGFrZXgvcGlw
ZWxpbmUuanNvbiAgICAgICAgICAgfCAgIDIgKy0NCj4gIC4uLi9hcmNoL3g4Ni9pY2VsYWtleC91
bmNvcmUtY2FjaGUuanNvbiAgICAgICB8ICAgMiAtDQo+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4
Ni9sdW5hcmxha2UvY2FjaGUuanNvbiAgfCAgMTEgKw0KPiAgLi4uL2FyY2gveDg2L2x1bmFybGFr
ZS9waXBlbGluZS5qc29uICAgICAgICAgIHwgIDE4ICstDQo+ICAuLi4vYXJjaC94ODYvbHVuYXJs
YWtlL3ZpcnR1YWwtbWVtb3J5Lmpzb24gICAgfCAgMTggLQ0KPiAgdG9vbHMvcGVyZi9wbXUtZXZl
bnRzL2FyY2gveDg2L21hcGZpbGUuY3N2ICAgIHwgIDI5ICstDQo+ICAuLi4vcG11LWV2ZW50cy9h
cmNoL3g4Ni9tZXRlb3JsYWtlL2NhY2hlLmpzb24gfCAgIDIgKy0NCj4gIC4uLi9hcmNoL3g4Ni9t
ZXRlb3JsYWtlL2Zyb250ZW5kLmpzb24gICAgICAgICB8ICA3MiArKysrDQo+ICAuLi4vYXJjaC94
ODYvbWV0ZW9ybGFrZS9waXBlbGluZS5qc29uICAgICAgICAgfCAgIDIgKy0NCj4gIC4uLi9hcmNo
L3g4Ni9wYW50aGVybGFrZS9jYWNoZS5qc29uICAgICAgICAgICB8IDI3OCArKysrKysrKysrKysr
KysNCj4gIC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9jb3VudGVyLmpzb24gICAgICAgICB8ICAx
MiArDQo+ICAuLi4vYXJjaC94ODYvcGFudGhlcmxha2UvZnJvbnRlbmQuanNvbiAgICAgICAgfCAg
MzAgKysNCj4gIC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9tZW1vcnkuanNvbiAgICAgICAgICB8
IDIxNSArKysrKysrKysrKysNCj4gIC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9waXBlbGluZS5q
c29uICAgICAgICB8IDMyNSArKysrKysrKysrKysrKysrKysNCj4gIC4uLi9hcmNoL3g4Ni9wYW50
aGVybGFrZS92aXJ0dWFsLW1lbW9yeS5qc29uICB8ICA2MiArKysrDQo+ICAuLi4vYXJjaC94ODYv
c2FwcGhpcmVyYXBpZHMvcGlwZWxpbmUuanNvbiAgICAgfCAgIDIgKy0NCj4gIC4uLi9hcmNoL3g4
Ni9zYXBwaGlyZXJhcGlkcy91bmNvcmUtaW8uanNvbiAgICB8ICAxMiArDQo+ICAuLi4veDg2L3Nh
cHBoaXJlcmFwaWRzL3VuY29yZS1tZW1vcnkuanNvbiAgICAgfCAgMjAgKysNCj4gIC4uLi9hcmNo
L3g4Ni9zaWVycmFmb3Jlc3QvZnJvbnRlbmQuanNvbiAgICAgICB8ICA2NCArKysrDQo+ICAuLi4v
YXJjaC94ODYvc2llcnJhZm9yZXN0L3BpcGVsaW5lLmpzb24gICAgICAgfCAgIDggKw0KPiAgLi4u
L2FyY2gveDg2L3NpZXJyYWZvcmVzdC9zcmYtbWV0cmljcy5qc29uICAgIHwgIDQ4ICsrKw0KPiAg
Li4uL2FyY2gveDg2L3NpZXJyYWZvcmVzdC91bmNvcmUtY2FjaGUuanNvbiAgIHwgICA2ICstDQo+
ICAuLi4veDg2L3NpZXJyYWZvcmVzdC91bmNvcmUtaW50ZXJjb25uZWN0Lmpzb24gfCAgNTMgKyst
DQo+ICAuLi4vYXJjaC94ODYvc2llcnJhZm9yZXN0L3VuY29yZS1pby5qc29uICAgICAgfCAgMjcg
Ky0NCj4gIC4uLi9hcmNoL3g4Ni9za3lsYWtleC9waXBlbGluZS5qc29uICAgICAgICAgICB8ICAg
MiArLQ0KPiAgLi4uL2FyY2gveDg2L3RpZ2VybGFrZS9waXBlbGluZS5qc29uICAgICAgICAgIHwg
ICAyICstDQo+ICA1MiBmaWxlcyBjaGFuZ2VkLCAxNjIzIGluc2VydGlvbnMoKyksIDI0OCBkZWxl
dGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJj
aC94ODYvcGFudGhlcmxha2UvY2FjaGUuanNvbg0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9wYW50aGVybGFrZS9jb3VudGVyLmpzb24NCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvcGFudGhlcmxh
a2UvZnJvbnRlbmQuanNvbg0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3BlcmYvcG11LWV2
ZW50cy9hcmNoL3g4Ni9wYW50aGVybGFrZS9tZW1vcnkuanNvbg0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9wYW50aGVybGFrZS9waXBlbGluZS5q
c29uDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gveDg2
L3BhbnRoZXJsYWtlL3ZpcnR1YWwtbWVtb3J5Lmpzb24NCj4gDQoNCg==
