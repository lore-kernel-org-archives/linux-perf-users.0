Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C154052AA;
	Thu,  1 Oct 2026 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878876; cv=fail; b=nRk5shR/+qATHQs3Si9rAOTXeYBU0AtmP6q2btZ5xikhLw20JYxjUIEkhjkhrH3QnyxuQCySE6zXgjFvyl5WFwK/xE+YdHaCV7WlE+0Z3LNW4B1D20fDRMd9dHBYGpBUGXxd66DbO6eBqImMNSNDG6hJuZrG5Q0s4NMyjE6AYvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878876; c=relaxed/simple;
	bh=lGp8yrNMwTNT10Dk9PwXWLWqDZMUmvFh0Pv77hnvzQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEsO4JKTu2b+EgYY4X4p7cK2P7N+9XlBFmylFs2rDtVUYqJ0VwIjmZI3hmF7BVE4nvHKTl5jF2i7iq5LaNWbp0vrRaGlAhFdQtcuvw9nVULeuXZJjWMHehdqH39BXRewxwGuSAiLy/2IHSTPaOsyPaHfy4YH243qXwRJPF7UuRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ocgr0gZL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wzWwNzYD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ocgr0gZL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wzWwNzYD"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FtjC61065367;
	Thu, 1 Oct 2026 18:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vzWWpi4teCzBLFxVIhaxvrI2U9uHAP2D7Bdaeaf7Vmo=; b=
	Ocgr0gZL5ixqVMpBnUXpXY583SG+/ER1TtAhL3d4L7ccbUmJ5JMqr+k+3/fNNXwO
	yw5tFYjwtmYb9jgxlwfNiIX+ZXjyxbrIFLvmrIpXNJC/Dcgg8NuozHc57VbPUoB0
	NJ+IeL4CZ8B8LThAD5braSL3xCYugammABUQZUv/Sl3ZezrxCJFxX5n1Wdcf0nW3
	C414P0NUHSAJn7K67dvxQL8b1rJQvdqIDOHGqJnGajaGrEkJwcosFK73mXqxArF8
	MORx2To2YhKf5ICbJ9fjF86u6vJuI+RXSKAXn7xPqGf33UFhcimBsplPVntOPgLz
	mx65fGBjWATH2Iq7KpIDyA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5x79tey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 18:20:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691IKP59008376;
	Thu, 1 Oct 2026 18:20:45 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gt4e5f-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 18:20:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRaOrXFOCTi8xBQAhzNY59ooHLMJ7RhtpBvawEjXUIZkkYDEzYSS2NmnuZmhR+MWaLWcOzA5pxJ7UdEeqxua4cAzHXiwcSmaqiAFVJDr/LoQnvb+QBZCZU8LOOjqLBiKrK90sz55UHn7SdyhMyanoKEGxp8yEfME2nAM3C8KkZopWJRlYjkM0ef6I3XXAGesKsJPPiwiZnjIwnF+AVboDyhkLmbpUWHnqpK2hH4bjd/qqjsWXEyy3Hqh/cLO6k3pIfYXE7AqzDwKZpYLfRM47+lv9JAdskigpI9+AKsFqqIIrQecWPWpwRaULwgwrJ8EyJjU8yTZouHGwxd02v6GGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzWWpi4teCzBLFxVIhaxvrI2U9uHAP2D7Bdaeaf7Vmo=;
 b=QWwNZlPV5//U39fMkOMrhTuruZPqrIZTEqbu/3+CJPutOvq4rdEOxECRjTyu0zuDbly8dyXTIOxmQZy+ZtacMMA0k5j2VURPXdKaMJxrsYgq+79y7ZI9ES9D9ApogZ5f3+KAsQkjNAlGCx/jPkxaHsp9SDByK8RpQjXpc2S783AJ+/WPV8SOaAnrU9oe3Jj3QKPCBRE/e67w161lSn/dC3EV5vbQM6RJ8iSZapLEBeuceVMt62l8b9H+/7bNP5QQUqDyH+s+0ORXx77DOvfYvcc+fo2ZCrc84W3yBw9NmJ72Bit6BTdsRTb/AApGREXnUkdT7zFAl7ObRDJl2klgRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzWWpi4teCzBLFxVIhaxvrI2U9uHAP2D7Bdaeaf7Vmo=;
 b=wzWwNzYD4SaHCxNO4Epq9BKeH2VfvsJBSOJmWmMrOTVPn99oB0kSz3CiGS2Polbl6raNco94pGRNXNzJg7aM49ruT/4ldHyJo/5fhN/u1bKEn/fS5TggLyQxNpRJsef7SXp6FwS7Ji0f+JbpS7a8cTJ2wJH9W82JEt9rBBvVrS0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by DSVPR10MB798099.namprd10.prod.outlook.com (2603:10b6:8:381::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Thu, 1 Oct
 2026 18:20:11 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 18:20:10 +0000
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
Subject: [PATCH 1/2] tools: perf: add perf_input_name() helper
Date: Thu,  1 Oct 2026 11:20:00 -0700
Message-ID: <20261001182004.1160406-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
References: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::30) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|DSVPR10MB798099:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9318c0-a231-4524-8529-08df1fe8a136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	ix+FoH0PENk8Q2+GOR9+3agZZpaQwZp5X2yUFqyNBCt3f2Vs38IgngZ1lfJ3SxSFuELTVwoH5gbHiyDNndWw7/WaBaR+UCDkC6T7Nmut4x+SgwhgLNAYLT8rMpsmDPGLHLNhxe6ooxw+NhAsy+F3C/jttxQHC7rBU1aY/6HN+WA8qpLyBek1Bm8JKVFtkoHO9+bYQV4W+V3VJ9C4QWRdUfWKo16bpN+WxHoKVkyQdw8w7K8t4Mq5yfSwvTmcjBUTI98nNZo5EEsH7ZLxjCWN30KfqYd49NXlSE+11MYnjwH1anYD2a2kwo857G/5djWZfXNhzOouXCrNRKvKMVRdugnmCO19s6Zfj2FYrm1Giq/2XZTe3quDP4rAjVkpwv4MOqIVDBg7VbMzbjMDclUErrdCHrzwb4IMnzQqvwCPqCDqN8DvDtSGO27FaYm72xzhghSykn5B46YkjtX/elzQySn9YSXK85b6ZVXnJd63rpmyqa/t96tOftGDTgGIcrNrwR99WByMgdbxU5pLfBq40m46RNFyQp4Rg9+mbov1Zriy0Qk1ciepET4sr6kS+Jy3b+cXr+yzFe8JFU7YLShWeV52HcjZQXIJtZGD+CoAwUz+DRpUX45DPENoUa9P1Lubz4lESR1lzbw96xfY+jGKWxnrdIqbGTRz4XZ8Nt2p7mc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HwiL9zwKYK2qhJvN2mM9TIiJ2UpL/NAbEFL13u1ffWifLajuQrZeUIqtCMVR?=
 =?us-ascii?Q?e2cGWuKKi2V+YQm4Sc0v7BwhDp/RtsDNi15JZEMNKNlhmfh7l4TUEJpC0esy?=
 =?us-ascii?Q?B6rDn3Q4TPgJlFpidJ1Gx13pXwxxtyvfH0KCa5Q4qyo1V92Qj3b78pOrLg++?=
 =?us-ascii?Q?kAzerNi0XQLBaHe1krhlpXNwwAU9ad/+4dvMEfe7Ly+0jX2ogf2N7ZYjAFQY?=
 =?us-ascii?Q?RTDa8jCGOcE07VGfeFTp7iIKNWXnWcfOV0PE7rVytRulhcRc916sOV7Iv84a?=
 =?us-ascii?Q?8u94Xh0VGsF1aOR0/OndEGPHdlPleWaw2vB5rVLem3Tsf3W/kROzAHW7QDnr?=
 =?us-ascii?Q?KBQ/cfgiPmqnUUJpMwmUNwLDX2/G+8jrZUYR4wd9+xcp1ZLDXhbmyWgbXMZq?=
 =?us-ascii?Q?Lv9GIcLt67WEwt5P7z7qy5sIo23Ng0SvfnRDt6ioEAzuLK7RAqFrq7SuHfMC?=
 =?us-ascii?Q?t/KMsYMfMGL6w4pcOW4JMl37e28EXjxKbKoqy9NDUC3/Kl32Tx+7DiQYadz0?=
 =?us-ascii?Q?vdllJC4fSLAd6badYl1H/JxZBb/yRKDR1yfWAFEw8ZjK0JG7rgL8RrditUSl?=
 =?us-ascii?Q?2MBsG0Yz5N71s2VWoWelk6CIu+YG+PEvvI/4bbLJReI81qRYvkXVFai5UP5g?=
 =?us-ascii?Q?5iuj075QiFeZt+p7iWTue5zhUf9sE6Ym6ZTGnoyF2o4UUpNltZTVzyHKmm5Q?=
 =?us-ascii?Q?iUTY0gENurUwPOlugcNRtEsMr6GWV0F1jNUf4e/3sdrSYWhDA35kfhg2G7lC?=
 =?us-ascii?Q?Knl3UDxc30b0ZFEoM7g0nnEQLVGyXzbvI7vz4RECKp8eoN5Kt1vvSj0uKHWU?=
 =?us-ascii?Q?pIflZ+OZjJqXNKl1twRoBV9oBY8we2FCvcMZxDU9oDeuxDHhE4r3agk3hmuq?=
 =?us-ascii?Q?SF127zjL5MvbIKoNp2RtyXex9FZ28GH/VgOKX3vUKwpoKw1rSxhR24H5IXuv?=
 =?us-ascii?Q?YFKZRu9GIC8BDbl3DjTk1VeKDcWGwFyQRERhXBFRGQWYRli8agYR7ogGXWlz?=
 =?us-ascii?Q?W3f3DFo9Y1dKLtdz9UNFb25fcmoxBkNfWXxWNrZEZzu0qDjtgYeg4eKXA311?=
 =?us-ascii?Q?gXJL7oFO0y7f8/8s+RKf0u9dWoLJ2+tuWP8UFZKtkJLdCIokm8vbpAWhKami?=
 =?us-ascii?Q?heszuFcf2EjL+brcr0quWUn9Lj+5+tdeBsj+H7os2VdrhDtEah38PpbpITVy?=
 =?us-ascii?Q?WbDcRWv6aba8rD8MoQKXrg0aMeLDPTpogf90TGLLbaDCJbu/ex5/1qy4++K6?=
 =?us-ascii?Q?pJDJ1gSkMGgzR+JvyVYeC/P0PI6TcP0t3zhjec0cX6ijRnf49Ri260nGSa6r?=
 =?us-ascii?Q?XuBxaWxDiO+LBVALDOt8mHe9vaZXJ8gYgIOz6XXwJFBD+B7cdFWQ4YmYB1fL?=
 =?us-ascii?Q?Yzhw+Gtsl2ywwByuO2C1w772WQa19lYizip6m1TgwJRpAEE8dFv7c2tcOq2Z?=
 =?us-ascii?Q?JPhsTSvAXzQRMrcUbQbbCj5G9MiL//I67nZ4glIS0sTv5j7+VBhyWqvB/Axh?=
 =?us-ascii?Q?giSmnlOfLn9d8IUdN4bYSmXpyY67F/ojFf0xXvp9pn5arJ56e+1ZbXRZaqTn?=
 =?us-ascii?Q?7o9EcXXEdb2BKrjLfUCwbofKZKBD+fA7HNkCxhbE4ps4TwiCDSJErzdusO9G?=
 =?us-ascii?Q?sNrmH29m0VVabPGNxQmPWSFW4Py/hwdUx3XQqirp4drMH9iFP0SSf1TC3cP5?=
 =?us-ascii?Q?44x58U8H/TIpISeWVimk6NRIL/NAny+waFYE+h8/e0E3N28SDE1bqpWdpJUS?=
 =?us-ascii?Q?+amzD20S7MukGP/J7Us1xpKbW1uQm/4=3D?=
