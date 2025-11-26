Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAA1E5207;
	Wed, 26 Nov 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152260; cv=fail; b=qUhxCdQQetH7F8zUhqf3ywEGwnsODIngJZ7kVZ2Vp5/pL2DCn90W3UHrDabX/yJ9ZpYBGkqUltk0MdZbTxLCe2Kx1KCdZEkIvXZV26woPiRvb6HfzXOv4hsvZPRYxy+rN8Bld0FDYfLlfxvPnSb63ZBtRqvumWeNN/tOREEvXqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152260; c=relaxed/simple;
	bh=+9TqpkBNyb7irHKNdh0WkKD6p1ZpiUqV2L2M5fe4CSM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTJoUAkOEcfM6J225BpXDhyu/AjHpaTZ1NLySverfxMWQfKmv3I6YulEVGgsqgic6lrDp/M5sAl48HZNoIfzQ8dSHHPqKat1dcY2Yp1uoTcdFAIyRAHLJyQfzFXSgS/PFT/77GeMaL/kwgQ5LkD03AtO7uBkUkAzMxvXrtpshH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0MU2+20U; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0MU2+20U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA7zK1kSEmGZFym8VB6YCquNwH41rjsFarzsBuq9YjBJfDUsb1H29j/dtdFtRTgwrtCrzgB09BgSPeV8hecntMHzvMo70JCvr+Ti/qAbeGx2/G2L5brnmePZQBYqyR1CplBhM8L+u7dFiS2gdfDBK2pJUKlxRkm1e9txWSJQzWDZpGW+13Q6+/fKssJxT6TrUlCXoaIcx+YmYq2YXxbb3iLd7QsC3GR52GNCzPKef/mnuO+kNNP4nKrpRK7MmAwrbqxkFfW/TbKfswqjyHwu6E8nFyQrIcPCGvwN7a46KOS1p/FZ0KLKOih07XZqovP2scNP1zj6PZC6T84jcpVBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx1beQSvaGrfpQmT849TcN51Un+h0r5a617fvYPBzHM=;
 b=yEvU8LSzyO3PMkPcW/OBpupcpfYDNNnsKJjGBUIR55PZwlKe/BcGj/vvAHQqBsgoHsHU1Aql6/0TDITw+UPL8uIRPOMPxFY28trwWtj7/5EqyMnrAs8pGfljebnLI8w0SR+yHoBKp9I+UZm9NZj/Nu1gBEenezciKo4fDKZGRw4CuUEMiuGLbLV377L1CahcWbJ3/yw8+lCbJ6nbOsbd31Kawur/5pV//eljVg3SvmtWVG0p5Zz9SA8cIW/5XFMq1GfOgwxnw7J7qZFfzN+idq/oZFFHlrXWpMJHpGGa/y7qYwjSLDcsGjMLek2N39/yVlUb0Xtso7ppRBJrJOLkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx1beQSvaGrfpQmT849TcN51Un+h0r5a617fvYPBzHM=;
 b=0MU2+20Ua6lJH5s5EJe91J3X4FxNMBu3QsalU5uLPvaDrkfep5M+7Rjn8h0axUCa7G17H+qhkQqrnYfOqTcnHnU++xejN9cmFiXhBvWMX6vyVQ4uzIaRaCdjPS9OeWov38fiUmOw/J7SK7PQfRM/UkLiMg4XtXjux+ZIRlQtsGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 10:17:36 +0000
