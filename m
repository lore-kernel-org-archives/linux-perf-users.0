Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D24C79;
	Sun,  9 Jun 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717902149; cv=fail; b=UzyRe5Nzm5QjiS7OtieqXX3MHh71SmQCSQlLaiOgKMgXUNfwqOVQ26J7E7snaA/XGGiPuc2+8fPNVPL79dSf/eLjrX9YwlACkHzMXcmqpC9mY0YA3TPXZZuRXTqWEHfE3pZrFt41mGi/hajoEqyQYWLDsy9TICYGOJIH5G9S7Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717902149; c=relaxed/simple;
	bh=/MZPI+iq0//moWrMlvkXYw54m5lrCopsI/s1GYODoQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kaRAzrQcdDA1zFloT8xuIo0sIHSW3O4fJ5UfOWQW0TYA+fG0XOUVWjUSFSsQkhtYW78RVMyJUaBTIYdxKwoSHe0dMq9v/WrTsHwYUkuVoaag6RKZ5E+u704GJ09PCBJ60gzMq1FqkMq/yNmEuAUlvfhAdOTCgnbPpmpkGCkaghU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iASxSXpN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iASxSXpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717902148; x=1749438148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/MZPI+iq0//moWrMlvkXYw54m5lrCopsI/s1GYODoQQ=;
  b=iASxSXpND8e7YYhjzSSUG+CqlhGcWjT68B+v0SyW2B7YJAmDDBbeom+Z
   H/OHIJoBt9XglCpsq6apIm3fjkF4YQPV2ZhcqQfAvzdrr/C6tTTz1OMu0
   FPV/Eqk57A/9pPjdgNCaGpFWxZdz28le6ghk5LuLi6ZR6mCWHUpxn3UKG
   SHE9HOUirrXik1FRp2HmS6yqRcBMi4QFs+37neST/sNM6Dyozizy3FPjW
   5TVo62puV3H6NH3fAFgVDEzzU+z7OgB1EljhIFX+kQb/O+gpjgmDVhscv
   HkSQgk/++K5z7AfYmiac28OIN79Yrja9yD2zQaGvD6mHjg/xuIa7+xtGW
   w==;
X-CSE-ConnectionGUID: SBc4hVW8Ra6fFvw4uKpQrg==
X-CSE-MsgGUID: 7raKJ3vqT/qgf2jrEkkSVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="37119037"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="37119037"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 20:02:27 -0700
X-CSE-ConnectionGUID: 2psrvmZlQnKzxoeVjx4sBQ==
X-CSE-MsgGUID: mn2bpr5PSfOSYz0aOHSsPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="43142055"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jun 2024 20:02:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 8 Jun 2024 20:02:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 8 Jun 2024 20:02:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 8 Jun 2024 20:02:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 8 Jun 2024 20:02:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+q/YoqedTBQYwY9/DuYa6uBbH67zQ8o4qOk1O81S3Z2eGMGZUQmPaU7+E78iWgb+tELjjP8Qyr6AcXynUbe+PPCVl9oEqRtS2SVgtZt2oxPtn/k4fpeIgNcsIGAEPUAVRDJ5CXkOVs0DryAwcqvMkQe/90FmpYCIxSDNbc298b/f83el8Mnq0dXPLm2OLxm0Q/utBqFoeSHoID7BFdRmPsMPlqXWCeCTX2bUe+TU2/ip8obnM1Zj3t78cMb3jctOdp4WJ+bhrVlPyjJcOgH7/wfvANNXzrRkFd+C/5xbxYHa04VwxMXdRsp+hPfOX3n3sDSw1LwBbRSA4H+xhHn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MZPI+iq0//moWrMlvkXYw54m5lrCopsI/s1GYODoQQ=;
 b=KquJk9U6bm5rG3ViPuRO7zuhnCoFSZ0jSWluZlN8pcBxzIuf9J59bv09eDxk6NwxCeItEWSXprzMBf2j4QpQWsTKxmmlR5zYHTyEN9Fd8Hlz8MLkd5dsvNlhaskGy0kvq3TMu7X8pyYmAQ9vP1NK0bUpYAOeGXSmoIMeRv056VqqTIN4Weo19VCSgC6ivDhEYHW5kr7YOzPz6Vdi1tMJbpRiOek4gHrVLwSM1htAA32evGlmpXK27AMHkrWN6gXEQcn0/DgBBAsJVcFbwMeMuUzDqv8FrNrDp0nDPHFFnSVi5JS0+46tc6IKQxIsslVvkgg/Sa6zPo/f+BrjVjBxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sun, 9 Jun
 2024 03:02:21 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.036; Sun, 9 Jun 2024
 03:02:21 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v11 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v11 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHatwhYLgt04LjuOUSuuxjoMN6UbbG7Yi6AgAAZqpCAATV8gIAAFcLAgAH0HwCAAAgtMA==