X-Exchange-RoutingPolicyChecked:
	ESAh0TZYV5CJBKQ7ayZD74KTCZKklaonwoFvH541jGJgpIRtyz1r3lp9dqMrr1b1qesuT1w1UHOEkFIZ5iBrWKrtLZfFWe2GkXYsdqpVCb1FnwQ7hwWrHv7Qlh6rVe9gMaVZeifxoUOhJNcAKT92SQo6qsYlB1TSxvJRsBtOWBl6we+VFYjt2LGTu1be2op41SPLPVfbUrKkpr8EIbZ9VdMuIhlOttrXnWZ2zQt6f15pd3w516f4uRXrbq2S3x3cnMaaxvNzLkGniYXCNzl6N8qWbR4dngh4+/uM0bxGVV42aUqQelarh1jnZQVhxv1Be2bRIH7HIe9VOd+CS3RKZA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A3Dm8oq0Sic+XsznlkurL9LVUg4XtxlOQINDhQyd4KohlqOBLhu5KGIxpJerg/lWFuNgKZ3Nl6JL3HV4K+eFCQNFDVtSNyxodm7qgAWtMbErimyOWjOMUiFjmYD6vwY6qKLyQYCcJGVefED04jU6HlI3NX7WFmwKBYzxfNhDW7xZ4m6daMlYGr938YqU7HLUrsDwtMkWxMaZhx735W4KmzdqgewK+iE8qokeanfITu957mjj42ihQZZgkUazqX99bf4QaMxxdsYSqFF/5DxhSSvPvQ37tYgxQYDFryfbyWhSCqt+1+0UR7RTC0KAPiv6kKfALnU0TYWWpT1sTEGVXtT04z6FQq4ZMOW0+JaggWMxqU0UaxI8i8qaIhnDHQ2/52f/s8X59IaiQg/dTeZEiCPkSE7P1fd+YpT+7S78BSRB97Pyhk9ZBi7VTP92DYqXy/5dKmNPrI4BRh0M1+SNpBbMJSVDkh9f8yiPNEFYjShEte3kPQAFX5zR6s/a6vRqXQgs6aXTYM0d/4elH9wG1eaLP3nE+1Ac0sJQ1oST+02x0WKcwrvWX2hNPdKKIIMvqW99mt0YuUk09YSyd1jd0kAAC+8C8bBohssY7ulYXz4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9318c0-a231-4524-8529-08df1fe8a136
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 18:20:10.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saqJ4NpdcVN75CTGRP1FC2/7qJlnmvWmA7xMH82p9wyxwgLv3gH7qmR/goV0mJB4N1WPYqtnJ/Qbgai3TqU+2aA+I/HJqHO+1ZYWxI+/p6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB798099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010073
X-Proofpoint-ORIG-GUID: ik8M9tXBeJ3GXJyXEYTP-ik0BGgbKdwW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfX+EzFIC7v710P
 PYpa+dMUExn1qtsCFQ36l6crIYbsEIp0ML5AQZNQB/GQuDnWFigLemQvKZmueUV75uTqFxU+WNu
 ebt7vB8CE4ETWyQ4387m6Q7dDelvLb9ByAJlTYpj+mPDQqVKC3x8
