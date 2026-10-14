Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1614F7CA6;
	Wed, 14 Oct 2026 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970766; cv=fail; b=rUJtJh+eLqjkGE+YM8QsoT+MZUZETbSVXLb2lYZ3ocl5x+dTsW3EhSzdArcBm5nmXFgWhjS3pv11S2n/am6OYncnMVAzwEXdVtYerAz3NjcAI+8PDpdYEtQJL5RJo1X3mvb8FRvZ/hBQVrC5oyMlHGdQ3D+TO7ZNuOjvOK+Nybc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970766; c=relaxed/simple;
	bh=g6Nj/FVtLRv/F3u7s/eDj8rsMoHFcrkpz681nDMCN94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WORoddHa+IayHLAdxfPx9C5XUp4Z3khmb3DJHfXyCPizLjKsdKm36VaoscEcYUIciXoslv8jH/bvRwZTDCuf/RK4gR1ujuer76HO8GdIB3SMiUCX0l5ZuUuJhFM+rZcGu7RlXDFDu96Kd4ykgwz95wzTOO1QMyAWXW1Bo3YKpsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4LgGMq8k; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4LgGMq8k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sylyMZSENdm4guVBmAkEze69SaMml2EsupuxQB+EtNSDsjrVAQwqYoQcRcOhuH9bbKcVgLk+MpvMFPXH4oc3xuazXufuW5mOpSzNWP5nQ4Nm1s2IIwzO9msSvUO1SHocpcys59uCEaegtuDtKKTIUG16NOc4L1121F+hSjnFaNCvfFdVbV6KtdcZ6Q2L+fL9MwLEoz4bJI6fZnabPlf45h/Lave5xOkCRuC0ihnec9+edskM+aoo5G3GH9bkmR8qz79H7WTAcSWlDRKI4N9cUB3BTsSTSv4l0ejNUdhnmXm3F1EXo8TGrxCdK5rVo+cYPRA6EEwcbzkTPHuv/crUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9Qm5uFFNL+7H+fbSWI9CCJfVeIL/5xNCzzUW7EDV3M=;
 b=Ire5HB9Te+VhNaLsbMHMMxjeEYYsLj5cxVGJdcqyTlYSwhTuGgca7i2+Kk3oYLyDFBlkgXH7K6huC+l7Tr9hkmcM8SeFPnqUMgELFGvynEPiGx7vDh9bQGetLplTUre7MbTZ3ie1d6unPczajtilNbfDSdKmGLfRDnEwKtl71k+PojnEfMQTjN7v7m5dGiKlDXtUwlVGi3oruXp11e+yucnOuLnmS2BxSg6iTmXE1rQOI34qEmCN+2NwnaCSatzbT4Mz9dBVerfdlgKXxq5+qb4s9R1Q7E+WmTgo+K/ybdfWJJcrhz+GMPheAKmdhIhDIjv0lqRmIVJ4uUYPMKT5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9Qm5uFFNL+7H+fbSWI9CCJfVeIL/5xNCzzUW7EDV3M=;
 b=4LgGMq8k2ZXQ3TqR81IXlnubORHiSVhIlLxvrlZ8ZiQ6Ny2tsgv0wkWCws5oM/VL7jCtncR4PIIHDanhqBFkpaRShaNM6eRk60DfjP+X1TKf1z4XQ82wGl6O7xjvgtbqEuxlxdzAWDgAPIJa90cmQ0qBYpms3ns7d0jMpaiMWNE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 09:39:19 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:39:18 +0000
