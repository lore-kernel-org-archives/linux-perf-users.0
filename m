Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D821E13D2A4;
	Tue,  8 Oct 2024 06:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367695; cv=fail; b=nFldkXvM6wP77LYEbQ8wtmR97+T9KHND67tsKdAy/v+8vl+Y11L+/kZ9lu2gbSrFvpXSJiN84IP0ErYH7vovcmiOul7TLoqXmo401APP1wkwfPEDzpLoIQqszsve4X+67DPXc9Us6gaSp2nupU7L8OeB8MfiY13WUH26cXQ8cB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367695; c=relaxed/simple;
	bh=j0vI5bAGtRsWGOThwCsWocLWheBVo2Ga1fFu9BfWGVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k/n864t7kYTTAl9TABucj1v98FLnBZJP1lxMxTyeiGYIDTs7OotvDrythN2wBcIt8eOXCByBR0mXe7vM1KU1uVv454UnuCgeljF37yjepnc/U8rs0K9l4fUxnnhWoYkDZDRONHON3mscc18k60UGUFDT7+TkgaMqWqIBb/zEJ1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjL0Ydzm; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjL0Ydzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728367693; x=1759903693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=j0vI5bAGtRsWGOThwCsWocLWheBVo2Ga1fFu9BfWGVI=;
  b=XjL0YdzmgZnFZjGc0uwEve7k4JcHH5LNhtLXcg4/kufSFiStbL8sh/B0
   WI7JnyXKhzExFK4GAEpo2bgiBANUxQP1qmt/erFbAY8muAMNvj3cnX4Aa
   wvk2OpCM+AH6zPNOiWlzDQIRzxY3gIL/sNgFbHcCnlpSGKSJloy/tZKb2
   v4CDvVBqTPOgfDr1aD+gVrfXLpBEhtmyxFaMF7TaSq+6uaeX8vKSgh137
   rwWO6xxMmqaNCR04o1Hl5sNVP3QnYzNo3scpnQoqLhAB18fPWMiZ3OsZ/
   0EBpif4Xjb9gVv/c/co5B8VnYqRV0s6SZ0ijenw+rq7ntYDgxuzlaWp6B
   w==;
X-CSE-ConnectionGUID: nJk+EYZnSnGrhVqzICHnuw==
X-CSE-MsgGUID: Z5lgapxzTEGOLXKhujO20A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="45004391"
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="45004391"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 23:08:12 -0700
X-CSE-ConnectionGUID: cguRD+1uTdmeoTyWh3f1Nw==
X-CSE-MsgGUID: UTITr3nNQ+CiYrOupK63kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,186,1725346800"; 
   d="scan'208";a="75285914"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 23:08:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 23:08:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 23:08:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 23:08:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 23:08:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF+nYI8BvpiYW9CA8NKLb23ueBz//r29g8jruX/Hw1njmlBF+zUd9aIuROkM/NKMNY2IP/y/HpDsaDz+jajJT1YQ24L1jaSzPprnHOflVURX2nhi5xDgC9RS9ydkv+4pJLh9rHpx2ANui7wZM18tPIQvZtzgjx/oSYYF+MXBakD52HNk6YteyY25eoKZAZtB+/n7ItYmpManBADP/hN1FLf3sQ8ELVM2i2xbnKg7j9zjtFMAtVA+YKxUdZS4+Gyt9S1LZ19Mf/Cv8hVfBx/TlCbM9yXuxg01atlr05LeSaVENBYj79o4JhJtQ7DZJqEf6x/UNkD3kqnxR4kxq2koBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0vI5bAGtRsWGOThwCsWocLWheBVo2Ga1fFu9BfWGVI=;
 b=BVhINVPsKkoipZ77wJ1XshOFOttssnHljWXxIVEu4gpa6oupEgSBILmKikRTu4r+qRN6eU46AnB9AzAYnbZeymnXQaZCg9GyrLtTFhfT/FYY8fxpiudeqmP/25dEeqdhhikvjEvXT4AYHSiXfXHte4R4y6ldM3hpNvWP72nVkySQaUTRv0HGt0wwY75zwE1uFxflbeEgRtBm7zruPMyVTlmdca4O6ozE29UtlVYkryVqTiwIJ0HmdcbgK45mvMgXJ2oItA094M49/kwMbt5jTtUxUm3H2wOJ2D9JlyBILN+xAR7VOGmup5WVL5kz7vHE/r6PvowVWKk1rz/iWOjFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 06:08:06 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 06:08:06 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "Dhananjay.Ugwekar@amd.com"
	<Dhananjay.Ugwekar@amd.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org"
	<acme@kernel.org>, "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eranian,
 Stephane" <eranian@google.com>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>
