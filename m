Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1382BD022;
	Mon,  3 Nov 2025 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206532; cv=fail; b=dW0qKPoICyUYh9eXdvONyEf0ZRD/eeo+lgCc7n07aGuiQKtTt/z9aU9vdZiiHLvjdXouXOWXSRffVlVFSLeDON2JGJ4yBBGfeuG+/jsVT4ZzPPgJDKLtPL261aO8uMJZ/YHs+eiRdL/JXpdMnaSGvFmXeylgbthE8d/SCAo1tCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206532; c=relaxed/simple;
	bh=lc33eoIpOKcxcb0lGvI7q9zbviv2GzU2GrauaC4kVPA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=oyIbzt05BYplmxJ11j4ji3CXcQrMIGwuzpM9EqqUK8irTFwx0ZgZ/gzo6aCJ/jrmuGjqpnIjA+2cdSEblOB7J8PiIfeHnrjHpPokMqtCqgYTmBA4t/p6z6l+uNwHRZSB0cbGTBurl5m3KRnAdI7gxR6kDnzkEh3b9Hz5rStgE5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NgyfKkio; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NgyfKkio"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKs+aZXquu/dw0sowhPtAy8XdoYa9Qoxnatq1S1gRYbsORUWHdVW5ha9Gpe1YT/wfolgYF8r6ZlyuEEHiqo7EwP8Bu42fud+hky3R8oCd5HbiivYvKvrpDyGgMciUjYzqnu2oA3FA5J1nPnjlHIQZEgJH1P+UCVtZH4ZumKNj5t2XZjmwaOa0t+TEfOGpUxlrF/RfZT6ZahFlYBXQB9RftYUWF5XcWkYLE23cfC1KU7+lhuHSas0DRID0l6TwrR9WUXCCdtB9z++CzAOnUUNMPaYEZERGtLegUhrZpdspIr6E48/KKbmewbc/Uh5ZoWlBtzgFq3JND4jNP60+oyqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cww9xAcEFH3LNpaditwRZVCdd2GpRlKHXuK/yzPCk6U=;
 b=WziyWEBp5e44pqoYYRoiYWs2tGB3kuMogycQdUcwl/HGSCP6TohW1MePXr5jukEeXv4I49itLeTIDOYaqzqy5HB9cBtATgG5mvgdZ1DxG3k38xt8gBoLh3ZQM98Bq9GoQ0YUJGmsAKz9PVtvDfFMKOTCLezTpZN+y+3L7PtQ002SKoStB5fDI4Jm8s+IkWSt0Y/ZjtttbPcedWfscowr4ZoLf4bvVEG8J5+T92Tf5s7a1i214vpjwE4ZWibjovI//xISn7XNWavUA6hdulnRqFsG875C+5MuS2DyMZvkUmK241e/3osQMWdF9AaNLwRrylv4SGbRDI7Lne3I+2UL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cww9xAcEFH3LNpaditwRZVCdd2GpRlKHXuK/yzPCk6U=;
 b=NgyfKkioA0AqQyDpdLkTDNNFhu23vlKt2r5XUZbSlje4tHKwBzERJvLrC8GrzXsboDI2WMbWvO4U7RzoMp18Rgiz3GGh0I03Rr8FhUvMo6rVEnkwfxJLqUrXxJ8QGFLZVBtufIuEKZmaMf62z479o2EGgs6LpoCcnM1gJuXC5h3wtHBwCXeS07Qcrw8QIohYFhrpwsMKSfc5dswHLcEa0irHFkEzQQv17pa0ZkLcqubuufcKgzZugVNGt/rS5ZRqlvlhnAuKiDEUOxDZiZ7G4Y3oyyOI0vI9wVAljV9DZlG5sMj8agN86qrG09MnT0xMIlaeEK5TUih7p7u0BzYEyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:48:45 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:48:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v3 0/6] perf/imx_ddr: Add i.MX8QM and pmu in DB (system
 interconnects)
