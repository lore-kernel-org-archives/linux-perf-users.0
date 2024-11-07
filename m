Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE92161F3;
	Thu,  7 Nov 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995702; cv=fail; b=fGwQQKSkM4oTu9dCg4Mh7PMHV4IfG9IPl2C1l85OtHykR9cj4EHR5whJwXG42RMOAsqXbv+Pg3woqD7D6rpCsCeh03AAVEffchSgB9RQ5TMP7+E7ume1lwRJHsrNLDILy6nv6LGBxbqmpA9+3c3SoORUsysGxn+uNdJt3dO+8jA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995702; c=relaxed/simple;
	bh=0yGm7YT6JhdBc8mtRYiUz2eFB6EF9PmFSvnSBltAi/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtlcZ/rWcNH2Tb8rEkZdI+lxI23gzAHFbOwaJgegECDQvdE4j+AhLVxv677TWGHC1opyyQUE1FSx5sbD0zZro5QNefbiX+oTAMH5pbXOBl0n75KyWZHEqQicfPWTBhiFsfV4epecxoMYlUGDaDcBql+BqfP9HFisUaGLeYJYjOs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l/7jiCea; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l/7jiCea; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l/7jiCea";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l/7jiCea"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Bb+Q5zSW1+O4pKK0wjnHrly8QKkZVMKJlOe+NY09wPA0jgVKLYWwRBKZhqGDZrJoCCPVA0csuUbFiUBrpvAuprpT1jZZKDrdst+vJdG9HKpPvEqP/jL7YUc0+RsEIgcYtyci57Vv5b3NnymlchkXSv1PVBEE3J+pZpweJqsPeqXUz2+C71JscqrvZYdl6/k5sNPUhcSFRjM8sRHhV9EPEwa702s0V/+amryiVnyLJ+QsoY6KV4RqcXxYTzwvEo4KqFlyLX9eDjh8Ryo0URB5ImeyqbsOrBUh7gj4SIMjzuMcdeSd+en1mj4qJ4JU5crA4X/8YYRwS1j9063L+xsvKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9LqgE8dW4hUmHx3D52niMT7JXJ5J/OinSVhVWI7jHI=;
 b=v2vxygWfUzn1hAFYCsEJgmZczcyO/H5iPk4kw/B04bNa+pRR0DuehSmDniFvPO8BkMucZtqA7PEfE15Gt/yUGLL+GsNyAJbPiJAG/AvfCtBx33nRVenZBFE1zDXx5vhSZYIlMjVZ/CbcKJi5JagSs6tbrU4Uq52sayOlMDlesOrvNiHUpUt93wKvh4K3fAOL0Ssa9E380khQ5o12VRl0pSvigSJZQ26/Q3DELUfnM9nTCbaFQGPnN+2O8IBTl9chhD4WZVihKIklSQI+Wm0E8eugTWgkwO7X5cowkz3sqLuq3/oAk5HYmCf5yAUvp84vudLT6huZdOPTsh1rTqc6Zg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9LqgE8dW4hUmHx3D52niMT7JXJ5J/OinSVhVWI7jHI=;
 b=l/7jiCeaGjcXkxOTj1jOs8kHsLAltjB64V31lNCuEjsE1YSltn/51KBVxuv4ciORCqg1jZGKCG0fuhvpYsPlnFdQj/mTDVnJM7ocPR8dYmesaaAXNurh4dgzdO5LlJTTi7nt9Af3HVCqVm4FbMRYA44QjBAnXLJI2z/2VMuXV5Q=
