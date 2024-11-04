Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28A20ED;
	Mon,  4 Nov 2024 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690117; cv=fail; b=RHRxwofErjPHSoRUeCVGnt4V2bs+JOJ7cwmdEVHvh2FH6VZE9k+yqmMvdyqlaucQy3QvAg2MtvQTXUElC/599z77j49Pb8MNT0enslXUZovAi9QBcg6HMFNUJQVpPb5YPXQPkw7C+YRnjnLgy8AR/ST0x03RwIf/ZTsTDsJtCyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690117; c=relaxed/simple;
	bh=dLZgH9JLmNM2y7TQkfhZNkir60FQAozmJeANyczLnRs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aYeZwVWVn1UdDN9guzbQ2X6nlwZ50EXt0CIrl2U3f3H3huZ5AH6oMDPQW0pvdh4hsm7UjRqcZ52/j9SC5OrK+QsRgoFraC1ZmvPlgLtbsQTELsWJzOHuPSnyBw2QFOq6G/4qvIjwxkaqyzFLfcURYtV//c5g/IHqf6gk8ODR2NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B+vMrH43; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B+vMrH43"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceHmOtUq7KO8hPycwM2AzZGPEEwpl2FP0gSZJ3W9fvTaQvlhU+XowlCnrIelkxi0xFKhH6AL6ZXUmw0zwp74FR57TTAF6UBCWnmdNnWWSmYxSjKQXfQRaCKLi75IrIowulV9IJ6q8VELAgJGKdXdPmgBGP6X1SNBf3zn0c8dva2m83yK+IYnPp4ugLRG3QuvoDABWnkRhbe0zUffYsaQRGISQZnA+Dd8oooZrC8MecmFJBMhbl1egxp046DnDw3ztw4ivUOHNuZW/PAFr7ymjvFA1lNztIyoL2oB1Uapy6+BLXDDEYFThVfN/NxS8wZmj/U5qpGEl3yt3gI91mF+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD7mi+/VXsDEjr1jBga0AWDMOfBggnozNw67YNbWgXI=;
 b=sfsns6GIibNqTw7bMSpdB2jEX63ecN07rAixwkPhLbGUmDiAqE3y+qIOk2qicL13mA2OwUWRoB3pSS+4klYSNssH4YJzBSzKxfP7vU9sLa+r5jMYZScbhDEOqY31qeLUjIyi+/bs3fWwMaRHyaaUFtT3nFnWd9bZQTakoprOrzaX/woQ9po2NfD1JL87K4CjOL4KIYVhJmOfShxrGb96SedmXeQHEqAalQsqdnjCmOgaHq4CIleLJXA5LEIxl72k032jMbJVovPWC9ZTML0/DXaKTe1IHrr5OYdDcgv/KILyQ5hKSZrPSq21xDLScEo4fM07R2AMVLt4eg0+kRY1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD7mi+/VXsDEjr1jBga0AWDMOfBggnozNw67YNbWgXI=;
 b=B+vMrH43E3J2mnHQqVMFGZUzacovoqyyVrZgo0Yu0HOXWBeYYKjeMmm+xLB3O9O29l/B0TgjqWtTryTyLQqPEjxKTJm5+uBlvaJH7tQLBat9HJC+3o1yUmH+3ywbq457GTQuVwwWrpfhO2PNgQ+/qbIOu5CBFDOt790OgLXugXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 03:15:11 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:15:11 +0000
