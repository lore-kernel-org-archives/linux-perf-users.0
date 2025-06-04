Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836128EA53;
	Wed,  4 Jun 2025 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041718; cv=fail; b=ELlh8JN9aDDmxrI9oSXfKoXt3nJ44FDxJGnpswEz7Gm9L3L5fjKmKpZra8IP5ZbAQt8FOJOHEDTbBOuHYApd+q2Ywez6HlWEUbfb9iv7oslsXZm7nrkoILUvTDsVJH5Ds/un5K42rqpaEgqpEoVEWsjNy80EAy4c9/CBbqqXYn4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041718; c=relaxed/simple;
	bh=cuZyO5KbqgHQJXX1CtzevAsy06/j/0dXTzOXr+6OAGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z3m0auxSyKlDb44fYefq3ARa6IuItGsRrqqC8k7cEQ3HUdbTzHeMAtMX7O9lbrIeeNNeAFzJzSvtklHZQhq6PkajEinygJEWF60BHrugM4AclGlRIK9GO8YnONPQWie4dCtqfsFOIV27MK3gdptS2dlLCwid6Jn2+dxA0/fjqbY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XVrnjEKC; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XVrnjEKC; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XVrnjEKC";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XVrnjEKC"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=X7PqiCSH4PFSjwtNgOKK8a6BjoG37KA4/jqBWJsPbyF1CdTqO2NWg+9eP7SxZSipxtb5ifp7H6wAfY637tw+vS6EGmTNeToWtR62leXwIhS/OBo0KaN2DNWJgdAKxJCEq8iGDBJc3KRp6jVdPMsZIPOuqOeieyorTxHII9jsx1SPxP1G0jkULFRifyJoGhXBz+DHv2YS7rit3T9ziLQCQhrNRps8viThW8OdZPK2HOJPpSu7sDbsUyiyG1HS67aB0NWr0CflRKCxYcdEQ+Xywh0kFtvHcn5cltHeMN6wgA9M/zPzEOJhebQ+Et8PdnyNl1jAbsguOjlDI9YNkmKR5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuZyO5KbqgHQJXX1CtzevAsy06/j/0dXTzOXr+6OAGQ=;
 b=mUZMChWPI16zf3G8jSVmLqx69UqO13pWxsAlVsItPbEbDA1mtlb4zyLtf/ncSKacbvwUiRMV1MF14OeyFz1mFrWQvoEorUzradU75Y00lYhjCRt5P52yciZkDtLcfmeOf3hpwlX6Kf5H2L4yimtHyPq1ZYouQ6sB3soAe35dHobWTlJkXwXAzX2C+0XPjO3WeeJDZwDRdgu9kcPuVX6l0sjpqLLTn5E7As1Tcfet+J0T8BCjIhrZi1IrBefUI1EuyjqIHTow7OpBp5FF24JzT8em2XHxOmYZDd6AqNY+B6LliWAlwRr+AjtYJMW0OfbKFbalLEYRBCzZgSze7kiT/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuZyO5KbqgHQJXX1CtzevAsy06/j/0dXTzOXr+6OAGQ=;
 b=XVrnjEKCB4qPCG1WqQtAUMK5QHg2S1eIk5C320/c63NUFE9XxZ1pTdbjTp8n71+uujJORfwmVls2dEtfmgITdPKiqYNLt+4PYURg0JOQjJQhhuFhmpvrRyk6anX/zy27JrYMr0BiQJVJDu9R5n8UJDpCCdcSGs/+eA++SSAgT+M=
