Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7A474263;
	Thu,  1 Oct 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878874; cv=fail; b=X03RHnmrwVvu14uayNslPwGup4tFwgT71B8WUtn5f6BUrbVMwzO9Bve3c43FG6SguBgahQygFnhZhqKavZLd78YY+RcXaBM5bIQS73DS1UYfIJFJ/o79nr3TsrKpidZpEx3qcors3Ewczup1piLp4H9vjDk97Rp/vqvR6pw/7QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878874; c=relaxed/simple;
	bh=1APazVijcVhO8k88YGdSRlYtUBk84bHTAw1vdgUzSgE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=d6aBQEpmUaXIiuXEF5R4oj1ug+x9pZ9TgN8X6PItDrMsgYibZz3HcyPq7yL5O6ywq3WxCgA7izOrjcjXbQiGJhbNHMlJ5ely2UYw0WY9KKkodskuBFoAKuWgoJZx1ZCDogHVoKhHp/2nt0A+NYNAQLK+XhPJde1sJcnkbOVKXaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZMWisX5W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uMx6YI4J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZMWisX5W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uMx6YI4J"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FtjJX907927;
	Thu, 1 Oct 2026 18:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Gqjobvbq+KvxEp6P
	dBYahhLIwzBDpK4rdQGMcdxou8s=; b=ZMWisX5WENnqz/ymPSQbPKsY9cak9sgG
	p8zKi+RvWpRYz9vm64ng1Jm3KvE+ydoYyBR3PfBj2jrCP8GSxnbWHR0snelfzPtN
	GELx5031mEz/inNgti9Vm3BWaLuZsop9oOSe91MpNTbBQoMwhXYtfLgypVxYA3iw
	/Zp1QCpraJpF7+ZAu8JXZ6clqlbXjfAKQiu+bwOrVHHoov2kP/vmK0jb81gvvhwZ
	MIIAu76JZdFQ9YuJ35f/DlZ/fwtqAYR/YufbpOCgWM6mUHkqPiid8bYMv5ElJnsG
	P2zxNEnb8EgNijZWRrfEfifWIAAUIGSMdbW4lRWwaiVwvpjY5SOL8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4u2hqpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 18:20:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691IKP58008376;
	Thu, 1 Oct 2026 18:20:44 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gt4e5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 18:20:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIzRVI9xGJcwEWuZaWYKLu2pB1ne76PdP9Xbq0q1ufjd9TYWSz//rFl5CazdmZoW79mMT5y9zvKzMoroscj8eHpgIQnX5f0h+GmWj3bIZRMOZegGTkvKfeKWrI1aQ1yhZ6/furY7A0e1C0NF7LArdvnp5Px8IfvWvNyv6GRigPFA7yhg+mJIe5NWyxM9EvJ6eISfgUIlTpvVfs6yZceFJrMZrFPNzjp1Jo/KsCcPAa1vfjblcV7AkqXRXG/SViDWIM4gAHhctPKA6fnwYti2Zz4bTeSqwLvQkvndLm4/xkapkmzFG3LjBDe5Kx/Wd4fWdeeMFbDqqC4pk3wCmu6yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gqjobvbq+KvxEp6PdBYahhLIwzBDpK4rdQGMcdxou8s=;
 b=W9LXBM85cVojP63K7bqcJ9FcHTPhdrufD2MKlF3qJ0gDlWIcQlAV1rzgBSLKo9apI3FWh3e3Z6PdFSfw0Da5vXgMkadGLr+8zhbPii8rvIeH9RAR4PhZCgd7LGclQK4orvsi+HJRj2PGhSKDRsJtQxqsQrsvqNjyMIuZV5Jy79jfD0T9SAKNQxS+ag63gx9PmyOvP949cgjEpAGLAskzxppYMoZmphbgNjP8+r16YzE5vw4NWnWZ+HgVguJEL27tlNP5onu7W25IfzTSEL/ePDvNlCitL550D5oPHviZsEDKaxR4DOhrMxEqCn1EGoSttqXG1FnJvx5FZf1HiHly3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gqjobvbq+KvxEp6PdBYahhLIwzBDpK4rdQGMcdxou8s=;
 b=uMx6YI4JcjjA2o+DNy8SkMbe9jSLJr0sus3dNQuUlemIbYplD95TUf2D1I4zIrB32oIcg0Lk0bIkIFPw1TNVlMNrOBW5fXjo2kGhyjejPlg9hYEfrKEKE1ZSSWShrYMKD1NF1Q9E+E5dsjPeW6ZFf77hmN4klpUrxJEExNqyzuU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DSVPR10MB798099.namprd10.prod.outlook.com (2603:10b6:8:381::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 18:20:07 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 18:20:07 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/2] perf script flamegraph: Fix input file name errors
