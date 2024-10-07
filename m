Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C015733A;
	Mon,  7 Oct 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728283473; cv=fail; b=tiSiOJmjAQ85IiwYFNlnrz1cAtKgYW4doKbQWttpfMydMbN37hi4aacSvzKZ9QKEOcYYeNF86x+h9Zy3dNQFSn2tlKxWVSyI25Kjq0WXvydoQOy/wHUS6bJflP81DXRxGrCd2TqJjmIRQzkVK0cIRzHeu58VjrBatHe+H5K9Amc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728283473; c=relaxed/simple;
	bh=ZIhKSB2oEi8or/LmlFRFsvoUwBFbidLbXPU4OhJgQA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TI+GHmTsEg7m+t2mTCcrS4qgE27/1N0aV16vunsDCDe3LmBRe1f+2h2XS4R9zcCWat78vndoV0/w/PZiJTtDIPyfx9mxvIaJH2m8R3WsbbeMG6ew9ZRzXbTAxgPbMhF7E0ovxeSTn7yBTFYkeCWGNfxAIH+ksNiYhGCkvxk6ZbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YXrYIFzD; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YXrYIFzD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0JI8a97/hX0eZSSg+0I09fExjct7Me6cZ0BKLyLbt/bDUNLSlVKN9MPtAYRqp5WpgtfAqKAa0juB0jKmWb6R0oXC3zUvDjJtR7DBxEjuguDj44tqd9ZRNRpK/v2uh7W9D12NBIIgIUKBy7OvQGyLeB0+ODIsXtwlQ34Qb85IL1j5LQ0MCrQ2Xc9hNN9R6XEVn2qgdUucARuOLMTitQfMfPSZrnpTUnD4+qAHQ69U5nHI/oZMsZkBfhr1d9rwCpnzPaUPhrart+aJkHMsuZMeNVbhXhomMbq0atv4ww4gf2WQkLSM3rp0WVXXw1Ux3wKURZV74/ggbEC91uM22wPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu/KF+Putcxy6ESMABbNuoqzwCwIYM/X32uIMw3nCZ0=;
 b=ELWiBshFEoGpFFIjS+WqJeD1bRUaktjieqyCO8QbWrDfjhkQbdw4GzFhJGur+s/M5YxiIGNn4+tYFbcBj97DzIRWbsBVGHSmfccGDz95Ygfdnil1LrMuOA73cTnNbW+N7kTCwgA9bHbvthRV8s6V+mq4GD8WiBizTJSY8JL4Og9Los49oxwU8Ly/9C0Epb5bTjXA3JSlkWVLJ6KxJXpW0dXA5Z7yQSNGWFtxNxVALYZ+Sve35t5rruhczUBH2DWTWU0/PvFlxB2WFOUFQsOaUNc2RA1VeoQ7ilE7u1KcRe7jwUlAv/XBURBdPliM9aJQrcdiVk1jOZOdLRzz5v8oCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu/KF+Putcxy6ESMABbNuoqzwCwIYM/X32uIMw3nCZ0=;
 b=YXrYIFzDE6zogC1AZDopgaCWMIwFUzWVa1ir9P8vYpfGnnuNo0F/4qVXD4pbhCrb5C4zCB7VVArTreV55rUSdTNH6enfjcLtmsreWzWaWkN+8xTvpFkVqCMuLqDZPCU/yesYWokaTMiCDz92hK2YsqL7fOAgStnkC6Frh+r34iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 06:44:28 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 06:44:27 +0000
Message-ID: <5837f1b6-b111-4ab5-888a-7a00891f3a34@amd.com>
Date: Mon, 7 Oct 2024 12:13:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v2] perf/x86/amd: check event before enable to
 avoid GPF
To: George Kennedy <george.kennedy@oracle.com>, peterz@infradead.org,
 mingo@redhat.com
