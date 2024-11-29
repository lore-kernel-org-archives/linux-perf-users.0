Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D81A2554;
	Fri, 29 Nov 2024 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897715; cv=fail; b=t4ah5KubhEr0ulTlEu+/Ye1PvDLWr8MQrRTZUjFBNRchr6pUjS24wASxO+2RuL+aESwxQjT6X0xFwz6i0aPDPeG19FHwRxCIp5bwAESFmSjNcqjLOVWf2XT0lfUt3lLK9K5vGvQ/FcD+dv/AFf/Kohxyz1UVSJxfBSSrE+E7JbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897715; c=relaxed/simple;
	bh=OiraSRNLm0ysXsYOxDc+0fD0WIgESXpbOtHMbMJn90I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T2Z3tndr1uApk9dEF/ChmB7eJSimrRXIDQ69ELcZiR4NLj2uzpo2q16lvrIGkYfDv9vI3QlC6Dd3vDPR8eMfcM6pJNhq6mAHi2ElHNR+HExunh/rxMMNjLisAU/X+rBi2cF/LIPrEDRdILpRpybmwhO0VwQYxV2wb7Hsy/iWhqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G/NfkTE4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g+PE1m+Z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G/NfkTE4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g+PE1m+Z"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATEMbq2000874;
	Fri, 29 Nov 2024 16:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OiraSRNLm0ysXsYOxD
	c+0fD0WIgESXpbOtHMbMJn90I=; b=G/NfkTE4GjW/6AJyyPpAQw1arclQMDV37t
	NqKAgLdQvVFVYEQ2RvTOKg4+iIumGT8D2HTVBvv+XnYCWcTE/7DBW5KT9cKJcBa9
	4A7GOliwQW9/BEA3X9mq7y2o0rt40Ac7EEQ8thlWyVCWdDXycpmabI1dwOV0YZJA
	haDi+g/ceJ+9UC4Km6edbm12HyuEHdjBW6w7qaBqbyKdoor3+qcCiAmw35tcvHyv
	mY+tLDaR2EbEpEEdrtgE0fDhVFm7/PZbIgGDb5hOGcSMYMiSTS2QDCPXOBN2eh+Y
	AYoy6r5oX+pXGbQKDH/O6BA/H0v3a81d+HOzaWD1xxc9RsY/Q/6Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xybjnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 16:28:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATEuE6j014402;
	Fri, 29 Nov 2024 16:28:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436700u46c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 16:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqNLVKz8kU9ixV76fgVGSm12jDNhFESWfuV4/lzjgO/LJcoiX9lhIK3nD72FSz7+Xwgu1u5I0KEvTB6KXeLa3Ij5Cj+/NRwxTUOiXP2wRgsrzemSofpxagOAocOZEmm4J6NCcVo5Uj7AqB1sVKQweiYuzkWqOYSEKoQVcjyS2NlJ4D4JrPpH3i4k0SUOpKRgjPIaRM3Ro8sd/xheNbGQzopCvcd9iGznq9fi6k9ISbiISNDGybJHEVquMlWE6F0fRIHlTnBH3cEWOvE/hagaObUI67Xgs0umpneDgMpHT5ikZXpui+KYji0Dfs8FfKOGhkWhAzGd+5U81SdT7m+RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiraSRNLm0ysXsYOxDc+0fD0WIgESXpbOtHMbMJn90I=;
 b=ft6RNU26xO8TLoh1BKXbwZDIlQIUj6q3kBEniHRhX1wr6t0NFz0j/q10TjX3Qc+hjPp5r7xluR/SLJBpDhWRb8mQqxOSrIY4udgbJAw8S2F1FB1wXStffufKU+YivMLe5G9GjVZm6dxCZ/s6kb75OpWJUo19ha1ADDkZz3zVUI8Nu+NBu1d/0xZYhySb5SLbO+BVoVdZfYKuDy0cVIFxLT35A1n4hcKVqIclLW2Qek0KujvIwULfJ39BvvwXoVBX2KFyKjpcHn3eOvhYG6ySfJlpIEldq4oTU1wlSHAeZrXLM/tjYM4O46D0yUMN3ulSNs47Zj+Bq6zzbSWI8HXWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiraSRNLm0ysXsYOxDc+0fD0WIgESXpbOtHMbMJn90I=;
 b=g+PE1m+Zwd47UDwxZyVGarM5RCyAuCB3TiOwTu7LnsKZLhmJs5MOHtY6dpKsTfm5m8++Bvj5kD9LWpG/35r/eeMt1dlgsNingMhZXp5A/pNflX4Re0pWbJHBbE7+p0qc0WbRJoFCClCP4vdZV3vT/GgT5oX2Qqh4NeYkWi2ATZ0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7705.namprd10.prod.outlook.com (2603:10b6:a03:57b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 16:27:53 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 16:27:53 +0000
Date: Fri, 29 Nov 2024 16:27:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] perf: map pages in advance
Message-ID: <d6829f2c-1517-4ac4-a907-d6dc88f2cc44@lucifer.local>
References: <20241129153134.82755-1-lorenzo.stoakes@oracle.com>
 <Z0nl4B_71PP-yf4m@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0nl4B_71PP-yf4m@casper.infradead.org>
