Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698D219E8;
	Fri,  7 Mar 2025 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389746; cv=fail; b=e2q4wYQ6rP3x0K3v/F+uBZp5/fo8I2F62zgNvOI6whxgPJWRQjeSohtvQtN/YiPlv/XQc/ijAVocnVBqFrbPOJQiXzI9nlikeN9nvu81U0E3UiY3SE5R+/vfJE44QctHfDGg5yJv2DLPkjPPFo0C0Uki7EW6B5A2QK7jUZtamKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389746; c=relaxed/simple;
	bh=UMVjE4pSuCTVl22qA+zwJq8sI5oyXnQzpYh9IHXKnio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Irop/g6J0kZbDBZrn5Mi4G6CywXoPIda/XyVePxUwkmY3XDhvyOO0+zeos5AUoIAie16hMVk+zzfsltWTNRpfS4FPjIASLz7/jhoTplRNptQteT7Aju1EjAGCE8S3ot+LMbQw8uQ97ixG0VYrVOA/8dnZib6Kcw0E+AeGbn6i0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HmrmCXMp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uCjwL4Mv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HmrmCXMp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uCjwL4Mv"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527LIIgu005623;
	Fri, 7 Mar 2025 23:22:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pEa1dw5MDETTosTwvhNK4x+tyZH7/LIkglqdzqtQSOA=; b=
	HmrmCXMpg/DY/YdCHvXDOp6kWaYv/U0kkAy4yuU9B70A8AI8ovhhr5RzLR1NLBwx
	H+1MsN6ejIi5Bh78qz8ZuzqmIwr/l7BFEZlBbz5iPiwPzriulUb8lnaH2WQaKY6l
	m5xbWVOo694Irn9EXHECgTDqQ4d2TCp+OEdOPbnh92oA5+a5m8VYDjvXem1Y0G2Q
	n71zEMYNjMIg9SfzdY6HNYJ8FvMCJ/DkQCuEtb9MuX3oGs4InOCwhmsXJK/WTPYd
	soiv3ajgKItv5FfdfIwaRe1w470UcEyqFSH18n5Ywqp5cy/Og8sUEOzJxcchXAJm
	WWcuEOMFqs5kHuhgiOWYqg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qnctk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527LCVOC003191;
	Fri, 7 Mar 2025 23:22:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe547m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxBL2P9V1PVnvJtzibxTeVg/81uQGuUoryRdE+DFu8TVjhlcXZu1ftK9huI9xeTItQe8Qw3jZGRo83KKU8F8MUIHefrs+3tnNmTTpcSdbrQKwgn+FzFAdY9ZVvDDEhqEUvZpLxL2obfDHUfzcs7ljHCdEea+SvIMuusYCoxLJ4pZoHY87gfkot4Jkd9YYp1Wvd1Oc2S6J+u/czfqSgBnpg9ZpsrwVqXjh9RTXSsfgtCT9P6YqAG3HJlENMH+ifwvdEB0dc3Ef+l0ja1nrAAijiw+fdGJPDh78252uUjJQZFUYlwSGkHrKIbSYRlhEE91QidF4YwFgMJLPOMttGo2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEa1dw5MDETTosTwvhNK4x+tyZH7/LIkglqdzqtQSOA=;
 b=al2svjDDo+SVHi7fW/pnwoWN4DAupasHNfzVTEJfK3zl/RdBsbZicvsAnfc5WPq9U8LzH6Z+/hMjaZgq6WlAJBWZLK+uAYuR3DaX5GL4kCG7IWo/nUOYi3y7zp6f5yuQK+YmD//wGgV7q5EzGA5pMx8sT+SBBZ/NX2Oc2Du+cgyEvUmXmoBLbxWF2ocOg/b6aVOdQlAzuzx50LXwmiPpwLTxl579Ytz37L+nIiTv3JODLrwSB6LAH20ke2T/CJ3f0yQM89JWrJhQ0yJpYzT9Glarf13NpDYS90u/u3nJ2YuJBV3G6YbIWDbd+xuqhOCJUrI4fnt6Ehq1buYIT3I0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEa1dw5MDETTosTwvhNK4x+tyZH7/LIkglqdzqtQSOA=;
 b=uCjwL4MvcJy/S35DtbzgY8etPqw447PmQ7ZShuPqx16VTASZMZZAzK7e2vyL3Vb3syamF26bouye9IPt20Ii7EODDU22OsIA6qTKPSOK2y3CnAEu7YsWlIEOX9gZMQzx0aG4sfT+AMphM+BJiaP8OVKZMsE8n0lkivLMfR7YrMo=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 23:22:09 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:22:09 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v3 1/3] tools: perf: add dummy functions for !HAVE_LZMA_SUPPORT
