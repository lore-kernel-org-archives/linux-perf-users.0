Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BD33C195;
	Mon, 16 Mar 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683833; cv=fail; b=FMzH878qwLu9Wdej/zb7l55EsdEvgoQi+P1c/lUse4gTjb9wxRKa0kfNZegLCc2MTSIV7VAtq/pRm/lifQW2in2EGbTVG++4ax2CnyLk8fs8mzF4sMtdzPvD5xlzgjpG9wx3bHjXc07AaWU2vYVocky/qvtHAxT1fgz1052NcM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683833; c=relaxed/simple;
	bh=OAD7ENseoPOo7OUnnSwMKuApRJ0N3DE9B2ndk2X11mA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VdDntbh6elgD91SXuJfADC52pLO924LmP5j8SqTDfVuhTaUf8YAZ7eVM/HJSVUdYldx4nUQZWUtn3bvuapCREZ9SZE6iN+kX2CQs+MwGeWQWY4aoMyk45L9vzhmfJaWX2gb4pHX908JAzyzoJZbbsdKvq3cIX71C7jlkdumgdQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVUydRmu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ff7yNAYS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVUydRmu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ff7yNAYS"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GDRRAs147471;
	Mon, 16 Mar 2026 17:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=/xbqMOPPJWIpG2Jh
	DNkSk3heWvCmvrp7gs5YHr5G1FA=; b=eVUydRmueowfHK1lJPwXTP8HoNOqLQnT
	WWz6fzxwy7uqVKIMZd8eKHocG36PgIcKV7Hr+2uGoSij8mff1n6953i1xwVJvoJ7
	wbxFg7UXlPL8NCU4DJSwpKyxuKQIJ7WXbxXaqN/Iou22OSwxDjUpTAOoRSAougtX
	mPUcfQ3JpQMnvAod2A4vLoDTtVRoIzuoca0rASUoZjSjvtLIABzOU0skqvuIV1S3
	96RjRvsmNhAkmVZoh28TleXN5h3FCs6+z6lQG9vJmJPXV1OhOwfWLFo8G1Co0vGU
	TcG7owCSbllemkgGZwP7j3DF3uU7S7aTpYDTp3VDIQhKFUcgGLqtOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rat7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 17:56:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GGSwI4002756;
	Mon, 16 Mar 2026 17:56:37 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4k7158-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 17:56:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjY+r2AmeRgi476UhMWUE1UKKE5FCZgv4KjH/fPMq2J+kEpCLzhl/EiWtVGI+Rsq3rVcoQrMTmLUZh0HUFJYhI/JH71hRdMTdnhdvG028dR3/ZadqpuJ19YQW6mfMqrNCAhkn9L9+bFd8GcZm2A/qFneNhXgjDOvcuJh7HQUgy14UAWQ3HX4+6Ke6nkEvvHUJwyV4vQh4/LgtQbqHDDnjXwzZyBqWuDCkE90nvw6giDsZdMW5Uhn4cWYd1UnHX6oBmaKcxcTnMSa6f6iJ3+ZKLfiJH1N1M6GetMMabAI+Vb00uyIc3s0GXlMf9MKemcNlVQP0BLuFSzqx0mfDyWv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xbqMOPPJWIpG2JhDNkSk3heWvCmvrp7gs5YHr5G1FA=;
 b=c28N3JsJesvxmiRrb/ksyO2FB/TiWAJrJydlvf9NrGGpZwBtIgx9U7vF2ctuJRx/4Wn6iLZLweQ8zItAbuJph5OK4EcHAP7+Mt7fNGpIiV/zJ+YEVR77d0KXpqObvCBgXhzVyA9AinqTW4xMHjcnvzCey/LUr5I+N3vsiQ4fAN0mdiEUlrd0vp42y6RhICjt3oMP9L4GiaZiDnc5ikfe3WPzJ9RTY1poqBBeOgH8pfNAVQlDfdtiHtftdNP2D8cn69pxK6r8fOIGgoysfoansrQ9pAN6hfNVc7SYQqVlAlTineZhu4g4R7VW41CgxGQPJlDi4fuB34AmYJCaSNgP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xbqMOPPJWIpG2JhDNkSk3heWvCmvrp7gs5YHr5G1FA=;
 b=ff7yNAYSAj/SS1EjlzQMKgq59qvvNAYI7NF+i9AVkxiU9tTFey85HGuftO/V0LhddQWc3/ezx38odv7Uh7JOEv24d6HiP9pWPYjKgSDSEYebIZ9WerFD14/FZdznd0wTM6N0f38VHR5NiDI9sdojO+Pd4tsN+6Rhs9YxwL/8eUI=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by CH4PR10MB8025.namprd10.prod.outlook.com (2603:10b6:610:247::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 17:56:33 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 17:56:33 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ricky Ringler <ricky.ringler@proton.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
        James Clark <james.clark@linaro.org>
Subject: [PATCH v2] tools: perf: add comm_ignore_digit column
Date: Mon, 16 Mar 2026 10:56:29 -0700
Message-ID: <20260316175631.3169955-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::13) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|CH4PR10MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 8117423b-f253-466c-671e-08de83855c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0anU7I9cy0QcglLrQNbbJv69EuX8Hlhh4fbXKccWeNeydpHFqpLhtOmg4dknA6Vi4ihjNOxUlokpIYl0zqTUwmO53WDQBdGc+kLbR4Pm9ilnnQgD70bYkUrkMwsqoVCGEuA0YmlMtjeQLftQcolkqKtFxZEJDKErtC5r6m9Bi4nIsKLfjayi8JH9wP8OlF1D3BCE3MRWlMVbb+KIcNZ67NiFT3jgIgm8315MXUk0AxBOp4kOZwnMlSpfLBlME9cLdHeU3Xrh8rvrgBoVy6Gm2o+bszeAUS0iYbw/G0dGjC5ESJhKLZLNDajiuDV68wZ4QCASkAWyVJNEYrJJFWCtALdNxazIc7zvYh8VCMH5MPBF6j4pv1DAENpKD3C23xEdREF+zZuCNBs4gnapkPaPR79A82CwUUQRKabWpuTYX6o2FmNBmFDgtSkuGVdFNFAEr7SIoWic/i1xrprGKAVKuEqq2pxbfRjlzkQpq26ZtlvkCxtbgsenrtId/8p9szNuBOnnZ36zajwk3/XqBZ0hfD+EAUGdt2BYWWnb5yVtNe6oSxsLBr19ptEDLRPiF7jMrKfchMLyCGdw9+bUz6dKSsZYaWrsJZhKuGkal6gAW4MAYco61KjtgU/vMoSSeFm6+W/SayVCQdfwuenwJAFibkwdecvERKHCZKTE03hFacplrWOnJ/pixRK0INCmJ8k7n6bUjnFVvYJeOutNq+zRmJCcxRbRTZnJdx7L6ZG32ThVEcwamE1iukK3OMx3755a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+0VvUptaerYx1L8IO6UQcHO1kn5JLIZI/6neHhEacol/V9vQ/GzoDiOmEY3?=
 =?us-ascii?Q?M+jKmeasZbUjEwdcbr/8LOYLt2BuBti+YCq877Tcb8ernJpzQpXP3CoqXk5b?=
 =?us-ascii?Q?Wd1ylFpH1/SBVAmiopYyOELPp9M5fV6+w0HNqOkgrkCu03qhtpVHQ8pUuBbE?=
 =?us-ascii?Q?iNIkKaz7UpISH+oItb7sKZ3TLLObSsoBJwSmpm4HZj9y7CFwkBvMrUFJU6ZI?=
 =?us-ascii?Q?6mN1347pqf6BaU52z4zFnSgN36MZrWYB5YWd5wIHZh8riVM972qjiDOukGqn?=
 =?us-ascii?Q?JU5gix1k2upbDNsr6Fkd80Z+3XPNHkiOk50XF4pGtmTUQBrxDG3RhJMyucPa?=
 =?us-ascii?Q?uCWqItD24RFjrrtluvmEKlpDhuWjltWfcPPJntH4WyNVGbjnC5uDg7rZJHG1?=
 =?us-ascii?Q?uiwEFJ6w9Vm3Ly0ob348pKiFipBaw5R4odSMNEV2ucgyjgF/CxblhTPtznyb?=
 =?us-ascii?Q?Qk75PXu9n+Pb7bHeZRZ4lgMgCYQXq1uMjHfP18AnzlVTVJoL/JGaPgIKZpfZ?=
 =?us-ascii?Q?ACjr1FfWR1YpGCh9690udJUb79n5wBOrRK2Wntf4NTEbYhB/BMvG63f2T0+i?=
 =?us-ascii?Q?qB53whJ3rkaz7rQYjZDwkvsuphcD+YKzEc5Q/eDCuc4ScliVOsZ5EOT2wNZK?=
 =?us-ascii?Q?4KFhm46EFSW7XP0iXu2PmROGWyN3BpRS87MsLzqQFOX/R+WJZbTlGfJ0aVHQ?=
 =?us-ascii?Q?Pr4xQ5NWJFSJ/AGwyIMEv1bbsuUVa3Unl9T8WU0TDHdH9MFTFbDXztVucERj?=
 =?us-ascii?Q?IZnHKOXibavWZIOz7mS2I2IG5uuZDIDEvirGpgKKuM+ODzTMdf94oJC+tVNR?=
 =?us-ascii?Q?S5VNvZN6Gh0qD/Gz3WxoRkyG98WF0LmExFJL6DvzBejGrk7kG4cA4gdZ+gu5?=
 =?us-ascii?Q?RbClQSav03EG1mRA0N+qfpJ0j8YRiWc5uVoviLzAtlgZ+0ciBaynartqc4eu?=
 =?us-ascii?Q?BdPFa/uKXMkHyKy1J3kGO/De1VcDwykMyck7sCaKAPYP4ynvDQpSFE2jcszf?=
 =?us-ascii?Q?NvchJS3xvIVKAl3o/yHRmwK/zFSyHHSA6ioJKYZ18dHCoHBntLeCmoGi909D?=
 =?us-ascii?Q?OCBbhFFNU0KqCn9w1WMQSM8hVp/n6JqFfGne22C2C2w78bQ1eA9ZmbN6m+O+?=
 =?us-ascii?Q?DEbE/7Q4XubOYBawYH0DNwLno3e4LMtJ9guO4jtJArsuWgpAbPdg4VHhgNml?=
 =?us-ascii?Q?z3S0NiGI5v2J4jmutb6kb39sok9eGZjL+3uDDeW0GcBmeh4DN3Ia+8IXRcC2?=
 =?us-ascii?Q?ItlxKyPkhli7BYYKqZjlBIgY0RmrSPCkFtOonr6fiWYf6DhS6d14KaGUIybe?=
 =?us-ascii?Q?PEmu/pRB7ohc8Yl5r4mPh61pdlPPhVkVvhWRexuou2hfXl8HB9/fF1zeLkks?=
 =?us-ascii?Q?sTBRirHiyth6oProNq6gX8v+laAG8Z2VRnvujdla6nN/L0dM4ZVcMate/I9c?=
 =?us-ascii?Q?lFhcUxcCzvPJT4cWThXjc1NaEHDsi7nogpefHmDtMTAKfwc63fHP6FGvz+YM?=
 =?us-ascii?Q?FDW13Qxa+59j349XpcSB77amL7VXkhJYBH21lhTTIQ2yCHsEwFjVR4pw/LfC?=
 =?us-ascii?Q?E+LcHgDE09gnqRsArs3Z+AWMVRfpR5XpjVYHyC/DS9+c2/HSjU2vwWkI+xQ8?=
 =?us-ascii?Q?WHR6oQOhGXxej+Zs1bQsBeUByhh/4NSbC+9mjilbQyu5Bf7sVNwJWIHy24Q4?=
 =?us-ascii?Q?HCn1Nc5Lxygcw81Myn09czCsFvIrV11p+qo7GoMWLUSNjSy22VesDQ8Rs/RN?=
 =?us-ascii?Q?NKaLjinrgDb5QowOYG7lGQZ/t9uf1nU=3D?=
