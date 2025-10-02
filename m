Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7468C148;
	Thu,  2 Oct 2025 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759442280; cv=fail; b=Fc8qNYwn0fspgi68mRouy4arVqjH4nuotJlvH4p0e6M3mvteYo4iNvxhsfAgI2Asta39bKCey9smgYDbTvhYvzEGuQCNzCwkJojSMslygH20/BQlaU3qeBvwIlNXxK4QyN6JlblyHLVFW6rsOHdSj1ToX9yPj34CaB0ZXoIj8Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759442280; c=relaxed/simple;
	bh=ewX5lm0WiwGLUkNdOPnPNy8+jOF8ljEsaCHBGT2TD08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KNDPuhomuB8br+Ea7vUV51uS7MB3vPmsjJMFg5lLf0KPjyGObRZur6mUcplwH2OZBk3FYfGP8CyIl1POa9Wd/oW/lYMdiFVJ8sWt9flEU8Kw+/IpV4J5G5BFu7vDeAX6jF+Dmho7hLTKH5lCVbPphGVEJG89C2tqDU7dJZbQ4Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+mmkuFC; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+mmkuFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759442279; x=1790978279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ewX5lm0WiwGLUkNdOPnPNy8+jOF8ljEsaCHBGT2TD08=;
  b=m+mmkuFCXM8y6gH8sTiaBbYxeYNHi07uGpfW9P2bW9Sz/2hbzuXV81Na
   9R14rw4IIwJolzt0EQn+HMNbZX1WGfv3CJPZYZ5MmhtcFCXnPvn0scBBz
   /PWnvIy/GnJGhAVjv7oLaDzAeu6jj1EEEUgcptSQUeDiUN3ozllCaPvV4
   51/vw8LJZzm/OFkEMMnKoIYH20L4JlvuUpeqHNEJKaXpMORPGA7IFnG4q
   ZFy6L2WYEYbtg6emDfuqe/zY5BJ0NLXoP7Y+W3odv+U40tegJRavOqhcD
   ZpzZkzDPSDzC1zzLXiYIiGp5J+UePiJrAHglE85qo4wh6mmD4U0U4IvmQ
   A==;
X-CSE-ConnectionGUID: r02PUb2kRXWQyOZruB5d/A==
X-CSE-MsgGUID: BSOgGfdTQNCzzMRH1dQl8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61621880"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="61621880"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 14:57:59 -0700
X-CSE-ConnectionGUID: PkrxKWDoS0SABQZUn8IZlA==
X-CSE-MsgGUID: iZRBKOcOQ4SsBZ8nQxzYQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; 
   d="scan'208";a="183549131"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 14:57:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 14:57:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 14:57:57 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 14:57:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9DyiDC41CojQdjYfFb/S1FM9jUXq2kc8MXoIHxURfK/8uI3dYxkNTLmpGuz+ePCw0SMed3yjrxYi6AdtF0nWfVjFSb0lXhFy3w46VrVQeLQDtNOk/s33n62Hc3j85Y8xFSO9X87QQk/qNEQYTD6tkIfHKF3n5W556WSBrTHXQYX8HNWiLNAH+g2qeailSe30rdo6t6d6tbYmdzzPFaeA4aE/uU2E3Q0gwKTyyzD3FBax0iZvpGx4NwN6zJ44u0JSgonUQVlTTMRCYCP96SeRNUhAC70k0K7hqGDk+wS+EKS6loDMV5JT5pK+uhB6kwOTYT+y/G2Uf9QgCtgbAGbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewX5lm0WiwGLUkNdOPnPNy8+jOF8ljEsaCHBGT2TD08=;
 b=RqemY25mGxXFj5eCUSxxs4YUHx6Hrj2065C+FJTwfsegUK3op7zueqEvGspfxR7IZnAs9rfcuErka7TdPaglYVGH2gkFbYpUG/zGQdvTpEJy6//XUSMCd9pIaSczqBqXIAa88wa/zrNV2YIMx/Q3vWiFGIeXRSaBNF22fepDfiyePwzScddpye5EpBAicZ4gjbO7PKngizKuviyOLZv6pRxM2XiPfEMqrb8p2lsU43jrAhJOPJrItEPabgPV9w6T+/q3IHEUVGAztkaQeAHxhGYtwPkJSelHbcf9F1bEY8UKP8WVPDr/wXEknYrXYnXxaxaveP8VE4UMeva+zYQUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 21:57:49 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 21:57:49 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "acme@kernel.org" <acme@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>
