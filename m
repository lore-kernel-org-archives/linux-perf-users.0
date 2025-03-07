Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEC2561D3;
	Fri,  7 Mar 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379320; cv=fail; b=GzG5IGBh+rcocFr3tB/WYihxb9WfDOwAdcbcHud0VMhdZQO5S7LoIJkZOvx90SvwlSLjCmnr7Xk/VyVhCI7AlwXAeizPDwaZJqPgS/pM5eGwHeUTfgzlYSE9QCOQ5Cti/VzhFY/YKh8QQ8l7abZP/sGvDNZgXVq5p0LbQq75Tns=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379320; c=relaxed/simple;
	bh=5PydjVRzQD6EtAW/78E356ATx/872sI2tqH0cjhHsDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ie9hfjlNmzmU+xKqiFMoXDqjjjhdjQMaxV7EslLtyrbYnjauS8Eh0ALhKeK2ucs/MGdlH8oR1KDAdXg+CALLjro69KPmb0xocIkxsNwGM6QBiiQ+Ht/ZcsOk++5oqLNX7TvI80w2NLxNgBslRiRB/Yd+lGFJZQzpiF7+gUzoTp8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a3PmN6BZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a3PmN6BZ; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a3PmN6BZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a3PmN6BZ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Wl/m9Xgehk1Gb9CubnuYtOTikpKrCAhpWPgdilRd0xeLiZmq/i3pezjvNWXEk2/3W+LN6z7GOEsE7ANdaXV9sebytREayV2J4J94rG1ZP17jUTqBHZkzVsHPuDV31xhQ4G/0nQPE+OAa7tiVTzew39MkD14TCoFHGCf2T7wYGlRc2kptzS7qCxZ+WUo3VRxXqV5BmlKkv7zpK1G1cBLiXCBf0/PC4f0BojQlAtUbsVk4ieWdnJRVnQFBLi325cABym782GESYodgkCPr0kZBGdyhSCHmvijn6cq1ePyum0diz94dCotqO7afdDqCGV9QEtu9jR3B9HSXq/AMKINY4g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8DaUg0EWwcSKMTTwvCanrcDjLZMF4lXvCi8asDeXIE=;
 b=siA/qLYhtdTkIRz37jXLjMsMLntQW71fScyOYp50WCW221dgr7VX9dGy80qD3r+uvLp00RHkWvjP2GKFFr6r2fiuNATPe6AGF+7z8dwVnAFO64wg0RrEsbq+d31Fu2EX9J9CQbjoF+E3MYB+yV090DCnCwCJpkF8iroY0vkhq4KM/pNyJ0PMU75SHMcsEmeVRs+D40ac+wKhXqRTO/mj0hiTUXYw17WOz7qLVn26jwZKRsBcHxroQeZCYgUGuy8PDPkassgoTWw9Gduvq+vuh+DRjZ2PyYu5BaU2z3mhN8lXtEFGdZHpGIQ0Cf1VNgb0Nz0LDm5ukIdDCEAexW1y+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8DaUg0EWwcSKMTTwvCanrcDjLZMF4lXvCi8asDeXIE=;
 b=a3PmN6BZrsH3Wwv7glvT37h6P/svqIEHt8ZrcoHjJ4QJ0s3hEHi+m93sSHQjCmNYl0u0IFRNn0kftzV8UwhNd+DgcHz9q6d2E80OsTcQeecVA+G0Lj9buZh+/u5e8IQ/S0ELYWMm/+05BH9gXoYt4J3a7VQA02WJjodM8tvgE+E=
