Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958519D091;
	Fri, 29 Nov 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887554; cv=fail; b=bZcM4LFDAsMUsDZzdBuusvGpeUV6vCsmYdCQ27SPvU18H45w1iCJHayMPbkT7U0M5sqSIXtFJO1UJP47mEWY3q5+yGxRU7M5qOAgyCUYsM3/Qhxotsu+NJeAHG3yei15+3s9+olZ3SFeNJT8bYwBiD2hKhUxGu3Ph6N7ntbb6bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887554; c=relaxed/simple;
	bh=WM5KogiyzI08+k77+YC8PXielzbuH1ZSIgRUjnyYb2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MxYMuD1puDW5Z119Aue+H6B0cfpdqLQL1v2rDn8ERoFOw6GcYJ56UF82B6qiuZwGLKlFygKqqtn9gnkrhBX36Wnov4/TQ35shzFl/JdLPRV94lwaumD190SJk+hfd4JBuziQvGdMfjLXLDYtVOpI3A+wi9NnsDUWEVwJlnewSXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BP585j+j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jhWb/gx3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BP585j+j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jhWb/gx3"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT4mOWV024337;
	Fri, 29 Nov 2024 13:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=U5BkYWamtaDQ8jE9rV
	EZrTA/klvXgb8Oem6sOkpCBJE=; b=BP585j+jNU7aSgZ/TX+4TbAnlhXPGlkh/c
	65K80Q17rRIUZ3JnWPA2+vAeIr0feGI+DVIe/O5zL2tl9qGJyIrY0ZaqtgJaCnlw
	x9rk7m3OytR0tgYOk86hKciZ6wPJmxAx6Pf1VSsEPscmbEfvP47NnuDts1JXdJgF
	elLKwmU90S1geIxskM0qSB551renrNycZ0+knT7uCWb1sGzlhiMsAVP46EmS20/P
	X4tjz4OtM/7s0RxRilLeNaaHgHse75t8h2XcFy464KdhxlA/QQ8UgEDbOUUk8Jbu
	puF0XMybDmJWG1WUnVjR6nqygXK3XqO5vugZWVdOtUf2ULjb8tTQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xybabh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:38:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATB4UNM018241;
	Fri, 29 Nov 2024 13:38:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 436706r1w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9SnRezy8Xy+sMj2373ta3Styfr4ijT1mowMxonC3pDTio7EXQWkEKZv3hU0WZudM/BXE78gxur2jdOdYaNsIA1gXqqazCzEpBvAQI5ATPjsZ4OoKiETD8mMZoNV+tTsl3xVF8884RzlsiAR71axQi52re/pDRy1uvkyQBq2uEcqPVfLQyIICdhwn/nJUDo/5NHEe+UUSTfqKE3AdkXvFZrIK0n4wGixI8gzlKEAHJ3Dar9s9vVrITtz7d9OI160qhkd7Cz/UOnZUg/OyC3g8ruMJtLCrT85suKLcfJTMwI0PvC0WZOST0Jl+vmO9P9SKi2T/62FTrICnsb4n0fx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5BkYWamtaDQ8jE9rVEZrTA/klvXgb8Oem6sOkpCBJE=;
 b=MzJQaYLDWDVIUUpNiCZ8+N6GHXSPRgo6mQsxCeICJ/k5CVEj7eyCHb8AA7L04qZpxHKf8CaJEaL68iYK9YAoXNUzpWteFCTyfMBsXuILe3l1Lp/729GffmFVxTxL9Ixu6K+Mb5eue2uRl7VuHjr+KTWq6GWotb4B7eet9HqQ3L+FhLNKaW8NrRrW1+NbhsRWjdMz+/IY2Fqn+Vbfb1NpXhWx+0mc1/S691bQj+daRCQwOVeHdmP8/xhMx7s7eXpkulAoJ6LKwP6m7jOLaDy/20tfMRUAFSXo3mVY6u3RwtV180qftA4fokJqzrZtRGXlYnFjYmYDHtZJJKB7pc3GNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5BkYWamtaDQ8jE9rVEZrTA/klvXgb8Oem6sOkpCBJE=;
 b=jhWb/gx3t0Uv+aJHVttk7dYVFm0JgLl9bAxBALKes+1P0Mv//ttFdpkzEfaZ6PHBelDSb6oVaUv70S/Km7AxiCxezO37cr453O9ySgosXdUzTSsVXPTpG6K5fWAu1xzt44cZhFvSF3G6gz5ag6tRXUkahaxth4KuTxHLfqIUoLU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB5842.namprd10.prod.outlook.com (2603:10b6:806:23e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 13:38:50 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 13:38:50 +0000
