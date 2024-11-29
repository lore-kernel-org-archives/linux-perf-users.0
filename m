Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6271991AA;
	Fri, 29 Nov 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886385; cv=fail; b=jks+a8UoBRg71RAkg95Ni0FHmz8n18C+qqXBd4nNedSjbOtahziHfXqFYgt+VSsLF0DUGqFaxq9EBbkfhIKt72B79wiAi4N3PuwGi5exzpCiMg85Xb+VLAmAm3vo91KKsD4aMNAWabYD5diEBVRYPWX4izm2ejRAnXnzCHf9n38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886385; c=relaxed/simple;
	bh=ZhFfgGqnp0Q0Iqbz+C7w9wLAo6ufIOXkq1eKB+dzbe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECK75l/SLuczN5Mp0DIUvqp/48UGs6A8A3xB5MjdKz0ib9p0FyXU8rCDOXMKztAps8BYMFNWMaMQNb3JTiyo3OQQknCI+r1rVwTVLjvetwqtOUM9Pq86U03VOzHDuIudDm+f2Bf6tec8sp/pWP1pQTny0Ou+3gwgvzNZRrQxoQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JaNnFIpc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bzwifBot; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JaNnFIpc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bzwifBot"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fZ5J017024;
	Fri, 29 Nov 2024 13:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hBGxN6qyB/z9uhdD9w
	LuuLN4iqw9m/LVOSiht6KRF7g=; b=JaNnFIpcN7oOS9Rcumh4hUc2YIUFRHUBpu
	hM/U1Rb2KJf7e5Usdt1Xav7eXABFirPRBBk4GX73cUhMregPGpeS4RcJT74QHzg0
	FyHfm7ZMQGQcRRJ8c1E3C7z38qO3v2+c/tVO5E+yVMCrssShqdYSihaLlQ2KL9MC
	Efg6fma2U7X7/ZrbrZMC/VwCCGfi+yHqEFqA6qzkfiaMkCPIPbN2luLfI2PyZqLg
	Sxm0EACs4FdvY2HuNk1dfH7onSZVu4YBtcsmqIwQ/Ssdl4nAAZDLubapQRINES5D
	Vr+jt3Bzi8wNR5cfDR7Sh5f0vxpOuZ0p7Piv4zJYIKBWDDFiDJMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xx3b35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:19:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATC1B17001332;
	Fri, 29 Nov 2024 13:19:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436701e01s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 13:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmZZdK402jiTzGRqvY9pqwylfx3pwSknAd7103aKPzMocnYNsbfd1Ehb3bP//knrkaa2BDM0a9+DMddsDkayMQROhR0waD3xU/6O3z0aiGygW83SxSmirBmas5UxUkfoG+rVQvD9NE73PS+LeB4+7TNnKmu6xczrm/USmVUr+GPxyM7j5GAGd9RiSU14BesEHrY29F8px8QAEPCdCCna7KJia5KS42ZZr0Qnn16Z8puGThlKveiWYIngfFN2yEMgWJb6o7iBtuFgFcvanOXE8AMYl/blqMeJMawsm39j+Bb1qAgnKep4TeLZgdtflvKMvt2Vun9u0wqQucWDxDl4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBGxN6qyB/z9uhdD9wLuuLN4iqw9m/LVOSiht6KRF7g=;
 b=OzMQInG0u2nzRDUIY5H0kxuRzki9Cn8dlbQ8lEUl2U1j+Cr9q5MXIMVCRGkkWYw3V3+OdMuzOWZO5OBF4KoUs2xQmVii3K74zdxRqB9MwQ0VFq/6SYY6CMBEdG9dj/EQV552+jRKIool/2m68TJRb3TI3WvXqB6UAGjNRQCw2UD/pCHSE0lTXzujIQ8stYM74c7IWFbmMjXdb3WGHPfEIQ6r8Tk+ilkope3FU96IOJ1zUbzHEcR/Wj+PY1xLdF2ILfBDP8K902WKT12Rt9GGKHzKqlMVsardpvntdTNZZ3cbYnBFy0KWD5/xc2vIwkofrU/Nikl3xBwa2NcLclpE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBGxN6qyB/z9uhdD9wLuuLN4iqw9m/LVOSiht6KRF7g=;
 b=bzwifBotZ63amXqNs3RxkBRrClaUpScBQzOofM8rvIu6YbiGyA26JpfLthEGkHsHl+T14KFt5tGAMIpftpCCUU6LnO38srvyJ2+FWvV7nw9yO6FlkD0H6oLzPSbAUMgL5l0LGgP0adsHW/cH1iT8zr0NVHalYLqqZeyHLWjUqwk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 13:19:17 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 13:19:16 +0000
