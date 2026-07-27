Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8458429003
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785170269; cv=fail; b=J7pqwqAr5VHw8Ur1tHIKDUgyfs3bO40fk4rCIIsV8Zo2Ne7glUnD2mCALcy9blWJeMU51IQwmr4t3XaFM781SXO5XW+bCTX8fB9x11TVQX5D+2Gi51GzqMSnO0UIGzMNqSupL8/u8H7sCjJn/UPlv/SwHfqxcFa7cI/zfeoXXbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785170269; c=relaxed/simple;
	bh=xoj1r3Lpck3Iq3718YRIMZ+KUsRvDJSEZgTFKdflnO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Me87gcjoQfMUeD+xBeDcJr+K5rmSqXXpLS0m2nXrJM56zR8JAOP2VWI2bTVe9AaS5OusKGQHgtIoiYLk3hbOZRsSXj+0CVCtTebpUuBT47UKxupZDh5DAn1h69tit9CAHoKcgGU6OIR73/7X6ynLSihjNZ14Qgkubq4ghVTpLt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhjUXqVT; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhjUXqVT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785170264; x=1816706264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xoj1r3Lpck3Iq3718YRIMZ+KUsRvDJSEZgTFKdflnO4=;
  b=MhjUXqVT2Os34D60yzzs8MNyB2Oks/EcChgQ/cgWDOhirxuLUPueNoc1
   MOciGFsrS3CDt37nkPTD4zrUMEg2H2E3Ku5hUEPe2zEP71TMj7QVra8ar
   cMgJ+FyP8WA6OgurrspqpLsQZsNWfqGQZP/rvU3C56bPktIX9Leqkmu3p
   7gpfyMgVv74c3np8jQ2PmU0ag4oa2YcgGMfUlj+TF0+WPDADvu8gglE5/
   2455vfUM4kS5hS4fyte29RAjGvWBRC7Y2yzMyyMj4/0pdRYONWy1kSP23
   jAVGYi1orHT7EBbfJ8dV5+/qTE8tgQPp1FQfuYDlkJBoq9YQrKc087cjB
   Q==;
X-CSE-ConnectionGUID: 94Fz6eFfR6OxU9AKpctaNg==
X-CSE-MsgGUID: lhqx9xT4RpCnyQXl2PBUAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="103284916"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="103284916"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 09:37:41 -0700
X-CSE-ConnectionGUID: CAn0flXIS6qoPUcSwD9BNg==
X-CSE-MsgGUID: kUOTN0sLSRKtTpqiZ+mKxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="264437272"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 09:37:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 09:37:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 09:37:40 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 09:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nceaOf3QyWJFTY1ok9/QrFcft2a6Ot7J4Dm0I/IHCQ4KYqMqhFdUUeu4OwJqN2ija91vTkbKxOM1mgeOMoWebAB1D9ABJJgEBDsn8FFSwK88uOX158v4NeMcm+U1O4W6D/XF+9+ZCcyqHQHMAo91zbm0lCw6t3pBl+LFlIW/sAr7CsNRDIuyxdCwBcKSiidBRjBDa3uZFSLEKkDa5JHIAA51MLyCchIEmKhUObjchd1jOn5ySz/gW6Hw/4LWhhH+mz1Aw55JWzrvlBtU97Y99MI9cWD6h549HlSgkeYev15LYHPCJk9P7qx4WxxNH8NVdy5XQdO+YhBHd6fS6+XGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoj1r3Lpck3Iq3718YRIMZ+KUsRvDJSEZgTFKdflnO4=;
 b=qVdnSa8UbJ7llVQbTO/hGvmcqCjO0m2InZ2uVk9IbWPuttK7xY/dpJ/HYBde2o+eYC7Kv+6Shs55PYSGIJfP3RN27EZJLEb+S/jnYdQWGoQHAPdZDKv5r/NDtLm01guhSD6JucSCyF1VJTdMYEfM3ZRPNt/E+3L2OovCo+xeLRbDgmSDiumNeoFDwJb5p3T9SiPlvwGGdDXiNVKGdB9atwOoA2nmBfIE7Ftq1r5DxI2QJfJVW8JPDjLalUdoYRZXywNoeinqT2jb6PWKhy7prcL5yF+k3h4WyAjDztWgLuTXzUzs3X5CANkD/TaO8BCwfPP9lYbKAEaMO1i97LOhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Mon, 27 Jul
 2026 16:37:36 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 16:37:34 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] perf tools: Show memory region in perf-c2c
 subcommand
