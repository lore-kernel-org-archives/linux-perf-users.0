Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB212192593;
	Fri,  3 Jan 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918345; cv=fail; b=V1XJAri+VPs3xE+7GmSZHLI0cm1ooOVr2FQJAbsyH7eJsLb8QEFT2PkDbLxg3zJFRW0kViUXEStYgoFrGNVrRndNONMzQ/B7w7UnDayLZANJbdsWMSGrpBj7boXkcyrJomPCAmYF7SooIs9w4a9X1LKR2MjaZYzzgWD39EtKT8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918345; c=relaxed/simple;
	bh=YD7bAB32WaTYzNao8P5o2p6qelZl5pfohK64b3Tqgno=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZzBp/BNjSiAjvDBBIXuyx725Hc7Cood1BWwWZOO4+NNsgRtbrdqDK3YDRdMuN8ov6zlhC08rzBMPkQeNn2PMR1Tb5xnZpDfkopkrRXIb2y6KDMtOB72W02PLf007KreVcDm0hZgk35FtMLa5u0YMgH5dXxToMwjFxQ8iFfYPhYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J0dvwcoU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x2zpwnGV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0dvwcoU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x2zpwnGV"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503FUidp010281;
	Fri, 3 Jan 2025 15:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=IAnL0kNo8NuIU5aW
	vLz/HBYSr43yJvWUNewyuIe4SKc=; b=J0dvwcoUpVWdlOpLruIMwSPTrGuxkds9
	3boAzrI8KEPQb8R/3GnAaM90cRF4xssNe/AO/W6uIifzxz2QfrlFn/6+6QWKDAwm
	Ht85sksStgH3OMJqQ1EkcGSU8tsRGO8tfdX6lMXZ7GANPD6CwUjJ4DDXGrpTMCUx
	ZnTE6tM46wPdsMWiBnoo+LPSGF+qx9uqWy3y01iD7Mk5CeWkU8RAsWzazSTTLE3k
	6mVBJpqruzliO8IpvPveIllMs4H68l8NNjqhlTfNHB/X8JOmovBq3wvv2+Nsi8Fs
	YbuJCkl9or2gMGbvWNKI2jEs1ONqzhLEiB19qRfNxPyVjBB7Kp0ZKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t8xs87a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 15:32:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503ExJOJ008778;
	Fri, 3 Jan 2025 15:32:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s9snve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 15:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDnc+jAj3muGKnnKA7yI3wswJxINrt8um6MiHkQCQfIMEr8KPTQoLaPRHZ2Evwbc5TNcUyIeYbWt9FaCPxMbor7wvEWdVrRlHXu34Zr9U/jEbVkl41bfbNIdAvZhC4CMDJVVRA0+Q47aZ5H6BukpTGMs7q+lVfdFBG2OtKoH+1etmVlqER8DYm0HNzjJbm7kyKk5Vv+wKxBmn81S+0eRBb9OBxyzUaKGHnu4N6BbR0pyVqMnXW2HNrSb82CcOFYUMZxuw9KNuGk1PzSeRWkkB9Z6+zLMUhd2M8FtY9J9pYHXgaNErnW73w85JfW951M68E1HcRxZJphY0JYoYoFQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAnL0kNo8NuIU5aWvLz/HBYSr43yJvWUNewyuIe4SKc=;
 b=dXxvhtYjyxBVJ/pOuO1ttJ1u+PPBETyy2k3xle3bNyemo+IrpbVKQKBalWTpRPwaEVrCpbbJB36MviY69IHzdYZWjIp5Pv4KAZZMOAuNYqHAorhC2Tlo6lAE9zeBCpBoj35kH/YrFCB3yYmqEigZYxhdhu8XBGpr+tZmsOnbSJHwTKv2Ph4HfCcSsNSA86d3FEZqUOXPeUTKpSqSXvILoujSX9sxkf42x9BvCYNu5KSjk6+qT6sdKU+GEXH0BFIjfs3kP0MOtVeJSM5Rhy85/XHYJEbUkynB8PpTXJCyfrUYPgVLyj7ClqUFiEQX/q3ecoZiqnC0e7pVNeccxkRkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAnL0kNo8NuIU5aWvLz/HBYSr43yJvWUNewyuIe4SKc=;
 b=x2zpwnGVGMDsOPUD5s2NKpc5pl3M5bJw8DYYKuNOxqRjwdLoeabIhhwooBa9MkMGR7NqN5oJRmt2kcIKGJ59qoY+tL1YPzFFaBLLnL+cY8YYXKUs80o8FjTCW9qUndLCBr73viXUTJBxOAEo06z2ICZh0tt6XUlJyXWbvMBSEYM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.22; Fri, 3 Jan
 2025 15:31:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 15:31:56 +0000
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
        David Hildenbrand <david@redhat.com>, Yi Lai <yi1.lai@linux.intel.com>,
        Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4] perf: map pages in advance
