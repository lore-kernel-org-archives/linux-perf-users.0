Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BCB35959;
	Mon, 20 Jul 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539661; cv=fail; b=N35SXTUKWgzYF9Co+sM426XDl8+1N01DBZ8m6aPQnmRFPvtGanOz0KYBxdtVExaBFFB5gWk4iq6oLs35VUoq5d7nED8yscuoddLJI96K+OgkBqrMZBKx47siJTvo5dawfIbYHA0dtY/xlV5oskjwaUeo2Xxu+A5a2wd5xuCgSnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539661; c=relaxed/simple;
	bh=Km5F0HP9xiHaw8ZJnWZm4Hc8PYTED7dCrD0wFgMhYY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANtsIcYKAtvOMDMM9MZ0QjR5Nnu5WG2T7+sqkq02wILAyg/SW33bogLFUfLUE9r8BtPM71PECdUw9RpU37Ig0XFfugbce3/DBmmfKVTmQyLRy41KPPayCNSLA/I4UnQvPM4gAbC/6ULDwY94cgcfAteD6xp/bJRiStUlEYn7qls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MLXwVVT3; arc=fail smtp.client-ip=52.101.193.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MLXwVVT3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ3WwgURVD+wRAr9t59f2pbjkBBlb3kDLF04Yyg9ocxy4PY1JRsoo3QzrgoPdAtaYSuBIKygAhQ0GfIj9gr1VDhAEQ/IXWwtDa4G5eYq9QUc+WLnRKJDNwBJ1ZN89t6roP4SNv6cckeqKoPpETr/3Xtp4sruOCihKLUC7ZLnb1ZY79JBhb14U5jxWf/OnNjIOWGSqPGZ/VxsgOoSfjHwBjPIXyVY96gAIc4RsorR2C7OLrlwBas+GsOjen0Lmgm8Pdv/wFfRmz0f5H0uA3VA287fNRAKNHVGhYK31d5VqHKLxe89kvU2eiMx2nkhaPVKIejlJ6Ad5/gKvf96PMMc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwRUT6FNKSlH8XErx1cVoHsgRsP4P3qAJC2tvMFxC7c=;
 b=TVPHp/lqOstEe+ioyRMc2ROnPu8U6JitrF+pt7oyenEgY5UjAdUcWqlZgC8I55iPryuUCtfU/8dbmsMMtpi4qYE8MbCVpSzEU4Qr4qjPkjuPBMs7P5FTJOcIfNMmLbPpRx3aarTbEHfhkkJZQ95Yo6gar77XfyFm6R63BIhOBZQs6/SM3+XrJiug69D65MNtAbqCnGJYxmPxVFlGNrGc8KoCd7t+uCgfERf1MvlKINmvIO6I4NTRaYr/VfH9ZosGFNrdxIuAdKcr1MYu9tJ56bFWWYuSazxtclHGuqQ5gPzr8C8nB5r9HJwmi2HDL8PDDmBxnw/OecrmZYTwKLD+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwRUT6FNKSlH8XErx1cVoHsgRsP4P3qAJC2tvMFxC7c=;
 b=MLXwVVT3KQL2wn8UMfjz3RadziRbK/0k9QE2KyDNre0oNIGh1+AqwVgw04iJq8Aru3ghBkpL9dhEw8RfmANmzgs6sYnmUyHRe+5TihdANipyn64nfiEUcreDKECidHZ35PRRkG3YAsNwax1+3a+aMqYkNTMnR276GGBWYnVOvp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 09:27:36 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:27:36 +0000
Message-ID: <82ff3301-13e1-4ebf-9f74-aa4318848cc5@amd.com>
Date: Mon, 20 Jul 2026 14:57:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf/x86: Do not read fixed counter control register
 if there is none
