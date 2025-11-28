Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959830EF9D;
	Fri, 28 Nov 2025 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329636; cv=fail; b=IVlCiab+N/ZWO2n98nJOuPU0my3na/R3xcNCYvRG98Z9QqqXWukt2CwxJYPAfKl9OIgtJJ7JrunUPHDE4FBaZa+S2Vbuvls393aQJgKsFnhzQtTtYN+HrX2zMd7qy6GNWq0I2znnlYwgQCgVMPZlNs6uVjFhfz9ahwQNXm46a3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329636; c=relaxed/simple;
	bh=IUZ8/OVBe5JLexUsunbn2vz7ZS2Wxyv0bND0h7uxl9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P8/BMw/5a+uMh9pkhU7MkVG5qlor53YTBsc8h3fSzqRHChuBjup9fHf2feltfTOLkZA0Fm9GMSL2DLEetlAWguCyC6ZDG/y88uTXQAVhoKgf8vDHSk8KPYbVFFITZilEwdwcEv1lfqOXu2i+ghKMxLHe8M9y0XHVGyzJnHxwEic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f7aJCwof; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f7aJCwof"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTv7KgTweMPgZhM7pYozDMrTsFKanoOFAxvTE4hwtpSAReKEKv5uAFwhuNNO9+OATfY7YUljXsG/QsVW3eJFXb1RjHFWGV/6WviHFXhelbffFrbvhfzV8FXmORVsXNMstGbw2x5I1Zq6P8HmVgGAnZmVpG/3KGjNSTEhFrelzmr3628cpNgQ2Fej9k1cd8s2fC+JYbcd22uh77rlcU5wzefPayQ4fmPCIyS4VO2nF9QWsEZy7ukzYLOpinbb2kzWWmmarCtEDfQCeD6rjXYb74+d4Jl56Sr5GaUjxEAcR2jzFx2o2CFP/bpR/QjYRLbxHg2NcQK04BZqmcYeWAu7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpDZq4ZNKLQMopSh7DDQ13a9YSm6BueXIApePgVK5Fs=;
 b=BKnTFB8HLhLpCUnUOI+nfC1LcuskzKL2ghOX/so/zVHO7A3wiHKRdcUcM7U2yHgQcdU5Yl8iTEII/HQ/kO5paqbWNO80I8YuQjamDqWxdM4ZZ3TQqJHLLzyH2f7t6MmEnPIOS1UAoFfAgax+zcUOo4mq40343UcwOBv7PiqgPrFNGlhr0OGX3+Ea3Uvr+b+UoFZUa8pB+S/ZmVX6Yjnr9yBnqwUfT6nvt3qD0WvOCCNBWAZBpEKNwwCWsa6TIgc8iw7SgpEvcIXpEoEZ/5s/ZJkVIR9gSgSRwOyNIGDyWyaEuOlFuK/HON0cl8QIZBgyt11mQRCcKqn2qAYDqiachA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpDZq4ZNKLQMopSh7DDQ13a9YSm6BueXIApePgVK5Fs=;
 b=f7aJCwofTX93x4RG+Mz7ewVpDUK7YR6cujAO+f1jVd9+6NfxAEhJVoH2/mx7YZZzhA/uI7UlgJ1TOl1qRYfZGnCd7CLY5/cYRdCN8KPLMF7tlruoDnfvtkQ3ew/NPKGJNDDkbA6Et7KcefqpwqQ8N7fIs6hAu3vv4xhIICoc++o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 11:33:50 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 11:33:49 +0000
