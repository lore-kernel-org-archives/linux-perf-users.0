Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA634D913;
	Thu, 23 Oct 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245846; cv=fail; b=KLYNCgLkua9rG9vOoca7B30FUvaYuCw1n+Rm/Wk1cUTBGGFfwxoFQLXRKryoi3fGVnjrB76zItnr/aAqPiA6fDYYYXadc1Da7GusJ90UrRn4XX77oePSRKgz29K5AxZI19rECS79tWGJG4PGQEDzZhBDFmhxNiMS7NxS/tmUH5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245846; c=relaxed/simple;
	bh=Zm75V9xqCe3ocYoA+1TeZc5TVKO6ho9EZbfxiV6cEaI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TSDRK7KT/fWZVAez4+Lg1ZNoKtFNoh9jVfaIk9G3VAC3/A4iOUWPi2TAvZkoTADnB56xVwJD5PMi3UFOrh8IHumkOEjLIbP2dsilW9caftWrsHlBCQqbanivgAACLv8kvWMZ1/h3hvTc4BxNd+RDRP7Pqizz3Dr6ZQRW+kZEtnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dAyjrpeu; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dAyjrpeu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciW+xpvk5JiIi1ukR1QfJvmuWrfQGdqv2ZBH1oAsXYRzTB1yAZtEVoAtkHfpn0bqXgJuVfOPVwUXPu9gsdGYki9S6r0hmRxc4spZRF7ynMTUr1mtM25a9xrTzfKPluYrbb3ouYPytXaG2NsaN5O6uPIH3RkIctkhiSPwViCfx6eDqyHu/TvZq9vbt1XdCsAsCq4uXX4PPwt+VR8SG1X3oqBZ8+mRSfw6fz3JAlhb4eiDhqCORv5kT5cWOTsWLqXJ7ih+g8sUi5HJDdXd3Wrlx38bm9CHZLa5x3IRye/2tZ7Oc3kzN0i4/QIFVvWVRFIZ73rPYaTUCJk8mnxib1WEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbSUfxVDDkfDi6aUaGzNrDK72d51CewGtRrWlvUNxmY=;
 b=dxKjr3670XC+oDvSaJ6IeZ9FuEC28yMF/Fbry2TKtkUlxzbnCcs/CpWs0JyL+cnloSTTLlQXRz1R6a1VosFBOk+3VFMxhjNH5n10RY3LLwTpu5JPAJ3qIpWDwsT0FwsOSch6fTo66IEq2HFLeN4um5dbYAi/+Nw3gkHIzVAtUnrTov+gEy98Vi1WccXKwJjScBUdW7oUMTwkA/s/N7+mFoYy1xHELDWLClx2sZmqRKG8PUWElundUcAFW3Wl0M1LeSsG0F7TgYQNbR1XWzRJj3uWQGzVU/DjdTTjRvRVm8Hq1Xuib+6tfwy8Psib2UiCBoV4Zok+y81yS0hune9TqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbSUfxVDDkfDi6aUaGzNrDK72d51CewGtRrWlvUNxmY=;
 b=dAyjrpeuQp5uYCGt644dkF90GPJAv1pgQ2BB8QK/KfESqIkyYjKiwI6MeV412zEq39FXMrqQeNAr20EKiioiK3BIApke5AGgfPHQ+9zALkmUCvtF8vqZ/oSxH228dbEhdBhujMgjI3kCk85Ui9PAAYXMz0rryhWBr/l9/uu5Wrk/BCTColAr8uGD2Fq6e5FCOMInIGobFRxV7LSStZV80zyIqEM9N847eEMzr3j0TCkQdVeN+5lXWjo4pQyvT8Obb09DBSBF4nIJy/vOH4hv8D6c9BtMNGisEd3zLpblSj0mMyPjrAScuZCcDjG2F9Yyxr3hnz09W+NJ+NXQIqmduQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Thu, 23 Oct
 2025 18:57:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:57:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 23 Oct 2025 14:56:44 -0400
Subject: [PATCH 4/6] perf/imx_ddr: Add support for PMU in DB (system
 interconnects)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-qm_dts-v1-4-9830d6a45939@nxp.com>
