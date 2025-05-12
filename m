Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84ED3FE7;
	Mon, 12 May 2025 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747081849; cv=fail; b=eyTfDK4JViPW1s2B3WrWhcqlNLutf2260bHSX0ztTx8z5UyRO1Q4GheQfwyX+iynV+xOOVcFqWPG6xmKTiWQvBBFV0lW2de3d176dawDeIeTB3hjUVJwcDuqRJFjNUHQ7QplVtT3ulLeQbwL2vHN2bxXMAk4SmCLcFgcRbKIBC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747081849; c=relaxed/simple;
	bh=MEE6r4dVVgO0sZxOJcneHzzOICWa5lWIsRuxVH/yu5Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AkJO6r5FfUNEP1+KsdpSexQP7eO4Em63NKDlErCoJKZiSeDkX/hpexURiVtkXT861RlRIaalfLhp3/9gXemR7FBEzQTwCwTIVBbrT9NolxDpWZOHY7WEiR7heybtLtsFhbAFTK+XcNxpSgd6JmySDE4jAmTOvOr9IkGWzUewZV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NW0ayhRs; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NW0ayhRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747081847; x=1778617847;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=MEE6r4dVVgO0sZxOJcneHzzOICWa5lWIsRuxVH/yu5Y=;
  b=NW0ayhRsMvS2SBKTYuAL+0fiSwop3zDmelR/PuSM0R0vwsWaZZnfUeEq
   SmmbbOakCjy4mZKzdmzk6Eq10xFmVif/7QcZGgfdddBm3P+mdLu0DZIyx
   roCUIm4ah/39KV1EIg39ExI895bO42aLTSZ9b5O7StLvL4RJH1VcVDkY3
   vmpTLvBxAhUBbzGyr7qlN4n2MX0BXnpSrcRzw3LHuWR/IJ89PBMhj+YXZ
   3gleIxYA5q6+mlkptz7LpOc93E4lAQ17h67jSw+q47RqAQ2oAOUVrLiJu
   OQ4ZJ3/fhGS15wbZuXUYqEeiU3CMkO5sayt1MFgNxC9NyJIbtdrXiyAe1
   w==;
X-CSE-ConnectionGUID: 3kBvELvqTQeAsiMorGknyg==
X-CSE-MsgGUID: RV/m4FL2SJWwRssVVWl0wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59904948"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="59904948"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 13:30:43 -0700
X-CSE-ConnectionGUID: zt8/fUMVQtOpdCaMbfaH1Q==
X-CSE-MsgGUID: xsMpZsdwR52JnSfNz7rA8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="137365779"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 13:30:17 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 12 May 2025 13:30:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 12 May 2025 13:30:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 12 May 2025 13:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaDRVDFHqTGRZ6jJtNxHM6wiDu+5dB2prZmqH1eQGl6LufKSzzw1ViS+hZYXpAznQrDsfhJ83gfotZkjT3l95ueZ4UiuE57Qguk1nu+AXYkzLoBEpVwRQkAlzeQD8kmxSK2OJ/4SoFAcDVHEru+Fl5IBgHsARoZBbt871W5G9MtjcGOfapUwNp74l2izq1p2z9rhJNQqz52USQnqLs1Jlq3Ih+hI/jyqIpTynqnudzabsEthu3aHT0JDjKO4M/ras86GgZeN84GYHcmzGL/t1DCB54w+FYzmUcilEI/ogSk3moTfZs//d+6k3IJlcRcGbE0peHv1TRyAEj+0bj6tJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEE6r4dVVgO0sZxOJcneHzzOICWa5lWIsRuxVH/yu5Y=;
 b=sAaA9ZQAPuINPYYgoS9op0iMGB1z8AkD2mM66qoLRfqLIpVv9/oe3eWNYvwbYBYi2TK03JnhT5bGi67gtEaWhAtEsxplT3mtIVqckmXUXx1csnvCAW7f7wBUFPpJHsIAwVVi4ZzSoaKiBPHmnqmTa8tu47mfArKsa3aSg9p8bJQ+5p5K46I6QntvQWcs8ApIvx6wosKIGiLh4PqtQKrXqUi2KsZRry+HCai+aWumkTUosMgwpMHoZJKGPTxe8gcr8ysX9rxbtZ4yfs2dYGehVXqL6hhZCJEiGfYclUJJbtlhb2uu6JbKE6UAFxZEOGgZq7NS61/cRAzhOb+CasqmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 20:30:08 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 20:30:08 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "irogers@google.com"
	<irogers@google.com>, "Wang, Weilin" <weilin.wang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>
Subject: Re: [PATCH v1 2/2] perf test: Hybrid improvements for metric value
 validation test
