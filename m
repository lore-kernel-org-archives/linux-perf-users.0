Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C88313542;
	Wed, 26 Nov 2025 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764133533; cv=fail; b=CEbIClmJ7OV9mryajytC3xBJFQ0QtT+SJjSWF9FUT6NtyK2XxDyvi5OfA7KAckYxHoOpoXzUILAROfol9pdYDlJG31HuD9mKHQ3iJEWht/8aAy4BRC9Z/8AqwB7j6Ok7qbAd/BDFV0KP0/41NJlcueUPEzpVXjRznzri+5Rt1sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764133533; c=relaxed/simple;
	bh=yTerUsSE++aORWh98Poznhmskdu3x4rYcHtCDfgobdY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o8sWyzOIzPP0f25HdhULwzeqqxlZLAd+sIso/uR38j/GggO43Qnf6YkqH1hjiXVs4UAu5GF8p7LuHvlCwtkQNz5i62aBw7c8bZzjdJhb5Hklm4oBJOUAZGwbTlFaZPYhOC0ejTkbA8KYQ3kR8/l6IE/xtkkY0zxBuSyjXMbaOn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tA4I+cKz; arc=fail smtp.client-ip=52.101.48.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tA4I+cKz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8p3vW2gS2L0SrQSJj6k3RKwtnrhunVb73eQ1UpDZB4dGtEE7wn9O+4mdbnQjX5jGnObSht5lcAVZKbgDLmQu03XOFQsq/rcs/RvjiWgs8sksL0VuwPpqtqzWg49gZAzj3FFMnfHwY2ae7lDgYFcI1dwpwSPy+c/6im9CxHoqECUHSQ9NJXONykjGnQSx6GvL9EkwzUJ0maJ13rNScD8RmbqDwZEiS39pROsvpmFSXNCNWiCGl7XBiWtzHYk/Ygt9mSATSYLkOo7905u0wWD3rRfdeZN8VlZjGpKPlbULbDrWvANu3dK24dVseMvAjAmGd0gi27N/1I+jlK5tWG9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpwE39XW+bdpmJmaDb115onBihyWdRL2044Wj0iHPJ4=;
 b=s6UWSDmeA2MOfreZ4W3B5D7cLjDFoqMkyy1ZD7kgQ4VCee/ceVL6pAJdvJCH3Bi5oZEhGLcwsbs1WkXrUB2C4RXop2MWkv79axz1cUBr9qws+D1eDvarbW5okQ6SBLRGBIBlgyavGcIS6/fL3jBpQ9lLB1WEc9DEzQ/r7+UcHkak5GxeMaoLpooRSRBWJNSUtmJYX+YFRKpB68cGdk1aQss4gyyDsYww3HLhkf2K0SKzBIEV7OKy1/WwzppASygRTOz31a4Ldl9MbIpXasR4ybqTmis5trbEE1FOUj6vt9oE44m3YslJ+Kno8tDzR30runfStrXpwv2k2d07Lw4KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpwE39XW+bdpmJmaDb115onBihyWdRL2044Wj0iHPJ4=;
 b=tA4I+cKzR8vSfNufEMYRiq7mCzzn+8hDvIjVIKOxmLDAa8fPAR/DTTiLN+Zk4lzqVj99NNJiJpauPN6mT52iyUjjIWOdElK78CwcBzZUW3gH88ycbg50EeR8YA0p65Uv117kNPRRpZYcsQPcV0dbYqTwKB90AtvN9MiNQZH6w9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 05:05:23 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 05:05:23 +0000
