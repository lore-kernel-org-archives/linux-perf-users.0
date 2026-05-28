Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26C351C02;
	Thu, 28 May 2026 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954312; cv=fail; b=CHrNaenJHsDkha2SUSOA3G6jxlprfsbkeTuGj5eRIWAgYkqQ3uwz4zrXNMF5XD4UZlowZ2XK933C0GXcqJPjpRjHhRjFn0nk+bC98n5kLD096i6vAPh7Chi46kASrrLeVhvAenmu96fhdqumaqIwwXGPTcjyRvxmm5hLQBpjSEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954312; c=relaxed/simple;
	bh=ahxvemGiswGQ+OQf4osF5mkZ3pxnsrPAWWdEXNWJtyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNDkklcKON8ftOABHbXtugGfVsZlto3ZcthQWcIcvhDar2SqfNjnUcbY5NFrPpUCB4/JjGZblOCeIH/5sWqehU2y5szvgcJ5dUs6Nx3hjxQrMFKvuTKAqj6sK/IaQeicnEz1PrDc4GoGDNN/PcH7gxLJ8sX192eJ4euXgGx1sZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZVJN11Wt; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZVJN11Wt"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKiGkI2434602;
	Thu, 28 May 2026 00:45:07 -0700
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021113.outbound.protection.outlook.com [52.101.57.113])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ee7wp9dpk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 00:45:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRtv91bR/iIFS2i0AeeHFdWqS9Gy1rkhbs71x+262tiXiSxYfc/jyoUOJ6fqguxVGqSP1TJ2K7BxPG2DXqo1mz18K3dj5hDrE1wDUsV/9iQOu8L+gYL6B3yTMdDFx5dQkRa188QGflyM/3TEYjh/xPmqYa2P/qaHyPfYCUoQYPugI0lNWDu63Q8uQrsPDKxGVwX838OjdKNbrqYlgdbDS5HwMwDOOQteql50LKLtZlTygizw6+eZzTkDOX/U2fTTtFfL5NZ9iV0c4kblGHdNjxGth4nZsvERpLxA/TEQFqXddSVefW/pMkcHEG+5Dn3ZBhfjroO/o1STxIfw20Qs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahxvemGiswGQ+OQf4osF5mkZ3pxnsrPAWWdEXNWJtyM=;
 b=M4Xv+bPLZl4DPAHxJ/u29Ck2vmIk6g9pCFyJJZpr7DDfW4tijNP0Gg/wJu2UidNblPAlcuKBm8ZeqQCanuNynM9wwM3u8CWNHel3uT9Prot9JL7BmySmi+iyDz7/m3QUIYEFbOUmMw8iQmhWTTFMoidCJhxW9fHiMj5bLXbsV6na+A99GlszHWb/xUqw1+pIBApk+50YU+xwVLzmkvfIBYlh352fY2zmmpf3UiTP7MOC5Iuy5b92xOQ2fC27j4WJpFRo1NW6ewEvH3t+WWUgLF2AexYFzYBUp5zeGIu8gtW91yX8Oqz8hAjiz4sBnLbLmlsmVfhHKLTBPT+AawWuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahxvemGiswGQ+OQf4osF5mkZ3pxnsrPAWWdEXNWJtyM=;
 b=ZVJN11WtQWAwzeE4LCAAdSMKSSlotalZ/u1kqLnB9f5DJSWEerCobbgWXGFt1Au9fWZ3MBNWlgR4n7lRsDRZ+Nl3WcII0ussWT2BFwVmrMtk02HTghY9yL84f+jL42fmXXmEn27ezLbqD2NdMNvEG9tsFVcgTh79aanTeHWj/gA=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by PH3PPF1A380B41B.namprd18.prod.outlook.com (2603:10b6:518:1::c88) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.30; Thu, 28 May
 2026 07:45:03 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%2]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:45:03 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v7 2/2] perf: marvell: Add CN20K DDR PMU
 support
Thread-Topic: [EXTERNAL] Re: [PATCH v7 2/2] perf: marvell: Add CN20K DDR PMU
 support
