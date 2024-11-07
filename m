Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3B185B56;
	Thu,  7 Nov 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995693; cv=fail; b=MdVHLKPAqmlI8IR1jz94K5MeYtpxOCgJMoEMuqFDyEuzioEPiIGTtdDqTc+fUXMc7F6MBG5W1jEdHKDjhxAKwtiXMitp6dxY9MI7Hq4KdYGaMxehCiwl4keRjHKnLdu1Nbgsrqys98zJSzUoTTb6CUh/U8ID9S3/0uv/okuebBU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995693; c=relaxed/simple;
	bh=iVsKipwIQpbvX4K6U2z+ZgEYg/Mx67xjS2BhNMwRlpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ibs2j3b/0HsZe8NZ7t6u8YoXu3b4WiEv8o7uyFddJ8fDmduQJXlAoe3rK0HqrAm0sVfib6+Z5D+Oe3ktYV7iSP0WMoTwyjj92F19bOmYrIbAtN7b1H0d4tKXgPm3pO244krKzlMrFSl9RAT/eefT5CPFARSZQkobVWrfjmfRPME=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nG28rnej; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nG28rnej; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nG28rnej";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nG28rnej"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JpwwaNzzEzB1sWNc5QNJ+rWtDFYsKkAsz4pKhkjA9xwlCS93gR7E1E0Az42GkqLHh9qosMo/ZglPrGterSMOIqTPdi09PRJOjYWfs9FwdYH/va8p0iarCPtGaZrYOX1MfDzms06qH+rMi2MkucBM0lBHAnOez6GHayyCXfwGgmWuY4dOGCI2FqBrObNQNmm3o7Lv/GxVKbukPi6M8ZajkdJg+mPV1aAabN9xne8rhU0+QvhaiEq0uh+StgHAilVSHU/pjAK08Gqlvcpg4/7i30N2QUSLvYf8PL2pvjCd7+4sfLpceZoHgAsCoQP2xGY+USiZfhEu6lj6GfDQ8o1H2A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imYS8DI8E4tiVChbKkiQXUN9AItMte/SwBew5hwT0Hg=;
 b=IoPNjySbuIxrrU/G1Et2XOEXfRogP4eWQ6HLAPi8D+249p7OempoC2IzSZL2KhpOxwjhtxuiHpFqb/ayITlGeI4NLV4/zz7e6kMcCP7SB0lyB+ZbA5TFrJR1PBbPXtWrEWYH6OwBNXIddCQk1iHek5N53rD3anbOXWCyejx82HbKKy0ixfrErToKM/xnpMd2bX3MskAbmYK8FENVkNpOuonpMCLeZ4EsaT3EvUuoloGt1Yp92Jt8M+4SC7MI1zkTHCdXBhe7IHckRMuetT4uxifoWKMkoZGz6ou2URrZMElKuc8DdKoFfkwZkryRrgLxeLVekBgba1BRpR+IK+NFEA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imYS8DI8E4tiVChbKkiQXUN9AItMte/SwBew5hwT0Hg=;
 b=nG28rnejWiQSuKe3k+gYr4fkh741DhN+xDD/H5P69RsHENPE6lCpT4YtLZdzLhkwMUgewdJR+mpKLEZEvgaabZ5um/2HWbOO1bBsKK2z7O1zCtf2BlskG+RFqfNmma0kljppeCbe+wCXoGduKgEwcG3P6++G+3MFNN+wTbVNo/o=
