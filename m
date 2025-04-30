Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747211D7984;
	Wed, 30 Apr 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035170; cv=fail; b=KY0oqBTsgLHQUaWNqDWGe/vTJEdadeLQAGZPDfT/srQ10cNZdmDuTwWDXKwj80azmdzJDv9yXcJOUq2JgK/gdlayk97yg6+JGm25AJRWvApOhEK8jnLeBqZVxWtZgrG6LJyj7gFS7HkiVvZYqcZehunSgQrmyV8V6wLPdIOMXX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035170; c=relaxed/simple;
	bh=6ADJ6+esPjOf/jnjsbiWYiXwBUklXpAuRkrYzr+b6y8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dq2wo5A8ZhzMgmaJ92OyGpwYZizBfYkFQaGXm0GUHiEsbPDGDlYeJxwKso73k9lIJJjsIWrZCZduTT48GNtx+ML3VR6vfK8mTMQbRYf0qPpveWKKfFFvKLTPZn5jmFU+Y+TK/asGovs5nZUBdKNh408Xz31z+TRMSrgcQzZmTBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GyJTzzcL; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GyJTzzcL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ep0fvclhueSpoAHcGA9OKANSfnsu0F2RZdsEuWo0Px6bkxbuS/wym+/kZC9saVdQZulXqHSxA799sonBjCZq4pvjZHsTAVfcKZ3BcM3eiO3Qop2phB7gXwy9rAHWeJ0NjXpvQV9AKGb4ai9ENk9Y8wD4eLerdZTUprXTXcKqfK3C/2Utbzxp+dk3g8oyQNXnqzripdZyOiOu2bimD6/4E3WVtXxWagdwgi+SIpPERARNMyAzCGfdKSCtrgcFOZcdLWTlJvxeJCpUgu1bRez/c2ftRhjv3ciG2H8jZzEIj2jep7g6AB5lkGhuEYKvKv5NfXgTM7qEwEu9oQ3ZGj/hkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJPfymxZtqpsZj9s+LWheR3J8SBt2dIlOCxtwCa+rHs=;
 b=OGdu5cBiUAUE3Y47o3H/uxs6IT0pO3WIkBG4IuWwTj2ssKleX2vsIkKiTnf8jNiK1JESIScpfoEj5pnkzYnEfIi/Ys0bwRRONf22uHoen81ER7JuBvWbx4GKiqJspPM8Bv+CiFN1xpb+lLsWHJGnVMqpBlixMf/wUafoQSZZT6mCPg4W1u966oFjTJ1AZYiuD0UiQLPldDfsql6hBbH7X48RFybK8hcWNvpVT517UPGl+/cJeSUrdVLg99JjtJ7/n9JuV+ZT9gp7y6WnUvSqxhyIktcjbt3gXw86NvgKYabU+F7LsMuQy2q5YyvoZFrS8ScvK/hElZZ8tQG4YfGhBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJPfymxZtqpsZj9s+LWheR3J8SBt2dIlOCxtwCa+rHs=;
 b=GyJTzzcL8EHhebzz0TgQZP7JgdjmAYr7oe8+M8JdvDMeFI4XWgIy13OTCg9bfTDlXEtlwBsXaXwKfr7uYizkVRc/taFQ1rfV9Csa0AZsfAWUtPPrHB4oTgoMLpFv0Ul8JSWUaOWluaqx/lt68WJS/8GnouW8CKkzkAMK1G0Pa8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 17:46:02 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 17:46:02 +0000
