Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B472925A63D;
	Fri, 17 Jan 2025 04:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737089502; cv=fail; b=eUGfZrjrkfvOsjsY4knfaJ7h/NxZBDA8G8H92rB+H5KH7RxkxFEh3sA+gpYvNoqnIh712VVhFdHwb3IO1dYH4yHya79YRKtTg83/glbv9VM7RaUB3/9fx8VDtQuHcHZxXptotWTVVBSdNqf/SUzWqRhtOTpvSsZfC0/jRW9VA4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737089502; c=relaxed/simple;
	bh=CUWcTbyhcFMmeKaaZRkJKEwWl5B9m05tLMnrCCWMzj4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eeiEudy8igGfjZDxlVQdj2JyJkTFAbhTKPZ9D5dk2y3Z7I6m4yssgzhzRFNjQVResg+zs0AqWwmgvTfY1P2jFaio3M6uWcmMxa1ZOhI0TOn2gSca45p4qfphSlZXJkT5TqN5ogV3qftZiKTzKJ7wSJ6cQHp97TcHOSOqN+XcHVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=td8U3cDG; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="td8U3cDG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiuHtt4InXlcFQ4RyUj1MPZqZjBNeETHu2QNiwN3yPfbWWw/R/IQja6aUYdmIKSU66mJJB/qQx629tiYF3GMYcHSQbYE/Esr0oUWSYGtxsQr3BBb6VWV5WAKwT7fsYZb/MKgSPREBbCJOu9JMf6TnTaWl6mRIT5OnmUGH8e2wazqYDmUOyJlVdxCUK0qSIzlPjgY1lWgx5mcbOuHM0P5kQx9GQ6MNn/S0S0V9gUGY2SuwL937NY7S9Om9+7n1cqOQBpB1CpsBvccX4uBSeJflLX/3vWj1xD3wluAsBXJqvX5iFwpc5J7VyIVOU4SoLJlMrbtI6MiyE97tQQbeFTdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRTxd21WV5HMN1P5ruPj8kSIz/PtdaqMtc9Wsy7Hh1A=;
 b=CAf31Z0ThIZ7WRA4yJMwDfuJg3q7LFpURQZgR8Ced8inQlmJVclrUoVL42DqJ+6Hp3HTQ+Io5iDzypMYdAZOdozOccg+H5r5dKnmFeVzsnaPngg07zt6taGjyywGAULJ/yyPzwXq1gWdhyTSoI6/NK3ebLWBTWGu4jEIG34eAEvkYb/yGD4lNG5jC7W1o9+gjiAtm9iIOHV226uAv+ChGfCxJQi0ewC6ukNbT/WfmLnS2KuA1l17PmUO7jGbOeSywXJ8va9yUSY6U+MqliRM4VbivYOcqRkYI/O02a21NHR3XsE1/iuWTF2zk50xdsXtHbku7ikaZK8bPmiAc8MD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRTxd21WV5HMN1P5ruPj8kSIz/PtdaqMtc9Wsy7Hh1A=;
 b=td8U3cDGsWXiaP6mUav5iWtqZZvGeaUY5BBKypdGUqT6EFpjCldxfDr77Q0TXkBGkSElRwJT4qiyTxVwx9eJDIeR4oHUHQ9Xokqr5K2U9vJ0XjkHTv9N/OSUR5CyVlAL2UCF3GBuoX612WhXvoPFOj1rN7wZr3gOgeJ7MtGryd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) by
 DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.14; Fri, 17 Jan 2025 04:51:37 +0000
