Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012006.outbound.protection.outlook.com [52.101.66.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F220B7F0;
	Thu, 20 Mar 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.6
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459076; cv=fail; b=gfjbIq9Ophk3fsi7I5L3lA+IfVUPencjf3DEy6pgdUtDnofQbp3hsayms/wVkhrqPUTmhkNBsoy0bY67kbxLyg6RWCUw1Yg/1r83cTm+1MsdyG0vHPossjhOO+wOZtGY82NJVjYEYAO+o/NHdvqIxV7RAjCBJZNJ2oh/xrwcfGY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459076; c=relaxed/simple;
	bh=eS+XgorCSmyShIU2CDCRTwYDiB2BclZYuGVPNO5fPcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rg4tMCwy4CRYqz5cNME7GfxUV56DvQcMSqyxN6Ks630e5vnv55S4ycaxC1s3A06nzVcFmdCSkZR77HKkAYzxWiOo4YYEamGmfYxuTCymsRjeNP1MepfoPny76xQaIkMm7vpZC6vsvTZzh0VG4VFepdp33Ksbu/O4dWGWWJQ3tF4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Md20wOZp; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Md20wOZp; arc=fail smtp.client-ip=52.101.66.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Md20wOZp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Md20wOZp"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Y6D+d4IN6RmvHf5o3nOJOKHh3SovXUvz/ASEWFbj11VHGa0XFKmnNDp5VCMfBkPIf77poZJIv/p+NeLnBipgyjSYIzzvv+FNQtvGrkZM+Pdiz8TrvlADLAuN/2WdStxvqs4ECGuxWewjpVUzBQmGAKqQWIKicQ97OCRvYw1z7iaNNezDdDmplJFTjUhAlD6f6Ww1B1PW3DHDg3Dpj2cJ6ZFnxd8YX2/5wvr+xSJReVRRhCRVzYgYjk+EQ1tRe6A1Zz0mlOpI2wA/DmrVgfQp7bhEdpDhGrlb1pkQCaA/a+4aujTuFZ2JXIR4DgnxrOG6tF6IaUaWbSlldoaagHi3yg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPbPrBSC4VBIF1u72hdeMHReB5tthyMPJhhjp21zD6s=;
 b=mfR72pgjd+MjSNMVpR1HfUVIuiT0RCajapYXdaWrmgcqFppCGwgT7p1nAR9baGLsSnBnl58yoI6HjGdmfq2jC9XWNFwl1OmfhUmTmRZZcib5t6rtAniRavDJO7kHjLKyvnSze82bGVfLw5MhZFIzhcWiJRfaY9O9TQ7Vh+Q/Q5DYUSMUk/CcIYEWoXUUkTmbCIEeZh/5zt5i2FlVpUyGAON+bzCmDWG1HNe89rbyM6ONSjLcf6KqESEhV2EFwz6H8GKWaN2HjyeHXeJQk9GclorJ2Uj2Mb/cndih4l5nuYFaQwUoeLKjllWW1Q4bgyPcaEXkZb1+SEhu+r0LsVjKXQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPbPrBSC4VBIF1u72hdeMHReB5tthyMPJhhjp21zD6s=;
 b=Md20wOZp8tqyoTdmX3wHqoUu4gq5ncwSsyxDSNn5ugdmvC/wYL/shzwAKSbKJGmdIIgUH2tq73wXAhl56qlU5DcLEpMnFblZ2FXb2ltqxDD6ykf/WS7H9AbxEn9uJ4FzXij7J3+6PT3B6WO++s0LOXrvH5R2hu6WQdsO0VqaT6c=
Received: from AS4P195CA0008.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::13)
 by DB9PR08MB6553.eurprd08.prod.outlook.com (2603:10a6:10:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:24:26 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::4b) by AS4P195CA0008.outlook.office365.com
 (2603:10a6:20b:5e2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 08:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Thu, 20 Mar 2025 08:24:26 +0000
Received: ("Tessian outbound bd61b317aaf8:v597"); Thu, 20 Mar 2025 08:24:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 416c86a17c80ce25
X-TessianGatewayMetadata: uD7yntTc6BMKNtUutMBC+48LFrhj1pReoERhlmQS9JNfLUBTYk9CMrAr+cQ5oIDLbwOZWBjGihCfGJ3I5pSvRs0dkVm95ZyG3lzab0/VT2JrqgkP1l65bVMYXS4yPt5wNNqQERIfi+CtBixPGsayeAohm03WezddVQlbXERpMP2iqdB3lkzdSmHQSzLVRtDnccffSwNG60nlSZ42khAqYg==
X-CR-MTA-TID: 64aa7808
Received: from L92a0fffd8c51.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2229F819-A7C8-405E-A324-D0C7EBF22453.1;
	Thu, 20 Mar 2025 08:24:14 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L92a0fffd8c51.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 20 Mar 2025 08:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AC3JAB5Ckf5gMjNx9RyNj3kUtwkMu+4H0lg9YK/nQOFTwwLoIqdHD7JOnDdn7osOxf30auDpDhv4iTiCb/fFXW/LTD30ZMZbcm6XY8y6y2/QS0Qm9LL6FSxVhCnPAE/ociYwcs0n+YT+2rvB8DYUpL9FErdT71CDCdUwQbEvBpvcy2ZzibpVTbiTlLNLahfYq3ZKFFQ3YEsiByncnrDyDB8WU8ROONd4S/TDUGj8wEkl2oXLRgjkXXsfh1Q0pH01o8FlcqI6WYRX2ip2301AWN1BdRcTBKQhdoaC5rC17ZaggjNebn1SpGWosLKblWmjVEG1+QqAfXWlUZAhOEKJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPbPrBSC4VBIF1u72hdeMHReB5tthyMPJhhjp21zD6s=;
 b=YTw7HaflLQm7zp8xiyFHWztN+A7nqH6/YfttdXLMVrsAgx9B5hO5WEzvki7jDYsVL+vr0NwA5jYJgGWQ4WGsyTDSRKwYWZKzcqcmvMpAtPdHjnymtVN/44vtSyiCbc/ADwOnDQPPBICc+vGhU5FeasWjAjwa2m4VaMf5A+P10wVJrXKfcP0RojgvW1572JZxvaUbswvxKQ2WZawatRGnahyrsDmDojT/G+Vm3lG9EipRerPGUjR7cj81laUyTlVJr+R4p73B5M0MrZ0YRZQ5ru+VefbdYn/XRNU7kc039qpld9ybBFZXumOiZLbIJHC9QSE+Ply3aTXKXRVWPVTLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPbPrBSC4VBIF1u72hdeMHReB5tthyMPJhhjp21zD6s=;
 b=Md20wOZp8tqyoTdmX3wHqoUu4gq5ncwSsyxDSNn5ugdmvC/wYL/shzwAKSbKJGmdIIgUH2tq73wXAhl56qlU5DcLEpMnFblZ2FXb2ltqxDD6ykf/WS7H9AbxEn9uJ4FzXij7J3+6PT3B6WO++s0LOXrvH5R2hu6WQdsO0VqaT6c=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB6040.eurprd08.prod.outlook.com
 (2603:10a6:20b:296::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 08:24:10 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:24:09 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, Mark Rutland
	<Mark.Rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, Leo Yan <Leo.Yan@arm.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Thread-Topic: [PATCH v4] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Thread-Index: AQHbjpQLgICdSQAXRk2x8UOm8rKpxbN7xam8
Date: Thu, 20 Mar 2025 08:24:09 +0000
Message-ID:
 <GV1PR08MB105210711A8786F45290F88D3FBD82@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20250306123350.1650114-1-yeoreum.yun@arm.com>
In-Reply-To: <20250306123350.1650114-1-yeoreum.yun@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB6040:EE_|AM3PEPF0000A794:EE_|DB9PR08MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5231caf4-d95c-4444-f673-08dd6788a08b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?mAQIRdg3fmLfH6h+BrfvjVujcR/p/H+yrXR7grgRL4s+tHb91cNtqYHRh41Q?=
 =?us-ascii?Q?JVqZjlm7rtG4x1AlBiCj4eDPZnIaMTlWidSk4edn9eMgLfI95HqWlZWOu2WR?=
 =?us-ascii?Q?/2Up5OcARFaC+L2q4TiAOVgTX2wD2JoRDeFfMi+4zRS59ddM91XTQaI4GBrI?=
 =?us-ascii?Q?c/QmVy/EjNwmjDcr32S14fedwWV8mhKWMgA0wEHtFul5zrEOh47iCLBiH2y0?=
 =?us-ascii?Q?/QFLhuR5yeXdBRJyqRY9zTGjAUdljH7xOrRygebhvyAcR2qRIHN0ADm9howa?=
 =?us-ascii?Q?6cIhx7Z6oCFjczi4gObzHtiy0sQqQhiohhQqHxEAnISK46iNjPndJigAa/nG?=
 =?us-ascii?Q?ZkR/GcMmYF5yXnAMNYLSSulkeAxzWmOXGM/m+XQT1+prn9foH2b80JsDVEE5?=
 =?us-ascii?Q?Zc5UBS3JOnrH2+Rs2iNz0w7XovOw6UVpfw6Pgya9QhGm9hbGOhAOXYWJzWGP?=
 =?us-ascii?Q?ZQLpl5LjEnHsY8I9cN+gbK/v7nC/OlyC8Aco17hSV2F7Advb1YAh5ZWggFbB?=
 =?us-ascii?Q?9R4VGljg170cGS5KP0AUIQ3uJy0rfrBhTcLewqq1YRt0FIgfxXhO/XA6Q3rR?=
 =?us-ascii?Q?3kbeSOFa5rU8HsrNcrGgkBTAoMI9/RWaarOhzkpyWGmtyGb2f3wE3h5lmzsQ?=
 =?us-ascii?Q?qRxVSYQsiI7MFY5oAJfsl6H9GzdaPmoSW0u7uHWFF6ICE9z9ES0zFJp0K9D5?=
 =?us-ascii?Q?DjtRL4LqcAZe4TQZfRBnAAC705PXk3fTfFSJTpK0mjGxzFCiyuqV+dEXJiaR?=
 =?us-ascii?Q?tTLVxII5pS57V+el4RnQOYqiB3I9GpVd5F8epbHXhLmR/6bVXYZOyF+ipKZ2?=
 =?us-ascii?Q?Xo8BIBtfrwkWN0eFHS1hz2Bd4JcSEA6CyIH5ehzfqp3WThR3f+TTh0kf1ARx?=
 =?us-ascii?Q?3ONazmdtDgBZWvKKDqfPCz++vm2ovpEiQZiaZuMSBWn7gOftDH0NSLfg8Ki0?=
 =?us-ascii?Q?0/Ir861NJ7A8y1+Ayg8i7KQEeaLSgz7i27b9DzH9QcyOy5fREg/cAPDr68Ux?=
 =?us-ascii?Q?bmRH3+QWHuylxT7mAPhDQgs2u8HZEp7QSmfzeILJPgfdpwVJfie0/fhO0U54?=
 =?us-ascii?Q?dTSHexEjxSPDhpiWIM7sEXpnDhdcSUpJLCzWnKTupFSxFVS8yAuQ7w088Bek?=
 =?us-ascii?Q?+IRQ/nzaJ72Wa/LZqzz9wK8jIn8gZ8PdMr8pkW5eEIMbhkO0TNZ9mE9cArP7?=
 =?us-ascii?Q?YE4uivd2mDT5sZejY01ELMf+U5HWOTV2aHTnL0fgGcltVnY5J2tLNf9JiKgL?=
 =?us-ascii?Q?LbfU+SK3vc4m0StQlbaCHgO6/XnxTGf9SLrAxHL5mtPtnciqfLh5/+d5zmHU?=
 =?us-ascii?Q?lp+vq2UGYFRp922toTw6B0SURsfVGIiKJTspPoYaUKQMV9kIVMRV7A8xHLsf?=
 =?us-ascii?Q?lpqRkEOKn7sWmKMtPoS37Y3WiSE1WEzG1wndAhNsUAAZC7+dnvcnEIHWvJww?=
 =?us-ascii?Q?Wjcbgy6GzhH7QjZwMAHGjaYC+5XVeOTu6yceuGubzWqzrsfc25kIlQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020)(7053199007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6040
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	74fea89d-1594-4392-acb8-08dd6788967d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|1800799024|35042699022|36860700013|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/HRLHDs58BkMmtG414iUIUAwhov+V270ViuKbMJpHAP0NfRAJjWDTswZIZq?=
 =?us-ascii?Q?tHuAEvcEUgYRHXswJNF8QvXGtAN4xpLNpXIab63WvMcqu7f0qXaKhZ9gSYTK?=
 =?us-ascii?Q?a9MOI5o3Z9BDH/S0E5NH/Go7y1U5hHKFpPeshqbi/hHKRyIoYvvFuaw/CMQo?=
 =?us-ascii?Q?Va7Ucq5avCyD5uOi+7ut4Iw4fwVCZMTYsp4Ee+oNgJ05FXSbkxe1+iPeD6fs?=
 =?us-ascii?Q?+MOxhGL8ytrbswrqzqdxth8Y7kI/b5vxchFXN8o2wmqGqnwe08YUvGdC02yv?=
 =?us-ascii?Q?1iXj3RjT6l/Mvmbf4MiLXNllqjLCSL+DqEW/a23QCs320lbUKDKKn25xeiYk?=
 =?us-ascii?Q?i7lID1jL1Ectpii1nmq6b8FUUUKTtKBtkGhlUY3t2m2Gi/pfOIp2y5uPj+eD?=
 =?us-ascii?Q?+m/FRRihUO6S3WviOGpkWsJcxVJPRshp8PT5g+f4J8bBpBuRnL6RmZjELL6R?=
 =?us-ascii?Q?Y0tOlr3ON7J80h7KhEbfYPATKldC6JJU3bVRhNuuVr/2C5mg/MuNc3ZZ86vW?=
 =?us-ascii?Q?eUnTKyHijcKyIp8PPv2VCFSdK09v+B81wW8YHclFjg9+Ub1RhvvwKcMw4FwX?=
 =?us-ascii?Q?gw90jHT4P5oM7e0pkxtFxwRZl59qTHVdXy+iDITfo/bFWY3kPHB3UbTtXgEc?=
 =?us-ascii?Q?cDoZDu2AaARlKdkumFJmG9tRFEtD16F4fVgQYRdOnDay/ayBeJJGh2Rsqk3s?=
 =?us-ascii?Q?sYRVlXHCJtArhGgi3/IMfZ0vE7mBqvlcAMW70DdEDaYk7gQzfKAust77gISf?=
 =?us-ascii?Q?sy1mMWlJpd98Bv9IA1XyP36u2qirfsoNCPZvdjnfNnmE0k9R3F8muCCioG5v?=
 =?us-ascii?Q?RO5J8D0c29uVSNIIHM7z4BCfm2QniugMzoOKBIAfNDsOVEzCAZAaRTsAdQ1C?=
 =?us-ascii?Q?fvvSRIbLWcEQrz65pnnKQ2qqz0t3TOCBgNbXcYybTRs/TzAUmAhd7m8LtGQu?=
 =?us-ascii?Q?DgRN0HFLF+0QD7FaCGXc1ve/QPJoyt1RqUFdc14ERZTiiFrR9tJpp5LonnQP?=
 =?us-ascii?Q?WdQo8YLv6XZWm6BJv9cSZUpKwiEdGzn/gxSlB8wH9fen5R9rNHEEk+MUYkqM?=
 =?us-ascii?Q?YTv5zz1bxqEHeojluzvUx72imXMIoQHDxVDCrWC4G726fehGCpU6oWAUpdI6?=
 =?us-ascii?Q?2LCImpZ/X3OoMjRkhc0Daaw6CA9Hk7Ve3/pGNfeQC4pui1Urc+CVqtPwUeZq?=
 =?us-ascii?Q?opSfbd8IHXJwVCBW6YGDMGWuTA4coetK7tbSV38vSnmx1336zqP/0Fn/Pc1n?=
 =?us-ascii?Q?veJhMoMPKi46s+E3/NFQaEz+VNCiUB2xYKtfeTG+wGhJlkymjVsvGWyiB0as?=
 =?us-ascii?Q?efWgvnMhihPWk0vcruKisS67zWeaa9divDrY++J/kdNe9pbat+vU3spOVDDV?=
 =?us-ascii?Q?LcqX/+PoztBu52KXMcinJLJI0D32O6B9Hr1zy2dnDCrj3eOwNCFVq9h+4d6y?=
 =?us-ascii?Q?50NBha8HbQy7E4bXn6nDjv+n1OvQaLwXDK1jZj2V9okyiY7BOee0kt5eaExg?=
 =?us-ascii?Q?LnXk9NV3F2abUCC4IIPF6lCxGkN66i0vg0AO?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:24:26.2281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5231caf4-d95c-4444-f673-08dd6788a08b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6553

Gentle ping in care of forgotten..

________________________________________
From: Yeoreum Yun <yeoreum.yun@arm.com>
Sent: 06 March 2025 12:33
To: mingo@kernel.org; peterz@infradead.org; acme@kernel.org; namhyung@kerne=
l.org; Mark Rutland; alexander.shishkin@linux.intel.com; jolsa@kernel.org; =
irogers@google.com; adrian.hunter@intel.com; kan.liang@linux.intel.com; Leo=
 Yan; james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Yeo Reu=
m Yun
Subject: [PATCH v4] events/core: fix acoount failure for event's child_tota=
l_enable_time at task exit

The perf core code fails to account for total_enable_time of event
when its state is inactive.

Here is the error case for failure to account for total_enable_time for
core event:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=3D0x08/ -e armv8_pmuv3_1/event=
=3D0x08/ -- stress-ng --pthread=3D2 -t 2s
...

/*
 * three number represetns each
 *   scaled count / total_enable_time / total_total_running_time
 */
armv8_pmuv3_0/event=3D0x08/: 1138698008 2289429840 2174835740
                                      ^^^^^^^^^^
armv8_pmuv3_1/event=3D0x08/: 1826791390 1950025700 847648440
                                      ^^^^^^^^^^

 Performance counter stats for 'stress-ng --pthread=3D2 -t 2s':

     1,138,698,008      armv8_pmuv3_0/event=3D0x08/                        =
                       (94.99%)
     1,826,791,390      armv8_pmuv3_1/event=3D0x08/                        =
                       (43.47%)

Since above two events are belong to the same task context and
mutually-exclusive per cpu (they couldn't be active at the same time on the=
 same cpu),
the total_enable_time should be the same (marked with ^^^^^^^^^^^)
and the summation of ratio should be 100%.

This account failure of total_enable_time because of
account failure of child_total_enable_time of child event when
child task exit.

Below table explains how the child_total_enable_time is failed to account a=
t
exiting child task which switch cpus as time passes by (CPU0 -> CPU1 -> CPU=
0)

 - in means sched_in.
 - out means sched_out.
 - exit means at the exit of child task.
   NOTE: the value is before calling list_del_event(). which mean
         the value at exit column will be added at parent event's
          child_total_enable_time when child task exit.
 - ctx is the child_task_ctx,
 - e0 is the child_event which set with cpu =3D=3D -1 and opened with pmu0 =
only
   added in CPU0,
 - e1 is the child_event which set with cpu =3D=3D -1 and opened with pmu1 =
only
   added in CPU1,
 - e0 and e1 belongs to same child_task_ctx.

          CPU0 (run t1)        CPU1 (run t2)          CPU0 (run t3)
          |  in | out |       | in  | out     |       | in      | exit     =
   |
---------------------------------------------------------------------------=
---
ctx->time |  0  | t1  |       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2 +=
 t3|
---------------------------------------------------------------------------=
---
e0->ena   |  0  | t1  |       | t1  | t1     *|       | t1 + t2 | t1 + t2 +=
 t3|
---------------------------------------------------------------------------=
---
e0->run   |  0  | t1  |       | t1  | t1     *|       | t1      | t1 + t3  =
   |
---------------------------------------------------------------------------=
---
e1->ena   |  0  | 0  *|       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2  =
  X|
---------------------------------------------------------------------------=
---
e1->run   |  0  | 0  *|       | 0   | t2      |       | t2      | t2       =
  X|
---------------------------------------------------------------------------=
---

The value marked with * means it doesn't updates since event->state was
INACTIVE.

Please see the last CPU0's column with exit (marked with X).
Since e1's state is INACTIVE its total_enable_time doesn't update
and it remains with former value without accounting t3 time.

In this situation, at __perf_remove_from_context() while exit child_task,
sync_child_event() where adds child_event's total_enable_time to
parent event's child_total_enable_time in perf_child_detach() is called
before list_del_event() in which event time is updated by setting
the event state as OFF.
That means child_total_enable_time is added with missing
amount of last enable time -- t3.

In case of parent event's total_enable_time is updated properly in
list_del_event() when the task exit.
However, the child_total_enable_time is missed when child_task exited,
the perf prints error amount of enable_time (which is summation of
total_enable_time + child_total_enable_time).

To address this, update event state via perf_event_state() in
__perf_remove_from_context() and call it before perf_child_detach()
where parent's total_enable_time is updated.

After this patch, this problem is gone like:

sudo ./perf stat -vvv -e armv8_pmuv3_0/event=3D0x08/ -e armv8_pmuv3_1/event=
=3D0x08/ -- stress-ng --pthread=3D2 -t 10s
...
armv8_pmuv3_0/event=3D0x08/: 15396770398 32157963940 21898169000
armv8_pmuv3_1/event=3D0x08/: 22428964974 32157963940 10259794940

 Performance counter stats for 'stress-ng --pthread=3D2 -t 10s':

    15,396,770,398      armv8_pmuv3_0/event=3D0x08/                        =
                       (68.10%)
    22,428,964,974      armv8_pmuv3_1/event=3D0x08/                        =
                       (31.90%)

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Suggsted-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6364319e2f88..058533a50493 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2407,6 +2407,7 @@ ctx_time_update_event(struct perf_event_context *ctx,=
 struct perf_event *event)
 #define DETACH_GROUP   0x01UL
 #define DETACH_CHILD   0x02UL
 #define DETACH_DEAD    0x04UL
+#define DETACH_EXIT    0x08UL

 /*
  * Cross CPU call to remove a performance event
@@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
                           void *info)
 {
        struct perf_event_pmu_context *pmu_ctx =3D event->pmu_ctx;
+       enum perf_event_state state =3D PERF_EVENT_STATE_OFF;
        unsigned long flags =3D (unsigned long)info;

        ctx_time_update(cpuctx, ctx);
@@ -2429,16 +2431,19 @@ __perf_remove_from_context(struct perf_event *event=
,
         * Ensure event_sched_out() switches to OFF, at the very least
         * this avoids raising perf_pending_task() at this time.
         */
-       if (flags & DETACH_DEAD)
+       if (flags & DETACH_EXIT)
+               state =3D PERF_EVENT_STATE_EXIT;
+       if (flags & DETACH_DEAD) {
                event->pending_disable =3D 1;
+               state =3D PERF_EVENT_STATE_DEAD;
+       }
        event_sched_out(event, ctx);
+       perf_event_set_state(event, min(event->state, state));
        if (flags & DETACH_GROUP)
                perf_group_detach(event);
        if (flags & DETACH_CHILD)
                perf_child_detach(event);
        list_del_event(event, ctx);
-       if (flags & DETACH_DEAD)
-               event->state =3D PERF_EVENT_STATE_DEAD;

        if (!pmu_ctx->nr_events) {
                pmu_ctx->rotate_necessary =3D 0;
@@ -13424,12 +13429,7 @@ perf_event_exit_event(struct perf_event *event, st=
ruct perf_event_context *ctx)
                mutex_lock(&parent_event->child_mutex);
        }

-       perf_remove_from_context(event, detach_flags);
-
-       raw_spin_lock_irq(&ctx->lock);
-       if (event->state > PERF_EVENT_STATE_EXIT)
-               perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-       raw_spin_unlock_irq(&ctx->lock);
+       perf_remove_from_context(event, detach_flags | DETACH_EXIT);

        /*
         * Child events can be freed.
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

