Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E012FB34;
	Tue,  9 Jul 2024 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506242; cv=fail; b=PxwR48qatknKK/sZDTsAgC2yGkv9clRUOBQ2Z0EUjn/RAZDLUCYzj1GgpSTJnmhnEXwPOflAqpJK8ZofNxR/XJLn+AxatcqDjjVM1C0r95BTKUQdYLW6mjQKKkeGOpj9yrdAgKx0RURRE+iqlrMsHheS/68/B+Femgtax9dsot8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506242; c=relaxed/simple;
	bh=yqy4A0GArUYNIBrGCpKPbMedt51MSOOfGrmXv6bP8pA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fpehJYUhPPQbpMzncna22tu/JKM4XafjWBH5116e085BEUbVIS+WNqaJVjSBPMur/5L+EXN6jEXaevEr/mj6VygOKhgVL8m34tETROTy3zbbUvuVJOalaH4ArD1fDZq6uJN+mUkANQzyWk7ztSBojJDFxg9ueqkO4t0cm4r4Roo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtSRrvl/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtSRrvl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720506241; x=1752042241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yqy4A0GArUYNIBrGCpKPbMedt51MSOOfGrmXv6bP8pA=;
  b=JtSRrvl/FcDeTUaw+aQtqrumAaN2dsvygkMg0IJLzQNbojSUhnD/FIho
   MJM9v5Dj0Lth3OmehazjyQyhnkQuw2xgzBiaQHL0/5GvquccYWoY5f18w
   xXQboT1VXGkR198WXP9IMZYX3FYpluZw5FbVDHi38TCXLFIL5b0DqFCz2
   TOeY07um1D1Kxh6X9LyIz2nrgEZpqTbOHGFUkUMK0HQMxso9Bfk9OEiRD
   79wOAI9med+nOIz2rzygwpRy70WnhwVpdAU+/o0vUy7geFZyW7DtVkUl3
   dleYXLqimp3mkGJN/McYnlMWDx360uHLwc8+rp8fMXpZoZECGHspqivCu
   g==;
