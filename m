Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738E314B66;
	Fri, 20 Mar 2026 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044292; cv=fail; b=RqBwTAmPgJjcU6IkSEYDpMpDqSlAiuTAb6X43svvWuJSF9bNsra9asMHjPxbPYlPwwoB/DPKA/r1borLP0kaVuJb/3f9znt69Ad67EmvZ0yzK2grKTdMcrYV8veKiTJoTTiQC8S535XOYmZ1eYM3ohWUBmuusfVE8k+vs0ME9V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044292; c=relaxed/simple;
	bh=kF+Q2m5/2HM0ouV8+lea9CGT6k4MigRUj5d42iJ/giM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M8tn2+nksstPp1+3Za0tsmEdNfGI9khDs28RAQK3qAHqpfUBHsyJefk7Zt0fE1SAg+5ZtkhNF6eHRZT5tIqwL5Hbq2Z3A8T/KZHtYVtCgkGjFI1PEnyd++ojeve6Cv7ou34FSCNcUrnfJ6kTcS5rSqDURhGZ8VSiaEz2lTRwK6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AkCZdYIF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WYjtJ2hj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AkCZdYIF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WYjtJ2hj"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KIkYc3135669;
	Fri, 20 Mar 2026 22:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hddQVXyRKy9SCIULLwb49udxRzaEqY8LdLD3ia0OTTg=; b=
	AkCZdYIF5H6vAoSwJzqNxyooGP9A5Wu+SDu/mJGc915Tz0v838Rh7XZ9Al9X/Sal
	K2UJiALjfvi6YW7nj8q4AiALMlLOKgaPdVRrqBlTC+FuUWGk0cQlkVPbKXsB3EhS
	oEX8UDqcX3nD2rRS1g7k0TP7KU7m81nhc/OHMnGeSjACFlUE3RbEslXe9AJeockU
	1NLbVLmSItIixTzQzVEV0noytQkj6HJ8pfkAtigSxeuSxtBdlK2OWTA/ivpd9azW
	A39YXK1jzYR/C/xJz9FlKeKGXtJy/CD7W5BF484W8JXrXIQsP9riS45qSkxjreoL
	0W9a5V7Wf7ePV27Z426MRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf4aare-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 22:04:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KJkrMe002901;
	Fri, 20 Mar 2026 22:04:18 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012029.outbound.protection.outlook.com [52.101.43.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4s0squ-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 22:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaPK2JsrrSouG6pxJDuD3X/3xa/nnttS2tv1FMQzIBsoDbIdS+Wbm+WVSScLoA99+0Yj3Vx6AL7HBmFm1+59Ym9BGww5XvJpT1hzzKRB+Ayuv9HCVYNtajon3qUSyamSwE5hJ0Q7c7M3EOI51RmTXvK8EuOzJk/z/C8IlUn0j8QJ/uj65swBRsfhxFp88i6LWw8INkG5XQ1oFCjWWp7HMrFcjtNAS00s/Cx4iRimYK/zIXn4DDsuGtLshe3Y9hRgoGrtbhypPamuDLwHgvdBxU+aPnApIjYng0cPQJPFP/fSCY3tLAMEY+LPlkSFLzER6Ma7/J5ZQLOSLxWMbCCgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hddQVXyRKy9SCIULLwb49udxRzaEqY8LdLD3ia0OTTg=;
 b=DOLUHu+1we0n4XvdqEQX4j5xx1ausyI7qnHL4bE52qPRCNtuqGVbfE/6WmWs1Uu2SuyBgV9Vd42T/ui3iApJWM/dygdwjZjw1OB4ZDoCyN22kZXQVdYxXSXZ/XxJ3BWySRvoxWMFJh9IiU8erZwZv9gu1g2ifnxg/Bvp0Sjphw0o6txgkeaB2JC9ZefMwFjSnwZAgY6pWF/I7SsFLn03hoajI5hDZ9efEdczpAgguQ1B6EjvDjVHlikZmHk3uqKovI4N2afE2TaQD9pHKzIRTKE5j1fnYEGMNgvBOhQg0sJVlE3c8PaGUnW+MQh/NvjrWyiriHMX+vBtgX5yjXaLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hddQVXyRKy9SCIULLwb49udxRzaEqY8LdLD3ia0OTTg=;
 b=WYjtJ2hjg0q+dmqhmJxjCotbDndbu2AXU8o11EcqZxf51b0KXe69lINAc/JZZrzCYrbcmrKD1GScZ3ZQn2HpmANjWK9cXQvDnT4UEUuKU7TN3BiDWm6PL+vFtEA+XXaCE2QkrVSOf9e3YFrNqqo5wMUNulLWv1MNREu6tzdoILM=
Received: from LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9)
 by CH5PR10MB997717.namprd10.prod.outlook.com (2603:10b6:610:2f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 22:04:15 +0000
Received: from LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce]) by LV3PR10MB7868.namprd10.prod.outlook.com
 ([fe80::9105:4421:4267:8fce%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 22:04:15 +0000
Message-ID: <54dad8b4-87ed-487e-985b-03b99cc3e8fb@oracle.com>
Date: Fri, 20 Mar 2026 15:04:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: perf: add comm_ignore_digit column
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ricky Ringler <ricky.ringler@proton.me>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Tianyou Li <tianyou.li@intel.com>,
        James Clark <james.clark@linaro.org>
References: <20260316175631.3169955-1-stephen.s.brennan@oracle.com>
 <CAP-5=fWFrDaG7dCT2AcEAu28aAPKz6qMtpzmrG+4-vn1NLQ--Q@mail.gmail.com>
Content-Language: en-US
From: Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <CAP-5=fWFrDaG7dCT2AcEAu28aAPKz6qMtpzmrG+4-vn1NLQ--Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To LV3PR10MB7868.namprd10.prod.outlook.com
 (2603:10b6:408:1b4::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7868:EE_|CH5PR10MB997717:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d62084-42cd-41b5-3738-08de86cc9fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|83080400003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0tjsN19bUvlSpJiPuCTOJC/MWuO36+nFGxwZw520Xl7MDP2UeytcJe2he1OTDAucHbMTOETTxvEJ6zUAwgglEUbJze2IEMXnIOFZWJ13RLS6Q+dOQE9EoCUoR1F1zeCPWLOjur7satnGTiPHAz+ulPI6C93MvAdt8KG8OJ8wgRp9cnIPjTxwVU7UuxrQwUvCdpepISAYcjfwXxi32pw3uV6SSh7bZ9xdXwvMHh3SYPjsqBr+xvOUTy/Ky0SVOVXdXvamabr3gU8UdYbBlLnlK8xyIXjU7AMb8TYmn3k8128TS+QnIcGZRVTz2vEN36PxYN3Cg8DzeY6M9iMr18J0ew5TdSM6RIxRHnFMGoXH4ZXMEtxyhP91rG6OschUdQcHhCcGVRVGueWg+h8DRxTV2eLC9EHVLEAq4vKf6fe1tLKz6eGpq4fXynJVxZJ9ZXoV0JgZtm7t2yBZt6Pfn4SV3s9IqXlnwyRvpyuW8d3Y4gfxbzz/E5oXImhFqOh6QJ6kJRBsb2uEHVMVeG0upb3aPN6iKDPMMiAT/mqMX9wNvREffTzC/H3ycqIg0rAOeLbHylIwpHu8P3D2gkULMGGXJCAgXbis9hl6K806U3UbP+/nlvnOG3C5j2jJdrvNdIwuNoRg+BL0pD+p7n8RbdOiB+ambErlOy710PP2s6VIn+JmmuOwBHSDT9i2QFPyMwIXuJiFMXLSlNRDnZ6X904SpEZi+/Ro+mdG71Kxd7KH3pP2bMZJgrURPs2o/ULEqHzo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7868.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(83080400003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGpIMm5jZFEzZmcyK2dpZmRhM1pYWWNVSlA3R2hCa3dJVVR3YjZrWHFOZFRY?=
 =?utf-8?B?RWg0akhzcHZTVm5uWnNUK0lNbk8vbHZpbnh6VU1yUVlmWENsZnVGRnE2MXFs?=
 =?utf-8?B?ekhva1lUUjlTSndhOEE2OEFxcEx0OFgwd3dnbmxNVHZHNkVvU1FCVHYxQjl2?=
 =?utf-8?B?Zm80TGNNVkVtZjJsZmRQTklnL29GOXBBRWkwVzhZNHdaUVJqMmlFWUxqQk9Q?=
 =?utf-8?B?UDU1QjJKNnNlL1dsMGIwVE1CSVZ0R0FSZCt3Rzg5ZDNhUjQreWdCMExkSTMx?=
 =?utf-8?B?SW1GMTQ2S0wvN29iQ3IvWTcydDBVNmR5cFNXQjR4eDdsRzViSVN5d1lqaEVm?=
 =?utf-8?B?TGV2eEM0TnNZUllPSzJVNlJlUklFWDllcHFDeFB4TkROYldkeXd6b0pkeFl4?=
 =?utf-8?B?bUNPeGFSSmtmZnBkU0w0RVhCSWJyYUxreWZETDI0WEllUWNyTXVmU2tNM09n?=
 =?utf-8?B?akNkSzd4VGFWMVZQanUwenI0TFpHd1FDb01DdWdpdkttdDY4a09uVjQ4RHgr?=
 =?utf-8?B?Q0t1QTNaWHh0ME5Vc2pieHRvL2tCN1gzaXMydEpndE02WGg3aGxWNjFVSUdU?=
 =?utf-8?B?Znl5aWExVmdkWXpRRlgwSXAyL2NZVmtQOVVtRU5xYndlSHZoSXlKcGF5eDRF?=
 =?utf-8?B?TXR0enBSU3llMVNZYUtPWUl5UUpRSk1ndFUyN2ZvKzQ5K1hFN2NCTkxWN0Nq?=
 =?utf-8?B?TEdOTDZCcEZiRzBYb2I1ZE9HVFAzL1h4aEVjRklCdkcyNDgrRmRsRkQ2aUgv?=
 =?utf-8?B?cFR6cktZZXdQNWZ2M2J2eGtFWGdZUXhja0ZZdUNFdnFydGVON3pva1RURjdV?=
 =?utf-8?B?L2M3SzErY0lSd3NGN1dnZ1M1RzNSR1RCNTNCd2VJVFpuaFJwZ1VwdGVyK21T?=
 =?utf-8?B?clJ1TXBzVFl2VzNNS0h6K0pycU9nR0VpNXc4ekFRSksvaS9PT3F1QXgzaGxr?=
 =?utf-8?B?Y0VBclZxSEVmSm9RSlMwY2V1RUwyQy9kUWJ4SVh2Y0E3T2xCbmErTnN2d1JV?=
 =?utf-8?B?OVRYSWViT2pZQnFyejRIL3l2V0hMaTdTck9MdHZMMEFKeFhyelROaVJkaEk4?=
 =?utf-8?B?SGdqRjFvTVh3aXp3WHF1UUlPbzRjOGRHSVJsRTBLeE9YaEJwejRoVmRCdEEx?=
 =?utf-8?B?RG9WTGcvZzdtVGNocnFzMHNMR2VhTDNONjVjYjVEcHBQMUhnVjltekpSeVZ5?=
 =?utf-8?B?WFpJazV5cHJuV3NlU2hqZCtzMXZWeEs2bWFMdTNmaTFyMUFOS0FCM2wrdzls?=
 =?utf-8?B?cFJBSmJVU1lmTDhTM0hFWml3SEhnSzU1OG9CY3c3SFdFWVlXcFNtTjdyOVE4?=
 =?utf-8?B?Ty9FSVpyMEVpeWdKU1VHZlpVOHhEZjBveS9WUEV5Qy82eHh2QUNpZlBNVklh?=
 =?utf-8?B?eTZxT2huMi9YWFNrVnZyTUxyN1k0NEdGRW82UzU3MkJQTHh5WVBvQnRYUFMy?=
 =?utf-8?B?UDlnQUl4ZHMxdzFtQlF3SlJrQmd3SUpsM0hPaDNWNEMvbE1mb0s5NWZJbXhC?=
 =?utf-8?B?Uk1IZWUwY3czYjc4YUx2Rm01KzFlaGRiZ0pmUEVaUEdTOXdVeDJzR1FPRnNp?=
 =?utf-8?B?eS9pNTRhUm9SWDlhaHdhTjNvRUFldCtKRFVGUTlGWlMvc0VxeFRPM3I1dytJ?=
 =?utf-8?B?UW9wSlNpU2VQbjI3UytQMGhPMTdUSXROODNoSFlrUDAvdTVWdFFhVGFobXh6?=
 =?utf-8?B?Qk00a1laSlZzUnBxNy9XZDBTWlU4KzlrQzFjZ2IwN2V1bFR5bzNmcFJJT1R2?=
 =?utf-8?B?QkZOZ3VLd01IcmNhcFZXMEdjWDZqRWYreWh4bkFYYUNiUThUSitoek1pYmdr?=
 =?utf-8?B?ZDYrTmlxUk9WSC9SQWpzSmxOcVR6eDBnWU13MTg2VTFGNTVjOE5kTytVVkJQ?=
 =?utf-8?B?TDF6TU9LeU1oT3d3R3UvYkVFYkFwV2JTNXlwSnBGSDhPYjA0SitaNjlZYmpq?=
 =?utf-8?B?QkVNZlVaNzc3dGxXREtzY1pRZFdzOWFkODlhN21Wd2JyUGpPTDI5VnZtYklz?=
 =?utf-8?B?SEhzbEhNaGxmYVlRa0owSTlONFFqY1YyL1BMMUNPMyt6MTFDdDhwNjFOaXFL?=
 =?utf-8?B?MlRGQkVILzlSYllxeitsT28rT2ZEQzB1SkV6VGxmamd6MlVYSXhwNk9XOXlr?=
 =?utf-8?B?QitjMXd0ZTJCdENwNmV1bjU3SHVMNTRYUTdFOEJOa1Jrd0dJQThHN0FqeVln?=
 =?utf-8?B?YmoxazRYZnI0bjhnalcySWVUZEM4Z3NscXNMWW9JdCs4YkRYcjNXRHhrYzdS?=
 =?utf-8?B?UG1iLzdFelFrQVZlRENPcEZ5aXBwQ1RqeGVNc2lDUk1Wd0J3ZThRWUtTdERT?=
 =?utf-8?B?cWFLZnRXZ0o1RHZiWHpDdk1aVjNON2VaSXRXOW1ZVGJVeE9HU3ZxTktabExj?=
 =?utf-8?Q?OteTsHRcOyi9U3Og=3D?=
X-Exchange-RoutingPolicyChecked:
	EAXVgA4sEDD0SX76AAgA0767qE+xBvzc5XDeaMKY0bo4xa4/F9wbXwy/ovwq2Sz9bOkFkIPbCzndnxsUrdZKh+LcUP2vL84hH3DtFwddLQjQlEh4cKvjQOrJqrlrVNUXNXgdFrEOcC29lqzF14Q8Z3G0bCmxuAUe/8JSA+XNwYrH/tilxmIUmWqU/+ns/1HNXF/FWDzs7hpxaaXc165u4rc8SNcxqfBH3J3Tv3Dqu8IavfFOTQaBmEF5DKMXM2cV7Ft6/t3Ow9vse/ljMd6HR8A09vrnXZf2f+CsRW2cChJv7LfJjWW5FnwNZE8opuxGbnlvBXWwWr8lA6Q+ng1RCg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bCRzV1YzhiyCy31DOug2hz4oQ9LNUiPCev1GVx9X9mjPhJaKX1qk6PoYV8TKTL6iLuTHg3A4dne7DVt4GKD3aIlMunOn2SIZJ6WISRrNDCwKsVeoaVsQQR0W+AhUZ5IDymaWY6bTYJuMj6+E06eaSa3KTNSCF6qkPWQYCXBjAWpAVNlaqZySJhuTaPPFaUgKiUxDOODr+uE9cM67ccH/BKpU7e+vi6HV5Pj25vC53J0JiZbZD6Li5PDSlgKqCBx9sYQVLdReljhbjvzJtICM2b+MfBx7UA1u4OnWSDhE9QNdPzf13DSUr6XmmPlf3tWO1EVNE1Wr4EEqJviNPqScw9fgUEjtXUAMNL+1zFb9EP/6A0n6ml3djN5u0dKIG7tGrQsnvjH30x9M0Fez1uCicNi/nmzJqDxYZOJAhwfi8PByqzXJ/APoLpiSGOZvE47JOR25D4akxk7pybfsbo7UfoieOfYFj5bTGj0+tFGWMZwCf0JdbcySSOavdazOOkcMjPCwmEqRgbWth1LzQg+LkG+N0qlybXgd+Z+VowEZzssxMIu4HAhHnD6q89grQhMbWqGzXdZ015UQCSopVeAXI/Ox4OOlfVG66d59TSzuwak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d62084-42cd-41b5-3738-08de86cc9fdc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7868.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 22:04:14.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqMqBP+wUMKDVZXumrva9TvUWJI3wPqh3GO44Bl9Dw3bX9VufzpwN240JctAYZQ2SF11FWXY6N92+blCHI8wapkTSOza6s4J3/ebMr86x6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200181
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69bdc463 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=c92rfblmAAAA:8 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8
 a=DbFGTOWyndj1kSKRH9oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 cc=ntf awl=host:12272
X-Proofpoint-GUID: dzPXmuXesZdu7_H1cJZwN7dOkoilrZIk
X-Proofpoint-ORIG-GUID: dzPXmuXesZdu7_H1cJZwN7dOkoilrZIk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE4MSBTYWx0ZWRfX+ojFDPBcm6KF
 XlRCvBVkDN4LQ+Ut9LfO8euFWM7pLv2qjJXakMJ6P8E+IVrDlvb6jrsOPI+jvUTQMbdRkcCytqH
 Xrl/mgF9UmNun4uHJf0QkhZnrX4XehKgmcw2W5fOWMc0ZUDxzdBqzdDWEmeWEwbMGRanUNABTuV
 txfGEHxtqHbEQJegEcgCYj/crd8pq6CwZ2ujI2vEwHi7Pile3zfSefvgl8ecqrV4KJJ0yxWuAo3
 wDNmrce37x0stUC/aVc8XyGZibR7TwtusNOhAvV0tXpplgcExobYX95DeDuorN5WN+0R8uDo7aJ
 ntNb/FJchoO1M6b1hsWzoHdSJ2Rm+cWJrTqYv79SUquZJ16jBk9rGEhmv1jT2Vdf3fEAvpzTFWJ
 1G3ypDG0762N80Xi0chuYeIW9F2/peKkleQ1RZtfKQHRX2tyjTH8DForL1JNpYCu1PDBuKkJXjF
 7zP198Xs4kWBBfXwk4f3ApAQJ/TmpuNl/ccLiLf4=



On 3/17/26 9:14 AM, Ian Rogers wrote:
> On Mon, Mar 16, 2026 at 10:56 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> The "comm" column allows grouping events by the process command. It is
>> intended to group like programs, despite having different PIDs. But some
>> workloads may adjust their own command, so that a unique identifier
>> (e.g. a PID or some other numeric value) is part of the command name.
>> This destroys the utility of "comm", forcing perf to place each unique
>> process name into its own bucket, which can contribute to a
>> combinatorial explosion of memory use in perf report.
>>
>> Create a less strict version of this column, which ignores digits when
>> comparing command names. This allows "similar looking" processes to
>> again be placed in the same bucket.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>
>> Changes from v1:
>> - Rebased on linux-tools-next. Resolved conflict with commit cbd41c6d4c26c
>>   ("perf report: Update sort key state from -F option").
>>
>> v1: https://lore.kernel.org/linux-perf-users/20260305181847.3249498-1-stephen.s.brennan@oracle.com/
>>
>>  tools/perf/util/hist.c |  1 +
>>  tools/perf/util/hist.h |  1 +
>>  tools/perf/util/sort.c | 92 +++++++++++++++++++++++++++++++++++++++++-
>>  tools/perf/util/sort.h |  1 +
>>  4 files changed, 94 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index 7ffaa3d9851b4..a6e566dda3a15 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -110,6 +110,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>>         len = thread__comm_len(h->thread);
>>         if (hists__new_col_len(hists, HISTC_COMM, len))
>>                 hists__set_col_len(hists, HISTC_THREAD, len + 8);
>> +       hists__new_col_len(hists, HISTC_COMM_IGNORE_DIGIT, len);
> 
> Thanks for working on this! Sashiko is noting some nits in its review:
> https://sashiko.dev/#/patchset/20260316175631.3169955-1-stephen.s.brennan%40oracle.com
> 
> Because hist_entry__comm_ignore_digit_snprintf() replaces consecutive digits
> with the 3-character string <N>, the formatted string is often longer than
> the original string (e.g., a command named worker_1 expands from 8 to 10
> characters: worker_<N>).
> 
> Since the snprintf logic strictly bounds the output to the calculated width,
> will the expanded output be prematurely truncated in reports?

Yeah, thanks for this. I think I didn't really notice because most of
the numeric commands I saw were shorter than the common max of 15.

>>
>>         if (h->ms.map) {
>>                 len = dso__name_len(map__dso(h->ms.map));
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index 1d5ea632ca4e1..ae7e98bd9e46d 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -44,6 +44,7 @@ enum hist_column {
>>         HISTC_THREAD,
>>         HISTC_TGID,
>>         HISTC_COMM,
>> +       HISTC_COMM_IGNORE_DIGIT,
>>         HISTC_CGROUP_ID,
>>         HISTC_CGROUP,
>>         HISTC_PARENT,
>> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
>> index 42d5cd7ef4e23..45662302ed5ba 100644
>> --- a/tools/perf/util/sort.c
>> +++ b/tools/perf/util/sort.c
>> @@ -1,4 +1,5 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> +#include <ctype.h>
>>  #include <errno.h>
>>  #include <inttypes.h>
>>  #include <regex.h>
>> @@ -265,6 +266,93 @@ struct sort_entry sort_comm = {
>>         .se_width_idx   = HISTC_COMM,
>>  };
>>
>> +/* --sort comm_ignore_digit */
>> +
>> +static int64_t strcmp_nodigit(const char *left, const char *right)
>> +{
>> +       for (;;) {
>> +               while (*left && isdigit(*left))
>> +                       left++;
>> +               while (*right && isdigit(*right))
>> +                       right++;
>> +               if (*left == *right && !*left) {
>> +                       return 0;
>> +               } else if (*left == *right) {
>> +                       left++;
>> +                       right++;
>> +               } else {
>> +                       return (int64_t)*left - (int64_t)*right;
>> +               }
>> +       }
>> +}
> 
> Sashiko also notes what's below, but I sent out a patch to make all
> chars unsigned (like the kernel):
> https://lore.kernel.org/lkml/20260306191908.2065682-1-irogers@google.com/
> but it has no reviews.

That makes sense. I've encountered the unsigned char nature of the
kernel in drgn development [1]. It's so strange that such a fundamental
concept is left unspecified in C! :/

I'd be happy to test that patch out and share a reviewed-by assuming I
don't encounter any issues. For whatever that's worth.

[1]: https://github.com/osandov/drgn/issues/569

> Process command strings can contain arbitrary non-ASCII bytes (e.g., UTF-8
> characters). On architectures where char is signed, these bytes evaluate as
> negative integers.
> 
> Passing a negative value (other than EOF) to ctype.h's isdigit() causes
> undefined behavior. In glibc, it results in an out-of-bounds read on the
> __ctype_b_loc array, which can lead to a segmentation fault.

I was curious and tried some simple programs that call isdigit() with a
negative number. Large magnitude negative numbers do indeed trigger a
segfault.

From what I can see in the glibc source code, the table is explicitly
sized and offset to allow the values -128 to -1 to be indexed safely, to
make the call safe for signed chars.

Of course at the end of the day this was just to satisfy my curiosity.
It is UB and should be avoided.

> Additionally, if char is signed, returning (int64_t)*left - (int64_t)*right
> means non-ASCII characters will mathematically sort before ASCII characters.
> 
> Does this code need to cast the characters to unsigned char before passing
> them to isdigit() and subtracting them?

Yeah, that seems right too. It's not great but it matches the use of
unsigned characters documented in strcmp(3).

> Thanks,
> Ian

Thank you!
Stephen

> 
>> +
>> +static int64_t
>> +sort__comm_ignore_digit_cmp(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int64_t
>> +sort__comm_ignore_digit_collapse(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int64_t
>> +sort__comm_ignore_digit_sort(struct hist_entry *left, struct hist_entry *right)
>> +{
>> +       return strcmp_nodigit(comm__str(right->comm), comm__str(left->comm));
>> +}
>> +
>> +static int hist_entry__comm_ignore_digit_snprintf(struct hist_entry *he, char *bf,
>> +                                               size_t size, unsigned int width)
>> +{
>> +       int ret = 0;
>> +       unsigned int print_len, printed = 0, start = 0, end = 0;
>> +       bool in_digit;
>> +       const char *comm = comm__str(he->comm), *print;
>> +
>> +       while (printed < width && printed < size && comm[start]) {
>> +               in_digit = !!isdigit(comm[start]);
>> +               end = start + 1;
>> +               while (comm[end] && !!isdigit(comm[end]) == in_digit)
>> +                       end++;
>> +               if (in_digit) {
>> +                       print_len = 3; /* <N> */
>> +                       print = "<N>";
>> +               } else {
>> +                       print_len = end - start;
>> +                       print = &comm[start];
>> +               }
>> +               print_len = min(print_len, width - printed);
>> +               ret = repsep_snprintf(bf + printed, size - printed, "%-.*s",
>> +                                       print_len, print);
>> +               if (ret < 0)
>> +                       return ret;
>> +               start = end;
>> +               printed += ret;
>> +       }
>> +       /* Pad to width if necessary */
>> +       if (printed < width && printed < size) {
>> +               ret = repsep_snprintf(bf + printed, size - printed, "%-*.*s",
>> +                                      width - printed, width - printed, "");
>> +               if (ret < 0)
>> +                       return ret;
>> +               printed += ret;
>> +       }
>> +       return printed;
>> +}
>> +
>> +struct sort_entry sort_comm_ignore_digit = {
>> +       .se_header      = "CommandIgnoreDigit",
>> +       .se_cmp         = sort__comm_ignore_digit_cmp,
>> +       .se_collapse    = sort__comm_ignore_digit_collapse,
>> +       .se_sort        = sort__comm_ignore_digit_sort,
>> +       .se_snprintf    = hist_entry__comm_ignore_digit_snprintf,
>> +       .se_filter      = hist_entry__thread_filter,
>> +       .se_width_idx   = HISTC_COMM_IGNORE_DIGIT,
>> +};
>> +
>>  /* --sort dso */
>>
>>  static int64_t _sort__dso_cmp(struct map *map_l, struct map *map_r)
>> @@ -2583,6 +2671,7 @@ static struct sort_dimension common_sort_dimensions[] = {
>>         DIM(SORT_PID, "pid", sort_thread),
>>         DIM(SORT_TGID, "tgid", sort_tgid),
>>         DIM(SORT_COMM, "comm", sort_comm),
>> +       DIM(SORT_COMM_IGNORE_DIGIT, "comm_ignore_digit", sort_comm_ignore_digit),
>>         DIM(SORT_DSO, "dso", sort_dso),
>>         DIM(SORT_SYM, "symbol", sort_sym),
>>         DIM(SORT_PARENT, "parent", sort_parent),
>> @@ -3577,7 +3666,7 @@ static int __sort_dimension__update(struct sort_dimension *sd,
>>                 list->socket = 1;
>>         } else if (sd->entry == &sort_thread) {
>>                 list->thread = 1;
>> -       } else if (sd->entry == &sort_comm) {
>> +       } else if (sd->entry == &sort_comm || sd->entry == &sort_comm_ignore_digit) {
>>                 list->comm = 1;
>>         } else if (sd->entry == &sort_type_offset) {
>>                 symbol_conf.annotate_data_member = true;
>> @@ -4040,6 +4129,7 @@ static bool get_elide(int idx, FILE *output)
>>         case HISTC_DSO:
>>                 return __get_elide(symbol_conf.dso_list, "dso", output);
>>         case HISTC_COMM:
>> +       case HISTC_COMM_IGNORE_DIGIT:
>>                 return __get_elide(symbol_conf.comm_list, "comm", output);
>>         default:
>>                 break;
>> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
>> index d7787958e06b9..6819934b4d48a 100644
>> --- a/tools/perf/util/sort.h
>> +++ b/tools/perf/util/sort.h
>> @@ -43,6 +43,7 @@ enum sort_type {
>>         /* common sort keys */
>>         SORT_PID,
>>         SORT_COMM,
>> +       SORT_COMM_IGNORE_DIGIT,
>>         SORT_DSO,
>>         SORT_SYM,
>>         SORT_PARENT,
>> --
>> 2.47.3
>>

