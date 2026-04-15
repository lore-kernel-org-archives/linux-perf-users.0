Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD23016E3;
	Wed, 15 Apr 2026 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233024; cv=fail; b=aNeFakeinWMdRWGgPXh0leg4YwuU9SUtaF9Qhq9TfqQFquFYEAFRm32nDA8+07WIVwiTfOygK59xjZTWp48oS7f8xIOYUW3bt64n8jio76Py19soLG9BsZhgi0UR2Qf2QQZuLVTNiQ2tvwuE4PBJkwucGc1RysBqlrUbDOYt3fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233024; c=relaxed/simple;
	bh=11pkZut9rP6qjblba7WvrsJS+RKSJTz4J/ZYZwuLzTQ=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T6UoknM8hx9efYlUmjryBPkSqJmORIZWqJ44sl3/n3gAsjEeJOQOAoRlBx7ztk/kMAxZhkkIcd1zE66g9G9/mqfvkQ+4W+13ywCaWIIfwNTvhOt7IqlklWFMCS7ZoIXhyImP2i7Uw0JbAhHYza7WEOD5qCw+AJ2Akjbs0hRLuXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKy/toi1; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKy/toi1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eope3U2wIeTRYw6+hEDDuI4rG2rbiyVLSvilP9sGzHAuWzOU3SQBlaH48q7gYUwCruVfhFjYEk60JZP7++RktTdX79XtW7YAVfXk+T8tlzw4kY7+yXk7UL+fwHvhJnvGqfk57kNrB4PXjh4cR8RVMxNdzy5NZhqne+yTcVQYpvc1GhVfBfU4YxoiCkjjagEcnRvBFqrHxtZ5poD8GGzVyFx6hcwJmBgIGLlLTTplNtDJ/omTN7K5zUN34JW/Clp13KJu5MverWG/XME9VCWfL/RBqtPwZyWM1ad/OONmxp9AXLp1LgzxWf0EkrI8+jnOezYfLEmd5HmdTGk7eBvqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqsvG8gX5u6vSibxvCpC3j3YQKDhJ9mYvdUcB+cuHnA=;
 b=XOGfz5dxJ0QIV0xcS3K1Ka2HYR5IroCdQriAsXxVmYFiKSBr34b+ZhG9T1N859mgE8QKP1JwuXMFoxqNoDmaUgbcwsv8wTc5BpQat/1mS/VsRe1GOjs40BtR/qKP2bZny+QyWbYeX02AMYzjbxr1A9XAxxa9EjDRMNggrTIKegIgH+bRTwnsLxwcJu0DKxZ9h+aQ0g4Sk0zVeV1Y/pFl0DZJYWy+5aLd/2OY+BomUMQ9KzNQ2dND4/pCnrIQuExHV20MN+MqM6q5abdWTSB4ehGFUAEBLVCPwXTQy2yljhmQdZ/tNsB0Hv6DowXLceVKwCrKRNXM0NEs/bdaucyAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqsvG8gX5u6vSibxvCpC3j3YQKDhJ9mYvdUcB+cuHnA=;
 b=sKy/toi1xMKJwDUvrxc+t8t1HcZV8Zp9vHG6gkBrWDZQDpYwcMnzPoyxyscuQukA62mT3MLUP6Ou2OcZhZCAmw36DUfMrSg+SAs7pQXHVRy52sxtN+If9F8UW3oxb/D6t9E0xwe3IuIpMRnO+aUj5hQuc8QX3E35SSzDXQucosw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 06:03:39 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 06:03:39 +0000