Message-ID: <f7ad550d-0547-414b-82d6-a85e208a5c5b@amd.com>
Date: Fri, 28 Nov 2025 17:03:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/52] perf jevents: Add RAPL event metric for AMD zen
 models
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
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
 <095bbbb8-4a65-4888-aa7d-39ea09a52b84@amd.com>
 <CAP-5=fW6er5djFROP-SQ64uiN545wfHoyZazugya1h8JXXyvvQ@mail.gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <CAP-5=fW6er5djFROP-SQ64uiN545wfHoyZazugya1h8JXXyvvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0235.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::13) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c794c7-f78b-4214-1e96-08de2e71ffe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdzaTFtQk9sL2hobnRSVjdINkUyckVhR2h4WlZXa3NiL3c1OGhxV1RYdGZk?=
 =?utf-8?B?N0ZobCtTSUJHUTZ3eEVmQ3I0TjNpQTlORzdqb2NPWUYxRzVZalBSQnY2amo2?=
 =?utf-8?B?cW54WEg4ajlwakl0SXIrb3l1Qi9hVlQzcjl3NENSRnJUUFZPaUpUZXJkbGpQ?=
 =?utf-8?B?VWdsQzg4REdSWUpqUDJEUUU0d2tGSjg3TDdLa1Z4YktWempWMzZOeTBzaWJO?=
 =?utf-8?B?eG4wYkdnNFVqbTJ6bVA0ZWFUUmcwazdXNDZodG9jTmxVWU13Q294a256aHRT?=
 =?utf-8?B?dXpSNWRGK0hlRmdkM3hpcUlkblZiWVNmTFMrZkVEUFd5dTB0YVBPWFl6RWE3?=
 =?utf-8?B?eG9kUEdlYzY0d2tYRGNTdmc0Z2VmZ1N1c0xXblpkbGRyeGV6REFqTVdTOGhE?=
 =?utf-8?B?UmNLZTM2NzJpNmFRN2ZBTWZZejRJdFNZdUdZMUwvb1ovaUlkbjRvZnUyWUdQ?=
 =?utf-8?B?R1luWlJHZi9jVWJhQkpTT2I2Skp6NDVLV1RYVkFTS3pJcURGV3JDbDJaK1do?=
 =?utf-8?B?dzZtdFVRNlBScUM2RlhwRmYrV2tCZmc4dTNBOFFuYlN3NHFrNFN1bytWV3lo?=
 =?utf-8?B?ampGMGdBM3o4ZG4zWXdXNC9VY1cxNGF0NHQ0UFF5dDNwcmFPRlpyZDVld09J?=
 =?utf-8?B?WUVtVk5WQkYyQ3hFTEs4bERUbUY4WkwxUVZNOEFVUzhSUmdjSVd6QjNPTko2?=
 =?utf-8?B?QUQ3cVVjQ0dlbmtKNllXdmprM05ZWmc4RUFIVlg3cTNnZmRaczM5aHRxSFVD?=
 =?utf-8?B?bkpCdnE5ZEZLM1k4WHkrb1RxTnJCRmhIZmhCbGYyZGhuSHhkOVhTOGg4MGxt?=
 =?utf-8?B?WDEvQkRVNUFDbklLUmpKM3VEREZUcmNHaTdJU2thYzNpQ09MSW5ZRi9HdzEy?=
 =?utf-8?B?dnBYcjNVMXlrbXc3dmY5clV6OUpLZ2tvS0xZdjJxdzR5QmZGeExvZFFRY01p?=
 =?utf-8?B?R2F4V1hPc2lPbnN4OWwyQkxSN0UxcnFQS0ZzOXQ3SG01Y3RJcDFzZGhvcnRX?=
 =?utf-8?B?YzQ3akZkUEM1NlpoeVZhay9VU1gzMXMvaW5wV3BGRHBkUGtVUFFGOUlZVVFK?=
 =?utf-8?B?UFVhSXBFQ3JxeUk4VXp3RS9xY2NvVU1KMUV4c3lIY203RUNwVFpweVV0V1pF?=
 =?utf-8?B?Mkg3ZzErYTFIVnd6R0Z0T1VqTXlFbUp3eU1CUWxmVWQ5QWxDb2pQb2xWSk9D?=
 =?utf-8?B?d2RPT0NUVTVDZWxXTlh6RGJjWGkwU2VUZTg1R0liU0V4RHhoSzhXMjNzRHJ1?=
 =?utf-8?B?ejdQSVVxdGoyM29sdVNMZTNDQnZaLzk1dCt1R0g0OWc4LzZEc0xTUXMzRVpM?=
 =?utf-8?B?MW9ubldmMFFtUTBMNmRuNG9FclpsYk0xZ3orRVlFaXBLenNKVUlSTmY5R21J?=
 =?utf-8?B?bmVubWV4ay92dktBalFKS0hkUDNLRU0xL2ppcnJ6WHhCL1diR2tTdHFSQmdu?=
 =?utf-8?B?Smh2K3JMeVp2NWhCUDMvdlVRVnBiTjFIVFJTSFZ2b2ZoUmphQURjcXJONE5H?=
 =?utf-8?B?K3NGQXV4RWtqM01ub3UvUHk2R091VkxqYUpmZ0VKbCtTTWhkNjJIMENOdWJm?=
 =?utf-8?B?akRXUEFFSWl2UytmZGVHeE93OERnWVRVYk9CYXpxZGZMcTdJeVpZZHVSRGV4?=
 =?utf-8?B?SG1mUzA5anNZd2xudGxGSXlpb1pwN2xCZ24vOXN5cXlQUlpaMU1hYmJjRTN6?=
 =?utf-8?B?R2JUMEhvS1JHUXMxYWx4YW40OHlrREFpMDNhcThiUXA3VmRyK3JtOUpyb3gz?=
 =?utf-8?B?TndkTklXSTllaFR2MDZEN1ZZWjU1WGFKbEdVM2swUlJPNncxOHM1QmFQMlow?=
 =?utf-8?B?VGtaVmtjR2ZibHJOY1E1VndqYW9OQzZRc1Q5cGhMeWZUbUZJcDd5RmJCSTlL?=
 =?utf-8?B?elFiMjVwOVlVaGVBcm91T25mZmc1dXNsRjdIN29ZZU94TlozNmlYeFhlUUZw?=
 =?utf-8?B?L09YRk1UQ3pmQkZFNXdNdVk1d0Rqc2w0SnQ3SGRuTU5zSGJOejZoMmpZYzFU?=
 =?utf-8?B?TkJIT044ZUhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3dLQ3BsU0J1ZzZldnFjVzdQMGFNZ0orcWRkZGc3SnAwZVphckZ2MkxiK0VC?=
 =?utf-8?B?cDBqMVdQU2tQdUJtbTRxTXo0YWE2K2ZNOVJGaUlXQ1VrdW96SkJvVlZ6czBQ?=
 =?utf-8?B?eWRVeVZPMTlBSVczL3pOell2aS9WVlFBdm5ZNzRKUmhVNVhPQ0NSb0g0dGNK?=
 =?utf-8?B?T1BNQVRHTzFNUnErUnpuV21lU1owdjdJVmV3U3dMbW1CZGZZSU5JNStiY3Vu?=
 =?utf-8?B?b1U5Z00zVGFUSmhiWUFuY211S3FLbVVuc092ZzRUUTZkSTlVc1FmWkR0L0hF?=
 =?utf-8?B?UUVuYTRsb2ZKcUZIWlFHdStYNVphWTM1UXdVSnJqZ0RDbTVuQm5TR3JRTjEw?=
 =?utf-8?B?OWtrOWlYYzNwdFJjN2E3TUJITDl5eG83Vno2b0F2cGdmYjltK0hTQmw0VEtE?=
 =?utf-8?B?TkV1S1BuWmNWeDVOQml2M3o3cDFIQUlveXRTZHJSRmtjaEZ1ZUhZeWRwYThn?=
 =?utf-8?B?aTVLUGtpMzUrWXNrUEZiR0RKWFF2eEVoNElWNUtHaDlQMXBWZEtIbHcyZGM4?=
 =?utf-8?B?aU13c3laWEUwT1ZTbnpJV3pSbnRTRXlFMzNFT0NoK3ZaVTJWNHBnRTcvZkkx?=
 =?utf-8?B?UzVHNUpzalk2azRrZUs3Sk1iR2traUtKajNyUTRnYXFFWFBqcnFQamtTTmtk?=
 =?utf-8?B?bnFJY3BSbTdtcDhveHhWbDVSY1dIOVkzM0VuZkhYZGkwaUF3Tlp2c3dGSDgr?=
 =?utf-8?B?MS9ZTHhrNk15bzd1QmRCOEtRc3JpWUdwdjVYa1pZT1A1ME9NMTFkMDBaRGNQ?=
 =?utf-8?B?R3cwS3NqeTN3OHIyMVl0M1phalZKTlpWWHZ0NkJjODJMU0tObGxNSEZCVFZy?=
 =?utf-8?B?cllOUE4vSXJBaVpoNnd3TXEvWUsvZGlaeklqcHQyTHJxTzlTaUlKUFpzaHNR?=
 =?utf-8?B?dVh4Z1VUTnp6TlZkLzd3Tk1wRm9LRmh1QllrSG9JZTh3cHNmbWdUOG1JVlJ5?=
 =?utf-8?B?a0lwbjUyU25aZkx0MThXV29zM2dnOGhuUll5a3lBenE4MyttUkN2VWhpM3F1?=
 =?utf-8?B?aWZheGpyQms1VUxRQjg1dVVyU2RRMlJ0ak9BbEdjdjBIaFFDU0Q3Tm5ITFFj?=
 =?utf-8?B?dFR6aHl6ekViQ21rL0xPdS9mYy9iQ0pHSFJaS1MzR1BYZGc2VTlrcTM4cEpq?=
 =?utf-8?B?L3dzcWs2K1VaalF2WDNwKzk4YW9XWVpnelpqci96aEtSV3ZRN2tIK1lKUk14?=
 =?utf-8?B?RWhUOE9FSUZWcXpES1FHcVFxWmxHSXdCdlgrUWU4SVNMOGtHN2tmeFFNODBl?=
 =?utf-8?B?c2ZqaFR2TStFbXI0TXFWckRpVlhMK3lKQkEzbEpOdDJyZS82VXlqWWhQd0Ey?=
 =?utf-8?B?MjEyYWhCbHV6Yk10bnl0MWFmZHA5dUs1by9vbkdRZm1vOEQ0K1hsT0hoK1pi?=
 =?utf-8?B?V2Z3VnNmMXcxaW9VQlgvWWd3NE54aUlha0xzcDJBdVkxVUlXOXZKWlFKSnlx?=
 =?utf-8?B?LzdNSC8xTmxMdk5NNWdENDFqR1Z5akdEQmRTa0Z2YXg0alRHUmRUMklxZXJY?=
 =?utf-8?B?L2lVc0VndjJUdEZwTVd1ZUFhaFhxYXpoTlY0Rk1ERHRrK0k3UFF5NFIyTjFJ?=
 =?utf-8?B?QjMzNEVySWh2UGNHdllMRXc1WjMxd0hKNFBGZlFFVmY4Y3lnMWQ1VFNEc1BG?=
 =?utf-8?B?cU1nemxoZE1ZOVczRGJwVzBvUmFhMjgwNGNpWU05RnoyWVB6UE9rVFN2REF3?=
 =?utf-8?B?T05vMUhWbHpCQThrbEZUYlIrc2J6dzZ5L3U3NVNkTHFURDlUUVZUTEVQU2Ny?=
 =?utf-8?B?czRiNlRQK3FxQkZiRG55dzFwd1RjWDBJWkVTZ3N2ZjExMmRReUZwNjJ3MlJB?=
 =?utf-8?B?dllqOTYyYWVUQlpTY1hyZ3o0VVhBc3czOHJWL1cxQzFjWWtvSW4rVm04cW8r?=
 =?utf-8?B?MXpQN3JUWUhYaE1UMkNHRlZRamtVN1ZEOHN2RVBlUFowcmIyYWo3YzJuWHh3?=
 =?utf-8?B?M0I3aDdKYmY2TlcrRHlnaU5GTmN6c0tzMWdITDVVS0JVTFk3UEVtbVh0OXFt?=
 =?utf-8?B?S1BsRWFxdE5UcE93ZThlYmQ4czVCN2pQMkd3dEVqaVhaMlprZjhnbCthOVFW?=
 =?utf-8?B?bUhVVG5Td1pmUVNDS1JMcnZISXNmUDFVa1E1WHN2UzB5Q2prOXFpZHRsNG5m?=
 =?utf-8?Q?Y4By1PmYTj1K17RZEUNHJBnqm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c794c7-f78b-4214-1e96-08de2e71ffe4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:33:49.6515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJimQyhQYcg6fX8Mefcpk4VvoOR4YeEkw+HT6MgxgC5xa8UvehsL7oxGoMismGty05Jt4fvH9bX+l2Gwq7BNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

