Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CD158520;
	Fri, 29 Nov 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884554; cv=fail; b=UaIHTU2Dsvu0JLNLeGrSU40KKBcVujnZH3ftGKx3Xke56dDMkUDqwyLA5iXMZkTPMmAjvoRSZrSbfFYd55+0smSie9uJYVZ7QKleeCPBZmJqAiLWE3bCx9S467PsX8hjlXmEkC6UEqnb0ZnL8LLyiAuHJK+QnbfyLSUycKki8js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884554; c=relaxed/simple;
	bh=N/9IR6pcbgGW1F5mwRVXQXFxTY3rn3BSKJHuMZOiVls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXXL/ALVSWbgUW4EiHXHmfNBV4Ab6fajPOVe61gHMbxnnKNTFmqUYNTqL2Dttijzah9Uuql1HhDqphrJptNLwfQ+3tWCk0HWT3K+/NjGxUGimed78eo5wGzssiHeibD6AUx/us+G7w+D5N+2hizNvTw0puL/UM5qhn8FfN+v+MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hMFE84e6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pSM3/bcz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hMFE84e6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pSM3/bcz"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fvQ4022229;
	Fri, 29 Nov 2024 12:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=B7F9alTOa7NQQm2Bug
	LY+6Td/ooZVwUviRM9+JUfqAg=; b=hMFE84e6xrIISpKr4eyJGIkRzTOmivvF7w
	seNGXbwZ7mVy7UJciyVz9WV4a/C/hrLRdyyxfLHm6POns+N2t7tq/2N1Y3FduVc7
	4bkuDaEvmQ9pRSgED7ZlT0xb5eWbIFvaHOx/2JsscASiZ/dW8A+dAv9Bvv98jhch
	Hi3+sPNEP/owO5yKDhumrl+0ywpFKd4K6BTgRj5U0w2qdhecnVe/0mmvVP2YhkBq
	uYgIBxnfUt5d8W+4vGyChtF6g78bEailjyxMv9PFPnUoynI6Va+XrA/ND4eeKvo9
	1xBroBt5xRr8nGHQf9oAj5uJ75SZbzzVyGhk5NZvm74AbkQlfcfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xyba4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 12:48:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATBq2nC027432;
	Fri, 29 Nov 2024 12:48:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43670550ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 12:48:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZourQJaP2WZP67gO5zlfZBq8ZWBTCpijihIazKGlKNeZTI34oV3vToP1oW0SlxD/SAVF8bCgy7LdDFYt0VbKQe90UlC9Q9RRvqNKyHHQBpQ9GjzC6MJP16RiXLbEoS0vr++5NtjygLj1GoGMdmJoZ5h9mH3nBPx1sh+0vrPJIQ5UBfM5XhLtC4tmm+bNOxN627DyB3Fp3Rlgan3FePSVEqfluSZodZHTUdxP8Wc0eAhljB8Z6iMc3c3Xw6MUHNPS5aRbWN5m4sxWefeUtTakcPAvfWd/2I/X5PCxrx7thGk/4t0BhrWIh49iLXZnKojgPflTN9r8xwGkYY24K2zyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7F9alTOa7NQQm2BugLY+6Td/ooZVwUviRM9+JUfqAg=;
 b=TOA8V8JflDSzZKx9/9jUMF9ejEZHCXWO/Zb2UlhEu/QCdF37znb1P37JfQV0/73RiF580UL2XS9OQGOAGoTZVjm3TsVVTSrqFzMyDBEvUtgcf8FGDz9d9HUgzhtmKJyM5VdkljWqoqAa9RWJBdmAYMFcZFNUd77geTcdmDdZ5Iwy2dbk8RISqis+rzyf3UXrDDxvZVEZSsZnt5PmWJ+k92ilgCB633bxdxkc8Rsph0JHzOrpdlOvwr+g2OkCP8sgYxIKNQIMNJO+t/xIA+Q0HFCtfVeiPPKzoLOYesSAx6MZPlXA63itxpp4nI7LanimWy6vO/G2UGIGXHliPZyYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7F9alTOa7NQQm2BugLY+6Td/ooZVwUviRM9+JUfqAg=;
 b=pSM3/bczToTXwOrgl6ItbPo8sGkMP73v0Ul95eU+JlYIO7DK7W7T/dQwiBLKv2xnDG2HFVnxZ5vN/sg/fotwfndcAF4p0YpPCD6RLFlVYNsu3jOmDNCjANlb1uapNZgn6UziC8VOILow1WPHZ59rKDN5eAfZLAoZHOMoxgJfXfM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB7062.namprd10.prod.outlook.com (2603:10b6:510:283::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 12:48:45 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 12:48:44 +0000
Date: Fri, 29 Nov 2024 12:48:41 +0000
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
Message-ID: <03f654d5-424a-4d23-828e-323aff46fa61@lucifer.local>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
X-ClientProxiedBy: LO2P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::25) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB7062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7204333e-8456-4147-8e6a-08dd107428f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6exG9yTTSgKoEgSxOBpRwpDmcTnZIL1KqD3cww3CcRoq/3VE0Vy7HpvbJrCQ?=
 =?us-ascii?Q?66mGSMQJRlrojAQEXc5IUVuOP04h5ucYhHN/m0X3gvjVL36pDNqiz0cGXZNN?=
 =?us-ascii?Q?ADVaEm/L4eTCdCV3BY0rATHjASInwayZuziTS8WtRmoRXckRMSmm3eu2Ujdi?=
 =?us-ascii?Q?T37tvQmFgGY9YNAEX8okCGVsKQRdYX7yUtLZlFUnqUYP7qjqKcDC49C+6JzA?=
 =?us-ascii?Q?Bj6VvEAyEZfrDkJSO24IatIJQtJH72FbpByqUaM4cqvaNK51yMQXNBb8g2G/?=
 =?us-ascii?Q?02MKgL7NeNcbvRLsP2BmJ9CzMFEITkMbsD6zLCnBS4DO1sLeRON3xeAMzSmv?=
 =?us-ascii?Q?KclKZ2/2qdfGODlVlhXl943+oKjAqFaKrGLbcu01yEFSRWQnRkxc13vd8XXe?=
 =?us-ascii?Q?yCh4lELYt/I0A7laS6meq08NVSm54HriF+1wfz9akEeNfVSDZh3eMJTwHIgZ?=
 =?us-ascii?Q?RNffGiLeOHtuHoakx3LyWFR6o6gCH8+NC3iMIwYEw/KwbICENMzLEpiqaixz?=
 =?us-ascii?Q?HskPS7H2TietVeUbiXxhUQ40j+us/+DoBYdfat9Ph7i8xWje+332W2rmdaOQ?=
 =?us-ascii?Q?+exZVGW6YIuLAe5FR+GPJQjFEHlfrRkEENFROhUZ0G+folbp0vJrJ3OZQNFN?=
 =?us-ascii?Q?EgwfjTB/CAYhT24QbuPe0HYXqbDxP7OoC9suF8paOmsI/8RzhQUSbNK+XTBu?=
 =?us-ascii?Q?PlvRAvyy01DBy7hzqq7yKG7YHcdA27GZPAtrYXwR8t+8qiL7lBqG0d/JWAzc?=
 =?us-ascii?Q?hCHcPaRgFQQzzko0p1FQcuz5DSM7re/t88qeQOG0M8s2tTw3CN1/D0pj7lkp?=
 =?us-ascii?Q?/KsPxd+LMTFS7QBAr1f0bNiO/d0ES7cq+TBYWn7yuhkdiHCFLh2//F04EgNy?=
 =?us-ascii?Q?3wLXNUxP8jsGyvt5ILj2Zn8roqnVI89k1ESPmh/RCTzJiKzqyWlPePc/taxS?=
 =?us-ascii?Q?f39D1x9HAVu0cPwRMB1vkIIpj7SKQLG1r5uQSxBYbESrJOWOMf2SpYgS469E?=
 =?us-ascii?Q?8Cs2UmWmuLOKJF+BJHowBXwjcZ3RoLbCekHnPtJCjaDSKLLv3gxgWYC5zN+h?=
 =?us-ascii?Q?Bezf5BM2BO9EOT6LkJbT+lvDiBWg2jqMKRmjcg0cgZ/byX6vXWwMN6z+ze5p?=
 =?us-ascii?Q?IvtgHBR+YfqkxRRHrnyoIZAW148MryqK4erDVHGKlu/oOokw9Wt805TpJLOt?=
 =?us-ascii?Q?gm+l5kqTi7NA1jz5QZuh7uIAZruT0C0CvaVIxmZYjpvubD3+CODdUg/Pjg53?=
 =?us-ascii?Q?fhga8OYTeP0VKU9B3u5xoDjMxJGfm9JazS1zYjJEk4uws85wkCXElOjHmsDB?=
 =?us-ascii?Q?T/yr0f1CHqKc8QHEu41yJPSlH8WZ1efURwlUWgQeWOpnFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jN3k3uAkOECYOExdBkioJPzy8TN6lU1MQq8VUtSMd3L4WuKInisAeizYg6gh?=
 =?us-ascii?Q?kaGzHUfi+ka1WcUQJq3Vdora7DiOBEnb3SoiC3x6M7iKHJR8R/9H715R2p4M?=
 =?us-ascii?Q?CDemfIcp1LYissbH7zZ6Phun+YX/zj1JO1IYoHGu/7zLdKXCT5eo5faUoaYn?=
 =?us-ascii?Q?V+oVBfi63C9GzVo0JVtc1VPS4qxTNMGnA3ZqVNfAiMDcG2rf13Kcu78CjT51?=
 =?us-ascii?Q?X5fcGDvNj+I0he47jyuzjzImsBQceK9GxPOz7Ie3uwyjtVPvmIN9vs4jSzXe?=
 =?us-ascii?Q?4KolDXOJLzQH+W+qtAOrBJJ7iwa5HefKAi79d3alcGWKtF6qMs5rCizJa+A+?=
 =?us-ascii?Q?ZyWR4HHklLBH6HlWSIXMlHdNEiUO4tS9kom81axt8kpEv+Q2A/PypX0IRja4?=
 =?us-ascii?Q?BqojLrXgdACgv8vHDSQyRNSVPI5poB45Z1ir5K0oUaYPQVUEJGU8bfmcURoZ?=
 =?us-ascii?Q?XFmErQhREFXc8o0Wt/62yTHBhKOwRt3tIKgdbp9IVFHrbbMzlIGe1nNf4nXE?=
 =?us-ascii?Q?ISeTFtDGueEy12OsTuBpcK20JjA5n/jAf+GoQb377YK+pyuV+klOUBQ2LoZt?=
 =?us-ascii?Q?TwzWrnRf1Cpe+gor0bOF9FJPYsQwONyUIv90NoRXO534EqxpmJS95GtrRCft?=
 =?us-ascii?Q?GLC7ZfuD+RB5nrrMo1G96m+Qb4PXBvcIqzBuyeUfODXLb7RhyzM96/yv8atJ?=
 =?us-ascii?Q?A0yPR2B1hd8P09jEahQOlJGHCwx4znNLKfgLvSUVoXOhlgpb+IIXjYQi02Sv?=
 =?us-ascii?Q?BDe4d7vzwWYQ7g3vx4N8Guo80cRoLj2l/69tOqVQSd9PpZb0zbhSZT0BYhCn?=
 =?us-ascii?Q?Z5wgjvEAlra6fJ3BkqeZizknHArLGxA7VROjy1SoAe3GnmVx2YF5uMNxUWW6?=
 =?us-ascii?Q?MwbMvYZKnHIQAic3EL2ODVHqVwo76hBXM0QjjCDYg9KzOXLqNEzkj14a/Cdn?=
 =?us-ascii?Q?IhsYQzo7+5G/lTNjf4n9obORGx9gqvpzamQYbSutb1ZEE++9VHc+Vo/sd/+l?=
 =?us-ascii?Q?b1wqWawNJLEqH1wa9oojSbKcXDpB4pAFbl8iJmZ9zbw2R3WsEwQylxuEc1YK?=
 =?us-ascii?Q?zzCKRlgkGAyyogy7DLmMd1pL4FTCCOnnU2eKzP+HiVi+A6jsHbVajKUJhUhQ?=
 =?us-ascii?Q?M07adwonyd4XhwHEEAEymqFM1IKuJ6beSey/k/3zUpa3Uf45diCq1fAhZFp0?=
 =?us-ascii?Q?ummJkeIch7qyiZBHxXzSg0TpY6DRW43QqRD6/trH4fsZ0gxTpv1Avj98hOvh?=
 =?us-ascii?Q?Y77mu8JOi2Udguh7SjyqQRAficccytkIXTgTZTxj6fcnTz0cTyIfKSbrshR+?=
 =?us-ascii?Q?wK7jxucwYPibxf27f80fcZAc0zgnzt7xOPsNnhH0P0En+Lo1FfW9aPEiU0v1?=
 =?us-ascii?Q?aNmhnFdT0LHX8hFBivaxTcY388yttX6zrflucZ2+2J6sI98hB5ixZrqI16DC?=
 =?us-ascii?Q?cI/BrIMh5OA4lRz04k/MpsHh9OeddcsgvJufzY1+3Q6Fiwu418uzYORpeWbG?=
 =?us-ascii?Q?fLg0vLsDAJ3g23JjAAlfLVasE+CEBWi2UobwXQ0lSvLH2S43InxzhPZRps1M?=
 =?us-ascii?Q?4dYv6MTJ2/RMXFCtdK4QnetGeAqXqDfKPXuzJ5cOHp9K+9KRt0BWy0I8dtcC?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bTvY0DpbUCRm/R+1BiEAhfYcd8YZyPKmNQNQksXVyH0BvJmqqam240SfRuluHhqcaWQA3M3qcL4lMlcIjj003/gSczBQQ6EjUtfUy9W72y0J4R0ltDaFiDAQkvnvYdripNAutgBx6QtdnFjebshF+UBuHjJJ2Sc8wTx9l9wYY7/bSiJ6qbylR6pE5kceQmHumTQtOnE2tVRttZ+kqy8ZkOG3l+eCmX3uhxKizKk4Qzj4bHIaB4m6Fa08LwUpre+peJMVzeC570Rxdz6cLOKmaF1GKJzR8lTFE3V7BiWlhjffP0PIKS/rtre9yrS6wgTFJ+u4tI4FgAtVnH+n8H1kIHWKCHZoY77Lw6Jh2LRvGMcTkgUayotiJNExlRRjGKd7YnxXFxAaEVhwRGyRp+tAFdjEo+nKFzAhCLXRhRcT4JuJx4bu9dHzdXMFnoD6UxKv9/FhfXh3rK6N+c+wzsx2UPzaP4gWssQz4XSFHGDH4brKDjE+yN+AuazKpFLPCDTpaxFCWFdX/q6OED5xMoD63KD8rQGp0pQIew1WLF1cuJgEBpOQplXA+EArvQ4g5qN6E30ssO0P0DghouAv04ST48C73YXV7plM/fx5bfU55gY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7204333e-8456-4147-8e6a-08dd107428f6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 12:48:44.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHAzdLLFTFYGwrOPWKWXBMi3DFT5sm+W35+vnRhKTeQq1Zl+PByFOqVas8uQXUMREEjXxp2vlor2Y/2ZnmZoI+Wl9QzXr/bGKTv/N8JonXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_11,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411290104