Message-ID: <2fd6bad3-cb37-4a4a-8b47-d7c2ffc96346@amd.com>
Date: Mon, 4 Nov 2024 08:45:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "ananth.narayan@amd.com" <ananth.narayan@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
 <Zx9RHtFAURrORTrd@BLRRASHENOY1.amd.com>
 <52e578d0-a885-4d6c-836d-fc3ec0f491b2@amd.com>
 <2884838e95def2a0ca3d2c263de10d9aab991501.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <2884838e95def2a0ca3d2c263de10d9aab991501.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: a71b2dfc-46d8-4294-091d-08dcfc7ee44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGFpTHVUem1iNGlpT1VZRDlqWlJWSE80RHMyL045MDZFYk9BY3RaZmpUMzlD?=
 =?utf-8?B?aTlmWWk1V1duTFhzdnllV25GaXdCejJka01sRzR6TW5USzE5RTZlMlJOQS9N?=
 =?utf-8?B?amVQbXR1OXJDWVJHL1RMUDB6ZU9LcllzK2REelB5ZjZEdS8zempZVGlIbkhN?=
 =?utf-8?B?UjFSUmZySEY5K21JM25SRjhjeGkzdVZVKzBQVGlOVVhTS2R3NXBHNW1wRWpM?=
 =?utf-8?B?Vm50UDl2K0I5QzBJQnprWUNwTTE4OFZpc3NnODB5bDNaWmdvMWRIZ0ZNN3dT?=
 =?utf-8?B?dkhiRXVDWkxvS0dvNndCMUYvaDEwQ1dSYTE2aENkQ2RQcTg5dVExM1crV3RB?=
 =?utf-8?B?YTM5YmdHQXhmVUgweXlpV1NmNTFUWThNM3E1d1E1Z1RyWkQ4UlkxRjVRYlhx?=
 =?utf-8?B?VW5TU3psd09jSXVscU9xQ1BZTkxmS1JySExtSUhqWW9ZUno2NmYwRSs1M0lq?=
 =?utf-8?B?T0lId2xUVXNaUVEyYjJHRkNPVXhaNEYvUWMzRjFBd0FUUkQ2T0FTUFpEbUxv?=
 =?utf-8?B?SEphOEpIK2h4anZUZTBya3BwM2dHWkFLVXMyNHMwNkJFSGh0SVdWZGRScnAv?=
 =?utf-8?B?SGNZb3FZKzl4SmdhYXBKVnBCWlk0MVQ4SW9XOUJBZ0NwTEdiTUhZN1ExTWti?=
 =?utf-8?B?NVpNSVFYQkdjMmcwSWV5K0RNME8vc0tzVDBHbUlMSGg5ZTdCQjR3L3JtSUVU?=
 =?utf-8?B?NE5Nc2xiV0NVczArOFVBSDBhQ2tNQStwanpqbGZteHluL1pYWmJ6Rk43djhR?=
 =?utf-8?B?UUx3R1d6OHJRMVp6MFpjekxmdkFDVUdVd1FEZ3Z6djhRbThJNVFXVjJUWUhi?=
 =?utf-8?B?WDNvVGNpMkI3YjkzTy9hTmkxQkEvUjNEenp3Smo3dWtGOW5CaVFqWFd6ODFK?=
 =?utf-8?B?SmFMRUVFVnRhS091eHBYK2lucElkU1Urenp6NWMyMm0zaDJzbGRFaGlVU1pQ?=
 =?utf-8?B?TFcwVHJ0QmRlbi9zdTMxTkNkUHFGQkQzM0MrY2haRHlMNTY0LzRLaGRpTEx4?=
 =?utf-8?B?aUFiM3Q0VVJ1V3lnTVhPbzVMNEkycDUxNVBXaCtXSllwbWt4cFduQ0NVMEJ2?=
 =?utf-8?B?ejliSlpoMDVBK1p6VW5pNGR2WHprNjlEZUpNRUpoMVlzS1RTaVlkd0crUFhs?=
 =?utf-8?B?M01rUWNTdlRwYWtPUXgxVkRITHdnOWtTbVFNNmZQNWpKSFFId3RrR0JnWXp2?=
 =?utf-8?B?YzNHdlRZMGdXNHpDQ2NPZnU5ZjNWNjNpZ3JsQUxvSE5xUTNOTExQRkVOL0sz?=
 =?utf-8?B?dmpIVmpTK1ZvQ2tMTFA2ai9kaGwwTGlZWWdyTHo5aWhpNWgxOVpTaUlBTm1O?=
 =?utf-8?B?T0VEZTdYd2M4SldOVExVblYyRHR1dzZTZFd2MEFWYXhqcmdOQ1UvVW5LUDJZ?=
 =?utf-8?B?cjhLQm8rc25jemZ2RWEvSWoxNXhKSHlBcE5uNkxvQ25NaU9ZUlF3WEJ3TnhY?=
 =?utf-8?B?ejR1K2FOY2EvTmRlOGV6VGErb3FDSVBhUStRSlA0a2tDc2ppbzllSDZQS3VI?=
 =?utf-8?B?QXdmS1VHdFhXdnQ3WFQ5VGF5WVlublEyeUdLeTJNdkxZZFBlalZPTERRb0Qw?=
 =?utf-8?B?bWRKZXkza3h0Y2VJdDNDMW1rQVNTMkpsL29BVUtmUFVSUHNrcE5ZdHIrZlQ1?=
 =?utf-8?B?SlBwL1l3Tk5ZM1RHTXMvNENtRXJhVE5Ya2poazFSSFFab2R4Yk8zaGVoMmhO?=
 =?utf-8?B?OHQ0Q3dYcDhQcDBEaDVpOHpOUEhmVnlqai9QQkVSUFpydDk3L0J4SnR3T3h3?=
 =?utf-8?Q?FZ0LP714pVFWJPSEW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlhBaEFkK3VneVpwcVBOZXEwZmlWYkJNN3RjMkYzZFVmM2JkNzBxKzlIbzd3?=
 =?utf-8?B?SW45aEM4OS9qd05GNSthNmZ6QzRIWm04MTliOWV5c2lwbmt6ZHBKS1hNeWNy?=
 =?utf-8?B?NTZpTTR1dUpyR2NRblRKd0ZqcVFLbDcvaDNvTHNNQUVqV2JLaTY2ZkU4TGpp?=
 =?utf-8?B?cG9NM09EakhONjJUTmhYdXk4L2FDRWY1Q0YxTzJjd3orUmtUYVUvUW1Na2l0?=
 =?utf-8?B?aG1FRmkzekFnb09pM2Q2dG9peXZhWkU5NWNxNUlXVXBDYy9lRGtUWUh1b2pG?=
 =?utf-8?B?N29EOXhEdVR6dy9hb2JLMDh5dUhldXNiTkozWFJ1TTh2YkQ2U1RWMm90aGU4?=
 =?utf-8?B?eEpULzdTWTAvYkRwQXBCZ2w2c0VDYm9yeUtEeTlhaWRwcE5XbkxHeUdBZjJQ?=
 =?utf-8?B?bkNpU1J5T000cHV1bUxoU0VQV01vR0NFZkVDcVIzTlo4RTVVZjNPWXRZQ3p0?=
 =?utf-8?B?RTZHQU5JRndxNlA3VzFZL2FONnRaZHE4WUt5cnEzTlVPbjJTMjQ4NWt1V1pU?=
 =?utf-8?B?VWpjcDdyZnVpSk8wSmNMdXlSQTdUN3F3aC9ja0pDSWxZZ0N6SzNxWllmRXg1?=
 =?utf-8?B?d3lJZU5WYWlCSDIrK0xGMEs0bDJDMzB6TEptYllvaTdaQjQxNkRtcFkrQ0F6?=
 =?utf-8?B?clBRNUZQUW5BQXFIbS9iMitRSmZQeWwvRVM3OG5mVkp2blE2b0ZmTEg1V2tL?=
 =?utf-8?B?VUtjazY4RDd6SkxLK045elpJTEVXOFBMR0tmT1NJNUJnd0VVY2Z5OWZMUnND?=
 =?utf-8?B?MHgyRHE3Z0xBVDNaeldKYnMzd0YzUDBnY0hHOWdKZXVVSXZNNmxvM0pMRllR?=
 =?utf-8?B?aEV4MnlWZzd2UU1ubXhwMXJzN1ZYYzlvRjE0VDVDMG9zajE1N2hYUVloWVBY?=
 =?utf-8?B?R241b3ovb3ZTQVF1WGhHZHBZOWo5LzVtcmdia3hDcUczamdiZ0hBd3hqdWxD?=
 =?utf-8?B?K2RHYlJLOXV1aXVBNkxFa1NRMmU5eThsWE5RVExzcWtTMDd6bm1SanFwSWx1?=
 =?utf-8?B?aWVrbWg5aEtJQmpqVzZhYVhhRGF0RjdiSkI2NENIOGxocmJqRTNHdndFeEpV?=
 =?utf-8?B?ZWx1T1Z6ekZjWWU5UmRnd1pGVlRITWh0ZWNvWXRUQXppSGY5ZlA1eE1ORS82?=
 =?utf-8?B?YXlUaWZSTG9ZUVU3bXh1U0hlS05NWlRKblBibnpkeG5raWhyRy93SHFLWlRv?=
 =?utf-8?B?dUZ2WWliczZ3S1cyYlE3Q3JHWXlJYWFINy94UlU4S0FWS1BwNC9BV1lNM0tM?=
 =?utf-8?B?K2p4VFZ2WGRsSHhnbkhDWXFKS1hHd0ZzSkpDZ1JBTXltUEZrTnUzN2Q0bHp3?=
 =?utf-8?B?N040N1lYVVJuRG9la0t1c3pTUUw0YnlQeElYQ2RxRlBjQksxaStnSGZoOUJ2?=
 =?utf-8?B?RHVEYVlrUzU1dFMvT2x3YThtNEFFNFBkUGo5VENZMkYwNzFHQUFncHpvV0d4?=
 =?utf-8?B?aVRJQTFraDN2TzlVR3IyKzVndEowZ3kzS09YUjJQekwyTXNNVG9Eek0wUElF?=
 =?utf-8?B?Q2xyTXNoZ2ZJTGFLTUhZRjNTWEZWVHZRSEl6VTZ5Uk51WVo0ZGV3MitTcFkw?=
 =?utf-8?B?UFR5aCtLYnhFQzQ0RXJjM05sWlVUcU5VSXM2TzIxeEg4dmdGRGFxUElJRW9t?=
 =?utf-8?B?Z25CcFNwdGZmcjRKa0hBWkdJRzQxQjc0eUJlN1lkU1hHbVFXa01qRFM5Ykhh?=
 =?utf-8?B?RFdaZ2lpZ09CTWlUWTNtUllrYUNQOE9IRjJVeHowSHVTMWhWOUwyWnlwTWZy?=
 =?utf-8?B?ZmxjdytRWlYwMkphZnpmUWp2UnJJUURleHRwUGNTdVNkcGdBcUQ5T0ZxT0t1?=
 =?utf-8?B?MFloaVorcXdodm1aMjJrVUJFYjVzTUJHYXE1dXQxUVRTcy9oZzcreTZiYU9O?=
 =?utf-8?B?OWhzVzVFbXZWL3kybmZHdFJneTNwR0xxeVc1clZCTFhJMjg0RGVQTFdHZ2NV?=
 =?utf-8?B?UE13Q2lSUnBPekZ1ejltNmswMURRMVpmRzRuK1VQaXlIUEw3WkV6UWpEc0kz?=
 =?utf-8?B?cWdKWlNvMG4wOEVkckJwWHpVTGNQU2pqazR3RVlrMFMrRHUxU1k0VFZ3QjU4?=
 =?utf-8?B?ZTJTMU9lWVNPWm9qa2VSN2tNN2NIK2JRdU1ZbUhoUXQ1V1M3c0JMQUVXWm80?=
 =?utf-8?Q?MmCpbltYFoorok2oAzZLmY9uT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71b2dfc-46d8-4294-091d-08dcfc7ee44c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 03:15:10.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlfUQk6loU9fQwzvIsE7g23UWtBq8C+/5Oua6oJ946aBnf1hMSIbnXBR6ouieQQ9nuuAkdX0fq+wkrqIulxG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

