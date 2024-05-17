Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1FE1A2C20;
	Fri, 17 May 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983078; cv=fail; b=WbZhZqZbOWgGmu13fUxMyl1NNmk9GL44/fRvNgNDucLE9Pe7hegoc36yTVTqEByP+CSWH4xb8jWe1qTy5vjyEHEJUIXD69t9IySw6OkMPhoLvrq1CW+0GWjTbVOt/4sVz/3qLStPCEHKsKHC8CG9VadC7Hzl0Dwaxt8SvDotNL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983078; c=relaxed/simple;
	bh=MIcwwMbjgXisM13pKlqhFPI8I2fvDPPJsI5+hd6khag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sy9bbxK+oRXQIEDbXg0JlYJ03NpvwSsrSBUBSQZmqOIEny+HUcQu/IoS4UxwRG4YyGNBi/NmzU5bExgo3dbbyNfWzeWyd09Cv0wYhm11xerZwe6GZVQbwb/s3KJrNM9V6fDYTozzg79W14uQbV5r4OCxAC0cMs6KC7qvbNXzW+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3KPYYhk; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3KPYYhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715983076; x=1747519076;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MIcwwMbjgXisM13pKlqhFPI8I2fvDPPJsI5+hd6khag=;
  b=b3KPYYhkJvuf1dR2/+AeB8oQTcZWH5BlXyK4wFP8+QLhAm9nCRg6vCHq
   OYx4q4AcUIycDhsbbyzqxKfLMTjlVAJ/D/0IGrorMAhLcoPJQ6tmMP5bw
   hkCkKm6uVpLgq7qGJ9C7pERq3T1tsq3jZE416WOTAYB95K3qiOVOgviYo
   1WMw4RI+NKW/XTGrZK5QlK1y0oPbRe+MKtaEino4tlBGrXEVBWx6WrdQq
   P75gkLymg7KC9BtUeosdbPg1qabXaMDhjFzHdZPvuFU6B8a62rDDmxS8Y
   JlZoHcFHYojRUh6RRu8mf9f4vP/XJRcdJIbfESnt0er004uUyIkX41OOp
   g==;
