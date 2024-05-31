Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021011.outbound.protection.outlook.com [52.101.186.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCC1CAA1
	for <linux-perf-users@vger.kernel.org>; Fri, 31 May 2024 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169418; cv=fail; b=A7b84SDioEPXuOeTP+sVhNuhbl8jx2GCNW8ib2thFj0lDHQF+HNO/LdHQXRxEhAL/9IqFLCVk3A5AY2qbJko8Y0Hc9o97EBjBjmgXWVwfY43jdnrfPZazJZ0It8ngB573VLVAltU5usJ7zAOwq77UJQ0WNi4TRT8HpHx9k+rWUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169418; c=relaxed/simple;
	bh=vUKamyWaBbYzxH4bt61dkH0EzOakLW49jkf2W++fQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gf5l/sjx41tSAnr4uuD5fgsCiwUyQQ2nAsQgO1n388iXCXlva1HR0mPsUGqMVaj2X+3aazTJEzFLzGVlPi5IvFNvEXfkbkUocY1pJ9O0cpD/ufoHG3BMtzneLaFbKNGvtTiOeY3ytQd2xt0901mWjSMbmAo0nEvO7REXRROv/MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch; spf=pass smtp.mailfrom=cern.ch; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=CXZR34Yi; dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b=CXZR34Yi; arc=fail smtp.client-ip=52.101.186.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cern.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="CXZR34Yi";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="CXZR34Yi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gboXgmzn5ZdxrI3UOFfGYAQeyuV0Ampg19taKSE+GPZZsJg3eulk0eb292FBapd9VTMJHSPjm4QjOZOqhLfHzXoYJKmaQmLVTkAl+RG6/mtok/20vueI6iuiMuogogpB4R2afKXuDt0ceBrrOCVCnZ9i/FBXmcVLRxPyq43FG8VlG7lHxn0XAIKcw1B1FksF2BP5Xth2v3STPzUxHwzcQE8awmnrtkRAGJVCTo8xDEjXID7BhMe0IsNJj2kRpDidtY7KfddO8IQT1xy2WmvR7rupouW7oqOumeUVCYr44I0C+yX1maUJJxNdnRGoNiIkRrGipex4l8SmQebC+IUfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V4ejlw2ryHelPX3dM5W5fWYg6qXqvdzehMbQGMUrFU=;
 b=XcMrcizI6SCD4V1wlawm75Vq+3llVZfPYJxFEZX9f96XvMExT6k1WsVasW3mpeJDC1RD82GmYP7qt5qZOrkBVwwVrewJpOvCw53oPY8g37V/CI5yaQe0YBQHYOiALxI3vLp3oqLKEkg0AGCcH6UeBZAdNm0NQxIhbbYre5gemxxW/OY7bHfKcnlJ+uCmrDhvDMYhfHR7L8qbM1Uv2RC4GtOsRgI2yxPiQwRIbrCB3b3IiM5uMzjoAVUsMpoBl/PpDb2yR8v/h8K69frvXeKX+Ucz/M7drD4WoyJR+LTIybAsG/lZHslsMrDzeCcOwrWlsdFQUnYuWsu3b3YzHPJBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=kernel.org smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V4ejlw2ryHelPX3dM5W5fWYg6qXqvdzehMbQGMUrFU=;
 b=CXZR34Yigar1teAOLSyA941eY8gsu1XTNo5DglcTgMDFtXK8E558SnxtX1tX2kceLaZVxtW8gPiot+7YlAt3wUpRA2mopVN+1XmrcGxlipJJlwduk1sK4YoVU4RYCIaTlvNUebDcBXxitCU6zWAKUqD8BZOk15t0MMkS+/VYJw4=
Received: from AS9PR06CA0309.eurprd06.prod.outlook.com (2603:10a6:20b:45b::11)
 by ZRAP278MB0770.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 15:30:12 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:45b:cafe::f6) by AS9PR06CA0309.outlook.office365.com
 (2603:10a6:20b:45b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 15:30:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Fri, 31 May 2024 15:30:11 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTP id 377867ECBE;
	Fri, 31 May 2024 17:30:11 +0200 (CEST)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011007.outbound.protection.outlook.com [40.93.85.7])
	by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id C461E7F413;
	Fri, 31 May 2024 17:30:09 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com;	dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=CXZR34Yi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V4ejlw2ryHelPX3dM5W5fWYg6qXqvdzehMbQGMUrFU=;
 b=CXZR34Yigar1teAOLSyA941eY8gsu1XTNo5DglcTgMDFtXK8E558SnxtX1tX2kceLaZVxtW8gPiot+7YlAt3wUpRA2mopVN+1XmrcGxlipJJlwduk1sK4YoVU4RYCIaTlvNUebDcBXxitCU6zWAKUqD8BZOk15t0MMkS+/VYJw4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:35::7) by
 ZR1P278MB1071.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:59::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Fri, 31 May 2024 15:30:08 +0000