Received: from MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::bbe0:a58f:b02c:1427]) by MN0PR12MB5713.namprd12.prod.outlook.com
 ([fe80::bbe0:a58f:b02c:1427%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 10:17:35 +0000
Message-ID: <1ac78000-b41c-47d1-ace1-3bdfc2968e4a@amd.com>
Date: Wed, 26 Nov 2025 15:47:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/52] perf jevents: Add hardware prefetch (hwpf)
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
 <20251113032040.1994090-21-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251113032040.1994090-21-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::18) To MN0PR12MB5713.namprd12.prod.outlook.com
 (2603:10b6:208:370::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5713:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: b13836e9-d265-461e-4cec-08de2cd504e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajdXNTZMbkhCZjFZQldraEVHMGRtK1RtTnpZM29xSDRoNTY1QnpTUjVMZEVN?=
 =?utf-8?B?Q2tiQng4UkVoRE5vNTZ4WjcwMXhvZHVQa3pvcmlWZ1JSd1ZnaG5JckEzQ1k1?=
 =?utf-8?B?UTlqU3JTcnFUdU5EV1ljMUJWVkpNV3N0RWJEOHRGeDUyRXBRNmQyanpBekNw?=
 =?utf-8?B?WnI2bDl5ekI1YnZ2L1hjNXdsaXp6MjN4aWhWMy9tUjQ5YXlhSnFOVkoxdWJZ?=
 =?utf-8?B?aW0xUVRjdlFpTFRVeDFaUC9OMVNNUnVZZ3RXTHcwY3hSVXdpVkRiYnVjWkJx?=
 =?utf-8?B?ZE9DeWIrK0wxdjRTbmpJOE5icngvdVVIeXU5YVh2MWZlbm5oNzdiN2tXU2My?=
 =?utf-8?B?anlMUnIweVdvVERHTUxqMFZnY1d0MTd5RzZFRHJBdXNORUhCZ0xuV0xPNi94?=
 =?utf-8?B?aFYvd0tuSWJESjN6UjdHTFppVXNiSXZaRUxieFNUQnBJM1dTWDIzQ2d3bmtt?=
 =?utf-8?B?RVpnTVlpVC93T2RNTlpVSGNrMmNvUUJXTE1vM1VEOGQvaUV3b2ZQT1JjVm5p?=
 =?utf-8?B?TlZ4TXVLSjRrNXpQUXNReThMQjJ0c1dJYWpMY2ozZE5RZEM3c2dPaGtCNjB6?=
 =?utf-8?B?ZUxIMVBNTjdKSnM4M0NLbVd5L1B2VnhqekxnM2JKcVVMUHVNdlJJcTcrNEhr?=
 =?utf-8?B?Yzg2UmpFdkpZUUQrM29SMnFVUzU4TExlZUJua3hlVU1vb1RxTWc2L2MwRnRZ?=
 =?utf-8?B?UWJTVjB6MGd5T05TdDE0V09pOTdZSmMrSDIvN3R2a2JMVTFkdHAvdkJmSXRO?=
 =?utf-8?B?WUl2REFhY1NraUhRUlVxZDhWZlUrRlk4UnYySk14QUpvTWV4VkdkdE80UnZ4?=
 =?utf-8?B?bmZyV05GeGNoQW1KNVBBU1NBc3NCWUZERE1ZVHhxS05wNWdnSis3c2JtNTNh?=
 =?utf-8?B?TFAxTVFmSEpwWXh5Zzc0VUVFc0J1U0lNeUZWUTdQK0FZZlVpb201aEp0T25P?=
 =?utf-8?B?VURmQWwwM0orOTdaTmJWaHJkRHpic1Z4Znl0SHp3N2VzTks3SjMxcTB3anV1?=
 =?utf-8?B?S3RDWGhDZXhKMFJ3N2dqVlpEeGk0V0d5ZlptaTArYy9ZblB4V3Q2QXNqZGZa?=
 =?utf-8?B?OElqcGFodXlMNjVaV0V3RVJLaVpMQ0VqUmVNdzAzSlBjRUpCQzFBMUgxeGQx?=
 =?utf-8?B?RFdGZVJKQ2R5NWttbzB0cDIrRlg1UHpVUElxdEpHcmJjakFjOTBhMHU5Yk8v?=
 =?utf-8?B?YkcyU1RXU3BySVhQQzBzVkZmQ2V2S3V1L3BoY3V3dllPcUs1cE1GMzVvRldN?=
 =?utf-8?B?Ty9WRk92T2xrZTJSc255NTNUeFRZbE9JN1RPd2FaTU80UDVEenNuLzZlZmUx?=
 =?utf-8?B?cWc2NzRvTER5MzhtZHFDaXdUOWdFRElkNXVEZ0RBZWRHeW5jaU5ndU94bDBI?=
 =?utf-8?B?OGU0dlJkTHN6SGtpL2o5MVJnZVdoaGdXVnN6QUU0RzN6SS94R0U4cDRPRTNZ?=
 =?utf-8?B?TTBFTmNPRU5sTkxVM0wzZnZVYytHSTBnUmJPalNxQWFkODkzZmVxY0pCTzVM?=
 =?utf-8?B?bHMwM0duM1F1bHBPblIxU09IWjlOSmlPMC9qd0l5K1RycWZmZm9YakdpcVZB?=
 =?utf-8?B?UzhxaGNkaVZKMWREeG1SeVk5TnUwTEI2OURkaFJCLytlV0lKSEN5SFNsOFFz?=
 =?utf-8?B?dmwrSW9rT2hGK3lXRDZOZldLdHRkcU5oNnB4SklIK282VkQrSGtYVEZjWHFh?=
 =?utf-8?B?RnpuZ1p5NW5ZTlRDaGM5VXQvMFlKWEh2VWxLTXhqSnF0VWorZCsxMHcvbnpI?=
 =?utf-8?B?ditNdXQrSlQ1ZjdML3EvOVdlWDlRd0Y0cGZzSHFYS3E2LzhqM3lETHFZbmNK?=
 =?utf-8?B?TDhLejhySEtjcHQ1bm5OQVVZUEZiOEFqbk05Mlc0TzFxVEJnekN0eEZMQ0xO?=
 =?utf-8?B?V05lMEZDc3ZYV1RFZFZLMUNxZ0FRdWR4V09UY2o0YlNkQ0s3Z2lWeVFsNDZT?=
 =?utf-8?B?dlVTVFB5cldMZ240SE1nenJhYzN4bk1vaGxyVEZFVXhDVHg0dTNtZGtPUUNF?=
 =?utf-8?Q?Wj2SDAV86R54XAogAj/VoSUlGhi3f0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkJMb3RjZ2JSREEwazNBWVdGMm1FN3V3UXdkZTdieGVlMWl3dmZ1R1R2L2Rx?=
 =?utf-8?B?aXUrVERQVTI4bFd3c2VoN25pR1Z4WVJBelppMGZCMmpUblcyRGhBblVMQkVq?=
 =?utf-8?B?cStiNzhpK1VwN2VtbzNtWlJieHozTlA4NWRVL2J6NVZvcjR2K0owV1VmSUpj?=
 =?utf-8?B?bkJRMmphTHZndlQ5VC9LaHp4dzJWcUhMcDFiSHF1WTlFYlJKd3dJQ0FRVVlt?=
 =?utf-8?B?bGRYQzM0TEphMFlLYVZoUDA1cnRQUjJPYUFxeWFqWU5zYVBWSDR0MHBvM3dh?=
 =?utf-8?B?OUw3L0xCVjM4cVJpeDIvQTRLbHdkZkpqTmRwb3BmNEs4VnNBTW53dUhtTWFO?=
 =?utf-8?B?MnN0Tk5jSzlPcHJVVG5wRjlIZFBncldzQ1g1ZURlU2d5OXpYdnR3dGxzbWRl?=
 =?utf-8?B?NngxR1dWYlpzOTNwNDRIVENYQldWUzJ6eUhMNFBOUXZSSU9MYVJLdm5Sdno3?=
 =?utf-8?B?OS9YMzZaSWwvNUh6UldIODZTWTZMeHhIZHI5WmVJUUo5NnNRNU92cmdrYldS?=
 =?utf-8?B?b0NkOVlsZ3lUaU5KMkpTdUtzbGxxaHMwRlZPV2dMQWNRbEZ2RVJuUkFYNllO?=
 =?utf-8?B?bUdUM1UxbnpmTmNidm5xTHlVaGxNckRsaTBOZlpDeVIvaTQ0M2pRT1RRVy9x?=
 =?utf-8?B?b0ZQVUk2UFhqMDhySTRyemtIOXJzNnVxRVUvcEVxTlVrSkk2RksybUtuRFZR?=
 =?utf-8?B?M0FSUFBBN1o1d1o3OVplM3VReXZxNEhkWlE3RDhRUTd5cHlETUxDK0JsLzV2?=
 =?utf-8?B?ZUVNdCtvN0lKSWVQbnFyRkJOV0dwN01VQURRWVowOXpMOGtEYnJsaHNkNjM0?=
 =?utf-8?B?UHNNSVFEWGFWWmVJZ3JEeTV6OTIrWFlIa3NIdDZvVFdDR0dxV2JndmRzSE91?=
 =?utf-8?B?RkdXRW5kc1JVK2M2Q1FLbXAzZUdJZ3NzclB5NklzYXYvWXFOYnhIa2hiSEdZ?=
 =?utf-8?B?NTY4bk41bkRwbXlsa3psaTJpR1Q0aDQveGFEZEN3LzhJRmJ6bTlhemxxQzRz?=
 =?utf-8?B?YUlnWnZ5V1dUbmNhSk1WL2Z0RWg0TTdaWktxMU1yU1dGbGVJaGxYb1Mzckhp?=
 =?utf-8?B?NlJ1eExkTlRvV0c4aFdPNk91NzNaMnd1RUdkamdEM1NkS2JpRFg5OGl3RklE?=
 =?utf-8?B?UVdEaGRmQldicG1iUFZzQWs2VnQ0cHdZcWhvalRiV21scU4xT2w2QXd2aGtY?=
 =?utf-8?B?c2lFaCtUQTIxMDgxYVpYUGlqVjJhM0wxM215R3R5VWtoL09wcnV2cXR6c0dD?=
 =?utf-8?B?blNjK2E2OWtQOWhTOE1OVGRlb1JvQWJVdi9QaFN5TjBCdDkvbnp3bXBPOEZF?=
 =?utf-8?B?WWFVT0pTVUNxUEozNXhodnYvYmdLajBPUkxUU1g2Y0pxOHhveEFKMEUzb3d2?=
 =?utf-8?B?QnZJSDlYT2E3SkRCdTlnU2dhMk5udEI4RWluOEp3UThDWXpZS09zMVgxWGtp?=
 =?utf-8?B?dVJPZ0JtbGhSQ25RMi93UUlGb0o4RU1qbXpkaU5KMmxkTitIRnpZUks5RGxy?=
 =?utf-8?B?clc1RUM3ejExcFIvd3Rnano3ZUFxSFFKNjZGRGVLR0dTQUVnRDU0MjhOdWhV?=
 =?utf-8?B?cUo1QW4xQlN6WmRNdzZsMHh0RThBakdGbGVmZXYzRGFiaUs2enNDa1N5a0lt?=
 =?utf-8?B?aER6L1NDT3dzZlhRYi91Vmp3SFZVTUVoZFFBT3UwWHpEY29ZWG00WDQxemNJ?=
 =?utf-8?B?VW84aWcxNDNZdnB4NHBIS0hlV1pCdmhUSU02bm51SVhtSlZ6b3lrdUN0SXNB?=
 =?utf-8?B?QkxrM0VkSC90MGFDRThvUGhpZWRXLzJjSkt3bXRtNVdNZy9HRTFvRXNCaHdJ?=
 =?utf-8?B?TTdyVDJUVjVySDZBZHdlYnowVUUzYjB4MlpwdjdSb1ZnTHVsQ0tEdlZCZ2xY?=
 =?utf-8?B?OWRSd3hBQ1NzRVlaamRPYStMMlJRZk5CQnBsdXdETDQwTXdKQUNVcFAwaElT?=
 =?utf-8?B?SGtWUGJxd1NFeldJTU5iUmpPU1Y2bFlTMXN4T3p4U0J6N1FpK29GcktZSjlY?=
 =?utf-8?B?ODJhTFM4dTJvWHl4S3JmS3FNRlRuUWZwM0x3TDhVWkpBME1RKzJOWElUZ2Zt?=
 =?utf-8?B?ZmxKZHZGWnBqRnQvUUdPYTNYOU1lU3greXRBbTg0SkcyWEN5NGhDaXRRNTZU?=
 =?utf-8?Q?B1HX2iFbtlVtEHU7hLV9BAwqt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13836e9-d265-461e-4cec-08de2cd504e7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 10:17:35.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8fFO+WUDQowSbIM8cO9DvTh6c622MonesNrkcp11qISAa277rrFrslZxTpb3wweeqnpVO9CvAA2abZBdjC6dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759

On 11/13/2025 8:50 AM, Ian Rogers wrote:
> Add metrics that give the utility of hardware prefetches on zen2, zen3
> and zen4.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 64 ++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 06cb56cbd617..be27a4947e45 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -121,6 +121,69 @@ def AmdBr():
>                         description="breakdown of retired branch instructions")
>  
>  
> +def AmdHwpf():
> +    """Returns a MetricGroup representing AMD hardware prefetch metrics."""
> +    global _zen_model
> +    if _zen_model <= 1:
> +        return None
> +
> +    hwp_ld = Event("ls_dispatch.ld_dispatch")
> +    hwp_l2 = Event("ls_hw_pf_dc_fills.local_l2",
> +                   "ls_hw_pf_dc_fills.lcl_l2",
> +                   "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2")
> +    hwp_lc = Event("ls_hw_pf_dc_fills.local_ccx",
> +                   "ls_hw_pf_dc_fills.int_cache",
> +                   "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache")
> +    hwp_lm = Event("ls_hw_pf_dc_fills.dram_io_near",
> +                   "ls_hw_pf_dc_fills.mem_io_local",
> +                   "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram")
> +    hwp_rc = Event("ls_hw_pf_dc_fills.far_cache",
> +                   "ls_hw_pf_dc_fills.ext_cache_remote",
> +                   "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache")
> +    hwp_rm = Event("ls_hw_pf_dc_fills.dram_io_far",
> +                   "ls_hw_pf_dc_fills.mem_io_remote",
> +                   "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram")
> +

