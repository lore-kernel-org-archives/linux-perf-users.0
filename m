Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D814F12D;
	Mon,  9 Dec 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739608; cv=fail; b=u7r8NNrKP1wHwbX+hZro4K9+nV0yK1ZN2Jw0Di4h+aAsG7Fai78VOkDFuUQhKbGIygPmW9k0DbkOQO8uHa5p+orZ9tXRCZOfBeKhBDipj2MHNMYZHMS3/G7jvVTmHS0RDWZ2NfuQiR8wbLOz1vS83nhGRPQjgudV7ImhSaDRhp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739608; c=relaxed/simple;
	bh=3Z2KkhSzKRsQJXZSPt5iWatuKH7FC6fmP7ak8wfGOu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4/PkhiOwGEzAP8TJPmQk59WdJ2W1HFsBS54QbTFhuiP0RJy4v5+Yi3nDQ/2KUMCX6uLfpF+asIkU6dqSgxmXPvrJxNaJQDGj4pYvaX+vGm7oggZfKSR9kcjf+TvJRPOI+iYuDfB5uAYyaJ8+zji3LKxRETC5xacX+ZFnvzgW3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MfVa5LC2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aQfz4z2d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MfVa5LC2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aQfz4z2d"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98gKVq015763;
	Mon, 9 Dec 2024 10:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v4SjhYhjNX6sIzGmo2lYKtUYqxr3cnDdExlxhdjwFug=; b=
	MfVa5LC2H6WKsemTXMtAzQJxf+cBaD7C7ec4dbDkgnEVHzymMiGy2v+YfBUJ3B4H
	E/p/dj+VccFebFLtq4p7LhtGG9Jm2o4BweSGlS1wJ3mHZHmhAAZ70sLRe5/Rb3jI
	fj6plTSV9EXFvtgC82/SqB0JqPNYpsHKHyj4hEgIg7bHv4Mauk2KSkZlBA9sRGJZ
	YUp2WJhDGHOcaV6pSZWZyt/8yiQp0X4VqGo/2/0qMNsyrYPcaYZaU9m7jLqFZ1Ma
	zG0ayfKv4EwLZwMTevst6yk7+ofRK0iElyLmo62etXIHkcblRADK0gDCvkR82Y3E
	oz9CCiHyFk91PDNWQ5Jj9g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr610kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:19:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9926E3035555;
	Mon, 9 Dec 2024 10:19:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct73u7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReIylidWSl/yg+DGV6OBA7uiULEMJx+LXlDsIDP98sDqL8qy/lR/JFzyDO3JSZVgoq02Rc/aUL2Xz4o7+2ewX5vRa973cPOWFq+v3r1xzMlH300A0SiESbYZ0RN25enyMnazyWSKJGnFEjfqHQnXB2oGugrCHltLg8jnvh7YZK61rYnkQidWoqqfx6OaE6aLF8tfyjJJj0i6ruFCZHDMW3SdWNs8eiNWK4hN8/X3yAtqo/l6ioGLFqNb+Vp7F8qXTkEFMh3izRfr7eypdoI9Wfot5Xbw8V9D2c6QRD7pO8rO7OzFFjUK5yGkLnCZXC4vsk3CfMXYuJrePlDoRqq/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4SjhYhjNX6sIzGmo2lYKtUYqxr3cnDdExlxhdjwFug=;
 b=k3ckYtFO8YDsvPibA87hL3Knaqwa2Ks4B0buBsGRlWJlt9AER8FhLloko+0BoUvi5OvuF/qeLREf7x6OHjFrCGKpz/7I7ZueR1Lii7ntGtFN+28/7hHQMQz8mGFeYBBaX6D77eF5h+nyrsk8OjHcLk4b1VYTDe1UuSPr+Y5V0TwatkslgrTG0kFPyRcZ4o+Uk2THDud92zmlgV1zi409j3C9nbthGg5Skfh7IaWKHWCpCatE2c98x6NBOWRn4DPZbhhkCCaDMe0eG80O+lN0h1VY2WcPTOlnoEEWsJJiDHl3Xl7gpChesEAMhGvXqjXJI4C1m6mEyvQcT3K4wHidVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4SjhYhjNX6sIzGmo2lYKtUYqxr3cnDdExlxhdjwFug=;
 b=aQfz4z2d7RZ5ks39gNJ3URFGu+RRz2uKBSaiC9zwrCDsLYu+Vb+S1ZKhcTTp1JqjB9ITg7fRAwlwuKUVV8MEtN3GUNwY4bQobs65gpWx15YSZGmkrnuKa3RnMb25wDNSzxMPDVj6N5U3F/LZ4bSfknIMIEKnYnAGCOKQ8PSM4OE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB7544.namprd10.prod.outlook.com (2603:10b6:208:46c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 10:19:03 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 10:19:03 +0000
Date: Mon, 9 Dec 2024 10:18:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [tip:perf/core] [perf]  eca51ce01d:
 BUG:KASAN:null-ptr-deref_in_perf_mmap_to_page
Message-ID: <ab61a884-48cf-4ca3-966c-4a7a0eaed557@lucifer.local>
References: <202412082200.aefeb02-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202412082200.aefeb02-lkp@intel.com>
X-ClientProxiedBy: LO4P265CA0258.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2c1733-412c-42c7-8233-08dd183ae725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYssAcacZXGoqkNlKICrIx1RhQEZoP925HEdV6RAzY4IttjJK6f+u07sL631?=
 =?us-ascii?Q?Kbn3TIOaHFSxiksiKRXqP9zeypNTwCgGDd2wzZ6bAbk+D/0KgMJC0gPF+vqf?=
 =?us-ascii?Q?0UIROLUHswHJkh2UNKs18Hkw41y+JWdMwOiBXUVsFKYUO9PlD1AO0ZoAk3wO?=
 =?us-ascii?Q?+MiTclGvSeh7TihWYntQnnwfd82OIoQg7JS2NlNxXmmHmCTY9zQWiMjkj1F2?=
 =?us-ascii?Q?FzZJSxorgbf0EXwBCKZB0mgm9RMXOnpD6y219U7x5QiPBBiFP9VsEtSXF5E/?=
 =?us-ascii?Q?X16BMaw4Wo6G/M1cTSNI8MwOwq0/eRBhHDWuq0+mjUQto+sI7NpUKSYvZ50T?=
 =?us-ascii?Q?/hpv/gtyvHVexvfHvT3ROu2ms7LkX/VQKahh7B3RJir+QH3g6j0h0oXfy00c?=
 =?us-ascii?Q?47YKcoJG9W9cnlxul0kRWb4fm3t9yXpFd19n3b1cD7K25EgMVvrMwcKdP5C+?=
 =?us-ascii?Q?q2dzu6s8dYar99UyLkxlZxo4iDqPEeLtCo1a3Fz8aWKDD9kcpCCwDCuQGgj1?=
 =?us-ascii?Q?mv8QKc9iREahcv9pifGt63ah3Yw0R1zN6KbBC9BHRStF7AosngrbcbZamTb9?=
 =?us-ascii?Q?8yAIFctJIrriA1Ew5e0eU2Qh4j5Z78YYXUPOxbwtreVKYomxc20OlxGk3HGJ?=
 =?us-ascii?Q?25iolW7QXKCtE/gMgN3Mu4MDJj8vj4Xx7MoVBXXNvIsx30IfzxB4kw6dfnHM?=
 =?us-ascii?Q?ixfs25cLZpnFhMH/HqQgcGfDvPJhHFhv1RMMqhwxaakwT/jISyVO2orauPa9?=
 =?us-ascii?Q?3tvXzyg7OOjVYysSinrDy8kHIz3NlSLq/YdcdCIiNoj9q7D8RXusgEdROXcR?=
 =?us-ascii?Q?tIL0DjX0K3L+TR19WT4qeZVFkB0D8NPybVyYyecI7QR5CIn/lF08qfBG5fyv?=
 =?us-ascii?Q?TKS5XmlfhrTm6DiRbVexmKPxNAhAWx3+5cl56JqPTuUrKKzpGzB2bzJlec2B?=
 =?us-ascii?Q?OtqkrVG2S2cXNiv6Fd3+l4qPdYihS0uI1K0wD1FoTPaFoEX6QKPJh33avhA5?=
 =?us-ascii?Q?LWg4XamIAB3TyhYsArwewO0w5ArXIPvNKmqECT7ku5B2nRR5UasNBBWiHcVY?=
 =?us-ascii?Q?vYOnzXp2DKCbiudLqIXtcWyEQQlPBTCLEsUSVRDSYmS+NMSUkedwAVT1qh5/?=
 =?us-ascii?Q?KUrTe7Tgd3RTPPwUUdH9RtFss9c3ogiHSP+d7wsZawGERHjFFEltJ7XIFbkv?=
 =?us-ascii?Q?9NolSsPgiv0RGLhmy4zDb2rLemJhFJ6+o1hIjJ7SOnfUsrSka6H+UQjBzmxc?=
 =?us-ascii?Q?HCdVLgjXjYaBkl+AWy9qKn3fhhg572FascQ9z+ni+8ZKHPfoYNERNEQf+LRl?=
 =?us-ascii?Q?FTJQMaj4Zo3aNTrgM+qzAKSB5Fj3USAq3b2v6vIaPWQv9immwjD4FihHTA7y?=
 =?us-ascii?Q?DCIED3w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4onTB7aMtM5D0TUwI/ETo6LBvYG5RU+b+5PmgyQPzxCgq2IWz9pWpxTAuss?=
 =?us-ascii?Q?mCMIIj8qPbgF+H8KgScFlI36Stoe+vnyNcml36qfh4imS1XMTYpXo2xjtL6O?=
 =?us-ascii?Q?kn7N7UsRlIhG4mtJ5uZuTlJ0oZq4PJaAxF/xhdlG/p9x51Pi9KlWqN8HS0Xx?=
 =?us-ascii?Q?bc5ep3Dq6t1/tg1Xi7sQyo43n7toKmUJWQRPMy9x/u3wUbGeRmv55h/BgueQ?=
 =?us-ascii?Q?zwwBMPbm2XQurvcWfZ9HUk0bqz9Hx4WcIQMZjTkNQd+eDZKvmWteeFrXM5r6?=
 =?us-ascii?Q?1xbA8x6lydoQhTzCDiqPnBR2Jz1GLiMqISYe6nJZ4zPfvjIcf1+XYuXCt7h6?=
 =?us-ascii?Q?cDvRHALzb7hiUO6WOeFrUj5P7XrItCxTz5jsn/uhCFpKOVse0VKwTa4182HM?=
 =?us-ascii?Q?rRtI9yjHsEcLu/8ZTcdk5ZJjf2SqpXVA1aKKg7pUKNbIiam0Io/iYLM/DoFH?=
 =?us-ascii?Q?8R+2MJjicevTJIlwOWB5TQPkWUy/s0axugq11Vrga4UlOUlCnWPFT/HIct+S?=
 =?us-ascii?Q?vorNY21lGBtPkvXmf0WAQH5IxBFBbp8PjG9NuIxQxFX4EdCsadKzlbaHEF5p?=
 =?us-ascii?Q?tDIvYwlPHaVPEwe57AGYsp6TwjCUDtvDsph0SW8vLpORQSR8sY30nB9U4UrW?=
 =?us-ascii?Q?3y+Xq6tUBM9UPA1kFv80GVmzoSaQPwGWfI/u25iFPf7alQXtqao+Ay29hzhd?=
 =?us-ascii?Q?KqXmwDkixTfUdqsYkqCvJ+Ca10+PNniQfFo22BCallX5Y+vbShvxNev8ZCud?=
 =?us-ascii?Q?onB+fUvPAG3u2/qMn9TKOt0T0QNw3qpmizfdN25D4zPjUj9n3uVqkPcs7U+F?=
 =?us-ascii?Q?MMCEKdd8qTrc7QTQSXGMeFZcJVTvgs1JN78wDdnpJYfzjQBxlxOUEgg2+1/E?=
 =?us-ascii?Q?w4Gv1vMLhabQqCbuRSbkm115XulVBgQOalTsItBvO5TC5l62jUnsr64TfNA7?=
 =?us-ascii?Q?XMfRVF2ONl7VaO609prKzPT9t5c0oAduM96wrvXxsdqj6lj2wWR5TyreJcj1?=
 =?us-ascii?Q?xFfZ6Vo+hr/9k822dNV14Erse/TJHVAQmC1NW1LuWRjwdWvp73pBN4GHqahg?=
 =?us-ascii?Q?jOr8FGOJ4YKoXBdHTdmrxmK9YAhX4H44IfUDaltzN4MjVa5wF6R9a9YSv9yB?=
 =?us-ascii?Q?Ybz2d5czT8WzCqSgvhTzBaLajsK9ZxP8is0GvnvP/JZnTj+zWbmvA2Qy1LNj?=
 =?us-ascii?Q?Z8vCUzB3myWnAnJBY1i/HpRgYyqI+EX14Y6aLQCqt/Z/jqYxFq3L5/w0bQGF?=
 =?us-ascii?Q?iBVcsKG43p8JhCPdspQ/3AqCC6hwRH6uxDaoyAz1YpyKc6BrN6ZkwJO3Xwml?=
 =?us-ascii?Q?3oYuHJx6LpjXxjbmeGu+58I7cLfqc551thzllduvJ5r96O7tLOhUCzooHQ/J?=
 =?us-ascii?Q?cLOmFAWqwmCb5or8BQ+y8yEcZ7AiQUJml7TOqaI5S1IAJNl0RQL2gkA5ibgu?=
 =?us-ascii?Q?dtMovYXo49qjGUxIxmmFlMaC+4T97hRPZwlw976tUsuqijuWQJkxKb3Ycswe?=
 =?us-ascii?Q?JrTsovLdh27PZCodIzInkD21SucUXbbEobUlHl8UBwIrJsWIhVXrBai/9VOA?=
 =?us-ascii?Q?0jaIm6sMK8bnHMs2eTlSW6dzEAo0p6bGOHIUfe/rgYdAlDXUGQ5+LbVP2OCT?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qKoVhjXaZBI8QORzEev6+c2AGj0vjjQcDkkn51iSyZ22U7d4JYwPyvH09eyD/Rvar5K9feUOtocFp2Nx56me6ocogi50x3VjHgm9fkvXsDFfYq/dKvaR/D180elaBG7b/Co4ik8wRsOQ2VvNuGHT9Z+LmrhPf95Si12anOYD2ycPi+Kz5Yo5bV1wh7Y0YBxiUzegH84Gh5bLkFNF4Si/yLGXMjqRHWNNQGXVywqqDCZvOLIrVHr/A///xCIyGbgRZcivbP2WA8psZ6edErz9P+3kQvr7kOzzPYqG2uo4G/9y/sG4E2GpwdnaQhHLLYCPdYiLn3HFLZy+l5Un1LJxGOZa76roKUlVgBDdY6t9YesEAbinHyPXagSi3sxv77fNMELDxqe+o708sWSym0w9PA6H5kWagAAEtyv76ro4mw6rOcp6ZnSRrdVnptCmsbyzwvAt+SeE2BVTcOhI+O8rJw6rwYiQY4oX8Qs2nS44qqvZKgBHyqD7VX2qAkm1Ea+cMJXicppE8Dg4yHMJc5ECzLtX8jnxqWoToaMHzx9/HNXuAbnXFDHTQLYsgTaVLsvMkTybblLEjj01meIpkeXxXaTYUpaJDa2DpECiG2RHZg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c1733-412c-42c7-8233-08dd183ae725
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:19:03.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPvosMkAjx1KORFMDLvHrgl7rPw4oIzmIQQcoy+nQE8trsNcug7mLZaePm3WR95EU+iZwvKZbhOg5i3akgIxwb/l4H4eJBNVldLayUDJ3xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_06,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090080
X-Proofpoint-GUID: MoegUKKvbhQW-6c7m6lJw7SqlboQtr0z
X-Proofpoint-ORIG-GUID: MoegUKKvbhQW-6c7m6lJw7SqlboQtr0z

On Sun, Dec 08, 2024 at 11:29:25PM +0800, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_perf_mmap_to_page"=
 on:

Sorry about this, sent a v3 [0], just needs to come down the line! I
overlooked a single case (grr) where a pointer can be unexpectedly NULL. :)

[0]:https://lore.kernel.org/linux-mm/20241205082948.56212-1-lorenzo.stoakes=
@oracle.com/

>
> commit: eca51ce01d4956ab4b8f06bb55c031f4913fffcb ("perf: Map pages in adv=
ance")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core
>
> [test failed on linux-next/master ebe1b11614e079c5e366ce9bd3c8f44ca0fbcc1=
b]
>
> in testcase: perf-event-tests
> version: perf-event-tests-x86_64-a052241-1_20241102
> with following parameters:
>
> 	paranoid: not_paranoid_at_all
>
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake)=
 with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202412082200.aefeb02-lkp@intel.c=
om
>
>
> [ 307.127855][ T2618] BUG: KASAN: null-ptr-deref in perf_mmap_to_page (ke=
rnel/events/ring_buffer.c:950)
> [  307.127867][ T2618] Read of size 4 at addr 0000000000000178 by task re=
cord_mmap/2618
> [  307.127872][ T2618]
> [  307.133120][  T298]
> [  307.140280][ T2618] CPU: 0 UID: 0 PID: 2618 Comm: record_mmap Not tain=
ted 6.13.0-rc1-00027-geca51ce01d49 #1
> [  307.140287][ T2618] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIO=
S 1.8.1 12/05/2017
> [  307.140291][ T2618] Call Trace:
> [  307.140294][ T2618]  <TASK>
> [ 307.140297][ T2618] dump_stack_lvl (lib/dump_stack.c:124)
> [  307.149632][  T298]     Testing PERF_RECORD_FORK...                   =
             PASSED
> [ 307.150214][ T2618] kasan_report (mm/kasan/report.c:604)
> [ 307.150226][ T2618] ? perf_mmap_to_page (kernel/events/ring_buffer.c:95=
0)
> [  307.152429][  T298]
> [ 307.162112][ T2618] perf_mmap_to_page (kernel/events/ring_buffer.c:950)
> [ 307.162122][ T2618] perf_mmap (kernel/events/core.c:6579 kernel/events/=
core.c:6819)
> [ 307.162135][ T2618] ? __init_rwsem (arch/x86/include/asm/atomic.h:28 in=
clude/linux/atomic/atomic-arch-fallback.h:503 include/linux/atomic/atomic-i=
nstrumented.h:68 include/linux/osq_lock.h:25 kernel/locking/rwsem.c:326)
> [  307.171025][  T298]   + tests/record_sample/record_mmap
> [ 307.173349][ T2618] __mmap_new_vma (include/linux/fs.h:2183 mm/internal=
.h:124 mm/vma.c:2291 mm/vma.c:2355)
> [ 307.173364][ T2618] __mmap_region (mm/vma.c:2457)
> [  307.176222][  T298]
> [ 307.180519][ T2618] ? __pfx___mmap_region (mm/vma.c:2436)
> [ 307.180526][ T2618] ? lock_is_held_type (kernel/locking/lockdep.c:5590 =
kernel/locking/lockdep.c:5921)
> [ 307.180582][ T2618] ? vm_unmapped_area (mm/mmap.c:711)
> [ 307.244366][ T2618] ? lock_acquire (kernel/locking/lockdep.c:467 kernel=
/locking/lockdep.c:5851 kernel/locking/lockdep.c:5814)
> [ 307.248898][ T2618] ? mm_get_unmapped_area_vmflags (mm/mmap.c:853)
> [ 307.254645][ T2618] mmap_region (mm/mmap.c:1351)
> [ 307.258921][ T2618] do_mmap (mm/mmap.c:497)
> [ 307.262848][ T2618] ? __pfx_do_mmap (mm/mmap.c:288)
> [ 307.267292][ T2618] ? down_write_killable (arch/x86/include/asm/current=
.h:49 kernel/locking/rwsem.c:143 kernel/locking/rwsem.c:268 kernel/locking/=
rwsem.c:1303 kernel/locking/rwsem.c:1318 kernel/locking/rwsem.c:1590)
> [ 307.272426][ T2618] ? __pfx_down_write_killable (kernel/locking/rwsem.c=
:1586)
> [ 307.277912][ T2618] ? __fget_files (include/linux/rcupdate.h:347 includ=
e/linux/rcupdate.h:880 fs/file.c:1050)
> [ 307.282455][ T2618] vm_mmap_pgoff (mm/util.c:580)
> [ 307.286907][ T2618] ? __pfx_vm_mmap_pgoff (mm/util.c:570)
> [ 307.291882][ T2618] ? __fget_files (fs/file.c:1053)
> [ 307.296422][ T2618] ksys_mmap_pgoff (mm/mmap.c:542)
> [ 307.301050][ T2618] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/=
entry/common.c:83)
> [ 307.305415][ T2618] ? __up_write (arch/x86/include/asm/atomic64_64.h:87=
 include/linux/atomic/atomic-arch-fallback.h:2852 include/linux/atomic/atom=
ic-long.h:268 include/linux/atomic/atomic-instrumented.h:3391 kernel/lockin=
g/rwsem.c:1372)
> [ 307.309689][ T2618] ? vm_mmap_pgoff (mm/util.c:584)
> [ 307.314306][ T2618] ? __pfx_vm_mmap_pgoff (mm/util.c:570)
> [ 307.319269][ T2618] ? put_ctx (arch/x86/include/asm/atomic.h:93 include=
/linux/atomic/atomic-arch-fallback.h:949 include/linux/atomic/atomic-instru=
mented.h:401 include/linux/refcount.h:264 include/linux/refcount.h:307 incl=
ude/linux/refcount.h:325 kernel/events/core.c:1223)
> [ 307.323279][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
> [ 307.327901][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockd=
ep.c:4347 kernel/locking/lockdep.c:4406)
> [ 307.333732][ T2618] ? syscall_exit_to_user_mode (arch/x86/include/asm/j=
ump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/con=
text_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:2=
20)
> [ 307.339303][ T2618] ? do_syscall_64 (arch/x86/entry/common.c:102)
> [ 307.343834][ T2618] ? __kasan_slab_alloc (mm/kasan/common.c:318 mm/kasa=
n/common.c:345)
> [ 307.348711][ T2618] ? rcu_is_watching (arch/x86/include/asm/atomic.h:23=
 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/context_trac=
king.h:128 kernel/rcu/tree.c:737)
> [ 307.353326][ T2618] ? lockdep_init_map_type (kernel/locking/lockdep.c:4=
980)
> [ 307.358551][ T2618] ? __rwlock_init (kernel/locking/spinlock_debug.c:49=
)
> [ 307.362995][ T2618] ? file_f_owner_allocate (fs/fcntl.c:110)
> [ 307.368150][ T2618] ? do_fcntl (fs/fcntl.c:440 fs/fcntl.c:530)
> [ 307.372347][ T2618] ? __pfx_do_fcntl (fs/fcntl.c:448)
> [ 307.376880][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
> [ 307.381499][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockd=
ep.c:4347 kernel/locking/lockdep.c:4406)
> [ 307.387330][ T2618] ? syscall_exit_to_user_mode (arch/x86/include/asm/j=
ump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/con=
text_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:2=
20)
> [ 307.392898][ T2618] ? do_syscall_64 (arch/x86/entry/common.c:102)
> [ 307.397430][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
> [ 307.402050][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockd=
ep.c:4347 kernel/locking/lockdep.c:4406)
> [ 307.407881][ T2618] ? syscall_exit_to_user_mode (arch/x86/include/asm/j=
ump_label.h:36 include/linux/context_tracking_state.h:108 include/linux/con=
text_tracking.h:41 include/linux/entry-common.h:364 kernel/entry/common.c:2=
20)
> [ 307.413451][ T2618] ? do_syscall_64 (arch/x86/entry/common.c:102)
> [ 307.417985][ T2618] ? do_user_addr_fault (include/linux/rcupdate.h:347 =
include/linux/rcupdate.h:880 include/linux/mm.h:741 arch/x86/mm/fault.c:134=
0)
> [ 307.423037][ T2618] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:440 (=
discriminator 2))
> [ 307.427828][ T2618] ? do_user_addr_fault (include/linux/rcupdate.h:883 =
include/linux/mm.h:741 arch/x86/mm/fault.c:1340)
> [ 307.432877][ T2618] ? mark_held_locks (kernel/locking/lockdep.c:4309)
> [ 307.437499][ T2618] ? lockdep_hardirqs_on_prepare (kernel/locking/lockd=
ep.c:4347 kernel/locking/lockdep.c:4406)
> [ 307.443331][ T2618] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entr=
y_64.S:130)
> [  307.449076][ T2618] RIP: 0033:0x7f9dbc1c88a3
> [ 307.453360][ T2618] Code: ef e8 d1 b4 ff ff eb e7 e8 3a 68 01 00 66 2e =
0f 1f 84 00 00 00 00 00 41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 =
0f 05 <48> 3d 00 f0 ff ff 77 25 c3 0f 1f 40 00 48 8b 05 29 05 0d 00 64 c7
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	ef                   	out    %eax,(%dx)
>    1:	e8 d1 b4 ff ff       	call   0xffffffffffffb4d7
>    6:	eb e7                	jmp    0xffffffffffffffef
>    8:	e8 3a 68 01 00       	call   0x16847
>    d:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>   14:	00 00 00
>   17:	41 89 ca             	mov    %ecx,%r10d
>   1a:	41 f7 c1 ff 0f 00 00 	test   $0xfff,%r9d
>   21:	75 14                	jne    0x37
>   23:	b8 09 00 00 00       	mov    $0x9,%eax
>   28:	0f 05                	syscall
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trappin=
g instruction
>   30:	77 25                	ja     0x57
>   32:	c3                   	ret
>   33:	0f 1f 40 00          	nopl   0x0(%rax)
>   37:	48 8b 05 29 05 0d 00 	mov    0xd0529(%rip),%rax        # 0xd0567
>   3e:	64                   	fs
>   3f:	c7                   	.byte 0xc7
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 25                	ja     0x2d
>    8:	c3                   	ret
>    9:	0f 1f 40 00          	nopl   0x0(%rax)
>    d:	48 8b 05 29 05 0d 00 	mov    0xd0529(%rip),%rax        # 0xd053d
>   14:	64                   	fs
>   15:	c7                   	.byte 0xc7
> [  307.472788][ T2618] RSP: 002b:00007ffd7c31e008 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000009
> [  307.481042][ T2618] RAX: ffffffffffffffda RBX: 00007ffd7c31e318 RCX: 0=
0007f9dbc1c88a3
> [  307.488860][ T2618] RDX: 0000000000000003 RSI: 0000000000009000 RDI: 0=
000000000000000
> [  307.496678][ T2618] RBP: 00007ffd7c31e070 R08: 0000000000000004 R09: 0=
000000000000000
> [  307.504497][ T2618] R10: 0000000000000001 R11: 0000000000000246 R12: 0=
000000000000000
> [  307.512326][ T2618] R13: 00007ffd7c31e328 R14: 000055886087cdd8 R15: 0=
0007f9dbc2e7020
> [  307.520166][ T2618]  </TASK>
> [  307.523050][ T2618] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  307.532190][ T2618] Disabling lock debugging due to kernel taint
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 6.13.0-rc1 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"gcc-12 (Debian 12.2.0-14) 12.2.0"
> CONFIG_CC_IS_GCC=3Dy
> CONFIG_GCC_VERSION=3D120200
> CONFIG_CLANG_VERSION=3D0
> CONFIG_AS_IS_GNU=3Dy
> CONFIG_AS_VERSION=3D24000
> CONFIG_LD_IS_BFD=3Dy
> CONFIG_LD_VERSION=3D24000
> CONFIG_LLD_VERSION=3D0
> CONFIG_RUSTC_VERSION=3D0
> CONFIG_RUSTC_LLVM_VERSION=3D0
> CONFIG_CC_CAN_LINK=3Dy
> CONFIG_CC_CAN_LINK_STATIC=3Dy
> CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=3Dy
> CONFIG_TOOLS_SUPPORT_RELR=3Dy
> CONFIG_CC_HAS_ASM_INLINE=3Dy
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
> CONFIG_PAHOLE_VERSION=3D127
> CONFIG_CONSTRUCTORS=3Dy
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_TABLE_SORT=3Dy
> CONFIG_THREAD_INFO_IN_TASK=3Dy
>
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_UAPI_HEADER_TEST=3Dy
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_BUILD_SALT=3D"5.14.0-427.20.1.el9_4.x86_64"
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_HAVE_KERNEL_LZ4=3Dy
> CONFIG_HAVE_KERNEL_ZSTD=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=3D""
> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> CONFIG_WATCH_QUEUE=3Dy
> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=3Dy
> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> CONFIG_AUDITSYSCALL=3Dy
>
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> CONFIG_GENERIC_IRQ_INJECTION=3Dy
> CONFIG_HARDIRQS_SW_RESEND=3Dy
> CONFIG_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> CONFIG_GENERIC_MSI_IRQ=3Dy
> CONFIG_IRQ_MSI_IOMMU=3Dy
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> CONFIG_IRQ_FORCED_THREADING=3Dy
> CONFIG_SPARSE_IRQ=3Dy
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
>
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_CONTEXT_TRACKING=3Dy
> CONFIG_CONTEXT_TRACKING_IDLE=3Dy
>
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ_COMMON=3Dy
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=3Dy
> CONFIG_CONTEXT_TRACKING_USER=3Dy
> # CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=3D125
> # end of Timers subsystem
>
> CONFIG_BPF=3Dy
> CONFIG_HAVE_EBPF_JIT=3Dy
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
>
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=3Dy
> CONFIG_BPF_JIT=3Dy
> CONFIG_BPF_JIT_ALWAYS_ON=3Dy
> CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> CONFIG_USERMODE_DRIVER=3Dy
> CONFIG_BPF_PRELOAD=3Dy
> CONFIG_BPF_PRELOAD_UMD=3Dy
> CONFIG_BPF_LSM=3Dy
> # end of BPF subsystem
>
> CONFIG_PREEMPT_BUILD=3Dy
> CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy
> # CONFIG_PREEMPT_NONE is not set
> # CONFIG_PREEMPT_VOLUNTARY is not set
> CONFIG_PREEMPT=3Dy
> # CONFIG_PREEMPT_LAZY is not set
> # CONFIG_PREEMPT_RT is not set
> CONFIG_PREEMPT_COUNT=3Dy
> CONFIG_PREEMPTION=3Dy
> CONFIG_PREEMPT_DYNAMIC=3Dy
> CONFIG_SCHED_CORE=3Dy
> # CONFIG_SCHED_CLASS_EXT is not set
>
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=3Dy
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_SCHED_AVG_IRQ=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
> CONFIG_PSI=3Dy
> CONFIG_PSI_DEFAULT_DISABLED=3Dy
> # end of CPU/Task time and stats accounting
>
> CONFIG_CPU_ISOLATION=3Dy
>
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_NEED_TASKS_RCU=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_TASKS_RUDE_RCU=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> CONFIG_RCU_NOCB_CPU=3Dy
> # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
> # CONFIG_RCU_LAZY is not set
> # end of RCU Subsystem
>
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> CONFIG_IKHEADERS=3Dm
> CONFIG_LOG_BUF_SHIFT=3D21
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> CONFIG_PRINTK_INDEX=3Dy
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
>
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
>
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> CONFIG_CC_HAS_INT128=3Dy
> CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
> CONFIG_GCC10_NO_ARRAY_BOUNDS=3Dy
> CONFIG_CC_NO_ARRAY_BOUNDS=3Dy
> CONFIG_GCC_NO_STRINGOP_OVERFLOW=3Dy
> CONFIG_CC_NO_STRINGOP_OVERFLOW=3Dy
> CONFIG_ARCH_SUPPORTS_INT128=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> CONFIG_SLAB_OBJ_EXT=3Dy
> CONFIG_CGROUPS=3Dy
> CONFIG_PAGE_COUNTER=3Dy
> # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> CONFIG_MEMCG=3Dy
> # CONFIG_MEMCG_V1 is not set
> CONFIG_BLK_CGROUP=3Dy
> CONFIG_CGROUP_WRITEBACK=3Dy
> CONFIG_CGROUP_SCHED=3Dy
> CONFIG_GROUP_SCHED_WEIGHT=3Dy
> CONFIG_FAIR_GROUP_SCHED=3Dy
> CONFIG_CFS_BANDWIDTH=3Dy
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_SCHED_MM_CID=3Dy
> CONFIG_CGROUP_PIDS=3Dy
> CONFIG_CGROUP_RDMA=3Dy
> CONFIG_CGROUP_FREEZER=3Dy
> CONFIG_CGROUP_HUGETLB=3Dy
> CONFIG_CPUSETS=3Dy
> # CONFIG_CPUSETS_V1 is not set
> CONFIG_PROC_PID_CPUSET=3Dy
> CONFIG_CGROUP_DEVICE=3Dy
> CONFIG_CGROUP_CPUACCT=3Dy
> CONFIG_CGROUP_PERF=3Dy
> CONFIG_CGROUP_BPF=3Dy
> CONFIG_CGROUP_MISC=3Dy
> CONFIG_CGROUP_DEBUG=3Dy
> CONFIG_SOCK_CGROUP_DATA=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_TIME_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> CONFIG_CHECKPOINT_RESTORE=3Dy
> CONFIG_SCHED_AUTOGROUP=3Dy
> CONFIG_RELAY=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_RD_LZ4=3Dy
> CONFIG_RD_ZSTD=3Dy
> CONFIG_BOOT_CONFIG=3Dy
> # CONFIG_BOOT_CONFIG_FORCE is not set
> # CONFIG_BOOT_CONFIG_EMBED is not set
> CONFIG_INITRAMFS_PRESERVE_MTIME=3Dy
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=3Dy
> CONFIG_LD_ORPHAN_WARN_LEVEL=3D"warn"
> CONFIG_SYSCTL=3Dy
> CONFIG_HAVE_UID16=3Dy
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> CONFIG_EXPERT=3Dy
> CONFIG_UID16=3Dy
> CONFIG_MULTIUSER=3Dy
> CONFIG_SGETMASK_SYSCALL=3Dy
> CONFIG_SYSFS_SYSCALL=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> # CONFIG_BASE_SMALL is not set
> CONFIG_FUTEX=3Dy
> CONFIG_FUTEX_PI=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_IO_URING=3Dy
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_MEMBARRIER=3Dy
> CONFIG_KCMP=3Dy
> CONFIG_RSEQ=3Dy
> # CONFIG_DEBUG_RSEQ is not set
> CONFIG_CACHESTAT_SYSCALL=3Dy
> # CONFIG_PC104 is not set
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_SELFTEST is not set
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
> CONFIG_HAVE_PERF_EVENTS=3Dy
> CONFIG_GUEST_PERF_EVENTS=3Dy
>
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=3Dy
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
>
> CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> CONFIG_PROFILING=3Dy
> CONFIG_TRACEPOINTS=3Dy
>
> #
> # Kexec and crash features
> #
> CONFIG_CRASH_RESERVE=3Dy
> CONFIG_VMCORE_INFO=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_HAVE_IMA_KEXEC=3Dy
> CONFIG_KEXEC=3Dy
> CONFIG_KEXEC_FILE=3Dy
> CONFIG_KEXEC_SIG=3Dy
> # CONFIG_KEXEC_SIG_FORCE is not set
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=3Dy
> CONFIG_KEXEC_JUMP=3Dy
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_CRASH_HOTPLUG=3Dy
> CONFIG_CRASH_MAX_MEMORY_RANGES=3D8192
> # end of Kexec and crash features
> # end of General setup
>
> CONFIG_64BIT=3Dy
> CONFIG_X86_64=3Dy
> CONFIG_X86=3Dy
> CONFIG_INSTRUCTION_DECODER=3Dy
> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_CSUM=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> CONFIG_KASAN_SHADOW_OFFSET=3D0xdffffc0000000000
> CONFIG_HAVE_INTEL_TXT=3Dy
> CONFIG_X86_64_SMP=3Dy
> CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_DYNAMIC_PHYSICAL_MASK=3Dy
> CONFIG_PGTABLE_LEVELS=3D5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy
>
> #
> # Processor type and features
> #
> CONFIG_SMP=3Dy
> CONFIG_X86_X2APIC=3Dy
> CONFIG_X86_POSTED_MSI=3Dy
> CONFIG_X86_MPPARSE=3Dy
> CONFIG_X86_CPU_RESCTRL=3Dy
> # CONFIG_X86_FRED is not set
> CONFIG_X86_EXTENDED_PLATFORM=3Dy
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=3Dy
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=3Dy
> CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
> CONFIG_IOSF_MBI=3Dy
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=3Dy
> CONFIG_PARAVIRT=3Dy
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=3Dy
> CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
> CONFIG_XEN=3Dy
> # CONFIG_XEN_PV is not set
> CONFIG_XEN_PVHVM=3Dy
> CONFIG_XEN_PVHVM_SMP=3Dy
> CONFIG_XEN_PVHVM_GUEST=3Dy
> CONFIG_XEN_SAVE_RESTORE=3Dy
> # CONFIG_XEN_DEBUG_FS is not set
> # CONFIG_XEN_PVH is not set
> CONFIG_KVM_GUEST=3Dy
> CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
> CONFIG_PVH=3Dy
> CONFIG_PARAVIRT_TIME_ACCOUNTING=3Dy
> CONFIG_PARAVIRT_CLOCK=3Dy
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> CONFIG_INTEL_TDX_GUEST=3Dy
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> CONFIG_MCORE2=3Dy
> # CONFIG_MATOM is not set
> # CONFIG_GENERIC_CPU is not set
> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_INTEL_USERCOPY=3Dy
> CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
> CONFIG_X86_P6_NOP=3Dy
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_HAVE_PAE=3Dy
> CONFIG_X86_CMPXCHG64=3Dy
> CONFIG_X86_CMOV=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_IA32_FEAT_CTL=3Dy
> CONFIG_X86_VMX_FEATURE_NAMES=3Dy
> # CONFIG_PROCESSOR_SELECT is not set
> CONFIG_CPU_SUP_INTEL=3Dy
> CONFIG_CPU_SUP_AMD=3Dy
> CONFIG_CPU_SUP_HYGON=3Dy
> CONFIG_CPU_SUP_CENTAUR=3Dy
> CONFIG_CPU_SUP_ZHAOXIN=3Dy
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> CONFIG_GART_IOMMU=3Dy
> CONFIG_BOOT_VESA_SUPPORT=3Dy
> CONFIG_MAXSMP=3Dy
> CONFIG_NR_CPUS_RANGE_BEGIN=3D8192
> CONFIG_NR_CPUS_RANGE_END=3D8192
> CONFIG_NR_CPUS_DEFAULT=3D8192
> CONFIG_NR_CPUS=3D8192
> CONFIG_SCHED_CLUSTER=3Dy
> CONFIG_SCHED_SMT=3Dy
> CONFIG_SCHED_MC=3Dy
> CONFIG_SCHED_MC_PRIO=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_ACPI_MADT_WAKEUP=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCELOG_LEGACY=3Dy
> CONFIG_X86_MCE_INTEL=3Dy
> CONFIG_X86_MCE_AMD=3Dy
> CONFIG_X86_MCE_THRESHOLD=3Dy
> CONFIG_X86_MCE_INJECT=3Dm
>
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dm
> CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
> CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
> CONFIG_PERF_EVENTS_AMD_POWER=3Dm
> CONFIG_PERF_EVENTS_AMD_UNCORE=3Dy
> CONFIG_PERF_EVENTS_AMD_BRS=3Dy
> # end of Performance monitoring
>
> CONFIG_X86_16BIT=3Dy
> CONFIG_X86_ESPFIX64=3Dy
> CONFIG_X86_VSYSCALL_EMULATION=3Dy
> CONFIG_X86_IOPL_IOPERM=3Dy
> CONFIG_MICROCODE=3Dy
> CONFIG_MICROCODE_LATE_LOADING=3Dy
> # CONFIG_MICROCODE_LATE_FORCE_MINREV is not set
> CONFIG_X86_MSR=3Dy
> CONFIG_X86_CPUID=3Dy
> CONFIG_X86_5LEVEL=3Dy
> CONFIG_X86_DIRECT_GBPAGES=3Dy
> CONFIG_X86_CPA_STATISTICS=3Dy
> CONFIG_X86_MEM_ENCRYPT=3Dy
> CONFIG_AMD_MEM_ENCRYPT=3Dy
> CONFIG_NUMA=3Dy
> CONFIG_AMD_NUMA=3Dy
> CONFIG_X86_64_ACPI_NUMA=3Dy
> CONFIG_NODES_SHIFT=3D10
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
> CONFIG_X86_PMEM_LEGACY=3Dm
> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=3Dy
> CONFIG_MTRR_SANITIZER=3Dy
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> CONFIG_X86_PAT=3Dy
> CONFIG_X86_UMIP=3Dy
> CONFIG_CC_HAS_IBT=3Dy
> # CONFIG_X86_KERNEL_IBT is not set
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> CONFIG_ARCH_PKEY_BITS=3D4
> CONFIG_X86_INTEL_TSX_MODE_OFF=3Dy
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_X86_SGX=3Dy
> # CONFIG_X86_USER_SHADOW_STACK is not set
> CONFIG_EFI=3Dy
> CONFIG_EFI_STUB=3Dy
> CONFIG_EFI_HANDOVER_PROTOCOL=3Dy
> CONFIG_EFI_MIXED=3Dy
> CONFIG_EFI_RUNTIME_MAP=3Dy
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=3Dy
> CONFIG_HZ=3D1000
> CONFIG_SCHED_HRTICK=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_FILE=3Dy
> CONFIG_ARCH_SELECTS_KEXEC_FILE=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=3Dy
> CONFIG_ARCH_SUPPORTS_CRASH_DUMP=3Dy
> CONFIG_ARCH_DEFAULT_CRASH_DUMP=3Dy
> CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=3Dy
> CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=3Dy
> CONFIG_PHYSICAL_START=3D0x1000000
> CONFIG_RELOCATABLE=3Dy
> CONFIG_RANDOMIZE_BASE=3Dy
> CONFIG_X86_NEED_RELOCS=3Dy
> CONFIG_PHYSICAL_ALIGN=3D0x1000000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
> CONFIG_RANDOMIZE_MEMORY=3Dy
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa
> CONFIG_HOTPLUG_CPU=3Dy
> # CONFIG_COMPAT_VDSO is not set
> # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> CONFIG_LEGACY_VSYSCALL_NONE=3Dy
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=3Dy
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=3Dy
> CONFIG_LIVEPATCH=3Dy
> CONFIG_X86_BUS_LOCK_DETECT=3Dy
> # end of Processor type and features
>
> CONFIG_CC_HAS_NAMED_AS=3Dy
> CONFIG_CC_HAS_SLS=3Dy
> CONFIG_CC_HAS_RETURN_THUNK=3Dy
> CONFIG_CC_HAS_ENTRY_PADDING=3Dy
> CONFIG_FUNCTION_PADDING_CFI=3D11
> CONFIG_FUNCTION_PADDING_BYTES=3D16
> CONFIG_CALL_PADDING=3Dy
> CONFIG_HAVE_CALL_THUNKS=3Dy
> CONFIG_CALL_THUNKS=3Dy
> CONFIG_PREFIX_SYMBOLS=3Dy
> CONFIG_CPU_MITIGATIONS=3Dy
> CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=3Dy
> CONFIG_MITIGATION_RETPOLINE=3Dy
> CONFIG_MITIGATION_RETHUNK=3Dy
> CONFIG_MITIGATION_UNRET_ENTRY=3Dy
> CONFIG_MITIGATION_CALL_DEPTH_TRACKING=3Dy
> # CONFIG_CALL_THUNKS_DEBUG is not set
> CONFIG_MITIGATION_IBPB_ENTRY=3Dy
> CONFIG_MITIGATION_IBRS_ENTRY=3Dy
> CONFIG_MITIGATION_SRSO=3Dy
> # CONFIG_MITIGATION_SLS is not set
> CONFIG_MITIGATION_GDS=3Dy
> CONFIG_MITIGATION_RFDS=3Dy
> CONFIG_MITIGATION_SPECTRE_BHI=3Dy
> CONFIG_MITIGATION_MDS=3Dy
> CONFIG_MITIGATION_TAA=3Dy
> CONFIG_MITIGATION_MMIO_STALE_DATA=3Dy
> CONFIG_MITIGATION_L1TF=3Dy
> CONFIG_MITIGATION_RETBLEED=3Dy
> CONFIG_MITIGATION_SPECTRE_V1=3Dy
> CONFIG_MITIGATION_SPECTRE_V2=3Dy
> CONFIG_MITIGATION_SRBDS=3Dy
> CONFIG_MITIGATION_SSB=3Dy
> CONFIG_ARCH_HAS_ADD_PAGES=3Dy
>
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> CONFIG_SUSPEND=3Dy
> CONFIG_SUSPEND_FREEZER=3Dy
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> CONFIG_HIBERNATE_CALLBACKS=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy
> CONFIG_HIBERNATION_COMP_LZO=3Dy
> CONFIG_HIBERNATION_DEF_COMP=3D"lzo"
> CONFIG_PM_STD_PARTITION=3D""
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM_SLEEP_SMP=3Dy
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_USERSPACE_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=3Dy
> CONFIG_PM_DEBUG=3Dy
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=3Dy
> # CONFIG_DPM_WATCHDOG is not set
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=3Dy
> CONFIG_PM_GENERIC_DOMAINS=3Dy
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> CONFIG_PM_GENERIC_DOMAINS_SLEEP=3Dy
> CONFIG_ENERGY_MODEL=3Dy
> CONFIG_ARCH_SUPPORTS_ACPI=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> CONFIG_ACPI_TABLE_LIB=3Dy
> CONFIG_ACPI_THERMAL_LIB=3Dy
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=3Dy
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
> CONFIG_ACPI_EC=3Dy
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=3Dy
> CONFIG_ACPI_BATTERY=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_VIDEO=3Dm
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_TAD=3Dm
> CONFIG_ACPI_DOCK=3Dy
> CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> CONFIG_ACPI_CPPC_LIB=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_IPMI=3Dm
> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_ACPI_PLATFORM_PROFILE=3Dm
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> CONFIG_ACPI_TABLE_UPGRADE=3Dy
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=3Dy
> CONFIG_ACPI_CONTAINER=3Dy
> CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> CONFIG_ACPI_SBS=3Dm
> CONFIG_ACPI_HED=3Dy
> CONFIG_ACPI_BGRT=3Dy
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_ACPI_NHLT=3Dy
> CONFIG_ACPI_NFIT=3Dm
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=3Dy
> CONFIG_ACPI_HMAT=3Dy
> CONFIG_HAVE_ACPI_APEI=3Dy
> CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> CONFIG_ACPI_APEI=3Dy
> CONFIG_ACPI_APEI_GHES=3Dy
> CONFIG_ACPI_APEI_PCIEAER=3Dy
> CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
> CONFIG_ACPI_APEI_EINJ=3Dm
> CONFIG_ACPI_APEI_EINJ_CXL=3Dy
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> CONFIG_ACPI_DPTF=3Dy
> CONFIG_DPTF_POWER=3Dm
> CONFIG_DPTF_PCH_FIVR=3Dm
> CONFIG_ACPI_WATCHDOG=3Dy
> CONFIG_ACPI_EXTLOG=3Dm
> CONFIG_ACPI_ADXL=3Dy
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_ACPI_PFRUT=3Dm
> CONFIG_ACPI_PCC=3Dy
> CONFIG_ACPI_FFH=3Dy
> CONFIG_PMIC_OPREGION=3Dy
> CONFIG_ACPI_VIOT=3Dy
> CONFIG_ACPI_PRMT=3Dy
> CONFIG_X86_PM_TIMER=3Dy
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> CONFIG_CPU_FREQ_STAT=3Dy
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=3Dy
> # CONFIG_X86_PCC_CPUFREQ is not set
> CONFIG_X86_AMD_PSTATE=3Dy
> CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
> CONFIG_X86_AMD_PSTATE_UT=3Dm
> CONFIG_X86_ACPI_CPUFREQ=3Dm
> CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
> CONFIG_X86_POWERNOW_K8=3Dm
> CONFIG_X86_AMD_FREQ_SENSITIVITY=3Dm
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_P4_CLOCKMOD=3Dm
>
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=3Dm
> # end of CPU Frequency scaling
>
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=3Dy
> CONFIG_CPU_IDLE_GOV_LADDER=3Dy
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> CONFIG_CPU_IDLE_GOV_HALTPOLL=3Dy
> CONFIG_HALTPOLL_CPUIDLE=3Dy
> # end of CPU Idle
>
> CONFIG_INTEL_IDLE=3Dy
> # end of Power management and ACPI options
>
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_PCI_XEN=3Dy
> CONFIG_MMCONF_FAM10H=3Dy
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=3Dy
> CONFIG_AMD_NB=3Dy
> # end of Bus options (PCI etc.)
>
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=3Dy
> # CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set
> # CONFIG_X86_X32_ABI is not set
> CONFIG_COMPAT_32=3Dy
> CONFIG_COMPAT=3Dy
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> # end of Binary Emulations
>
> CONFIG_KVM_COMMON=3Dy
> CONFIG_HAVE_KVM_PFNCACHE=3Dy
> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING_TSO=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=3Dy
> CONFIG_KVM_MMIO=3Dy
> CONFIG_KVM_ASYNC_PF=3Dy
> CONFIG_HAVE_KVM_MSI=3Dy
> CONFIG_HAVE_KVM_READONLY_MEM=3Dy
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> CONFIG_KVM_VFIO=3Dy
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY=3Dy
> CONFIG_KVM_COMPAT=3Dy
> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> CONFIG_HAVE_KVM_NO_POLL=3Dy
> CONFIG_KVM_XFER_TO_GUEST_WORK=3Dy
> CONFIG_HAVE_KVM_PM_NOTIFIER=3Dy
> CONFIG_KVM_GENERIC_HARDWARE_ENABLING=3Dy
> CONFIG_KVM_GENERIC_MMU_NOTIFIER=3Dy
> CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG=3Dy
> CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES=3Dy
> CONFIG_KVM_PRIVATE_MEM=3Dy
> CONFIG_KVM_GENERIC_PRIVATE_MEM=3Dy
> CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE=3Dy
> CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=3Dy
> CONFIG_VIRTUALIZATION=3Dy
> CONFIG_KVM_X86=3Dm
> CONFIG_KVM=3Dm
> # CONFIG_KVM_SW_PROTECTED_VM is not set
> CONFIG_KVM_INTEL=3Dm
> # CONFIG_KVM_INTEL_PROVE_VE is not set
> CONFIG_X86_SGX_KVM=3Dy
> CONFIG_KVM_AMD=3Dm
> CONFIG_KVM_AMD_SEV=3Dy
> CONFIG_KVM_SMM=3Dy
> CONFIG_KVM_HYPERV=3Dy
> # CONFIG_KVM_XEN is not set
> # CONFIG_KVM_PROVE_MMU is not set
> CONFIG_KVM_MAX_NR_VCPUS=3D4096
> CONFIG_AS_AVX512=3Dy
> CONFIG_AS_SHA1_NI=3Dy
> CONFIG_AS_SHA256_NI=3Dy
> CONFIG_AS_TPAUSE=3Dy
> CONFIG_AS_GFNI=3Dy
> CONFIG_AS_VAES=3Dy
> CONFIG_AS_VPCLMULQDQ=3Dy
> CONFIG_AS_WRUSS=3Dy
> CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=3Dy
> CONFIG_ARCH_HAS_DMA_OPS=3Dy
>
> #
> # General architecture-dependent options
> #
> CONFIG_HOTPLUG_SMT=3Dy
> CONFIG_HOTPLUG_CORE_SYNC=3Dy
> CONFIG_HOTPLUG_CORE_SYNC_DEAD=3Dy
> CONFIG_HOTPLUG_CORE_SYNC_FULL=3Dy
> CONFIG_HOTPLUG_SPLIT_STARTUP=3Dy
> CONFIG_HOTPLUG_PARALLEL=3Dy
> CONFIG_GENERIC_ENTRY=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_JUMP_LABEL=3Dy
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=3Dy
> CONFIG_KPROBES_ON_FTRACE=3Dy
> CONFIG_UPROBES=3Dy
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> CONFIG_KRETPROBES=3Dy
> CONFIG_KRETPROBE_ON_RETHOOK=3Dy
> CONFIG_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_OPTPROBES=3Dy
> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
> CONFIG_HAVE_NMI=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
> CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=3Dy
> CONFIG_ARCH_HAS_CPU_PASID=3Dy
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> CONFIG_ARCH_WANTS_NO_INSTR=3Dy
> CONFIG_HAVE_ASM_MODVERSIONS=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_RSEQ=3Dy
> CONFIG_HAVE_RUST=3Dy
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_HAVE_PERF_REGS=3Dy
> CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> CONFIG_MMU_GATHER_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_MERGE_VMAS=3Dy
> CONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=3Dy
> CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=3Dy
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> CONFIG_HAVE_ARCH_SECCOMP=3Dy
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> CONFIG_SECCOMP=3Dy
> CONFIG_SECCOMP_FILTER=3Dy
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=3Dy
> CONFIG_HAVE_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR_STRONG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
> CONFIG_LTO_NONE=3Dy
> CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_PROPELLER_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_CFI_CLANG=3Dy
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_USER=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=3Dy
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_MOVE_PUD=3Dy
> CONFIG_HAVE_MOVE_PMD=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> CONFIG_ARCH_WANT_PMD_MKWRITE=3Dy
> CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_ARCH_HAS_EXECMEM_ROX=3Dy
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> CONFIG_HAVE_EXIT_THREAD=3Dy
> CONFIG_ARCH_MMAP_RND_BITS=3D28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> CONFIG_HAVE_PAGE_SIZE_4KB=3Dy
> CONFIG_PAGE_SIZE_4KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
> CONFIG_PAGE_SHIFT=3D12
> CONFIG_HAVE_OBJTOOL=3Dy
> CONFIG_HAVE_JUMP_LABEL_HACK=3Dy
> CONFIG_HAVE_NOINSTR_HACK=3Dy
> CONFIG_HAVE_NOINSTR_VALIDATION=3Dy
> CONFIG_HAVE_UACCESS_VALIDATION=3Dy
> CONFIG_HAVE_STACK_VALIDATION=3Dy
> CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> CONFIG_OLD_SIGSUSPEND3=3Dy
> CONFIG_COMPAT_OLD_SIGACTION=3Dy
> CONFIG_COMPAT_32BIT_TIME=3Dy
> CONFIG_ARCH_SUPPORTS_RT=3Dy
> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
> CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=3Dy
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> CONFIG_STRICT_KERNEL_RWX=3Dy
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> CONFIG_STRICT_MODULE_RWX=3Dy
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
> CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> CONFIG_ARCH_HAS_CC_PLATFORM=3Dy
> CONFIG_HAVE_STATIC_CALL=3Dy
> CONFIG_HAVE_STATIC_CALL_INLINE=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=3Dy
> CONFIG_DYNAMIC_SIGFRAME=3Dy
> CONFIG_HAVE_ARCH_NODE_DEV_GROUP=3Dy
> CONFIG_ARCH_HAS_HW_PTE_YOUNG=3Dy
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=3Dy
> CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=3Dy
>
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> # end of GCOV-based kernel profiling
>
> CONFIG_HAVE_GCC_PLUGINS=3Dy
> CONFIG_GCC_PLUGINS=3Dy
> # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> CONFIG_FUNCTION_ALIGNMENT_4B=3Dy
> CONFIG_FUNCTION_ALIGNMENT_16B=3Dy
> CONFIG_FUNCTION_ALIGNMENT=3D16
> # end of General architecture-dependent options
>
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_MODULE_SIG_FORMAT=3Dy
> CONFIG_MODULES=3Dy
> # CONFIG_MODULE_DEBUG is not set
> CONFIG_MODULE_FORCE_LOAD=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
> CONFIG_MODVERSIONS=3Dy
> CONFIG_ASM_MODVERSIONS=3Dy
> CONFIG_MODULE_SRCVERSION_ALL=3Dy
> CONFIG_MODULE_SIG=3Dy
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=3Dy
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA256 is not set
> # CONFIG_MODULE_SIG_SHA384 is not set
> CONFIG_MODULE_SIG_SHA512=3Dy
> # CONFIG_MODULE_SIG_SHA3_256 is not set
> # CONFIG_MODULE_SIG_SHA3_384 is not set
> # CONFIG_MODULE_SIG_SHA3_512 is not set
> CONFIG_MODULE_SIG_HASH=3D"sha512"
> # CONFIG_MODULE_COMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH=3D"/usr/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy
> CONFIG_BLK_CGROUP_RWSTAT=3Dy
> CONFIG_BLK_CGROUP_PUNT_BIO=3Dy
> CONFIG_BLK_DEV_BSG_COMMON=3Dy
> CONFIG_BLK_ICQ=3Dy
> CONFIG_BLK_DEV_BSGLIB=3Dy
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> CONFIG_BLK_DEV_WRITE_MOUNTED=3Dy
> CONFIG_BLK_DEV_ZONED=3Dy
> CONFIG_BLK_DEV_THROTTLING=3Dy
> CONFIG_BLK_WBT=3Dy
> CONFIG_BLK_WBT_MQ=3Dy
> CONFIG_BLK_CGROUP_IOLATENCY=3Dy
> CONFIG_BLK_CGROUP_FC_APPID=3Dy
> # CONFIG_BLK_CGROUP_IOCOST is not set
> # CONFIG_BLK_CGROUP_IOPRIO is not set
> CONFIG_BLK_DEBUG_FS=3Dy
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
>
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=3Dy
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> CONFIG_OSF_PARTITION=3Dy
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> CONFIG_MAC_PARTITION=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_BSD_DISKLABEL=3Dy
> CONFIG_MINIX_SUBPARTITION=3Dy
> CONFIG_SOLARIS_X86_PARTITION=3Dy
> CONFIG_UNIXWARE_DISKLABEL=3Dy
> # CONFIG_LDM_PARTITION is not set
> CONFIG_SGI_PARTITION=3Dy
> # CONFIG_ULTRIX_PARTITION is not set
> CONFIG_SUN_PARTITION=3Dy
> CONFIG_KARMA_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> # end of Partition Types
>
> CONFIG_BLK_MQ_PCI=3Dy
> CONFIG_BLK_MQ_VIRTIO=3Dy
> CONFIG_BLK_PM=3Dy
> CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy
> CONFIG_BLK_MQ_STACKING=3Dy
>
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dy
> CONFIG_IOSCHED_BFQ=3Dy
> CONFIG_BFQ_GROUP_IOSCHED=3Dy
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
>
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> CONFIG_PADATA=3Dy
> CONFIG_ASN1=3Dy
> CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> CONFIG_QUEUED_SPINLOCKS=3Dy
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> CONFIG_QUEUED_RWLOCKS=3Dy
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
> CONFIG_FREEZER=3Dy
>
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_COMPAT_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> CONFIG_BINFMT_MISC=3Dm
> CONFIG_COREDUMP=3Dy
> # end of Executable file formats
>
> #
> # Memory Management options
> #
> CONFIG_ZPOOL=3Dy
> CONFIG_SWAP=3Dy
> CONFIG_ZSWAP=3Dy
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> # CONFIG_ZSWAP_SHRINKER_DEFAULT_ON is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=3Dy
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"
> CONFIG_ZBUD=3Dy
> # CONFIG_Z3FOLD_DEPRECATED is not set
> CONFIG_ZSMALLOC=3Dy
> CONFIG_ZSMALLOC_STAT=3Dy
> CONFIG_ZSMALLOC_CHAIN_SIZE=3D8
>
> #
> # Slab allocator options
> #
> CONFIG_SLUB=3Dy
> # CONFIG_SLUB_TINY is not set
> # CONFIG_SLAB_MERGE_DEFAULT is not set
> CONFIG_SLAB_FREELIST_RANDOM=3Dy
> CONFIG_SLAB_FREELIST_HARDENED=3Dy
> CONFIG_SLAB_BUCKETS=3Dy
> # CONFIG_SLUB_STATS is not set
> CONFIG_SLUB_CPU_PARTIAL=3Dy
> # CONFIG_RANDOM_KMALLOC_CACHES is not set
> # end of Slab allocator options
>
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SPARSEMEM=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=3Dy
> CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=3Dy
> CONFIG_HAVE_GUP_FAST=3Dy
> CONFIG_NUMA_KEEP_MEMINFO=3Dy
> CONFIG_MEMORY_ISOLATION=3Dy
> CONFIG_EXCLUSIVE_SYSTEM_RAM=3Dy
> CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> CONFIG_MEMORY_HOTPLUG=3Dy
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_MEMORY_HOTREMOVE=3Dy
> CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy
> CONFIG_SPLIT_PTE_PTLOCKS=3Dy
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> CONFIG_SPLIT_PMD_PTLOCKS=3Dy
> CONFIG_MEMORY_BALLOON=3Dy
> CONFIG_BALLOON_COMPACTION=3Dy
> CONFIG_COMPACTION=3Dy
> CONFIG_COMPACT_UNEVICTABLE_DEFAULT=3D1
> CONFIG_PAGE_REPORTING=3Dy
> CONFIG_MIGRATION=3Dy
> CONFIG_DEVICE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
> CONFIG_CONTIG_ALLOC=3Dy
> CONFIG_PCP_BATCH_SCALE_MAX=3D5
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_MMU_NOTIFIER=3Dy
> CONFIG_KSM=3Dy
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_MEMORY_FAILURE=3Dy
> CONFIG_HWPOISON_INJECT=3Dm
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
> CONFIG_THP_SWAP=3Dy
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_PGTABLE_HAS_HUGE_LEAVES=3Dy
> CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP=3Dy
> CONFIG_ARCH_SUPPORTS_PMD_PFNMAP=3Dy
> CONFIG_ARCH_SUPPORTS_PUD_PFNMAP=3Dy
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_CMA=3Dy
> # CONFIG_CMA_DEBUGFS is not set
> CONFIG_CMA_SYSFS=3Dy
> CONFIG_CMA_AREAS=3D7
> CONFIG_MEM_SOFT_DIRTY=3Dy
> CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
> CONFIG_PAGE_IDLE_FLAG=3Dy
> CONFIG_IDLE_PAGE_TRACKING=3Dy
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy
> CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
> CONFIG_ARCH_HAS_ZONE_DMA_SET=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_ZONE_DMA32=3Dy
> CONFIG_ZONE_DEVICE=3Dy
> CONFIG_HMM_MIRROR=3Dy
> CONFIG_GET_FREE_REGION=3Dy
> CONFIG_DEVICE_PRIVATE=3Dy
> CONFIG_VMAP_PFN=3Dy
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> CONFIG_ARCH_HAS_PKEYS=3Dy
> CONFIG_ARCH_USES_PG_ARCH_2=3Dy
> CONFIG_VM_EVENT_COUNTERS=3Dy
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_DMAPOOL_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> CONFIG_MAPPING_DIRTY_HELPERS=3Dy
> CONFIG_MEMFD_CREATE=3Dy
> CONFIG_SECRETMEM=3Dy
> # CONFIG_ANON_VMA_NAME is not set
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy
> CONFIG_USERFAULTFD=3Dy
> # CONFIG_PTE_MARKER_UFFD_WP is not set
> CONFIG_LRU_GEN=3Dy
> CONFIG_LRU_GEN_ENABLED=3Dy
> # CONFIG_LRU_GEN_STATS is not set
> CONFIG_LRU_GEN_WALKS_MMU=3Dy
> CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=3Dy
> CONFIG_PER_VMA_LOCK=3Dy
> CONFIG_LOCK_MM_AND_FIND_VMA=3Dy
> CONFIG_IOMMU_MM_DATA=3Dy
> CONFIG_EXECMEM=3Dy
> CONFIG_NUMA_MEMBLKS=3Dy
> CONFIG_NUMA_EMU=3Dy
>
> #
> # Data Access Monitoring
> #
> CONFIG_DAMON=3Dy
> CONFIG_DAMON_VADDR=3Dy
> CONFIG_DAMON_PADDR=3Dy
> CONFIG_DAMON_SYSFS=3Dy
> # CONFIG_DAMON_DBGFS_DEPRECATED is not set
> CONFIG_DAMON_RECLAIM=3Dy
> # CONFIG_DAMON_LRU_SORT is not set
> # end of Data Access Monitoring
> # end of Memory Management options
>
> CONFIG_NET=3Dy
> CONFIG_NET_INGRESS=3Dy
> CONFIG_NET_EGRESS=3Dy
> CONFIG_NET_XGRESS=3Dy
> CONFIG_NET_REDIRECT=3Dy
> CONFIG_SKB_DECRYPTED=3Dy
> CONFIG_SKB_EXTENSIONS=3Dy
> CONFIG_NET_DEVMEM=3Dy
> CONFIG_NET_SHAPER=3Dy
>
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dy
> CONFIG_UNIX=3Dy
> CONFIG_AF_UNIX_OOB=3Dy
> CONFIG_UNIX_DIAG=3Dy
> CONFIG_TLS=3Dm
> CONFIG_TLS_DEVICE=3Dy
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_OFFLOAD=3Dy
> CONFIG_XFRM_ALGO=3Dy
> CONFIG_XFRM_USER=3Dy
> # CONFIG_XFRM_USER_COMPAT is not set
> CONFIG_XFRM_INTERFACE=3Dm
> CONFIG_XFRM_SUB_POLICY=3Dy
> CONFIG_XFRM_MIGRATE=3Dy
> CONFIG_XFRM_STATISTICS=3Dy
> CONFIG_XFRM_AH=3Dm
> CONFIG_XFRM_ESP=3Dm
> CONFIG_XFRM_IPCOMP=3Dm
> CONFIG_NET_KEY=3Dm
> CONFIG_NET_KEY_MIGRATE=3Dy
> CONFIG_XFRM_ESPINTCP=3Dy
> # CONFIG_SMC is not set
> CONFIG_XDP_SOCKETS=3Dy
> CONFIG_XDP_SOCKETS_DIAG=3Dy
> CONFIG_NET_HANDSHAKE=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_FIB_TRIE_STATS=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_ROUTE_CLASSID=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE_DEMUX=3Dm
> CONFIG_NET_IP_TUNNEL=3Dm
> CONFIG_NET_IPGRE=3Dm
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_IP_MROUTE_COMMON=3Dy
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_NET_IPVTI=3Dm
> CONFIG_NET_UDP_TUNNEL=3Dm
> CONFIG_NET_FOU=3Dm
> CONFIG_NET_FOU_IP_TUNNELS=3Dy
> CONFIG_INET_AH=3Dm
> CONFIG_INET_ESP=3Dm
> CONFIG_INET_ESP_OFFLOAD=3Dm
> CONFIG_INET_ESPINTCP=3Dy
> CONFIG_INET_IPCOMP=3Dm
> CONFIG_INET_TABLE_PERTURB_ORDER=3D16
> CONFIG_INET_XFRM_TUNNEL=3Dm
> CONFIG_INET_TUNNEL=3Dm
> CONFIG_INET_DIAG=3Dm
> CONFIG_INET_TCP_DIAG=3Dm
> CONFIG_INET_UDP_DIAG=3Dm
> CONFIG_INET_RAW_DIAG=3Dm
> CONFIG_INET_DIAG_DESTROY=3Dy
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dm
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dm
> CONFIG_TCP_CONG_HTCP=3Dm
> # CONFIG_TCP_CONG_HSTCP is not set
> # CONFIG_TCP_CONG_HYBLA is not set
> # CONFIG_TCP_CONG_VEGAS is not set
> CONFIG_TCP_CONG_NV=3Dm
> # CONFIG_TCP_CONG_SCALABLE is not set
> # CONFIG_TCP_CONG_LP is not set
> # CONFIG_TCP_CONG_VENO is not set
> # CONFIG_TCP_CONG_YEAH is not set
> CONFIG_TCP_CONG_ILLINOIS=3Dm
> CONFIG_TCP_CONG_DCTCP=3Dm
> # CONFIG_TCP_CONG_CDG is not set
> CONFIG_TCP_CONG_BBR=3Dm
> # CONFIG_DEFAULT_CUBIC is not set
> CONFIG_DEFAULT_RENO=3Dy
> CONFIG_DEFAULT_TCP_CONG=3D"reno"
> CONFIG_TCP_SIGPOOL=3Dy
> # CONFIG_TCP_AO is not set
> CONFIG_TCP_MD5SIG=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_IPV6_ROUTER_PREF=3Dy
> CONFIG_IPV6_ROUTE_INFO=3Dy
> CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> CONFIG_INET6_AH=3Dm
> CONFIG_INET6_ESP=3Dm
> CONFIG_INET6_ESP_OFFLOAD=3Dm
> CONFIG_INET6_ESPINTCP=3Dy
> CONFIG_INET6_IPCOMP=3Dm
> CONFIG_IPV6_MIP6=3Dm
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=3Dm
> CONFIG_INET6_TUNNEL=3Dy
> CONFIG_IPV6_VTI=3Dm
> CONFIG_IPV6_SIT=3Dm
> CONFIG_IPV6_SIT_6RD=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_IPV6_TUNNEL=3Dy
> CONFIG_IPV6_GRE=3Dm
> CONFIG_IPV6_FOU=3Dm
> CONFIG_IPV6_FOU_TUNNEL=3Dm
> CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_SUBTREES=3Dy
> CONFIG_IPV6_MROUTE=3Dy
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_PIMSM_V2=3Dy
> CONFIG_IPV6_SEG6_LWTUNNEL=3Dy
> CONFIG_IPV6_SEG6_HMAC=3Dy
> CONFIG_IPV6_SEG6_BPF=3Dy
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> CONFIG_IPV6_IOAM6_LWTUNNEL=3Dy
> CONFIG_NETLABEL=3Dy
> CONFIG_MPTCP=3Dy
> CONFIG_INET_MPTCP_DIAG=3Dm
> CONFIG_MPTCP_IPV6=3Dy
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NET_PTP_CLASSIFY=3Dy
> CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
> CONFIG_NETFILTER=3Dy
> CONFIG_NETFILTER_ADVANCED=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dm
>
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=3Dy
> CONFIG_NETFILTER_EGRESS=3Dy
> CONFIG_NETFILTER_SKIP_EGRESS=3Dy
> CONFIG_NETFILTER_NETLINK=3Dm
> CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
> CONFIG_NETFILTER_FAMILY_ARP=3Dy
> CONFIG_NETFILTER_BPF_LINK=3Dy
> CONFIG_NETFILTER_NETLINK_HOOK=3Dm
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
> CONFIG_NETFILTER_NETLINK_LOG=3Dm
> CONFIG_NETFILTER_NETLINK_OSF=3Dm
> CONFIG_NF_CONNTRACK=3Dm
> CONFIG_NF_LOG_SYSLOG=3Dm
> CONFIG_NETFILTER_CONNCOUNT=3Dm
> CONFIG_NF_CONNTRACK_MARK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_ZONES=3Dy
> CONFIG_NF_CONNTRACK_PROCFS=3Dy
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
> CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> CONFIG_NF_CONNTRACK_LABELS=3Dy
> CONFIG_NF_CONNTRACK_OVS=3Dy
> CONFIG_NF_CT_PROTO_DCCP=3Dy
> CONFIG_NF_CT_PROTO_GRE=3Dy
> CONFIG_NF_CT_PROTO_SCTP=3Dy
> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> CONFIG_NF_CONNTRACK_AMANDA=3Dm
> CONFIG_NF_CONNTRACK_FTP=3Dm
> CONFIG_NF_CONNTRACK_H323=3Dm
> CONFIG_NF_CONNTRACK_IRC=3Dm
> CONFIG_NF_CONNTRACK_BROADCAST=3Dm
> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
> CONFIG_NF_CONNTRACK_SNMP=3Dm
> CONFIG_NF_CONNTRACK_PPTP=3Dm
> CONFIG_NF_CONNTRACK_SANE=3Dm
> CONFIG_NF_CONNTRACK_SIP=3Dm
> CONFIG_NF_CONNTRACK_TFTP=3Dm
> CONFIG_NF_CT_NETLINK=3Dm
> CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
> CONFIG_NF_CT_NETLINK_HELPER=3Dm
> CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
> CONFIG_NF_NAT=3Dm
> CONFIG_NF_NAT_AMANDA=3Dm
> CONFIG_NF_NAT_FTP=3Dm
> CONFIG_NF_NAT_IRC=3Dm
> CONFIG_NF_NAT_SIP=3Dm
> CONFIG_NF_NAT_TFTP=3Dm
> CONFIG_NF_NAT_REDIRECT=3Dy
> CONFIG_NF_NAT_MASQUERADE=3Dy
> CONFIG_NF_NAT_OVS=3Dy
> CONFIG_NETFILTER_SYNPROXY=3Dm
> CONFIG_NF_TABLES=3Dm
> CONFIG_NF_TABLES_INET=3Dy
> CONFIG_NF_TABLES_NETDEV=3Dy
> CONFIG_NFT_NUMGEN=3Dm
> CONFIG_NFT_CT=3Dm
> CONFIG_NFT_FLOW_OFFLOAD=3Dm
> CONFIG_NFT_CONNLIMIT=3Dm
> CONFIG_NFT_LOG=3Dm
> CONFIG_NFT_LIMIT=3Dm
> CONFIG_NFT_MASQ=3Dm
> CONFIG_NFT_REDIR=3Dm
> CONFIG_NFT_NAT=3Dm
> CONFIG_NFT_TUNNEL=3Dm
> CONFIG_NFT_QUEUE=3Dm
> CONFIG_NFT_QUOTA=3Dm
> CONFIG_NFT_REJECT=3Dm
> CONFIG_NFT_REJECT_INET=3Dm
> CONFIG_NFT_COMPAT=3Dm
> CONFIG_NFT_HASH=3Dm
> CONFIG_NFT_FIB=3Dm
> CONFIG_NFT_FIB_INET=3Dm
> CONFIG_NFT_XFRM=3Dm
> CONFIG_NFT_SOCKET=3Dm
> CONFIG_NFT_OSF=3Dm
> CONFIG_NFT_TPROXY=3Dm
> CONFIG_NFT_SYNPROXY=3Dm
> CONFIG_NF_DUP_NETDEV=3Dm
> CONFIG_NFT_DUP_NETDEV=3Dm
> CONFIG_NFT_FWD_NETDEV=3Dm
> CONFIG_NFT_FIB_NETDEV=3Dm
> CONFIG_NFT_REJECT_NETDEV=3Dm
> CONFIG_NF_FLOW_TABLE_INET=3Dm
> CONFIG_NF_FLOW_TABLE=3Dm
> CONFIG_NF_FLOW_TABLE_PROCFS=3Dy
> CONFIG_NETFILTER_XTABLES=3Dm
> # CONFIG_NETFILTER_XTABLES_COMPAT is not set
>
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=3Dm
> CONFIG_NETFILTER_XT_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_SET=3Dm
>
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CT=3Dm
> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
> CONFIG_NETFILTER_XT_TARGET_HL=3Dm
> CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
> CONFIG_NETFILTER_XT_NAT=3Dm
> CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
>
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
> CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
> CONFIG_NETFILTER_XT_MATCH_HL=3Dm
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
> CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
> CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
>
> CONFIG_IP_SET=3Dm
> CONFIG_IP_SET_MAX=3D256
> CONFIG_IP_SET_BITMAP_IP=3Dm
> CONFIG_IP_SET_BITMAP_IPMAC=3Dm
> CONFIG_IP_SET_BITMAP_PORT=3Dm
> CONFIG_IP_SET_HASH_IP=3Dm
> CONFIG_IP_SET_HASH_IPMARK=3Dm
> CONFIG_IP_SET_HASH_IPPORT=3Dm
> CONFIG_IP_SET_HASH_IPPORTIP=3Dm
> CONFIG_IP_SET_HASH_IPPORTNET=3Dm
> CONFIG_IP_SET_HASH_IPMAC=3Dm
> CONFIG_IP_SET_HASH_MAC=3Dm
> CONFIG_IP_SET_HASH_NETPORTNET=3Dm
> CONFIG_IP_SET_HASH_NET=3Dm
> CONFIG_IP_SET_HASH_NETNET=3Dm
> CONFIG_IP_SET_HASH_NETPORT=3Dm
> CONFIG_IP_SET_HASH_NETIFACE=3Dm
> CONFIG_IP_SET_LIST_SET=3Dm
> CONFIG_IP_VS=3Dm
> CONFIG_IP_VS_IPV6=3Dy
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=3D12
>
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=3Dy
> CONFIG_IP_VS_PROTO_UDP=3Dy
> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> CONFIG_IP_VS_PROTO_ESP=3Dy
> CONFIG_IP_VS_PROTO_AH=3Dy
> CONFIG_IP_VS_PROTO_SCTP=3Dy
>
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dm
> CONFIG_IP_VS_WRR=3Dm
> CONFIG_IP_VS_LC=3Dm
> CONFIG_IP_VS_WLC=3Dm
> CONFIG_IP_VS_FO=3Dm
> CONFIG_IP_VS_OVF=3Dm
> CONFIG_IP_VS_LBLC=3Dm
> CONFIG_IP_VS_LBLCR=3Dm
> CONFIG_IP_VS_DH=3Dm
> CONFIG_IP_VS_SH=3Dm
> CONFIG_IP_VS_MH=3Dm
> CONFIG_IP_VS_SED=3Dm
> CONFIG_IP_VS_NQ=3Dm
> # CONFIG_IP_VS_TWOS is not set
>
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=3D8
>
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=3D12
>
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dm
> CONFIG_IP_VS_NFCT=3Dy
> CONFIG_IP_VS_PE_SIP=3Dm
>
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=3Dm
> CONFIG_IP_NF_IPTABLES_LEGACY=3Dm
> CONFIG_NF_SOCKET_IPV4=3Dm
> CONFIG_NF_TPROXY_IPV4=3Dm
> CONFIG_NF_TABLES_IPV4=3Dy
> CONFIG_NFT_REJECT_IPV4=3Dm
> CONFIG_NFT_DUP_IPV4=3Dm
> CONFIG_NFT_FIB_IPV4=3Dm
> CONFIG_NF_TABLES_ARP=3Dy
> CONFIG_NF_DUP_IPV4=3Dm
> CONFIG_NF_LOG_ARP=3Dm
> CONFIG_NF_LOG_IPV4=3Dm
> CONFIG_NF_REJECT_IPV4=3Dm
> CONFIG_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_NF_NAT_PPTP=3Dm
> CONFIG_NF_NAT_H323=3Dm
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_AH=3Dm
> CONFIG_IP_NF_MATCH_ECN=3Dm
> CONFIG_IP_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> CONFIG_IP_NF_TARGET_ECN=3Dm
> CONFIG_IP_NF_TARGET_TTL=3Dm
> CONFIG_IP_NF_RAW=3Dm
> CONFIG_IP_NF_SECURITY=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_NFT_COMPAT_ARP=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> CONFIG_IP_NF_ARP_MANGLE=3Dm
> # end of IP: Netfilter Configuration
>
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_IP6_NF_IPTABLES_LEGACY=3Dm
> CONFIG_NF_SOCKET_IPV6=3Dm
> CONFIG_NF_TPROXY_IPV6=3Dm
> CONFIG_NF_TABLES_IPV6=3Dy
> CONFIG_NFT_REJECT_IPV6=3Dm
> CONFIG_NFT_DUP_IPV6=3Dm
> CONFIG_NFT_FIB_IPV6=3Dm
> CONFIG_NF_DUP_IPV6=3Dm
> CONFIG_NF_REJECT_IPV6=3Dm
> CONFIG_NF_LOG_IPV6=3Dm
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_AH=3Dm
> CONFIG_IP6_NF_MATCH_EUI64=3Dm
> CONFIG_IP6_NF_MATCH_FRAG=3Dm
> CONFIG_IP6_NF_MATCH_OPTS=3Dm
> CONFIG_IP6_NF_MATCH_HL=3Dm
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
> CONFIG_IP6_NF_MATCH_MH=3Dm
> CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP6_NF_MATCH_RT=3Dm
> # CONFIG_IP6_NF_MATCH_SRH is not set
> # CONFIG_IP6_NF_TARGET_HL is not set
> CONFIG_IP6_NF_FILTER=3Dm
> CONFIG_IP6_NF_TARGET_REJECT=3Dm
> CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_RAW=3Dm
> CONFIG_IP6_NF_SECURITY=3Dm
> CONFIG_IP6_NF_NAT=3Dm
> CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP6_NF_TARGET_NPT=3Dm
> # end of IPv6: Netfilter Configuration
>
> CONFIG_NF_DEFRAG_IPV6=3Dm
> CONFIG_NF_TABLES_BRIDGE=3Dm
> CONFIG_NFT_BRIDGE_META=3Dm
> CONFIG_NFT_BRIDGE_REJECT=3Dm
> CONFIG_NF_CONNTRACK_BRIDGE=3Dm
> CONFIG_BRIDGE_NF_EBTABLES_LEGACY=3Dm
> CONFIG_BRIDGE_NF_EBTABLES=3Dm
> CONFIG_BRIDGE_EBT_BROUTE=3Dm
> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
> CONFIG_BRIDGE_EBT_T_NAT=3Dm
> CONFIG_BRIDGE_EBT_802_3=3Dm
> CONFIG_BRIDGE_EBT_AMONG=3Dm
> CONFIG_BRIDGE_EBT_ARP=3Dm
> CONFIG_BRIDGE_EBT_IP=3Dm
> CONFIG_BRIDGE_EBT_IP6=3Dm
> CONFIG_BRIDGE_EBT_LIMIT=3Dm
> CONFIG_BRIDGE_EBT_MARK=3Dm
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
> CONFIG_BRIDGE_EBT_STP=3Dm
> CONFIG_BRIDGE_EBT_VLAN=3Dm
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
> CONFIG_BRIDGE_EBT_DNAT=3Dm
> CONFIG_BRIDGE_EBT_MARK_T=3Dm
> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
> CONFIG_BRIDGE_EBT_SNAT=3Dm
> CONFIG_BRIDGE_EBT_LOG=3Dm
> CONFIG_BRIDGE_EBT_NFLOG=3Dm
> CONFIG_IP_DCCP=3Dm
> CONFIG_INET_DCCP_DIAG=3Dm
>
> #
> # DCCP CCIDs Configuration
> #
> # CONFIG_IP_DCCP_CCID2_DEBUG is not set
> CONFIG_IP_DCCP_CCID3=3Dy
> # CONFIG_IP_DCCP_CCID3_DEBUG is not set
> CONFIG_IP_DCCP_TFRC_LIB=3Dy
> # end of DCCP CCIDs Configuration
>
> #
> # DCCP Kernel Hacking
> #
> # CONFIG_IP_DCCP_DEBUG is not set
> # end of DCCP Kernel Hacking
>
> CONFIG_IP_SCTP=3Dm
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
> CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
> CONFIG_INET_SCTP_DIAG=3Dm
> # CONFIG_RDS is not set
> CONFIG_TIPC=3Dm
> CONFIG_TIPC_MEDIA_IB=3Dy
> CONFIG_TIPC_MEDIA_UDP=3Dy
> CONFIG_TIPC_CRYPTO=3Dy
> CONFIG_TIPC_DIAG=3Dm
> CONFIG_ATM=3Dm
> CONFIG_ATM_CLIP=3Dm
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=3Dm
> # CONFIG_ATM_MPOA is not set
> CONFIG_ATM_BR2684=3Dm
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=3Dm
> CONFIG_L2TP_DEBUGFS=3Dm
> CONFIG_L2TP_V3=3Dy
> CONFIG_L2TP_IP=3Dm
> CONFIG_L2TP_ETH=3Dm
> CONFIG_STP=3Dm
> CONFIG_GARP=3Dm
> CONFIG_MRP=3Dm
> CONFIG_BRIDGE=3Dm
> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> # CONFIG_BRIDGE_MRP is not set
> # CONFIG_BRIDGE_CFM is not set
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=3Dm
> CONFIG_VLAN_8021Q_GVRP=3Dy
> CONFIG_VLAN_8021Q_MVRP=3Dy
> CONFIG_LLC=3Dm
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> CONFIG_6LOWPAN=3Dm
> # CONFIG_6LOWPAN_DEBUGFS is not set
> # CONFIG_6LOWPAN_NHC is not set
> CONFIG_IEEE802154=3Dm
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=3Dm
> CONFIG_IEEE802154_6LOWPAN=3Dm
> CONFIG_MAC802154=3Dm
> CONFIG_NET_SCHED=3Dy
>
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_HFSC=3Dm
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_MULTIQ=3Dm
> CONFIG_NET_SCH_RED=3Dm
> # CONFIG_NET_SCH_SFB is not set
> CONFIG_NET_SCH_SFQ=3Dm
> # CONFIG_NET_SCH_TEQL is not set
> CONFIG_NET_SCH_TBF=3Dm
> CONFIG_NET_SCH_CBS=3Dm
> CONFIG_NET_SCH_ETF=3Dm
> CONFIG_NET_SCH_MQPRIO_LIB=3Dm
> CONFIG_NET_SCH_TAPRIO=3Dm
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_NETEM=3Dm
> # CONFIG_NET_SCH_DRR is not set
> CONFIG_NET_SCH_MQPRIO=3Dm
> # CONFIG_NET_SCH_SKBPRIO is not set
> # CONFIG_NET_SCH_CHOKE is not set
> # CONFIG_NET_SCH_QFQ is not set
> # CONFIG_NET_SCH_CODEL is not set
> CONFIG_NET_SCH_FQ_CODEL=3Dm
> CONFIG_NET_SCH_CAKE=3Dm
> CONFIG_NET_SCH_FQ=3Dm
> # CONFIG_NET_SCH_HHF is not set
> # CONFIG_NET_SCH_PIE is not set
> CONFIG_NET_SCH_INGRESS=3Dm
> # CONFIG_NET_SCH_PLUG is not set
> CONFIG_NET_SCH_ETS=3Dm
> CONFIG_NET_SCH_DEFAULT=3Dy
> # CONFIG_DEFAULT_FQ is not set
> CONFIG_DEFAULT_FQ_CODEL=3Dy
> # CONFIG_DEFAULT_SFQ is not set
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH=3D"fq_codel"
>
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_BASIC=3Dm
> # CONFIG_NET_CLS_ROUTE4 is not set
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> CONFIG_CLS_U32_PERF=3Dy
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_FLOW=3Dm
> CONFIG_NET_CLS_CGROUP=3Dy
> CONFIG_NET_CLS_BPF=3Dm
> CONFIG_NET_CLS_FLOWER=3Dm
> CONFIG_NET_CLS_MATCHALL=3Dm
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> # CONFIG_NET_EMATCH_CMP is not set
> # CONFIG_NET_EMATCH_NBYTE is not set
> # CONFIG_NET_EMATCH_U32 is not set
> # CONFIG_NET_EMATCH_META is not set
> # CONFIG_NET_EMATCH_TEXT is not set
> # CONFIG_NET_EMATCH_CANID is not set
> # CONFIG_NET_EMATCH_IPSET is not set
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dm
> CONFIG_NET_ACT_GACT=3Dm
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dm
> CONFIG_NET_ACT_SAMPLE=3Dm
> # CONFIG_NET_ACT_NAT is not set
> CONFIG_NET_ACT_PEDIT=3Dm
> # CONFIG_NET_ACT_SIMP is not set
> CONFIG_NET_ACT_SKBEDIT=3Dm
> CONFIG_NET_ACT_CSUM=3Dm
> CONFIG_NET_ACT_MPLS=3Dm
> CONFIG_NET_ACT_VLAN=3Dm
> CONFIG_NET_ACT_BPF=3Dy
> # CONFIG_NET_ACT_CONNMARK is not set
> CONFIG_NET_ACT_CTINFO=3Dm
> # CONFIG_NET_ACT_SKBMOD is not set
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=3Dm
> CONFIG_NET_ACT_CT=3Dm
> # CONFIG_NET_ACT_GATE is not set
> CONFIG_NET_TC_SKB_EXT=3Dy
> CONFIG_NET_SCH_FIFO=3Dy
> CONFIG_DCB=3Dy
> CONFIG_DNS_RESOLVER=3Dm
> # CONFIG_BATMAN_ADV is not set
> CONFIG_OPENVSWITCH=3Dm
> CONFIG_OPENVSWITCH_GRE=3Dm
> CONFIG_OPENVSWITCH_VXLAN=3Dm
> CONFIG_OPENVSWITCH_GENEVE=3Dm
> CONFIG_VSOCKETS=3Dy
> CONFIG_VSOCKETS_DIAG=3Dm
> CONFIG_VSOCKETS_LOOPBACK=3Dm
> CONFIG_VMWARE_VMCI_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
> CONFIG_HYPERV_VSOCKETS=3Dm
> CONFIG_NETLINK_DIAG=3Dy
> CONFIG_MPLS=3Dy
> CONFIG_NET_MPLS_GSO=3Dy
> CONFIG_MPLS_ROUTING=3Dm
> CONFIG_MPLS_IPTUNNEL=3Dm
> CONFIG_NET_NSH=3Dy
> CONFIG_HSR=3Dm
> CONFIG_NET_SWITCHDEV=3Dy
> CONFIG_NET_L3_MASTER_DEV=3Dy
> CONFIG_QRTR=3Dm
> # CONFIG_QRTR_TUN is not set
> CONFIG_QRTR_MHI=3Dm
> # CONFIG_NET_NCSI is not set
> CONFIG_PCPU_DEV_REFCNT=3Dy
> CONFIG_MAX_SKB_FRAGS=3D17
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
> CONFIG_XPS=3Dy
> CONFIG_CGROUP_NET_PRIO=3Dy
> CONFIG_CGROUP_NET_CLASSID=3Dy
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_BPF_STREAM_PARSER=3Dy
> CONFIG_NET_FLOW_LIMIT=3Dy
>
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=3Dm
> CONFIG_NET_DROP_MONITOR=3Dy
> # end of Network testing
> # end of Networking options
>
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=3Dm
> CONFIG_CAN_RAW=3Dm
> CONFIG_CAN_BCM=3Dm
> CONFIG_CAN_GW=3Dm
> CONFIG_CAN_J1939=3Dm
> CONFIG_CAN_ISOTP=3Dm
> CONFIG_BT=3Dm
> CONFIG_BT_BREDR=3Dy
> CONFIG_BT_RFCOMM=3Dm
> CONFIG_BT_RFCOMM_TTY=3Dy
> CONFIG_BT_BNEP=3Dm
> CONFIG_BT_BNEP_MC_FILTER=3Dy
> CONFIG_BT_BNEP_PROTO_FILTER=3Dy
> CONFIG_BT_HIDP=3Dm
> CONFIG_BT_LE=3Dy
> CONFIG_BT_LE_L2CAP_ECRED=3Dy
> # CONFIG_BT_6LOWPAN is not set
> # CONFIG_BT_LEDS is not set
> # CONFIG_BT_MSFTEXT is not set
> # CONFIG_BT_AOSPEXT is not set
> CONFIG_BT_DEBUGFS=3Dy
> # CONFIG_BT_SELFTEST is not set
>
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_INTEL=3Dm
> CONFIG_BT_BCM=3Dm
> CONFIG_BT_RTL=3Dm
> CONFIG_BT_MTK=3Dm
> CONFIG_BT_HCIBTUSB=3Dm
> CONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy
> CONFIG_BT_HCIBTUSB_POLL_SYNC=3Dy
> CONFIG_BT_HCIBTUSB_BCM=3Dy
> CONFIG_BT_HCIBTUSB_MTK=3Dy
> CONFIG_BT_HCIBTUSB_RTL=3Dy
> CONFIG_BT_HCIBTSDIO=3Dm
> CONFIG_BT_HCIUART=3Dm
> CONFIG_BT_HCIUART_H4=3Dy
> CONFIG_BT_HCIUART_BCSP=3Dy
> CONFIG_BT_HCIUART_ATH3K=3Dy
> # CONFIG_BT_HCIUART_INTEL is not set
> # CONFIG_BT_HCIUART_AG6XX is not set
> CONFIG_BT_HCIBCM203X=3Dm
> # CONFIG_BT_HCIBCM4377 is not set
> CONFIG_BT_HCIBPA10X=3Dm
> CONFIG_BT_HCIBFUSB=3Dm
> CONFIG_BT_HCIVHCI=3Dm
> CONFIG_BT_MRVL=3Dm
> CONFIG_BT_MRVL_SDIO=3Dm
> CONFIG_BT_ATH3K=3Dm
> # CONFIG_BT_MTKSDIO is not set
> # CONFIG_BT_VIRTIO is not set
> # CONFIG_BT_INTEL_PCIE is not set
> # end of Bluetooth device drivers
>
> CONFIG_AF_RXRPC=3Dm
> CONFIG_AF_RXRPC_IPV6=3Dy
> # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> # CONFIG_AF_RXRPC_INJECT_RX_DELAY is not set
> CONFIG_AF_RXRPC_DEBUG=3Dy
> CONFIG_RXKAD=3Dy
> CONFIG_RXPERF=3Dm
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=3Dy
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=3Dy
> CONFIG_WIRELESS=3Dy
> CONFIG_CFG80211=3Dm
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
> CONFIG_CFG80211_DEFAULT_PS=3Dy
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> # CONFIG_CFG80211_WEXT is not set
> CONFIG_MAC80211=3Dm
> CONFIG_MAC80211_HAS_RC=3Dy
> CONFIG_MAC80211_RC_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> # CONFIG_MAC80211_MESH is not set
> CONFIG_MAC80211_LEDS=3Dy
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> CONFIG_RFKILL=3Dm
> CONFIG_RFKILL_LEDS=3Dy
> CONFIG_RFKILL_INPUT=3Dy
> # CONFIG_RFKILL_GPIO is not set
> CONFIG_NET_9P=3Dy
> CONFIG_NET_9P_FD=3Dy
> CONFIG_NET_9P_VIRTIO=3Dy
> # CONFIG_NET_9P_XEN is not set
> # CONFIG_NET_9P_RDMA is not set
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=3Dm
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=3Dm
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=3Dy
> CONFIG_LWTUNNEL_BPF=3Dy
> CONFIG_DST_CACHE=3Dy
> CONFIG_GRO_CELLS=3Dy
> CONFIG_SOCK_VALIDATE_XMIT=3Dy
> CONFIG_NET_SELFTESTS=3Dy
> CONFIG_NET_SOCK_MSG=3Dy
> CONFIG_NET_DEVLINK=3Dy
> CONFIG_PAGE_POOL=3Dy
> CONFIG_PAGE_POOL_STATS=3Dy
> CONFIG_FAILOVER=3Dm
> CONFIG_ETHTOOL_NETLINK=3Dy
>
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=3Dy
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=3Dy
> CONFIG_GENERIC_PCI_IOMAP=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> CONFIG_PCIEPORTBUS=3Dy
> CONFIG_HOTPLUG_PCI_PCIE=3Dy
> CONFIG_PCIEAER=3Dy
> CONFIG_PCIEAER_INJECT=3Dm
> CONFIG_PCIEAER_CXL=3Dy
> CONFIG_PCIE_ECRC=3Dy
> CONFIG_PCIEASPM=3Dy
> CONFIG_PCIEASPM_DEFAULT=3Dy
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=3Dy
> CONFIG_PCIE_DPC=3Dy
> CONFIG_PCIE_PTM=3Dy
> CONFIG_PCIE_EDR=3Dy
> CONFIG_PCI_MSI=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=3Dy
> CONFIG_PCI_PF_STUB=3Dm
> CONFIG_PCI_ATS=3Dy
> CONFIG_PCI_DOE=3Dy
> CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> CONFIG_PCI_IOV=3Dy
> # CONFIG_PCI_NPEM is not set
> CONFIG_PCI_PRI=3Dy
> CONFIG_PCI_PASID=3Dy
> # CONFIG_PCIE_TPH is not set
> CONFIG_PCI_P2PDMA=3Dy
> CONFIG_PCI_LABEL=3Dy
> CONFIG_PCI_HYPERV=3Dm
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> CONFIG_PCIE_BUS_DEFAULT=3Dy
> # CONFIG_PCIE_BUS_SAFE is not set
> # CONFIG_PCIE_BUS_PERFORMANCE is not set
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D64
> CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_OCTEONEP is not set
> CONFIG_HOTPLUG_PCI_SHPC=3Dy
>
> #
> # PCI controller drivers
> #
> CONFIG_VMD=3Dy
> CONFIG_PCI_HYPERV_INTERFACE=3Dm
>
> #
> # Cadence-based PCIe controllers
> #
> # end of Cadence-based PCIe controllers
>
> #
> # DesignWare-based PCIe controllers
> #
> # CONFIG_PCI_MESON is not set
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # end of DesignWare-based PCIe controllers
>
> #
> # Mobiveil-based PCIe controllers
> #
> # end of Mobiveil-based PCIe controllers
>
> #
> # PLDA-based PCIe controllers
> #
> # end of PLDA-based PCIe controllers
> # end of PCI controller drivers
>
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
>
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
>
> CONFIG_CXL_BUS=3Dm
> CONFIG_CXL_PCI=3Dm
> # CONFIG_CXL_MEM_RAW_COMMANDS is not set
> CONFIG_CXL_ACPI=3Dm
> CONFIG_CXL_PMEM=3Dm
> CONFIG_CXL_MEM=3Dm
> CONFIG_CXL_PORT=3Dm
> CONFIG_CXL_SUSPEND=3Dy
> CONFIG_CXL_REGION=3Dy
> # CONFIG_CXL_REGION_INVALIDATION_TEST is not set
> CONFIG_PCCARD=3Dy
> # CONFIG_PCMCIA is not set
> # CONFIG_CARDBUS is not set
>
> #
> # PC-card bridges
> #
> # CONFIG_YENTA is not set
> # CONFIG_RAPIDIO is not set
>
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=3Dy
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> CONFIG_DEVTMPFS_SAFE=3Dy
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=3Dy
> CONFIG_FW_LOADER_DEBUG=3Dy
> CONFIG_FW_LOADER_PAGED_BUF=3Dy
> CONFIG_FW_LOADER_SYSFS=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> CONFIG_FW_LOADER_USER_HELPER=3Dy
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_FW_LOADER_COMPRESS=3Dy
> CONFIG_FW_LOADER_COMPRESS_XZ=3Dy
> CONFIG_FW_LOADER_COMPRESS_ZSTD=3Dy
> # CONFIG_FW_CACHE is not set
> CONFIG_FW_UPLOAD=3Dy
> # end of Firmware loader
>
> CONFIG_WANT_DEV_COREDUMP=3Dy
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> CONFIG_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> CONFIG_HMEM_REPORTING=3Dy
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=3Dy
> CONFIG_GENERIC_CPU_DEVICES=3Dy
> CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
> CONFIG_REGMAP=3Dy
> CONFIG_REGMAP_I2C=3Dm
> CONFIG_REGMAP_SPI=3Dm
> CONFIG_REGMAP_IRQ=3Dy
> CONFIG_REGMAP_SOUNDWIRE=3Dm
> CONFIG_REGMAP_SOUNDWIRE_MBQ=3Dm
> CONFIG_DMA_SHARED_BUFFER=3Dy
> # CONFIG_DMA_FENCE_TRACE is not set
> # CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
> # end of Generic Driver Options
>
> #
> # Bus devices
> #
> CONFIG_MHI_BUS=3Dm
> # CONFIG_MHI_BUS_DEBUG is not set
> CONFIG_MHI_BUS_PCI_GENERIC=3Dm
> # CONFIG_MHI_BUS_EP is not set
> # end of Bus devices
>
> #
> # Cache Drivers
> #
> # end of Cache Drivers
>
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
>
> #
> # Firmware Drivers
> #
>
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
>
> CONFIG_EDD=3Dm
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=3Dy
> CONFIG_DMIID=3Dy
> CONFIG_DMI_SYSFS=3Dy
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> CONFIG_ISCSI_IBFT_FIND=3Dy
> CONFIG_ISCSI_IBFT=3Dm
> CONFIG_FW_CFG_SYSFS=3Dy
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=3Dy
> # CONFIG_SYSFB_SIMPLEFB is not set
> CONFIG_FW_CS_DSP=3Dm
> # CONFIG_GOOGLE_FIRMWARE is not set
>
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_ESRT=3Dy
> CONFIG_EFI_VARS_PSTORE=3Dy
> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=3Dy
> CONFIG_EFI_SOFT_RESERVE=3Dy
> CONFIG_EFI_DXE_MEM_ATTRIBUTES=3Dy
> CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> CONFIG_EFI_DEV_PATH_PARSER=3Dy
> CONFIG_APPLE_PROPERTIES=3Dy
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> CONFIG_EFI_RCI2_TABLE=3Dy
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> CONFIG_EFI_EARLYCON=3Dy
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=3Dy
> # CONFIG_EFI_DISABLE_RUNTIME is not set
> CONFIG_EFI_COCO_SECRET=3Dy
> CONFIG_UNACCEPTED_MEMORY=3Dy
> # end of EFI (Extensible Firmware Interface) Support
>
> CONFIG_UEFI_CPER=3Dy
> CONFIG_UEFI_CPER_X86=3Dy
>
> #
> # Qualcomm firmware drivers
> #
> # end of Qualcomm firmware drivers
>
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
>
> CONFIG_GNSS=3Dm
> # CONFIG_GNSS_USB is not set
> CONFIG_MTD=3Dm
> # CONFIG_MTD_TESTS is not set
>
> #
> # Partition parsers
> #
> # CONFIG_MTD_CMDLINE_PARTS is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # end of Partition parsers
>
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=3Dm
> CONFIG_MTD_BLOCK=3Dm
> # CONFIG_MTD_BLOCK_RO is not set
>
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> # CONFIG_SM_FTL is not set
> # CONFIG_MTD_OOPS is not set
> # CONFIG_MTD_SWAP is not set
> # CONFIG_MTD_PARTITIONED_MASTER is not set
>
> #
> # RAM/ROM/Flash chip drivers
> #
> # CONFIG_MTD_CFI is not set
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> CONFIG_MTD_CFI_I1=3Dy
> CONFIG_MTD_CFI_I2=3Dy
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> # end of RAM/ROM/Flash chip drivers
>
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> # CONFIG_MTD_PLATRAM is not set
> # end of Mapping drivers for chip access
>
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> # CONFIG_MTD_DATAFLASH is not set
> # CONFIG_MTD_MCHP23K256 is not set
> # CONFIG_MTD_MCHP48L640 is not set
> # CONFIG_MTD_SST25L is not set
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLOCK2MTD is not set
>
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> # end of Self-contained MTD device drivers
>
> #
> # NAND
> #
> # CONFIG_MTD_ONENAND is not set
> # CONFIG_MTD_RAW_NAND is not set
> # CONFIG_MTD_SPI_NAND is not set
>
> #
> # ECC engine support
> #
> # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
> # CONFIG_MTD_NAND_ECC_SW_BCH is not set
> # CONFIG_MTD_NAND_ECC_MXIC is not set
> # end of ECC engine support
> # end of NAND
>
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> # end of LPDDR & LPDDR2 PCM memory drivers
>
> # CONFIG_MTD_SPI_NOR is not set
> CONFIG_MTD_UBI=3Dm
> CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> CONFIG_MTD_UBI_BEB_LIMIT=3D20
> # CONFIG_MTD_UBI_FASTMAP is not set
> # CONFIG_MTD_UBI_GLUEBI is not set
> # CONFIG_MTD_UBI_BLOCK is not set
> # CONFIG_MTD_UBI_FAULT_INJECTION is not set
> # CONFIG_MTD_UBI_NVMEM is not set
> # CONFIG_MTD_HYPERBUS is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PARPORT_SERIAL=3Dm
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> CONFIG_PARPORT_1284=3Dy
> CONFIG_PARPORT_NOT_PC=3Dy
> CONFIG_PNP=3Dy
> # CONFIG_PNP_DEBUG_MESSAGES is not set
>
> #
> # Protocols
> #
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_NULL_BLK=3Dm
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=3Dm
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> CONFIG_ZRAM=3Dm
> # CONFIG_ZRAM_BACKEND_LZ4 is not set
> # CONFIG_ZRAM_BACKEND_LZ4HC is not set
> # CONFIG_ZRAM_BACKEND_ZSTD is not set
> # CONFIG_ZRAM_BACKEND_DEFLATE is not set
> # CONFIG_ZRAM_BACKEND_842 is not set
> CONFIG_ZRAM_BACKEND_FORCE_LZO=3Dy
> CONFIG_ZRAM_BACKEND_LZO=3Dy
> CONFIG_ZRAM_DEF_COMP_LZORLE=3Dy
> # CONFIG_ZRAM_DEF_COMP_LZO is not set
> CONFIG_ZRAM_DEF_COMP=3D"lzo-rle"
> CONFIG_ZRAM_WRITEBACK=3Dy
> # CONFIG_ZRAM_TRACK_ENTRY_ACTIME is not set
> # CONFIG_ZRAM_MEMORY_TRACKING is not set
> # CONFIG_ZRAM_MULTI_COMP is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D0
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=3Dm
> CONFIG_BLK_DEV_RAM=3Dm
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D16384
> CONFIG_CDROM_PKTCDVD=3Dm
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_XEN_BLKDEV_FRONTEND=3Dm
> CONFIG_VIRTIO_BLK=3Dm
> CONFIG_BLK_DEV_RBD=3Dm
> # CONFIG_BLK_DEV_UBLK is not set
>
> #
> # NVME Support
> #
> CONFIG_NVME_AUTH=3Dm
> CONFIG_NVME_CORE=3Dm
> CONFIG_BLK_DEV_NVME=3Dm
> CONFIG_NVME_MULTIPATH=3Dy
> CONFIG_NVME_VERBOSE_ERRORS=3Dy
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=3Dm
> CONFIG_NVME_RDMA=3Dm
> CONFIG_NVME_FC=3Dm
> CONFIG_NVME_TCP=3Dm
> # CONFIG_NVME_TCP_TLS is not set
> # CONFIG_NVME_HOST_AUTH is not set
> CONFIG_NVME_TARGET=3Dm
> # CONFIG_NVME_TARGET_DEBUGFS is not set
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> CONFIG_NVME_TARGET_LOOP=3Dm
> CONFIG_NVME_TARGET_RDMA=3Dm
> CONFIG_NVME_TARGET_FC=3Dm
> CONFIG_NVME_TARGET_FCLOOP=3Dm
> CONFIG_NVME_TARGET_TCP=3Dm
> # CONFIG_NVME_TARGET_TCP_TLS is not set
> CONFIG_NVME_TARGET_AUTH=3Dy
> # end of NVME Support
>
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=3Dm
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_RPMB is not set
> CONFIG_TIFM_CORE=3Dm
> CONFIG_TIFM_7XX1=3Dm
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=3Dm
> CONFIG_SGI_XP=3Dm
> CONFIG_HP_ILO=3Dm
> CONFIG_SGI_GRU=3Dm
> # CONFIG_SGI_GRU_DEBUG is not set
> CONFIG_APDS9802ALS=3Dm
> CONFIG_ISL29003=3Dm
> CONFIG_ISL29020=3Dm
> CONFIG_SENSORS_TSL2550=3Dm
> CONFIG_SENSORS_BH1770=3Dm
> CONFIG_SENSORS_APDS990X=3Dm
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> CONFIG_VMWARE_BALLOON=3Dm
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=3Dm
> # CONFIG_NSM is not set
> # CONFIG_MCHP_LAN966X_PCI is not set
> # CONFIG_C2PORT is not set
>
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_MAX6875=3Dm
> CONFIG_EEPROM_93CX6=3Dy
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
>
> CONFIG_CB710_CORE=3Dm
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy
> CONFIG_SENSORS_LIS3_I2C=3Dm
> CONFIG_ALTERA_STAPL=3Dm
> CONFIG_INTEL_MEI=3Dm
> CONFIG_INTEL_MEI_ME=3Dm
> # CONFIG_INTEL_MEI_TXE is not set
> CONFIG_INTEL_MEI_GSC=3Dm
> # CONFIG_INTEL_MEI_VSC_HW is not set
> # CONFIG_INTEL_MEI_HDCP is not set
> # CONFIG_INTEL_MEI_PXP is not set
> CONFIG_INTEL_MEI_GSC_PROXY=3Dm
> CONFIG_VMWARE_VMCI=3Dm
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=3Dm
> CONFIG_MISC_RTSX_USB=3Dm
> # CONFIG_UACCE is not set
> CONFIG_PVPANIC=3Dy
> CONFIG_PVPANIC_MMIO=3Dm
> # CONFIG_PVPANIC_PCI is not set
> # CONFIG_GP_PCI1XXXX is not set
> # CONFIG_KEBA_CP500 is not set
> # end of Misc devices
>
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dy
> CONFIG_RAID_ATTRS=3Dm
> CONFIG_SCSI_COMMON=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DMA=3Dy
> CONFIG_SCSI_NETLINK=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
>
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_CHR_DEV_SG=3Dm
> CONFIG_BLK_DEV_BSG=3Dy
> CONFIG_CHR_DEV_SCH=3Dm
> CONFIG_SCSI_ENCLOSURE=3Dm
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_SCSI_LOGGING=3Dy
> CONFIG_SCSI_SCAN_ASYNC=3Dy
>
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=3Dm
> CONFIG_SCSI_FC_ATTRS=3Dm
> CONFIG_SCSI_ISCSI_ATTRS=3Dm
> CONFIG_SCSI_SAS_ATTRS=3Dm
> CONFIG_SCSI_SAS_LIBSAS=3Dm
> CONFIG_SCSI_SAS_ATA=3Dy
> CONFIG_SCSI_SAS_HOST_SMP=3Dy
> CONFIG_SCSI_SRP_ATTRS=3Dm
> # end of SCSI Transports
>
> CONFIG_SCSI_LOWLEVEL=3Dy
> CONFIG_ISCSI_TCP=3Dm
> CONFIG_ISCSI_BOOT_SYSFS=3Dm
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> CONFIG_SCSI_CXGB4_ISCSI=3Dm
> CONFIG_SCSI_BNX2_ISCSI=3Dm
> CONFIG_SCSI_BNX2X_FCOE=3Dm
> CONFIG_BE2ISCSI=3Dm
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> CONFIG_SCSI_HPSA=3Dm
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> CONFIG_SCSI_AACRAID=3Dm
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> CONFIG_MEGARAID_NEWGEN=3Dy
> CONFIG_MEGARAID_MM=3Dm
> CONFIG_MEGARAID_MAILBOX=3Dm
> CONFIG_MEGARAID_LEGACY=3Dm
> CONFIG_MEGARAID_SAS=3Dm
> CONFIG_SCSI_MPT3SAS=3Dm
> CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT2SAS=3Dm
> CONFIG_SCSI_MPI3MR=3Dm
> CONFIG_SCSI_SMARTPQI=3Dm
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> CONFIG_VMWARE_PVSCSI=3Dm
> # CONFIG_XEN_SCSI_FRONTEND is not set
> CONFIG_HYPERV_STORAGE=3Dm
> CONFIG_LIBFC=3Dm
> CONFIG_LIBFCOE=3Dm
> # CONFIG_FCOE is not set
> CONFIG_FCOE_FNIC=3Dm
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> CONFIG_SCSI_ISCI=3Dm
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA_FC=3Dm
> # CONFIG_TCM_QLA2XXX is not set
> CONFIG_SCSI_QLA_ISCSI=3Dm
> CONFIG_QEDI=3Dm
> CONFIG_QEDF=3Dm
> CONFIG_SCSI_LPFC=3Dm
> # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> # CONFIG_SCSI_EFCT is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> CONFIG_SCSI_DEBUG=3Dm
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> CONFIG_SCSI_VIRTIO=3Dm
> CONFIG_SCSI_CHELSIO_FCOE=3Dm
> CONFIG_SCSI_DH=3Dy
> CONFIG_SCSI_DH_RDAC=3Dy
> CONFIG_SCSI_DH_HP_SW=3Dy
> CONFIG_SCSI_DH_EMC=3Dy
> CONFIG_SCSI_DH_ALUA=3Dy
> # end of SCSI device support
>
> CONFIG_ATA=3Dm
> CONFIG_SATA_HOST=3Dy
> CONFIG_PATA_TIMINGS=3Dy
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_FORCE=3Dy
> CONFIG_ATA_ACPI=3Dy
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=3Dy
>
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=3Dm
> CONFIG_SATA_MOBILE_LPM_POLICY=3D0
> CONFIG_SATA_AHCI_PLATFORM=3Dm
> # CONFIG_AHCI_DWC is not set
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=3Dy
>
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=3Dy
>
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=3Dm
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
>
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
>
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_RZ1000 is not set
> # CONFIG_PATA_PARPORT is not set
>
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=3Dm
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dy
> CONFIG_MD_AUTODETECT=3Dy
> CONFIG_MD_BITMAP_FILE=3Dy
> CONFIG_MD_RAID0=3Dm
> CONFIG_MD_RAID1=3Dm
> CONFIG_MD_RAID10=3Dm
> CONFIG_MD_RAID456=3Dm
> # CONFIG_MD_CLUSTER is not set
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> CONFIG_BLK_DEV_DM=3Dm
> CONFIG_DM_DEBUG=3Dy
> CONFIG_DM_BUFIO=3Dm
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=3Dm
> CONFIG_DM_PERSISTENT_DATA=3Dm
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=3Dm
> CONFIG_DM_SNAPSHOT=3Dm
> CONFIG_DM_THIN_PROVISIONING=3Dm
> CONFIG_DM_CACHE=3Dm
> CONFIG_DM_CACHE_SMQ=3Dm
> CONFIG_DM_WRITECACHE=3Dm
> # CONFIG_DM_EBS is not set
> CONFIG_DM_ERA=3Dm
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=3Dm
> CONFIG_DM_LOG_USERSPACE=3Dm
> CONFIG_DM_RAID=3Dm
> CONFIG_DM_ZERO=3Dm
> CONFIG_DM_MULTIPATH=3Dm
> CONFIG_DM_MULTIPATH_QL=3Dm
> CONFIG_DM_MULTIPATH_ST=3Dm
> CONFIG_DM_MULTIPATH_HST=3Dm
> CONFIG_DM_MULTIPATH_IOA=3Dm
> CONFIG_DM_DELAY=3Dm
> # CONFIG_DM_DUST is not set
> CONFIG_DM_UEVENT=3Dy
> CONFIG_DM_FLAKEY=3Dm
> CONFIG_DM_VERITY=3Dm
> CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=3Dy
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is not set
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_PLATFORM_KEYRING is not set
> CONFIG_DM_VERITY_FEC=3Dy
> CONFIG_DM_SWITCH=3Dm
> CONFIG_DM_LOG_WRITES=3Dm
> CONFIG_DM_INTEGRITY=3Dm
> # CONFIG_DM_ZONED is not set
> CONFIG_DM_AUDIT=3Dy
> # CONFIG_DM_VDO is not set
> CONFIG_TARGET_CORE=3Dm
> CONFIG_TCM_IBLOCK=3Dm
> CONFIG_TCM_FILEIO=3Dm
> CONFIG_TCM_PSCSI=3Dm
> CONFIG_TCM_USER2=3Dm
> CONFIG_LOOPBACK_TARGET=3Dm
> CONFIG_TCM_FC=3Dm
> CONFIG_ISCSI_TARGET=3Dm
> CONFIG_ISCSI_TARGET_CXGB4=3Dm
> # CONFIG_REMOTE_TARGET is not set
> CONFIG_FUSION=3Dy
> CONFIG_FUSION_SPI=3Dm
> # CONFIG_FUSION_FC is not set
> CONFIG_FUSION_SAS=3Dm
> CONFIG_FUSION_MAX_SGE=3D128
> # CONFIG_FUSION_CTL is not set
> CONFIG_FUSION_LOGGING=3Dy
>
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_FIREWIRE is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
>
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=3Dy
> CONFIG_MII=3Dy
> CONFIG_NET_CORE=3Dy
> CONFIG_BONDING=3Dm
> CONFIG_DUMMY=3Dm
> CONFIG_WIREGUARD=3Dm
> # CONFIG_WIREGUARD_DEBUG is not set
> # CONFIG_EQUALIZER is not set
> CONFIG_NET_FC=3Dy
> CONFIG_IFB=3Dm
> CONFIG_NET_TEAM=3Dm
> CONFIG_NET_TEAM_MODE_BROADCAST=3Dm
> CONFIG_NET_TEAM_MODE_ROUNDROBIN=3Dm
> CONFIG_NET_TEAM_MODE_RANDOM=3Dm
> CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=3Dm
> CONFIG_NET_TEAM_MODE_LOADBALANCE=3Dm
> CONFIG_MACVLAN=3Dm
> CONFIG_MACVTAP=3Dm
> CONFIG_IPVLAN_L3S=3Dy
> CONFIG_IPVLAN=3Dm
> CONFIG_IPVTAP=3Dm
> CONFIG_VXLAN=3Dm
> CONFIG_GENEVE=3Dm
> CONFIG_BAREUDP=3Dm
> # CONFIG_GTP is not set
> # CONFIG_PFCP is not set
> CONFIG_AMT=3Dm
> CONFIG_MACSEC=3Dm
> CONFIG_NETCONSOLE=3Dm
> CONFIG_NETCONSOLE_DYNAMIC=3Dy
> # CONFIG_NETCONSOLE_EXTENDED_LOG is not set
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_NTB_NETDEV=3Dm
> CONFIG_TUN=3Dm
> CONFIG_TAP=3Dm
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=3Dm
> CONFIG_VIRTIO_NET=3Dm
> CONFIG_NLMON=3Dm
> CONFIG_NETKIT=3Dy
> CONFIG_NET_VRF=3Dm
> CONFIG_VSOCKMON=3Dm
> CONFIG_MHI_NET=3Dm
> # CONFIG_ARCNET is not set
> # CONFIG_ATM_DRIVERS is not set
> CONFIG_ETHERNET=3Dy
> CONFIG_MDIO=3Dy
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_VENDOR_ADAPTEC is not set
> # CONFIG_NET_VENDOR_AGERE is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> # CONFIG_NET_VENDOR_ALTEON is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=3Dy
> CONFIG_ENA_ETHERNET=3Dm
> CONFIG_NET_VENDOR_AMD=3Dy
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_PCNET32 is not set
> CONFIG_AMD_XGBE=3Dm
> # CONFIG_AMD_XGBE_DCB is not set
> CONFIG_AMD_XGBE_HAVE_ECC=3Dy
> # CONFIG_PDS_CORE is not set
> CONFIG_NET_VENDOR_AQUANTIA=3Dy
> CONFIG_AQTION=3Dm
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ASIX=3Dy
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=3Dy
> CONFIG_ATL2=3Dm
> CONFIG_ATL1=3Dm
> CONFIG_ATL1E=3Dm
> CONFIG_ATL1C=3Dm
> CONFIG_ALX=3Dm
> # CONFIG_CX_ECAT is not set
> CONFIG_NET_VENDOR_BROADCOM=3Dy
> # CONFIG_B44 is not set
> CONFIG_BCMGENET=3Dm
> CONFIG_BNX2=3Dm
> CONFIG_CNIC=3Dm
> CONFIG_TIGON3=3Dm
> CONFIG_TIGON3_HWMON=3Dy
> CONFIG_BNX2X=3Dm
> CONFIG_BNX2X_SRIOV=3Dy
> # CONFIG_SYSTEMPORT is not set
> CONFIG_BNXT=3Dm
> CONFIG_BNXT_SRIOV=3Dy
> CONFIG_BNXT_FLOWER_OFFLOAD=3Dy
> CONFIG_BNXT_DCB=3Dy
> # CONFIG_BNXT_HWMON is not set
> # CONFIG_NET_VENDOR_CADENCE is not set
> # CONFIG_NET_VENDOR_CAVIUM is not set
> CONFIG_NET_VENDOR_CHELSIO=3Dy
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> CONFIG_CHELSIO_T4=3Dm
> # CONFIG_CHELSIO_T4_DCB is not set
> CONFIG_CHELSIO_T4VF=3Dm
> CONFIG_CHELSIO_LIB=3Dm
> CONFIG_CHELSIO_INLINE_CRYPTO=3Dy
> CONFIG_CHELSIO_IPSEC_INLINE=3Dm
> CONFIG_CHELSIO_TLS_DEVICE=3Dm
> CONFIG_NET_VENDOR_CISCO=3Dy
> CONFIG_ENIC=3Dm
> # CONFIG_NET_VENDOR_CORTINA is not set
> CONFIG_NET_VENDOR_DAVICOM=3Dy
> # CONFIG_DM9051 is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=3Dy
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=3Dy
> CONFIG_DL2K=3Dm
> CONFIG_NET_VENDOR_EMULEX=3Dy
> CONFIG_BE2NET=3Dm
> CONFIG_BE2NET_HWMON=3Dy
> # CONFIG_BE2NET_BE2 is not set
> # CONFIG_BE2NET_BE3 is not set
> CONFIG_BE2NET_LANCER=3Dy
> CONFIG_BE2NET_SKYHAWK=3Dy
> CONFIG_NET_VENDOR_ENGLEDER=3Dy
> # CONFIG_TSNEP is not set
> # CONFIG_NET_VENDOR_EZCHIP is not set
> CONFIG_NET_VENDOR_FUNGIBLE=3Dy
> # CONFIG_FUN_ETH is not set
> CONFIG_NET_VENDOR_GOOGLE=3Dy
> CONFIG_GVE=3Dm
> CONFIG_NET_VENDOR_HISILICON=3Dy
> # CONFIG_HIBMCGE is not set
> CONFIG_NET_VENDOR_HUAWEI=3Dy
> CONFIG_HINIC=3Dm
> # CONFIG_NET_VENDOR_I825XX is not set
> CONFIG_NET_VENDOR_INTEL=3Dy
> CONFIG_LIBETH=3Dy
> CONFIG_LIBIE=3Dy
> # CONFIG_E100 is not set
> CONFIG_E1000=3Dy
> CONFIG_E1000E=3Dy
> CONFIG_E1000E_HWTS=3Dy
> CONFIG_IGB=3Dy
> CONFIG_IGB_HWMON=3Dy
> CONFIG_IGBVF=3Dm
> CONFIG_IXGBE=3Dy
> CONFIG_IXGBE_HWMON=3Dy
> CONFIG_IXGBE_DCB=3Dy
> CONFIG_IXGBE_IPSEC=3Dy
> CONFIG_IXGBEVF=3Dm
> CONFIG_IXGBEVF_IPSEC=3Dy
> CONFIG_I40E=3Dy
> CONFIG_I40E_DCB=3Dy
> CONFIG_IAVF=3Dm
> CONFIG_I40EVF=3Dm
> CONFIG_ICE=3Dm
> CONFIG_ICE_HWMON=3Dy
> CONFIG_ICE_SWITCHDEV=3Dy
> CONFIG_ICE_HWTS=3Dy
> CONFIG_FM10K=3Dm
> CONFIG_IGC=3Dy
> CONFIG_IDPF=3Dm
> # CONFIG_IDPF_SINGLEQ is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_ADI=3Dy
> # CONFIG_ADIN1110 is not set
> CONFIG_NET_VENDOR_LITEX=3Dy
> CONFIG_NET_VENDOR_MARVELL=3Dy
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_OCTEON_EP=3Dm
> # CONFIG_OCTEON_EP_VF is not set
> # CONFIG_PRESTERA is not set
> CONFIG_NET_VENDOR_MELLANOX=3Dy
> CONFIG_MLX4_EN=3Dm
> CONFIG_MLX4_EN_DCB=3Dy
> CONFIG_MLX4_CORE=3Dm
> CONFIG_MLX4_DEBUG=3Dy
> # CONFIG_MLX4_CORE_GEN2 is not set
> CONFIG_MLX5_CORE=3Dm
> CONFIG_MLX5_FPGA=3Dy
> CONFIG_MLX5_CORE_EN=3Dy
> CONFIG_MLX5_EN_ARFS=3Dy
> CONFIG_MLX5_EN_RXNFC=3Dy
> CONFIG_MLX5_MPFS=3Dy
> CONFIG_MLX5_ESWITCH=3Dy
> CONFIG_MLX5_BRIDGE=3Dy
> CONFIG_MLX5_CLS_ACT=3Dy
> CONFIG_MLX5_TC_CT=3Dy
> CONFIG_MLX5_TC_SAMPLE=3Dy
> CONFIG_MLX5_CORE_EN_DCB=3Dy
> CONFIG_MLX5_CORE_IPOIB=3Dy
> # CONFIG_MLX5_MACSEC is not set
> CONFIG_MLX5_EN_IPSEC=3Dy
> CONFIG_MLX5_EN_TLS=3Dy
> CONFIG_MLX5_SW_STEERING=3Dy
> CONFIG_MLX5_HW_STEERING=3Dy
> CONFIG_MLX5_SF=3Dy
> CONFIG_MLX5_SF_MANAGER=3Dy
> # CONFIG_MLX5_DPLL is not set
> CONFIG_MLXSW_CORE=3Dm
> CONFIG_MLXSW_CORE_HWMON=3Dy
> CONFIG_MLXSW_CORE_THERMAL=3Dy
> CONFIG_MLXSW_PCI=3Dm
> CONFIG_MLXSW_I2C=3Dm
> CONFIG_MLXSW_SPECTRUM=3Dm
> CONFIG_MLXSW_SPECTRUM_DCB=3Dy
> CONFIG_MLXSW_MINIMAL=3Dm
> CONFIG_MLXFW=3Dm
> CONFIG_NET_VENDOR_META=3Dy
> # CONFIG_FBNIC is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> CONFIG_NET_VENDOR_MICROSOFT=3Dy
> CONFIG_MICROSOFT_MANA=3Dm
> CONFIG_NET_VENDOR_MYRI=3Dy
> CONFIG_MYRI10GE=3Dm
> CONFIG_MYRI10GE_DCA=3Dy
> # CONFIG_FEALNX is not set
> # CONFIG_NET_VENDOR_NI is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> # CONFIG_NET_VENDOR_NETERION is not set
> CONFIG_NET_VENDOR_NETRONOME=3Dy
> CONFIG_NFP=3Dm
> CONFIG_NFP_APP_FLOWER=3Dy
> CONFIG_NFP_APP_ABM_NIC=3Dy
> CONFIG_NFP_NET_IPSEC=3Dy
> # CONFIG_NFP_DEBUG is not set
> # CONFIG_NET_VENDOR_NVIDIA is not set
> CONFIG_NET_VENDOR_OKI=3Dy
> # CONFIG_ETHOC is not set
> # CONFIG_OA_TC6 is not set
> # CONFIG_NET_VENDOR_PACKET_ENGINES is not set
> CONFIG_NET_VENDOR_PENSANDO=3Dy
> CONFIG_IONIC=3Dm
> CONFIG_NET_VENDOR_QLOGIC=3Dy
> CONFIG_QLA3XXX=3Dm
> # CONFIG_QLCNIC is not set
> CONFIG_NETXEN_NIC=3Dm
> CONFIG_QED=3Dm
> CONFIG_QED_LL2=3Dy
> CONFIG_QED_SRIOV=3Dy
> CONFIG_QEDE=3Dm
> CONFIG_QED_RDMA=3Dy
> CONFIG_QED_ISCSI=3Dy
> CONFIG_QED_FCOE=3Dy
> CONFIG_QED_OOO=3Dy
> CONFIG_NET_VENDOR_BROCADE=3Dy
> # CONFIG_BNA is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RDC is not set
> CONFIG_NET_VENDOR_REALTEK=3Dy
> # CONFIG_ATP is not set
> CONFIG_8139CP=3Dm
> CONFIG_8139TOO=3Dm
> # CONFIG_8139TOO_PIO is not set
> # CONFIG_8139TOO_TUNE_TWISTER is not set
> CONFIG_8139TOO_8129=3Dy
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_R8169=3Dy
> # CONFIG_RTASE is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> CONFIG_NET_VENDOR_ROCKER=3Dy
> CONFIG_ROCKER=3Dm
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> # CONFIG_NET_VENDOR_SIS is not set
> CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> CONFIG_SFC=3Dm
> CONFIG_SFC_MTD=3Dy
> CONFIG_SFC_MCDI_MON=3Dy
> CONFIG_SFC_SRIOV=3Dy
> CONFIG_SFC_MCDI_LOGGING=3Dy
> # CONFIG_SFC_FALCON is not set
> CONFIG_SFC_SIENA=3Dm
> CONFIG_SFC_SIENA_MTD=3Dy
> CONFIG_SFC_SIENA_MCDI_MON=3Dy
> CONFIG_SFC_SIENA_SRIOV=3Dy
> CONFIG_SFC_SIENA_MCDI_LOGGING=3Dy
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> CONFIG_NET_VENDOR_STMICRO=3Dy
> CONFIG_STMMAC_ETH=3Dm
> # CONFIG_STMMAC_SELFTESTS is not set
> # CONFIG_STMMAC_PLATFORM is not set
> CONFIG_DWMAC_INTEL=3Dm
> # CONFIG_STMMAC_PCI is not set
> # CONFIG_NET_VENDOR_SUN is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_TEHUTI is not set
> # CONFIG_NET_VENDOR_TI is not set
> CONFIG_NET_VENDOR_VERTEXCOM=3Dy
> # CONFIG_MSE102X is not set
> # CONFIG_NET_VENDOR_VIA is not set
> CONFIG_NET_VENDOR_WANGXUN=3Dy
> # CONFIG_NGBE is not set
> # CONFIG_TXGBE is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> # CONFIG_NET_VENDOR_XILINX is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> CONFIG_PHYLINK=3Dy
> CONFIG_PHYLIB=3Dy
> CONFIG_SWPHY=3Dy
> CONFIG_LED_TRIGGER_PHY=3Dy
> CONFIG_FIXED_PHY=3Dy
> # CONFIG_SFP is not set
>
> #
> # MII PHY device drivers
> #
> # CONFIG_AIR_EN8811H_PHY is not set
> CONFIG_AMD_PHY=3Dm
> # CONFIG_ADIN_PHY is not set
> # CONFIG_ADIN1100_PHY is not set
> CONFIG_AQUANTIA_PHY=3Dm
> CONFIG_AX88796B_PHY=3Dy
> CONFIG_BROADCOM_PHY=3Dm
> # CONFIG_BCM54140_PHY is not set
> CONFIG_BCM7XXX_PHY=3Dm
> # CONFIG_BCM84881_PHY is not set
> CONFIG_BCM87XX_PHY=3Dm
> CONFIG_BCM_NET_PHYLIB=3Dm
> CONFIG_BCM_NET_PHYPTP=3Dm
> CONFIG_CICADA_PHY=3Dm
> CONFIG_CORTINA_PHY=3Dm
> CONFIG_DAVICOM_PHY=3Dm
> CONFIG_ICPLUS_PHY=3Dm
> CONFIG_LXT_PHY=3Dm
> CONFIG_INTEL_XWAY_PHY=3Dm
> CONFIG_LSI_ET1011C_PHY=3Dm
> CONFIG_MARVELL_PHY=3Dm
> CONFIG_MARVELL_10G_PHY=3Dm
> CONFIG_MARVELL_88Q2XXX_PHY=3Dm
> # CONFIG_MARVELL_88X2222_PHY is not set
> CONFIG_MAXLINEAR_GPHY=3Dm
> # CONFIG_MEDIATEK_GE_PHY is not set
> CONFIG_MICREL_PHY=3Dm
> # CONFIG_MICROCHIP_T1S_PHY is not set
> CONFIG_MICROCHIP_PHY=3Dm
> CONFIG_MICROCHIP_T1_PHY=3Dm
> CONFIG_MICROSEMI_PHY=3Dm
> # CONFIG_MOTORCOMM_PHY is not set
> CONFIG_NATIONAL_PHY=3Dm
> # CONFIG_NXP_CBTX_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_NCN26000_PHY is not set
> # CONFIG_QCA83XX_PHY is not set
> # CONFIG_QCA808X_PHY is not set
> CONFIG_QSEMI_PHY=3Dm
> CONFIG_REALTEK_PHY=3Dy
> CONFIG_RENESAS_PHY=3Dm
> CONFIG_ROCKCHIP_PHY=3Dm
> CONFIG_SMSC_PHY=3Dm
> CONFIG_STE10XP=3Dm
> CONFIG_TERANETICS_PHY=3Dm
> CONFIG_DP83822_PHY=3Dm
> CONFIG_DP83TC811_PHY=3Dm
> CONFIG_DP83848_PHY=3Dm
> CONFIG_DP83867_PHY=3Dm
> # CONFIG_DP83869_PHY is not set
> # CONFIG_DP83TD510_PHY is not set
> # CONFIG_DP83TG720_PHY is not set
> CONFIG_VITESSE_PHY=3Dm
> CONFIG_XILINX_GMII2RGMII=3Dm
> CONFIG_MICREL_KS8995MA=3Dm
> CONFIG_CAN_DEV=3Dm
> CONFIG_CAN_VCAN=3Dm
> CONFIG_CAN_VXCAN=3Dm
> CONFIG_CAN_NETLINK=3Dy
> CONFIG_CAN_CALC_BITTIMING=3Dy
> CONFIG_CAN_RX_OFFLOAD=3Dy
> # CONFIG_CAN_CAN327 is not set
> # CONFIG_CAN_KVASER_PCIEFD is not set
> CONFIG_CAN_SLCAN=3Dm
> # CONFIG_CAN_C_CAN is not set
> # CONFIG_CAN_CC770 is not set
> # CONFIG_CAN_CTUCANFD_PCI is not set
> # CONFIG_CAN_ESD_402_PCI is not set
> # CONFIG_CAN_IFI_CANFD is not set
> CONFIG_CAN_M_CAN=3Dm
> CONFIG_CAN_M_CAN_PCI=3Dm
> # CONFIG_CAN_M_CAN_PLATFORM is not set
> # CONFIG_CAN_M_CAN_TCAN4X5X is not set
> CONFIG_CAN_PEAK_PCIEFD=3Dm
> # CONFIG_CAN_SJA1000 is not set
> # CONFIG_CAN_SOFTING is not set
>
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> CONFIG_CAN_MCP251X=3Dm
> CONFIG_CAN_MCP251XFD=3Dm
> # CONFIG_CAN_MCP251XFD_SANITY is not set
> # end of CAN SPI interfaces
>
> #
> # CAN USB interfaces
> #
> CONFIG_CAN_8DEV_USB=3Dm
> CONFIG_CAN_EMS_USB=3Dm
> # CONFIG_CAN_ESD_USB is not set
> # CONFIG_CAN_ETAS_ES58X is not set
> # CONFIG_CAN_F81604 is not set
> # CONFIG_CAN_GS_USB is not set
> CONFIG_CAN_KVASER_USB=3Dm
> # CONFIG_CAN_MCBA_USB is not set
> CONFIG_CAN_PEAK_USB=3Dm
> # CONFIG_CAN_UCAN is not set
> # end of CAN USB interfaces
>
> # CONFIG_CAN_DEBUG_DEVICES is not set
> CONFIG_MDIO_DEVICE=3Dy
> CONFIG_MDIO_BUS=3Dy
> CONFIG_FWNODE_MDIO=3Dy
> CONFIG_ACPI_MDIO=3Dy
> CONFIG_MDIO_DEVRES=3Dy
> CONFIG_MDIO_BITBANG=3Dm
> CONFIG_MDIO_BCM_UNIMAC=3Dm
> CONFIG_MDIO_CAVIUM=3Dm
> # CONFIG_MDIO_GPIO is not set
> # CONFIG_MDIO_MVUSB is not set
> CONFIG_MDIO_THUNDER=3Dm
>
> #
> # MDIO Multiplexers
> #
>
> #
> # PCS device drivers
> #
> CONFIG_PCS_XPCS=3Dm
> # end of PCS device drivers
>
> # CONFIG_PLIP is not set
> CONFIG_PPP=3Dm
> CONFIG_PPP_BSDCOMP=3Dm
> CONFIG_PPP_DEFLATE=3Dm
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_MPPE=3Dm
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPPOATM=3Dm
> CONFIG_PPPOE=3Dm
> # CONFIG_PPPOE_HASH_BITS_1 is not set
> # CONFIG_PPPOE_HASH_BITS_2 is not set
> CONFIG_PPPOE_HASH_BITS_4=3Dy
> # CONFIG_PPPOE_HASH_BITS_8 is not set
> CONFIG_PPPOE_HASH_BITS=3D4
> CONFIG_PPTP=3Dm
> CONFIG_PPPOL2TP=3Dm
> CONFIG_PPP_ASYNC=3Dm
> CONFIG_PPP_SYNC_TTY=3Dm
> CONFIG_SLIP=3Dm
> CONFIG_SLHC=3Dm
> CONFIG_SLIP_COMPRESSED=3Dy
> CONFIG_SLIP_SMART=3Dy
> # CONFIG_SLIP_MODE_SLIP6 is not set
> CONFIG_USB_NET_DRIVERS=3Dy
> CONFIG_USB_CATC=3Dm
> CONFIG_USB_KAWETH=3Dm
> CONFIG_USB_PEGASUS=3Dm
> CONFIG_USB_RTL8150=3Dm
> CONFIG_USB_RTL8152=3Dy
> CONFIG_USB_LAN78XX=3Dm
> CONFIG_USB_USBNET=3Dy
> CONFIG_USB_NET_AX8817X=3Dy
> CONFIG_USB_NET_AX88179_178A=3Dy
> CONFIG_USB_NET_CDCETHER=3Dm
> CONFIG_USB_NET_CDC_EEM=3Dm
> CONFIG_USB_NET_CDC_NCM=3Dm
> CONFIG_USB_NET_HUAWEI_CDC_NCM=3Dm
> CONFIG_USB_NET_CDC_MBIM=3Dm
> CONFIG_USB_NET_DM9601=3Dm
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> CONFIG_USB_NET_SMSC75XX=3Dm
> CONFIG_USB_NET_SMSC95XX=3Dm
> CONFIG_USB_NET_GL620A=3Dm
> CONFIG_USB_NET_NET1080=3Dm
> CONFIG_USB_NET_PLUSB=3Dm
> CONFIG_USB_NET_MCS7830=3Dm
> CONFIG_USB_NET_RNDIS_HOST=3Dm
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dm
> CONFIG_USB_NET_CDC_SUBSET=3Dm
> CONFIG_USB_ALI_M5632=3Dy
> CONFIG_USB_AN2720=3Dy
> CONFIG_USB_BELKIN=3Dy
> CONFIG_USB_ARMLINUX=3Dy
> CONFIG_USB_EPSON2888=3Dy
> CONFIG_USB_KC2190=3Dy
> CONFIG_USB_NET_ZAURUS=3Dm
> CONFIG_USB_NET_CX82310_ETH=3Dm
> CONFIG_USB_NET_KALMIA=3Dm
> CONFIG_USB_NET_QMI_WWAN=3Dm
> CONFIG_USB_HSO=3Dm
> CONFIG_USB_NET_INT51X1=3Dm
> CONFIG_USB_IPHETH=3Dm
> CONFIG_USB_SIERRA_NET=3Dm
> CONFIG_USB_VL600=3Dm
> CONFIG_USB_NET_CH9200=3Dm
> # CONFIG_USB_NET_AQC111 is not set
> CONFIG_USB_RTL8153_ECM=3Dm
> CONFIG_WLAN=3Dy
> # CONFIG_WLAN_VENDOR_ADMTEK is not set
> CONFIG_ATH_COMMON=3Dm
> CONFIG_WLAN_VENDOR_ATH=3Dy
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_ATH9K_HW=3Dm
> CONFIG_ATH9K_COMMON=3Dm
> CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
> CONFIG_ATH9K=3Dm
> CONFIG_ATH9K_PCI=3Dy
> CONFIG_ATH9K_AHB=3Dy
> # CONFIG_ATH9K_DYNACK is not set
> CONFIG_ATH9K_WOW=3Dy
> CONFIG_ATH9K_RFKILL=3Dy
> # CONFIG_ATH9K_CHANNEL_CONTEXT is not set
> CONFIG_ATH9K_PCOEM=3Dy
> # CONFIG_ATH9K_PCI_NO_EEPROM is not set
> CONFIG_ATH9K_HTC=3Dm
> # CONFIG_ATH9K_HTC_DEBUGFS is not set
> # CONFIG_ATH9K_HWRNG is not set
> # CONFIG_CARL9170 is not set
> # CONFIG_ATH6KL is not set
> # CONFIG_AR5523 is not set
> # CONFIG_WIL6210 is not set
> CONFIG_ATH10K=3Dm
> CONFIG_ATH10K_CE=3Dy
> CONFIG_ATH10K_PCI=3Dm
> # CONFIG_ATH10K_SDIO is not set
> # CONFIG_ATH10K_USB is not set
> # CONFIG_ATH10K_DEBUG is not set
> CONFIG_ATH10K_DEBUGFS=3Dy
> CONFIG_ATH10K_LEDS=3Dy
> # CONFIG_ATH10K_SPECTRAL is not set
> # CONFIG_ATH10K_TRACING is not set
> # CONFIG_WCN36XX is not set
> CONFIG_ATH11K=3Dm
> CONFIG_ATH11K_PCI=3Dm
> # CONFIG_ATH11K_DEBUG is not set
> # CONFIG_ATH11K_TRACING is not set
> # CONFIG_ATH12K is not set
> # CONFIG_WLAN_VENDOR_ATMEL is not set
> CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> # CONFIG_B43 is not set
> # CONFIG_B43LEGACY is not set
> CONFIG_BRCMUTIL=3Dm
> CONFIG_BRCMSMAC=3Dm
> CONFIG_BRCMSMAC_LEDS=3Dy
> CONFIG_BRCMFMAC=3Dm
> CONFIG_BRCMFMAC_PROTO_BCDC=3Dy
> CONFIG_BRCMFMAC_PROTO_MSGBUF=3Dy
> CONFIG_BRCMFMAC_SDIO=3Dy
> CONFIG_BRCMFMAC_USB=3Dy
> CONFIG_BRCMFMAC_PCIE=3Dy
> # CONFIG_BRCM_TRACING is not set
> # CONFIG_BRCMDBG is not set
> CONFIG_WLAN_VENDOR_INTEL=3Dy
> # CONFIG_IPW2100 is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_IWL4965 is not set
> # CONFIG_IWL3945 is not set
> CONFIG_IWLWIFI=3Dm
> CONFIG_IWLWIFI_LEDS=3Dy
> CONFIG_IWLDVM=3Dm
> CONFIG_IWLMVM=3Dm
> CONFIG_IWLWIFI_OPMODE_MODULAR=3Dy
>
> #
> # Debugging Options
> #
> # CONFIG_IWLWIFI_DEBUG is not set
> # CONFIG_IWLWIFI_DEVICE_TRACING is not set
> # end of Debugging Options
>
> # CONFIG_WLAN_VENDOR_INTERSIL is not set
> CONFIG_WLAN_VENDOR_MARVELL=3Dy
> # CONFIG_LIBERTAS is not set
> # CONFIG_LIBERTAS_THINFIRM is not set
> CONFIG_MWIFIEX=3Dm
> CONFIG_MWIFIEX_SDIO=3Dm
> CONFIG_MWIFIEX_PCIE=3Dm
> CONFIG_MWIFIEX_USB=3Dm
> # CONFIG_MWL8K is not set
> CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
> CONFIG_MT7601U=3Dm
> CONFIG_MT76_CORE=3Dm
> CONFIG_MT76_LEDS=3Dy
> CONFIG_MT76_USB=3Dm
> CONFIG_MT76x02_LIB=3Dm
> CONFIG_MT76x02_USB=3Dm
> CONFIG_MT76_CONNAC_LIB=3Dm
> CONFIG_MT792x_LIB=3Dm
> CONFIG_MT76x0_COMMON=3Dm
> CONFIG_MT76x0U=3Dm
> CONFIG_MT76x0E=3Dm
> CONFIG_MT76x2_COMMON=3Dm
> CONFIG_MT76x2E=3Dm
> CONFIG_MT76x2U=3Dm
> # CONFIG_MT7603E is not set
> # CONFIG_MT7615E is not set
> # CONFIG_MT7663U is not set
> # CONFIG_MT7663S is not set
> # CONFIG_MT7915E is not set
> CONFIG_MT7921_COMMON=3Dm
> CONFIG_MT7921E=3Dm
> # CONFIG_MT7921S is not set
> # CONFIG_MT7921U is not set
> # CONFIG_MT7996E is not set
> CONFIG_MT7925_COMMON=3Dm
> CONFIG_MT7925E=3Dm
> # CONFIG_MT7925U is not set
> CONFIG_WLAN_VENDOR_MICROCHIP=3Dy
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> CONFIG_WLAN_VENDOR_PURELIFI=3Dy
> # CONFIG_PLFXLC is not set
> CONFIG_WLAN_VENDOR_RALINK=3Dy
> CONFIG_RT2X00=3Dm
> # CONFIG_RT2400PCI is not set
> # CONFIG_RT2500PCI is not set
> # CONFIG_RT61PCI is not set
> CONFIG_RT2800PCI=3Dm
> CONFIG_RT2800PCI_RT33XX=3Dy
> CONFIG_RT2800PCI_RT35XX=3Dy
> CONFIG_RT2800PCI_RT53XX=3Dy
> CONFIG_RT2800PCI_RT3290=3Dy
> # CONFIG_RT2500USB is not set
> # CONFIG_RT73USB is not set
> CONFIG_RT2800USB=3Dm
> CONFIG_RT2800USB_RT33XX=3Dy
> CONFIG_RT2800USB_RT35XX=3Dy
> CONFIG_RT2800USB_RT3573=3Dy
> CONFIG_RT2800USB_RT53XX=3Dy
> CONFIG_RT2800USB_RT55XX=3Dy
> CONFIG_RT2800USB_UNKNOWN=3Dy
> CONFIG_RT2800_LIB=3Dm
> CONFIG_RT2800_LIB_MMIO=3Dm
> CONFIG_RT2X00_LIB_MMIO=3Dm
> CONFIG_RT2X00_LIB_PCI=3Dm
> CONFIG_RT2X00_LIB_USB=3Dm
> CONFIG_RT2X00_LIB=3Dm
> CONFIG_RT2X00_LIB_FIRMWARE=3Dy
> CONFIG_RT2X00_LIB_CRYPTO=3Dy
> CONFIG_RT2X00_LIB_LEDS=3Dy
> # CONFIG_RT2X00_DEBUG is not set
> CONFIG_WLAN_VENDOR_REALTEK=3Dy
> # CONFIG_RTL8180 is not set
> # CONFIG_RTL8187 is not set
> CONFIG_RTL_CARDS=3Dm
> CONFIG_RTL8192CE=3Dm
> CONFIG_RTL8192SE=3Dm
> CONFIG_RTL8192DE=3Dm
> CONFIG_RTL8723AE=3Dm
> CONFIG_RTL8723BE=3Dm
> CONFIG_RTL8188EE=3Dm
> CONFIG_RTL8192EE=3Dm
> CONFIG_RTL8821AE=3Dm
> CONFIG_RTL8192CU=3Dm
> # CONFIG_RTL8192DU is not set
> CONFIG_RTLWIFI=3Dm
> CONFIG_RTLWIFI_PCI=3Dm
> CONFIG_RTLWIFI_USB=3Dm
> # CONFIG_RTLWIFI_DEBUG is not set
> CONFIG_RTL8192C_COMMON=3Dm
> CONFIG_RTL8192D_COMMON=3Dm
> CONFIG_RTL8723_COMMON=3Dm
> CONFIG_RTLBTCOEXIST=3Dm
> CONFIG_RTL8XXXU=3Dm
> # CONFIG_RTL8XXXU_UNTESTED is not set
> CONFIG_RTW88=3Dm
> CONFIG_RTW88_CORE=3Dm
> CONFIG_RTW88_PCI=3Dm
> CONFIG_RTW88_8822B=3Dm
> CONFIG_RTW88_8822C=3Dm
> CONFIG_RTW88_8723X=3Dm
> CONFIG_RTW88_8723D=3Dm
> CONFIG_RTW88_8821C=3Dm
> CONFIG_RTW88_8822BE=3Dm
> # CONFIG_RTW88_8822BS is not set
> # CONFIG_RTW88_8822BU is not set
> CONFIG_RTW88_8822CE=3Dm
> # CONFIG_RTW88_8822CS is not set
> # CONFIG_RTW88_8822CU is not set
> CONFIG_RTW88_8723DE=3Dm
> # CONFIG_RTW88_8723DS is not set
> # CONFIG_RTW88_8723CS is not set
> # CONFIG_RTW88_8723DU is not set
> CONFIG_RTW88_8821CE=3Dm
> # CONFIG_RTW88_8821CS is not set
> # CONFIG_RTW88_8821CU is not set
> # CONFIG_RTW88_8821AU is not set
> # CONFIG_RTW88_8812AU is not set
> # CONFIG_RTW88_DEBUG is not set
> # CONFIG_RTW88_DEBUGFS is not set
> CONFIG_RTW89=3Dm
> CONFIG_RTW89_CORE=3Dm
> CONFIG_RTW89_PCI=3Dm
> CONFIG_RTW89_8852A=3Dm
> CONFIG_RTW89_8852B_COMMON=3Dm
> CONFIG_RTW89_8852B=3Dm
> CONFIG_RTW89_8852C=3Dm
> # CONFIG_RTW89_8851BE is not set
> CONFIG_RTW89_8852AE=3Dm
> CONFIG_RTW89_8852BE=3Dm
> # CONFIG_RTW89_8852BTE is not set
> CONFIG_RTW89_8852CE=3Dm
> # CONFIG_RTW89_8922AE is not set
> # CONFIG_RTW89_DEBUGMSG is not set
> # CONFIG_RTW89_DEBUGFS is not set
> # CONFIG_WLAN_VENDOR_RSI is not set
> CONFIG_WLAN_VENDOR_SILABS=3Dy
> # CONFIG_WFX is not set
> # CONFIG_WLAN_VENDOR_ST is not set
> # CONFIG_WLAN_VENDOR_TI is not set
> # CONFIG_WLAN_VENDOR_ZYDAS is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
> # CONFIG_QTNFMAC_PCIE is not set
> CONFIG_MAC80211_HWSIM=3Dm
> # CONFIG_VIRT_WIFI is not set
> CONFIG_WAN=3Dy
> CONFIG_HDLC=3Dm
> CONFIG_HDLC_RAW=3Dm
> # CONFIG_HDLC_RAW_ETH is not set
> CONFIG_HDLC_CISCO=3Dm
> CONFIG_HDLC_FR=3Dm
> CONFIG_HDLC_PPP=3Dm
>
> #
> # X.25/LAPB support is disabled
> #
> # CONFIG_FRAMER is not set
> # CONFIG_PCI200SYN is not set
> # CONFIG_WANXL is not set
> # CONFIG_PC300TOO is not set
> # CONFIG_FARSYNC is not set
> CONFIG_IEEE802154_DRIVERS=3Dm
> CONFIG_IEEE802154_FAKELB=3Dm
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> # CONFIG_IEEE802154_ATUSB is not set
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> # CONFIG_IEEE802154_HWSIM is not set
>
> #
> # Wireless WAN
> #
> CONFIG_WWAN=3Dy
> CONFIG_WWAN_DEBUGFS=3Dy
> CONFIG_WWAN_HWSIM=3Dm
> CONFIG_MHI_WWAN_CTRL=3Dm
> CONFIG_MHI_WWAN_MBIM=3Dm
> CONFIG_IOSM=3Dm
> CONFIG_MTK_T7XX=3Dm
> # end of Wireless WAN
>
> CONFIG_XEN_NETDEV_FRONTEND=3Dm
> CONFIG_VMXNET3=3Dm
> CONFIG_FUJITSU_ES=3Dm
> CONFIG_USB4_NET=3Dm
> CONFIG_HYPERV_NET=3Dm
> CONFIG_NETDEVSIM=3Dm
> CONFIG_NET_FAILOVER=3Dm
> # CONFIG_ISDN is not set
>
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_LEDS=3Dy
> CONFIG_INPUT_FF_MEMLESS=3Dy
> CONFIG_INPUT_SPARSEKMAP=3Dm
> # CONFIG_INPUT_MATRIXKMAP is not set
> CONFIG_INPUT_VIVALDIFMAP=3Dy
>
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_JOYDEV=3Dm
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_PS2_ALPS=3Dy
> CONFIG_MOUSE_PS2_BYD=3Dy
> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> CONFIG_MOUSE_PS2_CYPRESS=3Dy
> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> CONFIG_MOUSE_PS2_ELANTECH=3Dy
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
> CONFIG_MOUSE_PS2_SENTELIC=3Dy
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> CONFIG_MOUSE_PS2_VMMOUSE=3Dy
> CONFIG_MOUSE_PS2_SMBUS=3Dy
> CONFIG_MOUSE_SERIAL=3Dm
> CONFIG_MOUSE_APPLETOUCH=3Dm
> CONFIG_MOUSE_BCM5974=3Dm
> CONFIG_MOUSE_CYAPA=3Dm
> CONFIG_MOUSE_ELAN_I2C=3Dm
> CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
> CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
> CONFIG_MOUSE_VSXXXAA=3Dm
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
> CONFIG_MOUSE_SYNAPTICS_USB=3Dm
> # CONFIG_INPUT_JOYSTICK is not set
> CONFIG_INPUT_TABLET=3Dy
> CONFIG_TABLET_USB_ACECAD=3Dm
> CONFIG_TABLET_USB_AIPTEK=3Dm
> # CONFIG_TABLET_USB_HANWANG is not set
> CONFIG_TABLET_USB_KBTAB=3Dm
> # CONFIG_TABLET_USB_PEGASUS is not set
> CONFIG_TABLET_SERIAL_WACOM4=3Dm
> CONFIG_INPUT_TOUCHSCREEN=3Dy
> # CONFIG_TOUCHSCREEN_ADS7846 is not set
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ADC is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> # CONFIG_TOUCHSCREEN_BU21029 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP5 is not set
> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> # CONFIG_TOUCHSCREEN_EXC3000 is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> # CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C is not set
> # CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI is not set
> # CONFIG_TOUCHSCREEN_HIDEEP is not set
> # CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
> # CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_ILITEK is not set
> # CONFIG_TOUCHSCREEN_S6SY761 is not set
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> # CONFIG_TOUCHSCREEN_ELAN is not set
> CONFIG_TOUCHSCREEN_ELO=3Dm
> CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm
> CONFIG_TOUCHSCREEN_WACOM_I2C=3Dm
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> # CONFIG_TOUCHSCREEN_MSG2638 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
> # CONFIG_TOUCHSCREEN_IMAGIS is not set
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> # CONFIG_TOUCHSCREEN_WM97XX is not set
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> # CONFIG_TOUCHSCREEN_TSC2005 is not set
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> # CONFIG_TOUCHSCREEN_SUR40 is not set
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> # CONFIG_TOUCHSCREEN_SX8654 is not set
> # CONFIG_TOUCHSCREEN_TPS6507X is not set
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> # CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
> # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> # CONFIG_TOUCHSCREEN_IQS7211 is not set
> # CONFIG_TOUCHSCREEN_ZINITIX is not set
> # CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
> CONFIG_INPUT_MISC=3Dy
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> CONFIG_INPUT_PCSPKR=3Dm
> # CONFIG_INPUT_MMA8450 is not set
> CONFIG_INPUT_APANEL=3Dm
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> CONFIG_INPUT_ATLAS_BTNS=3Dm
> CONFIG_INPUT_ATI_REMOTE2=3Dm
> CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
> # CONFIG_INPUT_KXTJ9 is not set
> CONFIG_INPUT_POWERMATE=3Dm
> CONFIG_INPUT_YEALINK=3Dm
> CONFIG_INPUT_CM109=3Dm
> CONFIG_INPUT_UINPUT=3Dm
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_PWM_BEEPER is not set
> # CONFIG_INPUT_PWM_VIBRA is not set
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=3Dm
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_IQS269A is not set
> # CONFIG_INPUT_IQS626A is not set
> # CONFIG_INPUT_IQS7222 is not set
> # CONFIG_INPUT_CMA3000 is not set
> CONFIG_INPUT_XEN_KBDDEV_FRONTEND=3Dm
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> CONFIG_RMI4_CORE=3Dm
> CONFIG_RMI4_I2C=3Dm
> CONFIG_RMI4_SPI=3Dm
> CONFIG_RMI4_SMB=3Dm
> CONFIG_RMI4_F03=3Dy
> CONFIG_RMI4_F03_SERIO=3Dm
> CONFIG_RMI4_2D_SENSOR=3Dy
> CONFIG_RMI4_F11=3Dy
> CONFIG_RMI4_F12=3Dy
> CONFIG_RMI4_F30=3Dy
> CONFIG_RMI4_F34=3Dy
> CONFIG_RMI4_F3A=3Dy
> # CONFIG_RMI4_F54 is not set
> CONFIG_RMI4_F55=3Dy
>
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dm
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=3Dy
> CONFIG_SERIO_RAW=3Dm
> CONFIG_SERIO_ALTERA_PS2=3Dm
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=3Dm
> CONFIG_HYPERV_KEYBOARD=3Dm
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
>
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_VT_CONSOLE_SLEEP=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LEGACY_TIOCSTI=3Dy
> CONFIG_LDISC_AUTOLOAD=3Dy
>
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=3Dy
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_DMA=3Dy
> CONFIG_SERIAL_8250_PCILIB=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_EXAR=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> # CONFIG_SERIAL_8250_PCI1XXXX is not set
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
> CONFIG_SERIAL_8250_RSA=3Dy
> CONFIG_SERIAL_8250_DWLIB=3Dy
> CONFIG_SERIAL_8250_DW=3Dy
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=3Dm
> CONFIG_SERIAL_8250_MID=3Dy
> CONFIG_SERIAL_8250_PERICOM=3Dy
>
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_SERIAL_JSM=3Dm
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_SERIAL_ARC=3Dm
> CONFIG_SERIAL_ARC_NR_PORTS=3D1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
>
> CONFIG_SERIAL_MCTRL_GPIO=3Dy
> CONFIG_SERIAL_NONSTANDARD=3Dy
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_N_HDLC=3Dm
> CONFIG_N_GSM=3Dm
> CONFIG_NOZOMI=3Dm
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=3Dy
> CONFIG_HVC_IRQ=3Dy
> CONFIG_HVC_XEN=3Dy
> CONFIG_HVC_XEN_FRONTEND=3Dy
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_TTY_PRINTK is not set
> CONFIG_PRINTER=3Dm
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dm
> CONFIG_VIRTIO_CONSOLE=3Dm
> CONFIG_IPMI_HANDLER=3Dm
> CONFIG_IPMI_DMI_DECODE=3Dy
> CONFIG_IPMI_PLAT_DATA=3Dy
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=3Dm
> CONFIG_IPMI_SI=3Dm
> CONFIG_IPMI_SSIF=3Dm
> CONFIG_IPMI_WATCHDOG=3Dm
> CONFIG_IPMI_POWEROFF=3Dm
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
> CONFIG_HW_RANDOM_INTEL=3Dm
> CONFIG_HW_RANDOM_AMD=3Dm
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_VIA=3Dm
> CONFIG_HW_RANDOM_VIRTIO=3Dy
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=3Dy
> CONFIG_NVRAM=3Dy
> CONFIG_DEVPORT=3Dy
> CONFIG_HPET=3Dy
> CONFIG_HPET_MMAP=3Dy
> # CONFIG_HPET_MMAP_DEFAULT is not set
> CONFIG_HANGCHECK_TIMER=3Dm
> CONFIG_UV_MMTIMER=3Dm
> CONFIG_TCG_TPM=3Dy
> CONFIG_TCG_TPM2_HMAC=3Dy
> CONFIG_HW_RANDOM_TPM=3Dy
> CONFIG_TCG_TIS_CORE=3Dy
> CONFIG_TCG_TIS=3Dy
> CONFIG_TCG_TIS_SPI=3Dy
> # CONFIG_TCG_TIS_SPI_CR50 is not set
> # CONFIG_TCG_TIS_I2C is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
> # CONFIG_TCG_NSC is not set
> # CONFIG_TCG_ATMEL is not set
> # CONFIG_TCG_INFINEON is not set
> # CONFIG_TCG_XEN is not set
> CONFIG_TCG_CRB=3Dy
> CONFIG_TCG_VTPM_PROXY=3Dm
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=3Dm
> # CONFIG_XILLYBUS is not set
> # CONFIG_XILLYUSB is not set
> # end of Character devices
>
> #
> # I2C support
> #
> CONFIG_I2C=3Dy
> CONFIG_ACPI_I2C_OPREGION=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_CHARDEV=3Dm
> CONFIG_I2C_MUX=3Dm
>
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=3Dm
> # end of Multiplexer I2C Chip support
>
> CONFIG_I2C_HELPER_AUTO=3Dy
> CONFIG_I2C_SMBUS=3Dm
> CONFIG_I2C_ALGOBIT=3Dy
> CONFIG_I2C_ALGOPCA=3Dm
>
> #
> # I2C Hardware Bus support
> #
>
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> CONFIG_I2C_AMD756=3Dm
> CONFIG_I2C_AMD8111=3Dm
> # CONFIG_I2C_AMD_MP2 is not set
> # CONFIG_I2C_AMD_ASF is not set
> CONFIG_I2C_I801=3Dm
> CONFIG_I2C_ISCH=3Dm
> CONFIG_I2C_ISMT=3Dm
> CONFIG_I2C_PIIX4=3Dm
> CONFIG_I2C_NFORCE2=3Dm
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=3Dm
> CONFIG_I2C_VIA=3Dm
> CONFIG_I2C_VIAPRO=3Dm
> # CONFIG_I2C_ZHAOXIN is not set
>
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=3Dm
>
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=3Dm
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=3Dm
> # CONFIG_I2C_DESIGNWARE_AMDPSP is not set
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=3Dm
> CONFIG_I2C_SIMTEC=3Dm
> # CONFIG_I2C_XILINX is not set
>
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=3Dm
> # CONFIG_I2C_CP2615 is not set
> CONFIG_I2C_PARPORT=3Dm
> # CONFIG_I2C_PCI1XXXX is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> CONFIG_I2C_TINY_USB=3Dm
>
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=3Dm
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
>
> CONFIG_I2C_STUB=3Dm
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
>
> # CONFIG_I3C is not set
> CONFIG_SPI=3Dy
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=3Dy
> # CONFIG_SPI_MEM is not set
>
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_CH341 is not set
> CONFIG_SPI_CS42L43=3Dm
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_LM70_LLP is not set
> # CONFIG_SPI_MICROCHIP_CORE is not set
> # CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PCI1XXXX is not set
> CONFIG_SPI_PXA2XX=3Dm
> CONFIG_SPI_PXA2XX_PCI=3Dm
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> CONFIG_SPI_AMD=3Dy
>
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
>
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=3Dy
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=3Dy
> # CONFIG_PPS_DEBUG is not set
>
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=3Dm
> CONFIG_PPS_CLIENT_PARPORT=3Dm
> CONFIG_PPS_CLIENT_GPIO=3Dm
>
> #
> # PPS generators support
> #
>
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=3Dy
> CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy
> CONFIG_DP83640_PHY=3Dm
> # CONFIG_PTP_1588_CLOCK_INES is not set
> CONFIG_PTP_1588_CLOCK_KVM=3Dm
> CONFIG_PTP_1588_CLOCK_VMCLOCK=3Dm
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_FC3W is not set
> # CONFIG_PTP_1588_CLOCK_MOCK is not set
> CONFIG_PTP_1588_CLOCK_VMW=3Dm
> # CONFIG_PTP_1588_CLOCK_OCP is not set
> # end of PTP clock support
>
> CONFIG_PINCTRL=3Dy
> CONFIG_PINMUX=3Dy
> CONFIG_PINCONF=3Dy
> CONFIG_GENERIC_PINCONF=3Dy
> # CONFIG_DEBUG_PINCTRL is not set
> CONFIG_PINCTRL_AMD=3Dy
> # CONFIG_PINCTRL_CY8C95X0 is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
> CONFIG_PINCTRL_CS42L43=3Dm
>
> #
> # Intel pinctrl drivers
> #
> CONFIG_PINCTRL_BAYTRAIL=3Dy
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=3Dy
> # CONFIG_PINCTRL_INTEL_PLATFORM is not set
> CONFIG_PINCTRL_ALDERLAKE=3Dm
> CONFIG_PINCTRL_BROXTON=3Dm
> CONFIG_PINCTRL_CANNONLAKE=3Dm
> CONFIG_PINCTRL_CEDARFORK=3Dm
> CONFIG_PINCTRL_DENVERTON=3Dm
> CONFIG_PINCTRL_ELKHARTLAKE=3Dm
> CONFIG_PINCTRL_EMMITSBURG=3Dm
> CONFIG_PINCTRL_GEMINILAKE=3Dm
> CONFIG_PINCTRL_ICELAKE=3Dm
> CONFIG_PINCTRL_JASPERLAKE=3Dm
> CONFIG_PINCTRL_LAKEFIELD=3Dm
> CONFIG_PINCTRL_LEWISBURG=3Dm
> CONFIG_PINCTRL_METEORLAKE=3Dm
> # CONFIG_PINCTRL_METEORPOINT is not set
> CONFIG_PINCTRL_SUNRISEPOINT=3Dm
> CONFIG_PINCTRL_TIGERLAKE=3Dm
> # end of Intel pinctrl drivers
>
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
>
> CONFIG_GPIOLIB=3Dy
> CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
> CONFIG_GPIO_ACPI=3Dy
> CONFIG_GPIOLIB_IRQCHIP=3Dy
> # CONFIG_DEBUG_GPIO is not set
> # CONFIG_GPIO_SYSFS is not set
> CONFIG_GPIO_CDEV=3Dy
> CONFIG_GPIO_CDEV_V1=3Dy
> CONFIG_GPIO_GENERIC=3Dm
> CONFIG_GPIO_SWNODE_UNDEFINED=3Dy
>
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_ALTERA is not set
> CONFIG_GPIO_AMDPT=3Dm
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_GRANITERAPIDS is not set
> # CONFIG_GPIO_GRGPIO is not set
> CONFIG_GPIO_ICH=3Dm
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_POLARFIRE_SOC is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
>
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
>
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_FXL6408 is not set
> # CONFIG_GPIO_DS4520 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
>
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_ELKHARTLAKE is not set
> # end of MFD GPIO expanders
>
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
>
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
>
> #
> # USB GPIO expanders
> #
> # CONFIG_GPIO_MPSSE is not set
> # end of USB GPIO expanders
>
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_LATCH is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
>
> #
> # GPIO Debugging utilities
> #
> # CONFIG_GPIO_SLOPPY_LOGIC_ANALYZER is not set
> # CONFIG_GPIO_VIRTUSER is not set
> # end of GPIO Debugging utilities
>
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=3Dy
> # CONFIG_POWER_RESET_RESTART is not set
> # CONFIG_POWER_SEQUENCING is not set
> CONFIG_POWER_SUPPLY=3Dy
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=3Dy
> # CONFIG_GENERIC_ADC_BATTERY is not set
> # CONFIG_IP5XXX_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_BATTERY_MAX1720X is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_MAX77976 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_BD99954 is not set
> # CONFIG_BATTERY_UG3105 is not set
> # CONFIG_FUEL_GAUGE_MM8013 is not set
> CONFIG_HWMON=3Dy
> CONFIG_HWMON_VID=3Dm
> # CONFIG_HWMON_DEBUG_CHIP is not set
>
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=3Dm
> CONFIG_SENSORS_ABITUGURU3=3Dm
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=3Dm
> CONFIG_SENSORS_AD7418=3Dm
> CONFIG_SENSORS_ADM1025=3Dm
> CONFIG_SENSORS_ADM1026=3Dm
> CONFIG_SENSORS_ADM1029=3Dm
> CONFIG_SENSORS_ADM1031=3Dm
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=3Dm
> CONFIG_SENSORS_ADT7X10=3Dm
> # CONFIG_SENSORS_ADT7310 is not set
> CONFIG_SENSORS_ADT7410=3Dm
> CONFIG_SENSORS_ADT7411=3Dm
> CONFIG_SENSORS_ADT7462=3Dm
> CONFIG_SENSORS_ADT7470=3Dm
> CONFIG_SENSORS_ADT7475=3Dm
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=3Dm
> # CONFIG_SENSORS_ASUS_ROG_RYUJIN is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=3Dm
> CONFIG_SENSORS_K10TEMP=3Dm
> CONFIG_SENSORS_FAM15H_POWER=3Dm
> CONFIG_SENSORS_APPLESMC=3Dm
> CONFIG_SENSORS_ASB100=3Dm
> CONFIG_SENSORS_ATXP1=3Dm
> # CONFIG_SENSORS_CHIPCAP2 is not set
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=3Dm
> CONFIG_SENSORS_DS1621=3Dm
> CONFIG_SENSORS_DELL_SMM=3Dm
> # CONFIG_I8K is not set
> CONFIG_SENSORS_I5K_AMB=3Dm
> CONFIG_SENSORS_F71805F=3Dm
> CONFIG_SENSORS_F71882FG=3Dm
> CONFIG_SENSORS_F75375S=3Dm
> CONFIG_SENSORS_FSCHMD=3Dm
> # CONFIG_SENSORS_FTSTEUTATES is not set
> # CONFIG_SENSORS_GIGABYTE_WATERFORCE is not set
> CONFIG_SENSORS_GL518SM=3Dm
> CONFIG_SENSORS_GL520SM=3Dm
> CONFIG_SENSORS_G760A=3Dm
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> # CONFIG_SENSORS_HS3001 is not set
> CONFIG_SENSORS_IBMAEM=3Dm
> CONFIG_SENSORS_IBMPEX=3Dm
> # CONFIG_SENSORS_IIO_HWMON is not set
> CONFIG_SENSORS_I5500=3Dm
> CONFIG_SENSORS_CORETEMP=3Dm
> # CONFIG_SENSORS_ISL28022 is not set
> CONFIG_SENSORS_IT87=3Dm
> CONFIG_SENSORS_JC42=3Dm
> # CONFIG_SENSORS_POWERZ is not set
> # CONFIG_SENSORS_POWR1220 is not set
> # CONFIG_SENSORS_LENOVO_EC is not set
> CONFIG_SENSORS_LINEAGE=3Dm
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2991 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=3Dm
> CONFIG_SENSORS_LTC4215=3Dm
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=3Dm
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=3Dm
> # CONFIG_SENSORS_LTC4282 is not set
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=3Dm
> CONFIG_SENSORS_MAX1619=3Dm
> CONFIG_SENSORS_MAX1668=3Dm
> CONFIG_SENSORS_MAX197=3Dm
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX31760 is not set
> # CONFIG_MAX31827 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=3Dm
> CONFIG_SENSORS_MAX6650=3Dm
> CONFIG_SENSORS_MAX6697=3Dm
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MC34VR500 is not set
> CONFIG_SENSORS_MCP3021=3Dm
> CONFIG_SENSORS_MLXREG_FAN=3Dm
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=3Dm
> # CONFIG_SENSORS_LM70 is not set
> CONFIG_SENSORS_LM73=3Dm
> CONFIG_SENSORS_LM75=3Dm
> CONFIG_SENSORS_LM77=3Dm
> CONFIG_SENSORS_LM78=3Dm
> CONFIG_SENSORS_LM80=3Dm
> CONFIG_SENSORS_LM83=3Dm
> CONFIG_SENSORS_LM85=3Dm
> CONFIG_SENSORS_LM87=3Dm
> CONFIG_SENSORS_LM90=3Dm
> CONFIG_SENSORS_LM92=3Dm
> CONFIG_SENSORS_LM93=3Dm
> CONFIG_SENSORS_LM95234=3Dm
> CONFIG_SENSORS_LM95241=3Dm
> CONFIG_SENSORS_LM95245=3Dm
> CONFIG_SENSORS_PC87360=3Dm
> CONFIG_SENSORS_PC87427=3Dm
> CONFIG_SENSORS_NTC_THERMISTOR=3Dm
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775_CORE=3Dm
> CONFIG_SENSORS_NCT6775=3Dm
> # CONFIG_SENSORS_NCT6775_I2C is not set
> # CONFIG_SENSORS_NCT7363 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
> # CONFIG_SENSORS_NZXT_KRAKEN3 is not set
> # CONFIG_SENSORS_NZXT_SMART2 is not set
> # CONFIG_SENSORS_OCC_P8_I2C is not set
> # CONFIG_SENSORS_OXP is not set
> CONFIG_SENSORS_PCF8591=3Dm
> CONFIG_PMBUS=3Dm
> CONFIG_SENSORS_PMBUS=3Dm
> # CONFIG_SENSORS_ACBEL_FSG032 is not set
> # CONFIG_SENSORS_ADM1266 is not set
> CONFIG_SENSORS_ADM1275=3Dm
> # CONFIG_SENSORS_ADP1050 is not set
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
> # CONFIG_SENSORS_FSP_3Y is not set
> # CONFIG_SENSORS_IBM_CFFPS is not set
> # CONFIG_SENSORS_DPS920AB is not set
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> # CONFIG_SENSORS_IR35221 is not set
> # CONFIG_SENSORS_IR36021 is not set
> # CONFIG_SENSORS_IR38064 is not set
> # CONFIG_SENSORS_IRPS5401 is not set
> # CONFIG_SENSORS_ISL68137 is not set
> CONFIG_SENSORS_LM25066=3Dm
> # CONFIG_SENSORS_LT7182S is not set
> CONFIG_SENSORS_LTC2978=3Dm
> # CONFIG_SENSORS_LTC3815 is not set
> # CONFIG_SENSORS_LTC4286 is not set
> # CONFIG_SENSORS_MAX15301 is not set
> CONFIG_SENSORS_MAX16064=3Dm
> # CONFIG_SENSORS_MAX16601 is not set
> # CONFIG_SENSORS_MAX20730 is not set
> # CONFIG_SENSORS_MAX20751 is not set
> # CONFIG_SENSORS_MAX31785 is not set
> CONFIG_SENSORS_MAX34440=3Dm
> CONFIG_SENSORS_MAX8688=3Dm
> # CONFIG_SENSORS_MP2856 is not set
> # CONFIG_SENSORS_MP2888 is not set
> # CONFIG_SENSORS_MP2891 is not set
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_MP2993 is not set
> # CONFIG_SENSORS_MP5023 is not set
> # CONFIG_SENSORS_MP5920 is not set
> # CONFIG_SENSORS_MP5990 is not set
> # CONFIG_SENSORS_MP9941 is not set
> # CONFIG_SENSORS_MPQ7932 is not set
> # CONFIG_SENSORS_MPQ8785 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> # CONFIG_SENSORS_PLI1209BC is not set
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> # CONFIG_SENSORS_TDA38640 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> # CONFIG_SENSORS_TPS546D24 is not set
> CONFIG_SENSORS_UCD9000=3Dm
> CONFIG_SENSORS_UCD9200=3Dm
> # CONFIG_SENSORS_XDP710 is not set
> # CONFIG_SENSORS_XDPE152 is not set
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=3Dm
> # CONFIG_SENSORS_PT5161L is not set
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=3Dm
> CONFIG_SENSORS_SHT21=3Dm
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=3Dm
> CONFIG_SENSORS_DME1737=3Dm
> CONFIG_SENSORS_EMC1403=3Dm
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC2305 is not set
> CONFIG_SENSORS_EMC6W201=3Dm
> CONFIG_SENSORS_SMSC47M1=3Dm
> CONFIG_SENSORS_SMSC47M192=3Dm
> CONFIG_SENSORS_SMSC47B397=3Dm
> CONFIG_SENSORS_SCH56XX_COMMON=3Dm
> CONFIG_SENSORS_SCH5627=3Dm
> CONFIG_SENSORS_SCH5636=3Dm
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS7828=3Dm
> # CONFIG_SENSORS_ADS7871 is not set
> CONFIG_SENSORS_AMC6821=3Dm
> CONFIG_SENSORS_INA209=3Dm
> CONFIG_SENSORS_INA2XX=3Dm
> # CONFIG_SENSORS_INA238 is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_SPD5118 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=3Dm
> CONFIG_SENSORS_TMP102=3Dm
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=3Dm
> CONFIG_SENSORS_TMP421=3Dm
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=3Dm
> CONFIG_SENSORS_VIA686A=3Dm
> CONFIG_SENSORS_VT1211=3Dm
> CONFIG_SENSORS_VT8231=3Dm
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=3Dm
> CONFIG_SENSORS_W83791D=3Dm
> CONFIG_SENSORS_W83792D=3Dm
> CONFIG_SENSORS_W83793=3Dm
> CONFIG_SENSORS_W83795=3Dm
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=3Dm
> CONFIG_SENSORS_W83L786NG=3Dm
> CONFIG_SENSORS_W83627HF=3Dm
> CONFIG_SENSORS_W83627EHF=3Dm
> # CONFIG_SENSORS_XGENE is not set
>
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=3Dm
> CONFIG_SENSORS_ATK0110=3Dm
> # CONFIG_SENSORS_ASUS_WMI is not set
> # CONFIG_SENSORS_ASUS_EC is not set
> # CONFIG_SENSORS_HP_WMI is not set
> CONFIG_THERMAL=3Dy
> CONFIG_THERMAL_NETLINK=3Dy
> # CONFIG_THERMAL_STATISTICS is not set
> # CONFIG_THERMAL_DEBUGFS is not set
> # CONFIG_THERMAL_CORE_TESTING is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> CONFIG_THERMAL_HWMON=3Dy
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
> CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> CONFIG_THERMAL_GOV_USER_SPACE=3Dy
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_PCIE_THERMAL is not set
> # CONFIG_THERMAL_EMULATION is not set
>
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=3Dm
> CONFIG_X86_THERMAL_VECTOR=3Dy
> CONFIG_INTEL_TCC=3Dy
> CONFIG_X86_PKG_TEMP_THERMAL=3Dm
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=3Dm
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>
> #
> # ACPI INT340X thermal drivers
> #
> CONFIG_INT340X_THERMAL=3Dm
> CONFIG_ACPI_THERMAL_REL=3Dm
> # CONFIG_INT3406_THERMAL is not set
> CONFIG_PROC_THERMAL_MMIO_RAPL=3Dm
> # end of ACPI INT340X thermal drivers
>
> CONFIG_INTEL_PCH_THERMAL=3Dm
> # CONFIG_INTEL_TCC_COOLING is not set
> CONFIG_INTEL_HFI_THERMAL=3Dy
> # end of Intel thermal drivers
>
> # CONFIG_GENERIC_ADC_THERMAL is not set
> CONFIG_WATCHDOG=3Dy
> CONFIG_WATCHDOG_CORE=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
> CONFIG_WATCHDOG_SYSFS=3Dy
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
>
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
>
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=3Dm
> # CONFIG_LENOVO_SE10_WDT is not set
> CONFIG_WDAT_WDT=3Dm
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> CONFIG_MLX_WDT=3Dm
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ADVANTECH_EC_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_EBC_C384_WDT is not set
> # CONFIG_EXAR_WDT is not set
> # CONFIG_F71808E_WDT is not set
> CONFIG_SP5100_TCO=3Dm
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=3Dm
> CONFIG_IBMASR=3Dm
> # CONFIG_WAFER_WDT is not set
> CONFIG_I6300ESB_WDT=3Dy
> # CONFIG_IE6XX_WDT is not set
> CONFIG_ITCO_WDT=3Dy
> CONFIG_ITCO_VENDOR_SUPPORT=3Dy
> # CONFIG_IT8712F_WDT is not set
> # CONFIG_IT87_WDT is not set
> CONFIG_HP_WATCHDOG=3Dm
> CONFIG_HPWDT_NMI_DECODING=3Dy
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> # CONFIG_NV_TCO is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> # CONFIG_SMSC_SCH311X_WDT is not set
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> # CONFIG_VIA_WDT is not set
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_W83977F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> CONFIG_INTEL_MEI_WDT=3Dm
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
> # CONFIG_XEN_WDT is not set
>
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
>
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=3Dy
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=3Dy
> CONFIG_BCMA=3Dm
> CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> CONFIG_BCMA_HOST_PCI=3Dy
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=3Dy
> CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
> CONFIG_BCMA_DRIVER_GPIO=3Dy
> # CONFIG_BCMA_DEBUG is not set
>
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=3Dy
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_MFD_SMPRO is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_CGBC is not set
> CONFIG_MFD_CS42L43=3Dm
> # CONFIG_MFD_CS42L43_I2C is not set
> CONFIG_MFD_CS42L43_SDW=3Dm
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=3Dm
> CONFIG_LPC_SCH=3Dm
> CONFIG_MFD_INTEL_LPSS=3Dm
> CONFIG_MFD_INTEL_LPSS_ACPI=3Dm
> CONFIG_MFD_INTEL_LPSS_PCI=3Dm
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77541 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6370 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_MFD_OCELOT is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_SY7636A is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RT5120 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=3Dm
> CONFIG_MFD_SM501_GPIO=3Dy
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS6594_I2C is not set
> # CONFIG_MFD_TPS6594_SPI is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=3Dm
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_CS40L50_I2C is not set
> # CONFIG_MFD_CS40L50_SPI is not set
> # CONFIG_MFD_INTEL_M10_BMC_SPI is not set
> # end of Multifunction device drivers
>
> # CONFIG_REGULATOR is not set
> CONFIG_RC_CORE=3Dy
> CONFIG_BPF_LIRC_MODE2=3Dy
> CONFIG_LIRC=3Dy
> CONFIG_RC_MAP=3Dy
> # CONFIG_RC_DECODERS is not set
> CONFIG_RC_DEVICES=3Dy
> # CONFIG_IR_ENE is not set
> # CONFIG_IR_FINTEK is not set
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> # CONFIG_IR_ITE_CIR is not set
> # CONFIG_IR_MCEUSB is not set
> # CONFIG_IR_NUVOTON is not set
> # CONFIG_IR_REDRAT3 is not set
> # CONFIG_IR_SERIAL is not set
> # CONFIG_IR_STREAMZAP is not set
> # CONFIG_IR_TOY is not set
> # CONFIG_IR_TTUSBIR is not set
> # CONFIG_IR_WINBOND_CIR is not set
> # CONFIG_RC_ATI_REMOTE is not set
> CONFIG_RC_LOOPBACK=3Dm
> # CONFIG_RC_XBOX_DVD is not set
> CONFIG_CEC_CORE=3Dm
>
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_RC is not set
> CONFIG_MEDIA_CEC_SUPPORT=3Dy
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_GPIO is not set
> # CONFIG_CEC_SECO is not set
> # CONFIG_USB_EXTRON_DA_HD_4K_PLUS_CEC is not set
> CONFIG_USB_PULSE8_CEC=3Dm
> CONFIG_USB_RAINSHADOW_CEC=3Dm
> # end of CEC support
>
> CONFIG_MEDIA_SUPPORT=3Dm
> CONFIG_MEDIA_SUPPORT_FILTER=3Dy
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy
>
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
>
> CONFIG_VIDEO_DEV=3Dm
> CONFIG_MEDIA_CONTROLLER=3Dy
>
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2_I2C=3Dy
> CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_V4L2_FWNODE=3Dm
> CONFIG_V4L2_ASYNC=3Dm
> # end of Video4Linux options
>
> #
> # Media controller options
> #
> # end of Media controller options
>
> #
> # Media drivers
> #
>
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
>
> #
> # Media drivers
> #
> CONFIG_MEDIA_USB_SUPPORT=3Dy
>
> #
> # Webcam devices
> #
> CONFIG_USB_GSPCA=3Dm
> CONFIG_USB_GSPCA_BENQ=3Dm
> CONFIG_USB_GSPCA_CONEX=3Dm
> CONFIG_USB_GSPCA_CPIA1=3Dm
> # CONFIG_USB_GSPCA_DTCS033 is not set
> CONFIG_USB_GSPCA_ETOMS=3Dm
> CONFIG_USB_GSPCA_FINEPIX=3Dm
> CONFIG_USB_GSPCA_JEILINJ=3Dm
> CONFIG_USB_GSPCA_JL2005BCD=3Dm
> # CONFIG_USB_GSPCA_KINECT is not set
> CONFIG_USB_GSPCA_KONICA=3Dm
> CONFIG_USB_GSPCA_MARS=3Dm
> CONFIG_USB_GSPCA_MR97310A=3Dm
> CONFIG_USB_GSPCA_NW80X=3Dm
> CONFIG_USB_GSPCA_OV519=3Dm
> CONFIG_USB_GSPCA_OV534=3Dm
> CONFIG_USB_GSPCA_OV534_9=3Dm
> CONFIG_USB_GSPCA_PAC207=3Dm
> CONFIG_USB_GSPCA_PAC7302=3Dm
> CONFIG_USB_GSPCA_PAC7311=3Dm
> CONFIG_USB_GSPCA_SE401=3Dm
> CONFIG_USB_GSPCA_SN9C2028=3Dm
> CONFIG_USB_GSPCA_SN9C20X=3Dm
> CONFIG_USB_GSPCA_SONIXB=3Dm
> CONFIG_USB_GSPCA_SONIXJ=3Dm
> CONFIG_USB_GSPCA_SPCA1528=3Dm
> CONFIG_USB_GSPCA_SPCA500=3Dm
> CONFIG_USB_GSPCA_SPCA501=3Dm
> CONFIG_USB_GSPCA_SPCA505=3Dm
> CONFIG_USB_GSPCA_SPCA506=3Dm
> CONFIG_USB_GSPCA_SPCA508=3Dm
> CONFIG_USB_GSPCA_SPCA561=3Dm
> CONFIG_USB_GSPCA_SQ905=3Dm
> CONFIG_USB_GSPCA_SQ905C=3Dm
> CONFIG_USB_GSPCA_SQ930X=3Dm
> CONFIG_USB_GSPCA_STK014=3Dm
> # CONFIG_USB_GSPCA_STK1135 is not set
> CONFIG_USB_GSPCA_STV0680=3Dm
> CONFIG_USB_GSPCA_SUNPLUS=3Dm
> CONFIG_USB_GSPCA_T613=3Dm
> CONFIG_USB_GSPCA_TOPRO=3Dm
> # CONFIG_USB_GSPCA_TOUPTEK is not set
> CONFIG_USB_GSPCA_TV8532=3Dm
> CONFIG_USB_GSPCA_VC032X=3Dm
> CONFIG_USB_GSPCA_VICAM=3Dm
> CONFIG_USB_GSPCA_XIRLINK_CIT=3Dm
> CONFIG_USB_GSPCA_ZC3XX=3Dm
> CONFIG_USB_GL860=3Dm
> CONFIG_USB_M5602=3Dm
> CONFIG_USB_STV06XX=3Dm
> CONFIG_USB_PWC=3Dm
> # CONFIG_USB_PWC_DEBUG is not set
> CONFIG_USB_PWC_INPUT_EVDEV=3Dy
> CONFIG_USB_S2255=3Dm
> # CONFIG_VIDEO_USBTV is not set
> CONFIG_USB_VIDEO_CLASS=3Dm
> CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
>
> #
> # Webcam, TV (analog/digital) USB devices
> #
> # CONFIG_VIDEO_EM28XX is not set
> CONFIG_MEDIA_PCI_SUPPORT=3Dy
>
> #
> # Media capture support
> #
> # CONFIG_VIDEO_MGB4 is not set
> # CONFIG_VIDEO_SOLO6X10 is not set
> # CONFIG_VIDEO_TW5864 is not set
> # CONFIG_VIDEO_TW68 is not set
> # CONFIG_VIDEO_TW686X is not set
> # CONFIG_VIDEO_ZORAN is not set
> # CONFIG_VIDEO_IPU3_CIO2 is not set
> # CONFIG_VIDEO_INTEL_IPU6 is not set
> # CONFIG_INTEL_VSC is not set
> # CONFIG_IPU_BRIDGE is not set
> CONFIG_UVC_COMMON=3Dm
> CONFIG_VIDEOBUF2_CORE=3Dm
> CONFIG_VIDEOBUF2_V4L2=3Dm
> CONFIG_VIDEOBUF2_MEMOPS=3Dm
> CONFIG_VIDEOBUF2_VMALLOC=3Dm
> # end of Media drivers
>
> #
> # Media ancillary drivers
> #
>
> #
> # IR I2C driver auto-selected by 'Autoselect ancillary drivers'
> #
> CONFIG_VIDEO_IR_I2C=3Dm
> CONFIG_VIDEO_CAMERA_SENSOR=3Dy
> # CONFIG_VIDEO_ALVIUM_CSI2 is not set
> # CONFIG_VIDEO_AR0521 is not set
> # CONFIG_VIDEO_GC0308 is not set
> # CONFIG_VIDEO_GC05A2 is not set
> # CONFIG_VIDEO_GC08A3 is not set
> # CONFIG_VIDEO_GC2145 is not set
> # CONFIG_VIDEO_HI556 is not set
> # CONFIG_VIDEO_HI846 is not set
> # CONFIG_VIDEO_HI847 is not set
> # CONFIG_VIDEO_IMX208 is not set
> # CONFIG_VIDEO_IMX214 is not set
> # CONFIG_VIDEO_IMX219 is not set
> # CONFIG_VIDEO_IMX258 is not set
> # CONFIG_VIDEO_IMX274 is not set
> # CONFIG_VIDEO_IMX283 is not set
> # CONFIG_VIDEO_IMX290 is not set
> # CONFIG_VIDEO_IMX296 is not set
> # CONFIG_VIDEO_IMX319 is not set
> # CONFIG_VIDEO_IMX355 is not set
> # CONFIG_VIDEO_MT9M001 is not set
> # CONFIG_VIDEO_MT9M111 is not set
> # CONFIG_VIDEO_MT9M114 is not set
> # CONFIG_VIDEO_MT9P031 is not set
> # CONFIG_VIDEO_MT9T112 is not set
> # CONFIG_VIDEO_MT9V011 is not set
> # CONFIG_VIDEO_MT9V032 is not set
> # CONFIG_VIDEO_MT9V111 is not set
> # CONFIG_VIDEO_OG01A1B is not set
> # CONFIG_VIDEO_OV01A10 is not set
> # CONFIG_VIDEO_OV02A10 is not set
> # CONFIG_VIDEO_OV08D10 is not set
> # CONFIG_VIDEO_OV08X40 is not set
> # CONFIG_VIDEO_OV13858 is not set
> # CONFIG_VIDEO_OV13B10 is not set
> # CONFIG_VIDEO_OV2640 is not set
> # CONFIG_VIDEO_OV2659 is not set
> # CONFIG_VIDEO_OV2680 is not set
> # CONFIG_VIDEO_OV2685 is not set
> # CONFIG_VIDEO_OV2740 is not set
> # CONFIG_VIDEO_OV4689 is not set
> # CONFIG_VIDEO_OV5647 is not set
> # CONFIG_VIDEO_OV5648 is not set
> # CONFIG_VIDEO_OV5670 is not set
> # CONFIG_VIDEO_OV5675 is not set
> # CONFIG_VIDEO_OV5693 is not set
> # CONFIG_VIDEO_OV5695 is not set
> # CONFIG_VIDEO_OV64A40 is not set
> # CONFIG_VIDEO_OV6650 is not set
> # CONFIG_VIDEO_OV7251 is not set
> # CONFIG_VIDEO_OV7640 is not set
> # CONFIG_VIDEO_OV7670 is not set
> # CONFIG_VIDEO_OV772X is not set
> # CONFIG_VIDEO_OV7740 is not set
> # CONFIG_VIDEO_OV8856 is not set
> # CONFIG_VIDEO_OV8858 is not set
> # CONFIG_VIDEO_OV8865 is not set
> # CONFIG_VIDEO_OV9640 is not set
> # CONFIG_VIDEO_OV9650 is not set
> # CONFIG_VIDEO_OV9734 is not set
> # CONFIG_VIDEO_RDACM20 is not set
> # CONFIG_VIDEO_RDACM21 is not set
> # CONFIG_VIDEO_RJ54N1 is not set
> # CONFIG_VIDEO_S5C73M3 is not set
> # CONFIG_VIDEO_S5K5BAF is not set
> # CONFIG_VIDEO_S5K6A3 is not set
> # CONFIG_VIDEO_CCS is not set
> # CONFIG_VIDEO_ET8EK8 is not set
>
> #
> # Camera ISPs
> #
> # CONFIG_VIDEO_THP7312 is not set
> # end of Camera ISPs
>
> #
> # Lens drivers
> #
> # CONFIG_VIDEO_AD5820 is not set
> # CONFIG_VIDEO_AK7375 is not set
> # CONFIG_VIDEO_DW9714 is not set
> # CONFIG_VIDEO_DW9719 is not set
> # CONFIG_VIDEO_DW9768 is not set
> # CONFIG_VIDEO_DW9807_VCM is not set
> # end of Lens drivers
>
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> # CONFIG_VIDEO_LM3646 is not set
> # end of Flash devices
>
> #
> # Audio decoders, processors and mixers
> #
> # CONFIG_VIDEO_CS3308 is not set
> # CONFIG_VIDEO_CS5345 is not set
> # CONFIG_VIDEO_CS53L32A is not set
> # CONFIG_VIDEO_MSP3400 is not set
> # CONFIG_VIDEO_SONY_BTF_MPX is not set
> # CONFIG_VIDEO_TDA1997X is not set
> # CONFIG_VIDEO_TDA7432 is not set
> # CONFIG_VIDEO_TDA9840 is not set
> # CONFIG_VIDEO_TEA6415C is not set
> # CONFIG_VIDEO_TEA6420 is not set
> # CONFIG_VIDEO_TLV320AIC23B is not set
> # CONFIG_VIDEO_TVAUDIO is not set
> # CONFIG_VIDEO_UDA1342 is not set
> # CONFIG_VIDEO_VP27SMPX is not set
> # CONFIG_VIDEO_WM8739 is not set
> # CONFIG_VIDEO_WM8775 is not set
> # end of Audio decoders, processors and mixers
>
> #
> # RDS decoders
> #
> # CONFIG_VIDEO_SAA6588 is not set
> # end of RDS decoders
>
> #
> # Video decoders
> #
> # CONFIG_VIDEO_ADV7180 is not set
> # CONFIG_VIDEO_ADV7183 is not set
> # CONFIG_VIDEO_ADV7604 is not set
> # CONFIG_VIDEO_ADV7842 is not set
> # CONFIG_VIDEO_BT819 is not set
> # CONFIG_VIDEO_BT856 is not set
> # CONFIG_VIDEO_BT866 is not set
> # CONFIG_VIDEO_KS0127 is not set
> # CONFIG_VIDEO_ML86V7667 is not set
> # CONFIG_VIDEO_SAA7110 is not set
> # CONFIG_VIDEO_SAA711X is not set
> # CONFIG_VIDEO_TC358743 is not set
> # CONFIG_VIDEO_TC358746 is not set
> # CONFIG_VIDEO_TVP514X is not set
> # CONFIG_VIDEO_TVP5150 is not set
> # CONFIG_VIDEO_TVP7002 is not set
> # CONFIG_VIDEO_TW2804 is not set
> # CONFIG_VIDEO_TW9900 is not set
> # CONFIG_VIDEO_TW9903 is not set
> # CONFIG_VIDEO_TW9906 is not set
> # CONFIG_VIDEO_TW9910 is not set
> # CONFIG_VIDEO_VPX3220 is not set
>
> #
> # Video and audio decoders
> #
> # CONFIG_VIDEO_SAA717X is not set
> # CONFIG_VIDEO_CX25840 is not set
> # end of Video decoders
>
> #
> # Video encoders
> #
> # CONFIG_VIDEO_ADV7170 is not set
> # CONFIG_VIDEO_ADV7175 is not set
> # CONFIG_VIDEO_ADV7343 is not set
> # CONFIG_VIDEO_ADV7393 is not set
> # CONFIG_VIDEO_ADV7511 is not set
> # CONFIG_VIDEO_AK881X is not set
> # CONFIG_VIDEO_SAA7127 is not set
> # CONFIG_VIDEO_SAA7185 is not set
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
>
> #
> # Video improvement chips
> #
> # CONFIG_VIDEO_UPD64031A is not set
> # CONFIG_VIDEO_UPD64083 is not set
> # end of Video improvement chips
>
> #
> # Audio/Video compression chips
> #
> # CONFIG_VIDEO_SAA6752HS is not set
> # end of Audio/Video compression chips
>
> #
> # SDR tuner chips
> #
> # end of SDR tuner chips
>
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_I2C is not set
> # CONFIG_VIDEO_M52790 is not set
> # CONFIG_VIDEO_ST_MIPID02 is not set
> # CONFIG_VIDEO_THS7303 is not set
> # end of Miscellaneous helper chips
>
> #
> # Video serializers and deserializers
> #
> # end of Video serializers and deserializers
>
> #
> # Media SPI Adapters
> #
> # CONFIG_VIDEO_GS1662 is not set
> # end of Media SPI Adapters
> # end of Media ancillary drivers
>
> #
> # Graphics support
> #
> CONFIG_APERTURE_HELPERS=3Dy
> CONFIG_SCREEN_INFO=3Dy
> CONFIG_VIDEO=3Dy
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> CONFIG_AGP=3Dm
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=3Dm
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_VIA is not set
> CONFIG_INTEL_GTT=3Dm
> CONFIG_VGA_SWITCHEROO=3Dy
> CONFIG_DRM=3Dm
> CONFIG_DRM_MIPI_DSI=3Dy
> # CONFIG_DRM_DEBUG_MM is not set
> CONFIG_DRM_KMS_HELPER=3Dm
> # CONFIG_DRM_PANIC is not set
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> CONFIG_DRM_DEBUG_MODESET_LOCK=3Dy
> CONFIG_DRM_CLIENT=3Dy
> CONFIG_DRM_CLIENT_LIB=3Dm
> CONFIG_DRM_CLIENT_SELECTION=3Dm
> CONFIG_DRM_CLIENT_SETUP=3Dy
>
> #
> # Supported DRM clients
> #
> CONFIG_DRM_FBDEV_EMULATION=3Dy
> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> # end of Supported DRM clients
>
> CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> CONFIG_DRM_DISPLAY_HELPER=3Dm
> # CONFIG_DRM_DISPLAY_DP_AUX_CEC is not set
> # CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV is not set
> CONFIG_DRM_DISPLAY_DP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_DP_TUNNEL=3Dy
> CONFIG_DRM_DISPLAY_DSC_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDCP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDMI_HELPER=3Dy
> CONFIG_DRM_TTM=3Dm
> CONFIG_DRM_EXEC=3Dm
> CONFIG_DRM_GPUVM=3Dm
> CONFIG_DRM_BUDDY=3Dm
> CONFIG_DRM_TTM_HELPER=3Dm
> CONFIG_DRM_GEM_SHMEM_HELPER=3Dm
> CONFIG_DRM_SUBALLOC_HELPER=3Dm
> CONFIG_DRM_SCHED=3Dm
>
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=3Dm
> CONFIG_DRM_I2C_SIL164=3Dm
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
>
> #
> # ARM devices
> #
> # end of ARM devices
>
> CONFIG_DRM_RADEON=3Dm
> CONFIG_DRM_RADEON_USERPTR=3Dy
> CONFIG_DRM_AMDGPU=3Dm
> # CONFIG_DRM_AMDGPU_SI is not set
> # CONFIG_DRM_AMDGPU_CIK is not set
> CONFIG_DRM_AMDGPU_USERPTR=3Dy
> # CONFIG_DRM_AMD_ISP is not set
> # CONFIG_DRM_AMDGPU_WERROR is not set
>
> #
> # ACP (Audio CoProcessor) Configuration
> #
> CONFIG_DRM_AMD_ACP=3Dy
> # end of ACP (Audio CoProcessor) Configuration
>
> #
> # Display Engine Configuration
> #
> CONFIG_DRM_AMD_DC=3Dy
> CONFIG_DRM_AMD_DC_FP=3Dy
> # CONFIG_DRM_AMD_SECURE_DISPLAY is not set
> # end of Display Engine Configuration
>
> CONFIG_HSA_AMD=3Dy
> CONFIG_HSA_AMD_SVM=3Dy
> # CONFIG_HSA_AMD_P2P is not set
> CONFIG_DRM_NOUVEAU=3Dm
> CONFIG_NOUVEAU_DEBUG=3D5
> CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
> # CONFIG_NOUVEAU_DEBUG_MMU is not set
> # CONFIG_NOUVEAU_DEBUG_PUSH is not set
> CONFIG_DRM_NOUVEAU_BACKLIGHT=3Dy
> # CONFIG_DRM_NOUVEAU_GSP_DEFAULT is not set
> CONFIG_DRM_I915=3Dm
> CONFIG_DRM_I915_FORCE_PROBE=3D""
> CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> CONFIG_DRM_I915_USERPTR=3Dy
> # CONFIG_DRM_I915_GVT_KVMGT is not set
> CONFIG_DRM_I915_DP_TUNNEL=3Dy
>
> #
> # drm/i915 Debugging
> #
> # CONFIG_DRM_I915_WERROR is not set
> # CONFIG_DRM_I915_REPLAY_GPU_HANGS_API is not set
> # CONFIG_DRM_I915_DEBUG is not set
> # CONFIG_DRM_I915_DEBUG_MMIO is not set
> # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> # CONFIG_DRM_I915_DEBUG_GUC is not set
> # CONFIG_DRM_I915_SELFTEST is not set
> # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
> # CONFIG_DRM_I915_DEBUG_WAKEREF is not set
> # end of drm/i915 Debugging
>
> #
> # drm/i915 Profile Guided Optimisation
> #
> CONFIG_DRM_I915_REQUEST_TIMEOUT=3D20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=3D10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
> CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=3D7500
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000
> CONFIG_DRM_I915_STOP_TIMEOUT=3D100
> CONFIG_DRM_I915_TIMESLICE_DURATION=3D1
> # end of drm/i915 Profile Guided Optimisation
>
> # CONFIG_DRM_XE is not set
> # CONFIG_DRM_VGEM is not set
> CONFIG_DRM_VKMS=3Dm
> CONFIG_DRM_VMWGFX=3Dm
> # CONFIG_DRM_VMWGFX_MKSSTATS is not set
> # CONFIG_DRM_GMA500 is not set
> CONFIG_DRM_UDL=3Dm
> CONFIG_DRM_AST=3Dm
> CONFIG_DRM_MGAG200=3Dm
> CONFIG_DRM_QXL=3Dm
> CONFIG_DRM_VIRTIO_GPU=3Dm
> CONFIG_DRM_VIRTIO_GPU_KMS=3Dy
> CONFIG_DRM_PANEL=3Dy
>
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
> # CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
>
> CONFIG_DRM_BRIDGE=3Dy
> CONFIG_DRM_PANEL_BRIDGE=3Dy
>
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
>
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_BOCHS=3Dm
> CONFIG_DRM_CIRRUS_QEMU=3Dm
> CONFIG_DRM_GM12U320=3Dm
> # CONFIG_DRM_PANEL_MIPI_DBI is not set
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9163 is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_SHARP_MEMORY is not set
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> # CONFIG_DRM_XEN_FRONTEND is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> CONFIG_DRM_GUD=3Dm
> # CONFIG_DRM_SSD130X is not set
> CONFIG_DRM_HYPERV=3Dm
> CONFIG_DRM_PRIVACY_SCREEN=3Dy
> # CONFIG_DRM_WERROR is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy
>
> #
> # Frame buffer Devices
> #
> CONFIG_FB=3Dy
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=3Dy
> CONFIG_FB_EFI=3Dy
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_XEN_FBDEV_FRONTEND is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_HYPERV is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> CONFIG_FB_CORE=3Dy
> CONFIG_FB_NOTIFY=3Dy
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_DEVICE=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_SYS_FILLRECT=3Dy
> CONFIG_FB_SYS_COPYAREA=3Dy
> CONFIG_FB_SYS_IMAGEBLIT=3Dy
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYSMEM_FOPS=3Dy
> CONFIG_FB_DEFERRED_IO=3Dy
> CONFIG_FB_IOMEM_FOPS=3Dy
> CONFIG_FB_IOMEM_HELPERS=3Dy
> CONFIG_FB_SYSMEM_HELPERS=3Dy
> CONFIG_FB_SYSMEM_HELPERS_DEFERRED=3Dy
> CONFIG_FB_MODE_HELPERS=3Dy
> CONFIG_FB_TILEBLITTING=3Dy
> # end of Frame buffer Devices
>
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=3Dm
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=3Dm
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_KTD2801 is not set
> # CONFIG_BACKLIGHT_KTZ8866 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> CONFIG_BACKLIGHT_APPLE=3Dm
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3509 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_LP855X=3Dm
> # CONFIG_BACKLIGHT_MP3309C is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
>
> CONFIG_HDMI=3Dy
>
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
>
> CONFIG_LOGO=3Dy
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=3Dy
> # end of Graphics support
>
> # CONFIG_DRM_ACCEL is not set
> CONFIG_SOUND=3Dm
> CONFIG_SOUND_OSS_CORE=3Dy
> CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy
> CONFIG_SND=3Dm
> CONFIG_SND_TIMER=3Dm
> CONFIG_SND_PCM=3Dm
> CONFIG_SND_HWDEP=3Dm
> CONFIG_SND_SEQ_DEVICE=3Dm
> CONFIG_SND_RAWMIDI=3Dm
> CONFIG_SND_UMP=3Dm
> CONFIG_SND_UMP_LEGACY_RAWMIDI=3Dy
> CONFIG_SND_COMPRESS_OFFLOAD=3Dm
> CONFIG_SND_JACK=3Dy
> CONFIG_SND_JACK_INPUT_DEV=3Dy
> CONFIG_SND_OSSEMUL=3Dy
> # CONFIG_SND_MIXER_OSS is not set
> # CONFIG_SND_PCM_OSS is not set
> CONFIG_SND_PCM_TIMER=3Dy
> CONFIG_SND_HRTIMER=3Dm
> CONFIG_SND_DYNAMIC_MINORS=3Dy
> CONFIG_SND_MAX_CARDS=3D32
> # CONFIG_SND_SUPPORT_OLD_API is not set
> CONFIG_SND_PROC_FS=3Dy
> CONFIG_SND_VERBOSE_PROCFS=3Dy
> CONFIG_SND_CTL_FAST_LOOKUP=3Dy
> # CONFIG_SND_DEBUG is not set
> # CONFIG_SND_CTL_INPUT_VALIDATION is not set
> # CONFIG_SND_UTIMER is not set
> CONFIG_SND_VMASTER=3Dy
> CONFIG_SND_DMA_SGBUF=3Dy
> CONFIG_SND_CTL_LED=3Dm
> CONFIG_SND_SEQUENCER=3Dm
> CONFIG_SND_SEQ_DUMMY=3Dm
> # CONFIG_SND_SEQUENCER_OSS is not set
> CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
> CONFIG_SND_SEQ_MIDI_EVENT=3Dm
> CONFIG_SND_SEQ_MIDI=3Dm
> CONFIG_SND_SEQ_MIDI_EMUL=3Dm
> CONFIG_SND_SEQ_VIRMIDI=3Dm
> CONFIG_SND_SEQ_UMP=3Dy
> CONFIG_SND_SEQ_UMP_CLIENT=3Dm
> CONFIG_SND_MPU401_UART=3Dm
> CONFIG_SND_OPL3_LIB=3Dm
> CONFIG_SND_OPL3_LIB_SEQ=3Dm
> CONFIG_SND_VX_LIB=3Dm
> CONFIG_SND_AC97_CODEC=3Dm
> CONFIG_SND_DRIVERS=3Dy
> CONFIG_SND_PCSP=3Dm
> CONFIG_SND_DUMMY=3Dm
> CONFIG_SND_ALOOP=3Dm
> # CONFIG_SND_PCMTEST is not set
> CONFIG_SND_VIRMIDI=3Dm
> CONFIG_SND_MTPAV=3Dm
> # CONFIG_SND_MTS64 is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> CONFIG_SND_MPU401=3Dm
> # CONFIG_SND_PORTMAN2X4 is not set
> CONFIG_SND_AC97_POWER_SAVE=3Dy
> CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
> CONFIG_SND_PCI=3Dy
> CONFIG_SND_AD1889=3Dm
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> CONFIG_SND_ALI5451=3Dm
> CONFIG_SND_ASIHPI=3Dm
> CONFIG_SND_ATIIXP=3Dm
> CONFIG_SND_ATIIXP_MODEM=3Dm
> CONFIG_SND_AU8810=3Dm
> CONFIG_SND_AU8820=3Dm
> CONFIG_SND_AU8830=3Dm
> # CONFIG_SND_AW2 is not set
> # CONFIG_SND_AZT3328 is not set
> CONFIG_SND_BT87X=3Dm
> # CONFIG_SND_BT87X_OVERCLOCK is not set
> CONFIG_SND_CA0106=3Dm
> CONFIG_SND_CMIPCI=3Dm
> CONFIG_SND_OXYGEN_LIB=3Dm
> CONFIG_SND_OXYGEN=3Dm
> # CONFIG_SND_CS4281 is not set
> CONFIG_SND_CS46XX=3Dm
> CONFIG_SND_CS46XX_NEW_DSP=3Dy
> CONFIG_SND_CTXFI=3Dm
> CONFIG_SND_DARLA20=3Dm
> CONFIG_SND_GINA20=3Dm
> CONFIG_SND_LAYLA20=3Dm
> CONFIG_SND_DARLA24=3Dm
> CONFIG_SND_GINA24=3Dm
> CONFIG_SND_LAYLA24=3Dm
> CONFIG_SND_MONA=3Dm
> CONFIG_SND_MIA=3Dm
> CONFIG_SND_ECHO3G=3Dm
> CONFIG_SND_INDIGO=3Dm
> CONFIG_SND_INDIGOIO=3Dm
> CONFIG_SND_INDIGODJ=3Dm
> CONFIG_SND_INDIGOIOX=3Dm
> CONFIG_SND_INDIGODJX=3Dm
> CONFIG_SND_EMU10K1=3Dm
> CONFIG_SND_EMU10K1_SEQ=3Dm
> CONFIG_SND_EMU10K1X=3Dm
> CONFIG_SND_ENS1370=3Dm
> CONFIG_SND_ENS1371=3Dm
> # CONFIG_SND_ES1938 is not set
> CONFIG_SND_ES1968=3Dm
> CONFIG_SND_ES1968_INPUT=3Dy
> # CONFIG_SND_FM801 is not set
> CONFIG_SND_HDSP=3Dm
> CONFIG_SND_HDSPM=3Dm
> CONFIG_SND_ICE1712=3Dm
> CONFIG_SND_ICE1724=3Dm
> CONFIG_SND_INTEL8X0=3Dm
> CONFIG_SND_INTEL8X0M=3Dm
> CONFIG_SND_KORG1212=3Dm
> CONFIG_SND_LOLA=3Dm
> CONFIG_SND_LX6464ES=3Dm
> CONFIG_SND_MAESTRO3=3Dm
> CONFIG_SND_MAESTRO3_INPUT=3Dy
> CONFIG_SND_MIXART=3Dm
> # CONFIG_SND_NM256 is not set
> CONFIG_SND_PCXHR=3Dm
> # CONFIG_SND_RIPTIDE is not set
> CONFIG_SND_RME32=3Dm
> CONFIG_SND_RME96=3Dm
> CONFIG_SND_RME9652=3Dm
> # CONFIG_SND_SONICVIBES is not set
> CONFIG_SND_TRIDENT=3Dm
> CONFIG_SND_VIA82XX=3Dm
> CONFIG_SND_VIA82XX_MODEM=3Dm
> CONFIG_SND_VIRTUOSO=3Dm
> CONFIG_SND_VX222=3Dm
> # CONFIG_SND_YMFPCI is not set
>
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=3Dm
> CONFIG_SND_HDA_GENERIC_LEDS=3Dy
> CONFIG_SND_HDA_INTEL=3Dm
> CONFIG_SND_HDA_HWDEP=3Dy
> CONFIG_SND_HDA_RECONFIG=3Dy
> CONFIG_SND_HDA_INPUT_BEEP=3Dy
> CONFIG_SND_HDA_INPUT_BEEP_MODE=3D0
> CONFIG_SND_HDA_PATCH_LOADER=3Dy
> CONFIG_SND_HDA_CIRRUS_SCODEC=3Dm
> CONFIG_SND_HDA_SCODEC_CS35L41=3Dm
> CONFIG_SND_HDA_CS_DSP_CONTROLS=3Dm
> CONFIG_SND_HDA_SCODEC_COMPONENT=3Dm
> CONFIG_SND_HDA_SCODEC_CS35L41_I2C=3Dm
> CONFIG_SND_HDA_SCODEC_CS35L41_SPI=3Dm
> CONFIG_SND_HDA_SCODEC_CS35L56=3Dm
> CONFIG_SND_HDA_SCODEC_CS35L56_I2C=3Dm
> CONFIG_SND_HDA_SCODEC_CS35L56_SPI=3Dm
> CONFIG_SND_HDA_SCODEC_TAS2781_I2C=3Dm
> CONFIG_SND_HDA_CODEC_REALTEK=3Dm
> CONFIG_SND_HDA_CODEC_ANALOG=3Dm
> CONFIG_SND_HDA_CODEC_SIGMATEL=3Dm
> CONFIG_SND_HDA_CODEC_VIA=3Dm
> CONFIG_SND_HDA_CODEC_HDMI=3Dm
> CONFIG_SND_HDA_CODEC_CIRRUS=3Dm
> CONFIG_SND_HDA_CODEC_CS8409=3Dm
> CONFIG_SND_HDA_CODEC_CONEXANT=3Dm
> # CONFIG_SND_HDA_CODEC_SENARYTECH is not set
> CONFIG_SND_HDA_CODEC_CA0110=3Dm
> CONFIG_SND_HDA_CODEC_CA0132=3Dm
> CONFIG_SND_HDA_CODEC_CA0132_DSP=3Dy
> CONFIG_SND_HDA_CODEC_CMEDIA=3Dm
> CONFIG_SND_HDA_CODEC_SI3054=3Dm
> CONFIG_SND_HDA_GENERIC=3Dm
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D1
> CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=3Dy
> # CONFIG_SND_HDA_CTL_DEV_ID is not set
> # end of HD-Audio
>
> CONFIG_SND_HDA_CORE=3Dm
> CONFIG_SND_HDA_DSP_LOADER=3Dy
> CONFIG_SND_HDA_COMPONENT=3Dy
> CONFIG_SND_HDA_I915=3Dy
> CONFIG_SND_HDA_EXT_CORE=3Dm
> CONFIG_SND_HDA_PREALLOC_SIZE=3D0
> CONFIG_SND_INTEL_NHLT=3Dy
> CONFIG_SND_INTEL_DSP_CONFIG=3Dm
> CONFIG_SND_INTEL_SOUNDWIRE_ACPI=3Dm
> # CONFIG_SND_INTEL_BYT_PREFER_SOF is not set
> # CONFIG_SND_SPI is not set
> CONFIG_SND_USB=3Dy
> CONFIG_SND_USB_AUDIO=3Dm
> CONFIG_SND_USB_AUDIO_MIDI_V2=3Dy
> CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=3Dy
> CONFIG_SND_USB_UA101=3Dm
> CONFIG_SND_USB_USX2Y=3Dm
> CONFIG_SND_USB_CAIAQ=3Dm
> CONFIG_SND_USB_CAIAQ_INPUT=3Dy
> CONFIG_SND_USB_US122L=3Dm
> CONFIG_SND_USB_6FIRE=3Dm
> CONFIG_SND_USB_HIFACE=3Dm
> CONFIG_SND_BCD2000=3Dm
> CONFIG_SND_USB_LINE6=3Dm
> CONFIG_SND_USB_POD=3Dm
> CONFIG_SND_USB_PODHD=3Dm
> CONFIG_SND_USB_TONEPORT=3Dm
> CONFIG_SND_USB_VARIAX=3Dm
> CONFIG_SND_SOC=3Dm
> CONFIG_SND_SOC_COMPRESS=3Dy
> CONFIG_SND_SOC_TOPOLOGY=3Dy
> CONFIG_SND_SOC_ACPI=3Dm
> # CONFIG_SND_SOC_ADI is not set
> # CONFIG_SND_SOC_AMD_ACP is not set
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> CONFIG_SND_SOC_AMD_RENOIR=3Dm
> CONFIG_SND_SOC_AMD_RENOIR_MACH=3Dm
> CONFIG_SND_SOC_AMD_ACP5x=3Dm
> CONFIG_SND_SOC_AMD_VANGOGH_MACH=3Dm
> CONFIG_SND_SOC_AMD_ACP6x=3Dm
> CONFIG_SND_SOC_AMD_YC_MACH=3Dm
> CONFIG_SND_AMD_ACP_CONFIG=3Dm
> # CONFIG_SND_SOC_AMD_ACP_COMMON is not set
> CONFIG_SND_SOC_ACPI_AMD_MATCH=3Dm
> CONFIG_SND_AMD_SOUNDWIRE_ACPI=3Dm
> # CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
> CONFIG_SND_SOC_AMD_ACP63_TOPLEVEL=3Dm
> CONFIG_SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=3Dm
> CONFIG_SND_SOC_AMD_SOUNDWIRE=3Dm
> CONFIG_SND_SOC_AMD_PS=3Dm
> CONFIG_SND_SOC_AMD_PS_MACH=3Dm
> # CONFIG_SND_ATMEL_SOC is not set
> # CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
> # CONFIG_SND_DESIGNWARE_I2S is not set
>
> #
> # SoC Audio for Freescale CPUs
> #
>
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> # CONFIG_SND_SOC_FSL_ASRC is not set
> # CONFIG_SND_SOC_FSL_SAI is not set
> # CONFIG_SND_SOC_FSL_AUDMIX is not set
> # CONFIG_SND_SOC_FSL_SSI is not set
> # CONFIG_SND_SOC_FSL_SPDIF is not set
> # CONFIG_SND_SOC_FSL_ESAI is not set
> # CONFIG_SND_SOC_FSL_MICFIL is not set
> # CONFIG_SND_SOC_FSL_XCVR is not set
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # end of SoC Audio for Freescale CPUs
>
> # CONFIG_SND_SOC_CHV3_I2S is not set
> # CONFIG_SND_I2S_HI6210_I2S is not set
>
> #
> # SoC Audio for Loongson CPUs
> #
> # end of SoC Audio for Loongson CPUs
>
> # CONFIG_SND_SOC_IMG is not set
> CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=3Dy
> CONFIG_SND_SOC_INTEL_CATPT=3Dm
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=3Dm
> # CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
> CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=3Dm
> CONFIG_SND_SOC_ACPI_INTEL_MATCH=3Dm
> CONFIG_SND_SOC_ACPI_INTEL_SDCA_QUIRKS=3Dm
> CONFIG_SND_SOC_INTEL_AVS=3Dm
>
> #
> # Intel AVS Machine drivers
> #
>
> #
> # Available DSP configurations
> #
> # CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_ES8336 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98927 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_PROBE is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_RT274 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_RT286 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_RT298 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_RT5514 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_RT5663 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_RT5682 is not set
> # CONFIG_SND_SOC_INTEL_AVS_MACH_SSM4567 is not set
> # end of Intel AVS Machine drivers
>
> CONFIG_SND_SOC_INTEL_MACH=3Dy
> CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=3Dy
> CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=3Dm
> CONFIG_SND_SOC_INTEL_SOF_MAXIM_COMMON=3Dm
> CONFIG_SND_SOC_INTEL_SOF_REALTEK_COMMON=3Dm
> CONFIG_SND_SOC_INTEL_SOF_CIRRUS_COMMON=3Dm
> CONFIG_SND_SOC_INTEL_SOF_NUVOTON_COMMON=3Dm
> CONFIG_SND_SOC_INTEL_SOF_BOARD_HELPERS=3Dm
> CONFIG_SND_SOC_INTEL_HASWELL_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BROADWELL_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=3Dm
> CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH=3Dm
> CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH=3Dm
> CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_ES8336_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_NAU8825_MACH=3Dm
> CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_DA7219_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOF_SSP_AMP_MACH=3Dm
> CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH=3Dm
> CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=3Dm
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> CONFIG_SND_SOC_SDCA=3Dm
> CONFIG_SND_SOC_SDCA_OPTIONAL=3Dm
> CONFIG_SND_SOC_SOF_TOPLEVEL=3Dy
> CONFIG_SND_SOC_SOF_PCI_DEV=3Dm
> CONFIG_SND_SOC_SOF_PCI=3Dm
> CONFIG_SND_SOC_SOF_ACPI=3Dm
> CONFIG_SND_SOC_SOF_ACPI_DEV=3Dm
> CONFIG_SND_SOC_SOF_DEBUG_PROBES=3Dm
> CONFIG_SND_SOC_SOF_CLIENT=3Dm
> # CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
> CONFIG_SND_SOC_SOF=3Dm
> CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=3Dy
> CONFIG_SND_SOC_SOF_IPC3=3Dy
> CONFIG_SND_SOC_SOF_IPC4=3Dy
> CONFIG_SND_SOC_SOF_AMD_TOPLEVEL=3Dm
> CONFIG_SND_SOC_SOF_AMD_COMMON=3Dm
> CONFIG_SND_SOC_SOF_AMD_RENOIR=3Dm
> CONFIG_SND_SOC_SOF_AMD_VANGOGH=3Dm
> CONFIG_SND_SOC_SOF_AMD_REMBRANDT=3Dm
> CONFIG_SND_SOC_SOF_ACP_PROBES=3Dm
> # CONFIG_SND_SOC_SOF_AMD_ACP63 is not set
> # CONFIG_SND_SOC_SOF_AMD_ACP70 is not set
> CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=3Dy
> CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=3Dm
> CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=3Dm
> CONFIG_SND_SOC_SOF_INTEL_COMMON=3Dm
> CONFIG_SND_SOC_SOF_BAYTRAIL=3Dm
> CONFIG_SND_SOC_SOF_BROADWELL=3Dm
> CONFIG_SND_SOC_SOF_MERRIFIELD=3Dm
> # CONFIG_SND_SOC_SOF_SKYLAKE is not set
> # CONFIG_SND_SOC_SOF_KABYLAKE is not set
> CONFIG_SND_SOC_SOF_INTEL_APL=3Dm
> CONFIG_SND_SOC_SOF_APOLLOLAKE=3Dm
> CONFIG_SND_SOC_SOF_GEMINILAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_CNL=3Dm
> CONFIG_SND_SOC_SOF_CANNONLAKE=3Dm
> CONFIG_SND_SOC_SOF_COFFEELAKE=3Dm
> CONFIG_SND_SOC_SOF_COMETLAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_ICL=3Dm
> CONFIG_SND_SOC_SOF_ICELAKE=3Dm
> CONFIG_SND_SOC_SOF_JASPERLAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_TGL=3Dm
> CONFIG_SND_SOC_SOF_TIGERLAKE=3Dm
> CONFIG_SND_SOC_SOF_ELKHARTLAKE=3Dm
> CONFIG_SND_SOC_SOF_ALDERLAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_MTL=3Dm
> CONFIG_SND_SOC_SOF_METEORLAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_LNL=3Dm
> CONFIG_SND_SOC_SOF_LUNARLAKE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_PTL=3Dm
> CONFIG_SND_SOC_SOF_PANTHERLAKE=3Dm
> CONFIG_SND_SOC_SOF_HDA_COMMON=3Dm
> CONFIG_SND_SOC_SOF_HDA_GENERIC=3Dm
> CONFIG_SND_SOC_SOF_HDA_MLINK=3Dm
> CONFIG_SND_SOC_SOF_HDA_LINK=3Dy
> CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=3Dy
> CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=3Dm
> CONFIG_SND_SOC_SOF_HDA=3Dm
> CONFIG_SND_SOC_SOF_HDA_PROBES=3Dm
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=3Dm
> CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=3Dm
> CONFIG_SND_SOC_SOF_XTENSA=3Dm
>
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
>
> # CONFIG_SND_SOC_XILINX_I2S is not set
> # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> # CONFIG_SND_SOC_XILINX_SPDIF is not set
> # CONFIG_SND_SOC_XTFPGA_I2S is not set
> CONFIG_SND_SOC_I2C_AND_SPI=3Dm
>
> #
> # CODEC drivers
> #
> CONFIG_SND_SOC_WM_ADSP=3Dm
> # CONFIG_SND_SOC_AC97_CODEC is not set
> # CONFIG_SND_SOC_ADAU1372_I2C is not set
> # CONFIG_SND_SOC_ADAU1372_SPI is not set
> # CONFIG_SND_SOC_ADAU1373 is not set
> # CONFIG_SND_SOC_ADAU1701 is not set
> # CONFIG_SND_SOC_ADAU1761_I2C is not set
> # CONFIG_SND_SOC_ADAU1761_SPI is not set
> # CONFIG_SND_SOC_ADAU7002 is not set
> # CONFIG_SND_SOC_ADAU7118_HW is not set
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> # CONFIG_SND_SOC_AK4104 is not set
> # CONFIG_SND_SOC_AK4118 is not set
> # CONFIG_SND_SOC_AK4375 is not set
> # CONFIG_SND_SOC_AK4458 is not set
> # CONFIG_SND_SOC_AK4554 is not set
> # CONFIG_SND_SOC_AK4613 is not set
> # CONFIG_SND_SOC_AK4619 is not set
> # CONFIG_SND_SOC_AK4642 is not set
> # CONFIG_SND_SOC_AK5386 is not set
> # CONFIG_SND_SOC_AK5558 is not set
> # CONFIG_SND_SOC_ALC5623 is not set
> # CONFIG_SND_SOC_AUDIO_IIO_AUX is not set
> # CONFIG_SND_SOC_AW8738 is not set
> # CONFIG_SND_SOC_AW88395 is not set
> # CONFIG_SND_SOC_AW88261 is not set
> # CONFIG_SND_SOC_AW88081 is not set
> # CONFIG_SND_SOC_AW87390 is not set
> # CONFIG_SND_SOC_AW88399 is not set
> # CONFIG_SND_SOC_BD28623 is not set
> # CONFIG_SND_SOC_BT_SCO is not set
> # CONFIG_SND_SOC_CHV3_CODEC is not set
> CONFIG_SND_SOC_CS_AMP_LIB=3Dm
> # CONFIG_SND_SOC_CS35L32 is not set
> # CONFIG_SND_SOC_CS35L33 is not set
> # CONFIG_SND_SOC_CS35L34 is not set
> # CONFIG_SND_SOC_CS35L35 is not set
> # CONFIG_SND_SOC_CS35L36 is not set
> CONFIG_SND_SOC_CS35L41_LIB=3Dm
> CONFIG_SND_SOC_CS35L41=3Dm
> CONFIG_SND_SOC_CS35L41_SPI=3Dm
> CONFIG_SND_SOC_CS35L41_I2C=3Dm
> # CONFIG_SND_SOC_CS35L45_SPI is not set
> # CONFIG_SND_SOC_CS35L45_I2C is not set
> CONFIG_SND_SOC_CS35L56=3Dm
> CONFIG_SND_SOC_CS35L56_SHARED=3Dm
> # CONFIG_SND_SOC_CS35L56_I2C is not set
> CONFIG_SND_SOC_CS35L56_SPI=3Dm
> CONFIG_SND_SOC_CS35L56_SDW=3Dm
> CONFIG_SND_SOC_CS42L42_CORE=3Dm
> CONFIG_SND_SOC_CS42L42=3Dm
> CONFIG_SND_SOC_CS42L42_SDW=3Dm
> CONFIG_SND_SOC_CS42L43=3Dm
> CONFIG_SND_SOC_CS42L43_SDW=3Dm
> # CONFIG_SND_SOC_CS42L51_I2C is not set
> # CONFIG_SND_SOC_CS42L52 is not set
> # CONFIG_SND_SOC_CS42L56 is not set
> # CONFIG_SND_SOC_CS42L73 is not set
> # CONFIG_SND_SOC_CS42L83 is not set
> # CONFIG_SND_SOC_CS42L84 is not set
> # CONFIG_SND_SOC_CS4234 is not set
> # CONFIG_SND_SOC_CS4265 is not set
> # CONFIG_SND_SOC_CS4270 is not set
> # CONFIG_SND_SOC_CS4271_I2C is not set
> # CONFIG_SND_SOC_CS4271_SPI is not set
> # CONFIG_SND_SOC_CS42XX8_I2C is not set
> # CONFIG_SND_SOC_CS43130 is not set
> # CONFIG_SND_SOC_CS4341 is not set
> # CONFIG_SND_SOC_CS4349 is not set
> # CONFIG_SND_SOC_CS53L30 is not set
> # CONFIG_SND_SOC_CS530X_I2C is not set
> CONFIG_SND_SOC_CX2072X=3Dm
> CONFIG_SND_SOC_DA7213=3Dm
> CONFIG_SND_SOC_DA7219=3Dm
> CONFIG_SND_SOC_DMIC=3Dm
> # CONFIG_SND_SOC_ES7134 is not set
> # CONFIG_SND_SOC_ES7241 is not set
> CONFIG_SND_SOC_ES83XX_DSM_COMMON=3Dm
> # CONFIG_SND_SOC_ES8311 is not set
> CONFIG_SND_SOC_ES8316=3Dm
> # CONFIG_SND_SOC_ES8323 is not set
> CONFIG_SND_SOC_ES8326=3Dm
> # CONFIG_SND_SOC_ES8328_I2C is not set
> # CONFIG_SND_SOC_ES8328_SPI is not set
> # CONFIG_SND_SOC_GTM601 is not set
> CONFIG_SND_SOC_HDAC_HDA=3Dm
> CONFIG_SND_SOC_HDA=3Dm
> # CONFIG_SND_SOC_ICS43432 is not set
> # CONFIG_SND_SOC_IDT821034 is not set
> # CONFIG_SND_SOC_MAX98088 is not set
> CONFIG_SND_SOC_MAX98090=3Dm
> CONFIG_SND_SOC_MAX98357A=3Dm
> # CONFIG_SND_SOC_MAX98504 is not set
> # CONFIG_SND_SOC_MAX9867 is not set
> CONFIG_SND_SOC_MAX98927=3Dm
> # CONFIG_SND_SOC_MAX98520 is not set
> CONFIG_SND_SOC_MAX98363=3Dm
> CONFIG_SND_SOC_MAX98373=3Dm
> CONFIG_SND_SOC_MAX98373_I2C=3Dm
> CONFIG_SND_SOC_MAX98373_SDW=3Dm
> CONFIG_SND_SOC_MAX98388=3Dm
> CONFIG_SND_SOC_MAX98390=3Dm
> # CONFIG_SND_SOC_MAX98396 is not set
> # CONFIG_SND_SOC_MAX9860 is not set
> # CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
> # CONFIG_SND_SOC_PCM1681 is not set
> # CONFIG_SND_SOC_PCM1789_I2C is not set
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> # CONFIG_SND_SOC_PCM179X_SPI is not set
> # CONFIG_SND_SOC_PCM186X_I2C is not set
> # CONFIG_SND_SOC_PCM186X_SPI is not set
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> # CONFIG_SND_SOC_PCM3060_SPI is not set
> # CONFIG_SND_SOC_PCM3168A_I2C is not set
> # CONFIG_SND_SOC_PCM3168A_SPI is not set
> # CONFIG_SND_SOC_PCM5102A is not set
> CONFIG_SND_SOC_PCM512x=3Dm
> CONFIG_SND_SOC_PCM512x_I2C=3Dm
> # CONFIG_SND_SOC_PCM512x_SPI is not set
> # CONFIG_SND_SOC_PCM6240 is not set
> # CONFIG_SND_SOC_PEB2466 is not set
> CONFIG_SND_SOC_RL6231=3Dm
> CONFIG_SND_SOC_RT_SDW_COMMON=3Dm
> CONFIG_SND_SOC_RL6347A=3Dm
> CONFIG_SND_SOC_RT286=3Dm
> CONFIG_SND_SOC_RT1011=3Dm
> CONFIG_SND_SOC_RT1015=3Dm
> CONFIG_SND_SOC_RT1015P=3Dm
> # CONFIG_SND_SOC_RT1017_SDCA_SDW is not set
> CONFIG_SND_SOC_RT1308=3Dm
> CONFIG_SND_SOC_RT1308_SDW=3Dm
> CONFIG_SND_SOC_RT1316_SDW=3Dm
> CONFIG_SND_SOC_RT1318_SDW=3Dm
> CONFIG_SND_SOC_RT1320_SDW=3Dm
> # CONFIG_SND_SOC_RT5616 is not set
> # CONFIG_SND_SOC_RT5631 is not set
> CONFIG_SND_SOC_RT5640=3Dm
> CONFIG_SND_SOC_RT5645=3Dm
> CONFIG_SND_SOC_RT5651=3Dm
> # CONFIG_SND_SOC_RT5659 is not set
> CONFIG_SND_SOC_RT5660=3Dm
> CONFIG_SND_SOC_RT5670=3Dm
> CONFIG_SND_SOC_RT5677=3Dm
> CONFIG_SND_SOC_RT5677_SPI=3Dm
> CONFIG_SND_SOC_RT5682=3Dm
> CONFIG_SND_SOC_RT5682_I2C=3Dm
> CONFIG_SND_SOC_RT5682_SDW=3Dm
> CONFIG_SND_SOC_RT5682S=3Dm
> CONFIG_SND_SOC_RT700=3Dm
> CONFIG_SND_SOC_RT700_SDW=3Dm
> CONFIG_SND_SOC_RT711=3Dm
> CONFIG_SND_SOC_RT711_SDW=3Dm
> CONFIG_SND_SOC_RT711_SDCA_SDW=3Dm
> CONFIG_SND_SOC_RT712_SDCA_SDW=3Dm
> CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW=3Dm
> CONFIG_SND_SOC_RT721_SDCA_SDW=3Dm
> CONFIG_SND_SOC_RT722_SDCA_SDW=3Dm
> CONFIG_SND_SOC_RT715=3Dm
> CONFIG_SND_SOC_RT715_SDW=3Dm
> CONFIG_SND_SOC_RT715_SDCA_SDW=3Dm
> # CONFIG_SND_SOC_RT9120 is not set
> # CONFIG_SND_SOC_RTQ9128 is not set
> # CONFIG_SND_SOC_SDW_MOCKUP is not set
> # CONFIG_SND_SOC_SGTL5000 is not set
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> # CONFIG_SND_SOC_SIMPLE_MUX is not set
> # CONFIG_SND_SOC_SMA1303 is not set
> # CONFIG_SND_SOC_SMA1307 is not set
> # CONFIG_SND_SOC_SPDIF is not set
> # CONFIG_SND_SOC_SRC4XXX_I2C is not set
> # CONFIG_SND_SOC_SSM2305 is not set
> # CONFIG_SND_SOC_SSM2518 is not set
> # CONFIG_SND_SOC_SSM2602_SPI is not set
> # CONFIG_SND_SOC_SSM2602_I2C is not set
> CONFIG_SND_SOC_SSM4567=3Dm
> # CONFIG_SND_SOC_STA32X is not set
> # CONFIG_SND_SOC_STA350 is not set
> # CONFIG_SND_SOC_STI_SAS is not set
> # CONFIG_SND_SOC_TAS2552 is not set
> # CONFIG_SND_SOC_TAS2562 is not set
> # CONFIG_SND_SOC_TAS2764 is not set
> # CONFIG_SND_SOC_TAS2770 is not set
> # CONFIG_SND_SOC_TAS2780 is not set
> CONFIG_SND_SOC_TAS2781_COMLIB=3Dm
> CONFIG_SND_SOC_TAS2781_FMWLIB=3Dm
> # CONFIG_SND_SOC_TAS2781_I2C is not set
> # CONFIG_SND_SOC_TAS5086 is not set
> # CONFIG_SND_SOC_TAS571X is not set
> # CONFIG_SND_SOC_TAS5720 is not set
> # CONFIG_SND_SOC_TAS5805M is not set
> # CONFIG_SND_SOC_TAS6424 is not set
> # CONFIG_SND_SOC_TDA7419 is not set
> # CONFIG_SND_SOC_TFA9879 is not set
> # CONFIG_SND_SOC_TFA989X is not set
> # CONFIG_SND_SOC_TLV320ADC3XXX is not set
> # CONFIG_SND_SOC_TLV320AIC23_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC23_SPI is not set
> # CONFIG_SND_SOC_TLV320AIC31XX is not set
> # CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
> # CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
> # CONFIG_SND_SOC_TLV320ADCX140 is not set
> CONFIG_SND_SOC_TS3A227E=3Dm
> # CONFIG_SND_SOC_TSCS42XX is not set
> # CONFIG_SND_SOC_TSCS454 is not set
> # CONFIG_SND_SOC_UDA1334 is not set
> # CONFIG_SND_SOC_UDA1342 is not set
> # CONFIG_SND_SOC_WCD937X_SDW is not set
> # CONFIG_SND_SOC_WCD938X_SDW is not set
> # CONFIG_SND_SOC_WCD939X_SDW is not set
> # CONFIG_SND_SOC_WM8510 is not set
> # CONFIG_SND_SOC_WM8523 is not set
> # CONFIG_SND_SOC_WM8524 is not set
> # CONFIG_SND_SOC_WM8580 is not set
> # CONFIG_SND_SOC_WM8711 is not set
> # CONFIG_SND_SOC_WM8728 is not set
> # CONFIG_SND_SOC_WM8731_I2C is not set
> # CONFIG_SND_SOC_WM8731_SPI is not set
> # CONFIG_SND_SOC_WM8737 is not set
> # CONFIG_SND_SOC_WM8741 is not set
> # CONFIG_SND_SOC_WM8750 is not set
> # CONFIG_SND_SOC_WM8753 is not set
> # CONFIG_SND_SOC_WM8770 is not set
> # CONFIG_SND_SOC_WM8776 is not set
> # CONFIG_SND_SOC_WM8782 is not set
> CONFIG_SND_SOC_WM8804=3Dm
> CONFIG_SND_SOC_WM8804_I2C=3Dm
> # CONFIG_SND_SOC_WM8804_SPI is not set
> # CONFIG_SND_SOC_WM8903 is not set
> # CONFIG_SND_SOC_WM8904 is not set
> # CONFIG_SND_SOC_WM8940 is not set
> # CONFIG_SND_SOC_WM8960 is not set
> # CONFIG_SND_SOC_WM8961 is not set
> # CONFIG_SND_SOC_WM8962 is not set
> # CONFIG_SND_SOC_WM8974 is not set
> # CONFIG_SND_SOC_WM8978 is not set
> # CONFIG_SND_SOC_WM8985 is not set
> # CONFIG_SND_SOC_WSA881X is not set
> # CONFIG_SND_SOC_WSA883X is not set
> # CONFIG_SND_SOC_WSA884X is not set
> # CONFIG_SND_SOC_ZL38060 is not set
> # CONFIG_SND_SOC_MAX9759 is not set
> # CONFIG_SND_SOC_MT6351 is not set
> # CONFIG_SND_SOC_MT6357 is not set
> # CONFIG_SND_SOC_MT6358 is not set
> # CONFIG_SND_SOC_MT6660 is not set
> CONFIG_SND_SOC_NAU8315=3Dm
> # CONFIG_SND_SOC_NAU8540 is not set
> # CONFIG_SND_SOC_NAU8810 is not set
> CONFIG_SND_SOC_NAU8821=3Dm
> # CONFIG_SND_SOC_NAU8822 is not set
> CONFIG_SND_SOC_NAU8824=3Dm
> CONFIG_SND_SOC_NAU8825=3Dm
> # CONFIG_SND_SOC_NTP8918 is not set
> # CONFIG_SND_SOC_NTP8835 is not set
> # CONFIG_SND_SOC_TPA6130A2 is not set
> # CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_VA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_RX_MACRO is not set
> # CONFIG_SND_SOC_LPASS_TX_MACRO is not set
> # end of CODEC drivers
>
> CONFIG_SND_SOC_SDW_UTILS=3Dm
> # CONFIG_SND_SIMPLE_CARD is not set
> CONFIG_SND_X86=3Dy
> CONFIG_HDMI_LPE_AUDIO=3Dm
> CONFIG_SND_SYNTH_EMUX=3Dm
> CONFIG_SND_XEN_FRONTEND=3Dm
> CONFIG_SND_VIRTIO=3Dm
> CONFIG_AC97_BUS=3Dm
> CONFIG_HID_SUPPORT=3Dy
> CONFIG_HID=3Dy
> CONFIG_HID_BATTERY_STRENGTH=3Dy
> CONFIG_HIDRAW=3Dy
> CONFIG_UHID=3Dy
> CONFIG_HID_GENERIC=3Dy
>
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=3Dm
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=3Dm
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=3Dy
> CONFIG_HID_APPLEIR=3Dm
> CONFIG_HID_ASUS=3Dm
> CONFIG_HID_AUREAL=3Dm
> CONFIG_HID_BELKIN=3Dm
> CONFIG_HID_BETOP_FF=3Dm
> # CONFIG_HID_BIGBEN_FF is not set
> CONFIG_HID_CHERRY=3Dm
> CONFIG_HID_CHICONY=3Dm
> CONFIG_HID_CORSAIR=3Dm
> CONFIG_HID_COUGAR=3Dm
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_PRODIKEYS=3Dm
> CONFIG_HID_CMEDIA=3Dm
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> CONFIG_HID_CYPRESS=3Dm
> CONFIG_HID_DRAGONRISE=3Dm
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EMS_FF is not set
> CONFIG_HID_ELAN=3Dm
> CONFIG_HID_ELECOM=3Dm
> CONFIG_HID_ELO=3Dm
> CONFIG_HID_EVISION=3Dm
> CONFIG_HID_EZKEY=3Dm
> # CONFIG_HID_FT260 is not set
> CONFIG_HID_GEMBIRD=3Dm
> CONFIG_HID_GFRM=3Dm
> # CONFIG_HID_GLORIOUS is not set
> CONFIG_HID_HOLTEK=3Dm
> # CONFIG_HOLTEK_FF is not set
> # CONFIG_HID_GOODIX_SPI is not set
> # CONFIG_HID_GOOGLE_STADIA_FF is not set
> # CONFIG_HID_VIVALDI is not set
> CONFIG_HID_GT683R=3Dm
> CONFIG_HID_KEYTOUCH=3Dm
> CONFIG_HID_KYE=3Dm
> # CONFIG_HID_KYSONA is not set
> CONFIG_HID_UCLOGIC=3Dm
> CONFIG_HID_WALTOP=3Dm
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_VRC2 is not set
> CONFIG_HID_XIAOMI=3Dm
> CONFIG_HID_GYRATION=3Dm
> CONFIG_HID_ICADE=3Dm
> CONFIG_HID_ITE=3Dy
> CONFIG_HID_JABRA=3Dm
> CONFIG_HID_TWINHAN=3Dm
> CONFIG_HID_KENSINGTON=3Dm
> CONFIG_HID_LCPOWER=3Dm
> CONFIG_HID_LED=3Dm
> CONFIG_HID_LENOVO=3Dm
> CONFIG_HID_LETSKETCH=3Dm
> CONFIG_HID_LOGITECH=3Dm
> CONFIG_HID_LOGITECH_DJ=3Dm
> CONFIG_HID_LOGITECH_HIDPP=3Dm
> CONFIG_LOGITECH_FF=3Dy
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> CONFIG_HID_MAGICMOUSE=3Dy
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_MEGAWORLD_FF is not set
> # CONFIG_HID_REDRAGON is not set
> CONFIG_HID_MICROSOFT=3Dm
> CONFIG_HID_MONTEREY=3Dm
> CONFIG_HID_MULTITOUCH=3Dy
> # CONFIG_HID_NINTENDO is not set
> CONFIG_HID_NTI=3Dm
> CONFIG_HID_NTRIG=3Dy
> # CONFIG_HID_NVIDIA_SHIELD is not set
> CONFIG_HID_ORTEK=3Dm
> CONFIG_HID_PANTHERLORD=3Dm
> # CONFIG_PANTHERLORD_FF is not set
> CONFIG_HID_PENMOUNT=3Dm
> CONFIG_HID_PETALYNX=3Dm
> CONFIG_HID_PICOLCD=3Dm
> CONFIG_HID_PICOLCD_FB=3Dy
> CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> CONFIG_HID_PICOLCD_LCD=3Dy
> CONFIG_HID_PICOLCD_LEDS=3Dy
> # CONFIG_HID_PICOLCD_CIR is not set
> CONFIG_HID_PLANTRONICS=3Dm
> CONFIG_HID_PLAYSTATION=3Dy
> CONFIG_PLAYSTATION_FF=3Dy
> # CONFIG_HID_PXRC is not set
> # CONFIG_HID_RAZER is not set
> CONFIG_HID_PRIMAX=3Dm
> # CONFIG_HID_RETRODE is not set
> CONFIG_HID_ROCCAT=3Dm
> CONFIG_HID_SAITEK=3Dm
> CONFIG_HID_SAMSUNG=3Dm
> CONFIG_HID_SEMITEK=3Dm
> CONFIG_HID_SIGMAMICRO=3Dm
> CONFIG_HID_SONY=3Dy
> CONFIG_SONY_FF=3Dy
> CONFIG_HID_SPEEDLINK=3Dm
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=3Dm
> CONFIG_HID_SUNPLUS=3Dm
> CONFIG_HID_RMI=3Dm
> CONFIG_HID_GREENASIA=3Dm
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_HYPERV_MOUSE=3Dm
> CONFIG_HID_SMARTJOYPLUS=3Dm
> # CONFIG_SMARTJOYPLUS_FF is not set
> CONFIG_HID_TIVO=3Dm
> CONFIG_HID_TOPSEED=3Dm
> # CONFIG_HID_TOPRE is not set
> CONFIG_HID_THINGM=3Dm
> CONFIG_HID_THRUSTMASTER=3Dm
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> CONFIG_HID_WACOM=3Dy
> CONFIG_HID_WIIMOTE=3Dm
> # CONFIG_HID_WINWING is not set
> CONFIG_HID_XINMO=3Dm
> CONFIG_HID_ZEROPLUS=3Dm
> CONFIG_ZEROPLUS_FF=3Dy
> CONFIG_HID_ZYDACRON=3Dm
> CONFIG_HID_SENSOR_HUB=3Dy
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dm
> CONFIG_HID_ALPS=3Dm
> # CONFIG_HID_MCP2200 is not set
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
>
> #
> # HID-BPF support
> #
> CONFIG_HID_BPF=3Dy
> # end of HID-BPF support
>
> #
> # USB HID support
> #
> CONFIG_USB_HID=3Dy
> CONFIG_HID_PID=3Dy
> CONFIG_USB_HIDDEV=3Dy
> # end of USB HID support
>
> CONFIG_I2C_HID=3Dy
> CONFIG_I2C_HID_ACPI=3Dm
> # CONFIG_I2C_HID_OF is not set
> CONFIG_I2C_HID_CORE=3Dm
>
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=3Dm
> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
> # end of Intel ISH HID support
>
> #
> # AMD SFH HID Support
> #
> CONFIG_AMD_SFH_HID=3Dm
> # end of AMD SFH HID Support
>
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_SUPPORT=3Dy
> CONFIG_USB_COMMON=3Dy
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB=3Dy
> CONFIG_USB_PCI=3Dy
> CONFIG_USB_PCI_AMD=3Dy
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
>
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=3Dy
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dm
> CONFIG_USB_AUTOSUSPEND_DELAY=3D2
> CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=3D1
> CONFIG_USB_MON=3Dy
>
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=3Dy
> CONFIG_USB_XHCI_DBGCAP=3Dy
> CONFIG_USB_XHCI_PCI=3Dy
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> CONFIG_USB_XHCI_PLATFORM=3Dm
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> CONFIG_USB_EHCI_PCI=3Dy
> # CONFIG_USB_EHCI_FSL is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_PCI=3Dy
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=3Dy
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_BCMA is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
> # CONFIG_USB_XEN_HCD is not set
>
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=3Dm
> CONFIG_USB_PRINTER=3Dm
> CONFIG_USB_WDM=3Dm
> CONFIG_USB_TMC=3Dm
>
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
>
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_REALTEK=3Dm
> CONFIG_REALTEK_AUTOPM=3Dy
> CONFIG_USB_STORAGE_DATAFAB=3Dm
> CONFIG_USB_STORAGE_FREECOM=3Dm
> CONFIG_USB_STORAGE_ISD200=3Dm
> CONFIG_USB_STORAGE_USBAT=3Dm
> CONFIG_USB_STORAGE_SDDR09=3Dm
> CONFIG_USB_STORAGE_SDDR55=3Dm
> CONFIG_USB_STORAGE_JUMPSHOT=3Dm
> CONFIG_USB_STORAGE_ALAUDA=3Dm
> CONFIG_USB_STORAGE_ONETOUCH=3Dm
> CONFIG_USB_STORAGE_KARMA=3Dm
> CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
> CONFIG_USB_STORAGE_ENE_UB6250=3Dm
> CONFIG_USB_UAS=3Dm
>
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=3Dm
> CONFIG_USB_MICROTEK=3Dm
> # CONFIG_USBIP_CORE is not set
>
> #
> # USB dual-mode controller drivers
> #
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
>
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=3Dy
> CONFIG_USB_SERIAL_CONSOLE=3Dy
> CONFIG_USB_SERIAL_GENERIC=3Dy
> # CONFIG_USB_SERIAL_SIMPLE is not set
> CONFIG_USB_SERIAL_AIRCABLE=3Dm
> CONFIG_USB_SERIAL_ARK3116=3Dm
> CONFIG_USB_SERIAL_BELKIN=3Dm
> CONFIG_USB_SERIAL_CH341=3Dm
> CONFIG_USB_SERIAL_WHITEHEAT=3Dm
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
> CONFIG_USB_SERIAL_CP210X=3Dm
> CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
> CONFIG_USB_SERIAL_EMPEG=3Dm
> CONFIG_USB_SERIAL_FTDI_SIO=3Dm
> CONFIG_USB_SERIAL_VISOR=3Dm
> CONFIG_USB_SERIAL_IPAQ=3Dm
> CONFIG_USB_SERIAL_IR=3Dm
> CONFIG_USB_SERIAL_EDGEPORT=3Dm
> CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
> # CONFIG_USB_SERIAL_F81232 is not set
> CONFIG_USB_SERIAL_F8153X=3Dm
> CONFIG_USB_SERIAL_GARMIN=3Dm
> CONFIG_USB_SERIAL_IPW=3Dm
> CONFIG_USB_SERIAL_IUU=3Dm
> CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
> CONFIG_USB_SERIAL_KEYSPAN=3Dm
> CONFIG_USB_SERIAL_KLSI=3Dm
> CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
> CONFIG_USB_SERIAL_MCT_U232=3Dm
> # CONFIG_USB_SERIAL_METRO is not set
> CONFIG_USB_SERIAL_MOS7720=3Dm
> CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
> CONFIG_USB_SERIAL_MOS7840=3Dm
> CONFIG_USB_SERIAL_MXUPORT=3Dm
> CONFIG_USB_SERIAL_NAVMAN=3Dm
> CONFIG_USB_SERIAL_PL2303=3Dm
> CONFIG_USB_SERIAL_OTI6858=3Dm
> CONFIG_USB_SERIAL_QCAUX=3Dm
> CONFIG_USB_SERIAL_QUALCOMM=3Dm
> CONFIG_USB_SERIAL_SPCP8X5=3Dm
> CONFIG_USB_SERIAL_SAFE=3Dm
> CONFIG_USB_SERIAL_SAFE_PADDED=3Dy
> CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
> CONFIG_USB_SERIAL_SYMBOL=3Dm
> # CONFIG_USB_SERIAL_TI is not set
> CONFIG_USB_SERIAL_CYBERJACK=3Dm
> CONFIG_USB_SERIAL_WWAN=3Dm
> CONFIG_USB_SERIAL_OPTION=3Dm
> CONFIG_USB_SERIAL_OMNINET=3Dm
> CONFIG_USB_SERIAL_OPTICON=3Dm
> CONFIG_USB_SERIAL_XSENS_MT=3Dm
> # CONFIG_USB_SERIAL_WISHBONE is not set
> CONFIG_USB_SERIAL_SSU100=3Dm
> CONFIG_USB_SERIAL_QT2=3Dm
> CONFIG_USB_SERIAL_UPD78F0730=3Dm
> # CONFIG_USB_SERIAL_XR is not set
> CONFIG_USB_SERIAL_DEBUG=3Dm
>
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_USS720=3Dm
> CONFIG_USB_EMI62=3Dm
> CONFIG_USB_EMI26=3Dm
> CONFIG_USB_ADUTUX=3Dm
> CONFIG_USB_SEVSEG=3Dm
> CONFIG_USB_LEGOTOWER=3Dm
> CONFIG_USB_LCD=3Dm
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> CONFIG_USB_IDMOUSE=3Dm
> CONFIG_USB_APPLEDISPLAY=3Dm
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_LJCA is not set
> CONFIG_USB_SISUSBVGA=3Dm
> CONFIG_USB_LD=3Dm
> # CONFIG_USB_TRANCEVIBRATOR is not set
> CONFIG_USB_IOWARRIOR=3Dm
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> CONFIG_USB_ISIGHTFW=3Dm
> # CONFIG_USB_YUREX is not set
> CONFIG_USB_EZUSB_FX2=3Dm
> # CONFIG_USB_HUB_USB251XB is not set
> CONFIG_USB_HSIC_USB3503=3Dm
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> CONFIG_USB_ATM=3Dm
> CONFIG_USB_SPEEDTOUCH=3Dm
> CONFIG_USB_CXACRU=3Dm
> CONFIG_USB_UEAGLEATM=3Dm
> CONFIG_USB_XUSBATM=3Dm
>
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
>
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=3Dy
> CONFIG_TYPEC_TCPM=3Dm
> CONFIG_TYPEC_TCPCI=3Dm
> # CONFIG_TYPEC_RT1711H is not set
> # CONFIG_TYPEC_TCPCI_MAXIM is not set
> CONFIG_TYPEC_FUSB302=3Dm
> CONFIG_TYPEC_UCSI=3Dy
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=3Dy
> # CONFIG_UCSI_STM32G0 is not set
> CONFIG_TYPEC_TPS6598X=3Dm
> # CONFIG_TYPEC_ANX7411 is not set
> CONFIG_TYPEC_RT1719=3Dm
> # CONFIG_TYPEC_HD3SS3220 is not set
> # CONFIG_TYPEC_STUSB160X is not set
> CONFIG_TYPEC_WUSB3801=3Dm
>
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> CONFIG_TYPEC_MUX_FSA4480=3Dm
> # CONFIG_TYPEC_MUX_GPIO_SBU is not set
> CONFIG_TYPEC_MUX_PI3USB30532=3Dm
> # CONFIG_TYPEC_MUX_IT5205 is not set
> # CONFIG_TYPEC_MUX_NB7VPQ904M is not set
> # CONFIG_TYPEC_MUX_PTN36502 is not set
> # CONFIG_TYPEC_MUX_TUSB1046 is not set
> # CONFIG_TYPEC_MUX_WCD939X_USBSS is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
>
> #
> # USB Type-C Alternate Mode drivers
> #
> CONFIG_TYPEC_DP_ALTMODE=3Dm
> # CONFIG_TYPEC_NVIDIA_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
>
> CONFIG_USB_ROLE_SWITCH=3Dy
> CONFIG_USB_ROLES_INTEL_XHCI=3Dm
> CONFIG_MMC=3Dm
> CONFIG_MMC_BLOCK=3Dm
> CONFIG_MMC_BLOCK_MINORS=3D8
> CONFIG_SDIO_UART=3Dm
> # CONFIG_MMC_TEST is not set
>
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=3Dm
> CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
> CONFIG_MMC_SDHCI_UHS2=3Dm
> CONFIG_MMC_SDHCI_PCI=3Dm
> CONFIG_MMC_RICOH_MMC=3Dy
> CONFIG_MMC_SDHCI_ACPI=3Dm
> CONFIG_MMC_SDHCI_PLTFM=3Dm
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> # CONFIG_MMC_WBSD is not set
> CONFIG_MMC_TIFM_SD=3Dm
> # CONFIG_MMC_SPI is not set
> CONFIG_MMC_CB710=3Dm
> CONFIG_MMC_VIA_SDMMC=3Dm
> CONFIG_MMC_VUB300=3Dm
> CONFIG_MMC_USHC=3Dm
> # CONFIG_MMC_USDHI6ROL0 is not set
> CONFIG_MMC_REALTEK_PCI=3Dm
> CONFIG_MMC_REALTEK_USB=3Dm
> CONFIG_MMC_CQHCI=3Dm
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_MMC_SDHCI_XENON is not set
> # CONFIG_SCSI_UFSHCD is not set
> CONFIG_MEMSTICK=3Dm
> # CONFIG_MEMSTICK_DEBUG is not set
>
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> CONFIG_MSPRO_BLOCK=3Dm
> # CONFIG_MS_BLOCK is not set
>
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=3Dm
> CONFIG_MEMSTICK_JMICRON_38X=3Dm
> CONFIG_MEMSTICK_R592=3Dm
> CONFIG_MEMSTICK_REALTEK_USB=3Dm
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=3Dy
> CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=3Dy
>
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_AW200XX is not set
> CONFIG_LEDS_LM3530=3Dm
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=3Dm
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP50XX is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_PCA995X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2606MVV is not set
> # CONFIG_LEDS_BD2802 is not set
> CONFIG_LEDS_INTEL_SS4200=3Dm
> CONFIG_LEDS_LT3593=3Dm
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> # CONFIG_LEDS_IS31FL319X is not set
>
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T=
HINGM)
> #
> CONFIG_LEDS_BLINKM=3Dm
> # CONFIG_LEDS_BLINKM_MULTICOLOR is not set
> CONFIG_LEDS_MLXCPLD=3Dm
> CONFIG_LEDS_MLXREG=3Dm
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_SPI_BYTE is not set
>
> #
> # Flash and Torch LED drivers
> #
>
> #
> # RGB LED drivers
> #
> # CONFIG_LEDS_KTD202X is not set
> # CONFIG_LEDS_PWM_MULTICOLOR is not set
>
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=3Dy
> CONFIG_LEDS_TRIGGER_TIMER=3Dm
> CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
> CONFIG_LEDS_TRIGGER_DISK=3Dy
> # CONFIG_LEDS_TRIGGER_MTD is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
> CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_GPIO=3Dm
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
>
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
> CONFIG_LEDS_TRIGGER_CAMERA=3Dm
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> # CONFIG_LEDS_TRIGGER_TTY is not set
> # CONFIG_LEDS_TRIGGER_INPUT_EVENTS is not set
>
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_INFINIBAND=3Dm
> CONFIG_INFINIBAND_USER_MAD=3Dm
> CONFIG_INFINIBAND_USER_ACCESS=3Dm
> CONFIG_INFINIBAND_USER_MEM=3Dy
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
> CONFIG_INFINIBAND_VIRT_DMA=3Dy
> CONFIG_INFINIBAND_BNXT_RE=3Dm
> CONFIG_INFINIBAND_CXGB4=3Dm
> CONFIG_INFINIBAND_EFA=3Dm
> # CONFIG_INFINIBAND_ERDMA is not set
> CONFIG_INFINIBAND_HFI1=3Dm
> # CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
> # CONFIG_SDMA_VERBOSITY is not set
> CONFIG_INFINIBAND_IRDMA=3Dm
> CONFIG_MANA_INFINIBAND=3Dm
> CONFIG_MLX4_INFINIBAND=3Dm
> CONFIG_MLX5_INFINIBAND=3Dm
> # CONFIG_INFINIBAND_MTHCA is not set
> # CONFIG_INFINIBAND_OCRDMA is not set
> CONFIG_INFINIBAND_QEDR=3Dm
> # CONFIG_INFINIBAND_QIB is not set
> CONFIG_INFINIBAND_USNIC=3Dm
> CONFIG_INFINIBAND_VMWARE_PVRDMA=3Dm
> CONFIG_INFINIBAND_RDMAVT=3Dm
> CONFIG_RDMA_RXE=3Dm
> CONFIG_RDMA_SIW=3Dm
> CONFIG_INFINIBAND_IPOIB=3Dm
> CONFIG_INFINIBAND_IPOIB_CM=3Dy
> CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> CONFIG_INFINIBAND_SRP=3Dm
> CONFIG_INFINIBAND_SRPT=3Dm
> CONFIG_INFINIBAND_ISER=3Dm
> CONFIG_INFINIBAND_ISERT=3Dm
> # CONFIG_INFINIBAND_RTRS_CLIENT is not set
> # CONFIG_INFINIBAND_RTRS_SERVER is not set
> CONFIG_INFINIBAND_OPA_VNIC=3Dm
> CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> CONFIG_EDAC_SUPPORT=3Dy
> CONFIG_EDAC=3Dy
> CONFIG_EDAC_LEGACY_SYSFS=3Dy
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_DECODE_MCE=3Dm
> CONFIG_EDAC_GHES=3Dy
> CONFIG_EDAC_AMD64=3Dm
> CONFIG_EDAC_E752X=3Dm
> CONFIG_EDAC_I82975X=3Dm
> CONFIG_EDAC_I3000=3Dm
> CONFIG_EDAC_I3200=3Dm
> CONFIG_EDAC_IE31200=3Dm
> CONFIG_EDAC_X38=3Dm
> CONFIG_EDAC_I5400=3Dm
> CONFIG_EDAC_I7CORE=3Dm
> CONFIG_EDAC_I5100=3Dm
> CONFIG_EDAC_I7300=3Dm
> CONFIG_EDAC_SBRIDGE=3Dm
> CONFIG_EDAC_SKX=3Dm
> CONFIG_EDAC_I10NM=3Dm
> CONFIG_EDAC_PND2=3Dm
> CONFIG_EDAC_IGEN6=3Dm
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_MC146818_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_HCTOSYS=3Dy
> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> CONFIG_RTC_SYSTOHC=3Dy
> CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=3Dy
>
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
>
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=3Dm
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=3Dm
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=3Dm
> CONFIG_RTC_DRV_MAX6900=3Dm
> # CONFIG_RTC_DRV_MAX31335 is not set
> CONFIG_RTC_DRV_RS5C372=3Dm
> CONFIG_RTC_DRV_ISL1208=3Dm
> CONFIG_RTC_DRV_ISL12022=3Dm
> CONFIG_RTC_DRV_X1205=3Dm
> CONFIG_RTC_DRV_PCF8523=3Dm
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=3Dm
> CONFIG_RTC_DRV_PCF8583=3Dm
> CONFIG_RTC_DRV_M41T80=3Dm
> CONFIG_RTC_DRV_M41T80_WDT=3Dy
> CONFIG_RTC_DRV_BQ32K=3Dm
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=3Dm
> # CONFIG_RTC_DRV_RX8010 is not set
> # CONFIG_RTC_DRV_RX8111 is not set
> CONFIG_RTC_DRV_RX8581=3Dm
> CONFIG_RTC_DRV_RX8025=3Dm
> CONFIG_RTC_DRV_EM3027=3Dm
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> CONFIG_RTC_DRV_RV8803=3Dm
> # CONFIG_RTC_DRV_SD2405AL is not set
> # CONFIG_RTC_DRV_SD3078 is not set
>
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> CONFIG_RTC_DRV_RX4581=3Dm
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=3Dy
>
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=3Dm
> CONFIG_RTC_DRV_DS3232_HWMON=3Dy
> # CONFIG_RTC_DRV_PCF2127 is not set
> CONFIG_RTC_DRV_RV3029C2=3Dm
> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> # CONFIG_RTC_DRV_RX6110 is not set
>
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=3Dy
> CONFIG_RTC_DRV_DS1286=3Dm
> CONFIG_RTC_DRV_DS1511=3Dm
> CONFIG_RTC_DRV_DS1553=3Dm
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=3Dm
> CONFIG_RTC_DRV_DS2404=3Dm
> CONFIG_RTC_DRV_STK17TA8=3Dm
> # CONFIG_RTC_DRV_M48T86 is not set
> CONFIG_RTC_DRV_M48T35=3Dm
> CONFIG_RTC_DRV_M48T59=3Dm
> CONFIG_RTC_DRV_MSM6242=3Dm
> CONFIG_RTC_DRV_RP5C01=3Dm
>
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
>
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=3Dy
> # CONFIG_DMADEVICES_DEBUG is not set
>
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=3Dy
> CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> CONFIG_DMA_ACPI=3Dy
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=3Dm
> CONFIG_INTEL_IDXD_BUS=3Dm
> CONFIG_INTEL_IDXD=3Dm
> # CONFIG_INTEL_IDXD_COMPAT is not set
> CONFIG_INTEL_IDXD_SVM=3Dy
> CONFIG_INTEL_IDXD_PERFMON=3Dy
> CONFIG_INTEL_IOATDMA=3Dm
> # CONFIG_PLX_DMA is not set
> # CONFIG_XILINX_DMA is not set
> # CONFIG_XILINX_XDMA is not set
> # CONFIG_AMD_QDMA is not set
> CONFIG_AMD_PTDMA=3Dm
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=3Dy
> CONFIG_DW_DMAC=3Dm
> CONFIG_DW_DMAC_PCI=3Dy
> # CONFIG_DW_EDMA is not set
> CONFIG_HSU_DMA=3Dy
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
>
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=3Dy
> CONFIG_DMATEST=3Dm
> CONFIG_DMA_ENGINE_RAID=3Dy
>
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=3Dy
> # CONFIG_SW_SYNC is not set
> CONFIG_UDMABUF=3Dy
> CONFIG_DMABUF_MOVE_NOTIFY=3Dy
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> CONFIG_DMABUF_HEAPS=3Dy
> # CONFIG_DMABUF_SYSFS_STATS is not set
> CONFIG_DMABUF_HEAPS_SYSTEM=3Dy
> # CONFIG_DMABUF_HEAPS_CMA is not set
> # end of DMABUF options
>
> CONFIG_DCA=3Dm
> CONFIG_UIO=3Dm
> # CONFIG_UIO_CIF is not set
> # CONFIG_UIO_PDRV_GENIRQ is not set
> # CONFIG_UIO_DMEM_GENIRQ is not set
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> CONFIG_UIO_PCI_GENERIC=3Dm
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_MF624 is not set
> CONFIG_UIO_HV_GENERIC=3Dm
> CONFIG_VFIO=3Dm
> CONFIG_VFIO_DEVICE_CDEV=3Dy
> CONFIG_VFIO_GROUP=3Dy
> CONFIG_VFIO_CONTAINER=3Dy
> CONFIG_VFIO_IOMMU_TYPE1=3Dm
> CONFIG_VFIO_NOIOMMU=3Dy
> CONFIG_VFIO_VIRQFD=3Dy
> # CONFIG_VFIO_DEBUGFS is not set
>
> #
> # VFIO support for PCI devices
> #
> CONFIG_VFIO_PCI_CORE=3Dm
> CONFIG_VFIO_PCI_MMAP=3Dy
> CONFIG_VFIO_PCI_INTX=3Dy
> CONFIG_VFIO_PCI=3Dm
> # CONFIG_VFIO_PCI_VGA is not set
> # CONFIG_VFIO_PCI_IGD is not set
> CONFIG_MLX5_VFIO_PCI=3Dm
> # CONFIG_VIRTIO_VFIO_PCI is not set
> # CONFIG_QAT_VFIO_PCI is not set
> # end of VFIO support for PCI devices
>
> CONFIG_VFIO_MDEV=3Dm
> CONFIG_IRQ_BYPASS_MANAGER=3Dy
> CONFIG_VIRT_DRIVERS=3Dy
> CONFIG_VMGENID=3Dy
> # CONFIG_VBOXGUEST is not set
> CONFIG_NITRO_ENCLAVES=3Dm
> CONFIG_TSM_REPORTS=3Dm
> CONFIG_EFI_SECRET=3Dm
> CONFIG_SEV_GUEST=3Dm
> CONFIG_TDX_GUEST_DRIVER=3Dm
> CONFIG_VIRTIO_ANCHOR=3Dy
> CONFIG_VIRTIO=3Dy
> CONFIG_VIRTIO_PCI_LIB=3Dy
> CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy
> CONFIG_VIRTIO_MENU=3Dy
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_PCI_ADMIN_LEGACY=3Dy
> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> CONFIG_VIRTIO_VDPA=3Dm
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=3Dm
> CONFIG_VIRTIO_MEM=3Dm
> CONFIG_VIRTIO_INPUT=3Dm
> # CONFIG_VIRTIO_MMIO is not set
> CONFIG_VIRTIO_DMA_SHARED_BUFFER=3Dm
> # CONFIG_VIRTIO_DEBUG is not set
> CONFIG_VDPA=3Dm
> CONFIG_VDPA_SIM=3Dm
> CONFIG_VDPA_SIM_NET=3Dm
> CONFIG_VDPA_SIM_BLOCK=3Dm
> # CONFIG_VDPA_USER is not set
> CONFIG_IFCVF=3Dm
> CONFIG_MLX5_VDPA=3Dy
> CONFIG_MLX5_VDPA_NET=3Dm
> # CONFIG_MLX5_VDPA_STEERING_DEBUG is not set
> CONFIG_VP_VDPA=3Dm
> # CONFIG_ALIBABA_ENI_VDPA is not set
> # CONFIG_SNET_VDPA is not set
> # CONFIG_OCTEONEP_VDPA is not set
> CONFIG_VHOST_IOTLB=3Dm
> CONFIG_VHOST_RING=3Dm
> CONFIG_VHOST_TASK=3Dy
> CONFIG_VHOST=3Dm
> CONFIG_VHOST_MENU=3Dy
> CONFIG_VHOST_NET=3Dm
> # CONFIG_VHOST_SCSI is not set
> CONFIG_VHOST_VSOCK=3Dm
> CONFIG_VHOST_VDPA=3Dm
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=3Dm
> # CONFIG_HYPERV_VTL_MODE is not set
> CONFIG_HYPERV_TIMER=3Dy
> CONFIG_HYPERV_UTILS=3Dm
> CONFIG_HYPERV_BALLOON=3Dm
> # end of Microsoft Hyper-V guest support
>
> #
> # Xen driver support
> #
> # CONFIG_XEN_BALLOON is not set
> CONFIG_XEN_DEV_EVTCHN=3Dm
> # CONFIG_XEN_BACKEND is not set
> CONFIG_XENFS=3Dm
> CONFIG_XEN_COMPAT_XENFS=3Dy
> CONFIG_XEN_SYS_HYPERVISOR=3Dy
> CONFIG_XEN_XENBUS_FRONTEND=3Dy
> # CONFIG_XEN_GNTDEV is not set
> # CONFIG_XEN_GRANT_DEV_ALLOC is not set
> # CONFIG_XEN_GRANT_DMA_ALLOC is not set
> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> CONFIG_XEN_PRIVCMD=3Dm
> CONFIG_XEN_EFI=3Dy
> CONFIG_XEN_AUTO_XLATE=3Dy
> CONFIG_XEN_ACPI=3Dy
> CONFIG_XEN_FRONT_PGDIR_SHBUF=3Dm
> # CONFIG_XEN_UNPOPULATED_ALLOC is not set
> # CONFIG_XEN_VIRTIO is not set
> # end of Xen driver support
>
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> # CONFIG_GOLDFISH is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_CZNIC_PLATFORMS is not set
> CONFIG_MELLANOX_PLATFORM=3Dy
> CONFIG_MLXREG_HOTPLUG=3Dm
> CONFIG_MLXREG_IO=3Dm
> CONFIG_MLXREG_LC=3Dm
> CONFIG_NVSW_SN2201=3Dm
> # CONFIG_SURFACE_PLATFORMS is not set
> CONFIG_X86_PLATFORM_DEVICES=3Dy
> CONFIG_ACPI_WMI=3Dm
> CONFIG_WMI_BMOF=3Dm
> # CONFIG_HUAWEI_WMI is not set
> CONFIG_UV_SYSFS=3Dm
> CONFIG_MXM_WMI=3Dm
> CONFIG_NVIDIA_WMI_EC_BACKLIGHT=3Dm
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> # CONFIG_YOGABOOK is not set
> # CONFIG_ACERHDF is not set
> CONFIG_ACER_WIRELESS=3Dm
> CONFIG_ACER_WMI=3Dm
>
> #
> # AMD HSMP Driver
> #
> # CONFIG_AMD_HSMP_ACPI is not set
> # CONFIG_AMD_HSMP_PLAT is not set
> # end of AMD HSMP Driver
>
> CONFIG_AMD_PMC=3Dm
> CONFIG_AMD_MP2_STB=3Dy
> # CONFIG_AMD_3D_VCACHE is not set
> # CONFIG_AMD_WBRF is not set
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=3Dm
> CONFIG_ASUS_LAPTOP=3Dm
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ASUS_WMI=3Dm
> CONFIG_ASUS_NB_WMI=3Dm
> # CONFIG_ASUS_TF103C_DOCK is not set
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_EEEPC_LAPTOP=3Dm
> CONFIG_EEEPC_WMI=3Dm
> CONFIG_X86_PLATFORM_DRIVERS_DELL=3Dy
> # CONFIG_ALIENWARE_WMI is not set
> CONFIG_DCDBAS=3Dm
> CONFIG_DELL_LAPTOP=3Dm
> CONFIG_DELL_RBU=3Dm
> CONFIG_DELL_RBTN=3Dm
> CONFIG_DELL_PC=3Dm
> CONFIG_DELL_SMBIOS=3Dm
> CONFIG_DELL_SMBIOS_WMI=3Dy
> # CONFIG_DELL_SMBIOS_SMM is not set
> CONFIG_DELL_SMO8800=3Dm
> CONFIG_DELL_WMI=3Dm
> CONFIG_DELL_WMI_PRIVACY=3Dy
> CONFIG_DELL_WMI_AIO=3Dm
> CONFIG_DELL_WMI_DESCRIPTOR=3Dm
> CONFIG_DELL_WMI_DDV=3Dm
> CONFIG_DELL_WMI_LED=3Dm
> CONFIG_DELL_WMI_SYSMAN=3Dm
> CONFIG_AMILO_RFKILL=3Dm
> CONFIG_FUJITSU_LAPTOP=3Dm
> CONFIG_FUJITSU_TABLET=3Dm
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_X86_PLATFORM_DRIVERS_HP is not set
> CONFIG_WIRELESS_HOTKEY=3Dm
> # CONFIG_IBM_RTL is not set
> CONFIG_IDEAPAD_LAPTOP=3Dm
> # CONFIG_LENOVO_YMC is not set
> CONFIG_SENSORS_HDAPS=3Dm
> CONFIG_THINKPAD_ACPI=3Dm
> CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=3Dy
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
> CONFIG_THINKPAD_LMI=3Dm
> # CONFIG_INTEL_ATOMISP2_PM is not set
> CONFIG_INTEL_IFS=3Dm
> # CONFIG_INTEL_SAR_INT1092 is not set
> CONFIG_INTEL_PMC_CORE=3Dm
> CONFIG_INTEL_PMT_CLASS=3Dm
> CONFIG_INTEL_PMT_TELEMETRY=3Dm
> CONFIG_INTEL_PMT_CRASHLOG=3Dm
>
> #
> # Intel Speed Select Technology interface support
> #
> CONFIG_INTEL_SPEED_SELECT_TPMI=3Dm
> CONFIG_INTEL_SPEED_SELECT_INTERFACE=3Dm
> # end of Intel Speed Select Technology interface support
>
> CONFIG_INTEL_WMI=3Dy
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> CONFIG_INTEL_WMI_THUNDERBOLT=3Dm
>
> #
> # Intel Uncore Frequency Control
> #
> CONFIG_INTEL_UNCORE_FREQ_CONTROL_TPMI=3Dm
> CONFIG_INTEL_UNCORE_FREQ_CONTROL=3Dm
> # end of Intel Uncore Frequency Control
>
> CONFIG_INTEL_HID_EVENT=3Dm
> CONFIG_INTEL_VBTN=3Dm
> # CONFIG_INTEL_INT0002_VGPIO is not set
> CONFIG_INTEL_OAKTRAIL=3Dm
> CONFIG_INTEL_ISHTP_ECLITE=3Dm
> # CONFIG_INTEL_PUNIT_IPC is not set
> CONFIG_INTEL_RST=3Dm
> CONFIG_INTEL_SDSI=3Dm
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_TPMI_POWER_DOMAINS=3Dm
> CONFIG_INTEL_TPMI=3Dm
> # CONFIG_INTEL_PLR_TPMI is not set
> CONFIG_INTEL_TURBO_MAX_3=3Dy
> CONFIG_INTEL_VSEC=3Dm
> # CONFIG_ACPI_QUICKSTART is not set
> # CONFIG_MEEGOPAD_ANX7428 is not set
> # CONFIG_MSI_EC is not set
> CONFIG_MSI_LAPTOP=3Dm
> CONFIG_MSI_WMI=3Dm
> # CONFIG_MSI_WMI_PLATFORM is not set
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> CONFIG_SAMSUNG_LAPTOP=3Dm
> CONFIG_SAMSUNG_Q10=3Dm
> # CONFIG_ACPI_TOSHIBA is not set
> CONFIG_TOSHIBA_BT_RFKILL=3Dm
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> # CONFIG_ACPI_CMPC is not set
> CONFIG_COMPAL_LAPTOP=3Dm
> # CONFIG_LG_LAPTOP is not set
> CONFIG_PANASONIC_LAPTOP=3Dm
> CONFIG_SONY_LAPTOP=3Dm
> CONFIG_SONYPI_COMPAT=3Dy
> # CONFIG_SYSTEM76_ACPI is not set
> CONFIG_TOPSTAR_LAPTOP=3Dm
> CONFIG_SERIAL_MULTI_INSTANTIATE=3Dm
> CONFIG_MLX_PLATFORM=3Dm
> # CONFIG_INSPUR_PLATFORM_PROFILE is not set
> # CONFIG_LENOVO_WMI_CAMERA is not set
> CONFIG_FW_ATTR_CLASS=3Dm
> CONFIG_INTEL_IPS=3Dm
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> # CONFIG_SILICOM_PLATFORM is not set
> # CONFIG_WINMATE_FM07_KEYS is not set
> # CONFIG_SEL3350_PLATFORM is not set
> CONFIG_P2SB=3Dy
> CONFIG_HAVE_CLK=3Dy
> CONFIG_HAVE_CLK_PREPARE=3Dy
> CONFIG_COMMON_CLK=3Dy
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_HWSPINLOCK=3Dy
>
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=3Dy
> CONFIG_I8253_LOCK=3Dy
> CONFIG_CLKBLD_I8253=3Dy
> # end of Clock Source drivers
>
> CONFIG_MAILBOX=3Dy
> CONFIG_PCC=3Dy
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=3Dy
> CONFIG_IOMMU_API=3Dy
> CONFIG_IOMMUFD_DRIVER=3Dy
> CONFIG_IOMMU_SUPPORT=3Dy
>
> #
> # Generic IOMMU Pagetable Support
> #
> CONFIG_IOMMU_IO_PGTABLE=3Dy
> # end of Generic IOMMU Pagetable Support
>
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=3Dy
> CONFIG_IOMMU_SVA=3Dy
> CONFIG_IOMMU_IOPF=3Dy
> CONFIG_AMD_IOMMU=3Dy
> CONFIG_DMAR_TABLE=3Dy
> CONFIG_INTEL_IOMMU=3Dy
> CONFIG_INTEL_IOMMU_SVM=3Dy
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
> # CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_PERF_EVENTS=3Dy
> CONFIG_IOMMUFD_DRIVER_CORE=3Dy
> CONFIG_IOMMUFD=3Dm
> # CONFIG_IOMMUFD_TEST is not set
> CONFIG_IRQ_REMAP=3Dy
> CONFIG_HYPERV_IOMMU=3Dy
> CONFIG_VIRTIO_IOMMU=3Dy
>
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
>
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
>
> CONFIG_SOUNDWIRE=3Dm
>
> #
> # SoundWire Devices
> #
> CONFIG_SOUNDWIRE_AMD=3Dm
> CONFIG_SOUNDWIRE_CADENCE=3Dm
> CONFIG_SOUNDWIRE_INTEL=3Dm
> # CONFIG_SOUNDWIRE_QCOM is not set
> CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=3Dm
>
> #
> # SOC (System On Chip) specific Drivers
> #
>
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
>
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
>
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
>
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
>
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
>
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
>
> # CONFIG_WPCM450_SOC is not set
>
> #
> # Qualcomm SoC drivers
> #
> CONFIG_QCOM_QMI_HELPERS=3Dm
> # end of Qualcomm SoC drivers
>
> # CONFIG_SOC_TI is not set
>
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
>
> #
> # PM Domains
> #
>
> #
> # Amlogic PM Domains
> #
> # end of Amlogic PM Domains
>
> #
> # Broadcom PM Domains
> #
> # end of Broadcom PM Domains
>
> #
> # i.MX PM Domains
> #
> # end of i.MX PM Domains
>
> #
> # Qualcomm PM Domains
> #
> # end of Qualcomm PM Domains
> # end of PM Domains
>
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> CONFIG_IIO=3Dm
> CONFIG_IIO_BUFFER=3Dy
> # CONFIG_IIO_BUFFER_CB is not set
> # CONFIG_IIO_BUFFER_DMA is not set
> # CONFIG_IIO_BUFFER_DMAENGINE is not set
> # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> CONFIG_IIO_KFIFO_BUF=3Dm
> CONFIG_IIO_TRIGGERED_BUFFER=3Dm
> # CONFIG_IIO_CONFIGFS is not set
> CONFIG_IIO_TRIGGER=3Dy
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
> # CONFIG_IIO_SW_DEVICE is not set
> # CONFIG_IIO_SW_TRIGGER is not set
> # CONFIG_IIO_TRIGGERED_EVENT is not set
>
> #
> # Accelerometers
> #
> # CONFIG_ADIS16201 is not set
> # CONFIG_ADIS16209 is not set
> # CONFIG_ADXL313_I2C is not set
> # CONFIG_ADXL313_SPI is not set
> # CONFIG_ADXL345_I2C is not set
> # CONFIG_ADXL345_SPI is not set
> # CONFIG_ADXL355_I2C is not set
> # CONFIG_ADXL355_SPI is not set
> # CONFIG_ADXL367_SPI is not set
> # CONFIG_ADXL367_I2C is not set
> # CONFIG_ADXL372_SPI is not set
> # CONFIG_ADXL372_I2C is not set
> # CONFIG_ADXL380_SPI is not set
> # CONFIG_ADXL380_I2C is not set
> # CONFIG_BMA180 is not set
> # CONFIG_BMA220 is not set
> # CONFIG_BMA400 is not set
> # CONFIG_BMC150_ACCEL is not set
> # CONFIG_BMI088_ACCEL is not set
> # CONFIG_DA280 is not set
> # CONFIG_DA311 is not set
> # CONFIG_DMARD06 is not set
> # CONFIG_DMARD09 is not set
> # CONFIG_DMARD10 is not set
> # CONFIG_FXLS8962AF_I2C is not set
> # CONFIG_FXLS8962AF_SPI is not set
> CONFIG_HID_SENSOR_ACCEL_3D=3Dm
> # CONFIG_IIO_ST_ACCEL_3AXIS is not set
> # CONFIG_IIO_KX022A_SPI is not set
> # CONFIG_IIO_KX022A_I2C is not set
> # CONFIG_KXSD9 is not set
> # CONFIG_KXCJK1013 is not set
> # CONFIG_MC3230 is not set
> # CONFIG_MMA7455_I2C is not set
> # CONFIG_MMA7455_SPI is not set
> # CONFIG_MMA7660 is not set
> # CONFIG_MMA8452 is not set
> # CONFIG_MMA9551 is not set
> # CONFIG_MMA9553 is not set
> # CONFIG_MSA311 is not set
> # CONFIG_MXC4005 is not set
> # CONFIG_MXC6255 is not set
> # CONFIG_SCA3000 is not set
> # CONFIG_SCA3300 is not set
> # CONFIG_STK8312 is not set
> # CONFIG_STK8BA50 is not set
> # end of Accelerometers
>
> #
> # Analog to digital converters
> #
> # CONFIG_AD4000 is not set
> # CONFIG_AD4130 is not set
> # CONFIG_AD4695 is not set
> # CONFIG_AD7091R5 is not set
> # CONFIG_AD7091R8 is not set
> # CONFIG_AD7124 is not set
> # CONFIG_AD7173 is not set
> # CONFIG_AD7192 is not set
> # CONFIG_AD7266 is not set
> # CONFIG_AD7280 is not set
> # CONFIG_AD7291 is not set
> # CONFIG_AD7292 is not set
> # CONFIG_AD7298 is not set
> # CONFIG_AD7380 is not set
> # CONFIG_AD7476 is not set
> # CONFIG_AD7606_IFACE_PARALLEL is not set
> # CONFIG_AD7606_IFACE_SPI is not set
> # CONFIG_AD7625 is not set
> # CONFIG_AD7766 is not set
> # CONFIG_AD7768_1 is not set
> # CONFIG_AD7779 is not set
> # CONFIG_AD7780 is not set
> # CONFIG_AD7791 is not set
> # CONFIG_AD7793 is not set
> # CONFIG_AD7887 is not set
> # CONFIG_AD7923 is not set
> # CONFIG_AD7944 is not set
> # CONFIG_AD7949 is not set
> # CONFIG_AD799X is not set
> # CONFIG_AD9467 is not set
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_GEHC_PMC_ADC is not set
> # CONFIG_HI8435 is not set
> # CONFIG_HX711 is not set
> # CONFIG_INA2XX_ADC is not set
> # CONFIG_LTC2309 is not set
> # CONFIG_LTC2471 is not set
> # CONFIG_LTC2485 is not set
> # CONFIG_LTC2496 is not set
> # CONFIG_LTC2497 is not set
> # CONFIG_MAX1027 is not set
> # CONFIG_MAX11100 is not set
> # CONFIG_MAX1118 is not set
> # CONFIG_MAX11205 is not set
> # CONFIG_MAX11410 is not set
> # CONFIG_MAX1241 is not set
> # CONFIG_MAX1363 is not set
> # CONFIG_MAX34408 is not set
> # CONFIG_MAX9611 is not set
> # CONFIG_MCP320X is not set
> # CONFIG_MCP3422 is not set
> # CONFIG_MCP3564 is not set
> # CONFIG_MCP3911 is not set
> # CONFIG_NAU7802 is not set
> # CONFIG_PAC1921 is not set
> # CONFIG_PAC1934 is not set
> # CONFIG_RICHTEK_RTQ6056 is not set
> # CONFIG_SD_ADC_MODULATOR is not set
> # CONFIG_TI_ADC081C is not set
> # CONFIG_TI_ADC0832 is not set
> # CONFIG_TI_ADC084S021 is not set
> # CONFIG_TI_ADC12138 is not set
> # CONFIG_TI_ADC108S102 is not set
> # CONFIG_TI_ADC128S052 is not set
> # CONFIG_TI_ADC161S626 is not set
> # CONFIG_TI_ADS1015 is not set
> # CONFIG_TI_ADS1119 is not set
> # CONFIG_TI_ADS7924 is not set
> # CONFIG_TI_ADS1100 is not set
> # CONFIG_TI_ADS1298 is not set
> # CONFIG_TI_ADS7950 is not set
> # CONFIG_TI_ADS8344 is not set
> # CONFIG_TI_ADS8688 is not set
> # CONFIG_TI_ADS124S08 is not set
> # CONFIG_TI_ADS131E08 is not set
> # CONFIG_TI_LMP92064 is not set
> # CONFIG_TI_TLC4541 is not set
> # CONFIG_TI_TSC2046 is not set
> # CONFIG_VF610_ADC is not set
> # CONFIG_XILINX_XADC is not set
> # end of Analog to digital converters
>
> #
> # Analog to digital and digital to analog converters
> #
> # CONFIG_AD74115 is not set
> # CONFIG_AD74413R is not set
> # end of Analog to digital and digital to analog converters
>
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> # end of Analog Front Ends
>
> #
> # Amplifiers
> #
> # CONFIG_AD8366 is not set
> # CONFIG_ADA4250 is not set
> # CONFIG_HMC425 is not set
> # end of Amplifiers
>
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> # CONFIG_AD7746 is not set
> # end of Capacitance to digital converters
>
> #
> # Chemical Sensors
> #
> # CONFIG_AOSONG_AGS02MA is not set
> # CONFIG_ATLAS_PH_SENSOR is not set
> # CONFIG_ATLAS_EZO_SENSOR is not set
> # CONFIG_BME680 is not set
> # CONFIG_CCS811 is not set
> # CONFIG_ENS160 is not set
> # CONFIG_IAQCORE is not set
> # CONFIG_SCD30_CORE is not set
> # CONFIG_SCD4X is not set
> # CONFIG_SENSIRION_SGP30 is not set
> # CONFIG_SENSIRION_SGP40 is not set
> # CONFIG_SPS30_I2C is not set
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
>
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=3Dm
> CONFIG_HID_SENSOR_IIO_TRIGGER=3Dm
> # end of Hid Sensor IIO Common
>
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
>
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORHUB is not set
> # end of SSP Sensor Common
>
> #
> # Digital to analog converters
> #
> # CONFIG_AD3552R_HS is not set
> # CONFIG_AD3552R is not set
> # CONFIG_AD5064 is not set
> # CONFIG_AD5360 is not set
> # CONFIG_AD5380 is not set
> # CONFIG_AD5421 is not set
> # CONFIG_AD5446 is not set
> # CONFIG_AD5449 is not set
> # CONFIG_AD5592R is not set
> # CONFIG_AD5593R is not set
> # CONFIG_AD5504 is not set
> # CONFIG_AD5624R_SPI is not set
> # CONFIG_AD9739A is not set
> # CONFIG_LTC2688 is not set
> # CONFIG_AD5686_SPI is not set
> # CONFIG_AD5696_I2C is not set
> # CONFIG_AD5755 is not set
> # CONFIG_AD5758 is not set
> # CONFIG_AD5761 is not set
> # CONFIG_AD5764 is not set
> # CONFIG_AD5766 is not set
> # CONFIG_AD5770R is not set
> # CONFIG_AD5791 is not set
> # CONFIG_AD7293 is not set
> # CONFIG_AD7303 is not set
> # CONFIG_AD8460 is not set
> # CONFIG_AD8801 is not set
> # CONFIG_DPOT_DAC is not set
> # CONFIG_DS4424 is not set
> # CONFIG_LTC1660 is not set
> # CONFIG_LTC2632 is not set
> # CONFIG_LTC2664 is not set
> # CONFIG_M62332 is not set
> # CONFIG_MAX517 is not set
> # CONFIG_MAX5522 is not set
> # CONFIG_MAX5821 is not set
> # CONFIG_MCP4725 is not set
> # CONFIG_MCP4728 is not set
> # CONFIG_MCP4821 is not set
> # CONFIG_MCP4922 is not set
> # CONFIG_TI_DAC082S085 is not set
> # CONFIG_TI_DAC5571 is not set
> # CONFIG_TI_DAC7311 is not set
> # CONFIG_TI_DAC7612 is not set
> # CONFIG_VF610_DAC is not set
> # end of Digital to analog converters
>
> #
> # IIO dummy driver
> #
> # end of IIO dummy driver
>
> #
> # Filters
> #
> # CONFIG_ADMV8818 is not set
> # end of Filters
>
> #
> # Frequency Synthesizers DDS/PLL
> #
>
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
> # end of Clock Generator/Distribution
>
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # CONFIG_ADF4350 is not set
> # CONFIG_ADF4371 is not set
> # CONFIG_ADF4377 is not set
> # CONFIG_ADMFM2000 is not set
> # CONFIG_ADMV1013 is not set
> # CONFIG_ADMV1014 is not set
> # CONFIG_ADMV4420 is not set
> # CONFIG_ADRF6780 is not set
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
>
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16080 is not set
> # CONFIG_ADIS16130 is not set
> # CONFIG_ADIS16136 is not set
> # CONFIG_ADIS16260 is not set
> # CONFIG_ADXRS290 is not set
> # CONFIG_ADXRS450 is not set
> # CONFIG_BMG160 is not set
> # CONFIG_FXAS21002C is not set
> CONFIG_HID_SENSOR_GYRO_3D=3Dm
> # CONFIG_MPU3050_I2C is not set
> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> # CONFIG_ITG3200 is not set
> # end of Digital gyroscope sensors
>
> #
> # Health Sensors
> #
>
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4403 is not set
> # CONFIG_AFE4404 is not set
> # CONFIG_MAX30100 is not set
> # CONFIG_MAX30102 is not set
> # end of Heart Rate Monitors
> # end of Health Sensors
>
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> # CONFIG_DHT11 is not set
> # CONFIG_ENS210 is not set
> # CONFIG_HDC100X is not set
> # CONFIG_HDC2010 is not set
> # CONFIG_HDC3020 is not set
> CONFIG_HID_SENSOR_HUMIDITY=3Dm
> # CONFIG_HTS221 is not set
> # CONFIG_HTU21 is not set
> # CONFIG_SI7005 is not set
> # CONFIG_SI7020 is not set
> # end of Humidity sensors
>
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> # CONFIG_ADIS16460 is not set
> # CONFIG_ADIS16475 is not set
> # CONFIG_ADIS16480 is not set
> # CONFIG_BMI160_I2C is not set
> # CONFIG_BMI160_SPI is not set
> # CONFIG_BMI270_I2C is not set
> # CONFIG_BMI270_SPI is not set
> # CONFIG_BMI323_I2C is not set
> # CONFIG_BMI323_SPI is not set
> # CONFIG_BOSCH_BNO055_I2C is not set
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_FXOS8700_SPI is not set
> # CONFIG_KMX61 is not set
> # CONFIG_INV_ICM42600_I2C is not set
> # CONFIG_INV_ICM42600_SPI is not set
> # CONFIG_INV_MPU6050_I2C is not set
> # CONFIG_INV_MPU6050_SPI is not set
> # CONFIG_SMI240 is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
> # CONFIG_IIO_ST_LSM9DS0 is not set
> # end of Inertial measurement units
>
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> # CONFIG_ADJD_S311 is not set
> # CONFIG_ADUX1020 is not set
> # CONFIG_AL3010 is not set
> # CONFIG_AL3320A is not set
> # CONFIG_APDS9300 is not set
> # CONFIG_APDS9306 is not set
> # CONFIG_APDS9960 is not set
> # CONFIG_AS73211 is not set
> # CONFIG_BH1745 is not set
> # CONFIG_BH1750 is not set
> # CONFIG_BH1780 is not set
> # CONFIG_CM32181 is not set
> # CONFIG_CM3232 is not set
> # CONFIG_CM3323 is not set
> # CONFIG_CM3605 is not set
> # CONFIG_CM36651 is not set
> # CONFIG_GP2AP002 is not set
> # CONFIG_GP2AP020A00F is not set
> # CONFIG_SENSORS_ISL29018 is not set
> # CONFIG_SENSORS_ISL29028 is not set
> # CONFIG_ISL29125 is not set
> # CONFIG_ISL76682 is not set
> CONFIG_HID_SENSOR_ALS=3Dm
> CONFIG_HID_SENSOR_PROX=3Dm
> # CONFIG_JSA1212 is not set
> # CONFIG_ROHM_BU27008 is not set
> # CONFIG_ROHM_BU27034 is not set
> # CONFIG_RPR0521 is not set
> # CONFIG_LTR390 is not set
> # CONFIG_LTR501 is not set
> # CONFIG_LTRF216A is not set
> # CONFIG_LV0104CS is not set
> # CONFIG_MAX44000 is not set
> # CONFIG_MAX44009 is not set
> # CONFIG_NOA1305 is not set
> # CONFIG_OPT3001 is not set
> # CONFIG_OPT4001 is not set
> # CONFIG_PA12203001 is not set
> # CONFIG_SI1133 is not set
> # CONFIG_SI1145 is not set
> # CONFIG_STK3310 is not set
> # CONFIG_ST_UVIS25 is not set
> # CONFIG_TCS3414 is not set
> # CONFIG_TCS3472 is not set
> # CONFIG_SENSORS_TSL2563 is not set
> # CONFIG_TSL2583 is not set
> # CONFIG_TSL2591 is not set
> # CONFIG_TSL2772 is not set
> # CONFIG_TSL4531 is not set
> # CONFIG_US5182D is not set
> # CONFIG_VCNL4000 is not set
> # CONFIG_VCNL4035 is not set
> # CONFIG_VEML3235 is not set
> # CONFIG_VEML6030 is not set
> # CONFIG_VEML6040 is not set
> # CONFIG_VEML6070 is not set
> # CONFIG_VEML6075 is not set
> # CONFIG_VL6180 is not set
> # CONFIG_ZOPT2201 is not set
> # end of Light sensors
>
> #
> # Magnetometer sensors
> #
> # CONFIG_AK8974 is not set
> # CONFIG_AK8975 is not set
> # CONFIG_AK09911 is not set
> # CONFIG_ALS31300 is not set
> # CONFIG_BMC150_MAGN_I2C is not set
> # CONFIG_BMC150_MAGN_SPI is not set
> # CONFIG_MAG3110 is not set
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dm
> # CONFIG_MMC35240 is not set
> # CONFIG_IIO_ST_MAGN_3AXIS is not set
> # CONFIG_SENSORS_HMC5843_I2C is not set
> # CONFIG_SENSORS_HMC5843_SPI is not set
> # CONFIG_SENSORS_RM3100_I2C is not set
> # CONFIG_SENSORS_RM3100_SPI is not set
> # CONFIG_TI_TMAG5273 is not set
> # CONFIG_YAMAHA_YAS530 is not set
> # end of Magnetometer sensors
>
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> # end of Multiplexers
>
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=3Dm
> CONFIG_HID_SENSOR_DEVICE_ROTATION=3Dm
> # end of Inclinometer sensors
>
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> # CONFIG_IIO_SYSFS_TRIGGER is not set
> # end of Triggers - standalone
>
> #
> # Linear and angular position sensors
> #
> # CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE is not set
> # end of Linear and angular position sensors
>
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> # CONFIG_AD5272 is not set
> # CONFIG_DS1803 is not set
> # CONFIG_MAX5432 is not set
> # CONFIG_MAX5481 is not set
> # CONFIG_MAX5487 is not set
> # CONFIG_MCP4018 is not set
> # CONFIG_MCP4131 is not set
> # CONFIG_MCP4531 is not set
> # CONFIG_MCP41010 is not set
> # CONFIG_TPL0102 is not set
> # CONFIG_X9250 is not set
> # end of Digital potentiometers
>
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
>
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> # CONFIG_ROHM_BM1390 is not set
> # CONFIG_BMP280 is not set
> # CONFIG_DLHL60D is not set
> # CONFIG_DPS310 is not set
> CONFIG_HID_SENSOR_PRESS=3Dm
> # CONFIG_HP03 is not set
> # CONFIG_HSC030PA is not set
> # CONFIG_ICP10100 is not set
> # CONFIG_MPL115_I2C is not set
> # CONFIG_MPL115_SPI is not set
> # CONFIG_MPL3115 is not set
> # CONFIG_MPRLS0025PA is not set
> # CONFIG_MS5611 is not set
> # CONFIG_MS5637 is not set
> # CONFIG_SDP500 is not set
> # CONFIG_IIO_ST_PRESS is not set
> # CONFIG_T5403 is not set
> # CONFIG_HP206C is not set
> # CONFIG_ZPA2326 is not set
> # end of Pressure sensors
>
> #
> # Lightning sensors
> #
> # CONFIG_AS3935 is not set
> # end of Lightning sensors
>
> #
> # Proximity and distance sensors
> #
> # CONFIG_HX9023S is not set
> # CONFIG_IRSD200 is not set
> # CONFIG_ISL29501 is not set
> # CONFIG_LIDAR_LITE_V2 is not set
> # CONFIG_MB1232 is not set
> # CONFIG_PING is not set
> # CONFIG_RFD77402 is not set
> # CONFIG_SRF04 is not set
> # CONFIG_SX9310 is not set
> # CONFIG_SX9324 is not set
> # CONFIG_SX9360 is not set
> # CONFIG_SX9500 is not set
> # CONFIG_SRF08 is not set
> # CONFIG_VCNL3020 is not set
> # CONFIG_VL53L0X_I2C is not set
> # CONFIG_AW96103 is not set
> # end of Proximity and distance sensors
>
> #
> # Resolver to digital converters
> #
> # CONFIG_AD2S90 is not set
> # CONFIG_AD2S1200 is not set
> # CONFIG_AD2S1210 is not set
> # end of Resolver to digital converters
>
> #
> # Temperature sensors
> #
> # CONFIG_LTC2983 is not set
> # CONFIG_MAXIM_THERMOCOUPLE is not set
> CONFIG_HID_SENSOR_TEMP=3Dm
> # CONFIG_MLX90614 is not set
> # CONFIG_MLX90632 is not set
> # CONFIG_MLX90635 is not set
> # CONFIG_TMP006 is not set
> # CONFIG_TMP007 is not set
> # CONFIG_TMP117 is not set
> # CONFIG_TSYS01 is not set
> # CONFIG_TSYS02D is not set
> # CONFIG_MAX30208 is not set
> # CONFIG_MAX31856 is not set
> # CONFIG_MAX31865 is not set
> # CONFIG_MCP9600 is not set
> # end of Temperature sensors
>
> CONFIG_NTB=3Dm
> CONFIG_NTB_MSI=3Dy
> CONFIG_NTB_AMD=3Dm
> # CONFIG_NTB_IDT is not set
> CONFIG_NTB_INTEL=3Dm
> # CONFIG_NTB_EPF is not set
> # CONFIG_NTB_SWITCHTEC is not set
> CONFIG_NTB_PINGPONG=3Dm
> CONFIG_NTB_TOOL=3Dm
> CONFIG_NTB_PERF=3Dm
> CONFIG_NTB_MSI_TEST=3Dm
> CONFIG_NTB_TRANSPORT=3Dm
> CONFIG_PWM=3Dy
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_CLK is not set
> # CONFIG_PWM_DWC is not set
> # CONFIG_PWM_GPIO is not set
> CONFIG_PWM_LPSS=3Dm
> CONFIG_PWM_LPSS_PCI=3Dm
> CONFIG_PWM_LPSS_PLATFORM=3Dm
> # CONFIG_PWM_PCA9685 is not set
>
> #
> # IRQ chip support
> #
> # CONFIG_LAN966X_OIC is not set
> # end of IRQ chip support
>
> # CONFIG_IPACK_BUS is not set
> CONFIG_RESET_CONTROLLER=3Dy
> # CONFIG_RESET_GPIO is not set
> # CONFIG_RESET_SIMPLE is not set
> # CONFIG_RESET_TI_SYSCON is not set
> # CONFIG_RESET_TI_TPS380X is not set
>
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=3Dy
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
>
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
>
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_CPCAP_USB is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
>
> CONFIG_POWERCAP=3Dy
> CONFIG_INTEL_RAPL_CORE=3Dm
> CONFIG_INTEL_RAPL=3Dm
> CONFIG_INTEL_RAPL_TPMI=3Dm
> CONFIG_IDLE_INJECT=3Dy
> # CONFIG_MCB is not set
>
> #
> # Performance monitor support
> #
> # CONFIG_DWC_PCIE_PMU is not set
> # CONFIG_CXL_PMU is not set
> # end of Performance monitor support
>
> CONFIG_RAS=3Dy
> # CONFIG_RAS_CEC is not set
> CONFIG_AMD_ATL=3Dm
> CONFIG_AMD_ATL_PRM=3Dy
> CONFIG_RAS_FMPM=3Dm
> CONFIG_USB4=3Dy
> # CONFIG_USB4_DEBUGFS_WRITE is not set
> # CONFIG_USB4_DMA_TEST is not set
>
> #
> # Android
> #
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
>
> CONFIG_LIBNVDIMM=3Dm
> CONFIG_BLK_DEV_PMEM=3Dm
> CONFIG_ND_CLAIM=3Dy
> CONFIG_ND_BTT=3Dm
> CONFIG_BTT=3Dy
> CONFIG_ND_PFN=3Dm
> CONFIG_NVDIMM_PFN=3Dy
> CONFIG_NVDIMM_DAX=3Dy
> CONFIG_NVDIMM_KEYS=3Dy
> # CONFIG_NVDIMM_SECURITY_TEST is not set
> CONFIG_DAX=3Dy
> CONFIG_DEV_DAX=3Dm
> CONFIG_DEV_DAX_PMEM=3Dm
> CONFIG_DEV_DAX_HMEM=3Dm
> CONFIG_DEV_DAX_CXL=3Dm
> CONFIG_DEV_DAX_HMEM_DEVICES=3Dy
> CONFIG_DEV_DAX_KMEM=3Dm
> CONFIG_NVMEM=3Dy
> CONFIG_NVMEM_SYSFS=3Dy
> # CONFIG_NVMEM_LAYOUTS is not set
> # CONFIG_NVMEM_RMEM is not set
>
> #
> # HW tracing support
> #
> CONFIG_STM=3Dm
> CONFIG_STM_PROTO_BASIC=3Dm
> CONFIG_STM_PROTO_SYS_T=3Dm
> CONFIG_STM_DUMMY=3Dm
> CONFIG_STM_SOURCE_CONSOLE=3Dm
> CONFIG_STM_SOURCE_HEARTBEAT=3Dm
> CONFIG_STM_SOURCE_FTRACE=3Dm
> CONFIG_INTEL_TH=3Dm
> CONFIG_INTEL_TH_PCI=3Dm
> CONFIG_INTEL_TH_ACPI=3Dm
> CONFIG_INTEL_TH_GTH=3Dm
> CONFIG_INTEL_TH_STH=3Dm
> CONFIG_INTEL_TH_MSU=3Dm
> CONFIG_INTEL_TH_PTI=3Dm
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
>
> # CONFIG_FPGA is not set
> CONFIG_TEE=3Dm
> # CONFIG_AMDTEE is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> CONFIG_COUNTER=3Dm
> CONFIG_INTEL_QEP=3Dm
> # CONFIG_INTERRUPT_CNT is not set
> # CONFIG_MOST is not set
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> CONFIG_DPLL=3Dy
> # end of Device Drivers
>
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=3Dy
> CONFIG_VALIDATE_FS_PARSER=3Dy
> CONFIG_FS_IOMAP=3Dy
> CONFIG_FS_STACK=3Dy
> CONFIG_BUFFER_HEAD=3Dy
> CONFIG_LEGACY_DIRECT_IO=3Dy
> CONFIG_EXT2_FS=3Dm
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=3Dy
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=3Dm
> CONFIG_XFS_SUPPORT_V4=3Dy
> CONFIG_XFS_SUPPORT_ASCII_CI=3Dy
> CONFIG_XFS_QUOTA=3Dy
> CONFIG_XFS_POSIX_ACL=3Dy
> # CONFIG_XFS_RT is not set
> CONFIG_XFS_DRAIN_INTENTS=3Dy
> CONFIG_XFS_LIVE_HOOKS=3Dy
> CONFIG_XFS_MEMORY_BUFS=3Dy
> CONFIG_XFS_ONLINE_SCRUB=3Dy
> CONFIG_XFS_ONLINE_SCRUB_STATS=3Dy
> # CONFIG_XFS_ONLINE_REPAIR is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=3Dm
> CONFIG_GFS2_FS_LOCKING_DLM=3Dy
> CONFIG_OCFS2_FS=3Dm
> CONFIG_OCFS2_FS_O2CB=3Dm
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
> CONFIG_OCFS2_FS_STATS=3Dy
> CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=3Dm
> # CONFIG_BTRFS_FS_POSIX_ACL is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_EXPERIMENTAL is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> # CONFIG_NILFS2_FS is not set
> CONFIG_F2FS_FS=3Dm
> CONFIG_F2FS_STAT_FS=3Dy
> CONFIG_F2FS_FS_XATTR=3Dy
> CONFIG_F2FS_FS_POSIX_ACL=3Dy
> # CONFIG_F2FS_FS_SECURITY is not set
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_F2FS_FS_COMPRESSION is not set
> CONFIG_F2FS_IOSTAT=3Dy
> # CONFIG_F2FS_UNFAIR_RWSEM is not set
> # CONFIG_BCACHEFS_FS is not set
> # CONFIG_ZONEFS_FS is not set
> CONFIG_FS_DAX=3Dy
> CONFIG_FS_DAX_PMD=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> CONFIG_FILE_LOCKING=3Dy
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FS_VERITY=3Dy
> # CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=3Dy
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=3Dy
> CONFIG_QUOTACTL=3Dy
> CONFIG_AUTOFS_FS=3Dy
> CONFIG_FUSE_FS=3Dy
> CONFIG_CUSE=3Dm
> CONFIG_VIRTIO_FS=3Dy
> CONFIG_FUSE_DAX=3Dy
> CONFIG_FUSE_PASSTHROUGH=3Dy
> CONFIG_OVERLAY_FS=3Dm
> CONFIG_OVERLAY_FS_REDIRECT_DIR=3Dy
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> CONFIG_OVERLAY_FS_INDEX=3Dy
> CONFIG_OVERLAY_FS_XINO_AUTO=3Dy
> CONFIG_OVERLAY_FS_METACOPY=3Dy
> # CONFIG_OVERLAY_FS_DEBUG is not set
>
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=3Dy
> CONFIG_NETFS_STATS=3Dy
> # CONFIG_NETFS_DEBUG is not set
> CONFIG_FSCACHE=3Dy
> CONFIG_FSCACHE_STATS=3Dy
> CONFIG_CACHEFILES=3Dm
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
> # CONFIG_CACHEFILES_ONDEMAND is not set
> # end of Caches
>
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dm
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_UDF_FS=3Dm
> # end of CD-ROM/DVD Filesystems
>
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dm
> CONFIG_MSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dm
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_EXFAT_FS=3Dm
> CONFIG_EXFAT_DEFAULT_IOCHARSET=3D"utf8"
> # CONFIG_NTFS3_FS is not set
> # CONFIG_NTFS_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
>
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_VMCORE=3Dy
> CONFIG_PROC_VMCORE_DEVICE_DUMP=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_PROC_CHILDREN=3Dy
> CONFIG_PROC_PID_ARCH_STATUS=3Dy
> CONFIG_PROC_CPU_RESCTRL=3Dy
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> CONFIG_TMPFS_INODE64=3Dy
> # CONFIG_TMPFS_QUOTA is not set
> CONFIG_HUGETLBFS=3Dy
> # CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy
> CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING=3Dy
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> CONFIG_EFIVAR_FS=3Dy
> # end of Pseudo filesystems
>
> CONFIG_MISC_FILESYSTEMS=3Dy
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS2_FS is not set
> # CONFIG_UBIFS_FS is not set
> CONFIG_CRAMFS=3Dm
> CONFIG_CRAMFS_BLOCKDEV=3Dy
> # CONFIG_CRAMFS_MTD is not set
> CONFIG_SQUASHFS=3Dm
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=3Dy
> CONFIG_SQUASHFS_DECOMP_SINGLE=3Dy
> # CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
> CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE=3Dy
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI is not set
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=3Dy
> CONFIG_SQUASHFS_ZLIB=3Dy
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=3Dy
> CONFIG_SQUASHFS_XZ=3Dy
> CONFIG_SQUASHFS_ZSTD=3Dy
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=3Dy
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240
> CONFIG_PSTORE_COMPRESS=3Dy
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_PSTORE_RAM=3Dm
> # CONFIG_PSTORE_BLK is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> CONFIG_EROFS_FS=3Dm
> # CONFIG_EROFS_FS_DEBUG is not set
> CONFIG_EROFS_FS_XATTR=3Dy
> CONFIG_EROFS_FS_POSIX_ACL=3Dy
> CONFIG_EROFS_FS_SECURITY=3Dy
> CONFIG_EROFS_FS_BACKED_BY_FILE=3Dy
> # CONFIG_EROFS_FS_ZIP is not set
> # CONFIG_EROFS_FS_ONDEMAND is not set
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dy
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V3_ACL=3Dy
> CONFIG_NFS_V4=3Dm
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=3Dy
> CONFIG_NFS_V4_2=3Dy
> CONFIG_PNFS_FILE_LAYOUT=3Dm
> CONFIG_PNFS_BLOCK=3Dm
> CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> CONFIG_ROOT_NFS=3Dy
> CONFIG_NFS_FSCACHE=3Dy
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=3Dy
> CONFIG_NFS_DEBUG=3Dy
> CONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=3Dm
> # CONFIG_NFSD_V2 is not set
> CONFIG_NFSD_V3_ACL=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_PNFS=3Dy
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> CONFIG_NFSD_SCSILAYOUT=3Dy
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> CONFIG_NFSD_V4_2_INTER_SSC=3Dy
> CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
> # CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set
> CONFIG_GRACE_PERIOD=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_ACL_SUPPORT=3Dy
> CONFIG_NFS_COMMON=3Dy
> # CONFIG_NFS_LOCALIO is not set
> CONFIG_NFS_V4_2_SSC_HELPER=3Dy
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dm
> CONFIG_SUNRPC_BACKCHANNEL=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dm
> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=3Dy
> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=3Dy
> CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=3Dy
> CONFIG_SUNRPC_DEBUG=3Dy
> CONFIG_SUNRPC_XPRT_RDMA=3Dm
> CONFIG_CEPH_FS=3Dm
> CONFIG_CEPH_FSCACHE=3Dy
> CONFIG_CEPH_FS_POSIX_ACL=3Dy
> CONFIG_CEPH_FS_SECURITY_LABEL=3Dy
> CONFIG_CIFS=3Dm
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
> CONFIG_CIFS_UPCALL=3Dy
> CONFIG_CIFS_XATTR=3Dy
> CONFIG_CIFS_POSIX=3Dy
> CONFIG_CIFS_DEBUG=3Dy
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> CONFIG_CIFS_DFS_UPCALL=3Dy
> # CONFIG_CIFS_SWN_UPCALL is not set
> CONFIG_CIFS_SMB_DIRECT=3Dy
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_CIFS_COMPRESSION is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS=3Dm
> # CONFIG_CODA_FS is not set
> CONFIG_AFS_FS=3Dm
> CONFIG_AFS_DEBUG=3Dy
> CONFIG_AFS_FSCACHE=3Dy
> # CONFIG_AFS_DEBUG_CURSOR is not set
> CONFIG_9P_FS=3Dy
> # CONFIG_9P_FSCACHE is not set
> CONFIG_9P_FS_POSIX_ACL=3Dy
> CONFIG_9P_FS_SECURITY=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_CODEPAGE_737=3Dm
> CONFIG_NLS_CODEPAGE_775=3Dm
> CONFIG_NLS_CODEPAGE_850=3Dm
> CONFIG_NLS_CODEPAGE_852=3Dm
> CONFIG_NLS_CODEPAGE_855=3Dm
> CONFIG_NLS_CODEPAGE_857=3Dm
> CONFIG_NLS_CODEPAGE_860=3Dm
> CONFIG_NLS_CODEPAGE_861=3Dm
> CONFIG_NLS_CODEPAGE_862=3Dm
> CONFIG_NLS_CODEPAGE_863=3Dm
> CONFIG_NLS_CODEPAGE_864=3Dm
> CONFIG_NLS_CODEPAGE_865=3Dm
> CONFIG_NLS_CODEPAGE_866=3Dm
> CONFIG_NLS_CODEPAGE_869=3Dm
> CONFIG_NLS_CODEPAGE_936=3Dm
> CONFIG_NLS_CODEPAGE_950=3Dm
> CONFIG_NLS_CODEPAGE_932=3Dm
> CONFIG_NLS_CODEPAGE_949=3Dm
> CONFIG_NLS_CODEPAGE_874=3Dm
> CONFIG_NLS_ISO8859_8=3Dm
> CONFIG_NLS_CODEPAGE_1250=3Dm
> CONFIG_NLS_CODEPAGE_1251=3Dm
> CONFIG_NLS_ASCII=3Dy
> CONFIG_NLS_ISO8859_1=3Dm
> CONFIG_NLS_ISO8859_2=3Dm
> CONFIG_NLS_ISO8859_3=3Dm
> CONFIG_NLS_ISO8859_4=3Dm
> CONFIG_NLS_ISO8859_5=3Dm
> CONFIG_NLS_ISO8859_6=3Dm
> CONFIG_NLS_ISO8859_7=3Dm
> CONFIG_NLS_ISO8859_9=3Dm
> CONFIG_NLS_ISO8859_13=3Dm
> CONFIG_NLS_ISO8859_14=3Dm
> CONFIG_NLS_ISO8859_15=3Dm
> CONFIG_NLS_KOI8_R=3Dm
> CONFIG_NLS_KOI8_U=3Dm
> CONFIG_NLS_MAC_ROMAN=3Dm
> CONFIG_NLS_MAC_CELTIC=3Dm
> CONFIG_NLS_MAC_CENTEURO=3Dm
> CONFIG_NLS_MAC_CROATIAN=3Dm
> CONFIG_NLS_MAC_CYRILLIC=3Dm
> CONFIG_NLS_MAC_GAELIC=3Dm
> CONFIG_NLS_MAC_GREEK=3Dm
> CONFIG_NLS_MAC_ICELAND=3Dm
> CONFIG_NLS_MAC_INUIT=3Dm
> CONFIG_NLS_MAC_ROMANIAN=3Dm
> CONFIG_NLS_MAC_TURKISH=3Dm
> CONFIG_NLS_UTF8=3Dm
> CONFIG_NLS_UCS2_UTILS=3Dm
> CONFIG_DLM=3Dm
> CONFIG_DLM_DEBUG=3Dy
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=3Dy
> # end of File systems
>
> #
> # Security options
> #
> CONFIG_KEYS=3Dy
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=3Dy
> CONFIG_BIG_KEYS=3Dy
> CONFIG_TRUSTED_KEYS=3Dy
> CONFIG_HAVE_TRUSTED_KEYS=3Dy
> CONFIG_TRUSTED_KEYS_TPM=3Dy
> CONFIG_ENCRYPTED_KEYS=3Dy
> # CONFIG_USER_DECRYPTED_DATA is not set
> CONFIG_KEY_DH_OPERATIONS=3Dy
> CONFIG_KEY_NOTIFICATIONS=3Dy
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_PROC_MEM_ALWAYS_FORCE=3Dy
> # CONFIG_PROC_MEM_FORCE_PTRACE is not set
> # CONFIG_PROC_MEM_NO_FORCE is not set
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITYFS=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_SECURITY_INFINIBAND=3Dy
> CONFIG_SECURITY_NETWORK_XFRM=3Dy
> CONFIG_SECURITY_PATH=3Dy
> CONFIG_INTEL_TXT=3Dy
> CONFIG_LSM_MMAP_MIN_ADDR=3D65535
> CONFIG_HARDENED_USERCOPY=3Dy
> CONFIG_FORTIFY_SOURCE=3Dy
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=3Dy
> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256
> # CONFIG_SECURITY_SELINUX_DEBUG is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=3Dy
> # CONFIG_SECURITY_SAFESETID is not set
> CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
> CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=3Dy
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> # CONFIG_SECURITY_IPE is not set
> CONFIG_INTEGRITY=3Dy
> CONFIG_INTEGRITY_SIGNATURE=3Dy
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
> CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
> CONFIG_INTEGRITY_PLATFORM_KEYRING=3Dy
> CONFIG_INTEGRITY_MACHINE_KEYRING=3Dy
> CONFIG_INTEGRITY_CA_MACHINE_KEYRING=3Dy
> CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX=3Dy
> CONFIG_LOAD_UEFI_KEYS=3Dy
> CONFIG_INTEGRITY_AUDIT=3Dy
> CONFIG_IMA=3Dy
> # CONFIG_IMA_KEXEC is not set
> CONFIG_IMA_MEASURE_PCR_IDX=3D10
> CONFIG_IMA_LSM_RULES=3Dy
> # CONFIG_IMA_NG_TEMPLATE is not set
> CONFIG_IMA_SIG_TEMPLATE=3Dy
> CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-sig"
> # CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
> CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH=3D"sha256"
> CONFIG_IMA_WRITE_POLICY=3Dy
> CONFIG_IMA_READ_POLICY=3Dy
> CONFIG_IMA_APPRAISE=3Dy
> CONFIG_IMA_ARCH_POLICY=3Dy
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> CONFIG_IMA_APPRAISE_MODSIG=3Dy
> CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=3Dy
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=3Dy
> CONFIG_EVM_ATTR_FSUUID=3Dy
> # CONFIG_EVM_ADD_XATTRS is not set
> # CONFIG_EVM_LOAD_X509 is not set
> # CONFIG_DEFAULT_SECURITY_SELINUX is not set
> CONFIG_DEFAULT_SECURITY_DAC=3Dy
> CONFIG_LSM=3D"lockdown,yama,integrity,selinux,bpf"
>
> #
> # Kernel hardening options
> #
>
> #
> # Memory initialization
> #
> CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=3Dy
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=3Dy
> CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=3Dy
> CONFIG_INIT_STACK_NONE=3Dy
> # CONFIG_INIT_STACK_ALL_PATTERN is not set
> # CONFIG_INIT_STACK_ALL_ZERO is not set
> # CONFIG_GCC_PLUGIN_STACKLEAK is not set
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy
> # CONFIG_ZERO_CALL_USED_REGS is not set
> # end of Memory initialization
>
> #
> # Hardening of kernel data structures
> #
> CONFIG_LIST_HARDENED=3Dy
> CONFIG_BUG_ON_DATA_CORRUPTION=3Dy
> # end of Hardening of kernel data structures
>
> CONFIG_RANDSTRUCT_NONE=3Dy
> # CONFIG_RANDSTRUCT_FULL is not set
> # CONFIG_RANDSTRUCT_PERFORMANCE is not set
> # end of Kernel hardening options
> # end of Security options
>
> CONFIG_XOR_BLOCKS=3Dm
> CONFIG_ASYNC_CORE=3Dm
> CONFIG_ASYNC_MEMCPY=3Dm
> CONFIG_ASYNC_XOR=3Dm
> CONFIG_ASYNC_PQ=3Dm
> CONFIG_ASYNC_RAID6_RECOV=3Dm
> CONFIG_CRYPTO=3Dy
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dy
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_SIG=3Dy
> CONFIG_CRYPTO_SIG2=3Dy
> CONFIG_CRYPTO_SKCIPHER=3Dy
> CONFIG_CRYPTO_SKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> CONFIG_CRYPTO_AKCIPHER2=3Dy
> CONFIG_CRYPTO_AKCIPHER=3Dy
> CONFIG_CRYPTO_KPP2=3Dy
> CONFIG_CRYPTO_KPP=3Dy
> CONFIG_CRYPTO_ACOMP2=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_USER=3Dy
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> CONFIG_CRYPTO_NULL=3Dy
> CONFIG_CRYPTO_NULL2=3Dy
> CONFIG_CRYPTO_PCRYPT=3Dm
> CONFIG_CRYPTO_CRYPTD=3Dy
> CONFIG_CRYPTO_AUTHENC=3Dy
> CONFIG_CRYPTO_TEST=3Dm
> CONFIG_CRYPTO_SIMD=3Dy
> CONFIG_CRYPTO_ENGINE=3Dm
> # end of Crypto core or helper
>
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=3Dy
> CONFIG_CRYPTO_DH=3Dy
> CONFIG_CRYPTO_DH_RFC7919_GROUPS=3Dy
> CONFIG_CRYPTO_ECC=3Dy
> CONFIG_CRYPTO_ECDH=3Dy
> CONFIG_CRYPTO_ECDSA=3Dy
> # CONFIG_CRYPTO_ECRDSA is not set
> CONFIG_CRYPTO_CURVE25519=3Dm
> # end of Public-key cryptography
>
> #
> # Block ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_ARIA=3Dy
> CONFIG_CRYPTO_BLOWFISH=3Dm
> CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
> CONFIG_CRYPTO_CAMELLIA=3Dm
> CONFIG_CRYPTO_CAST_COMMON=3Dm
> CONFIG_CRYPTO_CAST5=3Dm
> CONFIG_CRYPTO_CAST6=3Dm
> CONFIG_CRYPTO_DES=3Dm
> CONFIG_CRYPTO_FCRYPT=3Dm
> CONFIG_CRYPTO_SERPENT=3Dm
> CONFIG_CRYPTO_SM4=3Dy
> CONFIG_CRYPTO_SM4_GENERIC=3Dy
> CONFIG_CRYPTO_TWOFISH=3Dm
> CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
> # end of Block ciphers
>
> #
> # Length-preserving ciphers and modes
> #
> CONFIG_CRYPTO_ADIANTUM=3Dm
> CONFIG_CRYPTO_CHACHA20=3Dm
> CONFIG_CRYPTO_CBC=3Dy
> CONFIG_CRYPTO_CTR=3Dy
> CONFIG_CRYPTO_CTS=3Dy
> CONFIG_CRYPTO_ECB=3Dy
> # CONFIG_CRYPTO_HCTR2 is not set
> # CONFIG_CRYPTO_KEYWRAP is not set
> CONFIG_CRYPTO_LRW=3Dm
> CONFIG_CRYPTO_PCBC=3Dm
> CONFIG_CRYPTO_XTS=3Dy
> CONFIG_CRYPTO_NHPOLY1305=3Dm
> # end of Length-preserving ciphers and modes
>
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> # CONFIG_CRYPTO_AEGIS128 is not set
> CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
> CONFIG_CRYPTO_CCM=3Dy
> CONFIG_CRYPTO_GCM=3Dy
> CONFIG_CRYPTO_GENIV=3Dy
> CONFIG_CRYPTO_SEQIV=3Dy
> CONFIG_CRYPTO_ECHAINIV=3Dm
> CONFIG_CRYPTO_ESSIV=3Dm
> # end of AEAD (authenticated encryption with associated data) ciphers
>
> #
> # Hashes, digests, and MACs
> #
> CONFIG_CRYPTO_BLAKE2B=3Dm
> CONFIG_CRYPTO_CMAC=3Dy
> CONFIG_CRYPTO_GHASH=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> CONFIG_CRYPTO_POLY1305=3Dm
> CONFIG_CRYPTO_RMD160=3Dm
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_SHA512=3Dy
> CONFIG_CRYPTO_SHA3=3Dy
> # CONFIG_CRYPTO_SM3_GENERIC is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_VMAC=3Dm
> CONFIG_CRYPTO_WP512=3Dm
> CONFIG_CRYPTO_XCBC=3Dm
> CONFIG_CRYPTO_XXHASH=3Dm
> # end of Hashes, digests, and MACs
>
> #
> # CRCs (cyclic redundancy checks)
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> CONFIG_CRYPTO_CRC32=3Dm
> CONFIG_CRYPTO_CRCT10DIF=3Dy
> CONFIG_CRYPTO_CRC64_ROCKSOFT=3Dy
> # end of CRCs (cyclic redundancy checks)
>
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_LZO=3Dy
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> CONFIG_CRYPTO_ZSTD=3Dm
> # end of Compression
>
> #
> # Random number generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=3Dm
> CONFIG_CRYPTO_DRBG_MENU=3Dy
> CONFIG_CRYPTO_DRBG_HMAC=3Dy
> CONFIG_CRYPTO_DRBG_HASH=3Dy
> CONFIG_CRYPTO_DRBG_CTR=3Dy
> CONFIG_CRYPTO_DRBG=3Dy
> CONFIG_CRYPTO_JITTERENTROPY=3Dy
> CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=3D64
> CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=3D32
> CONFIG_CRYPTO_JITTERENTROPY_OSR=3D1
> CONFIG_CRYPTO_KDF800108_CTR=3Dy
> # end of Random number generation
>
> #
> # Userspace interface
> #
> CONFIG_CRYPTO_USER_API=3Dy
> CONFIG_CRYPTO_USER_API_HASH=3Dy
> CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
> CONFIG_CRYPTO_USER_API_RNG=3Dy
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=3Dy
> # CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
> # end of Userspace interface
>
> CONFIG_CRYPTO_HASH_INFO=3Dy
>
> #
> # Accelerated Cryptographic Algorithms for CPU (x86)
> #
> CONFIG_CRYPTO_CURVE25519_X86=3Dm
> CONFIG_CRYPTO_AES_NI_INTEL=3Dy
> CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
> CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
> CONFIG_CRYPTO_DES3_EDE_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm
> # CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
> CONFIG_CRYPTO_CHACHA20_X86_64=3Dy
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_NHPOLY1305_SSE2=3Dm
> CONFIG_CRYPTO_NHPOLY1305_AVX2=3Dm
> CONFIG_CRYPTO_BLAKE2S_X86=3Dy
> # CONFIG_CRYPTO_POLYVAL_CLMUL_NI is not set
> CONFIG_CRYPTO_POLY1305_X86_64=3Dy
> CONFIG_CRYPTO_SHA1_SSSE3=3Dy
> CONFIG_CRYPTO_SHA256_SSSE3=3Dy
> CONFIG_CRYPTO_SHA512_SSSE3=3Dy
> # CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm
> CONFIG_CRYPTO_CRC32C_INTEL=3Dm
> CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
> # end of Accelerated Cryptographic Algorithms for CPU (x86)
>
> CONFIG_CRYPTO_HW=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_DD=3Dm
> CONFIG_CRYPTO_DEV_SP_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
> CONFIG_CRYPTO_DEV_SP_PSP=3Dy
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> CONFIG_CRYPTO_DEV_NITROX=3Dm
> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=3Dm
> CONFIG_CRYPTO_DEV_QAT=3Dm
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62X=3Dm
> CONFIG_CRYPTO_DEV_QAT_4XXX=3Dm
> # CONFIG_CRYPTO_DEV_QAT_420XX is not set
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm
> # CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set
> CONFIG_CRYPTO_DEV_IAA_CRYPTO=3Dm
> # CONFIG_CRYPTO_DEV_IAA_CRYPTO_STATS is not set
> CONFIG_CRYPTO_DEV_CHELSIO=3Dm
> CONFIG_CRYPTO_DEV_VIRTIO=3Dm
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=3Dm
> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy
> CONFIG_FIPS_SIGNATURE_SELFTEST=3Dy
> CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=3Dy
> CONFIG_FIPS_SIGNATURE_SELFTEST_ECDSA=3Dy
>
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=3Dy
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
> # CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
> # CONFIG_SYSTEM_REVOCATION_LIST is not set
> # CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE is not set
> # end of Certificates for signature checking
>
> CONFIG_BINARY_PRINTF=3Dy
>
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=3Dm
> # CONFIG_RAID6_PQ_BENCHMARK is not set
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_STRNLEN_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> CONFIG_CORDIC=3Dm
> CONFIG_PRIME_NUMBERS=3Dm
> CONFIG_RATIONAL=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
>
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_UTILS=3Dy
> CONFIG_CRYPTO_LIB_AES=3Dy
> CONFIG_CRYPTO_LIB_AESCFB=3Dy
> CONFIG_CRYPTO_LIB_AESGCM=3Dm
> CONFIG_CRYPTO_LIB_ARC4=3Dm
> CONFIG_CRYPTO_LIB_GF128MUL=3Dy
> CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=3Dy
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dy
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=3Dy
> CONFIG_CRYPTO_LIB_CHACHA=3Dy
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=3Dm
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=3Dm
> CONFIG_CRYPTO_LIB_CURVE25519=3Dm
> CONFIG_CRYPTO_LIB_DES=3Dm
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=3Dy
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=3Dy
> CONFIG_CRYPTO_LIB_POLY1305=3Dy
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dy
> CONFIG_CRYPTO_LIB_SHA1=3Dy
> CONFIG_CRYPTO_LIB_SHA256=3Dy
> # end of Crypto library routines
>
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC_T10DIF=3Dy
> CONFIG_CRC64_ROCKSOFT=3Dy
> CONFIG_CRC_ITU_T=3Dm
> CONFIG_CRC32=3Dy
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=3Dy
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> CONFIG_CRC64=3Dy
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=3Dm
> CONFIG_LIBCRC32C=3Dm
> CONFIG_CRC8=3Dm
> CONFIG_XXHASH=3Dy
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_LZ4_COMPRESS=3Dm
> CONFIG_LZ4_DECOMPRESS=3Dy
> CONFIG_ZSTD_COMMON=3Dy
> CONFIG_ZSTD_COMPRESS=3Dm
> CONFIG_ZSTD_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_ARM64=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> CONFIG_XZ_DEC_RISCV=3Dy
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=3Dy
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_DECOMPRESS_LZ4=3Dy
> CONFIG_DECOMPRESS_ZSTD=3Dy
> CONFIG_GENERIC_ALLOCATOR=3Dy
> CONFIG_REED_SOLOMON=3Dm
> CONFIG_REED_SOLOMON_ENC8=3Dy
> CONFIG_REED_SOLOMON_DEC8=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dm
> CONFIG_TEXTSEARCH_BM=3Dm
> CONFIG_TEXTSEARCH_FSM=3Dm
> CONFIG_BTREE=3Dy
> CONFIG_INTERVAL_TREE=3Dy
> CONFIG_INTERVAL_TREE_SPAN_ITER=3Dy
> CONFIG_XARRAY_MULTI=3Dy
> CONFIG_ASSOCIATIVE_ARRAY=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT=3Dy
> CONFIG_HAS_IOPORT_MAP=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_DMA_OPS_HELPERS=3Dy
> CONFIG_NEED_SG_DMA_FLAGS=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=3Dy
> CONFIG_SWIOTLB=3Dy
> # CONFIG_SWIOTLB_DYNAMIC is not set
> CONFIG_DMA_NEED_SYNC=3Dy
> CONFIG_DMA_COHERENT_POOL=3Dy
> CONFIG_DMA_CMA=3Dy
> # CONFIG_DMA_NUMA_CMA is not set
>
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=3D0
> CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=3D8
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=3Dy
> CONFIG_IOMMU_HELPER=3Dy
> CONFIG_CHECK_SIGNATURE=3Dy
> CONFIG_CPUMASK_OFFSTACK=3Dy
> CONFIG_CPU_RMAP=3Dy
> CONFIG_DQL=3Dy
> CONFIG_GLOB=3Dy
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=3Dy
> CONFIG_CLZ_TAB=3Dy
> CONFIG_IRQ_POLL=3Dy
> CONFIG_MPILIB=3Dy
> CONFIG_SIGNATURE=3Dy
> CONFIG_DIMLIB=3Dy
> CONFIG_OID_REGISTRY=3Dy
> CONFIG_UCS2_STRING=3Dy
> CONFIG_HAVE_GENERIC_VDSO=3Dy
> CONFIG_GENERIC_GETTIMEOFDAY=3Dy
> CONFIG_GENERIC_VDSO_TIME_NS=3Dy
> CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=3Dy
> CONFIG_VDSO_GETRANDOM=3Dy
> CONFIG_FONT_SUPPORT=3Dy
> CONFIG_FONTS=3Dy
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
> # CONFIG_FONT_6x11 is not set
> # CONFIG_FONT_7x14 is not set
> # CONFIG_FONT_PEARL_8x8 is not set
> # CONFIG_FONT_ACORN_8x8 is not set
> CONFIG_FONT_MINI_4x6=3Dy
> # CONFIG_FONT_6x10 is not set
> # CONFIG_FONT_10x18 is not set
> # CONFIG_FONT_SUN8x16 is not set
> # CONFIG_FONT_SUN12x22 is not set
> # CONFIG_FONT_TER16x32 is not set
> # CONFIG_FONT_6x8 is not set
> CONFIG_SG_POOL=3Dy
> CONFIG_ARCH_HAS_PMEM_API=3Dy
> CONFIG_MEMREGION=3Dy
> CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=3Dy
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> CONFIG_ARCH_HAS_COPY_MC=3Dy
> CONFIG_ARCH_STACKWALK=3Dy
> CONFIG_STACKDEPOT=3Dy
> CONFIG_STACKDEPOT_ALWAYS_INIT=3Dy
> CONFIG_STACKDEPOT_MAX_FRAMES=3D64
> CONFIG_SBITMAP=3Dy
> CONFIG_PARMAN=3Dm
> CONFIG_OBJAGG=3Dm
> # CONFIG_LWQ_TEST is not set
> # end of Library routines
>
> CONFIG_PLDMFW=3Dy
> CONFIG_ASN1_ENCODER=3Dy
> CONFIG_POLYNOMIAL=3Dm
> CONFIG_FIRMWARE_TABLE=3Dy
> CONFIG_UNION_FIND=3Dy
>
> #
> # Kernel hacking
> #
>
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_PRINTK_CALLER=3Dy
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> CONFIG_BOOT_PRINTK_DELAY=3Dy
> CONFIG_DYNAMIC_DEBUG=3Dy
> CONFIG_DYNAMIC_DEBUG_CORE=3Dy
> CONFIG_SYMBOLIC_ERRNAME=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # end of printk and dmesg options
>
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
>
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_AS_HAS_NON_CONST_ULEB128=3Dy
> # CONFIG_DEBUG_INFO_NONE is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_BTF=3Dy
> CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> CONFIG_PAHOLE_HAS_LANG_EXCLUDE=3Dy
> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> # CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=3D2048
> CONFIG_STRIP_ASM_SYMS=3Dy
> # CONFIG_READABLE_ASM is not set
> CONFIG_HEADERS_INSTALL=3Dy
> CONFIG_DEBUG_SECTION_MISMATCH=3Dy
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
> CONFIG_OBJTOOL=3Dy
> # CONFIG_VMLINUX_MAP is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
>
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D""
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN=3Dy
> # CONFIG_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=3Dy
> CONFIG_HAVE_KCSAN_COMPILER=3Dy
> # end of Generic Kernel Debugging Instruments
>
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # CONFIG_DEBUG_NET is not set
> # CONFIG_DEBUG_NET_SMALL_RTNL is not set
> # end of Networking Debugging
>
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=3Dy
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_SLUB_DEBUG=3Dy
> # CONFIG_SLUB_DEBUG_ON is not set
> CONFIG_SLUB_RCU_DEBUG=3Dy
> # CONFIG_PAGE_OWNER is not set
> # CONFIG_PAGE_TABLE_CHECK is not set
> CONFIG_PAGE_POISONING=3Dy
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_DEBUG_WX=3Dy
> CONFIG_GENERIC_PTDUMP=3Dy
> CONFIG_PTDUMP_CORE=3Dy
> # CONFIG_PTDUMP_DEBUGFS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_PER_VMA_LOCK_STATS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SHRINKER_DEBUG is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> # CONFIG_MEM_ALLOC_PROFILING is not set
> CONFIG_HAVE_ARCH_KASAN=3Dy
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> CONFIG_KASAN=3Dy
> CONFIG_KASAN_GENERIC=3Dy
> CONFIG_KASAN_OUTLINE=3Dy
> # CONFIG_KASAN_INLINE is not set
> CONFIG_KASAN_STACK=3Dy
> # CONFIG_KASAN_VMALLOC is not set
> # CONFIG_KASAN_EXTRA_INFO is not set
> CONFIG_HAVE_ARCH_KFENCE=3Dy
> # CONFIG_KFENCE is not set
> CONFIG_HAVE_ARCH_KMSAN=3Dy
> # end of Memory Debugging
>
> CONFIG_DEBUG_SHIRQ=3Dy
>
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=3Dy
> CONFIG_PANIC_ON_OOPS_VALUE=3D1
> CONFIG_PANIC_TIMEOUT=3D0
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> # CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> # CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
> CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> # CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
> # CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
> CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=3Dy
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_WQ_WATCHDOG=3Dy
> # CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
>
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_SCHED_INFO=3Dy
> CONFIG_SCHEDSTATS=3Dy
> # end of Scheduler Debugging
>
> # CONFIG_DEBUG_PREEMPT is not set
>
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> CONFIG_PROVE_LOCKING=3Dy
> CONFIG_PROVE_RAW_LOCK_NESTING=3Dy
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=3Dy
> CONFIG_DEBUG_SPINLOCK=3Dy
> CONFIG_DEBUG_MUTEXES=3Dy
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> CONFIG_DEBUG_RWSEMS=3Dy
> CONFIG_DEBUG_LOCK_ALLOC=3Dy
> CONFIG_LOCKDEP=3Dy
> CONFIG_LOCKDEP_BITS=3D15
> CONFIG_LOCKDEP_CHAINS_BITS=3D16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=3D19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=3D14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=3D12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>
> CONFIG_TRACE_IRQFLAGS=3Dy
> CONFIG_TRACE_IRQFLAGS_NMI=3Dy
> # CONFIG_NMI_CHECK_CPU is not set
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
>
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=3Dy
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_DEBUG_MAPLE_TREE is not set
> # end of Debug kernel data structures
>
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=3Dy
> CONFIG_TORTURE_TEST=3Dm
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_REF_SCALE_TEST=3Dm
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> # CONFIG_RCU_CPU_STALL_CPUTIME is not set
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_LATENCYTOP is not set
> # CONFIG_DEBUG_CGROUP_REF is not set
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_RETHOOK=3Dy
> CONFIG_RETHOOK=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_RETVAL=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_HAVE_FENTRY=3Dy
> CONFIG_HAVE_OBJTOOL_MCOUNT=3Dy
> CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=3Dy
> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_TRACER_MAX_TRACE=3Dy
> CONFIG_TRACE_CLOCK=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
> CONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_GENERIC_TRACER=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> CONFIG_BOOTTIME_TRACING=3Dy
> CONFIG_FUNCTION_TRACER=3Dy
> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_FUNCTION_GRAPH_RETVAL=3Dy
> # CONFIG_FUNCTION_GRAPH_RETADDR is not set
> CONFIG_DYNAMIC_FTRACE=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_FPROBE=3Dy
> CONFIG_FUNCTION_PROFILER=3Dy
> CONFIG_STACK_TRACER=3Dy
> CONFIG_IRQSOFF_TRACER=3Dy
> # CONFIG_PREEMPT_TRACER is not set
> CONFIG_SCHED_TRACER=3Dy
> CONFIG_HWLAT_TRACER=3Dy
> CONFIG_OSNOISE_TRACER=3Dy
> CONFIG_TIMERLAT_TRACER=3Dy
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=3Dy
> CONFIG_TRACER_SNAPSHOT=3Dy
> CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=3Dy
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=3Dy
> CONFIG_FPROBE_EVENTS=3Dy
> CONFIG_PROBE_EVENTS_BTF_ARGS=3Dy
> CONFIG_KPROBE_EVENTS=3Dy
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=3Dy
> CONFIG_BPF_EVENTS=3Dy
> CONFIG_DYNAMIC_EVENTS=3Dy
> CONFIG_PROBE_EVENTS=3Dy
> CONFIG_BPF_KPROBE_OVERRIDE=3Dy
> CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_FTRACE_MCOUNT_USE_CC=3Dy
> CONFIG_TRACING_MAP=3Dy
> CONFIG_SYNTH_EVENTS=3Dy
> # CONFIG_USER_EVENTS is not set
> CONFIG_HIST_TRIGGERS=3Dy
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=3Dm
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> CONFIG_PREEMPTIRQ_DELAY_TEST=3Dm
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> CONFIG_DA_MON_EVENTS=3Dy
> CONFIG_DA_MON_EVENTS_ID=3Dy
> CONFIG_RV=3Dy
> CONFIG_RV_MON_WWNR=3Dy
> CONFIG_RV_REACTORS=3Dy
> CONFIG_RV_REACT_PRINTK=3Dy
> CONFIG_RV_REACT_PANIC=3Dy
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
> CONFIG_SAMPLES=3Dy
> # CONFIG_SAMPLE_AUXDISPLAY is not set
> # CONFIG_SAMPLE_TRACE_EVENTS is not set
> # CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
> CONFIG_SAMPLE_TRACE_PRINTK=3Dm
> CONFIG_SAMPLE_FTRACE_DIRECT=3Dm
> # CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
> # CONFIG_SAMPLE_FTRACE_OPS is not set
> # CONFIG_SAMPLE_TRACE_ARRAY is not set
> # CONFIG_SAMPLE_KOBJECT is not set
> # CONFIG_SAMPLE_KPROBES is not set
> # CONFIG_SAMPLE_HW_BREAKPOINT is not set
> # CONFIG_SAMPLE_FPROBE is not set
> # CONFIG_SAMPLE_KFIFO is not set
> # CONFIG_SAMPLE_LIVEPATCH is not set
> # CONFIG_SAMPLE_CONFIGFS is not set
> # CONFIG_SAMPLE_CONNECTOR is not set
> # CONFIG_SAMPLE_FANOTIFY_ERROR is not set
> # CONFIG_SAMPLE_HIDRAW is not set
> # CONFIG_SAMPLE_LANDLOCK is not set
> # CONFIG_SAMPLE_PIDFD is not set
> # CONFIG_SAMPLE_SECCOMP is not set
> # CONFIG_SAMPLE_TIMER is not set
> # CONFIG_SAMPLE_UHID is not set
> CONFIG_SAMPLE_VFIO_MDEV_MTTY=3Dm
> # CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
> # CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
> # CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
> # CONFIG_SAMPLE_ANDROID_BINDERFS is not set
> # CONFIG_SAMPLE_VFS is not set
> # CONFIG_SAMPLE_INTEL_MEI is not set
> # CONFIG_SAMPLE_TPS6594_PFSM is not set
> # CONFIG_SAMPLE_WATCHDOG is not set
> # CONFIG_SAMPLE_WATCH_QUEUE is not set
> # CONFIG_SAMPLE_CGROUP is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> CONFIG_STRICT_DEVMEM=3Dy
> # CONFIG_IO_STRICT_DEVMEM is not set
>
> #
> # x86 Debugging
> #
> CONFIG_EARLY_PRINTK_USB=3Dy
> CONFIG_X86_VERBOSE_BOOTUP=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_EARLY_PRINTK_DBGP=3Dy
> CONFIG_EARLY_PRINTK_USB_XDBC=3Dy
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> # CONFIG_IOMMU_DEBUG is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_0X80=3Dy
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=3Dy
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=3Dy
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
>
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> CONFIG_FAULT_INJECTION=3Dy
> # CONFIG_FAILSLAB is not set
> # CONFIG_FAIL_PAGE_ALLOC is not set
> # CONFIG_FAULT_INJECTION_USERCOPY is not set
> # CONFIG_FAIL_MAKE_REQUEST is not set
> # CONFIG_FAIL_IO_TIMEOUT is not set
> # CONFIG_FAIL_FUTEX is not set
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> CONFIG_FAIL_FUNCTION=3Dy
> # CONFIG_FAIL_MMC_REQUEST is not set
> # CONFIG_FAIL_SUNRPC is not set
> # CONFIG_FAIL_SKB_REALLOC is not set
> # CONFIG_FAULT_INJECTION_CONFIGFS is not set
> # CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
> CONFIG_ARCH_HAS_KCOV=3Dy
> CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=3Dy
> # CONFIG_TEST_DHRY is not set
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_TEST_MULDIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_MAPLE_TREE is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_PARMAN is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> CONFIG_TEST_VMALLOC=3Dm
> CONFIG_TEST_BPF=3Dm
> CONFIG_TEST_BLACKHOLE_DEV=3Dm
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_DYNAMIC_DEBUG is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_KALLSYMS is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_OBJAGG is not set
> # CONFIG_TEST_MEMINIT is not set
> CONFIG_TEST_HMM=3Dm
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> # CONFIG_TEST_OBJPOOL is not set
> CONFIG_ARCH_USE_MEMTEST=3Dy
> # CONFIG_MEMTEST is not set
> # CONFIG_HYPERV_TESTING is not set
> # end of Kernel Testing and Coverage
>
> #
> # Rust hacking
> #
> # end of Rust hacking
> # end of Kernel hacking

> #!/bin/sh
>
> export_top_env()
> {
> 	export suite=3D'perf-event-tests'
> 	export testcase=3D'perf-event-tests'
> 	export category=3D'functional'
> 	export job_origin=3D'perf-event-tests.yaml'
> 	export arch=3D'x86_64'
> 	export initrds=3D'linux_headers'
> 	export queue_cmdline_keys=3D'branch
> commit'
> 	export queue=3D'bisect'
> 	export testbox=3D'lkp-skl-d05'
> 	export tbox_group=3D'lkp-skl-d05'
> 	export branch=3D'linux-next/master'
> 	export commit=3D'eca51ce01d4956ab4b8f06bb55c031f4913fffcb'
> 	export job_file=3D'/lkp/jobs/queued/bisect/lkp-skl-d05/perf-event-tests-=
not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-213=
54-b34j8-1.yaml'
> 	export id=3D'b3ebf8d1df417274ccfd33ebd2b4bfc387b3ad80'
> 	export queuer_version=3D'/zday/lkp'
> 	export model=3D'Skylake'
> 	export nr_cpu=3D4
> 	export memory=3D'32G'
> 	export nr_ssd_partitions=3D1
> 	export nr_hdd_partitions=3D4
> 	export hdd_partitions=3D'/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
> 	export ssd_partitions=3D'/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
> 	export rootfs_partition=3D'/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
> 	export brand=3D'Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
> 	export need_kconfig_hw=3D'{"PTP_1588_CLOCK"=3D>"y"}
> {"E1000E"=3D>"y"}
> SATA_AHCI
> DRM_I915'
> 	export ucode=3D'0xf0'
> 	export rootfs=3D'debian-12-x86_64-20240206.cgz'
> 	export kconfig=3D'x86_64-rhel-9.4-bpf'
> 	export enqueue_time=3D'2024-12-07 16:30:01 +0800'
> 	export compiler=3D'gcc-12'
> 	export _rt=3D'/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/d=
ebian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8=
f06bb55c031f4913fffcb'
> 	export user=3D'lkp'
> 	export LKP_SERVER=3D'internal-lkp-server'
> 	export scheduler_version=3D'/lkp/lkp/src'
> 	export max_uptime=3D1200
> 	export initrd=3D'/osimage/debian/debian-12-x86_64-20240206.cgz'
> 	export bootloader_append=3D'root=3D/dev/ram0
> RESULT_ROOT=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/de=
bian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f=
06bb55c031f4913fffcb/0
> BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06=
bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49
> branch=3Dlinux-next/master
> job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_al=
l-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
> user=3Dlkp
> ARCH=3Dx86_64
> kconfig=3Dx86_64-rhel-9.4-bpf
> commit=3Deca51ce01d4956ab4b8f06bb55c031f4913fffcb
> intremap=3Dposted_msi
> max_uptime=3D1200
> LKP_SERVER=3Dinternal-lkp-server
> nokaslr
> selinux=3D0
> debug
> apic=3Ddebug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=3D100
> net.ifnames=3D0
> printk.devkmsg=3Don
> panic=3D-1
> softlockup_panic=3D1
> nmi_watchdog=3Dpanic
> oops=3Dpanic
> load_ramdisk=3D2
> prompt_ramdisk=3D0
> drbd.minor_count=3D8
> systemd.log_level=3Derr
> ignore_loglevel
> console=3Dtty0
> earlyprintk=3DttyS0,115200
> console=3DttyS0,115200
> vga=3Dnormal
> rw'
> 	export modules_initrd=3D'/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01=
d4956ab4b8f06bb55c031f4913fffcb/modules.cgz'
> 	export linux_headers_initrd=3D'/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca=
51ce01d4956ab4b8f06bb55c031f4913fffcb/linux-headers.cgz'
> 	export bm_initrd=3D'/osimage/deps/debian-12-x86_64-20240206.cgz/lkp_2024=
1102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/rsync-rootfs_20241102.=
cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/run-ipconfig_20241102.cgz,/=
osimage/deps/debian-12-x86_64-20240206.cgz/perf-event-tests_20241102.cgz,/o=
simage/pkg/debian-12-x86_64-20240206.cgz/perf-event-tests-x86_64-a052241-1_=
20241102.cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/hw_20241102.cgz'
> 	export ucode_initrd=3D'/osimage/ucode/intel-ucode-20230906.cgz'
> 	export lkp_initrd=3D'/osimage/user/lkp/lkp-x86_64.cgz'
> 	export site=3D'inn'
> 	export LKP_CGI_PORT=3D80
> 	export LKP_CIFS_PORT=3D139
> 	export job_initrd=3D'/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-no=
t_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354=
-b34j8-1.cgz'
> 	export last_kernel=3D'6.12.0'
> 	export acpi_rsdp=3D'0x000f05b0'
> 	export kernel=3D'/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4=
b8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49'
> 	export result_root=3D'/result/perf-event-tests/not_paranoid_at_all/lkp-s=
kl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4=
956ab4b8f06bb55c031f4913fffcb/0'
>
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=3D/lkp/${user:-lkp}/src
> }
>
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
>
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
>
> 	export_top_env
>
> 	run_setup $LKP_SRC/setup/sanity-check
>
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
>
> 	run_test paranoid=3D'not_paranoid_at_all' $LKP_SRC/tests/wrapper perf-ev=
ent-tests
> }
>
> extract_stats()
> {
> 	export stats_part_begin=3D
> 	export stats_part_end=3D
>
> 	env paranoid=3D'not_paranoid_at_all' $LKP_SRC/stats/wrapper perf-event-t=
ests
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper meminfo
>
> 	$LKP_SRC/stats/wrapper time perf-event-tests.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
>
> "$@"


> Decompressing Linux... No EFI environment detected.
> Parsing ELF... No relocation needed... done.
> Booting the kernel (entry_offset: 0x0000000000000888).
> Linux version 6.13.0-rc1-00027-geca51ce01d49 (kbuild@8637b1bd82a1) (gcc-1=
2 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP =
PREEMPT_DYNAMIC Sat Dec  7 16:35:26 CST 2024
> Command line: ip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 RESULT_ROOT=3D/=
result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20=
240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913ff=
fcb/0 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b=
8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49 branch=3Dlinu=
x-next/master job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_pa=
ranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34=
j8-1.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-9.4-bpf commit=3De=
ca51ce01d4956ab4b8f06bb55c031f4913fffcb intremap=3Dposted_msi max_uptime=3D=
1200 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebu=
g sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0=
 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic o=
ops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 system=
d.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0,115200=
 console=3DttyS0,115200 vga=3Dnor
> BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000400-0x00000000000903ff] usable
> BIOS-e820: [mem 0x0000000000090400-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000cb11ffff] usable
> BIOS-e820: [mem 0x00000000cb120000-0x00000000cb120fff] ACPI NVS
> BIOS-e820: [mem 0x00000000cb121000-0x00000000cb14afff] reserved
> BIOS-e820: [mem 0x00000000cb14b000-0x00000000cb1a1fff] usable
> BIOS-e820: [mem 0x00000000cb1a2000-0x00000000cb9a2fff] reserved
> BIOS-e820: [mem 0x00000000cb9a3000-0x00000000db514fff] usable
> BIOS-e820: [mem 0x00000000db515000-0x00000000db738fff] reserved
> BIOS-e820: [mem 0x00000000db739000-0x00000000db772fff] ACPI data
> BIOS-e820: [mem 0x00000000db773000-0x00000000dbf25fff] ACPI NVS
> BIOS-e820: [mem 0x00000000dbf26000-0x00000000dc4fefff] reserved
> BIOS-e820: [mem 0x00000000dc4ff000-0x00000000dc4fffff] usable
> BIOS-e820: [mem 0x00000000dc500000-0x00000000dfffffff] reserved
> BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000081dffffff] usable
> random: crng init done
> printk: debug: ignoring loglevel setting.
> printk: legacy bootconsole [earlyser0] enabled
> NX (Execute Disable) protection: active
> APIC: Static calls initialized
> e820: update [mem 0x00100000-0x0010000f] usable =3D=3D> usable
> extended physical RAM map:
> reserve setup_data: [mem 0x0000000000000400-0x00000000000903ff] usable
> reserve setup_data: [mem 0x0000000000090400-0x000000000009ffff] reserved
> reserve setup_data: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> reserve setup_data: [mem 0x0000000000100000-0x000000000010000f] usable
> reserve setup_data: [mem 0x0000000000100010-0x00000000cb11ffff] usable
> reserve setup_data: [mem 0x00000000cb120000-0x00000000cb120fff] ACPI NVS
> reserve setup_data: [mem 0x00000000cb121000-0x00000000cb14afff] reserved
> reserve setup_data: [mem 0x00000000cb14b000-0x00000000cb1a1fff] usable
> reserve setup_data: [mem 0x00000000cb1a2000-0x00000000cb9a2fff] reserved
> reserve setup_data: [mem 0x00000000cb9a3000-0x00000000db514fff] usable
> reserve setup_data: [mem 0x00000000db515000-0x00000000db738fff] reserved
> reserve setup_data: [mem 0x00000000db739000-0x00000000db772fff] ACPI data
> reserve setup_data: [mem 0x00000000db773000-0x00000000dbf25fff] ACPI NVS
> reserve setup_data: [mem 0x00000000dbf26000-0x00000000dc4fefff] reserved
> reserve setup_data: [mem 0x00000000dc4ff000-0x00000000dc4fffff] usable
> reserve setup_data: [mem 0x00000000dc500000-0x00000000dfffffff] reserved
> reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> reserve setup_data: [mem 0x0000000100000000-0x000000081dffffff] usable
> SMBIOS 3.0.0 present.
> DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> DMI: Memory slots populated: 4/4
> tsc: Detected 3200.000 MHz processor
> tsc: Detected 3199.980 MHz TSC
> e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
> e820: remove [mem 0x000a0000-0x000fffff] usable
> last_pfn =3D 0x81e000 max_arch_pfn =3D 0x400000000
> MTRR map: 4 entries (3 fixed + 1 variable; max 23), built from 10 variabl=
e MTRRs
> x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> x2apic: enabled by BIOS, switching to x2apic ops
> last_pfn =3D 0xdc500 max_arch_pfn =3D 0x400000000
> Scan for SMP in [mem 0x00000000-0x000003ff]
> Scan for SMP in [mem 0x0009fc00-0x0009ffff]
> Scan for SMP in [mem 0x000f0000-0x000fffff]
> found SMP MP-table at [mem 0x000fcdd0-0x000fcddf]
> mpc: fcba0-fcd54
> Using GB pages for direct mapping
> RAMDISK: [mem 0x7ab39e000-0x815ffffff]
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
> ACPI: XSDT 0x00000000DB7450A0 0000C4 (v01 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: FACP 0x00000000DB767A50 00010C (v05 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: DSDT 0x00000000DB7451F8 022857 (v02 DELL   CBX3     01072009 INTL 2=
0120913)
> ACPI: FACS 0x00000000DBF25D80 000040
> ACPI: APIC 0x00000000DB767B60 000084 (v03 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: FPDT 0x00000000DB767BE8 000044 (v01 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: MCFG 0x00000000DB767C30 00003C (v01 DELL   CBX3     01072009 MSFT 0=
0000097)
> ACPI: HPET 0x00000000DB767C70 000038 (v01 DELL   CBX3     01072009 AMI. 0=
005000B)
> ACPI: WSMT 0x00000000DB767CA8 000028 (v01 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: SSDT 0x00000000DB767CD0 00546C (v02 SaSsdt SaSsdt   00003000 INTL 2=
0120913)
> ACPI: UEFI 0x00000000DB76D140 000042 (v01                 00000000      0=
0000000)
> ACPI: LPIT 0x00000000DB76D188 000094 (v01 INTEL  SKL      00000000 MSFT 0=
000005F)
> ACPI: SSDT 0x00000000DB76D220 000248 (v02 INTEL  sensrhub 00000000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB76D468 002BAE (v02 INTEL  PtidDevc 00001000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB770018 000BE3 (v02 INTEL  Ther_Rvp 00001000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB770C00 0004A3 (v02 INTEL  zpodd    00001000 INTL 2=
0120913)
> ACPI: DBGP 0x00000000DB7710A8 000034 (v01 INTEL           00000000 MSFT 0=
000005F)
> ACPI: DBG2 0x00000000DB7710E0 000054 (v00 INTEL           00000000 MSFT 0=
000005F)
> ACPI: SSDT 0x00000000DB771138 000613 (v02 INTEL  DELL__MT 00000000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB771750 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 2=
0120913)
> ACPI: SLIC 0x00000000DB7725C8 000176 (v03 DELL   CBX3     01072009 MSFT 0=
0010013)
> ACPI: ASF! 0x00000000DB772740 0000A5 (v32 INTEL   HCG     00000001 TFSM 0=
00F4240)
> ACPI: DMAR 0x00000000DB7727E8 0000C8 (v01 INTEL  SKL      00000001 INTL 0=
0000001)
> ACPI: Reserving FACP table memory at [mem 0xdb767a50-0xdb767b5b]
> ACPI: Reserving DSDT table memory at [mem 0xdb7451f8-0xdb767a4e]
> ACPI: Reserving FACS table memory at [mem 0xdbf25d80-0xdbf25dbf]
> ACPI: Reserving APIC table memory at [mem 0xdb767b60-0xdb767be3]
> ACPI: Reserving FPDT table memory at [mem 0xdb767be8-0xdb767c2b]
> ACPI: Reserving MCFG table memory at [mem 0xdb767c30-0xdb767c6b]
> ACPI: Reserving HPET table memory at [mem 0xdb767c70-0xdb767ca7]
> ACPI: Reserving WSMT table memory at [mem 0xdb767ca8-0xdb767ccf]
> ACPI: Reserving SSDT table memory at [mem 0xdb767cd0-0xdb76d13b]
> ACPI: Reserving UEFI table memory at [mem 0xdb76d140-0xdb76d181]
> ACPI: Reserving LPIT table memory at [mem 0xdb76d188-0xdb76d21b]
> ACPI: Reserving SSDT table memory at [mem 0xdb76d220-0xdb76d467]
> ACPI: Reserving SSDT table memory at [mem 0xdb76d468-0xdb770015]
> ACPI: Reserving SSDT table memory at [mem 0xdb770018-0xdb770bfa]
> ACPI: Reserving SSDT table memory at [mem 0xdb770c00-0xdb7710a2]
> ACPI: Reserving DBGP table memory at [mem 0xdb7710a8-0xdb7710db]
> ACPI: Reserving DBG2 table memory at [mem 0xdb7710e0-0xdb771133]
> ACPI: Reserving SSDT table memory at [mem 0xdb771138-0xdb77174a]
> ACPI: Reserving SSDT table memory at [mem 0xdb771750-0xdb7725c2]
> ACPI: Reserving SLIC table memory at [mem 0xdb7725c8-0xdb77273d]
> ACPI: Reserving ASF! table memory at [mem 0xdb772740-0xdb7727e4]
> ACPI: Reserving DMAR table memory at [mem 0xdb7727e8-0xdb7728af]
> APIC: Switched APIC routing to: cluster x2apic
> No NUMA configuration found
> Faking a node at [mem 0x0000000000000000-0x000000081dffffff]
> NODE_DATA(0) allocated [mem 0x81dfd4c00-0x81dffffff]
> Zone ranges:
> DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> Normal   [mem 0x0000000100000000-0x000000081dffffff]
> Device   empty
> Movable zone start for each node
> Early memory node ranges
> node   0: [mem 0x0000000000001000-0x000000000008ffff]
> node   0: [mem 0x0000000000100000-0x00000000cb11ffff]
> node   0: [mem 0x00000000cb14b000-0x00000000cb1a1fff]
> node   0: [mem 0x00000000cb9a3000-0x00000000db514fff]
> node   0: [mem 0x00000000dc4ff000-0x00000000dc4fffff]
> node   0: [mem 0x0000000100000000-0x000000081dffffff]
> Initmem setup node 0 [mem 0x0000000000001000-0x000000081dffffff]
> On node 0, zone DMA: 1 pages in unavailable ranges
> On node 0, zone DMA: 112 pages in unavailable ranges
> On node 0, zone DMA32: 43 pages in unavailable ranges
> On node 0, zone DMA32: 2049 pages in unavailable ranges
> On node 0, zone DMA32: 4074 pages in unavailable ranges
> On node 0, zone Normal: 15104 pages in unavailable ranges
> On node 0, zone Normal: 8192 pages in unavailable ranges
> kasan: KernelAddressSanitizer initialized
> Reserving Intel graphics memory at [mem 0xde000000-0xdfffffff]
> ACPI: PM-Timer IO Port: 0x1808
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
> Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
> Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
> Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
> Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
> Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
> Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
> Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
> ACPI: Using ACPI (MADT) for SMP configuration information
> ACPI: HPET id: 0x8086a701 base: 0xfed00000
> TSC deadline timer available
> CPU topo: Max. logical packages:   1
> CPU topo: Max. logical dies:       1
> CPU topo: Max. dies per package:   1
> CPU topo: Max. threads per core:   1
> CPU topo: Num. cores per package:     4
> CPU topo: Num. threads per package:   4
> CPU topo: Allowing 4 present CPUs plus 0 hotplug CPUs
> mapped IOAPIC to ffffffffff5fb000 (fec00000)
> PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> PM: hibernation: Registered nosave memory: [mem 0x00090000-0x00090fff]
> PM: hibernation: Registered nosave memory: [mem 0x00091000-0x0009ffff]
> PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
> PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
> PM: hibernation: Registered nosave memory: [mem 0x00100000-0x00100fff]
> PM: hibernation: Registered nosave memory: [mem 0xcb120000-0xcb120fff]
> PM: hibernation: Registered nosave memory: [mem 0xcb121000-0xcb14afff]
> PM: hibernation: Registered nosave memory: [mem 0xcb1a2000-0xcb9a2fff]
> PM: hibernation: Registered nosave memory: [mem 0xdb515000-0xdb738fff]
> PM: hibernation: Registered nosave memory: [mem 0xdb739000-0xdb772fff]
> PM: hibernation: Registered nosave memory: [mem 0xdb773000-0xdbf25fff]
> PM: hibernation: Registered nosave memory: [mem 0xdbf26000-0xdc4fefff]
> PM: hibernation: Registered nosave memory: [mem 0xdc500000-0xdfffffff]
> PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
> PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
> PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfdffffff]
> PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
> PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [mem 0xe0000000-0xf7ffffff] available for PCI devices
> Booting paravirtualized kernel on bare hardware
> clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, ma=
x_idle_ns: 1910969940391419 ns
> setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> percpu: Embedded 85 pages/cpu s311296 r8192 d28672 u524288
> pcpu-alloc: s311296 r8192 d28672 u524288 alloc=3D1*2097152
> pcpu-alloc: [0] 0 1 2 3
> Kernel command line: ip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 RESULT_R=
OOT=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x8=
6_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031=
f4913fffcb/0 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4=
956ab4b8f06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49 branch=
=3Dlinux-next/master job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests=
-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21=
354-b34j8-1.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-9.4-bpf com=
mit=3Deca51ce01d4956ab4b8f06bb55c031f4913fffcb intremap=3Dposted_msi max_up=
time=3D1200 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=
=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifna=
mes=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3D=
panic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8=
 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlyprintk=3DttyS0=
,115200 console=3DttyS0,115200
> sysrq: sysrq always enabled.
> ignoring the deprecated load_ramdisk=3D option
> Unknown kernel command line parameters "nokaslr RESULT_ROOT=3D/result/per=
f-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-x86_64-20240206.cgz=
/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c031f4913fffcb/0 BOOT=
_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c0=
31f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49 branch=3Dlinux-next/mas=
ter job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_=
all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml =
user=3Dlkp ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-9.4-bpf commit=3Deca51ce01d4=
956ab4b8f06bb55c031f4913fffcb max_uptime=3D1200 LKP_SERVER=3Dinternal-lkp-s=
erver prompt_ramdisk=3D0 vga=3Dnormal", will be passed to user space.
> printk: log buffer data + meta data: 2097152 + 7340032 =3D 9437184 bytes
> Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, line=
ar)
> Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linea=
r)
> Fallback order for Node 0: 0
> Built 1 zonelists, mobility grouping on.  Total pages: 8359033
> Policy zone: Normal
> mem auto-init: stack:off, heap alloc:off, heap free:off
> stackdepot: allocating hash table via alloc_large_system_hash
> stackdepot hash table entries: 1048576 (order: 12, 16777216 bytes, linear=
)
> software IO TLB: area num 4.
> SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1
> Kernel/User page tables isolation: enabled
> Poking KASLR using RDRAND RDTSC...
> ftrace: allocating 59580 entries in 233 pages
> ftrace: allocated 233 pages with 5 groups
> Dynamic Preempt: full
> Running RCU self tests
> Running RCU synchronous self tests
> rcu: Preemptible hierarchical RCU implementation.
> rcu: 	RCU lockdep checking is enabled.
> rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D4.
> 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
> 	Trampoline variant of Tasks RCU enabled.
> 	Rude variant of Tasks RCU enabled.
> 	Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D4
> Running RCU synchronous self tests
> RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D1 rcu_tas=
k_cpu_ids=3D4.
> RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D1 rc=
u_task_cpu_ids=3D4.
> RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=3D1 r=
cu_task_cpu_ids=3D4.
> NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
> rcu: srcu_init: Setting srcu_struct sizes based on contention.
> Console: colour VGA+ 80x25
> printk: legacy console [tty0] enabled
> printk: legacy console [ttyS0] enabled
> printk: legacy console [ttyS0] enabled
> printk: legacy bootconsole [earlyser0] disabled
> printk: legacy bootconsole [earlyser0] disabled
> Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> ... MAX_LOCKDEP_SUBCLASSES:  8
> ... MAX_LOCK_DEPTH:          48
> ... MAX_LOCKDEP_KEYS:        8192
> ... CLASSHASH_SIZE:          4096
> ... MAX_LOCKDEP_ENTRIES:     32768
> ... MAX_LOCKDEP_CHAINS:      65536
> ... CHAINHASH_SIZE:          32768
> memory used by lock dependency info: 6429 kB
> memory used for stack traces: 4224 kB
> per task-struct memory footprint: 1920 bytes
> ACPI: Core revision 20240827
> clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: =
79635855245 ns
> APIC: Switch to symmetric I/O mode setup
> DMAR: Host address width 39
> DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3f=
f0505e
> DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050d=
a
> DMAR: RMRR base: 0x000000db5db000 end: 0x000000db5fafff
> DMAR: RMRR base: 0x000000dc024000 end: 0x000000dc26dfff
> DMAR: RMRR base: 0x000000dd800000 end: 0x000000dfffffff
> DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-r=
emapping.
> DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
> DMAR-IR: Enabled IRQ remapping in x2apic mode
> Masked ExtINT on CPU#0
> ENABLING IO-APIC IRQs
> Init IO_APIC IRQs
> apic 2 pin 0 not connected
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:=
0)
> apic 2 pin 16 not connected
> apic 2 pin 17 not connected
> apic 2 pin 18 not connected
> apic 2 pin 19 not connected
> apic 2 pin 20 not connected
> apic 2 pin 21 not connected
> apic 2 pin 22 not connected
> apic 2 pin 23 not connected
> apic 2 pin 24 not connected
> apic 2 pin 25 not connected
> apic 2 pin 26 not connected
> apic 2 pin 27 not connected
> apic 2 pin 28 not connected
> apic 2 pin 29 not connected
> apic 2 pin 30 not connected
> apic 2 pin 31 not connected
> apic 2 pin 32 not connected
> apic 2 pin 33 not connected
> apic 2 pin 34 not connected
> apic 2 pin 35 not connected
> apic 2 pin 36 not connected
> apic 2 pin 37 not connected
> apic 2 pin 38 not connected
> apic 2 pin 39 not connected
> apic 2 pin 40 not connected
> apic 2 pin 41 not connected
> apic 2 pin 42 not connected
> apic 2 pin 43 not connected
> apic 2 pin 44 not connected
> apic 2 pin 45 not connected
> apic 2 pin 46 not connected
> apic 2 pin 47 not connected
> apic 2 pin 48 not connected
> apic 2 pin 49 not connected
> apic 2 pin 50 not connected
> apic 2 pin 51 not connected
> apic 2 pin 52 not connected
> apic 2 pin 53 not connected
> apic 2 pin 54 not connected
> apic 2 pin 55 not connected
> apic 2 pin 56 not connected
> apic 2 pin 57 not connected
> apic 2 pin 58 not connected
> apic 2 pin 59 not connected
> apic 2 pin 60 not connected
> apic 2 pin 61 not connected
> apic 2 pin 62 not connected
> apic 2 pin 63 not connected
> apic 2 pin 64 not connected
> apic 2 pin 65 not connected
> apic 2 pin 66 not connected
> apic 2 pin 67 not connected
> apic 2 pin 68 not connected
> apic 2 pin 69 not connected
> apic 2 pin 70 not connected
> apic 2 pin 71 not connected
> apic 2 pin 72 not connected
> apic 2 pin 73 not connected
> apic 2 pin 74 not connected
> apic 2 pin 75 not connected
> apic 2 pin 76 not connected
> apic 2 pin 77 not connected
> apic 2 pin 78 not connected
> apic 2 pin 79 not connected
> apic 2 pin 80 not connected
> apic 2 pin 81 not connected
> apic 2 pin 82 not connected
> apic 2 pin 83 not connected
> apic 2 pin 84 not connected
> apic 2 pin 85 not connected
> apic 2 pin 86 not connected
> apic 2 pin 87 not connected
> apic 2 pin 88 not connected
> apic 2 pin 89 not connected
> apic 2 pin 90 not connected
> apic 2 pin 91 not connected
> apic 2 pin 92 not connected
> apic 2 pin 93 not connected
> apic 2 pin 94 not connected
> apic 2 pin 95 not connected
> apic 2 pin 96 not connected
> apic 2 pin 97 not connected
> apic 2 pin 98 not connected
> apic 2 pin 99 not connected
> apic 2 pin 100 not connected
> apic 2 pin 101 not connected
> apic 2 pin 102 not connected
> apic 2 pin 103 not connected
> apic 2 pin 104 not connected
> apic 2 pin 105 not connected
> apic 2 pin 106 not connected
> apic 2 pin 107 not connected
> apic 2 pin 108 not connected
> apic 2 pin 109 not connected
> apic 2 pin 110 not connected
> apic 2 pin 111 not connected
> apic 2 pin 112 not connected
> apic 2 pin 113 not connected
> apic 2 pin 114 not connected
> apic 2 pin 115 not connected
> apic 2 pin 116 not connected
> apic 2 pin 117 not connected
> apic 2 pin 118 not connected
> apic 2 pin 119 not connected
> ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e2036ff8d=
5, max_idle_ns: 440795275316 ns
> Calibrating delay loop (skipped), value calculated using timer frequency.=
. 6399.96 BogoMIPS (lpj=3D3199980)
> x86/cpu: SGX disabled or unsupported by BIOS.
> CPU0: Thermal monitoring enabled (TM1)
> Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
> Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> process: using mwait in idle threads
> Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sani=
tization
> Spectre V2 : Mitigation: IBRS
> Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context s=
witch
> Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
> RETBleed: Mitigation: IBRS
> Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction =
Barrier
> Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled v=
ia prctl
> MDS: Mitigation: Clear CPU buffers
> MMIO Stale Data: Mitigation: Clear CPU buffers
> SRBDS: Mitigation: Microcode
> GDS: Vulnerable: No microcode
> x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using '=
compacted' format.
> Freeing SMP alternatives memory: 48K
> pid_max: default: 32768 minimum: 301
> LSM: initializing lsm=3Dlockdown,capability,yama,bpf,ima,evm
> Yama: becoming mindful.
> LSM support for eBPF active
> Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linea=
r)
> Running RCU synchronous self tests
> Running RCU synchronous self tests
> smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (family: 0x6, mode=
l: 0x5e, stepping: 0x3)
> Running RCU Tasks wait API self tests
> Running RCU Tasks Rude wait API self tests
> Running RCU Tasks Trace wait API self tests
> Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width c=
ounters, Intel PMU driver.
> ... version:                4
> ... bit width:              48
> ... generic registers:      8
> ... value mask:             0000ffffffffffff
> ... max period:             00007fffffffffff
> ... fixed-purpose events:   3
> Callback from call_rcu_tasks_trace() invoked.
> ... event mask:             00000007000000ff
> signal: max sigframe size: 2032
> Estimated ratio of average max frequency by base frequency (times 1024): =
1056
> rcu: Hierarchical SRCU implementation.
> rcu: 	Max phase no-delay instances is 400.
> Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode le=
vel
> NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> smp: Bringing up secondary CPUs ...
> smpboot: x86: Booting SMP configuration:
> .... node  #0, CPUs:      #1 #2 #3
> Masked ExtINT on CPU#1
> Masked ExtINT on CPU#2
> Masked ExtINT on CPU#3
> smp: Brought up 1 node, 4 CPUs
> smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
> node 0 deferred pages initialised in 180ms
> Memory: 26713652K/33436132K available (30720K kernel code, 19538K rwdata,=
 21964K rodata, 7688K init, 19088K bss, 6709656K reserved, 0K cma-reserved)
> devtmpfs: initialized
> x86/mm: Memory block size: 128MB
> Callback from call_rcu_tasks() invoked.
> ACPI: PM: Registering ACPI NVS region [mem 0xcb120000-0xcb120fff] (4096 b=
ytes)
> ACPI: PM: Registering ACPI NVS region [mem 0xdb773000-0xdbf25fff] (807321=
6 bytes)
> Running RCU synchronous self tests
> Running RCU synchronous self tests
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_n=
s: 1911260446275000 ns
> futex hash table entries: 1024 (order: 5, 131072 bytes, linear)
> pinctrl core: initialized pinctrl subsystem
> NET: Registered PF_NETLINK/PF_ROUTE protocol family
> DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
> DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocatio=
ns
> audit: initializing netlink subsys (disabled)
> audit: type=3D2000 audit(1733574722.775:1): state=3Dinitialized audit_ena=
bled=3D0 res=3D1
> thermal_sys: Registered thermal governor 'fair_share'
> thermal_sys: Registered thermal governor 'step_wise'
> thermal_sys: Registered thermal governor 'user_space'
> cpuidle: using governor ladder
> cpuidle: using governor menu
> ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> PCI: ECAM [mem 0xf8000000-0xfbffffff] (base 0xf8000000) for domain 0000 [=
bus 00-3f]
> PCI: Using configuration type 1 for base access
> kprobes: kprobe jump-optimization is enabled. All kprobes are optimized i=
f possible.
> HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
> HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
> HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
> HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> cryptd: max_cpu_qlen set to 1000
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: 8 ACPI AML tables successfully acquired and loaded
> ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF8881018D2000 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF888102E28000 0006A2 (v02 PmRef  Cpu0Ist  00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF888102764900 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF8881015C5C00 000130 (v02 PmRef  HwpLvt   00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF888102E38000 0005AA (v02 PmRef  ApIst    00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF8881015F4800 000119 (v02 PmRef  ApHwp    00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF8881015F6000 000119 (v02 PmRef  ApCst    00003000 INTL 2=
0120913)
> ACPI: Interpreter enabled
> ACPI: PM: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs"=
 and report a bug
> PCI: Using E820 reservations for host bridge windows
> ACPI: Enabled 7 GPEs in block 00 to 7F
> ACPI: \_SB_.PCI0.PEG0.PG00: New power resource
> ACPI: \_SB_.PCI0.PEG1.PG01: New power resource
> ACPI: \_SB_.PCI0.PEG2.PG02: New power resource
> ACPI: \_SB_.PCI0.RP09.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP10.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP11.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP12.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP13.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP01.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP02.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP03.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP04.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP05.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP06.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP07.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP08.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP17.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP18.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP19.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP20.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP14.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP15.PXSX.WRST: New power resource
> ACPI: \_SB_.PCI0.RP16.PXSX.WRST: New power resource
> ACPI: \_TZ_.FN00: New power resource
> ACPI: \_TZ_.FN01: New power resource
> ACPI: \_TZ_.FN02: New power resource
> ACPI: \_TZ_.FN03: New power resource
> ACPI: \_TZ_.FN04: New power resource
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments =
MSI EDR HPX-Type3]
> acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIe=
Capability LTR DPC]
> acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug SHPCHotplug=
 PME AER PCIeCapability LTR DPC]
> acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_ERRO=
R)
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf7ffffff window]
> pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> pci_bus 0000:00: root bus resource [bus 00-3e]
> pci 0000:00:00.0: [8086:191f] type 00 class 0x060000 conventional PCI end=
point
> pci 0000:00:01.0: [8086:1901] type 01 class 0x060400 PCIe Root Port
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:02.0: [8086:1912] type 00 class 0x030000 PCIe Root Complex In=
tegrated Endpoint
> pci 0000:00:02.0: BAR 0 [mem 0xf6000000-0xf6ffffff 64bit]
> pci 0000:00:02.0: BAR 2 [mem 0xe0000000-0xefffffff 64bit pref]
> pci 0000:00:02.0: BAR 4 [io  0xf000-0xf03f]
> pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000=
dffff]
> pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330 conventional PCI end=
point
> pci 0000:00:14.0: BAR 0 [mem 0xf7030000-0xf703ffff 64bit]
> pci 0000:00:14.0: PME# supported from D3hot D3cold
> pci 0000:00:14.2: [8086:a131] type 00 class 0x118000 conventional PCI end=
point
> pci 0000:00:14.2: BAR 0 [mem 0xf704e000-0xf704efff 64bit]
> pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000 conventional PCI end=
point
> pci 0000:00:16.0: BAR 0 [mem 0xf704d000-0xf704dfff 64bit]
> pci 0000:00:16.0: PME# supported from D3hot
> pci 0000:00:17.0: [8086:2822] type 00 class 0x010400 conventional PCI end=
point
> pci 0000:00:17.0: BAR 0 [mem 0xf7048000-0xf7049fff]
> pci 0000:00:17.0: BAR 1 [mem 0xf704c000-0xf704c0ff]
> pci 0000:00:17.0: BAR 2 [io  0xf090-0xf097]
> pci 0000:00:17.0: BAR 3 [io  0xf080-0xf083]
> pci 0000:00:17.0: BAR 4 [io  0xf060-0xf07f]
> pci 0000:00:17.0: BAR 5 [mem 0xf704b000-0xf704b7ff]
> pci 0000:00:17.0: PME# supported from D3hot
> pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400 PCIe Root Port
> pci 0000:00:1c.0: PCI bridge to [bus 02-03]
> pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100 conventional PCI end=
point
> pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000 conventional PCI end=
point
> pci 0000:00:1f.2: BAR 0 [mem 0xf7044000-0xf7047fff]
> pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300 conventional PCI end=
point
> pci 0000:00:1f.3: BAR 0 [mem 0xf7040000-0xf7043fff 64bit]
> pci 0000:00:1f.3: BAR 4 [mem 0xf7020000-0xf702ffff 64bit]
> pci 0000:00:1f.3: PME# supported from D3hot D3cold
> pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500 conventional PCI end=
point
> pci 0000:00:1f.4: BAR 0 [mem 0xf704a000-0xf704a0ff 64bit]
> pci 0000:00:1f.4: BAR 4 [io  0xf040-0xf05f]
> pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000 conventional PCI end=
point
> pci 0000:00:1f.6: BAR 0 [mem 0xf7000000-0xf701ffff]
> pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:02:00.0: [104c:8240] type 01 class 0x060400 PCIe to PCI/PCI-X br=
idge
> pci 0000:02:00.0: PCI bridge to [bus 03]
> pci 0000:02:00.0: supports D1 D2
> pci 0000:00:1c.0: PCI bridge to [bus 02-03]
> pci_bus 0000:03: extended config space not accessible
> pci 0000:02:00.0: PCI bridge to [bus 03]
> ACPI: PCI: Interrupt link LNKA configured for IRQ 7
> ACPI: PCI: Interrupt link LNKA disabled
> ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> ACPI: PCI: Interrupt link LNKB disabled
> ACPI: PCI: Interrupt link LNKC configured for IRQ 5
> ACPI: PCI: Interrupt link LNKC disabled
> ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> ACPI: PCI: Interrupt link LNKD disabled
> ACPI: PCI: Interrupt link LNKE configured for IRQ 7
> ACPI: PCI: Interrupt link LNKE disabled
> ACPI: PCI: Interrupt link LNKF configured for IRQ 3
> ACPI: PCI: Interrupt link LNKF disabled
> ACPI: PCI: Interrupt link LNKG configured for IRQ 4
> ACPI: PCI: Interrupt link LNKG disabled
> ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> ACPI: PCI: Interrupt link LNKH disabled
> iommu: Default domain type: Translated
> iommu: DMA domain TLB invalidation policy: lazy mode
> SCSI subsystem initialized
> ACPI: bus type USB registered
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> pps_core: LinuxPPS API ver. 1 registered
> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <gio=
metti@linux.it>
> PTP clock support registered
> EDAC MC: Ver: 3.0.0
> NetLabel: Initializing
> NetLabel:  domain hash size =3D 128
> NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> NetLabel:  unlabeled traffic allowed by default
> PCI: Using ACPI for IRQ routing
> PCI: pci_cache_line_size set to 64 bytes
> e820: reserve RAM buffer [mem 0x00090400-0x0009ffff]
> e820: reserve RAM buffer [mem 0xcb120000-0xcbffffff]
> e820: reserve RAM buffer [mem 0xcb1a2000-0xcbffffff]
> e820: reserve RAM buffer [mem 0xdb515000-0xdbffffff]
> e820: reserve RAM buffer [mem 0xdc500000-0xdfffffff]
> e820: reserve RAM buffer [mem 0x81e000000-0x81fffffff]
> pci 0000:00:02.0: vgaarb: setting as boot VGA device
> pci 0000:00:02.0: vgaarb: bridge control possible
> pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+me=
m,locks=3Dnone
> vgaarb: loaded
> hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> clocksource: Switched to clocksource tsc-early
> VFS: Disk quotas dquot_6.6.0
> VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> netfs: FS-Cache loaded
> pnp: PnP ACPI init
> system 00:00: [io  0x0a00-0x0a3f] has been reserved
> system 00:00: [io  0x0a40-0x0a7f] has been reserved
> pnp 00:01: [dma 0 disabled]
> system 00:02: [io  0x0680-0x069f] has been reserved
> system 00:02: [io  0xffff] has been reserved
> system 00:02: [io  0xffff] has been reserved
> system 00:02: [io  0xffff] has been reserved
> system 00:02: [io  0x1800-0x18fe] has been reserved
> system 00:02: [io  0x164e-0x164f] has been reserved
> system 00:03: [io  0x0800-0x087f] has been reserved
> system 00:05: [io  0x1854-0x1857] has been reserved
> system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
> system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
> system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
> system 00:06: [mem 0xf8000000-0xfbffffff] has been reserved
> system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
> system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
> system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
> system 00:06: [mem 0xff000000-0xffffffff] has been reserved
> system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
> system 00:06: [mem 0xf7fe0000-0xf7ffffff] has been reserved
> system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
> system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
> system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
> system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reserved
> system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
> system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
> system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
> system 00:08: [io  0xff00-0xfffe] has been reserved
> system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
> system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
> system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
> pnp: PnP ACPI: found 10 devices
> clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2=
085701024 ns
> NET: Registered PF_INET protocol family
> IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> tcp_listen_portaddr_hash hash table entries: 16384 (order: 8, 1179648 byt=
es, linear)
> Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
> TCP established hash table entries: 262144 (order: 9, 2097152 bytes, line=
ar)
> TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hug=
epage)
> TCP: Hash tables configured (established 262144 bind 65536)
> MPTCP token hash table entries: 32768 (order: 9, 2883584 bytes, linear)
> UDP hash table entries: 16384 (order: 10, 4194304 bytes, linear)
> UDP-Lite hash table entries: 16384 (order: 10, 4194304 bytes, linear)
> NET: Registered PF_UNIX/PF_LOCAL protocol family
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp-with-tls transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> NET: Registered PF_XDP protocol family
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:02:00.0: PCI bridge to [bus 03]
> pci 0000:00:1c.0: PCI bridge to [bus 02-03]
> pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: resource 7 [mem 0xe0000000-0xf7ffffff window]
> pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:=
1)
> pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x1d0 took 33260 usecs
> PCI: CLS 0 bytes, default 64
> pci 0000:00:1f.1: [8086:a120] type 00 class 0x058000 conventional PCI end=
point
> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> Trying to unpack rootfs image as initramfs...
> software IO TLB: mapped [mem 0x00000000d7515000-0x00000000db515000] (64MB=
)
> ACPI: bus type thunderbolt registered
> AES CTR mode by8 optimization enabled
> Initialise system trusted keyrings
> Key type blacklist registered
> workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=3D0
> zbud: loaded
> fuse: init (API version 7.41)
> 9p: Installing v9fs 9p2000 file system support
> integrity: Platform Keyring initialized
> integrity: Machine keyring initialized
> NET: Registered PF_ALG protocol family
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
> io scheduler mq-deadline registered
> io scheduler kyber registered
> io scheduler bfq registered
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:=
1)
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/=
input0
> ACPI: button: Sleep Button [SLPB]
> input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/=
input1
> ACPI: button: Power Button [PWRB]
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> ACPI: button: Power Button [PWRF]
> thermal LNXTHERM:00: registered as thermal_zone0
> ACPI: thermal: Thermal Zone [TZ00] (28 C)
> thermal LNXTHERM:01: registered as thermal_zone1
> ACPI: thermal: Thermal Zone [TZ01] (30 C)
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
> Non-volatile memory driver v1.3
> loop: module loaded
> rdac: device handler registered
> hp_sw: device handler registered
> emc: device handler registered
> alua: device handler registered
> e1000: Intel(R) PRO/1000 Network Driver
> e1000: Copyright (c) 1999-2006 Intel Corporation.
> e1000e: Intel(R) PRO/1000 Network Driver
> e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:=
1)
> e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic =
conservative mode
> e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:00:6a:30:91:4=
8
> e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
> igb: Intel(R) Gigabit Ethernet Network Driver
> igb: Copyright (c) 2007-2014 Intel Corporation.
> Intel(R) 2.5G Ethernet Linux Driver
> Copyright(c) 2018 Intel Corporation.
> ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
> ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> i40e: Intel(R) Ethernet Connection XL710 Network Driver
> i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> usbcore: registered new device driver r8152-cfgselector
> usbcore: registered new interface driver r8152
> usbcore: registered new interface driver asix
> usbcore: registered new interface driver ax88179_178a
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0=
000000001109810
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDev=
ice=3D 6.13
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 6.13.0-rc1-00027-geca51ce01d49 xhci-hcd
> usb usb1: SerialNumber: 0000:00:14.0
> tsc: Refined TSC clocksource calibration: 3191.999 MHz
> hub 1-0:1.0: USB hub found
> clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e02c398820, max=
_idle_ns: 440795273435 ns
> hub 1-0:1.0: 16 ports detected
> clocksource: Switched to clocksource tsc
> usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDev=
ice=3D 6.13
> usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb2: Product: xHCI Host Controller
> usb usb2: Manufacturer: Linux 6.13.0-rc1-00027-geca51ce01d49 xhci-hcd
> usb usb2: SerialNumber: 0000:00:14.0
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 10 ports detected
> usbcore: registered new interface driver usbserial_generic
> usbserial: USB Serial support registered for generic
> i8042: PNP: No PS/2 controller found.
> mousedev: PS/2 mouse device common for all mice
> rtc_cmos 00:04: RTC can wake from S4
> rtc_cmos 00:04: registered as rtc0
> rtc_cmos 00:04: setting system clock to 2024-12-07T12:32:12 UTC (17335747=
32)
> rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram
> iTCO_vendor_support: vendor-support=3D0
> intel_pstate: HWP enabled by BIOS
> intel_pstate: Intel P-state driver initializing
> intel_pstate: HWP enabled
> hid: raw HID events driver (C) Jiri Kosina
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> drop_monitor: Initializing network drop monitor service
> Initializing XFRM netlink socket
> NET: Registered PF_INET6 protocol family
> Freeing initrd memory: 1749384K
> Segment Routing with IPv6
> In-situ OAM (IOAM) with IPv6
> NET: Registered PF_PACKET protocol family
> 9pnet: Installing 9P2000 support
> NET: Registered PF_VSOCK protocol family
> mpls_gso: MPLS GSO support
> microcode: Current revision: 0x000000f0
> IPI shorthand broadcast: enabled
> ... APIC ID:      00000000 (0)
> ... APIC VERSION: 01060015
> 0000000000000000000000000000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000000000000000000000001000
>
> number of MP IRQ sources: 15.
> number of IO-APIC #2 registers: 120.
> testing the IO APIC.......................
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00770020
> .......     : max redirection entries: 77
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 20
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
> IOAPIC 0:
> pin00, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin01, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped, I(0001),  Z(=
0)
> pin03, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin04, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin05, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin06, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin07, disabled, edge , high, V(01), IRR(0), S(0), remapped, I(0412),  Z(=
2)
> pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped, I(0007),  Z(=
0)
> pin09, enabled , level, high, V(09), IRR(0), S(0), remapped, I(0008),  Z(=
0)
> pin0a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin0b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin0c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin0d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin0e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin0f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin10, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin11, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin12, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin13, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin14, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin15, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin16, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin17, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin18, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin19, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin1a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin1b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin1c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin1d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin1e, disabled, edge , high, V(40), IRR(0), S(0), physic	al, D(1200), M(=
2)
> pin1f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin20, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin21, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin22, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin23, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin24, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin25, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin26, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin27, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin28, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin29, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin2a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin2b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin2c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin2d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin2e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin2f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin30, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin31, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin32, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin33, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin34, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin35, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin36, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin37, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin38, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin39, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin3a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(4000), M(=
2)
> pin3b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin3c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin3d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin3e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin3f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin40, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin41, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin42, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin43, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin44, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin45, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin46, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin47, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin48, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin49, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin4a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin4b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin4c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin4d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin4e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin4f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin50, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin51, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin52, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin53, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin54, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin55, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin56, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin57, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin58, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin59, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin5a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin5b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin5c, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin5d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin5e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin5f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin60, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin61, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin62, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin63, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin64, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin65, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin66, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin67, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin68, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin69, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin6a, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin6b, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin6c, disabled, edge , high, V(14), IRR(0), S(0), physic	al, D(1060), M(=
2)
> pin6d, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin6e, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin6f, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin70, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin71, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin72, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin73, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin74, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin75, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin76, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> pin77, disabled, edge , high, V(00), IRR(0), S(0), physic	al, D(0000), M(=
0)
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ16 -> 0:16
> IRQ19 -> 0:19
> .................................... done.
> sched_clock: Marking stable (125501010162, 1132075750)->(127044369487, -4=
11283575)
> registered taskstats version 1
> Loading compiled-in X.509 certificates
> Loaded X.509 cert 'Build time autogenerated kernel key: 7f19a3d4f59bb6116=
f921afe8b8db098c758382d'
> Demotion targets for Node 0: null
> Key type big_key registered
> Key type encrypted registered
> ima: No TPM chip found, activating TPM-bypass!
> Loading compiled-in module X.509 certificates
> Loaded X.509 cert 'Build time autogenerated kernel key: 7f19a3d4f59bb6116=
f921afe8b8db098c758382d'
> ima: Allocated hash algorithm: sha256
> ima: No architecture policies found
> evm: Initialising EVM extended attributes:
> evm: security.selinux
> evm: security.SMACK64 (disabled)
> evm: security.SMACK64EXEC (disabled)
> evm: security.SMACK64TRANSMUTE (disabled)
> evm: security.SMACK64MMAP (disabled)
> evm: security.apparmor (disabled)
> evm: security.ima
> evm: security.capability
> evm: HMAC attrs: 0x1
> Running certificate verification RSA selftest
> Loaded X.509 cert 'Certificate verification self-testing key: f58703bb33c=
e1b73ee02eccdee5b8817518fe3db'
> Running certificate verification ECDSA selftest
> Loaded X.509 cert 'Certificate verification ECDSA self-testing key: 2900b=
cea1deb7bc8479a84a23d758efdfdd2b2d3'
> e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Cont=
rol: None
> Sending DHCP requests ..., OK
> IP-Config: Got DHCP answer from 192.168.3.1, my address is 192.168.3.99
> IP-Config: Complete:
> device=3Deth0, hwaddr=3D64:00:6a:30:91:48, ipaddr=3D192.168.3.99, mask=3D=
255.255.255.0, gw=3D192.168.3.200
> host=3Dlkp-skl-d05, domain=3Dlkp.intel.com, nis-domain=3D(none)
> bootserver=3D192.168.3.200, rootserver=3D192.168.3.200, rootpath=3D
> nameserver0=3D192.168.3.200
> clk: Disabling unused clocks
> PM: genpd: Disabling unused power domains
> Freeing unused decrypted memory: 2028K
> Freeing unused kernel image (initmem) memory: 7688K
> Write protecting the kernel read-only data: 53248k
> Freeing unused kernel image (rodata/data gap) memory: 564K
> x86/mm: Checked W+X mappings: passed, no W+X pages found.
> x86/mm: Checking user space page tables
> x86/mm: Checked W+X mappings: passed, no W+X pages found.
> Run /init as init process
> with arguments:
> /init
> nokaslr
> with environment:
> HOME=3D/
> TERM=3Dlinux
> RESULT_ROOT=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/de=
bian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f=
06bb55c031f4913fffcb/0
> BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06=
bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49
> branch=3Dlinux-next/master
> job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_al=
l-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
> user=3Dlkp
> ARCH=3Dx86_64
> kconfig=3Dx86_64-rhel-9.4-bpf
> commit=3Deca51ce01d4956ab4b8f06bb55c031f4913fffcb
> max_uptime=3D1200
> LKP_SERVER=3Dinternal-lkp-server
> prompt_ramdisk=3D0
> vga=3Dnormal
> systemd[1]: RTC configured in localtime, applying delta of 0 minutes to s=
ystem time.
>
> device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lis=
ts.linux.dev
> ACPI: bus type drm_connector registered
> wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WQBC data block query control=
 method not found
> EDAC ie31200: No ECC support
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> EDAC ie31200: No ECC support
> intel_pmc_core INT33A1:00:  initialized
> Linux agpgart interface v0.103
> libata version 3.00 loaded.
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-17 -> IRQ 17 Level:1 ActiveLow:=
1)
> ahci 0000:00:17.0: controller can't do SNTF, turning off CAP_SNTF
> input: PC Speaker as /devices/platform/pcspkr/input/input3
> ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, RAID mo=
de
> i801_smbus 0000:00:1f.4: SPD Write Disable is set
> ahci 0000:00:17.0: 4/4 ports implemented (port mask 0xf)
> i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio slum part ems des=
o sadm sds apst
> iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=3D0=
x0400)
> IPMI message handler: version 39.2
> i2c i2c-0: Successfully instantiated SPD at 0x51
> scsi host0: ahci
> i2c i2c-0: Successfully instantiated SPD at 0x52
> i2c i2c-0: Successfully instantiated SPD at 0x53
> ipmi device interface
> scsi host1: ahci
> RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl time=
r
> RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> RAPL PMU: hw unit of domain package 2^-14 Joules
> RAPL PMU: hw unit of domain dram 2^-14 Joules
> LKP: ttyS0: 256: current_version: f0, target_version: f0
> scsi host3: ahci
> LKP: ttyS0: 256: skip deploy intel ucode as ucod[  143.466430][  T180] at=
a1: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b100 irq 129 lpm-pol=
 0
> e is same
> ata2: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b180 irq 129 lpm=
-pol 0
> ata3: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b200 irq 129 lpm=
-pol 0
> RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> ata4: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b280 irq 129 lpm=
-pol 0
> Error: Driver 'pcspkr' is already registered, aborting...
> ipmi_si: IPMI System Interface driver
> ipmi_si: Unable to find any System Interface(s)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata4: SATA link down (SStatus 4 SControl 300)
> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata2.00: Model 'INTEL SSDSC2KG960G8', rev 'XCV10120', applying quirks: ze=
roaftertrim
> ata2.00: ATA-10: INTEL SSDSC2KG960G8, XCV10120, max UDMA/133
> ata2.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 32)
> LKP: ttyS0: 256:[  143.860133][  T246] ata1.00: ATA-9: ST3000VX000-1ES166=
, CV27, max UDMA/133
> Kernel tests: B[  143.868917][  T272] ata2.00: configured for UDMA/133
> oot OK!
> ata1.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> ata1.00: configured for UDMA/133
> LKP: ttyS0: 256: HOSTNAME lkp-skl-d05, MAC 64:00:6a:30:91:48, kernel 6.13=
.0-rc1-00027-geca51ce01d49 1
> scsi 0:0:0:0: Direct-Access     ATA      ST3000VX000-1ES1 CV27 PQ: 0 ANSI=
: 5
> scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2KG96 0120 PQ: 0 ANSI=
: 5
> scsi 0:0:0:0: Attached scsi generic sg0 type 0
> input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wmi_bus/wmi_bus-P=
NP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input4
> scsi 1:0:0:0: Attached scsi generic sg1 type 0
> ata2.00: Enabling discard_zeroes_data
> sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
> sd 1:0:0:0: [sdb] 1875385008 512-byte logical blocks: (960 GB/894 GiB)
> sd 0:0:0:0: [sda] 4096-byte physical blocks
> sd 0:0:0:0: [sda] Write Protect is off
> sd 1:0:0:0: [sdb] 4096-byte physical blocks
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't supp=
ort DPO or FUA
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't supp=
ort DPO or FUA
> sd 1:0:0:0: [sdb] Preferred minimum I/O size 4096 bytes
> ata2.00: Enabling discard_zeroes_data
> sda: sda1 sda2 sda3 sda4
> sdb: sdb1 sdb2
> sd 0:0:0:0: [sda] Attached SCSI disk
> sd 1:0:0:0: [sdb] Attached SCSI disk
> i915 0000:00:02.0: [drm] Found skylake (device ID 1912) display version 9=
.00 stepping G0
> i915 0000:00:02.0: vgaarb: deactivate vga console
> Console: switching to colour dummy device 80x25
> i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=3Dio+mem,decod=
es=3Dio+mem:owns=3Dio+mem
> i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin fail=
ed with error -2
> i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27=
.bin (-ENOENT). Disabling runtime power management.
> i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pu=
b/scm/linux/kernel/git/firmware/linux-firmware.git
> [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
> ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:=
00/input/input5
> snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_=
bind_ops [i915])
> i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
> i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
> snd_hda_codec_realtek hdaudioC0D0: ALC3234: picked fixup  (pin match)
> snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC3234: line_outs=3D1 =
(0x1b/0x0/0x0/0x0/0x0) type:line
> snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D1 (0x14/0x0/0x0/0x0/=
0x0)
> snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0)
> snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0
> snd_hda_codec_realtek hdaudioC0D0:    inputs:
> snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=3D0x19
> snd_hda_codec_realtek hdaudioC0D0:      Headphone Mic=3D0x1a
> raid6: skipped pq benchmark and selected avx2x4
> raid6: using avx2x2 recovery algorithm
> xor: automatically using best checksumming function   avx
> input: HDA Intel PCH Headphone Mic as /devices/pci0000:00/0000:00:1f.3/so=
und/card0/input6
> input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1f.3/sound/c=
ard0/input7
> input: HDA Intel PCH HDMI/DP,pcm=3D3 as /devices/pci0000:00/0000:00:1f.3/=
sound/card0/input8
> input: HDA Intel PCH HDMI/DP,pcm=3D7 as /devices/pci0000:00/0000:00:1f.3/=
sound/card0/input9
> input: HDA Intel PCH HDMI/DP,pcm=3D8 as /devices/pci0000:00/0000:00:1f.3/=
sound/card0/input10
> intel_rapl_common: Found RAPL domain package
> intel_rapl_common: Found RAPL domain core
> intel_rapl_common: Found RAPL domain uncore
> intel_rapl_common: Found RAPL domain dram
> Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
> BTRFS: device fsid 64203e43-b048-4ba6-a0ac-92d7beafcd8a devid 1 transid 2=
7600 /dev/sdb1 (8:17) scanned by mount (522)
> BTRFS info (device sdb1): first mount of filesystem 64203e43-b048-4ba6-a0=
ac-92d7beafcd8a
> BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
> BTRFS info (device sdb1): using free-space-tree
> LKP: ttyS0: 256:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d0=
5/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51c=
e01d49-20241207-21354-b34j8-1.yaml
> LKP: ttyS0: 541: current_version: f0, target_version: f0
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> is_virt=3Dfalse
>
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0x00000000-0x00000fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> x86/PAT: bmc-watchdog:614 map pfn expected mapping type uncached-minus fo=
r [mem 0xdb745000-0xdb745fff], got write-back
> lkp: kernel tainted state: 0
>
> LKP: stdout: 256: Kernel tests: Boot OK!
>
> ntpdig: internal-lkp-server: Response dropped: stratum 0, probable KOD pa=
cket
>
> ntpdig: no eligible servers
>
> ar: creating libhelper.a
>
> LKP: stdout: 256: HOSTNAME lkp-skl-d05, MAC 64:00:6a:30:91:48, kernel 6.1=
3.0-rc1-00027-geca51ce01d49 1
>
> install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/=
ntpdate_1%3a4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1_all.deb
>
> /opt/deb/ntpsec-ntpdate_1.2.2+dfsg1-1+deb12u1_amd64.deb
>
> /opt/deb/python3-ntp_1.2.2+dfsg1-1+deb12u1_amd64.deb
>
> /opt/deb/patch_2.7.6-7_amd64.deb
>
> /opt/deb/libdpkg-perl_1.21.22_all.deb
>
> /opt/deb/g++_4%3a12.2.0-3_amd64.deb
>
> /opt/deb/g++-12_12.2.0-14_amd64.deb
>
> /opt/deb/gcc_4%3a12.2.0-3_amd64.deb
>
> /opt/deb/gcc-12_12.2.0-14_amd64.deb
>
> /opt/deb/libgcc-12-dev_12.2.0-14_amd64.deb
>
> /opt/deb/libquadmath0_12.2.0-14_amd64.deb
>
> /opt/deb/libatomic1_12.2.0-14_amd64.deb
>
> Selecting previously unselected package ntpdate.
>
> (Reading database ... 16595 files and directories currently installed.)
>
> Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1=
_all.deb ...
>
> Unpacking ntpdate (1:4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1) ...
>
> Selecting previously unselected package ntpsec-ntpdate.
>
> Preparing to unpack .../ntpsec-ntpdate_1.2.2+dfsg1-1+deb12u1_amd64.deb ..=
.
>
> Unpacking ntpsec-ntpdate (1.2.2+dfsg1-1+deb12u1) ...
>
> Selecting previously unselected package python3-ntp.
>
> Preparing to unpack .../python3-ntp_1.2.2+dfsg1-1+deb12u1_amd64.deb ...
>
> Unpacking python3-ntp (1.2.2+dfsg1-1+deb12u1) ...
>
> Selecting previously unselected package patch.
>
> Preparing to unpack .../deb/patch_2.7.6-7_amd64.deb ...
>
> Unpacking patch (2.7.6-7) ...
>
> Selecting previously unselected package libdpkg-perl.
>
> Preparing to unpack .../libdpkg-perl_1.21.22_all.deb ...
>
> Unpacking libdpkg-perl (1.21.22) ...
>
> Selecting previously unselected package g++.
>
> Preparing to unpack .../deb/g++_4%3a12.2.0-3_amd64.deb ...
>
> Unpacking g++ (4:12.2.0-3) ...
>
> Selecting previously unselected package g++-12.
>
> Preparing to unpack .../deb/g++-12_12.2.0-14_amd64.deb ...
>
> Unpacking g++-12 (12.2.0-14) ...
>
> Selecting previously unselected package gcc.
>
> Preparing to unpack .../deb/gcc_4%3a12.2.0-3_amd64.deb ...
>
> Unpacking gcc (4:12.2.0-3) ...
>
> Selecting previously unselected package gcc-12.
>
> Preparing to unpack .../deb/gcc-12_12.2.0-14_amd64.deb ...
>
> Unpacking gcc-12 (12.2.0-14) ...
>
> Selecting previously unselected package libgcc-12-dev:amd64.
>
> Preparing to unpack .../libgcc-12-dev_12.2.0-14_amd64.deb ...
>
> Unpacking libgcc-12-dev:amd64 (12.2.0-14) ...
>
> Selecting previously unselected package libquadmath0:amd64.
>
> Preparing to unpack .../libquadmath0_12.2.0-14_amd64.deb ...
>
> Unpacking libquadmath0:amd64 (12.2.0-14) ...
>
> Selecting previously unselected package libatomic1:amd64.
>
> Preparing to unpack .../libatomic1_12.2.0-14_amd64.deb ...
>
> Unpacking libatomic1:amd64 (12.2.0-14) ...
>
> Setting up python3-ntp (1.2.2+dfsg1-1+deb12u1) ...
>
> Setting up patch (2.7.6-7) ...
>
> Setting up libdpkg-perl (1.21.22) ...
>
> Setting up libquadmath0:amd64 (12.2.0-14) ...
>
> Setting up libatomic1:amd64 (12.2.0-14) ...
>
> Setting up libgcc-12-dev:amd64 (12.2.0-14) ...
>
> Setting up ntpdate (1:4.2.8p15+dfsg-2~1.2.2+dfsg1-1+deb12u1) ...
>
> Setting up ntpsec-ntpdate (1.2.2+dfsg1-1+deb12u1) ...
>
> Setting up g++ (4:12.2.0-3) ...
>
> update-alternatives: using /usr/bin/g++ to provide /usr/bin/c++ (c++) in =
auto mode
>
> Setting up g++-12 (12.2.0-14) ...
>
> Setting up gcc (4:12.2.0-3) ...
>
> Setting up gcc-12 (12.2.0-14) ...
>
> Processing triggers for libc-bin (2.36-9+deb12u8) ...
>
> NO_NETWORK=3D
>
> LKP: stdout: 256:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d=
05/perf-event-tests-not_paranoid_at_all-debian-12-x86_64-20240206.cgz-eca51=
ce01d49-20241207-21354-b34j8-1.yaml
>
> RESULT_ROOT=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/de=
bian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f=
06bb55c031f4913fffcb/0
>
> job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_al=
l-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
>
> result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESU=
LT_ROOT: /internal-lkp-server/result/perf-event-tests/not_paranoid_at_all/l=
kp-skl-d05/debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce=
01d4956ab4b8f06bb55c031f4913fffcb/0, TMP_RESULT_ROOT: /tmp/lkp/result
>
> run-job /lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_=
all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
>
> /usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 ht=
tp://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D=
/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_all-debian=
-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml&job_state=
=3Drunning -O /dev/null
>
> target ucode: 0xf0
>
> LKP: stdout: 541: current_version: f0, target_version: f0
>
> check_nr_cpu
>
> CPU(s):                               4
>
> On-line CPU(s) list:                  0-3
>
> Model name:                           Intel(R) Core(TM) i5-6500 CPU @ 3.2=
0GHz
>
> BIOS Model name:                      Intel(R) Core(TM) i5-6500 CPU @ 3.2=
0GHz  CPU @ 3.2GHz
>
> Thread(s) per core:                   1
>
> Core(s) per socket:                   4
>
> Socket(s):                            1
>
> CPU(s) scaling MHz:                   94%
>
> NUMA node(s):                         1
>
> NUMA node0 CPU(s):                    0-3
>
> linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9.4-bpf-eca51ce01=
d4956ab4b8f06bb55c031f4913fffcb
>
> make -C lib
>
> make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/lib'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o bpf_help=
ers.o bpf_helpers.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o branches=
_testcode.o branches_testcode.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o detect_c=
ache.o detect_cache.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o instruct=
ions_testcode.o instructions_testcode.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o matrix_m=
ultiply.o matrix_multiply.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o nops_tes=
tcode.o nops_testcode.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o parse_re=
cord.o parse_record.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o perf_hel=
pers.o perf_helpers.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o test_uti=
ls.o test_utils.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o tracefs_=
helpers.o tracefs_helpers.c
>
> ar r libhelper.a bpf_helpers.o branches_testcode.o detect_cache.o instruc=
tions_testcode.o matrix_multiply.o nops_testcode.o parse_record.o perf_help=
ers.o test_utils.o tracefs_helpers.o
>
> ranlib libhelper.a
>
> make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/lib'
>
> make -C tests
>
> make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/tests'
>
> make -C attr_fields
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/attr_=
fields'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o disab=
led.o disabled.c
>
> gcc   disabled.o ../../lib/libhelper.a  -lpthread -o disabled
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o enabl=
e_on_exec.o enable_on_exec.c
>
> gcc   enable_on_exec.o ../../lib/libhelper.a  -lpthread -o enable_on_exec
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclu=
de_guest.o exclude_guest.c
>
> gcc   exclude_guest.o ../../lib/libhelper.a  -lpthread -o exclude_guest
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclu=
de_host.o exclude_host.c
>
> gcc   exclude_host.o ../../lib/libhelper.a  -lpthread -o exclude_host
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclu=
de_idle.o exclude_idle.c
>
> IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
>
> gcc   exclude_idle.o ../../lib/libhelper.a  -lpthread -o exclude_idle
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclu=
de_hv.o exclude_hv.c
>
> gcc   exclude_hv.o ../../lib/libhelper.a  -lpthread -o exclude_hv
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclu=
de_kernel.o exclude_kernel.c
>
> gcc   exclude_kernel.o ../../lib/libhelper.a  -lpthread -o exclude_kernel
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclu=
de_user.o exclude_user.c
>
> gcc   exclude_user.o ../../lib/libhelper.a  -lpthread -o exclude_user
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o exclu=
sive.o exclusive.c
>
> gcc   exclusive.o ../../lib/libhelper.a  -lpthread -o exclusive
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o forma=
t_id_support.o format_id_support.c
>
> gcc   format_id_support.o ../../lib/libhelper.a  -lpthread -o format_id_s=
upport
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o inher=
it.o inherit.c
>
> gcc   inherit.o ../../lib/libhelper.a  -lpthread -o inherit
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o inher=
it_stat.o inherit_stat.c
>
> gcc   inherit_stat.o ../../lib/libhelper.a  -lpthread -o inherit_stat
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pinne=
d.o pinned.c
>
> gcc   pinned.o ../../lib/libhelper.a  -lpthread -o pinned
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o read_=
format_range_check.o read_format_range_check.c
>
> gcc   read_format_range_check.o ../../lib/libhelper.a  -lpthread -o read_=
format_range_check
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
e_type_range_check.o sample_type_range_check.c
>
> gcc   sample_type_range_check.o ../../lib/libhelper.a  -lpthread -o sampl=
e_type_range_check
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/attr_f=
ields'
>
> make -C breakpoints
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/break=
points'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o break=
point_support.o breakpoint_support.c
>
> gcc   breakpoint_support.o ../../lib/libhelper.a   -o breakpoint_support
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/breakp=
oints'
>
> make -C bugs
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/bugs'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check=
_schedulability.o check_schedulability.c
>
> gcc   check_schedulability.o ../../lib/libhelper.a   -o check_schedulabil=
ity
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o nmi_w=
atchdog_group_leader.o nmi_watchdog_group_leader.c
>
> gcc   nmi_watchdog_group_leader.o ../../lib/libhelper.a   -o nmi_watchdog=
_group_leader
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o peo_z=
ero_return.o peo_zero_return.c
>
> gcc   peo_zero_return.o ../../lib/libhelper.a   -o peo_zero_return
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o read_=
group_attached.o read_group_attached.c
>
> gcc   read_group_attached.o ../../lib/libhelper.a   -o read_group_attache=
d
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sync_=
read_required.o sync_read_required.c
>
> gcc   sync_read_required.o ../../lib/libhelper.a   -o sync_read_required
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/bugs'
>
> make -C constraints
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/const=
raints'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check=
_constraints.o check_constraints.c
>
> gcc   check_constraints.o ../../lib/libhelper.a   -o check_constraints
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/constr=
aints'
>
> make -C corner_cases
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/corne=
r_cases'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check=
_reset_mpx.o check_reset_mpx.c
>
> gcc   check_reset_mpx.o ../../lib/libhelper.a   -o check_reset_mpx
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o conte=
xt_switch_user_kernel.o context_switch_user_kernel.c
>
> gcc   context_switch_user_kernel.o ../../lib/libhelper.a   -o context_swi=
tch_user_kernel
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o huge_=
events_start.o huge_events_start.c
>
> gcc   huge_events_start.o ../../lib/libhelper.a   -o huge_events_start
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o huge_=
group_start.o huge_group_start.c
>
> gcc   huge_group_start.o ../../lib/libhelper.a   -o huge_group_start
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o hw_sw=
_mix.o hw_sw_mix.c
>
> gcc   hw_sw_mix.o ../../lib/libhelper.a   -o hw_sw_mix
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_refresh_0.o ioctl_refresh_0.c
>
> gcc   ioctl_refresh_0.o ../../lib/libhelper.a   -o ioctl_refresh_0
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o max_m=
ultiplex.o max_multiplex.c
>
> gcc   max_multiplex.o ../../lib/libhelper.a   -o max_multiplex
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o max_n=
um_events.o max_num_events.c
>
> gcc   max_num_events.o ../../lib/libhelper.a   -o max_num_events
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o multi=
ple_active.o multiple_active.c
>
> gcc   multiple_active.o ../../lib/libhelper.a   -o multiple_active
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overf=
low_requires_mmap.o overflow_requires_mmap.c
>
> gcc   overflow_requires_mmap.o ../../lib/libhelper.a   -o overflow_requir=
es_mmap
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o reset=
_leader.o reset_leader.c
>
> gcc   reset_leader.o ../../lib/libhelper.a   -o reset_leader
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
ed_notleader_refresh.o sampled_notleader_refresh.c
>
> gcc   sampled_notleader_refresh.o ../../lib/libhelper.a   -o sampled_notl=
eader_refresh
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o signa=
l_after_close.o signal_after_close.c
>
> gcc   signal_after_close.o ../../lib/libhelper.a   -o signal_after_close
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o signa=
l_after_exec.o signal_after_exec.c
>
> gcc   signal_after_exec.o ../../lib/libhelper.a   -o signal_after_exec
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sw_st=
art_leader.o sw_start_leader.c
>
> gcc   sw_start_leader.o ../../lib/libhelper.a   -o sw_start_leader
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o wrap.=
o wrap.c
>
> gcc   wrap.o ../../lib/libhelper.a   -o wrap
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o wrong=
_size_enospc.o wrong_size_enospc.c
>
> gcc   wrong_size_enospc.o ../../lib/libhelper.a   -o wrong_size_enospc
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/corner=
_cases'
>
> make -C error_returns
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/error=
_returns'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o e2big=
.o e2big.c
>
> gcc   e2big.o ../../lib/libhelper.a   -o e2big
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eacce=
s.o eacces.c
>
> gcc   eacces.o ../../lib/libhelper.a   -o eacces
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ebadf=
.o ebadf.c
>
> gcc   ebadf.o ../../lib/libhelper.a   -o ebadf
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o efaul=
t.o efault.c
>
> gcc   efault.o ../../lib/libhelper.a   -o efault
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o einva=
l.o einval.c
>
> gcc   einval.o ../../lib/libhelper.a   -o einval
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o emfil=
e.o emfile.c
>
> gcc   emfile.o ../../lib/libhelper.a   -o emfile
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o enoen=
t.o enoent.c
>
> gcc   enoent.o ../../lib/libhelper.a   -o enoent
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o enosp=
c.o enospc.c
>
> gcc   enospc.o ../../lib/libhelper.a   -o enospc
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eopno=
tsupp.o eopnotsupp.c
>
> gcc   eopnotsupp.o ../../lib/libhelper.a   -o eopnotsupp
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eover=
flow.o eoverflow.c
>
> gcc   eoverflow.o ../../lib/libhelper.a   -o eoverflow
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o eperm=
.o eperm.c
>
> gcc   eperm.o ../../lib/libhelper.a   -o eperm
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o esrch=
.o esrch.c
>
> gcc   esrch.o ../../lib/libhelper.a   -o esrch
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o non-e=
xistent.o non-existent.c
>
> gcc   non-existent.o ../../lib/libhelper.a   -o non-existent
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/error_=
returns'
>
> make -C flags
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/flags=
'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags=
_cgroup.o flags_cgroup.c
>
> gcc   flags_cgroup.o ../../lib/libhelper.a   -o flags_cgroup
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags=
_fd_no_group.o flags_fd_no_group.c
>
> gcc   flags_fd_no_group.o ../../lib/libhelper.a   -o flags_fd_no_group
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags=
_fd_output.o flags_fd_output.c
>
> gcc   flags_fd_output.o ../../lib/libhelper.a   -o flags_fd_output
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o flags=
_range_check.o flags_range_check.c
>
> gcc   flags_range_check.o ../../lib/libhelper.a   -o flags_range_check
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/flags'
>
> make -C generalized_events
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/gener=
alized_events'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o branc=
hes.o branches.c
>
> gcc   branches.o ../../lib/libhelper.a   -o branches
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o branc=
h-misses.o branch-misses.c
>
> gcc   branch-misses.o ../../lib/libhelper.a   -o branch-misses
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o cycle=
s.o cycles.c
>
> gcc  -o cycles cycles.o ../../lib/libhelper.a -lrt
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o instr=
uctions.o instructions.c
>
> gcc   instructions.o ../../lib/libhelper.a   -o instructions
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o l1-dc=
ache-loads.o l1-dcache-loads.c
>
> gcc   l1-dcache-loads.o ../../lib/libhelper.a   -o l1-dcache-loads
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o l1-dc=
ache-stores.o l1-dcache-stores.c
>
> gcc   l1-dcache-stores.o ../../lib/libhelper.a   -o l1-dcache-stores
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/genera=
lized_events'
>
> make -C ioctl
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/ioctl=
'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_flag_group.o ioctl_flag_group.c
>
> gcc   ioctl_flag_group.o ../../lib/libhelper.a   -o ioctl_flag_group
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_0_enable.o ioctl_0_enable.c
>
> gcc   ioctl_0_enable.o ../../lib/libhelper.a   -o ioctl_0_enable
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_1_disable.o ioctl_1_disable.c
>
> gcc   ioctl_1_disable.o ../../lib/libhelper.a   -o ioctl_1_disable
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_2_refresh.o ioctl_2_refresh.c
>
> gcc   ioctl_2_refresh.o ../../lib/libhelper.a   -o ioctl_2_refresh
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_3_reset.o ioctl_3_reset.c
>
> gcc   ioctl_3_reset.o ../../lib/libhelper.a   -o ioctl_3_reset
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_4_period.o ioctl_4_period.c
>
> gcc   ioctl_4_period.o ../../lib/libhelper.a   -o ioctl_4_period
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_5_set_output.o ioctl_5_set_output.c
>
> gcc   ioctl_5_set_output.o ../../lib/libhelper.a   -o ioctl_5_set_output
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_6_set_filter.o ioctl_6_set_filter.c
>
> gcc   ioctl_6_set_filter.o ../../lib/libhelper.a   -o ioctl_6_set_filter
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_7_id.o ioctl_7_id.c
>
> gcc   ioctl_7_id.o ../../lib/libhelper.a   -o ioctl_7_id
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_8_set_bpf.o ioctl_8_set_bpf.c
>
> gcc   ioctl_8_set_bpf.o ../../lib/libhelper.a   -o ioctl_8_set_bpf
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_9_pause_output.o ioctl_9_pause_output.c
>
> gcc   ioctl_9_pause_output.o ../../lib/libhelper.a   -o ioctl_9_pause_out=
put
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_10_query_bpf.o ioctl_10_query_bpf.c
>
> gcc   ioctl_10_query_bpf.o ../../lib/libhelper.a   -o ioctl_10_query_bpf
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ioctl=
_11_modify_attributes.o ioctl_11_modify_attributes.c
>
> gcc   ioctl_11_modify_attributes.o ../../lib/libhelper.a   -o ioctl_11_mo=
dify_attributes
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/ioctl'
>
> make -C multiplexing
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/multi=
plexing'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check=
_multiplexing.o check_multiplexing.c
>
> gcc   check_multiplexing.o ../../lib/libhelper.a   -o check_multiplexing
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check=
_papi_multiplexing.o check_papi_multiplexing.c
>
> gcc   check_papi_multiplexing.o ../../lib/libhelper.a   -o check_papi_mul=
tiplexing
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o old_m=
ultiplexing.o old_multiplexing.c
>
> gcc   old_multiplexing.o ../../lib/libhelper.a   -o old_multiplexing
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/multip=
lexing'
>
> make -C multithread
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/multi=
thread'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fork_=
then_read.o fork_then_read.c
>
> gcc   fork_then_read.o ../../lib/libhelper.a   -o fork_then_read
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o lots_=
of_forks.o lots_of_forks.c
>
> gcc   lots_of_forks.o ../../lib/libhelper.a   -o lots_of_forks
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o open_=
fork_close_kill.o open_fork_close_kill.c
>
> gcc   open_fork_close_kill.o ../../lib/libhelper.a   -o open_fork_close_k=
ill
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/multit=
hread'
>
> make -C openmp
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/openm=
p'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o openm=
p_test.o openmp_test.c
>
> gcc   openmp_test.o ../../lib/libhelper.a  -fopenmp -o openmp_test
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o openm=
p_overflow.o openmp_overflow.c
>
> gcc   openmp_overflow.o ../../lib/libhelper.a  -fopenmp -o openmp_overflo=
w
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o openm=
p_sample.o openmp_sample.c
>
> gcc   openmp_sample.o ../../lib/libhelper.a  -fopenmp -o openmp_sample
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/openmp=
'
>
> make -C overflow
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/overf=
low'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o break=
point_overflow.o breakpoint_overflow.c
>
> gcc   breakpoint_overflow.o ../../lib/libhelper.a   -o breakpoint_overflo=
w
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overf=
low_large.o overflow_large.c
>
> gcc   overflow_large.o ../../lib/libhelper.a   -o overflow_large
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overf=
low_poll.o overflow_poll.c
>
> gcc   overflow_poll.o ../../lib/libhelper.a   -o overflow_poll
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overf=
low_signal.o overflow_signal.c
>
> gcc   overflow_signal.o ../../lib/libhelper.a   -o overflow_signal
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overf=
low_skid.o overflow_skid.c
>
> gcc   overflow_skid.o ../../lib/libhelper.a   -o overflow_skid
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overf=
low_requires_wakeup.o overflow_requires_wakeup.c
>
> gcc   overflow_requires_wakeup.o ../../lib/libhelper.a   -o overflow_requ=
ires_wakeup
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simpl=
e_overflow_leader.o simple_overflow_leader.c
>
> gcc   simple_overflow_leader.o ../../lib/libhelper.a   -o simple_overflow=
_leader
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simpl=
e_overflow_leader_poll.o simple_overflow_leader_poll.c
>
> gcc   simple_overflow_leader_poll.o ../../lib/libhelper.a   -o simple_ove=
rflow_leader_poll
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simpl=
e_overflow_sibling.o simple_overflow_sibling.c
>
> gcc   simple_overflow_sibling.o ../../lib/libhelper.a   -o simple_overflo=
w_sibling
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simul=
taneous_group_overflow.o simultaneous_group_overflow.c
>
> gcc   simultaneous_group_overflow.o ../../lib/libhelper.a   -o simultaneo=
us_group_overflow
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simul=
_oneshot_group_overflow.o simul_oneshot_group_overflow.c
>
> gcc   simul_oneshot_group_overflow.o ../../lib/libhelper.a   -o simul_one=
shot_group_overflow
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o simul=
taneous_overflow.o simultaneous_overflow.c
>
> gcc   simultaneous_overflow.o ../../lib/libhelper.a   -o simultaneous_ove=
rflow
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o singl=
e_shot_overflow.o single_shot_overflow.c
>
> gcc   single_shot_overflow.o ../../lib/libhelper.a   -o single_shot_overf=
low
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o singl=
e_shot_w_enable.o single_shot_w_enable.c
>
> gcc   single_shot_w_enable.o ../../lib/libhelper.a   -o single_shot_w_ena=
ble
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o wakeu=
p_events_overflow.o wakeup_events_overflow.c
>
> gcc   wakeup_events_overflow.o ../../lib/libhelper.a   -o wakeup_events_o=
verflow
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/overfl=
ow'
>
> make -C periodic_stats
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/perio=
dic_stats'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o print=
_record_sample.o print_record_sample.c
>
> gcc   print_record_sample.o  -lpthread -o print_record_sample
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/period=
ic_stats'
>
> make -C prctl
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/prctl=
'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl=
.o prctl.c
>
> gcc   prctl.o ../../lib/libhelper.a   -o prctl
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl=
_attach.o prctl_attach.c
>
> gcc   prctl_attach.o ../../lib/libhelper.a   -o prctl_attach
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl=
_child.o prctl_child.c
>
> gcc   prctl_child.o ../../lib/libhelper.a   -o prctl_child
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl=
_inherit.o prctl_inherit.c
>
> gcc   prctl_inherit.o ../../lib/libhelper.a   -o prctl_inherit
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o prctl=
_parent.o prctl_parent.c
>
> gcc   prctl_parent.o ../../lib/libhelper.a   -o prctl_parent
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/prctl'
>
> make -C rdpmc
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/rdpmc=
'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_attach.o rdpmc_attach.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_lib.o rdpmc_lib.c
>
> gcc   rdpmc_attach.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpm=
c_attach
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_attach_cpu.o rdpmc_attach_cpu.c
>
> gcc   rdpmc_attach_cpu.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o =
rdpmc_attach_cpu
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_attach_global_cpu.o rdpmc_attach_global_cpu.c
>
> gcc   rdpmc_attach_global_cpu.o rdpmc_lib.o ../../lib/libhelper.a  -lpthr=
ead -o rdpmc_attach_global_cpu
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_attach_other_cpu.o rdpmc_attach_other_cpu.c
>
> gcc   rdpmc_attach_other_cpu.o rdpmc_lib.o ../../lib/libhelper.a  -lpthre=
ad -o rdpmc_attach_other_cpu
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_attach_multi_enable.o rdpmc_attach_multi_enable.c
>
> gcc   rdpmc_attach_multi_enable.o rdpmc_lib.o ../../lib/libhelper.a  -lpt=
hread -o rdpmc_attach_multi_enable
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_exec.o rdpmc_exec.c
>
> gcc   rdpmc_exec.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc_=
exec
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_exec_papi.o rdpmc_exec_papi.c
>
> gcc   rdpmc_exec_papi.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o r=
dpmc_exec_papi
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_group.o rdpmc_group.c
>
> gcc   rdpmc_group.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc=
_group
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_group_syswide.o rdpmc_group_syswide.c
>
> gcc   rdpmc_group_syswide.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread =
-o rdpmc_group_syswide
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_invalid.o rdpmc_invalid.c
>
> gcc   rdpmc_invalid.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdp=
mc_invalid
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_multiattach.o rdpmc_multiattach.c
>
> gcc   rdpmc_multiattach.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o=
 rdpmc_multiattach
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_multiattach_papi.o rdpmc_multiattach_papi.c
>
> gcc   rdpmc_multiattach_papi.o rdpmc_lib.o ../../lib/libhelper.a  -lpthre=
ad -o rdpmc_multiattach_papi
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_multiplexing.o rdpmc_multiplexing.c
>
> gcc   rdpmc_multiplexing.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -=
o rdpmc_multiplexing
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_pthreads.o rdpmc_pthreads.c
>
> gcc   rdpmc_pthreads.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rd=
pmc_pthreads
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_pthreads_group.o rdpmc_pthreads_group.c
>
> gcc   rdpmc_pthreads_group.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread=
 -o rdpmc_pthreads_group
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_reset.o rdpmc_reset.c
>
> gcc   rdpmc_reset.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdpmc=
_reset
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_support.o rdpmc_support.c
>
> gcc   rdpmc_support.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o rdp=
mc_support
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_sw_events.o rdpmc_sw_events.c
>
> gcc   rdpmc_sw_events.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o r=
dpmc_sw_events
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_validation.o rdpmc_validation.c
>
> gcc   rdpmc_validation.o rdpmc_lib.o ../../lib/libhelper.a  -lpthread -o =
rdpmc_validation
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_comparision_readsyscall.o rdpmc_comparision_readsyscall.c
>
> gcc   rdpmc_comparision_readsyscall.o  -lpthread -o rdpmc_comparision_rea=
dsyscall
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o rdpmc=
_comparision_mmap.o rdpmc_comparision_mmap.c
>
> gcc   rdpmc_comparision_mmap.o  -lpthread -o rdpmc_comparision_mmap
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/rdpmc'
>
> make -C record_sample
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/recor=
d_sample'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o lost_=
record_sample.o lost_record_sample.c
>
> gcc   lost_record_sample.o ../../lib/libhelper.a   -o lost_record_sample
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o mmap_=
multiple.o mmap_multiple.c
>
> gcc   mmap_multiple.o ../../lib/libhelper.a   -o mmap_multiple
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o multi=
ple_mmap_sizes.o multiple_mmap_sizes.c
>
> gcc   multiple_mmap_sizes.o ../../lib/libhelper.a   -o multiple_mmap_size=
s
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o overw=
rite_mmap.o overwrite_mmap.c
>
> gcc   overwrite_mmap.o ../../lib/libhelper.a   -o overwrite_mmap
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o print=
_record_sample.o print_record_sample.c
>
> gcc   print_record_sample.o ../../lib/libhelper.a   -o print_record_sampl=
e
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o recor=
d_comm.o record_comm.c
>
> gcc   record_comm.o ../../lib/libhelper.a   -o record_comm
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o recor=
d_comm_exec.o record_comm_exec.c
>
> gcc   record_comm_exec.o ../../lib/libhelper.a   -o record_comm_exec
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o recor=
d_fork.o record_fork.c
>
> gcc   record_fork.o ../../lib/libhelper.a   -o record_fork
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o recor=
d_mmap.o record_mmap.c
>
> gcc   record_mmap.o ../../lib/libhelper.a   -o record_mmap
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o recor=
d_mmap2.o record_mmap2.c
>
> gcc   record_mmap2.o ../../lib/libhelper.a   -o record_mmap2
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o recor=
d_mmap_data.o record_mmap_data.c
>
> gcc   record_mmap_data.o ../../lib/libhelper.a   -o record_mmap_data
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
e_branch_stack.o sample_branch_stack.c
>
> gcc   sample_branch_stack.o ../../lib/libhelper.a   -o sample_branch_stac=
k
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
e_data_src.o sample_data_src.c
>
> gcc   sample_data_src.o ../../lib/libhelper.a   -o sample_data_src
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
e_regs_intr.o sample_regs_intr.c
>
> gcc   sample_regs_intr.o ../../lib/libhelper.a   -o sample_regs_intr
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
e_regs_user.o sample_regs_user.c
>
> gcc   sample_regs_user.o ../../lib/libhelper.a   -o sample_regs_user
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
e_stack_user.o sample_stack_user.c
>
> gcc   sample_stack_user.o ../../lib/libhelper.a   -o sample_stack_user
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o sampl=
e_weight.o sample_weight.c
>
> gcc   sample_weight.o ../../lib/libhelper.a   -o sample_weight
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o valid=
ate_record_sample.o validate_record_sample.c
>
> gcc   validate_record_sample.o ../../lib/libhelper.a   -o validate_record=
_sample
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/record=
_sample'
>
> make -C size
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/size'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o heade=
r_mismatch.o header_mismatch.c
>
> gcc   header_mismatch.o ../../lib/libhelper.a   -o header_mismatch
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o just_=
right.o just_right.c
>
> gcc   just_right.o ../../lib/libhelper.a   -o just_right
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o too_b=
ig.o too_big.c
>
> gcc   too_big.o ../../lib/libhelper.a   -o too_big
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o too_l=
ittle.o too_little.c
>
> gcc   too_little.o ../../lib/libhelper.a   -o too_little
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/size'
>
> make -C socket
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/socke=
t'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o socke=
t_pass.o socket_pass.c
>
> gcc   socket_pass.o ../../lib/libhelper.a   -o socket_pass
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/socket=
'
>
> make -C sysfs
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/sysfs=
'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o event=
s.o events.c
>
> gcc   events.o ../../lib/libhelper.a   -o events
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/sysfs'
>
> make -C tracepoints
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/trace=
points'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o trace=
point_alias.o tracepoint_alias.c
>
> gcc   tracepoint_alias.o ../../lib/libhelper.a   -o tracepoint_alias
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/tracep=
oints'
>
> make -C utils
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/utils=
'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o check=
_paranoid.o check_paranoid.c
>
> gcc   check_paranoid.o ../../lib/libhelper.a   -o check_paranoid
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o get_c=
ache_info.o get_cache_info.c
>
> gcc   get_cache_info.o ../../lib/libhelper.a   -o get_cache_info
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/utils'
>
> make -C x86_amd
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/x86_a=
md'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ibs_f=
etch.o ibs_fetch.c
>
> gcc   ibs_fetch.o ../../lib/libhelper.a   -o ibs_fetch
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o ibs_o=
p.o ibs_op.c
>
> gcc   ibs_op.o ../../lib/libhelper.a   -o ibs_op
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/x86_am=
d'
>
> make -C x86_intel
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/tests/x86_i=
ntel'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o bts_a=
ux.o bts_aux.c
>
> gcc   bts_aux.o ../../lib/libhelper.a   -o bts_aux
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o bts_k=
ernel.o bts_kernel.c
>
> gcc   bts_kernel.o ../../lib/libhelper.a   -o bts_kernel
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fixed=
_ctr0.o fixed_ctr0.c
>
> gcc   fixed_ctr0.o ../../lib/libhelper.a   -o fixed_ctr0
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fixed=
_ctr1.o fixed_ctr1.c
>
> gcc   fixed_ctr1.o ../../lib/libhelper.a   -o fixed_ctr1
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o fixed=
_ctr2.o fixed_ctr2.c
>
> gcc   fixed_ctr2.o ../../lib/libhelper.a   -o fixed_ctr2
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o offco=
re_response.o offcore_response.c
>
> gcc   offcore_response.o ../../lib/libhelper.a   -o offcore_response
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o offco=
re_response_mask.o offcore_response_mask.c
>
> gcc   offcore_response_mask.o ../../lib/libhelper.a   -o offcore_response=
_mask
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs.=
o pebs.c
>
> gcc   pebs.o ../../lib/libhelper.a   -o pebs
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs_=
addr.o pebs_addr.c
>
> gcc   pebs_addr.o ../../lib/libhelper.a   -o pebs_addr
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs_=
latency.o pebs_latency.c
>
> gcc   pebs_latency.o ../../lib/libhelper.a   -o pebs_latency
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o pebs_=
registers.o pebs_registers.c
>
> gcc   pebs_registers.o ../../lib/libhelper.a   -o pebs_registers
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncor=
e_events.o uncore_events.c
>
> gcc   uncore_events.o ../../lib/libhelper.a   -o uncore_events
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncor=
e_cpu_cbox.o uncore_cpu_cbox.c
>
> gcc   uncore_cpu_cbox.o ../../lib/libhelper.a   -o uncore_cpu_cbox
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncor=
e_max_cbox.o uncore_max_cbox.c
>
> gcc   uncore_max_cbox.o ../../lib/libhelper.a   -o uncore_max_cbox
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../../include  -c -o uncor=
e_group_cbox.o uncore_group_cbox.c
>
> gcc   uncore_group_cbox.o ../../lib/libhelper.a   -o uncore_group_cbox
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests/x86_in=
tel'
>
> make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/tests'
>
> make -C crashes
>
> make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/crashes'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o pe_inher=
it_memleak.o pe_inherit_memleak.c
>
> gcc   pe_inherit_memleak.o ../lib/libhelper.a  -lpthread -o pe_inherit_me=
mleak
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o pe_task_=
schedule_panic.o pe_task_schedule_panic.c
>
> gcc   pe_task_schedule_panic.o ../lib/libhelper.a  -lpthread -o pe_task_s=
chedule_panic
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o perf_mma=
p_close_bug.o perf_mmap_close_bug.c
>
> gcc   perf_mmap_close_bug.o ../lib/libhelper.a  -lpthread -o perf_mmap_cl=
ose_bug
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o offcore_=
response_mask.o offcore_response_mask.c
>
> gcc   offcore_response_mask.o ../lib/libhelper.a  -lpthread -o offcore_re=
sponse_mask
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o oflo_sw_=
cpu_clock_crash.o oflo_sw_cpu_clock_crash.c
>
> gcc   oflo_sw_cpu_clock_crash.o ../lib/libhelper.a  -lpthread -o oflo_sw_=
cpu_clock_crash
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o sw_event=
_config_overflow.o sw_event_config_overflow.c
>
> gcc   sw_event_config_overflow.o ../lib/libhelper.a  -lpthread -o sw_even=
t_config_overflow
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o nmi_soft=
_lockup.o nmi_soft_lockup.c
>
> gcc   nmi_soft_lockup.o  -lpthread -o nmi_soft_lockup
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o tracepoi=
nt_irq_work_exit.o tracepoint_irq_work_exit.c
>
> gcc   tracepoint_irq_work_exit.o  -lpthread -o tracepoint_irq_work_exit
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o arm_vali=
date_event_oops.o arm_validate_event_oops.c
>
> gcc   arm_validate_event_oops.o  -lpthread -o arm_validate_event_oops
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o arm_map_=
hw_event_oops.o arm_map_hw_event_oops.c
>
> gcc   arm_map_hw_event_oops.o  -lpthread -o arm_map_hw_event_oops
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o perf_ftr=
ace_event_crash.o perf_ftrace_event_crash.c
>
> gcc   perf_ftrace_event_crash.o  -lpthread -o perf_ftrace_event_crash
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o css_cgro=
up_crash.o css_cgroup_crash.c
>
> gcc   css_cgroup_crash.o ../lib/libhelper.a  -lpthread -o css_cgroup_cras=
h
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o rapl_cra=
sh.o rapl_crash.c
>
> gcc   rapl_crash.o ../lib/libhelper.a  -lpthread -o rapl_crash
>
> make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/crashes'
>
> make -C fuzzer
>
> make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/fuzzer'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o perf_fuzzer.o perf_fuzzer.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o perf_attr_print.o perf_attr_print.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o get_cpuinfo.o get_cpuinfo.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o filter_address.o filter_address.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o filter_tracepoint.o filter_tracepoint.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_access.o fuzz_access.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_close.o fuzz_close.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_fork.o fuzz_fork.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_ioctl.o fuzz_ioctl.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_million.o fuzz_million.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_mmap.o fuzz_mmap.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_open.o fuzz_open.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_overflow.o fuzz_overflow.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_poll.o fuzz_poll.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_prctl.o fuzz_prctl.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_read.o fuzz_read.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_vsyscall.o fuzz_vsyscall.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzz_write.o fuzz_write.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzzer_random.o fuzzer_random.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o fuzzer_stats.o fuzzer_stats.c
>
> make -C trinity_files
>
> make[2]: Entering directory '/lkp/benchmarks/perf_event_tests/fuzzer/trin=
ity_files'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o fds.o fds.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o generic-sanitise.o generic-sanitise.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o interesting-numbers.o interesting-numbers.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o log.o log.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o perf_event_open.o perf_event_open.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o pids.o pids.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o random-address.o random-address.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o random-length.o random-length.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o random.o random.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o shm.o shm.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o unicode.o unicode.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I./include -I../../include =
-I.  -c -o utils.o utils.c
>
> ar ru trinity_lib.a fds.o generic-sanitise.o interesting-numbers.o log.o =
perf_event_open.o pids.o random-address.o random-length.o random.o shm.o un=
icode.o utils.o
>
> ar: `u' modifier ignored since `D' is the default (see `U')
>
> ar: creating trinity_lib.a
>
> ranlib trinity_lib.a
>
> make[2]: Leaving directory '/lkp/benchmarks/perf_event_tests/fuzzer/trini=
ty_files'
>
> gcc   perf_fuzzer.o perf_attr_print.o get_cpuinfo.o filter_address.o filt=
er_tracepoint.o fuzz_access.o fuzz_close.o fuzz_fork.o fuzz_ioctl.o fuzz_mi=
llion.o fuzz_mmap.o fuzz_open.o fuzz_overflow.o fuzz_poll.o fuzz_prctl.o fu=
zz_read.o fuzz_vsyscall.o fuzz_write.o fuzzer_random.o fuzzer_stats.o ../li=
b/libhelper.a trinity_files/trinity_lib.a   -o perf_fuzzer
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o replay_log.o replay_log.c
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o parse_log.o parse_log.c
>
> gcc   replay_log.o parse_log.o ../lib/libhelper.a perf_attr_print.o trini=
ty_files/trinity_lib.a   -o replay_log
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o log_to_code.o log_to_code.c
>
> gcc   log_to_code.o perf_attr_print.o parse_log.o ../lib/libhelper.a   -o=
 log_to_code
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include   filter_log.c   -o filter_log
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include -I./include -I.=
/trinity_files/include  -c -o active_events.o active_events.c
>
> gcc   active_events.o parse_log.o ../lib/libhelper.a perf_attr_print.o   =
-o active_events
>
> make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/fuzzer'
>
> make -C tools
>
> make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/tools'
>
> gcc -Wno-all -Wno-incompatible-pointer-types   -c -o event_parser.o event=
_parser.c
>
> gcc   event_parser.o   -o event_parser
>
> gcc -Wno-all -Wno-incompatible-pointer-types   -c -o trace_event_parser.o=
 trace_event_parser.c
>
> gcc   trace_event_parser.o   -o trace_event_parser
>
> gcc -Wno-all -Wno-incompatible-pointer-types   -c -o trace_filter_generat=
or.o trace_filter_generator.c
>
> gcc   trace_filter_generator.o   -o trace_filter_generator
>
> make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/tools'
>
> make -C warnings
>
> make[1]: Entering directory '/lkp/benchmarks/perf_event_tests/warnings'
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o core2_nm=
i_flood.o core2_nmi_flood.c
>
> gcc   core2_nmi_flood.o   -o core2_nmi_flood
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o kec_2122=
_warn.o kec_2122_warn.c
>
> gcc   kec_2122_warn.o ../lib/libhelper.a   -o kec_2122_warn
>
> gcc -Wno-all -Wno-incompatible-pointer-types -I../include  -c -o pec_1076=
_warn.o pec_1076_warn.c
>
> gcc   pec_1076_warn.o ../lib/libhelper.a   -o pec_1076_warn
>
> make[1]: Leaving directory '/lkp/benchmarks/perf_event_tests/warnings'
>
> mount: /sys/kernel/tracing: nodev already mounted or mount point busy.
>
> dmesg(1) may have more information after failed mount system call.
>
> 2024-12-07 12:36:04 ./run_tests.sh
>
>
>
> **** RUNNING perf_event_tests ****
>
> Linux lkp-skl-d05 6.13.0-rc1-00027-geca51ce01d49 #1 SMP PREEMPT_DYNAMIC S=
at Dec  7 16:35:26 CST 2024 x86_64 GNU/Linux
>
>
>
> * Testing /proc/sys/kernel/perf_event_paranoid setting
>
> + tests/utils/check_paranoid
>
> Checking /proc/sys/kernel/perf_event_paranoid setting...   PASSED
>
>
>
> * Checking infrastructure
>
> + tests/utils/get_cache_info
>
> Seeing if cache info is provided by the kernel...          PASSED
>
> + tests/sysfs/events
>
> Testing format of event files under /sys/...               PASSED
>
>
>
> * Checking generalized events
>
> + tests/generalized_events/branches
>
> Testing "branches" generalized event...                    PASSED
>
> + tests/generalized_events/branch-misses
>
> Testing "branch-misses" generalized event...               PASSED
>
> + tests/generalized_events/cycles
>
> Testing "cycles" generalized event...                      PASSED
>
> + tests/generalized_events/instructions
>
> Testing "instructions" generalized event...                PASSED
>
> + tests/generalized_events/l1-dcache-stores
>
> Testing "L1-dcache-stores" generalized event...            FAILED
>
> + tests/generalized_events/l1-dcache-loads
>
> Testing "L1-dcache-loads" generalized event...             FAILED
>
>
>
> * Checking Intel x86 specific features
>
> + tests/x86_intel/fixed_ctr0
>
> Testing fixed counter 0 event...                           PASSED
>
> + tests/x86_intel/fixed_ctr1
>
> Testing fixed counter 1 event...                           PASSED
>
> + tests/x86_intel/fixed_ctr2
>
> Testing fixed counter 2 event...                           PASSED
>
> + tests/x86_intel/offcore_response
>
> Testing RAW access to offcore response counters...         PASSED
>
> + tests/x86_intel/offcore_response_mask
>
> Testing if setting invalid offcore bits is blocked...      PASSED
>
> + tests/x86_intel/uncore_events
>
> Testing uncore events...                                   PASSED
>
>
>
> * Checking breakpoint support
>
> + tests/breakpoints/breakpoint_support
>
> Testing hardware breakpoints...                            PASSED
>
>
>
> * Checking basic perf_event functionality
>
> + tests/attr_fields/disabled
>
> Testing disabled bit...                                    PASSED
>
> + tests/attr_fields/exclusive
>
> Testing exclusive eventsets...                             FAILED
>
> + tests/attr_fields/format_id_support
>
> Testing for FORMAT_ID support...                           PASSED
>
> + tests/attr_fields/inherit
>
> Testing inherit...                                         PASSED
>
> + tests/attr_fields/inherit_stat
>
> Testing inherit_stat...                                    UNEXPLAINED
>
> + tests/attr_fields/pinned
>
> Testing pinned...                                          PASSED
>
> + tests/attr_fields/read_format_range_check
>
> Testing attr->read_format invalid bits...                  PASSED
>
> + tests/attr_fields/sample_type_range_check
>
> Testing attr->sample_type invalid bits...                  PASSED
>
> + tests/attr_fields/exclude_user
>
> Testing exclude_user...                                    PASSED
>
> + tests/attr_fields/exclude_kernel
>
> Testing exclude_kernel...                                  PASSED
>
> + tests/attr_fields/exclude_hv
>
> Testing exclude_hv...                                      PASSED
>
> + tests/attr_fields/exclude_idle
>
> Testing exclude_idle...                                    PASSED
>
> + tests/attr_fields/exclude_guest
>
> Testing exclude_guest...                                   PASSED
>
> + tests/attr_fields/exclude_host
>
> Testing exclude_host...                                    PASSED
>
> + tests/flags/flags_range_check
>
> Testing flags invalid bits...                              PASSED
>
> + tests/flags/flags_cgroup
>
> Testing PERF_FLAG_PID_CGROUP flag...                       SKIPPED
>
> + tests/flags/flags_fd_no_group
>
> Testing PERF_FLAG_FD_NO_GROUP flag...                      PASSED
>
> + tests/flags/flags_fd_output
>
> Testing PERF_FLAG_FD_OUTPUT flag...                        KNOWN KERNEL B=
UG
>
> + tests/socket/socket_pass
>
> Testing passing fd over a socket...                        PASSED
>
>
>
> * Checking attr.size behavior
>
> + tests/size/too_big
>
> Testing attr > kernel supported size...                    PASSED
>
> + tests/size/too_little
>
> Testing attr < kernel supported size...                    PASSED
>
> + tests/size/just_right
>
> Testing attr is kernel supported size...                   PASSED
>
> + tests/size/header_mismatch
>
> Testing header vs kernel attr size...                      PASSED
>
>
>
> * Checking perf_event ioctl calls
>
> + tests/ioctl/ioctl_flag_group
>
> Testing PERF_IOC_FLAG_GROUP...                             PASSED
>
> + tests/ioctl/ioctl_0_enable
>
> Testing ioctl(PERF_EVENT_IOC_ENABLE)...                    PASSED
>
> + tests/ioctl/ioctl_1_disable
>
> Testing ioctl(PERF_EVENT_IOC_DISABLE)...                   PASSED
>
> + tests/ioctl/ioctl_2_refresh
>
> perf: interrupt took too long (2503 > 2500), lowering kernel.perf_event_m=
ax_sample_rate to 79000
> Testing ioctl(PERF_IOC_REFRESH)...                         PASSED
>
> + tests/ioctl/ioctl_3_reset
>
> Testing ioctl(PERF_IOC_RESET)...                           PASSED
>
> + tests/ioctl/ioctl_4_period
>
> Testing ioctl(PERF_EVENT_IOC_PERIOD)...                    PASSED
>
> + tests/ioctl/ioctl_5_set_output
>
> Testing PERF_EVENT_IOC_SET_OUTPUT ioctl...                 PASSED
>
> + tests/ioctl/ioctl_6_set_filter
>
> Testing PERF_EVENT_IOC_SET_FILTER ioctl...                 PASSED
>
> + tests/ioctl/ioctl_7_id
>
> Testing ioctl(PERF_EVENT_IOC_ID)...                        PASSED
>
> + tests/ioctl/ioctl_8_set_bpf
>
> We are running release 6.13.0-rc1-00027-geca51ce01d49
>
> Using LINUX_VERSION_CODE: 396544
>
> Testing PERF_EVENT_IOC_SET_BPF ioctl...                    PASSED
>
> + tests/ioctl/ioctl_9_pause_output
>
> perf: interrupt took too long (3174 > 3128), lowering kernel.perf_event_m=
ax_sample_rate to 63000
> Testing ioctl(PERF_IOC_PAUSE_OUTPUT)...                    PASSED
>
> + tests/ioctl/ioctl_10_query_bpf
>
> Testing PERF_EVENT_IOC_QUERY_BPF ioctl...                  PASSED
>
> + tests/ioctl/ioctl_11_modify_attributes
>
> Testing ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES)...         PASSED
>
>
>
> * Checking perf_event prctl calls
>
> + tests/prctl/prctl
>
> Testing prctl()...                                         PASSED
>
> + tests/prctl/prctl_child
>
> Testing if prctl() affects attached events...              PASSED
>
> + tests/prctl/prctl_parent
>
> Testing if prctl() affects remote attached events...       PASSED
>
> + tests/prctl/prctl_inherit
>
> Testing if prctl() affects inherited events...             PASSED
>
> + tests/prctl/prctl_attach
>
> Testing if prctl() affects attached events...              PASSED
>
>
>
> * Checking error returns
>
> + tests/error_returns/e2big
>
> Testing E2BIG errors...                                    PASSED
>
> + tests/error_returns/eacces
>
> Testing EACCES generation...                               PASSED
>
> + tests/error_returns/ebadf
>
> Testing EBADF generation...                                PASSED
>
> + tests/error_returns/efault
>
> Testing EFAULT generation...                               PASSED
>
> + tests/error_returns/einval
>
> Testing EINVAL generation...                               PASSED
>
> + tests/error_returns/emfile
>
> Testing if EMFILE can be triggered...                      PASSED
>
> + tests/error_returns/enoent
>
> Testing ENOENT generation...                               FAILED
>
> + tests/error_returns/enospc
>
> Testing ENOSPC generation...                               PASSED
>
> + tests/error_returns/eopnotsupp
>
> Testing EOPNOTSUPP generation...                           PASSED
>
> + tests/error_returns/eoverflow
>
> Testing EOVERFLOW generation...                            PASSED
>
> + tests/error_returns/eperm
>
> Testing EPERM generation...                                PASSED
>
> + tests/error_returns/esrch
>
> Testing ESRCH generation...                                PASSED
>
> + tests/error_returns/non-existent
>
> 	Failed with wrong error fd=3D-1 error 22 !=3D 2 Invalid argument!
>
> Testing if non-existent events fail...                     FAILED
>
>
>
> * Checking multithread functionality
>
> + tests/multithread/fork_then_read
>
> Testing reads in forked children...                        PASSED
>
>
>
> * Checking overflow functionality
>
> + tests/overflow/breakpoint_overflow
>
> Testing hardware breakpoint overflow...                    PASSED
>
> + tests/overflow/simple_overflow_leader
>
> Testing overflow on leaders...                             PASSED
>
> + tests/overflow/simple_overflow_sibling
>
> Testing overflows on sibling...                            PASSED
>
> + tests/overflow/simultaneous_overflow
>
> Testing multiple event overflow...                         PASSED
>
> + tests/overflow/simultaneous_group_overflow
>
> perf: interrupt took too long (3987 > 3967), lowering kernel.perf_event_m=
ax_sample_rate to 50000
> Testing multiple event overflow within group...            PASSED
>
> + tests/overflow/simul_oneshot_group_overflow
>
> Testing simultaneous one-shot group overflow...            PASSED
>
> + tests/overflow/single_shot_overflow
>
> Testing single shot overflow...                            PASSED
>
> + tests/overflow/single_shot_w_enable
>
> Testing enable vs refresh signal types...                  PASSED
>
> + tests/overflow/wakeup_events_overflow
>
> Testing wakeup events overflow...                          PASSED
>
> + tests/overflow/overflow_requires_wakeup
>
> Testing if we overflow w/o setting wakeup...               PASSED
>
> + tests/overflow/overflow_poll
>
> Testing catching overflow with poll()...                   PASSED
>
> + tests/overflow/overflow_large
>
> Testing large sample_period...                             PASSED
>
> + tests/overflow/overflow_skid
>
> Testing if we can skid into kernel...                      KNOWN KERNEL B=
UG
>
>
>
> * Checking tracepoint functionality
>
> + tests/tracepoints/tracepoint_alias
>
> Testing if tracepoint event ids alias...                   PASSED
>
> perf: interrupt took too long (5010 > 4983), lowering kernel.perf_event_m=
ax_sample_rate to 39000
>
>
> * Checking mmap record sample functionality
>
> + tests/record_sample/print_record_sample
>
> Testing record sampling...                                 PASSED
>
> + tests/record_sample/validate_record_sample
>
> Validating sample record overflow...                       PASSED
>
> + tests/record_sample/lost_record_sample
>
> Checking behavior on mmap overflow...                      PASSED
>
> + tests/record_sample/multiple_mmap_sizes
>
> Checking behavior of various mmap sizes...                 PASSED
>
> + tests/record_sample/sample_branch_stack
>
> Testing PERF_SAMPLE_BRANCH_STACK...                        PASSED
>
> + tests/record_sample/record_comm
>
> Testing PERF_RECORD_COMM...                                PASSED
>
> + tests/record_sample/record_comm_exec
>
> Testing PERF_RECORD_COMM_EXEC...                           PASSED
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + tests/record_sample/record_fork
> BUG: KASAN: null-ptr-deref in perf_mmap_to_page+0x1b/0x150
> Read of size 4 at addr 0000000000000178 by task record_mmap/2618
>
>
> CPU: 0 UID: 0 PID: 2618 Comm: record_mmap Not tainted 6.13.0-rc1-00027-ge=
ca51ce01d49 #1
> Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> Call Trace:
> <TASK>
> dump_stack_lvl+0x62/0x90
> Testing PERF_RECORD_FORK...                                PASSED
> kasan_report+0xb9/0xf0
> ? perf_mmap_to_page+0x1b/0x150
>
> perf_mmap_to_page+0x1b/0x150
> perf_mmap+0x5cb/0xda0
> ? __init_rwsem+0xd4/0xf0
> + tests/record_sample/record_mmap
> __mmap_new_vma+0x1f9/0x5f0
> __mmap_region+0x52e/0x950
>
> ? __pfx___mmap_region+0x10/0x10
> ? lock_is_held_type+0x9a/0x110
> ? vm_unmapped_area+0x2b6/0x470
> ? lock_acquire+0x123/0x2e0
> ? mm_get_unmapped_area_vmflags+0x4d/0xa0
> mmap_region+0x136/0x170
> do_mmap+0x6a2/0x810
> ? __pfx_do_mmap+0x10/0x10
> ? down_write_killable+0x131/0x1d0
> ? __pfx_down_write_killable+0x10/0x10
> ? __fget_files+0x114/0x1f0
> vm_mmap_pgoff+0x184/0x280
> ? __pfx_vm_mmap_pgoff+0x10/0x10
> ? __fget_files+0x11e/0x1f0
> ksys_mmap_pgoff+0x1a9/0x2b0
> do_syscall_64+0x8c/0x170
> ? __up_write+0xec/0x2c0
> ? vm_mmap_pgoff+0x1df/0x280
> ? __pfx_vm_mmap_pgoff+0x10/0x10
> ? put_ctx+0x20/0x120
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> ? syscall_exit_to_user_mode+0xa2/0x2a0
> ? do_syscall_64+0x98/0x170
> ? __kasan_slab_alloc+0x2f/0x70
> ? rcu_is_watching+0x1c/0x50
> ? lockdep_init_map_type+0xcf/0x340
> ? __rwlock_init+0x80/0xa0
> ? file_f_owner_allocate+0x90/0xc0
> ? do_fcntl+0x484/0x9b0
> ? __pfx_do_fcntl+0x10/0x10
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> ? syscall_exit_to_user_mode+0xa2/0x2a0
> ? do_syscall_64+0x98/0x170
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> ? syscall_exit_to_user_mode+0xa2/0x2a0
> ? do_syscall_64+0x98/0x170
> ? do_user_addr_fault+0x3f6/0x790
> ? __rcu_read_unlock+0x65/0x90
> ? do_user_addr_fault+0x400/0x790
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f9dbc1c88a3
> Code: ef e8 d1 b4 ff ff eb e7 e8 3a 68 01 00 66 2e 0f 1f 84 00 00 00 00 0=
0 41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 25 c3 0f 1f 40 00 48 8b 05 29 05 0d 00 64 c7
> RSP: 002b:00007ffd7c31e008 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007ffd7c31e318 RCX: 00007f9dbc1c88a3
> RDX: 0000000000000003 RSI: 0000000000009000 RDI: 0000000000000000
> RBP: 00007ffd7c31e070 R08: 0000000000000004 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd7c31e328 R14: 000055886087cdd8 R15: 00007f9dbc2e7020
> </TASK>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
> BUG: kernel NULL pointer dereference, address: 0000000000000178
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 2 UID: 0 PID: 2618 Comm: record_mmap Tainted: G    B              6.=
13.0-rc1-00027-geca51ce01d49 #1
> Tainted: [B]=3DBAD_PAGE
> Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> RIP: 0010:perf_mmap_to_page+0x1b/0x150
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 5=
5 48 89 f5 53 48 89 fb 48 81 c7 78 01 00 00 e8 65 c4 17 00 <4c> 63 a3 78 01=
 00 00 45 85 e4 74 29 48 8d bb 70 01 00 00 e8 ad c5
> RSP: 0018:ffff8887ed2af400 EFLAGS: 00010282
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff81144e06
> RDX: fffffbfff0cf8609 RSI: 0000000000000008 RDI: ffffffff867c3040
> RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff0cf8608
> R10: ffffffff867c3047 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff8887eff9af70 R14: 00007f9dbc0b2000 R15: 0000000000000000
> FS:  00007f9dbc0c4740(0000) GS:ffff88874c700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000178 CR3: 00000001092a4004 CR4: 00000000003726f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> ? __die+0x1f/0x60
> ? page_fault_oops+0x8d/0xc0
> ? exc_page_fault+0x57/0xe0
> ? asm_exc_page_fault+0x22/0x30
> ? add_taint+0x26/0x90
> ? perf_mmap_to_page+0x1b/0x150
> perf_mmap+0x5cb/0xda0
> ? __init_rwsem+0xd4/0xf0
> __mmap_new_vma+0x1f9/0x5f0
> __mmap_region+0x52e/0x950
> ? __pfx___mmap_region+0x10/0x10
> ? lock_is_held_type+0x9a/0x110
> ? vm_unmapped_area+0x2b6/0x470
> ? lock_acquire+0x123/0x2e0
> ? mm_get_unmapped_area_vmflags+0x4d/0xa0
> mmap_region+0x136/0x170
> do_mmap+0x6a2/0x810
> ? __pfx_do_mmap+0x10/0x10
> ? down_write_killable+0x131/0x1d0
> ? __pfx_down_write_killable+0x10/0x10
> ? __fget_files+0x114/0x1f0
> vm_mmap_pgoff+0x184/0x280
> ? __pfx_vm_mmap_pgoff+0x10/0x10
> ? __fget_files+0x11e/0x1f0
> ksys_mmap_pgoff+0x1a9/0x2b0
> do_syscall_64+0x8c/0x170
> ? __up_write+0xec/0x2c0
> ? vm_mmap_pgoff+0x1df/0x280
> ? __pfx_vm_mmap_pgoff+0x10/0x10
> ? put_ctx+0x20/0x120
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> ? syscall_exit_to_user_mode+0xa2/0x2a0
> ? do_syscall_64+0x98/0x170
> ? __kasan_slab_alloc+0x2f/0x70
> ? rcu_is_watching+0x1c/0x50
> ? lockdep_init_map_type+0xcf/0x340
> ? __rwlock_init+0x80/0xa0
> ? file_f_owner_allocate+0x90/0xc0
> ? do_fcntl+0x484/0x9b0
> ? __pfx_do_fcntl+0x10/0x10
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> ? syscall_exit_to_user_mode+0xa2/0x2a0
> ? do_syscall_64+0x98/0x170
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> ? syscall_exit_to_user_mode+0xa2/0x2a0
> ? do_syscall_64+0x98/0x170
> ? do_user_addr_fault+0x3f6/0x790
> ? __rcu_read_unlock+0x65/0x90
> ? do_user_addr_fault+0x400/0x790
> ? mark_held_locks+0x24/0x90
> ? lockdep_hardirqs_on_prepare+0x131/0x200
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f9dbc1c88a3
> Code: ef e8 d1 b4 ff ff eb e7 e8 3a 68 01 00 66 2e 0f 1f 84 00 00 00 00 0=
0 41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 25 c3 0f 1f 40 00 48 8b 05 29 05 0d 00 64 c7
> RSP: 002b:00007ffd7c31e008 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007ffd7c31e318 RCX: 00007f9dbc1c88a3
> RDX: 0000000000000003 RSI: 0000000000009000 RDI: 0000000000000000
> RBP: 00007ffd7c31e070 R08: 0000000000000004 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd7c31e328 R14: 000055886087cdd8 R15: 00007f9dbc2e7020
> </TASK>
> Modules linked in: intel_rapl_msr intel_rapl_common btrfs snd_hda_codec_h=
dmi blake2b_generic x86_pkg_temp_thermal xor intel_powerclamp zstd_compress=
 coretemp raid6_pq libcrc32c snd_ctl_led snd_soc_avs snd_hda_codec_realtek =
snd_soc_hda_codec snd_hda_codec_generic snd_hda_ext_core snd_hda_scodec_com=
ponent kvm_intel snd_soc_core dell_pc platform_profile snd_compress sd_mod =
kvm snd_hda_intel dell_wmi snd_intel_dspcfg crct10dif_pclmul snd_intel_sdw_=
acpi crc32_pclmul sg i915 crc32c_intel dell_smbios snd_hda_codec ghash_clmu=
lni_intel snd_hda_core snd_hwdep snd_pcm mei_wdt rapl cec intel_cstate wmi_=
bmof drm_buddy rfkill sparse_keymap snd_timer ipmi_devintf dell_wmi_descrip=
tor dcdbas ipmi_msghandler snd i2c_i801 soundcore intel_uncore ttm i2c_smbu=
s pcspkr drm_display_helper ahci drm_kms_helper libahci intel_gtt mei_me ag=
pgart libata video intel_pmc_core mei intel_pch_thermal intel_vsec acpi_pad=
 wmi pmt_telemetry pmt_class binfmt_misc drm dm_mod ip_tables x_tables sch_=
fq_codel
> CR2: 0000000000000178
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:perf_mmap_to_page+0x1b/0x150
> Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 5=
5 48 89 f5 53 48 89 fb 48 81 c7 78 01 00 00 e8 65 c4 17 00 <4c> 63 a3 78 01=
 00 00 45 85 e4 74 29 48 8d bb 70 01 00 00 e8 ad c5
> RSP: 0018:ffff8887ed2af400 EFLAGS: 00010282
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff81144e06
> RDX: fffffbfff0cf8609 RSI: 0000000000000008 RDI: ffffffff867c3040
> RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff0cf8608
> R10: ffffffff867c3047 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff8887eff9af70 R14: 00007f9dbc0b2000 R15: 0000000000000000
> FS:  00007f9dbc0c4740(0000) GS:ffff88874c700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000178 CR3: 00000001092a4004 CR4: 00000000003726f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled
> No EFI environment detected.
> early console in extract_kernel
> input_data: 0x000000081bec62cc
> input_len: 0x000000000197949a
> output: 0x0000000816000000
> output_len: 0x00000000077a6d68
> kernel_total_size: 0x0000000006a30000
> needed_size: 0x0000000007800000
> trampoline_32bit: 0x0000000000000000
>
>
> KASLR disabled: 'nokaslr' on cmdline.
>
>

> ---
>
> #! /db/releases/20241203102937/lkp-src/jobs/perf-event-tests.yaml
> suite: perf-event-tests
> testcase: perf-event-tests
> category: functional
> perf-event-tests:
>   paranoid: not_paranoid_at_all
> job_origin: perf-event-tests.yaml
> arch: x86_64
>
> #! include/category/functional
> kmsg:
> heartbeat:
> meminfo:
>
> #! include/category/ALL
> sanity-check:
>
> #! programs/perf-event-tests/include
> initrds:
> - linux_headers
>
> #! queue options
> queue_cmdline_keys:
> - branch
> - commit
> queue: bisect
> testbox: lkp-skl-d05
> tbox_group: lkp-skl-d05
> branch: linux-next/master
> commit: eca51ce01d4956ab4b8f06bb55c031f4913fffcb
> job_file: "/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_=
at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.ya=
ml"
> id: b3ebf8d1df417274ccfd33ebd2b4bfc387b3ad80
> queuer_version: "/zday/lkp"
>
> #! hosts/lkp-skl-d05
> model: Skylake
> nr_cpu: 4
> memory: 32G
> nr_ssd_partitions: 1
> nr_hdd_partitions: 4
> hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
> ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
> rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
> brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
> need_kconfig_hw:
> - PTP_1588_CLOCK: "y"
> - E1000E: "y"
> - SATA_AHCI
> - DRM_I915
> ucode: '0xf0'
> rootfs: debian-12-x86_64-20240206.cgz
> kconfig: x86_64-rhel-9.4-bpf
> enqueue_time: 2024-12-07 16:30:01.185463319 +08:00
> compiler: gcc-12
> _rt: "/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/debian-12-=
x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55c0=
31f4913fffcb"
>
> #! schedule options
> user: lkp
> LKP_SERVER: internal-lkp-server
> scheduler_version: "/lkp/lkp/src"
> max_uptime: 1200
> initrd: "/osimage/debian/debian-12-x86_64-20240206.cgz"
> bootloader_append:
> - root=3D/dev/ram0
> - RESULT_ROOT=3D/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/=
debian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b=
8f06bb55c031f4913fffcb/0
> - BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f=
06bb55c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49
> - branch=3Dlinux-next/master
> - job=3D/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoid_at_=
all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.yaml
> - user=3Dlkp
> - ARCH=3Dx86_64
> - kconfig=3Dx86_64-rhel-9.4-bpf
> - commit=3Deca51ce01d4956ab4b8f06bb55c031f4913fffcb
> - intremap=3Dposted_msi
> - max_uptime=3D1200
> - LKP_SERVER=3Dinternal-lkp-server
> - nokaslr
> - selinux=3D0
> - debug
> - apic=3Ddebug
> - sysrq_always_enabled
> - rcupdate.rcu_cpu_stall_timeout=3D100
> - net.ifnames=3D0
> - printk.devkmsg=3Don
> - panic=3D-1
> - softlockup_panic=3D1
> - nmi_watchdog=3Dpanic
> - oops=3Dpanic
> - load_ramdisk=3D2
> - prompt_ramdisk=3D0
> - drbd.minor_count=3D8
> - systemd.log_level=3Derr
> - ignore_loglevel
> - console=3Dtty0
> - earlyprintk=3DttyS0,115200
> - console=3DttyS0,115200
> - vga=3Dnormal
> - rw
> modules_initrd: "/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b=
8f06bb55c031f4913fffcb/modules.cgz"
> linux_headers_initrd: "/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d49=
56ab4b8f06bb55c031f4913fffcb/linux-headers.cgz"
> bm_initrd: "/osimage/deps/debian-12-x86_64-20240206.cgz/lkp_20241102.cgz,=
/osimage/deps/debian-12-x86_64-20240206.cgz/rsync-rootfs_20241102.cgz,/osim=
age/deps/debian-12-x86_64-20240206.cgz/run-ipconfig_20241102.cgz,/osimage/d=
eps/debian-12-x86_64-20240206.cgz/perf-event-tests_20241102.cgz,/osimage/pk=
g/debian-12-x86_64-20240206.cgz/perf-event-tests-x86_64-a052241-1_20241102.=
cgz,/osimage/deps/debian-12-x86_64-20240206.cgz/hw_20241102.cgz"
> ucode_initrd: "/osimage/ucode/intel-ucode-20230906.cgz"
> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
> site: inn
>
> #! /db/releases/20241204090034/lkp-src/include/site/inn
> LKP_CGI_PORT: 80
> LKP_CIFS_PORT: 139
> oom-killer:
> watchdog:
> job_initrd: "/lkp/jobs/scheduled/lkp-skl-d05/perf-event-tests-not_paranoi=
d_at_all-debian-12-x86_64-20240206.cgz-eca51ce01d49-20241207-21354-b34j8-1.=
cgz"
> last_kernel: 6.13.0-rc1-00008-gf87326dedd3a
> acpi_rsdp: '0x000f05b0'
>
> #! user overrides
> kernel: "/pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f06bb55=
c031f4913fffcb/vmlinuz-6.13.0-rc1-00027-geca51ce01d49"
> result_root: "/result/perf-event-tests/not_paranoid_at_all/lkp-skl-d05/de=
bian-12-x86_64-20240206.cgz/x86_64-rhel-9.4-bpf/gcc-12/eca51ce01d4956ab4b8f=
06bb55c031f4913fffcb/0"
> dequeue_time: 2024-12-07 16:54:15.130226701 +08:00
> job_state: running
