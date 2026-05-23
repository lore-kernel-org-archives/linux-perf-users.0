Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E61F19046E
	for <linux-perf-users@vger.kernel.org>; Sat, 23 May 2026 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779503092; cv=fail; b=BqPAsagq8ZaSPq/u+3isFUaylfdf4RZ/Ui11frAxH1jY7iSIrSnFnvffBfii5KrpompP5OuSovBfgHY3aSG44M5flOv7BN6pGDvifESPerOe2AhsXXn+8Tw62E6s9C2IWr7AM+ucTSo2KKgcuHGxlMFHIK38vyDEx2gTLJ8udqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779503092; c=relaxed/simple;
	bh=biD9sldhr9N1Oi6V4KHz/rGLjxCtdk+5zIKN5Smns34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDcW0FvUw8ZjcDFolq81J90TnNNd4bga9dd+oSluulhNyVlNAKu5ttSgno6w6dlyUEqDs5l7mZj4hpv7AHhm03UXku40bvd+minKar79VSUqzXs1a65aNSBEWpiQnPEo4fkv2QwX74K9E6fxBr8CTbGBsnHDROEWu1DRRdT9/80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fkiWwKsB; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkiWwKsB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iu/Fdf1BtbyIqUx/iteINjSCjtV+gIS4oX0xf+ms8Wqg6jOvyaarHuiWt2ktML+8INxEhRTohS0Y6JzVv2FkWV3J84ZXFEZV7VIue5b3nyUYAWhwQWo/5xecL0PYlNJr6hgp0lCmDAvO9u38nCHO+E6xQwP+ouCJvc5Sckds4uXJ5xaxQrLYWwWgzSsinNOVSUkA1sjMStWme4IFqdo++WDhO1AWJBC5ds+4DrmlYshNVfJGwNkdDq8mj6gYdJrqglqC5uMh0sgSVaYakJW6cDQLwlqmTjuLsSNno811xQX5CYfMCP7zo3nTtfLzoyDnliphvEQ3Rmj84VyeqLhXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d57nX+Q+Nx/d5cmZsKHQYssBgUwSqB7ud4AFLFSfh/k=;
 b=a9qD6Vffj8B9bx+aM9axb7+cWcY2Sy2L7Goz2t1frMX05ju5XikmjF5pQ9Kv9bfaXHqWe+nsxWBrNXeFdXUpAR6/v2YqjhcvDqFq8hSyU1xNyE3vPzfOOaAaQE8HvJllRIw8eIoBVhTVDMwgrVhUgwolDn66+Aec1mG1Tpcpt4qHrH1eV88ZG+UmEFf7EWvviUefFDMlHAnO3fI6Bg4X6KmhOEq95zqYlnFfbxgMYIg9YzAkDwvBp5KlByIWpitwXcUr60T+SDJDt0ryi2HLNtJck5CUcSoN6a67gK2XydvMd/Q3Nk3RxJDwwUeHMXMk5vrgd0bwEieP/m12QWxQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d57nX+Q+Nx/d5cmZsKHQYssBgUwSqB7ud4AFLFSfh/k=;
 b=fkiWwKsB/ywwPkTCCGMQs1F6F2t25mb9Fuo2mHIT2++v1ycQ3DM5D2U9Ut3luJ7FXDKiNsBa9tNxZUCqYJSRL9m8M1QI09MNLEbMkeEuCnqpOmjv2mzVS9S1fox7cdwp/pHGrHb0hdn+MAZB5HuzchTt/m5nXZXn+aT5KXVzzYP1FhvoOnEUhWZUdL4PbDCUcDUSZ2YzK9pyDos4OAVZgIyRHuBHxehe9KL9biUuq7fP1AnDEIfIrCGmb2X1lXneq8yumGzVgk5dH6TTezJqcJhVkSz2TnmCqKIFPgF5UEC47o0ys/SSf0knAoMI00X78/6VrDSHLEg9z6zBnNPn8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Sat, 23 May 2026 02:24:47 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 02:24:47 +0000
