Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610781C5488;
	Fri, 20 Dec 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703568; cv=fail; b=lkR9TadLKqX4DPZU0PGlbsm+OF+eBDxVaeLWVg/uzRa84+aPbs6uflQFiaOAM0r2JaMN1Dpi5jbnSHmQw/TDSApr9ZMBKymEp7LMA8fZmvnMtnRqGCzbwRc4ZpuXzJnwCLx+Vebda197kRpahAUHBn5aWHahSkQYFhmIuEOHAOY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703568; c=relaxed/simple;
	bh=gCTOoWkEmDuP3X+91ZjSl14fpE/cF5+SsTM3ucveims=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NI3+1TttZcqBeorTPRBBK7s+yW1tGqXklFhH234NMobrKUNacM12TDIlpXnoppBu5D1DdUyonn4joq61djAe4neH9ukVZawhTZ/JIjFt9JNRWOVlsUpQbjV73oPg+Ht6tMRUKmMwItMqwlI218ybVC0V/FO/MqE/b89g4iv8MZg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C0/Vh1BG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=C0/Vh1BG; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C0/Vh1BG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="C0/Vh1BG"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=W8cEyyYHzMQa/UbE4t3pXtYnXKgA7iU0/yFKPClO7RvZE37HO+PSO1TgOWUFBRXtlcL97LJ6TSfy64iJoC+AOrDCltgio1NyVZMKzW+HOKLD/Jo2FMoWFSOwChp7v+rRyfkU7qPQtDul5/E/U8f6MT3tW1OpThfymabbHi8v2ZxpHKZz087n1efsbamNKXxrDtxNSPV9VxaapXpNMF3vTi24hlEg1vrBSDxhAZA2mPh78APXINgBfdMnZcZ+0YgHeRGA785bZjESLTeS1JU6Y/a+9DnjW7Rsgijz3dSCafbGfoeSd3hbeH9M73YJXgY4wA7jaqWdkmPpEBjlRvn0dA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvpqyG19PM7gdZpw35MS3JmMx5m88EDULBUgOJ8FLe8=;
 b=skMviYwyFI4PtiLnO7l6FgUvYChg1l1eg5m/zba0juUvVPmQYWD5DvRYxaKB4l8tUQl1gmW+woKyOACic3ILYuf3HtrLWkciYJuPcbDR15l3tMGI5MJr3aWkiHq7IbMDpNMWsuCmI054wKwd88AbXSsLXT2rbVFGukGK93Yp3CZ5hsM3BWdOsy8kodZ4/CpV1GhyKuzMgASOdCdOf+qvlLc/PNpxExglbcJ9EeeDAhNW6HSsxarevWQi3krFYHPj98Olp3LPif+OTT96ZHBx9YJfWA+MWuUipNco5fcRT2oROmWQIARkbVHUNiFBVgXqoH2dKRU5Q6NkWNqaPXZjWQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvpqyG19PM7gdZpw35MS3JmMx5m88EDULBUgOJ8FLe8=;
 b=C0/Vh1BGZHGxeQ1pIS6eIMl1NwJeAQ0R2rVpW+KwQAq+IV2aMRy7dXUpuRwRBVBQbP5Dx/XywsWKv0/uva7WvwIfnIo4mEMuk3LrH5C4T4b+eAiS4PLVKjz6G75i5dn+WbiFV8EzI43j/8lYYsBwEJD6GExjyyBjuR7v0mKKX8U=
