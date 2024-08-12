Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E516D9CB;
	Mon, 12 Aug 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.86
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455500; cv=fail; b=bCn0RHfPT1BArKZoaG/Z3oM29IMpJ6b1rKJJYF2kxUfZinG7gKkEPyKKVum5oF/lLn4Z0F6BJrm7KjpaLR9d2+MbZtRPwv6nTPScpqAikcNhk48Q8quTqdoLNeHadWDNUbwjC3fJvYaLo2XfJXYxHzR3AuUQ46I6n6ZCfrMCYpg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455500; c=relaxed/simple;
	bh=amG1gMKQen1BTVzOT77uDJzB6/YXE0wQxjSkF/IIqk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pRw/7U4Iy3sGssNXz9RF2Yex+zCtrI3SupN3zuJwIpcrEfqTZIjlyOZBUZos188nRYVbHEUdUjfnSpnAUNLZUwL8Z/ZbsfFB/FGQCzdasdFGsJkLYq8vx+e7uCC3sQrXw4+DB/AWHhnUiG9vIOZcv3Pu59tKCsfznortuLZDC5w=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZVf/Wa+M; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZVf/Wa+M; arc=fail smtp.client-ip=40.107.247.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZVf/Wa+M";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZVf/Wa+M"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qGkoF/KEM7C0pb4VAkv0MR4lV679ELQSeEG3Y4KArvdzSwZRzHBt0/6hzlZiY7ylobYi6XGJIgMgU3ejH3s8kHtudEz3hQGiPg/G/6A+GdMOcMeZXh4ISF6KVIbs3IuNJvzR030Y1CJCrBRPo9JC32lPtRw7vT16DuD73jUEimWVe7n36IpyRELWAJZQ5/urCcPCwyuhotTDD6TE7ZeqSZwd5Noa/F2kaAQFDBP3qnLGZwU9+PuRTlP0EKtDbEDN0r93vncIkImbgRwgpAlXiSLJzL4GntNnIK2ZOeXPXif4ds5+G49JPYsUxwjJsFo52DNVrC8yzYAqWF4EmSbxKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FYXMpUM3QaCPpL620bRtTDg5MxR1VEbVy1j3KZl2VU=;
 b=kdAOpKLT3K1VKvgqOc3bPtIr0IW+0YBvc2mDS8vgwHXWXc3bwEZhtmeh5uBiTVmXNEWuDCuaiO2/bvzl6PaW41FoBYTcbcy1EgMAdXWpg35ni4yJ4Jf1Tas7/BcpOltMnmFbqUEbBATwk6lQdYCB4qgLK/XXCM4buvg85cm//EgOBQ9GAmAhnC73w3h/QlbdDKcfhrVFiMmdN3i4+eJHmOBVoGBqTH9HVY+h/Ukkh3SffoeTxfSXq2PrBOj5P/yVffkcRPE4pc/1Ei51YGZOGwVEBig1pow+Svo/8h0lgBZ/KVspfLufQCcIOA0ABxd7xSUjVAodrEzws8wXe9X/3g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FYXMpUM3QaCPpL620bRtTDg5MxR1VEbVy1j3KZl2VU=;
 b=ZVf/Wa+Mbp+UlC/AyKCe0feKm+GoLRG4lAEacq9K1bD35z+nUTqX0ySsi9VGRQJj5nIska5cZvKkdyFWu/8q5XHneFm+g+8KhRdfpW5b3ObWA86+B6j3sydd9T8SsUCcCtxC73A8HKj7YFbmZJ9E9w/ZdiWyUd5o07I7+TMWAV0=