X-Exchange-RoutingPolicyChecked:
	RD3toN3cnyOqHQL46s2Sja2A9y1vO5426wKEbOob5W6le0zK/7HXZfbOd7NrHh2LoowjbukQelNLgPrNWETL+U1pvnWhtJlYYHDguzeA73bR5l8/4qQ8vRWFHviQwezAfcyrUzpRY6O9SngEUsO8Pk2FIWM2J863xJprSlOyPULhq796ajAKxRnQ2VvaqwMlnvsC4ImDhpFBogflhv9Mp8NS4bDvvPBDIY71IlR9RrTzRxQOllyTC6sKtP3+YMQeaDP/V6xsQpE5U7+v89xxvFbkW4KdndQngnzh7R4sx/bnHr35jknnxNa1vxgYuXlEVGAvEQWlz4XWut/Vj4mpGw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EUE7r2/wGwHpEzDi9lHqtxyvMsvtTthVmVs0TOfaMZHjgZMaNUC4FTtHK7pv0xRpNWd+TpIFcUaGb3S+oV8H4lS8qODPnk5Oy6ot05ZDhPjhqHcB3UEVYEdkWawZJ/isjiU5cf3RGXkky6kDVosbOav/18SLFGqL9w5j/7YUHcO03OE7qcV1o2vamsagFE8QgD7eyLfDQK+LZktir5IMtSk4iF90OvOe3n5g9+UtJBZxfzkW4O/g3M76GUXp7QL1unxqlD1I2hFzLlrtSSwgsxtQ4W0yM09PiKCjE4NHn4KlsTwXm5OR1ZJt/TNL7Aub2+zoCymZ2h7RLCD+wHcccvk4iurKzx3FoUxZcDzfVBNG2ZocmvMD0VJM3VZZEygI7Xhp60iifPtkaDdopqMrZkOMw6T6E4GpU5c9PZi5cjtwxoDLI6KYX1kHn9RC7njZvRQOEP2/MG02JmcNBjLTJfgMTN+g35ADR4V10Dr/LZibXp8SD4Yd3wjfNrM3DlSI8NGvhFHRmRYXRX6KvJ3IPT1pUhkJodqH0StRogtNSDywqDBlhPGYNryynFBmSL6YJ2J6meSOY74sngcKI2CnuOpLGlyD2N0q9u+6OXSBpKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8117423b-f253-466c-671e-08de83855c3b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:56:33.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTR5xKEpsi0XkdQ3hHA1jX9WRjfJOcRcyW5/IGhkIMLW6YqWZjSh+r+LKzNfi/eFk3YHe/69snxhg6AAdq/l7bvTeI0AH4TQxdubVANA1mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160140
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69b84456 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=dRiHr1jVkHHOXsI8eWwA:9 cc=ntf awl=host:12271
X-Proofpoint-ORIG-GUID: jI6tgZDZOOxg4D2YPqH9025916p91dUi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0MSBTYWx0ZWRfX1+Clfu+1xeAN
 p4TgRQSqVMyl5woT6qSAVKQzm5v4u+oNbYgEXaM1eFqpHKQkKQqcE6suLhCpwVoqbPGJPQBVkuv
 TylufwWFj72162KrnYUQX0BZqpsUE3XllJj0oHwwz4x37DlbiwKg3PM4mCZK4XPNw3WAjz391sD
 ZhcoUrRrC2wyhMq4iavBXxSYJle0Jd0vFMwbWB5Q2DNX0KomUwlLd0MhJSoNDKFv4d+5EeaZHda
 QPQt3Zel0UbqplYR+8474cZwgZLnBtpqWZDI61Pj3AKtY6Ka5E+c3leR2/dcJefXvY8LXF6h+Xs
 hRASNTRSAyei/q6CRAlDQ70V6KCkZBU/TE/+VvaN7Vn6z5e3hJqhM3V7R6FDF9ss/fffbVBUXZN
 fxl0DcsX3mUNzwhlPswTgfUymSM/FgE3ztnfJPUe9v65PI8KXFSAIfvRpLWR3pYFlP2tQ7/9ZHB
 BWz7aRgjS7IF+JggBROk1fZufPYqZIQ3Qi5G1z60=
