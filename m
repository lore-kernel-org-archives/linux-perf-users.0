Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794389421;
	b=m6cBcDMqiu7V3TmkBLnSKfgrwjwHbYt8AK6+1dIxg/d0ufNmzTgpq8FuRpbnYK9IH/Mk
	 exul4+3oaOd5dn2YTsoZuBxIv+ZoBeZ+XfGkTxEHDP5ac9FHUN1khPWBQ1c5FgQujekB3
	 4m3WxO0fSRXi6dFHXSooXWNNhQc54AOzkmvk9LlRRmfk78YMWXwKnLu15bqUUtYFZwnGJ
	 q6rTCjw220BeSqdsYambgEpir+x1QnTLQ4XTvMikZL4gTtpKaYVaCRG4xZmRGHOyKsrgI
	 CELltZjmQur3VFj3b5DRrM5r5xpdvcL57uJZxiurzfDxXJUoZeRRjDng5Nk0grVxqBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389421;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=miVYjn4LWR8m4yx5keGSKKopLTEx2IBsUlb+aAiPQuM=;
	b=hlR4kDkEJ4KNGEjyoNojyu8YdI7Bo4rxYe+oS7nESbcrQVXwFQ4htteuK/1UVdxCiHd4
	 lihjuEuLP2CLHkDpeOfiyERIbAXwQG9s+nmmK1yACRRt4G/xjqnuC8Hg1BQJ3qIbjW/Js
	 1Vm60kgkW2mabkAF/WcGheR0mGkQWRs2tRBGlboFZmUQLfRJYSsS6HxOParpLSfW59mEb
	 pMDoVO4SeOwpcDS473FweN/bOxwSOn1AkrxkdoqZDoXGHyj5G+rhQ5fNBcC06a/znN4p9
	 Kl3L1/LEnxahSeZdtqGLil/g5a4C2KZHq+wotSkVOWV58zGpVTrMVNI3exjE0g3T7eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BHhm6fPy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.25
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79360A2600;
	Wed, 11 Nov 2026 09:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C79360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BHhm6fPy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UE4umk6/710NiB9hpY/t5WX+/bph/hKLbAzhj2VXXmaZU9QRh66vySajZeZVSci+1YyApwptwJlBOTSoHdYmqXt0B2w0XaWsPPWrPocOxO27wdoFqwKPxZQo5kPJ4AOqD4ggSzIrl5b0STE5jH3xp1Gg5DG+bCZ0A0RwVfoXRT4ICmGJjoGUBjtRflH3nFEMbfDK/kHV2kEUCX0F6utr5ualqC9NoNf7NIMTzdlZyyKO6os1Nm7n8I0jTbCI7OnamJQ7RuWad8uZEavfdxJO9HXhX8svtUztAxQlNjk9MKIxqKMKEOQFZrt0XyZY9ID9OHwtaQ3XEoCLAKHZCrGTvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miVYjn4LWR8m4yx5keGSKKopLTEx2IBsUlb+aAiPQuM=;
 b=RSA9ljpVHQeS+jHhc0XvWcQFEmOpvHuBX8pf/YVL2z/QRawQafCYtqunjlNZbz2o+YTWxxTFVXe3c+/v0WE5RbcGmI/fUOidE+vv9dyDvbZpnNVzkU1NAWO0e7tFN6PGhA/d3QRBU4LJ6z3Ea6jTGcI25fuPYzwoeepJdgYqcnKaet9hpQqw0d3uAiHv6OMDIgyzDYiRhwxyUHtSL4N+Yk0zIHxRwVuktB8O7sOYbeY7+khioMpRPC32PqL8UJiIG8KGYzb+OMwI0YCUvuYp5GT4WdpdzNZmkJ5cIyTUEqkl3t/yZ9gL9rduPUWHkjqgfrpZ60RCsCvh9tF7iNbWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miVYjn4LWR8m4yx5keGSKKopLTEx2IBsUlb+aAiPQuM=;
 b=BHhm6fPyGfeIVMxT8dRDwlSk/wjTbMl52gvJsjMn/edb7NwFxc7FDnIiyAql825OXuQH5Irmvj/oM7l8R8IdiVY9LQGn1IxxpHPsl9yifH5cf4tBXinh09aZFG0P/2IQQ6Ht+xdaKpN1fkN5vAJPPtvuh8CQzdx9m4LaeHsDWOw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 09:30:09 +0000