References: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
In-Reply-To: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761245815; l=6526;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lpBaGVASVzewcDssNHRMOg1gqUyfw1BHNIjAmz2d/XY=;
 b=ADvOdOq8MsPeVxIZhyGSu3d7Zn6tqFiN4rWSWMH444bCJ4k+ExJ3zY6NaPOj6wsz6k/cl03YR
 Hspfh0vlayZB/i306LYidPq68kZsFEI8Om1+1UO7AOctbzPo4b7JCpf
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: 249aae60-12fb-4ac2-0251-08de1265fe8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmxMTzZ4KytnUXBhWTdFRWVobHhUZEtqckRucEMydC8zaHQwRmx6d1JJb2JI?=
 =?utf-8?B?Visxc1BxeUN2V3VSemdwWnBMMHhWL093U2tpRy9JWDBIcDI3NU9OWEpHWWti?=
 =?utf-8?B?VU1VaGRISXQreDh0djB3UjMrL0lhOWIyOGRCUEJ2dkdzTWk5OWJDNDJqNnc3?=
 =?utf-8?B?M0R4RitnVEVxTEVqSGQ2a3pIVDBORTE5YkZ2VG9OU1lublp2NXV0QUVneHAx?=
 =?utf-8?B?a3RiZU1MRVRyWFhCVkVVV1JHM3VrSnFDOUtUck9jZCt1ampJSlFtckZnQS83?=
 =?utf-8?B?dmo3cWcxK2UzMWh6WkJYMVhVWUpob0pyZ1FFcTNib1J2TkI0c0gzaVk5UERY?=
 =?utf-8?B?VVhWZmNjc1RoRHZraGFkdmhJSjNCRnlDa01pS01iZUo4aldrYXRXYjlPYmtG?=
 =?utf-8?B?R0ZObFF5OGtiZUNEaHJMSGtIK3lqdnRUSTRreEp2M1lYdEE3UU9nT0xLWW5h?=
 =?utf-8?B?M2dwTlQwZ0FObzRqdTJ5TnVQM2h6K0t2aFJWZWdTU0QyVXlpTEVMSm1GdUlv?=
 =?utf-8?B?M2FXR2R2cW5Ja0wwU3Ira2tDYWZ2NHNTbmdveThOSGVlWm94Zjk3ZFFNelN4?=
 =?utf-8?B?dXg5U1NrVjZCb0VDWkhWMWplUFE3R1hBTEZrV0FCQk9UdEJ1RklZUUNoMUxK?=
 =?utf-8?B?V0kyQzlQR3pSODZlWFBmcmtaOVpnbmxvc2hzTExkNHU1SGFrUjlabVpkQUpP?=
 =?utf-8?B?YVovTnF0RnpGVDBMY3k0QlN0MnVVYld1TUNsWWdJYW1RVVFBUlhVRkZ4M3d4?=
 =?utf-8?B?N0oxUyt1YkduazFpMXI2Skw2VWQ0UVNjRDljcW5qWnFLV3VETEI1eldpMnVY?=
 =?utf-8?B?ZDJLdVNlSnJZTFR4L3JmZkp5WXNndTNoNW9yZmU5MldFYVUzYllJanduRmE5?=
 =?utf-8?B?WlpvRDB0Ti96MmlZODcwWjZtUXZsU0lvWEt4UytCVXBPRVFkMDZBYWlna29C?=
 =?utf-8?B?bkN1cGlCUlNDbXFzbFBqcmtkcFFWYWp4c1MwSFBZU2dlMGZZZzQyak8vNmww?=
 =?utf-8?B?SVoyL3c2ZkVTQUhrUHFSR0NYOVczQ2hMNUNWUktzQ3RLZERqbnlFbmhHNnBR?=
 =?utf-8?B?WExsckxkNGdwOG5oa3djaE4zVHZiSWNnR2kwZ1JycDNzaURZWW9JRFArb3Fj?=
 =?utf-8?B?eEpOaXZ0MGhZYXQydzR2aTZ4eU9lV3FqbVlXTUE5cFVUS1l5SmNHY1R2NGdJ?=
 =?utf-8?B?UHo1Z3g5bDN1MVc5VVV1NlpPOVRsNE9vbmdja1JZY3RiUytOK25zamJZZnlv?=
 =?utf-8?B?N2lOaHMvQXVLK1JlY3FUUnZiOTNmdzFvNVdyNVhkL2RFOG1MamRVU3d0TFdz?=
 =?utf-8?B?Wm9uUTlhWnBTU3R6S0V5R1JPZkNXZlB4ZGd4cEVwS1VTWmd5R3k1ck9yUGdw?=
 =?utf-8?B?UitwRWV4MjE3clZubU5TNHk0YXRPZzRjYkI5ZUd0bXhPM0kreENOMnNEOWFt?=
 =?utf-8?B?ekZqSmNjR1ozWDZtWFJQMUdpQTI2bGFSc1NzOTdnaWZLZWlnQzFLM3VRZkFL?=
 =?utf-8?B?bEIwNHAvMlVRdmFNS2hpTGxKbFdTVWZNekNuejhnbi81VFF3aVVOZGw2eUFq?=
 =?utf-8?B?VDJ1bHhyanRzZHhXZlVibktEZUF3ak5XcE9rQ3ByQk80eVhRZzAza1c3a0RZ?=
 =?utf-8?B?eUJaQUpMNFBDeHp3WG5HaGV1dkQ2N0dSS0lKc2wxZTBGdHVtblIweERPVytE?=
 =?utf-8?B?N3FsOG1jM0ZKQVlkMFhFTDdOWXNVV0VPVWJIdXpBQzIzYXpYK3VnMzZsNEdP?=
 =?utf-8?B?YnlndzZua3pFa09jQkdpZU5CU055eHRnNWd6Vk44Tjd4UzhKSzE4RWYxZXVh?=
 =?utf-8?B?KzhFanAxcVZhbk9DUXJSS2NUYWNuK1o2cE9nWjhMZE9QR1I4R0NEVE9mQk1Y?=
 =?utf-8?B?bXhQdVBqSXBmVTdYM01WMUo1Z3BnbFNTLzIveUQ1WUlUaW5HSE90YTFHaGt6?=
 =?utf-8?B?Mzllblg2WVhxc3kwUDE1eHEwc2VMalY0STFqNmtRTndnWWk5elkvWmVONmhk?=
 =?utf-8?B?WGRPQ2orUzhaN3NlY2NWMDNnSkRuOG50ZEJKM0dQaWpBbGY3UitoYTN6djdx?=
 =?utf-8?B?Tys1bEJuanNMWXVMU1RYYjRycGplcEJsREFmZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGErT09nbzB2eFBVNnFIT1ZJRE9yQ29oYVA4N3N0TXVzd3pqQ0JCZkZaV0tl?=
 =?utf-8?B?WHZlMXdJaDMwYlFINWZZSEFYTmlIRzlrL3NWSHJCUkNUcFh5YzliQlJLWGxB?=
 =?utf-8?B?QU5jbEo1WXc5SWx5SzBPdXZJTkMrOEVocTdyUTBWRExSdU04dk1TT21VdnFV?=
 =?utf-8?B?SjdPSlorVUU4TCtmelNGcnhyS3pURW84M21QaE5LOUphR05Bd2hUY3BHTGZZ?=
 =?utf-8?B?YVNjYzB5MGdFVHQ2dldBTUNJeElYN0xSSjlFQjQybkRJS3I1VG5KNWlBdFdS?=
 =?utf-8?B?enZOdi81aHdWNkROMzlSdjByTkNLdXNySWF6WnQ5VG1Zb2hiTVJDcGtuNkJj?=
 =?utf-8?B?Y0ZFYXVHUktXdGxHWTRsVG1hQVZ2L3dnVmtUVzNVakd6UmpaRmxqZWdtV2Zs?=
 =?utf-8?B?K2xHbGY2RGdRekdsYmZRTHRzRW9qbTBGeTRObExScEM3c3J4cVIyNStxOGVu?=
 =?utf-8?B?K2dFU0pPN2ZxQ2R2VlNOZnp2WU53RjZxaTZvcXpIaVpXNWRETHcwQXBRUklN?=
 =?utf-8?B?NlNieVR6V2I0YzVUVG1MUzhpeWlVdmhaYW5yWElGUWxlTkl1VzdMbDNGSHJ3?=
 =?utf-8?B?OTBiWTBHeUtlUEt5Z1Z0UmplVzZWaVE0L2xDOFF1RmNzcm5vWEpTWUIwdmx0?=
 =?utf-8?B?eERQT0Z1OGFtdHRHdm0xTlBJMWtiVDF6elo0Q21ZTkZNak9YR1paeEVGMGNC?=
 =?utf-8?B?d2wwYng3THJWMVhabENiczJoY0JIbmZFUytnWUZsTzQ2MUdOb1IwbWJiZDFm?=
 =?utf-8?B?MEMwTEVxMHl5OUtlRktzMExETit1ZEUzaXFKMkdKQ3R1bVdaWXBDN1hzQzVC?=
 =?utf-8?B?Y1FSWms0dmJiaUNObE1LSDN0cmRrc0JuazdkQmRCbnoveXRRS0xDYW5ucllI?=
 =?utf-8?B?OG1TczhKcExYQUtsRVRjT1RpOS9YcHRwSjV3VW1mS3dlM3RNdUdlOVhHTkRN?=
 =?utf-8?B?emhDWlQrV01RU1lLdjlwVVVPVnpMQStVSTdOUG1sQ3JjWXFmYkRkVVVka1lV?=
 =?utf-8?B?N1M3NTJhWHFtc1hTY0lXWEo5RTZQUXJlUjJTV2pucFRLd0hiazBiaEE2dXFm?=
 =?utf-8?B?M09FeTBhVW53QTFhYVJtSFdNMTRkU2Jsai9hN0c2Ymc1YVphaFFCOFJYSms3?=
 =?utf-8?B?MUJqTW9Oc3lzaWUxbjZBMmlPQTlrNEt1MXpBTm1KV1VEeWVOQTBsVENoRGJI?=
 =?utf-8?B?ZWc1TUZUSmQwMVB4c1NaQzJKL1F6eU5tT0dWTjJDalRsaDg1YVpPUmluWFVT?=
 =?utf-8?B?b2tLNW81TGFpSkxVOHhyZW1IRDUzT2Uwc3RHcXRaSjhTRHdid0h1QWl4VnRn?=
 =?utf-8?B?TzMwdGFiL3pDd2NUSUlLTkEwaDBScUtFREtYZTFtOFJJcE9yL3U4M0QrSSs1?=
 =?utf-8?B?U0RUY3RkVGkzaSs0SFR0SHBpbEg0a1FMbzVpYjlSR1RFYWVNdG5jOTQ0L1hV?=
 =?utf-8?B?d3N1YzBFNGdsQzJJQlQ4WldTMDZjWmZRdWFUU3pRbFRBVjZMalF3anMwbjNU?=
 =?utf-8?B?RWZ6UUVJWHhZeW1yRFp6RmlWV2VJdFdRTDNRTmxvVVR1YzhqelhtMm5HTXBL?=
 =?utf-8?B?aXQ2eFBJR2NkWnNPczh2eTRqdDdvWHpPZm04UUpEYWhwMFF3b0tPdUsxVGYx?=
 =?utf-8?B?d3VoSVQzdlQzMjNJalZ1Um5nRXdkVmorUXd1aEZ6QnBBWEZmazRMZ0RPcXU2?=
 =?utf-8?B?ZEdicWMycjZoeHpKMjhJbzFRRUFOSloweHpHanVFSXNQa0Z3TlJyVXlmL2pT?=
 =?utf-8?B?TWR2TjZPZ1FEM2UvOTN2YVh5c1Y3WHV3ODBBbVI0T3J5eFpYOWJkTktoc2Y3?=
 =?utf-8?B?Z1B5TXJmRzZpc29kbXdCNDRxZSt4SzRnU3VrNkJZSjloWm1NV0NsdDZFVXB4?=
 =?utf-8?B?YklIOVEyNnFkam1WazBiVnVnRDc4cFk4cFVoV0VjbkxHY2FDbVdvSGJTemZP?=
 =?utf-8?B?SDNGMVQ2T1ViUkVOVEQzTm40M1hLV3FEN2VEMnJXdnRFZlJ6bG9lUWRsbkpv?=
 =?utf-8?B?d25UK25jTzFCTzh4K1pURUxvbDlSYlhjL0Vkd0R5bkN1czBnZ3V6NWpZdU5D?=
 =?utf-8?B?cDhkT0ZWM3hKeWhhK29GV3B1QkdIWGIzR3JJVkl0VmR5RDNzWjhiVUlkZVJ1?=
 =?utf-8?Q?LgphwsY9feVruPaMuRzj4K/LE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249aae60-12fb-4ac2-0251-08de1265fe8f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:57:20.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYGtD6/CqxkiTUPWleJfq62jtn99bDFHnhAo20d7yV387uThA2GlhnJnSzd1WoPvqD6vflXlfoCbKxaFgPlPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

