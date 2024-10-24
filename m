Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C11F8188
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786841; cv=fail; b=jb5wNtDhIpV0GnMkJ5IZ9JmDZR5sJG0AwuwiJpcp9eGDM5CUFdayG71139YWo89Vr58NyMMNUCygsy8BvvSGuWCJuJqFmY0yOqF/QRwbG6AfBUhR2Tv4TgrStRBAkDYXFg912UdCcYFTDqFaAFbwQtnciLF2YFSaCz0LwYtBgQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786841; c=relaxed/simple;
	bh=zbkKAh85zSa6tiEIm5GS1uMr7y2cXemF21ptapkP5Mo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2JNa/2vFbPiio9k9f+LaBOBrPGFAF0hKnMRpb6DuZN9P9/aZyx2VONpwA8MJjzgix0rB9X8lOG4sgqsTMLcfo/WRaxchFRGG8/JqEZougdnoYborXocL1+zkOjK966tMbqWkbt4HanDU8UERHRYY6lJcdWPPfnHSkCU5xSRITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YrkusEJw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AV4Fxn9o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YrkusEJw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AV4Fxn9o"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFteZB011260;
	Thu, 24 Oct 2024 16:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=F8CRLrw0Yl/Y4/3XweGi+kGFwtRDfSqjjlTKzzN6IYM=; b=
	YrkusEJwe84WNsuHL0xTy+6EP0F0LehNm6Yl9ncmKZFt9/td3mumuSVhOvDUyFoy
	SDn2Zx0CbZg5RMNq7dY3eShzrZ12btlf8j9oRkaWgKAfL9MbLWDHUwUBM0h7zwsl
	XnWOc24fcMi9jBlkv2ysy2bEu2Uq3nLmLh1MVgl2q5YdcIq+cHeLs1H1ZZtAm2Bz
	JwyA2TwbJHkAd7l0HrKpbYaRhg2TNKXy32ODJyFH0cfPRpeT6VcxP8Le/Kj1GxyZ
	IjFtBLDJXFUHBsa8CwQ+eHGfYD3NZZx67GVeDFrUrPq6c3k0jwi6F0ho7qunh/4z
	WHDeBdVw7ODKe2ceDtO3xw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ejxva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 16:20:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFs580039340;
	Thu, 24 Oct 2024 16:20:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhcqs5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 16:20:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxJRhVF+LfO8k+FREEMwArqkih/JD/orW6toN2q22T5/vzzObaM2IMTW6guWUNfYXKzZWp8kzrhLlTVbtKB8ObhEXmviKkvFFzOy7KkP9MhJTFB/qiRWjHMNBMwz/CzDfzHzllPKQ8F46W0r+f1qcYRnx0sx+BA7+WSmgKR9id+Jm9X0j+jjQfCONJMh3N33RRhlLHPWP31ttuh827xHX9E3uFWlLJUUNHaJzK5iwDUEl01Sl0utVZ4t3w1nmCMGnxEy5r1hSg+mFLNnWF8XHC2WHmVa63pwPX5FJ07O+tLFh4X5/iOIqbW308G0jZxX4gbrLFl/m1bU40GiJg9lLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8CRLrw0Yl/Y4/3XweGi+kGFwtRDfSqjjlTKzzN6IYM=;
 b=jlJxULOFgJqAamk3Ud5LWvpW+fzDH5u+NelBtkEQW5yOYYsiZQIBCnbEvHYX7SqBeIIz0IaxjXJXLnts77Q0/mPX01swUUnIXqvy/P1aKCt81qomfZ+SULreVwieVdnUMj3IEkO1SoLLVR2GemRDGBCd0Nlg5IDkZED3XXFIqsueUSPco42zJKTdjuSfNKeLo555X4/bF5EWq7UUS7TxkzaDCKxcruVWlqkHYHdpimk6bPQ19gMO3KEmp4WEuPlgXypKDnc6T2yePnB4b8j1TYmHp9Z0A3yaPIOSLZgly6QporfAGEviVzw7LhYmX5UCFF/V4tIsfJt2iXTWXDD5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8CRLrw0Yl/Y4/3XweGi+kGFwtRDfSqjjlTKzzN6IYM=;
 b=AV4Fxn9okdDayQv5/1evSLG35EG2exKpXBH0uBMOa5IQP7Tgrn6Unk8UnlJ6gqpoiHLCuyYw7jjVAXhDFFFt6uxFHQE7gF0M/8rvkSYFtfk3L7N4SQNxEk4ahEfJyNLrNY9kA/TuKcxv3kIjLgBUVI0oq+8aEDxjNy6Ix1aJirU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4472.namprd10.prod.outlook.com (2603:10b6:510:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 16:20:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 16:20:27 +0000
Message-ID: <8be4ca4e-ce69-468f-a846-d532a0e7393c@oracle.com>
Date: Thu, 24 Oct 2024 17:20:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] perf top generates kernel "unchecked MSR access
 error: WRMSR"
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org, ravi.bangoria@amd.com,
        Namhyung Kim <namhyung@kernel.org>
