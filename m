Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C71EE7C6;
	Thu, 30 Jan 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272148; cv=fail; b=SvXEG3vyYWnT/r1x2FTglzD7krtMTuxHm2gBToYMecwcLRD2UXTdbwjum94Nh41hu6T6h+4jKcG8vn4qrTqwk9g917XzzRmoN74Gr3NaIChRTKWmcO/dVPM6qvjp3vuK1Fe3JlHQ9ZhJbCe0o9wXkknbJjLCXFICyruEfgf1u4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272148; c=relaxed/simple;
	bh=dLZmwWA9/h3/t+DEXZwDHPl/1eX6WygR1VyHRKlJlsg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NSoo15FKP+iPFSACi00jsQLbUIcuslrtNBDhaq3IFbBn6QlFCaHtT/7ZP29SKyQ9S1Hk12zQaJ6HFC1D5ia6BzgAjnuQ583YmZphi/sc60jl5UuxSLtM2oeLQbwjYhQ30WEeq/1OK6FxvgAOK0YTApoK8P+UB5tu9G9H8MJnlrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H4ATQH18; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SsvZbDS5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H4ATQH18";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SsvZbDS5"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ULBgip031832;
	Thu, 30 Jan 2025 21:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zRS3HfrwFa1HXbg0hcRwHsToTqvOIXq5CifHFy5MpfU=; b=
	H4ATQH1856YVi5GRpwa1Q1GNDNV9uvgX5LOWagUz30evK8Go8lvAsSmxs/Caw6+8
	M/39KMbgZTP7pknYxTkwVi4KKgJ5hOj2DAK7cOz28nYwZCaYzsZW6EsJJIeWb1Gd
	6VHO5DuGV/RC+kF1LIo5Ap8rw2x4lch0iOMmPfYBsfKSWyXe1LoLBuY99wSMWuH/
	Va7hR8C18xP+KvadMvFaCWUTFVI2GjaCCH5vWD2OK0jzOaHkOe66mmT1NilhLzFt
	WZt2rqvDnOUujMbPtZ+wr7rAmQtIVdhjaiiAhUmBYAr0PuthL1ls2+YhoA0fTced
	8K2aoDCmHt2IsB49UCytYQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gghqr2y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 21:21:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKshGD016688;
	Thu, 30 Jan 2025 21:21:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44ggvjgwmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 21:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgiWHnEenHmWDQ7ZhNa2tFrZSmU+fG5OntZRanpO4FnrE7mhWYTeBKxksdy3TJREKpH+DO9X4OKpjFk2/fHGVIvMmaOnyRjhJwqT5XV/V44oUTSEF40AMTF+FftWrra6G8S6MGe9gRqQ4DQGMrp+AMQFKv3yU4GJEcnqF2ojSGOM3QJ8P1gV6EziBFQqwOe5SgflW8zR7XUBPnYrYwmHrmPCuv8lhXbl+LoUjkDWoFj2k5Ywia7ta8aZSBhAwJVjE5OPRP0pvPoa8m2PX+S3KKbmkBQfpghzcORJy7qGTO06QNhG89iiKwO0H26G35ks9RCZjcqy3XO9thVV3TYhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRS3HfrwFa1HXbg0hcRwHsToTqvOIXq5CifHFy5MpfU=;
 b=dIunO/9XMHws4sMG4MzvIKsgPWUx+wS7CBI/os/cokNHfKRufVDTkYY5p7Y5Hr+7rw5kkhBroWkgTAutfgq0gj5ETN0N8n+3RPMQFnEi8HjKqxleiTLUSYhwprP3v01gpCJX1e/jSAGYT/3R7HebpJpA8IyVmKNUQH/lwMqYA+wpv1Hb5uqN5od7Sgjq3vfiHd2vC5rXzeAJ+kW6ab7xLPZqq0BTV7//mKWIaEq9RJKS+2OqX1mzNkkVia0afSwM5WY2HAM0XIt36J6fBe6pHmhV8Us/jVikYlINOeJKi8MpZqK4EQ5xkK0D1EhDlfCwFKxGKQ7UtMdFcYGOawDJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRS3HfrwFa1HXbg0hcRwHsToTqvOIXq5CifHFy5MpfU=;
 b=SsvZbDS5gllKa+JajCDdQ4YVncG9tMFlTd4YfWmfIz+rSJW+WXXRHfoE0Wcbf3PlFUZ+whE+s9mxB7xxyAlW6LxdDIwSgDdJ2VVAQCa2H7VGMX45owQOzP0XNqrS+5SQl0uFcDWErPob5knG7dpZ+rVwLob/7gxJeMlJzFUi2h8=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by CY5PR10MB5986.namprd10.prod.outlook.com (2603:10b6:930:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 21:21:25 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%6]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 21:21:25 +0000