X-Proofpoint-ORIG-GUID: WT38jvPS3lnx__SGp5N2y85NcUSsdP2D
X-Proofpoint-GUID: WT38jvPS3lnx__SGp5N2y85NcUSsdP2D

Will reply inline also but to be clear - we should differentiate between
ongoing discussion about how best to tackle these things going forward
vs. whether _this patch_ is OK :)

I don't think you're objecting to the patch as such, just disappointed
about VM_PFNMAP and wanting to discuss this more generally?

As I say below, we can't use VM_MIXEDMAP as it's broken for our case (we
have to use page->mapping if there's a struct page), so I think _right now_
this is the only sane solution.

On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
> On 28.11.24 15:23, Lorenzo Stoakes wrote:
> > On Thu, Nov 28, 2024 at 02:37:17PM +0100, David Hildenbrand wrote:
> > > On 28.11.24 14:20, Lorenzo Stoakes wrote:
> > > > On Thu, Nov 28, 2024 at 02:08:27PM +0100, David Hildenbrand wrote:
> > > > > On 28.11.24 12:37, Lorenzo Stoakes wrote:
> > [snip]
> > > > > > It makes sense semantically to establish a PFN map too - we are managing
> > > > > > the pages internally and so it is appropriate to mark this as a special
> > > > > > mapping.
> > > > >
> > > > > It's rather sad seeing more PFNMAP users where PFNMAP is not really required
> > > > > (-> this is struct page backed).
> > > > >
> > > > > Especially having to perform several independent remap_pfn_range() calls
> > > > > rather looks like yet another workaround ...
> > > > >
> > > > > Would we be able to achieve something comparable with vm_insert_pages(), to
> > > > > just map them in advance?
> > > >
> > > > Well, that's the thing, we can't use VM_MIXEDMAP as vm_insert_pages() and
> > > > friends all refer vma->vm_page_prot which is not yet _correctly_ established at
> > > > the point of the f_op->mmap() hook being invoked :)
> > >
> > > So all you want is a vm_insert_pages() variant where we can pass in the
> > > vm_page_prot?
> >
> > Hmm, looking into the code I don't think VM_MIXEDMAP is correct after all.
> >
> > We don't want these pages touched at all, we manage them ourselves, and
> > VM_MIXEDMAP, unless mapping memory mapped I/O pages, will treat them as such.
> >
> > For instance, vm_insert_page() -> insert_page() -> insert_page_into_pte_locked()
> > acts as if this is a folio, manipulating the ref count and invoking
> > folio_add_file_rmap_pte() - which we emphatically do not want.
>
> Right, but that should be independent of what you want to achieve in this
> series, or am I wrong?
>