Subject: Re: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD
 CPUs
Thread-Topic: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD
 CPUs
Thread-Index: AQHbBfC/c6SZRefN40OvJSoH01hdyrJ8hP0A
Date: Tue, 8 Oct 2024 06:08:06 +0000
Message-ID: <76b67e939f58c3f4665c779bb867a03973796650.camel@intel.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_
x-ms-office365-filtering-correlation-id: 38f99a15-4caf-4ba1-8652-08dce75f939d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?alh6VDhMTG9PSVBZMlRTenNqNGZVQUN1ZDF3YUNqSmI3OUZSVW12TjZtaC92?=
 =?utf-8?B?S1I2ZUFDOFlPM1lzaWVNUUF5N3BqTU5hMVFSTkFKOFFlY2tHVG1hQzZKeElS?=
 =?utf-8?B?QnROajZEVXF6Y1hYSFp2RUIzZ2JtK3RFbndjL01KRktpSlpVbkJiYUFRU1Qz?=
 =?utf-8?B?eFJZZ1NtYVc5TW9uRHBqdUtuS05YTS8yN1gvTnpHUm94MmhCUGdKZXRsUUU1?=
 =?utf-8?B?b0V1MXR2cEhMM3hlQThUU1FlQlV5K1pPR2VxSDRSVC9tQU83ZERIaEFJWm1U?=
 =?utf-8?B?S25VNTI1ZG91akZMT1MrSU1SdDFhc3VTajc2MU5Hd2JmTWJad2s5d0RCdTJy?=
 =?utf-8?B?V0FWV0JzdFJDNWJjdmVVZWZFbHk0MGZRb2FXZ2o0ZDFHUDdMRVo0MnlnbnlB?=
 =?utf-8?B?KzhDOThFR0Z4U0lvWmljNTVOemI1YmEwSGtIVkFzTldpUGx0d2NsWXFPcUV4?=
 =?utf-8?B?MEdLMG1oeWVwR0hKZkw4RkxNeHRyUkROMU9VcXU2cHRCU2JZTzJELzhFVzhZ?=
 =?utf-8?B?TDEzbHZWa1hNWURsZWxUZElSVXBNaXF5ZTB3bUZHMUR1akVUdEZWUTBLSFNt?=
 =?utf-8?B?cHhhdzErNHRPQ0VzNGlBWHBrWWhoUnBuWmVnNmt0M2s3RmdWUmo4UjN3ZldW?=
 =?utf-8?B?blBRQ1dsVnBrVC9PUFl2ckdoUHl0eHFsTmRHVWtxK01VMEdoSUVzT1owTWxZ?=
 =?utf-8?B?RWpyaWtyd3lxTXRpTzJiLy9VMGxic0RNNDh2LzFJRXBnS3o4NEV3SnpjS3Z3?=
 =?utf-8?B?N2R3TFBrOFhBS0NOTmpXdWFpaHhoZjFIaTUyUnlzTGZKbzgzaGNQaW1QUDlm?=
 =?utf-8?B?em80TmcwbkpnZkNFTnpLT2gzTklLS0ErQkl1K2F1TkVSVWl6VGk3TWtwTzZH?=
 =?utf-8?B?QW83MEorT0xDTXhwUzZUcVVZVC94YkV5MlVkTEJIbm9Wa2pURTFHRzJkVVFz?=
 =?utf-8?B?c0RKcng1QkwyVHU5bnVvc3JWZFpxaUcxdExyRU5aWGI5UXI4S3p6TmpxQzhh?=
 =?utf-8?B?MElsc0JiNVQzUVVTa0Y5cTZoVlh2S2VBanBxRDMxdHZDQm5DYmZBemM4bkhm?=
 =?utf-8?B?L0UzUTQ0YVBmS0dRajBZVGVHM3Y1Y1J1QksyT3ZoblVFSllBTGxXTkg4akNu?=
 =?utf-8?B?dTlaanFCVDhHSkV2Z1VYSndCcjR1ZUtsVGV0cTc5WUl0K1duaFlZREd5L1g1?=
 =?utf-8?B?RWk2dWNpTGpFRXpZWGhXWldyYXdoVHZKV2EvN05jN0poSzhzdkptNGR0U29F?=
 =?utf-8?B?amh3UDQxTDcwSk1idzBCakU3Z3pyZGhqVXBYTldnM2dNN3hpYk5DSkd5NUNE?=
 =?utf-8?B?cXpPZkU4eTJqaU40NStEL2NacU1CSUNramxlMGoyZGhPL2xEQ3JMV2VEdzcx?=
 =?utf-8?B?MWM4NHFvU3kwZUFmTjlQOW4xcXJ1UnJFdUJWU3VheDRsNmVZbjZjVENac1pL?=
 =?utf-8?B?SGNmVHlRKzZ0cmRPZlVBMjBUUVhNK1FBS2hLSC92Y0lkRDRqOXBXU21zYnFQ?=
 =?utf-8?B?RHlEQTNGT2Ird3ErR3F0TXI1TUNYYUhiWGJvRCszeXppLy9KQzdlNUR5ckI2?=
 =?utf-8?B?Um1paVAranNwL3VNRDJDdysyTUdvSUZZV2loa2xPQnE0QWd6QS9PaFBVNjdX?=
 =?utf-8?B?Q3VzRW9GWGZwcHdMZWhvc3dXd3IyQmo5SkZ6UitiM2JjZURWVkYyRzNpTXh4?=
 =?utf-8?B?Q1BKeHk5dWFGdTlZWldtdHpnbzNYYUg5dGZpUnQ5VXJmOFg5VDBBYUJUbTVv?=
 =?utf-8?B?M3JKMDR6TUZNbUh3MEk0Y2VaQnFhdzlLREMzYWpvUFVCV0lsTVMrL0pKWFVl?=
 =?utf-8?Q?5M4M/RvyaU74hT1A+9mzK3EMP0PWgKIzPqK8M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3lRVGhxSERqbkJZS240TWlUTWQ1WjBrTVBTNnBOMlhPNWR4eU42d3pZYVNy?=
 =?utf-8?B?WmdMNHFVZXVvU2gvZzBZM0MramxXMG9lN3BoS3EwVmR5ZzdtM1hIaWhzaEc1?=
 =?utf-8?B?KzhMMU9EN3gwNFpjU05tdzJyVk9Hc2gxYVNmMmthbG9lWHl5YjlsWG42Q3Nx?=
 =?utf-8?B?Z0tCWHU5di9od1dJb2orZUx2bkNYUjlQRnFBSHJ5Y01aSTNMSHljaE1KaWJF?=
 =?utf-8?B?dTVMZHEyOXpYZk1ZaTFyaExrTmw2czhGRGQ1MDJuTUw2d0FFbkRUVHlDS1B3?=
 =?utf-8?B?bnBjNlFXb0dydEczdS84WXdPKzkyZUpQMG5NbUJKT0FydjRsT2FQQk1DZ1ZO?=
 =?utf-8?B?REowUW9CdjhMamYvTTlsNzJxcC9mSGpEZytkNVo5YWRjTCsvUllRK0E1cWs2?=
 =?utf-8?B?Kzd5VlNEZVRZbCtUbC93UFQ4TU9pUU9ZQldGbVIvQzcrY0dJbzBlODc4NWNj?=
 =?utf-8?B?NUJkTG82cHhwQWRCWHNpM2dtY3AxVkhtWnk1VFAzTktRMGVHUmhXOFBQSEJS?=
 =?utf-8?B?VCtXS1JSQXoxMCtTR29IUmVHQW82UHhmL2lGaEt0b3NESzU2YVM5Z0JsZUlI?=
 =?utf-8?B?MCsvV3hkR3VQU0FHYVRjT3pBaThBUEVJOC9SR25NRjFBSWdMR0ZEdDlBcWJO?=
 =?utf-8?B?RGx4WTB2YndUS2kvSUw5Qng4ZmlRS2p4Q0xrWFZ3bFRKNmF5OXp5RnVDc0k4?=
 =?utf-8?B?ZGpSQnA2VFFxWXB1cnBtcTZjdHFxK0pTTFN5SWlLM3grWlhBUmJEcldwNHp1?=
 =?utf-8?B?RVRoaE5yTThRYnU2N2czV1N5M3dGOEFvTGFLVmh5cW1HZmxWcHZKc0Y1UnRE?=
 =?utf-8?B?STFkV2xvbURyQUs3MmEwSGdDVitTMEx5Y2lhaFUrZGF4TWMwdXNaWSt2aXps?=
 =?utf-8?B?TFFSRmErRnV3bHNEN2V0QlhpTlBLWTlScUU5Y094S3BOQzYxMWhhci9zN2Fm?=
 =?utf-8?B?b3hHNUVmcDg5THhuNjRXRllVOFR2c0ZYRmhWdksrbVQ5R1dxWitUOFdKb3pR?=
 =?utf-8?B?SWZPcWxZbTlPRGM3eE9HejlaV3RYeEcwUFhIT0l5eVRNZnIrMzlPekt1Mkw0?=
 =?utf-8?B?NFZEcVFPenBOQ3dWOFhGejVuM1d1Q1JOcHVjMGE3OWZCWjg4MTQwSlVSOVhi?=
 =?utf-8?B?QnV3L3dYZlFOaVNnV1U2dG05aFEzNFRUOUYvaVlpcHBseFJ2eU1YSFMvZ01B?=
 =?utf-8?B?LzJYV0lFWHdSeXN4YTZ2Y1ltVkIrckRyQkM3T1hNb3Z4eERuTCsyVG9iQVdI?=
 =?utf-8?B?TGFIMW12WEVoK0ZGUVNLKzQ1aEwva01vOGxDbGV3c1dyUk1rNHRPSi9qeHR6?=
 =?utf-8?B?UDdHMnlrRDdZVTg5T1kzTkxUVFVsMXl5dkhmVzl2L24rRmFSTnJaY0pWZE50?=
 =?utf-8?B?MEJxWW5kcld6NWVaNnRSZzBOb2Y1OE4wc2I2NEZTYWdVNjFlbmtFUGJIS0NU?=
 =?utf-8?B?cXZScnY2TzBpOC95ekFvaDVxYXFnWUpWSVhldEROSkRjMHQ3WE5IcmRYL2tO?=
 =?utf-8?B?ZERXeVV6WWtwZVM1anVIRVM5ZG45MUlGNGlIS2ZSL0ExRDdiellVb0V3dDRN?=
 =?utf-8?B?dVhSNmtYejl6aEY3N3FJWHdxMmI3VmYzU0VZQjJzdU5ZQVZPY0JhREgxWEFh?=
 =?utf-8?B?bUlkMzVVdUQ3ckhDeGZ6QjcwT2RSU1gzWDlsemp4VnVxN3pXQ3haWHJ2WDMy?=
 =?utf-8?B?dFV0a3AwZWJienh4N3Y5ZkJVZzVTTzdXSG96eXNqeC9ZUmwxS2R2NEhBQ1A3?=
 =?utf-8?B?djNoZFRneWR6SllweDhIcnQrb3kyMXBzeFFjbUVQbTFBbkVCd3FpMjR6Zlhn?=
 =?utf-8?B?SWV5WlVncXlUSFlpVk91YitiZUJhU0d6T3VaUjYyUXlNVHU4ME8xZFc0OUYw?=
 =?utf-8?B?bGVaaGw3b29tOCtaWllJSW41a3NQRHVkb3V4cmZGOU9tOTN2SkRqczhnemp2?=
 =?utf-8?B?QVpHcGIzSmg4Zk1BcVZZeXlTUmUvaUhFUEkrS0s5RzVmcjlCYUlWTTdhcHNK?=
 =?utf-8?B?NTJ3RUcraG0rMlVidEVhZXBVRVduV1JHTDExSFZQQ1EzSjVXcmdNZ01LYktr?=
 =?utf-8?B?Y1NXcmRRQy9yOFloa2Vqdmx1aWdabFJRMCtVcU4rcGNBdVZObUxqRXJzeURN?=
 =?utf-8?B?SW9DY3ZUUzFjUFE3aFhpY21LaVpxcUNQM3dXQ01VZEhFT0EzWXdPRm5NaVFF?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F01290672CEF5A42B28DB755A392FDE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f99a15-4caf-4ba1-8652-08dce75f939d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 06:08:06.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uE2yFL1ljSIHd1uOcxnpSnJqy1JHjOmd1reEv7vzBMO2hZOkm01bhwEOYVZcu3RgUCkry6qAENzHu+1FYAfA+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA5LTEzIGF0IDE1OjIxICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gQ3VycmVudGx5IHRoZSBlbmVyZ3ktY29yZXMgZXZlbnQgaW4gdGhlIHBvd2VyIFBNVSBh