Thread-Topic: [PATCH v1 2/2] perf test: Hybrid improvements for metric value
 validation test
Thread-Index: AQHbw25TvIPDhNU9aES6j4Anv1fMDLPPcm+A
Date: Mon, 12 May 2025 20:30:08 +0000
Message-ID: <108f87fc28453adb52d6b8c2afd8d184e288a83e.camel@intel.com>
References: <20250512184700.11691-1-irogers@google.com>
	 <20250512184700.11691-2-irogers@google.com>
In-Reply-To: <20250512184700.11691-2-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|PH7PR11MB8549:EE_
x-ms-office365-filtering-correlation-id: 58b5d043-e24e-493d-ce5d-08dd9193c9c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?OU9DYzkvMGFIUmRydDRLSlRQcHJlWGxTME5yOTJKeWVzNEpDTmFSdFBtdTh1?=
 =?utf-8?B?L3h6dWhKYUJub2orZUcvM0FXWCtBYWtPaVFqbks3M0JBc0ZxZU9FZDJHWU9D?=
 =?utf-8?B?YW1hVitmazBNdDdpTUFuNjFZdGlValNXSzFqaWN6UjNZckpLUWpjYUc4SUll?=
 =?utf-8?B?d3pVaTZLamxkbXFoSEZlS0hpaDd4SklJUXRoQjVqVGJnd3RnL0R2YktkeGJY?=
 =?utf-8?B?V1lOaExkRWdueWRoSEJhcndqeTRISkYyU3FaV2NaL2tabG5seWVJOFRIbUQv?=
 =?utf-8?B?UVVHZHE4M1dsR2pRaS9PRUt0Q3c0R1QxN2hlVWRObXhseHkxOWFuZG90TUZ4?=
 =?utf-8?B?bjViRTFMcmJzWmhyUzJFYmptQjlwcnk3UzFkV1E4U2hmNlU1UTFNeHAxNzVU?=
 =?utf-8?B?UWl3WEx5b0Q2QWJvNlMxRndpaDVSNkJ3ZXhtcHRySmd6NGM1RTNleUh5R0lD?=
 =?utf-8?B?ekRhT2RBTXgwdFNzWXZBeUp4K2NDTm5XV0VqNlRyU2RqdVRGTVdkYWkwTGZG?=
 =?utf-8?B?WVQra0t1NVMvQXNtQzdTZ25WZldWME5yeEhYcGg4TmJpR0o3M2RHcWxaMGcx?=
 =?utf-8?B?VllJeWVuYTdmc3p5WVVjc2luTE8zQzcrSzhVa3VGRk1hRmxsNmRYaDVlTTA4?=
 =?utf-8?B?QUd3T21vM2dibGlkRDdKM2hhMXRuWlZmSmVHbXdBbVY1MmErL3drbWN2cGp3?=
 =?utf-8?B?VUpncVRSY3FabSt6dllDYXBOV3JjVXhQT2xnRzJmRjdNMGxadFJLaFZJMmVt?=
 =?utf-8?B?c2Q4b0JibnlhNVlDMEpzWnYrbXByMXNETFhobFhoRGZQL3hoSGprcG5aL3dz?=
 =?utf-8?B?ZTE2aXNiSTNaTTN4OXp3Vm4wTGljb3dxWFA5L2JmTjM4cmUrc1hFNCtUcjc0?=
 =?utf-8?B?MVlueHpzYXMreHZyNjgwZDVDeHo2WHlucmRza0s5UlRLZ1BKZVR1dlVSOXdz?=
 =?utf-8?B?WUlXU2RoUS9EaVVJRDVXcE40RDFRMmJVZkhlK0RBQjYvN0FuVkJJNkhCRWdr?=
 =?utf-8?B?V3NxdTR3R0xlV2xGTGRYNllieVNlSkdNL21Vc2d5Y0FLbURtOXh5VFlEazd2?=
 =?utf-8?B?cUNrcVNQVUpReThCSlI3a1htcGg5b1VDZXVSaG14R2tZS0F6ZDIxdzZZSkdt?=
 =?utf-8?B?NnVzYnVrQW9Ta2NsTkVwbS93clE3NlMwSlZlUTBydmhpMXRSajBCMDJEVmN3?=
 =?utf-8?B?dmFodko5VmhreEFZUEdhWlNEdXNXcnRvejJVaXovM2dOUlZPRzYxK2hSb3NZ?=
 =?utf-8?B?QndyeTFxdTJkSHZOOGc3bWxYTkQ4VkF4QmUrVnNPSTg4WUYyclZYR1pzNTZQ?=
 =?utf-8?B?R05taVJZSG5KZ2xFRWVyZkMrMnA0SzEraktqUVVueEQ3NXg2MURhOUlKSHhw?=
 =?utf-8?B?YjZwNXNIWXZwN1pheE5RL3I0bkYzSm41MXNmR3dZc21yQkoxM2lYTmg5Rjhi?=
 =?utf-8?B?YTFrd0Q2YlVVQnE1MVJIQXJsdndDWEFrUTRROEFva1pYYVJWa2VHVmFQYlEv?=
 =?utf-8?B?M1ExMTZudUY2UVVINFJoM2lDYy9Sbk1XTW5zaE91YzEzdXVJTy9LOTh5Zm1S?=
 =?utf-8?B?eXhDZXJ2NlQ0bnZmbjk0Nm4yL3BZbG0rN2N3VWJMRVltbWRweWxwUVZ3bzhW?=
 =?utf-8?B?NlVxZ093WTl6TnM0K0RmMFprTE0wTG9HZzBSQTlWL0ljSEpLZi9ZZVEzUVBJ?=
 =?utf-8?B?WVdBdkJpRS94REp5TnM0UkVDOWpsanZvNlk4QWoxaHh4R3RmM1RLUHV4dEJw?=
 =?utf-8?B?Y2Fmdld1RUJKWVdaMmVzVVk5bUpDeVZvUVdScFRZU1NkRXJiWVdPME5hbU4z?=
 =?utf-8?B?a21VOExSUEtETHhBU2dKRjRPWW8xV2tRYzErT1F6aDdiT1JERi9zaHk0ZXhp?=
 =?utf-8?B?UkpMOGwwbEdGajVNOFU1dUVMRXpweXZ6US94aVpiRFBONlBhNjR1QjFkb3Vr?=
 =?utf-8?B?V0pyTnJNaDd6U293RXJwNWFzT1ArN1FKdytKMU0rd1ZuL2NSaDJkZUxrb3o5?=
 =?utf-8?Q?WIqbCdbqPxDW+Dxk8pOaCStYLvxliI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk9iRDByZDVhUHlTMzQ2cXI2U05saUVpeUNzUTBsMVdSV2VmcFpvT2F2L1Y5?=
 =?utf-8?B?WlFwcVA2aGJYSkZJUWxpTWVhWS9tRkR0NzNvR1RsdGpIeURaTTdmYUJpaWpv?=
 =?utf-8?B?UnFYN3o3d21kUjlkZHdXNmowZGVVKzRFN1FqZXpKZEViVWJ2YlJhOU5Td2xw?=
 =?utf-8?B?a0J1WjBwTCtuWnhVZXZ0eEx4QmVuMDAxQmUyd1U4bFhGRW5UMU1tTDFnblBL?=
 =?utf-8?B?SmpPM0JwK1BNdDQwZEVCeS9UTnVaR0xkVzNLT3M2UzVZVGxKY0kwdVo2UFhQ?=
 =?utf-8?B?aisxOEJsSldXcHRpR0Zyd2RndmhXeWRCNHRuUTVOSm84Tkh5UTNBQTEvU2E0?=
 =?utf-8?B?Nm1pdzdBMmlvenpjNitlOEhqb3gxVmd2RS83QWRwaW5ZYkNOdVZLYitIb0Z1?=
 =?utf-8?B?Z3MvQWpQV3Q1REh0ZDEvK2tOYlA2eENTRVBuMGxtWEVxVEZZYzF4U0o5ZEl0?=
 =?utf-8?B?elpjeU9CcmxNSU1pV3h3SWZERWYvbmVmWmJqYjlVYnViK3NHNGMycDluSlpN?=
 =?utf-8?B?YlNyMzMvaGRwV1hRbUt0bENCMUJPSTBwcGJBUVVDdG9DdTFpVWdLdGNaY3hk?=
 =?utf-8?B?N3RLMDNqeWFzQlZ3eTY2d3R3cFJFb0lnL1lhWGdzOFB1ak95Z3hrVzh5R0JP?=
 =?utf-8?B?b3RFSHZzV3NMQXRjbnR5VEFST1duYzNlbHhOdTlobWJUQllMTHBucUVFaUJh?=
 =?utf-8?B?ZHF3a3pKYXF1VnU4M3RXdGVLeW9yWDd0Z1lDTWFjZWVHTUdkUHNBVzI4VzF2?=
 =?utf-8?B?dkR2a3Q5TmF4cFBJS2hsMEhMa3BRam83WkgrVXVyRFkvbXc1UWRlNlpMcUxD?=
 =?utf-8?B?K093Szc0bDJVdWRoWDJSSHB1aVcrbkIvSGJ6Mnl6VlE3K1R3WjRBL0RsNlgz?=
 =?utf-8?B?b2xCMVBTYTlIYlpkWVBEUXJiMXJYZFFpSWRXajAyV2V6QWtVNW4zU1JYZGRi?=
 =?utf-8?B?bUNSbCtqT2k3Qkp1d2Z5VEs1dCtpMXlMdlpudXhjNzBsZUNwY0NvYm9zeHVJ?=
 =?utf-8?B?T0JsT2ZjekRTWERCSEpha04xUjR3Wnh1M2xuSUI0VjJmczBQZjRsQm5iZGlm?=
 =?utf-8?B?MXdLVXBoTmlKaE1vODFwdU9JZFRFUXA3R0M1VWtSYjdwWFovcnRHeUpGUXpF?=
 =?utf-8?B?Mjl5OTVpK0RuZnEwc3E2SW85TlJ0LzNFakx4ZlRlRFU3akx0VjFISHNUaXhQ?=
 =?utf-8?B?YkdXSHIzUlhNSzhtd3o3SGFjWjAzdEUwaC96bVZiMXNJeTBLbTZ4QitTcWRQ?=
 =?utf-8?B?OXlabW5weU5NK3ZjaDgvNW5jdWtNcndLOVd2NmNZMm5YSHF6andnRHNDczlE?=
 =?utf-8?B?Tmh4em9HaklOSi9PTEVtTzN3dldPMVpORGdheHplbU93SjhiM1pwcVViSW53?=
 =?utf-8?B?QzViZHpLaUFnMmNpQTJreTJVU2U1N2tmakpSb0dCZDFUa09rc0tjUWlRa00r?=
 =?utf-8?B?M3AxZmQ4UEZGaUI1UGhoU2k3K1NXTTZGbm12OGx2SmxiZ09QL2lOb3VJYXJF?=
 =?utf-8?B?RTZxVEdCNERnb2J3U0Z0ZWYxSnI4N1NsTmxwR3lsZTVwRTlQRkwyY2RDb0dn?=
 =?utf-8?B?VTVONE5Od0FoYitSa2NXbTVEenJjNDF2WG1IK1RJa0VIM01yaFRrTDVGSTEx?=
 =?utf-8?B?eElCTklPR1BMUTQ4UTlSMUovcExPam9sZTNCbUlIRlZ1aFh2OUdyS0luUGpp?=
 =?utf-8?B?VnpYakErR3htOE1QY042a00zRVRYb3ZINGlHWnJNNURNUGhhd1V1aWVaVjJU?=
 =?utf-8?B?anRkdC9yZGlzdmpKRVBxUFh1Q2tCbE1CZENZK1VnWDVpckNzMHNqZ2lEZ1lH?=
 =?utf-8?B?YjEwMWUxTlZ4TC96V0V1Y0c5bjBSU3M2UWtTcHdKVTA1TVNpUGxWYXV1N0xL?=
 =?utf-8?B?MjY5Qmk1NlByVldGbGZRdEx2Mk51bzRKeHorbEpxK3ZJSHBkUG5INnZmRmFs?=
 =?utf-8?B?YUcvU3prM3Q2M2tXVHcvbGxrNUpZOFV6ZnZ1RDdQUXRza3VjR2dpSk41YzBC?=
 =?utf-8?B?SWgxUG02eVNtUTN0SmVneTY1eVB1SUxLc1hpVHViVWRpTk9UN2FjbDF5VUpX?=
 =?utf-8?B?aTc1R1Bpd00weE5TaVpobjJVVFl0NzhBTXlCM09peDVFV2NseTl6WkJrQTc1?=
 =?utf-8?B?bDBLRzlob2tkZEU4WFI3SFg1NmZEeHJsWXA0UFBZWUxrU2RJQWd6b3pMSDh1?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3E3D24E237E77448CCF928F1DD5AEE1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b5d043-e24e-493d-ce5d-08dd9193c9c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 20:30:08.7719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyL75bKmCMOqXIPM3eygBnbqwdxGocqVLr8zci8RhULrVxtD3u9XSPQLHo5bmo+LSatzxcMRO5EcEi8SbxjjuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTA1LTEyIGF0IDExOjQ3IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBteSBhbGRlcmxha2UgSSBjdXJyZW50bHkgc2VlIGZvciB0aGUgInBlcmYgbWV0cmljcyB2YWx1
