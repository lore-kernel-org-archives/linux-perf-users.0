Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1131139579;
	Thu, 16 Jan 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737001694; cv=fail; b=hM82/EG44+QDPseVF7cSVl1NjtiIAp5+4mcB7s/dkVRyOE8zmnu+JcK4DxuCK6tKBkaGLRybKottsE5AA/4vv+GmPy5o+GJ76eEAx+4xPNC/si52/M4ZKQQgVjlhKaxT58A1Q6rdhRPaT2vSa8v9AnpquXf7tmdd79+kQFXWfJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737001694; c=relaxed/simple;
	bh=YD/tn+QnD2tJZQ8P9+RrJfGkF+wG8gfJ2bVdewdxfJ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MxB+9sRYGp1rZhP23zplGhjLvLRE6jvCcGcAf8zAfq6goyNOcluoQrDWG6x4S60gNocE1a+V9WuqcwfrERYsjJYsw2/qEhrURG/9H2aw2fwNPfCfZzXZsTDNIZig5bIsSgOOSogHsMIVimIwmprn9/vnp51UMi/W3ZrMddb4oGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q/ObCeIj; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q/ObCeIj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEzQ4VMgoF6esgIhYgepHxy64QDOuPNttVnNNsFmBlbEckYDd4V2ofpG9PZklce+KIV/0aMp2DEhVSjkrRQrWqEGya7736pJnPB4b1jXTdFwzpG6el9NwIvQPAmOezaVGrr4Wv1P9zzRcxuDRybQY77eX449up8zPoDOUnWwuJE7VqH6lPi3y6KADJuO+u//JnD2cd5DvOD0rn8eMlinzJiG/XPkOsUzAWb1rgqoju/OcRQG/PJcXPz+53UHIOMYZ/b1V/4GOYeB4scBODactsaEX/0qeLA9ywUHOMl417H4Fv62SHZWlIjAdZ9J7SMjSjdEesNmBpgSHeL7k2YHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qCqk7OxURj0gs/s7hpyZ0lK6nr08weuy1S3/8CBaU0=;
 b=xX25iAAwkJWNIjEnNinOO/xOe7O+3NNCqBwGAdenQDGJmSHHFvJJQ3vCHca9jAOVgqJyfY73gDH/Ot6ONMJ6dh3UCh4TFqj+gYf1xP7LEmqDhYBefRx9Ty1gMPZSjGV/qnDthKtLy/AGi99ZItaDbR9OBi3cZAQEg80UheKjh6I4WdtZhCdk1Tes3SLpAMD0iFn3SzZqmTXptY2NpRy3lmSxQMXPfFfKV6xDyOrJnUFbBC5aRQuSpvqgTXVC4qJsGIkdnlLY7yo2sFusuwl4MoQzGUA7kMlpAnszn1HCP8lRnDj51b3XAnKCDK3hu3VWF7ouSr7cXUO76AsGl+12pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qCqk7OxURj0gs/s7hpyZ0lK6nr08weuy1S3/8CBaU0=;
 b=Q/ObCeIjkvQO95zyosYDgS1SPG9PTelJp48rqxMQhmq+o/VWYYj1uyIF51T4nZtTFJBekEDU2on9l2ZDAmiTapSb3QHDDx50dVSWsxUsOPSrecZ58KxfvBIBwU9qcVfTU6pFa3F1TIeR2FluvBFAuEkX8USKhzavpm3MUxE8nBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 04:28:10 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 04:28:09 +0000