X-Authority-Analysis: v=2.4 cv=CP+/zhrD c=1 sm=1 tr=0 ts=6abea47e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=GDe0PtGrjDQlM8l79nwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: ik8M9tXBeJ3GXJyXEYTP-ik0BGgbKdwW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfX8+WYy8N78oGK
 oaNTj/iN7YrEcQe/q1/gzP7OHuuX5ZS8mqOZgKjTyKi2htu0OH6J2wzMOhqrczm5s4AMYdPQp6j
 xrRh775U4sDWQgj+UdJPz4HOiqj59C3l8zcCwfO97CSb66EnRq5vsOO21h998IjtiXDmcC3xj53
 ihyDUFXFjgCV2zaEEzTT5R5EjUYA4FzHQnZYCTpN3syw/gOZyYJM6sYbdkR6FIK0TNDwalJ4jjz
 zlXk1KLFy9QGma8J0HAjZHu5uzsEoI8zYFWCgcAZUWSg7z+xxcja1V8mA5YcM3pSGQ9Aie5c0ro
 Ni2heOJX8ISy6h/N1sSRxZCC+Q/ezrAKV3dTKCsOslND24845POQjvazFRveVsX+07zVDPbjun/
 3q2WvqfHvWim/cMPmYA/OqQcq78zY4oICDjILk5zPxX1nCQWo576YVHHsZ0/sFTeZ8p9liDb9wO
 wt2Gl2sjIUY9AiGIy01fGmERdMPLM7uw4eK30Agk=