Date: Fri,  7 Mar 2025 15:22:01 -0800
Message-ID: <20250307232206.2102440-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
References: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::24) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: c67fc6d9-0101-4bae-68e0-08dd5dcee1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otSp0Rz7ZemzFvVi3lVY4gdinXRXg4m4ameC6dbl2d3albpXPQujy4MRJjny?=
 =?us-ascii?Q?6L/S0zsHXi6A0wA4EtVD/WmctjmEbwXtqOtop1WpuFwcC9JjdRG0l0EQgtzU?=
 =?us-ascii?Q?++TRPJq+N02Uqig23TfxlWuyUAD+8dPkCHaVn9roixCVbcTixv41dV/gte8G?=
 =?us-ascii?Q?Jjmg3W836QnssCIL6cP5zURnS6shjCYNsePc7J76audqtZYTmTOmpbgs5pS6?=
 =?us-ascii?Q?V64atkM7gjrVoAZorbik9uwiOhKPk/+1n3/yxu2Ka+DASD13JAoF3kkTQC0a?=
 =?us-ascii?Q?8s1yHmyv563aJrDab8fdEep1iJVJ8+0NfIDJtP4CxEUkTflrVEb095CVOyz3?=
 =?us-ascii?Q?8x0TEvqKYohwJJPTc0PBj+Zks0qKYhOv76ahwpjSQF2kzJeW/QsjCx6V/zea?=
 =?us-ascii?Q?4HoKdj1zCFDNyIJDdOTtHl3HV3d3hhjnfNWu+54z3uPnizgHI7W4Vo7Re8G8?=
 =?us-ascii?Q?ZfUAZtN3u8ucOpftA9hjgdLUz6qDbpyLgxqWrmdYpTmDcELfLk/W434rK4uu?=
 =?us-ascii?Q?0J3mH1l9J1bMGgNc9QGbSOgJqjOv0A/rwdD55stgYFe6FtRqdRQol8vvXnH4?=
 =?us-ascii?Q?D0eVbEHzt8ygvqfkE7+S8rAJXg+a02rIporOOXu+pGhdxn0RHyT5A7ggDjbc?=
 =?us-ascii?Q?hPRvxPbS6Nc3kw2aXWhC0+F8srhDOfGBrWCjMasXjp7x4C4ehq6JJhDh3zAx?=
 =?us-ascii?Q?K8gZpLWZRSnDI2znq8qnBwrsQiW+MhS9jFaMP9OhRq7+JbE4wv2x//UBAvTv?=
 =?us-ascii?Q?DuX50ynOblex9dLn5jLhuYBsjElJTHImuCYXK5ZgucU21WuifPkm3i1L1Bxm?=
 =?us-ascii?Q?GgYr5J8dLiQcjzIbTaKkJHJmzfBdQt0fW6IbqXKEZZ4ZYyjS19W3d1dr25We?=
 =?us-ascii?Q?Oc5C9Hs7BDtPxEphcitEntLtlQKFISDVdpOzePp1V3ZwwlmFyx81IGyXcpG/?=
 =?us-ascii?Q?9N2IYo4Fd5si65184tvjNzXnvWTJZ9GOmSRlt9O8KIz+D1eIGEw/4yB/0Otj?=
 =?us-ascii?Q?lHTOT6ts+dwsoAH2tlI0Ho7djtpGiuOyX4BLAKc2U9y+Kcppqitg0VKD4FiR?=
 =?us-ascii?Q?b9l3unAJYVgZnzAc14JBXne7G46AFFxkboEXhQHkcmM5rZJHk2CeDuYisJxE?=
 =?us-ascii?Q?jfBxk+WAkm409gMkRFFFWbRHPLGC2LHZYfFTHJvP2XjbABlroIcNbxxhYn4Y?=
 =?us-ascii?Q?L6jnRK8f3E7Bn3vkf9dlOpUkicQyD+FBPdSKPM/q5pR7AP/UtKQa3SHenp2y?=
 =?us-ascii?Q?OZoPCeHP/C/IXSwXPyYcdaVrMdS1WAKCy3uqPg0LuTViXuIBPIYXh9OdhOo5?=
 =?us-ascii?Q?rr6SQr8L/8Rha1VZFYJOkt1bXuVM372fQr1XDDQRI8iszB37a8WDvrZJqNG9?=
 =?us-ascii?Q?q2puqul4MpD+HM06OQ09j9Sc3suV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAzPk4h6HTlbDuhRKl/xdn8c1hd0/vEEelkcGliGC8nq+mzOtNLX2N3Rhs5V?=
 =?us-ascii?Q?kld2taB7TlS2vo5nPoysHRMOPEvJhRcIeI2HTCf1/475FMMJH+fmv9lr0Kw+?=
 =?us-ascii?Q?oNVLGUQ8FpFktymsHnLdpb5nTAfm/rilOXUvOJuXY+PsxTS0n/B8UUKL32hO?=
 =?us-ascii?Q?JhYb1IncoTTx2oGbiQ3zXGDKPKxsCt+mrh/cgKEgtHOibgtkXiwEI7NXg8ZI?=
 =?us-ascii?Q?cFp5N/P8ZZJlpUEaMZhLCB5zO1nVjFCzYqs5vVJ1ZwVGLOZ9TYdDOqfoCE81?=
 =?us-ascii?Q?rTaxd8DFkDMx5ZILI7s2/BU0wrCXl4vI03kqjanlfcgXtXuGEc+yrWvw9nfJ?=
 =?us-ascii?Q?rO/bFvQ5IFvtEVIn0XJhF0xBeHcEPX/TKWK7u23GzVCElaUXmnA/S6gGg1pi?=
 =?us-ascii?Q?NGavwty7jZ3PfmyT3rmXeb3guH6HEL4VcYy6As4Ep7405E06A7puwtWYwIXw?=
 =?us-ascii?Q?O/2MAcCyTel7MiXviLZ5rywUB7ZpDYPyF5XfSduGnaIUFpK9rEGCLE887T4Y?=
 =?us-ascii?Q?LmeBWC7RqfyHQOjknQ0TkMkGowAQ22PL4tc7RXzOMaDoCAYpgwhxKrwb0/vI?=
 =?us-ascii?Q?NIVESFp20sgaFw5coofjUTj0vN1xWRWn//XSCqo7X9nrnjI0gRgo686qnTT4?=
 =?us-ascii?Q?2BeATLMliRSnyrJOSE/NNmftWeY+ece9BhvU4fm1GbevDZxAKWE6Gw3TlI6j?=
 =?us-ascii?Q?EnZqF9ugXvDAjEGWTNiCMSxIGLhvQtGv5OD/psP2sYqGVL/MDfxLEdG1oAP9?=
 =?us-ascii?Q?JAovY2hDfj6liwjWbEQbOVydwb1OMbVYN7HECVu7ALrBFTMZ4Zi3bRft176r?=
 =?us-ascii?Q?+CuZ9dvuEybSniTf1FL5ULVk2VzzX4HjIwqNoAN8ogvnc1a1gP3DcX76VZ+9?=
 =?us-ascii?Q?TMeCpYm3GKLNGJnAVa8i0gUsPjczjydjw82EbqHhbZrmmXFmVZmaRFwhiDxS?=
 =?us-ascii?Q?Vs18rBK9rlUdQ2pHV1qjA1w4dYIOJkIh1Q762Ls/zqLbeF328QLV3Bab0wRR?=
 =?us-ascii?Q?NjSYeZHjj6Lvol7KMsEhvjKaN4UMS7SWO63ci/r4K2GMNZ2wurtYorzj6EGD?=
 =?us-ascii?Q?GS5gccIvv53JXCqxDspL/DQTfwBUE4FER0918+MKULOVWgLbSzRexh5UAkAQ?=
 =?us-ascii?Q?Smf7HA1Qkb8BmIGam+cA3oxX5SoKfKbNGEQWKNr8ujVvTciyG4uC2e93ZUZJ?=
 =?us-ascii?Q?h4+pRyV192cYyLYr93/PwmHk+Ul+4g+Rl4DDoNOIMx37zf7WHejDKzTzfOTJ?=
 =?us-ascii?Q?kGz//1tH7GdzJfNvCclK+qmP0Z/Oo2R+UlWUNU6qsX3E1bVMJUrR80XxTkvE?=
 =?us-ascii?Q?+llEWp37rKeJgEzReRMfQcZ5y1iHDAZZvrAz9Rft7mk6TEahxeESoK2yHkE1?=
 =?us-ascii?Q?HbUoQNg3xRVHB0ccYs568dO9UobMalZEYd0cmaNekiAKCKs0bYbG+OZMxyZd?=
 =?us-ascii?Q?eJBiGgys3oza1UUGcI+ep++drU8Y9aa6FpkWL38rzWs54akXStKb5gZFSFRE?=
 =?us-ascii?Q?0lmYGqUk3VyZ8Hqgyt9N8gNUBP+98vcSnQOhUgk6MOFFYx3BFojmzEFeNSbK?=
 =?us-ascii?Q?/Z4SpQXKJhpMLohlBQmxdPS9anmWPBnsYmDFyvuTRRsF4rnvcZXoTIoZrcMm?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EHADdvugkvnMrXhzk4fn9XFNupUQKRvzPjG0pkkgRJ18legpt4I1cPsWx6xUAQCUUGoEwqnJnqMgU4W1GaUqxF+6gf1hgsAHQkSTeERIh/TETBKz2nCSeDm8xJbfLOEQGUGhzly6hgngcwDhMEVYOA1KjFyGgyRPsYNM4VZuafDzqlMgUigJ1vHNtC9ASQyFpN0EezHD8He7z/i91k8Km3xU6DbqCPaQhFU4oliwxtF6z0riG8YfTCKRYcYhKVOKogz7XSndR7Ggm/Rn9qtQf77cxVsfCDqMfbavhb9EyjTDqvE5/W4Eftr1PtV8ys1PIvLXPOywlcGwUFUaayOHQ71icjlxH+KUZrzDAQZ6fGa3E5cvtsUMmvmuE0OrR3TlqzZCr5Xt0YOVBV9G+4QDX7SPOSfT0CqSvrQXVdDqiZTde+g23xZee9g8UVsL1ELhmC64CZ69U+Ae1p2XQsSmeA+eGC2WwNpGsTjWkhbTwSciLuKJN+Q8JuT9GDjNVAJSEfTJwQS1c5q36MxBzMC1SKzKI/VvtwYirXUNPO4+D5wfaUb8SubDo2Hj+FmsELc/WRfrtoOlsvuDTF4IYc5tg5meJE2Bu/Vg9qdjabDMx/k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67fc6d9-0101-4bae-68e0-08dd5dcee1c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:22:09.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qL4NBzP3hAldk0yoPY+zLywciF7bNnngXgoM2CwOB1AdwDjj9F8DYTpdJC0y50n9Fx1mKeyc6FuA15AR+/S2xkLhPFNUPAc411xpEw+75WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070173
X-Proofpoint-ORIG-GUID: 7djFb8VTcXdcOwZ4yx_Z4O1zEWF_syLZ
X-Proofpoint-GUID: 7djFb8VTcXdcOwZ4yx_Z4O1zEWF_syLZ

This allows us to use them without needing to ifdef the calling code.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/compress.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index b29109cd36095..a7650353c6622 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <sys/types.h>
+#include <linux/compiler.h>
 #ifdef HAVE_ZSTD_SUPPORT
 #include <zstd.h>
 #endif
@@ -17,6 +18,17 @@ bool gzip_is_compressed(const char *input);
 #ifdef HAVE_LZMA_SUPPORT
 int lzma_decompress_to_file(const char *input, int output_fd);
 bool lzma_is_compressed(const char *input);
+#else
+static inline
+int lzma_decompress_to_file(const char *input __maybe_unused,
+			    int output_fd __maybe_unused)
+{
+	return -1;
+}
+static inline int lzma_is_compressed(const char *input __maybe_unused)
+{
+	return false;
+}
 #endif
 
 struct zstd_data {
-- 
2.43.5