Received: from AS9PR06CA0079.eurprd06.prod.outlook.com (2603:10a6:20b:464::13)
 by AS8PR08MB7355.eurprd08.prod.outlook.com (2603:10a6:20b:446::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:08:02 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:20b:464:cafe::15) by AS9PR06CA0079.outlook.office365.com
 (2603:10a6:20b:464::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 16:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Thu, 7 Nov 2024 16:08:02 +0000
Received: ("Tessian outbound 0fe1877cedb7:v490"); Thu, 07 Nov 2024 16:08:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 955455c070d0fd57
X-TessianGatewayMetadata: 1NXyiMFdCwX5V/iBG2noyGF5gUAe5DI1yjhjWFuw8kGhayV5D10pUw5DxC+FbanL3VJ/75d6qiEwJMELZTWQ2JwVRoVdOzE4vRzyCsTfhMBOt2u1B6pL0+xWWpqiwDvQ6oaLjltjuAGWRQIrHvjLdvmYOiFdXwPjoxBs9IFDxhc=
X-CR-MTA-TID: 64aa7808
Received: from Ld3718656196f.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4519121B-5FF0-4EA1-A76F-AD37C88C1892.1;
	Thu, 07 Nov 2024 16:07:55 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ld3718656196f.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 07 Nov 2024 16:07:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hIxWZBPFWjMMZFCQrZMG4XGsijA59B/7WZUPOpvv0cR7MZFssTFVulIQeRJM+cwebNYJngxwgtARFFiWQJ9RxVf5v9OfKU7dW/GC0C48NQyC5DosOOa1QPn19CogRokTWpkSD+vP7ugDuCYV5WfFTTxNB6yoDWey8FTpehCsLPdtxsXEgf7O/j8mnjk/nj71QP+NRPu5f8BlDkX2VsbEsN71daGjlkoTn3GBG1/gUDBPPG3a94QFRXXcaeM/64iQ2/61pgTKIW02b3rc4DZ17/S1bSRiEELjopqz82Y5DwwKvtG5v9liB/4pvtZBZe4iyc9C0NlNHGb33PHwjFEdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imYS8DI8E4tiVChbKkiQXUN9AItMte/SwBew5hwT0Hg=;
 b=W8pisDYIPSbs7l1OJE55mOlAtYZ0uPkVs3lVfS1I0D+nJnDTYxf/mHeIiXSE4Ds11EormbGKejHz+v2b5Z7ClNnhWxqXIO1LSMo9ruNed/i7EiUXZrva5mRnVZZuYp7ei42JuOkJ1WeTc5YB9Agh4f6HzZCSJGUIh3AnZbdH5r6tpiyxLfBW78lT6BwwIxr2SP2EHE4f73syr4EL8USuLJYF2Scxz5Uod7M5d4EiyIgfmfRxAULmUp6E4b+rLJvi5S+vY3q9uJP5lUR+PrQsTn6ldNbEU1KZCh2zawPVsJx/VMyxR2YWlP5jpFwkvuwjPfcPLHlud6GqG6YR9bDPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imYS8DI8E4tiVChbKkiQXUN9AItMte/SwBew5hwT0Hg=;
 b=nG28rnejWiQSuKe3k+gYr4fkh741DhN+xDD/H5P69RsHENPE6lCpT4YtLZdzLhkwMUgewdJR+mpKLEZEvgaabZ5um/2HWbOO1bBsKK2z7O1zCtf2BlskG+RFqfNmma0kljppeCbe+wCXoGduKgEwcG3P6++G+3MFNN+wTbVNo/o=
Received: from AS9PR06CA0668.eurprd06.prod.outlook.com (2603:10a6:20b:49c::13)
 by GV2PR08MB8001.eurprd08.prod.outlook.com (2603:10a6:150:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 16:07:47 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:49c:cafe::b0) by AS9PR06CA0668.outlook.office365.com
 (2603:10a6:20b:49c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 16:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 16:07:47 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:46 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:45 +0000
Received: from e132406.cambridge.arm.com (10.2.3.22) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 16:07:44 +0000
From: Deepak Surti <deepak.surti@arm.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>
CC: <deepak.surti@arm.com>, <mark.barnett@arm.com>, <ben.gainey@arm.com>,
	<ak@linux.intel.com>, <will@kernel.org>, <james.clark@arm.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 3/4] tools/perf: Modify event parser to support alt-period term
Date: Thu, 7 Nov 2024 16:07:20 +0000
Message-ID: <20241107160721.1401614-4-deepak.surti@arm.com>
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
	AM2PEPF0001C711:EE_|GV2PR08MB8001:EE_|AMS1EPF0000004C:EE_|AS8PR08MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b68a374-eb23-46bd-5409-08dcff465b7d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?ijSdgZ3eM7n+KJl6Zb3YZaqV24eO9ml2s+AUsLLKviY/P/JC6r9eIT13+LCK?=
 =?us-ascii?Q?fAiZvoG1LYtl130cgX+NeNf2DjJ35vo+sdGl6zMb2cxlc7GdBWR1VBu8WWWJ?=
 =?us-ascii?Q?RijPj9qybGDur9OFOZ6u4cdp3OkO5B8aF1KHv7uwTef6gFOXDK9XqIpeWWdQ?=
 =?us-ascii?Q?oi23qlDHLaXjngJ6zEzB8tWPb2e7o22VFV6G3T+/SJBs5UT6Ba9oA7qxY6IN?=
 =?us-ascii?Q?5PYT7XiaY1Yf6oS9GyFs/Wc8pCSFhhwZIMpsZLXCel3MktWbe0aCDMrgU9GT?=
 =?us-ascii?Q?oY9aEh3mnG15M+xtXl0vkLFV1rfIhTmttskdy0Raf55PriyVvw8RnkScGQVr?=
 =?us-ascii?Q?wqOMZou+noHhU1G7NLE5mdumN7JXgXqy/gME7PgOoFQdl8bmFo7PPKStt1Y+?=
 =?us-ascii?Q?QreQekhaIwfQCLoJ6bhHW2G0SR7ZkeAo5fAzSzt4mZLm3MmJdqKwRJWxn4l1?=
 =?us-ascii?Q?yEURoJ6BCVmexS1eSLw4vBPy9rN8ss2XbkAf7Ek2KZRBlV9YE8tt10oMnv8u?=
 =?us-ascii?Q?BJgUPzvP3ExhkgA/y8daSFDGtJuMj/tK0LIx83fBR9Lx3iLMOU0oerSfio65?=
 =?us-ascii?Q?xFpGA41M5mJ3mwfmLmSAl+MjZJE4YN9BEiHuGrlt3Q/CtD98bywT5HVEImau?=
 =?us-ascii?Q?PRuH7YeRStI6/LPPQl4hFEDSBaQiSl9y3G1Jt5oFSgyslfJtTKjAoOlAyDU8?=
 =?us-ascii?Q?sJa0suam0gT6yLVbKeNK7Cs7QGpMOsG3BDLzjvxeYOg7wRRvTeigg3JqLvB8?=
 =?us-ascii?Q?s1CWsSzPHfrTzXhyi3QJBdJabCWc3yupfsLpEs8KWq/uDHDp1wmOtcPDFucj?=
 =?us-ascii?Q?iQ3N6WLK/G+1Z8QnX27IdanCPXl7bmOya0AKFj1UUAV6GXJg+Kwd/tUhdHeO?=
 =?us-ascii?Q?i2LYC8ngjdJJM5F7KoKqaSShYZnrwnDQTneNKAFZKFIMeF68oGJkTl5raATZ?=
 =?us-ascii?Q?XCsLrME+AcnvOCKSa0qSmKx7ljCQG/GBD0u3T4OnlohieDgtzCiFF7jtK7M4?=
 =?us-ascii?Q?DAJ1Iifjd4qjz7uCHspnhP2ym7jKruMQTh21redw91MebKQ7lLzYMGV1X51d?=
 =?us-ascii?Q?KT3ldPKc42fRcY71mO6vm447NZkvKdrUfSaynn+d8Uy66OIlH9Ot1AjEVVVv?=
 =?us-ascii?Q?FYmGd9QcpQAHJDNrSdmplow1sF8UtVo6pKuO2HWfJp5oTho99rn//XAI5qzO?=
 =?us-ascii?Q?lh78yJnaMKO3HzsaMLZzi8kIBpLsrvWuDA58qs4OJCDaW/djGbPzV8AuZS4v?=
 =?us-ascii?Q?S4YJaDaRtYDIK+x9+Z1l6z4CT7tisknWfqJZYH3GhbysVmm3gVi28KWYjrv5?=
 =?us-ascii?Q?/idUdPoTS9HDUUyVKBDzB5B4sGzt40IK/5FTf8+I1Bg22KnCnmfHxa/BEtig?=
 =?us-ascii?Q?T4vsUXnqw1DrIRCLwoba4h6nYrCHj5PFSj9unwvYcorL3o67BQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8001
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:49c::13];domain=AS9PR06CA0668.eurprd06.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8d01a7ba-7508-444e-7403-08dcff465293
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t9MjUP8bfOh56h/HP3MEaNk6pSA2wiTtmYNYGF5vp7rpirskkGCsBzKxza2s?=
 =?us-ascii?Q?9aIqSD1VFJ2s5djfj9BGa+ziPmilmNBW7GAVH1kdWAkMsNpCPUcq4c/JvUw/?=
 =?us-ascii?Q?rsTMg9ejjY7ZYhVIyFnVlPudsNKpTxIL8uZz55xwFxNQnVwaEMx7j/70gSgk?=
 =?us-ascii?Q?9WwxxPW7/Xd4ZTk4OokCqHNlTI9V1oXthEriAZn1SwJ/DUY60971vzUhHVvi?=
 =?us-ascii?Q?FkpO/PWNxh+GRVCG8xoWCtEgTEb8yzOBiIm95hLLOEBAnAexdy4e+MBacjF5?=
 =?us-ascii?Q?8eiFTSNIRzFZGFd9h5BCH7KKaE5AWkbxyAn86Ts0BxodS3O+oCwtAIM/daEu?=
 =?us-ascii?Q?8aGk7bI5rrRhi4iXktTe+KcgKs6ESE4Nhs8WgSsINRVWkdYHb1CEYD3U8YCE?=
 =?us-ascii?Q?DSjCpq2Pc+ttVBwGrUmZuLNuonmsgHAz0rUSAgO2MJHhT/Ah5w8iM8gHeZNd?=
 =?us-ascii?Q?Gf+G765Iq5zkbfvQID0MqiJvYZpHDQu/oCMjO3iptvH9F7BGfoztnI4ovedd?=
 =?us-ascii?Q?5mP7nDCQ1csw7Dqycod7JFprt8vDYi/9T6HdbiWE+2q8/YPChV4n6xCl8zEF?=
 =?us-ascii?Q?IqgA/5D3n9YpjeS6ZBUt89Ds6poXN+DTfY/nc2ewphHJQmbXLSmvWlhUUw4y?=
 =?us-ascii?Q?3TT7wi6CxVE5GGiinPqcE92VVVZpTr/YPD8FjSBS4qN0hUv73IL3nG1PO8Yh?=
 =?us-ascii?Q?gXOLjK8oElkAbRXQfe1KIKfLrrxyue47rZBAjDc0vYpgI8eHcWKPNEzsrW+8?=
 =?us-ascii?Q?qdS6s7pniy/37DqNOP7YOH2FTuAZ67VfOXyW5CFQEAZb2wmmnplx3HaMJSWE?=
 =?us-ascii?Q?5ExAGcSEdACLIbXFaqbfPUT7IcXEZyWY6DoajrSpsQwUz4BFy8kCPrE3RB+s?=
 =?us-ascii?Q?FxWV9F3dPj+ywF2u/8eQhJeSX75r22hmSmCyzVif+fBVAYmtgiIiN08S6QCI?=
 =?us-ascii?Q?BztHQLNMAxbVN4dL1ep3wGyeVIxs6T8dUK07xuIGUvr/iq5GpCcB2genFP6/?=
 =?us-ascii?Q?kDQ9RP0XMDUEnhYCPLagD2yDyJkTqrNvm2abT9Kr6pK1cRon6qi8MtvFXS3g?=
 =?us-ascii?Q?1Uu3qFY95+kPUiv9y8fFjhOeXtg89kbA5CNd1cKdOvU5p0zGiRxTZJABPV7o?=
 =?us-ascii?Q?gt1aSpAdrNdJiPnzbVRmr2la6hzFOHMdcWhmEqLT0SV20yoxVx55gdI6J1Dz?=
 =?us-ascii?Q?HmkwFjj39hc2jpez6YlV8BVVSAlJrPALaLyUsvyy9LjCUuad7zPcr8BMfHyM?=
 =?us-ascii?Q?KrnIh3v9kA4ejY7uUWh5WWkgflc+JqFitatQdtBZ/cUDq117Vgci1/TAKex8?=
 =?us-ascii?Q?jaalp02sp8tiSwS+3fqUg8jG8I/3D0A2YS9Zs8wiimzqYVracWEiS00HZ9CM?=
 =?us-ascii?Q?fOM+RAoC7vO9r20PtUpu7Mo7nY5H3oNkGN3jc58r/9P8yIPe5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:08:02.6564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b68a374-eb23-46bd-5409-08dcff465b7d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7355

