Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021099.outbound.protection.outlook.com [52.101.57.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38070198E99;
	Thu,  7 Nov 2024 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023756; cv=fail; b=D17h6QqzO8M5ZEi4NccRVemIrCzWqNnruUkxzhuA+yxO24AG8B41/bakeKxXSJLMXPMmjrTq8SllNfqJbValI2jLH/Ih9/yEdtGZapZyaaPZkVp4TbLPBPWyB993EjdqxuWOWkneFU0b8Ofwh0YnHe4kByxpPK+MdIEPsCRcXjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023756; c=relaxed/simple;
	bh=0T/nfq0qdUwSwJo2ohISDLHXGdfupUBEktlpNtVgsKA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=FH7rOuCPoWHp596smUCAV3vd4lHe4cgjOkEMjWZDRSKU9NpnSvrVzz7sOWJWSVera/VeAmcEauCAye0XOag33ISLQbj0wJ2PVTsBh4emXP7XxdE3K0L6qXarw7OKH+g/GjspzFnq+MVeXD1yKjmFelFoLeJ32hEw0V36fPLtV/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QE9nZO8Z; arc=fail smtp.client-ip=52.101.57.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QE9nZO8Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHa4za142d0xhMHUnDUdh62lmK/YIYjRKJsWpKgfNkjQP+AaWftshI2FDW/3O4BmdXaosTlk82xurwxcnpZCl4675AEH84O0swhWm5iMYsO2PhjF1fZQORcnY1TM5BRBL4l/pQJffusp4LLw5eH/3HUObznAbNR1ZUkHJ4zmqk6PozCi2h8xj9r9pj3cye/Wlj3g00tq8zbu3AMi8WqCC2oEE22NUSF5SBRBSs+QyoobSY1hWZZOMXtUxLGyt3Tznu8jihIxvwnbGXHpsbDP+9EtsV+mvcuaJHr1eLNTItFnAbbFdAG4rV3I9WYm/u2ow67TMZthnr/tycz/+OcbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO/tAEwPHNgBzbme1z12/z6dJ5Y3m0DsFoAEqoLjS2Y=;
 b=ctXd4rzh4ei3gpTY5A1DDAc2/VKE09i9irKzdl0wX4eQHDqDcpDAPASgf9jTHt5vU14CFOiG29TGpin+TNBA0WrsX1xYEDHXgrG9ngAUdLJR0B64fF30YjVLfDq8Z2E2mVywILsSGuk5wGVELfQyqL3BovKa3xDgQI87HskrrMLQX48aLft8B5G23I7VqO100gpcPpb7W68FnF8tk4f2ckbhqSNVaxvnQVpFN4P2znA16rnT33ALzZRM9kfs3JuGli/jACDACGm8LXGUlK0AuisPEHjy93voaZoZD/fYWoQJKf1r68ui0rWuLqSmjvdSpBANQJAX0SGI+06j/+9N6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO/tAEwPHNgBzbme1z12/z6dJ5Y3m0DsFoAEqoLjS2Y=;
 b=QE9nZO8Z8oZMdRRsBmUO9lHOG4Q0p//ZUgJyO79M1jm/YlqaZl3OP2vsGtivzNJMwh9UZz0/HnHLW06R/e5eYnSTAt2sEic9QJWyW694AyAwqiqbgFH9HiUzOUcKpp72hAFEjwrX6IpQtb2TyG0nd1G+DxrxFCBa9Allw6WIL9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 DS1PR01MB8720.prod.exchangelabs.com (2603:10b6:8:216::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Thu, 7 Nov 2024 23:55:49 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 23:55:48 +0000
Date: Thu, 7 Nov 2024 15:55:41 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Leo Yan <leo.yan@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
    James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
    Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Graham Woodward <graham.woodward@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf arm-spe: Prepare for adding data source
 packet implementations for other cores
In-Reply-To: <20241107152542.GC47850@e132581.arm.com>
Message-ID: <1c7db0d2-d08c-2d9-2976-30d1e9d8f2f4@os.amperecomputing.com>
References: <20241106193740.6159-1-ilkka@os.amperecomputing.com> <20241106193740.6159-2-ilkka@os.amperecomputing.com> <20241107152542.GC47850@e132581.arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:610:53::24) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|DS1PR01MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 921bcad2-f559-4cae-4bb8-08dcff87b3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NjlNR5X7Zf2OtLi/EB6vcvZzjxwhCHtGGYuxrxqP1wpFbF54d2R5sWtxFgs7?=
 =?us-ascii?Q?+Vtpu5BnbRzefpFqOB4Du51nb+gNu4BRSAEEpHZs7vddPYX5sUxO5b4/kdFZ?=
 =?us-ascii?Q?rbqwwyMaivqSGn2WQsQ5fy3bpQEzO/BhvhHmRq97gWsewf4XepFAW8G24zMg?=
 =?us-ascii?Q?RlUYOB34/8hD3Ubjcx0lFoXaYwuwMXbaHs47BovYbZ09LWCaoNxPu5iDZ0Om?=
 =?us-ascii?Q?Gtxsj9lDRP+lz9HFre2AD9DoxdNHjWikyWwlJH5FTHwviazGvEmc0BmXsEJx?=
 =?us-ascii?Q?kjX/dXBeBKzkrJizXEnhTZcnJYcWqIV+/+sbnyABTB8ZzsI1N+J9frVUsjmP?=
 =?us-ascii?Q?wsK3savOi7nD6TNya/DJH3vm/PpeCfxuQfMjwrabJkSSZczkTBvHTyDsHo0y?=
 =?us-ascii?Q?Ddqcy2yQ9khPV64s9UsAWjl5JTK4uoiDyl5vPTTYJgouwWCYnIbbIWZ6MVWF?=
 =?us-ascii?Q?8J2yJwip00rzA1SzbyTqKY4mVi8Qz1QyA5d5NO1wkyXlUIARiMYCd/ENnxq4?=
 =?us-ascii?Q?2sxTZsyt15mhnOwYRamtp2M+NBli4uNjPeKNzTTwTJWe/KXgPVYLcSL3Wi9u?=
 =?us-ascii?Q?335aOCEedY5xmK70Hu2LNbNCgOV2Zu3TZceuCSBMW1++bRMQEUOG8aeCzUNv?=
 =?us-ascii?Q?4crCjYNdexvDVBuDXAYEjST4ELOtj+nn/Uj4bPvhrYJm/nP1Cx/PSt5hTXTv?=
 =?us-ascii?Q?Jzw29Sev9TAFT6fd2VhTdUpW9za5XNIPeIZ0Kul6hiQ8UNjHMEG7c7Nivpvd?=
 =?us-ascii?Q?oe62vGYIAjMkpBIVpbgKqHtxHvv1aAcEjaajCtjduXHFpB03I0Yk4cDehVY5?=
 =?us-ascii?Q?Q7/yjWUlP2W0vlUIX5Uvac4M3HljNqM7QaBS6k2krBwk2EeoSnqEeUDr7aO9?=
 =?us-ascii?Q?ib7p9wlSKnuBXJEf1k5Fg/RW23DZIMeqPQVeqnUYOYTA79JJ9Gensb69pY/P?=
 =?us-ascii?Q?3xIfQjqTUuWEUCtSBbd7oYbUGI7SjZrSPwzZDbETpCJKtcHQDZh6dUUT9SgJ?=
 =?us-ascii?Q?aJ+HAV0Yu0TMFQtLo8A2xIul24MmeXHHqhJSXkdzNZzWOHmWAnU8VkNk8nF+?=
 =?us-ascii?Q?AN5B5qLK8ao/ehrhNj9KNs0nbi3HyG82gYfdDAKn0AE5Thj98a0riJrjTtW6?=
 =?us-ascii?Q?sCPIHKj9iZZnR3FPcOhycimCNvc52G1hCC+ovSqMQs8x+z7Jg8wxYhQ2yjUK?=
 =?us-ascii?Q?qbSG3/edSaj7hs2xRUMFTYxhnS+5i9SIcKfF4BHednn2zHPviCJSQ6d1Aa3Y?=
 =?us-ascii?Q?ymSS1ssDG1PzIGmNsoh4VQIgPbuAg59LF6a1sS0QieIpXEz56CiLPufv4OCd?=
 =?us-ascii?Q?Q0kt+rjk9Pa0fKNynLoER9pBSRLIIYo1zYoP4g9n84NVH+bvwKFzS0Fte2jo?=
 =?us-ascii?Q?W/Zxo9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s9ha0qOCg0TCir859gpnRT7f6zGlucWSImsGIgTWOi3V44aBYNZkMa3dufv9?=
 =?us-ascii?Q?DWaCd9jNek6Tmy2i8CQpT3c5DUtM05HF8bedu+mmVkTrZM3HNTX2Mwm7xiMv?=
 =?us-ascii?Q?qq3nBiN7Gw3Mpe2r9PUAmnkTRQrmhTzhzc7KBBOl1s0wE2BGFrqjEEcLBL/s?=
 =?us-ascii?Q?VT/5iwO7/OzR370t6j2oPJpXsOXK/jkYSqEk0rDNdDOtNU0fdljG2RtJZYgH?=
 =?us-ascii?Q?KyHpIdMjkzLOOFL/AnielmYX91k6kyVNk68orNQqngdex0pvU1ScUBoNekCy?=
 =?us-ascii?Q?HVadMzopcDvixXt+lv/qLsXt5mPASsKupZ9iJfkUUEWLyNONW5T03vSE7IoJ?=
 =?us-ascii?Q?XZldet5ihkImcOet5303Xl0ABink2uuLmrpVtcK+TROU1NrHPItLERL/R8qz?=
 =?us-ascii?Q?/DvEmFQgipqNlk6mqbLjukAKgq2a/IYi4Txjsll4VDKpzEh5rRuiabk9EnFY?=
 =?us-ascii?Q?dWKBNpgK5Fl2/3PZfup14UP4tnjqcRvyiJjxc2teIg+Ormx4+YBTTJ4BvPfZ?=
 =?us-ascii?Q?WZXrZEcpYnonhydB+VOlj0A+dsF/tDpQ/VYiFakCeKIt2QojiCCacIr91Iur?=
 =?us-ascii?Q?II3ZWTXG9P1gOjYnXoOBkn/iuzH7Dm5mYaM4mRKuckNki+vLtrKjzzzmJYzP?=
 =?us-ascii?Q?YSGq6uHOdyVQMxKBii+hSUXZ1YbYH8Jd2K9Nr9BK+x0l73/zxIhTNCDGTAGe?=
 =?us-ascii?Q?WYRsz9U8gv0ry1i5WxY9RL6SweSz3X2q4NINr37+qcYV8MUsbabIFDVUBRss?=
 =?us-ascii?Q?uQnCHbi2OlwIMkDKOxjtYeH8dLxbGSgAQdGXs80lFjQSMlhSN4vGiepWjTUy?=
 =?us-ascii?Q?59DoXvg0gOOm2hhkO+q0QzYeLEzrXr+4GgH6sAusJNtJsCom6BEAKtZxX1vX?=
 =?us-ascii?Q?Mpgn6mG0CK0H217Ho5So+qeOhhagwXSd9yxjowM9VU4NjtD8PgkN09tOAz+S?=
 =?us-ascii?Q?eJ2/NkCrExkDVi7zWSwStw/g/F5oCo6iyD9pqcSadFR9DvIRpJJsmdOzhQ7Q?=
 =?us-ascii?Q?Qq6xUAFw0Iog0m7KdY5qoxAPSvDxmCl4zje5pFS/iReFHqblH7JCXgCZsS1j?=
 =?us-ascii?Q?nBwGtQh+SG2R23bY9NjOi8kgwAUvx+lR7ch3RMrLtyZFh5vzcfgoatL8iAjG?=
 =?us-ascii?Q?vMq3Wl8udKb67KIJT7s+fIQgyXdSM5wKQgGqw8kCaQzVxCd1bGAB/Ksg4+H1?=
 =?us-ascii?Q?q8m4rmbOhBt9eWu01H1+1EXmLp8mvrZY3BUUr0iPY8DF8raYPUTBKkUDCL4Z?=
 =?us-ascii?Q?ZZsMOmTRFPfuoH/DnVt4Spc+L5ROl5T0FGUKa+HC7jyVOECXM4tA0XTLvXQZ?=
 =?us-ascii?Q?pyNES3uPKvTrwf1CUKrtlrg9lzTFEy+2WrG7NaOy8N865Ff/cSH9l8uq3fUk?=
 =?us-ascii?Q?lcyPJyv7wxpb/bX6T044vAlUK6MPFKKhHMzUkA4a4GYmh9bJubP2ZAcBUDbO?=
 =?us-ascii?Q?5+RRzk3oYIh8axfYVicRxzAIoFzHuGEhd+iYJWEqsEitF/vh/y5tjbU32L/Q?=
 =?us-ascii?Q?zx9BemIg4p+B4x15mAHhEfzvO2ievSvAOf29EqDiYUad+/qBY3ht1L3PNq3m?=
 =?us-ascii?Q?Bo3Yu8VeQDTR/xMJZ7R7KsVxagFbJvSb0hupxpDtPtXEEIGUjN8MbKcpuomj?=
 =?us-ascii?Q?T7bG6gkyKqrCUK7LZNoqsLU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921bcad2-f559-4cae-4bb8-08dcff87b3ca
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 23:55:48.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+07iOIY2G2EYOkCteRJNbEOucO/6QULbHlpLmePAiivF7v/Ih+nwlG5ir+/F6EiZ8YU2nrI0VE95EFhwIKHqlq89wxE1mlEXYqw1XxA7ZVvcKJPS0Dnb+3AlLtlIQ+H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8720


