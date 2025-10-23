Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC029B20A;
	Thu, 23 Oct 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245826; cv=fail; b=og8rlNCJ49jnKE/6Wx7ztSwL167KUi4dJG8rn6Bj6yOJFrsDF+8iKiW4mCR1VeyQPabLXXiohYcjqTiEEOJskELEAAVy+lzdNGQno6qHO1wp3DzzQzw1YacrGAR8bFMlSaw9CxmxOU96/7zxFogm3mZZcsCf+FI5GliRBcUacf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245826; c=relaxed/simple;
	bh=1tcxwfz9dD8vGhtRjGj9+YP7hB+HJ8BfnOTQF5aBiOk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=WyH/DMqS0ooAs/lASLk+lZ9piMwGJW3xAjlJUxNOB526GFKQHgw9M24EG5iiax6QzKuUWQy2pI6TGdCsAA/xk/X1vlijLTKfL0vo2wYO6mOGjs1gOK8qnQQknCqRRqx2UHH5ONguXX56p7qkwQehkYLDIC6AyaDBkX1Lwd4iwtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TqDuvE2h; arc=fail smtp.client-ip=52.101.72.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TqDuvE2h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJDxbKD5TG4NqiCYKbd2bM3xLuEBnLyr3D6CKlpcvQn9dQaSslKtueY+zWHanNWJnX6bVqF5sXqH7oMBySrx61RMpr7kR9hEaUdQ+7Hgwej5yeDnaj/1U8ecdqgExpuGrNcM3PHvKzkT4kHDVzodEAe9jpcnt3jZQeQS38Vvg+xFCX9DuKjxswB2XW8IrXUDvCczPuUBjpfN0zNXQ85w4RcLz+EDiAfSyJ6W0wlZp9IdKUQdJaIf6hRBt/Zg1qs5uz8ViBXBGrnQmBIhl7vVfLUk06gJFfmvDgNyIc7Kf5/I6yg78L9CXmIkRRBpmL3W3s7Jo9PwfvijB6nvov93UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jof5IJKV1MRD2Zk67sJvXhliYJEs6hBaXGkvUw2BQ8M=;
 b=SyvbWXcWAh56/vnNZgVMP1pVPMkXljtjuptLslYK5J+rF++G/rtBR3T+GuDdEVTT3UC9M+dr4BNg+4hmahYj2FnuqPegbLUpQkXSeiPvy18fah+mDJf+YpsuRZsCwHyVcS/J9hmKiSeGwn+xrGgNeGoCHzdn7PXEl61AobUWoiMDvgIk+KflLES4jPgE0/PoQgMgZ9oo0CBCSIdCb7An64wOiw7CtN4OE1SZq8oGOA2RhTiDfE0JZcie/0uKp+bjBqL+CHEYJAYnQrf6H1lXKCVFKK7z7kL5HSy0ZDBjOvuo5bSLHbi93haQoPDB6b56h5olVrgFF7xHnxcsODMRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jof5IJKV1MRD2Zk67sJvXhliYJEs6hBaXGkvUw2BQ8M=;
 b=TqDuvE2hpsewhUNje/JUAaBzRT+9kivso+hc+g3m5x/gjNhNNUQjJOYP4Rw71qnq/OL8nhJWTKx8gT9Non7Cx8QbF9h2sq8GgiumkHKzpYy7KhOt+KE0Px2gshKH/6ru0AF5MC6MW3VHQ7YG2cgpnWOHb9IDX89+h//tiGMc07xi+54PI7ZHdcuDuRSdY9ET0nrcMoyAjT+ulOg5Z9CEKzXCaGLwtkw6AsXRV/bk7jags6BpxkDaKMrC3kDAGlnyimLMdFPz7GXufjRhrkVFMNslnV5vI2tmNHRGHPDV+L5IdA8VSF094sIR0dhfrjDFMsqn9hLXX/B+NSvNs8ov+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Thu, 23 Oct
 2025 18:57:00 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:57:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/6] perf/imx_ddr: Add i.MX8QM and pmu in DB (system
 interconnects)
Date: Thu, 23 Oct 2025 14:56:40 -0400
Message-Id: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGl6+mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMj3cLc+JSSYl0zA0MTUwugoLF5ihJQcUFRalpmBdig6NjaWgC7MPW
 uWAAAAA==
