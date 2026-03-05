Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90280262FD0
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733750; cv=fail; b=PvfJ65XsOK06DASj0RLOjOImL2rSsvl4sMxNFguAUJz18IYtz/Vdvg358X+MknBJ6lCXa6XW0Jv7upsx+jmrbgus6onhWtrd1Z2zpeojlNxlrkjUWK7NujCY+mgaYt+J8H/jDfnGjbEuZwE/lgr2IQCR1GbWyGapNfbQK3LocRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733750; c=relaxed/simple;
	bh=SeViRGqsrlPjdnwcpAFjeAwGFZTxjFoOX3kMK/IadbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=pOmvEuIVYIsS9+VhGaFts/Z6lT+2jf6ZVHuPvzLxesqWPshg0frd8v8r30kFL0kcRf2gog2ti3Cudi+HJU3AFgzvJgJKmMJyGSYt1v+NONhr4GYxmyhqRh0VsM5ILTNlhdpTccdrtRXJW7cmASU9fE3+7b9amQ0cnRMsbHn5Zl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VKnzJYI1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DOKylrWA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VKnzJYI1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DOKylrWA"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625Hv57K1436112;
	Thu, 5 Mar 2026 18:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8QUly2/ws951dIlj1P
	GM4UkKug04Km67KbdR7ocLwLQ=; b=VKnzJYI19lmWYW5w5xx15B7XRHbvf3aJYB
	x38N1aLa73+qzJ8kbxv1ZV8bNrb7AIjxoHBruZukM2WuT5HiSayZXKlqegbnQunK
	ZOEdaikwzM29ha25PfJcLRP/G9CzqIze9UONd0NP8nR5vLlXUcXbYjtzW19NByA4
	JFR2FFvuXbeYxOUB2xu2MBr1Ebamz6sEU42lLibFIXDsq6PHzjB8/6cnf9FDETwR
	nK5EzrjoAXPb1iw3G+sjpaj/7qC9QgrvzZJRQaRpjombu1W/yZADXjz2C3XzUk1g
	VQtUWlCA4ndQxOOnht7Lbz50OSP+HhTUd+MM4u4EPpMlTcOZF0gw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqdyq03my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 18:02:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 625HJKFP023114;
	Thu, 5 Mar 2026 18:02:08 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpthuv4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 18:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2yU5274D5arPsw6xofo7k9o3ozYKkGxy5GEgaIewMRJ4pr3a5H9NbxcCRFBuK9ToRWfZGavpcUkFtnUeNeNB28MmQGd9vWfwzbJ+jgA6AkfUhbv5bdHptDZ4Q5HtVZlevkKPkliScN/cPlfLEfcjD7V4J/IWoti1/cbzFMUYMShz+C+8MPNfq9irtaB8i61JB4EqmBcszDd+fOo6wLNjnDMyYqXSMdbg1tT8dJ3u5d2mXnv/2HzZB0mb71/T0LvPOmgP+8GKrjLcCcAkPB8xjY3hdRXnS7J2Lj5sjKXcID8xEWd/rbp6AyAEBiLcWM8p/DhzV1MqQNZdMgmtFvliA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QUly2/ws951dIlj1PGM4UkKug04Km67KbdR7ocLwLQ=;
 b=qvhqfbl65khaJucH8m+y523OZ68xMYQOeZ/Q6JdG2OXAkLdhdfrL7odRL78oTcDzEKeCEewYadfVqpaFiBe+A3479bD1yHnfaP/R80KiJPr9zvr8ndWPVuHGf00Jx7qZbVkJFePI46bmfJz0gWJ5UHbubSSpyIN2vSSUuBiKmT2KOYwTd/9JjmUSoWyALuNd8Fz2lrQB2WkMU/qSfwODqrOohPrOVYFBgJnZJWV2EWgQHYx869RNDQQSoFjfMiFemOM0HO8ssGRZer1N/n85aky1mra8QXSTiiv3ufivafYBlYX8qMj1wqCVoiif3hV3EHeEJxxnCR9gS1/i8+fZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QUly2/ws951dIlj1PGM4UkKug04Km67KbdR7ocLwLQ=;
 b=DOKylrWA/ekXds159Z+EhwnzjnCEAkRBra5RTKSHjL3H3yYZuwR4TvZm6j3Hl8EONpTeYjv5G+SEoCD0Q/j/vHkJ3hPCBoIVTL+W4NLqu7/zUhEKdPAiszYiC73b/oLDlPrumvOjG6QH2YQMrmyQbVw5RImE6F63n5QAoz9EzJg=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by IA4PR10MB8753.namprd10.prod.outlook.com (2603:10b6:208:55c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 18:02:03 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 18:02:03 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>
Subject: Re: Question: perf report & top memory usage
In-Reply-To: <aZUbSLeRCSdTp55m@google.com>
References: <20260217190821.3882437-1-stephen.s.brennan@oracle.com>
 <aZUbSLeRCSdTp55m@google.com>
Date: Thu, 05 Mar 2026 10:02:01 -0800
Message-ID: <87qzpym9ye.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|IA4PR10MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e46f06b-e48c-4703-3dbc-08de7ae14e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	6bB+3QqF8sQa/sB67Xr34TyZuQRtiLIRlMJQzYoR0XXFW0pjOx0U6R87AkwfUFdLol8cTGL0CHbSXlflnH0pdWll3Dd9Li09Vt1LMwiLzN0xPx2f7CzAJX3Mz5U6+vSGIGwUgqA5LnR5KVlasdeiHcCYfFXYKp+Ae62JPxudr9tWxS3P1N4VlUmu5Vlw4el2BdDZF4XHL1X2WQooHRk09Z1Gd2Skmibrffd7HwvpX7B5aEYmPUCkxo9C3L5zVFk3m7GYos9VG8qHwc9DUcCa0DI55XojBeiZqg+OIBiTOKEep+X/BQysT3b+yHw4IAPxgfR8K87Hl2FeA+sawijobTap/intpqA2P/UG/RvtugdtVQknvH/52qwlLzZEr1qkTQtgyefrb9oq9xtNU/IiGG3X0wqhvr9igAmnHVDJlcs8AgJtE8yOMh/QsZypzRLPYmlbIgHXzAl8+z1V4XKmEX7ZRMf4w9Ik1NhnMbrFlT2gJmLNghoqL0xKns1soebMuC9thUgXPW9FdTXabFao1Zkzc5kzgiHbZDfaPa7Umb1zM0/vGa6QxNZo2QSCP7FrzDBUPyP2OgFvDLmu7//8ajf8qfCu8LBnGgw71iDY4uGUoXKjNoL1oqjZ06cl+cy9MKxA6r0chraWwGk101nwRjS4FR2dRILt7HSAytS5lHvobVJKwn0nhTmEYScPXc3/CJF2GOe6WbW9YEfqTtILbno2Pczwftpmd73mNp5yowE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xhM5BuBeD6dSB1L1/UaV2D902BhNO9nAy/O8DS/m8pCR9Y/13pdqRBK7UBl?=
 =?us-ascii?Q?QhEmsQD2QHn+9f9GGVTZHO0XCwetVrqNJQAeJZMRGVxcnIAWjln7VKu37ODy?=
 =?us-ascii?Q?BArs4KVJSMlRiU5NDmllIMIHTVvkD3DkZWViTDrNuxLSQUitFxXYO+cg8acR?=
 =?us-ascii?Q?2pbE31sCDI9YqsxY4Wj3yQiPkJUTdkVhWBoxowuGWU1vbG4uBWokNv/c/wVG?=
 =?us-ascii?Q?ieRAaTd6H5lpWVAnzDSBVq9BBkjicOIYjYB1fVBSik6OqzCtKnrIoNF2NQWq?=
 =?us-ascii?Q?7Lna/qN9fKLWzKwvK2DLdsnh56n9gUKXOxzgYmn7FAzETmgF5we9kpoH2UQN?=
 =?us-ascii?Q?nFG83mQtat7fIOyq9E/EaONvxb+PbwWerg3n9SV+74/MpJmhWmvyp2WTVm02?=
 =?us-ascii?Q?pwD89EHZlbsp6grY5FCSkcA8tZ2rR2BYtSjiUHO1M3dyAotUqRFVx7xsNsLI?=
 =?us-ascii?Q?/VAmgvtMI4ncYAGAlbRZOjFG29aiKP2Bijvauzj6hlVxVWxyWZxWJEPRLNSH?=
 =?us-ascii?Q?spPv84L2rJehIibLvgrtr0JVgDG0rg8Tfu39TDEjH5AH4n98xbkz3ayrxYX8?=
 =?us-ascii?Q?kW1mGm7Sn15SYnzzXrQ1fa0a+8UJuPYE0Zl9xh4J4UYKNfeBgBOq2z6VlhMb?=
 =?us-ascii?Q?Uqia/8oTOSmpnrcYp8/SqzKHXMqD7W8sjYzapjMf7c13fuT0RnrOwBUDg/3z?=
 =?us-ascii?Q?XcVnyHhDEtjhZnW4juj+/wOvpdhT6EzKbdB4AOgx62Sn5/TFVH+zGqjYEhKd?=
 =?us-ascii?Q?5q2DXXSo7Zofw4jWH3fPiMrYGDD+YV6ZZktr7G2v5PBQqLc57PfhdSyzsBXT?=
 =?us-ascii?Q?yMWIth3kGYUF0TccHWo2wN8iQwFrHOeLFmB0O7JDf3cebGApivRjJVxqn7EF?=
 =?us-ascii?Q?AYeAaeo86fr9YhOs4EJCYNDptilKXS2J7xURBAoVpKXwRIsOmMvOH0uvM348?=
 =?us-ascii?Q?EnI5vrK8UMRFItSCAE5yUayDZeyz9AdjAwWVBlI41b2Zys+fypSNbosQOxtr?=
 =?us-ascii?Q?Yq5w66kLVHUad9CsjB5xA8CfeDIJiZcCnCZ/lfNWlBBZoXBbpjQFla1MMBM/?=
 =?us-ascii?Q?eAxUfp2wn/rP5haY5O/xlnbKe07KylBPUqxlovWDs0rZE/N0hz3sdY66T6tt?=
 =?us-ascii?Q?1CK9VKNli4JbBBY1f76toZjTZVUDWkSGaXNlW+nTfgIyqtMayd77ZLfdq/BM?=
 =?us-ascii?Q?ds+OiqZbsi+BZEVjpxYmJphb5eWu/VU9uneM4BtSGFEu1uaahw+NOaMLrAvO?=
 =?us-ascii?Q?28UJFvRoVpIBxEVVvoeu7jr7XAzYAY/KHNsETouPF9NVNegRg/ISIfoYLre5?=
 =?us-ascii?Q?IjGA4bd6I8w0NVeHD+ozSRcqoD2mvR7FvrzxoJumEXjNC3qz0He6VaA/b9OQ?=
 =?us-ascii?Q?m4FrmhkSGPkUrvoMhaVYCDl4TynMDP+IWoalF/QbvQCd1bfAcBWrTP6zmtiD?=
 =?us-ascii?Q?tFmAC0pgD6grG222VnxQi9fHdCbfTvdeK4f2A6EDFun9b5OlERVfIFsGkHMv?=
 =?us-ascii?Q?C5fqDO8vbwHwgNpGfS7AL2Jgp4nhX7affc/lAeo9Uju0DaGTyuFKKX6eAVZ+?=
 =?us-ascii?Q?5H9v2BRraBMcLz6LaeoR6PK3YSRXFoGMpMaTbJTv3aGYDQ5J3iq/VcxnjeI6?=
 =?us-ascii?Q?2W5nS8lw2VBeaFZwN+Q6/++AXOPTY4D8BRrp9LkHQICDgjaSRfnrtsHe0UDR?=
 =?us-ascii?Q?V6aTXiRDiz4U9p4iHKzb2W/xUz5zg/dN4mzUDo3CrZUJ8h5GJUjDHyCvzCc2?=
 =?us-ascii?Q?v1Qurt4fV3E6shjkm5SJy1waOqy1hXM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e0cKMk6X1/vaveZX+ZEEnJ3JCKMZqNO5VbrR1Bkld5YKr7OxbnLLW/QEG11r4xZletPAojuD4cn20tjBHmqUxfQLFdgRaH1XdK1Ef0Flu9AyaBaIrYWw5AjqwXpVCy6N4gYG4iPxYUoShaif79HB3coCDyzRRLGTuSlXk7hyKe3Xx+LfQOkpQSy/MiCfl/XxPuYuUdsoxocZ1beW/OXL08uC1rwL88cZdzv1bgTjjpoc32X8WnTEv5pYuiPqyqpMAPqoamH5ym6fO3Rlz6TdVD8i7SV9m+DCTVETBF7LSU/t/9TyURUNDgvZCuvbiY741ax7JPudne9Y96Qv0RZNvvfHIdaBDSgXdxqxzB66RFCzEYV2EuDiHCB8BWRPZBD3o2uT3pM0AKQAhmkXmFNmdmC/p8u9LRfueI8dvgypfkkEmphEbbC4nOTkw5VjNYJ4H+QKao/b7CoQBstvdGkjhQf4F1b3zWss/llXklEWSP692s0FGKlsQGbFZKojxqXgaG/lmUwBM/Rg9nUD7jMuOmgRnLb8JbyE7BptIjiOO6kkyYp9JuUU2lnOCDrY2b2Q0w4Flat/QXJN6hTVbnZ5BEU0ad09745eXC2qvUgc70A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e46f06b-e48c-4703-3dbc-08de7ae14e17
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 18:02:03.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6cKpMUt8Sl/7ySkmpu72nhxKMIgBICPnw9SVQUQ9cyQBYKbPQV1dcRbHmXQ5o5gJDgzIjHfLG3IR3eZEAJR+VR4AHNPBLFnQEWdHmIQUSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603050147
X-Proofpoint-GUID: H4UBVefnplJfDgYttjhArk4uaoN_EhEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0NyBTYWx0ZWRfX9g/vozu2hj2X
 6sAJ+BwqqmN5CVv0t0xXQ3Wbmqtv84gJG64y5XmrSf/DnHFXFf14JqQOEuvrx7tG+HBMdq1wSV5
 wLfOHKNKsmMALIED7fuXwNR1dCIJsDdR7CekCetFYEMqWWyVFgGShGkwcNrTjaYGC0N6IFq7Qcr
 uuodYrUjwm3T2ldIhnZHbqm2NOn6kYTZkkrGNtl6j56kM3DyWv0f0cPEfAwT4l3DL1vuNDvB1oJ
 LJTn6/kA7WNriw4Jw1/6Gb4fII9z5JiSHDW1w+LdNXLW+/NFOceuYQRSdkAcXnamxUfz2SXixWK
 gM4S8CyatoA+CpMxSlF+2HfIK0bZVfpAWJF9mizLmfw2UN4HggsZwoMtuouQGcNJICH19Wj50hS
 v76oXV0R6VQVtYoI1aosIQJuolpM74QPTvBpTWEe5u4oarfJQxLhygQAAZJGWoEvGr5srOFbT2C
 2u7FtPtMpoRgBbWQgFgwiuiCouSmdRlqQs/r8kak=
X-Authority-Analysis: v=2.4 cv=RJy+3oi+ c=1 sm=1 tr=0 ts=69a9c520 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=hiM6WnBn_sF289y4DvkA:9 cc=ntf awl=host:12267
X-Proofpoint-ORIG-GUID: H4UBVefnplJfDgYttjhArk4uaoN_EhEc

Namhyung Kim <namhyung@kernel.org> writes:
> Hello,
>
> On Tue, Feb 17, 2026 at 11:08:19AM -0800, Stephen Brennan wrote:
>> Hello all,
>> 
>> I had an interesting case where perf record required 35 GiB of memory to create
>> a report for a 400 MiB data file. Unfortunately I don't believe I can share the
>> perf.data, but I did an analysis and wanted to share what I found and ask some
>> questions.
>> 
>> The particular data file contains 1,087,091 samples, with call chains, generated
>> by a pretty standard "perf record -a -g sleep 10" on a machine with 76 CPUs. I
>> looked at the perf report code and profiled memory allocations. Three items
>> seemed to dominate memory use:
>> 
>> 1. Histogram columns. The default being "comm,dso,symbol". The more buckets that
>>    the data is broken into, the more memory is used, and the histogram columns
>>    directly control this.
>> 
>> 2. Callchains. The default is to track them when the perf.data contains them,
>>    though it can be disabled with "-g none". The data structure storing call
>>    chains seems pretty efficient (a prefix tree) but it looks like there is one
>>    per histogram bucket. This makes sense, but it seems duplicative with #3.
>> 
>> 3. Accumulating child overhead. The default is to do this, creating the
>>    "Children" column in the report. The implementation walks the stack for each
>>    sample, creating a histogram bucket for each stack frame (even if no samples
>>    were observed actually executing in those symbols).
>> 
>> My understanding is that the 35 GiB memory usage then comes from a sort of
>> combinatorial explosion. In this data file, nearly every process has a unique
>> comm with numeric identifiers embedded within (e.g. "db1234"). This means that
>> the default "comm,dso,symbol" sort will result in a large number of buckets. The
>> call stacks are reasonably deep (though not absurdly so). There are many
>> non-leaf functions in the call stacks which don't have any Self samples. Child
>> overhead accumulation creates more buckets than there are samples: around 1.3
>> million buckets, compared to 1 million samples.
>> 
>> From this perspective, the memory usage makes sense to me. I understand that I
>> could tweak any combination of those knobs to ameliorate the issue. The most
>> straightforward option is to use "-s dso,symbol" because the "comm" column
>> wasn't informative for this workload. I also created a new histogram column
>> implementation (see below) that represents a command with any digits stripped,
>> so that the commands could still be grouped together, without the numeric
>> identifiers disrupting the bucketing. These solutions reduce memory used to 5.1
>> and 5.4 GiB respectively.
>> 
>> My concern is that most users aren't prepared to dive into this sort of detail,
>> especially when they're likely already in the middle of an analysis of some
>> other performance issue. While they may be familiar with the call graph options
>> and event selection choices, in my experience they generally aren't aware of the
>> many options that "perf report" provides. They certainly aren't aware of these
>> memory trade-offs, especially for what seemed like an innocuous 10-second data
>> collection at the default sample rate.
>> 
>> To sum up, I have the following questions:
>> 
>> 1. Does my analysis make sense and seem consistent with your understanding?
>
> Yes, it does!
>
>> 2. Does anybody else deal with this sort of memory usage issue, and have
>> strategies they can share?
>
> No, but I think "-s dso,sym" should work fine.  And it's the default
> sort key for `perf top` command.

Interesting, I did overlook that this is the default for perf top, thanks.

>> 3. Does the patch below for the custom column make sense to submit? I know it's
>> rather workload specific, but it could be useful for others in this situation.
>
> I think it makes sense and could be useful.  Maybe it's good to group
> kworker threads together.
>
> Different options would be
>
> 1. to add an option to enable it for the existing 'comm' sort key.
> 2. to have a regex pattern or so to specify names to merge.
>
> But a separate sort key as you did seems to be fine.

Thank you, those are good options as well. I hadn't considered the regex
approach before. I'll think more about it, because I do like that
flexibility.

>> 
>> Patch for the "commIgnoreDigit" column. For this workload, it reduced perf
>> report's peak RSS from 35 GiB to around 5.4 GiB, when used in place of "comm":
>
> We don't use CamelCase in the perf code base.  But otherwise looks ok.
>
> Thanks,
> Namhyung

Thanks Namhyung! I'll go ahead and send this patch without camel case
for further discussion.

Stephen

>> 
>> From df1452ae742d933b45c18d9dde090c11fb3cf846 Mon Sep 17 00:00:00 2001
>> From: Stephen Brennan <stephen.s.brennan@oracle.com>
>> Date: Wed, 3 Dec 2025 16:01:49 -0800
>> Subject: [PATCH 1/1] tools: perf: add commIgnoreDigit
>> 
>> The "comm" column allows grouping events by the process command. It is
>> intended to group like programs, despite having different PIDs. But some
>> workloads may adjust their own command, so that a unique identifier
>> (e.g. a PID or some other numeric value) is part of the command name.
>> This destroys the utility of "comm", forcing perf to place each unique
>> process name into its own bucket, which can contribute to a
>> combinatorial explosion of memory use in perf report.
>> 
>> Create a less strict version of this column, which ignores digits when
>> comparing command names. This allows "similar looking" processes to
>> again be placed in the same bucket.
>> 
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>  tools/perf/util/hist.c |  2 +
>>  tools/perf/util/hist.h |  1 +
>>  tools/perf/util/sort.c | 88 +++++++++++++++++++++++++++++++++++++++++-
>>  tools/perf/util/sort.h |  1 +
>>  4 files changed, 91 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index ef4b569f7df46..5f691d9b0272d 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -110,6 +110,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>>  	len = thread__comm_len(h->thread);
>>  	if (hists__new_col_len(hists, HISTC_COMM, len))
>>  		hists__set_col_len(hists, HISTC_THREAD, len + 8);
>> +	if (hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len))
>> +		hists__set_col_len(hists, HISTC_THREAD, len + 8);
>>  
>>  	if (h->ms.map) {
>>  		len = dso__name_len(map__dso(h->ms.map));
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index 1d5ea632ca4e1..ae7e98bd9e46d 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -44,6 +44,7 @@ enum hist_column {
>>  	HISTC_THREAD,
>>  	HISTC_TGID,
>>  	HISTC_COMM,
>> +	HISTC_COMM_IGNORE_DIGIT,
>>  	HISTC_CGROUP_ID,
>>  	HISTC_CGROUP,
>>  	HISTC_PARENT,
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index f3a565b0e2307..656b5cc62a730 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -1,4 +1,5 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> +#include <ctype.h>
>>  #include <errno.h>
>>  #include <inttypes.h>
>>  #include <regex.h>
>> @@ -265,6 +266,89 @@ struct sort_entry sort_comm = {
>>  	.se_width_idx	= HISTC_COMM,
>>  };
>>  
>> +/* --sort commIgnoreDigit */
>> +
>> +static int64_t strcmp_nodigit(const char *left, const char *right)
>> +{
>> +	for (;;) {
>> +		while (*left && isdigit(*left)) left++;
>> +		while (*right && isdigit(*right)) right++;
>> +		if (*left == *right && !*left) {
>> +			return 0;
>> +		} else if (*left == *right) {
>> +			left++;
>> +			right++;
>> +		} else {
>> +			return (int64_t)*left - (int64_t)*right;
>> +		}
>> +	}
>> +}
>> +
>> +static int64_t
>> +sort__commIgnoreDigit_cmp(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int64_t
>> +sort__commIgnoreDigit_collapse(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int64_t
>> +sort__commIgnoreDigit_sort(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int hist_entry__commIgnoreDigit_snprintf(struct hist_entry *he, char *bf,
>> +						size_t size, unsigned int width)
>> +{
>> +	int ret = 0;
>> +	unsigned int print_len, printed = 0, start = 0, end = 0;
>> +	bool in_digit;
>> +	const char *comm = comm__str(he->comm), *print;
>> +	while (printed < width && printed < size && comm[start]) {
>> +		in_digit = !!isdigit(comm[start]);
>> +		end = start + 1;
>> +		while (comm[end] && !!isdigit(comm[end]) == in_digit) end++;
>> +		if (in_digit) {
>> +			print_len = 3; /* <N> */
>> +			print = "<N>";
>> +		} else {
>> +			print_len = end - start;
>> +			print = &comm[start];
>> +		}
>> +		print_len = min(print_len, width - printed);
>> +		ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
>> +					print_len, print);
>> +		if (ret < 0)
>> +			return ret;
>> +		start = end;
>> +		printed += ret;
>> +	}
>> +	/* Pad to width if necessary */
>> +	if (printed < width && printed < size) {
>> +		ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
>> +				       width - printed, width - printed, "");
>> +		if (ret < 0)
>> +			return ret;
>> +		printed += ret;
>> +	}
>> +	return printed;
>> +}
>> +
>> +struct sort_entry sort_commIgnoreDigit = {
>> +	.se_header	= "CommandIgnoreDigit",
>> +	.se_cmp		= sort__commIgnoreDigit_cmp,
>> +	.se_collapse	= sort__commIgnoreDigit_collapse,
>> +	.se_sort	= sort__commIgnoreDigit_sort,
>> +	.se_snprintf	= hist_entry__commIgnoreDigit_snprintf,
>> +	.se_filter	= hist_entry__thread_filter,
>> +	.se_width_idx	= HISTC_COMM_IGNORE_DIGIT,
>> +};
>> +
>>  /* --sort dso */
>>  
>>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
>> @@ -2576,6 +2660,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>>  	DIM(SORT_PID, "pid", sort_thread),
>>  	DIM(SORT_TGID, "tgid", sort_tgid),
>>  	DIM(SORT_COMM, "comm", sort_comm),
>> +	DIM(SORT_COMM_IGNORE_DIGIT, "commIgnoreDigit", sort_commIgnoreDigit),
>>  	DIM(SORT_DSO, "dso", sort_dso),
>>  	DIM(SORT_SYM, "symbol", sort_sym),
>>  	DIM(SORT_PARENT, "parent", sort_parent),
>> @@ -3675,7 +3760,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
>>  			list->socket = 1;
>>  		} else if (sd->entry == &sort_thread) {
>>  			list->thread = 1;
>> -		} else if (sd->entry == &sort_comm) {
>> +		} else if (sd->entry == &sort_comm || sd->entry == &sort_commIgnoreDigit) {
>>  			list->comm = 1;
>>  		} else if (sd->entry == &sort_type_offset) {
>>  			symbol_conf.annotate_data_member = true;
>> @@ -4022,6 +4107,7 @@ static bool get_elide(int idx, FILE *output)
>>  	case HISTC_DSO:
>>  		return __get_elide(symbol_conf.dso_list, "dso", output);
>>  	case HISTC_COMM:
>> +	case HISTC_COMM_IGNORE_DIGIT:
>>  		return __get_elide(symbol_conf.comm_list, "comm", output);
>>  	default:
>>  		break;
>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>> index d7787958e06b9..6819934b4d48a 100644
>> --- a/tools/perf/util/sort.h
>> +++ b/tools/perf/util/sort.h
>> @@ -43,6 +43,7 @@ enum sort_type {
>>  	/* common sort keys */
>>  	SORT_PID,
>>  	SORT_COMM,
>> +	SORT_COMM_IGNORE_DIGIT,
>>  	SORT_DSO,
>>  	SORT_SYM,
>>  	SORT_PARENT,
>> -- 
>> 2.47.3
>> 