Thread-Topic: [PATCH v2 3/6] perf tools: Show memory region in perf-c2c
 subcommand
Thread-Index: AQHdEyoXtXgVR6l3xUWhOe/Y66HBeLZsMNMAgBV1SQA=
Date: Mon, 27 Jul 2026 16:37:33 +0000
Message-ID: <19a4c9074b6f07c50541ad0595224f600b94b82c.camel@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
	 <20260714004359.179451-4-thomas.falcon@intel.com>
	 <20260714005619.36BAD1F000E9@smtp.kernel.org>
In-Reply-To: <20260714005619.36BAD1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CY5PR11MB6089:EE_
x-ms-office365-filtering-correlation-id: bebd3465-74f5-4842-4678-08deebfd5c3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|1800799024|11063799006|5023799004|6133799003|4143699003|56012099006|38070700021|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: 4hZDA8S5g2bBcltwKh0NQ6yeMpHgWl/2jHAUkxgJrZw9G0XJzbD2vilxV9l3dl4cjGp2ozuXuJssyV2TxS2gweKoEw6e+X2jQiqw4JwfL8e6P9vAFnbyX643xksKRDLyCy3q/y/4HXmgDHKJMk2qT9aPdPXBXV6B37OO1+KfjdqaGljgn6X2yOWX/fK0EdgAeUneUQ3w2zZIk0zEpBEU4QcbCQfdsCIBdM1ygHm6mupmeXd779zEt+kqExR9JtnjN9rLynZcfPkQaHVVYXNKemOCvFvD84Hw5HvKG+qEiEhD2bjiKkbMoxGylfZCnmgLqx++236NtOVUbWqjpChhP6k2TUbxLe34ZP94uDZ9tcpCwEXpmFdB0PM7VoQbNs0MQo67UlPRuWKcwG8mkppq2zqiq33k3n/JyVsxv1KN0CmY4pwEy1cFmPaQK0v0u2Lp4QBwT2bBQS1ZABhZAUXmWlIz1Z/X7mA129anExXddkxglQaiVlAbsMKnl4wpZx48G6G30ZMAJe1eY+zcuHjG/DhKCp5etPxHbIP8soxM6D64dAMjrhCpylB5LGKKybNL+95cq5o2ttOSWf4GRRYw1GgcakrN6x7/x4Ew0GtlhFute0J409TtII1fXzmXkVcfu1f2V8GtcwMasYwchg0IZNZGJTDLBcZoRVaTsjToHzAM6fWrx4WaqfW67pg55+YZ2bn3PyeRH5Y8TGTFi/AAGdbUo/wIGzPtBXFebuoRXh4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(1800799024)(11063799006)(5023799004)(6133799003)(4143699003)(56012099006)(38070700021)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU1LamdiL05GNnhjdjhWSTVhN0I3K25tTFpDQW1PYm9iTmFNN0lkUmhWU05Y?=
 =?utf-8?B?SGYrRlBFT2ZVYnlrWnZrdW1wNFZJNWRCc1V6NHBLbVQ5dkhLc3ppZHMzSlFi?=
 =?utf-8?B?WTl3T2lzTGNiRjdBZ29rc3AyQ3ZES0oxckFDRHYvdTNuRm5zQ24yaU9hSkdk?=
 =?utf-8?B?M1ZIa1JvYllVTkV5N2o0emYwRkNmcG1zL0dxY3JhT0gyUHVrc1BLcHpCL1RE?=
 =?utf-8?B?czVleHBnSjFMcFFBSzZxaVpvWkJuaEtwU2VJaVlXMFF2Z2NiWHlZMUt2di9G?=
 =?utf-8?B?d1VXRHN0VjZSaVRIdnUwUlgvT3pJRHRsVnFta28rUVkzS1dSeW9JVnZSY1Uz?=
 =?utf-8?B?M01uRFFIL21XaHN5NjFSMkJ5N1VvYWFUa1FkUWJoVkd3bjAwM1FHdHhkK08w?=
 =?utf-8?B?cUhLaVRWTC9PaS9XeTgvRXpqMDB0RDE3UFlDcFRPbVZFMFN1b2d2N0xpQzgw?=
 =?utf-8?B?V0o0Y3NCaVBkRExteEdydVI3bW85dVlMemVoZkc5SjRScUEraEdWSlJDbi95?=
 =?utf-8?B?d1IwclRwRHNKRDh2SnRmN2pEVW8wOUsxQ0Q4UE81VEovVmZSSGlnYTg0ZXNk?=
 =?utf-8?B?OE9QTjZENFBETHZmaDEvTEh6eVcrN2RJSnB5WDVuUVZlZXNSL0tiNC9GT1BY?=
 =?utf-8?B?UkRScTR5cUNsakVUbVBJTTg1OVFvUlE5enQyUDdQTFZyM1pTb3hBT3RaVzUr?=
 =?utf-8?B?S2o5MXNpeGc3cjlBeDFoRUVJM2JlOWdaM0ZPUk9zOFdMZ3drdTh2QUx5RWlY?=
 =?utf-8?B?bHFIZGhtdW53WnFNdThRUDE3UThROG9RSUE3ZEs0dmlvb2w3VU1aT3RMQ21N?=
 =?utf-8?B?T05wU1VLMzJoU2ZyRlBZd2FLV2JXcXRCODFqd1ZlK2hVY01UZTc1NTZjY3d5?=
 =?utf-8?B?d2kySmgzYTlwcVNQaEErSXdxb2duSkdFdk1mUzE4b1pMU3lFT3RlSWNSNFN5?=
 =?utf-8?B?Q3NGOTN2L1h6RVlwejlhc1M1RmZlYzNMdGVKL0hZZVZDazB3eDJidzJSSFlx?=
 =?utf-8?B?OEE2bmx1UXB2dXNXNlZhU2hscnk5eEtqWnBhOHY2cHdHcE5VdFBEUnRMeDVy?=
 =?utf-8?B?QjU0emdLRXNObXBYcnY4WHFiT3N6aVp1Q3lZMjhlODJ3V3JQdEY1Q2pCRTQ2?=
 =?utf-8?B?eGVCdnBWanl0R2ZIM1BiSU9zOHNIbjVPejRjMlJQbmFMZnFlQ1R2RUpKUm5w?=
 =?utf-8?B?Rk1GUEUwQUdVRTQ5Yksxenc3eDlhbm5iVUpXaG42c042OWdEbmNoL3UxZS92?=
 =?utf-8?B?VGcyZDlIRkZMaG5Ibnc5bW1PbE81dE1kZm4rWDZDWjc3RWtab2FMeERXUHow?=
 =?utf-8?B?Ri9FT1A4Z01vVjlqdlhrZWUwZEhwckY3d205NXRwUXUzbDdZeFRoQnRUUnFO?=
 =?utf-8?B?czRjRW9yRSs0RFl6Q01YcDNsbWRkNjlDNEY1WGZINUZzVGYzUXNNS1VMYk5q?=
 =?utf-8?B?US9aZnBMaHEvcW9hekJzK1pLLzhjUUQrdTNGWHVuMXV1U0lrWmRiWFVTRnhZ?=
 =?utf-8?B?M0VSR29FenptbjMxN3pwTDhkSjJ4R1VibE1JQzBkeXNZbDJacEMzSUtCamhN?=
 =?utf-8?B?dVl1RFNtNkVwQjAzR1I5QkF4QUU5dU4vZWhNOGhSZk1ndmNZYnpFY3p1U1R5?=
 =?utf-8?B?b3NJemFQTkpPT2ZKRm02djBLTmdmaXc5U1M2aUtJeXJPMWVmMTluK2RGOXFL?=
 =?utf-8?B?VWdmRXFUZmE4Q0ZQMytYRTNiQVpzUWxDL1oxVXR4UFdIZlhvcGE3L1N4aW5W?=
 =?utf-8?B?bGlqbVc0Y2FWUlFKK3lEUDN4VHZFTnI5enVNckRlWUcvbTdDU1I2ZVNua3Mx?=
 =?utf-8?B?UUVxcEdoS0JxR2x3TVlxV3BFL1FLaXV5TkpoaTM4eCtsNS9HMVg0NFY0TGJx?=
 =?utf-8?B?a00yaFp5VmE5N012YXErc3pCV3J4dTBnK3dseGN6L003Mi9vUU1QN2ovOW0y?=
 =?utf-8?B?bGRSNjJod2xFSTg5U3EwYnFrTURabFBQdlBQdkdiakFyVFk1bmRJN2tHRFdX?=
 =?utf-8?B?ZjlmMGFEYW4vRkhuYm1keERKMUJUaWdWQ2NVTW5ob0toQXRHcHF5V1NFcHNJ?=
 =?utf-8?B?THZhREhyb292S1p3OUFJL0hwR09nRkJIS1YzU1Y3SU5vY0lzVy9ma21pQ0Yw?=
 =?utf-8?B?ZFpwTFpwaWVZeGFkYWphQ2VkWXBlMVN5dnhzWkkydysvUFBoSC9IR3RSeHRq?=
 =?utf-8?B?TzltYk05V1BFV2c3SFh2ekk5RllkN1ZHYVJTUUhUQmZqQkhReVd2UUt4K3Rj?=
 =?utf-8?B?Z0QrRkdJdVlPUnVocU5XV2svU2xqbzluWm8vU092UTd6YjVvYm0wRTg0bFhx?=
 =?utf-8?B?MUJRNm9BenlkNUFoVjByU0lEbmd3NmNNMXh3cUt0c21FbEowZjlBUStyZ1JK?=
 =?utf-8?Q?zotSPRRRMKoXSD9IR+xE3wV4HfUw+q1H6uNzn/BtgRSF/?=