Message-ID: <573aeaa2-f99b-47fb-b9ac-1439f601e7e7@amd.com>
Date: Wed, 30 Apr 2025 23:15:52 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v4 1/4] perf amd ibs: Add Load Latency bits in raw dump
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Joe Mario <jmario@redhat.com>, Stephane Eranian <eranian@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-2-ravi.bangoria@amd.com> <aBJWvAQc0wF6EV9g@google.com>
Content-Language: en-US
In-Reply-To: <aBJWvAQc0wF6EV9g@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be61e46-abb9-4961-66e2-08dd880edfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXk4cS9nTHNvYTVmVXVIcS9HekpDdzBHV0s0RFZMSEphQk82dEtXUmg2eWI0?=
 =?utf-8?B?dE05WDc1aWRTQkNteUVjN2Jud09Ld1JCMGllWWFoUytFOVJjYUtDbVBueWFy?=
 =?utf-8?B?NzhyL0cvRWRuOHlHYStYdE5PbEh1MlhoTFhocUdkclJTZUFVd0F2VlFWNzcy?=
 =?utf-8?B?N1VMZzJaZzRRY2lUc2wwQWNscm5USWVUOUNBUzJXcS91Qk1vNExseWJxN2Fn?=
 =?utf-8?B?andGNDRBdkdNNDBPUi8yZFlsVkh5eFJHTjMwNEpUSmE1U2QvdXNKRkNaRk95?=
 =?utf-8?B?aGFMRTBNVWEzWHdVbC81b0dwaTRqR1Q1VDZScHRuVS9mZnd0ckhhT0lpdlJr?=
 =?utf-8?B?djFDOW1md0VHR0RZcUU1NnduTG5XK3NzTjhhUUdTQnE3U3RoUmZtTEZ2Sk8z?=
 =?utf-8?B?TzZFOS8reU5ScTBZRUx3WXQveFI0aVByYUxwNzllL2FHSjJLMVhIcU5YamhY?=
 =?utf-8?B?SUpERXFrZktXNmJBc2IyTmFFYUVra3VqVzY1RWZKMEFhaXQ4a2k2M3RzYU5R?=
 =?utf-8?B?SUpWTk5Nbm5IV2tKWktjWjNhOG9XYnBxbzZnbUl1dm9GQlVaZTVjWVlPUnBJ?=
 =?utf-8?B?cWt6OUErakVBUHU4VnBic2FoNi8wdG5HcG5RMzU2YVdBNENxL0d1OTJhTW5s?=
 =?utf-8?B?anRDbTl1K1BJbVZuVURuWEhFSzdsakpSV3VxSU5Eb0VYRzlwRUttVnVybmlz?=
 =?utf-8?B?a214d3daczE3ZlNvT0JYVlVmTm5KUk8vWnlKR0JIc25lSW9nRE53bUtVZGg5?=
 =?utf-8?B?a1JoSWZvbHhEUmpPallqQ0k1QWlYbnJEWWZYeWRITFZVUk5pYnd3ek0vTVpt?=
 =?utf-8?B?ODZQZDUrbVR2S2hwc2pQbnFvYWQvalNqeXZUTWI0cy9HQWZNditKQ0RPVXdi?=
 =?utf-8?B?ZDFKTlE0ZVBmNkJaTFd2cWQ2ek9WTjFNSFRvRU1FWlk5d1NYSW9pZUNQMFdD?=
 =?utf-8?B?dzFIZW5jK0lUaUhsVythbWxPYkxJMkZDaGhFWFFEUVpGeWgvR0pUUEprc3lO?=
 =?utf-8?B?bEJxck11UklQVVBjV1IrT0h2QlR1bGY5elNFYTk5SWZucTRKQStrUDB2TVJ4?=
 =?utf-8?B?MEQwUHlWK0xQRlRwdFVkRGRVb1htTWtpZ3gySWRKd3VPbDJJS0lESEtRZG9H?=
 =?utf-8?B?SjhuVm1oRW5rTDVDSk02YzNPK095M3Q3Q2w0ZHVXb2dTTzlDVVlidWZtNVl5?=
 =?utf-8?B?aFF2ckZtN2JCQzRWbjJid25MeDBJYndyNXJod2RFckRiZ0k4NDhvdGd6cEJR?=
 =?utf-8?B?WjBoOXlRc2ozSk4xUjNwcmxEc0J5NkF0b3llMmt3RHBoREJVQjdGaFZpcHFh?=
 =?utf-8?B?TnFOUllZYllraW02N3F2Y0MyQVJrMnBKQ2NTYVAvZ3ZpbFV5c1NCYXU5TFp5?=
 =?utf-8?B?OVF0UnVySjl1Y3VxOWVuV3JReUZ2WkJXQXp5aHFFOG5mNmIvQUlGQTVTUkZl?=
 =?utf-8?B?dHphWTE5K0JmbXI3WlJmczFta1IzN0lUMC9vbHFyL3RNbUM1RnlYTlhwbzJa?=
 =?utf-8?B?K1FGV3NHek5tNy9DaWVQNEd0OVdYTjduL3MyMVdWWjJSN3h5VDNWeldGMUZZ?=
 =?utf-8?B?YXZwb1hzVUhsVWNybzRrdjF5S2pTcUhzWGlIeG1mUmZLRVlLdlhyYWtTRkdq?=
 =?utf-8?B?S3k0QWU0SE9zQ21xRnN1aTJiRDEvRjRaV3ErYjk5RVdqMENVcXJEMG81NXRk?=
 =?utf-8?B?eE9FQlN1bHVGTDM1LzhIMXJuWXl1dUZFNTVpWXV1Z1p5MndiVzU5ZENydGhv?=
 =?utf-8?B?OGVTSWhId2wwUUdRem1tK0RySERiTUw1V0dycllOaFllcWVDTXBCbWd4dkdB?=
 =?utf-8?B?cGtOZWFGcXJhU0pzUTJQcWV0MXF3bWY5VkpXZ0lUZnJLaTRvTC9TeXdFcEt1?=
 =?utf-8?B?eThScEhzc2JJenBwTFpaUWY0YjltNFpDTUovZSt6UUlyOUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTR5RjRZQ05wQVZ5MlJQa2RqcmdaQlRuSDFEbU5iVXNhV2dSTlRjeHFSZEZF?=
 =?utf-8?B?dHgwWFpqeUNwTWQwcTdtN242YjA4TnlDYnUxbVBFOFpMaWQrSExSM2VuUUlJ?=
 =?utf-8?B?ZzRYN0FXWlBBN3kyaGhnN0tzVmxhcW4yWDJwR3VONnVOQjhlNzZLQ2VOckpt?=
 =?utf-8?B?NGdYZGtZQlhxSEIxUUFod0txTWVybXBMeWZuV1lkSnFRK0M4TC9peW9HcEVK?=
 =?utf-8?B?QXRlTFRybWVrSFZEZ3lNd2loUmxranlKZGZkWDE3N0JkSjE2clFsZkFtR0R2?=
 =?utf-8?B?OXV3bHdTK0M2RUVWTVgwdFRFWHJrcFFpOHFlWXVhNmp5dFY5aUVsR0Rra3Va?=
 =?utf-8?B?Q2RlcGgvZWlLanlmVElSZlBBd28rWjNTMENWOVJ6MFlNSnNuWkQzQ0FaMG5r?=
 =?utf-8?B?REZoMlhocSs1ZUFRT2JzV3hua09yTDFOUXlHUXdOSlhGU3k2bW5UMW85YTVE?=
 =?utf-8?B?bTBWQi9BM2tFWkdCaVhMTk8zWS8rQUpva2hmL3BTY0cwaU40U3c0eEZOVUht?=
 =?utf-8?B?NmRHSnVFbFVNL1VHVUdteDF4dlc1YjN6VmhrdGVIQ2tXR2ExWnl2REtmT2xO?=
 =?utf-8?B?ZHpmbGVsaHZkVktRRVFTQWRDMjg3YmJvcHpEVm95dUJRRnUyWmo3Tk4yRlRl?=
 =?utf-8?B?WEd1NklQUDNFU1lncmUzRWVkSTBDaGRuSVBBbFNRKytuSk02ZlZxSmdjT0x5?=
 =?utf-8?B?MFVDTkFYN0N0TFozamZiMlBXRFBJRmhyQXIrT1pUS2FuWWxjTktCMGl2QnZ3?=
 =?utf-8?B?RXdXcXdHVUUvVnJkNkx4bnA1c1NiS2o5S1VId2lxb1lDMWRuRDFoNlhFL2pa?=
 =?utf-8?B?bmNySEd1S2FoTFdCekJWZUl2Wlp4UFJvbERQdmYzaHVqZXM4UktMaEZuWjRO?=
 =?utf-8?B?VnhkWjR4UkxJR1IxR0kyK1lhZ3JQbXAycVRRYUpFMmRBMVJidzB5dS94dmJK?=
 =?utf-8?B?dlRCUnJteWpBMHQwOWVNdGQ5V05kTFJMTVAyR0FFa2JMZEFsbkRqOEN1ckEv?=
 =?utf-8?B?WnZBdU1aZmZHa1lBYmlGWmVlcXZoam1ZbjhZVVR0OXBnSXJIM0YwZXo2QnJ3?=
 =?utf-8?B?eG81Vm1RMEdZcjFERU1mTGs0UkZPTERRTnBkWFA4cGlROC9iQ2ZTZGVER2Za?=
 =?utf-8?B?SG5iaHNnYXlyT09CS1dqQ29WM0xNTExUNnFZQWR4MDNWZXBSRjUwcC9FTUlL?=
 =?utf-8?B?UzBySDNudEE2SGFJS2VVNCtIL2lQVFprMjFKWnI5YWlaWkhpQjNNSGxRSTV3?=
 =?utf-8?B?eVhzV3p6WkY2ZzN2Yld1WTNVelR5RWY0N3lDZnVxMWVvSGF5RkFDMFhEVFY0?=
 =?utf-8?B?S0trUFBhNGtnL1grQ0lQanVNbWlWOVR4Q0hOMXdLaG1zNzU2Wkxxb2dVN1Fq?=
 =?utf-8?B?UzlDdHNiRXYxbW1vOVE1MTNFUzgwRkNyRTRNRmE0NUxsSXpwaUIvWVk0bC9X?=
 =?utf-8?B?ZVUxN2xsOE4yU3RMa2JVeVYrOVJnUnA3Q1QrVXVJclVXMEgxaU16OXhKRmM1?=
 =?utf-8?B?aFZEYnZ2YjVUcFNET09Vb1RzTjNleVVWTTdFV2Nqa2tnaGhJbWpGTEVSYkY0?=
 =?utf-8?B?akRwam5uZXJ3N1BLWWJGSytvTlNId0c0YkZ0c1pFQ0dmeExiY2xsQ1h1QlFU?=
 =?utf-8?B?RjBVbGVidW14MG83WG55Ykk3bGsvSmhOakZ2TWVrWmVBRVdXZ2wxK0I5MmhI?=
 =?utf-8?B?MzBNZ251L3NkSmgzOTVqRXNSVTBDenBhS3lGZXc5WHV4bUhSZ3ZSc0ptaVVH?=
 =?utf-8?B?b1hmeVlpaXFxOUdZTW1KNHpRTXhoNFNobjlWc1dpMW9rK1BjWXA1VXN6MUM4?=
 =?utf-8?B?WlY3S3FtVnNoa0JaOXVoUFFObWN5ajRURWVoOXgrOHE0MVZSSDFhRjc4MzBl?=
 =?utf-8?B?TjRpdnNMUy9ybHZEM1FqMXBtUzdsNEpLN2JDUVFXa1RoUkFwbUlyTzQ0VUh6?=
 =?utf-8?B?dlNaQU03VU9mS3ptQWlOdERmM1Riblk3RWN6UFJNMFA2RU15Rk5mVFl2UWg1?=
 =?utf-8?B?S2llb1VYV1A2T08rNnEwSWdPL0s5dVFxYUNGM01TM0RGakVMMjJXRDMyL0cy?=
 =?utf-8?B?RXFSczkzVFNDRy9kL3BVNndEcUw5SFRRd1dmMTVrcm9MT0R1dGVYR05TWm1C?=
 =?utf-8?Q?ozE4Z7RZxS9GQj6R4XvkpbdW/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be61e46-abb9-4961-66e2-08dd880edfa7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 17:46:02.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmUmHjb/q2YOIIn2dTTHiPOtXGpBzx5lKlVqstQc6FSLl9rXb4HnFly12F+5RxD1m/91GpH9UtA1Eta2kxEc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651

