Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C51432BE3
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Jul 2026 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172026; cv=fail; b=WodduJY7D2/NdN4Ox145pBeBYv6cFo3G4s+NUS3xj2hhD1H3qe1dDxuHmyxw2p1vEDvcVY7OPJS3LZ8xRpcTUonuK/zBUFmmNy71B3k2k5kmc0QZL86N9BvcX+gY1Pq+yTraShQ1oIMZmgePimySPoJfBnZJ+qoVBkzn7FKcHwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172026; c=relaxed/simple;
	bh=V/vdREDd836f42dx/tB6jmMmiK6d34U3QitrreRnvD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E5Z+936g7RnvS0o57J3ZLBjHOpdnn0I/EKDRZ7k68QTUbV4HBetCfDN1az158sra485zB8iU5E9qPcN55ufmD827wesETZc9V5p2L/sPCnnlM0YynqjCf4zObBjQ6SWyttZNnrmmAiv7ce4lwKZW+h6OkHN91S0YsraqXjHKajI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mX3TmLL3; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mX3TmLL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785172024; x=1816708024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V/vdREDd836f42dx/tB6jmMmiK6d34U3QitrreRnvD8=;
  b=mX3TmLL3uFAt1AY7pVMJmv1T0dEl2fivHYtrYgpYSP5OWq3+pe1r41NL
   knYf44nnQX8MKJCTgNxGFXpJdVRdiBtSK4RFuUtUce4Pxx2oYEYJGoZ7Q
   Kg13DFQd1jlBXh32132dUqiGAe5XySc9nQi0EwOhydbnxNp09DWO4T1Bk
   JAvasqyWl1fh/nsUzWAWR9nB8UxTySGMtPhwgMeKDLQwkZAaAomQhKdS0
   C6KF8JYccSY/NZfdoYIyCl2a64V6M6Qd8Ps/hlGQm7fy7KoxJ7nzll6Ct
   m2bhOEXtdHsamaIcN0eZyeWvgPR1FvPWwzCPgQW68esL00bqqftYDVr13
   Q==;