From: Joakim Zhang <qiangqing.zhang@nxp.com>

There is a PMU in DB, which has the same function with PMU in DDR
subsystem, the difference is PMU in DB only supports cycles, axid-read,
axid-write events.

e.g.
perf stat -a -e imx8_db0/axid-read,axi_mask=0xMMMM,axi_id=0xDDDD,axi_port=0xPP,axi_channel=0xH/ cmd
perf stat -a -e imx8_db0/axid-write,axi_mask=0xMMMM,axi_id=0xDDDD,axi_port=0xPP,axi_channel=0xH/ cmd

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 65 ++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 2a8426a74af98cf46725c2c70534829e198746f3..328287ab6326e3832aed85633957196548435d67 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -53,18 +53,27 @@
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
 #define DDR_PERF_DEV_NAME	"imx8_ddr"
+#define DB_PERF_DEV_NAME	"imx8_db"
 #define DDR_CPUHP_CB_NAME	DDR_PERF_DEV_NAME "_perf_pmu"
 
 static DEFINE_IDA(ddr_ida);
+static DEFINE_IDA(db_ida);
 
 /* DDR Perf hardware feature */
 #define DDR_CAP_AXI_ID_FILTER			0x1     /* support AXI ID filter */
 #define DDR_CAP_AXI_ID_FILTER_ENHANCED		0x3     /* support enhanced AXI ID filter */
 #define DDR_CAP_AXI_ID_PORT_CHANNEL_FILTER	0x4	/* support AXI ID PORT CHANNEL filter */
 
