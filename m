Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D114AD3D;
	Fri, 29 Nov 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894346; cv=fail; b=ThKJGZEMurtf9nPbVoM974b6LhSOU2ICmS2DZA7iT/epsjFF+f8MdcDGPPGCWqt1sVqbhuQXSc7oVs9UcE1xi9PvSEpzVRuyWLzy+Twc2KIgenD0FEDxGlezaSJVyFG/LQZZUHQrO7FUXWtVGmLxnBLpXDNexkCc2BCC8TcR9SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894346; c=relaxed/simple;
	bh=tm6sWDr1fSwZ+PAqCTqR2DWmzq4vKlgrVgMecK32VzY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RMvKGOm+Y3oG480BEkQF9xaFD59a8ZEjIyZXWWRuozhE/BMx08AA+amAnHXsOIi0QE18V9W/H/3W/teQqA87lflTmxvjJ/8t/FNwQElMEEUdTIAcjw2vO5F7f7W4s/0tRZrZLaHpTCNk+GB5anQJa1kDD3nVeD9g6cCbN9LP12o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cLnz2xRN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BSxMa0jE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cLnz2xRN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BSxMa0jE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATEMvNS016008;
	Fri, 29 Nov 2024 15:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=SspTdkH7ZthJHB7n
	tRLRv9uv1Z68A75NoU8WVTRvtHw=; b=cLnz2xRN00sxzwL/M2a/7VLetXXXLxM6
	qBnWG4BV/EPb76QGEv3KQqxIL0mqWwL229MJSDZs++X7IIqotsNUwQ4tlpypSLfC
	R7QNvfIv5zvOofCwttCrZQSgT9a1HMaRvdEszScZydGNbKU4ASTt/n0zUHY6fBG6
	+PmZ3HQnXOsNZXlj1xBuqx0UHI1uu3E+DPdFqVHQ2agm2jYlbFlvHrY+NOCVZBzF
	1ddtegJgZnCtjizRU4cqz59bPEE17SVNiLHAVPb5oZ2AfC4ppU2XeqZ3ncxfmONU
	Pvc5hcE9TJzzMhq6XBroo1+fmuHP/cDMVw84rRBABCcsNAoAR8yINw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xybf05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 15:32:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATDYGqM009283;
	Fri, 29 Nov 2024 15:32:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4373sse5yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 15:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wdyh3RvRWggvZlcI5D24mD/q18/K9/5U3FmVsdA4+bCLVQh53oUGCjwV/fhnFBC5AebxiY2rW6WGcpBVUMV14YrabVBK0LLhp9337VmAum2YqgE26PclGoehBEJvaGqe88el/1xaBtrYQbJgcZv44cOT+2nefF2jFnMbaXow3O4HnX7qIxmkjk5Br8tTXH8hgy+kso2UaReDE5FQObIZXmN0rGpRE+EHED/GmP58ty8stFml8oJbcAdtLP+HYocAMZ688la7tKoKSUdKG2upEnsfgeD0rBQ46zzYHgX40u5Bj5gTJnceXxPNjCQgYA754PSp7ujqCbe8FxKnndbY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SspTdkH7ZthJHB7ntRLRv9uv1Z68A75NoU8WVTRvtHw=;
 b=Sd9eLJ4xCTPodypMsEeKWfw893wS6y9xgDZylPzC+1q9GCqqmvpit4xUKB9ceIIn/xi1kXlNuf/oFWECnow/KXFZtO43c42OIEeaZ9KP8enc7sRLKlO8XNjLU8h6C69mRbtItvU5HdYlRdO+S5tHKsNvPiKW6vADkbp6XCPNbPwAuiWKQx+o6mrEXnEiAEsnF/tC+a4lnuUJP7wzzR4tD0FCBNvGzrEDttUZnl1xbx2nftWLUslTkLuRerdrjyw3OO6wZdQRA7G6qgzCs1MerrE+OK7NNpbDMMA2LXYD/uwh2sdpmVm5LhXJgrDhYIkKbcLEqsdLkWMPG0dAz5vhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SspTdkH7ZthJHB7ntRLRv9uv1Z68A75NoU8WVTRvtHw=;
 b=BSxMa0jEbOqKo/Kml+WmBJ0JD3EjTRJbbysN6HGeAt1GPIo76d81tnhukvLl8vMJiaC75cXuEyyTf5bUJ8qOG56yEmAiR3uak0ccRuP/NcvA5VaD6reslThMTFzfAK284f3+E2HCSZWI1lvMikmXJvKdsSYKWUQeq1iU9yH+tCg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7418.namprd10.prod.outlook.com (2603:10b6:208:445::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 15:31:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 15:31:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] perf: map pages in advance