x-ms-exchange-antispam-messagedata-1: wSzGAT6oHNB4Gtboi61f0uiS+2aVg15BcBQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7532B9351F6F8489458CD7F045CB465@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XCp9LsEmr5iX6rlia6xEeT6cCLMraeUba1taF4EOTGpWvElezhupL7cV4LhYHPdAgzxZcXJB5y4D8WhWnIgR+rfUCsqkz/gEHV7aCSeueYO67I+xFAlEM/mIZeQm/XPUNqpkS3udTqAAYz/OepeGJJbJAEFau/3pYou4v+eUwZY6J0cP/5KoC2Af2+Q1BubYO9LY7l0EyYzG2VT2RQM+k9skIJKRxHLMSp/IQ4i9/itU4eCZP3YkutXIlRbYTP4idSWItAks4+OfainxiI1xDFDGjyzcald9SeJOq2pM9fIAD5qAs9ePbtSlHV8OPan2ZvvnIni3xXSTs+GqHzYtng==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebd3465-74f5-4842-4678-08deebfd5c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 16:37:33.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nOYevKD/QOGFEsmHVm/QBHSIIqBcra8GgLDabQ1aeRlyLfaCYRz2bTBi5/PjwgLB3bYQo/pbcPUQ/BWxxBcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6089
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDAwOjU2ICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbA0KPiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gLSBbTWVk
aXVtXSBBcmJpdHJhcnkgdXBwZXIgYm91bmQgb24gVUFQSSBtZW1vcnkgcmVnaW9uIElEIGJyZWFr
cw0KPiBmb3J3YXJkIGNvbXBhdGliaWxpdHkgZm9yIGZ1dHVyZSBtZW1vcnkgdGllcmluZyB0b3Bv
bG9naWVzLg0KPiAtLQ0KPiANCj4gLS0tIFBhdGNoIFszXTogW1BBVENIIHYyIDMvNl0gcGVyZiB0
b29sczogU2hvdyBtZW1vcnkgcmVnaW9uIGluIHBlcmYtDQo+IGMyYyBzdWJjb21tYW5kIC0tLQ0K
PiBjb21taXQgMDZjNTA2NTczMjUxOWQwYzYwZDE3MzliYjhhNDIxZjkxMjA0ODZiOQ0KPiBBdXRo
b3I6IERhcGVuZyBNaSA8ZGFwZW5nMS5taUBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBwZXJmIHRv
b2xzOiBTaG93IG1lbW9yeSByZWdpb24gaW4gcGVyZi1jMmMgc3ViY29tbWFuZA0KPiANCj4gVGhp
cyBjb21taXQgYWRkcyBhIG1lbW9yeSByZWdpb24gZmllbGQgdG8gdGhlIGNhY2hlbGluZSBsaXN0
IHZpZXcgaW4NCj4gcGVyZi1jMmMuIFRoZSBuZXcgZmllbGQgaGVscHMgaWRlbnRpZnkgdGhlIG1l
bW9yeSByZWdpb24gdG8gd2hpY2ggdGhlDQo+IGNhY2hlbGluZSBiZWxvbmdzLg0KPiANCj4gTGlu
azoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwMTE0MDExNzUwLjM1MDU2OS0x
LWRhcGVuZzEubWlAbGludXguaW50ZWwuY29tLw0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
cGVyZi9idWlsdGluLWMyYy5jIGIvdG9vbHMvcGVyZi9idWlsdGluLWMyYy5jDQo+ID4gaW5kZXgg
Yzk1ODRkYmVkZjc3YS4uY2JhMmU5ZjIxYWU3YyAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJm
L2J1aWx0aW4tYzJjLmMNCj4gPiArKysgYi90b29scy9wZXJmL2J1aWx0aW4tYzJjLmMNCj4gDQo+
IFsgLi4uIF0NCj4gDQo+ID4gQEAgLTI4MSw2ICsyODIsMTggQEAgc3RhdGljIHZvaWQgYzJjX2hl
X19zZXRfbm9kZShzdHJ1Y3QNCj4gPiBjMmNfaGlzdF9lbnRyeSAqYzJjX2hlLA0KPiA+IMKgCX0N
Cj4gPiDCoH0NCj4gPiDCoA0KPiA+ICtzdGF0aWMgdm9pZCBjMmNfaGVfX3NldF9tZW1fcmVnaW9u
KHN0cnVjdCBjMmNfaGlzdF9lbnRyeSAqYzJjX2hlLA0KPiA+ICsJCQkJwqDCoCB1bnNpZ25lZCBp
bnQgbWVtX3JlZ2lvbikNCj4gPiArew0KPiA+ICsJaWYgKFdBUk5fT05DRShtZW1fcmVnaW9uID4g
UEVSRl9NRU1fUkVHSU9OX01FTTcsDQo+ID4gKwkJwqDCoMKgwqDCoCAiV0FSTklORzogaW52YWxp
ZCBtZW1vcnkgcmVnaW9uIElEXG4iKSkNCj4gPiArCQlyZXR1cm47DQo+IA0KPiBbU2V2ZXJpdHk6
IE1lZGl1bV0NCj4gRG9lcyB0aGlzIGFyYml0cmFyeSB1cHBlciBib3VuZCBicmVhayBmb3J3YXJk
IGNvbXBhdGliaWxpdHkgZm9yDQo+IGZ1dHVyZSBtZW1vcnkNCj4gdGllcmluZyB0b3BvbG9naWVz
Pw0KPiANCj4gVGhlIFVBUEkgZmllbGQgcHJvdmlkZXMgNSBiaXRzLCBhbGxvd2luZyBmb3IgbWVt
b3J5IHJlZ2lvbiBJRHMgdXAgdG8NCj4gMzEuIEJ5DQo+IHJlamVjdGluZyByZWdpb25zIGdyZWF0
ZXIgdGhhbiBQRVJGX01FTV9SRUdJT05fTUVNNywgdmFsaWQgcmVnaW9uIElEcw0KPiBmcm9tDQo+
IGZ1dHVyZSBrZXJuZWxzIG9yIGhhcmR3YXJlIGFyY2hpdGVjdHVyZXMgd2lsbCBiZSBkcm9wcGVk
IGFuZA0KPiBkaXNwbGF5ZWQgYXMNCj4gIk4vQSIsIHdoaWxlIGFsc28gdHJpZ2dlcmluZyBhIHNw
dXJpb3VzIHdhcm5pbmcuDQo+IA0KPiBJdCBsb29rcyBsaWtlIHRoZSBuZXcgZGlzcGxheSBsb2dp
YyBpbiBkY2FjaGVsaW5lX25vZGVfbWVtX3JlZ2lvbigpDQo+IGNhbg0KPiBhbHJlYWR5IG1hdGhl
bWF0aWNhbGx5IHNjYWxlIHRvIGhhbmRsZSB0aGVzZSBoaWdoZXIgdmFsdWVzDQo+IGdyYWNlZnVs
bHkuDQoNCkN1cnJlbnRseSwgb25seSBlaWdodCBtZW1vcnkgcmVnaW9ucyBhcmUgYXZhaWxhYmxl
IG9uIHN1cHBvcnRlZA0KYXJjaGl0ZWN0dXJlcy4gVGhlc2UgZGVmaW5pdGlvbnMgY2FuIGJlIGV4
cGFuZGVkIHdoZW4gZnV0dXJlDQphcmNoaXRlY3R1cmVzIHRoYXQgc3VwcG9ydCBtb3JlIHJlZ2lv
bnMgYmVjb21lIGF2YWlsYWJsZS4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+ID4gKw0KPiA+ICsJ
LyogVXBkYXRlIG1lbV9yZWdpb24gb25seSBpZiBpdCByZWFsbHkgYWNjZXNzZXMgbWVtb3J5ICov
DQo+ID4gKwlpZiAobWVtX3JlZ2lvbiA+PSBQRVJGX01FTV9SRUdJT05fTU1JTykNCj4gPiArCQlj
MmNfaGUtPm1lbV9yZWdpb24gPSBtZW1fcmVnaW9uOw0KPiA+ICt9DQo+ID4gKw0KPiANCg0K
