Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022E256E;
	Wed, 25 Dec 2024 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735088912; cv=fail; b=m9LlPDKHZOGFTZm9lbqrEXgkE6nmdtbaodQPcEnC3VtDFNBJW34GJwv4PJH+sBw+MKBHyg3Iq6I7VBNqgQJ/KPs+laCqsx8v1Vc7G6aldIEgp3rOuKjlzyLR0e8Olq4rZEhHWN6S5SPsVgmYIxz2v9obubQgZwB+yN+K/d1NvQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735088912; c=relaxed/simple;
	bh=2TgdZsmbuHgNp80yVNsZC3e1VXovA+jhvzmFnRQ3ICo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eaBMDz9a7DmfbSFBOAgOiHtrUhKtSKxx/uzKkmR2pxWiJ8A4zsghAJDqM7WhieGHoVazM0y9MfYpmF1BURTVTzhHYHiMBPUaeRzS0hyAk1qtMLIPxNTB4+8hyhfnLwHOljMIfoV4S7P6dKr+o8210am1eUoghpc0rzK0XEdrhh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkpR3cIn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkpR3cIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735088910; x=1766624910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2TgdZsmbuHgNp80yVNsZC3e1VXovA+jhvzmFnRQ3ICo=;
  b=NkpR3cIn0yLm35XalcEHZ3BsRJz+nAQkea7QQlpOEoJ28zRJEO9zA8tD
   TnUhktiJ9EA5HvY3jT7Gdnl1tKYqt7NpiKXUAcqPszRRc/shkl/Cd2X/n
   Fv0VjULJjiMpfAWiPA4C/3lYwO/YFl4gXVyqave8e4hPZeWaa5wSf9H4z
   oLyKZ5Eg2moIU4Dl4sXkYh63uji8giVD5RK6wErIHbK83Ybt2GgKy7Ry7
   dJRVR0zko5PF2ms4HJTk7RgvtfmanOSWSFd2vcaL9nX4CXgFhfz8omIgz
   Ti9xLxnE/6PhySPbg4pROw29QDTcWzmvUhm2TM7nkUj9aUbCRwnpUwr4x
   w==;
X-CSE-ConnectionGUID: 31rA/1NnT6+TAnil2uflCg==
X-CSE-MsgGUID: NMa9yw4YRWG8+odBWFjF8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="53078971"
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="53078971"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 17:08:29 -0800
X-CSE-ConnectionGUID: vkgod7mvSBOC31EhJqr+Cw==
X-CSE-MsgGUID: Dr3CvghvQHyktVPH9I3dDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130589966"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 17:08:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 17:08:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 17:08:28 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 17:08:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2663QlDrf4xQcawqsbH1J4phWfhkZgtysMEkONc6fOy/CXdbdH2Fzr9JMy/uvRTTBFgIiw9+ygDKQBCqNid7QEcyzihB3Azr/glIPtj0oxKMzMpySDbey+ZTFgMsPi03MqAd51s7qPkwvHc1GlfJ64aKdM0+AI2n2DMRSiyAa1SBj9cq4Gho+ZsbthUHD7/fLwRLgSVBLpfQiTByTw/2P4epbv9p8mOHNqOULhBL+hVA5aaG1Q2Klc7ctMb3UfnyhNXKl+4E6gRb+GyXR6iHLG055TmfLt13kR6CrEVmRpu1k0ugZBw2Q2Ze3j0vQY1u6y0KntT5DAQLKNCmSd2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TgdZsmbuHgNp80yVNsZC3e1VXovA+jhvzmFnRQ3ICo=;
 b=tGYd49vM1NcnNRiYL60wwKy/QpFtKRX93pS+TIUk/y3gaPrrCK8ZxXpdIPHpTwxEXOr3GsBkQOEaSYqdkmmgM0CiuVY+i97gr1VDuwiCN/KMYWY0CZ/xiZAz5sbVsPBl3HAuAxxCSvB+jO8cEZE+YmF1sXtvt3xEc55+pJcOaMV6Ynt+FqjcRkWTkd4i3nSfbU9fBw7J4jk/jZvtgooxXX/95AV/gA8wYTYrAweuMY3Gztm+ntUP+N/pG80b27ufgVWRNLo/7JnYIIXP6e6yt9Sxu+yKVY2roVRew3Ve20NUsPVFHO/YfUxIL+Cg8a1d8sAM7f4fR1y/6qqkM7LfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7560.namprd11.prod.outlook.com (2603:10b6:8:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 01:07:56 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%6]) with mapi id 15.20.8272.013; Wed, 25 Dec 2024
 01:07:55 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "Aaron, Ma"
	<aaron.ma@canonical.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"acme@kernel.org" <acme@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH] perf/x86/rapl: Add support for Intel Arrow Lake U