Message-ID: <12cef882-b5b2-43e5-9d78-abe4354069dd@oracle.com>
Date: Thu, 30 Jan 2025 13:21:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
        Jens Remus <jremus@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0210.namprd04.prod.outlook.com
 (2603:10b6:303:86::35) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|CY5PR10MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: ece627fa-be1b-4eb5-1b39-08dd41740d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0pzQ1ZZbm9KbmhxNVUxVGlRMm5NOEprOTUvYkE2MlJhN0ZtUFE0amtJbjdB?=
 =?utf-8?B?UlBjdDlidk1sQUR5RFFsanJLazAzR0VDdEM2a2xZeUhGblhWTit3ZG1ybDNM?=
 =?utf-8?B?Qy9mMm9ObWtaaUZMVEtnOU9VYko0anAyVENhZW0rN1l4eXYzeHdQQ3BqNHo1?=
 =?utf-8?B?SzF4K3IzVmFFUVo3WnpBWFBUSkVsUlhBMWtxNGdZWkFKMkR6Yko5TDNnWEYy?=
 =?utf-8?B?YTNrdVcvMkZGa0tUOHErYStCOG5vUlozcVBTZHpFRUlycEU3WnFKWThubXpR?=
 =?utf-8?B?RkpsTStnYlMyaW5nVFAydEJqWUJ1enVLZzlpMWNuMkUvRlBvWG1ieTIyTFVk?=
 =?utf-8?B?bDF2QTJaSFdhcXJJQ1U5dlVIMDJxMjVPUTVrNndMcHBlcWpBSXRWUXJwSTI3?=
 =?utf-8?B?MmNlSzdzNVBhUjVudFBMMDhyaVZsbHhLeVRueVE1aVprYllDNlVocTgrTGh0?=
 =?utf-8?B?S25HTjQvWkpEeVI4YkZxZytSM2FZTyt2SE13Q00rVnVDMXZZNWVqZEFpTG9s?=
 =?utf-8?B?Rk5pTHhFTW1qbXFiQk1Bd1U3K0VJaWlVQkFkaUFYUTV1WW5TVlBaOXFSaUl4?=
 =?utf-8?B?WndOcmtzRlRrMHNzYmoxRGhXdjVpcHVYSTRqcUgzNmlraFpuR2g4TmFTRkxh?=
 =?utf-8?B?UGRJbUxWalNWUWpleWoyekJLWmlzWFZNTngvcFBmWTV6MWVWOU9nWGYwTUxL?=
 =?utf-8?B?eXBnQWRLOGtPL1ZGSTFvaEdCN1lmd01CM1NnU2l3Qkd3VWt6VG5Qb3ZNMUtG?=
 =?utf-8?B?WGQ5L3VlbXFodUpXRmpQbFZGekYyeWFqV1EvRW10dWtxSFdiMzlGNkNFdVhk?=
 =?utf-8?B?SG0wMFF1YW9pOXNPd3RtS1dYOWo4Vy9PbUhsM0ovQ2EzQkpKTXJnTDN0MEJF?=
 =?utf-8?B?ZTJlY2tCVnYvcUxZTjdrUEdVZHoxYTI5SFp4b3p5SldmZ1JWTy9Ja0ZLajVu?=
 =?utf-8?B?UldLcEtaZ0pMd1JtZU9iOENrOUp2Q3ZLb0NFZlNDeDM0RDJDbElCSllydWJO?=
 =?utf-8?B?bkRZYTQ1aXVzeU9XZHJDVzRiQ3FubjkyRGoyNmVqMzR4T0FueG5WZGlZdm10?=
 =?utf-8?B?akd1TFUwaVZySDRlRXEwVFVtTlFRRVVDTSs1aUNrdDVTWDZUekV6STc4Vzd0?=
 =?utf-8?B?S0EvMXNhUFhRSEVnalY4NXFBT2FmS3UyS3U4U2kvM25JZk0zdnZWL0ZsZjNW?=
 =?utf-8?B?MitsK243cVFjQlZmSE5CZWMybVYrbUxCL2dVNnVHWGpkWUhBWnRwNk53ZnhV?=
 =?utf-8?B?OGNLRFVTaWY5amg3R0FVNlZsR2wzU244T3EzTXhRKzE5Y2tmOWZJZWNGMXpH?=
 =?utf-8?B?YTE4QjBHdDBLV1dPcndJaTVnK2lVb1FuTDVxODErbW1nRUkxU255cmc0WmFy?=
 =?utf-8?B?WUdxRmRaSENNTmJVZnpKb0xXc01qTFNMa3FYY3hZSW5JYnRVN1UrRW9rUURq?=
 =?utf-8?B?TGJWT2ZuS0hrMGYxcmRnSGgxVGFCZ1hnS0h2dERIaTFiaEpITCs4WWhLK0pP?=
 =?utf-8?B?ZjB1Z0dWVStVbTVFcXM5R2lQYmJGSkV3ZVRCTlJxdGZZM3d0WkJYQnd4cHo3?=
 =?utf-8?B?aSsxaUFXVmp4aU5mM3BNRTBhaEpXL0xOUWU3TERydHpVOFZFeFhGbEo4clZv?=
 =?utf-8?B?WU9hbVU5Y2NyMTdma0FZWm9HYXR1R0ZGNUxRN0xMaU1vZ0hSRjRBT1czRlVJ?=
 =?utf-8?B?RWhzZ2FBRTYzTHlQZnBHS3VrcEpTcXFBZUpkNXFsZ1RYZy9jNkhEeTNRdlFo?=
 =?utf-8?B?VFRXbjUzb1NIZEttbDBtNlhEQzJoOEZLUHNSZW5BejY5b01ubW9rSm90V2tP?=
 =?utf-8?B?OFNvMDk1TVI0WktFV04wZ0FGWHpzdnVJSlJjUUVnVWF6SWdubnNCM2VhREs0?=
 =?utf-8?Q?5Mw87XCw0grzc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWYwWFQ0OUFmaXVpVHBjejJ1MGpvbVVjd0NjeWhRVmlDN1pDSXJ3U2FkSVhx?=
 =?utf-8?B?Z2EraHJCZGpUOXNIY254YmJ4c1VlNzZEMGN1RGFlMHJFYzQ1UkJ6MXNMNENT?=
 =?utf-8?B?bjRkdlF4TWRkS09iYS83cXQweGk5WHAvL0hlRDh2M3F1dWxsQzIyYjdIRXR1?=
 =?utf-8?B?QjJXQWpvdTBEaUVpc2Z0ejZ1amdTK3JSSTliTmQyVk1sK0dTbFQ1K2prQ0Fl?=
 =?utf-8?B?L0l6dEdLSStOZjV2K1FZWW45Unl3aG9GMmdqeFErcEw0TlNlT0t3TVNmVSt4?=
 =?utf-8?B?dHAybTFDSUJobDNOQS9nd0V2cEtUZ0Y1cEJCT05JMGFhV1J6Y3gyYTl1VDYw?=
 =?utf-8?B?bGhhdWxWa3YwMEY4aXJac0RJTjZ2MGdYQStLMUYwdWhZaSsyVXFOSWhBSFB6?=
 =?utf-8?B?SS9wMWIyMjVXOTBLNE03bnlKZU9JMllVVFNMYmwyVWV1ekphRGYzS0NUOVFy?=
 =?utf-8?B?bHFPajFuZ0w4TStYSUMyY2hVUmZFT0kxTU5lNmdMaUhIbDZHc0Nhcm9WbVRn?=
 =?utf-8?B?eWsvR1oyK3dJSklpa0RockpQZVF5bFAzUmI3a2ZodWxuMjVLTXNiUGZSSGdx?=
 =?utf-8?B?UXpSRGVzRXRpc1BkSzZPK2FWcFlZUmp6SlNlY3N3QTVoVjNZbmF2a3BRSmt3?=
 =?utf-8?B?M2EvdGNLMFFCaDkwZC9CSGZlTGpPU3dYR2ZzTVZsSFA0dGxuTk5ZM1NwbFd5?=
 =?utf-8?B?bmxCcE41dkVuS1hyUksxamVHRFE3S1oxb1JMcWtSVDJkdVdnQ0VnUXB1RjN4?=
 =?utf-8?B?L2FFc245cUpiUlczL3VGOUhkVkJzZ0sxYUd6U2VOTGdVb3JNbUlWOGlQdnhF?=
 =?utf-8?B?Rnp2VEZXZE94YkNWVEVWdTlSTGc5dXMrbFM4TW5YSUxJYVhHaDJDNUEra1pn?=
 =?utf-8?B?RHFYWnoyajlQU2hKb2czRHBwQWFvL25uMW5KOXVURDlSVGFmemxBS0ZPU1E3?=
 =?utf-8?B?Z1NFMnhRRGNCRHh4ZFFTVDBzUFFlWEpIdWM4ZDFTZFJjRzl3OEFQVWZYZTY3?=
 =?utf-8?B?eHFVSDJnRlBTMEJ5L0lFc0ZzZk84c1JGNzFWRDJyRXMxeXRJTUxPdkMybTlL?=
 =?utf-8?B?T2lTZy9ySU10UVBGSzg0endhaWJSLzhVcy9ibjVuSktOcEdsTFpxbGZ4aWZJ?=
 =?utf-8?B?eUNoaTMxdzBDSnNjeDQrZHRKYjZsTlFPMkJjcnhqUkdZak9CanhBUUFOMUJh?=
 =?utf-8?B?N1Bid01sWXlVOVByQU4xODQ2REFNOXlJSis0QWh3cXQ1OGtmYlhjWW5UMkxz?=
 =?utf-8?B?Q1FqQTRFOG4yZ016V0pEZ1FvNVcyaEF4N01paXRPTFFvVmRhSjVzNytvUDRw?=
 =?utf-8?B?RlppYUxGQWpmQml6OTRMMXJYejcwZ29henlSSm5ZaTd4Y1ZMR21hZTAwMG0y?=
 =?utf-8?B?azBaL2FFQU5UYnRtaFR0aEFWd1RWT3ZRQWdudExVSXkyeDE3ZXAxRE1sZjVr?=
 =?utf-8?B?bFBoeHRwVnNuWHFwK0d1cnNPdkJXUzJVUnNidVlFNzZ3eTFCNncrYlZHak4y?=
 =?utf-8?B?SGJpYnM5R2hSaGsrUU91TUpFOGpYRGVsYndnS2Z3ZER3Z21jQ2VWbWVrRHBn?=
 =?utf-8?B?NU4xejBaTUJBZnJLbnVHTG1NWHMwLzJudkFkaWdxRlo0bDVMQnI1MGhJbXBn?=
 =?utf-8?B?Y1hBaHhoOTNsNzloTFhDRlZHV3JlN1pFWnByUStTbWpoekZXUkxNWGY1akl4?=
 =?utf-8?B?c2tZb0RIemdRb29WM1lJdnhlcHNYUDRNNjl4OXVFTExXTE1ZUkg2cEdpTHZk?=
 =?utf-8?B?VmFJQnA1cGFIaU5TdXNrREFDUlJmNzhrUDBnWThURDRRb0dabStlZk1oNXlw?=
 =?utf-8?B?YjJxTXY0emEweXZiTkg0Q3pEV05ud2xuUFhPN2tCQU9QV3JZTE90NldxVmkv?=
 =?utf-8?B?TTlQZEZkT29ndDE3eUpSaEdnMkh3dnhxdmpEVmtPZFNkdDNrYitHV0xpTWVz?=
 =?utf-8?B?UVVsNHo3Ym9qMWdXZlNlSDFCd2R0emdHcW5DNjRodDhXWmNtZ3FMaDBWL2Nj?=
 =?utf-8?B?RVhWdytBVFg1em5oWWdSOE8yaXJBYVg1akNSaDlmRHg3Q3liSTdxL0tkYmFV?=
 =?utf-8?B?dk45aTUxc2ZVSjNmdnBXRmJGNTkrakZDMmZnb3FUd0ZIWlpVZkFONkRuYU9k?=
 =?utf-8?B?QWhWckNoV3Q4WFRqSWFoNC9Pb3hnejg4RTNXREVlUi9ob2oxemxNM1luVmww?=
 =?utf-8?Q?Ke//qlB92Q1vV8YMhU2CYn0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fl3H3Y41a16o3JxVRZk8H0Yi8uzBDQgyqnIiesZqv1dIdjvgiOJZofApZ4n5cjJPcxibeLOQRgbN+eaAoDn9vTz9dC+S2AQacun8i8BqUY2ycakq6gBtIi55oBBGhHKThIYlGj9cLtTB6bK/uzvPJXcwxNHFPEA07ml6vnLzWd1mTREtZccruO/seWI7EGgr9NR1jygFdRCvfRfuujXcYlPZcAAFFlTV10Xl2zqMbsX3CURls5ur7+Nf1VPPDS7bWeBH42adx5KWrfoN02RojVcc9cH4lBQIQI3i/M2A65vDr+ogt6cFKSwMqIfg4rGArzxnFVpGFU5ykVDyqFjch2Uj+KDnbA0OJxpx7U5Tp2JIscn1FfAPP8iShhnT7/R1lUEgPm3aHwGGHPm7V6otyzU/sQxjbEHbY5UpRyd7kDMcXJ9Bej61aVGj8OcYGEyBtup6purIdm8nS5mxKAfJBxftgK4nqgusEdUjtn7wRNzLTMbHHRmKZkol3gIlpV4fIllSNau4vHqOgpIB08qbfBU/KOCp2W6HLcwfI/V8IlfkCq/tQjdJeczXJrZnCcwUy01POoZTb+JNnS6CkEsjOPSSnxzhmTs1Gh4tJAG0bzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece627fa-be1b-4eb5-1b39-08dd41740d25
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 21:21:25.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIZoiQesYm2TT1hWGC1JBBcni1KQoIfAdSzXXNJr4VpVZM3GpYONxscJsaUXVVVfDbmpTDky0z1ziCITqPv6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501300164
X-Proofpoint-ORIG-GUID: yTjGQKMAJBxE-JdOf63ylZbDiBtRqlTt
X-Proofpoint-GUID: yTjGQKMAJBxE-JdOf63ylZbDiBtRqlTt

