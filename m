Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B7158520;
	Fri, 29 Nov 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884948; cv=fail; b=Cl9VgqSKjjaWwwVspSSPGd5xYbhZiDIaMon7aKxHV+0LB7mBk48sseVe/qN2ljUXIDgIlHnEMsFryQe/w9OEROhVNSRffErsXngYbza0AWMrgwvhNX8emd9Ll/089op36adSdakFSNMRGrI2cbSXrJt7tGraDYwARebqH553lvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884948; c=relaxed/simple;
	bh=+Qm84O9TLSFrXqI7kwWIfFgGZm5BAPm2NlZi0snpTbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aJsbIoyowitDdwDARDLZkicE7czWVuSTv2nc3OOk0tQVFfczT/7hlRdETZ7atVHF/KjEw7zwSEsjv/YMmimSbmDuifUy7VjKpn3rgd2rXCfk9sqhL0ZJRVNbXjFgrgP3XpzYYPqb7WgfmcYKcEjtuucFAmKR5JwegSeBQCKmGfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sp2wVAru; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jejzEkeI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sp2wVAru";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jejzEkeI"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AT1fipG031780;
	Fri, 29 Nov 2024 12:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CDuLoFb/rNqGZsexrF
	7FNgx4ezFuyx0SaNMSMzT1VuY=; b=Sp2wVAruSrHoFhsmhRwLySn5ogyDLM48S6
	IMAIwRqtUHpF5K25QKbwuB73MDUroktlYFhTyn9vqMClWe7OtcsQotXId+sKeWX/
	i4U7Y7xUmLUFMzWelLpKJOuiWWTMYkLN+6ZJiWHwvYP75KTAfHxUn0HxM7bQPF6t
	EHEA8ooBkq+zJB5y1ai2l5ZCMc7vETm/Ftw4cwQfiJlTBZYDUq4jtXfjIn/ySrQQ
	GN3ZR8hlUKewKD1ST/8dh1pmu1ox0q5LtN/fR3bnX0fprzuyje/u5HTpmvkSsmb9
	FBRbcbhmrpAtvjOv/Z5srn2G/8S9FMNAOQe406ogXyh2kWqbZLqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xyu9kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 12:55:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATBxlci022503;
	Fri, 29 Nov 2024 12:55:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 436709fbdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 12:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIbxAYvmUmdxZH0rrGUn/7ZtUVyjiE8/V7FLT6d8cVs3ur2x5rdisk8tmu7imh2+W1/5PSEGNU95gThyYrAahPPbMeyB+ewttZLZfesDRSOd8ZlgS6krbbWEEw9psFyEyabs/VvoXCk6K6BUWSwPUUtVMoeH2hjIPxQw+qwnLfRiamJlWNrMcaDxCLgu+iSy9jmxVNQ7VCmxQiRWwyD4Bj8+t5SoRn1+qMAzQylfKvcxKqU7t5NuKQarAf1iQVGYSvL40rfN36PzuoiMC3PQXCGvtjszaiHW712XrEpFjZxV8kLVVg3EeNLCh17ozT+lsw+NYm0QVU2OYUEgUfcQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDuLoFb/rNqGZsexrF7FNgx4ezFuyx0SaNMSMzT1VuY=;
 b=YRpHF2Phx6oQACSVSzyl2doEmuAYOPg7bm0Wzdvxv0/K2QyiQL6ckos5MNdCAVLumCvx2kLV46hqSwQj4qLEgBKydoS009Ml/8OBqFDIwlxVvUxCKzfOJa+E/44144is1NSkMbFMo+5lY+m+qn5IrSsmR+/pwjANljuxXTq0xwT+++CaePIBN2Di0hx82hmyCKbYNKMnEcrcJZiitPOekc2hmBDLZB2jMOf/9dDTAddqHBfYY1EqXNb0R/vgkFwI9RNZakvsAY0c0J25tMpc6uDzKjha8JJEHfs1oPCKiHNiKrVz40IdcOL/K5Hj+r/4tDzWj2qCRqUlS+OlRkqyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDuLoFb/rNqGZsexrF7FNgx4ezFuyx0SaNMSMzT1VuY=;
 b=jejzEkeIt+HkzpgYzKRQLh0u7y39HpHtUBSVxx7GbpwpRpNY50zbp4jZeOckgQNDxm/852A4lG0kXk8SNrBErdlm+ztFZFyjvusFh/q8faNm9uCjSempJeyBIEGP3plq/pj3mbeRBXey1jYshs9iTojw4qQhUUU2Esw7R0DpdhI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4427.namprd10.prod.outlook.com (2603:10b6:806:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 12:55:27 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 12:55:27 +0000
Date: Fri, 29 Nov 2024 12:55:24 +0000
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
Message-ID: <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 0377e36c-efd3-45f6-6388-08dd1075191c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fPCGIiNA+/2xka3OcwDn7CQ/tecTxbmyGgpt7fLmlnoFK9LVksIHcQb0l69/?=
 =?us-ascii?Q?AYdibbkDTCIqC6qiKwskiJzqWXk8UXqpMTitMXgUxx/YmcTREWh841vEJ0QY?=
 =?us-ascii?Q?aZeYtCU/RRhp8iZAQU6OjGkasijjoONjiyC7xLH8/C0MspUY0wRgDQiH2Lt8?=
 =?us-ascii?Q?ZsDhjp/8YKJtOSVXaUL/bd6NV0WyDaF/W3EXuPx/EWkNUbBeeOL3JGtPIrZt?=
 =?us-ascii?Q?bLHUfy6NvP2y6qzvPEIl8cWt3WFPs4r8pFsnRi6UK8ectYdsOdWnh0W4ZhSe?=
 =?us-ascii?Q?QMbkU7QpcYpjdIDnlRklOWrmsezRGjWI8S8y6JwXJThjsVPUvsjO86GRni3T?=
 =?us-ascii?Q?pZeQvqEAXKp66rEjoSKS5sJwekwoYNYTW6pKNTeQtRM7k3bY7T7aiQUwWyao?=
 =?us-ascii?Q?gi0WCh9ZeEwYbRhbpjS+tr98TJ9/amGTAUF0r8ft7bOBTBROIk4JOiJaV6QB?=
 =?us-ascii?Q?Lqbj6g/joMSNZGLFDZekfXNOhPAe5xzyuhln8SkfvHBfmTWerhVOM7yrPzur?=
 =?us-ascii?Q?oyIBjoiEDLQu87/Tr1a4kdM7w/rjaUB9ywGnzNlqRxhunbXbj5oc1ohS9dAM?=
 =?us-ascii?Q?Z4GyTdomz1FCcB+iZotxSttSlCk+ey6iKpH7iUnquw8r+dF+jlz/6BWwfkQx?=
 =?us-ascii?Q?Ycqs6KLn6pMs/c1CnAgXDtHjeW7ljImGWEc9zuXlHlEQFInm9sr2pnFHAHnH?=
 =?us-ascii?Q?iuJVVcP6mE/a8H9p0HKCbh1uku8Tk8m7ZIqrKW8qBWYsaIIMjrVhKbBNTwT0?=
 =?us-ascii?Q?JQzTXEUXVeUMQAVIX+rcMQzgkQawwjECFjv3FtIH/a1CXNfNxZ6qfQzROAhg?=
 =?us-ascii?Q?Tsq6so2hNqEFpP5kMJv08vD/tUDbqzKzr2zSqC/7BAfcaazpC5X6X29Leq3Q?=
 =?us-ascii?Q?geAD8y9+4ityLscLsaMML/xaxdSTZj3/X2W1VwUT0JncMWgvoRRhk988K8mF?=
 =?us-ascii?Q?Mn3ETacH2YW2z9mgTP4L7MJYrqO+rlrZsWO8uEkL1SgKX7GBcNK2Zgdku3N5?=
 =?us-ascii?Q?1arGx6rZ7wwFaA681pHvOq29ymnfAy3vLrle7xBRLPGjhvqnHF/IOPRIEV0w?=
 =?us-ascii?Q?jcQ5/6FmBb7XQ1ZBlVBuCrj8ha3EbQ5AJgX4paBnpLV/epe3FvDcTIi65eab?=
 =?us-ascii?Q?HZxeOiImfqACSCf196KRe7JU/vPG4+bevrxsHt5Df0gcGYLnK4mWQ2tcyfQw?=
 =?us-ascii?Q?6/1VonEMC0EU+qHeHpqm2gdAGNaJsHHSiwzUYKRsWzWJ+5a4x7cMinUnvVFg?=
 =?us-ascii?Q?YcwTbrINvZxo0gwsWx/52HisQQZK+spVtJSsj0d5TP8Vw5AIzILCdckemVSR?=
 =?us-ascii?Q?bWQTjLAEtnlRzuadTxYQD5Scy3HqT7+3GYXRSAOHFZvhSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWE/RzpwHBY7jJDH6mLxLP5ibG+Jw+X4HviUNIZa5kAjf7LdwAmkO44nexkY?=
 =?us-ascii?Q?ACQ2zbzZCEaxJ9b4rU+4w7dcuH37W+q/AU0I6bN6Z7u6sXPK4QYjaDEFPTs8?=
 =?us-ascii?Q?u0oUDMp3YZw4hKQTdctExbYl4q/3ckwz8MfjEZzP8dvn6cBXCPMMd5sVjXos?=
 =?us-ascii?Q?8NAojsCVyIlBbvqKe8tF8kz1a4wjWWPYdeckKBWgsSztVWqxlSyfbK5uhwB4?=
 =?us-ascii?Q?sSMH8xswxefk7VojzINL5loj27/FE6pjnjt4bOucYHtQ1V1A8T5mERgLsGq0?=
 =?us-ascii?Q?bMxVEMLOMJvwJbNlSDisUPJIZ+qlrGe0UWwbzf5v4WlEAHWlj1NwPcjs/plK?=
 =?us-ascii?Q?1sG+GiGt8SxaMVzewEjOGGbsmHbPjTx6pLfwXFMKFG++KL0ORTp4vRtulD5u?=
 =?us-ascii?Q?4IQmJQcbTTUyflzdWPFs6r9AmwPmTDzFo5qshzqt8qFmJVoUIJRalIqcbeTK?=
 =?us-ascii?Q?2cQhXop7iCKs9vBJBuEUfr49kQ4yCTT3jSB1coc0v+jiu/ovW1ZlzshTu/Qk?=
 =?us-ascii?Q?e/tIz0vW+ldpLGvLO8SB641H4NCPNIlLnzAVuoxNf8SX4N3MmWkJCq7e97to?=
 =?us-ascii?Q?dNCZEwLO8L5whErwFz9IQAhQ4NNOzy5fEYJziWMEwL6nxOVSoCdXCrDyEzCR?=
 =?us-ascii?Q?4UgD+M13BgraVy0UWutQGXxyAsQLN0U2rb5NvMImz0SCGqaRkij9VSu8xsDP?=
 =?us-ascii?Q?FUenrfnGrP4eZV78bYr+ZDA6dL832nLIEFP90WUpAYDLRrrx6nYJEQBiD6o4?=
 =?us-ascii?Q?FK5WIJJh7DVtuHX3WYDYUeRqq03w1UR4dZeWvZhrutnSfyC36f8s81H0kSwx?=
 =?us-ascii?Q?MSwqztg3buL8h0Sll7enfXShGoEnZ6zoGif6N3rZr+boGv+LF3rtWy/Y9rIx?=
 =?us-ascii?Q?obZifZUEL/5go7B7QTDAkUPVaV61FyfXAAKYlPBMzrOstJRYgky4bTkxSOwx?=
 =?us-ascii?Q?9YweE0nIyBdsW74g1Hg/dXZlen9m95Nwk2Pw+KRWHh25VKgbJ77N+5oCn466?=
 =?us-ascii?Q?WCxDr2lMb6bN++R1QVR1yBpdih8BJp30XaNc1i425jKxGjqOV7ixhfd7Z13w?=
 =?us-ascii?Q?ZTmp8dxgsKmGUJctdYAXQmg+V+qJBhVoY/igUpQVI6cDfvDLJS+XtfdyC8du?=
 =?us-ascii?Q?HtrzTVvMayjmoR5riCWQx1cQUMRrNbIXVqzhnGcYXv/rb6QkNEPnRc6yFk1r?=
 =?us-ascii?Q?+V9q33CShsA5JM01sYFcRwB6dTG/FSuR0rueDOtQMFq0/wSD7eeaDoTYgJcy?=
 =?us-ascii?Q?6OXOX0YV0v2YjBITEVIoISP/dzKXDVRTKUn4RAUi4PDtP9/3xs8Hc/28VU5q?=
 =?us-ascii?Q?xVnXeO2VLnK2khqHqLGoK9hDhRCwR/PcGd18KwL26gRbramFlIdFE7bbCzG8?=
 =?us-ascii?Q?xAouiejP/Q+QEdaPNSvExDYZch8CwyfhZdV56v4v0COptXed30f+KgnGfjcY?=
 =?us-ascii?Q?d1jv4kF2s3H0/iNuiJSCMpKCq478grJdxVffJmP8lbIZJ9FIUocw6ElsB1B8?=
 =?us-ascii?Q?F0oydNOVFto1yaeOQsBFSzqy5R7BY5oiR9SR5H6yVI03aP6IKeCn4x6HA5Cg?=
 =?us-ascii?Q?mS04kIa042wpNFgyfZGtnbXMM7gzLJ8nOo4itLt2OM4HvYrLq1iaWi+pp4ky?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XwkHy28UVgDsHVRzDJqvtISUDczfzhMguPGTiagTN3SQX7hI7I/aw9yxfNeVLJVPf0MbbM/aovcRt/TrqLSji90vmJ3NH7bkJA+Fn78rP72epPsY7Fvjj1bbLxaahfVtVtp8IRZ3qs1zwEh6LfhwdRbalXN30xvVE+TFmlmw4kf+PJsCt7B4lWX3BJfF2J4MdVtZQNwX+iToX14HBrQQUtLMLSySwEwAYZMDmyPSuW5hlQA3zgc6NI2AVaPTd7HErVvR4/SCf/wOS6WKJGaiOWT6aLQOSHVL4VFuG1C31yJZhaS/BNXeVFvvu+tl84rBvzGhDX0v3syOEhdgEdxFklZQiSnV+wpqpG2DVklkUyyQFMws7q1cvA4JztP8jvAjfJy1EYdHdLt18D/kWSI/TASnL1CFBIHjN33rEM2ZQARHRBp23mPKESHv0+aNcQ23xkqB2Q+Z1QdaHbxcqUriZB8QAdAb1rg5qIGpytLzdE+Dr/PPQBczIW1UJRPicsLG9oQhjrwZ9iGQLhIgjFb6crChwp+22jq7vjXLk8p+QhtkgwXcFAt1IibzH2bhSZfiI9ipvXatzg9vy82pPy1oGjsh/+9rYY5PvHFRxbChbpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0377e36c-efd3-45f6-6388-08dd1075191c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 12:55:27.6521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJkd35IOwf++mVRUO0svjaYaH/IQVjY6XezVFZb+ZxEHCTHkRToFE03KVcd9MQjqi/AJfrOhWypv1LAqYjPwqO/LiFLvk5Kl0T2SHsOtwa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-29_12,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2411290106
X-Proofpoint-ORIG-GUID: KfiFxxrdtqTqqXfNsMzfAT1s5qWHQYtV
X-Proofpoint-GUID: KfiFxxrdtqTqqXfNsMzfAT1s5qWHQYtV

On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
> On 29.11.24 13:26, Peter Zijlstra wrote:
> > On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
> >
> > > Well, I think we simply will want vm_insert_pages_prot() that stops treating
> > > these things like folios :) . *likely*  we'd want a distinct memdesc/type.
> > >
> > > We could start that work right now by making some user (iouring,
> > > ring_buffer) set a new page->_type, and checking that in
> > > vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
> > > and the mapcount.
> > >
> > > Because then, we can just make all the relevant drivers set the type, refuse
> > > in vm_insert_pages_prot() anything that doesn't have the type set, and
> > > refuse in vm_normal_page() any pages with this memdesc.
> > >
> > > Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
> > > these things will stop working, I hope that is not a problem.
> >
> > Well... perf-tool likes to call write() upon these pages in order to
> > write out the data from the mmap() into a file.

I'm confused about what you mean, write() using the fd should work fine, how
would they interact with the mmap? I mean be making a silly mistake here

>
> I think a PFNMAP as used in this patch here will already stop making that
> work ....

Actually I think GUP should work fine, except if you explicitly use a version
that expects an array of struct page *'s, because obviously those can't be
provided?

>
> --
> Cheers,
>
> David / dhildenb
>