ZSB2YWxpZGF0aW9uIiB0ZXN0Og0KPiBgYGANCj4gVG90YWwgVGVzdCBDb3VudDogIDE0Mg0KPiBQ
YXNzZWQgVGVzdCBDb3VudDogIDEzOQ0KPiBbDQo+IE1ldHJpYyBSZWxhdGlvbnNoaXAgRXJyb3I6
ICAgICAgVGhlIGNvbGxlY3RlZCB2YWx1ZSBvZiBtZXRyaWMgWyd0bWFfZmV0Y2hfbGF0ZW5jeScs
ICd0bWFfZmV0Y2hfYmFuZHdpZHRoJywgJ3RtYV9mcm9udGVuZF9ib3VuZCddDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGlzIFszMS4xMzcwMjhdIGluIHdvcmtsb2FkKHMpOiBbJ3BlcmYgYmVu
Y2ggZnV0ZXggaGFzaCAtciAyIC1zJ10NCj4gICAgICAgICAgICAgICAgICAgICAgICAgYnV0IGV4
cGVjdGVkIHZhbHVlIHJhbmdlIGlzIFt0bWFfZnJvbnRlbmRfYm91bmQsIHRtYV9mcm9udGVuZF9i
b3VuZF0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgUmVsYXRpb25zaGlwIHJ1bGUgZGVzY3Jp
cHRpb246ICdTdW0gb2YgdGhlIGxldmVsIDIgY2hpbGRyZW4gc2hvdWxkIGVxdWFsIGxldmVsIDEg
cGFyZW50JywNCj4gTWV0cmljIFJlbGF0aW9uc2hpcCBFcnJvcjogICAgICBUaGUgY29sbGVjdGVk
IHZhbHVlIG9mIG1ldHJpYyBbJ3RtYV9tZW1vcnlfYm91bmQnLCAndG1hX2NvcmVfYm91bmQnLCAn
dG1hX2JhY2tlbmRfYm91bmQnXQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBpcyBbNi41NjQ0
NDJdIGluIHdvcmtsb2FkKHMpOiBbJ3BlcmYgYmVuY2ggZnV0ZXggaGFzaCAtciAyIC1zJ10NCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgYnV0IGV4cGVjdGVkIHZhbHVlIHJhbmdlIGlzIFt0bWFf
YmFja2VuZF9ib3VuZCwgdG1hX2JhY2tlbmRfYm91bmRdDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIFJlbGF0aW9uc2hpcCBydWxlIGRlc2NyaXB0aW9uOiAnU3VtIG9mIHRoZSBsZXZlbCAyIGNo
aWxkcmVuIHNob3VsZCBlcXVhbCBsZXZlbCAxIHBhcmVudCcsDQo+IE1ldHJpYyBSZWxhdGlvbnNo
aXAgRXJyb3I6ICAgICAgVGhlIGNvbGxlY3RlZCB2YWx1ZSBvZiBtZXRyaWMgWyd0bWFfbGlnaHRf
b3BlcmF0aW9ucycsICd0bWFfaGVhdnlfb3BlcmF0aW9ucycsICd0bWFfcmV0aXJpbmcnXQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBpcyBbNTcuODA2MTc5XSBpbiB3b3JrbG9hZChzKTogWydw
ZXJmIGJlbmNoIGZ1dGV4IGhhc2ggLXIgMiAtcyddDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGJ1dCBleHBlY3RlZCB2YWx1ZSByYW5nZSBpcyBbdG1hX3JldGlyaW5nLCB0bWFfcmV0aXJpbmdd
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIFJlbGF0aW9uc2hpcCBydWxlIGRlc2NyaXB0aW9u
OiAnU3VtIG9mIHRoZSBsZXZlbCAyIGNoaWxkcmVuIHNob3VsZCBlcXVhbCBsZXZlbCAxIHBhcmVu
dCddDQo+IE1ldHJpYyB2YWxpZGF0aW9uIHJldHVybiB3aXRoIGVycm9zLiBQbGVhc2UgY2hlY2sg
bWV0cmljcyByZXBvcnRlZCB3aXRoIGVycm9ycy4NCj4gYGBgDQo+IEkgc3VzcGVjdCBpdCBpcyBk
dWUgdG8gdHdvIG1ldHJpY3MgZm9yIGRpZmZlcmVudCBDUFUgdHlwZXMgYmVpbmcNCj4gZW5hYmxl
ZC4gQWRkIGEgLWNwdXR5cGUgb3B0aW9uIHRvIGF2b2lkIHRoaXMuIFRoZSB0ZXN0IHN0aWxsIGZh
aWxzIHdpdGg6DQo+IGBgYA0KPiBUb3RhbCBUZXN0IENvdW50OiAgMTE1DQo+IFBhc3NlZCBUZXN0
IENvdW50OiAgMTE0DQo+IFsNCj4gV3JvbmcgTWV0cmljIFZhbHVlIEVycm9yOiAgICAgICBUaGUg
Y29sbGVjdGVkIHZhbHVlIG9mIG1ldHJpYyBbJ3RtYV9sMl9oaXRfbGF0ZW5jeSddDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGlzIFsxMTcuOTQ3MDg4XSBpbiB3b3JrbG9hZChzKTogWydwZXJm
IGJlbmNoIGZ1dGV4IGhhc2ggLXIgMiAtcyddDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJ1
dCBleHBlY3RlZCB2YWx1ZSByYW5nZSBpcyBbMCwgMTAwXV0NCj4gTWV0cmljIHZhbGlkYXRpb24g
cmV0dXJuIHdpdGggZXJyb3JzLiBQbGVhc2UgY2hlY2sgbWV0cmljcyByZXBvcnRlZCB3aXRoIGVy
cm9ycy4NCj4gYGBgDQo+IHdoaWNoIGlzIGEgcmVwcm9kdWNpYmxlIGdlbnVpbmUgZXJyb3IgYW5k
IGxpa2VseSByZXF1aXJlcyBhIG1ldHJpYyBmaXguDQoNCkhpIElhbiwgSSB0ZXN0ZWQgdGhpcyBv
biBteSBhbGRlciBsYWtlIGFuZCBhbiBhcnJvdyBsYWtlLiBBbGwgdGVzdHMsIGluY2x1ZGluZyB0
bWFfbDJfaGl0X2xhdGVuY3ksDQpwYXNzIG9uIG15IGVuZC4NCg0KVGVzdGVkLWJ5OiBUaG9tYXMg
RmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4NCg0KVGhhbmtzLA0KVG9tDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAg
Li4uL3Rlc3RzL3NoZWxsL2xpYi9wZXJmX21ldHJpY192YWxpZGF0aW9uLnB5ICAgfCAxMiArKysr
KysrKystLS0NCj4gIHRvb2xzL3BlcmYvdGVzdHMvc2hlbGwvc3RhdF9tZXRyaWNzX3ZhbHVlcy5z
aCAgIHwgMTcgKysrKysrKysrKystLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rl
c3RzL3NoZWxsL2xpYi9wZXJmX21ldHJpY192YWxpZGF0aW9uLnB5IGIvdG9vbHMvcGVyZi90ZXN0
cy9zaGVsbC9saWIvcGVyZl9tZXRyaWNfdmFsaWRhdGlvbi5weQ0KPiBpbmRleCAwYjk0MjE2Yzlj
NDYuLmRlYThlZjE5NzdiZiAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9s
aWIvcGVyZl9tZXRyaWNfdmFsaWRhdGlvbi5weQ0KPiArKysgYi90b29scy9wZXJmL3Rlc3RzL3No
ZWxsL2xpYi9wZXJmX21ldHJpY192YWxpZGF0aW9uLnB5DQo+IEBAIC0zNSw3ICszNSw4IEBAIGNs
YXNzIFRlc3RFcnJvcjoNCj4gIA0KPiAgDQo+ICBjbGFzcyBWYWxpZGF0b3I6DQo+IC0gICAgZGVm
IF9faW5pdF9fKHNlbGYsIHJ1bGVmbmFtZSwgcmVwb3J0Zm5hbWU9JycsIHQ9NSwgZGVidWc9RmFs
c2UsIGRhdGFmbmFtZT0nJywgZnVsbHJ1bGVmbmFtZT0nJywgd29ya2xvYWQ9J3RydWUnLCBtZXRy
aWNzPScnKToNCj4gKyAgICBkZWYgX19pbml0X18oc2VsZiwgcnVsZWZuYW1lLCByZXBvcnRmbmFt
ZT0nJywgdD01LCBkZWJ1Zz1GYWxzZSwgZGF0YWZuYW1lPScnLCBmdWxscnVsZWZuYW1lPScnLA0K
PiArICAgICAgICAgICAgICAgICB3b3JrbG9hZD0ndHJ1ZScsIG1ldHJpY3M9JycsIGNwdXR5cGU9
J2NwdScpOg0KPiAgICAgICAgICBzZWxmLnJ1bGVmbmFtZSA9IHJ1bGVmbmFtZQ0KPiAgICAgICAg
ICBzZWxmLnJlcG9ydGZuYW1lID0gcmVwb3J0Zm5hbWUNCj4gICAgICAgICAgc2VsZi5ydWxlcyA9
IE5vbmUNCj4gQEAgLTQzLDYgKzQ0LDcgQEAgY2xhc3MgVmFsaWRhdG9yOg0KPiAgICAgICAgICBz
ZWxmLm1ldHJpY3MgPSBzZWxmLl9fc2V0X21ldHJpY3MobWV0cmljcykNCj4gICAgICAgICAgc2Vs
Zi5za2lwbGlzdCA9IHNldCgpDQo+ICAgICAgICAgIHNlbGYudG9sZXJhbmNlID0gdA0KPiArICAg
ICAgICBzZWxmLmNwdXR5cGUgPSBjcHV0eXBlDQo+ICANCj4gICAgICAgICAgc2VsZi53b3JrbG9h
ZHMgPSBbeCBmb3IgeCBpbiB3b3JrbG9hZC5zcGxpdCgiLCIpIGlmIHhdDQo+ICAgICAgICAgIHNl
bGYud2xpZHggPSAwICAjIGlkeCBvZiBjdXJyZW50IHdvcmtsb2Fkcw0KPiBAQCAtMzc3LDcgKzM3
OSw3IEBAIGNsYXNzIFZhbGlkYXRvcjoNCj4gIA0KPiAgICAgIGRlZiBfcnVuX3BlcmYoc2VsZiwg
bWV0cmljLCB3b3JrbG9hZDogc3RyKToNCj4gICAgICAgICAgdG9vbCA9ICdwZXJmJw0KPiAtICAg
ICAgICBjb21tYW5kID0gW3Rvb2wsICdzdGF0JywgJy1qJywgJy1NJywgZiJ7bWV0cmljfSIsICIt
YSJdDQo+ICsgICAgICAgIGNvbW1hbmQgPSBbdG9vbCwgJ3N0YXQnLCAnLS1jcHV0eXBlJywgc2Vs
Zi5jcHV0eXBlLCAnLWonLCAnLU0nLCBmInttZXRyaWN9IiwgIi1hIl0NCj4gICAgICAgICAgd2wg
PSB3b3JrbG9hZC5zcGxpdCgpDQo+ICAgICAgICAgIGNvbW1hbmQuZXh0ZW5kKHdsKQ0KPiAgICAg
ICAgICBwcmludCgiICIuam9pbihjb21tYW5kKSkNCj4gQEAgLTQ0Myw2ICs0NDUsOCBAQCBjbGFz
cyBWYWxpZGF0b3I6DQo+ICAgICAgICAgICAgICAgICAgaWYgJ01ldHJpY05hbWUnIG5vdCBpbiBt
Og0KPiAgICAgICAgICAgICAgICAgICAgICBwcmludCgiV2FybmluZzogbm8gbWV0cmljIG5hbWUi
KQ0KPiAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZQ0KPiArICAgICAgICAgICAgICAgIGlm
ICdVbml0JyBpbiBtIGFuZCBtWydVbml0J10gIT0gc2VsZi5jcHV0eXBlOg0KPiArICAgICAgICAg
ICAgICAgICAgICBjb250aW51ZQ0KPiAgICAgICAgICAgICAgICAgIG5hbWUgPSBtWydNZXRyaWNO
YW1lJ10ubG93ZXIoKQ0KPiAgICAgICAgICAgICAgICAgIHNlbGYubWV0cmljcy5hZGQobmFtZSkN
Cj4gICAgICAgICAgICAgICAgICBpZiAnU2NhbGVVbml0JyBpbiBtIGFuZCAobVsnU2NhbGVVbml0
J10gPT0gJzElJyBvciBtWydTY2FsZVVuaXQnXSA9PSAnMTAwJScpOg0KPiBAQCAtNTc4LDYgKzU4
Miw4IEBAIGRlZiBtYWluKCkgLT4gTm9uZToNCj4gICAgICBwYXJzZXIuYWRkX2FyZ3VtZW50KA0K
PiAgICAgICAgICAiLXdsIiwgaGVscD0iV29ya2xvYWQgdG8gcnVuIHdoaWxlIGRhdGEgY29sbGVj
dGlvbiIsIGRlZmF1bHQ9InRydWUiKQ0KPiAgICAgIHBhcnNlci5hZGRfYXJndW1lbnQoIi1tIiwg
aGVscD0iTWV0cmljIGxpc3QgdG8gdmFsaWRhdGUiLCBkZWZhdWx0PSIiKQ0KPiArICAgIHBhcnNl
ci5hZGRfYXJndW1lbnQoIi1jcHV0eXBlIiwgaGVscD0iT25seSB0ZXN0IG1ldHJpY3MgZm9yIHRo
ZSBnaXZlbiBDUFUvUE1VIHR5cGUiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVs
dD0iY3B1IikNCj4gICAgICBhcmdzID0gcGFyc2VyLnBhcnNlX2FyZ3MoKQ0KPiAgICAgIG91dHBh
dGggPSBQYXRoKGFyZ3Mub3V0cHV0X2RpcikNCj4gICAgICByZXBvcnRmID0gUGF0aC5qb2lucGF0
aChvdXRwYXRoLCAncGVyZl9yZXBvcnQuanNvbicpDQo+IEBAIC01ODYsNyArNTkyLDcgQEAgZGVm
IG1haW4oKSAtPiBOb25lOg0KPiAgDQo+ICAgICAgdmFsaWRhdG9yID0gVmFsaWRhdG9yKGFyZ3Mu
cnVsZSwgcmVwb3J0ZiwgZGVidWc9YXJncy5kZWJ1ZywNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZGF0YWZuYW1lPWRhdGFmaWxlLCBmdWxscnVsZWZuYW1lPWZ1bGxydWxlLCB3b3JrbG9h
ZD1hcmdzLndsLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICBtZXRyaWNzPWFyZ3MubSkN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgbWV0cmljcz1hcmdzLm0sIGNwdXR5cGU9YXJn
cy5jcHV0eXBlKQ0KPiAgICAgIHJldCA9IHZhbGlkYXRvci50ZXN0KCkNCj4gIA0KPiAgICAgIHJl
dHVybiByZXQNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvc3RhdF9tZXRy
aWNzX3ZhbHVlcy5zaCBiL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvc3RhdF9tZXRyaWNzX3ZhbHVl
cy5zaA0KPiBpbmRleCAyNzlmMTljNTkxOWEuLjMwNTY2ZjBiNTQyNyAxMDA3NTUNCj4gLS0tIGEv
dG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9zdGF0X21ldHJpY3NfdmFsdWVzLnNoDQo+ICsrKyBiL3Rv
b2xzL3BlcmYvdGVzdHMvc2hlbGwvc3RhdF9tZXRyaWNzX3ZhbHVlcy5zaA0KPiBAQCAtMTYsMTEg
KzE2LDE2IEBAIHdvcmtsb2FkPSJwZXJmIGJlbmNoIGZ1dGV4IGhhc2ggLXIgMiAtcyINCj4gICMg
QWRkIC1kZWJ1Zywgc2F2ZSBkYXRhIGZpbGUgYW5kIGZ1bGwgcnVsZSBmaWxlDQo+ICBlY2hvICJM
YXVuY2ggcHl0aG9uIHZhbGlkYXRpb24gc2NyaXB0ICRweXRob252YWxpZGF0b3IiDQo+ICBlY2hv
ICJPdXRwdXQgd2lsbCBiZSBzdG9yZWQgaW46ICR0bXBkaXIiDQo+IC0kUFlUSE9OICRweXRob252
YWxpZGF0b3IgLXJ1bGUgJHJ1bGVmaWxlIC1vdXRwdXRfZGlyICR0bXBkaXIgLXdsICIke3dvcmts
b2FkfSINCj4gLXJldD0kPw0KPiAtcm0gLXJmICR0bXBkaXINCj4gLWlmIFsgJHJldCAtbmUgMCBd
OyB0aGVuDQo+IC0JZWNobyAiTWV0cmljIHZhbGlkYXRpb24gcmV0dXJuIHdpdGggZXJyb3MuIFBs
ZWFzZSBjaGVjayBtZXRyaWNzIHJlcG9ydGVkIHdpdGggZXJyb3JzLiINCj4gLWZpDQo+ICtmb3Ig
Y3B1dHlwZSBpbiAvc3lzL2J1cy9ldmVudF9zb3VyY2UvZGV2aWNlcy9jcHVfKjsgZG8NCj4gKwlj
cHV0eXBlPSQoYmFzZW5hbWUgIiRjcHV0eXBlIikNCj4gKwllY2hvICJUZXN0aW5nIG1ldHJpY3Mg
Zm9yOiAkY3B1dHlwZSINCj4gKwkkUFlUSE9OICRweXRob252YWxpZGF0b3IgLXJ1bGUgJHJ1bGVm
aWxlIC1vdXRwdXRfZGlyICR0bXBkaXIgLXdsICIke3dvcmtsb2FkfSIgXA0KPiArCQktY3B1dHlw
ZSAiJHtjcHV0eXBlfSINCj4gKwlyZXQ9JD8NCj4gKwlybSAtcmYgJHRtcGRpcg0KPiArCWlmIFsg
JHJldCAtbmUgMCBdOyB0aGVuDQo+ICsJCWVjaG8gIk1ldHJpYyB2YWxpZGF0aW9uIHJldHVybiB3
aXRoIGVycm9ycy4gUGxlYXNlIGNoZWNrIG1ldHJpY3MgcmVwb3J0ZWQgd2l0aCBlcnJvcnMuIg0K
PiArCWZpDQo+ICtkb25lDQo+ICBleGl0ICRyZXQNCj4gIA0KDQo=