Date: Fri, 29 Nov 2024 15:31:34 +0000
Message-ID: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: c670796a-ed15-45ff-5fcb-08dd108af751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8Ymy/Lk5gJ4s7tnobahJ0Xjtlmz4ZJ1A7iW8El1lF3eRcJSJ9RfWQc8urPW?=
 =?us-ascii?Q?PQmvZJK+oa156EK4sGVN74dpZ7fXsicQCzddhVZlBXe1CgdACZusEHOu0WLS?=
 =?us-ascii?Q?fAw9H988+ihFid4KaWzNmtvcW55sa99TIMywO8PPT9foAVOPuw0wJbhjggAe?=
 =?us-ascii?Q?NctfGx3TctgZVp0cOfuMO81EtMgeYIXmp1QHVwoHke9BIJOwuejmU7LDzVwv?=
 =?us-ascii?Q?0oh2qDwuJWhaD77IRJa9LkiusROOLy5WjNJzRdDapKwRsxXvTiKwaEffKq0Y?=
 =?us-ascii?Q?N17xJ1rfPZ67o6M4UhbhrMLFl87bsjxMP7oi5HXOFjjoysTWE+autKvrO9uj?=
 =?us-ascii?Q?PtN5On31pUC1gwzJ0iFk6DRanY4PiWtwYXoDcvqghRpt/AAJR8X6EfDMVT2w?=
 =?us-ascii?Q?QHj1QPol+Ae6oq4NJnBnHBj+pxSAFnMF5aZ+B/YWevtM4irHai39c2EdjYf3?=
 =?us-ascii?Q?3YjBn4ac1P39nw446ubGPVys8GbDMHrMuCdfHx8+os/pp6PBbIv8fLlpci+H?=
 =?us-ascii?Q?D0YB5hs74d05JHXXR5+Izx4B5u9FwnoUSwCiwXkPldBaQv7fitSWgG5uigN+?=
 =?us-ascii?Q?C4VxkU+YnhyUlan2uD9GvtvnVGftfo5YbwxVMdInyZDcABXrqOmxiYxKldxo?=
 =?us-ascii?Q?Nw+j4Mlu++7Pij4UGKHqcB48B5EiM1wVVIlMGjM2ZXJfbZOUhiMgcbahQESQ?=
 =?us-ascii?Q?elgaq7Mkb4vjrDxmWGziizmFvu7E3t996iWxsBAQHiUCKD3cYr3uS1Q0BNTU?=
 =?us-ascii?Q?0nLYsuXL4J+112xU5ea7bMocwFkIxzg/ecoyNXUQ8y/96RwY54pRNifEZ8ip?=
 =?us-ascii?Q?O2R8f+H498bCsFJjQumcVWRXghtfqKpDnjOSqhqF9odcByEZH0jQq05+CciS?=
 =?us-ascii?Q?LW04zLGRhUscDXCgPDPOLoDRYh5VmR6qnXaoHj5Xv8wnpIW3Y8kQQvqS6hD+?=
 =?us-ascii?Q?wTqG5RHGs8PAzuKkTFSTrBvDwCxgbQmDGRHx6QL5vc1OPr1FcVx1YJkEB/vM?=
 =?us-ascii?Q?prLS01a7/pDTZU+HpGn7ryr1Cxz6JGfYain7k8Nni7/4z9uXp3ea3UkAy99u?=
 =?us-ascii?Q?nJ9BhpyQXoieqFuotSXzjhQpRlKYbYre/KOK7HtwTPKm96cCVIYptoQoSVgB?=
 =?us-ascii?Q?Abvpq8/ECy2h2a1HOyEj5Cm8dQkEz2QJerucBlI4jgTasu7m3ttsyRcH23cp?=
 =?us-ascii?Q?MOrE0zAgoY7xSXtzU2Aqn90N4+dHtLrJMIYXUCPGKLsnc36esZRQHqI5e+ga?=
 =?us-ascii?Q?d1vKKmiBVSwjXpv8ANTPgeb6jxa3b/4vh+Jj2arUFlpTbKtMsOCJ1rxR6TyJ?=
 =?us-ascii?Q?HIcJys2+f/1hmhvS01BWknSUVnmzvVz5CPI9HF8Ru2/OZG9yHW4DELah0vbM?=
 =?us-ascii?Q?mI0RHzo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GjVFu45/jxWRtL1M4rBoz+vNGvvjx3I6RQHYPObHjbQCSbadgqtnqyV3TAPm?=
 =?us-ascii?Q?zD7ztRNqFm8cVmE6HBDFJmKEEuLnl1Q821V0PILSXSkBwdli61PRyi/Ed5ha?=
 =?us-ascii?Q?t8KifRSnY/4a3dRJevorlN5wdJzxv/8JDTA2L+BjXjwY6FwJ2PKbgqrJFRgi?=
 =?us-ascii?Q?Zn9+eH3dGR3KhJVXR6SQuqj2rgAHe/rfOIoYEOvOFtIXnQ/mv+MH8cMr1lwn?=
 =?us-ascii?Q?pnDUhrfVTRW4FLGwWZe07iu7vOO7F8luDCJ4p40O//lrLgVjxjCimrBr+qZT?=
 =?us-ascii?Q?Z7enWw2TcLM/VC1OuUEZMzQ3Ee7pK/iZ9mdSsWVY35vrS9IgmS6kJFa8n7oS?=
 =?us-ascii?Q?2GX0nrGunl/SjZOXZjXQF0nBXBEg+m9L3CJbIDZ8gRV68cEBEw/KJKOOfzLs?=
 =?us-ascii?Q?U8KvHmXfgjeM1IIjufQQgcZHVX/uedVN8hz2pYDC1D6LkS6H64YK/Dy9XEBf?=
 =?us-ascii?Q?QORKtLmAkacxTDKHKzEp08g4DC48geleMf3xEP1Jtga7UsobuYGN+jiUUbIn?=
 =?us-ascii?Q?f4j04rYG+8xUOvZbkY8WZkA++5CHwXPd6nSWXYd3hmBxpA5DjylLAP3S8SVc?=
 =?us-ascii?Q?CnWhKhq7B57zLYv1hC1B8ilLz/MkA82FyzJ3QNzfdfMSA1Hotywg39RLTx8G?=
 =?us-ascii?Q?fCxZAxzE5OB/CUH85j+S1pMAPyJgQo7c5dobPYESe/OohrERvR9MerXT5ooN?=
 =?us-ascii?Q?0ubBToGRjHmmxB4HzovNz5gDMR8NZHDDz7867UbSrh3sHPsK5ojlvFZi536m?=
 =?us-ascii?Q?i/h9jP1LYDbCIw4yGRsZIbh+9JGABs0eamJ644hMdJVoZKlD9AwRJLaUcMlJ?=
 =?us-ascii?Q?ItPjBgKh1QPJQbNRv8Hs2BXFXvGq1xN19AJVVPHpxxPV8FPL/Oh760eQpmOd?=
 =?us-ascii?Q?b9Jt6qzp/xg5yMN4kln1ni9XCM/CToRT+ErlYXP27eFom2Fm9lpWaej2qMXO?=
 =?us-ascii?Q?MOp9+vQ3YTZmDyU6YESFY4akA6xlNt87X5La0Cfpvc0brct/ct9Bthoizo+F?=
 =?us-ascii?Q?9u6ev2UnQ4N3kBBMTKV0Bx/PRkdykc+5NmF9g7n83F6cPWKJKDlixGtr2+9q?=
 =?us-ascii?Q?qQsc+GV+Hcn33zOyjpXTXgLhNYBsM9ZYrs24xLYz9bQi3ncKM04h2LWd/BWo?=
 =?us-ascii?Q?ETh4/J0tuGcDJlhsf0R71Gdf0h+lPfQQep++n3A4MXWpJYMJeWoYtu/1FIRq?=
 =?us-ascii?Q?KC7hYm6DM3vaPODWxhhIKpWwSBQm+9EKojf0/Dti4oFkkHv5RIVxKrxojnh0?=
 =?us-ascii?Q?k1PKjglOnKEjFkwmIWkkahTwMIyMoe5TMcbpnew4gjvz8Fse9ZWj6ts2RnJQ?=
 =?us-ascii?Q?8aq5XlhBAkM46FFO7lCyVI4wEiSSP7C0S7Bh3AeLiBqKntVF2UGqF8GxfLCs?=
 =?us-ascii?Q?3/fgn2E4gImgYb1kmX81J+ddQL7TTKWFrEcQRJIEjMTusMJU/8JX2usyBwuU?=
 =?us-ascii?Q?tYxS/JggsIn6vM9AhYSnZoopzf2zyxDDLnjaVynAMq9iM7Ql1OQXGDP9fZcq?=
 =?us-ascii?Q?4o6Ej0x8hm7AmwytIc5K/OGd8AtNSBIAjqnfEFw2J1h9Bz0i1M00LcmRvOT4?=
 =?us-ascii?Q?2ebQFnvbdnTvElJdVYb8DwY5O7KsXkPTe80TAhOreGQ51EsRjJDrn8jHUTjX?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ArZdPsvfrAcq7Derp6Gv5SLCCGc/Ug7WNRqa9NypR8k1WTT+AS3iLr9BRkqxbDjzDPscYYkNswR0bCmS/73KtXDoNJGIPi0/6DjQnjKWU06gAKf6B8kB9Mjq5PsdUP/PUyxt++1Zmzw9Z8GDUQ1r9v+dh92vEuV/nAFwb1vz8htGUrP4pBIrgG3uNmw/Zux0cTxiKZCnDpqpZ45PeW6LMawacSfrDBNjGMiWCJ69Il2ii3dx5hB93NdPvthvc/BVVma6AQLbONc7vzbb2g17U1uWiX0B87qsugqveHG127/66Vrs2l6239BWHkdPdicjivrCmjlIyrQgfIpRKbddYDq7xL9ifrM/tjRwVaC/5x2xvcrghmBIk6BpDKMTWXKEL9WUl7imSl38jgbzob33ePXSGmzXg8ROPLoOgl/4uaWtmdpRI7mHeDhreV9nGLACyYmfH0+sY99hHJdFmPdoOA+C1gSlzB10RfQJkBEk8+1BbtJjppnEnVmm4BYARtucsA6t2eXJxysLZwjNCOQmCr/lyzJsEaWq8KJPAy8H8aGzKuAKC1L/+RbdtiwR4v3iilqw1kYbPFTgRvONkTTLqrgingWFd3P5qHYNlYuEvXg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c670796a-ed15-45ff-5fcb-08dd108af751
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 15:31:59.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FP2xf2UOEq8KiWiawT9navSlDDCMmNbEjFSM/+iKGUBGZFBzjQ6h1ElklhMFb12Rce3cUgs8MM8phV1UVJ4oLYV7EwqeqjI8Sm+YCLU4F60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_14,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290126
X-Proofpoint-GUID: twLV2gaxytm_5X9s3rPgtELKoZkBgQNp
X-Proofpoint-ORIG-GUID: twLV2gaxytm_5X9s3rPgtELKoZkBgQNp

