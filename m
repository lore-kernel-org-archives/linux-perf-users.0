Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA6436CE08;
	Thu, 21 Aug 2025 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774141; cv=fail; b=iPSeSstzys1xqWeBQYwc27oKwOspZaYMwubE2OajUfSZCXBfqwmWYsZhF5ZtuF8OeTS3gbIUWJV+y2UCnalYH8B1RY5wGc0zFO2bOwDjmTcvuAXBlDq+hon0Z4D+j7Ds3Kd1amyxEP9jE0GjdN0n2fyGWzbHvU3cJDNILvgu3QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774141; c=relaxed/simple;
	bh=6utQfHy4r+9CUoJKXGUjVkpMirtTXenRF5mLLtjKncM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tANRIeC4fAFtwuwmJrljqN/1qSCO3tR4az2IZ/w+GlS9CVSUqYBR0j3D6OYrX2f8A1dS6SJKgMuqYWkSgST/qaKhX1fPuS5hO66temntKbc5i1zkjZsGuJEfySKDZJX2SJSTzHH027o5CREddt36UMrKXc0YpHVC8WTiHx7Y+Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g1KCLpTp; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1KCLpTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEENh/SpHYCG6QaqIa7GfK26Sf2qL2OZQkg7enHOkw3Nii6MCWJ4xr19oczAr7IN3M10pzO2TNqSmSzm7JhMui4OhfJoL2BaL/XlbDR78iupza4huAOU+MIeiulJqPKfhl8dzQKR+SuqB4JYbCk6dTRlWUzDi8HfSsnmgwUD5LDWhy2222/F44JECFQ649rSmkgOj+XuLUb06xetTlcrJXy52H9yL7t8Of7q/R6qcNTyRVHyHFVsvuy8ADIvpwRVdzJzMSEWQ3I0zIcTpzNlVu9K2J+WeFFO7p4Y7DR/8ScLAlhzARlFyQOvrwYw2rgc4wqFJ2scCrHPyIcnkTomyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhrKMFo/VsPQqNjfXNjAqS46zReffM34GEnqjIuSzcA=;
 b=mSLSC+JI9fBIIFJtbf0M8nX3WQJiRHst+dL5O4X4dSmT3/mxSlQFHsM/DLRUP+/uK8er2BDbFy9EPv/jz2Wx+Y3ARHWPg8sUEP0vbb4iHwmitiaZBgqf7Dv9MS/DAsqX5wfuVsqA4OSI8RZ/vCsftZ1boYz8Tf2USI2K7foSIAQr5o4xVr8gIaMDbwwKx3C1b3KDNv8QqMoLIx7K5wPaCflzxA1RWracRAoyQo0kvzumyPaTra4BIWYLzLoPpDP4jJDbvuyUxlAlmgUjtYrhOQ84j6qKUB0EfGVLxXsQGilc+RR1FC//X66Uzax5avy4d4HTy6qBAtBzbqfFbEbjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhrKMFo/VsPQqNjfXNjAqS46zReffM34GEnqjIuSzcA=;
 b=g1KCLpTpEudigIQ+CjGjKSc+pvWlRKwasf6CC+EZRGeq+ErCaNqpccs8G/zr7tqmNPGZyQbewMLFiXeooYPJXzijFyoMXeikWbuCEQ6kxVf+WIcZlL1HQAcvE6xXbrtUtL0XVdnaYmG/pUfBWwnh267Q32uWrNan1Tr0loEGKPjpJPnWyDsZU8/BpRf9ePp871jEIdIBiQ0BxDWGdidgBis76346A8royB3D6tETaTxEBrAtKA4H6ASfO+XIG5irIP5kR33OTwm6grpU6FQbVZG8yC44Ye2Y7MfZKDw10+jp1EYcHM1b2WOfDU5KOa+Bt7uBixplVRGGdDoUMSYUcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI0PR04MB11540.eurprd04.prod.outlook.com (2603:10a6:800:2c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 11:02:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:02:14 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 21 Aug 2025 19:01:49 +0800
Subject: [PATCH v2 1/5] dt-bindings: perf: fsl-imx-ddr: Add a compatible
 string fsl,imx94-ddr-pmu for i.MX94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx94-ddr-pmu-v2-1-052c6420605d@nxp.com>
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
 Conor Dooley <conor.dooley@microchip.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755774118; l=1029;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=6utQfHy4r+9CUoJKXGUjVkpMirtTXenRF5mLLtjKncM=;
 b=pbp6ak/rj5ilnIsxc1YsSkKRx3J0OowyQViLymC0f/gTL5oG364mPigbKC3G76EaJfcMiHAIa
 qzfUcwahcLsDDioJIkg7Sqqrw1veyM3r4BK/s3xG75cpaUByr9HNCvj
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
X-MS-Office365-Filtering-Correlation-Id: d3c586c0-8703-42f1-fd93-08dde0a22f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1VrVEQzcFIwWWd1eldyL3grWkpNZzI0S0F2NVVnSS94amZxZ0JFMmcxL3Jx?=
 =?utf-8?B?NTZLMW9HK2ttbTBBN3pzZkc5dXRMRWZJNlpkUG1YbE9hSmxmUVlsb2g0cGNP?=
 =?utf-8?B?SUVSdUdQNkdhQ3BiRUFPYjl2dHlKT1VyUDdiaFM0RWt5a2o2azE5Vk1FeFNv?=
 =?utf-8?B?TW1LOThROXRrajlWWkd1WkR2OHlJWlhnKzF5dHNJZGtOdW9zU05jMlBtR0pR?=
 =?utf-8?B?ZGN2Y21KRTZmNHluMzlRbDJuQWdzRzM0SWxEcXZJTG5wMElYWVNDbkF6dENK?=
 =?utf-8?B?Tm1wSGhRYU5Da2FHVWl4V2dLTHBYMTcycm9jaWl2OGpxWXlXKzRQN3VOdUVp?=
 =?utf-8?B?TXFQYjJtT2ZBWGlQVDdNUVVGSk5qQUVKTitiQmRQaC85YTJNK0VZc1hOUTIv?=
 =?utf-8?B?czJMcmNYQnd2d2tIVmFrMkdwSTJGamZyd2JiMG1BMEZ0V08raHB3NXo1RFls?=
 =?utf-8?B?TU4welQvRkdUZzNtVFJhbDhOVkRnWVl4ZGgxc00wLy9RUytDcWQvMEJ4b1Iz?=
 =?utf-8?B?RXZiV0JkSit0MVZWU1BlTzVCUmZqOGRaRUd4c29IRXJvQ04zWXF1NUxHRGtn?=
 =?utf-8?B?bUkySE9UNkdYL3E4eGEvNjBHU2pTVVZ4bERRdVQwWDRVQ0hVUTN1UXhZSjB0?=
 =?utf-8?B?YUVhSGxwMGtJa1R0MEt5eGpINmlvRlVaTm5NSGFYejRqK2ZIbFpCL1dnUjhN?=
 =?utf-8?B?aHBxaXVnb3QxYmFEU3RrR0FTaFJhcEw4bVVoY2Q2OGlFd2hpMSszekozWWdW?=
 =?utf-8?B?YnVIOG92SFZpRWUyRFJqc3pIRVl1VVpTVEdEUlJ1K2ZqWjV0U0lKcWFUNHlG?=
 =?utf-8?B?Yi9tOUdhQW96WmI0TnQ1dU1yVkFvZXBlclNKYVBPUWdmZW9ZTXNINUdyY2Zv?=
 =?utf-8?B?ZG83TmhLT0VOZi9aOGtINlNSQStTc1BiUDZERmlobURjeWhZYzBZb2lHUGdY?=
 =?utf-8?B?YWVSNHEzOHZnM0hHL3ZKeCtKODR4cnp1d2pXbElRM2FobUQzSjU1NjNTclZi?=
 =?utf-8?B?WEd0dGlScjJxY3FiMnBDOXRhY3NKbjlaVXYxckZWUTVRSmFtcFQyQnVtdmhJ?=
 =?utf-8?B?YUVzdkNzc0hJZTNxcnNkTElnRzU4ODNJbVd5bzBCZGZYN1RoWS9DSTRZSkhV?=
 =?utf-8?B?ZVVYYXZuYVE1elpNQkFSeEpITlIrYU1rU1Jib3k4MWhGRkcrRzNLN01PYlU2?=
 =?utf-8?B?N2thRnRsZENtRnMzRnBFRTl4K09tS0VXWVlYNzZ1TDg4T2R0bW84a3I1SGw1?=
 =?utf-8?B?Nmt6dnhaMVNSL0tValp3bjlkakVLNUdUd1FhMFpLaVowSkEvV29YbndCTENS?=
 =?utf-8?B?dFBsaExSL01ISnlXSy9OYTlTSGV3MTd0OHRGcElxYWdPeG5LcTY5WldsU0Zr?=
 =?utf-8?B?U0d4UUFLVTFKZGJMbFFMWldLYXhYMlNQbUNUMW1qNUVOYnQxb21heGNJa09C?=
 =?utf-8?B?Z3k3RktTNEtpVi9SWVl6RmwwRHVjNkRGeHhDVW9mWDNwdGp1Slh1SE02SHdG?=
 =?utf-8?B?NlRlRVRBdUNqRXRIYWh4a0xKai9yVUwzRzZlQVVubkI0aW9LMjAwVXVHT21S?=
 =?utf-8?B?OUJHa2xNQzR0ZHhGTm9PTmJwNTVCbityclFRQkZvekRkUkZvdkROSnYxZ3Jv?=
 =?utf-8?B?QUFLTEVJMTUyYVNtUlVoQ0Jseld2cm9CSTE5ZnpNKzBNemxrb01MMklzK2RQ?=
 =?utf-8?B?SDhEdG54MW5hcnZnOEhWTmFvQVBheG1tQmNMT1hQUGFvUWtrTmEvVmdNMHNI?=
 =?utf-8?B?TlFSMW1mZVhrSERWWFlJM0Q3bXBJME5wNXB5dnFmOWMwNkNqc2pxSXovQXc2?=
 =?utf-8?B?amxxV3Z1T0lubkNHancxUUU0QWpYN1IwaFoyVjVjMjZqSll0Y2hoQVlHaXdZ?=
 =?utf-8?B?eDNwZ1R2Z1NNVmJNSjhTOWJ0SWR4VitiNWh0Z0RWMDV1RTdUN1NibSt5b245?=
 =?utf-8?B?dHRRWFNDUDg5RTI5VGs4SGxza0tlNEx4R3lzMWNPendwM0Y4Q2RkQjNjZUpt?=
 =?utf-8?Q?zDQsytafibnqcnFQnIg9LnVdihR3vo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGkyOVBQVXFKVGRyb3RidncyTUcwbHZDUmdlZlg2UStTbTNzQWVnMERwd3Jk?=
 =?utf-8?B?OEJLb3hhSTFqVFRvRkEwOVB2NnNRcDZQWXdOdExSeVdvQk93US9hU3kvRjE2?=
 =?utf-8?B?WWJxbjBSOTRjMnF3SUJRcTNtNWhZUUd0bW9Mb2VoaXo4a1JiQzVPNkVwNXZS?=
 =?utf-8?B?VjhJbDZvbXE3RzByQTc4MElLR2NRNUYxeXJobGJWVjJiUDA2RkxMSU5KY0F0?=
 =?utf-8?B?L0N0N1JiOUM2NDlxRlpHbGo0TElqNkJQYlllYkt4Z2lqdm10S3h1UE40L3Vq?=
 =?utf-8?B?bitaUjJZbXVFSG8wL0ZrdDZocFVHNTUwVnVMTjFWSjVON0w3NElCZ0VxUi9u?=
 =?utf-8?B?UUljaXQxTjhmaXQvZ0h1R3N2RVVseU44K3I5QS9Pd1l0c3NZOFZhbFJvS2hz?=
 =?utf-8?B?dURXTk1jTzU2SGRBcVVSa0VNbzhQbk9QWjBzVDVEdjExQms0bHZXTUtxeHZa?=
 =?utf-8?B?MXNaSzJzVGVyYXBSOHVlYTd6azNCQVprV1JNUU1WSmd3WjhnNVpDWjBPcFNC?=
 =?utf-8?B?SVJScE9SNU1rbm1JRmdTb2ZkbGF4b2prT2V3Yk1aSTRoVWh3Z3RJa1pFS25E?=
 =?utf-8?B?emFIVUV4a2FQM29JZXdIWHp5R3dIa2FFWUxWY3BoRmVnNFZkclRSa1NicjJn?=
 =?utf-8?B?ekpYVjkxWUxuZGdQcG0vS2psZEFJZE02QjhxSFpSQVprVVpvdWk3eWtsaUps?=
 =?utf-8?B?eHdXbXduNWpOYk9xUHltcm5WcE9jTDhTaHZTd3FkU3ZJcmNCVlJQd3JXV2kx?=
 =?utf-8?B?WTRMSkxsejIzcXRFNi9OSFdjdDlqbU9MZ0JvNXdsb2czeUc5OUFJa0JkSVFt?=
 =?utf-8?B?Y0wvUEpBNXBPRHlXMG4xMWhETk9GWElJRTF0eWY0YnNyL0Z0VDJmdzJZek9R?=
 =?utf-8?B?MTQ1OEZVaFZWSG1TR2RCZUF3NnFod09yWjZ5TXFkYWdCRUxaTmE0OGJZK2xt?=
 =?utf-8?B?OW8rQjQ3OEdvUkFjaVpRaFdpOEdHVjBDbURGR3RFajF4OTYyUHc2ZWN3K2FR?=
 =?utf-8?B?bnAvUU91VlIvMFNBMGErTWZXeW5CNkpnU1hIWGpmSzNkcGJKMFNKTlpRaGhI?=
 =?utf-8?B?MXYySndVUS9UcWdjZk4vakVrTzdpcFVuTTBvQjdZSW54cUgybVFtT1VxdHJm?=
 =?utf-8?B?NngwbmRxcTFoOGd6VVhvOTNtOFRGenAzdkxWU1dqUE9FT21aSU1FZURnTXB0?=
 =?utf-8?B?MUxST0QxK3JDRER3OW1IWWRBSEtlclNSUEE2T2JMcUpvbzJBNjlJcHRVQ3Rh?=
 =?utf-8?B?T2xiY1lrMjkvYWpMK1FRTndpRU5Bb1pLRlpaRnRNZjRaeUJhN1JsWGNpSlJS?=
 =?utf-8?B?dStwaXhrc2NkT1pTS2FJc2kyRWFITmZWb2F1aVNvTXd4aVVTRFJhWmZzM0xM?=
 =?utf-8?B?djJJd29vZzVGby9FcFFtQ29sa0dQcHl3RG11OFIxTVRENXJPVXRMNXJFUXpD?=
 =?utf-8?B?QnB3SDhHME1GN3hHTGx2NE1zZmw2b0U2aVpvR3plZHk2anpFNFZlaWFrbm5G?=
 =?utf-8?B?NUJuYmhVbFJVT0RSNUdBVkhEb3J4dU1Cc0dCN2NvdDNvSkxWWENCc0daZlRp?=
 =?utf-8?B?TWF6eThVV0FZK1kzdmpRL2VoZGZId0RRbXYyb3NJNk1tYW0rSFg2K1lGNXRZ?=
 =?utf-8?B?UUo3SGVCOWI2RXJWWVU0cFBXRkpIM25La3JyT3RDbndZdGZzaTU2ZFZvOXFW?=
 =?utf-8?B?L2JhSUJkQ1ByUWc3Wm10bUQ1cXdJbXJESDVmV291Q1B4U3M2aDhPRXFvc0F3?=
 =?utf-8?B?N2psa2c3OVNSWU9VVmt2d1U2RXg5WVBiUm5yWFFicXZWdjl5SHBWZ1I0UG5m?=
 =?utf-8?B?UmliakdsU0JhQXcwY01WYi9uRy9naVNSblQzQ3d5K2tkNHRqSmM2REZ4Wm9p?=
 =?utf-8?B?N3NhMnpYRUVwbml4ZWdES1pTREw0dkZGcjJFdU4yeWFKVnMvNUkzcHFvNWRG?=
 =?utf-8?B?VTRBeXZUbnhybkNJeis4ZlVZblJxOG5LdURkc0EvMUlvMWtMS253V1dlejUr?=
 =?utf-8?B?WFpKc3NCMHl5VjU0VDYxdWpGS3kyaE92NlQyVzVYQjVtVm1sQ3ArT2x5VzBY?=
 =?utf-8?B?ZUJ5dHh1WWdVTUtjWXArY1dFZDdnQW9KTGdnOEVJU2s4SERZSFpJZm4xTDVj?=
 =?utf-8?Q?szbQnAJ6ivi+ThPjQ1sDSmHhE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c586c0-8703-42f1-fd93-08dde0a22f39
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:02:13.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBLODqv8vKDSB5DG9En6PBDJQz9mb+er22UI1Chbk2ohuWWWZpy5FOB6HwaJsPiLixFQcCv4KLKYGz22StKkPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11540

i.MX94 has a DDR Performance Monitor Unit which is compatible with i.MX93.
This will add a compatible for i.MX94.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - modify subject
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

