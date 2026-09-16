Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17013DD86C;
	Wed, 16 Sep 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.57.120.243
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567361; cv=fail; b=R0AlzyCm5Kj9EB3dHCrK6sb7f+dK2CMm2AH53zv/I5KdMlyBnoYfgBvayx9MQkVA/XH25tX/cJnBCpe99HDySN/qbFLYZKgc4kBpwn/xDIyKwJIwf48CFoZWqCwr2MrpVLcA+Ccm0dRnvJRMKVhQLdXuBlDHmfxF0F256n+g6oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567361; c=relaxed/simple;
	bh=AVcyXdOon5CKkJBY1bVpYPrjUrmASWeYGn8vyzmNJFY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZ0XBNiyWBMVHGcoNt0iRuEvsgHfhWeaZLEzZKIswPTZKQTWXLG8R/RMXf03fMcScJmgtb4FGnfIG1zLJb2bF9Sob2EiqZ+rjTPB2og4KJ0O1xo692AfbsosRkYyv9JzVeHkTl63yx5ah7aByHEg14VQxJoiSh2u0u4k/F4MqwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=XGYh6dqh; arc=fail smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="XGYh6dqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789567360; x=1821103360;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=AVcyXdOon5CKkJBY1bVpYPrjUrmASWeYGn8vyzmNJFY=;
  b=XGYh6dqh/Ixu4t7+876j/qQ7Sy+sJhMSRishgdU0+SoOx/wZxMDGanxn
   W25LhQBkZmanl70DMEwAD8XIB1t1oLwPtSTH0APVxatKlhnkZVzBKJJXf
   KbeggDQsF5xfcDqPTBPZS3z8tU7Hp7ssbPYuqqnKth3HRefgio0pWS3R+
   bbWTAH5lJ0aSf+MrM8+ZUukXuLtWE6CzbiIko7bPES6KRm4mrt6HtMCn9
   YxugyX8RZ/st8H2lxcTcDupEp9POmbhCheBiAjLA+LxQYm3YiKDPz6RcC
   yAWk3E2DDf5+exzTPxA3MVloOG4qDVzZDXS/+3VySduJOuk9QN0ydiRby
   Q==;
X-CSE-ConnectionGUID: +KuMascOR5SwSV6yeGf+UA==
X-CSE-MsgGUID: VPlTEo8HTOqDfVYijmWFFw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="19549597"
Subject: Re: [PATCH] perf/x86/amd: Reject AMD Merge event as a countable event
Thread-Topic: [PATCH] perf/x86/amd: Reject AMD Merge event as a countable event
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:02:35 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:22633]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.1.143:2525] with esmtp (Farcaster)
 id 742ffaae-d64c-4fb5-8125-91d2350a6874; Wed, 16 Sep 2026 14:02:35 +0000 (UTC)
X-Farcaster-Flow-ID: 742ffaae-d64c-4fb5-8125-91d2350a6874
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Wed, 16 Sep 2026 14:02:35 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46
 via Frontend Transport; Wed, 16 Sep 2026 14:02:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7Lh9ezPcj2YC7YTYLFg0w/3XHITf2jOa2TocYe+NUWZgxsSYlNpU4/xNfcHy1AHuBebzEPQZB0YKE17wKlpxnWb2ObMqtnazo5uHwNDQMgo9MjI8K6OlljgPLji8dZpH1LjyjRLhHKLtypsrGXwljVlxbzCFQufdGIK7weVundZpeySIR0akw1oBVJz4b6CoogeK2Biztzbi7UvGFHsMQVqBgB4mayGVWW12zufYM7v1raiUuoA9j2X8oCASfXnmqzdh/oRdPbgZByVbdP0EgUBEF58K3enZuW0POj0I0BBE8M5jdCYaLS0yUy0tThZtyECW9LeipH1DicHmf+VAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVcyXdOon5CKkJBY1bVpYPrjUrmASWeYGn8vyzmNJFY=;
 b=s52d2FqHVDDz0ThitnB5rj1+Y/tmDVEIcKhH0etQhhNNFLsR514s4suN0xyb1RPwSNtYx6FQMymWoeY+Y57ZoC7HLrbWh5/2TAVe9JENROo9ZMsPCiX1r1LMnm7Ms0GzBEnokQhmnNhGIaU9wqi/RrUrH1KE5G7WZnKy4+sYn64Nh0IkbQXrhXkIe3ayuCyijZptfnuRlS7dtg56cQrghRk6vM8mmhIiv/BFNik9mH1I0LCuASXhvuXEt/EM6OaAo4QFnujLGJdD0WchAX9MiL/wSFF+Sx40NA3almLf8Db4h8xlrRYFsey8stt55797kTD6HHsbgxpme8YtgQFH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1bf::23)
 by FRSP281MB5841.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 14:02:32 +0000
