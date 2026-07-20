Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022083.outbound.protection.outlook.com [52.101.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194E26A1AC;
	Mon, 20 Jul 2026 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784512220; cv=fail; b=o6l+4nmK7EppiCyEt+1zB4Ztm/8/a4uMKV0vmPipAt2Dy+xWqesrD44JC4FJJWVXwiZv9sk+7jOutpP6eFSwBkzhkWSnR4TEYdJLg4yFP/TzRQECzS4OQNw/w3tswa5ING3BpnfmrrNYcnNwtPqhbt4aQxoeVj7sbxb5BpquGOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784512220; c=relaxed/simple;
	bh=cachaIUoe65Pgf7GUcJ8FPyyiimbE8pKjwaTmDmgr+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UkFBMY6YIGvyvWl6ZbVWcQLUpyur0wWo+N497IZOMPt8DLEU0uq+mH+Z7rmpLx038L2Gmd16R71BIEk7I7tXVpQk35FOHm6NYDaB2RDAvvHRdV6SGXac0lsS7I3WeS90ARaTh5Ag1Hfa2hV1UZxsVnfkW4wz/wNQGbnoq1zOqWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+1UTt+B70AMjsb7tkC8ON+S8vJ1nb2LZX9JlRITBhnwREdzG68ppXNf2NAAQznaNNomm7lf8Wngdthvzbat3KnMF7wBn50cOHOvntjF5IC2IeSz9TpPVr1oT75SzesgT9MxJGmeLjpRxAOkRNSz/UcvTPtSLJKeoTgaBHOmTz4Az529PkrSTWQfDzrgkuBV0a1OGnpmwJOc/AvwZ0NC9y1oNqLCJt/AAgaB9x+mxwBCAd4dsO+8xHtPqlNsKtTHexHqUTBShKjumV7LHa7eRquD7kVnW9SNG66NSRorC61FuUVoqZT5/wH5SgLYI3087+rwypBt7WcdtzfcJj70JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=cdRyAQwpgPF0d+9dQb8vH+SuHMfdN2svk/SL4ni9vLM=;
 b=Sjvcu2u13xVKT79m5Skb3W+uhqbkhY0wzYNjbxLcJaEYDYcHkLPsgAcHrbNgf41Rkxlqt0bMAytl4N2VLEeZwxIHTPhHYGtOcRmk6CrMkflcTScou6gXWtMWwQz1g1DfITJ9xb2a9yTabRjFP+ugrmu4ePgouIRbn9OW2AXQtYAbDdnazyTaCpVPk4VKLzOnaHrQFJnQJQ1DMRMk8QV9U1G9fuoNlKr8ie/O5r0P864fFTs/xF22/OCZvkQ6MQ9O6l6g312nzSDE7YzrA9oVTrIV7JUyVyYgT7ecBOXztvwalZ/XE6E+vbptOIg3LMNAac3KUiljNNFvjicG0RN07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6696.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 01:50:15 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 01:50:15 +0000
Date: Sun, 19 Jul 2026 21:50:12 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, 
	sean@ashe.io, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Format instruction pointer fields as
 hexadecimal
Message-ID: <qq4tncuxgh3dzasl4thzbkqsbos4yfi2yqfd3tbdm4akgnh7s5@3g7aroedeaw7>
References: <20260719191000.441985-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260719191000.441985-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN0PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:408:141::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: fec406b5-70a0-4ded-2408-08dee6013eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2TnyfzUMubR60tGl/76UHEddeLnAYG58sl91hSFP2ueLWqfQCI7m3Jd/9aBlPiHCPJ7+qm3J2JnsJjiwRQtpRipif1rGus5oTteFYsChWOnaY5DwbcZ3dsjharaxN5ap2larqs/fk3AVnWF9+VM2qoP5dPQN6a5cpu+DNgxSfXd1bhocUb8wZLzVd9wQspWDy2044/mY1p0IxYd/LajRQJlaTvnUpDMOTtpvF/hBs9FktJY/dpkUoTm7k63UPcvn5PTbkIivk/zVFg1HhEF1R9okHfhalP3zeihMTFBqfk33uF11RYRNFAjiCvAlgbnXJjiJq7XEKjRlqImToTqsR7odt1GQ0cVYggxjCFfZrm8LCjciJOveBo5tXjAuqZhxYRT6vLOfXvv9SuH6t8j3kWwseWaP1Ek3kaKlR+ksojym9p/rzwSPcCVUXnFPwRGsPe5hHjV2gTfCsY2E7yN/re3zHPtx3W4fHAsLPczCno1zFBr5loG7y+aqq0vqKxHa2efVUWHzU+pOP6Pw78pUe2AJu7j74pzS6rg1Lpxvneb6zgMxh+yeD8OUTpO2Rynb8XrFKLH/0NlcQhsqMvjj9DCReglPlX2D/YgBhlFEe73UDeohUN+rLnKO1ctHlw9qHXI4LLoWKTWCxrccGSvk1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHNZN2NMWi9tck1TYlIvVlU2ODhYNDZFYTREOGhsMDV1d21hZ3NMditrcEpB?=
 =?utf-8?B?U2FDSkhYRFNHc0V1b2ZtQm16cEVTaWtPZ25QVkkzQkVTT0EyQ054ZHFvVnhn?=
 =?utf-8?B?ZHV4UDd0UG1Gb3FjMFZZMU14N09DM2dZL2lUcC9vUVVsTUVKVWw2S0JiREJY?=
 =?utf-8?B?c0QxS0h1N0pwaGVnL2J1MnovcUxmSjJVQXd3Zlp1ejVWV3RoY0QzcmtZek8z?=
 =?utf-8?B?U3ZNQzVROXZlb1JUcE44QVE5cDVuWU5sbjUycXA5WjBwUkZRRXQ2NlVrZkM4?=
 =?utf-8?B?Ykd0azdlNWR0MDVNYTdDb2FhNjk3ckFYTTRrL2IyenZvcnVrMjVtMFFiN3Fh?=
 =?utf-8?B?K0p0QjVHQzFZTWFpRlcra21HSFdjWVhZQ0t3ZG1kWnRWRzRGN3hLaGRmSkxx?=
 =?utf-8?B?c3dDeHNFYStPN0VXUDFhSElxc2laSjBZZGtqaEtjTkRRU01qSGNQV2xIMUx2?=
 =?utf-8?B?NFRpWHdzaTNXdWk3TncwM3hhdmdjWEU0T3NGaXBoelhjcVB5NWk5c3J6aW8v?=
 =?utf-8?B?V3ROMGcraU54TDdUMUJ6Rlo4VC9FUmJMVVBjZVB4NmxFQjN6S1ZaNVlicEJP?=
 =?utf-8?B?bFJ6T3gvR3NidmJ2Ym5BWExYUHZwNEVwRmJNVk9acVZ6VmxQSlNjZlREQlFE?=
 =?utf-8?B?cktGWDNqRW5TazNaeHMxZEVraEZKR1JEdHowTG0yRVBPUGRINEt3SHp2bVNN?=
 =?utf-8?B?S3I2UGRJNndlMmZoNmhjVmlzTlFqV3lBdDMvNTRCTTV3RFlyRStwc0VVSTlZ?=
 =?utf-8?B?R2xUVCtZR2pUZmN6Qjh4RHp3V2lQcHl1KzNmRk4rQWlqZythdEhmRUJleDdJ?=
 =?utf-8?B?Y3FqQW1hakxOak9GYmVlV3hQMlhTVUVEZUg0cHlnNklGVzFlVUcwblNTOS9V?=
 =?utf-8?B?cW5SMFhCdFp3bFcvd05zN2o2Q1g5UGlJUGpQUGw5MzJEdzRKTU0xWlhQWWNY?=
 =?utf-8?B?Q3VFRTk2clcwdkRHZ3FSazlMVkR2L0NyM3h6QzB0N0ZBQmx0MDd4ak5XQWx5?=
 =?utf-8?B?d2NzWWFzaTR6dVFGNlJrT2FHS25YTSt4YTFRcTFzdVQ1akpGc25GS0lWQ0dG?=
 =?utf-8?B?akhoUm43M1l3Y3BTOVZ5NnpwUjdldFZESGNhc2ZIS0t6bHRHVEh1dDkzWnFo?=
 =?utf-8?B?NncvVHlZNnNzUTRmaGxHcnBUWkZqK2dldjBFMlZHWWx1NU00WTh0MzlZZldG?=
 =?utf-8?B?SUc0L1JQWlBTcWIxQzB3ZGhJSnJRbjJjYk9EcEVTK3M0eXlNdzhVaUl3b1Bp?=
 =?utf-8?B?aWI2bmYwYTArSHFMd3h2aXZhQ0ZrcHNxMUQza1hZVlN0Q2paUHUrQVVXWFd5?=
 =?utf-8?B?Y1J5dGVVS2wzUnNFQmZCT3l2bzdnV3lCWHBOR0NNQ3N2a1R1dk01S1ZXNHhq?=
 =?utf-8?B?NDg2NU5XRWpRcWpQeUZKajNuNGNHQTNjQ0FveWdPMEw2T2hlSWtmRERIS25o?=
 =?utf-8?B?RnVORjdrbTUwZ290MmhYWVkzT3hSQnpHVndTVjh6VWhxUHA3SWQ5Y1V4eVNv?=
 =?utf-8?B?U1ZDSjhQQ0xVTDBkOG1WeFc0eWwzejFEblFxbjdzTUpLaWdiT1BkcXJFOGpP?=
 =?utf-8?B?S3VSZmJDQURnOGtycG45QU5NYzVyMmNqa21ZSHd4WVhycUV6dHBFaFNOUmda?=
 =?utf-8?B?dzM4TEwzc2oycHliTVJtTzVKK2paTnpkZENIbU5lUFZtS1E1cmx1N0NrVk5E?=
 =?utf-8?B?Tk9xd3dPUUQvWDExVVBYTG9xNTlSREdjN09OZVRwYnU3RlpXQTJYR253bFhW?=
 =?utf-8?B?cWFKS2YvOVM5aWoveEh2bHQwQ2RvSGZ3Zzh4azltdTJpSlBaalQwd0l1Z3FB?=
 =?utf-8?B?M0FuL1BLZVZMbmgwWTR2azNhVW5EdnkvQzdwdWlvam9iNENtRzMyS1habi9O?=
 =?utf-8?B?aTg0a2h1bXFDRVVHNXN0UmRoMWZZUWxIc3ZkYWlpMFJ3c0NPNGtKK2Z5NDJR?=
 =?utf-8?B?RWJVNmdMM1d5bGM3MWxjb1FyRmV0OWU4OERNZkw4N2hXVjBkd1Q2TDBuam5i?=
 =?utf-8?B?NkxKSXdTaEt0RjBDNC9jTGc4b2Q1REdSYTJpQzFQVmo4NjN6SVNPb3A4KzFn?=
 =?utf-8?B?dlY0MVRpOHZqcmJOVGh1ZWdlSXM4OVVHMERkT1pBaXRzSmhPVEZDQXNhb3NU?=
 =?utf-8?B?QnZUUWZBNm5HeDFaNzR6bFgyVjdyWFg0a3pyODB1WHpmM2tiYWJpR01SM0NE?=
 =?utf-8?B?YW9BMGNWbEoxeUVzUkRWV25PdWVpdXRUY2I0OTFYaTdCRzd4SXBOMXF1b2VR?=
 =?utf-8?B?ZkJrd2dYUVZQcVZmODZjQWFMSm5DUWxVUEZzY0IrdG8zVzgyOHJ1NlhrYzQ5?=
 =?utf-8?B?aTdua3hCK2VReE5haDV4V0VnZ0t2Qk9PYS9ZenloS3kvUGpSYng2dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec406b5-70a0-4ded-2408-08dee6013eb7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 01:50:15.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldnjTVrUSn88WYgXp4W9JgFGjNLF08FJwLkLA9zT9oXrRHsSg/zwtSlZZFXSXXzD6qIXh/MA3eU32QdzUR8q2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6696

On Sun, Jul 19, 2026 at 03:10:00PM -0400, Aaron Tomlin wrote:
> Provide a helper function trace__field_is_ip() in
> trace__fprintf_tp_fields() to ensure that tracepoint fields representing
> instruction pointers such as "__probe_ip", "caller_ip", and
> "call_site" are always formatted as hexadecimal memory addresses rather
> than signed integers.
> 
> For example, when running a kmem:kfree tracepoint:
> 
>     # perf trace --show-cpu --event kmem:kfree --max-event 1
> 
>     Before this change, "call_site" was represented as a signed integer:
>       0.000 [003] xfce4-terminal/2201 kmem:kfree(call_site: -1714572588, ptr: 0xffff8afee0303000)
> 
>     After this change, "call_site" is correctly represented in hexadecimal:
>       0.000 [003] xfce4-terminal/2201 kmem:kfree(call_site: 0xffffffff99cf1194, ptr: 0xffff8afee0303000)
> 
> This improves the readability of perf trace output by making code
> addresses straightforward to parse and map to kernel symbols.
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-trace.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Hi Peter, Ingo, Arnaldo, Namhyung, Ian,

Please note that this patch was rebased on "perf trace: Correct cpumask
formatting and add --bitmask-list" (Message-ID:
20260719001510.398616-1-atomlin@atomlin.com).


Kind regards,
-- 
Aaron Tomlin