X-Change-ID: 20251022-qm_dts-60145802537d
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
 Frank Li <Frank.Li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761245814; l=1363;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1tcxwfz9dD8vGhtRjGj9+YP7hB+HJ8BfnOTQF5aBiOk=;
 b=3Qzs2jDAx4alK4tPN4sygwPvcB4cyRChYLwRsvrGN7QQJcdC5iNXhw8UKFHd8MFxCuXVfMrNf
 +vJ8qYdkM/TDlD3x7uEdakxPC+epmMhbb1TxvA3LkkSyRJuSINqPs8R
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
X-MS-Office365-Filtering-Correlation-Id: c59b228c-144e-4302-ad5a-08de1265f21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkxITTFpWlFPYjR2L2hiWjNoZHpzdWVvelNCbUpQRHIwZ0RLVG5wYmU0ajUx?=
 =?utf-8?B?WkgvRWs0OWZ5YlE0aWtCL255S1g3bStSRFFNSlFzVURzOFluNG5zbXVGK2tY?=
 =?utf-8?B?VkppZ3Y0Y29WRktGWHYrNVRySHZhbXRHZittaS9kb3F6NkFyb2VWSXVoMEpG?=
 =?utf-8?B?VkZsZjgvV3BWQnFUSjFiTnhxcUNnYkxpV25oL0RYSUdiWUFySjQ1ZjM5N3Zm?=
 =?utf-8?B?dFh6TngzSkJRMVRGekJkNlp0a3dHaEo0TnlLcndNRjU4SFBKdFBXaitYUmN4?=
 =?utf-8?B?Q0Z1cFJIUTVldjM0NXRid3FYbnhIaUVoWDJYOURGNzZvaVpPMm5mSVZnOHhU?=
 =?utf-8?B?MnNlN0h1a0lCNFZkZ1BaZWp4NWVsOHJkRURybGhza2Zzb2dQT2lTZXJQZ0Mr?=
 =?utf-8?B?b3doZkxVbUd0VU5aVlhNZ3p1S28rNkpzRVpJMUJzeDcwdTJHUFV5REhUMzZ5?=
 =?utf-8?B?QmRTNmVmZUNObHQrLzVQQ0hnTDZyU0lWdE95YUQyZk9rblEySFF5eEpwZlM0?=
 =?utf-8?B?MS9ETzZLVXozZU1mSmZva0t3VGxHbE9IZm00ejZkVnZhZ0RjeitzMER5cnV5?=
 =?utf-8?B?ZjVNV3F3NmlNZTQwcjU4d2pRQmRUcFJDNjhmQzd2dmk3L2s5d2hrK2VvOGNJ?=
 =?utf-8?B?N0JBSW5yeXZYWUNnbTl3NEUrR2ZaWmErWi9SU0s5SzZGcGVJZjVzNWg3QVJ3?=
 =?utf-8?B?Q0VjZ2xIMFQ0dEJXb1grUnVxRTQ1SDNUWmJTWjBUYjcxb3JaZlVlU1pHbmE5?=
 =?utf-8?B?RS90K3JxdnhBUlpNdWM5dy9qbzdUdS8rVVZSYkVyTVVEbUd3U2NibVNtYWNW?=
 =?utf-8?B?bDFwQWZseXJJMmNJaDhJZkVmS0JPbDc0Rk03MFRUcU9wQ0d2L21FVEY0cTZQ?=
 =?utf-8?B?OFBHQ1J6S2wxMm1nS3R5OERXamJpRFltdTZGRFJhWVhETU8wMTdFb1AzRFpr?=
 =?utf-8?B?SkdOUmtqVThxZU1tcEVDSjlXUkRyTm9icExzNDlzbUMvMTNhbUJza2N2a21P?=
 =?utf-8?B?bEJIQUJZWStZV1QvN0NrVWRiOGZjN3hxUllnWllzc1hib0NRRDMrOFNEZVRN?=
 =?utf-8?B?Z1cza1hWS1dQMnFrN3dqdFR0cWVWSzZWZ1hJKy9YTHBSYWdZNVp2YnlqVzE0?=
 =?utf-8?B?aDBzU2tPMW5MRTBFVUMyVFhZY0FQd3VPak0rN2d6dmh4RlVka1hPQnY2VWJr?=
 =?utf-8?B?cDdlY3BvR3JFMFA0OEJvbjRQZlE2RFNuWjRpcXZEWWNMM2FSaUxZZXY3NXBt?=
 =?utf-8?B?dWd6a1BsOFpHZFJXUGVtOEVhUUhzVStPbVU4SDdvdVp0MlFQbDVTN1dzTWVG?=
 =?utf-8?B?ZWloZXJBaTBCSDlaY1ZGbzVQdDVHaVc5ZVdybHZSTVZmQXAybzFBcm8rbkNP?=
 =?utf-8?B?enhiZEZTdDBFVWcvTFRaUGtKcnF6dXBMb2JKaW96eXduVlZ3ODg0VVkrMlNV?=
 =?utf-8?B?NDhBREN2QWFkcTc3Z3hEUnpVemY5YjZ6Ykk0M0lvR1V3U3BYRWU2OWR4OVhG?=
 =?utf-8?B?NFZDblEyMC9nRU5iOHJtd1l5NHg1OEdPMzlCQlFEUVhwdkp1UEhidzZtU1Jo?=
 =?utf-8?B?WlFPNHJmRHI3QjdiSWRjK09NNzdXSkZOcEVQbzRxa2tLVWxabUkwSmNzOHJo?=
 =?utf-8?B?aE9EZFlSR3RwQktGK0V2RVdYS1RRZTlZUC9nd1FBdGtJSlQyUXVqd0E4cE1v?=
 =?utf-8?B?Qzk3cXJwOFBmbWFCT3BNbnBRajNhcFBmZmFnOGVMT1VCVEJud2tWYWZnOTI2?=
 =?utf-8?B?cGcrcTA5UUZJb2tEOGMvOXNyTHlXTG5hRzRjWE85VHFYTDdIMFUwaHNxakNT?=
 =?utf-8?B?bjdtNC9aZUdGcXBHby9FSXhXNXBBOVVSQXJWVTVraEFmVWxVYVE2WUJTWS9t?=
 =?utf-8?B?c0JiRkU0a3hBNUlPQittaTJ5Zzl3dVpOYjJ1RWxRSytCd09PVnVpYVdrY0Rv?=
 =?utf-8?B?U1Z3UU1UbE1hSEI0V3gvWllWYW1kL3d0QmtCeHVFR1ducmJ2Z2Z4bkR0WStZ?=
 =?utf-8?B?ckhIUnFuajF0ZlNRZ0FXa1ZrckU5MGRsbjN5WE5ySUFBb1kwMkFKcjdqNDdF?=
 =?utf-8?B?STNYeTZJTk5FNDJQNEdGMnR5UjhBWURSVGx1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmMvRjF6ZmFYZWpKSlJSMU0zUkZyY0k0OHVFVGhIbFpxcml3THdPcHVCc0dO?=
 =?utf-8?B?UHl0dFNFRGFnUnVia1Qwb1c0T2NjeGlLRDA0Nm1WSWxheDFDZDF3NmZsR0Ew?=
 =?utf-8?B?V29LYVJUSVFkVGpEMWNoOXhlWGd2YmhlZ1hhMG8yeEFXQU82a3NEODNwVm5a?=
 =?utf-8?B?RmE3d1JxZzRjWVA4aWpnNFFQb1M2YjBZeFZ6dXQyZmNmYVJPc1FVZDZFT2lC?=
 =?utf-8?B?aXVRWS9EMS9JY3g0U2NQK2w2MDhSdjViRWpOblUvNHhWQTdrVHl2ZzhHV0xP?=
 =?utf-8?B?V0pHUzlLL1RkdllHdnplSmV2akE3UWRGallWRWMrWWl5YUhVeUd1Z3VDWDdn?=
 =?utf-8?B?ZFNheGNZOExycGFvNllRaHh2OWdIWW1RMkY5dGpLRUxmYU1yY09kMEY5ajJr?=
 =?utf-8?B?ZnptNUdVVWdzWmxNWFRBL0U4Ly9JQzNNeFdpdEZYMDBNSTBKRk1DN2tpZlhP?=
 =?utf-8?B?ejQzWFZlZmRWLzRrOTYxeTBEeFNLNjE2ZUdzR2NvUjVOdnV1bVJsTmVIM0ds?=
 =?utf-8?B?YXVZam9ublova0FwVUdiUCs4dnpqY2E0U05YNXZFMlQrSjljZDhDSXlwWGdU?=
 =?utf-8?B?K3NaT2paaXZ3S1RQYVJ6elZkeFFNSE9iczY2cEIvMEgyNGJDeS9neGcyM3Bo?=
 =?utf-8?B?RUxUZUpNQzdlUlJVdTRGTjFRSC90dTVLMGl6TEM3LzNwaG9oeVV3V3hZbjJn?=
 =?utf-8?B?cytwWStLMDA5RGJENEhlSlZVd09lUWhHUy94RkNRYzZYMWhuSElxd0M0cGNm?=
 =?utf-8?B?K0ovTnJsK3UvSVFqRVp1MktuWW5HK0dHUHpiekZrZUVKMzRLZFZUbUlFeWNm?=
 =?utf-8?B?VC84dWtOOGt1UlBhT3pnL2JlRXdDb0lFZHpkV2ROakJJUkIycjBJTWowcVZ2?=
 =?utf-8?B?c28wUUdqaHE3a3pDWlp5aVIvVVRwTTNpZTZlSCtIZnMvb0NNa0FrZitZbU5G?=
 =?utf-8?B?RFArUDR3dnhiMS9GMXprUTFqYlhtQkxDeTkvMVRFUzBuSW5uY1F1empLelFC?=
 =?utf-8?B?cG9BTDFudkhWVXpLVmx3TU1aVnBrTjFqQXpEM2lNK29iMjdTMGIwRHFBRmZq?=
 =?utf-8?B?SW9VWkNXZEJMYy9rcUI4blNYWWgzd1lmb3p5RExyRjRaRFgzaHIzbHZnTkIy?=
 =?utf-8?B?ZjdSa1FZMVNPQlV5T01SdnVqOUhkNndUMkVWSUhzTWM0RG5aRTd3SURsTWZE?=
 =?utf-8?B?TnNVNnBuOGloYWNZd0JFK2R2MGNXOExCbm5JR3NUM3lDdnI1ZmNVOGd5V2ow?=
 =?utf-8?B?K1Q3U2F3WUdtS3RTYlZNMHQ5WmJ4VjRQZERKdDIrVkVaWFg5SXZUWGlZTGV2?=
 =?utf-8?B?SDZLbG9ZQ0VNbGM5eXlLbXdkS1Jic3R5VUs2Y1laV1dHd2h6ZkU3TTVjbXh2?=
 =?utf-8?B?MnJzWm9YSmduTzRNK0IxS1MvUDNpelNTZlJ4QXVUQnMvTjVNTjltOThTa2xh?=
 =?utf-8?B?N3B1aS94R1lES25uTFVOVW5CSGxFRkpTSzlKMTR0OCt3NlFta0NJSENXTGxR?=
 =?utf-8?B?eFg0UUVpUkM0R0Ywa1JBUWdPYk00NkJDRTVsNldwemlPNDhPYWc0UHArVGlW?=
 =?utf-8?B?VU5OdEdieDJDTk14ZjUxbHUwbmNsUElzNm5qckk2NWFxZ1l5REJ1eGhNWFBv?=
 =?utf-8?B?SUxNNnVzVUFQUkdERUI2SGNFTEIzd2JLZDVXelBSN2k3clZSOWcrd21MTzZ1?=
 =?utf-8?B?WE53b1VidWdKdGpDeVhsclo4NTkxcDJjL0Z3OVA2UlFTMllVZGdRS0pCM0Uv?=
 =?utf-8?B?dkRHODBOcE0ySzR0aUkyLzFJbUF1aDhYRkhqZ2Z2L0hEWnhwVXlBcEVsQ3NO?=
 =?utf-8?B?azJGTUlablZNVHJCUTJwalFlZmhJSlNIWGp1TmlVMExQV2FiakVhZ1R3UW1C?=
 =?utf-8?B?M2MrUUdOWlE4cW5WeG1MYlRsdThpUlF3WHZ3Yml5Wkt5QlRTQi90cU1UalBI?=
 =?utf-8?B?V210cGkvSjVYRXJPNWpraTIyRDFSN25lV3JjcUlKZjJkdHZ2VjUxYlpjM3VX?=
 =?utf-8?B?VElnUzhFdW1Fb3RKTGpsdi9leGlYWHVxdUQyMk0zRTlEME1WWElKK0RUWUcz?=
 =?utf-8?B?dmI3c1NkWlViWEVkWkNxeSttcTVjM1d1Qmh4bjBDdE55c21TWm92M2lVUDVr?=
 =?utf-8?Q?cE+ViOdZfyzP6y5DkRgdzvrQW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59b228c-144e-4302-ad5a-08de1265f21d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:57:00.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDa/XeXJlxHIWfAsXDlcyynRQ9jyoqXrzBFHmbzd46bVhsNtV/TSaMPNtUOS0iqGOpImS8LVTOAYPG4LxfE4jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