X-CSE-ConnectionGUID: MvuDyD9nSua8DxU2eQodoQ==
X-CSE-MsgGUID: zGqOpRvUQ/KnE0TIEMPWeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="16015000"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="16015000"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 14:57:55 -0700
X-CSE-ConnectionGUID: sBZNfqxMS8SkjIHEiTOQHg==
X-CSE-MsgGUID: 0pce0CsGQACu2yCQRUhTBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; 
   d="scan'208";a="63116496"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 May 2024 14:57:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 14:57:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 14:57:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 14:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lssL3CY3gh3WeeNpvq+faskdRQvl5GMNGPh1J+No1/AHv9H/tGRo2xilHijt0feejYFOEQr/93caYkiz44GZCRZ0luXSzKTXe08Fw94WrLz9EvjLGIiz88gRyxwBKF25E87gw50FqSfT8YVrZoZFyI5tffO8QntuN/mIYj2faB6ARrnsPlRxRwJuVBOn6M5TjraOb75Bap0AajxMzzbx3J4cLsrfqcQZ0QRe2UFqm0U0ejAsNjNSFtCZVudulR8thl09+ACh+P48AW0eGTFsaG2BlCsNNloRqMyLeWDDgNJcTpyAf9+fEdeSX+5Z1IeTkwGpBNeeIMNobVfwovGGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIcwwMbjgXisM13pKlqhFPI8I2fvDPPJsI5+hd6khag=;
 b=EeWT+mC9lCZa6kawdDlO6ObMkecmG8sLMV1mWNNFsZ4cPEvEbyHL64EeULAMJBvduJf9MRKINAFzTMKUDGjrN+uLaK7OACT1uAw82tHDMCDn8FVmaA3YOgIGSLfvE+DXuby4u6k/APPpmoi1V6DW2q5sCrqo+ntN+loqAwaUz9icijD2Ce2oBTANU1/+Ahw3jWisPaDXOo1nlCud1ditCbCa7EN8w2Rxl3Y0+p04D1MTTh7Vrf9L3M1rxh4e7B7KbLcYcFUuDcYpLk22QUMsQZAWY0Asc/qK8VG+J9vobxzKgrNaVPk2b2w+TYPevRDTCOldygeYUU4FYqtBj0ebAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA1PR11MB7247.namprd11.prod.outlook.com (2603:10b6:208:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 21:57:52 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 21:57:52 +0000
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
Thread-Index: AQHaposFrByRjGFRDkOWD8ukWbv8TbGb+VMAgAADbGA=
Date: Fri, 17 May 2024 21:57:52 +0000
Message-ID: <CO6PR11MB563537F134026F22B5610DADEEEE2@CO6PR11MB5635.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA1PR11MB7247:EE_
x-ms-office365-filtering-correlation-id: 60360ea6-91bf-4f7a-71ad-08dc76bc66a2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?d2k0NTBRSkp6Y2h5R0JkZjlvV2lrN3B4SDhyVjI4aC9oSVBJa2NoNmNzWExH?=
 =?utf-8?B?UmNkZHlUUmhvNHFEYTk3UEE3UFR3dkN1NC9LYUxqWkkwM09wWUJJMkNaa3pu?=
 =?utf-8?B?MHVwS0RpU3A1UDhGa2wybVlhQ2VFSFNmQ0ZmWGx6eDEzN0puUGJ0Ly9mWUxF?=
 =?utf-8?B?d3FKRWxSbjRES2dNZmI4Lzl4YXU3UlFtOGdZcUZOaVR5NnZDUTJYSlBzam1S?=
 =?utf-8?B?N1AwZHdieEc2Lzg5L2RldzhUM0w5eFgwZUJQS0NlV1NWMU42NUo0VzFaK2dw?=
 =?utf-8?B?K0I4Y3NvWlpPL2dYMWhnbklqNDBXKysrRHIvQTJlcTh4bGFseVZ3L05sam5U?=
 =?utf-8?B?c0JZYzdjT0xtNUFlYkczUU81VkVteG5kL2ZLcXhURDcrdHc3U090a2tBcDE0?=
 =?utf-8?B?R2xkOUxkVEtwZGJlUURMWFUxRTRaM1lkVXdJV05YQWdzL3l3K0lGVUkzUWk4?=
 =?utf-8?B?SGRiV3Q2SUFycFJuN2xCZXc0cmN6b0sySTlsNjl0cndZOEhhTVNJR3JPMUxm?=
 =?utf-8?B?aXQxTmhOUE1Ea25zaThUdGhVUW90MGV0YWJLcm1kVzdCakJyWXk3czkxVXN4?=
 =?utf-8?B?aXFjQUludjVKT0RXSHl3eC9TWEtaMDJTNy9HZWc1ckpGdmxXcklXLzNXbUFN?=
 =?utf-8?B?djA0S1cvbUhGR0YxWU5WeEx6d0kyMEwyOElLTHlERWxwZ29LaHdqRElxcDl5?=
 =?utf-8?B?bFVHMmNMZkdSMUMyNmswdEhaM3p4eDFsa1daN0RUUlRvakcraXZYalRKeW5n?=
 =?utf-8?B?MFZjbWhKdDlsQ01JeEtobFNhSUtGWnJ2RjdGQjhQcFFaOWZyMllYVmRINE9s?=
 =?utf-8?B?aDg5a1lnS1czNTFyQkE0OVNlS2Y2eEZMenp6WjNkQzRqM29ZNDI2cGRjMk5u?=
 =?utf-8?B?VFR1MWo5dmpUQ3NwaTE5NlF5RXlWRDBud2dSdkxKQTU3UHlDSzZEN1RmN3U3?=
 =?utf-8?B?YjdVZkxGSW1WRm9PVU9uVFF1U1Npd3l0OHlXSE8zLzR0U1JGdFBMbWdiRlVh?=
 =?utf-8?B?S1JGYkJXZ2dJaDNXbC8vVGZpcGdkR00valIyY3pCVHJtK3dhUzdrUllkcnRU?=
 =?utf-8?B?ZjA1ZjZWNXFJcFRWMmxYa1NvT1kzNDNxSzBRWWhVN2NBZ1QzVzhCREVXRDlp?=
 =?utf-8?B?K05FK2x1eUVJTS9wNVNTY2srU0crb3FLbjJjdGxvc201dHhmNzVQSUxEZ0NT?=
 =?utf-8?B?YjZLa3ZkS3hFTGlnKzNDRnd5M0ZMa2x6R2lqWEtobnVFaHNHc2lOU0VDelNX?=
 =?utf-8?B?bVlrVEF1dzh4eFBuZEw5aVRyNy81d1liL3NWa2JqbEZxZnk5OGxUL0xjaUNn?=
 =?utf-8?B?S0lDRjlSSVhYZXppT2ZKaTlGMW03QS9HNDJ2Y09FOFNRSGt4RHY4T0RCbUdy?=
 =?utf-8?B?b0lYSWVNb2UvSld4YjkxUkhCUExZc0REZW1XL2VNNjNpMlZwS1ErL3F2T0d5?=
 =?utf-8?B?MlBHbjNYRVF5VndwKzBWRVNxT3ByYjUrcDhUTTB6U3lTbm5tQ3JmR2tQR3c5?=
 =?utf-8?B?WGtrbk5BeHR1elRzMGZLNCtwTDRjaXkrTEJZT0NmU2R2NndZTkUwQnRReVpZ?=
 =?utf-8?B?Mi9oYVBFNDNTY29nRjJOYmxEeWpRWUdrdUlTUkoveFQ0c3phQm4yUm4rdlBS?=
 =?utf-8?B?dk10ZzJQOGcxMHp0MEFwQWp6Y3RUZTkxNUFJckRzV3lFSVVCaFpyeUtYL0hF?=
 =?utf-8?B?Z1FnWEM4WHpxbjZldENEYjFJdng4Z1ExTUlBN3dPak1YMGVBMFE1dUgwWUpk?=
 =?utf-8?B?enUyYkY1M1g1VElCbkNibFRxRDM3MjdScW5hREgzclFPT2VKK2R1TjRNQXFD?=
 =?utf-8?B?K0kwUFAwMEZWbXlnK1NTUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2wvZmJQQ3hiMkRjNTRQMFJ1OUJxckVDUUtGdTNEODM4elNUTnZDMVpoN2Yy?=
 =?utf-8?B?MzFBM2FNZnpKaFg5NmZTM2lOZU9VRUlLZU1ObFZEK0VCc1B5SXV3T0JGQ1k3?=
 =?utf-8?B?bDZhZ1MxN0R0YzdaYkoyRHZFb1NFSVg0OU52d0ovaEZmVWZNZzlScmdZSm02?=
 =?utf-8?B?RFk2VE4zVk4ydGluZ0pXOHk0REZ1S2ZteFcyOWFUdHNwbGt5TlMwQVh6THFM?=
 =?utf-8?B?UXllNWtjL0dRVU9WaC9ISFFvTG5BMTBNZU05dGp3NmRSZ0FTLzh6WlVOUVZB?=
 =?utf-8?B?bWRtc1l6dno5Q3BDTUtsd2dEbUdJaHVPOERPclkrUEZSN0tEakpPeVFlWVVJ?=
 =?utf-8?B?Qmw0c2lIRjd3OE9QSmhRRzFsUXJXQkpkNitNV1BSSlZCVExMZE5pN0hPbWhJ?=
 =?utf-8?B?WjlIaXhCa1RBQlpTUkcxUXpHMVQ4M1hEMlhqMHhpdTBiZXdhaU1NWllleGJ5?=
 =?utf-8?B?NC92KzlWYVhRTEdzeHhvSmpwdzVaeU41eEN5VWNZYXRTa2o4WDI2SHBqVG9J?=
 =?utf-8?B?ZktXWU5Lb0pjZ29ORkd5bENKRnRmSFE3U2VtazBLQzAxYUhBN2N5YXRsQnZV?=
 =?utf-8?B?Y0hXbWdORWpjQ25Zb3NoRkU5Z2ZCMDFDZ3ZxVmd6UFJaakh3Qkp2TG5QQkxM?=
 =?utf-8?B?eDR2R1l3cXNxb05BZGoxY2JaQWg0eDl1c2g3a3hiT2xTRkxKenEvMmtUaGJt?=
 =?utf-8?B?dXFGbWFxWGx0eEVCTnkySVFNNXFVU3hmYzMrOFg2UmdSQVNuem5TR1ByRURV?=
 =?utf-8?B?cGRPRnlnWXE3ZnltZGxVcGhHbHJiRjBGc05wamNFWDJVUVlmZHJMWUVBTWNh?=
 =?utf-8?B?UlZ4WXk5dDRlcFFlK0hlWFhseTBDR1ZmTUNndnRtdmFzMjlyRUg2S3VWeGww?=
 =?utf-8?B?N2t3aWdrdEhwK082MmpwKzhvUlRqRHhDRnV6d1lIeFhxV2dVNnhoYnJOLzZU?=
 =?utf-8?B?c1dtZ20vaktuMVIyb3hodzRtNFIvTTNhRjBxUnYzcW9ZV1hhY2JUcWNzTjYw?=
 =?utf-8?B?a1dZeFdXbThzcXFtM2xPc2UxSWl6eWtsTTRuVHNsOGdIWGZzWmtoU3IwNW94?=
 =?utf-8?B?eDRDcUlVZXBLdjR6ZmxmSjBPU1Y1aTA3T0xoRE5JSVd4R2RDQlc4bm9yQWUr?=
 =?utf-8?B?eXZCK3R5TFdJMEJvYVBCdnBzems0dnJZQ1dqbC9MMmRXUWNpcFdSeFdMY2Fi?=
 =?utf-8?B?dkVsQW0wYjlML2hjQWpyVTNrN1pkR2dDWlN0N2VzdnN3Y0gvMjdZMUY3Rmx4?=
 =?utf-8?B?NlNTaDhyV1RlUDhwcUZYVlQxUmdqN1lWc2tqUHM2UDNVSnJla0FtOFE4WG0x?=
 =?utf-8?B?N09XK3o4VURxNytnL3ljNFozcW5Dc0MvVkFmRnJqcEQzUmluSHZrZ3RwcDdy?=
 =?utf-8?B?UGxIVGJCcDNHUkQ0eUNwaTBqcGxEOWczS2RBWVNBcHh2SmJDdkE1SUIybVp5?=
 =?utf-8?B?UDNTTEFWcHUwTXBxak0rcXhYMEZmYXRndjZQMm9sUU1EL20yNHJLYjQ4OFV5?=
 =?utf-8?B?eS9pRFBPN05sY1NQcFRBVEdEcVJEZnBuWjNWZFU3cDdSMkNGSytUak5aZG8z?=
 =?utf-8?B?RytpWXh6Nlg0YTBBbDkvT0JPMnlld1gwcHdHMnZEcXA5cWFhQ05wNHg5RnlN?=
 =?utf-8?B?UTh5OGZsdGhDdEhCd0dPZnpzUUFvVTRaOGNXZzQ0UDdLNG1iR3lGN0hPZ21p?=
 =?utf-8?B?dllxazBWcjFKeGdIWXdEcDZKc0kvVXgyUGd6RGtCMm1DQ0pxM2RCdEtxWTJL?=
 =?utf-8?B?dWFJV0R4OEdqaXBsaFRFVUw5aFNSRzRxeGc0Q0tIOC9VbkM2NmZYQmJqYTg2?=
 =?utf-8?B?eXd2R0ZqOHpSRGVvZ2NQbVRZWk05Y2lCSERWdzNmNzh3bmpVVTdvMjdCR1NK?=
 =?utf-8?B?NzN5RldTMjA0RENaRjdxWUcrOVNkVWdYL2tzTjhPN0YrQWZ4MUo4K3BWN2Fs?=
 =?utf-8?B?c3hCTTJUNi9EdHdUYW95Q1JLU0REMEhKYXExQlo4bFB6bU9PVGpLd3N3RHJG?=
 =?utf-8?B?Vk1JMFdjdkdGbFduWnZ6WC9jZi9lNFNTQ3lEUzhObnRtNjBnTWJVaWVscVBC?=
 =?utf-8?B?eHN0ZlU0endrZ0VWY0cwdy96YlROSjVMT2lsckI1RWpQcjk5OTg2RDZhNWoy?=
 =?utf-8?Q?0YGu5UmWi+1lyHIO92faw8tNa?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 60360ea6-91bf-4f7a-71ad-08dc76bc66a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 21:57:52.7216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VerOsjbHqR0u2p8xA3mVpI10iHNX1KaR39FNShNVc2vyoA6gqaRQGl1SScHKxIpcA/9U1A+CDlNvJn/9fC98Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7247
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
ZSBiZWdpbm5pbmcsIHdlIGNhbiBhZGQNCj4gIi0tdGFpbC1zeW50aGVzaXplIiB0b28uDQo+IA0K
PiANCj4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLS1jb250cm9sPWZpZm86L3RtcC9j
b250cm9sLC90bXAvYWNrIjsNCj4gDQo+IFRoaXMgaGFyZC1jb2RlZCBwYXRoIHdvbid0IHdvcmsg
d2VsbCB3aGVuIG1vcmUgdGhhbiBvbmUgdXNlcnMNCj4gd2FudCB0byBydW4gdGhlIHBlcmYgY29t
bWFuZCBhdCB0aGUgc2FtZSB0aW1lLg0KPiANCkhpIE5hbWh5dW5nLA0KDQpZZXMsIHRoaXMgaXMg
bm90IGEgZ29vZCBpbXBsZW1lbnRhdGlvbi4gSSdtIGdvaW5nIHRvIHVwZGF0ZSB0aGlzIG5hbWVk
IA0KcGlwZSBhbmQgYWxsIHRoZSByZWxhdGVkIGNvZGUuIA0KDQoNClRoYW5rcywNCldlaWxpbg0K
DQo+IFRoYW5rcywNCj4gTmFtaHl1bmcNCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKHN0YXRf
Y29uZmlnLT51c2VyX3JlcXVlc3RlZF9jcHVfbGlzdCkgew0KPiA+ICsgICAgICAgICAgICAgICBy
ZWNvcmRfYXJndltpKytdID0gIi1DIjsNCj4gPiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3Zb
aSsrXSA9IHN0YXRfY29uZmlnLT51c2VyX3JlcXVlc3RlZF9jcHVfbGlzdDsNCj4gPiArICAgICAg
IH0NCj4gPiArDQo+ID4gKyAgICAgICBpZiAoc3RhdF9jb25maWctPnN5c3RlbV93aWRlKQ0KPiA+
ICsgICAgICAgICAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1hIjsNCj4gPiArDQo+ID4gKyAg
ICAgICBpZiAoIXN0YXRfY29uZmlnLT5zeXN0ZW1fd2lkZSAmJiAhc3RhdF9jb25maWctDQo+ID51
c2VyX3JlcXVlc3RlZF9jcHVfbGlzdCkgew0KPiA+ICsgICAgICAgICAgICAgICBwcl9lcnIoIlJl
cXVpcmUgLWEgb3IgLUMgb3B0aW9uIHRvIHJ1biBzYW1wbGluZy5cbiIpOw0KPiA+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLUVDQU5DRUxFRDsNCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZzdGF0X2NvbmZpZy0+dHBlYnNfcmVzdWx0cywg
bmQpIHsNCj4gPiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICItZSI7DQo+ID4g
KyAgICAgICAgICAgICAgIHJlY29yZF9hcmd2W2krK10gPSBlLT5uYW1lOw0KPiA+ICsgICAgICAg
fQ0KPiA+ICsNCj4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLW8iOw0KPiA+ICsgICAg
ICAgcmVjb3JkX2FyZ3ZbaSsrXSA9IFBFUkZfREFUQTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1
cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPg0K
