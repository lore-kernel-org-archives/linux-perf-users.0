Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869ED53ED04;
	Tue, 13 Oct 2026 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927553; cv=fail; b=FcR47HJ6vvB5Sn3ilPxDjkcsmlRMPfLAVE0VFc7dK1DoEFkmtroOwDBhnEpk4fA+/OAWUSYBbLgvIvPZwpT/jG4NurGQN5Z9D1z6wVscYIY8dijnKoPLaQ/J0rrJsprU39M+adgfZTUbw452IdwQ+WnilkIpnHGUl+7pX4hIOVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927553; c=relaxed/simple;
	bh=R0a66O6GPVkY47r9j6A75kTuINu9eIfuqBwSXsUcZWs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T0M8ZrezO8MUmvdtdmRDhHeH9X5xDmOG71KtVRTUmR7lag+yVR5ZHHoHLF4ufN7ujTkrrnj5WuhXwA4jKORL5LCImP9nmVYUJKCX4nxHR/xoeLeBa4LcqdoSj4KgtKr6SamNggP7mhjqH9viMXn5CKY4pB3CXtLU6uivckgavP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HRubzZAM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EtwCpIMW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HRubzZAM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EtwCpIMW"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DKtdpn2587416;
	Tue, 13 Oct 2026 21:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=pvmPNGX5Ja5NJwVX
	Y1K+7IWg95wsjj3aMya/7ZPbzDk=; b=HRubzZAMsSbzkiEa8b0yHs48U0+ti1L+
	qUmMZdzEruc2xB2rUTQpGJfV4GJix25OY/GK6ZdxsJqvciPNJkHiiN2gb5/sFhkW
	jaQZUC3zF4SHk22yY3Q40BF+etDsZohFzPAQ/8fhPaNlpXQVdt4cXYI+EtNBeiA2
	KpQB2PBEK52RtkNOQz1ksSJBrOOxOFOdzak08tM0HEfrOY8criNavHb4PM8V5mi0
	F4KbI0GuL8IzaRiHSPq2wvYDXbmsKnD8NfvnG9XPGAjYMfgrlrCDOmQmicKSkhIu
	Sv4H3/Qpn5Igf+upVCJFwNQtUyckONgx0o6RPKnk9zCoB37zZl3o9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dddw3x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 21:38:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69DLaBRe030679;
	Tue, 13 Oct 2026 21:38:48 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h7bta64mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Oct 2026 21:38:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBwMufy+5/fS3TyAvs3pPjh8103dEh2Zsvw4YQSGFohLz+SHHve1U70H14KdQOMEAnSzYIzIlMxcefckzgt55OKSHBVVgCSY6IHfyER0q2NKI20ip/LhZ85ndemyFl/3VNUV6+l4+Yp5BfMkkx2wDIg8LNgP1wFq0VtYYWYTA+i8KkKHypbpEAf1T4HU/qstWGsSS3LwcVHhzNr3qAJYusTkX2nhsSGdAxSPvGFoqctqO5JFG2A8ZaxDLGjA1Rq4NpiGdKvD0BkZWOP900KlCnRVdnwICj6trnMTFVYkgfmApY51dn1B/lMajaStRva5xzqY9tDJb1PIHVC4LnAIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvmPNGX5Ja5NJwVXY1K+7IWg95wsjj3aMya/7ZPbzDk=;
 b=AxDEbAzADPKt1QjP17GjcD6CySfSaciQ4v0ZrP1s6DY5cEklMdlgOtT1vXhTzp8hV1n2vITHAFaCn3lyxaaXyEiKdLMzdMMOLRU6VoTTEVCfG1ICJDqNK/iMwdQsTCNUpMA5+YUsrGyJwbbRCmEKaculeVwr8rJLOpex0Gfftmm9DiF6C3e28RAxO4LW+3Zqfb4A+9uNZ+MoE1PuzPkkUyNJ8e0BnxTQE5PGFuejS1cc4/sO644vhwW9wpBob5db5RLL+gkLdP6KdvBUSDzY0gXuzAWmbVMpxMibeN5qVKtYBabA0mKYvOO3ci9yijh1pqlAQiYwM642slt8LNroYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvmPNGX5Ja5NJwVXY1K+7IWg95wsjj3aMya/7ZPbzDk=;
 b=EtwCpIMWcgDc5fUo1MhorKrVyAdNmDYw4312i5Heus9nXRglqZnlNo8nsEsXA3m+OnvujvHro1+93DaLySRU/g2ja9e6G+c7Jq69H86av/AQuEDx4jXRJVkAEiMbJ2q7uAWaypdS1h937gtcz/9VogSvHWd0Io+ExUVQvfi8eiw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by MN2PR10MB4271.namprd10.prod.outlook.com (2603:10b6:208:199::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 21:38:46 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 21:38:45 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] tools: perf: allow opt-in "no-dso." files in /dev/shm
