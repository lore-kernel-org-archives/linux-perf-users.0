Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0A3033FC
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822732; cv=fail; b=FnWBZ+0CmqlLy5QszHN2me9Ts0TZGhU14CwiCNHks1OmjNNzHCKdaQBHW93oC+oXc4UTZkXPsiH08XvquTCSrVWsppPpqaLodAqsoFwqLEUR1p5GxoODuC8Yfjem/Z1twsDZpus9T2nLW/oVWqcTxp1ARdtivW4a7Uz4dNGgpmA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822732; c=relaxed/simple;
	bh=4U3yWa4P+oKify17k57HOCuEVDTGzCQ0JdBlvedOXxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NvUnwBv5SY5QxY/4Xwet3Nt4+uP9Xk4r9LKf5KD82S9mVgPJyJQWaiWr4w8V8o5/het90cX0HUYgUW+xfsw706jZgAaPr84OvFmwjQGKwI/yO7YaH7u86x6tnJwpxxX5xrWMyRgPV/8XAMZfJphRxVfT7gENQkGZGW2a+QZVBhs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MYGWCgcc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MYGWCgcc; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MYGWCgcc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MYGWCgcc"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oagpR3V9MOs8R+tx1vyzjL3TT8I7UtiB8MzXremgNFzR3qHytHks32Xt5SjGFCmA4TPRIG6sd2Vj5ZruF5HM9BrQ4quW52DcAhfTj+IELhjO+QD6LV2tz03K0I7pEMgjHrMMMu0DpL6jMsnmlt1uTzXovts8L5NrinuWD0GBcrtLZ2yvIifcURpsulcEebpkQqw1HSSakEUZOzZ60IPPlwr01BFRxWbsZQWATk+njKfrmXd8fsrVI7YGCJkpdhAQP8m1Q0yqey1YeVfTEVZ42Rp8McT4xr4vR6tf8eegBzK79KmprCcz7xLimxE7FQUjuCJz12E5hFOy3TjdHt0zaw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U3yWa4P+oKify17k57HOCuEVDTGzCQ0JdBlvedOXxo=;
 b=ifjk7RkKHe0a7fwHb5jpGE9GfVDXyWwZsiT8eIDlcscMjRAPMofo5Qt19LUi7ddd+eWXKyCeSXtYlyP7w3I1VzrlrfetqfhwzbpRTMwDyptQoVvg09GBY7jpNLQYWv0Or0j9y6dGF7YwMHY7Z/AwaSp4sk+afn7il+csvaxam/UmCMKFBypWSIMcREd3yt9FvgccliLcWchjkwlDXBBQlsCXX1aTt2mMuDltlmiEm1qK8KVr+pEUP3UOr8a6St0siw/CMK4diVdvWzXOyadFLnEoZHFFbUaaNtAiB8sFJWRzRF+rnTFUEBA+yOpt7243ssFQdPOL1nNI6CXeYhVUCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U3yWa4P+oKify17k57HOCuEVDTGzCQ0JdBlvedOXxo=;
 b=MYGWCgccUzyIm0BzkQ/49Yw13kS4KJxHzJiMxWofWuMX0mgOrTvpXXD2bpzDf50Fnt1Xxn+Cd6BIbyxFX7tH2aRq6Sz+EzxXFSmqJuWTA1Jp85nDYu8xiCthE95jFoZetmp3t8CGGQcwN75YLFDGU/UsQwTelrWYmdR6VBjtGJI=
