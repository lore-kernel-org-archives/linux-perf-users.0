Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD5211469;
	Thu,  6 Mar 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268619; cv=fail; b=JJUN47dfKp2oLclOaJNPPqMISIkmh1fK7MRB4pGoeVBMDFLmX4ZR/F91GMDH+zzNw3+QBuQvyHtxpG/PvqvbpPFv6u+i037d7bD4aRetbrv8tW/4xIx7+MkEKS6p8mRV9nuQqxD/bKsZb6kTUVslVt6wNEspT9iCdUw3nZPEPF8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268619; c=relaxed/simple;
	bh=X3ntK8VNnd2M4GDJG5UWX7JLx5+cZPdkihDmq0Cn1vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWbnrEM2vwcDI+sgWqWuNNwjTcXfB2o5q6mbvZq9Tryt+qUEw6hy3bPrHvE/fSljZZbtwh6R4W88JLVeQOVh11+Tik4DC5FWtaF9B9ZLf44aVKJ/Dw4buxRdXx8QYMoEa/9SMZOga4T0XobBBz9KBWIb/m0YndubVLpeiC7QAuI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UyzHPipV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UyzHPipV; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UyzHPipV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UyzHPipV"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=zHJ51XFndHhvD53F1qSv8B62LmdlXmfoXiJl7y322MWX7VNjwvKLiReia2fUK22Mqq98vkXm/MjGQkPqisfJ3PqKs1wJHd1NgN88nmeiKrX/bxo76xHGHxptKTA/j4Zwq71nSl/lqiHhuC2Qk8I6ZYB0bGmwmP1aKOcrJzeJo76tPIRqiBI0jLXHxfOiI6kD7aQAK2PNCZzWB73tRelqORov/wio/G5idGJJpmPrE1QOUnn2Q1nir7kmH7ekYu9oJERStnznzZnIcuOzaxRpW6o4dYsHjYMTfHZIt+CzIM/oQmJrCy3+UnfAwNjqhzR6DWm61Fl59T8s0kGaypY/bw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDN49Gai7PlHze5MMCEBuFxp8dZrfZhs2UVrR4Gu708=;
 b=p6uzt3CkGGISXn+1qhyPjf6rYDWgKYUDMIjEH8bK9gYn15zSVSPzSoPIQKPmUUFQwVPhjaJvlxMKchzi88C9JoipUl5wJs3aAwxYMxJjRHUlePUgdH/yWm/ez/ATa0nejW66B7FnoVzqn3YotO+0tutm6jRpMJMTldQTZtw4cy7vi0T3F+0fvt5NNM2BLVIVjEo8VNShDiCtGdZd9ExqudqIX6zkirQPsKK8c10o19jzSkzjZBJ+VqHO674hHTm+y1Djhl5IR8o06xRzn3/Vhwu3dhqLGKGVhRap09EVo6gghRaE+vVfpk+2kMI5lqw1LBsMaM+f0Z6EQoRCwUkrFA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDN49Gai7PlHze5MMCEBuFxp8dZrfZhs2UVrR4Gu708=;
 b=UyzHPipVX1wYVaPDPkfnHNe2O9TnCIb8JNHg/W6otZyb+CUHsjbo/HRpubR3SxXQD67O2ok++7GYZBlQu7jQvOhO1fGdkdO1gZI0iP8sgj4+rXUxRN+RGWSE/sytu7XZd7xiFL/Wszn1xx6T3XfqdRYDbFy82cc3wSFb5zEiFe8=
