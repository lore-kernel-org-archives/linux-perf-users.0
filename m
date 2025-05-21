Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5054317D;
	Wed, 21 May 2025 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747805466; cv=fail; b=XkQsW13cEChSw9saDHv+xR42vyFo/I6NZfmdPZZhLwb2n7E9Ee9/XxZ0zX2/TfAdBWzUZjfZhf9WgXIUOWe4CYuu5Fy7V5RS07S3UhANcyIgQUUjinH69UvGz0MWfuWIVNt5GQWTh+/gFlj9l+Zpn3U2CXMXRkbKQ1jr+DzxWdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747805466; c=relaxed/simple;
	bh=twUeT+zOviDtSS8fvW1bR21ap1wI068Dbfklg46wf3o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Swk20+2sh8vVwGw2g8b15OEVpFpQNBuqhqvzt1+zW+ijBbJA5Gn49TOk7eU7GahhJkApj1mztlJdnNc9wgI0mTZy2gTRZUlkyYVbiFRtqR08lfYnUy9Re6qKNKlk526l7aGI8C+MErOP+plk5iEzVQxQvXThUgFR2U5JgkEu5hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nMUPtifQ; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nMUPtifQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov8OStvi3e2Avv3EOOFVz/vNaATY5mYizCk5nGJvzNvhYdvQ9gvN9iReBftHkTjo3qZoAfDqcjPxwmZQZ7pSDSETWiMtIIDpECQoFk8P3nWZ0dbNp2JcWfx3g3lAMVaT5YvkyHrK+ftEEVz+mokbs+qjZ+MTeriHlsJOgQ43VaggDMBlBhlAHExFPbppwqANI8TVf4/W41rXm93m8rsZs89Gwi9M4SNhYu+zBPmkT/3/NdWrQAxQg9qCqUTtBxfcbYcTGVK3K/kXkdLO5O1WTq4DpvD/BFkkt8zQSHga57o0Fj9SirE8oCKeM2h3Cd+7mZdQka8Z0cvG6oUYI4l2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fI7myCmLpMpW7zwLUWO8GADf0aw47OwNIL/QpCH17Ek=;
 b=vXFDwjB4ukEHWAEK7RZ2LPf6Qbt9O61syiZsyumTWhIPFLpTBsfHplR7hvbUbMJamfBT6kmGzuUTcK/M0fg6RPeSul32LPDHIhX4ddJ8Uxs/mUv/ZBnM723YWywaYYf/fESPyut1bb+WTv2RSQxudvRT3TPwLMmM1NpoTeGrX9OOAqyp6Sk2qpj9DAFAxwtpXvKxEAav9b+5Eh39tY2/UCjEt/c/IzNBoW4mxPed4gEpMtLmPjGnB9yju8ad/9GBI2D79J6OF69cKH47u9VWC+yK5lUrHJ+pzeQN7tWDx525NJvivuBG+auBiTRwe0uUaJun5l6wAjX9XmtbDQcrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fI7myCmLpMpW7zwLUWO8GADf0aw47OwNIL/QpCH17Ek=;
 b=nMUPtifQ30fjicSwF4ZREob/A2UDeMKhDOG+pfxmzpO1cmkVm3nri1PnThvalqo3mMdPBnY33oHe4/tBflz1JyH5SpYX8uHS5LHnlvI1UUcJwelObsRjGsiFuBmXJn9X7rFeipDGjxjGxvZuvsAbVTZDrChTQhEu2DyjaYFnxmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 05:31:02 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%6]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 05:31:02 +0000
Message-ID: <82853f34-cd5a-43d7-81de-8e40144503e1@amd.com>
Date: Wed, 21 May 2025 11:00:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: perf/urgent] perf/x86/amd/core: Fix Family 17h+ instruction
 cache events
To: Ingo Molnar <mingo@kernel.org>, Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
 x86@kernel.org
