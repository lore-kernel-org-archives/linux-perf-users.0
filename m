Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3342609EE;
	Wed, 24 Jun 2026 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283182; cv=fail; b=tSsXfcktiOLmHH5WlcfkWuwz/6JSnMWR+pOMr+bTM9wThY9pHKuiwcZ055rsjjo+Gxo+JiBCIoqiA+UEvVAxcoqNQlGKAQiigeo2vdjkCGu62KyunZRn5Hnqh4IWnvbJHNT4XSS0b9Mz5Aki8A6UiOKnfzw7agTnlJPmvDRO6fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283182; c=relaxed/simple;
	bh=4PUS7JiXS0mvCbHHKm+Rnyb0DrkLkHtuEt9sd+1iO8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ndMG00KJdUvqEd4qdKd4SHj26Tsjueb+0RBEPueZsz5Hw/SjEPfRzUduZy9Qgcw4bye5n3e6rxfZIp0li8ncJO6ltYZld9tC2nG7cxc+M4gqqYRLhyh5W2cHk4iLw6n1zP7frLyPgDruJX/heLwqmLibBophZHnT4gJm4EK4k/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MHrbkVfP; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MHrbkVfP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJrlQLcFYcm9NjMpTe9pqR83/XB2HZWBzMaENAm5jR1V5YeqhPsv52zahq9/RMEpZf3OyNcHwUfZGxIUq+loE52LhHyMLmtdf7nVXioaV7+bwMDWKu5aGrddvvSYFe2IXRFdmpv+AfFC3TMoUystx3F2ZXqjEx1uo1Otbp/GZK/g0Y1kr+UPzxodETtfEjTmKvL/0379Zi0JSjQKNNb4H+jdHwrZGE7bwtjvMu+UfxLR10ojaT3FiToym6K0Ru3w83sH4Ogb6weWdrHoFQ41uKRzaOLaHO5zoaqnwDvIRxJLR7wplcTvUmSU7eS66YDwVwcJc3BwY0Aw5hH1e8aYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT3qrZOCt7VUPyTe9G6XsdE06/3gzwlZ7wuPDgaS7sU=;
 b=Zks6h6uKJM3jNw0vqe5beggDMkQTlafVmRnjMhqwesNLiMNV7msdOKBvxF6omkZ+fdGi7Ch1cB7X6xNc/c2eOilDbm+T1q89RdPSf7teV1wFMenRqoa4jtSjd3R8CyTFIj+kkyJGf3I/uZ52Ug/4BBTChswhFJ5guGv8Obs+tM1J3EZsbAgOE+wQNs4LfZa7sXuE0XQAoKaAus+ngAQz+6cOdlcN31LO7hRL8iRakEcLzcsoG6OTVbDqUyiRaTFIobcxrPbmuSpjgiHGOnG5oCjhg6MG/xWa5vbqWtfAtPcei/QodJQQS1xgWXsE7/YzKrU6JpXNCWNskQq9FnW1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT3qrZOCt7VUPyTe9G6XsdE06/3gzwlZ7wuPDgaS7sU=;
 b=MHrbkVfP7l3n03V5cjA2xFuYp79grRA1mq2hkk+jqOd67PmzMRXd9+c4Ld+3gBTjmRrGURh1rNKTEsLLiSuYorGxgfKjvOX2o9kULOr8CYHUjg5SNOMJ+c3NvFx890weYTjCckedgyijTCR8AaYtPV+vozBok3ZWICJeKjoKQx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 06:39:37 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::cab0:6260:dd96:3fd8%4]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 06:39:37 +0000
