Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337354654
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335340; cv=fail; b=hBNn+JqX4sFEQJdM0m0UgfojqNyC1fzqQ3UpNx/f7o7txDEYAc+I3uWiUEqVk5NQjFov4h30EtM3oxdDxoP2kOtLeod3Jnq7s8y0NUtD2Dx8cNGd3hOpKZB5XtTjIYr2IPZmZ5X2ZSo5JfqIPy/3P01Buw0WikCQgw+Xvth7lz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335340; c=relaxed/simple;
	bh=t796YCCpLVzHOmZ23ESHEYSYZyTLDN+zpFKNT2ycYII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tcG0dHpPpwj3y7TFe1eWVx36byyBk6CwXTD9LIlyfjC9waYlkHNyA68K7q18IpDHYeyc3rBybzP2sJHqPEAwlAtgATWuNfFIq84bkd2Wr8aFd4BM4JV1sxp+xTb4QCKm5RvbYwBkNSZYKIhe38mWVz1oS+12Sx8BSPP0DKQm1rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5SW+ixM; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5SW+ixM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZz3hQrL1L/N4iRX3XOSLAjGvmNef6/zeDcgFNUyRd81549mQtz/8qCNoUlNxauUGRFrWnA6yCThwhZhpEoNVC/n1SpInrI4v2OL3bkgTmqRSBSbYmOnWdmD1B8DkqfYLlL7w+/3gRTIK0pRvm/cTce1+6V6DppTdd+66FHjbzXdRreV37or1IWoKiuw+847bbOy4O0FpDAcW9O9EM1OF+ULfszrQ0IXvuUV9gbrTtQktNqyOox3EQ1HB0yCLJZzPl6MFVqp/IThP2yD0A/6CiXUjCmCB4fSRjinFcHU9Hd/WXcC8gEKdyWwV9UVCeSROEE30XVWAgzJMhRzLxrMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge9YdNSEb0l+0go0F2SZhInjdhlJ/jD/u/HRVLngcqc=;
 b=d5BzFa5rv3w/ROpAL0KBac48U77dAgFRRDQQWl1tkgavlhP+fvxkRLYoaY+wP/shwhMV35VzdVfIzGuXx5pbLJGST792nntKVK3y2xWtYLYu8SUpIBU8Qdl3Jmm+TkQUwGPoYeNSyTxm9oKM6l3jECkwd1mG2iw0Vy3fLj28tCX8Sub56WWAbGVGsRiWh4ksbSJBQX0rHbdWQp2mqgw0zuMn1xL/VZRlqL52WptM/GInsi6HE7nmZDXWJWerSCU8sDCeCpgATZuX0EMd4BTWB3HHetWxVSUxMIUY7YYF/xjHSrWp5A11/HetE/LB7JmA1YejwlvIJ9AbzFx7iluu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge9YdNSEb0l+0go0F2SZhInjdhlJ/jD/u/HRVLngcqc=;
 b=B5SW+ixMQsUJ6iFUjJodWomeO0zCXAT+3wbvWdHd3DdnIIWPQ9iJKPXy8ZRWGawmZz20QYb3B/0kShFtW3o1BWoCO9UbQnc9EXlvYtb3kHjqN6UGOtxu5XnoxOXnZlrETuG+vdMys6weK0CeztpeYxtySpRQedoJMI/zLxzkxjDPKsg3pOG3zw+IXpUOBxkr9atuXXl7Cfgb69RoKpBpe4XzBxywa1mvruQnk4IXIi7R8KRYM1tAXoYWYkrTaxn6zZU/IHCCbwdWgvW/KuOUHLBvRp4U0CGYuUgVxFHbCF6juhc3MiitRw4YHK5rPlCeUwsZzAy53w5HS4/h6/gbvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 IA0PPF6483BC7EA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 03:48:53 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9913.012; Thu, 21 May 2026
 03:48:53 +0000
