Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F423C4E6;
	Tue,  3 Jun 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963868; cv=fail; b=T5+hgIe7KVfI1oufqSbPsNSYVVz1k1jUxUmCBC4Wu0YQIRi2JpaddskjrpxYdu5T1yqz7dDbZ85WF2WBCviEGI0HV8ivkJqPnvVe/4WW5HuptrxS+gUsun91gVErSOoVNMKB3Gp0K/MAojZ6rnt8XWBifzlzxWgt5Dbr3vQ4B20=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963868; c=relaxed/simple;
	bh=9a5sQhMRHxjZVLcZwNOQhjol2xjeIOuYpcDHYQ2x90U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cuQyQ3y6XxiloNvFY+jmd+xm/pdUgEx61gHFXxK3+HoL/2bs6jHgyA6HOF/k9ZJD9vGagk0/MpM24ZCF61VZccMh3EPB0KVftC28OU6BHXlTJmM/sETMy/85ggCpuuqIlb02fV0XBKuMnt9x5FkOPEu5o20w4yEjfGU0Qk6y1e8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ak6CZK1z; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ak6CZK1z; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ak6CZK1z";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ak6CZK1z"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rcK4AieI8mWlDApDTZcTwcqmyGwoqQP2ePEozGCxeKU8sRGKFer0uA9Mxu+M4Wr5wHH6w2fQg2UqHm+1QU+Gri14VtdoznQVFztAo4Rl6BLmm9BYBr1WwXDmZQVkWGEkrihibyDfQGooZg27xn6sbrcs/Sjduwcbg/eLhktFeocAiDuZvkcWzM+kDS1Mj/w15iUT7nimTzJX9/lXXbmuB81I2WkOCgBuqSnu2dZqfPOfGb7e3OK74sGL0imhEK63RqWObVnP29rxY3rDtkEB4A4GNDCq/3PIaUar2Mp7CKnGZlh1jFrpW+ExwwHhOjgcs3r724py58nj1Hfs6vpHEQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbd8ASjc8r0EvUaKg4e1ng1f3PEcPGoe/EcBwDI3CTE=;
 b=qqHh8SqdqCIbdsqgEeDsq7QyRAovJuFT65ECvM0e4dEBFIAZmgM3gmbLOkSpDeS0lZW/NXwbIMuxeFPxZn4/ww+TWYRWBeRwoV0JExG2Y3rT1PDNWdZqF96rBZl2sOnS5sr1VRzDab5tO7KeBabLXqR6nrX4+UZdleWLWAXhGQxpRKVI13JQByK9Y8eEh8UgRP7JJajZa70HegGN63XJVqKmQdOeyz7ORjCZHkeCeFTJ/oWVOk/wEKgnig2xUjpcpO/JtoUDCtKE4iTxkfEPAA2WYYPkwcY/Hl840AwucCSpqO41emdexE4F68kXQ+XoHLH60naK1kEwZx4jVT9bdA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbd8ASjc8r0EvUaKg4e1ng1f3PEcPGoe/EcBwDI3CTE=;
 b=ak6CZK1zMe/8olgWkcEXW35i+OtAemdtQ0e3eSpsbOw62QE2rWXBxnonJ256JONVrMKFIO2rWYYLw1CkDnsBuQakmGQxOuwLLa9eC7g6IZKwZSt1xe/3XXIV5C2BZ6mUXg//hT13kwtozIfcSz727auuqoAzg4iYhPmFYOBjBxg=
