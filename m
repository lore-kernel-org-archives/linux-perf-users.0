Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CC238D49;
	Mon,  3 Mar 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040073; cv=fail; b=GAJZzRUR507vfptc89etLtvx7S2dhiSUvEeThig9D00YZa8/TgLC3l5CE/cRxQOSurICOdyDPDI9HcPKHrM/AOlSRqCrZhz6UBZeagUPaRJH9JzpqFMko7yY1akmR1th4hjdz0WjB4fXFAfi/A6QtVefsJ4yg0qY7o7kXQQAgsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040073; c=relaxed/simple;
	bh=IEX0Ob9eVula87nvO2ORtM+yCJR4slvgTxZbTjBzMxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lU+dnaCsVQzH5xeoI64l9VySbtadm1jnsvgnlNy/xYoGh7YBbBYdxgF2IsCm/a+GvkHaPqdVqtz1AeUQIDhZNmXHee+ScyYQriDr/vzHfzG24Ls66JfdXDv4fA4bMxQqsed0t0BZXL5Vpj6xnNcazMb19qv3awXpNPNiCTJUTew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e18p8aQE; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e18p8aQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741040071; x=1772576071;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEX0Ob9eVula87nvO2ORtM+yCJR4slvgTxZbTjBzMxk=;
  b=e18p8aQE8asw02T194wZjm/2SGTVFLqDyKCnBTCTvu2ucyfsp55rorbR
   VoBZA6OuoVJZEFrxWGl0GnX8aN/cc4ZdysWQxBTC40W9bN/BqDQypTuvz
   REZv+qWB2BOavXQbisIJhVIlWpRZcv603Whwj24aXaZCp7vzSBLh8GDsT
   TZHbgaTtxtyA4B6LVES8n/aiVjaqQHsE124IphC8AEcrVzuFyi1qmx4Ct
   J+O2KagFYEai2HssAXUqaB0fTga00WXxxcEFQp9E9u9FlXwZYT4ZDo6CX
   lyAFhg/mCJ/mNNzRfadFhL2xfMEyOO296PjgJaEzOTHAyGE8JFvxSG0/4
   g==;
X-CSE-ConnectionGUID: p6nJlFEMQ0eg+ott9zeZlw==
X-CSE-MsgGUID: QRB7alU5RISthihKqnBNBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="59347372"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="59347372"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 14:14:31 -0800
X-CSE-ConnectionGUID: OY/sKRPIRImkjZluqkOWKw==
X-CSE-MsgGUID: XQEKxuXCQTCB1Sl+xDr7+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="123126275"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 14:14:31 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 14:14:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Mar 2025 14:14:30 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 14:14:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRrNiFMmSi1DZFfx+g7mHrz4EAjLB/+Yap8tgvIU0GvzQZMxip/vZaTkpnzZTMCwJdQw1pHvV1sszntTkSNbgRQl9WBkTWx2QN7cfgs2M9dFUq1DGH+LLFd6k9snK3UNktabvBs4jn+EbQbCLtnqktPeX353/0M0i0pnjuzSUfKOcwx02u3X3Hi+4+3JZ3J3p0mRjUwHDTsIivZfhSuD2oQoCZB57yUetV6QYr7M/1xU1zhPLSbQPh3YirOOFdzCO+rpE9eZLLV+Yfz5W/m79nGisXHZc/aHHeRMQpZ+HkCcwCGxlb/X0/ue3wTDhsc1w2AF1SFUvZcrAmzr2isgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEX0Ob9eVula87nvO2ORtM+yCJR4slvgTxZbTjBzMxk=;
 b=i89trx0pAO5UNcPsCYmrBkZSD2Nc09dp/goDEud4jNYIP3/V6DRGU/gDlSGgyoD8c6ckkn5VlACpDPNnfLDY/+HsZ5x+aqIm7bea/KIgzy7WP59myXPrLjmlneOwaaXApGN9PFySU4mW0Q69uB1scIlkMb0lf7ct55GVgODiT0bNBXJiHcwedquBnPbrW3dwBS+jP3fvyv7lMTUFNgiOKbX8VGik8NXueh0qILsCA/fLi9aodQ5rfOAYZZxVifrsQUdCJDRdqdmxjR1K28/fWcbkCCG60Rw17RhZ5UDkeapbt50eKDWomED0o04dH9SbLot0iDNfWYaeFeRhgEByLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 22:13:39 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 22:13:39 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "Liang, Kan" <kan.liang@intel.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v4] perf script: Fix output type for dynamically allocated
 core PMU's
