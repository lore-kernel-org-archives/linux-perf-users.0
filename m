Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835BE1B043C;
	Thu,  2 Oct 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419523; cv=fail; b=pwu8c+rDcx9R1OQxCxJvBp7+SvzqH3mQesP3qaNRgUfNRpH+Xs7/3aEfSlp8Tp1hrbkByOnf2eZRiGa4BjAOa9PWXLIUl25g37jqgp7WZH28VtjA9Kd+C6arQDh+5PFv0+1YXrCzeultLnZ0qB9nYnSZ9vR8o4BfdZsoIcbobkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419523; c=relaxed/simple;
	bh=U3RCxW5VPBZUfQHIEJQOY7lDyHtFo4TIt6pJWqldAig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uFd9+K+tOjq5Pca0ywtLs+uE+5sF9L8GEhkQZfggV+7eN79DUItJGOkX9h6oJXCkFyQfDoT9IzxXnm4DUBiv6cxsCyM7DGadiX9JGD+RVq4pafmobqpdrY0SWkb6NPeon03NcqtLbtUaQ3gNFcX3lE/VGa13yGnb1ShmaN3FSYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZoxLVEc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZoxLVEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759419522; x=1790955522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U3RCxW5VPBZUfQHIEJQOY7lDyHtFo4TIt6pJWqldAig=;
  b=cZoxLVEcgqeEQ4784D6NlWEn2r5+7CW04sG81a6gs7PoVaPEG/yfqU/1
   reoIaOVodbA1lZ4v8Zwm2MQf7kHIl5exbFAECN9Vsn7CBP0mmryQ8X/2y
   8CchJogzVx4Eq/Z3jZ0pbpLv0BsoxQ85Fv0BypUPSrS1cMfuSomx/ZbYO
   sWfpha9aaX1B+Yk2pYUqT3XVAknXq9cGBBu+aLkqqV/ayO9SAOW38VpCL
   OMGwKZJtxYba5XSXjm8F5M7/qQ4ZPTh6qr3VWtdYWc4fAR/Rakmz1eg/6
   7pNgat15W3+tiGiODN1uUERJPO2xRaNfKhtRTXqlFoYkAfWmB3jS76cgX
   Q==;
X-CSE-ConnectionGUID: bWaXXJmSRaW7cV2ODITJ3A==
X-CSE-MsgGUID: OHrEn6kYQ6K8oiVg7oEnkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72380492"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="72380492"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 08:38:41 -0700
X-CSE-ConnectionGUID: 94PBY3NqRMqtuwPFMxlYvA==
X-CSE-MsgGUID: sF3Dv7nSSl2I3weCnR2pdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178674916"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 08:38:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 08:38:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 08:38:39 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.37)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 08:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRfGiGOb8Fu8lPAd4rsxFITmbDNM7F0rX1FaehZ/RyHR/uXHdSeZOTHOkufm4zNPiRwqhst7Hk9C+7Iz4ftb0/gNtxBw2uPOv7bDLir8UXwIupRD3QYC+WlWU9xe/C2LaAz3/aK//XrtaHqeuKQpFOAlL2F/pW1m86zcfkBn2uwdZwf6ufYjsAALTor0ixdu6y70z22K9fycBQSJvud1mXav1K7gAEeq47QqcH2ZBNMxGQgbZ9Ec/I9Idqlfjn9dDRClrGkoYsFWKhN1jEomRXemTiVojQr9i2JVeS4zhrakh2Y5vqeYWmjKf3b5CRJl4+cggYShTJq/dvNbHKEpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3RCxW5VPBZUfQHIEJQOY7lDyHtFo4TIt6pJWqldAig=;
 b=HqfMbUmUI2xk1uczN3ZeuNwt/rVl26xxKMaz/dM29yZCsOxufz4UIVDpNp0I8NeHcaztpy3Uuyfo0rrSz03TD8M+KUMJQJT3lLTtnk7Re3bM3FK8YkqOQD5pQQwa2MdzS6ig/Be9fYCdf6sbKwSs4ZHC9UCaJjVQJQqON0cpdyp93ShPm9MutIX96557jIZbI14Zof1NAX9Z+mT9gbHRhQvh4JKzjTP9EXyOAmuKWZSROr/QOKihNggdQeSjJG69l1uA66CjXX8Qn90KlYA2K924f/TKZYK2kuzHZualqrzpzuz08I8pJOtGTApdhqyo18xDvR5/Fejw4Ic7qwMwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:38:30 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 15:38:30 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>