Date: Fri, 29 Nov 2024 13:38:47 +0000
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
Message-ID: <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
References: <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
 <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a27eef-cc08-4cfd-01c4-08dd107b2852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tm6/gkcJu1Vx4RXxrA1jFF0N4i/zViUP9IWgWMzQM8/QO/ZA3uHy5dWkZVqS?=
 =?us-ascii?Q?HxWGQRFST8gr/As2yfctdo5DBJGQFVjyAHe9KqwvMagBJcr3kKJ2OW/sJrPE?=
 =?us-ascii?Q?WrqIkcnw74Fw+tSLrZTaeSdIG6n5va7iMmwZeH8APnIdxM9MzZn32A4DlETx?=
 =?us-ascii?Q?oiW+L1LBQIZBa0fzpcnQgbTDW6Rud59qextY+7PaU6sWAsutiQN4ZNxNhz8G?=
 =?us-ascii?Q?JJeRprOHABrcYQ3bEREdVChR/GtYdB40HAxOaZLzZwNwY4HJf6GpRxlErTc7?=
 =?us-ascii?Q?7KUN5+iX/+gUP9zODZ9Tv6KhQxPHJBgEoeqTwfVEDmn171wqfrGZ41PD0xVt?=
 =?us-ascii?Q?RTu6TpO67KXH1gtFxP5CvtlW7/Qhrrl8AN3QXhkeAq85fNvnVxDtptMUISL/?=
 =?us-ascii?Q?xYSvl4tg/7zF+idQpRX+SuO7Tx0ZUWpIFrfivdstuaKt64bhcjouyAtvx0dY?=
 =?us-ascii?Q?jHK+WLVvBCubVo4NstMc4D7vbnMNd2NgVasBkc5VG1PeDFMsbDUbjQPY+eq2?=
 =?us-ascii?Q?d9Y43GBKzWgsWSwqE9Uh+zEVfiosF3Gmh/EJg12/S62hzIs/QPPFSCR2kx5q?=
 =?us-ascii?Q?tLiBO+jotaM8FROGIwwHfaQGFracVCyw46htnyKCA/VQY+znPtmu8G42ctBL?=
 =?us-ascii?Q?RY1Os11lH9yWC1++jeBXVMt5msQwVzPKayvXPvxB37TjMNNbUFUQa+Hck/xo?=
 =?us-ascii?Q?JfPQa9SpBNEwqr3MdbmL6xY0T4mLFBJ6aFNNTSoJsdoadhKi43ckm5VqmRjP?=
 =?us-ascii?Q?jwZ0arYPXe4GlQ/cLMxHtiRqgIsIlVkQWD/tUL91gB2XZDMIuwBT5jDyQ0AF?=
 =?us-ascii?Q?mvby/6qdFq5pUN7/k9SjtiRCGfPDUITROTqMnEsXiRyoAaa9hImC+zfOsT70?=
 =?us-ascii?Q?eD55U8s/XKcMPAZqRk8Q7asjxKBJ0Y1Cu0U1JdnHxiycH3gn4nneyBZLLwa9?=
 =?us-ascii?Q?s8vqbSxn5Aw480rETdmfTDb7sop8bL8jCA6/OIcwPNnY6t2iHFfR/aKL9sLP?=
 =?us-ascii?Q?xKcGI7UNSRjYAJpqKSBMKrV+d2KwS5r4mWtyXzcdb6/7IYZFjXLnrxxEc0vw?=
 =?us-ascii?Q?HveAVdqLLsSMtTf2EyEaSBA0g5V5am5x4tXbxe8wBdxAojtb1JAghCwfA79x?=
 =?us-ascii?Q?eWJI2U4uPRpgowJapEZitX2UnVSlBvikXrfIrpRQI2XbjjXR6U4Mk5IfCj88?=
 =?us-ascii?Q?Y6cYrH9SaiU8LxA0AIBdGD8M2eGQZDNNC6JDVYNfI1EkIj5GQivxxH+rjjG8?=
 =?us-ascii?Q?ft78MoiZHfQ3Fp5F0jwem0Ixw8E/6tG+e+HrJV/P5Re/CMeuiCLbSPWNb4gY?=
 =?us-ascii?Q?e8xXhuOJigTq3u7bJUQ3bXL3+V9it8bwj2acntemutXDCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2au/wFi+DVtRXq5mHiA9sRegfSIILv5R8Psg6+8HrfYrB0+KS3ZOqE+Eo1Qg?=
 =?us-ascii?Q?Xy++ttfjF/w4K899uL6TpNZhiEF8Wc/jjK5WWiw5CXBc7B9xy0Bn9GfTBkd3?=
 =?us-ascii?Q?x0cPINBA5cmotihgOze/uO2+WayFC4kTbFKn2Bw0AYGXltbCD+jauKNwjFJZ?=
 =?us-ascii?Q?GpSWDA/FDNykzMwZ0VDdSJiRSHcxkXd8gVvf4QhN89tU7logvApiGpJzjuQ0?=
 =?us-ascii?Q?fbUn9oZ0ozd8jw97mjxmqqNBPGn5RoGfY2XESqktQOAkYrirJ5q0dcaOleqH?=
 =?us-ascii?Q?yutfW7Xn07MXYyb5dMdhpl71wzhzpHbOiXSeHOoqXsbEqPFGcE43lbiXh8s2?=
 =?us-ascii?Q?kgEcBY9SJAqH4I52zPWJa4WH8vwSglqx1D+78R3Th0+TO3zRNDvqV7gn3+ZT?=
 =?us-ascii?Q?ZGAULdWF1HkHjDN/mMwmAaqnSaHu7AfNjns+0wF/ZYS/3mkzVGW3jiayxAxJ?=
 =?us-ascii?Q?Q3dEU2CFGL28R8gbTZNQVmrFn5JzC7s+LbWHxGTc5Qt64aZZ7V3ixySeAYTR?=
 =?us-ascii?Q?hFphCxiSn+E3Pa0GwPfBoCZ3edISoiXWjWn45NIlXmI+zr1GGMgjmiUXr8zY?=
 =?us-ascii?Q?DGSbrXHTowAVeM2IiuHCSDWHQjzjYCjrE3VeSAKNIBeikMmHZXBe9mSmv/jB?=
 =?us-ascii?Q?IPRBj95yue33UPqVYxU8SrirfCD0oUrIjPgg5IjQdweo2s05JMJ3eYQPfnVN?=
 =?us-ascii?Q?bbjqI1XBgEuK6p/tGICMGQX9oI+EFfTr/SIDBtvmuL6odvf8LjoaT/S2H8sW?=
 =?us-ascii?Q?d0mYxlqcMzTNTFc7H+Ct4UsfUCPrWspKRq8638IDfiY+06SmNdU7N88TkBN9?=
 =?us-ascii?Q?AjIm9qRrRXc7X8FbGPTUPGj8NFq3vznqI1pCwM2s6JLg9w6AmZRye/tQBVGf?=
 =?us-ascii?Q?Jh1a8zqFKiyWYy92g3W4Gj1gm5hy99nffBv0+4kvsLYRIjK3Vm3UkNFxhTCW?=
 =?us-ascii?Q?MRgUWfHTQeGVQp7a1pIUT7PsHMST8armDZijJL9zIvQeZd4bqIzJYbBmP+fe?=
 =?us-ascii?Q?vcZcyHRbcrlofd/PT2ndoQvAWnWrRFth7A6fAjSKmwryPvXrjk3ksh/5fbbw?=
 =?us-ascii?Q?h9qzZdlwC/o1cPtHNREcmSgLcTfwxP9/O497+5peZkjiceTIYtp7gi/4mI4O?=
 =?us-ascii?Q?aR26q5Sgigzmq2PnuK/Pdo/iFhTrf2byIu73LbWg710dGbp6Tv170KptL109?=
 =?us-ascii?Q?V16Z1RF52tqiLYXyLd9cifpjcYnV34zvUkfgfbcQB7ztG+sOZMpOQg6rg+6T?=
 =?us-ascii?Q?CFUHJvczw3xQMjNO5KAZtUE81Yk6hxIXWdjb9F+d13+GjIbjvE9872jeR0tN?=
 =?us-ascii?Q?5pt+hmVD07k1XFw26jZ432XLQP8qFQILbaUQ8EA3N1Iy6p0e9QWOoNxzV0Yf?=
 =?us-ascii?Q?XWifkQKnOzPVfbTjQ3WVgteZTeUfZR6/8feXJwQvLVYNn4IWvLXygg46/xT9?=
 =?us-ascii?Q?v8UQv5T974b8Ro85NsJEm2fVhK001r419iGtRqii3A7kbnGG48iD/A0XlEdn?=
 =?us-ascii?Q?Ep0e0StShzVb9jdPfH8rteFhhani8U5Pbyfho5/EUOYMWiBJWJnagEaX09R8?=
 =?us-ascii?Q?AJ6r7fisnGN3F9wXXzjHdazpoRFqf6AJgRFZn8+Bx0FHC80mS55Pb3vks5bX?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nFMelajLlq4xLuMsbVpqv4LKmLm1TvM7ji03CPbPUzREZPnW/qhFHllrgafEzBkSFSwI7fBhX8axXE5bhjNg6/3dbT33NlQ2TI3o2coHszI+/xoNAYJkYu/4raqrDkZ5LXIC8yfBPQoSHiTtmWYs7cO658GmalGlL+zyOkvz+cMiyO/KYqoaLFGI4KPFCTkspA2bgXtVPE2YfqzGwetFgveJSpAWzjmhlvNxKoAWTsvs8jdJiRXeovA3XMUYSik/mrnlp5IJL5AG6RQuajwae20UhRjmCYBcWzrlcfBf+2PwcMfXerPNyrGJa3Mblgvk/4u7S4CbIv60le9vs9N6x8kFvKMgX8myutxtCkCiZa9SsPcnroGUnzy0zbB0c//unpTiitxG2oojmL84OBVU1WoDWsmN3e3HCZiIufTCVv4UUJFMx5cEwdkiP0acEOivnY4YDQFwbSMCAA3v9j4pdB/uLCWBl+AeARji1CvG0X4GBw6fbd1cqDjqAkRnxdfXmdJu0QANfqLPqHNyXZV+mPAHEXR59vZFAQKghOjJVtDF/kG/2KDgGy6p18VwaHAnhB5bp+LKGg0syOR34xC2uYF93eLwwalfmK43wI/kVXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a27eef-cc08-4cfd-01c4-08dd107b2852
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 13:38:50.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JComP01CMlfJ5RQkDu0Hw/hX9/eHktXy1R+rLPYAEvD0tS5gLZf3ShK0S0sjH4W0pRQwcsqcmLyf9VVr4dfItV9/JYQR43EyaSPe4mN8auY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_12,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290112
X-Proofpoint-GUID: YYyRdc-x2-YcJgGEd-JFOTYOWOSSpsBr
X-Proofpoint-ORIG-GUID: YYyRdc-x2-YcJgGEd-JFOTYOWOSSpsBr

