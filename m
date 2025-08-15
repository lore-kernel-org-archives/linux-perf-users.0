Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DF2C1580;
	Fri, 15 Aug 2025 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250661; cv=fail; b=FHaKOfVyDK6fQrj8tByUxf9xlcYZt9XPg5Hjmq2GVCmkV5EsS+i8JRwK7UsSuQf4Y8CLMDNzu6tzDtrHZUNy+sCioC4RD4yI3gVvzzEMh2av//s5Z2th9Ptgw/N5s1+YqJo2KrDOL95AUk3FQghOhiGDTZyudqZILuswWGGWi/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250661; c=relaxed/simple;
	bh=gqVZpGEnvr0I4LQ3PhHXtf2RuIfql0gVlbwjV5fh3mQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dkhrN+Hyh2aRsnAZPEgHDDubHDS5tRkJrY5A6kU+kxjQVsAe3N2BX+D3LAuDJF06/kSDt5RLTJsuJFf1qGOZiKp0lM+EMss9ZsJdiYWtJ429KYbNQ/OGDp+xYe9hgoKXcuasEuGVwajBkLXGPAFc5B7Jrh28JWGpKqDL02nNdTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lFOyYLZC; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lFOyYLZC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMOS6CIYMEmADoQFrXHWoHhQkPLP4x6d3EjU55YH9GWZ9lxDSbFN4EAWqx27L1cTV7wuDzPam+owEV3DvOv/GkegAmmKofH/CUvoM86DTVqBFaA4F3y/w92J1WtniwsmuaSpFUlKBeJ+TYq97X/4m77bygAcS+uUIiXvo+fYmSOEHIuPJn7BjVS77iJ627iRwdbRgvtRFZ4oNFcX9j6B+qkmYxEqVdUkFTVaVkkQZgsdSwV+vwK/l5uNhlt49DQFNaLXKWgExysir9F4Fi7UPIR1EkHX0HuHwzHOeuH7TxH8Rbpp3Du4/v0fje6MBeP6gVLqgj9SIE4u9OeLW93oQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5tBt34vTw42SXAgygIL4/IhVfiQDQ6p0UaLZG/6uDU=;
 b=bN/lpY/QthxXauekbOLwoSCFUhfHxUHJ3BnQcr76LbuDn4gmCD02nUb0L70T6AtJfVOYiCtjD6kS7FsVabqihGaLb90qBnklORcqLUDeK9nyTDinnsiGooRltv8z7Yfd3tKrIw2F8lu5Jvvd/LYSzPkegQ3SmIk/f9Tqjd2PK6ZEqw8gfTKdUhbJfSz1fHzOKJ222cm1eUc9PixqMCWCpTpuDdzJrxMX0OyXLn89vBFAWd+hUZ4UaXjv6WDEHcT0ivzyK7zCNe/fFNo+otqtjiZNofD7Ha6X54SD1dzDC4XlZ9b3BrMX7osRm/NtReu0IYKfbDEm5lngIoKCGChGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5tBt34vTw42SXAgygIL4/IhVfiQDQ6p0UaLZG/6uDU=;
 b=lFOyYLZCbUmowAYdNaM4r/YsM0czIh9ohHcNlrZ7W9GfJ5N/g2SIBsEgbo/CjBLdJx4wPCZwbQhOECuLOwzrnIWil0bYjvR8uCoAnQKrhgUf9UlYspaA/CDmO2OENGS3ZclJ0q/m2uMfESAId5gPLyotREHTpNARePDzw2grpDsf5icbrSBenT2UFe9C539EiRTUvZVQ329MW0F/1tMQPBF/+9psJB6zTbkuIcDtmS9HwK+cenJ/1G/4LR/KzTrb7yWtFecFIv0hz7D/ZrUXEPVsiZVfyBkdIhRAae48g9wXB+5eYMuNEEN0pU33TwQSRN0p7ee/EXKFUOziAAtSHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 09:37:36 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:37:36 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 15 Aug 2025 17:36:30 +0800
Subject: [PATCH 4/5] MAINTAINERS: include fsl_imx9_ddr_perf.c and some perf
 metric files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx94-ddr-pmu-v1-4-edb22be0b997@nxp.com>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
