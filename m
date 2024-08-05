Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95012AD13;
	Mon,  5 Aug 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882879; cv=fail; b=k/p7OrEfjC+/15uHCNK9NU5+MVWSblrRyODwGlRjfg/sZymNHvb8DRnqTIvZ4adhzJ3G7ZLxjTHwZmDm6Jf4EbryteJ2ZPjPFQ09tDtHPCNgEPd1J+J2grQL+Yw+1ti6FreaPKsnFHVn0MKRW3HVpbK06/0Axw1evOdhce5SgNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882879; c=relaxed/simple;
	bh=Hy2MAE0jEOggkwT/TbX7GPPAotkz+yLzPTGYdIA4urY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XxpS+XGwsf/1qy8rAKceZtvb01eUjVI+XP72LKCd80yWUSDt60KSjdsZghZQrD1TRacYedWH/tUF75Sc6kSAOFjWLb5RdNV5ppBqyaUHYAfmvt2p+mrJt79EVY+D5oET06V/AedVZIv8yVH4VwFMEy/CDCx5bsuTxWCyU5yIezc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+cLXRy7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+cLXRy7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722882877; x=1754418877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hy2MAE0jEOggkwT/TbX7GPPAotkz+yLzPTGYdIA4urY=;
  b=Q+cLXRy7AmRIiTEaeERSdiS1DEaGSvuNAAUEOvpR+PiNweb1X8Qg8MDP
   DdewxNwEpSB3Zh9nUS9CyTWm5wLO0yZYfQ6p+Xl0LIQ/FPJ6xCGS5/pj/
   kSCft9TOqIQvwW8iRH2uf51scN30lpATgAHS+mPrpPMg2boabyzmf4+Ml
   NoHPMZoGKpdYL31Th+0IzarotwCSSeQFZdahNGp5Dp83KKcVzDpTJiqFV
   C2FOQw3dM/YuAs0rV3PMfKGqYrOFTWf0T/ecIoQj6uL+YsvUkeNXeU8KV
   eKFjFd0JsNb4IOnKTx946ZtpYQUNSC11hBaY7Ba45aPh5O0Cd4Y1qoEhT
   A==;
X-CSE-ConnectionGUID: fxBV6au0QUWoCq3uiu+Oug==
X-CSE-MsgGUID: WRhAFPvNSvO3ymsc5yecvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="24731847"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="24731847"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 11:34:36 -0700
X-CSE-ConnectionGUID: 6saqdskET/G9VJXxoIIJgA==
X-CSE-MsgGUID: 2pGLxidmRMKAxQ9GMD7BWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="55931232"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 11:34:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 11:34:35 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 11:34:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 11:34:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 11:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNmYLiDuza9Gp4+Rtab0k/8AI7tqev2xdRWmLkBKT04DWuXeh0i6iRnd0w2wDYPaXabqbz5lNpJ38Y9ibBQtnTRvPJyYhSGEjpO+vXBKh2kFnI8eok/oN1bSPRUs6kJLV807ir9Mu59oj624sioCaNuenl5dVSlN1ZfrUWPk3ufhAPxYzV61zRreHgkuPdvzMtcA1w88DNFme0GVLTyCjvGX6ioHKLR/LogRoQanct/XaDIFABclydD4WAemL2g/pcKP9fBDLhrkZDnNQHTNOIHETEUx+egayfaqz7jT93ALTTWPKHQCgIJyk5TxUndq0LA3JrmySYpAb+GqICEkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy2MAE0jEOggkwT/TbX7GPPAotkz+yLzPTGYdIA4urY=;
 b=RF6ehAOfqAZ1dgGxfIolvdvUibFVLcociD+xQ3Wc3qAb3tpezbrvHQFZw6elnqu8HL7OnrjRVtegnEc3D37CfjfFbBpo6RlOBm4GYSSgfY6blSNvVODOPIrigJRE4mBBFL0ELf5B/pHDXg6MDa6IEyQ6gX/hEu0KHqkxQ/pDc1AdnmxXA8wJC+TFBoEOgA/kbNL7qnNkVKIlL0HMG50GeH0FckiAPLkI5EYFNTKbSttyOoF0ImupT55cWBQQ1EHl2ErZwASCaqiwkCSNUWeOfXVqwAqNaBImedminArjhwrthRkDTsD/aualjksEqKMRv+vzQj+BsdG2LRcOPsfklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 18:34:32 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 18:34:32 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Song Liu <song@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>
CC: Ian Rogers <irogers@google.com>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Baker, Edward" <edward.baker@intel.com>, "Daneti, Venkata Naga Sai Dilip"
	<venkata.naga.sai.dilip.daneti@intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, "jonesz@meta.com" <jonesz@meta.com>
