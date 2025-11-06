Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9142E9EB1;
	Thu,  6 Nov 2025 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462949; cv=fail; b=s1raHb95bg31f7mMzFVy+AVbG+8VHx+kls1jSpYeMskLHIwhmI6CZR+IXQogWB8KYxLzfLIyEH0JW9ztTIV2k+oGpO6wD+tQ1DHc5AcCBWfAlCFtg72XtObO6ImKAzg17Mb/fWUV5i4PhuwXOIol0LjONuhlBz3Wava/zt5e5Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462949; c=relaxed/simple;
	bh=dJO1juD/9l6jYnTdD+gNOdL3HzSjyXe7dV6DVAud4yU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pm+S2yz3CT26dHXcHzmjRUbtKqQaiMry2fuHyEXCtx/zw2lMHQXnLJ5Lj6hrtbkLvUW9EaFArc+hUNb+1p9CrEUwAkAnVwSVOCnF6hph7KvLYfIeHgHcw/v4dGlXFrYDXxfak3NMQHpEJ6f32jRqKoaoCSqJ9u9KQNtxFeX7+dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJDZC3nf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hwk45uul; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJDZC3nf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hwk45uul"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6IgNZ8000926;
	Thu, 6 Nov 2025 21:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2zLEMj7e7nHhYtU90YhdicRv9WcW6WHa9X+a2Hy2eOM=; b=
	EJDZC3nfD1sniP8mCaeAL0TOdvEzwL6EU+HIQszzZzDO8p6R/W9sW/Lp1EA/H44u
	hyiZurDlwaPl9YkZCeIVQPFvPup1Jq/+2M3M5jGNO/eVibDJXer0OmMPljv/IKDF
	JS7TyrDxSUojKOZqA+EjKz1ecIMe5k/k22eFfXJoH+mlAL6seJVwHk3l4xvzVez4
	V/JyKZfiXNvEvJqSK10EcQsD9+gXFxZhwF94gD1eRpVlfEEJ97MKl7j8Fyy+CPMk
	zmTMa07BaZzGd1AEn7qNmnjos9JpYmEbeJHPMU4C6MTW74Bs2BA3Es58bmAHD3BP
	c9dC3Ev3SF2e8FS5Y9dFdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yhj8hjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 21:02:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6KOGuZ023092;
	Thu, 6 Nov 2025 21:02:21 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ngg14e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 21:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXTjk0WoDPVbwTpYbd8Cza5/UAo8TMSzMJsKVBeyJly2gmLXZiRYzoELqGSR+eVLDoOX1fwCdBWIuGUUip9voNpO83762vTc2cR9PJaCs894MIqz6Lq3PJGVkxJ45Hz7vcbKpwSZ7R/PiXlpaTyH9p7l2+BBshjHMumdZGr7hVFxLaDRyLGpqKXzFcEd9k8HeZo1SWW94xwuUJ8LiZP/Urjwbvr1Oz5j0u+8VnYU4XElwqgbaA4uQWQUYDEP31NQ3SKe4A9AJ6y1wlOdf52hZjGUg5k+eLf7Ooy19mUYbNYqdh4dyGpzumByICm0sl9bMu1sNcUnRPofY26KcPn0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zLEMj7e7nHhYtU90YhdicRv9WcW6WHa9X+a2Hy2eOM=;
 b=Cw1WDDvxPv2iitjkwya9u91astmirMtzuHSmAWEQ/+D4OO3JJwdS+xmTiKTC0j98mSI7NBfxyi/eVx9AGZiFudmrukcbPNNrXjArnoAGCT8e/A5AdZ7nbGIC9W28lJMcPZmlXvIlQ/qBC7lesNNfO/unCGR2xBj+L/R343fDXCF0lg8xXhuBBlfeKa6g2duqH2oLTa5Fz/XHWHyPvFUHaIoHwldvpZioRFDI37thJHAJLE3/eWlBTPhpoQOdbKWxkl2lTid44N5y5PW26o2dPOOfXU5+F4l3Z+7KfGPkb6jgwXGDt/9mMjijYbPm/4McqLhNw6dVl3o269uS5bK1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zLEMj7e7nHhYtU90YhdicRv9WcW6WHa9X+a2Hy2eOM=;
 b=Hwk45uulvw2JApZG6tOhLLq7IeRyVYVLI80O7KbBaZTFFqpU7xiK4SLHpyMDMoryUfIUhh43J1OeXvKHhky6dd1a63LsVsQeOrtpX483kjMJYMSo3TsBk5Sjxpps9Af7yHSBacQgc6rU4H6rQ/CjauhP/i4hpH3czBmXyweM6ds=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DM3PR10MB7926.namprd10.prod.outlook.com (2603:10b6:0:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 21:02:15 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%5]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 21:02:15 +0000
