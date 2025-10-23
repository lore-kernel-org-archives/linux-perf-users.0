Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BED34CFB0;
	Thu, 23 Oct 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245836; cv=fail; b=cr5HLJ5hGvX0m/32BBeRz7jrfLGZ7vlpys3QONsYjyn0ajl3oqp++zBk7LlE6Ag9q8u+qXbhd2/XK3hb0XNExe1wSMNHmzd01VAtHA2Rn+cCo0VwZJIj3aFWdPa5yfScpL/JE9sS+p0b/rXB3mWFrUCc0jEIvqR/b9BJsXnOEjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245836; c=relaxed/simple;
	bh=r8swxstYdfH7JP13mlqRiDOFoi7eOmtRK0Mk1iqdXPo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qJBz7RAaUzMuUhFiqfqbsZj0H2cxm4wmniCUHfPgoeMI6QVYSvqY94xg5TnhLD5oScd0E8TDfuADy7D2MGE8dAH9wsb1iOV8FE0d+6kMtYDRGY7OPXoIpnIztY3T20jUOd+TGkRI8aniOPcAc1Bukpygd7Y5i/AUfoQumm8rQ0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PErIhkKt; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PErIhkKt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiRSZ9sedOQXgJeuhJvLnNIiGscZSEG0BLvGclEMAWndDAFy5Wn+hjkNFLea6iMmqA9gg2g3JicrqWaLbqBRrJBU3izj7eXkuVCSmkGoF3GlmUq4DGaeg3XIFdTQL/G8xLZIXQWlQmXhuXKegaT0oH/3XM1W3eeEIFwfShm5F+1aUzcoMAI/zhr+Au4FkBIKV+Qh6neZgeaIZ0oXL6wguDobtbgpJxbOFLueR4buf7Fl9Q4V6iSVL5jL80xFOhAGRGV9LrMiP1nSkQvTwnzqe13TPogOoSiV1cqDUw0JGbytWLW86ejO2HOJfLH57U3MqTZ/sHWLefUxjMsVBbCL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NAfJqXK6yR1bKhacRp2sfn8rR8lZKGyMVv+Hs+tgPE=;
 b=xLFLXWbwffYaqqhQkEMoCV8uzQGKH3gwfE+ik4B1nTtFBVGEF/vqliZFgN7SL6WrC/j7qm0FpUqX6/GqMaT+begwpBM+957yfy9NiAebJAUllfV19RZ0cMR1zV+jDTaxHL7aej3koWcOAebfD/DF7Z0RBt+xvDGtHJZxOYH1Ogp3wVYUHX8LAnSBNRCECpULgDYNwRKpS2SEADp2gh7kLleme0K294VJ0UWBrlE6k+/Hi9lcaxcrxq1o/fUg9eiBeG6q8y8OBlA13F/HJDNBBzj4VFP8ABxtuikqI1xljImyjnDP1K9VOw+cKQKAvp8ahfbfXi5RcLY2yzG8sabkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NAfJqXK6yR1bKhacRp2sfn8rR8lZKGyMVv+Hs+tgPE=;
 b=PErIhkKtWLn/lowQgBiAKYiIHq+lEEg340dz6SGZz+gkBiPQeYI9vBfolckf3IpEoCRzaEkQ7mlK11yoSUH0NUb6xOGWQ0L/Q5QA4W1BlrXNwTeBM1iBYlWgSZjlM1gykY6l2zgAWQ/AwlsLGsiB13afMhjngIy8MeOWVe09+fJZUiT/Q2nXiFJ2rhI6XRvkGRfBfS43QBMfgFfmjNWw2OhBXZaovrJ/JJUsYjWwkleSp6lzOr/bhoKJ5+aQ8h8Dui7mTZSFno3QiVSmQa5K8M9rNGP1ovQixlQO6w07YSH4XJob2HCB2drmgcmQl9+NXMWVMI+lrmPkXpkjqrlHmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Thu, 23 Oct
 2025 18:57:10 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:57:10 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 23 Oct 2025 14:56:42 -0400
