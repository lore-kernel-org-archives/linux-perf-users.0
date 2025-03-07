Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F98259C89;
	Fri,  7 Mar 2025 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389751; cv=fail; b=e+UZU2H2fNPRaOj+b29XH9LFg2rpcJy8yUQvmw22KD7s3VA2LQwUK5/PHmzwkh/0RbTEW5JRzI9cieJ9MCFiZqHqY0w1GPvFZ+VRxIpxBNfjCLLE5l2fFtV66FPYcytfpaS/bYq6ACQiIshauvF3g4EZPylp7xJy/oslG8xd4t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389751; c=relaxed/simple;
	bh=RORWDNDiFSmrliSEScIJfDp8ISQb+BIvZl7cvY1gIfs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FTT66QVnCAGVPBbdl/tUcbCoHL+ALD2BadomwU4Csb1brXn/Z4DNTbxib/PtGgfuBGtItziGY/7GlHKbVlCTR9BgYNFm1obzcgJQiRAgH47UiKTdlqM4tm2LBDSi5URpGO9pYK+MCug9EtiB3yKEvucP50sIbQ802FV2plvylhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YzGJY++w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WmBcsbhu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YzGJY++w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WmBcsbhu"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527LIMtU008216;
	Fri, 7 Mar 2025 23:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=hmQ7ddniYfNpgIKB
	7cdLhUorCFwQ2Q78GaGW74cLxsU=; b=YzGJY++w/dNGA1ESb9o4nq/jymXWpOC3
	oRsJR/CWaHGjLvaNC5grKbq0tcC6LlbBuE4NvmxDZUOjbJ5mnxQ3VFOlvzVWy6mC
	6dZ+Wgr7ubRY0OF9DORazmubfxYGl/1g0wAaxrEr2vSx9z5XQUdMpLpSwX6v/P62
	uKnoWzsUuxrkgkNqj4Gu4yW/JNlEbz2PtG39zeB5PFOXOo7FeFm1LWGD3UZ8KBps
	cQXm8osWye7hoTADXZ28vuKqhWN53BnaGIwuDkjsgfnMO39dqnPHQysnSZLSa9S7
	n5Mvn/Xab9Shx+rGLsutgHOTpFWcbBaZDM+SPKRkmxa1bcC7jm86JQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub7dase-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527N1rLl011672;
	Fri, 7 Mar 2025 23:22:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpfrwat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 23:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJVy5/z00qLkZYGhTNljC3A90HpHF3xHQjBx9QUNvl8x171ajI+IvoXMakPVU4Il6MzO7D6/t2LS3taWiAhzPKN0aD4HzYjwBhLJHQ7G/fpX6GSbP4Gx6/dNirA9fwHhprSOH0ROnFQix9sKR3GEkWczrHrL8ljkQ9cn9BwWoIqBluxsI0Q3JFcXq0al4wTbANFOvJnvTrK/KpYzplLtksI+9hCz0O4jPW3FXLjptQsYVpW6Iz3eMJ0eXVeo61nyMmcabHnZ06UyZn5kq0KljK6SBe/uvC8MZA6dqgwIBmA2/M80j07C4sE8j02JFgmzDU/ARpwjrMoR4YonYB4EUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmQ7ddniYfNpgIKB7cdLhUorCFwQ2Q78GaGW74cLxsU=;
 b=X2bXODCjs7tHJ6Xd/od42bNHTi8JwCF8eUA9d8N3jJvmzk0j7k7oibRvgl09Ky9tnPG2wIORpGbpbjWgT8muIwiP1Yd/EpJmWk98iIaz6RFV1pLZXGKvubiPFuQFYsBUN77tqRR8T5GZ7g5SiBjqlo0OIetOAcSk9e9Hae9Hu3YBDODYFBwzkhl9TtiLzmcc02zcgJAn7Rt2zOiWvLfdjai7A4q0FUWR/eu4cdDMxCWikC35hghC4eFj4eIWHMPjBT92039ZFJj1KHmNAA+IBeBKAzzD1US9kb1FXyA4nAzeWcu2IaMrX/4h3jORXE8/Qr56UhBwrmIdNVTUUIdpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmQ7ddniYfNpgIKB7cdLhUorCFwQ2Q78GaGW74cLxsU=;
 b=WmBcsbhuiGnCJO+S8F1EXEjAWNAz0OkQ1gA0rLDyNY5wlL28yO2R+RKHO8kZ0FDiOWkK6TNGrk7qWFC+SnXhVAHbGGsg8S80b0YwUCexk6mIETTtzbeL3+XboizgufVrv9t4Ad6OfC0wfmLv1f93f3vToPwgYoCT2fYKr+WPQ/4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA1PR10MB6469.namprd10.prod.outlook.com (2603:10b6:806:29d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 23:22:08 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 23:22:08 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v3 0/3] Support .gnu_debugdata for symbols in perf