Received: from GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2518:d1f5:2f27:2cc5]) by GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM
 ([fe80::2518:d1f5:2f27:2cc5%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 15:30:08 +0000
Date: Fri, 31 May 2024 17:30:06 +0200
From: Guilherme Amadio <amadio@cern.ch>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: perf mem segfaults
Message-ID: <Zlns_o_IE5L28168@cern.ch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV0P278MB0387.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:35::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV0P278MB0387:EE_|ZR1P278MB1071:EE_|AMS0EPF00000195:EE_|ZRAP278MB0770:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfbc93d-48ca-458b-79af-08dc81868fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?V2pyUXlDcUVJL0R3NDlGQ3BaMjQyQnpTeENnYktLMU9yZ3ozalVGSVBoTk8y?=
 =?utf-8?B?YTUwV2ZRdWltbEh0cXE4d0ZjRlVIZllnRFJLbkZrdnJkeTVrUHIwdi9wVkx1?=
 =?utf-8?B?S0pidjQ3Qk1lUFZoNXVIbXdWOFltVkU4S3lVL2RIaVdhRXlUSlViRmpVSGI5?=
 =?utf-8?B?b1ZDYUlnQTZWZHJZRWdpQXRCUFB2NENZczYySFpHYktsV2Y3RkVIczc5NHE2?=
 =?utf-8?B?YlhGQlVZbHpVSnJweEhSejlRcHRHN1NDTkkxSG0wTFprYkdWWDVpZzZYekZo?=
 =?utf-8?B?K2NnUnZ5dklIdE5tbW1qNTN2MFpCVHJ0SWJGTjdoQTdUMW1jU1NxV0tKMjN1?=
 =?utf-8?B?K2xLWEEwelNnY0tSTlhuR1BmNFkvV3pWbUtoOUFKanRvQ2tvTXJrU01uelhq?=
 =?utf-8?B?c3RRTmVMQzJRbzdjakUyK1grdzQzZlNmdVhnSGV3cTVwTE1tYTcrZk9Ib2N5?=
 =?utf-8?B?TkZhc3h6UGdiS2U2OERoOXpReDhhRlg4MVVHaDB6a1VrdmIwaHAxbmJsRk1r?=
 =?utf-8?B?R0s5R1BKTmY2b2hvek5PVUp0K3h1SkIxanFEWkVNck9Sbmd5RnBLRGZnc0U2?=
 =?utf-8?B?bXJ4U2VZUmZKNkRnK21ZeDlpdmhpR2FHaDRQZEphUE5NR0JWeHJTM2kvRkov?=
 =?utf-8?B?QXY0WnV6OWNoejdIc21mbWVOV1hibjhHVUxjRUpJMmZBRTlYOW5SQ3hpbXJu?=
 =?utf-8?B?amtkSGhNcExKV0JxOTRYK1c1d0duZzVGRXZhMFhXNWF0eC9IRXRNMVB5UFM0?=
 =?utf-8?B?Y1JpR3ltVkF3UGtZL3RSWnUxTHBWTWVGenZoOVByNTZ0eVVyV0V4V2YySldV?=
 =?utf-8?B?bnJhLzN6SWt0VDJqTWtGcG5pZ3dyZnNRNUI1L0M3TTRXREkwQURtRU1CcTl2?=
 =?utf-8?B?eWgwb1c2MUVyVXRhdlFxYkVhZXkvaUxBUjBrTXBHWkorekh2U0RIZWU2QW0y?=
 =?utf-8?B?UXE5OTI3MDlJUjdjemUvNHM0dFpZNnlOTmFFMElBc252c0xpZ3dCRlNWd2tV?=
 =?utf-8?B?S3VhaEE3a2w3MFBYWm55R2hGajErdWdNNVA0R0pHVWg2Z0J4VmRraUtKc0FK?=
 =?utf-8?B?anVNamVoYUdjb1NTMnd0Z2Z3dnVQamc5T1E1amd0M1JCOTNqc3VnRkxCSjdz?=
 =?utf-8?B?Mkg5TUYzL1NsdXhuQ29ZWEF2SDhKWnRLNzErM2h3cDRsMHBDaCtYb21XSkd2?=
 =?utf-8?B?TGtTZFdZSU5KVTJxNVlkTmUvYnJzYzBhK0VuWDFzTE5SSkYyNFZDSlFTYlpH?=
 =?utf-8?B?N01pTVB6YjVrK2hoTzdZZEtXWk9vZ1NlNm5mMnplVmFicWVQSWFIbytzaXBQ?=
 =?utf-8?B?eVVFRkxST2xsSWkwTTdGOXBlTnB0Z001dkNWVENkS09jcnl1czhtTWl5K2VM?=
 =?utf-8?B?U0s5bVBZVEVwS0hnMUd1VWNMbFF4a2NpenQ3Z2J6OEh4akp5R0p2alUzaW5l?=
 =?utf-8?B?ZVZwaWdXOEp3aVJJTkt1MUpjc1hxVktIWDNldDRTUld5ZnpyT3ZsZ3czajNy?=
 =?utf-8?B?WGdsdDY3a3pVemZSWXo3MUk3OG5rOEhnclVPczNVWU1jS0FWQ3BsUFVCQlRX?=
 =?utf-8?B?ZGcyZHF5aS9MQ1AvNDBkY0VuWHlmSzI4OVlqWUJDU1VrYjNFQmpCWEJ0b0hI?=
 =?utf-8?B?N20vck03OUd2WjZMaVBhcmFlS3FDbHVTSVF0ZVlvcTZRODY4VGxlS3JuL0cz?=
 =?utf-8?B?UEw2VE4xZzMrWVFUU08zeGplWml3bnNuY1NsK29Nazd3cUxjZEEyZ3BBPT0=?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1071
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2c4947ab-995a-41d2-afb1-08dc81868dbd
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y21WLzh0V3J0eEdRVE1OM2FrWVRubVhVV3BkUCtmU3VHYWVuQnh3cStUL0lY?=
 =?utf-8?B?YUJOdUgzTEZnenFadjZla0kxMzFNaHdjand5RFhZUEJvUmtFNVI4bmZVd2Rs?=
 =?utf-8?B?QUZMRkNaYld5b0FFbHpmVGdJUEhtVmI0b1VUcmlYa0FIU2VyakxjaGRCZ0sz?=
 =?utf-8?B?MmhrWUNjRXA3WTkrenRkTHhGdzJIK1ZSVmh1eXl0RGFXeElzeW8vd0VrNFNy?=
 =?utf-8?B?T3ZoUW5oM3JhTGg4TTIwcTVuYmllc0MyN0dQbXhoZk5MR0s5YmpBcTF3bnB6?=
 =?utf-8?B?WlhGYjV1S1ErY1V0N0FGejQrcFhZNytpMzlxblFFUlJ5L0UwT2w0L3R1SG1E?=
 =?utf-8?B?eGlIV2VsQjFWQUFWRVBPdS9yRC9aK0M3c25ZVVhGcldTenJ0Q3dSbjY4SnBm?=
 =?utf-8?B?TmFwdVNFalhCRFdHSVhHazFEeUhHcHc2RVNmendRUkRkNWhRWml5d3V5RzNT?=
 =?utf-8?B?MXBlUkxiSVNwdWpXSmhMTjE4cTRVOHRMeC9heDBVTXVpRnp0dDdVNWhDa1NS?=
 =?utf-8?B?OGdKUEJEbTJ2Z2Y0SFZ4RkdEMnpVakpsTTlXZ3pGMG5iUUdaOFNnUlg2aW53?=
 =?utf-8?B?T2FvU2xIVGwvcnVtVUxrdFEyYllTNzhZMlNTQVg1ejVCVEFYQTh2S2lyM1Qv?=
 =?utf-8?B?R2tQL0V1bXgybjBHbVZqREYybEtqS1FJa0RjTU82QzVpRFF0NG5QcEMwSTI3?=
 =?utf-8?B?RnFRZy9oMVgzbHFVeXptK2FySnd1dEt0VmhqSUtjc0hDYVF0RlR0K0VnU3A4?=
 =?utf-8?B?TDJRR1RSczNvZ3l1ODVReG9qaG83aVhVa0VXYjRWdlRhVVRBWTZ2WEtvQ05v?=
 =?utf-8?B?SSs4VUw5QkNSbVVacjl1T2JFQlNQQ1FROEwzMDdpQWVzNkFhMDJuTTFEZXZX?=
 =?utf-8?B?eC9iZTlkRVo4emlWWTl0RnFKK093RERadzVETlV4TzhaNlF6VlNTZkdFUzRU?=
 =?utf-8?B?emhEOXlFdG1OTmxtSEVQenMxdm9oaVZiKzg1SFB3N3liYmFlZ3FEVkx1Zldr?=
 =?utf-8?B?SWVFMVdNdlZnTCtLaEgrL3hWdDkweUpnMlc3c2t2bG5sc2JESXpTUHNpbmNh?=
 =?utf-8?B?em1HcEcyT1A3ellINUk4QnlVWExDVSt6VGY4TlBoYWRkeFhCb2FHMmE2ZjhH?=
 =?utf-8?B?SWozSExuN0ZtZ2ZYRU0rMVdnazMwMVB1NkY0c2xEYUl3eThaSDljUEZwMFlj?=
 =?utf-8?B?R0VhYy9iQWxJaUh5a2hFQ29Vc0xOOWwvNHA5S0FLUThWcnVHSjNDZ3R4OGY4?=
 =?utf-8?B?bHdRMlQzN1VyR3V5ZmJGWjFlNWtod3cyREZUOW0zbTl3LzJETjBCU1U4OEdU?=
 =?utf-8?B?WlJyTlFMS0NYdnVDaW1QRHV4TFFWNTJDNXR0RTZWYXhHdG42K0Y4SFBSTVpP?=
 =?utf-8?B?Vmk1NENzT3VzR1dZOFFaMGJ5NUpzS2xhcnB3KzRhM1d5VVhhSmIyYXJCUjEx?=
 =?utf-8?B?c3B0RzZaMnF2RHZvT3FrLzU4Sy9DVFZ0VldFZis3cE4zdkJBekZMcHlWRzlp?=
 =?utf-8?B?RStTMVNjVVRRNmpod3ZXZVMzdUlnUkpZWlMzVzI0eldtbFkwSzVqYkNkS25p?=
 =?utf-8?B?K0daVzlxcitFMk1nNU8yNDFPU1R2dDVobnVFSUpuNmVwMzhPRzBpQWZna05X?=
 =?utf-8?B?OURTbWFOaGVXRGZvVnRVNnRWWFcvYXhhSzZ5MnFOY0VnZ0gzYjEzNG8vbVNr?=
 =?utf-8?B?Q1E4TGI1VkhUdU9yTktsSFdtTkUvenB4VTZqbFBxajM2cWNFUmdGbDJOV2xl?=
 =?utf-8?B?akZLUWc0QmMyVm44UEN3bDh6MUZDOGQ4akl1d29uNHVlcG5BZ1ZURkRpWTYr?=
 =?utf-8?B?ZGtzcnBaaVU3dmlNOGFnZ0VrTzhiVk9GNzArKzZRaEgvZG44RWljVDNaN2dX?=
 =?utf-8?Q?IMoxiBaWOzdpI?=
X-Forefront-Antispam-Report:
	CIP:20.208.138.155;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mx3.crn.activeguard.cloud;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004)(35042699013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:30:11.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfbc93d-48ca-458b-79af-08dc81868fb3
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[20.208.138.155];Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0770

Hi Arnaldo,

I reached some segfaults with perf mem, so I recompiled with DEBUG=1
and am sending below some stack traces. This is all with perf 6.9 for
now. The first one seems to pass a null pointer as format in frame #5,
along with a blank mem_loads_name:

gentoo ~ $ gdb --args perf mem record -t load -- root.exe -l -q
GNU gdb (Gentoo 14.2 vanilla) 14.2
Reading symbols from perf...
(gdb) run
Starting program: /usr/bin/perf mem record -t load -- root.exe -l -q
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib64/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
__strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
67		vmovdqu	(%rdi), %ymm2
(gdb) bt
#0  __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
#1  0x00007ffff6c982de in __find_specmb (format=0x0) at printf-parse.h:82
#2  __printf_buffer (buf=buf@entry=0x7fffffffc760, format=format@entry=0x0, ap=ap@entry=0x7fffffffc880,
    mode_flags=mode_flags@entry=0) at vfprintf-internal.c:649
#3  0x00007ffff6cb7840 in __vsnprintf_internal (string=<optimized out>, maxlen=<optimized out>, format=0x0,
    args=0x7fffffffc880, mode_flags=mode_flags@entry=0) at vsnprintf.c:96