Date: Thu,  1 Oct 2026 11:19:59 -0700
Message-ID: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DSVPR10MB798099:EE_
X-MS-Office365-Filtering-Correlation-Id: c53109f7-9a51-4fd5-19c6-08df1fe89f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|6133799003|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	EGmLlWxcPQBk/l049qX9ymo6LntH+pMePUmW2cBK0PoF0ApnuXsxsfMZRJ5E7EvRTYIPZrGHe624fbZk0hZ4qFaXBMssphfC8JUKW8MY1/8JHHr0VH32AvtlASuHbACx5DiKQmfaM7Kb3KTy3fnG3jhOjb6vBWUVPh9g2+Z++ft0jC/vYT6wW1BRxyjW2e8KpbPVpWZT9rx5wCau4dswXEVOcIHHg1N3RJ4QS5twY6dkUfgfnGtTlosXZNn6E5QMmBEvxC3kA2nEqH9ab32O8Bh9jNKdaPdq0CQnRfWiMey6J7DXtP1nqmy+OegppnnIfNNETlf9dxJQt5AGbU3AO0x4uND0OGXNW80KThNaJ4TvJ1CqPNQBAr0YHR2Hi/nDxCA7RlhsGwGfeKHt76xdNZG9hp96zIK/9FeaRoxyfH+mOhXnN/wWh69+s9viizs7g+seV7L/Ge5dWNw11wWyMXXFD9pjtkV+m+1l8PhGjgluTGWFEDFHxOSMVLlOXQIq6KSvOyzeZPLTxHbbQ2ShlMrhaq3cpD3Zn83wcfDfoLFN6vUy0mYMFFWmjgSWzp+ZqwvX7yGSX6oRbVxlD5o7+zvQf/JKfKTiZjirnz2ANJj5fiMPLGBR2/o9R3iciOvJjKU+KhWYx3j/PR302ReayV2YVJ0nS/onBlw75dhazTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(6133799003)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xR208SAXt6ytCZgFfvIpsDi4dNkFVOs6SRRQloLX9551p19cmTE1EILYHVI?=
 =?us-ascii?Q?H8FQOfr8B2RlV0FoLxDcjdaURAC7GoZ3XjK+vh0u5cbk58LZ8cTm4Sz6zEeV?=
 =?us-ascii?Q?GCKRIGhEDan543QB6xws3MPzU1UsUnzVBvy228vRe6kr6AZjkV+4ywsdkCrS?=
 =?us-ascii?Q?U5K+Zm1JJkUZOcjC4tGf94y0MEOQjqFBnBEwmVjqvWhYdIGR04C9+NoHhhLb?=
 =?us-ascii?Q?tUkPDFl2WHc/6LcJ5XRPY4MIesM28oeSqVmh3q/6NFVh3UJASUtHHQ1tPzVT?=
 =?us-ascii?Q?Uy6kmtbtewAPk7tBjzlR5rUsKxazquOgDoK+jH3pzLsCuEZj7ptqEbC0pnSl?=
 =?us-ascii?Q?uD2QCnzUhbNhQNxUOY3mVLgbAsro7fBMjhua9z7i/g01d7fXt+l+1HT7nVeW?=
 =?us-ascii?Q?QKZyiJj7p4tfQmDMm/GaZrqn85FLm+JGkcrNXNG/rhUi/1vlph0M3F3/Yjrw?=
 =?us-ascii?Q?vNsa3yHjMAPaKV/DjzGlLARAYaoaMHC6cZ4pmtkPRE+iZcispcAEmaJ7nXH5?=
 =?us-ascii?Q?a1shKvyuZB86CXFzZMBLnZeEwOYWgGB9LxVXoESp9ajmNYt5jyJJ7ssvZuOi?=
 =?us-ascii?Q?yVExI0DlgtUI25zXLrdf939HNUnlu3iZRwzJsry2eTk9sO3mf43P8SK7iJ0T?=
 =?us-ascii?Q?/mNA1koE3BfGmEn8SVzoXNKPu4+ktnqFn2j1Nolba7V9FvIOvH5Z8ZUkpnqx?=
 =?us-ascii?Q?qG4b7OM1X7Iw7tr9WeFaFhkYNv0XBDYjX35iEdkIW1u3OohgfNiGt36YR6Sq?=
 =?us-ascii?Q?eu1WPxMCYHhlhqb69NaCt1MDbD/CM20gb68vomYbSXMeKtX2XBgjX++hHJtp?=
 =?us-ascii?Q?Yi/JVZhl5glS9SGG3Yv6F0DKyMuwJftxQaNMYi1F0hCBgmKVL+2u/YORKOoW?=
 =?us-ascii?Q?KqkLjGtvK7/BnVepxhIZt1L92S4uRo36ld9wJF3pPpam8K3V0j1FJ8BMultr?=
 =?us-ascii?Q?pshQljzrlG4PERMQOhMgnlMhfklrAv6V15J+GsMWnV8fDXOAszSedIKxlWoY?=
 =?us-ascii?Q?H4qAKut3zVXVnlOJ6mDP7b0D1PCpLusV2PcRpGwsJEtbf2VLWA9LX5NfL4n3?=
 =?us-ascii?Q?lFy/aaORNwvw0lOQr6VY9YoktUAU+E3Yl+L+KSyqDbjvhvA+fGStMxm1cWWf?=
 =?us-ascii?Q?wg9OxmvbpGVJlZPMVSR/8RpGrZWIzng49fQoKm5VDhZ9zUhvh028WBvEjt7k?=
 =?us-ascii?Q?tA5P987/uiW9OSe8FbqG21DSuXdOAq5BSFJIepkNEkjsnhY4/GMBlcJlS7+X?=
 =?us-ascii?Q?ku95pJoXoNFs7OE3KiDPqRNMl65FvzZmiedbDWtwcRhFjIh1lWg2kjMgIQ3u?=
 =?us-ascii?Q?ZXpdDy1O9aREY+TcpVohfde0r/tojqUZSaI7/+wZLXwYQcYye0HOG6KBS/2V?=
 =?us-ascii?Q?pQc+KelgwIk8OHOcQWg12zXU24usPivpThgXWOySt+w8ps4Es3QRwt2o24uL?=
 =?us-ascii?Q?AHyQyet1nzx7fOfnjhCSOmJN95piZEyvEagBGH+blnO+7EiIoawTMv2vpg4s?=
 =?us-ascii?Q?KHrH5iSYipZpnqvg+7khY2S5JXwz/EnAbFtxlpnDd74F2SsDpB2V1Xm4KYvB?=
 =?us-ascii?Q?wcltsd+1q+kovwiyaj3c9SPLSx5d9KFkQsgZ2Emqfs9aYoCCN0Dm7MgOq5XT?=
 =?us-ascii?Q?AB6AcXwflx66mVEJQvKQcoZQBPZ/XuGdRCeg0WtTbgpIB8E/pxtHkEO+1jvI?=
 =?us-ascii?Q?2aQWFBuimkewT9OHZ+TxcWo7fURoa1opTWXx7aTXEcSaXcAiVh5oGhxaS/kC?=
 =?us-ascii?Q?Kqctbt53rEBqP0J52x3rY3be511abcQ=3D?=
