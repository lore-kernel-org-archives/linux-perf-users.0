Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013038.outbound.protection.outlook.com [40.107.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03326ED4A;
	Wed, 26 Nov 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151565; cv=fail; b=I1uGD3ELyXpxiVvUsMbWJcyZGbu8fhQWHbmyBSVtNu7xTQxXqSZycyJRXa0trzfH2Nn8O2dLcevWi4iuMQQiZZiyv5/gt8QLbeFp85z162ZNvQAbJrGz44EnrIcLRlkG8p0PDteGl+5+0xL7YosyeMKGU7Dv4Rh507T7szHTyms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151565; c=relaxed/simple;
	bh=e/adiIjXVorm5BBLqXi6oF0t0KtQie7irLZrDyZCSXA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kzQaapVpFkMeJIHwTfVkZRVBs5bjoEPLs9tjKl1vpOlkQHBhlMl20AGSURU3/CGnRaHH6xwH0LODWwbsg7ezTGz7F3CTOjvHBiXoJzHfFosR+ZcXzRypzaqxP5D+k3pvXdZRzY5ZYEGIDiSwfCI/nTLMOVehmJBqf+H4QF/0MhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1qO95c8G; arc=fail smtp.client-ip=40.107.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1qO95c8G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvxYjswa+dz3pa2CgQkHCvHJEN9TnhiA4vby0bTGzxq2IYJsozvnuguc+NbU4xV7QjNwuVawMrivJGjBid4c0fVVBVGJ4ojuTLr6rP0ELJS3apSF+uCm9NtXqPrBVqZWPuckUrg+Dp5nUtIYHXSbFD4DuE6mlyygGTdzFudnUX5jYNRejeFQBsW9cKxs7vNu36PJKAidLkA3WSNiob2wA7E9J8DY2pFKslWqArPOCZQddRShkLjg86FUcjfhKHSKNQiRjMeot1z/xm3bNGo82YE0o7SGcPihetANbA0YihbmmhZQ1nwDXn37XOaJ50WC+VhfZgnQy2zwrLnrsvO0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/2Dr2I2afzj44k4nvGUl02PZwpeX8odcIJ5qjcQbL0=;
 b=vMHOktYYq8qT2LeszLueAYvuoLJ3NTHviHgQocc/5w1n1OofGxJYhgF7ewB55xPSj+zn/HJoDGCGazhIy8kY624r9mhTdnMehg7g3tut862TfDUZo/0LnFzJ+x3y52rwxX8kr09pfNfmxIHYG5vqkeRB1h3yr2+N9RlYa0gWSMf1I8iUEffwyvIYfV8+cEfkolE+PFIIZeMbhG1niDewoZGA7bSIdBJzb2AXZPDjK0WugkrASOJ1yidGQuZPqKXrw0D2CfFJeC9dLEOt/QE6DblxLlDpF4PLl5EzMYNNQI9DJowjafuWgnfBKLjAHEQGckkrhc5970mxxbR1OD2jPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/2Dr2I2afzj44k4nvGUl02PZwpeX8odcIJ5qjcQbL0=;
 b=1qO95c8GXWhqsibPmMv4aM4hoo7R2wMJ7szWCbwSnBjtAGfYpvgbBdZtfBBnvVx6i9xW9riJksHHkBp6J4F04kx6x0p57wKEDUwh5SbOzk2fpJRDV29NZAhZV4QlTjYf7cyEruybKtZ2j9erUXo9OaAKBTC2zR1lLa6uEPXXZDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 10:05:58 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::bbe0:a58f:b02c:1427]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::bbe0:a58f:b02c:1427%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:05:58 +0000