References: <174740303900.406.5499797802401271693.tip-bot2@tip-bot2>
 <c409c331-da7d-7424-e0db-a4c61ea423ca@maine.edu> <aCiI4lcWIe6GYW4_@gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <aCiI4lcWIe6GYW4_@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e94b16e-c638-46d1-4cab-08dd9828ac7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak41Q3BMN0ZwYS9GTDZ2VEQyYi9Qelc4QVJNRlk5YTVQWW9qZ2lyeFllOGxk?=
 =?utf-8?B?S2x3WDl1Zmk1VmZKMnpHdVNPbnZsdVF6ZGRldFVXV05SNjh3UHFNZE1iQTVH?=
 =?utf-8?B?bXdlYkFRZ1JtcUkxelNBS1lUNUVJK01lV2FwcGQwTWtzMVo1M0Mxdm5FMGF6?=
 =?utf-8?B?SkxSVFQzRTdyMDdFRmJrYnBOVGtQaHFYVU9SZEVjZElncjlFZnFsZ3BMNmE2?=
 =?utf-8?B?Rm1yQUpxaUdsWkZxa0pPalVNWGc4MXBCaHRZRUphcTRzUnFsKzhOOTZlQjdM?=
 =?utf-8?B?Z0RpNXgvK1pyRk1zaWVlVExDQSs4bGIrM2t4TDNZQ2ZDKzFkSVYwR292TDJX?=
 =?utf-8?B?eFpyRGJrZmFTSHR3cTJESlQrT1czWUNDd0NuZmlicm9CVlhtSVRTajBvUHM4?=
 =?utf-8?B?L0E4YzRxcEJVQ1llcFJ6VWNvbnFhZVVuNzNkcmVRSnY4dHRmcmRhY1NTbDR2?=
 =?utf-8?B?eGU4ZktIOUFkNGNndFNVdkIySjE0cmFwUFRUdWU2dHFkK1NjS2oyay8zVmJH?=
 =?utf-8?B?YXJGbS9RUWUwdUlBeFJMcmpPT0pqS3ZkMU1oZlA5NDFkVE9jNHhUNVZDZkJX?=
 =?utf-8?B?M0hUR1gydmNrMWxTcmVvallHTnhsZkg0aDNEUXVJRFBxcjVVRVRtZkRyM1ds?=
 =?utf-8?B?MGRjOTRBQkRvUkY5elJMTkt5dHo2aGZacVVYT2RxUGFaN3dtRkNYbU1kdUhQ?=
 =?utf-8?B?bEhpcllYeEQ3S2xIZlRIcUtRU0ZhL0F4Q0dwdWFBR2NBSmR4eUdTRlg2RkhV?=
 =?utf-8?B?cVlSdzZEc1RRQi9MNnZ5VEFhcXpDdVRocFdNUk4wNXpZUjBpY3dWbUNNdHM2?=
 =?utf-8?B?elllSmsvL0NSaTM1S20zdmpUSmdyREtVNHBoaTZ0Nkw4Z0Rnd1Z5UTZCNGpX?=
 =?utf-8?B?WlFMVC9hdHpaVXFuOVA3Y3A1dWdEeHlLVzN4cURETUZLeWkxOGlZVWU5RGVV?=
 =?utf-8?B?elhtTXhDaHdqVUx3SHg5Z21ycEwrU3I3RW1TZTZQU1F1QlZZekdBdVBHNnNv?=
 =?utf-8?B?L1FKSkNuTU9wTWhEbkhsdDBZSXdXWFhVOWFLNmdLV2ljVThZbVJHd3g0Nkgx?=
 =?utf-8?B?S3pTRHVoSGJhMk9lS2svc0NVcUY4cnVSa0JybWw3SVl6R0VwZ3NQY2doWUtp?=
 =?utf-8?B?aXpkOHl3UmNWcmtSQ3BhRHNaYUdVd0hXTjJrbUs1REplb3YzMW4wYUlmai9X?=
 =?utf-8?B?bDlVMEFDTGlkZFh6MTI3VGppOGswRG5iYkNXSkxiY0hqWWtGZ3pGQktTdkFl?=
 =?utf-8?B?dkZja0V0SGtDRTdkQ2pQNWlZczRoR0JxT0t5d1hoTmZxbFBxdVJUK1p6cFhD?=
 =?utf-8?B?bFg0bnZRNlRUWVZ1c2VqZ0pXbDF2dVRxVUswT2pnM2VLNSt2c2ZseVV5LzJF?=
 =?utf-8?B?R2IvUVk4dDh6TlkwbiszUSs3OCt2Z3lTR3ZOVXBVOWd1NklwY3Q3OGVMSXVM?=
 =?utf-8?B?MGNacGUzSWRIRnhYZzcxVW1RRFJ5UFI5ZE81cjVSdWRDU2NTSFJWVUp6bGp5?=
 =?utf-8?B?MUgzOG13dWpHTXUvZThOTUptdFhhN3QrZ25zbTBlMVNLQWdibmVCbkR5NU1a?=
 =?utf-8?B?VFd1TzRkdVNvSjdzbHdtQ3ZjcWlPNis0aWwrQ0w4UEJXZkdGUnROTEdXZGlK?=
 =?utf-8?B?RVJmUXpUVUZEM254d0M4SmIxV0c1SnkxUDRaTHVUczRtVTRDVjRwV2oxMHBx?=
 =?utf-8?B?eUoyd0V5UWtuTHlLK0RqZVA4NzB6Mk9pQjltWlo3MlluOXptSEIzZ2JJRDRZ?=
 =?utf-8?B?V2sza0c0Y2xWVVcxN1FGRU9JcXUwcDFFZnR6UDI3WEh4bTFBUGlXRm5NRWV2?=
 =?utf-8?B?a0FGSkNITStQK2VrZWsrWktQVDVQYWJldTR2UVEwMXZYQzU5VXV0VVlNUU1J?=
 =?utf-8?B?ak9uK3dMemNPSnBXY2NYWllYN1RJWW1WYnkxTk5Vb3IwMXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDczdXVUZExEcHBwblZ6M21sQ1o2TkRXeEkyWGRVbmxnM3Brb2E5VWg4ejdz?=
 =?utf-8?B?OXNuN285cFUwTnNma2d5ZnJFOWdJQmU4cHdJT0djb2V4TTVwWGlGUEEwUXFj?=
 =?utf-8?B?OXc5NUN1UWxlOU9NVnFZdUFleVBCSldoMEJJRzA2VjEvVFQ5QnBnNVpMU2lF?=
 =?utf-8?B?ckkzSUtVeHM0STU1OVQ5Y0c3TUhkaEQwS01Sczdyb2trL1EwRVdlUHQ0L3Nl?=
 =?utf-8?B?TU5QcERpR1FjNDlLL1VDb0l1RUZMRmNqT3p4Q1V2TGZKRE15TkkveVFxRytV?=
 =?utf-8?B?eVVnSjBxZ2ZlRkxxY1FNNUllN0tmZ0xGMTlacXcrTnJTcDZLT2Q1NmN5Umh1?=
 =?utf-8?B?c3ZRYmU5MThsRGFBZkxpQU5zd1RaQUJKcHdrVTJEdDFrT0hmYkFGMW5FNDh2?=
 =?utf-8?B?QVBuZEJ1NGc4MXFJQWpWSFdDM2NGREdRZlNsbTZqbE9TVzg2MzQ3djlDN3Ar?=
 =?utf-8?B?b3MrRnJVWm1tamk2cWxFV0hvZFA5SXFUZ0ZoL2FBS1pCZ21DVUgySFQ4cWxC?=
 =?utf-8?B?b0pyK3ZJaXZZTGY4N0NVL3pxQ3dPbU80R0RPV2Q5Q095dUt0WWhmMWdEZURD?=
 =?utf-8?B?S2lSMVdHd2xGOW9hMlI5WGYrRGJwbFA5QmRxVko4dTJuSVEvWEM4VHdwTndh?=
 =?utf-8?B?UERqMzJVZkIwSjZWZkhGV2tWK2J4am11WG1OTE9kRjhNNUt6ODBCVDQ4NnJr?=
 =?utf-8?B?N21iTkoybjlsc0xyeUtqVGF4SnE0WWlUNkNaYjhuaWkreDJENVZRb3N3c2tO?=
 =?utf-8?B?MnFWcE16MStDcWtsSFRKU01iVnJkZWJiQkdnREV3YXhmWUEwdzJRT25Ia21u?=
 =?utf-8?B?eEJIejF6Q2NjRTAvTUlKb0ZLRGgyYjJreFNyUjdTMzZBT3NwSmJrY0NSeEgv?=
 =?utf-8?B?KzdWRUdkMlFaOG4xaGVtbUV3aGg0VUJjd1NyQWtvM1NnRm9HSFNmSHBEa1BQ?=
 =?utf-8?B?R3pEMlBtWmEyd01TWmVkV1pPTFpqR0ZtZ2xwOXVzckdnRDI2VDZDcGNtcjFy?=
 =?utf-8?B?aWxaMUN3SVpUZ0VWM3cxRXlzblpqSStidC9RQUpGdVRzeU5kZGZVMWhmYmJn?=
 =?utf-8?B?aHEydjM5UDFxbEVwb0dIT0E3U3VOZEdrS1c2UlBVd1owNEpCSVFYTzRyS3Fs?=
 =?utf-8?B?NkpoN05abFJmWFd2RXlHbW1OZU5zYWlYODJSV0xYOGhLSlF2ZFNsd2hhdFBY?=
 =?utf-8?B?VlU4cXpRVGFENUJzaWhidXd4ckFYMjlZdHp0MjVKRW9jSmlZd0hJYW5iTW8x?=
 =?utf-8?B?NGNSSU9nSE9wbFpoSWZVUFNiUnlqdzVNR1EzWlhmYzV4dUoxZGg5c0hURHlV?=
 =?utf-8?B?RXluVWdJV3pVWFRnUE1jU2xxWTJNQmRFVnZJcHlSZmlZRXQvVGFtM3ppZ09v?=
 =?utf-8?B?ZTl5Z2tnZjQ5cFk4aFN4N0theWFlTVlVL2s4TzJMYkNXTHJSOWFqUTFnaTI2?=
 =?utf-8?B?cGxzLzJUN1BsYmxFNXBlL1l3MXRodlRMalFjejBLbHNIM2VVK3E2N3VlYnY5?=
 =?utf-8?B?dUJmMWtZUDc2OS9UYmpIU2plQ1lGM3oyRDFzQzh1WUYxYUcvSWd3L3BKUVlK?=
 =?utf-8?B?NHBpblFMV3hPTEpvNm5kTUtjRmk3dEtpdVVydnRhWXpyZ1FQaVh0SzZxb3VW?=
 =?utf-8?B?bUJOQytHNmlRT0ZyOURMbGFjSGoxZ2M3Qm5VQ21ESVkwY0NJTkV2aG5EbEY5?=
 =?utf-8?B?cU1pd3lEZnRNWkdJY2o5Qzd3T3V1d1VZU2RENk1vcnJlTEo4YzFDcThqMjZK?=
 =?utf-8?B?WEplU0tjdWxZYVd6M051SVJKZUhDZkdnVTRTVjBMUnUzL2tCd0xENmhqd2lv?=
 =?utf-8?B?eHR2YU1vV09oODZNZVgvbmdSa1NzMUE1elRPYjhnWUpvRmhZSjI3dmVhRmJ1?=
 =?utf-8?B?VzNlbXcyeS9TdTBLNnlncHVoTzA3UnFtamVQOG9HUk9aY3NkdUcvTnZMc0VC?=
 =?utf-8?B?czVBcVVLeTIzS1Ywc1l3QWRTM2cyTTlncEVMK0hQNXJIdHQyWWQ5WlZONHBY?=
 =?utf-8?B?RzArdGc0S2NVcDU1TWlhVWFXbUhsWHhEVHlKYjFlU3hTUS9xMndRUWFiYzJZ?=
 =?utf-8?B?SXMrWWpqZ2ZUdEJteWtpTklCV1dNRUN4ZHhNYzg4VCtVN1J0dnBpa3l1NTlU?=
 =?utf-8?Q?YG9bUj4dS7MlB3GmcGBrPMKm3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e94b16e-c638-46d1-4cab-08dd9828ac7e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 05:31:02.1044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbajMabsJiv0GzVJx1BQmaidGplxKiVxLZXUOZApErHgVihU11YFJLeOvTNilo8xMi2oLamvL/2de2bhlsur2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