Received: from AS9PR06CA0383.eurprd06.prod.outlook.com (2603:10a6:20b:460::30)
 by AS4PR08MB7406.eurprd08.prod.outlook.com (2603:10a6:20b:4e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 09:38:12 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:460:cafe::b8) by AS9PR06CA0383.outlook.office365.com
 (2603:10a6:20b:460::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Mon, 12 Aug 2024 09:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7849.8
 via Frontend Transport; Mon, 12 Aug 2024 09:38:12 +0000
Received: ("Tessian outbound 3d5aa05142a5:v403"); Mon, 12 Aug 2024 09:38:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3be5750f2568c9da
X-CR-MTA-TID: 64aa7808
Received: from L0890ec38c744.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0504B807-8536-4E1B-93CE-B513AAAA4A33.1;
	Mon, 12 Aug 2024 09:38:01 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L0890ec38c744.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 12 Aug 2024 09:38:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxBOqefYkBg1jRN7Q/s40Zco2KOY8F4N4mq1VToSrwjet9p8BU+kVthmP4AxtlcewNrJT3nmJncLRftK2MqUnXdhML8847cz/e3esXgWA6NbK9jFpgWYqYThp2zRG3+MvPd/7t1nStxs/jJC77jtmLlFmFK1IvBwXsJFb043MD0r5nRY/l6YIak/s/7toSIgjtixDrgyf//EbH9+Obpmbr0jwJf7+/qoeUDdm6NnvsMDpWoBiYkk/QdfA15ef5zaX/cromFj1lF9wZwVXQJN1zMo4A1nT7gxJFz5gv3vFgl6EPqquyLrF4MvadnBr7F2k0JMTbpp3XRpIDfXvaQHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FYXMpUM3QaCPpL620bRtTDg5MxR1VEbVy1j3KZl2VU=;
 b=jJtGI/k8j4Z1vzhhaXVi2WsRFwzBqB7lVAFmRb2d/ptSeOJMVKfzy2PfpxGQpnwHJGdEadHwzu5zwIGBnevWKGE2YUtUa+M3OF51zXHU6QKIpigMoeW0uowROqsC+CYJC+RGVRrzjoC+0QJ3A/QCETN4gQTRTsyssN+Ns2gLtlwzQPbESYPypRQyDzyaqlsfjlyKBaZj3VLBMEMwu/bN+AXjqo6EvcZgbPDCDKcouDZn0/fLFuo4qKJUzYpSkIZ8ceXSE21IlW8ERmjOoxoV8Od94L32em1B537CuBW+RvJPwFug1uTS5O0Sb1w7QBgXvaIHDlAw4HEDZv+Z6DPfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FYXMpUM3QaCPpL620bRtTDg5MxR1VEbVy1j3KZl2VU=;
 b=ZVf/Wa+Mbp+UlC/AyKCe0feKm+GoLRG4lAEacq9K1bD35z+nUTqX0ySsi9VGRQJj5nIska5cZvKkdyFWu/8q5XHneFm+g+8KhRdfpW5b3ObWA86+B6j3sydd9T8SsUCcCtxC73A8HKj7YFbmZJ9E9w/ZdiWyUd5o07I7+TMWAV0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13)
 by AS8PR08MB8633.eurprd08.prod.outlook.com (2603:10a6:20b:565::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 09:37:57 +0000
Received: from PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad]) by PAXPR08MB6591.eurprd08.prod.outlook.com
 ([fe80::9c15:44ce:9335:a5ad%3]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 09:37:57 +0000
Message-ID: <a5015d55-6fa4-4078-8ccb-6a11748099d5@arm.com>
Date: Mon, 12 Aug 2024 10:37:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf docs: Refine the description for the buffer size
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Govindarajan.Mohandoss@arm.com
References: <20240810161540.2282535-1-leo.yan@arm.com>
 <9b27533e-6dc6-4476-8f0b-4497388efde3@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <9b27533e-6dc6-4476-8f0b-4497388efde3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::14) To PAXPR08MB6591.eurprd08.prod.outlook.com
 (2603:10a6:102:150::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR08MB6591:EE_|AS8PR08MB8633:EE_|AM2PEPF0001C717:EE_|AS4PR08MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 07048a2b-0c13-4a1c-25be-08dcbab27c1c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UnNvMnd2dFhUOGVNdE5KVkM3dGZMYWRSQ2JxSXIvTzZpbDJwbitoK3RKdm9Z?=
 =?utf-8?B?NFRtV3hOblNOQVNuMXZibDM2czdTcjNKQWFQeCtDdXBMdmpwRXFqdVErZVpO?=
 =?utf-8?B?S00ybjFSa28zLzByeVB1N3VDdDRMcDBlb2Q4Mm1TWDZJQ2lSNFRCYml0blpU?=
 =?utf-8?B?YWI5SGIvNmE3NWJwdU8rQ2JCOEFld0pSaFpBZFhtRmRIL2lFNjdhVGxOT2Ey?=
 =?utf-8?B?NmJEdVNXU0V5NTRKamZIcTNkc2t1azZGbG95eGRiSXozQ3JYdWtGbjduYkpu?=
 =?utf-8?B?MnBHSytEYWVoOW1EYTBIUUM4N3cxbFZGREw0Z3N1bStGblBwb25iZU9SVTlw?=
 =?utf-8?B?N2FjNTdXWHVUSWF6SGZ4a2xoT24xWndPbTVPaTA0MEhKSjZDUFgyQnlKWThT?=
 =?utf-8?B?ay9HL2lZWTF0Y0lwLy95SUNmK1FqSnA3dmdWSnhPV21CQXFadDBzK3N5djFt?=
 =?utf-8?B?d2NrWnVUM0krQWlYdDU1N2ZmMHlvWUdsMTlCTHpBemlwR0Q5S0NJeit6N0xT?=
 =?utf-8?B?a1BnSHBuSTUxRi9Td1Q5dFVzR3I1bVc2NTJGMjZ6Wk5idC93ZGE3ZndBeGxX?=
 =?utf-8?B?WHNWQVpySWVJKzhRcnZGNXNXbmRUMUVhTlBOSlpLTThYS3pEU29yRWU5UXg3?=
 =?utf-8?B?ZGJ1TGJWNW5vZlRJWlQrUm4vS2pBeXZCK0lRTTJ4RUE4cXZtWUFHaU96dko2?=
 =?utf-8?B?czRyc1NtRSs5YmFPMVR1VGFZUGRUZHFROTRxSnp6SGxwMGFqZG1ETHlZZE9M?=
 =?utf-8?B?d3duZXRtL3cxVGJ4RnFjNXBUK1hMR3pBTDBKeEl0TktWMjZPYUxRRmRsaHVU?=
 =?utf-8?B?dUpINjlieXp0andXRDZUb1MvY3dZV0k4WWlsVW1iVXAvbEtXUWNhWmFXMkQ3?=
 =?utf-8?B?cG92d0hlOGppNlpVTHRSWWJ5eW9peXdGSGFLTEV0NFpGVXFaOUhVTnc4aDZB?=
 =?utf-8?B?cVI0ZVNWYzV2Sk1RSCsxdkRFa09tcXYzd3lBeGk3bWhlNUNka2lmZU9xWm9v?=
 =?utf-8?B?bWVDZEVJeEcxYjJSQzd4Q01SUXhqOGczMTB2ZVduemlqTWZvbHZtUmZDazEy?=
 =?utf-8?B?YlJ2NGF2UndXL1BESnFycG5TekQ0enVSYWFBeWhUa3BkVkM0TmJsRlM2MlMy?=
 =?utf-8?B?WnhSbEcwYU1neFBiWVRYSnpsajJPQlpFQWp4RlpqcTZTYkNYMTdBekN4SkE4?=
 =?utf-8?B?NzdYS0ZJbnZlUDFSZGgzaGFLYytLL29KZStkYzllVytqM2wvUnZpLzBuUXpD?=
 =?utf-8?B?VURkRHMyYlRFZlprQktRaGFTR0w3RlR6OG1rMjBrSnkwSGJ2UC85WjlzREtL?=
 =?utf-8?B?VnRqZ0VZTDllVWNVbENYbDV5NVlPcWJDSTcvL3ZlY0lrY3dpR2NhcDUwNVhZ?=
 =?utf-8?B?YmhHajZJMEgxUWpwUnI5RWJ4V0wwZldTWC9HZ2VWdFF0UFZ5NCtTSlI4VWE2?=
 =?utf-8?B?T3dPeU1zcU5UbFFjL2RPR0wvZHMrazhpWkhCM2dORTV1ZFdubGI5c3pITFlW?=
 =?utf-8?B?cEhaQkpqakQ0ODdwaENOZnhLYldkTWljdG1IdDNFZDFaT2JjRC80SHFPaWJk?=
 =?utf-8?B?ZUpYd2htZVFEelJpdk1TdjZWdUZrMnIzOTl3dlV2ZFhhQ2REd0dsNHJKd0Fl?=
 =?utf-8?B?ckYxV1Q4cm10SW1CVzR0Vmh6UXZwYUJTQStidUlPL2Iyajh6bjVibW9jWUlx?=
 =?utf-8?B?L3NpSlZvRFlVa010SzdJSW5LZ1hFVUJBWGNiLzlFNy94dUtxcGozelkvYmZ3?=
 =?utf-8?B?WENTRmtCMnZxUzl2Z3ZMNUZCdTlaTUhDVkF0NnhpbHVwbk9jcnRxbXZoSGI5?=
 =?utf-8?B?NlU4aFc1S2tlMHFvYTd1QT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6591.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8633
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:150::13];domain=PAXPR08MB6591.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	03e4e222-3b44-4d6d-e329-08dcbab2728c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm16T1FGd0NWQ3dsT1JSVW4yWkI1MTZ3UCtGbEVFZmNGUnZQaUpQZWVaM2N4?=
 =?utf-8?B?dGtJU0U3emx5ZTJab24xM3ZZOTJKZFdweHRHNUwrVWljMi9OOU5nZ0E4em54?=
 =?utf-8?B?MVJwU3QzT3pHQWVwNWlmbjlVNk9XbGNQV1ZEVVR2Q2w2RlRjV3Q5OVBtZzlk?=
 =?utf-8?B?bW5IUm9BdFJwRkhhV3liM3ZwQjBwT3ZuejJXcE1mbmZYUmZmZjJPbG1ydzZY?=
 =?utf-8?B?Wlg0NWJyeFpRemhUSThiSStWSWRWc0U2MmpOZ2JhVnRocnNsVmFMam8xUXl2?=
 =?utf-8?B?TnZQK3I4U3hLTzVydUJFMVJ6WDJiR1kxNENPYXk5OUs0S2FYc3pSTjFIMCsw?=
 =?utf-8?B?blpIWmxKNUEyYTIyRitrdFhNdlRzSy9PaWR1QnZka2FGcnRhVFN6cDJPWHVZ?=
 =?utf-8?B?emluNmROU0JMbjFLcFBqMFgyYWlxUStxZW5ZUUNmeVVNSmd4cDYybmRRampQ?=
 =?utf-8?B?V0dOU0hacTIxREN6RHYwUEpMOGVnSXRvNlJySmJ3dlFkM3U2NncyakR0NW1n?=
 =?utf-8?B?S1NDaDl2UUM4bWlWMmlBTTZzZG9Mbm05RzV5T0g1UkhqdnNPVlR2UjgzSG12?=
 =?utf-8?B?aFFCU1M4SGdhTStwaWNna1VwTmJqTW55OWN5OGlPUmorM2lKYkVNYWhicHcy?=
 =?utf-8?B?aDZOd2xBcTVZL1QzTVdBWDRta0J5LzhvZXpYQXZnR3dISGRDeWdkYmhQZWtX?=
 =?utf-8?B?SnNmRGx5RVE2aXdzMkRzUDcwWS9RSEF2T0h2WDFsNDVadEt1SXZ6RzBKQTdr?=
 =?utf-8?B?blo3LzZEbkhMbjJSMkgzQlNSY3k2U1NkYVl6dVk3TVlvSTg5MmxKMktpY3VN?=
 =?utf-8?B?NzM4ZGxMbFlFVGtzRk50M0U1clJlRnVwdndKMmF2UjlieTIwbWk2QStlcG5P?=
 =?utf-8?B?bkNhQ0padVRrQmoxakJ1VGxSdWpWeHdOZ08yczBEYUtkR3kzcVUybVlXb0lm?=
 =?utf-8?B?VFAxdnk2NjRlU1huNnJLT281QXBuQlJ0TTY2TVFUMTI4V1AybFljTCt4ajVs?=
 =?utf-8?B?N3laanBOSkIvTmhPRyt6dGpHT3Q4YzVPcVpuZ3ljQ3Z2SzRSWGZNbzhNU3Fi?=
 =?utf-8?B?cXJGWVAwbE0xVlBpaWNmNkdlRlpuelpCejZHd0Vic0ZSNVU1ZWkrWjRsam1r?=
 =?utf-8?B?ekJvM3BLR2ZTRS9iV2pYUEdhUlVPaFVmQ2NQdHB6UU8xSWxhZ3YxQ2VFUGpT?=
 =?utf-8?B?NGMvNEpoVGJKWnZVdjV6ZWhDREw2VGhscHVTSzZlYUY4WEo3RTY1L1Mza3VK?=
 =?utf-8?B?aytQbm5odHc3azFubVpjKzgvOEpRK2wzS1laSUlqZmlkSjU2VjM3V28yTWJG?=
 =?utf-8?B?Mjk2Y0Vpck0vb2hBaWI1USs0QTVwdUEyVkdEK2YzUjlVbElScGFUS0NYOERt?=
 =?utf-8?B?Yk9JV1c3alI2dmpWVG9qYy9WZUo5TmFUVXdDVmE4Ym5KMGhPY29tdzdIekVH?=
 =?utf-8?B?Z2M3dG5YTWVlVm95bEIyNmhTVk1BT2M2RHROc2h3RWVNcEo4YlhmVWdZVzJy?=
 =?utf-8?B?S3Y1S0hUa3hYcjFZdUtuSUhoYTdDUE85UXJubmoxZUFrL2l0RFR5cVQzaDBo?=
 =?utf-8?B?RC8xWWtSNmxsQzZLWElSM0pmaE95Q1NONzFQZ2tjbEhVSUIza2JXcmJ4OWIv?=
 =?utf-8?B?N211ZDNoUWRSYVpMOGxBTE1nUGxjTDY1Nis4SHhFYUczbmJWVzcxMDBoZFEv?=
 =?utf-8?B?TSs1MUxXUDZab25XNlQ3TnB6WWg3aUxCbENyVDU2UUk4Zk9udjBveDNSNW10?=
 =?utf-8?B?cWFuMVZmOHNCaVU1U2JiUVZxYWd2RVA5ODZTdWhiZUx1WlI0SW13N2t1YWxC?=
 =?utf-8?B?UG15QmsrZitpYjhBSzFwdFJ1Slp6WmRzZk85WUhXUm4vaWthQnU5UGRST3ox?=
 =?utf-8?B?aUlkZHNCL3k3ZENVQkpCVzF3RzNQRmFocTFlYUUyaE9McFo4YlNvUEpxTEU5?=
 =?utf-8?Q?BTy7vgzvhQv58V0wD8tSb0rr8zJOjIan?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:38:12.8151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07048a2b-0c13-4a1c-25be-08dcbab27c1c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7406



