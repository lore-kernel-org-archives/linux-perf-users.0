Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020124.outbound.protection.outlook.com [52.101.61.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE3210C30
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103822; cv=fail; b=hz7CFM4dYrSHEXZ7BvM/bZJ4qFzhSLuhwy7jq4c8VLB+DC0FYBSYczuo3mKcW46Eeh+YN7aca3GunoKUtVSfQ5MJT82JIFO8137/RWndA/GO61wlOuYoQygxBCfkmY1G7g2Q7I7fTBdnCxmVTrAns4ikBc15+R+OnY2PJVDVh00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103822; c=relaxed/simple;
	bh=vFi+OnVuexwi56P7dW4PYgB4ZWGWuVEsXfkwiK265Qc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K9fbaIi7DMNX/zlfN3RDFGLr7htucQu3e7y61oyf6rZVFuHrWPyw2EBPA/0Sije4TYii4HBii7zxiJ43aA0T1L4yERSPYiCKVzzeckkh0qF0LpTNa6tbXmFO6NTuI1D5GwCSkyzR66eGtbN6nZa0ORj3DT3qxhNzXls8s1r028s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=LgDjmN0O; arc=fail smtp.client-ip=52.101.61.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="LgDjmN0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJrBge7zLy5m8bYlnvXajo2cJIl/a8sZELMU31QvGNGDpjr9Cc1ZnlNFtERiY7W95dfNpyH3w494CarIf2k2+lifM2WJDNgDNVLw5qh5b4J/bOpv9CN0F1/1qrGStaoUHgO/DhfXRCy+ogAaXUeTKLsqPS89mJK7KWzr3XmsIwInuP+BN38E5AlJA8WaK5wkzAywc9yzzD3LHqiRtOZK+VcjV64aWnZj43u9tcMxHTb5Rkm4rn5GmePMYbJJFjPQRlHb4pftBLntESV1e10fD27BNTLcneNxI+tyCDFQX0OdTNOkLE94Hmlb21JyS9lXgnDbCYhOh8cBys7MVzHrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flYV6AGnpy/1yDlKfojeV4Br4R0PXR28t9MaBqlIGD8=;
 b=hMP1DT3PyNN+mY4n8g3qnx5MYHVX56FsSQlszWTjCapd+GY6U9Xiwi4ApupjuUqbVsr3SLgwppLRdLXj3WiVX5kd6fq51HALJoIqEceIV6vDG4dheWb5PG84QN14hKxJ7iH8UjDm5BqfQKaDYiSBSzNqgYHcS3pIIsqMfWdZaq0JjefHv7WSjfGYryd9stjozTGDtRdoVh4/+5Nk5l3GY/egF5NqLuhenzPjkbPyrvPTSKSpUp38bR72ighEkiqu9ZUk6/zyWMl/b7inNLERv5EYFxn6SQ/ZH5HYYjM1NQHe++s/qNSetOZA5+pdrQHl/wx01Eypy1iBiv02DcvClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flYV6AGnpy/1yDlKfojeV4Br4R0PXR28t9MaBqlIGD8=;
 b=LgDjmN0OjONbA/OUJvRfJ2loXFASUGZ1CJtEFA6VwHFht/Zj/B3cBumwOUg8ph32+Gda3guLLZnUaFygQzxvc4O10Z82AOEZQfkWQPuLy3KoXPHSmWcLW0ZuMhody6z/+H3zRBu/aEaRcnKxhpQFg+uT1rA2Lpa5OE/eG8eKP5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 BY1PR01MB8946.prod.exchangelabs.com (2603:10b6:a03:5b5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Wed, 16 Oct 2024 18:36:57 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.031; Wed, 16 Oct 2024
 18:36:57 +0000
Message-ID: <ccdbea51-99ae-4e43-adfb-180c930ae284@os.amperecomputing.com>
Date: Wed, 16 Oct 2024 11:36:54 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V9 0/2] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Namhyung Kim <namhyung@kernel.org>, leo.yan@arm.com
Cc: james.clark@linaro.org, mike.leach@linaro.org, suzuki.poulose@arm.com,
 ilkka@os.amperecomputing.com, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <Zw_9ONdBzZER6zek@google.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <Zw_9ONdBzZER6zek@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:a03:54::26) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|BY1PR01MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7ae475-3a42-4f2a-f232-08dcee1183a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFRoTG9JdzVFZGRobVlFR3ZvcEREVFdBYktzeEZnckNTYXQrODRCR2prVFVD?=
 =?utf-8?B?eXdBWDh3UzZLdkRBZFNXVmR3K1hFMDNVUWxMaEZZRWpsaXRMQW5yZlhteEtz?=
 =?utf-8?B?emZ4OTB6Rk1ibGZRaFN1TkVrY3FWWjJmS1o1VDlXNmRPdzF3bkpSTzlIMlBE?=
 =?utf-8?B?VWNRWXkrZmZmeno3aU9XblEvZHVhYlN3ZlBJMHNWcnJTai9NM3c5TVBuanVP?=
 =?utf-8?B?WTFiYm1PakxsbG5pQmxMOFk2WENXSDBlMkFCRU5CVFBrM2hra2J5KzYzSEVj?=
 =?utf-8?B?ZWw0S2M2MVB5aTBpYUM1WU9sRFRUcW5Fd2ZqakFIYXlUM2ZNWFlma25MWmlH?=
 =?utf-8?B?bDdCTHZCSnNHcUJEcUV4V0NvWUhCNU9LdmhyZm1ITHNRcFJaREtqTFk5aGpx?=
 =?utf-8?B?MWlRQ0twVXF3MmlqZTJyUWZLV25GMWhaOC9YaXlzSG5lVjBBTVk5ZGxJbVBJ?=
 =?utf-8?B?eFRENGdnNXl0Um9iM2cyRjhKdmtsUUVUL2s4SDh2MGptU0IzNFFQSVVwM2VB?=
 =?utf-8?B?R1dvdDZIM3FVT2dJU0NJQjdLV2xDT0lzSXRJTmxMajI4R3A4NGNnUXp2cHBy?=
 =?utf-8?B?REFHZ0pnVkJ2dFpKUHZhemFUN01oenNoRHNNVkk5K3lJR25HS3ZJRitXeVdI?=
 =?utf-8?B?TVRGd2tGMlQxWmhmd1NjVHBnY1BWWVhnY01XSWxYMlZMV3VvWWxCaG1RQm5O?=
 =?utf-8?B?RW9Tc1BQQVlhbWMvbHZ6OVp1VHgzazR5bUt6L2EwTU91QkFzT2tJbGs2RmEz?=
 =?utf-8?B?akl2cm5tZFNlUjRqRU1JYkkwODZURU9NK3dDNzkvT1hSWVpXN3RXLzY0ajZY?=
 =?utf-8?B?N3VkOHpXTCtWL21CRXduSkNLSUZCSFlPSDFEc2tRTDJsdWRuSzFES25JblZR?=
 =?utf-8?B?cWx4T2tSVmxnbFc0NUlqanNHWWFQaUJhSEpZLzZiNHduZXFXRlBZRVJyTUox?=
 =?utf-8?B?VFkvcTNCa1VFWjN2NFdjMFlvbzJDcHVSQVNQcHM1N1VybFY4RitYSCtnbVFD?=
 =?utf-8?B?VlA3NzRDZmRweFUxanpITnEzVDM1MGRJc2lEUk5rSEdDVnI5VmloSytjcXlN?=
 =?utf-8?B?VDNCdllSK1ZsZDZqVTdaVTdwM2d4dHRnRzA0TzU1alZNWTV3Z3orOEFFY1J2?=
 =?utf-8?B?M2RWeFFqV2IrTndncnJiUE9lUllNSkt2T0ZsdHVTSWxGRzMrQi80a0cvTS9V?=
 =?utf-8?B?MjlYZTdwdjE5S1IzZVE2Y0I4U05mWUdVcjZTTWxrQm9jNWE3TUJWN1paNk1K?=
 =?utf-8?B?ZmpWanhpcCtWU1c3YlIrODBLRnBrb2prMHRMU2lUTVdUOEEwaWVERUdqVjY1?=
 =?utf-8?B?bWdtc3BwekpDZWlrc0wvWVRxazFvUWRadncvMVZYZW5HZ09zeUtKOHkwdGFz?=
 =?utf-8?B?NnluVUorV1NReTdVQlZRNUthUEpKQ1RRRHIrTURVOEdpU1hZRTJWUHFnejJq?=
 =?utf-8?B?YTdKOUlWaE5xdXZjbkozZnJaSlM2UUFxbWlGVlhBZ3JKV0trUENmajF6VWpo?=
 =?utf-8?B?QUxPcE5rc0toL3RyblN5akoyMVlyS2FneDlDRmhiMHBjRUhhQ0Q2ODBCRC9t?=
 =?utf-8?B?MWJia0k0MjNTZzE3VkltSS9rYTYxSzltSVRjcVJ6Q2VMTXVxNTkwV3lubk5O?=
 =?utf-8?Q?iteIfkd66R9KkrVmqiRuTBVWe2yG20Qz2YlyE5mjDs/4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXRKNG04N2dRYWgzc1IzSnF2cXVsSmJTbUNVWDVhL29LM1pZQUZJRkRBdVl1?=
 =?utf-8?B?bEdwSy9qMmZLbXI3bEdieVFuWk9telMrWnNQTUhLc0lybTFhaGxsTklUU3BW?=
 =?utf-8?B?TnRydWpQaTJmd3R6M29Yd1pQc3I0SjB2N0xPbytzWHlrRnM4cGZWMW8rQ1pp?=
 =?utf-8?B?ZHgwbW9VWHNKSEhoaWd3aDQvYnU2TkhDWm9QYTU1ZnpMd1pkWDdxSFI1anhj?=
 =?utf-8?B?L2xmdmVhRVp2QTVTVlVoNTRDYTluRXRpNm92b2ZmTHNENUVhOUdyZ001eTNS?=
 =?utf-8?B?MlBVb3h4UndXSFEyWTlNY3RtZkI2MXNMeSthVXREVjFJQXk1Ly84N0FTQ1lx?=
 =?utf-8?B?OGEzbnMxMFFaM0Y4ZDFMT2dHeEJSN3BvQWR4VElLS1FJWFFqbUFnSm9kaDM5?=
 =?utf-8?B?c2tVRHA1ZUV3cWxGaTZIODJuSENsUGc3MU9IR2U0ZlQzK21PdkJCZzA1cmNP?=
 =?utf-8?B?VURpczV1RmxUcks3cEphc2VMZGlTZ3FVblJ3dkl2ZEs0T1l3dk9wcm5IYm1j?=
 =?utf-8?B?M1gva0w1Uzg0VkQvVUwvRFpLU2dhRUlwSlNxNEp2anRkbm1UdCs0Y0FjdUdX?=
 =?utf-8?B?RWdCWUNxZlY1dEkyZXh3NXF3YWpycnFOVGU5YU9wd0oyN1N6UFByNmhUZER4?=
 =?utf-8?B?aHNlZ21tU2tDd00yVDVlMXpVRTAxSGdUL1Y3c0Qzc1ZsS0xaeWtaUnl0ZWU4?=
 =?utf-8?B?aklKcm5IRkJ3QzNUS3dZQzZrcUZFVStvbjJLbFpoVm1JNGRiSWowdlRYVG5D?=
 =?utf-8?B?TWRydTdLQVQwZ3Z4SE9JYU5FT1lFUWQwTXQ0OUxSV1Nqai83WmpzRndvWVhV?=
 =?utf-8?B?NUw0VVFxbmxDUVo3ZnYwWm9Rbjh3cy9OQzZnRGNrQWw5RllhOWZ4dkkwNXRG?=
 =?utf-8?B?enlwS2t1L3F1OEJOWFRXSWJEcDFVWVdKMkxCc3UvZzR2TzFoWERvMzRqeWdP?=
 =?utf-8?B?dld0ejJWUk53SkhtSTkwTTNuaytDSEV3TGNOTGZ5MThNcE5OUm80a3pWc0x3?=
 =?utf-8?B?cDFTZ1ZSRWZUS0FkL3hQYnFFdFJIV1dySUdacUNKRU02dUorQnpCc2FpRHNO?=
 =?utf-8?B?c2xFVDBKTXNBeDdmM2c1a2hIQ1pPSUtoWkdmbzkwemQ1ODBSU1VKOVU1L1Rt?=
 =?utf-8?B?aWdlb1VVUGhpVXFLU245T0R5aEZ2TzFmR1lIQmllZmdxMVJKZTBYZnRuazR6?=
 =?utf-8?B?Qm10VHZwY1ZyS2Y3L3cyRkRyN0dmakhHNTdYK3RJa1dBb3dEMXhCQXJHR2dE?=
 =?utf-8?B?UWs2cGVPMW4zbjRiWCswUDlxZ3RDd0l1dkNVUGJLMUhNVlhUN1RLVndFT2pO?=
 =?utf-8?B?N3hJZFJTT3VwbS9nVUhaYWpNem1zeFh6aldzank1V011RlNIYnhHL1h5SUxB?=
 =?utf-8?B?UHM5OFdOL2hubDB6MEF0RUFqZ1FObnRLQjdkRUg4TnpyWCt4Ymg2M01KWi8z?=
 =?utf-8?B?NUtRdUlxTldtaW15VHluR3FCb1o2OGwwQkE2YkcyRFY0SGc3ZXVVZ0xxSGlU?=
 =?utf-8?B?dDdEbjlPZEo1K2I0VXVvNnd2TFBVTWNUMFlITUtFeGRGczh4UFZtZlBNQlc1?=
 =?utf-8?B?OVBCY1orcThQTWJiODBvam01bCtjRGlqRXlmMUhGbW1SUzJzTlhqcTNGYkk5?=
 =?utf-8?B?VjBoTWRrOXpJMEh5UlcxNzJrUzJCTzBlYlRBRENhdS9xMC82SnVIeDd6b1pH?=
 =?utf-8?B?aHIyV2VsU29HRWlNempjMWcyRjBiV3dqNDZ4T2dSVzJIYU4wb3BNVGx2Mi96?=
 =?utf-8?B?a25qWm1sZ0VwSjlSVU9PSGtRaVNFWDdUYUNkVVNXUzdrUUNXd2ZCeElZYlhx?=
 =?utf-8?B?MDArZWJMZFd1TXRpWkl6NUlCN3pRM3JrbWZDcko0Ky8wQTFXMWE3OTVCRDF0?=
 =?utf-8?B?TXIwb25vUmFVMDNMYmkzVDlYcDB4OFc3OERWQ1YxUmRBenRJNGdLTkx1UWdW?=
 =?utf-8?B?ZUNvcTI2czNDMEkzNFkvTDBsU08zZnllaDhhdEIrVzBHZXhtUDNhNlh5R2Yv?=
 =?utf-8?B?YTdZV0tEekMxS1BWT21idEJ3akxzUnNSZytsNk9RWmxaQ2pHN1A0UUpoWmJi?=
 =?utf-8?B?V1d0ZkY1cC90SlBFMnJHUFFKL21XNG1KVXJkcGc5MG0zanBCWElhSkRFR0dk?=
 =?utf-8?B?SGpTMTFEUEpBbXFJL3dtVloxNDROcnJGKzRqRUo0blBPR0x0MkNFeEdvdjF4?=
 =?utf-8?Q?hEiCPhZlQ/f40YCm+8rezulmv3rkw0AFZEg6Cne73aDh?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7ae475-3a42-4f2a-f232-08dcee1183a6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 18:36:57.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plztBxoGzMVn1cb5kmm5vLfYPHaIcehHHrT+vUcSGy6Ul+oCb8R0tzCQss/X+D6vtQStv3fx/dJwtllOzG3wWTRp6t4VHZkqdtZ0vnbHTANDNnk0G/LgTBXp66EP6LZU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8946