No, we can't implement things this way if we use VM_MIXEDMAP, as
pfn_mkwrite() will no longer work (we have a page now) and page_mkwrite()
will require the same page->mapping hack as we had before, which breaks the
whole thing.

Also, this is memory that makes absolutely no sense being reference/map
counted/placed in the rmap. It was worked around in the previous code by
pinning the pages on fault, but this is ugly and unnecessary.

The whole issue we saw here arose because we tried to treat this memory as
if it were not kernel memory but instead just standard
refcount/mapcount... yes to below about needing a specific way of doing
this with e.g. memdesc :)) previously the pages were being pinned to avoid
presumably migration, compaction etc. but this isn't something we want to
be worrying about...

This change will break GUP for the range, but I don't see anywhere that
needs GUP for these mappings and the memory is now specifically pinned.

So TL;DR - it's VM_PFNMAP or I have to find a completely different way of
solving this problem afaict.

> vm_insert_page()/vm_insert_pages() is our mechanism to install kernel
> allocations into the page tables. (note "kernel allocations", not "kernel
> memory", which might or might not have "struct pages")
>
> There is the bigger question how we could convert all users to either (a)
> not refcount + mapcount (and we discussed a separate memdesc type for that)
> (b) still refcount (similarly, likely separate memdesc).

I think we definitely need the ability to differentiate between:

1. 'I allocated pages, but I want them to be treated like userland memory'

2. (maybe) 'I allocated pages, and own them, pin them for me (maybe) and do
   refcounts/mapcounts, but I will still manage them

3. Yes there are RAM allocations, but do not touch them at all, I am
   managing them privately.

4. This is a pure PFN mapping of memory-mapped I/O pages.

5. Mix of the above?

I mean roughly speaking :)