Message-ID: <dfaccd22-8f11-4fc6-9b36-f2a31affa3f3@amd.com>
Date: Wed, 26 Nov 2025 15:35:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/52] perf jevents: Add software prefetch (swpf)
 metric group for AMD
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Gray <bgray@linux.ibm.com>, Caleb Biggers
 <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Jiri Olsa <jolsa@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Samantha Alt
 <samantha.alt@intel.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251113032040.1994090-1-irogers@google.com>
 <20251113032040.1994090-20-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251113032040.1994090-20-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::12) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 19005ec9-b95f-452a-89c1-08de2cd3651e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnlQM3YxK0R3d3RENXRsKzM1eXBxbHF2L0ZmeFFhNkcwYUQ4Y2Zoc3VLWmpy?=
 =?utf-8?B?WTJiYjBhTkgwbTBuRXFFeTcwd1c1QWFkT1R2YWJNaEFXRlQ1TTBubldFU25x?=
 =?utf-8?B?MDduUTU1VjhPcE91VVRYQzgvcCtGZmxaYTlNcXRrNE9ldDZzbThRcmFXWnNU?=
 =?utf-8?B?c0xqc0dubERraDhGdFFERDVodzNENHBZNEpaODl3ZnBmQmhmV3hxeGQvbGxy?=
 =?utf-8?B?eDlwd241YzgyQVVpUWxNSUJvTTkxcGtsZTdXWGRSOHZjMURYcWFxMjVjYWhJ?=
 =?utf-8?B?TXVPVVJkSExkdjlKUHExRktvNk9iWVR3YngvdFoyWldKNEFBSWxLRFV4UUVR?=
 =?utf-8?B?bnRLeWRlMk1tcHR0L1Zvbnd4SFU1TkpjQkVxT3VWVmZwKzNuT1pyc0twbFZW?=
 =?utf-8?B?c3cxSUgxY2hvcWVhbUI5NjB6RzFFbXJ0YStWS0gzWi8zQk9taTlzakpNUUtt?=
 =?utf-8?B?QXpRb1EzZ1NSbTZhLzNwYllZSUdKTlZ1a1IvS09ZQXRja0YzZW5nMjg3dEt4?=
 =?utf-8?B?dTBPVExoQXM4Z0ExY3Z4MFNqUXBGSDdJL1krd3VaTzVsTzJCaWRNOWM0UnNz?=
 =?utf-8?B?YWp4ZmtPNFVBYWRIMFhDNnEyRjIrc3hwMnJVMGhsVDVkaUlsQzVRVWhXdkti?=
 =?utf-8?B?S21LQ2k0c0ppcWkwZXQ4b0ZDOTVVVElLRGRYMENRU0lCTDNmUWdtNnBua3Ro?=
 =?utf-8?B?VlhybDNqK2YyWEpQVm1TbTlvZ0VPZThMRHEyN09WWithRnNPTlhXQUZtMXNk?=
 =?utf-8?B?ZHI4aFNqd2ZLL3NPaStRMDg3c05IWHpJd1BRckVHUERDY2traG5PeUx3Rmla?=
 =?utf-8?B?c2xWdnk5MHpOYThnUjUzZlVLdTY3NmlRdnNqREN4Z0M5ak9QVkNVbklvemF3?=
 =?utf-8?B?MTlEajcreGk2Rzd2QWRMcVlYemRFV1FLb243bFlianl4R3BIa3NEaGRnQ1hF?=
 =?utf-8?B?RDQ5YUhEWkluZTJIR29kZXpseVJYNkJpWGJNTTBERWF4cTkwS2p2dU81SWsx?=
 =?utf-8?B?dE5MV0RDaU54amFrZzRCR2NBTjNjNTczdDJNcVVoY2VwU04zZ0l2Ly9HcmZs?=
 =?utf-8?B?MU9yNTV5N2JlNlJERWpjTEhqUGpxNFY5ZkwwbTJDVlBQc1lhYzdLWVJsTFQz?=
 =?utf-8?B?QzJiZjk0bjBUUHk2QWd6cW8xZWhsanNxelF5YjBYUzhDeVZiMlBxNnVIY09B?=
 =?utf-8?B?UFRjRGlrRHM5bGRrVDdEanY5WkNrWmovZHpyeTRnS21HZVFiWWNZVHRsUEoy?=
 =?utf-8?B?d1c2NVhCTmN1Z3ZuRzRtaFcveWVyRDZFVHFMbkNGVnlJWFNEbnQwNmdtUDJN?=
 =?utf-8?B?NTgvc0xYYnhtVVZrd21QZzFrVU5NZCt3bjRqcDlucHVrNHpmWmRhUS9ZNEFV?=
 =?utf-8?B?azJRbXNUVXZqVjJtb3VUSU5HWHUxZm1KM3MyeHZlcExWckpTc05sS0NudG4z?=
 =?utf-8?B?RjB4NlU0eGtvZTl2T2daZ1ZUZ3hSODc3YTdtZFlvcnFGM0w5d0RON1poTU9E?=
 =?utf-8?B?NkYzL2I4M3RSN3VsT2lRN3RBSDJ0a3RJUEc0cVlQT1NCaEdRUXF3RlE2RnVH?=
 =?utf-8?B?M013L2xiYXZuandzdHhlNWgzQTZvczAvUHBlS0tPK1E2MkpEREpyc0EvcnFT?=
 =?utf-8?B?RUZPOHJMREc3WTc2YzR4alpNVHF6b1YzWEd1SXdIVkNReDE2U01pMmE0b2dw?=
 =?utf-8?B?eE5WdzNTRGk2MmNvZ1hrU09UaFhxaktaWk45bktGM2Q3ZzhpWFBsTlB0MlRl?=
 =?utf-8?B?anNDOXpHNGRHMmJxRVZFWGhMcnVDZWYwTENyenZmUjd6MURhMlRkVzVLcU95?=
 =?utf-8?B?MkNLZElOM2d1N1FFeTF4MGRTaDZvcUdHWDVJV0d1K3IvMHVFUDM2K1hZVEYy?=
 =?utf-8?B?OFkrNDFYc3lGd1RZY2YwaTNwVkhPemtJZ1BiMHVaRkgySjFtM3lvMjFkTXV1?=
 =?utf-8?B?QmwrK1lzQnc0ai9GV002S0NhOTBNVExtOElpZHAzbW5YVlBHcFRldURQTVBw?=
 =?utf-8?Q?3Y4d+kJtoqm/3pnpjl1LupgbqkqEP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkpsRkZFN0hWQnAydkFiWlNMQVA1NU5tUnU4S0tuWEtzVXBRQWtqTVlMdVZa?=
 =?utf-8?B?R3ZGTm1RZXRZbnQvN1hqejl2TXc3eHBMSzNUK1FMK1doVktxSWVQSjEvSk51?=
 =?utf-8?B?VDZxMFNEcDRtbjlyZXhJSkJHT3AxMEljNTUrTmFBeWVqVHlYTkZmUEdZWVlV?=
 =?utf-8?B?R05Hczc5ZFdzaXBJYW4yZnpwNExJWG9mMU9qb3piaitSYStwNkJPakswYlAw?=
 =?utf-8?B?bjZXbnk0MTNENGlyYjlCdUJGTEk5eGZiZFBxYmpTb3BOZ1lSZUpDQWZ4RjZO?=
 =?utf-8?B?WWVaZ3pFdWw5RVVnRDJRL3EyWUdWcVE4OVpZTE85YlhVdFp1Wms1Q3hSTVZJ?=
 =?utf-8?B?enlwS2dieVdqY0p4MU9hSVIySnl4Nnl0Z3g1UThPQzd5cDhVYnA2Nk5pVW5N?=
 =?utf-8?B?TGE3NzI0Rzk4UDRLMk5DeGpGVyt2Slp1WUM5WkJ3clhJQitvQWQ4NTlyVnRj?=
 =?utf-8?B?QzNiTWtqK24vUGNQbGc3MGZWU2M4VFcxeFdXemxRSmsvOUwzeGRYZHRmamUy?=
 =?utf-8?B?VGRvVFJWbjJHV2p3azk3WXZnNUd4SWlQWjh0ZkJoY0lOU1ZuZVZNcVdvS2Ji?=
 =?utf-8?B?dWRhMHkvb2k1OFlrUlFjd0pZdk1RTXF1SnNiRUFYNWtpdDJZZHR3R3o3R2ZG?=
 =?utf-8?B?RXFPT0cwWkdzK2JnTnJ5RGhhVzMvbzJSNGpyaVdCTnZncEhXM2JwZUFEOXhM?=
 =?utf-8?B?ZHBGeEF3Y0I4OS9JN0RMOGZQbnZnTXFLQ1NPMU9xUDVYbEVWaXFuS04rRHc4?=
 =?utf-8?B?a25SNXN4Yi9QeXdzdVoyTW9ubFhFNXhiTnhURFdMVkVSa1J2RXdGZHNUUFV3?=
 =?utf-8?B?cmdQRVRXMlBHdGt5U0RnWDlLN3dXWDJacHh0S1l5Ri84RkZZS0R3ZkZLN0ZK?=
 =?utf-8?B?M2QrNGIrUGlFTlk1RDF1bHFVSmc5amd3RjBuM05lak5FOUFBQmtuamFoTXI2?=
 =?utf-8?B?NUhUZXdONC8wM1Exa3FvdXNhQS9obDgybytDNEZCWnd3MlJGdzlCa1J6bGRO?=
 =?utf-8?B?cElqRm9KeTVFWmhZWFV6UjFpTG9oQXVGZWZUbGJCODcxaDJOaEFLazJDdzA0?=
 =?utf-8?B?c3VLSU1BR0F1eGhaVXZGREJ6SmRGZzkxWVBkRG5vVTZpTUlpejJNRjhNT2lz?=
 =?utf-8?B?YitKNFBGV2Jtc1cwSkJqOGMrQ1lXT2lSNEpyUkpXazQwZDVZNlBZWGhsekVG?=
 =?utf-8?B?OEpJa3o4dWsvUGlEc2h1SXpYRUdNazJYSDNvNG5pZmFLSVVxQmtQZm1HN2kr?=
 =?utf-8?B?TnU4cm5vbHByUFJkUWZwTlhoZnd0T1F3WHlPOVJNVlVKSTVKZ1k1eDR3SUh4?=
 =?utf-8?B?ZE04L09wMHgzSFFpNzlGL0xob0JsQitCLzlYUnRrTU5sOHA3ZWRwalJSVER4?=
 =?utf-8?B?VEJKZy9tQWVYbHRvTDcxVS9jU0djNDdwOVp3MVplbW5iSUU1amh1ZlZzTXBU?=
 =?utf-8?B?Y2p6SE5oU1NabTZIbHdJTExyeDFWZDQ1REZOVkxJYmJFeFB2dnNjdkdVRlpG?=
 =?utf-8?B?a0NyVS9UWmtVZWdvbWZINHd2anFhN0NiUmRVMElyekRFSDdzQjAvRytLNDlv?=
 =?utf-8?B?QkJBMXdmbGhhM0pGL3VWZmNtN0NUcjByWDk1bnp0aGhrMXV2VVU0Q1ladXVO?=
 =?utf-8?B?MWdJMDV6UHVEY2NjZnpNckorV0IwZjF2dXdwb1BWRGIvQ2JyL01mclhNZUQv?=
 =?utf-8?B?UHBNVDBPViszZmkrRGtEemhKTDEvNHVTNS9ZMUFZWC9zemFIVTFFSDJlUktR?=
 =?utf-8?B?dm52WW5jRFJQNHZ2OGdlS2Jwa3YyejhoeURIZGIyYlZjd0IvbFpzZ1A3RnNM?=
 =?utf-8?B?Vmg4c1dlMlhGWERjeVpiWFdlZ2NLWkdDZjMrZUFpWlJUODUrTE5Td0JmVXNk?=
 =?utf-8?B?YzRPVFJ4MW5VL1BxM3ZGd1ZtdGx5VlV0Sm1nTjZlSnZsNWJsQVpiOHRZczRC?=
 =?utf-8?B?aEI5d1c4Uzl1dGlXaFRrS1A2LzdDNnpxN05tUEpWUmZqY2VMOC9wOC9pMTJx?=
 =?utf-8?B?dHVYSzZ1bzhGVkltTFJWaFNXVjNJVTlaWXNVcTZPb2thcnl3cHRsbisrNmRl?=
 =?utf-8?B?ZEhYOFlONkFkVFBucmJtcGt0SURUNzkzQk4ybVN5Sis5ZXJ6Sm5LWkd4U2dm?=
 =?utf-8?Q?+k4yg0146WhAW8MfeiWlNJLlK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19005ec9-b95f-452a-89c1-08de2cd3651e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:05:58.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5niTgTM2zdEJLkzzJ0BADoHnzAyBpkqWAZ2nZ3B1eew+jolNNS3jzqI/rGTkqwwKh2mLSmGTWwG1QkWLcVQtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207