References: <156a0ee3-18d5-4144-9f86-230a3946940e@oracle.com>
 <Zxl_4TvxWTtmO_e8@google.com> <368573d6-fd3d-43c3-8c15-d01ef0c35026@amd.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <368573d6-fd3d-43c3-8c15-d01ef0c35026@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: abbcf8a8-1352-42d7-23e4-08dcf447c548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW9hTjEvNmhPMjR3aG5QejNQOVVNa3ExLy9UVWtVVWNPZzUybXE0T1JURVdi?=
 =?utf-8?B?dEVqeUlHcW1hS2FxUHNiUFlQa2RFL1p4b0NHNUl4bDV1NTNoUlZhVFkwSEEw?=
 =?utf-8?B?TTFYS3pwTXBadTBDcFd0TUYzZ2RtL1dKNmdLR1M0MzBMbXErUTNGZHNOY3pi?=
 =?utf-8?B?ZlFmZUFyVzZnQTY2SldnTzV0akVDMFIwNWx1akJpVTBoL3lIWmpTOFArM2xj?=
 =?utf-8?B?RlZOYVAvR05iTzJnN2d2VkZXR2pob3l4SEZGRnkrK3l3OXY4QkJIZUJLMk83?=
 =?utf-8?B?VWdva3EwNytLMUVkM3Ayak5mOGNyY292SjRkSVpXK1V2VkswOFcvWWV3QkVE?=
 =?utf-8?B?dUFVbHZTSlBUc3FPR3g0WTVqTHhRdFNMUzdnT01LTGhRa2ZZWWZqaDNOVkxO?=
 =?utf-8?B?bmpBNHlGakRreXNDVjNhZmx3RWtmbnhzK3NOUHNWZzNkcXBmS3hwWFo2VTRC?=
 =?utf-8?B?WS9VTFNISVNDMVhQUWxQUkgwSjZPSlc2TExJSXdDUHVKWEFLTm9welF4ZGZN?=
 =?utf-8?B?Qm9pNEtaWWUrcjdrZDBOU0pYbktFNWw1OXZubnlYaHhFcEI1MWtXRk0vWmo3?=
 =?utf-8?B?OGltcG0rcEJXK20vSXJhakcvZ0x6aW5YOTIzS0t4ajlpdllVanoraUhxS3pw?=
 =?utf-8?B?ZXBKVjY5THJrcFd0OHRJQ0tHRGhuOTlSckNkcmkrTkpnWCs1QVp6a213ZHJP?=
 =?utf-8?B?dDgzVk5LVmFqMGVoV0RMUUhtVmk5cDdORTIvQm43VWlBMEJtaHQzQWxKZzNx?=
 =?utf-8?B?NjhLMW5EbElpY1MyNW9JdEQ5L2JNU0dkNGpESENyUkVFMHR3cFNpOUY2MTdZ?=
 =?utf-8?B?Sng1dW5LWFI0d0dRRHpJeThnSENwampoL0YvUjhuQXhyL1BhcWlHMDZ2S1Fk?=
 =?utf-8?B?NXdaZmVzOEltTUptL1JJbnhHb2pjSDJpUy9KUzVTK3RpVkFZa2RsZXg0QTdQ?=
 =?utf-8?B?bWN2bjJxVVBQWGkzY3p2Y1p0V0Nhd2NqTjR0ZzlWNk1sODRNRVFpT2xlZE0y?=
 =?utf-8?B?TUpFelJweHE5KzYyejJzUVM3QjNob3I1OUR2RWJ6VnBrUy9PRXlSU2R4NU8x?=
 =?utf-8?B?Rk1TZEh2QnpUcys5L1dRVHJqeFZSNGNwK3RadzFiMUpMdHlNaDdZcmtTRjVW?=
 =?utf-8?B?MkQvbEI5T3c3UmprbHlkR1lYM3dnVGkzcU1yRGNDNU4rZzF1Qjd3RzJnSVlI?=
 =?utf-8?B?Rzl3WjBucHRWblBKbVhvSmY2R1drS3ppSVZ4ZjRjQU00S2pXb2tmTWV0cWU3?=
 =?utf-8?B?S013ZU14emN4cHB1T0d4MWY5V0x3S2l6cE4vWDYxb0RjN2N4WlVxV1JOMS8y?=
 =?utf-8?B?dllmb0xFNGZQd1pjcFJndjlBeEEwWjBSMXI5ckRsSGFwcEM2Z2hLZGVNU3Fu?=
 =?utf-8?B?SzRiMWlSWjQvMitUODBRZ1VJdGU2Uzk4azB1ZndhTVExWmxDNXFDdm1CY2hR?=
 =?utf-8?B?YzVrQWRua1FzUWcyZE13bmJsM2RzR29vdUg2OXdPTXErVmZ3VFZIZEl0RVRv?=
 =?utf-8?B?ZHRXZFZ2ZXJDaTlKTkNmakdEVW85dzVTQmRRWXhmYVVYODI4eUswS2tEeXdz?=
 =?utf-8?B?UFJYRGZvSkNPOTNWdHBwbExZYm1iZkRucmhQMGIrRzRyOGw1YzI0bENjMFNJ?=
 =?utf-8?B?YjBmdHdvenRkYTUyQjNCYjNPOWJDRmtEOXlVajRqNU9mT0NXYWhBeUZhdDRo?=
 =?utf-8?B?UEZxSWMxamErb01qc2pCUHhFOWRhOHFlSHpjN2h1UkR3aVlodDcza0ozTzJQ?=
 =?utf-8?Q?63Q9bSN7h+BM1tBi1AHqZAqMexQo7KxFf+ofxDx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RERiY3NoeFA1d1MzbWJ3RW9nRkYyUG9vLzg1RDRqK0xQeXVMNitBKytFN1hp?=
 =?utf-8?B?UnYzWW5xdUNBVkhJdHJmb3JDV1RHd0Ywb1FzNGdOWnVSR0ZWbFByUFoydkpJ?=
 =?utf-8?B?eEE3eml4OEJldXZ1SElqOHJhMlFiTUVGOU80M0dnQW5VVUp1ZjY1UnMxckVs?=
 =?utf-8?B?SmNBUGQwNzZacVh1UlpReEJvOHFvQXErcFU3d2FqY2ttTGZZb293cFNXaWtI?=
 =?utf-8?B?Qys2bXZFdnliWTBUWHZpMzcyTkl3YkljbWNWRWVtdjlSWkpwcjhUZUFSTDZ3?=
 =?utf-8?B?OW9FRnZha1VIbmRCSlNWOENpQjk3MDNNSkRHbFNhZjJLcFBEdksxZFlxbndY?=
 =?utf-8?B?c2lkcjF6L0MraGhVMUNPNXB2RlliVjIzMTlBYnk4c0lvUDhZN0x2L0dHL2gw?=
 =?utf-8?B?eTdNTk5pRk5JZmtsN0pjWUQ4TkhNVnhHc09YdFZuRTFsUTlVQWRnMGlEYnht?=
 =?utf-8?B?Y3A0TXZQU0FybGV6SDVwV1NWZzlCNFo2UUN2M0lta1BXQWdFQmF1RWNaYUVB?=
 =?utf-8?B?RXZFMHhSaXFueHloVy9xOWJ4cXlJQW9HUDlnZFhpN3FFQS8rbEJ1NmQvYXdY?=
 =?utf-8?B?UXozNE83Mm94cnVZL1NLU3g3bUZPTytLSTR5OWw4Yy9ycHpVaTUvVHRFQUhR?=
 =?utf-8?B?SEFUMWdQRVd5czVDcVBUZVBhWjZMR3FhZVp5TFFhTzRTWEdoYkFMRHNIUHE2?=
 =?utf-8?B?cTUxVlB3TEZpS0Rtd3pzOHdmbVZObDE4WkRqcVJXUE05MXdRUWlrbFdlbmNp?=
 =?utf-8?B?V0NuYVN1anVWS1A3eTJkVWVCTjZ5eEhtVCtkc1NzTXBYQ09vbGN1c3ZkNnA0?=
 =?utf-8?B?N0VNaEl3ZmQzQ3ZDeHJ5K0M4RENvVXg4ejgzWVR2dGVHMzhHaXJGcXFvdDBi?=
 =?utf-8?B?RTVuV2tIMUZPMHlPZHZkZlptNDMzWHZxTTY4NmFXQnhEYWNRY0xwQlB1U3RQ?=
 =?utf-8?B?T21ORjlBNnMrM2lkSURMWEVicGdaRkprRXZnSEtmZ0FLQ1hmTk9ySVF2MmVt?=
 =?utf-8?B?WEtML1dXM2VDSjduNHdZZmQ0MTc3a3oyRnlqanJsU2Z1MWx2QU5VMk5KYVBP?=
 =?utf-8?B?M3c4OFpNZG1lZHZma2NMRXJxMFc5OUtuMHdGdkkxSnBBWHdiK0RvcVRmVWdE?=
 =?utf-8?B?eWVLSlV2WDgvV2c2S2FJWHpUNHVxa3hkN1BJTUhnVGNwY0dLQ2xVblRmM3pD?=
 =?utf-8?B?MFlIOUxqdE9xL3A2UE5DZEZnWDkxRWNXbWtGK0RZWmplMkh3QXFDYldHQTJa?=
 =?utf-8?B?MmVaVXNxVTRUZjFHWCtTbEhOR3NEVHVIc0lsQXZ5c2NIdFJBZTlEUmR3OTNS?=
 =?utf-8?B?OHUwUm80YWJkb28zNUdFZm9oOU5VNkdsT0pOTnNvU3RpN0Q4UmZRZk9vUk1Y?=
 =?utf-8?B?bHVQWXlLU0tvWXVDL1puL2ptb002ZFo5T0pJS0VmZjVDbEk4YThDcnlEYTdT?=
 =?utf-8?B?NW9XT21vTm5vN1JDUzFRRUpJUWNyVERUUFZyVzZqaHkxb0djUFR3UitTK1o4?=
 =?utf-8?B?dGNnN1Z5Q1JneFpaSFpvNkZMYldlUnloWUIwYTJIZjNWVUVKci9LNWZkVjVZ?=
 =?utf-8?B?Z0Y4WnNieWNoOVNudXZtZkxuYTVDMC9ZSGFqTjhEZlJWZEpPNmwrNnQrdDFn?=
 =?utf-8?B?eGgyUkZ4a1ltZGFvU0h0Y2k4UFdEQWIrV2hCcVUzc050TVNxbnVyNkkvMVht?=
 =?utf-8?B?RnY4cHltQWYvRU4xQXRlQ1NkRjQ5anpXdFNKbDY0eDRCbXArSW14K2R0TW9W?=
 =?utf-8?B?VVRrYnpZS3ZHUUdvUmhhdVA4UCtpWURJeVI5VXRqV1lHVDhjV0lNd2NEelAr?=
 =?utf-8?B?RzBtRGIvdkpyMElEd0xKTk12b0pLN1hyTEdSS0dTZHJub3QvYTYydSs0b0pM?=
 =?utf-8?B?TzhYY3hhZ2hiVm54aWNBWDBGYmVPVmhySVNybXNBanJOOGx4ZDB6dWpEUFZG?=
 =?utf-8?B?RXc2MDRUckQwa2NXWlFWcnJ0UnFPRFhFVjVKSVRlOElWZUN6VGJWT3hKVFpt?=
 =?utf-8?B?T05CRzZMY3gzZUpjaGZ2OW05TkxCQW53SVpDem1HN2NsSzRhOHVDUFIxd3Jh?=
 =?utf-8?B?Wkl0cGlTUW1aTENHYS9lSEwrQW13NWpUL2RPaDFMSXdGazZDOEk3TU8wN05T?=
 =?utf-8?B?dVFsVnlUZTZuS1ZzNDdGc2ZXTmtydytTT3ZkWStIYjhEdnZ2UFJlSnh4dVNE?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tNRV3FAsYCDsKdk4hAXGOdesKuUeKplm1QL6MgAC1VD96JaN+6CJURatvC8pB/vIrqTiClwXyNGw50lTlQtu8+iNuKw4D8atIOv6/fQ5JKCsmTAEqY4uvGJuVgiF6d45NCvvb65y/C3jBkNOaGVfVZKD3mjNzWCVDZu6UBEO0ww/k7Z6aoezZYajTKKvVA4ZF43Xqn/lTEhNGvscpXXq0j2ZQ/sZuMCuzI7J/tY5388Swg1OWuUTVyh11+goQds2Y/jhnDRom0anxe2AeDwemslgpVFQ8jD65+UhHJlveGbf9O2xHy3DeRvF9ic1au5Lc1H1w6tRtzKJhO07NbHlFK4RsTZlZRTMpou6rQB4L4DMrE3kYbcs3YslSbholdpwj9Hh3LpDviBndBQfFCpY1JVGgPZT4uvCFKkBe93OwilJ4gEILOGduAFR2lcBfxb0yHuBK50JEUihKg+/47r32UpK7Pw2lu0UQG3MK+vftdLejiY96Q5ET7mN0e5kNCDyMChVoA+46tEu+c5vdNIExmE5N3PNO3wVNT9uxYnu2mWyV7sO3e3thBA3d4REL2i0W3Lo1h5pUghge474y0XgYcvbZ9mLys6YqHFKZIMO8Jo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbcf8a8-1352-42d7-23e4-08dcf447c548
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:20:27.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWTPhqgxcg/dlGmqX5rk6lwArcuCzEM6X1YUG048J1K+Js0tFzeDFKhX2u/otfyp27jNWT+eFBA3HeUYIP6fqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240134
X-Proofpoint-ORIG-GUID: R15QcD_ydh5Kyqfi6NpFBZN3T7ru42Lo
X-Proofpoint-GUID: R15QcD_ydh5Kyqfi6NpFBZN3T7ru42Lo

