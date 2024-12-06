Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530379DC;
	Fri,  6 Dec 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474894; cv=fail; b=EDBNlnM7bCv94xSZ5ueoJpsLRylpG7DqhTyJpDDJEFjyrngVs/Fzt46ezZDkA/fjcTI2u5Sf4UR5mkUFH8t0pRzLeWVqOgq8ArSUTVFXPD7xfYy8LMlxkvubJklGrKqck6sAprC6ylOVcFDLmuGAdQDbRqdja91f73dveALY+cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474894; c=relaxed/simple;
	bh=bERf4+m+U0eNcvV7YGivKPWrzf/CwPsTIiDva8Wr14s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rr9OfVn3XBFxvpg5ndX5HB8HGKlKoSrHFARtMm/9HCrMb16SaTQYg28eCP4HFdgRiKrV2JM1wsBZCPBIJUG2m+L3nV7HXCljcau+GiAXOGCn52qgrme544iMAg3Ic2P6R2bpE7Lrfkhsy+Y9aEDQY30y89sIpSuNOTUMpPjULag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jANCYYaQ; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jANCYYaQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw6POh6ryozSfISgUcGbIq90X0ckytrVkWwIeqteIFlzh3b6t2LTWgPmOrFPUNcK/0b2iHCQRa3UxccJx6Ket2uRaeP+X/jDb5KCw4Pz0waCSSqSiWs2aCb8FuufKT3SZ3MUXfjRE+pefLAUbdASWKxUGsNThdKMZLV/BTbQDDB6w6O4F/z6tl/K+KYx9Ugx6GNhonZi1tg89Gx8aJ1WnQerEKgZFwUD1c3MFyfUwmr9FAJbDVqjAoG/aFTMDsysAQdPZdTNliiqa+0KM+bg6MDLje37KUwPUpE36BA5ZiEIbdnlXJOFJKft3rAAdrMfQ+3HykKkjp1NaYbyNKu5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLy6nCGWV0qIMg9bFcZVg3VVoMXngYieHoSm4DQzGz4=;
 b=OW1lsHGQnkS1WDUPveoMTabBN/o5WbNkb7VC9L2/MEWB9V2jFc/XKKdfY8yrxVzkiOE+ECqTs6WBs0wNtYw3vdsNSd7x+xba3R4gByh6aVjZU83adz4OXBqowfxns+U3mW9RgwdkF4XQmR8oC8yqJ+YKtbnoF1UbWEYgk6mS0hRMwoCWv8uBXyKqPBqJdIE62YvDA5s111fznot+wMEe6qupzjXJWiaYqJ5WwhpjIUgOE/mbZJZ5O8e9brU7xWsWuDiQUmq8WqHGNMewKJzjA0oYWBwAQU/DVJq7kFiYo52EE6U3pR8RTgm86XIaBVHJCdYi8sOpXGYSYe5QcA+d6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLy6nCGWV0qIMg9bFcZVg3VVoMXngYieHoSm4DQzGz4=;
 b=jANCYYaQyiacTfAGb7ObCjeyT9JzX6T4UVbNOpYpuJhKQMtbioKaZF1Tdi8ocn9bhOqwlXBUywcdgg4SOvQc891c7yX8hzjKUkE8fxEUJfKIDsnOhHUkCRItJ/+pzctff0F6xsRA5TrIfTK+dIFktcobHwK3OzX+yD2YLokgfaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 08:48:09 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:48:09 +0000
