Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B19442B39;
	Thu, 17 Sep 2026 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628109; cv=fail; b=DSJfgX6etHrKiDkyIQTko77Hm+zhR2++UG/aw5g2aAuUouDlscw4lcGNodEZXnFkDJk90n/2eHHkEL7A+0kLYqIrUTuV2tZv7DcmbWbeTjgujQS7dALR4rlHGCIh+R/kuCT0T+JJLFBmMDk5gnJQ05z/puBdQRv2i4IQnqjzF30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628109; c=relaxed/simple;
	bh=5DRhqY/UOmDdI/Fanwvtr0Dv22d9VAhpuvHMMt2vMls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mZmQP+ev3Hd9Ax32t9eQdV/nhuK5U9stTgRgLqzkMW3l0gf42QdCqOonBIj8poviwC9QCSqzuPIklgNe+4E8W7Gq5+niIBeT1wjUv3vvrFAzKH9EWaCg4H6OtmhIUwwDf5qvBcjL83LyQ94IijRZc9EK6BWgbU9CIprFYCsM7CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=17MDVZom; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="17MDVZom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TV8u1rBJaor4M/NBlpwEByZ5A02skGvyAvodeAsg4XO13N7KRO4PxiBJ3iHDklTvsNIx4UBV9zunTGNOFuDtE4Ux94iSyKGdSGH9kySaFg1eTg7N6Eg9XiKPya989bXZLDXoDvclSY6gehqAVOpSyivbxiLZ9c0ZnJwpvjPKCyN5A7v6YNT0ueATT17m2qm67djtUWEhCLKxIRsa5E8nYVElW7iDxQkKNOwKN1IbhlQy0zOGKmj7mZw29ikbkMAiLKTGszTItWmfgtdX46PjddZzYyegcecJlsVJUwzT8zMiTePqmr21q8RGvJn8lbqJL1qiVJFwhizau2Sv4dvqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE6fBU/4PetLQS23yHxd6GXrxOqn4wPdHC8dUfeC1xI=;
 b=QQ/wwuQtaLnNBqLu7cWPlCOq7Q29eWB/GNEUhmWBaTf/xgHytxkZBWs71vodIPrxEQ08Z+ivSGtxi1lfhtJq8fc8U2kmZmLFBaeNfguG5y9qYJAcsqUtaOaj8immzYguL28zNrxwQoC//hRKQwPZqILdfuVcBCQFBxJ/qUxpjfHRnw7MnoiwSCkwsTJjDgZQM8iAhVLSxxAcFnZwB+L8oQ3HA4Xj1UDRZrRHMYTlM65jA71OpA8tgoA89dfDxDjUcx18Yy3KkbEZ/H0m6uVhk0RwFbGZspJzqg3eIhsKWPFiL6PnVludp7TsK7u5EPmHNj4LDGbgIUJpwWo5BF4uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE6fBU/4PetLQS23yHxd6GXrxOqn4wPdHC8dUfeC1xI=;
 b=17MDVZomVHyn1tpoUp2DWo4Dxi1GiXkAEK7079z6Tyg5coizEWr4gke/siYrhSWeaAtj3WmbdkxaaUKqEGSz14xtR0erc+Dj6GrhSZLlEq2mu2LEOrTA+/covSCG3z6wYx+rI+YLMEja/CIqKH/yN/Q1L69IwEYf+VED14gOa94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 06:55:03 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 06:55:03 +0000
Message-ID: <36afa71a-e939-465e-a348-75b2472651f3@amd.com>
Date: Thu, 17 Sep 2026 12:24:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] perf/x86/amd/uncore: turn amd_uncore_ctx events
 into a flexible array
