Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526207BB17;
	Tue, 11 Jun 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136491; cv=fail; b=sc3Tu/clYVAB1glwTcK6nNgyd2ZChn0WsLAt+g2W7B1LDhlnj6Xyf4d97FByWXwvyyWKHitVN0BqenZc2vL3BlWaxLmKnTu04BPp5H3QUPSczqHV0j8dLhJBMV+VbDv73x+DGi7qY1ExdZj8uFtipOtzBgb5gRl2hSEcIdZdtec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136491; c=relaxed/simple;
	bh=dGnGDaFb5iuLLeaYyDYFu0PpEe5Ohb0PElV6xxgRTuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rG4el4uH0z9hSQIEw0A+EYE4idExOqj87TTI28i1gnzr8NbBKhTler2PrpeNTix+9mUqLKMmIbou9yolrYE1DwlqU6+g/WVnDUX38TVtsqLV4nuZ3fT8Bgia1j8YBpyy0p3QRrgPHB/qihQ0wKB3fEBOrHXggjeBfMv8Iy6+oT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QisESCwR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QisESCwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718136490; x=1749672490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dGnGDaFb5iuLLeaYyDYFu0PpEe5Ohb0PElV6xxgRTuI=;
  b=QisESCwRm35+oWOIph7XMcNQp4R8a7uWBxQp04MwPY/RW6PHUw97BQBH
   1AzQhRc0j1J9fR+9fL8DPeySQYG7dyn83B9Zv6shaq9B0eF8XxC7+LYR/
   pKtu2MLLchE/XNzSRc0q4VDL2QavrVYCOsjbv8CNKkUlVGm/eJS7jtzEY
   EjDo9GYRcbV8IcUOZhTs5sAU3Yf12oFrnKvil5KQP51ElOscfXyVsVel4
   QKfLILBx1X173rOG+0dpwOfnLVP2+EBhLlEsV8B3WEAWPyK/Q4U6ItFQs
   whW41Ukj02m5WIJphP/E/nRNLpFiJTX4zMXyQ+vwTk7gR1x6Fbb5oEPMT
   g==;