Date: Fri,  3 Jan 2025 15:31:51 +0000
Message-ID: <20250103153151.124163-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 2002bd69-4abb-4fde-cb97-08dd2c0bc1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dvvj0ooDeNx74wLfVy4pYbAiuxljiUJ6Uy3/H8i6CIeXSjpsFALCMENjKCO6?=
 =?us-ascii?Q?HQDtFYtIC9QcP1mMSdhglCzNcizXXFAhCUHXl85RxP7cu3/5qZbJGZ7y1Sf8?=
 =?us-ascii?Q?wgtSINGlibWKSaxJW7QeJOEYFYCY5wCFnXoXGCnVzqV83eeUUiqDoRG2A394?=
 =?us-ascii?Q?C0mnCJtCjBJC6Bf2w216vekenhuSyQ/Nx6Xlf6nkefv0lS9ppDNUpumQscT4?=
 =?us-ascii?Q?zc4ie2VeEELiDR9zyFKqwsvSmqWaq/Ycj0kfmYn2cppgjCYz6SEco9hCOmoL?=
 =?us-ascii?Q?x2IuKjfL1icvxt+lWRpYpg1YvF+wDHr6ehacLMGXQ+Xpp42rJ+ewjG2BCNx9?=
 =?us-ascii?Q?t4zYLVyi2zwpMbj1lTaJzLYv2DvUyH6JXpEPYBpga+2buoCpCFxkrINqWYMN?=
 =?us-ascii?Q?a0bOMU9+augtIuhDTl1XI8MbYlEdJCG1TPwmsGKoNZRdo0tBue92kugRbrlT?=
 =?us-ascii?Q?lP1Jpdz/4xVvWQFH/YBdfpmU1fvYERoz24omUEIQXm8F4LvfvPqa7550E+tR?=
 =?us-ascii?Q?BNOUI9rEUTxBVXZyMlDI/in+AS10gi3t1xWbMuTBGhEMxk7Xy767Cuh+6cfT?=
 =?us-ascii?Q?b0JhGvsj6H8Jn9pZugiCBisBNrxzW34PPxpVKFstPm9rU3cyFLIHLECYPiwi?=
 =?us-ascii?Q?kJD6IqRvfDqxD1USvyKlf3WO+r5msM8e527zi0mb4t1esinyrDAmf2SeAVuq?=
 =?us-ascii?Q?gLruKW7JP7VyrAS2BeU3pYzfmlUYcpWYZ2aIj1eU+Offe2v7Vi0D7YkmvN72?=
 =?us-ascii?Q?DeZ1tvaQsncRbF4j0ybRdTB8d68191N/ImVAOv22Kcbez3H8aMligBzPnfEn?=
 =?us-ascii?Q?sajHKmt7g/lqYvAz2eH9M2XMjOsNjPdubg0e9G46qI8Qg8aXvoLWDkreFP+p?=
 =?us-ascii?Q?TgPbm9VAKxvR6+HdLUPTHEOhmrYaffOE31dJUM/tAs059SIpPumpewfhtms5?=
 =?us-ascii?Q?6qGYpnsOPy5bZv1NpNM8iaYbqZ1WX5D2st3Scx6Yl7T/dttyH9g3Zxy3QkdC?=
 =?us-ascii?Q?0oB2G8NRjMrNLb3ZImwT/gT4dlaW67h8lNRSG7qX6yF0dapgn8Sl23OCeb4u?=
 =?us-ascii?Q?MwL40dFRjK81146nDGZmcFJ2tLvQUu/jDy0tvQ4IuLQCv9rPUfTXIx84sAsZ?=
 =?us-ascii?Q?VEgeiFaxd6RQxRrPQN7Eq/8XjZpNSiGlOSaug8PN1Tsi/NeJarNB/lXIxC6c?=
 =?us-ascii?Q?gAj1033mYad61zpcNDLbcIjnm0M42psphqyi0iKpYoD8IpUlVKATd2cPTACc?=
 =?us-ascii?Q?VpprPTt6Cp9wEWvrpPipnwbBzW02Ef4Yo1hiWbbCJp8s74MAK2bz//822s/4?=
 =?us-ascii?Q?RsYJQrV5Y/tirNo4Ki59ahFjVe/MrJzmrIkJBIuCvZMjbVRyCOKYpJ75JMLR?=
 =?us-ascii?Q?xq5zv5XsD/7uw9kSX87W1gzeZFwLENHsUgLAX5fQelkukDeYLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EqL+eLqbj/PBrhgaHlgP1dd84vABhOPtdSC9k67aneUyyvvIGbWCPvn5bWSJ?=
 =?us-ascii?Q?dotLUXuF3GbThf1S4PZ4B2//q/jBaiJIHws2VKCdyoNXX7wrcmFO/Vk07FYU?=
 =?us-ascii?Q?fj2bpwYwSEYFq4+Y/F7snTlEipFfBmDvoDUcJI11Grue4R7fyeSJ2AwJ1ng/?=
 =?us-ascii?Q?eQU3qJojQHEpqWUcDlV5VBpTeWKKXN0epaQ6R6hmq+jyaFm+Fs3QNUPmGhwf?=
 =?us-ascii?Q?QwiTOdFDkMaaDTtjDzl3cveVUtR6mO3mq+mZt11jpIpBOrgzrB4XHA7lrE6n?=
 =?us-ascii?Q?pW4TznRUvaLypvLwKRwNuoiDhTBHWAeMAq0LN0y3iUB3GLhIT9m5Jd7fnkHA?=
 =?us-ascii?Q?FpxMKHZXsNHh/Uwl4s2xCsC6G2cP0tYZLBhBBLNqVMXVHF0bI2tcA01G8k09?=
 =?us-ascii?Q?qjHnMZSpIKtbsYzYmbH9cGJm+VvNZjYLV/D/WMCb7GIOFE4wvEh/qB9ZnDg/?=
 =?us-ascii?Q?6h0dx2+dSv1aj0wel/+QCTIHljBIaNR1STpr8vqY11t9+l+vOd4EDmvaToRL?=
 =?us-ascii?Q?sPpofc7F63Q8rcPrceY3ohMH1HEjJG6TxZ51vYOa8009cH/L79u1ulA/uICV?=
 =?us-ascii?Q?9PGr9GtiIcfozis1IYWYYe2JL+aGN34wozrVcNUPvmaPNiyGv1aek7fWHnwF?=
 =?us-ascii?Q?nw77vOoKgd/5nhTqfatRV3b+pmevD0gxngFMP2opRl+Pb/+Mwrq0gVupnJLn?=
 =?us-ascii?Q?D9py6ZLj18HanNdgqnCs8OAlEHmO12W7L8+XHDg040ENuXS9GZlcvomJ1Ps+?=
 =?us-ascii?Q?SZMDZl4f+me77nahdE4T2zmRabidvS1JEuzBhGRe4ewkyRkWVofuyY+eqo/e?=
 =?us-ascii?Q?e7edATUE6ubwnYnRJaek2Y0R7NXAUOXPPa0CIj7mwncOq/giUUI+o+a3nbal?=
 =?us-ascii?Q?wg47KdpMazuvr8MaFUC8QLkkSK6Q3UHbP8i0lcq1lelFy7Vj8gZHwck6OjfX?=
 =?us-ascii?Q?tXKWQHI1uSjDVnvswcyvSlB445rKmNj+WYNPTn59FLhLczevo9aA35bhu7vN?=
 =?us-ascii?Q?/VxB1oL+hWK5jo/of/QYl/Cq4twAUH9yzMJmvocDceP0mG9UZwlB3fXtlfcA?=
 =?us-ascii?Q?j35eMgWcB4fiOjIjYmXgYUlRC9E3Bl631pGQthRcZJssxbqh5WxoUbTQ0zDX?=
 =?us-ascii?Q?rfiuESL5qznPLr+7wQlyqCrQCP61vVK8ms8FUKInJ1uoGJ0RrMiBz7xK4Dn9?=
 =?us-ascii?Q?mzBNwEuJer8pZRRVzVbBbuaZZ0b6KMnfEWs7yEvcZXvOZx9tg0fZ4CB5VwTz?=
 =?us-ascii?Q?EZjJYH0AgnV1wFXAlyoDI87UZmxfuUCf2OCB79glt8VkOqjvrcg5qegQJCVs?=
 =?us-ascii?Q?THE4sFpbqPy8p4ZmW4Y0oLTVmGODpI0GpRT3plp4WGqNxHQvfNHuIQqt7MbF?=
 =?us-ascii?Q?WmOURRxMFKkExQnfRIo6nj1sCZ0FxloggIiXWtYwGEO3Rg3hEAKX1r6u1NEZ?=
 =?us-ascii?Q?usF+1FH3qPbcpYnGbMrbrg4aFICpTQM6uNu+rbCiEk1Me9kjlCHrCaWe9g6X?=
 =?us-ascii?Q?uxhQutqL6DKVirezy0fcI1uN0L8wJRHdcNe68+XDMdMjNl20lnM7psrbkUgT?=
 =?us-ascii?Q?5Uz5j7GRSseBhrDeVGh0xEsmTlFSKG31fTzBSflJF2NTfYHQtk5K+bkT3lLS?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QF52o3tskcxDrZ5WhdwwaTiiVHzQioqhUIY6ZvpU0cEqokG/dYo9BZAcndAmghOVQJXf8SEsYJtzYMw7I2CoQHxvaps6UyqNkaIbG8wYu8P2cWhQ3FsFcGOxW14M70xxfVN/cI+3L9LmguQ33nAcA0eaanZClMBFlAnRHOoSxfK/vYaP7MUEs2JfVzpnrT9MoAVpVBAs9++Xdo362q6tDbSCGYDcfuTIZJ2FTJR1QucbImMuV2m3JJubRgJpet4Jex0/Z9tieRK0prqFNJt3AyoQOL8pkblT1/N+TzRCMNyD+LojB+vvLuTiRYR+Tu8KKCuJJoTz/Iqf/5rY48mwvMceu4hlDNNbWuVKWuyOknTrA721dO+U/K3I0AtiwncG2D1RSL1V8T8xH3F1YnYY3RwPpkXY1/CcFTPGW6E7LF9sFG/da6ycuEYXmvoY7U5m9zG+bpwKAuluWVSF7voM6NQ3L47MZR+jc6LyvJ16bTS0XMQZlKe1zXjfzSPJ6jHxKRvGtjN8ck7paizM8d5KtiroG8VDA79PW4JRZ4b0GrgE+C1/xGMWTcFe2wlpU0dTu/Tbq+oroO7yEPg2rqeMtOBHU1ka5Vgx7ok7tDoxG3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2002bd69-4abb-4fde-cb97-08dd2c0bc1a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 15:31:56.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRQg6SyUXRfM6pUA0WwDtfgGkJ95xknDPABq+8s/hAoehPpxWg7DMjtDO4RRif5W5LvHBsa4eQYsLxEay5mZ8V+HHatscWhlgc/qRs1vCLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030137
