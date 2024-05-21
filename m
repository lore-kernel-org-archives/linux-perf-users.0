Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717A7F;
	Tue, 21 May 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250237; cv=fail; b=DP0XWRXd6xwh/6pEP5yVHVUiTAs75QmO+2DjJOhMj2B2XqEbFzQnxWdeqc6P1U+Vf11V32WTCWqtTh3G9p9TIe8Ndm0nTsGkhhwWqwE7U8OnfmHmazih7aoSkVPdoKo2R1tAW8GE+MJN2G7IrNTYTaAvhu2GOHMx8TWEt+ddpGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250237; c=relaxed/simple;
	bh=57eHItRrT0RrsG70fucRIvzglMefeUDRoHU07wVjPks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dXWgKPcE4JXGtDeaWUYAVEm3/7TSN6UR2vlOz8j0VSwngIsV+bWd5M+A+ZXxYSP7KpJEuf/OAFUOl6x2vzv/eZA8VchIXP90VKzPoNQf4rd7/qBQngyjVDoinXHY/L3NOMPi1XrU0fJC5mv8ufwjngJjXcz6HvQRYyQtp1aUKn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjlLreJ3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjlLreJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716250235; x=1747786235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=57eHItRrT0RrsG70fucRIvzglMefeUDRoHU07wVjPks=;
  b=PjlLreJ3f5N1raIIXDCuqXOIoKbXmNBKkYEuYAZtodeUGKtjnnHecqgO
   xr2g2l+VjugSaWOMbprLMY7F73JGxOq4WvHN0iNk/LTc6Mz9zXGCWBMAE
   mwFgsdomDs9Rhw7HQC+TPo182OxzJFd9uPGyQVpEyLzM8auSypxGIKSL8
   2Sr+PdIVmNXdVVI67g/sqkRRhc8gDC6Fg7+fX8hBIEh4uFjCoG6Ib3rlr
   EIpgb+v6bYdf/PvGGuYJpqoQzQKEn64+Jkr1Oyj+FXhmVbTCfERlb8kYG
   Zs0fQsmBuA6c4w2/ww4fAB3EBYpMEak+kktzXcoyTI8K+USwxDvHk6PdT
   Q==;
X-CSE-ConnectionGUID: XJusI5q7QNyD2pQKp4b70Q==
X-CSE-MsgGUID: dz7Z5TaOTT+LHFW41m3RFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23552678"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="23552678"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 17:10:34 -0700
X-CSE-ConnectionGUID: fzVUsYwyRJGDu1j6+IE24Q==
X-CSE-MsgGUID: HmMnvOXQRzWvZZNuW7rgZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="55958236"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 17:10:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 17:10:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 17:10:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 17:10:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 17:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFN0678JnBJI59JsfB5cppRgENglm+Uy9+zOgYFpQcH0V2Fx01Tk/z7bGgjFnLxsqoAxdnSNpy5z8mRmEg0PQgXw0ejpgzPzLZWZNHPkUB4vwNpO2riSx617/QNxokJf+0mcdYVFqHn6Tw/ILa+yt+7sohI/bUiys2iUAxeSGfVNLAigIIgIgL8RvqRSGTDTTX0etXmqBCs7DNe6MkZaOYnYbmGuN7qFDhe4vn3PWUZsvT4t/f4Xx6FRJgbCmptaYzM4isGwptQcyyh3y7Q8o850q+b7Aq0ATBFz8d7QLS1pQ7f5AnBgtNymwe2bNt7FAs7fHPWlBmQoCFm2nyfCDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57eHItRrT0RrsG70fucRIvzglMefeUDRoHU07wVjPks=;
 b=J6rNnElekjTj0Vs7dcagbplp9If+ou548yEHD/L1PAtuQ44ZAXqwppV662QF+jEIbGut5V/xu/mcz97d9G3A6KiwxYX+8qMQxDvTJLXps0sEfsmVafA7qebMEJ77prVS5AVsyqQru2Rz4DwJSffudKK/PComqej1A56AP5q6IfNXpC9m6NnM/iB2tOCUrtsBb6X9N2WKE6KVXoDYPE5hnAwF1sxlJixKWxF0RvioSR34RQ4Mrt+V6XUkHUgPJk0s6MsiEPYjsVpED/Tx3i0iErysw238wYCATRTsrIehupklNP9ak4P56+e+uDiUJ5vLQ2v4XODqa79tmVE70eeRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 00:10:31 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 00:10:30 +0000
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
Subject: RE: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHaposFrByRjGFRDkOWD8ukWbv8TbGb+VMAgATX/DA=
Date: Tue, 21 May 2024 00:10:30 +0000
Message-ID: <CO6PR11MB563574C9C284744CD079C0D3EEEA2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-4-weilin.wang@intel.com>
 <CAM9d7cghtG-9rwy5Yg-oJDETO-J5OUzPt6=xMCwacKqfwo+sZA@mail.gmail.com>