X-ClientProxiedBy: LO4P265CA0139.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a1993f-77ea-4407-7a45-08dd1092c62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpQkhf0mKqy64vIeu3gDCzjJC1Vl1csiPMT3ifVzIELDQqfNscpCkCIp6Nbr?=
 =?us-ascii?Q?VbC++sbRm3YfgS3PrRwnAPlEhbANt0wneZp8hkRTOXwP+q5SagklOvI0aIeH?=
 =?us-ascii?Q?zEf9hp293/HgOcAVf99rzPwXAPdYNTSpFeeHGIYMCmxz61nYjwElsV8c3T5d?=
 =?us-ascii?Q?Uge3s72tK7ZJMvjJf8HuC2bQ2DPD49FjAFuhef/OKESTzdqPwUr6oA9H1yg6?=
 =?us-ascii?Q?D9QBG4mwnqlr2Ro6N2oBDMHvCO0jQVCsPQUp20gsZyqyuZ7xsOSMEvoxLZoo?=
 =?us-ascii?Q?FEQgL2oRE0OKYYtLMGu2R7JFnOWo7TvPIXdlB2HPZLtOT+vGlLn4BKhXcNG3?=
 =?us-ascii?Q?I3RJp1AKjhdY9XRufQRqTJMu/sbLm7KELztwTIv/pJn9beVydgLkY6ZuAtHz?=
 =?us-ascii?Q?y8l2+7o6iV0jNt3flY4uFn23bFaU+ApuFVa/OS3hf6zD+6G0f1X0Q+6/TXb7?=
 =?us-ascii?Q?NCaKrCBllQQBECEtn/Tmdn6Wu3H7Mmol55kQlfffL+3nEm2mn7Zh4kq1t8Ny?=
 =?us-ascii?Q?dhJClaO9rhyJfwsugMX8WRTJ5VraGlL/cPiAWl/NYpyCgGm4wIdly2+LVRK7?=
 =?us-ascii?Q?cwi2z0m6eC3kT8SN+ccDxRwVWmsTtIXrj4z7CcrhEJFS+bwzWMHanK3bH2HB?=
 =?us-ascii?Q?a9Mc+L3uJw9CiCt3XczpV5B2bH7G/TKMUGZWYdca8QdMmMqHOr1eoT4iZBKV?=
 =?us-ascii?Q?RkSSuMjZSHXbfbBD57Ox5TYuAsm9ETqEB/3GgkQWi9zHcKRztEK+9uuGcAc4?=
 =?us-ascii?Q?PBaoHf2XZDaEvIJHDp4xvTLe0yIQDyxt/5RA1gCtJJNaakOWOjMR/hikaVCG?=
 =?us-ascii?Q?aMSl9I/iuFhGnSGfGzwua86JDixLbG2wFWzDo4S3bOGrY9DWNRNrAmZYQp+w?=
 =?us-ascii?Q?Ig+99f8Ivvl8zMZFyFHubkigTxupx/yO3/9GqWHM4Ot+/eGGu+zWLgOxRgUs?=
 =?us-ascii?Q?OYU+GP7K6mDWx2otiOBK3V6Afc7jQBbuTnItEqtyk5AhU2CyQDBKmw3jBgHT?=
 =?us-ascii?Q?VJ9CRvbkl0S8Hm2EUOhSS9jdvjLC3QUmrRi2KXkt2cwcgQ8bHBWE9PSZwt5v?=
 =?us-ascii?Q?0NEs1e6i4CEl9AE81XNGL68Z5Smj3CggOvOHCcLmneDdiRjQbYqr074kWWyz?=
 =?us-ascii?Q?/AvokJk7WIsC9WU1LGj4sb8H6DjnXhhogacsvm6D06bivNKXun5EtwuUUx0q?=
 =?us-ascii?Q?Ys7zpcfLVxxkYRFLDab4Vv91Cdxfb7CiZrRe3nJu4/J1TN3GxNOCDuIcKiax?=
 =?us-ascii?Q?USq0bGVIHf7dt5uvEBEt+LLDnNSk3wBJQ49wooKLX56b5KiRlC4zDDsDTWOb?=
 =?us-ascii?Q?amIrgS/6ejdes1hTu+aG5JSrULeyV2z4p23b+I2iHQfI2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pGanYQz8gYPy44uz0m9M6YLQ+rUqGeMhnozitvtionaDLgdVGg53MmuaJ9GJ?=
 =?us-ascii?Q?HxiFOoYFrdqZyx1VHDZQMb+ciIre2l2TdwBJ/kuATrBbKo5XxVB9N5lnGuqG?=
 =?us-ascii?Q?HzBMwJPtUVoKzg4jLwZv6Hs863nyrk3PfraszsH9bQzo3tN61i3cYBi+JBlw?=
 =?us-ascii?Q?7sPa943JmS4xa8GjjxM1ymgi0Jueixm11FYqofBZdIUimKMf73VOjmQH9XKM?=
 =?us-ascii?Q?HplPV+h5NDc5QLWcjaZqtsEaCcIXVpbaxb7gCPPF0WU3GxRsZHoRV+j8ZQw6?=
 =?us-ascii?Q?8QVUNBCMeJdieJY8U+7PgA3PWr50xk3l+M1Vb4ajl9K0vuibrlfpM7iTvWCA?=
 =?us-ascii?Q?smB7UUoATh+uZMPCf5cWdW/TM8Q+Awi7L/p1rmBJKP4uhp+bxWv9LFcqEH+1?=
 =?us-ascii?Q?fYF0Nji/iu1IfOy4d7DMle+sRNXH93qC1fQchDs7fm4IotAk+TqMY9ZZe69A?=
 =?us-ascii?Q?GJecuDOx5qgER/49api2uy7WB5pOZ2DPsDFDeXq2GVKrlev+HaPiIyw7/1gf?=
 =?us-ascii?Q?I2cdwoc3g/LN7u5VzdhA2gXOTFisunHUOpDtP5+7YdKFULOafc36R/E6DfEP?=
 =?us-ascii?Q?gNnEI3Vf0LMASs/u2WjmBsMS+xcbo/PftgTBF6EnuTfifikG48u1gNYcS0Pk?=
 =?us-ascii?Q?NvTTUtwTVRTOFsnIP/Dkl7/w9/Z6hONnmMXQKiMCPlGfrnmdfMJ2C+PKNmpk?=
 =?us-ascii?Q?uL+rOuPmxCY02gFtJq+ZcHWN/UXW3Xa8EsTPvRdLIQ6KSB1AS1nhxPdjozvO?=
 =?us-ascii?Q?sjU5XY2Rr+klDSEVL9YTaOb3Mj4X6f7ppthlRdf/asWa8vOgg57YpT0cy/hc?=
 =?us-ascii?Q?Nu+4G2ehGYMN5T8bT3OmRKBV+CEzk3as4NlH9VfqcWI7dJcwVg1o97YvqYO5?=
 =?us-ascii?Q?1GNggG1EvnZQ9zgn13EQSXNT6ejeoW781nNy+tgBO5zp7AW4hVUKSg/EyVa3?=
 =?us-ascii?Q?Wk5PP1si2dArHSZUFDVTuvhCg4erOck1dpBqOWapz18A+DGKjbf+WpkD2JST?=
 =?us-ascii?Q?4XJi3+wL7wcsu1+rdLkczt1FrMucKRpNdU0F70wuTEa4k3PhR+2r9q0NjRNX?=
 =?us-ascii?Q?sp8cFwNbVNaIYhCpZtRlhGO+PZF5RVyZV7itUjPb0XS3Nt5dV0PgBnHkwo7a?=
 =?us-ascii?Q?r+Svvmq9XYyRzpvD+Ga+38ymyDg839TONJQreWzZI7VwBVOxV0rKnfPTLHZt?=
 =?us-ascii?Q?DYMmHQaN02QtkjwGezRGloIm9Ms/GlaADWLVsyYSsp1DONMl6TUzrnezTioV?=
 =?us-ascii?Q?YBYJUF1buWXq9iVp227Fybt5l/LcS/ru+GVjRwU3NhoBUn6ADFHR+RyNT5ZG?=
 =?us-ascii?Q?erNoQJRhyMOj0BpNVxiZmPUAzfaw0LPQU1Rfxk2xNoZvPYaAfgr8in9YR/t0?=
 =?us-ascii?Q?MhpjKuyvstSujOlT2IObd5UL22WzisC7qFmm9QMR+jpIQHftsWI4fSW2OoJ7?=
 =?us-ascii?Q?ZliI8uznSnRI2oKNSRoSR+FUvjQvEcaDS3DM9cwQspD+8rzn7lIeKOPbzgfl?=
 =?us-ascii?Q?4Vj5JOyaSjvzSuPdNcTQBf1zEiwDEBibU2/ffU2SwZTyYz+sqwCZY+oT9EKp?=
 =?us-ascii?Q?1y96ypCe1KFRDYfUe3GCa7QE5Q42QVfxNaBDvu29MJFzLpLbAWPFct/u+Isj?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fF6wFK0C0GZ1gRoZA6pby6x1/GEARPS4OsUxPrplkHwmjBJ37jERyS0bqPjiVRn9xU9dL4K520vkC4gYIjfY+LKseMU7J/O0iWtSj5j3UJU5g5pQtf41Y+SHEAjx7XVPIMfw5emFHQoAC3gUQt9SYQW6lfvXRDpUZx3IPfMDuvtXqxvHnOtSGtRmsftMCsxLs+C2O8yELxmk9p8LMsqp1fXzOYRhj2nqNZk5Ri6YxLUM8wAp/89UeKlHkd5+bdk/6x6GjlikRFz/qtNKJMhybwrpMIb87/d6Bsl+BeEQwnLvjvQRM8q3cbyTmnUFhde5UksNAHIUxh7dRpVjTcm+EX36kGFMoWGk0QIX7G/gsTjenCd6CVwxN/Oz9v+UAK8eQKtqftlK9tCvVck1/gl0LrkUYJhdPSjlI2GbMsCJTLTcsVJBqNrLu1Ou4Qy+/YQXXzwVVQDPBAf4SWfAgTxTnwqJcYViEHegdikDGz/04dE5T/s5t0W7dwPDUIdwpyIXErIZQJDx3vXRmj2khtzV3wZlkhPddbDkrhIddNmiyneQowc6l39VExd1x+QqeeqpDSGVr9+9Y0kuHWLszU8J1TC9ZBl+KNHOuSDx6ytJXfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a1993f-77ea-4407-7a45-08dd1092c62c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 16:27:53.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHc0qVUSCtss+mG7XJMoy6wG1k+tCe+n5FfNVd5k87Z+b43yByKbzoQe7O0jskLrymQZ9QJ/efOuEv5BYCFyWCZu8LCsdM2gp079+8EH+RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_14,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=715
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290133
X-Proofpoint-ORIG-GUID: 7-kTZf7PkYzW2BaGJWymj4OJ6UZtGdFa
X-Proofpoint-GUID: 7-kTZf7PkYzW2BaGJWymj4OJ6UZtGdFa

