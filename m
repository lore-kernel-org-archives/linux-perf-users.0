Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490D3C2795;
	Wed, 27 May 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874548; cv=fail; b=VJD12vq6E2C2p1PvtCDAgJKwis2eMcm+baU+eJ5VN1/u/M6exU5bzzBY8IgJGgUGL/CUALzoQYIoCJKdeuXX4UDrz3F/3+e4c35lOSsCeln/UtFHqVK2ScmrAw/gPPYgUavPa1rCWFHo0RHweeGTiXKVg7XkBXfvrk2mWsuxixQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874548; c=relaxed/simple;
	bh=aKbG85k9fU061ZSrdjFElU6t3efuS1k6zFT6tAfxUEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0n0SPxzcZE7IVVCbW/jVGhKi9ul22ISpTnkfndkMmucstdIUN+GUJ/8rdE7sc1feBHyP72Tac72VL0vNnlqTFOdwdIT041w3RF0nhLXLhlLlw1A0CAirVHPrPQ0uEvMfEljpLaHbwWz0TY4O7jcENLKatLSpzaGl5ld5g0G00w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aUAq1S1g; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aUAq1S1g"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R93OpT505478;
	Wed, 27 May 2026 02:20:54 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022097.outbound.protection.outlook.com [40.107.200.97])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4edncfhdg0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 02:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjRk+zJt/Y/ZD2DKAoTlL9LWDECKWjmXrtm1z5lx+cnATX1r1aEizHlRfhGZ+poYcgacFDhMILQC755Gs1idCn43s4MYTQn4Iczt51TcHpoqML/tQQTSwPRiY6y55NVbx0tfXQ3GmkgF3YzCT8pQtabIqxXdU5YH8/xNboKER0IlXjhYznDfy34QgJ+3DumzGbo0sAcAPtIGGULo+W7vnLKU5k+M1WutxXhCCGWefH7I1l4clQmCb4v64rN3uEkAgK9Vrq1E8dctIaGf9G4FKTIEM4g1LwRJbzqjbfJjRIPaBKpmg0Xq0QSVZwKsVFWVkHr/rpBHkY+TNY3hUEX6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKbG85k9fU061ZSrdjFElU6t3efuS1k6zFT6tAfxUEY=;
 b=UCl6K6jWXTwt4CQmqCzqUaJo/zKUzwQJ3wqdmnQqGhHwLiWPMBK2XNu93e1iHi9fmTAjKECP1r03Nw2yTiM3bJ0531DLfoCh6BmuSQiId4JlROWq2rXc6SvxJMp82rcRY5MbClB4jd1mE+mV7JSvj92SBEowv2CiuxaCMb3FltmlJdjthocMCUHyKug97uhnXF0R6OD/PQ2rLy0gSBM2eQOkhtLQYqTokfN8y36kP97/F71EJNMa9z3hr9DK5otVY7MZL0bVwbxGBU5LGBsIAdbmd753YyNNHpt1DfNl12rWumy135vTYMlKKfoMZkrOLZWma/Mkc4mOUp9F2pSyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKbG85k9fU061ZSrdjFElU6t3efuS1k6zFT6tAfxUEY=;
 b=aUAq1S1gVdVrh6ya9Wm8Nu8GODAgUzf+lmrhs4g8XOJW/Drlnrd7Mzcry/yQrZq8izOgfPL/bpwNg3paysLrm7TJrFAjglcTZ1RFJrgDg5xkR84NfwvJpT+0yiLWDY2C7Lx8fj13IEqXjTHgSRqjtQhfxnVxpebENL3zLJFlWY4=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SA1PR18MB4631.namprd18.prod.outlook.com (2603:10b6:806:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:20:50 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 09:20:50 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v6 1/2] dt-bindings: perf: marvell: Extend
 CN10K DDR PMU binding for CN20K
Thread-Topic: [EXTERNAL] Re: [PATCH v6 1/2] dt-bindings: perf: marvell: Extend
 CN10K DDR PMU binding for CN20K
Thread-Index: AQHc7bUpPS/s+XWaXk6VcdLxhcxhVrYhldSg
Date: Wed, 27 May 2026 09:20:50 +0000
Message-ID:
 <CH0PR18MB433904DAE545C8B386E6EC3CCD082@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260526164330.23878-1-gakula@marvell.com>
 <20260526164330.23878-2-gakula@marvell.com>
 <20260527-wise-cobra-of-feminism-2720a6@quoll>
