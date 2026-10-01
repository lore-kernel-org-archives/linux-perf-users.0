Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A743F6C3D;
	Thu,  1 Oct 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878876; cv=fail; b=peZfy9t4DGDaw8vVk4k5PW5UuTVwY1VXvEfo7SZ5HtbUPQXS81Li8eVZtpIIlFVn9MjS2Z1/xEMv3WR8Kb8Zv/27c3aNsABi89f8SochfnJKC10s0J9CFmYdJXVymNK3r5KB4Is8ZaW/kOkDJ9VIElpDMkL5DWpgFUP7asvh6yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878876; c=relaxed/simple;
	bh=OTuvctgPxy2xZ9S6Sbe9y0hi7YObhcaL1rxc57C7qyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEwoEKqxFeZN77r9W8k05JbkJhl/ZqiZWj7ooIGBWNWrNTcjoJWBsZWjuQbVGBw/VQp5qfPFHEUMn9FvjsfF26EaUEkxcz5Q/APsU1cPCQkF2nA7kRMxUSFN1g3SQDi0R2hfA+qj1+v7N1NJNZbQB7K06qbRfsh1gDvF5iCdpVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FiR0fBTo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UmgnBgdC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FiR0fBTo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UmgnBgdC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FthbR2545851;
	Thu, 1 Oct 2026 18:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=G3s1s2lBk5fXldHMfSgObYcPG29xA6hohv7+vmet+14=; b=
	FiR0fBToVWlJ4aUlLpt1f/8lxOYCgk3lxraoze2mKR74Gm9iM48bGhx4fOF22Ja3
	RQgW3Dh3oIIkjpYsY4fkJi54AchfWyNgEKwgiJdArG4xlhEDTsh/Xw4IArEkxt8y
	YeFwFrRgvwEpx2Ues9GjIS9Wi+ldwVOtiVHVM6gyFGrbKKCf0SnaXbjFJPn4MRol
	bhgLqek1eoDvgTVN2JbGu2iR1ahvmrwz3wGknVtvg9HNhXq9OMaemJ5VG7W5S5OQ
	qzojz2MjAtTm47lKmZLtWwzuTjnNEAmWDmPU2Pyk6RxOfT3WVSGezRRnTeYnapRJ
	/EdBEOId3B58/vEZQ4ZoQA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx63c1uma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 18:20:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691IKP5E008376;
	Thu, 1 Oct 2026 18:20:48 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gt4e5f-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 18:20:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWiPsgE4VYDRmoQXHv/gzh5i6Lh8/O8UP1It4qO+y3B6BlX9aF4aBB9BmnaX2ZBo79XxS70fNxGcIHrtDCbWGObumpCXmR8hJpKKlkJTYgAw7qwxM8CwnFS87xS31r0iPkw1Qj1wIzyzHT4twBHlz9fW0d+2S5YixUaTNiVwUtZ5HPEOFrJl/o1qa56aWUcMdsN6EyfL1GxiP8t6Bgndroy4g81O5coM+vvhlBOqnHKLwjZcKXyjO19ENKIs0ca1vlsfJOB1OHbFBRqWP9+UKf4MbOZSx8SsGkVLTUWOWeTA7w3XXInEDxeuyfkgf5S+73SurueY3L89GGETZs8nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3s1s2lBk5fXldHMfSgObYcPG29xA6hohv7+vmet+14=;
 b=L4hA5DJaf17zTyKwT2MTf/8G2grs+tPmL+P3eOTmn0rXaLxiOX8jF46MaUpOzOu+bDa5sLUVxZI10hlYf59n7/XZerFp7BZ7B7LevdHh8iF8IJdvVkdKT/6+9CCVGxj/ZmNk4u8XnEg4KGONJZZMBQZKHCDfz5QIJcZempBzgoB+BPCDcN2vT9DeET5ZXIbN8y5gOwv/sS3Ws51aubUM3yT1F+MYZj2WbgoOFOmE05+yr8KxPRGZeNA7PuYYgWyh2hXMXWxmEpb1iS90JXoMOEn1H2TKAsYNY/XzXAdOX/JurwnrJ8repXHRrx5JHHgdDcbZi87ZMTiOyvygfRl6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3s1s2lBk5fXldHMfSgObYcPG29xA6hohv7+vmet+14=;
 b=UmgnBgdCxApbTH7j3cgtDlCqz3CGMJzwfwKLrL2g5oBJJzjjDTWXU1Ehdi+96oprAmuojVss4CD66+9xocYZSzrytWcuKeS+jh8EJ9ZjgNEKDqcW3A1fb4GaaRHKkuRKzemotX1Jc+nj1q2iyKSoaj20XlyH5sIaMY61mewzjgc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DSVPR10MB798099.namprd10.prod.outlook.com (2603:10b6:8:381::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 18:20:14 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 18:20:14 +0000
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
Subject: [PATCH 2/2] tools: perf: flamegraph.py: fix "Error reading report header"
Date: Thu,  1 Oct 2026 11:20:01 -0700
Message-ID: <20261001182004.1160406-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
References: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:510:323::12) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DSVPR10MB798099:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e7667e-b06e-46ba-8003-08df1fe8a352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	GKdprkREDP3p7jjtjWgwjUB6Gp0eDxOIBwbTMCSRrdWMarNbLFAHha+KD/zKVCRJvG2b/Lf7TDWdIoqCU5trc2Th1NsNcGnbX3947ARqyxbkS/tEqTrsn8v5zw8Cb3NexUCfcGOayNwlN32wvk0VSslzbC6xoA//Kxz0UgfnKTBGJX8wDVrNoDg5+2t9CeMHdOA5IGJOZiQDtO2w53/UnUUk+SAdYraaF+Od9WI2Je3Ao+n/ZzzgYsgDgBnqhGnTEnv9leVprUb7KNAo+LEbAxLPuvvD7KScmVIcQYv0op1vLAWCsiZfT/LliA76QSGzhSgpqDQ+259A79T1371fD7IVC3j4MkK9BbB0jUN30VObF7YNn/Hk1+sCz3nA3N4PBVZoeG4/tyBIprtgVRPZ07xNQ66osba4/f1MQSmV9qfHfA8UxnljUkD1fhZbl7fzAMf5CuALyU9OpeXVE3mj10fd6X9T8E9kqTIdY5+PqTSuMeNz3wp3/LfIrDAMV9TYtKFoZS8xGZxDScJ4jRNo5fylTcnSm+4V6InZlkWeV66RhRSbzBrY9QJBnMDyB58bWPUS5+PCfK8D9/ypJcuIfWQEiRHwjR/M9Tl9MniV0UEgFH78OtE7KnX8XIdz3edf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hcz9dw2yF7n2vG048lhmFp9AnmIM730HrGRW86G6M020QrsK+7uvYIYQC0Jq?=
 =?us-ascii?Q?00naoPcgLxQBl2fnR0446/62Ac3s1yqjw+rywlxTf+kfOIVbOrdUaxHfu6wv?=
 =?us-ascii?Q?E/LQqJwZ4I6QAP/jeuv4Owubqxt1FJ/VxmiOs/yetSUfyhlqAt0nNWkR2mjo?=
 =?us-ascii?Q?Zh3KoW0E1gV5PMO8eakLtltU9ZLokKAIHfCI7JRNMbp/Bi/zLFeKp7Fckahx?=
 =?us-ascii?Q?ibW2GEbcKGI7+WJtoewIdIkLINSbw3FSCKD/51MyC/lXE/zv2U+FD6jWIWql?=
 =?us-ascii?Q?o/l7EhfKozCd4ZW6J8Cawpd0pwA3QyAfgnhYGQmQ5tIPJrWWYXp/u39mZ8vm?=
 =?us-ascii?Q?jQPccULYG03Nqcwb7Sb4vAErulA0zRtsR4LO+eKKbHzgPuZ6W57H+Na/MBqw?=
 =?us-ascii?Q?H6+jD6UYyqVhNoVVav4ZCBIUikeKr7NeqLUR14/YJo0QlAxle90/a+TzVhKG?=
 =?us-ascii?Q?PFIibZSFcVd6ouprScyy0v9FYLbUWmQvmvaL1xKw/6aj4Vn8WziPuBDIf6ow?=
 =?us-ascii?Q?byuS8moJV0fzA8T+gMxzq0mg5vnZxVWuOo8RhIWQsFxGFagDlfxBvi1gNjm9?=
 =?us-ascii?Q?jfCKH1Ky1613eXyE0vvFnTuaxsxAyIfKRBi+aAjmVcUp84IBAhyOxE3ese5O?=
 =?us-ascii?Q?jEpSZL6CKJcBFJlDBA3rPt4tqr6bbHBnDx5bqEl/G5BfvbHnVldvRkzT6WkR?=
 =?us-ascii?Q?Kn+L8GD8nrLBQjEnsHgd1zdSlIOui1WzAgN31wdz6H8DxxAvUp3ne+lUbOnb?=
 =?us-ascii?Q?Q2+qapy6p0/8R32vSvO0aY7A1DJQExluFT/8K9ccbAA+vy05pv0JA6Pa5ROs?=
 =?us-ascii?Q?ijiIRbPnU1WeVmA5bXoK81+V2DEUAtJv/dNBRiMRY92tH39FFOzkQuPhRS7O?=
 =?us-ascii?Q?q1mWhdJEldcxVvPJGc30qeper7hTeng4/+Oul67XVAulAFyKshMmmYs/wcCs?=
 =?us-ascii?Q?gE9hMvbYFgvADUPGF0fZVUvXaE1d1pjf1BXAQM+1nVtXo/p4gDa5N+sruYLM?=
 =?us-ascii?Q?GO/eUI5q6o+Deb7IOgJa3RvgHhbf+KUmjmMFH4AaCrg7aMe3aUhADhCKWEls?=
 =?us-ascii?Q?sfOUOuKX/skQB/o5usHGPrjd8Cm5sZAjaHTFETAOTIVaI7o3wULfJbgJYYaq?=
 =?us-ascii?Q?bwkcbbC2VoM5ypa8L0o1x7COR+Kj5RR2ijlQUSS42n+V9zgzd7ekR06ZcXSD?=
 =?us-ascii?Q?75jrYMjXpehWVFIyB7HzXjYbFDs/HAC27hawDTtWVnP/ffQVKacRFn1GfXmP?=
 =?us-ascii?Q?xyDo/XlrgG39FH7iKEd6xPlN6gn43X/599D8wSOvEsIpf2vLFO3IHjAYbEV7?=
 =?us-ascii?Q?KszgkMJ7AJTTs4RYBVVDUnGBvPyVHr2/cdWpbdF22KfPxwx93GkM4RZruOf7?=
 =?us-ascii?Q?duDPvxGaLeEJzJxQrs/+yim2WXNQrZ06VO2VUfDFw1UBx2KUDmi5dc5iCdBm?=
 =?us-ascii?Q?aEAsGCXPG4rmkZVA1QuQk+LhwBW6dWQmMROLKhC7pc7ZFLbYVYyU06PkW7kL?=
 =?us-ascii?Q?0+xG7EsivF8Cs7rdisCPTEjA/4KJ0NUdXvTIDYmXLrxw7upNjdRZv90nz2Ta?=
 =?us-ascii?Q?HPIWp1uW67MV4+2cUnnQNMUiB8Uv7+W7zQI9IuGy4JaKS6hXppDdqMfdhJzF?=
 =?us-ascii?Q?OsnpF66i4joCqx0V6auTiP/O6DpysFWTbe+Cd6fbtkGMH4jpcnTQ7ajwl8yR?=
 =?us-ascii?Q?h7bObvlRG5XLGH5i/cB5OPdiH58btFHGMXqhfsiRgvnNzNknbMdqGLv5Z3qP?=
 =?us-ascii?Q?CpquzYzTefYYeZebij50F1k9Wm8+1ZU=3D?=