On Fri, Nov 29, 2024 at 04:03:44PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 29, 2024 at 03:31:34PM +0000, Lorenzo Stoakes wrote:
> > While it is not ideal to use a VM_PFNMAP here, doing anything else will
> > result in the page_mkwrite() hook need to be provided, which requires the
> > same page->mapping hack this patch seeks to undo.
>
> Or we could map the first page read-write to begin with ... ?

This would sort of be a rejig, as then you'd just make pfn_mkwrite() always fail
and be doing essentially the same thing, only varying what prot you set on map
(you can't just set the other pages read-only in prot and not provide
pfn_mkwrite(), if you do the kernel will simply make them writable on write
fault in wp_page_reuse() :)

> Or we could implement a page_mkwrite handler, but do the permissions
> change in the driver and return VM_FAULT_NOPAGE.

Yeah interesting, that's possible, but wouldn't we need to be careful about TLB
etc. in that case since the mapping will have already been established?

I suppose we could zap then set, but that's icky...

Even if you don't pre-map this will be the case as it faults in first before
invoking page_mkwrite()...

>
> I don't think we should do the second option in this driver, but
> mentioning it because we're going to need to have A Talk about fb_defio.
>

Yes I think we're good with the current solution for perf, despite its warty
nature it works (TM).

I fear that this Talk may involve much gnashing of teeth...