Cc: harshit.m.mogalapalli@oracle.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, dongli.zhang@oracle.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <1727725947-18058-1-git-send-email-george.kennedy@oracle.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <1727725947-18058-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F0.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2c) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e785dd-5777-4aef-8aa5-08dce69b71d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGN0NjYzNThVM3p5VFZkOXdzNTUyQ1J2bG5aK1RaREVkelNIQUxiamVRR1gy?=
 =?utf-8?B?ZE5Qb3B4VzA4VnByM29odEZwcFFiQWlYUFFwWm5aYXJqbnBnUjl4d01aZE9a?=
 =?utf-8?B?c3ZyS2Ztbk1lU3dTZndPR3oyWE04eGpBVC9kOURnS09FdDBETEFmK1ZIT3Ey?=
 =?utf-8?B?WWdpNDJmZVluSTlXam9WUmY5TUJ0dXRSZnRTZVNQSjcxTlA2dHFncE1VNEwr?=
 =?utf-8?B?WmttV3R4QURybkNjL3huZncwd0ZJbHN6Q3JjaksyL25Kb3BieS9aajFQeWg5?=
 =?utf-8?B?OFJJa0hiQStzQ3pRZlZUME1QOHlIbnA2cjFwSFRVdVJLbDFJelZycmx3ZFJu?=
 =?utf-8?B?c0VxTUJvc1BUMHNDUlBpeGtuOG9hYmRhZDF3L1pyVHlWdHd2V20xMThrSUc0?=
 =?utf-8?B?ODVMWnNzWEg5cTZlMHd4T29ndUkxTGJaNkZiOGpacStwbUZha0lETDhpM2tt?=
 =?utf-8?B?ODgwaTZ2VW40OFFjeWUxVWc4MWNtWXpacWx1M2U5bzhvK1hMUnlVM1JSQ3hw?=
 =?utf-8?B?Wld1T3dZcnVqMmNmWWpLRjJLcGNjc1NnNE9HeEE4aXN2cloya1ZhR2xkT1Vm?=
 =?utf-8?B?b0JGUDNzWkZZZUhOUGJSb2ZIUmxpWGRpQ2NtdmNTd3plUFJ2VXFPbjdodXNw?=
 =?utf-8?B?ajdQRHlESktOTndtbDFINDc1d2d2RmdGZEUxLzV2Uk1OZlNXYkVEeEZBWFo5?=
 =?utf-8?B?TjhoUDdsSGk5bmNCZU9nVzYwanpMeHNlTDVtSzJmOFZ6aVp2ajB4VUFwbUtN?=
 =?utf-8?B?dzk5SjdlVEpINVJYcVBNTm9GQmpuY0lUYmxDMUF1OWRvVUhoNXZzUVRDRGdR?=
 =?utf-8?B?QWd6K2s1dm02R2VZU1VrNVYwYmdBS09kNDFKeTdoTURoMVJlaVBnNEM3dEZx?=
 =?utf-8?B?SXB2dG94MmR2WjU5MHRGODBqWTZLZ0E0bVlnK2g4STBCajY5UU9Bbnlqbm1h?=
 =?utf-8?B?cElBZnRVcThodGFLNmRYVHNncS9xSUNPc2xDeDBWMGNNSVFXRGF3Q0Zrb0lp?=
 =?utf-8?B?TzJOTERSUUNVTiswUDJhcHdQdmdWTy9Sd01zdzhHekQ5dXRjVGRHZEdIOS9n?=
 =?utf-8?B?UEtFUGNlWURwMk5TdmhLYjZSQ3d2RWV6ZUhPZkZCcEJYQTNZK3daa3FLQjhU?=
 =?utf-8?B?VVkrUW5HVm9TNXBuZWttMDcrQ1QzQXd2aktvbTlWNWw3Ui85cWY0M2dZeldD?=
 =?utf-8?B?UzBuL0w2aXlOOGRIZnRmalJpTkt0c1lwTjJIeDBWV2NHVWRUMU1VdCt2ZVpx?=
 =?utf-8?B?N3VJeE9wbDZKbG5Xc3RXYlo0K0c3K0RFTW1ZOHlHUi9DWlJMQ3VvVys1cTZQ?=
 =?utf-8?B?SWxFT2R0WlU3Ujk5L01zU0lHSFFha0RaNTFDVEY5SnF4ODNzT0JXNll5Mk9z?=
 =?utf-8?B?ZWF1MnhKOUFrOTNQeWRmemVZRHNKSUdOWXYrRkhLbFdFTE9jSEpNcVlkbVRp?=
 =?utf-8?B?SnArYlgxWWpjV3RaOVFSZ2ZBdkswYzVDMW5sNTRMazMrdVpiVU4rZWNqcytS?=
 =?utf-8?B?bEJlOXBNNG9kTEp6eHRHREFpZSt4VTlJdjVQaVpJVkV5TFVEeXNCNVIzTy83?=
 =?utf-8?B?TXBJMTU4OTFYV2VPVHVYZmZxb0c1TUY3OTh5YURYZnhhbXBTMzVIaC9NZmRW?=
 =?utf-8?B?TGxnSWtCYlVkSlB3UkpsTVJBblpZZjBFUlArWkNtTGhOeVdyNGlJUndsdGxS?=
 =?utf-8?B?eGhNZ3dlaWpibitRV0JUalVVc3NVSE15TktyUzVtK1BWS2ZSWGJaNUdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJBZ0Zmb3BzUVdjZmhPVTVySEhrcWg1N1pIQWkzYVAzZWVhV1BJM0lydHBR?=
 =?utf-8?B?ZjdTc2ZLSHovdHlCREhVdzViOGpFRVQ0MVovU1VSYy81RVltdDY5Vk5VY2pq?=
 =?utf-8?B?b2ZKeXB4V0V6OGZyMDRCYXg3UUpObkUyNW9GanZEOXY0WXY5MlQ5MTdoQUxt?=
 =?utf-8?B?dzA3UkZVTWpmWEtpQ3RNWE8yNWpTanl5QXlLeWhUSzN6QlJFZXlySXo1WUpq?=
 =?utf-8?B?bHFaZVJNcFJQajFjdHk1UGlVdmJoUlpkdTlBVUMyaU83WjA4UTFUc3JDRzZ5?=
 =?utf-8?B?OHlzVlliSStPa1pZSWdPeUk4TmJwZU1JalZ6enV5TGNhQ1hSYXlIc3NXMzhK?=
 =?utf-8?B?VVV5YXRTT2Y4VjdkWmwwbEMyU1U4M0NyaUwvOUpOK3VRMFBrNHpUNkx4c1li?=
 =?utf-8?B?TUV0dk1PeEdGd3JyaTBqZ0pPMTZWQ1UwRXF4MkZBUVAwUm5yWTB5WWpoZUZs?=
 =?utf-8?B?c0ZtUk9RR28zZDd2cXZ0OXJVWlFVaFoxSnhoVCtHV3BMa2hOcStSR3BLKy9Y?=
 =?utf-8?B?SDFNQXQwWjlLMFFtL0VtS2puSHdEV2RNdEdLdkNKZmREbkxWTlNEZG5wRHYw?=
 =?utf-8?B?cEFhcS9zaGliRVF6UmhoOHdaUmpYclUwR2xwcXlUY1dlUlNQWC8wNzYxazJr?=
 =?utf-8?B?c0wzMGxGOFB2NGRDc282cWNlR05ZM0oycTBaQnVWR29uY2NkVnpldDZOMEEy?=
 =?utf-8?B?RVRFbHNQcFdYaG1YTlhKVVJyb0ljOEozMVlxaHo2aG5ibjdrL2IvZW9aL203?=
 =?utf-8?B?UWxVTDlsNXlTUTd4WVowbU82ZklvS1BtbGI5UU9admFSWjh4V0FhSDU0TGI2?=
 =?utf-8?B?ZlJud3RSbWIreGFpNDVUZjNDRVRDT29TV3luVFdncjA1TTBGQXl5V0lYeElM?=
 =?utf-8?B?NFBlVEo5a1M1NTRtWkJYV0cxV3hyNzBseE1ja3krS2M2dUl5Z0h6U0RyMjcz?=
 =?utf-8?B?blVUV0FtNGEwanlKbHgwcm1BYlpxM3JoUjhlNnlOaWk4QVJGem1COEdGTnVB?=
 =?utf-8?B?RmtYdlg3NXdtOStGSFZpTDh1Y0tzbHdWVS9USU1MdFZUOWFCNzF4QnEwZGV3?=
 =?utf-8?B?TmF4MGpwTWhWUFZVaFBlVGxERy9sMjBQTDJmZ1RjVWc1VjFWa0lNNUVkdFh0?=
 =?utf-8?B?NldkWUtOcjBvZzVZL09lOFlVcjVrb0RhMW9Ha1lEbGZtRUNjRDVUREhyNnpB?=
 =?utf-8?B?b0RhUUtod0dWZkY3OTJubGVaVHJRWUxaUmNKeXE1V3FZNnFPWkwrT3pYZGkr?=
 =?utf-8?B?YjViMjBsYTVBSWh3TGRrVG0wQkdFUm5WYzlrdGlQM244SkFPT1k3QXNEcUlY?=
 =?utf-8?B?eXE5ZGFpR2pjMDFVaGhrV0JVOVNTZTRhdEsrK3AvQitHbjl1Z21NS2ZyR29Y?=
 =?utf-8?B?a2xDSEU1QjZKVHpQdE9MemVwQm1LRUNzZmdTQjRrU0ZPb0NieHY0aW5JYXBr?=
 =?utf-8?B?dGdhK3NyQWwyY0d3clUyNEZUVEZmY05pWE5zejU4ZklBcFYrR2s0UDhNL0lM?=
 =?utf-8?B?MWI4azI0akJ3Q212MCt0bFdTQWp4RFpCcDd2RWFhZ3VqbXp4MnNWT1c5OGlD?=
 =?utf-8?B?TWZ5elp4aDdHU2ZQdldmaFpCcnBGSEpHNkY3aDExRmMrU2pKQTErbWI3dmVX?=
 =?utf-8?B?L2xQMWZPZ2d3NkQyNjBnczdRTTUweUxBWlRCcXBqdEhVTWEwR09BS0NMeFlT?=
 =?utf-8?B?ZE1lRGd1WGFaS1JoMklINERyb09HTWt1T2dvdkRDWmdoVGQ1QXdnV2gzdi82?=
 =?utf-8?B?Qmg1eWxXWG1LTkZLYnNMbkFLUGh5aHNRWXg0dFdhUUVzNk5GWkRpNHlsaTEr?=
 =?utf-8?B?S1FpcjRpaUdQR2JVRk5MbXRiUU5IL2JaZCtvUzB5VE9wQ2U0Y1I4VGVFcjRY?=
 =?utf-8?B?M1NaRmxYWlRYZ2lURUM1VGZHNXlFSkJ3MFJzemVjZmxUUjYyY3Zia0daNWRh?=
 =?utf-8?B?Z1Yza2NzZkY1ZG5VYk1xRkxLc3oyakkya3hiVGQxYzA1WUptTE1oUGJic0tS?=
 =?utf-8?B?dDdkaEJMaEppTTFHNHAyL3NueFFBWmQrRFgzbjFCZGZSRGk0dEV5SndVdFlO?=
 =?utf-8?B?ZitjYWhjTkV2dlBWQlRnYVpSOW5ENU5qd3pVZWduYnFjRDl0WStYNWZFVGRl?=
 =?utf-8?Q?XusxpIAZIdJ1w4mv0Q193afY2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e785dd-5777-4aef-8aa5-08dce69b71d0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 06:44:27.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB3Bl3ysWSErc8j8s7NemOQd7efy9q4c1Z5b++/b+HLoivhp9auTWpari2GyhNgNVpndhIsd8jJzM0J6BZsnyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

