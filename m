Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73286327;
	Tue, 10 Dec 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852087; cv=fail; b=S4F3wvzYuuh4IewBtfJ4GCIF50nbI0zyUWzuFlHHKpOUB6Lps7NEPic4T14Ho5HU7zGXwaYOg95CKDrMAkvyM7NBbMWQNgPXYLihAriFsq+k1Pg73C9dLgw1HHkTbFIXOaYbNwt+o3umvZq2o0NiOW2MObsXnX16wD1QOcXMssI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852087; c=relaxed/simple;
	bh=6AemA04u/yz32hMeD/edUl03qGfaf1JdD0iUFryK6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MmmTSrxfh6ULYrD8WGcf5Ng7fXUH5gRCmqiHLZj8ElDiAZ8d0N93iYJEq2SEsdF1/7WL1swTmNcY6Al5jrpaUAy6aqtrA/Z2simuUmfsgMmgGxKkXy2eBn5vpn5rOfnHON3IdpEWPOhhiZlAQiNASojxmmeTbtXlU61E4M4+CZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EcvtiuDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ienRFVOE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EcvtiuDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ienRFVOE"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAGQnJv028774;
	Tue, 10 Dec 2024 17:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wyiC4unrxMwKmBNRHo
	of0m3DfFtKKPKfbIY48cwGjRM=; b=EcvtiuDUSIeXs8YhLnfMuExe+/JlK+OPJ/
	TaziD1/HQLcyYEy1d5WVnmjsXMLPRuLEI+X2Vp0NkAjNOowtwY9e/8JszkAItptI
	FNZZwOoE4X6m+wqt+CeOf6cnw0p5z7zPxaSyEPe9aab7OZvAlmZdZWTMuRY3CeHv
	vj6dfpgWvJfVZa9GdJcPob1TO+r4nvP7yKdB3Ztih4DHjc4oPvL7jI9QalvhPmfU
	coz9v5FEMgbrzAKzgwkzIrVelE27womhBtpp8F1JrXtPm578fhQ6z34sTLo4ZZz2
	cu/hc/cYYd2Y/Lxqgv7D1T052DEDmGdU1hgcONoQy7zKHg8KZUcQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdysxb4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 17:34:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAH5JSa034953;
	Tue, 10 Dec 2024 17:34:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctg42gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 17:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYA0XMs+wXG5NZzvnbMSANoSdkntHOENmPH2aJNqkpot26PVRLFwO/EFqPvT77goWaGvg3ALDu6CKPvMXwmIzqMqt69oB8rKwax2HeMD2LlQ4O2NUKoR+yhp2L6jyLUVpDVOpPttINeM4KREnk8w0es7ulfk5C+uiTl++x6KiWyxRmtEO/thYKs6J+poHVOMxFf2kRx/V7AxbznSUA9RYZJYlOhm52UKWGJBeb5Sq90JEFtwaCcFaHbsorvFXofmkbR0fupffnMLx/QseVKzcab6pgO+e7DJPe/1C0Z30I13VpVNOEdtLEl3JIVe2waK88IbdTHpd9jzxX8/WsN6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyiC4unrxMwKmBNRHoof0m3DfFtKKPKfbIY48cwGjRM=;
 b=qIuATcZnNPuCwo8acSXzbu8hMJtfRqfa15mGMCWcgoBOdP6vJ7EjscC5wRlzF924bn2qLpH4C4AKFa3DhEizZqus69ivALpx0ntZKci74maBNEO++m9BEvmk7A/+WqhS2SKqsjSiksHx+qYxP29Or5kwn+5K7wyfMruZZG9+kZ6i5TtzwGxPyKTCK18yKtKiZh+OTKMvPYvxbQccX9r3p4VUzAa7pqfBG4kKznE5GatT6L3pVsw4Urv0H3O7QNb6ikFut/x4WMMn9SCi0Y4dvkoeEIZWNZ7rLXeoJrLrRdnFz6UE3DS4ayx14TpW5zC2gpJiEfmZM/qcwTM2ThAWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyiC4unrxMwKmBNRHoof0m3DfFtKKPKfbIY48cwGjRM=;
 b=ienRFVOEM7pOCf7UfVOsyQ30py+Ej32S++uij+9j6KxAfdX6U8zXTGmKGZp3gVLr957L5NjP9klhe6ZWAcwilorqFup2iF9TERFfXrCixbkSBYqgP2IeFayQ5bTrGr7W14CexkLar1vpKHP7Ct2dgxTmfehameYMUQ15/mlkXgk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB6860.namprd10.prod.outlook.com (2603:10b6:610:14d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 17:34:06 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 17:34:06 +0000
Date: Tue, 10 Dec 2024 17:34:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
        linux-mm@kvack.org, Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] fork: avoid inappropriate uprobe access to invalid mm
