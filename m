Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302C22E418;
	Tue, 10 Dec 2024 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864400; cv=fail; b=QTB5ecb1HP16FU/i3aanHKJhxMKlr7m3xNcUlRp4ko1G1vt4f8tL9p2FaRll/Bnyz0MWYvzALbVE3z3yUteT6sMMzLFu9pireQ8kdU/JmBTLeBYQBmQJzmXypaH+KjIS5ccbY8YeUZee7QHlcI1exqCtB1rnFDMN/LTLiaScnco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864400; c=relaxed/simple;
	bh=Btfjr3fc7oCzzRzcXIDPKt/AhmShD0NJsk8HFh5ORkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hl56fGFXsNH6wILpMzcawnUzKLukxmR6CBNrY3p1dn7TubGSz5mE5QiRkqrg2gZxZq0Q70IKvHoxMnMkAfFNOUixRsamMKCsF8HpNZ9+tL4jKVSlrnK5+bgq34AQTOCYOOnHcwjhI/HPX1PYGCNvSdctW3AOf16ZX1sov73Dvm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W1cV0s8G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ntgjbx1Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W1cV0s8G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ntgjbx1Q"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAJJM8T000751;
	Tue, 10 Dec 2024 20:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Btfjr3fc7oCzzRzcXI
	DPKt/AhmShD0NJsk8HFh5ORkE=; b=W1cV0s8G3RK5btlVZ2V1gJ7M9qfHVX22P7
	7oOVVPLt+Zlc3FO8rSRm1f5YQbZvxy7KeN9SOGecFnMfl+5ENN1ZHLUteWazC8g1
	iBulfrj19GnwSgbMZxOhONKh9sltdOCU5SjLO+u0t/mojO7PBP5lhqDN8L/nFiAI
	JHRYMMgCWKbRx71fr1GzwufC4P/ECxyZKjO/oTHp9IQJrsla27f53oSx+zme8NU3
	aqFHvTMbN9mWdrmOyL9M/0VBu0WBxffkGHZg3u0ThlfNNxjS2Dd0YU9Jm5DcY0yu
	ngBoyPR3uJU5poMnA9qX//CBP9ok4zVbDN/AQUiVDKDvsvBfG5Yw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s43dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 20:59:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAKQ2ch020567;
	Tue, 10 Dec 2024 20:59:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8usd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 20:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXmIQNc+hKG3b6NGcNMflTfnaIu7zoRZY/DGk7ZRofyJ+caNx4YuYSIPR8Jcci8Mw9UmMadI5gpsKAS3IwJrcU4UNE2JfFcbK2XaDES1HdhU5o807/5peJ/UtGPyQpJMGiKKXS6K89gOUunxoghJg9cHAtDbBAvxTIAklEte6OLgdLlTTrlvQHPAwTlqJP7a4P+a1DftLL/IqJ/EcUw8ifqJT5eN9KMCd5Jgk3Vkci+UQwsoZUmJ4UYjNTA2Mb4O6DAHu3vmU1F1UFSDzNuNKDLkAN33T+cuyL8YZpv7Ks8WvvhaZqXuQoXVo7uhA05VAVx4Rh6lvcQ9L06X09usVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Btfjr3fc7oCzzRzcXIDPKt/AhmShD0NJsk8HFh5ORkE=;
 b=XgxTyEmNIwODueoBJDtCJSBYAXom8CdzZrtuRmiPXrx/hwsufDC3UOD4UTcyNDyPHlMpcsAUAwgFcQdQ5KEy7TlELMG1By2ksM3iAizgIlaMlyLtB6HD3npm58oi+x3OCz9Wuh7wv+gWxO5BNYaXXqnUy6wNB6HrJhqmFBxY7OZiirI4PF5J57391zAlpfaBxysTJNo3iu/IKTVpPSH+0d5PxVp+HxRu9J6PTLXcOq5Y+tUnlrbwI/0ipXQ2lf1Itvr8nAoQ6+XBPXuzUkQxl3z1gAt/c6phScuORqDj69wrsAvFfxHfzWXvGA/LTTHdOSjYsvXM1w9msX3mNxN8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Btfjr3fc7oCzzRzcXIDPKt/AhmShD0NJsk8HFh5ORkE=;
 b=ntgjbx1QEfjwAOdQTBuFbCbbC5+SjXr4IsLlQmxXva9qh4X9Hr6XmuQx4zOMBmNiiGm4QU79h2y0QkmkzY7DYqnhkU793eLy8j9D/kjcdjEiC+aFbb0QpqSbz+QWdOOVP+I+kSqcibaPyuoy2iGEiOMnU0gg7ObFlwOMRWj0cKQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 20:59:24 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 20:59:24 +0000
Date: Tue, 10 Dec 2024 20:59:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>,
        syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fork: avoid inappropriate uprobe access to invalid mm
