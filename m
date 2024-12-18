Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65519DF5B;
	Wed, 18 Dec 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734521179; cv=fail; b=cjnlwfNA66SftFIm90Hy1ZKnbJWGCH1TGraUIpdE0ux3GSUowrHfmUNK0LKjEif7D/vhd3vLDxC8HtUqNOB0v34TJk/SBXPpMUvAnhmmZ0mLD1l4vEMbOLSJCE/xclB0EychvTL4IP9viY+MCaTkWT5KzG+9drRMJooDVQkDC38=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734521179; c=relaxed/simple;
	bh=DMLDFUoWKWsyawqOBISgC/lO37qcWzpz+QhDrGeGhgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=En/AbknEBcRWr66P4CXN7SiauBLbPv60R7QXU0aJhlxlkcIfci76QcyHaEYRjNuWlHKRQj/eaRPZ4lHqgsuxfim6mM683FxKd52BKV21JOoe+b/8JTrXWpmEMcwmuDXp/BbZckiC6ZEvXGDmQUQCD//NMBztFSx7ZliZSzn1xIc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iJUYAz2z; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iJUYAz2z; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iJUYAz2z";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iJUYAz2z"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=C5u2TU0zc4gCQWs8QNgGM1mwQ8FuPvwP+7tWQaoRDQvKWupoudSEnd4X0A+L5nKV2T3fc9+xHP/enSmkSArxn7QV0VeweyDJkT2R1jyjzA/ABZ0XqkRu9IJaS1jKUmITATC7/DhqEgxpj8xJg0VYr0A/URHhTryjD+ZwwGQ6qsAglNsbV+uCJibNVXiYbYxoEfSQGw8+sMxljp0PaJwCulkDkXnmBUcg3YhRAx7+LxOU97FfWmNKOxjGgm0cQehQ42tTyYn3XcNyUl8ffxfO7ZNIrL+oqJHxMCRz39Fbjm7aH+u+jyuc5wYKz5VpP5DnnYk3Z22O45ThBistR7tXQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBANqjqtrJIdPMUPccXjkJxj4305wEi6d8WTDpVNOY4=;
 b=O40C9NnVm8f7MJILmyLxF8/Zrb+k6TE9AAWdi6FflpIt1dCyOiT62tl2enAyc3G+GLfblXYsm39AOyQCD52wd1HZ4Lfdk0CcYSkhrtT5PZPJWvEotBJCYzT+aUt7ZX7DiiZsot+bGdYOhCHpH+fJW47PApQYVzwcTTWYGv0TOEVsKMn9URTVbKCiXVEX49r+LwVjP3lj4QsAhlsLJTJ5xTkQ0WzvAiF5Lkuy9CjWQvr/sWPc5U5yC6TaDEJ1yPgMrKMKaXQ+uEphn8Gnk2edTMdvqb7xjslWvu9oKxwUQOhRGmQA4zjs+aTQ/5JLn367RIrZnb2MdKa/dhUCmoHhKw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBANqjqtrJIdPMUPccXjkJxj4305wEi6d8WTDpVNOY4=;
 b=iJUYAz2zCV9ZVh16Ar7VK3+u5Z0Cr2LvYJErj4eebIn/IHvvioDYRpI2mETtMLKywhayvQZ1XRSt04zB7t+vVfMSWZmfCcfWs0NdvKp+IBDraTxsX/EnthTKtbIev2BufEZEH09hVoEusiugsHsB1pKvX7ei8bE4B3r4nGVSFcA=