#4  0x00007ffff6cb787f in ___vsnprintf (string=<optimized out>, maxlen=<optimized out>, format=<optimized out>,
    args=<optimized out>) at vsnprintf.c:103
#5  0x00005555557b9391 in scnprintf (buf=0x555555fe9320 <mem_loads_name> "", size=100, fmt=0x0)
    at ../lib/vsprintf.c:21
#6  0x00005555557b74c3 in perf_pmu__mem_events_name (i=0, pmu=0x555556832180) at util/mem-events.c:106
#7  0x00005555557b7ab9 in perf_mem_events__record_args (rec_argv=0x55555684c000, argv_nr=0x7fffffffca20)
    at util/mem-events.c:252
#8  0x00005555555e370d in __cmd_record (argc=3, argv=0x7fffffffd760, mem=0x7fffffffcd80) at builtin-mem.c:156
#9  0x00005555555e49c4 in cmd_mem (argc=4, argv=0x7fffffffd760) at builtin-mem.c:514
#10 0x000055555569716c in run_builtin (p=0x555555fcde80 <commands+672>, argc=8, argv=0x7fffffffd760) at perf.c:349
#11 0x0000555555697402 in handle_internal_command (argc=8, argv=0x7fffffffd760) at perf.c:402
#12 0x0000555555697560 in run_argv (argcp=0x7fffffffd59c, argv=0x7fffffffd590) at perf.c:446
#13 0x00005555556978a6 in main (argc=8, argv=0x7fffffffd760) at perf.c:562
(gdb)