Date: Fri,  7 Mar 2025 15:22:00 -0800
Message-ID: <20250307232206.2102440-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA1PR10MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: a4408df6-bbea-4247-1a6e-08dd5dcee10d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lIv9iBxcypmyYiEo/cogojJ7vP1aAdsqUd3LyxtPfaTfSZLfMbfAhcit4TOu?=
 =?us-ascii?Q?YKNsWaHtgSt29B9Q7jg/07rxUU+fCDEhKlVCXNGQkALlvVeNlwBwxgGFLKGG?=
 =?us-ascii?Q?xE0l7yrtXmW0lgS8wuK7UIa0wvJlEkSyPsxQb+DjUqrrWEAEFTx/0jbpb7WX?=
 =?us-ascii?Q?uAuUgIrxz8A+Q7fcNMwgX5H5yy07/0Q4y5o5kTIvGuomx4O9xKOGj85EIdWs?=
 =?us-ascii?Q?mbA6KenUPij/1JDA9oTtingAr3gIEak7s1VOkj3BcznTXuhCVFnpYfPJEfbg?=
 =?us-ascii?Q?pUvBNmjnRCzNXjLA3IaaxsaD3ACWBqfY+1zRppp9WiZ83mgDAyrxE0l/VDdE?=
 =?us-ascii?Q?9Uc4nbFHZmGpBoOcvZBK40UAovex7szd81j3AtjLvF4yasID+BiioUiC+axy?=
 =?us-ascii?Q?TK9PK/FNjO3g3SHCq9igrBaYKQBogjtU0pWLV8VnG5IVwUnpDYvi5xhqgAvc?=
 =?us-ascii?Q?NFW4BZAB2rGwZqeIthPC/uCaumCQkMbelP4jI1AS7+F3u30VR6PHPv1Iau6I?=
 =?us-ascii?Q?lumbEaXxq98S50z7H2VV33VPQQV4Ae3mPfp79uZqDJKmH4MMlGxsjj36NpH0?=
 =?us-ascii?Q?1N4R0zBbluUE+qUTWiBNZZFU+m61tXPNyaLUb+5rnbESgrs/RJPGLpWpRThp?=
 =?us-ascii?Q?Pp6wXVNWyKwSCrC1VDiFK5v+VH/2X4XOjjWI/mrX4SxzYSSJvetHtZBqOs8I?=
 =?us-ascii?Q?IpZU4Hl5vqr88z0WCop5sqEPYVHJJD4WmP8rzqMyj3emQmWCegd0Q5TrJ3El?=
 =?us-ascii?Q?04UF0NsFCfPCrNhl3XhIBBBYI6SbO1sd7wP0usOmpKswYgSfw4xsJ1S1XcKv?=
 =?us-ascii?Q?PH626SY2w6laZjCw8w9lg5eJYWWpKurWesMw9SLV2HSawugqWl61MRQJCc1g?=
 =?us-ascii?Q?T+vI2CsdX5rStfPHUVh5TQbRolRuRhJBIea2lDt0Nc7bJUbF4rKfffIHxlNV?=
 =?us-ascii?Q?13JvxWLl4RAiF7aPfntaXJAVsBrxtEUTRIAH+HVwLjBgvpluDth0i9klzA12?=
 =?us-ascii?Q?iDBuD+LyJDHzmp8pdYhq0kvYojHCtZL6fMQbQL5D5d9S/JfRvqK1irShMrSg?=
 =?us-ascii?Q?qUWR2kP/lz0mIDmhyIXwz+hrHU1JAOrREpL3pWp+hV2TTwHmBbo+5S2rOCYG?=
 =?us-ascii?Q?xg0QtZrM16dF+wD3aLgbwtQAcuysSsztmuS/wWYUCYodI06ES0kCETP2t/ja?=
 =?us-ascii?Q?guu4W9/a1vzERK+dQHVsxvFWcO02lEzKYdcmIj+h8fL7Fwxne6yI8Fvrs0Fm?=
 =?us-ascii?Q?g30sgy34BWGQDkDgT8AUCl6a1QXEXhSTMmDmXja6+u3sOUYivPCpyRLX8nkt?=
 =?us-ascii?Q?IwFp02z1m2Ox1/SsGAbyMW3nK+8xaz5/UhBlaoH0AAeiICf+pzhiHyIW0q7R?=
 =?us-ascii?Q?yI/dfIOz+dsga4w87W+6KCjBWmiOPJTdZr+mTycC3vIqjo+duQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fyr4RaDodl7H87R0GLDhrCIuTy3M58bVgAhT8OVwj0FwPsF3OeAxt4rbCe44?=
 =?us-ascii?Q?FQynv7C5dFDxJb5iieG3oL/2F4sQYAsXqQ4Hr1CPcFUm/xBVkylZ4wWB8T+/?=
 =?us-ascii?Q?MC5wYOqbQeFdRdcWiBSQwp/xf8iqQJ+40J9U8YhTDmt7J8vA5oEWseudWRzZ?=
 =?us-ascii?Q?CZn6chxBqsqSCAqUfBwonSEc1MdhQtU6fDBjTXHyVEmbGY0M0C+4kLyhBdnb?=
 =?us-ascii?Q?Utp/WI12HBWfiPisrSFFd8N0cZxbxP3ASaJHfd9NY2xsA+hiD7ZYJzD21QZY?=
 =?us-ascii?Q?3GcQorOOCcBGUu7qbtlAr0pDcIqiESiNl9Wcw3b0+cQge6y9mmML6mzgdDvb?=
 =?us-ascii?Q?spMQyZppB1Az65q5MZHNdCwU0QlGnKGzVr+gwU4o3WpWANTICQtprlI5iHY9?=
 =?us-ascii?Q?4ez9MMUYbsAqaFd9o3CfA23CTtiJMW9ZGjt3sGPTc0spkbF2F3YS1KUH6TPt?=
 =?us-ascii?Q?mSrr4vw68WgHDp9gFCyadgBhflb96kAftVdk05grQ9fEhnAJ4b02ZqvCs1Iw?=
 =?us-ascii?Q?VPzIG4awMjL4FAdww9WgFJdSfy6cx0BLrQaJVQMyjMrh6QBhYXBFWj2fTfvk?=
 =?us-ascii?Q?W+65s6tZb9MOnEvVk2EmXCzI1ZpokPDFeozXP6ouVxifKN3q2m6YzAhpXmzQ?=
 =?us-ascii?Q?+G0H/l6SU2Lt9w2Hn+SYT1x5KeJhwcv+R9/O6hA5d1pGOfqzmsZ3lQCuLS6E?=
 =?us-ascii?Q?2gpp/bufTeuWwHZ0FanGqqQQwYXvWYL5cSJzWmZRRTYTJ+tJio0hVHRgQeCQ?=
 =?us-ascii?Q?OhlScoERnMCbQxPHWVi6Is5M/Ikh1NXYNDuAhwikk1mcFfHQWcT41GJsW7Lu?=
 =?us-ascii?Q?LaQxuNyGqjnH7CEy4BMB5SUafKbr1KQHaudi0HR7lT7vuNoU6Qr4Im2OPHDY?=
 =?us-ascii?Q?YtSu514y+olWZDAQmIQosnsAqdXpeZuaJYo0wnnnXlOhf3pYfAMRx4BlVmDV?=
 =?us-ascii?Q?AlUVpfmpVJ8nzPP2FfgfeblBiZt8XEWbnam1GqWS3uW5446mcawIYZdZrVar?=
 =?us-ascii?Q?FsyKITpq/aFc/TyzI5W/hY6ni91aCDS1YRs46ddc4RaOltOXVCmW+pJO8UrT?=
 =?us-ascii?Q?BFtZCoKizysONjK6T7PCSjymxsmniI2c2VGyjDdwwhyplEgRRRFuq2CJDvr5?=
 =?us-ascii?Q?mQkl2nzdbLEOuazILNeC//97H6y67mhevSwm3RYZFnpdvdez9KIQFER67pN7?=
 =?us-ascii?Q?Gj61dseLFN19Hx20qFFHTxMAZMlpdUKr6JPz8PKw9PXKWBgwRHHXEMe4lMn1?=
 =?us-ascii?Q?6ZvargYB0lM99bDlyunpjBJzBOjQxRAU4m9t2/aDEGYc78l9miJRZxZpHJ/j?=
 =?us-ascii?Q?JhVwHxaKf91IEDed9Y1Uz1GPXteyfMFsFx1g5y+qxFmEFh7g/YkXF44OA33u?=
 =?us-ascii?Q?OIoPv8oTjARepWi16bt9h+F4UrPqODrLO1sC45tYVurr/N1J3W+emW91/WC7?=
 =?us-ascii?Q?NGW2ilqOzlWhy5hQw/EVBk6dBIoSBfE/mXoC2yhjICp3jc9rywt5+uwHdMY0?=
 =?us-ascii?Q?SkT+k5eHLsO+ssFMzvdzQbqM/87iQo9TByix4nVvHy7AGl3UJcevZ5cEXDb6?=
 =?us-ascii?Q?8PvgyOjimjgfgwlzeuXcxMlj45lOhq8o5djguUq85jR53iCoYW+sFc4AZ8RK?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rdna95dhCWrEgG4Ci6FC8kqZv9DvKJ5hrzJ45NcwRo/XRNPBiOxzkT/LCVtZsLh7oiFvRZ0JiZ097pzZwDYPiV+EnXZX+W2AoqzDbGY1DSvnAGSqUSrvKoblWRGaF2X4U83eRtuXW5w3q7yfGd6LcKvmUokmPXoNHRnaPlafND2Lf5k1o8AudVFgoH20vOkOeuKkXT0kLjGZYxJYUc3wT90tECiCkcM38XWRWKKlZBg3gPbPNqC0df/S+oRleOwWRSQ5SCLR4auyTOVZXqzmNXaWbCn0Bwx3jfp1yzd7XrtqCXfTkkHs20g9Jb80U05cOunhw2ubJ6O1FXkiqbK8EnfvZ7lBMOEoFv59oJIcMDRCgCx8nP3lVUHcfnMJjw+he762tqPqORqRfH7BOn+39VKZzxAMM1XUbDJP3RGwnD/he6S1Y/Jnf12WiztO21fS1FjbZbI7qHAQ+0N7p7ETNiOnXjPsmItVc5rJxEx0m1rAJ+CiYfYek2YG6URL2GRTFfwtDfJOuH79r1s2TEZueAUmaydwCvj2RJfA7xb4VFXG8mQ9NMVWZr4ZIfLnZ45j8nCQfzly+K471UrZNNRc1GQdympV0XYVVrKrwrLtyxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4408df6-bbea-4247-1a6e-08dd5dcee10d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:22:07.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2U8OOSB6i6kslM8h3DdR9wXg+B2H5KOVdM/UikvDDT30zrU9UjmEpzn9P1Z0JepZ/U3lE0zS7Yb+pn9WJ0RHWIcoirKlP70zuhp1R+v/vng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070173
