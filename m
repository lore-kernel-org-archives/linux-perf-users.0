Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909771748;
	Fri,  7 Jun 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787689; cv=fail; b=tnOK8KwdE/3yplIrsB0oD/8rsRQJm6zLkI3Tsi4P2gsQNk5/12bDjBu9TfRCU1IB2IUJZgphljdRS0ps2gbMqjganZkHSKEQcZsK2W7toMlLBHWxf34wGBU+cft2gxxEDdqKuQ6USH43mrMF0VjGMHU3aWHFY4Aai322RQElauc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787689; c=relaxed/simple;
	bh=PiGsvuCW3ylS+UZPK6bkc7A+qFolxE2spGQ8M4Dwn4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aSpr/dP1I/vPr1q15o6ZzwaqE5ov3upRrC+W7l/InD6Ks4ZwNAzyleQF/2AT3HXXzbjfWhzkT5vtTsdRm1eP1p4CWQAund5qCktoJoR84RJU+yEQEb8DdQUa31f/WXpAYPuO9kDgDinCYS83f6hQfm96Qk9jMKpm+XaxtPf4ahU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=auDsPlQ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SEQCHmDD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="auDsPlQ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SEQCHmDD"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuhVJ016017;
	Fri, 7 Jun 2024 19:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=rGUotTlvJquIIhRGgDwXt7gKOGzdF3vPBjb0yYK9kuA=;
 b=auDsPlQ4ZvZDQ6E/UexaC+9kFGRxpF2ft38spQG97oxbdZB7GxuisRY0Oqn4kbLegI89
 Y9tSrxPWEj9tZz6EWFJQkx28NZPPOZHuhz8V5PayG7gXEjyNWfEgjzIB4pYxv9BLYGSb
 H01GZmPCmIY8QUUMkxGaidcGxVtU7Olwy13+hMtjjIRGgg1srCkeg5ok9zpAN1P3EdCM
 Ev1IYk+6ubkAS+5TvBKdaM05/tZ3rdm1R0cvsK/TyKsWX1DGZ4eG/3P7TSUj9sktmEa1
 Ye80fi/0ofktI+GVYzlokE2gUYmplM0JEJrlvFV0kyQZFZFRgBzOEIMXcL6h1JnyLeDj BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn6ag3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 19:14:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457HsQbm025130;
	Fri, 7 Jun 2024 19:14:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtdcnny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 19:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il8KOoTxBi1MgAfTX3HuWHjZExb/ZSFuGhBkGvFBsNk6UriNlSqzV9XJz7KwIOuF1nlhylWYAeUJQZzdO8wHDP0xI7YYrdqDDdqyQEv6ALISA4ZOd4p7qp+cYlb8dg2F3uX7krBb1kcspg+kOEuvXvK0jS3R/mVF7Isn5NfhxzuolbhHdrFuWSvu6UJxTT1WY69seytvAo4lPYaXPINWgD2lmnm3FyohyTxFiQ3UoXAfMTgI1Ni6BqsEK68ozzLuXcRwHmQiew9p5s1z86E1q1v+ra5XsK4Uu5SyT1wDwmABXkw/nb5FNZr295TCZKTgP9JGBcwoeWTxjyz124IM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGUotTlvJquIIhRGgDwXt7gKOGzdF3vPBjb0yYK9kuA=;
 b=ahxZkFQRh+wCQYUyY6DQytx0e7EA+QnYINwDUxFw1DDAmVOemUgXQoFXF1nLUNlBs+PmaPkn3mxQrakc71IaUF55FQswHMDZuavTQRcNG7vl9ItpnOtLEo8w75kvRAiRxd9zGJGWmdOg30RsCZVSDKUWRsY20X2Ss1XxIOGf0GKyrWWCqFogvqqWFFI7RlzPQVZuJCuRw7t3l9DRzvx1pMIDfEVEoNEpt/B8ZDdwkbglMmQXzM0mi9lEUyRnl+yocg3WcnQnpHxU6XuOS8aOYxHokToBdu/MSoCWT/I3m2nrUrwTbHDloZ67hrVrjTXqx1yTob8BBT0cDDYI6udj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGUotTlvJquIIhRGgDwXt7gKOGzdF3vPBjb0yYK9kuA=;
 b=SEQCHmDDpSK3DFZQ4z/HVDOJM8kCvs56VcTT8Lqzg2rinvQpeqcOm2uEuRtSRoAClED6+ktovnJfl9VBF8ysOIEUx4qIoKqGKkiVa7PmladPVutHLWxoMdln8YGLO7X2q6ZtkGOvSWFyr5LsjhzYAvwKeqXFEUtPA+CBQRCTDGg=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by MW4PR10MB5751.namprd10.prod.outlook.com (2603:10b6:303:18f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 19:13:57 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::521f:4913:ea29:ef83%5]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 19:13:57 +0000
