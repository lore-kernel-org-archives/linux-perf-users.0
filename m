Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8513AB496;
	Mon,  6 Jul 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358502; cv=fail; b=NCbqHv9WhIZMzkR3tg4CyTb/d6xhbSzff2T1KDaWUCRdL6EqT8RA3BgJJPLMO4QQr6T13F+iNtqjfi8b5pWkTY4wBbBQRyfIx/DGtmAcpvOOziv4f0+QrkNDsq29SjhPsltRRKFm7duQoOOEEmPOsgJg9pQ4h28988L9tH3yFm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358502; c=relaxed/simple;
	bh=pYxqs0QMEU0ni5qA2D53J/FZvvRbvdu+/5/rBaYIGGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xr8B3pibfJcviNWDJSpzwzV9tlJJ9m7m4nZO3AKEDlYNqW5nkBLPaqdWFFl5W/Wv4hrNQvu7391Ugo4dYgasT60uH1BB8vPt+A3ftB2sKIPN7mw+L60a+wFsDEGYmMvDgP74oraBb1n71IhkohoW1GPJZGp3r7cIeVMhR6N7ljg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ah0cxxAE; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ah0cxxAE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DA1+wK/RFtBHhT624JJr2NncduOlSh/LpGpHAnQdBLMA2wbtBJAMKYWPEyYpyz5GVv4PjPXps7CAZdGrLbI44D9vR3diYa9PdcaxGPFfgyXSBO/IEDomiWhnRzTCRV6LN9OEzl7YzxcTbduN5lXHqZXsVziS/J4qxgmX2Axbx5jSSh5XT+6MXMG3ipTYv+2EpUHMvWiYHAqdvVlHo6PCuYMnjLa4YX92Vz0MILWHQWVzpdDouVtfJP6G0MTqFHgw0bZKSRrBc7n9h9Q8M/GBM9WswQnmdzkWXCeFP8OmwzKobqRmDD0tV0vzr2omdu8drgvmzIAmmCODwgaSW8mBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwpMDEGRlHydoFRByB1UT3P2Pa8DQ/r0hd3bNjkbnFs=;
 b=lh7pI/UC4pTi9XQ6rYJb3l2ruAY6TaC+qQVXMk0uUxDzRLwtpwBX2p6B70UsXMx1B3+8gabjic36h/oVDMRqAISyQG2r2aWXy2YnztiTkd8J3fs7KwiwSW/a2eQLoegDqouBpOnK+fEhgUU7O0AyFfYdcYonoufK/q0zawdj24W8Gd2DJS2urvuaZvHWNtPK24H8bxS1lJSrtk8ERLilv4Bhrb1fWB5tuVM8xqmTiMCR9AOPsdYPdRvBB02G3GstX69WQVibCpxLBelU7/GyUgTDZC8AN2VNzgPu5fmUh/5gb+pw+oHF6ine81k17SwTuIncPy6SK+H6CCL9i380Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwpMDEGRlHydoFRByB1UT3P2Pa8DQ/r0hd3bNjkbnFs=;
 b=ah0cxxAETo6dhaQX4HLsQZ8x0OVuU48wks3jZ7c28TSgvsabgBEWa/o9X3+8t5AxA5h86CjNZS1KL7myD0T0oIlnXxbAbKu88kIp8J94m01Y+QWV/aiZ70OL6al0T6nZ1oGpCDYmEy/8lh7pJbKvQAkMUicAJcKJI7hRbwV/gzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 17:21:31 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 17:21:30 +0000
