Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E236215F42;
	Thu,  7 Nov 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995704; cv=fail; b=uobk0IVb7mj2524zq/ztQxFmS+Y4fx9s1scw806dUprA0GbhVDN88P7ybO2W3URcAcpuIz/5c0jGxQAx4hrcy5s+edWgnfInQtTolWpW2P2n7GxeD4XniPlnn7qjoAAHZNtT71X2KA0dhYm8K9tSIPd+BdSGDA6LXp7i2bhKI5Y=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995704; c=relaxed/simple;
	bh=tip53np4mlHyBgV9vtihq7Y+wJBY81XtrJr8iUhBEI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+LvwN0NUgFNPg7NRH1lxvu7vLadJwOqzS9eD7aYIwtwIzalkECU39MN+OFR9UmeXnt47s1vN+rjPA3aSE7Aks6PjqBWO7FmlKCVpXljVflDC94xqBnp2cMzTt+BpDbrXSPuANPSt4a4LEA1wd0tTIyTLXG0HQJjo6BIeuNo3h4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GIetak0D; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GIetak0D; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GIetak0D";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GIetak0D"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QyJOPoCpql01cnelr+ac4NHW8WcRUV5ZslW7abegpWxgzZGmY9BPhltVKMi8/B4jDI1D7j6zav8NTY8quhpeHuwrStn1POo4F8YlNIKzcGTZvEZSxrYwbi/HQ5U211VFL5WP2oS47FGyVBKEmvTQq0bNzmzaShnuPu+uG/EV0/KTUg9PFSo9f4NrJuyrVkdOdlqbE5lFQB/X4PUrt+BMXDVSDq/B1XBk2j2qfshbpViitrPvm1FoMFa9UwqcIW/9TJHfv5MdesqPjf/xp2leSeeo6OFg31xGAvCgltBBVAbVtOAQjJp7CtB8ZwiRFhe1fmmxBMvvi6eb2yBDYrb8kQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTitNezrnDKbgE4kBBdKx2gTtn2o1x8IwApXxf94/gk=;
 b=tJgxY/hR6CeyBQRVV9O29avRXoNzh6ojIk+4XbQXtA6tSI+2KmM+FQDdsV5dz3y6uo+EAwU3UY/j5wlrfFx6UutY+pqmCOYRDDgj9URE5DBewR87Tyvg7Vrufrc4GKibHmvimiosL4RuG1s1g+qsUy8Ff1936BOmmPgu9gpCYw9BSVB9POEdI6KyRPjMrWqTxxGhb2x0PIXx5oHSNzneuqJSoH1BYBx/rGN7CMfcDnhzpZSEBgLSYvUO4faL/VTdIK11mZV1CNNa0qclC3FEt9zG94IDrnDdN+mS/lB4iMolzJwDjMw5ua8ql6tEL0+CdvpFGnVk3dpD4WicyJP6Pw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTitNezrnDKbgE4kBBdKx2gTtn2o1x8IwApXxf94/gk=;
 b=GIetak0DFGL4s5lrIHEdhqQ2oqS5QQpf6WAjdnBJkRcLgp2vmnDe4vTQDB4IWa8FxAhpw6ZR2XvlnNNeU6xnXa0pL09HfxU2r89Kh1oZI+8tZUFkQyGIqNyGp74b5BWKSpI0HMf00fZtB3k6EbzgM/nTPTOm9UI/hgrJOQSvOv4=