Message-ID: <670ad730-002d-49f6-b85d-fda0343d2dd5@amd.com>
Date: Thu, 16 Jan 2025 09:58:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [UNTESTED][PATCH] perf/x86: Fix limit_period() for 'freq mode
 events'
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, eranian@google.com, irogers@google.com, bp@alien8.de,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250115154949.3147-1-ravi.bangoria@amd.com>
 <62c13793-f4b4-4e2e-b6bc-0de2427ea93e@linux.intel.com>
 <5f2c62d4-1bfa-458d-847e-095979a4bf54@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <5f2c62d4-1bfa-458d-847e-095979a4bf54@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: c7edf905-1a97-41db-1665-08dd35e62e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blJreVF0UG5YL3kyeHJQVTJydnZUNFFlT0VMUVZ2dmx1Mk9vZmZVeE5hV0hp?=
 =?utf-8?B?RHZ0WmZtb2twREhpUUhldXhxWnlVaU9Hc3ViWGhRdFZWTjBYaVE4aHJSa2FB?=
 =?utf-8?B?ZHB5V2ZCZlBJdStxaTRxTnpCTWpSZXRrVGtEOGREbml3Y0VLRGFNbERnMFJs?=
 =?utf-8?B?OGxWR01ZR1RTSG5YeUVnd05rV2VnMncwUmNZbDA5ZTVHd0EvNi9mOS9tYjF3?=
 =?utf-8?B?VG90Z1phcDVSQnVxS2FhY1EzZGpKRzN6Wk1qV2p2MFVoQ0NVcXduUWJnd3RC?=
 =?utf-8?B?Y0tTRUVmdjhLaGJFbHJVRTBrQ2wxNVEyK3RJczNjN3VXeGROUFgwU2E3ekh2?=
 =?utf-8?B?NzZhNHMxQjR0NU9EWERvcmlFSzVUVWY3Ri9JcjNWZVJSTitTMWw3ajc5K0k3?=
 =?utf-8?B?L2dMNGtCSjhuVHRVVU53azRTRnRZZ3BoeENUMHlYN0lJWk96V0g4ZE9RcE9L?=
 =?utf-8?B?UzZ4aitBQzFaYnE2aXBTTVBWS2Z4Vnc2WU1XU2EranVoS3BQYkNUM1JEYW1O?=
 =?utf-8?B?d2NTWWNOOVI0NEdRNHl5WGN5OURpb3RJRk9iOVNzS3FwYWdIdWZXT3ZnZnNz?=
 =?utf-8?B?aHlubTF3K3ZROWc4dWFXazJZa3NyaHlzSm1keWhNNThEOG0wOWhGRlA2d1JQ?=
 =?utf-8?B?S3BvWHc1Z0VZRVYyNGpuOHJiLzh5VFBCUThSbnlLOXMwOU1rYzh3SUdLUmwy?=
 =?utf-8?B?OHRFUjZOWUlsSFBtcFZaeGx1Q1lIRHFVSDkrQTdhd2tvYnBESWlIdDRtaWxl?=
 =?utf-8?B?WDhrNUFCNWRPUmZidVVaam51a1RPWGxwcXhRQklMenpMVzVWNWExZjFXd09J?=
 =?utf-8?B?MUF3WXA3WFpaK0tiQ1FnalZCTEpBbXRIZWpCTzlORjRETU05RUNNODNxVlRq?=
 =?utf-8?B?N1dUR1FtR1U2N1FwaW1UZmhxYjR4Smp5dTJxa2NZZjI3RzZqOG93M3JCNzRQ?=
 =?utf-8?B?UkZCeTZ4clFFYTl1LzJ0ZDNMc3hUR2trdHRVbWtTc3FpM21LcUZLUnd1akpX?=
 =?utf-8?B?ay9EVTdOKy9EMVp1dHdxSkJNZU1Gc1lzWDcra2NteXdBS25jZWhkcGdXRU55?=
 =?utf-8?B?SjFJbG9jOG9uaG0wbEhYWmE2bFZGMUtBRVUvb3EvR0hjNzN6ODVHT1VjU2t6?=
 =?utf-8?B?bDd1eUhiSGFFU0dzNUlrRUdlVEdyUEhWdk95bDF5ZUhRUmZlT0tIUUZJaU42?=
 =?utf-8?B?V1NrYmloMkxFb283T3NxWUEzckV4OEVUbm9jU0RMU0xJaDk4bWZPWGxqZEtK?=
 =?utf-8?B?YWNXd1M3TFFxUEZ1a2VXV1JlcUxqMDFXdDkwRTROZ0ZyMWlpLytJYWlMSEdl?=
 =?utf-8?B?eFhHR1NxSFlMMys5MjV1OC8reWZSM0ExNmtUZllubGk4YTFVZVdmWVduM25a?=
 =?utf-8?B?V2FDUXowY0l6Z3E2bG5henZnaXp4dFdFQUErNEZIQVFlQS85ZzNlYzZQQ0dZ?=
 =?utf-8?B?dEhSdHZ5NFZJWjdDVEZDVTlKZGNCQ29QblJXaVcrZWRjc2hVd3RpVDJ1b3Mv?=
 =?utf-8?B?bERvU05WOFZoMng0UXoyVWY4Wi9Ub0ZqOG5PTjA4K1dqeHdHMmxpaWJjU2hN?=
 =?utf-8?B?dHNIT1RqRElRL2xTaTl4YUVadjFadE83SVl1RWlqOXJ3V3lBSWZ6VkRwUDFr?=
 =?utf-8?B?L0JHTGxybThIOFRwdGhKMTYyMFB3RTl1Z1dBTkZ4VDRqR3o3RU83OTdKOUZ1?=
 =?utf-8?B?cXlpbklucHNONTMvNkN1UHM2UHlsWWlpTm53eWJBbThPUG1DMW5oYTE1UDgv?=
 =?utf-8?B?ZnNWZG5RWXBnZmFjWnhBamFZSVZ3Z1c0NEJ2NFhER3RsVS80ck9WK254c3JV?=
 =?utf-8?B?UWUwbDlQREh2SGQzTWF4eWVyUklwKzdGUU9SQzJzSjU3bjZNNUZXaUFaak9I?=
 =?utf-8?Q?66yxhkClq56SM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aElacmVQc1RFWE9rOG05bmtqUFAremRMZVVQUlFjL0lFRUZraEMzOXFsZ1Fs?=
 =?utf-8?B?NXhDelQ2MDF6cjRsUVBNSzJIV3JMMFppQlE0cldXL2k1bjllK3lvNExMRHcz?=
 =?utf-8?B?MVBRVXE5cFR5a3FhZXk0akNQY1FlcEw4YXRZUUtpajJ5ZlNlb1BDMFQreFNH?=
 =?utf-8?B?YWsxTUROeG1iaEg3MHR6SS9aUTVHZCtUVnZramV5R2xaTjFOWWwwaVZYOG1H?=
 =?utf-8?B?cHpFZmh2SkcvWjFmMkpmL3YyOEcxaUwwb29qQ2Rja2xKVlJYNUdGTXB4SHhp?=
 =?utf-8?B?UE9VODIzU1gwOTZYMUZxTWIxdFVScFY0c0UrTUI2YnE3dWRmdFF3UGlrejVE?=
 =?utf-8?B?Z3pDV1QxMnhEb0tDYml3M0Fyd3NqeUU3clVubUpkRHoxYWxNU2NsNDR5RUkw?=
 =?utf-8?B?SUtvcmtmdUVnUlB0UmhLbHJCNkpYbng1ME9yV1ZOZkd3VlFwWkprTmdaRlJW?=
 =?utf-8?B?N3BZTjdDeURpL1lTWEZCWCt1S2RFeUxQbWlxWmZ4eGVxR3FVK093WmFmZ2dt?=
 =?utf-8?B?b1Y5eHJnK1czYkZjRko2VDFxbncwZ00xLzB5ckY0a3l1VlRPb3pLUWJXcWtt?=
 =?utf-8?B?NlVzMGgwS3cycWl3QlhsemJiRit5S0QrUmZ2aUw2b3RqVzBPSVY1dnVLRnlG?=
 =?utf-8?B?bXZGU1lpaHN6L1ZjSCtZNkFpZWlkanR1NURKVVVFcjgycE1QRDNIUnBVdmdk?=
 =?utf-8?B?V205RlNxOE5hVzJuaW44M1F0TFBVTlhrcFdrUTg2cE8vR3o4cktFVDdmSWxY?=
 =?utf-8?B?Nk5WQWpTVDhGNDhqMmRKTlk2dkwxYXgxWERmeUxnQUd4Wml2a3JId1NpbHVO?=
 =?utf-8?B?eFZkYkRzZzdScmZLa0tjSncvUVlEZmlNazloR2N3c1hzd3lhcFpHZGY3cklt?=
 =?utf-8?B?S05zSEQrdmRyWDBzdS9qRGJ5QjB0NGhvYkEzajBXYVBjMzJISm1oWWRDMkI1?=
 =?utf-8?B?NXpubVdvTEdNNm9yUVZFb3Y0emtCeVJNK2RHR0FjeFFPM0lhZi9tZS9QMzc4?=
 =?utf-8?B?ZmNwc2VRUXNid0pJa1kzdVh1N1JLNnBkYTJnd241cnhOcFJaMGVUOXpPTjdP?=
 =?utf-8?B?aWVFZndiaVFGQnlrWjRwL25IMVYwWnNCYTZZTktDUTJjVDhXemRYMHpSZVZa?=
 =?utf-8?B?SzB4TE1lNnM4YzdyTHhER0hraGVndnVnOGJkczgrNzQzVE5XOWN5TlhhRE5m?=
 =?utf-8?B?TkZuRzAvMDFvOG5KREYwZ29UeTFma3Q5NUpwU2I0eFc1ZmdQcGc0Wk4zKytP?=
 =?utf-8?B?dXF0ZVhkMzQzNEFNeHk4YndMbUlrMXR3eFdFZitMeTB5d3JkUVZ6RDNiMlhn?=
 =?utf-8?B?R1E3MHZjblBQTnhaeHJ6aDBqRmtob2dqRkxiUmlhVUJ6VmlkdmIxVDE4Nmd6?=
 =?utf-8?B?VlJPaHRiZDdVUmlqZzBvdjJZMlFXZlQvRnJMUGRjZCtqV0Foc0Y5NkJJVzhE?=
 =?utf-8?B?T2QyZXcwWWNtRDNZR0VqWDM1ZWRkSVk5bnplS2NsVHFkZmU5enJIbnZDYTc2?=
 =?utf-8?B?ZTNyNTQzdjJ1cEV2T3hZU2pXTGF0Q2lVUU1vOHBDMkU0b1RzamprcWxFM2pu?=
 =?utf-8?B?a0tDamFwSlNOaGgzYlB1akVZRTc4NVlLaDB6Y1ZRNTlMY3ZRM3h0bjk2d0sr?=
 =?utf-8?B?OHhnSmt0Z3E2SGNWbFdMV0tFd2prT3VYTVpOSldvSDFIUHJyeWY3WTBrUHZC?=
 =?utf-8?B?a1dmQzRRMDMwV29lMTM3VmtWb0lwR3RxWXNuUmkzcHNTU3ZjRnlpNVBBQ1Mw?=
 =?utf-8?B?UVNnczZtVjBSN2pkdjFkY2cxM1pPMzROdzJlaFVYYlZ1NVY4NXlVK0Vza0wr?=
 =?utf-8?B?eVVWdWJYVFUvK0tsTDdsNVZiMm9adGhtQlUxZjlOaUttZy9IQTM5cjZUTlVM?=
 =?utf-8?B?b21mVDloL3VOWGlrYlZPUFZ0YzNOWjBMYy9Qc1FxbmdzNmNMb0IrZHJpckpo?=
 =?utf-8?B?ZGZ3L1VSQ1R5SmpnemJvbzVQQ21GRnJOekJSVTlDMXRBMXpseWVYY2V3QW1R?=
 =?utf-8?B?U2dHdmlMM3poT1k1MEw5UUJwcnVzTTVrYnRDQ0JiS1RXK3FTNVZ4eTFxRVRN?=
 =?utf-8?B?c2NyVDFXMG5raUMwLzRKdlhuWG5KSXRKV0ZYVWFJZ21mZFBIQm42am53clNy?=
 =?utf-8?Q?oymP+IDbB9P06QN05/kdNC7KX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7edf905-1a97-41db-1665-08dd35e62e7b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 04:28:09.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RV5YbUJPqGxzU1aBW+oxmjPFS4Cz2FzEPQKRF76m/nczXs/I0OTC+V+bXWdzxIYciWiyBptx/EeiaayqFGNrLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

