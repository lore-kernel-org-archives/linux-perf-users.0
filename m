Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF03FD1
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 04:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740026451; cv=fail; b=OuNCO3bi/5P9hPVfmFJxDKNJ0SpKk1IX3Tz3Snii+jkvT7vLYm2AtJVHugvRkWyXiXh++yrXbzxTNYFAHFTekqy9lPfeMyk2koHsjGwxdM2/RGJJo1A4S4AI6IYOBXaEhTHdpLkvNlJHrElnl3520gTbjJEAeKupY01kWCKiyI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740026451; c=relaxed/simple;
	bh=xe8xnmuTYzB4geuTbVUAokVJbB4m3Rfu/Ww2XtMIHEw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vBp38PG9e4YDnD8aly9Z5MDry0o+IqA9Xk6u68yUH0coRIKNmZqJFKlxywuViW9YZ+Gb1lEiQHAlhNiJZQO9nNsJ1gGcj6xmHhTWTQtcxt+AxTbCoP5nVwoDh2h82xZikU1rxxbp2ZLklwI3jowsb+j7fMNo+3oKFPJTGu1mjc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ODlsMvVo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ODlsMvVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740026449; x=1771562449;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=xe8xnmuTYzB4geuTbVUAokVJbB4m3Rfu/Ww2XtMIHEw=;
  b=ODlsMvVoImYS2CHDu0yXrIVE38bvhBj6UxzQ/ahngSBtrN3LYAtPSzX9
   s33m2Gf06h8wdKLr0fqRjGXOMqeHqbqproYbZGqi0/8rf8SCR7XouXtf6
   P8HcwQzgJiytrVUx/L5p74sCV/4vpbVWph6OBwiAIuzkNus8QzQxQVSLG
   I3cUYEWb4vTt8v5PTg31oOHkJXhs0bCoju5QVEtgBf9o6GIN75+DBy9DJ
   wpT26DfFlABFUAvUNvkVuv9YAwRhPwcN3asC8GiYT61xcc5I6a4flkWNq
   fTgMI6pRQmJ/9ASunUPUkjGbxdz2RQBXK/HkqTpU2tidWCCbn+ByOIizk
   Q==;