Message-ID: <89d37e39-a513-44d0-9e7e-d705853e6d39@amd.com>
Date: Fri, 6 Dec 2024 14:17:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] perf/amd/ibs: Add pmu specific minimum period
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-7-ravi.bangoria@amd.com> <Z1K5D7zbwjXhZE2P@gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Z1K5D7zbwjXhZE2P@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067E8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::24) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c8c999-6b9c-4034-e965-08dd15d2b594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDdrZDJ5bEJ5cjQ4NEg4OVhUYXh3LzdmWERrY2xwL0xEZEZseU5STUs0Tko4?=
 =?utf-8?B?Z2ZacHgycExNc1pEbUZTOUhGNmtKRjF0S201TjhscjFSZXhlUWIreVVLWUwv?=
 =?utf-8?B?Y3pBdUo0K0NvWmVEcmdkUmp1L05hV1VUaHFNNTU1YkRlZC9xMWpnbjAxbHZT?=
 =?utf-8?B?Z29EUWpqbTBBWGlzd3JhUUxiaUNLOGRZMnNERVVVM3hHSmZScVdBVVpVUk1E?=
 =?utf-8?B?V2RzYWx5Z2xKR3JDSmNjR3ZhRFpPRjhmc0VnMWIyeU1DdHNkeWVTTDY1M0k0?=
 =?utf-8?B?SGpqNExpeFV0MUxVeXdQNUN5d1dJOTlmNkthQktjeWV3c0I4cmFGaGpvNE5U?=
 =?utf-8?B?dEVEQ1VvRFhnZ0JsVEZnNTQ0RHdUR2Z0dGZ5UDNwWWxtcjZGMjJtYnlHdjNP?=
 =?utf-8?B?TzN6bkIrWlRuc3UrTW83YStEbEF1ejJBR3NOZWxlVmg4Z0dncklLVFdMdEVq?=
 =?utf-8?B?dnI2VGNWN0Y4S3ZQUlBFMlRHK2NxZjdlR01mbU9XN2NjazhZd0pDVkUvemFv?=
 =?utf-8?B?cGdWZUFhbFhxZnRHeU1SMTI4SWg0WDFXcGZBTm55SjJaYldzMUJnTitOVXEx?=
 =?utf-8?B?Njc0YjhMSTg1cEUzNWVBbXJLMkh4VlR4OXFjK1N2V1NGQVRYd1ZCZUFubkVZ?=
 =?utf-8?B?ZGdCb1pZNlk5UW15UkpWWGVDU0k5bzFpdmxHVFhsOFFDRE4vNFAvdkpjNFkr?=
 =?utf-8?B?VHhiU2hLVllmYTVXWDYvTnpxT2Y3dWp3NFYrWFZuQU10bXQwUk5tZS95NVpH?=
 =?utf-8?B?cnkyOC9sTUprOXVPZFN1TEhveDJCMnpwTFYyZ3Y0YU9zY3c3UC9rdko4NjRm?=
 =?utf-8?B?VTlDaytQbU1ldkVTWHBBNXI4ZW5LNk9ITmMwZi9YRGd1QjdqSFUzVEFoS1g5?=
 =?utf-8?B?OTh6VGtVSnEwZFBLUEJ4UkF4VEJ4RUMwYW1scGs5Q012U1Yxb0U4VC94ZU5K?=
 =?utf-8?B?QTJ3ckRlaEF4Ym11SDdWYnlxV0IybHY3cSs2ZEcvM2QwSTd4T3d3ZUpvTTRZ?=
 =?utf-8?B?ZzRIb3Rmay9RRnhyeXhYcmRHMm1kL24rVGdWYXhzaXVMMklYQXo2MlJiTW5x?=
 =?utf-8?B?UTJEMVU1eXVEL2JzSVpISGt6ZjFRQ005d0wyems2SERidFhaTW11c0VxdG9T?=
 =?utf-8?B?a1pCU3NxazJiY1hhZUEyanVCQXJkZjZpSzFpdUZtNWZLNjJEcmI0ZXBUdHQz?=
 =?utf-8?B?c05HSCs3OHBiRFNEN3dnMHRQUE9kem9Jb0pPaGswK1o0THJ3d2xYNjRrMFk4?=
 =?utf-8?B?aEZWT0ZLdldmUVROdFRQK2ZGankvaEk5Z3Q1TElBalZjM1doUElaT0VzaXdZ?=
 =?utf-8?B?WDdmdDBveHVNbDI0RG1uT2daTEw1UzU3QlB3SXgxY1FJd2ZqMTMwMldiTXJ4?=
 =?utf-8?B?Q2QxaC9ET0ZMMDM1RTFmdFdUYjYxWGhVZnpMU0VYb256QnZGQTNNVHV6UDJn?=
 =?utf-8?B?ZlpxWFlZNk5IWWw3T1VmSlo0d3VuRUptSi9rSmVqMGYvUkMrYXRha3M0Q0Jj?=
 =?utf-8?B?L2orQlJxeElHSmN2N3VkMWRINCs3YUF1OUpDd0x0N0dndjZPTGcrUHBWRjhF?=
 =?utf-8?B?RWxuUnQvekdQVjh4UUxlZVBMWml1Y0VtMGVJMy9SY0hJTGNoZUZsR2ExY21U?=
 =?utf-8?B?c0FwSkdxVitCQmhjMm1QV0xJTEp4ak1pdEw5UEthVmJybWN0QTY3UWk2Qkx3?=
 =?utf-8?B?bnhhSlRqblIwREROYW1HL3JpQUNQbWRqOTd4bXY1SWNlMEF5MjBoQWwvb3Bx?=
 =?utf-8?B?M21wbTN3dUhZZFhyb3EzSElTV2NEOHZTZ3J1UFhsakRJUmdybTJYcVBsSEcr?=
 =?utf-8?B?b3l1NlgrZy9sQ3JIZHBVUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dk9OOG1WeEh4ekV1WG9QaHN0aXhWclhwOWlmcDlva0V4UDdqYk9YMFY2QXFZ?=
 =?utf-8?B?UlVzM1E0R1ZsOFdQbmtLUkcydVRCZ09KUGxkdDZQeTYvdHNaN3JQYTZYR1Zz?=
 =?utf-8?B?MGhxMEV1NXNkL3NHdmpqRE9rZGhJSk9PdGpOV1VFQmZMRVVzNmdqUG1PbWVP?=
 =?utf-8?B?VDEzQjQzUEVPQUJlYk1POXlOMWVrS09ZLzdDWUtDNlpKVXczamt5ajBNelpH?=
 =?utf-8?B?WWtUbHJWTVQrUVVBZTUvak13cVZDTnRqZUoxQ3ljcWxHWGt5S0h0YjFMb2ZF?=
 =?utf-8?B?Z2hWZDJyMFBhM1Z4WVUrQmV1bFlNMnBrZUtBeXRneEZkdStvSGZLMlJCTlJw?=
 =?utf-8?B?YW1sdGdRakNPSDdKTW5tL0M0QkUraGs4VTZTTkxhcldwRDNsWE1aM0RUVHRW?=
 =?utf-8?B?V2h5UlRhUElHOXpzcXhhUm1DdFVEWmV3Skwxa2VlV01DTVZhM1hCb3AweEU4?=
 =?utf-8?B?d0Y3dFJ6WHRWVXZ3OTg0OHI4UlR3dlRHY2dKd2FqRUs4Y2MydHlDSE9Wb1FJ?=
 =?utf-8?B?KzhZQVc4b3JKUzN1WGRXZVQvamJqc1FkcHFFWGpJVnAwN2UxN2RRYUozVzZr?=
 =?utf-8?B?dmN4OFpzdXlVWE8xZEhjS1p2Ty9IbS9WUnIvMU9MdE9qVXdIMHhENnIrUW5J?=
 =?utf-8?B?QnIyWDFTSHdMYTFBYWppVlhVUnRIWVYvQWQ0Rnc3NFlISlUrWlhSZ244QnRP?=
 =?utf-8?B?eEY2ZWltYUY1NGlheWc4SDhiRzd2UDJRTGtyV2RoSFZxTDQ0WUtGYlVxK2cr?=
 =?utf-8?B?QXJXKzFFRW5yeno1bXF1TDlqUDA5QStGWW5Sa2JNS1ZHUFVCaUJWSTJHZllh?=
 =?utf-8?B?bU5oQU5yY25vNUZKb3pmZG1qUDU0YTNscW5wQkwyRnV1SVRGaFoxdjd1WEJY?=
 =?utf-8?B?L1NJTU9pRGdzTUJqQ0kwMk1DZGJDZVdpSXphMnZ2ZmR5NGlVYzVoUVlEYVIr?=
 =?utf-8?B?UFJaMmRDZjdTaFNZSCtDVndZNXhxUTFubk9JK0xkR2pXSklONVBaUWxlTGsr?=
 =?utf-8?B?Q3RGakdBUlU3ZDVzUUFSaC96KzJqODRUT1NqN25qaS8yQ0J1RTJzT2R6Z2t2?=
 =?utf-8?B?dTBVTWxubklmSXBjQTdOU3ZCYUMxRk83T1JvejlqS000cnR1QS80YkpZUUdP?=
 =?utf-8?B?WTJEK2puN1NwbDl2bTBmb3BMT3YvdnJsVzFtUDVBdHBGK1I1WnViRzdTeHhO?=
 =?utf-8?B?a29DTVBobktVVE94eVhMS3VSNWE1QnpKcUx1dG9FU0pJRVBESnp5Y0QyWkFn?=
 =?utf-8?B?bFlKT3ZmcE10VC9sMWVvVmQ4MktnYXJmNm5kRkQwdDVHem1qWFNGN3hvaS90?=
 =?utf-8?B?WTFxQlhpbWRDZE95a2VtMDFTTHlPSEh1dVF3WEp4R2F1aEt4SktybUdzaTBz?=
 =?utf-8?B?c0xFT1QxUXkzc0xURFd2RGF0N0lYam0zWHgvaVhLOVhtSE1RcEVIQjlyTlhs?=
 =?utf-8?B?bU04TDJWSjBvdStoU0NLTGtPRzRNWm4vMW16M1UrK0t2QTVKeTk3WEtyZERN?=
 =?utf-8?B?TXBHR0ZiWEtVZHdKU0tJTG9uVzFlNTc5TnNNWWFvblVSS1JoYzA3RWVPYUdW?=
 =?utf-8?B?N041TlJyTlI3eldsMDg2RDJ2c3lMYWNTYWozbmhOVGVPQVBCOUQzamlqVzVE?=
 =?utf-8?B?VnlzME5wYWRGMEFRTUFkSDI3aXJQbFVPY2RLK1pmT0E3cmF2TE43T3NyTG4w?=
 =?utf-8?B?U2pkbHhvUHprV0E0OWdZWnRLazNvbEYwNU40dDVzOVBJM29yM1V2ditJZ3p4?=
 =?utf-8?B?YjR4MXA1YnZXck1CaEFjSmh4aE5XTncyRCs5RFA3eDcwbHNyRklJZG5HZGtJ?=
 =?utf-8?B?aUJ4aVF4UkxidFprMkJpT2d6bkxGYytOVDRBWXdHMEV6czh0N1Y3ZXlYUFJF?=
 =?utf-8?B?czYwMXQyVlR1MGgxdUdDOGlJNllUSFJ6NngrOW9nTXFMbWRSTTRWQjh2UCtu?=
 =?utf-8?B?RHV1eFhQbHpuRXp3a0NJdDNVdFBVR0N5TGlPbk9PZXNva2VodktqdkNqdGtM?=
 =?utf-8?B?bUExc2FsOGdoNVJQTmswVlJUb0l5MUc5K29teHBsanlDdUp5OEdvSkI2bk5D?=
 =?utf-8?B?R01YY01ZdnBNeUdvWG5uVU1vYm1BWGVjeGNMcTNBa3pETkpYa3VpYUZTWlhG?=
 =?utf-8?Q?16y8jKyMLNqrtttF+lBsasgZF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c8c999-6b9c-4034-e965-08dd15d2b594
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 08:48:09.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OjT+Q3SizX3qeSPE/tp4jHiL4Eda/WcgShFQtPEQDOWUZF+W6Ho1FkQM14rGaAGC+9A7BET/S/eoKY+/28uwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

On 06-Dec-24 2:12 PM, Ingo Molnar wrote:
> 
> * Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> 
>> 0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
>> Current IBS pmu driver uses 0x10 for both the pmus, which is incorrect.
>> Fix it by adding pmu specific minimum period values in struct perf_ibs.
>>
>> Also, bail out opening a 'sample period mode' event if the user requested
>> sample period is less than pmu supported minimum value. For a 'freq mode'
>> event, start calibrating sample period from pmu specific minimum period.
> 
> Could you please capitalize PMU consistently, like the rest of the code 
> does, both in code comments and in changelogs?
> 
> It's "PMU" and "PMUs", not "pmu" and "pmus". The only lower case use is 
> when we mention 'struct pmu' - and that should be quoted.

Sure. Will fix that in next revision.

Thanks,
Ravi