Message-ID: <fb15e9e2-5d3b-42c6-aabd-3bd2553c5c78@amd.com>
Date: Wed, 14 Oct 2026 15:09:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/lbr: Limit branch snapshots to valid entries
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <20261007181002.4005262-1-sandipan.das@amd.com>
 <20261012153014.GU4121339@noisy.programming.kicks-ass.net>
 <94d387f2-ff07-4895-a722-e8ded4203309@amd.com>
 <20261013074625.GC2009045@noisy.programming.kicks-ass.net>
 <becc5593-69ef-4800-bc2b-0fb217165910@linux.intel.com>
 <eb6c7bda-0dcf-4fac-ad69-9f5b24abc21b@linux.intel.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <eb6c7bda-0dcf-4fac-ad69-9f5b24abc21b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:261::10) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: cec8d9b0-6adb-40e6-c9f4-08df29d704af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r6OaZbzZ+kTtW1CrYrhnvNCHmZ4IqRzbrgRiOJL4OUakXVqdxGaWYDWYlmVwweRFrnhWq9+HOWoz8kXeM3WmM5hiyxTSIVs5xlNz+kN5Lah1XJSQ9gqmDOKd2xXa5RuPcA/C5VxuilJ5X0Gcpk/IW+lEV+mbz5yU+nlo4PvCzkHKYM1De9EI3pfuQk/n7RSGDzLqQfP/G7ylDUQ/F0wA4rRwXmQNEkmQ8xOt6OqA5+j/AyGS+Zr1PTE1cRmTmZC08OJ4OfOuU5U0DNSwLZ5rU4+728lSrnM/Ifq3eZK3S0r9Ug+91SkSkpyEEXi5VMMT2JkBlfF1UQozZvKKfuSCv5ikiw705xHPc8I4NTreUBei0RY4ql+UNr2bH9ioQqqAvPHVq+jG3/Uw1j6AFoucHBsdC1yDOWVc9tpHMy31ektmZDMGJtbjlNIYNuLPeHguNajCaaOE6ffVMBeNEJzMH8WxMmEOJJb13wJbS1WTvCFZAKKDHcaIQf0H1RO35TGUJivgeHhaVi/CRxYduit14+HxB3CpJ0zyozkJuemH5UP9Bc3BYBV6r7hV45AbkaUBEeSzWRxXU9oAlrmq9QLnYcZefBFJWyiJbTBsDpdg8ZnaOrY4gIqMwvKq4EpLWmVC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU5nOFZXdTRDS1EzZUhMeHB2QW9aWml2cGVKSFBTQWFFTEtyYU1VTXhYQ1ky?=
 =?utf-8?B?SGdTWGhLd0R4TEFIZHNtYzZodHJzaC9wc29lZXJabWFpdENkdUZoQVRRbzRu?=
 =?utf-8?B?UXVaVzhKN2JtNFF1L2NMSDFMSFFhSTFtM3JDdldUcWNlaUZseG82d0NCUmY5?=
 =?utf-8?B?M210Q1NybGFFOEQydW0wY1BsdDNoMUFWbWFSaVZGbCtDYytkV21pWVIraUV2?=
 =?utf-8?B?TEVpNFVFeTFJMEExdll4ak1Fb2VSOGhzV1VLUUdzWXdpV08xdklSUDB3QlRC?=
 =?utf-8?B?UU9hM3o0RkNsZkFkQXZGb0hXRTE1cjhPOVEwUWR1MnJhcEpTdUxHeXp5bmwx?=
 =?utf-8?B?cVZHdkUwektvcTkrMWdoQ0JHK0pyalhURWk0ZTR2eThsSU13N0FQdmhVVHhh?=
 =?utf-8?B?TFNlTGs2SytTMWNKK3I3T3RJRmcvZURMYWVmV1lwOHZaMFR1RnFlN3pMVTRT?=
 =?utf-8?B?KzRKcVkzYnRHTnBhN2xpdWY4K1g1VDNySGtYSENnTFhpK0ptR1Z6aURXY2gy?=
 =?utf-8?B?M0tEdkhUSFcxa2NRMGtGU3FHUHd1ekZoSlgreitHN2lJYU1HeXoyT2U0TG9K?=
 =?utf-8?B?cWR3RnJUSmc0Z0pxa2JISnk3M3FBZW4wdGxnaERkZW1GTUJBejBkeWR4dnhX?=
 =?utf-8?B?VGdlampTWVpvekYxSTFZeGhWUStWSVNuWEM3TzJ4QjlrTUszNENUNDRISVQz?=
 =?utf-8?B?SU9Iam90dEVhR0tHTHlNQUJUbTFDT0lOa3VuTTN6L0l5cFhvbjAybW4zVm93?=
 =?utf-8?B?VW0ybEt6SjBTbW02WEp5Q3Z1NVo0OEF6ZXBRUFJoMnNsYThQZmVzR21yUWhm?=
 =?utf-8?B?OEJGQTZ0SWhVVmNBS2N5RmxWV2xhSTFqeDkxZDNpVTNsVmNHNkdWMm5SZDVv?=
 =?utf-8?B?Q253dWV6QURrcnMwdzVxUVd1TGt6ZTBucDRvWUhkR0FqbFhwYXRNVnV5V3dp?=
 =?utf-8?B?OExyWW4zNlA3Q21pdkhkdnpidTh0eURPc1E0MkJ2TTFLdC9MWUs5bkZIbGlI?=
 =?utf-8?B?QW15RUlzdXFDZGJIdkJpa3QrZlU3amx5MkwxdXBtejFBOWpnSnFUdTVRWjVC?=
 =?utf-8?B?TVB0UnlhVk5oRFEwT1NieWNPWXQ5SE43aWpjMXVnWjc2MWZGVjRSdnJlSlVa?=
 =?utf-8?B?RFlmT2Vsa0dwOFBrUk1mMFUyQ0VkdFhBNzFLTkVOR21OWkdST1czRE43bU94?=
 =?utf-8?B?SktZaEpKbUdNOWxndmdjdi83elpIdmVZVW1KeEdaY3BuZFNGbnpZYXJBRlNO?=
 =?utf-8?B?OVl3RTBRU3ZRMFFhYzFQbFRUdVZJdnQ5TmdmTkZNWUJsS1NXcjh3cUdwTmND?=
 =?utf-8?B?YXpnMnJSVlh3aUZFRkFBUnZVajEzSXEvZVJBbXJZcXNCUVdnM1JDUkZnR2VF?=
 =?utf-8?B?NEUrTU9YNWpDUDByYmlrKzhiaVdJTHFMVDQ0MlJFNThJKy9rUFEwMmVJczFT?=
 =?utf-8?B?SlJYbkp5NEZlYUszVXB3SHVjRG1lOE9RR0l6UEFyOXdlL0dKZDFQRWJNTXlo?=
 =?utf-8?B?QVIveFU2OVJBZHpmUndqSFA1RlRSUzhFUEVCQWhYcW1UekZIMVF3YXdsblpl?=
 =?utf-8?B?c1RpcHp4NGpnQWtLdWZ3dE5tRVRQUVZ3eE1UQktxeENPeTRYWkl6T3hMaEtj?=
 =?utf-8?B?bEM2MjYvZWN0RkFMUnRqc2VoeDI2TmJaNVpsbndmWWQzd0t3NEZJdDI0dFc3?=
 =?utf-8?B?MUhwTDgyMEo0RE5SN1BSRU93d2xmSzZuMHJ2Ri9mcmFOamI0a2N5YjF6UWk1?=
 =?utf-8?B?OWhHMGVMYllpbW9qd3V0UjNpQjljSU92RS9HekFHNVprdGpvVjZNeldFdTB4?=
 =?utf-8?B?Q2d6T00ybUJaeUFyWjNWeGJnbzBRTnN5Umw1Y1g3NlNrcXRhT0I1MjJsOXF4?=
 =?utf-8?B?Y084SmNlRWNTRmhST2psYzlsTzNSZmFMcVdVamU2UE52WE8zRjR2UUVxVDZQ?=
 =?utf-8?B?cWJBR3JjZWs4NGNJMmFOcHYycVRyQ2VxRVh3alAyQkpDOEx4RmdHU3A1aUIx?=
 =?utf-8?B?blYxc0ltUmJXUmNHTG1yaFB5ODk1eVFuS25wcnU5dUZsNmJYbCtOZmxYd05E?=
 =?utf-8?B?MFh3V2VmRDhPbm1Yc202bXNVaEZ4YTNxODhIa2pyai94NVd5N1NCRGtrU3JU?=
 =?utf-8?B?RndITVltNkRTTFoyZnFOc29lV1NxaktFL05ad05qQnZaK1lYN0tFTEoyOTJh?=
 =?utf-8?B?dWJXMWQrSWtlTUhZR0tHeGwwMkpGajd2aVN0L2xid1VaSElvb21tblNpLzBk?=
 =?utf-8?B?STJqa2N5aVZUSllmcWtQQzM4aUZiZTZFNVBiampRZ3I2Rm1pL0FsYnRHRkZT?=
 =?utf-8?Q?NHGLWjgEzdU6oJpn+w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec8d9b0-6adb-40e6-c9f4-08df29d704af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:39:18.7329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GpePr7p2CO4pVA5N4E+zfK48WtMBaGEXwsa+hll+sZctKR6zou0I/6spac2Sq+37qpEPKVt5ASq7wQN7ZZQPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351