Message-ID: <c5ddb4b5-5e91-4434-8f42-4709433032a1@lucifer.local>
References: <20241210163104.55181-1-lorenzo.stoakes@oracle.com>
 <20241210165334.GB31266@redhat.com>
 <20241210172315.GC31266@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210172315.GC31266@redhat.com>
X-ClientProxiedBy: LNXP265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::28) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4329a0e0-f06a-4577-1a4b-08dd1940d889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vaqo8cfGu2FugM1sYP+ZLe3iterIMr/MNf1kq21eiZRuyzG7nBvHMpFZsSD2?=
 =?us-ascii?Q?gEAmDsWOTUQat8VwJNbK2lek6Ye74DZ0uTWoY3t7BJa9hcbLuK7ph8bIz/42?=
 =?us-ascii?Q?d78n8LqQzWkgfmVNkZUZgsCb29ZYtooLbH2ov8noJeudaweDOWMKTuTwRS0j?=
 =?us-ascii?Q?LClr8VdCdT9Cn6gUBAtwcbfSDkmkQoZ+1rBl5PluzRCCflDqBas5wGddbIxw?=
 =?us-ascii?Q?vjQi4qsqLGXii7WPUCWD7gQB5ZphdrHRt3bOdewXlJXn0Gpy2+r+82mGJBIF?=
 =?us-ascii?Q?wUfwpaR9f2BnNqihyg+L6UMerGxg9BzdiivO4hgreJRVXJBEgQywSi+83mPd?=
 =?us-ascii?Q?7hHPQ6DC4f3s5fECI8owmNvikNQsWl6AlEIPl8x9lWm5Qjop7327eI9OcpuC?=
 =?us-ascii?Q?NhXEPDRjpWjlfoeytdZnpaAZhk/ooWGZ6X6CZaJUXNMtwmFvW9TJUHQxstF8?=
 =?us-ascii?Q?Vas5ANRYVmcHlKqbEAt/u4R1oGhNd506pNn233TjIzDvszuPNdLe7Qyfh8MI?=
 =?us-ascii?Q?LtXwZ7cYEE49p+haeR6ZK+6UiYJ+iHRdPFuVf2JBsZj/wRf+g7MHE8DCNCpM?=
 =?us-ascii?Q?QUMy6UAS05l5zV9R7Jq47XU+6zcan08WP+ng2eWQpowhPVuprbrFd79pK7Nc?=
 =?us-ascii?Q?gMjKgdwB/QrKtnOQByLsSZHS3ln8xSeSrvfahQbgVocUmeMh/NoJ//zTg9eb?=
 =?us-ascii?Q?vU5E1D8lFJD2Dabmoewm+TSiS4VNUPxjPkn0xP6ku3qbIT7/Ecd4WP+O3Ne/?=
 =?us-ascii?Q?teX56OxAO0Y6XoUu8vDKfySBDYafLwqdHIjCTku7FrzCR8x2EEUCWaO1z18x?=
 =?us-ascii?Q?7Vj6NJv0TNONMAgfMiG9l9DloQUknGScu7uz5Qth7SPkSNST/hXk7ULGm9z1?=
 =?us-ascii?Q?gfgxEQhCDMRvHsxxGhljTgu48XoKBGJrJl04qBB3JZKUtclgaZqrBVRSz7uU?=
 =?us-ascii?Q?GBptU/xxWNxxlVs0oPaY9XPIa5o3qaOeXsorca5BfDhEdXHA7Ik9vQkH+qhI?=
 =?us-ascii?Q?bnNTd2gZ+xlpaJna4Hm161rFaLFurheG8D7oqlqb+rjqbF9xeLQ83xsEfcIq?=
 =?us-ascii?Q?5R5Pn1oEH+rK0rbF0goFCJabwuBlS/0WP5ydb9x1Nd8kd86wIz9U0fnD2jyI?=
 =?us-ascii?Q?Hk4w4ErZQAw7Hb8zwCmnqM402BSCWq8TtM7+9wW8n2R0Bm9k/hqH5gXFkgRQ?=
 =?us-ascii?Q?xm7Hko2gUx5fvwV7IKcCLHzuiFD2F3BJ7d8lxQ37HfvytwRMxSmLtRri3AWT?=
 =?us-ascii?Q?S32q6ELCMlJQz0P343YXig2ix/0ecwWX/eeY1Cynt9Gi1rDPiqd4j7ztS0fg?=
 =?us-ascii?Q?qI3a4+6rO81WB4F9Y6aCFUVRd/LG1TVpB7e69fQCaNr2Xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nGdoJA4wfizYn0d3RcFJ1LO/2O0BSD1y6uehkTOcjX9hryfgrVU/sJKvmL5?=
 =?us-ascii?Q?4wbRjCcZjkyDgjpZ7G/s0DnFsujIzMbGyl8S3FQNyaM89yc2HVzHAfW9TJQH?=
 =?us-ascii?Q?oyBb2hm+UJa+49X4+WMAw8j3bIcys7A8mIHtCugLXhNgfdiRiiLIUeVE3nSV?=
 =?us-ascii?Q?4YRa4mtEvW+DivGI2kWCYHEjUCBGaUpB3S9nhyNq/ZBCl3mQE9ND0RikStGp?=
 =?us-ascii?Q?0UlelMguSErEvpIFSFDuA4+BuMoPNrsJADsAuEaES4l5C/B3y/adNtm6wOw3?=
 =?us-ascii?Q?HTwxIKm4MYDFSgP26AXD42FNSakg+IFA9un3IavZ8sPN0bUd3A5ZUIOLZV/G?=
 =?us-ascii?Q?2udL1vtk25fhGEvlSoXKBJdRhI08+ChcINQlbrRPviLoSVpl3HhEvFafHGIW?=
 =?us-ascii?Q?uNJ/gshLVxXMClWNFMonPZ5y8V0TNOAIBh+5Yzvs8cvZ/TDOhtZkS9YKY1RQ?=
 =?us-ascii?Q?BY6qhz+j65euNApA7/hOrFkNSFfNjW7X5g+jwiDsOox6IbiNNYWA0A9Li7q/?=
 =?us-ascii?Q?T3TJNG4iGMmY19F/bNUjZZv9IiurbPox70WZ8OzAwk0JCuHKKnZj8UhJpbEH?=
 =?us-ascii?Q?iNzueAwD+s4FTKWsnVV6PYlvPV/DJquVIUNd6RvEVwD+M+PKF31xwufA6uR/?=
 =?us-ascii?Q?1612g0Xcir+gWbVZZKBzMtmjr6PsQYK8pEWhVKWP5BQDH2empLTu+Y6LYYPq?=
 =?us-ascii?Q?FoqqRn3Deib10TNq5V2eWRRZ+6OPxXTDNou6BetbK7N6XLw5nWlxp/R/1SCw?=
 =?us-ascii?Q?VSsT1Ma2vvU1K8ugLQZ37Dl9lf0803cp9x0rkX7BiWyAIJoozjevfYJmcuUo?=
 =?us-ascii?Q?3mJjZMh1u9l9gitDi23O7l2NkEkhgoMNzkhHYBImFed0cvheRWYfjqEAhyVh?=
 =?us-ascii?Q?uiL1ZGanAwJ3FGXlxxllVx7scaertYcNAmIlJNDPqZy2QlxstT/RU4v2Fo+o?=
 =?us-ascii?Q?CZ/2nkypqxV5xmy/MNuf6R03b1+dRjFGEB8yDRY8O9I1+zx/V+vJCc88WWcO?=
 =?us-ascii?Q?1zZ7U0m1+ndcsomHuCHDwxoNMnk/0T1UPx8ZnHt++YuCHE3a9Cii1yVUIZKL?=
 =?us-ascii?Q?wz4c0V0rpO8nPoqwF6KGRzJKFfmwgiLmlCmcBKyy32CSmt8ND7sqt8p6Ysg8?=
 =?us-ascii?Q?jozQvLnTZyhWonYMJU5IFNm7m/z7k553Sbr2gX832kH8TUFq8JhtPkUG3h5/?=
 =?us-ascii?Q?2GkMKramLLtN0B6yVMsxekUTZDnLY207aVC7AT2dbCI9g3o9l6zvjVJZmDcH?=
 =?us-ascii?Q?Ly2C5G6udhTbBMEIyRQMNCJsl19nTVngTsKfea0ZPm7RLIa/wkfoqeGh3ACq?=
 =?us-ascii?Q?M4c8rPJm7qs+2m93/oiDy6Ti50dyHt284k9JXC6pTqXoLcfni1NmhqoMC0It?=
 =?us-ascii?Q?qXmo7W9FYx/K3rcTG4UkNYsL/OHpERLvC7e3+pC4vARmS5wrdQHqLYOsJgr+?=
 =?us-ascii?Q?qF3V5MLQiRkr2N+ubjQQkyY5CqT7dCqEaZPrdHOwtYyIPcVqI+v9kgsiAagT?=
 =?us-ascii?Q?5MdswhVedcS1MlvtZx1f9z9RG65xByZ0WdALxpsgzN3tO9yBJpoBEavy1mkr?=
 =?us-ascii?Q?OBMN/9UwDY0JCeE/8PqIhi4H3oixUh3694ecwaAq/iXvM14a1rWRZPPurf9J?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2JyQd4KG/sxeehhiQvEr7jU2lQiMwl3HwyRFLYFt8pRPtooNwZ2FJz+SMvXYS85AZFRmEH9ujzbK7uPdxGscgun8E/gdoob1WcxjRMRccJyFQse1YsAUHas/rqK335MdsMACFfcDRWtbc7uulYgsblqE9WPS4EadJo3lpXRORRWXx297E/Pd+lSvkC1Jh9nrnqWIc4XfDAuqCV952tdn/KO126fNQk7o3xqiS+0lW0hze8l/u1EjPqoEk7Fbw489UBaKJ1daTs5dSf2He4YtLaHGKVIgoUypjVexUsL35AOKEBkD4/ub+vbOfZHtuhFboEfG4nQ4GJ1KY5kYJMbkQ54gKr0pPtR0FScvvuSLb4r7TMrb1iTNTKnu6WbSmZ381IgJvywAcXKZOqtjLmn6EjD1usIZizQ8Zu1w4aDYz9hpJAHPQXNUxjgVdgQB02zDXhU7KjeAgrISqp3C99qEkTdyF3thvEbcJDuqsEb2+V3B0iHAqNJ0FE+8Bbmn447MxwCkBJAkXL7T6Hj7I18RnW0qxJeY7pim4hROQMzL4Y24rhpQ08IIlxvIupbKnE+Cx/C8XqwJqgXHE5c/TTJ4R6MEKiFHaFuSKq5cOX66LQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4329a0e0-f06a-4577-1a4b-08dd1940d889
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:34:06.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNhhsVgjPJFjKd+qyf8532VpTd1vKgkMQkkWjXSlo1woa/l/aMVRTVA0wo+NB7st3Q0zcNQ7JOB8TvpOhTynhDF64NxFsnVNSaIBGJgeJDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_10,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412100130
X-Proofpoint-ORIG-GUID: OdBq8uxpal_uOvoHRlaIwaG7Eh5rkiKw
X-Proofpoint-GUID: OdBq8uxpal_uOvoHRlaIwaG7Eh5rkiKw

