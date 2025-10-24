Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E2348446;
	Fri, 24 Oct 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329882; cv=fail; b=Q1Z8j63URVOPs1JwlLFHOg9X5DwrWCjLZwvEENvl10pnoVmY2WYYQrgzjR6GdYz8Ubep8EC0b/t2vJY8wqxmVvrECl+PaUXyhGC9nQ5Oc01RuMpCtgM8wWu+zLYmY0TQTodcy13svUQbsDnX9N3/M+//xIt33r1bnqIHNP2szVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329882; c=relaxed/simple;
	bh=5aNPbmICzuDmt8HqRTvDr2QJitYKq8z3hwoe699hYRU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sH2RXXt1JHjU9C+8Km+hQFeoL1MM27jlBLQ9wU3THWMnuuhh6brhfwOGDqKI6fmpG9cmrlGZqSz0t8h2yWyJdp9DYvaBx5KYhrXdWWWCuEqogTiDa+KpCYKZUbgvEGuZWCeW8JaoVuVc9ipXPLrZMh9serJsZP+ZQ4R0yAEzZsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dp88EjTj; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dp88EjTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4mFLZ3FfmSWipbrh30+O39D3Rp68u+WjMl09knBQQKg2RZKI8fTPfEQYGSKX+CXKd7IOoFUoBr3OIVRUkJr8y1X9K+gJQhDimzRBdKGbTNTMt5yDXLrri+zssFQgvx8xzBmG4pBJqtu7IA436Op5RzLjZAgaWyxfzblVnax7ys4Mr5Ad28WKR59hdl01+p2lKmHJ2Bvp8Iv578FfmXB+aRWNgdxegiyAecmhZ6u4oqLRCfNTf5FO/9aUuTZaKRMkNqYGxPpxSJYHQF0eNqqYFW4VBHPqyGlxbkd3qLA+LB0ZgB0TU/gv34WR2hoVtSlxe4JQfF7FhvCCQYeE0ftYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTQ+/eoAn+aZqDJLqryvHIkv7HpjCVbKwDoZrK9Vy3o=;
 b=Ggo9EM5dh0JoVxzyjZXMgxO7MioXzQUdINmO1udGtHamC1s6Lqum82HSkWSGFp6Qs68Rt6w7rxUCsARIlpdLJGA+eJ8EOw1YxW1g1Gs1jyZ44eHhLGodAD4/TS4S48lLTR5Z31hYl/37LV1KuuczLNmjTtPj9roSQqFBeNehzSd98nKioYfAbzVYBhbxwqA+6xr8ue64VzH7f4O0/VdmsVazI7P9EdRGyfRU5Ufuav1AhBDgIw9Wa6hZme8Egx5Ky2EoF8L+WQFlJqbkZjBEDpAJcWiC3BfYQLHq3m48S6PxP+ws9Lb1sa7FE6hu0x6d2iAE9I+Ot/STWdCOrcs+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTQ+/eoAn+aZqDJLqryvHIkv7HpjCVbKwDoZrK9Vy3o=;
 b=dp88EjTjAl83eRTfSDKkTwUADMObNc+R66tR5Nu1U6r22R3CIRayqErSlTYAH2b9lIeoRlgmoL0rz01DnTMrUul/wxeO00dQb0scqF+If4DgWsjpuKdL9yulAJdCZoWM8X/VOwP/aVb5/nBVwm8pR4Y9sdTZr2Iu6v7R+XuoE4m27FufaBGKIgNRqU46Ho+vYImet2F1EEr0PvnmeZy/f52Kc9HXq9yNaf2YuBgcfBRQQLjTB1tSRi8pMpGXkGd97vPErwSxZcVSClk+B1hdUxi+kQdX26v166pk7JAlzwNto/SZzYZs/nFHHA2QAPk0snJRMANtGdzCzsIP4FSnUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:17:58 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:17:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 24 Oct 2025 14:17:16 -0400
Subject: [PATCH v2 6/6] arm64: dts: imx8dxl-ss-ddr: Add DB (system
 interconnects) pmu support for i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-qm_dts-v2-6-7a7e07022ed6@nxp.com>