In-Reply-To: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, John Garry <john.g.garry@oracle.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755250614; l=1029;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=gqVZpGEnvr0I4LQ3PhHXtf2RuIfql0gVlbwjV5fh3mQ=;
 b=mbLmtdjWrLVEGRWrEb/wxeNnMWkd95aWYJrpmYVUNPBlzlwy0NBNBGwLKxKXD3sGNA+5R2xv6
 6s/s22gOH72AUsNo+KetpR2yOKZXwmbK2yh7NDfRPX2bVcrlzEaVRIT
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: bce8c1c6-170a-49a5-9157-08dddbdf5e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVFOUFgvWXd2MXJaVlFDbFUzbG0xaXpLM2xCanNVR3ZuOGhKT1IzemVSOElm?=
 =?utf-8?B?ZFZKZkF5WVAwcjE1eVdtRVhKV2JyM1pRaUFRTWFVQ2F2WkFlV3AxaUhrZnN4?=
 =?utf-8?B?SnFMOEFRUmIxWDQzMkdPUXA5TDVQRVNYb2JndWpxWUhlalM0SzBMNnBNU3d5?=
 =?utf-8?B?R1p4eUpJSkVad2pXcHpGZTloUG5mNnpOaTdFczN3MHA5UFRLaGpQb1VSY1Zu?=
 =?utf-8?B?V0YrRkNHQ3F0WWNDWnJqUTFKaDhsYllia0x5dVpqM0pWb21rNll3NXFvallG?=
 =?utf-8?B?c04xR2JZbXlwU3BGcmNtVW1leEhNK2ppaUcxWmh0cFJJUzg5Y2VWd3NGcXJF?=
 =?utf-8?B?TDJkR0d3S0FYNmg2NDQxa253TE05VnB5WHpjc2dROC8yMUtXVHhKMnppbThI?=
 =?utf-8?B?MUg3V3hXSzZpTWNNaVdha2dhRVJYUVNFVWh6ZCtBQi9TdCsxSDc4RWVJVjFk?=
 =?utf-8?B?YjRYVGNySGxqSWNMZVpVdDZMdHdNZjVRWjhVb0hLbU1jRW40UmxhZ3BUZ1Ba?=
 =?utf-8?B?dFU3NDdUdTVxbDZHZVJpbXVteTJHRFBqMHNQQ1lsUGVmZzFUV1VFVExHZ05s?=
 =?utf-8?B?clNwTzN1K3F6dGtBb09Jck9LQnYwVzhtU1l6Rit4SUxzMzI5U1pYSGFJWkYv?=
 =?utf-8?B?QjFVc0ZLeHN1aFZXSFhibmhJZDhSaXFEMnRnbEY4WjN0bVlSMTFoTWFGVWRK?=
 =?utf-8?B?VFE2WEhqNytDV2pvZGNlazFJK1ZsUDc0MDhYaEYvbElmNnlXT3N2cm5nY0Uw?=
 =?utf-8?B?UncxTlgxR0lueEVxS0thUklXcVc2MitRaGR0eXRkWWNMUCtXNlVaMlJRbFNC?=
 =?utf-8?B?UGFBK3NqSzRUTkpVcDJSelFCUEZpOXhBYjU3UUIrQ0VybUt2V2NZb3VNYnVE?=
 =?utf-8?B?QnNGVFJYcERUNVA5SGhPdXlvL0ozcDhsd0l3SFpubkpQWURxOW9BYTQ0ZzFz?=
 =?utf-8?B?dFdCcmIrRThkQmFZQm5ESXpBb0FKN0M2b3JKcjZqUGRyanpJMGV1VUlEUW1q?=
 =?utf-8?B?MGhoQkxDeW1zR1RvR0tkcTJGdjdBOVU4VWU0S0ZsN0FYdlhRbzR1WGg5L29x?=
 =?utf-8?B?L3IrUC9tWFBiWWJvZ1JpWjh6N1V5QUNUbVhXbjNHYTlmMlN2WWNrL1pTVWpw?=
 =?utf-8?B?V05RSHVsTC9rVVNFU2JMTVVQVGZWQVMzRnh2VlVFRjZsR25jOGxuVXovUWhX?=
 =?utf-8?B?akRDWnR5RnVWZ2docEJYcmRTNVoyUUVlRU5BdUJaQjV6aHFGaElkYkJjQjNM?=
 =?utf-8?B?akgyclVtY0FGbi9Va0R2UWVvUy9BV1VzYXIyWXBMSTRpYUJ0ejhtNGJta2Yv?=
 =?utf-8?B?emQ3NittR3lnSURMV3Nsbm9BZ0JTWkVBcFhQZlQ5aDJTOFVWT3BJL01SeXJh?=
 =?utf-8?B?TjdTMk9rb25FcE4zT1ZJME5HK3V0WUY1NUs1akhadVN2dGhmOHdqVk9vQkpm?=
 =?utf-8?B?RlVLc1BJeVBud0tlYk9UNUEyZFlHaW91K1BDSG1xcCsrSTM4NzFvN0JrS3V6?=
 =?utf-8?B?SWx1bHNqM2V4SkdGMFQrRDhyTFgzL0xhZm5ndTExS0doeGkxVVpCeUtNa0Zw?=
 =?utf-8?B?TXdZSnN1cmtEUU1IbUFmVUFld2U5dnJ0NEdOcWI1T0VTQmt4QWxPODM1cGoy?=
 =?utf-8?B?WVMxVDJTa3FEK1JmS0Jwb2F0QjRxczN2elRNcllGY1JhNndXWjdvMmxwaTZt?=
 =?utf-8?B?RUxxR3k1WEp1M1k0QlJYZHZjZHR2VzIwOWNwNldmb2lqWi8yQ3FRWkt5UmpG?=
 =?utf-8?B?cWNhR0dhTFBkU3VzZ1R3ZjFGNlREYmNWOEZPTGJGSWI1Ykx3VEhtNTllM0Js?=
 =?utf-8?B?NFM4cklYQ0RjcDJQamw0Vzd2UU9XWG5Wc2p0MDNIN1ZJcHBab09Zc1JrTm1C?=
 =?utf-8?B?cVRlOHB2cWQrR2ZqOCtGTHJ0bEF6cnUzLzhrNzNaSlFUdWFRaDlvdmtYT0sr?=
 =?utf-8?B?endaYklxVmhrSGN0ZGc1VTVZay9qUWVDM3JBT0VTTXQ4S1pvMXQ1VVlBWXVQ?=
 =?utf-8?Q?LIUD9n05i2Or6u2+PnveSBRx51am2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWNNNXErRnIxdVp1eWd0TjB4c25jQnRBS09iQ3M1VjN0UlhsUGF0ejVZY2RW?=
 =?utf-8?B?aFdUbk8wNGkwVHpHNGo1bU54aTAwbFJFQlVibDg1S1dxSkU3aERUS051aGJh?=
 =?utf-8?B?REV1N1dvU1F3MDJSdG5jbzB2dGpMY0pNaVhVUjZXeEp2V3h4SW9Oc1FqRDhM?=
 =?utf-8?B?a25pL2c4R0RvcFRQVEhDWmRBR3MzWTFvRE5XVi8zeVRCTHBzNll0aHpUQ3Bz?=
 =?utf-8?B?aU9zL00xSTRScXozT3UzVG9zNG5aM1ZIOExWTmVtVHI1UGxaSzdVWGRXOUtF?=
 =?utf-8?B?cVpDa1pOSUl3b2xHeXVxUm9IRldNNVVWeitLaWFSNnRkUTMvbW9iU1FtUU5z?=
 =?utf-8?B?NlZzTmhVMnpYZDF3TVdsU3lBYUpNbUFMclhZK1pKWElpZHE0NEw4ekwzSUlu?=
 =?utf-8?B?Rnk2NjZzdU1nZVdQdTNnejg2bndQWG5jSW5iVHFrKzlWZkJHemZiejVFTkJn?=
 =?utf-8?B?eXp0Y2hJZktFRlYrK2VRTVRpaXBvK0xlbllZdXE4d2RlSkl3U09BRWdmNzUy?=
 =?utf-8?B?emp4QzJIRlRWR2g1eUxsVHVweGYxRHJSTE1PYjNoZkhrSml0d3lhSFhvU004?=
 =?utf-8?B?dzU1U0Q1YS8wVnRzTW5yMkFXVmVST0NLN291dWc1Z3VKZHRhMFpqZno1akx0?=
 =?utf-8?B?RE1GY3NWZDg1RmJhckNTeTdHMEEyMDBlK001dzF5TWdzbjZzWFczcFZJaGZs?=
 =?utf-8?B?bVA4dTJhVmcyV2dtaFA0N1UvQnpOMWRLN25EWTB0UEhaR3FlQTFFcUxDSXRP?=
 =?utf-8?B?cUdPNlh2S0ZER2NxcjQ4TUE5MlMwVURpMFhhNHk3RXE5bkVFUjNjaFJBVHBJ?=
 =?utf-8?B?WE5Bd3ZPNUZ1Z0VhT2pwNmxEb3ZxTnBwcXNTT2t2TW5CMnJQVy9DL1RsQjBy?=
 =?utf-8?B?RTdjR3lqaCtoc1oweTM3Zll0UnNZamNER200MmFZZmxmSHZZUjVENGtiV1RC?=
 =?utf-8?B?UmQvRFY3eit3akpxc0orMHdKYkVFaHMvd2c2S3FEL3d6UzlCUTFGN0xHaU84?=
 =?utf-8?B?M0EzblVKdXluOEpZZFVDRExDekQ2dGh2WFJTbWdwdWJIcFRkZnRRTHdsUFFJ?=
 =?utf-8?B?WllmcWg0WkJpNHh5Q3VyL1ZVRFFWL1hMd0x0NkZBbHMvcVUxK3FyWGxqYzFr?=
 =?utf-8?B?Z2M3S3VnT0RxeHorVFk3dEZoMG9GeUNPQnFyMXAreUVNYk1uYnR0dEovYmp1?=
 =?utf-8?B?UHJXaUkrSDh2dWUySURVczNISFlKRmtXRGpVTE4xRmQzenA4eWtaRjVWZ2E2?=
 =?utf-8?B?ZGQybmtWTWVCaUhrMEVPc2VkNkJUOCsxTFQwU0tLc3QrNG1meGg5N2RWWFkv?=
 =?utf-8?B?cDVkcE1ack0rSVdtZ2NXeXdDa1FKWFl1OVhSYXRtQndIUytVV05neDRtcHVF?=
 =?utf-8?B?Ty8xdDFzbTh6R1dZcDNCQkhEbHJuS29ZWkFWVzlaTDN3eDNzZFJEK1grb0xQ?=
 =?utf-8?B?Z0tZc1lFc1o1bGI2dy9UeENSNngvRGlWWDBvbnRnQ2xzWFpJNVllU1BCTW1p?=
 =?utf-8?B?K1lmVWYrSDczdzQwNk5wT0RJNzV4cUFpYUY1dmxnMkdJOTQ1STBXeWI4Tmpp?=
 =?utf-8?B?cVRHeElVNE5ubmZzOXZKc2ZkcHVPdmo4NElNV3pQMWl2Y3ZQSUszVEF1WUhk?=
 =?utf-8?B?M2xSUndqR3g3RXVZRkVlUzlNOFl1Ny8wL3hFSytaQitnSHVtRzJxRlNmL21n?=
 =?utf-8?B?K29EV3RmUkx0eGJHcEU2dnJraS9JK0ZjMUpqa0todW91VU1rYmJQLzN2eklK?=
 =?utf-8?B?OGNmSmFsSGxwVUVId3I4RWYyV0xqWnNGRS92QkZoSnZHY29tbFBwUFk3Z09W?=
 =?utf-8?B?ZWVnSzNIY0ZjK3VxUjFpaitxN0lpZ0FrcXBZUjk1ZVB5SDJ2cmprODhwY3lB?=
 =?utf-8?B?MkdvbGJDUEhvTkVYZTVWcWhuSVBrcy9iUEFoTTM2QjVaUmpYVTdaMG1aUW1S?=
 =?utf-8?B?NFNTR2wyakJCM0FGTUo1MzR4U04wYUd1OEE1SXFTTG5zb3M2WmpsZGtpdjNq?=
 =?utf-8?B?MGIycjNXaS93YUNyaE5CbnVaRjNRcTJleDV4R2Rhb1dFL0U1SnZYcDI1YWxE?=
 =?utf-8?B?dUF3TUU2SmFOdU5rWUZjQkVJUFowdHd1TkJPdm5takxsZ2J2L09mRUMvTkhU?=
 =?utf-8?Q?IYB9JbTW1ZWfxFReekOF1RbAi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce8c1c6-170a-49a5-9157-08dddbdf5e37
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:37:36.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQMZaFDiXFKiSDZSBwC70VkU7pt4vZtdfqmtt0snhDKNNPRtOFVZQXNKiY8LzPXyp8EqbXglp9f0GNDZe2ZTPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

The fsl_imx9_ddr_perf.c and some perf metric files under
tools/perf/pmu-events/arch/arm64/freescale/ is missing in MAINTAINERS.
Add them and add me as another maintainer.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eeeef7bf25500987bc1a278758c82c1c68a55a0..163d6591f169d250a77c8c27cc78e0e9b25cefb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9780,11 +9780,14 @@ F:	drivers/video/fbdev/imxfb.c
 
 FREESCALE IMX DDR PMU DRIVER
 M:	Frank Li <Frank.li@nxp.com>
+M:	Xu Yang <xu.yang_2@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/admin-guide/perf/imx-ddr.rst
 F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
 F:	drivers/perf/fsl_imx8_ddr_perf.c
+F:	drivers/perf/fsl_imx9_ddr_perf.c
+F:	tools/perf/pmu-events/arch/arm64/freescale/
 
 FREESCALE IMX I2C DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>

-- 
2.34.1