Message-ID: <4471e290-a20f-4d44-b479-d378ee561388@nvidia.com>
Date: Wed, 20 May 2026 20:48:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/xe: gate observation streams with
 perf_allow_cpu()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260521024904.331912-3-jhubbard@nvidia.com>
 <20260521033048.C05411F000E9@smtp.kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260521033048.C05411F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a584bf-4caa-4194-b294-08deb6ebe08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|4143699003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	DvXfxjwkSWqooyEffqCluAXK0Wg56neCYge7vGntcC5cW4j1xTBmV0nJqysTTRo3+CyIEgn6O+QuwxSjDcWodDYRDx+IHEHFG7W/8bixbzbktMZO7j3hFav2UHpUbYavCVYVv3H5ze0BTRlSka3Mf8evXTMijqRk7ZGAJUPrjJSXNtQwO3VP13pKxFknLH6H37q/w+VYQvBhDn6Ce9FwS/aLxB734dCJ+1jZBu1k6VcvGpYJCfAB3j7rs6vEyGWSgrlXu0S/u2pRusfFc8H+lg32QIEQP3UcCoCHgcAv9aFVEJ0r1d3BUrG8AoPbu9kS10E/DqVubmW7Ft1XC3WPTkOe8JJqa8+l2pakIOSswi+0D9z0mbYm/UBNNf6C86h/Cy/N0x4JEAIs1PQ6n2IMwauw4/l6hwJ42Apo4oMj8M4d9oEUcyHx+zYbe6yeBzeuE9gDUZ+l2nBL4HCvsjjeEpJoigOMh+uJGNFNZh6cf8yWWvlWSLUfeEazNWqHwcVsTEthk44RDcev1LoSoKwJr1QVXzJcfBvHcIhLegIhvPt3+q57+Fx8pYC2V4HLspF+uszJpeuDy3L4FnXRyRi3myLqQlHkP25hnx6Z61+aMEOkO6HdCFBk7BerMx8HT58vV4BHjXL0rUqhQ0vTlKEVoZnSzhjwdU4c5L/HPRO7302UghXo4J8YRY+xDeR83MR4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3pRTjUrZGRIT0xZSnZqdDB0ZjFlVThWUHh5b1haMDZ3a2tNZEdjeStVR2VS?=
 =?utf-8?B?U2s2Qk1FTlF3eDd6eHl0QnNBeCswd2VWTTA1YkVVS09DdER1cFBVNk54VGtF?=
 =?utf-8?B?eVVDQ3Ftd0R0Y3p4VDl0TDdvYiswbEdWdWViMEd0d3FXN3V4cVBQWFM0MmRS?=
 =?utf-8?B?K2ZyZnVrdDhiaDYzUVpuUjZmN1BEMFBnQldtMktGYXcxNWVEWEczZ0p6NWwv?=
 =?utf-8?B?RCtMaXpudFZxQ0g5YTJwRTgxY214R1FKTFFuZzQ2TzkwM1hFRGxqenNqWW15?=
 =?utf-8?B?MW1aWHFGU3pWUFBQRFdmTTN6aE9nMzZzbjZRcUNMUEg0bDdnenlMNy9mdzh2?=
 =?utf-8?B?eHhadHZlMVJseHVYODdHZms2cCtzdlhxMWlRcktNSW9HS0FNSk5zakFVWUVl?=
 =?utf-8?B?T2twbWNVU0Yzd2JKL28zY3pTOE91eWU1L3VJcjN3bGZUUVhRblJ3NVpVUklK?=
 =?utf-8?B?dVNuNGh0NGRTR2xlck9PcG5TTjhrRzFsOVArS3FKSE9OMnZxSkxwTURCSVFM?=
 =?utf-8?B?dVpGL0F6YzdXaWY4SE8veWU4R21OMFBsUXJLZm1FRmRMSjdBK244bDFkRks4?=
 =?utf-8?B?NFF3TlZiSVdLek9PVXZ2djFVTjZKRHRVZWg5M2w1NExFR1BKdXBtUklDMnB6?=
 =?utf-8?B?bFVubWJFd3JibGVkbjZDeDhBWWFENldwUk1aeEdqbDM3aytsbmxlNjFyYjYy?=
 =?utf-8?B?b2thdi9xYlFyWjRwa3d0b09uR3UzaXlkUWV1VXBFdGhZdlppb2JydnVTWUEx?=
 =?utf-8?B?UUpmb0NsT1k1NUNFeXJMREZXajJzQU5aNjltZWFrSDNKYk12VVQ0Rmt2cFgr?=
 =?utf-8?B?WTd4U282RnpEL0VWemJwNDFwaTlZYTgvL1k3NGp0c0dDUk0vMjZjSWQ2UXdh?=
 =?utf-8?B?U1JwbVUyZVE0OWNHckxRek9tNWVMMWd0UGZoV2xrYkRlZnlmRGU0THVQdWRD?=
 =?utf-8?B?ejk1UjNISDZPZUlqWWVENEI5bURLbXBVWFFKUjZaQ2R4UjY4Zm4zeDU5R1Ex?=
 =?utf-8?B?anEvS1AzZ29jRHJxMHZYVjlUT1lhNndrNTNOVS9wclkyWnE5K1AxYnpXTXJ0?=
 =?utf-8?B?T0dTUGRLclpQZU9HZGFqUnZCQmxSd1RVR0srQXZnWUp6WUZxOGZSbzNSV2M2?=
 =?utf-8?B?eEVTcFZmakdJVVlkZnNIMllxVWg5NVhhU1BGc0JKZXd4ekZhV3dXZ0paTk5E?=
 =?utf-8?B?Z0JLTVlrNjA3K3lBbk8wUlRVYmVEdmJWbi9qa3NNeE51SlJ5TGlpRmNPQXJi?=
 =?utf-8?B?QzJIb0o3THNEWWViU2xFTnVHejB5dlNkOHZ5c0JySWZveS8ydEhDVFFZaHNh?=
 =?utf-8?B?YXI4ZHlxcTR0aEtjbGs1Y0tHU21seVBkaG02SFZHZmowbzZSYThnc000OFAy?=
 =?utf-8?B?U21DL0lwdGZuSXJLSkdZeXVLZnp3NlVnYm10dytjNWRTcng2dmE2dWJ2T1Zt?=
 =?utf-8?B?akpjY3A3QWlIRklEZnRLU21qZ0YvUlE1SG12anJ0TmFHWlc0NlRpZUoxdmFi?=
 =?utf-8?B?UmREQUc3a3lFWkJrOXR6MzZUT2VLV0g2cFU1ZXdKdVdPNllGK0VDN3VoUTh4?=
 =?utf-8?B?cFZ0d2F6SWRiaTQyNXlPQ0NqNGkzM09QdHRWVXdqYW80cEQvM1VIdG8yWWZx?=
 =?utf-8?B?Q3llWmtnU1BhV3I2cEs2RlBFRCs0ZnVhQXdoS3ltbVp4bG5VQnQyVlpOU0Q4?=
 =?utf-8?B?RXU1ODFQczNERkVyQWRLYm9QYmR3MEt2STJOcGtmVW94RWtMOHQwR2FCaG1n?=
 =?utf-8?B?emF4SmprS2FBb3JJcTc0MHN1WnoyUVBaRzVqNnBiSGxNSDRUSFFjQkJxNTdM?=
 =?utf-8?B?NyttUmlKRUp5ZEQ0YWMrTTRwczNUQ2FSdVh3S3h3eFNPMVZLRTkrQTA0TjVt?=
 =?utf-8?B?ZmlUeExjVC8vSkIrMkxGcmcvUjliS2F6Z2dWdnlwTzJXOFBLZXh0L1ZPbFVY?=
 =?utf-8?B?RjRhN3BPZzh0cnpJajMyTkJhVE5COUNuZUozOTk2YXhTbG1OREw2WERVSGpu?=
 =?utf-8?B?NTFLd1A2dEdVVTI2RklFV1ArS29nNDE3Z0JGWUd3a04vTzZWMXpJS0dmc2lx?=
 =?utf-8?B?UVQxTXpYSGJCRkxkV3ZjejNlczdhVVROZzlvcVNwbEkwMkpmblVNa1NzYi9r?=
 =?utf-8?B?MjdNMkJLZHBVSXAwbzhTWDlYck9wRTJtTGJlcFM5cmI3SzZTMEMzWTcvcUVO?=
 =?utf-8?B?Q1Q0dVBsdmsrR1RUKzlidFJTZmJKNEFVOVE0L0F0aHJCN1lDT1IyaFlPbmp0?=
 =?utf-8?B?UFM5eWVudk80SHNueEFObXJKQ3pFUTNFQzZ6bml4WUpBQkY4NzVSSkFVajZH?=
 =?utf-8?B?eEhpOVUvMGdaMlE4RGZwQnZjcU95ei83azllaDY4Nnh2RlN5djN1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a584bf-4caa-4194-b294-08deb6ebe08c
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:48:53.5992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZu/Y9CG1F3nhMQXA1hjnt9a4I3Wm8tBdHUCSW5cmpvZCWbwIdG4r8g6GHR2ACTRcQj+cep4JKCL5bwL2+iLzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA

On 5/20/26 8:30 PM, sashiko-bot@kernel.org wrote:
...
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
> 
> [Severity: High]
> This is a pre-existing issue, but does this code leak the xe_exec_queue
> reference on the error path?

Hi Sashiko-bot-san,

Good to know, but like you said, pre-existing, and therefore out of
scope for this patchset.

> 
> Looking earlier in xe_oa_stream_open_ioctl():
> 
>     param.exec_q = xe_exec_queue_lookup(xef, param.exec_queue_id);
>     if (XE_IOCTL_DBG(oa->xe, !param.exec_q))
>         return -ENOENT;
> 
>     if (XE_IOCTL_DBG(oa->xe, param.exec_q->width > 1))
>         return -EOPNOTSUPP;
> 
> When the execution queue width is greater than 1, it directly returns
> -EOPNOTSUPP instead of jumping to the err_exec_q label. This bypasses
> xe_exec_queue_put() and leaves the reference incremented, which could allow
> a malicious user space program to repeatedly leak execution queue references.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the stream opening
> process leak the stream->syncs array if the stream is disabled?

Another pre-existing issue, and also out of scope for this patchset.

...
> [Severity: Low]
> Will this cause a build failure when CONFIG_PERF_EVENTS is disabled?
> 
> The function perf_allow_cpu() is only defined if CONFIG_PERF_EVENTS is
> enabled, and there is no fallback stub provided in
> include/linux/perf_event.h for the disabled case. Since the DRM_XE
> subsystem does not strictly depend on CONFIG_PERF_EVENTS, building the
> driver without perf events support might result in an undefined reference
> linker error.
> 

That seems like a real problem, let me fix that in a v2, after waiting
a bit for any other feedback.


thanks,
-- 
John Hubbard