Received: from AS4PR09CA0021.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::19)
 by AS2PR08MB9320.eurprd08.prod.outlook.com (2603:10a6:20b:598::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 16:08:14 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::71) by AS4PR09CA0021.outlook.office365.com
 (2603:10a6:20b:5d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 16:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Thu, 7 Nov 2024 16:08:14 +0000
Received: ("Tessian outbound 373849c2df5a:v490"); Thu, 07 Nov 2024 16:08:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 667e1c8edd42b742
X-TessianGatewayMetadata: EK41TypnulX21YfZgfSD2ZsOnd+9H62c03T5EixXfD4zsHHccOw2Ewj+ENOSRXKBTWL2cpkxiVuEsAD1W2T1t1RIer9IwrNt1vN928t32WXnpbn6C0qjljJY8C9Wd4NydvT7O70mbrqGQGppcvvmEtFpUzv89bqSwnBrmXR4Ogc=
X-CR-MTA-TID: 64aa7808
Received: from Ld9aed62b4560.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A8BD3BC4-F6FA-43B3-B59F-6D7AC9E7A79C.1;
	Thu, 07 Nov 2024 16:08:07 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld9aed62b4560.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 07 Nov 2024 16:08:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO+0xw+1iHYmxHhVIVHfMOLSFzgBe5Ap9duYY/9B/2ixTbU4eEqOJGFEg+uq8XPbQJuxu2BBYFy2DSvTYQ4R26cLZeZaZ92Dj8NKnCPqPtN+VGmT/XbBKUFhW1rDWLKERn0L72KDwxFJjpiX46x+KfOFQoN3o+KgN5ytCOQujrx37H8Mx9iSS9EiRZRea2jbgO1wjo8SO/TfMK9X7s2OnLLL229EdSzNDPqqAbjA9j34nQM9aGqlJMBdF+yCF2q5tpc52VyTFCwIV+24eCqGMGngRT7M0AyQ8D/vvI9NldEWtf00RgfvNI9YJqJah4K4f40nAV4676IUNip148mp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTitNezrnDKbgE4kBBdKx2gTtn2o1x8IwApXxf94/gk=;
 b=OvsS6nbNa9xlNCr9C6jBrwUdbY1SCjs9dwudsRxTK3N9n/yDr4ZIMt/D8fgPupq/+7Knf08OMqonLz25Esll6SAma0v39gv1bia7JMNuyZqnpZPEhjOfxWob7pvSFATmuubDQxyugYqsQiKOW/Shc+55v2Mn11p9dTNyZCZ2mHi6m5uXve7ioOs2Dtl8G/PAfYu+h0kzS/El7+cUgkSQNOo5wvdbuKrIyawSFSF2KW3n1d/5PZKNo6UJHon8CEGaViWwd7fz3Ooh9jPTxHqtORIfJdN7eQAdI/P4dyeFvYTkdo9tK47icwz/eqeIxGjFQjvEd70Uwf/z6hnQ/EfPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTitNezrnDKbgE4kBBdKx2gTtn2o1x8IwApXxf94/gk=;
 b=GIetak0DFGL4s5lrIHEdhqQ2oqS5QQpf6WAjdnBJkRcLgp2vmnDe4vTQDB4IWa8FxAhpw6ZR2XvlnNNeU6xnXa0pL09HfxU2r89Kh1oZI+8tZUFkQyGIqNyGp74b5BWKSpI0HMf00fZtB3k6EbzgM/nTPTOm9UI/hgrJOQSvOv4=
Received: from AM0PR03CA0025.eurprd03.prod.outlook.com (2603:10a6:208:14::38)
 by DB9PR08MB9539.eurprd08.prod.outlook.com (2603:10a6:10:453::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:08:00 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:208:14:cafe::f6) by AM0PR03CA0025.outlook.office365.com
 (2603:10a6:208:14::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 16:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 16:08:00 +0000
Received: from AZ-NEU-EX05.Arm.com (10.240.25.133) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:41 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:39 +0000
Received: from e132406.cambridge.arm.com (10.2.3.22) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 16:07:39 +0000
From: Deepak Surti <deepak.surti@arm.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>
CC: <deepak.surti@arm.com>, <mark.barnett@arm.com>, <ben.gainey@arm.com>,
	<ak@linux.intel.com>, <will@kernel.org>, <james.clark@arm.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 1/4] perf: Allow periodic events to alternate between two sample periods
Date: Thu, 7 Nov 2024 16:07:18 +0000
Message-ID: <20241107160721.1401614-2-deepak.surti@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107160721.1401614-1-deepak.surti@arm.com>
References: <20241107160721.1401614-1-deepak.surti@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS0EPF0000019C:EE_|DB9PR08MB9539:EE_|AMS1EPF0000003F:EE_|AS2PR08MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: 223b38fc-f60e-493d-ed62-08dcff46627b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?6nrDMyYsVEdicetwPtPzqi5yyVJpMIDG925JUHWuPznpMyuYVoejACpxQ6ph?=
 =?us-ascii?Q?D9u0v/mtW4wtu1VARX7cbs9A+/MDL/o/hq5kiurCm9VUHxT2c2B6IakF3kDW?=
 =?us-ascii?Q?goi1Vo1S0J9b2cRkgfeArexTUtLihKyNCJfNPkG7cUPGDwGV/HTO2/7CSGU6?=
 =?us-ascii?Q?UmF9/q5Hw4+yq/r+K5Y3YqERL73ASwzSH8Td/IG25VN7uoddkkVb+4sZMYyo?=
 =?us-ascii?Q?hPd1c85ROy2PSyuMz9y0YFCdM6Lqf+P9b8b0WmKLqZZpWX3lS8jvJeRQ8jc5?=
 =?us-ascii?Q?onRsyB0w5Ic/ThmZpl3WdRHui9Aj9Nne28G2TcAKsRLZQNWfUcZo69YJxo1N?=
 =?us-ascii?Q?J1peInP2BDO23YXAGKtMDpDtTX1sm+ylRcU9uLIvDAWdY6Z6yI1ViVFvDd7J?=
 =?us-ascii?Q?yexJpnA92JFqmYDflatoEtJ5myQrrk2KJftaegqFdMvyUdnlk5DGjdrz36pe?=
 =?us-ascii?Q?37tz3iSdHgJXVmdtvjjBT4ukVUajQvJgiChIEooAKa+jwO2mXmO/HQ3F9pwJ?=
 =?us-ascii?Q?iwHKP9qYsaSbKqkiNhe4X6LfYXguZoS51gp7a14Qz8ZVV+KPRkovsHFqsrws?=
 =?us-ascii?Q?m8K6onu190bkdEJEapEDbeIwK5wm7ZuZgCyEFnY6AIFCN4VMx50uAabPafCm?=
 =?us-ascii?Q?tZXNXRHC77QUWa1n5HEKSokILjYPeIZl3OuKtXN5fsXa26AhF4CgYNPl2P4B?=
 =?us-ascii?Q?iuk9iAKYYQQq21EQCxd3PmS9VTPxzhDt3hlklI/QhopgXkr4SoJDYN2KkQVu?=
 =?us-ascii?Q?EEmQstMnP2YhBu6WGkMQZd0m8cOBt2+OkO0jNN7PE97RXL3ZZ6YCiCpx6PIF?=
 =?us-ascii?Q?VnA2GeI4fifWhdlw+AgBgIldXhweWQFAhFkEskX9BELwDZLmT/bGz7e4KVqI?=
 =?us-ascii?Q?FP+bU9ONsAlcEYAAMjwR91Kxu6vRHWXiwI2e2klDBx7bzzsczKCRYbP2Yqgn?=
 =?us-ascii?Q?y1RM4Qd96ANmSubWWtx/Moi64nf6EYNRqfsZlwDsHCUh2BzH3zBIuQUQ5TlW?=
 =?us-ascii?Q?o5Ks7Pc81+qKdx59wnYnBcuaddJupa6bDeHnkOXCCMXR7CweqZo0JYFi1ijZ?=
 =?us-ascii?Q?ZIOm1/GtE3IDC3CL3likA2M2zJANkarzM3eIyoP+7BjQGhVVUc/9MpqXNX0x?=
 =?us-ascii?Q?J8ApT0o54ePigSdNCR9jVZYkRR0sO7+Xe6Frp1tlu8HulOuM59sAsESRIWfr?=
 =?us-ascii?Q?lgZ7dme7j+fyvPDmoJf+KraG4NMjDVSTslkLVgVJQD9i8BUr4sKhQRfZxtVf?=
 =?us-ascii?Q?Vy8tnim+9Jg7Xu4yx9xXo++4tyz6aqca6a/RTHo8FIagCNUk9uoIQnQnNNrw?=
 =?us-ascii?Q?UsWylsulBGj+3t+ys4DvjdvYmZOANe349xxvRHO0gQkyJrN4SUatCRhgXoIw?=
 =?us-ascii?Q?T9VKPPrjMTLxHFITBVWXWH6fx02PYCctCXFweH3p6s2TWhXf4Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9539
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:208:14::38];domain=AM0PR03CA0025.eurprd03.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	545309ad-36af-4957-2982-08dcff4659f6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2pe6hNJijeB/iYsp6jbtSrxK+G1i5lJJu0RFORctNoMr8ZLRsokNx87+fGZ2?=
 =?us-ascii?Q?TkwzWZKOITfrMA1gE7iZb1yO3t6y5jUuzk6kXUgOX6YYD1MG9CQBq07Hkrhe?=
 =?us-ascii?Q?E6PFemwe1rVOjuTHlv2xSGTDAs4iAGJe8yHY6jOgF66zHYQcrOvgomck0C2d?=
 =?us-ascii?Q?YvAufBvzOzWKihpK1yoXPlPGqdWW6xAsee84CO1FrODdCOUqQzwyXWF+H+RQ?=
 =?us-ascii?Q?ePbAaFyig3BGRyPmlVW+4Hui6Y7n0aZpHSr3lAGVOLz1Sbd7xVCbweWGvb0h?=
 =?us-ascii?Q?XXnqjdrfH4ru2OExzBfZqEgcNQhd6DpB+0QeeJT0zH2nAvEl3/ISEoqkUiPl?=
 =?us-ascii?Q?oaWyGDc5pU7U83vuHOE2lADtNl3lHSb7ZBwQy71GjsaX22HzwKFCeDkOR+Iu?=
 =?us-ascii?Q?vZNhSLDeH/O8zevqvcYu7UDRHKDoLPkCKZ5n5DWQeBws+XbffJDjJvIZ8Q0B?=
 =?us-ascii?Q?NkExa64qsa8w3No8j4VVPpW+cMbzBDKiSFI1+TT5xd1BnLmUqmV2Wpk7qH2Z?=
 =?us-ascii?Q?0EycTs7cnqDWPPE6o+4CgWymVLhCg/KXqsPLRyRxHjPtQjEE0vnPOjeXJ8GR?=
 =?us-ascii?Q?N24fvNnWeZ38fd38u0UShR8y1Eghc0zEZNia/iVvBQI9KvqHSOGtbjiJtgiF?=
 =?us-ascii?Q?4r07MpkqLeSlW+or/VUJ9K5ygQR5no4OYll0LfeOuWbTeJkpWATNj779jQah?=
 =?us-ascii?Q?L+WrmYBHZOZQ1kBiXsig4wdKAeRpCTkhXkIFuRd8Mltii+SG9gPNW7vWvx2x?=
 =?us-ascii?Q?Jxmei1xaRA/d2/f8c8ZqbjVEtqxGsR6NvgrSKcaNwnJ2Ylc/WlK6y1FQvkis?=
 =?us-ascii?Q?XaoOmsj1pUwOdaigr1PjgWlrUq7JPjP/0OHn1cC50LliR2ESuwBcHrCQPdmU?=
 =?us-ascii?Q?OZj3N7BK5rn3vM1lc+b41Y3GfVF4yHYzXJHw32LKbmICdWbkDyVpHzERp17u?=
 =?us-ascii?Q?1RiwUEcsfB+OW6agDeuuN8nOpbzgBDlDTPMyUR+kSKeplpxlpHXgzYB8jH2G?=
 =?us-ascii?Q?WBEhRVt0OeMXqHIf29x/m/ML0wsjzSQxf5e2T36KzqxtWz+8lo/N2Cfhly6d?=
 =?us-ascii?Q?t5qmFLGfDe1Cw76pLQUuezJGwWJraczt0Z2BrJrv/gniE/OE2urCVJP1msab?=
 =?us-ascii?Q?1iFZ6ppEc0cv5g8gTs4NUUER53v/mNKGMZQ+DY/KJ3J5uQiXTLQ+WyT03J1H?=
 =?us-ascii?Q?jtx9JDQfLfDQfGmUNIhBGzjzaBZGnSAtNbQv4+cmfnVLm0tWmH0HS57b1YYu?=
 =?us-ascii?Q?OcgYTkMYy8EYzF2z37Q3F/KaQ9n0CnFTvyagHw+WnIpQ0Xtw34gsx3oO+K2H?=
 =?us-ascii?Q?a8kJos7LXz63c7eoFyoRs/+Oo3OAbO/jgspKoVvkEtOVoPDy3mthQi9QAdfw?=
 =?us-ascii?Q?/BDYCW4Hu3QsqZwl+dwLa+S3FfAKprbD9IpAHFtJsmUpf0nG/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:08:14.3912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223b38fc-f60e-493d-ed62-08dcff46627b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9320

