Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2104.outbound.protection.outlook.com [40.107.243.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC491A9B2D;
	Fri,  8 Nov 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097513; cv=fail; b=IB4bMSuNtdto1W0v6PRbhbC6TULB+9vBaBYaafIoOz324YSvV4GerDEDrhALGUqajGkArVcObybD74vdctKu/P3Z8e3ULRY0bf5omLXHkGcBdlSTLsn5wnPbVPRtp41qtdcXAQvcVafq3qS9tYLWvkVuZaldi/sy0WIAr8fHONo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097513; c=relaxed/simple;
	bh=HSAmk4aFlOTAWmnzb1zjkDpCrk7rohOwdrHFHhVTjtA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=JQTRDtYG2G4LN8sDU279/ELmrPsyc0kwMTdPXhXv2NHg51+Fn1Q8gdK9hhHXa5IfmHfMbXdOXWGUSnWvH+CTziV8SAH/NWu8kwsnhhkINfeVrH6bKwKk9SzxrsTJyOzn/aL+WDX8JarDhFiQkmHai3MxGAUDTdAwXpRU4ap3urw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fI/iTjhm; arc=fail smtp.client-ip=40.107.243.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fI/iTjhm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3+2JQoRNgKYcVlWyHAgQ9eLdMvDakJwTRvVvqg9uJz5ogTCy9R1cHFtLQJtO5Teyrn4+WF73HPdFGCTDaSJAssc16kEsg/hJcUxCbmxyRWWuHsoZPSivvOdIheprll7FwiuZu3g1Ue0gR06QJdGFvusX4UsBEwtuyaW3+c6LCYcUhhnQ1zjIlpHpJ//L37C6a1ZPQJEvi7RqVBIJ4HPVHouzVvc9GkepBtNfCW96YVoRpTv29R5TWv0N2s058nRuxzP5rMRECJCD39cpCvngNme7X0yHZX6X6h53gZ9K1sP0oKtfO38rmVYMvDSTCR+rh2vyEH8VHF25q83ZKrEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYwc+PG6zxCelBJRM3ruwkH64JBbabkKCHJgW0lYRlc=;
 b=bq11ZBCum2qlG0uuk5OFOsL+nEfbIDPlZ4QLGHZE583rCpFpaNswRjCyeJhqpBC2Hq68vDk4oeZNGIW+jSFoBiYlKlQgBAr4S1B4nkKGuwfCQhYtizjvwKkNIRl9wEry7o0Ze840NiMnDkrlCHmuGHM5AYL9KOLk1RJx8JSxiPEhH5UkByzYMjVLQUJDceyZJRs280MHAfEKW8sXrQ2Z3Cqck13amWJHrrTLdy8hJaJdBYbQld6QuwNiIzbgXxF8umfjWX9dRtAaSVAizRCB/jX6O7Mjw1C+40acGYu36eEs++DumZG7iDAHk64ZPBV9Ixm3KMGd1xWzOa3h6Wta6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYwc+PG6zxCelBJRM3ruwkH64JBbabkKCHJgW0lYRlc=;
 b=fI/iTjhmwBtImS9hGDQLeTynOTNfFNmhJzqIGuqEYjbIblCJWx0vpjJ2jaC7QzfzIPuhainkX7V7Zwri6hixxIK5Njr7SfAPElBOKAzq8+TxWVe07Fb/P/16+H/LPF76vxgZrLlbkXp9XK5wpem75k4Di7Dv6HVlkb0pgQ3Prbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 PH7PR01MB8514.prod.exchangelabs.com (2603:10b6:510:2e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Fri, 8 Nov 2024 20:25:06 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 20:25:06 +0000
Date: Fri, 8 Nov 2024 12:24:59 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Leo Yan <leo.yan@arm.com>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
    James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
    Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Graham Woodward <graham.woodward@arm.com>, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf arm-spe: Prepare for adding data source
 packet implementations for other cores
In-Reply-To: <20241108145035.GE47850@e132581.arm.com>
Message-ID: <44de3e9-8c55-3740-fda-3e55c3aae97c@os.amperecomputing.com>
References: <20241108010911.58412-1-ilkka@os.amperecomputing.com> <20241108010911.58412-2-ilkka@os.amperecomputing.com> <20241108145035.GE47850@e132581.arm.com>
Content-Type: multipart/mixed; boundary="1372433909-240294241-1731097506=:2059"
X-ClientProxiedBy: CH2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:610:38::24) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|PH7PR01MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c7dbf5-2466-4ca8-27e9-08dd00336f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVpSc1RrelRxZmV4c3FzazJxNEliRFFoU3M0OHFub0hDK3Nwa0M2SUlvTlhv?=
 =?utf-8?B?bUUwVDllSkhVRVlKaE1VSEZwV3RxWDRtSXZrV3Q1L1BGTXk3MStKcjJ3Mlow?=
 =?utf-8?B?YVdvTllsaXpEWFoyMFM4SkpzajNZUlFmbDgrOUQ4MkYzemRLbGNON2VWQXJW?=
 =?utf-8?B?SnVaV2RMTWU0aUZuNi9GdG1hZGliZFpFdUF3eGFjTVR6NEh6NWtPamNhZ0t2?=
 =?utf-8?B?VWlXenRuNDk2QW8xeU5SaU81ZkVBK3ZEMTlKRnIrbmJaalNyWm5LT3NIOWVJ?=
 =?utf-8?B?a2drNjFqcnhYR0duaG53TWsySURkNzc5WjNoT0l4OVlmTnhvd3RrY3UyVkxw?=
 =?utf-8?B?NU1DaTV1Z1hoT0k0dHVqdENGRGVtQmR0OFE0YXR4cm02ejA1QVdPL2V5d2hH?=
 =?utf-8?B?dml6OVFJMWpSbU9oNmFTK2d6WUlmVVRvdmVMWWRkNDRyV3kvRUhMbzBPN2pz?=
 =?utf-8?B?dFJYaWpaK0E3ZHVpSm45K1BENm5FaE1jTE5tODB3MkJTQSsvRWJtZFVwTHhU?=
 =?utf-8?B?bzJjSFhmUmZuazV4VzVibVNZQlk5NW1GNXhWTVpnSmloUmtCMnUrN0ZhRmdz?=
 =?utf-8?B?VStFaXJmT2E0TEtjMmI3QzJlKzNMQnExTVlNYkh2dEFyQVBEdjl6aktxSDVI?=
 =?utf-8?B?d1l4V21xZk9HZFNGcWE5WlB1L2llWUFkN2tWamtiS2xvM09oSkNmOUtKM3dm?=
 =?utf-8?B?MXlSNjVRbFJidTB0T2ZvSEFVK29PMitGcDJsSXI1U3BoOTJNc3NFanhGc21S?=
 =?utf-8?B?T1hGNHB6bXBpRlc4b1dHTVE2cS9EVWZjMDNxY01XRlQ4bFVydUFwMmI2UkVE?=
 =?utf-8?B?ZHNva09mZklGbXBUVTIxMjZubWNBNjR4SmpFRVkveHltZU9Sc2dvbmlRVlNj?=
 =?utf-8?B?dzZ6dTdYYVlqQ2lMUEZrQ3VKUmNtVW9iZjZPRVlmOTUvYVhlZ3g5UXNKZDds?=
 =?utf-8?B?QnJQdmRteGpGa2pPZEo2ZVRlNzRpNzRaK2dDSFJkVklWUzJrcXYrNk5KemNZ?=
 =?utf-8?B?Tjd4TjJZQU1VMC9wT0trV1FpNlI3b1RjUlN4MmJrdW5MaUdDMEd1OWdIdUlO?=
 =?utf-8?B?SDhhVGM2QkV5RUZsV0pWRVVNN0lyQ0VqMDFZOTZnbkIrOUhPOGVjMzZXSWVY?=
 =?utf-8?B?NjBMbVFhOGlOMTd1VmpNbHBDNWVNQ3k4YmlBKzZLSWs2REpCN29MK213RTBi?=
 =?utf-8?B?NHNJaW1RTmNRNklrTFZ4WkdzckwyelR6RFBzNlR6dEozRm5ZUWg2WFJscTg0?=
 =?utf-8?B?WXlYYVFOVlZXYkliOFh2YlVWQVNoS1dHNXFRbFpKdGFCQjdESDhvZmI1QWg4?=
 =?utf-8?B?MlB0emNETW1BbFduek5xN2lUL1lBNW5hL08rN2xhVFNEN1QzUU5VdGdNTGhE?=
 =?utf-8?B?bGtCbEszTHZMSjE0eldjaCtSUDhxOHAyNGw1dytzYThtRW44ZC8vZVo2Y214?=
 =?utf-8?B?UWNmenk4MGRGdjlZQXE4eHpodG1zM0lyYVo2Mno0b3NKNTBWTWZaWGRiV3Zv?=
 =?utf-8?B?aHU1UC9WTVRRemk3U0VnbkNPWUV4U081WGthSFZGY09sUWhNbUdOYmVtTHdW?=
 =?utf-8?B?SnpuSnk2M2ROeFR3Slh4emV3bXhGRUVQOENVT1pOV2JJU2p5VWh4RzhXMURO?=
 =?utf-8?B?dzZndVh5SzJlRDNTbHNOZmUvSzBOWjloUTNBVlJrbFhKREY5WUovWjcwM2Nl?=
 =?utf-8?B?RG9GSHF6VWY2SnlHTElHdCtWWnZrT2piY29DZGJiSjNOb0dodlQwL3ZSV1V0?=
 =?utf-8?B?bjQwOEFxaEFLeXE3Q0E2WVVvd0Myd2l5YUlrZlMxZ1NQWXFhR3RVSTFjTWM4?=
 =?utf-8?Q?CGUktFLPDanMGAhNf6JmWwEEGSTgZRCQgojBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTNlWXVHNjBWRE9qbUJtTVhpcjdUU1YwMTZzMStCUk80M1V4eGQrTURSMUsr?=
 =?utf-8?B?aTRseDY0K3ZnNHBBQnNSQldpaW5PK0hYeXo0dCsvN0sybTRvdm1EblZ4RWV6?=
 =?utf-8?B?L3NVdzI0WUk5OEN0cUhBRkUxaktMRTJqU3B1TWNEUURzUVNuSGNsd2s0RzR5?=
 =?utf-8?B?VzVxbE8xeTMwWklIM0MvdHBicGRYUGdmZERtSW4xNjdtcUU0MVhSRExmZWR0?=
 =?utf-8?B?ZmdGdkxZT3FlemVoemoyZVUraWpVclc4NmEwZVU5TWFDc3NjYUtWOGlZZ2Q1?=
 =?utf-8?B?bkFUa0V3L2I4YVVFNCtNT1dJNWFiQmdUL09tNmFWaCtuN1ZjLzM4ZzZaRUIz?=
 =?utf-8?B?d2hrQkZBcmNiTkJRN0M5R3VXZWdMcG1BZXplenA2TjZXdVl5ZEtFOXJ4SVkr?=
 =?utf-8?B?TTVxVVByYWpweVpPNXpzRWVub0hCQ215TjZhb0V4QUsySkQ1SXFtSnQwYnFO?=
 =?utf-8?B?ZU9CTUU2Q0hlVDRFQi8zMzlmSTFjdFNiTXY2S283bm1QYWc0Yy9iMk1waTNL?=
 =?utf-8?B?Tm9iWFBPS2dPQlBHNmFWc0ppa3FBd2J0VjVLY2hzN0dRbDlMckRZSzF5RUp6?=
 =?utf-8?B?V1d4dkVoNkZwRXJ3Z0FIM0NOVjlCME1jM1VtTGxuZWtlOGZHeFkrd3Y4ZnI5?=
 =?utf-8?B?Nkl2M0YyZDlUUTJsSUdDemhaaWNPQk5vSTBuZ1pxYm9mQ2FpR09GeGdCMHNE?=
 =?utf-8?B?ZWZvTWxGbVlBUTZleUZzZmlsWE13WTQ3VFUvUEFCNDdHZUtqczBWNmdsZlcw?=
 =?utf-8?B?d0h3MmVFT01vUGFZaEM1VjlHVVdDYlFkc2NkWGNmY0NaQ1BPMEp3YlB3UVRX?=
 =?utf-8?B?dWpjUHNVR0JsUll1SkZ0VnZaNzhxdUU5REh6NTlVWEQyVFZOSGtYOWZKQUJU?=
 =?utf-8?B?VzBXZytlcS9sWXBqdW1IaTZ4WXkxdVZLc2ZoY0U2QUFOOHUyZmEzTFBxdDVX?=
 =?utf-8?B?aUNSc0x0TnFtcEU1VDN6d1ZqRmsvOHUvZGY5ZEcrK1hETm85Qk5wbkQ0elFp?=
 =?utf-8?B?RkVEQUVaWXlGRlMzQ0pjRDh4QjJXQmlwNlRqbGtoUjFUNlNnZjB2THczTkcx?=
 =?utf-8?B?VC92QTVMZDJzTDBvc3JiRmlCQm9uTUFDQ2s1WnFOby8wWTZ4YW9jVStaNXpw?=
 =?utf-8?B?TklDOUtyS1dMOWFsOEtjejIxSWovNVhtQTEwVlRsR2ljZXZRUStGZlNmR0Qy?=
 =?utf-8?B?TzNLVGxsYkVobGI0SU8yTW1uMlQxUTg2bWpHRUMwVmhUVGg4S01kU2VTUXY2?=
 =?utf-8?B?T2p6SGI5YmNyUDMxSWk5UVZxMDNNV2o0aHJiL3hHYkhsV1RhM1lYd3gvSXNw?=
 =?utf-8?B?R3VQQXZDQ0VZendZRUdnNDdIU2NpUThMZTBjSkxnanRDZXcvV0tBbm15cGJH?=
 =?utf-8?B?K0xRTXR3dm1CRFV5QUV4RDE2S3BJa1ZjN0Y1R3NaQUJYOUZXNGJVYzFyRkZU?=
 =?utf-8?B?ckNINFByZ0JQYk5YUHNkcU5JQndDQjJjWU9pZHkxUlYxdG9ETWNtbGJ1eWRi?=
 =?utf-8?B?WFRHVDhjeU90NlJ3VjNZQzYvY3NpeStWV054RzArTjhRbDh6V0xqWmk3dTlJ?=
 =?utf-8?B?UFozdENsQjZvODl5NndqLzErZTlEczRWSDhMcmViWW5veDlwSGhreFNjNkRa?=
 =?utf-8?B?U2UwNmhKejNyaVJMMjY5ZzRuRWVYQlNBYkc3dUVBSW00QVVkOG9kemx0d09X?=
 =?utf-8?B?SERVTE43ak1yUkgrSGR5YkZoUklIaE1qR211Qm5KNE12emxyL3lFdDNwSTMy?=
 =?utf-8?B?cTBsbGUybW5hTzdTY28wQUJTY01ONU85ZjFBbHZQN1orK1M1a1Zoa0kycERI?=
 =?utf-8?B?SnhCd0NXWFZ2Wi9IaGJGL2xpdmEreGgwNUd2S0dBR2ZLTHRBTTY3emNldkNH?=
 =?utf-8?B?a1NHY29PYzJpTkxhYXZMdWVzZlFxRVZBZHRWc2JqQjFkT3ZHbzZnbFhnVWJK?=
 =?utf-8?B?aHZ6U2VvcGFpU2NOd0d6WlRUT3p0UVF3ZjllbzBVcWs2enI3SWE4K0o2NFZH?=
 =?utf-8?B?bjU1TmVDUlBJT3BuL01iNTRKcGVTNHpKVitlOTZGSDFDMFFRSEFuMHh3aUtH?=
 =?utf-8?B?WUxJQmppT3hKL3drcW9XQnlEajZPRDRsZ2dvbi9nU01GSVdXa3JqOWVOR3ZP?=
 =?utf-8?B?OTZHMHc2dnRZOW1ka25JWDkzQi94eHRGaURMU0tSNkREbE1jZWRXRy84Yk1y?=
 =?utf-8?Q?IHGFMwuPw5nPipWt7nP+UIY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c7dbf5-2466-4ca8-27e9-08dd00336f00
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 20:25:06.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn6I+HPFOBdX0l9kj4uUEBHJ1WWCAyfm3zyKCNn0sqCOBBsBSLOrFzWavlXv/4HCqaoLWOL8orGLTibPkAXM4PW8SSD4KyojkLqZlxZd6wkJyeVb8NMYmDm4tz/cafSh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8514

--1372433909-240294241-1731097506=:2059
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 8 Nov 2024, Leo Yan wrote:

> Hi Ilkka,
>
> On Fri, Nov 08, 2024 at 01:09:10AM +0000, Ilkka Koskinen wrote:
>>
>> Split Data Source Packet handling to prepare adding support for
>> other implementations.
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  tools/perf/util/arm-spe.c | 42 ++++++++++++++++++++++++++++-----------
>>  1 file changed, 30 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index dbf13f47879c..dfb0c07cb7fe 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -103,6 +103,18 @@ struct arm_spe_queue {
>>         u32                             flags;
>>  };
>>
>> +struct data_source_handle {
>> +       const struct midr_range *midr_ranges;
>> +       void (*ds_synth)(const struct arm_spe_record *record,
>> +                        union perf_mem_data_src *data_src);
>> +};
>> +
>> +#define DS(range, func)                                        \
>> +       {                                               \
>> +               .midr_ranges = range,                   \
>> +               .ds_synth = arm_spe__synth_##func,      \
>> +       }
>> +
>>  static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>                          unsigned char *buf, size_t len)
>>  {
>> @@ -443,6 +455,10 @@ static const struct midr_range common_ds_encoding_cpus[] = {
>>         {},
>>  };
>>
>> +static const struct data_source_handle data_source_handles[] = {
>> +       DS(common_ds_encoding_cpus, data_source_common),
>> +};
>> +
>
> Move this structure under arm_spe__synth_data_source_common(),
> otherwise, the building will fail:

Uh, didn't I build it after I moved the arrays. I fix it right away

--Ilkka


>
>  CC      util/arm-spe.o
> util/arm-spe.c:115:15: error: ‘arm_spe__synth_data_source_common’ undeclared here (not in a function)
>  115 |   .ds_synth = arm_spe__synth_##func, \
>      |               ^~~~~~~~~~~~~~~
> util/arm-spe.c:464:2: note: in expansion of macro ‘DS’
>  464 |  DS(common_ds_encoding_cpus, data_source_common),
>      |  ^~
>
> The rest looks good to me.
>
> Thanks,
> Leo
>
>>  static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>>  {
>>         const struct arm_spe_record *record = &speq->decoder->record;
>> @@ -555,12 +571,14 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>>                 data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>>  }
>>
>> -static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
>> +static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>> +                             const struct arm_spe_record *record,
>> +                             union perf_mem_data_src *data_src)
>>  {
>>         struct arm_spe *spe = speq->spe;
>> -       bool is_in_cpu_list;
>>         u64 *metadata = NULL;
>> -       u64 midr = 0;
>> +       u64 midr;
>> +       unsigned int i;
>>
>>         /* Metadata version 1 assumes all CPUs are the same (old behavior) */
>>         if (spe->metadata_ver == 1) {
>> @@ -592,18 +610,20 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
>>                 midr = metadata[ARM_SPE_CPU_MIDR];
>>         }
>>
>> -       is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
>> -       if (is_in_cpu_list)
>> -               return true;
>> -       else
>> -               return false;
>> +       for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
>> +               if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
>> +                       data_source_handles[i].ds_synth(record, data_src);
>> +                       return true;
>> +               }
>> +       }
>> +
>> +       return false;
>>  }
>>
>>  static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>>                                       const struct arm_spe_record *record)
>>  {
>>         union perf_mem_data_src data_src = { .mem_op = PERF_MEM_OP_NA };
>> -       bool is_common = arm_spe__is_common_ds_encoding(speq);
>>
>>         if (record->op & ARM_SPE_OP_LD)
>>                 data_src.mem_op = PERF_MEM_OP_LOAD;
>> @@ -612,9 +632,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>>         else
>>                 return 0;
>>
>> -       if (is_common)
>> -               arm_spe__synth_data_source_common(record, &data_src);
>> -       else
>> +       if (!arm_spe__synth_ds(speq, record, &data_src))
>>                 arm_spe__synth_memory_level(record, &data_src);
>>
>>         if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
>> --
>> 2.47.0
>>
>>
>
--1372433909-240294241-1731097506=:2059--
