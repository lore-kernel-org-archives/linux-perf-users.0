Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E842F42;
	Tue, 25 Mar 2025 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742861851; cv=fail; b=FhbSFVrX5VU110APyWWMRnaLKtvA7q5Gig4F8u27+2/PabMEmh8agZ/Iq6kJWxdjmx0yr2qfrq9ghFcU28p7E1P6ETBM7X+tRRZUSxBoFxJ4cqXwU1BJgb+ecbYK2EBG2ZFGUlhQu4yM0tLagYlxyYmHacPTTxQaNc8WryUamxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742861851; c=relaxed/simple;
	bh=KQ6WDIr/7wULNkhPu0RQjuqTFOw+iww6KaUPRwEd0nY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tSE+i6hVrGCLvdF4mmNNFCOAdIFxcWRF9UjfxBRQHnHjbhPiF/nQASJTlEW49FOOCWvLqxTdj4wTjYwjMS/ukG+Scqe6DpHhQ9+sKGNLgpjZk6AMd52R2iPPjR/+1XBH+Fc7D3SbAbNKKrhw8ilhUMEOc5gjUa0jAYoa2tn5L1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COYhrAlb; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COYhrAlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742861849; x=1774397849;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KQ6WDIr/7wULNkhPu0RQjuqTFOw+iww6KaUPRwEd0nY=;
  b=COYhrAlbil8hdUD3oGbgcdP1q1ABOZ2+8utlnP7s4CSHFmAqbbg2/hsG
   j41w42rj6AjK7G5sbq8EY1OgWn1DCUMhus90aoOEtuaVDcSfmCOhS/H4+
   cX0+UYFlyyIxVkoE6wH9ssk+KnlErMge/UxCLvNP4MMJKPGeJyQ2w8uhM
   QrOV1WLt5onNthoS+XhfnWwRramaIesik4Y6qIr0aGbZ1rq55rpiiaebr
   YR8D9I1YuglQWzEuKwaJ5wPDYAsfbLN5SJ63fu0v6AcYgWcMJnn4bYP2R
   AAzXxDksrg8i64b5IOrTsIZO6mO/wgIPN+jDRXY1gAPEFEM3byINyqyp5
   g==;
X-CSE-ConnectionGUID: FpdKUSuZRqSwk9zN/2qffg==
X-CSE-MsgGUID: mW/SnfW4Qx2hIk7m9tq0Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="46834653"
X-IronPort-AV: E=Sophos;i="6.14,273,1736841600"; 
   d="scan'208";a="46834653"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 17:17:22 -0700
X-CSE-ConnectionGUID: DkOhZw1/Q92GRBH/1eP0+A==
X-CSE-MsgGUID: 8eRitu/LSWKpXsySaiCmuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,273,1736841600"; 
   d="scan'208";a="124985823"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 17:17:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 17:17:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Mar 2025 17:17:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Mar 2025 17:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuTXjr6+nXwl0qGRmo1xDZzjyrlJFRincP+WNt27XLV/4hTbGjjm/via49Egvj59jbe/2qHWb94t+r+jELsHLfSjIiuMZ3W2uLNB7fSN7GSsYFrjAlpriaiXsZTioHibWUmSjJ2kKiEp8Fy3xxQg/XJOQF9OJJYmKSHecf2ddI8jSVmSLsKELREPFE+wcN0nJOKPoDYAYwt0+PZGCYs/S6iwIxKeAz0/ddH1VvOvAVX2jeDVuwreO/G3OA0i6ubNaBMYxb/NeobGLOyssm44kY6Dy7wQkPU0OloGY57ky7RzRTTQYyxt+t2OhhNEWAsfcSS+JpuVsToFgyIO9BNBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQ6WDIr/7wULNkhPu0RQjuqTFOw+iww6KaUPRwEd0nY=;
 b=fWh9f7zuj6Oz3P8f93kDtXZOdlXwmjJ45qOToBwXosAm2i9BC1ozBcoBjDf5LnmAjLmR2RAMMc8rXK9Yrro3FtPxC8QZA5sX5hHuprnaPPTpPlJbT3L9bqrjP4ONcQLpusnwh2XwlWV0jatIDV0KY0W28uLYrj8fWe5KN4cyVAVdWvzzzJHqM4G7FG8loD9UHlYaT5o/uQNr4t4qdmc/EXv+yLiPdsFa1XPCo69Du+dpFAUhAUFsJWc+1CBggssPBiJKX/TOVj9RIlZFK+4x4F+tpw8wPS0+yrrdQXXFNEnWM8B28FcbB3YWjzo5Jg0l9/3NgRI6dBOLR/Zkyb5ZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 00:16:51 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 00:16:51 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "Taylor, Perry" <perry.taylor@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "irogers@google.com"
	<irogers@google.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "Wang, Weilin" <weilin.wang@intel.com>,
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v1 03/35] perf vendor events: Update arrowlake
 events/metrics