To: Rosen Penev <rosenp@gmail.com>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
References: <20260916004516.268192-1-rosenp@gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20260916004516.268192-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::11) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 948df65b-88b6-488a-f4ee-08df14889909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rijtbvx6cmYAOysQNQhPMnT9cOaryUnsciKudmZah9KJhHhUDo0j5hZSUzNIxlJkDY+Eg56ZLs10mFs1TTfHD9DH8TpyXPECHB1Pe6vY1C6We6j3g2/KMSHvX7NwW3z8pMDy9/HtJVwdYnOvJtVWLzmUxszMSWr/qB35gB1RG9/zsLqQI0qhyrUCfArx+M7/czuUqz04rAHtS/4xCitioZXrbH8AcXjdwWkqGJKBtlD+H6jmBMTaHn2L9O/9to4JMH7z3jtLHNao3s5UR8mtAXENtB7ja1scKngdyglv134r3odHldldzBFIxG4JERGcBK9VV6nOCTxgHTkVAbRswywJXrIbIsqzw0xoHI3YZ0PX+0R+NR3jVU8+W6/ldJWZ4cwaaYdJ3gUlVdSC8oeKM6ODWlHOdZND82H9n9J4rXSvfML3IMroDN+YI/LCYCg147F5/2AGuEN4aeVP09ivyH5WuCkGRxocENOIqYzVItQU7gNcurhj+la8ExUenr6rBE71ejRWAsz/+Kgkr/M22rSLfzCp+CP9t+IH3c2MBp3TGOZ1xBSMGTcSttdsnhG6wcjhULUjsQArT+v8rexEJ22oZuaVia5G77AqNYRZ6zvp/vR3jtjdqFMGh59Z3dDkdheR2VsMLeKfS+y5BubbO4kOr8i4iqzbM2FJqgRWyzw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2lyOTc1TGZaSVZIZDhoVGhqUDVuQXk3UlQrd2tpeUx0aEV5Z1c0ZHlhTDN3?=
 =?utf-8?B?RnJSZVhIY245TWQyT0RxZk1wYk5hSGpQL1UrWE5FUTZQSXBGZzJ2dXI3RHRh?=
 =?utf-8?B?U0NXay81MHBwbVZIcEl1T3RpUmE3dGgrNzVvbzVGUkt5aDh3RU9xM2ZOd2xa?=
 =?utf-8?B?WnQ4aytVYnZXK2VWWU94MlplMTlleUkzamQrMHFVUkNmM1ZTYldpTFNGc3Vx?=
 =?utf-8?B?MC94bmZEdFR2dWNWczFFcDhleDRCTmsydS9FUlhGeEw4MlVVa1l3TDU4TXBD?=
 =?utf-8?B?a2kxWmUwN0JZSE9qdFdnWmx3RDBKSzVmbFE5OFJCWW1iSkFvWElnS1FNNDRR?=
 =?utf-8?B?aHJZcmhGdWhrS0NESy9FWDNiYUxjMmV6dHl3ZVlGZnJtaFAzNVdQaDA0Q2xu?=
 =?utf-8?B?NEgrSHNvZXNmZXB3cjgzVUhXVVQzK0FtUG1XOU9lNUdpczJob3IwQzhJTDFD?=
 =?utf-8?B?cDJzQ2J1VkRoR1IxSXBCV3BEL0xZdSttaFZmUjFvSlgrNjRTb3Q2S0hNMVBN?=
 =?utf-8?B?Q2xLZVM4a0Q3S1hCNnFLbWpQUWx2K05zeXZIaUNIQWJ5TllwTk0vOXcwdk1n?=
 =?utf-8?B?bHRlZnVRdlcyT244aDhzSG9WWHlIb3JwSkNTN0RVVTFyOU5ISGI3Z2FmUXkz?=
 =?utf-8?B?OHBQSHEwTDAzN2VPVmp5OWZKUWYvSE9oaU1SeE1JcDZtOU43U1JOdjVYRWVh?=
 =?utf-8?B?U0R2blRwdkRjMlFHZUJWMXVHdTlUakdYdHhTM1NPSzlySGNyWkNod3llYkIw?=
 =?utf-8?B?aXZhZGRkWUZUSXNRQ1NBbTYzR1UxVndTSTRZcDZkYkxlNUNnOUp6d2liRkJT?=
 =?utf-8?B?RWJmS1BiL3M4ZStEZVIzb1FOWlR0RXgwU1p4V3dMbEhpRnM4c090M2JQVUJH?=
 =?utf-8?B?dlc1YWFHU2pFVGlqSmVKeFlGcm1wK3lWY2dTeGtzc3BYSHZjd1dRZ0F2TzN4?=
 =?utf-8?B?R1pkQWZkaWJlS1doYUo4T21sdnNuWjlGL2lqcVo4NjUyclNCZ0xIWU93enRH?=
 =?utf-8?B?dW9QZzlBeFJ4a2t2YTNTdnJ0cnl3OW81Y0MyUmtZTnhSSk8zRUYwRGNEb2FR?=
 =?utf-8?B?K1JtYTNvWHdDanZqUUYyZjY3VnJBaXRManBQVXgzUnFwaDJVWXVFeUlSb2Z3?=
 =?utf-8?B?OUVZbjFnNzVFMXhUQ3BVSmkyV1ZXK01JdWN1bjhtdmxTQXFDZzlyaHBleGZL?=
 =?utf-8?B?ZUhnSE1QT1dNcGxJMmRoSzhIOFAxYVZxdWRaaEY0VjF1VXRkTlR4RG01OFpT?=
 =?utf-8?B?bC9ucHV5T2MyMUszUk5iSXNDNVZtaEhVd1Z1WUhyOXhJYU1kdk55THZ4djJB?=
 =?utf-8?B?S1ZhQktnSWwvSDFGYkpQaW81SngwajBHU2FuMjVnazgrSFFuVWlwK2pGVEF4?=
 =?utf-8?B?UzJjdHhHZ2hWdzNCekZ3M3hwTXl6dlc0T2dRemRzczhPZkRGUlkxeWNTVVlZ?=
 =?utf-8?B?ZEdiaUxRK2VYcDcrL25BeTdZNDNFTW51TE1UdHMwc29ucmFBY1hraXNGMlVK?=
 =?utf-8?B?QXBWRThFaWhYZE95WnZIMVlVSDVtUmRJVVdyZVVvUjl1QmJSbzBEY3l1dTU3?=
 =?utf-8?B?WVlDWDB1MUlIMnJnaWM3VUhsdXRTRXhuTlJIcWprWEFZbThWYWp5VWRxOCtv?=
 =?utf-8?B?UllRRjhJaDYvTlA4TWViYWpvT2J3QmhYbUNYdHQ2L2l2Y2REQjExaUcwUjB6?=
 =?utf-8?B?NVYzOWNSYldQdDRsdExZS2Q2SjBaZkZBcUJKYTYyRS8xT2hWSi9JaisxZi96?=
 =?utf-8?B?TENSTXRiQ2QvRmZMczFJNFJMYXRRT1llOXFaSWd0WFI0clVOOUk1THFvYXhK?=
 =?utf-8?B?U0RUem9ibndqRzd6MENvK3NsU0NuaklWVnJBc2xxWGlDY2R5R0x6c1dsVFI1?=
 =?utf-8?B?ZHNpb0NWRDdHeFh0WmZiTmdndVhxVW5hRU5ZMXc5ZlJNbStEdUd6aWd0Qkpv?=
 =?utf-8?B?cmtrSE8zY1VUWlE0enQ5ODdReFM0TFpJSXVPdDAxM01USUVyMVRic2hrOVJu?=
 =?utf-8?B?aXNWd0dyZUtSeHU2bUxyV21lOWpLR2ZjSERVYmYrT2NhR1J5YVZGYWxyQXg1?=
 =?utf-8?B?VHQ2VUFpNk8vZUQ2ODdHM01rZWdMWFFtR1pJVnRqVG9UdEovQUhUUDg0WC9p?=
 =?utf-8?B?d1pEbFpIL25OWTdXbkFFdkVCTVZwU3EyNXBaU3gxcVFXVWczZElCU2I3T3Ro?=
 =?utf-8?B?UXZ5MTRwQ2pSbTJ6REJlNk5qc3NITjAraDJad3MrYVhnMFp2NG80ODNMOGtq?=
 =?utf-8?B?U2xUQ2JkenRsQUh2MTQ3T2tmVjVWS0s3b3BITXFYQW5ZU1FJNGROSTBmR05U?=
 =?utf-8?Q?8bqThgkqo+D1X/M2lA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948df65b-88b6-488a-f4ee-08df14889909
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 06:55:02.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rcgj+GWLgfqW17fUwqDnE0AZd7YCiERaauBiyKmRRA2D0tpVw/3peRcilkkeaoqR3yhUbVoWQsiHlIfNCw4MsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

