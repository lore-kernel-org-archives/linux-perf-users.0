Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990E262D2E;
	Thu, 20 Feb 2025 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077747; cv=fail; b=hXCq6ntH63NN/21B3bzHbDVmEmHioP1psyTG/QATJevZ4ywzXzRy7j/NmuIq/YZTvEiORf+iXdLH8/o9xVC+rmuYkbwScOUhQeippddphE+wT8j6C0WMmTXlQkvD6gLRQVRReSrCVAd8+SGkePiomjT6v8xI6WGGRdHn9yJ+F+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077747; c=relaxed/simple;
	bh=UMVjE4pSuCTVl22qA+zwJq8sI5oyXnQzpYh9IHXKnio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fq+uqFhsV9Ct4/1uoIRpQENkYGFLgRhmulSh8GvYIQn9YMeNjzxxXi1orp/5aPjVbR6tTjAyBT/Eymr5k9xa8O/kZk0ikNWIkNR98Z35wyhO85i3hpfF3MUExLsjwh3QIQ+8fo8W0vo7q8eU3TGH02zmOTnh27s0RLncflZnT+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WvLfbHCG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l5n6SyBJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WvLfbHCG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l5n6SyBJ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMb8o027057;
	Thu, 20 Feb 2025 18:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pEa1dw5MDETTosTwvhNK4x+tyZH7/LIkglqdzqtQSOA=; b=
	WvLfbHCGDE1bBNOQ4WYSNiyrV1E/xJ7SjMl3WRClKBmtl5FlQFOtJKIf2yJ20zm4
	JLKzDGnKBA/0MHvU5OzVgATpxP+j93kU+VkISs99WPMcd0+DC7heA7vecLEGhtt+
	6tdFn5Rh8hk0rI5H/t87uUtEjy1+3jGIQyGJ7ii3rqOS7yx6zeVShPCiLTB/o6X2
	LylJd71QdzcWb3ZOMszDjPeFmk+K9xGrEij+h68FDuqYPS0bQdcY3LHgMznXTBAo
	1DXQGJlRIV+KrEROGHmYUEle1djYq0rg5iv6DWrv0EEj3+bw1IvZBvJl6TjPKtAV
	b3vIa4Reay7+LWaW4xfJ2Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pvt83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KHWBdQ026518;
	Thu, 20 Feb 2025 18:55:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0squm42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY/nzJ2GGvxqtBlbRMXzXVP837j7L0I/9Kdx3ZwxhFj0pjGfxOWovt3pyvnyNB9240ar/oJI368sOijI9IA4TMklQ6XU9z1uiCvK/mEvhqKdtkyqjmEFfGUVqfmpfLNllGA5V3mVuYEeL+nL9kG+c9Ffekcn1MxYDeeCl26we49ZRBzXyW1GlZG3l2DFuma6Ae9m0CNkasr9xf3I00cmFPVUqhdFN74Qg6vLAc+OFaTDush8Uynj5bxiZQyiamTv2xmM9lw3BDeoljJzdvTzbLfSVQ8UGJ9QfHHLswtamDz5FVYuTWOB9zVIIXhGvjrrhNu98gHdgyv5v8X/bh5wjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEa1dw5MDETTosTwvhNK4x+tyZH7/LIkglqdzqtQSOA=;
 b=Gaiig9EebRiPKJTj2Yfz0brvpd5GhLm2+HwxxmiRnIbN4zNi/pmeiFRt+KdwsDLfjUYFNjV639SL4J8Lw2Hf7blel3H8DTiGH9Vc72M24ZfS7gSdUplYnnDkCKpx3Gt5kxM9LL944r0ZEdh4vB7WVFuK1W2y/r21tNADje2uqNrEK8+cYkBsiLZyPaJeAQlth8mpU4oEpL1HF9OaZ+sDrSpF+tqnFq4aUIT84UWTovLRYHYtueut6wBt9L5z8Xmh6T8KFe0WPZpx/9abFx4VRlVGLS/xSfkWoxtk5/CbmHQ/nFuSJ8hpUUD2rMbIyK3d0Y+A3E6hajdyfIaJ7LhL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEa1dw5MDETTosTwvhNK4x+tyZH7/LIkglqdzqtQSOA=;
 b=l5n6SyBJLSRXHddrfbKrXhwUp86kbBcN3Nnk5HYeBaPyBvVjIFlZ1kcTXbvSQePrQbdrMw/lzU+V+bLGLvP4wTPluOq6qfColzvnwLVaVYezDWVEHSPKrxIQxGvIi8Lxw/h7ZWZ9OMDw1EvNUHyu2Pk4dGZL8wkSaCtPhThIr4g=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 18:55:28 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 18:55:27 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/3] tools: perf: add dummy functions for !HAVE_LZMA_SUPPORT