X-CSE-ConnectionGUID: pFJZHlijR/mQYIWGgYnB9Q==
X-CSE-MsgGUID: PJDGQ5EOSsqFXKJvKyTJiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17444007"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17444007"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 23:23:59 -0700
X-CSE-ConnectionGUID: iOunDZn2Ruyq6mapXetUmw==
X-CSE-MsgGUID: nQ+xhAHwQN2uULAyJtTM5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="52540672"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 23:24:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:23:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:23:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:23:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDp8AgM+XX0kPvffhFGmGU98NC9b/5hOPCOVyfPSwOgZGapWztEVFLmsb5j7wJOK8sfkZlPeIq9C/hERp2v1FpObGUDU0iqVKPdQAwWpdgWYuXd8rNqXu5K+y7hNz94EEi1Ed+BLgB7ViaYAFxMjdiBN8yXTUXvvMw2NCjt577x6ywUc5eXi8Oi+Qw8oSVNDfQomFjIxH2LGILtMNNdef/TeG2jJ4FGRtIMZ2RAujzfEndUCARgLdqjbYw8PG4O+Ls+/4GFQE0UK3O4VcrtBMB2DUjPAqzTYHTd5awZ5voLW8WALwkSbhffcSPMt+2MkQS1qIonJRdervF/BrJLsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqy4A0GArUYNIBrGCpKPbMedt51MSOOfGrmXv6bP8pA=;
 b=hx0yEFdmRqlk8mUUAhs5S+wsHYAJgNFu2HAVoNyZnYB+gQ3PbgGCDZNw2aFig4nDDbI9DOQ06LUbn9PSfgl+vcMnwzO1yVIfdS+z3AMh/7VOU3bmTTX9DXB0MpvnbN0GUSayDft/hLDaxSBEY0LLCXobraySJWQ0O5vQB+yhYzTxhqSIgv43Vz1l1TDGYs+xjqRYbjURGiWfpGXB6qOBYi7c1uov5NP9vzfOFIH8dmyZ2DBXlvFaOfS7aOY2h/nseZGe0V30ID2J91jFrksJ8WmiAz7qmAKnDGPrf0xNWnqb7zxo5s/ZYCtYzxiU8b3ZlvQVKOoWjUnzybMfrEpG/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by PH8PR11MB6853.namprd11.prod.outlook.com (2603:10b6:510:22e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:23:51 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:23:51 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Topic: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Index: AQHaz/yE5K7EZmPt/k6tYcJFR9dutrHt1TgAgAADezCAAAIMgIAAFGfw
Date: Tue, 9 Jul 2024 06:23:51 +0000
Message-ID: <CO6PR11MB5635F6A59A405ED9CB63B8B0EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240706232956.304944-1-weilin.wang@intel.com>
 <20240706232956.304944-9-weilin.wang@intel.com>
 <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
 <CO6PR11MB563567A7804F50AD5AA1F708EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cgrX=hL_Y16ZrPr6NOsd2ApOWdDP2bWDSNcK2yp4Skn3A@mail.gmail.com>
In-Reply-To: <CAM9d7cgrX=hL_Y16ZrPr6NOsd2ApOWdDP2bWDSNcK2yp4Skn3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|PH8PR11MB6853:EE_
x-ms-office365-filtering-correlation-id: a71f7f3a-d687-478f-41d4-08dc9fdfb32e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2diVDZZclRsMkRpTXZmSExHbnBCVCtDRzZmQU03WXV3R2VIVkNQcFYxZTlC?=
 =?utf-8?B?WGFFaktvK1dQVUhjNlBERHY4NHlSK3BHZHFlaDAwQjd1Y0U5Y3VkOUZWVHpD?=
 =?utf-8?B?UU5tY3RNb3l0MWY4cUtWd2ZNUDN4dmJNV3V2RVFsdTNmRHBYVlRaem5SQ090?=
 =?utf-8?B?UHBTU01vTUYxUllBak9vbTljQURnVzRRYmViRzhhajhxeXNIcDJYVXpmS2pm?=
 =?utf-8?B?N3BuQ2lyTUM1Y0xGWHgrMVIrMjNvSU5PS2lBTnFxdHllZkRMVEwvWEhhb2hX?=
 =?utf-8?B?aFlSWlY4ZVI2UVU3NUJicUZ2eVJ5ZXBkbmNnbngwUGkyS3RUaTNXTHhhT0xO?=
 =?utf-8?B?dkhLZ1B4b0JqVUEreVlYNWVNdExjUGd2VTNBOXpRU3lwc2ZHOGxDQlAzQ3Yy?=
 =?utf-8?B?UUYrQXA1aThUeVNPclVuZUViWC9xdy9NaWtvdnhEdWNOOEdyUmU1QXNrZ05q?=
 =?utf-8?B?T1h1ZHlFSW5aLzdxNzZlSXYvNkJCa2VMMVprbFNhUnA4YkFYOW5ZdlVoWHYr?=
 =?utf-8?B?UHI2dHFicnBnYnN2d3ZxMnl6MElHdmhPdFRqSTBlMU5WaDhnR0FuQlZpT3o4?=
 =?utf-8?B?bHB3TEVWbEpaVy84YWpJNWpwQjg5bU9EZCtneEJwM1JzaE9SUVZMRm1TaWpp?=
 =?utf-8?B?ZUppMzF2d25rNXNHZTN3TW9ZQ0xPczB1Q1F1Ulk3a1llcFhyMHJaelJHbUFx?=
 =?utf-8?B?NjlLWGczaC9XRHFKdDlLT2hsbmVFbFVmYUl4QVAwMFBRTGdKVTkvMTZjUnor?=
 =?utf-8?B?S3poMUIwTFJhdnJLLytGWTV6dGZ6U0N3OWdxQjJSZnNqaXlENmVaRjQ5dG5w?=
 =?utf-8?B?UVczZlhwZVBtSnFZemsxQXdsSWxwTjFlbnNIMC9SeDczWk14SFZNelFDOVlW?=
 =?utf-8?B?WlhtR3NyYnROOGcyeU9xMTliMTBpWVNMTHdxUTkxUnA4QkNXbzhxaUYrMEhD?=
 =?utf-8?B?Y0tHNGgzeWsvZU4wbFFGRU9pem5Ic3dGdStYR1JILy9oMHNyejdyVzIwY0tI?=
 =?utf-8?B?QnV6OVVCTTR6bXYzd0tWOVFLMjRrbzB6L1ZSOE14UHhGNkhab1dvbWF1MEo0?=
 =?utf-8?B?UFlBbHQya251WUtnKzhVekMwWWhrUHNrN1ovMExnSXNiKzJOdkJSOENEaGJ1?=
 =?utf-8?B?RHRsbmtkSEFKbmZpS0k4NURRRUxLQlpRUW5mUnlXMjQ4T0Nqd2MvWWwzV1kx?=
 =?utf-8?B?NFduSW90NElwSmpFRlcvMXlObTc3amNqWkpZRG9vZThxVXlhRVZPNUdubnY4?=
 =?utf-8?B?Z25mTGEzOS9WM1U5OENhRFJkZjdjTUdwRkxiUVN4ZFRkU3VWc0NSbytvZko5?=
 =?utf-8?B?M2ZXMDBPWjZLcTZ0S2F0L2NEZnE4R1FkUlY2eXcyUmZnVXMyUTRyVVhvNGF3?=
 =?utf-8?B?Ny9Zd0JQbjJUeHRZaGtKeDY0VStYSEtRc2xMS21wdFJYdUFFRmxXOHYxcHNZ?=
 =?utf-8?B?WTJQaitzOXU5RnFsVVplZUs4MmIrQ1dzbFl4dExxMFRGeVdEOThVaCtlUTZS?=
 =?utf-8?B?SVFZSTV4UlJHVTQ0ZEppbWowdTRWZkVtV1FrRldoeTlVc1FwWnB0bEVDTHlj?=
 =?utf-8?B?YTR4TDZDTW14dTVoSDBhYWVtWnU0QkFvM2N2MjJLWE50Y0FiclVkZU1tMVVM?=
 =?utf-8?B?TTdsTXZQWm9BbWF2NHVvUUM5TmxEM0ZiVi9KdVpnc0pvM2p0dXFIdXlLdXo1?=
 =?utf-8?B?cHR0Z2dSbkZsdVpSSFRYSnlxV2NBajY2cDFBRERqTWhYN2N6VUlRamxPYUJX?=
 =?utf-8?B?c1RRTVlRMmFjNzRpWk5sRHEzTWV3VTErL3NoRFZhV1VKRndWeXAvOVVuem9w?=
 =?utf-8?B?OE9Xc3RINnFabVJQYmZiL295cjBsYWFQdEJCd21YQmYydDB2QmtMMHg3QXUy?=
 =?utf-8?B?aElVdzVqZ0wrZkVKcmFVMzk0TmVHdVFuTlhQUmQxRVhRY2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWpSVzdwQTdIbm16ZjNVK282aFJrcXVMSE9uN0xHSjBHVjVnTndxRVdPalV6?=
 =?utf-8?B?LzRuVStNSzR3SDFyQ1lXdFBxRVZqcHBqV3ByYWJadTJmTmJOcGJGZGc0WlVC?=
 =?utf-8?B?Ui9scnRaMSswem9FeERyNHBNc1BPV3M2ZUwwV2N2Y09FamtmL1VhNGUrU3Vv?=
 =?utf-8?B?SU5WWllpcWNqK1BRS3lkRkZGNkdHcmVFZXRyaDhEVU5kdHZxb3FUNEJ4Smty?=
 =?utf-8?B?RUhwM1BtMGt0dGFMTDlQdFo4QlhmZ1hJNCt5QUtteXRWcVRKZVFWcEQ0SXhV?=
 =?utf-8?B?VjVjeWJJb3ZUdlVrdnNTRzVoQUEzTnI2UlhpV25SN1dWOHhCTUF6OFliSWZT?=
 =?utf-8?B?cURMOVMzTGMzNlFnelk5YjlLUTJGcDhlWG1Ea1ZFY1QrTGpQZUhPdlZKa1k3?=
 =?utf-8?B?c2t3cC9nWG1veERTMERYQURkVnhqb2x2OE9kSlhybHIzSTRRa1ZING1FZzBG?=
 =?utf-8?B?VzFOdFdQVmFuTVd2NFRSR3pQZ1BlbHB5dXMxaE9zUi9VajhrdFlhY1RDRHI4?=
 =?utf-8?B?YkFwVDV6aXhnZjZSUGxkaXh3M1lMb0FOUGxvLzcvT3ZYd0VJeS9NTFd3TWJL?=
 =?utf-8?B?NWYvWFFvbjBnNnF5K3dPc0Rtc3ZDNGxaQXN0a1RIVDJhWmVPY2Y2UHpYOHFy?=
 =?utf-8?B?RHZBUWRoVTdwaVhsb0pCMjZsVm1NalVySklNam5URlIvYlZqbG91Ny9tL0dN?=
 =?utf-8?B?U2tRQXdnN0xPcGRlWm04dG9OVllUL012Z0k2OUZTcWw1WHBUNFZBSjJWejF5?=
 =?utf-8?B?N1hnenI5OEdXcE41am45MW9nWUVlSGs4akp5eXlmREM2SVZBOXA4VFJkVXJq?=
 =?utf-8?B?OTFKS1RGQVJ3NUIxMjUwZHJZTWMxeWVDVXhmNDc0OTBQTzcxRE5IVE1OMkVJ?=
 =?utf-8?B?RXhBOWdRYWNGc2hCaUk3cVRHUDh1UnVYbjljNnpTNHpscFF5OWlJSzJhbDQ2?=
 =?utf-8?B?dk1ycXBGWHNiQW1tVmIxUEV2TGpNUjFyaWt2YzRvMFNQbStwUlJjUHk2dTEy?=
 =?utf-8?B?UjRVUllra09OK0kyVmFuQm1YbFMvam5uTDNDZHBQZG9jcXVQYkYyMXRaOXV6?=
 =?utf-8?B?dGhTRi8zYjdQeG1DcVg0S2pJUWswV0dXcUdXaklmVEVxOUhOZk84ZTlqWnN0?=
 =?utf-8?B?Q3JmZFU4UU9peHcyREhndHlZQUNDbTZrR1luMmZjdE4vcnlxbWpyYzVsMTh3?=
 =?utf-8?B?eEtlcW1LM3NQUVhyWWd3a25CZEhBM2hvamRyTHR0eWpmMVJXcWlXcElPV1VY?=
 =?utf-8?B?N2RRNFR1akpsaVdYSEJ2WEFOdTdZWmNoeFJYN2hiT2YvYzFwQ20wSnJudTVH?=
 =?utf-8?B?SDZXSHhOSlRZM01oUE04aldxdXNVd1FzcFJMejliU050UU8rU202L1ZJbzlZ?=
 =?utf-8?B?c2N4ZXpHQnVOMEVyZzNNQmxVRms1NUN4N09uSFpiZWdPQkJnWlNaakllcnhS?=
 =?utf-8?B?andnbTY5ZEcrM1pSV3lrc0VGWTVHUmJYZ0pRbVdYNzlrWklGUE03RGEza1RC?=
 =?utf-8?B?KzlVNXRTdkMwazFpK0lPcFlSaEJOdjNxRVRaSWcvUThENkNtUUZwMkFFUUpQ?=
 =?utf-8?B?OUlvcmZ6WldiaFlra0pmei90a2hOeERoU3lhd0FOZU9XcGNNMjZnSkJiTHkr?=
 =?utf-8?B?QktPV2oxbUhqN3JGdXB6b0dwZ0VMWllMTTlyc2tLMHRDVUV2eW1ZM3A3bXBS?=
 =?utf-8?B?MldEaGlIc1lZWVJBQ2s4V2hDTTMvTGk1bUFWK09yeWpFZlJZT2pON3NrM0VO?=
 =?utf-8?B?Zk5jbE1jVDVYV29rdkFZcXE1akExdmwzOWZqZUhrZ0wySTc3ZGwwcFByOHNG?=
 =?utf-8?B?anFZaTB0YVEyU3pYTVZZckZUZzlBQ3ZlWU8wMmg2eEF2VzVJM3ZUMFhtTWp3?=
 =?utf-8?B?emxwdkxrQTB2SDBhdmE1bEdzNDZ6d0xrZlYwbjJxSmlIM2tPMHZiSGpySnhx?=
 =?utf-8?B?WXFmOFloOXoyMzBhQ3JRTVRBdXV4QmtDbkdZbS9nZitCWEcxWkRCTWxiRmMy?=
 =?utf-8?B?VWlLRjFkcGdCd0sySWQwMHBWQWh5TVl1UFBFbmNyS1ZIS0JLdEJxSnZjbisw?=
 =?utf-8?B?bW9KMHYwRVZ6YnFBYitXeTZ2ZVM4RFNkeDZmZDZzQVhtNVA0dU5GU09TQ1hU?=
 =?utf-8?Q?neFe53mX/J4K4LKXlzXIwwrHX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a71f7f3a-d687-478f-41d4-08dc9fdfb32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:23:51.2383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLRGbnMn1J43eHKGYlhL+uWcy0ULIX5DMs5hSLGsUt2vtZtON0w1T+PxNd0dOwBxTcJX3BWp/pCeKHse3EmV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6853
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgOCwgMjAyNCAxMDowNCBQ
TQ0KPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+IENjOiBJYW4g
Um9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4g
PGFjbWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+
IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBr
ZXJuZWwub3JnPjsgSHVudGVyLA0KPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsg
S2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gbGludXgtcGVyZi11c2Vy
c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxvciwg
UGVycnkNCj4gPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRo
YS5hbHRAaW50ZWwuY29tPjsgQmlnZ2VycywNCj4gQ2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MTYgOC84XSBwZXJmIHRlc3Q6IEFkZCB0
ZXN0IGZvciBJbnRlbCBUUEVCUyBjb3VudGluZw0KPiBtb2RlDQo+IA0KPiBPbiBNb24sIEp1bCA4
LCAyMDI0IGF0IDk6NTjigK9QTSBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4N
Cj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiA+ID4g
U2VudDogTW9uZGF5LCBKdWx5IDgsIDIwMjQgOTo0NCBQTQ0KPiA+ID4gVG86IFdhbmcsIFdlaWxp
biA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IElhbiBSb2dlcnMgPGlyb2dlcnNA
Z29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA+ID4gPGFjbWVAa2VybmVs
Lm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9sbmFy
DQo+ID4gPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0KPiA+ID4gPGFs
ZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtlcm5l
bC5vcmc+OyBIdW50ZXIsDQo+ID4gPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsg
S2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gPiA+IGxpbnV4LXBlcmYt
dXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXls
b3IsDQo+IFBlcnJ5DQo+ID4gPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50
aGEgPHNhbWFudGhhLmFsdEBpbnRlbC5jb20+Ow0KPiBCaWdnZXJzLA0KPiA+ID4gQ2FsZWIgPGNh
bGViLmJpZ2dlcnNAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjE2
IDgvOF0gcGVyZiB0ZXN0OiBBZGQgdGVzdCBmb3IgSW50ZWwgVFBFQlMNCj4gY291bnRpbmcNCj4g
PiA+IG1vZGUNCj4gPiA+DQo+ID4gPiBIZWxsbyBXZWlsaW4sDQo+ID4gPg0KPiA+ID4gT24gU2F0
LCBKdWwgNiwgMjAyNCBhdCA0OjMw4oCvUE0gPHdlaWxpbi53YW5nQGludGVsLmNvbT4gd3JvdGU6
DQo+ID4gPiA+DQo+ID4gPiA+IEZyb206IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5j
b20+DQo+ID4gPiA+DQo+ID4gPiA+IEludGVsIFRQRUJTIHNhbXBsaW5nIG1vZGUgaXMgc3VwcG9y
dGVkIHRocm91Z2ggcGVyZiByZWNvcmQuIFRoZQ0KPiBjb3VudGluZw0KPiA+ID4gbW9kZQ0KPiA+
ID4gPiBjb2RlIHVzZXMgcGVyZiByZWNvcmQgdG8gY2FwdHVyZSByZXRpcmVfbGF0ZW5jeSB2YWx1
ZSBhbmQgdXNlIGl0IGluIG1ldHJpYw0KPiA+ID4gPiBjYWxjdWxhdGlvbi4gVGhpcyB0ZXN0IGNo
ZWNrcyB0aGUgY291bnRpbmcgbW9kZSBjb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4g
PiA+ID4gIC4uLi9wZXJmL3Rlc3RzL3NoZWxsL3Rlc3Rfc3RhdF9pbnRlbF90cGVicy5zaCAgfCAx
OA0KPiArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA3NTUgdG9vbHMvcGVyZi90ZXN0cy9z
aGVsbC90ZXN0X3N0YXRfaW50ZWxfdHBlYnMuc2gNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJzLnNoDQo+ID4g
PiBiL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJzLnNoDQo+ID4g
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZmVh
OGNiMWI4MzY3DQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvdG9vbHMvcGVy
Zi90ZXN0cy9zaGVsbC90ZXN0X3N0YXRfaW50ZWxfdHBlYnMuc2gNCj4gPiA+ID4gQEAgLTAsMCAr
MSwxOCBAQA0KPiA+ID4gPiArIyEvYmluL2Jhc2gNCj4gPiA+ID4gKyMgdGVzdCBJbnRlbCBUUEVC
UyBjb3VudGluZyBtb2RlDQo+ID4gPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3NldCAtZQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsjIFVz
ZSB0aGlzIGV2ZW50IGZvciB0ZXN0aW5nIGJlY2F1c2UgaXQgc2hvdWxkIGV4aXN0IGluIGFsbCBw
bGF0Zm9ybXMNCj4gPiA+ID4gK2V2ZW50PWNhY2hlLW1pc3NlczpSDQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyMgV2l0aG91dCB0aGlzIGNtZCBvcHRpb24sIGRlZmF1bHQgdmFsdWUgb3IgemVybyBpcyBy
ZXR1cm5lZA0KPiA+ID4gPiArZWNobyAiVGVzdGluZyB3aXRob3V0IC0tcmVjb3JkLXRwZWJzIg0K
PiA+ID4gPiArcmVzdWx0PSQocGVyZiBzdGF0IC1lICIkZXZlbnQiIHRydWUgMj4mMSkNCj4gPiA+
ID4gK1tbICIkcmVzdWx0IiA9fiAkZXZlbnQgXV0gfHwgZXhpdCAxDQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyMgSW4gcGxhdGZvcm1zIHRoYXQgZG8gbm90IHN1cHBvcnQgVFBFQlMsIGl0IHNob3VsZCBl
eGVjdXRlIHdpdGhvdXQNCj4gZXJyb3IuDQo+ID4gPiA+ICtlY2hvICJUZXN0aW5nIHdpdGggLS1y
ZWNvcmQtdHBlYnMiDQo+ID4gPiA+ICtyZXN1bHQ9JChwZXJmIHN0YXQgLWUgIiRldmVudCIgLS1y
ZWNvcmQtdHBlYnMgLWEgc2xlZXAgMC4wMSAyPiYxKQ0KPiA+ID4NCj4gPiA+IEl0IG5ldmVyIGZp
bmlzaGVzIG9uIG15IEFNRCBtYWNoaW5lLg0KPiA+ID4NCj4gPiBIaSBOYW1oeXVuZywNCj4gPg0K
PiA+IERvIHlvdSBzZWUgYW55IG1lc3NhZ2Ugd2hpbGUgaXQgZXhlY3V0ZXM/IElzIHRoZSBwZXJm
IHJlY29yZCBmb3JrZWQNCj4gc3VjY2Vzc2Z1bGx5DQo+ID4gYnV0IGZhaWxlZCB0byByZXR1cm4/
DQo+IA0KPiBJIGRvbid0IGtub3cuLiBhbGwgSSBjYW4gZ2V0IGlzIGxpa2UgYmVsb3c6DQo+IA0K
PiAkIHN1ZG8gLi9wZXJmIHRlc3QgdHBlYnMgLXZ2DQo+IDEyMTogdGVzdCBJbnRlbCBUUEVCUyBj
b3VudGluZyBtb2RlOg0KPiAtLS0gc3RhcnQgLS0tDQo+IHRlc3QgY2hpbGQgZm9ya2VkLCBwaWQg
NTgzNDc1DQo+IFRlc3Rpbmcgd2l0aG91dCAtLXJlY29yZC10cGVicw0KPiBUZXN0aW5nIHdpdGgg
LS1yZWNvcmQtdHBlYnMNCj4gXkMNCg0KSSB0aGluayB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBm
b3JrZWQgInBlcmYgcmVjb3JkIiBlbmNvdW50ZXJlZCBlcnJvciwgd2hpY2ggDQpjYXVzZWQgdGhl
IGNvbnRyb2wgZmlmbyBmYWlsZWQgdG8gc2VuZCBhICJBQ0siIGJhY2sgYW5kIHRoZSBQSVBFIGhh
bmdlZC4NCg0KQ291bGQgeW91IHBsZWFzZSB0cnkgb3V0IHRoZSBkaWZmIGJlbG93IGFuZCBzZWUg
aWYgdGhlIHRlc3Qgd291bGQgZmluaXNoPw0KDQpBcyBmb3IgdGhlICJwZXJmIHJlY29yZCIgZXJy
b3IsIEkgdGhpbmsgaXQgbWlnaHQgYmVjYXVzZSBvZiB0aGUgZmFrZSANCmV2ZW50KGNhY2hlLW1p
c3NlczpSKSBjYW5ub3QgYmUgc3VwcG9ydGVkIGluIEFNRC4gQ291bGQgeW91IHBsZWFzZSB0ZXN0
IHJ1bg0KYSAicGVyZiBzdGF0IC1lIGNhY2hlLW1pc3NlczpSIC0tcmVjb3JkLXRwZWJzIHRydWUi
IGFuZCBzZWUgaWYgaXQgY29tcGxhaW5zIGFib3V0DQp0aGUgZXZlbnQ/DQoNCmRpZmYgLS1naXQg
YS90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYyBiL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10
cGVicy5jDQppbmRleCBhMDU4NWE2NTcxYjUuLjViOGUxMDRmMzZmMSAxMDA2NDQNCi0tLSBhL3Rv
b2xzL3BlcmYvdXRpbC9pbnRlbC10cGVicy5jDQorKysgYi90b29scy9wZXJmL3V0aWwvaW50ZWwt
dHBlYnMuYw0KQEAgLTI2Myw2ICsyNjMsNyBAQCBpbnQgdHBlYnNfc3RhcnQoc3RydWN0IGV2bGlz
dCAqZXZzZWxfbGlzdCkNCiAgICAgICAgfQ0KIA0KICAgICAgICBpZiAodHBlYnNfZXZlbnRfc2l6
ZSA+IDApIHsNCisgICAgICAgICAgICAgICBzdHJ1Y3QgcG9sbGZkIHBvbGxmZCA9IHsgLmV2ZW50
cyA9IFBPTExJTiwgfTsNCiAgICAgICAgICAgICAgICBpbnQgY29udHJvbF9mZFsyXSwgYWNrX2Zk
WzJdLCBsZW47DQogICAgICAgICAgICAgICAgY2hhciBhY2tfYnVmWzhdOw0KIA0KQEAgLTI5Nyw2
ICsyOTgsMTkgQEAgaW50IHRwZWJzX3N0YXJ0KHN0cnVjdCBldmxpc3QgKmV2c2VsX2xpc3QpDQog
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCiAgICAgICAgICAgICAgICB9DQogDQor
ICAgICAgICAgICAgICAgLyogd2FpdCBmb3IgYW4gYWNrICovDQorICAgICAgICAgICAgICAgcG9s
bGZkLmZkID0gYWNrX2ZkWzBdOw0KKw0KKyAgICAgICAgICAgICAgIGlmICghcG9sbCgmcG9sbGZk
LCAxLCAyMDAwKSkgew0KKyAgICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCJmYWlsZWQ6IHBl
cmYgcmVjb3JkIGFjayB0aW1lb3V0XG4iKTsNCisgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
b3V0Ow0KKyAgICAgICAgICAgICAgIH0NCisNCisgICAgICAgICAgICAgICBpZiAoIShwb2xsZmQu
cmV2ZW50cyAmIFBPTExJTikpIHsNCisgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiZmFp
bGVkOiBkaWQgbm90IHJlY2VpdmVkIGFuIGFja1xuIik7DQorICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIG91dDsNCisgICAgICAgICAgICAgICB9DQorDQogICAgICAgICAgICAgICAgcmV0ID0g
cmVhZChhY2tfZmRbMF0sIGFja19idWYsIHNpemVvZihhY2tfYnVmKSk7DQogICAgICAgICAgICAg
ICAgaWYgKHJldCA+IDApDQogICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBzdHJjbXAoYWNr
X2J1ZiwgImFja1xuIik7DQoNClRoYW5rcywNCldlaWxpbg0K