Message-ID: <a33a42ae-253b-41ce-8a2d-9d9ae58372d2@amd.com>
Date: Wed, 15 Apr 2026 11:33:32 +0530
User-Agent: Mozilla Thunderbird
From: Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v1] perf pmu-events AMD: Switch l2_itlb_misses to
 bp_l1_tlb_miss_l2_tlb_miss.all
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260414175855.2089482-1-irogers@google.com>
Content-Language: en-US
In-Reply-To: <20260414175855.2089482-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0180.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da21301-7fd0-4504-8e1f-08de9ab4bd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UvYiRdBlz+AVbdyL1L3zKZvHXRyz9rRyubq2/ebVbLUC3PZ1rzXYplR5pzio2RI0P58uh3YMw7RI4iGIV6cgirTUdUb5pCUxSS1Ne6AVXeR8HiiMm7nRFtJVyKHnemENlnoZeHCxaTIMlt4YX1LWlMMeMrWXuF0llKIv4M/XubZ0uEXaNq0RfaSzmev4CFz7XgySLMyggXo51LadYdLLMGS7/YbkPRqa6Zuvkpdxo1rOn77aYn57ZDPpgYs/DAIxm/XO6yCQQb8C0LVj9VKZ208YuYiph9JBg3gPxVVHR0MpjvQwY31TU8CzOUqfc3RnbcdyF2Xk0HRVWtT/eWZuJgHu8tqSrYmONhLrsd/HANidXXqL5L5GSScOLWJoRR0ocHGVS0KzERupUS2C22GglzrQowce+43x4+5VMfAfqCS+3SU4t6kM1KcQeNrE1nZjmCFaRGS1eHMDUfV2Cd4PbSCq1IAaIDs8FanyW3Qw9UB5/foqRpG6xGI71MZn98WbXlGjd7elnAS3AdmbPjL1BlTc5bK1RLKliC8pejnu9PSOAa3hsWX5L6V1hGmrhgj6aErERlFz0y8AlyEM3D0OWCRyVwzq0me61tPKKini366u9ud1we3jrcYf7dv3N7+srtnxyq+FCTqNxBcOKqjsACnfZQSu/fwvoULslEGk4Q/j74Vlm1cW/mHIVCmp5BGyaPQdX7sRjGq83NyQX1b5Eqq6/dTsE0BFkI3anH1Q7BJcit30F1I1P98HUF++4qCZ3WJ/RRmwxAccCht/+Mf/uQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVdUS0dGUHJ1cTJmK1BadURtQmZwaUJNRDkrVkRwdUhnNWNQQ0x5TmQ2Rkkv?=
 =?utf-8?B?SFpPcFNDOEFxamhOYnFqQ0ozVGx5cUtUNlRMSUpFbTRFMHR1K1VjbXZVbjVs?=
 =?utf-8?B?ZXYvc0JkTTcwcjhZajFQdXFPWnd1eU1CSjhHN1M2bDJvKzc4NDNzS1dGbVhN?=
 =?utf-8?B?OGNsUXdjL05SWmpMUHBJZk51TlFwalVxd2xzOFROY2xxbmJqb291NHZ0V1hK?=
 =?utf-8?B?bGkyV1JFT0tHeG4xSHNOdi8zaWhSeWJVMWZuVXBTdEFNYVBGK1RnUElhLzcv?=
 =?utf-8?B?K2MxWHNrWDZ4ZHJjUlVTb1l6enhtSU5jUUtnWWxIMnBuVmtTREZ1cFp1WFFE?=
 =?utf-8?B?SGFYU0Z4UXF5OFdaSlI1QTZ4em1DSFdyZnJrb2tMZEsvYTdRbzRrdGN3aFlM?=
 =?utf-8?B?T3lIVXVodTVFNk93dGJNTDM5dkNnN1hQSlVPT2U4aEVITTByek0wc2FuSFVs?=
 =?utf-8?B?VlhhUE5oZ2I0YmFmQ1YweXYyTjdBK1JKSGRVdCtvYXp5bFlZUTVEdm1GTUlL?=
 =?utf-8?B?MFBwYWdrSFN5ZEJST0gyMHFneHcxK3g2TEpBcFRiTE9KRHRaVHVhVFRBd2dP?=
 =?utf-8?B?Vk9IYlRzZHhkK1ZuMFpzQnBaZUxNcmIvSzljTjVjaFBnR2xJMStTczc3S0Fw?=
 =?utf-8?B?SlJDbmRMZjlsOWNwZjg5WlhNWmpUNGJKNURuWGNUZUlmTHJKWGdRWkcxakk5?=
 =?utf-8?B?VStEcExqeHdHaElzN1lDb1VWNXRPeUljVkM1R3JRK0IrTzJBbDVvNDduZTBX?=
 =?utf-8?B?NThmVUs5V2RReitKZVViMDFJbzRxWnRlK1Q5ZkVRM0tmbURhbElMT3h0Nkxq?=
 =?utf-8?B?aWxTclY2NmVJdzhwSUF0dGU3MzRRVmllUWpMei8xaXNpZS83T1ZzMmFHbTcy?=
 =?utf-8?B?ODdmVlBKYnZ1OThWeUpwMWExT0pORTQ1SllrTVRYbVJ5NlRLZFQ1L0pUeUFW?=
 =?utf-8?B?TUFEZXJQbE8vYVcwcTBrc3JzYUhXYzJraE5YSVcvOEs0MzZXUlBzS3VXNEtX?=
 =?utf-8?B?NXQrN0JXQnNoWjNQd2ZpR3ZoNklTY2lzK2M0Q25QZUdxRUtiN1I5ZDlXQXNo?=
 =?utf-8?B?cWhMOGNsVzc5U1BiSkhPdW0zZFQ1OXRmSUI2VWpMNU52SzFpZEFhS20yMFgw?=
 =?utf-8?B?WlIyVlZRcjUyMDZxclplK3YzYUhJSFdNZzNQWHBOVTJQTEhVMTNWQXIzTkdM?=
 =?utf-8?B?c3ZQRmFZall5UE5pK09xVHc2OWJhK1N6Z1NqRkxuYXZ0NHhHTG5lWVdLeTNx?=
 =?utf-8?B?ZGpiYjFoSlJBZys2emc1VkRkU0tLQjRIOWJPNjZPaFRYRWlDUENPY3ptMFZS?=
 =?utf-8?B?MHpMTHJCc3hldXpCcEh0cGdXb3NqQnR2VHFwY1VjQjE1Nzh1cU52MGM1Z1Vw?=
 =?utf-8?B?ZDFNaW5sOS93U1VPQ1ZNMHBwRHVvTVViY3ZiRnh1Rk1zaVF5SjVscERyVFRi?=
 =?utf-8?B?OHNYcklKaDFyK042VTAzbTVVeFRKeGRHK3ZxK1BJQkxpeUl0MDZHSkplelcz?=
 =?utf-8?B?TFcvN0tMeUJuWG5TVTVJNFBZTUllZ250allWcWpXTjRiRnIremY5Q0d2dHZh?=
 =?utf-8?B?QW9YOGlUT3RqRC9wTnlXampDMTM1dGhjaURZQ0lJb08vaU8xY0JTZ0ZEeDRW?=
 =?utf-8?B?Wkx6Q2ZYODhKN0NINHpDK2dQVEorY09UNUFIR2VFMlNMVzUyQXRuNXM4SlFp?=
 =?utf-8?B?bWoxTjRtYytMaE1YVTBtMDNIU1hKUzNSRjgyWjFGWnJPOFFJeGNEMmdnbnpQ?=
 =?utf-8?B?d3NvL0VySkJFQUdCQW5UZGR3S0dHSDZTOE1ORzBLOGM1YUxaUG1yY2VlWjBW?=
 =?utf-8?B?NHkwRkdlV3dUbHhIbTV0YWNSVFJ3WEtqWmhFMUd0NURmMnV6NHcrUnpTWjNX?=
 =?utf-8?B?UjQ5dFA5ajg5YlpTeDJWNmNROGV5Q3NhaWM2aHZpeWlrdmpjdmRPdFpiTEY5?=
 =?utf-8?B?clFUOWsxaUZBdk8xRWZXQisxeXdjSThXYWZ6MHl4d242T1VMTUhJb0w0eHdN?=
 =?utf-8?B?eGhCSlNoN05SVnZOWnA3bHUyekx6OUQ1NG9IWlkyVmhhRllyM0Q5QVFQb3hZ?=
 =?utf-8?B?dWJJeUNwd1RqK2sxR2pVOWQvQ1l1aFBaOUZDQlJSblBYZUd5NW16K2hkTllv?=
 =?utf-8?B?QU1LTVNPVXl0dTB1TVpIbWZRMTB3eFk0ZGdPQnBNTzBJZmJZNTVUMGo2VTZa?=
 =?utf-8?B?Z2dsZ2ZlbnBnSFFqSTF1aEtpY1FkdUgzZUtkb0hWM2tEdEQyUFhHNHRpaWJy?=
 =?utf-8?B?ZjE1UlBkcnVZNm4zSnRoY1ducGdwaXVvMDFDSk1PNGpHUHpuY2ZFVGl2QVFO?=
 =?utf-8?B?Z0FPb2tMdDBHL2xPNTdkK09vZDFkWTJ5MFpOa3dWUUdJS3RuaDJRZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da21301-7fd0-4504-8e1f-08de9ab4bd1f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 06:03:39.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBjMRqQUgYU5wM+BdKGcsWcljROvqRNnqp2hvWQmYm8jDxlb889rjMtHh3ktUFhbOhnSnWVPKPRzFl1He8KYeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787