when I record without -t load, then it works. However, when I report
with --hierarchy, I get a crash as well:

gentoo ~ $ gdb --args perf mem report --stdio --hierarchy
...
Program received signal SIGSEGV, Segmentation fault.
0x000055555574b228 in _hist_entry__sym_snprintf (ms=0x555558256940, ip=7237970023832232038, level=46 '.',
    bf=0x555558261200 "[.] ", size=525, width=42) at util/sort.c:376
376			if (sym->type == STT_OBJECT) {
(gdb) bt
#0  0x000055555574b228 in _hist_entry__sym_snprintf (ms=0x555558256940, ip=7237970023832232038, level=46 '.',
    bf=0x555558261200 "[.] ", size=525, width=42) at util/sort.c:376
#1  0x000055555574e148 in hist_entry__daddr_snprintf (he=0x5555568d66c0, bf=0x555558261200 "[.] ", size=525, width=42)
    at util/sort.c:1384
#2  0x0000555555750acb in __sort__hpp_entry (fmt=0x555556844a00, hpp=0x7fffffffa550, he=0x5555568d66c0)
    at util/sort.c:2505
#3  0x0000555555829cce in hist_entry__hierarchy_fprintf (he=0x5555568d66c0, hpp=0x7fffffffa550, hists=0x555556818270,
    fp=0x7ffff6df25c0 <_IO_2_1_stdout_>) at ui/stdio/hist.c:517
