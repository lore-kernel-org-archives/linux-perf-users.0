Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1471F152D;
	Wed, 23 Apr 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407030; cv=fail; b=M/f5cFJHH7d6LIpGW94KVESlF42Od/3MQELur/irc/OYzfhqX0+iTOBCetDDuGmcXjLMKKO22czkFqvKeWcvkvs0pnjZD+xXyjT060vtXqnW5B8vE6IX2E7qfMWMugoxO4avi/JLM06YHCdlw37hEQcGOK/RRBUtCF/40YU0myA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407030; c=relaxed/simple;
	bh=fVuQg/vwY64mopvWlRmNeTRWXAcqrOvhloax+GUd80Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HhIB+zXP+IgpdQ/KI5IHG4JMDW/ulZFO0aXxfafa4HSCSQZPr9bZIUKC3D8+1XNuv+mD4Yel9kA2GqPGOnYNfQyeuVeclzMvTwiL0AVHITkem2H1tmcVodFJ8mGN/Bek9e8E0F4LKAZRfjybFsrlvCweNHgg/jyjtjnYT/a7vuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mw2ehcQL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ee3Cvn6a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mw2ehcQL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ee3Cvn6a"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N8fukh021729;
	Wed, 23 Apr 2025 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=urKoWusy1x1aIzJriPbmp4lIslGSr62h6KH2UFv9+S0=; b=
	mw2ehcQLYV94idyVTVxL9ARUTwE6OaPkDmkRQstN1ha8Xf/HKdNn6T5Dv1xMt8bw
	iVstkb/LJyZQYSbyCQmkv56pxVfJV6BNK7fuKgmqEYpPNhUgxmCW9EA5gXQYu6Rv
	gAEH6bP74wvjqx7XRS5D6VATU8wLgKVBuj+sNqBHJ1t26hMyWbP2d9y6SOQfsSrB
	9ERLYU+nvPEeMA6QN/K0vsrrcd5/eraatLuBvoDd2Zc8uxsl47DaAeHGIm6S8St3
	fP9RvtYFANyUP3c043zgmQOLvCsCBRycxXfbPeD/tnl0MSNjYCqArA7+Y24pEK4/
	w6WrCRlokXN90QZLiE4wzQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdh10s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 11:16:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N9W4Gp039241;
	Wed, 23 Apr 2025 11:16:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jkffjjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 11:16:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyXcs13PzvFHkGpdYJKsslkIp1JPWoJBYZzSJ8z38c3ytgQcL0U9Kx1Z6mZsT46TuoEfIhTNJnBJFlEyPLk4xo82EsSGgsyqDsCV7sTrX+krxNx+CXUqZTbKUN5U8f0xkDLMzNC38G2gmaES7nCJBsLbtM/FMB0cQs1o29E0mYwDdhu8L1G2IjUO2l8HARcH93v2Ol0Ny1RrzZiNs1Zk8EGYBo8Hrde9JvLAsle2ToaIZ7SmdkcGrjPdF9bA9TxgvdRSmtCc/hi7zVH2E7j3A3idtXgNVjVaTUHsGROTJQ2PSGrXAqxNICBXJ+qn/3xlKviZtE2xsXlEHcnjcDbrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urKoWusy1x1aIzJriPbmp4lIslGSr62h6KH2UFv9+S0=;
 b=Pg3+8PnBrbjBR8LjT3Sd5OPSSGq/WyjlCRbF1FD0kFfDaMljER/aHOI/2NxzZmPEyTUkdOWR+9UZ40CRpRLdSjKQy8DeEY4/iNGv9nHSjQ7ECnILzTM6pmlSGbj/6Qb0gzN7W2ACA2fiTY7WIG+DvPFoHd2UXt5TvBv1PPi4Sn+DzGk15z3iYr6Df7HIpZjtyGQr6V5vHypjrzndkCXweA5ZPlEPUxb/X4Mh7RlDSHe7engAWCfGrCVqGxNGq/hI1euaM/4iLuPeMyMw5S0Pr9Y8/dvFb0Z1kTt3uosEvZvOU6r0jbgAuSp1ifl3W/flBHtLOAL2ZUKcmAOddsv46A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urKoWusy1x1aIzJriPbmp4lIslGSr62h6KH2UFv9+S0=;
 b=Ee3Cvn6aRRWB9U6P90L9ScaAQp7935n49QUuG+Q8gKiJjiHZT09Lmphv2DQ37Lyzyat+LzfO+mUXCMhQ+nEDGdplzAjm2qa2yRbGXSOzHR/DFlm+2n74JDCpWmtBIJafdDiizbwQrkblBM0Y0Dlwo1Q0SDJU1F8Ag3ITzgl1Wew=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by PH0PR10MB4568.namprd10.prod.outlook.com (2603:10b6:510:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 11:16:52 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 11:16:52 +0000
Message-ID: <9eefa69e-72a1-4cfb-9f7e-349532f9fb7c@oracle.com>
Date: Wed, 23 Apr 2025 16:46:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Fix arm64 build by generating unistd_64.h
To: James Clark <james.clark@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, arnd@linaro.org
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250417-james-perf-fix-gen-syscall-v1-1-1d268c923901@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:404:42::30) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|PH0PR10MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 864aebb6-f85b-4dee-2a01-08dd82585911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzlOM0Z2Q00xT2xqelEvNmxZM1QwZnVKNU90anM5WUZYN3NXUmM4eitKMVpL?=
 =?utf-8?B?MDBBMTYvSXYyVzRQS0NjMUZCdHprNVhKQVJOcUFtWUo5WUNYOXJDdk43dEsx?=
 =?utf-8?B?YUwvMDRieElZVnhTN1VFWGNYV3VqcTFwaXhlUnVRRmdoZnJsY3NBREc4SWY4?=
 =?utf-8?B?b2R4WWJkZW05OFZuU28vN2U3NE10YTVDMjNPeUtTZ3FOR1dMUndUbTUxWEpu?=
 =?utf-8?B?bHFwMlBLVEEyaFhzQmlaanVjalZTRXpsc0ZkZHVKZTBubTlWOEVnUkVwQmND?=
 =?utf-8?B?bWF6aWZIaGZuYzM0TXVmM0lQREtPSjFkaC92dy8xS2ljQXJNR3NWa0l5UzQw?=
 =?utf-8?B?Z1FmWXlnZFJjRVdjbi9jbUg3ZzlxVmt2aUJkakRwdTVvbHUyTkY4cnhWekZk?=
 =?utf-8?B?aS8xc0dhVklwMER4eUZ3WUlYWXdlV1ovTkFIS1loRzZ2VlFST3l6OFVtY1RI?=
 =?utf-8?B?ZzBwYmkrbDdKd1BwdVBOQWhOaWJVUEpYczBVa2lwMDNMOWExUTFaVlpVZVdH?=
 =?utf-8?B?V2pydmFjL2RqZFhmVFFXWWlYbE0xOE1OOHJTY1kyNEM5ck1vOFgvSG9oTVoz?=
 =?utf-8?B?ZGhueTd4VjFsWld6MXBXMHpSWDNWNnJ0dUNNZHMrdEJNdkJtdW9GWGJ0UnhN?=
 =?utf-8?B?NFRqSW82RnFuTjEwUFpJbEgxSDlFVDRJRTJ3Uy9vejFHMjhXY1J6SFM5aG9Z?=
 =?utf-8?B?SzhBM1F6d3JEZzBZWmVrSWRMMDF5OXNsZEJGNmluSmU3RU9yV1ZpbzZ0b3ZG?=
 =?utf-8?B?NmFodWhnTTFYYzVnNTZpWG0vQW41SHRHdmVHZXFzNkRVZGsvcTNPRERBb0p0?=
 =?utf-8?B?TE1sT2kraVFsU21GZ0VaVWhsNnNlZTdSakZGUHJRNzh1aHR2TjlwSzJKRHBx?=
 =?utf-8?B?bDRnUjB3SW9WaW1GdzlPY2VkTXlMUjRFd0tkSUV6V0F6V3gzeFFlMnZWaHJ1?=
 =?utf-8?B?MmxKZFVCUU1vcW9HRmZha0c5T2ZYMi94TXJFdStvM29pL0pQS1ZBUmh6NEZJ?=
 =?utf-8?B?ZFRzVUppVnlvK3Q4N2JEWXEwYmtmWU9LN1JzVjI0RE11Mytkc1ZaTENJazB0?=
 =?utf-8?B?Zm55cXMrWGZrY1dCUkRjMUZMQ1B0RStEUmRIVG9JYXJsNmlPQW5rR0p0ZmFS?=
 =?utf-8?B?OGM4VmxVTisyNDlidWlhSzQ3RG1GcmRwaHI0Y1Q3cm00QnNZZ0JyTkdpREM4?=
 =?utf-8?B?ejNiRDFzOW04T1ovOU9TQnZkZ0tVbzlBUGFwaW1lakgzWnNTaEdnTm5nVDlZ?=
 =?utf-8?B?WWg4V1Fmb2RxT0lqSm4yNmZYbStlYi9CbnVQQ0gvVkpOb0tVOWlEMWVCODFI?=
 =?utf-8?B?UWRFMUxPU0YvOW1PVjJHYmxPb0s1T2tDcEFCSmRZTDFOMHpuNGt6bkNjT3NS?=
 =?utf-8?B?SDJFT2xXbFJLeUZiVFJiNkxtU2tLSnZmUTFJZmJkZVZvcG55K3l6amF1VCtj?=
 =?utf-8?B?UlR4aHplaE5RQkRCMzVuSTUwelIrYS9BTzIrUlZyMC83dmdqVW5DeU5nWDRC?=
 =?utf-8?B?enVYYndzSmh3UXU5TEltT21LMlkxTkdTU29KT3JHRm9SOHkzYTZZdWhZOU52?=
 =?utf-8?B?dXBRWlFGaVB2SlNPT1lMKzFKTG9IS21iOW9YdnJRRjJPT25FQm1vVHZ5VjZO?=
 =?utf-8?B?VjBOblNiY2sxd04vTUpNWEt0R1pIT1U2TXpWTEZWVDBrUnErLzJRbVhRWFhD?=
 =?utf-8?B?anNuQkIyaW16ZVNPMS9yRit5Ym9DS0VwUnNUaXVsK2J0eDNJNURHclV4QU1t?=
 =?utf-8?B?ZjBod2JVc3UxNHFnNlp1aVVDSjdPTTVYTnBiNzluQ09RNjhjV1oxTHhFQk90?=
 =?utf-8?B?N2ZwU2ZNbmI5N2VMR0VoU0hPSG9VTVdJeWZpQ0xURFhOMmR0L0dMMVBBdTlQ?=
 =?utf-8?B?b0lGZllJQ0J4QURDbFVzN1V0RTN1ZUJMQk5UNjRxZ3VoTWFVdVp2eW5VK2pv?=
 =?utf-8?B?OWlJTWFES2FyL0cyOC9QZlRpTUg1UEtBTnB3ZmN2SXBWemx5NGNORUZ3dFpC?=
 =?utf-8?B?SUxNc3pVMHBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3lYSnFqVjlzejNUMXQ2elM4bjZvSktiaHRhMkJuNWd3UjJJZWVXQjQwaDBJ?=
 =?utf-8?B?UFk0OEFUUlhHU2JNWUgvV21NdWFqL1dQbGd2WHRuZmcyRm54bEoxK0VRZTFS?=
 =?utf-8?B?Q2d2S2Y0WHkrNkFGRzAyUU1VMTFqT0pzcy8xa0p1MGNmT0MvUXRoZGZTeFFM?=
 =?utf-8?B?TlFYdDkrNFZ3SFcrTkY4MldiQjVXa1dkMmRTWlhLR0RMa25KKzk2djZ5T0V6?=
 =?utf-8?B?YTAwME5DYkNJUzBRNjJpdE55U2ZqRmpiTkxBTFRvcFF0cHlWcEhadW5YcDBl?=
 =?utf-8?B?UVd4ZVd1SGQxRjZRdEFXaHdud3JYSzN3YjFONERxeHVJSVFlQXJSbm5SNU5F?=
 =?utf-8?B?QXNFWnBhR09KTjY5dHhibGNxTGNsUncrK3RYOXhOWDJkZzlDc0R5NVEvVFJm?=
 =?utf-8?B?NGdVYis0Q3QzTnJJNVBSNk4ydExJallCMjVGb085a3FtSThEVTM1RUl4bmpm?=
 =?utf-8?B?emVxTHVEUnNoaSs3VmlYaVRXbTNmaDBRcFE0c0J0bzZtd3lZSUM4Y28xU3JF?=
 =?utf-8?B?K2pKSnorZjVTU2NnRXJuZ0hhbFVYdWZvd0Y0OFdBRk83N0hIVklnLzMxSVBt?=
 =?utf-8?B?elBQbDZOQWFDaEdyaGpXWXZmN2JDUEhtdEEyYmJBZEFjZkJySlZvbTFjUGJ2?=
 =?utf-8?B?aElndDhKcjBzQXZuUXRRUCtzNDRWN1JyaGxkeDBBTEkvL09kOGdLZVJoeXkz?=
 =?utf-8?B?NVZhb2dpRXJVWGJpeXRuUklQUldoSUZ5NDI3aGVBLytNbU5TcjlUMHNCQkVG?=
 =?utf-8?B?YzU5dndod0xjbVcyeVRhblI1WXBXcXlRcmhBTGVVeTV6bFpZSlJxSHY2SDZi?=
 =?utf-8?B?OVV3Ykh4U2FwSzFFbkQrUHhWbW44VnFkZDVNVkZ0dS9JSS9iZjY1dDFCWFBO?=
 =?utf-8?B?NFh5dnRPeGdCRTcrRlc1dUtwZW5oVDNUUHEwZDRRRUs3bWpSN0pGMUxuT0JN?=
 =?utf-8?B?ME5oQ2V1eGpPU3pQK2k5T1NhSkE0b2RmcjlNaTZvTFhFZnB5cFZQMHF5ZGFp?=
 =?utf-8?B?U2dUWWptaElTTnZGRTlFdXBnTFQ5bEU0MmhBL1c0TnF5Skk1R3ZpZWdjb05s?=
 =?utf-8?B?U3RZdFIxd2d5N0dLSlRnWFpQd2k2MDE1TCt6M0djYTdEVkl4d05nSmRVWW04?=
 =?utf-8?B?WHdYL09uWEwxMWJGVHY1LzgyMFVSWTV6b0J3MFNDdTlaMFRMenVwM2ZlS1RD?=
 =?utf-8?B?SFp6SnVyeEd5Tk5pUkhwbTBvaGZvS2tLVExqSHdPNWxZWjd6WnN1clFva2Uv?=
 =?utf-8?B?OWJ5SjU5V2J5blV6N3FiSk5ibjRDYmJaMFVQbW5IUkc0MEJRdm8vZHVtYzAy?=
 =?utf-8?B?dit4Q29tSk53bndzMDMrYjAzcWg2QUdVTzltMUZVbUkvZ0dJYjhNWDBDSWs3?=
 =?utf-8?B?K3FBSTVLTGliVm1nRXZoR3kxZVZvd2JVTzJkSVc2YlA3c3ppVXljR1ZyMjFB?=
 =?utf-8?B?RXdrZkFJamNITjl6Z3poWnJhQnJ0OFhJMFYxSy9Id2RsVHVKcFl0K1pxTHgy?=
 =?utf-8?B?b1UwRjJIK0lCRU1qTGdVVDkxS2pEU0JwcEQ3N01ScFdGQlJIY3AxRExtMkEr?=
 =?utf-8?B?aUp2c3A2eTM0VitzY0ZiS0t4NEJINnQ2RDA0VWp1bTRyNjZvUHEwcnNROVh6?=
 =?utf-8?B?dUh2QXB2V2NPeWFqSXMrN28zajFhWFl4T1Jod3pOSlF1RXZlQlFRcDh5ek0r?=
 =?utf-8?B?T0FzTndZczAyS3puUG5KcTgyd2V3QUlDejlsOHF1bXozV0FVY2RHMExsQlZu?=
 =?utf-8?B?Z2YwSDRGY25idHZZMUVZc1l3WVQ3NEZTakhaUWMzM01UMExjdjYxdU5BbXhQ?=
 =?utf-8?B?QVp4cThORmlGemNtYTdsOFFzWXJLck9tZ3VadnIrQjFxR0VkVXNtSjdWTkVw?=
 =?utf-8?B?eFQ4eEk4RFkxSGhlUFJDenhHVU1pcGgrMVQwWjJVNEtNQXdhOFQrZEFUQjA1?=
 =?utf-8?B?eVR0OGFiNDloMjdwRElWdUM2MmhSdVlHbGFUN25CQ3Jsb0lsSUxybVpxanhs?=
 =?utf-8?B?NytkYldQd1FnRXVJbVhZNFlLYlUxWTBkMlk3cDVQOEhhY2ROMnh4cDR2U3R6?=
 =?utf-8?B?VXR3bWxzZ0lhUVUxOU9nREtrei93RStFTnFScVE1cml6enJocEY1TTlack1m?=
 =?utf-8?B?Y3Vqc0RzcnQwMkRYQUY5YkVxZzVGNkZjMnhNZmIza3h2OWowUWZBL3NlYUxH?=
 =?utf-8?Q?NaWnBbdbYCzcoS0Y6fegHng=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pY1zHxvv5BPJFpv+rLRiIOAkJHvNnEppiqbQmfMHXnIMl6rs8tWfd6bw/CYKJ7CI+GJqcUXn6a2Og7MxC6cUC2EypiGcnWAH9hnBaN+iz8O71oRHH/9SKFADIcX4rVtGYS6LTcTz8nxqxw4O3eJhZ98wUCIbzWlei1C7iNCkqZg5sMSh1wBbETwMpHMR0QSdswHupfqQyKLujmiM4yTSmG9j2WV7rflL569Hls1RFs2VDTG7DHuRLO1d6KKE/ABsq2GMNA9pUz/aTTCjorsBsf5JPpNlAvN6Ux8BV8hlOfKfVTfSWYfZlCfZ4vcH3i+L+rnJX8PKJ+lCj+NTPRrfO7/pg3CzNhrZ38DMfLpDijwy9HlASs0tocxQb+um2S/6VTLskmFULufOmXY6d0KuNSl6R8r2u9+kdeJT6MWwXQzXhWFrtxrNrswfxC/xzi9RERmsUnEYXDn2jPsUxouRpGwwn8RTrlCUGu03Hn437jjpPex0w6MSyQZZAN6UiIK0PjnoPKYmAbeBEp616kKNXt1ypwYa8eVjGFYGPpJuhiH9fvF5OKgwYnzrftaYm8tPRtNqY8V0Su613SCuTEHtz4+W3qzF7u+ZIbpBl5Qvd+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864aebb6-f85b-4dee-2a01-08dd82585911
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 11:16:52.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9ClZSEgN1pam3V90eBExdjHtvKqf/OG1S8gpn/743962FJsNbfPEVdEpIW3G8cH97yv9R+95tCXg4eEWv9JtFdpcny1dXgeLOCYrhF1nuSsyeKKzJl+u0AyjUjQiKRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4568
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_07,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA3OCBTYWx0ZWRfXzuBsfzyVdFL+ 2gmeXr1eIZ7GYNUTVN3OoMNlz0WZQeJXnvzrn1KFnyxRNdY5qDVaRU1VEdlcnp/rGPmtdRDdVsX 8P/XNyF1EhoT6f2CMdrcU9BuaGHL2URgyYixiNRn46JrEf2pTreU7JbMcIRerJyljUltpTdlBvg
 BgN+AzXttrA0BnNZcYF5/gx2AohOTMFpJsMejPoNEVoprg7NdEPZ5sjLcxvBQVoJOmNLaKwv3GF tHiO2WDw1fPE9S2ltMMAsVayb2yXxSshl+PdhMFD2wLUwybHObAN5c4taQHDFMuITdsgMLYk0OE A2/wty/DQ/6xvewmPqGRP0vcCNwVRPP+P7vDWDorBBI9jqCIT9Tdb9jy5FXSCf9hVLbFFdlb3Du lYNdHo0V
