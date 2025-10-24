Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2FC262FCB;
	Fri, 24 Oct 2025 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329858; cv=fail; b=HaS9rwGiY1B1anHuqjIYGgULbqABxzy44uUVgZWdzp5xEwLys/Hp7kMVUdMsA6NysWrb17x/6B57YRDOaK0wQkqK+v8p+LRcvNKJCktSAoE5xl9Fcxb9otJejyrjjgvSqsVrgdIqI8wjvoQO/5AWgol5YEal+c4XyT5rtd2UeIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329858; c=relaxed/simple;
	bh=JuyEXckT9I7hnEDOILUcvEEpEi3472vv9NPZdSSey9c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KJekbUWVwFp6TAHeOTi91WzRoLFQLcOwu9+p4D0CuhUQSx1Pn4sE9m7g/PKmL/3CDPGyTkU94tEz0r+dyKVjaFp5SsHJ9ykkytKiLzBIqLQFpHYaeIwpe+fypj2wb3jxUILmt9lGYWrt739KLBkrtTKXHbX3BNJ7koQPLUBT8dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BG0k3ZQe; arc=fail smtp.client-ip=40.107.162.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BG0k3ZQe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoM0r+wyLT0/r2EUFUUXr0rHhs01mtLS57LmsXBGqruXoiXjX+QLvspu5n31xMBmcOphVbAyLCajXKvTUmXtdanHJHa+hXpVFXy5B9rxUsWdUK+bvYYxtB/IouiKTRUol2VtilZW9CY+g/D6npRVYtOxIb9FWFgPNp3I7ecJLj1QwdmUDwlgOttXUnD9pGl3Le/OuVnNcYMqiHvhX21qJxomeBCCQNthz9aJy69F4C1yt1winDzMLlSZ+ttJ7i9SwcgRO/dkbhzTN9z5qvn57k484sv6nv4C/pIbClND87m/DifTcduyhrX/yq75OAZuMTnIdv67evqC//83iz8Bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujDzd8x9Ug5fyqqsROYSLmUOUgQ9NvpO8de8ycPWOX4=;
 b=ToJtxTWFIXlUBd1TTz4CcOYk2ruRdPjh4UG6QMWCVQZEXKOv7OzClC8DSIWReH1uFovJpmVqrQ5YD7V+RzhHVKQj27KUA98cFXbZc3dwEbP8+4tINQjkjx/a0BSsnmFs8/KAlVySkE/BNIeLJOwrfuYoFs3Am2IRJAxl2fTkE9mGwUjRkkPmwf+ceW6wZgamyr6O0EeOcLVJJNA1uyEf6kYg7ZHT4+ZsOSYTipvZJPm57oXIeD4gYpD1jjMtW58GIN8pVG3bZ9reFU6NZgdWD3gnPt8iw6gIVmwFefs7SkDdwOUQRNxEVAuV7xD3hy7+ALkoZ556wyQr6HKXRiGvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujDzd8x9Ug5fyqqsROYSLmUOUgQ9NvpO8de8ycPWOX4=;
 b=BG0k3ZQed+PEZ7gp2B74vRZU99q1aSRvuT96oi3DPcxow9omysd1F2sej1dL8RxW0sYBEos4oJNYzvy2C5axZa2d1Oj4uRBP0YdoG/1WDJC3E3Q02ctmTHx8HBRkhYY+tNJnJeW5JTeEHKb7jeuLbRVjkr5fbR5R5oH8irkIMJMSxXK7/qGTzPecG9fTSJLbkkqtgl1ak8KydT9AEIviXfa6Z/Bz+Qvt1glAN/Zo/PotJ0zZQ6+1qYrvbRTbV0JHOOgxBcpnM5itgT51TV70gE7n4WmMn6Rt84i8gea2Y+PuEvPW8CBrNtGA7ASn1Q8ZbeINJ+0LcVqUWogHNQCHpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:17:34 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:17:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 24 Oct 2025 14:17:11 -0400
