Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7A190661;
	Wed, 29 Jan 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173467; cv=fail; b=IrMpq2VMRh/IetxhfZuCpF3T4FjSZ8b2W/x03BiJ7OZDT+VyTfBfePpKY30jqt6VMQJWsmWByAghZKUEmMYb8muzQSc5qJe29Bsai4GqVLgsfdSDSy8umX4fxQa95wpvrPvAlDenxcm8MATEg544GZ3nL4d5nChwLpB8hdfqrpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173467; c=relaxed/simple;
	bh=MbusLR/VaHP5RebGLtNwSdcVX85nic+xS948bhLNzd4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RcDuKQN2OxHUgvfhUNjFCk4ZqvfzXcFcm2dc+nVcdJ45T57r8CD6l+Y3EbDdqKraYxlVcJKcLg4OkZ/qfkEJ+5iUBDJ/xJBU9XBaXt2DFdoeZcwI6VjQ4FGXiBGHpUQePmCzkYqaUwZXFifO0RPnOTGqb+kyBIaBJiaNy1gpvVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpbtUxeP; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpbtUxeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738173465; x=1769709465;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=MbusLR/VaHP5RebGLtNwSdcVX85nic+xS948bhLNzd4=;
  b=XpbtUxePenjqiQV5iuLWDMf6N/8W3UqboIONNiNv4BpzN89CwRGwItzb
   jQmqKCAFVy/o4Zb7gpxYy0USs+GDe+aAW4Sa0hto7pH/5wvzbq3iHfpS4
   W462PKsXt+F3g5nWHWGF0H9Juz8AVmBPRkyKYKrFQp7Meg3Zr/1EPOI6G
   q2/TK+EjBxbhJMVxLiI5gTbCoOY4lCJKRHdCiqpBu8D5cgyARsLm0ayGD
   teGabW+45Y7ChdydERH7u7m8rFT4LvMl5seYhd7anBD+XzfyUbhBHjYXk
   9DjBryQyQ7UlfFnS5N5dAkeNB1C3Vv+5up49EFaWIXlC5Da2Uglxj/R88
   Q==;
X-CSE-ConnectionGUID: 3cI3N7mZSaiHiqlHhQX/rA==
X-CSE-MsgGUID: LkQkoR55R9qxW36VVYuXaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="38405525"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="38405525"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 09:57:45 -0800
X-CSE-ConnectionGUID: 0uCLGN2UR+ClcOSyKLq1ig==
X-CSE-MsgGUID: F0+n0cH4TQ+l9TWoa4mYmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146298034"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 09:57:44 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 09:57:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 09:57:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 09:57:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ui3ehr9jDpYpskv8y4kezjhQTyD2P/phd2rT8RbPA0tAcYCaNrkvWn3XH8S2KBaK2i/0gzGmGlHuzY+FBUCFzJ+IRnTGwurw2RQhSvzHK6U7ir6eQHe04yTFq+ng0RRtRdySgFrfpIMLb+DBZBKU+tDgEekfT4CBHIEay/uBFPw9zV86jp+7hpwR6Eg/9euA+qwZyctFR3EfQS4RLeIJI33ke/5JxgaSDRVQBiIEUaLazzbWMPFwdt4xi+BCAmpYDlzWiOSB01UXDAA1M2WAkfw79qwgdL4U/rqfxJl1ga3treQktEfx8/fOMrVRt2dX2y1Vqe7BI3eZmKesu7No6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbusLR/VaHP5RebGLtNwSdcVX85nic+xS948bhLNzd4=;
 b=HGteYqeh6s9zKfhT8ssOzS02ach0lr/n/4cas9+8xaTaCsbg8TNIRLPaoaBkcCSkBRh3lGB2XiXBOQ4HPwR/h8E90pxVUvTdWePXRmgISQxknXVVsbl5CXMohuKweuBnFZS1dWFrZRLX5XYLp6JYf3F18B6Q4bXH8tZTNmrUDrYQ+R9vFeLeiDgxpvMZOdPE9xa+3vmVzu8E/3KvrsQqZmppTTXaJk8G6IQd8CEnQl4TajALdADgbkE/Mf41ns/6dwcfhmRrnopFg4V6b6XIvS48Bx7hvIF33X2w8ZglBmkuStyCibdr+a5MudEBWb2zJO6yuPxHlc7NVhG+aM4/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Wed, 29 Jan
 2025 17:57:42 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%6]) with mapi id 15.20.8377.009; Wed, 29 Jan 2025
 17:57:41 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"Wang, Weilin" <weilin.wang@intel.com>