X-Exchange-RoutingPolicyChecked:
	usWvUvPgvX9EG36UtvzsqjZegGyYy0aOd4Jc3P6yDUU3pz+P8Hq1KIirLNgZNd+v7Sq4KY9vTZ6VxKX+fJ44FszIcE3XAr6ZdmLRpJLy0uP3YToyqKwph7YucYHKAwKKjbGCx300esAL6SV/vhD0s18tsNqjqiEfSXyuCu5K/Wp/zlFYPZ0S7r2awRpSJtpKmhfI1JUCBHxzRoISJEMsQg0Zmi1pgfhUOOEOs8fYcDHxlaKSLz6hHw+IruciOx8ORUpK9c5Qtvqq6OMqlf48q7QhRLtXmYevGdd8P/lq8A0fsC/AQDbAGUoV/IOmEZx33mFGqwPH5AakzsI+GJVlxA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3USS5CJlmhMyArrKEu4hGjZce5DIM5SqkoX0bo22rCGyGIkPfYQVZ6Y3Bgkj+pDbBxId51Vn5w2QJwhvsvc4B2U2qdaWtDlexySSyxBF7/bCpao6WWXx04fcfYLw10SAjFZzfc3QsFg3OQS52VcMxbSVED8q8V0ZLKn5BDBw1zHmoRND7TJ+w6gowoJS44viwFdZKr8PIwRlf1R1t+A/HhyFRnNCKHcLpwCRsR/pjocEPBpB7mAoQaV5z4aRkDg4bReiLtq/v8WcRmVuWAPLEGdzjnp0d4ETupuU7iHZ2XpLIbEdhDQjlgFIp4EchMbn0dm49aXf29d/u+O3KF15CP25iNFxPmURrgIg3+4JapYRSaJwvu0dUMleAHGGpKrJVzXol/9NZ2LuW/XL2nJh6JYBcgZLiJ34tonJRXUjm0ulwki2a4u4QQFYQiQXopvywKEVTNdF/zk+xtUEWpXg0C0en17iwvOEbLOxWUAhlsiMGGlh5VLEobvJQQZDlcnBTPIvLpFx/jRV2tgYKF9qIqiD7oUJ5TXkMyf+Aw/NxIs4C5s3VSCOPdwCxRBC91l2Os21O0Zup2GT5Rc5h/H9tCkQVQHdAJ80seehl4tw75E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e7667e-b06e-46ba-8003-08df1fe8a352
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 18:20:14.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/l9ytCFYGfYv4WDkTz4T4it0EiJVK5pfh/+UOTKBasajF0S/SGB+0dxBhXptU4gLFvugv3I7kcbHH9DilMBQ/ws4Tox/1Bk5cv/zpGUgzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB798099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010073
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfX35vZ4DO85hmS
 ytU3dueddvjtMMh52QWMPM27Ld1kGkK14kRSQWeOYffYym1TxTzS8e7w6WXgZIW/9TcoIKGkrva
 j8LfH2wC7iOvWokw1rJzxh5mM9ncH/VKBqcK/xbCLc4K5WMophUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfX0ghLwyWrr4gw
 pQnp0GivGuQ0UOeNDg/wUnujCBvJKLb9LjZeGxkKMhjs4cvby0lFIaJtQGQxYiIL9kmFWDWy0yO
 uumoaLD0l3jy2NZ++fQiZ48/E/F8P6a4e8Eb1pedVm00BjBx/sXQfduanJpG8fDpdMxzt9TfkK1
 VB4jnjBXoyU6SBIsfm8Fcw//6yUkO1djrI1fyJraEw4FxzLj4Ct4oE5rox1tzy1XgH16v1eZyrp
 I8ovVesHLt9NFehfEkS/DvvugUCP5e/F0UOL+YUtrgxdthGAv3ABDzD0HtTRNSoRdyl58xgw6ih
 4K3XE86UcxUWXpr6aQNQs/7hVNd0pUaw3j8AfTreL7BjhrrEq69OhEa3Fc5x/3wARfoTi+3Xwfl
 qwYUSwtKUw9oZQgaE7H3j5z9xu3btcfu82gqLH8zpasuuTxuxJF4zQ1WOUbCKufcKfA0LJBN+pQ
 LAmlgBMWLKTr1z2lE+8m0KSVaJvs2/tEXYO0Hx40=