Date: Tue, 13 Oct 2026 14:38:41 -0700
Message-ID: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::8) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|MN2PR10MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a75cb4-f1e6-4b4b-295c-08df29725bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	f+qj3TUmbv5/4jJWvzalCf5q5/iFMpCrAeJPNttrUJ2pYhULGci/qeA76t8iYdpvjzZLw1rXbuv8Teg9ZaI30UvLemy1xlGyj+niU8JpD4o7x17lQrq20czAqChuPd34MLJBjxnduyFtCCNZwKE3zUATOCEb6PpDAvZBxsHK4V2e2dv9AA1bLnSfUasyvOFCcR1ubyVSDPnsK4/0WNTQZruAUmLgIYcRtLt9ZmlRKuC4hbCSsQMl87wN1vMPl/3Zg78sUUTf6U3meHRcwn9g1qa8YZ+vbD9Cm6G+1Ma68f8ErltggWdPcoYMKOjOfraGqrtxDk3buetS3pZ1yo1cSAtTLhkAaReSB67LQ7rpE/4jYEj2gQFxYvEosOB99HgapBxovae5RqR+YIjfsJEyGc+8skUYDW1C5hu4BrPJSa7Z4cedakv5zyLZsDHj+nny4btKktcIIu1fKn6sGHxIWZjHsBZX2OVOX8KBm+T0jVXx3O0n24DGziDNKtDPzBZHsE/MoV/t6VU/P7ASD2uImyus99NbYaTk5GOhNmc67oKtrLG3jLR11fGDJFh7ReGJ92UJiZMPsNX8u71AcVZOq4q3AzQdSs2mfCJeRhlDXLf9A67EjO5buNlTpFvL4DHYYnWHINWHIqyxAirPOaMUuDp69ReqQCRm0GeyXNWhx54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMVMG91PlMbIQ2DC0ujns7Zh6AVMF4FOTWRaBPojvN60P/GocvXaHyKWbWoV?=
 =?us-ascii?Q?tTXdniAL2lm3UPSDebNEXcdItaZ9lV2Ba81ByaCT5aNGsdMbX/vx3uwAgUAC?=
 =?us-ascii?Q?oLJJwEbYtaKoJvJQDwMzo5WLKqjUW1CVwguld3Jc3fPFowBzMoVUitsvhGou?=
 =?us-ascii?Q?IbV5/zKDrx/x7yyiSnsGNglGCYX9pwJvt856kNOrbt1sBXOl4W2/7i+GltMb?=
 =?us-ascii?Q?WxqxTDlDDp1yAJecZIzx/sudy84EeAjwNjPq2D6j6PHOhsYTkZukoyKiDi3q?=
 =?us-ascii?Q?NHu1s0BCIE3Jr077SKfEO6e3L8URNk49ugNAXAhrUBx4EJyBeEBTrDvhVOto?=
 =?us-ascii?Q?z5pDBcuCYyKwVaO9WSmQEGZEb97aUIgpqOd+23qbV3jujIsTKIsLvAcoNla1?=
 =?us-ascii?Q?PBoyMCBxRzH7slwpovts0kct+maKtbUB3yYQz/ORLUpV2Yc6h7w0+ceEqPe9?=
 =?us-ascii?Q?wAO2+ILsVQ1mHVYZsbJ/RZJoV9MNnIcCpeIFkUIvLlh0DYa9Uq78ADys2Prh?=
 =?us-ascii?Q?uTKI1fBtpb+hOUpzm2EhxCJK9Ux/xmMgO0+7Vci9c473ExHBE8Ie30gzM7D6?=
 =?us-ascii?Q?bWkAZmy2gjyLbDIwbX99oHyKIEjkdKQqKrInPg5IM9Zl19LUpMOtG/g3vjMb?=
 =?us-ascii?Q?8DYGBLuiwV2YZG8Mqd+L2nAdMybdytHsR48wqqCXL8LE06/TTDAiMbaJp3l2?=
 =?us-ascii?Q?af/3kNC3evPiVTJd5rhjOmy1yDCg2x1BVQQNFkW6z/602OgwoTp4Pr40jJk0?=
 =?us-ascii?Q?8bZnrHkDY1eJULZFhpd89rBHXJoBlWExwleqNi6ta8NHZjXUQmTpJ/smFUlV?=
 =?us-ascii?Q?Au6L2kDhiQ9UGkSDUceA19Aj7Q926L3DnP5HeAwdUJPhkgwmGnoAgKOKIQhU?=
 =?us-ascii?Q?12N/GlvxwfXx21IO0Q1l76mo4K1JhLbzrxv2PUBXabattx56ZM8mwBpIEJyT?=
 =?us-ascii?Q?Z1Y2Vcn9o7bih4ezkTDtSvwIlvL0aLt/6xAtNfoq71AkwV7Bs9JGDHLIm+Ww?=
 =?us-ascii?Q?zHmvV08evmtofJjXoK8jtZ309m9sPlbwysLe9Eo2fC3l7o7sG5koYtE3gS4Z?=
 =?us-ascii?Q?dphM0L6nl5R4OCa9RoPhmfO0aMFgRDWwnVVZzqxa4IMVZr3x+H4SkmeHiATp?=
 =?us-ascii?Q?1SNyR6+gYKtJoy95H5wibAmBEun/4ciEJHI5dEMzap2KZPbHVETDhSkp4+Yo?=
 =?us-ascii?Q?8IaUL0OgkljfjBhTfkcywuTNO71n4QXlW+MwqK3ODdxSM575BIAy7IjiuhdB?=
 =?us-ascii?Q?neqg/eOQIhqbrMQKJAGdILSUc4KKCh59CRlO9qfEJb7XGMCFbG+j8tlqNsIw?=
 =?us-ascii?Q?Qt6txpd5sCTuGkxv/BVYDqY9W5w1vziuoCZJEThkWkrN0ZMvM6V3iibDdUVi?=
 =?us-ascii?Q?J8vda/hRNljXS+wSlPdiTN6e0KEgviSaCY55UFE/gElwSc16f+mWSXohpDNH?=
 =?us-ascii?Q?Rb5XYtB+LF9XCnVdu5ISSasOGQNlQf0ziyJ10pY22p9m3R1+IVIitHC5WhtV?=
 =?us-ascii?Q?mvL36q7KOX/kEfpg5xsZihkWuGDtbXZVnRqIqWrDMczxsqcKk3qhGpHPhPwp?=
 =?us-ascii?Q?RQuWD0kP1b8JSDd/0UE6zfDSoFm0Um/75WHdBZi+rBeGYShaSkqtI+m7geD5?=
 =?us-ascii?Q?lEqgJq9OMEX2PmbnpI+mo7bIs1uR+3ySXxm1vnDTC89a324C63LmZOGif4K/?=
 =?us-ascii?Q?e7n7xnnVBbU/ByOmgAk5EM7Zxu5b2Gqer/i24IQ93sWNGicqW0UsFCwm8oFu?=
 =?us-ascii?Q?ghF1F/XuDSn38Yt2iOqkjBSyi1ZQ0Ag=3D?=