On 16-09-2026 06:15, Rosen Penev wrote:
> The events pointer was kzalloc_node()'d immediately after the parent
> struct allocation, with the count (pmu->num_counters) trivially
> available beforehand.  Move events to the struct tail as a flexible
> array member and fold the two allocations into a single kzalloc_node()
> with struct_size(), dropping the separate kfree(ctx->events) in the
> free path.
> 
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/x86/events/amd/uncore.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 7181973b5b12..74b9c92d517a 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -39,11 +39,11 @@ static int pmu_version;
>  struct amd_uncore_ctx {
>  	int refcnt;
>  	int cpu;
> -	struct perf_event **events;
>  	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
>  	int nr_active;
>  	struct hrtimer hrtimer;
>  	u64 hrtimer_duration;
> +	struct perf_event *events[];
>  };
>  
>  struct amd_uncore_pmu {
> @@ -519,10 +519,8 @@ static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
>  		if (cpu == ctx->cpu)
>  			cpumask_clear_cpu(cpu, &pmu->active_mask);
>  
> -		if (!--ctx->refcnt) {
> -			kfree(ctx->events);
> +		if (!--ctx->refcnt)
>  			kfree(ctx);
> -		}
>  
>  		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
>  	}
> @@ -567,18 +565,11 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>  		/* Allocate context if sibling does not exist */
>  		if (!curr) {
>  			node = cpu_to_node(cpu);
> -			curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
> +			curr = kzalloc_node(struct_size(curr, events, pmu->num_counters), GFP_KERNEL, node);
>  			if (!curr)
>  				goto fail;
>  
>  			curr->cpu = cpu;
> -			curr->events = kzalloc_node(sizeof(*curr->events) *
> -						    pmu->num_counters,
> -						    GFP_KERNEL, node);
> -			if (!curr->events) {
> -				kfree(curr);
> -				goto fail;
> -			}
>  
>  			amd_uncore_init_hrtimer(curr);
>  			curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
