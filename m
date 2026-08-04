Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F0257435;
	Tue,  4 Aug 2026 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826852; cv=fail; b=t8FUVo9zxfWKEl0VHUD3LMIsYbAQWZy4MhrV0j2yUvSGewc7yUuVrGdTrfwtDCE7nzvTVV7jj9lMpKhNDq+DVDqF/Ok2xGUExy3/TqP8APgFh5Ji8JXhDbbvhk4mDJHSFqfDccSX20YBXiD6+sLDUibkPBsGjEZrZFnGIVr8Idk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826852; c=relaxed/simple;
	bh=u7zvh7czSjGTuBBhaI3HzouTEbpWTqQ2ITVusbPIRN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U9V0GqOB3g3RidYPQOihwLjIuyr+YeWR4syXy0oSx+1cYhEMLDDk5Eyr+JTLUUvCOuEt6oo7BQIl+w+LhvYdAOiia1LWegoWr40WeTDXPTG/hfL6SDlLpbwW/tLaQXGhVpNo80U1h82kEI+rqWJsEmV5DEooqN3itz8UI/30VHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fBlUzZN+; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fBlUzZN+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArZXrKnf4fx/fsS1EbU0SrWibroLLiquyKA6mecYkTO9KlSBZFsOwYNNukb4y/7EytUqS35EcRWaIhtReES3/iNqEzLzLnUh9HeiJu3TMQMxyX1bAZqXY1caxqXrVXfF3FUaVM/YZoikC5pR+4YKzS3txCRDeDrCUGKLH2NtLS35y5p6kgWe/aDNaO1HFrqMTzk7WxFWhojB7f09+dLq9WlnYcuoVWipxO/13EHMPAggzQaytfdaVbDCLZeaIfFMSEsEcu0LTYzWdykaJyV2KemSo95VHqoldiVsU2GnEO3K0mj5uzQBz1pmXv1cikexK9yJJjZ/2iyEGSgqCv96xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuwLFGCl+/IieWIgQ1aExclXeYbS13DA7x+9xOlbAhU=;
 b=g0uFtzIGrwElIlCEz+SMgwpnpWRCLTzpliy6v8eQYSRzIpJjP6wSaCRcqhwz6WOp6ed6HtVH3qDHvKSRF0/RYCwy7zF/hUmVKZPpaFoydpLWMwCkrY4dXl5LsAC9vkjVwtwWgduu6u3ZNhrG0VLxVHfu8FylC+J9MMyRXRzSq7k9rRPhISytgv76APiY+yUM3LUXgFxTKDyk+V/iw1Yjzk2dMYdgZIIUGo8OdezMtpS8M9q+rR6UNZgEd7D9zOyoI3uf5z622i3EDsgB662GlV7PlyRSvCzngut7uHmAnYACjrSjbi96FktAODn/qe3Pd+5Q3z3BIOkyS0iWgJXXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuwLFGCl+/IieWIgQ1aExclXeYbS13DA7x+9xOlbAhU=;
 b=fBlUzZN+fkOdz1ENfsq7vm1q5PFUxD6LGWigvSMGnTh2q3neeKAJ77sCzkgR0BXbf1F6LVPIT7J5mlB6xwq4k9UgAdV3bOR2wc/2YpARW5zXhyqaJsb2h0vgnq9YipHT7tn3awaTfDtLHtBxk+eugRuX9mOJr93Z7hrohiv1oMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 07:00:46 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 07:00:45 +0000
Message-ID: <7284a598-0799-45d9-85ff-739563ddf226@amd.com>
Date: Tue, 4 Aug 2026 12:30:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf/x86: Do not read fixed counter control register
 if there is none