Thread-Topic: [PATCH v1 03/35] perf vendor events: Update arrowlake
 events/metrics
Thread-Index: AQHbmvR+bmvjHIPgmk6PDeBfnorbyrODAH2A
Importance: high
X-Priority: 1
Date: Tue, 25 Mar 2025 00:16:51 +0000
Message-ID: <48eb46bce14d895b61560907cb7f0df9038df57d.camel@intel.com>
References: <20250322063403.364981-1-irogers@google.com>
		 <20250322063403.364981-4-irogers@google.com>
In-Reply-To: <20250322063403.364981-4-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|PH0PR11MB4807:EE_
x-ms-office365-filtering-correlation-id: 04591298-5b77-4776-1dba-08dd6b325754
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZHZrYWU3OFM0R2NFTnZvc0lhNlRoY0xXbldQUFE4cWU1eGVGeXlOYWxCbnFJ?=
 =?utf-8?B?a3VndFZCM0s5U3JEYWY3ekVZb3o5eXNMZjRZeUl2Qld3bDQraSsxT0ZtNkx2?=
 =?utf-8?B?a2RmVjN5OENZWHlaelNVNG9MN1dTenA4ZjVTSGxnN0x3bEwrc1ZoRTJBYlRv?=
 =?utf-8?B?WTJDYjFyL054TDdXb2VpZFJYUVY5UUNaSytiSE4rM1hEdGJzY1A1eXBrN1hk?=
 =?utf-8?B?d2VQL3BhOFZtaUd5bWpsbElVR3JpaG5RdWZQTVBSa0RGQ0htcVpHL050a0pY?=
 =?utf-8?B?SGRxMjFEUWsxNjBnbWdXcUdCV1BYNkt4UW1WN0w1RlZjZFNjbDlDUExBTDBp?=
 =?utf-8?B?QzhkdlQ2Vjh1NkZpTlN1Tm45S0JYdWZyVFJvZTFRcEtHMG9wTFZMY2hWQThB?=
 =?utf-8?B?RmJhSTY0UG9BUjNoRXZ1blRHTjdyY09YUVBISnFEZEdINHRWN3lxdTdZNDln?=
 =?utf-8?B?ZVdjcHdRTWQxd1dzKzBqOWdOb2VtTHFBTWtUblBGTStGSlQzNnVIaURhK250?=
 =?utf-8?B?RjcxSnpoT0N4VlBrWktWT0hFRTNiY3dkSE9iMG1BZ05ONk9xUkJFQVpzUTM1?=
 =?utf-8?B?YzR5VG4vNkhpRGZ0K0NwSXlvV0hPUzBBY0RLNW9NUzlubXBTSlY5RUJPUUVK?=
 =?utf-8?B?bGZIVHlPRU5mQW1oYWRMMW5zQlRFaXdkQTVaQzdPOFlKWk41SmFUQnA0SExL?=
 =?utf-8?B?OW1JeEFheE9XbHdqUHhXbVU4eDc0ZFR5bXBHaVdKcUdvcnVaZVNBTEE1d2R5?=
 =?utf-8?B?NEZzNjZEVk5Bb0F1WE9sOSs2OG9PNkVVc0c5dE96QTNWd0U5R3orQ1pHK2xa?=
 =?utf-8?B?MEkxQVd2M2E1WTJ1SlgraWMyamNkV01WeC9CY2dNeWpDeHZXZHNVcHI2bXNh?=
 =?utf-8?B?alBJd0FZVFlCWExFVHJOMlBOcFBYN0REb0hPWmFyMG5jUkR5ZGdsTzJDUml5?=
 =?utf-8?B?aGNjUzcvSE5udFoycFFGYVF3MVdPV1I4b3lsTkpCQWN3NHpyWHhYQ2JXQ042?=
 =?utf-8?B?cVVRN2pCUnZRQ3JLYVRWNHBxMzNmVW9vVjc0MzRTek8rMTUvNGVXWDlraVFJ?=
 =?utf-8?B?bTNiMWZQM1hkOWc1R3VaOXhFMUFIN1FxOU90VVNjVmRIV3pMUy84cER6dHo5?=
 =?utf-8?B?RHVGbXp5cDVHeFd2cGs0M2lNRUdZanlRTlNrMEkzZHYvSS8zOFVLTkpqL2dj?=
 =?utf-8?B?MUJ0Z0Erb29nU0t4ZDJ0N3d4K0tYV3JIM1hqSG1XRkt0eWxiMjJUUmJzMUJ0?=
 =?utf-8?B?RGVxV21aK2xJQTlUcWIxbFE3cnhVN3h2M2poMUdnOWYyT1g3TStCeXBCMkZL?=
 =?utf-8?B?SGZuMS91ejg5M0hUaWw5WWRTcnVNN0ZJRUdmdXp2R0dZVzBqV21HcUNmM2Ez?=
 =?utf-8?B?TlUreFBEdy9DWW5OUHF0ZW5HdmVnY2REV1lpUzRUTStHZ2tqdHpIVDhXYVRO?=
 =?utf-8?B?b1pIRDR5QU5Td0xpTFlTMzdMREpCOWJ0anpEQW9scnFKSEZmRURFTUxBOTVS?=
 =?utf-8?B?NUFqeDRYb3JrY0JydlQ4V3J6Sjg0LzZFMHVWSU9MRTNnYjJFMG4yYlh2cHVJ?=
 =?utf-8?B?a2RUNXc1QXg4OGUveGhWeXIwNVVXOEFIQnNKNkFweCtrTkh4d09NZmJKQVBD?=
 =?utf-8?B?cDFUQk9NU2ptOHdDMlA2S0hFNThiQm9QemF3NFJnNUVpTkVHdmFUS0gyZmo3?=
 =?utf-8?B?K0FkTHc3cC91dGZwbHcyL0hsNitiQ0RCTHFOTXlYWkoyam9hL3hIMTNvZmRI?=
 =?utf-8?B?bjI3S1lJTVJHc3JwYnYwYU5TRnlrSWNieW95djYzay9SY0RHd1NFUDBOekZr?=
 =?utf-8?B?TlRUQUhBMTVERE9KYTVZRlFkeUpkTWF4Qkk1MHJTY1VzYzFHdllYMUNJWFk3?=
 =?utf-8?B?NW9iYzdPamtVYmlkZ2xaRnpmbFJKbzNCWGJTN1c0MmNZSGd4N0pNVEc0MWtX?=
 =?utf-8?B?aFliNHNuZVlaeXZ6WVA3WU03am53Y0pYZkhibjVYMTlrTFZicCtLS0ExYzZC?=
 =?utf-8?B?RGtWRWg3MXp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkRNbW1nYUZjZUdJckRLMGdUQ29OYVZ3Z3VWR0FCVkhJVG9HNVpoUlBFL2JJ?=
 =?utf-8?B?SDZzME5ESUl2dGN4TkVnRUJwcG9jUWcwSXRsYzlITkpMUFVjNVIzRHVvSDYv?=
 =?utf-8?B?MEhQKzh4ZUt3QUlXUHE2VEhXalFjVWVoNFg3S1BSNEJHcmYzUzN2amRJanVq?=
 =?utf-8?B?K0Y1bDcyY21NeFd0NU1vVnNxNGpXMHVCS2JKT2tMMTdGSmxRejF5V2VwWlZp?=
 =?utf-8?B?SXJQMVEzVCtyNi9uQ2RkUXlISUhKQ2hWdkdvOHlaTVJXQmpocGszUTlwVGNt?=
 =?utf-8?B?QXRFMDRBY1Z1citIdkpFQWJIanRWb2dtbVlOR04zMmMrSk5UVmtLcys1Rmd1?=
 =?utf-8?B?dm5VQzk2emlvSU1oNVFPd2pOR2F1Q1cvYVlFUDBwY2dRbFNTKzBvaVZOM2RT?=
 =?utf-8?B?Rk54dys1TXhNeFFyM21DM3dWWGliS2VVaUI5NDBvczU1SGhyRVphMEo2Y2VK?=
 =?utf-8?B?bFJMaEUzcDIzRTkvR0s5cmxuY3ZOZkxUaW5Md0w0cWxCTHlKVXNKTkZRY2ZQ?=
 =?utf-8?B?U3dkUmJ4N21NSHN4WDc1S1lCUnUweTRvYlhqdHBZSzlVOWNieUdtMFBmV24x?=
 =?utf-8?B?U1NwYnRjM0Z4Zklzd0FHR0YvbVo0YWhDLzVJbjhqY0dTM1g1T0lGNmkrLzcy?=
 =?utf-8?B?L0xaaUNmZ3psU1pEd1JuQU9HU281Vm9tNm11T2k5czNHT0FlTWJiUnY3Tzds?=
 =?utf-8?B?QXNoTE5ONUFpYWo5S2RmQzdhT1ZPQ29wTmE0WklLc2Z3bmVXZ1BhSG1kUlIw?=
 =?utf-8?B?RlY2d1RUY2c1NkpNYWlWMk0zeUQ0WW5ZSUk5b3pIczF4M2JnbkZhVVFibGZk?=
 =?utf-8?B?NTNrTERpVGJIUmQ0RjNOUXV6NGZUL1FWN0VGMGxwK25lUEZDR2orM0ZZei9x?=
 =?utf-8?B?VEFtQk1vWXFrcDg2S2NmODYzZEdGeldNYVlONDJveDRFWmVGblo2KytidmVF?=
 =?utf-8?B?M0EvNFhTM2pEYjd6dTdmOXRKTnAzdW1lcXo4dUZtK2R4LzUrU1VZY1I0RnF6?=
 =?utf-8?B?RmpjUjRHUGM0T1EybjRhMmZxSDV5WGZYdTFxeUhnYVIxaU9rbGhpb0NsWjNF?=
 =?utf-8?B?cGtmaGpucnlLMElFTGNqT3VQTWtrSXVkN20vMXlaTE5IbWpjYjBlYTkwTndn?=
 =?utf-8?B?R1JCa1Fyd1pETmdKMm1ZNUloV1FEZFl2U0c4Sk1Wdk5EbWErUWwrRzRUZlUr?=
 =?utf-8?B?VDB0Vi85aEFSWnpDeUN6aVI4Tk1xeGo0ZW5adlNGdUJpKzR5cHVEWEI3a1pq?=
 =?utf-8?B?TXEzejdKRlo5aWZlS0YvVkdiWkgvQ0hEZzQxZWxwNEJBbDVwODZlZzdURWU2?=
 =?utf-8?B?V0tEMVlIZ01IK2JxWnp5b01uQnh0dTJJMlAzQlhOUjViSHlPQmpSd2RFYXp1?=
 =?utf-8?B?Y1h2K3BnV1lRbytsWG5WVFYwUVlLQnROWTIrMFNLLzhnT2lYZTVyR0VPdlE3?=
 =?utf-8?B?NWNHMmlHSTFNdm1RUmc5Ui9PeVd3SGRZRUtWL1pYWDFYaFBsZVpZYUx2M0FY?=
 =?utf-8?B?TWs2YXhuQU5UTmhqQWNiQ0tWSTNyT1dtYmJiVC9ZVlRDdlgvUXpxK3IyQUwx?=
 =?utf-8?B?ckhITmtNUmU1bTNueUc0VnZRdXJrUmV3S2U4QU1PMDhBSlJOQlZDNnBzSG1s?=
 =?utf-8?B?WG5ZcTJvMVhXeWJ4bG5xN1dxUS9La1Q1UkxwampnS050YkVxSlFPSlphUjZx?=
 =?utf-8?B?SGpoRmk1eDZER3pUaUNlckF1Y1dCKzl6V1dnMzgvR0xBbmVIZWxlQjFYU1FM?=
 =?utf-8?B?SnAzRjFUcUhVYlRqaitkZldheFR3em5lcU44eWhReG0zM0M2THpUdGdsckdO?=
 =?utf-8?B?VWJDeVZtMUVwYTluY1RhTGxhKysrZU1CNmpEZ3pHMFh4NlMwSGcwMnZObTEv?=
 =?utf-8?B?TzdiZTRMakMrc1owQ2R2cjRPMy9WSFNjM0VSSjlPcnVrL2kxeWVtMndjNDNE?=
 =?utf-8?B?Wlc0bnY0S2pYYmhJbkowc1M5RkFxdWV2RXg3ZTVaamtuVk9xQXEyMHJPcFVk?=
 =?utf-8?B?TW9UdW1ieTZYSVJsRHN2aDFVMGdkUCtzaGErNlk3OGVoNWtpR2FWSGE2Mmla?=
 =?utf-8?B?Zklra3NPL2dIVldwSnNTelAvc0FLS0NnemtxdzB6TE9RejY5Mzh4SUdQZndT?=
 =?utf-8?B?cmhVcDdjK0MwUGV5eUx4clNlTnVFaUZyZTdpY1NnbHBzZzdKNnEzQXlvUXRo?=
 =?utf-8?Q?cF4W66jD9LmsMXXV+mDgH/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4929388991B0F4C97ACA78A4E14A092@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04591298-5b77-4776-1dba-08dd6b325754
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 00:16:51.3589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIpl8zHHZtUV0x/o0DIPAV3vVM73R1jaumNF2PNN5ZKAQKy+DLChh516kqRIKq76ztW/A/R7vmPxnDF3EfaT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTAzLTIxIGF0IDIzOjMzIC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBV
cGRhdGUgZXZlbnRzIGZyb20gdjEuMDcgdG8gdjEuMDguDQo+IFVwZGF0ZSBldmVudCB0b3BpY3Ms
IG1ldHJpY3MgdG8gYmUgZ2VuZXJhdGVkIGZyb20gdGhlIFRNQSBzcHJlYWRzaGVldA0KPiBhbmQg
b3RoZXIgc21hbGwgY2xlYW4gdXBzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSWFuIFJvZ2VycyA8
aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gIC4uLi9hcmNoL3g4Ni9hcnJvd2xha2UvYXJs
LW1ldHJpY3MuanNvbiAgICAgICB8IDU2NiArKysrKysrKystLS0tLS0tLS0NCj4gIC4uLi9wbXUt
ZXZlbnRzL2FyY2gveDg2L2Fycm93bGFrZS9jYWNoZS5qc29uICB8IDE0OCArKysrKw0KPiAgLi4u
L3BtdS1ldmVudHMvYXJjaC94ODYvYXJyb3dsYWtlL21lbW9yeS5qc29uIHwgIDExICsNCj4gIC4u
Li9wbXUtZXZlbnRzL2FyY2gveDg2L2Fycm93bGFrZS9vdGhlci5qc29uICB8IDE5MyAtLS0tLS0N
Cj4gIC4uLi9hcmNoL3g4Ni9hcnJvd2xha2UvcGlwZWxpbmUuanNvbiAgICAgICAgICB8IDE2MyAr
KysrLQ0KPiAgdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gveDg2L21hcGZpbGUuY3N2ICAgIHwg
ICAyICstDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDYwOCBpbnNlcnRpb25zKCspLCA0NzUgZGVsZXRp
b25zKC0pDQo+IA0KPiANCi4uLg0KDQo+IEBAIC0xMDg2LDE4ICsxMDg2LDE4IEBADQo+ICAgICAg
ICAgICJNZXRyaWNFeHByIjogImNwdV9jb3JlQE1FTU9SWV9TVEFMTFMuTUVNQCAvIHRtYV9pbmZv
X3RocmVhZF9jbGtzIiwNCj4gICAgICAgICAgIk1ldHJpY0dyb3VwIjogIk1lbW9yeUJvdW5kO1Rt
YUwzbWVtO1RvcGRvd25MMzt0bWFfTDNfZ3JvdXA7dG1hX21lbW9yeV9ib3VuZF9ncm91cCIsDQo+
ICAgICAgICAgICJNZXRyaWNOYW1lIjogInRtYV9kcmFtX2JvdW5kIiwNCj4gLSAgICAgICAgIk1l
dHJpY1RocmVzaG9sZCI6ICJ0bWFfZHJhbV9ib3VuZCA+IDAuMSAmIHRtYV9tZW1vcnlfYm91bmQg
PiAwLjIgJiB0bWFfYmFja2VuZF9ib3VuZCA+IDAuMiIsDQo+ICsgICAgICAgICJNZXRyaWNUaHJl
c2hvbGQiOiAidG1hX2RyYW1fYm91bmQgPiAwLjEgJiAodG1hX21lbW9yeV9ib3VuZCA+IDAuMiAm
IHRtYV9iYWNrZW5kX2JvdW5kID4gMC4yKSIsDQo+ICAgICAgICAgICJQdWJsaWNEZXNjcmlwdGlv
biI6ICJUaGlzIG1ldHJpYyBlc3RpbWF0ZXMgaG93IG9mdGVuIHRoZSBDUFUgd2FzIHN0YWxsZWQg
b24gYWNjZXNzZXMgdG8gZXh0ZXJuYWwgbWVtb3J5IChEUkFNKSBieSBsb2Fkcy4gQmV0dGVyIGNh
Y2hpbmcgY2FuIGltcHJvdmUgdGhlIGxhdGVuY3kgYW5kIGluY3JlYXNlIHBlcmZvcm1hbmNlLiBT
YW1wbGUgd2l0aDogTUVNX0xPQURfUkVUSVJFRC5MM19NSVNTIiwNCj4gICAgICAgICAgIlNjYWxl
VW5pdCI6ICIxMDAlIiwNCj4gICAgICAgICAgIlVuaXQiOiAiY3B1X2NvcmUiDQo+ICAgICAgfSwN
Cj4gICAgICB7DQo+ICAgICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIlRoaXMgbWV0cmljIHJl
cHJlc2VudHMgQ29yZSBmcmFjdGlvbiBvZiBjeWNsZXMgaW4gd2hpY2ggQ1BVIHdhcyBsaWtlbHkg
bGltaXRlZCBkdWUgdG8gRFNCIChkZWNvZGVkIHVvcCBjYWNoZSkgZmV0Y2ggcGlwZWxpbmUiLA0K
PiAtICAgICAgICAiTWV0cmljRXhwciI6ICIoY3B1X2NvcmVASURRLkRTQl9VT1BTXFwsY21hc2tc
XD0weDhcXCxpbnZcXD0weDFAICsgY3B1X2NvcmVASURRLkRTQl9VT1BTQCAvIChjcHVfY29yZUBJ
RFEuRFNCX1VPUFNAICsgY3B1X2NvcmVASURRLk1JVEVfVU9QU0ApICogKGNwdV9jb3JlQElEUV9C
VUJCTEVTLkNZQ0xFU18wX1VPUFNfREVMSVYuQ09SRUAgLSBjcHVfY29yZUBJRFFfQlVCQkxFUy5G
RVRDSF9MQVRFTkNZQCkpIC8gdG1hX2luZm9fdGhyZWFkX2Nsa3MiLA0KPiArICAgICAgICAiTWV0
cmljRXhwciI6ICIoY3B1QElEUS5EU0JfVU9QU1xcLGNtYXNrXFw9MHg4XFwsaW52XFw9MHgxQCAr
IGNwdV9jb3JlQElEUS5EU0JfVU9QU0AgLyAoY3B1X2NvcmVASURRLkRTQl9VT1BTQCArIGNwdV9j
b3JlQElEUS5NSVRFX1VPUFNAKSAqIChjcHVfY29yZUBJRFFfQlVCQkxFUy5DWUNMRVNfMF9VT1BT
X0RFTElWLkNPUkVAIC0gY3B1X2NvcmVASURRX0JVQkJMRVMuRkVUQ0hfTEFURU5DWUApKSAvIHRt
YV9pbmZvX3RocmVhZF9jbGtzIiwNCj4gICAgICAgICAgIk1ldHJpY0dyb3VwIjogIkRTQjtGZXRj
aEJXO1RvcGRvd25MMzt0bWFfTDNfZ3JvdXA7dG1hX2ZldGNoX2JhbmR3aWR0aF9ncm91cCIsDQo+
ICAgICAgICAgICJNZXRyaWNOYW1lIjogInRtYV9kc2IiLA0KPiAgICAgICAgICAiTWV0cmljVGhy
ZXNob2xkIjogInRtYV9kc2IgPiAwLjE1ICYgdG1hX2ZldGNoX2JhbmR3aWR0aCA+IDAuMiIsDQo+
IC0gICAgICAgICJQdWJsaWNEZXNjcmlwdGlvbiI6ICJUaGlzIG1ldHJpYyByZXByZXNlbnRzIENv
cmUgZnJhY3Rpb24gb2YgY3ljbGVzIGluIHdoaWNoIENQVSB3YXMgbGlrZWx5IGxpbWl0ZWQgZHVl
IHRvIERTQiAoZGVjb2RlZCB1b3AgY2FjaGUpIGZldGNoIHBpcGVsaW5lLiAgRm9yIGV4YW1wbGU7
IGluZWZmaWNpZW50IHV0aWxpemF0aW9uIG9mIHRoZSBEU0IgY2FjaGUgc3RydWN0dXJlIG9yIGJh
bmsgY29uZmxpY3Qgd2hlbiByZWFkaW5nIGZyb20gaXQ7IGFyZSBjYXRlZ29yaXplZCBoZXJlIiwN
Cj4gKyAgICAgICAgIlB1YmxpY0Rlc2NyaXB0aW9uIjogIlRoaXMgbWV0cmljIHJlcHJlc2VudHMg
Q29yZSBmcmFjdGlvbiBvZiBjeWNsZXMgaW4gd2hpY2ggQ1BVIHdhcyBsaWtlbHkgbGltaXRlZCBk
dWUgdG8gRFNCIChkZWNvZGVkIHVvcCBjYWNoZSkgZmV0Y2ggcGlwZWxpbmUuICBGb3IgZXhhbXBs
ZTsgaW5lZmZpY2llbnQgdXRpbGl6YXRpb24gb2YgdGhlIERTQiBjYWNoZSBzdHJ1Y3R1cmUgb3Ig
YmFuayBjb25mbGljdCB3aGVuIHJlYWRpbmcgZnJvbSBpdDsgYXJlIGNhdGVnb3JpemVkIGhlcmUu
IiwNCj4gICAgICAgICAgIlNjYWxlVW5pdCI6ICIxMDAlIiwNCj4gICAgICAgICAgIlVuaXQiOiAi
Y3B1X2NvcmUiDQo+ICAgICAgfSwNCj4gDQoNCkknbSBzZWVpbmcgc29tZSBlcnJvcnMgZm9yIG1l
dHJpY3MgdG1hX2RzYiwgdG1hX2xzZCwgYW5kIHRtYV9taXRlIG9uIGFycm93bGFrZS4gSSB0aGlu
ayBjcHUgc2hvdWxkDQpiZSBjcHVfY29yZSBoZXJlDQoNCiQgc3VkbyAuL3BlcmYgc3RhdCAtTSB0
bWFfZHNiDQpldmVudCBzeW50YXggZXJyb3I6ICcuLi5USFJFQUQhMy8sY3B1L0lEUS5EU0JfVU9Q
UyxjbWFzaz0weDgsaW52PTB4MSxtZXRyaWMtDQppZD1jcHUhM0lEUS5EU0JfVU9QUyEwY21hc2sh
MjB4OCEwaW52ITIweDEhMy8sY3B1X2NvcmUvdG9wZG93bi1mZS1ib3VuZCxtZXRyaWMtaWQ9Y3B1
X2NvcmUhM3QuLicNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcX19fIEJhZCBl
dmVudCBvciBQTVUNCg0KVW5hYmxlIHRvIGZpbmQgUE1VIG9yIGV2ZW50IG9uIGEgUE1VIG9mICdj
cHUnDQoNCg0KPiAgICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJUaGlzIG1ldHJpYyByZXBy
ZXNlbnRzIENvcmUgZnJhY3Rpb24gb2YgY3ljbGVzIGluIHdoaWNoIENQVSB3YXMgbGlrZWx5IGxp
bWl0ZWQgZHVlIHRvIExTRCAoTG9vcCBTdHJlYW0gRGV0ZWN0b3IpIHVuaXQiLA0KPiAtICAgICAg
ICAiTWV0cmljRXhwciI6ICJjcHVfY29yZUBMU0QuVU9QU1xcLGNtYXNrXFw9MHg4XFwsaW52XFw9
MHgxQCAvIHRtYV9pbmZvX3RocmVhZF9jbGtzIiwNCj4gKyAgICAgICAgIk1ldHJpY0V4cHIiOiAi
Y3B1QExTRC5VT1BTXFwsY21hc2tcXD0weDhcXCxpbnZcXD0weDFAIC8gdG1hX2luZm9fdGhyZWFk
X2Nsa3MiLA0KPiAgICAgICAgICAiTWV0cmljR3JvdXAiOiAiRmV0Y2hCVztMU0Q7VG9wZG93bkwz
O3RtYV9MM19ncm91cDt0bWFfZmV0Y2hfYmFuZHdpZHRoX2dyb3VwIiwNCj4gICAgICAgICAgIk1l
dHJpY05hbWUiOiAidG1hX2xzZCIsDQo+ICAgICAgICAgICJNZXRyaWNUaHJlc2hvbGQiOiAidG1h
X2xzZCA+IDAuMTUgJiB0bWFfZmV0Y2hfYmFuZHdpZHRoID4gMC4yIiwNCj4gLSAgICAgICAgIlB1
YmxpY0Rlc2NyaXB0aW9uIjogIlRoaXMgbWV0cmljIHJlcHJlc2VudHMgQ29yZSBmcmFjdGlvbiBv
ZiBjeWNsZXMgaW4gd2hpY2ggQ1BVIHdhcyBsaWtlbHkgbGltaXRlZCBkdWUgdG8gTFNEIChMb29w
IFN0cmVhbSBEZXRlY3RvcikgdW5pdC4gIExTRCB0eXBpY2FsbHkgZG9lcyB3ZWxsIHN1c3RhaW5p
bmcgVW9wIHN1cHBseS4gSG93ZXZlcjsgaW4gc29tZSByYXJlIGNhc2VzOyBvcHRpbWFsIHVvcC1k
ZWxpdmVyeSBjb3VsZCBub3QgYmUgcmVhY2hlZCBmb3Igc21hbGwgbG9vcHMgd2hvc2Ugc2l6ZSAo
aW4gdGVybXMgb2YgbnVtYmVyIG9mIHVvcHMpIGRvZXMgbm90IHN1aXQgd2VsbCB0aGUgTFNEIHN0
cnVjdHVyZSIsDQo+ICsgICAgICAgICJQdWJsaWNEZXNjcmlwdGlvbiI6ICJUaGlzIG1ldHJpYyBy
ZXByZXNlbnRzIENvcmUgZnJhY3Rpb24gb2YgY3ljbGVzIGluIHdoaWNoIENQVSB3YXMgbGlrZWx5
IGxpbWl0ZWQgZHVlIHRvIExTRCAoTG9vcCBTdHJlYW0gRGV0ZWN0b3IpIHVuaXQuICBMU0QgdHlw
aWNhbGx5IGRvZXMgd2VsbCBzdXN0YWluaW5nIFVvcCBzdXBwbHkuIEhvd2V2ZXI7IGluIHNvbWUg
cmFyZSBjYXNlczsgb3B0aW1hbCB1b3AtZGVsaXZlcnkgY291bGQgbm90IGJlIHJlYWNoZWQgZm9y
IHNtYWxsIGxvb3BzIHdob3NlIHNpemUgKGluIHRlcm1zIG9mIG51bWJlciBvZiB1b3BzKSBkb2Vz
IG5vdCBzdWl0IHdlbGwgdGhlIExTRCBzdHJ1Y3R1cmUuIiwNCj4gICAgICAgICAgIlNjYWxlVW5p
dCI6ICIxMDAlIiwNCj4gICAgICAgICAgIlVuaXQiOiAiY3B1X2NvcmUiDQo+ICAgICAgfSwNCj4g
DQoNCi4uLmhlcmUNCg0KJCBzdWRvIC4vcGVyZiBzdGF0IC1NIHRtYV9sc2QNCmV2ZW50IHN5bnRh
eCBlcnJvcjogJy4uLlRIUkVBRCEzLyxjcHUvTFNELlVPUFMsY21hc2s9MHg4LGludj0weDEsbWV0
cmljLQ0KaWQ9Y3B1ITNMU0QuVU9QUyEwY21hc2shMjB4OCEwaW52ITIweDEhMy8sY3B1X2NvcmUv
dG9wZG93bi1mZS1ib3VuZCxtZXRyaWMtaWQ9Y3B1X2NvcmUhM3RvcGRvd24hMS4uJw0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFxfX18gQmFkIGV2ZW50IG9yIFBNVQ0KDQpVbmFi
bGUgdG8gZmluZCBQTVUgb3IgZXZlbnQgb24gYSBQTVUgb2YgJ2NwdScNCg0KDQo+ICAgICAgfSwN
Cj4gICAgICB7DQo+ICAgICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIlRoaXMgbWV0cmljIHJl
cHJlc2VudHMgQ29yZSBmcmFjdGlvbiBvZiBjeWNsZXMgaW4gd2hpY2ggQ1BVIHdhcyBsaWtlbHkg
bGltaXRlZCBkdWUgdG8gdGhlIE1JVEUgcGlwZWxpbmUgKHRoZSBsZWdhY3kgZGVjb2RlIHBpcGVs
aW5lKSIsDQo+IC0gICAgICAgICJNZXRyaWNFeHByIjogIihjcHVfY29yZUBJRFEuTUlURV9VT1BT
XFwsY21hc2tcXD0weDhcXCxpbnZcXD0weDFAIC8gdG1hX2luZm9fdGhyZWFkX2Nsa3MgKyBjcHVf
Y29yZUBJRFEuTUlURV9VT1BTQCAvIChjcHVfY29yZUBJRFEuRFNCX1VPUFNAICsgY3B1X2NvcmVA
SURRLk1JVEVfVU9QU0ApICogKGNwdV9jb3JlQElEUV9CVUJCTEVTLkNZQ0xFU18wX1VPUFNfREVM
SVYuQ09SRUAgLSBjcHVfY29yZUBJRFFfQlVCQkxFUy5GRVRDSF9MQVRFTkNZQCkpIC8gdG1hX2lu
Zm9fdGhyZWFkX2Nsa3MiLA0KPiArICAgICAgICAiTWV0cmljRXhwciI6ICIoY3B1QElEUS5NSVRF
X1VPUFNcXCxjbWFza1xcPTB4OFxcLGludlxcPTB4MUAgLyAyICsgY3B1X2NvcmVASURRLk1JVEVf
VU9QU0AgLyAoY3B1X2NvcmVASURRLkRTQl9VT1BTQCArIGNwdV9jb3JlQElEUS5NSVRFX1VPUFNA
KSAqIChjcHVfY29yZUBJRFFfQlVCQkxFUy5DWUNMRVNfMF9VT1BTX0RFTElWLkNPUkVAIC0gY3B1
X2NvcmVASURRX0JVQkJMRVMuRkVUQ0hfTEFURU5DWUApKSAvIHRtYV9pbmZvX3RocmVhZF9jbGtz
IiwNCj4gICAgICAgICAgIk1ldHJpY0dyb3VwIjogIkRTQm1pc3M7RmV0Y2hCVztUb3Bkb3duTDM7
dG1hX0wzX2dyb3VwO3RtYV9mZXRjaF9iYW5kd2lkdGhfZ3JvdXAiLA0KPiAgICAgICAgICAiTWV0
cmljTmFtZSI6ICJ0bWFfbWl0ZSIsDQo+ICAgICAgICAgICJNZXRyaWNUaHJlc2hvbGQiOiAidG1h
X21pdGUgPiAwLjEgJiB0bWFfZmV0Y2hfYmFuZHdpZHRoID4gMC4yIiwNCg0KLi4uYW5kIGhlcmU/
DQoNCiQgc3VkbyAuL3BlcmYgc3RhdCAtTSB0bWFfbWl0ZQ0KZXZlbnQgc3ludGF4IGVycm9yOiAn
Li5ldGlyaW5nITMvLGNwdS9JRFEuTUlURV9VT1BTLGNtYXNrPTB4OCxpbnY9MHgxLG1ldHJpYy0N
CmlkPWNwdSEzSURRLk1JVEVfVU9QUyEwY21hc2shMjB4OCEwaW52ITIweDEhMy8sY3B1X2NvcmUv
dG9wZG93bi1iYWQtc3BlYyxtZXRyaWMtaWQ9Y3B1X2NvcmUhLi4nDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXF9fXyBCYWQgZXZlbnQgb3IgUE1VDQoNClVuYWJsZSB0byBmaW5k
IFBNVSBvciBldmVudCBvbiBhIFBNVSBvZiAnY3B1Jw0KDQpUaGFua3MsDQpUb20NCg0KDQo=