On 1/27/25 5:10 PM, Andrii Nakryiko wrote:
>>>>> +struct sframe_preamble {
>>>>> +       u16     magic;
>>>>> +       u8      version;
>>>>> +       u8      flags;
>>>>> +} __packed;
>>>>> +
>>>>> +struct sframe_header {
>>>>> +       struct sframe_preamble preamble;
>>>>> +       u8      abi_arch;
>>>>> +       s8      cfa_fixed_fp_offset;
>>>>> +       s8      cfa_fixed_ra_offset;
>>>>> +       u8      auxhdr_len;
>>>>> +       u32     num_fdes;
>>>>> +       u32     num_fres;
>>>>> +       u32     fre_len;
>>>>> +       u32     fdes_off;
>>>>> +       u32     fres_off;
>>>>> +} __packed;
>>>>> +
>>>>> +struct sframe_fde {
>>>>> +       s32     start_addr;
>>>>> +       u32     func_size;
>>>>> +       u32     fres_off;
>>>>> +       u32     fres_num;
>>>>> +       u8      info;
>>>>> +       u8      rep_size;
>>>>> +       u16 padding;
>>>>> +} __packed;
>>>> I couldn't understand from SFrame itself, but why do sframe_header,
>>>> sframe_preamble, and sframe_fde have to be marked __packed, if it's
>>>> all naturally aligned (intentionally and by design)?..
>>> Right, but the spec says they're all packed.  Maybe the point is that
>>> some future sframe version is free to introduce unaligned fields.
>>>
>> SFrame specification aims to keep SFrame header and SFrame FDE members
>> at aligned boundaries in future versions.
>>
>> Only SFrame FRE related accesses may have unaligned accesses.
> Yeah, and it's actually bothering me quite a lot 🙂 I have a tentative
> proposal, maybe we can discuss this for SFrame v3? Let me briefly
> outline the idea.
> 