Subject: [PATCH 2/6] perf/imx_ddr: Move ida_alloc() from ddr_perf_init() to
 ddr_perf_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-qm_dts-v1-2-9830d6a45939@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761245815; l=2517;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r8swxstYdfH7JP13mlqRiDOFoi7eOmtRK0Mk1iqdXPo=;
 b=TXUTUjRHK5CB/Q0X5C5VBg0LWuHz8fyxYHrNL3p0R/10smf9ODe39X9nSSoRw3qERTNVvEnnE
 CxGAvnNpCriAizDj+KewFABZATGoiPljuiOT7iFDxFYGQyOGjdnmEds
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
X-MS-Office365-Filtering-Correlation-Id: 927c895e-f420-47ab-b0ea-08de1265f83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnJUeXFnalNRazlyakVaNUJuVGJ2TUVFcjA3NmE0VlVyRGFtbzlVZXEyNkxD?=
 =?utf-8?B?UlNkQTZOVWRNKzRtUUtPRnVzV01OVkN4TStHa1lFZVFhd29vRFgyQkJEMFF4?=
 =?utf-8?B?MVI0OEV6RlU0SXRJWDJqR243Tm4rWXkvMmR2L0d4SzNzeFE4WDk3ZFNuN3dn?=
 =?utf-8?B?b3pZN2d0dW1zWjg3bi85bTNMLzF0akxWMWtDVkFTblFMOWYzYk5rTlF5djIw?=
 =?utf-8?B?OUNDbmdJTUVIQWpIU2MrMm5LSjFzbG4rSmNhVEZPbjRvOFNqVHVvdTY2NFJU?=
 =?utf-8?B?ZEEwQkpRaGdsdHA2eWFoT29EWVM1S0NTNURkL3p4bmRFTHl0Y1ZjSWpHeXUv?=
 =?utf-8?B?MGRMcEk5M3UxYVZ2UDRtdlVFd21zV2hCOTNKRWFNNFZrS2xNRjhyTTNjTS96?=
 =?utf-8?B?bXRMSW1pZFd5cjlhYXd0KzdiQUZOalMwTUU0TkpBaTZxMGdScWpQR05jdVEw?=
 =?utf-8?B?T0ZEZGNjc2lsdDg2ZTRZYTZDZnQ3OVU1WWozNTcreHR0V3VIem1KcURWNW5Q?=
 =?utf-8?B?eW5PcjA3YkhRUjJEdW5WZGRxZGpWdW1TdUxmOCtvS3Yvam5wbC9EZ0VRYkZn?=
 =?utf-8?B?K0dwT3dYc3BqQWk5UEE2ZVZMSnl0aWZCc253alBxV1VCcWo2aWc1M25kOStW?=
 =?utf-8?B?NzRYQjQzdFY0dG5mN1FPb1drNmJNL3BMay9Wbi9TVFBabTlvbkp5YXYxOE45?=
 =?utf-8?B?RWNUbmVNTGw4SmFJN2t4dkE0dUdzRnFLWXoxU2Zrc1JMK3FxdkFUOTl4MVY0?=
 =?utf-8?B?K1hGOWtFdzdVTmlGR0orT0l1S1lxU09WN3VQRTdWK1AzVVZ6dFk5c3h4bXl6?=
 =?utf-8?B?NHhST1YyRFIyQXY1eHVZanRQQ3FaVjdLVWtYankyYXJyWi9iRUxDejc5WFFD?=
 =?utf-8?B?MTduei8rc25IdDlCZ1Iyd3krSnZUSnYvekxNSmU4WnRRdGZBY0VWeHlwWFNV?=
 =?utf-8?B?N05lVmNZUUoyOFVLRk9TNXVCeVE5OXBBUlVZMHBxOC9neHExOWlTdWx3MjRy?=
 =?utf-8?B?VXZHMEtpZnZnbGlDLzJkb3BTOVVvN1RmUXc4WnJycFN6VWRrV3VvaVk2STdQ?=
 =?utf-8?B?eEF5aWp6WFc2UEh6ZW1Rb0hOemVXam1uWDlPTW02VUQrY3F6TzkxK0M5dFpo?=
 =?utf-8?B?SkhQSGtHYUdWMlhYNVBlWkpzNXlYeTZVUE9sTkpxUkpkd3ErQ1VuSzRTcjRC?=
 =?utf-8?B?cjN2YXVVU2FjeFIwWU1QVnZoSHlCSkFjbGhhcmdtZTZhWi9TbW1Vb1F3Y3JJ?=
 =?utf-8?B?T0dicVYrenJJYU80RFQ0ZlE5OFh5VnBPR1RKZzhzdkRNazlIZ3hxNlhCcnh5?=
 =?utf-8?B?RnNPM3dPdzJjbE9laFhFb0VFZ2dFRTBxbkk2Q1FzamZ4MlZwWUhEOXZNVGd3?=
 =?utf-8?B?RnFZK3g3MTZGMmxpNjRob3g4NE1MVkZ2d0FPamtMZUdjZHpMaEpwbzY0V2hL?=
 =?utf-8?B?QzB2T1dFZlc2T1JEY2d4ZDRqaVIwNVducThEVVF0czM2amJUODNIbGhJNWg3?=
 =?utf-8?B?cGJsTm1RSWxzbHA3eVgxS3czTkhFUi9sRlZMNmRZUmtlYmo2Y2dUSHNBSDRM?=
 =?utf-8?B?YVJKcTRqSWNoTlNIcDUzdjVKUlVYVlBsN3U3R2FDMXBwcU9LNUhHTEowdzFK?=
 =?utf-8?B?VEJ4NU5scW9ZaWtwdE5HSUZkT1dzUUZVT0hBdUxzdkhsTzN2Sk5HUks3a20x?=
 =?utf-8?B?NUM0OFdza2FSWjlvVjJxaDFlQkxRZE01RkZBWG13bUtOM1BGRWVxN3krcjhh?=
 =?utf-8?B?Uk82YkJmYVdPL2lheWozZXdFYS9heE5DakdlRzZwT3pFVGJJNkJSaEpmNUQz?=
 =?utf-8?B?WTRDajBvdTE5cUpZRnZVR1pzN0ZveG9zOEpTbDlxUEU1NFdBaURHb05sSWt6?=
 =?utf-8?B?cTJWeVg3K2UrY0hXeStsbnBuOHN2c2gyUlY1R01NRlhuekpNcVFqY3VKRmsr?=
 =?utf-8?B?d2hqRDFBUmVJSnFrSXBkU21wR2F2d3pIcnU0VXk0Y1FIOCtTRUFua3YwM09W?=
 =?utf-8?B?a1o1NkNWU1Y5NzRMRlhuWnNTTU5EckwxMW5oNVlMVDBEcVk4UDJkSlFJZUJS?=
 =?utf-8?B?VnVPRWFsZGw4d2xkeHpNeHVxUkpIaDFkS0RGUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnJhUGRKMWMvWGxIR0lLNWp4YXhpeEViT0RvSG02dkZwUzZ2VXRMeklHV25H?=
 =?utf-8?B?YUdQVklrLy9hdlllTldsdzRVNVZ6d0NQMnRBbk0rODIraWZDVW8vNVdDckNy?=
 =?utf-8?B?MzdVSk9EU2lhWTZvYWZGU3l2VWZsUGVXMVlsQ29TZ3BrUzhDMG1QV3pDNG95?=
 =?utf-8?B?aTVxVy84dlFVN2pUR1l3dmtTU0d5aERBYVZ0TlRMMDA4cmNzTEtUeFJKaWpI?=
 =?utf-8?B?MnQrTWRjb3Y3Si9iRllSSFpLYTg3Z3JaQ3p5blBRTS9qTHI1N3NrMzc3bnp2?=
 =?utf-8?B?bktkV2N5SjlsZ0RoNVZkWnlSSUhJMzArM2laSGtlQjRZcWRjYUtoWUpUY3k3?=
 =?utf-8?B?SkhOSFY1Z1lGdCt2YXR3aitkc2dFSjNsYjU1V2dTeTJ2RlhWNUFBZHRtM0VD?=
 =?utf-8?B?bzI3MS9xdTdVNjVEL2FUVDJZQXBBZGxBM3NCWi94Qy9lUW1HUUxER2trUGxr?=
 =?utf-8?B?YjBRS0Z3REpnd2x5Ti9YeW9yYnVQNnJnUTc0L0ZVTmpCbnVWSVBDd0RReEZz?=
 =?utf-8?B?anc4cWV4OTA4aFdqYXNubnNHNlNQWnRRUDlaaEF3MVgvUmF1MGtUSkFTSXgx?=
 =?utf-8?B?VGZDMm1TWGJzV1ZTdU9YZTR3VjkvSHI2ekI5MUxzd1R6dWNZd09FR1pkK1I4?=
 =?utf-8?B?L0FGWWFRT2FTOVpZT1QvNUZwbDdWOG5jQ0ZxR3FOY3ZZTDA0RmtJRVFBanJS?=
 =?utf-8?B?dFVCNkFsVGk2TXRLaTZ4ekVYaXR3M3lMSmQwTjZ1cUFmVis3bEo2QzVmbkg0?=
 =?utf-8?B?anhldUxxREExNXlvZ0lzWFpMUVJscnZYcmw4dGxNaGE1cVd4U3BQdlM2cEtX?=
 =?utf-8?B?RVNIWFZRM3F5RG9jSEJrbG51ckpGK01xeXZmZzcxOUo4a1FRUGh0WGR5aW54?=
 =?utf-8?B?cHlxUUxBVUF5MUsrd1hSRElDcWpSbGZZSGRBVWZhbjVNMzhPOHBKakNUV0Jy?=
 =?utf-8?B?VVJkdHRZSUxJQksyTjFVaUZRTTArckxhbFc3L0lqb2MxeWJxcGJHRklwZmov?=
 =?utf-8?B?eXllT0FuSExTaVpiTjczdjZncmZUb1RSNS92NzhNbWFDbmdQOXBuc0ZNSlFy?=
 =?utf-8?B?V2dSN09oeHU0V3Q4MEl3SEtwejV5WnE1cFNnMjdTbVlkRUNLdjl6Q1Zyam9P?=
 =?utf-8?B?ODJjMEQzYU5CSlhVL3YweWR2dFFLMmNDemp0T1JiMkpaS2VKZ09Bam55bFNI?=
 =?utf-8?B?ZUZRa2VOZ3plWXhUbzl3ZjBOS1JIdlJUN1V5Z3B1TXVadjdtRFc3Q2p0VnJL?=
 =?utf-8?B?Wmxkclg0UE9PeEk0ZVJGTDVWSDVTRWlGcTlNZnZnMVhuZTBLZnBRZGl6NktV?=
 =?utf-8?B?R1R0SytjNlVWbUo3dHJmM3N2dXduSmFCNHVuZDFBMXgzV24xQ1RjNDdibHI0?=
 =?utf-8?B?WGVxYUs0cG1CMGNucGFuVXZHcnFNa29uQzRDQnVSei92Q1FzK3R5N0wydEc5?=
 =?utf-8?B?cTNvVUdEZDVJdGEvd05ZQjV3czlKSVF3bEhiRFNIaWEzd2FhTGVnVitSZGx2?=
 =?utf-8?B?YmRHUzByU2NON2VYRy9HS3Y2SHhQejBNa2ZML3RhZzVxTE10ZTNuRG15aG9W?=
 =?utf-8?B?c0h0RGdZNG1NNnhKeG1Wbk02UTROdXpSUU5yeGlLYWhTWXRoL1ZsSDNVVEs4?=
 =?utf-8?B?VlFxaDdaQy9qaUJxa2JUL1VkQTZyVFdZd0daQVlCMVhqQnhoaGZxV21OTUtq?=
 =?utf-8?B?RDJ0cVAydWFFUWhHRlNPclJiYzl6dW9oRWVpalJUUWpzbzYzN05YNG9XcGFi?=
 =?utf-8?B?WVFIbWthZGZ3VzlKQjNjUUJiU3ZQMFVUWUFrOXJnLzgxalIyWmlDS1FSOFFF?=
 =?utf-8?B?V3VXdElrcGxQWFZ2UkJ1cWxqQUF4TWVkSHZ3akw2emN2UVJpblpIWlc3S1A3?=
 =?utf-8?B?S3BDK0JpaDNsVDByU2NaUk4xL1VYNGd1RjlleW5JUXNzQzhvYWZtRzZ3eDRF?=
 =?utf-8?B?NWNaRTNvdzFDTzZ5amJWVit0NHpTWlYvK1pwRzlGZzZFU2hsK01ETDF5MHB2?=
 =?utf-8?B?WU1EZXBZZzVRYjdmczNKTkswNkxwK000ejNnWjFoOXRWdDZyYk1HWUROdHZT?=
 =?utf-8?B?c1VHWkVTeEd0NytPcGlSL2pkOExURkplbnBaWjVxL09YMGprRk9NQ3YyZW5h?=
 =?utf-8?Q?76yGr9HDpC2X7U/91wKQtfczh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927c895e-f420-47ab-b0ea-08de1265f83b
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:57:10.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RS0TEqewlcfqDnvCt1nVVVnYhpqV5dd6DaCCkQ+RV2tiHDgu8O0QQwXIizun4gMeZXFLRs4O7vwSnAxvM71Iqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

