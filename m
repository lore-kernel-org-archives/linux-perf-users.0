Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6E4C66;
	Tue, 21 May 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308633; cv=fail; b=aJbwAfxbiwwOhjSdEsv6JqX6Si3ss2roABqzLU2ExsrgCT7gzHqLrfnEArs/nBrh+I4CKpQszDCJFI9RCEcuffiQ6pgUlj6zJa61KO4Wrw3iI72JzJXyZPV0pSXOCHDAQk2eWIw2ZvsaAP+wRZHlTwgQPxclomq7uGYCrXvfNrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308633; c=relaxed/simple;
	bh=lZqIc6IQVDJ66/UrigWJhEmD9UuinHKp5W78kwzF8dU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DbCleB5WUwKAyuV9gHA2vYa1GVCrlOvsDda06HkADWnL0KovLk8I6CLwJ/mtSJGbopqBEHOemBzwXU+cmutqcyCEkkJ01095XpNLJQznBFhPqLW34b/icafHbUfhjm1xaka6B49gSYPSaRZIB1kjHpCkPulg+OFBbZJf4chJBfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKto++rN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKto++rN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716308632; x=1747844632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lZqIc6IQVDJ66/UrigWJhEmD9UuinHKp5W78kwzF8dU=;
  b=gKto++rNfU8UNk6eZh4nUk4hl0yQEMZtvJZTU6ri09uXmaDFBJmItoFo
   IVzu2EPvm1V+/BQok4mVARn1GdcHoYSEgycojkWblX6CeugnVq7FyR7KP
   5ZmHrr7YUAyizZuBzRzYAaxSjmfC0Cm5lmLpvAb8AAQ6Fa2AJEC+0g1Wn
   mwPjmSGqGUur9GKSQkuhjuz/OzGV7z9lAa8LTbkj+rE5enqZiSQmj2FN2
   OBJAegAtOULmju5Q+5RuQgjukd2Vx0gNL401bF67NqjvFK2bzFn1bAB9D
   SBdKo+BNrHZS6+v+cBoohw2O3mhrc5zLvGNiHojm1hdFb0tfHbNeVT6av
   Q==;
X-CSE-ConnectionGUID: w2HQpTHYS6yRDtN15FNGQA==
X-CSE-MsgGUID: ZEwXyIAoTmCQIFJNtU2p/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23921500"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="23921500"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:23:28 -0700
X-CSE-ConnectionGUID: oVFKXj3iQnWdGDiRWS0A6g==
X-CSE-MsgGUID: MvbSvihZQMib9hk4/yC8PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33036819"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 09:23:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 09:23:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 09:23:27 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 09:23:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRtiXk0+Z2+P1IInYXv7lq3dYMwlRwX6Q12CoOh9gxoKD5ovLTz+o76udIUZoaDGD53LbLUCjawkLRboqYt0rqSlC+WTotCzoL6DU3ivoE5wKxPPX5feOObobC0BgGgJCZYDJ8cv8fSFzBdEgl4s0KFYHITFF2aG5M4dytW5QXB2L/q0Fh+3aoIt7jP07mK/Ya2/ko0uQg+rJYQ9rXAgy0pMqBjtZ64TecltLExC6ARImTcXI11o+obeOjQWrQJUUpCTdd4biWsdS7eLMH/6PR04ArfUdBmVS73csILK6s66FM15OYdMByMz7VclGyDRo8T3XTvytdNVTB5gFnHN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZqIc6IQVDJ66/UrigWJhEmD9UuinHKp5W78kwzF8dU=;
 b=kWnJHPVFT/icYI3hCyZvwptNPbNEe1sSUjIdIxlnphAUVtgPbYiIng1mxOh/si7NfhvVS+cZApHhqwopGyb5OlrMjaDP8SD5C+c6Zyi4VaxRk/jGKAR9lbARpOBfyU4b2kJoMvOc2K81uVtZqvNSB6iLy5aNnmmnJorQ1MLxptM3noBNdbQkjp8oln3ZKkADx2elW3T9IRkLdRfPM3tQ+NuFfBhoMhOVxFbXJf4EnaQpLqOvRyifnwE36rWI+8zUkTIQvQdNwmJsbp8nlIbuRhEoixWiLLVOdODQw0j2iLLd94lwwhQtKB4lIERglgEEZsKYKv4tsGXzAGuwRhJ99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SA3PR11MB7528.namprd11.prod.outlook.com (2603:10b6:806:317::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Tue, 21 May
 2024 16:23:24 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:23:24 +0000
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
Subject: RE: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v8 3/7] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHaposFrByRjGFRDkOWD8ukWbv8TbGb+VMAgATX/DCAAGUCAIAAstCw
Date: Tue, 21 May 2024 16:23:24 +0000
Message-ID: <CO6PR11MB5635C9FEC45885BB39E1E63FEEEA2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-4-weilin.wang@intel.com>
 <CAM9d7cghtG-9rwy5Yg-oJDETO-J5OUzPt6=xMCwacKqfwo+sZA@mail.gmail.com>
 <CO6PR11MB563574C9C284744CD079C0D3EEEA2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7ciOyp4AjTxR=-kq=B8b3-ium3wiG+_j6s3wfoH+DOLp8Q@mail.gmail.com>