#4  0x000055555582a039 in hist_entry__fprintf (he=0x5555568d66c0, size=525, bf=0x555558261200 "[.] ", bfsz=525,
    fp=0x7ffff6df25c0 <_IO_2_1_stdout_>, ignore_callchains=true) at ui/stdio/hist.c:598
#5  0x000055555582adf5 in hists__fprintf (hists=0x555556818270, show_header=true, max_rows=0, max_cols=0, min_pcnt=0,
    fp=0x7ffff6df25c0 <_IO_2_1_stdout_>, ignore_callchains=true) at ui/stdio/hist.c:868
#6  0x00005555555b2442 in evlist__tty_browse_hists (evlist=0x55555682e000, rep=0x7fffffffa930,
    help=0x555556924240 "Tip: System-wide collection from all CPUs: perf record -a") at builtin-report.c:581
#7  0x00005555555b28c0 in report__browse_hists (rep=0x7fffffffa930) at builtin-report.c:684
#8  0x00005555555b3e7f in __cmd_report (rep=0x7fffffffa930) at builtin-report.c:1141
#9  0x00005555555b668a in cmd_report (argc=0, argv=0x555556806100) at builtin-report.c:1800
#10 0x00005555555e42d2 in report_events (argc=3, argv=0x7fffffffd790, mem=0x7fffffffcdb0) at builtin-mem.c:374
#11 0x00005555555e4a1c in cmd_mem (argc=3, argv=0x7fffffffd790) at builtin-mem.c:516
#12 0x000055555569716c in run_builtin (p=0x555555fcde80 <commands+672>, argc=4, argv=0x7fffffffd790) at perf.c:349
#13 0x0000555555697402 in handle_internal_command (argc=4, argv=0x7fffffffd790) at perf.c:402
#14 0x0000555555697560 in run_argv (argcp=0x7fffffffd5cc, argv=0x7fffffffd5c0) at perf.c:446
#15 0x00005555556978a6 in main (argc=4, argv=0x7fffffffd790) at perf.c:562
(gdb)