X-CSE-ConnectionGUID: KhylSKTEQNKOR5DZjtUIKQ==
X-CSE-MsgGUID: hsQN2MnLSWmvzDkW3SPvxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96899236"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="96899236"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:07:03 -0700
X-CSE-ConnectionGUID: lrKIqJBBRQSqfuhoPiVfRg==
X-CSE-MsgGUID: BLNPO1YHR96PSjNXqzaSYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255527358"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 10:07:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:07:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 10:07:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 10:07:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5VSAyTruAcfRt4Xvo6YY87exm06hceZASF3M5+MMFJG62lwTIpsYxrZI2s8H6hk5NI+e3MaO0fDjxPowpREjaYWLUHi733upFB5PxpD/hIVy1EeRudj6vsGSG6DrRcSzjno7NgFAGFLfkcjNpwwkqn/nnVFs4kJSEy16FBsXlnOHWhDtuo40Q7ve6uyCFT6zfqGJmG/IDqkbX7bpRgxgS2sEY5DFdL/whxAm7cXPELLKUFN/6r2iA8ynt9B0szA7E/TEyYFxMKckFC4kukqykVup2IImuU9GeKbk1A3mUYlWYtz9vc3KytyK3DhMHWY3IBCgHErFmKHmSa3peX8Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/vdREDd836f42dx/tB6jmMmiK6d34U3QitrreRnvD8=;
 b=DIQle6PIFpOhEt+mrca/o6F+0+76fclDdZHTAFNaCQfRaMTxBIdXWW04NF08Hx+NRiD1I7mqAP18/oMaxP45OklsfQg1wMgUm578u4ynyyCaDQNZijrVtIjuL2QklBGnmLvrqiXAqIPLJa6lcKVvJre7lF94hMXCqbNO3pQ/oI+Fi5KGGlWYMKHvKXrqOBYJkwDfn1n6dAe0myrv5ed65iJ91yEjpb45TJsX+4YBtN63r5fO5EPvI805U+z2+4HPFOt/7sognawoNpt2mCMCoqwEeZPUUM+e7MaIp2idAADsT4MXiCpqlf76PVOUp6rZ16bU89CeC3qtFyU8LRKp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by LV3PR11MB8725.namprd11.prod.outlook.com (2603:10b6:408:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:06:54 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 17:06:54 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Thread-Topic: [PATCH v2 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Thread-Index: AQHdEynvKKl9rl6vhkCtczi7KABE4rZsL5+AgBV+r4A=
Date: Mon, 27 Jul 2026 17:06:53 +0000
Message-ID: <4f122ecf3db0de4cb39deb20f5e4e15f23c0c14f.camel@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
	 <20260714004359.179451-2-thomas.falcon@intel.com>
	 <20260714005200.80E5E1F000E9@smtp.kernel.org>
In-Reply-To: <20260714005200.80E5E1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|LV3PR11MB8725:EE_
x-ms-office365-filtering-correlation-id: e18dc81c-0ab8-44dc-a1a9-08deec01754b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|1800799024|6133799003|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: E420f/Sxz56CgGQGKmA3sRZmtLar/UXtZJ154UveGwidw5ZlZkpTi93lwsOSEGN2uTqj0oxANsUThTOHfG0Rzd5y4tkKDuDTcxQnCceAcwWp5NAGPUN9aAcNQfe4kdqA50rlDDFl1ZXldGlVmNsFCsu3fAKYDD7nFtHbu6gzcvMOB2V5cfqWToZk9/acfVZsjU/5DbLQpxH33q82Vhb+8Ln07Yg5CXG1L6jGbiRHvDm1qyw2VFrFvZ/yMmP01f9d5La3Wg0HOyk1X2Hm0v6UYqtw156Gv1sBIGkho9nZRsYxuA6BLIFiWRRP6UWYqyU83fQ9QbS0hR3LvmBvkWDxOgn2W+XQmvrId/hxuu76YGJ8qUT3++VIzzsYJ+rjb3pus8qShPIFAfxrDG3C1Ff5X7kX9SyC7CQbwE45fu5ah4I5X/vN7ynoSKGgkZ4AiUAyGpkZ0WE2RUQKBB0cd0fLJDJxzEAvdVpWfgbxzLfruflbdFYoV422Qfay8ESRKHfO3BkHhqyx1/AdsEvoOtipy0VhyCm8PxpeF4gt8zIJXq718nZnRVR7fOKbeZPES21gcLMZvyZcz5PaqGcBy6I27y6z5gXli7W6F4SUkwjWXi/UsG8cnWFrkROwbfiWaRL6J6XqdLCr/7FQN3C1rGGJ+9r3Bb8FzN739IOCLUGK5oZNrlUKstbAb1WjejIR+2AKKT+xIwg191I7au2c3VgD6OKn84IWW+1a8J+9JYaJ4bg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3VZWUsvbWlYTi9meDNPcXU5ak1MazRmTjVMTERYeUR3RFdqZHRocFZtQVBs?=
 =?utf-8?B?bkljVTVWbEFnQ2VSVXorUTFVdi9kTWc4QVRYSzlPOHJSMjM4Vk5Md0NUbkkw?=
 =?utf-8?B?N0JxTis0TlNYbGpnamFWSkdkNG5jMitMSXhLaW5hRkN6WERmakZTSkFmcnc1?=
 =?utf-8?B?dndHU28ydE1BUjVFMExWazF2ZkRmVlBUUnJ5Z01qeVp0SDBoNWtQaStOdjVq?=
 =?utf-8?B?YUpCdnZMTGJ6YzVsTTdKRmh4L0JnVDA2eVRURFQ4ZXBJSTNFNTdpU3ZXOGF2?=
 =?utf-8?B?L1FyRFYvdzBWd21qRDZYdUVRVjIyQWJVNGowSlJIenFkSVlwOWsyd2VPaVgx?=
 =?utf-8?B?MzA3RjdZSXFoVEYySHo3OFBqSXBmcktKdmY3K3drbnJZekxZRnRmY2dQVmtJ?=
 =?utf-8?B?d0d6bU9zT1Vyb3JzdWJwRU5xRXFKbEVzU0NPKy95aENEL0xSZG9FZ0p3YXZK?=
 =?utf-8?B?N2ZKWXNhdmxOT1lXTlJUVHB2M1dHMzVNTC91QUErMVlnR1pvV3BhbVJoc1pX?=
 =?utf-8?B?UGhnK1lDM0FPRCtCcnFDMWZBNkRhMld0VUpEKzBPamJnaEZxcm9YbVpXUDQ1?=
 =?utf-8?B?eExZTFo5b1grR3BSbm5RYkxaZk1uSWNHNU1JV1B4NW1VeWd3K1cvRFI3bC9u?=
 =?utf-8?B?YTNZNy9kb1dDNlR0RDJRSDExOUlzTVV3ZnRUV2RmeXlMQks2cDNxYm52Z0JO?=
 =?utf-8?B?aDNSYkpOMlBlS3Q3aUJnOStkbVF5K1JhZFB0clh2bDZQNE8yTUpGNDdPek5y?=
 =?utf-8?B?NU04NkZLUkx2ODVwaUphU3VMa1N5dXRIdzY1a0twaW1kUS8wQ0JoQ3VDOXhH?=
 =?utf-8?B?RTVCdnBsdnQxWGFHaGthZWNKbHNkbnJUWGZNU2ozSTdWK2Z4eXZQWTN3alhv?=
 =?utf-8?B?a2Y3QmE2TW1UQnBlaGw5TUZQUmF4clRtdkxUd0VJcWJtVzJrV2tyLzhObnlY?=
 =?utf-8?B?NWp5eWU4ZGpVcXlBQmdDTzdoeXN3U0ZUQkZSZFMrU3dlQXlJWmdLUUZnNGNF?=
 =?utf-8?B?L0tQSUhzdnRoSXB4dHY5ckdhVTRuallGbUdDaHBDQnVDd01KdmpOUk5TM3Zx?=
 =?utf-8?B?YjJlQ3VLVmJLM215dWxrclN0WmZUNnRMYWlFbUEvSEI2MjZKU0JOYXRFbkZY?=
 =?utf-8?B?K2Jua2kwNjZaUElpeGdGc0d6RjRCOUo0WHNGNDNxSjNhaDlSZGJwdHJiNkE1?=
 =?utf-8?B?NEtHOUd4azU2TUp1cmZLU25sVE56ZWFnbXdUZXYvSzlKOHYrNGQ1Zk0ya1Bm?=
 =?utf-8?B?MnJnbm5LNVdqWDlZQU1HeHVSWUZtcHhqL0tzWkVEVTBhMjg2ZVJnZEo4bWRL?=
 =?utf-8?B?SlczRTRucmJrU1ppZkpvWi80Q3ExK3lrck5lK043RG5ieXh3aENDYUtXM3VK?=
 =?utf-8?B?NERBczYrejJmNXM0alQ5eHNxS1dia0F3a0xHMXhFVHExN3p4d1dPT0ZOUGNJ?=
 =?utf-8?B?OW9SeElIZkRQelFZODlMd0JpVE11NXdXZ05HRDdYMjRQckk5TyttVVFscjdO?=
 =?utf-8?B?SjhuWDJYSkNMaU90VWVmZVR1bkp0aTdnL25CYml1NVZnOURyakZIZjJqKzdz?=
 =?utf-8?B?RUUwRTNZMzJ3bEtpMHh5U3ZZdzk5L3Q1UUhKSmU3ZVpvME9IZGxyamcvMHpU?=
 =?utf-8?B?ZXBxdXJWMVcwdlZwWHhnMDRtMWlyTWl4OXo5d0trM3E0cjlWaEM0TVNOK010?=
 =?utf-8?B?NFMxNmVQbi84QVJNN01sR25MNEU5SUhqMjExUGd0cDJNUEhDYUlUYitJZTdo?=
 =?utf-8?B?dVhqVVhIdHRkR0RYWjJnWGZ0dm1PclBXRjJmd2RXOWp4TG0zOURSemM1czlV?=
 =?utf-8?B?M0Vnd1hCTzRNMnRIbWhGNERuQ1JoNjNUOCsxWXdJR0c5YzhEa2wyVWIzdnFJ?=
 =?utf-8?B?U1N3YWI2RWNCcW4xT0xnVk9lREhXaGR1OTVEYzBSdm85ZHpsNTI4MnZ4d0x4?=
 =?utf-8?B?VW9wTTFCb3g0dTlKaUE2LzVSZ2NHQk9kaVVNLzFSelF2bVlIL0JJSXM2b2VH?=
 =?utf-8?B?dHhXNVVJVTk0L0tuU2pZVnBzb3JEZzlkY1I2TFdPc2RQWHhWQzN6dkorK2Nq?=
 =?utf-8?B?emtFZnd2NDlUTUxwUHFQSWFkWHNQMHpnM2diZSs5WTB1TlJPK053N2dySktX?=
 =?utf-8?B?SzhwWTRpV2Z6ditCUHg1TmUvVkhJa3M3VTRCdzNpcHZZM2t1U29aRWdHcy9h?=
 =?utf-8?B?NTl1ZVplcWZSeUxkU2lkSCtQcWE2TE5qMGVvcElyZ3BNUXBDdk1NNlJML3I1?=
 =?utf-8?B?Q1BGNHdnR0xhRFduTXNxWTJkU2RlL3VZbVQwM2xSZkl1M0V6MlRBQWpQYlVK?=
 =?utf-8?B?R05IQmFMdXZTdThvREh2WFZHMXNRdC8ycm02Ym8wakMvc09FTzR3WDNWS0ZU?=
 =?utf-8?Q?5U6KOfQyOlIPRBSSNwQvBfe0YKx0QChb7Qu4qSHYQB+24?=
x-ms-exchange-antispam-messagedata-1: mjMXTRnBIIYuS15ztO+QdfDjW9W/a6xG4n8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04A8B2C1955187498D83EED530B6DB31@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RBS51KXVuYx4EN9bPTJEhDtA0C7EDS4Rg+/JIP/NAr/Ge1J5G3/34y8i0J5HPStZfxlAOqyvn4erzwpE5iY+b4mT2Psl5c/5T4lugnkuv3UAUsqoeZPR/Lig+Twj/dfLZcqTL6PuxfwCcXrxHEOmTJdIygvjoPIkN+7nfGW5IiJ73ZV4CSsM1Y9DX6bmA1A1ytKoZbGCMlCs3xxuQYjKdKZTEV3wPlD8HwsGFJV/Qm3DOrQtJtSqAHWCeOtHgR3ZHQcjChWXsLP/maPy/0OgVOCojZgw5hBncSj7Lv0jZI70RBOXbCI/CeOQFcaltLKeazP1bEpmeWkFEnNy+9GHZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18dc81c-0ab8-44dc-a1a9-08deec01754b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 17:06:53.9756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XeOB8BtnOLfNyGW41EFwDuzkwa+CQt2B9fYuUPuO9ZhnwrTeYKdK2aKkZAPoARswL1SRu+KbUrEwqa44UKdL3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8725
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDAwOjUxICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9uISBTYXNoaWtvIEFJIHJl
dmlldyBmb3VuZCAxIHBvdGVudGlhbA0KPiBpc3N1ZShzKSB0byBjb25zaWRlcjoNCj4gDQo+IFBy
ZS1leGlzdGluZyBpc3N1ZXM6DQo+IC0gW0hpZ2hdIFNldmVyZSBwcmUtZXhpc3Rpbmcgc3RhY2sg
YnVmZmVyIG92ZXJmbG93cyBhbmQgaW50ZWdlcg0KPiB1bmRlcmZsb3dzIGluIGBwZXJmX21lbV9f
Kl9zY25wcmludGZgIGZ1bmN0aW9ucyBkdWUgdG8gdW5zYWZlDQo+IGBzdHJjYXRgIHVzYWdlIGFu
ZCBtaXNzaW5nIGJvdW5kcyBjaGVja3MuDQoNClNpbmNlIHRoZXNlIGFyZSBwcmUtZXhpc3Rpbmcg
aXNzdWVzLCBjYW4gdGhleSBiZSBoYW5kbGVkIGluIGEgc2VwYXJhdGUNCnBhdGNoIHNlcmllcz8N
Cg0KVGhhbmtzLA0KVG9tDQoNCj4gLS0NCj4gDQo+IC0tLSBQYXRjaCBbMV06IFtQQVRDSCB2MiAx
LzZdIHBlcmYgbWVtOiBGaXggc2l6ZSB0cmFja2luZyBmb3INCj4gbWVtX2x2bCdzIGluIHBlcmZf
c2NyaXB0X19tZW1pbmZvX3NjbnByaW50ZigpIC0tLQ0KPiBjb21taXQgY2Y4ZjAyYzMwNzA2MGYx
NDE3NDBiYjM1NjdhNjlmNzc3NjFlMGY1Zg0KPiBBdXRob3I6IFRob21hcyBGYWxjb24gPHRob21h
cy5mYWxjb25AaW50ZWwuY29tPg0KPiANCj4gcGVyZiBtZW06IEZpeCBzaXplIHRyYWNraW5nIGZv
ciBtZW1fbHZsJ3MgaW4NCj4gcGVyZl9zY3JpcHRfX21lbWluZm9fc2NucHJpbnRmKCkNCj4gDQo+
IFdoZW4gcHJpbnRpbmcgbWVtb3J5IGluZm8gaW4gcGVyZiBzY3JpcHQsIHRoZSBlbnRpcmUgc2l6
ZSBvZiB0aGUNCj4gYnVmZmVyIGlzIHBhc3NlZCB0byBwZXJmX21lbV9fbHZsX3NjbnByaW50Zigp
IGluc3RlYWQgb2YgdGhlDQo+IHJlbWFpbmluZw0KPiBzaXplLiBQYXNzIHRoZSByZW1haW5pbmcg
YnVmZmVyIHNpemUgaW5zdGVhZC4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRp
bC9tZW0tZXZlbnRzLmMgYi90b29scy9wZXJmL3V0aWwvbWVtLQ0KPiA+IGV2ZW50cy5jDQo+ID4g
aW5kZXggMGI0OWZjZTI1MWZjYy4uNGU0OTBmOWNkMzQ4OCAxMDA2NDQNCj4gPiAtLS0gYS90b29s
cy9wZXJmL3V0aWwvbWVtLWV2ZW50cy5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL21lbS1l
dmVudHMuYw0KPiA+IEBAIC02MTAsNyArNjEwLDcgQEAgaW50IHBlcmZfc2NyaXB0X19tZW1pbmZv
X3NjbnByaW50ZihjaGFyICpvdXQsDQo+ID4gc2l6ZV90IHN6LCBjb25zdCBzdHJ1Y3QgbWVtX2lu
Zm8gKg0KPiA+IMKgCWkgKz0gc2NucHJpbnRmKG91dCwgc3osICJ8T1AgIik7DQo+ID4gwqAJaSAr
PSBwZXJmX21lbV9fb3Bfc2NucHJpbnRmKG91dCArIGksIHN6IC0gaSwgbWVtX2luZm8pOw0KPiA+
IMKgCWkgKz0gc2NucHJpbnRmKG91dCArIGksIHN6IC0gaSwgInxMVkwgIik7DQo+ID4gLQlpICs9
IHBlcmZfbWVtX19sdmxfc2NucHJpbnRmKG91dCArIGksIHN6LCBtZW1faW5mbyk7DQo+ID4gKwlp
ICs9IHBlcmZfbWVtX19sdmxfc2NucHJpbnRmKG91dCArIGksIHN6IC0gaSwgbWVtX2luZm8pOw0K
PiANCj4gW1NldmVyaXR5OiBIaWdoXQ0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCBi
dXQgZG9lcyBwYXNzaW5nIHN6IC0gaSBoZXJlIHJpc2sgYW4NCj4gaW50ZWdlcg0KPiB1bmRlcmZs
b3cgYW5kIHN0YWNrIGJ1ZmZlciBvdmVyZmxvdyBpbiB0aGUgY2FsbGVlIGlmIHRoZSBidWZmZXIg
aXMNCj4gYWxyZWFkeQ0KPiBmdWxsPw0KPiANCj4gSWYgcHJldmlvdXMgZmllbGRzIGV4aGF1c3Qg
dGhlIGJ1ZmZlciwgc3ogLSBpIGNhbiBiZSAwIChvciB3cmFwDQo+IGFyb3VuZCBpZg0KPiBpID4g
c3opLiBJZiAwIGlzIHBhc3NlZCB0byBwZXJmX21lbV9fbHZsX3NjbnByaW50ZigpLCB0aGUgc2l6
ZQ0KPiBkZWNyZW1lbnQNCj4gYXQgdGhlIHN0YXJ0IG9mIHRoZSBmdW5jdGlvbiB3aWxsIHVuZGVy
ZmxvdzoNCj4gDQo+IHRvb2xzL3BlcmYvdXRpbC9tZW0tZXZlbnRzLmM6cGVyZl9tZW1fX2x2bF9z
Y25wcmludGYoKSB7DQo+IMKgwqDCoMKgwqDCoMKgIHN6IC09IDE7IC8qIC0xIGZvciBudWxsIHRl
cm1pbmF0aW9uICovDQo+IMKgwqDCoMKgwqDCoMKgIG91dFswXSA9ICdcMCc7DQo+IMKgwqDCoMKg
wqDCoMKgIC4uLg0KPiDCoMKgwqDCoMKgwqDCoCBzdHJjYXQob3V0LCAiUmVtb3RlICIpOw0KPiB9
DQo+IA0KPiBXaGVuIHN6IHVuZGVyZmxvd3MgdG8gU0laRV9NQVgsIG91dFswXSA9ICdcMCcgd3Jp
dGVzIG91dCBvZiBib3VuZHMsDQo+IGFuZA0KPiB0aGUgdW5ib3VuZGVkIHN0cmNhdCBvcGVyYXRp
b25zIGNhbiBjb3JydXB0IHRoZSBzdGFjayBpZiBhIG1hbGZvcm1lZA0KPiBvcg0KPiB1bnRydXN0
ZWQgcGVyZi5kYXRhIGZpbGUgc2V0cyBtdWx0aXBsZSBiaXRzIGluIGRhdGFfc3JjLg0KPiANCj4g
RG9lcyB0aGlzIHNhbWUgdW5zYWZlIHBhdHRlcm4gYWxzbyBleGlzdCBpbiBwZXJmX21lbV9fc25w
X3NjbnByaW50ZiwNCj4gcGVyZl9tZW1fX3RsYl9zY25wcmludGYsIGFuZCBwZXJmX21lbV9fYmxr
X3NjbnByaW50Ziwgd2hpY2ggYWxsIHN0YXJ0DQo+IHdpdGggdGhlIHNhbWUgc3ogLT0gMSBkZWNy
ZW1lbnQ/DQo+IA0KPiA+IMKgCWkgKz0gc2NucHJpbnRmKG91dCArIGksIHN6IC0gaSwgInxTTlAg
Iik7DQo+ID4gwqAJaSArPSBwZXJmX21lbV9fc25wX3NjbnByaW50ZihvdXQgKyBpLCBzeiAtIGks
IG1lbV9pbmZvKTsNCj4gPiDCoAlpICs9IHNjbnByaW50ZihvdXQgKyBpLCBzeiAtIGksICJ8VExC
ICIpOw0KPiANCg0K