From: Ben Gainey <ben.gainey@arm.com>

parse-events is modified, adding the "alt-period" term which can be used
to specify the alternative sampling period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/include/uapi/linux/perf_event.h             |  3 +++
 tools/perf/tests/attr.c                           |  1 +
 tools/perf/tests/attr.py                          |  1 +
 tools/perf/tests/attr/base-record                 |  3 ++-
 tools/perf/tests/attr/base-record-spe             |  1 +
 tools/perf/tests/attr/base-stat                   |  3 ++-
 tools/perf/tests/attr/system-wide-dummy           |  3 ++-
 tools/perf/tests/attr/test-record-alt-period-term | 12 ++++++++++++
 tools/perf/tests/attr/test-record-dummy-C0        |  3 ++-
 tools/perf/util/parse-events.c                    | 15 +++++++++++++++
 tools/perf/util/parse-events.h                    |  3 ++-
 tools/perf/util/parse-events.l                    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c         |  1 +
 tools/perf/util/pmu.c                             |  1 +
 14 files changed, 46 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-alt-period-term

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4842c36fdf80..bedae424ba36 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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
diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index 97e1bdd6ec0e..956b58c7ba8f 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -139,6 +139,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu
 	WRITE_ASS(branch_sample_type, "llu");
 	WRITE_ASS(sample_regs_user,   "llu");
 	WRITE_ASS(sample_stack_user,  PRIu32);
