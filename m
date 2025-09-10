Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9730C62A;
	Wed, 10 Sep 2025 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494840; cv=fail; b=ZLPVEFMzXahCiqYi/r97B+2LMxeskjp8GOoKUQCdv3h7lBM5yrwfzdknRp57+FKkp0P4EEATp/5ICCwsPsDO38CsZbr7oTXKMcFIy4P9XG3GdUJro9y73LYeJnoJ7hiPD25M8fIyc4SQaJk555XWaUzfCH6bLX4285XvfRPx0q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494840; c=relaxed/simple;
	bh=/m4T7Obdo8nSf4gaxRZ5uzcwRuTUz9/6p+z+et4vvZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IPOp9XPrUwHauHBInW7Dj/IcEZ3ZkAiCAu6svPCyoUen/JchSQe1kIntsHRlVXLMJV1m0tZvL10PV53PEPKopC7ypEDUbEuR1Ik+0EWfQmSv7YMm7X+6aemj2DCPXTfkb0Q+HS8EyHhdEJIfYlEODv3TG3WPnT4pP9qI8sXGGHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oitxkUzs; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=LevCEaZZ; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oitxkUzs";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="LevCEaZZ"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8g4pQ006049;
	Wed, 10 Sep 2025 10:42:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	J4FpgXhEMAGf7egEgiEdPnRQIewNbRLswdo2X/eMG6w=; b=oitxkUzse9wagNRf
	EvValU/t6Wnvtm0pkJ8Exr+ELHNZv6ByI4/i5EMrQ/4K3DZ+nvZQtxRXhKIH9Bm7
	KWdGBjFWcoSqVim5J4XqjdGcRs1iACAOtC07w1OV58IMkfipAzonmnoDDP/0D2cz
	U3ll0k9NlxlNQvCw7P/XXGoU2YzwIEaHaI5TouuMBAWa/iTi5lZtxt3qhn7Ue16t
	NxDYaMxgvylgUaSyK8uJ+kcHjnqKXTqa+rbitlNY0jGzyiLCyeJ838XEbAViCN4B
	dpKs5BcCyanlVpLImK/AWC9VBQPKYgdY+b989qfmQwGUqTMzeJFJa0USIC4myzMH
	TgYrRA==
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 490a386umx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:42:52 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7JmGUMtOp3202VdA120D9Sa7atEVQLWxx27LHJVmHr7htQVK+1g1FMtJnX8F387T+rtAQsrNztMdYnDAegVKVfdi8JsjDdL5lJjZoQWmaXQhzPL6y+LhVXvLupA4fVqKY9LGY1uA33LuLGsduxgTQbolMv683Bv9svIhoGxlau8mx9Nkn+CGNUPmz9prkTM0C7Vp4Z8Id85a6t32bxd3lpjvbXkExB6UP2CxXuFszkiK9tCMA7mV3pXaPJZAShtH6VDREh+Ftbzi9BMVe61UHjAoH4ZUPXhIYSTej0hqf2c+CT4pA+cUyn+1FslLwIaOsTmEuH5uX1nRVE/ySA7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4FpgXhEMAGf7egEgiEdPnRQIewNbRLswdo2X/eMG6w=;
 b=B4Nqo38sdEgKQBBP7jyeVjKFG4cjvDCpNZTBQNoy0LCqdLkBfMeWPEX7GLYTXmmbI+0ZkbinwyxBbwmdcmVIFDht3QXGl6YYvYF6/wTsi0SHs+zZQYOo2CaXepHnlGD2iFA4xTb60sy60gI6ZmY4aXtLtN12Rf58oOIPhJ9o4/u6+qVAubA3xinS0tTe+5Fu+AVycVghSXEYVRTQ59GhC5Yw1BjGpCo+Npc4DRMGrXqWBpPD8bCcfsOnK1zcmSXZWC1dMbMCHt6qE9o846NznhzvtaHQzBFo1IylDwWKXZt0VADnZLt5NMDPe3irP9G/kF9Jd9IcGi5TZbJtOPjkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4FpgXhEMAGf7egEgiEdPnRQIewNbRLswdo2X/eMG6w=;
 b=LevCEaZZLjQ7re4ypqqZ0M/BA15Me9faC0jV1SsGUaxfWOw+2+IzwW4itUopdfBidlIv4FUXVwWQvnWO5grC0B4L5kcxEyfLZGWREHFem0fyDFgeyMVA5UauVkhJrGV/LsxhW2cTVQnnbQI7JdXfqdeKujxdij6fjeqKG7T8S/A=
