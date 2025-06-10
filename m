Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8C27A934;
	Tue, 10 Jun 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749545981; cv=fail; b=O9xBjauxwWEwv6rXU/LmGA4LOASMIOc8I1TSUyrbKodmSYh4Fba0sk3csqkAcchgqn+1mIZBFXzRpWy4HQJIbFkemtVyLBjgnJANAzQvbpMr4KFitOnGcYiKt7cabSKVhqILtr3GI+t6UfKss4ucoFhoPPleV6EMxILnvML2Eu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749545981; c=relaxed/simple;
	bh=XKtXFpxHqe1LxDp04gRLEW0GumXgJanyn9VMUutGd6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T4Pg883gA01aPpJUggz8DuwZ2QXWyFcMv7irYyfui3b2cm9KzoeFLshCuVSk+AxqShnup4k1/2U5j9NKsXGiF68/Qoy2qLEKkLzLEBckEFNQsW31qlRaqr+kM6qAMxO3mG1gzlvWl9ZLlleGJmAUKxy+M7bDjCr23j/KXGUGIM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QtBQKMYh; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QtBQKMYh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM6Y1YGR8souatk+xsjGVkYED50PLy99dpfE+fU8Yo7YChyzbLPLaEv7zZZHIv0OuI3qEpmQQYUUXb/xXJarZpqbzPvMvyy6731VD3B54MT6+83vmyEisfxYONv3bqtEVkkmdJcfvGNXOlXC9PGGtnxUcLPLAczrWhiYAt/uvyp2iYPyJ0OM8Qj39M+976qZKnlxfjM9G4tp1/kGg+nRj40Gp19JUYc5wA0VXHzV6jrBWhPwy1AsluO0/zfqJsIKsC15e8nlBRt9Kdp5NtsPIDdKbz7WnfQ8SF/obmcVG4SWiP3RViW3d0h7x/NBo9Bwcco0XNNKnjONHpFvkM50TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlMUPmixtDoPf6g4JGrsvQPZvJwPJpHWgwNxXj6KTwU=;
 b=evCeihLhFdtn0nCz7w4OYU9M409FhoTjGhbfJxICVns96ufQwsWFPHSYMGXhEW10A5dSmUq3n9AerLvXTRK1iogFFcyHGMtINQ4CQS4/i139tCZual8W2rjlWtaJihY4c1Et2kSBa57IWAD6Hr4sqKRhxp6BoGmnR/JIg/pz2VLP5PClMntCIQEruzIUckL5Ph8AJ8Tl43P8oWLlG7hE+CTHO8xc5fcuQyidmk7/xEbYfuiY8UwepdtrUOI19+DjBYN0FCQRVmg2LWkRjyH+KRfV+QtU+cZpkIFzcVszIl2kBEXe/GHgq1MzhBDCPtit5UGoccTbPi9lhfBAIZ8JHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlMUPmixtDoPf6g4JGrsvQPZvJwPJpHWgwNxXj6KTwU=;
 b=QtBQKMYhdikjNKpd8SKEPhU2J2i6/2o2eu3pFHTykRneBJAm0Sm+SOkdqI6/X2QoTfup7iKMrFMNjU71ERLPu9A2AK+TW6At4ksRF95AF15Fa/7Ty6uquCrHaEK7OrhHTrPHNXn8dq+KfZBTYUL5Ku+vcGhZ6vKP7uq6QWzZaY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 08:59:37 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 08:59:30 +0000
