Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF741F5FD
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171919; cv=fail; b=e01ttseuGPfGzydsnEafAy9/OisJRwcQ0KVpyjSPNLv5QJTFi0m13/PpSeh//w0fJFkBgS5dokGm4XAWwYthsrIuQ0SpeIVu6vXMHmqde1rC6zG4wHiyKykif4ID3RRqE2osQmlSrZT7mR9fXEQn4Sq7fWL6+E+vXkCFbJuRZa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171919; c=relaxed/simple;
	bh=AWmuIlXHiFKGnec1/nquDoxy8MFJldFcpzQFZKtLTX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWSSTMgn5NzzqK5SVjp6Zri4WAuUATUV5qLC0ojlLuLuAPbQdWsG5vJEIj/B2e55owKqqH4AsbRJ7y9DXMUMku7bXfF9sMxW14GguhKE+y/b/BvTzfDn0DRCPEX45BxpnsT2P1eg7ixJfni3S/9wIbSbVvAXKAtB2bl8pgSQHRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CM594ibH; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CM594ibH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785171918; x=1816707918;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AWmuIlXHiFKGnec1/nquDoxy8MFJldFcpzQFZKtLTX4=;
  b=CM594ibHK7GfIthS4Y1o9ra8zlkVUYyWArktESNaIQ/OKo/AWny0qX2F
   QTegfbiiMfT1a9PpwRsXUXd0CKrMWJOOI9Mxvkxyam1VM2B1+fZlFeeqB
   biGI8bfszIeS79FVPInb+G508sPyvLz2noov9k/JnMJ7qC5SkcXGNHW7U
   Y/qXJq0qCIMb2fDonuNktIBhcmkrCw0gu4tv6HZdZrfGOeqPgDL/nABCM
   gH+FfN6iF5mXItMPQ02X0aYPZBzzBWi4A4Cf+QZrkMtnRmkJT55kKvt3V
   ad6hKfR3exSq5AFRyijJNTftqcZKm2Ijsw6o2AYeXU2awjap8DiujF4S2
   Q==;
X-CSE-ConnectionGUID: QIx1fnayQY2sd0JjwQameQ==
X-CSE-MsgGUID: 2LRPTqTUSYC7ES2LZozdOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85830531"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85830531"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:05:17 -0700
X-CSE-ConnectionGUID: BpwE1gZyS0yWY+E2smbVOw==
X-CSE-MsgGUID: brOGSnd4Ttq3ZgioGlcoPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="256792833"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:05:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:05:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 10:05:15 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.55) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:05:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylb/nRi19eozCmpPNNrHdt6NcgqQyVcqYmX8p199M2u/zbZ5qFngLcQvBCN2jrsjvexWZPJ7YsRlx4fGgXCQelrt3u3/OFn8Fx4XywZruITRB1+0/86on0wcsktorh+CrqnO/ETzQr/PcOfd0ltB97zIFJ7yVDGqzLrCjuGtlMNKIU8PhKOu1WuPStqdHlac6S5muJEZT657/hek1hVYiQFPVGVgy5fki3zR8a2/WCM+tqeG3JdOJVxA1a0dwoiWl2rHoUX8VILKqV+JPJ2LZXYEPTpduNmBWnNqDhkxNK5as0uhw5WKVuZz2yEY8QbTGwSQOPnPz8mvOWul7jZMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWmuIlXHiFKGnec1/nquDoxy8MFJldFcpzQFZKtLTX4=;
 b=Xhyc7xXET3CE4EBhcGtT0Le7TG4Prw8alYx43Dk9nxWvWNadezOpPcegBZctAy8TFX8bSulKf0C6YQQaCCN5cfDRSISu8ycE9xyd1rGmwFQ8S81hgCU6ig1k76htVK1iEOiDW04HecFY0bBz0jI/TRyvZKy3Pt2IdynOB0ZMchVmLBm77yZBTYjJC1s9H3IYK6uZV9zhivk+H0TQZNjEj2hSweaymH4sDuBS1ME+PyNu4WIj3+MvrsOI+gfq9UtP1fuVTs9f3X42neQW4oX6grG068m1bIXfPNK2xIBBU38IPxOXTuBprDWBM7ZaJno9Cx4Tj2+haj+7hfMSIHhXHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:05:11 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:05:11 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] perf c2c: print memory region data with stdio
 output