Received: from DB9PR06CA0026.eurprd06.prod.outlook.com (2603:10a6:10:1db::31)
 by PAVPR08MB9721.eurprd08.prod.outlook.com (2603:10a6:102:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 05:25:23 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::a1) by DB9PR06CA0026.outlook.office365.com
 (2603:10a6:10:1db::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Fri, 15
 May 2026 05:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.13
 via Frontend Transport; Fri, 15 May 2026 05:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEE/iAusG1j5cdbSf9BwM/kloqenLxRg4LFczqEfsovrY3TAF63Ye/nyDMPa0PTcB8mhlLaMEJsU15hcaORF6MdK08hfgcYRucBefKFacMEggh7ccnKBnSMbCDFudRBerut8FGuswWX7LHq17REv0kSAXLZor6YVZjpyq6Fv68mGASgoNJMvlfPmqwS0mKZk9jyGfZUQ9NyF0LNDaL3onGG3WEmA3Cg7h8F43Es1xA/qKcIjaIg15gCrJeqlazAmr/bVKdloIRRim2P3krugT7jWjpjBx7aEk7yQJu9NVwU4P7CqWtOIJuCi6fhEiYo2pNjbyi6kvBcR/uKTzFcveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U3yWa4P+oKify17k57HOCuEVDTGzCQ0JdBlvedOXxo=;
 b=NHlZq1b9A8j/JzEo0i2WaV5+oy73oVZbMWkN4a3QuK9IjaTsxU1wAiy5EQt7pw0Hnm5aRjXSbCFwSmmDuh4ltFDtn+zKExr05mOhZ26cn7wlywEvXCkk0p2oDvd5PB0xPqeYLD70BY1DfjUifhqXNJ3mWP61t+vYefdLYs/pikJsAVBdJu+os3cFL6wgXeQ0G6j9HuJP0lq84DvjOTLef8Rl/9LQFv+6t0qOR+O0Mw3iAPzoTwPWk9MKJ/dxViD+WfNnq36FcBqREjlHP/ib48kxGlsBKa+CVJaZ+k6b3oloNHIXHyK0mjJaciM89guvYxI6L6xEV9l9H3H5N9V3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U3yWa4P+oKify17k57HOCuEVDTGzCQ0JdBlvedOXxo=;
 b=MYGWCgccUzyIm0BzkQ/49Yw13kS4KJxHzJiMxWofWuMX0mgOrTvpXXD2bpzDf50Fnt1Xxn+Cd6BIbyxFX7tH2aRq6Sz+EzxXFSmqJuWTA1Jp85nDYu8xiCthE95jFoZetmp3t8CGGQcwN75YLFDGU/UsQwTelrWYmdR6VBjtGJI=
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com (2603:10a6:20b:605::22)
 by GV1PR08MB8107.eurprd08.prod.outlook.com (2603:10a6:150:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 05:24:20 +0000
Received: from AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::d721:dfdb:2f83:155]) by AS2PR08MB9786.eurprd08.prod.outlook.com
 ([fe80::d721:dfdb:2f83:155%4]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 05:24:19 +0000
From: Justin He <Justin.He@arm.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH 1/7] init/initramfs_test: wait_for_initramfs() before
 running
Thread-Topic: [PATCH 1/7] init/initramfs_test: wait_for_initramfs() before
 running
Thread-Index: AQHc4198vUVCdPd+qUK4ZCIAMqhS/7YNc/MAgAEbJmA=
Date: Fri, 15 May 2026 05:24:19 +0000
Message-ID:
 <AS2PR08MB9786E79D161D1C87AB1C2368F7042@AS2PR08MB9786.eurprd08.prod.outlook.com>
References: <20260514050455.2954509-2-justin.he@arm.com>
 <20260514122946.C5F75C2BCB3@smtp.kernel.org>
