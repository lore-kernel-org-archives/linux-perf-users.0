Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98F2D8363;
	Fri, 15 Aug 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250638; cv=fail; b=psLEEL9AbQQXAOvrnRcNlCEWRAWQ4OlkEAouAFRz3Qw+0F25EkRKMoGDs7aF5rJNr9UfAM3naw6gudAr/pfl/jmexKyMo/pDL7WuDK6uEbyYZ7IwAOBa87JofQ5mh6qxHjirfPLH9aiQn/cT7aVRTECiyLtFgn7YDcM3w1rJa9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250638; c=relaxed/simple;
	bh=gi4HWIknL6AcrRAZPLJPDA6GDiJqmJ/dYbY9VDCatLQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FLOdNltnO7UxxBOze2zZqeMyOxP4J2ozXnPTLUXp3fnVEFaX6LkhV76OZZMvHG8B7r7KMN8i+gJONu3o1uS59zYXzfHG+PSbcs5Uyk6GRHrSEkAUnr75kSvQGEvSXoKVbkJktffKpFaZSj3T9c4kxELCnlSjdXQsAoUvv7bVRgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N/LNeRYI; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/LNeRYI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQJM4Wdx+6HyLjs63k4bwRhBcRRsEryFQUOHDCKlTbbAfrxO+aAgQrEFHge7H4fhK3KLR7r8KRIYS3/tu8dslUtDS9LkEmnfn8K+XS6vcjMc2HxR7vgzYxWINPYR+/9w4OieS08XyNc6tzUSOBxxwookVI5s+fA3rTSok9s391KyTll2Eh5cRM5WHhHerjzpYEMHMP0tgyhnPUYXXvYpXOhX1BKxT6YrGTDuAVmeKB8zHEwZAgEahdFJ1o55QqjVmKQhuIGL499T+aqrwXx29xbvMqZTxzZbHk4vlCc2mRgg6+EDurqatMARuK/DyycSo4bMQjuTfgjTK7gt8uyqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSUeUeehzNkiIwvM0Mq206dDwQfKja9BTToH9zy+ay8=;
 b=aA3Mz/yfBfoxc9ndLw+E74u9l63/A905V3DBhZvADf5cTYZGdZeEsODsSwkk0kah2n/pFyXWjDhR8nSr44DeLlW8yWhgDBe+TK+QB35Vxpguacy6w8kJAfW2g54gqAglQZ4MNvowLmetnR1HP7wXI4DrvpXRyWW77uh2K67Ipx8bbkSU1lvgP6KY302C6lDCuI6AYPQIO5EIxYy0dgEcpwOacy/nacyAQI8YOg5AOF5mDr+GCPPDueaetlaQF/Mw+T9TEBNKghvNOYtYN/5Li4lIY3jhTQUf414y6PLOBsYJILxn6suxzX1b4EcjGW9saJhI9lr70j+7PweHttAUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSUeUeehzNkiIwvM0Mq206dDwQfKja9BTToH9zy+ay8=;
 b=N/LNeRYIbNThcofOG0c302y4bosYdTke5Wso1WPBHK2mIrfK/hQJx1/8vAHjHFvJTmTqUsdf6/7iEGfJKQDWaHJUeGVr259EIHnMGjmD7Jzpf+WQlyR6/AuypqVjjJV9EgTu6mA9HYmOv8xQ4fNXt7g2gYOnYmvvjHuDUDbj3U/NhD51QuNKbdFD0dCOtyTEu/wsLmQb49TvZCpGwG3mOLdio4Q0zgaUSCMx6deglWVTQW4vL4+DUi7UREGp1S7MSOZOj5DyOYKb5vXNmNwSyGZKf+RGsUFgcQ8TvJYA273IeMXSbQOBTlcGjCQeLwxmGl4towkwpHOnGijrRF61qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 09:37:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:37:13 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 15 Aug 2025 17:36:27 +0800