Date: Mon, 03 Nov 2025 16:48:27 -0500
Message-Id: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACwjCWkC/02OzQ6CMBAGX4Xs2Zr+AKWefA9jDKGr9ACFljQYw
 ru7kKAe58vOZBeIGBxGuGQLBEwuOt8TqFMGTVv3L2TOEoPkshBcSjZ2DztFVnKRFxWNSlug4yH
 g08176HYnbl2cfHjv3SS29UioI5EE48xUituyzgujzLWfh3PjO9gCSf5L+VeSJOlaI9f0DdryJ
 63r+gFIkjsYzwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762206519; l=1993;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lc33eoIpOKcxcb0lGvI7q9zbviv2GzU2GrauaC4kVPA=;
 b=3SFu/z4iP+s5kAkrUnm0XXTPA60w7pGcAT7NFEtGk/1Y3uM6YaeAsiiQQDyKUOI207xggPFun
 Z+UKBjwCi1sCy7QCcmZGogB/4gkbdR573jO1OQGIq+A0CaHsn3LYAYx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1977f2-7dc4-4289-c485-08de1b22c2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXdFNzRHTkp4dkV1NFVoSENseVFlT3RPV1JHaHVrdGVia0NHL2VXMFF0bE4v?=
 =?utf-8?B?dEw3aCtJZVMxRGdjai9RVjFjbStyeFhmVDBLeVdhd2l2SDg1cnl4RlpBdEpM?=
 =?utf-8?B?c3piTEtYSXU3bmtPT0xHMGNJVXk0elZFc2p6bnhXekhlcjJRWmg2VkVTOGg1?=
 =?utf-8?B?TGN3c21PS0JBQnFYZ3pDeFRJcWFpd0R6ZFd6T3VHNnhwaTFja3Z0Q1FLMDN1?=
 =?utf-8?B?UVp2Ry93NE1QZ09NdTJvdmdMcHc0eTRUL0wyWml4MXdpZCs5NERsdVVtWUo1?=
 =?utf-8?B?eWdZTUNzaFdqd0poYkp5Rkp4NjJmbkhZRWZkWVlyc1FUVmhTWWRCbDdqcDc1?=
 =?utf-8?B?eXVNWFZZWkM4ZU5nV2RJNHhJNUZIYVBEWlpoM3l3a1NYRUxHU2ZSYlJiSUFY?=
 =?utf-8?B?V05kM09aWDJUNnhZMWRwd2s3Zko2Tk1VclgvZ1gvcFpNSVdBY3Fhbm9mTEdj?=
 =?utf-8?B?aERqeEhUbHlISFQzUGN4N1lSY0o1Z2pBZnRlaFpjSGNvejdEd2VJUVlyWmgv?=
 =?utf-8?B?d1ZpeUp2a2pHT3JtNG50UXREdGw4Q0l6Q3Q3bWVaMFhaRVB5M09hdlc0KzBi?=
 =?utf-8?B?MU5Rejg4S29pQ1JJOWFpTWRpb0ZPSlloSkNVNUpiZzhONnkwK1FsOHp3R1V5?=
 =?utf-8?B?Y25DdUc0cmhKUjFZWThBQnorL1A2bmVVclpkU1k2VjRkQVpNVTdMNXc4T1dk?=
 =?utf-8?B?K2JESTZwTUF2c2RnR1BBVjVqa2JhS2ppRGh6WUdlSWtHb2JGYXdUOUFDaG1a?=
 =?utf-8?B?TndXNnRqOUkwQWxGN0NORjAyYUExOXEzNXV4dlBRRkxPT0tldkh4dDVPMGI4?=
 =?utf-8?B?cTFwTE4wQnVNdU5qc0k4aEg3TEl2YjlDd0dXTmRBcnJsNm5VSUQyTjNCOGVE?=
 =?utf-8?B?Ukt4QXc5Y0FmS2hrQys5OEw5R3pvUXRJTU8rYmtwOXZZMXJlWjFrODZRMWpV?=
 =?utf-8?B?cW16TnJUOStuTFVRTEtwMW1pUmlReTFkcyszRngrdHR1NUNaaHBwSU5vaW1x?=
 =?utf-8?B?S1IxV2N5UzNOSDdzU0Z1YWgrZWJHRUFXTnY0WHJWay9sTUM2VmhmN0pSb2xo?=
 =?utf-8?B?T0grMElEaWQvaGxrOXlIRTJtaS8ydXkwd095U1Vtb0UrSkVLbmNXOGlLV2t2?=
 =?utf-8?B?OVU4NTU0TmpPc3pJWndETy9KNy9nYTJNR050NXExNm9BNzVaMmYybFZvTTIz?=
 =?utf-8?B?dEJnbTlQZDdjbmthUGtaZENVamt1OTBXcllHaWpRcXE0NlBNL2tjcTdhQjBC?=
 =?utf-8?B?OS9GZllCTW9kMllOMU56UnpnSkVxM1ltd3MrRmlzRWd2Z3F4L1Rnekhaa0dv?=
 =?utf-8?B?b3JsTzQzMWovaWxIV0pyTXg1V1lMODVTQ3NaWkNPV1dwMGV5aHM0a2NZaURQ?=
 =?utf-8?B?dUdRZCtYeHp3WCtXSmhPdnNNakdVc1Vub0JtdjNlYUczVDNoa0tiVGFodTRP?=
 =?utf-8?B?Z2xnWmxod29nOG85b3BkVWZzSTNUSkxqWVAxOEFBZW9rL04xTmJibnNwVjhY?=
 =?utf-8?B?azhlNVN0UEM3WE8rMzlwd21mWEdEdmZESUdKbWJFVzBxQlN2cVovVXdvci84?=
 =?utf-8?B?OE5SOWRFWjlQTGhCWVc0Vk5hL0wyciswY09YYm9pMEZwSDhoeDRLY29zNVBy?=
 =?utf-8?B?cEF6dVZRcXlOYjQ2Q29palZ4dE5HZGNxNDUxbEFBcTRlRm5aY1NobFZtdUda?=
 =?utf-8?B?dUd2cXUzWEZ2OVlOTmhzWjFNQi9pSU9ZcDBiSDFHTnpQdVcrUjNMdjNQYUhm?=
 =?utf-8?B?RVp2ajdLNnd2QllzdDZiZmpVdWlJV2lCdk1nOEVDeUs5OHNIS2tucXZWMzVH?=
 =?utf-8?B?T3NycEQvODZvZC9SNlJJVzdYMGtVZ1E2NmMySWFGdTFod2pmdVk4Z2dlaDNm?=
 =?utf-8?B?dzgxU2dUNlJSVTBCQUpCbjFqSGlhampIckpRRmFMOEZKWGJxNG5FVnRXdU5k?=
 =?utf-8?B?TGdDQ3l1aFdCNUdWeVNSaURBVjBRMGI5eUY0S2VtNy9lTEtsS0txREo5eUl6?=
 =?utf-8?B?MTRZQWFZRlFMSzgzWStZcjFSTEMyTUJSOUJUNVdkQVhMWnBHd0pDS0t0Zmhw?=
 =?utf-8?B?bk1ZUXFaU3VrckY5VEVhWHpYWk96bHpnM09VUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTFEdkQyUmlwQ3NDc0srYWs0a2gxdFMyeHBOVlBXM1k0c0hUTVArMFBKcXJo?=
 =?utf-8?B?RGQyeFAvZy9GSDRUQVV1L3RrMy9wTFdwZ2JiNU5tdDFKOEFFa3lhTE1PT1BF?=
 =?utf-8?B?V2MxQnllTDFZY0s1OUZ0NkwxUldXaktkWWYzbERDeW5UZERpTGc3akJxRE5o?=
 =?utf-8?B?dVZqNUZpbTVPaUIwSk11SlNwZTFrSHNBRzBXTVVPWEtkaXhRY1hnU1NSNGcw?=
 =?utf-8?B?VlZXWWhaOU82RGhSVFVCOE9CNndDYTM5c0FESjdacFY5ek5lUGphUFFWamxG?=
 =?utf-8?B?aEVUNGIzK0g1Q1djb0phcUtwRDc0YVhLS1RMWHNGRlhqdmpoTmN4SktyV3hE?=
 =?utf-8?B?STY5RWpCNFF5b1cycklZSGd4NTJXU05JMnFwMkRqZk12SWVhVnN6ZzExSXFX?=
 =?utf-8?B?RWh0WHhIdm5kd2FvY0ZURXlWa3pWSVJJR2VlSFBBZXN6TFQzbmc2TW91bUk0?=
 =?utf-8?B?NFM2dXdxSW1IQWhIQ3pLZUxabFgrbXBpTWQ3VXdEc3RaUjB4Q2NDOUg5T3pQ?=
 =?utf-8?B?N1JVbWtmRG1VcE5RdkNBMFRqenhaUVRoZFpodk1ab1BBdzFMLzE0TUcydTVD?=
 =?utf-8?B?bFFJYjdSa3dzZzgzK2JkbFNtNC9jVWR1WncyV0dqcGFYRjNZZDZ2UDBXY2pG?=
 =?utf-8?B?WXBTU25wWk9MWWk4dWs2M2JFeGs0RFZVZDVPTW9QcG9nSVByVXI4VVBUclVL?=
 =?utf-8?B?RWJ5ZFozdSt6L0JEK3Y3YVBlSXlGbStuZTJYamhYZ21VVmsxYUtVdzBNdS9h?=
 =?utf-8?B?NHNTWGRuSVVOUHdEWGk5ZDFwOGc0WDkxK1RjZnV0T2ptajJWaStOS09WcGY0?=
 =?utf-8?B?ZHdwbFFzQnR5bzlyVGo3cVoyZFl6ZndobUpScXBIanZkY3RMUm55NytrOXpy?=
 =?utf-8?B?Yy9lZUJqaE9pZlhybVA2Rlg0ekFMNzlxVzJSckQ2dzFIeVRwbExZT09JYk1x?=
 =?utf-8?B?Mmord09INlNyOHdhSDZTZGd2ekF5VnpRcVM2RmNMclJRS1RibzF3OVJ3TUF5?=
 =?utf-8?B?UVpMSGxLT25Nd3djRFRGUTNSV3F6Rjc5ZzZGT1dpT2VUSHJJUTM1MVRla1h1?=
 =?utf-8?B?VnNkZjVqZVBEVXV6ajdVRXRhSDdYMmo5bHJ0WFNvVVNmTy9SN2hsbmNKS2FC?=
 =?utf-8?B?TmtSTC9DMzJuNi96Wm5TR1VXdlFVZWc5YXFRaFlJRlRsalpNWGpwMmR0TTZG?=
 =?utf-8?B?TWNOOGt4ZEo1UWZrbjk5bERFQzJrMy90bExGdmR4SWwwaHpxRytBMDlpcnJI?=
 =?utf-8?B?eWk2dXFsa3VaZGJLaGtSc1JBMFRxcVpUOWpTS2oyUlRMWGQ2VUdjVENjcmFJ?=
 =?utf-8?B?RHpGTndKVWFyY29Kd3FRcnFKTEdNS3JLR2hxaUc0MktFUFVLdUI0YlVSMWNB?=
 =?utf-8?B?Z01XYjJISFQ0czRMYTkzc3RDWGNrN2FXa2c2S01BaGZVSmxTS0Y2SHVNTjh4?=
 =?utf-8?B?bi92dU1zb05rRDk2Q09zS2dlQ0IyMkpDMTV6bGM1MUZkbW5sV0JYdWkzN2Mv?=
 =?utf-8?B?Qm1EdjU2NTR6Y2I3R1dQVVdaaTJ1UGcranUySjluTnRtTERzSE9jTitBNWJV?=
 =?utf-8?B?OEhpdElJT0ZSenNneVQrbHZ6MnJiUlV1eHpCZENRYkE4Lzg1ZTJWdFh1NkxU?=
 =?utf-8?B?S1IyNGZnd1llUXdOQWpUVjdtSEMraWNaL1dNaDNtZXBsS094b2diRUxXU05C?=
 =?utf-8?B?c2c1YjVZWGJEanBnL1UxZ2p1OWZNekxCQWR4Ly9RQkl5OFJudWUxY3pjRUVw?=
 =?utf-8?B?UmlkdTJhd1lFNGR4Smk2R0w5WXdlQ2tZWEYwZ2c3TldKUDI2ZE5lUGt5WGlC?=
 =?utf-8?B?VDdWWlR5TUZOY1J0anRqNHJHRllSdkt6ak9WbzJyUHNrWkhMaHNTSDZuckVw?=
 =?utf-8?B?Uk1XbFgyVTU5MDBiTHJoNjRoNTAwSXBmT29ON3RENFNDWDFoa0JVUFRvVWNH?=
 =?utf-8?B?aHVTRXJIQTVQMDhoTWJTa2RYelpGQituUXpiUW5lZWhEd00wcDlMd1g2eUpC?=
 =?utf-8?B?bXJhMEZTUlZScm90VE5SZGwxQlVkWk1PZ295VjhWRHAwQ3YzRzRqd1I0ZVBq?=
 =?utf-8?B?cjFCSUsxUEtUNkNTVHEwVm5iU1Q1bFZvOTU2Z1JtbFVHamE3NkNJczNCUzVj?=
 =?utf-8?Q?3092K3GQ+2QOABl+mtDotmvH+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1977f2-7dc4-4289-c485-08de1b22c2e6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:48:44.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66zsJbzpVJtuDhSJOQJJSP4MuIN9QSWxonR2lLHgwyac0CFrn3nFQsb5caIiRB1os/WJGldYXH3dw6lI563J9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

