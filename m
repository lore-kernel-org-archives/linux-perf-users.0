Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE52230999;
	Fri, 22 Nov 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257280; cv=fail; b=nf0Zkg2MBqqw5juFVzs57US5LYwmQy36w8a0xyU58wv2unoKKtyUtdJRQ/E2eE6nveUA84A8DXsHo6VA8tlvsEENyH5W8urHuvVQvxClwuYotEdjUxQm0XI30BW/4a0sumHllQmajzdOvZm5qUUjiwiSu1sAQbzEOR3XHU2LSCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257280; c=relaxed/simple;
	bh=8r7D2zJTGUXrI+q9fI3k5pLm+Cw4xTgKLGTs0ERKgX0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TPJnLUNKEIdOUrURS8fzer2VxkJgTejYqB7xPcTfUhJofEx9TjHDWPgcpRW8YhDlkkGOFhEY4ObMas5n6Npn3FLh1rZ0ddGd5IMolDy0Eo/vPe/K5GTgKR7HHhlgFeub5WveHH2FIap9cKZ2gZ/dEAUUfzc5jnz4VIsFfV92Rvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nt6KiKZD; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nt6KiKZD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ep8aXgkLXmdcKKm5N/Pf+dC3VL0xI9nA9lUb9kcTI1PGnpIEwJr45FJDD0Ds7lrweCdxIv7So9RFbEmjjnM9in+NraAyL8VJWTFGy5I4YjQoTQN6nv0uoF2/yuHC95CeEHCnNzhQuB1QrI0FWPl25a88XTlYaeJo3SCMVFFJVYhlRPZ85mvqnB4aDPsiYhAu7aS9UMszhP/i+pw1u5plZp5hWSeJ3PY3K5CkMZPOcJiQDZFto8qUP43JBL40sDhyXSnGN2bKuX0HSBrePzH6YSt1t5kl21RDIz84tPZaFzamjL4WIUrrO+32A517zIK7nBkIWQsj10KHPgaqNJiPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/kUfXb+yd04MHWtqX+SGtfRkM/ZjIhVQDfYvUUiz3M=;
 b=QyQuFzAcXdNekJv6t9E773gBjtazfBksy4sDtb4/GMULhENBMQ/5hozcJskoCdFkhIdRicOgPoaYcQ+/BBVIx/L9Gf0Od/No5sjL1Te4YuvvRUDFp2YKz4EGA7w93LEPj7X+yOAcu5j/R97mSM/ZBWNugTKgekvZmIBncVdfEmjXz/BQey9j3ZyMXFz+qqFYXWiQWb1qkhEng5GleGYkI/elabgIq9hOgcnRa6GuDk76Ex/rlFYuR5is1qNRqr9E+5AMAP6a3iupcy5zA65jT4QrF0M/QBosK5/V0jWA8l6Ki4eLPiQR1UhyAfQGhUHmvVmBBBszu5hN7P6ITngXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/kUfXb+yd04MHWtqX+SGtfRkM/ZjIhVQDfYvUUiz3M=;
 b=Nt6KiKZDxT0zoPumwYJdgC4Cu7EcNmG0exrv/nlUrSIN2EHbOgjQ7MVOUABRNr+nm1lmEdxO8V80lRMBCs4ruRFTsr1CyBKh5IqQU4FTD0YbqKH5U2a/9TZ57nI0ryZNvAqmxQwZVsloldT0YzEBpsMVhOvr3a9idSuvSRQRmvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 06:34:35 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 06:34:35 +0000