The other thing I noticed as of recently is that --hierarchy sometimes
fails to correctly show stacks:

$ sudo perf record -a --off-cpu -g -- sleep 10
gentoo ~ $ sudo perf report --stdio --no-children --percent-limit 5 -c swapper
# To display the perf.data header info, please use --header/--header-only options.
#
# comm: swapper
#
# Total Lost Samples: 0
#
# Samples: 17K of event 'cycles:P'
# Event count (approx.): 6796556494
#
# Overhead  Shared Object                        Symbol
# ........  ...................................  .........................................
#
    39.71%  [kernel.kallsyms]                    [k] io_idle
            |
             --32.55%--io_idle
                       acpi_idle_enter
                       cpuidle_enter_state
                       cpuidle_enter
                       call_cpuidle
                       do_idle
                       cpu_startup_entry
                       |
                        --31.71%--0xffffffffa18d046c
                                  secondary_startup_64

# Samples: 525  of event 'offcpu-time'
# Event count (approx.): 294273818205
#
# Overhead  Shared Object  Symbol
# ........  .............  ......
#

$ sudo perf report --stdio --no-children --percent-limit 5 -c swapper --hierarchy
# To display the perf.data header info, please use --header/--header-only options.
#
# comm: swapper
#
# Total Lost Samples: 0
#
# Samples: 17K of event 'cycles:P'
# Event count (approx.): 6796556494
#
#       Overhead  Command / Shared Object / Symbol
# ..............  ...............................................
#
    47.61%        swapper
       47.58%        [kernel.kallsyms]
          39.71%        [k] io_idle
            |
             --32.55%--0xffffffffa36504b3
                       0xffffffffa3650837
                       0xffffffffa364f9a4
                       0xffffffffa2e63049
                       0xffffffffa1a36d42
                       0xffffffffa1a3c963
                       0xffffffffa1a3cbc9
                       |
                        --31.71%--0xffffffffa18d046c
                                  0xffffffffa189aefd



