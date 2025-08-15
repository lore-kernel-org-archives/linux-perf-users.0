Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5122E5427;
	Fri, 15 Aug 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250631; cv=fail; b=gpAzcNFVTPTw7xJviugS6A/JPTchWN2EPOIHWDp/aPAKfqQH36HE3DlvnjdAIMRj8nmnj99hmvrUlo24Pl6/4ui/+8vp6XPkjhlGOWvU01W5Z9H8sZGQ0bdI7HLcMZtHBp5xe6oftrsF2rzW6nO2ILUxmnjlS4MOskjrEu8PFUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250631; c=relaxed/simple;
	bh=tiyhuFAH2MjXlKoEJpX5OI8uSZGy3uvNKPx24ffuVMY=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=uVK79U3f28AyMJWh4Rqwi81myqR7i0BVyBX4s/WqQhqU7S1AJrlNu9ENUXG8MksIFaTEOjI/RL/DdiZTxvufeSEl3h0AnDoLZfGUJdcoUNenKKyPwL+xBYj0J4WDB25fj6b3T8yZvs/LMigNObaJEZ9FK8G5FqPiCXX90QJ7dMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G53R3HLf; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G53R3HLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUqmxgZRTljple5OzostTaIX83eAGzVKP1v+9uPz8tKbPYbLGDuRAMxd7HAONANXCQeNx4iCH1pL2U7w3GKHk2FdVHn28B+STYXHFwMujD58nPUN53V4w/DYsOJVkK9b6ns50sQ1hBM8HVkuuTD4Zdhs8c/on/AZXCYGY0ZwhXL+9s7ry8KNnbLpATenw0vsVjuqR8IsVQNkgKKfV6ueis+kjxggorc/uN5FqHRewv/0VxTkErQ4yKzxpkAmQO2NHzlrqOUrcNJJOAQiS13c5uQ6P+WK3FZruPYV6o7uRHa7UKvqxmqHHFFmcdW4GLCh2gDcSVqiGVKsHDfQrXzswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLG9633GVDENQ62GEIUE6J/kOTn3FCekwkZWobXvvdE=;
 b=HFzK+QD8DqdanDUr7wy6tmXyzW8pR0ZloWNOBLf2t1ymag0ESh9w1CFLCZzE/yoluayT3dsLknFOmRmYpJeaW8uy3q7wr1dc49E3/xT9gC8DLilzjKjnWiCrn/ahskzKOYgJfxC7+/z+0OZEig8B+3zCeVEUnSbiADpgIbLWqrVD2R1GziHqlPzeWc/Maeh4kAuj2Ol3rDQT7DtnGJB9WqGI4q1IaVPuraMG46BEb6a2EN1XX8+63w+BmbywgE6CSZykvhaypjV0ZehuBDa40rs6IURoF27EtlBPddPFKUolwd3fYstFHv9ASScJDGx/zgfkqs7BxxUzN4Is1y/Hgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLG9633GVDENQ62GEIUE6J/kOTn3FCekwkZWobXvvdE=;
 b=G53R3HLfk7vhBVhnUMJITKI+OPbBH9VlVQZU9HDd1D4zbONbUssOW6sSTo1Y0DzUEhYKlbjdlCWLehtsjLDI1/e3DRCdqVjsmqLxSRsOV6yrwdfWd0sS4lP4wcBLm0xlkRbAXLcl9Ha4YAuZ9pLkuBBtnp1CwaEvd3PWa4RSJ+L9jwa6OAkoeJNHvsIlTndRu2q9hDt0Y/v7Q5gOtIZG0x0RYEONF82EOW1H2/xKN5X9E/9yN6aSOnewd+GyYwDruX0KnEE6Y9rrAMdkxVyEvs3VoMIFCmoF75e0MDI3HHIlny0PWdAmac3X+bBVgUNT7g9/FXORF7SQGCATn+MjzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 09:37:06 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:37:05 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 0/5] add imx94 DDR Performance Monitor support
Date: Fri, 15 Aug 2025 17:36:26 +0800
Message-Id: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJr/nmgC/x3MQQqAIBBA0avErBtQUbGuEi0ip5qFJkohRHdPW
 r7F/w8UykwFxu6BTDcXPmOD7DtYjyXuhOybQQllhJMGOdRBo/cZU7hQar9ZpR1ZQ9CalGnj+v+
 m+X0/jZXFyl8AAAA=