On 24/10/2024 07:21, Sandipan Das wrote:
> Thanks for bringing this to our attention.
> 
>> On Tue, Oct 22, 2024 at 03:55:05PM +0100, John Garry wrote:
>>> Hi all,
>>>
>>> On my VM, "perf top" gives this stackframe on v6.12-rc4:
>>>
>>> [  930.527581] unchecked MSR access error: WRMSR to 0xc0010200 (tried to
>>> write 0x0000020000510076) at rIP: 0xffffffff94ead548
>>> (native_write_msr+0x8/0x30)
>>> [  930.531135] Call Trace:
>>> [  930.531456]  <IRQ>
>>> [  930.531749]  ? ex_handler_msr+0x138/0x150
>>> [  930.532285]  ? search_extable+0x26/0x30
>>> [  930.532780]  ? fixup_exception+0x9c/0x310
>>> [  930.533405]  ? exc_general_protection+0x10c/0x490
>>> [  930.534081]  ? asm_exc_general_protection+0x26/0x30
>>> [  930.534768]  ? native_write_msr+0x8/0x30
>>> [  930.535357]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [  930.535998]  x86_pmu_enable_event+0xa5/0xd0
>>> [  930.536641]  amd_pmu_enable_all+0x4e/0x80
>>> [  930.537211]  ctx_resched+0x13b/0x1d0
>>> [  930.537735]  __perf_install_in_context+0x2a2/0x390
>>> [  930.538439]  remote_function+0x49/0x60
>>> [  930.538931]  __flush_smp_call_function_queue+0xdc/0x700
>>> [  930.539694]  ? __pfx_remote_function+0x10/0x10
>>> [  930.540480]  __sysvec_call_function_single+0x38/0x140
>>> [  930.541134]  sysvec_call_function_single+0x6c/0x90
>>> [  930.541970]  </IRQ>
>>> [  930.542269]  <TASK>
>>> [  930.542766]  asm_sysvec_call_function_single+0x1a/0x20
>>> [  930.543493] RIP: 0010:pv_native_safe_halt+0xf/0x20
>>> [  930.544195] Code: 22 d7 e9 ff b5 13 00 0f 1f 40 00 90 90 90 90 90 90 90
>>> 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d d3 e3 25 00 fb f4 <e9>
>>> d7 b5 13 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
>>> [  930.546841] RSP: 0018:ffffffff96a03e68 EFLAGS: 00000206
>>> [  930.547563] RAX: 0000000000000006 RBX: ffffffff96a269c0 RCX:
>>> 0000000000000000
>>> [  930.548579] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>>> ffffffff94f53f31
>>> [  930.549568] RBP: 0000000000000000 R08: 0000000000000001 R09:
>>> 0000000000000000
>>> [  930.550529] R10: 0000000000000001 R11: 0000000000000000 R12:
>>> ffffffff970608e0
>>> [  930.551582] R13: ffffffff96a269c0 R14: 0000000000000000 R15:
>>> 0000000000000000
>>> [  930.552683]  ? do_idle+0x1d1/0x2a0
>>> [  930.553182]  default_idle+0x9/0x20
>>> [  930.553670]  default_idle_call+0x7d/0xc0
>>> [  930.554226]  do_idle+0x1d1/0x2a0
>>> [  930.554696]  cpu_startup_entry+0x29/0x30
>>> [  930.555154]  rest_init+0x12e/0x1d0
>>> [  930.555621]  start_kernel+0x60f/0x6d0
>>> [  930.556064]  x86_64_start_reservations+0x21/0x40
>>> [  930.556633]  x86_64_start_kernel+0x91/0xa0
>>> [  930.557107]  common_startup_64+0x13e/0x141
>>> [  930.558038]  </TASK>
>>> [  930.738880] perf: interrupt took too long (2511 > 2500), lowering
>>> kernel.perf_event_max_sample_rate to 79000
>>> [  930.772912] perf: interrupt took too long (3414 > 3138), lowering
>>> kernel.perf_event_max_sample_rate to 58000
>>> [  930.797764] perf: interrupt took too long (4275 > 4267), lowering
>>> kernel.perf_event_max_sample_rate to 46000
>>> [  931.117733] perf: interrupt took too long (5345 > 5343), lowering
>>> kernel.perf_event_max_sample_rate to 37000
>>> [  933.862829] perf: interrupt took too long (6765 > 6681), lowering
>>> kernel.perf_event_max_sample_rate to 29000
>>> [opc@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 ~]$ ^C
>>>
>>> a known issue?
> I am unable to replicate this with KVM guests. MSR 0xc0010200 is the
> first PERF_CTL (event selector) and generally, unchecked MSR accesses
> happen when the hypervisor restricts what guests can access.
> 
> Can you share details about the hypervisor?
> If its just KVM, can you share the host kernel version as well?