Received: from SA0PR12MB4383.namprd12.prod.outlook.com
 ([fe80::825f:2fc7:9ad8:520]) by SA0PR12MB4383.namprd12.prod.outlook.com
 ([fe80::825f:2fc7:9ad8:520%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:30:09 +0000
Message-ID: <e096a872-ad31-4a05-939f-0f5d30b45208@amd.com>
Date: Wed, 11 Nov 2026 15:00:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/rapl: Fix use-after-free on rapl_pmus_core on
 AMD/Hygon
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>
References: <20261013095051.24777-1-jayapalashwin.nair@amd.com>
Content-Language: en-US
From: "Nair, Jayapal Ashwin" <jayapalashwin.nair@amd.com>
In-Reply-To: <20261013095051.24777-1-jayapalashwin.nair@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0221.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::9) To SA0PR12MB4383.namprd12.prod.outlook.com
 (2603:10b6:806:94::12)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 360ead6c-0367-40cb-038f-08df3fd66122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sikNa9i6EJ3NtmBHFusKCLtAoCVceQclDasz7cadMQ7fXdtVMSLdw7iMhSoFbu8iLQ8Ov2Arclq0jpOPQCAtqX8x1qPf5AnQIncwjYhZq8k6gkv6KG7xjtK7VX8i13FPhrU2XFEqldOxOH4VOfoHgngi7IH51cXQQjQYkWOonp7ImL0okidImEBivz+p7o8mLm0a118/2NBqoPpfaPhDiMcHK/k8Ox93+YINSZvEajRyHwYmqo9Hj6XuSOedEW9fLg7AJJoE+TjkQlBANyFUED4YVeYbk+/HZtzjaTjDC2V/g7DC78qoZpugOk88IfwJRK6tx0m/SxjVKphPIpZtrCTTnJITnKPqmx7f4W1CphKrf7Y0o7KhkSdoro9Y68URIGTxwXq8bJ3MfrysQNcLlbbEibyB4P5fVfF4tzqeZnTFd069uSvUCXLmTg7L589xrRAUywIx20O0U1uKfXx70NINn52BHTXSsDhyPc+SPVJWwZmVeNYRxFXMyHHneGqhewmHFpy3b/KjMirhsDF64x14tlhpQ0kcnDZoTtIF3OtMhQhWhCPldihZexcOnie9k2i8Wv3JThJQv9sJ6Wi0sZNeu3LrPnOuiBYfHrbS7Uw29Z/guo7XLG0tI/nx9BeMtRbNZrAwHlFH1VOQYabc24aNHnot+N1xOyohbbFFTBs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4383.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDNSYnQrU2ZxSjByaDFqR3hEakNEWkF6eFArd3FMVURPMkJ1VWZSd1IzVVg0?=
 =?utf-8?B?NUtZOUNqSDZWZFZ4UWRhR0hMcEJNRC80UzNDMmN1SmlNSHRGbjdPdnV6bW1h?=
 =?utf-8?B?eGJpSjNQcDlaN3o3bUh3SXMreGZKOHJzNWR3SGQ1RnBndXZZVHNRNHFZY2lz?=
 =?utf-8?B?MUdqQy95WDBIWlNRVVV6enZ5WVQreWFIWXgvU3IzbVJCeWFPdnpObmMrY1VE?=
 =?utf-8?B?RUZjRGZFN08vM3k4eEdlZEx4Yk11N2l1K3pIbEJNZExOR1dFN2x5KzA0d1NU?=
 =?utf-8?B?R1lBME1RUitrcmQ2aDhaUHdHOWtKZ1UrTFJUNVRuRkNaR2Z2QllmRlpTanJI?=
 =?utf-8?B?MFBRT0t1OEZNcCtQN3NrRC9scUNNaVVpL0poc3AvVUVjTXNPRXBJZklFQklo?=
 =?utf-8?B?anBkZnhXVTFoT0hOVVlTUnBSVGI3eG5lOEV0bG1lT0JDaURRVHh2Z2xubzhR?=
 =?utf-8?B?WXZZT0dVNkJpdXJZRlFnaHNUcjh4MlY1NXFCaVJlOG5FeTVvRUJVVVpPQjF4?=
 =?utf-8?B?eURqeXNXVjlERkk5M1R0TVhtYlYxMnUwMEI1YU5Mc05id2JLblhSbllNZ0Zk?=
 =?utf-8?B?b091eFQyY3VMSFN1aTA0YnpkcnBBMmNQQnB2QXk4MnBYTVhHUFpuUmVNT3pT?=
 =?utf-8?B?TEVjZ3NpWGpsVGYyRjgwOW1ZcEdkOW9pUGFEa2FDVHhYYzJQeE0zODRXWDFS?=
 =?utf-8?B?YlVwcytEblV5TWVhYXlROW4xZmdNRUJvbi9OdHNBdGordWxodWVyN2U3SWxj?=
 =?utf-8?B?cUQ3YjYwZFpEYk5IeWcvblNPWi9OL3RFaDduNjVzdVJkbGhBZlpPU0YxTmNs?=
 =?utf-8?B?NWREakxrMUF6cUlIcGFvK2ZQclNmQ2tvWlNYT2h4a2pwa1hMVGVISG1zWmFo?=
 =?utf-8?B?bzN0QVl2Zm5hL0RPOUoyZkNISFAxUUl5VHcyM1Z1Y1U0cXQ3amRYenUzTkJw?=
 =?utf-8?B?anoyVzViaWZ3Yk5ETGhURkNKVXp0TUlZNXJkNktYcUVieDlUeitJS056K2Ft?=
 =?utf-8?B?VDE1N2pDd3djYmN0bDFYNzQwd09SQjdMeVRWK2FyUStmWUpVM3lrdFI2a3V0?=
 =?utf-8?B?TUF6cjV6RU9wb2o0WVZPVHhtakltQjJJRmc1cTQ4OXNvclQ3NXl0T3MxK1lQ?=
 =?utf-8?B?RFEwRXlpam1BQWd4aS9JeFgzWkxWdVlFTmRFWUhWd1pkdlB2aFdKZWh0aWhZ?=
 =?utf-8?B?NHFmQkc4Y0lvckdicTZDMDdQZkdvb2RKaytidnlGUjB5UVBHMUlDVVVYMW51?=
 =?utf-8?B?SmFXTTFlaDBNQTBEZ1Yyd2k4RkQxVWZjcnN5NEdtWnV1QnFXaWFFS3FJK1Uv?=
 =?utf-8?B?TWxUNHdlZm9WSnZ4UmxFcUlFL3Ixdk8yNk5sempOUEtlVXVaY0I5SmI3NlA1?=
 =?utf-8?B?RHlSU1pEdXJjQVNMR3BMaFFpMlNMVEM0TGJXWHBlcG80Qll1WVdmdEtTaEky?=
 =?utf-8?B?YjlGNjUzY2luOXZRRldHNy9LMTRTT3JBcVNBSEFIOU5nM0g5MmxRMXdSOUdV?=
 =?utf-8?B?U2wvcXp0Zk5SUEF4eXA3QTk3QUhnYnVkSU1rdHhPQXR1NmRwRkFHMy9VYmFr?=
 =?utf-8?B?MjhaL01uMmtBS01IdkpvTjBvZ21IS2ltcE5Vck9nWVgweEJEbDg1RTZIUkll?=
 =?utf-8?B?NC9KRzJJWUZEM1dTMVBTeFFKQnhjeWFJbnpNRTRicjZnd0UrS0ExU09UQlBh?=
 =?utf-8?B?UWNKRjJ0eHNPQ2szOHFxclo0bVhPRXRGSDgzNWJ4VmpLOFRWOFdEMmFzdXcw?=
 =?utf-8?B?YW5uZlpyVS9YNHE3Qnp4RE0rTm4rY1ZUUHlwRjY0VXo1cnpPOFpyYzMxWEtF?=
 =?utf-8?B?WllFb1YweEo0Z2xwOWpBTVc2eUlVcGc5dXhkVGhXcWFNZm1aaFM4LzFoenVE?=
 =?utf-8?B?d1hFMGI1QjlvdTY1bWlmZFZrdm9PMXJjcGViUlE3d29CTWhkblgvQUhYcTUw?=
 =?utf-8?B?WFJKQXZIVjRIR3NFWGRWb2l0dVo5WVVCREk4SThYbVpnZHdqQWw3Q2ZLbUZv?=
 =?utf-8?B?NEhJNUVrM0lHWU5XS0kxZzl0L1FnZGRxNTNFdjRBaTg4aHRWaHBucktwc2Fp?=
 =?utf-8?B?VmpHSERQWWpBZkc3Qm0vYSs2YzVaVVhvbmFTTFAwd1JRYVhMbThTL29DWTNC?=
 =?utf-8?B?MWtZQVMxTHVYV2dHZytwRjd0K0wzZU83WGZzNW55ZmhUa2U2a0F4SWJDN0Fp?=
 =?utf-8?B?ckZGN05ka3FTNUNXQWVLTExEYkNIbFRpRTh0eWdxcU9CYWNSelFpcjBUKzdx?=
 =?utf-8?B?Yk9LS0VBeXhOZmxKOUNqVEJSaUxieGdhRHFBaFFpUXNkQzlOVk1oWjJOVjZC?=
 =?utf-8?Q?OnJ+iEEkSouET/KII+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360ead6c-0367-40cb-038f-08df3fd66122
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4383.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:30:09.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQGQtXIHPsViQE6wc621kubbgJo90NNPGgssagFlUlqNpAI/z85JpKplQOV30fL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

On 13-10-2026 15:20, Jayapal Ashwin Nair wrote:
> The global rapl_pmus_core pointer can be used after it has been freed in
> 
> Signed-off-by: Jayapal Ashwin Nair <jayapalashwin.nair@amd.com>

Gentle ping, Any feedback?

Regards,
Ashwin