In-Reply-To: <20260527-wise-cobra-of-feminism-2720a6@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SA1PR18MB4631:EE_
x-ms-office365-filtering-correlation-id: cf2c8b6f-f147-482f-5793-08debbd13e61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|11063799006|4143699003|3023799007|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info:
 FmikdvfFqyXH18baG9kFORVFXGiM2jeiYn6Y9q5SyyhznL723j/F+gTfvRCPIV8CdWSX6SpHsyldLpt1/6meu5B1BywE2sZrUE7lB68CjPEKp80ZCFxzvp3m4oBTNag/uFA1To8p81kx0K3uZxQBaW1pbFbPhj3t3MAkcxNQ7NJEFaa67Wh5hfzWR2FMORk5zH0ZXsgUA/++2o9fyTUoUSCjpTC8ub2bOp7LjEbhkxnpzrF2HnW7bbaoZdQSNUtUnkzwoqdFEWnHR3kyUDMa8g0LX/ukoGSr86nr6DXmnaibs/tfoijW6KDG/Qien84zzoGCrmrqNpT/mBv4gY9P243ridqOsiANBtvb6nTjkoSlwdES0aXE4hHiRJ5uwQh2wLh4ijqJLRm/yowqjMsPsdUGaGCsDTL0RcdMQDjd1mqlJlF3EI4Wptsy8wiiEo6OdrTK8Lqh9B5xQvD3BEv3RG4A3DKl2qUV6nZjBfevOeuMnxTyyw8YlXjPOmzOLhJ0W0g9IZDGWXuugKeUNZYlIaSwz7vxnkl93U+nUG7os0De4HOK/fLPKsZKLDofiRMgYZEq0VRvEzkAuwUZzFBsVII5PS8iIHvquR8dkHjOaS5pi9hgOE5RS3L43rz3QlAjgpoMegJk3hJiReaUzuS8/WqJDAaaQ+5rrXjIQeMXbCBxPzMmwGKail0iOCtp+1lmZR8r57gBncw2PkSIKBXGcg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFlaaVc1a0NVRSs2c3hETW1ndUFqSldrdHVTOW5oTWJTQTh5Rzlsd0xZNGtK?=
 =?utf-8?B?N2ZmZWxhSDVtRGtpQy9PZUtrZUVRMG4xVWRjcCtORkxuei84anFCTzM4NXor?=
 =?utf-8?B?VmwxUXlMYVJob0NsUlpIeUlvR3MxQ3JSVVp0MmJxS1NFdVZVdGVaVWtBN3Az?=
 =?utf-8?B?MGVhQkd1RTdEeFZwd3luUkQxcjVqd2RGUThKZ3BYN3E0Sm85TEZvQ3l5MnVv?=
 =?utf-8?B?U2FiaEVmVHpVV08rZXlYODNPRFVLSERjREluT3FGN2d2VlhMc3NjaDIydmJL?=
 =?utf-8?B?cjJkRzdnWE13UDNYRzlRVnp5NXNhaWp5N2tST3djSXRoU1ZKTENQZVJIVlN2?=
 =?utf-8?B?aDdPTDkyWVN6NmQ0YzlCY3dIb1NHM1JTMFZIVy9ROVFqd3NQUGlvcXBoRFdj?=
 =?utf-8?B?N2I1ODdBZ2xPOC8vaExteHY0OGQ3c0tPeCtvK1NoU0N3cStreTMxaVRuNE16?=
 =?utf-8?B?NVJrOG5kTXhtUno3K2NTR0FWRlk2dHN0aUFCb25USk9hMjdlL3BSS0JadTFx?=
 =?utf-8?B?dTc1Y0FaZEtCQzFWMTlMR1grM1JoUkZ0MWtYSHhGVjJvc2FwSlFOejZ1OXBk?=
 =?utf-8?B?M1hDWWJPYkhpUmVocTFDWlRjYUt5S2gyT0YyOENHejNOYWtraGxKYmtYUHVF?=
 =?utf-8?B?Z1hxRmpaZTFURW9HeEdvdFpDdXdHRFd4c0FVd2xXS2xVdXFscy8rT1JQQVRJ?=
 =?utf-8?B?WERaeC9CUGNDL2daSEFnblEwVVY3WEpGTElVcUxER2ppeW9HVy9FKzVXeitz?=
 =?utf-8?B?MXdxWVpZS3F6WTFacDRUc1RKUU0yR1hvb29RWGtkQlh1SFh0TGtRYmoxMVpE?=
 =?utf-8?B?ZExyK3F5V1RGZXIvWG02bndLWnRlcXovOWFOYTJ3U0RLKzBTdjVGMFlLUHRp?=
 =?utf-8?B?SzhFVHZSUnVYbkRlRW0rN1lTd3BrcXAzNU03Z1ZJdHVuSkw5QmFqcE85UlBF?=
 =?utf-8?B?Zjk4RzRqQjdHejdrTW85VVBPVUZwYjVweGxrd0JXcXNXQ2pBZ0Y1RVdoSTBE?=
 =?utf-8?B?Z013UkVsdTZnOHhWQjNtd0IrY1RObFhvNnlLNHBnUDd5YVU1KytyUzlHVjdr?=
 =?utf-8?B?WENOcGNlZ1E4ZDlsUDF2N0wwRjkzUEtYQ2lBVUFVVVhJaHlCcEpObzRWVktq?=
 =?utf-8?B?NHdSd3I0b0Y4empzbURJczkrQlRlK1dNekJ3cTdJTnQ3c1I5U1RhMUNJRFVF?=
 =?utf-8?B?ZVFIRTl6TGV0Z3BqMGZTSFJPcUdlVEVOSDd1N2F6SEVaWUdna3FIVU0va0I4?=
 =?utf-8?B?dll5RGVmb1B0YXEzNkhUM3NMdS80clRtL0V1YWhhSHNIdnUyUlBuQ1B2bkRX?=
 =?utf-8?B?WUtwNmZPVEM1TzVKSDNtd2FUL21VL1AwVytpMTh5aDFmaytIWXltQWF3Vlht?=
 =?utf-8?B?ODYvYWU5bGpNM1ZxUGd5OUxFaU1VYXVuRzVJTkhZMzZ2d20zSTlUVFhDbU1E?=
 =?utf-8?B?MXh4SmlDNjZwWHhzbjZwNkZqQ2Q3ZHFUc0s0NnNieGFmVEtYRGU1S0RidFhZ?=
 =?utf-8?B?cW5HUnZVUDhScm0vbVBVK2NtZEpEUjBUdlNjZU1KVGJaRTZWMEVNbFZoMEZE?=
 =?utf-8?B?d0ZvSTQ2UzRJV1FkMmdtaW84OVVqcG1IMkpSSUk4UTdwSVQxZ0JvdGhtQUk1?=
 =?utf-8?B?Z3lLVGljcVVpbk5ib2NXK1JvNFIxVEgwWjNxbmlYaHpvZUQ1S1dTVDZ6a2NL?=
 =?utf-8?B?clpZT0NRaFNTNVFpOW1nZWpHNnFLMnJWRTlWRUtQdXp2R0wwK1dNMDhSRzZp?=
 =?utf-8?B?TEc1cEpoQ29TdDkxWC9rc203djA3K0FGZG5zMjhnb0tPekpRR1Q2dktmYUty?=
 =?utf-8?B?MFdCTzBkWVlRM3ZzZXpvT2dGTkt3UDN6aXhLWjRQQTdJb0N5RUtPbk1TSDhs?=
 =?utf-8?B?NXBPTHgvejFyT3I2bXVtQ0lYMElEN1RqcHYxa2w4d05HZE04NVB1Z29uRjU5?=
 =?utf-8?B?YVVvSndkWWtUYlhveDFUWGhaUDk0OExRVE5sMFgzdUF1YW0wRHRIc3dWUE1k?=
 =?utf-8?B?b2kwQnM4K0FEQkFaUTU5eXlDUVNnMnpoTXY2azJWT2FUSnBhb1hxaDFuS3hn?=
 =?utf-8?B?THpOamdkUXN2OFRKbms2ZGorcktPdjBWNlQ0Vy9KckxFbHYyWW5jY24rRzJs?=
 =?utf-8?B?anR6aU1CbHZSVnNaaHUzeWtWZjYxVXYxSHVIMDFzMCtHNHZIWXYrRlhnVHJh?=
 =?utf-8?B?c2hzNDN0VmRON05BSUVYNXpDK056VnlHSUI2UVBZNlh4eHF5VFlDN3VzQUtx?=
 =?utf-8?B?YWdqZmFvWjRmbTB5YVJOMkRUTEJva0krTm1VODhZQTloZW5oRGtPMEpoTlBi?=
 =?utf-8?Q?jth381tjQpQ7yExoKD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	INo+jYYmQ618bZ0bDTISWIwnnixGwPAaCZqQUIsUOBSBrX6xidnTHU80LJCJ/Kq0gkQD2gS/HinHkGJ0h4eabsJUtqVDBBqPSM0r9lHWLLhwgguWkSs3ZcPwgu0Wyj13XTh437q+Kn3/1NICtsm8BbmGsTA9dmxZACXNdbbsddT4LrlauZeIjgOOPRzwLJbhwSVLokXBL8rJjSiM4ka8aEk/vmMezXBfzr4H2jkcLPs5BQllsGM4ZZErrN+hsYDJQBw45Htf3MXoB+6ElefkX9qnUFCosPkJDNTmlcQ1uPcOsxjyNYgo/9aCjDXlYrunj8T7/pFK0lyRH4gz98TRSg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2c8b6f-f147-482f-5793-08debbd13e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 09:20:50.1724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpFnPS50Kjkn0ZZ8AOAfeMnyiyI4OU5MY5GwD/OlCwmRSj5iiOQRxSUY2uZqrYHa4oQ9ql1T8ItEBLP5N5NjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4631
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4OSBTYWx0ZWRfX0kHgU3sxGC6w
 3q3ENY8ldS0qx3IeIUBmjC2UcH5+WDtSMKDexYAH+M3J42zCKr7kZvwb2WXsZDoYdGmXYxxAR+s
 6BtXJNO243D0ooj+AS4UMhz5l7U9HU/gi6FjYZKssNkb+8BV6cBD9OsxTQxEWIXhWKfSOvM/9t5
 TpHM1L1x+ywVn/3OVgbmq58RH35UJ5nOLeKlyln4hzIxplFVSW+6RqCFENnOesbcIFc7nbZXccO
 DMyVCjTWxKLWAOZ7BdxSn790wqXgbeu7cncgBWeoNG8zXTEtothF79Gusxdf5k8t+0UZ8pM1HfK
 es0og0bV2tA6GIxN1tjPGQmAigmnZtLm3KQQRzZ2dy7ZJMbhL7y0nfd1Adq148q+A2ZEnzQ3MfC
 Lf2CFdxwebSpm2IgfD5uhBUHR//zxzONv7cX/C7r6xN4nSsTmuwMwA+K/CrCQeEUJ7ZVpfNFfn6
 gSCT4DXJZm+6bgWSmzw==