On 8/12/24 10:11, James Clark wrote:

[...]

> On 10/08/2024 5:15 pm, Leo Yan wrote:
>> Current description for the AUX trace buffer size is misleading. When a
>> user specifies the option '-m,512M', it represents a size value in bytes
>> (512MiB) but not 512M pages (512M x 4KiB regard to a page of 4KiB).
>>
>> Make the document clear that the normal buffer and the AUX tracing
>> buffer share the same semantics.
>>
>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>> ---
>>   tools/perf/Documentation/perf-record.txt | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 41e36b4dc765..242223240a08 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -273,10 +273,11 @@ OPTIONS
>>   -m::
>>   --mmap-pages=::
>>       Number of mmap data pages (must be a power of two) or size
>> -     specification with appended unit character - B/K/M/G. The
>> -     size is rounded up to have nearest pages power of two value.
>> -     Also, by adding a comma, the number of mmap pages for AUX
>> -     area tracing can be specified.
>> +     specification in bytes with appended unit character - B/K/M/G.
>> +     The size is rounded up to the nearest power-of-two page value.
>> +     By adding a comma, an additional parameter with the same
>> +     semantics used for the normal mmap areas can be specified for
>> +     AUX tracing area.
>>
>>   -g::
>>       Enables call-graph (stack chain/backtrace) recording for both
> 
> The same text is repeated on a few tools, probably makes sense to update
> them all at the same time.
> 
> With that change:
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks for review. Sent a new patch with suggestion.

Leo