Date: Sun, 9 Jun 2024 03:02:21 +0000
Message-ID: <CO6PR11MB5635B74E5C5FFE7182501DCBEEC52@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240605052200.4143205-1-weilin.wang@intel.com>
 <20240605052200.4143205-4-weilin.wang@intel.com>
 <ZmJEP_42Ehlt-c-6@google.com>
 <CO6PR11MB56350EA26F8AD92B222C528DEEFB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZmNdYwAxlXkQ8WJt@google.com>
 <CO6PR11MB5635DC04091BBE1FEC59642DEEFB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZmUTLOeLcdYs-cqe@google.com>
In-Reply-To: <ZmUTLOeLcdYs-cqe@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|LV3PR11MB8603:EE_
x-ms-office365-filtering-correlation-id: aee922a4-b3ba-4753-69c7-08dc883094c8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YXpaUkpqZktZYU1OY3hIU3grVU56cE1wOU5oMEN2a0VBZm1aZExmMnVERzB4?=
 =?utf-8?B?UHgrcU45MUJoa2p0SjZiWGIyN05kUHB6bHpUOW10ZHdtd1BBL0QyN0pQaUxh?=
 =?utf-8?B?OU5xVHAxNm10V0xjZnpsaU1kRzU2eGhtbW1oeTM4U3RaWWpqU05DMHQ4WC9O?=
 =?utf-8?B?VVhYV0svWEdCTWRtV25VUC9VU3hHTEZQMlcyRjVIL1ZtTk9Qejl5cXN1a1hJ?=
 =?utf-8?B?dk9VOSs2V3dXVjQwdnl0SSs2cVNxMEZ5dlZQbyswdVY0b1V2bDZYSDlIZWJB?=
 =?utf-8?B?MEE3VmhyWGRtTkxXV1h4a002SkpZTUJ5VW9UNW1rUTlKK2QrRmFVOGpINFNZ?=
 =?utf-8?B?VFlXV1NjRVJsdElNd0ZhVVVINEFPdlRvNlFkMldZQUQ0NjBnaFRzTUcyM28v?=
 =?utf-8?B?QzlaYjE1TlN6QTBNMTF0emJDdDVXMVVDNGlYYWNzSENSbUN2NkI2blBjajhT?=
 =?utf-8?B?djVpWmpGbFFpTUphNlEwSno3ZkJic1ozZ1ZTOHU3RVZuMnFxaGFzdVBZYXFM?=
 =?utf-8?B?YVhYUmZxZVZHdEN0SU9ncit3QXFkMzVxYTZLSjlITkkzOWpWM05remcveno0?=
 =?utf-8?B?QUtrUVl3Vm1IbVdKUE13QXM5OTMzUGVsOHk1eDFnUXpacE56MFJ3c25DVzJE?=
 =?utf-8?B?VXFGRmx0U0pHQlIydjZVQUtNRW82anZtNkRnSmR6RmZjUTg2dklHYkVvT0ZO?=
 =?utf-8?B?NlcrYXdwUE80MUtKL0E3YTFQNzdyL0dNYjQzTncwdFhjUkRRcEJHTEVJTVZV?=
 =?utf-8?B?Vm1ZdHp4K1RaM1N0dTR1YWc3SDZ4b2xGenZETjcyQjYxTFNINWhMSWtuSmNl?=
 =?utf-8?B?a0ZwK25YREdoQlRTNW8xL0x1emFYZUVGSkpGN2lTZkU4d00rUFpjaHBJZzk0?=
 =?utf-8?B?Y3NmVytLTHpCZ0xZZWFvVGpVK0F4VHFpNFV4Um0vdnIrcHVBakRZeGZwMzdk?=
 =?utf-8?B?M0RnL3ZZL3Ywa0NabVoyZ0VDdmhJLytrZ1FiY2JscmNPRDJhamZMRTRRNDdh?=
 =?utf-8?B?Skd6UVJZZko2Y3RwRHE3M0J6ZU83QjRPMVI5bE1zbXUxRlpGRkRadHRoTFh5?=
 =?utf-8?B?OUlhNHhKRFEvZTlvNXN6bzYxbXo0bXJUclNUZzk0ZVhaZVRJQytYYm9tdzhG?=
 =?utf-8?B?MHkvWlh3ZUtjM1ZFZ1p3eTdlRVVPN3llMTJpMEpZbHlhaDRxK25FMTArRkVq?=
 =?utf-8?B?RnhxUlE0ZW93ZmdONUtlV3dQdGJ6VTEzMGZ6VjFiM1dCU3FNYm1SSWtYb0Nm?=
 =?utf-8?B?bXFpUjdsMitrdEh5blZuYUtsV1d3aWk5SU91bVJFR1ZhTXlMZmNxZUE3c1da?=
 =?utf-8?B?ajFEWTVCU1BvSkFOMkh3aDRDRGJ2T1VCWVBBcGsrTWFpMGQwOGFOVU16V2RP?=
 =?utf-8?B?YVk2UXZTNnUzaWtrb2tuc2FJY0FDRkU5QVY2U09UK1FwTnc0WUNpcHVrSWw3?=
 =?utf-8?B?bWoySlUvT2dJbXB3K3dmYjlJMEFsZi9Sa25HdVNob3V5ekQ0RVNsajQ3eW4w?=
 =?utf-8?B?SC8ybUNkU2o5WFpwdXVGNzI3amtNcnZPSUMxOHJSWGdPalRPSk04N2ZxYytO?=
 =?utf-8?B?UFNmZ3d1eG8vcGlnTFRTS0FrL2cwcU5EU2dTQ1Y4cWtiWXYySEg1QWZqRzMr?=
 =?utf-8?B?UkhldXFhK2thaW1TVDlPZXZnYjI2ZUVLblNtL2xrcEJoMG4yenB1bEZSZWx6?=
 =?utf-8?B?amd2aW03OWFCN3BkUjdoSWY5TzRTVGRKakFFVUppd0tyUW04OVVXc2JXMzRN?=
 =?utf-8?Q?gMuN91RE2vVsLCUIIPjJkB2mEK1oRIKndcMfmhs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUJINlVWRVhrSTh5T0RuNFo4SjIxSFNrdmVCZFVleXZXNU1UcU1uaEwvTDFm?=
 =?utf-8?B?OTJiZE5OekpKOXJuUzNyb3pBUjl0V29scloraTRjYnVhN25XaUJ6dkNvREpi?=
 =?utf-8?B?ZzhXKzZGRDFLVHdLc3NrZ0sydUhXMkJqdVhVRWQyUzJ3S2hLT0F2K0VMVjh6?=
 =?utf-8?B?WnhhOGlOMTRBa203WEV0MThDM3VvZlZGSm55UityL09PYk5JV3E1NWFkSWFo?=
 =?utf-8?B?V1ZCSUJrK2Vobis1Rk5lL1RpK2tlcE5LMUYzcE9QMjRnemd0bXJ5d0U5RVpr?=
 =?utf-8?B?WVBtUm5Tb3g4UlFlb3RiSFYvaUNKTTVXeWYrd0V2Wi94SGVkWUJOTm9UNmJQ?=
 =?utf-8?B?UjdlUncwOVZrTjVjNTFKUmRtQjlLV25DWkl3YnJyQ1R2dE0rRUpJQ2FCNXl2?=
 =?utf-8?B?VHRVcUMzd2FKSW0xUStxYVpYb3dmY2djOUxtb1NaQk8yQkhmaFNtM0dGb3o1?=
 =?utf-8?B?ZFdpT0Fjdmp5ZEFQQWF2c0cyZUZkSnBKQmlZb0Z6Z1pzMnhzNm5FWDlxa1U4?=
 =?utf-8?B?VHRaTUdzYXpiR3pSY2ozbDlBd1RySG5TNU9sazNVYm4zNm95dXRzUzBCRUJN?=
 =?utf-8?B?WmZDanc3WG5rWkFuTm1FWkFpVlVGRXRvYlIvMklXbkZUaFptSUs5LzBCQlRx?=
 =?utf-8?B?OFJlbWV5S0hJRE8vbkNKb1ppRmsxdWhaYUtPcUtOblQva2JaYXA2b05kcmRB?=
 =?utf-8?B?SUFxWkdmWHNMZ2F4UnNSVWVFRnBLZmVTUlJxQkpQcUk0Z24vYzZmRlo4MTV1?=
 =?utf-8?B?enFXemljS2V4aVowSURXYTlQU3d2YmROaUFucUd1MHZ6MHdabmRyUm9Lblkx?=
 =?utf-8?B?SExwSmN0M1MzQzlmRFRVNGl5LzFFZG9ZMlplbjB4WTBMTWozQzV0N1lZVGty?=
 =?utf-8?B?QXVBTngwNWEwTEo3VU9XVFJNWkRlYThoS0ZrMEdsT0MvREtIRGFQWjJndjVl?=
 =?utf-8?B?VnVEQW91eVcxZnRlZmNwaFA5T0kzV3A3MmN4QXc1bXJnVjU4bmhJbEdoVjNi?=
 =?utf-8?B?S2JoWXB5ZDBYaWpLQmNrT2R4QW54QjVXUWw0c2hxY3VpQlFkcUVDU1J6amNK?=
 =?utf-8?B?eThORldjUC9keWFIS1hPbEJJbDlDbHQ0Z1BXRmE2MEo5cHM5Wk1YMHNqZWNm?=
 =?utf-8?B?cnExZGxUdm5WU1JUajhiaDNZaWRnUzZlem5LTFNydTJMUnpzazVPd3VobkRL?=
 =?utf-8?B?T1pvMmdZbkhwYzNzUDFPamVkYUJYUVJqdkRQQ2MxQkdORWlJQ0YvR2xpazRK?=
 =?utf-8?B?d1RHdW13VDZuZE9mNExlNzZXQ0dJUGtSMVdpTHNFcmZXRVZ3VHFzTG10ZmNI?=
 =?utf-8?B?R3lYeUl1a3VNVlJvbml0OUVDYW0rUnFSSXErakFXL1FjWUtnNDk0eXNXODVF?=
 =?utf-8?B?UFAzNkxicXdOcmx1WUFKTVV3ZEpyMjE3UDlDcUdJT0Y5OUM4ODZUSVVZc3Y2?=
 =?utf-8?B?cFo0cjVIN0UxUDlhd216azBPN3Nubmx6L012SEhDdEQwU2tlR0dpV0Erd2tE?=
 =?utf-8?B?VlhyY29DYkxBeDU5dDF6Y3FGWG8xamhvK0lNQXVmU0tzRVlkTmQwZmx3anpC?=
 =?utf-8?B?dHphS0dQWUxJd0FwNjAvY1NKZEhJTm9PaDM4cHpuVE9zQjdkMW16K2g5cmZh?=
 =?utf-8?B?Y3J5WDFKU0g0UUE5dkFLRlNUSzhjMU1vaUxIbVRmL2NkdDcyQWRRbDZhYnQx?=
 =?utf-8?B?ZmNQUVRuRjJwTG16NmRRd2hFS2lnT3ZkZEhLZ1p5VFNJdG1HMHU5ZXBua0Q3?=
 =?utf-8?B?L3ZUWFhZcFVzcFBHYk45RlNjalE3RFI5UWJ0dzFBdjVwNnpPS1RmMXVwWnR0?=
 =?utf-8?B?TmhwaC9FRmdTeW9UeGhJbGFTQ0pkZXJ1RUI3MlpkdFp0cGJmTlpnT1o3L3dQ?=
 =?utf-8?B?U3RDaEVuNW9LSXNIZlhEbU90dVZqUkROdVZ1c1VlMkpJclZ4UlhkV09WS1FW?=
 =?utf-8?B?V2Y2ZGZrajBJbVdtTVpUaXFlTlJQQnhreXBJdTlHUFQvM0FkZjNEb2xJWlpM?=
 =?utf-8?B?dlhmeGJacVB2U1NieG5SWHJ2U2xCNnNvNFdZakxsS2xGRExvRWxRZWEwTnlp?=
 =?utf-8?B?VHgyay9kdThIVjVWWmpETit5VjFXWFRsYjRBRUtldmZhcXprM21pbXo0Y3Nv?=
 =?utf-8?Q?jMAsjwAxsQJghzrp2AblFFbqo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aee922a4-b3ba-4753-69c7-08dc883094c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2024 03:02:21.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ecj93GSHP39wqwGv2EbsQ5Pg8zhpvlukwm5T7QSh+Kb8fN7a4J8wJz9M07f1MKT60HNA2T7EHVh3RjbGQdszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgSnVuZSA4LCAyMDI0IDc6Mjgg