X-CSE-ConnectionGUID: uLJlmhp4RROOeoSalPmijw==
X-CSE-MsgGUID: dqIU0gchQwWAEtIFWnCekg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14830172"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="14830172"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 13:08:10 -0700
X-CSE-ConnectionGUID: 77eb9uJQSkmUff6nZ9LF3w==
X-CSE-MsgGUID: ubmII4odT+6TFjWFLV0LnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="39649528"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 13:08:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 13:08:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 13:08:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 13:08:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 13:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpEraIsExRECdh3vcafvCfNvOfo/qpyJofSsmVJcPKl9pd7KCyLFUuih5R8cSHX9JffsAocSihghDUsC12QeDrjyr8QIq9ZF/9zF5SrWxDLl4rxiTJmWn9funTD4lX7QSpePjM016I2GF3YhFdtTwbbqcVr6i5xL8z2iGR67oJV735LPyzF1UduSHyZpEKwtaxmGJjsKmk3mFk5RiJf9OGA2lX6NMmkz6w4fP0Zp97QLv1n//aeTnjHeDz2jLm1OSIUjfZIaIWadnCnjxYcWsIqlPE4W+50cCCEXnPKNfjXDZpqSbwUTr2owrjX1WzDfcYOF+fWrXWPV6836uTx7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGnGDaFb5iuLLeaYyDYFu0PpEe5Ohb0PElV6xxgRTuI=;
 b=KowqUoRwUrtfu37ppKbbH2NnXll0yRZ979GUHlGIxf5VVbnBTRdnK2sJbn69q6xhXzpaJkbex2Z6pGwTKHD5M6BXZzuczqmnxPK6mARoS5tKpdrXq6Jxk3UCiEQFej1DV0N2CevzzZH8FAAutLr43jqYEhdTl819fy1RmZnwAxGmMlMdmzHRPemWP1xE4jeLWHlSH9z38+5uC5a4Ikpi1O58EA8JaGOmcuKw1GZ1YhsZuTJNbnHnab+qojDVHx1m/CrVql6IkWhVlAkThbUPgty4cqiU0AiRPE48zDCVOEz95H1C2Qvh2+5erECIbpgtTCOzs01du5Imic2CFJKxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA1PR11MB8100.namprd11.prod.outlook.com (2603:10b6:208:445::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 20:08:04 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 20:08:04 +0000
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
Subject: RE: [RFC PATCH v12 6/8] perf stat: Add command line option for
 enabling tpebs recording
Thread-Topic: [RFC PATCH v12 6/8] perf stat: Add command line option for
 enabling tpebs recording
Thread-Index: AQHau7+aOC3cYAEJDkWzRsCVj+441bHCx0iAgAAOaHCAABLxAIAAFYhg
Date: Tue, 11 Jun 2024 20:08:04 +0000
Message-ID: <CO6PR11MB56351FCFDAA27B05F00D8922EEC72@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240611052331.85715-1-weilin.wang@intel.com>
 <20240611052331.85715-7-weilin.wang@intel.com>
 <CAM9d7chQFeqCFJAfnRFKkQkxyRtOotF3kE49tL47EuEEBC_RkA@mail.gmail.com>
 <CO6PR11MB56353719739D822626369453EEC72@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cipkoRSDkw2FEE4UN6a_W7Y5E1XBvKHa4GWsJNqm8qNhA@mail.gmail.com>
In-Reply-To: <CAM9d7cipkoRSDkw2FEE4UN6a_W7Y5E1XBvKHa4GWsJNqm8qNhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA1PR11MB8100:EE_
x-ms-office365-filtering-correlation-id: d5b6ba97-e9d9-45e5-8096-08dc8a523438
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|7416006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?U0ZIZWlUdVBvdmNDdStCdnExZ2d0N2V4c2dLMjQ4V0RpY0NRRGlvQi9hejAx?=
 =?utf-8?B?SWVDOVBjcnNzdU1TRmdYOGFBcEVBQUlhZ21PWi92bU8zZUJZeFZUZ1d6OG8y?=
 =?utf-8?B?N2F2RVR0dy9JRmUyT09DQ1lNSWV5TklyMVBJbUNmODBPS3F6K2FhM2ZZaWJV?=
 =?utf-8?B?UlllZDQwd1JMQUpSK1I0YmF3NFBhN0xuTld6NEVRS3ZrSzNVdGtrTS9RQmJj?=
 =?utf-8?B?UExjaUpsRTJIY2dVOFZINDE4NXRYeTBqSWdFRGoyNTcvZ3d3UFN2VkVDZ3Vr?=
 =?utf-8?B?aVdXQ1QycDdkdGpicHk5Sm56THJzZUQxU1FiS1I3UitpdVU4RWFxaTJVemRj?=
 =?utf-8?B?NEFQUCtpWkpOSWZuSlRGa050QjhIY1g1OVY0WkowY1NuQnpuT0RTTGRaMWlV?=
 =?utf-8?B?emZnUXRveGhQNGs4aVJKVE1qSXVTUWFEMFVaTVlSWWVFVThlc1N0ck1NcGVD?=
 =?utf-8?B?aUU1dW82TnBIb1ZhRG84ZW9hK05aaGhtb09lL3BtaFZkZXBZTENqdGlkSkZ1?=
 =?utf-8?B?cVpjQU0rM0s0bVkyUTZmaERtalJIMExjRkh6SWZmVElsNWR6V0V5c0YzZ1NZ?=
 =?utf-8?B?OHk5RzVKUSt0ZUtTUzJRVjlkc05BTS90VjU1cE5VNFNwTTg0alZiRXBUbXdq?=
 =?utf-8?B?R3c4Vmlab2pDOCtRYm1tclZoeGQ0VjJCYlQ4TE1yV1JRV3VCdXhqWEFaRUlN?=
 =?utf-8?B?TVVpcEpHVmpHOHNwc0Y3eFVtWmNmNGJrcEhOSkt5eEtiZjVBRmpzVnJCZWpi?=
 =?utf-8?B?ZVhCYlpHdExCU0lZMURXOEdONDBxMWRoeGFFT0pmMzFoLzhtMTdxZWtZSERE?=
 =?utf-8?B?aE9uQzV5SXRHclpRajlvUUFnNnRtbkFNS2NKbjA3dFpIdy9rNkt5VVFGQlB2?=
 =?utf-8?B?N21jenU1Ti93Z1VPa29aZERzRU9IL3o1TktvclZCdGxXVStpcjBLa0Zqa1Ex?=
 =?utf-8?B?UFhZUHhNSXVGb084QUxqU3locFRKM1NEVk1iV3drbDVRVndzZ29BYWNSVGRF?=
 =?utf-8?B?cU5NM1BHdEpSb3hyRFhBVWR4alBBZHk5Y2lPMXNSdEx1RjFDVGZ5MjFMb3Ja?=
 =?utf-8?B?dnRSR0xsemFoRzRieTYzRm8vL1VXL3NhcVRoUk9iMkdwUlVta2lFRXZQSEFK?=
 =?utf-8?B?RUNMSit3eThUQ1VRWnZPdnFEVXdOMVMxc2xwbEZhRHhJRjJvQ3AvTGxId1lq?=
 =?utf-8?B?ZW1PcVhTbGJ6UVYvUUlMUHZuRE1LelFKSXl0Y1hDTnVDN2JHV0hWYkpNc3Ux?=
 =?utf-8?B?b0hzUCsycHRhZTRpRFFHMytDWDIza1JtNG9HZndCQ0VaUEEzbFN5NmRoMjE0?=
 =?utf-8?B?UVdINUFsV2ptY0ZnTjZpL1QvMnhGN2RBaGlFNWtPaVdTMzJYWDRkVmtobmVL?=
 =?utf-8?B?TkRmdnlUOFVaWXFXMWdRK2dZYkowbGpFM3kzOFljQlpLWS92Y0JYZUVlaC8z?=
 =?utf-8?B?Zk5HbFNJejErYTZKM1VaY0ovLzQ0VlM3TklUMDlBUy9QRlBkWkd2c2tWelZj?=
 =?utf-8?B?MzU0NnQ3RDdKWmcvKzczYVhtSjlGTGdVUUxNemFFR05tRE9MRzQvZEJ4QnJL?=
 =?utf-8?B?MVd4OGdsM3VrQ2w4d2NyTHhaSVhTaTRDM2V1bjVmZXRYd2d0TEJVMGV4dlZY?=
 =?utf-8?B?eUxlOHpUWkR2UFlMKzFDRTVRQ1lOd1UzMENsZXlNeGNnN2htTDAwUzJCWUxa?=
 =?utf-8?B?VnFXbjljUk5UTXhpZU50SkpZc041MFkwbTkydElqbFlTcDU1YUxOMGRhejlW?=
 =?utf-8?B?TlByRkVKQlVidDhnYis2ZERxVnJ4N0Y3SU5NcVl1dld6czZRcnVvY294OFZr?=
 =?utf-8?Q?JPtPbW6o97J7qYt76NviAl715Ou5b1I7lIKGg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aER6djJCZGJ5dFlybWNsMzJVVDBVMHdHbktWM0NKRUdIVVRWQTE3T0IyVXI3?=
 =?utf-8?B?WERnL3hRMEkxc1pvc0JjL25Oc0xLcGF3TVNHM08vMlcyY3VzUVNsRmZvRHZ3?=
 =?utf-8?B?U09oeS9uZTVQNjZYdmJML3VNQjI0T2FUVGZ5SmoyVytiNjIvQzdBK3RUV3p5?=
 =?utf-8?B?TW0wcjRCNTloTDcrY3FGTXFkMjR5cG1uUHZ5Mk1YUmtKOWFucklMOFFpK2hL?=
 =?utf-8?B?aUNGbDd3QkZ4UTQzVzdaOTM1dXhJRy8rcnZmVUxTSTFIakhCYmt5L012L2ts?=
 =?utf-8?B?bzMwTmVqcDQ4OGl6NWJ2eXY4WWtybzhTUVk1ZVFkcEsrM1Rnak9xQktkM3Jp?=
 =?utf-8?B?NFVvdmtudC9FRXhYNHBwMEE5SGkyWjFHVkhzanNzZWtXNGoyMGpGM0VDNmc5?=
 =?utf-8?B?UEQvVUhYN1dlbzUyNkxuZkJTc2V1Rm1TRnZjSlpWSmxGTVpsb04xMGRRWjJK?=
 =?utf-8?B?bzhoWjdZT0xYdU1zMkFydmlnVUlZVTZqdWhTNDQ3ZFlDRkp6aHNpMDkvd0Rl?=
 =?utf-8?B?RDZHS2VCajN4VzBzQks2UStUMWVpcTlCdzBMK2U2WGdGQ0tURGZqY3V1VVNF?=
 =?utf-8?B?bEV6U29WUXhSdXVWOE16OEVqZW5RQld5dU1ad0NGTUwvNUxOYUNPb0FqMCtk?=
 =?utf-8?B?MDdZcU1XZHc3SCszS1dzRE51T01VMkl5K3pONGNybEt2Y1JEaWhaM0taOWV2?=
 =?utf-8?B?ZjFzdjZFcFNON0pzUENJWGc2bmZPN09WVmp2SW5qdkw0WXc2bVN6TTlBVmh2?=
 =?utf-8?B?Yno5eXNhak5qdFNVMmhYZENOeVY5am1JcHZ6amgzVXBkelFNNDNmbUpZTmxL?=
 =?utf-8?B?Zml0TXV1S1lXWEZrTnRqdWIrS2JLNmI5RGJ6WEhJdndGaVJ4ekZvTDA0dGtU?=
 =?utf-8?B?Ri90a0JpY01LcTdCK3hOUHp4bWRDdERib3hySzUwZEU5c2VKTHZJTzJzWUho?=
 =?utf-8?B?dStackI1WDZnd1lsSGlWb0RaQktsMkZ3WlRBeU4veTdsK2RsRFZGbW9CTVhU?=
 =?utf-8?B?RUkrWjZsWm51bnBXTVhnUUR5M1FXTVByVGtjTGhIYlZCQ3FWdEZneEZRZEpZ?=
 =?utf-8?B?dDlsSlBrWnFlY0RIQnFZNEJsWXFCQ05BVUV3Y1czTFJCaXp4Uzh0MzlaZjdv?=
 =?utf-8?B?WnhDaTdCQkJKYWRKRXZRN2VOaHpzTHdWc29LV2dGWGxnOXJhNmNoS1NwbVgw?=
 =?utf-8?B?WW00OHU5OXVEdW9EU3BZejN6cElJbkpTR1UvYmlnOC9UaFNDKzEwakdBMTh3?=
 =?utf-8?B?eS9HSmZ3NnNaZjJQbjdrdnhyZHhTRXdtQmJweWFOUUJrNktvQm1KMnoydkww?=
 =?utf-8?B?TElETFhLTkhlRGlaVXlVMUg4U2oyaTBiUFMwSnh3SWcxK1dsM09OUVN0eFhv?=
 =?utf-8?B?R3lhM2MxdlJtVE4wbzBUSmM2V1VXNVFhejc2eG53ZFRrdXVIeUdZaENMeXRN?=
 =?utf-8?B?M0JORzdTL3RBYm42UWc4NmVUalAyUlpIS0ltSUN3MjNJaHljOU5LL1pDdXUw?=
 =?utf-8?B?UkpMVHNENGg2dDVSeXY1Z0dLYk5NWXU1SCs5S0VOdUZ4STdESW1VZHZVT1dP?=
 =?utf-8?B?WU56SUdKSGt4SkJVVG1zUVpxaDdPVFpBUG56MXRLZkxWaGtnMkVnNUZnM3hM?=
 =?utf-8?B?cVo0NGp2bFM3VElzU2VoYVoyM2NsSDNadi9UcVU4QURrcmtZOHJFMTBiSTFm?=
 =?utf-8?B?SDRvd3h4bU80bDNCMjVRTklMTjY0MnRad2YwcThTNVB0MmtoQ0I0dTQyNVA0?=
 =?utf-8?B?eGlkYUlzUzF0bytzQVprRlVRaThERGwzcEx4UjQyQUE5QTV4Zmw4OXJ5TGdw?=
 =?utf-8?B?Vm9sTnl1WTFPSWpLczRIWEZsOGNZeDhIdTE2UXlzY3F4SXYyUkhtV1pYQWhx?=
 =?utf-8?B?R2pTQnRaN0VvdlhXb3A3NUFYTWloQ0dNOFQzUW51aDh1cko5cVI0R21QV0R5?=
 =?utf-8?B?MExGcHFEWlI2NHBXdGxlS2J2Y2Y3NGhmSGVKUUtoa2RoM3ppWjNmb2RqVWFZ?=
 =?utf-8?B?SWlLRkFUZlpORFZKaTB0cVp3VlVyVXhvM1lsRXBxSVNuNWF2ZFd0OVhEMk9s?=
 =?utf-8?B?d1R1OHQzZEV0bTJsa2NsUFV4WGc2ZTVjQmJvUFcwR2gxRjNRK1NpL0ZKSTUv?=
 =?utf-8?Q?H4IwV4RQurOOjlDmY1EUQA3ZQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b6ba97-e9d9-45e5-8096-08dc8a523438
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 20:08:04.7663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yyqvx/ZVMfYCDZeJiVNLE4vqStOwrWOKruTD0YWau3rtyWS3fGXAMNRaO8iVW7MwMVkXmpUsgO17ORdu7PiVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8100
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDExLCAyMDI0IDExOjQ5
IEFNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0K
PiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxMiA2LzhdIHBlcmYgc3RhdDogQWRk
IGNvbW1hbmQgbGluZSBvcHRpb24gZm9yDQo+IGVuYWJsaW5nIHRwZWJzIHJlY29yZGluZw0KPiAN
Cj4gT24gVHVlLCBKdW4gMTEsIDIwMjQgYXQgMTA6NDnigK9BTSBXYW5nLCBXZWlsaW4gPHdlaWxp
bi53YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0Br
ZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVHVlc2RheSwgSnVuZSAxMSwgMjAyNCA5OjUwIEFNDQo+
ID4gPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4gPiBDYzog
SWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
DQo+ID4gPiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRl
YWQub3JnPjsgSW5nbyBNb2xuYXINCj4gPiA+IDxtaW5nb0ByZWRoYXQuY29tPjsgQWxleGFuZGVy
IFNoaXNoa2luDQo+ID4gPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEpp
cmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz47IEh1bnRlciwNCj4gPiA+IEFkcmlhbiA8YWRyaWFu
Lmh1bnRlckBpbnRlbC5jb20+OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+
Ow0KPiA+ID4gbGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFRheWxvciwNCj4gUGVycnkNCj4gPiA+IDxwZXJyeS50YXlsb3JAaW50
ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50aGEuYWx0QGludGVsLmNvbT47DQo+IEJpZ2dl
cnMsDQo+ID4gPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCB2MTIgNi84XSBwZXJmIHN0YXQ6IEFkZCBjb21tYW5kIGxpbmUgb3B0
aW9uIGZvcg0KPiA+ID4gZW5hYmxpbmcgdHBlYnMgcmVjb3JkaW5nDQo+ID4gPg0KPiA+ID4gSGVs
bG8sDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBKdW4gMTAsIDIwMjQgYXQgMTA6MjTigK9QTSA8d2Vp
bGluLndhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogV2VpbGlu
IFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gV2l0aCB0aGlz
IGNvbW1hbmQgbGluZSBvcHRpb24sIHRwZWJzIHJlY29yZGluZyBpcyB0dXJuZWQgb2ZmIGluIHBl
cmYgc3RhdA0KPiBvbg0KPiA+ID4gPiBkZWZhdWx0LiBJdCB3aWxsIG9ubHkgYmUgdHVybmVkIG9u
IHdoZW4gdGhpcyBvcHRpb24gaXMgZ2l2ZW4gaW4gcGVyZiBzdGF0DQo+ID4gPiA+IGNvbW1hbmQu
DQo+ID4gPiA+DQo+ID4gPiA+IEV4YW1wZSB3aXRoIC0tZW5hYmxlLXRwZWJzLXJlY29yZGluZzoN
Cj4gPiA+ID4NCj4gPiA+ID4gcGVyZiBzdGF0IC1NIHRtYV9kdGxiX3N0b3JlIC1hIC0tZW5hYmxl
LXRwZWJzLXJlY29yZGluZyBzbGVlcCAxDQo+ID4gPiA+DQo+ID4gPiA+IFsgcGVyZiByZWNvcmQ6
IFdva2VuIHVwIDEgdGltZXMgdG8gd3JpdGUgZGF0YSBdDQo+ID4gPiA+IFsgcGVyZiByZWNvcmQ6
IENhcHR1cmVkIGFuZCB3cm90ZSAwLjAwMCBNQiAtIF0NCj4gPiA+ID4NCj4gPiA+ID4gIFBlcmZv
cm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICdzeXN0ZW0gd2lkZSc6DQo+ID4gPiA+DQo+ID4gPiA+
ICAgICAgICAxODEsMDQ3LDE2OCAgICAgIGNwdV9jb3JlL1RPUERPV04uU0xPVFMvICAgICAgICAg
ICMgICAgICAwLjYgJQ0KPiA+ID4gdG1hX2R0bGJfc3RvcmUNCj4gPiA+ID4gICAgICAgICAgMywx
OTUsNjA4ICAgICAgY3B1X2NvcmUvdG9wZG93bi1yZXRpcmluZy8NCj4gPiA+ID4gICAgICAgICA0
MCwxNTYsNjQ5ICAgICAgY3B1X2NvcmUvdG9wZG93bi1tZW0tYm91bmQvDQo+ID4gPiA+ICAgICAg
ICAgIDMsNTUwLDkyNSAgICAgIGNwdV9jb3JlL3RvcGRvd24tYmFkLXNwZWMvDQo+ID4gPiA+ICAg
ICAgICAxMTcsNTcxLDgxOCAgICAgIGNwdV9jb3JlL3RvcGRvd24tZmUtYm91bmQvDQo+ID4gPiA+
ICAgICAgICAgNTcsMTE4LDA4NyAgICAgIGNwdV9jb3JlL3RvcGRvd24tYmUtYm91bmQvDQo+ID4g
PiA+ICAgICAgICAgICAgIDY5LDE3OSAgICAgIGNwdV9jb3JlL0VYRV9BQ1RJVklUWS5CT1VORF9P
Tl9TVE9SRVMvDQo+ID4gPiA+ICAgICAgICAgICAgICA0LDU4MiAgICAgIGNwdV9jb3JlL01FTV9J
TlNUX1JFVElSRUQuU1RMQl9ISVRfU1RPUkVTLw0KPiA+ID4gPiAgICAgICAgIDMwLDE4MywxMDQg
ICAgICBjcHVfY29yZS9DUFVfQ0xLX1VOSEFMVEVELkRJU1RSSUJVVEVELw0KPiA+ID4gPiAgICAg
ICAgIDMwLDU1Niw3OTAgICAgICBjcHVfY29yZS9DUFVfQ0xLX1VOSEFMVEVELlRIUkVBRC8NCj4g
PiA+ID4gICAgICAgICAgICAxNjgsNDg2ICAgICAgY3B1X2NvcmUvRFRMQl9TVE9SRV9NSVNTRVMu
V0FMS19BQ1RJVkUvDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgMCAgICAgIE1FTV9JTlNUX1JF
VElSRUQuU1RMQl9ISVRfU1RPUkVTOlINCj4gPiA+DQo+ID4gPiBIZXJlIEkgZ3Vlc3Mgd2UgY2Fu
IGV4cGVjdCBhIG5vbi16ZXJvIHZhbHVlLCByaWdodD8NCj4gPg0KPiA+IEhpIE5hbWh5dW5nLA0K
PiA+DQo+ID4gRG8geW91IG1lYW4gd2hlbiB3ZSBoYXZlIHRoZSBvcHRpb24sIHdlIHNob3VsZCBl
eHBlY3Qgbm9uLXplcm8gdmFsdWU/DQo+ID4gRHVyaW5nIHRoZSBleGVjdXRpb24sIGl0J3MgcG9z
c2libGUgdGhhdCB3ZSBkb24ndCBjYXB0dXJlIGFueSBzYW1wbGUgb24gdGhpcw0KPiA+IGV2ZW50
LiBJbiB0aGlzIGNhc2UsIHdlIHdvdWxkIGhhdmUgYSB6ZXJvIHZhbHVlLiBJbiB0aGUgZnV0dXJl
LCBJIHRoaW5rIHdlIHdpbGwNCj4gPiBnaXZlIGl0IHRoZSBkZWZhdWx0IHZhbHVlIGluc3RlYWQg
b2YgemVyby4NCj4gDQo+IEkgbWVhbiB0aGVyZSdzIGEgY2hhbmNlIHlvdSBnZXQgbm9uLXplcm8s
IGJ1dCBpdCBjYW4gYmUgemVybyBzb21ldGltZXMsIHJpZ2h0Pw0KPiBUaGVuIEkgdGhpbmsgaXQn
cyBiZXR0ZXIgdG8gY2hvb3NlIG5vbi16ZXJvIGluIHRoaXMgZXhhbXBsZSBvdGhlcndpc2UgaXQn
cyBub3QNCj4gY2xlYXIgd2hhdCdzIHRoZSBkaWZmZXJlbmNlIG9mIHVzaW5nIHRoaXMgb3B0aW9u
IG9yIG5vdCB3aGVuIHlvdSBsb29rIGF0IHRoZQ0KPiBvdXRwdXQgaW4gdGhpcyBjb21taXQgbWVz
c2FnZSAodGhleSBhcmUgYm90aCAwKS4NCg0KSSBzZWUuIEkgd2lsbCBjcmVhdGUgYSBub24temVy
byBleGFtcGxlIGFuZCB1cGRhdGUuIA0KDQpUaGFua3MsDQpXZWlsaW4NCj4gDQo+IFRoYW5rcywN
Cj4gTmFtaHl1bmcNCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAxLjAw
MzEwNTkyNCBzZWNvbmRzIHRpbWUgZWxhcHNlZA0KPiA+ID4gPg0KPiA+ID4gPiBFeGFtcGUgd2l0
aG91dCAtLWVuYWJsZS10cGVicy1yZWNvcmRpbmc6DQo+ID4gPiA+DQo+ID4gPiA+IHBlcmYgc3Rh
dCAtTSB0bWFfZHRsYl9zdG9yZSAtYSBzbGVlcCAxDQo+ID4gPiA+DQo+ID4gPiA+ICBQZXJmb3Jt
YW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOg0KPiA+ID4gPg0KPiA+ID4gPiAg
ICAgICAgMTgxLDA0NywxNjggICAgICBjcHVfY29yZS9UT1BET1dOLlNMT1RTLyAgICAgICAgICAj
ICAgICAgMC42ICUNCj4gPiA+IHRtYV9kdGxiX3N0b3JlDQo+ID4gPiA+ICAgICAgICAgIDMsMTk1
LDYwOCAgICAgIGNwdV9jb3JlL3RvcGRvd24tcmV0aXJpbmcvDQo+ID4gPiA+ICAgICAgICAgNDAs
MTU2LDY0OSAgICAgIGNwdV9jb3JlL3RvcGRvd24tbWVtLWJvdW5kLw0KPiA+ID4gPiAgICAgICAg
ICAzLDU1MCw5MjUgICAgICBjcHVfY29yZS90b3Bkb3duLWJhZC1zcGVjLw0KPiA+ID4gPiAgICAg
ICAgMTE3LDU3MSw4MTggICAgICBjcHVfY29yZS90b3Bkb3duLWZlLWJvdW5kLw0KPiA+ID4gPiAg
ICAgICAgIDU3LDExOCwwODcgICAgICBjcHVfY29yZS90b3Bkb3duLWJlLWJvdW5kLw0KPiA+ID4g
PiAgICAgICAgICAgICA2OSwxNzkgICAgICBjcHVfY29yZS9FWEVfQUNUSVZJVFkuQk9VTkRfT05f
U1RPUkVTLw0KPiA+ID4gPiAgICAgICAgICAgICAgNCw1ODIgICAgICBjcHVfY29yZS9NRU1fSU5T
VF9SRVRJUkVELlNUTEJfSElUX1NUT1JFUy8NCj4gPiA+ID4gICAgICAgICAzMCwxODMsMTA0ICAg
ICAgY3B1X2NvcmUvQ1BVX0NMS19VTkhBTFRFRC5ESVNUUklCVVRFRC8NCj4gPiA+ID4gICAgICAg
ICAzMCw1NTYsNzkwICAgICAgY3B1X2NvcmUvQ1BVX0NMS19VTkhBTFRFRC5USFJFQUQvDQo+ID4g
PiA+ICAgICAgICAgICAgMTY4LDQ4NiAgICAgIGNwdV9jb3JlL0RUTEJfU1RPUkVfTUlTU0VTLldB
TEtfQUNUSVZFLw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgIDAgICAgICBNRU1fSU5TVF9SRVRJ
UkVELlNUTEJfSElUX1NUT1JFUzpSDQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAxLjAwMzEwNTky
NCBzZWNvbmRzIHRpbWUgZWxhcHNlZA0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4g
IHRvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMgfCAyICsrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9w
ZXJmL2J1aWx0aW4tc3RhdC5jIGIvdG9vbHMvcGVyZi9idWlsdGluLXN0YXQuYw0KPiA+ID4gPiBp
bmRleCAxNGJlMTMyZjdiNmYuLjA1NTEzOWU0NDc2MyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdG9v
bHMvcGVyZi9idWlsdGluLXN0YXQuYw0KPiA+ID4gPiArKysgYi90b29scy9wZXJmL2J1aWx0aW4t
c3RhdC5jDQo+ID4gPiA+IEBAIC0xMjM1LDYgKzEyMzUsOCBAQCBzdGF0aWMgc3RydWN0IG9wdGlv
biBzdGF0X29wdGlvbnNbXSA9IHsNCj4gPiA+DQo+ID4gPiBXaGF0J3MgdGhlIGJhc2Ugb2YgeW91
ciBwYXRjaHNldD8gIEkgdGhpbmsgd2UgbW92ZWQgdGhpcyB0byBjbWRfc3RhdCgpLg0KPiA+ID4g
UGxlYXNlIG1ha2Ugc3VyZSB0byByZWJhc2Ugb24gdGhlIHBlcmYtdG9vbHMtbmV4dC4NCj4gPg0K
PiA+IFRoaXMgd2FzIHJlYmFzZWQgb24gdG9wIG9mIElhbidzIGNoYW5nZSBmb3IgdGhlIHRvb2wg
ZXZlbnQgYW5kIHJldGlyZV9sYXRlbmN5DQo+IHBhcnNlcg0KPiA+IHBhdGNoZXMuIEkgdGhpbmsg
dGhhdCB3YXMgb24gdG1wLnBlcmYtdG9vbHMubmV4dC4gSSB3aWxsIHJlYmFzZSBvbiBwZXJmLXRv
b2xzLQ0KPiBuZXh0Lg0KPiA+DQo+ID4gPg0KPiA+ID4NCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAiZGlzYWJsZSBhZGRpbmcgZXZlbnRzIGZvciB0aGUgbWV0cmljIHRocmVzaG9sZCBj
YWxjdWxhdGlvbiIpLA0KPiA+ID4gPiAgICAgICAgIE9QVF9CT09MRUFOKDAsICJ0b3Bkb3duIiwg
JnRvcGRvd25fcnVuLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAibWVhc3VyZSB0
b3AtZG93biBzdGF0aXN0aWNzIiksDQo+ID4gPiA+ICsgICAgICAgT1BUX0JPT0xFQU4oMCwgImVu
YWJsZS10cGVicy1yZWNvcmRpbmciLCAmdHBlYnNfcmVjb3JkaW5nLA0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAiZW5hYmxlIHJlY29yZGluZyBmb3IgdHBlYnMgd2hlbiByZXRpcmVf
bGF0ZW5jeSByZXF1aXJlZCIpLA0KPiA+ID4NCj4gPiA+IFBsZWFzZSB1cGRhdGUgdGhlIGRvY3Vt
ZW50YXRpb24gKG1hbiBwYWdlKSBmb3IgdGhpcyBvcHRpb24uDQo+ID4gPg0KPiA+ID4gQWxzbyBJ
J20gYWZyYWlkIGl0J2QgZmFpbCB0byBidWlsZCBvbiBub24teDg2IGJlY2F1c2UgdHBlYmVzX3Jl
Y29yZGluZw0KPiA+ID4gaXMgZGVmaW5lZCBpbiBpbnRlbC10cGVicy5jLg0KPiA+ID4NCj4gPg0K
PiA+IFllcywgeW91IGFyZSByaWdodC4gSSBmb3Jnb3QgYWJvdXQgbm9uLXg4Ni4gSSB3aWxsIHVw
ZGF0ZSB0aGlzIGFuZCBhbHNvIHRoZQ0KPiA+IERvY3VtZW50YXRpb24uDQo+ID4NCj4gPiBUaGFu
a3MsDQo+ID4gV2VpbGluDQo+ID4NCj4gPiA+IFRoYW5rcywNCj4gPiA+IE5hbWh5dW5nDQo+ID4g
Pg0KPiA+ID4NCj4gPiA+ID4gICAgICAgICBPUFRfVUlOVEVHRVIoMCwgInRkLWxldmVsIiwgJnN0
YXRfY29uZmlnLnRvcGRvd25fbGV2ZWwsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICJTZXQgdGhlIG1ldHJpY3MgbGV2ZWwgZm9yIHRoZSB0b3AtZG93biBzdGF0aXN0aWNzICgwOiBt
YXgNCj4gbGV2ZWwpIiksDQo+ID4gPiA+ICAgICAgICAgT1BUX0JPT0xFQU4oMCwgInNtaS1jb3N0
IiwgJnNtaV9jb3N0LA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjQzLjANCj4gPiA+ID4NCg==