Message-ID: <71f4c100-ea02-4a64-b2ee-5bd2d5d01fbb@amd.com>
Date: Wed, 24 Jun 2026 12:09:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: Add group validation
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <0f2cff983d79521e153d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com>
 <CAP-5=fVg-mjLj2v6Q2kXMBU26rn=CgZNyFE7O=-+ZuE90RC_8Q@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fVg-mjLj2v6Q2kXMBU26rn=CgZNyFE7O=-+ZuE90RC_8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::27) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: c75fbf22-36cc-4ad8-c933-08ded1bb5c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	a1XOCdg30/qEiYjG9+NqzluqHYqvN8s670lVheJHbzehirYw/2kDGfpmOwXp+eawPZguSK86kJEx5oNdhEFowdglFvCMu8JYbEGsb6C9CyHSiTD+1e+qXmNsp+Fwql31pNTQylXBfRSr+HpMFAZy0BG4pMBLEWXkNFn1BFeu0gr18qAHbHlM1qCWK+qDXGBklzp2ka9l8+1VsTvluKI6i4AE3BHL4awuJr9U/NmbGaHA4snQiJAvPMKVzs/cXK2lA9ECMxp6FNf3sxjFrFnAeklGFs6Bq2cYqqaw4nAo8eKhVddAdpkjLgBG7M8LDWVioA+8nogJV8QirPCg9Np0V7nW4FncUqh0RM6gDBPs4Vu2aG4rFzRUbPMZwGgGCkk2PQsPK+jtcQ52dADlRTUvw78U7Ie9S1mnktbqwN3QEqh6+wxd9jaTT0IHlKuEuRD3v20NgWw5Wx4p7s2H4KiSi231y0K9Mf7O5cVwsHS6UFIozghrAcobq/53XltFUCaucPP7E4NBnti0eRB9/EUptudEMDclIVbt8omTZJH/y6y0AE2KLs4yKzn8bAhbe1Xsq407GhjPiWcV3PDBEKUn1X21EREkXHzxDDtN65arZQBnCcZShxDXb1noXsBhyUPdibPSzQKI/LAhdw05IGatDVvG4dl/9tMwd6h/ZDAxiRo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDZCNTRaaUZ2U0grSFNGMEJJZG12djJzWGdKczVUenJiVko2WUh1bGQ1RVRm?=
 =?utf-8?B?V0t6K3pObEY5K1p2MG8vT3UwTFkyK0RyUmhkSmNyUEpTWmNRNmpZN2UyUUtE?=
 =?utf-8?B?Yy9uUWFVNGFQQXExeS9YT1ROVXdCZE9rVUxESklLcGRiTGx5YXdhVHZYR1Vs?=
 =?utf-8?B?clJnMGFDbmV1YUdmeklKQVN3VXBuREVydFhUWWlRbzh1WFpXbHVmVTRMN3pD?=
 =?utf-8?B?cWYyL0JHVzBVT2NGa216bjZjQVUxY2xGUkZmU1NJQndkRDg2WGNYTUcvTjBn?=
 =?utf-8?B?Z3cvZVBRY3pqa1QyRlV2WHMvaTU1SHpBeFEyL3dyMU13T1RoTTFKengzNmZG?=
 =?utf-8?B?YTQ1OUxPdmRIaDFWSlpUVDMvVjl0VjBXNmdBU3NYSDBnRVkzUWxkazU4RFdZ?=
 =?utf-8?B?OUZ6azFHMEFOK3BSanZqL2VwMDdEOVpac2NZK1hrVnJGNjNkZFZpa1V6MTR4?=
 =?utf-8?B?LzVuZmgxNkhza3hRUkhoNWRKTHd5dzZ4Q1l0cjFEMUtQM0FpUDk1R1NlSlE1?=
 =?utf-8?B?TzFkTm1yRlBiUnpLREhIb2R1dVJ4RS9OQlh3NGRlZ1NxV0h2ZmRXOVFBeXRo?=
 =?utf-8?B?K3hUS24vcld3L2J6SktTY1RSU3huRjRKRmtZZTZCckd4bjNuM0Jnd3JjRUlr?=
 =?utf-8?B?T2J1Y2pTWHRHa2VyMDZiK1k5UVlTUjh5UnpwY1g1aTl2WGJDRlFnTE9hUnJx?=
 =?utf-8?B?RjFVeWRzK2dwb2NMYXJoUW4rcTZwTW1uK2lIdU9EL1ZqcW53SG9jK0tXb211?=
 =?utf-8?B?RDVWSkFQZE1ObTVsYnRyS2pSNzdDRVd6SlhDREdQU2MvV2k4NnpWU3pFekVJ?=
 =?utf-8?B?TkZvRDhneDZjaG9abFBVYi9UWGZZeXZQa2NEeG5nK3EvZDZEQVJGUzVJd2dm?=
 =?utf-8?B?UjBJRGV4dW9YZTJ1SU90eFUxMlp5SDcwWlUwODhkdVo5QUE1VmFkcXdyNTN4?=
 =?utf-8?B?MkxsbHA0cUxWUFg3YU5LN29QN0ZrNjMxd0tlQzlxVUplc3hRR016S1B2VFVF?=
 =?utf-8?B?M0lCTVc5VSswbTlwUzVTaUptS1ZZU2NQTGI0N3FlbFRMWTFHQ0QrVVRHVFdQ?=
 =?utf-8?B?bE9EeC80b0tXSzQxVW41cTNPK3pDUXROTytZOVFhb2U1dkJnbFdMWThQWHVV?=
 =?utf-8?B?cHlFWkRZS21wS0pDaG9nYThmQm1Bd1dDZWV6cVl6UG5GU3lTcWQwQ0xIMGVs?=
 =?utf-8?B?ZUQ2eENwdDhvMjRYQXQzQVZaUkpsci9kZGVENjFUNVRmSFdPSkU4WCtnUzZh?=
 =?utf-8?B?THdxUjZqSG1pRTBJTXAzT2U3eTNwWFZiOEx1amxCMEFxc1JkUkIyN3ovY1ZN?=
 =?utf-8?B?UFB0VVNSQ3h5L3BpMExEbXYzL3FrNFVXMitUZkNUdEJrMHNHUHVWcmU0bUsw?=
 =?utf-8?B?eVJoekM5NWJ3RWxQaTF4dkJCU1o5L1NHU05xd0dRU01Qc1dydGNkUG5JcE9n?=
 =?utf-8?B?T1RxaURzV2orVSt6QkR6UzZkdk9kcCtHUjJaRWNOSEVlZjdRc1pzNWx1RWtU?=
 =?utf-8?B?QVFiT0NwdzVCNHFTWkhsY1BDRTh3c3JIQVJ2YU1PQmFaZEYzWmlLY1gwUjBQ?=
 =?utf-8?B?aThBMExGaHlLTS83VjF2UVBLbEF5ODR1VGJOZ3dPOXI0VS9uMXBvRjE1VTcr?=
 =?utf-8?B?ejlZK29FQndhZmg5YWNQVUdmZjVkRG5JeXBISzZsWDc3VFFZMnR3WFl3dTll?=
 =?utf-8?B?S1hhbWwxY0lmckJ1THkwMUpOUXExc05kSlIxR2ZReTE0dWNmTktJU0VXYVAv?=
 =?utf-8?B?Q1FqcWxwWG5KQXBGdlFic2hPUXdUZ2VXb2RBdWNEQkx4QjUveG1BQ21qV0Mz?=
 =?utf-8?B?TzArOGtndk90NW1hWjBkRUhBSkEyQVNHdGF5Tm54OUFVQVNGZVRqUnhURDJ2?=
 =?utf-8?B?aHR0eUhEVHN5bnNuUmlra3BtZnNiRW90SWhOWkJSS3ZCbmEzSVAxL1RxZStR?=
 =?utf-8?B?TnZMQVNiTjBQMnF5V1JTbTlGdmJBNzZnemVKUitHdzFpcFg2S1pBVDBWbEYy?=
 =?utf-8?B?MWlDckxuc2RJaExlUXpqMWhycTdFZFBCbUpQT1ZqYlI0SFB1eGRBRnpFMjhF?=
 =?utf-8?B?ejE2UHB3SlpPRDlOTlMyZnczbjF4OENHSVJlT3Z6MGxSTG5PM0pjTGtaK0I4?=
 =?utf-8?B?SkRldFNKUkQveHNtb3dZYjRsTGFLNUl0eXg2TzhhL004THdXU3lWRjFnb3px?=
 =?utf-8?B?dlh6bGRDQzlLL0tER2ZvMTJwSWd0SStWaFNJYmpMN3ZDR0k0SzZTVE44U3FE?=
 =?utf-8?B?RWNCK1R0QjlIbmFyYTFBU1JVVWNveFkrN2diMUpYZ2dsUlhYQzFLNXFTMDEz?=
 =?utf-8?B?c2MwQ0U2aWVVeWEzNndza0RkTC85enUxaGJYLzU0ZXA1Zm40aWtFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75fbf22-36cc-4ad8-c933-08ded1bb5c6c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:39:37.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQKilTCxz9EIdiERxb6nFjNFb6Th3hiMcQe+pXzlhfdFWNqnNcI2PSDA0nvZpgvV5a+2ahe5ORN0yn6HPXs+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134