Thread-Index: AQHc7flf7I1gq7b+GUq9hqPp4IDM5rYjDsGQ
Date: Thu, 28 May 2026 07:45:03 +0000
Message-ID:
 <CH0PR18MB4339DAD9123F7D2D8426607FCD092@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260527154118.12884-3-gakula@marvell.com>
 <20260527165333.B50F11F000E9@smtp.kernel.org>
In-Reply-To: <20260527165333.B50F11F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|PH3PPF1A380B41B:EE_
x-ms-office365-filtering-correlation-id: 0159ff17-1dd5-428c-4025-08debc8d0778
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|4133799003|22082099003|18002099003|4143699003|6133799003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 sNfm5TuFqEp4y7sSitff32aLp5Z1Gydd5xV6R5wLDZUp7hOX1fMW8xSboaUJnrbKe73GQ28uxqJKdiemA32BHlDLMQ1Z7VCIMxEBnhgb0LvS5Gb0gA9qbstS3AW43HdP+BMGlyNQ+wnR+fGu2ZCSOCpTTi5Zb55A1heJq3zvbavkaLlgxdonEGWFZga9ttzDgjTkHjkasDwP5rEJ7J25hD15fYtfz6u/Ht8N/gtEzRKd2YDSyXmug27cXyowsF7NEteXcAIxxN3s6onh6GEG5g1U8mppUCZ7tQ+gT4vCPVUcy5Po8NZiywKZjZ+ZgoineGzeu0zIgJAoHpiqOY5soUSl788wJGcbvMJ0P/QDMldLjbcFRyqFGCqIaYxhGsY8qLoab5WxmX/BCEqLf8zns5gQq0+ui6dkg4e7mKUuC+7K6UVvuBHyNHFme6bj2SfB0M3NlyLmUDZBPifKwV/zoZpvdz9jkhrR32VUupRFwo1WYVpWcgMMFTMstDiAN3FcjfTXGA9y72/LslZGM/A5vapeYs/2uA6TJaHCqo2TgQsdASZN/28loRVoVjXejmPK8qauwRijapaLe6kyRTs24JnfisurW6koGGIw9E+zSZYTgHB3tt9JA7b71e0TA8s8UMUFJStCSXAM2Q8nD6wOTl1I2yc9rA/1/dS7AswXn2HgRpmjuk9U/ftfCHD8EyFi3R5jFBRSd3Bs/CzIk9+H0w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(4133799003)(22082099003)(18002099003)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTErWmdGb0oxd0xMeUwvUWNiYWxTd3NxcHVFTC9temkzZkg5bDRJQzJQbklG?=
 =?utf-8?B?Nk1zZ2crUzJJM0p2N1MzQ1huMmZBaHlEUHFuRDMyWXRkd0xKampGdlF3SmpB?=
 =?utf-8?B?Z0dCTGxjUWFFVG01d2NVZzVIUGNNK0dhUkNBSC9hMjlodzU5d0dFUTdOVnBj?=
 =?utf-8?B?ZVJlWG5VcVFEWlhud2NCV1Z6VGJRYXBmbUNITmRaVE1LQ2FrMktSdWdseXRK?=
 =?utf-8?B?TlN0ejB2bHpNZlg4Sjg1d293V2N4N1JmMUFmRzJteWltYi9MTVQ2K0ZQUW9W?=
 =?utf-8?B?VW85MnJLUEg2dzFWdVZhcWg0cWN1QUIwOWlQbHhJVWxYYmpmWUJrOWRjUFQz?=
 =?utf-8?B?aTNvMnBscytBMXNUVFYzd2pTNk15ZDhkN2V4STdCTTk3TUJZV2ZUaWpVRi9y?=
 =?utf-8?B?MGdTcmVxVGQxRFZFejBnZ3FFRTZTYi9uWHVLMEYwU2RqZ0ZTN0wvbk5scHBu?=
 =?utf-8?B?V1Y3ZUsyUnBoS0t3VXdrc1RwVHhvY20yVU9zOUhRajJrS1BNUlpQcXUvL05s?=
 =?utf-8?B?dmRWaFZkZkZWejV3aVcxeHFHZHROS0ZVaXliRjJSalptRVlDRUcrdEZYVEpM?=
 =?utf-8?B?bjN0S28zUkFFekltTmVRNm02NGJsTW9mTEFvNlZXR0R2OWwyU2pDdnhDUERX?=
 =?utf-8?B?NmV5dnYwUExtYlAwWmZOcElJU25GVXJ6bTgwMW93Z014bmtPUGtQeU1uZ1FS?=
 =?utf-8?B?MDQ2UnY3MTRERXZUOGZ4eG5Od3MzUnZwb09iV2xqcHM2QzRrUEtvdzhSRTBF?=
 =?utf-8?B?clNId1VCd2Z6cjRuUnFDTHQ3U0orSUhJdWlOQmU0WXRxa1BjQWxjbkoxa0NQ?=
 =?utf-8?B?SjFNNnZmNlcxSGlPbnVXWndLSkRYSHRuM1NuTEdWZ1RFYkhjMkZpYWxBbTlF?=
 =?utf-8?B?ZU1obENncEg2YzVCaWU0bUhYalQ1Q3VKRFFGRTRDVENkeG1scXIzZXkzZDR1?=
 =?utf-8?B?aWpTRXpJNzIrTEMvbzkxb2ZmMzFqVDJGZW0zdE5zemYvdjZPNExBWW9Gc1dt?=
 =?utf-8?B?V0Nrd2NDdGh5SkVLVmZWd2VyUGpNYW5OK0tNcy9lRk5MMXM2b2FqNGJBNldH?=
 =?utf-8?B?SzZpMzJqK094UWJJL3NvNytiRE4wM2JJVmt5TjNFa1l5Z2FFUmdtRmdqWjY3?=
 =?utf-8?B?eW5LWjNjbjhndkRpTEo1bFptcHdYUFYzM3FseXc5Zm9jQ2xCVWt3SVNTbVIw?=
 =?utf-8?B?b0VJTDE0a2MwUElJQkRTOXppTlk2NUhmR1RYS3h3SWx6STlJMDBWZ1QzUUZG?=
 =?utf-8?B?THhKZ3lFSld6cGw3T0VIOU9TOU5XWk5oZWtzRDFFQVJCdUJoaEkwbzN3cWQ4?=
 =?utf-8?B?ZGpTejVNeUplQXYvbktTS1dkMm9mbGZVN1Qza0EvajRUdUJtNW5Gakg2K1VS?=
 =?utf-8?B?bXR2eXFwTko3SFFvbFVKY0dtdExEL3NJOVZQQkRTVVBhak9QVkY1U25wQ1Yy?=
 =?utf-8?B?dkQ0U1o2aE5wRGpkcCsyQzljMVRSMXVTRUpDVXBDdnpZKzdCUzVKSmxWbkYw?=
 =?utf-8?B?MFBJVG9WRDl4QnVGaGJTaWE0K0piZk5OejlCSGt5SlZ5TFZxQnlubXNWcllo?=
 =?utf-8?B?UTFxK2N4ZTM1N3g5ZTAyYlh6amQ1bjJEU2RWdjVSZ2tlam9MQUp5OGlNZWhB?=
 =?utf-8?B?UEE4U0FBRC9uY2hmSithWHBrdVp0VGpGUG5NMWdsOWZwbGUrV3A2NnI1TVdD?=
 =?utf-8?B?N3kwcHRCVXpvYjJISTJTQTZTM0dXRVlFcGFGQk43V1pSYkw2L3dhSmREOU1M?=
 =?utf-8?B?Yk9MR0dnTHRKUExhSm5hZGU5Y0liOWNFUzVZb3RBWWNyT0V4QjZWOTUxUjRO?=
 =?utf-8?B?SFgxNEFxcW5HcjBtdkhaQVNkRVZhNUJ0Tlc1THp2K01VVVNwV0tQemhUMTJp?=
 =?utf-8?B?UjlNTjgySWM5NENZZkJYZFZhSDdIa3dZeWZlNFFqNmd3ZkFza1RYYUwveHgv?=
 =?utf-8?B?RVRpY0dML0dpc0VKTDJlVjhyeHNWcUxOWkxkUklkWkI4MEVnUUo3R0JKUWVB?=
 =?utf-8?B?S1dEdThwcC92cmhNblBlZWxyZFpMbDdUcmVkZGZZcGd1ci9ObnM5TjRaVFRp?=
 =?utf-8?B?R0hWNmpSbjAzTDZyUUw1VDBla2N2V3pCQ3krUmJLZTBGSUx0M3pESDdLTjln?=
 =?utf-8?B?eFVmMGtNZi9RV3hTc3A2Q09ZM3ZQc2kzNWpyZmZmVlI1N1BRYTl1eVFSNGNQ?=
 =?utf-8?B?dElZYUxjK1hBaHVReUhON3RoaU1pSUUvQTJyNGFRMDVrRkgwSnpRYWoxQ0RQ?=
 =?utf-8?B?aFh1NDlzdUJGMmYrYUZscnJrUzVRWmVLa0R2Y2xHcGtiRjBPRnMxNExsRUY1?=
 =?utf-8?Q?inZBCUleo5KaVlKtbs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	X1qkRJGWPLa2OBROpVhB5+wofIM50s/BipoqI0iLVZGCaOnWWgK2zSbeKs48ZPc8bzK0kMP34KBotKuiBjqz11wEBa2+LfrwyEC+13iPoYk3PTbtWKQe1ptaleOFCHH1T33kBhZSdgY/c7s+MapckHGf2uxUy/bzh8wa7yHf2spHb/zIIcvpO93b+uMjVt3IP022u2L8bCbf3SalzG5NVgaILu8wwhlB8lggVPAtc/CZMI+H2e0KjXTVTR0+N/c9Pr923qZIJQaX9K8O4TuNOLwjCTPckhq9h7Dkvd3yJv43Xc6+tyN2N0tXWhqRdSAMXjs5m9+qo9BnuvqIQ94ujw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0159ff17-1dd5-428c-4025-08debc8d0778
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 07:45:03.4561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8U6xqcXjFePZUHCUUlavbGE83Zr3s+uDa9jM5zdR4L+MoXzvvos7bUi0LsBQTL26NCNIRxLjrzoDQpIcGItug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1A380B41B
X-Authority-Analysis: v=2.4 cv=Ls2iDHdc c=1 sm=1 tr=0 ts=6a17f283 cx=c_pps
 a=I4gKhz1MVFc1Ib3WWZpdnQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=Aw-ByWYbLbQAwAUndqIA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA3NiBTYWx0ZWRfXwEqZd9ijWYjg
 AhuUF28gpkSDiSOgv+WbZVnuyyES7giqgFHvfpVG98rSdgAd+dOs2U5+0YU6gKJvfkioCAr/p3+
 NgR/1i8BUX9WmVlvulhAZ1RYSLJbqQWyKzk/qVjdFtJrwq0scU+w5rfINwoUn/sr5sFOPTHZF9y
 HoNU3Kzd5t7/3g/BXRM2Yuk2hiwywzmAQWWSZ98SVJu/a/FuQBHAulRgJkAmIeLsyJZu6CJNMbP
 Y4xvsUR2A2mmQSV52iQ+SVSLz+L8B1y4Cr3qz1qKoi6OJ5mgboCLA1yeExckjaR3lXHE4QhW6E7
 P/2XUMA3el82tonUzLMq+ah2hWAJObBKtPlrjGgINk595IiMX19RA91PJ7r7gT7S2aESuPFt+47
 K3w/URcNHZDPY4VU43Lxbas0TqUB9r2FSPituYfUUvRcLuoCpUpL9quc2jRMR7OEBVOP+kI4qWZ
 Jqf9Hho+KXHB2ilTuBA==
