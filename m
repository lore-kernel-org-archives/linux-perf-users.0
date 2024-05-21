Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110B74C04;
	Tue, 21 May 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291939; cv=fail; b=bCqd3zsl7PqL7sbwhd52cKiH6WPJnkCCu3nnrVxNGG03dmdI+ldk3IZLLDce6RAwohVulHv+YgSclDKJQb8H9uRmrkMwYT9yztJXusDwIplewVe9X2vJE90O8iMdierbTMWykVi/4JtblyFNwlm/6WOpnrqx76WYtbYAwn8ok6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291939; c=relaxed/simple;
	bh=vkuSwsocVFGsX1FypA1fKMw3v9lr4vGxQYR3SDHryNQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JH9D0d7V0WU7iuwGl6JDYe1dFIpXnJQCeCRaDTk1oWWM3OYzYLpnmFnM8dtIrPCFrjj76LKttt0Ehfw9P0JI3wn7M6cU3gx1W+1ShDpCjAbGq1mLKVmPM63pkhkKz9n9U83TSRMAB6LqZU64ru7/8y0paWsT+0pjoVnRTXrOM70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FP2Yd3RL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qyClTgij; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FP2Yd3RL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qyClTgij"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44L7xXcw000537;
	Tue, 21 May 2024 11:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hKAv+liS1fKXbGR5wRrAj7CrMQPZYtnH2M+rjmh3t/g=;
 b=FP2Yd3RL21B1R7J9HS8HwP0S5EQgPRACJpsqb1qgCgNDUKAtYMv1SPuSRma6Vh6MOsij
 nE1k3Os4G9/UBldSIa3udlvCpGoFbkmVIgidO2pzx9tY8iIosAgVhBxH5IAR054uYfgZ
 s7axR5ywBg8WUNEn9u6ix4ZnBPC5fHlyvmQTohZYjteoPQYlnt7Ux/FvGvyMYsnhjlyE
 y9lcuLPiEQd3c0LF884KxzZXGViM78vuOIp4JqWR/WfJ0fe+ewodVjhaBV7xFHOprNxn
 n3dUCqDtRD0qentEYEOnL0vnXhCXdefjkER3uRgDxnvVTHYsRYzmVnJ6hu2C2U48D5dj mA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv51fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 11:45:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LBEOKW004963;
	Tue, 21 May 2024 11:45:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js7t18p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 11:45:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNgo2P/69WiaVO5KevSUsoj+kiElhGcLfO0x4T28z0AiSSujB6OBHHe8KTwq9sf1ZtBrgbTxA6wGNJa3oB7uqA0HnpNnQ/Kf7AF3TgbVwViFwdUi9wpgMZFOR3i1GhXmPqvD0KMhUB1Zlo7UU7K2N9Wd0Cc5ezRln3Ub0uSbH1B632fakSXRYPgzn6BnjTFE0nQuW0E+/760Cvzzgh104HKhv/Nm5RXDVxnyjX90qWINWebIrZJrJ2U9XYR1lgHY9G6p7z11tZFX/17gVutO97Mr9Czf3HIxdiwl+Usa41KHwHoGqsKYo8Iywaqc+u+0p36pF9QZUaNXMPxL4kw5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKAv+liS1fKXbGR5wRrAj7CrMQPZYtnH2M+rjmh3t/g=;
 b=jjGGpOl++5uL6cOzmViQOCXLjwUMHbACRZlWbvoy2GjuKaWuH/BLyDBGm03QF4xQPJnHVhobaooSbSAhVyrif349uuOHdSLwuFZV50NduwLa4in1heyvNnIAlXABaXbXVYFJ31ObWz3tyRBfmxAFXe5KAKupvblzD4fB9sgnPuR0tvGGjN8dab41wNEnxCVOVufiihFaumRU9IXEsVuelUPOJ4MQeDHdik5O2eNCQVHtc3Ficf0DkvP4R0B98yDuvP01fm7RjtyFTIVnxuyIqD5I7lhwEJpO38rmllNqrUTy8+IUQrO8sJiVnjhLaRtKOhS6/edxOyrLQ3jEYjIMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKAv+liS1fKXbGR5wRrAj7CrMQPZYtnH2M+rjmh3t/g=;
 b=qyClTgijuUzskEcTL6zWnsfla466Ws+C0onslRgoChefmeBIVfhmgVm3KP6hjiUI0+rV9OPgLbjkTWJWQUgJgvxwPDYQK+KR9ogplqHjJt6RhTxYm2WOlUz1uj0L/PGiWQ9hdOGFAzLiSvh8odC4WYWfukg7395gmkpQ0uNFyMs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 11:45:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 11:45:08 +0000