Message-ID: <e4a2c5f3-4bd3-4ce9-a872-d9e3d7b58f54@amd.com>
Date: Fri, 22 Nov 2024 12:04:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] Add RAPL core energy counter support for AMD
 CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rui.zhang@intel.com, irogers@google.com,
 kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.dei,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241119122021.GE2328@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241119122021.GE2328@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3a167a-6d6d-4dfb-4dc8-08dd0abfbb2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ujc5N3d5SzBOUWluR1M0ZEZyNEl3UDVPS3J5Vkx0QnZROXNFRTR5RXFwWitR?=
 =?utf-8?B?WTNack03THNJdjlxUDlONEJiVUFOVDFWZmdNQnlEUUtPKytSUjFDbXNQTEpG?=
 =?utf-8?B?K3F2MWJIZGRUVTlEUTgrTTBpNGUvSHhDMjVEeGtyUktWcUFXVUI2aDQ5ZytQ?=
 =?utf-8?B?a3kyNmdwWGJyeTBvQUxENHZXUldJbVpmTGlUSThJWEpFaWpPdTZWUEFkZnpr?=
 =?utf-8?B?U1hycnFjQ092MURESjFXRFdiQXBXTE5TN0JGWThVNGhYSnFWSGhTRFkxYkFY?=
 =?utf-8?B?ZE5mc2dwc0xSYzR3VEJRY1QwQjIwbEkzSWwzRVNLQWVnbUQ5akhyYWh4ZUFN?=
 =?utf-8?B?UEl2bzdLN28rczl3MEN4UjBBUmV3cllQaGRMaUtzT0tKZDYrU2phelJEdVhF?=
 =?utf-8?B?MzYzVEhXQVUxNkFmeTZQNjlEYUdqOVUxalpmN21lZ0VqZGdpNTNVV2dBNnda?=
 =?utf-8?B?Mk9ZU1ppNEJSYnRRbzVIMXhoellkK3ZLQzNwc0ZnbGlmRFVBd2V2WFRJTHdm?=
 =?utf-8?B?dDQxazlyTzlhVXVjUXdla2wybW5uZHRGQ0t6WUVwWFRwNVZBNC9SeCs1UDlz?=
 =?utf-8?B?SndUWHlnMU5oRmR3WitTbk13ZnVoN0JSeE56dittSHU0RGwxU293YzQzUUNQ?=
 =?utf-8?B?Q2hIdlF4UFF6N0phVm5hTjB5ZHJ6cnFPNDBaTlN0Szl1VDBvS2E0bm43N3RG?=
 =?utf-8?B?c29jS1BUZG9uT3VFTkVwZ2xSZmhwM09LV1NsODZaSXp1djhISXlSYnlxd1Mr?=
 =?utf-8?B?WUJOSEVQZVBOY0o2cGVSb1pCdTgzUERyeHdZcVhHcHBlRlZKMlNSa3FWcENV?=
 =?utf-8?B?NW5UWW1hbG9iaWRlOXBOVm9DelozeGpaWFFMYkF4Z3B5d0Fwekp3R3JsQTU3?=
 =?utf-8?B?UHFmQlcwbyt4Ny8za0QvSHpDSVRMRy9mZDRJQmpxdC95NDlSSEpmUFc2S3g3?=
 =?utf-8?B?YWh5NWltWHM5WjNpbVBTYWs2S0k3dElGYjBuaHhKdXJOYk1aK1l5dkFsbVI5?=
 =?utf-8?B?T2RkUnptbmpQZlA0MEhDZUJvOCtVZXJGVHZOQlpmNHB0UCszVmpnUWF6UDlp?=
 =?utf-8?B?QTQwa1hyOWd2OTBMMVFxYzhpR0dPQVpMbklPQ3F3aitqNEdHaW52bStvNnA1?=
 =?utf-8?B?WHNOMkVJdnNMSktzWTh3SHBGZVZmZXkvZDVCOS9vQ1NOZnhkSmFRZTZSNXBF?=
 =?utf-8?B?NkM5MGRrUkJkeWtCWkhzRlNXb09JNUNzSCt1a1J6cTkwbzBKR3J2ZjAzMWhC?=
 =?utf-8?B?M2paMVlocnlqMTNuejVRdzNkaW5CZ2NTcU5FQUFTcWh3V2RlUkJhV01PL3Ro?=
 =?utf-8?B?ampZMzU2UmE1aG9WTm1NaHJGMHF3VTQwOEdOKzRRRXJ1Q2NCTzUrRFZROWl2?=
 =?utf-8?B?Z3BsanpGdE1hSnFDZFBvbjRPM1F3dVBvMHQ5RWhnT1NhVXo0VnExVURFZ3VL?=
 =?utf-8?B?bzh2bVJUaUwxcHJWUXpmTHZuTURSN1NQL1RhVVU4eUlSRGpHbDd0NjYrdUo2?=
 =?utf-8?B?TlJjYVpBMGthZld3OWhsK1hKMTI1TkxKNFJacXJjelRYNFAzc2pTQk81amF3?=
 =?utf-8?B?MW12TE1nYUtuZ2F2bkEra1pTQnpjSjBoUHRjYmN0YUVsYk1BUnRRbVNOOVg1?=
 =?utf-8?B?c3JPSmhURmZBSENCOWExaGU0YzZVd2ltYjEzS1dpLzdmS0h2d3g4R2xQNW0v?=
 =?utf-8?B?VTN1ZEJ5Z3NocDFpOWNPQlg3d0xLR01WRXpNMHhSM1RhMFlkZXU5d25ZK3da?=
 =?utf-8?B?UFB3MDFDa3RKcG5SMCtPNVRJOFZqNnFHRnlRZ005WmxtNHBibk5QVjlFSHFE?=
 =?utf-8?B?dXdGc1d2WXZzaXRNUEFrZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R09zZ3pUTEM4QXRzMnlpOHpNYmlEcFJIb20xR1lDYjluOTJ0UDRhdWsvUVJl?=
 =?utf-8?B?S2xCeHYyRVozRkQrSEpHRnlLYzFwNUFUeUkxVGtaclVHWllFOXNGV2p3aFRU?=
 =?utf-8?B?VlJEbEZGUStYajB2NGtTYm5KNUx0U2ZRb0hYbUUzdWtKUkdSQ05pS2xBbGtj?=
 =?utf-8?B?UGt5emM4bVV1eUVkWCtqc0RVdVZIN1NhdVV5TWUvTURSaHJjalY0dEZ1bStL?=
 =?utf-8?B?dFlDV3A5R3JUanhIL05qOHJDbE8zbjhRZ3BoRWc0T3RXeUZiUFNqTy8zNUd5?=
 =?utf-8?B?RlBUUWMyWHcwaU9Rb2lPNkVTTyt1dFRuYVBURHdWNTlxYndiR1Z1ZTBreWUy?=
 =?utf-8?B?MWJMZm1sMld3YVJiNXdmaEgwTjZaMjNYUFVYZUllUnBIR1llYlUwNXVSRkpV?=
 =?utf-8?B?Qkk1OEVCNVZqajh4WUZMdHN4WndlSDR5UFEyTjFrOU1lcUhtWm5vVEdtQUwr?=
 =?utf-8?B?UXBpM0g0VU9NZCtXOVNvN3NMdDhoQUhja2M5YlJGcE1tblI5ZGhzVGNPdkNL?=
 =?utf-8?B?cDQxd2s2SXlEVUZKcm1vVWVhdk1WcGx4WlIxQytHZ05lczZoUVdOWXU4bENa?=
 =?utf-8?B?ZGlZQ3l4dVBrdVk2V3ZXd1UvaGJwTittUVZsRzFCSFlrMXJZWDByaFZuV3Zs?=
 =?utf-8?B?ZDh6YWcrWVBsQXBGZkl1MVdHV3pvcVhoOXJrN01SZjV5U3AyVTM3RkVzcmNp?=
 =?utf-8?B?cncwcHNBOUtFMlRDMXhpSnZMcVRiWXcrTEJhM3k5R0ljc21ORWRFcEFtRGwz?=
 =?utf-8?B?VEFITk4rU05GS0V2Um9OalZHdjlEdlBKeU5UUWRRbi9XeUY0TGJvSCt2SnRR?=
 =?utf-8?B?MGs5cHVOYXlqODlmc2FES3BiU1NxT2lxQ2N6eEZtSDdqdkNuMlpoOFkxK2sr?=
 =?utf-8?B?ZyszdjgxMlRDRHFZT0F6WC9EMlZmdEVxZWsyTUxVV3J3cmR6V25mcGc5RUFs?=
 =?utf-8?B?Z1o1a1FXY1BZYjhLeWNpb2NGQ0ozVk9VcVRGYlo2YmlZMy9ySHJpNGE3RG9Y?=
 =?utf-8?B?aEI0UytoT0R6VVRXWTJGcWdMNWp2ZFQ3NmxVWlRLZitQaVBiQjF3VXlYZkEv?=
 =?utf-8?B?akcwQkcrbzRvR0pIZENGc0wrSHZicENtK2c1N3lEWkJoWFVKRThzRlBOZkw3?=
 =?utf-8?B?Mmd6UUt1aFBleDhwdHRibllLRDlxd01Sc25ZMnVsVVdNVDFZRXlkTHEwek9u?=
 =?utf-8?B?aEtjNkNlR05sSncra29PYUJmK2tHTEhOL09BZ0czSG9xRDNabXN6VFNkN2dX?=
 =?utf-8?B?Mm0ra2VSeENXNk5lMCtWZEhaVFRKUXI3K09aRU51bGsyRVFYUC9WckQraVZw?=
 =?utf-8?B?WDJObGhZUE1rN01kRWdla216dzU4TUZOUGM0UjlzNUlnOTdOZzZpT0NtdjJ6?=
 =?utf-8?B?OVJrZ0ROWkxCaytwYTVBSThJMk9UcExVQWRzRkJvaE5KOThIMGZkUDIxL0Zj?=
 =?utf-8?B?cEFWSU1VSC9NNENIdE5UUnZ5d0V6NTBOdmlVbWtXS1gzaG82RTJxWVdORjlL?=
 =?utf-8?B?Wlh6TjgwUTAwdTZkWDZHWmt3NXJoOTZ2Mnk5cHBSeGNTMTBSUExlTEJoSUZN?=
 =?utf-8?B?dHJaNWlUOGZWUUVXa3JhQTJmcmk3YVd2aEwrQUNEcTFkdWJ0RndiSzhFeDRS?=
 =?utf-8?B?aTZ5b1pUU0NIU1k4U1k1dGxxam1WZWJmZmNNSUVtb0czdHNlTUp6SGZKcXp5?=
 =?utf-8?B?Unc4YnEyNUJuNEROV0xJU2g1Q2xnK2xuRUF1WjBvd0dRM3AvbTMxVkFJUXVB?=
 =?utf-8?B?cFNtLzhQSVE3UTFpd1dOSXRUMEZWNnJCbS9BWWloc0kzOTFlMlQ1ZVNVb0VY?=
 =?utf-8?B?KzJTeUpjREhnZ0pjaWEyeWtrREpQMjBEUWpPOWs2Zk9Zc0pTZjJnYmRsYVY1?=
 =?utf-8?B?eUtEY2g3d2tKMzl3WVhLUmlCVHhZNi9jYjRPcWY5eFpNcWNGL3VxYmRvb2xU?=
 =?utf-8?B?ZXplb1Z5UW90Q01JRndMZXFEbTYrZnM2MHNQSkJNeWpYOTBDbTVhRXpGZU14?=
 =?utf-8?B?ODQ4ZnJhcnVHQU91UHRJSHk4bzZaY1dxd1ZkOVM4ZDg3ZVlnY283S21FN3pw?=
 =?utf-8?B?a0thU3pTK3R2RFNUMzdBeUdlR2ljQnRpL2xQMHpERS9tNG9VK3FwcVQydmlp?=
 =?utf-8?Q?GbfHYkC8MLcCJqA6PaD740EiG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3a167a-6d6d-4dfb-4dc8-08dd0abfbb2c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 06:34:35.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5465NhD/BSMojWbVefSNBVZEQLgmDRSZqNsRiWSoWFrlRmLUmL/BrfL1V5U/vCKr8mowe86O9h8DIdHq7laYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466