Same notes from the previous SWPF patch are applicable here.

> +    loc_pf = hwp_l2 + hwp_lc + hwp_lm
> +    rem_pf = hwp_rc + hwp_rm
> +    all_pf = loc_pf + rem_pf
> +
> +    r1 = d_ratio(ins, all_pf)
> +    r2 = d_ratio(hwp_ld, all_pf)
> +    r3 = d_ratio(all_pf, interval_sec)
> +
> +    overview = MetricGroup("lpm_hwpf_overview", [
> +        Metric("lpm_hwpf_ov_insn_bt_hwpf", "Insn between HWPF", r1, "insns"),
> +        Metric("lpm_hwpf_ov_loads_bt_hwpf", "Loads between HWPF", r2, "loads"),
> +        Metric("lpm_hwpf_ov_rate", "HWPF per second", r3, "hwpf/s"),
> +    ])
> +    r1 = d_ratio(hwp_l2, all_pf)
> +    r2 = d_ratio(hwp_lc, all_pf)
> +    r3 = d_ratio(hwp_lm, all_pf)
> +    data_src_local = MetricGroup("lpm_hwpf_data_src_local", [
> +        Metric("lpm_hwpf_data_src_local_l2",
> +               "Data source local l2", r1, "100%"),
> +        Metric("lpm_hwpf_data_src_local_ccx_l3_loc_ccx",
> +               "Data source local ccx l3 loc ccx", r2, "100%"),
> +        Metric("lpm_hwpf_data_src_local_memory_or_io",
> +               "Data source local memory or IO", r3, "100%"),
> +    ])
> +
> +    r1 = d_ratio(hwp_rc, all_pf)
> +    r2 = d_ratio(hwp_rm, all_pf)
> +    data_src_remote = MetricGroup("lpm_hwpf_data_src_remote", [
> +        Metric("lpm_hwpf_data_src_remote_cache", "Data source remote cache", r1,
> +               "100%"),
> +        Metric("lpm_hwpf_data_src_remote_memory_or_io",
> +               "Data source remote memory or IO", r2, "100%"),
> +    ])
> +
> +    data_src = MetricGroup("lpm_hwpf_data_src", [
> +                           data_src_local, data_src_remote])
> +    return MetricGroup("lpm_hwpf", [overview, data_src],
> +                       description="Hardware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
> +
> +
>  def AmdSwpf() -> Optional[MetricGroup]:
>      """Returns a MetricGroup representing AMD software prefetch metrics."""
>      global _zen_model
> @@ -287,6 +350,7 @@ def main() -> None:
>  
>      all_metrics = MetricGroup("", [
>          AmdBr(),
> +        AmdHwpf(),
>          AmdSwpf(),
>          AmdUpc(),
>          Idle(),

