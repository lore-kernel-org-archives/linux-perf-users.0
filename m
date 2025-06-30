Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA6286D6F;
	Mon, 30 Jun 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293314; cv=fail; b=ZN1rFiJSCaZJQsuS0hrMYxHBWSFD5Jxx+O9s66tn4P5ur5tFxTudBY5nBo9tVaBBLymi3SVJU1K5C11uzqGvFl1mKg4qC4bSRkI0Gao54xk5TFDWQ0ZaIDahypwNxE03q13BboRKAs1jrpXU+v4tK33C/qNJWNRgXcufywCqYbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293314; c=relaxed/simple;
	bh=Ybpcw036VYZImuBUAl8cj7kyHU4SToPKIaszuX5alT8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dORWycpHSj2CocaCuSqH+dWdIRc6Cu3jPqxjCl9DKIAulkM4aWBdFljutpFsB9xY1kELwtcPaTjvWbf64zDsdEWTdbOMl/o/IBnFCDLZ+SDZEt8lQY1DKozaQWR+Z6NkIA5W+BCZfZSoxsSEuIboDPnm5FOTTSxWJcbEYDDEJ2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Voj9ePUf; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Voj9ePUf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751293313; x=1782829313;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ybpcw036VYZImuBUAl8cj7kyHU4SToPKIaszuX5alT8=;
  b=Voj9ePUf7J2X+KlkEta8xswyju1d1VHkmwdLcNs9BB3h/8l9qr8UzkX8
   c5B2riaP9bgVNAf4T3wNsyeg8ghNWW91O+3RIh33p7Z9TVNQxtfExZ5xs
   pwrnqsWx08vMVv8+0YUA1iDQlolBjDasIEvnbQP2BNj0ft4cx+UtUFpd8
   I4RzLiVR86ViQB+my3rh15WyPvihPD2jvFo99a0SgcECcQwbeNVKLbjnW
   0kz4BbjMmzdcRSyzXasK2/LnxI3cCT1rHsvmSVq+/NtbHH4RnMqFTd4aZ
   OhlTcqznTIhuxOIRROZu3bXb/khX75TUark6lw6ku+goiBg/NAPAwFAMR
   A==;
X-CSE-ConnectionGUID: H9blxZQpTzyqwCGOTnId9Q==
X-CSE-MsgGUID: myKyUlr8TS+WAB/G/J04Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57200508"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="57200508"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:21:43 -0700
X-CSE-ConnectionGUID: G1yy2mTeQZ+Bx7spV4BVuA==
X-CSE-MsgGUID: SgncQ9TQSamCVELx/k5VNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="157752043"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:21:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 07:21:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 07:21:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 07:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHdc00rIRbQ0kP/Ew+7r+9RUAu08cXmHvyQYQe72MxaekFi/Uyo+EylCm6xLiDpsuu4c0wImMaHLJY9jNNCPG3fBn5L1pztfoiSg6RPVbOljkqy9DgtPLIF052ST/PYyW+L1Terr2/DE5k1ODLHCySP0DJKaJ9zbaC6O74A+jdMB4pnCZvSyJEak99cnOlP6c6FAhHvjb30hygEpcO+RwfrWQkwIns2qP83jWyTfrORvcJB9aVEdI4ae81yMIREhUpJ1QksCyd1IXiUoz1Uu2UjjqYeCt7f0CLJ8k502SwMdplGIqjQAxacLGFfHjc72N0sR/aTwF05iOOK9zfECdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybpcw036VYZImuBUAl8cj7kyHU4SToPKIaszuX5alT8=;
 b=YIsnYp5TXVPgX9kO48UKhCUIqhYgnUqRdi/znhu1tpIyt9COUNWBXseXL4CBfDovfIPHDVtHsdG1Ht6cHe+1hgSRd8QaFA1x8hYNCdNO2vLNRlQh9Qpa4Jn4u4CQiQQgSH8Uv42CDGVaCZl4ed77+fqqY7faHRGWXtFY5KgxePXZgdnvDfYR5YnI8PsXIreM4xQw3oIbu5HcRRRYMXKThrA/wiX/y7fj9/Z4jOakzets1+2CHVUG9DjdZ2blK2Xl5t/wHccfLNL4TFa+XFek2fScZR3FFPgS7HZEiIo8r/O6ZTFMpZN05Wez9KyHLMym05AyLGOzZ/w+kPSN2C8t3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 30 Jun
 2025 14:21:19 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.8857.026; Mon, 30 Jun 2025
 14:21:19 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"Baker, Edward" <edward.baker@intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "mani@kernel.org" <mani@kernel.org>,
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>
Subject: Re: [PATCH v1 00/15] perf vendor events: Update Intel events
Thread-Topic: [PATCH v1 00/15] perf vendor events: Update Intel events
Thread-Index: AQHb2y1WgEzfCfAdH0uR/LJbTixlAbQXzQWAgAQRHQA=
Date: Mon, 30 Jun 2025 14:21:19 +0000
Message-ID: <fe821704ddd4a3ae5169ec974cc8cfde8dc44e7d.camel@intel.com>
References: <20250612000224.780337-1-irogers@google.com>
	 <CAP-5=fVGqnWuQNYM9XULyLuDvx-yAuyCMRh=uS0gybiEsYH9jw@mail.gmail.com>