References: <20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com>
In-Reply-To: <20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761329844; l=2241;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PisC1FFnqO8CpYCnMicfreqFJ284Xm7e1m95ZljMa9g=;
 b=Xlpna1l1lWwUPkm1FcCPmD5gq3SKiztjAna4QLZtlbjGc1rJ7JJUkevQuH9CDnS53uJ/DwKRN
 9ZlnQvenzeLA67L5zv5PCWJcg0bOXNhBscshWIdh2fSlVxlAR0ycuFY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0047.namprd11.prod.outlook.com
 (2603:10b6:a03:80::24) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cd1f7a-ee10-4f1f-c63f-08de1329a89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mmt3MUp2TFVPTXRwcDFCVWxVSXQzeTdLZTFTYVZGSnNPVWRqQXk4K1NESDlG?=
 =?utf-8?B?L09Mc0ErM081TkhIdjhPcEZIRGtsOFdmbkdIQXVBcHB1WFpHbTVIMHorU2Vu?=
 =?utf-8?B?WE5zRVlicmNzbjRob1VWdjBLZ084akVYellJMlYvZnU3U0RURGN3VlE2K3Ev?=
 =?utf-8?B?dFFNaUVzY0cxOXpXcEtDWTFiaW8xUmhoQm1GNGNSTXN5TFNjeFV2NHgxbUFk?=
 =?utf-8?B?azhTRDBsbEZXQ2J0a043cmdjK0hZQmk2N0FzV3lIS1NGYXlLc3Nmcm1hcTN2?=
 =?utf-8?B?eXloRlcyQ1paU0ZYa3J5RjdjZkljUnZDQlNlYThncEhtY0lvcjBUS0dWRUpq?=
 =?utf-8?B?YmVxOUh5ek9OOUovaUg1SGltREVVeExMaVdRYkJpMkxQbW9RZ1VDY3M1YTM4?=
 =?utf-8?B?Rjh3MjhzL3U3enZkM09La0wvejBONW1laThjSWpmWlpaQjFXaHRSVGhMQW8v?=
 =?utf-8?B?THFxRnE5MWo0WHNqc0FpT0tMTEFIakpxUG1yaVczbXQ3c0s4QmVQak9lbHNk?=
 =?utf-8?B?R0xObHo5NVlCVWhnQ2VzdFNwaFRsQVBmdHgrUHZxMHI0Q2RxaFFHK0dmS2lp?=
 =?utf-8?B?NnF5K3NIT0I2UHRKb2djY1pEcmhBTkZVZW0zSjhBOE1hK1BqeXNQSTRqRzd5?=
 =?utf-8?B?UHR5SEI0R1pySmlGUzlWYUJtMEptNUtsRFprbm5yaURyRVBBYXdoTHhkTzdR?=
 =?utf-8?B?bTBVR2N4S0k5bUtBQzlMamlMZDdKTWluVVNTT1JMdjBjTUJEY0hpTlN2MVpp?=
 =?utf-8?B?TkpiSy9nbXd4bU1kWnp3NzBjeFV4YmlWSnhnUVJMUzRrVUFvYkVPVzVVc1RE?=
 =?utf-8?B?WmJTMWphRldrd29na2dQVHhYR1Ayek0yZVpzbEM4TnA0Q0I3cnEyeDUyV005?=
 =?utf-8?B?bmF6V0pTdmFVeWcrcU13TmZFNnFwK3Y0eHdLaVc3bHJoejlsRm5pVk5SNzNk?=
 =?utf-8?B?TThqSkNTU29QK1ZQNDIxb2J2VlMwRTdrUDd1bVdzejBGa3hlMWthR3p1TXlG?=
 =?utf-8?B?eHcyUFNzVjBJaUdBOEtudVhvUm1BaVJPK1E0V2JuM2VGdEpjdzY1ZXpGR3lT?=
 =?utf-8?B?c050RU14OE15L0xnOVJ3aFZaQitxdXhMSnl0VC9GYSsrMnJhM1RjZ2xNRTNX?=
 =?utf-8?B?ZG4vSlBzSFpYYWh5M2tYOWkyUkFGOXM1aWpzaHZxcXV4d1NhU3BCclRnbTRl?=
 =?utf-8?B?ZVFSZ2xRbHo2a3ExY1VWVzdNeVJjTDVCQU9pZ25nRU9pZUhKWkd2dG9Cdkl5?=
 =?utf-8?B?NnlCRXFSMmJVNmRhSWVpL1plWGpGWnlHWURTTjBUbkY5ejNMb0F2OS9rbWJR?=
 =?utf-8?B?bWlzN3pXcUFzNnUxL2R3RU1nOEFuV2NDUis5TThKOXR4RDBHQSt4UFIrSG5v?=
 =?utf-8?B?N1VoY0ZkemtQZU81cm9rN29mSUprcDg1T3MzQjRJYTdSa1FKdHgxdVNvOWp4?=
 =?utf-8?B?SVB4ejB5T3VCU3V0dnU3eDJ3V3ZCVlRGOGNZMVlsNkh4MmpDbFBFSkEwWW8r?=
 =?utf-8?B?ZDNFSExEeC9zWFU5alJQeTZzdlViOEljZ3ozajlEWmpGMEpKdXJmVk1JTzZj?=
 =?utf-8?B?NGNlcGd0ZytURjJxUE1ycHhmWk84aUpMWFduZnNEbmJVc2g4Y3dsU1NhZEtl?=
 =?utf-8?B?dGRTOUhsWG9RcXhTMmU5cWpuYmliQ0hiYnZpMjNyRER5K0wrekpONnBnSzRl?=
 =?utf-8?B?SWJGVGhENWdBQkZyVFRjd21hRUpIZlVNM2ZIWnBKWGkySm5wN3o3Y1kyZ1ZH?=
 =?utf-8?B?VmlvMmoydWFELzBiT3hIRlVBUHBUdnMwUGkrWjVGZWF4ZzNFRDFGb1pQZmxK?=
 =?utf-8?B?clEyQVVqdEgzd1NDLy9WSHBVa2NHdUV3UkJzMHNhUjI1cXE2UjVIeGFHaFF0?=
 =?utf-8?B?MFF5TkdZYkx2cm9ma3VUTXhVVzIvRElPakJHWUl0WkMwMnMybXYzeGgrZzk3?=
 =?utf-8?B?ZnR1bEFyRm9FNXgwKzdUemo2WW8xTWdQN2h2ODJXWWh6WEJlYkhHclhFV3B6?=
 =?utf-8?B?LzFobzZUYnhydEduTHRvRllhb0FNYnJSZ1RtWGxZSE1KUm8vZWhpeTZ2NERB?=
 =?utf-8?B?d0FjM3o1NUppS0NKVm5IelYzMTVBb3VuNUw3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGJTNjByZUhuVW9aZW9qczgvcUthSXhINTJVdmgrZExKWjdzRFU0ZUNzTnV3?=
 =?utf-8?B?dU5wb1pFUXN4TWkwZEZtSjhVdUUvRzM3UEpQZ1dRQW1ab3RqUEFZTHRTY2do?=
 =?utf-8?B?dDNUc3o3TWJWaTh6dXNQc1V0MVppeXh5SExSZGF5MDR0MXVadXZJekNrc3dm?=
 =?utf-8?B?ano4ZEFSQXRscEhpOWp2N21SOElHcElsMm8zY2N0ZTFWbE56RmovQjh5VXJX?=
 =?utf-8?B?SmlOUUU0dkZGczl6NGxMa1Z1Q093dkl4SnJaaURkOU9ESHpGcWE0b1NpdW9U?=
 =?utf-8?B?TVFXY2dEajZzbktxODhjeTFjS0ZFV2pLZWl4Tm9xU3k5eEdwV2xkUGhBZHRG?=
 =?utf-8?B?bUN3QXV2UWI5SGY1MlkvZ21YK01ZdUFqdGp3WWs5cnJmaEhqWEUvYlNMUU4y?=
 =?utf-8?B?c2JXeFJiTUpQVE12MHRqUktBYXltYVNXa3Q2Qzh2MHlrenFKNDNhbUpCMFdi?=
 =?utf-8?B?aHI4QzRLZzJoYlBQVDlkL1dmYzEvcXlWWlBKL0wxd2gxeUc3cEptMlo1Z05k?=
 =?utf-8?B?d0gwQ2FnWmU1UTk5NkJzNi9QNVNXb0pLRWJMandtbFR0dndRajI3Y0JpL0c3?=
 =?utf-8?B?OFduaDVYcjhlZ1MrSys2TnlyNDdXVUFZZW1xaEh5dE5CQTJvQ1NqbGlobEpx?=
 =?utf-8?B?dnpJY21EKzhKZDdaNWNzSzZWV1UwUEk1UkQ5cWZ2ckhnL1NES2NEcXhzeno0?=
 =?utf-8?B?ZjE2ZE5uRDNSOS9BL1kyVjVqcDRtdHhzZUJmanBGZmI2cXRCWE9wa2FpLzJn?=
 =?utf-8?B?dkZyR1ZsQ2Y2Tytia1hURVNhdEFCM1h2VEs3Q3c4aXdKOVN0U1AxcjVJMkh6?=
 =?utf-8?B?RkJnbzBFL2ZlS1ZLcHBTbzFOS1JKRUQ0azg2aEY5YU9sTjcxSXZXZHVRUW1p?=
 =?utf-8?B?QUFaQ0pWOUtvSTJZL3BzMGV1Z21NNldqYXREYVp6N3pEYVgrbWdRZVRvcUgv?=
 =?utf-8?B?VmRXS2xGcW1EYmxTYXQ1anc3cHhqOXBjdWJvUEdFOG5pUS9JUE10KzFjQXh0?=
 =?utf-8?B?d05Xd29ZcFlMYTc2d2VsMEVXMS9ZS0ZVL0ovYTRyZ1ZxTDZMMUtZSmlvWjMv?=
 =?utf-8?B?OGNVQjlEUUs4UmZjOENPd2pSVHdLSEsvN2tWd3lXcWRWaDJ0b1Ayc3VrVnMz?=
 =?utf-8?B?aWRvK0M5RWxhU1N2akthV1orWFkrOUdncWRTQ2VuMTYyL0RaZW15aHlDRG80?=
 =?utf-8?B?RGpuS3BMMCt5b3lMMkx1MmZ1bVY1dkMrODBjS3Z3ZU5Hb25Kd1gzT3l5Tm42?=
 =?utf-8?B?aUh6cmNtRUM2N215SHZtQW10c1M0dVljZEFHNXZ4NnFValB1YXdhTVRiaDBv?=
 =?utf-8?B?ODhpUExnSWNEVWtxaHVidXRVYlR1Qm01R09BUG4yZTRHRFZ2cXJEZFdlTmc3?=
 =?utf-8?B?YnNVeWZPanlwUWVVQmpJenpjSmhTZlFsTm5oS1kzdnBHT2NaWkdwWVJnUXZG?=
 =?utf-8?B?WGNBd1Y4b1ViS3pyMHNuVFpUVU9iZG5aY2x5aEkyWksyNzFsMFdQcGN4ZFFQ?=
 =?utf-8?B?bitobWZDR085WFJrOUFYTmZBalNFQTVldDNFWk05aTNFNFlqR1Z2ZWZWWTlk?=
 =?utf-8?B?bW8zRnpXUkVkdEJhQzFhWkw1V3R3dUxzV0Z4NHAzSW9CcW9QZWtFZXVrV2Z0?=
 =?utf-8?B?ZWd4TkVEUVBjME43WEVpNHFyTHZOTWJ5QTlOc1VnN1BBNGw1VGRXMGVuTGUy?=
 =?utf-8?B?SU1YM2swM1hXaUN4OFhleTV2SStDQ21yYzM4SWpUZVJCWk4vN1ZrUkpXTkxS?=
 =?utf-8?B?bE5KODZIR1l2QzVrem9wVHpMOW1UaXdaMkN2UGNzZDg2b0MwYzd6OEVXUmhZ?=
 =?utf-8?B?UXA0d2tuREFyNU9iWjRmWHlCUllVNWRUby9XU0pBMWRYL1pPMzMvNlJveTZQ?=
 =?utf-8?B?VHRsVVk3TUVuVEtabTlOTklQZXVxN3piYTRxZElOWHhOaVdodlJ2NDQ2SG9V?=
 =?utf-8?B?a2hNVUxvR081VDFWWVl0MUhvdzR2b29tZVhCRjRycWNJS3FOZWVBOTBadmZM?=
 =?utf-8?B?QzhhMG9OT2VZeFMwbVFjR1A5bW8wenFLbUtyeTVOOFFWRllNcXVCRFphYVV6?=
 =?utf-8?B?OEUyb2xEajVabnZZYVg0ZU1ZYUsvNW1mTVZhTVl2V1Q5NFQzZitvNU9md09q?=
 =?utf-8?Q?ZdzXT2Kn27zSJO6T52ELPFfjs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cd1f7a-ee10-4f1f-c63f-08de1329a89a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:17:57.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/ty1fsGTuaHUSsU909yduCPyrIGbXyyyiJSmGbhYyzqHyx43invo3QAn0vbJolAmuQcJvHGW7+YuSy0L19CwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Jacky Bai <ping.bai@nxp.com>