We are current refactoring struct page to make it smaller, removing
unneeded fields that correctly belong to struct folio.

Two of those fields are page->index and page->mapping. Perf is currently
making use of both of these, so this patch removes this usage as it turns
out it is unnecessary.

Perf establishes its own internally controlled memory-mapped pages using
vm_ops hooks. The first page in the mapping is the read/write user control
page, and the rest of the mapping consists of read-only pages.

The VMA is backed by kernel memory either from the buddy allocator or
vmalloc depending on configuration. It is intended to be mapped read/write,
but because it has a page_mkwrite() hook, vma_wants_writenotify() indicaets
that it should be mapped read-only.

When a write fault occurs, the provided page_mkwrite() hook,
perf_mmap_fault() (doing double duty handing faults as well) uses the
vmf->pgoff field to determine if this is the first page, allowing for the
desired read/write first page, read-only rest mapping.

For this to work the implementation has to carefully work around faulting
logic. When a page is write-faulted, the fault() hook is called first, then
its page_mkwrite() hook is called (to allow for dirty tracking in file
systems).

On fault we set the folio's mapping in perf_mmap_fault(), this is because
when do_page_mkwrite() is subsequently invoked, it treats a missing mapping
as an indicator that the fault should be retried.

We also set the folio's index so, given the folio is being treated as faux
user memory, it correctly references its offset within the VMA.