Received: from AS9PR06CA0267.eurprd06.prod.outlook.com (2603:10a6:20b:45f::33)
 by DB9PR08MB7867.eurprd08.prod.outlook.com (2603:10a6:10:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 13:43:30 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:45f:cafe::cf) by AS9PR06CA0267.outlook.office365.com
 (2603:10a6:20b:45f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 13:43:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Thu, 6 Mar 2025 13:43:29 +0000
Received: ("Tessian outbound 7c48d84d1965:v585"); Thu, 06 Mar 2025 13:43:29 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3d1c76ef3f681ba5
X-TessianGatewayMetadata: PbqUChtM4rk7QrUHZlQRKAVLzEK30VG6Np8kKU12q2s9qmzpJxeArSqILiA+b3lJUlU8RKegErmB+SxonCweRPqUEkGJzEBvGIVROOhKDx4ziOflMrguDfWz3fB66qamOeBXls0M57if5AZs0Ax23Q==
X-CR-MTA-TID: 64aa7808
Received: from Lf897603d0057.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B467410E-6E80-48F2-885E-FE0C507E751F.1;
	Thu, 06 Mar 2025 13:43:18 +0000
Received: from PA4PR04CU001.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lf897603d0057.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 06 Mar 2025 13:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLYUbxih3oz79BPa96BPp5WwZd5X0qITSV//QFm/Kf5H+3Ph2jIaW+LQH15pMe2YRQlwsXWUUWQ9T68U+7I+B1rZ/ERBaIlfJkr8ZgFQ69SFmoQDrIBscuYFdo1FmLByWYvCiEgluJ+/QTrkjD/cAmoxcCnkfFSzdwr7zUyxrq7u7lDMB7dMWaH3ZWE55Ll6222ZevCyb41eFMkewuzlQhnrH8wCGc+rT0P/eHt39Lvtzkq0eW8tZSKt0wxt4Dfn9wNPxBV7kxUITkFX/+t4Oo2k8repd00LOSxHg3KbEIfnqwnLp9E+cAie3aOwBDdzRNGRWY+tvttK2MiNBVRHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDN49Gai7PlHze5MMCEBuFxp8dZrfZhs2UVrR4Gu708=;
 b=G/a+kKw5YgxZPxgyKo4RR4y1a7cD85x4KaFQXluWbv0d9nLsQGzQutTmba82wOE0n/QxVkvEeU+n57lzNglWxSnZpsgsc1l+FgRyoGPXjrlIXNgowXDQJa1GPgsfmzJMqK0ptSmmGKyeMvP0Ufx/PVgjnunTp7oOosGgcD3NsHllULAXeTSlbOcRMQ2G4+qQwRw0I3uP/vys8HPAA7n0bc472ol8Zs1JBgnQEiQCadJQn2+AQoj+Y6VBTLxMXtKK3y61kAYCXfBge4aRVBaekX1gQR6kJHufgqX7jSHf8VSjmH749uwboPeR5ZRmuoy+KWPiCG75bXRcCarYquBAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDN49Gai7PlHze5MMCEBuFxp8dZrfZhs2UVrR4Gu708=;
 b=UyzHPipVX1wYVaPDPkfnHNe2O9TnCIb8JNHg/W6otZyb+CUHsjbo/HRpubR3SxXQD67O2ok++7GYZBlQu7jQvOhO1fGdkdO1gZI0iP8sgj4+rXUxRN+RGWSE/sytu7XZd7xiFL/Wszn1xx6T3XfqdRYDbFy82cc3wSFb5zEiFe8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM9PR08MB5890.eurprd08.prod.outlook.com
 (2603:10a6:20b:281::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 13:43:15 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 13:43:15 +0000
Date: Thu, 6 Mar 2025 13:43:12 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] events/core: fix acoount failure for event's
 total_enable_time
Message-ID: <Z8mmcBDLcgRxl4cH@e129823.arm.com>
References: <20241220100202.804062-1-yeoreum.yun@arm.com>
 <20241220133359.GC17537@noisy.programming.kicks-ass.net>
 <Z2V5s2JM4W7BRckR@e129823.arm.com>
 <20241220151414.GO11133@noisy.programming.kicks-ass.net>
 <Z2WMsnbFmqpEV5Pu@e129823.arm.com>
 <20241220153040.GP11133@noisy.programming.kicks-ass.net>
 <Z2WaC0CqSwU5Ux1B@e129823.arm.com>
 <20250110163643.GB4213@noisy.programming.kicks-ass.net>
 <GV1PR08MB105213E200ED463126D478DF1FBEF2@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <Z74p1QaMdNKQRNeu@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z74p1QaMdNKQRNeu@gmail.com>
X-ClientProxiedBy: LO4P123CA0568.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM9PR08MB5890:EE_|AM3PEPF0000A796:EE_|DB9PR08MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: bf79517b-726c-45f7-e8ac-08dd5cb4e150
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?mHJrdPLAxdfe5XTcc6tl4UUWWOXQtAPBrltfhzUDqREdaUzGKxpBx3gg3bRc?=
 =?us-ascii?Q?UNnco6q9qeJsO6jhY/6g1mH+HwFnfYmnRmDwnsDdO4KqG5XDJfJWWWl7+n2G?=
 =?us-ascii?Q?ZGxSm2xW8414qQzb1iLI85bZYS8ozXf00o3zZisezIH+iVQ1QNu1hVsPptlx?=
 =?us-ascii?Q?x5mZldrgqML0klBPo/6FZwY7H3F5MXE+M7oAetNCk06EmMx6RSfHnvzzYv+H?=
 =?us-ascii?Q?9nOFvW/yvCfnxTVhgdzk7M4Kpodl8RycKYJ7ZVZyBEvrIht3nHdimDFitXVc?=
 =?us-ascii?Q?je+pf6YHUSYcfMqIZITAoJHr6Nff1OfqDbqJsqzRMcgDV0J4nZZLc1kfrion?=
 =?us-ascii?Q?XRDfKEYkg5V+uY2GcYTldRdLNrnKKWSbkJDaCCxGesWA2J0YFVEBc8GZMAJi?=
 =?us-ascii?Q?O/IxxFp+O8U4JQBtpvpAx6KgVKeQVKLlcA7r3oWj1ZyeQgF1r5tHT58gDlEt?=
 =?us-ascii?Q?7a6Ht6Av+OS2INZ4+UbIwuFiBk0GaArcRQ3UUvZwzsH5UC+WQOuSIHIcGy1D?=
 =?us-ascii?Q?A/ZIrPEgWGC3+xVgn8l0tM7uxHSsVPYSkdvKJSRhsbu+/u41O56AK/5WwBaU?=
 =?us-ascii?Q?hAaD/Vy4OzHVmpDsa/RVRAnI2W6/HlJVx6oaGGyTNUPynIqUCdH8tqlwgJFU?=
 =?us-ascii?Q?0DfBrQJWBWSgUVznf1Y6HVrYkbL+bIufLlsx7crLWvDX/JuRTLAZ2NWVygt0?=
 =?us-ascii?Q?6hwVCtGLwhlkU6LFZcl1zpGZH7gAOeDT7H681WGyvKrdos2P+6nxzAMe9C0J?=
 =?us-ascii?Q?9lpJJUd87CXD1P6TqE6WCcGE9aYfkboLn2w2YBRsOO6L5cD4E7bBh+deucjW?=
 =?us-ascii?Q?yGf3DthTRWqKsmXrxnL5V++nR9SoeSTYkH40nyYu/bfANYsRj7CBMWwsVpYA?=
 =?us-ascii?Q?sFKgmfCLzSNSpTimx0k7drMwytQWbVT03cB8casDMhGGlBSMhQXyYshFmdh/?=
 =?us-ascii?Q?SktvyluFu5qeDkP836CoqjHKTQ1pigmQhSlC8bmaIuWXoxqZge8vP7xYEZAY?=
 =?us-ascii?Q?7nHguyHP8wl4MZJ5V3Uw0OvLw3Hzt9Ikqck3a5Ifo+UQSyhHSRVp3BBywOTR?=
 =?us-ascii?Q?zGPITmV+9OLUsUeRbuEzGGJMe1sFKbb1rB7C/MEV2ALIJ7J/uIulyupjrO5J?=
 =?us-ascii?Q?Yo6zhR+LOx/ycm8jb4SqjGuRCYUxxxO+QsZDQfkOHizifNlvKbO5lhEqHjo6?=
 =?us-ascii?Q?DuDTbCxhRgSjyTbfEx8Lbyl7MtyRQ8EPHYG2Bkswidy1YO5jqsoRHckqhOIf?=
 =?us-ascii?Q?cyRgS00dGgvB18RNkUrGYW49kQnn8wQfrzNsVprsqzuImLJcvBUOhnhnwqMD?=
 =?us-ascii?Q?drcfv9R0KJuf5ttGpUZBokbgRFSZCfNbknNKRooAJVZOpVIhpsD3dHk4V9Sc?=
 =?us-ascii?Q?vKpZnwZ1JFzW3ffP+CIM8k3xTaKsc+38asJYRD5aEWEkqXAJLQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5890
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	297cce70-419c-42d0-0013-08dd5cb4d827
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|35042699022|82310400026|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6NcxBePy+F4KDEP9bXrasFb/hvEXk0hnIxO2drmFUTxwZWfbVhFgBlLwtxmN?=
 =?us-ascii?Q?YFmYtD+ZQ7/pupQ7H6YOI6ba1Y0Q9s95VlexvId4QS81jidLcSpef5efAimX?=
 =?us-ascii?Q?5VofEVHg2uYiJxrSvaBLbwHKPWzGBDyJqOKdUBnLEFDBNcxm4L59qBQoqV9k?=
 =?us-ascii?Q?M4DSO8RK+oioLTn5/ZDOTVkVLp1BE5OOeJgg4wDURd5sVJ/fYclzhPzWTyIQ?=
 =?us-ascii?Q?v1TodBZTiIVIhXsKPZLzYOa7I7eCvOj4O16Anu6YFT7YLsQAWR8MbYg78kIB?=
 =?us-ascii?Q?S+YaG3kLgdt+w2ck9sS9Lpe0ZYkkz5TOvwgpvNERHDjj/TbVjHRPX92MZniL?=
 =?us-ascii?Q?lasEeE8la69Hcyi3lufevJf+TdqkjA5DbTlBq2/af4AnnCNhx3GLo9Wtgx6C?=
 =?us-ascii?Q?1sTv4jw5eGVEqGTyzOy7fAS2N7Wb9Df5dNz6/YB37vYxU6gGkpyoZ/3CXpgV?=
 =?us-ascii?Q?UN9OWC470+Sz1hX5+nBbUDttYcYAKqYKxo2or9aA6i+NsnbXpKNNfCu4Rse4?=
 =?us-ascii?Q?QkM0Bk9gyPOy7+KCDiiFFgkergE0ySj/IrBoaUYwpRg/eZIWiFyH/27+OhlR?=
 =?us-ascii?Q?53ry08GgsX1fJUg1p42BD+FV0IBIvWzF2CXCRj1Kv9rO5RjYuQfdElHvYqy1?=
 =?us-ascii?Q?Bqd8oFILoIipEVGkv/uvK3vBNJ9h4ZHy7koyh/quud2whl/kgwDT9u60baFw?=
 =?us-ascii?Q?Y8Zy9S0+PlBavUwKJ/XhgiSKJXGoZJFS7Id7QEZEn5/h6W8930b+TaNu+Td3?=
 =?us-ascii?Q?b5eYYuWi13A2n8NbnVzG16bzDAAwM+uSsVEMq8cXTiabebxqeEa8HZyk9l7k?=
 =?us-ascii?Q?jF9eGLZ2v5Pd5SlEVsXr2iSc06rxUusOlivL3xcyOR7/mL/6s4jELJ0nWnCl?=
 =?us-ascii?Q?pdS1aDYzGQb8s2budG1tDXzurpHCGH4VG5fYDdBk03v/72JNRkWyKShKKZkY?=
 =?us-ascii?Q?giiQQobMIg/aznp92uNM9lT3kqEg1maer+LmeZZy2/J7tewsjxTtSUhjAMQQ?=
 =?us-ascii?Q?cfue0ghhOiVFDa9wELZ3PeauwFwrbDwO0maZIP3qXYIg8NIL03w8AydX8Rjy?=
 =?us-ascii?Q?94Hsw/Rqfd0KD4ZOdoDIC0VoFAr6lzZAezy+n6wnYqEkBRGzoDCPSk7jtwwe?=
 =?us-ascii?Q?gSU1NkYEOD1ajEDyg4oF5U2RYqhDDtVc//3/6adypr1798egwNrpM2Csjjz+?=
 =?us-ascii?Q?vcPsYsQ34Ok8myh803EtQkj3AKQLdxyg/ZqAqZumnI3HOvBeyahfq6FtDpvA?=
 =?us-ascii?Q?Lr1Od/NpMpls9u/B72X9NOfT2hsCKAb8FG/GEI9uyUxyXqHqT7pxOuJrDjga?=
 =?us-ascii?Q?yRWZH0z/xp8EI/ZcqRd+nJtDpqF8SdYhCyx33vrhc9iPG7O7tVuFhZsy+sLW?=
 =?us-ascii?Q?ovRmdO9ZX9kmrDadSmzDZAcr2UZdqwUNMKIQ9pfJcfMz2n0SehvXrOwDYXdJ?=
 =?us-ascii?Q?gZwf4qavvZSnAG1EY8hJN8hJFrBjU2D+8wao6zAqtgeBew1oaf201QrxwLJy?=
 =?us-ascii?Q?Zi6UoQRv/h47vfo=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(35042699022)(82310400026)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 13:43:29.9741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf79517b-726c-45f7-e8ac-08dd5cb4e150
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7867

> > Hi Peter,
> >
> > Sorry to late answer. I've missed your last repsonse in this thread,
> > and waiting for in new thread:
> > https://lore.kernel.org/all/20250110163643.GB4213@noisy.programming.kicks-ass.net/
> >
> > > > This patch doesn't work when the event is child event.
> > > > In case of parent's event, when you see the list_del_event(),
> > > > the total_enable_time is updated properly by changing state with
> > > > PERF_EVENT_STATE_OFF.
> > > >
> > > > However, child event's total_enable_time is added before list_del_event.
> > > > So, the missing total_enable_time isn't added to parents event and the
> > > > error print happens.
> > > >
> > > > So, I think it wouldn't be possible to update time with set_state.
> > > > instead I think it should update total_enable_time before
> > > > child's total_enable_time is added to parents' child_total_enable_time
> > > >
> > > > like
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index 065f9188b44a..d27717c44924 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -13337,6 +13337,7 @@ static void sync_child_event(struct perf_event *child_event)
> > > >         }
> > > >
> > > >         child_val = perf_event_count(child_event, false);
> > > > +       perf_event_update_time(child_event);
> > > >
> > > >         /*
> > > >          * Add back the child's count to the parent's count:
> > >
> > > Well, that again violates the rule that we update time on state change.
> > >
> > > AFAICT there is no issue with simply moving the perf_event_set_state()
> > > up a few lines in __perf_remove_from_context().
> > >
> > > Notably event_sched_out() will already put us in OFF state; and nothing
> > > after that cares about further states AFAICT.
> > >
> > > So isn't the below the simpler solution?
> > >
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -2438,14 +2438,13 @@ __perf_remove_from_context(struct perf_e
> > >                state = PERF_EVENT_STATE_DEAD;
> > >        }
> > >       event_sched_out(event, ctx);
> > > +       perf_event_set_state(event, min(event->state, state));
> > >       if (flags & DETACH_GROUP)
> > >                perf_group_detach(event);
> > >       if (flags & DETACH_CHILD)
> > >                perf_child_detach(event);
> > >        list_del_event(event, ctx);
> > >
> > > -       perf_event_set_state(event, min(event->state, state));
> > > -
> > >        if (!pmu_ctx->nr_events) {
> > >                pmu_ctx->rotate_necessary = 0;
> >
> > Agree, for DETACH_EXIT case, below code in list_del_event()
> > doesn't need to be considered because
> > the all of event related to event ctx would be freed:
> >
> >      /*
> >       * If event was in error state, then keep it
> >       * that way, otherwise bogus counts will be
> >       * returned on read(). The only way to get out
> >       * of error state is by explicit re-enabling
> >       * of the event
> >       */
> >       if (event->state > PERF_EVENT_STATE_OFF) {
> >           perf_cgroup_event_disable(event, ctx);
> >           perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> >       }
> >
> > With your suggestion, Could I send the v4 for this?
>
> Yes, please send a -v4 version.
>
> Thanks,
>
> 	Ingo

Hi Ingo,
Sorry for late.

Here is v4:
  - https://lore.kernel.org/all/20250306123350.1650114-1-yeoreum.yun@arm.com/

Thanks!