Received: from DB8PR06CA0060.eurprd06.prod.outlook.com (2603:10a6:10:120::34)
 by VI1PR10MB3230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:42:49 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::fd) by DB8PR06CA0060.outlook.office365.com
 (2603:10a6:10:120::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 08:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:42:48 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:40:26 +0200
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:42:46 +0200
Message-ID: <7cfb167a-26df-4abf-a6ec-73813a1a0986@foss.st.com>
Date: Wed, 10 Sep 2025 10:42:57 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/20] bus: firewall: move stm32_firewall header file
 in include folder
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>,
        Julius Werner <jwerner@chromium.org>, Will Deacon
	<will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com>
 <9a46c8a8-1d25-410c-9fa2-267eb4040390@foss.st.com>
 <19e664da-df4c-4bc0-84ce-41e4364f10bc@gmail.com>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <19e664da-df4c-4bc0-84ce-41e4364f10bc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|VI1PR10MB3230:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee64fa2-aa79-4dca-4c9a-08ddf04605be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVJVWkFZa2IvRHdicU8xWVRGa2xGa2xYUEJhNVcwblhCN3lkWS9kYkhKNmta?=
 =?utf-8?B?WXJmUXBTSTE4WkJ5MVpSWVBHMHZsNVhGZ1VkUGRXdVBXZG54WUdEaW1IMTV3?=
 =?utf-8?B?em5XZk9zL3JYRnVBekpJWTVCUis2MEw4c1I0dHFjemtFbEZONGZNNURudWk5?=
 =?utf-8?B?ejBMQms1L2RKd3l3blZPd1hrZnNSeFhzQThuQ0lvNEZ3Z1hRY0Q0M3ZDUTJ6?=
 =?utf-8?B?Q1RXbWZ5TE5ldmZiL1BZK2VhV2U3QmZ5WkNDMUp0c3ZFVmxRR21TaVNRM25F?=
 =?utf-8?B?UmJhMDF5ajN4bVJ2anFZbEFTN2Y0UUNzQzFyNjhkNnF4ZmJWUnVydk9tMzR5?=
 =?utf-8?B?Z0laY2hOaVZiWmdsZ2ZLd01Sb09abDBPRDkrQitPN013ZHBVVUcyWHpML055?=
 =?utf-8?B?QzZwc1JqeWdvWkh1b3h5elI0cVpXWXN3cGl5MGdidDRBaWJyU1E3eWg5SGht?=
 =?utf-8?B?bktDQUpzcjM3YW1nVmdEUG9yQU5uV2RaT2pOUXNaZDJYVVNlcFFheUEwWkt1?=
 =?utf-8?B?SWFzYVQ2UDZqRUlDbGlENWdSbkpRREIxdm1KbUEvTHg0M1lTRTQ2S0h2VndI?=
 =?utf-8?B?L1JNeXhRNVJtTmdSUlhHemJpVHZTL1hpSklnaG83MTNSR2hPendZUE9xNjFa?=
 =?utf-8?B?cXd1TC9veEVFQTU5UjlYd1l2MC9PajVFOGdKZXpFaUlVYjhEWlNwT0dJRGdN?=
 =?utf-8?B?SlRBNjlxMktZRktNTnMxYzNYekN2anYyTHU1bFpnV2dVRlBMOC9hMmtUYmRv?=
 =?utf-8?B?TFE5Tkd5cWtLK00vbEdITEJ2OGlkN3RKNXRYUm84TVBxNlBsR2NzVG8wL3Az?=
 =?utf-8?B?QTNYLzFnRkRJQmV3dm5ZV0hFdnVJQUtuVVd1a0ZNanMwUWhDTFgvbkJiMWpP?=
 =?utf-8?B?ek1nZVVzTkpzY2s0YzBNeFJsMVZnVUZKbDNhV0dCN1BMZUk3SlNOZmF5VGgz?=
 =?utf-8?B?S2gyakJrd0pkaGkxUVBEcHN1QUhJOEp3eXFzRmppai9TbVBmcGNTR3cvWkZn?=
 =?utf-8?B?MzJCTFNmZjk3K21JemJqMkJCNGExWEVFMmdzQ3I4ZTFzUS9KNUsyMFFnTXgy?=
 =?utf-8?B?WUthUGRlSy8weXhQdDZQVWxiVXA1SHJoZWxlU2FmR01JVFdMWWdyOElXdnVF?=
 =?utf-8?B?SnJhQXR0eGQ4UGRLNFBXa3Zlczg0ZFhRSFB0c2gycW9yNWZTdGxDTHZIanU0?=
 =?utf-8?B?WTFUdm5wdFJRSnZtSDF1SStJclNGWDhIUjBobktyWDA4eWlDZTVRbXlKY2w1?=
 =?utf-8?B?U0ZucTNoem9KQ0hLWTVQWlFqVGxYUjhxTHVBSjZDa1V3a3UvQjd1Y2ZrV0lt?=
 =?utf-8?B?ZmtTbkYzWW45aHRkT2JTNGVOYXBUY0FRdHVIYVNHMGJrelA3ZERkNUJZaVhw?=
 =?utf-8?B?WnBaaG1GSzUxclNWdmF0bDNOdzBrcWFpNmZOZVNWSXhhN3RZOVZJZDc3U0Va?=
 =?utf-8?B?ZnpZbXpzM1hLb0Vqc2FLK3VvSitBWDFXZ0FMTkxtZ0QrYW1ZTmN2S1BWWGRz?=
 =?utf-8?B?WWJtS3I4ck1uc0V3ZGkyRnRwUTJ1MmNOY2tKdC81eEp2RjBWajJWVkc1aEZV?=
 =?utf-8?B?UGV6d1R6QmN5eEx3VnNYWklvSlE0RGtmQUdUVVRUbDNsNWdqcXJQT21QdUhV?=
 =?utf-8?B?a3laQ0o4TkZTS3ZLNktjU21XUFJKZVVZZmNqRVlFcTQ4MDV0bVh6aEIxL2lB?=
 =?utf-8?B?VGdoUEp1bWVkdU53dVZtblY4ZzhpeTFuSTN4VGlteGprS1YvL0NqSGt5Q3l1?=
 =?utf-8?B?ais2Sk82YjRzbnN5RlZ2NkZERXBsV3dnOG5keld1VDE4aHRWbGRRUERERWNs?=
 =?utf-8?B?RmlJa1h2a044b0EvWXBmbnlaTHNlM2x3TFFCV3lnakdxek1RdEpGczVpd1lM?=
 =?utf-8?B?NDVvemRURmxkNVhmT1dYY041MHg2RUdrOEF6dzJQMzVFOFJvZ01JUm9wQnZi?=
 =?utf-8?B?M3VPY3daTFNsZzFFSmVoL09MN3Z6dGlMTUx4U0lrQWJTdEVmZ1dsNEhqQzlE?=
 =?utf-8?B?Wm95UjVKUUZIOHV2cDJNWTFHdFdlWHBCTVRCOFVzVnI0cEM4Y1FRdGxQcEdT?=
 =?utf-8?B?M1dhSzJjU0FNeXJZOHloNDFua29EZENPNS8vZz09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:42:48.9991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee64fa2-aa79-4dca-4c9a-08ddf04605be
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3230
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDIzNyBTYWx0ZWRfX1KbADuoLthWh i/LCcDEK8JaapDabifDHC/znWq9h3yhpmGDO2S0tMSbNq/x7zQzrmzWR9ISGHCxsnJdEKOs12xb 7xsY/6UIkKPwqA0tZqquzW49AQm385YlKXY77or+b028m7bTqumHHqhpF/Z+H/hyCn58acEIloJ
 ga1GXoh+32y2pEuYnQDkvlb25AWC7leQdoXNyD4kv7G1BCG1sKgzANGL+DyQM/YeUg3emgFjjz7 H//mpTFsNItmrxDg2mr49UHBqburvH0+vLJjv3soB2XSxpUeIrOte0GHpiwkBrorgn9y4nVq9pZ SYJp+c7ap9xHlkb/9xBiYBqg7sqUAsswXOXf31w3xJpYApM6OgK8S3XKUPMKkoSe1xmH1I2jSl8 T62I6LXd
