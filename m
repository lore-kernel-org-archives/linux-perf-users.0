Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96826286;
	Thu, 25 Jul 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929959; cv=fail; b=RTIyoNi3k/7HoT+3p1RAXS2cW9ffKGlJyvfh+yBQ3D+ZSipp9ghBPuUPfmqo32YV7tWrWWFSAFiJMHe1zIpl/5rPxG4kZJqHi4LDLQUXhXT2zAC6RxZvARJwhXeVv79LsTgSEvjB1zR7vWqh6YdTFmBp/8Ucwvxk2lwQ3pMQTJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929959; c=relaxed/simple;
	bh=dgdKzC8eYyYM1wPgBcQjo1gAxzxAcgxatjvE3wLk524=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iURHhQQkmJLM0gLRzxA2xdTlPuu5iDTLBE5cWUo/CQpVld8aRHHYIH+vVhgHzxSd3oNsCZ8x5tqdgASNVdYIF/8XTHY+WmPVay4ze0HjkDJh3aKZcXoNHzcNyKuihUxr9n7R8iva7P6eJ5Ai7VICT1iwvJfZH6nY6VpT9YpBiBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/KzRuI/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/KzRuI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721929957; x=1753465957;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dgdKzC8eYyYM1wPgBcQjo1gAxzxAcgxatjvE3wLk524=;
  b=e/KzRuI/KovLKmVmMQzge/tmRlp35eZPCb3zSDnTYaUvjyeG0s8JvTBE
   MZYT5fE5Pxw4ok1P0rYak02Adi/y5o7K4l4/u2XEq7SvgwETlUh1GZ8cL
   oYAjAFN/1qCgdBSrviKYVA2wV8QXS+5FDel9LBIrsKI7AZ/lz9avHkFsJ
   VJppcsvhBzXs660KSh4NtyEeu8PZzTtUB1T5Lu+MZkQj2Lzcvm7yMsyUu
   HJ9vLuxHyljeeNSK3mxZQlLuvYYnX81moPOL0/zgvP2jdSWtU/NMZidNx
   f4rUbEsv/cwgM43hG0tCIEb8AGBSRvvp6fU3Bz+uEmDEfDgyiWTpUO7GJ
   g==;