Hi Namhyung,

>> +	# perf record -e ibs_op/ldlat=128/ -c 100000 -a
>> +
>> +	Supported load latency threshold values are 128 to 2048 (both inclusive).
> 
> What happens if user gives an out of range value?

Kernel returns error.

>>  static void pr_ibs_op_ctl(union ibs_op_ctl reg)
>>  {
>>  	char l3_miss_only[sizeof(" L3MissOnly _")] = "";
>> +	char ldlat[sizeof(" LdLatThrsh __ LdLatEn _")] = "";
> 
> Shouldn't it reserve 4 characters for the threshold since it can be up
> to 2048?

This function dumps HW register content. IBS_OP_CTL[LdLatThrsh] is a
4 bit field which should be programmed as:

  (actual threshold / 128) - 1

Valid values for LdLatThrsh are 0 to 15.

>>  	if (zen4_ibs_extensions)
>>  		snprintf(l3_miss_only, sizeof(l3_miss_only), " L3MissOnly %d", reg.l3_miss_only);
>>  
>> -	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d\n",
>> +	if (ldlat_cap) {
>> +		snprintf(ldlat, sizeof(ldlat), " LdLatThrsh %2d LdLatEn %d",
> 
> Here, it would be %4d.

Since the valid values for LdLatThrsh are 0 to 15, two characters are
sufficient.

Thanks,
Ravi
