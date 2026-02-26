Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755A27FD5D;
	Thu, 26 Feb 2026 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772089427; cv=fail; b=Bgi8CHaUMWMYfLh2i0VmP3OJvKYMBFKB1By8LoTAw/RCA74K9CeGRpDLOu+r/jVVZLln7LDthPmh5MHu8NTirf2/PhPr9KUvVQoSMMWeCMVZfdm0fJYjDrfUp1lvi9mfbD5mLCmvZfIuNThH2rngHiCqx7CyVWYqvbpFKAae+8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772089427; c=relaxed/simple;
	bh=s9br44lZQd7H9ERO4uEEpFxRtDd3U9Kme/BG2dMHluQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=dGTePDTw/011FW4Ojvi9iATAVdpz9rtUj0PCrGq2cEMIa8MOKcKXI3H+qywUyZVncZlEpPGA8gr8vafuWuKYwU1lqQbvdWUOGC3Jb9QU/KlJW9DnQLbAw2Bd2hGarzTLYLos4nvN/ND1OUbhyVedGS7FsjQpPR7Pc5zJLONnl3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WfI32fmw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=asnq74aX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WfI32fmw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="asnq74aX"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q62i9b4032393;
	Thu, 26 Feb 2026 07:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=W2W0E4kNmGkj3m7NQY
	8mbJKHQC/O1tmKjAnMTiiYkbk=; b=WfI32fmwMlKRCSNpkBqjBtB1qyRV0cO+hp
	vIlXQS9hunZXFRD8dwgRN9NmJcpuKjW1ViqH7zM1yFtDfbocKxIGXofbhS5N1Lb6
	94lv1knAiFi+RSjuyo1XBiMwKGMqH4biPEw1NAl+SXoIKhee01wTkmQyOQKnGfbS
	KwUlMJzG5v0uNNDAgPmhbvfdzwYddRdr9zcRn9YKtOdGwW+d6bwG8RGQLYuqfgqz
	87ma9LjYK/na64SbQA/z+nofiWfIDc9NBSKkXc/eApTPLn5P10xeldrYvvFOXUTe
	lS2yAdMOXjxMd6c1dJ6wqp/CwSQHpgaTHF8r/abc3Rmzw0V6QXOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgjfr1rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 07:03:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q5u06G027842;
	Thu, 26 Feb 2026 07:03:33 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35h568q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 07:03:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMbPjjq0nz/076aXttoViMwFJmaMsGnT20HTUqYqA/VFjkm7eQR2dvA04ODLUjSfUWuItwF7AwvE9XFBe0RZ6leUv21mpKcNrqw9B24VW5mWRboYvGArSUHR7jrTkZS6IId0eWxGVLtNqXhw5GUTiAwSLLHOiDOC0WgjKa8ppY8qBH+gnZExSlQyvD9pSsGvFHY6eK9+1CbH1NsAvPw/3WTUUhfmpZDRiAECm8VF4vnTTmcl+bioCjymXdlmGtTVISMqvcpLkg9tgM3ifeKrXj6pMEEpIyQKLXiq4lNqPvCdffdieZUm9yuZYkRtceN2LVilnMYyV1U+bnOCV0YHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2W0E4kNmGkj3m7NQY8mbJKHQC/O1tmKjAnMTiiYkbk=;
 b=KyoQv0pbyyyZBMR44aTK2YfTDDDIploZeaov0JpZ2EMkpCaoZkvL83CX6esqRO+NFscz3SrhbRu8lJiF7Ka66YaeliZzYr5nYZGHqSwrlHaUiFskICyQu/eKgeLZuAtQ3+IN3qOuuBbWYOC7OEPPTxKHin8RCm0YlGgochTSQwJ8BdfQ1vngsBCqxqlvLVIOUNWZoPPBZG6AwIw4xHLsgVR0MmGqT9PzP3NmH9RyfAL3p5Ga9z/b8oHJYxTp8W98syh2nOJs9k1JQARofRzMTKkU2vTd9sxS6M1E7puPjJ8YvtuHLYPh7+PY4IPsPtoTQDxq3otaMDw9EWt2bBoLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2W0E4kNmGkj3m7NQY8mbJKHQC/O1tmKjAnMTiiYkbk=;
 b=asnq74aX6+Gw8LZHaRmAVViAKmXghCnmIcLWf6XFsp3vp9v2bcIzid4FENvUZ7jS8pElZDDlAS14lL9mDFA+8655/Gc6YZJS0D7OX+r4w/yTGsX2EUitiAz5RlhenMHJ0aZf3VjrvQhwDJooxXchZv6EMUtNO4Veq0oPC2Ec6aM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5795.namprd10.prod.outlook.com (2603:10b6:510:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 07:03:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 07:03:00 +0000
References: <20260219004417.188434-1-namhyung@kernel.org>
 <20260219004417.188434-2-namhyung@kernel.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers
 <irogers@google.com>, James Clark <james.clark@linaro.org>,
        Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML
 <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Ankur
 Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH v2 2/2] perf bench: Add -t/--threads option to perf
 bench mem mmap