X-Exchange-RoutingPolicyChecked:
	UK99Tttn48gJpnSlWX+o8FAFhMXBO4fEa2/VD28yc+SQiVVk1hStUZGfPAZaIxa4QMRBRSpojlqyy75EsfK73fXb//WfH5Kjuee5QjMAfBtt8idTrM7uZDxD37fSVMaCjq5TZnl564Ul2G7orgygIgwF7lenWDSV/sLIRAm2Qe8zU/qd+cRYXBtqrKNUOuMCKINJbiOzwgFME4otyhtpBFj3PkJm5pzYBNsjk6ZODQnkZ963iCWxz/HnGdIrqonkgNU5UTRULEuQ+SiSOO+IagAbFlIjt+B4KZy9dg3lNTgL9o1XEW0HBirFrpd+iqDssbS8Ygbj5umEZZwInO+T1A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TfuGhRGBh3jHmUOa+siFdG70+/ZgwfRXKc+4UZC5MKrX5Bw6ie1qhX61M92eRXtAEmz8fAqAUTlUPYWH0Y+KR6x98kNuwCQfDQ+LFkGnkNUzBWXfy16RWzi++IixeCLMBN/KlRDkmySIfNCaDEzia1ofw1OrhQw7Fl+3G3j2STkeps4ygj8BNIRUchMFftwyJXkDon+kiEHsf7bVRJL9PlqjKePsMm+5H376flA5JqQE01eG238US3DqkOsYgLFIp+HcUWKhtFBOb7zfAuVCAbWLzpI+7i0WBGsF53B7fLnOtgsGl3sFGgMCMJx2PYaBYFBwiwqAe0rBSzZZUNuB5vwQEvEAjDnilbmXU4UhDnHmt6uaXe2whrefhB/k+06AD+akLZOVLxEivSRspK/DKmLWH7ZUbrS8J09KwwveOoqM9FRpE88V6cZGTHmauvBgMJxVWxcnh5uLZlUi7CO4Wa/UviMpBiO656C3IQ6iknZcfeeju15BVYQDY+jAI88cwGo9kBUH9TUPbUSxwZaY948a0ywE71DlT7RCbvLULEEtzVoVoEyseg9yICH8n0x2lMjP3eJ8PN/I9sjqspEOrJbHIGjs9dzNnFKAt5AUVW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53109f7-9a51-4fd5-19c6-08df1fe89f23
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 18:20:07.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGOl42TP3/N984vAJumWBKn/gKMjw7B5WJq/yRJwjXqO20MiUvYu4AfhFElfNQu1E375Ke/M4EpQiK7VuKZzA6mufg6NDWrNnpuiTUl9+XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB798099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010073
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfX51xthCq0D0+Z
 sj8CIjBJCtDmFsKecSifaJr/6NEwemsxitQICEuzMEFAUIGqhdEvS/qNy2tFEV/Ytm4WBQIcexJ
 UY7EEvU4g69jycMoqwbZokH1FJgiKG+eqf3dXjzyPqMK4AFni5zA