In-Reply-To: <CAP-5=fVGqnWuQNYM9XULyLuDvx-yAuyCMRh=uS0gybiEsYH9jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB7903:EE_
x-ms-office365-filtering-correlation-id: 12547ec7-9e80-4bba-0209-08ddb7e1621e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dDBzaGFBcFNQelA4Yi81MHFmdmlXcTAvU21xWDA3SXdTYjVnS3lJUWx0SnN4?=
 =?utf-8?B?U0gvbUdXQUU4OTdEOG8yTFcrN0RkZVJVczBmSThBSjNmOWFETnFDcGUxa3Nj?=
 =?utf-8?B?dlJhWkUvL0tHTHZqVzJ3di9XaGViVVpweEc2dWFJZzdTNFVDSWh4WDBmWWYy?=
 =?utf-8?B?Wk5ycmNkRlhtODVwMERhaFZDNnNzVDF1VkVrdDY4K1R0aXFKNW5STE5UQ3Iy?=
 =?utf-8?B?dHZueC93M1BpY1JEUldURmd0L09KTy9ISlRDbjA5U2NoU3RLYm11bzkyOXlp?=
 =?utf-8?B?VDI1dU5SK2t3b2hjQ1p5Z2RlUDdhQVM2RVIxZnlhZjBPZlRNTGhxUDNlMlhU?=
 =?utf-8?B?R2V2TGhqQjlQckFYTzlQTTV6WnpITzlvVW9Ha21rQUNrY2wyRzlmNU1mRXAr?=
 =?utf-8?B?aUwyMFFWcFd0ajlRZGpNZVNyZWdxeGp2WDRjclFScDRZdTI5dldtdHpuQkVX?=
 =?utf-8?B?clJjRDNXYUx2eTVXWDlqOVNVbk03M3FUWjhyZ0VMOENXU2F4RVltVXBBc2dq?=
 =?utf-8?B?Zm04WnFJM3JuOTlqYWttNmoyZUZHemtrNCtTYTRtM1NienJnTUNubzVNVDY1?=
 =?utf-8?B?WDY0WFE3aHN4NjdOaEo2dWhVc2tpUEdhZFJ5S3pIVmdPaEdGUUE5Wkt0TFlj?=
 =?utf-8?B?eEFFSE9xMW4yclI3ZGFyYjQyRkVad0tZUGt1djdhYlIrcW91ZmFLaU4za2lk?=
 =?utf-8?B?bEp3MForZkhPWHRMT0pEcDFVTUliTTZENFFiZ3Zvb3dpb0MvblZOMUdPZGRH?=
 =?utf-8?B?cVd3S0VEaHRtcFA5MWtENXdwUU93b1BtN2pxTzN6Wm4wYkxhWXZnQkNqS2Ex?=
 =?utf-8?B?Q28vQS8yeWpoRXBpTHMzMmZBVmdIS0wvNGNvWFpjVVhhMUdsWkoyakoxdXFu?=
 =?utf-8?B?WDNrQXFjeDZBSDlQbi9jQ1dSWEtXMS9CVnJrSmNvQkdFRjJ3Y2xYWFpXYkZu?=
 =?utf-8?B?dnJZYjMyQzFGdUI4SWJwbnlEd2NEZEI4ekh5RDY0UmtKMlduNGdiRm92OHhQ?=
 =?utf-8?B?RjFKZXJFWjh5YW9qek1nd1B3L0Q4QlFRWEVzVFNBYUpXbnVTMTlVQTdDaHJK?=
 =?utf-8?B?VEx3cWlKc2F0RlNnNmc0UGxiK1lmNUUrdzhJRGRobWVycTRGMG9VQjFJWkNR?=
 =?utf-8?B?Ui82N0lUN1NQUWZhYjkzZXA2Zm52YnpJT0p6WU5iSGZBR29BR21zSjNFTnN1?=
 =?utf-8?B?ZlBmNkNmK0t1VzgySGNWUFN6eXgrcTdydTFEaHFieG1oMFdLTkN6YXBxVjhw?=
 =?utf-8?B?MWNaeFhZRDF3QkNmK2JyOFRQUGQxcWI0VkcyRlJ1UGxiVi9pb2pkN0ZtZURS?=
 =?utf-8?B?RXJlZlJsa20vN1d2Unc2RDVNcWc4U0ZKdU55UVFOQjRqRmt3cXRjZ0s2VHgw?=
 =?utf-8?B?dEhIR0E1em96SmxIZ2E5dlNZNXpkNWVnYjdjSjZKNjdHQjBCcFhNcDA5UUJz?=
 =?utf-8?B?MDRQRGM2MWI3cWVJc2hCTUI2K0lDbXN5ZDUrWHpCeUFVQ3ZWVUlJOWdjQWJx?=
 =?utf-8?B?RllVanpUZmtqY2N6MUJidHZzQUtuaGlyYzNsNE9ySjUxaGdtNkkwZnA4U2Iv?=
 =?utf-8?B?OEZEWEM4ZEl1RFlNTlZVYlIwVUgraXk0VHNFdU51b3JjaGNaN096V0NqZmRF?=
 =?utf-8?B?OHlHMDVSMlhveVFORkVyVjJtWlkreTR6YVFNVXFTVVl2eUdPeTkrZlVzdGdH?=
 =?utf-8?B?aHRkcVU4RFViR01jRVNXNENId0VOVnYwd2pTU0xqU3BzT2ttbHFsTUxrY09D?=
 =?utf-8?B?SERsSVJpdnc1S2ZPYzlrVnBoR2t0UDUwL2pWT0FmN2E4RFlxdS9sRklkeVpk?=
 =?utf-8?B?UTlPMmdna2wxckk4YjlSdU9kazNDRzBTOTFISDNRdXgxZ1lGQnRIN3c2UjQ4?=
 =?utf-8?B?emJ4d29RV0N2MVJnY3BLSi9sNjM4N1RYM1pCTDljRnNwNEtmZjdXQy9BSTlz?=
 =?utf-8?B?bGtDN2cvWG1UalAxMGNxM2F1cURTeXJLM2I3d2ZnRmtJeDkrNm40eFhFYmpE?=
 =?utf-8?B?VEpsTitPOWJacUpVZE1jeHUzcjQwMWhkM1lLODBxRHZ4a0NNTFE1V2xWY2ZU?=
 =?utf-8?Q?OCK1Td?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alBwZDlPay9vUmwrMWkyNlY3SFVLelFWTTEvd1pFb09SQlAyMVZqZ254K1JS?=
 =?utf-8?B?SERQaDJjMVVYcksyNjRHdVMwZWFDK0tQK3U3WnAzMW9paDJHV0kvbDBvaEh4?=
 =?utf-8?B?eVNPZUJSbGhEMmVoZUM0SDFsUHM3Ri82WUZEVEVDSit4dzUzNVkxWTE3b3Ir?=
 =?utf-8?B?SjhSbHczdlhNT2NGL2wvTWhPUGtlVi9jdXIxVS8zVE14bjR1VkxzWmZkQ1F5?=
 =?utf-8?B?U290MEcyeWYyNkx6RS81SnhRczlpSHNCeWt2bzZvSVVaN2YySHJZMHgyMENw?=
 =?utf-8?B?KzhaTnU1SEtjazd2V3JMdy8yeldYY3IrbUdkcGJwL00zQW9KT0l4VFY1eDNo?=
 =?utf-8?B?QnhQbWJRS09aVDNmZWZVQng0dm0xSTlnV2hDVWwzckYyWVNEUWpGa3V5L1hv?=
 =?utf-8?B?NjZ2N3BieVZrQlAxczR1VFlmNURwQi9hZVZvTmpndkFvZXBXVmdTWlBTYThi?=
 =?utf-8?B?WFpBZkc1eW5oNS9ZeHFieG5DNHZ3YnZydXNHdmxiblk2SkZ2cVZNVTZjc0Vw?=
 =?utf-8?B?ZVpNVWNMeXY2TVVGYWZlaXMzdVZxdzBuWkRLQlNQN01DRlQ4Z1p3aTVIelFO?=
 =?utf-8?B?SjRibU5BWmtSWGQ0UWhvbGNYRnBURHFvbmYvVUxKaFE4NFNldGxsc0NqQWM4?=
 =?utf-8?B?TUZJQ3JDOU9YdjFjVkFHZ2FzdjVQVVE4RDN4NGRaYkVHdTRnSkpZVHQyaGZ1?=
 =?utf-8?B?Z0pTYTh2MlhuaUZOOXhIOFVzT1I1QjYvNXZOZURQZVpLbCtYL3V6ZUVrQWNa?=
 =?utf-8?B?MzFTV3hWWC9VZXM1UlRlbG1Yb041WGQvR3BRWmN3T1lOSDdGKy9qMlRFZ2dj?=
 =?utf-8?B?Q1Q4OGNMRnhJdmJpb1ZKNnpGRXF6OUNIUnliUDRqMkd3SXVvdmxyL2JhSlZ1?=
 =?utf-8?B?RlhQeEk2bnRDbE9nUnJqMS9haitvY0dGUzhER0E4dTFCS001My8wWFE0N3Z1?=
 =?utf-8?B?MVZ6emFUUGJUU1FONHRkZzVNWGt2S2Q2U3pyRGVENVh5V3JPWUJ5dnNTSkRk?=
 =?utf-8?B?ejZOM2R0L0VxSzU0eWlZTmI4L2dPTFU4OFB3dk9PNHlhL0h2a0hWYjdTLzhh?=
 =?utf-8?B?ZTAxYUN5WFhoUjYxTXF1V1dXTTlzc3o5Z2RTVEZudWU4bnh5YnBabGdoUXJY?=
 =?utf-8?B?YmYvNE83ZWxUL3NVRVhKOUpwVDVDeFg5MnJ1dDhZRXh1OXZsZ3JKdXBkbm5r?=
 =?utf-8?B?U0hTS1lGcU5DRU1XMjYzdmQ0Q2N0K1ovM1JRNE1CNXZzVkY5ZUs5djRKL0JI?=
 =?utf-8?B?dHdtUTY3VzFSM2poM2h2TFRlemNXc2E4Z2s4dTZwNGNBOTJPdnpOUHRzS3Bn?=
 =?utf-8?B?WGwzdUVTYVZMNGk4dzZkcXh0VllXd0RMZzBZa24zSXppWm1ZOVpkMFRsSW5J?=
 =?utf-8?B?QTFsWFRrdjJqNWUrNTJBd0ZzcTlTTmUrUm1pUlBGVDhLRWpJYU5MYTVRVzBS?=
 =?utf-8?B?bkhJWVN5aWlVYmp1UDFha0w3K2FhSVZFSk81bXUxR2ExVGFlaDhoNENoOXJu?=
 =?utf-8?B?NnN5VkovNEJmNXBmdE1EQUdyRWY1VEVTeDJGMFc3Y1BzUWlLQ09hZ1JUelBM?=
 =?utf-8?B?SHA3SUVvcFRZdUJOakNPdjJtbnZhNGVJRHF4NWRsODBFd1FIeHNiQUV0cFli?=
 =?utf-8?B?ckVIL2xlL2YwVjQ5SUl4a2lhcGdLUTVUNFdQV3hyUU9sNU5CN3V3YkU0Q3Zk?=
 =?utf-8?B?VGY3a29GVTMwdHlaeE5IOUtSWHc4dmJhNHM5ZklWVXVsSWVlRW9HTUdsZ3Ew?=
 =?utf-8?B?dWdYL09weTE3b0h1dE4waG9vRDUyZE1tRUxKcHQrMWxkM2xKbmk0NHArdGE2?=
 =?utf-8?B?a1BoSFMxbll6OGJXOXYxRXA3RkIyYlRBZEQrd0tKQTJRekpicC9SVnBuT2h5?=
 =?utf-8?B?aTliZXNNWE1ITXhzWkZVOUMvdUFnTGF6RWFYNWVYYm9sbmNqdng2T3VJTVFU?=
 =?utf-8?B?amJma2VNMzJINThVbUdISGVsT1hVVXlickpvcVF5R25WMFFIY1VjeUE4S1Ra?=
 =?utf-8?B?N00vVWNmWWJDTGpKbHZFTmlpL0tSVDVmVlVEMXlMb2VaRFA4NnBqZ3hWS3k5?=
 =?utf-8?B?QWg4OVIyMXplSXdNRFlYbVNqUW5sazBFbUg1STB3VDd3SUx5NnJqZ2czUHJP?=
 =?utf-8?B?dXZlWUtoSnh1ZGN3TnVETVlqcFlROGZQdDZ3Y0lPd2pJRG9taHBvNXJwaU5r?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5743E33C02DF89498C526A8501E9A794@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12547ec7-9e80-4bba-0209-08ddb7e1621e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 14:21:19.7580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iO1sYodObqRkQyfZ1z561fKhMEtwWy2qfUWPtPo3UrzjEb+AKIFZmYuiG0tfuL9DhSU3Q/jsufR5YldYRj2J6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA2LTI3IGF0IDE3OjE1IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBXZWQsIEp1biAxMSwgMjAyNSBhdCA1OjAy4oCvUE0gSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29n