To: Petr Tesarik <ptesarik@suse.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260717150315.2868314-1-ptesarik@suse.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260717150315.2868314-1-ptesarik@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0340.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adffb14-d678-42c4-373d-08dee641225d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|11063799006|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XSYIpEwfEEJOZbkU8G3aJgRtylVmim4rNcU0gWDjqPM7wzWU1WdGsBoJLYNMGgbZdUMGq34huXGTyRu2c6ALBxT4u6CwryLAGjBg0mWWjk16l+2/YZDPg2GSYNhzNgb56UDs0VXyjuvgM1lxNDnA3O725Qq1IBEXkt/85s26cwBvytt6l5ATbl686BXTIaEP29UFz+eEmjievcqsq5CptgjfXTE/TSkJQpXnLeuMZQYyb8njfLoOYPHFkTvii9cAGPX5yz2fArcFYHy7IjFBmioMKBLDnXY+ULrDN/iTTR1a3fuNb5bvzN6nktr2Q2mIZ/TZnVl490crXdBHP7LWu7BNW3YK25hP5l28mfgTwbwP7UHyeDMZi96JcnIg1pZAalfAdtGgRdKRngTBQnpZPQl28L0Be9t0J2OSaH65pZCei+opUOELR/yNH/Ad0sUfjV0F0xbN/x2lv8pxShd8NCczi1Q1kooRL4OQXIOth/G5v7VxfSxt5KO9yf94+pw1mD4PvO5pbUMkbMGLd1OkK183P5hbmIdS1MMMTDCxDrR2fGr5X7zBtsYbuzvbDGqpax2zEppZyCRkKiHoar6syX/iWW8tioK5bHxautt9vcFBSDRiwaRv4eHAp6j2eHykUWSf9e7+68imHkO1qJMXEKntT7A/wB/fouXp6jEMp1M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUd3R0V1bmpNZUJTNFdONDU4M3NHeXBFNzVDY2xZdkgvRkJLcXlMOXNWSGcr?=
 =?utf-8?B?WG9jSCtxUHVFcE9UbmhhZTVpQjhqNG9xMndoRkN2Y0hTYndQOXlZQnltSW5x?=
 =?utf-8?B?TnhqcGZDaDQ4S2Zmcis5dWJlU0kwNitpc3BUWEl5LzBjamJyN0FkMkptUzhx?=
 =?utf-8?B?UzhJRGRjYXJuU1M2NjZzL252Uk5SSzhtMWlCeW5uRGpWY2RkYWJaWEhJblZ3?=
 =?utf-8?B?d2lhNUFMbXVVblduMFRMMGprL2hodjNXNWEvSmVnQVRrREJsL0Fablg2MWx0?=
 =?utf-8?B?L080VXU1NjFwMmFHMGdRTFlRUmU0ZTMybzdPcUpLaUhPVFlRMXhkaUthcHh5?=
 =?utf-8?B?d2FCN2psTnJtd015V3RMWlVmNGZSUU1sYmpyc1ljNU5EZzBSL1JYczNsUkU5?=
 =?utf-8?B?Y1V2ZExwY0ZNMTQ4RDJyMUJ2VyswNXpzVzR5OUF1dmNLcUhpV0hrSUcwdnNC?=
 =?utf-8?B?NWFOd3VwL3U4WWR4TUlSVHRvUTBQZ2x1bnJzNXN5SnRFRldKNzhhTzlFTTdL?=
 =?utf-8?B?NndtamUxMFYxanpmeG9rdWVzSVR5R2loRU93aUNMN1lKTzZYdUVEaEovbys5?=
 =?utf-8?B?TW1QQnYybU9hM283bmFpUHlRTWk0OEszd2EvWlFEWFBLQ1FUaVBXRGlSdDBm?=
 =?utf-8?B?TEYxWmlPV0M0a0YzckcydXVZN0hGdlBnVktCUnc2RFRVMkxXV2drTC9ndS9j?=
 =?utf-8?B?a1pnUHNqclRwSnlZL21TYmRRT0o0blJFQ2NoL1plU2JzSU9GRTdsUVBDMjhn?=
 =?utf-8?B?L0EzZ09wTERhNzVzWlRHbk8zQTJ0cUk2aThFeDh1aEtTTTh3dUNiVGRiT2Zy?=
 =?utf-8?B?VzMwRDZRVTRKbjVENmJHbGJQSDNmdk0rWkRyRHo1NkI4aytkMGFIb1E2QUFQ?=
 =?utf-8?B?WGgzUDVkNUlrMnNkOXpQMEg1SDRia2RaMlYrZUIwc05LZHdJdm1FRlQ5TTJL?=
 =?utf-8?B?UUdjYnNJTDVIK1dSMmlxd1dMd2tIZkg3NjUwWGxEY3hyUWhMZ1k3ajhCOVRh?=
 =?utf-8?B?a0FJWXQ5SVB1Y0hsMUhlQUQ1dmZXdEtNSmV6VloyaFJxOEsyT3l6NEFZdlJH?=
 =?utf-8?B?SkVSQkh4enJ5OXd2dmF5WkdBVmFOdXlkUno1eWpndjNESW9GNEJHZjBjSWtq?=
 =?utf-8?B?cm5NbHF4NEJ6US8rRnM5NDltdHlaL0lkSHdpOG9sTmhmYjJESVpUQlJTVGxH?=
 =?utf-8?B?Z2d2ZU5Gdy9ha3NXUUMzZTF1cm4wTmZBb1YrbU9vNmFPTitGNGFwemFTU0xy?=
 =?utf-8?B?TmpnRkFBbjQvVjdtT2ZVSkVSUDRQMlRrdHV3OHBPWExtV0VRcjMwRzRiZ1Nz?=
 =?utf-8?B?Rmo4Ni94eFh4UkI1bE41bDhvVTZLMDh0ZUdXZ2RXaFQySGFzRlI4QWs3TEtC?=
 =?utf-8?B?K0UyQkVIUXBBRWZrOTBVQTVWVXhSeVJUcHFBcVVDanZVZUtaNlhraEZqS284?=
 =?utf-8?B?b3ArbWhQQzVCVEJ1VWtHR3VSd1I2MWlOVTFQWW55ZVJkM2ZwdlZrcXFyaDMx?=
 =?utf-8?B?cHBPWUMxcUZ4bHdwR2pYbDhvR2I5bFIxS3gzLzBKWEJLL2tCbFlsRW9NSkIv?=
 =?utf-8?B?ZHR4RGhpT0hwT3N5dHNRaEF2T2pHSmJSUXcrRGdIVGlRbUJTNDRWRU5xc0xw?=
 =?utf-8?B?MWlXWXI5OExPeDY2eFZCeXlRMk56bzZTeU9SdmphYUtxRWprZmpFNEFCYnNs?=
 =?utf-8?B?WTNUWisvTEFYTDFnQmI0Q2pmQ0Y3SmMwWWJvZTBSYjlvaVU0dC9ycktHNVRN?=
 =?utf-8?B?UEtia3l3SXdXc3VLTmQ4RGN1T3NsZXk4VUh0bDlWaDZWSHlHeDI0UDJMSXQr?=
 =?utf-8?B?UjVKODQxLzhyemxQU0ZTVi96b3FOcDhjbnBlWGFnQTR1MTlrM09xRHR5b3Az?=
 =?utf-8?B?RDkyMm9sUVJCMTF4ZzU3eEJ4TnF0UU56N3Y2SGd1Q1Fqc0M2TFpVWEQxamFr?=
 =?utf-8?B?QVRkTW5ucStsdkxHRmp3b09oaWt5cVlGVGx1eERoUXg4RWRKenZXOXByb1pu?=
 =?utf-8?B?elB6c3NoUTNWUFpoSGJFa0phdU1QOTBIV3FEZEY3dXloNXVYV3R2ak1SYVJh?=
 =?utf-8?B?M2VDQktzc29sU2pFOTY0eGJraTd1RGRwZ21iM2I2cDcxY3MrQ0ZTMHJ1dHYz?=
 =?utf-8?B?ZHNkL0pwam4zNFRIcjhXMlp5L0dCSmFDcks4cllVN3RrTGZEa0hnbjJIdFox?=
 =?utf-8?B?NkxmNkdZaUp4SGx1Z0tQdmtremJjKzQ1eStudXNGK2xmZ2tCemgvTlU5QkF5?=
 =?utf-8?B?RkVsQkUrOTFEeUd0YXN3R3RhcU16N1FWM2xMeFg5MGVucTNEUFBaamdMWXFw?=
 =?utf-8?B?QmdKb3hDZSswMTgvZC9oRGpaenRTNnBaNzlNYWlkM2VKcmVhRFdmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adffb14-d678-42c4-373d-08dee641225d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 09:27:35.9372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gX5+qqY9/C8cY0IWz2YSaxwdosb+FM46Hrx7T/8KhJAUpJMpXTBVBJPr87d0JP/i6JiZRMClTVt7g80DXVpE2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177