From: Ben Gainey <ben.gainey@arm.com>

This change modifies perf_event_attr to add a second, alternative
sample period field, and modifies the core perf overflow handling
such that when specified an event will alternate between two sample
periods.

Currently, perf does not provide a  mechanism for decoupling the period
over which counters are counted from the period between samples. This is
problematic for building a tool to measure per-function metrics derived
from a sampled counter group. Ideally such a tool wants a very small
sample window in order to correctly attribute the metrics to a given
function, but prefers a larger sample period that provides representative
coverage without excessive probe effect, triggering throttling, or
generating excessive amounts of data.

By alternating between a long and short sample_period and subsequently
discarding the long samples, tools may decouple the period between
samples that the tool cares about from the window of time over which
interesting counts are collected.

It is expected that typically tools would use this feature with the
cycles or instructions events as an approximation for time, but no
restrictions are applied to which events this can be applied to.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/linux/perf_event.h      |  5 +++++
 include/uapi/linux/perf_event.h |  3 +++
 kernel/events/core.c            | 39 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fb908843f209..9910b3c115d0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -270,6 +270,11 @@ struct hw_perf_event {
 	 */
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
+
+	/*
+	 * Indicates that the alternative_sample_period is used
+	 */
+	bool				using_alternative_sample_period;
 #endif
 };
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4842c36fdf80..bedae424ba36 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: alternative_sample_period */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -522,6 +523,8 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	__u64	alternative_sample_period;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index df27d08a7232..579b04af70a2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4185,6 +4185,8 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	s64 period, sample_period;
 	s64 delta;
 