X-CSE-ConnectionGUID: JODQkwcJRoOWrpFdmdIaMw==
X-CSE-MsgGUID: 3FI/QAwHTQqmwmhLWcS5yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40911254"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="40911254"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:40:49 -0800
X-CSE-ConnectionGUID: qI5agEaWSAeuu+G5Igi0Jw==
X-CSE-MsgGUID: 7c0YvzVhRJGhqBzC7Pxi/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114873508"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 20:40:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 20:40:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:40:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJxU9tia2Cm2kVAm9vj55eU0Qe78PtNvGvdlBzekNIM6YU53LZHkTSZXJYfTn5B8gF73TPwqjBo1Et+1+A+ut7ju8cFHEiP5O7CU6OtIsZIlgI504dEBg3cBSTcL9U0ZKc4pTANxHQE2cwLSWy3ZEhR6X/1uh7xFEb/qLLbIp7R/axcMG3eAHQQTZj1bie0iOgs0FNQYSw6un/HtS+8JkKEea+Mf34Zw1jOjBoLqxrWh7ZvlDMlP8nt7iR7UqUnaAEBbYE+kX/0P4MPX+qyzbwjRd6EbDBTndwjjm5BUhdsgHlw4VVljyzzyCJHKL+l0/UiuUf7TGuB5HQUqb6ijcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe8xnmuTYzB4geuTbVUAokVJbB4m3Rfu/Ww2XtMIHEw=;
 b=Oo+eym+i+SUpmJrkJbUEec/FuIqbVSUw/IRv6h6tBayRaJiNiUhQSl4AWa0QQRh3mB7ylIZkF1knZCxSoELj0Bp/I8oTn8g/AGOzu4kSt/t6/fIsEVJ/GO1JbQjv1leAbIoX8KdDfMGI+sgRwU80XP5df5lqYfmYRZD0o8kK2IKnw189yzWSFsz26QIXvEZfM6GWAm6Lwehy+G20dajq+MMIb9hies96KPqpUzoN+3x8+hOiGh0wTX2CJ8LbT72LTWcUMLbhmZcbfAbIWy7+DjnhAntT6fY/5z07UhkOrCyUXLRrNVf694/jbYVe0iYev45daPGAm6ITIxvZ0vHTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CH0PR11MB8215.namprd11.prod.outlook.com (2603:10b6:610:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 04:40:18 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 04:40:18 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf report: Fix sample number stats for branch entry
 mode
Thread-Topic: [PATCH] perf report: Fix sample number stats for branch entry
 mode
Thread-Index: AQHbgxj7coxQEzfrv0ODmnRqNEyMvLNPnOEA
Date: Thu, 20 Feb 2025 04:40:18 +0000
Message-ID: <f0e57443a013840c38e672dd39affb5a53e3fc6c.camel@intel.com>
References: <20250219215317.82905-1-thomas.falcon@intel.com>
In-Reply-To: <20250219215317.82905-1-thomas.falcon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CH0PR11MB8215:EE_
x-ms-office365-filtering-correlation-id: b0469c27-5cec-4f22-d090-08dd5168ad66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QThMSnhZa0xFMmhuZ3B1aEZoaEgwd1dVVVc5MWlybW14eFBLSHlyenRmenFW?=
 =?utf-8?B?SmI3RjdnSTlTU3AyZ1cxUE9OMGtPTDYvQ3J4c0M0MjQwekRoekcyQW5SVG1z?=
 =?utf-8?B?bjhsd29kZWZ0dW5vMlQzZ2NEV3V5b1R4bUdOR1YrVDdQaUdaQzRoUDlaK29K?=
 =?utf-8?B?TzRWZW5QVlhVWmQ5ZmdkZ2I2cVBHcDg4dmpaU1VvTVRoRXBRREtnSnlVaWl1?=
 =?utf-8?B?aWt3bzI1clN1eldtdE9nSmZLeWRXVmIwd2puOXF4TUdkT3ZCOG5KTDFvUmxo?=
 =?utf-8?B?dUFLNlc5VVVITzdKZ0ROSEhQUUxqRUE0anNjTUgrWllUVGJsY0V6K0VnbzZl?=
 =?utf-8?B?eC9KY2g3SFZDNFZYa0ZYMFVSdjR6MGdUeTFweVFwaUhaQ2dva3VaNktFWThX?=
 =?utf-8?B?anZhTXBnOURiMzh4bjJaWGRLdlpZN3d6blRxaS9CaVVCUmtDVk1CVVZlc3lG?=
 =?utf-8?B?ajlBOURjR2t3bVozcEVxbkoxSWQ1T0F6OS9xbmxkczBQbTBKUU92WWNYWDg5?=
 =?utf-8?B?OFlLaVZ4TndVcFlEOExHMWhub1NlalVhTFoxcE1GbnBoY0VidHdVdFRWUlp2?=
 =?utf-8?B?SU9FQTI2QWU0RFdaUHVNWVV6NUlwdDBXYWVEaFZTZnBoekNDekR4ZFkzeDYv?=
 =?utf-8?B?WTJzV1RVdG5WMDd2ZnJtaVF0bEtYeWpXSld6TFhJU3MxclF5TjNiYXhwT3ln?=
 =?utf-8?B?QnlyRzFVRWpGN21YRHlNRVZEcHJ0NEhab2NvU29Jck0rblBlZVlnK3FPMTRG?=
 =?utf-8?B?d1liUGdSQ2ZSd2ZrbTJZOVN6c0NCSHZIWDljUVZPTytWS0ZNbHgxUVBUUitQ?=
 =?utf-8?B?aTFZRlk5cC9pUXVvMTZaVGF0SmIxZ1ltOUJnbW5LOUpoaXlHNkxJZzArdE8y?=
 =?utf-8?B?UStiYytkZ0cxZmovMUx4RmFwTHIrdHAvQmN5REdhd2VZRXhKVGRHRFFza0xW?=
 =?utf-8?B?Sk9oeDBabGVtMStKbjYydDZ0QzA0WFg4Y2orbUZpKzRQNm8yZy9Yc1VYWGJQ?=
 =?utf-8?B?NzkrR29lOFZRSDQ5dElyekcxRnVUcVBFVDFObDdqRk5rTlpNNGRYYllGT1lC?=
 =?utf-8?B?SFRSUDI1M3h3UmM2dzQ2R0NZZ0RQaUpENDMzRUFOQnZoSE9nVkFFTGVKRjFM?=
 =?utf-8?B?dHJ2TmJVbjBWSWdaNTVoZUVWZFYzTnFXREVVYmorZzU1c2lBNjc0TGNvRkJa?=
 =?utf-8?B?Q0QrUkZscWdRL1FoMUVyT1V4QWc1MTBXbGhHUEhFS2x6UzVpK1dCbTMxd3pK?=
 =?utf-8?B?U1cyZGN3MUpmdU43L2pRdVRMSTc3bWhVR2pNRkM5UkdNcy9ieng2OXBLOHhq?=
 =?utf-8?B?K25lcTJWNVBOaVdUdWpSSDQzV1BXS0dYUmEyQkJMRVdXaGFXcm9acmRXR25l?=
 =?utf-8?B?WnQ2cFhEVVYzOWNZVmwyWCs5UUlabTFUZGw2N1k1TkwwcTZMQmRscHBaYmlS?=
 =?utf-8?B?eEZ1cS9YeU11eklqRlhvL2U2V0hRZ2xoVmxKSHM1dyt3SDFrL0VGWThjTjhv?=
 =?utf-8?B?QjRldHZVMHZFUlhHSFNTNjlIRytQMDkrVG1acDhpQXgyWGtIM3BzdW1pODVm?=
 =?utf-8?B?Mm1KSkpHaWx4VUtMRHhwbmxESjRhSGJsQkdVNmcza3psVjdvYXFYNDlmZjhL?=
 =?utf-8?B?S2VWTHp2bERwS0JScUljZ2xEa2QwK3FCT25sVTJ4aHZ6YWo4bzFab0p5bk45?=
 =?utf-8?B?clhUR3BtbzZTbzdhWTVZOG9qYTJaOHRyTzlxbjJhVHFJM3VidFJ0U0U0b0hp?=
 =?utf-8?B?WjlKWHNjMEZ0KzI2R3I3bHpabzR1RWFPNVpEZUZ4QXYrcUd0NEphVy94dGtN?=
 =?utf-8?B?Wm5TM2xrTVVJZzA4WjhVbHh6YTVXc1NxSHMzOFpabFVHekFCdEtRRGpVNnRj?=
 =?utf-8?B?MEFFdnhxUzdwR2JsR3VpZWtwMkNIcFB0VzBsNkI4ZXZsbUFleXZ4dzhFaGN4?=
 =?utf-8?Q?TJkbcvVihwRqKgoCPpkyO/USOYay6y2k?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUdVSjQyVXFaWXdDeUtGVUR3STE3RlVQb2d0M2x0MGNCaElDTU5kU2RNRDJH?=
 =?utf-8?B?MCtzc094K3k5bXlWVEJKNGZvTGFKNEh0WVVycGdZY2VjZEJOTk82Z0dQSTBI?=
 =?utf-8?B?ZEF4WDM4aUZFV2pjckd1Y25IK0JPMnZ0K0p3bmVqRE5lYzZLYk1oTlh4QXU3?=
 =?utf-8?B?RjVVYytYKzNvRlF5MlBzcmk2K2JTazdqRkdVZEJwa1Q3d2p1ZzdZNitNMDVP?=
 =?utf-8?B?R0E2VVVzMWkrNDFjL0ZBb2xuM01sMnJpMHdseGZScEhaRmxUbHhnRlNld3V6?=
 =?utf-8?B?SHNQQWxKZkh1WUZrRGQySU42OXBKYkprd1VsalBUb3I3QmtKUnR2N1NINmFY?=
 =?utf-8?B?UThtL3NiT2FLK3VxOVc1d0dXeVAzRFhqQWk1OGdHa00zc2lYTElhTFg4MUh3?=
 =?utf-8?B?Z3V4bHllS3g3aVZMTWozSENLN2d3RVRVTkR4aTNLTzZWYVJtVGVvNEl3NlZM?=
 =?utf-8?B?dmlOa2FvR0wwbVd0dlRmVWQ1T1NIY0F2QjN0b0hSR0JKNHg4eTd4NDhnbTUx?=
 =?utf-8?B?UWdXVmVndkZxV0JSUGxWK0tTUGNzOC9QSjNLQng0KysvMFpRR2RMK1BXS0oz?=
 =?utf-8?B?OENBUlQ5R1RCWGZhaHNoUFNhYUpPQVZBckdHQzlsRlljajY2WVZRbkd1aVJU?=
 =?utf-8?B?TlcwQXQrcVhCc2Y0a0svMDFDU1BtUHlWREN5SHMyVTNKWnY0OVAwb3VVY2xh?=
 =?utf-8?B?MHNobGhGeXNIZFB6VXBsZVRRYWI1K05yV3FSUzc4dnFIaHAwcUhMOVJ6bDl2?=
 =?utf-8?B?RVhNRHFBMExuVmdLYmRJeHBIL0daTzVwMXpCSzVwOXZFbXlRUnFhRVdFVDEw?=
 =?utf-8?B?RkcxMGtGYklkNnVkMlVpeUZJWHVGYlhxVHZxbkR4dDVZV0xUeDFuVnI3UlR0?=
 =?utf-8?B?V1Z5MXorUlQ0cXRpM3R0cytyQXM1OTF4VnVtR1lmYnpvRFBVblZhYklYQUdI?=
 =?utf-8?B?NEFKQ1NpTUVVQ3J3Q0FuWmVCNDdsTzU0VzFrdWNLTXU4VDcyVnZtM0syYnJv?=
 =?utf-8?B?eUh1M0V4dkRNanptSDJBUDVSdTR4ckFacDFSV0lTQ3VOTTNXYWZUM1dpdndF?=
 =?utf-8?B?SCtIVDFmaFM4dXBlRVBIaU5INjEzdE1iK00ySmlCbDFReDZab3V1M3lESEpD?=
 =?utf-8?B?YzQwUWhXcG9CdnBGZlVyVC9vOG5FMkkvTmx1ZkZpQzFlZnBrRlpEYlFDRU0v?=
 =?utf-8?B?Y3Qvd3dPVENOcXVPaVJ5ZGduRE8vTUp0MTlhREI2NDlTTitOVjIycTNSNzRG?=
 =?utf-8?B?MTVHZ3UyUTNlWVlheG5Pck90WVAxQmRtMW1TYW9yYklUc0w1c2kxdXROSnZH?=
 =?utf-8?B?K0NBNnFBeU5TVlBCUC85aU1zNTNIRkVmckRjNEZkWFRKYWxzSXFYZC9qQTRN?=
 =?utf-8?B?VEUxNGVmR3NybHliaEgvcGhkdmZNR2lSeDUwZUNZTzBhL0lsM0xMdHVhZnJW?=
 =?utf-8?B?UnFDVmhhR1ZHd1ZBRmpKY090TCtiRVYyS1NZMmZnSEtoemlZd3NFYW1JQkxZ?=
 =?utf-8?B?TW1VcnNZSVpuTkloVnRIMXliMTgxdkpyMXdLUktGR0c5TFphVWQ2RW9NWlp4?=
 =?utf-8?B?NW5lZGRvL2NrRENwVDhLRlJReWNkTmo1UnRMTU1QbnlmNmlJM0pnMXVVaW5E?=
 =?utf-8?B?cHFBZjFVcG5LUWdvS1ZyWHk4UUFUQytGbEQ4OUMyV3Z2bTYxMjZTQXVvWEd0?=
 =?utf-8?B?U2swNE9FNDNvNFZCMmpWSDgzN3ZzTmp5Ykt5TEZIZEY4ZGcxZ0ZBVzIyZlcv?=
 =?utf-8?B?OEN4T2J0RUpPQk40ZWRYZUNFY3BXb1QvdHdJdkI0dFFONWlENWtFUEt2Tzhz?=
 =?utf-8?B?TlpWN0swK0hwVHhCN2RmbENieDdvOEFJK29lRGRYK3JaMzk1L1VHODdpaStG?=
 =?utf-8?B?a2hnMFBiY3M1SU1rUDBuWFRaS1FNeHVQK0pRVnBXVDU4TzhacXNiSFR3UUhn?=
 =?utf-8?B?RGI0Mm5HM2craGdlR3czZkl5emVZaytlL2xUZkxkbkd6ZDE0eTJPa3Y3YmV1?=
 =?utf-8?B?bDQzaVRKdjhEQkxjZHJ6Q2JxQzJmQytDVkVCSzg1MFNvSTgrMGtWL2NiREVx?=
 =?utf-8?B?aEVMLzhGdjQzT3Z6WjZoaE1xWFdVc2tsOVRQYVk0ci9LUUlOV2dESmtxUGdV?=
 =?utf-8?B?M0dwTkJwWlNPMGtlOWhWN0FEa29TdFNtQnlGM1R4Z0hhL1pvMS9vcTdMU0tU?=
 =?utf-8?Q?Dc+o1UlNuSro0ZTgDzoH5/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A01AF9F11BCB994A96FDEB904350F8A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0469c27-5cec-4f22-d090-08dd5168ad66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 04:40:18.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLTw3ZMk0J+C2DC/GPxzL3EGyCzUGDbL0SkOhLmdn8RuSxlKTP91/HvseGgP+aqOrEZvgdzF8/p10Ktv2XjAGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8215
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDE1OjUzIC0wNjAwLCBUaG9tYXMgRmFsY29uIHdyb3RlOgo+
IEN1cnJlbnRseSwgc3RhdHMtPm5yX3NhbXBsZXMgaXMgaW5jcmVtZW50ZWQgcGVyIGVudHJ5IGlu
IHRoZSBzYW1wbGUncwo+IGJyYW5jaCBzdGFjayBpbnN0ZWFkIG9mIHBlciBzYW1wbGUgdGFrZW4u
IEFzIGEgcmVzdWx0LCBzdGF0aXN0aWNzIG9mCj4gc2FtcGxlcyB0YWtlbiBkdXJpbmcgcGVyZiBy
ZWNvcmQgaW4gLS1icmFuY2gtZmlsdGVyIG1vZGUgZG8gbm90IHNlZW0KPiBjb3JyZWN0LiBDYWxs
IGhpc3RzX19pbmNfbnJfc2FtcGxlcygpIG9ubHkgZm9yIGVhY2ggc2FtcGxlIHRha2VuLgo+IAo+
IEJlZm9yZToKPiAKPiAkIC4vcGVyZiByZWNvcmQgLWUgY3ljbGVzOnUgLWIgLWMgMTAwMDAwMDAw
MDAgLi90Y2hhaW5fZWRpdAo+IFsgcGVyZiByZWNvcmQ6IFdva2VuIHVwIDEgdGltZXMgdG8gd3Jp
dGUgZGF0YSBdCj4gWyBwZXJmIHJlY29yZDogQ2FwdHVyZWQgYW5kIHdyb3RlIDAuMDA1IE1CIHBl
cmYuZGF0YSAoMiBzYW1wbGVzKSBdCj4gJCBwZXJmIHJlcG9ydCAtRCB8IHRhaWwgLW4gMTYKPiBB
Z2dyZWdhdGVkIHN0YXRzOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVE9UQUwgZXZl
bnRzOsKgwqDCoMKgwqDCoMKgwqAgMTYKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Q09NTSBldmVudHM6wqDCoMKgwqDCoMKgwqDCoMKgIDLCoCAoMTIuNSUpCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEVYSVQgZXZlbnRzOsKgwqDCoMKgwqDCoMKgwqDCoCAxwqAgKCA2
LjIlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNBTVBMRSBldmVudHM6wqDCoMKgwqDC
oMKgwqDCoMKgIDLCoCAoMTIuNSUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNTUFQ
MiBldmVudHM6wqDCoMKgwqDCoMKgwqDCoMKgIDLCoCAoMTIuNSUpCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEtTWU1CT0wgZXZlbnRzOsKgwqDCoMKgwqDCoMKgwqDCoCAxwqAgKCA2LjIlKQo+
IMKgwqDCoMKgwqAgRklOSVNIRURfUk9VTkQgZXZlbnRzOsKgwqDCoMKgwqDCoMKgwqDCoCAxwqAg
KCA2LjIlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSURfSU5ERVggZXZlbnRzOsKgwqDCoMKg
wqDCoMKgwqDCoCAxwqAgKCA2LjIlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoCBUSFJFQURfTUFQIGV2
ZW50czrCoMKgwqDCoMKgwqDCoMKgwqAgMcKgICggNi4yJSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgQ1BVX01BUCBldmVudHM6wqDCoMKgwqDCoMKgwqDCoMKgIDHCoCAoIDYuMiUpCj4gwqDC
oMKgwqDCoMKgwqAgRVZFTlRfVVBEQVRFIGV2ZW50czrCoMKgwqDCoMKgwqDCoMKgwqAgMsKgICgx
Mi41JSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUSU1FX0NPTlYgZXZlbnRzOsKgwqDCoMKgwqDC
oMKgwqDCoCAxwqAgKCA2LjIlKQo+IMKgwqDCoMKgwqDCoCBGSU5JU0hFRF9JTklUIGV2ZW50czrC
oMKgwqDCoMKgwqDCoMKgwqAgMcKgICggNi4yJSkKPiBjcHVfY29yZS9jeWNsZXMvdSBzdGF0czoK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTQU1QTEUgZXZlbnRzOsKgwqDCoMKgwqDCoMKg
wqAgNjQKPiAKPiBBZnRlcjoKPiAKPiAkIC4vcGVyZiByZXBvcnQgLUQgfCB0YWlsIC1uIDE2Cj4g
QWdncmVnYXRlZCBzdGF0czoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRPVEFMIGV2
ZW50czrCoMKgwqDCoMKgwqDCoMKgIDE2Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IENPTU0gZXZlbnRzOsKgwqDCoMKgwqDCoMKgwqDCoCAywqAgKDEyLjUlKQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBFWElUIGV2ZW50czrCoMKgwqDCoMKgwqDCoMKgwqAgMcKgICgg
Ni4yJSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTQU1QTEUgZXZlbnRzOsKgwqDCoMKg
wqDCoMKgwqDCoCAywqAgKDEyLjUlKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTU1B
UDIgZXZlbnRzOsKgwqDCoMKgwqDCoMKgwqDCoCAywqAgKDEyLjUlKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBLU1lNQk9MIGV2ZW50czrCoMKgwqDCoMKgwqDCoMKgwqAgMcKgICggNi4yJSkK
PiDCoMKgwqDCoMKgIEZJTklTSEVEX1JPVU5EIGV2ZW50czrCoMKgwqDCoMKgwqDCoMKgwqAgMcKg
ICggNi4yJSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElEX0lOREVYIGV2ZW50czrCoMKgwqDC
oMKgwqDCoMKgwqAgMcKgICggNi4yJSkKPiDCoMKgwqDCoMKgwqDCoMKgwqAgVEhSRUFEX01BUCBl
dmVudHM6wqDCoMKgwqDCoMKgwqDCoMKgIDHCoCAoIDYuMiUpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIENQVV9NQVAgZXZlbnRzOsKgwqDCoMKgwqDCoMKgwqDCoCAxwqAgKCA2LjIlKQo+IMKg
wqDCoMKgwqDCoMKgIEVWRU5UX1VQREFURSBldmVudHM6wqDCoMKgwqDCoMKgwqDCoMKgIDLCoCAo
MTIuNSUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgVElNRV9DT05WIGV2ZW50czrCoMKgwqDCoMKg
wqDCoMKgwqAgMcKgICggNi4yJSkKPiDCoMKgwqDCoMKgwqAgRklOSVNIRURfSU5JVCBldmVudHM6
wqDCoMKgwqDCoMKgwqDCoMKgIDHCoCAoIDYuMiUpCj4gY3B1X2NvcmUvY3ljbGVzL3Ugc3RhdHM6
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU0FNUExFIGV2ZW50czrCoMKgwqDCoMKgwqDC
oMKgwqAgMgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25A
aW50ZWwuY29tPgo+IC0tLQo+IMKgdG9vbHMvcGVyZi91dGlsL2hpc3QuYyB8IDcgKysrKystLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2hpc3QuYyBiL3Rvb2xzL3BlcmYvdXRpbC9oaXN0
LmMKPiBpbmRleCAwZjMwZjg0M2M1NjYuLjRhZTU2YTJhNGQzNCAxMDA2NDQKPiAtLS0gYS90b29s
cy9wZXJmL3V0aWwvaGlzdC5jCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2hpc3QuYwo+IEBAIC05
NzUsOCArOTc1LDYgQEAgaXRlcl9hZGRfbmV4dF9icmFuY2hfZW50cnkoc3RydWN0IGhpc3RfZW50
cnlfaXRlcgo+ICppdGVyLCBzdHJ1Y3QgYWRkcl9sb2NhdGlvbiAqYQo+IMKgCWlmIChoZSA9PSBO
VUxMKQo+IMKgCQlyZXR1cm4gLUVOT01FTTsKPiDCoAo+IC0JaGlzdHNfX2luY19ucl9zYW1wbGVz
KGhpc3RzLCBoZS0+ZmlsdGVyZWQpOwo+IC0KPiDCoG91dDoKPiDCoAlpdGVyLT5oZSA9IGhlOwo+
IMKgCWl0ZXItPmN1cnIrKzsKPiBAQCAtOTk1LDkgKzk5MywxNCBAQCBzdGF0aWMgaW50Cj4gwqBp
dGVyX2ZpbmlzaF9icmFuY2hfZW50cnkoc3RydWN0IGhpc3RfZW50cnlfaXRlciAqaXRlciwKPiDC
oAkJCSBzdHJ1Y3QgYWRkcl9sb2NhdGlvbiAqYWwgX19tYXliZV91bnVzZWQpCj4gwqB7Cj4gKwlz
dHJ1Y3QgZXZzZWwgKmV2c2VsID0gaXRlci0+ZXZzZWw7Cj4gKwlzdHJ1Y3QgaGlzdHMgKmhpc3Rz
ID0gZXZzZWxfX2hpc3RzKGV2c2VsKTsKPiArCj4gwqAJZm9yIChpbnQgaSA9IDA7IGkgPCBpdGVy
LT50b3RhbDsgaSsrKQo+IMKgCQlicmFuY2hfaW5mb19fZXhpdCgmaXRlci0+YmlbaV0pOwo+IMKg
Cj4gKwloaXN0c19faW5jX25yX3NhbXBsZXMoaGlzdHMsIGl0ZXItPmhlLT5maWx0ZXJlZCk7Cj4g
KwoKU29ycnksIEkgbWlzc2VkIGEgbnVsbCBjaGVjayBmb3IgaXRlci0+aGUgaGVyZSBJIHRoaW5r
LCB3aWxsIHNlbmQgYSB2Mi4KClRvbQo+IMKgCXpmcmVlKCZpdGVyLT5iaSk7Cj4gwqAJaXRlci0+
aGUgPSBOVUxMOwo+IMKgCgo=