On 11/13/2025 8:50 AM, Ian Rogers wrote:
> Add metrics that give the utility of software prefetches on zen2, zen3
> and zen4.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 101 +++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 1880ccf9c6fc..06cb56cbd617 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -121,6 +121,106 @@ def AmdBr():
>                         description="breakdown of retired branch instructions")
>  
>  
> +def AmdSwpf() -> Optional[MetricGroup]:
> +    """Returns a MetricGroup representing AMD software prefetch metrics."""
> +    global _zen_model
> +    if _zen_model <= 1:
> +        return None
> +

Zen 1 supports PMCx059, used by ls_sw_pf_dc_fills.*, but it looks like the event
definitions are missing from the "amdzen1" JSON files. I can send a fix to address
that unless there is an erratum.

> +    swp_ld = Event("ls_dispatch.ld_dispatch")
> +    swp_t0 = Event("ls_pref_instr_disp.prefetch")
> +    swp_w = Event("ls_pref_instr_disp.prefetch_w")  # Missing on Zen1
> +    swp_nt = Event("ls_pref_instr_disp.prefetch_nta")
> +    swp_mab = Event("ls_inef_sw_pref.mab_mch_cnt")
> +    swp_l2 = Event("ls_sw_pf_dc_fills.local_l2",
> +                   "ls_sw_pf_dc_fills.lcl_l2",
> +                   "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2")
> +    swp_lc = Event("ls_sw_pf_dc_fills.local_ccx",
> +                   "ls_sw_pf_dc_fills.int_cache",
> +                   "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache")
> +    swp_lm = Event("ls_sw_pf_dc_fills.dram_io_near",
> +                   "ls_sw_pf_dc_fills.mem_io_local",
> +                   "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram")
> +    swp_rc = Event("ls_sw_pf_dc_fills.far_cache",
> +                   "ls_sw_pf_dc_fills.ext_cache_remote",
> +                   "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache")
> +    swp_rm = Event("ls_sw_pf_dc_fills.dram_io_far",
> +                   "ls_sw_pf_dc_fills.mem_io_remote",
> +                   "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram")
> +