On 14-10-2026 14:31, Mi, Dapeng wrote:
> 
> On 10/13/2026 8:53 PM, Mi, Dapeng wrote:
>> On 10/13/2026 3:46 PM, Peter Zijlstra wrote:
>>> On Tue, Oct 13, 2026 at 12:14:58PM +0530, Sandipan Das wrote:
>>>> On 12-10-2026 21:00, Peter Zijlstra wrote:
>>>>> On Wed, Oct 07, 2026 at 11:40:02PM +0530, Sandipan Das wrote:
>>>>>> The branch snapshot callback used by bpf_get_branch_snapshot() copies
>>>>>> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
>>>>>> last LBR read kept fewer branches. The entries past lbr_stack.nr are
>>>>>> invalid, but they end up reaching BPF programs.
>>>>>>
>>>>>> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
>>>>>> amd_pmu_lbr_read() skips reading the registers, so that a stale count
>>>>>> is never reused.
>>>>>>
>>>>>> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
>>>>>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>>>>>> ---
>>>>>>  arch/x86/events/amd/core.c | 2 +-
>>>>>>  arch/x86/events/amd/lbr.c  | 4 +++-
>>>>>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>>>>>> index 49b6b8fce566..bf631f60757c 100644
>>>>>> --- a/arch/x86/events/amd/core.c
>>>>>> +++ b/arch/x86/events/amd/core.c
>>>>>> @@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>>>>>>  	cpuc = this_cpu_ptr(&cpu_hw_events);
>>>>>>  
>>>>>>  	amd_pmu_lbr_read();
>>>>>> -	cnt = min(cnt, x86_pmu.lbr_nr);
>>>>>> +	cnt = min(cnt, cpuc->lbr_stack.nr);
>>>>>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>>>>>  
>>>>>>  	amd_pmu_v2_enable_all(0);
>>>>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>>>>>> index 1e1b2f08cb51..a00d3850c4a8 100644
>>>>>> --- a/arch/x86/events/amd/lbr.c
>>>>>> +++ b/arch/x86/events/amd/lbr.c
>>>>>> @@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
>>>>>>  	struct branch_entry entry;
>>>>>>  	int out = 0, idx, i;
>>>>>>  
>>>>>> -	if (!cpuc->lbr_users)
>>>>>> +	if (!cpuc->lbr_users) {
>>>>>> +		cpuc->lbr_stack.nr = 0;
>>>>>>  		return;
>>>>>> +	}
>>>>>>  
>>>>>>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>>>>>  		entry.from.full	= amd_pmu_lbr_get_from(i);
>>>>> You now seem to deviate from what the Intel code does. Please clarify.
>>>> Yes, it is a deviation. I thought of proposing the following but didn't
>>>> proceed because I was not sure about the if condition in the second hunk
>>>> which considers things other than cpuc->lbr_users for an early return.
>>> Dapeng, can you look into this? I would really like to keep behaviour
>>> consistent where possible.
>> Sure.
>>
>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 0a34d674df59..5dfb9e9156e8 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>>>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>>
>>>>         intel_pmu_lbr_read();
>>>> -       cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
>>>> +       cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>>>>
>>>>         memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>>>         intel_pmu_enable_all(0);
>>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>>>> index 0b446d8912e4..6b070490f461 100644
>>>> --- a/arch/x86/events/intel/lbr.c
>>>> +++ b/arch/x86/events/intel/lbr.c
>>>> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>>>>          * but this simple approach seems to work for now.
>>>>          */
>>>>         if (!cpuc->lbr_users || vlbr_exclude_host() ||
>>>> -           cpuc->lbr_users == cpuc->lbr_pebs_users)
>>>> +           cpuc->lbr_users == cpuc->lbr_pebs_users) {
>>>> +               cpuc->lbr_stack.nr = 0;
>> I checked the code, and it looks safe to clear cpuc->lbr_stack.nr here. For
>> PEBS events with the LBR group, the LBR stack is populated again for each
>> PEBS record, so this should not affect the LBR trace for PEBS events.
> 
> I test the changes on SPR for the 3 cases, pure LBR PEBS sampling, pure LBR
> non-PEBS sampling and the PEBS/non-PEBS mixed LBR sampling. No issue is
> found for the LBR stack sampling.
> 
> Sandipan, would you mind to post the fixes for Intel LBR with the AMD fixes
> together? Thanks.
> 

Will post the fixes together. Thanks for testing this.

> 
>>
>> But I’m not fully sure if it's intentional for the
>> bpf_get_branch_snapshot() helper. Clearing lbr_stack.nr to 0 prevents the
>> BPF helper from reading LBR data from PEBS although the LBR data could be
>> stale since it comes from the past PEBS record instead of the runtime
>> hardware LBR state. That seems reasonable and correct, but the side effect
>> is that the BPF helper can't read the LBR stack when all LBR events are
>> PEBS events. Not sure if it's intentional and expected. 
>>
>> I’d like to run some tests for this change tomorrow to confirm the
>> behavior. Thanks.
>>
>>
>>>>                 return;
>>>> +       }
>>>>
>>>>         x86_pmu.lbr_read(cpuc);
>>>>