We also have nuances, like the issue this patch fixes

>
> But that will be a problem to be solved by all similar drives.
>
> Slapping in a remap_pfn_range() + VM_PFNMAP in now in the absence of having
> solved the bigger problem there sounds quite suboptimal to me.

See above, sadly it is the only way to solve the problem.

Note though that perf has a _very specific_ requirement for 1st page r/w,
rest r/o. I think most drivers will not have this requirement.

> remap_pfn_range() saw sufficient abuse already, and the way we hacked in
> VM_PAT handling in there really makes it something we don't want to reuse as
> is when trying to come up with a clean way to map kernel allocations. I
> strongly assume that some of the remap_pfn_range() users we currently have
> do actually deal with kernel allocations as well, and likely they should all
> get converted to something better once we have it.

Yeah I think all this is a bloody mess and is crying out for a much clearer
way to abstract things.

>
>
> So, isn't this something to just solve independently of what you are
> actually trying to achieve in this series (page->index and page->mapping)?

Again, VM_PFNMAP is necessary here for this to work (sadly). This other
discussion we're having is kind of separate though :)

>
> [...]
>
>
> > > >
> > > > We set the field in __mmap_new_vma(), _but_ importantly, we defer the
> > > > writenotify check to __mmap_complete() (set in vma_set_page_prot()) - so if we
> > > > were to try to map using VM_MIXEDMAP in the f_op->mmap() hook, we'd get
> > > > read/write mappings, which is emphatically not what we want - we want them
> > > > read-only mapped, and for vm_ops->pfn_mkwrite() to be called so we can make the
> > > > first page read/write and the rest read-only.
> > > >
> > > > It's this requirement that means this is really the only way to do this as far
> > > > as I can tell.
> > > >
> > > > It is appropriate and correct that this is either a VM_PFNMAP or VM_MIXEDMAP
> > > > mapping, as the pages reference kernel-allocated memory and are managed by perf,
> > > > not put on any LRU, etc.
> > > >
> > > > It sucks to have to loop like this and it feels like a workaround, which makes
> > > > me wonder if we need a new interface to better allow this stuff on mmap...
> > > >
> > > > In any case I think this is the most sensible solution currently available that
> > > > avoids the pre-existing situation of pretending the pages are folios but
> > > > somewhat abusing the interface to allow page_mkwrite() to work correctly by
> > > > setting page->index, mapping.
> > >
> > > Yes, that page->index stuff is nasty.
> >
> > It's the ->mapping that is more of the issue I think, as that _has_ to be set in
> > the original version, I can't actually see why index _must_ be set, there should
> > be no case in which rmap is used on the page, so possibly was a mistake, but
> > both fields are going from struct page so both must be eliminated :)
>
> :) Yes.
>
> > > > The alternative to this would be to folio-fy, but these are emphatically _not_
> > > > folios, that is userland memory managed as userland memory, it's a mapping onto
> > > > kernel memory exposed to userspace.
> > >
> > > Yes, we should even move away from folios completely in the future for
> > > vm_insert_page().
> >
> > Well, isn't VM_MIXEDMAP intended specifically so you can mix normal user pages
> > that live in the LRU and have an rmap etc. etc. with PFN mappings to I/O mapped
> > memory? :) so then that's folios + raw PFN's.
>
> VM_MIXEDMAP was abused over the years for all kinds of stuff. I consider
> this rather a current "side effect" of using vm_insert_pages() than
> something we'll need in the long term (below).
>
> >
> > >
> > > >
> > > > It feels like probably VM_MIXEDMAP is a better way of doing it, but you'd need
> > > > to expose an interface that doesn't assume the VMA is already fully set
> > > > up... but I think one for a future series perhaps.
> > >
> > > If the solution to your problem is as easy as making vm_insert_pages() pass
> > > something else than vma->vm_page_prot to insert_pages(), then I think we
> > > should go for that. Like ... vm_insert_pages_prot().
> >
> > Sadly no for reasons above.
>
> Is the reason "refcount+mapcount"? Then it might be a problem better tackled
> separately as raised above. Sorry if I missed another point.