X-Proofpoint-GUID: ERTwHrdpjCV2zl2blL9YHh2C5164rcL1
X-Proofpoint-ORIG-GUID: ERTwHrdpjCV2zl2blL9YHh2C5164rcL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IHNhc2hpa28tYm90QGtlcm5l
bC5vcmcgPHNhc2hpa28tYm90QGtlcm5lbC5vcmc+DQo+U2VudDogV2VkbmVzZGF5LCBNYXkgMjcs
IDIwMjYgMTA6MjQgUE0NCj5UbzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxs
LmNvbT4NCj5DYzogY29ub3IrZHRAa2VybmVsLm9yZzsgbGludXgtcGVyZi11c2Vyc0B2Z2VyLmtl
cm5lbC5vcmc7DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZw0K
PlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2NyAyLzJdIHBlcmY6IG1hcnZlbGw6IEFk
ZCBDTjIwSyBERFIgUE1VDQo+c3VwcG9ydA0KPlRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRp
b24hIFNhc2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlKHMpIHRvDQo+Y29u
c2lkZXI6DQo+DQo+UHJlLWV4aXN0aW5nIGlzc3VlczoNCj4tIFtIaWdoXSBUaGUgUE1VIGRyaXZl
ciB1bnJlZ2lzdGVycyB0aGUgUE1VIGJ1dCBmYWlscyB0byBjYW5jZWwgdGhlIGhydGltZXINCj5k
dXJpbmcgZGV2aWNlIHJlbW92YWwsIGxlYWRpbmcgdG8gYSBVc2UtQWZ0ZXItRnJlZSB3aGVuIHRo
ZSBkZXZpY2UgbWVtb3J5IGlzDQo+ZnJlZWQuDQo+LS0NCj4NCj5jb21taXQgZDE4YjE4YzBmZDAx
ZGE2YmQ2ODM1OTZiZGQ5NjQ2NGQyNWVkMThhOQ0KPkF1dGhvcjogR2VldGhhIHNvd2phbnlhIDxn
YWt1bGFAbWFydmVsbC5jb20+DQo+DQo+cGVyZjogbWFydmVsbDogQWRkIENOMjBLIEREUiBQTVUg
c3VwcG9ydA0KPg0KPlRoZSBDTjIwSyBEUkFNIFN1YnN5c3RlbSBleHBvc2VzIHBlcmZvcm1hbmNl
IGNvdW50ZXJzIGZvciBERFIgdHJhZmZpYy4NCj5UaGlzIGNvbW1pdCBhZGRzIENOMjBLIHJlZ2lz
dGVyIG9mZnNldHMsIGV2ZW50IG1hcHMsIGFuZCBzeXNmcyBhdHRyaWJ1dGVzLCBhbmQNCj5tYXRj
aGVzIHRoZSBkZXZpY2UgdmlhIE9GIGFuZCBBQ1BJLiBQbGF0Zm9ybSBkYXRhIGlzIHVwZGF0ZWQg
dG8gdXNlIHNpbGljb24NCj5mbGFncyB0byByZXVzZSB0aGUgQ04xMEsgUE1VIGNvZGUgcGF0aC4N
Cj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BlcmYvbWFydmVsbF9jbjEwa19kZHJfcG11LmMN
Cj4+IGIvZHJpdmVycy9wZXJmL21hcnZlbGxfY24xMGtfZGRyX3BtdS5jDQo+PiBpbmRleCA3MmFj
MTdlZmQ4NDZhLi42ZjYzOGRmZTgyOWI4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9wZXJmL21h
cnZlbGxfY24xMGtfZGRyX3BtdS5jDQo+PiArKysgYi9kcml2ZXJzL3BlcmYvbWFydmVsbF9jbjEw
a19kZHJfcG11LmMNCj4NCj5bIC4uLiBdDQo+DQo+PiBAQCAtMTA5OCw2ICsxMjk0LDcgQEAgc3Rh
dGljIHZvaWQgY24xMGtfZGRyX3BlcmZfcmVtb3ZlKHN0cnVjdA0KPj4gcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPg0KPltTZXZlcml0eTogSGlnaF0NCj5UaGlzIGlzIGEgcHJlLWV4aXN0aW5nIGlz
c3VlLCBidXQgZG9lcyB0aGlzIGZ1bmN0aW9uIG5lZWQgdG8gY2FuY2VsIHRoZSBocnRpbWVyDQo+
YmVmb3JlIHJldHVybmluZz8NCkhpICBLcnp5c3p0b2YsDQoNCkFncmVlZOKAlHRoaXMgc2hvdWxk
IGJlIGZpeGVkLiBTaW5jZSBpdCdzIGEgcHJlLWV4aXN0aW5nIGlzc3VlLCB3b3VsZCB5b3UgcHJl
ZmVyIGEgc2VwYXJhdGUgcGF0Y2ggaW1tZWRpYXRlbHkgDQphZnRlciB0aGlzIHNlcmllcywgb3Ig
c2hvdWxkIHdlIGluY2x1ZGUgaXQgYXMgcGFydCBvZiB0aGUgdjggc2VyaWVzPyANCj4NCj5Mb29r
aW5nIGF0IGhvdyB0aGUgZHJpdmVyIG1hbmFnZXMgbWVtb3J5LCBzdHJ1Y3QgY24xMGtfZGRyX3Bt
dSBpcyBhbGxvY2F0ZWQNCj53aXRoIGRldm1fa3phbGxvYygpIGluIGNuMTBrX2Rkcl9wZXJmX3By
b2JlKCkuIFRoaXMgbWVhbnMgdGhlIG1lbW9yeSB3aWxsDQo+YmUgYXV0b21hdGljYWxseSBmcmVl
ZCBieSBkZXZyZXMgaW1tZWRpYXRlbHkgYWZ0ZXIgY24xMGtfZGRyX3BlcmZfcmVtb3ZlKCkNCj5m
aW5pc2hlcy4NCj4NCj5JZiB0aGUgZGV2aWNlIGlzIHVuYm91bmQgdmlhIHN5c2ZzIHdoaWxlIGEg
cGVyZiBldmVudCBpcyBzdGlsbCBhY3RpdmUsIHRoZSBocnRpbWVyDQo+Y291bGQgc3RpbGwgYmUg
cnVubmluZyBvciBxdWV1ZWQuIEJlY2F1c2UgcGVyZl9wbXVfdW5yZWdpc3RlcigpIGRvZXMgbm90
IHN0b3ANCj50aGUgUE1VJ3MgaW50ZXJuYWwgdGltZXJzLCB3b3VsZCB0aGUgdGltZXIgY2FsbGJh
Y2sNCj4oY24xMGtfZGRyX3BtdV90aW1lcl9oYW5kbGVyKSBleGVjdXRlIGFmdGVyIHRoZSBkZXZy
ZXMgY2xlYW51cCBhbmQgY2F1c2UgYQ0KPnVzZS1hZnRlci1mcmVlIG9uIHRoZSBmcmVlZCBkZHJf
cG11IHN0cnVjdHVyZT8NCj4NCj5Db3VsZCB3ZSBhZGQgaHJ0aW1lcl9jYW5jZWwoJmRkcl9wbXUt
PmhydGltZXIpIHRvDQo+Y24xMGtfZGRyX3BlcmZfcmVtb3ZlKCkgdG8gcHJldmVudCB0aGlzPw0K
Pg0KPj4gICNpZmRlZiBDT05GSUdfT0YNCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBjbjEwa19kZHJfcG11X29mX21hdGNoW10gPSB7DQo+PiAgCXsgLmNvbXBhdGlibGUgPSAi
bWFydmVsbCxjbjEway1kZHItcG11IiwgLmRhdGEgPQ0KPj4gJmNuMTBrX2Rkcl9wbXVfcGRhdGEg
fSwNCj4+ICsJeyAuY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGNuMjBrLWRkci1wbXUiLCAuZGF0YSA9
DQo+PiArJmNuMjBrX2Rkcl9wbXVfcGRhdGEgfSwNCj4+ICAJeyB9LA0KPj4gIH07DQo+DQo+LS0N
Cj5TYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtDQo+M0FfX3Nhc2hpa28uZGV2Xy0yM19wYXRjaHNldF8yMDI2MDUyNzE1
NDExOC4xMjg4NC0yRDEtMkRnYWt1bGEtDQo+NDBtYXJ2ZWxsLmNvbS0zRnBhcnQtDQo+M0QyJmQ9
RHdJRmFRJmM9bktqV2VjMmI2UjBtT3lQYXo3eHRmUSZyPVVpRXRfblVlWUZjdHU3SlZMWFZsWERo
DQo+VG1xX0VBZm9vYVpFWUluZkd1RVEmbT15d096dzBZOWhINE1Tdmg5YjFCMGtrMDhsTXpFVzZ6
U0JQNmNVDQo+eUtMQjFnQm1CS0ltdExVekU4MkNWQ1hVN3RXJnM9aGRBUVJjeDc2UmFPMHREZml4
aEJCdHJGdnRlUlZfUmdxDQo+cXJBQXFiSVRyYyZlPQ0K