On Tue, Dec 10, 2024 at 06:23:19PM +0100, Oleg Nesterov wrote:
> On 12/10, Oleg Nesterov wrote:
> >
> > I must have missed something, but...
> >
> > On 12/10, Lorenzo Stoakes wrote:
> > >
> > > @@ -1746,9 +1741,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> > >  	if (!mm_init(mm, tsk, mm->user_ns))
> > >  		goto fail_nomem;
> > >
> > > +	uprobe_start_dup_mmap();
> > >  	err = dup_mmap(mm, oldmm);
> > >  	if (err)
> > > -		goto free_pt;
> > > +		goto free_pt_end_uprobe;
> > > +	uprobe_end_dup_mmap();
> > >
> > >  	mm->hiwater_rss = get_mm_rss(mm);
> > >  	mm->hiwater_vm = mm->total_vm;
> > > @@ -1758,6 +1755,8 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
> > >
> > >  	return mm;
> > >
> > > +free_pt_end_uprobe:
> > > +	uprobe_end_dup_mmap();
> >
> > if dup_mmap() fails and "mm" is incomplete, then with this version dup_mmap_sem
> > is dropped before __mmput/exit_mmap/etc. How can this help?
>
> Easy to fix, but what ensures that another mmget(mm) is not possible until
> dup_mm() calls mmput() and drops dup_mmap_sem? Sorry, my understanding of mm/
> is very limited...

Yeah that's a really good point - it's not impossible, though
unlikely. This lives alongside the 'what if the rmap provides access to
something else' consideration.

I believe Liam's going to look into something more solid on the maple tree
side.

So this change doesn't purport to entirely shut down all possible routes to
this issue arising but rather is a very small and direct way of addressing
the proximal case.

The thing with this situation is that its borderline impossible to happen
in practice, so we should probably be cautious about going out of our way
to preclude it if it involves too much chnage.

Somehow marking the mm as 'don't touch' would be good, but then we'd have
to audit every single corner of the kernel that touches it to be really
sure that works, and we don't have any MMF_xxx bits left to play with
really. MMF_UNSTABLE does seem suited but could it somehow interact with
oomk in some broken way...?

Not sure the RoI on that is good.

Probably the better thing to do here is to attack the XA_ZERO_ENTRY stuff
from the maple tree side - see if we can't audit/rule out inappropriate
access to these (perhaps adding filters in the vma_xxx(0 helpers?) which
elimniates this particular issue from this side.

But I think this patch as-is is relatively low risk to scoop up the most
likely version of the nearly-impossible thing :)

>
> Oleg.
>