Message-ID: <4a1e2d01-051e-4644-a729-c30585aa367e@nvidia.com>
Date: Fri, 22 May 2026 19:24:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/xe: gate observation streams with
 perf_allow_cpu()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260523013326.129491-3-jhubbard@nvidia.com>
 <20260523022022.E766E1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260523022022.E766E1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::9) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b94ca5e-a0e4-451b-dd2b-08deb872759f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|5023799004|4143699003|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IDR7rXd+pX2YZPcO/GeMvyOgUqNszKvp8MT1qP0CCHZFXdjtArUm6brpDk7LqA2rtf5F2pOjdQgp3iEUbE1wSnUT91RjZ008cnK4+863izbHJM+qfU2q9+ae3hMZQwa3QMpEiZV9+mvUxX0204rNj69FcvvuhC4IkkoIL0jh4/37BpldlhNoNm8f3+536k5CtILDdeB/hGnm2rg7xvLklKQxNfC3CqvFuAjvVr3MHt/SPKdlmW9laKKo6fpqITUcFM2NEjG/LUS/F3CJqXDIAClyYzfib+Na14++Uvq2xkOF8ZnceB6jzTPLy2pJjXkTyJO4UyT978NofiAQBUSB75V0/iBc1LHiQFROOqxGRt7LuJYkBAv1Jz+h1SV1w+jN9TIdXgtaEYa0LONUg8GKkpzEJOUsxMyg3aTq45WACewPGbfi5TBu1FP5IahjLjUn6JSU62pRuxRnHgxNF/PZlVh864HovGZHmV822UqYSxqQd1nBTHuPaqfDDW6MCDNbYclN9GNyp5yp6lnXxgDAmkNgneAeJEYklq4VvcVM78iNIoRiBmdHnBYdZsBb0nSLpDrc2lN1MWokCqQxutTifK7XBBUwFBdr9LH6irwkR6MUnpmngBxi+j0jaP+zu7180G+ND8Nocb1CZFxHryLMhYVN+jyy8VRgWRIDS7buTRAN89wPrg17uVKo1Q1ogIyn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(5023799004)(4143699003)(6133799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHI1TmZSSzZROEM0Y0ZjbWlYbHFLN0tCbTVKeWtaRjg5ZTNjbUNvQVlOS3Y0?=
 =?utf-8?B?OWp0emp3RVo4WXJtdkY2a0k5dzV5WTF4R1FXNk0xd01VUDRQM1lBQ2tlT0ZB?=
 =?utf-8?B?bVNSZTRDQU1DTEN5TzhVL2ZTRWpnOEpQRENLZHJLSkVFTzgxVVlacFpzN1Fl?=
 =?utf-8?B?Z1QxazZPTDh4a3RUR2tlK1k4V1BCQ0puMFA0TXlHbzRWbm5yTFNDQmpZdklY?=
 =?utf-8?B?TW4wWWJ5VE40WjFJZ0sxazBFSE1QV0JJQmJyRE95ejVxdG1PdC9wc0swMHk1?=
 =?utf-8?B?aVZQQmsyMVZIM05nQkdvUFBVSFhIL0JXbnVrOU9TUDI1aHZqNEtjalJxYXlR?=
 =?utf-8?B?TDhhMFVabEEybllvSWpUeS9KZWh0aDVLcmlDa0RmM2dRM3lNM0VoNlhkektG?=
 =?utf-8?B?SzNYbmt3RnJVSythTUVGcGppcXU5SVRFbDJaRzY1QzV5SkFzb1NpbDNPRnJa?=
 =?utf-8?B?aUtBSklPRWxSZ1hjME9hMmRjbWRWSEg3emdMZ2VuUFo4ZVltTG0rb0swRGZy?=
 =?utf-8?B?aGpITG9VV0hCTG5pcTM1UjBaenlFa2pDNzNrVS81SlBIRlYrbTc0SDllRkp1?=
 =?utf-8?B?dGxCazY0Z01Zek1waFM3V3p6ZCtMT3ZVNnBkU2hIUksyeW0xSi9RbkpweG5w?=
 =?utf-8?B?Y28zYUxTQi9XcVlIWFBaMXo3U2xNdzdldmdEZnZPK3FxdzFKVlk0RHJUZWtw?=
 =?utf-8?B?cCs0U1pOL2ZmREs4U1c0aUtKOVJGcktWVndmOGQ0VWxuWFJLb0gzaFlNWEJy?=
 =?utf-8?B?NUdRaDY2RTJTTzJDZzMyYUg0bXoxcnlYS3BXVG93OVk1cS9FdXRnK3FRWU9I?=
 =?utf-8?B?aUpIazdGZUYzY0NUMFAwUHY5ZEF6d3YrWEF3QldTMU4rYjB4WUhZTVlWMjQw?=
 =?utf-8?B?VkJHdlBSWmRZeUxHQkpKd0NhRXFMSytuR2MxQXBzZ0lUTWI1a1ZrMVpPcDZj?=
 =?utf-8?B?SUVSNGpaTVYrQnVLNmpCdEdkVENqeFR6WjRDaUhKUDgvNWlITmdIS2UyYU1n?=
 =?utf-8?B?bUNnVmlNRGlWWFkreDRrVzdyZldSQ2pEbmtpZFkxbkhBM2NZNjdWa2U1bVVB?=
 =?utf-8?B?V2FpaXJzRUo4VDhidS8rT2VBeWRId0NDNWx4VU1wZ3ZZU1dnZTg5eGhieFR3?=
 =?utf-8?B?MFlSdVRQTUkxY3BTNzBYdHFiZEJGQWFROTQyeFBNUFhVUk8wTVhoNERXSDhJ?=
 =?utf-8?B?TUlmZlZ1dTFuRFRHemtCVy9SMThXSytMSDlEUzAxc1FFVlZpRVFIbm9vSWNZ?=
 =?utf-8?B?cmVUYTN5bjVHQ0cvTHZvM1FMWTd4TTc1dGQrcUl1alhjUWxqZjJ5c1VoQWVP?=
 =?utf-8?B?WGx0N1crSzhSd1N5OG52UXpWUythWmttOU96ZHhsbDhrckY1Tml2bzZobTFO?=
 =?utf-8?B?ZlVINGpRcWNodUpaaW9HRUx1OWhsOW93QkFOZWlRZzduOW9mMVZxT0ZyMWwy?=
 =?utf-8?B?MkcxVnp4TVpqcy9hRHZWdENlMjFUdzA4VzRGaW0xZ29sVUlDSGJyM2xDVkhs?=
 =?utf-8?B?NnpMY25vcFcyd1hFOUZyakpua3N1THl6QU1abGROajYxYmp0WXF3SS81eDJG?=
 =?utf-8?B?Rk9HcE9CMU83UHljcDlVa1V0WGZhVDkyVnRkNklMSmxiWnRDVlJWeGpCK2pt?=
 =?utf-8?B?UWpVcFZPWXZUTGs2N3p1ZTRVMGZQSTR3azB2NEFQd1gxU2pYdzF3bGRvSlBC?=
 =?utf-8?B?U1ZMU2pUT3BEYnFIaVAzQThlU0VVb3ZNRm1meTdiYUIxSzVTODAzQWY1S1kr?=
 =?utf-8?B?ZkVQb3NHY1ovdVVJWERuRUNWdUs2bitLc2tEaGVxT1FiQUxGZkdtc0RIYUZZ?=
 =?utf-8?B?NWZhWnBHeUhvVkpTWFJieVUyV1luTGc5M1BVdWM2UnFraW45Q3FMMzJBaXE5?=
 =?utf-8?B?OFJBNlRTeXhjZFhOYXFRQmx2SVVqS252NTZyNzg1RzMrZE1DOEpWbS96Ly92?=
 =?utf-8?B?U0V6TEY5eWVUZU9QcVBQdWlNSkxiT2hrbVVtdFFSODR2TGhJS1ZDSGpmb0U2?=
 =?utf-8?B?UnZsQ2V6RmN6ZnExYytzRDcvUnduSDlTeSsvaDFMZ3dKbnFaNWVtRWJqamYz?=
 =?utf-8?B?T1l3STBQUnZ0VDZBZDdLaGFZU3VnZEFCK09ELzc5TFRUbDJ3Vzg1eXR3UVRP?=
 =?utf-8?B?RDZUSStya0F3bTFVeFcyd1hPOVBZRnBIcDNsNE1RUkNTU25xNnJWNGtQejJ5?=
 =?utf-8?B?aTYwVzNibEJiOWlUUXlOWXl1Mm5DVkJmQU9nc1JYdGU2QmlxdGx4Znpib1Nj?=
 =?utf-8?B?dHBHZzFLM0FPbkhkVXFGZm9tZlJpTm1iMDVGS0c4eCs5NEE2SnFGeHg1cWRJ?=
 =?utf-8?B?SmI4L3R3Y2U2SFNMRC9hODM2TDJrUGZQa1IzQ2R3MzdWSHBTS0pxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b94ca5e-a0e4-451b-dd2b-08deb872759f
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 02:24:47.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzBflc7svSEd7JXmdPaRajC2Np03NwYDD3MIw+znjqghggzDNSBdaJ79zLPtbWSiGmOUZyK1D7TrgugTIzXvbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

On 5/22/26 7:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Reference leak of `xe_exec_queue` when the execution queue width is unsupported.
> - [High] Failure in `idr_alloc()` leads to a leaked sysfs group and a subsequent Use-After-Free of `oa_config`.
> - [High] Exposing file descriptor to user space before acquiring device reference leads to potential Use-After-Free.

These are all pre-existing issues, and thus out of scope for this
patchset.

thanks,
-- 
John Hubbard

> --
> 
> commit 8e3552a6815565ba8e84e67fba6937312f269a6f
> Author: John Hubbard <jhubbard@nvidia.com>
> Subject: drm/xe: gate observation streams with perf_allow_cpu()
> 
> This commit introduces xe_observation_paranoid_check() to wrap
> perf_allow_cpu() and converts the open-coded sites in xe_oa.c and
> xe_eu_stall.c. It ensures xe observation consults kernel.perf_event_paranoid
> and the LSM perf hook on every open.
> 
>> diff --git a/drivers/gpu/drm/xe/xe_eu_stall.c b/drivers/gpu/drm/xe/xe_eu_stall.c
>> index c34408cfd292c..a1fd7dace0a61 100644
>> --- a/drivers/gpu/drm/xe/xe_eu_stall.c
>> +++ b/drivers/gpu/drm/xe/xe_eu_stall.c
> [ ... ]
>> @@ -963,9 +963,10 @@ int xe_eu_stall_stream_open(struct drm_device *dev, u64 data, struct drm_file *f
>>  		return -ENODEV;
>>  	}
>>  
>> -	if (xe_observation_paranoid && !perfmon_capable()) {
>> +	ret = xe_observation_paranoid_check();
>> +	if (ret) {
>>  		drm_dbg(&xe->drm,  "Insufficient privileges for EU stall monitoring\n");
>> -		return -EACCES;
>> +		return ret;
>>  	}
>>  
>>  	/* Initialize and set default values */
> 
> [Severity: High]
> This is a pre-existing issue, but is there a potential use-after-free
> if anon_inode_getfd() is called before drm_dev_get() in the locked stream
> open functions (like xe_eu_stall_stream_open_locked)?
> 
> If anon_inode_getfd() exposes the file descriptor to user space, it becomes
> immediately visible. If a concurrent thread calls close() on the new fd
> before drm_dev_get() increments the device refcount, the release handler
> will drop a device reference prematurely.
> 
> Could this potentially free the DRM device while the original thread resumes
> and calls drm_dev_get()?
> 
>> diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
>> index 6337e671c97ae..f15847be01bc2 100644
>> --- a/drivers/gpu/drm/xe/xe_oa.c
>> +++ b/drivers/gpu/drm/xe/xe_oa.c
> [ ... ]
>> @@ -2052,10 +2053,12 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
>>  		privileged_op = true;
>>  	}
>>  
>> -	if (privileged_op && xe_observation_paranoid && !perfmon_capable()) {
>> -		drm_dbg(&oa->xe->drm, "Insufficient privileges to open xe OA stream\n");
>> -		ret = -EACCES;
>> -		goto err_exec_q;
>> +	if (privileged_op) {
>> +		ret = xe_observation_paranoid_check();
>> +		if (ret) {
>> +			drm_dbg(&oa->xe->drm, "Insufficient privileges to open xe OA stream\n");
>> +			goto err_exec_q;
>> +		}
>>  	}
>>  
>>  	if (!param.exec_q && !param.sample) {
> 
> [Severity: High]
> This is a pre-existing issue, but does this function leak the xe_exec_queue
> reference?
> 
> Earlier in the function, if param.exec_q->width > 1, it directly returns
> -EOPNOTSUPP:
> 
> if (param.exec_queue_id > 0) {
>     ...
>     param.exec_q = xe_exec_queue_lookup(xef, param.exec_queue_id);
>     ...
>     if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1))
>         return -EOPNOTSUPP;
> }
> 
> This bypasses the err_exec_q label which is responsible for calling
> xe_exec_queue_put(param.exec_q).
> 
> Since this happens before the privilege check, could an unprivileged user
> repeatedly trigger this to exhaust kernel memory?
> 
> [ ... ]
>> @@ -2334,9 +2337,10 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
>>  		return -ENODEV;
>>  	}
>>  
>> -	if (xe_observation_paranoid && !perfmon_capable()) {
>> +	err = xe_observation_paranoid_check();
>> +	if (err) {
>>  		drm_dbg(&oa->xe->drm, "Insufficient privileges to add xe OA config\n");
>> -		return -EACCES;
>> +		return err;
>>  	}
>>  
>>  	err = copy_from_user(&param, u64_to_user_ptr(data), sizeof(param));
> 
> [Severity: High]
> This is a pre-existing issue, but does a failure in idr_alloc() lead to a
> leaked sysfs group and a use-after-free?
> 
> Later in this function, create_dynamic_oa_sysfs_entry() creates a sysfs
> group linked to oa_config. If the subsequent idr_alloc() fails:
> 
>     err = create_dynamic_oa_sysfs_entry(oa, oa_config);
>     ...
>     oa_config->id = idr_alloc(&oa->metrics_idr, oa_config, 1, 0, GFP_KERNEL);
>     if (oa_config->id < 0) {
>         ...
>         err = oa_config->id;
>         goto sysfs_err;
>     }
> 
> The code jumps to sysfs_err and frees oa_config via xe_oa_config_put(),
> but it does not call sysfs_remove_group().
> 
> Can user space read the remaining sysfs files to trigger show_dynamic_id(),
> dereferencing the freed oa_config?
> 