In-Reply-To: <CAM9d7cghtG-9rwy5Yg-oJDETO-J5OUzPt6=xMCwacKqfwo+sZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SA3PR11MB7554:EE_
x-ms-office365-filtering-correlation-id: 004aebe1-51ac-4963-dfa4-08dc792a6d45
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bzFVSlpiYjk0ZzVTVFZBdmtiNTVxRmxOdkErT1hESVU3ZUhNNkFOenJ4TW42?=
 =?utf-8?B?dlphRUNrK1pwZDFmZVVqNlF6VzhDNG15T0Z3ZmNlUHZXaHFNbHJYSi9FOS9E?=
 =?utf-8?B?Q2tFeU1ISDBDWVluMXk5TFNlRGJqbXVFcWlLdXAzczJKZ3VvZGM4ZHh4am9q?=
 =?utf-8?B?dFlSQzNIaUVJTklSYXd5RFhkRXhYZW9jQnp0YU1NeGRwT1hQcCs5clJRYk9s?=
 =?utf-8?B?SFU3UTRYZ3JqbStJNjE5VUh3TkllRUFuS1JpSTkra2dERGtiYzUxVm4rWFAv?=
 =?utf-8?B?S0hEeXJES0M5T3AvTjJJSXBBTURFVFcyZ0MxdngwZDRTbnR6ek5NRzEyRUtN?=
 =?utf-8?B?MU84QXVZaWtkR2NocUJLRVNwL3c1ZFVvazBNQzFzbWNPejNyeFc0VVZ6U2gz?=
 =?utf-8?B?OWJwSE9Hc1A3UHhyWitWRnQyQ05jQWJyOUdEeHFNeGNORGdMbWxxTUlldU5x?=
 =?utf-8?B?aG5Vb1ZqY3ZyTXRjV3ZuZkJuVXhtTDFad1EwamlMRlptYkpiVXNKSDAxOTZ4?=
 =?utf-8?B?QVdsdU9EYTBJMnhEMWNKV29IRzViNXJENFFyVjJ0UncrcXZ5ZWdMYkJLV2RP?=
 =?utf-8?B?ek9GK21nOXUxRnpxdzNQQjhRZFVJZWlpWnBwZldzZ1E2eDFVd2d5WkpZZkYv?=
 =?utf-8?B?bUpWQ2VnMVpZTHJmV09BNE85ZGNhVTZxL1oyLytScXg5cEE5akhjMWVrbUxL?=
 =?utf-8?B?c2hMQmxaVUcvbFpBV01ya25UUW13YWdNVG5ZZStzeHJzeHVpc2ZndUdvQnVa?=
 =?utf-8?B?QjFEL3diRElSYXNlanZiTWZrQ1lvQlVNUk85MmNvRldaVHpXblBvNVh0RmtQ?=
 =?utf-8?B?K0RlV2ltSk1qMVVIem9sNDRkbUNHWXorSWFjUkk2M1lHQjBBN2JhbnFUMUFF?=
 =?utf-8?B?cXYzNDVUY25JakgvTnVZTHN5dmcxMGt4YjZveWpnSkxVU002dlk3TG1xYkFX?=
 =?utf-8?B?NDkyYlpDRnk0bTVFMHZ4VkU2K3ZwblJNRFQvaDNzLzB6S3R5SFplbk1wQ1py?=
 =?utf-8?B?MzVqRjdmemxNYWQ3c3c1RHFZNEVlL0JwcTZwMEhrbjJ3Zzc3TWJCV3JzdlUx?=
 =?utf-8?B?Z0c2SFIycEJrUUpldGtGaWNvdjBnVWxlUDN2bGl0MXJqaW42MjB5Z2xBaHZ6?=
 =?utf-8?B?T1VNV2hJMG9MV2E1SUUvK0hqWUFxN3pEYXY4aEJFdEEwSmx4MUV6ZzVqdkMx?=
 =?utf-8?B?ZmhJSHVnamNxTndvQlQyVTA2c1VXWUVQbStNVkg5RlQ1NjF5TUxZc1M2d2J4?=
 =?utf-8?B?dmVxS3orV0tzbFMyRm9Fb3VySFdUN0ZxN3BwQVBTN01SY0pRanYza0ZEbVhR?=
 =?utf-8?B?R1R4ZWtYb1lyK0RWcXRHUEdYMFp4YStVWW5NT1c5bnJGNmFlRGJROUsxcU4v?=
 =?utf-8?B?b2owRlFQQ0FtQlVzeGpkakZnTGVsTDM1VnhxaU5YK2xhUTJlZGFQbVBCN244?=
 =?utf-8?B?eTVCSFpyTEtiMnlFVzIyRDQrd2NuUCtvWGROVHFUbmNURzVVbmE0Mld4N1Ir?=
 =?utf-8?B?bitTTmplbTJGbzNRVDBOYlNFK2tDd3R6RTkrOHRCaGd1elZYZUpnOWNNT3BU?=
 =?utf-8?B?NXdwV2VFNW81b1JFWVNYekV3Vnd2Um1iMjdiaUtqWUVSQ1ZpWHlWZ252cmxh?=
 =?utf-8?B?TVNGMW5nMUQxRmJkOVkyMjhFb242M0JRdlRabDJHOFRQMXRGZDNFNjgxRWJL?=
 =?utf-8?B?Mmd1NHliVVdlKy9mdzB0VGtVbmJXTnBTWG9CbCtyVFlESmo5SWQvUjhrajZP?=
 =?utf-8?B?S2tvZFE5dFh5UkhKam9JMHhCT3VIM1B2ZGZQakgvaXhybVNvNWEzOVg3SGR2?=
 =?utf-8?B?L1RUS0ZCSFJzLytzVjZ2dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHF1aDB0YVJuR21ZVFpRV0Roa3hhNFVLdjNqNS9GODQ5c2xPL2k3QlZtZlQr?=
 =?utf-8?B?NkxIaXFhYnMwczhFMmtuQzRIQjhWNUp1YVhkQkxIakNqQitLekczcWI3Y0ZU?=
 =?utf-8?B?a0dya3hucTE3M1A5eDdSQXBpQmJQRlFjOE1qYzhqa205VkttY3lQeVVNb1dp?=
 =?utf-8?B?MHl0anhXeXBwQUExdTEvcC91dVhLOUNhWmw2N0U2V0NJWEI0NFdCcHVvY1BS?=
 =?utf-8?B?Ly9nT1VOb2twN2pDNU45bjNwdVRHUkVobTA0cngxdHlNbHhqRjRpaHdra1M5?=
 =?utf-8?B?d0lDQjdLeHBYMVlLUnV4RFhhcklsM0VYeWRPUUVVdFEwSWFhVXlDMVRiVTFL?=
 =?utf-8?B?bkwySXB4RmJRZVNsOTFnbC8xNml2Rm1uVVRmanpaL2ZEQWkvMzkzTTR0K1J0?=
 =?utf-8?B?bk91RUM0ZlYwZkRUZ2toQ0dWOGxIV1E3cjdZYkRsTmZMMzFXa1RjS1BlUlo0?=
 =?utf-8?B?UmpCamt6Z1QvejFHZkxLNStndmE4VTQrUkl3MVRHNFMvbm5QR3BrR0hXOVAr?=
 =?utf-8?B?UXpOanNqYVQ4NnJDeDViVTVjSDc5S3VoY1lqalRxNEFKalZnN1ZRNFFmQ3Bk?=
 =?utf-8?B?VmE2emdsZEtnTTh2Z1huZVFjd2dheVJXUzFDZnMzSEhZcGNWTXVIeVMyWkE3?=
 =?utf-8?B?V1FyQTVlb0dzUjNYR2hlQncwYzM2MWswQWthaTBwMDl0RFJNRkloRHlObU9B?=
 =?utf-8?B?UG0wWU5DWWYyUmcrczM3TGQ5MWl3d2hOZ3dwUjFobFd3OVN3NXRYUEs3U1FB?=
 =?utf-8?B?QmVrZDNXTGUzOWpZRGRVQkFFUnpGbU16b1NOckdDVWpvTE9yTWd4YXI5WlE1?=
 =?utf-8?B?ZkphTjU5SXpTSjR5NlIwdmFFNVRNUlJvVzlVRGhWbERLSHhyTnpLSVVBZHRE?=
 =?utf-8?B?SFNZNVJ0YWtnVEF3T0ZJUUF1bi84TXlWdnBGbElsQjM0dUdsbnk2RHRmV1RL?=
 =?utf-8?B?Y2hpZlJlWjB1czdDUHlENEYvaElEbjZoeVJmMUFxbWlYSVBIcmtmeUEvMmVW?=
 =?utf-8?B?K2R1NVFXN3BjYjA5Mm01aDZRdGRDYllzdCtqTnVVTFlnb01xSHNYNjZQcVha?=
 =?utf-8?B?aXpySW54Ti9WUmc2dWsrQ1ArL0ZtMU54bXY2eWZOTWRyOXZidUNzdWV3VFdR?=
 =?utf-8?B?NWtMWTh1UXNqdTNZdWxuMmNpaFRLaWdaUmxoTGxKMTlzY2N4QXh2b2ROQnl0?=
 =?utf-8?B?SUVncFVoMWk4a3MyeHhncHlRbEkvWW9IdlEzY2lyUERXWnJKRjBITjJGbk5B?=
 =?utf-8?B?UDNtay90dENlVWJmSXhGWnRzMGlxU1NRVzRseURyVFV4MW1EcEpaRnZyMkI2?=
 =?utf-8?B?eDVNL04wUmNqZkY1bG1ZZU5UaWo2TWFCQ0kyNC8wS0FiSWV2MXNRUnRISUNl?=
 =?utf-8?B?UlNpWmZRN1ptbi9hSDdPVkdvKzZSdXhpd2ZWbmpxbUlQTDg3aks3ZUp3aUVR?=
 =?utf-8?B?WFZJbHIwaE9TWjV2RlYrcU1aYThwckVuU244TVMrWUVwMkxSbDRwR1FkOGY5?=
 =?utf-8?B?cHBRcEdyVjJXdzJsT1RET09xQVgvN2RZRVNOUlhIcDJqQk4zYW9MVmxJOUR5?=
 =?utf-8?B?akFqMDhVNFFzaFBJT3FTWVhwOTV3TFZNUlhZZUVNSWlnUWYvMEhITUpkUGh2?=
 =?utf-8?B?VGl2UFYyQ1REb1VmaXJPR2RmQkRLOGFncDRkWDQ1alNURWtqT3RsZmx2V1pt?=
 =?utf-8?B?dmFTUUlxVGNCeG5IZ1IwYnB2eXVkajEwdVptbDF1bFUzaWM3U0NoU2psNVVN?=
 =?utf-8?B?YUpTcXpYNEJwZmZNL1ZUNnVlNFV6Z1hZZnZ1QjliVjR1TTVFbkZnYjQ1VXhk?=
 =?utf-8?B?ZG9CeVV6akRvbHRwTmxXYkVHLzlqd2lJSkdYZGtEaEI0MkNCRGZCYkkwcVBX?=
 =?utf-8?B?Uzd0bWNIVzhwVWJ6YkoxUDk0WWJlUDJnZ3gzd1hTZ3dKWU1pK0lES1Fxdnlv?=
 =?utf-8?B?cU9BNDRsVmFsZlh1dDhERUtPZHpwdThFdzR1SDBlNExqSkdib2svdVIybXZX?=
 =?utf-8?B?WWR2bmY5MFlnRnBmblpuNWNwR1NJcmFBZnJBYmhqUG1WWjNNRkVySjFvN2NZ?=
 =?utf-8?B?TjVyNFVXK3hYRHd6V3Z3N21JbloyNXkzeThUYnJaL2xoZVpEdmNEWkJZelJP?=
 =?utf-8?Q?7/BZqpRdtcoqZT+GiOLjymYpa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 004aebe1-51ac-4963-dfa4-08dc792a6d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 00:10:30.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEX6ZeGviNQjwZurA6glo4P392yGrbCKvtQYDBhDstbW39hRWxPb7xLljojbzhkHJ60AkKyngUldTDWuOjKnfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7554
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAxNywgMjAyNCAyOjQzIFBN
DQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElhbiBS
b2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8
YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
SW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4g
PGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtl
cm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBL
YW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9yLCBQ
ZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFudGhh
LmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY4IDMvN10gcGVyZiBzdGF0OiBGb3JrIGFu
ZCBsYXVuY2ggcGVyZiByZWNvcmQgd2hlbg0KPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJldGly
ZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJpYy4NCj4gDQo+IE9uIFR1ZSwgTWF5IDE0LCAyMDI0
IGF0IDEwOjQ04oCvUE0gPHdlaWxpbi53YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBG
cm9tOiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gV2hlbiBy
ZXRpcmVfbGF0ZW5jeSB2YWx1ZSBpcyB1c2VkIGluIGEgbWV0cmljIGZvcm11bGEsIHBlcmYgc3Rh
dCB3b3VsZCBmb3JrIGENCj4gPiBwZXJmIHJlY29yZCBwcm9jZXNzIHdpdGggIi1lIiBhbmQgIi1X
IiBvcHRpb25zLiBQZXJmIHJlY29yZCB3aWxsIGNvbGxlY3QNCj4gPiByZXF1aXJlZCByZXRpcmVf
bGF0ZW5jeSB2YWx1ZXMgaW4gcGFyYWxsZWwgd2hpbGUgcGVyZiBzdGF0IGlzIGNvbGxlY3RpbmcN
Cj4gPiBjb3VudGluZyB2YWx1ZXMuDQo+ID4NCj4gPiBBdCB0aGUgcG9pbnQgb2YgdGltZSB0aGF0
IHBlcmYgc3RhdCBzdG9wcyBjb3VudGluZywgaXQgd291bGQgc2VuZCBzaWd0ZXJtDQo+IHNpZ25h
bA0KPiA+IHRvIHBlcmYgcmVjb3JkIHByb2Nlc3MgYW5kIHJlY2VpdmluZyBzYW1wbGluZyBkYXRh
IGJhY2sgZnJvbSBwZXJmIHJlY29yZA0KPiBmcm9tIGENCj4gPiBwaXBlLiBQZXJmIHN0YXQgd2ls
bCB0aGVuIHByb2Nlc3MgdGhlIHJlY2VpdmVkIGRhdGEgdG8gZ2V0IHJldGlyZSBsYXRlbmN5IGRh
dGENCj4gPiBhbmQgY2FsY3VsYXRlIG1ldHJpYyByZXN1bHQuDQo+ID4NCj4gPiBBbm90aGVyIHRo
cmVhZCBpcyByZXF1aXJlZCB0byBzeW5jaHJvbml6ZSBiZXR3ZWVuIHBlcmYgc3RhdCBhbmQgcGVy
ZiByZWNvcmQNCj4gPiB3aGVuIHdlIHBhc3MgZGF0YSB0aHJvdWdoIHBpcGUuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+IFJl
dmlld2VkLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+DQo+ID4gLS0tDQo+IFtT
TklQXQ0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYyBiL3Rv
b2xzL3BlcmYvdXRpbC9pbnRlbC10cGVicy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwMDAwMDAuLjRiN2E5ODc5NGZhZQ0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYw0KPiA+IEBAIC0wLDAgKzEsMjg1
IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gPiAr
LyoNCj4gPiArICogaW50ZWxfcHQuYzogSW50ZWwgUHJvY2Vzc29yIFRyYWNlIHN1cHBvcnQNCj4g
PiArICogQ29weXJpZ2h0IChjKSAyMDEzLTIwMTUsIEludGVsIENvcnBvcmF0aW9uLg0KPiANCj4g
VGhpcyBuZWVkcyBzb21lIHVwZGF0ZXMuIDopDQo+IA0KPiANCj4gPiArICovDQo+ID4gKw0KPiA+
ICsNCj4gPiArI2luY2x1ZGUgPHN5cy9wYXJhbS5oPg0KPiA+ICsjaW5jbHVkZSA8c3ViY21kL3J1
bi1jb21tYW5kLmg+DQo+ID4gKyNpbmNsdWRlIDx0aHJlYWQuaD4NCj4gPiArI2luY2x1ZGUgImlu
dGVsLXRwZWJzLmgiDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC96YWxsb2MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ICsjaW5j
bHVkZSAic2FtcGxlLmgiDQo+ID4gKyNpbmNsdWRlICJkZWJ1Zy5oIg0KPiA+ICsjaW5jbHVkZSAi
ZXZsaXN0LmgiDQo+ID4gKyNpbmNsdWRlICJldnNlbC5oIg0KPiA+ICsjaW5jbHVkZSAic2Vzc2lv
bi5oIg0KPiA+ICsjaW5jbHVkZSAidG9vbC5oIg0KPiA+ICsjaW5jbHVkZSAibWV0cmljZ3JvdXAu
aCINCj4gPiArI2luY2x1ZGUgPHN5cy9zdGF0Lmg+DQo+ID4gKyNpbmNsdWRlIDxzeXMvZmlsZS5o
Pg0KPiA+ICsNCj4gPiArDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFBFUkZfREFUQSAgICAgICAgICAg
ICAgIi0iDQo+ID4gKyNkZWZpbmUgQ09OVFJPTCAgICAgICAgICAgICAgICAgICAgICAgICIvdG1w
L2NvbnRyb2wiDQo+ID4gKyNkZWZpbmUgQUNLICAgICAgICAgICAgICAgICAgICAiL3RtcC9hY2si
DQo+ID4gK3B0aHJlYWRfdCByZWFkZXJfdGhyZWFkOw0KPiA+ICtzdHJ1Y3QgY2hpbGRfcHJvY2Vz
cyAqY21kOw0KPiA+ICtzdHJ1Y3QgcGVyZl9zdGF0X2NvbmZpZyAqc3RhdF9jb25maWc7DQo+IA0K
PiBzdGF0aWMgPw0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZ2V0X3BlcmZfcmVjb3JkX2Fy
Z3MoY29uc3QgY2hhciAqKnJlY29yZF9hcmd2KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpbnQgaSA9
IDA7DQo+ID4gKyAgICAgICBzdHJ1Y3QgdHBlYnNfcmV0aXJlX2xhdCAqZTsNCj4gPiArDQo+ID4g
KyAgICAgICBwcl9kZWJ1ZygiUHJlcGFyZSBwZXJmIHJlY29yZCBmb3IgcmV0aXJlX2xhdGVuY3lc
biIpOw0KPiA+ICsNCj4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAicGVyZiI7DQo+ID4g
KyAgICAgICByZWNvcmRfYXJndltpKytdID0gInJlY29yZCI7DQo+ID4gKyAgICAgICByZWNvcmRf
YXJndltpKytdID0gIi1XIjsNCj4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLS1zeW50
aD1ubyI7DQo+IA0KPiBVbmZvcnR1bmF0ZWx5IHRoaXMgc3RpbGwgc3ludGhlc2l6ZXMgTU1BUCBy
ZWNvcmRzIGZvciB0aGUga2VybmVsDQo+IGFuZCBtb2R1bGVzLiAgQXMgd2UgZG9uJ3QgY2FyZSBh
Ym91dCB0aGVtIGFuZCBqdXN0IHdhbnQgdG8NCj4gbWluaW1pemUgdGhlIG92ZXJoZWFkIGF0IHRo
ZSBiZWdpbm5pbmcsIHdlIGNhbiBhZGQNCj4gIi0tdGFpbC1zeW50aGVzaXplIiB0b28uDQoNCkhp
IE5hbWh5dW5nLA0KDQpJJ20gdHJ5aW5nIG91dCB0aGUgIi0tdGFpbC1zeW50aGVzaXplIiBvcHRp
b24gYnV0IGZhaWxlZCB0byBnZXQgaXQgd29yayANCmNvcnJlY3RseS4gQ291bGQgeW91IHBsZWFz
ZSB0YWtlIGEgbG9vayBhdCB0aGlzIGNvbW1hbmQgYW5kIGxldCBtZSANCmtub3cgd2hhdCdzIHRo
ZSBwcm9ibGVtPyANCg0KInBlcmYgcmVjb3JkIC1lIGN5Y2xlczpwIC0tc3ludGg9bm8gLS10YWls
LXN5bnRoZXNpemUgLVcgLWEgLW8gLSBzbGVlcCAxIHwgcGVyZiBzY3JpcHQgLUYgcmV0aXJlX2xh
dCAtaSAtIi4NCg0KSSBnb3QgYW4gZXJyb3IgIjB4NDAgWzB4NDBdOiBmYWlsZWQgdG8gcHJvY2Vz
cyB0eXBlOiA5IiB3aGVuIHJ1biB0aGlzIGNvbW1hbmQuIA0KDQpJZiBJIHJ1biB0aGUgY29tbWFu
ZCBpbiB0d28gc3RlcHMgd2l0aG91dCBwaXBlLCB0aGV5IHdvcmsgZmluZS4gDQoNClRoYW5rcywN
CldlaWxpbg0KDQoNCj4gDQo+IA0KPiA+ICsgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICItLWNv
bnRyb2w9ZmlmbzovdG1wL2NvbnRyb2wsL3RtcC9hY2siOw0KPiANCj4gVGhpcyBoYXJkLWNvZGVk
IHBhdGggd29uJ3Qgd29yayB3ZWxsIHdoZW4gbW9yZSB0aGFuIG9uZSB1c2Vycw0KPiB3YW50IHRv
IHJ1biB0aGUgcGVyZiBjb21tYW5kIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KPiBUaGFua3MsDQo+
IE5hbWh5dW5nDQo+IA0KPiA+ICsNCj4gPiArICAgICAgIGlmIChzdGF0X2NvbmZpZy0+dXNlcl9y
ZXF1ZXN0ZWRfY3B1X2xpc3QpIHsNCj4gPiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsr
XSA9ICItQyI7DQo+ID4gKyAgICAgICAgICAgICAgIHJlY29yZF9hcmd2W2krK10gPSBzdGF0X2Nv
bmZpZy0+dXNlcl9yZXF1ZXN0ZWRfY3B1X2xpc3Q7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgICAgaWYgKHN0YXRfY29uZmlnLT5zeXN0ZW1fd2lkZSkNCj4gPiArICAgICAgICAgICAg
ICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICItYSI7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKCFzdGF0
X2NvbmZpZy0+c3lzdGVtX3dpZGUgJiYgIXN0YXRfY29uZmlnLQ0KPiA+dXNlcl9yZXF1ZXN0ZWRf
Y3B1X2xpc3QpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJfZXJyKCJSZXF1aXJlIC1hIG9yIC1D
IG9wdGlvbiB0byBydW4gc2FtcGxpbmcuXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJu
IC1FQ0FOQ0VMRUQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgbGlzdF9mb3Jf
ZWFjaF9lbnRyeShlLCAmc3RhdF9jb25maWctPnRwZWJzX3Jlc3VsdHMsIG5kKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLWUiOw0KPiA+ICsgICAgICAgICAgICAg
ICByZWNvcmRfYXJndltpKytdID0gZS0+bmFtZTsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4g
KyAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1vIjsNCj4gPiArICAgICAgIHJlY29yZF9hcmd2
W2krK10gPSBQRVJGX0RBVEE7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gK30N
Cj4gPiArDQo+ID4NCg==