On 11/19/2024 5:50 PM, Peter Zijlstra wrote:
> On Fri, Nov 15, 2024 at 06:07:56AM +0000, Dhananjay Ugwekar wrote:
>>
>> Dhananjay Ugwekar (9):
>>   perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function
>>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
>>   perf/x86/rapl: Rename rapl_pmu variables
>>   perf/x86/rapl: Make rapl_model struct global
>>   perf/x86/rapl: Add arguments to the init and cleanup functions
>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>>   perf/x86/rapl: Remove the global variable rapl_msrs
>>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>>   perf/x86/rapl: Add core energy counter support for AMD CPUs
>>
>> K Prateek Nayak (1):
>>   x86/topology: Introduce topology_logical_core_id()
>>
>>  Documentation/arch/x86/topology.rst   |   4 +
>>  arch/x86/events/rapl.c                | 414 ++++++++++++++++----------
>>  arch/x86/include/asm/processor.h      |   1 +
>>  arch/x86/include/asm/topology.h       |   1 +
>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>>  arch/x86/kernel/cpu/topology_common.c |   1 +
>>  6 files changed, 272 insertions(+), 150 deletions(-)
> 
> Thanks, I'll stick them in a tree post -rc1.

Thanks Peter!, there was a bug reported by Peter Jung, it is fixed by a diff that 
I posted as a reply, could you please squash the diff into the last patch of the 
series before merging or let me know if you prefer me to post the squashed patch 
separately.

Regards,
Dhananjay