Message-ID: <095bbbb8-4a65-4888-aa7d-39ea09a52b84@amd.com>
Date: Wed, 26 Nov 2025 10:35:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/52] perf jevents: Add RAPL event metric for AMD zen
 models
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
 <20251113032040.1994090-16-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251113032040.1994090-16-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 504848b2-229d-405e-20c7-08de2ca9671e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amVINDVLYS9ScW85OVdxRzMrTGUvZnRiUmQyZVE0OFg5R0M2cHA4b09seEZj?=
 =?utf-8?B?YzkvWWJwcjF6N0Q2WGhpaElxY3E3UzFoc1lVeVhHcTN3V3Z0ZEt1c0piU2FN?=
 =?utf-8?B?NjVUU0ZNK0F6ME9ZMDJkMFd5ZHJvQlpmamR0UnBlZ0lGSTgzUW9KU0pLa0FG?=
 =?utf-8?B?aGRZUUNidnd6dnRPekY5cFVxOGdLNG5hSk1QeWlsVXhBaHUxZE9hL0VBdGhr?=
 =?utf-8?B?RkFpbVowb2hhKzgva3R5N2ExVW02eXNKL0JYdnlYMFlBWHRSMHNOenN3UnhB?=
 =?utf-8?B?YjZvYjhxeU4vUlNmOUFyMkc2ZXpHdnZoU1ZjRXkrKzVHNFlHbGtXcmNVUVUr?=
 =?utf-8?B?RG1QVUhKbWM1U1V6NUNDVitCVHg3OEI0MTNibGtuMTNwMlZna3JyTWsvelVa?=
 =?utf-8?B?Ky9LM0g3TFM5b0Mybzc2TkI3YnpIaWNJb0pWZmpUdll2ZE1hbWpjUXVVandw?=
 =?utf-8?B?WXhDQnRwQW5td2F6Ui9XMVNpaHc4MURwSG5pc0dvcTBSclZmMVhEeHBLc2NT?=
 =?utf-8?B?Tk9CSm9rS29aNlY3OEpVU3hVbWk1d2dqcG0rNTAwOUVyTEQ5QmtxYThaUWgv?=
 =?utf-8?B?Wk1CRWhOZU5WZ1k4UGhHb1IvV2ZOUm41TmpxY0tqdk9OWG0yVGZTaVhjZkQx?=
 =?utf-8?B?aEpPa2NYTDBXb21ETnVlaFZGZHRKOUtBQi80d3AvZ1o3b0RvaVZmYURyVUp3?=
 =?utf-8?B?U3RGMGs0bmFweGY3TEtPSGh5UkNnS2NlekNCQXpNYnJFWU85ZnFZeWlPWkp6?=
 =?utf-8?B?R283WklEYnhnT3MrRFJIcDAxVEloeFpXbnhJQ3Z6MU5pSkZxQkMxS2tjcjVJ?=
 =?utf-8?B?ZFhGcFJYbmlEdmFJL0hEbS9rbUpkSlh0bGorNnZGeVYvb1hydnBsMEU1WUVS?=
 =?utf-8?B?R21DWmN4em1KQTE2ZmxwTUZOSDN2endIbklsM3pvcVY5UXp3MVg5MW81Syt1?=
 =?utf-8?B?V1BPWGpCVzZUUy9CWWNnM3hBTldOYVpyaWwyRHpCcys5R3ZUTE5LTFpmTXRw?=
 =?utf-8?B?T1BSclNRKzhKcDVZZHBZTnN6TC9aam1hS1d2cncrU0JlOWtWeUZWUUQ2Sy9l?=
 =?utf-8?B?RjhHMDVjZjAycEFJaU40YjlQZzRnczV3TjY2akt0dG1ZMWpHbGZlYXN5Zy9Y?=
 =?utf-8?B?RXlKTFp1MkdDdEVIUlpET3JtYS85a0MvemN3Q0Z6RFJHSUhkTmplaXl2UG4r?=
 =?utf-8?B?Q0tnRnRSMVlwTzQyWGhxSzZudEFwcTVZLzd5bzlyZi9LOWRXY3RoeWh4aU84?=
 =?utf-8?B?ZmpWK2t4d2k1LzRRSEJFV0ROWTQ1a3R0aFR3dG1PelRBYkQ4TmxOS2Q4Y3Vy?=
 =?utf-8?B?RnR3cVh5YmpERVE4MlV4blJhdFNBVmV5dXBTdkxNQTU4cERmbFJ6YTdoODcz?=
 =?utf-8?B?TFN2WTVCWS9mYlV2eUZDenEwcGh1UjEyM3BlMkZPbGwvKzlVK0NnY2xtQVBL?=
 =?utf-8?B?TlpXVHJQaEdFWkUyQUFwMjFXOEtrRjlsNHNOMlN2WjFxU2ZQcXBnOFlRSHp3?=
 =?utf-8?B?cU5aRUZoaGtqNUNqajhRNGFMMDdTNjdqMU5BSE1CWit1TGRRZm14T2IxVktm?=
 =?utf-8?B?WnBrN0JBV05ZUDlzcXRJSXRXTWNNM3RTbXl3VUNNcWlpd0FISU50cmo1V2JO?=
 =?utf-8?B?bGpwTXlRdHY2bmhERFBLYThUV0VHeFNjMm04UnJ2d3NESDI0V0R2cHkybE1a?=
 =?utf-8?B?azZyODROUHlLVmwzdFhIcUVCd1EwUXlhZ1NMQ1RnVk51YXBYWC9NRWhMNmc1?=
 =?utf-8?B?LzJ0NVh4d2YyK0FXbkd4cjhjY1BqRnc1aEFPZ2RPVHlJUjFsb2ZCeGdFYjNZ?=
 =?utf-8?B?b2o2bkNVa1EvU3YwRUVCWEhaZU4wckU4dHFrazVZMjFBb3l1Y3dLLzA4blBa?=
 =?utf-8?B?R1IyS1BqeTV5ZGZyZllNUnNTbkpGTEdRKzN6S1V1TlNwbjJUclZxczNObi9C?=
 =?utf-8?B?aFdmYm1GdldGYmxPNTQzaWRQY1lGWXhxb3pkNC9LN2IwUzFCRWtkbjFFekhr?=
 =?utf-8?Q?nx76Oo9qOO/sxWxC7o1Ey4l3Zrb6pw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVp4RVlwNGJYSkRVY1lweUMyY1gvMFNJclp2ejYrM3ZzOXZjZU9KMVZQSW1V?=
 =?utf-8?B?Zm9pNCs3dTllMHZlM0YrWXI4bFVpRXk3ZEV4bHFtK1dUbkN5RjhWbDI5OFhr?=
 =?utf-8?B?NUdlazZPTzNYSTNna1BRM3NBZG1FS0prUnU1VThHOTN1RFEvOGhLOTlpNGpP?=
 =?utf-8?B?TDZpVXdYWlZJL21OdWwyay9yQ1VXVHpWTkFlTjZ4QVhFR1RCeDJIOVhiRVRO?=
 =?utf-8?B?dWJ4c005WTNaNWZrUnRLaHNLemxBV0pzSTliNXRtTEhsM0tWVTNXRW0xTFY4?=
 =?utf-8?B?R3BxRmU3ZjNsNHd1ci9RUENqM3pKdFptSHdyUk5rRERIOVpFZDBuRUNydkc0?=
 =?utf-8?B?aHFNYTdHSlZrbFRuZFdPTTBuUmkvbC9DTHExWFhnOGl5WmpLbDhOeWFDRmdG?=
 =?utf-8?B?VWJjRWViWGNUZnFCemhtMlB6UlFPUUora0QvVVFpY0hIUVdWZ2ZqcmJtQkVD?=
 =?utf-8?B?VXlsR0JwWE9BL3ZWOWpGOHVUOXRyNFZCdFZaeThCVlJMeVpqNnIxOVhyaFdS?=
 =?utf-8?B?V1N1MDQ4bWpHN3ZsTUpUak9QUVBCRi9VUGwxL1hOc2JiWk1HQnAvZklLcVZX?=
 =?utf-8?B?WnZLUzNSOHZLSEVibFFicUNqbnNiY0E4SVMrdWxoZjdiWGozUkpFN24xY0tH?=
 =?utf-8?B?U0RYa21lZTM5bENPTU5TVWRqaTFqNXEvOElLMHh6b1JtdlBua2JrOUl1VGpp?=
 =?utf-8?B?VkpDM1Z2QmUxUTQyRmdEWmZZYk82dmVLMC9PYzBNWEpqL0pWekRoRTZlRjcw?=
 =?utf-8?B?c21HekVNUFk1K2dRV1AyZTc0elhqb1NhQitKUTVncUttS0ZMQ1FQZ3gzVzcr?=
 =?utf-8?B?MEZ0RERERFZzYVRYVTQ0TytUNW1CcFdNSXJvclU5S3RTditVTUJrWDljRVpU?=
 =?utf-8?B?aFQ5elV2RHdBMkZsejJGMXJ4N3ZuYWJkc2Z4TjhLeVNTVE9rWHkxWTlxWWk0?=
 =?utf-8?B?OVoxVEk0M0Nnd2I4ZS9lUVhRRmN6a0kzVUNJWjB6UFhYa3AvSEMzNmFxcEpm?=
 =?utf-8?B?T1BnS1hPMG95NEtsK09ka044N0lhRHppU0NRbXlBNzZMNnJtWkl6STA0OGNE?=
 =?utf-8?B?SElSaHhSMTY4MGpSMEx2M29yQXVZTk1XK2FGVlV6ODBJNEljaU1rMVFFOU10?=
 =?utf-8?B?b09DYmlybkk5K01oSytBZVF1T0lheFNJKzFZMWw0cEt0emxpTzlybUJqQjda?=
 =?utf-8?B?YWdvTWVzb2JEZDlrTDlmVVNxYnkrTERsUnU2Q3YvS1lJaDhSN3JENFF0TzAz?=
 =?utf-8?B?NUN6Y2paSWRHTE5wbkEyb2VZV0JBVTErRHVQLzB0N1d2RXZXdWRMWXIyQkZU?=
 =?utf-8?B?TStGOFlFeDAxaE53S3ptbnI3UkNjVmorR3pmREZ3R2EwK2hJckdpYk1rUG1j?=
 =?utf-8?B?T0E1eW1WZHBDMDQxQU93eHRSVG43VmV2R3M5OWFxdWFiSEV0cXUrZ3hzajNZ?=
 =?utf-8?B?YUVZR1VPbHdMZ3piTlp5RVdnNU8rdGsxbGJ0VllldkZWMHo0YjF0TXkxVkl1?=
 =?utf-8?B?eENaMmhOYVd6UDlqTVh6Y0Fod3BnK2NkRGlieUh0UElWRXY1R25zRlNBUGYw?=
 =?utf-8?B?cHdvU0ZvOUtFSm93T2NQSVFiWVI3a21zYjlGTm01amc4SDNuaUVzS3FJSFdK?=
 =?utf-8?B?NXZHNDBWVzdTWm5WeUgxaWphMmpuNHlwakNYbjlQbFJiRUNnVTZPN3UxWXhQ?=
 =?utf-8?B?MkZHaGJpbnhhajBzMkVlUjd2dC8yL2lMNWFPQzRwTU1pUUJ4cElsc1I5Zld2?=
 =?utf-8?B?T0FmM3JuL1llT3BwWS8vVjRTbHhVOEpYcFJFNUI4VFk4dm9nMGlNOFk2MjNu?=
 =?utf-8?B?bjJkZFk1VmR2Vk1Qdm1sRnZ5YW4rb1dNYXZQYVhobkRqUFh3OFQxUEMwcDRs?=
 =?utf-8?B?dFd5YXNZT0psZEtGcmgwYVZReFFqNzhJbjY4TEw2UUUwclhaWlpRdHNkWWR3?=
 =?utf-8?B?N0NTTEJldXhxT1I4Tnl0bFdFSDVEVUIzaE05VXFtRHBhU01Ib2J0MlRuNWNR?=
 =?utf-8?B?RlppdTY0U1dxZkFNRUhHSXB3aTArZk9aZmpZbHZGVnZpTldaeTl5a29KemYr?=
 =?utf-8?B?cG9pS2dnRG0ySkdVMzR5dkQyVElBYmZ5TytXa2NUMlk1VXBtOWFOWUFvNkRX?=
 =?utf-8?Q?VNls/BXOxaj3krmAcaRdQMlQP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504848b2-229d-405e-20c7-08de2ca9671e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 05:05:22.9693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqBQkAtatzY1JY3VbKCSQ013zJLY1f2lKoTfKpdEZRArgWkvMCe41B2HZvy8PZD2J4sqnDhjf37tVNTfo7hjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135

