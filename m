Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F737160;
	Mon,  9 Sep 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864274; cv=fail; b=QsQBTbC61UFwM8CmdSDYrIuqZJY7XsCN9E/Dq2zmA/fhNrnCvbN5tGHMsQ8CC9ShrhJnguCdFSRvKB4IpEv9b0GVNkw32l8p0psgXq14zo/NFxz+iYB8BqTYVuT1W0oytmNhxM+JgTK6/mhrUxPuKPrK49nFh5jjAdHPrdOdjoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864274; c=relaxed/simple;
	bh=7/l2iGMOWifdOrqvZTyiCX2qzXSmP8STZfPKD4lXAVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hoWLh6X0B5SQ40wuPjYJ9NgGQzEVp1f7mS2/ELnZTCZZT1AOJrNFgJ2ghoz04nmJkiGHKy0APGx0YDYK/voOVSIFRget1ZGOA9ewCd/nwpwIOo/uLWvdCIqNuy68ccvUzIcu4N5F3EBXx+tLhcdP06WKywQt/PfafT1GDTZQ2DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QrwTkiCw; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QrwTkiCw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jut2BZT/5ZTVSRt4NCZCtTjsXjxeAq5znVixgDnxL/U7leki01x/YRIr7QAw1RqsoclePBbG/CUgttUHPB8MFP49FSOoSpy7nO6qcXcUrssPfQqT9v/EajQzXFx9qKnTv6iNrcqS5KvkjIxS2yI3ws9zVCf4w3bwFGgvhWMcSxy3C3AgizIeA8hMwzB85SND47ADPga2YeGu5Uz/YkEQO3S+ri0aac3YTyM9roNuiwUA1cXpOLe3llfoAtGEK4W73tevliU5COQud3DWBH0wNbBlO+2PxnPNcYoNWBCw4cvez7zJnMJTjyBzJ0bTg9iYnIMlNdP+1Rhy+qUK1NsRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zj/804J8AzK1e1ZOt+rqInWmFxe35omcvi66DsqPvg=;
 b=PrOpFwfrRZlWyMRAPEnTm2AlUh1idZ06+Ls2k3eOnXtjNQV22szC0D8P5HbuqZmQnqeq3cy1Jhj0n2Y26uekRy22wLAkqPaf27AUcxizMTohkwKM9D65w60sP05ZPWQqcD4hyIAHLONkNsx/7AEh2kvF6Ez8P4GcGXUMZmEckmQ9qU//i6U4VS5nrkYa7J7Pu4mt46tnl7MbK+Q+kgJQBKJVZh5TKDkaOlSCJ3gA1EV3XJ2GEhMKo6mBsFZpAAybvisADYYLn+KLnFmvgXWRjMCWFEk9oar54TY4TnENqwizcKqem2O8OBtr0Ur+twVS//fExOrdKR8FpxOqJX6dDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zj/804J8AzK1e1ZOt+rqInWmFxe35omcvi66DsqPvg=;
 b=QrwTkiCwtfkpTTmjOxb1jccUZ4Oapz149h/HPhEreCpKjtSHPh7BPfI5gARpfScXzaPYf7QOZYZUyS3x3dsbSipfz3L7ab2TTgPVo96hLcGmD+0ULNSUgfGPsHK6YRnlQOvvnqI3Ul2AtjVtZvA6aK3Gg2NB7H2myfCvjHMWRsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Mon, 9 Sep
 2024 06:44:29 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 06:44:29 +0000