To: Petr Tesarik <ptesarik@suse.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260717150315.2868314-1-ptesarik@suse.com>
 <82ff3301-13e1-4ebf-9f74-aa4318848cc5@amd.com>
 <20260803105751.17146a49@mordecai>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260803105751.17146a49@mordecai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0354.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::8) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f1f071-ecb2-4971-cc4a-08def1f61b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4oGRLQrPeGx7jlDgR/OxP6n/cZf2iR4DSHk/hEEfTFnmOkEW8T1meZV+lIXXdTdyMSRFRfHVS2UXT1iEN0LnghdktcFXQxeMhGqbYojTfmPnctfGR0zOaT8KM1CTaABV+AoTMo50XWMEGrA1LQFjUlMDi7sNXN8UBsdDw39zu7zmycxvOkdCgmDLELdvviXq/idL/Dq3EeLj7AuGSaXB7g/dJbUtar8yDn7Rb0gaqK+XrmHOCIlfct50FaGZl6QqPsyD3zGj4yVUOAyltBhKYqJttuyGuWrIfs0GsJ0glV2pZQg7WrhelU/TIhC0sSa5L8g0DbVU28LPbdsfq2yTb29/wO1VESTvvbB/kaZXnf3xerFClXVabPEMClpGrZjsDe9bslLrdB4hz4Xu/psYhzwy9tkT/vmnMsOPXHJfWvxuKs06FsLqDFWx1MktosL6jhElx4AuleYiDbOdZKpzfw/iA5OVjPK/9S+aD6aL99/mCiHXYo5GUpxyl5Y1Uvk07SQoWQPXegG2TCyEz3riCptu6EwsrldhBtO9/iu6yuwKttPDD2vMRquhBN/stJFh8MdnU/pmHLnGkUnb99uOUpdsO+Qw4PH5+a5oAbaV0ec6tladnGYYcu6wJ6kg1oBx9q9kzatZ0COXODhDX7i/+1JY7jHb9MhdfEMNH2kDZzQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTZKMEFMeXQ4ZS9hOVQzWk1ZcXBlWERUSHdDOE0zYVl1YnpSdVFMb0Rnd3Av?=
 =?utf-8?B?VEpSTS9OS1NJRkNLNUp4RzRkUUJIQldTN2htcWgxYzVPbW4xQmtQb2NrVHZG?=
 =?utf-8?B?N1ZUcEdvOUYyLzFJMDltMHRSeFI3bFg4cUFYMFVxb25ZQXJWa1RaVGJLZmdo?=
 =?utf-8?B?S1pGK0ErRDlocjNCN0xZL01MdzBqbUZRL3VVTU5RTkxuMnlObGdCZk5yTktP?=
 =?utf-8?B?UU5uc0FNblhsWGF1bzc5eFhBQ1pxV1l0cFZYN1RzQ3plNW5LUXVkWTVlL2lv?=
 =?utf-8?B?cFpSdGtIVVBkODNlK2pOcGZMN015WGt4Slg4dFR4OXMxOWh6dy8zMjZVWUhv?=
 =?utf-8?B?eHVNN2hVektqZHZrdklIZ0RKRk5nWnlyMkZNalh0TUxqYlhIQS9oSEZKd21G?=
 =?utf-8?B?UWE0R0d5OVArd1lSblNBTVE5QThjLzhFZXk2NzJuais0WmdWSmtOSXA3ZG1Y?=
 =?utf-8?B?L3l0T01uOE0zU3p3cjV1OFFFSy9mdTRTSlJHUlVGZ2c3TTZVeUZCbEJJeTlU?=
 =?utf-8?B?YWwvOU84N0owS1ZVU01kMlY3S1ZRSDVMbm94SG1IYjdkbnh5bVBkSTZPZGZN?=
 =?utf-8?B?ZG9uYzBFMU9FQ1QrZHpJcFVaVVNiLzdpZENEUExzVzV3QUhwMEJpQWU4Ykln?=
 =?utf-8?B?VS80cjJ3ZVFLb1lEMVVhQmdJKzN3K3p5a2Z3eHNweFdKdTU5UXFHSlo2Ty8r?=
 =?utf-8?B?elVEOXBKWWxycDlxb1A0dmZ5bks5dkVFWVh2WGUrRUVtaU5MN0E3M3RTNW0v?=
 =?utf-8?B?MVRORGwyLzEzR0Ztb1JHWVo0ZUFyNGd1YjlXRjBlMWdQMEhBNXgvYlhDOG9v?=
 =?utf-8?B?WU1yWGxZZTBFMUpxcE1QR0lFU1pwa0lITnhsUloyWUxnYnRjL05DSURGbnhL?=
 =?utf-8?B?R3lXNkNTeHczVlV5bFZZMnJkNmo1Ryt0ay9IZ3oyS0xWNVJyVHd4MFRnVUZw?=
 =?utf-8?B?Wmp6OEtWSXcyUllBOW1OOEJnZ2NUZElIRFo3SldTUzh3VlBkdXZ1aS9OWTJO?=
 =?utf-8?B?ZE1lZzVuams5VVo1RUFZYzNRVnpmS2VLMHl4dUlRcktmWGR3b28vcEZWRVdt?=
 =?utf-8?B?R0JuOC8zakh1TGgvMlZ1YjJFUkUwOEhzY3VnZEFUVUZPWkJpUC85aHdWWE9C?=
 =?utf-8?B?eXd4Q3hjUVFuQWlFV2d1NjdkT3Q4Q0JYdzF2d01EUXFKcFBoc3hoZlRER3lR?=
 =?utf-8?B?NHBGN3Y1ZXd5eXRPWFRSb1FXTzBKbU40RjNkZ2ZaRUk0cllIZ1hhMUFJYjMv?=
 =?utf-8?B?RHZxMitjRlEvRDZZVUk2VWlKd2JwaVIxOVhFMFpjK0dZemZoNk1Bd1gvUzdY?=
 =?utf-8?B?MW5jWlZpMmNOeUFQZVNLdEdsWUVWdUxacUxEdysyWEh0VUhwN0oxdG44SXFU?=
 =?utf-8?B?U3UyaCtXS2x6Ymg3eXRWcm85RW9uVFZCZlM4WmJua210L3FneGtMZ1JtU3Fz?=
 =?utf-8?B?SmRwTE02RkwxQXRPY01iVGxjLzczZWlOd25BeWk2ZUJ1U3BldUY5OHlyYjZp?=
 =?utf-8?B?SGJMbDFNQmtLSS9FOS9BZitxNzFKbnk0K2QreWQwN2JLbEdsK0sybHlpSENT?=
 =?utf-8?B?YjJob3lDNzdOODdWZ3RnWU5mdldzQk8zc08rejdoaURaZC9GekZCajJ6aTdV?=
 =?utf-8?B?YlI2d3F2QWYwaHJIb1ZNNm5nWU1xNWJxeEdsMndTZFRMMXdSZ1BNQUtLOTg3?=
 =?utf-8?B?UG95OU41N3d3bnRhUFpTbUVwMzc2S3haWTVSTUp3dmFmQ1dTaC9lRmlhMFNS?=
 =?utf-8?B?NVlHaVVGR3pvaksxSGFLL3poMXlRbnQzNUhuc2tkSmdkbnAvblE3eDNzWmpG?=
 =?utf-8?B?alBVK0tHeUx6aHdVQTBLdklUSHI5WDllNDJ2TXVtM1VjS2M1UHdnL2RUbm1V?=
 =?utf-8?B?R2cwZk9qSWNUOHlKdlcxOXhIMlRPYmNPeTZ5aHRmTmlJQ3VDWHVSSEJLNUNu?=
 =?utf-8?B?dXpsQTl4aTZtb2NrY3JyS3cweitYbU4vYjVEcFlyZm5HY09NQWNQZUlOYlY3?=
 =?utf-8?B?bVYzcGVpWFVzT054QTdrc0VXNytScjhpYk9qT2JnRVY1UUNEMW9YS1VPNEd0?=
 =?utf-8?B?Y3JuVlFxZXVhalhWNXRmV2NLYi9aOXo2YnArQ01XZFJncTVwTDRQY3VwQ2hU?=
 =?utf-8?B?emwvdEpYR01MVVU1STQzb2k1ZUtUaG5wV2gzVVM4dks0bGxGTm9XOWhrRnhL?=
 =?utf-8?B?RDBoaXRQYnhOaW5wWXpVSE1lWHpoKzgvdjhwZmgrSjVkMHJwRHJmQW92amxz?=
 =?utf-8?B?ZDErRGdmVlJ4cTJDUkVZOXB4YkhwRmdmSWdDYzJ5ditBWFhwOUxkN2gya2hN?=
 =?utf-8?B?VXJraWdVT3BFSVdEN2JNaDFVakZoMVN4WHl4dFhOek1WbFNXQTZXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f1f071-ecb2-4971-cc4a-08def1f61b5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:00:45.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgyz4Kf/jNAZ7XN7jBbxt98ULnZrE8TiIcKAgiJvetVWm9QXjXDKb8g9OV0DAIdtyApYIxGfTDEzqh0UfKOcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179