Message-ID: <733c2079-2cd8-48ef-809e-b42bf74b3bd9@oracle.com>
Date: Thu, 6 Nov 2025 13:02:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Florian Weimer <fweimer@redhat.com>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <2d713719-709d-4b46-8234-2dfe948b836a@oracle.com>
 <CAN30aBGEpwA+ZROXufqBL6MHM70oWTtNpGSioCMhxT8yS2t-Pg@mail.gmail.com>
 <9c11b765-66df-46f3-b4ea-a0c7f52dac35@oracle.com>
 <lhuikfniop1.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <lhuikfniop1.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::13) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DM3PR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: f567e1e5-ac68-4b43-83a9-08de1d77c33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnFPWWVHb0g3Rk1Eb2VPTFoydjJSd3pzVldOcFhnTERSWG5SZ1UvT3licEc5?=
 =?utf-8?B?VHlXV0grZTkrUDc2a0g0UG1wNnQ3OW8ySlVyVFBHL01kV0l6b0M0RXFrSmx3?=
 =?utf-8?B?OU9BUWIrSDVSUDNFMHV5UXEvSzJrcFRkeE9Xb29uUnlNaHp0NExadk5nV2JI?=
 =?utf-8?B?SCtma2Y0cFBDY1RQUnJxcU9vUEw0Qy9xU2dLMm14azZ5T3pHVFBFUkFrOWpq?=
 =?utf-8?B?NnNlSUpieVVSRUs4UE1leERudk1CZmNrUElkb1Ntdkt4b1ZiMklweXBCd1Zn?=
 =?utf-8?B?eWx1RDE3ckhUM21qYStEOHBxb2wrV3gxbE5jWlJjY2R4bFd6MG9GVHpIRFlN?=
 =?utf-8?B?RXZmNDMrQjJmL1pzUndQOU1Cb3NJYkZuTUdncFRoWEt2UUxIcmJkTzhxVTNH?=
 =?utf-8?B?ZWI0OFpVcDkxYWhRcWxwL2RzYithTDBSaFZKSGNPb3hjb3FEc2dtY2VMTTkw?=
 =?utf-8?B?OGZRZkp4S0xhajBvQTJlaDhaVDg5MW1xUnRDTDdmenpLMkRyakQzSml6TjJV?=
 =?utf-8?B?VFBVWmJVQnJ5enVhMkFkMzFRZ1hzN2hvektudVJXUGhqZllNekdQajY3OGdJ?=
 =?utf-8?B?NXdwZzU3VnFnSldRMmFYaU5xZmdXTmRaL0VIQzdtM1E5MWNUdzluWWhmYm1a?=
 =?utf-8?B?ZkYyamZleDFRb0JRaVFPZlNFN0l3Sis3WDd1dFpBaHA0RjlvclVjUVV4Y1Fw?=
 =?utf-8?B?bVl2SFo3RzhkcjhHd1ZjSzNreDQ3VTVPVUFzV2R6Sms4Um00dFluOGNSeHJv?=
 =?utf-8?B?RjZTcm5CY3UyY25xMVFSWXRkdGRiTURRWTZWYkp2czBSMW5JMGIydWFndUdF?=
 =?utf-8?B?QmJjaXZVeUpnSWM1NHdxWTFidTZ6LzUvZDBlTEljaXZCOHZvbVBsWmxpQUIr?=
 =?utf-8?B?TFRrcE9BQm0rQk9TK3BQcGJCcFVCWCtXZXlVYytPVFMvL3JHdytSL0ZIUm55?=
 =?utf-8?B?aUZGNjZGOExSRmpPY2g5QVY2S0pTRjBCTXhEblRXVmt0NkUza2tEeG1WRDNv?=
 =?utf-8?B?V2I2dUhlTTZlMWVHcVNmbmRqVVFUN05PSDhzeGJwM1VTOHI5MmhZRXNTVzJr?=
 =?utf-8?B?V1N4Z1pTbEV2aFl5QTRUK2JVa3p4QUFWRXZJWnFqMGRJMjBZejVWeExyM0RM?=
 =?utf-8?B?MzhqNWtxd2RaZC85VVNnWVRTdVk4bUcvQVZZNE5IZ1ZlTHlzeTZjcmRzWUNw?=
 =?utf-8?B?c2Fhb09ZSnlBL0xwTEJQS0dPUHlCa1ZxanBERjdPNjgzbXF6VW1zSXNlOFRU?=
 =?utf-8?B?cStUbjdMaDQ3RUE5TlhEekMrcVBRbWp5RWxwM1NYUjZoS3NmYSt1WVhCK0tx?=
 =?utf-8?B?YlRVaG80eUR4a0lPZGpBNUk0OUwzK3NzVDROaXptdHF4OGlRRktFL0JBYThQ?=
 =?utf-8?B?ZWp5dEZJNGc4TjgrZlc2R2dtZ3gwZ2JJODV2K2NBMnNaSUhaWDJscDhpUW0r?=
 =?utf-8?B?Y3ZBQzdQTkU0U0Y1VDlWK21oYS9aMGxyRkRQaFo5SndnSmFUTzZqWkJWa0t3?=
 =?utf-8?B?V1RPTndOb0JOcElDUFdoRnZqZmR1dW80SDdXeUZjQi95UTJxYkpTdnFvUzFu?=
 =?utf-8?B?ODVsS3U0bmRMY3pwK2lsNjlvRFIzR3BGVlRvWk5OWlRMMmpuZlllWEw4UFJL?=
 =?utf-8?B?VWNySkpGSGp4bC9qNEphS0hZcVlVWEd2c2FUWWVXM1RBY0lyT1lVZGR2UitE?=
 =?utf-8?B?N24zZDA4Mnp6Z2Y1cktLZXBtemN6ZUhBQkU3eHdkdUdrRksrSDVvTFVDYms2?=
 =?utf-8?B?YUg3SFQ2NkpPQ3RpdFMzdHNNUXZqR3NhdU1KUmNSdmk3bGVKQ3RmMXBXYTZp?=
 =?utf-8?B?d3RYNEhia2taRkJrMnFtT1VsMXF1M3Mvc2txYUY1dFlOWUh3amxQNDZ1Qkcy?=
 =?utf-8?B?M2Z2emZSbFdIZW45a0NOakltZ1krMkxnSjNLRGVZV2RZMEFuQ3ZvUVpvY01K?=
 =?utf-8?Q?MAvCqxKIHKH25xl8pL44ExeSD/g5jJ3h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXNIeTRVMWFlTWdnSlVKaDhnL0VEamdWNzFCb0VPeGk3TzJ0MXJKUUpPdU0x?=
 =?utf-8?B?aWNaSmxXaTkweko0T3NrMk1WODBRcHFIRGpJQloyY0x1VGxYc1FGZ01lNXZl?=
 =?utf-8?B?dTJwWFJvZ2JQZ3JTM1JQNGR4Rk9pNEo4RkpUdVh2cXhwWjYyYWt0UEREb2FP?=
 =?utf-8?B?YkpMOG9lU2lsaHpKeG5jdU00c09Tb1RuTXpWcGxDMzE4ck5ZT3FUZytOV0VQ?=
 =?utf-8?B?OXNqRDQrOGh0QWx1aWpuOTdsdGlUREV0djUzKzFsMlh4U09vMkJ0ZlpPWm0z?=
 =?utf-8?B?OHlPYkR4M1h5UkM1SjBvUndrV1dWOGJCNUsrTkRqTXYxbWo2dG5wQktBQWdY?=
 =?utf-8?B?NFJQUUxUSWl6Nm9SQ2tNUThBUDdXb2Q5UFphQ2ZFVjNkWU91OUg0N0RjaXpz?=
 =?utf-8?B?Y2hKNkd3Q2xvZkxkSVJha2YwYzNzTGcyYTBIdmwxbmNOUHhDNUU0YWE3Mlow?=
 =?utf-8?B?dEkxaW5Ud3J3WHkzaW9wMFc0bk1CcUtKS01RcjNzSWpNZkxmZW1aTGI4Q3NL?=
 =?utf-8?B?LytiWGw0bUtMUjVjUnlZYXNPSEtINkZhblRjY29Xak13Rnk3dGx0M1pjVVN5?=
 =?utf-8?B?UklDOGFuUUtic29KdXo2QzFBRm5JTzFKWmxFbXVRVlZLZ0UvOHhoQU9TOTM2?=
 =?utf-8?B?Vzc1Y21CY3hxVnJ3MXRUU1lwVGRMM2RPN1hzTXJmbDgrUmpKYktNSFlCNmM5?=
 =?utf-8?B?dW5MNTBPSGVQeGdjYjZ4MnZEZjY3SzNyaTdtTmpTYWNSUXl0NXp2MXlPS3lV?=
 =?utf-8?B?N2E0WE5SOFpqMFQzTUtFTnpPNnhBei9vQlVMaG5LRUZxa0k4UytGUUR6c094?=
 =?utf-8?B?MmJWR2gvTlFZOTNxQUlVd1RLVlM0czVjcUNuOEg2aE50dWdPQkNsQ1FIQzZt?=
 =?utf-8?B?Mk95QTVnR3BTenpFMzhld0pNUG1lK3hSdS9DcTUvWm8waDBtdlU3UDRBbmlF?=
 =?utf-8?B?bEtCL0gwQ3lkQmZpRjNkSG02YllOSndaVDg2L093YzR1Q2oyNkZOS3lTZERj?=
 =?utf-8?B?SXlJQlBzZUdVVDhkWDlJMVlCY2txVW1vRkRKeXEwbkcxbk5PNHFKSnE5cnFl?=
 =?utf-8?B?dGFqVXY0R2V6QUg3ZGlmeDdDSzlGem5OV3ZERUxBdmhZT2F6WFlpc3lZVUpI?=
 =?utf-8?B?MWJQWldOUnNYWUpYVVhPTzdEUjIwenBEa29Ybm4rbTJWY1hNSEtFZ0N3UWds?=
 =?utf-8?B?dFRDR2FLaUpjaER0NmJlL0x6cy9abjRwOEhoUStWdFpNTk9adlBqUzJCeVcw?=
 =?utf-8?B?Q1R2eVpEL3UzVWhESXk4YytUa2t3K1JNaFRMVXI1eUViMStyamh0OGNSU2hp?=
 =?utf-8?B?c1hYN081MDFoa1U4MzhEODE5bThTUEVRRGYxUWlCRW1SRXR6a2c0Wmk3Z0RU?=
 =?utf-8?B?MmxXWmlUV2VXSlZhUVh0VVlTbkJ3a0o1MTFMdW5abVcyc3A1YWFjRTJxWXlq?=
 =?utf-8?B?UmFlL3ZFeWpRY0dVL0tiNlcyZW5iY3dTZklwVHcwNEg4MlF0RWxpSFYxUity?=
 =?utf-8?B?dVMzalAvVEt1eUZ6SFY0M3dxcUtVNkZkWTArdkdVa0pnLytpNU9PMmtKVWtW?=
 =?utf-8?B?WEtidEs4UDNRUU9vMTNlSlhnQklXT0owcHJvUDkxUk85d3VzRmI0LzBMajNY?=
 =?utf-8?B?cU1RTUxwK1Y4S2lCbmxFRENJWjROMFQyN2dnS1Z4TUFNM1YzZVhIMHdQM1RI?=
 =?utf-8?B?THo2WEovSEQ0NkJCMHkyKzhrcmdiUUZtUkkwQUNCVXliNk55YTk5ajBLY1Uy?=
 =?utf-8?B?cEhmL0g3V21vbVVRbVp6aXVNcnI5TUNLaEVWMGt2am12c3VtRXhBSjQ4clB2?=
 =?utf-8?B?NmxHZXBNOHRhVlRKNjZhY0VuWlpROEdSN0pLak9JeVZJcE1OdHpCNTFtaDJE?=
 =?utf-8?B?Ry9BelRjSFBTaTNieThlYXh4NjZsQWw2V0JaSU9DZ1VHZjZCMllIUkkvZ0Rx?=
 =?utf-8?B?UHNmTDU2TDkwTVVYK3hDZkNMUlhRbklKM0dTTGlveVFRYVE4OEJqaUVUZUJn?=
 =?utf-8?B?M3IwbGk5a09NMVd1U2VxYTRZV0duYzdsRkJacURCUVc1dzBGTk1QVWFJLzR1?=
 =?utf-8?B?RVpSb3YxOFF5Zk5nd1dvRTdreEhKSUdZQ2VjNDJQZm1NRkk4ZlJ6aEZhRGlq?=
 =?utf-8?B?SFRWZUV1Q2NHMUNsaFdCY3hnNmhjY2VtVkJ0SkhuQTRuSmpmalA5bGxnWCtx?=
 =?utf-8?Q?u6j8qh5BJQLDmRqqDPzt8S4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZypswLAUuHrXT3owdaugbM3QTSHrU+DK4FHdSN9XdSQyZRP3k17Nn3+f4u7kJ2NivLGYCZts7vjCJfZuihhMlQ9rGO1CIEw6MKafL3C5EYSRyepAGakcn1jDm6MJWb8mNg+zUympUF9vFgmngHHvgHRb1XjPicGkah88muNb0fN3URLMSZ3t4hJiEzi3rBu2IROJFg32gAeOYtNY0yT3Fns/fGYoZQM+rk6fnqc/KdATgrW+0hvG14tZpWFdr2NU9rC4G7lifw1c7CcqXB0Jb4e7LrrhhrrD7GLwqRx4Cb9590g14Dp3vGT+ycm3QRtnh4QQ14Gr2gVuk1RGhvoRIZqXNX9fN3QIWGE6oDTnb0mGr5NEV9hzq25qLoIAw+uEO8VOlf4FvWjWlDqICDJPFDyfTVI9BBz2a9TeVwTqk8qE4vpDjgC0uajTKNwYBT9aRXPbDPfTUiSW0HRWxnNSdjMel6U+jv++4emC3yY71gH7rLdzvQAxqcUKX5DvhGTNFBwZ5swLecZ4RppKu62ZOIR7tOpWES+XDckJUcGM6/oLtAQerMTP+D1Tytkmt0UzL9PKFZ4B+YXLAozTDfLQ89Ok7rHfDXdjk8uvBeODDH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f567e1e5-ac68-4b43-83a9-08de1d77c33d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 21:02:14.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Da+qkSR4KmSrHG53vROHcuAtW7+IbQFcktbED51Cc3L2tQ3VTI7zY+Fxn7F8e3eAlmJh459mgc5XjKuQ4Q4p6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=789 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511060171