Received: from FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8]) by FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::1c27:e30e:1c73:ccd8%4]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 14:02:32 +0000
From: "Absandze, Luka" <absandze@amazon.de>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Thread-Index: AQHdRde9QHMfQ+o9x0qyyB92c8Ih4rbRKJKAgAATxwA=
Date: Wed, 16 Sep 2026 14:02:32 +0000
Message-ID: <aqqhR9rZBUx-jscN@dev-dsk-absandze-1c-663c31a8.eu-west-1.amazon.com>
References: <20260916123315.89042-1-absandze@amazon.de>
 <20260916125146.0E96F1F00893@smtp.kernel.org>
In-Reply-To: <20260916125146.0E96F1F00893@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR6P281MB5787:EE_|FRSP281MB5841:EE_
x-ms-office365-filtering-correlation-id: 3996bc9a-e7d9-4c09-c16b-08df13fb271d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|38070700021|10067099003|4143699003;
x-microsoft-antispam-message-info: ZkuJ6s/uTSrKpgFlyVIZeuWuftmzqMHvb6Z5WhTgXG+9mQYbBjINxhz7N0DlG7Ql4P0QCJ/+qHrB8OLwpRzwwr8i6dxjxjgRi1EEJxtOEtNkPAcUaZvMXhy6FO++G3U8QVdEyrJhGNq0JhjrFXvpzPiU7HFvn2xdrxbKszGxxUWaRvxUVXWow1yg7iL4Qucf2om06ekLHyquQ1Dy41G+Qw+iJ/G7l06TGicuwdIGWse3bpTMgWLYDapWVb8hO5d9oBPBMxGf8Yq4sRmPV0XPbw1BiRK6Z4BSChbU4AGdWal+yFXPNNgzWYwO0yFal/5MnoJAOi/G+JOrdQ6nrZGpqUbqFhrXddsZWXeAoaSPd2F3rCjtEvft6Djr6Ty3zTPJSeF1GviDjhFqRbfaw/I/Evq080Zwc0TwgKK80jsKbzi/YYCHYU6dERAAJ+nig0Xcv3cnMmOlUxNtBurwLx+WhMh7x7b/53ovEeSTeGn3wIpAsIAtQqKarOTyFjLfxmKp1x/WiO1D54Y6TduvqmgwH3TI9gUtJ701Sd1St07XEXfJXbzFPLAspYJ+rSshEivFjvcGbFCwWN3a3/+fvnsvQRWNz7RCm0q/n4JEzdPhsLu6h05uwiByBZ65O6qDhvJUHbPa3tHjEa5coq5LcRM2MsEHnCrUgl/utedsjj0jDHhgy8S8n9Eg4lbLyo0nHUADwpOrDVO1JCmCS63dwCQieg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUI5SkMwWU1QRUpTZlJKWjNVMjNkTTRpZWlSbkNGcjBNdm1hTDBsYkZaRDBo?=
 =?utf-8?B?VC9MTjM4dXdPNGRuT01ReHR1S0gvK2RPR3VWOGpFT3UzWDRiMEVGWXp6QU01?=
 =?utf-8?B?bUpqeGNHTHdtZnJyaVBFWjJsNEQ0Q0lhRDcrRGNlNnhTelhHUkVYUkVEdzFJ?=
 =?utf-8?B?ZERlZmh5cUMrM1Y1bWZ5eEE4RXNicUk0dDV5a1FlNHd2bzVKcVp0WllUMUg5?=
 =?utf-8?B?NmdkNXlEampjQjJ0d3B3OGtWS0g4Vno2L0VZeTU3NmhvbmFYcVVnOERZM2g2?=
 =?utf-8?B?alpXNW0zT2JOZEpuTUV0WUVDWjRuWlJFblpjQlpvSURyZ2huRDVTSzAxYjU3?=
 =?utf-8?B?d3hQTlk4aGJXQmp3alhJV0FhVFRxdjdaRFdKbEhjME55Vmc5aDZYOXIzZUxh?=
 =?utf-8?B?V3I2dUxCMTA0eXoyN2xMZ21zSTdzV3oycmNHMmlDQjBlV0dydDd3eDNGRXhZ?=
 =?utf-8?B?ckRtemplVUR0WVZTMXhMNXY4THp2NW4ycWhIRVJrRDViWFd5c1YwQXRwVEJO?=
 =?utf-8?B?RUJIdURLVGxWa1FhL3JQcFBCM1FNU01kMDdDenUxSHFjWWE4Y0FYSWZENGZ1?=
 =?utf-8?B?bzJ4RDN3MlFyaXhlTnF2bTdCL08vQ1oveTRhZDBvck5GQ00vRW5iZnFIMGxL?=
 =?utf-8?B?RHVHc1FyNFpLU0xKb2RSMm1lcmd5RVhBUzZzWW5NS1BEV0dDYWdTWDZKRlZx?=
 =?utf-8?B?ZWE1MGh5VGtCQlNySjFjWGdZV1JKbTFMSThCRkNoYjVXNVhBSFBBdHdpd1dT?=
 =?utf-8?B?cDE4d2YyVTRqSDVibnRQQllWS2drMWtsdVR4QkQxTENKUE5VKytlbDJOYTB6?=
 =?utf-8?B?Ny9vZWZHd3BFZGZ5UHNFSU1ITmlaTlVoNTRONWRkV0x3cmhBc2JycDcwR2JY?=
 =?utf-8?B?STBXNGE2dkdDSVBTWWZXajRTYUp6bXBacGRDUWd2TEZHQ0tCSUlXSzdPTGtU?=
 =?utf-8?B?Nit3T1VmTkZQRkEyWFgrNnVoeHVtS1A0V3ZBT0NYMWltREQ0dUZ6WTRTQU13?=
 =?utf-8?B?V2JlVC9Ud24rQUxjczBTZmdjZ2NsZ2ZmSDQrdkdVM21Nc3I3S2d1TEt6VW9v?=
 =?utf-8?B?Y0pvY2VrSkNsbzlycmhSa0gydnFKVUxKMFl6NkczRkNpRXUzMDhpdHo2Zjhw?=
 =?utf-8?B?M0RjencrNmR0amJTUEEzdVI2b3l6M2lWUmo3NGFEOTFxZlpDckUrQVZ1cFZX?=
 =?utf-8?B?b0pLdG1Ia1pyVjFRZXpWNWxYSlAwVVR0T1l6OHJWK0JRVnRSdE8yODlhNlox?=
 =?utf-8?B?UEpMNzc0OUtRU0FxVGUzcDZCbHpnb0NLcTNPakZseUlKaDdzNFpkZGRWV2FN?=
 =?utf-8?B?SXZlUEt1WjNqZEl5TEFlb3FWSEpDQnR1ZitHZTlTOW1ha1ZMM2l4bXd1S29w?=
 =?utf-8?B?TlJHMmVqZkJ2bDlOakdHN1pWdnlwUkJCVk5WbXQzTFZMbHRBNWFEY1lnb2hP?=
 =?utf-8?B?VFJrcWNLVXJaSFBObnZ6YzdoVUJmYWFQcFhzRERMc05DU3lVanZGTFgvRTVB?=
 =?utf-8?B?eWZaZVRCQ252K21PUTdDZ0RjYXQreHdzUFY3blI0QVJGbnUrWGpBQSszaHB4?=
 =?utf-8?B?bGU1V0V2dVRtanR5Z0N5OXgvQUtTY1pvb3NXUVNEai9WMHdtcnhjUXRldncy?=
 =?utf-8?B?TDVjVlpabXBLTTE1WW9XTE5XZXBOeDYzY3lXdVg3NVdvcHBLNFRncmEzSnI3?=
 =?utf-8?B?c2RkVFNLSU9SRVkzNXk5YWN2d3Bhc0lwSHZRS2dDK2krVHdEWHBsNzQvZit6?=
 =?utf-8?B?U3ZCYlRXazdobWRzeFE0dmRBUTFIclVzRDY4WnF3WmdlMmZ2TXE1STZqdHpP?=
 =?utf-8?B?RzF6ZDhiYW1aenBMcGQ5RkJGTHVBc3p4d3BpWWJobWVMdmNTYUllNjA4Lzg0?=
 =?utf-8?B?ZWQ5anltK3I3ZHFwelR2Z0dBNXlZRmV0WUV5RUN0YjhpZ2ZCVHFWRkwzVVRK?=
 =?utf-8?B?TW1Ed1R5UWtlMU9wMk9sM0lkNnBtNFl0MW50Mlh5Zmorb1RsVFZKNU5xK09H?=
 =?utf-8?B?dmdoNG9yK1FPdG1YL3RGY3NJTXduanhsUU4vWThQZE5YdVo4YWM1dkx6Si9G?=
 =?utf-8?B?WW9jaWFoOU1xcHF4bXdCRm1pbjVEdkNkVXZLUU5ORDRhZkhvUDl1ZnhmNU1r?=
 =?utf-8?B?a3B3djdtSVdwekt0b0FvRGdsN2hCSzh5VWJJb2cwUnNFTVlKYVQxYjRUOXBV?=
 =?utf-8?B?RHpsSS8yVlp5bUk2Z1ZiNm5JZHRTbHBtSkduSUdqNUtHUnhhdmpxOWRpQnkv?=
 =?utf-8?B?NHQ3TlFoblBWNlgzMS9jb3B6aVVQa3pNT3RvTlhLRmZlWkVibUI0aFNMNXQ5?=
 =?utf-8?Q?jsvF9jMubZLUJmxiWR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <667AFFC89EDCD047BE8DBFAEDF2384CB@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CaXanfVSRX7c11kGG23HgG9oRDMFrh1qRytO9uA91QyN6Eag8R4FvJS5rZn+yA03U9qjBs6sazMgsa5/pHwHRpuNbwaI4H7mMwOwJuHWnVDJbalul4g/sZRyW5aHwnNhnhUFWo1PR+SZTRy41etUk06fLRUyScTMeF70r0p/v9uJLKVTdIH/aKYUcDeE7VXwiIiQh7Tto0qYlegU5ZShn9xjqVrNW0npJSVhcDuPPZlTI4lk+k66pw7Vl4QF48GCkQdR2J36tpr05sFzpW8mWdWgdWqKzrb3KR/J/fG4uLbEGNTI+JA5rV9LffoDyEebG7rS7qH7qQZhNjAfnTFLCg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR6P281MB5787.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3996bc9a-e7d9-4c09-c16b-08df13fb271d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:02:32.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PmXecGYtg38jqKtfswQ2SyjIN061BhWIhWHT4OZbSpLaMRtxnKYKMG5OXndZooi4Oj9Gp0Xk/jkPMiXxl38Rrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRSP281MB5841