On 5/17/2025 6:32 PM, Ingo Molnar wrote:
> 
> * Vince Weaver <vincent.weaver@maine.edu> wrote:
> 
>> On Fri, 16 May 2025, tip-bot2 for Sandipan Das wrote:
>>
>>> The following commit has been merged into the perf/urgent branch of tip:
>>>
>>
>>> perf/x86/amd/core: Fix Family 17h+ instruction cache events
>>>
>>> PMCx080 and PMCx081 report incorrect IC accesses and misses respectively
>>> for all Family 17h and later processors. PMCx060 unit mask 0x10 replaces
>>> PMCx081 for counting IC misses but there is no suitable replacement for
>>> counting IC accesses.
>>
>> can you link to the errata document that describes this problem as well as 
>> maybe give a rundown of how and why this breaks?
> 
> I've delayed this patch until these details are cleared up.
> 

Both of these events were removed from the Processor Programming Reference
starting with Zen 2. Errata is missing for Zen 1 but it is known that these
events are broken. A quick test like the following will show that PMCx081
undercounts IC misses compared to PMCx060 with unit mask 0x10.

$ perf stat -e "{cpu/event=0x81/,cpu/event=0x60,umask=0x10/}" ./ic-miss

 Performance counter stats for './ic-miss':

             2,105      cpu/event=0x81/u
            30,826      cpu/event=0x60,umask=0x10/u

       1.650143599 seconds time elapsed

       1.646070000 seconds user
       0.000998000 seconds sys

If its acceptable, I can send out a v2 with the details above.