X-Exchange-RoutingPolicyChecked:
	KNcflY5Kg3O49n5CHnTF1Bl8+Bp85io9ZCfl+ER0EGuZxfpAE1BVpWrcg+KpEBllYUFGuJGYJu8G2vOvmChLjTXvqOnxSwjkL/+pEnS4JL3gONJJ4iesizxIWSbU5TcSYgd4YQfYQYdWMu6DIaZ7Q7LykNvHJ0iv7eGz7sx6Nz1Ab6qyXCEFe5F1LLQhjMK5/Pq/yZdLByxXi41YUYnuyP1V4VlI1WobaP43wl4nqySesNwf05Hzpmm/yCA7Mgh8nRir4l3SSRjArngt6bpIf6873EOm333xx4sdl9s5GRYszOolq2wAluNDE66yTqjVcaXWSnFN0Rre/SzeWfhpaA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nTLhXxITHZAGjoc/ug/uaiiALGztNejR6pJnEIe5tIVSOwGUOWPC6g1BnRCC6HrZo5kig8Ik/3AMGexNWKWJQ0PkFBdG2LAQOCE4o6L4/4GmcXl3cB1xt59eIErSzzA0OBO0IwAEttsSEeULT4Dwzci4kKCEj4sswXkm6s0wXDPTV7wHSRAIb0TXh1xUHW7tyLKqwPDABG7879YywcGe1SSyVuQEJUyjQRVr/q9sQE1Wp07TDlJyEfVOcq93g3bCHQttCR80S6nlhNIWgkD+NL9AJfRcoD19/5pNRJBlh7NQdEl21xZzhJp70fnP9D+v5UwqUQzefPbsrBJMwWu6f+9vtZLtyrBuKSuky7gy6x8rWChOMjLw1xztM8fUTaAFmN0b2l4T+ykv5pYxpa+P6//pRXRsBmMVj9bHbLHy7frfgZ83TaJJ7AxhrC9MmjmrmQCvMGasSDj8WnIhLEWcxKdutsS+ueWR8CGQlIgCWc0vEGd+ZeDdF+fmBxEl+wjXuoIRyFRSo0BIsKJ9qAhHsCJ98znAciDQafbYW2tUM0nfOiKTjlOdKPACzXbCkKAP4K4HaEbRuHx6LAG+9XfV5aAHcw9dKk/i8WTwLJv+LnA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a75cb4-f1e6-4b4b-295c-08df29725bf3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:38:45.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHY+wH8NdRoODEKY+btB/YjEhJnOslqyEDMTxNN/XnhyjVV3X45GT0Y/uj8u83Z0a1yxJGRiapRmwzVomGbJCwfWlbqIFGIZIK3G13Vx/j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610130086