Z2dyZWdhdGVzIGVuZXJneQ0KPiBjb25zdW1wdGlvbiBkYXRhIGF0IGEgcGFja2FnZSBsZXZlbC4g
T24gdGhlIG90aGVyIGhhbmQgdGhlIGNvcmUNCj4gZW5lcmd5DQo+IFJBUEwgY291bnRlciBpbiBB
TUQgQ1BVcyBoYXMgYSBjb3JlIHNjb3BlICh3aGljaCBtZWFucyB0aGUgZW5lcmd5IA0KPiBjb25z
dW1wdGlvbiBpcyByZWNvcmRlZCBzZXBhcmF0ZWx5IGZvciBlYWNoIGNvcmUpLiBFYXJsaWVyIGVm
Zm9ydHMgdG8NCj4gYWRkDQo+IHRoZSBjb3JlIGV2ZW50IGluIHRoZSBwb3dlciBQTVUgaGFkIGZh
aWxlZCBbMV0sIGR1ZSB0byB0aGUgZGlmZmVyZW5jZQ0KPiBpbiANCj4gdGhlIHNjb3BlIG9mIHRo
ZXNlIHR3byBldmVudHMuIEhlbmNlLCB0aGVyZSBpcyBhIG5lZWQgZm9yIGEgbmV3IGNvcmUNCj4g
c2NvcGUNCj4gUE1VLg0KPiANCj4gVGhpcyBwYXRjaHNldCBhZGRzIGEgbmV3ICJwb3dlcl9wZXJf
Y29yZSIgUE1VIGFsb25nc2lkZSB0aGUgZXhpc3RpbmcNCj4gInBvd2VyIiBQTVUsIHdoaWNoIHdp
bGwgYmUgcmVzcG9uc2libGUgZm9yIGNvbGxlY3RpbmcgdGhlIG5ldw0KPiAiZW5lcmd5LXBlci1j
b3JlIiBldmVudC4NCj4gDQo+IFRlc3RlZCB0aGUgcGFja2FnZSBsZXZlbCBhbmQgY29yZSBsZXZl
bCBQTVUgY291bnRlcnMgd2l0aCB3b3JrbG9hZHMNCj4gcGlubmVkIHRvIGRpZmZlcmVudCBDUFVz
Lg0KPiANCj4gUmVzdWx0cyB3aXRoIHdvcmtsb2FkIHBpbm5lZCB0byBDUFUgMSBpbiBDb3JlIDEg
b24gYW4gQU1EIFplbjQgR2Vub2EgDQo+IG1hY2hpbmU6DQo+IA0KPiAkIHBlcmYgc3RhdCAtYSAt
LXBlci1jb3JlIC1lIHBvd2VyX3Blcl9jb3JlL2VuZXJneS1wZXItY29yZS8gLS0gc2xlZXANCj4g
MQ0KPiANCj4gwqBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOg0K
PiANCj4gUzAtRDAtQzDCoMKgwqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKgwqAgMC4wMiBK
b3VsZXMgcG93ZXJfcGVyX2NvcmUvZW5lcmd5LXBlci0NCj4gY29yZS8NCj4gUzAtRDAtQzHCoMKg
wqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKgwqAgNS43MiBKb3VsZXMgcG93ZXJfcGVyX2Nv
cmUvZW5lcmd5LXBlci0NCj4gY29yZS8NCj4gUzAtRDAtQzLCoMKgwqDCoMKgwqDCoMKgIDHCoMKg
wqDCoMKgwqDCoMKgwqAgMC4wMiBKb3VsZXMgcG93ZXJfcGVyX2NvcmUvZW5lcmd5LXBlci0NCj4g
Y29yZS8NCj4gUzAtRDAtQzPCoMKgwqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKgwqAgMC4w
MiBKb3VsZXMgcG93ZXJfcGVyX2NvcmUvZW5lcmd5LXBlci0NCj4gY29yZS8NCj4gUzAtRDAtQzTC
oMKgwqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKgwqAgMC4wMiBKb3VsZXMgcG93ZXJfcGVy
X2NvcmUvZW5lcmd5LXBlci0NCj4gY29yZS8NCj4gUzAtRDAtQzXCoMKgwqDCoMKgwqDCoMKgIDHC
oMKgwqDCoMKgwqDCoMKgwqAgMC4wMiBKb3VsZXMgcG93ZXJfcGVyX2NvcmUvZW5lcmd5LXBlci0N
Cj4gY29yZS8NCj4gUzAtRDAtQzbCoMKgwqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKgwqAg
MC4wMiBKb3VsZXMgcG93ZXJfcGVyX2NvcmUvZW5lcmd5LXBlci0NCj4gY29yZS8NCj4gUzAtRDAt
QzfCoMKgwqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKgwqAgMC4wMiBKb3VsZXMgcG93ZXJf
cGVyX2NvcmUvZW5lcmd5LXBlci0NCj4gY29yZS8NCj4gUzAtRDAtQzjCoMKgwqDCoMKgwqDCoMKg
IDHCoMKgwqDCoMKgwqDCoMKgwqAgMC4wMiBKb3VsZXMgcG93ZXJfcGVyX2NvcmUvZW5lcmd5LXBl
ci0NCj4gY29yZS8NCj4gUzAtRDAtQznCoMKgwqDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKg
wqAgMC4wMiBKb3VsZXMgcG93ZXJfcGVyX2NvcmUvZW5lcmd5LXBlci0NCj4gY29yZS8NCj4gUzAt
RDAtQzEwwqDCoMKgwqDCoMKgwqAgMcKgwqDCoMKgwqDCoMKgwqDCoCAwLjAyIEpvdWxlcyBwb3dl
cl9wZXJfY29yZS9lbmVyZ3ktcGVyLQ0KPiBjb3JlLw0KPiANCj4gdjQgTGluazoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNzExMTAyNDM2LjQ0MzItMS1EaGFuYW5qYXkuVWd3
ZWthckBhbWQuY29tLw0KPiANCj4gdjUgY2hhbmdlczoNCj4gKiBSZWJhc2Ugb24gdG9wIG9mIEth
biBMaWFuZydzICJQTVUgc2NvcGUiIHBhdGNoc2V0IFsyXQ0KPiAqIHJhcGxfY250cl9tYXNrIG1v
dmVkIHRvIHJhcGxfcG11cyBzdHJ1Y3QgaW4gcGF0Y2ggOA0KPiAqIFBhdGNoIDEgZnJvbSB2NCBp
cyBtZXJnZWQgc2VwYXJhdGVseSwgc28gcmVtb3ZlZCBmcm9tIHRoaXMgc2VyaWVzDQo+ICogQWRk
IGFuIGV4dHJhIGFyZ3VtZW50ICJzY29wZSIgaW4gcGF0Y2ggNSB0byB0aGUgaW5pdCBmdW5jdGlv
bnMNCj4gKiBBZGQgYW4gbmV3IHBhdGNoIDIsIHdoaWNoIHJlbW92ZXMgdGhlIGNwdV90b19yYXBs
X3BtdSgpIGZ1bmN0aW9uDQo+IA0KPiBCYXNlOiB0aXAvcGVyZi9jb3JlKGN1cnJlbnRseSBoYXMg
anVzdCAxLTUgcGF0Y2hlcyBmcm9tIFsyXSkgKyBwYXRjaA0KPiA2IGZyb20gWzJdICsgDQo+IMKg
wqDCoMKgwqAgZGlmZiBbM10gKyBwYXRjaCA3IGZyb20gWzJdICsgcmV2ZXJ0IFs0XSArIGFwcGx5
IFs1XSANCj4gDQoNClRoZSBwYXRjaCBMR1RNLiBCdXQgdGhleSBkb24ndCBhcHBseSB0byBsYXRl
c3QgdXBzdHJlYW0gYmVjYXVzZQ0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwOTEw
MDg1NTA0LjIwNDgxNC0xLURoYW5hbmpheS5VZ3dla2FyQGFtZC5jb20vDQphbmQgdGhlIHVwc3Ry
ZWFtIHZlcnNpb24gZGl2ZXJnZXMuDQoNCndpbGwgeW91IHJlYmFzZSB5b3VyIHBhdGNoZXMgc28g
dGhhdCBJIGNhbiBnaXZlIHRoZW0gYSB0cnkgb24gbXkgSW50ZWwNCnRlc3Rib3g/DQoNCnRoYW5r
cywNCnJ1aQ0KDQo+IFsxXToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8zZTc2NmYw
ZS0zN2Q0LTBmODItMzg2OC0zMWIxNDIyODg2OGRAbGludXguaW50ZWwuY29tLw0KPiBbMl06DQo+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgwMjE1MTY0My4xNjkxNjMxLTEta2Fu
LmxpYW5nQGxpbnV4LmludGVsLmNvbS8NCj4gWzNdOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvOGMwOTYzM2MtNWJmMi00OGEyLTkxYTYtYTBhZjliOWYyZThjQGxpbnV4LmludGVsLmNv
bS8NCj4gWzRdOg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90aXAvdGlwLmdpdC9jb21taXQvP2g9cGVyZi9jb3JlJmlkPThkNzJlYmExY2Y4Y2VjZDc2
YTJiNGMxZGQ3NjczYzJkYzc3NWY1MTQNCj4gWzVdOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNDA5MTAwODU1MDQuMjA0ODE0LTEtRGhhbmFuamF5LlVnd2VrYXJAYW1kLmNvbS8N
Cj4gDQo+IERoYW5hbmpheSBVZ3dla2FyICg4KToNCj4gwqAgcGVyZi94ODYvcmFwbDogUmVtb3Zl
IHRoZSBjcHVfdG9fcmFwbF9wbXUoKSBmdW5jdGlvbg0KPiDCoCBwZXJmL3g4Ni9yYXBsOiBSZW5h
bWUgcmFwbF9wbXUgdmFyaWFibGVzDQo+IMKgIHBlcmYveDg2L3JhcGw6IE1ha2UgcmFwbF9tb2Rl
bCBzdHJ1Y3QgZ2xvYmFsDQo+IMKgIHBlcmYveDg2L3JhcGw6IEFkZCBhcmd1bWVudHMgdG8gdGhl
IGNsZWFudXAgYW5kIGluaXQgZnVuY3Rpb25zDQo+IMKgIHBlcmYveDg2L3JhcGw6IE1vZGlmeSB0
aGUgZ2VuZXJpYyB2YXJpYWJsZSBuYW1lcyB0byAqX3BrZyoNCj4gwqAgcGVyZi94ODYvcmFwbDog
UmVtb3ZlIHRoZSBnbG9iYWwgdmFyaWFibGUgcmFwbF9tc3JzDQo+IMKgIHBlcmYveDg2L3JhcGw6
IE1vdmUgdGhlIGNudHJfbWFzayB0byByYXBsX3BtdXMgc3RydWN0DQo+IMKgIHBlcmYveDg2L3Jh
cGw6IEFkZCBwZXItY29yZSBlbmVyZ3kgY291bnRlciBzdXBwb3J0IGZvciBBTUQgQ1BVcw0KPiAN
Cj4gSyBQcmF0ZWVrIE5heWFrICgxKToNCj4gwqAgeDg2L3RvcG9sb2d5OiBJbnRyb2R1Y2UgdG9w
b2xvZ3lfbG9naWNhbF9jb3JlX2lkKCkNCj4gDQo+IMKgRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni90
b3BvbG9neS5yc3TCoMKgIHzCoMKgIDQgKw0KPiDCoGFyY2gveDg2L2V2ZW50cy9yYXBsLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0MDYgKysrKysrKysrKysrKysrKy0tLS0tLS0t
DQo+IC0tDQo+IMKgYXJjaC94ODYvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmjCoMKgwqDCoMKgIHzC
oMKgIDEgKw0KPiDCoGFyY2gveDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmjCoMKgwqDCoMKgwqAg
fMKgwqAgMSArDQo+IMKgYXJjaC94ODYva2VybmVsL2NwdS9kZWJ1Z2ZzLmPCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgIDEgKw0KPiDCoGFyY2gveDg2L2tlcm5lbC9jcHUvdG9wb2xvZ3lfY29tbW9uLmMg
fMKgwqAgMSArDQo+IMKgNiBmaWxlcyBjaGFuZ2VkLCAyNjYgaW5zZXJ0aW9ucygrKSwgMTQ4IGRl
bGV0aW9ucygtKQ0KPiANCg0K