dts: add soc specific compatible string for imx8qm, imx8qxp, imx8dxl in db.
driver:
 - did some cleanup
 - add support for pmu in imx8dxl DB
binding:
 - add compatible string for imx8qm, imx8qxp, imx8dxl in db

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      dt-bindings: perf: fsl-imx-ddr: Add compatible string for i.MX8QM, i.MX8QXP and i.MX8DXL
      perf/imx_ddr: Move ida_alloc() from ddr_perf_init() to ddr_perf_probe()
      perf/imx_ddr: Get and enable optional clks
      arm64: dts: imx8qm: add ddr perf device node

Jacky Bai (1):
      arm64: dts: imx8dxl-ss-ddr: Add DB (system interconnects) pmu support for i.MX8DXL

Joakim Zhang (1):
      perf/imx_ddr: Add support for PMU in DB (system interconnects)

 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 26 +++++++
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi  | 30 +++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi   | 19 +++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  2 +
 drivers/perf/fsl_imx8_ddr_perf.c                   | 91 ++++++++++++++++++----
 6 files changed, 152 insertions(+), 18 deletions(-)
---
base-commit: c31b21db1c04ba719c3889a57873f0f7eff54670
change-id: 20251022-qm_dts-60145802537d

Best regards,
--
Frank Li <Frank.Li@nxp.com>

