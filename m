Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021125.outbound.protection.outlook.com [40.93.194.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAFF1863F;
	Tue, 29 Oct 2024 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167602; cv=fail; b=D5hic5xM3cE4SXj7i9sv2ehcHNXx7E5rmHZmK0+RSfjQvY7M94MgV0x3IRgnM++eJpriATME/6EuDV0Abgm2a38joBtRuxiUom/7xHKa3oWX66pbf0f3lTHcYCuAd5q9Nsar77Kywcg2bZr7/P1tdQVUMyDvGo8g1WO15UBezrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167602; c=relaxed/simple;
	bh=nZGwlRkkuEgEWafXnkb2A/rHt9iJpVPRxM3yGvryXfE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=EaxXMU5GrvrBct01+vn8SFOcUKFQpaURhWvefwHJo+C6WnwOqhL+rhS3qp6RNdElnyKE4UGp4L5AtUsLhcKHgcTqKS/e/R3k+/3ijbAm0MHq2QC5s92Ku6LB5A0shoo6wnihUXIpTzcdIouWUPpN09eTGMl7ECan0axTsqcppkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FKw8OPhw; arc=fail smtp.client-ip=40.93.194.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FKw8OPhw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5QJGpRAR/Zf7kYqawr/x327FC5vLQMNJ7aLXk/jCT38Jph2IAZtnCt8flQuEUZCdV6B9mmgNgKvT8EBh2xc/9c1x3Y07KgmCesUmg3fZaa7CCmfiqaNsePXcE8qbk9YEXaeEngpJZre6e0BE2Kb5q9F4YsBGThWGOi+jpVoSSC3H3wELPa+4fFqBNDvFmVZA3hUpItnv3igzuEetny4UdFrxixzcAQmkAPqJkVGAOXZW8kc0cI8Wcyzu8/dg/PNvUC9XJlasH9sF44FvwPZZRCh3f/k+L6zn30WnebQL4fHZ1eek8UB86ULqOs6LY8ccHpiGDrsn3LhR7qqPFis+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GohEJTe/VaXsTQ/cdqizfcGlHjb+s8TSaZHmf74By5E=;
 b=MoFtuWUBPCKIrRFdJOQvh+i7PoTlMSR3QKX8UTH0UESV/7JhqOu8Oea2fbbUcMTVHSAsXkv7IE9fgVnUTLqOyZZHYhtKYi63yMfWUfoMxyLyAHw1inZ28xUl3pyR9KUtrXiOpdHlnBKA+wi/T3vZ35sh72/bbm6nO2svMQwfBbydDXjrUWCBtUKd+sjunTzgHyK1VfsSJH2DAffdGJ0seaxHfMOkoL+icf52VlxHXt1QvVVeZRqHFQwZznabxtcuIvPfDo5FRtdLvXlPGTKnlyZH1VtE8vgs4bHNRM2c8TgRLhhe8lqzGDkLoUv0hE1TAklMhZfwhSLYLAaduEROwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GohEJTe/VaXsTQ/cdqizfcGlHjb+s8TSaZHmf74By5E=;
 b=FKw8OPhwC4PsaAbnV4bK6qfKPPILgZxz4bm2dmT2hz7853LzwGoBhFkad3c9hSo4dwNvMtg7FwDjf/Awr7YQlLixFCt/dks2yAwP+j4pfyodiqUhp3JIX8UO7wyY3Fi3hU6H8A9btZ+tnvi8jVik2shNh2tUbkrkH/vyQsv91EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CO1PR01MB8841.prod.exchangelabs.com (2603:10b6:303:26d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.12; Tue, 29 Oct 2024 02:06:37 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 02:06:37 +0000
Date: Mon, 28 Oct 2024 19:06:26 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: James Clark <james.clark@linaro.org>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
    Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 AmpereOne
In-Reply-To: <963d58e4-c00e-40b5-bb64-97476807ed61@linaro.org>
Message-ID: <86abfa22-4d2e-2a4-7365-571a69e8a233@os.amperecomputing.com>
References: <20241024233035.7979-1-ilkka@os.amperecomputing.com> <963d58e4-c00e-40b5-bb64-97476807ed61@linaro.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:610:51::28) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CO1PR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: c3439dca-8b1f-40d8-0c26-08dcf7be51bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PrsAlP7h55hbnjWCQhwWCW6cYtsP8Iqmz2ZTqd6McNTS/NhRGeUvniiFwxNE?=
 =?us-ascii?Q?sm4+kRbY7vTT23pLlO+PYr/fgxOpLZQyZw7VciGniMYDIJKzf9SUCbAjXjBw?=
 =?us-ascii?Q?0rVtDYg6ND4ED4xOhYowTxxen+PBXMxOZ+mtfNlHsB5hduOh5erXfM/o/UlE?=
 =?us-ascii?Q?rG8kRaMH30C4J5zWBv+sWm9plWjH26xMM2Eg//ZbcBU4K/axw2eGLmzh+Dyx?=
 =?us-ascii?Q?FT8JO5IToH+wrhF96gQGEcrHFH9Dhv3o7y+LvQIkUcHNvRS57lLyXN+/EBP5?=
 =?us-ascii?Q?6bT0U+psp3b/gsSypDlDxf5rkXMHO2dW0x5Mb0QqhSA0bZE+9nAvrcgR0lsx?=
 =?us-ascii?Q?JEfCmjRLaK/6xvZicndGM3zXXh8Li8YAuGaeJeyjEAay3Qg90kcMKSEexLPX?=
 =?us-ascii?Q?un90BpN0UIa8bgCV/RObZhzd2RgU5wbDsQXdv6ZSxpwhcSroIYtWU2sddRaa?=
 =?us-ascii?Q?wA42MzpXoyNueJMoivVDoVgltrPGeDlL+s4QevMVwLZBif2qj8Gd3RprZpQL?=
 =?us-ascii?Q?c7yelr0f5gU8NJ+vZ94xaaaKDp2PtiGPWJmCsTQtLhaYYO2qmkBQGAGnzQgg?=
 =?us-ascii?Q?rzXNILISPmDM3N4etzyRlEZgPM463eZeG+dVJX8pThat73KI4QgHrZwllgBK?=
 =?us-ascii?Q?rdZGV7XqhCLgOws7E7NW0xQ7eT4+PbWQ6tZvo9Dbr+wqLsOw0WACz/gQRifr?=
 =?us-ascii?Q?Q3oJwPu3VuRpnF0z7tsf/i+8iJQmEA4TEGV/mtoP5mKJB5LKUN7s76YqOWyH?=
 =?us-ascii?Q?u7tPh6pWiZZKRZNp7pKBzVXWpYbIUGEaIIif/tzqRHfOdhLfM79w+8wDbB08?=
 =?us-ascii?Q?nUUlL8DbnJTnZV/2/9vwsK0RFcRpOFe7wb/LvFbpkwzSEVgjgii7igLAp6cv?=
 =?us-ascii?Q?kkHBPlkjs7zOp+A5DreHvx7MnMmhjwiXKraL4aHJw8jOdk72ir+nfB7yaPl8?=
 =?us-ascii?Q?UA7KdOFUmLCBGO6QJFGCj6rJfmnISJ2EGkbElPcNMGIU5M0R1frwFDRU1Kyo?=
 =?us-ascii?Q?cDGoN1gXUIb0kBEVbYm6wGJ9gKF53CkXlaTWyzgqXYBal1SBL0HygHDM73ld?=
 =?us-ascii?Q?L9F5sD8Qgja8lNTlw1+gkteQYqSWHJBp0dxv8YzZowg3rXX8UwfbupehfwGo?=
 =?us-ascii?Q?y+liV1CFb4U/NvoKV6PwPuPy4pCwsq4bxff9SVho12vXuq84hwwdwk/oY029?=
 =?us-ascii?Q?m++zbF18/NihNljKGop20lcvMmvSucfZm5v7Nx/rydnldy7T6LXjdABLimnx?=
 =?us-ascii?Q?d0kSb7hIsJ6SEyQFccg3I4pH/iN4FJZR9r2soUvtQsgjRxNC0w16fnnFnQQ0?=
 =?us-ascii?Q?mXmZCwJsdpNdz7MumV2WJK2XvoJa3ryRlEcuA0lKy4c0xSdxHaN8XybrtyQA?=
 =?us-ascii?Q?0oRejSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1C6oq3UGNScsVPpDRa+bADZfzTFiI7R6oVHmluAqax+szvvIs0Pzn2KpzuOl?=
 =?us-ascii?Q?M3s7eAjPkZgHQXO2ywzLfcuOui1QV8HwDjC71CUtGkZ4rX8uucykXWgidBjr?=
 =?us-ascii?Q?d+LCEQXjyg2VsrVGW+AE0+MtUQ7OUfw7tql/Oo4Mf3ivTi5jD7w0YU1lmLPA?=
 =?us-ascii?Q?WWp1OCf9amljjn4onTDjm07t+QCSf8SFW7G7YlO9yTCRZZ1QG8Qasnldqo/J?=
 =?us-ascii?Q?XcFTUdSkYbtADGggLviNg5keioudOO42RMmlom79KIu5s4AGTTNa/Ta08aN5?=
 =?us-ascii?Q?mXN35vbn12g0Vi8C8MxI/+4TDNIKXpYEKMmWkEuVUyiaB50/RoLCDIRgmZLL?=
 =?us-ascii?Q?MVst/iPNC6dM+eW61bRh7OeEY97MN9GT39xK25cmNpd9tp76kL8gh47BbR0Q?=
 =?us-ascii?Q?aNyn/mPdyBlYOAZ3fbSsKra2r3SeMO8jEX9fxbhpFwtvLf7/llWtuwdGDdxv?=
 =?us-ascii?Q?jMSg5l2XM+LdQReEeq/kh5/tfz/5dFuI7H6GOAWV2f+F0KJqcXus/1gnD/UJ?=
 =?us-ascii?Q?ZIy9y2QRndDUDk28sSPaEoREugHHb090soZMNk5BFGQd6bXeFXtYE4K8+nr6?=
 =?us-ascii?Q?NYSD4Apobt1SKOiUOEWeTYCPIAdCr2vTiwHTjoEM0/HPf5aBEvfYDvR3v7gz?=
 =?us-ascii?Q?q2kmGh84FyG40eAgBP0ekxF1EZKHO3L3nOz2cWh4lfjROaQOZaKL6Xmos7l8?=
 =?us-ascii?Q?0gwFqtrk9rQBVrss6iq3MF8aNWJjcGvoLBvtev8pJrAnjnjGOYZ5s4WfBI4I?=
 =?us-ascii?Q?tEXM8cAlsg9xKyxE6THN/RuYIhNW/kouOyhX37qqrJNjnLmpmDr/RP5NDrHx?=
 =?us-ascii?Q?rEx8kUu3H8YLbefNbaRBVPemWRlJ6fXkanEQnKDBN/u1K8LeqmsYBbeO3AzD?=
 =?us-ascii?Q?c8pmhAX4ATyFRrQvf7FtR9QK9uSVhDdnYMfK3St8dSKSJdSlcBKbkgtZquFk?=
 =?us-ascii?Q?8I+QnaPnA6okP0QtsU3FHhoz6HEfRFYLxjrV+YKCudNDID4cehXFPwQ2iW5N?=
 =?us-ascii?Q?Zs2QVucQBs4x/C7L4ICYUo+6++/3GeW05GEygc4RwcLT45e2Lckc2z9cZmAb?=
 =?us-ascii?Q?DP7UKRE+pOnbWB19Na9wgsiXcdMl6hAnGILjdRGq5hLxDWV8+qrxsm/97qI8?=
 =?us-ascii?Q?Tjd4tF7fw7p+r30BKz1ttiQq/FC0czfJEiG2uvUWAi5iHMRYPtyWoXjZWLV3?=
 =?us-ascii?Q?MRkAQzhf8VWuO9ihJZMpklbPrpowQDB+UUjjVINMfhAN0puvLEdi9UTjZRLy?=
 =?us-ascii?Q?seLlRfs+kw0aK2QmI78YNXSjEGaB6yCvNsAOLICHRzCqXHvIOrkzF9iob2Gn?=
 =?us-ascii?Q?3rZu3CXUi3tApjM2ALafQqasd0C/VC4k03lAvubzqTnyjPTjJnyB7psE4nhP?=
 =?us-ascii?Q?th0iiqfONZAdxac5L2aZGYBvELI4wGHO4fS1DjtalKS/fOhdWP6sLFAFBh+6?=
 =?us-ascii?Q?f0EyHNTE4MSaAtaprfdapYeVzR6OKTfpjLsYW8X9QOauBisYiKnbQhbUf/Q0?=
 =?us-ascii?Q?pafW3DMGy+tqdwtJKeE3QmqxaIXT8UlfAIv72n99n3fOunx/AnmDjO1Faufm?=
 =?us-ascii?Q?eRJbjOAEp6IJr0Tbvg1wUT8iKByl+5wk0MKYZQYXId5BJCPCWhlRnRpdFYh2?=
 =?us-ascii?Q?Jx+g7UDJXPfTJlXiiuJzw/A=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3439dca-8b1f-40d8-0c26-08dcf7be51bf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 02:06:37.1304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PNO2RnW7EtKuxmHMunYB9Ja1wDQMLuA5oKVwX7km6KyHkqeEXdLDadNeZGRJiXaxsLD3Z2mLyEWJln50G9T0uQjXGpggNYKGZz50ohCWk7lA0ZzjJrwhIBxONNfPHvF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8841



Hi James,

On Fri, 25 Oct 2024, James Clark wrote:
> On 25/10/2024 12:30 am, Ilkka Koskinen wrote:
>> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
>>   tools/perf/util/arm-spe.c                     | 61 +++++++++++++++++++
>>   2 files changed, 70 insertions(+)
>> 
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h 
>> b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> index 1443c28545a9..e4115b1e92b2 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> @@ -67,6 +67,15 @@ enum arm_spe_neoverse_data_source {
>>   	ARM_SPE_NV_DRAM		 = 0xe,
>>   };
>>   +enum arm_spe_ampereone_data_source {
>> +	ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE	= 0x0,
>> +	ARM_SPE_AMPEREONE_SLC				= 0x3,
>> +	ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE		= 0x5,
>> +	ARM_SPE_AMPEREONE_DDR				= 0x7,
>> +	ARM_SPE_AMPEREONE_L1D				= 0x8,
>> +	ARM_SPE_AMPEREONE_L2D				= 0x9,
>> +};
>> +
>>   struct arm_spe_record {
>>   	enum arm_spe_sample_type type;
>>   	int err;
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 138ffc71b32d..04bd21ad7ea8 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -515,10 +515,69 @@ static void arm_spe__synth_data_source_generic(const 
>> struct arm_spe_record *reco
>>   		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>>   }
>>   +static const struct midr_range ampereone_source_spe[] = {
>> +	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>> +	{},
>> +};
>> +
>> +static void arm_spe__synth_data_source_ampereone(const struct 
>> arm_spe_record *record,
>> +						 union perf_mem_data_src 
>> *data_src,
>> +						 u64 midr)
>> +{
>> +	if (!is_midr_in_range_list(midr, ampereone_source_spe)) {
>> +		arm_spe__synth_data_source_generic(record, data_src);
>> +		return;
>> +	}
> [...]
>>   static u64 arm_spe__synth_data_source(const struct arm_spe_record 
>> *record, u64 midr)
>>   {
>>   	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
>>   	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
>> +	bool is_ampereone = (read_cpuid_implementor() == ARM_CPU_IMP_AMPERE);
>> 
>
> Hi Ilkka,
>
> I think this read_cpuid_implementor() is for the device that's running 
> report, rather than record. You need to use the midr that's saved into the 
> file.

Uh, that didn't come to my mind at all.

> But it looks like you've done that for is_midr_in_range_list(midr, 
> ampereone_source_spe) above. Is it possible to just do that and not 
> read_cpuid_implementor() and then it's done the same way as neoverse and also 
> works off target?

You're right, it's wrong and there's no even need for separate implementor 
id check. I fix it.

Cheers, Ilkka

>
> Thanks
>
> James
>
>