bGUuY29tPiB3cm90ZToNCj4gPiANCj4gPiBVcGRhdGU6DQo+ID4gIC0gQURML0FETE4gdjEuMjkg
LT4gMS4zMQ0KPiA+ICAtIEFSTCAxLjA4IC0+IDEuMDkNCj4gPiAgLSBDTFggMS4yMyAtPiAxLjI1
DQo+ID4gIC0gRU1SIDEuMTEgLT4gMS4xNA0KPiA+ICAtIEdSUiAxLjA3IC0+IDEuMDkNCj4gPiAg
LSBHTlIgMS4wOCAtPiAxLjEwDQo+ID4gIC0gSUNYIDEuMjcgLT4gMS4yOA0KPiA+ICAtIExOTCAx
LjExIC0+IDEuMTQNCj4gPiAgLSBNVEwgMS4xMyAtPiAxLjE0DQo+ID4gIC0gUFRMIG5ldyB2MS4w
MA0KPiA+ICAtIFNQUiAxLjI1IC0+IDEuMjgNCj4gPiAgLSBTUkYgMS4wOSAtPiAxLjExDQo+ID4g
IC0gU0tYIDEuMzYgLT4gMS4zNw0KPiA+ICAtIFRHTCAxLjE3IC0+IDEuMTgNCj4gPiANCj4gPiBV
cGRhdGVzIGZyb206DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL3BlcmZtb24NCj4gPiB3
aXRoOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9wZXJmbW9uL3B1bGwvMzEyDQo+ID4g
UnVubmluZyB0aGUgc2NyaXB0Og0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9wZXJmbW9u
L2Jsb2IvbWFpbi9zY3JpcHRzL2NyZWF0ZV9wZXJmX2pzb24ucHkNCj4gDQo+IEhpLCB0aGVzZSBJ
bnRlbCBldmVudCB1cGRhdGVzIGFyZSBzdGlsbCBhd2FpdGluZyByZXZpZXcuDQo+IA0KPiBUaGFu
a3MsDQo+IElhbg0KDQpIaSBJYW4sIG5vdCBzdXJlIHdoYXQgaGFwcGVuZWQgYnV0IEkgY2FuJ3Qg
ZmluZCB0aGlzIHNlcmllcyBpbiBteSBpbmJveC4gQ291bGQgeW91IHJlc2VuZCBpdD8NCg0KVGhh
bmtzLA0KVG9tDQoNCj4gDQo+ID4gSWFuIFJvZ2VycyAoMTUpOg0KPiA+ICAgcGVyZiB2ZW5kb3Ig
ZXZlbnRzOiBVcGRhdGUgQWxkZXJsYWtlIGV2ZW50cw0KPiA+ICAgcGVyZiB2ZW5kb3IgZXZlbnRz
OiBVcGRhdGUgQWxkZXJsYWtlTiBldmVudHMNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBk
YXRlIEFycm93bGFrZSBldmVudHMNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIENh
c2NhZGVsYWtlWCBldmVudHMNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIEVtZXJh
bGRSYXBpZHMgZXZlbnRzDQo+ID4gICBwZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBHcmFuZFJp
ZGdlIGV2ZW50cw0KPiA+ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUgR3Jhbml0ZVJhcGlk
cyBldmVudHMNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIEljZWxha2VYIGV2ZW50
cw0KPiA+ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUgTHVuYXJMYWtlIGV2ZW50cw0KPiA+
ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUgTWV0ZW9yTGFrZSBldmVudHMNCj4gPiAgIHBl
cmYgdmVuZG9yIGV2ZW50czogQWRkIFBhbnRoZXJMYWtlIGV2ZW50cw0KPiA+ICAgcGVyZiB2ZW5k
b3IgZXZlbnRzOiBVcGRhdGUgU2FwcGhpcmVSYXBpZHMgZXZlbnRzDQo+ID4gICBwZXJmIHZlbmRv
ciBldmVudHM6IFVwZGF0ZSBTaWVycmFGb3Jlc3QgZXZlbnRzDQo+ID4gICBwZXJmIHZlbmRvciBl
dmVudHM6IFVwZGF0ZSBTa3lsYWtlWCBldmVudHMNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50czog
VXBkYXRlIFRpZ2VyTGFrZSBldmVudHMNCj4gPiANCj4gPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94
ODYvYWxkZXJsYWtlL2NhY2hlLmpzb24gIHwgIDU2ICsrLQ0KPiA+ICAuLi4vYXJjaC94ODYvYWxk
ZXJsYWtlL2Zsb2F0aW5nLXBvaW50Lmpzb24gICAgfCAgIDEgLQ0KPiA+ICAuLi4vcG11LWV2ZW50
cy9hcmNoL3g4Ni9hbGRlcmxha2Uvb3RoZXIuanNvbiAgfCAgIDEgLQ0KPiA+ICAuLi4vYXJjaC94
ODYvYWxkZXJsYWtlL3BpcGVsaW5lLmpzb24gICAgICAgICAgfCAgNDQgKy0tDQo+ID4gIC4uLi9h
cmNoL3g4Ni9hbGRlcmxha2UvdmlydHVhbC1tZW1vcnkuanNvbiAgICB8ICAgMyAtDQo+ID4gIC4u
Li9wbXUtZXZlbnRzL2FyY2gveDg2L2FsZGVybGFrZW4vY2FjaGUuanNvbiB8ICA1MiArLS0NCj4g
PiAgLi4uL2FyY2gveDg2L2FsZGVybGFrZW4vZmxvYXRpbmctcG9pbnQuanNvbiAgIHwgICAxIC0N
Cj4gPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvYWxkZXJsYWtlbi9vdGhlci5qc29uIHwgICAx
IC0NCj4gPiAgLi4uL2FyY2gveDg2L2FsZGVybGFrZW4vcGlwZWxpbmUuanNvbiAgICAgICAgIHwg
IDQyICstLQ0KPiA+ICAuLi4vYXJjaC94ODYvYWxkZXJsYWtlbi92aXJ0dWFsLW1lbW9yeS5qc29u
ICAgfCAgIDMgLQ0KPiA+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9hcnJvd2xha2UvY2FjaGUu
anNvbiAgfCAgMTMgKy0NCj4gPiAgLi4uL2FyY2gveDg2L2Fycm93bGFrZS9mcm9udGVuZC5qc29u
ICAgICAgICAgIHwgMTM1ICsrKysrKysrDQo+ID4gIC4uLi9hcmNoL3g4Ni9jYXNjYWRlbGFrZXgv
ZmxvYXRpbmctcG9pbnQuanNvbiB8ICAgNiArLQ0KPiA+ICAuLi4vYXJjaC94ODYvY2FzY2FkZWxh
a2V4L3BpcGVsaW5lLmpzb24gICAgICAgfCAgIDIgKy0NCj4gPiAgLi4uL2FyY2gveDg2L2VtZXJh
bGRyYXBpZHMvcGlwZWxpbmUuanNvbiAgICAgIHwgICAyICstDQo+ID4gIC4uLi9hcmNoL3g4Ni9l
bWVyYWxkcmFwaWRzL3VuY29yZS1pby5qc29uICAgICB8ICAxMiArDQo+ID4gIC4uLi9hcmNoL3g4
Ni9lbWVyYWxkcmFwaWRzL3VuY29yZS1tZW1vcnkuanNvbiB8ICAyMCArKw0KPiA+ICAuLi4vYXJj
aC94ODYvZ3JhbmRyaWRnZS9ncnItbWV0cmljcy5qc29uICAgICAgfCAgMzAgKy0NCj4gPiAgLi4u
L3g4Ni9ncmFuZHJpZGdlL3VuY29yZS1pbnRlcmNvbm5lY3QuanNvbiAgIHwgIDEwICsNCj4gPiAg
Li4uL2FyY2gveDg2L2dyYW5kcmlkZ2UvdW5jb3JlLWlvLmpzb24gICAgICAgIHwgIDEyICsNCj4g
PiAgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMvY2FjaGUuanNvbiAgICAgICAgIHwgICA5ICsN
Cj4gPiAgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMvY291bnRlci5qc29uICAgICAgIHwgIDEw
ICstDQo+ID4gIC4uLi9hcmNoL3g4Ni9ncmFuaXRlcmFwaWRzL2duci1tZXRyaWNzLmpzb24gICB8
ICAzNiArKw0KPiA+ICAuLi4vYXJjaC94ODYvZ3Jhbml0ZXJhcGlkcy9waXBlbGluZS5qc29uICAg
ICAgfCAgIDIgKy0NCj4gPiAgLi4uL2dyYW5pdGVyYXBpZHMvdW5jb3JlLWludGVyY29ubmVjdC5q
c29uICAgIHwgIDE5IC0NCj4gPiAgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMvdW5jb3JlLWlv
Lmpzb24gICAgIHwgIDI3ICstDQo+ID4gIC4uLi9hcmNoL3g4Ni9pY2VsYWtleC9waXBlbGluZS5q
c29uICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICAuLi4vYXJjaC94ODYvaWNlbGFrZXgvdW5jb3Jl
LWNhY2hlLmpzb24gICAgICAgfCAgIDIgLQ0KPiA+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9s
dW5hcmxha2UvY2FjaGUuanNvbiAgfCAgMTEgKw0KPiA+ICAuLi4vYXJjaC94ODYvbHVuYXJsYWtl
L3BpcGVsaW5lLmpzb24gICAgICAgICAgfCAgMTggKy0NCj4gPiAgLi4uL2FyY2gveDg2L2x1bmFy
bGFrZS92aXJ0dWFsLW1lbW9yeS5qc29uICAgIHwgIDE4IC0NCj4gPiAgdG9vbHMvcGVyZi9wbXUt
ZXZlbnRzL2FyY2gveDg2L21hcGZpbGUuY3N2ICAgIHwgIDI5ICstDQo+ID4gIC4uLi9wbXUtZXZl
bnRzL2FyY2gveDg2L21ldGVvcmxha2UvY2FjaGUuanNvbiB8ICAgMiArLQ0KPiA+ICAuLi4vYXJj
aC94ODYvbWV0ZW9ybGFrZS9mcm9udGVuZC5qc29uICAgICAgICAgfCAgNzIgKysrKw0KPiA+ICAu
Li4vYXJjaC94ODYvbWV0ZW9ybGFrZS9waXBlbGluZS5qc29uICAgICAgICAgfCAgIDIgKy0NCj4g
PiAgLi4uL2FyY2gveDg2L3BhbnRoZXJsYWtlL2NhY2hlLmpzb24gICAgICAgICAgIHwgMjc4ICsr
KysrKysrKysrKysrKw0KPiA+ICAuLi4vYXJjaC94ODYvcGFudGhlcmxha2UvY291bnRlci5qc29u
ICAgICAgICAgfCAgMTIgKw0KPiA+ICAuLi4vYXJjaC94ODYvcGFudGhlcmxha2UvZnJvbnRlbmQu
anNvbiAgICAgICAgfCAgMzAgKysNCj4gPiAgLi4uL2FyY2gveDg2L3BhbnRoZXJsYWtlL21lbW9y
eS5qc29uICAgICAgICAgIHwgMjE1ICsrKysrKysrKysrKw0KPiA+ICAuLi4vYXJjaC94ODYvcGFu
dGhlcmxha2UvcGlwZWxpbmUuanNvbiAgICAgICAgfCAzMjUgKysrKysrKysrKysrKysrKysrDQo+
ID4gIC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS92aXJ0dWFsLW1lbW9yeS5qc29uICB8ICA2MiAr
KysrDQo+ID4gIC4uLi9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy9waXBlbGluZS5qc29uICAgICB8
ICAgMiArLQ0KPiA+ICAuLi4vYXJjaC94ODYvc2FwcGhpcmVyYXBpZHMvdW5jb3JlLWlvLmpzb24g
ICAgfCAgMTIgKw0KPiA+ICAuLi4veDg2L3NhcHBoaXJlcmFwaWRzL3VuY29yZS1tZW1vcnkuanNv
biAgICAgfCAgMjAgKysNCj4gPiAgLi4uL2FyY2gveDg2L3NpZXJyYWZvcmVzdC9mcm9udGVuZC5q
c29uICAgICAgIHwgIDY0ICsrKysNCj4gPiAgLi4uL2FyY2gveDg2L3NpZXJyYWZvcmVzdC9waXBl
bGluZS5qc29uICAgICAgIHwgICA4ICsNCj4gPiAgLi4uL2FyY2gveDg2L3NpZXJyYWZvcmVzdC9z
cmYtbWV0cmljcy5qc29uICAgIHwgIDQ4ICsrKw0KPiA+ICAuLi4vYXJjaC94ODYvc2llcnJhZm9y
ZXN0L3VuY29yZS1jYWNoZS5qc29uICAgfCAgIDYgKy0NCj4gPiAgLi4uL3g4Ni9zaWVycmFmb3Jl
c3QvdW5jb3JlLWludGVyY29ubmVjdC5qc29uIHwgIDUzICsrLQ0KPiA+ICAuLi4vYXJjaC94ODYv
c2llcnJhZm9yZXN0L3VuY29yZS1pby5qc29uICAgICAgfCAgMjcgKy0NCj4gPiAgLi4uL2FyY2gv
eDg2L3NreWxha2V4L3BpcGVsaW5lLmpzb24gICAgICAgICAgIHwgICAyICstDQo+ID4gIC4uLi9h
cmNoL3g4Ni90aWdlcmxha2UvcGlwZWxpbmUuanNvbiAgICAgICAgICB8ICAgMiArLQ0KPiA+ICA1
MiBmaWxlcyBjaGFuZ2VkLCAxNjIzIGluc2VydGlvbnMoKyksIDI0OCBkZWxldGlvbnMoLSkNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9wYW50
aGVybGFrZS9jYWNoZS5qc29uDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3Bt
dS1ldmVudHMvYXJjaC94ODYvcGFudGhlcmxha2UvY291bnRlci5qc29uDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvcGFudGhlcmxha2UvZnJv
bnRlbmQuanNvbg0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcGVyZi9wbXUtZXZlbnRz
L2FyY2gveDg2L3BhbnRoZXJsYWtlL21lbW9yeS5qc29uDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvcGFudGhlcmxha2UvcGlwZWxpbmUuanNv
bg0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gveDg2
L3BhbnRoZXJsYWtlL3ZpcnR1YWwtbWVtb3J5Lmpzb24NCj4gPiANCj4gPiAtLQ0KPiA+IDIuNTAu
MC5yYzEuNTkxLmc5Yzk1ZjE3ZjY0LWdvb2cNCj4gPiANCg0K