Add DB pmu related nodes. This pmu is in DB (system interconnects).

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- move clock-db-ipg to imx8dxl.dtsi
---
 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi        |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
index 3569abb5bb9befd4d1504e3e2a352c64229533c0..adc6e394dbc5598c50e0e288ee605ac91087d36b 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
@@ -7,3 +7,25 @@ &ddr_pmu0 {
 	compatible = "fsl,imx8dxl-ddr-pmu", "fsl,imx8-ddr-pmu";
 	interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&ddr_subsys {
+	db_pmu0: db-pmu@5ca40000 {
+		compatible = "fsl,imx8dxl-db-pmu";
+		reg = <0x5ca40000 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&db_pmu0_lpcg IMX_LPCG_CLK_4>, <&db_pmu0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "ipg", "cnt";
+	};
+
+	db_pmu0_lpcg: clock-controller@5cae0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5cae0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&db_ipg_clk>, <&db_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "perf_lpcg_cnt_clk",
+				     "perf_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_PERF>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 8d60827822ed1cc6cfb1a9369faaebfd711708d1..5106be2fde6e025cc066b796ba7987d0d9c21bd5 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -236,6 +236,13 @@ xtal24m: clock-xtal24m {
 		clock-output-names = "xtal_24MHz";
 	};
 
+	db_ipg_clk: clock-db-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <456000000>;
+		clock-output-names = "db_ipg_clk";
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm40.dtsi"
 	#include "imx8-ss-adma.dtsi"

-- 
2.34.1

