Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CA372;
	Tue,  2 Jul 2024 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893041; cv=fail; b=D/Q6/iyNlsh5QMtFU0cUZ/SZZi/Px4ZBMDBVChn3/JyGMpn6XfcgADQzc2dL0GoWcIGEf60wHYAVMjaGUptzZ6WXxeDZtyREseOmwRS6qh6Dgp5y/oDnytfgxcuYctqBRLnRLqkglfwo6Y7yuoc32/wP5kRQp0Z5j61Q+g49/dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893041; c=relaxed/simple;
	bh=GL4WdBFFovU5jftxFaqkIe6BJtIXmQstlY+OjKb11x0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyW1jSG4DxKRtPeEAxHVxz0adJ3pjlJLUVv0/YmPfWLjDu4lhhAmtmA3bQAsP+5atwPeKk0FbbtTEXp7oYnURP/Kle8lQG/AnP4GttBzIclB2nVmCrk2Vw/efSfji14sNtDasHWzlOH4PF9dhdoUueBkRinUPughsgnxl2g8BlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZI6F9RYq; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZI6F9RYq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eq6j+CSDQOLtfUp3xp+JPamQqaC9y9jUQqWH1OXUpcQWvuZ2RxbvcNOnhl9U8UlaiUnu1eAile4egrZ4vjpSSCsYZerX1CXUTx0+7i/xSvBiR0gOOw+ddXBZ+IHIbM86lZZwJkwObzK/EY6ue5RaRkJOUkKcUzm1MirRJ1NSosm0Gab0BjRMBR2U1RacDnHTcNEk4tGj88LO1yWMKcH1f7JKSRWQAATKOh3E4kP/8RXHCmPsP4uyFcCE+NmGHVU030FPN689iYbZY/eYxhLlTSvn+kjTNu5yeXF+I+1T5UIlGMbu3YUpF2Yn6wW3Rgls3WpdAxE9Fd/yabAxKSIK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFjAgM9+fa/BRSH/ubMDs59N11w4GqqNSBlQ4Fx94yY=;
 b=SChahHePS6EuuhjFA/uCQYlPw+C6ZRMK+a6kMiH2h1yTPTuh/HjNutGfI8eQLjxmF8qi5o2XTGTRMF146HJ38yieGGWA7BDtw3WjSc6NI2rL9J3FJzGfd4XGEZRtS8iPFj4Ebk5P+9uJ1IQGChEEfcmUk4n6SSkXToDUMnxQwZJEohsxyrCcQ/BjclF+R8bMd3dcOi5pyIork/sx9SU9KX4BbORTBrzi/+tpoH+91h+AZLg1bO6+2nuhAtpaP8GN2XawE56uzGn7XXytXEManIoD5Vz2Hz99ry1qWUCT0cakNTkIm/wSQKKNmhHwNjUMOyfB3By6ILTonJ2FDWNieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFjAgM9+fa/BRSH/ubMDs59N11w4GqqNSBlQ4Fx94yY=;
 b=ZI6F9RYqXGy3zv9upaVyS9PzNecLfhQX98qzvx2hREna0vdRn9X7fETxS5EBlfAvHFaLQvKiY1U5uBLALCEOep3iMNEBQHjW3DFpENrmIXF0bQpdsP16ChivH9024cWGaJIwKwFp4Ljpcgb82D/KMi2HbbG8aGoJATqLgtSLZ/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 04:03:56 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 04:03:55 +0000
Message-ID: <7a34a58b-9366-46a4-92ca-e36e378311f5@amd.com>
Date: Tue, 2 Jul 2024 09:33:43 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf/x86/amd: check event before enable to avoid GPF
To: George Kennedy <george.kennedy@oracle.com>
Cc: harshit.m.mogalapalli@oracle.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <1716990659-2427-1-git-send-email-george.kennedy@oracle.com>
 <75f6aba1-8ed6-4ef8-8811-de40ae40be90@amd.com>
 <1e14ca4b-6e3e-4d57-acec-bc3ee2bed6ed@oracle.com>
 <0494aedf-9759-4427-a7f3-39a91bd5771d@oracle.com>
 <3ec1cb26-c889-45ab-b8cc-92f933a2b5d1@amd.com>
 <7b27a039-ddb9-4beb-a1b4-ba2b74a3043e@oracle.com>
 <17bfa7c1-43b7-4b25-a8cf-eb6d3797df5a@amd.com>
 <36e86320-1a43-45d4-b25e-a5d60857f4b2@oracle.com>
 <78db946d-db24-408e-92fc-b7ff79c80728@amd.com>
 <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