This explains why the mapping and index fields are used - but it's not
necessary.

We preallocate pages when perf_mmap() is called for the first time via
rb_alloc(), and further allocate auxiliary pages via rb_aux_alloc() as
needed if the mapping requires it.

This allocation is done in the f_ops->mmap() hook provided in perf_mmap(),
and so we can instead simply map all the memory right away here - there's
no point in handling (read) page faults when we don't demand page nor need
to be notified about them (perf does not).

This patch therefore changes this logic to map everything when the mmap()
hook is called, establishing a PFN map. It implements vm_ops->pfn_mkwrite()
to provide the required read/write vs. read-only behaviour, which does not
require the previously implemented workarounds.

While it is not ideal to use a VM_PFNMAP here, doing anything else will
result in the page_mkwrite() hook need to be provided, which requires the
same page->mapping hack this patch seeks to undo.

It will also result in the pages being treated as folios and placed on the
rmap, which really does not make sense for these mappings.

Semantically it makes sense to establish this as some kind of special
mapping, as the pages are managed by perf and are not strictly user pages,
but currently the only means by which we can do so functionally while
maintaining the required R/W and R/O bheaviour is a PFN map.

There should be no change to actual functionality as a result of this
change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
v2:
* nommu fixup.
* Add comment explaining why we are using a VM_PFNMAP as suggested by
  David H.