While "local_ccx" and "int_cache" are equivalent, "ls_mabresp_lcl_cache" is
slightly different.

The "ls_mabresp_lcl_cache" variant applies to Zen 2 and older architectures
and it counts fills from any cache beyond the local L2 but within the same
NUMA node.

Zen 3 onwards, this was further broken down in a way that the "int_cache"
variant counts fills from the local L3 or another L2 in the same CCX while
the "ext_cache_local" variant counts fills from another CCX in the same NUMA
node. So, "ls_mabresp_lcl_cache" is effectively the sum of "int_cache" and
"ext_cache_local".

Zen 4 onwards, "int_cache" and "ext_cache_local" were renamed to "local_ccx"
and "near_cache" respectively. A new "alternate_memories" variant was also
introduced.

> +    # All the swpf that were satisfied beyond L1D are good.
> +    all_pf = swp_t0 + swp_w + swp_nt
> +    good_pf = swp_l2 + swp_lc + swp_lm + swp_rc + swp_rm
> +    bad_pf = max(all_pf - good_pf, 0)
> +

Zen 4 onwards, "ls_sw_pf_dc_fills.all" is a single event that covers all
fills under good_pf. I can add that variant for the older architectures if
it helps with simplification.

> +    loc_pf = swp_l2 + swp_lc + swp_lm
> +    rem_pf = swp_rc + swp_rm
> +