See above, vm_normal_page() cannot return a struct page * or otherwise we
end up having to invoke do_page_mkwrite() which interprets a missing
folio->mapping as requiring a retry.

We could hack it to lock the folio in the page_mkwrite() hook but that's
just horrible and worse than using VM_PFNMAP. Plus we're folio-fying by the
back door at that point.

This is not helped by the fact we allocate non-compound higher order pages
(if not using vmalloc) in the perf code :)

We are in an ugly situation, so it's a question of drinking the least
horrible pint of beer here.

>
> >
> > >
> > > Observe how we already have vmf_insert_pfn() vs. vmf_insert_pfn_prot(). But
> > > yes, in an ideal world we'd avoid having temporarily messed up
> > > vma->vm_page_prot. So we'd then document clearly how vm_insert_pages_prot()
> > > may be used.
> >
> > I think the thing with the delay in setting vma->vm_page_prot properly that is
> > we have a chicken and egg scenario (oh so often the case in mmap_region()
> > logic...) in that the mmap hook might change some of these flags which changes
> > what that function will do...
>
> Yes, that's ugly.
>
> >
> > I was discussing with Liam recently how perhaps we should see how feasible it is
> > to do away with this hook and replace it with something where drivers specify
> > which VMA flags they want to set _ahead of time_, since this really is the only
> > thing they should be changing other than vma->vm_private_data.
>
> Yes.
>
> >
> > Then we could possibly have a hook _only_ for assigning vma->vm_private_data to
> > allow for any driver-specific init logic and doing mappings, and hey presto we
> > have made things vastly saner. Could perhaps pass a const struct vm_area_struct
> > * to make this clear...
> >
> > But I may be missing some weird corner cases (hey probably am) or being too
> > optimistic :>)
>
> It's certainly one area we should be cleaning up ...
>
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
> > I wonder if we need a new interface then for 'pages which we don't want touched
> > but do have a struct page' that is more expressed by the interface than
> > remap_pfn_range() expresses.
> >
> > I mean from the comment around vm_normal_page():
> >
> >   * "Special" mappings do not wish to be associated with a "struct page" (either
> >   * it doesn't exist, or it exists but they don't want to touch it). In this
> >   * case, NULL is returned here. "Normal" mappings do have a struct page.
> >
> > ...
> >
> >   * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
> >   * special mapping (even if there are underlying and valid "struct pages").
> >   * COWed pages of a VM_PFNMAP are always normal.
> >
> > So there's precedence for us just putting pages we allocate/manage ourselves in
> > a VM_PFNMAP.
> >
> > So I guess this interface would be something like:
> >
> > 	int remap_kernel_pages(struct vm_area_struct *vma, unsigned long addr,
> > 			       struct page **pages, unsigned long size,
> > 			       pgprot_t prot);
> >
>
>
> Well, I think we simply will want vm_insert_pages_prot() that stops treating
> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
>
> We could start that work right now by making some user (iouring,
> ring_buffer) set a new page->_type, and checking that in
> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
> and the mapcount.
>
> Because then, we can just make all the relevant drivers set the type, refuse
> in vm_insert_pages_prot() anything that doesn't have the type set, and
> refuse in vm_normal_page() any pages with this memdesc.
>
> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
> these things will stop working, I hope that is not a problem.
>
>
> There is one question is still had for a long time: maybe we *do* want to
> refcount these kernel allocations. When refcounting them, it's impossible
> that we might free them in our driver without having some reference lurking
> somewhere in some page table of a process. I would hope that this is being
> take care of differently. (e.g., VMA lifetime)
>
>
> But again, I'd hope this is something we can sort out independent of this
> series.

Yes, in a way you wonder if _everything_ should be refcounted and _nothing_
'manually' controlled by drivers which __free_pages() unconditionally at
the end.

This would avoid uaf's and such for still-mapped memory.

Here we're cleaning up on VMA close and doing our own reference counting
there so we're relatively safe...

Anyway I agree with you that we should have something that explicitly
describes what is desired like presumably a memdesc would.

>
> --
> Cheers,
>
> David / dhildenb
>