Received: from DU2PR04CA0211.eurprd04.prod.outlook.com (2603:10a6:10:2b1::6)
 by PAVPR08MB9436.eurprd08.prod.outlook.com (2603:10a6:102:316::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 15:17:43 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::a1) by DU2PR04CA0211.outlook.office365.com
 (2603:10a6:10:2b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Tue,
 3 Jun 2025 15:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Tue, 3 Jun 2025 15:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHbmIyn19klCxXvEc/27eevqUs1J/tduO0HN8RnCoVhbnVtW8oaHBM/NTGQEFZFTF43ESDJ/FEsJLi9Vlvic+hlWF0NOeczdoI1PeombfaIGKAU0ct5nsmSF+foPYgtiCUh76W0E/BqfdJ6HuN5oSXgJ0mrxt5id8jQ7LnbkZNLb/PqiQDgcaFe7DLpyqLFiRqMCXoJVDAh4KT9S4klwBP82w+HPDX6E0XlS3SQZCkLM1jPd4DEKnr56JYr/V8aIyB9ty02lPVmHehqydpMPQTlG70kORUthooEJyPkV557SbFjbWRKVSm+j+OjUZ0EPrcxsqX37v81ICiQnzumoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbd8ASjc8r0EvUaKg4e1ng1f3PEcPGoe/EcBwDI3CTE=;
 b=KccFG9/B4YQBmTDGaSdbA4X6pqjclXLPMhBM4FrzlBeSdXG61tLcSdfrn1GTvprqxoGUvFctNUxY6LJcJ47wp4SebkRZTWkUk50+dE/rthhafnZjwCdUMhxegE+FNezDmd7xC3072/RonfbAiadsCE8YKDJldIAkukMt2xVv+wlnWEti5HdDZfxDoxkVg2BGeRZVASVx0vpJvXoV+oRGjcpvQgOvOTCbaV0kdZU/dnudU6I2iSiTrgggD2LFZn0pt6er18RntziTbAIfyqaS1dJmSYE25V2dUOmdhh68yuHlMep1qmhcDWtLBxrMiWi5DeVVWtM7r5NqN85mhR6jAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbd8ASjc8r0EvUaKg4e1ng1f3PEcPGoe/EcBwDI3CTE=;
 b=ak6CZK1zMe/8olgWkcEXW35i+OtAemdtQ0e3eSpsbOw62QE2rWXBxnonJ256JONVrMKFIO2rWYYLw1CkDnsBuQakmGQxOuwLLa9eC7g6IZKwZSt1xe/3XXIV5C2BZ6mUXg//hT13kwtozIfcSz727auuqoAzg4iYhPmFYOBjBxg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 15:17:08 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:17:07 +0000
Date: Tue, 3 Jun 2025 16:17:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Leo Yan <leo.yan@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <aD8R8Bke1KZifJDH@e129823.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603144414.GC38114@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO2P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::29) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB10291:EE_|DB3PEPF0000885B:EE_|PAVPR08MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d5af25-f9ee-4efa-60ad-08dda2b1c7aa
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?98BxxhOl/1xe4RtQHFtqRqW97glTxMPeGSGJK9Zk/eoDQ8gmP6Sin3E3g1Jn?=
 =?us-ascii?Q?7wUT3Bsojmw6D2W+qmy1kFNqW1jIpHntnzFGawEnsGX644KyUgWcv1NnZ3wY?=
 =?us-ascii?Q?g7vZsTQmDcJ8UXVdxjg7hJbIYeUub5l9xthvkjDdMv9ggWJQB2EiOECk6oB8?=
 =?us-ascii?Q?mp9fG5WxN0t8ja0mVkThP9jyOA9v78atOCmQSelpCLGLiTxrUJVjnZsS62II?=
 =?us-ascii?Q?9rFm1MtSrP8Nby2Nz1YfM6MMFIX7V4F3CX0TBIzbUUU0p/uqZdFP0T+GNkJb?=
 =?us-ascii?Q?mftkGzPOuL5a1aOW53flgYJlH1/SnDf72Uo/IOMPRRbxEln8ozRb8I0G6KSk?=
 =?us-ascii?Q?iLr5ykiHrJWD6lu6YqTRvnUFNVMml4vXxhhjX9t8kXfBaHu4zIKJsTW6dzOH?=
 =?us-ascii?Q?2GgzKURY3jmB0kEQdHxhwW2Py+oczhlqh9cYagIOt8UxT4O1o+13Wide4r9h?=
 =?us-ascii?Q?adkk1sofNyvrRpGWj3UAq+zUOMq23czNBXF7+BwQVUYR+xzlPB7cWhlGIOWx?=
 =?us-ascii?Q?kKxNB99Eq81tCXY4D+MSCvfr7W8rGI4l4eDDfLsnqkBJDa6bwu/azBY+2Yq1?=
 =?us-ascii?Q?gzJ7IZLmblYn9Eo3xQuH+7TaoX6h3P4UL1pkxqika+bK36jZoHRZSf4qRjp4?=
 =?us-ascii?Q?KWREGPZXmjAXhQTwDthGtvRSZlIlyknNy1KNaZGBWO0wHLodpyO5M7q1sD7b?=
 =?us-ascii?Q?MiywCgOdsbOGzoTvotduDvWODxBFLZixeB4o1rKjPqBqWJ9zZwbTe/5huh0B?=
 =?us-ascii?Q?orNEyQhCBnkfgPuUzReDsnFXAG+zplA4v65umFMcpKkW/qdtQnnp3eu8oEmp?=
 =?us-ascii?Q?Uw/LhDKXNUUVzfIcUp/jsxHg00t8OgY73ouyx5lzJ7ZBScfwcpvLE96ke07s?=
 =?us-ascii?Q?KvCKt+cQ+vfyLLP8Qc5Kt5LHTQ/AkM1/GdT/rvoqBivftC5jlFV8dkHtjmcj?=
 =?us-ascii?Q?wzeN0Yte5nGl5fQJmzrxXWrcailF6WSJR3ue+Ib90lWs6AgblLz4bZZuqKYr?=
 =?us-ascii?Q?IW7udLc2xGPX4aAUrnL4bAIDHq/zs7jX/ZjL9TZMwpU70/rYrXW+GMtwUdQR?=
 =?us-ascii?Q?otao+At/R0gLly/HeNORXBJ4YCQ96FMJ2BKFRG/qaIbBYKn+Ty91cfjVerNl?=
 =?us-ascii?Q?OXNlK46advR4SVYGDEzrHdeCfPr8OkMjYSGEh3I266MunpJMems2cLvBjtsz?=
 =?us-ascii?Q?1lBe08CeDTDzuHearPAapUWr4/RwVAgQKjKMjE3TuhUy+22Bm2mN4ujQwlQF?=
 =?us-ascii?Q?V/UV5VsX+oXlgRJk5rt8Fps+3bSVWslewhiMFOUtPHiXkrLcAss6pixHyMoC?=
 =?us-ascii?Q?XW9Iy1YSWP7WJ130tz4mtPiTWVloc8k20b4qmKoYEvt/BHFP4QHy2tgb+2yh?=
 =?us-ascii?Q?3AWaONz1zcEoQB4qSWDdU1WYU1Jv4kRBOxnRHF03I0J2ADUxDg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10291
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a92478ba-9195-4be7-0759-08dda2b1b477
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|35042699022|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oEx/beW+0cQmWeHdbcm1PLXuw8mxot7PU18zXL8pW5GrejSevYUuerZ0vwV5?=
 =?us-ascii?Q?+wfhXGpRWHDvLKi9uzb6r8uKnaeQq9/cc3f5SOGDwNcXK6382HIGcXDyGg4Y?=
 =?us-ascii?Q?xHDf4KWCA048UfpA/9aP5ZRoLxT/yPWFYRoStwndwbyb+MPeEzYm4fId5WLp?=
 =?us-ascii?Q?eOx1SpjSgFQAL3c1s53evBxmoV+Wje3hT/ytrKfERCqsD7Mqb3fbsvH0THl8?=
 =?us-ascii?Q?upCsfyYiCI8TCOlqm6xjJU0l9oBmCz/LHNN99HV2XZddsNE7p1GBMlBYKbm+?=
 =?us-ascii?Q?nEBKTtyIft0qnraV2kT0Ep38gbmgn1BbDwQxXEjX/TR2jVyvWZG+mfOm3052?=
 =?us-ascii?Q?ihGtYVluioCJdFwwJ9vvPpnBYjUn5H/PPaH9uEFgZu1daBNY5uprNrZyfqVD?=
 =?us-ascii?Q?Jl3XlEkmS7dXhkKGzES7k8MueEugfBws/KGsgK0CI82Hkbai1hvy4t3bzwQR?=
 =?us-ascii?Q?LbXcSzljItjvkoIkEV3NM5UkepIV0j2Bnheo6iYcN7QL9ou+r7NPE/kyRDkH?=
 =?us-ascii?Q?kNmdG97Fb4WpeFP10Un067MUfFXWaXgUeFptsUbosFOd8V/uG5t/wp4D5BV6?=
 =?us-ascii?Q?0tgVbm5/mmFD0TNY1zMd57dc/YASA9+K2vfj3G1PXkDk9nmUpB+7UKi+7P5H?=
 =?us-ascii?Q?30NOkFRyJnK8GEiRd0kXfzc31NBH9qp0QPIgbyWhHS9GtxFoGIReBIYveboL?=
 =?us-ascii?Q?3XXQTJSrTV9sIT7B/beBpaYfoPB3V/WyPj4qr0pPVs7POvaXwKqmKlYAjU8e?=
 =?us-ascii?Q?qa2MGbhQ+fWf66JVOQjyeKxLJ0mtxP1Uqc1lsnbr8yjZzEREYIbSzYfY4PWD?=
 =?us-ascii?Q?BmDj8WrZCOYQeZYvySGSAETRVJqpsBmCeD4cQftrrfEbc4sPsMS9wx9Cs32T?=
 =?us-ascii?Q?kaRmL/m9FmuMVJCPmmgEk51So8P0Lot91Jc6sSpQy5fUkg1IRcAcPOMA1Ybx?=
 =?us-ascii?Q?ueMevKjasidcy0vOzRU0D+M8Nh9+6P3WMIREBDHltVhfT5pareqEJ8wEFwW0?=
 =?us-ascii?Q?jFUSNHs0ajtIscNbXLQUU5LndW5thRwhKv7nOjv7oBYQ6Svu0W5Pg3oJ5DZR?=
 =?us-ascii?Q?eqQ0gEjCtbGCW/K8oWIraneZTnv4e69N4lZf+/logx04YFk+AjvPO4xdrgJW?=
 =?us-ascii?Q?sM5zNbibyCNJjNRtHtqc0sL1oPzHBds9DOrnCnokkuh1apKwOk9JNh2gML7H?=
 =?us-ascii?Q?R/8zkMZdvHfIhFKLpe+DzZFGlm3Ma7u1JKDviIDQfFVWgZOulzJFiub3sqKm?=
 =?us-ascii?Q?O6SnRR6lB9yCESCP9RqJULQgdhDvWe6ScrSoJTn+nQ49z9ffijS12vlx6T0g?=
 =?us-ascii?Q?zcY1rokCizDBVfMb7bsp7byAxMGeLfC1njc6tuxuXjh9nNVRuK6V6ZE2JQTt?=
 =?us-ascii?Q?qcth3+Gx/kkPvB7tYMxf7YNTDa5JN+xVDLtbsRw9iAzgixg1UmhfgEvgTwgV?=
 =?us-ascii?Q?qx5DVGrJihARXNnX2nclIZQwkH4NRP3G7fUIACZO3byzZ60BItxENjrvc5E7?=
 =?us-ascii?Q?6eAXDYrXxvAwZP15bEtXtK5LMsaL7XiVN2AC?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(35042699022)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:17:39.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d5af25-f9ee-4efa-60ad-08dda2b1c7aa
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9436


Hi Peter,

>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2120,18 +2120,6 @@ list_del_event(struct perf_event *event,
>  	if (event->group_leader == event)
>  		del_event_from_groups(event, ctx);
>
> -	/*
> -	 * If event was in error state, then keep it
> -	 * that way, otherwise bogus counts will be
> -	 * returned on read(). The only way to get out
> -	 * of error state is by explicit re-enabling
> -	 * of the event
> -	 */
> -	if (event->state > PERF_EVENT_STATE_OFF) {
> -		perf_cgroup_event_disable(event, ctx);
> -		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> -	}
> -
>  	ctx->generation++;
>  	event->pmu_ctx->nr_events--;

JFYI, this removal should be not included when you backport to v6.15
unless your patch backport together:
  commit 90661365021a ("perf Unify perf_event_free_task() / perf_evenet_exit_task_context()")

Thanks.

--
Sincerely,
Yeoreum Yun