In-reply-to: <20260219004417.188434-2-namhyung@kernel.org>
Date: Wed, 25 Feb 2026 23:02:59 -0800
Message-ID: <878qcgx9zw.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 276f155e-0653-4104-a08e-08de75051419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	v9hQatiw6+03tA5C99QYnAoWzI7uQ1i2iML+FfLKeWnuOrrS6s2HdBiJi64a2P3hexdt6Hc0hvJ6K6Jxi/rsuRFTV5O6wgEJkA4cGPUMnbRJnVCeUBZohmi0mkdDCUhpXQ5BJ80KC1/II7jLi5NU4V1JSdtPOCPpjdUOkcg/R7YTK/IrgMnOKEIvvLfOzsrhx8QB/iopNT3yoWQlUbJg4e9gWThtbFIfhxzUqXhLnrBzwgISJLN7HKwcTHz3TCLCdhj8Lw/scdFv73iQ+nXeimD0RXHVuoCOA8LU1LSz4/NN8wmTSuRjQGRu12+NOwpJ9FPhOKMAcg0hVf/tcni+aNpgYx6USr3junxh+AR6l7+LIK0YqigYFMEdkcJ+hENNuTQAU9QCyDr/Tnj/QgJT4Mgjppp1HWp9f6u1myOEMh/rSZTeBYoIHuTsnYrYbBvE3314frmyzBwuGQuo+KA/W0GjIy0Ot67cN99rvdWu22igk9aN+rgoWrPewyxUVmyGvBel2CmGDmEzVxjLVtzRSTzeZSKQwPi4VELi7AqPGHVTD6Pdn8HryfYvvuOAG9tH3M/2AxGQCRjkAQxXPJHGsYrV04zPVPHtRYx3n4ms5WEXgR17hhsrbzBBf0lO7tB17zJdjqBBjsL4Ze50u1audNqT6wUSO69cHp2o01qn03/IjezagXWonzOYGIs+XKsYY08V98d6PSXBHeiQrMHHmAAj9sMmy5Zrw/yb2D5WCSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9+7zPIPq9enAbDJXRka4qbE/dZa4FbA5lU2s7Wczo4XqRLFpFPHONVsxTNLc?=
 =?us-ascii?Q?3ZKPzQsP9t34agt6Fu7KRDsH9O/rcjf53gfdkLg3ewS9Acpvt+BhylC7Gv8m?=
 =?us-ascii?Q?/IHxr1jljOdw+vK6tdUiU/dtORzgopaBVDTjQE4nnSjPHBA2WReuJUBbT2dW?=
 =?us-ascii?Q?ibqw/B4fHPEM7dnqGFgZWWOhZbDDFD5NHaRkTLDge8AmTk1XfqDDw1T421Ej?=
 =?us-ascii?Q?TNsiYb5r36UikjM1MlALqOweufQrSSP7eegoBkizWFpdE6eflT4o8hooEIh+?=
 =?us-ascii?Q?bFNWlk0QYMb5jBwo5AHpxp1RJ0Soy1ffxXUJfNz5twJxNw32APVaXO/Qb4uL?=
 =?us-ascii?Q?EqokSMiNOIfo4X09AJlJtq/40EKLZDvcDcVkhQ8idOEK89obwU5ZUPMbQIdL?=
 =?us-ascii?Q?AmYbRqEaBtlge/nIYVJ7VVF2Ls0/th5ux/bwwypugdJaBjdZFhNea1sGMrr6?=
 =?us-ascii?Q?DFEpfW+HJBqc3KPk4Fnzml7znyi0W2iVvQVZ9wioLylZ61dONstoFgLNxJ33?=
 =?us-ascii?Q?iS6dMM08qIDJabICvK+Y7S/Jbs9Jtufei3LK4r4ifHNeWLNr6RTm0iDrMh/f?=
 =?us-ascii?Q?yXErPSaWZu61UShHGDbW79tKrfGBzBpCE4nY2saV63tZdsOF5nNxaG0Xzq87?=
 =?us-ascii?Q?6zUUvA0xQ1jJdeh7tPtfiqp5ES3J9qzVNBMr4sVWU0C8NQfYNHHSIb8kJlmc?=
 =?us-ascii?Q?VVO+vyDxsMjh71gQpnYRuzsIWSlunnXt0iOwD6YxqxYZDk1wjIT6QLQKtfJR?=
 =?us-ascii?Q?qRBEAYb1dGZ9plN57xq+jbVcnvh/BZzZ2UkfkV9Jt3LnIlpwcyJO2SiFfmGk?=
 =?us-ascii?Q?fFADFGUytSjfOgMHcwYT1Aj9he+6JHkXqZ+gtRZi1IGfPVm3JR40+dfArnSL?=
 =?us-ascii?Q?+4GtjTHOUjBnlHHG7rnkD67xD9Op/WD9mfstsgqC6s5Mv29Q+ITc07pkVQlb?=
 =?us-ascii?Q?lr6ngIHzv7/9APWVl+3VagRcWBE+6nKuqv2tp+owRsv9fnkewKV4mBEblXjQ?=
 =?us-ascii?Q?4JYk0w4s0IdldVGll/J/j6VjLSlzCBG7ChQb/OPCtsHE5+XvG8VHyv7QlXVr?=
 =?us-ascii?Q?wx6oLL5Olxu4ngZr4yUJetD0ynzb54iQkSdmz5Fium5jeaqTRJ0ZE7CUznax?=
 =?us-ascii?Q?EYwpXzG6ULh/vsxjZSJXMhXt5AE6KEf2DAn1RR5d/QMo91m5ZTOeev/2gFT8?=
 =?us-ascii?Q?ZzaxQ//Kbt3fH3RQIDVOrCcMB6aFv2uitpK5GOgKKXL3+XWBf/XspDwKIbVL?=
 =?us-ascii?Q?4gDtrIiEy2sihbsYwP+t5zHgeqNmh1UaM+h6etARy8xaal/5pe6L6hizLLwB?=
 =?us-ascii?Q?6HyAygF19vxfYkf0cGHyPyEJJcGQJnvHtX1FdzaOKeHNftzFlUZP2IOamwVQ?=
 =?us-ascii?Q?3vf2D1T4mXpM80QU2ZW3htHnqFOPHfIQ5Jz8QXAzSKxnNyQhKrcmPZTUMrF8?=
 =?us-ascii?Q?M+jg1IELxnMUvdguVDSpP92A7CaVFB7mQxGsLTOb46N9Gqpm5bP24vJngH+H?=
 =?us-ascii?Q?XHCmmPOtguAawTs4lCftVeRXVOAxhDX65jCo80FaDOv9Oto7161oGLqUYEnD?=
 =?us-ascii?Q?QVIblkqTi/XGwzwKBJ9Cw1AQt8wDgnHbK0PYK0g3RgskdsgNFmGopfsyY7ME?=
 =?us-ascii?Q?c3LwXDxDOxRq3h8HhMxjDm0foj7VXRmhMvSZ6Zh3gI9cIlLAcTaCfplRiOa9?=
 =?us-ascii?Q?t4FEunImYfb6KValTH/gMhvRRktlpG1v3UCSeZtFwtlLtQRD+q4EQoBsbwzh?=
 =?us-ascii?Q?14xMDuOZY3VKf70axOCjL5Rsaf/ypv8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IwnoGoy4LQstbT+1EgjlyNmAWP9Lm/OzUkKi5oDNkEm/9avd/26hgyX60zThWy1wTIYQmyOhtgsnqi5/vyQiH/MgrCddG2Bp1O6il3UCQbcSB/kFKanBkFHoI7026XznzFm1KvOBUlJARMMBj/UXFlENugujwF3qzZiMf/p0QI7eWHzM+BtxEN/OtAdgn9OXe4Y/W9KdY6EiLHQ7RqKDJhFZnbsvl0Wi22TCCDe1zWyx1+eDZXtQ9YAaQDua0TVVjRIS//zQnIkYlTjbdlW8V6IBN0byF8ZY+8tuMFtd7DspxQvzA6EIIFggNCwnASTYUzqv1+I6vce5uc7aSzFgoUnvVYuTXniUwvfh4N7VVndWfa37QAYwUoz/2Yv2+ITaAquJYX09/Aa90weubTtArnOPNhrwLjTc5nJJvqcmshan4yx8sCGVCTzdbJu3hd5PTi1Mo8JYgZoSdq12Y3lChLt7XxFzgldlbecmfmz1HW1m4ColwBhamULJac/Ov0Jv65iwpDYTk5hmClzb4kSzSoSZY4cCYYJ6bKEFApGencHDEEegZlghIysgnyhaVHn+dP738WNUAnqtvIrfuyqWCNJBtDlUjR1RuCM1R3WDQ1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f155e-0653-4104-a08e-08de75051419
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 07:03:00.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ1hzKuCjrACFONEUGcfbTFyLoaTMm3WPPqNxLCfKfMXTVRpmouFBlLWp6nFHmjBUTYQvbM0YghEyuHb9dDX5gmijnjs77YQ71DMmFg38ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MSBTYWx0ZWRfX0iLZVzZGugpv
 Qw2VlW861djBkMoVXhh36Ar9YPqyc9NNfRvPXPO0hRprEdv8EhKzCDqvTcBCF0waKpEl+DjLPus
 XpfzsWf16c/BkP7YRZBDdFbE9ptdxnwk9rC5pxHMJy1o+VLvwmw+A2yvZoGONav/s+rwhuozlMa
 ov1oebULjbC5kuga9pDhtdNHE3FyPAQps+cmIJrx36rYiqOWohbPRE1mzVoIX2FWap/3lMo7W39
 FUhOP5+7lBJOeOKRVuG1l/nSSsCirNTE6q3yn1sOefAWQEFp8wfhXEidWtOC5R7+tJYlLmwVpHE
 GEENQl9MyCtIN3tW06NTnue2sGIPDpwppS8RURTjR9lx7PtaHDpx1LpjKRyzgJyUQaq2G3SXAKw
 Jtb8KfdjRrsFknEFC4Yl5iW5VFdH5HKXV0NEW5+qesJTxEc9BMLFr/ffpyz/tJ24BJZKxgzzu/d
 goGfS2Xo3hsceMi/wFUKrP/ITw6G+WOZ+WkNSls0=