Zen 5 has the "local_all" and "far_all" variants to cover these. Perhaps
these can be extended to older architectures too.

> +    req_pend = max(0, bad_pf - swp_mab)
> +
> +    r1 = d_ratio(ins, all_pf)
> +    r2 = d_ratio(swp_ld, all_pf)
> +    r3 = d_ratio(swp_t0, interval_sec)
> +    r4 = d_ratio(swp_w, interval_sec)
> +    r5 = d_ratio(swp_nt, interval_sec)
> +    overview = MetricGroup("lpm_swpf_overview", [
> +        Metric("lpm_swpf_ov_insn_bt_swpf", "Insn between SWPF", r1, "insns"),
> +        Metric("lpm_swpf_ov_loads_bt_swpf", "Loads between SWPF", r2, "loads"),
> +        Metric("lpm_swpf_ov_rate_prefetch_t0_t1_t2", "Rate prefetch TO_T1_T2", r3,
> +               "insns/sec"),
> +        Metric("lpm_swpf_ov_rate_prefetch_w",
> +               "Rate prefetch W", r4, "insns/sec"),
> +        Metric("lpm_swpf_ov_rate_preftech_nta",
> +               "Rate prefetch NTA", r5, "insns/sec"),
> +    ])
> +
> +    r1 = d_ratio(swp_mab, all_pf)
> +    r2 = d_ratio(req_pend, all_pf)
> +    usefulness_bad = MetricGroup("lpm_swpf_usefulness_bad", [
> +        Metric("lpm_swpf_use_bad_hit_l1", "Usefulness bad hit L1", r1, "100%"),
> +        Metric("lpm_swpf_use_bad_req_pend",
> +               "Usefulness bad req pending", r2, "100%"),
> +    ])
> +
> +    r1 = d_ratio(good_pf, all_pf)
> +    usefulness_good = MetricGroup("lpm_swpf_usefulness_good", [
> +        Metric("lpm_swpf_use_good_other_src", "Usefulness good other src", r1,
> +               "100%"),
> +    ])
> +
> +    usefulness = MetricGroup("lpm_swpf_usefulness", [
> +        usefulness_bad,
> +        usefulness_good,
> +    ])
> +
> +    r1 = d_ratio(swp_l2, good_pf)
> +    r2 = d_ratio(swp_lc, good_pf)
> +    r3 = d_ratio(swp_lm, good_pf)
> +    data_src_local = MetricGroup("lpm_swpf_data_src_local", [
> +        Metric("lpm_swpf_data_src_local_l2",
> +               "Data source local l2", r1, "100%"),
> +        Metric("lpm_swpf_data_src_local_ccx_l3_loc_ccx",
> +               "Data source local ccx l3 loc ccx", r2, "100%"),
> +        Metric("lpm_swpf_data_src_local_memory_or_io",
> +               "Data source local memory or IO", r3, "100%"),
> +    ])
> +
> +    r1 = d_ratio(swp_rc, good_pf)
> +    r2 = d_ratio(swp_rm, good_pf)
> +    data_src_remote = MetricGroup("lpm_swpf_data_src_remote", [
> +        Metric("lpm_swpf_data_src_remote_cache", "Data source remote cache", r1,
> +               "100%"),
> +        Metric("lpm_swpf_data_src_remote_memory_or_io",
> +               "Data source remote memory or IO", r2, "100%"),
> +    ])
> +
> +    data_src = MetricGroup("lpm_swpf_data_src", [
> +                           data_src_local, data_src_remote])
> +
> +    return MetricGroup("lpm_swpf", [overview, usefulness, data_src],
> +                       description="Software prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
> +
> +
>  def AmdUpc() -> Metric:
>      ops = Event("ex_ret_ops", "ex_ret_cops")
>      upc = d_ratio(ops, smt_cycles)
> @@ -187,6 +287,7 @@ def main() -> None:
>  
>      all_metrics = MetricGroup("", [
>          AmdBr(),
> +        AmdSwpf(),
>          AmdUpc(),
>          Idle(),
>          Rapl(),