I looked at the idea below.  It could work wrt unaligned accesses.

Speaking of unaligned accesses, I will ask away: Is the reason to avoid 
unaligned accesses performance hit or are there other practical reasons 
to it ?

> So, currently in v2, FREs within FDEs use an array-of-structs layout.
> If we use preudo-C type definitions, it would be something like this
> for FDE + its FREs:
> 
> struct FDE_and_FREs {
>      struct sframe_func_desc_entry fde_metadata;
> 
>      union FRE {
>          struct FRE8 {
>              u8 sfre_start_address;
>              u8 sfre_info;
>              u8|u16|u32 offsets[M];
>          }
>          struct FRE16 {
>              u16 sfre_start_address;
>              u16 sfre_info;
>              u8|u16|u32 offsets[M];
>          }
>          struct FRE32 {
>              u32 sfre_start_address;
>              u32 sfre_info;
>              u8|u16|u32 offsets[M];
>          }
>      } fres[N] __packed;
> };
> 
> where all fres[i]s are one of those FRE8/FRE16/FRE32, so start
> addresses have the same size, but each FRE has potentially different
> offsets sizing, so there is no common alignment, and so everything has
> to be packed and unaligned.
> 
> But what if we take a struct-of-arrays approach and represent it more like:
> 
> struct FDE_and_FREs {
>      struct sframe_func_desc_entry fde_metadata;
>      u8|u16|u32 start_addrs[N]; /* can extend to u64 as well */
>      u8 sfre_infos[N];
>      u8 offsets8[M8];
>      u16 offsets16[M16] __aligned(2);
>      u32 offsets32[M32] __aligned(4);
>      /* we can naturally extend to support also u64 offsets */
> };
> 
> i.e., we split all FRE records into their three constituents: start
> addresses, info bytes, and then each FRE can fall into either 8-, 16-,
> or 32-bit offsets "bucket". We collect all the offsets, depending on
> their size, into these aligned offsets{8,16,32} arrays (with natural
> extension to 64 bits, if necessary), with at most wasting 1-3 bytes to
> ensure proper alignment everywhere.
> 
> Note, at this point we need to decide if we want to make FREs binary
> searchable or not.
> 
> If not, we don't really need anything extra. As we process each
> start_addrs[i] and sfre_infos[i] to find matching FRE, we keep track
> of how many 8-, 16-, and 32-bit offsets already processed FREs
> consumed, and when we find the right one, we know exactly the starting
> index within offset{8,16,32}. Done.
> 
> But if we were to make FREs binary searchable, we need to basically
> have an index of offset pointers to quickly find offsetsX[j] position
> corresponding to FRE #i. For that, we can have an extra array right
> next to start_addrs, "semantically parallel" to it:
> 
> u8|u16|u32 start_addrs[N];
> u8|u16|u32 offset_idxs[N];
> 
> where start_addrs[i] corresponds to offset_idxs[i], and offset_idxs[i]
> points to the first offset corresponding to FRE #i in offsetX[] array
> (depending on FRE's "bitness"). This is a bit more storage for this
> offset index, but for FDEs with lots of FREs this might be a
> worthwhile tradeoff.
> 
> Few points:
>    a) we can decide this "binary searchability" per-FDE, and for FDEs
> with 1-2-3 FREs not bother, while those with more FREs would be
> searchable ones with index. So we can combine both fast lookups,
> natural alignment of on-disk format, and compactness. The presence of
> index is just another bit in FDE metadata.