Message-ID: <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
Date: Fri, 7 Jun 2024 15:13:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
Content-Language: en-US
From: George Kennedy <george.kennedy@oracle.com>
In-Reply-To: <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::15) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|MW4PR10MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4ba7b0-2138-4ab2-a866-08dc8725fa9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHd2RnhiWVVjeHBYWGNSRGgyakFvdjhPaVR4SlN1SVJsbjR3eUhQSlBwNEhH?=
 =?utf-8?B?cmswZDAwTFkwcXk2a0NQZ3JUZ3Y1ZnhuOG44bndSS2Z1VzQ1WHhFYkxYOFBk?=
 =?utf-8?B?aXpTNFBmWlVUeVdyeGtpKzZiOFZKUUpOaXNDeitsYmdoTkc0a3U2ZHJ5TDFY?=
 =?utf-8?B?czJRQ21NaFZqNHlZdGJ6cGpXRlNEZ2ZZYnF0Q3hZbWsxY3Z0THZFOHJXOWVD?=
 =?utf-8?B?VnJkQWFnV3FMZXdmSVJibm5PaXd5N0dSTWhVR2xrV041QndQVVJxa0JCYU9O?=
 =?utf-8?B?aVo3a3VrVWRHcVAvV29QQkUxQW5weGFCNWZGOEUwdUJ5NkIzenB0REJqVmx3?=
 =?utf-8?B?NnNFUm16eDVlajV6UWplVWlGME5tNkVDU2dacThUWFRBVUI3MjBLYmpNK0xm?=
 =?utf-8?B?cVkxY3p2UVRaZWJIUFMyODVwaXNxY0RQaVJZQjNEYlkvRlJQelY5Q2UxK1RK?=
 =?utf-8?B?c2lueHkrVzNRellna3JqdXhXdFZxb3VqK1JiY2FlRkVHdDZGYnVxSHVHWllp?=
 =?utf-8?B?dzZLUU1DRURYNHkwTE95NE11ajBxM3AvcU5JNGxBS2pXZEp5c0s1ZjQrVUt1?=
 =?utf-8?B?QTdDc0p6K1M4dkxHeGUvd3BTQmEzd2ZiWndPTTBYWXZ2ZUtDNnFmWHdlZTVD?=
 =?utf-8?B?Mk1TTHdvTlJ6eHBaQTV0Y1NJdks0WGszYVhtYkY5bVNrcXdwMHVKKzlxSUNa?=
 =?utf-8?B?MUlaQ01odENmYXQzdTA3OHEzZDNtYmNBS04wblR5UVNFaEF2YVJsVXdkMnJu?=
 =?utf-8?B?VUZ0SWZHeWt2TGM2eTFpcThJUWhGNzFIT3JLRk5uUGdXRC9Ycmx6L0p5VmI2?=
 =?utf-8?B?ODFkOXdFdGpOemdCNWtickpNaGlLTm9XMEF0bnRCVjloWnFEeHpkNjhzbEZU?=
 =?utf-8?B?V3J3TzVsNitVdzZQUU13eTB3Y2FlcmprR3R3SVFXbGJnK1p5YjRsNjRVamFR?=
 =?utf-8?B?WXpQd0JTVGViTTZCdUdTWStFV2JiZkFJRG9tbzFYTE1qaWNLRVhMMU1na2pw?=
 =?utf-8?B?RkJUK2Zic0gwcndoM3lmcVlscFpuM1diR3dXaEhmKzNqMlZTZnpZak1Qdkpz?=
 =?utf-8?B?VGFhUEY0blFhQ0phL1FmR0VPeUNKbzlCSFVxZG11djdMcGJTbDhvWW1YTXFN?=
 =?utf-8?B?MittMjB1TkFLQVVoWEVoTEY1amVONHVFeHBQdEcxcEZ3b25rZlNDMUNsMFR4?=
 =?utf-8?B?UUJGeXlQeWJhSmJqWklMUk5EMHFFVUFsTm1NK1NXOTIxTmc2c3cvY3dRcG4x?=
 =?utf-8?B?dmY1U2VJUjl4R2dyb3BFU0NPYmsxQ21HOEF0UTI2YlJiOGNGQXNyU0ZJL3Jl?=
 =?utf-8?B?andPaTRkMG41d01JQk9OQ0s2emU3cTY2VG5Lb3dXNGhwa1FkdUhwWC9tQ2F1?=
 =?utf-8?B?QmF2eUh4ZWNTSmJsbUJOQ1puS296YjFEOEVxTVA2UG13RWZGVUJDa21jWk5P?=
 =?utf-8?B?ZC8ydVJEaGZ6VHA4dE05cHJhTDFqUWt2NHV4aHdJcFpodGhIditGYWxBRlpq?=
 =?utf-8?B?ck1aVm4zdVNzUUVxWW9GZ09MazF0b0JYMHFCSytQaWJpSFQrN3BpOFpOOEE1?=
 =?utf-8?B?VS9GZ1Q3NFh2cSthTEZIUWN1Znp5QzhYTlZ6djRMZzV3YVFGRXBLTkZxTlhX?=
 =?utf-8?B?cTdlVi95ZnVGMytJUGRpUVBYY3p6c0hSak1HQ1lRd1VWTlduRGJkSVEvYURW?=
 =?utf-8?Q?nMarnzH2g871wUxX4OIr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkNYd29DVm9xQkNMVUhIWHZwNEkzZ1l1RFNyOWd5VFE2UVFpSWlOdC8xVUJy?=
 =?utf-8?B?R2hTaXhIWlZZNXZBbzFoWG91SWFmSko3bkswL20yd052NDRaN2ZlZWNicUVB?=
 =?utf-8?B?K0NEQjdvc3hFRFY2VXVOV0EwdmZwK2Y5U3NlY1lJZzRaWW1hTU1NVWNqL3dM?=
 =?utf-8?B?N1orc0dnQ3dyS2xHb1VWMUlDNjBvQ3N0U1J5YUhpOE8yZW85djJwK3JVaTZU?=
 =?utf-8?B?VVkxYWhsbHE5REk3LzFMd0UyTXFHNVFJMXhpbld2Um82ay95TUhaSXVWZ2s0?=
 =?utf-8?B?cUt3WjVvdUJqSHZpbWo3UzBXREVIMXlBeHlVd0duYVpvSE9yU29BZlRxY0x4?=
 =?utf-8?B?eWJoZjNoSVByR08wd3FuS2JaME1ocHRmbmVTZjVVcDkvbHNESGZQQ1BkeE4w?=
 =?utf-8?B?T2Q5VjNJOTlzMlg2LzJYT2JKWnRCQS9zRGkvdW5lTnJSNWh2dkpEb3FTYmxY?=
 =?utf-8?B?UVZyT3kySFdrRXJGQTM3TnAzQkVXNksrTGxGVkM3NTlUSHNSMEVqVmx2cUd0?=
 =?utf-8?B?TWNKMDlJYUFCbFZqOFloM0NUZTZHVGh4OEtQbDBHQmxFUUJwK29KaXBHVERm?=
 =?utf-8?B?Q2ovVU1KYjNLVzRrZVlQeFJUVkQva3RrK2FFTFFnVTZYRVlzWU9ZWm9XdGEr?=
 =?utf-8?B?enNUUEVqNTNXZVZVdWlGZ1ZEQ3ZoU2k0MlJ6N2pTRk8xbGwvOXlCNU5rRmQ2?=
 =?utf-8?B?SkhRSHpvbWlIemNXWURWYkRjTkoyL1Q4cWFUZm1zOU5mdDRDNU0rVHp1alNH?=
 =?utf-8?B?Q21Qd1h1WUNIRkg1RlU5Q01GdVBpTWYzaHEyeWs4d2x2SnNmZEhHcnpkdVY0?=
 =?utf-8?B?SVVPOFVzRFNPaFVDdXo2VXF6Y0ZYREdnREtVMGx3eVFmMUtuYmZXK3V5ZjE2?=
 =?utf-8?B?alk2SncvRFRkZGxHTGNSbC9XdE1PQVJxNUdjalU0ZW84a3dZQVl6VjQycTlm?=
 =?utf-8?B?dXByWDRLOVRNYUVOd2xFN0Y1KzBqRHloMjRubDVmMTFoKzBwUzFNVCtCdVNj?=
 =?utf-8?B?ek9NZFZCUTE3emFpMWxSVDhka0FaS0VQL0lhVWtyTnpLWjhnYzVJNUNmQmRo?=
 =?utf-8?B?ampjMVRqZzNDNFhTOWNsZVd6VGRHRFhCVmJRbzJtTWJ4Tk9TaG8zdlJJcDcr?=
 =?utf-8?B?RGFmbE9nbVNIc3cwNmZ1RTJVK1VWdWcveFpOa1Rna2c0cEJTaVdURWlnVkNo?=
 =?utf-8?B?c0tYT2VkUERibENTQTRkc1R0dUZFK1NlaEZMQ3NWazE3R1ZvOVRTOVQyTWJN?=
 =?utf-8?B?NUR4WGYwSFM5cnY3M3JFc3I1bnNrQ2thVG5CcGtGSW1nZEQ3Mkc0TCtzK1Rl?=
 =?utf-8?B?djNjc2N3K1VQcGl3YmVMT1k0bGRHbDRjK3VKZXF5SXJVSzNrZ3Nlek8rbHdB?=
 =?utf-8?B?V25id2VSNUQ1ejFuWUFhNkszNXE4WEFDZUYwQmNaN0w2YlFzQysxc0FueXlV?=
 =?utf-8?B?UUYreXlhd3BIRURnbjN1UHN2dTkzeWlCS2sxSDZkZHUvMjZsbkIxMTRsdGVm?=
 =?utf-8?B?YzR1TUoybzdKWldCVEMxVm9qR2dzQVlSNiszTGV5WTNOMGM2MDJUOGNPejJW?=
 =?utf-8?B?Zzl6a05ZYVorR1Yrd3c0VE15cmlsY0JxMnZSN09OTEtvS2FDSmVoblA5T0lk?=
 =?utf-8?B?TnVHeDFNbGgwWXd2cWNCbkdwL2xnMndoSE5PZUtRUHRIY1VVZm5FZmxsbEFj?=
 =?utf-8?B?QnI4aVdpTEdVcUxUdFVITWRiNU5GcXArM05xcXBtOENJYmtxbnM3ajR2Zmda?=
 =?utf-8?B?a1pjZXQyRUlSNElFTE5sRzJvQzJiTEJmUlQxV2FFK2VyZWhHRUFRMnFNQmU5?=
 =?utf-8?B?Q2VKamtWNVVBVlI1VUFqVm1JdDdRUG1JWXJFa2FTTUFHVWU3MHlEYVRNK2Fp?=
 =?utf-8?B?bERRMFJqTHNmMTNaZjh1MzNZMXhwVTluTXdaejYrd2Q1bmgwSU1IL2lvQzhX?=
 =?utf-8?B?WFBGRDBveWVNdHlLUUQyZ3NnWndWNmpzMUU4RjVMajJsTU9SSHhaeVN3S0Nr?=
 =?utf-8?B?bDVNS2kvV2pQcVowSDE0WkpvQjJERDdmWmh3MzlWK1kvR3RJU2gwcVZCZjA4?=
 =?utf-8?B?dW1nb0pzL2xrcGtySU9jMEw3QVh6U3dwS1YxSXVvQi9IRC9tcXo0YUJRSmFZ?=
 =?utf-8?B?U2hDdXY3NHl5SW1scmRsd1o3SjlOeVNrbmNEVjBMWVpnMkl5d2hXS21wSThh?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Xhxrqa1n9VLeiFJD/QhbXdFwxWGlchE9H57+OORHCNyaB2On8RsD2mCFgZJm+FJa31bPkdjWaydBg+wp5EtTO5xW+sAtFDXnfqXO0/oQriIJQlOsOGoN1Y7sMptMPMOUNUU8k16Yt63HmvdVxtKLVs3ek9HJuNNPw2jTPuzsyTi0O2mlMLCwn8BRW5nx33XUmJZRXTrfSAYNRT0j+89bgwhqLRlappofNv8LsIQZvwxBF8H1bCFklrD2SpxxdGwig8DWRjztCLbHjref5o+tY3c1H+cYkZiX2DeoaP/te5+bR5brRFpf3ZpDvNZceCbkJ3XgY2MZNWioj1DgAtGhwOUclflHbXSacLqmMM/fFy8LPybAKN6Vei3499NDJBCd2Bt5VZnkcOBVwjOZPmgVccIQ/Wztj7Ji3iV2qOYDHB8uPkKwMg4zO7KxVF5tZuHVUzEvvgEmmxMV4CkNKENPbqO2eI9GP/cWN1MoieGdKPA3LCisX+nuUcqQXZQYK2qrzZsvA4wAoqc3d1pxS1UlSVJuTvZdN0LiZS/LTN0d2D0SZN1fEorVtM1wAt9gBDrky/w7e1DycAxQDcMgAXFXray2Bicp2jsELg/lH6NxeZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4ba7b0-2138-4ab2-a866-08dc8725fa9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 19:13:56.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsNrzQy9/ht8hGYdH3PT60JhWG1sB/ezhbSjOoU+ivlh2bw808JxAn0xASSjsLyOhmFzdGmZTkuxW7dr/DVm+5rsNV3HQJMlel5D8ydIU9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5751
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_12,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070141
X-Proofpoint-ORIG-GUID: lQhCvj_yJrYS5kvRiMakn63qXIzA4LFa
X-Proofpoint-GUID: lQhCvj_yJrYS5kvRiMakn63qXIzA4LFa

Hi Ravi,

On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>> Can you please also explain "how".
>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>> This appears to be an AMD only issue.
>>>>>>>
>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>> The Syzkaller reproducer can be found in this link:
>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>             if (!test_bit(idx, cpuc->active_mask))
>>>>>>>                 continue;
>>>>>>>     -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>> +        if (cpuc->events[idx])
>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>> There are subtle differences between Intel and AMD pmu implementation.
>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>
>>> The WARN_ON_ONCE() is important because it will warn about potential
>>> sw bug somewhere else.
>> We could add a similar WARN_ON_ONCE() to the proposed patch.
> Sure, that would help in future. But for current splat, can you please
> try to rootcause the underlying race condition?

Were you able to reproduce the crash on the AMD machine?

Thanks,
George
> Thanks,
> Ravi

