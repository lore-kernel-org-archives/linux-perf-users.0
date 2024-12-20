Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2063.outbound.protection.outlook.com [40.107.103.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E279218AA8;
	Fri, 20 Dec 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.63
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709556; cv=fail; b=DFwDC+7rcAbfhWa2M78Ih8N6Cu7WF6zQVlE+Nc1v05i8D15uqbw58Vw7JxI3t3rFSF8PnadPDW6WosvwyOJnm4agV4ISKfZqMA9CXuWDCEXgFrO5+Igjn05I8wgcR5pxbzA00wTBPiCN3tpNs6lCq3Ycwnv9W/3FYIqXPk3uPEk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709556; c=relaxed/simple;
	bh=2iNDLkIklLZfblqoeIGnf65rGtt+J+8RTAlVqpkDQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqW6HSMpVTw6BlnJLNkRzVeEMuFm8O+5L/4tJnq91wG5ZWQVVL+ltQh8TbDLrSSMwX1C6Xm4Yct2kb6T8p/d1g4deYEK0tK9gyfUpZAM0bZmhgAgVlsdx9WTKRf9ewTDrPhHF5qc/q6liyknhaSg8SvCf6ambnr234cQ6GMpV74=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VYYFlxjh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VYYFlxjh; arc=fail smtp.client-ip=40.107.103.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VYYFlxjh";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VYYFlxjh"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FY2nqeQDQmXq5+YIUNaB0kPz0Q4Eo4QU5mBshM04H86um4/N/yU7XhGNGd3P+EX2aIHNhI77hz6+B/QrdgciwskO1pVjuupgZJl9NpydOZStXeUYcBom5Ej8Oiz60ebodqtQzvBx7qcChHq0tqyPWtC+0NgGVG4A7wDHbVx2hCETtnWPQRPGBo18JZ8UXMrSGkZfj89eeRuGt50cKzGP9Wp0kIlb2QJCGHe+DyBhZAqhlLHbv9KZLUhmxIvde6C7Kg/kbeAH1CBsuBdIRg4IvQpyPhiGGG1pcTU9nuqpqJhW6g6k0o0Jqk73M5T5TntijyBK5rdzxqtMmMxiBRVAlg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YHBC8VnB6ar8V6MgPGZFqdhKd9rDmT/+UkAKuWuXAQ=;
 b=kaeAzLouLqrFduTjfDenqpCj+vsLnz7X0eReKkqnIUOtI5+KCaiv165aEJFI5a4LwM1bCxlZhfLNjVW+/pT/CpscfJy18jCDlYv+LZx7qO13ze9UUWoSEKr6pnVRYNIdrDuMl4POyOAgMEUvF5sOP+LQz0znXNHVBbClM7kIm722eCmjzYLN8VpqeNW5mXR1m0kqbv/wDLOge5IdO3AO1yva3KCLGUL/sYoxCdI+lM2Fx4YK0gX144v9Htbse3ZZetUaUKRpcW8bjObzbU5xVbKfvNXoydfcXCQM5cNEdseiqwps06cL4MertY1FUM0xDlmzamssgcAt5t7308dRqg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YHBC8VnB6ar8V6MgPGZFqdhKd9rDmT/+UkAKuWuXAQ=;
 b=VYYFlxjhIploz/jL42Kc4p0ymAPngiKbF82vroRGKNw9LBZsmDeM6lqCZfTGJL7zkiV6Ssx/pE4vZU9s0SDZjpm1cl+5yLbezDUSee762EyF7401eHC61y/LPYpRXgDFPHbbefKLs3Sjh6qCc8hZXZh4vlIvqhfITkBDV+oAsr0=
Received: from PA7P264CA0376.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:399::13)
 by AS8PR08MB8682.eurprd08.prod.outlook.com (2603:10a6:20b:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 15:45:49 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:102:399:cafe::9d) by PA7P264CA0376.outlook.office365.com
 (2603:10a6:102:399::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Fri,
 20 Dec 2024 15:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 15:45:48 +0000
Received: ("Tessian outbound 8c86f99b1b13:v528"); Fri, 20 Dec 2024 15:45:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0da281db7c624d87
X-TessianGatewayMetadata: PAyjeMjvbsleLICnrMG9IyauscU6wkG7yguEUfaVUsJGwPh4hEv4xfW434HlSAeH8hNd4EATKMmIRjSLrMO+w809nBOgCwVbhrzk1kmJyDl6GQUEd6soLvFcKwpCtYkMGTK3NFY24S3Msvo63q9Pqw==
X-CR-MTA-TID: 64aa7808
Received: from L1820c9295c2e.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 015644DE-AC10-4B23-AFB8-9817D2B3D54E.1;
	Fri, 20 Dec 2024 15:45:41 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L1820c9295c2e.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 15:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHLktwfTLBIz4f/AzDdmw1Ftojvxio8XqoQet0g7c6nms/PASwykVA9VpVNahcrsDtb6VWauqNatIqiPVb5oVynsgPutK/aFo2VTq5R+9i4sNwY1Ak5WY/4S4knT8M12c42E94Tm1g74Tj6Po6GWc8VJNL8xnQXeaS/kV/Q97cDxnEenHwCo97K2IehFvQxXrOCYyryHTGiA1rtJBZzMiN0erLFzDx4ssj3aMnlfE/Rk6khd3zee174sKOEgEUtkxJlNbk+WLRwib3rOM7fZWA6Tewo/mYSOsxJKvFiEYkr/+QtedJ7oIT8fAHYZFaFO6fBD78ZZ0zKaM1kje7PXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YHBC8VnB6ar8V6MgPGZFqdhKd9rDmT/+UkAKuWuXAQ=;
 b=AtbUjsK4IQGFs/SbqF375VFqHoFUF7nH7/xOpNLRxHGN9hhAXhNtTxrdHoABZh2ieLu7b2pjcCzlVv7NzlAd0goSBpd57nA1X/HC4fV1mva82kMDBzD85Rk6FZJSuGCSAwF8L0JaQi3GwDbor7Gi6tumT90jlhBjdhCC6WFSylJc+QD2p9xZTW5V55qfzwo8dhXFDa7SrleoMDHi3HtCBhSOxQiWI3Ar1czzx2kLlRtJzcj+/YuzfXYETeP8yabBg6s82whkx8Vv12JaDajCO9CE1CowUAUtjWaAXYyobi8LwcXEZtExAp7hqvo5/72UG/ZCmoq+AifHv8IMZskmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YHBC8VnB6ar8V6MgPGZFqdhKd9rDmT/+UkAKuWuXAQ=;
 b=VYYFlxjhIploz/jL42Kc4p0ymAPngiKbF82vroRGKNw9LBZsmDeM6lqCZfTGJL7zkiV6Ssx/pE4vZU9s0SDZjpm1cl+5yLbezDUSee762EyF7401eHC61y/LPYpRXgDFPHbbefKLs3Sjh6qCc8hZXZh4vlIvqhfITkBDV+oAsr0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB8034.eurprd08.prod.outlook.com
 (2603:10a6:150:99::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 15:45:35 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:45:35 +0000
Date: Fri, 20 Dec 2024 15:45:33 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <Z2WRHS4CbbjTIHkQ@e129823.arm.com>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
 <Z2WMsnbFmqpEV5Pu@e129823.arm.com>
 <20241220153040.GP11133@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220153040.GP11133@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO2P265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::32) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB8034:EE_|AM2PEPF0001C70E:EE_|AS8PR08MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: a01b7db6-2cc0-4c5b-5eb2-08dd210d6041
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?9U6WpDXuX33tmlJC+sO5tFf8fpRfBhXTSWMHRUbd4TMD+W6REbpUiW6fBYiW?=
 =?us-ascii?Q?Y0I4aOcmGFjoMil7GE5QR6F5/+f4ODAT6dJaZCNU3mB+ajQTA8UAgdvrMz+2?=
 =?us-ascii?Q?WTH59rZcBDjJ41tEWmeyxCINoTwd6GAUPKBN1dI5DazJRVyWgFoH0JLFlYEg?=
 =?us-ascii?Q?5pAotqYgEc6Ni5uU08A1uO47rvNl0MHYj49Z4mPBQ7jZoEBHKsIRRssAf56x?=
 =?us-ascii?Q?3h2PXj//lTc5VhoU2j1+er9Bur3gkp8kb5ynoC0ElqIvUfKlj7EZwjf25UVr?=
 =?us-ascii?Q?0VVrA1WNlomA7BCNSWX0A3bSjMXQma8EQN/EAlLEGamHM9L/5DVi4qss19Wh?=
 =?us-ascii?Q?avM26E08zEDiugltUueJXiU8Yp8z1CrElHmaBc+BJ80h1ciQDl7M/5u4GFie?=
 =?us-ascii?Q?j8VR+lYqyM/GQ46m97kngcV6pJUsdnHPDgUAqL4l7J5DhnPiyVAvSGLdQPYC?=
 =?us-ascii?Q?3NXlG96d4JP69SyOBLmCuJGf4tiUoWfj6cXanRjNE6/MfbWQmIQlg2QsGu0k?=
 =?us-ascii?Q?yinRj8EFN1P9jl+SjO99x+tJ6hKf4LA8MM3F67jNi/ks2eQkWOsXVqC7wt84?=
 =?us-ascii?Q?xVVLzHOcLsgQA8neArkP5z7J0iU3ypqaDaD8beHFyBV13xwrF/CuEOGOzVH/?=
 =?us-ascii?Q?B39OXY94V7aGwpUBn0xBVvohXLEm7mti6BvNPw6UKxKWDoWHdzCIfB5iPnGB?=
 =?us-ascii?Q?ogROFN7IDcGKT1vhNmAYsYlvZDL1N0GfP89YVjTTOkPNVGp9/renKQ1+WZ35?=
 =?us-ascii?Q?2wymGNINi4RJxIhU4fO6po4xkQ7r0MgPVdMnU8d9U1Pjgz5u7qL6O6b+lrF6?=
 =?us-ascii?Q?0tcsjoJVwX5KqjJHor1EX4CzrTyX3mLXhcjOjmmY3OOhJM72mBLg5SqjtVv4?=
 =?us-ascii?Q?tssjadei7SuKk8j3VOpxD8aFTQQ5qROOx4holV7ibCFHt5KLlQMNC9J2VmnP?=
 =?us-ascii?Q?Y/8i+Lo9ANsbFqdi4DG6fMwfQWju1FxbNL2AVSYxoi5qMkKnVwEKdIWp+hYM?=
 =?us-ascii?Q?/y7fhNovv1Es9x5p/Aid4MHxbR2U1rU7350nkVO6iM9ROf01STZckTlozO4W?=
 =?us-ascii?Q?jM7NNfl/OjSMKSffzDV3kPVr8i7lm9BcwKHVK9WYIF09rPI0VsBmzTST81Zz?=
 =?us-ascii?Q?CFjkL/SzXu7khmax0HSob7kCNvijzdzrj4A+ve6LBh0DEe++Z3eaybyAEH33?=
 =?us-ascii?Q?dNhvR8FgAnAQiGg0faAGtN4fIIUHoiDbMWqReelkheWIvQW2hH4ZXOGxURM6?=
 =?us-ascii?Q?siIxLESVNboD/783zBNKJdpOyYHfVEsDQHL84RkPSoahdv055dgzfaAOd3SL?=
 =?us-ascii?Q?rIEolc1iwMtdOPRN9u/Ei5hre5h6m5+uib1YAR62cRPItgCDuHH/d1wBJcc9?=
 =?us-ascii?Q?K02ZAs9/tPI8KZPxPpP30550Ae6b?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8034
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	524e6480-736b-4063-c2fd-08dd210d5857
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1CTQ6RTIyqYrQASxF+67gCO6keP+NbslvCvt8iFUxjXBLfb1AEt60ewQr8JH?=
 =?us-ascii?Q?/TaCMotQyna4SsrD1jzJYGCqiqoTWPfhAbYhGZgAygt1dZLG1OS47FVsG/N3?=
 =?us-ascii?Q?gTCVSCQDo1R6Wrtp5AcJNJJ/8mdT4GTkZAPhOVNYOGtRf6/0WzXDEC4JujqZ?=
 =?us-ascii?Q?qEF9MEL0RjhHIfCEjr5MS/q1iAWFad3J44wEBL8d9HhBKu9THNiwlognZzsQ?=
 =?us-ascii?Q?Ec7wHmfmnD6zLAIL/rJH1zPoKkB+RpK8F4aPDUtVokkDsrnNFnNvp8sQ9ryw?=
 =?us-ascii?Q?Af8eMHYqRnqau9I1y1BCu0qBuo/2cT0lWqxcXjSRGqK5mLo8uCv1giCOT8Nu?=
 =?us-ascii?Q?4XIocXUpxR/S8hpVXQ20+/o01pV6SfuQP6sY9vL1pxpNFO8I+n+MazV2p9JZ?=
 =?us-ascii?Q?YRb1R9Pn1Y7mptLvbTqLygzvxdAg/zBAXcJJ8hjiZ2joifTRSLdx6MYeu7lv?=
 =?us-ascii?Q?jdTlCqNu0C1jtPAMoKqksPhlfBUDiWenChSK6feEGYtCWgQClh4N3oOtRZwF?=
 =?us-ascii?Q?M9yvQEWXXMd9M6PztIYOUG3U6gvKsK8apmIkqBbTqxD/nMTqIcQZSVBZ8c3m?=
 =?us-ascii?Q?3tPWgLNZBE2qCEF+8mQYy+1K/uUj8NhOkSWBzI6CEDU4LNlUJdkkt3ZTe4jc?=
 =?us-ascii?Q?N0bYcmmlNafzL52K6W/iTxDawcTrkaDn/HqHr5Z7yHM5K9wCJd1hULwDT2ZB?=
 =?us-ascii?Q?ku5r3Z2Q4A0HS7eFt5d1MgqNAXYS9/sMW/nr2eudIu1TKNgPip2hRJE/KCVZ?=
 =?us-ascii?Q?6J8gsfUPRXrdn2QSYVH4p1R6ZVGxIq3nNS2+8tz1cpAIzw8jHoVIMCFJfFpr?=
 =?us-ascii?Q?OT2GjDz5cwKzCA7fEKNDw/astI/QcGA6OyeIsD7rWMyWaJgPiKPQRRfg7cnB?=
 =?us-ascii?Q?Jr94klmZKlyUQ7+1YNC3xWwoGP9434AQFhmNM3TwTAiUjN5aOKasnU6g1Fej?=
 =?us-ascii?Q?k6bKZvPPWnWSy6/dLQGX4lHJS7xJuwc2x9AQqrEa7PhBFsEQRSZEBGY77p3z?=
 =?us-ascii?Q?8PsZnaz50akF2lvOgp2giDbIpvt6f9Kq1SxdG3OMC9v7ovBmizVtgl6sIM5d?=
 =?us-ascii?Q?SNj3HRKGCZnuldEjwiSTA3JXLcVc1vc87bqDosLUg6v41F7kZftf3YxMk7aZ?=
 =?us-ascii?Q?LGwLOunAnd5I6ek48mqAVH0u8996XF0qxdscXkBpFidket/ecVBSFe2f1FLs?=
 =?us-ascii?Q?bryW3hxfJOjNlIexzzhsz6wnBlpYdY1KdkDR8izmTg7y1s9TO6wXLWRqPhHa?=
 =?us-ascii?Q?IIBUAJaxn2iVI+90ywK4tRtbOLi3TEhljXG7Jb3ndXULg2uaYPRwZjO9xVt3?=
 =?us-ascii?Q?yT6vhMrpnZz6ObILWijlCA7c02/Ch66uitn9TkOpPauFaWnLylavMOQMvRov?=
 =?us-ascii?Q?DV1IiK0vKZIuTqlSHn6UXX4bu3Scy5XiYMWojAPBlJnyFUficeOLb32U9nMT?=
 =?us-ascii?Q?QO9G6cMbHMYNVrC0JqddzCvCa/dXN1kCcN311SHZAWzq52UOFWGcJb00YJvV?=
 =?us-ascii?Q?UwXePpFH+Fc/204=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:45:48.8885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01b7db6-2cc0-4c5b-5eb2-08dd210d6041
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8682

> > It works. but what about this?
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 065f9188b44a..71ed8f847b04 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2432,6 +2432,7 @@ __perf_remove_from_context(struct perf_event *event,
> >         if (flags & DETACH_DEAD)
> >                 event->pending_disable = 1;
> >         event_sched_out(event, ctx);
> > +       perf_event_update_time(event);
> >         if (flags & DETACH_GROUP)
> >                 perf_group_detach(event);
> >         if (flags & DETACH_CHILD)
>
> Well, the rule is that timekeeping is tied to state change. And as you
> can see __perf_remove_from_context() violates that.
>
> Probably because someone (probably me) figured that the event would not
> be observed again after detach or something like that.
>

Ah. Thanks to let me know to think this rule.
I agree with your last suggestion.

Could I send patch with it again?

Thanks