X-Proofpoint-ORIG-GUID: wGVfclzqWveZCZHPQ7vhZZ6tTlxNxEml
X-Proofpoint-GUID: wGVfclzqWveZCZHPQ7vhZZ6tTlxNxEml
X-Authority-Analysis: v=2.4 cv=PPGaavqC c=1 sm=1 tr=0 ts=6abea481 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=Chh5Qc8kAAAA:8 a=yPCof4ZbAAAA:8
 a=lQGYQqnvPlNDCdc8KV0A:9 a=rLMzWEaC_ko1Fj9b:21 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107

When running "perf script flamegraph" in a directory without perf.data,
the script succeeds but prints out the following error:

    # perf script flamegraph -ag -F999 -- sleep 5
    failed to open perf.data: No such file or directory  (try 'perf record' first)
    Error reading report header: Command '['perf', 'report', '--header-only']' returned non-zero exit status 255.
    dumping data to flamegraph.html

If a "perf.data" file were present in the working directory, then the
error would not occur, but flamegraph.py would silently include an
incorrect header as the context for the flamegraph.

The issue is with the "-i" option and how it interacts with option
parsing in the flamegraph-report shell script. Below are the different
flamegraph-report script calls in recent git history:

[1]: perf script [...] -- "$@"
[2]: perf script [...] -i - -- "$@"
[3]: perf script [...] "$@"

