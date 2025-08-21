Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013024.outbound.protection.outlook.com [52.101.83.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4012F0C43;
	Thu, 21 Aug 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774147; cv=fail; b=e29foMDaiXeUxGS7E6sbffOGqdaUML41xYzMGnGLBoxuJIxZmX0jJL74HzN2M8E+LjktXhZyhH9r7Frq5bLZnS7CN6y4yhv33sfjd4xwUjWduzD6x2/IgLq+Q5Ox02VCsPOyoHcp6XJtKI4fCBX+f8+6KcDdpeinmXB+6Lnzvn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774147; c=relaxed/simple;
	bh=gZ+5l/XdFA1nxz5J1smHlvhL23mS76A/zF2EZ62oJOs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Nl9w2AYBsBQzYPjhWL0RQR2ak8lorUho/TAWBCqF8gXxkU9Z3K+8wbqtJu7twsoRu21fngV44r4nB28/xezd+kBi8SXtJ5K07uzqd39wik2Y9GPIqMrRxSKASHEiXbwQPBhtxL/aTzUZIwNqO+c7EMknzX6SoCV2sOVxPPpvBEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FYcj7PzL; arc=fail smtp.client-ip=52.101.83.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FYcj7PzL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+sdZoLCoQpskJfggO03LQ5/qjbmg6tOBsrhd2fcx/9ZYw9kOB1krPKCOqAoSR8OqWb8YaZoOLZ9+HBnNfb9M94+fr7fsXMvbk15VBIW61yRKQdTPZoBVb4yqoyJDsnIBL8rZfkHsulCl+P4xlcvwLj3cl5okIsWNZwvJsGEyS/nDE9ZZumPFoWxzqXhgwGQVQxrH/1mgYA/GfhYwpZlALBEbPgD3PJRE62L4pFixN4ZT4S7IFxrJ37395LbJMGnPs3+AhpGho12KQ/M8BmsXnx8+A8sxtSV/LMMg+/0nawwfVuDt75W8VG1uoT27Wp/JxT4wuh/4NG1uW3C+82WVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BY6A+6ekkrBIPsp1SuQf27+6M1iliIKaseZIa36RoqA=;
 b=ABBCjTIHJPfqFHyOqVOwzm2JkeVKkxvSosEQ6rEAMQV0JKBDsmPPwi3NFnF+rFBR5WJ5aUNg8yQ9nF10hidmEV1vKkn++hcSR3jn13/ffXqd0ZTsRyHsTyFj3gst/bEr6lGUg3Y6kS4ze8r2zCWXfzTuY/QUiwgJM60tcbVhI0jDGp30jfUBjFszHTD2f954X+vnGYjDe7Y7m6jCbH+UfVdPdY75OyCl3mGFHV15uatyqI8GKi/BBrOvv6jO7KT5YO9B4P2rYNEh/zw23SF5hi9NLiUXivOOhCgp312zOOmaoYRtXxt5Q9LUmZ/NNA1033sbbYszdCxPwGxZjeMqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BY6A+6ekkrBIPsp1SuQf27+6M1iliIKaseZIa36RoqA=;
 b=FYcj7PzLzo1HZQILu/560uts5mkC7fGY5QSPR33A4QoOsP13jAm+HITM2HkuZVJjJJS/jHaugwBitxEshS3+xC5OO+h8tjV7C+j3DeGvjwFumlp5tJsnevwgLjiWN70PNttBRAcm5goFjvwpREZSSqelicj9UUQBQu7vq0w6TFp4AsG2FTepuZLbq2wXdr6IWPtDsS66NZtTV89xTWJqxMv7mA3db/NsytXbgP8yUuu+EifaudMYjzAgmBknTHZpCWsivEdcQaIamudp+Lz73wISsOMTVAmZgFpVep0uZm9IKwMhZ3I8O0GxoBnOtfFDxoM36HGVOzjD6/UZa7uUSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI0PR04MB11540.eurprd04.prod.outlook.com (2603:10a6:800:2c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 11:02:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:02:21 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 21 Aug 2025 19:01:50 +0800
Subject: [PATCH v2 2/5] perf: imx_perf: add support for i.MX94 platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx94-ddr-pmu-v2-2-052c6420605d@nxp.com>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
In-Reply-To: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755774118; l=1456;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=gZ+5l/XdFA1nxz5J1smHlvhL23mS76A/zF2EZ62oJOs=;
 b=4p9hXlBCgHll+ED9YewSc6A8mJe7AvmYwasxv3SRBBU/Fl5K4LBwt/j0DpZ3f1RWxVSgN2SU5
 U94bIhwRWk7A51HIZ5SY2wfrysrv4xTNA80TyBwxCAUbm6evvupgL+V
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI0PR04MB11540:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e30636-da70-44d0-ca8f-08dde0a233d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVNnbVdSWjBZYWRScDNndlFvMjhEMmZaaVBpVnJpbWFRWGV4UDhpNWFMQlZv?=
 =?utf-8?B?RCtJb3lvQ1FSWWUxSnFaSGNINUFzem1JMEMraURaQzRlSjJyZEV5L0tjM1Yw?=
 =?utf-8?B?VkpMdElXRUNNWDR3bTVHVmcxeUxocjNzUzBpRG9vb3lKR2Z4UmFMY0ZCUkJi?=
 =?utf-8?B?M0tsREFDcGNSZ3ZNcmhicHFXODdyKzgyYlFkZitjV3BQNFQxc1Y0c0lqdWE0?=
 =?utf-8?B?MTg3ZEY5UkQ3a0F3ekpOenE3b0V1WTV4QmhsUHFFVlJPaGExb1BvUlg0YW9P?=
 =?utf-8?B?VnF5TDlGYUk0TmxVR3lpLytGZjZQR0lEVDJmU251N3IwN0dvUjZrdlVubTZP?=
 =?utf-8?B?QTFaVHFVSDBXTW9EcUlvTjQydW8yV1VVUjRDMElVOWx0N2wzYTI2QU04MEVs?=
 =?utf-8?B?YW9pTitaOTM4cWtCQ1EwOXFpT2Nkb0RWQTFiOUErRlFicXJtS0xkdHl2TzM4?=
 =?utf-8?B?b1hqcjJ2NzRzWjdHdHhtb0ZyS0MrVVRFV1JSVm92N1Qybzg5cTZ1NzZnMUMr?=
 =?utf-8?B?WGlMeHNXa2FhY0Uvb0lXandhMWRYTFl5eldwdExNTW9sMmRLQ2JPd3VrY0pr?=
 =?utf-8?B?MjJVamV5am5zbFpjeUl0SDRlU1RKTksreGtPbmFLTnk3emMveFZLQ3d3ZDg5?=
 =?utf-8?B?VERMY3FrQm4yUi9PQmVkOUpGR3pmRy9ERk8wSTNUVHN1cWdpcXhVeWpSTVJp?=
 =?utf-8?B?U0NCcy8zWnB0cFdJQkZzY3FaK1FkbDBkZ25jM1hRTVNXOFpSM2tDN2JHQ1lz?=
 =?utf-8?B?K01VWks0NGRhU0RNT2hkNTZad2RSTG9uTlM3L2JXVnNaQWRjVGxManRpTjYy?=
 =?utf-8?B?VjFjTW00c0RRNlJkTzA4OGFEcWtUL0NKMVdFQndBQWlxV0tXRDljcjJoZzRa?=
 =?utf-8?B?Sk5kakFOT0tBSGc3YWFVM3pTdkJ2cFl4MElVOXB5U25Ia3JhenpYeElZSi9o?=
 =?utf-8?B?M2tmUnIyc0tqZ2pCMmhjbk15eHBWWHRFSUJRaFB4NE5CdmhtcmU2K29LWmQw?=
 =?utf-8?B?bTBiTTF3dkU2NFQ1MGU4ZkhpbDBtUy9DcjR6c2tjU0pZYkZIWnhiaWRVMnp5?=
 =?utf-8?B?dnlIQ29oU29BUmlpZmFSeHdhcnV0MGZvTG1EN0k4WVZNb2Yyc1BKSkRGT29F?=
 =?utf-8?B?ZmZvRjNJSCs3YVBKSWhtYzJFSkdSOEZiNWxBVzVrdW1YRXVMcFo0NktteFZh?=
 =?utf-8?B?VWpjSXlIRy9OUEs5VE1aeGVvQndzU0Jab1hwQ1FjSVpzYktCdDdCQWFOOERS?=
 =?utf-8?B?dUttdi8zQ25lTUlNb2tocEg5NVVsWDRMaHFXUXRFby9YWGhHSDNjVWxaVFJ2?=
 =?utf-8?B?Mng5NEpmZG9kd05nN1U5T2FYTytJV0VPbmo4cmVVOEZOTzkramtCL3ByK3Bv?=
 =?utf-8?B?YzBIaDF1RTArLzJkOVQxWCsxOTFUNG5scnpSbHJ4U1ZQZ29YNmduRGl2SzlT?=
 =?utf-8?B?RzIybmdvWlVrYTErTWRlc1VpZjkvZkZhNG1pZDNCVVhzRHdXUEpVMG1Uczh2?=
 =?utf-8?B?MlFubkNkdy9TSWVXV2p2TW1iOFZHeDdjUUJ1SW55MEtkdTI4Qyt0end3dHNB?=
 =?utf-8?B?c1ExRGFxaTY0ZVNBUVdjTzcwdU81aktCbHhreERFRGwxTzR6SlF0MlhuazV4?=
 =?utf-8?B?NUp1NWxYRVVXWlRmcmVNNDJ1UHYwL3FrR0RUK3RYOUo5cGJDNGpYQjViS1ZO?=
 =?utf-8?B?b01JRXdUdCtLTUozNGhkNTlJcGNXL2IvdWl3UGpjZFBUMDdBdmpjTC8wejNV?=
 =?utf-8?B?b2ZTUEJlbXVtbzhoUjNNSlI4NHZqTGpzeUh4Y0o1alpZY2g3dTZJUHZRL3Bs?=
 =?utf-8?B?eVovVDZ2TzZRV1A1Sk53Ly9VRHU4WDdtazJDYW5Ha3JNWmJVR0tiTjVTMHZw?=
 =?utf-8?B?L3dQVUpESWNnR1MyZm1YWFJGSW5VUFFVbk1hYTE1VThwa2NvUnNiOE5tQlRl?=
 =?utf-8?B?YjFCejJPNkJiUDV5UFE5bkhjK2tMRy9rbVY2Y0RKcGd5OFppVlZIQ2VnVTBm?=
 =?utf-8?Q?MznzmCqzqNhKn6dUJ7qhAO/yZsHK3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWgydE1CL05vUmowV3IrU0dwQjUvVE1SZXA4VEg1V3VqbDJ4NEV6S01Rait3?=
 =?utf-8?B?bklUbFFLV25xZ002YU00eFBoc2Ria1hMVlFGdExoSFNmT2tDOHpwK0RDRHBq?=
 =?utf-8?B?VmpTS01xSEtGV242T1hhc2JGSTR3VHZkb1VJUFV5SkRRVXBTeGU5d3pxY1hN?=
 =?utf-8?B?MGltSkVoOWdLdXpuZDl2YUE5QTU5cmROWGRabnBNMmVRSzZiVTJ3ZmZHVnNw?=
 =?utf-8?B?cmNSLzJDNnRQejJuL2tpUWI4eGFlRG5MM1VJZ0kyQWpmVmZYZ0pGVGVHSkx0?=
 =?utf-8?B?QXhMRGVsWHB3WG1XeWtQTC82NHFqTFM5RC84VjBuTDVBLzBJMTM0c2dvZUdG?=
 =?utf-8?B?K3NUakR0VVhXM2VKaFVaWFU2dmFZL1JjYjNLdWRHMDZvcWdlNGg0dXFHM3U1?=
 =?utf-8?B?Mkc5N2dzZG56ekFUcnBZRERlaWwvU1B3RjZFOFg3bmVXZUhLaC9DS1QyenRv?=
 =?utf-8?B?bDFSd3U5T2lRb0Y3alF1VWlwQ2xrdWRpSW1lOWFGTUErOVBVRENNdDQ5bHJJ?=
 =?utf-8?B?U1h3MWZnUUszd0tiRVljdVZadFBLaVltaHVDS0oxZTVUWmhMUVFnSGpEbGxV?=
 =?utf-8?B?ZjNBR08va3NEUmM3bldIR0t3UDJQUXlvS0s5a080MktqaWt1SHVHak10VjBp?=
 =?utf-8?B?cVk4YURTOEdwZ3VGT3QxdVpqd1VIaU9rV3d4bXhNM1BlQjhyTitsYkt2SS9u?=
 =?utf-8?B?TDNrY0k5R0JCV0FPakRHNDkzWmJHa0JrQWMwU25YQmoxS3NITVAvamNmS25z?=
 =?utf-8?B?aUp6blkyTmZyQ2t3QXRaUUg1M1ZiM1JzWjBxZzNQQTZoMDhGYWdtYnMvSk52?=
 =?utf-8?B?MVdUdGFhMG1SU1FkWi9WdHQvQm5FdUFtUG5VajUwcGhBNCtJM2xNelZBbzdE?=
 =?utf-8?B?eTEzYk9tYm40bTFqWnlFVUcxV21JKy80TzYvdXJGa2M2aklsUFl0RHNBeEo4?=
 =?utf-8?B?ZCtVaG9DZzVPQ1FWaXpCMW5GbElRNjF3Uis2QVVOWTRySFJjZ3c0alViWlk4?=
 =?utf-8?B?WlN4cnM1KzRPWG5QQmtEenQ4TTJCQ1FqRllKSEplMG9GN1FwdTFJUzlSWnhj?=
 =?utf-8?B?NTdEUzk2aktzR1lMdm84bjVGTkUzU1VCSENyWElWamwxR2prM3NCSC9qR1Jk?=
 =?utf-8?B?eVZ0UjdheTF5dHdLY25mQUNLaEVQNHY5dUttZGcwWm0zWWt4QnN5OVloZ2No?=
 =?utf-8?B?TGNza1N1U1dSS2JwRTZIanpsdEsvT2VKS0pvZ2JSZURyMmdYK3J5ejhoNk1h?=
 =?utf-8?B?aWY0djRBVHFJQWVPb0JlY2JZSjUvV3p0TFJvdkdVcnUweVBma1JpWDBxRkNr?=
 =?utf-8?B?enZDSGNldEFrdVJjTE53d2pvZFNtRllSYjRsVTBoVDVsTlI0OHdGTTk0Rk9P?=
 =?utf-8?B?TEVwZ3V0YktjZkxybzQyeStmNFY3UU1paUlnYWcxKzlhZjc2WXRkeDYrVFRB?=
 =?utf-8?B?WmhYaWpNSmVSR0VINDVJOG1HdGFtN1ovV2lhZGFkMkVFc3J1VUFqS3hwMFFi?=
 =?utf-8?B?alBjZEtRR2xZUGZCY0VjWlBZcG5HdStxeStoU0ZtdFEyTFRLY3BrVUFnaGRG?=
 =?utf-8?B?ZHltTzEvZTdPLzZrQnBnQUVxMlhwbG1RQjU5UkhaSEE2eUlLTWhMaGlkY05z?=
 =?utf-8?B?Zk5pbFJiVHcrdlVQdVYwNGtqM05tdVB1aTBzNWFNcDM2emlvVzZKQWFjK0JZ?=
 =?utf-8?B?aS9iSHE0ZmxTUkpWWUJWVTg0ODZYRU9zSDZpRzQrNHRVY1pvSWFjWVFzN3J6?=
 =?utf-8?B?WDYrbitBbVFsaGo1bW51RVFyczZjOUJ6dGZwcmRDbUZkeks2bGZ4NDdzWW41?=
 =?utf-8?B?Wmk0Mk1SZjd1bzNpWnlYbEVYZmx2NElCdXpmUDN0dkdXZDlBelA4T1o3OW9o?=
 =?utf-8?B?ZGs0L1IyZXYrMS9SWmtEMEV0R3lzVUE5L0hUUW9Ed21hWnpsNEVFYWZNa0VO?=
 =?utf-8?B?SHJ2Vkc2ZGhBRk5rYjZiR3BPaUcxZitkV3RaQUFiZTVnd1NUeHNLVnBQRjVD?=
 =?utf-8?B?c1hwL0lsRkVKclFnNWtmRjdRaXRsL2tsTm9EYjNZT2d1cGM5MXh6Uy9hbjN2?=
 =?utf-8?B?eWhsRGR5OUNYRU1uSXZFQTlyN25WWCsvZG9yWWQ3ZGk0WVVIbzdXZTd5eVdD?=
 =?utf-8?Q?HZRGxZp1AsDKuj6iC3S9dFpT8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e30636-da70-44d0-ca8f-08dde0a233d6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:02:21.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM1ER8AonCT2QS6eCdVQEeW267rAUwqZlUYQslmoOALme9/k35H4Yk8WQ87zKMs/1BFJmHCo2Y09BrSGNpIbng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11540

Add compatible string and related devtype for i.MX94 platform.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - modify commit message
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 267754fdf581469642c4485c28a2b00050fe785f..7050b48c04671759e8cad0e93359c088a2bf342a 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -104,6 +104,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.filter_ver = DDR_PERF_AXI_FILTER_V1
 };
 
+static const struct imx_ddr_devtype_data imx94_devtype_data = {
+	.identifier = "imx94",
+	.filter_ver = DDR_PERF_AXI_FILTER_V2
+};
+
 static const struct imx_ddr_devtype_data imx95_devtype_data = {
 	.identifier = "imx95",
 	.filter_ver = DDR_PERF_AXI_FILTER_V2
@@ -122,6 +127,7 @@ static inline bool axi_filter_v2(struct ddr_pmu *pmu)
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx91-ddr-pmu", .data = &imx91_devtype_data },
 	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx94-ddr-pmu", .data = &imx94_devtype_data },
 	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
 };

-- 
2.34.1