Message-ID: <bf0b2ab8-c2b1-4020-8506-6e2188e78250@amd.com>
Date: Mon, 6 Jul 2026 22:51:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf vendor events amd: Update Zen 5 core events
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
References: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
 <CAP-5=fV_czvd-z4N7K+_SabxuOm9UUHRyBxNuchrtAgJL3OqOw@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fV_czvd-z4N7K+_SabxuOm9UUHRyBxNuchrtAgJL3OqOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ba::7) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: acbb6343-fbf7-46de-8625-08dedb8304ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|3023799007|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	DgghQZqWHiAG10koaYoY0vAOzvYsDSajqmSpVdmX6dho8SfnfYTXFlwYsXXOmxLmFvtJZ2+XWVCIkr8SwIQDThs9ULrccFIFpqkn6hDkEo3xkVXQ6NtSwtXM9vtv1qROJQ2vkrX4mvaEMXxTa3xC6+OBoku9FH63OCECVhEbAtwDtMs+os0hDPaAZ9ywoULzghg3e0l9DrUGgrJ6Gpgu1OnkE6ogvUaHxIGFKrLCqy1d4vxI4ymTEQjpgkoN/34OQGtt6wK2+U6NNqCU0+Qcq2/EokJ7M7W7GGdUs/jtKa9pTuFTqbXydriXPaAb5Eip9/CY5ODUNk2Ahr8EWUTKNLsFZpVKpqChE2DvanMJqBqPH2RJ3nW/fUvEzEremKFPiTVwAa+bBVE2OMvqRpjSYB4icTgVRuYLaSpUsMi0b7lrUEv9SD/T1SvC1hcNVv0PRoko0RfeWld8bPV1QxwrEg2HkuXW4dtsH/6ti9Mnq8nYGcQa0jceJGI82wTEVp/F2SYkFiKs6oAwJtQIKUMTrtH+g9Ykk9Z3AAabw435VP+1zsp/4/YXE17R9GmdlvuBhNPbnIKc8+31sLXW8iGB//3bsQ9Ds20Ilwe1hoaqkyLL+rt1m3p6dmV86q2d8+Z982DzslAaENBVWUHxRhp1QxODd6nCTm0jcWhSiy5ahJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3dkWmR2dHVBTlRGOFlCME0yWWRFaXk4UjEwT2VHYTNHUTdyZ3BoYUR5dTFv?=
 =?utf-8?B?RzZoTTF3Rm03VkdESGNRUCs2NERTQlp1SHpNdU5qWFlkdjJRaG8wNzA5eWNh?=
 =?utf-8?B?RFdybzRNS2ZUdDJLK2I1clZZd0ZjZlJ6eVpoeDdjZTNLL3A0N0lPTzBQNEY3?=
 =?utf-8?B?R2xvdXZoak9UcWQ5OW94WTFOUHlzSWlub0RsOVlwM01HcCtIVUJqemdJTkYr?=
 =?utf-8?B?OUkxRUphUnRrRzZjMHFaYTh1SExBeG5YZUtrYWhXa3lOdDFHc3FLUmU3Tkho?=
 =?utf-8?B?Mk1OK294SzF4aTMraWFjblNKbVdHdnJUV1hkRk9Fd0RCVUJlZ2J0WGE2RFNR?=
 =?utf-8?B?VjJWQlBuTHkyRHZ3RXdCMERtdFRVeExKbGl6UWJKRkR0UVVTR3FHdXBFd3Rq?=
 =?utf-8?B?WldXRWE3dlVuTjcyWVIxSEtuTzljamNnbVdJZXVOMUdlZStjV0RLK2xjdmxz?=
 =?utf-8?B?Y0dOYXhJNGZuVXpkVjBVWTl1YXorVS92cStiSFdtK2RvNmRneHdMc3UxeGF1?=
 =?utf-8?B?dVN1YUQ1S2VIMEx5N0YxY0NrZXI4RkNCa2ZNeDBNSGFydDZrRE1qOWludTUz?=
 =?utf-8?B?Q1F5RFhIaHpkYnhha3VPSEs0VE1QeEdTWm9WNHRMWkN4QVQ1WFVUQ0tVYVJv?=
 =?utf-8?B?aDF6MGluWm1VUkpFYXpWUFk0UVIreHhrYWxwL0gvUkdjOUZJb0g5UE5NZTFa?=
 =?utf-8?B?Y0c5cUNrZFN1SzdjN2luY2hUOCtQd0djWXhHWHZFYlFxZHRhYnJxOEJQcmUw?=
 =?utf-8?B?ejR3UHVLa2xNZ0IybWJsZGNLOVk4WVB3dUhBKysvQVo1dFZEbVlSZVJFYjR6?=
 =?utf-8?B?ZW9TOVhkOWtrZnJFV1pkaXluN1hEVEZXaUduZnFXWWFiT29ZR1ZFOFZBQzYz?=
 =?utf-8?B?eTdRNmdFZDlUbENMejJDTmRjRWpocHUvdnRJS3Yrc2x6OFF0ZmU3bWs4Uzd1?=
 =?utf-8?B?MHdZaGlSVy9Pa2xsUFRiTVpjYStRMVFlejBOTUcxRm9UcUFKYmk1T0tLUDYw?=
 =?utf-8?B?dms2dnFjdXh4cnJMN3RBZ1N6QkdRYXFFUzM0ZHVRdU01MllnR2xFM3Y0M08x?=
 =?utf-8?B?UnJPdXpEOVFEQnV5OEFybVlESm51cGRrU25HOEpudWdrZEthd2VqMHlDTWlS?=
 =?utf-8?B?ZlVjZUF6WWEvNGR2ZC9USHdwc0ZnWWlSUTBoNVpJM3hDTTNwZ3d2YlVFRU9j?=
 =?utf-8?B?cmhZQ214Tkl1aWlSKzgrUVpPazhKWlBPczZoYjZONnlLUlRhaFdpNUlacnMx?=
 =?utf-8?B?ZGt3UERSQWljRTlaYzk1eENEb3ZnUWxhODBqdDhSSHV1MzJtRCtaWVdYaUpN?=
 =?utf-8?B?VXkxelJuK3lHdDdrOFpuaWxWR0Zac1pkc1RXSXIrd1lZRTZNZHA1dmw3Zldj?=
 =?utf-8?B?eHQzcXR2RzVxVXZVQjJTb2pWRnZ3bW5Tb2lKY0g0enp2NDRkbTBmQTJPRkdt?=
 =?utf-8?B?QTFjMncxaFl4NTh4Z1JmSTZRL3BEenhpUkswY3JjK0lhblRUSXRoWkkycXRa?=
 =?utf-8?B?T0FpT25xSnRMUzlJZEU0UnlxQTRIUUJhN1l6dC9DRHYyVTF4bTI2eEpNdjNZ?=
 =?utf-8?B?VHlqZTV1TGdjZktsRE1BQW12MS94Mi9CVTRxdG5hZjRIZ1NJbXVJVmQ2aGx6?=
 =?utf-8?B?SGNKQ1U4TU91TXdzYzhrWkk1ZG5lTG1RejVVL2RiMWtTSzJRRjduYXV4OGVZ?=
 =?utf-8?B?aWNxcVVFSUlOemdGT3NiTVZUMGtpVXgrTkJvTldMYXdtM1E3QVZZZ29ieFU0?=
 =?utf-8?B?K2hKbzVnMExrV3lUQmNJVFNrWlhNdERrbE05S2p0YmVnMmxLZElxQ3BtdC9D?=
 =?utf-8?B?ZHNzYU5IajNJRW8wWHErV24yZWhWelYzMkhTMnMrcFlJV1pOR0F0c2VmQ0I1?=
 =?utf-8?B?NG56a3hmREdrSGFuL09Xd2p6dnYzNVg1am9RZVdWNzJaT1dlK29vK0ZzZTFl?=
 =?utf-8?B?cjNKYWIwWlNFQVRyYTI5MW9qN0dFa0ZteFpQRXZHRGVZeWNmM0pXRFE1RE00?=
 =?utf-8?B?WWJmejVHYzZxVzZKY096bGxqUm1hWGp2MHkxT3UwVlFVRWVrU3R1MmZLSXIw?=
 =?utf-8?B?YXNNVloyNlpHRk13ZmREWGVvWFgrUUwvcURsa0tWQTlGZGZNK2k0ZU80NHR3?=
 =?utf-8?B?VHdvSTNSYmRCMzQyS3NYWmhENmFVbExQTnJ2UzlqNDJOdnlJN2ptckF0NFUv?=
 =?utf-8?B?ZDZJcVlXM0lOTXFxOEdCRnVLaFFqK1JsRjFYbzUyUEhoWmlWTEtDTTJzMXFt?=
 =?utf-8?B?VURKKzFMRi9RdFgrUEJmL0NDb1hwTVpuaHYvWTB2YW05YnZiWm4zdW9hcmwv?=
 =?utf-8?B?RzlBcHlwRHpYS09MdDFTcy9Ieks0bS9tdzIybnlzMG5BSnJLWVhIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbb6343-fbf7-46de-8625-08dedb8304ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 17:21:30.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMQ3LRRRurDg8THHVPIbWWtQuHu14uFM4/aFxyTjJacn7lDWLUA6YkEuYgHKTEPdSfNoibqhqN9ACYH/MS3lXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903

