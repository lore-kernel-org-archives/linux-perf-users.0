Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2C2FD7BC;
	Fri, 20 Mar 2026 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774050398; cv=fail; b=AcfOJ03iwm+OjJlb+TKIkzr2/b9jxcvN11n5XK/oVr+dCoHieOlN7HRDP0eiaHqbDI3kP8MQrWcalRK3GzgIE/Y/yvvuYF5IZQs5tnZ1ip6zFmOqKabDTl4hg4sVZS8RsaVKdQWhbYKLJs5o7J/N9bWyWe5ipb5VkarKi6bifyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774050398; c=relaxed/simple;
	bh=DQr6SDIglSEj8x3Lo+hHzmGW1Ko4nZQLqY0U3BU5WRc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hlz3bb9g3WPbc7ZE1MxjCQpJK7LpAKTeN3+nR/uQPVwrVwLEoBHhPp6xlc43j9pDqonGJ8k+KOP0rIALkr9RHzxJxYNSNNQ9FckD1CV0sX1Kr3bX7i6rBUqX3C5H1r2AhjY625YxmfH3ukiCiTYCYesvBXt5SfAZDmfBX3+dTh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=otWaF29l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x6OVb9DD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="otWaF29l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x6OVb9DD"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KIf04L2498897;
	Fri, 20 Mar 2026 23:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=1nqqTLdLewUBfGOf
	RAxEH2sC9dgjk9JAyhwcmGysnco=; b=otWaF29lmM7T6BSxe8ugC1RQcr7Uyzue
	oPdNphDsl624/t1wWl/UNa2dVRL6jSW5ywMv1uXlVO6QxsXIN0JUscn4nEfjyF0C
	KKU0F6a8HF1Mn/gzRPDHTYifGFNlJkg8OSmepAITwBMx10JB7wgq5KU8vdXDF5up
	m6XS8OJCZ/ZQtb9pjIDnVyzqTFWm2GG+LPdGFfEGWS5YtbwEz7jW7xM7M4Melnjj
	6feaK4sXZmbJBYhSh4wmO5TfvA/XwORLVKstjThBFFCwXC/wuON/oIJ3UzO8UfIS
	evrA05gllGMrB/gbp928TFZq4hInGwH0022bofoDQEi5fKYSq/CkaA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rjjhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 23:45:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KLQn2H030614;
	Fri, 20 Mar 2026 23:45:58 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4eutf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 23:45:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLDscwD5H0t0v2sJhdxTFKK4RN6REq9RnLExfrTLr3LKxWxWzGPNOqYPkpI5wsHbklE45DsdvwESHVbF8pSIL1r8b/+cHTk0Z3f00yxVpJUhVe1ugp1gvQoeVNu/qnyUxRPxzknEoSzd2MYhiscJKve0Z9ZdfjZ5w6QFqsFVQTlGfD0m6QcH4gUi9p1MatrPGf9z4TVgyOIxjjAQ+zk7luRsOxgCzKnh4m5QkKmmtXkdkq/ht2XLhAn4ghPNGysuLI8aAFFsrq3MVYU+ieimMwu0wil2y+fgNnUJlTOXQl3vxNCWrhNdvBG2+9dsZfGjcFBk528zZlUl6DVPtnejJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nqqTLdLewUBfGOfRAxEH2sC9dgjk9JAyhwcmGysnco=;
 b=nHolz6ZPUkF9EeLFriQf6fuFH794ioXghXfuS5g7DT+HBqG2GRpHTyCcWX+5FlwNyLYRtu7b3KpomnGtmssFcI+D3SWaTERiF/KXU7aHqbp24u2v485N8310vmF2VNDj1vgpOvOyKyxp8G1VC/UrnE6dVlw/tZahVJS+wHTewoDi//HUnQ63pQ5hh6RWOur6Z6tJ+qBtDpvNf4TaB6Iu/Kaa34TpmBrnJWVSG8iz6u1t40B/KyzVSkJw+e3M5/2r226Y5n2F44SVAnUCw1LyUg+bUZIotuEa/55BPVYvkgI9y4g+GV6ib/TnZAIsPIeorbmuPWyluee7PSsKmvWoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nqqTLdLewUBfGOfRAxEH2sC9dgjk9JAyhwcmGysnco=;
 b=x6OVb9DDzTsvhdCioxNK5ud37/yVO2t/rrynS2HYmXrx6QGjWXjNieKlCy+yjG041PjvFZsWgmsjpaX0A2896T5G9SRgYPsVpSRXjnXuzZcyPpCPaPgJyWKZBNDrcwePlZXVIqr0fFfFgUe/W8FUN85JBjHZsI/3nq5zxnBvEfY=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DS4PR10MB997621.namprd10.prod.outlook.com (2603:10b6:8:31c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Fri, 20 Mar
 2026 23:45:56 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 23:45:55 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Changbin Du <changbin.du@huawei.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Ricky Ringler <ricky.ringler@proton.me>, Jiri Olsa <jolsa@kernel.org>,
        Wangyang Guo <wangyang.guo@intel.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tianyou Li <tianyou.li@intel.com>, Ian Rogers <irogers@google.com>
Subject: [PATCH v3] tools: perf: add comm_nodigit column
Date: Fri, 20 Mar 2026 16:45:53 -0700
Message-ID: <20260320234554.2560453-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH3PEPF0000409D.namprd05.prod.outlook.com
 (2603:10b6:518:1::50) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DS4PR10MB997621:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea4dd82-b093-464a-3476-08de86dad462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2wzF1F+MSdEM3GGfrE4yy5Ve97vOlZDeDMoBChViHWt9FwOZh3lBpHGAeHMwpdNwkgHiIPc9ItH4ZedhA6lcuaYOkIrm5B08nMXg9TJlMvg4OQwzaS4u1v5ncTaV7JOM9zXjQPiqp6izeC1vyB0kAsAUQtpcbvbbGl0t/F28AdVq4MH0lEq1yRDeOVhAFWkIPA35YCxzHpqtLQp5pVyf8Jr85LJtVimClHETa5ny/0sbvfquYnuRr6vvZyey+ythsuKU8gdZdzGUzGYtyfDO3wXeR1OzWnpCbKyRbLA/O0ILMnMho2pKoXfdYnYMA2Yk7zB2fQRZs0+B8lP8rrcKVeJcB7qBdpeOyxIpnLNhk9HzOkQTGFq4Fcjsl6F6hsgDfYdic42skyf6NGYiddQOuZBRjecAcY1etNGgZ8TkIT4L2xlx5iQiH/hP6MJwqnoH2OdZjXWNiPsica3ZgM+MXDj+jIvZU6YVV8U5JQrcSNtBMpyJacupqBi2z0IOCVm1JCbUD19XUvRvOBVPbSXduT4iE0OSW4rP0HK9LTFSME8T0B/rYNilulh3xPkbndhiGQgaP7BMn6QMOaPHrXq4QlP916+EyhaFKkbeyYhiMPghBhkwlIqP8oxDzdaXID8j/wKcYUlPDhNb0rXOem3WaVJC8FWMahdqTJpJJ2shEE5gBaU7HbzZAX1W2QkF9NOdgRvtnmuiMPtTsoZUjOpiuUn8jn24BMbId6jithlWx2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5bru0yensiDGTLbFi7j+EOt2s3c/7jhhTAreoB0ufujiNQutn9A1HlEvb0X?=
 =?us-ascii?Q?Tgrre4qNqvnKU6LHau9gp32phrsJc8eC/q8wuJBHAXdQ+dvhTcV0gyzJuh2g?=
 =?us-ascii?Q?5vZCKkcjzjCkwQ5DF4LkuicgczVi0eXRxsCc+8QhDvtbw6avS1zdQiqnpY2f?=
 =?us-ascii?Q?VzofgZ5G8fGb+BylDB8fuaDOoHxGC8g/eP+/ai2pHyO9se8MfEHsYoQR+ZLk?=
 =?us-ascii?Q?Ep2m2kfsm4SRm0i4iKTWVMKS1+D9uBqmdUVbn0nWd0fEMeCUCwyLk9Y2WriF?=
 =?us-ascii?Q?TEHCtt40smBb1lZLTt9sxRffeCy4MEeRSG+Lco8Xc+5sslFIenwi0uKtUJ+B?=
 =?us-ascii?Q?PXtSx4e1kv06sCMwweVYgyE/lia5R52iLbSkaXGhU4GqjCDLBMJRTYFOwcDb?=
 =?us-ascii?Q?mHOMRV/jBplrfstmmqTSpa/y560TgJ1TwGh5FNF80J0jJUTQZPGDBpFvukJ+?=
 =?us-ascii?Q?bVTM2bZL/GfuiRUja7CFe5nKfkx0uPayeQ1MljHG2UHrs6fchm7k9dxrF0ru?=
 =?us-ascii?Q?iH6KJkRDVXQ5VQjzYMkvh4b58m/qhEoCcnSS8VjwgCayBmW+uilFdgZDsQDh?=
 =?us-ascii?Q?49BPvqySKo06PA3pJw+Yckijc4VOYXZOn+HzfXCIZKfi5emwK1n1mfWfJHR2?=
 =?us-ascii?Q?UEcckuKjzKdn+0alfVi7ugpxS9lVa+dF1W0WDtIYj1691W8K1f73ch9ELKlN?=
 =?us-ascii?Q?r899gZbHHHizeygRZiWxI6e8o0aIzTppS75wobDy7csPD39qLwaHOyDHilRb?=
 =?us-ascii?Q?RIRQvZoDxZtEQYygwLchwrNOsiXbhFcgcwSI2T1QVTuvmEEEtBip75ahX+RJ?=
 =?us-ascii?Q?qPR7Ajm2jYkJnDKgmPOTvbeKc6H31HtF+rfz9ZFKzzaJmhn+sKFh7VkRDdIA?=
 =?us-ascii?Q?ffBRN0/wz3p9sxCLVUHSFY1GRp720iPqWANlGXsF8Tg9vGHqFv/WeTgDNwLV?=
 =?us-ascii?Q?mqTXWcbOTmWB9IoVBPri6T0j87fSzZlEHc+0Ow5Ze2BIU5Vm2fySV3qraC6q?=
 =?us-ascii?Q?onJwsjwjTJS7y/qI+STU26Wcqd5SiExL73q5RZr2U9EX1mM/VMwsSgOMttoE?=
 =?us-ascii?Q?eypaqdsSJ1GphuhgjicZB0mIn3RZKpIE4nQj1NWAqn3ofGYnK6EU5khefZol?=
 =?us-ascii?Q?LsF4xWGVzVNS1rl4z2pc/BM92nu9S/hEnusPupFpG1kanQovdCwUC6o+dgYo?=
 =?us-ascii?Q?NK2NqeyN4IbMAmfxc1Z8R9chL85kzghT150s5lcgFih8akWf4q9sZg9Ffdj0?=
 =?us-ascii?Q?XUNExqraWtiZUhWO+4TiSDsCVQ3QPHONbDhzO962PFA7lzvza0JACzk5Rfks?=
 =?us-ascii?Q?Pmg19w0tbT2m8uQU6tg/7Ts2GgIL+RoukWAG9TyPKy/eC6voy7ardlOFvHvY?=
 =?us-ascii?Q?Hm3HZzlQntVYI+msSRs7UYqBPEIUiaf/q2o7h0NrxwI7mTUI57xVCuQJj5nz?=
 =?us-ascii?Q?gTbRsZ3wQKoNcAWcJZR6OACuGQjCzawb2AiOLq4RE1XceJvEPcTTOuslP03R?=
 =?us-ascii?Q?DC5CKmrPiBSOmCCKJeLFDOFNmNmVR7HVf3kv498kmv7NesIeYAEsvF4JntH9?=
 =?us-ascii?Q?RNJo6X8l3wLGcyID7rc4lMYXrwmoVV/Hd9asjzgTAIJtAhBm45Xt+hImvrvp?=
 =?us-ascii?Q?VwwMTR+AIa7YTaFw8pMoAR3dkzws711NGiBcPXBINZu0jzdaPiZWmzwI2xV9?=
 =?us-ascii?Q?vnYlVJZI7ABd43ZzrOwwQHg6gJ3RZNSPMRHRg1K6VtedYOQSh5e4XaHXtj+7?=
 =?us-ascii?Q?kQqF5PIjOcFhfd/fMRrVA1QJNU4EvwE=3D?=
X-Exchange-RoutingPolicyChecked:
	WPjCrxrj+0Z/p76S1oENErskgj8l1Yf5LNbyWMXRby78uNo2cG9G+6cWi5b5JLefFCkLcSKfAJYyVux+/TRYwJ7lwyo8P782tuGNiZZ+ZRRr9s2rc2gcgKZFLNBJw2kVOTfaVssThzkDmCx4Jrd2ynrUD9wzbhOEoUhQLndHfNSmc7mQ0GG7DrVAdA/m9m1fY58EfdF6GcuszlDveQRCenh8I3e4pfUUl47NZwDcY75E/o+GL/xlo8Qsqia8dSvivPE9IZEPnTjjd7xPf2vuacqOzvv7IhpmaLPQ5+3B8MAGLK3fmuo6O4CXiyVElvrHin61yKYF41z153k2/QxhTg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xz6YTi0s8JlgFUjAj6ezXfSdymxocwHrPH1UqLeOMTary5jhClmWa2VWLjQKwgZmr2wb09gEs0F92k4JEOdPP4i7SRKPLGq5dRBVHZQj/ygl0WiZ1bzqcJyBzeWSsBY+I/hqq8TM5oZx07lynXnl0cAj79wTkiT+eCeli6aWTYK8cJdrUY/40AP0TfRGekrH7jVzmglSDuLf1kJ1sIhMOnAhZVy3Hn9pkNhHSkPyMu3vXUJdLcyf4O/LyIinRm9MdiBxZSWRwQW2Llda26ubdXM3hQIqiLKKbEPfcRp067Lf6IdoYdY6yUp7wT/7sYSymTdKCqfyrgQa5tfu3LkZPDHj7/rfDOdRZ6pro9OiRCDr0+efhp9SVw6BHzmIxTlQQoWF7MnDfofILSs6VgxywIcUwtAUn+f6R3UuogEKWuQSbw3X4YqjWnMEniUOH5QpNMytCb+qxUlt9E0xzlZ+lC8d6MXpY4/sVPOFJT/jDQ9pZlZqNEV4adjHmRtuhbwBdwIuO1y5kQdHIeN9IcDZLsxYfbsx1lPfbIyYqF4BZsNhyr62eddas/7QYlZgwigYrGNbOVD8KiD44IheOq+9uBoLyYP9oUb/SgZ9UTT7Kik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea4dd82-b093-464a-3476-08de86dad462
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 23:45:55.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMML0yiuDh84zoZQMz0FIZOyyXM4OyfVHKXvsZomNfx/4HrEtIB0A13br2pFvQVnELTbOVtEdns6XfQWWNumDc9wZ7CyVRpmAwqaQfTuSJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200195
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bddc37 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=qLUsTNKUj4uwTi3SvBAA:9
X-Proofpoint-ORIG-GUID: BjWVSv99OnZUf5ln2itJtvFjYgP3pe3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE5NSBTYWx0ZWRfX8Wb5kX0sACqH
 A/jVyfPenKAixS9D985xS4tvrlZ52hKfzqnVCs1ZjjNdmh3DSIxYjKamnFopLbER3ct/jG4zL3c
 uKgOEeFmZetPjv/2meqX5rN5bgry/SoSRtr7W+laoQMov7kCoP+VUCeVG04Cu5n5i+WnUhp2yFq
 HIZJ0z88zHxZMopdsTkFiKmpDBl6O6yor3EAJtnDFhz/6leO8wX/FzedlgTj5lPqVOeNDzZ4k6a
 9CI5RT8o+Mia4l+upI7O78bIeNiG/DGKliHALLnlhUqqcU+GSf/6IOvKOuqNSAm+4bSl4vZRApi
 bTsPyJeClk5ES3qqKgE67vgUqQQAJjcIrTAVSPffU0c9x9wjisGvyh5HjZkWo78oxovV7VNp/Tv
 z43igWh6gWmjGIY7bLa3st8WVcJfrmAYPPP783+DxI188paZI6qmjQbl7vtfEZxQHqFlcuqfnWt
 OexSgcRakcxlvprAOVA==
X-Proofpoint-GUID: BjWVSv99OnZUf5ln2itJtvFjYgP3pe3F

The "comm" column allows grouping events by the process command. It is
intended to group like programs, despite having different PIDs. But some
workloads may adjust their own command, so that a unique identifier
(e.g. a PID or some other numeric value) is part of the command name.
This destroys the utility of "comm", forcing perf to place each unique
process name into its own bucket, which can contribute to a
combinatorial explosion of memory use in perf report.

Create a less strict version of this column, which ignores digits when
comparing command names. Commands whose names are the same (ignoring
digits) are sorted into the same histogram buckets, and displayed with
the placeholder value "<N>" in the place of digits. For example,
hypothetical command names "kworker/1" "kworker/2" "kworker/3" would
sort into the same bucket and be represented as "kworker/<N>".

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/Documentation/perf-report.txt |   3 +-
 tools/perf/util/hist.c                   |   3 +
 tools/perf/util/hist.h                   |   2 +
 tools/perf/util/sort.c                   | 114 +++++++++++++++++++++++
 tools/perf/util/sort.h                   |   2 +
 5 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 802f931ae64db..52f316628e43a 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -88,7 +88,7 @@ OPTIONS
 	Sort histogram entries by given key(s) - multiple keys can be specified
 	in CSV format.  Following sort keys are available:
 	pid, comm, dso, symbol, parent, cpu, socket, srcline, weight,
-	local_weight, cgroup_id, addr.
+	local_weight, cgroup_id, addr, comm_nodigit.
 
 	Each key has following meaning:
 
@@ -143,6 +143,7 @@ OPTIONS
 	- weight1: Average value of event specific weight (1st field of weight_struct).
 	- weight2: Average value of event specific weight (2nd field of weight_struct).
 	- weight3: Average value of event specific weight (3rd field of weight_struct).
+	- comm_nodigit: same as comm, with numbers replaced by "<N>"
 
 	By default, overhead, comm, dso and symbol keys are used.
 	(i.e. --sort overhead,comm,dso,symbol).
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7ffaa3d9851b4..fc737a0a8e4d7 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -110,6 +110,9 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	len = thread__comm_len(h->thread);
 	if (hists__new_col_len(hists, HISTC_COMM, len))
 		hists__set_col_len(hists, HISTC_THREAD, len + 8);
+	if (hists->hpp_list->comm_nodigit)
+		hists__new_col_len(hists, HISTC_COMM_NODIGIT,
+				   (u16) sort__comm_nodigit_len(h));
 
 	if (h->ms.map) {
 		len = dso__name_len(map__dso(h->ms.map));
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 1d5ea632ca4e1..d97a4efb92505 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -44,6 +44,7 @@ enum hist_column {
 	HISTC_THREAD,
 	HISTC_TGID,
 	HISTC_COMM,
+	HISTC_COMM_NODIGIT,
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
 	HISTC_PARENT,
@@ -522,6 +523,7 @@ struct perf_hpp_list {
 	int socket;
 	int thread;
 	int comm;
+	int comm_nodigit;
 };
 
 extern struct perf_hpp_list perf_hpp_list;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 42d5cd7ef4e23..fda8fcfa46e07 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <ctype.h>
 #include <errno.h>
 #include <inttypes.h>
 #include <regex.h>
@@ -265,6 +266,115 @@ struct sort_entry sort_comm = {
 	.se_width_idx	= HISTC_COMM,
 };
 
+/* --sort comm_nodigit */
+
+size_t sort__comm_nodigit_len(struct hist_entry *entry)
+{
+	const char *comm = comm__str(entry->comm);
+	size_t index, len_nodigit = 0;
+	bool in_number = false;
+
+	if (!comm)
+		return 0;
+
+	for (index = 0; comm[index]; index++) {
+		if (!isdigit((unsigned char)comm[index])) {
+			in_number = false;
+			len_nodigit++;
+		} else if (!in_number) {
+			in_number = true;
+			len_nodigit += 3; /* <N> */
+		}
+	}
+
+	return len_nodigit;
+}
+
+static int64_t strcmp_nodigit(const char *left, const char *right)
+{
+	for (;;) {
+		while (*left && isdigit((unsigned char)*left))
+			left++;
+		while (*right && isdigit((unsigned char)*right))
+			right++;
+		if (*left == *right && !*left) {
+			return 0;
+		} else if (*left == *right) {
+			left++;
+			right++;
+		} else {
+			return (int64_t)((unsigned char)*left - (unsigned char)*right);
+		}
+	}
+}
+
+static int64_t
+sort__comm_nodigit_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__comm_nodigit_collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int64_t
+sort__comm_nodigit_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
+}
+
+static int hist_entry__comm_nodigit_snprintf(struct hist_entry *he, char *bf,
+						size_t size, unsigned int width)
+{
+	int ret = 0;
+	unsigned int print_len, printed = 0, start = 0, end = 0;
+	bool in_digit;
+	const char *comm = comm__str(he->comm), *print;
+
+	while (printed < width && printed < size && comm[start]) {
+		in_digit = !!isdigit((unsigned char)comm[start]);
+		end = start + 1;
+		while (comm[end] && !!isdigit((unsigned char)comm[end]) == in_digit)
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
+struct sort_entry sort_comm_nodigit = {
+	.se_header	= "CommandNoDigit",
+	.se_cmp		= sort__comm_nodigit_cmp,
+	.se_collapse	= sort__comm_nodigit_collapse,
+	.se_sort	= sort__comm_nodigit_sort,
+	.se_snprintf	= hist_entry__comm_nodigit_snprintf,
+	.se_filter	= hist_entry__thread_filter,
+	.se_width_idx	= HISTC_COMM_NODIGIT,
+};
+
 /* --sort dso */
 
 static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
@@ -2583,6 +2693,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_PID, "pid", sort_thread),
 	DIM(SORT_TGID, "tgid", sort_tgid),
 	DIM(SORT_COMM, "comm", sort_comm),
+	DIM(SORT_COMM_NODIGIT, "comm_nodigit", sort_comm_nodigit),
 	DIM(SORT_DSO, "dso", sort_dso),
 	DIM(SORT_SYM, "symbol", sort_sym),
 	DIM(SORT_PARENT, "parent", sort_parent),
@@ -3579,6 +3690,8 @@ static int __sort_dimension__update(struct sort_dimension *sd,
 		list->thread = 1;
 	} else if (sd->entry == &sort_comm) {
 		list->comm = 1;
+	} else if (sd->entry == &sort_comm_nodigit) {
+		list->comm_nodigit = list->comm = 1;
 	} else if (sd->entry == &sort_type_offset) {
 		symbol_conf.annotate_data_member = true;
 	} else if (sd->entry == &sort_sym_from || sd->entry == &sort_sym_to) {
@@ -4040,6 +4153,7 @@ static bool get_elide(int idx, FILE *output)
 	case HISTC_DSO:
 		return __get_elide(symbol_conf.dso_list, "dso", output);
 	case HISTC_COMM:
+	case HISTC_COMM_NODIGIT:
 		return __get_elide(symbol_conf.comm_list, "comm", output);
 	default:
 		break;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index d7787958e06b9..c962e77e4b938 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -43,6 +43,7 @@ enum sort_type {
 	/* common sort keys */
 	SORT_PID,
 	SORT_COMM,
+	SORT_COMM_NODIGIT,
 	SORT_DSO,
 	SORT_SYM,
 	SORT_PARENT,
@@ -158,4 +159,5 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right);
 int64_t
 _sort__sym_cmp(struct symbol *sym_l, struct symbol *sym_r);
 char *hist_entry__srcline(struct hist_entry *he);
+size_t sort__comm_nodigit_len(struct hist_entry *entry);
 #endif	/* __PERF_SORT_H */
-- 
2.47.3