Thread-Topic: [PATCH] perf/x86/rapl: Add support for Intel Arrow Lake U
Thread-Index: AQHbVhQtpYL/wVm3YU20yvG8hphrKbL2JtmA
Date: Wed, 25 Dec 2024 01:07:55 +0000
Message-ID: <32cd09bb8f15bf7a5d4d6b0db2a8200a63ab90a0.camel@intel.com>
References: <20241224145516.349028-1-aaron.ma@canonical.com>
In-Reply-To: <20241224145516.349028-1-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7560:EE_
x-ms-office365-filtering-correlation-id: 699d2ea6-94ba-4c86-0249-08dd248090b6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVRkT3lMTkRKblhkT1VsZW90MEh6NTdERFZPb3Fyek0vYlk3TE5tT0c5c1Nl?=
 =?utf-8?B?VWo3OUk1bC9JbU1UYkg3N1E2SWt1SWRydjMvZElvK1lxa2M0QzdmNGZ1RlUv?=
 =?utf-8?B?MFNzUStVNGFCb3dMZ3lqenNjcitCYzE5cXhBRmtFL09GK0dIdEhZTjJuWm1p?=
 =?utf-8?B?TFA1RmhtY1RXbFQyWUVUc2w5c1Z5TGlpRldPelJjTUcyek1wemlWRXhHRk1F?=
 =?utf-8?B?RjA1UmZRUmViN28zV1hUanJHQXNnUGdkTUhDbUhUYThUZ0xPSDZ2b2FPRlJs?=
 =?utf-8?B?RFFBTFlQYXZkbGN5eEhpMC9IRWpNUGRFOW9XRE12UHUyRnFyV2NBUUlFcm1P?=
 =?utf-8?B?cDVPYXo3dk83WVMvTE92NGUrbTFFMGtiRnI5WUtCOFR6NmlxZldSejNOR3ZR?=
 =?utf-8?B?VnA0Rmw1UDEvaDlnendtRjZwekdRU1VXQ3l5enhnL0x3N2JidVZ5TUJadkg4?=
 =?utf-8?B?WHY1VkRiaHJ1S1hRd1YwWmxGb3lNaThwZDA2MFZiRnJMQnovdldNOHFsdW44?=
 =?utf-8?B?c0RMM1NVMmdmOXM4SHIxWVUwT2VsaENhNElmdkFoSW5YeDB5Vk5kdkNsMmZ3?=
 =?utf-8?B?OTRKNS9LK0VRcGxlYUFoek1xK0l4STEyc0sxSXVWcHBRQm43Y0VpMW5yZmE1?=
 =?utf-8?B?M3hxQjl2S1FYSFRRRVY4VGJ5cHZMalFSS3VpcSt6bGtYYTFBNlAyMnJqL2Q5?=
 =?utf-8?B?anpaeXp0bVNwc3ZjUSt0SkVDTlh2ZTdUaUVIMWtjbEFvdVZoRXpzRWQ5bVU4?=
 =?utf-8?B?cnJjbldxdkpodENyTWZieWVmT21GT0hIYlUvczdlTUlLV25hTnNTREFIak40?=
 =?utf-8?B?bzJzd1BIbHlqa0tXS2hBTStOWng4d2U3aHJMMTN3NFFKVFZ4UUNhREJ2UUFa?=
 =?utf-8?B?bU52cmNmZ3poaFNYMjJzMHc0QnpKcVE1Zk5FdmZqK0U4Tm44SE55c0RUd2VE?=
 =?utf-8?B?TVRqc2tlZmZiY2xmVzRPbTF3OFBrcWw5aGhJYlJHQ2g2azY5aGg3c2o2d2N2?=
 =?utf-8?B?K2lJSWx0aExZUVVTZXZvbFNpRDhMZmRtQWliNTJYaHpXZHhqbE02TFJpUTBC?=
 =?utf-8?B?YXpENkJqTmJJYld2SWROcmt2TGJqamVad1IyMzBWYzlrRmVNWHRLTjZpOEJp?=
 =?utf-8?B?dktCK2o1SXdQbUZTTWMvS0NCRUUybHQ2NmhsLzFoTHkxb1dSL2tHRHhSOWVs?=
 =?utf-8?B?WUVsSGJrUENmSjA1NnVQSFpLYVZ4SGlrTHZJK3FrKzlFeG9KUTcwaGtvRE13?=
 =?utf-8?B?VkgvdVByTXBzT2pEclU0KzFjajdZdWVzclJkeUVmdTFNMjV4cUl6UjlHd25F?=
 =?utf-8?B?UEVrZi81dm9YSngzQWFJWUxzWE12QWE4UlN3K0pUS3FuVUNlYXNtOEJTK3JW?=
 =?utf-8?B?WW00aGFDZEdNMFYxTG9EYzdzV0NpMkVOVmZta25jR1NpRHdOWWtjZkFTb05K?=
 =?utf-8?B?TWpDWkpnYllvM3hkVHVuSFpTMS93ck01V29XTktoNG00bzgrQ1ZJNmJUNFBi?=
 =?utf-8?B?aS9TODNOMXVnTTdtbzhKOGlmU3c4OW1HSERCMEpBQWlSUFRxb1ZIRUFPSk40?=
 =?utf-8?B?MkJBVTh1M0R0YjRkakl0d3VnQmdYTTM4VjV6NkMvbThJbW56K0pmaTFtV3Vp?=
 =?utf-8?B?VE1uS2tBMEdFaEpaZll3MjNQc2JCUlV0UlRsdWFSYTgyMTVhWEI2UlZWMlJq?=
 =?utf-8?B?ZUMycjFnd2EvMW9DdjNnS2owSGxoWHNlUGZnVDJiRWtTWDdReWxFUVh6aVNG?=
 =?utf-8?B?UmFUYURxUEM4bHNwRG13NmVHaVlnMXRjTXBOOUNIL29URm85aTRSMzhCbEQ1?=
 =?utf-8?B?SjVPaXdTZzRyRnhSNnBLRXkrUW5VTEoxVEdjbThsMFpuaFBOWHlaU1VSeGFz?=
 =?utf-8?B?ZzMvbDN0TytCMENQTlo0bktNTnZVWVhjL2VEejdzeDRYR1hFckJwbkpWdHpS?=
 =?utf-8?Q?6vQD+jcNEU+Srwlh1nHn6cGUnv+2DnQ9?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVN1Y3JZNnVjU29TMEdDcE5PZTdpRm91c3N1Y1JzZURqVEgyeUlQdHEzVlpa?=
 =?utf-8?B?THlZYVhzTnBHa2RSemJrQUVPNUdrbWZvVERZRUt2eGhqV2gxVURsbEQ0VXB4?=
 =?utf-8?B?bDFOQ0p1elhTTmErYmtxTy90ak9wVUZQckxQL0ExWW5MaXdNNXJsbUdmWEs3?=
 =?utf-8?B?eFMyeC9vMndneEt3YjRHb255UDJkR3l3T09YSmJvTEpNbVk1NzcrUEZGVTRQ?=
 =?utf-8?B?Vm83RFlmUmd5WXdlTFNvdldzZE1VcnN6Z0h4OS9SRXpUTGZ4SS9NMGNqR1d0?=
 =?utf-8?B?TGV0d01jMFVockp3QS9Xdkdhdi9USmpNY1p0bzN2SFQyMExxLzE3SFdSLzdP?=
 =?utf-8?B?Q1g2bndMaUpCN3Y4WjEvTDI5TXhhNXc4eUMwaHM1QXdDZk9GQll2Qkk3YUVN?=
 =?utf-8?B?TTMxcFNYdTR6L0tmSG5VVWVlMTJoSW5xYVBEUkdINnNCUlhhdEhjTFhOUWk0?=
 =?utf-8?B?VnVreXorOHJ5amRFM28vNDIrNmt3TVBvRng3L3RTbE51cHRZUUxzVDV5Qmkw?=
 =?utf-8?B?QUNPc3pNczJYZHJsUGZzSW4rZURmcVhGNXYyTWNzY0F2TnVNNU1wRTRidFhq?=
 =?utf-8?B?VVcwRDlYbXpQLytjeFZMcmZJb0tCaTdMNDBISHE3RHdGbmhZT24vTHlSRVNX?=
 =?utf-8?B?RWRlUnVKRTl6ZjZ2K3FscWFkRWpPQUpTeGZHZ3NNVHNZeFcrWG96OG5DMlF2?=
 =?utf-8?B?SFBXZjRlVGMzLzBQQ1ljRnlmdzFoQ2pjUFNIRXV3SkNSVHVRZW9Rb2RYbWtu?=
 =?utf-8?B?S2I1UjBFYndWdkl3ZmFHMzFWMDVjRytMWDlEVTdVOXNJMnVSeUZDQ2Z0OUcv?=
 =?utf-8?B?SlhScnc1cEVFenViTkJlUkEzSUZ2djZKNG81ajBXUnVJYjA5ejdmSU81eERZ?=
 =?utf-8?B?Yk45djc1YTR6ZklKMVBOKzQzNFo4aHZNZWd6QnR6cW9LUWdKcUZpQ0M2NjVp?=
 =?utf-8?B?YnlaRDhjSnA2L0p0cnQyV1VOZUNZZ21HYWZTRFJLUlQ5QmtFdUN3c2lwanBV?=
 =?utf-8?B?bjZlYWlGOTQycFJoWGF4RkNPbVE1b1hRdjlYRUpmVFMvOHBxSGJuNStyMjRy?=
 =?utf-8?B?RWZuK0xCMWxMYi9jOS9YZ0k4T25uWlZNYVBjdmc4ZFdLdGxhOXBtd2NHei9P?=
 =?utf-8?B?aFV1UlNjVktkU0ljbnkxcTUxd3FDYXVoektyTXNORHFHMS8xTjNodGROcW41?=
 =?utf-8?B?bEpJcGVkb1R0RkdnZG9UUzhjVHc4bFRmb0ZYdENzNk0rSDAxNDRUaGp2dEN3?=
 =?utf-8?B?Mkd1NDFreG44NWlwbURKQm5IL3kzTmhPWktlTjBtcUhmR010UnZORXhvSHlK?=
 =?utf-8?B?ZXFaUVNSTzNiOTVtZmlYYkxLOWJZdTVzY0pnb2t5amFtS3NILytLcUw0U1NK?=
 =?utf-8?B?V2pVQXBsOWd0TVplTEQ0ZHQ4a2NEUG1yUTJOb1lCczVzdDZUSjJkVlB5VE41?=
 =?utf-8?B?bzdMMisxVnhJM2tvT1hlUUJxaGFHNnBOTDdOTWdFa3k4MFU0TUhvRjA3ZTdu?=
 =?utf-8?B?eDc0T3ZxL3V4NGNnT1hBM25vV0RCdFlKdVN1VVpkbmNFVU9ZalNTSWcrZHph?=
 =?utf-8?B?dWhIOW5vWDBob2g2Nm1VTG0xcm1DcCszRnVlTTVIcVdVc2k4NTYyTzhGck9i?=
 =?utf-8?B?ZFg2OVE2NEJVZ0JvL0dyRVZQTllBdUZQR09jY05OcGxaY0VFSHdtYWVZd1Bs?=
 =?utf-8?B?QmFPNVFPTVgrcFdkVzM5REs1aUt4cWQ0a1haTTF1eFdPTERPeEJLREJOd2p1?=
 =?utf-8?B?OS9WNFNUMUJHZ1F1R05ESmpXdHpRWkszR1NRclRjMlE2Z1pSK0lSVWkrMFBq?=
 =?utf-8?B?ZTlTbjVjSzVTS1dpakl2Y1FvdXlBZldFbWhGWC9WUVhQZkpaUXdLdGI3WWVH?=
 =?utf-8?B?M3VieXdwQXhIL0p1MmF1YlZXU2wrM3pXa2U0aU9kUFM0WDEvbmdpRkR6M3NL?=
 =?utf-8?B?TUE3RDM3TGFnYlE5SnNSRDg0a2VjL0JGQkFtcmtDNWI4REhCV0N5cUoxc2JG?=
 =?utf-8?B?eDIxcnRrRjc0ZFNLVWpyb2x5S01qLzhXT3AzNTEyNFFuOXpWVmY4d0ZOQmVh?=
 =?utf-8?B?NXBXVGRUcEhNMXV5ejZ6Mmt0YnE3KzBTaFd4bk50MWY3dXBJQ25JSzY4a3I1?=
 =?utf-8?B?TnNBRGw4MEdxT3VFb2xYeG5MKzI2WFd6bFQ5NlRZdkhJZFhkY1RCdzhCNGlN?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13275BB876EAB044A5A527A7A77A5457@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699d2ea6-94ba-4c86-0249-08dd248090b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2024 01:07:55.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2G/5+bZAXF4/sRZaRTTHZ1YfJwqee8Wk8TxKUit2+3nmsJ0RdqyckBuMwDfr/JlbczbsflqBOcwAUI2JRt2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7560
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTEyLTI0IGF0IDIyOjU1ICswODAwLCBBYXJvbiBNYSB3cm90ZToNCj4gQWRk
IEFycm93IExha2UgVSBtb2RlbCBmb3IgUkFQTC4NCj4gDQo+IMKgICQgbHMgLTEgL3N5cy9kZXZp
Y2VzL3Bvd2VyL2V2ZW50cy8NCj4gZW5lcmd5LWNvcmVzDQo+IGVuZXJneS1jb3Jlcy5zY2FsZQ0K
PiBlbmVyZ3ktY29yZXMudW5pdA0KPiBlbmVyZ3ktZ3B1DQo+IGVuZXJneS1ncHUuc2NhbGUNCj4g
ZW5lcmd5LWdwdS51bml0DQo+IGVuZXJneS1wa2cNCj4gZW5lcmd5LXBrZy5zY2FsZQ0KPiBlbmVy
Z3ktcGtnLnVuaXQNCj4gZW5lcmd5LXBzeXMNCj4gZW5lcmd5LXBzeXMuc2NhbGUNCj4gZW5lcmd5
LXBzeXMudW5pdA0KPiANCj4gVGhlIHNhbWUgb3V0cHV0IGFzIEFycm93TGFrZS4NCj4gwqAgJCBw
ZXJmIHN0YXQgLWEgLUkgMTAwMCAtLXBlci1zb2NrZXQgLWUgcG93ZXIvZW5lcmd5LXBrZy8NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPg0KDQpB
Y2tlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoGFy
Y2gveDg2L2V2ZW50cy9yYXBsLmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jIGIvYXJjaC94
ODYvZXZlbnRzL3JhcGwuYw0KPiBpbmRleCBhOGRlZmM4MTNjMzY5Li43ZTQ5Mzk2M2QwNTc2IDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jDQo+ICsrKyBiL2FyY2gveDg2L2V2
ZW50cy9yYXBsLmMNCj4gQEAgLTc5Niw2ICs3OTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHg4
Nl9jcHVfaWQgcmFwbF9tb2RlbF9tYXRjaFtdDQo+IF9faW5pdGNvbnN0ID0gew0KPiDCoAlYODZf
TUFUQ0hfVkZNKElOVEVMX01FVEVPUkxBS0VfTCwJJm1vZGVsX3NrbCksDQo+IMKgCVg4Nl9NQVRD
SF9WRk0oSU5URUxfQVJST1dMQUtFX0gsCSZtb2RlbF9za2wpLA0KPiDCoAlYODZfTUFUQ0hfVkZN
KElOVEVMX0FSUk9XTEFLRSwJCSZtb2RlbF9za2wpLA0KPiArCVg4Nl9NQVRDSF9WRk0oSU5URUxf
QVJST1dMQUtFX1UsCSZtb2RlbF9za2wpLA0KPiDCoAlYODZfTUFUQ0hfVkZNKElOVEVMX0xVTkFS
TEFLRV9NLAkmbW9kZWxfc2tsKSwNCj4gwqAJe30sDQo+IMKgfTsNCg0K