On Fri, Nov 29, 2024 at 02:24:24PM +0100, David Hildenbrand wrote:
> On 29.11.24 14:19, Lorenzo Stoakes wrote:
> > On Fri, Nov 29, 2024 at 02:12:23PM +0100, David Hildenbrand wrote:
> > > On 29.11.24 14:02, Lorenzo Stoakes wrote:
> > > > On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
> > > > > On 29.11.24 13:55, Lorenzo Stoakes wrote:
> > > > > > On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
> > > > > > > On 29.11.24 13:26, Peter Zijlstra wrote:
> > > > > > > > On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
> > > > > > > >
> > > > > > > > > Well, I think we simply will want vm_insert_pages_prot() that stops treating
> > > > > > > > > these things like folios :) . *likely*  we'd want a distinct memdesc/type.
> > > > > > > > >
> > > > > > > > > We could start that work right now by making some user (iouring,
> > > > > > > > > ring_buffer) set a new page->_type, and checking that in
> > > > > > > > > vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
> > > > > > > > > and the mapcount.
> > > > > > > > >
> > > > > > > > > Because then, we can just make all the relevant drivers set the type, refuse
> > > > > > > > > in vm_insert_pages_prot() anything that doesn't have the type set, and
> > > > > > > > > refuse in vm_normal_page() any pages with this memdesc.
> > > > > > > > >
> > > > > > > > > Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
> > > > > > > > > these things will stop working, I hope that is not a problem.
> > > > > > > >
> > > > > > > > Well... perf-tool likes to call write() upon these pages in order to
> > > > > > > > write out the data from the mmap() into a file.
> > > > > >
> > > > > > I'm confused about what you mean, write() using the fd should work fine, how
> > > > > > would they interact with the mmap? I mean be making a silly mistake here
> > > > >
> > > > > write() to file from the mmap()'ed address range to *some* file.
> > > > >
> > > >
> > > > Yeah sorry my brain melted down briefly, for some reason was thinking of read()
> > > > writing into the buffer...
> > > >
> > > > > This will GUP the pages you inserted.
> > > > >
> > > > > GUP does not work on PFNMAP.
> > > >
> > > > Well it _does_ if struct page **pages is set to NULL :)
> > >
> > > Hm? :)
> > >
> > > check_vma_flags() unconditionally refuses VM_PFNMAP.
> >
> > Ha, funny with my name all over git blame there... ok yup missed this, the
> > vm_normal_page() == NULL stuff must but for mixed map (and those other weird
> > cases I think you can get0...
> >
> > Well good. Where is write() invoking GUP? I'm kind of surprised it's not just
> > using uaccess?
> >
> > One thing to note is I did run all the perf tests with no issues whatsoever. You
> > would _think_ this would have come up...
> >
> > I'm editing some test code to explicitly write() from the buffer anyway to see.

I just tested it and write() works fine, it uses uaccess afaict as part of the
lib/iov_iter.c code:

generic_perform_write()
-> copy_folio_from_iter_atomic()
-> copy_page_from_iter_atomic()
-> __copy_from_iter()
-> copy_from_user_iter()
-> raw_copy_from_user()
-> copy_user_generic()
-> [uaccess asm]

> >
> > If we can't do pfnmap, and we definitely can't do mixedmap (because it's
> > basically entirely equivalent in every way to just faulting in the pages as
> > before and requires the same hacks) then I will have to go back to the drawing
> > board or somehow change the faulting code.
> >
> > This really sucks.
> >
> > I'm not quite sure I even understand why we don't allow GUP used _just for
> > pinning_ on VM_PFNMAP when it is -in effect- already pinned on assumption
> > whatever mapped it will maintain the lifetime.
> >
> > What a mess...
>
> Because VM_PFNMAP is dangerous as hell. To get a feeling for that (and also why I
> raised my refcounting comment earlier) just read recent:
>
> commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Sep 11 17:11:23 2024 -0700
>
>     mm: avoid leaving partial pfn mappings around in error case
>     As Jann points out, PFN mappings are special, because unlike normal
>     memory mappings, there is no lifetime information associated with the
>     mapping - it is just a raw mapping of PFNs with no reference counting of
>     a 'struct page'.
>

I'm _very_ aware of this, having worked extensively on things around this kind
of issue recently (was a little bit involved with the above one too :), and
explicitly zap on error in this patch to ensure we leave no broken code paths.

I agree it's horrible, but we need to have a way of mapping this memory without
having to 'trick' the faulting mechanism to behave correctly.

At least in perf's case, we're safe, because we ref count in open/close of VMA's.

This is a special case due to the R/W, R/O thing.

In reference to that - you said in another email about mapping one part as a
separate R/W VMA and another as a separate R/O VMA, problem is all of the perf
code is set up with its own reference counting mechanism and it's not allowed to
split/merge etc., so we'd have to totally rework all of that to make that work
and correctly refcount things.

It'd be a big task. I don't think that's a reasonable thing to put effort into
at this time...

Also who knows if there's somebody, somewhere who _relies_ somehow on this being
a single mapping...

>
> GUP relies on the refcount. In a PFNMAP you don't have any way to make sure the
> driver won't go down, free the page, to have it used by someone else while IO is still
> happening to that page.

GUP isn't required here afaict, having eliminated write() as an issue.

I mean there's definitely things we need to fix here, but I think it's out of
scope for this fix.

>
> --
> Cheers,
>
> David / dhildenb
>