X-Proofpoint-GUID: 8RlWodQo0xLe-E0rdd1mUQ4MhG6pRpNg
X-Proofpoint-ORIG-GUID: 8RlWodQo0xLe-E0rdd1mUQ4MhG6pRpNg

We are adjusting struct page to make it smaller, removing unneeded fields
which correctly belong to struct folio.

Two of those fields are page->index and page->mapping. Perf is currently
making use of both of these. This is unnecessary. This patch eliminates
this.

Perf establishes its own internally controlled memory-mapped pages using
vm_ops hooks. The first page in the mapping is the read/write user control
page, and the rest of the mapping consists of read-only pages.

The VMA is backed by kernel memory either from the buddy allocator or
vmalloc depending on configuration. It is intended to be mapped read/write,
but because it has a page_mkwrite() hook, vma_wants_writenotify() indicates
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
maintaining the required R/W and R/O behaviour is a PFN map.

There should be no change to actual functionality as a result of this
change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
v4:
* Fixed silly error where perf_mmap_to_page() was invoked with a page offset
  equal to the page offset _within the VMA_ but not accounting for the mapped
  page offset, vma->vm_pgoff. This broke mappings that are made at an offset to
  the underlying file.

v3:
* Fix issue raised by syzbot where it's possible that ret == 0 and rb ==
  NULL, leading to a null pointer deref in perf_mmap_(). Thanks to Yi Lai
  for reporting.