X-Proofpoint-GUID: jI6tgZDZOOxg4D2YPqH9025916p91dUi

The "comm" column allows grouping events by the process command. It is
intended to group like programs, despite having different PIDs. But some
workloads may adjust their own command, so that a unique identifier
(e.g. a PID or some other numeric value) is part of the command name.
This destroys the utility of "comm", forcing perf to place each unique
process name into its own bucket, which can contribute to a
combinatorial explosion of memory use in perf report.

Create a less strict version of this column, which ignores digits when
comparing command names. This allows "similar looking" processes to
again be placed in the same bucket.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Changes from v1:
- Rebased on linux-tools-next. Resolved conflict with commit cbd41c6d4c26c
  ("perf report: Update sort key state from -F option").

v1: https://lore.kernel.org/linux-perf-users/20260305181847.3249498-1-stephen.s.brennan@oracle.com/

 tools/perf/util/hist.c |  1 +
 tools/perf/util/hist.h |  1 +
 tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/sort.h |  1 +
 4 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7ffaa3d9851b4..a6e566dda3a15 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	len = thread__comm_len(h->thread);
 	if (hists__new_col_len(hists, HISTC_COMM, len))
 		hists__set_col_len(hists, HISTC_THREAD, len + 8);
+	hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);
 
 	if (h->ms.map) {
 		len = dso__name_len(map__dso(h->ms.map));
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1d5ea632ca4e1..ae7e98bd9e46d 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -44,6 +44,7 @@ enum hist_column {
 	HISTC_THREAD,
 	HISTC_TGID,
 	HISTC_COMM,
+	HISTC_COMM_IGNORE_DIGIT,
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
 	HISTC_PARENT,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 42d5cd7ef4e23..45662302ed5ba 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
@@ -265,6 +266,93 @@ struct sort_entry sort_comm = {
 	.se_width_idx	= HISTC_COMM,
 };
 
+/* --sort comm_ignore_digit */
+
+static int64_t strcmp_nodigit(const char *left, const char *right)
+{
+	for (;;) {
+		while (*left && isdigit(*left))
+			left++;
+		while (*right && isdigit(*right))
+			right++;
+		if (*left == *right && !*left) {
+			return 0;
+		} else if (*left == *right) {
+			left++;
+			right++;
+		} else {
+			return (int64_t)*left - (int64_t)*right;
+		}
+	}
+}
+
+static int64_t
+sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he, char *bf,
+						size_t size, unsigned int width)
+{
+	int ret = 0;
+	unsigned int print_len, printed = 0, start = 0, end = 0;
+	bool in_digit;
+	const char *comm = comm__str(he->comm), *print;
+
+	while (printed < width && printed < size && comm[start]) {
+		in_digit = !!isdigit(comm[start]);
+		end = start + 1;
+		while (comm[end] && !!isdigit(comm[end]) == in_digit)
+			end++;
+		if (in_digit) {
+			print_len = 3; /* <N> */
+			print = "<N>";
+		} else {
+			print_len = end - start;
+			print = &comm[start];
+		}
+		print_len = min(print_len, width - printed);
+		ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
+					print_len, print);
+		if (ret < 0)
+			return ret;
+		start = end;
+		printed += ret;
+	}
+	/* Pad to width if necessary */
+	if (printed < width && printed < size) {
+		ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
+				       width - printed, width - printed, "");
+		if (ret < 0)
+			return ret;
+		printed += ret;
+	}
+	return printed;
+}
+
+struct sort_entry sort_comm_ignore_digit = {
+	.se_header	= "CommandIgnoreDigit",
+	.se_cmp		= sort__comm_ignore_digit_cmp,
+	.se_collapse	= sort__comm_ignore_digit_collapse,
+	.se_sort	= sort__comm_ignore_digit_sort,
+	.se_snprintf	= hist_entry__comm_ignore_digit_snprintf,
+	.se_filter	= hist_entry__thread_filter,
+	.se_width_idx	= HISTC_COMM_IGNORE_DIGIT,
+};
+
 /* --sort dso */
 
 static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