Subject: RE: Some unc_cha_tor_* events appear to be "not supported"?
Thread-Topic: Some unc_cha_tor_* events appear to be "not supported"?
Thread-Index: AQHa3rRBYvlGDnS4q0yQwR0fDD3VnbIHscXwgAzc24CABHmq0A==
Date: Mon, 5 Aug 2024 18:34:32 +0000
Message-ID: <CO6PR11MB563550B4AB0D89D6DAC39CBAEEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com>
 <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
 <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com>
 <CO6PR11MB5635E5844F7C8CB1277C1DF4EEAB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAPhsuW6Hq4qno1=K9-q17TsNO7S4-dQMCfo_nAQZ7EMdcuP6NQ@mail.gmail.com>
In-Reply-To: <CAPhsuW6Hq4qno1=K9-q17TsNO7S4-dQMCfo_nAQZ7EMdcuP6NQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: song@kernel.org,kan.liang@linux.intel.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|PH0PR11MB4901:EE_
x-ms-office365-filtering-correlation-id: fc539418-22bb-454e-927b-08dcb57d3fba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFJ5QWN6UUd5SThiTEZYckYySWp0TE44TytveDdlekpaMEdJVFRmQ0xRaFdI?=
 =?utf-8?B?Rk9LMTRsckNlVzJldnBYdkJLN3NWa0pXV0xEaXlqNVB3ZUJSN0tZZ3RXVXhn?=
 =?utf-8?B?MzB4UDBIUnludERGQ1FEVjc0N0JOcHJmenhPeEpkZHlycG9UTjlwRHNBR3dS?=
 =?utf-8?B?VVVGNDhlNldiTytySnNtM0xEZVR4WE1mY1VEcDJuVm1Ib1lYSFBOTWsyMW8y?=
 =?utf-8?B?QW1leEZFcVpkVWs4a3UySGF3eDRrVjJhNTdzM05pMHRQemY3ZHZyNGVhcDZa?=
 =?utf-8?B?TkxHMVhCaDhvRWhjRW5nWUY0c0RZWmV5WmYweFNrL0pscnB0cXlTWlZtOWQ1?=
 =?utf-8?B?TGgwYk5wMkxEMy9zeXEzUldJR2pqaXFJWjVQQ1FQQWNsMHB3YStoU05sUWFW?=
 =?utf-8?B?NEM1TFlqSzFub0x0UTZwa0ttd2pja3Z2RkF5L29xNjFYZ1lrSWdMRmp0aE1o?=
 =?utf-8?B?K284OWZVL0R2VWJ3VEVYemxrTE1TNlJsTW01K3ZuL3BiZ3pleExTSHVIbURL?=
 =?utf-8?B?MnVrL0Q0Q2pQUjRaTkYvVk1yNE4wVnhzWXNSWVlzVUFlRXFmU3N0ZGtVaFlh?=
 =?utf-8?B?ZitJUVprVnlPbm5nMHJ2ZmZiY3ZSOHhzdXB4S3laRERpR0REVW5pbk43OEVS?=
 =?utf-8?B?d0lYaTRQK29qMTFRMFNkcVpwQk5vSnpUcU1saVFlbWp1eEZsT0M3UU82RnRQ?=
 =?utf-8?B?eGo4UTJEVjhEQUV0aG9lRmVzbS9idm5PcTVHRmR1TFVpUTdaVU1IZHJHbXk5?=
 =?utf-8?B?REtoeTYyL1h3VmhkWGNjeWMvUC9sL1U0LzBoeDA0UGRqZmlCUElQcmtndHBa?=
 =?utf-8?B?NEpteWNGTUxuVVBVNXdVMHdVNFd1VnNVWUpPeThJcWtod0hHWE1HaFdESXBo?=
 =?utf-8?B?ajYvNmViWmUxNEN6RGRmTHdoSDl3by8yUXFMNldxR2NIQi83UFdDb2x2UVBh?=
 =?utf-8?B?aUFqR0V1YnI4a3dlT2Y4SzRqbk9oRDVVUHA4YUUzQUdrbTJBZmd6bS80N0VL?=
 =?utf-8?B?Z0hRUjZ5VXZ6UFB4eThjdEh3Snh4cmttcXRqM1RSQXZoSDltNkx6RDBubnFu?=
 =?utf-8?B?S3k4OW5NRkJuZUdUdWZ6YU9kanRjaUZydU5jYXJkckhBZzg1dnBZYzRKaFpP?=
 =?utf-8?B?dVlncWhaM3c5SUVGaEhoRnRmUkZ5NzhIVEExTE1mMXRlbEZwdEZta2ZCMU1J?=
 =?utf-8?B?ZVBKY0FqMng1dUFNMGlFbnpMaTdtZnpzUDk4SzZzRTFqYnE5eDdBOFhwUHVq?=
 =?utf-8?B?VHdCUHFuOENDaVFaSHhMbEY3eDhaQzRFeVQ5dFROOHdxcUczRks5alAxMG00?=
 =?utf-8?B?Vmx3Qkc3YWhkRk1Ib0dOaHUyaGVlbk85aUpyem50QjhhQWZUNU1LSU9ycXVO?=
 =?utf-8?B?d1JPRnVXdWZnaFViWERGbjQ2YzJ2ZnNwbHhCRDMvK0RXM0RpalZtdVBhbkhW?=
 =?utf-8?B?NURUTlhjdUxGTVFHTEZ2YVdoT1hXL1ZnZkE2bjFHMk9ZdEl3UENQL2RZRWxw?=
 =?utf-8?B?WE5rb2RrZXdRSFlnTFR2ZVhIKzgvY3NUeEJCMytLamxFcjRmeitIa3RLMi9F?=
 =?utf-8?B?U1h3MzIxSy9wS3JBRXozOWdSbmsvYTFmNDNpV2tkRHlhYVNBelFhenF5V1VJ?=
 =?utf-8?B?d0V4VFhJaWpqcVRhRC9IYnRjdzNXcFZlczJZdmRyU051Z0MwR1M3U0FGYW9N?=
 =?utf-8?B?UUxnMVI0V0R1bFN6Ym80cXVLWURmYnBXZGpYZGc4L1Zxb25DQXdiQlNmNlcr?=
 =?utf-8?B?enBmT21qaGUvWWY4OTZtbjVZeCtSbStuUUhlWGpaRlZydnljc24vNiswN3FX?=
 =?utf-8?Q?jNMwEwoCZR5KO5bny0YMm1j9fWrEFTOK7RzbE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGZ1ajg2SjRyYUxyZkt0Y2xoWHlSU3hCSXJGK2t5T2dDZ00xOEp5ZjRsQ3py?=
 =?utf-8?B?aHNBT1A1T1psNVJVZGZreDBXejRFSjM0bHZJM1MrKzVYcmNLdEJBZWhKKy9P?=
 =?utf-8?B?VWFSWWpMQkdEaERuTVFiZTRiQWR5U3F0UFFzbkRvN0h2V2NPWUs2cG8xbFJ0?=
 =?utf-8?B?VmpHK05vOHdseHR6RE16aXppckJwekwwR1lNZFhmWCswTCs1U0pTL2s5eDdE?=
 =?utf-8?B?Q3ZpaVNCaFRadS9Wd0pJL0pKQTN3a1ZyczJHZEpXTU92RDJzV2tNbXVVM01R?=
 =?utf-8?B?Y3VZd2w5aW9BdmhRZXZ2STlWaWlBS1lBUFhjZzVqNnFIUU54UG9MTFdqTENi?=
 =?utf-8?B?S1FYbXFNTU04S3RKSGRCVFBkM2ljWW0vaVM0UUZsajVPVjdoeG1MN0ZXMEF6?=
 =?utf-8?B?NHVKQVh6NmdycExBRUJjSjlSNUYxQWh4b1c0UjdBSnJkYUI2enlONzRzQi9D?=
 =?utf-8?B?ZHJuYVNIZEZLOU4wV2YxQ2tvRmdFTm5RNytycGJqZytJaFk5OTRJZ3QyRFAv?=
 =?utf-8?B?TU5udURYbEpjN0ZtWkwybWJVTCs5R2FVcmlNRS9kM3JGaDg1TERGcWovVXJN?=
 =?utf-8?B?V1hOS2p3TVJmU3ZBdDg5L0FhZ0RoZlVKVDBFUmZZaU04ZmdPZk5aYVA3YzBJ?=
 =?utf-8?B?TmxuYldRQ0FHa1JPaWMrdkgyYUQ0c3Axbnk4UFlkSmgybG40WU9aZHJHTWVs?=
 =?utf-8?B?OFBHZmNMZktobWswSkVqcnBGbnd2eXpXTW9kV1V4VG0vRndEUGZvVkdHR29N?=
 =?utf-8?B?S2VaVWRJK0Y4RE81NUZJdGZKN00ySTBSUXdIR3JycGRLcndSNXJKdjF0dE1r?=
 =?utf-8?B?bGRTQkRDdG93ZEc0NkZHREx0Y2VUN2RvVnkzb3AzSitwZEkzbXpQazQxaWpP?=
 =?utf-8?B?RWxMNUV0YUErZE1MMVN6N2F3UkphUjVxWHhwRHQyVDJlZFczcW9FeGRqWGdV?=
 =?utf-8?B?c21GeVFNU25PdWk0eitoN2JOa1pBWXA2cmJjRk5KOWhnM1RxYXV3ZDNGQ0ds?=
 =?utf-8?B?aERsSUhEWGFoaGFRMHBBeElwazI3d3IrdUlicjNIWHM3bEdBbFhYSTV2OW5o?=
 =?utf-8?B?ZmlYcFlZeUV5eWYveDFYYXFRejBBQnFJcEVoWXpQbjBPZ0g5SHY5Sy9jNEE1?=
 =?utf-8?B?SVRndE1EdkVkUnlqQnA5QnZNWC9RRXBlUHh4NkR3MHV1c2RCRndEZ2JrS0F4?=
 =?utf-8?B?c253S3pGbmZDZnBzbm0zaitHZm5tRnFXK2hEV2hwOWlGNng3cTU2dlUyMjdq?=
 =?utf-8?B?cjdXN2ZsekVtdjR2VFlXTXhNVU1jS3RmWG9XQ24reWtIVk5RL0NFRXR2N1RO?=
 =?utf-8?B?WitkRVdRdlYyY0IzaTRLbHVDMEFaN3hnaFNRZEFvSU5LR3BIWXpaaG1vOUt1?=
 =?utf-8?B?aFM0S3Fqai9VSnArTTMrYmU5K2Y1WWtlL0M0WG9IZHdUWHFXNm1xQnZxbE5s?=
 =?utf-8?B?S3JzN0VCL3JxL045N2FhVkVGcElJamFpSFQvSW5VM3NyZkE2SzljVEhaRE52?=
 =?utf-8?B?b1AwcXN2S0hEclU4NzQ5SUQrUUxjUFhOQ1NQdVBYSUZBWGNrR0tLNjBqaVcw?=
 =?utf-8?B?RWo2aU5EU3VFK3N6dllBRUF4SmNqekozL0RaclFIQU1vSFpDdjBya3U0eXJI?=
 =?utf-8?B?ek15SUt2MXBlR2p2M1kwWE80b3l1NnhjVGdtVGNDTU5Gdlg3aVlXVE8vTUR4?=
 =?utf-8?B?cUt4eGtUZ1oxOENmQUhvMjkzZE94SzlVNHgyVlY4Vk03SkhUZUhKYmhQczFC?=
 =?utf-8?B?aUc0U3pocktZU0wzRkxrUzlWYTNtQ2FXVVBLd2swZlMvNXAvaDNXcTVZYUla?=
 =?utf-8?B?eVdoMEZZTXVNVHlvVyt3eDNuOVpmZENUZ3dZb3g3UEYxd1pqNG5UbkRyc3Jy?=
 =?utf-8?B?ZGFvaHpnb1pHNUR0bXU4eENheVdsN0xkS055SnRKTk9kbDJoVkptWGpHZlAv?=
 =?utf-8?B?QmhvMXU4aXZ6U29uMmFxcEZVT3diMnpueFYwOHc2Ykl2dGlQZUxNTUo1Rjlh?=
 =?utf-8?B?Wmtob3oxMGI4ZDJaSXVwcmExVUtlVDZHclRFaWlPSVZUaGNnQTErK0tQazBC?=
 =?utf-8?B?aHVnQWljeTU0VVJKWGdRVzRQL2RIMm45SnpEVGZhT3hZWU5uTTM4YkZRc2dq?=
 =?utf-8?Q?ghAIo289cPeE1IaCU8LnRl+N1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc539418-22bb-454e-927b-08dcb57d3fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 18:34:32.4324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6sl9EeDd2PfHIEtumXfnG10p7HTRSFb1dZQgy2qRWhL3dn02MDVvKaz/rsc3y3h94gjfico/m0HJaPUI5f+9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU29uZyBMaXUgPHNvbmdA