Content-Language: en-US
In-Reply-To: <e193949b-d969-42e7-a0f3-fbea6e4dfe12@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 93198b00-b38d-41de-44f1-08dc9a4bfe0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0ZwUGRtTThlKzFYajNBS1hjcGgvMVdvMjcwWnAvdWVDTExGK3lVY0JPYVlt?=
 =?utf-8?B?Y3d5S3ZnYXNoZnJsY3BmdjdGSSt3dTAwRTJEVTgyY1JEeWVJZmpiVHhXS1Jm?=
 =?utf-8?B?OFVIQ0VnZ2U4Y2NIMEorNTRQWllFaHh1S29wai84cnRvb3U0aGJYYWkvRzZr?=
 =?utf-8?B?Wm1qRkNORTRJeCtSWG9hanZvWThFL2VuZjRTMTlLQU0rWldzN2t1MlY0S1Z4?=
 =?utf-8?B?Q09lY0N0N0pFR1RvMFdDNnhqelRPeFI3bHdyNlN1WU5iandWdkJFYktkeS8z?=
 =?utf-8?B?eXdjQmVuay95Um9NWnJkaHNjVzZoYmpMa0xSeDJsR080aEIzOE56YWMrelpn?=
 =?utf-8?B?d2hqVkVQaEhKOWpta3ZEWitNaERNTXZiNTZPaktaOW5pdzZwUWJQTDFiRE1z?=
 =?utf-8?B?WnJxNk9aRm1BeWpGNDN2RHFLOUJRMUdRUnVMR0dZYU9VbkUvc1VmbXdJWWJw?=
 =?utf-8?B?bTRiMVdibzFmTEVnd3JQQkEvQXhOK1FjaWwzMmZ6bkV6cGluT0dLRklXWHpW?=
 =?utf-8?B?OWs3UzhaaCtXZWx4UmJ3dVBXMkpkTGFBS2tNNnBia2hUTjFVSDlyU2R1WjFN?=
 =?utf-8?B?Qk9PWGVnYkVXV1VNemRJalc1eXB0NmpPZXBYTUl6UnFnaVppbmd4S3dwekxO?=
 =?utf-8?B?VytNb2svTTFsQ1dKRVRGOGVmTTBrNS91cFprVlpwU2NHckRpb3UwTHJNQkFz?=
 =?utf-8?B?ZUc1b0QvY0VIUkJ4QlhCbWZ3SmNiMVNEL2t0czhpYU0yZStLYTZnZ1FRdFBk?=
 =?utf-8?B?bmF2YmwxeW9OMTFhWis4RVdNR3dDdG0wOTZJSVNUUXN2UDBudWp1QTZyaTla?=
 =?utf-8?B?aTFEZ3hBY0ZIQUYrSDhFL2U3emF6WVR5dnUrWTRqZmwvbUpieU90K0dZTGha?=
 =?utf-8?B?QnlWUGdXTFJaby9UTjlrS0pxWjVBUS8waGd5QzR1c3lodjFvWmRoWjFUQVhz?=
 =?utf-8?B?Q1JvdjRTbUFEZ3dtSDd6WFNHcmVzb1pWRnI4SGFlMGRoazFXdjVPbmVlcy9S?=
 =?utf-8?B?NmlLTHNIYXNnS1lUNTg4aHg0RUlYazJrYW1scWhhNWVBUXFrd2tCaXk5Q0VR?=
 =?utf-8?B?ZUY0dmsrK0tJMlNHazl6VmJFdHh6RWFQY3AvT052bmdKOGdnK2l2bU15ZUxw?=
 =?utf-8?B?V3ozMWxSZGp1Zy9zRi9rVWNWRGc5OUV0eGVoOHV2d2NPTk9Fbi9INzllMXJF?=
 =?utf-8?B?U1ptUzJRVTl3TXlGQ2lxSnp3TE1QNnVHSW13NUZMY0pWdnZYWFVMSEQ4aGdr?=
 =?utf-8?B?ZW4zWVJlVzg1Wk0yUDR1MjEreU9HOExYaWlrM1kwdFRvS0djZTNiaWZmU1I1?=
 =?utf-8?B?QTZGUmk4SW5abER0MldLdlVJVm5VZE1Gb1ZQTGhWVkpzOWxUUHNmblJXQXdy?=
 =?utf-8?B?K2JMTVAzSDNZZHp1TEtjMmc2SWJKRjFXSnJwMVltQ211T2FlZ2lrdjA2ZVNP?=
 =?utf-8?B?UnZkNHZMUWVHSGh3MGhEc3dtWTdrNUhRaERlS01IMldLRkhNWElmK3htUFFq?=
 =?utf-8?B?cnBtOU9OblVmbVAwUHF6Nnk0bUNTRjI3OGM1bVJtZHJ3UnFoTFZtQnJlWDNJ?=
 =?utf-8?B?Zm1LaVh0andEOGhmTXp2SFR2QmpzVHdOYUYxdXNJUDdnOCtEMDFaNGp1c1c0?=
 =?utf-8?B?MTFBRnNPQ3ZqOUtFYWxiN0FCc2wrSW1Bc3Y1aGI3Q1h4d1lSMDdFRk9yRWNG?=
 =?utf-8?B?VTkyclNBdlhiNlpGSDRZa2YvaStlL3FNdE9YQTI2SWViSXY1blNyMGFLMlZ4?=
 =?utf-8?Q?l4S86iFBqZAcmHM6rM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1d1VE40VHdnd0NqR2pRdDJ6S1lmTDFSZlhTN0ZrT3l1YmFDSG5veWJTMkJx?=
 =?utf-8?B?dHZnMmV2WkJ2N0p2ZCtxbzFoMHpsRGhZczdscGNFSzRVQTdtY2RpNzVkSXp2?=
 =?utf-8?B?cDJpdEtndlRHWklZQm50N1dPaWIra0RPVDhrNmtYUnZGeElyZXJ4ai9leXd6?=
 =?utf-8?B?K2o1RjcrdU9xZ2NHNGF5NmR3QmpvL3U4Q0c0L3lGaTRUbU1pZWF1MVc4d0tH?=
 =?utf-8?B?K3JSRG8yOTlieGJXaDlvMHBFdU92Rmdwbmk4VHkybHQyQ1V4bmd6TDF2Z3RH?=
 =?utf-8?B?MGlUQVFKZzdONnhTem5QR1dqZzUzaDBYZDRJS1VESGRsZTY2L3lOVUpRODc4?=
 =?utf-8?B?cmZyVHJzRm1WcVhwSDZkSWxFeElidjAxdStnTkNEdlFGWFFJNVVWY2tMUTNs?=
 =?utf-8?B?VFdhSzQzS2lEWk1rOUFpMjJ3M3pVemVIQ28yR2NlejQ5aEtMd0pZcGlRak1v?=
 =?utf-8?B?VGpNOGhxZlVNWjVKOE1LZHpPSGErQnczNFVmeTdhdTZCckh3Q2xFYnhqYUFJ?=
 =?utf-8?B?T0kxTE1EY1FsQ0sxT1IwZ21jaFkzY0dKU2NGVGt4eVplazBzenRMZVBudlo5?=
 =?utf-8?B?ZU94WlAyTWV4L2kyZDZmRFQ2SmpTd280dU1nZWp3QkZNTi9DOFBBUWJmZnJE?=
 =?utf-8?B?WDhoTVU4SUxhL2RCRkxVWFB5bzhNVndXUVJBQUNMRDJnT0M2T2EyY3dEbCtT?=
 =?utf-8?B?ektkN2FJWUF5WU9NY2h0VmtOTVlCWGFnL1BhdWI3UG4vSFErckJRNEZja3dJ?=
 =?utf-8?B?NFE4UmJ6OGk4NFBpcytqVVhISjlIYS9BU2pZNEZNUFdFZlAwdUpJUGtaaS92?=
 =?utf-8?B?L1RVNm9sc0tYZjZZNFpSWHA1Y0R3VmZkOHZLNkhDenNaVWx4TnFjK1V0NC9X?=
 =?utf-8?B?Z1hDQ25pWERYTmw2enRKN0JEb3hVdTRKR1lTdlMxQVFFVHUvb0NrT1dETFNu?=
 =?utf-8?B?T3FYS2toc1VPNGRNR2t2TFQ4RUx3T29kRW1Rdnp4V2xtK3NQM0xsbkVlcFR5?=
 =?utf-8?B?VE9EZFdoZkNDeHZEb1htRlE1OGQxZmhzUVZJT1YrMVZSMEZRMnBTS0d2R0E3?=
 =?utf-8?B?c3VsZXRlQ3h4V0QxTHBJbWhCMnh3MjVobTlEdnJ0VlNOL3pQYk5sbkxCSnJZ?=
 =?utf-8?B?eHc5M3BsN0pDK1YzTnRWR1BUOFd2cGYyNlcrZnBTRTJxMFBKSUN3MjRoZGpT?=
 =?utf-8?B?Sk5CdXJQUCtLbnB1b3FlTmpWTGtYTXZFRzI0Ym14M0RVcmVDLzQ1UThRUGdY?=
 =?utf-8?B?SnRQZ3Q3Z3V4OXZYd0lhUGtPUlM2ZzJLS1hFMXY5Zm10eHpNTW11dVBUTG1p?=
 =?utf-8?B?TTQ2SEJSYW1rQWcvYUduK2JyNk1saVRJWG5YSGFGNDFPNHkrYllZekZReEFH?=
 =?utf-8?B?V2tjbjl2VGpudjk4OXRDU0VLc25oNGhaTk5KU3BabWxzL292V2NSU1hmQi9K?=
 =?utf-8?B?UGF0UmphZWlJTVg4dVJiSWhpT3JKN05lZFV6OGp6R3prcXMvOHB4a1N6UE9x?=
 =?utf-8?B?TEcyaGpqN0tkSUdXbHkycWZDQ21zU0NXM0VBcDU2NDR0bTdPTEFrOHdvaG9X?=
 =?utf-8?B?Z05abWdTVHRObXh3YU9aaXM5ZGtIeXptREFaN2ZJZUlsZ3FVK2d0K2RHNXRy?=
 =?utf-8?B?VUZiSGpndDB4M1NoTU1HUjNHN0liVFRMNlo4NmZQdWJJYnlJOXRMNGlTOFN6?=
 =?utf-8?B?OHFJTDd4OUp1MzFOQWV5MlVvYUtYUHdUVFZRUkRzc3lnaGRFVWNnOFRtMU1U?=
 =?utf-8?B?WlVSVDd4dHh1V2EwWkRoTDAvbXh4Rkc5SE9rd01qUVlocDBzQVEyQ1BSNnN2?=
 =?utf-8?B?ZmYySG9HS1poZjB1ckZ1YVRqbDBWQndvRU5QRVAzTlR0eUpWd3VCMFdISHla?=
 =?utf-8?B?RmpTdzRKOTVnNHlBL09uSGJSNjNjcEhiTnY3U0ZkeWlZWE1CUlNWMnhKMjFE?=
 =?utf-8?B?MlVZRkxNdVFRZk4vQ0tlSTBQd3EvRnlVMC92Y0F6aWZmL2lDM1RDYVkvYkoz?=
 =?utf-8?B?cmhxTG5aa0thZ09zRWZNL0N1SGRPSTZ4eGVYbnVxWmZZV0dsVWticGl1RmRh?=
 =?utf-8?B?RGNXUWpFWGs5NWdBRkk3OVBwQ2s0amJBUXZvZXlSK3ZhbHY1SFJQN1VkQllQ?=
 =?utf-8?Q?2L1j7vvEQTck7mRiORbqHM7Za?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93198b00-b38d-41de-44f1-08dc9a4bfe0a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 04:03:55.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxzobW64t0MzK93eyVpz2o8WnK+ysoPdWXxgRavgQ0OYU85uDG/ariw4I7XR4eSgn73Y2q3NJvU/rIPdVxsw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

