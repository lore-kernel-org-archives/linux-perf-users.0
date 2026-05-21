Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9E385D68;
	Thu, 21 May 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386540; cv=fail; b=Fr1axcr4NHhKnqxtDvWaDklFk87qW1aRA0eB4tGPRUBCrcntZRr8gvf6ha1/03/kc0DHv0WLUkoKFx6l219V+8C+purmll5cLGNsuDC59M2cLSf1Ge8l+9x+7zgX2A1JkFqejN/XI+9ZaRxzHAA/VSaAyu3EwcT1pBOs4ZEPQHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386540; c=relaxed/simple;
	bh=1cnOjf+DDPep/+tJKs1kDTxwN/M7GgtiJtWZqqC0nSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z3D0TKD/qj/dyuEVkpWvY80XlmLrMROFA1u3Qnk93FZGl3mF0iWDYDqHqPBwV4lEZmjqeUogOuFIZFSVeSxZ207w5kWz0PX6FIdYOpeDT2QMNnpCG40dE1tsqsYryQJPRZ2JvZUT6D/Cya6jevACBZdaWsPwaJ7noZUE4mLuEQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8uj1KMN; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8uj1KMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779386537; x=1810922537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1cnOjf+DDPep/+tJKs1kDTxwN/M7GgtiJtWZqqC0nSM=;
  b=m8uj1KMNS608n9yZidsmIJkd2xStCjeFSNdkG4uyHe6ccNYY3lSACW5X
   nEVCSE+ku/4kO52+1qKqi1+ASuyNDNO6NktFB2rcCJK5nAeP4btWaqc+P
   QGRp9oR+UxozjWZy1p0D3Rmz8Juqo4/KxFOSbTj+OY7izoQNJPQxalosP
   XOOuu0bZAs/Ik1ChXmnO+D0OohivANkToeOp3DDYR3ZGJIkdZ8qL9OEZ/
   6nncvc7owkgK0H50O4SSjttecR3M41O2Iv4NIdX+sV7fLdH/8VCWe3mBk
   T41HyZ57p1yIm0HvYlofUA2aYRHmdcYsQp+Z/bfaojUepegL2Q3qYfGCW
   Q==;
