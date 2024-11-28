Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59A1AA1FF;
	Thu, 28 Nov 2024 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803847; cv=fail; b=FCyHU7/Y9W0pxUf9EdE6W7YmcaS5yrLmBrF2ZyuvLdqKCjjQHZ8qoM/SWbvAtS1L5w5uFQKTYzn9ey+jYXoFN/yMNHPjntPKJQPiyCZTyUVa1dvd54Xd1nc3ZOfSMdr5S4qWGZMIeagS3v/oZRdv7cbX4QbSuARk9FnqgCi3ncw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803847; c=relaxed/simple;
	bh=PTJKcYTfZCmkhDtwuoHz2d6ciqPVM44xUYAi5FsQG78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lTFZ9wIaCw/UEuoRkHV0HOiTwAHjHighNCWyB7oPrTFUe2ee13ifcFhiviyHNe4DwjDsKY7OudN9PGta6Lg3gFVMFuzhMdBNRfXpqzSUp1GpSw4GC6gHzCWA8b+LoutefJEHWslKpjvhQnuNM1817dA3MIo2fFuq1piIkykH1r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hMTrZhvc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dBDjuDK7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMTrZhvc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dBDjuDK7"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASE12Y4027974;
	Thu, 28 Nov 2024 14:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tYneniVZWVqK7fYyB5
	99je/TG1sn9CueRu2eX2Xfmxk=; b=hMTrZhvcMnaKm/znhd5GxLZw9n34ppgTR5
	dSTKmTTM/h1s/IrdffKfyXeo+y3tXQ7/9HVemCtcDiOyIHvarecHIcdWF+/LO+Vf
	8p03NMKgrCDDfG4K/TQtQl4pDrdjxycIuJUF0zJ+X7hGTapnmeVSLwYsKF+zaInc
	+JEXGlj1m1kFlmJwsYQ3yJSxDyNIoygk/uUrXMCHjl9qCLuvchOMg3qaVEYTJfe1
	Xi+sJXMkM8auk79GJ8KWvsc5/bFagK5GnQ3KCaF/6H5IUmNa2t1Ee7FEX15JaITC
	LLYx83wnOVTv5fjS3JYGeCDMWLGlNSKuqrujPZTBfAaVwjp8BYnQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xw9xwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 14:23:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASEGkfk027564;
	Thu, 28 Nov 2024 14:23:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4367045tek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 14:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZUBPF8l9rZ6EHhoP+arQuSdUh9PEtqpZ+ZnfStelYifddPx7FrJS9EVLQ93kef8Kug9EYlj9B8Lxn2PaIbapBrfeCaL1WOXkPOstbWKgyR1cScC6fw4YeVVIhBGm3WwI60TaeoO7sBlZTxJoSz8IAE+zctlhiNgu8W5VW4s60PUeAhzW8rU2Q95lfOvoK69Y1lscd5uGEFTP1SJP9PEYPIAL7s6EVA0UOo+G9M5bC0FiYitPtKLwjfDL3S2QYT2FBmxNg3Sphvi1uKeof76PO6RG8LXQvz+kYd6NWQuUHbkNv22usq7Vt3WfWWF/PfJJ49SMFzkl2qlRxUPt0z3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYneniVZWVqK7fYyB599je/TG1sn9CueRu2eX2Xfmxk=;
 b=HVXY5l+mW7/dJCfOoETK+qXyF+vt+seLgEN41MxNM9aqAESxNqvzvnLK58yqYdHd4NpjPCgxs143jYl1tE64REQbttOWX+NRhP3yjg/uYR3G/VukwOunPFgVwZThjvozpPuHdoQZwqaP4RWcQBzlXHHMRLlXfMG8Ny7YO9WXe1YL8p88VYpyEHIBv6xqYRONoYWcOOjo10mZCqfTVQiaZISISyMmXBhiliNxDqbs2rAfVl2WEVybg8H/GMtaJc4TVBYA9jTuxjW5DaVt8y34BmegVfwNWnKov1ZBElHntLmalsCc/Kt77GI398Rvo/uEREaBfi93g58vWiEIKgAzMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYneniVZWVqK7fYyB599je/TG1sn9CueRu2eX2Xfmxk=;
 b=dBDjuDK7e/CwuR7xvY52TDir1ICg4rGVRpNkYGrOP+OzNWapAIprGOpvBtuKOIKcR84ZlaJvUOvqCeLrZa4whtpqyqL3KLvK5Ul8222a0chsXmLDy+anPJ7u+RRZvNrxoebjiOSPxhNRFvmTn0HgriuPrQGl4FNKpb5rByJ1wuM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7558.namprd10.prod.outlook.com (2603:10b6:a03:549::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Thu, 28 Nov
 2024 14:23:41 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 14:23:41 +0000
Date: Thu, 28 Nov 2024 14:23:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] perf: map pages in advance
Message-ID: <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d31906-cfca-408f-ab82-08dd0fb841f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQsDpHn5hO0hhHHl1QDOAT0IeRv8KxmzVBOh6c7u6l/eoxs/1m/2s65rx8DG?=
 =?us-ascii?Q?D/qvsEld8i9mIOskEGOQXhm+E/1Zh15QEt9jqX0fsjOxfSl7V4A3B3tV6fXc?=
 =?us-ascii?Q?jvFqHSeUVxuiDxK0XxZ96SyCeznVQL8IgMQtUXCnR1P+Jwk53j3L2yegzlqG?=
 =?us-ascii?Q?g8I+EWU6X9jksynX2/dHR4TDDMKkRGGZtPJS3gKxB4/emm0SrrpJnOpRtNBv?=
 =?us-ascii?Q?Z/Jdf5JOtZVHJMpeLetEDOMNoohHiGk39Mz0kFi0UsGflXCyAz2d4XL0G1fl?=
 =?us-ascii?Q?3N/bdjPBSlJ7SUywBRAcuJPAh8r5EiDi607gYIdXGdhFVEdqMu6KQvtPhMKL?=
 =?us-ascii?Q?s2KUIGrUulCCf2WU3ejqnfmdC2jpuqVlmkSAPkauxCrrAYeuO5SArtJ63Fss?=
 =?us-ascii?Q?URYQJX62jZTw+YSFq8Jk7jzBhqMkpbPak//+e//JrsFciu/7T+S9GQ6qll0V?=
 =?us-ascii?Q?3NX1WuiUvePZvA5KRWNzM4Lu1r3E2oTSXp/n/l9dJ8pFRt/eKHsP6DZ3Mt4x?=
 =?us-ascii?Q?698RBfTiS5X4zjOj8pSAZJbUbEh40IKcNxa5wW5/qYl3SP5k8dRemKn/4YCZ?=
 =?us-ascii?Q?7ESUgmmrT/QZmZ/JK27QTtPWNPB1TRfjV9eLTPOqNZvCJ4iNAgr8jgPS/OCK?=
 =?us-ascii?Q?zT6JSQC82OU8CgkU+s6XNKlyIIEfR6G2UTYuc692+WmnfP/DFt/nC/1xYCh+?=
 =?us-ascii?Q?A449ovaZ1jZmVIqlpJ8g0N0lQUiH8s3RFDf4Q4PBCv9sFO0vzMA3ngp9+YuX?=
 =?us-ascii?Q?LffPJwg71qZDVV8qNpKtmVo1m+pSgJTJsTdw/y4eBfVBUIPYE402MevKOVKS?=
 =?us-ascii?Q?ZFR0mV0DL8idMH9oHCrRq7jhUah5pInRIc6JVjNuLoGKNR5MvG+cIQz/uMeS?=
 =?us-ascii?Q?cCG9BWOBYPj/lsgDlBfZOOffliOarb8giD9WODu7S1W9LHEG7+XSSFg14yso?=
 =?us-ascii?Q?a4Dlgb0cmGKJ8vDhZS12Q5nSZHpna+YE+dlV/WwhEjuOlKzjLi30NIG/2Zdf?=
 =?us-ascii?Q?5jHq+pFi6SIED1zBwsXM3toVMpFPhbIS0n5Tv0cQ6wIkDesOrF3e3dM1Gxxo?=
 =?us-ascii?Q?K1o5suPOrka0UB3cCeWNDjRP/+vSo74yM2IiorCQNuZcfpvnyPNaSuzifKA3?=
 =?us-ascii?Q?3dpK9OQ9okK7f7yvrN/nQe8nceF9+ZGl7DoVHQ6PY70AqY+GkIgy9h+QwonW?=
 =?us-ascii?Q?ZP1//e6xjT82f/jl1lEV+Cj2HOrW/TpIzfNUe4v4nVDnSHj+k454UFtJgH63?=
 =?us-ascii?Q?4d/G5EGNZgGc3pw71CxTWZUhc4eVZ29urmM9ne5tJYohyORxhNFkXTyzjrmz?=
 =?us-ascii?Q?Fdw9i9pQQVrhH1SYmVIyAhZrqnXDFLPn9+kFsJAIh3v8cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKvdplO7kgWWZ6VGL5aSIbxlVRtosg9ujpxO1/nIHpEwMC5z2k1Y3qdw1QlB?=
 =?us-ascii?Q?7coxt1AulT00/Tvhta2uO9CROeiY1pX/h8MBTtrb3KizBVJX8DFzAEr6hDOn?=
 =?us-ascii?Q?Di2Z3TeHIR95J7/9cwWnGkq/zR2hZFBugI0htJ2s632JmcXQuWQwXUUxg1x8?=
 =?us-ascii?Q?kxffEEF4DcddkB93uqgQ7rH9BTmTjDaoy9+OzG+OBd4yGAu+P/mO7MgF6kqr?=
 =?us-ascii?Q?ZsKQGIYzjuhTOoMJ7ebHsxlAIJvoWRgydDKrYKDf8S6k3kV6b/5Jep7C9bUC?=
 =?us-ascii?Q?uYbVyakxCGs/TH4MHzf0FLf5enfF7XMfnOPPxKKGUAINiaXP5JuVJRU6v5Ip?=
 =?us-ascii?Q?i2UQvT3BG3Sl80CxmeBFqwJWlCn5uUMOaCEdYfdNeR6DA5YLCq0CmuXktT1K?=
 =?us-ascii?Q?HSj9hYvRdUBN47kjm1+JP9GumMl97fRwyeqPFTiX3YE105/3EO8JzP7tLUdV?=
 =?us-ascii?Q?wphQ0uRHmSkyyXRlsAYM+VBeMcuuJP90ZP3Zu/rifYDPJDrsu9oY97joR8hf?=
 =?us-ascii?Q?UUpoSu/EIl7+sf7Ng3CNXIkqOZD5X6wucAFpA7z140ws2sGMVERuS16GZPQh?=
 =?us-ascii?Q?a1ayR/xS+6XBv/7HG4RUiEh4B5u0oxMw1PNL9jSrOCgUCEYr1i0cGLnUHaI9?=
 =?us-ascii?Q?039QCcawT6lmKMe79gYC2xSJ0fMYIFJAYjE51L9HwTeE2Vf+c12lvzIKBQac?=
 =?us-ascii?Q?AWlZcXn1omZiD8e1o+x25cHDv+MSgO9Z9z8WCzqGHWAsAwsuq1hCkKxYT/jJ?=
 =?us-ascii?Q?aCqH/7MTLRB9PUHYXBSrePkdvGOl7YFOcuVe8j17UdqcXa0wq2WL14tFqSbm?=
 =?us-ascii?Q?dA1kHkVF6nww83uOPtShOEK8Xb7Upd3hamvr9fe/GKfXWAZbrmJ6L9djd/aF?=
 =?us-ascii?Q?mrNq9FDNZpOa3qgXGcIx5h+NndjTCEcBphFLNKCYBz7s6IjOYMBnV0ZB0OmS?=
 =?us-ascii?Q?Lo7g/970eX44RqKLPwNtl/hEfx9Q1r+kjvzhUQHqBjeHFD4LlmVIAhkXswe0?=
 =?us-ascii?Q?bYRDTmDWHdJCAHVFO6bDjUM44SiVkm3x1CmVqK7ZPDe6EL/Jd/k89fj2ZEWn?=
 =?us-ascii?Q?+sC6T89Aib0Rg3fYxjEsqlxzABVLlXUPvH2WVEMt5jsFhu4VTLHp9OMGJsMR?=
 =?us-ascii?Q?FRxWOLDRafAZhTw+M9Ws0PZTiNUhYi+MN3E5ksyLSNowHq7XKp0WF56wQNZa?=
 =?us-ascii?Q?z0pJ8z5u+V7XYVyfUQtf5c2RhIhTeIgNiw3hurivGWfc5gXPjMmySRxdfTm0?=
 =?us-ascii?Q?Qmi4sUMYe+A6ZyKVTi6gCS5bC+SmpBRxXs1OHupNPO65DRe2ZQkZG1cLGNzn?=
 =?us-ascii?Q?lC6WAg8HkgzgsUWvomK9Q1nK+sOQ0LAf5eQ4y7p5/3i1AVMIZCZaKnJfMveN?=
 =?us-ascii?Q?UBy2G/h5HZrKypxyYc+FdvKvbI7u2L5EC/5EyxhqQf2A2895tu4FyNT6UasX?=
 =?us-ascii?Q?DHJNH8XNrGXDkxdDPsQ9ekQsJLtYqiZX2snzEs9Yz5sFSKAXnlygV+zVPUDY?=
 =?us-ascii?Q?mAv/KWdikWa4r6TSb3dIjam9d1lIqTdJxkIq2jag/ndUShVPr1reo+cRxVka?=
 =?us-ascii?Q?mcdx51Zdn9DIhZ9CJ+sZIXV7av/A05hBDTLm74vdmn6u8JZ4EBUvzm1a7zDe?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/CYb5Xs0WTYGVC+onmr/YIn/esxtT0JezmJ4zw55YW2Mt2uDhvNFvkDvsXAOPQHEhSaEFI7WX7sm4ifE2cRoqS2k4VpXpljm+QJOY9JtV1pU2u17XPPret+FlP4v6Bcxl/WnHpPXR1Tm43Xq7SB88uFqicMrDJwV3AYjCa7r18zpBYOFDbBG5/qmFnd+nm51iyQnHCzWYV1/OSRaz5ObS7t9R8mH6Ka0xz6q8gLJhKzk3mEpVMLQOMyk3XiLfzVf0Yy55EeHhte5GgpN3En4vGl/2LHYhRBnh4UXl/cweHLhU+Isv0whQB84wLvChfsY1RvADeVuc9L2EDQS1Mt8u2HM5eMwe7ld7sZd4phdticA6Q+ih93/KtPaJvxEKPihsjUmMto+7jFIfi0kdZBWV94H3fMsxNnvjtQVa1KGwyDdPrYUVV/LEZBcC6VUh2MEdMxePA/EqzsHab2ttHXL2G91qeboFc2b9oUkjoU3Dqsxf0xRAnEgtvQ9H/STeKWnHLtoAciIUplHdOQFitMGNKm3k/K5lRCXHHQePekQAJzVTceVrzIQ8rCEJu6fgC69VLGUMDDDqEqmRW1zgsgBi9AuCf15r9q+mskAzy+sSaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d31906-cfca-408f-ab82-08dd0fb841f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:23:41.3662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whnGcQM5Sccaho637P8nyxNHCTt+cFlV9SmBkSR7P1pyw7LbdqSEDXUG5MAIuO0rSvDrMNu5NJey0LRLY4WdkQAYCj99KYUWTtfUR/lSPgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_13,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280113