In-Reply-To: <CAM9d7ciOyp4AjTxR=-kq=B8b3-ium3wiG+_j6s3wfoH+DOLp8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SA3PR11MB7528:EE_
x-ms-office365-filtering-correlation-id: 38fb93cf-a4d5-42a3-9370-08dc79b256ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z29LS2V2UzlZaGR4NHJtSXY5Y2tjMHp5TmhMQlBicGhBM2dBTVpzMU1VSi9Z?=
 =?utf-8?B?WEhRL3YybDRJNkdJanFDOU5hYnQ1MTJRSkkwdS94TG8vU1krMStzUVI0cmxO?=
 =?utf-8?B?M2hsV08rdkNPd1Y4WWYzK1VnSk51MnFIZjJEc3lZdDBteWhhWEpWbjVGcEFk?=
 =?utf-8?B?Y1hGQVcwREFrSFpQOVhZMHNQZnkrSW9zY2syWlNXL0VSek9sUDh1QmtiRkp5?=
 =?utf-8?B?QTZ6M2IwUEovdjdDNnFyekhGelE5NEt3aU9UdWVSd1EvMXMybHhyT1c1Zkhq?=
 =?utf-8?B?enRYUktRdFJIRDlDOUNIRjlRQ2dyRVhTdWNLRjV3b2dSTm5DVHM0RmZQN2ll?=
 =?utf-8?B?NiszVlZlR2JUT1BNLytOQ1ZtMXVnL1dtb1A0a0lVVGJtL1JpRW1udW9wdEd6?=
 =?utf-8?B?NXpMNlpFRXZYQXhIWE4ySnBsblVPUFhOMzZod2kzQ1pHQ3YwdlZCbHFnZzE5?=
 =?utf-8?B?cUUvSGpjWFBOb1BNOUNFbmRnZFlhTlJvbC9TQnAycjloVFJmbExmQ1Nva2VV?=
 =?utf-8?B?cGFBV01wcEViMkpJT0lLN0FIYU1JNlNSeHJkQml4b21pSVdIZTBySTZKK2tQ?=
 =?utf-8?B?dVkwRXRiTGMrNjFleXIrOWlsMERJMTgwUFVNQUVjaU5NRzBtM1c4NjZGTUx0?=
 =?utf-8?B?czhwamtJWldzN3JOem4zZFNpOVNIYUcyVVpjV2kyZllNYnhIQWRmOHMwbktS?=
 =?utf-8?B?eEZKbDB1QUxDL0ZNQkg1QlIwWC9wUWtjSktBTnBYSHd0aksrVUNGU093c0dI?=
 =?utf-8?B?ekgzQ3hnRGVhTTlzT2lxdjhJZVQrRzQ1L3haTTBPYWFwZVRhK3Q4cVV5TDRq?=
 =?utf-8?B?alBCYkhPRDVxdHQ3M0Jadk45Z3lSQlk4aTBwMUg3UHFTaEtwZjRTTW9UejZN?=
 =?utf-8?B?T0IvWVhPYmViSFMwOUNyZUI2azJyemQrS2g2VW5KZ01WSmJ4STlnMzltR1Jj?=
 =?utf-8?B?UytUNnU1N3VDMzY4YndMOUhFNmRQRmNXQW5hQ3lWNEExL3Ezd0tBRytseXMy?=
 =?utf-8?B?M2Z3TFpGQmdmaHFERFp3OVhJR3NJU3RYZ2QrdmFNZHNkdUpmSHpRdllaNytj?=
 =?utf-8?B?bHJwMHpzUEduZnVIb1NSSEl5WEx5STk0eGxLdHBkUHhCdk93TXJMS1FpVVBn?=
 =?utf-8?B?RFZYUVRocWFxZFpjOTQwNStmR25HMnJpallaVzNaRU9IOGVhZEF4S0tMY09j?=
 =?utf-8?B?V3BISGVtaVlMTFExSk8vcFkvL0ZkcGM0ejNWYjVEWXRwOWZGSW01QU5ldWZ0?=
 =?utf-8?B?cGUvNWxYYjZsWTYrTFZQK0xkcVFhUGJmRTdOb0NSMkVLUGJvVkpraG9Xb0xl?=
 =?utf-8?B?TnNjWlkvSThpQ1ZCbEJMRmxrY1lBcFVzS1REU1Z3WW9lRjJydFNZbkxCZ1du?=
 =?utf-8?B?cm5WTVpweFNHNXZCN2l0aFEwSGJvditUQndjZTJXS0pnbDN2RnYzTG9lTjNP?=
 =?utf-8?B?aXRuMHlUNWhDRVkvbXpIeDdpa3lrbzJ1aXRXa2ZIUmpmNWJvdFRXU0Fia3M2?=
 =?utf-8?B?eWZvTFhIcElDQVAvcDFUanBpQUJDY1Y1Ri92bXZXWFkyMGdHbVpHNkxyaXpP?=
 =?utf-8?B?VktGOXdVeXJNcDZLWk9tNnVNaDNqaWxad1pGV1hZVktXZWdxUWtTVzJ2TG95?=
 =?utf-8?B?ejRsVi9TbmpQVXQydCsyNzM4NW9ud0o2clNqdFhUZm1WNnYzSHpDVGgxbHl1?=
 =?utf-8?B?My93QW1POUEvaGl5MWNOREhEM1dLbmYvODU3THZEQWJWSEZSQ0ZxM2lncTlh?=
 =?utf-8?B?MWJtYTc0cTNPQUpqZHN6VE9PN0ZyZkU0VGxlc2txQnN4a2R6ZnZ1VUdhZW05?=
 =?utf-8?B?aWw4TWpyUGwrTS8rckMvdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWQwTXF6YTYrS0JMUjJsL0ovOEVyaFVVOUpsUmRYZytPRUNPMUdFRUYvbm9L?=
 =?utf-8?B?ZkYrcXdFRS9vbWN6Ymt5SW8rU0wwd1JWc0F2aUE4MXNCN0t4TktXWDhyejM1?=
 =?utf-8?B?Z2JmSzk2UmpGWTdkZ0tpWEc1SW5UbndIVWh1VmZjVUVLKzRBcWQ0eWpJalJx?=
 =?utf-8?B?d2ZNalV2MStCcEl0TzF1L29iVms2QUNiM0w3QllUOWptRFBYdHZUdXcxUkd0?=
 =?utf-8?B?MzRVTUZ3TU1kWkk2U05qYVc5RWJ5TXhNSXdEK1crald2TmxHSlVXSmZGZE44?=
 =?utf-8?B?SHM0YWFnYUhDbE95Sko0bEtsTDBGeFJQVi9XeEJRQjEzei8vRis5MmdrRURO?=
 =?utf-8?B?NG9jVTlXSHNHTi9xR29CbmpURXMrSUpQSE5tKzBBZUdUaStZQW9nYTBQVWY0?=
 =?utf-8?B?bW9PUGdCZUNHZlpXc3kvVUZOaHBlVjNReUZaZi9pK3JoVHQydTVWeHlOMlRB?=
 =?utf-8?B?VUg1U0U2dWJBQzByL05GeFo4TVQ2dG5rR0xWejBMOTZEcXdsb2pIZWtjaE9T?=
 =?utf-8?B?RndHamN0bE55bzJLUkdidnBCM1N3VXdDRkxRYXc1Z1hUYUdtMHFVNmg0VVlX?=
 =?utf-8?B?TktEUHpVc1dRSVFFK09GRFdPMmlxcWtQTk9wdGloamVsQzkxZWRITk11MlZB?=
 =?utf-8?B?WUIwRDlldWt1NUViZVdNcWt1SHE0RGsvSTlXNVA3VkpCUkFsWHljWEE3TkxH?=
 =?utf-8?B?SUxCdVlrYy9tNXFRdnRnemZ4cnBoM0VLYmlLei85ZnRpcVhPait5SEY2TjRO?=
 =?utf-8?B?SEJrckVJVFkxMGx1WE8yekNkZUVkNU4yd3VCZ0x4dGV4VFRMN2U2aWhBZTlG?=
 =?utf-8?B?cFA2ZXJRQ0VxYnRNQW0weEk5MitKNy9lT3lsbVQwRENKN3dCSm5pdzA0SFFV?=
 =?utf-8?B?Q1lJRW5QNVc2RE54b1o5TEZvQ3VUeDRCTkt4VW9hdDUxVVEwaDd2Y2g1TTA5?=
 =?utf-8?B?bVRXY2pQc2JUR1ZBQ25CN0dmbjJsVDJzbXkvSVhKSnVpZ0FLRnpxdlh2VlAx?=
 =?utf-8?B?emZVcVl3RVJLWjdFUVNwS3pRVFpnL3hVVW9hall2clhTWjJMdWZ1eUxGRDJH?=
 =?utf-8?B?Tk5YY1BDUW5XU2pkMUhwTTRJQyttQ2JrSGtSWHhjeHdlOW9rL09LOERvMHBi?=
 =?utf-8?B?bFMzK0FNaU1GQVVBNGFaTWVXeE45dlh4Y1MrNTNQTWoraFdDNUxIMVE5TnZn?=
 =?utf-8?B?dXFzelNOTWFkMVgyL3hHMXVPcjF4UFZLWDJwUXdyejdKYWhKbE14OHdKUTFW?=
 =?utf-8?B?dWMwUWV0RlYwelpiQ1V5OXpvSXEvR1Y0WVRId2lCVXUxdVIzM3JIbi9mTmsx?=
 =?utf-8?B?dzQ1S3VaRkEzTU9YdkRUeWRtd1RoUWhySHJrandMa3ZjanJTR3JqdHMwRXpa?=
 =?utf-8?B?VzNZa0NuUVkxVnB2L3RzSjlFZWJlWXdoTEJkdjZMVUxRTDZaOXk4R05ET0U3?=
 =?utf-8?B?R0JkcU9ta1RqL2M1VVlkUjJSODg2SGJnZ2NKSVZlaE1jOW1OcXBvQ1ZaK1JW?=
 =?utf-8?B?VUt1M0hvLytpRitFbmRsT0JKeDlVVzU5UXN5SHU2S2ZGOTd2S3ZQRndOdnhR?=
 =?utf-8?B?NTVEU0hNaHNHQ2pCbkZkVHpQR0RMWGdRTHJCTUt0WWZWNCtvbEdlYUV4UVJy?=
 =?utf-8?B?S1k4WktsUWdVZk5HdCtwekdCSTM1OHEyVmRkL1VhNnQ0ZDVzYjN6R3NCY09w?=
 =?utf-8?B?RENLRDM5YjBqa290NG9uTFp0MXUxWWZTVzdzLzQ4RzVzbytMM3VxcFFXUXRL?=
 =?utf-8?B?aENZMFpwdWtBYWx3SUsvQzdKWFRocHJzczJiQm5mZHIyWTgzVHd2bkNNUzlk?=
 =?utf-8?B?bTJMTEVLU01mL2pWajJHc1VGVmthaUdydDdCeWxUaGQ5cW5qVGVua0N2eWVp?=
 =?utf-8?B?QlE1SVA5NTlsV3JEaFgvVXVNSUc3d1Nxcjg4NTZmSXFoM0todSthZWV3VVhr?=
 =?utf-8?B?VmsvSjRCcHMzeDZCRkl1eWZkL1E5OHNZSldrV1RWOHhpbElQcTNqS3pJU2FE?=
 =?utf-8?B?QndLQTF3dE1aWGw3WUxiUVBKL1RxZitJWkdnSmx6UElwelhpV0swSVFFNkda?=
 =?utf-8?B?NmZOYm9WaExTSmlVRW9GL2RFb2U2Q1pPd0lIT3QxUGJIK3A4WDZWWVNHMDc5?=
 =?utf-8?Q?jQ9rLIfgZOJQsYEuZRuGH7c56?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb93cf-a4d5-42a3-9370-08dc79b256ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 16:23:24.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQafb7QZYrBTokzp26tWcokfRELw6tLwtZ00swMKrG31UI/kbF8bpHFiQ2wH29fb8Nm2Z0DiD7sfxfGJ1tfL2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7528
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE1heSAyMCwgMjAyNCAxMDo0MyBQ
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
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2OCAzLzddIHBlcmYgc3RhdDogRm9yayBh
bmQgbGF1bmNoIHBlcmYgcmVjb3JkIHdoZW4NCj4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldCByZXRp
cmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBtZXRyaWMuDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIE1v
biwgTWF5IDIwLCAyMDI0IGF0IDU6MTDigK9QTSBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGlu
dGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3Jn
Pg0KPiA+ID4gU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMjQgMjo0MyBQTQ0KPiA+ID4gVG86IFdh
bmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IElhbiBSb2dlcnMg
PGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA+ID4gPGFj
bWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IElu
Z28gTW9sbmFyDQo+ID4gPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA+ID4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpv
bHNhQGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+ID4gPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tPjsgS2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gPiA+IGxp
bnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBUYXlsb3IsDQo+IFBlcnJ5DQo+ID4gPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFs
dCwgU2FtYW50aGEgPHNhbWFudGhhLmFsdEBpbnRlbC5jb20+Ow0KPiBCaWdnZXJzLA0KPiA+ID4g
Q2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMg
UEFUQ0ggdjggMy83XSBwZXJmIHN0YXQ6IEZvcmsgYW5kIGxhdW5jaCBwZXJmIHJlY29yZA0KPiB3
aGVuDQo+ID4gPiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJldGlyZSBsYXRlbmN5IHZhbHVlIGZv
ciBhIG1ldHJpYy4NCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE1heSAxNCwgMjAyNCBhdCAxMDo0NOKA
r1BNIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9t
OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBX
aGVuIHJldGlyZV9sYXRlbmN5IHZhbHVlIGlzIHVzZWQgaW4gYSBtZXRyaWMgZm9ybXVsYSwgcGVy
ZiBzdGF0IHdvdWxkDQo+IGZvcmsgYQ0KPiA+ID4gPiBwZXJmIHJlY29yZCBwcm9jZXNzIHdpdGgg
Ii1lIiBhbmQgIi1XIiBvcHRpb25zLiBQZXJmIHJlY29yZCB3aWxsIGNvbGxlY3QNCj4gPiA+ID4g
cmVxdWlyZWQgcmV0aXJlX2xhdGVuY3kgdmFsdWVzIGluIHBhcmFsbGVsIHdoaWxlIHBlcmYgc3Rh
dCBpcyBjb2xsZWN0aW5nDQo+ID4gPiA+IGNvdW50aW5nIHZhbHVlcy4NCj4gPiA+ID4NCj4gPiA+
ID4gQXQgdGhlIHBvaW50IG9mIHRpbWUgdGhhdCBwZXJmIHN0YXQgc3RvcHMgY291bnRpbmcsIGl0
IHdvdWxkIHNlbmQgc2lndGVybQ0KPiA+ID4gc2lnbmFsDQo+ID4gPiA+IHRvIHBlcmYgcmVjb3Jk
IHByb2Nlc3MgYW5kIHJlY2VpdmluZyBzYW1wbGluZyBkYXRhIGJhY2sgZnJvbSBwZXJmIHJlY29y
ZA0KPiA+ID4gZnJvbSBhDQo+ID4gPiA+IHBpcGUuIFBlcmYgc3RhdCB3aWxsIHRoZW4gcHJvY2Vz
cyB0aGUgcmVjZWl2ZWQgZGF0YSB0byBnZXQgcmV0aXJlIGxhdGVuY3kNCj4gZGF0YQ0KPiA+ID4g
PiBhbmQgY2FsY3VsYXRlIG1ldHJpYyByZXN1bHQuDQo+ID4gPiA+DQo+ID4gPiA+IEFub3RoZXIg
dGhyZWFkIGlzIHJlcXVpcmVkIHRvIHN5bmNocm9uaXplIGJldHdlZW4gcGVyZiBzdGF0IGFuZCBw
ZXJmDQo+IHJlY29yZA0KPiA+ID4gPiB3aGVuIHdlIHBhc3MgZGF0YSB0aHJvdWdoIHBpcGUuDQo+
ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0Bp
bnRlbC5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2ds
ZS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gW1NOSVBdDQo+ID4gPiA+IGRpZmYgLS1naXQgYS90
b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYyBiL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10cGVi
cy5jDQo+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGluZGV4IDAwMDAwMDAw
MDAwMC4uNGI3YTk4Nzk0ZmFlDQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIv
dG9vbHMvcGVyZi91dGlsL2ludGVsLXRwZWJzLmMNCj4gPiA+ID4gQEAgLTAsMCArMSwyODUgQEAN
Cj4gPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gPiA+
ID4gKy8qDQo+ID4gPiA+ICsgKiBpbnRlbF9wdC5jOiBJbnRlbCBQcm9jZXNzb3IgVHJhY2Ugc3Vw
cG9ydA0KPiA+ID4gPiArICogQ29weXJpZ2h0IChjKSAyMDEzLTIwMTUsIEludGVsIENvcnBvcmF0
aW9uLg0KPiA+ID4NCj4gPiA+IFRoaXMgbmVlZHMgc29tZSB1cGRhdGVzLiA6KQ0KPiA+ID4NCj4g
PiA+DQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gKw0KPiA+ID4gPiArDQo+ID4gPiA+ICsjaW5jbHVk
ZSA8c3lzL3BhcmFtLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8c3ViY21kL3J1bi1jb21tYW5kLmg+
DQo+ID4gPiA+ICsjaW5jbHVkZSA8dGhyZWFkLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSAiaW50ZWwt
dHBlYnMuaCINCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9saXN0Lmg+DQo+ID4gPiA+ICsjaW5j
bHVkZSA8bGludXgvemFsbG9jLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+
ID4gPiA+ICsjaW5jbHVkZSAic2FtcGxlLmgiDQo+ID4gPiA+ICsjaW5jbHVkZSAiZGVidWcuaCIN
Cj4gPiA+ID4gKyNpbmNsdWRlICJldmxpc3QuaCINCj4gPiA+ID4gKyNpbmNsdWRlICJldnNlbC5o
Ig0KPiA+ID4gPiArI2luY2x1ZGUgInNlc3Npb24uaCINCj4gPiA+ID4gKyNpbmNsdWRlICJ0b29s
LmgiDQo+ID4gPiA+ICsjaW5jbHVkZSAibWV0cmljZ3JvdXAuaCINCj4gPiA+ID4gKyNpbmNsdWRl
IDxzeXMvc3RhdC5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPHN5cy9maWxlLmg+DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArDQo+ID4gPiA+ICsjZGVmaW5lIFBFUkZfREFUQSAgICAgICAg
ICAgICAgIi0iDQo+ID4gPiA+ICsjZGVmaW5lIENPTlRST0wgICAgICAgICAgICAgICAgICAgICAg
ICAiL3RtcC9jb250cm9sIg0KPiA+ID4gPiArI2RlZmluZSBBQ0sgICAgICAgICAgICAgICAgICAg
ICIvdG1wL2FjayINCj4gPiA+ID4gK3B0aHJlYWRfdCByZWFkZXJfdGhyZWFkOw0KPiA+ID4gPiAr
c3RydWN0IGNoaWxkX3Byb2Nlc3MgKmNtZDsNCj4gPiA+ID4gK3N0cnVjdCBwZXJmX3N0YXRfY29u
ZmlnICpzdGF0X2NvbmZpZzsNCj4gPiA+DQo+ID4gPiBzdGF0aWMgPw0KPiA+ID4NCj4gPiA+ID4g
Kw0KPiA+ID4gPiArc3RhdGljIGludCBnZXRfcGVyZl9yZWNvcmRfYXJncyhjb25zdCBjaGFyICoq
cmVjb3JkX2FyZ3YpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAgaW50IGkgPSAwOw0KPiA+
ID4gPiArICAgICAgIHN0cnVjdCB0cGVic19yZXRpcmVfbGF0ICplOw0KPiA+ID4gPiArDQo+ID4g
PiA+ICsgICAgICAgcHJfZGVidWcoIlByZXBhcmUgcGVyZiByZWNvcmQgZm9yIHJldGlyZV9sYXRl
bmN5XG4iKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAi
cGVyZiI7DQo+ID4gPiA+ICsgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICJyZWNvcmQiOw0KPiA+
ID4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLVciOw0KPiA+ID4gPiArICAgICAgIHJl
Y29yZF9hcmd2W2krK10gPSAiLS1zeW50aD1ubyI7DQo+ID4gPg0KPiA+ID4gVW5mb3J0dW5hdGVs
eSB0aGlzIHN0aWxsIHN5bnRoZXNpemVzIE1NQVAgcmVjb3JkcyBmb3IgdGhlIGtlcm5lbA0KPiA+
ID4gYW5kIG1vZHVsZXMuICBBcyB3ZSBkb24ndCBjYXJlIGFib3V0IHRoZW0gYW5kIGp1c3Qgd2Fu
dCB0bw0KPiA+ID4gbWluaW1pemUgdGhlIG92ZXJoZWFkIGF0IHRoZSBiZWdpbm5pbmcsIHdlIGNh
biBhZGQNCj4gPiA+ICItLXRhaWwtc3ludGhlc2l6ZSIgdG9vLg0KPiA+DQo+ID4gSGkgTmFtaHl1
bmcsDQo+ID4NCj4gPiBJJ20gdHJ5aW5nIG91dCB0aGUgIi0tdGFpbC1zeW50aGVzaXplIiBvcHRp
b24gYnV0IGZhaWxlZCB0byBnZXQgaXQgd29yaw0KPiA+IGNvcnJlY3RseS4gQ291bGQgeW91IHBs
ZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIGNvbW1hbmQgYW5kIGxldCBtZQ0KPiA+IGtub3cgd2hh
dCdzIHRoZSBwcm9ibGVtPw0KPiA+DQo+ID4gInBlcmYgcmVjb3JkIC1lIGN5Y2xlczpwIC0tc3lu
dGg9bm8gLS10YWlsLXN5bnRoZXNpemUgLVcgLWEgLW8gLSBzbGVlcCAxIHwgcGVyZg0KPiBzY3Jp
cHQgLUYgcmV0aXJlX2xhdCAtaSAtIi4NCj4gPg0KPiA+IEkgZ290IGFuIGVycm9yICIweDQwIFsw
eDQwXTogZmFpbGVkIHRvIHByb2Nlc3MgdHlwZTogOSIgd2hlbiBydW4gdGhpcw0KPiBjb21tYW5k
Lg0KPiA+DQo+ID4gSWYgSSBydW4gdGhlIGNvbW1hbmQgaW4gdHdvIHN0ZXBzIHdpdGhvdXQgcGlw
ZSwgdGhleSB3b3JrIGZpbmUuDQo+IA0KPiBIbW0uLi4gaXQgbWF5IG5vdCB3b3JrIHdpdGggcGlw
ZXMuICBMZXQncyBnbyB3aXRob3V0IHRoZQ0KPiB0YWlsLXN5bnRoZXNpemUgdGhlbi4gIFNvcnJ5
IGZvciB0aGUgbm9pc2UuDQoNCk5vIHByb2JsZW0uDQoNClRoYW5rcywNCldlaWxpbg0KPiANCj4g
VGhhbmtzLA0KPiBOYW1oeXVuZw0K