Subject: Re: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
Thread-Topic: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
Thread-Index: AQHcHCh2q4LtoPAB+0mbASO8ar6BLrSvbzSAgAAnqQA=
Date: Thu, 2 Oct 2025 21:57:49 +0000
Message-ID: <b6d4e04f5ce50aa1ce13fcbdb2d8c5ed15b706d1.camel@intel.com>
References: <20250902164047.64261-1-thomas.falcon@intel.com>
	 <aN7UF0MwmQnzk72W@x1>
In-Reply-To: <aN7UF0MwmQnzk72W@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA0PR11MB4685:EE_
x-ms-office365-filtering-correlation-id: 2a9bd314-ea98-4d51-bf42-08de01feba81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RTROZkZ2U243NVM0U3FNdDcyenVZRkRpUGpnOHhuL0xFVkdqM3U5czdobXZC?=
 =?utf-8?B?eWFxblN6Q0JaSkVJalFnNmZkUzZ0S2ZvU0lYdTducTViZnJoek1RTHB4Y1g3?=
 =?utf-8?B?dy9nWTZjRGUvZGhVV1U4Sll1ZTdJQS8rQ1ZzQWN6TlIzYlFVRUQxd1ozKzJq?=
 =?utf-8?B?Q05VOSt0amRySlJpVFhkU01ieEQxaDVocFp5UG1YSGN1YXk2OEl3Ui9iUFNF?=
 =?utf-8?B?WWxRNjlOQm5sL2NKeTgyeEhEQkJoSGNoK1Zvazg4T2M3dDdRdkhvcGhHbWNS?=
 =?utf-8?B?cUc4dnlld0NYM1Nua3hFMGpxMFd0NmJLYXg0TUxtaFFZQ1BHS2llTHhnUENB?=
 =?utf-8?B?T1ZLWWcxV0dtNGROZ3ZaUWFoeWpJN0l3MElmZ3VaWHI4ZzlLUVEyRCtGY3lv?=
 =?utf-8?B?dlg1MWdvaHVvZFFsc09jNG5iMU5PTzlYN25QZ3lqR0o5OTNzMEhjME9kNGdn?=
 =?utf-8?B?SHdzU3ZTcXBWcktlUEE3Vmd6OXZtVGpZaVVQTUd5QWN6TS8yZk1rbmM0VHFS?=
 =?utf-8?B?MmhQT0pydWVLR1lOK1JIMktETlgwNWF3eGtGQTUwdWlXdFVINERZSTJlNC81?=
 =?utf-8?B?dm0vQUZiNStVTTNCM1RxUHFJQlgyR0xtYnNLdUlqczAzYnBLUWo1SmtxcEFG?=
 =?utf-8?B?NmpGQW9xOS8yTE1DeEo3K2JienZ6di95MFhkSE8ybHVwQkJpM09Fa2NLS3Bu?=
 =?utf-8?B?V1hlNXcxazVKS0tMZDdHSEFjNXpncEtpVDVWd09GYk4xV2RBV0xqL3lDbjRa?=
 =?utf-8?B?elU3VDdQZUl1UHI2MGp6OUNSYk1RV0ZQblhzMjNIc0FHT2pHdWZwcHpVWUd3?=
 =?utf-8?B?RDg1c0NoU1ViajhlL1NzY091RTBkUnAwazJCcnV2b2syNm9Rb2ZVSldySmhF?=
 =?utf-8?B?aEdjbWR3RjhkY2I3SVdQZnJFcWFZaWdNNlV6SG9ZdWdhL1BzZE51dTNNNG5I?=
 =?utf-8?B?ZmV0TUZad1BZTXlEMmIvL1p4dFZvQUhKVndQUDMwRWEveUxjU0lPMWd4ZE9v?=
 =?utf-8?B?YituRzhQSlNoays5dGk5NnF0TDVHK0tGeUpkV1Z5bUJoVDVUQ1A5WVZCaVV4?=
 =?utf-8?B?U2RmaDhoc3daQ0Vka01pYkFWcEx6anQ0WTdSTE1mdnpjZzRaV1RKak56eWx6?=
 =?utf-8?B?ZHA2RENISjAvUjF1bXp3YXd1cUtER2hlYW5nUDFPN3R1NUw2SUJJelFJK1pt?=
 =?utf-8?B?L29Bb0JkVWRtdmZMMnBjUitCY0ZBK3p5SVN0cGFvbXhPRWVKRGorUGl2MVBu?=
 =?utf-8?B?V1EraDNJRUJ0TVZQL1dqVkFYOE51ZjBPTm1keGQ4OE5nSTY3RFk2SGlRQ05X?=
 =?utf-8?B?eEJFaGRJalVIaUVObTlISUhZOW9ZdjNFSExvZStNUXY0UEVHSUo0aG1DWWNR?=
 =?utf-8?B?L2w0SW9xRDJIZFNtblZIazhsZ1laYTZzTVMvVjZTS2pKOVQ1NDFwNkZkNVpT?=
 =?utf-8?B?bHBucmZKdnArblZkdHovZTVYanFJYU5VRmU1WGtVYmVra25oSzcwRVU1bXZu?=
 =?utf-8?B?eDdZSHA1WkF6cjl2cnB5UGxBOGRSN1hVRUlVMURhMnRyQUp0cVNlVnlGSTc3?=
 =?utf-8?B?elBkOExrMmFIcURuQWZ3NHhOZUhIVHUwRWxLQm1UbXBIbjg0MTlXbGdFSUxr?=
 =?utf-8?B?Umt6V3lWVHZBQkF3NDBQOFVtRGxTa0dSSHRLemU0RytKSW85SEZpRnBvaWRi?=
 =?utf-8?B?Z0VBZ3g3WGlhY3BxQ3FhNm41bjBqN25XUVplTkRKQzQ2UWYyNGxRbVVTZHM5?=
 =?utf-8?B?bnNEZ29MY3ZuanZHU0tNS1dkVmQ4ZGZLNHJ6azRhdDN1TGh6cm5IZmtPYUpu?=
 =?utf-8?B?ZkR4d1VUWjJ0YnVPeHRUck0yWVc3WDk0bUNxSnBVKzhLaUJaNGF2R0ZEd1Qx?=
 =?utf-8?B?Vno2UTFQa1cxaFJaY2U2QVF4VDBvTjlVRGtKYTBRclBlVlI0dHNUVlJuNjJ5?=
 =?utf-8?B?NnY1bEFpYUwyZmRHdkFDREcvZ1dRMW9ROGs4RUZrbkFBZG9qMHg0d095U0I5?=
 =?utf-8?B?dDZtSnlkNXBtbG5rVlAvUXFWUUFHeHRiMWpEM1RYeTNwZFlkVTVLYUQrVmNB?=
 =?utf-8?Q?iUg60J?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3RlYWE5eGV4L3ZVdlBBOXVkZlFYQTRjcGpWK0tyeGR2L2tjQ1Zmejh0c0ZD?=
 =?utf-8?B?R3liekxOd25ISGs4RWE0eDFLVkFQOXg5YmRsZ2NObWd2R0ptSmg1amtkdzlI?=
 =?utf-8?B?K01sd2dwY1VtMFZIYzlIbjIrMDgxb0xod2o2NU50Q2EraHlxKy9wbjB5TGxX?=
 =?utf-8?B?ODYrZW5zM3ZJVHR6dmZZcGV4TEdtTXpUY2VMV25EaFRYMG02M1liVHQxRHNC?=
 =?utf-8?B?NWFVYy9TMWZFSjM3am56eGZpUWowU2xaa1ZEOGpIdkZ2Q1VTLzhGUVg4bmhm?=
 =?utf-8?B?ZUh1Zyt2aXpVTlRlcFJlUllPNVhUZEIrakMwQmRTdGJJd1JhOHlMZmF3bWg2?=
 =?utf-8?B?YVRHZFNuaEFWWUxWdHBuRFkwK0xzMmtqbFNDKzVaaEJ2N21ZVlFpZWxxZlZH?=
 =?utf-8?B?QWI2VCtZWDRrNUFUSlZUNVo2anZ3MVh6NVpRZnFvcnI4c1ppN0ZEamV6RFZq?=
 =?utf-8?B?eTRDSm8rUEZhc2M2dTJXVWQrcE15TUFlRmU0TERDNGVBMHJwdHNFUWdLSHZQ?=
 =?utf-8?B?MmZHc0xmSUVFU00zNjhhZmsvZWg5ZytiTnZNNWw5T0tScUdPRDNnRnU0MVlZ?=
 =?utf-8?B?SFNYUzRrR0JYL3ErSm5lbDJzSGdDWWFKaFh5TDdVOE03K1d4NzlWdUplVitD?=
 =?utf-8?B?cEVDeW9vSkQyYVZtNXVTM29tb0NQZ0RlT1ZrOWc5aFRzdDFsMUlYQjQxQ3VC?=
 =?utf-8?B?M0VFd2dsZnRaZVUzckh6dDFxUWxEQm5MYmUyK1RFVERPNythc3pqT2xINnU0?=
 =?utf-8?B?ZldFUWZFcGxpbzUyRE5jdE96NGVQMHdORG0zemtyZWsxanIzSC84OXFqVGI3?=
 =?utf-8?B?WUtDWU82dUpTSWNEeXFEcjBvM3hTU3NQckU3VlNVMHRmUlU1emNSdTdzSExY?=
 =?utf-8?B?Z2FGN2tqWE91dHBMekxtZlA3OUdEcUw5aXV6U3lHVG1EckVCdXBGQmRzRTlQ?=
 =?utf-8?B?SXBvaExDZ0laNkIrL2lpOXJibEN2OUdobmFhYUh4UUp0dGlhOEVzeXZmbld3?=
 =?utf-8?B?aXQ0eC80eTZMZG82eTJFK0lObkVKZlk5S0ZqRzYzVG9sOU8wUE05cGFRNVJS?=
 =?utf-8?B?UkJWbFZ2elNETE82clRoMUZsMWxveHdrZmRlM3NOZ2VIV2xrbXo3OFRua1pU?=
 =?utf-8?B?UElJVlIrUUtuejM0RjNra1VIWkpndDBGV04zQlg0dDJQc3YzNERNR1lneGRL?=
 =?utf-8?B?MEFOVXcySXhVRVkxeGc0SDEzdUd5SW9ObkRXVFhtM1Rrb1g0VE0yNzNlV2ZY?=
 =?utf-8?B?eTlPeU8rVE1aL0xmWkNHMTlLTlpKSzRPamxqbVRWTFFITVBBRDZld08zcmhB?=
 =?utf-8?B?WEVCMkZDa3VUYUpZTFl0R1RWRGVOZXZndXcwWm9zRUlhL2xSVXBHaDkyNnhi?=
 =?utf-8?B?WnhzcUdoeC91eG93MTF1ZE9zb25lVVo0Y2hWYVE2ZUJ2TUYybFpvM3d6VjJr?=
 =?utf-8?B?MmVCT1RGVWd3MGZSY095MzRoV2FacmVaaTBIQkhSZjNDOEJhUHRCbXByYnhK?=
 =?utf-8?B?a0E4Qms2cGhRM0J6d0t3RnBIaDhmUkw0WU5HMjZSSUQxWURNL2pzWnhlK0Zl?=
 =?utf-8?B?UlE5amdhenl1bkMwWi9iY1JFZlJad0toUmdCNHFaME5GOGtGUGF6dHR6dnFz?=
 =?utf-8?B?WVRtRFc5OUs3MXM1QnYyTVMwRE93dWtvQ1dNcE1abG5RZWc3bkw1NHF3d3ZK?=
 =?utf-8?B?STAxdWJURnh3NFVwVzJ1aDRjSzhHdFcxbGhsa25LV3JCYkNnQnkwQndWajVN?=
 =?utf-8?B?Z2thS3lMRGZNdHV1T0ppQ2pqeEpub0MvSXlOZWhUQi83TFZjM3hHR2s5WVJQ?=
 =?utf-8?B?ZENpN1hKV1F1amZFV2QxWmdCUmkyMmxzWFpMdUcrK3hjbjFOcExJV202aVRy?=
 =?utf-8?B?cVpmS0J6MU9aalpGaCtNcmpWd0tiQklDZUIvUWJvb1pvLzBRU0VDbTlKQzBQ?=
 =?utf-8?B?Qno1WVBad2p3djE2UlhGV2RsSGJVS0Z1eER4Rm04ODVHKzhiYUZ4SzhHMjZZ?=
 =?utf-8?B?KzExUmEvckd6RU9sNlRVTitEUXN3S2RwRk85QTdyRk9PTjVzZ0lTSVc4WkUw?=
 =?utf-8?B?cFJlTXhENEt3RzZDZHZ0YmpGVFQ3Yml4aUdqYmlVeGIvSzVYNnpBRzlpZ2o5?=
 =?utf-8?B?djZxMmJVYWF1azdCKzdEYUJHWEdWR3RmTGQzaWdib1VrWFV2L2tzZ2l5NTVO?=
 =?utf-8?B?cUIwOGZFZlpKd2Z5aUxyMnRZZVRuaElGNUcrYmg4U3JrUy9sL0VRZ243V1V6?=
 =?utf-8?B?dXYrczJMZml5OUF4VzUwbmpxNyt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <796D91E0BE7C4F428D2C33C6D75AF428@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9bd314-ea98-4d51-bf42-08de01feba81
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 21:57:49.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLYVfp6rTemDtJNkMfaNFE9Eyp84/kcV51Q22CxOvYgAKAffj7aRO11CxmQSj0lDAj8zghZpMcfcTat7OaPVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTEwLTAyIGF0IDE2OjM1IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDAyLCAyMDI1IGF0IDExOjQwOjQ0QU0gLTA1MDAsIFRo
b21hcyBGYWxjb24gd3JvdGU6DQo+ID4gVGhlIEF1dG8gQ291bnRlciBSZWxvYWQgKEFDUilbMV0g
ZmVhdHVyZSBpcyB1c2VkIHRvIHRyYWNrIHRoZQ0KPiA+IHJlbGF0aXZlIHJhdGVzIG9mIHR3byBv
ciBtb3JlIHBlcmYgZXZlbnRzLCBvbmx5IHNhbXBsaW5nDQo+ID4gd2hlbiBhIGdpdmVuIHRocmVz
aG9sZCBpcyBleGNlZWRlZC4gVGhpcyBoZWxwcyByZWR1Y2Ugb3ZlcmhlYWQNCj4gPiBhbmQgdW5u
ZWNlc3Nhcnkgc2FtcGxlcy4gSG93ZXZlciwgZW5hYmxpbmcgdGhpcyBmZWF0dXJlDQo+ID4gY3Vy
cmVudGx5IHJlcXVpcmVzIHNldHRpbmcgdHdvIHBhcmFtZXRlcnM6DQo+IA0KPiBDYW4geW91IHBs
ZWFzZSB0cnkgdG8gcmViYXNlIHRvIHdoYXQgaXMgaW4gdG1wLnBlcmYtdG9vbHMtbmV4dCBub3c/
DQoNCk9rLCBJIHdpbGwgc2VuZCBpdCBBU0FQLg0KDQp0aGFua3MsDQoNClRvbQ0KDQo+IA0KPiAt
IEFybmFsZG8NCg0K