Received: from DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) by DBAPR08MB5864.eurprd08.prod.outlook.com
 (2603:10a6:10:1a0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 12:55:11 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::fb) by DUZPR01CA0171.outlook.office365.com
 (2603:10a6:10:4b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Wed,
 4 Jun 2025 12:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Wed, 4 Jun 2025 12:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSDmvj45VqKXjcPMtYk48I38xtECdCFIaWUfN7Ek2BErnbXlf4KDJ15sn41zDdrG2sRHBKpJDE/Pkx7sNNDCy7hYxskvBGtAzK7mhy1D8o6bIk7P3z45YmzPiEp3eobz7ofLfcfKEpzz5IqlFT1sKm99pDvU0BCSTblB+go/Oce7EE87CPWDvbjLjdnK5Hf99eOky4uwK/D/JB+plllMTaIl2i18r6VfxPwCMSCogKKm8Ebq9SX2Yo4dz3pW9hLdsMnVtVF06Xbs6ds/4+LrZfAzDKedAY3C8IouezsIKYG5XVKKfN81M4e+PjBBOXdpfNIlqysov/TteqLkv5M+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuZyO5KbqgHQJXX1CtzevAsy06/j/0dXTzOXr+6OAGQ=;
 b=bTI/xMuwIYaHcY7KxGe1l2cXFDvBtgeEGO42mbS6k5MPeNSq1F02/agARyv1WqWZgYMgH9MiLNwQ4zxJkfgQXnuht0ha4yD57ogXp/ojh6WL1nvr0hK0zBqnIuBkbnuWcgC8lVYsl/BdkvjBmkbX8m2J4mJo2WUtw+L44tOcCNbKj8qSzW26Nj7QK0s33vh0tkvjhe27qujheI3ikoDJ9MxGhAlTzIA7QZtcsfOhyByCBHn3zQkgcM/pxeQc50hi+XPK/QGx1is2r4V5WrF1QSWiI32kmu89px8mfPDGuoEPX/g59KxZP4do7OBmEyfzz32CzGKG/oTuMuHZsJX41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuZyO5KbqgHQJXX1CtzevAsy06/j/0dXTzOXr+6OAGQ=;
 b=XVrnjEKCB4qPCG1WqQtAUMK5QHg2S1eIk5C320/c63NUFE9XxZ1pTdbjTp8n71+uujJORfwmVls2dEtfmgITdPKiqYNLt+4PYURg0JOQjJQhhuFhmpvrRyk6anX/zy27JrYMr0BiQJVJDu9R5n8UJDpCCdcSGs/+eA++SSAgT+M=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB5682.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 12:54:38 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 12:54:37 +0000
Date: Wed, 4 Jun 2025 13:54:34 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Leo Yan <leo.yan@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aEBCCvKKS1OLP1Z0@e129823.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <aEAau+v4qBQSt13s@e129823.arm.com>
 <20250604123725.GJ38114@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604123725.GJ38114@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO6P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB5682:EE_|DU2PEPF00028D11:EE_|DBAPR08MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 19618585-1808-40ca-a1d5-08dda3670a8d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?AHmm+Vf/TtYaK/7A2wAZSc+o0uqui1r8eBfRkbi65YJiGlWoW2ACA/tgE2nL?=
 =?us-ascii?Q?InJLKUjMlcEeRh9db5VfL87hr/jQh3kMCCVaz+wjbvrXO59qcMZIHHcya+c0?=
 =?us-ascii?Q?NVz4xpdyUJtRUjPS2kuZUztP/4GSNGw+HwOpOTVCjHFA8VsNWtqbcr2OJZnu?=
 =?us-ascii?Q?HZcqaYXLrh2jdrlJlo0vxQD69UfP4uf2QiQGTYMl+11Of7rQ6slFpVQ6He3f?=
 =?us-ascii?Q?sC/SdCf87GhjvlKFxY1EJi82j4iS7+n7MyGnMYv6AGIGnKDa+S+vdmfR8CCG?=
 =?us-ascii?Q?BNrYzwUbHXkWFmumNzIrzBpwaeivVxvzBDsLOIordjfgrQ3DsY/enN8VH19K?=
 =?us-ascii?Q?xlRp2al46PfMUsEPs1BemkanXPHykZ0hgoW0wuwOGTw52vymS4hZBIZQhe8M?=
 =?us-ascii?Q?djejdiO/vPqqT7wIAa1iK9lKJLDsiZR5tc82kLv/XHYLFgVZciwXjYoMwtjb?=
 =?us-ascii?Q?PnHmx7AyVkKVB0Ul1Pt92G4AZ41N+iYUEUGze5FSM/bbcavlgdsNgGJHmQQ1?=
 =?us-ascii?Q?0uTjMcqs8zA3mj0MZk28mcNrwv6KBdxl5BPrHp7G4iN6g0BvJFqI0oJ4AiRj?=
 =?us-ascii?Q?e8GOqTWkzFm7r6je5xCv4XAr3iW8FVJJ7FWQqNtbnjJEwGmtk3+zJyFYEcJn?=
 =?us-ascii?Q?p743UQAObDPCsTrJqhY29jj/mU5u77jBHO0rKZim/ELILizOk3sFuyfcZUbl?=
 =?us-ascii?Q?wT2IvwXhphoHws1l9EO7BxG4DY2LT0M1X5ZbJEZ6Aa98iR9ZclICSMb9A1tW?=
 =?us-ascii?Q?KKguts3ZHnZQTX2vr1pT9KFr6D9OkLIwArTM9st3TOEvzJGJziCfRgeDpuPg?=
 =?us-ascii?Q?YRvG/WKiDXz5tDYuVRSycPJF/fV5HcxznEpHkHiuedTAjDhCVgXH7nctF6p5?=
 =?us-ascii?Q?XSPEMbOBcSDz5NDZhKsMIkrHbqM/xQ4r/8K0eRtHQUzFUSrBq70RTsyw4S8l?=
 =?us-ascii?Q?n4OzapSMy6ucBbyZSQa/gQ2hg5dhw9llqFDQFssLFGybKF+50Lz5CWAlGqEf?=
 =?us-ascii?Q?/4NohAOmFFRbFUYQ19tb+EsY8PrUa3MtDSc+fA+snUwB8ZWXejab/JC/Id5j?=
 =?us-ascii?Q?b5JY8rLC7/PZXhyWsG9HE6t+94xR6gS6SV+0JL/q2vy5pfpyV+VvuaxQ9pEc?=
 =?us-ascii?Q?HdaqdkZeOeTcgHflLsDExd12xWXUroqC8w/EA7YdAvd96EfeKWurHV6PVloF?=
 =?us-ascii?Q?86RHHk/oBIrojp4/xxjIjzs0Cffa7z1o+Cdcckl92LYregO+4xpeq7+9Q0Pu?=
 =?us-ascii?Q?Ga6ab1hu4tb0nXqLJTizUSen7KzW4iKGxCKgSui2sxRDmxDBL/2si+fp4q+q?=
 =?us-ascii?Q?d9aZ6IduopY3gzZiVSQJrm10Ui2JH/ZTo/PezQ9y71DdSASbCl48uUGIQx+z?=
 =?us-ascii?Q?/QwtF3hj5IzWzkfqg2asLyYlzAejuGwMBEIapS3Nn1l++Er/xO0/j7M0YBQP?=
 =?us-ascii?Q?B438vinDSn8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5682
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a707addf-88e8-429c-04f9-08dda366f650
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I/PbGoOzC65OLRVY7hAZFbUGKd+sklUBrHJsHFEmacCe1y+kn3hAaB+l81u+?=
 =?us-ascii?Q?CFUinYD1RzOJ8sqc+/EAiyJElEGtFJMDvd2vI8Y1lv5Tb9Grmjqmoqj4mLZT?=
 =?us-ascii?Q?fXAB8LVqBKVliT8YeG0cx5Bi+nvAp81Rnib5E9J2k0E+BdnxcwsXIaMI481b?=
 =?us-ascii?Q?IiToR3CWweZ1bJZfkErORg01oi14dIb/PlW1Y2/mYgOzmb+4xyXwgP/RCVHv?=
 =?us-ascii?Q?PTqyt25u4QkQQJOaxjKDAT7aGBwJ8KVuroxiFQEWcunC3rtRlDi9n7azoVsB?=
 =?us-ascii?Q?dOuG1/uI6oRzJV00FQUNMczCWVj1WziaBrGdDNdo2YDro5Kj9kJbY3wA//po?=
 =?us-ascii?Q?onAZ6a5Gey5PSlJuU6Kl4FVc2d2hUr1kdcsJv4d0npqG+IUMQa5p1E37DP/t?=
 =?us-ascii?Q?kq66Lvl7pTDXuDGclP2tuCZR5+5O5lgf2znfSr9cAlMehtSq6NYf61janAOl?=
 =?us-ascii?Q?xKbOzaO/v+Q9w6xA7LME1p3BRfTEvqgoD0MXISTJediGoikzk/IYL7xFdGnt?=
 =?us-ascii?Q?hd1csuh2k2t8dT9ukbzo4/1YHU3gVCgVxwM0iPaYQw2He5jyS/O3gWCfqqE1?=
 =?us-ascii?Q?tsIbaF32zxZAKs2OTXGhpLhlhvkcJbHY+t9IaL5tpvsjI62Wxdmm+QF3+dRG?=
 =?us-ascii?Q?yMLd/AKSeVCkC/YCPjAAqrSOEEn2/RtTF+DOL7sW0y+e6BeNzUXh33qh2bdo?=
 =?us-ascii?Q?jOmUb1PotCJc3csELysYw6V4yT7LokyMiTQm5095NG03esS+xo2M1/DHotzO?=
 =?us-ascii?Q?CzCPZgU/f/8QTdFHT7MnLkmXxJG6GpHAT7QoU7dBkiBm5HnPlVschcHVky8J?=
 =?us-ascii?Q?h7dTLH1upXIrZrg275rMiBeEte1nlT3DMldJO/qeBntATYSNm8IrncUElzci?=
 =?us-ascii?Q?RwOCwKJZwmkXE7sAXA18ssE5pk+W2dw95K3+63WvNdlLnG4/zhIvuDXr/3iK?=
 =?us-ascii?Q?xvSuIK4rJfNdrGNzQNe7ZdSPV54RzP6f9U6CS1af6DsheW/+L5OCSyqlI6vn?=
 =?us-ascii?Q?5SJP0V4ypH+qQanpbquaP87WWTfJcZ8Cbr912ybOoyPvPzXYaOHdGommWBTR?=
 =?us-ascii?Q?AFiEfmzt5bOqB+alt9nNpsDJcPlF1MPDnafhsejKyaqjY5rhtdocaTzBlFId?=
 =?us-ascii?Q?tuA8Iwzsctm7wNwRlmqHUEOAMCyJ5D/Nm4ti8ewjz1b2BnRk+IW6ePB4PujY?=
 =?us-ascii?Q?Sfad69EAsDRCbpdPp76k6Bbh3TnkYFDDE1FfLYYvWRrPXsE2Cqmzhe5jo3bv?=
 =?us-ascii?Q?5o6JakPH6Im8YN0OT/fiCudZFAtqhpGylJxGg9UO6hWPDVyL6n3rahdkqTtu?=
 =?us-ascii?Q?SOKSuiUebr8SQKOizjoNHXgV6OYCBtuSBIfsfCmifwAmdai838E+ftzwqPTa?=
 =?us-ascii?Q?jegvp/yhwCW5rB4ktRxqb7NVwjgXx7zEv+a1mvs86Cxw0rhRB0qFKhEBAuRO?=
 =?us-ascii?Q?AhrByS4wIfKOs41mEPoQHE0poB70V9lDVxyUp1T4UrmZXRO+IaCjtaaDRqMP?=
 =?us-ascii?Q?fOHXsCwzgxhGMjaaqQtQXYltlBxBKTHE5fpJ?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(35042699022)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:55:10.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19618585-1808-40ca-a1d5-08dda3670a8d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5864

[...]

> > But suppose the child_task(2) try to fork (child_task3) and
> > inherit the event (create child_event(3, parent_event:0),
> > and at the fork, forking can observe the parent event state as "EXIT".
> > In thie situation why child_event(3, parent_event:0) should be created for
> > child_task(3)?
>
> Yes. You set out to monitor the whole hierarchy, so any child created
> after the first task should be monitored, until such time that you close
> the event.
>
> Notably, a fair number of daemons go about their business by explicitly
> closing their original task in order to detach from the tty.
>
> Also, per the context switch optimization the original event doesn't
> need to stay with the original parent, it can end up on a random child.

Ahh I overlooked daemon case. Thanks for clarification..!


--
Sincerely,
Yeoreum Yun