@@ -2583,6 +2671,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_PID, "pid", sort_thread),
 	DIM(SORT_TGID, "tgid", sort_tgid),
 	DIM(SORT_COMM, "comm", sort_comm),
+	DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore_digit),
 	DIM(SORT_DSO, "dso", sort_dso),
 	DIM(SORT_SYM, "symbol", sort_sym),
 	DIM(SORT_PARENT, "parent", sort_parent),
@@ -3577,7 +3666,7 @@ static int __sort_dimension__update(struct sort_dimension *sd,
 		list->socket = 1;
 	} else if (sd->entry == &sort_thread) {
 		list->thread = 1;
-	} else if (sd->entry == &sort_comm) {
+	} else if (sd->entry == &sort_comm || sd->entry == &sort_comm_ignore_digit) {
 		list->comm = 1;
 	} else if (sd->entry == &sort_type_offset) {
 		symbol_conf.annotate_data_member = true;
@@ -4040,6 +4129,7 @@ static bool get_elide(int idx, FILE *output)
 	case HISTC_DSO:
 		return __get_elide(symbol_conf.dso_list, "dso", output);
 	case HISTC_COMM:
+	case HISTC_COMM_IGNORE_DIGIT:
 		return __get_elide(symbol_conf.comm_list, "comm", output);
 	default:
 		break;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index d7787958e06b9..6819934b4d48a 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -43,6 +43,7 @@ enum sort_type {
 	/* common sort keys */
 	SORT_PID,
 	SORT_COMM,
+	SORT_COMM_IGNORE_DIGIT,
 	SORT_DSO,
 	SORT_SYM,
 	SORT_PARENT,
-- 
2.47.3