Received: from DB9PR02CA0012.eurprd02.prod.outlook.com (2603:10a6:10:1d9::17)
 by GV1PR08MB7705.eurprd08.prod.outlook.com (2603:10a6:150:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 11:26:10 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::c1) by DB9PR02CA0012.outlook.office365.com
 (2603:10a6:10:1d9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 11:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Wed, 18 Dec 2024 11:26:09 +0000
Received: ("Tessian outbound 42d62cca2da1:v528"); Wed, 18 Dec 2024 11:26:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c30a8939aed1f64d
X-TessianGatewayMetadata: 2NAPJ5KpM9TM3qi+2q2jwaWM8Fs41C89FeXA0ObvjlTPzbCRadHkO6DOlypGRqCw59tMXN3G/uhxRkiFYX01GlsjtUTm6sw/hrhQuf/JFVs4vry552b7VPzGyWAHhGMJqwtKFNVvtOJCkRt6T5id3A==
X-CR-MTA-TID: 64aa7808
Received: from Le5850f45a68e.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1518D34F-7286-4B57-9AB3-AAB94769041C.1;
	Wed, 18 Dec 2024 11:25:59 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le5850f45a68e.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 18 Dec 2024 11:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJ+IWGF2j+ZvdDEwra8q9TEkCG2eLYHvnk376PXPLPKLdyiQp2geeAc3WFGHs5hZoW6mBsxav+BepXC495t+OJz7J8wmmwqxfM/rHdMEVGlDmGyPteQBRDDKnR3bubBwMys1rEuhFtfSbz7EqRdIHTWQtpymVVtIHIREDJuFGW0zA4sxOmS1nKzmfpWkzuDKPZOboTg4Y1LXIQnc0m/FoXRu8WSvpnxrGtvb61Dd2c2/RdclInRaSU8BQrVujuYaBZUFSfVUQbagbTFeMhRRe5f/P0sg5SoIFy1DKlQpuWi8q0c7pC8tlxIdDGR2Vv+zINed/zLN4vXboCldqFydrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBANqjqtrJIdPMUPccXjkJxj4305wEi6d8WTDpVNOY4=;
 b=VOfvAQTt1SiIXcPJQIaPGVij2ehRxKH02KMIM88syo5Gl+TwZkqEHSU+HPhGOKTmqsLp4To6oMcnARQNKZh8s6QZ06lxwW00za735/3zTumnzfQH2+wqKOD/JyvBe1X0b1r/abN7iGFNUMLcSMOx7mTKUP9bA6ZPMwoXaWzdaT0vLg5x760lnbxGHfc1CHl0bVuntkWcZZTRj/1GMvpQ56x08FNsfW1upSdaOBS77hcrnFvquCqLDqvFOQKUBNUl4K7mk08RhHroqJHY8VcSK5kthY/ojvnn8ciLRsRUR7MPOxXhKOTMxes0TlTKR0Vwr7R0+90zJbE/mHJKCo0zOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBANqjqtrJIdPMUPccXjkJxj4305wEi6d8WTDpVNOY4=;
 b=iJUYAz2zCV9ZVh16Ar7VK3+u5Z0Cr2LvYJErj4eebIn/IHvvioDYRpI2mETtMLKywhayvQZ1XRSt04zB7t+vVfMSWZmfCcfWs0NdvKp+IBDraTxsX/EnthTKtbIev2BufEZEH09hVoEusiugsHsB1pKvX7ei8bE4B3r4nGVSFcA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV2PR08MB9950.eurprd08.prod.outlook.com
 (2603:10a6:150:b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 11:25:56 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 11:25:56 +0000
Date: Wed, 18 Dec 2024 11:25:54 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, amhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	nd@arm.com
Subject: Re: [PATCH 1/1] events/core: fix error run/enable ratio display
Message-ID: <Z2KxQmmoCWyA7raR@e129823.arm.com>
References: <20241218084656.609764-1-yeoreum.yun@arm.com>
 <20241218104255.GE2484@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218104255.GE2484@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO6P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::11) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV2PR08MB9950:EE_|DB1PEPF00050A00:EE_|GV1PR08MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: c078e79e-33c0-405f-9181-08dd1f56c58b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?AmpBgkd2lrTO0pLvjco82MYZ1snfj47OpVs6zVs4ymFU2SpyvVfKkwc7/TKH?=
 =?us-ascii?Q?UDVqZ+mEP2/Sg+d8hGHddKhNKED47HVgmH5KgTsG21/9OSPRU8Y+lmKvx2dn?=
 =?us-ascii?Q?mxE6zWnsav3TkKC0cgGTmc5Eg1AG3Y8PB1n36shNhXGj0HaNxUasXCfNjVyN?=
 =?us-ascii?Q?Y6EY3hJNHmnoqdKBYk18dwip0CCKdaKomOnRr0xZk203ReqGPubsBlnOyhQt?=
 =?us-ascii?Q?xbaxvctmYLFSZ1VFY2SEfepx1oUKnAQmVplaIZloIJesa0aciEqBTFJ0Nv9N?=
 =?us-ascii?Q?sZEf+sRnGLAIpF6PeKcs+NLhnSZDJB4RHNKKxNVNoxFKe9n5TBUKl6kjdj/s?=
 =?us-ascii?Q?v1hP5JcZkKpLHrRZ38BBuMOBF1Uox/Gx2G4ESiyFxPbPcs1YWRe79/qg1GUx?=
 =?us-ascii?Q?vdEDDjyoXVqaf1ebAmD0PrGKXH3sq5tRqJNUw4cz+h9+plap+0Wum94Fk6FT?=
 =?us-ascii?Q?RlHA3+1PCFt1+iuwoP0nqdzu/7Z1NtRG9iEkHjN0dtJBxv9c990RF3x2o9D8?=
 =?us-ascii?Q?NNg27RJQZKbda4EP1g/NxTqaZaPVs3qwvDpsuX+YFw4CNS2QoQsIwDqvAr34?=
 =?us-ascii?Q?rhPMYdY5D33DIZYT6qB9toNdyTb3qN88pGAAEJNYgU54+9O0+kKpZh1UeOR2?=
 =?us-ascii?Q?+cWw/9XYJlQiNvlcEQJwyupCvVUdxDZ8iqZvloBnah1+hFMwb40z4w81rpEF?=
 =?us-ascii?Q?MJ5VWd6LEfx9tncS8+X6YmlQ9NI23ZG6jASC/v2lpR4hZNw5ouc2wNmjnhxH?=
 =?us-ascii?Q?d0fVYpxN+D/iiYu3kjonuxgRwSPR4nsNZNRSyCY78sItFbk6p5ythnGSXyRV?=
 =?us-ascii?Q?VagHsfQXfoe8h6p3qmglPu/ZeS+89EMz2iZjOEDWKWiJbxVH98X31XZhOe85?=
 =?us-ascii?Q?wAuKQzXvbpH5X5TjC5nl/GjCHzpMff/gfT4AhzQhN9oMpFNpXHuzcGoQ/r1m?=
 =?us-ascii?Q?vArmZ6s443h3Lnc/FmNJwm+4+F5wjMC9rRJaNzVJMxSiLk9JN3Oz4ru3FWOo?=
 =?us-ascii?Q?5IcXhA8XMEXvsh315B0EhSq92nwDfXX63PIDzTo6IJDXwZPfjd1Gb4GNyv/K?=
 =?us-ascii?Q?pOs+XFdvBPjl3y7d/qj3u0DqA9e4sWAr1KjK0zdArrnZeGbW7sfoIYO7AJY0?=
 =?us-ascii?Q?p+OUKiJTDSZcWM9mDS8Ic4NQHy9GGIR2ZngzDuUTTqPLFCC6uY4qxWUXPXhP?=
 =?us-ascii?Q?8GQ3HAN6bb/fAshCAVZAVRVp3bQ70ZFcWZ3IjqoessyGD0GAG/ty0dz6kAEp?=
 =?us-ascii?Q?lbFVZmeD7x7ZIM+rA6MQMkr56Kfe02FXaV9eqVYw4M5E/nidyM+z6jXrhMfO?=
 =?us-ascii?Q?sUbCbldl7v1Htriv8YVldy6Ez6cGf3Te04FUJMWY+89tq1mkShUPhDk+ZD08?=
 =?us-ascii?Q?Ui2EErDX+LG9liopQfz2ZjchTgUX?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9950
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ee752967-5aaf-4081-459e-08dd1f56bd95
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|14060799003|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXIP+8qcOgYcxb3xiAH6F8yUWXy0uMRzYuSYkilbikdizeKpeIxrzHmTzpYq?=
 =?us-ascii?Q?b9oYR4Nsntd+iqLja0iiPWwE/2y/WH3xEBTFNWga2L9j+WcBv64jsyUTV2Hp?=
 =?us-ascii?Q?RqwR57EZN89Vm3XIGHCcpTtz2ZL2XUELHP6hkcg80OOFjQ/7Gte4SBce4t62?=
 =?us-ascii?Q?cT5plN3+XDErEno6wW5TyVINS+LS0lFJka3Dnc6RdXaZ+MePKTb38U8Ip3TM?=
 =?us-ascii?Q?DgSe6q9VFnQdQGwGMBIRWl8G8xBwmCfXpW0p+c4jsaEuy1oiN65q4V8nvP/K?=
 =?us-ascii?Q?QCwUomXsYW2tH7lrSnH4+08O6kvJGf/Zp/qTNzcOfLIgM+sLfyKo+FP0zYJ+?=
 =?us-ascii?Q?wiC2MkKj9vuveNSFzweLNFEj3Bky6IcGozigvWQbBqTLXNLVvaU5gqCQEwlN?=
 =?us-ascii?Q?I61+g8+UMXDt8WAH6c3V0c+k7SReOyc9cr2J0/eLJCGh6tlS7nJmRKQ10IB6?=
 =?us-ascii?Q?25jCt8rtTwMskoYFXthQF2S/ymLG8TK6JzL+rwt0IFEdSrrjfmUBDs+Z4CtM?=
 =?us-ascii?Q?gdH0naFwMZ7e9OQGbDnJWGcDHs7YYq62Aynl0CKVquy2YnpVbUQWNpsd5mFh?=
 =?us-ascii?Q?RHoCPRz5vlovX6Hk/B28O/00h/UmoHeZeCuPu5TegUBAmiqWFBfVc0hguIt0?=
 =?us-ascii?Q?QrFbMKZP4J1Orb/K5r0Gs7itJ+bbzo3Cua6yGNvvJddrTIUtXIuRwADWtJVA?=
 =?us-ascii?Q?0LD/TRuanrtfF9IUJvWWMqUUB5UdF/UbAJFkCq7jgkzJUuPfDn0hlP89Wrk+?=
 =?us-ascii?Q?A9Iq8C9+I5BHIIUEsclrAvRMM8vCbk3pC4uiAD1CN/wH41WbhxjnVd11mLF6?=
 =?us-ascii?Q?Zk1vn9MHp4csGhpYY97j3+9Dkj8XhGibZtOw4484SfgM/Tho7UNC9Nf4C8Cq?=
 =?us-ascii?Q?3D1aEQr7+dJeCr4W7QPffFsdKuhwNm7hM+zEMIt1Xqg3p0MR6Nbu5nbPhX2B?=
 =?us-ascii?Q?mhCQu823WZO6h8LHdq48D/zE8uJf7a/kaH54RX9KQ4aZCDqjSEHDHjeG7GRl?=
 =?us-ascii?Q?Ipl/qo32FPk7/Ld/GXJEDGDcMcuqe9FIhqZvwdzYbhVgkG6Hjs+CycbRq6nl?=
 =?us-ascii?Q?eBqGuizK3hTZPTUSGGtNV8uFAGe2sGGt6dl4gxoPjs2bvLV/J+qCZZlJ5Yhy?=
 =?us-ascii?Q?HhmRbNNxLUR3HawFExY1MdnxvKKMrePtvaAvmjdAh07fVb43Y2rv27huL3W/?=
 =?us-ascii?Q?aW06Wq+ZptDG38xsWGSYaV2B5w5ZMDVNIstbdT8cv7Hyt8qmI1EXruYf9tq0?=
 =?us-ascii?Q?zw/RhMW26GUb2hcVja4kh/9TvO3nIgKf5FA55wXydvrj2I78+bG5QdUxbY2W?=
 =?us-ascii?Q?gOWJyXZ6QyrsQz7LKRVrlFUDzMyOfkJGcb7dyfyj1iN//VS76avtodMGONOB?=
 =?us-ascii?Q?CskUdOirfYs6K4RWnEZoqQKdOGLPst/LKISK4QXbmxImQvHLgblwC8Fm9MwL?=
 =?us-ascii?Q?2TvDhyuB4gF+14SThVFxaDzxsx9HbstnMiIFrrSM0BIINwRLHtL66ymXIKT4?=
 =?us-ascii?Q?JwjY7GMhAKth484=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(14060799003)(82310400026)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 11:26:09.8385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c078e79e-33c0-405f-9181-08dd1f56c58b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7705

Hi Peter.

>
> git log --oneline kernel/events/core.c
>
> Compare result with your subject.
>
> On Wed, Dec 18, 2024 at 08:46:56AM +0000, Yeoreum Yun wrote:
> > when runs below command (with core pmu) sometime perf prints error
> > ratio for each perf.
> >
> > sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> > ...
> > armv8_pmuv3_0/event=0x08/: -1: 1081702126 2289429840 2174835740
> > armv8_pmuv3_1/event=0x08/: -1: 794080238 1950025700 847648440
> > armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
> > armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
> >
> >  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> >
> >      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
> >      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
>
> At this point I've no idea what the error is. You start by saying there
> is an error, but then give no clue.

The error what I want to point is that the ratio print (94.99% and
43.47%).

Since each pmu is for core and when with above command, these event
belong to same each task context, the total enable time should be the
same. (which is described in second columns among three data.)
But
   armv8_pmuv3_0/event=0x08/: 2289429840
   armv8_pmuv3_1/event=0x08/: 1950025700

That means there is missing count for total_enable_time which saved in
each event.

>
> > This happens because of missing total_enable_time of inactivate event.
> > it's enabled time doesn't update at the event_sched_out() because state
> > isn't PERF_EVENT_STATE_ACTIVE but PERF_EVENT_STATE_INACTIVE.
>
> time tracking doesn't happen at sched calls -- you'll find a grand total
> of 0 perf_event_update_time() calls in them.
>
> Also, things like group_sched_out() don't even call into
> event_sched_out() when !ACTIVE.
>
> So why is event_sched_out() the right place to change here?
>

In below case, the last time is update at __perf_remove_from_context()
which calls event_sched_out(). (e0, e1 is child event).
and total_enable_time is tracked per each event. So I think it is right
place to change.
But, for exact tracking, I think group_sched_out() should allow when !ACTIVE
to update event time.

> Also, I've still no clue under what condition all this is supposed to
> have happened :/
>
> > For example, Suppose there're two events:
> >     e0: with pmu0 which supports only cpu0
> >     e1: with pmu1 which supports only cpu1.
> > then
> >
> >                CPU0                  CPU1                     CPU0
> >           |  in | out |       | in | out     |       | in      | out (exit)   |
> > ------------------------------------------------------------------------------
> > ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
> > ------------------------------------------------------------------------------
> > e0->ena   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t2 + t3 |
> > ------------------------------------------------------------------------------
> > e0->run   |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t3      |
> > ------------------------------------------------------------------------------
> > e1->ena   |  0  | 0   |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2      |
> > ------------------------------------------------------------------------------
> > e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
> > ------------------------------------------------------------------------------
> >
> > at the CPU0, state of e1 is PERF_EVENT_STATE_INACTIVE since it doesn't
> > support on CPU0. So when event_sched_out() it failed to update its
> > total_enable_time and it makes error print of run/ena ratio.
>
> Sorry, I have no idea what you're saying. I can't relate the table to
> the text in any meaningful way.

Sorry to lack of explain.

Please see the first CPU0,
at first ctx_sched_in(), ctx->time is 0.
and e0 is ACTIVE and e1 is changed ACTIVE but to !ACTIVE because of add
failure. and at the ctx_sched_out(), ctx->time is updated with running
time with t1. and e0->ena update with t1 but e1->ena is not updated
becuase it is !ACTIVE.
so, first out column describe this situation.

next, when this task->ctx runs on CPU1
at ctx_sched_in(), e0->ena is the same  and it become ACTIVE to !ACTIVE
and e1->ena is updated with t1 on setting state ACTIVE.
at ctx_sched_out(), e0->ena doesn't change because its state !ACTIVE
and e1->ena change with t1 + t2 with runtime with t2.

and last, when this task->ctx runs again CPU0
at ctx_sched_in(), e0->ena is update with t1 + t2 while it becomes ACTIVE.
but e1->ena is the same to t1 + t2.
and when task become exit, e0->ena is updated with t1 + t2 + t3.
But, e1->ena is t1 + t2 because It's !ACTIVE.
So, the e1->ena time is missing for "t3" at the exit time
and it prints wrong ratio value.

this patch by updating enable_time on the event_sched_out() is called while
perf_event_exit_event() at exit, it fixes above case.
But, I think it also need to group_scehd_out() should allow for !ACTIVE
to update event's enable time properly.


Thanks.
