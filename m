Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC1348469;
	Fri, 24 Oct 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329878; cv=fail; b=Z3qAySBfJXi2/ihMUWeZc4DCfOVU6g0jpOOyKcAQyrDnPlD7iBITBXkROFnQxpQ/wZMcUrna5MpMP2aI4oP9brYK7sN4F0y/KM0bIeqWm5OpkTinqIzr8MASLQ0DgW7XsSgkFxX9QlUGXpMx/3l+xLIcTSpTjvigybK1DggiKnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329878; c=relaxed/simple;
	bh=lL3PHbQB9BliLrPOwqyoxNzEa2Xr3lLa2ZMWIrSgXbo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IFOOH2iqm4eN9lZZQ3piqA9JXDniuXTK0CUj6jdcrPPvDkdqzrbibHYTLcK1fPBitc0v7313fY8V+coJKB1bEA/7szf+WpUacicNhw2neLvXLpgk6yBUpckf+JCJK4ONK3/I5lr8a6A/FzCNynFuvyRM5FCwWOzBC3vvKwusf18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OTzN2EnD; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTzN2EnD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQPH/Bk5/Ox0XBLSGLC872c6+SpEkpJmi/b8SiHqxy4FKocS6IZkHqaZq3rizV8D6BfG9ABrsaxLSdZUnWQuc5D5qJZFSYhgLv2C2gTK8IHNWqhdwArVtwNHawVXzzdSO3f76SeGx+26ov0nxOcWJ301tdJGE8pwMjA6whPLoWujFmaypreJsvWs8tXPHfTibh/9lQUHBEgHJOg7tdsoPkI6sUe38F8Y0wm3LiEWmT7Akohv0aO0JOllsIRo95zEMRvus9/k2aEZbjCCjqtf5mEjIHxsds6IfREnmouN1Q6/YhODxh/O0m/xud6WE04mhulQIX4BzNOqkhrW84vN4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgowNT4jGBUzcmPNcJ06gqG0j872POtXYzkSObd50OY=;
 b=XZon4qLb0BtXA05B9MUm6f/6RVfPzviwMEbR3Yg9apnkzI2AwkevX35O8g7ZrgRYH4clmnybb9Ff2vWrR4iIoZF6Pv4dcWw9iBpPU+cHNyo515x7/0yp0R8u946u9ag4tCl3uzPwnyLSksbLPHD+vDB5fARq142y/3PRWJEzksA6gGAis0ksEbnwYWIAm1xEXkrQvK3opa/Z53woj46Fs7Tlr4OEKqbSEACY3QL3nX4DNg4yhw98wIC3m0+2/rSw/wdBVhr1upvn5qe2+3ywWvLMvFReMKlVXKM50Wxx7BvrHyn+Aoi3/oLDTSguSNV+HDEreguzA5IncOhnsZ0Yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgowNT4jGBUzcmPNcJ06gqG0j872POtXYzkSObd50OY=;
 b=OTzN2EnDJeMnIIANG3wnCOjCnYxjNP4NaFHINfGxWa/lwky+9s+eRIB3yrLATDVVyBGzaXtgEd2hUwwnw5VqFg2vm2IF/ZeMzAJu1FtcVmiGX29lLsMoXeTmE/FI6GRz7h5CtxH1u8eBLVXudolTrAdiapbsjNkW0RSfkX9UUSEsjYvC2Zgh2XiOtCuDNcxWo/u7XLIip3A97Y1TEZs51wfSZERipq9Yqd6ECCKqoADLphZ2yh7cT9mOtmkCAM0uoPgZY5uxJVR31WvWPaYDqfazDkeQ3UU7HwYGTcgIq4bN2oGiJ0p2Z01hAVaQEoLgl+0rZxXqaXPxMosIAw1ong==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:17:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:17:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 24 Oct 2025 14:17:15 -0400