On 10/16/2024 10:51 AM, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Oct 11, 2024 at 11:17:10AM -0600, Steve Clevenger wrote:
>> Changes in V9:
>>   - Removed V8 patch files 1/4 and 2/4.
>>   - Modified set_sym_in_dict (trace-event-python.c) to add map_pgoff
>>     in dictionary as-is without regard to MAPPING_IDENTITY. This patch
>>     file is now patch 2/2.
> 
> I think the previous version had Leo's Reviewed-by tag.  
> 
> Leo, can you confirm if it still holds?
> 
> Thanks,
> Namhyung

It did. You can confirm there's no arm-cs-trace-python.py script change
from V8. Note the patch file numbering is different (since 2 patches
dropped). The trace-event-python.c patch file changed so I had to drop
out his "Reviewed-by" tag for that file. Due to the patch numbering
change, I didn't want to add confusion so I left it out.

Steve
> 
>>
>> Changes in V8:
>>   - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
>>     string.
>>   - Remove map_pgoff integer conversion in dso not found print
>>     message.
>>
>> Changes in V7:
>>   - In arm-cs-trace-disasm.py, fix print message core dump resulting
>>     from mixed type arithmetic.
>>   - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
>>     CS_ETM_TRACE_ON message is changed to print only in verbose mode.
>>   - Removed verbose mode only notification for start_addr/stop_addr
>>     outside of dso address range.
>>
>> Changes in V6:
>>   - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
>>     map_pgoff to start/end address for dso not found message.
>>   - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
>>     by Leo Yan in V4 and V5.
>>
>> Changes in V5:
>>   - In symbol-elf.c, branch to exit_close label if open file.
>>   - In trace_event_python.c, correct indentation. set_sym_in_dict
>>     call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>>     match local naming.
>>
>> Changes in V4:
>>   - In trace-event-python.c, fixed perf-tools-next merge problem.
>>
>> Changes in V3:
>>   - Rebased to linux-perf-tools branch.
>>   - Squash symbol-elf.c and symbol.h into same commit.
>>   - In map.c, merge dso__is_pie() call into existing if statement.
>>   - In arm-cs-trace-disasm.py, remove debug artifacts.
>>
>> Changes in V2:
>>   - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
>>     checks per Leo Yan review.
>>   - Updated mailing list distribution.
>>
>> Steve Clevenger (2):
>>   Add map_pgoff to python dictionary
>>   Adjust objdump start/end address per map_pgoff parameter
>>
>>  tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
>>  .../util/scripting-engines/trace-event-python.c  |  9 ++++++---
>>  2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.44.0
>>