It's KVM, but I don't know the host version - I don't think it's easy 
info to get. Here's some KVM prints:

[opc@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 ~]$ sudo dmesg 
| grep -i kvm
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 394705327075 cycles
[    0.000002] clocksource: kvm-clock: mask: 0xffffffffffffffff 
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.010289] kvm-guest: APIC: eoi() replaced with 
kvm_guest_apic_eoi_write()
[    0.010297] kvm-guest: KVM setup pv remote TLB flush
[    0.010300] kvm-guest: setup PV sched yield
[    0.010324] Booting paravirtualized kernel on KVM
[    0.016465] kvm-guest: PV spinlocks enabled
[    0.058487] kvm-guest: APIC: send_IPI_mask() replaced with 
kvm_send_ipi_mask()
[    0.058491] kvm-guest: APIC: send_IPI_mask_allbutself() replaced with 
kvm_send_ipi_mask_allbutself()
[    0.058492] kvm-guest: setup PV IPIs
[    0.280302] clocksource: Switched to clocksource kvm-clock
[    1.302630] systemd[1]: Detected virtualization kvm.
[    1.312201] systemd[1]: Initializing machine ID from KVM UUID.
[   13.771695] systemd[1]: Detected virtualization kvm.
[   15.072121] kvm_amd: Nested Virtualization enabled
[   15.072124] kvm_amd: Nested Paging enabled
[opc@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 ~]$