Message-ID: <ec718cd8-afcf-4002-95c5-4cc610a44107@lucifer.local>
References: <20241210172412.52995-1-lorenzo.stoakes@oracle.com>
 <3bd43f87-571a-4bc6-b068-69056ec18d85@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd43f87-571a-4bc6-b068-69056ec18d85@redhat.com>
X-ClientProxiedBy: LO2P265CA0261.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::33) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 1202ac6e-16fa-4df2-f591-08dd195d869d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhIN8lrrC8MejMoGP9cNcT/1vULSbWw702TfEloGOudlF981twMZLs/sN9Fz?=
 =?us-ascii?Q?tCH2qH5sA9/AZSzHQRoie48tOVbCmd84MW3Ncw5Wq7V7cCvuBJZ9KwMywocS?=
 =?us-ascii?Q?/Jxr+qgTeVcq9UgTSTXEtJzPw3LJrFAXuoKM0h0TZtyHeNCyP+O6D/7LlZC3?=
 =?us-ascii?Q?j8V5ZINIEE/OBZqjKgmLTs++bJE0J2NQILujflKWN0oII7mEyAgP3gL2b+p/?=
 =?us-ascii?Q?dohgm2Few5wyB7kF3s8umgJgfhXZwvshLh8PsdMriTgqRP1TkafrXhoAFP0u?=
 =?us-ascii?Q?zT7GciwAmMdPmB9RFb9Jzc6TNBaahlEwVJ3HfEGjmdAExl/WeVgmAInVMEIf?=
 =?us-ascii?Q?4zIYJ9bFIjy/uDShWgEJowj1n8DEABAxwk853BQ+8QmSABLGL8Uwobnq9sZe?=
 =?us-ascii?Q?0ID+9/gd+GJteKueWVQDjKuKBoB4fuvr0MVJYLMht1LQQk/fd0O2qklirNCe?=
 =?us-ascii?Q?lSQRgShAOxmhF9vtMcTiAhhUmCqM9s1TvmPCAFe9UY08+oP0MMF2dLQfWmFU?=
 =?us-ascii?Q?z876WPi9q0xVsHKaohG5znhy16AcHqYqWbslCgF8K9L+NgWEzvt/iXKQf/lx?=
 =?us-ascii?Q?QhiBXKNdHTgZDhPx2jk+vQfCqo9Ir0l0H2er+sNxZEOG14cxENQVtOM80lJk?=
 =?us-ascii?Q?5U6OzumfLr1bSchxeCC7kNPKch0ZZWsLdVHuPxp7viqy+8Er4UnbBzt9YqAn?=
 =?us-ascii?Q?+FPZq2GUvg07VOwyYaGC3Jqcc3yKfdzjbBSfm3+0lP9oGHW0sxXzu6BrYMq3?=
 =?us-ascii?Q?VHaJYLN/Xz47ZrqBb64dZ6seXQbWRrbhdtbkQmVj7fSV8yPE3xpp5jAavJb3?=
 =?us-ascii?Q?UpfQt9Z1+LsOtoNXoiJrzCwL235e+V6qlGDlMdY85ccFT4WEzEMjNLVEjZQ8?=
 =?us-ascii?Q?bWSYqeRRfOGvsVSo6V3yY5jOB7rJvnVi/QVF34hxn8kOhHXCC3icfi9FqFG7?=
 =?us-ascii?Q?wvXWHtLrAkxl+IJbkU9zSwzDqz8fJIuP8x1ExvnLHwC9WsQl6fk75cLnLccM?=
 =?us-ascii?Q?KaWMzqqMMapBdYKkGl/NUZsSSS7OGTqt2G0ohHlrgciVOvrRtw+uzPnCl9/+?=
 =?us-ascii?Q?yI9dADJsHCrmGrjsaYcn0Ku3ZGeMzbyVJheQZ5nJBZTpR3a9VgDnLag9lv5q?=
 =?us-ascii?Q?3rwIkD5hna0mmgc7hgtJV/5ORNWt1WgLirRZABpS86D9daoF8t141ZE868Sk?=
 =?us-ascii?Q?hOR7kHUxrVZBI7qjURwWvJ7UAH9gLqmLZB+A9Ol9MZZ/s50FmBkYVZwghLVj?=
 =?us-ascii?Q?RSvjGgp1R8B4z3p6DjBOusbo5LouTfnTJru/WklBDApJtoQndNOjvSM1/plf?=
 =?us-ascii?Q?xoPGQAXmV4A2pZESlMhiTr1ghELxVhnap+GJstmfGD0cFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sgiw0ZklT3mKwRr0YdWTsT137R8lI++HLXeya9djuVH3wmH8KGQo5+t1OBfM?=
 =?us-ascii?Q?o8CccIHiRcrq5AmOiZplVT6bE43pErCBx1SgWnad3oQAdEPJRa6Y8jjIg3OG?=
 =?us-ascii?Q?m4c8DhhfXsfKXlUCGLmnUttJnjooMIrvdeiMdZCECAkeBwr7VxRU0B8sWAf7?=
 =?us-ascii?Q?GlT26XFLv93tJDUhelNX+0CvMSmmHzd8IZKHO55qeWuohdjV90LQdX/qIf5y?=
 =?us-ascii?Q?y6G7gp5hl7sh8Ut32q1wCiG64bMG20E95mjz+doCf2ZcXfua02LrDZgfbB/N?=
 =?us-ascii?Q?I1HUztmNGCTB8WbQEcjasuCZ2pUdggQUMbc5PKhWI4M1wZn0Hm2CYdlMgskt?=
 =?us-ascii?Q?RfLGZ0+UyxX6LaY/K8sJDiu9N0yp3I6Kalcr6UYPMZH0Gf8Zc6PrJCJVA5rU?=
 =?us-ascii?Q?rgDq2XEdh7IBrxXio3f9reR1Z/zJN0eyTLG5RO7d2n3fYFOiQ0me5xh6Y/T4?=
 =?us-ascii?Q?l1AJORIqcgVCu5KeTN2D+vxLOnporctV/U9aoTLNdDTLCtGBX6iWIFUfUP8F?=
 =?us-ascii?Q?Tpq3iz6rHint0cvdtoZVnIHszR83X1bjTBUxz/MHU8+gjB44axJxwCNt9+jO?=
 =?us-ascii?Q?e9WBqh1lAu844OY2yfP5yK6LT/YQV/GjRAggtvW7WA+u5p8OVrQGA2JJuJy8?=
 =?us-ascii?Q?EuW2v/HCVpivhNYWF0flJqUzEA0r8/KUVeiaACGFuTpU9QJS7M78r9hSBph/?=
 =?us-ascii?Q?H9YkHUc8eSDDyXtw2fVXZoMFOj9XBAWblB8AINJVLrFEPWmGeIf/ykR+EXJe?=
 =?us-ascii?Q?/vFBBWUv7Iu7ru9T/blEzsO9gkNfHPR23VWooIA0lb8+FEKt8YTWdb0e90PJ?=
 =?us-ascii?Q?PsiEFsFNZlC5f2K2UoOeictpyjpLLihjb6pIgRvs7eJ4HIEtuRLVAP0r6x/7?=
 =?us-ascii?Q?Kwvw9l7KUYFCGaYh0u1u9lSZlMeWSzU5vASqLInikrLlmiAjebDyixuO2R9d?=
 =?us-ascii?Q?90aMJgTH2rvphbFDp0dnkGDnSwkkaPCglh+uPVXhZNJSvP4xFz4FCQhME3OA?=
 =?us-ascii?Q?O9h1p/LAp2Aeu6BeoZio8/0GzCSIJfZV7P/3sPzxFmkHvuezGEnPCBtWSy1u?=
 =?us-ascii?Q?bkC6XEgkLNzkboD4hjVtLDCOkHdzTEMxUL5AW8LCxhhKtrMSosWDEUJO/Wk3?=
 =?us-ascii?Q?Bh9VZ0uBkc3ep+3TaA6T7QL+5guMLwLWbGNGiB7wDr3DjgH0uUw+ug16PsMW?=
 =?us-ascii?Q?U2DqbfbG4G9TCD3vjqnCPd/LuPZbKsVwI4LGHmy7p735KoyBotvmAbQQN0vQ?=
 =?us-ascii?Q?j+HLowRZJjY724dFeUHoB6IEtkJLD/a5eprEN1y7mq0XAnBdeS1FD2cp6Pts?=
 =?us-ascii?Q?8RcX/2z03boqAiDNWvuvpL/W73zhId1aHKqF4rSiUSiaCqyNaJTWZzd//Mra?=
 =?us-ascii?Q?XCkSTNPdoPhVYbyp5P7CN9FfSX3TNfqHTeoeo17Vh+f5Au27UHkviI1Ly7b7?=
 =?us-ascii?Q?FFW69+fKVitZGJlvHl7fsRJqh1UAleUQgvZ+XBDFZXED1uKyjnaG0s13qMLo?=
 =?us-ascii?Q?TGGbe92yq4pBPfHUA6fbLUDllnu33ij5unUNSXnFZrUBIuYVmwgathD68YK1?=
 =?us-ascii?Q?+sD3aC41CibW+dltiSHqdAP7BvQGhtFt31kkSG7EK8F4MYCCeQNjlT82vrdo?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yH6dRg/KVPl9HwqtVa3yT+l3DYGBgmfnfO/VdLduIWwk12myx06ZKa0TkPGalq15szsBmbeP7BK02fdFTwtgnhBTQIEkUFxP/Mcwh2N3HVx3vmm+SnoOX6E3n7x8KR0JjL+0gx7Ss7WpEarrWD8rRMzmyYtq8qfDkY4f2cyEYvgC/1sWirVCXDyR9SiguD56S1Uu1oqUm2GZ/r9m8mgZI/6venm7g3k0gD5arsEuZRrqDifWyAwGE9V7UgzuZ8vyHI6ohZly6MpSM/MfbtQQSCvTyfMvbyQFeBGLY395wFPy5jYIEWuEvmFuz9+yngHBcy560ugc3hih3eIE0TdKT5nGbcq87G/+WHtYkQ6eaSqTVsZ3HslH+Aa6w5zUh+3Hz9hXTHTT5g8dgcfHAOAYHkNveijSjLE+gyYylrItmJhzINOlvg8szMuhxXUcvKE8M7jeynL0gvPn8JRNq7s55UfJko7Y/4lwf8aa/9lYlmVCyRMSdDvx3HNr13pygISpxu31pnIdj10klJSMASGH+Y9U8Uo2oYKLdqp2uJTAwCEUJokYgyUwDa+VqEqa9bOhSqxMtbNUCXR5tjYccYrMuObdBahsFTazluvvCaeNGg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1202ac6e-16fa-4df2-f591-08dd195d869d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:59:24.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCRlMpYj0ZjKquvs/yaU9lENw0gzHRZtWv4xb877jh8rOQ/i1bCLWTUZynmNXItmEugnMMzUIsbGEGvR+sxSn7yaNXqCsHXt+LT9v8Om9/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_12,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100152