Subject: Re: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
Thread-Topic: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
Thread-Index: AQHcHCh2q4LtoPAB+0mbASO8ar6BLrSrf2oAgAOtdwA=
Date: Thu, 2 Oct 2025 15:38:29 +0000
Message-ID: <cf7ae59b735f004b5c6dd53b82e3d3e2acfad973.camel@intel.com>
References: <20250902164047.64261-1-thomas.falcon@intel.com>
	 <ed463cd8-495e-4769-b392-372413ca7db6@linux.intel.com>
In-Reply-To: <ed463cd8-495e-4769-b392-372413ca7db6@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SN7PR11MB8067:EE_
x-ms-office365-filtering-correlation-id: b56fba4b-c55e-4522-826f-08de01c9bce0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?WWxHYkJUMGhOOU9YT1J3WHVSZDQ5QWQ5TDlEN0Jiek5NL0NMWkczQTV5c3BW?=
 =?utf-8?B?VUV3QzZYMVdCcnhiNC9oQ3BMVHNQRWNkSXBRVnM5Yzl3QnlGVGtIS0dJdXpJ?=
 =?utf-8?B?Q3VsalJjQVR2VW5FWTNHT09sYUhGUnFzWTR2UjIrdDMrVFVwMVVCY1RxbDVJ?=
 =?utf-8?B?bUVvazVPMUdYOHgyenpHSkU1TDVING5oamhPVTdCQXpXa1pvL0xYK1RTa0NQ?=
 =?utf-8?B?OXZHVzAxcEdZTElwMWt2UjkyYnlYMG1XU0tUZXR1QXlBY1YrMUtCdUhreVRD?=
 =?utf-8?B?M1QxMEJYenRlcUxFRitpZVN2WmR5TXJURWFRZk1JUFZKT25yZ2dCK3J0VDVR?=
 =?utf-8?B?alNoWE1zN1c3SlBGK2hCNWJhSSt2ZmxNaEE1dDhPTnA1SDJvZ0pBZHRtZWNS?=
 =?utf-8?B?blU3ZmlDMm9QYjAySlEwdWR1YkxTVmtFaHpkdGpPMDdSb3dlZVg4Z3ZVY3Fr?=
 =?utf-8?B?M0N6dUpWREVVeHNDV3V4ODZoSm9oWWYzWUpmMnJ5cXhIbi9qSVNORUh3L2tr?=
 =?utf-8?B?Q0U2ZVEyQWxTVEtNSm5JY3VXM1doakhsQWZjR2IxRVE0cm1QVzhJN3VlYnp5?=
 =?utf-8?B?NTl2eG1MN0EzTEpJQkFwRE5lQ3VZNmtCeFEyWGx6TE9qVk9wNnRHbFB3V3Ir?=
 =?utf-8?B?RlozNkpWUGQ0dElaY0JjRk8yclg5MTFON3VTdHYwdzZvNmk0TUQ3MmZsdHFW?=
 =?utf-8?B?bGoyWjE5dm9EMjhQdWhDSnh1a1REZzRvQUlRRXlMeHhGVGNGaG9LT0FaVTYx?=
 =?utf-8?B?azBpc3FUbHQ0SHh0eXV3L3lXWEJSZFpRa3FKaUY0dklPN3l1SktTdVlxMms0?=
 =?utf-8?B?RERJUzV4RzZablBzcG1DS3JhWkcxaVBYNFc1WHFVSWZVbEpGbHdVV2pqUzRl?=
 =?utf-8?B?WlFLaFJOSkp1azM5amFkcGFjcmlhVjVHTzVNdnhwNlcrK1BCQTNhT0IxekpM?=
 =?utf-8?B?NFNabERzQ2NpOU1Gdkw5SUs2QmV5b2lwWWRHQ1NjRGhNNjlGOVo2WnFtcEVB?=
 =?utf-8?B?SXh2eHdzTlhxMWVSMHc0NHJJRytIN2VocjhMQ011Yy9jSlRBRHdERUJPTVhH?=
 =?utf-8?B?N1loTTQ0Vk1UWUd4QkNMcmlLaFpIZmZrdG82ZXEyblA1OVJ4Qk5VRlZxRGFt?=
 =?utf-8?B?NW9DcmxUcWd1VlpRSUZPSWtHSHJlN0VwRjZFMXFhbzljZmo5LzM4N0czV0FL?=
 =?utf-8?B?TDdWNmExVjNwTGhXYlBjYk1YaytoMmI4elNLVnZoc2tTcEVRUDgrZzh1ay9H?=
 =?utf-8?B?RFVNdFQyT2dLa0syRHRGMWtNc1VTMyszMkhWUzZ2eDJzMGlHSlUwTVdjNjlq?=
 =?utf-8?B?dTFldjJTaENTaUVIZUptTEMwaWx0OXRZRW8wTE4raVlFTDBpZXRUR2w3R3hS?=
 =?utf-8?B?NjdpT1pSS1BBZnRETGNiNWFDV3hBU29mcFZhY3lic3FST2ZvRE5sbk9ScElP?=
 =?utf-8?B?Y1p4OTlpai9rMFpkK0M5MTdLcG1Vb0tzc2ljTTB6Z0JSTCtsSUE0VHRwT0Zu?=
 =?utf-8?B?NzF3NWRDSEdDSDQrYlNoeGJtdGdEVlhqNGg3aFN4Yi92cE1Nb001OEhCTUZY?=
 =?utf-8?B?NklyUzQwWndEazZHSmdWNnBiZ2ZRaE9ZMVBycHBhVU9aeFhEbE9OTEdpZGh2?=
 =?utf-8?B?dkRIenkzZ3IraDBqY0h0aWdzcGdUZGxrUG1RVlhYOGRJdm1qQTUvbzA1WUFH?=
 =?utf-8?B?VjBLc3ZWMCtJYURXMkNsSjhhTmNnVWJYRzFvTWVKSzBWSjUyRGJoOHlLcnhR?=
 =?utf-8?B?REpRRloyb2cwdU41ODkxOElKZ1pjYzhFUmhkNXgzTHRuNGpXZmJlRVpnbzdx?=
 =?utf-8?B?WUFoRkhCYzlzN3hNYURYR0RkNnQvRkFQLzlwK1ljWGVVa0cyN2F5UGxLeGNY?=
 =?utf-8?B?MzBLby9GeW4xVHc3U1gxRFFDV0htVjR6YlFuaFYxZm1rbVE3ZzIwTGlRd2Nm?=
 =?utf-8?B?czJuQjhCWElLMHhocjROUGkweDVOUnpLQllhUUFBL1RqQjJNRG5qOTFHNG9o?=
 =?utf-8?B?bEZBVHVBc0E0UXZMbVVCWFpyU0FWbGU5dnd4OHNWdTN4QnhNb3BGcjk4MnRC?=
 =?utf-8?B?VzkxbGpDcEsvOFpmY25ndUNibzZzSnNOd0JVUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVU0S0dvWFh3YVY0Nk0wanpmTExKbklONlNjai9KNTRHZmZLMDVsQm8zTjFY?=
 =?utf-8?B?ZlNsT1J1eVUzcDdPN2JoUVlna3dpRkoxMHJaM29ZSkNXaVg3T2JKdU9vNE1P?=
 =?utf-8?B?QW96WEZkNU1JYk9HLzRnZ21mcFFFb1FUOXNVdk4wV1JEUnhGaWx4ejZSb0V1?=
 =?utf-8?B?TlFhemxSN243Vlluc2QvL3VjYW9qc1prdUhlY1RyRytVMkZoRWhYNitFb25R?=
 =?utf-8?B?ZDMrcThvVFZ0TmJNdmNKMVBqdVZjQkdtZTgwVjJsNUo3T0VpMjRNRFN6TmVD?=
 =?utf-8?B?dEtPM00yWnUwRFRwVU5CT2owdVpHQTZZaWo4TEo0aHc5S2RnWVF5TDF1MUZr?=
 =?utf-8?B?amlDZ0ZmRmZaK09YMDMwWXErMnQyOVh4b1E3ZkpjaGtDVWVxSXpiN1krekg2?=
 =?utf-8?B?Tk1BemN2bjRBUlFXd2I0d1UxeHNPOFdwZVVaYzl5Szk1cHA5M3N1VmpKTFY0?=
 =?utf-8?B?OERzSm9vcmgrQ3h3emppdjlGTjNGdHUyNUYwdTBJcElGQUNKbXlnUWIyVTNj?=
 =?utf-8?B?ZW0wZ1NLcFY3cmJaVHEzSTJYZXBDeFM5SWNycWh2aDQxc0ZMLzRuNkRZZlI5?=
 =?utf-8?B?YWRmZWVKeVhkcGxoNVJtQ0g1RjZUUXdYTVo2WEVNNDJ6RVV6aFk1ZUFZejMx?=
 =?utf-8?B?bzM2dmdNSXA4VTAxSWFOMVIxWG5JWEdDcmlOZDQ4N3M1cVl3Q1QrL1J4aTM3?=
 =?utf-8?B?L1YySE1rVXNTV0l4d1pXUVFJM3lZMkdpbjNHemdzaDZFN1Eyc1BqaFc1OTFw?=
 =?utf-8?B?WHEyNlJJaFpwMGpvTHFFcFVvTTZhVUwxMGRPb1puU291NUFEVWVGZWVHT2w0?=
 =?utf-8?B?ejF4NkJYbDdXKzNabVJQdFplMXdGb21MWFZnVTZuYXVSdmlhWHZ3aWE3ejFP?=
 =?utf-8?B?QmpxcFFudWpvRXNUVjM5dldON0drajNHck1XdXZGbkZqb3RVdndvYnFsYzhw?=
 =?utf-8?B?QW5hbGNwSnZEdzhMNlJwQjcvcjE3WnJlTkV1UHE0dE9JK1pDajExQjRpZ2FW?=
 =?utf-8?B?SzNPUVJpMkgwUlVzTEpRQmlRRzZ2RVZxMXRBc2hWYnRNaEdmeDc4RXN4SzB3?=
 =?utf-8?B?ZnpiTTNqWHNQM2RyQmpITTlMOW8vb3hFVmM2UFZIbDhqZENYUEg0RCtlY1Zu?=
 =?utf-8?B?aExudWc4RktORlVRT1pIaEk4UzNJV3lqVXRyRVlYTCt1U3lpYXVna2ZiZzRJ?=
 =?utf-8?B?MHBNRW5uMVVZYWN4UEZtRS9FYi9zMnZLcms2Rkc1SDA2MmpNekNBaWlSNUZp?=
 =?utf-8?B?TUFoUmF5d1FqZXlrTnNZMkc4YkFGa2hXNUo3RVowd2Exc3JlZjVMMndudml2?=
 =?utf-8?B?MFh0VU5lQzRpcGsrcTY1TTk3OS8wb010VlV0R1VacHZUdjUwZ3E1Ykgvcjcx?=
 =?utf-8?B?U2YzSzhzcTVDaGNkc2hIb1RNR3VCbzFhUkF1Qnc1eDA4L3BMZHV1WXB2WHlZ?=
 =?utf-8?B?VVgyZ1ZSVytFN2t2aWZmMXFFSXBOYmNBRDM2OGVoVmNGQ2hPcU5JelpGWTkx?=
 =?utf-8?B?eUNiMFlEbTR4WnhwaUJSc3Bnb3I5V1pGY0NzNXVGcnl6d3IzcXhrZWJwZSt5?=
 =?utf-8?B?aTJuQmZBMFlLL00razE4WUtGQ0pVenM5YkZvY0k5Q3NxV0Ywd09lZ1hsVkw5?=
 =?utf-8?B?WWpyTUlpMnVyRlB0Z1FpejgwRmhhNHY4bFNYVk10TEhwSlp0ekkvVHc5cmwv?=
 =?utf-8?B?Q1pBcU04MnUyd1RjQjFvWDl4aTUyTE13SDJEWWs2OVd0VHFzYjNETWJHUktu?=
 =?utf-8?B?akpiTnN2bURXVzBYYlVwa1o0THBMcDJMRTdCQmR5Qk1Pcm8rYWV5VXJhc2Nw?=
 =?utf-8?B?ZDhyZ1RsRS8zbUx4SjRHamt4eDNnWllyaC8zdXIyYnVIWno1dWRPS0NwUUJL?=
 =?utf-8?B?MmFKVkFlNS9FQnFZbWdYUUpWbjZCTlloYm5VM1Zqcm1YNDQ4L3dxUUoxTkdo?=
 =?utf-8?B?VXF0dWFRbWRuS05DWENrekU2SUVxWjlRT1BxRFdGQVBlRlVZWlRKaEtwNUZY?=
 =?utf-8?B?NjZkTjNFbzVjbE80dTRxU3FiNHU3NnpIL1QzV2t1MUg0QkhaVEQ3aXRicTNo?=
 =?utf-8?B?Kzdna0dyRXZGaUgvWXNIOTBEU0c2QjA1OHQ5NEdxcCthelpGVVFZRDVHYlF3?=
 =?utf-8?B?ZndmanFwN1FNb0FLcEpZSnVUTlBadWs1eitNUEFPNE8wN3MzVUpGYTJTSDA2?=
 =?utf-8?B?Nmt6U09ib1ZXaDRESGYzancwZWJkT0R2UEZucHBGTWpNMkIxL01FSUhvZE1N?=
 =?utf-8?B?dXpnbVVTempMMEk2M3BBUDhKVXR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21C2E1F4B72A1848BD818D427782D72A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56fba4b-c55e-4522-826f-08de01c9bce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 15:38:30.1772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuObTXAGWIYT1kcBccrgLRi+8VM0dDt7xXjto6krh9ERg5uNwr79D5riE6sdsoYpfvEpyt5orT/HUaoMRIFu+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA5LTMwIGF0IDE1OjI4ICswODAwLCBNaSwgRGFwZW5nIHdyb3RlOg0KPiAN