> 
>>> more /proc/cpuinfo gives:
>>>
>>> processor       : 0
>>> vendor_id       : AuthenticAMD
>>> cpu family      : 25
>>> model           : 1
>>> model name      : AMD EPYC 7J13 64-Core Processor
>>> stepping        : 1
>>> microcode       : 0x1000065
>>> cpu MHz         : 2445.322
>>> cache size      : 512 KB
>>> physical id     : 0
>>> siblings        : 16
>>> core id         : 0
>>> cpu cores       : 8
>>> apicid          : 0
>>> initial apicid  : 0
>>> fpu             : yes
>>> fpu_exception   : yes
>>> cpuid level     : 16
>>> wp              : yes
>>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>>> cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
>>> pdpe1gb rdtscp lm rep_good nopl xtopology cpuid extd_apicid tsc_kn
>>> own_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt
>>> tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy
>>> svm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw topo
>>> ext perfctr_core ssbd ibrs ibpb stibp vmmcall fsgsbase tsc_adjust bmi1 avx2
>>> smep bmi2 erms invpcid rdseed adx smap clflushopt clwb sha_ni xsaveopt
>>> xsavec xgetbv1 xsaves clzero xsaveerptr wbnoinvd arat npt nrip_sa
>>> ve umip pku ospke vaes vpclmulqdq rdpid arch_capabilities
>>> bugs            : sysret_ss_attrs null_seg spectre_v1 spectre_v2
>>> spec_store_bypass srso ibpb_no_ret
>>> bogomips        : 4890.64
>>> TLB size        : 1024 4K pages
>>> clflush size    : 64
>>> cache_alignment : 64
>>> address sizes   : 40 bits physical, 48 bits virtual
>>> power management:
>>>
> I tried replicating this on systems with an EPYC 7713 (very similar to the
> one above) and an EPYC 9654 but had no luck.

Thanks for checking.

but wouldn't you know it - it does not occur now. I guess that it will 
reappear... I'll let you know.

Thanks
John