X-Proofpoint-GUID: OnOMethvd9mR28RG7m2DfYKZXJGbTEDL
X-Proofpoint-ORIG-GUID: OnOMethvd9mR28RG7m2DfYKZXJGbTEDL

On Thu, Nov 28, 2024 at 02:37:17PM +0100, David Hildenbrand wrote:
> On 28.11.24 14:20, Lorenzo Stoakes wrote:
> > On Thu, Nov 28, 2024 at 02:08:27PM +0100, David Hildenbrand wrote:
> > > On 28.11.24 12:37, Lorenzo Stoakes wrote:
[snip]
> > > > It makes sense semantically to establish a PFN map too - we are managing
> > > > the pages internally and so it is appropriate to mark this as a special
> > > > mapping.
> > >
> > > It's rather sad seeing more PFNMAP users where PFNMAP is not really required
> > > (-> this is struct page backed).
> > >
> > > Especially having to perform several independent remap_pfn_range() calls
> > > rather looks like yet another workaround ...
> > >
> > > Would we be able to achieve something comparable with vm_insert_pages(), to
> > > just map them in advance?
> >
> > Well, that's the thing, we can't use VM_MIXEDMAP as vm_insert_pages() and
> > friends all refer vma->vm_page_prot which is not yet _correctly_ established at
> > the point of the f_op->mmap() hook being invoked :)
>
> So all you want is a vm_insert_pages() variant where we can pass in the
> vm_page_prot?