* Fix typos in commit message and correct prose.
https://lore.kernel.org/all/20241205082948.56212-1-lorenzo.stoakes@oracle.com

v2:
* nommu fixup.
* Add comment explaining why we are using a VM_PFNMAP as suggested by
  David H.
https://lore.kernel.org/all/20241129153134.82755-1-lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/20241128113714.492474-1-lorenzo.stoakes@oracle.com/

 kernel/events/core.c        | 118 +++++++++++++++++++++++++-----------
 kernel/events/ring_buffer.c |  19 +-----
 2 files changed, 82 insertions(+), 55 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..cf229704098b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6277,41 +6277,6 @@ void perf_event_update_userpage(struct perf_event *event)
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
@@ -6551,13 +6516,87 @@ static void perf_mmap_close(struct vm_area_struct *vma)
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
+	unsigned long pagenum;
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
+	for (pagenum = 0; pagenum < nr_pages; pagenum++) {
+		unsigned long va = vma->vm_start + PAGE_SIZE * pagenum;
+		struct page *page = perf_mmap_to_page(rb, vma->vm_pgoff + pagenum);
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
@@ -6682,6 +6721,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			goto again;
 		}

+		/* We need the rb to map pages. */
+		rb = event->rb;
 		goto unlock;
 	}

@@ -6776,6 +6817,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
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