+/* Perf type */
+enum fsl_ddr_type {
+	DDR_PERF_TYPE = 0,	/* ddr Perf (default) */
+	DB_PERF_TYPE,		/* db Perf */
+};
+
 struct fsl_ddr_devtype_data {
 	unsigned int quirks;    /* quirks needed for different DDR Perf core */
 	const char *identifier;	/* system PMU identifier for userspace */
+	enum fsl_ddr_type type;	/* types of Perf, ddr or db */
 };
 
 static const struct fsl_ddr_devtype_data imx8_devtype_data;
@@ -98,6 +107,12 @@ static const struct fsl_ddr_devtype_data imx8dxl_devtype_data = {
 	.identifier = "i.MX8DXL",
 };
 
+static const struct fsl_ddr_devtype_data imx8dxl_db_devtype_data = {
+	.quirks = DDR_CAP_AXI_ID_PORT_CHANNEL_FILTER,
+	.identifier = "i.MX8DXL",
+	.type = DB_PERF_TYPE,
+};
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx8-ddr-pmu", .data = &imx8_devtype_data},
 	{ .compatible = "fsl,imx8m-ddr-pmu", .data = &imx8m_devtype_data},
@@ -106,6 +121,7 @@ static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx8mn-ddr-pmu", .data = &imx8mn_devtype_data},
 	{ .compatible = "fsl,imx8mp-ddr-pmu", .data = &imx8mp_devtype_data},
 	{ .compatible = "fsl,imx8dxl-ddr-pmu", .data = &imx8dxl_devtype_data},