On 01-Oct-24 1:22 AM, George Kennedy wrote:
> On AMD machines cpuc->events[idx] can become NULL in a subtle race
> condition with NMI->throttle->x86_pmu_stop().
> 
> Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
> This appears to be an AMD only issue.
> 
> Syzkaller reported a GPF in amd_pmu_enable_all.
> 
> INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.143
>     msecs
> Oops: general protection fault, probably for non-canonical address
>     0xdffffc0000000034: 0000  PREEMPT SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7]
> CPU: 0 UID: 0 PID: 328415 Comm: repro_36674776 Not tainted 6.12.0-rc1-syzk
> RIP: 0010:x86_pmu_enable_event (arch/x86/events/perf_event.h:1195
>     arch/x86/events/core.c:1430)
> RSP: 0018:ffff888118009d60 EFLAGS: 00010012
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000034 RSI: 0000000000000000 RDI: 00000000000001a0
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
> R13: ffff88811802a440 R14: ffff88811802a240 R15: ffff8881132d8601
> FS:  00007f097dfaa700(0000) GS:ffff888118000000(0000) GS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200001c0 CR3: 0000000103d56000 CR4: 00000000000006f0
> Call Trace:
>  <IRQ>
> amd_pmu_enable_all (arch/x86/events/amd/core.c:760 (discriminator 2))
> x86_pmu_enable (arch/x86/events/core.c:1360)
> event_sched_out (kernel/events/core.c:1191 kernel/events/core.c:1186
>     kernel/events/core.c:2346)
> __perf_remove_from_context (kernel/events/core.c:2435)
> event_function (kernel/events/core.c:259)
> remote_function (kernel/events/core.c:92 (discriminator 1)
>     kernel/events/core.c:72 (discriminator 1))
> __flush_smp_call_function_queue (./arch/x86/include/asm/jump_label.h:27
>     ./include/linux/jump_label.h:207 ./include/trace/events/csd.h:64
>     kernel/smp.c:135 kernel/smp.c:540)
> __sysvec_call_function_single (./arch/x86/include/asm/jump_label.h:27
>     ./include/linux/jump_label.h:207
>     ./arch/x86/include/asm/trace/irq_vectors.h:99 arch/x86/kernel/smp.c:272)
> sysvec_call_function_single (arch/x86/kernel/smp.c:266 (discriminator 47)
>     arch/x86/kernel/smp.c:266 (discriminator 47))
>  </IRQ>
> 
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

Peter, Ingo,

I've been blocking this for quite some time without acting on it. Since
the patch is trivial and harmless, I'm giving an Ack here. However, the
underlying race condition is still unknown, so I will get back to it.

Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>

> ---
> Ravi requested patch resend with the following:
>   /*
>    * FIXME: cpuc->events[idx] can become NULL in a subtle race
>    * condition with NMI->throttle->x86_pmu_stop().
>    */

George, the comment should be inside the code.

> 
>  arch/x86/events/amd/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 920e3a640cad..3a8b8db878f6 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -762,7 +762,8 @@ static void amd_pmu_enable_all(int added)
>  		if (!test_bit(idx, cpuc->active_mask))
>  			continue;
>  
> -		amd_pmu_enable_event(cpuc->events[idx]);
> +		if (cpuc->events[idx])
> +			amd_pmu_enable_event(cpuc->events[idx]);
>  	}
>  }
>  

Thanks,
Ravi