On 24-Jun-24 9:48 PM, George Kennedy wrote:
> 
> 
> On 6/10/2024 6:51 AM, Ravi Bangoria wrote:
>> On 6/8/2024 12:43 AM, George Kennedy wrote:
>>> Hi Ravi,
>>>
>>> On 6/4/2024 9:40 AM, Ravi Bangoria wrote:
>>>>> On 6/4/2024 9:16 AM, Ravi Bangoria wrote:
>>>>>>>>>> Events can be deleted and the entry can be NULL.
>>>>>>>>> Can you please also explain "how".
>>>>>>>> It looks like x86_pmu_stop() is clearing the bit in active_mask and setting the events entry to NULL (and doing it in the correct order) for the same events index that amd_pmu_enable_all() is trying to enable.
>>>>>>>>>> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
>>>>>>>>>> This appears to be an AMD only issue.
>>>>>>>>>>
>>>>>>>>>> Syzkaller reported a GPF in amd_pmu_enable_all.
>>>>>>>>> Can you please provide a bug report link? Also, any reproducer?
>>>>>>>> The Syzkaller reproducer can be found in this link:
>>>>>>>> https://lore.kernel.org/netdev/CAMt6jhyec7-TSFpr3F+_ikjpu39WV3jnCBBGwpzpBrPx55w20g@mail.gmail.com/T/#u
>>>>>>>>>> @@ -760,7 +760,8 @@ static void amd_pmu_enable_all(int added)
>>>>>>>>>>              if (!test_bit(idx, cpuc->active_mask))
>>>>>>>>>>                  continue;
>>>>>>>>>>      -        amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>>> +        if (cpuc->events[idx])
>>>>>>>>>> +            amd_pmu_enable_event(cpuc->events[idx]);
>>>>>>>>> What if cpuc->events[idx] becomes NULL after if (cpuc->events[idx]) but
>>>>>>>>> before amd_pmu_enable_event(cpuc->events[idx])?
>>>>>>>> Good question, but the crash has not reproduced with the proposed fix in hours of testing. It usually reproduces within minutes without the fix.
>>>>>>> Also, a similar fix is done in __intel_pmu_enable_all() in arch/x86/events/intel/core.c except that a WARN_ON_ONCE is done as well.
>>>>>>> See: https://elixir.bootlin.com/linux/v6.10-rc1/source/arch/x86/events/intel/core.c#L2256
>>>>>> There are subtle differences between Intel and AMD pmu implementation.
>>>>>> __intel_pmu_enable_all() enables all event with single WRMSR whereas
>>>>>> amd_pmu_enable_all() loops over each PMC and enables it individually.
>>>>>>
>>>>>> The WARN_ON_ONCE() is important because it will warn about potential
>>>>>> sw bug somewhere else.
>>>>> We could add a similar WARN_ON_ONCE() to the proposed patch.
>>>> Sure, that would help in future. But for current splat, can you please
>>>> try to rootcause the underlying race condition?
>>> Were you able to reproduce the crash on the AMD machine?
>> I'm able to reproduce within the KVM guest. Will try to investigate further.
> 
> Hi Ravi,
> 
> Any new status?

I was able to reproduce it with passthrough pmu[1] as well on a Zen4 machine
where Host has PerfMonV2 support (GlobalCtrl etc) but guest do not. I've
debugged it at some extent and seeing some race conditions, but not working
on this with top priority since this requires root/CAP_PERFMON privileges to
cause a crash. I'll resume investigation once I get some time. Sorry about
the delay.

[1] https://lore.kernel.org/all/20240506053020.3911940-1-mizhang@google.com

Thanks,
Ravi