Subject: Re: [PATCH v2] perf test: Skip Intel TPEBS under hypervisor
Thread-Topic: [PATCH v2] perf test: Skip Intel TPEBS under hypervisor
Thread-Index: AQHbcT5ySuOUYIFA9EyfJy6gAlOaGbMuDBYA
Date: Wed, 29 Jan 2025 17:57:41 +0000
Message-ID: <838b1fe1a3a303db5b050c787160a77a96e24ca5.camel@intel.com>
References: <20250128043739.256305-1-irogers@google.com>
In-Reply-To: <20250128043739.256305-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM6PR11MB4674:EE_
x-ms-office365-filtering-correlation-id: 290ec071-7508-4c27-9305-08dd408e6d3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?R0E1MWhXWWJMdUp3d2ZhT2ErSEpEaVJUNE1FUGdVMW14cHlMOWlPWExubURp?=
 =?utf-8?B?NzJRdnBEZ29oajRnZnl5SXJ5QTIvL1NsUGNLc0RvenRHMER2Rk40cSsrV1lv?=
 =?utf-8?B?bHBidytya1JhSUhsZTVEdTRWYTZmN1hKL2NqbzNDaEVJK0lZOXZ6dUtIM2Ja?=
 =?utf-8?B?ZWkwR3JPM01zelhnSnBMZjAwWmgzVDhqbmpCRkhmTEVqUElVUXhUcVpaU3pD?=
 =?utf-8?B?Y1g1N1dRSUFic29XREo1alN1WUk5ZU11YW9wZG1QT1o2aUltOWp4QTR6eDlp?=
 =?utf-8?B?NVJ1T0tCakVKOWp2Rk5SN0hmWDJiMHlBV3pxbVdkMXAzQTV4SFdGZDdNRWp5?=
 =?utf-8?B?KzlRcW43WHhoNDFGOEJpYkF6TE5PVG9vRGdwQTY3ZTJLYzNock1yT0JjVUtD?=
 =?utf-8?B?RnAyaGtKbkw1MkorWWdZb3BPWnJlcFViNFVSSzBKUVZPcUtRQ0VoVnVtT2dn?=
 =?utf-8?B?YVV5RU80Uk96Qk1HTVpkL3lnMEJuS0hBZ3hrYVAzbXBUNmI3cVhzcS93a05M?=
 =?utf-8?B?dDdTbzVDbE5mYzdQZnNraXpvdjlvdUwrSGM1Z3IzRjQ5ZWd0aEVYY3hYNlIw?=
 =?utf-8?B?RWV3VWxqQWFlYVo1Ti9QU0NhMnErQVNRQkJDaGVHdVgwbGFYMW01VzRXTWZ4?=
 =?utf-8?B?S0ZDT0NkVWsydnAvWkRTYm93NlNiK2M3blhMM3Bhcy83TldIeTJGSFdNYzVE?=
 =?utf-8?B?eWFQNTF1NEJDSDFKVjlpdzJOaE5LdkhISlNhVGRwd25jRkVTam9hZkZVUzcw?=
 =?utf-8?B?SC9od2o5ejlTUVRSYUlXNUNSckV3M1Z0NmhERXprNk10eSt0NGc0ZFhLSjd6?=
 =?utf-8?B?MEhTYUxaVEs5UTQzRlFjTktPQW5CbHFRZTJwSXgvSWFtMFVETDNtRGtEdUY4?=
 =?utf-8?B?dmE2a0YvNVFZeFFUVld2dzBsTmsycjRleFJkaE03dlNYSjNDWHA5WEZ0ZDNO?=
 =?utf-8?B?YXlYN0o4aWRaNDJaMFEvcm1GTnFxMnhaa01yZ2NLOHh5cjFhWGtLWDR5ZzRP?=
 =?utf-8?B?WTZQdVFGNlB2cU9UbHQ2dzRtMFBhbDlacGlmamlPdkVuNmZOOVYyREFYcS9L?=
 =?utf-8?B?bnY1NlozT2t4YXFnNmFHSGxhMVlGQUlmNjZTdlNzTEN4ZXM4ODk0cXlaQ3NC?=
 =?utf-8?B?Kyt0aDI2WnlPcVBJT0lvSDZ4VzlvMEhZWWZ3S1U1eXRFYWR0eFRheFVwUm1U?=
 =?utf-8?B?MkllMncvamgrNFRWUFZiMVBhVGFjelgrbEVHZnFWdUgvNjdMUC9sVW1wd1Y1?=
 =?utf-8?B?VStRcSttaFVUSk5hbU1rUmFaYjZ0eDdMcDNOK2hMdXRUak9ObkV1Lzg2Wk5P?=
 =?utf-8?B?VFNhUGFjQ2d2TWJMc0ZIZjRsSStaSk5EWjJTV2JZa3lGSGczaU9UYWRCTmp1?=
 =?utf-8?B?UTNucDQ2THN1M1NETWpudVlVL1dzeWxra0FiV2o4ZXVwQUM1SFJjMDZoRzN1?=
 =?utf-8?B?YitHa2lqZXZWWk1lLzRoTFgwUkJYd0FwTmZ6RmFSRUM1ZFZ1QjFyREZTUkFa?=
 =?utf-8?B?OW1CV1VyL3VsblZBVkVidGc4NTJKYWZZWXJwazBvSjMxV1k2R1VCZG9HbDBU?=
 =?utf-8?B?bzl0dDF2a0E2ZmhIaVcxQVpJQXBueDhyekVhbVNaK25oK2N5Ti9wQXZ1MXJp?=
 =?utf-8?B?cVhONmNVUnNlZmpNUFpNVEsrME5xZnpUU1VhZ0JIaWpKdlozTFZsbnpQTjhY?=
 =?utf-8?B?bUZZSlREMkRPSW5vWUtnemM0NXNpRXd4RERvZXk3ckQ5UkFZT1VHRll2MFBF?=
 =?utf-8?B?L1VLN2VYT2R0OHdaelhmeDEzSWE5QVJSNmVMSGtaZFhJb01jelhuNEwrdU1w?=
 =?utf-8?B?MzdwU09BcGFsYll3WXJtUVVneFNFTHpKUzhVUG1QVDZRSGt1aUZDYWo3YUYx?=
 =?utf-8?B?bjRHOUhPdXlQU2dELzVNYVhMTUdGN0RMcW9yTml4cGY5NitDNXh1R3lBWjl6?=
 =?utf-8?B?WGRSL2M1L3FuZUgrdEo5WXdnNCtOSVVsNUFCTFY2ekZLK3A4RlltQmFhMVNS?=
 =?utf-8?B?R3RjMWJHN2Z3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YU1UaVh6QTlTaEcvT2tMRHRuTkk4QUdUNmY2ZzBDUitYdFVwRVNxYzMxNDUw?=
 =?utf-8?B?N3pYZG90enlGZjI1VVQ4czlBUUxnTGVEaE11YVFHdkJveFZ6ZnFQa21ISlhh?=
 =?utf-8?B?S2VydGFQWGJld1ZqaHp4Q1dneEFJVGtVQ2ZWek1xczBpNzQ2cHAyNWFoS3A4?=
 =?utf-8?B?M3kzRVJpQ3JCb2oycjF4b3Zmdk5RZjJjM0tBSWZXRnFidFVmM2o4cDNGdkdx?=
 =?utf-8?B?Z0ZzRVI1Z3l0cUpkbUdYMUdGclJobDB1SzlhRE5lOSt4VDVzMmRTbVJWK0N1?=
 =?utf-8?B?NWhDYndMN2pHVjBoRm1sRWlrelBZTnFiZmdTeFU4Nk1lODk2UlRKVi84REt3?=
 =?utf-8?B?MWFZdUZjZE1ndFRpaHFpcjJPRzF3VzI2TDN4V1hFaDkwdW9zTWhQN1lxSUls?=
 =?utf-8?B?NFArSkFYREtiMTlVTFdwVXFnZkRQaEEraFEyU1QxNFgzMWVhUUdWQ2dqS0Fa?=
 =?utf-8?B?UFd2V1k0aEhpNXFDY3d3TnJndnBCYUdBa0FxcXhhL0VheVB0eW1LMnJmck8y?=
 =?utf-8?B?eXk5bnN4c3R0eTVCamR0NnBZL0svVzRHWW12dkdnZ1MySGhYYXE4cHVTQnVz?=
 =?utf-8?B?VGhnZTN6UTIxSTRZaTZDQVlPRnhrK1NXcjEvQ3U3dkl4MVF3Q0tQclpnRDNu?=
 =?utf-8?B?NnVnb0NkcjlIa1BUMmNUMGFmb3RwR3MzZmJYOWtzbFg2V3YzZ0tFZ0tlNlhn?=
 =?utf-8?B?bE02NU15ZHZ2dHJvYjlCbW9wNnlWWEprSEJvU2s1bEdyaE0yVjdKOUkzN1pL?=
 =?utf-8?B?ZThWUDFaSnE5ZXRrV09SRUtvU3ZIb3ROcVFTUThoeU00MnlRSzA5b3JKR0RC?=
 =?utf-8?B?dGdJSzJHTTFKMS9SWmJFMGRUNC9MN0sremdBNkFOYXplSW9GTXdHRitqVCsr?=
 =?utf-8?B?cjU3bzExcmhxNGJBSWkvZzR2NmMzZ2xuRVJYeXAvSWo3aVVEbXpJbWR2LzhX?=
 =?utf-8?B?VS9aY05IWC9YTy81V1BuRFIxald6RExudWhCdnZXSkpmbzU0SmIvMlNrcWt3?=
 =?utf-8?B?OTBzVzcvNWtzaVpqa0szTmRwMmJBT2pjRm5nRHR0WkR5LzVQVzFiajBoc2p6?=
 =?utf-8?B?WVJSNUFZVFdDK1NGUjJYakJ3by9rOFlBU1VieEVIUThtWW01L1ZQVWVKOGNy?=
 =?utf-8?B?VDNaSHd0Mmk0b3pqanlRODNSbFB5dUM1REtyNTN5cDF6TmczV1lEWWFwa0lk?=
 =?utf-8?B?NHZZRTg4Q3B3VFBNd3AwV0xQR0VSblMzRlJnSkFyWXJJbVZFS1dtS1c1QjhU?=
 =?utf-8?B?dWUzUjBzWXBCUC9waFF2bWNLR3prMEFDVE0vZGR5YVR5NTJPTWp1TEYzaHFN?=
 =?utf-8?B?czRMeUcwUXptUStBd0NYaDE0MkdCY01KYUJydFA2bUxRRWhOdDloUGs2YXUw?=
 =?utf-8?B?SzI4ZHhQWnBKZWIzQkEwaDhWNkNjNGRmQnFXTXFWaklSdFVMcUFJb3d5U0RH?=
 =?utf-8?B?bzIyeDgwenFmeFhyV3dzSDdYbWhkS2M5cTllVXhWdCtodFQySlROM1V0N25V?=
 =?utf-8?B?SHJYckZYeS9SYk9qdm1meUR4aGpia0tPZjgwSis4bHJ0NFVjSGJDbzcxdlVp?=
 =?utf-8?B?cDRtUkYyRnBTQlZNTURha3lrbVpvckI0MUNGYlEvWTdmLzNrVUVQdVRXbFJO?=
 =?utf-8?B?dWQzVi9lZnVTMjJlWUdHV2l6dzRaNnRkaVdhK09IVmZoZzh6L0Vsc1pkM1R2?=
 =?utf-8?B?VmUwZlRSb3o1WXVXYlNZRHh6Ym8xM1pnMXdYSHo0c255VlVNR2R4OTNSN3NF?=
 =?utf-8?B?NEtKVXV3UW55YkFUVzZvd2pQOGVMNDdaN2IvSVZJS1A3azZ5Tm9DN015REpl?=
 =?utf-8?B?RE0wUTArUU0xd3ozOGg2VDB1eFUwN2pPSVlBVHRHU1ZoU0NYVitxYkxPNTAy?=
 =?utf-8?B?OW5kaXAwa0owS3IxeUVtcWVTcGowb1VIUDZIbWRFTFJxamdpYVY5Qm9jZ2kx?=
 =?utf-8?B?MDJ4eU05S1FiN1RzaFRiOW5NaUdhdDBndlRGMm92dTFXOUdRSFlwbTR4QTRm?=
 =?utf-8?B?ZkQ4ZjZrQldZYVZXNk5RMlVlMXdTMEdOTUZDbWsvT0xoRzV1VG5TK3VYaUkr?=
 =?utf-8?B?TUxxTE5ieFFsVWZXaHhBY3hCbXpldmV4TWY5RkpXVmZEbktaTEhSemZZbFJi?=
 =?utf-8?B?bS9abXQ3UGZLSFd5aEp2UHVjaFpjLzJCbm9OL0I4SmZqaGhCZVR1MEhQY1dS?=
 =?utf-8?Q?Su8A4VDmKPtrN1pH5O1OLig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FAFD65362C5EC4A8BC7B2EB2CB88241@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290ec071-7508-4c27-9305-08dd408e6d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 17:57:41.8301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pxMcIOlUdx1Xx+nlaEUMWu9p4xdFpbpDMVMkgR7sEdOXo3QKEG5oIqLszT7fwY3xThgcSK34HsxRxJ4TVtpJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAxLTI3IGF0IDIwOjM3IC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBJ
bnRlbCBUUEVCUyB0ZXN0IHNraXBzIG9uIG5vbi1JbnRlbCBDUFVzLiBPbiBJbnRlbCBDUFVzIHVu
ZGVyIGENCj4gaHlwZXJ2aXNvciB0aGUgY2FjaGUtbWlzc2VzIGV2ZW50IG1heSBub3QgYmUgcHJl
c2VudC4gU2tpcCB0aGUgdGVzdA0KPiB1bmRlciB0aGlzIGNvbmRpdGlvbi4NCj4gDQo+IFJlZmFj
dG9yIHRoZSBvdXRwdXQgY29kZSB0byBiZSBwbGFjZWQgaW4gYSBmaWxlIHNvIHRoYXQgb24gYSBz
aWduYWwNCj4gdGhlIGZpbGUgY2FuIGJlIGR1bXBlZC4gVGhpcyB3YXMgbmVjZXNzYXJ5IHRvIGNh
dGNoIHRoZSBpc3N1ZSBhYm92ZQ0KPiBhcw0KPiB0aGUgZmFpbGluZyBwZXJmIHJlY29yZCBjb21t
YW5kIHdvdWxkIGZhaWwgd2l0aG91dCBvdXRwdXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBJYW4g
Um9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+DQoNCkhpLCBzb3JyeSwgYnV0IEknbSB1bmFibGUg
dG8gYXBwbHkgdGhpcyBwYXRjaCB0byBwZXJmLXRvb2xzIG9yIHBlcmYtDQp0b29scy1uZXh0PyBX
aGF0IHJlcG9zaXRvcnkgc2hvdWxkIEkgdXNlIHRvIHRlc3QgdGhpcz8NCg0KVGhhbmtzLA0KVG9t
DQoNCj4gLS0tDQo+IHYyOiBGaXggbG9zdCA6UiBhbmQgdXNlIDpwIHdpdGggcmVjb3JkIGFzIGl0
IGlzIGlnbm9yZWQgYnkgcGVyZiBzdGF0Lg0KPiAtLS0NCj4gwqAuLi4vcGVyZi90ZXN0cy9zaGVs
bC90ZXN0X3N0YXRfaW50ZWxfdHBlYnMuc2ggfCAzNiArKysrKysrKysrKy0tLS0tLQ0KPiAtLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3Rlc3Rfc3RhdF9pbnRlbF90
cGVicy5zaA0KPiBiL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJz
LnNoDQo+IGluZGV4IDY5NWRjYjkzYmI1ZS4uYTMzMGVjZGI3YmE1IDEwMDc1NQ0KPiAtLS0gYS90
b29scy9wZXJmL3Rlc3RzL3NoZWxsL3Rlc3Rfc3RhdF9pbnRlbF90cGVicy5zaA0KPiArKysgYi90
b29scy9wZXJmL3Rlc3RzL3NoZWxsL3Rlc3Rfc3RhdF9pbnRlbF90cGVicy5zaA0KPiBAQCAtMjAs
MzEgKzIwLDM5IEBAIHRoZW4NCj4gwqDCoCBleGl0IDINCj4gwqBmaQ0KPiDCoA0KPiArc3RhdF9v
dXRwdXQ9JChta3RlbXAgL3RtcC9fX3BlcmZfc3RhdF90cGVic19vdXRwdXQuWFhYWFgpDQo+ICsN
Cj4gwqBjbGVhbnVwKCkgew0KPiArwqAgcm0gLXJmICIke3N0YXRfb3V0cHV0fSINCj4gwqDCoCB0
cmFwIC0gRVhJVCBURVJNIElOVA0KPiDCoH0NCj4gwqANCj4gwqB0cmFwX2NsZWFudXAoKSB7DQo+
IMKgwqAgZWNobyAiVW5leHBlY3RlZCBzaWduYWwgaW4gJHtGVU5DTkFNRVsxXX0iDQo+ICvCoCBj
YXQgIiR7c3RhdF9vdXRwdXR9Ig0KPiDCoMKgIGNsZWFudXANCj4gwqDCoCBleGl0IDENCj4gwqB9
DQo+IMKgdHJhcCB0cmFwX2NsZWFudXAgRVhJVCBURVJNIElOVA0KPiDCoA0KPiAtIyBVc2UgdGhp
cyBldmVudCBmb3IgdGVzdGluZyBiZWNhdXNlIGl0IHNob3VsZCBleGlzdCBpbiBhbGwNCj4gcGxh
dGZvcm1zDQo+IC1ldmVudD1jYWNoZS1taXNzZXM6Ug0KPiAtDQo+IC0jIEh5YnJpZCBwbGF0Zm9y
bXMgb3V0cHV0IGxpa2UgImNwdV9hdG9tL2NhY2hlLW1pc3Nlcy9SIiwgcmF0aGVyDQo+IHRoYW4g
YXMgYWJvdmUNCj4gLWFsdF9uYW1lPS9jYWNoZS1taXNzZXMvUg0KPiArIyBFdmVudCB0byBiZSB1
c2VkIGluIHRlc3RzDQo+ICtldmVudD1jYWNoZS1taXNzZXMNCj4gwqANCj4gLSMgV2l0aG91dCB0
aGlzIGNtZCBvcHRpb24sIGRlZmF1bHQgdmFsdWUgb3IgemVybyBpcyByZXR1cm5lZA0KPiAtI2Vj
aG8gIlRlc3Rpbmcgd2l0aG91dCAtLXJlY29yZC10cGVicyINCj4gLSNyZXN1bHQ9JChwZXJmIHN0
YXQgLWUgIiRldmVudCIgdHJ1ZSAyPiYxKQ0KPiAtI1tbICIkcmVzdWx0IiA9fiAkZXZlbnQgfHwg
IiRyZXN1bHQiID1+ICRhbHRfbmFtZSBdXSB8fCBleGl0IDENCj4gK2lmICEgcGVyZiByZWNvcmQg
LWUgIiR7ZXZlbnR9OnAiIC1hIC1vIC9kZXYvbnVsbCBzbGVlcCAwLjAxID4NCj4gIiR7c3RhdF9v
dXRwdXR9IiAyPiYxDQo+ICt0aGVuDQo+ICvCoCBlY2hvICJNaXNzaW5nICR7ZXZlbnR9IHN1cHBv
cnQiDQo+ICvCoCBjbGVhbnVwDQo+ICvCoCBleGl0IDINCj4gK2ZpDQo+IMKgDQo+IMKgdGVzdF93
aXRoX3JlY29yZF90cGVicygpIHsNCj4gwqDCoCBlY2hvICJUZXN0aW5nIHdpdGggLS1yZWNvcmQt
dHBlYnMiDQo+IC3CoCByZXN1bHQ9JChwZXJmIHN0YXQgLWUgIiRldmVudCIgLS1yZWNvcmQtdHBl
YnMgLWEgc2xlZXAgMC4wMSAyPiYxKQ0KPiArwqAgaWYgISBwZXJmIHN0YXQgLWUgIiR7ZXZlbnR9
OlIiIC0tcmVjb3JkLXRwZWJzIC1hIHNsZWVwIDAuMDEgPg0KPiAiJHtzdGF0X291dHB1dH0iIDI+
JjENCj4gK8KgIHRoZW4NCj4gK8KgwqDCoCBlY2hvICJUZXN0aW5nIHdpdGggLS1yZWNvcmQtdHBl
YnMgW0ZhaWxlZCBwZXJmIHN0YXRdIg0KPiArwqDCoMKgIGNhdCAiJHtzdGF0X291dHB1dH0iDQo+
ICvCoMKgwqAgZXhpdCAxDQo+ICvCoCBmaQ0KPiDCoA0KPiDCoMKgICMgRXhwZWN0ZWQgb3V0cHV0
Og0KPiDCoMKgICMgJCBwZXJmIHN0YXQgLS1yZWNvcmQtdHBlYnMgLWUgY2FjaGUtbWlzc2VzOlIg
LWEgc2xlZXAgMC4wMQ0KPiBAQCAtNTcsMTYgKzY1LDE2IEBAIHRlc3Rfd2l0aF9yZWNvcmRfdHBl
YnMoKSB7DQo+IMKgwqAgI8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDC
oMKgwqAgY2FjaGUtbWlzc2VzOlINCj4gwqDCoCAjDQo+IMKgwqAgI8KgwqDCoMKgwqDCoMKgIDAu
MDEzOTYzMjk5IHNlY29uZHMgdGltZSBlbGFwc2VkDQo+IC3CoCBpZiBbWyAhICIkcmVzdWx0IiA9
fiAicGVyZiByZWNvcmQiIF1dDQo+ICvCoCBpZiAhIGdyZXAgInBlcmYgcmVjb3JkIiAiJHtzdGF0
X291dHB1dH0iDQo+IMKgwqAgdGhlbg0KPiDCoMKgwqDCoCBlY2hvICJUZXN0aW5nIHdpdGggLS1y
ZWNvcmQtdHBlYnMgW0ZhaWxlZCBtaXNzaW5nIHBlcmYgcmVjb3JkXSINCj4gLcKgwqDCoCBlY2hv
ICIkcmVzdWx0Ig0KPiArwqDCoMKgIGNhdCAiJHtzdGF0X291dHB1dH0iDQo+IMKgwqDCoMKgIGV4
aXQgMQ0KPiDCoMKgIGZpDQo+IC3CoCBpZiBbWyAhICIkcmVzdWx0IiA9fiAkZXZlbnQgJiYgISAi
JHJlc3VsdCIgPX4gJGFsdF9uYW1lIF1dDQo+ICvCoCBpZiAhIGdyZXAgIiR7ZXZlbnR9OlIiICIk
e3N0YXRfb3V0cHV0fSIgJiYgISBncmVwICIvJHtldmVudH0vUiINCj4gIiR7c3RhdF9vdXRwdXR9
Ig0KPiDCoMKgIHRoZW4NCj4gwqDCoMKgwqAgZWNobyAiVGVzdGluZyB3aXRoIC0tcmVjb3JkLXRw
ZWJzIFtGYWlsZWQgbWlzc2luZyBldmVudCBuYW1lXSINCj4gLcKgwqDCoCBlY2hvICIkcmVzdWx0
Ig0KPiArwqDCoMKgIGNhdCAiJHtzdGF0X291dHB1dH0iDQo+IMKgwqDCoMKgIGV4aXQgMQ0KPiDC
oMKgIGZpDQo+IMKgwqAgZWNobyAiVGVzdGluZyB3aXRoIC0tcmVjb3JkLXRwZWJzIFtTdWNjZXNz
XSINCg0K