X-Proofpoint-GUID: Xz0lerQotPCREl7kCLwEBLVEJ3-FZ8-y
X-Proofpoint-ORIG-GUID: Xz0lerQotPCREl7kCLwEBLVEJ3-FZ8-y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA4NiBTYWx0ZWRfX7ArBboXiDzjE
 HMLz7J5jY/ouVuCS+NCpgB7eG6HjfwWtTqrlYz7VxNgVb7Zwln/L7GMnMpGOrj+f+UZBFancRPy
 DmBYUJG51LIRKCC+J+x+NU+owTsYo4IsuH9cu7Mu5e8EK8VvYCyc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA4NiBTYWx0ZWRfX9aFUut1SBomr
 5xtevYTuYgtuMywPHs1W2KTdiXeP+VWWx+l/Oln4bBRI7ATujBW9EyQxn8O9XGKtw3RKAlT4d7b
 Z53JTRb6MsBZK803Z2MRKkoef5yhKrt5MoPD0IAwihpaG8enxJJY2w7a9tf3sqLeOyFkgn4375L
 mK66ZqMm5ylAnrVNi21EIQw0u76tssC8oUnR3NaUu5C9lmFxULY/q8QDQKDX3vgeOT03ChSPph3
 OrCHe6KGH2pDy3y7EcsG+JiGQ2IHUQn0pQGda/gcTTURivjOe9BnNO46sEaGJ7G2McLLB/V67yU
 EOUkS5S26Fyr3LuCdXFbBh8P0HCj9a0ZUuCUsyOTDlVoR2CXrCTo+VPmBwzI4I09u8/gjRWCdj1
 /kIEqNI+euqCYjhoBzqMhoZuScTNW7JEkD7WFNaCaQDSnh9HiCeq/hBRhpipmKp7BwzBDl9lr+k
 CVzlWRTwXIQhYmVUvNQ==
X-Authority-Analysis: v=2.4 cv=J/8/fwnS c=1 sm=1 tr=0 ts=6acea4e9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=q7rp4hw91RTOSAFIDu4A:9
 a=WmVTiCyuxqgg3mnwYu6p:22

Applications can place JIT-compiled code in POSIX shared memory so that
multiple processes can execute the same code. On Linux, these shared
memory objects appear as file mappings under /dev/shm.

Perf uses /tmp/perf-$pid.map to resolve symbols for executable SysV
shared memory mappings, but it treats /dev/shm mappings as ordinary
DSOs. As a result, applications which provide perf-map symbols for JIT
code in POSIX shared memory don't get those symbols resolved, while they
do with SysV shared memory.

It would be incorrect to classify every /dev/shm mapping as no-DSO
memory though, because /dev/shm is just a tmpfs mount, and it can
contain ELF files.

Add a filename prefix "/dev/shm/no-dso." which is recognized by
is_no_dso_memory(). Applications can opt-in by naming their shared
memory objects "no-dso.<name>". Executable mappings with this prefix
will use the perf-map file, while other /dev/shm mappings will keep the
existing behavior. This allows applications that already emit perf maps
to use POSIX shared memory for JIT code, without needing to implement
jitdump support.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/util/map.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index fb0279810ae99..c2e31be232c88 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -258,6 +258,8 @@ static inline int is_no_dso_memory(const char *filename)
 {
 	return !strncmp(filename, "[stack", 6) ||
 	       !strncmp(filename, "/SYSV", 5)  ||
+	       !strncmp(filename, "/dev/shm/no-dso.",
+	                sizeof("/dev/shm/no-dso.") - 1) ||
 	       !strcmp(filename, "[heap]");
 }
 
-- 
2.52.0