On 17-07-2026 20:33, Petr Tesarik wrote:
> [You don't often get email from ptesarik@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> When printing out CPU performance registers for debugging, skip
> MSR_ARCH_PERFMON_FIXED_CTR_CTRL if fixed counters are not implemented.
> 
> Since AMD CPUs with PerMonV2 do not implement this register, attempts to
> read it generate a #GP. In particular, SysRq-P logs something like this:
> 
> [   14.748144] [   T1118] sysrq: Show Regs
> [   14.748896] [   T1118] unchecked MSR access error: RDMSR from 0x38d at rIP: 0xffffffff937154c6 (native_read_msr+0x6/0x40)
> [   14.750878] [   T1118] Call Trace:
> [   14.751505] [   T1118]  <TASK>
> [   14.752057] [   T1118]  paravirt_read_msr+0x7/0x10
> [   14.752940] [   T1118]  perf_event_print_debug+0x135/0x240
> [   14.753931] [   T1118]  __handle_sysrq.cold+0x9b/0xde
> [   14.754855] [   T1118]  write_sysrq_trigger+0x59/0x80
> [   14.755779] [   T1118]  proc_reg_write+0x5a/0xb0
> [   14.756631] [   T1118]  vfs_write+0xce/0x430
> [   14.757406] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.758322] [   T1118]  ? security_file_fcntl+0x5f/0x120
> [   14.759083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.759754] [   T1118]  ? __x64_sys_fcntl+0x80/0x110
> [   14.760334] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.761005] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.761676] [   T1118]  ? __ct_user_enter+0x27/0xc0
> [   14.762270] [   T1118]  ksys_write+0x6a/0xe0
> [   14.762776] [   T1118]  do_syscall_64+0xe1/0x610
> [   14.763324] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.763995] [   T1118]  ? __ct_user_enter+0x27/0xc0
> [   14.764564] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.765233] [   T1118]  ? do_syscall_64+0x205/0x610
> [   14.765806] [   T1118]  ? __x64_sys_ioctl+0x97/0xe0
> [   14.766375] [   T1118]  ? __pfx_woken_wake_function+0x10/0x10
> [   14.767048] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.767717] [   T1118]  ? get_close_on_exec+0x34/0x40
> [   14.768311] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.768985] [   T1118]  ? do_fcntl+0x6da/0x8e0
> [   14.769502] [   T1118]  ? do_syscall_64+0x205/0x610
> [   14.770083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.772321] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.773166] [   T1118]  ? tty_read+0x150/0x220
> [   14.773722] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.774423] [   T1118]  ? filp_flush+0x5b/0x80
> [   14.774966] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.775660] [   T1118]  ? filp_close+0x25/0x40
> [   14.776214] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.776936] [   T1118]  ? do_dup2+0xae/0x140
> [   14.777486] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.778309] [   T1118]  ? ksys_dup3+0x67/0xf0
> [   14.778870] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.779600] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.780310] [   T1118]  ? __ct_user_enter+0x27/0xc0
> [   14.780917] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.781613] [   T1118]  ? do_syscall_64+0x205/0x610
> [   14.782215] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.782907] [   T1118]  ? ksys_read+0x6a/0xe0
> [   14.783429] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.784120] [   T1118]  ? __ct_user_enter+0x27/0xc0
> [   14.784741] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.785431] [   T1118]  ? __ct_user_exit+0x15/0xb0
> [   14.786014] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   14.786706] [   T1118]  ? do_syscall_64+0x98/0x610
> [   14.787282] [   T1118]  ? exc_page_fault+0x6d/0x180
> [   14.787873] [   T1118]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   14.788612] [   T1118] RIP: 0033:0x7f70d6497e0a
> [   14.789186] [   T1118] Code: 08 03 00 00 59 5e 48 83 f8 fc 75 1e 83 e2 39 83 fa 08 75 16 e8 05 ff ff ff 0f 1f 80 00 00 00 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
> [   14.791587] [   T1118] RSP: 002b:00007ffc36a93580 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [   14.792617] [   T1118] RAX: ffffffffffffffda RBX: 00007f70d65f6580 RCX: 00007f70d6497e0a
> [   14.793594] [   T1118] RDX: 0000000000000002 RSI: 0000556f34e41c30 RDI: 0000000000000001
> [   14.794574] [   T1118] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> [   14.795563] [   T1118] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> [   14.796537] [   T1118] R13: 0000556f34e41c30 R14: 0000000000000001 R15: 0000000000000000
> [   14.797514] [   T1118]  </TASK>
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/x86/events/core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index d1af33d96d0a3..8310bedfc364f 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1581,13 +1581,16 @@ void perf_event_print_debug(void)
>                 rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
>                 rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
>                 rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);

GLOBAL_{CTRL,STATUS,OVF_CTRL} functionality is also provided via different MSRs
for AMD PMU version 2 and I assume that reading the ones above will also raise
#GPs. If they don't, the reported values will surely be incorrect.

> -               rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> 
>                 pr_info("\n");
>                 pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
>                 pr_info("CPU#%d: status:     %016llx\n", cpu, status);
>                 pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
> -               pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> +
> +               if (x86_pmu.fixedctr) {
> +                       rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
> +                       pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
> +               }
>                 if (pebs_constraints) {
>                         rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
>                         pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
> --
> 2.54.0
> 