Received: from DU2P250CA0001.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::6) by
 PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Thu, 7 Nov
 2024 16:08:16 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::9e) by DU2P250CA0001.outlook.office365.com
 (2603:10a6:10:231::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 16:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Thu, 7 Nov 2024 16:08:16 +0000
Received: ("Tessian outbound 4a86a9c66651:v490"); Thu, 07 Nov 2024 16:08:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9f0652da09028213
X-TessianGatewayMetadata: BC+DMOY0e2MFItsCh36Ph9nYU8o/CqQblghzDbGznE47zeMSsNZMnknAmEd6DbqRKr7P0kGBH7pImpBhsAKwZ2ihk8OnXDCIaUk7ZI0yN4dqqx9Yp0q3BczN6ClGdnu0dENiQScy0nb/kjSXoFWO2goSfEeN0vxPclspEXzLol0=
X-CR-MTA-TID: 64aa7808
Received: from Lf497499200bc.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D4EA1FCE-6234-4EC4-9B9A-847986D2D82A.1;
	Thu, 07 Nov 2024 16:08:09 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf497499200bc.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 07 Nov 2024 16:08:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAC1lRTDkNngFRld4DQvRXUlIfjkDujbWl1OZixutSuIfxHRlwR2aaOeh99LZDQlkkB580Arnt95JRuFSS48ZJhxYAtJQi1vwMyQXS2gy5h/zgcvCJX98yNnI0J4qZFRJAWa6izS0aiaK5lSriCnQ2kPXq6I5hrJiZebRSSdIar0g+gbssKSy41okZCgq7UX41fQq5/sWDC+1qJ1lAqXO7sOQzYKVV5Vr0/lsBR3GpcG1Lm4Jadn+aCwIQgnQ1JdQhRO0+v/tk2fQmZbtQI9/Jj/eyn5GvyqOSYEMdYp8BKs3/t+flc+wUcYnqCPukVeCgkh0GZrvZMU/6ARZbFrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9LqgE8dW4hUmHx3D52niMT7JXJ5J/OinSVhVWI7jHI=;
 b=Qthixx2w9YRriWGoRHwZjKO4l9SyggSOpbsvdmXWfiNp9Er0J/jo5E2PDvGuCFTqqX/hDeTf+Tq9Dv1Nm2c4+tRdBIlZczAdBOyh0qxH4fjxDlMMbYWnGRRDQoJ9fqniJMy3hxnVE1ZjBtSUsQ7v3FNp39AZnXGHS7f5chqRS0ZmjshHBWbZ0FMMuIkw3Vl2o7cFLFepf9exEVSbz2H7qsA2leHs58BZBRC+p2d3+9OJ2P+HSlmssUg+pP4c3OWKq1Ir+cJW20ZebUnVwB4lHZAZbnJLKemNmbuB+xHcLyUAYBfUEOMIZmyiu5jebmgjhGCNXNwIyiX2xMesDYp2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9LqgE8dW4hUmHx3D52niMT7JXJ5J/OinSVhVWI7jHI=;
 b=l/7jiCeaGjcXkxOTj1jOs8kHsLAltjB64V31lNCuEjsE1YSltn/51KBVxuv4ciORCqg1jZGKCG0fuhvpYsPlnFdQj/mTDVnJM7ocPR8dYmesaaAXNurh4dgzdO5LlJTTi7nt9Af3HVCqVm4FbMRYA44QjBAnXLJI2z/2VMuXV5Q=
Received: from AM4PR0302CA0017.eurprd03.prod.outlook.com (2603:10a6:205:2::30)
 by AS8PR08MB6311.eurprd08.prod.outlook.com (2603:10a6:20b:290::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:08:05 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:205:2:cafe::2f) by AM4PR0302CA0017.outlook.office365.com
 (2603:10a6:205:2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 16:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 16:08:05 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:43 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 16:07:42 +0000
Received: from e132406.cambridge.arm.com (10.2.3.22) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 16:07:42 +0000
From: Deepak Surti <deepak.surti@arm.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>
CC: <deepak.surti@arm.com>, <mark.barnett@arm.com>, <ben.gainey@arm.com>,
	<ak@linux.intel.com>, <will@kernel.org>, <james.clark@arm.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 2/4] perf: Allow adding fixed random jitter to the alternate sampling period
Date: Thu, 7 Nov 2024 16:07:19 +0000
Message-ID: <20241107160721.1401614-3-deepak.surti@arm.com>
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
	AMS0EPF0000019B:EE_|AS8PR08MB6311:EE_|DB1PEPF000509E2:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7085ae15-4cdc-4392-320e-08dcff4663a0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?1PV7PJDnKvnlG1CLly/JNYmtzce17tZ2rhz85qzeBg9lRW+nHiXSL7oXwTzV?=
 =?us-ascii?Q?D0lBLTLzqeYi6xIMc1ot1cQcsmVghQxqL8MSq59FinUfQ0GeM9V/HDQhu+QY?=
 =?us-ascii?Q?q1r8SZHxpUDQAPBddWdVGbq9kHDQmpW8BIyhofx7RHV2FAo8xBPgkWY2G5lc?=
 =?us-ascii?Q?fXAhNSwCzVQXDgb7HKmZdCZnVetIYJPFqze9v2OK7Ivt9ARdp96DyhZADjHD?=
 =?us-ascii?Q?/vQs2b5nPr97M5f5EqzPJ1xoTZB7rt6Gyw58haOdicX/GYizXJG1mwt4GNHX?=
 =?us-ascii?Q?z9j5CtzKTj5D7xv/l0szbansTrwsAB/AMrMgSpbLa+kgi5EQrFkw7ZFVViI/?=
 =?us-ascii?Q?a+0NyKa+0K5uZWwWjV2vjS9SHkYSr1FaWC2Og2dQ/JdD0Br4e/IqTtynoT+7?=
 =?us-ascii?Q?Cg4qO+i6ft5o0809E10F3DdgM17ifUNRGJ0HPZKEaQj7E/874Al5y8jHU92P?=
 =?us-ascii?Q?YLcVMyzq40efS/K5tWmoqtw654awvCdm1+DG9yhqT6RrfIhGvTCVgrZ+nMsK?=
 =?us-ascii?Q?/eBmmmCJfaC6t/nbXhoUOCwYF3TDx21AlRJohUowN5t6cCq6IebduNrkP84M?=
 =?us-ascii?Q?rRX6Ob0QEqSA5eaN2keNIluaO+2L16IGXwio/DVR7NItXj21SsveFIdG6wFD?=
 =?us-ascii?Q?0Us+3oeIogLJLFmAE0oETpEOfEJrGRfSg91/2vZQwk1jBMjEf5kX/S+fhISV?=
 =?us-ascii?Q?wAIq21Yc//o3pZs3D43lNUN3C20SQCHSzohsuQTdyd6WI3EXSxjpb6a5PLnM?=
 =?us-ascii?Q?DNnRz+uSg4/2XXfhp8ZyK0JuB6G9vQW1kj6KN68+8uFjIb9fRdk9IKmzb1ry?=
 =?us-ascii?Q?A3OE7l20+3HucdKfkr/yI+duFpcsaDxC3Gz1hVqmwS7TR3L97ZC6F1dBMjsG?=
 =?us-ascii?Q?yd//NMv8T0XEcU1CoazqRgznXZKyoJ+6XtJKf1D4vhQd6xuetOvM2CTJAUTf?=
 =?us-ascii?Q?lUItBlFOjj87gsV76O46EBGQCf7veO/FIx/oCDEFd4XsEpO3lSx493mtZzeE?=
 =?us-ascii?Q?Dzdwlvsh/Z1s9qMjHAt9+z1qXJGHCx6T9PcwXewMwAHWqTiFfRnSbTx/0a5/?=
 =?us-ascii?Q?99eylGKaLC6KITUAe6XdBuqmkZ6gbbAU5mjzfqxaF1lLoUMT//ZyRKoWNsdr?=
 =?us-ascii?Q?MSuBwKWUrlzIXU0w9g4O68k0mcYNOrp/Hcj3dVKoCfZ+XKR6SCdU+yFsGeSb?=
 =?us-ascii?Q?amu7YMw/CYY5SlrFamd8gzE09Q70oVHbpclbOptb4q/hJbvxWw/XA0uyUJ2B?=
 =?us-ascii?Q?knvplP2WuKCIt8xNJzWbiX1oQu58ph0A/S1oR9TZM1y4GCKrGw/NVksBN8GA?=
 =?us-ascii?Q?wcmKmejIlo3vEi3N9ZKYsIv5iUyushySACP/Jhav1QD+1JVLfQvVbKHVFiIO?=
 =?us-ascii?Q?dquI7DBjcyxwPNHQTY4XDWqcNjzetnTY9wENVrN0TG1+3VgBDA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6311
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:205:2::30];domain=AM4PR0302CA0017.eurprd03.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fb36313d-646c-4e7b-6efe-08dcff465d21
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|36860700013|35042699022|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ItsuisbIQr1ePXJuqsrVWJF9xlsMIY7lO/xurVi3Dan/lS5eLnTa2Txwo0RT?=
 =?us-ascii?Q?CAqsjvUR0kbrA4ss11TC27kW4cARbyQXFvLSbXNE6UUEIdGQpurNtAj03qhV?=
 =?us-ascii?Q?tnALd9tyfDeqMNmcCfBJI74Ka97gl/EQbPhPrhNTIo/7Ix2LSOSeOzPb3N2C?=
 =?us-ascii?Q?5xGPvz8H/uns/MPmMhG/rqPjeSX6oO16OwZs5G377kbHAOZXpKuLeN+HTq6T?=
 =?us-ascii?Q?fT1tSkosH5R9P+jGH4nwTHKec5GQW1GqbP+eYxr/bPyMA3tMh8B34OnMo/3k?=
 =?us-ascii?Q?pHOrKUIz6/tJ495O/M0espruoOAal8Nw+ajpwU4IarM91RBTZvyJzYx1RomG?=
 =?us-ascii?Q?bwYdA67yaINetwJfcI/TzwjQwT+sY7yXH5uP52FtPH29gv0LLTkhbhmRBJI6?=
 =?us-ascii?Q?+a+2edGAuZp1dPqmpJS/xyfGwH0LJi7MfjZdPX5mZJ5NvkouMqbRcD2nDmjE?=
 =?us-ascii?Q?ENOGv5HeCmKQsFeHcZSBdp1NEJm6uDWfXwpITV5krtZGgMl4LPqdwhxnQaXS?=
 =?us-ascii?Q?hxXnXsNqE+Htekluo2ZXaAYJSQMsmotrKtyb7Li/iQu39ZjLqmkQqo6Dcw2k?=
 =?us-ascii?Q?AklS9WBfX+V8NuU/HKC0+tUGZvWARyLSQ7dILzlY8jfiPvlllzHL6WTH298z?=
 =?us-ascii?Q?Sgk9YBMNYm86rHBDe6hJ6DC3a8+j7ph0Pg6/77iunl0tkgdXfxuq05cP+CAZ?=
 =?us-ascii?Q?JdtYTTRSXTPj2KusUltd6zK4fMdMQKgrxtFE93BN/5z4KU7x10bmjhxmVdOE?=
 =?us-ascii?Q?DL6SDe+nH9mUvQtI2wg813iIKZ8CAY7kD8rlmFN+US0EvGaE0EEuRoT4GJN+?=
 =?us-ascii?Q?s6JdYrIilkpIpXDEzd7QbklAf79dl75DjOMGPWSeZWVGoGcSg7Q5X1KFoexk?=
 =?us-ascii?Q?htZKMUN7dw0LzKWyMlRR6NX9+dheMk821x5BnOkNEvZuS8ggKBYdKF34zbT9?=
 =?us-ascii?Q?WTCHmzURvoyYi7WVH0XVTMFvVA3Nee/AMLOauR/r150f9RwYalZId/mNh/90?=
 =?us-ascii?Q?LljfKcHpB8nXnin3SrmdTpKk6mTxvHSNW1P79ies5fwIhUIKnLogqICN8oNA?=
 =?us-ascii?Q?iObC2l1zGwAeLNEUzwVcFMTdGgtP8rpx5SdxYr6NyciyYcHkpNTOkzcuIrPm?=
 =?us-ascii?Q?R9AfU1UVVm28J91S6lOtxFKJlu/tYikdrhvMYgZpOUY8DA+5GdcKD65stjaa?=
 =?us-ascii?Q?n5mC2jkN/5py3V+Eyq5GdZmNcfHhBJ+I62Fel7tDtGHctG87IGrwHvNr5tXN?=
 =?us-ascii?Q?iZKoSmxmaOegQXB/We9nTpHOSCTEqlHmdr8tIQGKdfxqqXDa8J+KyCXeDkC2?=
 =?us-ascii?Q?ZC2Or5OvBalE1/SpWh/trZHVpsshhTGNRltWhwNXcmzKABDJrQZcIpEn8s8A?=
 =?us-ascii?Q?uEy/SnUMJ+dBx4kVoKvtjeD8W+eN9hYCOHAZkTAbJkJu0xQlew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(36860700013)(35042699022)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:08:16.3535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7085ae15-4cdc-4392-320e-08dcff4663a0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338