Subject: [PATCH v2 1/6] dt-bindings: perf: fsl-imx-ddr: Add compatible
 string for i.MX8QM, i.MX8QXP and i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-qm_dts-v2-1-7a7e07022ed6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761329844; l=2131;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=JuyEXckT9I7hnEDOILUcvEEpEi3472vv9NPZdSSey9c=;
 b=PlQH95aCeVbM1X+VOh6s0LnZH1Pm11e+EF7rwZddvbEvFEZezM1gA5cZaZOslZqPpURK3q78l
 BzXEa+3hEvZDu4GpDsVCOGCxQmwOuEM2oTfYD/X3pDueEkWpeBvU5pP
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
X-MS-Office365-Filtering-Correlation-Id: 657a7001-340e-4e8f-8770-08de13299a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkhTNlBCWlcxbVZIY2pKVjhoVzd5VTFZMVg3c0t6WUl0OElCMEVkNmpxa2tl?=
 =?utf-8?B?WTg5MldjMDVhV3FiWnRlSTBKZlVCVVBTRVo5U3FleThPeXVzb2ljSkhzbS8z?=
 =?utf-8?B?NHhMdTdhTERWcDBIVDdEY3NHa2pXZjA4dkUzQzFIN25heTRZeGZnamdQQWxa?=
 =?utf-8?B?M3dQSlJDaU1JZThUdTBnbXMxMHJvbVV2MGNhVGZadmNvVDBTL2Y5RzNwUU9O?=
 =?utf-8?B?RGpIZ3VzMzlXVGNiYWRPVUFGdUQ1ZGJ0Z2l0ZzBsL2p0emQ4RWpWRXduTU45?=
 =?utf-8?B?aTlIL3Z5SVNRa2NoTFFwUXNpMU5ISTJNMTBxZVZEVWZDWHcvZW9zZGRrWCtZ?=
 =?utf-8?B?WThaSy9QRVQ1SjR2Ykt0YkMvbVMwTkZ4Y0F5OGl4Qy8xNkV4SVRDVkVMMmVL?=
 =?utf-8?B?RnJjcnFHT0JNeURuS05HWCs1end0YWY3VUQ2WWFaS05qUm94U2F3NlpBNkJr?=
 =?utf-8?B?MGE0K1NJTFFvdTRVb0Q4OTFwcHRmUVN1eHZrSGxVSGlPWWhaS0hmM2cxUlVt?=
 =?utf-8?B?L041cE1VWngrNUJHMFpiZWRXRDd3eEkwZVJFa2dSQXVBTGYwWVNtZkxLdUxP?=
 =?utf-8?B?a1I2bnhKaFBjOUpjcTY2V0ZBTGM2bUo5OVhURHJCdGVvVDBSdmFWcVpuNExT?=
 =?utf-8?B?OW1IdFltUGFueHA0K0labVpsQnhUUkthdFhDYkdSYlJOcUIvTnVDaDRIVEhZ?=
 =?utf-8?B?SlZHY045U2hMcFN6bHVRdDRxcm9MMGpXWU9ORnp3ZWtHcjFyWnl4enk2THNs?=
 =?utf-8?B?VmZkQmRoeHc1eTA3eFhLa08xbW9jRWRvdGFnckFJdW1rRTluemdXdUJTc0Nn?=
 =?utf-8?B?VitTK0lkL0wwdTY3QnJZdFl1cjBpQU43SUhmVkdZcjlBMDI3V3dPZFBNb2VO?=
 =?utf-8?B?bU0wbmlVQnpMb0thTThxK2llWGNWbGdwV0V4QmR6U3JSMjNYK0o2aWZRNGJD?=
 =?utf-8?B?WWsydTc0ajEvRW8ydCtEY1dqSFVNWmU0SlJBdEIyUjdXa3E5eXFycEt0NFBi?=
 =?utf-8?B?RVFueUwzK0x2WWthWWF1cS9ESmlyUW5EQlRjWnNkbTFsaVN5WGNaMEtldFk0?=
 =?utf-8?B?YnNueVRxOTRtZ3k2VVNtUDB6TGthZ0x3TGdjS256RjdTaTFSL0h6UmF3VnlL?=
 =?utf-8?B?bWZrWENkV1piUjRCNWc3T0g3SEtYZU83U1lGbDY2YTRLWW9HU2I3Y1l3a0Jh?=
 =?utf-8?B?OE1vVzgybXpsTHRWWmFlVWpXZ1VZU0ZaSjdQa015cHAyZmZZL2tRNzJkSkxJ?=
 =?utf-8?B?Vjh4cTNNZE1wUmV3bjNoTXZ4SWtGeEpmci9rR0FuUCtJTWp5V3E4RDFSSXdW?=
 =?utf-8?B?ek1ZWEFuZFppU3ZBd0dHTTJYOVFYSlRzcWU4TkZjZ2R4UU5NNVpoR1B5dVZy?=
 =?utf-8?B?c0lJbkZBUzJaOXRkTG5BdEVydmwyRGszM0EvV1YxZ0pXWkgxS29wdjBOUWJI?=
 =?utf-8?B?VGVheThDM1RvNVEvLy9qd1JmQVY2TFhXMUEweWpZMjJiYVM4SWNqd0hBanNY?=
 =?utf-8?B?MmJ2RjM5WE9FLy91MnU3c2VDaFRkN2l4Qkg5UWNMc2o1YzRwL0hMVE9wMnZ4?=
 =?utf-8?B?bTUzMC9TaWZCb2FlRWt0RHhyelRHazkreVJiVjVXSkdGVnhpNFlsekVTbzNl?=
 =?utf-8?B?TFdJVXRHb0hFeXd3ekd1RTFJOXV6QjFhT3hENExXRVBWbzlmalpkbHV3UE0y?=
 =?utf-8?B?KzRBaXRpcGs0Y1F6TGVpb1kyQUdwaWFoSjR4SXVDUVRoM2ZWTkxEVXNrNzZ5?=
 =?utf-8?B?bVdKZnBjRU16eDFSajBUc0RXSkZTRHNtVnBoU01odHVKWUJkZDhhSUFvbjJV?=
 =?utf-8?B?WXYzWDdpQjlYendCc0RBeWw4U2Y3L21uUFI3SE5TWmJtdFR5ZkpPd3gydTMv?=
 =?utf-8?B?TGhpTnUxU1VPZStlMzBvQVhWb0l2ZU42RmtrTDMrOXBQVDE4NVhLQUFxeW82?=
 =?utf-8?B?SVF4K2VEWUJmUXVzOGMzWnZTMWJxYXg5VnpFUXB5ODV2REpiTEVOOThZNDJo?=
 =?utf-8?B?MDlmYXhoNExUUTNiaWRsR2RGcnRoUVJ2L3JMNzNaK05LTTR3ZUtQbGpKU3c5?=
 =?utf-8?B?SmFUUFpUZFJNMFFMMXpOVk9GYk1hNENhZjlnUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlpY3VNejZ6SWFRMk1ZblpRNjJwQmRLdThIdkxwdGpGaG1BN0k5UWM0eHB6?=
 =?utf-8?B?SzF1MjZvcWNOR3FZdmIybkR0bHcyYVViOEVVT05rd01yN29FUDQwZC9ScFZR?=
 =?utf-8?B?VWs4UmdWVFF2MHNXVDRwOEpDdFJpOWdGSk9Gb3ZLRVI1VFNHaFg2ZzlZVC9N?=
 =?utf-8?B?SjdXNlFwa3AxV0JHSVJ2ZjgrV2RmdVA0RTJRcVRsNWJMUCt3N2Rqd3ZHMXM2?=
 =?utf-8?B?Z3J3N3N2SU9ydEc5VTI1Yzc0Q1VrZURRUEk2aHR5UzlLWTkvNkZHOVJ6dmVJ?=
 =?utf-8?B?UUpNS1dSM1ZjMHVOZndqb2IySHpid21UZGxsZ1V5QVVFNTRZUmQzczZ2dTdN?=
 =?utf-8?B?Mi9KUWdDODNwUkxWWTdCSnpoZ0NVSmFrUXJTWXZYS2dCa2VsRVBtek4wMXpB?=
 =?utf-8?B?ZUVhUnkrZTYzTTNjUS9pTUlHQlg4T2Zsc1hMTGNrSHNraUtKY0R1UWprQlV1?=
 =?utf-8?B?cWhtUy9EdmQ3clI3cHhuc2x4cnpWMzNRV1hSS1JIalRQYjNoKzZLaTdUbk9m?=
 =?utf-8?B?czIraVhQTGRsczMzeVc2R1hWK0F6WGJiMWJIUXkxbk1EUzhHenplREpPVFhq?=
 =?utf-8?B?YkdvYnNENE1iVlVKc21JY0RmTUlXSFNzL1BHbW5Pa3FoM0dyWjFMaG83aEdu?=
 =?utf-8?B?b3JybldVejcyRGlFOVkxUjRNdHpzRHhjdkFGNkZBcUtjMEY3WDN0Um1KR0xF?=
 =?utf-8?B?YTZMS3c2MVZ4dzlpVk5xVDFzMnNIdUdsbjA3QkU0WGQ4WWhBWW1JSEhlZGxB?=
 =?utf-8?B?TFcrNEkzSSs0UFhCSHJ4QnpubENZYmNrRlpBREtVM1lmYzFpLytMelAvR2VP?=
 =?utf-8?B?cHU5YU9KcVJ4d3QwcklRT1hTQk1PK0dmanNES2lxOHRER2hTNGJTZ2VoM01m?=
 =?utf-8?B?NzFrVkN5ZGlHM0lBQWcwVE9MN2crdjdkd1pnTWtveVFXOE1Xd2VQZXlEVkY0?=
 =?utf-8?B?K1hiVGx1N0pidm9SdmxZaS84UVVwQWhGT2hXSVpaemNmdGpuSEtqbG5LWEQx?=
 =?utf-8?B?eGZqTTNLNkRaYWdkb3ZvN3MxcDFRbEhHb0t6Z3pEZ21KOW5qZUg4b2svZGFL?=
 =?utf-8?B?bjlCZ0grOFhrZkpVL2VIWGoya0FDb3EvTGY5ckIwRVN3eUhNaGt2RWtpUi9o?=
 =?utf-8?B?eG9jU3BkRjdyQUgxSE13ZWRLM2hCTkxiY0g2aVNYcXVKMGNXMUxZZU1IQTRo?=
 =?utf-8?B?ejVaZmlBSnVhdVBNbGR0aWdIN1B1Q0dpUVlFQVpqNGFVeUF5VXI4RXVsWDdi?=
 =?utf-8?B?SzZDRjYzSTJpWDR4LzA1TWxsenlWNG1reEZlenBBMDF0a2JJbmJRa3dTNnZU?=
 =?utf-8?B?eEtGMGxCb2FDRm95NFBqR0xzRVNxL1JNMENIVzZ2SEEweDZvTDNMZWZDWUJT?=
 =?utf-8?B?M0FVWEkxWTNObUN3RjJyTlE0WTU3RVloQzdxODd6a0RoTFlqMU5qcldIR1Rm?=
 =?utf-8?B?N2wxZmVLNTdSckVBSnpNR3FyR0VVV3NlWmVENldLWDZpYVVXYkRLMFRaSFJJ?=
 =?utf-8?B?cFB1cTFjWERqaG9wL002Tk9aNXFoeUhmUzJuMUVFRGxWS05TcEFkMmk0elpN?=
 =?utf-8?B?K1pXYU16eStLTmdVYm5Ma3dwZHk2WkJ4WXJRR1hoVzdVaW5yVWd5cDFPRG5X?=
 =?utf-8?B?QmdiUWVFVkhWa2g5YlFYTGIxSlVWWnFYTkRabEI1eTVieE9BRy9CU1MvdlBG?=
 =?utf-8?B?SEJCcHhZc2RKWHl5SEo3VUtrUkcvR2M1OGxOUFEzR3dITjRaMWRNQkE3WU5H?=
 =?utf-8?B?cldyc2FjbkhZbzZnekNkNi84eG5vcm5ZSFdoejF5SlR5Vk0xNVk1cXh5Z0NK?=
 =?utf-8?B?d0tLMk5GOHF4T0d0TGpsa0kzZzJ2NjgrQURlSlpiNVMxVDNqWnUxQUxVU09G?=
 =?utf-8?B?cnhtQzN6MkhxWEF4WjFiV1daWE8wRU1ZTTNET0lpQVNBd3pDd3NpR0JZZURO?=
 =?utf-8?B?elRKS0JWUk9FV3R1OWJmbUlhWHdIcU5vUXhxNG1FK1NYS1A1dURqSUFvNGxP?=
 =?utf-8?B?TWJGbisrTTdoMGxmV210K2pwUHA1ZEk3WmtBdGNJQStyYWlJMC82djNCOXJP?=
 =?utf-8?B?MXEyOWtlTjVMMHhkU0hwbmEwRUVnNzFpMkV3czg3Nkx1MGF0bm5GVnJuSVVW?=
 =?utf-8?Q?MFB0G94nGANFomq2NSjW3qk+V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657a7001-340e-4e8f-8770-08de13299a86
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:17:34.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXuQEAgJg7WhnkV8v7vMCweGNxF90ujD4RfT0HB3yTyH4iJVz+giUtjeIG+UTOM92ufgt/PtfjbtXg2i9Ka1ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