Date: Fri, 29 Nov 2024 13:19:14 +0000
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
Message-ID: <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
References: <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
X-ClientProxiedBy: LO2P265CA0483.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1402c039-1908-4d3b-34e7-08dd10786cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ToGvnYmhmE9sJSpzUB9HkduNejiYxDK45RZrM+K9JdeRCDLlqRxxQsgWn4J+?=
 =?us-ascii?Q?mN/N+KZq7fyk69emEuzsq7JhHkpiz8ZDM6YYaegLpTJu9bbFiF8sdCA7t+If?=
 =?us-ascii?Q?OSqJd/XhjtX06aJVmengdjCAqnO1SQiBYJeuY6fJk3RzJgR+UtCZOXo7E4FH?=
 =?us-ascii?Q?R8IolYVLB+GIdX44dWPp/o4LhAR4OpQuCB8PMr7OTzN5BgtPg6sgVjXu0Uw6?=
 =?us-ascii?Q?c64UvKRe/JFQCOmSd7Mw3CP/ZDKs2g0593hRDqHQmQVUJvFL9lQxJ9fiB0zW?=
 =?us-ascii?Q?HfPg0RTCPpT5LWP550asLN6fB6sH60g77ANqq8RT5rsw6dCdkxiYcxwooQtC?=
 =?us-ascii?Q?sE2FisLmU0bo7rShYQxs8tNXqLGFC3s7L3WXobl/M+VxPgex72yY9fX09L2g?=
 =?us-ascii?Q?GPMXGgudmMuAGC+258mtttxPqPGjW8kPXi9iTdeTrF/VuEAOrVrSi3PDoKdu?=
 =?us-ascii?Q?b5bUR+Iu5xYFOr3cI/Bb3RgJpT947IqJM7zyDGvJ6zz0Ko9GPA01NqylEMd3?=
 =?us-ascii?Q?LNZNybU9OAb5YY21McMvodGL6lvVi1giUvm5h8Oswel3DtMuEy3M/etjzify?=
 =?us-ascii?Q?CYNEr+gUnTR6Zw7rw/NohF3DgiLicDGeckeuhMMkfoolid6huZPb9XP9s33e?=
 =?us-ascii?Q?H/JT+5f3ED83dtuuHHogc/01F/wuLRbuERg3kQ4S5lvl+gZtuP123X13OXX4?=
 =?us-ascii?Q?Svjx2ib/R30d2hnU9g97b+DbPjtnfH6FH7LtCu6yARedbKGH3Iw3C6qcozH2?=
 =?us-ascii?Q?q5IA59Pr9KsR1ccqV82Crux6+uDlBAUngxhRDKFEdhe4KEGNq6Sf53CD1c8f?=
 =?us-ascii?Q?MJDRJTsBzAOX0iOMlU+WWRfqwWf56LhxX6RXInuuyVmNvvsN0mnY+dBijUXA?=
 =?us-ascii?Q?TUQGLjZ50mklYXjd+kasb8UXhnXrcq0HP9TsgW5GkX23nFu1oPH8IupFTi5y?=
 =?us-ascii?Q?Fl4pAsK+BKS/i689m+T0x8j3LCyds1EQgy9RcfE6pvn1pTEh/TkJ68lG7OTT?=
 =?us-ascii?Q?slcqjd9GLiHPxCzfPPwL/WO1KcqCfaRfhsVUW1mJJxhaSMAUQBCNmhTU7nKy?=
 =?us-ascii?Q?Zclf+Q6LzYxxuCYsFFJXQ/nmUL0+SG09E54/E7lqGHFn3haPav1FJXu7dl+U?=
 =?us-ascii?Q?zTryroCpZyUsUqQbhCh/srZJuzBRQbT7MVwASo92hp1CQxDRikQb/hNcQo0Z?=
 =?us-ascii?Q?rdcILoNwA21WPlGl0Qqbui4zrP+SjxGrY+kdx8y9lWoEFL3xFhaIVcM5uuir?=
 =?us-ascii?Q?sPm5awyKx1nMmC9Li05pPi+rReg0EhZJmEr0yGlZ68r9Fit4R8v715ERD1TK?=
 =?us-ascii?Q?Dj3gL/k6YDqUW4iBG1TkNRFlNp99u0xixO0Dpyf8gjVDTg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ilk/zCll2FDMF2AnQtUNzCPCs8L/5FqUOc4PR/K3OoDC2gss06ZES4bG8Ez?=
 =?us-ascii?Q?x5fgmOs2IKFa3QxXurEZ4ROnMfmjWEs4M/bYTJlLWw062MW338Ul98vXkpSt?=
 =?us-ascii?Q?S9WNuQncz72nRurihIRCkmTpi2ox5d31oYpZHZ6f63CXEO7B9A/ZJGvR09fA?=
 =?us-ascii?Q?LEHiPZ41PG9iQ9Cg6dfnpjEwsTvuDuLcuHPJMYDTRKh3nFbzkX9L4kEYJH33?=
 =?us-ascii?Q?/0NJByWi5+JZ2MrEQcXhSVzQQL7hKhQS00SUE+o7WrkomK4qMdiYOT9zOdgt?=
 =?us-ascii?Q?hoSdECbJCJm1zUcpqApCrYmvnKdOl1KPbW9EQChyZNdylgpG/m+yaZFP5FqX?=
 =?us-ascii?Q?7hTQpSTOEa7e3j6kiZ2XnezdSnGyW9jtugkUuzxyXLeUQRtyWZxusib8vR71?=
 =?us-ascii?Q?N83AQPCu27UoLumVX+xabjj4Qve1vu5rPHsMDmCF6vzIJAg6TzdoUEEOCQPG?=
 =?us-ascii?Q?8qMTlRrRVxxlUjKZdI4qMQa166UJAz6gu0PjeM6p6beCvZE1AdVjHdicMaC+?=
 =?us-ascii?Q?hC2SwNIy1tIXU3zWSnYhO6h97GotKjeypN08lSPI7+XRrHeXEXJH9ZtNSJow?=
 =?us-ascii?Q?5Dft/chCbZOLcdl9hv9EfvyR9AhAIwB+d7PeUDbRGtGeCcjU4Y4/Bs+XChC0?=
 =?us-ascii?Q?7FBtp0HaVp4xKLQpd6elkZiKiQrqIXoc6lAoWPjrhEhcW87lF1sUOunaBL1G?=
 =?us-ascii?Q?Q4WowoUeeWvqZYH1lrQVwDePfDiiFQp+eG1Gz/X2L/zJH4eV1/hFhGWm+WCO?=
 =?us-ascii?Q?gHWktb9BCTtsYbcEZHsibvy0gXkmWEjB2ubOC/JkPTYfT0DyPtF2LaUZEZuj?=
 =?us-ascii?Q?yh8BG44aY+yV9QOb3gjzdOsJXOke/Y5cXs/wU5TEomSNiSY1j50WnU6yVLhv?=
 =?us-ascii?Q?EKRzzKpQ1mJ/H+em1eqEQX/mYJZdJJUWCyuBnRhfVHi5BCFDtP+ZrHqOuEHV?=
 =?us-ascii?Q?dcXSjAGVjsilSaEBosHT1+6wIR6HzI7I4avjCqLFJFR8dLq0SPC2to1CaBtE?=
 =?us-ascii?Q?+vFzqvnPaffMTxxufbkrBvJQfRODIqKWznFjwIJyky/epUbGKTq8mhYPB6ru?=
 =?us-ascii?Q?GWIGjun4c80mCZq2aYRoKboBQUMIt8IwdcPtDMjIGHbbVMCdugR+DRBXjOr5?=
 =?us-ascii?Q?LP9g9J00CV3XbnaIPkazBrBAJoI5Pt/wt8FlaIlucrb3Y5sf5SDARWBzPRiX?=
 =?us-ascii?Q?VaTylrnVgprJzp31SqeeePPcQ3wjOvbCfOiLXbJTKl56ZYPU1mRDQdn0XBRu?=
 =?us-ascii?Q?sVS2CPLQVcyCuHg3TkabeloZyUBiGa20tkLdvPFQAWlwgQvgJ/yuyoK/lPSL?=
 =?us-ascii?Q?AV73jaKk+EA+Gi9fNSdglhMPM8WI7sxOm3oOWfn79aptaPcekC4RzO2BziRG?=
 =?us-ascii?Q?OBcqtwrYGiIEN4XFDiS/KnSOBw1pN880o9dGfSzAyCbUMucDc/VGQPs52xqW?=
 =?us-ascii?Q?AFs/rbwxoxgh0/iRApxn+OAEyd4Ca0xS6cCTpGlri9IuqCbr9ZnzgkeCl8sT?=
 =?us-ascii?Q?qfyrBWBv43TTRndSvltTOoy6CXDIKviZ8TrYVz2r/orvPEl3XUZ1J5p/1fLC?=
 =?us-ascii?Q?6MqxbUGA+vFI0JCsllpkyaALTBqW5LMCqOuC2CIAsymf9zwtFIOMyAlqUIL+?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jURwYJ9Yjbur5u2tKmGmiPYVmzTloAT9jBZQ6XZ79fOyK9diJ8AEOOnsSzo0iwoGVk9QeZC/5VAX+JVluIaHDwDRPiXiIVB/rM4SCSPWdioC8gc9k/sWTPpHmPPSZzr4nVrOR7bejxdiWvhKTalN0BJE1G6yTiF4rI0AnsTft5O3gF/cDEZnXm1lCT3ajWV4TdlKm82jt4k3oKINI6qRVvR8mIcbHpphCaSU3+zZlx7lLEG3cnVsIwj66qRuqKS++iZkCSnI2cRlqNZBAQ/cjLxmTv/q46j4iHENr5bWASYloXA1RhcQtbW7LxydZPC4hfFskB+clcfgLNsN+x7blQot91K5rqmTFzatZXZdJEil0WQpSkLJc6IjVyBvLdPx/SbRc8d6AAXHzu3i/kRNp7AVo3cN99d+812LS61Uid708U3MsWoy9QE4giVDdOAA6vOhU42P+kxgK8z+z8nl7UFffUdKLsw4IIVJSnjUib64RyOiDQlumSXL0M2ZCi8WHbS1yZNPJ246jOrcIgyIKJKrzeZu7y3daf3SuWv1dJpvxxVrd1BKTBAiJUywapj5Fzt2BOIq/97yAPhX9RQXKTIsuQj2PRTNbnpQEdqE4zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1402c039-1908-4d3b-34e7-08dd10786cf5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 13:19:16.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ni+WYD80cJ1Vo76b6xOHeFRbZdp9h/J0csufmGWSmGRG/Z4FSe3K95r8ZasmVHw4iUgpqcu4diJn2cpEn/PMDj1vYKNdn0yw3AjZTf2gcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_12,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2411290109