Received: from DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::45e0:b675:7986:3305]) by DS0PR12MB6584.namprd12.prod.outlook.com
 ([fe80::45e0:b675:7986:3305%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 04:51:37 +0000
Message-ID: <337e17e7-b3db-44a1-9493-495b4c7313eb@amd.com>
Date: Fri, 17 Jan 2025 10:21:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] perf/amd/ibs: Don't allow freq mode event creation
 through ->config interface
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, namhyung@kernel.org, acme@kernel.org,
 eranian@google.com, irogers@google.com, kan.liang@linux.intel.com,
 bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250115054438.1021-1-ravi.bangoria@amd.com>
 <20250115054438.1021-6-ravi.bangoria@amd.com>
 <20250116210959.GB7232@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250116210959.GB7232@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::19) To DS0PR12MB6584.namprd12.prod.outlook.com
 (2603:10b6:8:d0::6)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6584:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd7e2fc-2f4a-4d00-bf29-08dd36b2a007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ems0bmJUZ3hjakxGTGxTcUpVcEJoaDNFTHBNQmR2TlphdWF2OHRUeHlEQU0z?=
 =?utf-8?B?dWQrWVdVbTFwQjZNTGozSDdRdEowMFBhRXBvakRORk9rU3FsdytYU1dBWnJ5?=
 =?utf-8?B?QUlvZGlNSTVRSWhIcHludDJnbDhMWitoNkRITnJxS1p0WDhuTUJ0RnRBRVBW?=
 =?utf-8?B?bHlSd3VXWTVndHVYaXdFSCt0OTYyMEovaS90RFJHNTZqT1RYWGJGdEsxVDZQ?=
 =?utf-8?B?YXNKY3NCc1BZRlRBenMvYXZOQ3hmcnpXdlJ3aDgrRUh5ZHkzZjIxL0l1c3BK?=
 =?utf-8?B?eHpOS3hiN1VnSFZFemg1NDU2ZCtKVzZDbUtMUkZXYmpVTkRQcjBwRDJoVE1X?=
 =?utf-8?B?d2pFTDFjTEZTRGZmZ2UySFk5WldSVitHRjF5dVhvYXhFMDRtbldYM0J4Wmhu?=
 =?utf-8?B?U2gwTis2OXVYYkJvR0pjV3hDSHFGeW90ak1DdCt4cERmQWNKTlhTdmp4MUNw?=
 =?utf-8?B?c2VzSWlYK25tZE5NbEFiNzlnR0pNbmQxeEdiMlRmOXN3dWxFUzdMTGZ0d3JR?=
 =?utf-8?B?WUlVa2ZhYXVKamNhRlB5VUpEUGErRnlVYmowR0VhaVJUbDMzcHRVU0Y3YWZm?=
 =?utf-8?B?WFY5RTJJNW1RTWlBSUZsVzBUd3lLS0dFYmR0NXB6TEdoeGh0dlVkeE8yTUNp?=
 =?utf-8?B?bEpWeUpyS2h1UVdKRXpuZC90d1l1dFJTRlhFdmEray91bkFsYjg1TnlBZkVL?=
 =?utf-8?B?dnA1WE1CL0YrbDNtYVFLU3p1OUJsbmxZMUtkUkU3OHI1a0ZGejVzSFRlMlFq?=
 =?utf-8?B?Wk1RQ1FmSUJHNzlTeXRCWmQ3Y3k5cVpyTVlJbTdjM3ZUYWZqUUhKYXRPQXJh?=
 =?utf-8?B?UmNmN3AvYVRFYW9YZXdQM0J4QVhtNllQbGlCRjQ3U2FZd0ZEbU02ZGxzellG?=
 =?utf-8?B?eTlYM1FIOGZPVXF5Y2lnaXl2dFZ0YmVLWWZnSWJBYTg1cCtmeDQwMTdnZDVl?=
 =?utf-8?B?TVZtZHNJMHBKWXJRUi9LbzFNMEVWamRXczdoWlV6ZUpuUFZqN1lrVFl4QUFq?=
 =?utf-8?B?bUVTUGVmMkQ0eDhTc1BhN0hwdzl0RElHb2UvVEZPOU9qWTRpcHFnL3hCb1M3?=
 =?utf-8?B?aDNFRzBuZkZqOXY0K2xKamU4aTVFNmZoV1Rrc2NicGlUR3k2dnVXUDd2a0dI?=
 =?utf-8?B?bERXa0tpTzRMNGJYVDBBdm1vR1FFQi9TNnNJMzNPMSs1eDZPRzR2Slcza1hU?=
 =?utf-8?B?UURvSWYwUk5ic1NUYkJ0UHpFVzVFL09iWmNLVWhZRmhuNVkrSnJHeHVUbVNq?=
 =?utf-8?B?YUplMERlT2JEaE0xYWxtYWFrOWJFODU3UGZrUWkzMlhQZ1AydWM3VC8yR0Vl?=
 =?utf-8?B?aVY0KzdKS1IzRkRVTSs1VDR2SEV3WjhlMGg5c1htbDBTWlhBZW9Nc2ZDS0lp?=
 =?utf-8?B?S0xrOU5iZ0UxYTNjVjlKTkNEc0NjZFNpV0JScUtQMTlNU000NGJnSSt6NERk?=
 =?utf-8?B?MmZMTWlTczYrUzVYN0U3bGJvTDVqMGJBWFg5aUdvcXFIcDlhQU51OGpGZFpU?=
 =?utf-8?B?QWh1dSt5TmJ3cUJyTUFUY3NVSzNMaWNHT0ptNmkrbFU2Qy9wUDZyNjZ3QzhE?=
 =?utf-8?B?TS9jb29LTFlPcHE5TmZIZWl1K2hpelNKSGJyOEN3MVZMSXZYZzc2ZHplRjIr?=
 =?utf-8?B?QWxIeG5oVWdsZzlnVHZhNnBkTjFQVXVmd2tXOXMvQm1pNFpRcjBKbDFyTElt?=
 =?utf-8?B?RHRwMUxUSkUxcDQ3WkVLNFhSTzNwaW9sOHVaWjY0ZXRnbEdUUmUxMTZOVGRm?=
 =?utf-8?B?U2xydmhSYW9Sd1B6Y0Nvck9RL0FXbXlnWkhSME0xb2MvYTFVb203djJmczRV?=
 =?utf-8?B?dUtyMEN5SlNFQjE2WjM5NFhEVElxbUZWUjMzS09neTN1TmZNL3hSOTFQN1F2?=
 =?utf-8?Q?M9JcxQfZKe7Xn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6584.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDJOMEM3NTJxVG1PRjFVcUtUdk05SG5jL3BwSXFHcFpETTE1SlRuOE9vNEp1?=
 =?utf-8?B?eWV6ZkhUOEMyWHNiNG5yNm8yOXBMNnorOGNrcktuZ1E3aFh2Y0JzZEp5cG9q?=
 =?utf-8?B?MSs1TXdLZ3R0Zk1WZ0tPNnJ4akFlSFkvMXMzeVA3TjlHNlZDVHdXTWIvSjhw?=
 =?utf-8?B?dUUwcVdOL1NrMW1lTVBLb0UzQXpTK0Z3Rnd5SGNWaEptTlp2dDJKcEJNT3dO?=
 =?utf-8?B?MWlra21GM0Ewaldtd3U5K3V2bFVrdjlSOGdybDZSS0pvWks4dlNpeWI0eWNu?=
 =?utf-8?B?UitkQlhMd1oxTUwzZjc4U0Jod2JRVDcxcjI5amZIRDliMEpCQ0o5UEJFN2Fw?=
 =?utf-8?B?cTdwWkdpWW5DUFFkMnlSemlMM2ppT3FJbUtZSFZIMTVxcFRIZEpPcVNtR0JH?=
 =?utf-8?B?Y2hBR2RPZ1d4ZlJWL2w5bWU5WlpTcTRwb21pdjRKTUlsY1UrQkhmNFd5R3Fy?=
 =?utf-8?B?MlFrTi9DVTZrWmtadERJa3ZPM0VoejR1OEVncFhaU3VIQWlaclVRMERab0h4?=
 =?utf-8?B?cTc2OWdQOXFLZzZ0RWVoRnAyaU1QV3NqdEpVWjBoZE5LaVI0NkUyc0ZqMmRY?=
 =?utf-8?B?dXVTejJtNE1kWVdaRitYWDlZUjRUbUpRL1pBUmtiZXZESWY4N0tFcTlEcFlt?=
 =?utf-8?B?UzNaRU8wQmU5MUdqdk1qUnV2TFYwM2FNSkxwemJmbXBRMjZnQzJORUdCYng2?=
 =?utf-8?B?bHZlQlBMQlhYM0Rod1V2cUEzUjRyZkJBdFNMSlU5ZC9QWlZoazB0MVJFbzcw?=
 =?utf-8?B?UENTcDZoeDUydjlsYWhCdEJ6dFVPV1FabERtQkthZUVOTkExcGRxNzM2cEpZ?=
 =?utf-8?B?azNZVERUYlpGcm8veHNYVHNVMFdtMUd0T0hwTDZNRjVTWjZKY3U4OXh6QTda?=
 =?utf-8?B?UWt1Qk9BOU8rVVZ1NDFOa1V3SlQ5d1AvLzl3bDNla1hCN1RUSmNoZ2NTVGhU?=
 =?utf-8?B?R1d0QWlscjhSSzBqR1ZHb01DR0JjSnIvRE1Xd0g4RjNQMW1IT1k3TXQxMEhR?=
 =?utf-8?B?bFczWWVsbVRhZmpoUVZpYlVDRkwyQnpVMEVaVWpTSHdOT0VBR2Fra1cvcnFL?=
 =?utf-8?B?eDh3M0xVTHJKWTd2RlFUekVmNFdtb05ET2N0bFdQVEw2NElibk9IT0U1OXUv?=
 =?utf-8?B?MEFBR2lvTUV4OTh6N050VWhjQzBHZ0dnUTA1U1h1TlJOMUJRVHhDN1NUZnVE?=
 =?utf-8?B?ZWM0U0VaZ0p6OHljSFpaUFBFVkIxQ2szMGdoTVV2ZU5mdWt1YVIrRmNYSXIy?=
 =?utf-8?B?MFRmVkZKaUl2VDJnbVN1dmgwbDhmQlByTXEwM21qaXpaRkpWRzZ0U09rWms2?=
 =?utf-8?B?T21OZ3MxQzAybXRiSzFRZkIyazBXcTlpM1dsQzl3My8xQmRsNU9XeDBkVFhz?=
 =?utf-8?B?ZXdldHNxZDl1U0xyS2hFd3RES285b2gzaWFFaWZFSkJVZE9OUlh3WGdIOVFJ?=
 =?utf-8?B?N0l6TmVTYXFkNnRoQS9aeHlBMklWVWdmc3JBODhJalBDS25qczkrY0cwTTI1?=
 =?utf-8?B?bmFBb0ovWmdnRHpoOW9sYUlJcVpaeTN5ZUtVbFIwbkdZYVZxVzlnRE4xcFkz?=
 =?utf-8?B?S2tqUFpqNFJCdDNnVDREbWhKTGJGWW9ZOGIvRkZlWkxUM1RJbHZuQkZJbnFK?=
 =?utf-8?B?NHJXNC9tUEhqWFNiczhlNkI5eFpIVk1IQ1QrYlJYTnJrQnM2U3dyRlBoQ3NS?=
 =?utf-8?B?YU40VnhBeldkZkl3aG1MaUdzSnZnNzI4dkI0Z2NZMFFUR0swYTZjQTIyc3ND?=
 =?utf-8?B?YUM1MldORUdRdFpWeVowMkJINjkxVVR6TG8wczRjVmFURG52cmlmRE10TGNo?=
 =?utf-8?B?MTVYbUhwaVoxZ3Q2SjVXUFhzM2Z3RlNzalUvcG10MTlUc3J3a2VqZGNxRGEy?=
 =?utf-8?B?RHY0TlhOa212SUFicDF4aSttdWYrSVZ6VnVPbWNIYkxpZWEzOUdJRFk4dHNJ?=
 =?utf-8?B?eFVZTkl3cDZid0ttMklQWFQzTW1EYnJsZHRvUEdqWkk5L2VWK1dEeUZ3b0NU?=
 =?utf-8?B?WXlDa3dLbXhaVjFTM1J3N21iR2pqQzBsU0RKMG5FQzhXSVJZYmptN1RNL0l4?=
 =?utf-8?B?eHI5bldJd3FwdmdnV3lnQ200M3N0eDM3dVVWTW5vcjNsMHdBbkdVTjRxK1Vo?=
 =?utf-8?Q?za6SPMjtCgKCzGK/wwR94uOnn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd7e2fc-2f4a-4d00-bf29-08dd36b2a007
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6584.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 04:51:37.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eInuwuDqP6vtagwH9rRysjc/6dpNQf2Lo9d8D2awdwTBNbLoI2XNo9+Pz6nRuVoGyxb7RjErBfoiSf039LNBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672