Message-ID: <a0e0bdbf-c8a1-48af-9287-9de023adc065@amd.com>
Date: Tue, 10 Jun 2025 14:29:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
To: Steven Rostedt <rostedt@goodmis.org>, Matthew Wilcox <willy@infradead.org>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 david@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org
References: <20250609170806.447302-2-shivankg@amd.com>
 <aEc0MNj9JNXbLHmw@casper.infradead.org>
 <E40B36E2-1D0E-4769-B155-0175A06DE3AB@goodmis.org>
 <aEc7JG-OL2fp075j@casper.infradead.org>
 <20250609161454.27122eb4@gandalf.local.home>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250609161454.27122eb4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0081.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::15) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 64db4f01-091f-4841-b7d5-08dda7fd1c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0xZLzJ0QnlxSFNaYStnYzc4eWFSNyticVBaR3h1d0UyRGlLTUFDWlJHQkl0?=
 =?utf-8?B?UnZ0enRHN0QzYUJWNmdmS1d6eTlBdGZ6Z0hSTlJoV0Z6Z2lFTUc2ekNSMHA0?=
 =?utf-8?B?a291bFgycHpIVWYyZkhGNVIyL0wxM0xtVVJVeE9xMFpSUFJ1ZGxvQmcwbjBL?=
 =?utf-8?B?YUQ2aGt1OThUM0JJcDBXMkg4b2wvcE8yNis1RGp0SlJveUM4d2wxMlMraWZy?=
 =?utf-8?B?Skl4UGNrK0M2KzNETitaUzh6VURxVXUwMGRjaStHQkEwV1RDR1hmWUwyb1Na?=
 =?utf-8?B?NkdPTzRnR01QWTRpUDROaUdEaG1YWFpZTUgvKzgzVmcvL0xpRnNQaFNJcE9i?=
 =?utf-8?B?aWlPRXVhRjRhSm9NUjM1djdOcHNwQTdhMnlIVUl6cGFPZU5hUzZNTEszRHF3?=
 =?utf-8?B?R2l5KyszcU5oMFNYSjUvblZrK09NclF0dndDdlFvWjhZQ3l6Tzd3aW14Nkls?=
 =?utf-8?B?YjRLRmI0SjZ4KzV5NGd5WGIyT0lEdXdKVGN4ekRRcmZxZ0Q1OHF3eDF5UTA4?=
 =?utf-8?B?R2ZNbG5XT2JyMEZ4RElMZGFmV1hodysyUVJyeE0wNVR2d0k5NUtDcmpabWZk?=
 =?utf-8?B?TkdTYS9mWlpoeFN5WUdvZ2dEYk0xM0pjYktkWUZIS2M0enRIUzZPUzVKQUtW?=
 =?utf-8?B?ZmpwSEhWMS9HSnB0ZDZVSlcrbWtqcFVCOFlDa0kzcDVDaWxneG5XUGRIdVRB?=
 =?utf-8?B?U0Y2bTdWNnZYdE5QbGZVQVl5U3p6ZktMa09NcGRkSzRRRW1UY0pMTGd4VHYy?=
 =?utf-8?B?dFR4Szg5Sk1LTXBLVDRza3hPM2NsYlMyNlQvdXM3Y1NHbnpiYWNJSjc0bW8v?=
 =?utf-8?B?T3VEbFdjQXEzbUQ1Vm9WcjNHQUU2aVROV1hobVJsOWZvaTdUSU1TcTFmT2ZY?=
 =?utf-8?B?NmpsTHJPMTdONnZDcjY0SnNhMFZhNUhQcllKYWh1YTFHMVZPcG81RjlJd0p6?=
 =?utf-8?B?dEpPM21OMXJweFB5UWpaNjVHZkJqcTJZcnBLNEs0U01FaE9EeFh2aFJUcmNm?=
 =?utf-8?B?aHcyWkVUVVBBWVEwOU43dkhrWS9oTGtjZG1mUjY4eHp0WmNmUXRTa3c2bXZR?=
 =?utf-8?B?Q1l2K0pEQTVvSjBwbDBqNUZTbzllYTVkNjVpeWl0TTdiNDJhbmV6MzdDOHl0?=
 =?utf-8?B?UzlvQTc4Qi9SZi90NXJROGJDZUo3dVlWaUR6TjJxUkw2dDBtWlMvTnduMWFh?=
 =?utf-8?B?VmhYWnhKV1Z6N1FsNXRpTFNrNTduaXdoZXBqcysrc0R3Qjdrc1hCc2N4bklS?=
 =?utf-8?B?eFhDa1k3L2ZXTnRkSHIzUW9Dam1rYXdNaUVKYkdKM0swV1hEcGdkOGY5Vkpj?=
 =?utf-8?B?MjR4U0xkWUZwdm1hUit6N2l6L25iV0JmbUpwdHp2SUc3dXZ4eWRUSWFGSERG?=
 =?utf-8?B?MmhMKzBENDcrM0gvVlZpZW0yZ1RmUGREcnQ1T2QyYnNhMFNCaGZLOHFWazJB?=
 =?utf-8?B?dVNZSHg4OE9tcC9qRkswVkM2eDBIR0J1UkdUSnlMeEgwblNzb1lQTTh4ZDgx?=
 =?utf-8?B?d2hqWDg5WUF4WlVmcVkvM1U5QVlOYS9xZlY2bGNZeE12bm9iOWNRSFpVYjBz?=
 =?utf-8?B?d25OcGZRNitHaXhpTHg2aCtYUUJadjZPMG14SWxWaE9oRFRHaHp2aXR1ejlI?=
 =?utf-8?B?d1FRam8vUXpoQWhidzg2MmRBNytwNE5tWVZqcVpodnBlUjhGUXd1UFNVNE5U?=
 =?utf-8?B?VzJzMlNSTndRUWp0WHEzRGUwaUVjTVhCN052WWFUNU4zMUdwblJvbm9YUTV5?=
 =?utf-8?B?eStFRzJuN3B3c2lQUUpxbWJQZWxTM01uaCtwQTJjSlZuUjRna2Y5bHgyeGVo?=
 =?utf-8?B?dU93UHFwZ2N2TmRIdWhESGQvUE5ua1lpL3dMdFNCNkVjdnZjZHRrS08ybXVV?=
 =?utf-8?B?T3hSK2tnOGJiZDNZNjVZYTdTWHpvTGhEVVRJdjdSYTROUGU5QmR5UmdoU09L?=
 =?utf-8?Q?723uRxr50tQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tUQXJaNC9CMmVRUEwxVzhGU0hsMThJREFLTnd3LzRLSFdEd25lVTNlTDJV?=
 =?utf-8?B?YVlNOTBYaUgyNGl1cGdmclQ3YUJlcjhWZkRqY2owbEVFamgzTmNZOXVMS21H?=
 =?utf-8?B?dnZTTHB1bXlRNVJMcHlmNWE5TDJrNEh6QlhrcFJ3eVI2TzlpTlNWTHVTSlRz?=
 =?utf-8?B?UTQzaUxWKzcyUlhYMGRZYzBXZmxxblVaNi9BVjIwelhDb3VrVy96UTdLMzJx?=
 =?utf-8?B?VkpOS2hqaytZZzBRbXkwc2xrbEpIVXBvemU4cjJkWEVnaS9lYStkZHFlTGFq?=
 =?utf-8?B?QnhNb2RGN3g3OUVrQWxCa05GbFo3bllSZ1ExWklkNGptTkVRWWR3QjdyT3Nz?=
 =?utf-8?B?aWM2QjF0RTdJVURVajBCWXUwSm1jSVV2WmRPeXBNMnZUT2FpaTFQcUxlUjZR?=
 =?utf-8?B?T25WTGNzWjBxSExGcTVmL29VdVhuQlh3dkovUTFZYlhlUXhEYXRTaGhNckwx?=
 =?utf-8?B?UndMMkJFeWpNN1pNMC9VTFNndUJyWCttcTN5ZjVVZXlwRllYWHlOcnZPYU1F?=
 =?utf-8?B?STdBWGZacnJHY2E1OHVKc2FPbmFRUTRPWXZ1Nm9pdkN5MVZLdnVCWjZRY1hY?=
 =?utf-8?B?SzQ2YmIxc0hJMUZXY0JkVnJOS3RiemNmL3lOWWlSQVQweU54WGxnZHg0QU5x?=
 =?utf-8?B?VCszNjlCL29JQzc2OTNqUTMxWFROV3dIbVZSWkl2R25obHVMMmNyVmZ0bWFL?=
 =?utf-8?B?S0M2R00xZnlUWVA1aExzRDg4TGVTcGZ6Q3pJSis2S280Z1lYRnJWMFowTWF6?=
 =?utf-8?B?dUFXd00vWEhNTTZDZlFqTHlPd1FWQmNqc2lYRVAxaUZkQU16TkQ1QWx2cjZ0?=
 =?utf-8?B?ZGtlcTYxWnNINS9IVmp6TUFyZm9nVXNwOGRtODV4cnVIK1pTVlRaNEJlbXE3?=
 =?utf-8?B?UHErVEk4VkhxQWl4QlFJWjRnMitKdDhuWlVtM2U2NGVVZnVjUFo2M3h3dEoz?=
 =?utf-8?B?SWNzWk5xc1FUckxaNG9VQjJaOWN1VUxyR1FVcW1Uc09iam9pOHN2UVFaT1k1?=
 =?utf-8?B?RERBS1JBWFh6RzRNdFVpZE1nODgvS2V5aDRzYUJjU0FyT3ZRaENmdWxvL1pN?=
 =?utf-8?B?UjdOdnZKZFVKZXhCVkVvRkpoS0loU2dpeFRKWUdPc29xSk5Ib01ZeTFtSmkx?=
 =?utf-8?B?cUxETmNUOFNNUjBERG8zNFZPZHJIUGJBUFlqMGFQRjlQZmdtbkVoYy85VzF0?=
 =?utf-8?B?VTVpeFR2NWRIU3FGaTBJTW5wcmtGM3Z1NUZXWlJlSFJBR3VyazVkUk9rZ0ZL?=
 =?utf-8?B?TUNqcTNHaXRrUS9sdnIyNTRhVEVMZHhNdW1scFhvVVJXa3RCK09MZmF3cG5H?=
 =?utf-8?B?bXMzUFdjZnZMc2pvRkZQVTF0OWVlTlVlMG1POEhlc3lDcnpQcnpZN0p2dGZu?=
 =?utf-8?B?ZEQ3TmNTZ2ZLazhHUVNHcjFIWFUxdDJMb1Q4amtLYXg4M0crUlZxNHlMSFg5?=
 =?utf-8?B?Z0x1SFFCNjNUWDhaRllMeDBiekxQNGJNNGZwQzRTMTUxSzhJREpLdDFHQngv?=
 =?utf-8?B?VVM1NG14blhibzluY0NRTGFYS0JONE9QQjM2dDJUTlFZRE1VTzQrRXRkNWQ1?=
 =?utf-8?B?N2RoSUFhMkxNZUtuTkxpK1hnM3lqdlZoL3dOYWk2NzEvVkZhMElnM3dmeHZB?=
 =?utf-8?B?T2doQ0VDbzFSRGVjbldoeTQyVFRUMyt4U2dWaUxqRjlSbkUwdURVNXdqY0tY?=
 =?utf-8?B?VmpJK2F4ZU9Jd00reXB2ck91NmNUdlVOSW9sTCtpVHZRZWRFc1cxWjBzNGM3?=
 =?utf-8?B?bWo3L25ybFQzY1ErYjlQbGQ1MUdqSWtscjFteGkwT05UL29yTThZS1hrazdq?=
 =?utf-8?B?RGNsNEloWThadG9LNEswSDk1dVJFR2JEK3Y2YlVYRU43dHpZeGtrLzhWdFZ4?=
 =?utf-8?B?cjlyZ2c5eXpFLytWb014SnBIR202MDhoQ2NmREVvcmduRzI4SDBGLzk4cGp0?=
 =?utf-8?B?SGZIeGQrRWE1R3BBNkdScW1yMVJnWC80WHE5c0d3dzNzQnpCMzRtdFVIbzd3?=
 =?utf-8?B?cXRJL0s5MG9LK2Fpcm81SmV3Nnh3Q1Z3YXdvclJtZnpsYlZtS0o4TldnQ0xh?=
 =?utf-8?B?ZmlvaWZHTkpoMzF2QWYrMXR0Ymt1Tkl1VWdycXc3VE1uZzN4b25ZdkxKMzZM?=
 =?utf-8?Q?JAoM71RmqNHk/q9AnfUfb1PXB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64db4f01-091f-4841-b7d5-08dda7fd1c25
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:59:30.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap9tjYeo3vNpHh/h6ZGF+qy6s3Z8vtYCVHxC9gSeQM2H1YPgftrWZxZaAve0O0RdHKEYzwsBFeW732hSRgEKfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911



On 6/10/2025 1:44 AM, Steven Rostedt wrote:
> On Mon, 9 Jun 2025 20:51:00 +0100
> Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Mon, Jun 09, 2025 at 03:31:40PM -0400, Steven Rostedt wrote:
>>>
>>>
>>> On June 9, 2025 3:21:20 PM EDT, Matthew Wilcox <willy@infradead.org> wrote:  
>>>> On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:  
>>>>> Replace open-coded folio reference count calculations with the
>>>>> folio_expected_ref_count() helper to improve code maintainability
>>>>> and reduce duplication.  
>>>>
>>>> If it needs this much additional commentary, perhaps it's not actually
>>>> clearer?  
>>>
>>> I don't know. I tend to over explain as I rather make it totally
>>> obvious what is happening. I wouldn't say excessive commentary is
>>> necessarily a sign that it's not clearer.  
>>
>> That was a Socratic question, not for you to answer.
>>
>> My opinion is that the extra commentary is obfuscatory and should be
>> removed.
> 
> 
> Ah, sorry, your response wasn't clear ;-)

Thank you Willy, Steve for the discussion.
Fair point about extra comments, I'll remove them.

Thanks,
Shivank