X-Authority-Analysis: v=2.4 cv=W9itxhWk c=1 sm=1 tr=0 ts=6abea47c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=_3VD7Uta1GpMSbdIbMoA:9 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: f_F4RMRZErc763K-KEGjXlcxf8KBqfzb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfXy6aWDzhOV3yu
 15KJRwDlkkG2TQQNbd4Jus6eI6SM85RXMngwQYGiQOX61/++nuWh1mv1TmQCQui72rupF8KgJiJ
 dOfsR/seC2gJLllvN5xYLmtxEFuC+1Nd6ShKrmUq6ZOJeJghkEHoEHV5kotcUauJBw87ltBaGbk
 m73HMZKIOUley69MI4J8voz/8LKpkHJHF70TWkp/fb/iLfprjZ5hom3q1GQOZotiYNBPrbjajKs
 DBvHUbmHHSM7ubGMy71ixqQIBINRnRn94GEtKsMzeYc0oyX5/1UoSsMhNGTEdOoBQernCpu6MN7
 i/A/hTUIBiFSpKTFQ4U745OlhoAmZhzzli1dPRK4WUXQqqbwWfM9eWHkyCAQTQDHu4jGeheoTxk
 uo5owgLVH7DusidNXVabe9nXhvBGRDBDuKObh3TwaMODW/Tywvhv7njM2fh9NsQH4MfpB/bMgYd
 Bv7C7XIKr0McvkUZUedjLyyGUULgzw6ryP5ypACE=
X-Proofpoint-ORIG-GUID: f_F4RMRZErc763K-KEGjXlcxf8KBqfzb

The flamegraph.py script has a "-i" option which it uses in an attempt to
know the input file name for the data it is processing. But perf itself is
using that flag and not forwarding its value to the script, so the entire
strategy won't work. It's further complicated by how the option processing
is handled in the flamegraph-report script -- details in patch 2.

This series introduces a helper to allow python scripts to see the input
file name, and then fixes flamegraph.py. Testing with a variety of options
like below shows that it is using the correct input files in most use cases
I can think of:

$ export PERF_EXEC_PATH=$(pwd)/tools/perf

$ sudo -E tools/perf/perf script flamegraph -a -F999 -- sleep 1
dumping data to flamegraph.html

$ sudo -E tools/perf/perf script record flamegraph \
                          -o myfile.data -a -F999 -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.891 MB myfile.data (1832 samples) ]

$ sudo -E tools/perf/perf script report flamegraph -i myfile.data \
                                 -- -o myfile.html
dumping data to myfile.html

$ sudo -E tools/perf/perf script \
       -s tools/perf/scripts/python/flamegraph.py -i myfile.data
dumping data to flamegraph.html

$ sudo -E tools/perf/perf script record flamegraph \
       -o - -a -F999 -- sleep 1 \
    | tools/perf/perf script report flamegraph -i - -- -o manual.html
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.936 MB - ]
dumping data to manual.html


Stephen Brennan (2):
  tools: perf: add perf_input_name() helper
  tools: perf: flamegraph.py: fix "Error reading report header"

 .../perf/Documentation/perf-script-python.txt |  1 +
 .../scripts/python/Perf-Trace-Util/Context.c  | 16 ++++++++++++++
 tools/perf/scripts/python/flamegraph.py       | 22 +++++++++----------
 3 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.52.0