X-Proofpoint-ORIG-GUID: VZLVwvf1YpQ5pvAidnTVTs5DMStA6c8y
X-Proofpoint-GUID: VZLVwvf1YpQ5pvAidnTVTs5DMStA6c8y
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=699ff046 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=f9sNAF69xHHfK-a88e4A:9 cc=ntf awl=host:12262


Namhyung Kim <namhyung@kernel.org> writes:

> So that it can measure overhead of mmap_lock and/or per-VMA lock
> contention.
>
>   $ perf bench mem mmap -f demand -l 1000 -t 1
>   # Running 'mem/mmap' benchmark:
>   # function 'demand' (Demand loaded mmap())
>   # Copying 1MB bytes ...
>
>          2.786858 GB/sec
>
>   $ perf bench mem mmap -f demand -l 1000 -t 2
>   # Running 'mem/mmap' benchmark:
>   # function 'demand' (Demand loaded mmap())
>   # Copying 1MB bytes ...
>
>          1.624468 GB/sec/thread   ( +-   0.30% )
>
>   $ perf bench mem mmap -f demand -l 1000 -t 3
>   # Running 'mem/mmap' benchmark:
>   # function 'demand' (Demand loaded mmap())
>   # Copying 1MB bytes ...
>
>          1.493068 GB/sec/thread   ( +-   0.15% )
>
>   $ perf bench mem mmap -f demand -l 1000 -t 4
>   # Running 'mem/mmap' benchmark:
>   # function 'demand' (Demand loaded mmap())
>   # Copying 1MB bytes ...
>
>          1.006087 GB/sec/thread   ( +-   0.41% )
>
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>