X-Proofpoint-GUID: rE2BGDrsvS58U55LKwnMniQlX9Xh6Agn
X-Proofpoint-ORIG-GUID: rE2BGDrsvS58U55LKwnMniQlX9Xh6Agn

On Fri, Nov 29, 2024 at 02:12:23PM +0100, David Hildenbrand wrote:
> On 29.11.24 14:02, Lorenzo Stoakes wrote:
> > On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
> > > On 29.11.24 13:55, Lorenzo Stoakes wrote:
> > > > On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
> > > > > On 29.11.24 13:26, Peter Zijlstra wrote:
> > > > > > On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
> > > > > >
> > > > > > > Well, I think we simply will want vm_insert_pages_prot() that stops treating
> > > > > > > these things like folios :) . *likely*  we'd want a distinct memdesc/type.
> > > > > > >
> > > > > > > We could start that work right now by making some user (iouring,
> > > > > > > ring_buffer) set a new page->_type, and checking that in
> > > > > > > vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
> > > > > > > and the mapcount.
> > > > > > >
> > > > > > > Because then, we can just make all the relevant drivers set the type, refuse
> > > > > > > in vm_insert_pages_prot() anything that doesn't have the type set, and
> > > > > > > refuse in vm_normal_page() any pages with this memdesc.
> > > > > > >
> > > > > > > Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
> > > > > > > these things will stop working, I hope that is not a problem.
> > > > > >
> > > > > > Well... perf-tool likes to call write() upon these pages in order to
> > > > > > write out the data from the mmap() into a file.
> > > >
> > > > I'm confused about what you mean, write() using the fd should work fine, how
> > > > would they interact with the mmap? I mean be making a silly mistake here
> > >
> > > write() to file from the mmap()'ed address range to *some* file.
> > >
> >
> > Yeah sorry my brain melted down briefly, for some reason was thinking of read()
> > writing into the buffer...
> >
> > > This will GUP the pages you inserted.
> > >
> > > GUP does not work on PFNMAP.
> >
> > Well it _does_ if struct page **pages is set to NULL :)
>
> Hm? :)
>
> check_vma_flags() unconditionally refuses VM_PFNMAP.

Ha, funny with my name all over git blame there... ok yup missed this, the
vm_normal_page() == NULL stuff must but for mixed map (and those other weird
cases I think you can get0...

Well good. Where is write() invoking GUP? I'm kind of surprised it's not just
using uaccess?

One thing to note is I did run all the perf tests with no issues whatsoever. You
would _think_ this would have come up...

I'm editing some test code to explicitly write() from the buffer anyway to see.

If we can't do pfnmap, and we definitely can't do mixedmap (because it's
basically entirely equivalent in every way to just faulting in the pages as
before and requires the same hacks) then I will have to go back to the drawing
board or somehow change the faulting code.

This really sucks.

I'm not quite sure I even understand why we don't allow GUP used _just for
pinning_ on VM_PFNMAP when it is -in effect- already pinned on assumption
whatever mapped it will maintain the lifetime.

What a mess...

>
> --
> Cheers,
>
> David / dhildenb
>
