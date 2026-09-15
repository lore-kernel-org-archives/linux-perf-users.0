Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC937F315
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488110; cv=fail; b=rI5N0VZXkq3xyd9Q7Vq97ACZOhLH3EtVICFu+y1JrKg5IHRekqEnhh3E9hM2pTIKi2QY3RIUTN8BHNmgF78fN05OK4myzonB4PfYKq7H7g55TbUPTOgfXb81mP/XtQ0TqXRDpZz2Qqj324P8vRYrAH5U5ywIA6EsYVOHEhC68DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488110; c=relaxed/simple;
	bh=5CwD0H6iCtsonHz/gakG6U4SfKopsaMCa9p3RAmF4mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sSv2vEBv0AN+EkbAy87Xp12fkvmCoz473NBbXcTHVMrHnkHYEfu9vpgV4Op9NYSxPDpFrTCWG3wWb9tCqXVvFyH5oNLnw6HrEMwuXsuSqTTC4tutcPj/ZA/sl7jhX+eHntrqkEvTQXyxr3iT16OODDrVGxsw9GmK3qC3NSps1SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjKWNkYU; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjKWNkYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789488109; x=1821024109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5CwD0H6iCtsonHz/gakG6U4SfKopsaMCa9p3RAmF4mw=;
  b=SjKWNkYU4dBpx0s1HJ9lTjzz+aANU/qV+cECXfHQ2D8y1iXt6E7UCPa9
   v1/ZTcfkZUkfmT6eh197SER8jxrUYO1Lyd//oNHgDeDp7IbtHW8WFEzwK
   2OfwLGmJlUnR/r0NIRMsHIBM4/KsKG3M2pTjgKGl+UNo8I0orPDJG61vn
   ofwwY8tQwOrHjQkYmOu5wmcWH1DaCKATPqwKEea3sVpBGOUiUyF87rWRd
   g0lfUMdy9iOAPZOzTKgUAWcVeCOUlkCN5Jh6Je19mA/NSn4PhnhiRnxQX
   VALutct4bdxIVAWfA9qXNTOetpfK5c8Zl9VJlA31lmUKVpxzY8AmvehwN
   Q==;
X-CSE-ConnectionGUID: VwFMIl+RQNWkSZ0waweXbg==
X-CSE-MsgGUID: tNvJdRiFTYC/yB729FmG6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77416949"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77416949"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 09:01:48 -0700
X-CSE-ConnectionGUID: 4fGrNgm3Tt+y59w6RJBlZg==
X-CSE-MsgGUID: eutCLlcPSseYs6qGQPh9Ow==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 09:01:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:01:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 09:01:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 09:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXplvnE/fLOJTT/MEcbtB+xa9+pffLrsMpX5uCQTbDkaAWEGfmEt16Aiu9a5PUqgN4w6dGtpGP29tdeqwu4pFZxCfqsxvZfypxh3y7n9OAmevZKAN74w4fIeTnmciqoo/uUNVsQcf5IhgyNEtrMjXAC3Dn2uooCGMxT6tjzPujfH8+uBGAUHnk+OQo/UhXlV3Hhk8bhSicfvTYPKbLcWqx0yoF0xtNeLX4wbelHJZNClz4VsJMB3sxoSc0I79npnKmt8Ld9IAb/eHcBco6/+H25jhRh1g7C5mbO35m0Rlis3Ttqo5rMHyc9eSgP5htIumgcwPe4Wx3vWbqClBptHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CwD0H6iCtsonHz/gakG6U4SfKopsaMCa9p3RAmF4mw=;
 b=aO1Twps6fmQ1nx4DJfI7zeiAsSaPyR6hdgSSxh/3+bOn3VbMt6r1mMjo5vOD/xh3+jBGbVifSK3rReXXM0taDZHvG7165M5OLey4Vtbloi65OJlih/OeMaOZJ3X+idPlQykApCPoPffjQP9K16qPuKCJ7RObqSGbP+20jeQ7XzPrEQhHgl3yMK3LrNoZhL/j73uwlp2LCVCW4NEgQhXAa/uHg8ZqOKgyq483bJmAzfIWbKod2yZLlYZYAN9ACQGE/bGSOtoeVFtJ8eU3TSoySi9ZisgxRah8i7oW+VnO72obSVZA2RUCTfG2Zzm63p15Spg4FxmnmAwe7K+LsxvipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 16:01:08 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 16:01:08 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "acme@kernel.org" <acme@kernel.org>