+	WARN_ON_ONCE(hwc->using_alternative_sample_period);
+
 	period = perf_calculate_period(event, nsec, count);
 
 	delta = (s64)(period - hwc->sample_period);
@@ -9806,6 +9808,7 @@ static int __perf_event_overflow(struct perf_event *event,
 				 int throttle, struct perf_sample_data *data,
 				 struct pt_regs *regs)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
 
@@ -9822,6 +9825,26 @@ static int __perf_event_overflow(struct perf_event *event,
 	    !bpf_overflow_handler(event, data, regs))
 		return ret;
 
+	/*
+	 * Swap the sample period to the alternative period
+	 */
+	if (event->attr.alternative_sample_period) {
+		bool using_alt = hwc->using_alternative_sample_period;
+		u64 sample_period = (using_alt ? event->attr.sample_period
+					       : event->attr.alternative_sample_period);
+
+		hwc->sample_period = sample_period;
+		hwc->using_alternative_sample_period = !using_alt;
+
+		if (local64_read(&hwc->period_left) > 0) {
+			event->pmu->stop(event, PERF_EF_UPDATE);
+
+			local64_set(&hwc->period_left, 0);
+
+			event->pmu->start(event, PERF_EF_RELOAD);
+		}
+	}
+
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
 	 * events
@@ -12244,6 +12267,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	local64_set(&hwc->period_left, hwc->sample_period);
 
+	/*
+	 * alternative_sample_period cannot be used with freq
+	 */
+	if (attr->freq && attr->alternative_sample_period)
+		goto err_ns;
+
 	/*
 	 * We do not support PERF_SAMPLE_READ on inherited events unless
 	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
@@ -12700,9 +12729,19 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (attr.freq) {
 		if (attr.sample_freq > sysctl_perf_event_sample_rate)
 			return -EINVAL;
+		if (attr.alternative_sample_period)
+			return -EINVAL;
 	} else {
 		if (attr.sample_period & (1ULL << 63))
 			return -EINVAL;
+		if (attr.alternative_sample_period) {
+			if (!attr.sample_period)
+				return -EINVAL;
+			if (attr.alternative_sample_period & (1ULL << 63))
+				return -EINVAL;
+			if (attr.alternative_sample_period == attr.sample_period)
+				attr.alternative_sample_period = 0;
+		}
 	}
 
 	/* Only privileged users can get physical addresses */
-- 
2.43.0