X-Proofpoint-GUID: FRF-Om3ZiX2LFqdS_E7-Wd6NA4buJBLq
X-Proofpoint-ORIG-GUID: FRF-Om3ZiX2LFqdS_E7-Wd6NA4buJBLq

Hello all,

This series adds the ability to read symbols from the ".gnu_debugdata" section
of DSOs. More details are the cover letter of v1. This only has one small change
from v2: it adds the missing entry in dso__symtab_origin(). Its lack resulted in
truncating the output of symbols in "perf report -v" -- thanks to Arnaldo for
testing and catching that.

v2: https://lore.kernel.org/linux-perf-users/20250220185512.3357820-1-stephen.s.brennan@oracle.com/
v1: https://lore.kernel.org/linux-perf-users/20250213190542.3249050-1-stephen.s.brennan@oracle.com/

Stephen Brennan (3):
  tools: perf: add dummy functions for !HAVE_LZMA_SUPPORT
  tools: perf: add LZMA decompression from FILE
  tools: perf: support .gnu_debugdata for symbols

 tools/perf/util/compress.h   |  20 +++++++
 tools/perf/util/dso.c        |   3 +
 tools/perf/util/dso.h        |   1 +
 tools/perf/util/lzma.c       |  29 ++++++----
 tools/perf/util/symbol-elf.c | 106 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol.c     |   2 +
 6 files changed, 148 insertions(+), 13 deletions(-)

-- 
2.43.5