On 11/28/2025 2:50 PM, Ian Rogers wrote:
> On Tue, Nov 25, 2025 at 9:05 PM Sandipan Das <sandipan.das@amd.com> wrote:
>>
>> On 11/13/2025 8:50 AM, Ian Rogers wrote:
>>> Add power per second metrics based on RAPL.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
>>>  1 file changed, 28 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
>>> index bc91d9c120fa..b6cdeb4f09fe 100755
>>> --- a/tools/perf/pmu-events/amd_metrics.py
>>> +++ b/tools/perf/pmu-events/amd_metrics.py
>>> @@ -1,13 +1,36 @@
>>>  #!/usr/bin/env python3
>>>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>>  import argparse
>>> +import math
>>>  import os
>>> -from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
>>> -                    MetricGroup)
>>> +from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
>>> +                    LoadEvents, Metric, MetricGroup, Select)
>>>
>>>  # Global command line arguments.
>>>  _args = None
>>>
>>> +interval_sec = Event("duration_time")
>>> +
>>> +
>>> +def Rapl() -> MetricGroup:
>>> +    """Processor socket power consumption estimate.
>>> +
>>> +    Use events from the running average power limit (RAPL) driver.
>>> +    """
>>> +    # Watts = joules/second
>>> +    # Currently only energy-pkg is supported by AMD:
>>> +    # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
>>> +    pkg = Event("power/energy\\-pkg/")
>>> +    cond_pkg = Select(pkg, has_event(pkg), math.nan)
>>> +    scale = 2.3283064365386962890625e-10
>>
>> It is unlikely that the scale factor will change, but would it still be safer to read
>> it from /sys/bus/event_source/devices/power/events/energy-pkg.scale?
> 
> Thanks Sandipan, I agree with the feedback but this isn't something
> the metrics currently support. I'll keep it in mind.
> 