Hmm, looking into the code I don't think VM_MIXEDMAP is correct after all.

We don't want these pages touched at all, we manage them ourselves, and
VM_MIXEDMAP, unless mapping memory mapped I/O pages, will treat them as such.

For instance, vm_insert_page() -> insert_page() -> insert_page_into_pte_locked()
acts as if this is a folio, manipulating the ref count and invoking
folio_add_file_rmap_pte() - which we emphatically do not want.

Since this is a non-CoW mapping (according to vma->vm_flags), VM_PFNMAP even
with !IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) will not touch vma->vm_pgoff
(which we rely on equalling the offset into the range) and all works as it
should.

>
> Or a way detect internally that it is not setup yet and fallback to
> vm_get_page_prot(vma->vm_flags & ~VM_SHARED)?

No, this would be too complicated I think. And we can't know that we will need
to do this necessarily... Better to just expose prot the same way we do for
remap_pfn_range().

>
> Or a way to just remove write permissions?

We can't really do this without bigger changes to the faulting mechanism,
because a shared mapping with VM_WRITE that write-faults but doesn't have a
page_mkwrite() or pfn_mkwrite() hook will end up invoking wp_page_reuse() and be
made r/w again.

>
> >
> > We set the field in __mmap_new_vma(), _but_ importantly, we defer the
> > writenotify check to __mmap_complete() (set in vma_set_page_prot()) - so if we
> > were to try to map using VM_MIXEDMAP in the f_op->mmap() hook, we'd get
> > read/write mappings, which is emphatically not what we want - we want them
> > read-only mapped, and for vm_ops->pfn_mkwrite() to be called so we can make the
> > first page read/write and the rest read-only.
> >
> > It's this requirement that means this is really the only way to do this as far
> > as I can tell.
> >
> > It is appropriate and correct that this is either a VM_PFNMAP or VM_MIXEDMAP
> > mapping, as the pages reference kernel-allocated memory and are managed by perf,
> > not put on any LRU, etc.
> >
> > It sucks to have to loop like this and it feels like a workaround, which makes
> > me wonder if we need a new interface to better allow this stuff on mmap...
> >
> > In any case I think this is the most sensible solution currently available that
> > avoids the pre-existing situation of pretending the pages are folios but
> > somewhat abusing the interface to allow page_mkwrite() to work correctly by
> > setting page->index, mapping.
>
> Yes, that page->index stuff is nasty.