Cj4gT24gOS8zLzIwMjUgMTI6NDAgQU0sIFRob21hcyBGYWxjb24gd3JvdGU6DQo+ID4gVGhlIEF1
dG8gQ291bnRlciBSZWxvYWQgKEFDUilbMV0gZmVhdHVyZSBpcyB1c2VkIHRvIHRyYWNrIHRoZQ0K
PiA+IHJlbGF0aXZlIHJhdGVzIG9mIHR3byBvciBtb3JlIHBlcmYgZXZlbnRzLCBvbmx5IHNhbXBs
aW5nDQo+ID4gd2hlbiBhIGdpdmVuIHRocmVzaG9sZCBpcyBleGNlZWRlZC4gVGhpcyBoZWxwcyBy
ZWR1Y2Ugb3ZlcmhlYWQNCj4gPiBhbmQgdW5uZWNlc3Nhcnkgc2FtcGxlcy4gSG93ZXZlciwgZW5h
YmxpbmcgdGhpcyBmZWF0dXJlDQo+ID4gY3VycmVudGx5IHJlcXVpcmVzIHNldHRpbmcgdHdvIHBh
cmFtZXRlcnM6DQo+ID4gDQo+ID4gwqAtLSBFdmVudCBzYW1wbGluZyBwZXJpb2QgKCJwZXJpb2Qi
KQ0KPiA+IMKgLS0gYWNyX21hc2ssIHdoaWNoIGRldGVybWluZXMgd2hpY2ggZXZlbnRzIGdldCBy
ZWxvYWRlZA0KPiA+IMKgwqDCoCB3aGVuIHRoZSBzYW1wbGUgcGVyaW9kIGlzIHJlYWNoZWQuDQo+
ID4gDQo+ID4gRm9yIGV4YW1wbGUsIGluIHRoZSBmb2xsb3dpbmcgY29tbWFuZDoNCj4gPiANCj4g
PiBwZXJmIHJlY29yZCAtZSAie2NwdV9hdG9tL2JyYW5jaC1taXNzZXMscGVyaW9kPTIwMDAwMCxc
DQo+ID4gYWNyX21hc2s9MHgyL3BwdSxjcHVfYXRvbS9icmFuY2gtaW5zdHJ1Y3Rpb25zLHBlcmlv
ZD0xMDAwMDAwLFwNCj4gPiBhY3JfbWFzaz0weDMvdX0iIC0tIC4vbWlzcHJlZGljdA0KPiA+IA0K
PiA+IFRoZSBnb2FsIGlzIHRvIGxpbWl0IGV2ZW50IHNhbXBsaW5nIHRvIGNhc2VzIHdoZW4gdGhl
DQo+ID4gYnJhbmNoIG1pc3MgcmF0ZSBleGNlZWRzIDIwJS4gSWYgdGhlIGJyYW5jaCBpbnN0cnVj
dGlvbnMNCj4gPiBzYW1wbGUgcGVyaW9kIGlzIGV4Y2VlZGVkIGZpcnN0LCBib3RoIGV2ZW50cyBh
cmUgcmVsb2FkZWQuDQo+ID4gSWYgYnJhbmNoIG1pc3NlcyBleGNlZWQgdGhlaXIgdGhyZXNob2xk
IGZpcnN0LCBvbmx5IHRoZQ0KPiA+IHNlY29uZCBjb3VudGVyIGlzIHJlbG9hZGVkLCBhbmQgYSBz
YW1wbGUgaXMgdGFrZW4uDQo+ID4gDQo+ID4gVG8gc2ltcGxpZnkgdGhpcywgcHJvdmlkZSBhIG5l
dyDigJxyYXRpby10by1wcmV24oCdIGV2ZW50IHRlcm0NCj4gPiB0aGF0IHdvcmtzIGFsb25nc2lk
ZSB0aGUgcGVyaW9kIGV2ZW50IG9wdGlvbiBvciAtYyBvcHRpb24uDQo+ID4gVGhpcyB3b3VsZCBh
bGxvdyB1c2VycyB0byBzcGVjaWZ5IHRoZSBkZXNpcmVkIHJlbGF0aXZlIHJhdGUNCj4gPiBiZXR3
ZWVuIGV2ZW50cyBhcyBhIHJhdGlvLCBtYWtpbmcgY29uZmlndXJhdGlvbiBtb3JlIGludHVpdGl2
ZS4NCj4gPiANCj4gPiBXaXRoIHRoaXMgZW5oYW5jZW1lbnQsIHRoZSBlcXVpdmFsZW50IGNvbW1h
bmQgd291bGQgYmU6DQo+ID4gDQo+ID4gcGVyZiByZWNvcmQgLWUgIntjcHVfYXRvbS9icmFuY2gt
bWlzc2VzL3BwdSxcDQo+ID4gY3B1X2F0b20vYnJhbmNoLWluc3RydWN0aW9ucyxwZXJpb2Q9MTAw
MDAwMCxyYXRpb190b19wcmV2PTUvdX0iIFwNCj4gPiAtLSAuL21pc3ByZWRpY3QNCj4gDQo+IEhp
IFRvbSwNCj4gDQo+IERvZXMgdGhpcyAicmF0aW8tdG8tcHJldiIgb3B0aW9uIHN1cHBvcnQgMyBh
bmQgbW9yZSBldmVudHMgaW4gQUNSDQo+IGdyb3VwPw0KPiANCg0KSGkgRGFwZW5nLA0KDQpUaGUg
J3JhdGlvLXRvLXByZXYnIG9wdGlvbiBvbmx5IHN1cHBvcnRzIGdyb3VwcyB3aXRoIHR3byBldmVu
dHMgYXQgdGhpcw0KdGltZS4gRm9yIGxhcmdlciBldmVudCBncm91cHMsIHRoZSAiYWNyX21hc2si
IHRlcm0gaXMgYXZhaWxhYmxlLg0KDQo+IElmIG5vdCwgc2hvdWxkIHdlIGNvbnNpZGVyIHRvIHN1
cHBvcnQgdGhlIGNhc2VzIHRoZXJlIGFyZSAzIGFuZCBtb3JlDQo+IGV2ZW50cw0KPiBpbiB0aGUg
QUNSIGdyb3VwPyAoSWYgSSByZW1lbWJlciBjb3JyZWN0LCB0aGUgUE1VIGRyaXZlciBzaG91bGQN
Cj4gc3VwcG9ydCBpdCkuDQo+IA0KDQpDb3JyZWN0Lg0KDQo+IGUuZy4sDQo+IA0KPiBwZXJmIHJl
Y29yZCAtZQ0KPiAie2NwdV9hdG9tL2JyYW5jaC0NCj4gbWlzc2VzLHBlcmlvZD0yMDAwMDAsYWNy
X21hc2s9MHg2L3AsY3B1X2F0b20vYnJhbmNoZXMscGVyaW9kPTEwMDAwMDAsDQo+IGFjcl9tYXNr
PTB4Ny8sY3B1X2F0b20vYnJhbmNoZXMscGVyaW9kPTEwMDAwMDAsYWNyX21hc2s9MHg3L30iDQo+
IC0tIHNsZWVwIDENCj4gDQo+IE9mIGNvdXJzZSwgdGhpcyBpcyBqdXN0IGFuIGV4YW1wbGUgdGhh
dCBpbmRpY2F0ZXMgdGhlIGNhc2VzIGFyZQ0KPiBzdXBwb3J0ZWQsDQo+IGl0IGRvZXNuJ3QgbWVh
biB0aGUgY29tbWFuZCBpcyBtZWFuaW5nZnVsLiBCdXQgd2UgY2FuJ3QgZXhjbHVkZSB0aGF0DQo+
IHVzZXJzDQo+IGhhdmUgc3VjaCByZWFsIHJlcXVpcmVtZW50cy4NCj4gDQo+IElmIHdlIHdhbnQg
dG8gc3VwcG9ydCAzIGFuZCBtb3JlIGV2ZW50cyBpbiBBQ1IgZ3JvdXAgKGlmIG5vdA0KPiBhbHJl
YWR5KSwgd2UnZA0KPiBiZXR0ZXIgcmVuYW1lIHRoZSAicmF0aW8tdG8tcHJldiIgb3B0aW9uIHRv
ICJyYXRpby10by1oZWFkIiBhbmQgb25seQ0KPiBhbGxvdw0KPiB0aGUgZ3JvdXAgbGVhZGVyIGNh
biBiZSBzZXQgdGhlIHNhbXBsaW5nIHBlcmlvZMKgZXhwbGljaXRseSB3aXRoDQo+ICJwZXJpb2Qi
DQo+IG9wdGlvbiBhbmQgdGhlIHNhbXBsaW5nIHBlcmlvZCBvZiBhbGwgb3RoZXIgZ3JvdXAgbWVt
YmVycyBjYW4gb25seSBiZQ0KPiBjYWxjdWxhdGVkIGJhc2Ugb24gdGhlIHNhbXBsaW5nIHBlcmlv
ZCBvZiBncm91cCBsZWFkZXIgYW5kDQo+IHRoZcKgInJhdGlvLXRvLWhlYWQiLCBtYXliZSBsaWtl
IHRoaXMuDQo+IA0KPiBwZXJmIHJlY29yZCAtZQ0KPiAie2NwdV9hdG9tL2JyYW5jaC1taXNzZXMs
cGVyaW9kPTIwMDAwMC9wLGNwdV9hdG9tL2JyYW5jaGVzLHJhdGlvLXRvLQ0KPiBoZWFkPTUvLGNw
dV9hdG9tL2JyYW5jaGVzLHJhdGlvLXRvLWhlYWQ9NS99Ig0KPiAtLSBzbGVlcCAxDQo+IA0KPiBU
aGFua3MuDQo+IA0KPiANCg0KVGhhbmtzLCB0aG9zZSBhcmUgZ29vZCBzdWdnZXN0aW9ucywgYnV0
IHRoZSBnb2FsIG9mIHRoZSBmZWF0dXJlIHdhcyB0bw0KcHJvdmlkZSB1c2VycyBhIHdheSB0byB1
dGlsaXplIEFDUiB0byBtYWtlIHNpbXBsZSBjb21wYXJpc29ucyB3aXRob3V0DQpuZWVkaW5nIHRv
IHVzZSB0aGUgImFjcl9tYXNrIiBmaWVsZC4gRm9yIHRlc3RzIGNvbXBhcmluZyBsYXJnZXIgZXZl
bnQNCmdyb3VwcywgdGhlIGFjcl9tYXNrIGZpZWxkIG1heSBiZSB1c2VkIGluc3RlYWQuDQoNClRo
YW5rcywNClRvbQ0KDQo+ID4gDQo+ID4gb3INCj4gPiANCj4gPiBwZXJmIHJlY29yZCAtZSAie2Nw
dV9hdG9tL2JyYW5jaC1taXNzZXMvcHB1LFwNCj4gPiBjcHVfYXRvbS9icmFuY2gtaW5zdHJ1Y3Rp
b25zLHJhdGlvLXRvLXByZXY9NS91fSIgLWMgMTAwMDAwMCBcDQo+ID4gLS0gLi9taXNwcmVkaWN0
DQo+ID4gDQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDMy
NzE5NTIxNy4yNjgzNjE5LTEta2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbS8NCj4gPiANCj4gPiBD
aGFuZ2VzIGluIHYyIChtb3N0bHkgc3VnZ2VzdGVkIGJ5IElhbiBSb2dlcnMpOg0KPiA+IA0KPiA+
IC0tIEFkZCBkb2N1bWVudGF0aW9uIGV4cGxhaW5pbmcgYWNyX21hc2sgYml0bWFzayB1c2VkIGJ5
IEFDUg0KPiA+IC0tIE1vdmUgQUNSIHNwZWNpZmljIGltcGxlbWVudGF0aW9uIHRvIGFyY2gveDg2
Lw0KPiA+IC0tIFByb3ZpZGUgdGVzdCBjYXNlcyBmb3IgZXZlbnQgcGFyc2luZyBhbmQgcGVyZiBy
ZWNvcmQgdGVzdHMNCj4gPiANCj4gPiBUaG9tYXMgRmFsY29uICgyKToNCj4gPiDCoCBwZXJmIHJl
Y29yZDogQWRkIHJhdGlvLXRvLXByZXYgdGVybQ0KPiA+IMKgIHBlcmYgcmVjb3JkOiBhZGQgYXV0
byBjb3VudGVyIHJlbG9hZCBwYXJzZSBhbmQgcmVncmVzc2lvbiB0ZXN0cw0KPiA+IA0KPiA+IMKg
dG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL2ludGVsLWFjci50eHQgfCA1MyArKysrKysrKysrKysr
KysrKysNCj4gPiDCoHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLWxpc3QudHh0IHzCoCAy
ICsNCj4gPiDCoHRvb2xzL3BlcmYvYXJjaC94ODYvdXRpbC9ldnNlbC5jwqDCoMKgwqDCoMKgIHwg
NTMgKysrKysrKysrKysrKysrKysrDQo+ID4gwqB0b29scy9wZXJmL3Rlc3RzL3BhcnNlLWV2ZW50
cy5jwqDCoMKgwqDCoMKgwqAgfCA1NCArKysrKysrKysrKysrKysrKysNCj4gPiDCoHRvb2xzL3Bl
cmYvdGVzdHMvc2hlbGwvcmVjb3JkLnNowqDCoMKgwqDCoMKgIHwgNDAgKysrKysrKysrKysrKysN
Cj4gPiDCoHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgNzYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgdG9vbHMvcGVy
Zi91dGlsL2V2c2VsLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+
IMKgdG9vbHMvcGVyZi91dGlsL2V2c2VsX2NvbmZpZy5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMSAr
DQo+ID4gwqB0b29scy9wZXJmL3V0aWwvcGFyc2UtZXZlbnRzLmPCoMKgwqDCoMKgwqDCoMKgIHwg
MjIgKysrKysrKysNCj4gPiDCoHRvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVudHMuaMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDMgKy0NCj4gPiDCoHRvb2xzL3BlcmYvdXRpbC9wYXJzZS1ldmVudHMubMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+IMKgdG9vbHMvcGVyZi91dGlsL3BtdS5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLQ0KPiA+IMKgMTIgZmlsZXMgY2hh
bmdlZCwgMzA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gwqBjcmVhdGUgbW9k
ZSAxMDA2NDQgdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL2ludGVsLWFjci50eHQNCj4gPiANCg0K