X-Proofpoint-GUID: XBnuA9u5CKDFZm0oRHK6eZCiAOuQhyDd
X-Proofpoint-ORIG-GUID: XBnuA9u5CKDFZm0oRHK6eZCiAOuQhyDd
X-Authority-Analysis: v=2.4 cv=C6vZDwP+ c=1 sm=1 tr=0 ts=6a16b776 cx=c_pps
 a=SZtIYYfwCtOfF2ZQIsfBAw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=sJsbjMzcYqjkqFslYosA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj5TZW50OiBXZWRuZXNkYXksIE1heSAyNywgMjAyNiAyOjE1
IFBNDQo+VG86IEdlZXRoYXNvd2phbnlhIEFrdWxhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+Q2M6
IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0tDQo+a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPm1hcmsucnV0bGFuZEBhcm0uY29tOyB3aWxsQGtlcm5lbC5v
cmc7IGtyemsrZHRAa2VybmVsLm9yZw0KPlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2
NiAxLzJdIGR0LWJpbmRpbmdzOiBwZXJmOiBtYXJ2ZWxsOiBFeHRlbmQNCj5DTjEwSyBERFIgUE1V
IGJpbmRpbmcgZm9yIENOMjBLDQo+DQo+T24gVHVlLCBNYXkgMjYsIDIwMjYgYXQgMTA6MTM6MjlQ
TSArMDUzMCwgR2VldGhhIHNvd2phbnlhIHdyb3RlOg0KPj4gTWFydmVsbCBDTjIwSyBTb0NzIGlu
dGVncmF0ZSBhIEREUiBQZXJmb3JtYW5jZSBNb25pdG9yaW5nIFVuaXQgKFBNVSkNCj4+IGFzc29j
aWF0ZWQgd2l0aCB0aGUgRERSIGNvbnRyb2xsZXIuIFRoZSBibG9jayBwcm92aWRlcyBoYXJkd2Fy
ZQ0KPj4gY291bnRlcnMgdG8gbW9uaXRvciBERFIgdHJhZmZpYyBhbmQgcGVyZm9ybWFuY2UgZXZl
bnRzIGFuZCBpcyBhY2Nlc3NlZA0KPj4gdmlhIGEgZGVkaWNhdGVkIE1NSU8gcmVnaW9uLg0KPj4N
Cj4+IFRoZSBDTjIwSyBERFIgUE1VIGlzIGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50IHRvIHRoZSBD
TjEwSyBERFIgUE1VLA0KPj4gd2l0aCBtaW5vciByZWdpc3RlciBvZmZzZXQgZGlmZmVyZW5jZXMu
DQo+Pg0KPj4gQ2hhbmdlcyBpbiB2NjoNCj4+IC0gZHQtYmluZGluZ3M6IERvY3VtZW50IENOMjBL
IGluIHRoZSBleGlzdGluZyBtYXJ2ZWxsLWNuMTBrLWRkci55YW1sOw0KPj4gICBhZGQgbWFpbnRh
aW5lciwgZGVzY3JpcHRpb24sIGNvbXBhdGlibGUgZW51bSBlbnRyeSwgYW5kIGEgQ04yMEsgZXhh
bXBsZQ0KPj4gICB3aXRoIHVuaXQtYWRkcmVzcyBhbGlnbmVkIHRvIHJlZy4NCj4NCj5DaGFuZ2Vs
b2cgaXMgbm90IHBhcnQgb2YgY29tbWl0IG1zZywgYnV0IGNoYW5nZWxvZyBhcmVhLCBzbyBhZnRl
ciAtLS0uDQpXaWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQo+DQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogR2VldGhhIHNvd2phbnlhIDxnYWt1bGFAbWFydmVsbC5jb20+DQo+PiAtLS0NCj4+ICAu
Li4vYmluZGluZ3MvcGVyZi9tYXJ2ZWxsLWNuMTBrLWRkci55YW1sICAgICAgIHwgMTggKysrKysr
KysrKysrKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0DQo+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wZXJmL21hcnZlbGwtY24xMGstZGRyLnlhbWwNCj4+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BlcmYvbWFydmVsbC1jbjEway1kZHIueWFtbA0KPj4gaW5k
ZXggYTE4ZGQwYThjNDNhLi43OWZhZTlmZGI2ZjEgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9tYXJ2ZWxsLWNuMTBrLWRkci55YW1sDQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9tYXJ2ZWxsLWNuMTBr
LWRkci55YW1sDQo+PiBAQCAtNCwxNiArNCwyMiBAQA0KPj4gICRpZDoNCj4+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwLTNBX19kZXZpY2V0cmVlLm9yZ19z
Y2gNCj4+IGVtYXNfcGVyZl9tYXJ2ZWxsLTJEY24xMGstMkRkZHIueWFtbC0NCj4yMyZkPUR3SUJh
USZjPW5LaldlYzJiNlIwbU95UGF6N3gNCj4+DQo+dGZRJnI9VWlFdF9uVWVZRmN0dTdKVkxYVmxY
RGhUbXFfRUFmb29hWkVZSW5mR3VFUSZtPUtQdXB2Q2d2SUx1UzkNCj5ZUnpLUg0KPj4NCj5WTUF3
TzBKaVVxUFExWVRicWFzX1lBcF9VVXR6emRVZ05kTWJCUnE3M1ZXekNLJnM9UUVReUZ2OFlLRg0K
PkRHb1V4R2k0NlU3DQo+PiBZam12akhLSHFEbXpvR2kyd3czR0xRJmU9DQo+PiAgJHNjaGVtYToN
Cj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwLTNBX19k
ZXZpY2V0cmVlLm9yZ19tZXQNCj4+IGEtMkRzY2hlbWFzX2NvcmUueWFtbC0NCj4yMyZkPUR3SUJh
USZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEmcj1VaUV0X25VZVkNCj4+DQo+RmN0dTdKVkxYVmxY
RGhUbXFfRUFmb29hWkVZSW5mR3VFUSZtPUtQdXB2Q2d2SUx1UzlZUnpLUlZNQXdPMEppDQo+VXFQ
UTFZVA0KPj4NCj5icWFzX1lBcF9VVXR6emRVZ05kTWJCUnE3M1ZXekNLJnM9M2tQNFZfZ0ljeGlY
UG00dk9DbnNyUDhoa00weQ0KPkhMNmxURWZvDQo+PiA5WDNmVm5vJmU9DQo+Pg0KPj4gLXRpdGxl
OiBNYXJ2ZWxsIENOMTBLIEREUiBwZXJmb3JtYW5jZSBtb25pdG9yDQo+PiArdGl0bGU6IE1hcnZl
bGwgQ04xMEsgLyBDTjIwSyBERFIgcGVyZm9ybWFuY2UgbW9uaXRvcg0KPj4gKw0KPj4gK2Rlc2Ny
aXB0aW9uOg0KPj4gKyAgUGVyZm9ybWFuY2UgTW9uaXRvcmluZyBVbml0IChQTVUpIGZvciB0aGUg
RERSIGNvbnRyb2xsZXIgb24gTWFydmVsbA0KPj4gKyAgQ04xMEsgYW5kIENOMjBLIFNvQ3MuIFRo
ZSBibG9jayBpcyBhY2Nlc3NlZCB2aWEgYSBkZWRpY2F0ZWQgTU1JTw0KPnJlZ2lvbi4NCj4+DQo+
PiAgbWFpbnRhaW5lcnM6DQo+PiAgICAtIEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVs
bC5jb20+DQo+PiArICAtIEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPj4N
Cj4+ICBwcm9wZXJ0aWVzOg0KPj4gICAgY29tcGF0aWJsZToNCj4+ICAgICAgaXRlbXM6DQo+PiAg
ICAgICAgLSBlbnVtOg0KPj4gICAgICAgICAgICAtIG1hcnZlbGwsY24xMGstZGRyLXBtdQ0KPj4g
KyAgICAgICAgICAtIG1hcnZlbGwsY24yMGstZGRyLXBtdQ0KPj4NCj4+ICAgIHJlZzoNCj4+ICAg
ICAgbWF4SXRlbXM6IDENCj4+IEBAIC0zNSwzICs0MSwxMyBAQCBleGFtcGxlczoNCj4+ICAgICAg
ICAgICAgICByZWcgPSA8MHg4N2UxIDB4YzAwMDAwMDAgMHgwIDB4MTAwMDA+Ow0KPj4gICAgICAg
ICAgfTsNCj4+ICAgICAgfTsNCj4+ICsgIC0gfA0KPj4gKyAgICBidXMgew0KPj4gKyAgICAgICAg
I2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+PiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4+
ICsNCj4+ICsgICAgICAgIHBtdUBjMjAwMDAwMDAwMDAgew0KPj4gKyAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWFydmVsbCxjbjIway1kZHItcG11IjsNCj4+ICsgICAgICAgICAgICByZWcgPSA8
MHhjMjAwIDB4MDAwMDAwMDAgMHgwIDB4MTAwMDAwPjsNCj4NCj5ObyBuZWVkIGZvciBhIG5ldyBl
eGFtcGxlLg0KQWRkZWQgdGhlIGV4YW1wbGUgYmVjYXVzZSB0aGUgcmVnaXN0ZXIgYWRkcmVzcyBy
YW5nZSBkaWZmZXJzIGZyb20gQ04xMEssIGFuZCBhIHNlcGFyYXRlIGV4YW1wbGUgbWFrZXMgdGhl
IENOMjBLIG1hcHBpbmcgZXhwbGljaXQuDQpBcyBzdWdnZXN0ZWQgd2lsbCBkcm9wIHRoZSBhZGRp
dGlvbmFsIGV4YW1wbGUgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpHZWV0aGEuDQo+DQo+
QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0KDQo=