Date: Thu, 20 Feb 2025 10:55:09 -0800
Message-ID: <20250220185512.3357820-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:408:e3::21) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 30872d89-a6f4-4a07-ec9c-08dd51e023ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9lT4CbsokQnXO+kCXoLDLrLGHeBjBlxFBGcwLhTRoXHDDW5nFXZ2kmEeLAS/?=
 =?us-ascii?Q?RTQPLxX9+TFE9l1KjMlvucHYQw/ifpnGyFP9FXEYfqToAgHSbHRYYUTTNj74?=
 =?us-ascii?Q?9CBI46hBEAFUL04AddDHky7QdbJDE1pCBTd3eKJW2z9hU7RC9gDsiBeLjRP/?=
 =?us-ascii?Q?IXhKvFT+ZP6cWhxWU+OAQrL0ckAxUPm7bJt6S56HpUgMsahcwoReiY57NzhX?=
 =?us-ascii?Q?NOjtoh7cT5fGOrU3XwZ3Qp4QV25E6dQiX7X1NYb9saaDu0BZbOGIA+b3g7EB?=
 =?us-ascii?Q?//kzbYx4/DQCJWWiAEaxOnZiUOwYDJ2p9FuPN1nblxFci+jftBHrTou7I/i7?=
 =?us-ascii?Q?KiLRDcoPv3HSHMwrnegIjHmxp3ZbYPdEXvVZ73m5KZ1B93pVdMdBaotvYxYj?=
 =?us-ascii?Q?+AcGI8f1NlR1F+HV6q+xJ3QtPtFrbzjrIfbUPjbnE63mYmob1F/XICxCQkvv?=
 =?us-ascii?Q?Ah8KpJ13T6z61vDUH6KurgSCvwRO9ZSwp9wCOksQhsV4bxPKS2H4ODolmgER?=
 =?us-ascii?Q?T55aKyLJknYeuA/TJDo6eZyxMh7dKzIksZRROlibPqbnZUHU8PK0H7XhQNqN?=
 =?us-ascii?Q?ps3yN5AwGhWZqImLYFVKqLc4L1rNM/O4Js2CYgUZdcw0vj48diV7NSgcYeKI?=
 =?us-ascii?Q?Zqe6GDigZqEUtf8SUpNdcs5UyYccXJc9sdRsCXxKlbDD7+uVdhdZjX2eSYgY?=
 =?us-ascii?Q?977hHaqMmSRjT9sJ/kLeNskGzUu4BHc2sd09xfdDYAXa4nohfHGM51xOqy8F?=
 =?us-ascii?Q?BiFpbSHKmOtbbG3lfTECIjb7vGsLw9/JxvZHo8Qd+2hFAYNjdYwjTfvhitBq?=
 =?us-ascii?Q?s/htHXs5jcguk8mjDAB3lWfwv1vv06873A5fUdS3y8AwiVQ1rLjZUVOgMJn1?=
 =?us-ascii?Q?pr2VnbrCPuzw/jkrEjmPAcEDQy+NJ6BZtBfAzcIorDr4jVAhL4GKa3lqTZBR?=
 =?us-ascii?Q?nB8CTB4BAaNTSkzWh3PfGkRpamMuCrc7fkkZJY/i1+VeA66W4Z0g5HYIjzNH?=
 =?us-ascii?Q?JSkrO9nEGHR3sv4DtzHXRTSbIyT8QQ7sBc6Hom5utDwX0dO+8unHvCJYIg53?=
 =?us-ascii?Q?1BD0vQIP5Mzy75tF9uYcYWh96BgYGj/vzODAEhatxr3TE7r+WWfy64aSWTZS?=
 =?us-ascii?Q?OLx8JVaHBA4OsWtZZRgeAONziazk1MCe5UOY85yAGoICDXTNUGEJtMg/tsC2?=
 =?us-ascii?Q?ZFgcNZqMuihMD6nBEqFUgSMVaVs+q9odiDGzl0mThgTSuGB9wAmI234n0GWW?=
 =?us-ascii?Q?6lXdtu7PBPAjC2ydg0XgoMvlOldfcoBqkrt71N40xcr44klDe4BffIpdasyW?=
 =?us-ascii?Q?ll6lrp4tF28haUxb5LGAN+t1SK+y7wqmMWL9gHJRNy4Z6VRTLk39YtPb4JFE?=
 =?us-ascii?Q?Xm4JG1lU8RNd75mqpaZKTiRSLGZd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKgzM1qf3Jv3dyfCQ9USBmoR1jARMD4n02DXLPu3awuGFqvuCkRsO27t39wo?=
 =?us-ascii?Q?yLO4XMAPX9eG6fNvDC71vNZvSnd/VC1JkVB0oWlIJ9Vvh8333e9ujOnJYmor?=
 =?us-ascii?Q?qCu0y1p3hdCbVJdk8NlqK3dr+CDxhCNehOLoCNdUPyiQmednHqdlwnBjOd4s?=
 =?us-ascii?Q?/imb+AH+/TeRMy9hiQbV7VVAFwbWnGfqmyZD3OOEnZl6qqgrxYqUVk+8G0J/?=
 =?us-ascii?Q?xP3RfgBcw9yPrpDx9CZbl3rRhSHWoMo1PMEZ/bJWtcgq2ycjvQUBtQ153fMK?=
 =?us-ascii?Q?m3NnqewcqPL0pmQsWtQQUDJqcM82UydmiGZ4ib7jLYjDRIzmL0hypG/1phsx?=
 =?us-ascii?Q?hPeyFUj4NiqwC+obtYZ6XehvD0ZZTpfiAHatbdnyX12S5CoaHZ/y8xIJveKt?=
 =?us-ascii?Q?j8+uqwD9gpkOQepSvd27sMNYyZ9ZK9l9UEWGjWaT8CISE5i9jhDewzvM+oQ5?=
 =?us-ascii?Q?j+5XzkuQJTUDmKxKqE+bT7N3+cc/HOSjkf9yj+qHTcd/bdYVpdV1e2DAXoLT?=
 =?us-ascii?Q?X2Xj6W5UoBC5QMIQsuwUR15mqlAbMRgdfijEN7zr0TfCMcS1M2lT90xg/nMz?=
 =?us-ascii?Q?I6jExAUVB4bCqhKKeEUJJQzq2hlo7vD9gm2D3NJ0KmkZ6TXCcmnbntjTfyBp?=
 =?us-ascii?Q?1wCL/EFNadfDVTkLs+4hIY8f/vbMPh1TVjuGuTrLoQUouXCIeNHZtwzq/2pY?=
 =?us-ascii?Q?GChHEwSmVz3ub3J05MZ4X4wGN0mNOpArmrcxPgRvo6SuF8agsxx650HKW8la?=
 =?us-ascii?Q?lAx9OQXLcGqtrW4ADzrKLPJ+EyE2oLAkcjcKPWu0EXpUGMGqAmbmtBegWMWp?=
 =?us-ascii?Q?uIbND4i0NuSfiUpiVL/LJ2Ikbq2CTtHuz14vDSyGQIgL9jaKx2QenA1PsIJS?=
 =?us-ascii?Q?YYHomO5Fxq5wjfrfsleOKPFfEpEaDkVgo/s4/JUtH6m9OoS4zbd7c2VE0xvO?=
 =?us-ascii?Q?nyBo/mFivJhL0PC2+3XRJKi3aN0h6VGBTGolleFa+H2JQevwB6iUaiKsk9B2?=
 =?us-ascii?Q?VPAxoJh9UZpaKVNhs+M1CRLLL4TF+0fY2ZZz0HcN5HKsn4Ztd71ztF7W13tO?=
 =?us-ascii?Q?jDvqNwYAcWpNirvALgpux4QWLOdD1hAVXjjf4aBL9xiTFH/BM3DOoaW/uJ/c?=
 =?us-ascii?Q?WAccmMmbmxsXeLWFAGRnsp0tA7T0bY2basKDzhllNnbL4Zcx7QkKyZwsMuA4?=
 =?us-ascii?Q?V1i9t5AGYeEMUNivauW8XGXoIdS0XRjHHuBAjv+ya+PYwe4+LQZGTFeaQGSR?=
 =?us-ascii?Q?j6e7ryTKMBzsyTsKCLCT/9NyYpCnWBt7btcXxrsi56dkREkHV1mDaIPZurXP?=
 =?us-ascii?Q?F4ZGpEnK3+GD/YPMa5NdzatAWfm5sMm/UswpwX2w7ZKQV7kRbsn+oS6BxSVJ?=
 =?us-ascii?Q?yBI2CenqP56IIqzvj2mTbrIX28bg258Aj4/6nygeI82qDvEh46ruhYnxgcPm?=
 =?us-ascii?Q?syW+8C9X7KdNy4g9tBBtUemytB9xiVZneCDlNZjTpsmQTWdX5p9t2XGnrrdI?=
 =?us-ascii?Q?KSUeZ4Xh1D+DpmdIWUH9e/1rkb2yplk/CCFCoeexo4CkJ65UqYgJnhrYCdO/?=
 =?us-ascii?Q?eXm3xQaI6SDB3Vkzlt/6gfintLelP638idLc7z9ydLZ4OysWQ69mtvvz7mm4?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GHKpfGbFo99/Ee73lGCTHNmH/iX4YC82tg1Jmyq8wfyr/9SkPXb1Q2D3W/5LREbhhsAbH/RIK9Y+VItg+CYQcM3Jkqx5h2OjbP7tcc7vC30g0FjZtvxuku4Jb0q2OO2NhgKa0XHtcef4V43mCFQoPyTymyZhU6LnJY95X7sKv9xMYKlE/Ha8FuFv/irDyVwvLNAo0nsC0lXb+JUSY+cTQwOB59cOMG+CMFlhzbNtugf8u9qixnltx3BmDIuuKRhPmtATIR68WKzsNFsxfm/SV+KUN+oJL6uXA7s2wB53OO1c5y8dBrfvUnYXdMB5w/e9zxIIiP9616VrrNh1FGQ7zbwpoO7TCDgmBK8SwPmz3vBhRY2iCbY4eN5FjuUAmQm/Au4c9PzrcFCkePqAkn5lpiZcrKxUvE1C+pcCrJ0zJGJ/5Ss2ldFkW342bji7h8I1LqQq1ozCWujEP7d9xQjNtEqccN27qjd+7xxsrigMb8Xq9yPagM5yNC8TycaGFVWbqjKbq+9/Xx2erSkVybOyQvfkNAYB7cQU6dTwmBTnehn+nnUHOhOATlAijygC3FMmE/el1IWlQuUmnjxas8hx8Qtzd2vG7XtbWSG6ULqDx/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30872d89-a6f4-4a07-ec9c-08dd51e023ea
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:55:27.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKHQSpJu/WflIjUZQ4IhEONuNbX21uIEPDbFqbI4lw+cu+X70v9DXYtcjNHjJ2461/LQNfI+1CJYDbtRK0YxnLMKVAEw9g4mn2/EW4lfcgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200130
X-Proofpoint-ORIG-GUID: IvFwrCK_DOzeLy8h16vCaVrsTOBgk2kX
X-Proofpoint-GUID: IvFwrCK_DOzeLy8h16vCaVrsTOBgk2kX

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