On 11/13/2025 8:50 AM, Ian Rogers wrote:
> Add power per second metrics based on RAPL.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index bc91d9c120fa..b6cdeb4f09fe 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -1,13 +1,36 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  import argparse
> +import math
>  import os
> -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
> -                    MetricGroup)
> +from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
> +                    LoadEvents, Metric, MetricGroup, Select)
>  
>  # Global command line arguments.
>  _args = None
>  
> +interval_sec = Event("duration_time")
> +
> +
> +def Rapl() -> MetricGroup:
> +    """Processor socket power consumption estimate.
> +
> +    Use events from the running average power limit (RAPL) driver.
> +    """
> +    # Watts = joules/second
> +    # Currently only energy-pkg is supported by AMD:
> +    # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
> +    pkg = Event("power/energy\\-pkg/")
> +    cond_pkg = Select(pkg, has_event(pkg), math.nan)
> +    scale = 2.3283064365386962890625e-10

It is unlikely that the scale factor will change, but would it still be safer to read
it from /sys/bus/event_source/devices/power/events/energy-pkg.scale?

> +    metrics = [
> +        Metric("lpm_cpu_power_pkg", "",
> +               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
> +    ]
> +
> +    return MetricGroup("lpm_cpu_power", metrics,
> +                       description="Processor socket power consumption estimates")
> +
>  
>  def main() -> None:
>      global _args
> @@ -33,7 +56,9 @@ def main() -> None:
>      directory = f"{_args.events_path}/x86/{_args.model}/"
>      LoadEvents(directory)
>  
> -    all_metrics = MetricGroup("", [])
> +    all_metrics = MetricGroup("", [
> +        Rapl(),
> +    ])
>  
>      if _args.metricgroups:
>          print(JsonEncodeMetricGroupDescriptions(all_metrics))