X-Proofpoint-ORIG-GUID: GuYCL8zfxvNF9l4F5rzImXRSde5Zto69
X-Proofpoint-GUID: GuYCL8zfxvNF9l4F5rzImXRSde5Zto69

Hi James,

On 17/04/25 19:25, James Clark wrote:
> Since pulling in the kernel changes in commit 22f72088ffe6 ("tools
> headers: Update the syscall table with the kernel sources"), arm64 is
> no longer using a generic syscall header and generates one from the
> syscall table. Therefore we must also generate the syscall header for
> arm64 before building Perf.
> 
> Add it as a dependency to libperf which uses one syscall number. Perf
> uses more, but as libperf is a dependency of Perf it will be generated
> for both.
> 
> Future platforms that need this will have to add their own syscall-y
> targets in libperf manually. Unfortunately the arch specific files that
> do this (e.g. arch/arm64/include/asm/Kbuild) can't easily be imported
> into the Perf build. But Perf only needs a subset of the generated files
> anyway, so redefining them is probably the correct thing to do.
> 
> Fixes: 22f72088ffe6 ("tools headers: Update the syscall table with the kernel sources")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   tools/lib/perf/Makefile    | 12 +++++++++++-
>   tools/perf/Makefile.config |  1 +
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index ffcfd777c451..1a19b5013f45 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -42,6 +42,7 @@ libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
>   TEST_ARGS := $(if $(V),-v)
>   
>   INCLUDES = \
> +-I$(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi \
>   -I$(srctree)/tools/lib/perf/include \
>   -I$(srctree)/tools/lib/ \
>   -I$(srctree)/tools/include \
> @@ -99,7 +100,16 @@ $(LIBAPI)-clean:
>   	$(call QUIET_CLEAN, libapi)
>   	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
>   
> -$(LIBPERF_IN): FORCE
> +uapi-asm := $(OUTPUT)/../arch/$(SRCARCH)/include/generated/uapi/asm
> +ifeq ($(SRCARCH),arm64)
> +	syscall-y := $(uapi-asm)/unistd_64.h
> +endif
> +uapi-asm-generic:
> +	$(if $(syscall-y),\
> +		$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-headers obj=$(uapi-asm) \
> +		generic=include/uapi/asm-generic $(syscall-y),)
> +
> +$(LIBPERF_IN): uapi-asm-generic FORCE
>   	$(Q)$(MAKE) $(build)=libperf
>   
>   $(LIBPERF_A): $(LIBPERF_IN)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index eea95c6c0c71..a52482654d4b 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -29,6 +29,7 @@ include $(srctree)/tools/scripts/Makefile.arch
>   $(call detected_var,SRCARCH)
>   
>   CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
> +CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated/uapi
>  

Thanks for fixing this.

This patch fixes the perf build failure on mainline ARM64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>


Regards,
Harshit

>   # Additional ARCH settings for ppc
>   ifeq ($(SRCARCH),powerpc)
> 
> ---
> base-commit: 2b70702917337a8d6d07f03eed961e0119091647
> change-id: 20250414-james-perf-fix-gen-syscall-a8d9b4367d07
> 
> Best regards,