Message-ID: <a310b7a1-b11d-4efa-8352-c57875047ac3@amd.com>
Date: Mon, 9 Sep 2024 12:14:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
To: Ingo Molnar <mingo@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
 <90028792-19b0-4371-a8b4-0a37612b4c9b@linux.intel.com>
 <ZtmC8hhpUvQTXFDn@gmail.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <ZtmC8hhpUvQTXFDn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::9) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b76c47b-015c-4607-d516-08dcd09ada74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjdYbXd0b1ZmNW1aRlNxNjQ1U0FoU0NGR0xGWU9PL0NGUEJpeEFtc3JYcitO?=
 =?utf-8?B?d3dmUnhHeTcxYkpJRG5pQ2FaWStjNGJUMW9lUzFjSHdWWDMxdG0vYk56cld6?=
 =?utf-8?B?eHpaZVN0S2h6TG1yb1Z4OVd6LzlrM0kvcTBvT1doTi9VRnBpdGdhbFpiWUgy?=
 =?utf-8?B?NWRobEtMeVFBeDN4TitSSlNCUWJlcE5ONzJ4a28wSC9RckhNOVorTVdaS3M4?=
 =?utf-8?B?WnZSMG4yZFFBWUhRaXBmK0NYUkJHTi9JblR3UU5FWGZRM3dGRUlMNU9ackU2?=
 =?utf-8?B?MmEveU02OUE0WlV5RGFBYlM2MFE5STFYaGE3bFpDeDZwMGxiK0dHN1NDcVJV?=
 =?utf-8?B?YlAyb3k4cjVhQ1hqRE5FWlFaZ1FSYjBSY0xqUFpSMUhlNGdXSTB3R21aMmlk?=
 =?utf-8?B?Y3JSenk0TmRZd2FtVzd5aDJmbElLNjA0bUdMdUdnVEc1aTRzZE5yZzErOGxt?=
 =?utf-8?B?YldqUThGTDVwTjVHc3R4RUJTQTFiRnkvVE04OWtFaENrRHdzaTJxcXVqK2p0?=
 =?utf-8?B?MHNDTnhneXFWRWg4ZEhSQkY1empnQmVYdVdpbzhJNXJXZ2o3UUtMS0M5Y3NH?=
 =?utf-8?B?NDk3QU1pODZ3cFdReWdFeVh5OEdkR2JZNnBwelY5ZHZjM1NvVGZEUEdHU1pu?=
 =?utf-8?B?Y3VHcHdxb2pFZnF3MXI1d2hXaUlyNTRsRm1VMy8yZGdkOUFyYUQ5RW9XSk91?=
 =?utf-8?B?eDhoVkkxNU5WRGZvSmVQUWVOTEJ4a3laK09TS0daOUlCNzlsbVNSTEdjSE4y?=
 =?utf-8?B?SStsSVh6RTlZbThBYXpjQ1NNWTlWbUZtZnVNOVhYcEF2ZG5Bb05BazFqU0VB?=
 =?utf-8?B?NDRCVnRJdHpEN0s5eGg0NVhra2t1U212aDk3bHZ1bkZ4QjhIVHVwUU00REg5?=
 =?utf-8?B?SEhFcUpORXQ2Zlg1SjY1MTJSVGRzWDhxTy9zVGZsZnJOZ29mY2s5VFh5RVhy?=
 =?utf-8?B?RG5qK285R1MwREUvOThDaWt5TkNhaUhlRUx6OEV3QnVHZEQ5YldONnI2T09h?=
 =?utf-8?B?NjROZ1lPaXNjQWRmT3JXTTM3L2hQWWM4Q2hUQnFIMUFxTVhrb0xDbmU4Mktt?=
 =?utf-8?B?akNxZWk4eDdFSnFWRWNmOFZ2YnVFa2RkZG9rL2pxT0tzdnQrMXhuWFJnUHdK?=
 =?utf-8?B?SThYNlVnSFY3Z2lEbTBPOFFFREtBVnBJdzJVL1NoakpNQmJybDRFbkljclBa?=
 =?utf-8?B?M0daTFNScGRBeUMrVTJ1ZTBGWDNLenhMZ3l3dDZ3NkdwcXE0eFBLazAyN3ZF?=
 =?utf-8?B?YUhvNmErMnYyRmdjR3RoTzJMY2dyclFFaHZtMXhncDMvQ1VSbzM5MEkxUVVZ?=
 =?utf-8?B?S2g5Vng5ZXM3SEQ2ZEVnVTY5NmoxSDNlSFFwVHJRVXhhY2ZMTzdyd3RNVDhh?=
 =?utf-8?B?VFoxa3pBbDllSk5wOVhaa0dZdCs2K1Q4bmxvYzJUbk85ODAvKzhTTU5HVXBK?=
 =?utf-8?B?WU51cktTVUlaMGJrS3pQdlFJbjdNK2plWUV4dEkwMXgvTmxYWWNYU0JNa3Zs?=
 =?utf-8?B?a2pQQkkvdVcvL1FhQ29PdnhVUGRjbmRZbUg1Q2h1ejBLalhrZ25GSlJEWTBZ?=
 =?utf-8?B?cHVKUEp4MWtraGMySWF0NTFRSytNc1JWQUhodkJUcTk1LzBEd3laVjlJRGtD?=
 =?utf-8?B?djIxTVFsYWFZR1RsTUVhTlQ2MzNlbzRjaFJDRFRVTzU5cFpZMGJRdkhPRlBI?=
 =?utf-8?B?SkZvUXVMV0ZtUEhBUjVoOUJycmcwcFU3WXZBN1JCQjFybUxFYVdmMEdxajBF?=
 =?utf-8?B?K2RnMnF6aFlHVy84bXdDOU9QVytMWjNkVzl0V3B4cG8vTXJkR1dTcmgzN01F?=
 =?utf-8?B?U0FwU2tiL3RMMGgyb3hhZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE8rWjk2ZW9CK1RzSmpDdmo1b2Y0bjNoK0lHN2w2aTlYVkphRHltRkg2OXVs?=
 =?utf-8?B?bHJTdXVOS0lxL245TUdOOHMxd1RrTHBLNnF3MTgrWXFuTVYxUUp1VTZZNy9t?=
 =?utf-8?B?VEg0aWxKZ0NjUjU2Q0RMUzkyc2o1WUYzUE54MVhaZy9Rb2Mra2w5aEVZb0Iy?=
 =?utf-8?B?WGFMOVdFTkN0L2RPNVlsYU8rdks2VU00WDVxdlRWSlIzVy9DcEl2aFRicW03?=
 =?utf-8?B?MWR6UXBlMDY4NEVqZmF0SzVLQ2trN2I2STUzS3Q4WW1pQXdJV1VhR2hTcW5Y?=
 =?utf-8?B?WnBIaSt4cithOUJhRGJiMDltSG01V1N3YzJ5dE8zVC91NjZaeW44UldiRFV5?=
 =?utf-8?B?YlpOakg5cm9rT2o2T01vU1M4RllYa013ZnB2Nk0vektNTlZjSEN2WGZhRmlH?=
 =?utf-8?B?UzZseGxmaW8xejd3QzJ2MGcvUVpIdDBNcG5QVG1pZTVPdk4zYXYrc2tiWm9D?=
 =?utf-8?B?ZTk4K3RnZnZMY2JkbEMrTUVMc05ieWZ6VkQ5Y3NycWI2akRmUDBnbENIaHN1?=
 =?utf-8?B?TEoyWlJTOUFHWkh1YnROQmF1eDhiNmpmQnFYTUJiR0tWODgwV0grcmlQZFhF?=
 =?utf-8?B?Q201bSs1NDdIMVl0SjBTTjhQQzh4dkVJb253b1AwSXB0VGxvOFdlMlNYMVNw?=
 =?utf-8?B?Q1lib3hIb2J0eFVmcCtYZFJzcitReVB5MCtwa3BqRUxXN1Y5djF2MmRhU1lt?=
 =?utf-8?B?K0FBd0tTUzVPSURyUUN0SUlhRTZBZ0w1V1ZoMlB6bXc3UVRyZ0V4U0V6WFVo?=
 =?utf-8?B?b3hYdzN6dXNqREU3M0FXYlJPQU9meDNrbWxCWEIxYlljT3NVRzZRMEpTSnVT?=
 =?utf-8?B?VVBPeUhDVHh5aXlrK3l4RDl2MkZCRXZ3dDFtK09lcXIvZVp2eFZkU0Q1OW00?=
 =?utf-8?B?MUU2UkRSM1hYMzVEZVJ0cFJuVUZiOVZuZVpoQThrMzQrM2xjby9wK3JaTzhJ?=
 =?utf-8?B?dzMyaUhkNTFDaE1XcGhQeEM3NUxiWFA2SGJ2cURZMlc5bjVtNmsycE1YRmVa?=
 =?utf-8?B?REFlRE5aMXcvWmxwd0JrSzk3bU4yTVFUUTVUb3ZkeVBpcTNxM3F4UHFpcWx6?=
 =?utf-8?B?cmQvT3QvcnJ5L0VibkVEVzNQSk5vOUdNVVJiMU9DaEIzL1FpUVlkWk1TZXhm?=
 =?utf-8?B?ZzZ5ZWs3ZjUvNStkRTFYS3Q1OS9YdEZjUFNrT3NtRTlNUjZNd1h5NlZPb0Nv?=
 =?utf-8?B?MkQ5UFd5N3I1c3JIWlZIRytycDJmMDk1Wnl1UVBSR3VjdXFBaHBhTWRvcm4z?=
 =?utf-8?B?bk10MkI1VE83TWM0c0NIYzZOb1RrbTNCVWRrTXhIWkhMNEJPSENFVDN4MmQ3?=
 =?utf-8?B?dXZFZmF2cTFKdDJObnVOeiswU1RxeHRZTkM1bHdGK0dQQTlISGwxT0YwaFpJ?=
 =?utf-8?B?MjV0bDc2OHJvcFRwS3ZMVTZkaVd0eWJmTzIxWklFVXFad2x6NWJoTVJ6cmpS?=
 =?utf-8?B?K25QNExCQy9wYVhkVUZkVVJucTlLeWxVcTJxVldYQytxMlo1ajZBWHE2eDFx?=
 =?utf-8?B?eVloVTM5YmFST01YNGdTekp6V0VXUnl2Y3VEM3RORG1Od3lwU1dZY1NLRGw0?=
 =?utf-8?B?RWpTQnFGdlBhWkxaRW5YSXFLbkF3U1pEbmtKTEd5c05NSm5TR2JraVRzMEZp?=
 =?utf-8?B?SkZWd3ZuZS94UlI3UWlzZm9wRExZNWp6K1F5b3d1Z1RzRWR1RnBmRE9PL1NM?=
 =?utf-8?B?aEFEZkw1cVRlckNIYzF1c3kwekxhVzcvNi8vdUpvYjFMZzNEeXV2U0QxUFM5?=
 =?utf-8?B?YXNUUDd2RzFGZmhzb1hqM0R0THdKVmFObVZwQzA0U1JxYWdDTmttaFFSYlUr?=
 =?utf-8?B?MXUrbXFXWlF4VmV4OS9QTytxRUpCUUk5ajBhejFjZm9rMm0rTzAyYVVnczF5?=
 =?utf-8?B?WXdoM2ZLdkthRUFodXljYXhkbnhTQ2trZWxrTlpaYnJudzFrVCtZTVY2OFRl?=
 =?utf-8?B?UU9QMThCMjNmdU9mcFoxS0pFdUFGcUxBOFFDR0FjbGgzaG9yeEtjN1FKYlcx?=
 =?utf-8?B?OVhWNVFBOTQ1aUNzenVNbDFDbFkxNk8vdVhLak10NVBMM1AzY24zYi82T3hj?=
 =?utf-8?B?em43aG5IK3lYMVJOcXlDSkNXUTIzbVFERnVDWXZjYkFMLzFVMnRobXRSRmpF?=
 =?utf-8?Q?keNk5JahY3gS9xXpvVlbucT6/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b76c47b-015c-4607-d516-08dcd09ada74
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 06:44:29.2258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2aiG/1/ELb4vxEVi8XgfZTGBqWTYzp4aS96TZmpbecP9sR8tN/xkYFU7Wo8rAztVVyhbdqurOjmXaQHwqePCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342