I have been going back and forth on this one. So there seem to be the 
following options here:
   #1. Make "binary searchability" a per-FDE decision.
   #2. Make "binary searchability" a per-section decision (I expect 
aarch64 to have very low number of FREs per FDE).
   #3. Bake "binary searchability" into the SFrame FRE specification. 
So its always ON for all FDEs.  The advantage is that it makes stack 
tracers simpler to implement with less code.

I do think #2, #3 appear simpler in concept.

>    b) bitness of offset_idxs[] can be coupled with bitness of
> start_addrs (for simplicity), or could be completely independent and
> identified by FDE's metadata (2 more bits to define this just like
> start_addr bitness is defined). Independent probably would be my
> preference, with linker (or whoever will be producing .sframe data)
> can pick the smallest bitness that is sufficient to represent
> everything.
> 

ATM, GAS does apply special logic to decide the bitness of start_addrs 
per function, and ld just uses that info.  Coupling the bitness of 
offset_idx with bitness of start_addrs will be easy (or _easier_ I 
think), but for now, I leave it as "should be doable" :)

> Yes, it's a bit more complicated to draw and explain, but everything
> will be nicely aligned, extensible to 64 bits, and (optionally at
> least) binary searchable. Implementation-wise on the kernel side it
> shouldn't be significantly more involved. Maybe the compiler would
> need to be a bit smarter when producing FDE data, but it's no rocket
> science.
> 
> Thoughts?

Combining the requirements from your email and Josh's follow up:
   - No unaligned accesses
   - Sorted FREs

I would put compaction as a "good to have" requirement.  It appears to 
me that any compaction will mean a sort of post-processing which will 
interfere with JIT usecase.