Add compatible string fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu, which
fallback to fsl,imx8-ddr-pmu and fsl,imx8dxl-db-pmu (for data bus fabric).

Add clocks, clock-names for fsl,imx8dxl-db-pmu and keep the same
restriction for existing compatible strings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v2
- move fsl,imx8qm-ddr-pmu, fsl,imx8qxp-ddr-pmu under enum
---
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      | 29 +++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index d2e578d6b83b8847c7a0ca9d5aeb208a90e2fa6a..103e4aec2439424129fdb9a76edd2ce1c598b5a1 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - fsl,imx8-ddr-pmu
+          - fsl,imx8dxl-db-pmu
           - fsl,imx8m-ddr-pmu
           - fsl,imx8mq-ddr-pmu
           - fsl,imx8mm-ddr-pmu
@@ -28,7 +29,10 @@ properties:
               - fsl,imx8mp-ddr-pmu
           - const: fsl,imx8m-ddr-pmu
       - items:
-          - const: fsl,imx8dxl-ddr-pmu
+          - enum:
+              - fsl,imx8dxl-ddr-pmu
+              - fsl,imx8qm-ddr-pmu
+              - fsl,imx8qxp-ddr-pmu
           - const: fsl,imx8-ddr-pmu
       - items:
           - enum:
@@ -43,6 +47,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: cnt
+
 required:
   - compatible
   - reg
@@ -50,6 +62,21 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8dxl-db-pmu
+    then:
+      required:
+        - clocks
+        - clock-names
+    else:
+      properties:
+        clocks: false
+        clock-names: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>

-- 
2.34.1

