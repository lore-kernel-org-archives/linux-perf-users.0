Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD81494BC;
	Thu,  9 May 2024 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715234554; cv=fail; b=BPdQsmQ9MOkKTBRKMkVx/wtz+J9SL+C5NQpLBc1cnncmOt4cI1ph3rFxVO536lL069YvvkIzfVCAGStHRlygSUb20H7ZMh5bZZd1/KeWpW61XSVN04Q9CGI2Z4YnjDQIaMZbt0SqFc7ma6DL2yEcLQkj/KRMC+Tcx/Y85bVBKuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715234554; c=relaxed/simple;
	bh=zKGs2QytQ2MhyJQPaL2WjFhMyikRqCL4PCFUOK/PhzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ww2MjcTHS2Ddj25Nqq3LHYTVBN1h7BM/BLk6VG8fnxQonEfFsMkJaqJZ1a2Jd4DrDE4eYvQBislaghOrv+bDJB7rtzgbYvidXrTixQLkmAHI7JeLLjpbcoBF4hLSMYVvon0XIbTdZxmwLnyW+vy+yqaLl9SJRgSenJ8kAUPpdRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FmhYAOWB; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FmhYAOWB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG5DvaA0KMRPjTQalKi4zo3a6WyP8/uuQ7cyVcpLDKacIzb+9ITjCZOcBeXiuT0jtuOTEi2uDW9wyksEXP3h/QIbihqQS6hqqLzfao4VY9+wIi7xQNoC2536GT3YrBimOUYHN/zyZOEPOIjkkVs2OcWRpPHGjlllUI7Lil2GYCT5R9BZpbwp+dad1MiDy8c3IZ38Sug7Qz1c2Y7ZlldY92xfaGi6UEEzamRpMfu4CZy5tjUXVjh/9J3G1OAXnf14n5qAg6eW3uQcjJ5Q1sndCFtckst1EhHXZ4noPXbV19u3gU+1P9cA8PFkKwD6tbtfyLibo+y8h8a6l0q4aYM56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YBkDUoY189tCNmSDgSdqHBsMo8FzI72n1UdzOw5VIE=;
 b=KfnLwwyWt0bOpboifi9EaKmzvs5iUFHNk7KQJbSlE4xkNE/ifjYQxgOQINbTtOvclgerLEF0CMUSoN2mkj6Foa4aBtKRFQu05iWOznNO7LdfZRQPJom+UKJoqx9zdKIdr+ftoR8Uf9bjAqTra43RERbALo8UqMFxZZ3B2psgaPXBS+EEe/fn7mnRzUoUzRvHApndkiaEqYHlhaMOnzKeUePHGkzPm7vILdq5NporseEgYNQtA8BKmg8mX1W90pt2HA2OzmkTyFPEfs5lrDAmHocC2FJYrbcfB9Uo635j8TmwK5OMonvCM5Gkg5/GhnBiFTYDU9y63JOxPfQ3MUCuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YBkDUoY189tCNmSDgSdqHBsMo8FzI72n1UdzOw5VIE=;
 b=FmhYAOWBI2V1vG1j0D+iNsZ5ZzM/v8/S1klfVhDMo3ieRFlDkVKjVOhv5I2F9uK1HB2a8lm6mdt4rDbylg+sNI2jLmXYp2nppBHL4n/BkdUp8ls/zyFzaKes1Ug+R9fBSODuAQaFzltqq4kszLwKWepqBjfJg6orhEGS3iSPHKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 06:02:28 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 06:02:28 +0000