X-Change-ID: 20250815-imx94-ddr-pmu-14df6248e65e
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
 Peng Fan <peng.fan@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755250614; l=1014;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=tiyhuFAH2MjXlKoEJpX5OI8uSZGy3uvNKPx24ffuVMY=;
 b=ndhnr3jld4SmxNlIUTQkkNf5r2/yW167tZ+L4EcoFHfHs9sJahPPgTSZEuRU0ky1LCGCPP+0E
 O4hP1rrmxu1D2mOiP4s1yMkDzCQ1sEGT80JhmfYMNltzx18k3cmowF0
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
X-MS-Office365-Filtering-Correlation-Id: 2758090d-23e9-444b-3440-08dddbdf4bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0RWZHo2QlBTNU05Uy9xZXpnMDE1Q0tSbHhxVEdYdVBqaWllbjZmbkdySzRm?=
 =?utf-8?B?eHZ1VHBCRTV0c3l1cU12S3Rqakx3bVhEVnN0Z0p3a09QRGNjVUd1UEt1S00v?=
 =?utf-8?B?YzN2TlRRWEQ5RWs0aXc1NlJodVhwMHVnYmhpNE1tb3o2dzdrbGxmVmo3cWNo?=
 =?utf-8?B?V2VYV3ZDcmx1NEdTMk1ZOXNVb1VaZmVlQkllTnladTBldTAyWHBoMlRwTkIy?=
 =?utf-8?B?RFNXRXdWVEhwdlU5TkdhV2VUNWJIczdDTEVKaUVSb0xGMFdIS1g5czVRUEVm?=
 =?utf-8?B?ZUlvVFlqcGV5OWFjRm9lREIyck9VeFdCMVhGaEtlRUVJUXRMNGp3RVQxSXpZ?=
 =?utf-8?B?Y0xqcUxwa2RsRXQwM2FyLy8xNWs3bVhDanBSVGwyemM0d3Q2ZXJhMmI2emJR?=
 =?utf-8?B?K3V2SlJSQ3BCSjltNWt4S1B4SWJxcXVoY1BrbTVwS3hYblVuZklqT0xBVHdl?=
 =?utf-8?B?elZncnJGR3BsOFVKM2FIME1oZ0tzUVVtZGhxZzdhempkTmJ3b2NHOEpvNlJB?=
 =?utf-8?B?NmlVSUVTNkFIYVJaWEI0RFhXU21VRmlhdy9OcXRQSW5mUkU2OFhFZjFvRkJr?=
 =?utf-8?B?UHljOXVkK0REUi9KdTVTblJIaXhRQXNlUzFNRnZucGFOVWd4OHYwYWtrYWFC?=
 =?utf-8?B?UzdJRGRrVHpESlNqOHF5TVIyamJPUUk3MkdBU3B5YkVOTDYvWnhtR1U0THFF?=
 =?utf-8?B?Rmp4VzBLNy84YUlzL09weWw0eVMrNWs3SEU4SVFkbFU4SHhQSzZ2eCtDSmwr?=
 =?utf-8?B?R25FMWZIT0cxRit3R0RuWXNoTk02bjBnQ3JMbDR3Q2ovcXAweVVQRVVGVGF1?=
 =?utf-8?B?cVl1TkcvUGVLR2dJTGJiRzBwbzRVbXVTaFJNRUZ6OGttUTE1akNTYUwycll0?=
 =?utf-8?B?NjBwM212c0FTSE1TczgxUHltTjVTTkJWNnJnTGJkRURKc25CTEFhWWZpUGU0?=
 =?utf-8?B?cCtsdzFEZzVOREl3ZXhvNmxQdXhVcDNTS1RjdU82Z3dMWGhlbDJJdDFMYUsw?=
 =?utf-8?B?aFF5amY1WFVCdUZydTlMYy9ob1BmMmN5QU1SQk9Id1FTWnkvZkt6NHFQUjd0?=
 =?utf-8?B?N3pmRDY3TXhxeG5zTEFyUlBWbVdTbmdjUTNDaTdwWldpZkVKRTQydGY2SmN4?=
 =?utf-8?B?bkpCbUd2S3p5MDkyYlBsMFNGMDN2dDdoRWVIeDFzQTJjZnJHOFRGUGNpemE1?=
 =?utf-8?B?azRzVnBBNXpUK2ppK09WUlJvZG1oWDNIM1dZMkovRWJsRlJybGxPdGgwSk8r?=
 =?utf-8?B?RU1qWjFLM2x5UlhQNWRUcW5pMXc0V0ZjMHBaM3R3dURFUUN1Ni96M3Fma2JO?=
 =?utf-8?B?b1hpbEpaVUs1VXd6ak5GS1JmYks3VjY2Wmt0SFEzZlZ5TitYVVVIbzMvVm9U?=
 =?utf-8?B?WVo2YTNaM3p0YUZlUlRUT3lnNVRjM1FIalFDNHllSjkrallIcFdrZUFNbDB5?=
 =?utf-8?B?ZjVoU0tOcC9GUGpvTko5a3R1QnpGRmtqWWFwdzUrejdBazAwb3czZlJiNkpS?=
 =?utf-8?B?WVFIbmJsZXIvWStVS3F6Uzh1UXZBaUQzUEh3OHZta2NvdG5IamJGd3JLRGd2?=
 =?utf-8?B?cWZrb0RNOUNQSUFHSkE1SmNRbmdTWXhadEFFZ1lWeGVVT3RjTm1RUVA0bWwy?=
 =?utf-8?B?SUZKUUN1KzhEWUY4Yy9PcEhVaFN2Qm5Jekdrajh0WTdjWThFSERKUFVYdSt4?=
 =?utf-8?B?QStoRm1yUWVIQXFtQ1pCemJxQk9aQkV0ZnQzOTFHcVdqWHFRNm9hbmRFSXlD?=
 =?utf-8?B?Q2RUbmFBRm9TN2hFUGJUaVVXY2FsOFhCYWdBWldqTDN1ZVhLZlRwaElSb0ZI?=
 =?utf-8?B?dEVDY1lyVmRIOGdRVlcxRUtlTTdhQTBZU0FSdDJFaE9UUXRLc0t6dStCN1Vs?=
 =?utf-8?B?MHZvK0VQSGNhOWJmaWoydFc1N0d6SVVoWi9ORy9rcUVtNFlaS3ppRG81dmNm?=
 =?utf-8?B?a2xRdGtVaStzdlhsU2hyNUZqbStxZFZrMnUzdmg1akJhazRNVWJldzVZaGNQ?=
 =?utf-8?Q?Rlc2R4m9l2HMJQD5STTMZqbXwJ1Cr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZ5a2JQVk9aSWFNeFIvQlhmQnhSeGgwVE45d0daSGh5Zm9ITWs5YU1ORDhI?=
 =?utf-8?B?Q2crdHpVS3hNa0hDSHBBcTFTRytqc1JlN0JtZ2ZNY0R6aVg4UEdDeHhZMkJh?=
 =?utf-8?B?L1BmS0x3eWpJZ2xqaDRtb3VmWnFXREZqd2I4TFNoWkR0YUt6ZkJsdlJ4L3A4?=
 =?utf-8?B?U3NoOHNVTTVWNmw5Tkk3eHZWY2ViR0tUR01zZFI5bC9LUmN4T3E3OVNCMFJl?=
 =?utf-8?B?di96ZUJXUk1wNitKa3hWc0xuamE4WU9zcDduVHdVKyt3SUU0bEtzd0lORDJh?=
 =?utf-8?B?WEJQekEzNCtUVkJxNTBDMTIwSFppaWV2ZWZqdno5MzdPQlY5a1pxLzdGTlpx?=
 =?utf-8?B?UFR2YitDNk1SSGdyTGl2bjdrbU5tdmJ0VmJ5aE5WMUwwbGhoT3NSME1wOEQ2?=
 =?utf-8?B?TDdzOXF4TUVmTTQ0S3MzYzNmU0ZmVFRSYXIvZlJuYUpFV1pjZGRLREVOVnVX?=
 =?utf-8?B?N21qUXg3cG00R3hWcUdNSmFmOVZaelNiczlyYmZyenhxa01IN3VveEpmY1hx?=
 =?utf-8?B?YlgwQktwRDV5VEdkR3RJV2VpU01IVHF5WXlkZ2VBZ0d2blNqSlJTUlRtRHhY?=
 =?utf-8?B?RTRMcW5uQmhLU0NqOGRVNHFhYzZQKzBaUzFjMWZSdkZYdnVTU25zS1FkeGtN?=
 =?utf-8?B?Z2c5bytRNUpQUnFZMG5CSmliaUpQakd6S3V4STg5SEFKdm0rbHFQQnV1aUt5?=
 =?utf-8?B?dCtvbHRJckhJNEw2K2NBb2J3SnNWVUxMMmJWSTZFcEo3Wi9JZ0pzN21LQXRM?=
 =?utf-8?B?eTVQS3VNbjdDb1ZyZWc3R29mU1JYR00xUnV1WDVETGJkeTdrMXNQUFA4clpB?=
 =?utf-8?B?bVNYdXdhcTRxOGh0aGlTMnpwNXM0REF6MWViUE9MUEQvODMrbjM4ZmI2eE9h?=
 =?utf-8?B?bE9ic0ZWSndqNkwvb2p6dEVYOXExMHppeDRxOEl4cjJYYzk0V0FIVWp5b1dV?=
 =?utf-8?B?V1VqNTJpbC9NQnF1NE9OVjMvNlVVTE9UZGNnWldTSWNXM0ZYU09LSndUbHMr?=
 =?utf-8?B?UTZqSW9lQXprQjMwOE5GTjMzOVp3VE0wenNMRkdtQmtFZy96RlpIdThpN1hR?=
 =?utf-8?B?WnJIOUkyV0pFRW5RWmdlN1kxTmJrRHArd0ZNUXI0T0d4eWwwaGdlK0V2T2Ux?=
 =?utf-8?B?d0w3T2h0NHBaUTlCV2svcXBDVk5LY2xGdEJQdXFmZEJ1U0czTWRHc3hvODBr?=
 =?utf-8?B?TU4vaDJzWSt3eGVIUy9nN3Y4TEVjVzV2dTNobHNDcG83WVRVSzVjRmVCYllG?=
 =?utf-8?B?MDhzbXhEbkM0VVBMUWd5d0pFVDN6WWtSSUtZRmQvSGY5WFlvcjU1Zm92MzdB?=
 =?utf-8?B?bFd5b2Mwa3dhdzZSWUd4VThHZUt2UlZ5SUlDRlVRRGNLcDhMcGt3eTdsdnNo?=
 =?utf-8?B?cTd3WGlmcXVyWE9EeDhXcUlBeElPNElNSHhsZGNLWFlpS3RiQUxoNG1VTEls?=
 =?utf-8?B?SzhtYXlocjNKeEJYSUVjZ0M5MEdmL2RLcmJHdklCMmJMR3hWeVRhL2gzckV5?=
 =?utf-8?B?VGluR0hjdnJBdEdSNXVVZGxiQUhjMnBlZll1eVo5WTcrMXB1ZC9jc2duN3Uw?=
 =?utf-8?B?bTFjR09sQkwyRmxvMC81L2c5NmdZRTZ3QVVvVEpWc0k2SEsvN1Yxa0hOUnQr?=
 =?utf-8?B?VTdCUnF6bGJZWndQK05BNHZ5SzZzSmtEUm1QK1krYjQ5QjhXRytZdis0Z3Z6?=
 =?utf-8?B?aFRYWGxIY0lIVnFpa3YxSmkyYkIyaTZzRjA0Tno1OCt1eUY5RDVvNkhNcXVm?=
 =?utf-8?B?d0l1VHRNb0ZrZjNjNnpraUlneGtBMFBBWkpha1Vxd0ZBMW9BeW5kTG5XR1RM?=
 =?utf-8?B?dGxPbjhNSGdpaS9JbWVubmRzdHBPNWluV2dSZ2Uza1hLY0pWWUNjbC93TWlH?=
 =?utf-8?B?SjZEYnp4aVlIVmZHRnNybUtCT2V0dlNjYjFXN0FCWTVqaEdkVStKTnljNWth?=
 =?utf-8?B?bWhvbTI4UWR1ekd5eWlYSG12UGNrejRFUjFaYmdqWlM5TjU4M2xWaHlya2hk?=
 =?utf-8?B?ZjZ5WldvQjRLUXdhWUxpVFk4djRIeTNIMTArZUtteURobFk0S0NiT25jQzIw?=
 =?utf-8?B?eFdlK2JtMmw3QWtqSEN3UUFqM0xTYmFqTWdwK2t5ek9FcitjSkpaYVBHSEJL?=
 =?utf-8?Q?pSLUhxTnsfD863UfyvaFFce+6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2758090d-23e9-444b-3440-08dddbdf4bf9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:37:05.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVYTMvvpqYpOSYs2yKop5UX4ZHb3ZYMinIQ0dNKzS1ogUOPb9H3Jxi+QzYvmRAremA3251veDGOWwP/wYmj4cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

The i.MX94 Soc has a DDR Performance Monitor Unit (PMU), this will
add support for it.

---
Xu Yang (5):
      dt-bindings: perf: fsl-imx-ddr: Add i.MX94 compatible
      perf: imx_perf: add support for i.MX94 platform
      perf vendor events arm64:: Add i.MX94 DDR Performance Monitor metrics
      MAINTAINERS: include fsl_imx9_ddr_perf.c and some perf metric files
      arm64: dts: imx94: add DDR Perf Monitor node

 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   1 +
 MAINTAINERS                                        |   3 +
 arch/arm64/boot/dts/freescale/imx94.dtsi           |   6 +
 drivers/perf/fsl_imx9_ddr_perf.c                   |   6 +
 .../arch/arm64/freescale/imx94/sys/ddrc.json       |   9 +
 .../arch/arm64/freescale/imx94/sys/metrics.json    | 450 +++++++++++++++++++++
 6 files changed, 475 insertions(+)
---
base-commit: 2a2b302fb15ebea4da71e3fe2943e61a1c83cde9
change-id: 20250815-imx94-ddr-pmu-14df6248e65e

Best regards,
-- 
Xu Yang <xu.yang_2@nxp.com>