X-Proofpoint-ORIG-GUID: 6YAUnuyRZBpVFOd0DoQ59YBvIlqhZHmV
X-Proofpoint-GUID: 6YAUnuyRZBpVFOd0DoQ59YBvIlqhZHmV

On Tue, Dec 10, 2024 at 08:35:30PM +0100, David Hildenbrand wrote:
> On 10.12.24 18:24, Lorenzo Stoakes wrote:
> > If dup_mmap() encounters an issue, currently uprobe is able to access the
> > relevant mm via the reverse mapping (in build_map_info()), and if we are
> > very unlucky with a race window, observe invalid XA_ZERO_ENTRY state which
> > we establish as part of the fork error path.
> >
> > This occurs because uprobe_write_opcode() invokes anon_vma_prepare() which
> > in turn invokes find_mergeable_anon_vma() that uses a VMA iterator,
> > invoking vma_iter_load() which uses the advanced maple tree API and thus is
> > able to observe XA_ZERO_ENTRY entries added to dup_mmap() in commit
> > d24062914837 ("fork: use __mt_dup() to duplicate maple tree in
> > dup_mmap()").
> >
> > This change was made on the assumption that only process tear-down code
> > would actually observe (and make use of) these values. However this very
> > unlikely but still possible edge case with uprobes exists and unfortunately
> > does make these observable.
> >
> > The uprobe operation prevents races against the dup_mmap() operation via
> > the dup_mmap_sem semaphore, which is acquired via uprobe_start_dup_mmap()
> > and dropped via uprobe_end_dup_mmap(), and held across
> > register_for_each_vma() prior to invoking build_map_info() which does the
> > reverse mapping lookup.
> >
> > Currently these are acquired and dropped within dup_mmap(), which exposes
> > the race window prior to error handling in the invoking dup_mm() which
> > tears down the mm.
> >
> > We can avoid all this by just moving the invocation of
> > uprobe_start_dup_mmap() and uprobe_end_dup_mmap() up a level to dup_mm()
> > and only release this lock once the dup_mmap() operation succeeds or clean
> > up is done.
>
> What I understand is: we need to perform the uprobe_end_dup_mmap() after the
> mmput().

Ack yes.

>
> I assume/hope that we cannot see another mmget() before we return here. In
> that case, this LGTM.

We are dealing with a tiny time window and brief rmap availability, so it's hard
to say that's impossible. You also have to have failed to allocate really very
small amounts of memory, so we are talking lottery odds for this to even happen
in the first instance :)

I mean the syzkaller report took a year or so to hit it, and had to do
fault injection to do so.

Also it's not impossible that there are other means of accessing the mm
contianing XA_ZERO_ENTRY items through other means (I believe Liam was looking
into this).

However this patch is intended to at least eliminate the most proximate obvious
case with as simple a code change as possible.

Ideally we'd somehow mark the mm as being inaccessible somehow, but MMF_ flags
are out, and the obvious one to extend to mean this here, MMF_UNSTABLE, may
interact with oomk logic in some horrid way.

>
> --
> Cheers,
>
> David / dhildenb
>

So overall this patch is a relatively benign attempt to deal with the most
obvious issue with no apparent cost, but doesn't really rule out the need
to do more going forward...