Subject: [PATCH v2 5/6] arm64: dts: imx8qm: add ddr perf device node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-qm_dts-v2-5-7a7e07022ed6@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761329844; l=2726;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lL3PHbQB9BliLrPOwqyoxNzEa2Xr3lLa2ZMWIrSgXbo=;
 b=vEJAf1CAmqb11f9zMMd6YM6m2SnZLtV14yhYamVJsk6oLpWmNWpEhGZVn4DVmqXmrBADLcPok
 qVZONwIOsH6BgTDDfgTnXUf1S3saPXkv10sEYlRY6kppNaG/iOejdun
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
X-MS-Office365-Filtering-Correlation-Id: 107f9b70-85f5-4838-f186-08de1329a5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ektaOTRRVnMzMlQzcTByMlhOUHRIeFl3Ny9qMTdSeUtGdUlhR3cxZGZXWFlJ?=
 =?utf-8?B?bTJ5R1pzVFk2VFdhNy9qam1GQitEWjVxTFVlN2VMQlArVHJQWGh5VVVVQk1H?=
 =?utf-8?B?UEpnL3g4a25vT0xRMWRmeGkrU2RLcCt2OW42UmYzeE9CekhuUk5wL2xLN0Zn?=
 =?utf-8?B?V2ZUU1FPZmIzUm1MOENqSFNEeWtzbWo2WUVTWU82UUpMNWhldGdSaTJ3eGlC?=
 =?utf-8?B?aERvbXpEczV2c2doWkh0M3NOc1Z3NGg1a2MvbUcyZ2ZDQmx0U1RUUkFOV1VN?=
 =?utf-8?B?dHZGYlN5Z2hTRjAyTE5reFJTNEcwaGQxUUlNd043ZVg5REtUaE5XdHdDd3BW?=
 =?utf-8?B?WFBYZEhldElQbTNkMzJ1dEpxQmpqcVNGZVp1YXRJRDJRcHdudC9FcE9ZQ2hX?=
 =?utf-8?B?K2QrdVp4NStTck5SaFVtWWJ2M29zTXRuRGh5UG1hcG1ZQVJwSG01elpVdXhw?=
 =?utf-8?B?UzZPMktjTmFnQ0RzZk5sOG1kOUcrS2E4NzFqU0ZyTk1UYWJjYzlLSUlVVTlE?=
 =?utf-8?B?bWhUdnMrd3NJNzJqcVhIRXhNOFd6RmNCWEFTcUpOb1ZiVHU3a1RLQS8vdG5w?=
 =?utf-8?B?U3VTRnNzbUs0anhWQjdYVGVacWN1Q0U1TytTREJUWVpUODQwdUIxaDk0Z0VZ?=
 =?utf-8?B?Q3dKVEYxUzhmMnBLZ2U4NGlvU2RrOC8xYmUxQmpKQVl1a2I1cmxzOEdZY3pN?=
 =?utf-8?B?TVdJdmMzV3FJK3lwSzVNWGMyeXpaUEp1bFp6aVZwRE5NTDdzcXpzMjRzMURu?=
 =?utf-8?B?REN1SFhOQmhoalBKdFZqMFhVbGplMGtLM1h1RVIwL3ZEcUZWZUlSc0xEbHlC?=
 =?utf-8?B?UnJUY2MzK2VqaXpIMHV6T3RZMzVGQndlZTEyRkxVamJNMUMwcGFrSlc1dzNa?=
 =?utf-8?B?WlBnaDZlQkVJVGZSR3BaOTZKUEF0TEl2eldZUjB3UG5DTXhTWW1aVEs1YzlQ?=
 =?utf-8?B?T29MTFZiUDVRZ3l3M3EvTXdJWVM5TGppeVJqVXZ1bUJGU1Rpd0hmNWlsMnhr?=
 =?utf-8?B?MUYzanBIeW04U3owUHZoV0hOUnI4K2E4ZXd2MTJMNWNleGNZNTFFSXg5Tjkw?=
 =?utf-8?B?cHdhZCtVdXNQcHA0QTcyUEdrTWhrbDVHR0ZZbjI5cyt1RUdtTlJPRGJvck9z?=
 =?utf-8?B?anAzaFBDRjZLY21aM3lha05XRFF1b0QrSitRUFVIaDM4Y2lpc0szaVM3VDNR?=
 =?utf-8?B?T2J5WTlzWGM2YlkxVm9jNjlPd0VpQmdyMnp4UmliRCs5eno1NjRQNVAxNWll?=
 =?utf-8?B?cnNmUkJqQWd3RFBEMUhSTldMMGVtNGwyclljKzJhcFhzOEVXeEhLRjZGWVRo?=
 =?utf-8?B?bzhKeEZiUXJiVStSWHVsN1hmTGxrcFkzWkRDbWNRbFk1ZVRMaVVVQTNQU0Yw?=
 =?utf-8?B?SVRJOCs1N0l0Y2JueUo1dlpjMWdLOXhiZGpuTDk3VDBLSmlwNndkblQrVkxS?=
 =?utf-8?B?M1VjZzVnazBVLzlkLzhSSUNCdmVyKzBUWTFwbjROR0JIcnN2UE4wRTYwa212?=
 =?utf-8?B?b1J2V3JJdWx2RXNLRmZoZCt1bU9kemVVUDNjcSt6Z1I5UzVvVHBkRzNNMURi?=
 =?utf-8?B?aEZVVVBhWXJ6eWJaV2hmdkg4NUhUUFRVZDVjbnFsWHBpWkZ5L3d3Z1dEWmJQ?=
 =?utf-8?B?ZnJTM1hLdmFxT0J4Nm5hVHBodmhvRVc0WWgrakRNeFdpdVFkc1BpUTR4TUQ2?=
 =?utf-8?B?RmpEV052K3A1M0VmZlZwTXRKU2xiaWNpMTlJUzAzR1NBa0FYTWF2TTgyWlly?=
 =?utf-8?B?anlzOUI0czd6b0ZaQXNpQ0E1cFd0ZFZvSXpRVWhRU1owOG1RNSs4ZE9EMHhn?=
 =?utf-8?B?bU1lZU1lOGx4TW9qVmFlclgyZk8xU2hsNnl2N0ZnME9lQ09qTVNMa1huZGRt?=
 =?utf-8?B?ZmQxeHpuMU53bUJJbkFNSU52bzJIRGEydzh0dEdjQnE4KzhqUGFOR3BUdG1Y?=
 =?utf-8?B?dlRWRUZHcC94ZStTdWxTeTF0QUtiU3dVbVg2L1oyYnIrdkhnSS9tYUliejM2?=
 =?utf-8?B?bUNPZTRwdDNxQ1RwN212QWJQVm9hTU85SjdWZzdTdE1NYWdIdjdwN2Rnazlx?=
 =?utf-8?B?elArUXhyNjBiN01XUUlPTG1ZLytWZzZEVEg3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmNGS09jbDRZMGRlWEhDbHZoN2lBK0tpeURKRE8yb2kvS0xOa3lYTUFtSWNC?=
 =?utf-8?B?M2VrWmRwYkRzV1dTOWFvc0Mrd1pPOGlrTW5ldEdiRlE1MENaSDdjZzlCOW9F?=
 =?utf-8?B?b0o2RWJRNWVQanVYYVVLaElJd2VIR2VjUjRDUldnM1ZHYnB2dEc1V0toNkFP?=
 =?utf-8?B?dm9kTXVINVFRN2hQeUVGVThteUQvUVVXNXVSSUtNTXBFdWJnanhKS045ZlR2?=
 =?utf-8?B?VWc4cnVJd3BPU3JYeE0wTUNrTEFMTEZxbU9QcXhwUlRmQ0NJcDIvMXF4T1di?=
 =?utf-8?B?NWRmTHhWWkxXdXBPQ216WlFHYTdkMUh0YXNCekNOengwWDJPQ1hXOTVXODNG?=
 =?utf-8?B?dzQ0NHlqTHdQYTlHb0lkekV5cUFVODNla3YwV1dTNlBYOE12YUJIaUdJVm5X?=
 =?utf-8?B?eVVzbXo0eXJNMUFZYmVCVlQyRnl0aXBvNmFRdVlKOTA0UU16cEFremhKb1h3?=
 =?utf-8?B?VDBUd0szSTRUY0pUOUhtanpMNlNKdnFYUGNzSC9xdG1pdzgxK3Y2T3YwRGFD?=
 =?utf-8?B?alNoenU1SU1JSzlzVjJ4RzRaaVp0YUJUQklVVFpkalFrMTY5Y1NlcVhtMUh4?=
 =?utf-8?B?Q09WZVR2cmFkNmhvQVJUdk12dzRQSTlCVjVFbFBLc1NRejV1cUtHMU1pT2ps?=
 =?utf-8?B?NnA4N2t1RFJHVGtGc3JObTRMWHJQZTFsU2dvdnIrVlpzQTU4YndOZWFwdGpt?=
 =?utf-8?B?d20yVFdjYzBNSkEyeGJQM2tSQWlYVG9sajA3dkRYY2J6bHpCbWNLNXJOTEdJ?=
 =?utf-8?B?YVoxNTdQblorZ1lrdzlSOW9scGFyOHNWckdOb3RhRDRJNm1JUVNkOHBNWG9D?=
 =?utf-8?B?bDRLZkE3ZkNXR2JsSUR1RVl1ZkRlaWZ0aDYrcDlWZ252QnhocTVENTlabTls?=
 =?utf-8?B?R2lQaHRmcU9ScjJhNU5zNCtSSWNWL0RzVUMwL1J0TFhDOXp5YjBEZWpNSEJl?=
 =?utf-8?B?dmZWR2p4ZjQwSEE4SlVOSzhWNkF3TnZaSXhBakpqYXQvL3UrUmY4Vko1Tktx?=
 =?utf-8?B?anlIV2t6OHd2V09EWHU0emc5cUJwOHZGNElIS2wzbWdXc2NveVltQmRHVnov?=
 =?utf-8?B?S1pLTmFLMEdGZ2ZLZGc1SXF6US8vWEc5Y1k0OTVXMzdzNVhIY0k3dU0zVENY?=
 =?utf-8?B?OEhrYUlLekhWMEhreHJQYzZiSjUwczZjaWNXVExKenRDb1V1eTI5VU5CcWVr?=
 =?utf-8?B?OUEvcGlvQ0M2dzM1d2pQVDdva0VTL3hOTEN2M3VLSnBQU1Z0VnB2MW0zN0Ns?=
 =?utf-8?B?SG1rc3hBMHFGYk5CTXFXOW5ud0FNVXB1eG5zY3FSNEZyM3BwTm8vbURjclVJ?=
 =?utf-8?B?d1VNMzljd1d0Z2ZPd2NOYS8zMHlJUVVnRVFGYlNYUi9tc0Zpb0l3NzhabHNw?=
 =?utf-8?B?ZjRQaG5XdDlyMGZqRGlwQ0tWcEtVY0R0WVlhQllLdTBMK0c3RThWV0htMXFP?=
 =?utf-8?B?Rk94c2NJc0M4ck5RK0RwbW9vRzBYamJuYjA1b1d5NklQbS9Qd3JPSS8ycW1Z?=
 =?utf-8?B?SmZxNUhXODVqTjNUWFYxeGc5d2pubGlsU1pQZDNTT24vK3RJYk90ZENUdFBm?=
 =?utf-8?B?WklrK1kzUWNUdWI5bnFoQW4xWU1wV01FeDJra1VqWDljdDltemc4MEJIdGZW?=
 =?utf-8?B?Mlh3Z1VZMlF1VmovTjNIZ2F4S3RKTWJrblptSkNBakxMaUJ2QnVLcFM5WmVS?=
 =?utf-8?B?Mk9NbnZmOHZNcWhFRUVibnNndTI3Yjg4UEExaVZIM2l3QWIza2ZnZ1VyQmNU?=
 =?utf-8?B?RmdDNlNVNVdzVFRwQ1VReVRjeC8vcXJYWDJyRU5JVEt5alB4SjJGSjhGNEhE?=
 =?utf-8?B?RXlKMnY3blE3cHdwc0Mzd1BoR2hwam1YeVVDOFNkYVJLWk4xallVT1owdjdQ?=
 =?utf-8?B?V0pjVytiUTdnajI0MXJSNFdvNTEyU1BEMzRWVnNYT0lUUkswaW8rMm5UdnVK?=
 =?utf-8?B?TmRlQVBXZ25xdzFGbUNSUDFNUDVobEtOSVZ6a2UrWVY2dU9HSndUUFJwSnFk?=
 =?utf-8?B?aDMyZGg3b3BsSnYzRWR4aHA3Yk9zbmNhMkYxdU1yUnBmTnBRZkcyTStGWTh4?=
 =?utf-8?B?T0hwQmVSZ2ZTSGFqSXI2K1RFKytpbXRIWjdkZmNBaGw4NHU2dGxGRCtvOFBi?=
 =?utf-8?Q?atVM10974b15v+YGv1g2QoFgQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107f9b70-85f5-4838-f186-08de1329a5c8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:17:53.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkXziE8KPDyn5y9N/tYQyGXLen1+kTiE3cQqMxhYCjY11oCkqFGGomKaU3zTz4xNfMSFNCJ+ylwOdirfSVrSeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