Thread-Topic: [PATCH v4] perf script: Fix output type for dynamically
 allocated core PMU's
Thread-Index: AQHbiHAJC9xups2aLEG0spoMhwOTuLNh8j4AgAAP6AA=
Date: Mon, 3 Mar 2025 22:13:39 +0000
Message-ID: <def6d16033e732ebf158f6936be41794b95a811d.camel@intel.com>
References: <20250226170043.762219-1-thomas.falcon@intel.com>
	 <Z8YcOidenzGofq7R@google.com>
In-Reply-To: <Z8YcOidenzGofq7R@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|LV8PR11MB8487:EE_
x-ms-office365-filtering-correlation-id: e5126f79-aec4-46b5-8e71-08dd5aa0a6c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NVpZdHRqNTd5WjJXK1dnMDdDY3ZlRkVBa1RuamhZSVhZK3NKZjF0NllpY1JF?=
 =?utf-8?B?eFBna2ZEZVNhN0Y4VjdGV1grMDVHYzFYU0xrNVJsa0d4STBtd1R0R3c1S3BI?=
 =?utf-8?B?Y09rOXlZMFFDN2RJbzhRTEQwTkRSU0hqZGZWN2dVRE03V28xZ2RYNUxURUkr?=
 =?utf-8?B?QnVsUUNtQ1dnZTduNTRlazB0Z2xGeFJoMVFDTGE5L2gyQ25NRG9TRW9mWDdT?=
 =?utf-8?B?TUNBVGttUUo4ZFRjemlrb1J0dC8ySWtMMUxoYjF0blJIK01icy9jVTVSV08r?=
 =?utf-8?B?L0dBOTNjVWV5VEljQ0JJelg2SXFoOXI1bzBEWjh5b2NFd0EvUmM5V2RHS2lJ?=
 =?utf-8?B?b204VHBWNVVRMHNuVXl3N3o5NW5zWkJ6Q1V4UmNGbzIrU3RnRnB4ODlWUThw?=
 =?utf-8?B?dU1HK3lXUVZxcTJVVU9LcjJoRlFQeHRnWkY5TXcvOHNQcGpiT1BIMEkvSHRa?=
 =?utf-8?B?UjNVMFlydEFYMWZldFJ4dUduWUp3MjQ2ZklzQW5wVWM3VW1VemZQOGxsdzZW?=
 =?utf-8?B?SlJ5R3NXVDFNMnZJT0V2OXNuTXk1QTI5c2N0M25KOUNSbzZ6MXo3Qkxrekdo?=
 =?utf-8?B?SmpaR0lXZnhBUkhxZmY1ZzhGZjE3cUo0WmtnWms4RmcwREYvYjFua3ozV3VL?=
 =?utf-8?B?M2hzdGN3TVJBaWJzb25PQWljTW1XMGhxNEJpSForOUpNaEkwbjlQbStMc1Ux?=
 =?utf-8?B?WXlGQXBhWDZPeERUb3hUTVFGVENqblZ6VUZhWHVscmJITnVQVW82Ry9yMjBz?=
 =?utf-8?B?czZEajBoUy9IMExIMk01bkZxcEkvN0FNdTA1UVNwZ0Mrbm9NSXprekVjY284?=
 =?utf-8?B?Q05ES0Z3bHVxd3hyS2pZOEhMTUFGb1FYaitiUlpHbCtsWUpBRGV4K21PWWZk?=
 =?utf-8?B?eU53Vmt5eGkxSldMem9FWmFOK043SW9OckxyZVBjemVDa3BqUUVueVRtZGYr?=
 =?utf-8?B?azBXRmR6UFdwVnNUMGpYK1RrajZRdll4SmZOdHBwT3hPb2o3QytseFZzMXlk?=
 =?utf-8?B?cTBJc1hqUWFENElYQU15WUM0U0tkVlUrTk0rM2pCcmtjd1NZeTJjV1ZJNWlJ?=
 =?utf-8?B?ak1uRXVUcXBJZS90bkR3NHk0bG9GTlM5cFI0ckpRSGNBWHcram82M0xWWU0x?=
 =?utf-8?B?Zzh6UlJURUVQZ2huMHVTUzU1bVJBTkE4aW9nbnZwaERpS3B6QTdiT2dFRWw2?=
 =?utf-8?B?V2lkTWJQdEpOSnRCdVJ2cW1BUWR1ZGlsREZPcTQzZFV2MENkaG5saDdHY002?=
 =?utf-8?B?MkNQYjBFQm1VWE4yVVdGM0pUTTFObGY4d3pjTGx4WVlZbk1tVENwaUNYanhZ?=
 =?utf-8?B?NklBWXBuc1FBZXBxc1VzWVZ0Qm01S0lMQ3NuNFhMS1F2V3VVUkcvOGp5VzhT?=
 =?utf-8?B?K3VOZGxNcWRxME0rSkNjNkhKWmkrcUN0MzJONUM2VkNqSC9uSC9hYlRaK0dz?=
 =?utf-8?B?dW9XcmtVcVR6ekkzRkJYbUFpUnZHRkxQbUNUeG5PRTZXN3FjVGpFcmhqbzRV?=
 =?utf-8?B?cGFRdTNtUW5xYVhnbDZxZDNaUFB2Q3R3TVNXMHVLRUtZWEFDdzdVcFArM3dQ?=
 =?utf-8?B?dHFPMU1PK3lubXlFblo5azZoVE1jZWtYM05TK2QzQXAvU21BY2tZSGtPZXBW?=
 =?utf-8?B?SCticGxTekZnVXRKdE9JeFRTVlNXVWJhMFVtUXZxSUd0dEpJUE1qMzVTbnRo?=
 =?utf-8?B?UXhWSWU5ZXJiZHZiRXdHRncvVWdzMWd2RWFMc1BTaXRFeC82YUc0RjY0RGxB?=
 =?utf-8?B?bEVmWjZuWU5JRDF3cWZIWUlGZTZlRW5NVlJaRjF4UkU0UVBFNUJreHNzOTBM?=
 =?utf-8?B?T011MzUvUGdKYitEcG5uUkJtMEJ2UHBmczZDdFBiRVBDcmVzU2x5aUtuU1Ra?=
 =?utf-8?B?S1MvSFo0TGFDbE1oM0JwOUxNUzl1Ujk4TlhGbndVanlrWlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akxsYmt4MWYxMlZZSnB5aUVwVWEyVDcrMkwvbSt3cnBsVll3bzB5ZExMOElj?=
 =?utf-8?B?TlRMaTBBRnBXRVBCblFWL3Z4cW9qUWE0T01XREJIYlErRDB2OG9lR1QxbEtz?=
 =?utf-8?B?dGx2Q3VpdDVZc0ZuR2NIYmVZeHFvWHlGMzEvd215K015d1Bici9jVzV4ZVBp?=
 =?utf-8?B?MDRrSFFKejJUNUdjb1hDSnh3TTd3L0JZMDNWMEFaYnhKN1RETmJCNWJpeDNL?=
 =?utf-8?B?RUkxRkx2ZnV3YlMyWWFGQTVtek5yenFBYnFNZG9zd2lYSHVqbTZlVzZQTldi?=
 =?utf-8?B?SVUzODJiTVVFcUc5OGwrNlB3L2VEL0NrK1NBNk04eW45VThsRjdXc3R4ckdh?=
 =?utf-8?B?cjAwVmowNDVhZGx1clJNWFlmMWRINit1enhVeWdkaWpHY2dFcnQ0U3JDZ1Mw?=
 =?utf-8?B?TnZFdFNlTzhIaXVzcENzSW5PRnRIR0JHTmljZ3p1WGF1Z05ZL1YwNGlGYXNv?=
 =?utf-8?B?OEUvdS9MOHJFNVJPQWsvbGhEMUd2TE1kVDNuSTBrSFhLc09tNlZLaGhQUThR?=
 =?utf-8?B?VWhKQjNBNUQzN1N3ZjA4aHFrQW1rVEVOa2R1endVZEN6MTAya0wvU1F3ZXBL?=
 =?utf-8?B?NHgwTm11ODdrRzgyOTlYZHV5M3Nac0dXMWJoK2ZTUFNFUkJUNVlCZ0ZTa1BC?=
 =?utf-8?B?cDJEdkhEekoxK1JRc2VjZ3dSbWRpVUlTS1R0bHNteG1hNXp3ME1ZcU1LVlUv?=
 =?utf-8?B?dFB2QkhpL3VNK0tNbVVyK0F0YmQ3dkRJN0xRUk41S0E5Q0MwSWVkaC9nemJj?=
 =?utf-8?B?dXN0ZllPTW5XTlZUdXhzeHhtNDM5NElNY1lpeEVEcDBVR1FxS1k4R1dQdXF4?=
 =?utf-8?B?SXV2dnlscE9PemtsQXVZQmFxa1EvTEh5blZtRmJBWDc3Vkp3YmJqK05KY1dm?=
 =?utf-8?B?N2xCUFhwKzdma0FrMU5OUVc3bTZXaUJNU2g2UlRpSWFLaW9DK2ZCS01SMm5C?=
 =?utf-8?B?RWJqd21tWS9kdzAwdnIvbnRrYkdzOGFLNGNONVBZUGwxNmI2SHF1OXA5cHJr?=
 =?utf-8?B?OEJBWkE0azFCcFFZR2R3Y1VjcmJrckoxZnE3akVtUVZieUIwVFhaRk5qYVp0?=
 =?utf-8?B?ako1eGh1RXJMTFhJa05IZkFvUmxqOUlpZFFyRm50UkZyM0NBUjg1dkRrMWdO?=
 =?utf-8?B?Nmp2UUx2cHd2ZXRzNEp1dUQ4WWoxNllPbjhQSzlsTEhSTWtYTjdCUEMzZndC?=
 =?utf-8?B?eGN5dm51eFhsbCtiT2NONGJjTkhBTEhuendoYjVIM0xEaVRlenI5bDE5dklk?=
 =?utf-8?B?UUJXa3U3WG1sVVFiT09iYjd5azlIZGxVVUZTWmo5T3ljdHpZUFA1T1ZtSEwx?=
 =?utf-8?B?S2NnVlBZam00Yk5IdHlkSjFwdmZSRm1iYmg2OHZpUVB3elNFRmxZbzF5VGhw?=
 =?utf-8?B?UDlBaFM1L1ErZ2hUeFRiYmhwNVNLRVVFZ2VsMWVuNHRIaFlGeWF0MjhzNm1Q?=
 =?utf-8?B?Sk1hbU9oMFJ0RnZUYldJU0ZPMVQyaVc5TitzSEZxaHZscUxZOVFFcDN4TXVa?=
 =?utf-8?B?NFZhNGFyMW96Si9reWYxR0FyN2Y2MzhWMnB3VjJNSUdpY1VDaVJ0M2VlRDR6?=
 =?utf-8?B?MUN2KytqNnlMeHM0Q25SYnVTazZacVhtWk1pU1FlZmZDam91TCs0Ni81eXdm?=
 =?utf-8?B?WEYwRkVpbjd4ZE5vUTc5TWVSQXNYU1M3eXdLRmtuU2RqNW52RURYTVlIM1J1?=
 =?utf-8?B?aHNRNTY1bFFhWmxCaG16UzIraUs3NGNzdS9ralh1L1pCaVI2U0ZkRysxYzl0?=
 =?utf-8?B?RFZianlDWlYrUmRaWlpUNWltOVpJM0l4RHl3S0J5cm40ZktRK0NxK21vWkZu?=
 =?utf-8?B?L1VKUW5LK1JGekMrcjduYmY2UzRyVkRjZll3bFM1c0FuVGh2dGxXK3JzaHRX?=
 =?utf-8?B?SUhYOW9ZOE5ucXJnWFRDYXE5N21xcjc2TVYvQUNvTWo5MHErYlFDY0lPbFJV?=
 =?utf-8?B?dG9CaktrNThlcjlLK1NxWnhlWE5kN2RVOThjbWlEVXIxSm5VMld0cTczRlFZ?=
 =?utf-8?B?WlJOT3hDN0gydERGRHMreUNnNEtKMVVZblphRnp3aW9Mdks1Y3k1dmUzV3R3?=
 =?utf-8?B?a0NGSFlxYXJFQXdhMEJFT3M2OW1yZDRUTFBzZmtEek9lRGlyS1B4WkRQcHBv?=
 =?utf-8?B?OWNINTNnRjVVNkJ0bUc5TEtkbWlQZFFrQkdkRTdsWFUxaVZjamJwMFIzV2xW?=
 =?utf-8?Q?ED4rg1wvem4OPUL7LJmPjFA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2438F09A62A8B2489E0784587D9019E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5126f79-aec4-46b5-8e71-08dd5aa0a6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 22:13:39.5258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQXugBV/SLNfTLHKmIxAMeyqXVEKMav2vpBg/5lLoOpwZ3/wyhMs3txA7inrjALonPWRBVcCeZGJG//2v4D8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTAzIGF0IDEzOjE2IC0wODAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gT24gV2VkLCBGZWIgMjYsIDIwMjUgYXQgMTE6MDA6NDNBTSAtMDYwMCwg