On 06-07-2026 22:44, Ian Rogers wrote:
> On Mon, Jun 22, 2026 at 10:28 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> Update definitions for the following events.
>>   * PMCx00A - Add missing unit masks
>>   * PMCx00B - Add missing unit masks and fix descriptions
>>   * PMCx00C - Add missing unit masks
>>   * PMCx00D - Add missing unit masks
>>   * PMCx025 - Add missing unit masks and fix descriptions
>>
>> Fixes: 45c072f2537a ("perf vendor events amd: Add Zen 5 core events")
>> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
>> ---
>>
>> Previous versions can be found at:
>> v1: https://lore.kernel.org/all/f16d1391366762dee0d49f00697f5e6ea913e2c1.1780330378.git.sandipan.das@amd.com/
>>
>> Changes in v2:
>>   * Fix event description pointed out by sashiko.
>>
>> ---
>>  .../arch/x86/amdzen5/floating-point.json      | 130 +++++++++++++++---
>>  .../arch/x86/amdzen5/load-store.json          |   8 +-
>>  2 files changed, 120 insertions(+), 18 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
>> index 9204bfb1d69e..569975b53cc3 100644
>> --- a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
>> @@ -179,6 +179,30 @@
>>      "BriefDescription": "Retired scalar floating-point blend ops.",
>>      "UMask": "0x09"
>>    },
>> +  {
>> +    "EventName": "fp_ops_retired_by_type.scalar_mov",
>> +    "EventCode": "0x0a",
>> +    "BriefDescription": "Retired scalar floating-point MOV ops.",
>> +    "UMask": "0x0a"
>> +  },
>> +  {
>> +    "EventName": "fp_ops_retired_by_type.scalar_shuffle",
>> +    "EventCode": "0x0a",
>> +    "BriefDescription": "Retired scalar floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
>> +    "UMask": "0x0b"
>> +  },
>> +  {
>> +    "EventName": "fp_ops_retired_by_type.scalar_bfloat",
>> +    "EventCode": "0x0a",
>> +    "BriefDescription": "Retired scalar floating-point bfloat ops.",
>> +    "UMask": "0x0c"
>> +  },
>> +  {
>> +    "EventName": "fp_ops_retired_by_type.scalar_logical",
>> +    "EventCode": "0x0a",
>> +    "BriefDescription": "Retired scalar floating-point logical ops.",
>> +    "UMask": "0x0d"
>> +  },
>>    {
>>      "EventName": "fp_ops_retired_by_type.scalar_other",
>>      "EventCode": "0x0a",
>> @@ -245,12 +269,24 @@
>>      "BriefDescription": "Retired vector floating-point blend ops.",
>>      "UMask": "0x90"
>>    },
>> +  {
>> +    "EventName": "fp_ops_retired_by_type.vector_mov",
>> +    "EventCode": "0x0a",
>> +    "BriefDescription": "Retired vector floating-point MOV ops.",
>> +    "UMask": "0xa0"
>> +  },
>>    {
>>      "EventName": "fp_ops_retired_by_type.vector_shuffle",
>>      "EventCode": "0x0a",
>>      "BriefDescription": "Retired vector floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
>>      "UMask": "0xb0"
>>    },
>> +  {
>> +    "EventName": "fp_ops_retired_by_type.vector_bfloat",
>> +    "EventCode": "0x0a",
>> +    "BriefDescription": "Retired vector floating-point bfloat ops.",
>> +    "UMask": "0xc0"
>> +  },
>>    {
>>      "EventName": "fp_ops_retired_by_type.vector_logical",
>>      "EventCode": "0x0a",
>> @@ -278,7 +314,7 @@
>>    {
>>      "EventName": "sse_avx_ops_retired.mmx_add",
>>      "EventCode": "0x0b",
>> -    "BriefDescription": "Retired MMX integer add.",
>> +    "BriefDescription": "Retired MMX integer add ops.",
>>      "UMask": "0x01"
>>    },
>>    {
>> @@ -299,16 +335,34 @@
>>      "BriefDescription": "Retired MMX integer multiply-accumulate ops.",
>>      "UMask": "0x04"
>>    },
>> +  {
>> +    "EventName": "sse_avx_ops_retired.mmx_aes",
>> +    "EventCode": "0x0b",
>> +    "BriefDescription": "Retired MMX integer AES ops.",
>> +    "UMask": "0x05"
>> +  },
>> +  {
>> +    "EventName": "sse_avx_ops_retired.mmx_sha",
>> +    "EventCode": "0x0b",
>> +    "BriefDescription": "Retired MMX integer SHA ops.",
>> +    "UMask": "0x06"
>> +  },
>>    {
>>      "EventName": "sse_avx_ops_retired.mmx_cmp",
>>      "EventCode": "0x0b",
>>      "BriefDescription": "Retired MMX integer compare ops.",
>>      "UMask": "0x07"
>>    },
>> +  {
>> +    "EventName": "sse_avx_ops_retired.mmx_cvt",
>> +    "EventCode": "0x0b",
>> +    "BriefDescription": "Retired MMX integer convert or pack ops.",
>> +    "UMask": "0x08"
>> +  },
>>    {
>>      "EventName": "sse_avx_ops_retired.mmx_shift",
>>      "EventCode": "0x0b",
>> -    "BriefDescription": "Retired MMX integer shift ops.",
>> +    "BriefDescription": "Retired MMX integer shift or rotate ops.",
>>      "UMask": "0x09"
>>    },
>>    {
>> @@ -324,9 +378,9 @@
>>      "UMask": "0x0b"
>>    },
>>    {
>> -    "EventName": "sse_avx_ops_retired.mmx_pack",
>> +    "EventName": "sse_avx_ops_retired.mmx_vnni",
> 
> Just a heads up, when renaming events it may be a good idea to keep
> the old name and mark the event as deprecated, then add the event
> again with the new name. This avoids events breaking when the perf
> tool is updated. Personally I feel vendors should get to decide about
> this kind of thing, but there have been some strong sensitivities
> around event names in the past.
> 

Thanks for the suggestion. I agree that renames can be problematic
for existing scripted workflows.

Namhyung, please let me know if you want to revert these changes.
I can send out v3.

> 
>>      "EventCode": "0x0b",
>> -    "BriefDescription": "Retired MMX integer pack ops.",
>> +    "BriefDescription": "Retired MMX integer VNNI ops.",
>>      "UMask": "0x0c"
>>    },
>>    {
>> @@ -390,15 +444,15 @@
>>      "UMask": "0x70"
>>    },
>>    {
>> -    "EventName": "sse_avx_ops_retired.sse_avx_clm",
>> +    "EventName": "sse_avx_ops_retired.sse_avx_cvt",
>>      "EventCode": "0x0b",
>> -    "BriefDescription": "Retired SSE and AVX integer CLM ops.",
>> +    "BriefDescription": "Retired SSE and AVX integer convert or pack ops.",
>>      "UMask": "0x80"
>>    },
>>    {
>>      "EventName": "sse_avx_ops_retired.sse_avx_shift",
>>      "EventCode": "0x0b",
>> -    "BriefDescription": "Retired SSE and AVX integer shift ops.",
>> +    "BriefDescription": "Retired SSE and AVX integer shift or rotate ops.",
>>      "UMask": "0x90"
>>    },
>>    {
>> @@ -414,9 +468,9 @@
>>      "UMask": "0xb0"
>>    },
>>    {
>> -    "EventName": "sse_avx_ops_retired.sse_avx_pack",
>> +    "EventName": "sse_avx_ops_retired.sse_avx_vnni",
>>      "EventCode": "0x0b",
>> -    "BriefDescription": "Retired SSE and AVX integer pack ops.",
>> +    "BriefDescription": "Retired SSE and AVX integer VNNI ops.",
>>      "UMask": "0xc0"
>>    },
>>    {
>> @@ -497,12 +551,24 @@
>>      "BriefDescription": "Retired 128-bit packed floating-point blend ops.",
>>      "UMask": "0x09"
>>    },
>> +  {
>> +    "EventName": "fp_pack_ops_retired.fp128_mov",
>> +    "EventCode": "0x0c",
>> +    "BriefDescription": "Retired 128-bit packed floating-point MOV ops.",
>> +    "UMask": "0x0a"
>> +  },
>>    {
>>      "EventName": "fp_pack_ops_retired.fp128_shuffle",
>>      "EventCode": "0x0c",
>>      "BriefDescription": "Retired 128-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
>>      "UMask": "0x0b"
>>    },
>> +  {
>> +    "EventName": "fp_pack_ops_retired.fp128_bfloat",
>> +    "EventCode": "0x0c",
>> +    "BriefDescription": "Retired 128-bit packed floating-point bfloat ops.",
>> +    "UMask": "0x0c"
>> +  },
>>    {
>>      "EventName": "fp_pack_ops_retired.fp128_logical",
>>      "EventCode": "0x0c",
>> @@ -575,12 +641,24 @@
>>      "BriefDescription": "Retired 256-bit packed floating-point blend ops.",
>>      "UMask": "0x90"
>>    },
>> +  {
>> +    "EventName": "fp_pack_ops_retired.fp256_mov",
>> +    "EventCode": "0x0c",
>> +    "BriefDescription": "Retired 256-bit packed floating-point MOV ops.",
>> +    "UMask": "0xa0"
>> +  },
>>    {
>>      "EventName": "fp_pack_ops_retired.fp256_shuffle",
>>      "EventCode": "0x0c",
>>      "BriefDescription": "Retired 256-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
>>      "UMask": "0xb0"
>>    },
>> +  {
>> +    "EventName": "fp_pack_ops_retired.fp256_bfloat",
>> +    "EventCode": "0x0c",
>> +    "BriefDescription": "Retired 256-bit packed floating-point bfloat ops.",
>> +    "UMask": "0xc0"
>> +  },
>>    {
>>      "EventName": "fp_pack_ops_retired.fp256_logical",
>>      "EventCode": "0x0c",
>> @@ -648,15 +726,15 @@
>>      "UMask": "0x07"
>>    },
>>    {
>> -    "EventName": "packed_int_op_type.int128_clm",
>> +    "EventName": "packed_int_op_type.int128_cvt",
>>      "EventCode": "0x0d",
>> -    "BriefDescription": "Retired 128-bit packed integer CLM ops.",
>> +    "BriefDescription": "Retired 128-bit packed integer convert or pack ops.",
>>      "UMask": "0x08"
>>    },
>>    {
>>      "EventName": "packed_int_op_type.int128_shift",
>>      "EventCode": "0x0d",
>> -    "BriefDescription": "Retired 128-bit packed integer shift ops.",
>> +    "BriefDescription": "Retired 128-bit packed integer shift or rotate ops.",
>>      "UMask": "0x09"
>>    },
>>    {
>> @@ -672,9 +750,9 @@
>>      "UMask": "0x0b"
>>    },
>>    {
>> -    "EventName": "packed_int_op_type.int128_pack",
>> +    "EventName": "packed_int_op_type.int128_vnni",
>>      "EventCode": "0x0d",
>> -    "BriefDescription": "Retired 128-bit packed integer pack ops.",
>> +    "BriefDescription": "Retired 128-bit packed integer VNNI ops.",
>>      "UMask": "0x0c"
>>    },
>>    {
>> @@ -719,16 +797,34 @@
>>      "BriefDescription": "Retired 256-bit packed integer multiply-accumulate ops.",
>>      "UMask": "0x40"
>>    },
>> +  {
>> +    "EventName": "packed_int_op_type.int256_aes",
>> +    "EventCode": "0x0d",
>> +    "BriefDescription": "Retired 256-bit packed integer AES ops.",
>> +    "UMask": "0x50"
>> +  },
>> +  {
>> +    "EventName": "packed_int_op_type.int256_sha",
>> +    "EventCode": "0x0d",
>> +    "BriefDescription": "Retired 256-bit packed integer SHA ops.",
>> +    "UMask": "0x60"
>> +  },
>>    {
>>      "EventName": "packed_int_op_type.int256_cmp",
>>      "EventCode": "0x0d",
>>      "BriefDescription": "Retired 256-bit packed integer compare ops.",
>>      "UMask": "0x70"
>>    },
>> +  {
>> +    "EventName": "packed_int_op_type.int256_cvt",
>> +    "EventCode": "0x0d",
>> +    "BriefDescription": "Retired 256-bit packed integer convert or pack ops.",
>> +    "UMask": "0x80"
>> +  },
>>    {
>>      "EventName": "packed_int_op_type.int256_shift",
>>      "EventCode": "0x0d",
>> -    "BriefDescription": "Retired 256-bit packed integer shift ops.",
>> +    "BriefDescription": "Retired 256-bit packed integer shift or rotate ops.",
>>      "UMask": "0x90"
>>    },
>>    {
>> @@ -744,9 +840,9 @@
>>      "UMask": "0xb0"
>>    },
>>    {
>> -    "EventName": "packed_int_op_type.int256_pack",
>> +    "EventName": "packed_int_op_type.int256_vnni",
>>      "EventCode": "0x0d",
>> -    "BriefDescription": "Retired 256-bit packed integer pack ops.",
>> +    "BriefDescription": "Retired 256-bit packed integer VNNI ops.",
>>      "UMask": "0xc0"
>>    },
>>    {
>> diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
>> index 06bbaea15925..b1994539ece8 100644
>> --- a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
>> +++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
>> @@ -8,9 +8,15 @@
>>    {
>>      "EventName": "ls_locks.bus_lock",
>>      "EventCode": "0x25",
>> -    "BriefDescription": "Retired Lock instructions which caused a bus lock.",
>> +    "BriefDescription": "Retired lock instructions which caused a bus lock.",
>>      "UMask": "0x01"
>>    },
>> +  {
>> +    "EventName": "ls_locks.all",
>> +    "EventCode": "0x25",
>> +    "BriefDescription": "Retired lock instructions of all types.",
>> +    "UMask": "0x1f"
>> +  },
>>    {
>>      "EventName": "ls_ret_cl_flush",
>>      "EventCode": "0x26",
>> --
>> 2.53.0
>>