Subject: [PATCH 1/5] dt-bindings: perf: fsl-imx-ddr: Add i.MX94 compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx94-ddr-pmu-v1-1-edb22be0b997@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755250614; l=892;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=gi4HWIknL6AcrRAZPLJPDA6GDiJqmJ/dYbY9VDCatLQ=;
 b=laY+EdE0/xzifXeNWCsmbAy0nJqHFsQ5+CfTOrToFbgNU4vPKWa75LEmTGdCZN2ZNDYCr2JQP
 rtfKKs0VXJ6A3NIZA9zZwzRgrc97y2LK7sSTsr9eYH2wr7IUTvWdshj
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
X-MS-Office365-Filtering-Correlation-Id: b1668287-0037-4885-daee-08dddbdf5097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjdFeW44NXp5dXdMa0l6UlBDMmh3RVlKN1VNNDdiVkM3QVB5Qi9DTSs4RlZL?=
 =?utf-8?B?QmVGU29BSXVQcEtIN1gzTGtDVGNPQmpUY0JPRFh6V3piYWc0QjRIODZPaVpF?=
 =?utf-8?B?U1NkYlRvVVZqVmh4a1JnRzA1UXcvaUhtMU5CVFVwL3JTTWlUVUM5TXVHcWhD?=
 =?utf-8?B?QWp3bjJQa1d3Zk1vOEVnY2xQcXQ4alBKczhUdC9nYXQrT3RIY0R1c05OalpM?=
 =?utf-8?B?OXBRSmNab2hneVdlT3dTR0pkMkYraFVZTXBLN2VVRFBkK1c2YXNZRy9GdHVV?=
 =?utf-8?B?clVaeDdQK2lIVGx1WnRaRFVFbzFYMi9PQ01jTDIyTytCb3pIUkVLMXJYTmZH?=
 =?utf-8?B?TVRPQU5TNDBjUzZ6bVp1S1JXZ0xMcE9oWk0zT1AvcEhrMVlPY1NPU3c2V0sv?=
 =?utf-8?B?QWltZjRzT0YvVWtkR2ZWaTFIRjdLZm8vVUlPZ0I3dTVHcm1uTGM0Ym03Wm9W?=
 =?utf-8?B?RGNiU2tMZXFWN3hOcjYzZVJNWCtQRHBoZ1JYUVFqZHhqeVJ3VFNxdW9HV3Fa?=
 =?utf-8?B?M0ZYcmw2b1gwM2xZOGllb3BTZnBVNHV1SHFTK0NYTkRHRS9Ud09OdVd3UEpt?=
 =?utf-8?B?dzhReDVmOGFESEhrMUVxbENpWDZEZWQydTVRVGt6Smc5bHRQcXlNcCttZXRt?=
 =?utf-8?B?Nk1kcG45N2JUWUhCTDkxdklLNElud3BDRlU2YllqN0VUaWl2VUF4RnlEbUI3?=
 =?utf-8?B?UEdqalJETjVtWXZaMkI4Zmg4WisxTEl5YWlhOEo5aHZ1VllGUnV2cmNSaTRG?=
 =?utf-8?B?a1Q0dlVCbWhtNU5BOVV4VHNlMXMwU0hQdEJkUDdOUWloUTdNeU1YY3ZvRldy?=
 =?utf-8?B?bFFSbUM0UFFmSmM2dVpMN09QamxqOE5lNFBIQ2NsQjBRUEdWVlB5VDlOdXZh?=
 =?utf-8?B?WEFQNG1acWtBV3B5Wk5VaTJOYi90ai9ZdERQdkhURUdsNUpCcTJLOERyUW5p?=
 =?utf-8?B?K0hwYzFJaDVhNVR2NjRJVFRGYXhZUmdZcVJoNlE1dGFLbzlHMGZtMm0xeVJn?=
 =?utf-8?B?eVcrVmt6aXI1ejByOGhvY2pVbmQrUDFhRTNzUXBPQW8xS0hMVWpUUG4xWUxO?=
 =?utf-8?B?RmlqSFFUYkRrZ1dBU0RUakk1aURib0RuTXlxSmMxdFZmN0NkbDVPd1ZCM2tn?=
 =?utf-8?B?QStlKzZWcXlFS0ppUUgwNWlkNklOTzREYTkxdFpLQTNTUStianltckY3R2xn?=
 =?utf-8?B?a2ZabHVlcHdjOUFodU9kWHBBbTE3eExVbjk2cnpPV3hUeW5XSlJyOVV6aTY2?=
 =?utf-8?B?UE95VWlodytUNWdMUjZ5UGV1TkowZVlrS1dteGJCMUJHVWN0ZEpGSGxsL25t?=
 =?utf-8?B?WEpoSkRaanVaQjFGeDVJekNTNEU5T1BHT09nalQyTFQ0WDE5eERqOGRJTzZu?=
 =?utf-8?B?TmIwWDJUeVAvTlFJeXg4Q1lMaUxDYVk0NDhGM0NxenFFeWVXV2RsODJzVzI2?=
 =?utf-8?B?Vzk2ekVaeHZ3RFZGQTJaMWs5aFhkU0pSY3BlOEZIRWF4c3VDdEtWVW9Qck90?=
 =?utf-8?B?TC9HNlJ3Q1lsOG5yQ2x2eG1SVmNaWVZ1YnBOY2ZqczVKR2Q3SHFkZ2pLSnhv?=
 =?utf-8?B?UmpweE5FbnpIbHREWnBmSnRUUmpBT2NXZGljSEZTb2tsQjdHazRDUzZuWkRo?=
 =?utf-8?B?OEJnYm9EWlYwdjdpaTg2S3pUYnhUV1hnR2FJUjdwc2V3T1M1M01FMHA3Z01u?=
 =?utf-8?B?dWc5cFhRWUlRQTk1aWErV29pQmRjdDdNUW42eEc5cDhZVlF3K3RkRlFkSUVi?=
 =?utf-8?B?WlFNQVRiSTdyUWRMWDdSa0ZzYzd0YWlMMlhiTnFkR2VaMVpYRmpCYlNnaHZt?=
 =?utf-8?B?Rm5mSTJPazN1ZWtQbnA2bGg5QlMxNWp2YW1BYzZoVzhINDhySmNzRkxRRm9p?=
 =?utf-8?B?eldDYzZXMGcxaVB3N1E3K1NsY2VnWm1NT3lxQzJpV3lnSVJvZzRqeE4yU2pB?=
 =?utf-8?B?NExZczBMc0orakJmZldsRHlyLy83bndHVkZEakYvbjE1eDJsTUl5d00vOW54?=
 =?utf-8?Q?TFX0X+HMCj0jzQ/tNebMvd9bMRFl4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmNHc0lVVTNFeDNtS2lGTjRRTzNBREhRYytIekdPblhNN2lMVnhRRFRDMXRy?=
 =?utf-8?B?VFFoWXAxVVRoVVhNdFUxamZ0b1MyS21OK0toVjQ4SEpDZkR4M1kvblBTaVBD?=
 =?utf-8?B?VHNxbXRLdHFyOVd0UWlJcjN5cnVtSWZacUc0UTdNNmRBYk9aRjArU0xVWldR?=
 =?utf-8?B?SHpyMlp2Uk0xczQveTVwNDhwdDhaWlo4TnU0aHFnUkthTlkveVl1c1RUWGlv?=
 =?utf-8?B?Um41U2x4NWJJOFVFQTMzQjhaNGtHTnl3QzJiZEdhSHY3aTNkeEFMVHZKaFNa?=
 =?utf-8?B?WnR1SURoYVlKVkZYTjRmTVg1NHJVa3pobWRHeURDd3ZrSm5VeHdSdlZHZ3lV?=
 =?utf-8?B?U3hraUc4MmZlMllMMzdUR3lWeUQxeENhYWhvdGhaQ1JETTZhN3RmSDdXV1pp?=
 =?utf-8?B?NGNCcU1oTFJ6TmN6ZnJSelVZWVZnMzY1M1I2c3JGVVkxM1lFV045L3NSeDNz?=
 =?utf-8?B?cG1OTm5kSEhQcGRMajl2MHZDRm5aMno2d2ZScStzUnN4MXkxdmZRM2NZaWln?=
 =?utf-8?B?R2paYUd5NXViZEp2Y1hLalk5YW5qU1hWWEYwSG5salV6R2F2ckgvQTBwRitu?=
 =?utf-8?B?R2F5cW0rMG91emdydi9pODBjZHJ1eHRJL1FOdGYwRGhlVUw0OHFTTE0ydEFl?=
 =?utf-8?B?STRWM1pQOC82a2dvMUZ1TmdjSVVBcVRaekJXREpQWkozQzBURFQ3V0M4TVNX?=
 =?utf-8?B?ZExPdzFCV1lNR1lGT0JwaTA5NEYwSkNVZW5rNkU3OFJia0hpSEhRb1hXNFFR?=
 =?utf-8?B?ZnRzT1Y5TXJWR1dIaWhnS3NMcUFXeUM4d3BVUXR6OGhGT0x3RnlCakNqcFhi?=
 =?utf-8?B?T3BRVmF5N1JPbDd0YWRGVWtXeWFuT0pranZCb0xJUGN4UGNzeFpHU0Z3T0NP?=
 =?utf-8?B?eFNUQ3ZZMDJpZkQ3bzAveGs1UEJsVkZCbmJCWUxoajVWczBZTzVjeHc1ZHdO?=
 =?utf-8?B?VHpENjRMUXI1NkVOZWVyVldJaGwwdTR0TUdKMzRodkxPWWdQcGx6d2F4NklL?=
 =?utf-8?B?ODdCVHg4MHN2QStnbkhjdG9jbVl1UHRxbWIxRlcra1ZNa0xmQ04rYW5MbWM2?=
 =?utf-8?B?RmoxQUgrejJkZlh4dmR4di85U29YaW4wZGgzajJZVGliT2xNYlIreDZpWTM1?=
 =?utf-8?B?TUJ1bWw3WjhRdG1wRFU1aEdkUTU2QWdRM3RtSGlHbHY3VU80d2JOOTQwZ3Zi?=
 =?utf-8?B?TXM2L1l4L1A3V1k4V0ZacWg3VXY3WkE0UDJPcDJFVFRpeEs4RjlzaGRaQ2Fa?=
 =?utf-8?B?ak56UlMrbUNTeDdDWkNFSlJ4azVFWWhXMmRRRXpMbWwwN3czcll5Wm1KMGpx?=
 =?utf-8?B?d1N5eTduZXhlUWZvbytvUjhzNmV4Vnpzbzg0NFlpUUNUKzJCS1JQNVBUb1hC?=
 =?utf-8?B?RkZPOTgyTXJ0WDN5VDhGODRIczIvak40dVk1T3hhTzBXMmxmd0lZUmdLbS9K?=
 =?utf-8?B?Qi9HeCsyWWxBUWg5QXpCTkJ2cXgzdk1VRkNpRStTd3duL3B5MmM3dnNxL3Zr?=
 =?utf-8?B?YnQxek5la3QzVTRQK1FsNU9QOUJoYjNJcWNGZFBEVXhYYzhHMFF0WkovRzdF?=
 =?utf-8?B?aGsrQVN0VUpYWi9aYkJkaDFBclpVbm5IK29ITHQyMmRqZ0tLRVJUTkVwS1Qx?=
 =?utf-8?B?U09aa3ZrVlg4OXg0RFd4ZHJUTkNIWGQyczZqUUhXdXRjWWdpYitMR0RudVJ1?=
 =?utf-8?B?TWpuSnpnQVdzU1pjVXNoUXlzWGJPMjlBMkk3RGpTQTZYc1M3V3IwS3B2WUow?=
 =?utf-8?B?d3lvbEdxRFJveXBTQVF1VHp3WkJFbWw4V1dzT0ZmeUZPNUVsZE52dTVNU0RM?=
 =?utf-8?B?a1ZiRG11ZSsveUNHZjNZeitOWWE2M2VLYWVTN1NMeU1rWVJIb0s2aU5xc21I?=
 =?utf-8?B?QjJmMnVsZFB4TFBlTXBPWDQrd1RBYnJCa3ArNnhQM1JPWjlRamErSjA2SGx6?=
 =?utf-8?B?dXM3bU5sd0J5VWJPell0YjZoOXVzYmhKS2NjNmlNTTMxY3czN0ZJWmhUR2p0?=
 =?utf-8?B?QmZ0RFFWYllDSW5kWElUTXlMa0RNV0RNMG1iUVN4SmdzYlBxUi9wR28xam53?=
 =?utf-8?B?MXdLMUpCemh4TDVDMDZ5VTVmK2JqeHhwcHJja3B0dnJnMWRaWUNBQ1FSc0xL?=
 =?utf-8?Q?oYvynvH1AW50FAD73z/XDgZd3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1668287-0037-4885-daee-08dddbdf5097
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:37:13.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaHR4kkrq0CyD2suTD6GXhZSqumDJxCNfzW/pMblhhMkEDS79u5OlhEE0ZJZ51TY1KA+gaaI3xhMzgBIEZEfVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

i.MX94 has a DDR Performance Monitor Unit which is compatible with i.MX93.
This will add a compatible for i.MX94.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 8597ea625edba5d0e2a3373ae6cd45bb1ba351cc..d2e578d6b83b8847c7a0ca9d5aeb208a90e2fa6a 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -33,6 +33,7 @@ properties:
       - items:
           - enum:
               - fsl,imx91-ddr-pmu
+              - fsl,imx94-ddr-pmu
               - fsl,imx95-ddr-pmu
           - const: fsl,imx93-ddr-pmu
 

-- 
2.34.1