Move ida_alloc() from helper ddr_perf_init() into ddr_perf_probe() to
clarify why ida_free() must be called at the error path.

Add return value check for ida_alloc().

Rename label 'cpuhp_state_err' to 'idr_free' to make the code clearer,
since two error paths now jump to this label.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index b989ffa95d692fce2d42eec08fbc70520c21b8e1..5ba34c606213d255edf27081bb9f63763cca3066 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -645,8 +645,8 @@ static void ddr_perf_pmu_disable(struct pmu *pmu)
 {
 }
 
-static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
-			 struct device *dev)
+static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
+			  struct device *dev)
 {
 	*pmu = (struct ddr_pmu) {
 		.pmu = (struct pmu) {
@@ -667,9 +667,6 @@ static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 		.base = base,
 		.dev = dev,
 	};
-
-	pmu->id = ida_alloc(&ddr_ida, GFP_KERNEL);
-	return pmu->id;
 }
 
 static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
@@ -753,15 +750,21 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (!pmu)
 		return -ENOMEM;
 
-	num = ddr_perf_init(pmu, base, &pdev->dev);
+	ddr_perf_init(pmu, base, &pdev->dev);
 
 	platform_set_drvdata(pdev, pmu);
 
+	num = ida_alloc(&ddr_ida, GFP_KERNEL);
+	if (num < 0)
+		return num;
+
+	pmu->id = num;
+
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d",
 			      num);
 	if (!name) {
 		ret = -ENOMEM;
-		goto cpuhp_state_err;
+		goto idr_free;
 	}
 
 	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
@@ -774,7 +777,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
-		goto cpuhp_state_err;
+		goto idr_free;
 	}
 
 	pmu->cpuhp_state = ret;
@@ -821,7 +824,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 cpuhp_instance_err:
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
-cpuhp_state_err:
+idr_free:
 	ida_free(&ddr_ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;

-- 
2.34.1