On 03-08-2026 14:27, Petr Tesarik wrote:
> On Mon, 20 Jul 2026 14:57:25 +0530
> Sandipan Das <sandipan.das@amd.com> wrote:
> 
>> On 17-07-2026 20:33, Petr Tesarik wrote:
>>> [You don't often get email from ptesarik@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> When printing out CPU performance registers for debugging, skip
>>> MSR_ARCH_PERFMON_FIXED_CTR_CTRL if fixed counters are not implemented.
>>>
>>> Since AMD CPUs with PerMonV2 do not implement this register, attempts to
>>> read it generate a #GP. In particular, SysRq-P logs something like this:
>>>
>>> [   14.748144] [   T1118] sysrq: Show Regs
>>> [   14.748896] [   T1118] unchecked MSR access error: RDMSR from 0x38d at rIP: 0xffffffff937154c6 (native_read_msr+0x6/0x40)
>>> [   14.750878] [   T1118] Call Trace:
>>> [   14.751505] [   T1118]  <TASK>
>>> [   14.752057] [   T1118]  paravirt_read_msr+0x7/0x10
>>> [   14.752940] [   T1118]  perf_event_print_debug+0x135/0x240
>>> [   14.753931] [   T1118]  __handle_sysrq.cold+0x9b/0xde
>>> [   14.754855] [   T1118]  write_sysrq_trigger+0x59/0x80
>>> [   14.755779] [   T1118]  proc_reg_write+0x5a/0xb0
>>> [   14.756631] [   T1118]  vfs_write+0xce/0x430
>>> [   14.757406] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.758322] [   T1118]  ? security_file_fcntl+0x5f/0x120
>>> [   14.759083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.759754] [   T1118]  ? __x64_sys_fcntl+0x80/0x110
>>> [   14.760334] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.761005] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.761676] [   T1118]  ? __ct_user_enter+0x27/0xc0
>>> [   14.762270] [   T1118]  ksys_write+0x6a/0xe0
>>> [   14.762776] [   T1118]  do_syscall_64+0xe1/0x610
>>> [   14.763324] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.763995] [   T1118]  ? __ct_user_enter+0x27/0xc0
>>> [   14.764564] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.765233] [   T1118]  ? do_syscall_64+0x205/0x610
>>> [   14.765806] [   T1118]  ? __x64_sys_ioctl+0x97/0xe0
>>> [   14.766375] [   T1118]  ? __pfx_woken_wake_function+0x10/0x10
>>> [   14.767048] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.767717] [   T1118]  ? get_close_on_exec+0x34/0x40
>>> [   14.768311] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.768985] [   T1118]  ? do_fcntl+0x6da/0x8e0
>>> [   14.769502] [   T1118]  ? do_syscall_64+0x205/0x610
>>> [   14.770083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.772321] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.773166] [   T1118]  ? tty_read+0x150/0x220
>>> [   14.773722] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.774423] [   T1118]  ? filp_flush+0x5b/0x80
>>> [   14.774966] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.775660] [   T1118]  ? filp_close+0x25/0x40
>>> [   14.776214] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.776936] [   T1118]  ? do_dup2+0xae/0x140
>>> [   14.777486] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.778309] [   T1118]  ? ksys_dup3+0x67/0xf0
>>> [   14.778870] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.779600] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.780310] [   T1118]  ? __ct_user_enter+0x27/0xc0
>>> [   14.780917] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.781613] [   T1118]  ? do_syscall_64+0x205/0x610
>>> [   14.782215] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.782907] [   T1118]  ? ksys_read+0x6a/0xe0
>>> [   14.783429] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.784120] [   T1118]  ? __ct_user_enter+0x27/0xc0
>>> [   14.784741] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.785431] [   T1118]  ? __ct_user_exit+0x15/0xb0
>>> [   14.786014] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [   14.786706] [   T1118]  ? do_syscall_64+0x98/0x610
>>> [   14.787282] [   T1118]  ? exc_page_fault+0x6d/0x180
>>> [   14.787873] [   T1118]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [   14.788612] [   T1118] RIP: 0033:0x7f70d6497e0a
>>> [   14.789186] [   T1118] Code: 08 03 00 00 59 5e 48 83 f8 fc 75 1e 83 e2 39 83 fa 08 75 16 e8 05 ff ff ff 0f 1f 80 00 00 00 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
>>> [   14.791587] [   T1118] RSP: 002b:00007ffc36a93580 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>>> [   14.792617] [   T1118] RAX: ffffffffffffffda RBX: 00007f70d65f6580 RCX: 00007f70d6497e0a
>>> [   14.793594] [   T1118] RDX: 0000000000000002 RSI: 0000556f34e41c30 RDI: 0000000000000001
>>> [   14.794574] [   T1118] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
>>> [   14.795563] [   T1118] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
>>> [   14.796537] [   T1118] R13: 0000556f34e41c30 R14: 0000000000000001 R15: 0000000000000000
>>> [   14.797514] [   T1118]  </TASK>
>>>
>>> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
>>> ---
>>>  arch/x86/events/core.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index d1af33d96d0a3..8310bedfc364f 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -1581,13 +1581,16 @@ void perf_event_print_debug(void)
>>>                 rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>>>                 rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
>>>                 rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
>>
>> GLOBAL_{CTRL,STATUS,OVF_CTRL} functionality is also provided via different MSRs
>> for AMD PMU version 2 and I assume that reading the ones above will also raise
>> #GPs. If they don't, the reported values will surely be incorrect.
> 
> They do not raise #GPs on my Ryzen 7 system, but that's about the only
> system I have tried.