UE0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzogSWFu
IFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+
IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FA
a2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYtdXNl
cnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3Is
IFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50
aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjExIDMvOF0gcGVyZiBzdGF0OiBGb3Jr
IGFuZCBsYXVuY2ggcGVyZiByZWNvcmQgd2hlbg0KPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJl
dGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJpYy4NCj4gDQo+IE9uIEZyaSwgSnVuIDA3LCAy
MDI0IGF0IDA4OjQ1OjEzUE0gKzAwMDAsIFdhbmcsIFdlaWxpbiB3cm90ZToNCj4gPg0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTmFtaHl1bmcgS2lt
IDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogRnJpZGF5LCBKdW5lIDcsIDIwMjQg
MTI6MjAgUE0NCj4gPiA+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4N
Cj4gPiA+IENjOiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZh
bGhvIGRlIE1lbG8NCj4gPiA+IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5hcg0KPiA+ID4gPG1pbmdvQHJlZGhhdC5jb20+
OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4gPiA+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50
ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgSHVudGVyLA0KPiA+ID4gQWRy
aWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4
LmludGVsLmNvbT47DQo+ID4gPiBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9yLA0KPiBQZXJyeQ0KPiA+ID4gPHBlcnJ5
LnRheWxvckBpbnRlbC5jb20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRoYS5hbHRAaW50ZWwuY29t
PjsNCj4gQmlnZ2VycywNCj4gPiA+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVsLmNvbT4NCj4g
PiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxMSAzLzhdIHBlcmYgc3RhdDogRm9yayBhbmQg
bGF1bmNoIHBlcmYgcmVjb3JkDQo+IHdoZW4NCj4gPiA+IHBlcmYgc3RhdCBuZWVkcyB0byBnZXQg
cmV0aXJlIGxhdGVuY3kgdmFsdWUgZm9yIGEgbWV0cmljLg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwg
SnVuIDA3LCAyMDI0IGF0IDAxOjA3OjEyQU0gKzAwMDAsIFdhbmcsIFdlaWxpbiB3cm90ZToNCj4g
W1NOSVBdDQo+ID4gPiA+ID4gPiBAQCAtMjE4Niw2ICsyMjQwLDkgQEAgc3RhdGljIGludCBldnNl
bF9fb3Blbl9jcHUoc3RydWN0IGV2c2VsDQo+ICpldnNlbCwNCj4gPiA+ID4gPiBzdHJ1Y3QgcGVy
Zl9jcHVfbWFwICpjcHVzLA0KPiA+ID4gPiA+ID4gIAkJcmV0dXJuIDA7DQo+ID4gPiA+ID4gPiAg
CX0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArCWlmIChldnNlbF9faXNfcmV0aXJlX2xhdChl
dnNlbCkpDQo+ID4gPiA+ID4gPiArCQlyZXR1cm4gdHBlYnNfc3RhcnQoZXZzZWwtPmV2bGlzdCwg
Y3B1cyk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBcyBpdCB3b3JrcyB3aXRoIGV2bGlzdCwgSSB0
aGluayBpdCdzIGJldHRlciB0byBwdXQgdGhpcyBjb2RlIHRoZXJlLg0KPiA+ID4gPiA+IEJ1dCBp
dCBzZWVtcyBwZXJmIHN0YXQgZG9lc24ndCBjYWxsIHRoZSBldmxpc3QgQVBJIGZvciBvcGVuLCB0
aGVuIHdlDQo+ID4gPiA+ID4gY2FuIGFkZCB0aGlzIHRvIHNvbWV3aGVyZSBpbiBfX3J1bl9wZXJm
X3N0YXQoKSBkaXJlY3RseS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4g
IAllcnIgPSBfX2V2c2VsX19wcmVwYXJlX29wZW4oZXZzZWwsIGNwdXMsIHRocmVhZHMpOw0KPiA+
ID4gPiA+ID4gIAlpZiAoZXJyKQ0KPiA+ID4gPiA+ID4gIAkJcmV0dXJuIGVycjsNCj4gPiA+ID4g
PiA+IEBAIC0yMzc2LDYgKzI0MzMsOCBAQCBpbnQgZXZzZWxfX29wZW4oc3RydWN0IGV2c2VsICpl
dnNlbCwgc3RydWN0DQo+ID4gPiA+ID4gcGVyZl9jcHVfbWFwICpjcHVzLA0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ICB2b2lkIGV2c2VsX19jbG9zZShzdHJ1Y3QgZXZzZWwgKmV2c2VsKQ0KPiA+
ID4gPiA+ID4gIHsNCj4gPiA+ID4gPiA+ICsJaWYgKGV2c2VsX19pc19yZXRpcmVfbGF0KGV2c2Vs
KSkNCj4gPiA+ID4gPiA+ICsJCXRwZWJzX2RlbGV0ZSgpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
RGl0dG8uDQo+ID4gPiA+DQo+ID4gPiA+IEhpIE5hbWh5dW5nLA0KPiA+ID4gPg0KPiA+ID4gPiBJ
IGhvcGUgYm90aCB0aGlzIGFuZCB0aGUgb25lIGFib3ZlIG9uIG9wZW4gY291bGQgc3RheSBpbiBl
dnNlbCBsZXZlbA0KPiBiZWNhdXNlDQo+ID4gPiA+IHRoZXNlIGFyZSBvcGVyYXRpb25zIG9uIHJl
dGlyZV9sYXRlbmN5IGV2c2VsLg0KPiA+ID4NCj4gPiA+IFRoZW4gSSB0aGluayB5b3UgbmVlZCB0
byByZW1vdmUgdGhlIHNwZWNpZmljIGV2c2VsIG5vdCB0aGUgYWxsIHRwZWJzDQo+ID4gPiBldmVu
dHMuDQo+ID4gPg0KPiA+ID4gPiBBdCB0aGUgc2FtZSB0aW1lLCBhIGxvdCBvZiB0aGUNCj4gPiA+
ID4gcHJldmlvdXMgc2V2ZXJhbCB2ZXJzaW9ucyBvZiB3b3JrIHdhcyB0byBtb3ZlIFRQRUJTIGNv
ZGUgb3V0IGZyb20gcGVyZg0KPiA+ID4gc3RhdCB0bw0KPiA+ID4gPiBldnNlbCB0byBtYWtlIGl0
IG1vcmUgZ2VuZXJpYy4gSSB0aGluayBtb3ZlIHRoZXNlIGJhY2sgdG8NCj4gX19ydW5fcGVyZl9z
dGF0KCkNCj4gPiA+IGFyZQ0KPiA+ID4gPiBvcHBvc2l0ZSB0byB0aGF0IGdvYWwuDQo+ID4gPg0K
PiA+ID4gT2gsIEkgbWVhbnQgeW91IGNhbiBoYXZlIHRoZSBsb2dpYyBpbiB1dGlscy9pbnRlbC10
cGVicy5jIGJ1dCBhZGQgYSBjYWxsDQo+ID4gPiB0byB0cGVic19kZWxldGUoKSBpbiBfX3J1bl9w
ZXJmX3N0YXQoKS4gIEkgdGhpbmsgaXQnZCBiZXR0ZXIgdG8ga2VlcCBpdA0KPiA+ID4gaW4gZXZs
aXN0X19jbG9zZSgpIGJ1dCB3ZSBkb24ndCB1c2UgZXZsaXN0X19vcGVuKCkgZm9yIHBlcmYgc3Rh
dCBzbyBpdCdzDQo+ID4gPiBub3Qgc3ltbWV0cmljLiA6KA0KPiA+ID4NCj4gPiA+IEFueXdheSwg
YWxsIEkgd2FudCB0byBzYXkgaXMgdGhhdCB0cGVicyBBUElzIHdvcmsgb24gZXZsaXN0IGxldmVs
LiAgU28gSQ0KPiA+ID4gdGhpbmsgaXQncyBuYXR1cmFsIHRoYXQgdGhleSBhcmUgY2FsbGVkIGZv
ciB0aGUgd2hvbGUgbGlzdCwgbm90IGZvciBhbg0KPiA+ID4gZXZlbnQvZXZzZWwuDQo+ID4NCj4g
PiBJIHRoaW5rIHdlJ3JlIHRyeWluZyB0byB3b3JrIGF0IGV2c2VsIGxldmVsIGFuZCBvcGVuKHJl
bW92ZSkgb3IgY2xvc2Ugb25lDQo+ID4gcmV0aXJlX2xhdGVuY3kgZXZzZWwgYXQgYSB0aW1lLiBJ
biBhZGRpdGlvbiB0byB0aGF0LCB3ZSBwdXQgYWxsIHRoZSByZXF1aXJlZA0KPiByZXRpcmVfbGF0
ZW5jeQ0KPiA+IHRvZ2V0aGVyIGluIG9uZSBwZXJmIHJlY29yZCBsYXVuY2ggaW4gb3JkZXIgdG8g
cmVkdWNlIG92ZXJoZWFkIHRvIGZvcmsNCj4gbXVsdGlwbGUgcGVyZg0KPiA+IHJlY29yZC4gSSBo
b3BlIHRoaXMgbWFrZXMgc2Vuc2UuDQo+IA0KPiBXZWxsLi4gSSB0aGluayB3ZSBjYW4gZG8gc29t
ZXRoaW5nIGxpa2UgdGhpcyBpbiB0aGUgY3VycmVudCBjb2RlLg0KPiANCj4gX19ydW5fcGVyZl9z
dGF0KCk6DQo+ICAgLi4uDQo+IA0KPiAgIHRwZWJzX19zdGFydChldmxpc3QsIHRhcmdldCk7DQo+
IA0KPiAgIGV2bGlzdF9fZm9yX2VhY2hfY3B1KC4uLikgew0KPiAgICAgICBpZiAoY3JlYXRlX3Bl
cmZfc3RlYXRfY291bnRlcigpIDwgMCkgew0KPiAgICAgICAgICAgLi4uLg0KPiANCj4gaW5zdGVh
ZCBvZiBkb2luZyBpdCBpbiB0aGUgZXZzZWxfX29wZW4oKS4gIFdoYXQncyB0aGUgaXNzdWUgd2l0
aCB0aGlzDQo+IGFwcHJvYWNoPw0KDQpUaGlzIGlzIGJhc2ljYWxseSBob3cgdHBlYnNfX3N0YXJ0
KCkgd2FzIGludm9rZWQgaW4gdjkgKGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQU05ZDdj
aTd0Z2pSOExWTngrWnJGS01HbytPWm49ZUZTa3NQTDU2TWVQX1E4NFBrTXdAbWFpbC5nbWFpbC5j
b20vKQ0KDQpJIGNoYW5nZWQgaXQgaW4gdjEwIHNvIHRoYXQgaXQgd29ya3MgYXQgZXZzZWwgbGV2
ZWwuIA0KDQpJYW4sIGNvdWxkIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgd2hhdCBkbyB5b3UgdGhp
bmsgYWJvdXQgdGhpcz8gDQoNClRoYW5rcywNCldlaWxpbg0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+
ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAgCXBlcmZfZXZzZWxfX2Nsb3Nl
KCZldnNlbC0+Y29yZSk7DQo+ID4gPiA+ID4gPiAgCXBlcmZfZXZzZWxfX2ZyZWVfaWQoJmV2c2Vs
LT5jb3JlKTsNCj4gPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4gPiBAQCAtMzM0MSw2ICszNDAwLDkg
QEAgc3RhdGljIGludCBzdG9yZV9ldnNlbF9pZHMoc3RydWN0IGV2c2VsDQo+ICpldnNlbCwNCj4g
PiA+ID4gPiBzdHJ1Y3QgZXZsaXN0ICpldmxpc3QpDQo+ID4gPiA+ID4gPiAgew0KPiA+ID4gPiA+
ID4gIAlpbnQgY3B1X21hcF9pZHgsIHRocmVhZDsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAr
CWlmIChldnNlbF9faXNfcmV0aXJlX2xhdChldnNlbCkpDQo+ID4gPiA+ID4gPiArCQlyZXR1cm4g
MDsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAJZm9yIChjcHVfbWFwX2lkeCA9IDA7IGNw
dV9tYXBfaWR4IDwgeHlhcnJheV9fbWF4X3goZXZzZWwtDQo+ID5jb3JlLmZkKTsNCj4gPiA+ID4g
PiBjcHVfbWFwX2lkeCsrKSB7DQo+ID4gPiA+ID4gPiAgCQlmb3IgKHRocmVhZCA9IDA7IHRocmVh
ZCA8IHh5YXJyYXlfX21heF95KGV2c2VsLQ0KPiA+Y29yZS5mZCk7DQo+ID4gPiA+ID4gPiAgCQkg
ICAgIHRocmVhZCsrKSB7DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGls
L2ludGVsLXRwZWJzLmMgYi90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYw0KPiA+ID4gPiA+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4u
MzdiN2E0ZjkyZGQ5DQo+ID4gPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ID4gPiArKysg
Yi90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYw0KPiA+ID4gPiA+ID4gQEAgLTAsMCArMSwz
OTcgQEANCj4gPiA+ID4gPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
bmx5DQo+ID4gPiA+ID4gPiArLyoNCj4gPiA+ID4gPiA+ICsgKiBpbnRlbF90cGVicy5jOiBJbnRl
bCBUUEVCUyBzdXBwb3J0DQo+ID4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgPHN5cy9wYXJhbS5oPg0KPiA+ID4gPiA+ID4g
KyNpbmNsdWRlIDxzdWJjbWQvcnVuLWNvbW1hbmQuaD4NCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8
dGhyZWFkLmg+DQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgImludGVsLXRwZWJzLmgiDQo+ID4gPiA+
ID4gPiArI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGlu
dXgvemFsbG9jLmg+DQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ID4g
PiA+ID4gKyNpbmNsdWRlICJzYW1wbGUuaCINCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSAiZGVidWcu
aCINCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSAiZXZsaXN0LmgiDQo+ID4gPiA+ID4gPiArI2luY2x1
ZGUgImV2c2VsLmgiDQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgInNlc3Npb24uaCINCj4gPiA+ID4g
PiA+ICsjaW5jbHVkZSAidG9vbC5oIg0KPiA+ID4gPiA+ID4gKyNpbmNsdWRlICJjcHVtYXAuaCIN
Cj4gPiA+ID4gPiA+ICsjaW5jbHVkZSAibWV0cmljZ3JvdXAuaCINCj4gPiA+ID4gPiA+ICsjaW5j
bHVkZSA8c3lzL3N0YXQuaD4NCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8c3lzL2ZpbGUuaD4NCj4g
PiA+ID4gPiA+ICsjaW5jbHVkZSA8cG9sbC5oPg0KPiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxtYXRo
Lmg+DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArI2RlZmluZSBQRVJGX0RBVEEJCSItIg0K
PiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK2Jvb2wgdHBlYnNfcmVjb3JkaW5nOw0KPiA+ID4g
PiA+ID4gK3N0YXRpYyBwaWRfdCB0cGVic19waWQgPSAtMTsNCj4gPiA+ID4gPiA+ICtzdGF0aWMg
c2l6ZV90IHRwZWJzX2V2ZW50X3NpemU7DQo+ID4gPiA+ID4gPiArc3RhdGljIHB0aHJlYWRfdCB0
cGVic19yZWFkZXJfdGhyZWFkOw0KPiA+ID4gPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgY2hpbGRfcHJv
Y2VzcyAqdHBlYnNfY21kOw0KPiA+ID4gPiA+ID4gK3N0YXRpYyBzdHJ1Y3QgbGlzdF9oZWFkIHRw
ZWJzX3Jlc3VsdHMgPQ0KPiBMSVNUX0hFQURfSU5JVCh0cGVic19yZXN1bHRzKTsNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEl0IGNhbiBiZSAnc3RhdGljIExJU1RfSEVBRCh0cGVic19yZXN1bHRzKTsn
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICtzdHJ1Y3QgdHBlYnNfcmV0
aXJlX2xhdCB7DQo+ID4gPiA+ID4gPiArCXN0cnVjdCBsaXN0X2hlYWQgbmQ7DQo+ID4gPiA+ID4g
PiArCS8qIEV2ZW50IG5hbWUgKi8NCj4gPiA+ID4gPiA+ICsJY29uc3QgY2hhciAqbmFtZTsNCj4g
PiA+ID4gPiA+ICsJLyogRXZlbnQgbmFtZSB3aXRoIHRoZSBUUEVCUyBtb2RpZmllciBSICovDQo+
ID4gPiA+ID4gPiArCWNvbnN0IGNoYXIgKnRwZWJzX25hbWU7DQo+ID4gPiA+ID4gPiArCS8qIENv
dW50IG9mIHJldGlyZV9sYXRlbmN5IHZhbHVlcyBmb3VuZCBpbiBzYW1wbGUgZGF0YSAqLw0KPiA+
ID4gPiA+ID4gKwlzaXplX3QgY291bnQ7DQo+ID4gPiA+ID4gPiArCS8qIFN1bSBvZiBhbGwgdGhl
IHJldGlyZV9sYXRlbmN5IHZhbHVlcyBpbiBzYW1wbGUgZGF0YSAqLw0KPiA+ID4gPiA+ID4gKwlp
bnQgc3VtOw0KPiA+ID4gPiA+ID4gKwkvKiBBdmVyYWdlIG9mIHJldGlyZV9sYXRlbmN5LCB2YWwg
PSBzdW0gLyBjb3VudCAqLw0KPiA+ID4gPiA+ID4gKwlkb3VibGUgdmFsOw0KPiA+ID4gPiA+ID4g
K307DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArc3RhdGljIGludCBnZXRfcGVyZl9yZWNv
cmRfYXJncyhjb25zdCBjaGFyICoqcmVjb3JkX2FyZ3YsIGNoYXIgYnVmW10sDQo+ID4gPiA+ID4g
PiArCQkJCWNvbnN0IGNoYXIgKmNwdW1hcF9idWYpDQo+ID4gPiA+ID4gPiArew0KPiA+ID4gPiA+
ID4gKwlzdHJ1Y3QgdHBlYnNfcmV0aXJlX2xhdCAqZTsNCj4gPiA+ID4gPiA+ICsJaW50IGkgPSAw
Ow0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlwcl9kZWJ1ZygiUHJlcGFyZSBwZXJmIHJl
Y29yZCBmb3IgcmV0aXJlX2xhdGVuY3lcbiIpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4g
KwlyZWNvcmRfYXJndltpKytdID0gInBlcmYiOw0KPiA+ID4gPiA+ID4gKwlyZWNvcmRfYXJndltp
KytdID0gInJlY29yZCI7DQo+ID4gPiA+ID4gPiArCXJlY29yZF9hcmd2W2krK10gPSAiLVciOw0K
PiA+ID4gPiA+ID4gKwlyZWNvcmRfYXJndltpKytdID0gIi0tc3ludGg9bm8iOw0KPiA+ID4gPiA+
ID4gKwlyZWNvcmRfYXJndltpKytdID0gYnVmOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4g
KwlpZiAoY3B1bWFwX2J1Zikgew0KPiA+ID4gPiA+ID4gKwkJcmVjb3JkX2FyZ3ZbaSsrXSA9ICIt
QyI7DQo+ID4gPiA+ID4gPiArCQlyZWNvcmRfYXJndltpKytdID0gY3B1bWFwX2J1ZjsNCj4gPiA+
ID4gPiA+ICsJfQ0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlyZWNvcmRfYXJndltpKytd
ID0gIi1hIjsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICsJaWYgKCFjcHVtYXBfYnVmKSB7
DQo+ID4gPiA+ID4gPiArCQlwcl9lcnIoIlJlcXVpcmUgY3B1bWFwIGxpc3QgdG8gcnVuIHNhbXBs
aW5nLlxuIik7DQo+ID4gPiA+ID4gPiArCQlyZXR1cm4gLUVDQU5DRUxFRDsNCj4gPiA+ID4gPiA+
ICsJfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSG1tLi4gSSB0aG91Z2h0IHlvdSBzdXBwb3J0ZWQg
c3lzdGVtIHdpZGUgY29sbGVjdGlvbiwgbm90IHN1cmUgaWYgaXQNCj4gaGFzDQo+ID4gPiA+ID4g
YSBjcHVtYXAuICBBbnl3YXkgdGhpcyBjaGVjayBtYWtlcyB0aGUgZWFybGllciBvbmUgbWVhbmlu
Z2xlc3MgLSB5b3UNCj4gPiA+ID4gPiBuZWVkIHRoZSBjcHVtYXAgYWx3YXlzLCByaWdodD8NCj4g
PiA+ID4NCj4gPiA+ID4gVFBFQlMgc2hvdWxkIGJlIHdvcmsgd2l0aCAiLWEiIG9yICItQyIuIEkn
bSBub3Qgc3VyZSB3aGF0IHRoZSBjcHVtYXANCj4gPiA+IHdvdWxkIGJlDQo+ID4gPiA+IGZvciAi
LWEiLiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGFkZCAiLWEiIG9ubHkgd2hlbiBjcHVtYXBfYnVm
IGlzDQo+IE5VTEw/DQo+ID4gPg0KPiA+ID4gSSB0aGluayB0aGUgYmVzdCB3YXkgaXMgdG8gY2hl
Y2sgdGFyZ2V0X19oYXNfY3B1KCkuDQo+ID4gWWVzIHRoaXMgaXMgYW4gaWRlYWwgd2F5IHRvIGNo
ZWNrLiBCdXQgc2luY2UgdGhlIHRwZWJzX3N0YXJ0KCkgaXMgY2FsbGVkIGluIGV2c2VsLA0KPiBJ
J20NCj4gPiB3b25kZXJpbmcgZG8gd2Ugc3RpbGwgaGF2ZSB0YXJnZXQgaGVyZT8NCj4gDQo+IFBs
ZWFzZSBzZWUgYWJvdmUuDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0KPiA+DQo+ID4g
Pg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArCWxpc3Rf
Zm9yX2VhY2hfZW50cnkoZSwgJnRwZWJzX3Jlc3VsdHMsIG5kKSB7DQo+ID4gPiA+ID4gPiArCQly
ZWNvcmRfYXJndltpKytdID0gIi1lIjsNCj4gPiA+ID4gPiA+ICsJCXJlY29yZF9hcmd2W2krK10g
PSBlLT5uYW1lOw0KPiA+ID4gPiA+ID4gKwl9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiAr
CXJlY29yZF9hcmd2W2krK10gPSAiLW8iOw0KPiA+ID4gPiA+ID4gKwlyZWNvcmRfYXJndltpKytd
ID0gUEVSRl9EQVRBOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKwlyZXR1cm4gMDsNCj4g
PiA+ID4gPiA+ICt9DQo=