Hi Leo,

On Thu, 7 Nov 2024, Leo Yan wrote:
> Hi Ilkka,
>
> This is a good refactoring for me.  Just several minor comments.
>
> On Wed, Nov 06, 2024 at 07:37:39PM +0000, Ilkka Koskinen wrote:
>>
>> Split Data Source Packet handling to prepare adding support for
>> other implementations.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  tools/perf/util/arm-spe.c | 65 ++++++++++++++++++++++++---------------
>>  1 file changed, 40 insertions(+), 25 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index dbf13f47879c..b222557cc27a 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -103,6 +103,18 @@ struct arm_spe_queue {
>>         u32                             flags;
>>  };
>>
>> +struct data_src {
>> +       struct midr_range midr_range;
>> +       void (*ds_synth)(const struct arm_spe_record *record,
>> +                        union perf_mem_data_src *data_src);
>> +};
>
> The naming is a bit mess. The data structure and the parameter both
> are called "data_src", though this will not cause building issue.
>
> How about rename the structure "data_src" to "data_source_handle" or
> "data_source_class"?

Yeah, I forgot to revisit the naming part. I like "data"source_handle",
that should clarify it quite a bit.


>
> For the "midr_range" field, I'd like to change it to a pointer:
>
>  struct midr_range *midr_range;
>
> Please see below comments, which will present the reason for defining
> it as a pointer.
>
>> +
>> +#define DS(range, func)                        \
>> +       {                                               \
>> +               .midr_range = range,                    \
>> +               .ds_synth = arm_spe__synth_##func,      \
>> +       }
>> +
>>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>                          unsigned char *buf, size_t len)
>>  {
>> @@ -430,19 +442,6 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
>>         return arm_spe_deliver_synth_event(spe, speq, event, &sample);
>>  }
>>
>> -static const struct midr_range common_ds_encoding_cpus[] = {
>> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
>> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
>> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
>> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
>> -       MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
>> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
>> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
>> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
>> -       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
>> -       {},
>> -};
>
> We can keep this data structure.  For Ampere CPUs, you can add a new
> data structure:
>
>  static const struct midr_range ampereone_ds_encoding_cpus[] = {
>      MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>      {},
>  };