Perhaps it is based on Zen 3 or older where x86_pmu.version is set to 0.

> 
> Honetly, I was very unsure about the availability of the feauture(s)
> and what the appropriate checks would be; that was the reason to
> include you as a recipient. What is the AMD-recommended method to check
> whether a CPU supports global perf control MSRs? Does x86.pmu_version
> even work? If yes, should I then simply make the actual MSR numbers
> conditional on AMD/Intel?
> 
> Any guidance welcome.
> 

AMD processors with X86_FEATURE_PERFMON_V2 also set x86_pmu.version to 2.
I think that it is better to move the parts that require the use of
vendor-specific MSRs to a new callback implemented in
arch/x86/events/{intel,amd,zhaoxin}/* instead of making additions to
perf_event_print_debug().

I'm also not sure why MSR_CORE_PERF_GLOBAL_OVF_CTRL is read here because
this as well as its AMD counterpart, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
are both write-only MSRs.

Mind if I send a cleanup?

> 
>>
>>> -               rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
>>>
>>>                 pr_info("\n");
>>>                 pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
>>>                 pr_info("CPU#%d: status:     %016llx\n", cpu, status);
>>>                 pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
>>> -               pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
>>> +
>>> +               if (x86_pmu.fixedctr) {
>>> +                       rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
>>> +                       pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
>>> +               }
>>>                 if (pebs_constraints) {
>>>                         rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
>>>                         pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
>>> --
>>> 2.54.0
>>>
>>
> 