On 17-Jan-25 2:39 AM, Peter Zijlstra wrote:
> On Wed, Jan 15, 2025 at 05:44:34AM +0000, Ravi Bangoria wrote:
>> Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
>> MSR. Since the sample period is programmed in these control registers,
>> IBS PMU driver allows opening an IBS event by setting sample period
>> value directly in perf_event_attr->config instead of using explicit
>> perf_event_attr->sample_period interface.
>>
>> However, this logic is not applicable for freq mode events since the
>> semantics of control register fields are applicable only to fixed
>> sample period whereas the freq mode event adjusts sample period after
>> each and every sample. Currently, IBS driver (unintentionally) allows
>> creating freq mode event via ->config interface, which is semantically
>> wrong as well as detrimental because it can be misused to bypass
>> perf_event_max_sample_rate checks.
>>
>> Don't allow freq mode event creation through perf_event_attr->config
>> interface.
> 
> So this is the case where:
> 
> perf_event_attr = {
> 	.freq = 1.
> 	.sample_freq = 0,
> }
> 
> Right, where we would then take the period from the .config fields?
> 
> So that seems sensible enough; but does this not break existing users?
> Or are we lucky enough to not have any users of this borken behaviour,
> unlike the earlier broken behaviour that we now have to live with?

I'm not aware of any existing tools using the ->config interface.

Also, I can't think of any advantage of the ->config interface over
stranded one. So, if anyone is using it and start seeing an error, they
can switch to { attr->freq=1, attr->sample_freq=xxx } and there is no
functional breakage.

Thanks for the review,
Ravi