From: Ben Gainey <ben.gainey@arm.com>

This change modifies the core perf overflow handler, adding some small
random jitter to each sample period whenever an event switches between the
two alternate sample periods. A new flag is added to perf_event_attr to
opt into this behaviour.

This change follows the discussion in [1], where it is recognized that it
may be possible for certain patterns of execution to end up with biased
results.

[1] https://lore.kernel.org/linux-perf-users/Zc24eLqZycmIg3d2@tassilo/

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/uapi/linux/perf_event.h | 10 +++++++++-
 kernel/events/core.c            | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bedae424ba36..16dbeea5803e 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -461,7 +461,15 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				/*
+				 * jitter_alternate_period:
+				 *
+				 * add a limited amount of jitter on each
+				 * alternate period, where the jitter is between
+				 * [0, (2<<jitter_alternate_period) - 1]
+				 */
+				jitter_alternate_period : 3,
+				__reserved_1   : 23;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 579b04af70a2..14dfac6f13dd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15,6 +15,7 @@
 #include <linux/idr.h>
 #include <linux/file.h>
 #include <linux/poll.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/tick.h>
@@ -9831,7 +9832,11 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (event->attr.alternative_sample_period) {
 		bool using_alt = hwc->using_alternative_sample_period;
 		u64 sample_period = (using_alt ? event->attr.sample_period
-					       : event->attr.alternative_sample_period);
+					       : event->attr.alternative_sample_period)
+				  + (event->attr.jitter_alternate_period
+					? get_random_u32_below(2 <<
+								event->attr.jitter_alternate_period)
+					: 0);
 
 		hwc->sample_period = sample_period;
 		hwc->using_alternative_sample_period = !using_alt;
@@ -12744,6 +12749,9 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
+	if (attr.jitter_alternate_period && !attr.alternative_sample_period)
+		return -EINVAL;
+
 	/* Only privileged users can get physical addresses */
 	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
 		err = perf_allow_kernel(&attr);
-- 
2.43.0