v1:
https://lore.kernel.org/all/20241128113714.492474-1-lorenzo.stoakes@oracle.com/

 kernel/events/core.c        | 116 ++++++++++++++++++++++++------------
 kernel/events/ring_buffer.c |  19 +-----
 2 files changed, 80 insertions(+), 55 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5d4a54f50826..1bb5999d9d81 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6284,41 +6284,6 @@ void perf_event_update_userpage(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);

-static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
-{
-	struct perf_event *event = vmf->vma->vm_file->private_data;
-	struct perf_buffer *rb;
-	vm_fault_t ret = VM_FAULT_SIGBUS;
-
-	if (vmf->flags & FAULT_FLAG_MKWRITE) {
-		if (vmf->pgoff == 0)
-			ret = 0;
-		return ret;
-	}
-
-	rcu_read_lock();
-	rb = rcu_dereference(event->rb);
-	if (!rb)
-		goto unlock;
-
-	if (vmf->pgoff && (vmf->flags & FAULT_FLAG_WRITE))
-		goto unlock;
-
-	vmf->page = perf_mmap_to_page(rb, vmf->pgoff);
-	if (!vmf->page)
-		goto unlock;
-
-	get_page(vmf->page);
-	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
-	vmf->page->index   = vmf->pgoff;
-
-	ret = 0;
-unlock:
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static void ring_buffer_attach(struct perf_event *event,
 			       struct perf_buffer *rb)
 {
@@ -6558,13 +6523,87 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }

+static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
+{
+	/* The first page is the user control page, others are read-only. */
+	return vmf->pgoff == 0 ? 0 : VM_FAULT_SIGBUS;
+}
+
 static const struct vm_operations_struct perf_mmap_vmops = {
 	.open		= perf_mmap_open,
 	.close		= perf_mmap_close, /* non mergeable */
-	.fault		= perf_mmap_fault,
-	.page_mkwrite	= perf_mmap_fault,
+	.pfn_mkwrite	= perf_mmap_pfn_mkwrite,
 };

+static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
+{
+	unsigned long nr_pages = vma_pages(vma);
+	int err = 0;
+	unsigned long pgoff;
+
+	/*
+	 * We map this as a VM_PFNMAP VMA.
+	 *
+	 * This is not ideal as this is designed broadly for mappings of PFNs
+	 * referencing memory-mapped I/O ranges or non-system RAM i.e. for which
+	 * !pfn_valid(pfn).
+	 *
+	 * We are mapping kernel-allocated memory (memory we manage ourselves)
+	 * which would more ideally be mapped using vm_insert_page() or a
+	 * similar mechanism, that is as a VM_MIXEDMAP mapping.
+	 *
+	 * However this won't work here, because:
+	 *
+	 * 1. It uses vma->vm_page_prot, but this field has not been completely
+	 *    setup at the point of the f_op->mmp() hook, so we are unable to
+	 *    indicate that this should be mapped CoW in order that the
+	 *    mkwrite() hook can be invoked to make the first page R/W and the
+	 *    rest R/O as desired.
+	 *
+	 * 2. Anything other than a VM_PFNMAP of valid PFNs will result in
+	 *    vm_normal_page() returning a struct page * pointer, which means
+	 *    vm_ops->page_mkwrite() will be invoked rather than
+	 *    vm_ops->pfn_mkwrite(), and this means we have to set page->mapping
+	 *    to work around retry logic in the fault handler, however this
+	 *    field is no longer allowed to be used within struct page.
+	 *
+	 * 3. Having a struct page * made available in the fault logic also
+	 *    means that the page gets put on the rmap and becomes
+	 *    inappropriately accessible and subject to map and ref counting.
+	 *
+	 * Ideally we would have a mechanism that could explicitly express our
+	 * desires, but this is not currently the case, so we instead use
+	 * VM_PFNMAP.
+	 *
+	 * We manage the lifetime of these mappings with internal refcounts (see
+	 * perf_mmap_open() and perf_mmap_close()) so we ensure the lifetime of
+	 * this mapping is maintained correctly.
+	 */
+	for (pgoff = 0; pgoff < nr_pages; pgoff++) {
+		unsigned long va = vma->vm_start + PAGE_SIZE * pgoff;
+		struct page *page = perf_mmap_to_page(rb, pgoff);
+
+		if (page == NULL) {
+			err = -EINVAL;
+			break;
+		}
+
+		/* Map readonly, perf_mmap_pfn_mkwrite() called on write fault. */
+		err = remap_pfn_range(vma, va, page_to_pfn(page), PAGE_SIZE,
+				      vm_get_page_prot(vma->vm_flags & ~VM_SHARED));
+		if (err)
+			break;
+	}
+
+#ifdef CONFIG_MMU
+	/* Clear any partial mappings on error. */
+	if (err)
+		zap_page_range_single(vma, vma->vm_start, nr_pages * PAGE_SIZE, NULL);
+#endif
+
+	return err;
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
@@ -6783,6 +6822,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &perf_mmap_vmops;

+	if (!ret)
+		ret = map_range(rb, vma);
+
 	if (event->pmu->event_mapped)
 		event->pmu->event_mapped(event, vma->vm_mm);

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4f46f688d0d4..180509132d4b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -643,7 +643,6 @@ static void rb_free_aux_page(struct perf_buffer *rb, int idx)
 	struct page *page = virt_to_page(rb->aux_pages[idx]);

 	ClearPagePrivate(page);
-	page->mapping = NULL;
 	__free_page(page);
 }

@@ -819,7 +818,6 @@ static void perf_mmap_free_page(void *addr)
 {
 	struct page *page = virt_to_page(addr);

-	page->mapping = NULL;
 	__free_page(page);
 }

@@ -890,28 +888,13 @@ __perf_mmap_to_page(struct perf_buffer *rb, unsigned long pgoff)
 	return vmalloc_to_page((void *)rb->user_page + pgoff * PAGE_SIZE);
 }

-static void perf_mmap_unmark_page(void *addr)
-{
-	struct page *page = vmalloc_to_page(addr);
-
-	page->mapping = NULL;
-}
-
 static void rb_free_work(struct work_struct *work)
 {
 	struct perf_buffer *rb;
-	void *base;
-	int i, nr;

 	rb = container_of(work, struct perf_buffer, work);
-	nr = data_page_nr(rb);
-
-	base = rb->user_page;
-	/* The '<=' counts in the user page. */
-	for (i = 0; i <= nr; i++)
-		perf_mmap_unmark_page(base + (i * PAGE_SIZE));

-	vfree(base);
+	vfree(rb->user_page);
 	kfree(rb);
 }

--
2.47.1