X-CSE-ConnectionGUID: Yz7e11ApRGCXfzmqjo8PfQ==
X-CSE-MsgGUID: 4uFdUszSTdW/Vq7L1o0fmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="45114467"
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="45114467"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 10:52:37 -0700
X-CSE-ConnectionGUID: acakx4cZSmyzf7EumBgC9g==
X-CSE-MsgGUID: LI11KzJ2Qf6xuJwuls1vzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,236,1716274800"; 
   d="scan'208";a="57800239"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jul 2024 10:52:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 10:52:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 10:52:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 25 Jul 2024 10:52:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 10:52:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFqS0ZtH9xUQJ/L3YgF4QJ9voVnTD14h0nQe8glX+HPEdvhKUsaX9X3ExsFl2XGUUylqqaUXpXKtnbwBGYE30qEzBDKL/+oq9w/YcCTO+rwH7EIqyXAgYXL6XR1190xGhD1OheXKLWVqMJe+TVf9v+k1mVUllmg8r7NHo9gxDB/B1JG8R/oBb6bfvxk7gFrP7XqNrvCB6F3BMhpHOkUQAvRlnKUCdFMmJLe59MB8xOjUe8h6dU4wN0XlVsRMudfnEX9M3S3Lnocw5uW0DGM3SWM1ecw/UEw+PtXDDu4H6XNGnitdP/xm2I/+REAfm3GQP4BwuYBdUs7dDcJiiUtHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgdKzC8eYyYM1wPgBcQjo1gAxzxAcgxatjvE3wLk524=;
 b=E6zSzEE53I6wATFdxyaqj3RrN55lFxDSrmKFhZALEY8SZFK3+OZkHJIBPC2uqoTa7hldWavYLRWWx6eJc9uuKBDDk4TNkjd2ZqvGU1hNtD3e86u47QIkRRqApFDV/x+rSO+8XHQfhjvLTK5dCyGswMN81S+puZ4yInbz4MM1yHvQJ8SDuKoozUaW7S8YKcCvveAHWyFgAWeTNUq9mRhQLrNxRHoW9dEw2AgrwnBpF/VCiJ4+6qQ4RqvNQ7Btd374DdVXMVyTyRy44Bu691eB21zm34MC6l/Hg81OAkG7eZ5rZoqVUVbdJRHuAj3B7MLZfIW2YCK8zolTN0gHsdrY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by DM6PR11MB4611.namprd11.prod.outlook.com (2603:10b6:5:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 17:52:32 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 17:52:32 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>, Song Liu <song@kernel.org>, "Taylor,
 Perry" <perry.taylor@intel.com>, "Baker, Edward" <edward.baker@intel.com>,
	"Daneti, Venkata Naga Sai Dilip" <venkata.naga.sai.dilip.daneti@intel.com>
CC: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, "jonesz@meta.com" <jonesz@meta.com>
Subject: RE: Some unc_cha_tor_* events appear to be "not supported"?
Thread-Topic: Some unc_cha_tor_* events appear to be "not supported"?
Thread-Index: AQHa3rRBYvlGDnS4q0yQwR0fDD3VnbIHscXw
Date: Thu, 25 Jul 2024 17:52:32 +0000
Message-ID: <CO6PR11MB5635E5844F7C8CB1277C1DF4EEAB2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com>
 <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
 <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com>
In-Reply-To: <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|DM6PR11MB4611:EE_
x-ms-office365-filtering-correlation-id: c00ab115-37f8-430e-c4b3-08dcacd28f21
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MzRFeEtPRjBoSFVObTRjQnl1YzZLbDFtWXpibjQrTExZZm8wNE9nd1FTb3dQ?=
 =?utf-8?B?ajY5VGxOMGJ2U0ZvcVhmd2l2d2JlUFNFcDBzYk5iWUFZcVpBeWdFdzRLMStC?=
 =?utf-8?B?Vkw2Mk85clZXa1FROWs2L0QvR2twQ2lmTVhtRlFYOEpIY3FJeEJTM3R1K0Ix?=
 =?utf-8?B?VjNSNk0xZVd2SzY0akk4ZW84TW1TUUgzekNETVhoZ0tOT0ZpdnJNdnMva2cv?=
 =?utf-8?B?V2lhSU1QWElvc3kxYjV1L3hLSkdsazN5MWE3NzJua3Z2aGVLMUdyUVlVVDM0?=
 =?utf-8?B?SXFLMk1jampsRG9BY09lK01RMFFnS2VxZnRUMGRBMVV1b1dRSU92Mkxkazkw?=
 =?utf-8?B?SzlDNTd3dlBteWRYOStVODNhaWJ2S2JGeVVMVG96TkFjOUM0VG15SHBRdjNs?=
 =?utf-8?B?aGRLWUkzVyszVzlLNmRmUXpCRklqeVBNWXhSWTA1QVJUMVZxeHU0SHI0VDIr?=
 =?utf-8?B?VkhHZmJvUWR1Y0RGcFRJVS93bEJrcHpHR0l6N0ZUZnVXNFlkMmNLSWVoMUhT?=
 =?utf-8?B?UWtIZ3E2c1VUdXY5bGd2dGhSa21JV2FCaVRIbzR2OUx5NXFvRG1ZVi83dUxj?=
 =?utf-8?B?T21vTVFHRDM4dlNjTU1CbzVnVkxGTzAwQWtBNU9sMk1nVnphSVlqdVVlTXl2?=
 =?utf-8?B?ZUNLaFFkYU9rZXAvbUJoWG9OM2J3WXBPL2ZMd3lIaVBTelQ5NnNNaHlPUlpa?=
 =?utf-8?B?cjNHdmF4YjB0Q1NTTDVMS1Q2M0YvVWdCVk5COUlFWGtZOWxhTHE2a2phWEpx?=
 =?utf-8?B?NDRiSy8vRUdHZEVJa0tUYUJXU1phdDE0WU0rOU5xaDAwOUlFVnR6TEZ3ODFJ?=
 =?utf-8?B?aHZDekh5UlgreDJEb0dJSyt0YlhZeHpGQ3Zja2s5U3VGcmZ5bnFoTWRrMFVi?=
 =?utf-8?B?VHJLaFVWWVQvbnhaV0R3SFBheldtNU5saUxSSGFSbGN4R1NkVURoUDdqcnlR?=
 =?utf-8?B?U25wOG9pVWNKRFc3dHg1K0FoUkM3dHQ0dnVOZ2w0bk56NGtOQ0I2SkxzSjRO?=
 =?utf-8?B?bk5GZFJPVndzTnRNSHFwdVJTNWp4UGczbkZXSE1qWFJ0dC9LNjB0K0RGZW52?=
 =?utf-8?B?a2NpMjhCbXZjNExFejBTbDVPZTJRM3p6Q0x1ZjlvV2Zlc0U5Y2dwNHpQMitv?=
 =?utf-8?B?cWI0STN1VGIzS01lV2Y5ZHBpbVF6cjNkNndvYTBEejgyWHNENTRtRTNHV3Vy?=
 =?utf-8?B?NTRpYnJKZ015VHRiUGozOXluNFZJZlh0QzNic3Q2K2k3amsyeVMzQUlYV2lO?=
 =?utf-8?B?azlpUmVkSmcyL0tjK3BHODcwUEtZM1FUSEpRN244MnNGRFUvcEFkWktQMDZU?=
 =?utf-8?B?SGMvUlhoaGlPbjdLYnlveXJPSHVwZ0FSSlFlRTY3MEY5MG1ZY0p3dVlJd25Z?=
 =?utf-8?B?NjZsbHNBMTVRTHpNRWN6a1V6NGFqclhZcU43UWlib1Fua2oxQzQ0eTNwd0xW?=
 =?utf-8?B?a0J6UmxCTDVoeHJhcFN2MERHQm9aV0FobXdJekJGOXB4NUZXN2ZmZW1Vc1Yw?=
 =?utf-8?B?eW5LTEF0dkJEM1pZZEFsTzdUS0d4WjNQOWRtWk5BSnVCQlZUUkxVbHMwYmZP?=
 =?utf-8?B?MTVROTBsdG1oWXVLaGVOeTBia1FlTmYydmlLcWMwWFFQQnVIdUhRdFlVTDRY?=
 =?utf-8?B?NFliT21OcmhHUnZ2UThjbGFyZ1Rzc2lzRG91TXR4ZjFTQlJYK0g5R1JSbWNp?=
 =?utf-8?B?WDBlWnpabnE5eHo3V3NQQWNuV3NhMGZzUWlUckVmWTdieis2cXQ0aGVCTmg0?=
 =?utf-8?B?TG4wSTYybzJjYjN0WTZZM1Blazg4cmxDenIxaWRQQVllZmJiREtCWDVYMzVJ?=
 =?utf-8?Q?9jLFnQhh7PIBeCIsHWlCEyg6g/C3yvPA2pJfo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVBkNzN0OHZKdU5RRGZJRHFGczlvRnNUTDQ4elZVdFFRRHV2V1pQdTU0ZmRo?=
 =?utf-8?B?dE5oTHhkdzEyNFRCZ3hGRkhZV0R2R3lWbk9kTUlmUCt5ODJGMk1NNUdUN25V?=
 =?utf-8?B?V29iODNNVERvd3VyUG5KeHl0SWxhWFc0a1c4NisrSm1wUHdmR2hTdUJqbU5J?=
 =?utf-8?B?Tmt0Y0R5U2pON2IzMUgvY3ZNNy90UEEzTGxpTno0ZGwwNEIyNGd2VEVROHdM?=
 =?utf-8?B?NmZSL1VpRFp4RTVXQitYdjlCOGlLTmhWM01vOUl6Q1Rsem1pSjJ1WGJ2T1dk?=
 =?utf-8?B?Yk14ZSsyOFVwL2luTC9xcFhvM0F0bEtCOGpxYjNkb0RSUUN4RGtzUUFwVGRT?=
 =?utf-8?B?ZjltNTBrU1AxdUI4RDFlNVBnSUJRQXFXOFBOMG84U0dBbTViTXNFY0JPa3dh?=
 =?utf-8?B?UmdScHZhdHRmVFNteDkrVWRCRTAya1FRM0tZcHJ6YUlaU21kR25XWHpQbjJG?=
 =?utf-8?B?WGNWdUpudU0xeXdaait6cHNidnJGVmtTSURsVEY0M1JPT041TTBqSlh0a28r?=
 =?utf-8?B?UUFjL3ljMSs3NlBTMGF6OVJaaDZuSlN4L2I2dUpJZnFKWi9HdUY5ekltUU1m?=
 =?utf-8?B?ZjBmM2orci8rNVVnSGx2czg2SUtzandKcmMrN0VHR2g4OFNtNUlqQXZ2RnJG?=
 =?utf-8?B?TnZpVmRpMVFvOU8vUUdUZVdwbDg4a3FPZ3hyYmtLTkZBRitpWmNaSE1hVUZ1?=
 =?utf-8?B?SDZDNXJOanYxZXdEQXpwVDFtZ3ZGOHBleHdaTk5pTFFpNmxraElVcWxWWE5r?=
 =?utf-8?B?THYweW9kQ2V3Mms0TE5RUEU4KzlNZGRTUERyTHdJY1RqODRQRjNVZVAxdWJq?=
 =?utf-8?B?dGpTQXRodWlEb2tkV0dZVzUwUlYyZmhtS0tZbklPQ1pUT2kvWVk0VEptdGJt?=
 =?utf-8?B?U0RsUEJpeE9wdkxFK2FNT1RYb3NhMXo5QXJYT2lNekpTenRjd0swVzJldmRo?=
 =?utf-8?B?TUNPRklyQXBING1rOENZS3Ryenp1NGZMVmR2VGlrM3JtNVlvMkRzNVBVYWQ3?=
 =?utf-8?B?SzhVWG1DQUJUQUNHZmd0c3haM3YwK1d3dEIwQ0RtbkdVZklzY0FEOWs0RXR1?=
 =?utf-8?B?bEtneW9HMDBNRTFac3NRVUp2K1JXaElvTmhKVTYzUyttZ1JTRjUwc3k1bjBQ?=
 =?utf-8?B?NmpaclRweGNsTzYxam5lYTY1eGYyOGxYY3V6THV3NFd5OWxzSTkwdWJiODls?=
 =?utf-8?B?bStYUDEzTWlBeUk2dUNMTTZXKytmMWthdUk0TUtnanFTREhEWTduNzBMbjEv?=
 =?utf-8?B?VjFOU2R0MUQzWXZpZFhnNmtGUlhxMGNjdWkvNnhaajVTMDM0dStPRnRNZ0NS?=
 =?utf-8?B?WUh0a2p4d2dTa2x4dWZSdXYrczJMalN1NW5iRkx0Z3YzTTJvNFp0dHFuT0pS?=
 =?utf-8?B?cytxcWdSTDczTGRodFBLRHZ5dmw4cTFMYkRRSHhjcW5vYnQ2WXZPYndLaGFo?=
 =?utf-8?B?aW9Xa05aOExkdzJvd1d0RVI2bkJoQXo0NGxlWmlnbDVyWHhzZlJoUGtNcTc1?=
 =?utf-8?B?ZU1YWGRZVzBEWFZSYnZjRTg5ZC9NaFJ3MHZPNmNkMy9LcVMzTmdkQnl3ZXhE?=
 =?utf-8?B?OUo4TjZNSVhGNUkraGwvZCtQZkVzNjFpdFM0WTZZUlVPTjhqdXlLWm1CblJI?=
 =?utf-8?B?SWE4dzl3WmMzdzdGU1pUdlFqSU1kR29wT01pOW5sNndraFZCMmtLd2s5ai80?=
 =?utf-8?B?OGROS05ZcHlvcFpFNW80OS9TdFJVd1RsZTgyeDBNSjBUd0pNdzFiQmp5Zm9G?=
 =?utf-8?B?VWkrQjdwYk91M0tXZjgxbDlHOWF1OHJVY3BtSjVKT3N5bWlFcGxjc21hWXZv?=
 =?utf-8?B?NkppbGVlbUxmNGUvck96QkdXOFZNbjNlQ2s2dTh3S2tZM2NZdzN0L0JQSU0z?=
 =?utf-8?B?bU1vNjJJT3NxbHRueGJjRENYQ2hLdVZzaVFkMStqc2JYQkcrWFRTZnZ5a3J4?=
 =?utf-8?B?M3RETTNxNmVsampnZVUreGhOekZhVy9WekVJRkh4ZHR6L3g5YlZYMEphMDM3?=
 =?utf-8?B?SnlnWHRwVUVTeXhKdExmTldYTEpGRlZhcENXNGt0L1RUU2RMbWtoSmw0Sit6?=
 =?utf-8?B?ZEJzNVMwZDZ0OU9pT3p2K2d2d1RkTVBadHBZOVU0eXhDd0w3MUppaHplVGxW?=
 =?utf-8?Q?3unbKqyr4XgtuDj3zRr8gNSuG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c00ab115-37f8-430e-c4b3-08dcacd28f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 17:52:32.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qZFqvomK5ItgesA8TCtNxjjFT4dDqonkGVQmY2kRvPmGCO2mKBH6UaYeK8ZJnREA9vqRnpxABFX8u11qxTHoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4611
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNSwgMjAyNCAxMDowMCBB
TQ0KPiBUbzogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz47IFdhbmcsIFdlaWxpbiA8d2VpbGlu
LndhbmdAaW50ZWwuY29tPjsNCj4gVGF5bG9yLCBQZXJyeSA8cGVycnkudGF5bG9yQGludGVsLmNv
bT4NCj4gQ2M6IExpYW5nLCBLYW4gPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+OyBBcm5hbGRv
IENhcnZhbGhvIGRlIE1lbG8NCj4gPGFjbWVAa2VybmVsLm9yZz47IEh1bnRlciwgQWRyaWFuIDxh
ZHJpYW4uaHVudGVyQGludGVsLmNvbT47IGxpbnV4LXBlcmYtDQo+IHVzZXJzQHZnZXIua2VybmVs
Lm9yZzsgb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTmFtaHl1bmcN
Cj4gS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3Jn
Pjsgam9uZXN6QG1ldGEuY29tDQo+IFN1YmplY3Q6IFJlOiBTb21lIHVuY19jaGFfdG9yXyogZXZl
bnRzIGFwcGVhciB0byBiZSAibm90IHN1cHBvcnRlZCI/DQo+IA0KPiBPbiBUaHUsIEp1bCAyNSwg
MjAyNCBhdCA5OjM54oCvQU0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4N
Cj4gPiBIaSBLYW4sDQo+ID4NCj4gPiBUaGFua3MgZm9yIHlvdXIgcXVpY2sgcmVzcG9uc2UhDQo+
ID4NCj4gPiBPbiBUaHUsIEp1bCAyNSwgMjAyNCBhdCA2OjM34oCvQU0gTGlhbmcsIEthbiA8a2Fu
LmxpYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+
ID4gPiBPbiAyMDI0LTA3LTI0IDY6MzkgcC5tLiwgU29uZyBMaXUgd3JvdGU6DQo+ID4gPiA+IEhp
IGZvbGtzLA0KPiA+ID4gPg0KPiA+ID4gPiBXZSBub3RpY2VkIHRoYXQgc29tZSB1bmNfY2hhX3Rv
cl9vY2N1cGFuY3kgYW5kIHVuY19jaGFfdG9yX2luc2VydHMNCj4gZXZlbnRzDQo+ID4gPiA+IGFw
cGVhciB0byBiZSAibm90IHN1cHBvcnRlZCIgYW5kIGFsd2F5cyBjb3VudGluZyB6ZXJvIChzZWUg
YW4gZXhhbXBsZQ0KPiBiZWxvdykuDQo+ID4gPiA+IElzIHRoaXMgYSBrbm93biBpc3N1ZT8gV2Ug
YXJlIHRlc3Rpbmcgd2l0aCA2LjEwIGtlcm5lbCBhbmQgcGVyZi4NCj4gPiA+ID4NCj4gPiA+ID4g
VGhhbmtzLA0KPiA+ID4gPiBTb25nDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFtyb290QGtl
cm5lbHRlc3QwMDguMDUuYXRuNiB+XSMgLi9wZXJmIGxpc3QgfCBncmVwDQo+ID4gPiA+IHVuY19j
aGFfdG9yX29jY3VwYW5jeS5pYV9oaXRfbGxjcHJlZmRyZA0KPiA+ID4gPiAgIHVuY19jaGFfdG9y
X29jY3VwYW5jeS5pYV9oaXRfbGxjcHJlZmRyZA0KPiA+ID4gPiBbcm9vdEBrZXJuZWx0ZXN0MDA4
LjA1LmF0bjYgfl0jIC4vcGVyZiBzdGF0IC1lDQo+ID4gPiA+IHVuY19jaGFfdG9yX29jY3VwYW5j
eS5pYV9oaXRfbGxjcHJlZmRyZCAtYSAtLSBzbGVlcCAxDQo+ID4gPiA+IFdBUk5JTkc6IGV2ZW50
ICdOL0EnIG5vdCB2YWxpZCAoYml0cyAxMCwxMi0xMywxNSBvZiBjb25maWcxICc0YjQzMycNCj4g
PiA+DQo+ID4gPg0KPiA+ID4gVGhlIHZhbHVlICc0YjQzMycgaXMgZm9yIHRoZSAnRmlsdGVyMScs
IGFjY29yZGluZyB0byB0aGUgb3JpZ2luYWwgZXZlbnQNCj4gPiA+IGxpc3QuDQo+ID4gPg0KPiA+
ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL3BlcmZtb24vYmxvYi9tYWluL1NLWC9ldmVu
dHMvc2t5bGFrZXhfdW5jb3JlLmpzDQo+IG9uI0w0NjM0DQo+ID4gPg0KPiA+ID4gICAgICAgIkV2
ZW50TmFtZSI6ICJVTkNfQ0hBX1RPUl9PQ0NVUEFOQ1kuSUFfTUlTU19MbGNQcmVmRFJEIiwNCj4g
PiA+ICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjoNCj4gIlVOQ19DSEFfVE9SX09DQ1VQQU5DWS5J
QV9NSVNTX0xsY1ByZWZEUkQiLA0KPiA+ID4gICAgICAgIlB1YmxpY0Rlc2NyaXB0aW9uIjoNCj4g
IlVOQ19DSEFfVE9SX09DQ1VQQU5DWS5JQV9NSVNTX0xsY1ByZWZEUkQiLA0KPiA+ID4gICAgICAg
IkNvdW50ZXIiOiAiMCIsDQo+ID4gPiAgICAgICAiTVNSVmFsdWUiOiAiMHgwMCIsDQo+ID4gPiAg
ICAgICAiRUxMQyI6ICIwIiwNCj4gPiA+ICAgICAgICJGaWx0ZXIiOiAiRmlsdGVyMSIsDQo+ID4g
PiAgICAgICAiRXh0U2VsIjogIjAiLA0KPiA+ID4gICAgICAgIkRlcHJlY2F0ZWQiOiAiMCIsDQo+
ID4gPiAgICAgICAiRklMVEVSX1ZBTFVFIjogIjB4NGI0MzMiDQo+ID4gPg0KPiA+ID4gVGhlcmUg
YXJlIHR3byBmaWx0ZXJzIGZvciBDSEEgb24gU0tYLiBFYWNoIGZpbHRlciBpcyAzMiBiaXRzIHdp
ZGUuDQo+ID4gPiBTbyB0aGUgTGludXgga2VybmVsIGRyaXZlciB1c2VzIGNvbmZpZzEgKDY0IGJp
dHMgd2lkZSkgdG8gcmVwcmVzZW50IGJvdGgNCj4gPiA+IG9mIHRoZW0uIFRoZSBsb3cgMzIgYml0
cyBhcmUgZm9yIGZpbHRlcjAgYW5kIGhpZ2ggMzIgYml0cyBhcmUgZm9yIGZpbHRlcjEuDQo+ID4g
Pg0KPiA+ID4gSXQgc2hvdWxkIGJlIGFuIGlzc3VlIG9mIHRoZSBjb252ZXJ0IHNjcmlwdCwgd2hp
Y2ggc2V0IHRoZSBmaWx0ZXIxIHZhbHVlDQo+ID4gPiB0byB0aGUgbG93IDMyIGJpdHMuDQo+ID4g
Pg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvdHJlZS90b29scy8NCj4gcGVyZi9wbXUtZXZlbnRzL2FyY2gveDg2L3Nr
eWxha2V4L3VuY29yZS1jYWNoZS5qc29uI240NDg5DQo+ID4gPg0KPiA+ID4gQ2FuIHlvdSBwbGVh
c2UgdHJ5IHRoZSBiZWxvdyBldmVudD8NCj4gPiA+IHVuY29yZV9jaGEvZXZlbnQ9MHgzNSx1bWFz
az0weDExLGNvbmZpZzE9MHg0YjQzMzAwMDAwMDAwLw0KPiA+DQo+ID4gVGhpcyBhcHBlYXJzIHRv
IHdvcmsuIEkgYWxzbyB0cmllZCBldmVudHMgbGlrZToNCj4gPg0KPiA+DQo+IHVuY29yZV9jaGEv
VU5DX0NIQV9UT1JfT0NDVVBBTkNZLklBX01JU1MsY29uZmlnMT0weDQwNDMyMDAwMDAwDQo+IDAw
Lw0KPiA+DQo+IHVuY29yZV9jaGEvVU5DX0NIQV9UT1JfSU5TRVJUUy5JQV9NSVNTLGNvbmZpZzE9
MHg0MDQzMjAwMDAwMDAwLw0KPiA+DQo+ID4gRG8geW91IGhhdmUgYW4gaWRlYSBvbiBob3cgdG8g
Zml4IHRoZSBjb252ZXJ0IHNjcmlwdD8gSSBoYXZlbid0IGxvb2tlZA0KPiA+IGludG8gdGhlc2Ug
Y29kZXMuDQo+IA0KPiBUaGUgY29udmVydGVyIHNjcmlwdCBsb2dpYyBpcyBoZXJlOg0KPiBodHRw
czovL2dpdGh1Yi5jb20vaW50ZWwvcGVyZm1vbi9ibG9iL21haW4vc2NyaXB0cy9jcmVhdGVfcGVy
Zl9qc29uLnB5I0wzDQo+IDk1DQo+IGJ1dCBwcmVzdW1hYmx5IHRoaXMgd29ya2VkIGF0IHNvbWUg
cG9pbnQgb3IgaXMgbmVlZGVkIG9uIG90aGVyIG1vZGVscy4NCj4gQ2hlY2tpbmcgdGhlIHBlcmYg
anNvbiBJIHNlZToNCj4gYGBgDQo+ICQgZ3JlcCAtcmwgY29uZmlnMSB0b29scy9wZXJmL3BtdS1l
dmVudHMvYXJjaC94ODYvDQo+IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9zbm93cmlk
Z2V4L3VuY29yZS1jYWNoZS5qc29uDQo+IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9z
a3lsYWtleC9za3gtbWV0cmljcy5qc29uDQo+IHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4
Ni9za3lsYWtleC91bmNvcmUtY2FjaGUuanNvbg0KPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJj
aC94ODYvY2FzY2FkZWxha2V4L3VuY29yZS1jYWNoZS5qc29uDQo+IHRvb2xzL3BlcmYvcG11LWV2
ZW50cy9hcmNoL3g4Ni9jYXNjYWRlbGFrZXgvY2x4LW1ldHJpY3MuanNvbg0KPiBgYGANCj4gU2lu
Y2UgQ0xYIGlzIG5lYXIgZXF1YWwgdG8gU0tYLCBhbmQgdGhlIG1ldHJpY3Mgd2lsbCBwcmVzdW1h
Ymx5IGJlDQo+IGZhbHNlIGhpdHMsIHBlcmhhcHMgc2hpZnRpbmcgdGhpcyB2YWx1ZSB3aWxsIGJy
ZWFrIHNub3dyaWRnZXggLSBJIGhhdmUNCj4gbm8gc3VjaCBtYWNoaW5lIHRvIHRlc3Qgb24uDQo+
IA0KPiBVc2luZyBjb25maWcxIHZhbHVlcyByYXRoZXIgdGhhbiBmb3JtYXRzIGlzIG9kZCB0byBt
ZS4gT24gYSBTa3lsYWtlWCBJIHNlZToNCj4gYGBgDQo+ICQgZ3JlcCAtciBjb25maWcxIC9zeXMv
ZGV2aWNlcy91bmNvcmVfY2hhXzAvZm9ybWF0Lw0KPiAvc3lzL2RldmljZXMvdW5jb3JlX2NoYV8w
L2Zvcm1hdC9maWx0ZXJfcmVtOmNvbmZpZzE6MzINCj4gL3N5cy9kZXZpY2VzL3VuY29yZV9jaGFf
MC9mb3JtYXQvZmlsdGVyX29wYzA6Y29uZmlnMTo0MS01MA0KPiAvc3lzL2RldmljZXMvdW5jb3Jl
X2NoYV8wL2Zvcm1hdC9maWx0ZXJfaXNvYzpjb25maWcxOjYzDQo+IC9zeXMvZGV2aWNlcy91bmNv
cmVfY2hhXzAvZm9ybWF0L2ZpbHRlcl90aWQ6Y29uZmlnMTowLTgNCj4gL3N5cy9kZXZpY2VzL3Vu
Y29yZV9jaGFfMC9mb3JtYXQvZmlsdGVyX2xvYzpjb25maWcxOjMzDQo+IC9zeXMvZGV2aWNlcy91
bmNvcmVfY2hhXzAvZm9ybWF0L2ZpbHRlcl9uYzpjb25maWcxOjYyDQo+IC9zeXMvZGV2aWNlcy91
bmNvcmVfY2hhXzAvZm9ybWF0L2ZpbHRlcl9vcGMxOmNvbmZpZzE6NTEtNjANCj4gL3N5cy9kZXZp
Y2VzL3VuY29yZV9jaGFfMC9mb3JtYXQvZmlsdGVyX2FsbF9vcDpjb25maWcxOjM1DQo+IC9zeXMv
ZGV2aWNlcy91bmNvcmVfY2hhXzAvZm9ybWF0L2ZpbHRlcl9ub3Rfbm06Y29uZmlnMTozNw0KPiAv
c3lzL2RldmljZXMvdW5jb3JlX2NoYV8wL2Zvcm1hdC9maWx0ZXJfc3RhdGU6Y29uZmlnMToxNy0y
Ng0KPiAvc3lzL2RldmljZXMvdW5jb3JlX2NoYV8wL2Zvcm1hdC9maWx0ZXJfbm06Y29uZmlnMToz
Ng0KPiBgYGANCj4gDQo+IEFkZGluZyBXZWlsaW4gYW5kIFBlcnJ5IGFzIEknbSB1bnN1cmUgd2hh
dCB0aGUgcmlnaHQgZml4IHNob3VsZCBiZS4gTXkNCj4gdGhvdWdodCBpcyB0aGUgaW5wdXQgSW50
ZWwgcGVyZm1vbiBqc29uIHNob3VsZCBicmVhayBhcGFydCB0aGUgZmlsdGVyDQo+IHZhbHVlIGlu
dG8gb3Bjb2RlcywgZXRjLiBhbmQgdGhlbiBpbiB0aGUgY29udmVydGVyIHNjcmlwdCB3ZSBhZGQg
dGhlc2UNCj4gdG8gcGVyZiBldmVudHMgbGlrZSBmaWx0ZXJfb3BjMD0weGI0Lg0KPiANCg0KQWRk
aW5nIEVkIGFuZCBEaWxpcCBmb3IgZXZlbnQgcmVsYXRlZCBxdWVzdGlvbnMuIEkgY2FuIGZvbGxv
dyB1cCB0byB1cGRhdGUgdGhlIA0KY29udmVydGVyIHNjcmlwdCBvbmNlIHdlIGFyZSBjbGVhciBh
Ym91dCB0aGUgY29udGVudCB3ZSBuZWVkL2NvdWxkIHByb3ZpZGUgDQppbiBldmVudCBKU09OLiAN
Cg0KVGhhbmtzLA0KV2VpbGluDQoNCj4gVGhhbmtzLA0KPiBJYW4NCj4gDQo+ID4gVGhhbmtzLA0K
PiA+IFNvbmcNCj4gPg0KPiA+IFsuLi5dDQo=