On 14-04-2026 23:28, Ian Rogers wrote:
> l2_itlb_misses is a valid legacy cache event name, hence allowing it
> in all_events in metric.py. l2_itlb_misses was also a json event for
> AMD zen1, zen2 and zen3. For zen4, zen5 and zen6 the checking that
> metric events are within the json was skipping l2_itlb_misses as it is
> a valid legacy event, however, the PMU driver lacks the event mapping
> causing it to be a bad event when used in the metric. Add
> bp_l1_tlb_miss_l2_tlb_miss.all as the l2 itlb miss event (bp = branch
> predictor, the AMD way to say itlb), so that is used in preference to
> l2_itlb_misses when the event exists. Remove l2_itlb_misses from
> metric.py as the legacy event isn't used by any metrics and having it
> is error prone for newer AMD zen models.
> 
> Fixes: e596f329668e ("perf jevents: Add itlb metric group for AMD")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 2 +-
>  tools/perf/pmu-events/metric.py      | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 63e5098606c4..ee5381646a8d 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -287,7 +287,7 @@ def AmdDtlb() -> Optional[MetricGroup]:
>  def AmdItlb():
>      global _zen_model
>      l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
> -    l2m = Event("l2_itlb_misses")
> +    l2m = Event("bp_l1_tlb_miss_l2_tlb_miss.all", "l2_itlb_misses",)
>      l2r = l2h + l2m
>  
>      itlb_l1_mg = None
> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
> index 0c41a502cf21..c1931b2a5170 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -25,7 +25,6 @@ def LoadEvents(directory: str) -> None:
>        "cycles",
>        "duration_time",
>        "instructions",
> -      "l2_itlb_misses",
>    }
>    for file in os.listdir(os.fsencode(directory)):
>      filename = os.fsdecode(file)

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