X-OriginatorOrg: amazon.de

T24gMjAyNi0wOS0xNiAxMjo1MSwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToNCj4gW1Nl
dmVyaXR5OiBIaWdoXQ0KPiBEb2VzIHJldHVybmluZyBhIHBlcm1hbmVudCAtRUlOVkFMIGVycm9y
IGhlcmUgY2F1c2UgYW4gb3Bwb3J0dW5pc3RpYyByZXRyeSBzdG9ybQ0KPiBpbiBLVk0/DQo+IA0K
PiBJZiBhIEtWTSBndWVzdCBwcm9ncmFtcyBhIExhcmdlIEluY3JlbWVudCBwZXIgQ3ljbGUgKExJ
UEMpIGV2ZW50IGJ5IHdyaXRpbmcNCj4gQU1EX01FUkdFX0VWRU5UIHRvIGFuIG9kZCB2UE1DLCBL
Vk0gaW50ZXJjZXB0cyB0aGlzIGFuZCBhdHRlbXB0cyB0byBjcmVhdGUgYQ0KPiByYXcgaG9zdCBw
ZXJmIGV2ZW50LiAgV2hlbiB0aGlzIGZhaWxzIHdpdGggLUVJTlZBTCwgS1ZNJ3MgcmVwcm9ncmFt
X2NvdW50ZXIoKQ0KPiBwcm9wYWdhdGVzIHRoZSBlcnJvciB0byBrdm1fcG11X2hhbmRsZV9ldmVu
dCgpOg0KPiANCj4gYXJjaC94ODYva3ZtL3BtdS5jOmt2bV9wbXVfaGFuZGxlX2V2ZW50KCkgew0K
PiAgICAgLi4uDQo+ICAgICAgICAgICAgICAgICBpZiAocmVwcm9ncmFtX2NvdW50ZXIocG1jKSkN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgc2V0X2JpdChwbWMtPmlkeCwgcG11LT5yZXByb2dy
YW1fcG1pKTsNCj4gICAgIC4uLg0KPiB9DQo+IA0KPiBCZWNhdXNlIEtWTSB0cmVhdHMgYWxsIGZh
aWx1cmVzIGFzIHRyYW5zaWVudCBhbmQgdW5jb25kaXRpb25hbGx5IHJlLWFkZHMgdGhlDQo+IGZh
aWxpbmcgY291bnRlciB0byBwbXUtPnJlcHJvZ3JhbV9wbWksIG9uIGV2ZXJ5IHN1YnNlcXVlbnQg
UE1VIHJlZnJlc2ggS1ZNDQo+IHdpbGwgcmVwZWF0ZWRseSByZXRyeSB0aGUgZmFpbGVkIGNvdW50
ZXIuDQo+IA0KPiBDb3VsZCB0aGlzIGNyZWF0ZSBhIHBlcm1hbmVudCByZXRyeSBzdG9ybSB0aGF0
IGRlZ3JhZGVzIFZNIHBlcmZvcm1hbmNlIGFuZA0KPiB3YXN0ZXMgaG9zdCBDUFUgY3ljbGVzPw0K
PiANCg0KVGhlcmUgaW5zJ3QgYW55IHN1YnN0YW50aWFsIGxvYWQgZ2VuZXJhdGVkLCB3ZSBzaG9y
dCBjaXJjdWl0IGhlcmUgYmVmb3JlDQp0aGUgZXhwZXNuaXZlIHBhcnRzLiBIb3dldmVyLCBhIGZv
bGxvd3VwIGluIEtWTSBjb3VsZCBiZSBiZW5lZmljaWFsIHRvDQpyZWplY3QgdGhpcyBjYXNlIG91
dHJpZ2h0Lg0KDQpJJ2xsIHdhaXQgZm9yIG9waW5pb25z