The perf scripting API does not expose the name of the input file being
processed. Some scripts, like flamegraph.py, assume that the "-i" option
will be passed through, but when perf actually processes "-i", it does
not keep it on the command line for the script. (This could break some
scripts which do not expect it.)

To allow scripts to know what file they're processing, add a new helper
perf_input_name(), which returns either the filename being processed, or
None for an unnamed pipe.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 tools/perf/Documentation/perf-script-python.txt  |  1 +
 .../scripts/python/Perf-Trace-Util/Context.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 27a1cac6fe763..3f127024f640d 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -622,6 +622,7 @@ as perf_trace_context.perf_script_context .
  common_lock_depth(context) - returns common_lock_depth for the current event
  perf_sample_insn(context) - returns the machine code instruction
  perf_set_itrace_options(context, itrace_options) - set --itrace options if they have not been set already
+ perf_input_name(context) - returns the input file name (or None for an unnamed pipe)
  perf_sample_srcline(context) - returns source_file_name, line_number
  perf_sample_srccode(context) - returns source_file_name, line_number, source_line
  perf_config_get(config_name) - returns the value of the named config item, or None if unset
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index c19f446109831..c50c2432c1f60 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -20,6 +20,7 @@
 #include "../../../util/map.h"
 #include "../../../util/maps.h"
 #include "../../../util/auxtrace.h"