Hello Ingo,

On 9/5/2024 3:37 PM, Ingo Molnar wrote:
> 
> * Liang, Kan <kan.liang@linux.intel.com> wrote:
> 
>>
>>
>> On 2024-09-04 6:09 a.m., Dhananjay Ugwekar wrote:
>>> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
>>> on AMD processors that support extended CPUID leaf 0x80000026, the
>>> topology_die_cpumask() and topology_logical_die_id() macros, no longer
>>> return the package cpumask and package id, instead they return the CCD
>>> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
>>> event scope to be modified to CCD instead of package.
>>>
>>> So, change the PMU scope for AMD and Hygon back to package.
>>>
>>> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
>>>
>>> Before:
>>> $ cat /sys/devices/power/cpumask
>>> 0,8,16,24,32,40,48,56,64,72,80,88.
>>>
>>> The expected cpumask here is supposed to be just "0", as it is a package
>>> scope event, only one CPU will be collecting the event for all the CPUs in
>>> the package.
>>>
>>> After:
>>> $ cat /sys/devices/power/cpumask
>>> 0
>>>
>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Note that I just merged the older v2 version into perf/urgent

I'm not able to find the v2 version in perf/urgent right now, tip-bot had given the below link before
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514.
Have we changed our decision about keeping the v2 for backporting and "revert v2 + apply v4" post the PMU scope patchset?

Thanks,
Dhananjay

, because it's 
> a regression fix, and to not create a backporting complication. I added 
> your Reviewed-by to it if that's fine with you.
> 
> Your hotplug series can essentially revert this:
> 
>   8d72eba1cf8c ("perf/x86/rapl: Fix the energy-pkg event for AMD CPUs")
> 
> and apply the v3 patch to gain the simpler version.
> 
> Thanks,
> 
> 	Ingo