Add ddr perf monitor device node for i.MX8QM. Change imx8-ss-ddr.dtsi's
compatible string to fsl,imx8qxp-ddr-pmu. i.MX8QM overwrite to
fsl,imx8qm-ddr-pmu. All fallback to fsl,imx8-ddr-pmu.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi   |  2 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi        |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
index 7d5183c6c5bef9b57f2ff92c5184272e43054a03..37e68865b026deb73ffb6a52207f5c05a0dbf5fb 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -11,7 +11,7 @@ ddr_subsys: bus@5c000000 {
 	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
 
 	ddr_pmu0: ddr-pmu@5c020000 {
-		compatible = "fsl,imx8-ddr-pmu";
+		compatible = "fsl,imx8qxp-ddr-pmu", "fsl,imx8-ddr-pmu";
 		reg = <0x5c020000 0x10000>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..c831567cfbc1f2df7e3642c1f0ff080551462543
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+&ddr_pmu0 {
+	compatible = "fsl,imx8qm-ddr-pmu", "fsl,imx8-ddr-pmu";
+	interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&ddr_subsys {
+	ddr_pmu1: ddr-pmu@5c120000 {
+		compatible = "fsl,imx8qm-ddr-pmu", "fsl,imx8-ddr-pmu";
+		reg = <0x5c120000 0x10000>;
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 5206ca82eaf642a32299147e9c1b45704075e2b2..9ff0d56fe97078cabafb66db95b4ea82f95ebec2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -635,6 +635,7 @@ vpu_dsp: dsp@556e8000 {
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
+	#include "imx8-ss-ddr.dtsi"
 	#include "imx8-ss-lsio.dtsi"
 	#include "imx8-ss-hsio.dtsi"
 };
@@ -647,5 +648,6 @@ vpu_dsp: dsp@556e8000 {
 #include "imx8qm-ss-lvds.dtsi"
 #include "imx8qm-ss-mipi.dtsi"
 #include "imx8qm-ss-hsio.dtsi"
+#include "imx8qm-ss-ddr.dtsi"
 
 /delete-node/ &dsp;

-- 
2.34.1

