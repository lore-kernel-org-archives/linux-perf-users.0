Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504B33EA;
	Tue, 15 Oct 2024 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728966007; cv=fail; b=FeWx48kX85lP8cdhz+8OYpfeKN6NmT2QgwNNnZ44H/G7BjZNfTOqpB4OV+oSoN9r+qPVkhmJKLzkyM88sZQAT83rixT+4UoSj2L1fdLSKoXkY4+klcfdwU7SwbR45MFp1Ma9PpNkjkAusTjsEWVmQVaV5wR4LPR+PArLeUv/US8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728966007; c=relaxed/simple;
	bh=ZMxlxLpUxl/ytUTW3tF7GKXQ4X934Rj5Dj2CcQr83d8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iHNFLxOEekrh2Zv4AytNFAx0kMLT9We1doUBulstSL+WWoS7zJKLkGYACmbPDUlzHv4EzGnHKaFv8B7vq3uQGHEKBGLPJWvG6GeXJAF+vJgz7hIPLT5ECM3AtPbA4aGQv+ixn9TxaDZYrKFIwXw7Lb2AXWAuU3SNO+CyfgPD1CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hiq5s3af; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hiq5s3af"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMpfT9BnePtZ6E7Z6nGoeZ7GZqLyAxytrDqxgeAKKGxQhNdn0kqWJI7EY1Nhac0EeRjiVm8LIlWw7hNBUbFA1Br3J4r+iU8C2mcZPkPmR5DUQNuunFS6wPChK1o5u/UYdskJIV5JbzslkndXRZvtC+Ef7XVsG3F+ET0Mlj/42GtiGEK+0W1ENgYSYeyHkvwhBtlRQA7Fl0PL/zMgpNk4ZAXRqXMfyg3GyQGIaJkzoxj8g3PKzUL+VMN590BuY0XgwfRrGaWn8GSRv+I8GqmUZ4TAnRQ+7ky9YzUilCD1po4K6XJL2MQ3GNxzM2iCKEXMYIgOq9ENVeBPNKm8f+MnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGkQLqUl6c+wjJ9xNXvtXS5FnZzE+S6+ArxQvcE2a2I=;
 b=X+JFYYOwXdXJ4V9LnX+c29EacFHQWE3qBm+piLPGQdcbFs4uTKBV/fUq700TNwT/AjkDDHCY9iSB9AKXOc5kISWq8ctcKxUt6MRvjZ4axyjSDtQsjdZ9+Xeapu6ofUGnwuy8ETz80jksfcDxSIviEPz5m1qK8CQfo1Ya3bpnDhkGk6ZirAtoMgfMTjOo2T4cRzjy0cDkhBeeLcDFH1XgKYt8XEVfOuAk6d8kW77V4UMrOvjCCefQPAXmEQI+busR8J4F+0gR8y9P0Lij6t8Kxqmij8bqadkxDQNyGSqHc23GS1pVYeBrQmu08JF1bjbuV2QZwsgumuPFVLZ6Y2hasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGkQLqUl6c+wjJ9xNXvtXS5FnZzE+S6+ArxQvcE2a2I=;
 b=Hiq5s3afx9eEBVFl0uu+wWpUVRs360IuL1rIijth9q9tUMowsbqqQykioCBLwjb3db1rU08a4bGT8dvbDQ5DKGyvzb2F1rprRJ7tFnH+aPOn98RXimjaMdzdEZ7nJxLdSlz6sw1hhU3drETCAISRTa14PBo6XmiKVhktGqKUbo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 04:20:02 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 04:20:02 +0000