It's the ->mapping that is more of the issue I think, as that _has_ to be set in
the original version, I can't actually see why index _must_ be set, there should
be no case in which rmap is used on the page, so possibly was a mistake, but
both fields are going from struct page so both must be eliminated :)

>
> >
> > The alternative to this would be to folio-fy, but these are emphatically _not_
> > folios, that is userland memory managed as userland memory, it's a mapping onto
> > kernel memory exposed to userspace.
>
> Yes, we should even move away from folios completely in the future for
> vm_insert_page().

Well, isn't VM_MIXEDMAP intended specifically so you can mix normal user pages
that live in the LRU and have an rmap etc. etc. with PFN mappings to I/O mapped
memory? :) so then that's folios + raw PFN's.

>
> >
> > It feels like probably VM_MIXEDMAP is a better way of doing it, but you'd need
> > to expose an interface that doesn't assume the VMA is already fully set
> > up... but I think one for a future series perhaps.
>
> If the solution to your problem is as easy as making vm_insert_pages() pass
> something else than vma->vm_page_prot to insert_pages(), then I think we
> should go for that. Like ... vm_insert_pages_prot().

Sadly no for reasons above.

>
> Observe how we already have vmf_insert_pfn() vs. vmf_insert_pfn_prot(). But
> yes, in an ideal world we'd avoid having temporarily messed up
> vma->vm_page_prot. So we'd then document clearly how vm_insert_pages_prot()
> may be used.