Thanks Ian. Parsing the scale factor and unit will be a nice addition.

> Wrt, the other feedback, I'm wondering if we can get this series
> landed and drop for now the patches that you have commented on? I'll
> move them to a follow up series. That'd make the AMD patches here
> something like:
> 
> Keep: [PATCH v8 15/52] perf jevents: Add RAPL event metric for AMD zen models
> Keep: [PATCH v8 16/52] perf jevents: Add idle metric for AMD zen models
> Keep: [PATCH v8 17/52] perf jevents: Add upc metric for uops per cycle for AMD
> Keep: [PATCH v8 18/52] perf jevents: Add br metric group for branch
> statistics on AMD
> Drop: [PATCH v8 19/52] perf jevents: Add software prefetch (swpf)
> metric group for AMD
> Drop: [PATCH v8 20/52] perf jevents: Add hardware prefetch (hwpf)
> metric group for AMD
> Keep: [PATCH v8 21/52] perf jevents: Add itlb metric group for AMD
> Keep: [PATCH v8 22/52] perf jevents: Add dtlb metric group for AMD
> Drop (or perhaps keep and followup with miss latency): [PATCH v8
> 23/52] perf jevents: Add uncore l3 metric group for AMD
> Keep: [PATCH v8 24/52] perf jevents: Add load store breakdown metrics
> ldst for AMD
> Drop: [PATCH v8 25/52] perf jevents: Add ILP metrics for AMD
> Keep: [PATCH v8 26/52] perf jevents: Add context switch metrics for AMD
> Keep: [PATCH v8 27/52] perf jevents: Add uop cache hit/miss rates for AMD
> 
> Is it okay to use your reviewed-by tag on the kept patches? If I keep
> patch 23 for uncore l3, with a follow up on miss latency, then are you
> okay with that?
> 

I am fine with patch 23 currently not having a miss latency metric.

For all the patches tagged "Keep" except 27/52, I don't see any obvious
issues but to be sure that the interpretations are correct, I reached
out to our internal hardware and performance teams for clarity on the
behaviour of some of the events. I would like to wait until I have the
answers.

> 
> 
>>> +    metrics = [
>>> +        Metric("lpm_cpu_power_pkg", "",
>>> +               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
>>> +    ]
>>> +
>>> +    return MetricGroup("lpm_cpu_power", metrics,
>>> +                       description="Processor socket power consumption estimates")
>>> +
>>>
>>>  def main() -> None:
>>>      global _args
>>> @@ -33,7 +56,9 @@ def main() -> None:
>>>      directory = f"{_args.events_path}/x86/{_args.model}/"
>>>      LoadEvents(directory)
>>>
>>> -    all_metrics = MetricGroup("", [])
>>> +    all_metrics = MetricGroup("", [
>>> +        Rapl(),
>>> +    ])
>>>
>>>      if _args.metricgroups:
>>>          print(JsonEncodeMetricGroupDescriptions(all_metrics))
>>