Received: from DUZPR01CA0256.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::16) by AS2PR08MB8745.eurprd08.prod.outlook.com
 (2603:10a6:20b:55d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 20:28:30 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::72) by DUZPR01CA0256.outlook.office365.com
 (2603:10a6:10:4b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 20:28:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Fri, 7 Mar 2025 20:28:29 +0000
Received: ("Tessian outbound c3a902884497:v585"); Fri, 07 Mar 2025 20:28:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 71ec563f0a98e457
X-TessianGatewayMetadata: OLLKm3K1NSZGsOKwv1Wf8YDZX0lJw5y31H2qv6C/xuCkQHr0yniwDRUHOiez5xhm7gbT/6iSNRHvbv+xQDBRe5vnJCZtv0jpDnRfdPUfF520Rf6ci/3c4Lsn2288Q0ETSGXCJaBXTHNtTl2smm8kS4LJFCRgRS3ozM0QcA4hRzo=
X-CR-MTA-TID: 64aa7808
Received: from Lf6df87b1f986.3
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4276B66A-DE5F-4670-95B1-5DA88F4CA3D3.1;
	Fri, 07 Mar 2025 20:28:19 +0000
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf6df87b1f986.3
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 07 Mar 2025 20:28:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNMalycQtMcWyMhMYLxq8/ZhJJ/qTTMvQNhXRdqelB2rW7SNoGiYfJ17qEyPeTaNjHcfz7N2jqoHMb+C8pxTwWfjnDYtH7T3yVsjkEzBfcN64ZsQZinembWskWrLgOOMQ47UjNcfDIVkdNoreRScNH7gz6qxrfA1VyRXFAlRJKiPzCmp+WSXGQK7LgPNGL3AsMXmdR4LfP/VdOqjvpMbJIMariQKQ7dqD7SIIlA2b7+NdXb/7h2eLdZjMRpYJniFZItANA0SmOrvlh03tJ4nHA8Ivx8+KGRrxeXxE9WC9Qcjghq6UsSMwYWKHHfi6Ve/8v6pkCMqsS0vDHZYpvBRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8DaUg0EWwcSKMTTwvCanrcDjLZMF4lXvCi8asDeXIE=;
 b=uvFqR3bIEKRC0lVFnabMQGCRQz/A1MJDruils1oHZD6Mu6nOmD0lf9BAMaBnjHqBLezXQIqQrKHxMgw9sJU5d9yy0bfMWWZXDZ+2Cq8m1MXiMnSvFnmvtaUWMlqEnMfvF1ziDC+Dzq0+R5rUtZDT11Iaq7T2H8Wyzuu/ZghRjrmbK/iUPiLTLSKaqBZT8ECTwrBpw0LwRYM073A9URZ5Mafvtp+TiRwN8u/lWz923FdDW0/42XX2ticA6M05U3+yxPmpSzJ2+xBiei8msCFnWLkwmK/JC9htAgwSJfPltevWg04QIPFRqgZYCJ+3NSRp7ibWEsvM24dj5PkxlgHD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8DaUg0EWwcSKMTTwvCanrcDjLZMF4lXvCi8asDeXIE=;
 b=a3PmN6BZrsH3Wwv7glvT37h6P/svqIEHt8ZrcoHjJ4QJ0s3hEHi+m93sSHQjCmNYl0u0IFRNn0kftzV8UwhNd+DgcHz9q6d2E80OsTcQeecVA+G0Lj9buZh+/u5e8IQ/S0ELYWMm/+05BH9gXoYt4J3a7VQA02WJjodM8tvgE+E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com (2603:10a6:10:308::6)
 by DU0PR08MB8161.eurprd08.prod.outlook.com (2603:10a6:10:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 20:28:16 +0000
Received: from DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb]) by DB9PR08MB7584.eurprd08.prod.outlook.com
 ([fe80::5144:343:7017:bacb%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:28:16 +0000
Message-ID: <c62a9f8a-312d-4f9e-9022-265e53564101@arm.com>
Date: Fri, 7 Mar 2025 20:28:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] perf: Allow periodic events to alternate between
 two sample periods
To: Leo Yan <leo.yan@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
 deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
 james.clark@arm.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250106120156.227273-1-mark.barnett@arm.com>
 <20250106120156.227273-2-mark.barnett@arm.com>
 <20250121130154.GA416913@e132581.arm.com>
Content-Language: en-US
From: Mark Barnett <mark.barnett@arm.com>
In-Reply-To: <20250121130154.GA416913@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To DB9PR08MB7584.eurprd08.prod.outlook.com
 (2603:10a6:10:308::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7584:EE_|DU0PR08MB8161:EE_|DU2PEPF00028D0D:EE_|AS2PR08MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c11e61d-3132-41c7-2c37-08dd5db69f88
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dDBXekxXY25hV0hSS2ZIbCt3aFJXSFlSbCtyY3dBcnlYMGhTVXlJODJKNUJO?=
 =?utf-8?B?TFRzM05rVHUxdXhpWldFeW5ibTBGM0FJcHFWRVB2M1dzdTRQNHMwUXdwV0Nq?=
 =?utf-8?B?b3o3dTRPYWtoNzVqZ1Y1OFhqWTNWWGd2TEVMUFQ4R3hWa2o2ZjNNY1hIcXR3?=
 =?utf-8?B?TENicDF3M3FvekxpQjkzU0doZWxxSzdua08wbXlkSE11eEZOT1lQejdISXZ0?=
 =?utf-8?B?RUc0WENMOTR4dHdSTUFPTHFxRmRCT1c4a2lNWm5CWW11eno5NFcvbERhclBz?=
 =?utf-8?B?M2p4MHJkS1JEcEtmR1p6TkJoTHJVNEJLbURTVWZ4MnhmSzZJSlpUbW4zakc3?=
 =?utf-8?B?a2o5Y1E0WENWZkkwT0h5cm83QUgrMlZYVkdhWjlodHpPNytBRlNQcjlqQ0pZ?=
 =?utf-8?B?dWh5Yjg1YWpaWTg4eStZNUlOKzZXSW9ybEJCRThBMS81YkE0YkdGeEhhVlBZ?=
 =?utf-8?B?NW85dHN4L3Eza2hlbERxVzBvelNtY1FwWDBZZklGM1lJdk1HY2dmZVdjeXdM?=
 =?utf-8?B?cFpvZXNTNjNaampFaFZJYWd1WjUwVXVIY1pVYUJTN2dqTEppeXQ0NVRXZE5q?=
 =?utf-8?B?VUNwcnE5OFhrZ25TbnRUMm9pWkc4K0ZkZzc5L0hYY28rbjVRZEt3KzNzR3BU?=
 =?utf-8?B?Nmg1OGF2bE5xOEJ4cFlDM2VFT1c0YXgxQmlRTngyVWp5dm1TdjFHSkIya2hL?=
 =?utf-8?B?M2xhTk9udVdzU2xnT2ZBanhrNWFhT2Y2U1I5STFtL1g4SThjVGd4WVZka2Y2?=
 =?utf-8?B?ZnIwU0srRFNERVVZWU4zQ2g3blN3eGo1ZHR4K2VNeXpEK3pianFCY1FoMUlz?=
 =?utf-8?B?bzlyaTFrUFJJNWt6S1ZSRmtJcXpENlRYSGg3RVR3dXpxRzVYdWU0VmhFNVhE?=
 =?utf-8?B?cmRiblplS0lHZGk3M1FqV0NqMmZHRUpqams0dWdwckZXMThwZVg0eXdkYjR2?=
 =?utf-8?B?QUpYbTdpVmVyZXRFM09XaEF0UEs5dEtnSGtabDZRenRlZFdCdGNUdmxORXky?=
 =?utf-8?B?RGovL0t3a3AxaUo1QlVzRExCenV4VjcrZHBjTVZIcURRNUpPd2syUUpMb0d2?=
 =?utf-8?B?aHg5ZndPOGJWMDAxUEFnZjRNQzJVY1lOOEFzUEhyYlZ0c1oyZDR2SFRWNFVy?=
 =?utf-8?B?QlhzZzk1VU1SZ3BnU3I2MWU5RzA4VjZwNytBTkg3d2xwd29UZWRGaWVjWHBL?=
 =?utf-8?B?VUZ2Tm1RRjdlQXRJMTRwVFF2dzRmNW1HMWtRSjUzeElmbkhHSkhWZStkNGN6?=
 =?utf-8?B?QkJIT2hMT2l2bWF3L3BXbkhYVHg3MVlLRWFsS1puTE54THNGL2owbm9CWVRU?=
 =?utf-8?B?RkRjQ01pTkdRU2lmZlhYdFo1UzFEYWNrWVJ4S2poL3NGNHVJWXRwTk1HTHNZ?=
 =?utf-8?B?L21UYlI1cm9oUlNvbnU5enB3amt3NUY0bzdWY1Z3MG43bWo5dzJ5Mk9KQk5a?=
 =?utf-8?B?dEdIbkZxSTQzeC9ZOU12VFhwWTlFNVlucW5KUU5MU3lKd3RGazBxdXh1Y2Ev?=
 =?utf-8?B?SXd6b01uUFNoN2tYMG5oMC90enhyS0FKM25uTkg2VUlwdGRHVC9rclF2elVx?=
 =?utf-8?B?UzZmUUpsNmlYQ3RVd0huQ0FWSzE2Yi9FZEV5RjFmRkRFSG1KclV0YTdKaHJZ?=
 =?utf-8?B?WElRanNOR2ZkZFVuRHU0VzlVcVJURGZSYWY4SExqaSs5NUVlNnJlYTkrenRQ?=
 =?utf-8?B?OUJ4dVFvQ2JFNDZHcXY1Y3dOaTVsZGZJeFJTWWxydFlmU2pBcURSeUVaTjla?=
 =?utf-8?B?eHZlY3c2ZlRmb0lhODVUdHBSc1lzcS9zRVQxdTF3bnJLNEZ2OWE2OFBMSDUr?=
 =?utf-8?B?V3RhZEg3N2RybDFXWUV3L2RnS09mVkhFNkpvUjRhaU11bExKZDM0bzRRSnNq?=
 =?utf-8?Q?Zl9B021KE9kJx?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7584.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8161
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:10:308::6];domain=DB9PR08MB7584.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e9f56739-f817-4b3c-198b-08dd5db69779
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|376014|36860700013|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N09DYS9YVTJ5RFoyb3d2dzhVWDdzcmlXK3ZTMDM4elFFZXU4SCtIVk44c1Ir?=
 =?utf-8?B?T2dDOHpsSGlCT3N5ZS9vaE1NR1dZSEdzd3dMVmJUeTQxOEYyRGtHdnQyMmk0?=
 =?utf-8?B?Smo4VzJHdGtKcFVmdzFadlFoSnBkSzJLbVBXTGxGdlVkbGd1TnMrZHhlY3Uw?=
 =?utf-8?B?cHlrb2dWeDNCVm5JQ0ZtK3lTSVZGSC9najl6QkhwVkttUGt4YWhab0JiNm45?=
 =?utf-8?B?cm9CcWkyYkROVWIvdTJqbkE4dE5rWXltS09sb09yQXBvL0ZmdWxhcTE3L2Fa?=
 =?utf-8?B?elRNdnd5d1MxV0prRnFNSHJLQUJtMHMwajZGTXl3SmNQTFhFQWdWNVdlR2JZ?=
 =?utf-8?B?TVZOOFFtYnJ2SS9VNmFyVnJNT2ZCeFk4NUJJWWEvN3YveGduaGJVQ3l5cDBE?=
 =?utf-8?B?S2VYWENNeklJMGFYY1BEM0xJU2pGL09MS0d6MzZhODE1cjhLL2F0VUpYc3hZ?=
 =?utf-8?B?TWhET1htTVJoWHYxa3RqWGxmNlIrcXZnN1dVbG42ek1MSm1oVTFidkJ4cXE3?=
 =?utf-8?B?eGdPektYREtMM09EbjRJU3RRcjVFZUdYR01IZWo3REFhNy9sRG1CQVoxaWZY?=
 =?utf-8?B?L2ZCM3ZXckxQWEF3TmJXSXU0ZXZqZjRiU2hqZzl6UHhqV2l6ZGk1NkN2cUtP?=
 =?utf-8?B?Wlg4Y2I0TUYwUTFJcmZHMlVCck00NElkbUtFeEpkMHdDRCtQUUEyMXh4cFNG?=
 =?utf-8?B?WERLZFZzcEhaclI5QThlWkNVdG83U1IzeE1RMGlCa1o3elhVQ1hnL3ZWS1BO?=
 =?utf-8?B?RTIydjZ1eUowSG9UT2paQ0ZFN21QU3NnaHMwWWxCOWl0RFdDaGI1NUpVVmlM?=
 =?utf-8?B?dDFzS0toZFROeGZyazJVTUdGK0FBYnlZanByeGNZMytiV3lvSFhweWEzeElE?=
 =?utf-8?B?WEFXaERYVHIyVlRVMFdORDl2TmxGRSsvZDBaMTlvdXpBL0lHUHF2YUdkSGp4?=
 =?utf-8?B?NTV5dTlLd2lHYURRR0VKQXZqZEszVlFFOXRXYmdxOEpGVmhYcnBtOTUyUGFT?=
 =?utf-8?B?SytPd3QxTmtsQnlRUThKQnZQcVZyMy9HMGc3Q0wrcUo2dFZWL2YyVGFRek54?=
 =?utf-8?B?Y21KUEdEclRLSk9QZGJCcnQ4WmVnekQ0ZC9aWmNSdFVzOGZkSHMyYkN3ajR6?=
 =?utf-8?B?RmpGSlV2VmhiVVlScndyb2wxajU4Q2xxZi9lYm5iV1E5N2FFeGJUbVlzcHV2?=
 =?utf-8?B?YjlqcXpZTWEzK01lU2tOV29XWDZZbnRUZDN0bm42cnlUekpZMk9mS3paTTl6?=
 =?utf-8?B?K2U1ZGJmN1Y5cWphMitVZ25nM3NGY01VSTM4U01EeG1pd203eEovVFlEdHRP?=
 =?utf-8?B?d3VjaUovTWEwMDVDdFhNTm1UNzRpaXdsODFSU3EzanRSTVNRU0I5a2tpTmxY?=
 =?utf-8?B?VTFaSkZsOHRvTnBFc2xyRHJ4OExZTjZaQ1F3d0QwZTRNMHVBN3BNaUFCWDZo?=
 =?utf-8?B?YklpZlpjZmo0MmljNHNyTWEwcElLT1VJb3ZZbkY5SzJKem1HaEVVVmIxSkov?=
 =?utf-8?B?NGtiUGU1THF6RkhvaFpiV1kvYitGWVJwQ2dpUlMrQmFOdFVYcEFVd2ZsSnFG?=
 =?utf-8?B?Zm1YV3RsUVpTMitqVUFCOEJvRnQrcTVra0oyL2YwdjBreWZkRHFPS1BnZTlu?=
 =?utf-8?B?TGp5UEhDb3UxNTdKR1RndWJiczN6ZlJBcklWK2d0ZUhWK0RnN2FqaTU5ZGUz?=
 =?utf-8?B?LzMyc3ZORzZ5MnpKUFE5TDlTeEJUbkVoQW0ycjJrTzJZSTRIRDQ4UjN0S1RT?=
 =?utf-8?B?b3lrNnZTdHc3UHlxY1lmN3VsWHhQTy90NEtRdzVGeHh6M1RwZUxFaUVaZm9p?=
 =?utf-8?B?d29KaWEwb0ltS09kVjhyalVsMU04QkxxVzhRY3VjRkJ6cnZFL294dEszSUZs?=
 =?utf-8?B?TWZod1BMRmdMTHBaMG1JcFMyOXArbG9rcDBrOVFGcjI4b3ZzSXZoSlRaNStq?=
 =?utf-8?B?R0JraE9kOXFySFdId0s0MEE4SEF1ZHFxRDFqRXNMaUpSMjJxSTgvbklDanZK?=
 =?utf-8?Q?DXgh9pvxBA+P0wjHrYTszToTejIKZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(376014)(36860700013)(35042699022)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:28:29.8254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c11e61d-3132-41c7-2c37-08dd5db69f88
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8745

On 1/21/25 13:01, Leo Yan wrote:
>>   	local64_set(&hwc->period_left, hwc->sample_period);
>>   
>> +	if (attr->alt_sample_period) {
>> +		hwc->sample_period = attr->alt_sample_period;
>> +		hwc->using_alt_sample_period = true;
>> +	}
> 
> My understanding it sets a short sample window for the first period.
> Would it initialize the `hwc->period_left` with the updated sample
> period?
> 

It sets the long period first: hwc->period_left is used to program the 
PMU when setting up the event, and hwc->sample_period is queued up as 
the next period to switch to.

>> +
>> +	/*
>> +	 * alt_sample_period cannot be used with freq
>> +	 */
>> +	if (attr->freq && attr->alt_sample_period)
>> +		goto err_ns;
>> +
> 
> It is good to validate parameters first. So move the checking before
> the adjustment for the alt sample period.
> 

Ack. Done.

>>   	/*
>>   	 * We do not support PERF_SAMPLE_READ on inherited events unless
>>   	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
>> @@ -12763,9 +12788,19 @@ SYSCALL_DEFINE5(perf_event_open,
>>   	if (attr.freq) {
>>   		if (attr.sample_freq > sysctl_perf_event_sample_rate)
>>   			return -EINVAL;
>> +		if (attr.alt_sample_period)
>> +			return -EINVAL;
>>   	} else {
>>   		if (attr.sample_period & (1ULL << 63))
>>   			return -EINVAL;
>> +		if (attr.alt_sample_period) {
>> +			if (!attr.sample_period)
>> +				return -EINVAL;
>> +			if (attr.alt_sample_period & (1ULL << 63))
>> +				return -EINVAL;
>> +			if (attr.alt_sample_period == attr.sample_period)
>> +				attr.alt_sample_period = 0;
> 
> In theory, the attr.alt_sample_period should be less than
> attr.sample_period, right?
> 

Added some validation for this.