Hello Rui,

Thanks for reviewing and testing the series!,

On 11/1/2024 1:36 PM, Zhang, Rui wrote:
> On Mon, 2024-10-28 at 14:49 +0530, Dhananjay Ugwekar wrote:
>> Hello Gautham,
>>
>> On 10/28/2024 2:23 PM, Gautham R. Shenoy wrote:
>>> Hello Dhananjay,
>>>
>>> On Fri, Oct 25, 2024 at 11:13:41AM +0000, Dhananjay Ugwekar wrote:
>>>> Prepare for the addition of RAPL core energy counter support.
>>>> Post which, one CPU might be mapped to more than one rapl_pmu
>>>> (package/die one and a core one). So, remove the
>>>> cpu_to_rapl_pmu()
>>>> function.
>>>>
>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>> ---
>>>>  arch/x86/events/rapl.c | 19 ++++++-------------
>>>>  1 file changed, 6 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>>>> index f70c49ca0ef3..d20c5b1dd0ad 100644
>>>> --- a/arch/x86/events/rapl.c
>>>> +++ b/arch/x86/events/rapl.c
>>>> @@ -162,17 +162,6 @@ static inline unsigned int
>>>> get_rapl_pmu_idx(int cpu)
>>>>                                         
>>>> topology_logical_die_id(cpu);
>>>>  }
>>>>  
>>>> -static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>>>> -{
>>>> -       unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>>>> -
>>>> -       /*
>>>> -        * The unsigned check also catches the '-1' return value
>>>> for non
>>>> -        * existent mappings in the topology map.
>>>> -        */
>>>
>>>
>>> See the comment here why rapl_pmu_idx should be an "unsigned int".
>>>
>>>
>>>> -       return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus-
>>>>> pmus[rapl_pmu_idx] : NULL;
>>>> -}
>>>> -
>>>>  static inline u64 rapl_read_counter(struct perf_event *event)
>>>>  {
>>>>         u64 raw;
>>>> @@ -348,7 +337,7 @@ static void rapl_pmu_event_del(struct
>>>> perf_event *event, int flags)
>>>>  static int rapl_pmu_event_init(struct perf_event *event)
>>>>  {
>>>>         u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>>>> -       int bit, ret = 0;
>>>> +       int bit, rapl_pmu_idx, ret = 0;
>>>
>>> Considering that, shouldn't rapl_pmu_idx be an "unsigned int" no?
>>
>> Correct, with unsigned int we will be able to check for negative
>> values as well with the 
>> "if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)" check. Will fix this in
>> next version.
>>
> you can stick with unsigned int here, but in patch 10/10, IMO, making
> get_rapl_pmu_idx() return int instead of unsigned int is more
> straightforward.

But I have one doubt, there wont be any functional difference in returning 
"unsigned int" vs "int" right?, we will still need to check the same condition 
for the return value i.e. "if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)" 
(assuming we are still storing the return value in "unsigned int rapl_pmu_idx"), 
I think I didnt get your point.

Thanks,
Dhananjay

> 
> thanks,
> rui
> 
>> Thanks,
>> Dhananjay
>>
>>>
>>> --
>>> Thanks and Regards
>>> gautham.
>>>
>>>
>>>>         struct rapl_pmu *pmu;
>>>>  
>>>>         /* only look at RAPL events */
>>>> @@ -376,8 +365,12 @@ static int rapl_pmu_event_init(struct
>>>> perf_event *event)
>>>>         if (event->attr.sample_period) /* no sampling */
>>>>                 return -EINVAL;
>>>>  
>>>> +       rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
>>>> +       if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>>>> +               return -EINVAL;
>>>> +
>>>>         /* must be done before validate_group */
>>>> -       pmu = cpu_to_rapl_pmu(event->cpu);
>>>> +       pmu = rapl_pmus->pmus[rapl_pmu_idx];
>>>>         if (!pmu)
>>>>                 return -EINVAL;
>>>>         event->pmu_private = pmu;
>>>> -- 
>>>> 2.34.1
>>>>
> 