dts: add soc specific compatible string for imx8qm, imx8qxp, imx8dxl in db.
driver:
 - did some cleanup
 - add support for pmu in imx8dxl DB
binding:
 - add compatible string for imx8qm, imx8qxp, imx8dxl in db

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- collect Rob's reviewed by tags
- use .is_visible() call back. so below feedback will not applied after
change to .is_visible().

"Is this identifier useful given that you don't add
'ddr_perf_identifier_attrs' here:"

- Link to v2: https://lore.kernel.org/r/20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com

Changes in v2:
- fix binding file by move imx8qm/qxp/dxl under enum
- move clock-db-ipg clock into imx8dxl.dtsi
- Fix CHECK_DTBS warning caused in v1
- Link to v1: https://lore.kernel.org/r/20251023-qm_dts-v1-0-9830d6a45939@nxp.com

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

 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 29 ++++++-
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi  | 22 +++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi         |  7 ++
 arch/arm64/boot/dts/freescale/imx8qm-ss-ddr.dtsi   | 19 +++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  2 +
 drivers/perf/fsl_imx8_ddr_perf.c                   | 93 ++++++++++++++++++----
 7 files changed, 157 insertions(+), 17 deletions(-)
---
base-commit: c31b21db1c04ba719c3889a57873f0f7eff54670
change-id: 20251022-qm_dts-60145802537d

Best regards,
--
Frank Li <Frank.Li@nxp.com>