I think the thing with the delay in setting vma->vm_page_prot properly that is
we have a chicken and egg scenario (oh so often the case in mmap_region()
logic...) in that the mmap hook might change some of these flags which changes
what that function will do...

I was discussing with Liam recently how perhaps we should see how feasible it is
to do away with this hook and replace it with something where drivers specify
which VMA flags they want to set _ahead of time_, since this really is the only
thing they should be changing other than vma->vm_private_data.

Then we could possibly have a hook _only_ for assigning vma->vm_private_data to
allow for any driver-specific init logic and doing mappings, and hey presto we
have made things vastly saner. Could perhaps pass a const struct vm_area_struct
* to make this clear...

But I may be missing some weird corner cases (hey probably am) or being too
optimistic :>)

>
> --
> Cheers,
>
> David / dhildenb
>

I wonder if we need a new interface then for 'pages which we don't want touched
but do have a struct page' that is more expressed by the interface than
remap_pfn_range() expresses.

I mean from the comment around vm_normal_page():

 * "Special" mappings do not wish to be associated with a "struct page" (either
 * it doesn't exist, or it exists but they don't want to touch it). In this
 * case, NULL is returned here. "Normal" mappings do have a struct page.

...

 * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
 * special mapping (even if there are underlying and valid "struct pages").
 * COWed pages of a VM_PFNMAP are always normal.

So there's precedence for us just putting pages we allocate/manage ourselves in
a VM_PFNMAP.

So I guess this interface would be something like:

	int remap_kernel_pages(struct vm_area_struct *vma, unsigned long addr,
			       struct page **pages, unsigned long size,
			       pgprot_t prot);

Certainly this area of the kernel is a bit confusing at any rate...