Sounds good to me. I change all those.

Cheers, Ilkka


>
>> -
>>  static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>>  {
>>         const struct arm_spe_record *record = &speq->decoder->record;
>> @@ -532,6 +531,19 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
>>         }
>>  }
>>
>> +static const struct data_src data_sources[] = {
>> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A720), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_A725), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X3), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_CORTEX_X925), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1), data_source_common),
>> +       DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2), data_source_common),
>> +       {},
>> +};
>> +
>
> As a result, we can simplify the structure as:
>
>  static const struct data_src data_sources[] = {
>         DS(common_ds_encoding_cpus, data_source_common),
>         DS(ampereone_ds_encoding_cpus, data_source_ampereone),
>  };
>
>>  static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>>                                         union perf_mem_data_src *data_src)
>>  {
>> @@ -555,12 +567,14 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>>                 data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>>  }
>>
>> -static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
>> +static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>> +                             const struct arm_spe_record *record,
>> +                             union perf_mem_data_src *data_src)
>>  {
>>         struct arm_spe *spe = speq->spe;
>> -       bool is_in_cpu_list;
>> +       const struct data_src *src = data_sources;
>>         u64 *metadata = NULL;
>> -       u64 midr = 0;
>> +       u64 midr;
>>
>>         /* Metadata version 1 assumes all CPUs are the same (old behavior) */
>>         if (spe->metadata_ver == 1) {
>> @@ -592,18 +606,21 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
>>                 midr = metadata[ARM_SPE_CPU_MIDR];
>>         }
>>
>> -       is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
>> -       if (is_in_cpu_list)
>> -               return true;
>> -       else
>> -               return false;
>> +       while (src->midr_range.model) {
>> +               if (is_midr_in_range(midr, &src->midr_range)) {
>> +                       src->ds_synth(record, data_src);
>> +                       return true;
>> +               }
>> +               src++;
>> +       }
>
> Here we can traverse the 'data_sources' array:
>
>          for (i = 0; i < ARRAY_SIZE(data_sources); i++) {
>               if (is_midr_in_range(midr, data_sources[i]->midr_range)) {
>                   ...
>               }
>          }
>
> Thanks,
> Leo
>
>> +
>> +       return false;
>>  }
>>
>>  static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>>                                       const struct arm_spe_record *record)
>>  {
>>         union perf_mem_data_src data_src = { .mem_op = PERF_MEM_OP_NA };
>> -       bool is_common = arm_spe__is_common_ds_encoding(speq);
>>
>>         if (record->op & ARM_SPE_OP_LD)
>>                 data_src.mem_op = PERF_MEM_OP_LOAD;
>> @@ -612,9 +629,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>>         else
>>                 return 0;
>>
>> -       if (is_common)
>> -               arm_spe__synth_data_source_common(record, &data_src);
>> -       else
>> +       if (!arm_spe__synth_ds(speq, record, &data_src))
>>                 arm_spe__synth_memory_level(record, &data_src);
>>
>>         if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
>> --
>> 2.47.0
>>
>>
>