+	WRITE_ASS(alternative_sample_period,  "llu");
 
 	fclose(file);
 	return 0;
diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index e890c261ad26..75c4527393f9 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -91,6 +91,7 @@ class Event(dict):
         'branch_sample_type',
         'sample_regs_user',
         'sample_stack_user',
+        'alternative_sample_period',
     ]
 
     def add(self, data):
diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index b44e4e6e4443..403de2e2c891 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=136
+size=144
 config=0|1
 sample_period=*
 sample_type=263
@@ -39,3 +39,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
\ No newline at end of file
diff --git a/tools/perf/tests/attr/base-record-spe b/tools/perf/tests/attr/base-record-spe
index 08fa96b59240..db528d7d8b73 100644
--- a/tools/perf/tests/attr/base-record-spe
+++ b/tools/perf/tests/attr/base-record-spe
@@ -38,3 +38,4 @@ config2=*
 branch_sample_type=*
 sample_regs_user=*
 sample_stack_user=*
+alternative_sample_period=0
\ No newline at end of file
diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
index fccd8ec4d1b0..27ef0fa1386f 100644
--- a/tools/perf/tests/attr/base-stat
+++ b/tools/perf/tests/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=136
+size=144
 config=0
 sample_period=0
 sample_type=65536
@@ -39,3 +39,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index a1e1d6a263bf..5c4d2a60931d 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -7,7 +7,7 @@ cpu=*
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=1
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
@@ -50,3 +50,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
diff --git a/tools/perf/tests/attr/test-record-alt-period-term b/tools/perf/tests/attr/test-record-alt-period-term
new file mode 100644
index 000000000000..e0de4c8eb1c8
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-alt-period-term
@@ -0,0 +1,12 @@
+[config]
+command = record
+args    = --no-bpf-event -e cycles/period=3,alt-period=2/ -- kill >/dev/null 2>&1
+ret     = 1
+kernel_since = 6.11
+
+[event-10:base-record]
+sample_period=3
+alternative_sample_period=2
+
+freq=0
+sample_type=7
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index 576ec48b3aaf..d4f0546e02b6 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -10,7 +10,7 @@ cpu=0
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=4000
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
@@ -53,3 +53,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+alternative_sample_period=0
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9a8be1e46d67..48723cea3a51 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -826,6 +826,7 @@ static const char *config_term_name(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD]	= "alt-period",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -854,6 +855,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -998,6 +1000,16 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
+		CHECK_TYPE_VAL(NUM);
+		if (term->val.num == 0) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("expected a non-zero value"),
+						NULL);
+			return -EINVAL;
+		}
+		attr->alternative_sample_period = term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1124,6 +1136,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1255,6 +1268,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 		default:
 			break;
 		}
@@ -1308,6 +1322,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 10cc9c433116..f1482361321a 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -79,7 +79,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 5a0bcd7f166a..1972a5a696ef 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -331,6 +331,7 @@ percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
 aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+alt-period		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_ALT_SAMPLE_PERIOD); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 59fbbba79697..c6af598070b5 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -335,6 +335,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(sample_max_stack, p_unsigned);
 	PRINT_ATTRf(aux_sample_size, p_unsigned);
 	PRINT_ATTRf(sig_data, p_unsigned);
+	PRINT_ATTRf(alternative_sample_period, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 61bdda01a05a..7615d05e389f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1738,6 +1738,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"percore",
 		"aux-output",
 		"aux-sample-size=number",
+		"alt-period=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.43.0