Message-ID: <97fd7f8c-8593-4018-a1a0-f85e8e4957aa@amd.com>
Date: Tue, 15 Oct 2024 09:49:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] perf tools: Detect missing kernel features properly
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>,
 Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Mingwei Zhang <mizhang@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-6-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241001002027.1272889-6-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::19) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f16dc9-cd22-4b55-29a8-08dcecd0a344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akZEMHVzaW0xRzRIWWNscVdiYXlVd2Rsd1U5aDdoTERJZEFxa1hjOUZmTFJV?=
 =?utf-8?B?RkZuQmJhak9tNVlESEpBSmxHNGpZYmk5REFRSXh0N0JQRkMrVUlYaVlVcy9w?=
 =?utf-8?B?UWd2eHBiWC9Db2hmUEo2QndBcWJhVEFnbmJCZ05UM01yRHBxbTJGOERzQVoz?=
 =?utf-8?B?dmthMWpLdG1xRk1pblh2ZkxhYUtpa2JNRVpoYTVJOU55TzVneWk2cE5kakND?=
 =?utf-8?B?clVZZVpYN1I5aVJ6aXZGRkRVaHgzRzcwMEdkZlh5M1FLT1J2Wk5LNU5hSldv?=
 =?utf-8?B?UGNBSmJ3bkxsRGdBeUNmUE5qY0NybFJIak0rN2ZQUk5UeDRkRW4rWjRWUUY4?=
 =?utf-8?B?SkpzeUtVRVljV0kyUHAxcWR6eGdXcjUzNlFKakVLdUxONncwZmd1TVpVN0ZZ?=
 =?utf-8?B?LzNqVStxZlcrbmExb05HRFlZeUxhYXgzWU1MK1R3NUxpa1dYTm50SE0yWitj?=
 =?utf-8?B?d0pGOHVzRXplY1NXM0JaYmYwd0FUakZaY0pDTi9HenpRa2xwL2lsejcvVytT?=
 =?utf-8?B?aUE3WjFuMWJQSW05cGRXU0hCa2o2NjlXV2FkRHIxaDhINlcreWI0MXFiRDJP?=
 =?utf-8?B?UENlNGlua21aYVR5NXg3UzY3WkZkVUJUV081cWhDN1RPczVzcFJiaFlxdjhp?=
 =?utf-8?B?T3VNRlRzVEMwdnJkQmFubVppNVZwWFFQVjIzaHE5UzJCRHI1Z1NoOEVnRXJo?=
 =?utf-8?B?Vm5JdVBTOGNWbkprcmRJOHdURlJzKytQNWJ3WFZiYjhvQ1l5SEZ6b3J5YXoy?=
 =?utf-8?B?T2duWnFEakw0WWxMQlZ5dk9TME1CNmNkQXdKR3R1MVdUV3ltYis2MFhxQlBl?=
 =?utf-8?B?VUY3YkRndWdTaUsxVTJTenB0WnVVbTRqYkdCOEVYanVoQW1MaXk1K1ZoY0Z6?=
 =?utf-8?B?WmdYR1hod2VLMnhYUzJjVnlGSkdkMGQveEc4MGVVQVB2Wk5lQ01WRExxbjhJ?=
 =?utf-8?B?T2xXS1AvV0VKWVFmMkdEeDFFMXhrcVA5MFBJNFNPZEl2dGNVa3VQT044RzE1?=
 =?utf-8?B?eHJsaW00SVIzVGNCSDM1WXdKV0JkRktwNTlya2NoMkRtT3FJMk9SUW1yUEp3?=
 =?utf-8?B?WFl4WitBbU90QTFOVmtsbVh5L25Zc1lOcmMvcHg4N2JCSy9SMDdJMzZaZndi?=
 =?utf-8?B?WE1wL2UyemVaUk1HMjNLc1pIcXNQOUVpcGJ4MlpDMWtPeE9GcjIxeGZNRE1V?=
 =?utf-8?B?Zm5mRGFvNHVwa08wd1NRVTV5VlRwLzV3cUd3TFNIMkFidjg1ZWRRR1hMekI4?=
 =?utf-8?B?blRQY09YWnBHdTJCc3RobmdENlM1NmxkdktOdHB4STlEWlZoakI3SGVhMEVa?=
 =?utf-8?B?dEJhTUZPZ05CZjg5TGVRcmFQakgwdzZ4M1FXMkpOU1Z5cDAwcFp0cjdQVTBC?=
 =?utf-8?B?T1hMMVJtMnJFSnNSYmNRTHYvRDNvcHBPNFU5WGpCQmd6YVBLS2dLaXQzOTBq?=
 =?utf-8?B?WmpUOXV0UVVzVHJkWGgxTERYYWFkNUsrakZ2K3dyazNod1k0TTRVdEZTL3dl?=
 =?utf-8?B?NXhDYnBLdDVMN2o2QXEwbXpkWEJKNGRJNEJVa2lpbGgrYU5MQ05VcHZjZnFP?=
 =?utf-8?B?MTZwRE5vVS9tZE5TbDdYcWs5M0J1c1NsZ1RZS0I2N09KR05RaGc3blVTQjNY?=
 =?utf-8?B?d0RvMVlnVHpNQ0RUUUd2Z0p6V1FDSG54Rkg2V3ZsVUpnYUZkVThOK3BqdEd1?=
 =?utf-8?B?NkprTU0xd1BKK3h0bUJkeFRvaGVYakk1S0JwbTBYMjY5S251SWxyL2VRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Umg1S0NJN21JcFBDYmsySGx6SWpZVzh3MEd5aVNnTS9xbm81MytRbms1R2pj?=
 =?utf-8?B?eURrc0N3SGt4NlZrSlVuaTI1WU9VczZGelZnak9Ibk9oY21DaG56VXJjcXVF?=
 =?utf-8?B?aDFHZHoxWElRTFFCNmRjSENRMzNyZDFqby91SUJOQlVya2NBWU9XWVhZS05K?=
 =?utf-8?B?RkZEWXIxMzhtNHNuaG9jWjBnbzVJb0k4cldSOUhhc0g0UW1OcUNXZ2d1c2o2?=
 =?utf-8?B?NEpBWEVxWG1nR0RkaVJUa2ZPQnlxYzJEUlN0blRqOC9FVW5iUGx5NGpndUtG?=
 =?utf-8?B?ZGRKSDJwVENMejFlRkZEMWJPVG5Yckdrclo4NS9UcE1GNVdSaXA4UHAwaWxk?=
 =?utf-8?B?UmtSTUZrSVl2N2tTN1JFMEFzZFBVVkZ6MkFyeEVMYWJsWCtPRzUzRUR5NTVU?=
 =?utf-8?B?bzlFdWJyZHhzQncxUjR4TlFzdTJVVWlMNmVtT0Zqb3dJSkJwUXZVOXp3eXk0?=
 =?utf-8?B?ZTAvUHhyWmhEcllrMzlDd0x0WVpOUEVyMHdpL201UU5kS0szR2FIRVFJd0lq?=
 =?utf-8?B?SGI2VzZiWXZoWUFCV2M1VXRjaW9MVkNJS2d3eUJzZnI4c0VjZzdKL1V3bGlm?=
 =?utf-8?B?SGIyRGJaQ0JlMUhTLy8vZkZUcHhQck82L1AvanpZcTBKQlRITHhtTHJSTWdD?=
 =?utf-8?B?RzQ1eHdGYzBKaGlLMkU3TDFMbk5nemZwTU5TN2l3Q05RbTRSbk8wNzNJNXVB?=
 =?utf-8?B?NmpNYnN5b09oV2ZCZlJqdktQQWJHNUZobGI1L2d3TE1TYzN4Uy9mUzRMbnpn?=
 =?utf-8?B?UzZyeTdEK285aUtWYzIzTWY1VU90eFlSZ3NmSEhscktKYVJrMlhvV0luc3lU?=
 =?utf-8?B?bW5wWFoxYXd1QmczZloxQ2dGR05JQVZxalhLUTNJL2RDQ2d1eHYwWTR6UU9N?=
 =?utf-8?B?TFp1Y2U0VGdkQm55dTByTEpEUHJzcDN5T1I0YzlHSzJvVDZ2TUplaDZGS3dz?=
 =?utf-8?B?NVdlOEdqRXJaVjVrQ3drS0w5UnM0RHBsbUZGTkFmQkhUdTMvNThpWmlGZlZY?=
 =?utf-8?B?U1RXZlFNNWJaYUdqQWtwKzQ4Z1JyU1VDSkNMWTBRM2lDbUhYTWRhTmxiTi9Z?=
 =?utf-8?B?TnJqbGdkV1lyWDVqZnIxMWxQR29MZUkzbExvdnI5T2hzVzNjTGtJWXRITUtO?=
 =?utf-8?B?ZXI0SGRtREllNTMyZjY0ZlBNU2Z0ODA2Y2FnYmlJN203b0hBMXN2eU40MGtt?=
 =?utf-8?B?QlJKckFlbDAxQ2ZXTTMyZHJibDQvVDVBMlVLbVVSQVdsd2hPemo0b1d3cWNJ?=
 =?utf-8?B?WGpmb1A0blZYa1RlT3VKL0tVd2JVUlFvUDlPRnpSMW9NM2ZUTFdkTEphclFQ?=
 =?utf-8?B?d2VtRDFOOVZWR0NlbTExSlpVc1NFcHBPTWNkRkN5UEVRNytPcmlXOFpjYzRy?=
 =?utf-8?B?ZXQxekNZYVRFQUU1SHZORU9BOTFqek1hL01pZmhsSlJLb0JaZmI3czJrQy9h?=
 =?utf-8?B?TFhoeXNNbUZaRjllQ2tOTVJaOGVtdzhvc3FuSUhSVFRKZHI0Y1A2TU10VWhn?=
 =?utf-8?B?cXpZc0daamZ5YlZiZVlrWDlSNElCaTE5L1lxOTV5RVlzKzV6SFVFWU9ZZjFV?=
 =?utf-8?B?NXBQSTRrQlR3dUJDK21xUnJ4ZXdPU0g3N2VTUXlSbnBGbVc4MGZJenloZ2Mv?=
 =?utf-8?B?MG1WSFRseEt5RnpXeUs1SEdleDdzMnRQYks2V0t1SkcxMGt0NENobVlCVE9D?=
 =?utf-8?B?VmJzT2lrdExwa0xOaExsVDEwRG5aek1ldkNKaVAxa1h2SEtyeU9uZ25ZcENZ?=
 =?utf-8?B?Wld6VG4rNHJwZno1dGZpdzFkWmlicG85SEE1WFozZFFIWVZYeUpQL04xQWFG?=
 =?utf-8?B?bHQwbHgxRzd2L0N5Y1VFd1Q4eFBLZzRFd0MxQUlpRmFWYTcrWEVMaFJnZ0h0?=
 =?utf-8?B?SlN0eTlwdVQwTEkxdGI5OHltYk0ySWdUQnQzZU84TWUxMXU3V0M0MEMwUGIv?=
 =?utf-8?B?YkE5WElVbVFWK0luc1NQZTdnYWFoSmpWc2o5QmVqaWNFTmpjeUlkMHMvS1Vp?=
 =?utf-8?B?NXc0YlhoZVpZWTkrcWl6UlVnWVFhekQ1ZmE2S2ZwdEJtS0p5NW1BWFhIUThU?=
 =?utf-8?B?aXltMlJuRTJXWlVJNGF3V3dGbmpnNG5pelI0czFyWlFGM3MzNlBqWG9ibTIy?=
 =?utf-8?Q?A1xt9d2m8G0vCqSlcI/gFjDbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f16dc9-cd22-4b55-29a8-08dcecd0a344
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 04:20:02.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eurmSFWcuprcGLIA/ftZgAfzmZpjpnSOMgjr0yH+G835GpZ1AA07Ays77BDo6GoibBSeQjBZoptsG1YAL0+FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

> -	} else if (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) {
> -		if (evsel->pmu == NULL)
> -			evsel->pmu = evsel__find_pmu(evsel);
> -
> -		if (evsel->pmu)
> -			evsel->pmu->missing_features.exclude_guest = true;
> -		else {
> -			/* we cannot find PMU, disable attrs now */
> -			evsel->core.attr.exclude_host = false;
> -			evsel->core.attr.exclude_guest = false;
> -		}
>  
> -		if (evsel->exclude_GH) {
> -			pr_debug2_peo("PMU has no exclude_host/guest support, bailing out\n");
> -			return false;
> -		}
> -		if (!perf_missing_features.exclude_guest) {
> -			perf_missing_features.exclude_guest = true;
> -			pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> -		}

Shall we get rid of:

  perf_missing_features.exclude_guest
  pmu->missing_features.exclude_guest

they don't seem to be used anywhere after the patch.

Thanks,
Ravi