Received: from AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::11)
 by DU0PR08MB7414.eurprd08.prod.outlook.com (2603:10a6:10:352::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 14:05:57 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::bb) by AS4PR10CA0030.outlook.office365.com
 (2603:10a6:20b:5d8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 14:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 14:05:56 +0000
Received: ("Tessian outbound 7762b28e8285:v528"); Fri, 20 Dec 2024 14:05:56 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b936a678333e2d8b
X-TessianGatewayMetadata: znEoxklOWUIgilp39aob8z4LVS0pg64ICj/77Rze3Ifn17t2cvN5j6iNNqJLtZjcSuDaEh5Jii1EJUH5FteUKpcfuEvpQiEPcoWsrHlU9V33pKl5l1YGfIn9Ah5h/S0fMaEwdWBgyCZqjg/fbYgNyg==
X-CR-MTA-TID: 64aa7808
Received: from L5d9a04829801.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 510F40E1-63C0-424D-BF65-C515EC6759E0.1;
	Fri, 20 Dec 2024 14:05:45 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L5d9a04829801.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Fri, 20 Dec 2024 14:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI/wWIDswoD7D/s4Tz84LMmR2rOAlRmCUUi8Yz6gawunTJ3GlCzfKb+uIF6DMF1I+Sb+lxx9FJGxI9wTLA9p2whA0cK+x+xv71ITxU5AbU6D13GDRqxhPVccsEQFzre6XyJAgBCOQmLPZMS/f13Im0ABGG3JHwLxc3gBml/0UVFDSG1J4BOPcYa8KylCh2voVlJdXIRvGQUosmz7X757rAxEzoDI85UqEzn/Z4oNnkdkZV8TLXPUIzjkrYYDxKjwl2vK75Qc1InbuI4zfvflHUuVyyBmvZ29QsDsnvXkacF4JlTVhkTZ9wtrprHmk2k74rqlyXyJwYahRmx0ZklNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvpqyG19PM7gdZpw35MS3JmMx5m88EDULBUgOJ8FLe8=;
 b=H21jbjKA5V6bN0ExjDSCyi/1RD9Kz7uB9Nvknth+HrZ5R4UQtveFSP9PuAWUc5EaIJ3CSG0JkhDWXqVY1Fq3nQ5AU4InsB1kLZldht1CLwiY3uBUqB1aAgd/NsRmN+ypj8NWlKgJ8IhN/G13Z5IKxXmbR6p/t1Xt0h5qPPzISxIQHF0LA2VDvbPNirrTja7cPt29jNkH9ZWb3Gi+iC/ypTzpNBw91WPBXfFjqDNBmhfmTwUYWx4L9G8iqFDDjNl2BA5jvGpzj+QYWj+kepn5agUSJNsDBaq+JM+y+/a4tzSxGC4ZZwaO9tn9T9wZSJlyQ/l8+En0udaocWTmec1qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvpqyG19PM7gdZpw35MS3JmMx5m88EDULBUgOJ8FLe8=;
 b=C0/Vh1BGZHGxeQ1pIS6eIMl1NwJeAQ0R2rVpW+KwQAq+IV2aMRy7dXUpuRwRBVBQbP5Dx/XywsWKv0/uva7WvwIfnIo4mEMuk3LrH5C4T4b+eAiS4PLVKjz6G75i5dn+WbiFV8EzI43j/8lYYsBwEJD6GExjyyBjuR7v0mKKX8U=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA6PR08MB10663.eurprd08.prod.outlook.com
 (2603:10a6:102:3c9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 14:05:42 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:05:42 +0000
Date: Fri, 20 Dec 2024 14:05:39 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <Z2V5s2JM4W7BRckR@e129823.arm.com>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220133359.GC17537@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO4P123CA0190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::15) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA6PR08MB10663:EE_|AM4PEPF00027A5D:EE_|DU0PR08MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: d647117e-af8f-415f-b15f-08dd20ff6ccb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?zGo2h+9qMaosMVA+jWkOYDhCTe7qgp669IoSgbEWjFFpEDoHjDNYjHDxTqHe?=
 =?us-ascii?Q?iWHmlbp+xIEgmCcacamkf4ZlNaFSOovWZxq0FAn8k8WfN0hVisp1pc6Q2sS3?=
 =?us-ascii?Q?QayaYTaLv5E4Dsh4CNmVkNc6xVW/r0NWnZRtfRTSFwaAw/7u0of/44TmtIyo?=
 =?us-ascii?Q?WijcxJzrk4K0vWmYvcIahrK5l6HldUaHBPCZEwuKLXgwAlgBjsaW8qnihfU0?=
 =?us-ascii?Q?bOKLZNsz0mkqRm9sH9QQeBu7bUawzF5nny/c7G8MENLte4IwyzaT04Gt9CS0?=
 =?us-ascii?Q?a92+hXQfkx5xbo8SJX5qg4haeFo4JebEeuJyNGKg9IUZ+pohSlXQjgB6v9Yz?=
 =?us-ascii?Q?Fyxd4bjHw3TFBZgqK2kD3MU/dFjk6BMbKoSmJI4/4lsUbvqkhj3k9hdiugYp?=
 =?us-ascii?Q?AH2VDJ3Mlyj6eTKJwD7QvgpKXgIWZX8zF7H0cJsnJLw6enhv3zabrH3qxa9q?=
 =?us-ascii?Q?uP9WIgD3xV3tA/RZJdLkfktTGnGlurwoHQkEBcARdSQPKG6c7b/vH/uiC5zi?=
 =?us-ascii?Q?hkuMsgUmYyn9cnG1p7ZFfzwTNRQaTMH6nC+h/+if90EEXZ/XypjTWqw1LG/L?=
 =?us-ascii?Q?6JUxS3RmYfoDlUlzUW2gl887jyZPRpVHE7cHuM2UNWRMJ7Xp33tHJLKM5iBR?=
 =?us-ascii?Q?LcOvKRkvK1wJ6zzKx4WE6Z47ugACwfcEwSf0uRZJkL/PJCgbcR+/YF1J4wDJ?=
 =?us-ascii?Q?tOmU/IRCwaa6tYnbUQZEk5U5PhLyOyZiKi+Y6mbgun8/+Ce/REGTh/9e03MG?=
 =?us-ascii?Q?/SILbT3WSCbZlV7cGZ15DQjjwsSJkYLR12/9a8ftLN78+pdJsj6mgYc2rWmM?=
 =?us-ascii?Q?T4H5mXgfV6NSJrTcYaLUVLpFpeusOo45JrDlmUHWheDECzzyIfy3M/WrxixJ?=
 =?us-ascii?Q?juNaBS3tvu/NrKeLp41fNd9Sx/FYuUYbabOTVlAA/VBez8gexybqBricEnqG?=
 =?us-ascii?Q?wWK5/nxfKIdmP7KfOn/TSbzu8BvRXtHCmGdzK15fVbAxe30NGf9AFOSAeWQ7?=
 =?us-ascii?Q?5Sihon/SFV8eNJvWc2p4vwV5qmyc7gLvMVj6/kUlJPTcUBy/XR8IsnMt1g57?=
 =?us-ascii?Q?BAOkopn1Ns7U0eT6MZzv9pIuP28baYqQuFwMb7bhimAF7iZe1A7KCgu+3KeU?=
 =?us-ascii?Q?mG6fM/Bug5/ELkfcTcLuXod/pE6+/KW1BL5LtQJWrX2y9+ztOaMC3maG1vBy?=
 =?us-ascii?Q?Mm2qq5c3RRikjlbmtTmyiotwa/Z1iPfyFajlKKSVwmoI+1gGYJeocKg+Hx2B?=
 =?us-ascii?Q?QY2qyTGoc2IqPA3/79mydqrSKW8PoN5HrN0lNw8+9aafdn8bGMFYSpDLX5Dv?=
 =?us-ascii?Q?k+fyAZDfydrfz9qbuCd6am60nc/GLIY4IHHzTtNNAR1Qeag8jLko1/t+4GFN?=
 =?us-ascii?Q?b1+UsqnheKjwK1AdIFypiIpUr4FJ?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10663
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bff345a4-0abb-42fa-8720-08dd20ff63c4
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|35042699022|82310400026|14060799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2yYVZ6q30EO4n/7BH4yKrLad/dJELN399+3R2CrCHhJ1neQo2kuhurYRX2Wj?=
 =?us-ascii?Q?Ysfm6il71g/PMmYbsGHvQDxUZ/yo7t9q1BRBhKkfUWyAlknLGX9fNzJRxKth?=
 =?us-ascii?Q?XiLLi3kiNG0Nq7Agu0nnarthZuNnqySxcJuYqsYGza15cxEPwhVczD2M3vFT?=
 =?us-ascii?Q?VGbOHDw2AxEVzyFCgPdVYxxeAOo266cBfFDmhQw1PsmR4PF7vKiUW4W6uHB+?=
 =?us-ascii?Q?pJZ1HpGtFniclILnpREA2CnXFmXX+QqXdUWwQPBIItUODbYrZYEQUqwSD+3m?=
 =?us-ascii?Q?iU/UjtEzTujQT1UtnmG5YGJDJkcwKNS1HDKLo4CGyGExAxvEHMkVcbOiU82n?=
 =?us-ascii?Q?YmSEcezmoOySKChdCnjcGHQ+8yuAvHiq6BNn3WdRGisrQ684ow3VSf0npR9Y?=
 =?us-ascii?Q?ys+0uSwmnZ7j9bclrBHFpoOVkD42E+h6QJh+Y+sLQsHTKFLfTK72EN7t8sPD?=
 =?us-ascii?Q?Y2jGYs6F6WoBLyG1pKL2tAhq3lpB9YwaN9aIt23NGoGH3DMfNB/ylPcU6hAU?=
 =?us-ascii?Q?JaonrPX1sHGIrPnr+gEAvx4dYcqisebQxvftPTcS2H2FVLcGJySvXJT52GJs?=
 =?us-ascii?Q?qHYwGhBuJOzZgQ8BYeBYwWiMDI445ObwBxNkFIk9xL4AmWw/sZ4mPLHElZAA?=
 =?us-ascii?Q?OGnxeTNRzCyAqr9d00nMETzf5Z3dvNpdzkI4hLTuY7v5ocuPtW811UPpj1qp?=
 =?us-ascii?Q?rWyBuNCAuHoy15U+VpriMvH8raBibFWyrvnRLKoOOo6/xiCPdtU6gP7/iULR?=
 =?us-ascii?Q?g6SL8Xyaw1LmTV6O465n1tc2CY/oXQm+Q/iMHgI/kOnCY9jEKEs2tvk0tStl?=
 =?us-ascii?Q?Rj97yS9yGnCmS7O09MsowdGTwJT7/2qDnpP0K/jazDKD4w3AYrb9l05Ien3V?=
 =?us-ascii?Q?5WWgHsEvAtFHwq4o3US3d8BFs5fMNbH27MpT3IZU9RxqTpAP0zB2dYCV9yR0?=
 =?us-ascii?Q?ZDJWs6xAfTRGAShKaAUgyuYjoRNdoOuBhhIoD3+t5x+YBjGWqKTZd0SLFWv9?=
 =?us-ascii?Q?ah0lCUl1FrJBpahfmZVrKP68ZR9+lLHpF9KfqVMbxUZGYzfcTwenh+j0Ggsc?=
 =?us-ascii?Q?IrntLs59Ng9YccBqpjl2T5rnnkZXO1PfN0ZskK2n/SjlAbvrCy6ljWhED/9x?=
 =?us-ascii?Q?LX3LXsc26stdmJw0M8ALt9ZohB71ni7BYBjR+m94Xqwzx3Xd+bURfuuIe3S5?=
 =?us-ascii?Q?03x7W5kFVSsXs9uCjkH/zyN7yIzoC5Se+PubRr31MMuWKpO7pl8sJdcJJr1S?=
 =?us-ascii?Q?vYHWT82Ji4dKYn5BwM2rpn7jOw8xDvo80QVfpupZDyHxhSVD/yHb2ZNdQdWp?=
 =?us-ascii?Q?3+dNPQEwBUxgfLdwoNfwccBFpjriDxcwDgHdDLaXovAIJk1x3QrdAb4QfWW3?=
 =?us-ascii?Q?y9VjGGsMOvW2LthLpASSDqsXq+ATawDfpA45ts7Ke1IhbdZevDapzCEsJvRr?=
 =?us-ascii?Q?XNhVuP4FwWKT8veF8kCVPEJ/NTy8PlbJGcB+KCvVex+ze2kZ/GbmXW6obiIn?=
 =?us-ascii?Q?nnWDsMn4LgKFbFI=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(36860700013)(35042699022)(82310400026)(14060799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:05:56.9735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d647117e-af8f-415f-b15f-08dd20ff6ccb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7414

Hi, Peter.

On Fri, Dec 20, 2024 at 02:33:59PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 20, 2024 at 10:02:02AM +0000, Yeoreum Yun wrote:
> > The perf core code fails to account for total_enable_time of event
> > when its state is inactive.
> >
> > Here is the error case for failure to account for total_enable_time for
> > core event:
> >
> > sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> > ...
> > armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
> > armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
>
> So *that* number is wrong and should have been equal to the number above
> it.

Yes it is.

> >
> >  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> >
> >      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
> >      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
> >
> > Since above two events are belong to the same task context and
> > mutually-exclusive per cpu (they couldn't be active at the same time on the same cpu),
> > the total_enable_time should be the same (the 2nd number among 3 numbers)
> > and the summation of ratio should be 100%.
>
> So the enable_time for the second event is too low, meaning the ratio
> hsould have been ~15% rather than ~43%.
>
> /me goes try and congest the wall of text below for more clues :/
>
> > This account failure of total_enable_time for event could happen in below sequence.
> >
> > 1. two event opened with:
> >    - first event (e0) is opened with pmu0(p0) which could be added on CPU0.
> >    - second event (e1) is opened with pmu1(p1) which could be added on CPU1.
> >    - these two event belongs to the same task_ctx.
> >
> >    at this point:
> >      task_ctx->time = 0
> >      e0->total_enable_time = 0
> >      e0->total_running_time = 0
> >      e1->total_enable_time = 0
> >      e1->total_running_time = 0
> >
> > 2. the task_ctx is sched in CPU0.
> >    - In ctx_sched_in(), the task_ctx->time doesn't updated.
> >    - In event_sched_in() e0 is activated so, its state becomes ACTIVE.
> >    - In event_sched_in() e1 is activated, but soon becomes !ACTIVE
> >      because pmu1 doesn't support CPU1 so it failed in pmu1->add().
>
> This doesn't make sense; e1 should never reach event_sched_in() and it
> should already be INACTIVE.
>
> Notable events are created INACTIVE when !attr->disabled.

But in perf stat code, it via enable_counter(), so it's set with
INACTIVE.

> Also, scheduling should not get beyond merge_sched_in()'s
> event_filter_match(), which will find the CPU is a mismatch and stop
> right there.
>
> This also means the event (e1) does not get to go on flexible_active
> (see below).

No, when perf stat command with above, the cpu sets as == -1,
So, It doesn't filter out in event_filter_match(). so it enter into
merge_sched_in() and get into event_sched_in().

> >    at this point:
> >      task_ctx->time = 0
> >      e0->total_enable_time = 0
> >      e0->total_running_time = 0
> >      e1->total_enable_time = 0
> >      e1->total_running_time = 0
>
> Both have the same state, surely that could've been compressed somewhat.
>
> /me deletes giant wall of text
>
> > 7. the task exit and task_ctx is sched out. and suppose scheulded time as t3.
> >    - In ctx_sched_out(), the task_ctx->time updated with t1 + t2 + t3.
> >    - e0 was ACTIVE, so In event_sched_out(),
> >      e0->total_enable_time and e1->total_running_time are updated with t3.
> >    - e1 was !ACTIVE, so it doesn't update
> >      e1->total_enable_time and e1->total_running_time.
> >
> >    at this point:
> >      task_ctx->time = t1 + t2 + t3
> >      e0->total_enable_time = t1 + t2 +t3
> >      e0->total_running_time = t1 + t3
> >      e1->total_enable_time = t1 + t2
> >      e1->total_running_time = t2
> >
> > In step 7, amount of t3 enable time is missing in e1.
> > So, the perf prints error ratio for total_running_time/total_enable_time
> > for e1.
> >
> > Here is the summary of change of time as timeline:
> >
> >                CPU0                  CPU1                     CPU0
> >           |  in | out |       | in | out     |       | in      | out (exit)   |
> > ------------------------------------------------------------------------------
> > ctx->time |  0  | t1  |       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2 + t3 |
> > ------------------------------------------------------------------------------
> > e0->ena   |  0  | t1  |       | t1 | t1     *|       | t1 + t2 | t1 + t2 + t3 |
> > ------------------------------------------------------------------------------
> > e0->run   |  0  | t1  |       | t1 | t1      |       | t1 + t2 | t1 + t3      |
> > ------------------------------------------------------------------------------
> > e1->ena   |  0  | 0  *|       | t1 | t1 + t2 |       | t1 + t2 | t1 + t2  XXX |
> > ------------------------------------------------------------------------------
> > e1->run   |  0  | 0   |       | 0  | t2      |       | t1 + t2 | t2           |
> > ------------------------------------------------------------------------------
>
> So just the table is fine (better even than this giant wall of text),
> but you have to explain what's what. Eg, there is no clear progression,
> and having two columns both labeled CPU0 is highly confusing.
>
> Also, a visual indication of where the error happens is useful. So the
> cell marked with XXX is the failure case, right, that's missing '+ t3'.
>
> Except then you should also mark those I stuck a * on.
>

Thanks. I'll rewrite it again.

> > To address this, update total_enable_time in event_sched_out() when event state
> > is PERF_EVENT_STATE_INACTIVE.
>
> This is a giant jump that I'm not following. Notably ctx_sched_out()
> will only iterate pmu_ctx->{pinned,flexible}_active and that list should
> only include ACTIVE events.
> So how does handling INACTIVE in event_sched_out() even begin to help?

the answer is in the perf_event_exit_event()'s
perf_remove_from_context(). in here
event_sched_out() is called via __perf_remove_from_context()
So above case, the enable time is fixed in here.

But I think in case of change of group_ctx_out() is my mistak. Sorry.

>
> Additionally, where does perf-stat get those numbers from; because
> afaict perf_event_read() will do perf_event_update_time() and you should
> be getting the correct numbers, no?
>
> I'm utterly lost in the perf-stat code :-( Also it appears I can't even
> build tools/perf anymore :-(
>

After exit task. in this case, the ctx->is_active doesn't have
EVENT_TIME, it doesn't update ctx->time and the event time.
So, the task_ctx which is child one is callected with missing
total_enable_time.

> > After this patch, this problem is gone like:
>
> Yes, but why? Something smells.
> Looking at group_sched_in(), I'm thinking that that STATE_OFF thing is
> totally wrong, should that not be something like:
>
> 	if (group_event->state <= PERF_EVENT_STATE_OFF)
> 		return -EBUSY;
>
> or something !0 at any rate.
>
>
> So what path leads to event_sched_out() with !ACTIVE that's relevant
> here?
>
> It can't have geen that group_sched_out(), because that wasn't in your
> first patch.
>
> How is this a fix and why is it the right fix?
>
>

As I said above, at the time of exit. __perf_remove_from_context()
calls in event_sched_out(). so it fixes the missing enabled time at the
exit.

the middle of event''s total_enable_time() is updated in ctx_sched_in()
(as I above said, it doesn't filter out because it runs with cpu == -1).
So, it's enough to add missing enabled time with exit() and this is
fixed via event_sched_out() in __perf_remove_from_context().

The group_sched_out() is my mistake, But with update in
event_sched_out(). It's enough to fix and I think it's right fix.