# Samples: 525  of event 'offcpu-time'
# Event count (approx.): 294273818205
#
#       Overhead  Command / Shared Object / Symbol
# ..............  ................................
#

So the off-cpu stacks are not shown, and with --hierarchy symbol
resolution seems to not work anymore, which is somewhat strange.

This is the hardware I'm using:

gentoo ~ $ lscpu | head
Architecture:                         x86_64
CPU op-mode(s):                       32-bit, 64-bit
Address sizes:                        43 bits physical, 48 bits virtual
Byte Order:                           Little Endian
CPU(s):                               32
On-line CPU(s) list:                  0-31
Vendor ID:                            AuthenticAMD
Model name:                           AMD Ryzen 9 3950X 16-Core Processor
CPU family:                           23
Model:                                113

It's known to be buggy with the NMI interrupts, which still causes dmesg
to show strange messages like shown below:

[286943.722814] perf[1010806]: segfault at 0 ip 00007f1dc277ab43 sp 00007ffdcd302cd8 error 4 in libc.so.6[7f1dc2666000+134000] likely on CPU 5 (core 5, socket 0)
[286943.722827] Code: f8 77 c3 0f 1f 40 00 f3 0f 1e fa c5 f9 6e c6 89 f8 25 ff 0f 00 00 c4 e2 7d 78 c0 c5 f1 ef c9 3d e0 0f 00 00 0f 87 8d 01 00 00 <c5> fe 6f 17 c5 fd 74 da c5 f5 74 d2 c5 ed eb db c5 fd d7 c3 85 c0
[288940.208010] traps: perf[1111710] general protection fault ip:55c0999fb228 sp:7ffd96023f00 error:0 in perf[55c09983d000+31d000]
[289114.949941] perf: interrupt took too long (2511 > 2500), lowering kernel.perf_event_max_sample_rate to 79600
[289115.070561] WARNING: kernel stack frame pointer at 00000000189df501 in swapper/20:0 has bad value 000000005dc8ab50
[289115.070568] unwind stack type:0 next_sp:0000000000000000 mask:0x6 graph_idx:0
[289115.070570] 00000000b2bdf5fc: ffffab26805f4ba0 (0xffffab26805f4ba0)
[289115.070575] 000000008d353c11: ffffffffa365c2d2 (_raw_spin_lock_irqsave+0x52/0x70)
[289115.070580] 000000002fccc0bb: ffff9ca4057d5be8 (0xffff9ca4057d5be8)
[289115.070582] 00000000078840a2: 0000000000000000 ...
[289115.070583] 000000002c7f6250: ffffab26805f4bb8 (0xffffab26805f4bb8)
[289115.070585] 00000000afe09fb3: ffffffffc03eef12 (os_acquire_spinlock+0x12/0x30 [nvidia])
[289115.070844] 000000005d608f8f: ffff9ca4057d5bc8 (0xffff9ca4057d5bc8)
[289115.070846] 00000000189df501: ffff9ca4297ade60 (0xffff9ca4297ade60)
[289115.070848] 00000000b4c4e61a: ffffffffc0cfd120 (_nv044096rm+0x10/0x20 [nvidia])
[289115.071189] 00000000e2a64928: 0000000000000000 ...

and later (the usual "Dazed and confused ones"):

[289115.075161] INFO: NMI handler (perf_ibs_nmi_handler) took too long to run: 4.605 msecs
[289115.075166] perf: interrupt took too long (38058 > 3138), lowering kernel.perf_event_max_sample_rate to 5200
[289117.772464] Uhhuh. NMI received for unknown reason 3c on CPU 16.
[289117.772468] Dazed and confused, but trying to continue

I wonder also if the nvidia drivers taint have anything to do with this.
I'd appreciate your insights in helping to debug this last problem, as I
couldn't find out why it's happening. I'm running Linux 6.9.0.

I hope this is enough information to at least fix the segfaults, but if
you need any extra information, please let me know.

Best regards,
-Guilherme