Message-ID: <e3e483ff-d160-4bf2-a1e7-ae541c59f63d@oracle.com>
Date: Tue, 21 May 2024 07:45:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf jevents: Autogenerate empty-pmu-events.c
To: Ian Rogers <irogers@google.com>, Weilin Wang <weilin.wang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sandipan Das
 <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240520203643.182920-1-irogers@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240520203643.182920-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae71813-4338-4f6e-240d-08dc798b76ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|7416005|376005|1800799015|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cElrYklET3BpK0J5eW0wSkQ0bHJqNnRwanpIdlVIZWhuNjUxQUtIeElSZWJV?=
 =?utf-8?B?VkZKYmEvUlhjT1BUdWVxTys2U1JLNy9EdTZwR0JaNkpmMHk5RUNlTHd4TEkw?=
 =?utf-8?B?ai92MlkwcXBUOG1wV0NqclFycWJ0bXFTeDdqL1dRaWlyaWg0TzZiOFl5WW4w?=
 =?utf-8?B?anM0LzNNUmN0Y3JFYnQrTEQyUHVidFEwWDdNUUhNUVU1OWd5WlZpbmtqWE9D?=
 =?utf-8?B?V2xsWmNzU2laK2lIVGlOTG9RZUpNUytIbWlZbzFOUmZic0RsVUZkcy94SlNa?=
 =?utf-8?B?cGNJN2pxOVdGTjc2dWRkbFM4ckN4dk1pdC9oL1JuM0tuZU5UdU56QlR0OWpN?=
 =?utf-8?B?eUhQL3lQQ2JET3duWWwzdDg0dVdrZWFEc21oRzh0VktUZGNOTDVSaHo0WHBG?=
 =?utf-8?B?T3NIVW1acmZvb0RuTUEvUnNtOHpJY21ackNlcjBkclU4MXIxTE55NUlldEUy?=
 =?utf-8?B?SkF3bVpBVTdjZDE3ZkVhVWdUYjFsV0dqbFVSVXl1WGViNUYzWCthNTNqd0p0?=
 =?utf-8?B?ZzRWMitmUXZERmwvOWxPWU9aTm9vU1FlZWhvelVKcDBqY29NL2k4T1hPbDlQ?=
 =?utf-8?B?R28yYlVSakZoK2ZnSUlXeVFNZER6RkZ4UVVWYy91T2pxMDVmWXBhelFSMTJU?=
 =?utf-8?B?aEgrc2czdWJONitiYzlwc1FEOG5XOEZhNDhBcHpLSzRJZy9DTmNKUWFjd2Rq?=
 =?utf-8?B?b3JudWorZ3o0b2JraVRqQjRTUDJPaGJYRVVhc1Q4WnhHcXVHUlc0QWtMYnNJ?=
 =?utf-8?B?WFJqaHJjd0NGK0tTZGpUcnc0UHo0dEEwYmtLSW55U1hpVW5oM3ZYTkgzOHJu?=
 =?utf-8?B?ZGF3b0E2REJaK0E4bWRzMC9tNXp1bEVwdU42bkkydVBYVkJwM1daY2ZRQmNE?=
 =?utf-8?B?VCttcHVGVjl4Q2hqZFpTRVBNcldYZ0tyMndTcnNwb1VHUlZBdzBQRHNGWkhL?=
 =?utf-8?B?UDlRRFVvTW0vbEhoZnR1Wmg4YWlaUmh4Nld1UWpyVmdaaFNtSHRQeWF1OGR0?=
 =?utf-8?B?TkwyakpvWWwxdkR6ODgyWU5GQkVlRlovV0czODlPUHRpcmkyZ2t3RXVJTU5o?=
 =?utf-8?B?OEZGRTdEQklwT2dxU3R2WDVHZFN6WjByRFBBSzNnZFFjQjlicHhNZ1RMRnNn?=
 =?utf-8?B?RVUxdkRFZjFCSXVjQ1hlT1ZLaDhqSUQ2bnNOK2Q3RXFoenk1elpXdmhSMHZL?=
 =?utf-8?B?V2c1cFBFbjJCenFYUTBQaEpFbEI0eTlMM3R2WlZmcDQ3d1JBRlhGdXZsaTZw?=
 =?utf-8?B?Ull1T1dNMHVCQTNSb2h6cUIvc3I3SFVkTTNVaEo2cDE2MSs1UW5DKzNFcXJv?=
 =?utf-8?B?ZUxlMU5MUllpdmkrZldBWTRQYXRPWVpYbUszOUowUHpjOEs5NGxaT3hBdmJy?=
 =?utf-8?B?bkNla1J1WEpvUUhBMGt0M0g1d0RCVkgyc3kwd1liZUJkNVkzZE55VDdWNTNi?=
 =?utf-8?B?cWhvaGI5YlpxOXYzRzI0cFozOGVRcER2Y2xDUkFsN2Jna1pUNktTSU52RmM3?=
 =?utf-8?B?R0RVZHdKRkUzeFZZR0owaUo2VFJRbkZsRVNNZmxUdUdCeU9zZVBUdzdlSjRT?=
 =?utf-8?B?a0U4VWZSR1FaOXlMajBCeWFmN3BXemJEWE1Zc2U2NDVRRGp4RFUvaU5DTnJ2?=
 =?utf-8?B?Q0w4VDB2Q0x6WUt4anFtMVRRT0xudHlyZUUvdWh1enhjZElIM280bUZ5ak5i?=
 =?utf-8?B?THVSRE16a08wV1JHdm9CUFo2Y3J5T3JlTHcyR2ZhblhsOWZ0c2Y1TGcvZXJv?=
 =?utf-8?Q?1UJbuSgKobfFFJvhLKLVeLtZ5CpSiQLVh56fRXg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zk5yZjV1ZTdHMjlUL2kvN21xY1VDeVEydU5NOFlHVjhNR0tYcjZza0VoTWdP?=
 =?utf-8?B?eUhTT09XeWwrRzh2TXpxbjNoTEEzUGFqZUNldGdEbThINTVkOTZnVnM5L0N0?=
 =?utf-8?B?SjQzd25CbnA2MHQ2cklaaFZSV1RUSnMrUy9lbnpSZnNicmVDNEJzK3I3N2Zq?=
 =?utf-8?B?WW9lb2VOQitJaU04MEd0bTcvZjdOclJlYzZCN25peEFsT0lGVjlCMGRWWmJB?=
 =?utf-8?B?M1BkcjZXSWxOVG95Qjc3R0FDUnp5QWtGQlVsbmExQzVYN21SaDlsTVBvVldr?=
 =?utf-8?B?ZTZlbEc3OGtJMStjd2lWUTlnTDlnVWVwT045Y2E4K0piUTFrK0tPOVFLeEJr?=
 =?utf-8?B?Ni9xQXBtaVZqOFN6Y1NNMHlBcXRqdU5HaFVFMndjbkxrMlZ3YWRNaVhPTUht?=
 =?utf-8?B?TzlLNGR1WHZEMVVVTTNiQ1JlSFpVQXo4SURiSm00OW53NHVnQnhpRVFrMG1G?=
 =?utf-8?B?d3BpT2dObkU2WmRBNjFRVjVQaFNYeFo3dWUrVlBia1JXR2k5ZnVaNUgyTTQv?=
 =?utf-8?B?OHN3dTRhS1hNSjF1b245eE9OSVFNem11YjhPYWdIb2RKaUlFblpNSkI0MWJs?=
 =?utf-8?B?Wno1d0NvK0ErejF3dW1RU0JsREFqMlVJSDdIK29wWDJzT2Z4aDIwdlJFTXBG?=
 =?utf-8?B?SGt4Ung4a1JYNXQwR0ZyMnhXSDVEMWkyQSsyWjIybXZMWWhwU3ZZdWRBWUpL?=
 =?utf-8?B?VlhRTi80bVJBUlFXcElLb21xdlVIUUVEdmVVbzlMSW1lK01OU0FhZ0pPK2R5?=
 =?utf-8?B?RE1xeWQrek5udjdjR3RuS3hlZXIwcko0OXhvMEJCNEZYa09CQ2E5UnVCLzB4?=
 =?utf-8?B?V2lJRGREWnBWVFAxeHU0L3FkTjdMbWpQYTFjU2hjWEc2WUVXWUp1QXpRcHpx?=
 =?utf-8?B?am9WcWhhdzJCckxMTmh4ZTBOZzFyY29pSm95MnJBaS9ab0d0VWd6Z0JJNGFK?=
 =?utf-8?B?eUwzYklWa2lQUnZDWFNvbmdBYlBEUWhGZGpkQy9VYkd4bGcrWEZ6YXZvTXQ0?=
 =?utf-8?B?SmxXdU1VS01ZTlZxM2tXazJkOEV5UmhpbWxCUG1QbHh3YnFmZVpJSFp3ay9o?=
 =?utf-8?B?VWZua1VnSUVmZHlYekI1UmpoNkVRWmRuZGhPUlRQR1dWWUprWThSQjQvQk1i?=
 =?utf-8?B?dlRWY09KeUFDckhiUFNYbjhnMCs5eGpYdUJJUkM1RmtLb0M0a0ZnOFJCWFJt?=
 =?utf-8?B?a3FXUys5UXFkMWVua3d3dktnemt5VUdSUFlqZEJ6WS9ENXBubG8xSGRIN1Er?=
 =?utf-8?B?cU1hN2luaFp4Z0FZTmtSTm10OG4xQ3hEbjZtOFp0U1ZQaFFmbTllMEZkUzNj?=
 =?utf-8?B?SjdUUnhadE1hTjdyWTJUaFFRQUxKbmJ1ZVZtVGs4emwyd2l4di9BNkRTYzFy?=
 =?utf-8?B?dHpaYmsvWmZIeGthMzZqM2JFcDNBUXlORGlZalE0b0hiOUo1anpEYWFiQWhE?=
 =?utf-8?B?aWpBdGcxbmplY2t5ZEQ4UUlFdG9YYUZndSt0bmJvNEtRRGZxNUo1bzdTamVX?=
 =?utf-8?B?c0hVSmQybkNUYTBMM0hMdjlqa01HYkxYMmIvM051MU0vRXdlTWdWbW1TbTQz?=
 =?utf-8?B?Z3VlU2Q5MDE1dVFHTlZkYklXNHhHNlBGRSs0ejRNMjhMWjF6bWZvMlZrYWxW?=
 =?utf-8?B?VWpkaVAxRXFGVCtMR2tOeGhPQXh6Zk0xMEorazArR0hCdHhSYXVIT0RwN0F5?=
 =?utf-8?B?TGNEYkpQVzdSVjN2ajJ4dmE5T1VYcFVsSkJKeTcwa3VVRFp3am43ZGQydEQy?=
 =?utf-8?B?OGdiZ0tiTUV5SWJyT1dtSXdjNXB2YjBPbk1PTmgyMG95SVVORThjZXZoaXNO?=
 =?utf-8?B?ZitxaFRNdTRMbFhnNG5ZK2wwK24xOWl1TTBHMVlDeWpkU1BJd0FndGFYc0Z5?=
 =?utf-8?B?UThRUVVGMFVNSVhyQUNyMlI2SEYxWnNqTHQ3aUR6dERrVGZhcy9VclJIR0Ex?=
 =?utf-8?B?YlFIdldRSUxhYlZzd2ZqUnlKYnJKOGd6KzI4UWpQWVJ3RXJaRG85bDNoamxK?=
 =?utf-8?B?RGlJalBQV1pncTZOQWpQakszTEZCSU1Hcm9LTUlYc0dHdER3WVk2Z2VPRzJI?=
 =?utf-8?B?V094aks3aEhJdjJnUXp4RUFQdGxMSncvdnoxdmRIeW1Lek1nRDFHU05VbGhl?=
 =?utf-8?B?VkhyeHhUMk0rZ2ZIYVg3N1Z3dXYzRXluNm9CdWxKZUs4RlVpSFJQUWpNRWFZ?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZUc1A82T5A7oPrnCa+NeadTAjZby/yYx4UWaswSyauortBPWfZCmbX0wD3P28yuNxNb0S9NIjF/mhdt+nouYosv62dqLiZRFDaqWPBPyjAJcqHCpJCPvgu1pEfAynKnrFHlndEtgfn921nerz3qjPBwgJSROSTbe5qVt8km10d8OPXxM0uBi0NrNFGiNMl17FdxxZijmxuqKwNro1uGBQZAxK6qjlvWkGhsGKRt8oAslbKVhX6W0PVWk/hKgSobc8gsClKoGfPZPAe/YrUVqshHXgJieKxz7K7bHjA5DwYJY4Nk65ZhFQSTcnBxR2zbZrpeiRJ1na8PUv74QFLsGZEfgj0WHcRtqsZRsPVOdTiR7QYReiK81p4EVAxOBe66pUujpEZEbmoxJnYAe2UjQW8cFjfwWclwbXyh/sBz7/OK3UIaQpErROv/6mpOZdGk5XpHOspT46gPqy2/a4vCsFuwNtMnvoaOgVwR4L09HYpLumUCBs3bZSOZfU9XEdFv98LHThW/fQqM/8oQ494zg4OmSNrLCfbGBzOIeE5u2w5tBo3YlACCWrU3XKK5ovPZMZIAvHHYgDoavMZo5OUa/bjGh3TPwb/CNT0LuAPmMrRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae71813-4338-4f6e-240d-08dc798b76ce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:45:08.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5RT8gTScHAJMzN+OaJskSk/69aa98gT4t7/uwTrCXM4GxDEF7FdccLv2OrW5wDmu79oxXJ3/pgRPyUtvjG+7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_07,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210088
X-Proofpoint-ORIG-GUID: BJdGZN3O9wH2LmZJ4MtDok4Tz57dIM1N
X-Proofpoint-GUID: BJdGZN3O9wH2LmZJ4MtDok4Tz57dIM1N

On 20/05/2024 16:36, Ian Rogers wrote:
> 	}
> +                ret = pmu_events_table__find_event_pmu(table, table_pmu, name, fn, data);
> +                if (ret != -1000)
> +                        return ret;
> +        }
>           return -1000;

what's -1000 meaning? It would be nice to use some standard error codes.

Thanks,
John