CC: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Thread-Topic: [PATCH v9 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Thread-Index: AQHdRJsIz1F2lKnRo0e7VMq/7GR137bOr5AAgAATpgCAAQpoAA==
Date: Tue, 15 Sep 2026 16:01:07 +0000
Message-ID: <cbfdfa4e0f57b12ec30f8d3db0becfb17fc80e63.camel@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
	 <20260914224650.52982-5-thomas.falcon@intel.com>
	 <20260914225716.667A11F000FF@smtp.kernel.org> <aqiMSGuBkJHjMYei@x2>
In-Reply-To: <aqiMSGuBkJHjMYei@x2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|SJ0PR11MB5214:EE_
x-ms-office365-filtering-correlation-id: 3101787a-82d9-4359-0840-08df13428e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|23010399003|38070700021|56012099006|4143699003|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: hXDB2B7W1895OJaDE/zSuYfecRjgRnniMXux2359Wk8M1uX2ELwmRYny6N1wA5zNYJR+mYZqUAWretT+ktcS7xjGOQFgLA9qkWGwpGqS7EpbumykkrRCQbfF8QiBzee7QiF0zKfxzk/tMJuI5Of6nKO6l+kIpMclb3fbcxjtR5fOVugWd7FFK6mzoeEl7qf0sjP1VCJbsTW9eJxxi2HtofndBGPspE9eIbQgBgE9I1qKOt2XeNsxmrrMBmrxMhjQF5M1EXG/3n73uvUW7x+u9cckWp+9UiVn1/2lDY0ZCNKnZj1yGe37fvuiXTSZsY1qOKOcyow8RX8Oj8h9hgIKf+9FDIZqBsxpHavG2A14wAdSXth25USugwrCTj9EKhQ8Zip+K+O8FQy4ywlOp+gZ2NMzwaCqj6fbekCuf5v0pKD/O6ZOcD/kPKb/hrRSWQq58Jw4oengi0CX1A60evwjeZh0nP5LlIE4qfsY7AI6vxVRoYFDNvtOLnZ6PbSr4Q9mKTitfLdlT+Lob0NshYvYpDbHfpoZJN96EQBJQdPILzXbQFfdUHYVv18a8oWX+p9Q0JdRyqZRSGbMCaETTeKwmBEjrTutPvdqJ30IAXpEhgOZ+HCZdVNgJA1gzOxXTMpLfc12V+u/cFCwqaGIE81PfpeRw0lDC2gx54fH5hDhHCU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c20vcGVDQ0VmUzdtMDUvN09QbVpLTXhTK1JSR1dYdldzYi9ocXZXMzVtVnhV?=
 =?utf-8?B?VXlzcFhFUmw4OUpDbTFVTkx5RS9wdXJ0Z2RFOWprRlY0OWxEVW5KOGh6cSt2?=
 =?utf-8?B?Q0phM0p3NHU0ZldZVHJSaUxaaWJnRVJBeXJTays2VnFXSFQ4TTR2bjZ6LzQz?=
 =?utf-8?B?N2V2WGYvN04zUnNTcFd1U0MxVHdRKzNWZk5kd1BiendIVzVlNEMzeTFlOSsv?=
 =?utf-8?B?RzNvWHFpV2pjK1dtZ1JVZDE1VzYxbGYyQmFRTFJqTnRnL2d3NVEvQk10NWY3?=
 =?utf-8?B?M1JWenlCQnpCOE1nS0lPTkp6anBqU3FtMzd1S1R3cnppUk5ObW5KWXVRMFdq?=
 =?utf-8?B?TFdBMlhYZUk3L2dTa0VUTVMxR0NNNHh6WThLbXRwT1BzTUJHR2tSMU1OemFL?=
 =?utf-8?B?YmwyRloxRURpS2dzdmZkc0tsNTAzV3dzSllzWGxSTTZ5OThiUEVuODZLeVBz?=
 =?utf-8?B?ZnQ2K1ZwZk5hN2NwaXZyQkNKczZUemp1RTJNTW1zQW40cTdJc1FRa3dHVnEz?=
 =?utf-8?B?UkFseDA2dkhLcHEwUGFIWDFXWE9RWjMwZm9YM2NndmpQaWJrSHFKQWEzenJp?=
 =?utf-8?B?TGNVRnJ0emRMeXdtTHZXZlVZT0lvc3QzZkNjMkJlcU5vSTNTNUlTMm1EYThq?=
 =?utf-8?B?dGhjTFVZTGVFWkJUVUU2dWVrMWM4MHU4amdXSzhTK0NQdlo0RzRFT1J2OEJ6?=
 =?utf-8?B?ODFiY3ovTS9yS1UxNDdCeDU2cTlLcGN0b1hWSzAvRGpxMEx2WE43cWlDcXhH?=
 =?utf-8?B?ZjlUMGJwYUN1ZEdPUWtTYUxXdndyL0JLdUp3Y3NwTGgzNmJPdGlyNU9nM1FU?=
 =?utf-8?B?ZEpOSHdxQnV1MGY0L1lURDY5S3VFUmowYTdXeWZ2b3pxREdBWjcwRW9NbVcw?=
 =?utf-8?B?N0N1OWhpcmM0Wi8rdWlWVGdJVmUwbUVQODVWNHRsTGVNL1FLVXhham9ZL0Nk?=
 =?utf-8?B?WC9RMGlNaG1tci9vK0JjaWpWZmwrb3hjYkFnaUQyNWdXT3d0RmZMSVhHOEJ5?=
 =?utf-8?B?QUt0WEhscFdzbWZja1U3VDd6V0pDcFJHT0JNanZiSjEySldqUlFtVmxBSUUr?=
 =?utf-8?B?WVY2WkFKTG0zaUJjVEJubU5CVmlZUE1GTVlvMElmK0pBQ0UxOU1QZWdsaWk1?=
 =?utf-8?B?MXh2cklFMlRDL3l0MzhPMUZ3L1VsZi9vS2h1eU9QcUphcno1a0VXU2dxdEVq?=
 =?utf-8?B?cUxTcTlkdGFUY2kyVW1JZW5Gc1RGUDByakVVR2JBTXB2Skl5RDdrRjliaWJn?=
 =?utf-8?B?Z2dqVS9Jc0VFd25GdnA3MDBuaXBiT280UFhjeFFxSHdvNVhnMjdhTi9tM24y?=
 =?utf-8?B?dmt2OUpRT2FVY3dRS285clNqTHcxNU5TdmpOMXR5UE9HRTRwSDZTMWpyNTNz?=
 =?utf-8?B?MC9SeWd0MDFzMXc4Q09DTTZScEl0UUhWck1nNWtMekd4VXU1NUhmbzBFblBo?=
 =?utf-8?B?Q29LWXVHZVJhQlYzbGlMMW50WUJjcTlISXRuUG5NelZiellUUlRoUk9hMFpl?=
 =?utf-8?B?UGY0ci9DbWhWL1gyU09pNzBQcTc1UVJ3enN3NjMxTXRiSmQ2Qm9ZRUQxMWhu?=
 =?utf-8?B?ZGVqaU5SQzBST0htN0owYmM3dHpac1F3Q1pLRkZJWExJRnQ4UXJsQjVLMWpJ?=
 =?utf-8?B?WStVbHU4Q0huUjVZZlh5QUpFenlwOGdkeWszOHNxeDVUS3llRDRGajNOUXZw?=
 =?utf-8?B?d2t1MW9RU1d1WjNIemNLTVkvV1hqb0pZcGhJeVlnc3lod09wUHZyTG1yempn?=
 =?utf-8?B?aUNNeDNHUlpqQkJFbDZnYXVCSCtIN0NhR09RRXJub2VMbysyY0l1ZlhsRkty?=
 =?utf-8?B?aW1haGE2N0FWRXRQVTZrTGhGak93akZpaDlUVGtNaXhiNURYNWIvZGFaV3RM?=
 =?utf-8?B?Nytlc05ONHEwSHBoN1lDUGcrc08zOTdHRnFyWWkwS20vUTdXQ0xCdFozQVVl?=
 =?utf-8?B?S0tNU3RLRzN0dThqQ2VMVE1Db1p1Zzh4ZmZvaXVNRVVScmw3cHVzY0xjUnZ5?=
 =?utf-8?B?RmdsYmUxemp5TmprT2NLMm1MZnJBQzFzTjh2TUxvYmRlODdhK3dkMVM2dVZI?=
 =?utf-8?B?OXFkRjcwaStkK1pQZ0lQd05KcU84N1BaSkp2cUpVOFNER0NqbWNNUEVMT0xj?=
 =?utf-8?B?eWlsUEZWTlF5aHgvbzFPa0puWnBOKzhka1h1TUNaTjNmS01hOW1TU1djSnNr?=
 =?utf-8?B?ck5pTVZiY0ZUbnRJQ3IzQXhPelpqWlB3R0RiZ3VHaHA2dnllYW4xM0NxenBR?=
 =?utf-8?B?RWpmNllxMDRKUjV3WjFYWWtQMzFjdngwR3JHcHd4VWc4VWh6TFNkVE1VenNY?=
 =?utf-8?B?RVlCL292bk1GeEtTT1U1d3QzcnhpdUNiUVc2QmF3ZUZPU2hNUExKbXNES3ZL?=
 =?utf-8?Q?ywudLdGgmXjjUlpUJeMVmOAZbq3EFVzVXHQlEoCqgqIPz?=
x-ms-exchange-antispam-messagedata-1: UkgXIi4z8xFrBjIqljcTiIyUAA3if14/K9g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A14F5414C0EB14296F90A4F1DF43B2D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vCa81CaqmSJHPhCivaTi6Cg43OZHY5KWVVplY3sRQtOPAVrQfq0LIXpFqA7K91qGMXoYBzdm+f7scexTMuzPG9AKVUL7gxXYj03p2oKqj8MT0G37OOrxYPY55IKECRXRQJGL1iQAykpM6o59T2sa0nXhfhMU/pNlDIF4rZtgP2xwnOCEUHpGcLqa3jOYzGwFJ94lzo8k0iV0GY1eIiDNXdDw0x1WPEICxR0hG33eipZrzto8S2DK9bBHWo8PsRNmultriiVjMr1YnS+WK+7mrsHyf5uxAl4xN1NCfrYYuFmjKpNw86Qr+MnB1cz1gh53xvA2pzfBAIBMxJjGEYI49w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3101787a-82d9-4359-0840-08df13428e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 16:01:08.1068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ttr5gb402XpvoPZpkIeLpGASPSXh4UoUuuforOWTJzLkVYfmnS5PmVi5Gzke5tQmt4aSZNe5uAYxbuk2q0PzWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5214
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTE0IGF0IDIxOjA3IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IE9uIE1vbiwgU2VwIDE0LCAyMDI2IGF0IDEwOjU3OjE2UE0gKzAwMDAsIHNh
c2hpa28tYm90QGtlcm5lbC5vcmfCoHdyb3RlOg0KPiA+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250
cmlidXRpb24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDIgcG90ZW50aWFsIGlzc3VlKHMpIHRv
IGNvbnNpZGVyOg0KPiA+IC0gW01lZGl1bV0gcGVyZiBjMmM6IHZhbGlkIG1lbW9yeSByZWdpb24g
b3ZlcndyaXR0ZW4gYnkgTi9BDQo+IA0KPiBBbGwgdGhlIG90aGVyIGFyZSBtaW5vciBzdHVmZiB0
aGF0IEkgd291bGQgZml4IHVwIG15c2VsZiwgYnV0IHRoZXJlIHRoaXMNCj4gb25lLCBjYW4geW91
IHRha2UgYSBsb29rIGF0IGl0LCBhZGRyZXNzIHRoZSBvdGhlciBtaW5vciBvbmVzIGFuZCBwb3N0
DQo+IHYxMD8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IC0gQXJuYWxkbw0KDQpUaGFua3MsIEkgd2ls
bCBkb8KgdGhhdCBhbmQgc2VuZCBhIG5ldyB2ZXJzaW9uIHNvb24NCg0KVG9tDQoNCj4gDQo+ID4g
LSBbTG93XSBwZXJmIGMyYzogbWlzc2luZyBzdGRpby5oIGluY2x1c2lvbiBmb3IgYXNwcmludGYN
Cj4gPiAtLQ0KPiA+IA0KPiA+IGNvbW1pdCBkN2FmNzM5ODI1NGE1ODVlOTgzMzA5NTdmYWYzNDhj
NzYwMzM3NWJlDQo+ID4gQXV0aG9yOiBEYXBlbmcgTWkgPGRhcGVuZzEubWlAbGludXguaW50ZWwu
Y29tPg0KPiA+IA0KPiA+IHBlcmYgdG9vbHM6IFNob3cgbWVtb3J5IHJlZ2lvbiBpbiBwZXJmLWMy
YyBzdWJjb21tYW5kDQo+ID4gDQo+ID4gQWRkIG1lbW9yeSByZWdpb24gZmllbGQgdG8gdGhlIGNh
Y2hlbGluZSBsaXN0IHZpZXcgdG8gaGVscCB1c2Vycw0KPiA+IGlkZW50aWZ5IHRoZSBtZW1vcnkg
cmVnaW9uIHRvIHdoaWNoIHRoZSBjYWNoZWxpbmUgYmVsb25ncy4gVGhlIG1lbW9yeQ0KPiA+IHJl
Z2lvbiBmaWVsZCB3YXMgaW5jbHVkZWQgd2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIHN1cHBvcnQg
Zm9yIHRoZQ0KPiA+IE9mZi1tb2R1bGUgUmVzcG9uc2UgZmFjaWxpdHkgKE9NUikgaW4gSW50ZWwn
cyBEaWFtb25kIFJhcGlkcyBhbmQNCj4gPiBOb3ZhIExha2UgYXJjaGl0ZWN0dXJlcy4NCj4gPiAN
Cj4gPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjAxMTQwMTE3NTAuMzUw
NTY5LTEtZGFwZW5nMS5taUBsaW51eC5pbnRlbC5jb20vDQo+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvcGVyZi9idWlsdGluLWMyYy5jIGIvdG9vbHMvcGVyZi9idWlsdGluLWMyYy5jDQo+
ID4gPiBpbmRleCA3MTViNzVkNDJmMmE4Li40MjcyZjVmMjJjMDFmIDEwMDY0NA0KPiA+ID4gLS0t
IGEvdG9vbHMvcGVyZi9idWlsdGluLWMyYy5jDQo+ID4gPiArKysgYi90b29scy9wZXJmL2J1aWx0
aW4tYzJjLmMNCj4gPiA+IEBAIC0yNDcsNiArMjQ4LDE2IEBAIHN0YXRpYyB2b2lkIGMyY19oZV9f
c2V0X25vZGUoc3RydWN0IGMyY19oaXN0X2VudHJ5ICpjMmNfaGUsDQo+ID4gPiDCoAl9DQo+ID4g
PiDCoH0NCj4gPiA+IMKgDQo+ID4gPiArc3RhdGljIHZvaWQgYzJjX2hlX19zZXRfbWVtX3JlZ2lv
bihzdHJ1Y3QgYzJjX2hpc3RfZW50cnkgKmMyY19oZSwNCj4gPiA+ICsJCQkJwqDCoCB1bnNpZ25l
ZCBpbnQgbWVtX3JlZ2lvbikNCj4gPiA+ICt7DQo+ID4gPiArCWlmIChXQVJOX09OQ0UobWVtX3Jl
Z2lvbiA+IFBFUkZfTUVNX1JFR0lPTl9NRU03LA0KPiA+ID4gKwkJwqDCoMKgwqDCoCAiV0FSTklO
RzogaW52YWxpZCBtZW1vcnkgcmVnaW9uIElEXG4iKSkNCj4gPiA+ICsJCXJldHVybjsNCj4gPiA+
ICsNCj4gPiA+ICsJYzJjX2hlLT5tZW1fcmVnaW9uID0gbWVtX3JlZ2lvbjsNCj4gPiANCj4gPiBb
U2V2ZXJpdHk6IE1lZGl1bV0NCj4gPiBEb2VzIHRoaXMgY29kZSB1bmNvbmRpdGlvbmFsbHkgb3Zl
cndyaXRlIGEgcHJldmlvdXNseSByZWNvcmRlZCB2YWxpZCBtZW1vcnkNCj4gPiByZWdpb24gd2l0
aCBhIG5ldyB2YWx1ZT8NCj4gPiANCj4gPiBJbiBwcm9jZXNzX3NhbXBsZV9ldmVudCgpLCB0aGlz
IGlzIGNhbGxlZCBmb3IgZXZlcnkgc2FtcGxlIGdyb3VwZWQgaW50byB0aGUNCj4gPiBjYWNoZWxp
bmUgaGlzdF9lbnRyeToNCj4gPiANCj4gPiBwcm9jZXNzX3NhbXBsZV9ldmVudCgpDQo+ID4gwqAg
YzJjX2hlX19zZXRfbWVtX3JlZ2lvbihjMmNfaGUsIG1lbV9yZWdpb24pOw0KPiA+IA0KPiA+IElm
IG11bHRpcGxlIHNhbXBsZXMgaGl0IHRoZSBzYW1lIGNhY2hlbGluZSwgY291bGQgYW4gZWFybGll
ciBzYW1wbGUgdGhhdA0KPiA+IHByb3ZpZGVzIHZhbGlkIE9NUiByZWdpb24gZGF0YSBiZSBvdmVy
d3JpdHRlbiBieSBhIGxhdGVyIHN0YW5kYXJkIHNhbXBsZQ0KPiA+IChzdWNoIGFzIGFuIEwxIGhp
dCkgbGFja2luZyBpdD8gVGhpcyBjb3VsZCByZXN1bHQgaW4gdGhlIGNhY2hlbGluZSdzDQo+ID4g
bWVtb3J5IHJlZ2lvbiBiZWluZyBpbmNvcnJlY3RseSBkaXNwbGF5ZWQgYXMgJ04vQScgaW4gdGhl
IHBlcmYgYzJjIG91dHB1dC4NCj4gPiANCj4gPiBbIC4uLiBdDQo+ID4gDQo+ID4gPiBAQCAtMzI3
MSw5ICszMzUzLDE2IEBAIHN0YXRpYyBpbnQgcGVyZl9jMmNfX3JlcG9ydChpbnQgYXJnYywgY29u
c3QgY2hhciAqKmFyZ3YpDQo+ID4gPiDCoAkJZ290byBvdXRfbWVtMm5vZGU7DQo+ID4gPiDCoAl9
DQo+ID4gPiDCoA0KPiA+ID4gLQlpZiAoYzJjLmRpc3BsYXkgIT0gRElTUExBWV9TTlBfUEVFUikN
Cj4gPiA+IC0JCW91dHB1dF9zdHIgPSAiY2xfaWR4LCINCj4gPiA+ICsJYzJjLnNob3dfbWVtX3Jl
Z2lvbiA9IHBlcmZfaGVhZGVyX19oYXNfZmVhdCgmc2Vzc2lvbi0+aGVhZGVyLA0KPiA+ID4gKwkJ
CQkJCUhFQURFUl9NRU1PUllfUkFOR0VTKTsNCj4gPiA+ICsJaWYgKGMyYy5zaG93X21lbV9yZWdp
b24pDQo+ID4gPiArCQlkaW1fZGNhY2hlbGluZS5oZWFkZXIubGluZVswXS5zcGFuID0gMzsNCj4g
PiA+ICsNCj4gPiA+ICsJaWYgKGMyYy5kaXNwbGF5ICE9IERJU1BMQVlfU05QX1BFRVIpIHsNCj4g
PiA+ICsJCWlmIChhc3ByaW50Zigmb3V0cHV0X3N0ciwNCj4gPiA+ICsJCQnCoMKgwqDCoCAiY2xf
aWR4LCINCj4gPiANCj4gPiBbU2V2ZXJpdHk6IExvd10NCj4gPiBEb2VzIHRoaXMgZmlsZSBleHBs
aWNpdGx5IGluY2x1ZGUgPHN0ZGlvLmg+IGZvciBhc3ByaW50Zj8NCj4gPiANCj4gPiBTaW5jZSBt
dXNsIGxpYmMgZW5mb3JjZXMgc3RyaWN0IFBPU0lYIGhlYWRlciBzZXBhcmF0aW9uIGFuZCBkb2Vz
bid0DQo+ID4gaW1wbGljaXRseSBpbmNsdWRlIGhlYWRlcnMsIG9taXR0aW5nIDxzdGRpby5oPiBo
ZXJlIGNvdWxkIGxlYWQgdG8gYnVpbGQNCj4gPiBmYWlsdXJlcyB3aGVuIGNvbXBpbGluZyBwZXJm
IHdpdGggYSBtdXNsIGxpYmMgdG9vbGNoYWluLg0KPiA+IA0KPiA+ID4gwqAJCQnCoMKgwqDCoCAi
ZGNhY2hlbGluZSwiDQo+ID4gPiArCQkJwqDCoMKgwqAgIiVzIg0KPiA+IA0KPiA+IC0tIA0KPiA+
IFNhc2hpa28gQUkgcmV2aWV3IMK3IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2
MDkxNDIyNDY1MC41Mjk4Mi0xLXRob21hcy5mYWxjb25AaW50ZWwuY29tP3BhcnQ9NA0KDQo=
