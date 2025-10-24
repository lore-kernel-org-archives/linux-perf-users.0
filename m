Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199F3081BE;
	Fri, 24 Oct 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329868; cv=fail; b=r7gzpEjNxpxaIuOV+HPFPXytxs+HhBtC84499LNDFX00i/gC809DXsD0LPi17EPPjf9ZaSqvr0MMnNKrYizEJDGbwvcc0pMqSMsNGf/X6o4o0bC0zWOCn/ad6FZLq97AYIDNtqAPlb818QKeW0znJesljbUnTJhzqrwritTzhEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329868; c=relaxed/simple;
	bh=TqMcqW+Kxz6E/IDdqx3tbGfcadJsWFZWwfFnfFLUkqc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t9y9hwZWdGZCzA+cKUzmqFfLyPmtoFdtS1cnEo25XcqQK3270zCzwoMBO0/Ll7wDwechoaMtUYgBfqu7NPIReb8qPOBrwOI3dUeu9F6sZWtYx1lisI4vc5sAxS+LnbMiujtNSRAV9scsNDH//2UtyQDz9e0ssmLS7VLYOLdcjDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PwrdrDy2; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PwrdrDy2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRd42FJH1cFhb+nw5LOxZz/BM3DZy2f8/g+i/E2h2K1yEniLt0LOahZxUbGugIzu06aDtLgZo79zzRniIWd/icOwaNVUDVcXOrON8oNua8NoUg+sSaCH7ZhImLXDEzxjyraQoNFYXU6ZBoFVa/QchxJKd2EkhWvGplnPghThP1Pit5SBmlZZX+LzqB2x1+D1jX6I4f9JGv2KfoE5VsZdNFtonsHwqUAeUSk2B1wda1zQnHzLxTnGO2Yxco4W//VBz3aPTdiy9Q0ETDINAcOK6kZVWKhaNAQOGOHeqtXdOZgjafCjE0OUznDSsXkQ7r4Ss6Et56YGM5iHiKHKY38o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzqdn7CrUP1/Ij9Q4ieLj3cGHYshb9divfuyKT3t8Ms=;
 b=nLb/xHTbP87twXFgb9xuzqWxOFdHjYZglgOl+HF247kd2jflBBomB1JE7kE73vjAc5UoY2d1AdopO9YijHa8lqaR0GDc+SA0VYnfA8KuaWIGI0ZpfgauFBC+OY14/Cqg7P8A/xGA6Jh45/7IaGGTHVPFcyBeUbPFdh3Tbk0eDuvB1iWrau51S0oMllNfewyKb1r3kY/LUCV/K+KCyXXrML4g0gT7DJYQIOoXWAXPvmbs5ds0RnS4vpKyW/hxVmakgxgaTQTt4r1GtT9RIBhJF2sQjp+o1d3uJrpLaE5/0Aj0bIk6GRQcNUpOj+e6zXwgXDOpqhUmcYSbsWouC4fYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzqdn7CrUP1/Ij9Q4ieLj3cGHYshb9divfuyKT3t8Ms=;
 b=PwrdrDy2I/rGn/QFDMfnWe6geoOgnn0hZKvQO/vt8zwvOfg4QJJuWuUkOhA9fRxLKpdws99RRh4OoWM5tdCxQfaRHdT/+iZtOUZ/eZvCK3V2lAE9YDe04rlTwb/PqEIu/8leRj3SptZm0JqtBKPiGGRe21I33paLWBxY0/u389RGEO+1KeF6fLheryRFszbFO3rP3xc0UbyXg+0/96sLU3IIuegZpOMlSdIqn/SvJUM0p1sS9f3hvreFKEexbJaTB/E9QHQGAXouS+mk9OK8oN2C2/a4bSakDW8NsBoKFKXEWCTrg5raGrBpRywI1KLyiuOp1d4VIa5ICWrSc62xMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:17:43 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:17:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 24 Oct 2025 14:17:13 -0400