+	{ .compatible = "fsl,imx8dxl-db-pmu", .data = &imx8dxl_db_devtype_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
@@ -290,6 +306,18 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
+static struct attribute *db_perf_events_attrs[] = {
+	IMX8_DDR_PMU_EVENT_ATTR(cycles, EVENT_CYCLES_ID),
+	IMX8_DDR_PMU_EVENT_ATTR(axid-read, 0x41),
+	IMX8_DDR_PMU_EVENT_ATTR(axid-write, 0x42),
+	NULL,
+};
+
+static struct attribute_group db_perf_events_attr_group = {
+	.name = "events",
+	.attrs = db_perf_events_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(axi_id, "config1:0-15");
 PMU_FORMAT_ATTR(axi_mask, "config1:16-31");
@@ -310,7 +338,7 @@ static const struct attribute_group ddr_perf_format_attr_group = {
 	.attrs = ddr_perf_format_attrs,
 };
 
-static const struct attribute_group *attr_groups[] = {
+static const struct attribute_group *ddr_attr_groups[] = {
 	&ddr_perf_events_attr_group,
 	&ddr_perf_format_attr_group,
 	&ddr_perf_cpumask_attr_group,
@@ -319,6 +347,14 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *db_attr_groups[] = {
+	&db_perf_events_attr_group,
+	&ddr_perf_format_attr_group,
+	&ddr_perf_cpumask_attr_group,
+	&ddr_perf_filter_cap_attr_group,
+	NULL,
+};
+
 static bool ddr_perf_is_filtered(struct perf_event *event)
 {
 	return event->attr.config == 0x41 || event->attr.config == 0x42;
@@ -655,7 +691,6 @@ static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 			.parent      = dev,
 			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 			.task_ctx_nr = perf_invalid_context,
-			.attr_groups = attr_groups,
 			.event_init  = ddr_perf_event_init,
 			.add	     = ddr_perf_event_add,
 			.del	     = ddr_perf_event_del,
@@ -737,6 +772,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	struct ddr_pmu *pmu;
 	struct device_node *np;
 	void __iomem *base;
+	struct ida *ida;
 	char *name;
 	int nclks;
 	int num;
@@ -761,21 +797,28 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (nclks < 0)
 		return dev_err_probe(&pdev->dev, nclks, "Failure get clks\n");
 
-	num = ida_alloc(&ddr_ida, GFP_KERNEL);
+	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
+
+	ida = pmu->devtype_data->type == DDR_PERF_TYPE ? &ddr_ida : &db_ida;
+	num = ida_alloc(ida, GFP_KERNEL);
 	if (num < 0)
 		return num;
 
 	pmu->id = num;
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d",
-			      num);
+	if (pmu->devtype_data->type == DDR_PERF_TYPE) {
+		pmu->pmu.attr_groups = ddr_attr_groups;
+		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d", num);
+	} else {
+		pmu->pmu.attr_groups = db_attr_groups;
+		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DB_PERF_DEV_NAME "%d", num);
+	}
+
 	if (!name) {
 		ret = -ENOMEM;
 		goto idr_free;
 	}
 
-	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
-
 	pmu->cpu = raw_smp_processor_id();
 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
 				      DDR_CPUHP_CB_NAME,
@@ -832,7 +875,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 cpuhp_instance_err:
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 idr_free:
-	ida_free(&ddr_ida, pmu->id);
+	ida_free(ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;
 }
@@ -846,7 +889,11 @@ static void ddr_perf_remove(struct platform_device *pdev)
 
 	perf_pmu_unregister(&pmu->pmu);
 
-	ida_free(&ddr_ida, pmu->id);
+	if (pmu->devtype_data->type == DDR_PERF_TYPE)
+		ida_free(&ddr_ida, pmu->id);
+	else
+		ida_free(&db_ida, pmu->id);
+
 }
 
 static struct platform_driver imx_ddr_pmu_driver = {

-- 
2.34.1