+#include "../../../util/data.h"
 #include "../../../util/session.h"
 #include "../../../util/srcline.h"
 #include "../../../util/srccode.h"
@@ -181,6 +182,19 @@ static PyObject *__perf_config_get(PyObject *obj, PyObject *args)
 	return Py_BuildValue("s", perf_config_get(config_name));
 }
 
+static PyObject *perf_input_name(PyObject *obj, PyObject *args)
+{
+	struct scripting_context *c = get_scripting_context(args);
+
+	if (!c)
+		return NULL;
+
+	if (!c->session || !c->session->data || !c->session->data->path)
+		Py_RETURN_NONE;
+
+	return PyUnicode_DecodeFSDefault(c->session->data->path);
+}
+
 static PyMethodDef ContextMethods[] = {
 #ifdef HAVE_LIBTRACEEVENT
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
@@ -199,6 +213,8 @@ static PyMethodDef ContextMethods[] = {
 	{ "perf_sample_srccode", perf_sample_srccode,
 	  METH_VARARGS,	"Get source file name, line number and line."},
 	{ "perf_config_get", __perf_config_get, METH_VARARGS, "Get perf config entry"},
+	{ "perf_input_name",	perf_input_name,
+	  METH_VARARGS,	"Get the input file name, or None for a pipe"},
 	{ NULL, NULL, 0, NULL}
 };
 
-- 
2.52.0