Subject: [PATCH v2 3/6] perf/imx_ddr: Get and enable optional clks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-qm_dts-v2-3-7a7e07022ed6@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761329844; l=1320;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TqMcqW+Kxz6E/IDdqx3tbGfcadJsWFZWwfFnfFLUkqc=;
 b=PksEWhGAJtg4+IGWF6TrKhxvYSLQTmVU/hDE6o+ztOaXwB6ugj+TE93fa+6Ghaxz8ys87TtE3
 9rRPLv398nHDk90i40OWyNs05ht5nBo5GQx6XikpODWPvDC4iTYBag6
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
X-MS-Office365-Filtering-Correlation-Id: becea6af-f7f5-4c8a-be47-08de1329a026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWN1MmQ2ZSt5ekhrY2laMkRBL3UrZUFvQW16VzIzNmlBUDNtcitKYlBMMW5q?=
 =?utf-8?B?enpSMnRuNWxyTHdsOHY4YlBkbnc4eSsyQmp4dUlpUWs1MlEvUlZPZDFjaXpZ?=
 =?utf-8?B?ZHQ2YUhGdzQ0VEtXdHFuTVJuU3laNlV4RktuZ0lJellGQ2lpNTdPTHZ2RDZQ?=
 =?utf-8?B?RWU2bTNJSXdCMjNOK3IxVjdzbUpEQkcvQS9MYzIySkhDdVV2anVVWlU5dDdx?=
 =?utf-8?B?Yk9sY0YwcXRFMksrLzliSnBzOUx3M3NVQ0FmM1NBZGxuL2Jra1N6Z1RxVVgy?=
 =?utf-8?B?ZUZDWnZsb041N1VEVlJLS1V2MjFhazZJZmZ3dXN3dm9rQTZmdVRoWDVNMytC?=
 =?utf-8?B?QTJwbGZuRElLNUpTTlBFODM4cFdEb1ZTdTVGeTdCdDlTLzFTay82cUlDeGhS?=
 =?utf-8?B?MWwwZmZ1TG9JMEp6VWdKbWp1VEFxNXQ2K2xUSG40RGNQNUMwS1BrdGpLQmtJ?=
 =?utf-8?B?RXk4ZkwwTlNFVjNaUEZKMXhmVHl4a2ptMzlxVVBVdTBJTVV0Smp1NERhZ1BV?=
 =?utf-8?B?UTJOaG9kUnBoWnFJWEVIT2M4OVpjdHZaNE1MWVlPNFBTUWg1Mk53ZDkxM0Q2?=
 =?utf-8?B?SXR0SnRlODJFNVp3c0k2RTJGSjZnTUJINkhkUkxCbHoxUGFTcEJQbUJlNTg5?=
 =?utf-8?B?SSs0V29tQUZpQlpoSlZCQno3TnhMcXFsZ1IxRDg0d0xWRm0zNFhTcnZsL2xC?=
 =?utf-8?B?Vk5QTmRUQ0Y5WXZhaGYrVy80TkRMRzY2ZzI1eUdsa0ZGanRvVVpCMllDd2Js?=
 =?utf-8?B?c0ZWelZCeTNNU0JnNUxyaUorcHdSb3g5Rnplb2htNm9JRVNHemtyVDUzRzEr?=
 =?utf-8?B?SkFLd3orbjk2V0NZQ1lHVGxxT1RHWWFONkZSdFgrak1XNGxCdCs4cnEvWnMy?=
 =?utf-8?B?WTNqMWhJcVZiNk1oNmgyZmswK053NXVGWVNYemlpUEdnTXNuYVFac0syNXlh?=
 =?utf-8?B?N0lwN2VYeUNnVk1Yekg3TFIwYzhvR21yeG45aW9weWpaK29UODQrZE55cWFo?=
 =?utf-8?B?Z1ZHb3JMQ0J3UUVhV3BUbmwzdm02VFgzSkU0dFkwbnNNUmtYSGR3YU1YY1p6?=
 =?utf-8?B?THJFd3Q5QVZYLzQvbFhoNThSeEdDSkdOektqZU9OZWNxQ1lmUXpzUzM3THVr?=
 =?utf-8?B?WUY1ZzlYNVNpY2t4ek9GUkcxWjMxZkxmNGVBUGZNWlFwVEZOTG5PaEZBenln?=
 =?utf-8?B?dU9ybE5iOXA4bm1FaXhuU1llQWxRc0hQOFdKM09IQUFXb1pGV1RoTlZha1cw?=
 =?utf-8?B?VTJlWjJ4enFyY25Sd3Qzdm54YlFaSWRjcG85cVd0a3NHYzh4S1dqTEJLMEIw?=
 =?utf-8?B?SWdzcktPdVd4ejViR25MaVdtMnZIZ1RnMWRRODBkVWJVWlVraGhYQklReDJK?=
 =?utf-8?B?QmFjYnRFUTE4dWtqY1hCaDFHNzV2MG56MGpDMjBuNzkzRDdUOHRmZkY0Y01E?=
 =?utf-8?B?dnpmNkYvSUJjSkp2K3lMVkxqams0RGU4RXZvYjB6amRpM0dPdFhoeXFyQ1ZI?=
 =?utf-8?B?YnNDbS9kQ1ZqOGQ2eEZYUjFIcUpWRDlIOVF3SW1jSFBrblNmWUROMUdFRWRY?=
 =?utf-8?B?WnF1b1dvU2tCMWF4WnAvMUxWc3EvQ3hvTUtCeVFndGVKZ09vZEUreldJNGQw?=
 =?utf-8?B?RCsvS0pmQi85SkJaaThrcEg1Um9Kb0dCa25WSGtldUpzRFErSHBKU3ZVNldY?=
 =?utf-8?B?eEJKdHF1enhRNGd0K1BxN1QvSkhVWXE5bGY3L3RndU9lbE9NblZMbWtOYnFM?=
 =?utf-8?B?NFZkZmVqVXpiOEhZVkVKUExrWmtzaTVUcUVrNHczTW9XK0hrYm9iTVBScHcy?=
 =?utf-8?B?UlZHV21UVzBYVlh6M3o1Z3hjUzZIaGVIVnQzUGdvRUNRaVlBVDd0K2VCVWFU?=
 =?utf-8?B?OGNpL25sUzAwQ1JmVmh6RDBPS2N4bW9NbVlqREI4OTRhd3Y0WnRuQkI2MjZR?=
 =?utf-8?B?VXU5QTBwRzc4V3lLUStDU2F6QlpFcmc5Q3Y1UzRPYnFmc3VYQVYyR3Rhd0pi?=
 =?utf-8?B?N0tsclJ3NDZTYjJxVmZ4UTQzOUhaaFVyNHVZMmd6VHN1Q01jTEZSK1R3dmw1?=
 =?utf-8?B?dER5VitibisyYWl4MHg5WFY4dFpPMVhTdG00QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b01TbTBTRGRVSUVNVk5QcmZaVzY1MExycjVtMDgyMHllRW50dnoxcXNYRmpF?=
 =?utf-8?B?NmlzUzBNK0hZdWRIRjZHaEpLOVZKQkpMcWpibmxyYlVnYzhBemk2OHhjUit6?=
 =?utf-8?B?TnI4SFAyT2UvWUdYNjdWNXlkNlBBR1ZmeEtQdy9Ha2ZKMllSV2dKait5TEU5?=
 =?utf-8?B?bEU1ZnZSN3RUZWtjMTl0YzFzYWcwdFVlaFVZTytsY0lmcXRLY0dzbUFiZXZC?=
 =?utf-8?B?L3plOVlNdVRPeWJIaEJuODBXZFBjblExdEpsVXcrRkNtOXJ5ZkZOcFJlVmxw?=
 =?utf-8?B?MDJRQk5mbmJuL0paSmxLUWJ3NmRmVGx3QThEd3lFbVdqZHAzWEFWR0EvYVFB?=
 =?utf-8?B?RWZmUVdTMU5IeHUrM1hCcG1nTnlNOXQwYk5vLzJDNzYrYWM1Q3VObWxwYVlz?=
 =?utf-8?B?U2tsUWRTK1hmdE02WUFleGxET2JWTkZvR2lBamZYVm1GWVZJUTduVnBybGRS?=
 =?utf-8?B?K2IvWmNpY1dvdmxReFQ5RHVUMVZjWkM2dFU4TTM4MUt0bUl0bEpKaEJHZEJL?=
 =?utf-8?B?cUQxWEJXbms4OFU3VDhUdlF4WjZQdmZuZDRxblVYQW5qTVlKbXBuR0xGei9k?=
 =?utf-8?B?UWNSUFc1alA2ZnNkOUhvWWJ5TW56MC8vNjBwalFYUzRWSVptVVVRbU5SYzZW?=
 =?utf-8?B?RjF5bTBzUVNjUTRLSmNCUStNY2kyNDhpdTQ1eEFlZXQvWlVxeXlQSnRJMjFv?=
 =?utf-8?B?OWFjQmkrUUhvNlBBblh4d0tzYXRzd1UyTDZOUXR1TzZTSEZBMnR0VUtGajNa?=
 =?utf-8?B?aW04cmpTc21YUnpDUG4wa2UyTzNoVUhVRzVuWWcrT0srYWJWR3BjSGxhSDlx?=
 =?utf-8?B?dVBQUzlZUkppUWNRak1NWkltaHVQRkE5bWNtZ2VuMXVjbEhtV3ZQbTYvbVFo?=
 =?utf-8?B?MTkrQTFHYnZGT2pJVUlTMHRSYU04UmJrUEJGQkhWTGt1ZkRjZ1Z1Rm83MEVQ?=
 =?utf-8?B?UzNqVUJ2eWlTYlFiY0pvZWZMVytzNWMrbE5NQ1RHQjA1VndyMUM5R3RoaFV6?=
 =?utf-8?B?Z293RC95dmY5ZzB3R2NLSjdJV1RIbWxXVDlGN1VDcnZaT3Myam90MnlRdm5m?=
 =?utf-8?B?d0s3c011RHNvSVB0YzY3eGZvcjBadk4rYTZ1NmlDaGs5MGwvc09XdGJZTGg3?=
 =?utf-8?B?MjlGUW8xcitSVUhhTEJ5YUwwR1RIQUtpVk5KNlY2WWVlOXVXSWhMT0s2aHRX?=
 =?utf-8?B?TldKRmVmL2FZU3hna3VwUENlbE5rOGJCRzVIMGZHTXFvTHBnSUlMcGdQSmU1?=
 =?utf-8?B?RFJrL1M0ZEExbG54T2tpMVpNNUdDZ1dTRzBzVS95TTEwbzRoUWIxYW9YanNj?=
 =?utf-8?B?VkE0MDkwOUV0TDQyK09PeUlIOU5xYVVncFdXMWFDNWpZdGNnbjZqbnFHalBm?=
 =?utf-8?B?Z0pRVFA0VEl4L255NUJYWUl6NVYrVTNsZEZYMkxaTDdBb1c2SU5XdENUUHdC?=
 =?utf-8?B?V0Q4blhXWHdJdjNSQUFBTE1UM2xqaWcrNkZtcENjWW5LWDUxS1gvUXBQdGpQ?=
 =?utf-8?B?T1kyMWFoUTZGNTNVL3UvRGFkZFZETzVmcXlOVVo5NFJMQnN0OXpPK1pYKzN1?=
 =?utf-8?B?aXUvMU5oOTFKdnRUQllUYXpSSWFySjBscXBvSml4NXpiSlRTT2wyRmJZdk5a?=
 =?utf-8?B?Nml2b2hhSEVPaXhvTUNPTTRWZmhwbHB6Nlo1R0dFZllPTmRnNnkvWW5hWkIy?=
 =?utf-8?B?M3BsTHN1T3NMK3FFOFpkdlRPanJrL0J4a1VmQ0o0cVI4S3h6RWRxNVRzT093?=
 =?utf-8?B?Y0JGaHJVSHhLZ3BWUHBVMnU4TUdxQWEwUUoxNmdTZnJMNnpITGorQjJHUWND?=
 =?utf-8?B?dXZMalI0SFU5T3hxcWRBbzhzSHpTYnJycnB5bnAzZHpzTXVYZ25SUXhlS0R4?=
 =?utf-8?B?Y1ZPL2RKOVY0akI0dXhMYXFDcEo4ZzRtZzJadFJZbUhoT1gxRnZRRmZoTkFB?=
 =?utf-8?B?cUZoK2Q5cFBYYTE2a3B3NzdqbmttVU8yVWVlU2hCS1hkc09qRmkwbzE2S1Bp?=
 =?utf-8?B?ZUxabm0zSnduYmpjTWZCajdyUUpQNGtZeE1aSEJndU1EQlBwTHBEZnBNRjlm?=
 =?utf-8?B?amsxcVZEUWtkcVN4ZTVHZEJXTnNsSTg5cVIrNnNadnZLNEJDZHdZMG9lYjkx?=
 =?utf-8?Q?n1lK3dMjyuFuOYriW7WMlcvgZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becea6af-f7f5-4c8a-be47-08de1329a026
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:17:43.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqtCEYYQ1FyYZAXD2KSWkKlc14stFtiSoqPeovnRFQKGO2/sBLVBYzTqLnS9LGoJ567IootxEQ0C5Q3KjNOK7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

Get and enable optional clks because fsl,imx8dxl-db-pmu have two clocks.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 5ba34c606213d255edf27081bb9f63763cca3066..2a8426a74af98cf46725c2c70534829e198746f3 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -732,10 +733,12 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int ddr_perf_probe(struct platform_device *pdev)
 {
+	struct clk_bulk_data *clks;
 	struct ddr_pmu *pmu;
 	struct device_node *np;
 	void __iomem *base;
 	char *name;
+	int nclks;
 	int num;
 	int ret;
 	int irq;
@@ -754,6 +757,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu);
 
+	nclks = devm_clk_bulk_get_all_enabled(&pdev->dev, &clks);
+	if (nclks < 0)
+		return dev_err_probe(&pdev->dev, nclks, "Failure get clks\n");
+
 	num = ida_alloc(&ddr_ida, GFP_KERNEL);
 	if (num < 0)
 		return num;

-- 
2.34.1