VGhvbWFzIEZhbGNvbiB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIHdhcyBvcmlnaW5hbGx5IHBvc3Rl
ZCBoZXJlOg0KPiA+IA0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MTIxMzIx
NTQyMS42NjExMzktMS10aG9tYXMuZmFsY29uQGludGVsLmNvbS8NCj4gPiANCj4gPiBJIGhhdmUg
cmViYXNlZCBvbiB0b3Agb2YgQXJuYWxkbydzIHBhdGNoIGhlcmU6DQo+ID4gDQo+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1oyWENpM1Bnc3RTclYwU0VAeDEvDQo+ID4gDQo+ID4gVGhl
IG9yaWdpbmFsIGNvbW1pdCBtZXNzYWdlOg0KPiA+ICINCj4gPiBwZXJmIHNjcmlwdCBvdXRwdXQg
bWF5IHNob3cgZGlmZmVyZW50IGZpZWxkcyBvbiBkaWZmZXJlbnQgY29yZQ0KPiA+IFBNVSdzDQo+
ID4gdGhhdCBleGlzdCBvbiBoZXRlcm9nZW5lb3VzIHBsYXRmb3Jtcy4gRm9yIGV4YW1wbGUsDQo+
ID4gDQo+ID4gcGVyZiByZWNvcmQgLWUgIntjcHVfY29yZS9tZW0tbG9hZHMtYXV4LyxjcHVfY29y
ZS9ldmVudD0weGNkLFwNCj4gPiB1bWFzaz0weDAxLGxkbGF0PTMsbmFtZT1NRU1fVU9QU19SRVRJ
UkVELkxPQURfTEFURU5DWS99OnVwcCJcDQo+ID4gLWMxMDAwMCAtVyAtZCAtYSAtLSBzbGVlcCAx
DQo+ID4gDQo+ID4gcGVyZiBzY3JpcHQ6DQo+ID4gDQo+ID4gY2hyb21pdW0tYnJvd3NlwqDCoCA0
NjU3MiBbMDAyXSA1NDQ5NjYuODgyMzg0OsKgwqDCoMKgwqANCj4gPiAxMDAwMMKgCWNwdV9jb3Jl
L01FTV9VT1BTX1JFVElSRUQuTE9BRF9MQVRFTkNZLzogN2ZmZGYxMzkxYjBjwqDCoMKgwqAgMTAy
NjgxMDAxNDJcDQo+ID4gwqB8T1AgTE9BRHxMVkwgTDEgaGl0fFNOUCBOb25lfFRMQiBMMSBvciBM
MiBoaXR8TENLIE5vfEJMS8KgwqDCoCBOL0HCoMKgwqANCj4gPiA1wqDCoCA3wqDCoMKgIDDCoMKg
IDdmYWQ3YzQ3NDI1ZCBbdW5rbm93bl0gKC91c3IvbGliNjQvbGliZ2xpYi0NCj4gPiAyLjAuc28u
MC44MDAwLjMpDQo+ID4gDQo+ID4gcGVyZiByZWNvcmQgLWUgY3B1X2F0b20vZXZlbnQ9MHhkMCx1
bWFzaz0weDA1LGxkbGF0PTMsXA0KPiA+IG5hbWU9TUVNX1VPUFNfUkVUSVJFRC5MT0FEX0xBVEVO
Q1kvdXBwIC1jMTAwMDAgLVcgLWQgLWEgLS0gc2xlZXAgMQ0KPiA+IA0KPiA+IHBlcmYgc2NyaXB0
Og0KPiA+IA0KPiA+IGdub21lLWNvbnRyb2wtY8KgIDUzNDIyNCBbMDIzXSA1NDQ5NTEuODE2MjI3
OsKgwqDCoMKgwqAgMTAwMDANCj4gPiBjcHVfYXRvbS9NRU1fVU9QU19SRVRJUkVELkxPQURfTEFU
RU5DWS86wqDCoCA3ZjBhYWFhMGFhZTDCoCBbdW5rbm93bl0NCj4gPiAoL3Vzci9saWI2NC9saWJn
bGliLTIuMC5zby4wLjgwMDAuMykNCj4gPiANCj4gPiBTb21lIGZpZWxkcywgc3VjaCBhcyBkYXRh
X3NyYywgYXJlIG5vdCBpbmNsdWRlZCBieSBkZWZhdWx0Lg0KPiA+IA0KPiA+IFRoZSBjYXVzZSBp
cyB0aGF0IHdoaWxlIG9uZSBQTVUgbWF5IGJlIGFzc2lnbmVkIGEgdHlwZSBzdWNoIGFzDQo+ID4g
UEVSRl9UWVBFX1JBVywgb3RoZXIgY29yZSBQTVUncyBhcmUgZHluYW1pY2FsbHkgYWxsb2NhdGVk
IGF0IGJvb3QNCj4gPiB0aW1lLg0KPiA+IElmIHRoaXMgdmFsdWUgZG9lcyBub3QgbWF0Y2ggYW4g
ZXhpc3RpbmcgUEVSRl9UWVBFX1ggdmFsdWUsDQo+ID4gb3V0cHV0X3R5cGUocGVyZl9ldmVudF9h
dHRyLnR5cGUpIHdpbGwgcmV0dXJuIE9VVFBVVF9UWVBFX09USEVSLg0KPiA+IA0KPiA+IEluc3Rl
YWQgc2VhcmNoIGZvciBhIGNvcmUgUE1VIHdpdGggYSBtYXRjaGluZyBwZXJmX2V2ZW50X2F0dHIg
dHlwZQ0KPiA+IGFuZCwgaWYgb25lIGlzIGZvdW5kLCByZXR1cm4gUEVSRl9UWVBFX1JBVyB0byBt
YXRjaCBvdXRwdXQgb2Ygb3RoZXINCj4gPiBjb3JlIFBNVSdzLg0KPiA+ICINCj4gPiANCj4gPiBT
dWdnZXN0ZWQtYnk6IEthbiBMaWFuZyA8a2FuLmxpYW5nQGludGVsLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiB2MjogcmVzdHJpY3QgcG11IGxvb2t1cCB0byBwbGF0Zm9ybXMgd2l0aCBtb3JlIHRoYW4g
b25lIGNvcmUgcG11DQo+ID4gdjM6IG9ubHkgc2NhbiBjb3JlIHBtdSBsaXN0DQo+ID4gdjQ6IHJl
YmFzZSBvbiB0b3Agb2YgQXJuYWxkbydzIHBhdGNoDQo+ID4gLS0tDQo+ID4gwqB0b29scy9wZXJm
L2J1aWx0aW4tc2NyaXB0LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gwqAxIGZp
bGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9idWlsdGluLXNjcmlwdC5jIGIvdG9vbHMvcGVyZi9idWls
dGluLQ0KPiA+IHNjcmlwdC5jDQo+ID4gaW5kZXggZDc5N2NlYzRmMDU0Li5hYmM4NjBkMDE0MjAg
MTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi9idWlsdGluLXNjcmlwdC5jDQo+ID4gKysrIGIv
dG9vbHMvcGVyZi9idWlsdGluLXNjcmlwdC5jDQo+ID4gQEAgLTM5OCwxMCArMzk4LDI4IEBAIHN0
YXRpYyBpbmxpbmUgaW50IG91dHB1dF90eXBlKHVuc2lnbmVkIGludA0KPiA+IHR5cGUpDQo+ID4g
wqAJcmV0dXJuIE9VVFBVVF9UWVBFX09USEVSOw0KPiA+IMKgfQ0KPiA+IMKgDQo+ID4gK3N0YXRp
YyBib29sIG91dHB1dF90eXBlX2NoZWNrX2NvcmVfcG11cyh1bnNpZ25lZCBpbnQgdHlwZSkNCj4g
DQo+IEhvdyBhYm91dCByZW5hbWluZyB0byBpc19jb3JlX3BtdV90eXBlKCkgPw0KPiANCj4gPiAr
ew0KPiA+ICsJc3RydWN0IHBlcmZfcG11ICpwbXUgPSBOVUxMOw0KPiA+ICsNCj4gPiArCWlmIChw
ZXJmX3BtdXNfX251bV9jb3JlX3BtdXMoKSA+IDEpIHsNCj4gPiArCQl3aGlsZSAoKHBtdSA9IHBl
cmZfcG11c19fc2Nhbl9jb3JlKHBtdSkpICE9IE5VTEwpDQo+ID4gew0KPiA+ICsJCQlpZiAocG11
LT50eXBlID09IHR5cGUpDQo+ID4gKwkJCQlyZXR1cm4gdHJ1ZTsNCj4gPiArCQl9DQo+ID4gKwl9
DQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+IA0KPiBUbyBiZSBtb3JlIGdlbmVyaWMsIGl0IGNvdWxk
IGJlDQo+IA0KPiAJcmV0dXJuIHR5cGUgPT0gUEVSRl9UWVBFX1JBVzsNCj4gDQo+ID4gK30NCj4g
PiArDQo+ID4gwqBzdGF0aWMgaW5saW5lIGludCBldnNlbF9fb3V0cHV0X3R5cGUoc3RydWN0IGV2
c2VsICpldnNlbCkNCj4gPiDCoHsNCj4gPiAtCWlmIChldnNlbC0+c2NyaXB0X291dHB1dF90eXBl
ID09IE9VVFBVVF9UWVBFX1VOU0VUKQ0KPiA+IC0JCWV2c2VsLT5zY3JpcHRfb3V0cHV0X3R5cGUg
PSBvdXRwdXRfdHlwZShldnNlbC0NCj4gPiA+Y29yZS5hdHRyLnR5cGUpOw0KPiA+ICsJaWYgKGV2
c2VsLT5zY3JpcHRfb3V0cHV0X3R5cGUgPT0gT1VUUFVUX1RZUEVfVU5TRVQpIHsNCj4gPiArCQlp
ZiAob3V0cHV0X3R5cGUoZXZzZWwtPmNvcmUuYXR0ci50eXBlKSA9PQ0KPiA+IE9VVFBVVF9UWVBF
X09USEVSICYmDQo+ID4gKwkJwqDCoMKgIG91dHB1dF90eXBlX2NoZWNrX2NvcmVfcG11cyhldnNl
bC0NCj4gPiA+Y29yZS5hdHRyLnR5cGUpKQ0KPiA+ICsJCQlldnNlbC0+c2NyaXB0X291dHB1dF90
eXBlID0gUEVSRl9UWVBFX1JBVzsNCj4gPiArCQllbHNlDQo+ID4gKwkJCWV2c2VsLT5zY3JpcHRf
b3V0cHV0X3R5cGUgPQ0KPiA+IG91dHB1dF90eXBlKGV2c2VsLT5jb3JlLmF0dHIudHlwZSk7DQo+
ID4gKwl9DQo+IA0KPiBJdCBzZWVtcyBiZXR0ZXIgdG8gcHV0IHRoaXMgbG9naWMgaW5zaWRlIG91
dHB1dF90eXBlKCkuDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0KDQpUaGFua3MsIHdp
bGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHNvb24uDQoNClRvbQ0KDQo+ID4gwqANCj4gPiDCoAlyZXR1
cm4gZXZzZWwtPnNjcmlwdF9vdXRwdXRfdHlwZTsNCj4gPiDCoH0NCj4gPiAtLSANCj4gPiAyLjQ4
LjENCj4gPiANCj4gDQoNCg==