In-Reply-To: <20260514122946.C5F75C2BCB3@smtp.kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS2PR08MB9786:EE_|GV1PR08MB8107:EE_|DB3PEPF0000885B:EE_|PAVPR08MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: 7081e7fd-462f-4559-c1d8-08deb2425d4c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|11063799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 3E0uHzMVXJmfR6PSbuT1ZtAmzfxykTUoH3F0QOveu2T+6EkbCaHLh/XL+V8UlG+KFrgr9BthEz9LM3HWXP4ZaTDckaGMVQWCTN3I6uRUiaN42c5uJ6j1G3cw/XQkU++W5cwccrAVqxHRqdCEiSGyHno7OhO6hYDPulxFcAW389DDr1cNLBrd2FSr1wGFGLnmKYR9kHgsnFeb9VwlEZvdYFDCPtXxyLDjrnjUK7qcOr4ks/0VPRLpgi/KdRdjzTQNTCDX3Eei+uiHQa02pShpt5d2FhiOp2vz4MEDMvfVssD3niWPt3ibdqHeOY2iWrYI3l9wdCU+NKjbbObvp1tdbWKTyFbPeQMNdOyJnawm2wNfS4aetJjDwH0FEuI3UOQO9RUFAnGA8SaynVI/SMH77p3RI2nHYVKokWgwji/p34Asi3X0UDch+K37EWgnULLbGreZtgvAVu43FKssqgcmd70QWECe1t6giERSx1kUzetmlf/0YH+AsWX8mi66k/rrc9h3cw10LLIwMEwkut5FUqDNWjYa+1vYAHujJwj+G+O2bMdFAvvtKU2yDAABWueqnF6fUurWTBjea743TFERfrMBtdqyw2pi1Ey0Df1+e2gwn62cCWruDEZ4DLWaBm7dSbA2my1oAwsjHFaCZN4dnsFAQ7mZbfxuFvEj3DVrIcD4Pny48siKfAVAbjpemir+JM2CPj6INDKKxOvOp45AoSeEa1zE3A17/g+vAUrEED47QQv7/GT2dSDvesoSqx5y
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9786.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 KC756z4hH9nBEoxvzc1JI97S0X1Q/569rX7LpCbrWNH/J8jHUkM5irVH67a5nVxXNnpEHrFvakX+V+cFuY+N4mxSPJosBHTosTU9xpB6tSUwCjRDx64oAQXBKscZ6GaxO2qpCs3H96G0kLOtWgVgmJubyDCkG5uxKtu74Q5+2typb6aC6kKyncMNEGq4Oxm1rJaYACskV5Myr9co+DwwxNyxt3mquYsckMrz/Ww1EA/PlXEcJRtn5AZ34cZP2h84Fz5LEF4JkEG3VD8BZ3AVt7ROi5Ag9ryQCwuSsXyXCsKFjhuWhVYS+lCvhbouhvb4DFiWehfbASoP8vMU7HcQJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8107
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b0fb5f8c-5ded-4f31-af61-08deb2423756
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|35042699022|30052699003|36860700016|376014|1800799024|82310400026|22082099003|18002099003|4143699003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3/UC0GN5QqvzsSPu2S3wPG0Gl6FxNcTcvRrz1Jj+75g6T/alfIfx5ISvhMgD1gL7+4m7RjvktIS+gXQASOc5L4zBQ1e62S8jx7638VOGqJu4iQYlKhL/yH6guHPZ1N4Q2OxAAEJZmpZEf9i4ECmQ4QiWoocdWw8jeq4nnn+yxwzpikrIOS5PUBTaIeFtQyiObyba6s4gxoHjyqQKuiOr9riO6sQA6ArEHyJVNDYQYdcsirUBblXtD6izF+7YcUi6LxwjCwPYQ6mzR0BJ/ahm+i/uUFzsAbiDWZjRkHYxo4V6ZEy/NZnDJ+ktbfZRsv0Yz7Ia4yMP/tE9JCZiyoIRnKMpnKT9Y9DL6U7cOaL8y32xDieWffa/epuY4w6QujK+J4Qt0OqzE8XtbqKF2enfmTZdoAuugsVneYlDRUEYYkKhylq3qUSHLvKhwNQWAGkbHsasglKVF+ctw2euhOHQ/EQZhtU1VmQFDxyM6OAeawuncQ2Yln+qtLFQdFkRczNnZxhW9l/9igV2EcV2I6AKPoqj0MNspHMPjmAvKLi5VTFRzMDzwBW5lQValqZnf+dQIO3ANyJpwMGmX57B96h124NC/7bQi1QBIHR51fdGe0fKZA4COtKIFo8KsalaPc/kcSId9ShAIaxtUdEBTCXQ7hPa9YjuZCtds0Ig8JzzpJhkcpfzbUB2zjeIMs3L1yJJNvfC5iHRopCBx7WtrjMHP3q5OAlM5PR6bGm+Fcz2T9I=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(35042699022)(30052699003)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(4143699003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	360mi096xsWUn2Jj4Af+RStHKuorq69ephl1sZsnGQYcZKPPbEWVI3Jo2JT9H6BNwas3ll+dG6pTKnsy9JfICVnTrU83/7mKud/K5KxGeXEbajdIKike4V1IJJ9iVUCWAQLvSfiKWUoq3Ov7Lz3GZrEE84FwYsPNUQ91mDU7v1CRrUUwU4TkNxWIrNqjWg+MpAVFMJd7QrRsv7eYqTPdg8uykGp3NyTB+goadPFCYwiveDC9rJcX5ToLt6bC3ob1vso2i8o3i0gQavti4NZThqhjzDSpUmAHcsAMrG6sbCzq7aQ6vfpvv+js3wgExdrgHOgMWgCxspCSsx0WCYMONdBrauVO081pb4TSZWCDUeMwA5aGTN9unDRbBnFEemQOYD4ruyqYk5zZFh8Zs4BjLtr1hu5rGiOAjDo5rYpaeB25DnRoBDjxeZA59Ydj1nyH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:25:23.5614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7081e7fd-462f-4559-c1d8-08deb2425d4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9721

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogc2FzaGlrby1ib3RAa2Vy
bmVsLm9yZyA8c2FzaGlrby1ib3RAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE1heSAx
NCwgMjAyNiA4OjMwIFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBD
YzogbGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzddIGluaXQvaW5pdHJhbWZzX3Rlc3Q6IHdhaXRfZm9yX2luaXRyYW1mcygpIGJlZm9yZQ0K
PiBydW5uaW5nDQo+DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNhc2hpa28g
QUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlKHMpDQo+IHRvIGNvbnNpZGVyOg0KPiAt
IFtMb3ddIFRoZSBwYXRjaCB1c2VzIHRoZSBwZXItdGVzdCBgLmluaXRgIEtVbml0IGNhbGxiYWNr
IGluc3RlYWQgb2YgdGhlIHN1aXRlLQ0KPiBsZXZlbCBgLnN1aXRlX2luaXRgIGNhbGxiYWNrLg0K
PiAtLQ0KPg0KPiBjb21taXQgMjhlNmYzNzAwNmVkOWEzNTljODhmMzZmY2M1ODc1MmI2ZjNlYjc4
ZQ0KPiBBdXRob3I6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+DQo+IGluaXQvaW5pdHJh
bWZzX3Rlc3Q6IHdhaXRfZm9yX2luaXRyYW1mcygpIGJlZm9yZSBydW5uaW5nDQo+DQo+IFRoZSBj
b21taXQgaW50cm9kdWNlcyBhIHdhaXRfZm9yX2luaXRyYW1mcygpIGNhbGwgdG8gZW5zdXJlIHRo
ZSBib290LXRpbWUNCj4gYXN5bmMgZG9fcG9wdWxhdGVfcm9vdGZzKCkgaXMgY29tcGxldGUgYmVm
b3JlIHRoZSBpbml0cmFtZnMga3VuaXQgdGVzdHMgcnVuLg0KPiBUaGlzIHByZXZlbnRzIGEgcmFj
ZSBjb25kaXRpb24gd2hlcmUgdGhlIGJvb3QtdGltZSB1bnBhY2tlciBhbmQgdGhlIHRlc3QNCj4g
dW5wYWNrZXIgY29ycnVwdCBlYWNoIG90aGVyJ3MgbW9kdWxlLXN0YXRpYyBzdGF0ZS4NCj4NCj4g
PiBkaWZmIC0tZ2l0IGEvaW5pdC9pbml0cmFtZnNfdGVzdC5jIGIvaW5pdC9pbml0cmFtZnNfdGVz
dC5jIGluZGV4DQo+ID4gMmNlMzhkOWE4ZmQwZi4uZWI3NmY2M2YzMDJlMCAxMDA2NDQNCj4gPiAt
LS0gYS9pbml0L2luaXRyYW1mc190ZXN0LmMNCj4gPiArKysgYi9pbml0L2luaXRyYW1mc190ZXN0
LmMNCj4NCj4gWyAuLi4gXQ0KPg0KPiA+IEBAIC01MTAsOCArNTEyLDIxIEBAIHN0YXRpYyBzdHJ1
Y3Qga3VuaXRfY2FzZSBfX3JlZmRhdGENCj4gaW5pdHJhbWZzX3Rlc3RfY2FzZXNbXSA9IHsNCj4g
PiAgICAge30sDQo+ID4gIH07DQo+ID4NCj4gPiAtc3RhdGljIHN0cnVjdCBrdW5pdF9zdWl0ZSBp
bml0cmFtZnNfdGVzdF9zdWl0ZSA9IHsNCj4gPiArc3RhdGljIGludCBfX2luaXQgaW5pdHJhbWZz
X3Rlc3RfaW5pdChzdHJ1Y3Qga3VuaXQgKnRlc3QpIHsNCj4gPiArICAgLyoNCj4gPiArICAgICog
dW5wYWNrX3RvX3Jvb3RmcygpIHVzZXMgbW9kdWxlLXN0YXRpYyBzdGF0ZSAodmljdGltLCBieXRl
X2NvdW50LA0KPiA+ICsgICAgKiBzdGF0ZSwgLi4uKS4gVGhlIGJvb3QtdGltZSBhc3luYyBkb19w
b3B1bGF0ZV9yb290ZnMoKSBtYXkgc3RpbGwgYmUNCj4gPiArICAgICogcnVubmluZywgc28gd2Fp
dCBmb3IgaXQgdG8gZmluaXNoIGJlZm9yZSB3ZSBjYWxsIHVucGFja190b19yb290ZnMoKQ0KPiA+
ICsgICAgKiBmcm9tIHRoZSB0ZXN0IHRocmVhZCwgb3RoZXJ3aXNlIHRoZSB0d28gd3JpdGVycyBy
YWNlIGFuZCBjcmFzaC4NCj4gPiArICAgICovDQo+ID4gKyAgIHdhaXRfZm9yX2luaXRyYW1mcygp
Ow0KPiA+ICsgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBr
dW5pdF9zdWl0ZSBfX3JlZmRhdGEgaW5pdHJhbWZzX3Rlc3Rfc3VpdGUgPSB7DQo+ID4gICAgIC5u
YW1lID0gImluaXRyYW1mcyIsDQo+ID4gKyAgIC5pbml0ID0gaW5pdHJhbWZzX3Rlc3RfaW5pdCwN
Cj4NCj4gVGhlIGNvbW1pdCBtZXNzYWdlIG5vdGVzIHRoaXMgaXMgYWRkZWQgc28gdGhlIGFzeW5j
IHVucGFjayBpcyBxdWllc2NlbnQNCj4gImJlZm9yZSB0aGUgZmlyc3QgY2FzZSBydW5zIi4gU2hv
dWxkIHRoaXMgYmUgdXNpbmcgLnN1aXRlX2luaXQgaW5zdGVhZCBvZiAuaW5pdD8NCj4NCj4gVGhl
IC5pbml0IGNhbGxiYWNrIGlzIGludm9rZWQgYnkgS1VuaXQgYmVmb3JlIGV2ZXJ5IGluZGl2aWR1
YWwgdGVzdCBjYXNlLA0KPiBtZWFuaW5nIHdhaXRfZm9yX2luaXRyYW1mcygpIHdpbGwgYmUgY2Fs
bGVkIG9uY2UgZm9yIGVhY2ggb2YgdGhlIHRlc3QgY2FzZXMuDQo+DQo+IFdoaWxlIGZ1bmN0aW9u
YWxseSBoYXJtbGVzcyBzaW5jZSBzdWJzZXF1ZW50IGNhbGxzIHJldHVybiBpbnN0YW50bHksIC5z
dWl0ZV9pbml0DQo+IGlzIGRlc2lnbmVkIGZvciBvbmUtdGltZSBzdWl0ZS1sZXZlbCBpbml0aWFs
aXphdGlvbiBhbmQgc2VlbXMgdG8gYmV0dGVyIG1hdGNoDQo+IHRoZSBpbnRlbnQuDQo+DQpHb29k
LCBpdCBtYWtlcyBzZW5zZSBpbmRlZWQuDQoNCg0KLS0tDQpDaGVlcnMsDQpKdXN0aW4gSGUoSmlh
IEhlKQ0KDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwg
YW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2
aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVu
dHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUg
b3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