> ---
> v2)
>  * correct timeval2double calculation
>  * add "/thread" notation when -t > 1  (James)
>  * add stddev when -t > 1  (Ankur)
>
>  tools/perf/Documentation/perf-bench.txt |   4 +
>  tools/perf/bench/mem-functions.c        | 109 +++++++++++++++++++-----
>  2 files changed, 92 insertions(+), 21 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
> index 1160224cb718392d..c5913cf59c988421 100644
> --- a/tools/perf/Documentation/perf-bench.txt
> +++ b/tools/perf/Documentation/perf-bench.txt
> @@ -274,6 +274,10 @@ Repeat mmap() invocation this number of times.
>  --cycles::
>  Use perf's cpu-cycles event instead of gettimeofday syscall.
>
> +-t::
> +--threads=<NUM>::
> +Create multiple threads to call mmap/munmap concurrently.
> +
>  SUITES FOR 'numa'
>  ~~~~~~~~~~~~~~~~~
>  *mem*::
> diff --git a/tools/perf/bench/mem-functions.c b/tools/perf/bench/mem-functions.c
> index 676c8d18f4c2e259..8e04ae69f8a85c5e 100644
> --- a/tools/perf/bench/mem-functions.c
> +++ b/tools/perf/bench/mem-functions.c
> @@ -7,13 +7,14 @@
>   * Written by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
>   */
>
> -#include "debug.h"
> +#include "bench.h"
>  #include "../perf-sys.h"
>  #include <subcmd/parse-options.h>
> -#include "../util/header.h"
> -#include "../util/cloexec.h"
> -#include "../util/string2.h"
> -#include "bench.h"
> +#include "util/cloexec.h"
> +#include "util/debug.h"
> +#include "util/header.h"
> +#include "util/stat.h"
> +#include "util/string2.h"
>  #include "mem-memcpy-arch.h"
>  #include "mem-memset-arch.h"
>
> @@ -26,6 +27,7 @@
>  #include <errno.h>
>  #include <linux/time64.h>
>  #include <linux/log2.h>
> +#include <pthread.h>
>
>  #define K 1024
>
> @@ -41,6 +43,7 @@ static unsigned int	nr_loops	= 1;
>  static bool		use_cycles;
>  static int		cycles_fd;
>  static unsigned int	seed;
> +static unsigned int	nr_threads	= 1;
>
>  static const struct option bench_common_options[] = {
>  	OPT_STRING('s', "size", &size_str, "1MB",
> @@ -121,6 +124,8 @@ static struct perf_event_attr cycle_attr = {
>  	.config		= PERF_COUNT_HW_CPU_CYCLES
>  };
>
> +static struct stats stats;
> +
>  static int init_cycles(void)
>  {
>  	cycles_fd = sys_perf_event_open(&cycle_attr, getpid(), -1, -1, perf_event_open_cloexec_flag());
> @@ -174,18 +179,18 @@ static void clock_accum(union bench_clock *a, union bench_clock *b)
>
>  static double timeval2double(struct timeval *ts)
>  {
> -	return (double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC;
> +	return ((double)ts->tv_sec + (double)ts->tv_usec / (double)USEC_PER_SEC) / nr_threads;
>  }
>
>  #define print_bps(x) do {						\
>  		if (x < K)						\
> -			printf(" %14lf bytes/sec\n", x);		\
> +			printf(" %14lf bytes/sec", x);			\
>  		else if (x < K * K)					\
> -			printf(" %14lfd KB/sec\n", x / K);		\
> +			printf(" %14lfd KB/sec", x / K);		\
>  		else if (x < K * K * K)					\
> -			printf(" %14lf MB/sec\n", x / K / K);		\
> +			printf(" %14lf MB/sec", x / K / K);		\
>  		else							\
> -			printf(" %14lf GB/sec\n", x / K / K / K);	\
> +			printf(" %14lf GB/sec", x / K / K / K);	\
>  	} while (0)
>
>  static void __bench_mem_function(struct bench_mem_info *info, struct bench_params *p,
> @@ -197,6 +202,7 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
>  	void *src = NULL, *dst = NULL;
>
>  	memset(&rt, 0, sizeof(rt));
> +	init_stats(&stats);
>  	printf("# function '%s' (%s)\n", r->name, r->desc);
>
>  	if (r->fn.init && r->fn.init(info, p, &src, &dst))
> @@ -211,11 +217,16 @@ static void __bench_mem_function(struct bench_mem_info *info, struct bench_param
>  	switch (bench_format) {
>  	case BENCH_FORMAT_DEFAULT:
>  		if (use_cycles) {
> -			printf(" %14lf cycles/byte\n", (double)rt.cycles/(double)p->size_total);
> +			printf(" %14lf cycles/byte", (double)rt.cycles/(double)p->size_total);
>  		} else {
>  			result_bps = (double)p->size_total/timeval2double(&rt.tv);
>  			print_bps(result_bps);
>  		}
> +		if (nr_threads > 1) {
> +			printf("/thread\t( +- %6.2f%% )",
> +			       rel_stddev_stats(stddev_stats(&stats), avg_stats(&stats)));
> +		}
> +		printf("\n");
>  		break;
>
>  	case BENCH_FORMAT_SIMPLE:
> @@ -495,16 +506,27 @@ static void mmap_page_touch(void *dst, size_t size, unsigned int page_shift, boo
>  	}
>  }
>
> -static int do_mmap(const struct function *r, struct bench_params *p,
> -		  void *src __maybe_unused, void *dst __maybe_unused,
> -		  union bench_clock *accum)
> +struct mmap_data {
> +	pthread_t id;
> +	const struct function *func;
> +	struct bench_params *params;
> +	union bench_clock result;
> +	unsigned int seed;
> +	int error;
> +};
> +
> +static void *do_mmap_thread(void *arg)
>  {
> +	struct mmap_data *data = arg;
> +	const struct function *r = data->func;
> +	struct bench_params *p = data->params;
>  	union bench_clock start, end, diff;
>  	mmap_op_t fn = r->fn.mmap_op;
>  	bool populate = strcmp(r->name, "populate") == 0;
> +	void *dst;
>
> -	if (p->seed)
> -		srand(p->seed);
> +	if (data->seed)
> +		srand(data->seed);
>
>  	for (unsigned int i = 0; i < p->nr_loops; i++) {
>  		clock_get(&start);
> @@ -515,16 +537,59 @@ static int do_mmap(const struct function *r, struct bench_params *p,
>  		fn(dst, p->size, p->page_shift, p->seed);
>  		clock_get(&end);
>  		diff = clock_diff(&start, &end);
> -		clock_accum(accum, &diff);
> +		clock_accum(&data->result, &diff);
>
>  		bench_munmap(dst, p->size);
>  	}
>
> -	return 0;
> +	return data;
>  out:
> -	printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> -			p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
> -	return -1;
> +	data->error = -ENOMEM;
> +	return NULL;
> +}
> +
> +static int do_mmap(const struct function *r, struct bench_params *p,
> +		  void *src __maybe_unused, void *dst __maybe_unused,
> +		  union bench_clock *accum)
> +{
> +	struct mmap_data *data;
> +	int error = 0;
> +
> +	data = calloc(nr_threads, sizeof(*data));
> +	if (!data) {
> +		printf("# Failed to allocate thread resources\n");
> +		return -1;
> +	}
> +
> +	for (unsigned int i = 0; i < nr_threads; i++) {
> +		data[i].func = r;
> +		data[i].params = p;
> +		if (p->seed)
> +			data[i].seed = p->seed + i;
> +
> +		if (pthread_create(&data[i].id, NULL, do_mmap_thread, &data[i]) < 0)
> +			data[i].error = -errno;
> +	}
> +
> +	for (unsigned int i = 0; i < nr_threads; i++) {
> +		union bench_clock *t = &data[i].result;
> +
> +		pthread_join(data[i].id, NULL);
> +
> +		clock_accum(accum, t);
> +		if (use_cycles)
> +			update_stats(&stats, t->cycles);
> +		else
> +			update_stats(&stats, t->tv.tv_sec * 1e6 + t->tv.tv_usec);
> +		error |= data[i].error;
> +	}
> +	free(data);
> +
> +	if (error) {
> +		printf("# Memory allocation failed - maybe size (%s) %s?\n", size_str,
> +		       p->page_shift != PAGE_SHIFT_4KB ? "has insufficient hugepages" : "is too large");
> +	}
> +	return error ? -1 : 0;
>  }
>
>  static const char * const bench_mem_mmap_usage[] = {
> @@ -549,6 +614,8 @@ int bench_mem_mmap(int argc, const char **argv)
>  	static const struct option bench_mmap_options[] = {
>  		OPT_UINTEGER('r', "randomize", &seed,
>  			    "Seed to randomize page access offset."),
> +		OPT_UINTEGER('t', "threads", &nr_threads,
> +			    "Number of threads to run concurrently (default: 1)."),
>  		OPT_PARENT(bench_common_options),
>  		OPT_END()
>  	};


--
ankur