On 23-06-2026 22:46, Ian Rogers wrote:
> On Tue, Jun 23, 2026 at 3:49 AM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> The amd_uncore driver currently does not validate event groups and
>> allows creation of groups with more events than the number of available
>> hardware counters. Because of this, pmu->event_init() succeeds but
>> counter assignment fails later in pmu->add() which returns -EBUSY once
>> all counters are exhausted.
>>
>> Address this by introducing group validation in the pmu->event_init()
>> path. Since the uncore PMUs have no per-event constraints and all
>> counters of a PMU are interchangeable, validation is reduced to just
>> counting the group members that target a PMU and ensuring that they fit
>> within the available set of counters.
>>
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> 
> This is great Sandipan! Thanks for addressing this! I'd been wondering
> if in the perf tool if we could test hardware PMUs for not supporting
> failing at open properly. This is a problem for weak groups, as used
> by metrics, because they try to group all events and then break the
> group when the open fails. I'd observed that AMD uncore events
> supposedly opened but then failed during reading. I suspect other PMUs
> also suffer this.
> 
> Peter mentioned a behavior in the past: opening events in a group in a
> disabled state, with more events than counters, and then the software
> enables and disables events in the group to control counter
> allocation. The perf tool doesn't currently utilize this behavior but
> I think it explains some of the Sashiko feedback.
> 

Thanks, I think it does explain the Sashiko feedback.

> Would it be possible to get a Fixes tag for stable backports?
> 

Sure. This has always been a gap in the amd_uncore driver ever since
its introduction in commit c43ca5091a37 ("perf/x86/amd: Add support for
AMD NB and L2I "uncore" counters.").