On 16-Jan-25 9:51 AM, Ravi Bangoria wrote:
>>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>>> index c75c482d4c52..924aa35676d3 100644
>>> --- a/arch/x86/events/core.c
>>> +++ b/arch/x86/events/core.c
>>> @@ -629,10 +629,22 @@ int x86_pmu_hw_config(struct perf_event *event)
>>>  		event->hw.config |= x86_pmu_get_event_config(event);
>>>  
>>>  	if (event->attr.sample_period && x86_pmu.limit_period) {
>>> -		s64 left = event->attr.sample_period;
>>> -		x86_pmu.limit_period(event, &left);
>>> -		if (left > event->attr.sample_period)
>>> -			return -EINVAL;
>>> +		if (event->attr.freq) {
>>> +			s64 left = event->hw.sample_period;
>>> +
>>> +			x86_pmu.limit_period(event, &left);
>>> +			if (left != event->hw.sample_period) {
>>> +				event->hw.sample_period = left;
>>> +				event->hw.last_period = left;
>>> +				local64_set(&event->hw.period_left, left);
>>> +			}
>>
>> For a better start period, I'd prefer the below patch.
>> https://lore.kernel.org/lkml/20241022130414.2493923-1-kan.liang@linux.intel.com/
>>
>> The limit_period() check was introduced in the c46e665f0377 ("perf/x86:
>> Add INST_RETIRED.ALL workarounds"). For my understanding, it's to check
>> the !freq case. If so, I'm thinking something as below.
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 79a4aad5a0a3..6467ecc65486 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -630,7 +630,7 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  	if (event->attr.type == event->pmu->type)
>>  		event->hw.config |= x86_pmu_get_event_config(event);
>>
>> -	if (event->attr.sample_period && x86_pmu.limit_period) {
>> +	if (!event->attr.freq && x86_pmu.limit_period) {
>>  		s64 left = event->attr.sample_period;
>>  		x86_pmu.limit_period(event, &left);
>>  		if (left > event->attr.sample_period)
> 
> LGTM.
> 
>>> +		} else {
>>> +			s64 left = event->attr.sample_period;
>>> +
>>> +			x86_pmu.limit_period(event, &left);
>>> +			if (left > event->attr.sample_period)
>>> +				return -EINVAL;
>>> +		}
>>>  	}
>>>  
>>>  	/* sample_regs_user never support XMM registers */
>>> @@ -2648,6 +2660,9 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
>>>  	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
>>>  		return -EINVAL;
>>>  
>>> +	if (event->attr.freq)
>>> +		return 0;
>>> +
>>
>> The ioctl(PERF_EVENT_IOC_PERIOD) can be used to set both freq and
>> period. But according to the implementation, yes, the
>> perf_event_check_period() should be only for the !freq mode.
>>
>> If so, we may change the generic code.
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f91ba29048ce..a9a04d4f3619 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -5960,14 +5960,15 @@ static int _perf_event_period(struct perf_event
>> *event, u64 value)
>>  	if (!value)
>>  		return -EINVAL;
>>
>> -	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
>> -		return -EINVAL;
>> -
>> -	if (perf_event_check_period(event, value))
>> -		return -EINVAL;
>> -
>> -	if (!event->attr.freq && (value & (1ULL << 63)))
>> -		return -EINVAL;
>> +	if (event->attr.freq) {
>> +		if (value > sysctl_perf_event_sample_rate)
>> +			return -EINVAL;
>> +	} else {
>> +		if (perf_event_check_period(event, value))
>> +			return -EINVAL;
>> +		if (value & (1ULL << 63))
>> +			return -EINVAL;
>> +	}
>>
>>  	event_function_call(event, __perf_event_period, &value);
> 
> LGTM. And you can remove the if (event->attr.freq) check from
> intel_pmu_has_bts_period().

Hmm, There are other code paths from which intel_pmu_has_bts_period()
gets called. So you need that check. Sorry for the noise!