Thread-Topic: [PATCH v2 6/6] perf c2c: print memory region data with stdio
 output
Thread-Index: AQHdEyoCIHfDHansRE+qjHtquZcK87ZsMROAgBV8wgA=
Date: Mon, 27 Jul 2026 17:05:11 +0000
Message-ID: <81f84b17c2f620d45a27e3cc00ea0d837b7b362e.camel@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
	 <20260714004359.179451-7-thomas.falcon@intel.com>
	 <20260714005711.709741F000E9@smtp.kernel.org>
In-Reply-To: <20260714005711.709741F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|PH0PR11MB5902:EE_
x-ms-office365-filtering-correlation-id: 4b569945-18ed-4eb7-5976-08deec013853
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|376014|3023799007|38070700021|11063799006|5023799004|10067099003|56012099006|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: wV+GTDI75rxPvMyhaDsn85aR5y4NSL4HHMCFTYApbj8rgl2NlECRj6JRaE0s4+hBVVQ0Vp9jvni3I882ivV3WWs3fZZ3VuEsf5LKVDyYvkCzA6pRzMj4gfOjprH8W+7ckXrFi9sJwdGOi9bjjJhzDfiCIO2Nq5F/Bi2eLmnnBihItW4N+2jPVzavSWSWt5oWSac81e/5bbKY1/qW15MtNIXL3yx57Jj4qnQOlp0MzM89LktMxQhyvAmkNmlFPAB6eLK9qQinwCQdup6OJ4MkZfqC513ZZfT0qsJl7oDj53aAUKiXFO/vXYVk0rjPoX58wy0eFZ4Khtqu+QsHkYG7yssny+DsZkE5Q5DJWabMJ53K89kxDW7eGKCklBDVz1jTyo6TiWmukP/iJtpNrFzRtHG3x4/WJ/6NekgidNHuGJpzYd3HjQAVChjtjm6IcL3LuZX7jfA5l8cQn1xt+z+ehokN8e3so/ae8H6gd5sDoWBPllYlNrqLDFCSYQ4Mt2M4xnfAetFKoJy/0l66TLIxT+pL8dnhdjjxlqn8RqqDGw+fy2cS084z4DTfhdcA0sGEOqUz48LySdAAF5Kjl/x3DUN4K70BKxaKU7FL75xWOCvb77nVT/v9XhoP8TVfv6afKapGrLVWoJlotay8lVe4IKFzhFL5RojJj3Ghfe2tDzvPdTA7coXNvrO9JEHYPs3eyvtoL9A0s/ogNoRvFFNRLgyucU0zoUkpUGeWCPN8twc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(3023799007)(38070700021)(11063799006)(5023799004)(10067099003)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bS9GM2JlTU9yWXJRTjZsSFBid1RIdzVJU3ZoSWo5THdndkNoR0tIUktGQmdX?=
 =?utf-8?B?K0czQWx4QmFDbi96a0xwQzFzVStvME1pZnRpSHdDNmwzK1lKQzNZbHpsV0Fk?=
 =?utf-8?B?Vkgxbjdkc21KYjcvMGRhK3NZWCtQTHJuY3V6czdmYmUxSmtIdU1tR2JNc3Vl?=
 =?utf-8?B?YlF2OFh0U2dIQ3BzVC84eTd1bFZiaUltdWFBakJMRGZtQXhKUGpCOXRMMGZx?=
 =?utf-8?B?d3pWUkFqUnh0WHJvVUtlVUVibnM3YmxpNFJ0T1NxZFlTaDhSWEVWSzV6R2Vi?=
 =?utf-8?B?dTdjZXdXN21BWElFQVI3MHVoZmd4K2t3cXBvR2VyMnJKU04yN2NNVk02OHZj?=
 =?utf-8?B?THNmMUxIRnZJRGtXOW9yRHFYU1F0cjNuVVJPQ2JRVGNnd0htNEpsQ0kzMDlP?=
 =?utf-8?B?RnhmcHRjclNaMkxaRmNmaHNORHdPYzNrVVoxdTBkTzh2UmhXQWVKL1lKYjdI?=
 =?utf-8?B?akxtcittaEYzdHNYa3I5cFlpaFIvSkM4Y2lZUUwwcUs0SG9vK0poQ3NCTVpx?=
 =?utf-8?B?bHI1eDd2N094Ykk0SFVla3lXM2hLNkU4RGpxcytzbjdvWlRXZzc2SFl1NUVT?=
 =?utf-8?B?Y3Z0ZHpueUQ2MkZBUFVVZWVNcVZ4K0tGTThObEY2d0xLNjArQTlUcGpmblhk?=
 =?utf-8?B?dkJQZVIwVUZST3RhblN1QllZdWhRUVdVcDlCTUNvRW00N0UwQnZTUDg1dzRW?=
 =?utf-8?B?aEl0TnA1Rk84WERvK1A5L2JPbFZWKzZsQTRQencrZUdiY3BncWNhdHIzY0NX?=
 =?utf-8?B?VXlEbjVicmtSL1NoWnk3QWs0NS9QY21TZHYvOElPakg4aWZBUnlmZmlKLzRB?=
 =?utf-8?B?UHhKQitsMm9GdmM5b0czZ0dBNjBFUGl2VUUxMVFrcnk3Zm4xaUVuYmxRM1I5?=
 =?utf-8?B?UFpRVzdrMzh1Nmh4VmZDQ0RXeitMeWljM0xHQlNKTU1PS1VtVWJQaUR4U2hZ?=
 =?utf-8?B?SURvTUQremt5dFJ4ZUJqbWtwZkNaVlJCak9FbFhQQXN6WllMTW5sSTBnOFpW?=
 =?utf-8?B?T0dwR1dDd0tXYmxkMkw1VWNROUFSRnNCdzRtYUpEbHJ1Um9PaVk5RVc3dTZO?=
 =?utf-8?B?TThVWjV0YU9pbTNielNoYkxjVjlWYlp5a2J3Q0M5V2crbGxJOWVJdjRYb3dU?=
 =?utf-8?B?ajV0cVlXdTNJV3hlM2dZR0NXNWNLUE9tSy9xSWJ0LzI2SnVVYXYwV0Ntdk0r?=
 =?utf-8?B?K2hWTjNPN0dVZXdmVFlmNWZRT09QeFVrdFpHWU5ZV2ZkM3RuZzFTTXJqOEJE?=
 =?utf-8?B?eDhobHJwN2s5REFhZ2FMZUgxeUVlVWV3aUNSZHdmNDkxdzBlblFJa0srbDFI?=
 =?utf-8?B?ZnlvVGVoaU5YcGhKbWpsOWRIaVNoQkw5Z0FZTytVQnVkVWptYVA3YlA3OTJC?=
 =?utf-8?B?bDFiSkZuZnpnV0RBT3VDZWF1NVVlcDM3MWt0VWo3Y1cyRWtTYlhyZWh5TG91?=
 =?utf-8?B?UmtTTDJrVzhnbjg5RjJ4WnJGNjB2REViL3dlNXpVYkZRblVtWVduekIrWHZO?=
 =?utf-8?B?WFcvajNqd2c3aDU0UlplRGpLV0JvZkFEdGlMRHkxRnkzbWdEWUNkOEJqM09K?=
 =?utf-8?B?aWlpSHEyVkJldlEvR0hUcitJcnoxbktvRm9IN3o3MVcyOGdtU0krWUtOTWtT?=
 =?utf-8?B?bjZ5SG9IZ3VBd0xVZFgwZXhwUkxQcnNHY0VWTEo4QkFNb2VGMmowaVloK1BT?=
 =?utf-8?B?dC85aGVNK3phK05ybTV0QkVWbFRkeUgzT1VBTUthUlQzajcvdXc1ajRmc2dJ?=
 =?utf-8?B?QnJsYnJkVXBoQnJmWkJCT2tsVU5DWEdUc3IreHdYRDh0V3lXSTBnREsralps?=
 =?utf-8?B?Rmx2NXBDUEJ2MzFBYTJ2QzFTdXRuWFh1ZjV6TmkvTmNBNWE5bnV2MEhRWDRu?=
 =?utf-8?B?NWVDcUdTWmRhV0RlMWF4cFhGc1V0Q3pSZnVUMFFTclo1OEQ2VHlTOGtPQkQz?=
 =?utf-8?B?bXQyeVEzamQ2VVdPZUtmc21OR3JPOS81eU04Uzl6OVo5eERRdy9STnp5UHBB?=
 =?utf-8?B?c05oRml4VFNCeG9ORVVxeWhtV3E2L0QrbkpFQWoyT3ROd25aUGxpaEl6TUxh?=
 =?utf-8?B?L2lTRjRyMDJvWTNnUGgxbTNVVHQ0NitYVkZxcVlZcDJzcm9OWCtLYjkzNnd0?=
 =?utf-8?B?bzhMWXNDdXI2LzI0aFRPK0Zhd0g1WkJlcVVnam9DeitJVVBtV1pqQUpvR2JZ?=
 =?utf-8?B?dU5Gbis1TmJ5NUYyZy93WlpiV01OMm11S0paSEo1STVaWHczNlVBTzhvOFNS?=
 =?utf-8?B?QytiNE5MZXBpdmlqcWVMQ2RPZDlrRWRReDVNcm1DQVJ1NDhBcjJCWll6RkpX?=
 =?utf-8?B?NGl2RDNzOFZLSjhtU1dJamU1bWRnQkhKMVVuVVJnVnFCWUdmdjJvQWwvdFI3?=
 =?utf-8?Q?owSbsuaYvpnv/OvnCN3v1MmaZSwKJ+F0kK4qTaaxvYrG6?=