X-Proofpoint-GUID: I6cA2-H2HqpFTqPVdZoFNp0I1FAr5hgO
X-Proofpoint-ORIG-GUID: I6cA2-H2HqpFTqPVdZoFNp0I1FAr5hgO
X-Authority-Analysis: v=2.4 cv=WLB/XmsR c=1 sm=1 tr=0 ts=68c13a0c cx=c_pps a=lih53SDVldumcZxYoUPpqg==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=pGLkceISAAAA:8 a=1Ic4tg3mJiWtIKtg5K4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2509050237



On 9/10/25 09:47, Clément Le Goffic wrote:
> On 09/09/2025 14:25, Gatien CHEVALLIER wrote:
>>
>>
>> On 9/9/25 12:12, Clément Le Goffic wrote:
>>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>>
>>> Other driver than rifsc and etzpc can implement firewall ops, such as
>>> rcc.
>>> In order for them to have access to the ops and type of this framework,
>>> we need to get the `stm32_firewall.h` file in the include/ folder.
>>>
>>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
>>> ---
>>>   drivers/bus/stm32_etzpc.c                       | 3 +--
>>>   drivers/bus/stm32_firewall.c                    | 3 +--
>>>   drivers/bus/stm32_rifsc.c                       | 3 +--
>>>   {drivers => include/linux}/bus/stm32_firewall.h | 0
>>>   4 files changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
>>> index 7fc0f16960be..4918a14e507e 100644
>>> --- a/drivers/bus/stm32_etzpc.c
>>> +++ b/drivers/bus/stm32_etzpc.c
>>> @@ -5,6 +5,7 @@
>>>   #include <linux/bitfield.h>
>>>   #include <linux/bits.h>
>>> +#include <linux/bus/stm32_firewall.h>
>>>   #include <linux/device.h>
>>>   #include <linux/err.h>
>>>   #include <linux/init.h>
>>> @@ -16,8 +17,6 @@
>>>   #include <linux/platform_device.h>
>>>   #include <linux/types.h>
>>> -#include "stm32_firewall.h"
>>> -
>>>   /*
>>>    * ETZPC registers
>>>    */
>>> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
>>> index 2fc9761dadec..ef4988054b44 100644
>>> --- a/drivers/bus/stm32_firewall.c
>>> +++ b/drivers/bus/stm32_firewall.c
>>> @@ -5,6 +5,7 @@
>>>   #include <linux/bitfield.h>
>>>   #include <linux/bits.h>
>>> +#include <linux/bus/stm32_firewall.h>
>>>   #include <linux/bus/stm32_firewall_device.h>
>>>   #include <linux/device.h>
>>>   #include <linux/err.h>
>>> @@ -18,8 +19,6 @@
>>>   #include <linux/types.h>
>>>   #include <linux/slab.h>
>>> -#include "stm32_firewall.h"
>>> -
>>>   /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
>>>   #define STM32_FIREWALL_MAX_ARGS (STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
>>> diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
>>> index 4cf1b60014b7..643ddd0a5f54 100644
>>> --- a/drivers/bus/stm32_rifsc.c
>>> +++ b/drivers/bus/stm32_rifsc.c
>>> @@ -5,6 +5,7 @@
>>>   #include <linux/bitfield.h>
>>>   #include <linux/bits.h>
>>> +#include <linux/bus/stm32_firewall.h>
>>>   #include <linux/device.h>
>>>   #include <linux/err.h>
>>>   #include <linux/init.h>
>>> @@ -16,8 +17,6 @@
>>>   #include <linux/platform_device.h>
>>>   #include <linux/types.h>
>>> -#include "stm32_firewall.h"
>>> -
>>>   /*
>>>    * RIFSC offset register
>>>    */
>>> diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/ 
>>> stm32_firewall.h
>>> similarity index 100%
>>> rename from drivers/bus/stm32_firewall.h
>>> rename to include/linux/bus/stm32_firewall.h
>>>
> 
> Hi Gatien
> 
>> As the firewall header is moved to a dedicated firewall directory,
> 
> I don't move it to a dedicated firewall directory just to the "bus" 
> directory where the "stm32_firewall_device.h" header file is already 
> located.
> 

Yes, my bad, I mixed my words there.

>> maybe it would be coherent to create the same kind of directory
>> for the sources as non-buses drivers use it. I can test it on my
>> side if you're willing to make the change.
> 
> Do you mean create an include/linux/bus/firewall/ directory ?
> 

Rather include/linux/firewall/(stm32/). and a drivers/firewall/(stm32/)
directory for the firewall files would be great. If that's not too much
of a burden.

Cheers,
Gatien

> Best regards,
> Clément
