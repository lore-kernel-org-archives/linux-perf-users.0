Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021085.outbound.protection.outlook.com [40.93.199.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19E10E3;
	Wed,  6 Nov 2024 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853150; cv=fail; b=I+umLQWoDsh+nVNnpYi1SYX7rZtcBvm2e0WBp80bxwVF85/YPyTNkyZBaIfhQU90kCEIuzn/GQ3c5mfVqEUhdW17fm8xnc+T6T7B5SiKp9m6OhUNVDglz4KwbPQNpTAvS0oVRdAjBA4oWFqhWpYFKrhFpc+9edAkH0VpDwEMqxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853150; c=relaxed/simple;
	bh=NfI6RDa95zsn3idGHM+KTJB+Y66LODokFNN1lR+eFGA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=GAOB2fr2ADkZzfNwHT/KM3h5Q+s/viDDDKtSxiVRgn1R2w0VQgYJ005gcm+9rzZggD6+nqHS1Pq4FpbjhjA+57u4c2IYA4OolImSY7tQ+CBEXmG0NY7sC6/0DCchU0gLR9qHigOTzYKDIogCEM7KJgmF/qDhe5bMN10mnY7BdKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Vo+bLEoI; arc=fail smtp.client-ip=40.93.199.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Vo+bLEoI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcCEuwnaqginx95X5UaFH4UcLe1sBgewVlirpna+B0C7NEKjMsvbeIONyZGcgDvar48Ngb2wRB14FQYlZIoE2hL7UW/b/9JSpFHzPeNBOTrSx3X/SgM1qWdH+5Y/9edtmWiVOd7Gma/2iME+hC4SdLtl1phjiHA3RN1j3gnjnMCZ3PQmIFYOyzaqm3AC31k2WmBin8nx4KvdTqaZKVrpROD+stVigiOEvygMKn6aX+djRB6NgYUjBnyhIZIg+0C6a/yta5MvFsP50yM8AzpuZ9YRRWpVIfPLoruCa2lpDzCA6g1aBXgzc2+obEDi5Zx6OdG59owBUrAWPlEiD+d65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OonQ3n27GpTNyHLcyJNSYW94OP6gRJ62TNjw/KhLJZQ=;
 b=qI2KLWsFs0QMeeGvEZcOb1nuhDglQbKi4naW8+eU7F4waTcIGCMaXmohLdghGebJb8RcNm30vit58rt2xhAFsOmbeHLO7IpbhcQFB7RSIa/dkkFdAnC6mpkOaye5OQXJmvJW21kczRrofiUU+O6CeS0mUEaYpfrRzzl3n72EMRB1Aqxe1byKhASg+ael1ytXRBgQyKTAZgRzME4f/VpjL8ZRuKJUWUL0FOfg8rY91jj1GOaXdZFWUUCNcAHA/07mHPIo7j/PfG8Wb3+hdRp0sTK5D2pusvPzcU/e+GGY7Y9X7BojklAMt/VFXoyo8+Q1Uf9oRC7ln/VCnf1iVgPAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OonQ3n27GpTNyHLcyJNSYW94OP6gRJ62TNjw/KhLJZQ=;
 b=Vo+bLEoI8uDRFYtVsAUJfipHdj6CRZyVT+LFqQnra5SDXSx92AyK+YKqEo+M+75iHDRUwNGTiBlEL0q6c5DMgSDiwIOG6arCZIaHnHy45m1LNzXBOCjP9/VVuAAvTRJ+SmR/gk0AoQ2Rj2LRtYhQLxFfxIs4uLlSicWVZpZYwGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SA1PR01MB6655.prod.exchangelabs.com (2603:10b6:806:1a3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.19; Wed, 6 Nov 2024 00:32:25 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 00:32:24 +0000
Date: Tue, 5 Nov 2024 16:32:20 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: James Clark <james.clark@linaro.org>
cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
    Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, 
    Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
    Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Graham Woodward <graham.woodward@arm.com>
Subject: Re: [PATCH v2 2/2] perf arm-spe: Add support for SPE Data Source
 packet on AmpereOne
In-Reply-To: <ed15526d-9b1a-4204-92a3-4d319b03b790@linaro.org>
Message-ID: <4c2aa7e9-8e4e-aa1a-9c0-23c62f6b15cd@os.amperecomputing.com>
References: <20241031213533.11148-1-ilkka@os.amperecomputing.com> <20241031213533.11148-3-ilkka@os.amperecomputing.com> <ed15526d-9b1a-4204-92a3-4d319b03b790@linaro.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SA1PR01MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 5102dbc1-7763-4604-fcf1-08dcfdfa7bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RgOYK6/UjwkdJh3DzLtOAb6Oyb9TDzwzoq/NFSrO9rc+ZpC0UYJzRzzfaY4W?=
 =?us-ascii?Q?TXvcIf85Ro7jl+C+Igx2By1moPEkDKRQkic5CYrZG+qluvkKPWdtDDAQjhlX?=
 =?us-ascii?Q?82UjYri7hZqkgTIx0v2GxAf+Vq1MgUBCt0LGSawfzQNXFalOl/E2VTu8nUsa?=
 =?us-ascii?Q?Ur/tIJb1YIqerljOWu1AEpCO3x0oNMTM0TuKW/HqoT4348h1qJ8bje6+r+NE?=
 =?us-ascii?Q?YJ0miXOyZNc7/HzXQXz5U4USf/l2gzO7U+lDDNt5YBrmclOpKbMURFzfyIWG?=
 =?us-ascii?Q?zl7sGc6rTW6bZViI4DPvk82IZWzJ97d/UwRtG3YFzyf/+Tf83Nw4spE+RCRO?=
 =?us-ascii?Q?T7Uafvsl21aa2tkak3I/V03OQWr5srZzWmfZTQMddrt4FDE5oQtKVz+7OliI?=
 =?us-ascii?Q?lwY8yPftXaDgab2czTl4NKVFXNXTYh/Rq5yt0aRmZUktM3cxowBrsSBTP6OH?=
 =?us-ascii?Q?+tZGTA0zgeNxEOOInnfAV0vB0xgVpj0puueOVet+fP1v4FZ7/Q3evMeurlRx?=
 =?us-ascii?Q?ov6/hygHfHDdMHaNPN7Jhnq071C7pIw1vbWYAA5Sa/J+ydairJ9wxxT4xcSb?=
 =?us-ascii?Q?Qlt05KGn+uk6ygeKYb72FkNaw6yfdyj5JHl+EFMFKckj8/2iKw7fjyB0Zf2S?=
 =?us-ascii?Q?LtbMS779VyaWkS6PLIV2CXkpBEPBGcJsxx2RKqpSADFMbZly4W1EwoBqVTkE?=
 =?us-ascii?Q?dCsSqIj0T7yKGjYshkR9op70dGqsLmlmuCJ6Sjlicu9m9JXfQyzx5cs4gDso?=
 =?us-ascii?Q?ZWKSOfCfXKRkTh8Vs8oGzrgXwQAMaJtiYyrdzZO48QplnMaxGcepI1q5xaYp?=
 =?us-ascii?Q?3m/kpmVyZYpQiMOGhkojkcfPO72GMho98NEI02W/KUFIYrKKT4XUTKVU8Jz0?=
 =?us-ascii?Q?A9HoLBK//9aKVpYu/ne6w6J68yyf4LYlm+ON+ULS2/zOOXSoBG1JUHIkGi2j?=
 =?us-ascii?Q?pYDJ8hweZF1SCKbYzxJhrhIQZTIjkGKJGGwhqi/9k2iYHcbd6jB9ExXWF41O?=
 =?us-ascii?Q?Nc/6ZCxiWgTZODPl4EH234ckV24P+naxR8727vrppryL57NSfUpLNb/bG9JJ?=
 =?us-ascii?Q?FjwcEgAxKXYtwtzjrkflfsmnPEOgItJOEiAbu8Eb6oAX0rWXRiX3tCy2WeT1?=
 =?us-ascii?Q?9CHUxtfh/nQ1RqsRSnzxysCNOm0s/qkbSnQgvQAOoFmYaEZrWfzXentU29lq?=
 =?us-ascii?Q?XmpLaAezacPtNxhPcn4DWYpfyoqpKciaFMaS/N+NyKVoS+C5G6/3USwCO3OV?=
 =?us-ascii?Q?AydGv84d3eGQ/NxTAyTHeABpykfeeORK0jGhbulFFka0XcmlLs1YobzR7VKh?=
 =?us-ascii?Q?MgbKzWwEGBcsOMGilfp82CFiXRT0AHX86yoU4X0MZpIDVYdaB5xABLT4jNHf?=
 =?us-ascii?Q?gwBDX8s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nNZhg/7xiSa1dDpAm4tO7y+lC/AbCSktbk452dKp/gAXRRBpnQbatLqSsY7/?=
 =?us-ascii?Q?cMGIsU3HD9y6RBwdFZE894JfPuI0sG4Uhh7noJs28M6SZ4To7HhfZOdFf4iF?=
 =?us-ascii?Q?lB0+v4qShxIPEEtcunV6Zge83aXeNdTM2482dxUkS8YSORWfDE5jxr5jvJwe?=
 =?us-ascii?Q?4Th6MZ2GLft+RGWE5P2Qq8seb5KHen1g/q/UlCweBgJdIiKgLJWRrim73/Hv?=
 =?us-ascii?Q?R/T5RSTCx/anrKBGVKYodXbgwHj60AZl8R7rLdUsPVILvA3TsB3W2NOKndcg?=
 =?us-ascii?Q?AzbZi7RtDwOGleWyIfXOfX4QB7PKsWmJBjF+srWEZX4/RH20/CSyLFt9zpmQ?=
 =?us-ascii?Q?tiyuj8uQadIEgfcp9GBAFVi7mcEU1ntgl35u8S6+ffM9ZwFQ+Xg4lVCeyBXK?=
 =?us-ascii?Q?XIVJSTMdGG1VD4U1dH9DBY2kR9i33iqlj4E+Mxp8Oumj9URijtoARlIKflvR?=
 =?us-ascii?Q?Vh3MgAKEPhiOy3dSXRlBdMxSZWn6D3U/QEXxh0Gy97a5XfMpXIKIsDYALPBT?=
 =?us-ascii?Q?AJCUoRRZb9Luv8AuRhkVqDYe7lrKZUQfrE6GVDZWkmlIj2vsNg9hs1pHJUDq?=
 =?us-ascii?Q?x3cEDwLHgeH1bFH606my1wqNbZ/kFgE+3ANTvFfcdxJQ3lzZs4Sl2Vp76dZi?=
 =?us-ascii?Q?GasCskUmHI6rtNPxY88fn17RTxQeSdJAz4AgePD729IrC1Srjmxq4W0eYxIJ?=
 =?us-ascii?Q?hei8GCDumhiSIX1nYrpQw5GCAnUYbS6C5kL1xvbJCdd8CPRNjaYzT6cdIVIa?=
 =?us-ascii?Q?6Vanlz4L/kBec5kCxJHNlBpKYLp/FGJUcW3wNPCk8GOiKxYUXpeNJyPLuDiC?=
 =?us-ascii?Q?j4nfWOboTg3XVySjlxq95wHXyODTZLfiFA4yiZ21TsMiF7fFYvnb2ep6Qh5o?=
 =?us-ascii?Q?3fjXBLYmz0q3bqi3D4hAZ9zxvzt3/JUIzo/Va190/ZoWvsyVsGKeNM/vzCJs?=
 =?us-ascii?Q?qYn1PtlcPdyNnsINBP58Z503Ug8Nl/E3qwpRb56aV3EoavcHevyKirG+Q0AE?=
 =?us-ascii?Q?ph6lkbZ10XLIKHe6BUwz8UrNS4GRQyiFDxlYDLV0U9lv7qFt60yV8/Cvvu6C?=
 =?us-ascii?Q?S7/LD51ljJAoUnQ3lwY/mDIsDaUECljMcKxBF3y+WMZDUbwHFr3JEN6MTIdw?=
 =?us-ascii?Q?35jCBo1Qctzo59VDpxb1DeVptP19njNgRmKqUhGaJA9DZZXGzMDRr2d6+UXf?=
 =?us-ascii?Q?2XnpWofm0uTTkl93WZF+9aHJPgHo3+3OIr27UCOclg8VxNTIC8anyz6iY1Hd?=
 =?us-ascii?Q?PynrRXM1z7kt7FlFog7fg0e5gxJ3PJnjxqCJ8tThXXhs8x5fXH/E3UF9Znzo?=
 =?us-ascii?Q?kkM0yODtfR+EUmwjfemBDto+PVQl1oOVoau/d3/wGKlUe5OGWgFXhsuHUyr/?=
 =?us-ascii?Q?OKBMLOcIoYawteD4909ytjhZm0TB/cv2X3CN/9q5aNIPrbXHdAmylU7T00dq?=
 =?us-ascii?Q?zSaZ3NRfNvF6MsQctAr2scd71gItuqQjejFDfG0kRJ4/eZ6LilI7/X7gpHb/?=
 =?us-ascii?Q?mX572Fb4J7OT82you/+/L+d4ClEjk2iLo3EJqltf7KWxS/yumOUsNDM2XElQ?=
 =?us-ascii?Q?pBU39cIwwObudJ3kALwB16+nMrAEyXbLvz5fjy8skoldLHmYKkYi4arjEZHJ?=
 =?us-ascii?Q?crMnfwHp/KYPSnZhpODm4gI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5102dbc1-7763-4604-fcf1-08dcfdfa7bcb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 00:32:24.1557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVYvZGgaUuvqEVe7q10ghgPSXh7cVRAj5tly+iIPgNxLoz144sRa+/BGePWdMN/F78egqrIugB478N9eA+m3RH8BsIEao8yi9Wx84BwG7/jCYEuQZEv5WAZuozPradKL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6655


Hi James,

On Mon, 4 Nov 2024, James Clark wrote:
> On 31/10/2024 9:35 pm, Ilkka Koskinen wrote:
>> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
>> 
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
>>   tools/perf/util/arm-spe.c                     | 65 +++++++++++++++++++
>>   2 files changed, 74 insertions(+)
>> 
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h 
>> b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> index 358c611eeddb..4bcd627e859f 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> @@ -67,6 +67,15 @@ enum arm_spe_common_data_source {
>>   	ARM_SPE_COMMON_DS_DRAM		= 0xe,
>>   };
>>   +enum arm_spe_ampereone_data_source {
>> +	ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE    = 0x0,
>> +	ARM_SPE_AMPEREONE_SLC                           = 0x3,
>> +	ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE             = 0x5,
>> +	ARM_SPE_AMPEREONE_DDR                           = 0x7,
>> +	ARM_SPE_AMPEREONE_L1D                           = 0x8,
>> +	ARM_SPE_AMPEREONE_L2D                           = 0x9,
>> +};
>> +
>>   struct arm_spe_record {
>>   	enum arm_spe_sample_type type;
>>   	int err;
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 9586416be30a..700d4bc8d8ec 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -103,6 +103,30 @@ struct arm_spe_queue {
>>   	u32				flags;
>>   };
>>   +struct arm_spe_source_mapping {
>> +	u16 source;
>> +	enum arm_spe_common_data_source common_src;
>> +};
>> +
>> +#define MAP_SOURCE(src, common)				\
>> +	{						\
>> +		.source = ARM_SPE_##src,		\
>> +		.common_src = ARM_SPE_COMMON_##common,  \
>> +	}
>> +
>> +static int arm_spe__map_to_common_source(u16 source,
>> +					 struct arm_spe_source_mapping *tbl,
>> +					 int nr_sources)
>> +{
>> +	while (nr_sources--) {
>> +		if (tbl->source == source)
>> +			return tbl->common_src;
>> +		tbl++;
>> +	}
>> +
>
> Hi Ilkka,
>
> I think a simple switch statement here would be easier to follow than the 
> loop, custom macro and then having the mappings in some other place:
>
> switch(source)
> case 0x0: /* AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE */
>  return DS_PEER_CORE;
>
> etc...
>
>> +	return -1;
>
> And the default case can return 0xfff directly, which avoids the if else 
> later only to convert this -1 back into 0xfff.

I can surely do that.


>
>> +}
>> +
>>   static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>>   			 unsigned char *buf, size_t len)
>>   {
>> @@ -443,6 +467,11 @@ static const struct midr_range 
>> common_ds_encoding_cpus[] = {
>>   	{},
>>   };
>>   +static const struct midr_range ampereone_ds_encoding_cpus[] = {
>> +	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>> +	{},
>> +};
>> +
>>   static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>>   {
>>   	const struct arm_spe_record *record = &speq->decoder->record;
>> @@ -532,6 +561,38 @@ static void arm_spe__synth_data_source_common(const 
>> struct arm_spe_record *recor
>>   	}
>>   }
>>   +static struct arm_spe_source_mapping ampereone_sources[] = {
>> +	MAP_SOURCE(AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE, DS_PEER_CORE),
>> +	MAP_SOURCE(AMPEREONE_SLC, DS_SYS_CACHE),
>> +	MAP_SOURCE(AMPEREONE_REMOTE_CHIP_CACHE, DS_REMOTE),
>> +	MAP_SOURCE(AMPEREONE_DDR, DS_DRAM),
>> +	MAP_SOURCE(AMPEREONE_L1D, DS_L1D),
>> +	MAP_SOURCE(AMPEREONE_L2D, DS_L2),
>> +};
>> +
>> +/*
>> + * Source is IMPDEF. Here we convert the source code used on AmpereOne 
>> cores
>> + * to the common (Neoverse, Cortex) to avoid duplicating the decoding 
>> code.
>> + */
>> +static void arm_spe__synth_data_source_ampereone(const struct 
>> arm_spe_record *record,
>> +						 union perf_mem_data_src 
>> *data_src)
>> +{
>> +	int common_src;
>> +	struct arm_spe_record common_record;
>> +
>> +	common_src = arm_spe__map_to_common_source(record->source,
>> +						   ampereone_sources,
>> + 
>> ARRAY_SIZE(ampereone_sources));
>> +	if (common_src < 0)
>> +		 /* Assign a bogus value that's not used for common coding */
>> +		common_record.source = 0xfff;
>> +	else
>> +		common_record.source = common_src;
>> +
>> +	common_record.op = record->op;
>> +	arm_spe__synth_data_source_common(&common_record, data_src);
>> +}
>> +
>>   static void arm_spe__synth_memory_level(const struct arm_spe_record 
>> *record,
>>   					union perf_mem_data_src *data_src)
>>   {
>> @@ -606,6 +667,8 @@ static u64 arm_spe__synth_data_source(struct 
>> arm_spe_queue *speq,
>>   	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
>>   	bool is_common = arm_spe__is_ds_encoding_supported(speq,
>>   						common_ds_encoding_cpus);
>> +	bool is_ampereone = arm_spe__is_ds_encoding_supported(speq,
>> +						ampereone_ds_encoding_cpus);
>
> I know this probably already works, but we don't really need is_common 
> is_ampere etc, it will only grow anyway. All we need is a list of midrs and 
> function pairs. That also avoids doing is_ampereone even after we already 
> know is_common == true.
>
> static const struct data_src[] = {
> ...
> 	DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2), common_ds),
> 	DS(MIDR_ALL_VERSIONS(MIDR_AMPERE1A), ampere_ds),
> 	{},
> ...
> };
>
> "arm_spe__is_ds_encoding_supported" then becomes a direct call to 
> "arm_spe__synth_ds" and we can drop the is_ampereone and is_common vars. Then 
> adding new ones doesn't require changing the function anymore.

To be honest, I'm not a big fan of the is_xyz() thing but I just didn't 
want to change it. Anyway, I'll change it for the next version.

Cheers, Ilkka


>
>>     	if (record->op & ARM_SPE_OP_LD)
>>   		data_src.mem_op = PERF_MEM_OP_LOAD;
>> @@ -616,6 +679,8 @@ static u64 arm_spe__synth_data_source(struct 
>> arm_spe_queue *speq,
>>     	if (is_common)
>>   		arm_spe__synth_data_source_common(record, &data_src);
>> +	else if (is_ampereone)
>> +		arm_spe__synth_data_source_ampereone(record, &data_src);
>>   	else
>>   		arm_spe__synth_memory_level(record, &data_src);
>> 
>
>