X-Proofpoint-ORIG-GUID: iZQ9y65-Kwa6TxWj6i1e07wYFrP3Q6wW
X-Proofpoint-GUID: iZQ9y65-Kwa6TxWj6i1e07wYFrP3Q6wW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNSBTYWx0ZWRfX/NOiUVl0zfl9
 8pEVqrB7o1A2CFMXrv6u9eEDFfciBvwxb57Ym9UTH3Qgu9svrNHA7MjIpiqO6KxuMysIz+byMzJ
 AqIpkqkhpICBJguU/5/tFh+MpoqwNvCZ5vxVXv2SmD8TgZchxQ9MI6IXQ4UYoLPQBvzlb2bnW/1
 oacl6hrcdjnzHNFpJR0pQtmQga5pu18Ffe6rOAx0LejZP8uVBKdtIhvjQjGeGuM2HCsnaE2VHk1
 52JC1V9+NbbrQ1tw6nOOtIZS3hqqQiNAGCSvdAEqY/o+e9+hwAkFWHgLAEjkvlEy03i6HjQrJiW
 btRRbcFQP3ZBy78baQT7KZDm1HGY0o1yQAh9NY2M99elgWL74OytKVlqWn2jTQlXBrwiGIOi+BW
 2yemFvIN59R3MG1u2lhforwQ/bGd4PdL7OCnD4p8zOl3LpNdN0o=
X-Authority-Analysis: v=2.4 cv=Lr+fC3dc c=1 sm=1 tr=0 ts=690d0cde b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-TRGmtq9tEvMLg3g-MQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12100

On 11/5/25 11:51 PM, Florian Weimer wrote:
> * Indu Bhagat:
> 
>> PLT stubs may use stack (push to stack). As per the document "A null
>> frame (MODE = 8) is the simplest possible frame, with no allocated
>> stack of either kind (hence no saved registers)".  So null frame can
>> be used for PLT only if the functions invoking the PLT stub were using
>> an RBP-based frame.  Isnt it ?
> 
> I think I said this before, but I don't think new toolchain features
> need to support lazy binding.  Without lazy bindings, the PLT stubs do
> not change the stack pointer or frame pointer and just make a tail call.
> 
> Do you see a need for continued support of lazy binding?
> 

(Yes, you did mention this before in another thread on Binutils.)

My thinking has been: some linker emulations default to lazy (I guess 
the reason is changing the default is difficult).  So, users may end up 
continuing with lazy bindings unknowingly ?

But I guess not designing new toolchain features to support lazy binding 
seems reasonable.

Thanks