[1] is prior to commit 23e0a63c6dd3f ("perf script: force stdin for
flamegraph in live mode"), [2] is after the same commit, and [3] is
after commit 29bab85418efd ("perf script: Fix hangup in offline
flamegraph report"). As noted in the latter commit, for the "perf script
flamegraph" invocation, the parent perf process which sets up the pipe
will set the appropriate "-i -" option when it invokes
flamegraph-report. Thus, the third form is the correct way to ensure
perf itself processes the "-i" option and thus processes the correct
input file.

As a result, for cases 1 and 2, there was an input file string passed to
flamegraph.py -- though it did not necessarily match the one that perf
was processing. For the current case (#3), the script doesn't receive an
input file string and thus assumes that "perf.data" is the input, even
when stdin is being processed.

All of this is fragile and works around what we really want: to know
what input file perf is processing. The previous commit implements a
helper for this, so drop the "-i" option entirely and use the helper to
properly detect the filename.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/scripts/python/flamegraph.py | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index ad735990c5bec..d49b96a324a6f 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -28,6 +28,8 @@ import sys
 from typing import Dict, Optional, Union
 import urllib.request
 
+from perf_trace_context import perf_input_name, perf_script_context
+
 MINIMAL_HTML = """<head>
   <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
 </head>
@@ -122,20 +124,14 @@ class FlameGraphCLI:
         node.value += 1
 
     def get_report_header(self) -> str:
-        if self.args.input == "-":
+        if self.input_file_name == "-":
             # when this script is invoked with "perf script flamegraph",
             # no perf.data is created and we cannot read the header of it
             return ""
 
         try:
-            # if the file name other than perf.data is given,
-            # we read the header of that file
-            if self.args.input:
-                output = subprocess.check_output(["perf", "report", "--header-only",
-                                                  "-i", self.args.input])
-            else:
-                output = subprocess.check_output(["perf", "report", "--header-only"])
-
+            output = subprocess.check_output(["perf", "report", "--header-only",
+                                              "-i", self.input_file_name])
             result = output.decode("utf-8")
             if self.args.event_name:
                 result += "\nFocused event: " + self.args.event_name
@@ -144,6 +140,9 @@ class FlameGraphCLI:
             print(f"Error reading report header: {err}", file=sys.stderr)
             return ""
 
+    def trace_begin(self) -> None:
+        self.input_file_name = perf_input_name(perf_script_context) or "-"
+
     def trace_end(self) -> None:
         stacks_json = json.dumps(self.stack, default=lambda x: x.to_json())
 
@@ -167,7 +166,7 @@ js-d3-flame-graph or libjs-d3-flame-graph, specify an existing flame
 graph template (--template PATH) or use another output format (--format
 FORMAT).""",
                               file=sys.stderr)
-                        if self.args.input == "-":
+                        if self.input_file_name == "-":
                             print(
 """Not attempting to download Flame Graph template as script command line
 input is disabled due to using live mode. If you want to download the
@@ -248,8 +247,6 @@ if __name__ == "__main__":
                         default="blue-green",
                         help="flame graph color scheme",
                         choices=["blue-green", "orange"])
-    parser.add_argument("-i", "--input",
-                        help=argparse.SUPPRESS)
     parser.add_argument("--allow-download",
                         default=False,
                         action="store_true",
@@ -265,3 +262,4 @@ if __name__ == "__main__":
 
     process_event = cli.process_event
     trace_end = cli.trace_end
+    trace_begin = cli.trace_begin
-- 
2.52.0