Message-ID: <0689aa59-426e-2f37-dcc4-d79b1e89403c@amd.com>
Date: Thu, 9 May 2024 11:32:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 0/4] perf sched: Introduce schedstat tool
Content-Language: en-US
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 irogers@google.com, swapnil.sapkal@amd.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org,
 vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com,
 james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com,
 kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
 <CAM9d7cgFKcHXeTXxax7GRCK__0U3HUnG3Ls09GpnD8FipyJk1A@mail.gmail.com>
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cgFKcHXeTXxax7GRCK__0U3HUnG3Ls09GpnD8FipyJk1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: b34ce1f4-2b28-4608-a3c2-08dc6fed9b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkRZaHVIeVRGTjVxUVgvUklnbDlHVXZXa1QybWJoMVV4MlhEcjJyZjk3dHYr?=
 =?utf-8?B?VCs3S1kwenRuSW94OTNHYk5iWlJRVm9RUHNYc04vYk5jYjFGR0sxRkliRmlU?=
 =?utf-8?B?Mmw0MnQ5Z1R4VUZ1SDJjMjBhckF1Unk1VDcyLzB6UjQ1RER5MWpIZW9vQzBK?=
 =?utf-8?B?ZnJkWDR3QWt3TnEwMmxzQW1hQ2tuNHJ5UGZLdGRub3lrcEJ5WTAzbTF0VjJS?=
 =?utf-8?B?bkQ4b2dydmdPL1l1RnpmRDdLaFpZRTVQL3k1NnQyQUNrOWMzMjdnZkNMRW44?=
 =?utf-8?B?a3FsTVNRUG4vU1YrTitLZUJZTUFKTFBHMytlNzk5RUh6WTQyUmZNNmRDNFNF?=
 =?utf-8?B?T3NCK2cwRzk1QWlHR2dwdS9zMjFRSlNrQm1WdXc0ZzlSVXF5QkJEUGFMSmNE?=
 =?utf-8?B?UlVtSlR2dHQvbHNBaWFtSTEzbERtL0ZzSElQSVlUZm5CYTUxUzBaNUgzb2Y4?=
 =?utf-8?B?dm95WmRyRDFIUmMxem1aRWczUUY1UzFEMDZQUnQ2ZHFkak5PN2d0bldFeUl0?=
 =?utf-8?B?cDVzRkJVNGlLaHZ4UVpITERmQndxL3FqVXRxU1lzdk5JSHZHMUZoYmtDa1JI?=
 =?utf-8?B?UGRtaDFKY0MwYmwza2ZNN1Z6UVlNT0xqblFwNEJzNnMrVXZFNUtrQ3hMeHJB?=
 =?utf-8?B?YUk2aWlWd0EvT0pBUExUcVVLZjdyOGt6N2hoZCtGcUJ6eXhuQkd6ODdqU0FU?=
 =?utf-8?B?N0toY3NKVUZIc1JnZTYrTTdJUldXR3ZKM1VEbHdxZk52UXZNSlVERk53a2xH?=
 =?utf-8?B?Tld2NDVBTFpPbXJvZUhUTzJPc2VzaHhST1RCU0FWUWtqR1UrVG1ZWVJZMHp3?=
 =?utf-8?B?Mm9FL3lKR0xFSVVPR3NoZjJ1UzRKQ2tmbTJsQjJYWjZ0Uy9OdXRrT3RzQ0Jt?=
 =?utf-8?B?dFFzWXBPMit4TysrejRxTklkVzloQmJDb2RKbzBGVW1MdzYwd1Z2alZqbXJ1?=
 =?utf-8?B?RjJWc05RdmUvVWNMSGpTQmV4TzhySk9WWExGakJpdjRFVEg3Y2Q3OFRhekhH?=
 =?utf-8?B?NElLTDBzRlpxdGdXdktxbitoTGMyOEpDRW9rNTQzOExXNFcxK25ERXZxTU53?=
 =?utf-8?B?S2dGTG5qQ2RyQTVSaktldFprSVZDNjhpbGtKaWhMTndOYmxjaEFWMnBKYjkw?=
 =?utf-8?B?TXcvTnBXNGRLbEZ1K1JHckNCcDl1SzZ1Zm9NZmdGWmo3aW9JQlR3eWttWEhV?=
 =?utf-8?B?bkdTNDBIRHVZdENPSHRmaUcremNEd1Z2WTdqVjQ4NEFnYi9YTVRmZkhMYmdP?=
 =?utf-8?B?ODJmSDFEeFQ5anl6RjBGcGw0anE0ZzlZUzlDamJpeFJNeEcyTzgreWZOWkRF?=
 =?utf-8?B?R0ZoZkxnd1ZIVW9YNzMybUgzcGVaVnU0ZDZiWlAzTXE0L3NJa29uYWZ1Y2Zp?=
 =?utf-8?B?bTg5dWxuekliVHcxYWRlU2hoVUVpR2lySmJhcUR4Y0hhZkRlcEIxa1JkSDBY?=
 =?utf-8?B?U1EraDZNRDZVSjJHT2N1d3NPNmJidVBYMTFobkhsb0N2dzdFWnE2dHdRRDFS?=
 =?utf-8?B?QkYwZ1psb2JreTFHWjJsYmFWejdOTzFDUzYwWVIzUHNvUm9GOVZjVElvOUl5?=
 =?utf-8?B?TUl6MzlZbmxHU2h0ZmlsRExsWjdjajVOdTRYVEYvVVBGKzZYOVdtTk5BcDQw?=
 =?utf-8?B?RTNMOUErZjF3TDM0Vm81UkMwbGx6YnpMbFpEWS9UVzhZa0NIOGxzcHMzTEd4?=
 =?utf-8?B?RUZrZXZYcG5NRUpyc0FJL0ZjYlVPM1RCME92ODNBMkNzK254Q04xRWRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzduOHNaVnM5SCtjWTg1SEFNUkgrZDlTdmx3NzA5Yk1WZ3o3b0FNMENqUWda?=
 =?utf-8?B?ekNsVCsyOHRFcml5MjByejR1VFUvYmVQQ2M2Q0tWWDliVWhPR0sxL1M3djdu?=
 =?utf-8?B?MlNZWGNpY0RNdzhDS2RzdTJmQmVlWnpxdEN0cmk3b2ZhaVNhNHBia28yeWJz?=
 =?utf-8?B?UUl6SWlxQ1IwT0dDUjdSOUNQa2xobDZMOWJxWTlyQndTalhXNjZSaU1odEFO?=
 =?utf-8?B?L2tVcDhwMlJiLzRuNEtwRDZGa29jdGZldlRjMFc5d1Y0SWdQTW5NTVZBSTdm?=
 =?utf-8?B?aEpoYjVVeEZic3pPMzF4WFNXL0wwcnJZYS9mRmJ2UWFRK3NEV3RCSWIzaWhu?=
 =?utf-8?B?N0RrczkvOWhreTFUVzFRaUdCQWYvUkVLcUJWMUJqanVDcFlIRm9NdjdvVWtZ?=
 =?utf-8?B?cnd4dlJxN1hPSmthMDBlZWoyM09xeVREZEJYUkZxdi9LSjhiOFkwUVhOa1Qx?=
 =?utf-8?B?YlFkOWJsY2RLcGZrZlVQMy81QjdYTm9tRGp1Z0pldkRaY1lsZ0dERTFsYWJJ?=
 =?utf-8?B?MDB1QVVYYkVIUm9KcHZ5SW1mVlI5b2NFR2Y4RDM2RkxLMTlaRlNtaXVWVGxw?=
 =?utf-8?B?ZDBodis0MytmZXY1TzFleC9nZ1hUbXkyc2JjOVE1Y0tFbVQ0cGpWemZzWTlJ?=
 =?utf-8?B?RS9IeitzMTdha1ExY29yNzF1TWUvWkJEVGZoRWJDbkNua3JnTWVnN01ROWhX?=
 =?utf-8?B?MU1LaFY1UkZPTGdCY0xOVUdWQW55Q0kvNEpYdDFrRWJLMXBSMlhPV3pMQldW?=
 =?utf-8?B?b1NJYjk4UWFYT1hJZVlRL3dPOTBqU2FBOXlzRFFsQm9YMVVwWGZzcnU5MTZ2?=
 =?utf-8?B?YVRMZGl1YStUVi9UQzZpUkNqMkFFNjJ5dSsxa1oxNkxwMmpzL2ZUbXpUZlpT?=
 =?utf-8?B?UENaYUJsSWJncEw0Y0ZkTHRYVTJlSERsclFUUE1UdTlPbUU3NVc5cXhsSWx3?=
 =?utf-8?B?Qkx0aHJkT1VBVHlRK25xb2lUaExycHZHWTZPV2lheXVBZkRnRTVsVHZDaE1N?=
 =?utf-8?B?SGloaU1QcVhKSGFzcXRjT0wrcFdtYUVIVzlaOVU3U25HTEh0amRGb2l2K2pt?=
 =?utf-8?B?VVdFcXhBYnNib2YxTmwrZGpnSlZEOENkd1VmM2E4T2JvVHgxZ2RXVlpETUoy?=
 =?utf-8?B?MmY5RHVheTI1WjkxLzlJMjRoTGlPTnFQSVA0Skp6M3JETm9jVHREWkxvNDl1?=
 =?utf-8?B?SGtCWFVzdnBBdmRwblF2UFptczBad042Q2ZKZGl3cWdNaUdmTmJWRHRrbFVa?=
 =?utf-8?B?c0phSkVEci9ENm1vZE15Q2lRaW9HTitWVktXQmttZmxBRWlia2k0L056UXRa?=
 =?utf-8?B?eUZYN0VGRmwvbFRPMnpsQ0ExVEY5T29FV0dpdldKYjIvalR1VDVUVEY5bk96?=
 =?utf-8?B?aUorL29qQWhDWGRaQkJFN0pGSW8wTUNwT1U5SlRSeUVVdE45ZStVMkgvM3Q0?=
 =?utf-8?B?RVYzemJXQVNqRXN3TjkwdXFYSlVpdU5LcVNCVzdSZE9JSTIydE52c01MVU95?=
 =?utf-8?B?K1E3OElLcmh0SExKL2NwVmlrYm9YNG00Q0Fjc21YbWUxWVJKb2t5N3pvTWo5?=
 =?utf-8?B?enBia1ltaDlvRTY4WmFES1lCYmtnS3VSeFdKYlRCVEtLNDZGZFdwYkRBbHZC?=
 =?utf-8?B?alIreWdqRjRCR3FIaUE0UVdSWjFkWkVJWFZRdytVNHVYUlcwNjUyZEhqWnVm?=
 =?utf-8?B?YjVENDd3K0Y2SFhKYVdTaFdUclA2Rlk4OXVINGJydTVKZ1pOUGZnRklpQ3lQ?=
 =?utf-8?B?SzA5NHdGU2dCZW13U0swYTE1WE5sOGdPUnVsWmZjSWRSaGRKUDI0RC9CVUdX?=
 =?utf-8?B?aTB2U0dncUhBR0daakI3VUVhaDFIL296TVE2VzhDcDVlemxsWUFoa3cveW9i?=
 =?utf-8?B?RlRONDkvN0FVYUlpMmtINFRXRlh5MmEramxYOFZXMlRKdDY2S0hSNjd2U3gr?=
 =?utf-8?B?bHBXMzRZWlhnYmNJQzRJSUV4Vm41cE5UYlBmNTZaZFg4MkFrVlRFWFM5RTRB?=
 =?utf-8?B?S0hnVjlrM1U4MDFMSmNGRkIzejhnU2o0M1YzY1JUK0lzU1ptMy83T0MyaEFY?=
 =?utf-8?B?VXVvYmRWK2FjeTZuYjJJb3VtZVBMaW5LOEZ0L3lRYjRqZVptTzFCWmFYQ3Zx?=
 =?utf-8?Q?mkQQo7vLptMYddSoSFGAMmMl0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34ce1f4-2b28-4608-a3c2-08dc6fed9b09
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 06:02:28.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cTQfN/RRPVHLNJuhlSFrW4aSPA8FwT4nj6YJe/yodobQrUBOaUpU9kDicj1ydGUUhDJXSGJZjaWQI5X0kcQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082

>> USAGE
>> -----
>>
>>   # perf sched schedstat record
>>   # perf sched schedstat report
> 
> Hmm. I think we can remove the duplication in 'sched'. :)

You mean `perf sched stat record/report` ?

> Given you are thinking of taskstat, how about making it
> 'cpustat' instead?

Sure. How about:

  # perf sched stat --cpu --task record
  # perf sched stat report

> Also I think it'd be easier if you also provide 'live' mode so that
> users can skip record + report steps and run the workload
> directly like uftrace does. :)
> 
> Something like this
> 
>   # perf sched cpustat  myworkload
>   (result here ...)

Sure.

Thanks for the feedback,
Ravi
