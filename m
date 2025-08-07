Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010021.outbound.protection.outlook.com [52.103.33.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76C205AA1;
	Thu,  7 Aug 2025 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544251; cv=fail; b=obbKM8lshWQiVb7r+ROqzcSTWfnBpNAii/Ug0ijUARmXxZT6E4n7Z0f6LcdKAxzHlFGUD0hu4phMCDoWexrayWivtX3R260t/tb8bt0oGuV/1XVoVQ1jj1cDaOMfXrRI/THwJnjSvG5AcldWM0P3dWekcipsEowes84Msodakho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544251; c=relaxed/simple;
	bh=ZxVCJ+CsN+zMssWfoyVbyHuwwqcgRlgaVxSNjtKPowc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CnP8V8tCTNZ2u+HPMo6tjQRpnrTJQ/Zx6FdmrzFB6auSX4ScGArOlwppEY/jgVNSSeASrnNgnRqAs6veKwtUj18ReDBWWYi6Ye4hqX8vCcvRh1sF0Uf5tFgwiFMT0tpu6Z6Jahby1eiAuyPwODxAHSap7wjsg40si0KFbJ4YvBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DRLOPAk6; arc=fail smtp.client-ip=52.103.33.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DRLOPAk6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS9Jfiu964rnivoDs3F19+opHjUgw4mR5vktSpUKBSgMeGg+MEF3NH/dnxBz6AXXOR5XYbTntiUwz6m3wpFCe6O74dPD3L4kJR1p5dMrH5vY3DZG8LeV9rAHE3fK4E+IGbt0MdvUg2YsVaa5rPVX1BqQa8t4OMDmUquotxNqbU1gLsz0KnExHNpATJsSjP/WWuN7SMDyf9gxdu7Q8ST69Uenh2sWEocLzaO6AZG71Hg+XsGjz3Ynix+SbmMuA9Xlvy287sUPhZlGkwpIfdoIqOP4AnJwEq6LoFTovP1WbRjjnXqtLotXAYZwNSQ67Tlmenq3ObvSSWd27jIaaOROsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxVCJ+CsN+zMssWfoyVbyHuwwqcgRlgaVxSNjtKPowc=;
 b=x7uTdCA8wR1LOC38Py705yAozkWV6ufvY3LqUZbHHEGGm3Cm2qRTY4Q53vtBLsQNwbCaAJYRaDGj3fxklv/HYdH/Fd3F1MeG0Yy8jkGrTRD9hHxo1qHyktcvhw8ecmb/mxj8ReDuP7gNllJ8mBDWI0EQM4rhd0EkXCg14bgaDBbtva951nzylKEE0leZ0rhZVCcSx3fCLtrKhX5nCXqhZWVzSGzNWr95PhG1DiGOCuo4KeakmkPiy9mauaPNf8iP2usKZB3gqiDdal4RIVJHjxJ3M2IJlH8k8h19H2bZaLVz95EdaqhcwYR3jqJ4rpmd2yXM/hT0v5d5JZfjBNXyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxVCJ+CsN+zMssWfoyVbyHuwwqcgRlgaVxSNjtKPowc=;
 b=DRLOPAk6DrCAjtIT1xwxR1YY3QhtawN1ApaeV7pi/CnuFn2sRhu/wXuxW6waU7M+Q3KLz25M+eiB3QKNlQVv8cuGwtFQvTrE9jMmIH0uS2QVfOFM7EI03zZAu81HSVkCYcKK9JEYh3nif1QAmyRJu+WcVTvMcbkhBZF1nMCvd6WsZ0IM6TZS/SfL7XLTEQH97tub6KX8lNPimsT6H1FX3ZJe9yE9rFcSJAohR3EPsRecBdOZ/lXZBXHhVV11Y7CHz1xDFUTVtW6D426SzZyFC4NVkxPU3BtCD93rRmyVsTl9RCzgAUtQOKFkkwikOWnBa8IvWfLGFuJZjNSQ6Cr79g==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by AS4PR02MB7951.eurprd02.prod.outlook.com
 (2603:10a6:20b:4b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 05:24:07 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::5556:4de5:6245:a3c%7]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:24:07 +0000
From: David Binderman <dcb314@hotmail.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: Re: linux-6.16/tools/perf/util/tool_pmu.c:242: Pointless test ?
Thread-Topic: linux-6.16/tools/perf/util/tool_pmu.c:242: Pointless test ?
Thread-Index: AQHcBpg9E5AKwgPdK0agL0hVJ+bmArRWQeWAgABnTN8=
Date: Thu, 7 Aug 2025 05:24:06 +0000
Message-ID:
 <AS8PR02MB10217C6C1A3F8E3448C144F389C2CA@AS8PR02MB10217.eurprd02.prod.outlook.com>
References:
 <AS8PR02MB10217286997CFA78F802121F39C2DA@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <aJPhTRz8B8jIjjov@google.com>
In-Reply-To: <aJPhTRz8B8jIjjov@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|AS4PR02MB7951:EE_
x-ms-office365-filtering-correlation-id: 8a71c550-9cc2-4a2b-d63d-08ddd572a18f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|31061999003|15030799006|15080799012|461199028|3412199025|40105399003|51005399003|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?lbX+Px1DBSvr6iScCL6fJhGvNWXHdRl72rGpEtBb2VioQgn0z2X1Bxs/ug?=
 =?iso-8859-1?Q?9pm0+vAMAEvZTMxsALDmSg6AmePV8unNlpuLwTHJFZYPRdfdse0xKBUZ91?=
 =?iso-8859-1?Q?isaWNS/n3O9JwGfjCfiZAzl3Bkqzebr1F/EkEU2M21deu/xp0iGDSAotAy?=
 =?iso-8859-1?Q?Msdpw+IKtaXFc9Xj6uGvgcogQL0OWDEQ16zTRU0eYmWfZYvkieYM7efRNQ?=
 =?iso-8859-1?Q?4TKSeeTG0zSjyj/7JJHZ8ow2VY6VTVeAvnBlapTU/A3T5aUf0VxeMTkPn8?=
 =?iso-8859-1?Q?KpTncbNmchY5Sr1cBucvlk5pmNVwkY8M2HFAk58XUmbpg0neR1cSwZwDys?=
 =?iso-8859-1?Q?07Jzk2NJN9//RHHfltKB3mApkQDxwbY5c8kcG6yWS6RvTFUr/ecFt5JMcp?=
 =?iso-8859-1?Q?yUNXqeL95cV0BrymlR1VFYZJxLdpgI56FU6upGoByfqn/+rmnjE3tv5Z4W?=
 =?iso-8859-1?Q?kD8YXX9OnL4fTX9Gjia6u3ddbCgFt7+XeDWcAHOmwpTiXersHU6hR6GUWj?=
 =?iso-8859-1?Q?Hqjpe5aiw4542ggH1HGp4j8nlcCuPGFIUI9cKl8oGmhu5Gb6h+OLogNo1E?=
 =?iso-8859-1?Q?KnY1J1DSRb6BLSjIoFCdErE/YiKNJ4LFd5tlMr6AiIH1Zuzt4jZ3XeWo41?=
 =?iso-8859-1?Q?6/Mycf+JsKWLfJS66dlqdSouYpiZBTjxLBG12hKsAoPrfCT5r3AzdUM71I?=
 =?iso-8859-1?Q?zgnEo3CMr7TR6PNjfqnOwD2K0VyW4pC1XE0Idn6bGlBDa/fK3JE8m7cYA2?=
 =?iso-8859-1?Q?+/lGVRAVp4ytdb5nNpGCZbccgw8p7NwCUI5/EuyauX5ndDIxTaF7RIrto/?=
 =?iso-8859-1?Q?QCzK5ycNNUp9cp/RMl/uGPTNE3ahYCDBNiC0IWPDXT3m2QMQWnCOBFHLvA?=
 =?iso-8859-1?Q?B2IEqpXCLAkAoDdstzi7QyD92fTU36ck98hfvAU1Vo+QnuoOVrokUwsxJh?=
 =?iso-8859-1?Q?e7MMng934nlVMuVsDbuELmEs+QqOkSa8jVk1H9WhwlM4lAbv0wlFgNN1nz?=
 =?iso-8859-1?Q?1dpqLenL/Kjgmya6t2Sh5RM9+jX5VWJCzNqigVQQsmpJTffHBwyj5bPL5u?=
 =?iso-8859-1?Q?ufuwoHxB1rQPkCEvu8fhu2hpGH5cLu1A8zQHyOKHT5Lf1Y0czA+eOM/ecJ?=
 =?iso-8859-1?Q?m+XbkBybLi3boKfbcfuRfzubpofts/h3wBLpHXh4VZDnxnWrxNSahqb5RJ?=
 =?iso-8859-1?Q?YpbPGaPYtnwT9cfcgwdylbWDh77tYcqmW3w3bSCgaAPtrXAjo/lHFLvKhX?=
 =?iso-8859-1?Q?duYZbgs5xjpzw7NiPhCg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?nQsBGv133Mj05lA2mlnfQNMgQBuAewbdikNk6fXwIXxiX/DcbeaQ7Br6ob?=
 =?iso-8859-1?Q?L4jwwFrW1O5tcvYwRq6ODY7rraA7hO69NN+lVvIeQDuDVE2aq9zSxEIMkt?=
 =?iso-8859-1?Q?svvpkYQ9uW4Bx3QWDyaxkfuY9NwUnNHZq2wyDSN/+Wv78qMNBMVcA7aK8a?=
 =?iso-8859-1?Q?RAB5gIjYFD6ktA9MzTM9rQV8JellROgvNTBi2TF4fcquOrrNnVvRGfa32+?=
 =?iso-8859-1?Q?h925xj8EfHDwkFWPGtOZSPYx3RYYyxcPMFw+4N9WwN4M6yNifS17H5UnVJ?=
 =?iso-8859-1?Q?eaIh52SA1BCQ653dI+210zm/B/8TzztFLouWDe25WDDkk3XkID29bL9KeZ?=
 =?iso-8859-1?Q?EeFpxbBm3c5fmj7KBiFr6yxmSzD4v0Fs+mukbM0p7z2bHAdRU57YIN5ObB?=
 =?iso-8859-1?Q?/cg/SgQjOZslqHj9qKgKvKaEE33Ps5ukcovCM/Bb4K80qDiZywSB3VDaeF?=
 =?iso-8859-1?Q?GstiyQdZulnZZYdjePMuRX8MOcWubNc99Qwkpsbwbf1JN0QrSuHAdcFHE9?=
 =?iso-8859-1?Q?UBVCYsrYTF9dZ/tFx1PMcWMi9Fx1dPTgsJP96pbkYQ1CPrcmM1BO8j9VV8?=
 =?iso-8859-1?Q?7AHm6ZF+wNIZPDm9APELYgALp/9NefYQmpXtCXm8c2raGIg4GubwKUxdXE?=
 =?iso-8859-1?Q?0LIMxN01h8aW2WbA5MHa/CXKYztfur6QZMsjwVeatAdsqtT6+N9joY5bBq?=
 =?iso-8859-1?Q?Ve6D/+A6t3l0+4j3GxBn7Yirlnp1BA1x4pFZ0ItrPshK670SbkQViX+98c?=
 =?iso-8859-1?Q?B7RV25MnpTsWkTYkUEbuds6atHAZyxp2G8MkR4fFBsQafThxqexus8FQWB?=
 =?iso-8859-1?Q?uGz5tYMOpQwMX7ethAupU/eZzYGWapqfLKEk0Npe3B4uEkvopEvAaooxPe?=
 =?iso-8859-1?Q?rmQlFRQ6eEbl2Y6zjsZ8HNK/KS4nPgwpBPGonntOvhj9xotmoFqXyC4pQH?=
 =?iso-8859-1?Q?4zyFJYoajw9CEhEXZ4AhAS+f1iF4ZxTHnFIDRFXcYH6FxF6jPVV4mMRbmw?=
 =?iso-8859-1?Q?fyPZNk67JW2LrqxH1I3Xwh84US5mduwKeBHj7PXWo9dDJY715RydP3QD11?=
 =?iso-8859-1?Q?HyDhro4S3l9mfXcxU1yBVaQQA/9RkQZsfGJxclDbz7NDVakoPd8d7W/eVt?=
 =?iso-8859-1?Q?HOArNps6YVEI/xN+gE21C+PSt4/+eLxyvl9mzyoTK7bea1qYsQDbED85+o?=
 =?iso-8859-1?Q?Ke2CQ0QzAJdXtCc7vxjL1QYJalMQIJXbc07SqKAwosMdR3EU95cnYLu7wj?=
 =?iso-8859-1?Q?kIzKrQpW5XI5Xjsoozlg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a71c550-9cc2-4a2b-d63d-08ddd572a18f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 05:24:06.9668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB7951

Hello there,=0A=
=0A=
>Thanks for the report.=A0 =0A=
=0A=
You are welcome.=0A=
=0A=
>Do you want us to remove or will you send a patch?=A0=0A=
=0A=
All my patches fail, so option 1, please.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