X-CSE-ConnectionGUID: j91GnxtERMWvonEYocDzmA==
X-CSE-MsgGUID: MsDVarg4T4+EnJJmFNSWmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91706061"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="91706061"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 11:02:06 -0700
X-CSE-ConnectionGUID: QuJHp9MVTZCIS0PlamZgIg==
X-CSE-MsgGUID: rRdqDFOVQZ289StQBi49MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="245573835"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 11:02:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 11:02:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 11:02:06 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 11:02:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmZGO6UmVkOVcO2wxXmU1YRk3Cd4OlOVrF8nbvsNOo40ScI1mGe0RQu9zMPdh8qBozrVK4dHUKx8UZlZ3xuugxpqqSeRK0qXXpMbkcypTbI+L+Z57uFEjJ2PqyTtKRIOFfHL/MheuOtmKDm0mHz+pxqYZVFT/dNRwdjAR2+B58Vg5xKQXWZbTxlu4cls/f+ioH7PLiSYCve/EIWEx61OrEqz667uxWxQDuidvG16gywy0LJ1hKdr9ckbHVMwD4BlfkiDdiTHppf0aEQM7R+V+lqrK9Eno+xLiFu2navYipEjGHk0ArBvGDg7QwwDUBEjW/uc/JO/h3t6vqysVYVpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cnOjf+DDPep/+tJKs1kDTxwN/M7GgtiJtWZqqC0nSM=;
 b=YrzZcgZmN/EPqM6Qt7icdjXxLyHfcn3lvIR5Jy5lmUm5c+sTUlCJpdo4r+yqn3kR7n3thpdvmxyYUlbzXzjKRlE4SCea+4F/mIDwMrZ2aDQlqAQbQ1xKpM/WX48AjMGrhgu4uGSQNTQHjn0rbeL75UjEn9E1TYUVwTmyUC6HemEBbQI4HSAOEVUrkYQZCVKsToL4gGqbYXrB4S+JUJBQpE9bBuuiRWPVQbtXZRpFMPvoeaeG8/TgDbb12bLcNJK8pL5vTal5M3e/wm9c6zzgJdiDLA8dGK3LZWuNl+yLbX8U8kRnXfYXm2bZ2hxuXEl3dXT8x63OoYGGdMIecx6tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CH3PR11MB8093.namprd11.prod.outlook.com (2603:10b6:610:139::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 18:01:59 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 18:01:58 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"Rogers, Ian" <irogers@google.com>
CC: "Chen, Zide" <zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [Patch v3] perf tests: Add auto counter reload (ACR) sampling
 test
Thread-Topic: [Patch v3] perf tests: Add auto counter reload (ACR) sampling
 test
Thread-Index: AQHc0Uu1ZACPgwImVkau+7JIMSbOkLYY9TyA
Date: Thu, 21 May 2026 18:01:58 +0000
Message-ID: <29ad63162ca81262778d4f732c9bf0bcba23a838.camel@intel.com>
References: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CH3PR11MB8093:EE_
x-ms-office365-filtering-correlation-id: 4d9eb182-80c2-4e50-b152-08deb7630d70
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021|3023799007|20052099010|6133799003|921020|11063799006|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: DP9yAyYL1UdMBO/uZ1KS12UCWlZd1p+B6YxQR7o4EGY65Vv2jHTus+6Lja52HjvbByv0UB+yp2+WLkWbwPOQ2SK7WIgTJ2iHLiHUMgcFfv3GSe8IDp0yz9KbimKZG0iWx7FtfoEohjir0rYXe1j6Aqdx2mtw0uf682fKIJs0tZAHLprggwD0qaLxB75+l+n3ZbzxhmdrGlvsvDApZagJp3JXikTOO5IKtc+c4NvwOxwrxDtFN/hFSN4ioEMZerhpda2/CIDdrOlcZELHnLDASvsalL1Mg4Ex8edFSrxjP7pFpQPnr1h6OmCLkuSHXYVgwqdwSDayfGpkwQ1hzl5IzWJU2A9mBl+56L6JW1olzGYi82F9UUJNh1GJIJOqynXNa/A0HeBF0Ugw5GdqR3D66WQ67tBp/TUKNBi+QOhFdBDZd1Easa+iSmzbkH044hRDETdVnmCD471pPZPPZYTs+gywRgDjPzzlk9FEcB57H6S8ekEvR0rpNqCt1ZQHC7wX8sAcWxVcPaaf++XnqfemZ+9Y+KjtiMvIlNf4V7Grjm3z9frGzoRgKOyqRptZwNFS5DdvIRESL9mrOAtGoAD/WZkWixf8CQheDHR6RHYtSuPZIkf3r1C8ti+mQUu/poA+XHWeJWO6oj+Himxh1FR6uikdw8cOK1uGbNEKJP7q76++3uaiB08CJ2fWnWQwq2uGWeprAHN2QRlB9rkv1wrWAtI+CcMlfV+D9nWwT8mha7FBopboyQpotXBdd21XQ7X37Jpq8za5ZRRwyeFZMY51uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(3023799007)(20052099010)(6133799003)(921020)(11063799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhWbkpsOXdsVTdlVWZhcWxBdTMvUTI4TGZ5WXRTYnhzZExGR1grdUY3KzVJ?=
 =?utf-8?B?eDAvODhJZzRlMm51enVFcjJDNjJ4LzNlTGFiYncrUXA5VkFmSkVjVkpzbDZ5?=
 =?utf-8?B?ZUpXbWplQytJc3FsRmUrRVFZcVFGU1NvNXRkNmlSWTZsK3RpZUNGSUlMdmVu?=
 =?utf-8?B?R0xtTG1CNDhmL3E4NGdIcmdXeDFmaGhIMGlURmpxLzgzTzEyd091Z24vTHN0?=
 =?utf-8?B?dkNoUHo3K2owbzI3dnlteEo2STN6YnhoaHdUUXpDVllrT0xILzZvdndNVjJt?=
 =?utf-8?B?c0wzbUN5SHJzQTZUZDZTd1JsVDROWjUzamVQcEgyekVnb1U1VWdOWjZpUnM1?=
 =?utf-8?B?cEpISzRuRFk2YjZ1blZiZVhQNGVpMUtaem5mTFN3R0FlWU0zeGFiTkJ0K2Rk?=
 =?utf-8?B?c05BeTE4UUtqVjlwRzdJU0p6Q3FGUjIrd0hEc0pOem11NnQ3UW1ncHNKZWZH?=
 =?utf-8?B?UFAzMENMT3JjTklyYzZkbUJyRVo4REpVTjA5Um5zWFYyQks0WmhZUnpkYlg4?=
 =?utf-8?B?TVYrOE5IWDNCSDlFVzZEYm1LcXlWSUQyVE1hRFFxaXVZR2NCYisvd1QvT28r?=
 =?utf-8?B?dGdoaEE5VW9FekN3ckIvT1dQejVnRitFUW02STlyZ3ZCTUIvcVVNV1Nmd0hL?=
 =?utf-8?B?T25lcnU5WXJDdHlrS3Y5YzZJY2h0bTVoMkR2WWpQYnFUTmVmSVdBZFRweGNZ?=
 =?utf-8?B?cVJBaGlNMWNuR1NXdFIyKzkxaVMvZHNLT2t5VTkwbFludFFuR0tjZVRZTW1n?=
 =?utf-8?B?RE1OVFZUN056dUlYdWFhYnRWWStVT3FldWdkQlFhdDhERW05UXhPNVYyckh2?=
 =?utf-8?B?djlaVHkwM2xCNnVHSWhTcjh0YVpEUldFY1N0OE92QVVqSW1kSldndWgvMVNI?=
 =?utf-8?B?c0FvTlArVTN0VXNRZ3FsUWtjeGJxU1ZDMi9DdjZyNFZPTisxR1hQQVY4VERL?=
 =?utf-8?B?d0dvN2FOcjRxVzkyeGtkNldIZzVWanJ5MVdYak9FQW5oL25xL0hYTmJzbEpx?=
 =?utf-8?B?WU5xVUJVWlRKdE8vaVFxNThaNm0xand4Vk0rODUyVnZPa2MrbDFHeHdURC9V?=
 =?utf-8?B?SVhPaDBXUVh1Q1dCK3ZsdGpvVGJkenFjN2Q3aXRvcEZYUU9TM2U4cTd5QXo0?=
 =?utf-8?B?UVB3dm0vSTJiQ3ZsdVJTVkVIOFQzZmFnbmRxWmk1c095T0tmaXpsOFMxUFRp?=
 =?utf-8?B?aG9GSE9jSUhzZ0c5NStOd1FmRVl6bTFrck1uNkgxSTN3dEk0d2gvNXpPcEZy?=
 =?utf-8?B?K1NUZzEvMEd6c2RmdkVkb3dleFRSMVF6aUlNUHpRVVRuVXJ6M0laTDk5SGl1?=
 =?utf-8?B?T2dMOG5tZThMTHkyamU4aFJjNnMvbi96Z1JVOUR1b09ZMzA4NjAvam5iNCtW?=
 =?utf-8?B?K1JRUDQzaks0bVdORVEvU1lZLzBXSGJrL3FtUno1YmEvVFRjT09CZ1NmTXpP?=
 =?utf-8?B?bTVXMXpHcnd2QkdMVEFpNTRjQzBLVkF5dmIxMWNJVXdHQlRrWklQV0F4R3RR?=
 =?utf-8?B?Vmo3YUV2SUZPSTAwSGUrQzZDbHJFc3htcDdkVERqRDFWUDVlZzlXOVE5Vjl3?=
 =?utf-8?B?cFFIbENoV2ZZRmxMSHMvb0E5WGM3SjEzQUtjM0pxb2VHSFlrS3B1OVV3eWlp?=
 =?utf-8?B?TkVJZ2tOYU85TGpsSTBEcjBqM09mR2l3dnFYUXZRU0hJN013QUdkVHlvd2c4?=
 =?utf-8?B?VmxrSTFIVVBiZmVSSnJId01kTDBqYTVmWSt5VkM4NFRZVXJpNTVHNGVaVmhB?=
 =?utf-8?B?Y2doNzJMWW1XUlc1T3BMUWNwdjQ0ZTArenRaNm1BMjVyMjV6bFVPeFczQkNW?=
 =?utf-8?B?R2pYQ25oOUY5aUFNY0NCZE5RdTk2dUZqalNMRUFuN1NpbUtVS1RKUEhYamxp?=
 =?utf-8?B?NmVjK1ZNZ2JIWE9iNVhCVG5ZSW02NDQ4T1hxWTJFSXpJZ3crK3RHckljTGl2?=
 =?utf-8?B?dVZTM0grWUhEbU9QMUJrUHpXQTVYWGJXZ0dHUUNIRFRDWHF2anJ0QjNVYTZm?=
 =?utf-8?B?UDhuM2lpb1gyNWRmVmVZd0M0NmczVC8rQktoV2Q2UStVd0xsRmNEWnBvM1R5?=
 =?utf-8?B?Qm9xTEFrVHNFMDYxRStONjc4MkZOSkhmZnN6Qktsd2dpQnpTWTFydmlIWWxD?=
 =?utf-8?B?VUNQSnp0T0d6Mnl6Y1J5d3Exdklmb1RPRUw1VDVPQVFyQm5TeXZXYldsT25M?=
 =?utf-8?B?cXBDMlFjVG5sWmF1aGtiTW56ZjY4RGY0bHlRclpEKy9IaXA0U2hLSHhINnAv?=
 =?utf-8?B?cUI1bmJMRTNPZWVWWHB0VFNxR2tSZnpLMmRjaStEdzZaVCtLL0x3YTZaRjNE?=
 =?utf-8?B?NjIzRkxFUEw2eU5PbmZOUWRYdjkzaVR4UHc4NjNBNjB5OW8wZ1JtTHRLaDR6?=
 =?utf-8?Q?s02Tt+NXEmNAlCMT+NJAE11k0iAIyaSh9pZGOEkzQHiLQ?=
x-ms-exchange-antispam-messagedata-1: 4FAeudGfYDk9qvO8tKhyvOpzPI7XFP5iZAo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD34C035BC34D643BEE6B6B7AFEF0BA3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PW/TLjeySlzwDJostalX0vMiDiYJpe9AhuZHtVfowFXQLqw42silYib9P2ie5CEeUlac9ri24uCjXaue16BnFzcniJDbIlBCNL1GoT+yJdHlBOwtJ25ItcXwh+XToFBBq8VMSBQcs0crfa/nBzqFMXMmS0KwtZrqmmJoStOy6/7UEbciL2625KAebQe3H12frbK83ouP4j7UFay/H4UO+RI2qw5ldCdjLuZSC47u2u+5/4+Qn074iCwRzRhOqUsMOHuU2iPY8kVX7LLDBs+vBoJ0LA2TPzol/1z+Xj2SJ7MINLyqPWgT6D0oGDEmbw3YVzZQibg3iWVVf9CgPTbZzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9eb182-80c2-4e50-b152-08deb7630d70
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 18:01:58.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdEroyK0KE7WOFOM7b5lFw3lHcCS9fu9JxqjUMPBEdD74/IePKUsNrW6EKzCDQucImnfTf4JbZVazJvcs2MFFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8093
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA0LTIxIGF0IDEyOjU1ICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IEFk
ZCBhdXRvIGNvdW50ZXIgcmVsb2FkIHNhbXBsaW5nIHRlc3QgdG8gdmVyaWZ5IHRoYXQgdGhlIGlu
dGVuZGVkDQo+IGV2ZW50DQo+IHJlY29yZHMgY2FuIGJlIGNhcHR1cmVkIGFuZCB0aGUgc2VsZi1y
ZWxvYWRlZCBldmVudHMgd29uJ3QgZ2VuZXJhdGUNCj4gYW55DQo+IHJlY29yZHMuDQo+IA0KPiBB
ZGRpdGlvbmFsbHksIGVuaGFuY2UgcmF0aW9fdG9fcHJldiB0ZXN0IHRvIHZlcmlmeSBBQ1Igc2Ft
cGxpbmcgYXMNCj4gd2VsbA0KPiBpZiBBQ1IgaXMgc3VwcG9ydGVkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRGFwZW5nIE1pIDxkYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+IA0K
PiBWMzogTW92ZSByYXRpby10by1wcmV2IEFDUiBzYW1wbGluZyB0ZXN0IGludG8gcmF0aW9fdG9f
cHJldiB0ZXN0Lg0KPiBWMjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNDIw
MDI1NTAxLjIxMzM0OTUtMS1kYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbS8NCj4gdjE6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDQxMzAxMDkyMC41NDY1MDEtMS1kYXBlbmcx
Lm1pQGxpbnV4LmludGVsLmNvbS8NCj4gDQo+IMKgdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9yZWNv
cmQuc2ggfCA5Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiDCoDEgZmls
ZSBjaGFuZ2VkLCA5MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9yZWNvcmQuc2gNCj4gYi90b29scy9wZXJmL3Rl
c3RzL3NoZWxsL3JlY29yZC5zaA0KPiBpbmRleCA3Y2I4MWNmMzQ0NGEuLjA5MWQ4YjBhOTk4YiAx
MDA3NTUNCj4gLS0tIGEvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9yZWNvcmQuc2gNCj4gKysrIGIv
dG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9yZWNvcmQuc2gNCj4gQEAgLTQwMiw3ICs0MDIsNTIgQEAg
dGVzdF9jYWxsZ3JhcGgoKSB7DQo+IMKgwqAgZWNobyAiQ2FsbGdyYXBoIHRlc3QgW1N1Y2Nlc3Nd
Ig0KPiDCoH0NCj4gwqANCj4gK3Rlc3RfYWNyX3NhbXBsaW5nKCkgew0KPiArwqANCj4gZXZlbnRz
PSJ7aW5zdHJ1Y3Rpb25zL3BlcmlvZD00MDAwMCxhY3JfbWFzaz0weDIvdSxjeWNsZXMvcGVyaW9k
PTIwMDAwDQo+ICxhY3JfbWFzaz0weDMvdX0iDQo+ICvCoA0KPiBwZWJzX2V2ZW50cz0ie2luc3Ry
dWN0aW9ucy9wZXJpb2Q9NDAwMDAsYWNyX21hc2s9MHgyL3B1LGN5Y2xlcy9wZXJpb2QNCj4gPTIw
MDAwLGFjcl9tYXNrPTB4My91fSINCj4gK8KgIGVjaG8gIkF1dG8gY291bnRlciByZWxvYWQgKEFD
Uikgc2FtcGxpbmcgdGVzdCINCj4gK8KgIGlmICEgcGVyZiByZWNvcmQgLW8gIiR7cGVyZmRhdGF9
IiAtZSAiJHtldmVudHN9IiAke3Rlc3Rwcm9nfSAyPg0KPiAvZGV2L251bGwNCj4gK8KgIHRoZW4N
Cj4gK8KgwqDCoCBlY2hvICJBdXRvIGNvdW50ZXIgcmVsb2FkIHNhbXBsaW5nIFtTa2lwcGVkIG5v
dCBzdXBwb3J0ZWRdIg0KPiArwqDCoMKgIHJldHVybg0KPiArwqAgZmkNCj4gK8KgIGlmICEgcGVy
ZiBzY3JpcHQgLWkgIiR7cGVyZmRhdGF9IiAtRiBldmVudCB8IGdyZXAgLXENCj4gImluc3RydWN0
aW9ucyINCj4gK8KgIHRoZW4NCj4gK8KgwqDCoCBlY2hvICJBdXRvIGNvdW50ZXIgcmVsb2FkIHNh
bXBsaW5nIFtGYWlsZWQgbWlzc2luZyBpbnN0cnVjdGlvbnMNCj4gZXZlbnRdIg0KPiArwqDCoMKg
IGVycj0xDQo+ICvCoMKgwqAgcmV0dXJuDQo+ICvCoCBmaQ0KPiArwqAgaWYgcGVyZiBzY3JpcHQg
LWkgIiR7cGVyZmRhdGF9IiAtRiBldmVudCB8IGdyZXAgLXEgImN5Y2xlcyINCj4gK8KgIHRoZW4N
Cj4gK8KgwqDCoCBlY2hvICJBdXRvIGNvdW50ZXIgcmVsb2FkIHNhbXBsaW5nIFtGYWlsZWQgY3lj
bGVzIGV2ZW50DQo+IHNob3VsZG4ndCBiZSBzYW1wbGVkXSINCj4gK8KgwqDCoCBlcnI9MQ0KPiAr
wqDCoMKgIHJldHVybg0KPiArwqAgZmkNCj4gK8KgIGlmICEgcGVyZiByZWNvcmQgLW8gIiR7cGVy
ZmRhdGF9IiAtZSAiJHtwZWJzX2V2ZW50c30iICR7dGVzdHByb2d9DQo+IDI+IC9kZXYvbnVsbA0K
PiArwqAgdGhlbg0KPiArwqDCoMKgIGVjaG8gIkF1dG8gY291bnRlciByZWxvYWQgUEVCUyBzYW1w
bGluZyBbU2tpcHBlZCBub3Qgc3VwcG9ydGVkXSINCj4gK8KgwqDCoCBlY2hvICJBdXRvIGNvdW50
ZXIgcmVsb2FkIHNhbXBsaW5nIFtTdWNjZXNzXSINCg0KU2hvdWxkIHRoaXMgIlN1Y2Nlc3MiIG1l
c3NhZ2UgYmUgaGVyZT8NCg0KVGhhbmtzLA0KVG9tDQoNCj4gK8KgwqDCoCByZXR1cm4NCj4gK8Kg
IGZpDQo+ICvCoCBpZiAhIHBlcmYgc2NyaXB0IC1pICIke3BlcmZkYXRhfSIgLUYgZXZlbnQgfCBn
cmVwIC1xDQo+ICJpbnN0cnVjdGlvbnMiDQo+ICvCoCB0aGVuDQo+ICvCoMKgwqAgZWNobyAiQXV0
byBjb3VudGVyIHJlbG9hZCBQRUJTIHNhbXBsaW5nIFtGYWlsZWQgbWlzc2luZw0KPiBpbnN0cnVj
dGlvbnMgZXZlbnRdIg0KPiArwqDCoMKgIGVycj0xDQo+ICvCoMKgwqAgcmV0dXJuDQo+ICvCoCBm
aQ0KPiArwqAgaWYgcGVyZiBzY3JpcHQgLWkgIiR7cGVyZmRhdGF9IiAtRiBldmVudCB8IGdyZXAg
LXEgImN5Y2xlcyINCj4gK8KgIHRoZW4NCj4gK8KgwqDCoCBlY2hvICJBdXRvIGNvdW50ZXIgcmVs
b2FkIFBFQlMgc2FtcGxpbmcgW0ZhaWxlZCBjeWNsZXMgZXZlbnQNCj4gc2hvdWxkbid0IGJlIHNh
bXBsZWRdIg0KPiArwqDCoMKgIGVycj0xDQo+ICvCoMKgwqAgcmV0dXJuDQo+ICvCoCBmaQ0KPiAr
wqAgZWNobyAiQXV0byBjb3VudGVyIHJlbG9hZCBzYW1wbGluZyBbU3VjY2Vzc10iDQo+ICt9DQo+
ICsNCj4gwqB0ZXN0X3JhdGlvX3RvX3ByZXYoKSB7DQo+ICvCoCByYXRpb19ldmVudHM9IntpbnN0
cnVjdGlvbnM6dSxjeWNsZXMvcGVyaW9kPTIwMDAwLHJhdGlvLXRvLQ0KPiBwcmV2PTAuNS91fSIN
Cj4gK8KgDQo+IHBfY29yZV9yYXRpb19ldmVudHM9IntjcHVfY29yZS9pbnN0cnVjdGlvbnMvdSxj
cHVfY29yZS9jeWNsZXMscGVyaW9kPQ0KPiAyMDAwMCxyYXRpby10by1wcmV2PTAuNS91fSINCj4g
K8KgDQo+IGVfY29yZV9yYXRpb19ldmVudHM9IntjcHVfYXRvbS9pbnN0cnVjdGlvbnMvdSxjcHVf
YXRvbS9jeWNsZXMscGVyaW9kPQ0KPiAyMDAwMCxyYXRpby10by1wcmV2PTAuNS91fSINCj4gwqDC
oCBlY2hvICJyYXRpby10by1wcmV2IHRlc3QiDQo+IMKgwqAgaWYgISBwZXJmIHJlY29yZCAtbyAv
ZGV2L251bGwgLWUgIntpbnN0cnVjdGlvbnMsDQo+IGN5Y2xlcy9wZXJpb2Q9MTAwMDAwLHJhdGlv
LXRvLXByZXY9MC41L30iIFwNCj4gwqDCoMKgwqDCoCB0cnVlIDI+IC9kZXYvbnVsbA0KPiBAQCAt
NDM4LDcgKzQ4Myw1MSBAQCB0ZXN0X3JhdGlvX3RvX3ByZXYoKSB7DQo+IMKgwqDCoMKgIGVycj0x
DQo+IMKgwqDCoMKgIHJldHVybg0KPiDCoMKgIGZpDQo+IC3CoCBlY2hvICJCYXNpYyByYXRpby10
by1wcmV2IHJlY29yZCB0ZXN0IFtTdWNjZXNzXSINCj4gKw0KPiArwqAgcmF0aW9fZXJyPTANCj4g
K8KgIGRvX3JhdGlvX3RvX3ByZXZfdGVzdCgpIHsNCj4gK8KgwqDCoCBsb2NhbCBldmVudHM9JDEN
Cj4gK8KgwqDCoCBsb2NhbCBjcHU9JDINCj4gK8KgwqDCoCBpZiAhIHBlcmYgcmVjb3JkIC1vICIk
e3BlcmZkYXRhfSIgLWUgIiR7ZXZlbnRzfSIgJHt0ZXN0cHJvZ30gMj4NCj4gL2Rldi9udWxsDQo+
ICvCoMKgwqAgdGhlbg0KPiArwqDCoMKgwqDCoCBlY2hvICJBdXRvIGNvdW50ZXIgcmVsb2FkICR7
Y3B1fSByYXRpby10by1wcmV2IHNhbXBsaW5nDQo+IFtGYWlsZWQgc2FtcGxpbmddIg0KPiArwqDC
oMKgwqDCoCByYXRpb19lcnI9MQ0KPiArwqDCoMKgwqDCoCByZXR1cm4NCj4gK8KgwqDCoCBmaQ0K
PiArwqDCoMKgIGlmICEgcGVyZiBzY3JpcHQgLWkgIiR7cGVyZmRhdGF9IiAtRiBldmVudCB8IGdy
ZXAgLXENCj4gImluc3RydWN0aW9ucyINCj4gK8KgwqDCoCB0aGVuDQo+ICvCoMKgwqDCoMKgIGVj
aG8gIkF1dG8gY291bnRlciByZWxvYWQgJHtjcHV9IHJhdGlvLXRvLXByZXYgc2FtcGxpbmcNCj4g
W0ZhaWxlZCBtaXNzaW5nIGluc3RydWN0aW9ucyBldmVudF0iDQo+ICvCoMKgwqDCoMKgIHJhdGlv
X2Vycj0xDQo+ICvCoMKgwqDCoMKgIHJldHVybg0KPiArwqDCoMKgIGZpDQo+ICvCoMKgwqAgaWYg
cGVyZiBzY3JpcHQgLWkgIiR7cGVyZmRhdGF9IiAtRiBldmVudCB8IGdyZXAgLXEgImN5Y2xlcyIN
Cj4gK8KgwqDCoCB0aGVuDQo+ICvCoMKgwqDCoMKgIGVjaG8gIkF1dG8gY291bnRlciByZWxvYWQg
JHtjcHV9IHJhdGlvLXRvLXByZXYgc2FtcGxpbmcNCj4gW0ZhaWxlZCBjeWNsZXMgZXZlbnQgc2hv
dWxkbid0IGJlIHNhbXBsZWRdIg0KPiArwqDCoMKgwqDCoCByYXRpb19lcnI9MQ0KPiArwqDCoMKg
wqDCoCByZXR1cm4NCj4gK8KgwqDCoCBmaQ0KPiArwqAgfQ0KPiArDQo+ICvCoCAjIHJhdGlvLXRv
LXByZXYgc2FtcGxpbmcgd291bGQgZmFsbGJhY2sgdG8gbm9ybWFsIHNhbXBsaW5nIGlmIEFDUg0K
PiBzYW1wbGluZw0KPiArwqAgIyBpcyBub3Qgc3VwcG9ydGVkLCBzbyBhY3JfbWFzayBtdXN0IGJl
IGNoZWNrZWQgYmVmb3JlIHRlc3RpbmcNCj4gcmF0aW8tdG8tcHJldiBzYW1wbGluZy4NCj4gK8Kg
IGlmIFsgLWUgL3N5cy9idXMvZXZlbnRfc291cmNlL2RldmljZXMvY3B1L2Zvcm1hdC9hY3JfbWFz
ayBdDQo+ICvCoCB0aGVuDQo+ICvCoMKgwqAgZG9fcmF0aW9fdG9fcHJldl90ZXN0ICIke3JhdGlv
X2V2ZW50c30iICIiDQo+ICvCoCBmaQ0KPiArwqAgaWYgWyAtZSAvc3lzL2J1cy9ldmVudF9zb3Vy
Y2UvZGV2aWNlcy9jcHVfY29yZS9mb3JtYXQvYWNyX21hc2sgXQ0KPiArwqAgdGhlbg0KPiArwqDC
oMKgIGRvX3JhdGlvX3RvX3ByZXZfdGVzdCAiJHtwX2NvcmVfcmF0aW9fZXZlbnRzfSIgIlAtY29y
ZSINCj4gK8KgIGZpDQo+ICvCoCBpZiBbIC1lIC9zeXMvYnVzL2V2ZW50X3NvdXJjZS9kZXZpY2Vz
L2NwdV9hdG9tL2Zvcm1hdC9hY3JfbWFzayBdDQo+ICvCoCB0aGVuDQo+ICvCoMKgwqAgZG9fcmF0
aW9fdG9fcHJldl90ZXN0ICIke2VfY29yZV9yYXRpb19ldmVudHN9IiAiRS1jb3JlIg0KPiArwqAg
ZmkNCj4gK8KgIGlmIHRlc3QgIiRyYXRpb19lcnIiIC1lcSAwDQo+ICvCoCB0aGVuDQo+ICvCoMKg
wqAgZWNobyAiQmFzaWMgcmF0aW8tdG8tcHJldiByZWNvcmQgdGVzdCBbU3VjY2Vzc10iDQo+ICvC
oCBlbHNlDQo+ICvCoMKgwqAgZXJyPSIke3JhdGlvX2Vycn0iDQo+ICvCoCBmaQ0KPiDCoH0NCj4g
wqANCj4gwqAjIHJhaXNlIHRoZSBsaW1pdCBvZiBmaWxlIGRlc2NyaXB0b3JzIHRvIG1pbmltdW0N
Cj4gQEAgLTQ1Nyw2ICs1NDYsNyBAQCB0ZXN0X2xlYWRlcl9zYW1wbGluZw0KPiDCoHRlc3RfdG9w
ZG93bl9sZWFkZXJfc2FtcGxpbmcNCj4gwqB0ZXN0X3ByZWNpc2VfbWF4DQo+IMKgdGVzdF9jYWxs
Z3JhcGgNCj4gK3Rlc3RfYWNyX3NhbXBsaW5nDQo+IMKgdGVzdF9yYXRpb190b19wcmV2DQo+IMKg
DQo+IMKgIyByZXN0b3JlIHRoZSBkZWZhdWx0IHZhbHVlDQoNCg==