a2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMiwgMjAyNCAyOjUxIFBNDQo+IFRv
OiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElhbiBSb2dlcnMg
PGlyb2dlcnNAZ29vZ2xlLmNvbT47IFRheWxvciwgUGVycnkgPHBlcnJ5LnRheWxvckBpbnRlbC5j
b20+Ow0KPiBCYWtlciwgRWR3YXJkIDxlZHdhcmQuYmFrZXJAaW50ZWwuY29tPjsgRGFuZXRpLCBW
ZW5rYXRhIE5hZ2EgU2FpIERpbGlwDQo+IDx2ZW5rYXRhLm5hZ2Euc2FpLmRpbGlwLmRhbmV0aUBp
bnRlbC5jb20+OyBMaWFuZywgS2FuDQo+IDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgQXJu
YWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+Ow0KPiBIdW50ZXIsIEFkcmlh
biA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVs
Lm9yZzsNCj4gb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgTmFtaHl1
bmcgS2ltDQo+IDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwu
b3JnPjsgam9uZXN6QG1ldGEuY29tDQo+IFN1YmplY3Q6IFJlOiBTb21lIHVuY19jaGFfdG9yXyog
ZXZlbnRzIGFwcGVhciB0byBiZSAibm90IHN1cHBvcnRlZCI/DQo+IA0KPiBIaSBmb2xrcywNCj4g
DQo+IFdoYXQgYXJlIHRoZSBuZXh0IHN0ZXBzIHdpdGggdGhpcyBpc3N1ZT8gSSBndWVzcyB3ZSBu
ZWVkIHRvIHVwZGF0ZSB0aGUNCj4gc2NyaXB0cyBhbmQgcmVnZW5lcmF0ZSB0aGUgSlNPTiBmaWxl
cz8NCj4gDQo+IFRoYW5rcywNCj4gU29uZw0KPiANCj4gT24gVGh1LCBKdWwgMjUsIDIwMjQgYXQg
MTA6NTLigK9BTSBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6
DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPiA+ID4gU2VudDogVGh1cnNk
YXksIEp1bHkgMjUsIDIwMjQgMTA6MDAgQU0NCj4gPiA+IFRvOiBTb25nIExpdSA8c29uZ0BrZXJu
ZWwub3JnPjsgV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+Ow0KPiA+ID4gVGF5
bG9yLCBQZXJyeSA8cGVycnkudGF5bG9yQGludGVsLmNvbT4NCj4gPiA+IENjOiBMaWFuZywgS2Fu
IDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+
ID4gPiA8YWNtZUBrZXJuZWwub3JnPjsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tPjsgbGludXgtDQo+IHBlcmYtDQo+ID4gPiB1c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IG9w
ZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IE5hbWh5dW5nDQo+ID4g
PiBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+OyBKaXJpIE9sc2EgPGpvbHNhQGtlcm5lbC5vcmc+
Ow0KPiBqb25lc3pAbWV0YS5jb20NCj4gPiA+IFN1YmplY3Q6IFJlOiBTb21lIHVuY19jaGFfdG9y
XyogZXZlbnRzIGFwcGVhciB0byBiZSAibm90IHN1cHBvcnRlZCI/DQo+ID4gPg0KPiA+ID4gT24g
VGh1LCBKdWwgMjUsIDIwMjQgYXQgOTozOeKAr0FNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+
IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBIaSBLYW4sDQo+ID4gPiA+DQo+ID4gPiA+IFRoYW5r
cyBmb3IgeW91ciBxdWljayByZXNwb25zZSENCj4gPiA+ID4NCj4gPiA+ID4gT24gVGh1LCBKdWwg
MjUsIDIwMjQgYXQgNjozN+KAr0FNIExpYW5nLCBLYW4gPGthbi5saWFuZ0BsaW51eC5pbnRlbC5j
b20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBPbiAyMDI0LTA3LTI0IDY6MzkgcC5tLiwgU29uZyBMaXUgd3JvdGU6DQo+ID4gPiA+ID4g
PiBIaSBmb2xrcywNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBXZSBub3RpY2VkIHRoYXQgc29t
ZSB1bmNfY2hhX3Rvcl9vY2N1cGFuY3kgYW5kDQo+IHVuY19jaGFfdG9yX2luc2VydHMNCj4gPiA+
IGV2ZW50cw0KPiA+ID4gPiA+ID4gYXBwZWFyIHRvIGJlICJub3Qgc3VwcG9ydGVkIiBhbmQgYWx3
YXlzIGNvdW50aW5nIHplcm8gKHNlZSBhbg0KPiBleGFtcGxlDQo+ID4gPiBiZWxvdykuDQo+ID4g
PiA+ID4gPiBJcyB0aGlzIGEga25vd24gaXNzdWU/IFdlIGFyZSB0ZXN0aW5nIHdpdGggNi4xMCBr
ZXJuZWwgYW5kIHBlcmYuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhhbmtzLA0KPiA+ID4g
PiA+ID4gU29uZw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBbcm9vdEBr
ZXJuZWx0ZXN0MDA4LjA1LmF0bjYgfl0jIC4vcGVyZiBsaXN0IHwgZ3JlcA0KPiA+ID4gPiA+ID4g
dW5jX2NoYV90b3Jfb2NjdXBhbmN5LmlhX2hpdF9sbGNwcmVmZHJkDQo+ID4gPiA+ID4gPiAgIHVu
Y19jaGFfdG9yX29jY3VwYW5jeS5pYV9oaXRfbGxjcHJlZmRyZA0KPiA+ID4gPiA+ID4gW3Jvb3RA
a2VybmVsdGVzdDAwOC4wNS5hdG42IH5dIyAuL3BlcmYgc3RhdCAtZQ0KPiA+ID4gPiA+ID4gdW5j
X2NoYV90b3Jfb2NjdXBhbmN5LmlhX2hpdF9sbGNwcmVmZHJkIC1hIC0tIHNsZWVwIDENCj4gPiA+
ID4gPiA+IFdBUk5JTkc6IGV2ZW50ICdOL0EnIG5vdCB2YWxpZCAoYml0cyAxMCwxMi0xMywxNSBv
ZiBjb25maWcxICc0YjQzMycNCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIHZh
bHVlICc0YjQzMycgaXMgZm9yIHRoZSAnRmlsdGVyMScsIGFjY29yZGluZyB0byB0aGUgb3JpZ2lu
YWwgZXZlbnQNCj4gPiA+ID4gPiBsaXN0Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCg0KQFNvbmcg
TGl1LCBkbyB5b3Ugc2VlIGRpZmZlcmVudCBvdXRwdXQgZnJvbSBzb21lIG90aGVyIHVuY19jaGFf
dG9yX29jY3VwYW5jeSANCmFuZCB1bmNfY2hhX3Rvcl9pbnNlcnRzIGV2ZW50cy4gT3IsIGFyZSBh
bGwgb2YgdGhlbSByZXBvcnQgdGhlIHNhbWUgd2FybmluZyBsaWtlIHRoaXMgDQpleGFtcGxlIGhl
cmU/DQoNCkNvdWxkIHlvdSBwbGVhc2UgdHJ5IFVOQ19DSEFfVE9SX09DQ1VQQU5DWS5JQV9NSVNT
IGFuZCBzaGFyZSB0aGUgb3V0cHV0PyANClBsZWFzZSBhbHNvIHNwZWNpZnkgdGhlIHBsYXRmb3Jt
IHlvdSB0ZXN0ZWQgb24uIFRoYW5rcyENCg0KPiA+ID4NCj4gaHR0cHM6Ly9naXRodWIuY29tL2lu
dGVsL3BlcmZtb24vYmxvYi9tYWluL1NLWC9ldmVudHMvc2t5bGFrZXhfdW5jb3JlLmpzDQo+ID4g
PiBvbiNMNDYzNA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICAgICAgIkV2ZW50TmFtZSI6ICJVTkNf
Q0hBX1RPUl9PQ0NVUEFOQ1kuSUFfTUlTU19MbGNQcmVmRFJEIiwNCj4gPiA+ID4gPiAgICAgICAi
QnJpZWZEZXNjcmlwdGlvbiI6DQo+ID4gPiAiVU5DX0NIQV9UT1JfT0NDVVBBTkNZLklBX01JU1Nf
TGxjUHJlZkRSRCIsDQo+ID4gPiA+ID4gICAgICAgIlB1YmxpY0Rlc2NyaXB0aW9uIjoNCj4gPiA+
ICJVTkNfQ0hBX1RPUl9PQ0NVUEFOQ1kuSUFfTUlTU19MbGNQcmVmRFJEIiwNCj4gPiA+ID4gPiAg
ICAgICAiQ291bnRlciI6ICIwIiwNCj4gPiA+ID4gPiAgICAgICAiTVNSVmFsdWUiOiAiMHgwMCIs
DQo+ID4gPiA+ID4gICAgICAgIkVMTEMiOiAiMCIsDQo+ID4gPiA+ID4gICAgICAgIkZpbHRlciI6
ICJGaWx0ZXIxIiwNCj4gPiA+ID4gPiAgICAgICAiRXh0U2VsIjogIjAiLA0KPiA+ID4gPiA+ICAg
ICAgICJEZXByZWNhdGVkIjogIjAiLA0KPiA+ID4gPiA+ICAgICAgICJGSUxURVJfVkFMVUUiOiAi
MHg0YjQzMyINCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZXJlIGFyZSB0d28gZmlsdGVycyBmb3Ig
Q0hBIG9uIFNLWC4gRWFjaCBmaWx0ZXIgaXMgMzIgYml0cyB3aWRlLg0KPiA+ID4gPiA+IFNvIHRo
ZSBMaW51eCBrZXJuZWwgZHJpdmVyIHVzZXMgY29uZmlnMSAoNjQgYml0cyB3aWRlKSB0byByZXBy
ZXNlbnQgYm90aA0KPiA+ID4gPiA+IG9mIHRoZW0uIFRoZSBsb3cgMzIgYml0cyBhcmUgZm9yIGZp
bHRlcjAgYW5kIGhpZ2ggMzIgYml0cyBhcmUgZm9yIGZpbHRlcjEuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJdCBzaG91bGQgYmUgYW4gaXNzdWUgb2YgdGhlIGNvbnZlcnQgc2NyaXB0LCB3aGljaCBz
ZXQgdGhlIGZpbHRlcjEgdmFsdWUNCj4gPiA+ID4gPiB0byB0aGUgbG93IDMyIGJpdHMuDQoNCkBM
aWFuZywgS2FuLCB0aGUgZm9sbG93aW5nIGlzIHRoZSBjb252ZXJ0ZWQgIlVOQ19DSEFfVE9SX09D
Q1VQQU5DWS5JQV9NSVNTX0xsY1ByZWZEUkQiDQppbiBwZXJmIEpTT04uIFRoZSAiRmlsdGVyIiBm
aWxlZCBoYXMgdmFsdWUgImNvbmZpZzE9MHg0YjQzMyIsIHdoaWNoIGxvb2tzIGNvcnJlY3QgdG8g
DQptZSBhY2NvcmRpbmcgdG8geW91ciBkZXNjcmlwdGlvbiBhYm92ZS4gDQoNClBsZWFzZSBsZXQg
bWUga25vdyB5b3VyIHRob3VnaHRzLg0KDQogICAgew0KICAgICAgICAiQnJpZWZEZXNjcmlwdGlv
biI6ICJVTkNfQ0hBX1RPUl9PQ0NVUEFOQ1kuSUFfTUlTU19MbGNQcmVmRFJEIiwNCiAgICAgICAg
IkNvdW50ZXIiOiAiMCIsDQogICAgICAgICJFdmVudENvZGUiOiAiMHgzNiIsDQogICAgICAgICJF
dmVudE5hbWUiOiAiVU5DX0NIQV9UT1JfT0NDVVBBTkNZLklBX01JU1NfTGxjUHJlZkRSRCIsDQog
ICAgICAgICJGaWx0ZXIiOiAiY29uZmlnMT0weDRiNDMzIiwNCiAgICAgICAgIlBlclBrZyI6ICIx
IiwNCiAgICAgICAgIlVNYXNrIjogIjB4MjEiLA0KICAgICAgICAiVW5pdCI6ICJDSEEiDQogICAg
fSwNCg0KVGhhbmtzLA0KV2VpbGluDQoNCj4gPiA+ID4gPg0KPiA+ID4NCj4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3Ry
ZWUvdG9vbHMvDQo+ID4gPiBwZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvc2t5bGFrZXgvdW5jb3Jl
LWNhY2hlLmpzb24jbjQ0ODkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENhbiB5b3UgcGxlYXNlIHRy
eSB0aGUgYmVsb3cgZXZlbnQ/DQo+ID4gPiA+ID4gdW5jb3JlX2NoYS9ldmVudD0weDM1LHVtYXNr
PTB4MTEsY29uZmlnMT0weDRiNDMzMDAwMDAwMDAvDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgYXBw
ZWFycyB0byB3b3JrLiBJIGFsc28gdHJpZWQgZXZlbnRzIGxpa2U6DQo+ID4gPiA+DQo+ID4gPiA+
DQo+ID4gPg0KPiB1bmNvcmVfY2hhL1VOQ19DSEFfVE9SX09DQ1VQQU5DWS5JQV9NSVNTLGNvbmZp
ZzE9MHg0MDQzMjAwMDAwMA0KPiA+ID4gMDAvDQo+ID4gPiA+DQo+ID4gPg0KPiB1bmNvcmVfY2hh
L1VOQ19DSEFfVE9SX0lOU0VSVFMuSUFfTUlTUyxjb25maWcxPTB4NDA0MzIwMDAwMDAwMC8NCj4g
PiA+ID4NCj4gPiA+ID4gRG8geW91IGhhdmUgYW4gaWRlYSBvbiBob3cgdG8gZml4IHRoZSBjb252
ZXJ0IHNjcmlwdD8gSSBoYXZlbid0IGxvb2tlZA0KPiA+ID4gPiBpbnRvIHRoZXNlIGNvZGVzLg0K
PiA+ID4NCj4gPiA+IFRoZSBjb252ZXJ0ZXIgc2NyaXB0IGxvZ2ljIGlzIGhlcmU6DQo+ID4gPg0K
PiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwvcGVyZm1vbi9ibG9iL21haW4vc2NyaXB0cy9jcmVh
dGVfcGVyZl9qc29uLnB5I0wzDQo+ID4gPiA5NQ0KPiA+ID4gYnV0IHByZXN1bWFibHkgdGhpcyB3
b3JrZWQgYXQgc29tZSBwb2ludCBvciBpcyBuZWVkZWQgb24gb3RoZXIgbW9kZWxzLg0KPiA+ID4g
Q2hlY2tpbmcgdGhlIHBlcmYganNvbiBJIHNlZToNCj4gPiA+IGBgYA0KPiA+ID4gJCBncmVwIC1y
bCBjb25maWcxIHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4Ni8NCj4gPiA+IHRvb2xzL3Bl
cmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9zbm93cmlkZ2V4L3VuY29yZS1jYWNoZS5qc29uDQo+ID4g
PiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvc2t5bGFrZXgvc2t4LW1ldHJpY3MuanNv
bg0KPiA+ID4gdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gveDg2L3NreWxha2V4L3VuY29yZS1j
YWNoZS5qc29uDQo+ID4gPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvY2FzY2FkZWxh
a2V4L3VuY29yZS1jYWNoZS5qc29uDQo+ID4gPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94
ODYvY2FzY2FkZWxha2V4L2NseC1tZXRyaWNzLmpzb24NCj4gPiA+IGBgYA0KPiA+ID4gU2luY2Ug
Q0xYIGlzIG5lYXIgZXF1YWwgdG8gU0tYLCBhbmQgdGhlIG1ldHJpY3Mgd2lsbCBwcmVzdW1hYmx5
IGJlDQo+ID4gPiBmYWxzZSBoaXRzLCBwZXJoYXBzIHNoaWZ0aW5nIHRoaXMgdmFsdWUgd2lsbCBi
cmVhayBzbm93cmlkZ2V4IC0gSSBoYXZlDQo+ID4gPiBubyBzdWNoIG1hY2hpbmUgdG8gdGVzdCBv
bi4NCj4gPiA+DQo+ID4gPiBVc2luZyBjb25maWcxIHZhbHVlcyByYXRoZXIgdGhhbiBmb3JtYXRz
IGlzIG9kZCB0byBtZS4gT24gYSBTa3lsYWtlWCBJIHNlZToNCj4gPiA+IGBgYA0KPiA+ID4gJCBn
cmVwIC1yIGNvbmZpZzEgL3N5cy9kZXZpY2VzL3VuY29yZV9jaGFfMC9mb3JtYXQvDQo+ID4gPiAv
c3lzL2RldmljZXMvdW5jb3JlX2NoYV8wL2Zvcm1hdC9maWx0ZXJfcmVtOmNvbmZpZzE6MzINCj4g
PiA+IC9zeXMvZGV2aWNlcy91bmNvcmVfY2hhXzAvZm9ybWF0L2ZpbHRlcl9vcGMwOmNvbmZpZzE6
NDEtNTANCj4gPiA+IC9zeXMvZGV2aWNlcy91bmNvcmVfY2hhXzAvZm9ybWF0L2ZpbHRlcl9pc29j
OmNvbmZpZzE6NjMNCj4gPiA+IC9zeXMvZGV2aWNlcy91bmNvcmVfY2hhXzAvZm9ybWF0L2ZpbHRl
cl90aWQ6Y29uZmlnMTowLTgNCj4gPiA+IC9zeXMvZGV2aWNlcy91bmNvcmVfY2hhXzAvZm9ybWF0
L2ZpbHRlcl9sb2M6Y29uZmlnMTozMw0KPiA+ID4gL3N5cy9kZXZpY2VzL3VuY29yZV9jaGFfMC9m
b3JtYXQvZmlsdGVyX25jOmNvbmZpZzE6NjINCj4gPiA+IC9zeXMvZGV2aWNlcy91bmNvcmVfY2hh
XzAvZm9ybWF0L2ZpbHRlcl9vcGMxOmNvbmZpZzE6NTEtNjANCj4gPiA+IC9zeXMvZGV2aWNlcy91
bmNvcmVfY2hhXzAvZm9ybWF0L2ZpbHRlcl9hbGxfb3A6Y29uZmlnMTozNQ0KPiA+ID4gL3N5cy9k
ZXZpY2VzL3VuY29yZV9jaGFfMC9mb3JtYXQvZmlsdGVyX25vdF9ubTpjb25maWcxOjM3DQo+ID4g
PiAvc3lzL2RldmljZXMvdW5jb3JlX2NoYV8wL2Zvcm1hdC9maWx0ZXJfc3RhdGU6Y29uZmlnMTox
Ny0yNg0KPiA+ID4gL3N5cy9kZXZpY2VzL3VuY29yZV9jaGFfMC9mb3JtYXQvZmlsdGVyX25tOmNv
bmZpZzE6MzYNCj4gPiA+IGBgYA0KPiA+ID4NCj4gPiA+IEFkZGluZyBXZWlsaW4gYW5kIFBlcnJ5
IGFzIEknbSB1bnN1cmUgd2hhdCB0aGUgcmlnaHQgZml4IHNob3VsZCBiZS4gTXkNCj4gPiA+IHRo
b3VnaHQgaXMgdGhlIGlucHV0IEludGVsIHBlcmZtb24ganNvbiBzaG91bGQgYnJlYWsgYXBhcnQg
dGhlIGZpbHRlcg0KPiA+ID4gdmFsdWUgaW50byBvcGNvZGVzLCBldGMuIGFuZCB0aGVuIGluIHRo
ZSBjb252ZXJ0ZXIgc2NyaXB0IHdlIGFkZCB0aGVzZQ0KPiA+ID4gdG8gcGVyZiBldmVudHMgbGlr
ZSBmaWx0ZXJfb3BjMD0weGI0Lg0KPiA+ID4NCj4gPg0KPiA+IEFkZGluZyBFZCBhbmQgRGlsaXAg
Zm9yIGV2ZW50IHJlbGF0ZWQgcXVlc3Rpb25zLiBJIGNhbiBmb2xsb3cgdXAgdG8gdXBkYXRlIHRo
ZQ0KPiA+IGNvbnZlcnRlciBzY3JpcHQgb25jZSB3ZSBhcmUgY2xlYXIgYWJvdXQgdGhlIGNvbnRl
bnQgd2UgbmVlZC9jb3VsZCBwcm92aWRlDQo+ID4gaW4gZXZlbnQgSlNPTi4NCj4gPg0KPiA+IFRo
YW5rcywNCj4gPiBXZWlsaW4NCj4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gSWFuDQo+ID4gPg0K
PiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IFNvbmcNCj4gPiA+ID4NCj4gPiA+ID4gWy4uLl0NCg==