x-ms-exchange-antispam-messagedata-1: 7lSNJqiCPjxThsMiFyi8Uveqpp3TM0tPOXc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BACA85C2EA28784C8B3A7EF114900C26@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nMSpaLMPArU8G5NLNYRYhhmzZ+3d6yT6tPG/z8GdIzielmQkJqTm3ca102u+EHUspRHiihuJd2uL/E0dcaz4wcfsACD31n12p8UErA4tZpPr2NbGWOpo51f/swG1Ewpl+60XpEunCgy9JnIRJMSOqNNeDaXMFtfqQYP8RboFCLaFgDLzNeu52vcWtRLEHpO5cM6FyB4q8fWxaN6HtrYYoa4dBsNvCYsHnrGf6XeDIxPEoKerrUsz/+z+1EEWaoiCsHog8FC6NqP8eRJa3eC4LAp4ckww49nBwQXv/IjxLM8p8vFtZvEnCJBeRzuMFSBIu/0uS45dgeG5janowSHktg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b569945-18ed-4eb7-5976-08deec013853
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 17:05:11.6846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4wvE7sKs+WMuWM9agmB6WO2D8ggVVeHfLviL+X4IIJTxs9voA8kmI1F6ss++iSvQIooWNJQwOVA5A0oJxrIow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDAwOjU3ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAyIHBvdGVudGlhbA0KPiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTWVk
aXVtXSBUaGUgcGVyZiBjMmMgdG9vbCBzdHJ1Y3R1cmUgb21pdHMgdGhlIGAuZmVhdHVyZWAgY2Fs
bGJhY2ssDQo+IGJyZWFraW5nIGBwZXJmX2VudmAgaW5pdGlhbGl6YXRpb24gaW4gcGlwZSBtb2Rl
Lg0KPiAtIFtMb3ddIEltcGxpY2l0IHJlbGlhbmNlIG9uIFBPU0lYIGxpYmMgaGVhZGVycyB2aW9s
YXRlcyBtdXNsIGJ1aWxkDQo+IGNvbXBhdGliaWxpdHkgcnVsZXMgKG1pc3NpbmcgYDxzdGRpby5o
PmApLg0KPiAtLQ0KPiANCj4gLS0tIFBhdGNoIFs2XTogW1BBVENIIHYyIDYvNl0gcGVyZiBjMmM6
IHByaW50IG1lbW9yeSByZWdpb24gZGF0YSB3aXRoDQo+IHN0ZGlvIG91dHB1dCAtLS0NCj4gY29t
bWl0IDIxMGIyOWYyYzZhZTljN2NjOTEwZmQ5OTk0ZDFlMGI5MjA3OGVlYzINCj4gQXV0aG9yOiBU
aG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4NCj4gDQo+IMKgwqDCoCBwZXJm
IGMyYzogcHJpbnQgbWVtb3J5IHJlZ2lvbiBkYXRhIHdpdGggc3RkaW8gb3V0cHV0DQo+IMKgwqDC
oCANCj4gwqDCoMKgIFByaW50IG1lbW9yeSByYW5nZSBkYXRhIGluIHBlcmYtYzJjIHN1YmNvbW1h
bmQuIE9ubHkgYXZhaWxhYmxlIGluDQo+IHN0ZGlvDQo+IMKgwqDCoCBtb2RlIGN1cnJlbnRseS4g
SWYgbWVtb3J5IHJhbmdlcyBhcmUgbm90IHN1cHBvcnRlZCBvciBwcmVzZW50LA0KPiBwcmludA0K
PiDCoMKgwqAgbm90aGluZy4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvYnVpbHRp
bi1jMmMuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1jMmMuYw0KPiA+IGluZGV4IGNiYTJlOWYyMWFl
N2MuLjY4MzQ4YTkzYmQzMzEgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi9idWlsdGluLWMy
Yy5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi9idWlsdGluLWMyYy5jDQo+ID4gQEAgLTI2MzQsNiAr
MjYzNCwzNCBAQCBzdGF0aWMgdm9pZCBwcmludF9jMmNfaW5mbyhGSUxFICpvdXQsIHN0cnVjdA0K
PiA+IHBlcmZfc2Vzc2lvbiAqc2Vzc2lvbikNCj4gPiDCoAlmcHJpbnRmKG91dCwgIsKgIENhY2hl
bGluZSBkYXRhIGdyb3VwaW5nwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiAlc1xuIiwNCj4gPiBjMmMu
Y2xfc29ydCk7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHByaW50
X21lbW9yeV9yYW5nZXNfaW5mbyhGSUxFICpvdXQsIHN0cnVjdA0KPiA+IHBlcmZfc2Vzc2lvbiAq
c2Vzc2lvbikNCj4gPiArew0KPiANCj4gW1NldmVyaXR5OiBMb3ddDQo+IERvZXMgdGhpcyBjb2Rl
IHJlbHkgb24gaW1wbGljaXQgaGVhZGVyIGluY2x1c2lvbj8NCj4gDQo+IFRoZSBuZXcgcHJpbnRf
bWVtb3J5X3Jhbmdlc19pbmZvKCkgZnVuY3Rpb24gdXNlcyBGSUxFIGFuZCBmcHJpbnRmLA0KPiBi
dXQgdGhlDQo+IHBhdGNoIGRvZXNuJ3QgZXhwbGljaXRseSBpbmNsdWRlIDxzdGRpby5oPi4gQ2Fu
IHRoaXMgY2F1c2UgdGhlIGNvZGUNCj4gdG8gZmFpbCB0bw0KPiBjb21waWxlIHVuZGVyIG11c2wg
bGliYyBkdWUgdG8gbWlzc2luZyBkZWNsYXJhdGlvbnM/DQoNCkV4aXN0aW5nIGZ1bmN0aW9ucyAo
cHJpbnRfYzJjX19kaXNwbGF5X3N0YXRzKCksDQpwcmludF9zaGFyZWRfY2FjaGVsaW5lX2luZm8o
KSwgcHJpbnRfYzJjX2luZm8oKSkgdXNlIEZJTEUgYW5kIGZwcmludGYoKQ0Kd2l0aG91dCBhbnkg
aXNzdWUuDQoNCj4gDQo+ID4gKwlzdHJ1Y3QgcGVyZl9lbnYgKmVudiA9IHBlcmZfc2Vzc2lvbl9f
ZW52KHNlc3Npb24pOw0KPiA+ICsJaW50IG5yX3JhbmdlcyA9IDA7DQo+ID4gKw0KPiA+ICsJaWYg
KCFwZXJmX2hlYWRlcl9faGFzX2ZlYXQoJnNlc3Npb24tPmhlYWRlciwNCj4gPiBIRUFERVJfTUVN
T1JZX1JBTkdFUykpDQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJbnJfcmFuZ2VzID0gZW52LT5ucl9t
ZW1vcnlfcmFuZ2VzOw0KPiA+ICsJaWYgKG5yX3JhbmdlcyA9PSAwKSB7DQo+ID4gKwkJcHJfZGVi
dWcoIk5vIG1lbW9yeSByYW5nZXMgZm91bmQsIHNraXBwaW5nXG4iKTsNCj4gPiArCQlyZXR1cm47
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZnByaW50ZihvdXQsICJcbiIpOw0KPiA+ICsJZnByaW50
ZihvdXQsDQo+ID4gIj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT1cbiIpOw0KPiA+ICsJZnByaW50ZihvdXQsICLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE1lbW9yeQ0KPiA+IFJhbmdlc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXG4iKTsNCj4gPiArCWZwcmludGYob3V0LA0KPiA+ICI9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09XG4iKTsNCj4gPiArDQo+ID4gKwlmb3IgKGlu
dCBpID0gMDsgaSA8IG5yX3JhbmdlczsgaSsrKSB7DQo+ID4gKwkJc3RydWN0IG1lbW9yeV9yYW5n
ZSAqciA9ICZlbnYtPm1lbW9yeV9yYW5nZXNbaV07DQo+ID4gKw0KPiA+ICsJCWZwcmludGYob3V0
LCAiUmFuZ2UgJWQ6IFsweCUwMTYiIFBSSXg2NCAiLTB4JTAxNiINCj4gPiBQUkl4NjQgIl0gTm9k
ZSAlZCwgbG9jYWwgcmVnaW9uIGlkICV1LCByZW1vdGUgcmVnaW9uIGlkICV1XG4iLA0KPiA+ICsJ
CQlpLCByLT5iYXNlLCByLT5iYXNlICsgci0+bGVuZ3RoIC0gMSwgci0NCj4gPiA+bm9kZSwNCj4g
PiArCQkJci0+bG9jYWxfcmVnaW9uX2lkLCByLT5yZW1vdGVfcmVnaW9uX2lkKTsNCj4gPiArCX0N
Cj4gPiArfQ0KPiANCj4gW1NldmVyaXR5OiBNZWRpdW1dDQo+IFdpbGwgdGhpcyBzaWxlbnRseSBm
YWlsIHRvIGRpc3BsYXkgbWVtb3J5IHJhbmdlcyB3aGVuIHBlcmYgaXMgcnVuIGluDQo+IHBpcGUN
Cj4gbW9kZT8NCg0KUGlwZSBtb2RlIGlzIG5vdCBzdXBwb3J0ZWQgb24gcGVyZi1jMmMuDQoNClRo
YW5rcywNClRvbQ0KDQo+IA0KPiBUaGUgdG9vbCBpbml0aWFsaXplcyBpdHMgY2FsbGJhY2tzIGlu
IHBlcmZfYzJjX19yZXBvcnQoKSBsaWtlIHRoaXM6DQo+IA0KPiAJcGVyZl90b29sX19pbml0KCZj
MmMudG9vbCwgLypvcmRlcmVkX2V2ZW50cz0qL3RydWUpOw0KPiAJYzJjLnRvb2wuc2FtcGxlCQk9
IHByb2Nlc3Nfc2FtcGxlX2V2ZW50Ow0KPiAJYzJjLnRvb2wubW1hcAkJPSBwZXJmX2V2ZW50X19w
cm9jZXNzX21tYXA7DQo+IA0KPiBCZWNhdXNlIHRoZSAuZmVhdHVyZSBjYWxsYmFjayBpcyBtaXNz
aW5nIGhlcmUsIGZlYXR1cmUgZXZlbnRzIGFyZQ0KPiBkcm9wcGVkIGluDQo+IHBpcGUgbW9kZSwg
c28gcGVyZl9lbnYgaXMgbm90IHBvcHVsYXRlZCB3aXRoIG1lbW9yeSByYW5nZXMuIEFsdGhvdWdo
DQo+IHRoZQ0KPiBjYWxsYmFjayBvbWlzc2lvbiB3YXMgcHJlLWV4aXN0aW5nLCBkb2Vzbid0IGl0
IGFjdGl2ZWx5IGJyZWFrIHRoZQ0KPiBmdW5jdGlvbmFsaXR5IGludHJvZHVjZWQgaW4gdGhpcyBw
YXRjaD8NCj4gDQo+IFsgLi4uIF0NCj4gDQoNCg==
